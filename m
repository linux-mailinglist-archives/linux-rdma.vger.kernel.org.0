Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F772378EE4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbhEJNYn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:24:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2611 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352240AbhEJNOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 09:14:22 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ff1cL2631zQlnq;
        Mon, 10 May 2021 21:09:54 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 21:13:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 2/6] libhns: Introduce DCA for RC QP
Date:   Mon, 10 May 2021 21:13:00 +0800
Message-ID: <1620652384-34097-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
References: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The HIP09 introduces the DCA(Dynamic context attachment) feature which
supports many RC QPs to share the WQE buffer in a memory pool, this will
reduce the memory consumption when there are too many QPs inactive.

This patch wraps two functions for adding buffers to memory pool and
removing buffers from memory pool by calling ib cmd implemented in hns
kernel driver.

If a QP enables DCA feature, the WQE's buffer will be attached to the
memory pool when the users start to post WRs and be detached when all CQEs
has been polled.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.c     |  45 ++++++++++++++
 providers/hns/hns_roce_u.h     |  18 ++++++
 providers/hns/hns_roce_u_buf.c | 137 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 200 insertions(+)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 3b31ad3..a4e0997 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -95,6 +95,40 @@ static const struct verbs_context_ops hns_common_ops = {
 	.get_srq_num = hns_roce_u_get_srq_num,
 };
 
+static int init_dca_context(struct hns_roce_context *ctx, int page_size)
+{
+	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+	int ret;
+
+	if (!(ctx->cap_flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
+		return 0;
+
+	list_head_init(&dca_ctx->mem_list);
+	ret = pthread_spin_init(&dca_ctx->lock, PTHREAD_PROCESS_PRIVATE);
+	if (ret)
+		return ret;
+
+	dca_ctx->unit_size = page_size * HNS_DCA_DEFAULT_UNIT_PAGES;
+	dca_ctx->max_size = HNS_DCA_MAX_MEM_SIZE;
+	dca_ctx->mem_cnt = 0;
+
+	return 0;
+}
+
+static void uninit_dca_context(struct hns_roce_context *ctx)
+{
+	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+
+	if (!(ctx->cap_flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
+		return;
+
+	pthread_spin_lock(&dca_ctx->lock);
+	hns_roce_cleanup_dca_mem(ctx);
+	pthread_spin_unlock(&dca_ctx->lock);
+
+	pthread_spin_destroy(&dca_ctx->lock);
+}
+
 static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 						    int cmd_fd,
 						    void *private_data)
@@ -123,6 +157,8 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	else
 		context->cqe_size = HNS_ROCE_V3_CQE_SIZE;
 
+	context->cap_flags = resp.cap_flags;
+
 	context->num_qps = resp.qp_tab_size;
 	context->num_srqs = resp.srq_tab_size;
 
@@ -178,8 +214,15 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
 
+	if (init_dca_context(context, hr_dev->page_size))
+		goto tptr_free;
+
 	return &context->ibv_ctx;
 
+tptr_free:
+	if (hr_dev->hw_version == HNS_ROCE_HW_VER1)
+		munmap(context->cq_tptr_base, HNS_ROCE_CQ_DB_BUF_SIZE);
+
 db_free:
 	munmap(context->uar, hr_dev->page_size);
 	context->uar = NULL;
@@ -199,6 +242,8 @@ static void hns_roce_free_context(struct ibv_context *ibctx)
 	if (hr_dev->hw_version == HNS_ROCE_HW_VER1)
 		munmap(context->cq_tptr_base, HNS_ROCE_CQ_DB_BUF_SIZE);
 
+	uninit_dca_context(context);
+
 	verbs_uninit_context(&context->ibv_ctx);
 	free(context);
 }
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 8f805dd..d26ef9c 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -145,8 +145,21 @@ struct hns_roce_db_page {
 	bitmap			*bitmap;
 };
 
+#define HNS_DCA_MAX_MEM_SIZE ~0UL
+#define HNS_DCA_DEFAULT_UNIT_PAGES 16
+
+struct hns_roce_dca_ctx {
+	struct list_head mem_list;
+	pthread_spinlock_t lock;
+	uint64_t max_size;
+	uint64_t curr_size;
+	int mem_cnt;
+	unsigned int unit_size;
+};
+
 struct hns_roce_context {
 	struct verbs_context		ibv_ctx;
+	uint32_t			cap_flags;
 	void				*uar;
 	pthread_spinlock_t		uar_lock;
 
@@ -179,6 +192,8 @@ struct hns_roce_context {
 	unsigned int			max_srq_sge;
 	int				max_cqe;
 	unsigned int			cqe_size;
+
+	struct hns_roce_dca_ctx		dca_ctx;
 };
 
 struct hns_roce_pd {
@@ -424,6 +439,9 @@ void hns_roce_free_buf(struct hns_roce_buf *buf);
 
 void hns_roce_free_qp_buf(struct hns_roce_qp *qp, struct hns_roce_context *ctx);
 
+void hns_roce_cleanup_dca_mem(struct hns_roce_context *ctx);
+int hns_roce_add_dca_mem(struct hns_roce_context *ctx, uint32_t size);
+
 void hns_roce_init_qp_indices(struct hns_roce_qp *qp);
 
 extern const struct hns_roce_u_hw hns_roce_u_hw_v1;
diff --git a/providers/hns/hns_roce_u_buf.c b/providers/hns/hns_roce_u_buf.c
index 471dd9c..82a8849 100644
--- a/providers/hns/hns_roce_u_buf.c
+++ b/providers/hns/hns_roce_u_buf.c
@@ -60,3 +60,140 @@ void hns_roce_free_buf(struct hns_roce_buf *buf)
 
 	munmap(buf->buf, buf->length);
 }
+
+struct hns_roce_dca_mem {
+	uint32_t handle;
+	struct list_node entry;
+	struct hns_roce_buf buf;
+	struct hns_roce_context *ctx;
+};
+
+static void free_dca_mem(struct hns_roce_context *ctx,
+			 struct hns_roce_dca_mem *mem)
+{
+	hns_roce_free_buf(&mem->buf);
+	free(mem);
+}
+
+static struct hns_roce_dca_mem *alloc_dca_mem(uint32_t size)
+{
+	struct hns_roce_dca_mem *mem = NULL;
+	int ret;
+
+	mem = malloc(sizeof(struct hns_roce_dca_mem));
+	if (!mem) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	ret = hns_roce_alloc_buf(&mem->buf, size, HNS_HW_PAGE_SIZE);
+	if (ret) {
+		errno = ENOMEM;
+		free(mem);
+		return NULL;
+	}
+
+	return mem;
+}
+
+static inline uint64_t dca_mem_to_key(struct hns_roce_dca_mem *dca_mem)
+{
+	return (uintptr_t)dca_mem;
+}
+
+static inline void *dca_mem_addr(struct hns_roce_dca_mem *dca_mem, int offset)
+{
+	return dca_mem->buf.buf + offset;
+}
+
+static int register_dca_mem(struct hns_roce_context *ctx, uint64_t key,
+			    void *addr, uint32_t size, uint32_t *handle)
+{
+	struct ib_uverbs_attr *attr;
+	int ret;
+
+	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
+			       HNS_IB_METHOD_DCA_MEM_REG, 4);
+	fill_attr_in_uint32(cmd, HNS_IB_ATTR_DCA_MEM_REG_LEN, size);
+	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_REG_ADDR,
+			    ioctl_ptr_to_u64(addr));
+	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_REG_KEY, key);
+	attr = fill_attr_out_obj(cmd, HNS_IB_ATTR_DCA_MEM_REG_HANDLE);
+
+	ret = execute_ioctl(&ctx->ibv_ctx.context, cmd);
+	if (ret)
+		return ret;
+
+	*handle = read_attr_obj(HNS_IB_ATTR_DCA_MEM_REG_HANDLE, attr);
+
+	return ret;
+}
+
+static void deregister_dca_mem(struct hns_roce_context *ctx, uint32_t handle)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
+			       HNS_IB_METHOD_DCA_MEM_DEREG, 1);
+	fill_attr_in_obj(cmd, HNS_IB_ATTR_DCA_MEM_DEREG_HANDLE, handle);
+	execute_ioctl(&ctx->ibv_ctx.context, cmd);
+}
+
+void hns_roce_cleanup_dca_mem(struct hns_roce_context *ctx)
+{
+	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+	struct hns_roce_dca_mem *mem;
+	struct hns_roce_dca_mem *tmp;
+
+	list_for_each_safe(&dca_ctx->mem_list, mem, tmp, entry)
+		deregister_dca_mem(ctx, mem->handle);
+}
+
+static bool add_dca_mem_enabled(struct hns_roce_dca_ctx *ctx,
+				uint32_t alloc_size)
+{
+	bool enable;
+
+	pthread_spin_lock(&ctx->lock);
+
+	if (ctx->unit_size == 0) /* Pool size can't be increased */
+		enable = false;
+	else if (ctx->max_size == HNS_DCA_MAX_MEM_SIZE) /* Pool size no limit */
+		enable = true;
+	else /* Pool size doesn't exceed max size */
+		enable = (ctx->curr_size + alloc_size) < ctx->max_size;
+
+	pthread_spin_unlock(&ctx->lock);
+
+	return enable;
+}
+
+int hns_roce_add_dca_mem(struct hns_roce_context *ctx, uint32_t size)
+{
+	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+	struct hns_roce_dca_mem *mem;
+	int ret;
+
+	if (!add_dca_mem_enabled(&ctx->dca_ctx, size))
+		return -ENOMEM;
+
+	/* Step 1: Alloc DCA mem address */
+	mem = alloc_dca_mem(DIV_ROUND_UP(size, dca_ctx->unit_size));
+	if (!mem)
+		return -ENOMEM;
+
+	/* Step 2: Register DCA mem uobject to pin user address */
+	ret = register_dca_mem(ctx, dca_mem_to_key(mem), dca_mem_addr(mem, 0),
+			       mem->buf.length, &mem->handle);
+	if (ret) {
+		free_dca_mem(ctx, mem);
+		return ret;
+	}
+
+	/* Step 3: Add DCA mem node to pool */
+	pthread_spin_lock(&dca_ctx->lock);
+	list_add_tail(&dca_ctx->mem_list, &mem->entry);
+	dca_ctx->mem_cnt++;
+	dca_ctx->curr_size += mem->buf.length;
+	pthread_spin_unlock(&dca_ctx->lock);
+
+	return 0;
+}
-- 
2.7.4

