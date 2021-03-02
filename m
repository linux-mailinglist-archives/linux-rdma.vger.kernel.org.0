Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE932A840
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579805AbhCBRJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:09:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13415 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447196AbhCBMvZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 07:51:25 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DqcQJ1sH5zjTWl;
        Tue,  2 Mar 2021 20:49:12 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:50:32 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next] RDMA/hns: Add support for XRC on HIP09
Date:   Tue, 2 Mar 2021 20:48:18 +0800
Message-ID: <1614689298-13601-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The HIP09 supports XRC transport service, it greatly saves the number of
QPs required to connect all processes in a large cluster.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_alloc.c  |   3 +
 drivers/infiniband/hw/hns/hns_roce_device.h |  25 +++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 147 +++++++++++++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
 drivers/infiniband/hw/hns/hns_roce_main.c   |  32 +++++-
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  51 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  63 ++++++++----
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   3 +
 include/uapi/rdma/hns-abi.h                 |   2 +
 9 files changed, 258 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 4bcaaa05..5d389ed 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -304,6 +304,9 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev, dma_addr_t *bufs,
 
 void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 {
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
+		hns_roce_cleanup_xrcd_table(hr_dev);
+
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
 		hns_roce_cleanup_srq_table(hr_dev);
 	hns_roce_cleanup_qp_table(hr_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 3d6b7a2d..f74db0f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -137,6 +137,7 @@ enum {
 	SERV_TYPE_UC,
 	SERV_TYPE_RD,
 	SERV_TYPE_UD,
+	SERV_TYPE_XRC = 5,
 };
 
 enum hns_roce_qp_state {
@@ -168,6 +169,8 @@ enum hns_roce_event {
 	HNS_ROCE_EVENT_TYPE_DB_OVERFLOW               = 0x12,
 	HNS_ROCE_EVENT_TYPE_MB                        = 0x13,
 	HNS_ROCE_EVENT_TYPE_FLR			      = 0x15,
+	HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION	      = 0x16,
+	HNS_ROCE_EVENT_TYPE_INVALID_XRCETH	      = 0x17,
 };
 
 #define HNS_ROCE_CAP_FLAGS_EX_SHIFT 12
@@ -179,6 +182,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_RECORD_DB		= BIT(3),
 	HNS_ROCE_CAP_FLAG_SQ_RECORD_DB		= BIT(4),
 	HNS_ROCE_CAP_FLAG_SRQ			= BIT(5),
+	HNS_ROCE_CAP_FLAG_XRC			= BIT(6),
 	HNS_ROCE_CAP_FLAG_MW			= BIT(7),
 	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
@@ -244,6 +248,11 @@ struct hns_roce_pd {
 	unsigned long		pdn;
 };
 
+struct hns_roce_xrcd {
+	struct ib_xrcd		ibxrcd;
+	unsigned long		xrcdn;
+};
+
 struct hns_roce_bitmap {
 	/* Bitmap Traversal last a bit which is 1 */
 	unsigned long		last;
@@ -467,6 +476,7 @@ struct hns_roce_srq {
 	u32			rsv_sge;
 	int			wqe_shift;
 	u32			cqn;
+	u32			xrcdn;
 	void __iomem		*db_reg_l;
 
 	atomic_t		refcount;
@@ -640,6 +650,8 @@ struct hns_roce_qp {
 					 enum hns_roce_event event_type);
 	unsigned long		qpn;
 
+	unsigned long		xrcdn;
+
 	atomic_t		refcount;
 	struct completion	free;
 
@@ -766,6 +778,8 @@ struct hns_roce_caps {
 	int		reserved_uars;
 	int		num_pds;
 	int		reserved_pds;
+	int		num_xrcds;
+	int		reserved_xrcds;
 	u32		mtt_entry_sz;
 	u32		cqe_sz;
 	u32		page_size_cap;
@@ -963,6 +977,7 @@ struct hns_roce_dev {
 
 	struct hns_roce_cmdq	cmd;
 	struct hns_roce_bitmap    pd_bitmap;
+	struct hns_roce_bitmap xrcd_bitmap;
 	struct hns_roce_uar_table uar_table;
 	struct hns_roce_mr_table  mr_table;
 	struct hns_roce_cq_table  cq_table;
@@ -1004,6 +1019,11 @@ static inline struct hns_roce_pd *to_hr_pd(struct ib_pd *ibpd)
 	return container_of(ibpd, struct hns_roce_pd, ibpd);
 }
 
+static inline struct hns_roce_xrcd *to_hr_xrcd(struct ib_xrcd *ibxrcd)
+{
+	return container_of(ibxrcd, struct hns_roce_xrcd, ibxrcd);
+}
+
 static inline struct hns_roce_ah *to_hr_ah(struct ib_ah *ibah)
 {
 	return container_of(ibah, struct hns_roce_ah, ibah);
@@ -1136,6 +1156,7 @@ int hns_roce_init_mr_table(struct hns_roce_dev *hr_dev);
 void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev);
 int hns_roce_init_srq_table(struct hns_roce_dev *hr_dev);
+int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev);
 
 void hns_roce_cleanup_pd_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_mr_table(struct hns_roce_dev *hr_dev);
@@ -1143,6 +1164,7 @@ void hns_roce_cleanup_eq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev);
 void hns_roce_cleanup_srq_table(struct hns_roce_dev *hr_dev);
+void hns_roce_cleanup_xrcd_table(struct hns_roce_dev *hr_dev);
 
 int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj);
 void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
@@ -1207,6 +1229,9 @@ int hns_roce_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr,
 			struct ib_udata *udata);
 int hns_roce_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata);
 
+int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata);
+int hns_roce_dealloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata);
+
 struct ib_qp *hns_roce_create_qp(struct ib_pd *ib_pd,
 				 struct ib_qp_init_attr *init_attr,
 				 struct ib_udata *udata);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c3934ab..593acf1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1829,6 +1829,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->num_srqwqe_segs	= HNS_ROCE_V2_MAX_SRQWQE_SEGS;
 	caps->num_idx_segs	= HNS_ROCE_V2_MAX_IDX_SEGS;
 	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
+	caps->num_xrcds		= HNS_ROCE_V2_MAX_XRCD_NUM;
 	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
 	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
@@ -1846,6 +1847,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
 	caps->reserved_lkey	= 0;
 	caps->reserved_pds	= 0;
+	caps->reserved_xrcds	= HNS_ROCE_V2_RSV_XRCD_NUM;
 	caps->reserved_mrws	= 1;
 	caps->reserved_uars	= 0;
 	caps->reserved_cqs	= 0;
@@ -1900,7 +1902,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 
 	caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
 		       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
-		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
+		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL | HNS_ROCE_CAP_FLAG_XRC;
 
 	caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
 	caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
@@ -2131,6 +2133,8 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->num_mtt_segs = HNS_ROCE_V2_MAX_MTT_SEGS;
 	caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
 	caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
+	caps->num_xrcds = HNS_ROCE_V2_MAX_XRCD_NUM;
+	caps->reserved_xrcds = HNS_ROCE_V2_RSV_XRCD_NUM;
 	caps->mtt_ba_pg_sz = 0;
 	caps->num_cqe_segs = HNS_ROCE_V2_MAX_CQE_SEGS;
 	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
@@ -3909,6 +3913,16 @@ static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 		       ilog2(hr_qp->rq.wqe_cnt));
 }
 
+static inline int get_cqn(struct ib_cq *ib_cq)
+{
+	return ib_cq ? to_hr_cq(ib_cq)->cqn : 0;
+}
+
+static inline int get_pdn(struct ib_pd *ib_pd)
+{
+	return ib_pd ? to_hr_pd(ib_pd)->pdn : 0;
+}
+
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 				    const struct ib_qp_attr *attr,
 				    int attr_mask,
@@ -3925,13 +3939,13 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	 * 0 at the same time, else set them to 0x1.
 	 */
 	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
-		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(hr_qp->ibqp.qp_type));
+		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(ibqp->qp_type));
 
 	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
 		       V2_QPC_BYTE_4_SQPN_S, hr_qp->qpn);
 
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-		       V2_QPC_BYTE_16_PD_S, to_hr_pd(ibqp->pd)->pdn);
+		       V2_QPC_BYTE_16_PD_S, get_pdn(ibqp->pd));
 
 	roce_set_field(context->byte_20_smac_sgid_idx, V2_QPC_BYTE_20_RQWS_M,
 		       V2_QPC_BYTE_20_RQWS_S, ilog2(hr_qp->rq.max_gs));
@@ -3942,6 +3956,9 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
 		       V2_QPC_BYTE_24_VLAN_ID_S, 0xfff);
 
+	if (ibqp->qp_type == IB_QPT_XRC_TGT)
+		context->qkey_xrcd = cpu_to_le32(hr_qp->xrcdn);
+
 	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
 		roce_set_bit(context->byte_68_rq_db,
 			     V2_QPC_BYTE_68_RQ_RECORD_EN_S, 1);
@@ -3956,19 +3973,20 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 		    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) ? 1 : 0);
 
 	roce_set_field(context->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
-		       V2_QPC_BYTE_80_RX_CQN_S, to_hr_cq(ibqp->recv_cq)->cqn);
+		       V2_QPC_BYTE_80_RX_CQN_S, get_cqn(ibqp->recv_cq));
+
 	if (ibqp->srq) {
+		roce_set_bit(context->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
 		roce_set_field(context->byte_76_srqn_op_en,
 			       V2_QPC_BYTE_76_SRQN_M, V2_QPC_BYTE_76_SRQN_S,
 			       to_hr_srq(ibqp->srq)->srqn);
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
 	}
 
 	roce_set_bit(context->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 1);
 
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
-		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
+		       V2_QPC_BYTE_252_TX_CQN_S, get_cqn(ibqp->send_cq));
 
 	if (hr_dev->caps.qpc_sz < HNS_ROCE_V3_QPC_SZ)
 		return;
@@ -3991,22 +4009,28 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	 * 0 at the same time, else set them to 0x1.
 	 */
 	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
-		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(hr_qp->ibqp.qp_type));
+		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(ibqp->qp_type));
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
 		       V2_QPC_BYTE_4_TST_S, 0);
 
+	if (ibqp->qp_type == IB_QPT_XRC_TGT) {
+		context->qkey_xrcd = cpu_to_le32(hr_qp->xrcdn);
+		qpc_mask->qkey_xrcd = 0;
+	}
+
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-		       V2_QPC_BYTE_16_PD_S, to_hr_pd(ibqp->pd)->pdn);
+		       V2_QPC_BYTE_16_PD_S, get_pdn(ibqp->pd));
+
 	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
 		       V2_QPC_BYTE_16_PD_S, 0);
 
 	roce_set_field(context->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
-		       V2_QPC_BYTE_80_RX_CQN_S, to_hr_cq(ibqp->recv_cq)->cqn);
+		       V2_QPC_BYTE_80_RX_CQN_S, get_cqn(ibqp->recv_cq));
 	roce_set_field(qpc_mask->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
 		       V2_QPC_BYTE_80_RX_CQN_S, 0);
 
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
-		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
+		       V2_QPC_BYTE_252_TX_CQN_S, get_cqn(ibqp->send_cq));
 	roce_set_field(qpc_mask->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
 		       V2_QPC_BYTE_252_TX_CQN_S, 0);
 
@@ -4685,7 +4709,6 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 			       V2_QPC_BYTE_244_RNR_CNT_S, 0);
 	}
 
-	/* RC&UC&UD required attr */
 	if (attr_mask & IB_QP_SQ_PSN) {
 		roce_set_field(context->byte_172_sq_psn,
 			       V2_QPC_BYTE_172_SQ_CUR_PSN_M,
@@ -4763,7 +4786,6 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 			       V2_QPC_BYTE_80_MIN_RNR_TIME_S, 0);
 	}
 
-	/* RC&UC required attr */
 	if (attr_mask & IB_QP_RQ_PSN) {
 		roce_set_field(context->byte_108_rx_reqepsn,
 			       V2_QPC_BYTE_108_RX_REQ_EPSN_M,
@@ -4806,6 +4828,29 @@ static void hns_roce_v2_record_opt_fields(struct ib_qp *ibqp,
 	}
 }
 
+static void clear_qp(struct hns_roce_qp *hr_qp)
+{
+	struct ib_qp *ibqp = &hr_qp->ibqp;
+
+	if (ibqp->send_cq)
+		hns_roce_v2_cq_clean(to_hr_cq(ibqp->send_cq),
+				     hr_qp->qpn, NULL);
+
+	if (ibqp->recv_cq  && ibqp->recv_cq != ibqp->send_cq)
+		hns_roce_v2_cq_clean(to_hr_cq(ibqp->recv_cq),
+				     hr_qp->qpn, ibqp->srq ?
+				     to_hr_srq(ibqp->srq) : NULL);
+
+	if (hr_qp->rq.wqe_cnt)
+		*hr_qp->rdb.db_record = 0;
+
+	hr_qp->rq.head = 0;
+	hr_qp->rq.tail = 0;
+	hr_qp->sq.head = 0;
+	hr_qp->sq.tail = 0;
+	hr_qp->next_sge = 0;
+}
+
 static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr,
 				 int attr_mask, enum ib_qp_state cur_state,
@@ -4840,19 +4885,23 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 
 	/* When QP state is err, SQ and RQ WQE should be flushed */
 	if (new_state == IB_QPS_ERR) {
-		spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
-		hr_qp->state = IB_QPS_ERR;
-		roce_set_field(context->byte_160_sq_ci_pi,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
-			       hr_qp->sq.head);
-		roce_set_field(qpc_mask->byte_160_sq_ci_pi,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
-		spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
-
-		if (!ibqp->srq) {
+		if (ibqp->qp_type != IB_QPT_XRC_TGT) {
+			spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
+			hr_qp->state = IB_QPS_ERR;
+			roce_set_field(context->byte_160_sq_ci_pi,
+				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
+				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
+				       hr_qp->sq.head);
+			roce_set_field(qpc_mask->byte_160_sq_ci_pi,
+				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
+				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
+			spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
+		}
+
+		if (!ibqp->srq && ibqp->qp_type != IB_QPT_XRC_INI &&
+		    ibqp->qp_type != IB_QPT_XRC_TGT) {
 			spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
+			hr_qp->state = IB_QPS_ERR;
 			roce_set_field(context->byte_84_rq_ci_pi,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
 			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
@@ -4871,7 +4920,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		goto out;
 
 	roce_set_bit(context->byte_108_rx_reqepsn, V2_QPC_BYTE_108_INV_CREDIT_S,
-		     ibqp->srq ? 1 : 0);
+		     ((to_hr_qp_type(hr_qp->ibqp.qp_type) == SERV_TYPE_XRC) ||
+		     ibqp->srq) ? 1 : 0);
 	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
 		     V2_QPC_BYTE_108_INV_CREDIT_S, 0);
 
@@ -4892,21 +4942,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 
 	hns_roce_v2_record_opt_fields(ibqp, attr, attr_mask);
 
-	if (new_state == IB_QPS_RESET && !ibqp->uobject) {
-		hns_roce_v2_cq_clean(to_hr_cq(ibqp->recv_cq), hr_qp->qpn,
-				     ibqp->srq ? to_hr_srq(ibqp->srq) : NULL);
-		if (ibqp->send_cq != ibqp->recv_cq)
-			hns_roce_v2_cq_clean(to_hr_cq(ibqp->send_cq),
-					     hr_qp->qpn, NULL);
-
-		hr_qp->rq.head = 0;
-		hr_qp->rq.tail = 0;
-		hr_qp->sq.head = 0;
-		hr_qp->sq.tail = 0;
-		hr_qp->next_sge = 0;
-		if (hr_qp->rq.wqe_cnt)
-			*hr_qp->rdb.db_record = 0;
-	}
+	if (new_state == IB_QPS_RESET && !ibqp->uobject)
+		clear_qp(hr_qp);
 
 out:
 	return ret;
@@ -5017,7 +5054,9 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 				    V2_QPC_BYTE_76_ATE_S)) << V2_QP_ATE_S);
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC ||
-	    hr_qp->ibqp.qp_type == IB_QPT_UC) {
+	    hr_qp->ibqp.qp_type == IB_QPT_UC ||
+	    hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
+	    hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT) {
 		struct ib_global_route *grh =
 				rdma_ah_retrieve_grh(&qp_attr->ah_attr);
 
@@ -5049,6 +5088,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->max_dest_rd_atomic = 1 << roce_get_field(context.byte_140_raq,
 						     V2_QPC_BYTE_140_RR_MAX_M,
 						     V2_QPC_BYTE_140_RR_MAX_S);
+
 	qp_attr->min_rnr_timer = (u8)roce_get_field(context.byte_80_rnr_rx_cqn,
 						 V2_QPC_BYTE_80_MIN_RNR_TIME_M,
 						 V2_QPC_BYTE_80_MIN_RNR_TIME_S);
@@ -5083,6 +5123,15 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	return ret;
 }
 
+static inline int modify_qp_is_ok(struct hns_roce_qp *hr_qp)
+{
+	return ((hr_qp->ibqp.qp_type == IB_QPT_RC ||
+		 hr_qp->ibqp.qp_type == IB_QPT_UD ||
+		 hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
+		 hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT) &&
+		hr_qp->state != IB_QPS_RESET);
+}
+
 static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 					 struct hns_roce_qp *hr_qp,
 					 struct ib_udata *udata)
@@ -5092,9 +5141,7 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	unsigned long flags;
 	int ret = 0;
 
-	if ((hr_qp->ibqp.qp_type == IB_QPT_RC ||
-	     hr_qp->ibqp.qp_type == IB_QPT_UD) &&
-	   hr_qp->state != IB_QPS_RESET) {
+	if (modify_qp_is_ok(hr_qp)) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
@@ -5275,7 +5322,7 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
 	hr_reg_write(ctx, SRQC_PD, to_hr_pd(srq->ibsrq.pd)->pdn);
 	hr_reg_write(ctx, SRQC_SRQN, srq->srqn);
-	hr_reg_write(ctx, SRQC_XRCD, 0);
+	hr_reg_write(ctx, SRQC_XRCD, srq->xrcdn);
 	hr_reg_write(ctx, SRQC_XRC_CQN, srq->cqn);
 	hr_reg_write(ctx, SRQC_SHIFT, ilog2(srq->wqe_cnt));
 	hr_reg_write(ctx, SRQC_RQWS,
@@ -5479,6 +5526,12 @@ static void hns_roce_irq_work_handle(struct work_struct *work)
 	case HNS_ROCE_EVENT_TYPE_FLR:
 		ibdev_warn(ibdev, "Function level reset.\n");
 		break;
+	case HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION:
+		ibdev_err(ibdev, "xrc domain violation error.\n");
+		break;
+	case HNS_ROCE_EVENT_TYPE_INVALID_XRCETH:
+		ibdev_err(ibdev, "invalid xrceth error.\n");
+		break;
 	default:
 		break;
 	}
@@ -5579,6 +5632,8 @@ static int hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		case HNS_ROCE_EVENT_TYPE_SRQ_LAST_WQE_REACH:
 		case HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR:
 		case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
+		case HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION:
+		case HNS_ROCE_EVENT_TYPE_INVALID_XRCETH:
 			hns_roce_qp_event(hr_dev, queue_num, event_type);
 			break;
 		case HNS_ROCE_EVENT_TYPE_SRQ_LIMIT_REACH:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 39621fb..ffdae15 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -74,6 +74,8 @@
 #define HNS_ROCE_V2_MAX_SRQWQE_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_IDX_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_PD_NUM			0x1000000
+#define HNS_ROCE_V2_MAX_XRCD_NUM		0x1000000
+#define HNS_ROCE_V2_RSV_XRCD_NUM		0
 #define HNS_ROCE_V2_MAX_QP_INIT_RDMA		128
 #define HNS_ROCE_V2_MAX_QP_DEST_RDMA		128
 #define HNS_ROCE_V2_MAX_SQ_DESC_SZ		64
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index c9c0836..1a747f7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -207,6 +207,9 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 		props->max_fast_reg_page_list_len = HNS_ROCE_FRMR_MAX_PA;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
+		props->device_cap_flags |= IB_DEVICE_XRC;
+
 	return 0;
 }
 
@@ -300,6 +303,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		return -EAGAIN;
 
 	resp.qp_tab_size = hr_dev->caps.num_qps;
+	resp.srq_tab_size = hr_dev->caps.num_srqs;
 
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
@@ -461,6 +465,13 @@ static const struct ib_device_ops hns_roce_dev_srq_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_srq, hns_roce_srq, ibsrq),
 };
 
+static const struct ib_device_ops hns_roce_dev_xrcd_ops = {
+	.alloc_xrcd = hns_roce_alloc_xrcd,
+	.dealloc_xrcd = hns_roce_dealloc_xrcd,
+
+	INIT_RDMA_OBJ_SIZE(ib_xrcd, hns_roce_xrcd, ibxrcd),
+};
+
 static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 {
 	int ret;
@@ -484,20 +495,20 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR)
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
 
-	/* MW */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_MW)
 		ib_set_device_ops(ib_dev, &hns_roce_dev_mw_ops);
 
-	/* FRMR */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_FRMR)
 		ib_set_device_ops(ib_dev, &hns_roce_dev_frmr_ops);
 
-	/* SRQ */
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ib_set_device_ops(ib_dev, &hns_roce_dev_srq_ops);
 		ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_srq_ops);
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
+		ib_set_device_ops(ib_dev, &hns_roce_dev_xrcd_ops);
+
 	ib_set_device_ops(ib_dev, hr_dev->hw->hns_roce_dev_ops);
 	ib_set_device_ops(ib_dev, &hns_roce_dev_ops);
 	for (i = 0; i < hr_dev->caps.num_ports; i++) {
@@ -727,10 +738,19 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 		goto err_uar_alloc_free;
 	}
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC) {
+		ret = hns_roce_init_xrcd_table(hr_dev);
+		if (ret) {
+			dev_err(dev, "failed to init xrcd table, ret = %d.\n",
+				ret);
+			goto err_pd_table_free;
+		}
+	}
+
 	ret = hns_roce_init_mr_table(hr_dev);
 	if (ret) {
 		dev_err(dev, "Failed to init memory region table.\n");
-		goto err_pd_table_free;
+		goto err_xrcd_table_free;
 	}
 
 	hns_roce_init_cq_table(hr_dev);
@@ -759,6 +779,10 @@ static int hns_roce_setup_hca(struct hns_roce_dev *hr_dev)
 	hns_roce_cleanup_cq_table(hr_dev);
 	hns_roce_cleanup_mr_table(hr_dev);
 
+err_xrcd_table_free:
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
+		hns_roce_cleanup_xrcd_table(hr_dev);
+
 err_pd_table_free:
 	hns_roce_cleanup_pd_table(hr_dev);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index cca818d..9dbd21a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -137,3 +137,54 @@ void hns_roce_cleanup_uar_table(struct hns_roce_dev *hr_dev)
 {
 	hns_roce_bitmap_cleanup(&hr_dev->uar_table.bitmap);
 }
+
+static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev,
+			       unsigned long *xrcdn)
+{
+	return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap, xrcdn);
+}
+
+static void hns_roce_xrcd_free(struct hns_roce_dev *hr_dev,
+			       unsigned long xrcdn)
+{
+	hns_roce_bitmap_free(&hr_dev->xrcd_bitmap, xrcdn, BITMAP_NO_RR);
+}
+
+int hns_roce_init_xrcd_table(struct hns_roce_dev *hr_dev)
+{
+	return hns_roce_bitmap_init(&hr_dev->xrcd_bitmap,
+				    hr_dev->caps.num_xrcds,
+				    hr_dev->caps.num_xrcds - 1,
+				    hr_dev->caps.reserved_xrcds, 0);
+}
+
+void hns_roce_cleanup_xrcd_table(struct hns_roce_dev *hr_dev)
+{
+	hns_roce_bitmap_cleanup(&hr_dev->xrcd_bitmap);
+}
+
+int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ib_xrcd->device);
+	struct hns_roce_xrcd *xrcd = to_hr_xrcd(ib_xrcd);
+	int ret;
+
+	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC))
+		return -EINVAL;
+
+	ret = hns_roce_xrcd_alloc(hr_dev, &xrcd->xrcdn);
+	if (ret) {
+		dev_err(hr_dev->dev, "failed to alloc xrcdn, ret = %d.\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int hns_roce_dealloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
+{
+	hns_roce_xrcd_free(to_hr_dev(ib_xrcd->device),
+			   to_hr_xrcd(ib_xrcd)->xrcdn);
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 004aca9..9169225 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -98,7 +98,9 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 	if (hr_dev->hw_rev != HNS_ROCE_HW_VER1 &&
 	    (event_type == HNS_ROCE_EVENT_TYPE_WQ_CATAS_ERROR ||
 	     event_type == HNS_ROCE_EVENT_TYPE_INV_REQ_LOCAL_WQ_ERROR ||
-	     event_type == HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR)) {
+	     event_type == HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR ||
+	     event_type == HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION ||
+	     event_type == HNS_ROCE_EVENT_TYPE_INVALID_XRCETH)) {
 		qp->state = IB_QPS_ERR;
 		if (!test_and_set_bit(HNS_ROCE_FLUSH_FLAG, &qp->flush_flag))
 			init_flush_work(hr_dev, qp);
@@ -142,6 +144,8 @@ static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 			event.event = IB_EVENT_QP_REQ_ERR;
 			break;
 		case HNS_ROCE_EVENT_TYPE_LOCAL_WQ_ACCESS_ERROR:
+		case HNS_ROCE_EVENT_TYPE_XRCD_VIOLATION:
+		case HNS_ROCE_EVENT_TYPE_INVALID_XRCETH:
 			event.event = IB_EVENT_QP_ACCESS_ERR;
 			break;
 		default:
@@ -366,8 +370,13 @@ void hns_roce_qp_remove(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	unsigned long flags;
 
 	list_del(&hr_qp->node);
-	list_del(&hr_qp->sq_node);
-	list_del(&hr_qp->rq_node);
+
+	if (hr_qp->ibqp.qp_type != IB_QPT_XRC_TGT)
+		list_del(&hr_qp->sq_node);
+
+	if (hr_qp->ibqp.qp_type != IB_QPT_XRC_INI &&
+	    hr_qp->ibqp.qp_type != IB_QPT_XRC_TGT)
+		list_del(&hr_qp->rq_node);
 
 	xa_lock_irqsave(xa, flags);
 	__xa_erase(xa, hr_qp->qpn & (hr_dev->caps.num_qps - 1));
@@ -1100,11 +1109,16 @@ static int check_qp_type(struct hns_roce_dev *hr_dev, enum ib_qp_type type,
 			 bool is_user)
 {
 	switch (type) {
+	case IB_QPT_XRC_INI:
+	case IB_QPT_XRC_TGT:
+		if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC))
+			goto out;
+		break;
 	case IB_QPT_UD:
 		if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 &&
 		    is_user)
 			goto out;
-		fallthrough;
+		break;
 	case IB_QPT_RC:
 	case IB_QPT_GSI:
 		break;
@@ -1124,8 +1138,8 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 				 struct ib_qp_init_attr *init_attr,
 				 struct ib_udata *udata)
 {
-	struct hns_roce_dev *hr_dev = to_hr_dev(pd->device);
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct ib_device *ibdev = pd ? pd->device : init_attr->xrcd->device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
 	struct hns_roce_qp *hr_qp;
 	int ret;
 
@@ -1137,6 +1151,15 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	if (!hr_qp)
 		return ERR_PTR(-ENOMEM);
 
+	if (init_attr->qp_type == IB_QPT_XRC_INI)
+		init_attr->recv_cq = NULL;
+
+	if (init_attr->qp_type == IB_QPT_XRC_TGT) {
+		hr_qp->xrcdn = to_hr_xrcd(init_attr->xrcd)->xrcdn;
+		init_attr->recv_cq = NULL;
+		init_attr->send_cq = NULL;
+	}
+
 	if (init_attr->qp_type == IB_QPT_GSI) {
 		hr_qp->port = init_attr->port_num - 1;
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
@@ -1156,20 +1179,20 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 
 int to_hr_qp_type(int qp_type)
 {
-	int transport_type;
-
-	if (qp_type == IB_QPT_RC)
-		transport_type = SERV_TYPE_RC;
-	else if (qp_type == IB_QPT_UC)
-		transport_type = SERV_TYPE_UC;
-	else if (qp_type == IB_QPT_UD)
-		transport_type = SERV_TYPE_UD;
-	else if (qp_type == IB_QPT_GSI)
-		transport_type = SERV_TYPE_UD;
-	else
-		transport_type = -1;
-
-	return transport_type;
+	switch (qp_type) {
+	case IB_QPT_RC:
+		return SERV_TYPE_RC;
+	case IB_QPT_UC:
+		return SERV_TYPE_UC;
+	case IB_QPT_UD:
+	case IB_QPT_GSI:
+		return SERV_TYPE_UD;
+	case IB_QPT_XRC_INI:
+	case IB_QPT_XRC_TGT:
+		return SERV_TYPE_XRC;
+	default:
+		return -1;
+	}
 }
 
 static int check_mtu_validate(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index d5a6de0..f71459a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -314,6 +314,9 @@ static void set_srq_ext_param(struct hns_roce_srq *srq,
 {
 	srq->cqn = ib_srq_has_cq(init_attr->srq_type) ?
 		   to_hr_cq(init_attr->ext.cq)->cqn : 0;
+
+	srq->xrcdn = (init_attr->srq_type == IB_SRQT_XRC) ?
+		     to_hr_xrcd(init_attr->ext.xrc.xrcd)->xrcdn : 0;
 }
 
 static int set_srq_param(struct hns_roce_srq *srq,
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 90b739d..42b1776 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -86,6 +86,8 @@ struct hns_roce_ib_create_qp_resp {
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cqe_size;
+	__u32	srq_tab_size;
+	__u32	reserved;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
-- 
2.8.1

