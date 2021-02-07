Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9D31211D
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 04:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBGDQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Feb 2021 22:16:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11689 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhBGDP5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Feb 2021 22:15:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DYDkg0t9xzlH1C;
        Sun,  7 Feb 2021 11:13:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 11:15:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH RFC rdma-core 3/5] libhns: Add support for shrinking DCA memory pool
Date:   Sun, 7 Feb 2021 11:12:52 +0800
Message-ID: <1612667574-56673-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The QP's WQE buffer may be detached after QP is modified or CQE is polled,
and the state of DCA mem object may be changed as clean for no QP is using
it. So shrink the clean DCA mem from the memory pool and destroy the DCA
mem's buffer to reduce the memory consumption.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 providers/hns/hns_roce_u.h       |  2 +
 providers/hns/hns_roce_u_buf.c   | 96 ++++++++++++++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_hw_v2.c |  7 +++
 3 files changed, 105 insertions(+)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 619b060..7dc4a1e 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -149,6 +149,7 @@ struct hns_roce_dca_ctx {
 	struct list_head mem_list;
 	pthread_spinlock_t lock;
 	uint64_t max_size;
+	uint64_t min_size;
 	uint64_t curr_size;
 	int mem_cnt;
 	unsigned int unit_size;
@@ -410,6 +411,7 @@ void hns_roce_free_buf(struct hns_roce_buf *buf);
 
 void hns_roce_free_qp_buf(struct hns_roce_qp *qp, struct hns_roce_context *ctx);
 
+void hns_roce_shrink_dca_mem(struct hns_roce_context *ctx);
 void hns_roce_cleanup_dca_mem(struct hns_roce_context *ctx);
 int hns_roce_add_dca_mem(struct hns_roce_context *ctx, uint32_t size);
 
diff --git a/providers/hns/hns_roce_u_buf.c b/providers/hns/hns_roce_u_buf.c
index 424f916..8f3d34a 100644
--- a/providers/hns/hns_roce_u_buf.c
+++ b/providers/hns/hns_roce_u_buf.c
@@ -101,6 +101,20 @@ static inline uint64_t dca_mem_to_key(struct hns_roce_dca_mem *dca_mem)
 	return (uintptr_t)dca_mem;
 }
 
+static struct hns_roce_dca_mem *key_to_dca_mem(struct hns_roce_dca_ctx *ctx,
+					       uint64_t key)
+{
+	struct hns_roce_dca_mem *mem;
+	struct hns_roce_dca_mem *tmp;
+
+	list_for_each_safe(&ctx->mem_list, mem, tmp, entry) {
+		if (dca_mem_to_key(mem) == key)
+			return mem;
+	}
+
+	return NULL;
+}
+
 static inline void *dca_mem_addr(struct hns_roce_dca_mem *dca_mem, int offset)
 {
 	return dca_mem->buf.buf + offset;
@@ -144,6 +158,25 @@ void hns_roce_cleanup_dca_mem(struct hns_roce_context *ctx)
 		deregister_dca_mem(ctx, mem->handle);
 }
 
+struct hns_dca_mem_shrink_resp {
+	uint32_t free_mems;
+	uint64_t free_key;
+};
+
+static int shrink_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
+			  uint64_t size, struct hns_dca_mem_shrink_resp *resp)
+{
+	DECLARE_COMMAND_BUFFER(cmd, HNS_IB_OBJECT_DCA_MEM,
+			       HNS_IB_METHOD_DCA_MEM_SHRINK, 4);
+	fill_attr_in_obj(cmd, HNS_IB_ATTR_DCA_MEM_SHRINK_HANDLE, handle);
+	fill_attr_in_uint64(cmd, HNS_IB_ATTR_DCA_MEM_SHRINK_RESERVED_SIZE, size);
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_KEY,
+		      &resp->free_key, sizeof(resp->free_key));
+	fill_attr_out(cmd, HNS_IB_ATTR_DCA_MEM_SHRINK_OUT_FREE_MEMS,
+		      &resp->free_mems, sizeof(resp->free_mems));
+
+	return execute_ioctl(&ctx->ibv_ctx.context, cmd);
+}
 static bool add_dca_mem_enabled(struct hns_roce_dca_ctx *ctx,
 				uint32_t alloc_size)
 {
@@ -194,3 +227,66 @@ int hns_roce_add_dca_mem(struct hns_roce_context *ctx, uint32_t size)
 
 	return 0;
 }
+
+static bool shrink_dca_mem_enabled(struct hns_roce_dca_ctx *ctx)
+{
+	bool enable;
+
+	pthread_spin_lock(&ctx->lock);
+	enable = ctx->mem_cnt > 0 && ctx->min_size < ctx->max_size;
+	pthread_spin_unlock(&ctx->lock);
+
+	return enable;
+}
+
+void hns_roce_shrink_dca_mem(struct hns_roce_context *ctx)
+{
+	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
+	struct hns_dca_mem_shrink_resp resp = {};
+	struct hns_roce_dca_mem *mem;
+	int dca_mem_cnt;
+	uint32_t handle;
+	int ret;
+
+	pthread_spin_lock(&dca_ctx->lock);
+	dca_mem_cnt = ctx->dca_ctx.mem_cnt;
+	pthread_spin_unlock(&dca_ctx->lock);
+	while (dca_mem_cnt > 0 && shrink_dca_mem_enabled(dca_ctx)) {
+		resp.free_mems = 0;
+		/* Step 1: Use any DCA mem uobject to shrink pool */
+		pthread_spin_lock(&dca_ctx->lock);
+		mem = list_tail(&dca_ctx->mem_list,
+				struct hns_roce_dca_mem, entry);
+		handle = mem ? mem->handle : 0;
+		pthread_spin_unlock(&dca_ctx->lock);
+		if (!mem)
+			break;
+
+		ret = shrink_dca_mem(ctx, handle, dca_ctx->min_size, &resp);
+		if (ret || likely(resp.free_mems < 1))
+			break;
+
+		/* Step 2: Remove shrunk DCA mem node from pool */
+		pthread_spin_lock(&dca_ctx->lock);
+		mem = key_to_dca_mem(dca_ctx, resp.free_key);
+		if (mem) {
+			list_del(&mem->entry);
+			dca_ctx->mem_cnt--;
+			dca_ctx->curr_size -= mem->buf.length;
+		}
+
+		handle = mem ? mem->handle : 0;
+		pthread_spin_unlock(&dca_ctx->lock);
+		if (!mem)
+			break;
+
+		/* Step 3: Destroy DCA mem uobject */
+		deregister_dca_mem(ctx, handle);
+		free_dca_mem(ctx, mem);
+		/* No any free memory after deregister 1 DCA mem */
+		if (resp.free_mems <= 1)
+			break;
+
+		dca_mem_cnt--;
+	}
+}
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index c8d273f..93f3546 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -651,6 +651,10 @@ static int hns_roce_u_v2_poll_cq(struct ibv_cq *ibvcq, int ne,
 
 	pthread_spin_unlock(&cq->lock);
 
+	/* Try to shrink the DCA mem */
+	if (ctx->dca_ctx.mem_cnt > 0)
+		hns_roce_shrink_dca_mem(ctx);
+
 	return err == V2_CQ_POLL_ERR ? err : npolled;
 }
 
@@ -1478,6 +1482,9 @@ static int hns_roce_u_v2_destroy_qp(struct ibv_qp *ibqp)
 
 	free(qp);
 
+	if (ctx->dca_ctx.mem_cnt > 0)
+		hns_roce_shrink_dca_mem(ctx);
+
 	return ret;
 }
 
-- 
2.8.1

