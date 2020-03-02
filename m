Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E311175A2D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgCBMPX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 07:15:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbgCBMPX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 07:15:23 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8E8B25D6C72A000FD755;
        Mon,  2 Mar 2020 20:15:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 20:15:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/5] RDMA/hns: Optimize wqe buffer set flow for post send
Date:   Mon, 2 Mar 2020 20:11:33 +0800
Message-ID: <1583151093-30402-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Splits hns_roce_v2_post_send() into three sub-functions: set_rc_wqe(),
set_ud_wqe() and update_sq_db() to simplify the code.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 473 ++++++++++++++---------------
 1 file changed, 225 insertions(+), 248 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index ea61ccb..f6bd0cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -294,6 +294,214 @@ static int check_send_valid(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static inline int calc_wr_sge_num(const struct ib_send_wr *wr, u32 *sge_len)
+{
+	u32 len = 0;
+	int num = 0;
+	int i;
+
+	for (i = 0; i < wr->num_sge; i++) {
+		if (likely(wr->sg_list[i].length)) {
+			len += wr->sg_list[i].length;
+			num++;
+		}
+	}
+
+	*sge_len = len;
+	return num;
+}
+
+static inline int set_ud_wqe(struct hns_roce_qp *qp,
+			     const struct ib_send_wr *wr,
+			     void *wqe, unsigned int *sge_idx,
+			     unsigned int owner_bit)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
+	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
+	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
+	unsigned int curr_idx = *sge_idx;
+	int valid_num_sge;
+	u32 msg_len = 0;
+	bool loopback;
+	u8 *smac;
+
+	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
+	memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
+
+	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_0_M,
+		       V2_UD_SEND_WQE_DMAC_0_S, ah->av.mac[0]);
+	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_1_M,
+		       V2_UD_SEND_WQE_DMAC_1_S, ah->av.mac[1]);
+	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_2_M,
+		       V2_UD_SEND_WQE_DMAC_2_S, ah->av.mac[2]);
+	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_3_M,
+		       V2_UD_SEND_WQE_DMAC_3_S, ah->av.mac[3]);
+	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_DMAC_4_M,
+		       V2_UD_SEND_WQE_BYTE_48_DMAC_4_S, ah->av.mac[4]);
+	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_DMAC_5_M,
+		       V2_UD_SEND_WQE_BYTE_48_DMAC_5_S, ah->av.mac[5]);
+
+	/* MAC loopback */
+	smac = (u8 *)hr_dev->dev_addr[qp->port];
+	loopback = ether_addr_equal_unaligned(ah->av.mac, smac) ? 1 : 0;
+
+	roce_set_bit(ud_sq_wqe->byte_40,
+		     V2_UD_SEND_WQE_BYTE_40_LBI_S, loopback);
+
+	roce_set_field(ud_sq_wqe->byte_4,
+		       V2_UD_SEND_WQE_BYTE_4_OPCODE_M,
+		       V2_UD_SEND_WQE_BYTE_4_OPCODE_S,
+		       HNS_ROCE_V2_WQE_OP_SEND);
+
+	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
+
+	switch (wr->opcode) {
+	case IB_WR_SEND_WITH_IMM:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		ud_sq_wqe->immtdata = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
+		break;
+	default:
+		ud_sq_wqe->immtdata = 0;
+		break;
+	}
+
+	/* Set sig attr */
+	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_CQE_S,
+		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
+
+	/* Set se attr */
+	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_SE_S,
+		     (wr->send_flags & IB_SEND_SOLICITED) ? 1 : 0);
+
+	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_OWNER_S,
+		     owner_bit);
+
+	roce_set_field(ud_sq_wqe->byte_16, V2_UD_SEND_WQE_BYTE_16_PD_M,
+		       V2_UD_SEND_WQE_BYTE_16_PD_S, to_hr_pd(qp->ibqp.pd)->pdn);
+
+	roce_set_field(ud_sq_wqe->byte_16, V2_UD_SEND_WQE_BYTE_16_SGE_NUM_M,
+		       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_S, valid_num_sge);
+
+	roce_set_field(ud_sq_wqe->byte_20,
+		       V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M,
+		       V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
+		       curr_idx & (qp->sge.sge_cnt - 1));
+
+	roce_set_field(ud_sq_wqe->byte_24, V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
+		       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, 0);
+	ud_sq_wqe->qkey = cpu_to_le32(ud_wr(wr)->remote_qkey & 0x80000000 ?
+			  qp->qkey : ud_wr(wr)->remote_qkey);
+	roce_set_field(ud_sq_wqe->byte_32, V2_UD_SEND_WQE_BYTE_32_DQPN_M,
+		       V2_UD_SEND_WQE_BYTE_32_DQPN_S, ud_wr(wr)->remote_qpn);
+
+	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_VLAN_M,
+		       V2_UD_SEND_WQE_BYTE_36_VLAN_S, ah->av.vlan_id);
+	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
+		       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S, ah->av.hop_limit);
+	roce_set_field(ud_sq_wqe->byte_36, V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
+		       V2_UD_SEND_WQE_BYTE_36_TCLASS_S, ah->av.tclass);
+	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
+		       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S, ah->av.flowlabel);
+	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_SL_M,
+		       V2_UD_SEND_WQE_BYTE_40_SL_S, ah->av.sl);
+	roce_set_field(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_PORTN_M,
+		       V2_UD_SEND_WQE_BYTE_40_PORTN_S, qp->port);
+
+	roce_set_bit(ud_sq_wqe->byte_40, V2_UD_SEND_WQE_BYTE_40_UD_VLAN_EN_S,
+		     ah->av.vlan_en ? 1 : 0);
+	roce_set_field(ud_sq_wqe->byte_48, V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M,
+		       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S, ah->av.gid_index);
+
+	memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0], GID_LEN_V2);
+
+	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
+
+	*sge_idx = curr_idx;
+
+	return 0;
+}
+
+static inline int set_rc_wqe(struct hns_roce_qp *qp,
+			     const struct ib_send_wr *wr,
+			     void *wqe, unsigned int *sge_idx,
+			     unsigned int owner_bit)
+{
+	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
+	unsigned int curr_idx = *sge_idx;
+	int valid_num_sge;
+	u32 msg_len = 0;
+	int ret = 0;
+
+	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
+	memset(rc_sq_wqe, 0, sizeof(*rc_sq_wqe));
+
+	rc_sq_wqe->msg_len = cpu_to_le32(msg_len);
+
+	switch (wr->opcode) {
+	case IB_WR_SEND_WITH_IMM:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		rc_sq_wqe->immtdata = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
+		break;
+	case IB_WR_SEND_WITH_INV:
+		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
+		break;
+	default:
+		rc_sq_wqe->immtdata = 0;
+		break;
+	}
+
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_FENCE_S,
+		     (wr->send_flags & IB_SEND_FENCE) ? 1 : 0);
+
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SE_S,
+		     (wr->send_flags & IB_SEND_SOLICITED) ? 1 : 0);
+
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_CQE_S,
+		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
+
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
+		     owner_bit);
+
+	wqe += sizeof(struct hns_roce_v2_rc_send_wqe);
+	switch (wr->opcode) {
+	case IB_WR_RDMA_READ:
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		rc_sq_wqe->rkey = cpu_to_le32(rdma_wr(wr)->rkey);
+		rc_sq_wqe->va = cpu_to_le64(rdma_wr(wr)->remote_addr);
+		break;
+	case IB_WR_LOCAL_INV:
+		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
+		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
+		break;
+	case IB_WR_REG_MR:
+		set_frmr_seg(rc_sq_wqe, wqe, reg_wr(wr));
+		break;
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		rc_sq_wqe->rkey = cpu_to_le32(atomic_wr(wr)->rkey);
+		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
+		break;
+	default:
+		break;
+	}
+
+	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
+		       V2_RC_SEND_WQE_BYTE_4_OPCODE_S,
+		       to_hr_opcode(wr->opcode));
+
+	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+		set_atomic_seg(wr, wqe, rc_sq_wqe, valid_num_sge);
+	else if (wr->opcode != IB_WR_REG_MR)
+		ret = set_rwqe_data_seg(&qp->ibqp, wr, rc_sq_wqe,
+					wqe, &curr_idx, valid_num_sge);
+
+	*sge_idx = curr_idx;
+
+	return ret;
+}
+
 static inline void update_sq_db(struct hns_roce_dev *hr_dev,
 				struct hns_roce_qp *qp)
 {
@@ -331,23 +539,15 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 				 const struct ib_send_wr **bad_wr)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
-	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
-	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe;
-	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_qp *qp = to_hr_qp(ibqp);
-	struct device *dev = hr_dev->dev;
+	unsigned long flags = 0;
 	unsigned int owner_bit;
 	unsigned int sge_idx;
 	unsigned int wqe_idx;
-	unsigned long flags;
-	int valid_num_sge;
 	void *wqe = NULL;
-	bool loopback;
-	u32 tmp_len;
-	u8 *smac;
 	int nreq;
 	int ret;
-	int i;
 
 	spin_lock_irqsave(&qp->sq.lock, flags);
 
@@ -370,8 +570,8 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		wqe_idx = (qp->sq.head + nreq) & (qp->sq.wqe_cnt - 1);
 
 		if (unlikely(wr->num_sge > qp->sq.max_gs)) {
-			dev_err(dev, "num_sge=%d > qp->sq.max_gs=%d\n",
-				wr->num_sge, qp->sq.max_gs);
+			ibdev_err(ibdev, "num_sge=%d > qp->sq.max_gs=%d\n",
+				  wr->num_sge, qp->sq.max_gs);
 			ret = -EINVAL;
 			*bad_wr = wr;
 			goto out;
@@ -381,248 +581,25 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		qp->sq.wrid[wqe_idx] = wr->wr_id;
 		owner_bit =
 		       ~(((qp->sq.head + nreq) >> ilog2(qp->sq.wqe_cnt)) & 0x1);
-		valid_num_sge = 0;
-		tmp_len = 0;
-
-		for (i = 0; i < wr->num_sge; i++) {
-			if (likely(wr->sg_list[i].length)) {
-				tmp_len += wr->sg_list[i].length;
-				valid_num_sge++;
-			}
-		}
 
 		/* Corresponding to the QP type, wqe process separately */
-		if (ibqp->qp_type == IB_QPT_GSI) {
-			ud_sq_wqe = wqe;
-			memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
-
-			roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_0_M,
-				       V2_UD_SEND_WQE_DMAC_0_S, ah->av.mac[0]);
-			roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_1_M,
-				       V2_UD_SEND_WQE_DMAC_1_S, ah->av.mac[1]);
-			roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_2_M,
-				       V2_UD_SEND_WQE_DMAC_2_S, ah->av.mac[2]);
-			roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_3_M,
-				       V2_UD_SEND_WQE_DMAC_3_S, ah->av.mac[3]);
-			roce_set_field(ud_sq_wqe->byte_48,
-				       V2_UD_SEND_WQE_BYTE_48_DMAC_4_M,
-				       V2_UD_SEND_WQE_BYTE_48_DMAC_4_S,
-				       ah->av.mac[4]);
-			roce_set_field(ud_sq_wqe->byte_48,
-				       V2_UD_SEND_WQE_BYTE_48_DMAC_5_M,
-				       V2_UD_SEND_WQE_BYTE_48_DMAC_5_S,
-				       ah->av.mac[5]);
-
-			/* MAC loopback */
-			smac = (u8 *)hr_dev->dev_addr[qp->port];
-			loopback = ether_addr_equal_unaligned(ah->av.mac,
-							      smac) ? 1 : 0;
-
-			roce_set_bit(ud_sq_wqe->byte_40,
-				     V2_UD_SEND_WQE_BYTE_40_LBI_S, loopback);
-
-			roce_set_field(ud_sq_wqe->byte_4,
-				       V2_UD_SEND_WQE_BYTE_4_OPCODE_M,
-				       V2_UD_SEND_WQE_BYTE_4_OPCODE_S,
-				       HNS_ROCE_V2_WQE_OP_SEND);
-
-			ud_sq_wqe->msg_len =
-			 cpu_to_le32(le32_to_cpu(ud_sq_wqe->msg_len) + tmp_len);
-
-			switch (wr->opcode) {
-			case IB_WR_SEND_WITH_IMM:
-			case IB_WR_RDMA_WRITE_WITH_IMM:
-				ud_sq_wqe->immtdata =
-				      cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
-				break;
-			default:
-				ud_sq_wqe->immtdata = 0;
-				break;
-			}
-
-			/* Set sig attr */
-			roce_set_bit(ud_sq_wqe->byte_4,
-				   V2_UD_SEND_WQE_BYTE_4_CQE_S,
-				   (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
-
-			/* Set se attr */
-			roce_set_bit(ud_sq_wqe->byte_4,
-				  V2_UD_SEND_WQE_BYTE_4_SE_S,
-				  (wr->send_flags & IB_SEND_SOLICITED) ? 1 : 0);
-
-			roce_set_bit(ud_sq_wqe->byte_4,
-				     V2_UD_SEND_WQE_BYTE_4_OWNER_S, owner_bit);
-
-			roce_set_field(ud_sq_wqe->byte_16,
-				       V2_UD_SEND_WQE_BYTE_16_PD_M,
-				       V2_UD_SEND_WQE_BYTE_16_PD_S,
-				       to_hr_pd(ibqp->pd)->pdn);
-
-			roce_set_field(ud_sq_wqe->byte_16,
-				       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_M,
-				       V2_UD_SEND_WQE_BYTE_16_SGE_NUM_S,
-				       valid_num_sge);
-
-			roce_set_field(ud_sq_wqe->byte_20,
-				     V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_M,
-				     V2_UD_SEND_WQE_BYTE_20_MSG_START_SGE_IDX_S,
-				     sge_idx & (qp->sge.sge_cnt - 1));
-
-			roce_set_field(ud_sq_wqe->byte_24,
-				       V2_UD_SEND_WQE_BYTE_24_UDPSPN_M,
-				       V2_UD_SEND_WQE_BYTE_24_UDPSPN_S, 0);
-			ud_sq_wqe->qkey =
-			     cpu_to_le32(ud_wr(wr)->remote_qkey & 0x80000000 ?
-			     qp->qkey : ud_wr(wr)->remote_qkey);
-			roce_set_field(ud_sq_wqe->byte_32,
-				       V2_UD_SEND_WQE_BYTE_32_DQPN_M,
-				       V2_UD_SEND_WQE_BYTE_32_DQPN_S,
-				       ud_wr(wr)->remote_qpn);
-
-			roce_set_field(ud_sq_wqe->byte_36,
-				       V2_UD_SEND_WQE_BYTE_36_VLAN_M,
-				       V2_UD_SEND_WQE_BYTE_36_VLAN_S,
-				       ah->av.vlan_id);
-			roce_set_field(ud_sq_wqe->byte_36,
-				       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_M,
-				       V2_UD_SEND_WQE_BYTE_36_HOPLIMIT_S,
-				       ah->av.hop_limit);
-			roce_set_field(ud_sq_wqe->byte_36,
-				       V2_UD_SEND_WQE_BYTE_36_TCLASS_M,
-				       V2_UD_SEND_WQE_BYTE_36_TCLASS_S,
-				       ah->av.tclass);
-			roce_set_field(ud_sq_wqe->byte_40,
-				       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_M,
-				       V2_UD_SEND_WQE_BYTE_40_FLOW_LABEL_S,
-				       ah->av.flowlabel);
-			roce_set_field(ud_sq_wqe->byte_40,
-				       V2_UD_SEND_WQE_BYTE_40_SL_M,
-				       V2_UD_SEND_WQE_BYTE_40_SL_S,
-				       ah->av.sl);
-			roce_set_field(ud_sq_wqe->byte_40,
-				       V2_UD_SEND_WQE_BYTE_40_PORTN_M,
-				       V2_UD_SEND_WQE_BYTE_40_PORTN_S,
-				       qp->port);
-
-			roce_set_bit(ud_sq_wqe->byte_40,
-				     V2_UD_SEND_WQE_BYTE_40_UD_VLAN_EN_S,
-				     ah->av.vlan_en ? 1 : 0);
-			roce_set_field(ud_sq_wqe->byte_48,
-				       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M,
-				       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S,
-				       hns_get_gid_index(hr_dev, qp->phy_port,
-							 ah->av.gid_index));
-
-			memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0],
-			       GID_LEN_V2);
-
-			set_extend_sge(qp, wr, &sge_idx, valid_num_sge);
-		} else if (ibqp->qp_type == IB_QPT_RC) {
-			rc_sq_wqe = wqe;
-			memset(rc_sq_wqe, 0, sizeof(*rc_sq_wqe));
-
-			rc_sq_wqe->msg_len =
-			 cpu_to_le32(le32_to_cpu(rc_sq_wqe->msg_len) + tmp_len);
-
-			switch (wr->opcode) {
-			case IB_WR_SEND_WITH_IMM:
-			case IB_WR_RDMA_WRITE_WITH_IMM:
-				rc_sq_wqe->immtdata =
-				      cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
-				break;
-			case IB_WR_SEND_WITH_INV:
-				rc_sq_wqe->inv_key =
-					cpu_to_le32(wr->ex.invalidate_rkey);
-				break;
-			default:
-				rc_sq_wqe->immtdata = 0;
-				break;
-			}
-
-			roce_set_bit(rc_sq_wqe->byte_4,
-				     V2_RC_SEND_WQE_BYTE_4_FENCE_S,
-				     (wr->send_flags & IB_SEND_FENCE) ? 1 : 0);
-
-			roce_set_bit(rc_sq_wqe->byte_4,
-				  V2_RC_SEND_WQE_BYTE_4_SE_S,
-				  (wr->send_flags & IB_SEND_SOLICITED) ? 1 : 0);
-
-			roce_set_bit(rc_sq_wqe->byte_4,
-				   V2_RC_SEND_WQE_BYTE_4_CQE_S,
-				   (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
-
-			roce_set_bit(rc_sq_wqe->byte_4,
-				     V2_RC_SEND_WQE_BYTE_4_OWNER_S, owner_bit);
-
-			wqe += sizeof(struct hns_roce_v2_rc_send_wqe);
-			switch (wr->opcode) {
-			case IB_WR_RDMA_READ:
-				rc_sq_wqe->rkey =
-					cpu_to_le32(rdma_wr(wr)->rkey);
-				rc_sq_wqe->va =
-					cpu_to_le64(rdma_wr(wr)->remote_addr);
-				break;
-			case IB_WR_RDMA_WRITE:
-				rc_sq_wqe->rkey =
-					cpu_to_le32(rdma_wr(wr)->rkey);
-				rc_sq_wqe->va =
-					cpu_to_le64(rdma_wr(wr)->remote_addr);
-				break;
-			case IB_WR_RDMA_WRITE_WITH_IMM:
-				rc_sq_wqe->rkey =
-					cpu_to_le32(rdma_wr(wr)->rkey);
-				rc_sq_wqe->va =
-					cpu_to_le64(rdma_wr(wr)->remote_addr);
-				break;
-			case IB_WR_LOCAL_INV:
-				roce_set_bit(rc_sq_wqe->byte_4,
-					       V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
-				rc_sq_wqe->inv_key =
-					    cpu_to_le32(wr->ex.invalidate_rkey);
-				break;
-			case IB_WR_REG_MR:
-				set_frmr_seg(rc_sq_wqe, wqe, reg_wr(wr));
-				break;
-			case IB_WR_ATOMIC_CMP_AND_SWP:
-				rc_sq_wqe->rkey =
-					cpu_to_le32(atomic_wr(wr)->rkey);
-				rc_sq_wqe->va =
-					cpu_to_le64(atomic_wr(wr)->remote_addr);
-				break;
-			case IB_WR_ATOMIC_FETCH_AND_ADD:
-				rc_sq_wqe->rkey =
-					cpu_to_le32(atomic_wr(wr)->rkey);
-				rc_sq_wqe->va =
-					cpu_to_le64(atomic_wr(wr)->remote_addr);
-				break;
-			default:
-				break;
-			}
-
-			roce_set_field(rc_sq_wqe->byte_4,
-				       V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
-				       V2_RC_SEND_WQE_BYTE_4_OPCODE_S,
-				       to_hr_opcode(wr->opcode));
-
-			if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
-			    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
-				set_atomic_seg(wr, wqe, rc_sq_wqe,
-					       valid_num_sge);
-			else if (wr->opcode != IB_WR_REG_MR) {
-				ret = set_rwqe_data_seg(ibqp, wr, rc_sq_wqe,
-							wqe, &sge_idx,
-							valid_num_sge);
-				if (ret) {
-					*bad_wr = wr;
-					goto out;
-				}
-			}
-		} else {
-			dev_err(dev, "Illegal qp_type(0x%x)\n", ibqp->qp_type);
+		if (ibqp->qp_type == IB_QPT_GSI)
+			ret = set_ud_wqe(qp, wr, wqe, &sge_idx, owner_bit);
+		else if (ibqp->qp_type == IB_QPT_RC)
+			ret = set_rc_wqe(qp, wr, wqe, &sge_idx, owner_bit);
+
+		else {
+			ibdev_err(ibdev, "Illegal qp_type(0x%x)\n",
+				  ibqp->qp_type);
 			spin_unlock_irqrestore(&qp->sq.lock, flags);
 			*bad_wr = wr;
 			return -EOPNOTSUPP;
 		}
+
+		if (ret) {
+			*bad_wr = wr;
+			goto out;
+		}
 	}
 
 out:
-- 
2.8.1

