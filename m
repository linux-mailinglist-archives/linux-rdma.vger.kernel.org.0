Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7C34B61B
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 11:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhC0K2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Mar 2021 06:28:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14171 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhC0K2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Mar 2021 06:28:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6w3950QQznZsy;
        Sat, 27 Mar 2021 18:25:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 18:28:05 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 1/2] RDMA/hns: Support configuring doorbell mode of RQ and CQ
Date:   Sat, 27 Mar 2021 18:25:37 +0800
Message-ID: <1616840738-7866-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616840738-7866-1-git-send-email-liweihang@huawei.com>
References: <1616840738-7866-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixian Liu <liuyixian@huawei.com>

HIP08 supports both normal and record doorbell mode for RQ and CQ, SQ
record doorbell for userspace is also supported by the software for
flushing CQE process. As now the capability of HIP08 are exposed to the
user and are configurable, the support of normal doorbell should be added
back.

Note that, if switching to normal doorbell, the kernel will report "flush
cqe is unsupported" if modify qp to error status as the flush is based on
record doorbell.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 88 ++++++++++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  6 +-
 5 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 74fc494..f53aa44 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -225,7 +225,7 @@ static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 		       struct ib_udata *udata, unsigned long addr,
 		       struct hns_roce_ib_create_cq_resp *resp)
 {
-	bool has_db = hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB;
+	bool has_db = hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB;
 	struct hns_roce_ucontext *uctx;
 	int err;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index eb2ccb8..b8a43fa 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -179,8 +179,8 @@ enum {
 	HNS_ROCE_CAP_FLAG_REREG_MR		= BIT(0),
 	HNS_ROCE_CAP_FLAG_ROCE_V1_V2		= BIT(1),
 	HNS_ROCE_CAP_FLAG_RQ_INLINE		= BIT(2),
-	HNS_ROCE_CAP_FLAG_RECORD_DB		= BIT(3),
-	HNS_ROCE_CAP_FLAG_SQ_RECORD_DB		= BIT(4),
+	HNS_ROCE_CAP_FLAG_CQ_RECORD_DB		= BIT(3),
+	HNS_ROCE_CAP_FLAG_QP_RECORD_DB		= BIT(4),
 	HNS_ROCE_CAP_FLAG_SRQ			= BIT(5),
 	HNS_ROCE_CAP_FLAG_XRC			= BIT(6),
 	HNS_ROCE_CAP_FLAG_MW			= BIT(7),
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 783388b..f1360d9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -632,7 +632,7 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	 * around the mailbox calls. Hence, use the deferred flush for
 	 * now.
 	 */
-	if (qp->state == IB_QPS_ERR) {
+	if (unlikely(qp->state == IB_QPS_ERR)) {
 		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
 			init_flush_work(hr_dev, qp);
 	} else {
@@ -653,6 +653,40 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	}
 }
 
+static inline void update_rq_db(struct hns_roce_dev *hr_dev,
+				struct hns_roce_qp *qp)
+{
+	/*
+	 * Hip08 hardware cannot flush the WQEs in RQ if the QP state
+	 * gets into errored mode. Hence, as a workaround to this
+	 * hardware limitation, driver needs to assist in flushing. But
+	 * the flushing operation uses mailbox to convey the QP state to
+	 * the hardware and which can sleep due to the mutex protection
+	 * around the mailbox calls. Hence, use the deferred flush for
+	 * now.
+	 */
+	if (unlikely(qp->state == IB_QPS_ERR)) {
+		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
+			init_flush_work(hr_dev, qp);
+	} else {
+		if (likely(qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)) {
+			*qp->rdb.db_record =
+					qp->rq.head & V2_DB_PARAMETER_IDX_M;
+		} else {
+			struct hns_roce_v2_db rq_db = {};
+
+			roce_set_field(rq_db.byte_4, V2_DB_BYTE_4_TAG_M,
+				       V2_DB_BYTE_4_TAG_S, qp->qpn);
+			roce_set_field(rq_db.byte_4, V2_DB_BYTE_4_CMD_M,
+				       V2_DB_BYTE_4_CMD_S, HNS_ROCE_V2_RQ_DB);
+			roce_set_field(rq_db.parameter, V2_DB_PARAMETER_IDX_M,
+				       V2_DB_PARAMETER_IDX_S, qp->rq.head);
+
+			hns_roce_write64_k((__le32 *)&rq_db, qp->rq.db_reg_l);
+		}
+	}
+}
+
 static void hns_roce_write512(struct hns_roce_dev *hr_dev, u64 *val,
 			      u64 __iomem *dest)
 {
@@ -878,22 +912,7 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	if (likely(nreq)) {
 		hr_qp->rq.head += nreq;
 
-		/*
-		 * Hip08 hardware cannot flush the WQEs in RQ if the QP state
-		 * gets into errored mode. Hence, as a workaround to this
-		 * hardware limitation, driver needs to assist in flushing. But
-		 * the flushing operation uses mailbox to convey the QP state to
-		 * the hardware and which can sleep due to the mutex protection
-		 * around the mailbox calls. Hence, use the deferred flush for
-		 * now.
-		 */
-		if (hr_qp->state == IB_QPS_ERR) {
-			if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG,
-					      &hr_qp->flush_flag))
-				init_flush_work(hr_dev, hr_qp);
-		} else {
-			*hr_qp->rdb.db_record = hr_qp->rq.head & 0xffff;
-		}
+		update_rq_db(hr_dev, hr_qp);
 	}
 	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
 
@@ -1884,8 +1903,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 
 	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
 				  HNS_ROCE_CAP_FLAG_ROCE_V1_V2 |
-				  HNS_ROCE_CAP_FLAG_RECORD_DB |
-				  HNS_ROCE_CAP_FLAG_SQ_RECORD_DB;
+				  HNS_ROCE_CAP_FLAG_CQ_RECORD_DB |
+				  HNS_ROCE_CAP_FLAG_QP_RECORD_DB;
 
 	caps->pkey_table_len[0] = 1;
 	caps->gid_table_len[0]	= HNS_ROCE_V2_GID_INDEX_NUM;
@@ -3082,7 +3101,23 @@ static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
 
 static inline void hns_roce_v2_cq_set_ci(struct hns_roce_cq *hr_cq, u32 ci)
 {
-	*hr_cq->set_ci_db = ci & V2_CQ_DB_PARAMETER_CONS_IDX_M;
+	if (likely(hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB)) {
+		*hr_cq->set_ci_db = ci & V2_CQ_DB_PARAMETER_CONS_IDX_M;
+	} else {
+		struct hns_roce_v2_db cq_db = {};
+
+		roce_set_field(cq_db.byte_4, V2_CQ_DB_BYTE_4_TAG_M,
+			       V2_CQ_DB_BYTE_4_TAG_S, hr_cq->cqn);
+		roce_set_field(cq_db.byte_4, V2_CQ_DB_BYTE_4_CMD_M,
+			       V2_CQ_DB_BYTE_4_CMD_S, HNS_ROCE_V2_CQ_DB_PTR);
+		roce_set_field(cq_db.parameter, V2_CQ_DB_PARAMETER_CONS_IDX_M,
+			       V2_CQ_DB_PARAMETER_CONS_IDX_S,
+			       ci & ((hr_cq->cq_depth << 1) - 1));
+		roce_set_field(cq_db.parameter, V2_CQ_DB_PARAMETER_CMD_SN_M,
+			       V2_CQ_DB_PARAMETER_CMD_SN_S, 1);
+
+		hns_roce_write64_k((__le32 *)&cq_db, hr_cq->cq_db_l);
+	}
 }
 
 static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
@@ -4154,17 +4189,6 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S, 0);
 
-	roce_set_field(context->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, hr_qp->rq.head);
-	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
-
-	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_S, 0);
-
 	return 0;
 }
 
@@ -4840,7 +4864,7 @@ static void clear_qp(struct hns_roce_qp *hr_qp)
 				     hr_qp->qpn, ibqp->srq ?
 				     to_hr_srq(ibqp->srq) : NULL);
 
-	if (hr_qp->rq.wqe_cnt)
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 		*hr_qp->rdb.db_record = 0;
 
 	hr_qp->rq.head = 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index aa90311..924dc48 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -309,7 +309,8 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	if (ret)
 		goto error_fail_uar_alloc;
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&context->page_list);
 		mutex_init(&context->page_mutex);
 	}
@@ -729,7 +730,8 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	spin_lock_init(&hr_dev->sm_lock);
 	spin_lock_init(&hr_dev->bt_cmd_lock);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
+	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) {
 		INIT_LIST_HEAD(&hr_dev->pgdir_list);
 		mutex_init(&hr_dev->pgdir_mutex);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 6203c17..54f8566 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -785,7 +785,7 @@ static inline bool user_qp_has_sdb(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_ib_create_qp_resp *resp,
 				   struct hns_roce_ib_create_qp *ucmd)
 {
-	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SQ_RECORD_DB) &&
+	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) &&
 		udata->outlen >= offsetofend(typeof(*resp), cap_flags) &&
 		hns_roce_qp_has_sq(init_attr) &&
 		udata->inlen >= offsetofend(typeof(*ucmd), sdb_addr));
@@ -796,7 +796,7 @@ static inline bool user_qp_has_rdb(struct hns_roce_dev *hr_dev,
 				   struct ib_udata *udata,
 				   struct hns_roce_ib_create_qp_resp *resp)
 {
-	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
+	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) &&
 		udata->outlen >= offsetofend(typeof(*resp), cap_flags) &&
 		hns_roce_qp_has_rq(init_attr));
 }
@@ -804,7 +804,7 @@ static inline bool user_qp_has_rdb(struct hns_roce_dev *hr_dev,
 static inline bool kernel_qp_has_rdb(struct hns_roce_dev *hr_dev,
 				     struct ib_qp_init_attr *init_attr)
 {
-	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RECORD_DB) &&
+	return ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB) &&
 		hns_roce_qp_has_rq(init_attr));
 }
 
-- 
2.8.1

