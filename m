Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31083D7065
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhG0Hb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 03:31:59 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12268 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbhG0Hb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 03:31:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GYpHZ2XY7z1CNtG;
        Tue, 27 Jul 2021 15:26:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:56 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:56 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 05/10] libhns: Use shared memory to sync DCA status
Date:   Tue, 27 Jul 2021 15:28:16 +0800
Message-ID: <1627370901-10054-6-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
References: <1627370901-10054-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The user DCA needs to check the QP attaching state before filling wqe
buffer by the response from uverbs 'HNS_IB_METHOD_DCA_MEM_ATTACH', but
this will result in too much time being wasted on system calls, so use a
shared table between user driver and kernel driver to sync DCA status.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u.c     | 135 +++++++++++++++++++++++++++++++----------
 providers/hns/hns_roce_u.h     |  11 ++++
 providers/hns/hns_roce_u_abi.h |   3 +-
 3 files changed, 116 insertions(+), 33 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index a4e0997..3b13d0f 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -95,7 +95,46 @@ static const struct verbs_context_ops hns_common_ops = {
 	.get_srq_num = hns_roce_u_get_srq_num,
 };
 
-static int init_dca_context(struct hns_roce_context *ctx, int page_size)
+/* command value is offset[15:8] */
+static void hns_roce_mmap_set_command(int command, off_t *offset)
+{
+	*offset |= (command & 0xff) << 8;
+}
+
+/* index value is offset[63:16] | offset[7:0] */
+static void hns_roce_mmap_set_index(unsigned long index, off_t *offset)
+{
+	*offset |= (index & 0xff) | ((index >> 8) << 16);
+}
+
+static off_t get_uar_mmap_offset(unsigned long idx, int page_size, int cmd)
+{
+	off_t offset = 0;
+
+	hns_roce_mmap_set_command(cmd, &offset);
+	hns_roce_mmap_set_index(idx, &offset);
+
+	return offset * page_size;
+}
+
+static int mmap_dca(struct hns_roce_dca_ctx *dca_ctx, int cmd_fd, int page_size,
+		    size_t size)
+{
+	void *addr;
+
+	addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, cmd_fd,
+		    get_uar_mmap_offset(0, page_size, HNS_ROCE_MMAP_DCA_PAGE));
+	if (addr == MAP_FAILED)
+		return -EINVAL;
+
+	dca_ctx->buf_status = addr;
+	dca_ctx->sync_status = addr + size / 2;
+
+	return 0;
+}
+
+static int init_dca_context(struct hns_roce_context *ctx, int cmd_fd,
+			    int page_size, int max_qps, int mmap_size)
 {
 	struct hns_roce_dca_ctx *dca_ctx = &ctx->dca_ctx;
 	int ret;
@@ -112,6 +151,16 @@ static int init_dca_context(struct hns_roce_context *ctx, int page_size)
 	dca_ctx->max_size = HNS_DCA_MAX_MEM_SIZE;
 	dca_ctx->mem_cnt = 0;
 
+	if (mmap_size > 0) {
+		const unsigned int bits_per_qp = 2 * HNS_DCA_BITS_PER_STATUS;
+
+		if (!mmap_dca(dca_ctx, cmd_fd, page_size, mmap_size)) {
+			dca_ctx->status_size = mmap_size;
+			dca_ctx->max_qps = min_t(int, max_qps,
+						 mmap_size *  8 / bits_per_qp);
+		}
+	}
+
 	return 0;
 }
 
@@ -126,19 +175,60 @@ static void uninit_dca_context(struct hns_roce_context *ctx)
 	hns_roce_cleanup_dca_mem(ctx);
 	pthread_spin_unlock(&dca_ctx->lock);
 
+	if (dca_ctx->buf_status)
+		munmap(dca_ctx->buf_status, dca_ctx->status_size);
+
 	pthread_spin_destroy(&dca_ctx->lock);
 }
 
+static int hns_roce_mmap(struct hns_roce_device *hr_dev,
+			 struct hns_roce_context *context, int cmd_fd)
+{
+	int page_size = hr_dev->page_size;
+	off_t offset;
+
+	offset = get_uar_mmap_offset(0, page_size, HNS_ROCE_MMAP_REGULAR_PAGE);
+	context->uar = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, cmd_fd, offset);
+	if (context->uar == MAP_FAILED)
+		return -EINVAL;
+
+	offset = get_uar_mmap_offset(1, page_size, HNS_ROCE_MMAP_REGULAR_PAGE);
+	if (hr_dev->hw_version == HNS_ROCE_HW_VER1) {
+		/*
+		 * when vma->vm_pgoff is 1, the cq_tptr_base includes 64K CQ,
+		 * a pointer of CQ need 2B size
+		 */
+		context->cq_tptr_base = mmap(NULL, HNS_ROCE_CQ_DB_BUF_SIZE,
+					     PROT_READ | PROT_WRITE, MAP_SHARED,
+					     cmd_fd, offset);
+		if (context->cq_tptr_base == MAP_FAILED)
+			goto db_free;
+	}
+
+	return 0;
+
+db_free:
+	munmap(context->uar, hr_dev->page_size);
+
+	return -EINVAL;
+}
+
+static void ucontext_set_cmd(struct hns_roce_alloc_ucontext *cmd, int page_size)
+{
+	cmd->comp = HNS_ROCE_ALLOC_UCTX_COMP_DCA_MAX_QPS;
+	cmd->dca_max_qps = page_size * 8 / 2 * HNS_DCA_BITS_PER_STATUS;
+}
+
 static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 						    int cmd_fd,
 						    void *private_data)
 {
 	struct hns_roce_device *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_alloc_ucontext_resp resp = {};
+	struct hns_roce_alloc_ucontext cmd = {};
 	struct ibv_device_attr dev_attrs;
 	struct hns_roce_context *context;
-	struct ibv_get_context cmd;
-	int offset = 0;
 	int i;
 
 	context = verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
@@ -146,7 +236,8 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	if (!context)
 		return NULL;
 
-	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd, sizeof(cmd),
+	ucontext_set_cmd(&cmd, hr_dev->page_size);
+	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd.ibv_cmd, sizeof(cmd),
 				&resp.ibv_resp, sizeof(resp)))
 		goto err_free;
 
@@ -190,42 +281,22 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	context->max_srq_wr = dev_attrs.max_srq_wr;
 	context->max_srq_sge = dev_attrs.max_srq_sge;
 
-	context->uar = mmap(NULL, hr_dev->page_size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, cmd_fd, offset);
-	if (context->uar == MAP_FAILED)
-		goto err_free;
-
-	offset += hr_dev->page_size;
-
-	if (hr_dev->hw_version == HNS_ROCE_HW_VER1) {
-		/*
-		 * when vma->vm_pgoff is 1, the cq_tptr_base includes 64K CQ,
-		 * a pointer of CQ need 2B size
-		 */
-		context->cq_tptr_base = mmap(NULL, HNS_ROCE_CQ_DB_BUF_SIZE,
-					     PROT_READ | PROT_WRITE, MAP_SHARED,
-					     cmd_fd, offset);
-		if (context->cq_tptr_base == MAP_FAILED)
-			goto db_free;
-	}
-
 	pthread_spin_init(&context->uar_lock, PTHREAD_PROCESS_PRIVATE);
 
 	verbs_set_ops(&context->ibv_ctx, &hns_common_ops);
 	verbs_set_ops(&context->ibv_ctx, &hr_dev->u_hw->hw_ops);
 
-	if (init_dca_context(context, hr_dev->page_size))
-		goto tptr_free;
+	if (init_dca_context(context, cmd_fd, hr_dev->page_size, resp.dca_qps,
+			     resp.dca_mmap_size))
+		goto err_free;
 
-	return &context->ibv_ctx;
+	if (hns_roce_mmap(hr_dev, context, cmd_fd))
+		goto dca_free;
 
-tptr_free:
-	if (hr_dev->hw_version == HNS_ROCE_HW_VER1)
-		munmap(context->cq_tptr_base, HNS_ROCE_CQ_DB_BUF_SIZE);
+	return &context->ibv_ctx;
 
-db_free:
-	munmap(context->uar, hr_dev->page_size);
-	context->uar = NULL;
+dca_free:
+	uninit_dca_context(context);
 
 err_free:
 	verbs_uninit_context(&context->ibv_ctx);
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 08e60b7..95e8046 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -35,6 +35,7 @@
 
 #include <stddef.h>
 #include <endian.h>
+#include <stdatomic.h>
 #include <util/compiler.h>
 
 #include <infiniband/driver.h>
@@ -44,6 +45,8 @@
 #include <ccan/array_size.h>
 #include <ccan/bitmap.h>
 #include <ccan/container_of.h>
+#include <ccan/minmax.h>
+
 #include <linux/if_ether.h>
 #include "hns_roce_u_abi.h"
 
@@ -54,6 +57,8 @@
 
 #define PFX				"hns: "
 
+typedef _Atomic(uint64_t) atomic_bitmap_t;
+
 /* The minimum page size is 4K for hardware */
 #define HNS_HW_PAGE_SHIFT 12
 #define HNS_HW_PAGE_SIZE (1 << HNS_HW_PAGE_SHIFT)
@@ -157,6 +162,12 @@ struct hns_roce_dca_ctx {
 	uint64_t max_size;
 	uint64_t min_size;
 	uint64_t curr_size;
+
+#define HNS_DCA_BITS_PER_STATUS 1
+	unsigned int max_qps;
+	unsigned int status_size;
+	atomic_bitmap_t *buf_status;
+	atomic_bitmap_t *sync_status;
 };
 
 struct hns_roce_context {
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index e56f9d3..23509c1 100644
--- a/providers/hns/hns_roce_u_abi.h
+++ b/providers/hns/hns_roce_u_abi.h
@@ -39,10 +39,11 @@
 
 DECLARE_DRV_CMD(hns_roce_alloc_pd, IB_USER_VERBS_CMD_ALLOC_PD,
 		empty, hns_roce_ib_alloc_pd_resp);
+
 DECLARE_DRV_CMD(hns_roce_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		hns_roce_ib_create_cq, hns_roce_ib_create_cq_resp);
 DECLARE_DRV_CMD(hns_roce_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEXT,
-		empty, hns_roce_ib_alloc_ucontext_resp);
+		hns_roce_ib_alloc_ucontext, hns_roce_ib_alloc_ucontext_resp);
 
 DECLARE_DRV_CMD(hns_roce_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
 		hns_roce_ib_create_qp, hns_roce_ib_create_qp_resp);
-- 
2.8.1

