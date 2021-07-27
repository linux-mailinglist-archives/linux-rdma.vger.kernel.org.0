Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177503D7067
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhG0HcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 03:32:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12314 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhG0Hb6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Jul 2021 03:31:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GYpJy4tgbz7ydv;
        Tue, 27 Jul 2021 15:27:14 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:56 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 15:31:56 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 rdma-core 06/10] libhns: Sync DCA status by shared memory
Date:   Tue, 27 Jul 2021 15:28:17 +0800
Message-ID: <1627370901-10054-7-git-send-email-liangwenpeng@huawei.com>
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

Use DCA num from the resp of modify_qp() and indicate the DCA status bit in
the shared memory, if the num is valid, the user DCA can get the DCA status
by testing the bit in the shared memory for each QP, othewise invoke the
verbs 'HNS_IB_METHOD_DCA_MEM_ATTACH' to check the DCA status.

Each QP has 2 bits in shared memory, 1 bit is used to lock the DCA status
changing by kernel driver or user driver, another bit is used to indicate
the DCA attaching status.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 providers/hns/hns_roce_u.h       | 31 +++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_abi.h   |  3 +++
 providers/hns/hns_roce_u_buf.c   | 42 ++++++++++++++++++++++++++++++++++++++++
 providers/hns/hns_roce_u_hw_v2.c | 28 +++++++++++++++++++++++----
 4 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 95e8046..fb7b864 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -298,6 +298,7 @@ struct hns_roce_dca_buf {
 	void **bufs;
 	unsigned int max_cnt;
 	unsigned int shift;
+	unsigned int dcan;
 };
 
 struct hns_roce_qp {
@@ -349,6 +350,7 @@ struct hns_roce_dca_attach_attr {
 	uint32_t sq_offset;
 	uint32_t sge_offset;
 	uint32_t rq_offset;
+	bool force;
 };
 
 struct hns_roce_dca_detach_attr {
@@ -402,6 +404,32 @@ static inline struct hns_roce_ah *to_hr_ah(struct ibv_ah *ibv_ah)
 	return container_of(ibv_ah, struct hns_roce_ah, ibv_ah);
 }
 
+#define HNS_ROCE_BIT_MASK(nr) (1UL << ((nr) % 64))
+#define HNS_ROCE_BIT_WORD(nr) ((nr) / 64)
+
+static inline bool atomic_test_bit(atomic_bitmap_t *p, uint32_t nr)
+{
+	p += HNS_ROCE_BIT_WORD(nr);
+	return !!(atomic_load(p) & HNS_ROCE_BIT_MASK(nr));
+}
+
+static inline bool test_and_set_bit_lock(atomic_bitmap_t *p, uint32_t nr)
+{
+	uint64_t mask = HNS_ROCE_BIT_MASK(nr);
+
+	p += HNS_ROCE_BIT_WORD(nr);
+	if (atomic_load(p) & mask)
+		return true;
+
+	return (atomic_fetch_or(p, mask) & mask) != 0;
+}
+
+static inline void clear_bit_unlock(atomic_bitmap_t *p, uint32_t nr)
+{
+	p += HNS_ROCE_BIT_WORD(nr);
+	atomic_fetch_and(p, ~HNS_ROCE_BIT_MASK(nr));
+}
+
 int hns_roce_u_query_device(struct ibv_context *context,
 			    const struct ibv_query_device_ex_input *input,
 			    struct ibv_device_attr_ex *attr, size_t attr_size);
@@ -474,6 +502,9 @@ int hns_roce_attach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
 			    uint32_t size, struct hns_roce_dca_buf *buf);
 void hns_roce_detach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
 			     struct hns_roce_dca_detach_attr *attr);
+bool hns_roce_dca_start_post(struct hns_roce_dca_ctx *ctx, uint32_t dcan);
+void hns_roce_dca_stop_post(struct hns_roce_dca_ctx *ctx, uint32_t dcan);
+
 void hns_roce_shrink_dca_mem(struct hns_roce_context *ctx);
 void hns_roce_cleanup_dca_mem(struct hns_roce_context *ctx);
 
diff --git a/providers/hns/hns_roce_u_abi.h b/providers/hns/hns_roce_u_abi.h
index 23509c1..3a9aacf 100644
--- a/providers/hns/hns_roce_u_abi.h
+++ b/providers/hns/hns_roce_u_abi.h
@@ -57,4 +57,7 @@ DECLARE_DRV_CMD(hns_roce_create_srq, IB_USER_VERBS_CMD_CREATE_SRQ,
 DECLARE_DRV_CMD(hns_roce_create_srq_ex, IB_USER_VERBS_CMD_CREATE_XSRQ,
 		hns_roce_ib_create_srq, hns_roce_ib_create_srq_resp);
 
+DECLARE_DRV_CMD(hns_roce_modify_qp_ex, IB_USER_VERBS_EX_CMD_MODIFY_QP,
+		empty, hns_roce_ib_modify_qp_resp);
+
 #endif /* _HNS_ROCE_U_ABI_H */
diff --git a/providers/hns/hns_roce_u_buf.c b/providers/hns/hns_roce_u_buf.c
index 8142fcd..9a26aff 100644
--- a/providers/hns/hns_roce_u_buf.c
+++ b/providers/hns/hns_roce_u_buf.c
@@ -402,6 +402,45 @@ static int setup_dca_buf(struct hns_roce_context *ctx, uint32_t handle,
 	return (idx >= page_count) ? 0 : -ENOMEM;
 }
 
+#define DCAN_TO_SYNC_BIT(n) ((n) * HNS_DCA_BITS_PER_STATUS)
+#define DCAN_TO_STAT_BIT(n) DCAN_TO_SYNC_BIT(n)
+
+#define MAX_DCA_TRY_LOCK_TIMES 10
+bool hns_roce_dca_start_post(struct hns_roce_dca_ctx *ctx, uint32_t dcan)
+{
+	atomic_bitmap_t *st = ctx->sync_status;
+	int try_times = 0;
+
+	if (!st || dcan >= ctx->max_qps)
+		return true;
+
+	while (test_and_set_bit_lock(st, DCAN_TO_SYNC_BIT(dcan)))
+		if (try_times++ > MAX_DCA_TRY_LOCK_TIMES)
+			return false;
+
+	return true;
+}
+
+void hns_roce_dca_stop_post(struct hns_roce_dca_ctx *ctx, uint32_t dcan)
+{
+	atomic_bitmap_t *st = ctx->sync_status;
+
+	if (!st || dcan >= ctx->max_qps)
+		return;
+
+	clear_bit_unlock(st, DCAN_TO_SYNC_BIT(dcan));
+}
+
+static bool check_dca_is_attached(struct hns_roce_dca_ctx *ctx, uint32_t dcan)
+{
+	atomic_bitmap_t *st = ctx->buf_status;
+
+	if (!st || dcan >= ctx->max_qps)
+		return false;
+
+	return atomic_test_bit(st, DCAN_TO_STAT_BIT(dcan));
+}
+
 #define DCA_EXPAND_MEM_TRY_TIMES	3
 int hns_roce_attach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
 			    struct hns_roce_dca_attach_attr *attr,
@@ -413,6 +452,9 @@ int hns_roce_attach_dca_mem(struct hns_roce_context *ctx, uint32_t handle,
 	int try_times = 0;
 	int ret = 0;
 
+	if (!attr->force && check_dca_is_attached(&ctx->dca_ctx, buf->dcan))
+		return 0;
+
 	do {
 		resp.alloc_pages = 0;
 		ret = attach_dca_mem(ctx, handle, attr, &resp);
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index dff0e42..8989a08 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -533,6 +533,7 @@ static int dca_attach_qp_buf(struct hns_roce_context *ctx,
 			     struct hns_roce_qp *qp)
 {
 	struct hns_roce_dca_attach_attr attr = {};
+	bool enable_detach;
 	uint32_t idx;
 	int ret;
 
@@ -554,9 +555,16 @@ static int dca_attach_qp_buf(struct hns_roce_context *ctx,
 		attr.rq_offset = idx << qp->rq.wqe_shift;
 	}
 
+	enable_detach = check_dca_detach_enable(qp);
+	if (enable_detach &&
+	    !hns_roce_dca_start_post(&ctx->dca_ctx, qp->dca_wqe.dcan))
+		/* Force attach if failed to sync dca status */
+		attr.force = true;
 
 	ret = hns_roce_attach_dca_mem(ctx, qp->verbs_qp.qp.handle, &attr,
-								  qp->buf_size, &qp->dca_wqe);
+				      qp->buf_size, &qp->dca_wqe);
+	if (ret && enable_detach)
+		hns_roce_dca_stop_post(&ctx->dca_ctx, qp->dca_wqe.dcan);
 
 	pthread_spin_unlock(&qp->rq.lock);
 	pthread_spin_unlock(&qp->sq.lock);
@@ -1368,6 +1376,9 @@ out:
 
 	pthread_spin_unlock(&qp->sq.lock);
 
+	if (check_dca_detach_enable(qp))
+		hns_roce_dca_stop_post(&ctx->dca_ctx, qp->dca_wqe.dcan);
+
 	if (ibvqp->state == IBV_QPS_ERR) {
 		attr.qp_state = IBV_QPS_ERR;
 
@@ -1475,6 +1486,9 @@ out:
 
 	pthread_spin_unlock(&qp->rq.lock);
 
+	if (check_dca_detach_enable(qp))
+		hns_roce_dca_stop_post(&ctx->dca_ctx, qp->dca_wqe.dcan);
+
 	if (ibvqp->state == IBV_QPS_ERR) {
 		attr.qp_state = IBV_QPS_ERR;
 		hns_roce_u_v2_modify_qp(ibvqp, &attr, IBV_QP_STATE);
@@ -1563,8 +1577,9 @@ static int hns_roce_u_v2_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 				   int attr_mask)
 {
 	int ret;
-	struct ibv_modify_qp cmd;
+	struct hns_roce_modify_qp_ex cmd_ex = {};
 	struct hns_roce_qp *hr_qp = to_hr_qp(qp);
+	struct hns_roce_modify_qp_ex_resp resp_ex = {};
 	bool flag = false; /* modify qp to error */
 	struct hns_roce_context *ctx = to_hr_ctx(qp->context);
 
@@ -1574,7 +1589,9 @@ static int hns_roce_u_v2_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 		flag = true;
 	}
 
-	ret = ibv_cmd_modify_qp(qp, attr, attr_mask, &cmd, sizeof(cmd));
+	ret = ibv_cmd_modify_qp_ex(qp, attr, attr_mask, &cmd_ex.ibv_cmd,
+				   sizeof(cmd_ex), &resp_ex.ibv_resp,
+				   sizeof(resp_ex));
 
 	if (flag) {
 		pthread_spin_unlock(&hr_qp->rq.lock);
@@ -1584,8 +1601,11 @@ static int hns_roce_u_v2_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 	if (ret)
 		return ret;
 
-	if (attr_mask & IBV_QP_STATE)
+	if (attr_mask & IBV_QP_STATE) {
 		qp->state = attr->qp_state;
+		if (attr->qp_state == IBV_QPS_RTR)
+			hr_qp->dca_wqe.dcan = resp_ex.drv_payload.dcan;
+	}
 
 	if ((attr_mask & IBV_QP_STATE) && attr->qp_state == IBV_QPS_RESET) {
 		if (qp->recv_cq)
-- 
2.8.1

