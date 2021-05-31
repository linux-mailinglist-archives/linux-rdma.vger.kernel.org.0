Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654AA395B08
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEaNBi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 09:01:38 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2918 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhEaNBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 09:01:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FtwKf4Y5Yz67XR;
        Mon, 31 May 2021 20:56:54 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 20:59:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 20:59:50 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 6/7] RDMA/hns: Use new interface to write DB related fields
Date:   Mon, 31 May 2021 20:59:33 +0800
Message-ID: <1622465974-20415-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
References: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Use hr_write_reg() instead of roce_set_field().

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 85 ++++++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 42 ++++++---------
 2 files changed, 49 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 047b27c..7cd0bc6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -639,17 +639,10 @@ static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 	} else {
 		struct hns_roce_v2_db sq_db = {};
 
-		roce_set_field(sq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
-			       qp->doorbell_qpn);
-		roce_set_field(sq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
-			       HNS_ROCE_V2_SQ_DB);
-
-		/* indicates data on new BAR, 0 : SQ doorbell, 1 : DWQE */
-		roce_set_bit(sq_db.byte_4, V2_DB_FLAG_S, 0);
-		roce_set_field(sq_db.parameter, V2_DB_PRODUCER_IDX_M,
-			       V2_DB_PRODUCER_IDX_S, qp->sq.head);
-		roce_set_field(sq_db.parameter, V2_DB_SL_M, V2_DB_SL_S,
-			       qp->sl);
+		hr_reg_write(&sq_db, DB_TAG, qp->doorbell_qpn);
+		hr_reg_write(&sq_db, DB_CMD, HNS_ROCE_V2_SQ_DB);
+		hr_reg_write(&sq_db, DB_PI, qp->sq.head);
+		hr_reg_write(&sq_db, DB_SL, qp->sl);
 
 		hns_roce_write64(hr_dev, (__le32 *)&sq_db, qp->sq.db_reg);
 	}
@@ -677,12 +670,9 @@ static inline void update_rq_db(struct hns_roce_dev *hr_dev,
 		} else {
 			struct hns_roce_v2_db rq_db = {};
 
-			roce_set_field(rq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
-				       qp->qpn);
-			roce_set_field(rq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
-				       HNS_ROCE_V2_RQ_DB);
-			roce_set_field(rq_db.parameter, V2_DB_PRODUCER_IDX_M,
-				       V2_DB_PRODUCER_IDX_S, qp->rq.head);
+			hr_reg_write(&rq_db, DB_TAG, qp->qpn);
+			hr_reg_write(&rq_db, DB_CMD, HNS_ROCE_V2_RQ_DB);
+			hr_reg_write(&rq_db, DB_PI, qp->rq.head);
 
 			hns_roce_write64(hr_dev, (__le32 *)&rq_db,
 					 qp->rq.db_reg);
@@ -999,6 +989,13 @@ static void fill_wqe_idx(struct hns_roce_srq *srq, unsigned int wqe_idx)
 	idx_que->head++;
 }
 
+static void update_srq_db(struct hns_roce_v2_db *db, struct hns_roce_srq *srq)
+{
+	hr_reg_write(db, DB_TAG, srq->srqn);
+	hr_reg_write(db, DB_CMD, HNS_ROCE_V2_SRQ_DB);
+	hr_reg_write(db, DB_PI, srq->idx_que.head);
+}
+
 static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 				     const struct ib_recv_wr *wr,
 				     const struct ib_recv_wr **bad_wr)
@@ -1036,12 +1033,7 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 	}
 
 	if (likely(nreq)) {
-		roce_set_field(srq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
-			       srq->srqn);
-		roce_set_field(srq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
-			       HNS_ROCE_V2_SRQ_DB);
-		roce_set_field(srq_db.parameter, V2_DB_PRODUCER_IDX_M,
-			       V2_DB_PRODUCER_IDX_S, srq->idx_que.head);
+		update_srq_db(&srq_db, srq);
 
 		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg);
 	}
@@ -3195,14 +3187,10 @@ static inline void update_cq_db(struct hns_roce_dev *hr_dev,
 	} else {
 		struct hns_roce_v2_db cq_db = {};
 
-		roce_set_field(cq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S,
-			       hr_cq->cqn);
-		roce_set_field(cq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
-			       HNS_ROCE_V2_CQ_DB);
-		roce_set_field(cq_db.parameter, V2_CQ_DB_CONS_IDX_M,
-			       V2_CQ_DB_CONS_IDX_S, hr_cq->cons_index);
-		roce_set_field(cq_db.parameter, V2_CQ_DB_CMD_SN_M,
-			       V2_CQ_DB_CMD_SN_S, 1);
+		hr_reg_write(&cq_db, DB_TAG, hr_cq->cqn);
+		hr_reg_write(&cq_db, DB_CMD, HNS_ROCE_V2_CQ_DB);
+		hr_reg_write(&cq_db, DB_CQ_CI, hr_cq->cons_index);
+		hr_reg_write(&cq_db, DB_CQ_CMD_SN, 1);
 
 		hns_roce_write64(hr_dev, (__le32 *)&cq_db, hr_cq->db_reg);
 	}
@@ -3323,14 +3311,11 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 	notify_flag = (flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED ?
 		      V2_CQ_DB_REQ_NOT : V2_CQ_DB_REQ_NOT_SOL;
 
-	roce_set_field(cq_db.byte_4, V2_DB_TAG_M, V2_DB_TAG_S, hr_cq->cqn);
-	roce_set_field(cq_db.byte_4, V2_DB_CMD_M, V2_DB_CMD_S,
-		       HNS_ROCE_V2_CQ_DB_NOTIFY);
-	roce_set_field(cq_db.parameter, V2_CQ_DB_CONS_IDX_M,
-		       V2_CQ_DB_CONS_IDX_S, hr_cq->cons_index);
-	roce_set_field(cq_db.parameter, V2_CQ_DB_CMD_SN_M,
-		       V2_CQ_DB_CMD_SN_S, hr_cq->arm_sn);
-	roce_set_bit(cq_db.parameter, V2_CQ_DB_NOTIFY_TYPE_S, notify_flag);
+	hr_reg_write(&cq_db, DB_TAG, hr_cq->cqn);
+	hr_reg_write(&cq_db, DB_CMD, HNS_ROCE_V2_CQ_DB_NOTIFY);
+	hr_reg_write(&cq_db, DB_CQ_CI, hr_cq->cons_index);
+	hr_reg_write(&cq_db, DB_CQ_CMD_SN, hr_cq->arm_sn);
+	hr_reg_write(&cq_db, DB_CQ_NOTIFY, notify_flag);
 
 	hns_roce_write64(hr_dev, (__le32 *)&cq_db, hr_cq->db_reg);
 
@@ -5545,22 +5530,20 @@ static void update_eq_db(struct hns_roce_eq *eq)
 	struct hns_roce_v2_db eq_db = {};
 
 	if (eq->type_flag == HNS_ROCE_AEQ) {
-		roce_set_field(eq_db.byte_4, V2_EQ_DB_CMD_M, V2_EQ_DB_CMD_S,
-			       eq->arm_st == HNS_ROCE_V2_EQ_ALWAYS_ARMED ?
-			       HNS_ROCE_EQ_DB_CMD_AEQ :
-			       HNS_ROCE_EQ_DB_CMD_AEQ_ARMED);
+		hr_reg_write(&eq_db, EQ_DB_CMD,
+			     eq->arm_st == HNS_ROCE_V2_EQ_ALWAYS_ARMED ?
+			     HNS_ROCE_EQ_DB_CMD_AEQ :
+			     HNS_ROCE_EQ_DB_CMD_AEQ_ARMED);
 	} else {
-		roce_set_field(eq_db.byte_4, V2_EQ_DB_TAG_M, V2_EQ_DB_TAG_S,
-			       eq->eqn);
+		hr_reg_write(&eq_db, EQ_DB_TAG, eq->eqn);
 
-		roce_set_field(eq_db.byte_4, V2_EQ_DB_CMD_M, V2_EQ_DB_CMD_S,
-			       eq->arm_st == HNS_ROCE_V2_EQ_ALWAYS_ARMED ?
-			       HNS_ROCE_EQ_DB_CMD_CEQ :
-			       HNS_ROCE_EQ_DB_CMD_CEQ_ARMED);
+		hr_reg_write(&eq_db, EQ_DB_CMD,
+			     eq->arm_st == HNS_ROCE_V2_EQ_ALWAYS_ARMED ?
+			     HNS_ROCE_EQ_DB_CMD_CEQ :
+			     HNS_ROCE_EQ_DB_CMD_CEQ_ARMED);
 	}
 
-	roce_set_field(eq_db.parameter, V2_EQ_DB_CONS_IDX_M,
-		       V2_EQ_DB_CONS_IDX_S, eq->cons_index);
+	hr_reg_write(&eq_db, EQ_DB_CI, eq->cons_index);
 
 	hns_roce_write64(hr_dev, (__le32 *)&eq_db, eq->db_reg);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 8387756..19f5f87 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -943,28 +943,30 @@ struct hns_roce_v2_mpt_entry {
 #define V2_MPT_BYTE_64_PBL_BUF_PG_SZ_S 28
 #define V2_MPT_BYTE_64_PBL_BUF_PG_SZ_M GENMASK(31, 28)
 
-#define V2_DB_TAG_S 0
-#define V2_DB_TAG_M GENMASK(23, 0)
+struct hns_roce_v2_db {
+	__le32	data[2];
+};
 
-#define V2_DB_CMD_S 24
-#define V2_DB_CMD_M GENMASK(27, 24)
+#define DB_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_db, h, l)
 
-#define V2_DB_FLAG_S 31
+#define DB_TAG DB_FIELD_LOC(23, 0)
+#define DB_CMD DB_FIELD_LOC(27, 24)
+#define DB_FLAG DB_FIELD_LOC(31, 31)
+#define DB_PI DB_FIELD_LOC(47, 32)
+#define DB_SL DB_FIELD_LOC(50, 48)
+#define DB_CQ_CI DB_FIELD_LOC(55, 32)
+#define DB_CQ_NOTIFY DB_FIELD_LOC(56, 56)
+#define DB_CQ_CMD_SN DB_FIELD_LOC(58, 57)
+#define EQ_DB_TAG DB_FIELD_LOC(7, 0)
+#define EQ_DB_CMD DB_FIELD_LOC(17, 16)
+#define EQ_DB_CI DB_FIELD_LOC(55, 32)
 
 #define V2_DB_PRODUCER_IDX_S 0
 #define V2_DB_PRODUCER_IDX_M GENMASK(15, 0)
 
-#define V2_DB_SL_S 16
-#define V2_DB_SL_M GENMASK(18, 16)
-
 #define V2_CQ_DB_CONS_IDX_S 0
 #define V2_CQ_DB_CONS_IDX_M GENMASK(23, 0)
 
-#define V2_CQ_DB_NOTIFY_TYPE_S 24
-
-#define V2_CQ_DB_CMD_SN_S 25
-#define V2_CQ_DB_CMD_SN_M GENMASK(26, 25)
-
 struct hns_roce_v2_ud_send_wqe {
 	__le32	byte_4;
 	__le32	msg_len;
@@ -1099,11 +1101,6 @@ struct hns_roce_v2_wqe_data_seg {
 	__le64    addr;
 };
 
-struct hns_roce_v2_db {
-	__le32	byte_4;
-	__le32	parameter;
-};
-
 struct hns_roce_query_version {
 	__le16 rocee_vendor_id;
 	__le16 rocee_hw_version;
@@ -1627,15 +1624,6 @@ struct hns_roce_dip {
 #define HNS_ROCE_V2_AEQE_SUB_TYPE_S 8
 #define HNS_ROCE_V2_AEQE_SUB_TYPE_M GENMASK(15, 8)
 
-#define V2_EQ_DB_TAG_S	0
-#define V2_EQ_DB_TAG_M	GENMASK(7, 0)
-
-#define V2_EQ_DB_CMD_S	16
-#define V2_EQ_DB_CMD_M	GENMASK(17, 16)
-
-#define V2_EQ_DB_CONS_IDX_S 0
-#define V2_EQ_DB_CONS_IDX_M GENMASK(23, 0)
-
 #define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_S 0
 #define HNS_ROCE_V2_AEQE_EVENT_QUEUE_NUM_M GENMASK(23, 0)
 
-- 
2.7.4

