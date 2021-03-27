Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35D34B404
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Mar 2021 04:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhC0DYX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 23:24:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14626 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhC0DYN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 23:24:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F6kfQ494yz1BGrs;
        Sat, 27 Mar 2021 11:22:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 11:24:01 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 1/5] RDMA/hns: Refactor hns_roce_v2_poll_one()
Date:   Sat, 27 Mar 2021 11:21:30 +0800
Message-ID: <1616815294-13434-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
References: <1616815294-13434-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Encapsulate the process of obtaining the current QP and filling WC as
functions, also merge some duplicate code.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 403 ++++++++++++++++-------------
 1 file changed, 224 insertions(+), 179 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8b1520a..0127451 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3303,8 +3303,8 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 }
 
 static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
-						    struct hns_roce_qp **cur_qp,
-						    struct ib_wc *wc)
+					struct hns_roce_qp *qp,
+					struct ib_wc *wc)
 {
 	struct hns_roce_rinl_sge *sge_list;
 	u32 wr_num, wr_cnt, sge_num;
@@ -3313,11 +3313,11 @@ static int hns_roce_handle_recv_inl_wqe(struct hns_roce_v2_cqe *cqe,
 
 	wr_num = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_WQE_INDX_M,
 				V2_CQE_BYTE_4_WQE_INDX_S) & 0xffff;
-	wr_cnt = wr_num & ((*cur_qp)->rq.wqe_cnt - 1);
+	wr_cnt = wr_num & (qp->rq.wqe_cnt - 1);
 
-	sge_list = (*cur_qp)->rq_inl_buf.wqe_list[wr_cnt].sg_list;
-	sge_num = (*cur_qp)->rq_inl_buf.wqe_list[wr_cnt].sge_cnt;
-	wqe_buf = hns_roce_get_recv_wqe(*cur_qp, wr_cnt);
+	sge_list = qp->rq_inl_buf.wqe_list[wr_cnt].sg_list;
+	sge_num = qp->rq_inl_buf.wqe_list[wr_cnt].sge_cnt;
+	wqe_buf = hns_roce_get_recv_wqe(qp, wr_cnt);
 	data_len = wc->byte_len;
 
 	for (sge_cnt = 0; (sge_cnt < sge_num) && (data_len); sge_cnt++) {
@@ -3451,21 +3451,205 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		init_flush_work(hr_dev, qp);
 }
 
+static int get_cur_qp(struct hns_roce_cq *hr_cq, struct hns_roce_v2_cqe *cqe,
+		      struct hns_roce_qp **cur_qp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
+	struct hns_roce_qp *hr_qp = *cur_qp;
+	u32 qpn;
+
+	qpn = roce_get_field(cqe->byte_16, V2_CQE_BYTE_16_LCL_QPN_M,
+			     V2_CQE_BYTE_16_LCL_QPN_S) &
+	      HNS_ROCE_V2_CQE_QPN_MASK;
+
+	if (!hr_qp || qpn != hr_qp->qpn) {
+		hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
+		if (unlikely(!hr_qp)) {
+			ibdev_err(&hr_dev->ib_dev,
+				  "CQ %06lx with entry for unknown QPN %06x\n",
+				  hr_cq->cqn, qpn);
+			return -EINVAL;
+		}
+		*cur_qp = hr_qp;
+	}
+
+	return 0;
+}
+
+/*
+ * mapped-value = 1 + real-value
+ * The ib wc opcode's real value is start from 0, In order to distinguish
+ * between initialized and uninitialized map values, we plus 1 to the actual
+ * value when defining the mapping, so that the validity can be identified by
+ * checking whether the mapped value is greater than 0.
+ */
+#define HR_WC_OP_MAP(hr_key, ib_key) \
+		[HNS_ROCE_V2_WQE_OP_ ## hr_key] = 1 + IB_WC_ ## ib_key
+
+static const u32 wc_send_op_map[] = {
+	HR_WC_OP_MAP(SEND,			SEND),
+	HR_WC_OP_MAP(SEND_WITH_INV,		SEND),
+	HR_WC_OP_MAP(SEND_WITH_IMM,		SEND),
+	HR_WC_OP_MAP(RDMA_READ,			RDMA_READ),
+	HR_WC_OP_MAP(RDMA_WRITE,		RDMA_WRITE),
+	HR_WC_OP_MAP(RDMA_WRITE_WITH_IMM,	RDMA_WRITE),
+	HR_WC_OP_MAP(LOCAL_INV,			LOCAL_INV),
+	HR_WC_OP_MAP(ATOM_CMP_AND_SWAP,		COMP_SWAP),
+	HR_WC_OP_MAP(ATOM_FETCH_AND_ADD,	FETCH_ADD),
+	HR_WC_OP_MAP(ATOM_MSK_CMP_AND_SWAP,	MASKED_COMP_SWAP),
+	HR_WC_OP_MAP(ATOM_MSK_FETCH_AND_ADD,	MASKED_FETCH_ADD),
+	HR_WC_OP_MAP(FAST_REG_PMR,		REG_MR),
+	HR_WC_OP_MAP(BIND_MW,			REG_MR),
+};
+
+static int to_ib_wc_send_op(u32 hr_opcode)
+{
+	if (hr_opcode >= ARRAY_SIZE(wc_send_op_map))
+		return -EINVAL;
+
+	return wc_send_op_map[hr_opcode] ? wc_send_op_map[hr_opcode] - 1 :
+					   -EINVAL;
+}
+
+static const u32 wc_recv_op_map[] = {
+	HR_WC_OP_MAP(RDMA_WRITE_WITH_IMM,		WITH_IMM),
+	HR_WC_OP_MAP(SEND,				RECV),
+	HR_WC_OP_MAP(SEND_WITH_IMM,			WITH_IMM),
+	HR_WC_OP_MAP(SEND_WITH_INV,			RECV),
+};
+
+static int to_ib_wc_recv_op(u32 hr_opcode)
+{
+	if (hr_opcode >= ARRAY_SIZE(wc_recv_op_map))
+		return -EINVAL;
+
+	return wc_recv_op_map[hr_opcode] ? wc_recv_op_map[hr_opcode] - 1 :
+					   -EINVAL;
+}
+
+static void fill_send_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
+{
+	u32 hr_opcode;
+	int ib_opcode;
+
+	wc->wc_flags = 0;
+
+	hr_opcode = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
+				   V2_CQE_BYTE_4_OPCODE_S) & 0x1f;
+	switch (hr_opcode) {
+	case HNS_ROCE_V2_WQE_OP_RDMA_READ:
+		wc->byte_len = le32_to_cpu(cqe->byte_cnt);
+		break;
+	case HNS_ROCE_V2_WQE_OP_SEND_WITH_IMM:
+	case HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM:
+		wc->wc_flags |= IB_WC_WITH_IMM;
+		break;
+	case HNS_ROCE_V2_WQE_OP_LOCAL_INV:
+		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
+		break;
+	case HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP:
+	case HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD:
+	case HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP:
+	case HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD:
+		wc->byte_len  = 8;
+		break;
+	default:
+		break;
+	}
+
+	ib_opcode = to_ib_wc_send_op(hr_opcode);
+	if (ib_opcode < 0)
+		wc->status = IB_WC_GENERAL_ERR;
+	else
+		wc->opcode = ib_opcode;
+}
+
+static inline bool is_rq_inl_enabled(struct ib_wc *wc, u32 hr_opcode,
+				     struct hns_roce_v2_cqe *cqe)
+{
+	return wc->qp->qp_type != IB_QPT_UD &&
+	       wc->qp->qp_type != IB_QPT_GSI &&
+	       (hr_opcode == HNS_ROCE_V2_OPCODE_SEND ||
+		hr_opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_IMM ||
+		hr_opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_INV) &&
+	       roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_RQ_INLINE_S);
+}
+
+static int fill_recv_wc(struct ib_wc *wc, struct hns_roce_v2_cqe *cqe)
+{
+	struct hns_roce_qp *qp = to_hr_qp(wc->qp);
+	u32 hr_opcode;
+	int ib_opcode;
+	int ret;
+
+	wc->byte_len = le32_to_cpu(cqe->byte_cnt);
+
+	hr_opcode = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
+				   V2_CQE_BYTE_4_OPCODE_S) & 0x1f;
+	switch (hr_opcode) {
+	case HNS_ROCE_V2_OPCODE_RDMA_WRITE_IMM:
+	case HNS_ROCE_V2_OPCODE_SEND_WITH_IMM:
+		wc->wc_flags = IB_WC_WITH_IMM;
+		wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immtdata));
+		break;
+	case HNS_ROCE_V2_OPCODE_SEND_WITH_INV:
+		wc->wc_flags = IB_WC_WITH_INVALIDATE;
+		wc->ex.invalidate_rkey = le32_to_cpu(cqe->rkey);
+		break;
+	default:
+		wc->wc_flags = 0;
+	}
+
+	ib_opcode = to_ib_wc_recv_op(hr_opcode);
+	if (ib_opcode < 0)
+		wc->status = IB_WC_GENERAL_ERR;
+	else
+		wc->opcode = ib_opcode;
+
+	if (is_rq_inl_enabled(wc, hr_opcode, cqe)) {
+		ret = hns_roce_handle_recv_inl_wqe(cqe, qp, wc);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	wc->sl = roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_SL_M,
+				V2_CQE_BYTE_32_SL_S);
+	wc->src_qp = roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_RMT_QPN_M,
+				    V2_CQE_BYTE_32_RMT_QPN_S);
+	wc->slid = 0;
+	wc->wc_flags |= roce_get_bit(cqe->byte_32, V2_CQE_BYTE_32_GRH_S) ?
+				     IB_WC_GRH : 0;
+	wc->port_num = roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_PORTN_M,
+				      V2_CQE_BYTE_32_PORTN_S);
+	wc->pkey_index = 0;
+
+	if (roce_get_bit(cqe->byte_28, V2_CQE_BYTE_28_VID_VLD_S)) {
+		wc->vlan_id = roce_get_field(cqe->byte_28, V2_CQE_BYTE_28_VID_M,
+					     V2_CQE_BYTE_28_VID_S);
+		wc->wc_flags |= IB_WC_WITH_VLAN;
+	} else {
+		wc->vlan_id = 0xffff;
+	}
+
+	wc->network_hdr_type = roce_get_field(cqe->byte_28,
+					      V2_CQE_BYTE_28_PORT_TYPE_M,
+					      V2_CQE_BYTE_28_PORT_TYPE_S);
+
+	return 0;
+}
+
 static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 				struct hns_roce_qp **cur_qp, struct ib_wc *wc)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
+	struct hns_roce_qp *qp = *cur_qp;
 	struct hns_roce_srq *srq = NULL;
 	struct hns_roce_v2_cqe *cqe;
-	struct hns_roce_qp *hr_qp;
 	struct hns_roce_wq *wq;
 	int is_send;
-	u16 wqe_ctr;
-	u32 opcode;
-	u32 qpn;
+	u16 wqe_idx;
 	int ret;
 
-	/* Find cqe according to consumer index */
 	cqe = get_sw_cqe_v2(hr_cq, hr_cq->cons_index);
 	if (!cqe)
 		return -EAGAIN;
@@ -3474,189 +3658,50 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 	/* Memory barrier */
 	rmb();
 
-	/* 0->SQ, 1->RQ */
-	is_send = !roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_S_R_S);
-
-	qpn = roce_get_field(cqe->byte_16, V2_CQE_BYTE_16_LCL_QPN_M,
-				V2_CQE_BYTE_16_LCL_QPN_S);
-
-	if (!*cur_qp || (qpn & HNS_ROCE_V2_CQE_QPN_MASK) != (*cur_qp)->qpn) {
-		hr_qp = __hns_roce_qp_lookup(hr_dev, qpn);
-		if (unlikely(!hr_qp)) {
-			ibdev_err(&hr_dev->ib_dev,
-				  "CQ %06lx with entry for unknown QPN %06x\n",
-				  hr_cq->cqn, qpn & HNS_ROCE_V2_CQE_QPN_MASK);
-			return -EINVAL;
-		}
-		*cur_qp = hr_qp;
-	}
+	ret = get_cur_qp(hr_cq, cqe, &qp);
+	if (ret)
+		return ret;
 
-	wc->qp = &(*cur_qp)->ibqp;
+	wc->qp = &qp->ibqp;
 	wc->vendor_err = 0;
 
+	wqe_idx = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_WQE_INDX_M,
+				 V2_CQE_BYTE_4_WQE_INDX_S);
+
+	is_send = !roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_S_R_S);
 	if (is_send) {
-		wq = &(*cur_qp)->sq;
-		if ((*cur_qp)->sq_signal_bits) {
-			/*
-			 * If sg_signal_bit is 1,
-			 * firstly tail pointer updated to wqe
-			 * which current cqe correspond to
-			 */
-			wqe_ctr = (u16)roce_get_field(cqe->byte_4,
-						      V2_CQE_BYTE_4_WQE_INDX_M,
-						      V2_CQE_BYTE_4_WQE_INDX_S);
-			wq->tail += (wqe_ctr - (u16)wq->tail) &
+		wq = &qp->sq;
+
+		/* If sg_signal_bit is set, tail pointer will be updated to
+		 * the WQE corresponding to the current CQE.
+		 */
+		if (qp->sq_signal_bits)
+			wq->tail += (wqe_idx - (u16)wq->tail) &
 				    (wq->wqe_cnt - 1);
-		}
 
 		wc->wr_id = wq->wrid[wq->tail & (wq->wqe_cnt - 1)];
 		++wq->tail;
-	} else if ((*cur_qp)->ibqp.srq) {
-		srq = to_hr_srq((*cur_qp)->ibqp.srq);
-		wqe_ctr = (u16)roce_get_field(cqe->byte_4,
-					      V2_CQE_BYTE_4_WQE_INDX_M,
-					      V2_CQE_BYTE_4_WQE_INDX_S);
-		wc->wr_id = srq->wrid[wqe_ctr];
-		hns_roce_free_srq_wqe(srq, wqe_ctr);
-	} else {
-		/* Update tail pointer, record wr_id */
-		wq = &(*cur_qp)->rq;
-		wc->wr_id = wq->wrid[wq->tail & (wq->wqe_cnt - 1)];
-		++wq->tail;
-	}
 
-	get_cqe_status(hr_dev, *cur_qp, hr_cq, cqe, wc);
-	if (unlikely(wc->status != IB_WC_SUCCESS))
-		return 0;
-
-	if (is_send) {
-		wc->wc_flags = 0;
-		/* SQ corresponding to CQE */
-		switch (roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
-				       V2_CQE_BYTE_4_OPCODE_S) & 0x1f) {
-		case HNS_ROCE_V2_WQE_OP_SEND:
-			wc->opcode = IB_WC_SEND;
-			break;
-		case HNS_ROCE_V2_WQE_OP_SEND_WITH_INV:
-			wc->opcode = IB_WC_SEND;
-			break;
-		case HNS_ROCE_V2_WQE_OP_SEND_WITH_IMM:
-			wc->opcode = IB_WC_SEND;
-			wc->wc_flags |= IB_WC_WITH_IMM;
-			break;
-		case HNS_ROCE_V2_WQE_OP_RDMA_READ:
-			wc->opcode = IB_WC_RDMA_READ;
-			wc->byte_len = le32_to_cpu(cqe->byte_cnt);
-			break;
-		case HNS_ROCE_V2_WQE_OP_RDMA_WRITE:
-			wc->opcode = IB_WC_RDMA_WRITE;
-			break;
-		case HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM:
-			wc->opcode = IB_WC_RDMA_WRITE;
-			wc->wc_flags |= IB_WC_WITH_IMM;
-			break;
-		case HNS_ROCE_V2_WQE_OP_LOCAL_INV:
-			wc->opcode = IB_WC_LOCAL_INV;
-			wc->wc_flags |= IB_WC_WITH_INVALIDATE;
-			break;
-		case HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP:
-			wc->opcode = IB_WC_COMP_SWAP;
-			wc->byte_len  = 8;
-			break;
-		case HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD:
-			wc->opcode = IB_WC_FETCH_ADD;
-			wc->byte_len  = 8;
-			break;
-		case HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP:
-			wc->opcode = IB_WC_MASKED_COMP_SWAP;
-			wc->byte_len  = 8;
-			break;
-		case HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD:
-			wc->opcode = IB_WC_MASKED_FETCH_ADD;
-			wc->byte_len  = 8;
-			break;
-		case HNS_ROCE_V2_WQE_OP_FAST_REG_PMR:
-			wc->opcode = IB_WC_REG_MR;
-			break;
-		case HNS_ROCE_V2_WQE_OP_BIND_MW:
-			wc->opcode = IB_WC_REG_MR;
-			break;
-		default:
-			wc->status = IB_WC_GENERAL_ERR;
-			break;
-		}
+		fill_send_wc(wc, cqe);
 	} else {
-		/* RQ correspond to CQE */
-		wc->byte_len = le32_to_cpu(cqe->byte_cnt);
-
-		opcode = roce_get_field(cqe->byte_4, V2_CQE_BYTE_4_OPCODE_M,
-					V2_CQE_BYTE_4_OPCODE_S);
-		switch (opcode & 0x1f) {
-		case HNS_ROCE_V2_OPCODE_RDMA_WRITE_IMM:
-			wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
-			wc->wc_flags = IB_WC_WITH_IMM;
-			wc->ex.imm_data =
-				cpu_to_be32(le32_to_cpu(cqe->immtdata));
-			break;
-		case HNS_ROCE_V2_OPCODE_SEND:
-			wc->opcode = IB_WC_RECV;
-			wc->wc_flags = 0;
-			break;
-		case HNS_ROCE_V2_OPCODE_SEND_WITH_IMM:
-			wc->opcode = IB_WC_RECV;
-			wc->wc_flags = IB_WC_WITH_IMM;
-			wc->ex.imm_data =
-				cpu_to_be32(le32_to_cpu(cqe->immtdata));
-			break;
-		case HNS_ROCE_V2_OPCODE_SEND_WITH_INV:
-			wc->opcode = IB_WC_RECV;
-			wc->wc_flags = IB_WC_WITH_INVALIDATE;
-			wc->ex.invalidate_rkey = le32_to_cpu(cqe->rkey);
-			break;
-		default:
-			wc->status = IB_WC_GENERAL_ERR;
-			break;
-		}
-
-		if ((wc->qp->qp_type == IB_QPT_RC ||
-		     wc->qp->qp_type == IB_QPT_UC) &&
-		    (opcode == HNS_ROCE_V2_OPCODE_SEND ||
-		    opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_IMM ||
-		    opcode == HNS_ROCE_V2_OPCODE_SEND_WITH_INV) &&
-		    (roce_get_bit(cqe->byte_4, V2_CQE_BYTE_4_RQ_INLINE_S))) {
-			ret = hns_roce_handle_recv_inl_wqe(cqe, cur_qp, wc);
-			if (unlikely(ret))
-				return -EAGAIN;
-		}
-
-		wc->sl = (u8)roce_get_field(cqe->byte_32, V2_CQE_BYTE_32_SL_M,
-					    V2_CQE_BYTE_32_SL_S);
-		wc->src_qp = (u8)roce_get_field(cqe->byte_32,
-						V2_CQE_BYTE_32_RMT_QPN_M,
-						V2_CQE_BYTE_32_RMT_QPN_S);
-		wc->slid = 0;
-		wc->wc_flags |= (roce_get_bit(cqe->byte_32,
-					      V2_CQE_BYTE_32_GRH_S) ?
-					      IB_WC_GRH : 0);
-		wc->port_num = roce_get_field(cqe->byte_32,
-				V2_CQE_BYTE_32_PORTN_M, V2_CQE_BYTE_32_PORTN_S);
-		wc->pkey_index = 0;
-
-		if (roce_get_bit(cqe->byte_28, V2_CQE_BYTE_28_VID_VLD_S)) {
-			wc->vlan_id = (u16)roce_get_field(cqe->byte_28,
-							  V2_CQE_BYTE_28_VID_M,
-							  V2_CQE_BYTE_28_VID_S);
-			wc->wc_flags |= IB_WC_WITH_VLAN;
+		if (qp->ibqp.srq) {
+			srq = to_hr_srq(qp->ibqp.srq);
+			wc->wr_id = srq->wrid[wqe_idx];
+			hns_roce_free_srq_wqe(srq, wqe_idx);
 		} else {
-			wc->vlan_id = 0xffff;
+			wq = &qp->rq;
+			wc->wr_id = wq->wrid[wq->tail & (wq->wqe_cnt - 1)];
+			++wq->tail;
 		}
 
-		wc->network_hdr_type = roce_get_field(cqe->byte_28,
-						    V2_CQE_BYTE_28_PORT_TYPE_M,
-						    V2_CQE_BYTE_28_PORT_TYPE_S);
+		ret = fill_recv_wc(wc, cqe);
 	}
 
-	return 0;
+	get_cqe_status(hr_dev, qp, hr_cq, cqe, wc);
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		return 0;
+
+	return ret;
 }
 
 static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
-- 
2.8.1

