Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332CD168E3F
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBVK0c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 05:26:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbgBVK0c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Feb 2020 05:26:32 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BC15FDE833A0B6B2593;
        Sat, 22 Feb 2020 18:26:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Feb 2020 18:26:19 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Stop doorbell update while qp state error
Date:   Sat, 22 Feb 2020 18:25:58 +0800
Message-ID: <1582367158-27030-3-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
References: <1582367158-27030-1-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are two paths to update qp producer index into hardware now,
one path is doorbell in post verbs (send and recv), the another is
mailbox in modify qp verb which is called by flush process. This
will lead the hardware to be broken to correctly generate flush cqe.
With stoping doorbell update and holding qp spinlock in modify qp
during flush process, the problem can be solved.

Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 76 ++++++++++++++++--------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 2c48f67..16f9d30 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -244,6 +244,38 @@ static int check_send_valid(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static inline void update_sq_db(struct hns_roce_dev *hr_dev,
+				struct hns_roce_qp *qp)
+{
+	/*
+	 * Hip08 hardware cannot flush the WQEs in SQ if the QP state
+	 * gets into errored mode. Hence, as a workaround to this
+	 * hardware limitation, driver needs to assist in flushing. But
+	 * the flushing operation uses mailbox to convey the QP state to
+	 * the hardware and which can sleep due to the mutex protection
+	 * around the mailbox calls. Hence, use the deferred flush for
+	 * now.
+	 */
+	if (qp->state == IB_QPS_ERR) {
+		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
+			init_flush_work(hr_dev, qp);
+	} else {
+		struct hns_roce_v2_db sq_db = {};
+
+		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_TAG_M,
+			       V2_DB_BYTE_4_TAG_S, qp->doorbell_qpn);
+		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_CMD_M,
+			       V2_DB_BYTE_4_CMD_S, HNS_ROCE_V2_SQ_DB);
+		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_IDX_M,
+			       V2_DB_PARAMETER_IDX_S,
+			       qp->sq.head & ((qp->sq.wqe_cnt << 1) - 1));
+		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_SL_M,
+			       V2_DB_PARAMETER_SL_S, qp->sl);
+
+		hns_roce_write64(hr_dev, (__le32 *)&sq_db, qp->sq.db_reg_l);
+	}
+}
+
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				 const struct ib_send_wr *wr,
 				 const struct ib_send_wr **bad_wr)
@@ -255,7 +287,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
 	struct hns_roce_wqe_frmr_seg *fseg;
 	struct device *dev = hr_dev->dev;
-	struct hns_roce_v2_db sq_db = {};
 	unsigned int owner_bit;
 	unsigned int sge_idx;
 	unsigned int wqe_idx;
@@ -580,36 +611,10 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 out:
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
+		qp->next_sge = sge_idx;
 		/* Memory barrier */
 		wmb();
-
-		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_TAG_M,
-			       V2_DB_BYTE_4_TAG_S, qp->doorbell_qpn);
-		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_CMD_M,
-			       V2_DB_BYTE_4_CMD_S, HNS_ROCE_V2_SQ_DB);
-		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_IDX_M,
-			       V2_DB_PARAMETER_IDX_S,
-			       qp->sq.head & ((qp->sq.wqe_cnt << 1) - 1));
-		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_SL_M,
-			       V2_DB_PARAMETER_SL_S, qp->sl);
-
-		hns_roce_write64(hr_dev, (__le32 *)&sq_db, qp->sq.db_reg_l);
-
-		qp->next_sge = sge_idx;
-
-		/*
-		 * Hip08 hardware cannot flush the WQEs in SQ if the QP state
-		 * gets into errored mode. Hence, as a workaround to this
-		 * hardware limitation, driver needs to assist in flushing. But
-		 * the flushing operation uses mailbox to convey the QP state to
-		 * the hardware and which can sleep due to the mutex protection
-		 * around the mailbox calls. Hence, use the deferred flush for
-		 * now.
-		 */
-		if (qp->state == IB_QPS_ERR)
-			if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG,
-					      &qp->flush_flag))
-				init_flush_work(hr_dev, qp);
+		update_sq_db(hr_dev, qp);
 	}
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
@@ -706,8 +711,6 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		/* Memory barrier */
 		wmb();
 
-		*hr_qp->rdb.db_record = hr_qp->rq.head & 0xffff;
-
 		/*
 		 * Hip08 hardware cannot flush the WQEs in RQ if the QP state
 		 * gets into errored mode. Hence, as a workaround to this
@@ -717,10 +720,13 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		 * around the mailbox calls. Hence, use the deferred flush for
 		 * now.
 		 */
-		if (hr_qp->state == IB_QPS_ERR)
+		if (hr_qp->state == IB_QPS_ERR) {
 			if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG,
 					      &hr_qp->flush_flag))
 				init_flush_work(hr_dev, hr_qp);
+		} else {
+			*hr_qp->rdb.db_record = hr_qp->rq.head & 0xffff;
+		}
 	}
 	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
 
@@ -4752,7 +4758,6 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	/* When QP state is err, SQ and RQ WQE should be flushed */
 	if (new_state == IB_QPS_ERR) {
 		spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
-		spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
 		hr_qp->state = IB_QPS_ERR;
 		roce_set_field(context->byte_160_sq_ci_pi,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
@@ -4761,8 +4766,10 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		roce_set_field(qpc_mask->byte_160_sq_ci_pi,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
+		spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
 
 		if (!ibqp->srq) {
+			spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
 			roce_set_field(context->byte_84_rq_ci_pi,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
@@ -4770,9 +4777,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 			roce_set_field(qpc_mask->byte_84_rq_ci_pi,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
+			spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flag);
 		}
-		spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flag);
-		spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
 	}
 
 	/* Configure the optional fields */
-- 
2.7.4

