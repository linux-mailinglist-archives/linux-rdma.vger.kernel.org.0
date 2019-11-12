Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A08D7F8FF8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2019 13:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfKLMvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 07:51:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbfKLMvm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Nov 2019 07:51:42 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3B2F91F73D874B3A8FEC;
        Tue, 12 Nov 2019 20:51:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 20:51:30 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 2/2] RDMA/hns: Delayed flush cqe process with workqueue
Date:   Tue, 12 Nov 2019 20:52:04 +0800
Message-ID: <1573563124-12579-3-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
References: <1573563124-12579-1-git-send-email-liuyixian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HiP08 RoCE hardware lacks ability(a known hardware problem) to flush
outstanding WQEs if QP state gets into errored mode for some reason.
To overcome this hardware problem and as a workaround, when QP is
detected to be in errored state during various legs like post send,
post receive etc[1], flush needs to be performed from the driver.

The earlier patch[1] sent to solve the hardware limitation explained
in the cover-letter had a bug in the software flushing leg. It
acquired mutex while modifying QP state to errored state and while
conveying it to the hardware using the mailbox. This caused leg to
sleep while holding spin-lock and caused crash.

Suggested Solution:
we have proposed to defer the flushing of the QP in the Errored state
using the workqueue to get around with the limitation of our hardware.

This patch specifically adds the calls to the flush handler from
where parts of the code like post_send/post_recv etc. when the QP
state gets into the errored mode.

[1] https://patchwork.kernel.org/patch/10534271/

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Reviewed-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 84 ++++++++++++++----------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ec48e7e..bf8a710 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -221,11 +221,6 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	return 0;
 }
 
-static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
-				 const struct ib_qp_attr *attr,
-				 int attr_mask, enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state);
-
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				 const struct ib_send_wr *wr,
 				 const struct ib_send_wr **bad_wr)
@@ -238,14 +233,12 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	struct hns_roce_wqe_frmr_seg *fseg;
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_v2_db sq_db;
-	struct ib_qp_attr attr;
 	unsigned int sge_ind;
 	unsigned int owner_bit;
 	unsigned long flags;
 	unsigned int ind;
 	void *wqe = NULL;
 	bool loopback;
-	int attr_mask;
 	u32 tmp_len;
 	int ret = 0;
 	u32 hr_op;
@@ -591,18 +584,17 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->sq_next_wqe = ind;
 		qp->next_sge = sge_ind;
 
-		if (qp->state == IB_QPS_ERR) {
-			attr_mask = IB_QP_STATE;
-			attr.qp_state = IB_QPS_ERR;
-
-			ret = hns_roce_v2_modify_qp(&qp->ibqp, &attr, attr_mask,
-						    qp->state, IB_QPS_ERR);
-			if (ret) {
-				spin_unlock_irqrestore(&qp->sq.lock, flags);
-				*bad_wr = wr;
-				return ret;
-			}
-		}
+		/*
+		 * Hip08 hardware cannot flush the WQEs in SQ if the QP state
+		 * gets into errored mode. Hence, as a workaround to this
+		 * hardware limitation, driver needs to assist in flushing. But
+		 * the flushing operation uses mailbox to convey the QP state to
+		 * the hardware and which can sleep due to the mutex protection
+		 * around the mailbox calls. Hence, use the deferred flush for
+		 * now.
+		 */
+		if (qp->state == IB_QPS_ERR)
+			init_flush_work(hr_dev, qp);
 	}
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
@@ -619,10 +611,8 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_rinl_sge *sge_list;
 	struct device *dev = hr_dev->dev;
-	struct ib_qp_attr attr;
 	unsigned long flags;
 	void *wqe = NULL;
-	int attr_mask;
 	int ret = 0;
 	int nreq;
 	int ind;
@@ -692,19 +682,17 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 
 		*hr_qp->rdb.db_record = hr_qp->rq.head & 0xffff;
 
-		if (hr_qp->state == IB_QPS_ERR) {
-			attr_mask = IB_QP_STATE;
-			attr.qp_state = IB_QPS_ERR;
-
-			ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, &attr,
-						    attr_mask, hr_qp->state,
-						    IB_QPS_ERR);
-			if (ret) {
-				spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
-				*bad_wr = wr;
-				return ret;
-			}
-		}
+		/*
+		 * Hip08 hardware cannot flush the WQEs in RQ if the QP state
+		 * gets into errored mode. Hence, as a workaround to this
+		 * hardware limitation, driver needs to assist in flushing. But
+		 * the flushing operation uses mailbox to convey the QP state to
+		 * the hardware and which can sleep due to the mutex protection
+		 * around the mailbox calls. Hence, use the deferred flush for
+		 * now.
+		 */
+		if (hr_qp->state == IB_QPS_ERR)
+			init_flush_work(hr_dev, hr_qp);
 	}
 	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
 
@@ -2691,13 +2679,11 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				struct hns_roce_qp **cur_qp, struct ib_wc *wc)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
 	struct hns_roce_srq *srq = NULL;
-	struct hns_roce_dev *hr_dev;
 	struct hns_roce_v2_cqe *cqe;
 	struct hns_roce_qp *hr_qp;
 	struct hns_roce_wq *wq;
-	struct ib_qp_attr attr;
-	int attr_mask;
 	int is_send;
 	u16 wqe_ctr;
 	u32 opcode;
@@ -2721,7 +2707,6 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				V2_CQE_BYTE_16_LCL_QPN_S);
 
 	if (!*cur_qp || (qpn & HNS_ROCE_V2_CQE_QPN_MASK) != (*cur_qp)->qpn) {
-		hr_dev = to_hr_dev(hr_cq->ib_cq.device);
 		hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
 		if (unlikely(!hr_qp)) {
 			dev_err(hr_dev->dev, "CQ %06lx with entry for unknown QPN %06x\n",
@@ -2815,14 +2800,21 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		break;
 	}
 
-	/* flush cqe if wc status is error, excluding flush error */
-	if ((wc->status != IB_WC_SUCCESS) &&
-	    (wc->status != IB_WC_WR_FLUSH_ERR)) {
-		attr_mask = IB_QP_STATE;
-		attr.qp_state = IB_QPS_ERR;
-		return hns_roce_v2_modify_qp(&(*cur_qp)->ibqp,
-					     &attr, attr_mask,
-					     (*cur_qp)->state, IB_QPS_ERR);
+	/*
+	 * Hip08 hardware cannot flush the WQEs in SQ/RQ if the QP state gets
+	 * into errored mode. Hence, as a workaround to this hardware
+	 * limitation, driver needs to assist in flushing. But the flushing
+	 * operation uses mailbox to convey the QP state to the hardware and
+	 * which can sleep due to the mutex protection around the mailbox calls.
+	 * Hence, use the deferred flush for now. Once wc error detected, the
+	 * flushing operation is needed.
+	 */
+	if (wc->status != IB_WC_SUCCESS &&
+	    wc->status != IB_WC_WR_FLUSH_ERR) {
+		dev_err(hr_dev->dev, "error cqe status is: 0x%x\n",
+			status & HNS_ROCE_V2_CQE_STATUS_MASK);
+		init_flush_work(hr_dev, *cur_qp);
+		return 0;
 	}
 
 	if (wc->status == IB_WC_WR_FLUSH_ERR)
-- 
2.7.4

