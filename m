Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E491A34B61A
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 11:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhC0K2Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Mar 2021 06:28:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14172 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhC0K2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Mar 2021 06:28:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6w394G33znZLd;
        Sat, 27 Mar 2021 18:25:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 18:28:05 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/2] RDMA/hns: Reorganize doorbell update interfaces for all queues
Date:   Sat, 27 Mar 2021 18:25:38 +0800
Message-ID: <1616840738-7866-3-git-send-email-liweihang@huawei.com>
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

The doorbell update interfaces are very similar for different queues, such
as SQ, RQ, SRQ, CQ and EQ. So reorganize these code and also fix some
inappropriate naming.

Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   8 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  24 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 145 ++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  56 +++++------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  10 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   2 +-
 7 files changed, 119 insertions(+), 130 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index f53aa44..dc36fbe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -250,8 +250,8 @@ static int alloc_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 			*hr_cq->set_ci_db = 0;
 			hr_cq->flags |= HNS_ROCE_CQ_FLAG_RECORD_DB;
 		}
-		hr_cq->cq_db_l = hr_dev->reg_base + hr_dev->odb_offset +
-				 DB_REG_OFFSET * hr_dev->priv_uar.index;
+		hr_cq->db_reg = hr_dev->reg_base + hr_dev->odb_offset +
+				DB_REG_OFFSET * hr_dev->priv_uar.index;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index b8a43fa..61323cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -372,7 +372,7 @@ struct hns_roce_wq {
 	int		wqe_shift;	/* WQE size */
 	u32		head;
 	u32		tail;
-	void __iomem	*db_reg_l;
+	void __iomem	*db_reg;
 };
 
 struct hns_roce_sge {
@@ -446,7 +446,7 @@ struct hns_roce_cq {
 	u32				cq_depth;
 	u32				cons_index;
 	u32				*set_ci_db;
-	void __iomem			*cq_db_l;
+	void __iomem			*db_reg;
 	u16				*tptr_addr;
 	int				arm_sn;
 	int				cqe_size;
@@ -477,7 +477,7 @@ struct hns_roce_srq {
 	int			wqe_shift;
 	u32			cqn;
 	u32			xrcdn;
-	void __iomem		*db_reg_l;
+	void __iomem		*db_reg;
 
 	atomic_t		refcount;
 	struct completion	free;
@@ -707,7 +707,7 @@ struct hns_roce_aeqe {
 
 struct hns_roce_eq {
 	struct hns_roce_dev		*hr_dev;
-	void __iomem			*doorbell;
+	void __iomem			*db_reg;
 
 	int				type_flag; /* Aeq:1 ceq:0 */
 	int				eqn;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 759ffe5..60454f1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -345,7 +345,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 		doorbell[0] = sq_db.u32_4;
 		doorbell[1] = sq_db.u32_8;
 
-		hns_roce_write64_k(doorbell, qp->sq.db_reg_l);
+		hns_roce_write64_k(doorbell, qp->sq.db_reg);
 	}
 
 	spin_unlock_irqrestore(&qp->sq.lock, flags);
@@ -440,7 +440,7 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 			doorbell[0] = rq_db.u32_4;
 			doorbell[1] = rq_db.u32_8;
 
-			hns_roce_write64_k(doorbell, hr_qp->rq.db_reg_l);
+			hns_roce_write64_k(doorbell, hr_qp->rq.db_reg);
 		}
 	}
 	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
@@ -1939,7 +1939,7 @@ static void hns_roce_v1_cq_set_ci(struct hns_roce_cq *hr_cq, u32 cons_index)
 	roce_set_field(doorbell[1], ROCEE_DB_OTHERS_H_ROCEE_DB_OTH_INP_H_M,
 		       ROCEE_DB_OTHERS_H_ROCEE_DB_OTH_INP_H_S, hr_cq->cqn);
 
-	hns_roce_write64_k(doorbell, hr_cq->cq_db_l);
+	hns_roce_write64_k(doorbell, hr_cq->db_reg);
 }
 
 static void __hns_roce_v1_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
@@ -2092,7 +2092,7 @@ static int hns_roce_v1_req_notify_cq(struct ib_cq *ibcq,
 		       ROCEE_DB_OTHERS_H_ROCEE_DB_OTH_INP_H_S,
 		       hr_cq->cqn | notification_flag);
 
-	hns_roce_write64_k(doorbell, hr_cq->cq_db_l);
+	hns_roce_write64_k(doorbell, hr_cq->db_reg);
 
 	return 0;
 }
@@ -3217,12 +3217,12 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		roce_set_bit(doorbell[1], RQ_DOORBELL_U32_8_HW_SYNC_S, 1);
 
 		if (ibqp->uobject) {
-			hr_qp->rq.db_reg_l = hr_dev->reg_base +
+			hr_qp->rq.db_reg = hr_dev->reg_base +
 				     hr_dev->odb_offset +
 				     DB_REG_OFFSET * hr_dev->priv_uar.index;
 		}
 
-		hns_roce_write64_k(doorbell, hr_qp->rq.db_reg_l);
+		hns_roce_write64_k(doorbell, hr_qp->rq.db_reg);
 	}
 
 	hr_qp->state = new_state;
@@ -3604,7 +3604,7 @@ static int hns_roce_v1_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 static void set_eq_cons_index_v1(struct hns_roce_eq *eq, u32 req_not)
 {
 	roce_raw_write((eq->cons_index & HNS_ROCE_V1_CONS_IDX_M) |
-		       (req_not << eq->log_entries), eq->doorbell);
+		       (req_not << eq->log_entries), eq->db_reg);
 }
 
 static void hns_roce_v1_wq_catas_err_handle(struct hns_roce_dev *hr_dev,
@@ -4234,9 +4234,9 @@ static int hns_roce_v1_init_eq_table(struct hns_roce_dev *hr_dev)
 						ROCEE_CAEP_CEQC_SHIFT_0_REG +
 						CEQ_REG_OFFSET * i;
 			eq->type_flag = HNS_ROCE_CEQ;
-			eq->doorbell = hr_dev->reg_base +
-				       ROCEE_CAEP_CEQC_CONS_IDX_0_REG +
-				       CEQ_REG_OFFSET * i;
+			eq->db_reg = hr_dev->reg_base +
+				     ROCEE_CAEP_CEQC_CONS_IDX_0_REG +
+				     CEQ_REG_OFFSET * i;
 			eq->entries = hr_dev->caps.ceqe_depth;
 			eq->log_entries = ilog2(eq->entries);
 			eq->eqe_size = HNS_ROCE_CEQE_SIZE;
@@ -4245,8 +4245,8 @@ static int hns_roce_v1_init_eq_table(struct hns_roce_dev *hr_dev)
 			eq_table->eqc_base[i] = hr_dev->reg_base +
 						ROCEE_CAEP_AEQC_AEQE_SHIFT_REG;
 			eq->type_flag = HNS_ROCE_AEQ;
-			eq->doorbell = hr_dev->reg_base +
-				       ROCEE_CAEP_AEQE_CONS_IDX_REG;
+			eq->db_reg = hr_dev->reg_base +
+				     ROCEE_CAEP_AEQE_CONS_IDX_REG;
 			eq->entries = hr_dev->caps.aeqe_depth;
 			eq->log_entries = ilog2(eq->entries);
 			eq->eqe_size = HNS_ROCE_AEQE_SIZE;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f1360d9..3cb3ae6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -638,18 +638,19 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	} else {
 		struct hns_roce_v2_db sq_db = {};
 
-		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_TAG_M,
-			       V2_DB_BYTE_4_TAG_S, qp->doorbell_qpn);
-		roce_set_field(sq_db.byte_4, V2_DB_BYTE_4_CMD_M,
-			       V2_DB_BYTE_4_CMD_S, HNS_ROCE_V2_SQ_DB);
+		roce_set_field(sq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
+			       qp->doorbell_qpn);
+		roce_set_field(sq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
+			       HNS_ROCE_V2_SQ_DB);
+
 		/* indicates data on new BAR, 0 : SQ doorbell, 1 : DWQE */
 		roce_set_bit(sq_db.byte_4, V2_DB_FLAG_S, 0);
-		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_IDX_M,
-			       V2_DB_PARAMETER_IDX_S, qp->sq.head);
-		roce_set_field(sq_db.parameter, V2_DB_PARAMETER_SL_M,
-			       V2_DB_PARAMETER_SL_S, qp->sl);
+		roce_set_field(sq_db.parameter, V2_DB_PRODUCER_IDX_M,
+			       V2_DB_PRODUCER_IDX_S, qp->sq.head);
+		roce_set_field(sq_db.parameter, V2_DB_SL_M, V2_DB_SL_S,
+			       qp->sl);
 
-		hns_roce_write64(hr_dev, (__le32 *)&sq_db, qp->sq.db_reg_l);
+		hns_roce_write64(hr_dev, (__le32 *)&sq_db, qp->sq.db_reg);
 	}
 }
 
@@ -671,18 +672,19 @@ static inline void update_rq_db(struct hns_roce_dev *hr_dev,
 	} else {
 		if (likely(qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)) {
 			*qp->rdb.db_record =
-					qp->rq.head & V2_DB_PARAMETER_IDX_M;
+					qp->rq.head & V2_DB_PRODUCER_IDX_M;
 		} else {
 			struct hns_roce_v2_db rq_db = {};
 
-			roce_set_field(rq_db.byte_4, V2_DB_BYTE_4_TAG_M,
-				       V2_DB_BYTE_4_TAG_S, qp->qpn);
-			roce_set_field(rq_db.byte_4, V2_DB_BYTE_4_CMD_M,
-				       V2_DB_BYTE_4_CMD_S, HNS_ROCE_V2_RQ_DB);
-			roce_set_field(rq_db.parameter, V2_DB_PARAMETER_IDX_M,
-				       V2_DB_PARAMETER_IDX_S, qp->rq.head);
+			roce_set_field(rq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
+				       qp->qpn);
+			roce_set_field(rq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
+				       HNS_ROCE_V2_RQ_DB);
+			roce_set_field(rq_db.parameter, V2_DB_PRODUCER_IDX_M,
+				       V2_DB_PRODUCER_IDX_S, qp->rq.head);
 
-			hns_roce_write64_k((__le32 *)&rq_db, qp->rq.db_reg_l);
+			hns_roce_write64(hr_dev, (__le32 *)&rq_db,
+					 qp->rq.db_reg);
 		}
 	}
 }
@@ -715,7 +717,7 @@ static void write_dwqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_M,
 		       V2_RC_SEND_WQE_BYTE_4_WQE_INDEX_S, qp->sq.head);
 
-	hns_roce_write512(hr_dev, wqe, qp->sq.db_reg_l);
+	hns_roce_write512(hr_dev, wqe, qp->sq.db_reg);
 }
 
 static int hns_roce_v2_post_send(struct ib_qp *ibqp,
@@ -1034,13 +1036,14 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	}
 
 	if (likely(nreq)) {
-		srq_db.byte_4 =
-			cpu_to_le32(HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
-				    (srq->srqn & V2_DB_BYTE_4_TAG_M));
-		srq_db.parameter =
-			cpu_to_le32(srq->idx_que.head & V2_DB_PARAMETER_IDX_M);
+		roce_set_field(srq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
+			       srq->srqn);
+		roce_set_field(srq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
+			       HNS_ROCE_V2_SRQ_DB);
+		roce_set_field(srq_db.parameter, V2_DB_PRODUCER_IDX_M,
+			       V2_DB_PRODUCER_IDX_S, srq->idx_que.head);
 
-		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg_l);
+		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg);
 	}
 
 	spin_unlock_irqrestore(&srq->lock, flags);
@@ -3099,30 +3102,31 @@ static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, unsigned int n)
 		!!(n & hr_cq->cq_depth)) ? cqe : NULL;
 }
 
-static inline void hns_roce_v2_cq_set_ci(struct hns_roce_cq *hr_cq, u32 ci)
+static inline void update_cq_db(struct hns_roce_dev *hr_dev,
+				struct hns_roce_cq *hr_cq)
 {
 	if (likely(hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB)) {
-		*hr_cq->set_ci_db = ci & V2_CQ_DB_PARAMETER_CONS_IDX_M;
+		*hr_cq->set_ci_db = hr_cq->cons_index & V2_CQ_DB_CONS_IDX_M;
 	} else {
 		struct hns_roce_v2_db cq_db = {};
 
-		roce_set_field(cq_db.byte_4, V2_CQ_DB_BYTE_4_TAG_M,
-			       V2_CQ_DB_BYTE_4_TAG_S, hr_cq->cqn);
-		roce_set_field(cq_db.byte_4, V2_CQ_DB_BYTE_4_CMD_M,
-			       V2_CQ_DB_BYTE_4_CMD_S, HNS_ROCE_V2_CQ_DB_PTR);
-		roce_set_field(cq_db.parameter, V2_CQ_DB_PARAMETER_CONS_IDX_M,
-			       V2_CQ_DB_PARAMETER_CONS_IDX_S,
-			       ci & ((hr_cq->cq_depth << 1) - 1));
-		roce_set_field(cq_db.parameter, V2_CQ_DB_PARAMETER_CMD_SN_M,
-			       V2_CQ_DB_PARAMETER_CMD_SN_S, 1);
+		roce_set_field(cq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
+			       hr_cq->cqn);
+		roce_set_field(cq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
+			       HNS_ROCE_V2_CQ_DB);
+		roce_set_field(cq_db.parameter, V2_CQ_DB_CONS_IDX_M,
+			       V2_CQ_DB_CONS_IDX_S, hr_cq->cons_index);
+		roce_set_field(cq_db.parameter, V2_CQ_DB_CMD_SN_M,
+			       V2_CQ_DB_CMD_SN_S, 1);
 
-		hns_roce_write64_k((__le32 *)&cq_db, hr_cq->cq_db_l);
+		hns_roce_write64(hr_dev, (__le32 *)&cq_db, hr_cq->db_reg);
 	}
 }
 
 static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 				   struct hns_roce_srq *srq)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
 	struct hns_roce_v2_cqe *cqe, *dest;
 	u32 prod_index;
 	int nfreed = 0;
@@ -3165,7 +3169,7 @@ static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
 
 	if (nfreed) {
 		hr_cq->cons_index += nfreed;
-		hns_roce_v2_cq_set_ci(hr_cq, hr_cq->cons_index);
+		update_cq_db(hr_dev, hr_cq);
 	}
 }
 
@@ -3260,30 +3264,26 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
-	u32 notification_flag;
-	__le32 doorbell[2];
-
-	doorbell[0] = 0;
-	doorbell[1] = 0;
+	struct hns_roce_v2_db cq_db = {};
+	u32 notify_flag;
 
-	notification_flag = (flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED ?
-			     V2_CQ_DB_REQ_NOT : V2_CQ_DB_REQ_NOT_SOL;
 	/*
-	 * flags = 0; Notification Flag = 1, next
-	 * flags = 1; Notification Flag = 0, solocited
+	 * flags = 0, then notify_flag : next
+	 * flags = 1, then notify flag : solocited
 	 */
-	roce_set_field(doorbell[0], V2_CQ_DB_BYTE_4_TAG_M, V2_DB_BYTE_4_TAG_S,
-		       hr_cq->cqn);
-	roce_set_field(doorbell[0], V2_CQ_DB_BYTE_4_CMD_M, V2_DB_BYTE_4_CMD_S,
-		       HNS_ROCE_V2_CQ_DB_NTR);
-	roce_set_field(doorbell[1], V2_CQ_DB_PARAMETER_CONS_IDX_M,
-		       V2_CQ_DB_PARAMETER_CONS_IDX_S, hr_cq->cons_index);
-	roce_set_field(doorbell[1], V2_CQ_DB_PARAMETER_CMD_SN_M,
-		       V2_CQ_DB_PARAMETER_CMD_SN_S, hr_cq->arm_sn & 0x3);
-	roce_set_bit(doorbell[1], V2_CQ_DB_PARAMETER_NOTIFY_S,
-		     notification_flag);
-
-	hns_roce_write64(hr_dev, doorbell, hr_cq->cq_db_l);
+	notify_flag = (flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED ?
+		      V2_CQ_DB_REQ_NOT : V2_CQ_DB_REQ_NOT_SOL;
+
+	roce_set_field(cq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S, hr_cq->cqn);
+	roce_set_field(cq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
+		       HNS_ROCE_V2_CQ_DB_NOTIFY);
+	roce_set_field(cq_db.parameter, V2_CQ_DB_CONS_IDX_M,
+		       V2_CQ_DB_CONS_IDX_S, hr_cq->cons_index);
+	roce_set_field(cq_db.parameter, V2_CQ_DB_CMD_SN_M,
+		       V2_CQ_DB_CMD_SN_S, hr_cq->arm_sn);
+	roce_set_bit(cq_db.parameter, V2_CQ_DB_NOTIFY_TYPE_S, notify_flag);
+
+	hns_roce_write64(hr_dev, (__le32 *)&cq_db, hr_cq->db_reg);
 
 	return 0;
 }
@@ -3674,7 +3674,7 @@ static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
 	}
 
 	if (npolled)
-		hns_roce_v2_cq_set_ci(hr_cq, hr_cq->cons_index);
+		update_cq_db(hr_dev, hr_cq);
 
 out:
 	spin_unlock_irqrestore(&hr_cq->lock, flags);
@@ -5579,33 +5579,30 @@ static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 	queue_work(hr_dev->irq_workq, &(irq_work->work));
 }
 
-static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
+static void update_eq_db(struct hns_roce_eq *eq)
 {
 	struct hns_roce_dev *hr_dev = eq->hr_dev;
-	__le32 doorbell[2] = {};
+	struct hns_roce_v2_db eq_db = {};
 
 	if (eq->type_flag == HNS_ROCE_AEQ) {
-		roce_set_field(doorbell[0], HNS_ROCE_V2_EQ_DB_CMD_M,
-			       HNS_ROCE_V2_EQ_DB_CMD_S,
+		roce_set_field(eq_db.byte_4, V2_EQ_DB_CMD_M, V2_EQ_DB_CMD_S,
 			       eq->arm_st == HNS_ROCE_V2_EQ_ALWAYS_ARMED ?
 			       HNS_ROCE_EQ_DB_CMD_AEQ :
 			       HNS_ROCE_EQ_DB_CMD_AEQ_ARMED);
 	} else {
-		roce_set_field(doorbell[0], HNS_ROCE_V2_EQ_DB_TAG_M,
-			       HNS_ROCE_V2_EQ_DB_TAG_S, eq->eqn);
+		roce_set_field(eq_db.byte_4, V2_EQ_DB_TAG_M, V2_EQ_DB_TAG_S,
+			       eq->eqn);
 
-		roce_set_field(doorbell[0], HNS_ROCE_V2_EQ_DB_CMD_M,
-			       HNS_ROCE_V2_EQ_DB_CMD_S,
+		roce_set_field(eq_db.byte_4, V2_EQ_DB_CMD_M, V2_EQ_DB_CMD_S,
 			       eq->arm_st == HNS_ROCE_V2_EQ_ALWAYS_ARMED ?
 			       HNS_ROCE_EQ_DB_CMD_CEQ :
 			       HNS_ROCE_EQ_DB_CMD_CEQ_ARMED);
 	}
 
-	roce_set_field(doorbell[1], HNS_ROCE_V2_EQ_DB_PARA_M,
-		       HNS_ROCE_V2_EQ_DB_PARA_S,
-		       (eq->cons_index & HNS_ROCE_V2_CONS_IDX_M));
+	roce_set_field(eq_db.parameter, V2_EQ_DB_CONS_IDX_M,
+		       V2_EQ_DB_CONS_IDX_S, eq->cons_index);
 
-	hns_roce_write64(hr_dev, doorbell, eq->doorbell);
+	hns_roce_write64(hr_dev, (__le32 *)&eq_db, eq->db_reg);
 }
 
 static struct hns_roce_aeqe *next_aeqe_sw_v2(struct hns_roce_eq *eq)
@@ -5692,7 +5689,7 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		aeqe = next_aeqe_sw_v2(eq);
 	}
 
-	set_eq_cons_index_v2(eq);
+	update_eq_db(eq);
 	return aeqe_found;
 }
 
@@ -5732,7 +5729,7 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		ceqe = next_ceqe_sw_v2(eq);
 	}
 
-	set_eq_cons_index_v2(eq);
+	update_eq_db(eq);
 
 	return ceqe_found;
 }
@@ -5874,7 +5871,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	memset(eqc, 0, sizeof(struct hns_roce_eq_context));
 
 	/* init eqc */
-	eq->doorbell = hr_dev->reg_base + ROCEE_VF_EQ_DB_CFG0_REG;
+	eq->db_reg = hr_dev->reg_base + ROCEE_VF_EQ_DB_CFG0_REG;
 	eq->cons_index = 0;
 	eq->over_ignore = HNS_ROCE_V2_EQ_OVER_IGNORE_0;
 	eq->coalesce = HNS_ROCE_V2_EQ_COALESCE_0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ffdae15..5bb2ffb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -197,11 +197,11 @@ enum {
 };
 
 enum {
-	HNS_ROCE_V2_SQ_DB	= 0x0,
-	HNS_ROCE_V2_RQ_DB	= 0x1,
-	HNS_ROCE_V2_SRQ_DB	= 0x2,
-	HNS_ROCE_V2_CQ_DB_PTR	= 0x3,
-	HNS_ROCE_V2_CQ_DB_NTR	= 0x4,
+	HNS_ROCE_V2_SQ_DB,
+	HNS_ROCE_V2_RQ_DB,
+	HNS_ROCE_V2_SRQ_DB,
+	HNS_ROCE_V2_CQ_DB,
+	HNS_ROCE_V2_CQ_DB_NOTIFY
 };
 
 enum {
@@ -1132,33 +1132,27 @@ struct hns_roce_v2_mpt_entry {
 #define V2_MPT_BYTE_64_PBL_BUF_PG_SZ_S 28
 #define V2_MPT_BYTE_64_PBL_BUF_PG_SZ_M GENMASK(31, 28)
 
-#define	V2_DB_BYTE_4_TAG_S 0
-#define V2_DB_BYTE_4_TAG_M GENMASK(23, 0)
+#define V2_DB_TAG_S 0
+#define V2_DB_TAG_M GENMASK(23, 0)
 
-#define	V2_DB_BYTE_4_CMD_S 24
-#define V2_DB_BYTE_4_CMD_M GENMASK(27, 24)
+#define V2_DB_CMD_S 24
+#define V2_DB_CMD_M GENMASK(27, 24)
 
 #define V2_DB_FLAG_S 31
 
-#define V2_DB_PARAMETER_IDX_S 0
-#define V2_DB_PARAMETER_IDX_M GENMASK(15, 0)
+#define V2_DB_PRODUCER_IDX_S 0
+#define V2_DB_PRODUCER_IDX_M GENMASK(15, 0)
 
-#define V2_DB_PARAMETER_SL_S 16
-#define V2_DB_PARAMETER_SL_M GENMASK(18, 16)
+#define V2_DB_SL_S 16
+#define V2_DB_SL_M GENMASK(18, 16)
 
-#define	V2_CQ_DB_BYTE_4_TAG_S 0
-#define V2_CQ_DB_BYTE_4_TAG_M GENMASK(23, 0)
+#define V2_CQ_DB_CONS_IDX_S 0
+#define V2_CQ_DB_CONS_IDX_M GENMASK(23, 0)
 
-#define	V2_CQ_DB_BYTE_4_CMD_S 24
-#define V2_CQ_DB_BYTE_4_CMD_M GENMASK(27, 24)
+#define V2_CQ_DB_NOTIFY_TYPE_S 24
 
-#define V2_CQ_DB_PARAMETER_CONS_IDX_S 0
-#define V2_CQ_DB_PARAMETER_CONS_IDX_M GENMASK(23, 0)
-
-#define V2_CQ_DB_PARAMETER_CMD_SN_S 25
-#define V2_CQ_DB_PARAMETER_CMD_SN_M GENMASK(26, 25)
-
-#define V2_CQ_DB_PARAMETER_NOTIFY_S 24
+#define V2_CQ_DB_CMD_SN_S 25
+#define V2_CQ_DB_CMD_SN_M GENMASK(26, 25)
 
 struct hns_roce_v2_ud_send_wqe {
 	__le32	byte_4;
@@ -1984,8 +1978,6 @@ struct hns_roce_eq_context {
 #define HNS_ROCE_INT_NAME_LEN			32
 #define HNS_ROCE_V2_EQN_M GENMASK(23, 0)
 
-#define HNS_ROCE_V2_CONS_IDX_M GENMASK(23, 0)
-
 #define HNS_ROCE_V2_VF_ABN_INT_EN_S 0
 #define HNS_ROCE_V2_VF_ABN_INT_EN_M GENMASK(0, 0)
 #define HNS_ROCE_V2_VF_ABN_INT_ST_M GENMASK(2, 0)
@@ -2084,14 +2076,14 @@ struct hns_roce_eq_context {
 #define HNS_ROCE_V2_AEQE_SUB_TYPE_S 8
 #define HNS_ROCE_V2_AEQE_SUB_TYPE_M GENMASK(15, 8)
 
-#define HNS_ROCE_V2_EQ_DB_CMD_S	16
-#define HNS_ROCE_V2_EQ_DB_CMD_M	GENMASK(17, 16)
+#define V2_EQ_DB_TAG_S	0
+#define V2_EQ_DB_TAG_M	GENMASK(7, 0)
 
-#define HNS_ROCE_V2_EQ_DB_TAG_S	0
-#define HNS_ROCE_V2_EQ_DB_TAG_M	GENMASK(7, 0)
+#define V2_EQ_DB_CMD_S	16
+#define V2_EQ_DB_CMD_M	GENMASK(17, 16)
 
-#define HNS_ROCE_V2_EQ_DB_PARA_S 0
-#define HNS_ROCE_V2_EQ_DB_PARA_M GENMASK(23, 0)
+#define V2_EQ_DB_CONS_IDX_S 0
+#define V2_EQ_DB_CONS_IDX_M GENMASK(23, 0)
 
 #define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S 0
 #define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M GENMASK(23, 0)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 54f8566..268d460 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -850,15 +850,15 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		}
 	} else {
 		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
-			hr_qp->sq.db_reg_l = hr_dev->mem_base +
-					     HNS_ROCE_DWQE_SIZE * hr_qp->qpn;
+			hr_qp->sq.db_reg = hr_dev->mem_base +
+					   HNS_ROCE_DWQE_SIZE * hr_qp->qpn;
 		else
-			hr_qp->sq.db_reg_l =
+			hr_qp->sq.db_reg =
 				hr_dev->reg_base + hr_dev->sdb_offset +
 				DB_REG_OFFSET * hr_dev->priv_uar.index;
 
-		hr_qp->rq.db_reg_l = hr_dev->reg_base + hr_dev->odb_offset +
-				     DB_REG_OFFSET * hr_dev->priv_uar.index;
+		hr_qp->rq.db_reg = hr_dev->reg_base + hr_dev->odb_offset +
+				   DB_REG_OFFSET * hr_dev->priv_uar.index;
 
 		if (kernel_qp_has_rdb(hr_dev, init_attr)) {
 			ret = hns_roce_alloc_db(hr_dev, &hr_qp->rdb, 0);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index f71459a..546d182 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -415,7 +415,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 		}
 	}
 
-	srq->db_reg_l = hr_dev->reg_base + SRQ_DB_REG;
+	srq->db_reg = hr_dev->reg_base + SRQ_DB_REG;
 	srq->event = hns_roce_ib_srq_event;
 	atomic_set(&srq->refcount, 1);
 	init_completion(&srq->free);
-- 
2.8.1

