Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549E131083A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 10:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBEJrL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 04:47:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12848 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBEJpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 04:45:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DX9Q96SpPz7hVh;
        Fri,  5 Feb 2021 17:40:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 17:41:50 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 07/12] RDMA/hns: Replace wmb&__raw_writeq with writeq
Date:   Fri, 5 Feb 2021 17:39:29 +0800
Message-ID: <1612517974-31867-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Currently, the driver updates doorbell looks like this:
post()
{
	wqe.field = 0x111;
	wmb();
	update_wq_db();
}

update_wq_db()
{
	db.field = 0x222;
	__raw_writeq(db, db_reg);
}

writeq() is a better choice than __raw_writeq() because it calls
dma_wmb() to barrier in ARM64, and dma_wmb() is better than wmb()
for ROCEE device.

This patch removes all wmb() before updating doorbell of SQ/RQ/CQ/SRQ
by replacing __raw_writeq() with writeq() to improve performence.
The new process looks like this:
post()
{
	wqe.field = 0x111;
	update_wq_db();
}

update_wq_db()
{
	db.field = 0x222;
	writeq(db, db_reg);
}

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 15 ---------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 20 +-------------------
 3 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1f94154..74eb08f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -1077,7 +1077,7 @@ static inline struct hns_roce_srq *to_hr_srq(struct ib_srq *ibsrq)
 
 static inline void hns_roce_write64_k(__le32 val[2], void __iomem *dest)
 {
-	__raw_writeq(*(u64 *) val, dest);
+	writeq(*(u64 *)val, dest);
 }
 
 static inline struct hns_roce_qp
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 262ad58..5346fdc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -330,8 +330,6 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 	/* Set DB return */
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
-		/* Memory barrier */
-		wmb();
 
 		roce_set_field(sq_db.u32_4, SQ_DOORBELL_U32_4_SQ_HEAD_M,
 			       SQ_DOORBELL_U32_4_SQ_HEAD_S,
@@ -411,8 +409,6 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 out:
 	if (likely(nreq)) {
 		hr_qp->rq.head += nreq;
-		/* Memory barrier */
-		wmb();
 
 		if (ibqp->qp_type == IB_QPT_GSI) {
 			__le32 tmp;
@@ -1984,12 +1980,6 @@ static void __hns_roce_v1_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 
 	if (nfreed) {
 		hr_cq->cons_index += nfreed;
-		/*
-		 * Make sure update of buffer contents is done before
-		 * updating consumer index.
-		 */
-		wmb();
-
 		hns_roce_v1_cq_set_ci(hr_cq, hr_cq->cons_index);
 	}
 }
@@ -2330,8 +2320,6 @@ int hns_roce_v1_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 		*hr_cq->tptr_addr = hr_cq->cons_index &
 			((hr_cq->cq_depth << 1) - 1);
 
-		/* Memroy barrier */
-		wmb();
 		hns_roce_v1_cq_set_ci(hr_cq, hr_cq->cons_index);
 	}
 
@@ -3220,9 +3208,6 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	 * need to hw to flash RQ HEAD by DB again
 	 */
 	if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-		/* Memory barrier */
-		wmb();
-
 		roce_set_field(doorbell[0], RQ_DOORBELL_U32_4_RQ_HEAD_M,
 			       RQ_DOORBELL_U32_4_RQ_HEAD_S, hr_qp->rq.head);
 		roce_set_field(doorbell[1], RQ_DOORBELL_U32_8_QPN_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6c9dbe2..a5e304a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -742,8 +742,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 	if (likely(nreq)) {
 		qp->sq.head += nreq;
 		qp->next_sge = sge_idx;
-		/* Memory barrier */
-		wmb();
 
 		if (nreq == 1 && qp->sq.head == qp->sq.tail + 1 &&
 		    (qp->en_flags & HNS_ROCE_QP_CAP_DIRECT_WQE))
@@ -873,8 +871,6 @@ static int hns_roce_v2_post_recv(struct ib_qp *ibqp,
 out:
 	if (likely(nreq)) {
 		hr_qp->rq.head += nreq;
-		/* Memory barrier */
-		wmb();
 
 		/*
 		 * Hip08 hardware cannot flush the WQEs in RQ if the QP state
@@ -1013,12 +1009,6 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	}
 
 	if (likely(nreq)) {
-		/*
-		 * Make sure that descriptors are written before
-		 * doorbell record.
-		 */
-		wmb();
-
 		srq_db.byte_4 =
 			cpu_to_le32(HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
 				    (srq->srqn & V2_DB_BYTE_4_TAG_M));
@@ -3196,11 +3186,6 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 
 	if (nfreed) {
 		hr_cq->cons_index += nfreed;
-		/*
-		 * Make sure update of buffer contents is done before
-		 * updating consumer index.
-		 */
-		wmb();
 		hns_roce_v2_cq_set_ci(hr_cq, hr_cq->cons_index);
 	}
 }
@@ -3709,11 +3694,8 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 			break;
 	}
 
-	if (npolled) {
-		/* Memory barrier */
-		wmb();
+	if (npolled)
 		hns_roce_v2_cq_set_ci(hr_cq, hr_cq->cons_index);
-	}
 
 out:
 	spin_unlock_irqrestore(&hr_cq->lock, flags);
-- 
2.8.1

