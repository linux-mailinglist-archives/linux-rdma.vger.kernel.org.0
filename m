Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048053D6CB5
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhG0Cun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:43 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7433 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbhG0Cum (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:42 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYj0D5h0Sz80Dm;
        Tue, 27 Jul 2021 11:27:24 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:08 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:08 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v3 for-next 10/12] RDMA/hns: Sync DCA status by the shared memory
Date:   Tue, 27 Jul 2021 11:27:30 +0800
Message-ID: <1627356452-30564-11-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
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

Alloc a DCA num to indicate the DCA status position in the shared memory,
if the num is valid, the user DCA can get the DCA status by testing the
bit in the shared memory for each QP, otherwise the user DCA needs to
invoke the verbs 'HNS_IB_METHOD_DCA_MEM_ATTACH' to check the DCA status.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    | 81 +++++++++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_dca.h    |  2 +
 drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 11 ++++
 include/uapi/rdma/hns-abi.h                 |  5 ++
 5 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 2e7952c..7643cf5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -298,6 +298,39 @@ static int shrink_dca_mem(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+#define DCAN_TO_SYNC_BIT(n) ((n) * HNS_DCA_BITS_PER_STATUS)
+#define DCAN_TO_STAT_BIT(n) DCAN_TO_SYNC_BIT(n)
+static bool start_free_dca_buf(struct hns_roce_dca_ctx *ctx, u32 dcan)
+{
+	unsigned long *st = ctx->sync_status;
+
+	if (st && dcan < ctx->max_qps)
+		return !test_and_set_bit_lock(DCAN_TO_SYNC_BIT(dcan), st);
+
+	return true;
+}
+
+static void stop_free_dca_buf(struct hns_roce_dca_ctx *ctx, u32 dcan)
+{
+	unsigned long *st = ctx->sync_status;
+
+	if (st && dcan < ctx->max_qps)
+		clear_bit_unlock(DCAN_TO_SYNC_BIT(dcan), st);
+}
+
+static void update_dca_buf_status(struct hns_roce_dca_ctx *ctx, u32 dcan,
+				  bool en)
+{
+	unsigned long *st = ctx->buf_status;
+
+	if (st && dcan < ctx->max_qps) {
+		if (en)
+			set_bit(DCAN_TO_STAT_BIT(dcan), st);
+		else
+			clear_bit(DCAN_TO_STAT_BIT(dcan), st);
+	}
+}
+
 static void restart_aging_dca_mem(struct hns_roce_dev *hr_dev,
 				  struct hns_roce_dca_ctx *ctx)
 {
@@ -347,8 +380,12 @@ static void process_aging_dca_mem(struct hns_roce_dev *hr_dev,
 		hr_qp = container_of(cfg, struct hns_roce_qp, dca_cfg);
 		spin_unlock(&ctx->aging_lock);
 
-		if (hr_dev->hw->chk_dca_buf_inactive(hr_dev, hr_qp))
-			free_buf_from_dca_mem(ctx, cfg);
+		if (start_free_dca_buf(ctx, cfg->dcan)) {
+			if (hr_dev->hw->chk_dca_buf_inactive(hr_dev, hr_qp))
+				free_buf_from_dca_mem(ctx, cfg);
+
+			stop_free_dca_buf(ctx, cfg->dcan);
+		}
 
 		spin_lock(&ctx->aging_lock);
 
@@ -381,6 +418,8 @@ static void init_dca_context(struct hns_roce_dca_ctx *ctx)
 	INIT_LIST_HEAD(&ctx->pool);
 	spin_lock_init(&ctx->pool_lock);
 	ctx->total_size = 0;
+
+	ida_init(&ctx->ida);
 	INIT_LIST_HEAD(&ctx->aging_new_list);
 	INIT_LIST_HEAD(&ctx->aging_proc_list);
 	spin_lock_init(&ctx->aging_lock);
@@ -458,6 +497,8 @@ void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 				 ctx->status_npage * PAGE_SIZE);
 		ctx->buf_status = NULL;
 	}
+
+	ida_destroy(&ctx->ida);
 }
 
 static struct dca_mem *alloc_dca_mem(struct hns_roce_dca_ctx *ctx)
@@ -904,6 +945,7 @@ static int attach_dca_mem(struct hns_roce_dev *hr_dev,
 
 	resp->alloc_flags |= HNS_IB_ATTACH_FLAGS_NEW_BUFFER;
 	resp->alloc_pages = cfg->npages;
+	update_dca_buf_status(ctx, cfg->dcan, true);
 
 	return 0;
 }
@@ -1014,6 +1056,7 @@ static void free_buf_from_dca_mem(struct hns_roce_dca_ctx *ctx,
 	unsigned long flags;
 	u32 buf_id;
 
+	update_dca_buf_status(ctx, cfg->dcan, false);
 	spin_lock(&cfg->lock);
 	buf_id = cfg->buf_id;
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
@@ -1060,6 +1103,27 @@ static void kick_dca_buf(struct hns_roce_dev *hr_dev,
 	restart_aging_dca_mem(hr_dev, ctx);
 }
 
+static u32 alloc_dca_num(struct hns_roce_dca_ctx *ctx)
+{
+	int ret;
+
+	ret = ida_alloc_max(&ctx->ida, ctx->max_qps - 1, GFP_KERNEL);
+	if (ret < 0)
+		return HNS_DCA_INVALID_DCA_NUM;
+
+	stop_free_dca_buf(ctx, ret);
+	update_dca_buf_status(ctx, ret, false);
+	return ret;
+}
+
+static void free_dca_num(u32 dcan, struct hns_roce_dca_ctx *ctx)
+{
+	if (dcan == HNS_DCA_INVALID_DCA_NUM)
+		return;
+
+	ida_free(&ctx->ida, dcan);
+}
+
 void hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
@@ -1068,6 +1132,7 @@ void hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	INIT_LIST_HEAD(&cfg->aging_node);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
 	cfg->npages = hr_qp->buff_size >> HNS_HW_PAGE_SHIFT;
+	cfg->dcan = HNS_DCA_INVALID_DCA_NUM;
 	/* Support dynamic detach when rq is empty */
 	if (!hr_qp->rq.wqe_cnt)
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DYNAMIC_CTX_DETACH;
@@ -1083,6 +1148,9 @@ void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
 
 	kick_dca_buf(hr_dev, cfg, ctx);
 	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
+
+	free_dca_num(cfg->dcan, ctx);
+	cfg->dcan = HNS_DCA_INVALID_DCA_NUM;
 }
 
 void hns_roce_modify_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
@@ -1093,9 +1161,14 @@ void hns_roce_modify_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	struct hns_roce_dca_ctx *ctx = to_hr_dca_ctx(uctx);
 	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
 
-	if (hr_qp->state == IB_QPS_RESET || hr_qp->state == IB_QPS_ERR)
+	if (hr_qp->state == IB_QPS_RESET || hr_qp->state == IB_QPS_ERR) {
 		kick_dca_buf(hr_dev, cfg, ctx);
-
+		free_dca_num(cfg->dcan, ctx);
+		cfg->dcan = HNS_DCA_INVALID_DCA_NUM;
+	} else if (hr_qp->state == IB_QPS_RTR) {
+		free_dca_num(cfg->dcan, ctx);
+		cfg->dcan = alloc_dca_num(ctx);
+	}
 }
 
 static struct hns_roce_ucontext *
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index 1f59a62..0004ee4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -15,6 +15,8 @@ struct hns_dca_page_state {
 };
 
 #define HNS_DCA_INVALID_BUF_ID 0UL
+#define HNS_DCA_INVALID_DCA_NUM ~0U
+
 struct hns_dca_shrink_resp {
 	u64 free_key; /* free buffer's key which registered by the user */
 	u32 free_mems; /* free buffer count which no any QP be using */
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index ac53a44..bef418d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -234,6 +234,7 @@ struct hns_roce_dca_ctx {
 
 	unsigned int max_qps;
 	unsigned int status_npage;
+	struct ida ida;
 
 #define HNS_DCA_BITS_PER_STATUS 1
 	unsigned long *buf_status;
@@ -348,10 +349,11 @@ struct hns_roce_dca_cfg {
 	spinlock_t lock;
 	u32 buf_id;
 	u16 attach_count;
+	u32 dcan;
 	u32 npages;
 	u32 sq_idx;
-	bool			aging_enable;
-	struct list_head	aging_node;
+	bool aging_enable;
+	struct list_head aging_node;
 };
 
 struct hns_roce_mw {
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 0918c97..8476000 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1389,6 +1389,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct hns_roce_ib_modify_qp_resp resp = {};
 	enum ib_qp_state cur_state, new_state;
 	int ret;
 
@@ -1415,7 +1416,17 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 	ret = hr_dev->hw->modify_qp(ibqp, attr, attr_mask, cur_state,
 				    new_state, udata);
+	if (ret)
+		goto out;
 
+	if (udata && udata->outlen) {
+		resp.dcan = hr_qp->dca_cfg.dcan;
+		ret = ib_copy_to_udata(udata, &resp,
+				       min(udata->outlen, sizeof(resp)));
+		if (ret)
+			ibdev_err(&hr_dev->ib_dev,
+				  "failed to copy modify qp resp.\n");
+	}
 out:
 	mutex_unlock(&hr_qp->mutex);
 
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 476ea81..40ac2c3 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -117,6 +117,11 @@ enum {
 	HNS_ROCE_MMAP_DCA_PAGE,
 };
 
+struct hns_roce_ib_modify_qp_resp {
+	__u32	dcan;
+	__u32	reserved;
+};
+
 #define UVERBS_ID_NS_MASK 0xF000
 #define UVERBS_ID_NS_SHIFT 12
 
-- 
2.8.1

