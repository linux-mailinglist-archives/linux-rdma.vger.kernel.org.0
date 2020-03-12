Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A351829FC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387869AbgCLHv7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 03:51:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387958AbgCLHv7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 03:51:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A0E0355E5EED0EB1D720;
        Thu, 12 Mar 2020 15:51:55 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 15:51:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add interface to support lock free
Date:   Thu, 12 Mar 2020 15:48:10 +0800
Message-ID: <1583999290-20514-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jiaran Zhang <zhangjiaran@huawei.com>

In some scenarios, ULP can ensure that there is no concurrency when
processing io, thus lock free can be used to improve performance.

Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 112 ++++++++++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   1 +
 3 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d7dcf6e..974d125 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -703,6 +703,7 @@ struct hns_roce_qp {
 	struct list_head	node;		/* all qps are on a list */
 	struct list_head	rq_node;	/* all recv qps are on a list */
 	struct list_head	sq_node;	/* all send qps are on a list */
+	u8                      flush_en;
 };
 
 struct hns_roce_ib_iboe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 82021fa..369f9d1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -48,6 +48,35 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_hw_v2.h"
 
+static bool qp_lock = true;
+static bool cq_lock = true;
+
+static inline void v2_spin_lock_irqsave(bool has_lock, spinlock_t *lock,
+					unsigned long *flags)
+{
+	if (likely(has_lock))
+		spin_lock_irqsave(lock, *flags);
+}
+
+static inline void v2_spin_unlock_irqrestore(bool has_lock, spinlock_t *lock,
+					     unsigned long *flags)
+{
+	if (likely(has_lock))
+		spin_unlock_irqrestore(lock, *flags);
+}
+
+static inline void v2_spin_lock_irq(bool has_lock, spinlock_t *lock)
+{
+	if (likely(has_lock))
+		spin_lock_irq(lock);
+}
+
+static inline void v2_spin_unlock_irq(bool has_lock, spinlock_t *lock)
+{
+	if (likely(has_lock))
+		spin_unlock_irq(lock);
+}
+
 static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 			    struct ib_sge *sg)
 {
@@ -257,7 +286,8 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	 * now.
 	 */
 	if (qp->state == IB_QPS_ERR) {
-		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
+		if (qp_lock &&
+		    !test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
 			init_flush_work(hr_dev, qp);
 	} else {
 		struct hns_roce_v2_db sq_db = {};
@@ -301,7 +331,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	int ret;
 	int i;
 
-	spin_lock_irqsave(&qp->sq.lock, flags);
+	v2_spin_lock_irqsave(qp_lock, &qp->sq.lock, &flags);
 
 	ret = check_send_valid(hr_dev, qp);
 	if (ret) {
@@ -617,7 +647,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		update_sq_db(hr_dev, qp);
 	}
 
-	spin_unlock_irqrestore(&qp->sq.lock, flags);
+	v2_spin_unlock_irqrestore(qp_lock, &qp->sq.lock, &flags);
 
 	return ret;
 }
@@ -642,14 +672,14 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 	struct hns_roce_v2_wqe_data_seg *dseg;
 	struct hns_roce_rinl_sge *sge_list;
 	struct device *dev = hr_dev->dev;
-	unsigned long flags;
+	unsigned long flags = 0;
 	void *wqe = NULL;
 	u32 wqe_idx;
 	int nreq;
 	int ret;
 	int i;
 
-	spin_lock_irqsave(&hr_qp->rq.lock, flags);
+	v2_spin_lock_irqsave(qp_lock, &hr_qp->rq.lock, &flags);
 
 	ret = check_recv_valid(hr_dev, hr_qp);
 	if (ret) {
@@ -721,14 +751,15 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 		 * now.
 		 */
 		if (hr_qp->state == IB_QPS_ERR) {
-			if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG,
-					      &hr_qp->flush_flag))
+			if (qp_lock && !test_and_set_bit(HNS_ROCE_FLUSH_FLAG,
+							 &hr_qp->flush_flag))
 				init_flush_work(hr_dev, hr_qp);
 		} else {
 			*hr_qp->rdb.db_record = hr_qp->rq.head & 0xffff;
 		}
 	}
-	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
+
+	v2_spin_unlock_irqrestore(qp_lock, &hr_qp->rq.lock, &flags);
 
 	return ret;
 }
@@ -2810,9 +2841,9 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 static void hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 				 struct hns_roce_srq *srq)
 {
-	spin_lock_irq(&hr_cq->lock);
+	v2_spin_lock_irq(cq_lock, &hr_cq->lock);
 	__hns_roce_v2_cq_clean(hr_cq, qpn, srq);
-	spin_unlock_irq(&hr_cq->lock);
+	v2_spin_unlock_irq(cq_lock, &hr_cq->lock);
 }
 
 static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
@@ -3142,7 +3173,8 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		dev_err(hr_dev->dev, "error cqe status is: 0x%x\n",
 			status & HNS_ROCE_V2_CQE_STATUS_MASK);
 
-		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &hr_qp->flush_flag))
+		if (qp_lock &&
+		    !test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &hr_qp->flush_flag))
 			init_flush_work(hr_dev, hr_qp);
 
 		return 0;
@@ -3294,10 +3326,10 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	struct hns_roce_qp *cur_qp = NULL;
-	unsigned long flags;
+	unsigned long flags = 0;
 	int npolled;
 
-	spin_lock_irqsave(&hr_cq->lock, flags);
+	v2_spin_lock_irqsave(cq_lock, &hr_cq->lock, &flags);
 
 	/*
 	 * When the device starts to reset, the state is RST_DOWN. At this time,
@@ -3323,7 +3355,7 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 	}
 
 out:
-	spin_unlock_irqrestore(&hr_cq->lock, flags);
+	v2_spin_unlock_irqrestore(cq_lock, &hr_cq->lock, &flags);
 
 	return npolled;
 }
@@ -4753,29 +4785,42 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	if (ret)
 		goto out;
 
+	/* When locks are used for post verbs, flush cqe should be enabled */
+	if (qp_lock) {
+		hr_qp->flush_en = 1;
+		/* Ensure that the value of flush_en can be read correctly later */
+		rmb();
+	}
+
 	/* When QP state is err, SQ and RQ WQE should be flushed */
 	if (new_state == IB_QPS_ERR) {
-		spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
-		hr_qp->state = IB_QPS_ERR;
+		v2_spin_lock_irqsave(qp_lock, &hr_qp->sq.lock, &sq_flag);
 		roce_set_field(context->byte_160_sq_ci_pi,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
 			       hr_qp->sq.head);
-		roce_set_field(qpc_mask->byte_160_sq_ci_pi,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
-		spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
+		if (hr_qp->flush_en == 1)
+			roce_set_field(qpc_mask->byte_160_sq_ci_pi,
+				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
+				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
+
+		hr_qp->state = IB_QPS_ERR;
+		v2_spin_unlock_irqrestore(qp_lock, &hr_qp->sq.lock, &sq_flag);
 
 		if (!ibqp->srq) {
-			spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
+			v2_spin_lock_irqsave(qp_lock, &hr_qp->rq.lock,
+					     &rq_flag);
 			roce_set_field(context->byte_84_rq_ci_pi,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
-			       hr_qp->rq.head);
-			roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
-			spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flag);
+				       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
+				       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
+				       hr_qp->rq.head);
+			if (hr_qp->flush_en == 1)
+				roce_set_field(qpc_mask->byte_84_rq_ci_pi,
+					       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
+					       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
+					       0);
+			v2_spin_unlock_irqrestore(qp_lock, &hr_qp->rq.lock,
+						  &rq_flag);
 		}
 	}
 
@@ -5017,7 +5062,8 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	recv_cq = hr_qp->ibqp.recv_cq ? to_hr_cq(hr_qp->ibqp.recv_cq) : NULL;
 
 	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
-	hns_roce_lock_cqs(send_cq, recv_cq);
+	if (cq_lock)
+		hns_roce_lock_cqs(send_cq, recv_cq);
 
 	if (!udata) {
 		if (recv_cq)
@@ -5033,7 +5079,9 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 
 	hns_roce_qp_remove(hr_dev, hr_qp);
 
-	hns_roce_unlock_cqs(send_cq, recv_cq);
+	if (cq_lock)
+		hns_roce_unlock_cqs(send_cq, recv_cq);
+
 	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 
 	return ret;
@@ -6617,3 +6665,7 @@ MODULE_AUTHOR("Wei Hu <xavier.huwei@huawei.com>");
 MODULE_AUTHOR("Lijun Ou <oulijun@huawei.com>");
 MODULE_AUTHOR("Shaobo Xu <xushaobo2@huawei.com>");
 MODULE_DESCRIPTION("Hisilicon Hip08 Family RoCE Driver");
+module_param(qp_lock, bool, 0444);
+MODULE_PARM_DESC(qp_lock, "default: true");
+module_param(cq_lock, bool, 0444);
+MODULE_PARM_DESC(cq_lock, "default: true");
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 5a28d62..bca66c3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -56,6 +56,7 @@ static void flush_work_handle(struct work_struct *work)
 
 	attr_mask = IB_QP_STATE;
 	attr.qp_state = IB_QPS_ERR;
+	hr_qp->flush_en = 1;
 
 	if (test_and_clear_bit(HNS_ROCE_FLUSH_FLAG, &hr_qp->flush_flag)) {
 		ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
-- 
2.8.1

