Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8253641D597
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 10:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbhI3Inp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 04:43:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27945 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348518AbhI3Ino (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 04:43:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HKmpG3nl7zbmyq;
        Thu, 30 Sep 2021 16:37:42 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:41:57 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:41:56 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 2/2] libhns: Add a new mmap implementation
Date:   Thu, 30 Sep 2021 16:37:46 +0800
Message-ID: <20210930083746.19136-3-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930083746.19136-1-liangwenpeng@huawei.com>
References: <20210930083746.19136-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

The new implementation prepares for subsequent new features and is
compatible with the old implementation.

In the new mmap implementation, the user space driver use the offset sent
by kernel space driver to complete the mmap instead of a hard-coded offset.
And the old implementation using hard-coded offset will not be extended in
the future.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u.c     | 86 ++++++++++++++++++++++++----------
 providers/hns/hns_roce_u.h     |  1 +
 providers/hns/hns_roce_u_abi.h |  2 +-
 3 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 3b31ad37..2531b097 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -95,16 +95,66 @@ static const struct verbs_context_ops hns_common_ops = {
 	.get_srq_num = hns_roce_u_get_srq_num,
 };
 
+static int hns_roce_mmap(struct hns_roce_device *hr_dev,
+			 struct hns_roce_context *context, int cmd_fd,
+			 uint64_t db_mmap_key)
+{
+	context->uar = mmap(NULL, hr_dev->page_size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, cmd_fd, db_mmap_key);
+	if (context->uar == MAP_FAILED)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hns_roce_legacy_mmap(struct hns_roce_device *hr_dev,
+				struct hns_roce_context *context, int cmd_fd)
+{
+	off_t offset = 0;
+
+	context->uar = mmap(NULL, hr_dev->page_size, PROT_READ | PROT_WRITE,
+			    MAP_SHARED, cmd_fd, offset);
+	if (context->uar == MAP_FAILED)
+		return -EINVAL;
+
+	offset += hr_dev->page_size;
+
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
+	context->uar = NULL;
+	return -EINVAL;
+}
+
+static void ucontext_set_cmd(struct hns_roce_alloc_ucontext *cmd)
+{
+	cmd->comp = HNS_ROCE_ALLOC_UCTX_COMP_CONFIG;
+	cmd->config = HNS_ROCE_UCTX_REQ_MMAP_KEY_EN;
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
+	int ret;
 	int i;
 
 	context = verbs_init_and_alloc_context(ibdev, cmd_fd, context, ibv_ctx,
@@ -112,10 +162,14 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	if (!context)
 		return NULL;
 
-	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd, sizeof(cmd),
+	ucontext_set_cmd(&cmd);
+	if (ibv_cmd_get_context(&context->ibv_ctx, &cmd.ibv_cmd, sizeof(cmd),
 				&resp.ibv_resp, sizeof(resp)))
 		goto err_free;
 
+	context->mmap_key_support = !!(resp.config &
+				       HNS_ROCE_UCTX_RESP_MMAP_KEY_EN);
+
 	if (!resp.cqe_size)
 		context->cqe_size = HNS_ROCE_CQE_SIZE;
 	else if (resp.cqe_size <= HNS_ROCE_V3_CQE_SIZE)
@@ -153,26 +207,14 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	context->max_cqe = dev_attrs.max_cqe;
 	context->max_srq_wr = dev_attrs.max_srq_wr;
 	context->max_srq_sge = dev_attrs.max_srq_sge;
+	if (context->mmap_key_support)
+		ret = hns_roce_mmap(hr_dev, context, cmd_fd, resp.db_mmap_key);
+	else
+		ret = hns_roce_legacy_mmap(hr_dev, context, cmd_fd);
 
-	context->uar = mmap(NULL, hr_dev->page_size, PROT_READ | PROT_WRITE,
-			    MAP_SHARED, cmd_fd, offset);
-	if (context->uar == MAP_FAILED)
+	if (ret)
 		goto err_free;
 
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
@@ -180,10 +222,6 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 
 	return &context->ibv_ctx;
 
-db_free:
-	munmap(context->uar, hr_dev->page_size);
-	context->uar = NULL;
-
 err_free:
 	verbs_uninit_context(&context->ibv_ctx);
 	free(context);
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 0d7abd81..126c9d3c 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -180,6 +180,7 @@ struct hns_roce_context {
 	unsigned int			max_srq_sge;
 	int				max_cqe;
 	unsigned int			cqe_size;
+	bool				mmap_key_support;
 };
 
 struct hns_roce_pd {
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index e56f9d35..295808b1 100644
--- a/providers/hns/hns_roce_u_abi.h
+++ b/providers/hns/hns_roce_u_abi.h
@@ -42,7 +42,7 @@ DECLARE_DRV_CMD(hns_roce_alloc_pd, IB_USER_VERBS_CMD_ALLOC_PD,
 DECLARE_DRV_CMD(hns_roce_create_cq, IB_USER_VERBS_CMD_CREATE_CQ,
 		hns_roce_ib_create_cq, hns_roce_ib_create_cq_resp);
 DECLARE_DRV_CMD(hns_roce_alloc_ucontext, IB_USER_VERBS_CMD_GET_CONTEXT,
-		empty, hns_roce_ib_alloc_ucontext_resp);
+		hns_roce_ib_alloc_ucontext, hns_roce_ib_alloc_ucontext_resp);
 
 DECLARE_DRV_CMD(hns_roce_create_qp, IB_USER_VERBS_CMD_CREATE_QP,
 		hns_roce_ib_create_qp, hns_roce_ib_create_qp_resp);
-- 
2.33.0

