Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932FA395B0B
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhEaNBl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 09:01:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2801 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhEaNBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 09:01:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtwHf11KQzWqQ6;
        Mon, 31 May 2021 20:55:10 +0800 (CST)
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
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 3/7] RDMA/hns: Use new interface to modify QP context
Date:   Mon, 31 May 2021 20:59:30 +0800
Message-ID: <1622465974-20415-4-git-send-email-liweihang@huawei.com>
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

From: Lang Cheng <chenglang@huawei.com>

Fill all QPC fileds with hr_reg_*() instead of roce_set_*(). SQPN is used
for HIP08 ES only, it should be removed.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 765 ++++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 550 +++++++--------------
 2 files changed, 442 insertions(+), 873 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f1acc05..2bddc0b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4014,38 +4014,33 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
 	if (!dest_rd_atomic)
 		access_flags &= IB_ACCESS_REMOTE_WRITE;
 
-	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
+	hr_reg_write(context, QPC_RRE,
 		     !!(access_flags & IB_ACCESS_REMOTE_READ));
-	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S, 0);
+	hr_reg_clear(qpc_mask, QPC_RRE);
 
-	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RWE_S,
+	hr_reg_write(context, QPC_RWE,
 		     !!(access_flags & IB_ACCESS_REMOTE_WRITE));
-	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RWE_S, 0);
+	hr_reg_clear(qpc_mask, QPC_RWE);
 
-	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
+	hr_reg_write(context, QPC_ATE,
 		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
-	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
-	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S,
+	hr_reg_clear(qpc_mask, QPC_ATE);
+	hr_reg_write(context, QPC_EXT_ATE,
 		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
-	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S, 0);
+	hr_reg_clear(qpc_mask, QPC_EXT_ATE);
 }
 
 static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
 			    struct hns_roce_v2_qp_context *qpc_mask)
 {
-	roce_set_field(context->byte_4_sqpn_tst,
-		       V2_QPC_BYTE_4_SGE_SHIFT_M, V2_QPC_BYTE_4_SGE_SHIFT_S,
-		       to_hr_hem_entries_shift(hr_qp->sge.sge_cnt,
-					       hr_qp->sge.sge_shift));
+	hr_reg_write(context, QPC_SGE_SHIFT,
+		     to_hr_hem_entries_shift(hr_qp->sge.sge_cnt,
+					     hr_qp->sge.sge_shift));
 
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S,
-		       ilog2(hr_qp->sq.wqe_cnt));
+	hr_reg_write(context, QPC_SQ_SHIFT, ilog2(hr_qp->sq.wqe_cnt));
 
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S,
-		       ilog2(hr_qp->rq.wqe_cnt));
+	hr_reg_write(context, QPC_RQ_SHIFT, ilog2(hr_qp->rq.wqe_cnt));
 }
 
 static inline int get_cqn(struct ib_cq *ib_cq)
@@ -4073,62 +4068,46 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
-		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(ibqp->qp_type));
+	hr_reg_write(context, QPC_TST, to_hr_qp_type(ibqp->qp_type));
 
-	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
-		       V2_QPC_BYTE_4_SQPN_S, hr_qp->qpn);
+	hr_reg_write(context, QPC_PD, get_pdn(ibqp->pd));
 
-	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-		       V2_QPC_BYTE_16_PD_S, get_pdn(ibqp->pd));
-
-	roce_set_field(context->byte_20_smac_sgid_idx, V2_QPC_BYTE_20_RQWS_M,
-		       V2_QPC_BYTE_20_RQWS_S, ilog2(hr_qp->rq.max_gs));
+	hr_reg_write(context, QPC_RQWS, ilog2(hr_qp->rq.max_gs));
 
 	set_qpc_wqe_cnt(hr_qp, context, qpc_mask);
 
 	/* No VLAN need to set 0xFFF */
-	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
-		       V2_QPC_BYTE_24_VLAN_ID_S, 0xfff);
+	hr_reg_write(context, QPC_VLAN_ID, 0xfff);
 
 	if (ibqp->qp_type == IB_QPT_XRC_TGT) {
 		context->qkey_xrcd = cpu_to_le32(hr_qp->xrcdn);
 
-		roce_set_bit(context->byte_80_rnr_rx_cqn,
-			     V2_QPC_BYTE_80_XRC_QP_TYPE_S, 1);
+		hr_reg_enable(context, QPC_XRC_QP_TYPE);
 	}
 
 	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_RQ_RECORD_DB)
-		roce_set_bit(context->byte_68_rq_db,
-			     V2_QPC_BYTE_68_RQ_RECORD_EN_S, 1);
+		hr_reg_enable(context, QPC_RQ_RECORD_EN);
 
-	roce_set_field(context->byte_68_rq_db,
-		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_M,
-		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_S,
-		       ((u32)hr_qp->rdb.dma) >> 1);
-	context->rq_db_record_addr = cpu_to_le32(hr_qp->rdb.dma >> 32);
+	hr_reg_write(context, QPC_RQ_DB_RECORD_ADDR_L,
+		     lower_32_bits(hr_qp->rdb.dma) >> 1);
+	hr_reg_write(context, QPC_RQ_DB_RECORD_ADDR_H,
+		     upper_32_bits(hr_qp->rdb.dma));
 
 	if (ibqp->qp_type != IB_QPT_UD && ibqp->qp_type != IB_QPT_GSI)
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_RQIE_S,
+		hr_reg_write(context, QPC_RQIE,
 			     !!(hr_dev->caps.flags &
 				HNS_ROCE_CAP_FLAG_RQ_INLINE));
 
-	roce_set_field(context->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
-		       V2_QPC_BYTE_80_RX_CQN_S, get_cqn(ibqp->recv_cq));
+	hr_reg_write(context, QPC_RX_CQN, get_cqn(ibqp->recv_cq));
 
 	if (ibqp->srq) {
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
-		roce_set_field(context->byte_76_srqn_op_en,
-			       V2_QPC_BYTE_76_SRQN_M, V2_QPC_BYTE_76_SRQN_S,
-			       to_hr_srq(ibqp->srq)->srqn);
+		hr_reg_enable(context, QPC_SRQ_EN);
+		hr_reg_write(context, QPC_SRQN, to_hr_srq(ibqp->srq)->srqn);
 	}
 
-	roce_set_bit(context->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 1);
+	hr_reg_enable(context, QPC_FRE);
 
-	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
-		       V2_QPC_BYTE_252_TX_CQN_S, get_cqn(ibqp->send_cq));
+	hr_reg_write(context, QPC_TX_CQN, get_cqn(ibqp->send_cq));
 
 	if (hr_dev->caps.qpc_sz < HNS_ROCE_V3_QPC_SZ)
 		return;
@@ -4150,49 +4129,28 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
-		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(ibqp->qp_type));
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
-		       V2_QPC_BYTE_4_TST_S, 0);
-
-	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-		       V2_QPC_BYTE_16_PD_S, get_pdn(ibqp->pd));
+	hr_reg_write(context, QPC_TST, to_hr_qp_type(ibqp->qp_type));
+	hr_reg_clear(qpc_mask, QPC_TST);
 
-	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-		       V2_QPC_BYTE_16_PD_S, 0);
+	hr_reg_write(context, QPC_PD, get_pdn(ibqp->pd));
+	hr_reg_clear(qpc_mask, QPC_PD);
 
-	roce_set_field(context->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
-		       V2_QPC_BYTE_80_RX_CQN_S, get_cqn(ibqp->recv_cq));
-	roce_set_field(qpc_mask->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
-		       V2_QPC_BYTE_80_RX_CQN_S, 0);
+	hr_reg_write(context, QPC_RX_CQN, get_cqn(ibqp->recv_cq));
+	hr_reg_clear(qpc_mask, QPC_RX_CQN);
 
-	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
-		       V2_QPC_BYTE_252_TX_CQN_S, get_cqn(ibqp->send_cq));
-	roce_set_field(qpc_mask->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
-		       V2_QPC_BYTE_252_TX_CQN_S, 0);
+	hr_reg_write(context, QPC_TX_CQN, get_cqn(ibqp->send_cq));
+	hr_reg_clear(qpc_mask, QPC_TX_CQN);
 
 	if (ibqp->srq) {
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_SRQ_EN_S, 0);
-		roce_set_field(context->byte_76_srqn_op_en,
-			       V2_QPC_BYTE_76_SRQN_M, V2_QPC_BYTE_76_SRQN_S,
-			       to_hr_srq(ibqp->srq)->srqn);
-		roce_set_field(qpc_mask->byte_76_srqn_op_en,
-			       V2_QPC_BYTE_76_SRQN_M, V2_QPC_BYTE_76_SRQN_S, 0);
-	}
-
-	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
-		       V2_QPC_BYTE_4_SQPN_S, hr_qp->qpn);
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
-		       V2_QPC_BYTE_4_SQPN_S, 0);
+		hr_reg_enable(context, QPC_SRQ_EN);
+		hr_reg_clear(qpc_mask, QPC_SRQ_EN);
+		hr_reg_write(context, QPC_SRQN, to_hr_srq(ibqp->srq)->srqn);
+		hr_reg_clear(qpc_mask, QPC_SRQN);
+	}
 
 	if (attr_mask & IB_QP_DEST_QPN) {
-		roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_DQPN_M,
-			       V2_QPC_BYTE_56_DQPN_S, hr_qp->qpn);
-		roce_set_field(qpc_mask->byte_56_dqpn_err,
-			       V2_QPC_BYTE_56_DQPN_M, V2_QPC_BYTE_56_DQPN_S, 0);
+		hr_reg_write(context, QPC_DQPN, hr_qp->qpn);
+		hr_reg_clear(qpc_mask, QPC_DQPN);
 	}
 }
 
@@ -4223,74 +4181,46 @@ static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	roce_set_field(context->byte_12_sq_hop, V2_QPC_BYTE_12_WQE_SGE_BA_M,
-		       V2_QPC_BYTE_12_WQE_SGE_BA_S, wqe_sge_ba >> (32 + 3));
-	roce_set_field(qpc_mask->byte_12_sq_hop, V2_QPC_BYTE_12_WQE_SGE_BA_M,
-		       V2_QPC_BYTE_12_WQE_SGE_BA_S, 0);
-
-	roce_set_field(context->byte_12_sq_hop, V2_QPC_BYTE_12_SQ_HOP_NUM_M,
-		       V2_QPC_BYTE_12_SQ_HOP_NUM_S,
-		       to_hr_hem_hopnum(hr_dev->caps.wqe_sq_hop_num,
-					hr_qp->sq.wqe_cnt));
-	roce_set_field(qpc_mask->byte_12_sq_hop, V2_QPC_BYTE_12_SQ_HOP_NUM_M,
-		       V2_QPC_BYTE_12_SQ_HOP_NUM_S, 0);
-
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
-		       V2_QPC_BYTE_20_SGE_HOP_NUM_S,
-		       to_hr_hem_hopnum(hr_dev->caps.wqe_sge_hop_num,
-					hr_qp->sge.sge_cnt));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
-		       V2_QPC_BYTE_20_SGE_HOP_NUM_S, 0);
-
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_HOP_NUM_M,
-		       V2_QPC_BYTE_20_RQ_HOP_NUM_S,
-		       to_hr_hem_hopnum(hr_dev->caps.wqe_rq_hop_num,
-					hr_qp->rq.wqe_cnt));
-
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_HOP_NUM_M,
-		       V2_QPC_BYTE_20_RQ_HOP_NUM_S, 0);
-
-	roce_set_field(context->byte_16_buf_ba_pg_sz,
-		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M,
-		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S,
-		       to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz,
-		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M,
-		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S, 0);
-
-	roce_set_field(context->byte_16_buf_ba_pg_sz,
-		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M,
-		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S,
-		       to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.buf_pg_shift));
-	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz,
-		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M,
-		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S, 0);
+	hr_reg_write(context, QPC_WQE_SGE_BA_H, wqe_sge_ba >> (32 + 3));
+	hr_reg_clear(qpc_mask, QPC_WQE_SGE_BA_H);
+
+	hr_reg_write(context, QPC_SQ_HOP_NUM,
+		     to_hr_hem_hopnum(hr_dev->caps.wqe_sq_hop_num,
+				      hr_qp->sq.wqe_cnt));
+	hr_reg_clear(qpc_mask, QPC_SQ_HOP_NUM);
+
+	hr_reg_write(context, QPC_SGE_HOP_NUM,
+		     to_hr_hem_hopnum(hr_dev->caps.wqe_sge_hop_num,
+				      hr_qp->sge.sge_cnt));
+	hr_reg_clear(qpc_mask, QPC_SGE_HOP_NUM);
+
+	hr_reg_write(context, QPC_RQ_HOP_NUM,
+		     to_hr_hem_hopnum(hr_dev->caps.wqe_rq_hop_num,
+				      hr_qp->rq.wqe_cnt));
+
+	hr_reg_clear(qpc_mask, QPC_RQ_HOP_NUM);
+
+	hr_reg_write(context, QPC_WQE_SGE_BA_PG_SZ,
+		     to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.ba_pg_shift));
+	hr_reg_clear(qpc_mask, QPC_WQE_SGE_BA_PG_SZ);
+
+	hr_reg_write(context, QPC_WQE_SGE_BUF_PG_SZ,
+		     to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.buf_pg_shift));
+	hr_reg_clear(qpc_mask, QPC_WQE_SGE_BUF_PG_SZ);
 
 	context->rq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 	qpc_mask->rq_cur_blk_addr = 0;
 
-	roce_set_field(context->byte_92_srq_info,
-		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts[0])));
-	roce_set_field(qpc_mask->byte_92_srq_info,
-		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S, 0);
+	hr_reg_write(context, QPC_RQ_CUR_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(mtts[0])));
+	hr_reg_clear(qpc_mask, QPC_RQ_CUR_BLK_ADDR_H);
 
 	context->rq_nxt_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
 	qpc_mask->rq_nxt_blk_addr = 0;
 
-	roce_set_field(context->byte_104_rq_sge,
-		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
-		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts[1])));
-	roce_set_field(qpc_mask->byte_104_rq_sge,
-		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
-		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S, 0);
+	hr_reg_write(context, QPC_RQ_NXT_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
+	hr_reg_clear(qpc_mask, QPC_RQ_NXT_BLK_ADDR_H);
 
 	return 0;
 }
@@ -4329,37 +4259,26 @@ static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	context->sq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
-	roce_set_field(context->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
-	qpc_mask->sq_cur_blk_addr = 0;
-	roce_set_field(qpc_mask->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S, 0);
-
-	context->sq_cur_sge_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(sge_cur_blk));
-	roce_set_field(context->byte_184_irrl_idx,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)));
-	qpc_mask->sq_cur_sge_blk_addr = 0;
-	roce_set_field(qpc_mask->byte_184_irrl_idx,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S, 0);
-
-	context->rx_sq_cur_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
-	roce_set_field(context->byte_232_irrl_sge,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
-	qpc_mask->rx_sq_cur_blk_addr = 0;
-	roce_set_field(qpc_mask->byte_232_irrl_sge,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S, 0);
+	hr_reg_write(context, QPC_SQ_CUR_BLK_ADDR_L,
+		     lower_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
+	hr_reg_write(context, QPC_SQ_CUR_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
+	hr_reg_clear(qpc_mask, QPC_SQ_CUR_BLK_ADDR_L);
+	hr_reg_clear(qpc_mask, QPC_SQ_CUR_BLK_ADDR_H);
+
+	hr_reg_write(context, QPC_SQ_CUR_SGE_BLK_ADDR_L,
+		     lower_32_bits(to_hr_hw_page_addr(sge_cur_blk)));
+	hr_reg_write(context, QPC_SQ_CUR_SGE_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)));
+	hr_reg_clear(qpc_mask, QPC_SQ_CUR_SGE_BLK_ADDR_L);
+	hr_reg_clear(qpc_mask, QPC_SQ_CUR_SGE_BLK_ADDR_H);
+
+	hr_reg_write(context, QPC_RX_SQ_CUR_BLK_ADDR_L,
+		     lower_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
+	hr_reg_write(context, QPC_RX_SQ_CUR_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
+	hr_reg_clear(qpc_mask, QPC_RX_SQ_CUR_BLK_ADDR_L);
+	hr_reg_clear(qpc_mask, QPC_RX_SQ_CUR_BLK_ADDR_H);
 
 	return 0;
 }
@@ -4419,33 +4338,23 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	roce_set_field(context->byte_132_trrl, V2_QPC_BYTE_132_TRRL_BA_M,
-		       V2_QPC_BYTE_132_TRRL_BA_S, trrl_ba >> 4);
-	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_BA_M,
-		       V2_QPC_BYTE_132_TRRL_BA_S, 0);
+	hr_reg_write(context, QPC_TRRL_BA_L, trrl_ba >> 4);
+	hr_reg_clear(qpc_mask, QPC_TRRL_BA_L);
 	context->trrl_ba = cpu_to_le32(trrl_ba >> (16 + 4));
 	qpc_mask->trrl_ba = 0;
-	roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
-		       V2_QPC_BYTE_140_TRRL_BA_S,
-		       (u32)(trrl_ba >> (32 + 16 + 4)));
-	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
-		       V2_QPC_BYTE_140_TRRL_BA_S, 0);
+	hr_reg_write(context, QPC_TRRL_BA_H, trrl_ba >> (32 + 16 + 4));
+	hr_reg_clear(qpc_mask, QPC_TRRL_BA_H);
 
 	context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
 	qpc_mask->irrl_ba = 0;
-	roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
-		       V2_QPC_BYTE_208_IRRL_BA_S,
-		       irrl_ba >> (32 + 6));
-	roce_set_field(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
-		       V2_QPC_BYTE_208_IRRL_BA_S, 0);
+	hr_reg_write(context, QPC_IRRL_BA_H, irrl_ba >> (32 + 6));
+	hr_reg_clear(qpc_mask, QPC_IRRL_BA_H);
 
-	roce_set_bit(context->byte_208_irrl, V2_QPC_BYTE_208_RMT_E2E_S, 1);
-	roce_set_bit(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_RMT_E2E_S, 0);
+	hr_reg_enable(context, QPC_RMT_E2E);
+	hr_reg_clear(qpc_mask, QPC_RMT_E2E);
 
-	roce_set_bit(context->byte_252_err_txcqn, V2_QPC_BYTE_252_SIG_TYPE_S,
-		     hr_qp->sq_signal_bits);
-	roce_set_bit(qpc_mask->byte_252_err_txcqn, V2_QPC_BYTE_252_SIG_TYPE_S,
-		     0);
+	hr_reg_write(context, QPC_SIG_TYPE, hr_qp->sq_signal_bits);
+	hr_reg_clear(qpc_mask, QPC_SIG_TYPE);
 
 	port = (attr_mask & IB_QP_PORT) ? (attr->port_num - 1) : hr_qp->port;
 
@@ -4454,73 +4363,52 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	/* when dmac equals smac or loop_idc is 1, it should loopback */
 	if (ether_addr_equal_unaligned(dmac, smac) ||
 	    hr_dev->loop_idc == 0x1) {
-		roce_set_bit(context->byte_28_at_fl, V2_QPC_BYTE_28_LBI_S, 1);
-		roce_set_bit(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_LBI_S, 0);
+		hr_reg_write(context, QPC_LBI, hr_dev->loop_idc);
+		hr_reg_clear(qpc_mask, QPC_LBI);
 	}
 
 	if (attr_mask & IB_QP_DEST_QPN) {
-		roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_DQPN_M,
-			       V2_QPC_BYTE_56_DQPN_S, attr->dest_qp_num);
-		roce_set_field(qpc_mask->byte_56_dqpn_err,
-			       V2_QPC_BYTE_56_DQPN_M, V2_QPC_BYTE_56_DQPN_S, 0);
+		hr_reg_write(context, QPC_DQPN, attr->dest_qp_num);
+		hr_reg_clear(qpc_mask, QPC_DQPN);
 	}
 
 	memcpy(&(context->dmac), dmac, sizeof(u32));
-	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
-		       V2_QPC_BYTE_52_DMAC_S, *((u16 *)(&dmac[4])));
+	hr_reg_write(context, QPC_DMAC_H, *((u16 *)(&dmac[4])));
 	qpc_mask->dmac = 0;
-	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
-		       V2_QPC_BYTE_52_DMAC_S, 0);
+	hr_reg_clear(qpc_mask, QPC_DMAC_H);
 
 	mtu = get_mtu(ibqp, attr);
 	hr_qp->path_mtu = mtu;
 
 	if (attr_mask & IB_QP_PATH_MTU) {
-		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
-			       V2_QPC_BYTE_24_MTU_S, mtu);
-		roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
-			       V2_QPC_BYTE_24_MTU_S, 0);
+		hr_reg_write(context, QPC_MTU, mtu);
+		hr_reg_clear(qpc_mask, QPC_MTU);
 	}
 
 #define MAX_LP_MSG_LEN 65536
 	/* MTU * (2 ^ LP_PKTN_INI) shouldn't be bigger than 64KB */
 	lp_pktn_ini = ilog2(MAX_LP_MSG_LEN / ib_mtu_enum_to_int(mtu));
 
-	roce_set_field(context->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
-		       V2_QPC_BYTE_56_LP_PKTN_INI_S, lp_pktn_ini);
-	roce_set_field(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_LP_PKTN_INI_M,
-		       V2_QPC_BYTE_56_LP_PKTN_INI_S, 0);
+	hr_reg_write(context, QPC_LP_PKTN_INI, lp_pktn_ini);
+	hr_reg_clear(qpc_mask, QPC_LP_PKTN_INI);
 
 	/* ACK_REQ_FREQ should be larger than or equal to LP_PKTN_INI */
-	roce_set_field(context->byte_172_sq_psn, V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, lp_pktn_ini);
-	roce_set_field(qpc_mask->byte_172_sq_psn,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, 0);
-
-	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
-		     V2_QPC_BYTE_108_RX_REQ_PSN_ERR_S, 0);
-	roce_set_field(qpc_mask->byte_96_rx_reqmsn, V2_QPC_BYTE_96_RX_REQ_MSN_M,
-		       V2_QPC_BYTE_96_RX_REQ_MSN_S, 0);
-	roce_set_field(qpc_mask->byte_108_rx_reqepsn,
-		       V2_QPC_BYTE_108_RX_REQ_LAST_OPTYPE_M,
-		       V2_QPC_BYTE_108_RX_REQ_LAST_OPTYPE_S, 0);
+	hr_reg_write(context, QPC_ACK_REQ_FREQ, lp_pktn_ini);
+	hr_reg_clear(qpc_mask, QPC_ACK_REQ_FREQ);
+
+	hr_reg_clear(qpc_mask, QPC_RX_REQ_PSN_ERR);
+	hr_reg_clear(qpc_mask, QPC_RX_REQ_MSN);
+	hr_reg_clear(qpc_mask, QPC_RX_REQ_LAST_OPTYPE);
 
 	context->rq_rnr_timer = 0;
 	qpc_mask->rq_rnr_timer = 0;
 
-	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_HEAD_MAX_M,
-		       V2_QPC_BYTE_132_TRRL_HEAD_MAX_S, 0);
-	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_TAIL_MAX_M,
-		       V2_QPC_BYTE_132_TRRL_TAIL_MAX_S, 0);
+	hr_reg_clear(qpc_mask, QPC_TRRL_HEAD_MAX);
+	hr_reg_clear(qpc_mask, QPC_TRRL_TAIL_MAX);
 
 	/* rocee send 2^lp_sgen_ini segs every time */
-	roce_set_field(context->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_LP_SGEN_INI_M,
-		       V2_QPC_BYTE_168_LP_SGEN_INI_S, 3);
-	roce_set_field(qpc_mask->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_LP_SGEN_INI_M,
-		       V2_QPC_BYTE_168_LP_SGEN_INI_S, 0);
+	hr_reg_write(context, QPC_LP_SGEN_INI, 3);
+	hr_reg_clear(qpc_mask, QPC_LP_SGEN_INI);
 
 	return 0;
 }
@@ -4552,44 +4440,26 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	 * of all fields in context are zero, we need not set them to 0 again.
 	 * but we should set the relevant fields of context mask to 0.
 	 */
-	roce_set_field(qpc_mask->byte_232_irrl_sge,
-		       V2_QPC_BYTE_232_IRRL_SGE_IDX_M,
-		       V2_QPC_BYTE_232_IRRL_SGE_IDX_S, 0);
+	hr_reg_clear(qpc_mask, QPC_IRRL_SGE_IDX);
 
-	roce_set_field(qpc_mask->byte_240_irrl_tail,
-		       V2_QPC_BYTE_240_RX_ACK_MSN_M,
-		       V2_QPC_BYTE_240_RX_ACK_MSN_S, 0);
+	hr_reg_clear(qpc_mask, QPC_RX_ACK_MSN);
 
-	roce_set_field(qpc_mask->byte_248_ack_psn,
-		       V2_QPC_BYTE_248_ACK_LAST_OPTYPE_M,
-		       V2_QPC_BYTE_248_ACK_LAST_OPTYPE_S, 0);
-	roce_set_bit(qpc_mask->byte_248_ack_psn,
-		     V2_QPC_BYTE_248_IRRL_PSN_VLD_S, 0);
-	roce_set_field(qpc_mask->byte_248_ack_psn,
-		       V2_QPC_BYTE_248_IRRL_PSN_M,
-		       V2_QPC_BYTE_248_IRRL_PSN_S, 0);
+	hr_reg_clear(qpc_mask, QPC_ACK_LAST_OPTYPE);
+	hr_reg_clear(qpc_mask, QPC_IRRL_PSN_VLD);
+	hr_reg_clear(qpc_mask, QPC_IRRL_PSN);
 
-	roce_set_field(qpc_mask->byte_240_irrl_tail,
-		       V2_QPC_BYTE_240_IRRL_TAIL_REAL_M,
-		       V2_QPC_BYTE_240_IRRL_TAIL_REAL_S, 0);
+	hr_reg_clear(qpc_mask, QPC_IRRL_TAIL_REAL);
 
-	roce_set_field(qpc_mask->byte_220_retry_psn_msn,
-		       V2_QPC_BYTE_220_RETRY_MSG_MSN_M,
-		       V2_QPC_BYTE_220_RETRY_MSG_MSN_S, 0);
+	hr_reg_clear(qpc_mask, QPC_RETRY_MSG_MSN);
 
-	roce_set_bit(qpc_mask->byte_248_ack_psn,
-		     V2_QPC_BYTE_248_RNR_RETRY_FLAG_S, 0);
+	hr_reg_clear(qpc_mask, QPC_RNR_RETRY_FLAG);
 
-	roce_set_field(qpc_mask->byte_212_lsn, V2_QPC_BYTE_212_CHECK_FLG_M,
-		       V2_QPC_BYTE_212_CHECK_FLG_S, 0);
+	hr_reg_clear(qpc_mask, QPC_CHECK_FLG);
 
-	roce_set_field(context->byte_212_lsn, V2_QPC_BYTE_212_LSN_M,
-		       V2_QPC_BYTE_212_LSN_S, 0x100);
-	roce_set_field(qpc_mask->byte_212_lsn, V2_QPC_BYTE_212_LSN_M,
-		       V2_QPC_BYTE_212_LSN_S, 0);
+	hr_reg_write(context, QPC_LSN, 0x100);
+	hr_reg_clear(qpc_mask, QPC_LSN);
 
-	roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_IRRL_HEAD_M,
-		       V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
+	hr_reg_clear(qpc_mask, QPC_V2_IRRL_HEAD);
 
 	return 0;
 }
@@ -4714,14 +4584,14 @@ static int fill_cong_field(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 
 	hr_reg_write(context, QPC_CONG_ALGO_TMPL_ID, hr_dev->cong_algo_tmpl_id +
 		     hr_dev->caps.cong_type * HNS_ROCE_CONG_SIZE);
-	hr_reg_write(qpc_mask, QPC_CONG_ALGO_TMPL_ID, 0);
+	hr_reg_clear(qpc_mask, QPC_CONG_ALGO_TMPL_ID);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SEL, cong_field.alg_sel);
-	hr_reg_write(&qpc_mask->ext, QPCEX_CONG_ALG_SEL, 0);
+	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SEL);
 	hr_reg_write(&context->ext, QPCEX_CONG_ALG_SUB_SEL,
 		     cong_field.alg_sub_sel);
-	hr_reg_write(&qpc_mask->ext, QPCEX_CONG_ALG_SUB_SEL, 0);
+	hr_reg_clear(&qpc_mask->ext, QPCEX_CONG_ALG_SUB_SEL);
 	hr_reg_write(&context->ext, QPCEX_DIP_CTX_IDX_VLD, cong_field.dip_vld);
-	hr_reg_write(&qpc_mask->ext, QPCEX_DIP_CTX_IDX_VLD, 0);
+	hr_reg_clear(&qpc_mask->ext, QPCEX_DIP_CTX_IDX_VLD);
 
 	/* if dip is disabled, there is no need to set dip idx */
 	if (cong_field.dip_vld == 0)
@@ -4776,20 +4646,14 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	/* Only HIP08 needs to set the vlan_en bits in QPC */
 	if (vlan_id < VLAN_N_VID &&
 	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
-		roce_set_bit(context->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 1);
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 0);
-		roce_set_bit(context->byte_168_irrl_idx,
-			     V2_QPC_BYTE_168_SQ_VLAN_EN_S, 1);
-		roce_set_bit(qpc_mask->byte_168_irrl_idx,
-			     V2_QPC_BYTE_168_SQ_VLAN_EN_S, 0);
+		hr_reg_enable(qpc_mask, QPC_RQ_VLAN_EN);
+		hr_reg_clear(qpc_mask, QPC_RQ_VLAN_EN);
+		hr_reg_enable(qpc_mask, QPC_SQ_VLAN_EN);
+		hr_reg_clear(qpc_mask, QPC_SQ_VLAN_EN);
 	}
 
-	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
-		       V2_QPC_BYTE_24_VLAN_ID_S, vlan_id);
-	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
-		       V2_QPC_BYTE_24_VLAN_ID_S, 0);
+	hr_reg_write(context, QPC_VLAN_ID, vlan_id);
+	hr_reg_clear(qpc_mask, QPC_VLAN_ID);
 
 	if (grh->sgid_index >= hr_dev->caps.gid_table_len[hr_port]) {
 		ibdev_err(ibdev, "sgid_index(%u) too large. max is %d\n",
@@ -4802,39 +4666,28 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_UDPSPN_M,
-		       V2_QPC_BYTE_52_UDPSPN_S,
-		       is_udp ? get_udp_sport(grh->flow_label, ibqp->qp_num,
-					      attr->dest_qp_num) : 0);
+	hr_reg_write(context, QPC_UDPSPN,
+		     is_udp ? get_udp_sport(grh->flow_label, ibqp->qp_num,
+					    attr->dest_qp_num) : 0);
 
-	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_UDPSPN_M,
-		       V2_QPC_BYTE_52_UDPSPN_S, 0);
+	hr_reg_clear(qpc_mask, QPC_UDPSPN);
 
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S,
-		       grh->sgid_index);
+	hr_reg_write(context, QPC_GMV_IDX, grh->sgid_index);
 
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S, 0);
+	hr_reg_clear(qpc_mask, QPC_GMV_IDX);
 
-	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
-		       V2_QPC_BYTE_24_HOP_LIMIT_S, grh->hop_limit);
-	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
-		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
+	hr_reg_write(context, QPC_HOPLIMIT, grh->hop_limit);
+	hr_reg_clear(qpc_mask, QPC_HOPLIMIT);
 
 	ret = fill_cong_field(ibqp, attr, context, qpc_mask);
 	if (ret)
 		return ret;
 
-	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-		       V2_QPC_BYTE_24_TC_S, get_tclass(&attr->ah_attr.grh));
-	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-		       V2_QPC_BYTE_24_TC_S, 0);
+	hr_reg_write(context, QPC_TC, get_tclass(&attr->ah_attr.grh));
+	hr_reg_clear(qpc_mask, QPC_TC);
 
-	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
-		       V2_QPC_BYTE_28_FL_S, grh->flow_label);
-	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
-		       V2_QPC_BYTE_28_FL_S, 0);
+	hr_reg_write(context, QPC_FL, grh->flow_label);
+	hr_reg_clear(qpc_mask, QPC_FL);
 	memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
 	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
 
@@ -4846,10 +4699,8 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
-		       V2_QPC_BYTE_28_SL_S, hr_qp->sl);
-	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
-		       V2_QPC_BYTE_28_SL_S, 0);
+	hr_reg_write(context, QPC_SL, hr_qp->sl);
+	hr_reg_clear(qpc_mask, QPC_SL);
 
 	return 0;
 }
@@ -4931,12 +4782,8 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 
 	if (attr_mask & IB_QP_TIMEOUT) {
 		if (attr->timeout < 31) {
-			roce_set_field(context->byte_28_at_fl,
-				       V2_QPC_BYTE_28_AT_M, V2_QPC_BYTE_28_AT_S,
-				       attr->timeout);
-			roce_set_field(qpc_mask->byte_28_at_fl,
-				       V2_QPC_BYTE_28_AT_M, V2_QPC_BYTE_28_AT_S,
-				       0);
+			hr_reg_write(context, QPC_AT, attr->timeout);
+			hr_reg_clear(qpc_mask, QPC_AT);
 		} else {
 			ibdev_warn(&hr_dev->ib_dev,
 				   "Local ACK timeout shall be 0 to 30.\n");
@@ -4944,128 +4791,68 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 	}
 
 	if (attr_mask & IB_QP_RETRY_CNT) {
-		roce_set_field(context->byte_212_lsn,
-			       V2_QPC_BYTE_212_RETRY_NUM_INIT_M,
-			       V2_QPC_BYTE_212_RETRY_NUM_INIT_S,
-			       attr->retry_cnt);
-		roce_set_field(qpc_mask->byte_212_lsn,
-			       V2_QPC_BYTE_212_RETRY_NUM_INIT_M,
-			       V2_QPC_BYTE_212_RETRY_NUM_INIT_S, 0);
-
-		roce_set_field(context->byte_212_lsn,
-			       V2_QPC_BYTE_212_RETRY_CNT_M,
-			       V2_QPC_BYTE_212_RETRY_CNT_S, attr->retry_cnt);
-		roce_set_field(qpc_mask->byte_212_lsn,
-			       V2_QPC_BYTE_212_RETRY_CNT_M,
-			       V2_QPC_BYTE_212_RETRY_CNT_S, 0);
+		hr_reg_write(context, QPC_RETRY_NUM_INIT, attr->retry_cnt);
+		hr_reg_clear(qpc_mask, QPC_RETRY_NUM_INIT);
+
+		hr_reg_write(context, QPC_RETRY_CNT, attr->retry_cnt);
+		hr_reg_clear(qpc_mask, QPC_RETRY_CNT);
 	}
 
 	if (attr_mask & IB_QP_RNR_RETRY) {
-		roce_set_field(context->byte_244_rnr_rxack,
-			       V2_QPC_BYTE_244_RNR_NUM_INIT_M,
-			       V2_QPC_BYTE_244_RNR_NUM_INIT_S, attr->rnr_retry);
-		roce_set_field(qpc_mask->byte_244_rnr_rxack,
-			       V2_QPC_BYTE_244_RNR_NUM_INIT_M,
-			       V2_QPC_BYTE_244_RNR_NUM_INIT_S, 0);
+		hr_reg_write(context, QPC_RNR_NUM_INIT, attr->rnr_retry);
+		hr_reg_clear(qpc_mask, QPC_RNR_NUM_INIT);
 
-		roce_set_field(context->byte_244_rnr_rxack,
-			       V2_QPC_BYTE_244_RNR_CNT_M,
-			       V2_QPC_BYTE_244_RNR_CNT_S, attr->rnr_retry);
-		roce_set_field(qpc_mask->byte_244_rnr_rxack,
-			       V2_QPC_BYTE_244_RNR_CNT_M,
-			       V2_QPC_BYTE_244_RNR_CNT_S, 0);
+		hr_reg_write(context, QPC_RNR_CNT, attr->rnr_retry);
+		hr_reg_clear(qpc_mask, QPC_RNR_CNT);
 	}
 
 	if (attr_mask & IB_QP_SQ_PSN) {
-		roce_set_field(context->byte_172_sq_psn,
-			       V2_QPC_BYTE_172_SQ_CUR_PSN_M,
-			       V2_QPC_BYTE_172_SQ_CUR_PSN_S, attr->sq_psn);
-		roce_set_field(qpc_mask->byte_172_sq_psn,
-			       V2_QPC_BYTE_172_SQ_CUR_PSN_M,
-			       V2_QPC_BYTE_172_SQ_CUR_PSN_S, 0);
-
-		roce_set_field(context->byte_196_sq_psn,
-			       V2_QPC_BYTE_196_SQ_MAX_PSN_M,
-			       V2_QPC_BYTE_196_SQ_MAX_PSN_S, attr->sq_psn);
-		roce_set_field(qpc_mask->byte_196_sq_psn,
-			       V2_QPC_BYTE_196_SQ_MAX_PSN_M,
-			       V2_QPC_BYTE_196_SQ_MAX_PSN_S, 0);
-
-		roce_set_field(context->byte_220_retry_psn_msn,
-			       V2_QPC_BYTE_220_RETRY_MSG_PSN_M,
-			       V2_QPC_BYTE_220_RETRY_MSG_PSN_S, attr->sq_psn);
-		roce_set_field(qpc_mask->byte_220_retry_psn_msn,
-			       V2_QPC_BYTE_220_RETRY_MSG_PSN_M,
-			       V2_QPC_BYTE_220_RETRY_MSG_PSN_S, 0);
-
-		roce_set_field(context->byte_224_retry_msg,
-			       V2_QPC_BYTE_224_RETRY_MSG_PSN_M,
-			       V2_QPC_BYTE_224_RETRY_MSG_PSN_S,
-			       attr->sq_psn >> V2_QPC_BYTE_220_RETRY_MSG_PSN_S);
-		roce_set_field(qpc_mask->byte_224_retry_msg,
-			       V2_QPC_BYTE_224_RETRY_MSG_PSN_M,
-			       V2_QPC_BYTE_224_RETRY_MSG_PSN_S, 0);
-
-		roce_set_field(context->byte_224_retry_msg,
-			       V2_QPC_BYTE_224_RETRY_MSG_FPKT_PSN_M,
-			       V2_QPC_BYTE_224_RETRY_MSG_FPKT_PSN_S,
-			       attr->sq_psn);
-		roce_set_field(qpc_mask->byte_224_retry_msg,
-			       V2_QPC_BYTE_224_RETRY_MSG_FPKT_PSN_M,
-			       V2_QPC_BYTE_224_RETRY_MSG_FPKT_PSN_S, 0);
-
-		roce_set_field(context->byte_244_rnr_rxack,
-			       V2_QPC_BYTE_244_RX_ACK_EPSN_M,
-			       V2_QPC_BYTE_244_RX_ACK_EPSN_S, attr->sq_psn);
-		roce_set_field(qpc_mask->byte_244_rnr_rxack,
-			       V2_QPC_BYTE_244_RX_ACK_EPSN_M,
-			       V2_QPC_BYTE_244_RX_ACK_EPSN_S, 0);
+		hr_reg_write(context, QPC_SQ_CUR_PSN, attr->sq_psn);
+		hr_reg_clear(qpc_mask, QPC_SQ_CUR_PSN);
+
+		hr_reg_write(context, QPC_SQ_MAX_PSN, attr->sq_psn);
+		hr_reg_clear(qpc_mask, QPC_SQ_MAX_PSN);
+
+		hr_reg_write(context, QPC_RETRY_MSG_PSN_L, attr->sq_psn);
+		hr_reg_clear(qpc_mask, QPC_RETRY_MSG_PSN_L);
+
+		hr_reg_write(context, QPC_RETRY_MSG_PSN_H,
+			     attr->sq_psn >> RETRY_MSG_PSN_SHIFT);
+		hr_reg_clear(qpc_mask, QPC_RETRY_MSG_PSN_H);
+
+		hr_reg_write(context, QPC_RETRY_MSG_FPKT_PSN, attr->sq_psn);
+		hr_reg_clear(qpc_mask, QPC_RETRY_MSG_FPKT_PSN);
+
+		hr_reg_write(context, QPC_RX_ACK_EPSN, attr->sq_psn);
+		hr_reg_clear(qpc_mask, QPC_RX_ACK_EPSN);
 	}
 
 	if ((attr_mask & IB_QP_MAX_DEST_RD_ATOMIC) &&
 	     attr->max_dest_rd_atomic) {
-		roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
-			       V2_QPC_BYTE_140_RR_MAX_S,
-			       fls(attr->max_dest_rd_atomic - 1));
-		roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RR_MAX_M,
-			       V2_QPC_BYTE_140_RR_MAX_S, 0);
+		hr_reg_write(context, QPC_RR_MAX,
+			     fls(attr->max_dest_rd_atomic - 1));
+		hr_reg_clear(qpc_mask, QPC_RR_MAX);
 	}
 
 	if ((attr_mask & IB_QP_MAX_QP_RD_ATOMIC) && attr->max_rd_atomic) {
-		roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_SR_MAX_M,
-			       V2_QPC_BYTE_208_SR_MAX_S,
-			       fls(attr->max_rd_atomic - 1));
-		roce_set_field(qpc_mask->byte_208_irrl,
-			       V2_QPC_BYTE_208_SR_MAX_M,
-			       V2_QPC_BYTE_208_SR_MAX_S, 0);
+		hr_reg_write(context, QPC_SR_MAX, fls(attr->max_rd_atomic - 1));
+		hr_reg_clear(qpc_mask, QPC_SR_MAX);
 	}
 
 	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC))
 		set_access_flags(hr_qp, context, qpc_mask, attr, attr_mask);
 
 	if (attr_mask & IB_QP_MIN_RNR_TIMER) {
-		roce_set_field(context->byte_80_rnr_rx_cqn,
-			       V2_QPC_BYTE_80_MIN_RNR_TIME_M,
-			       V2_QPC_BYTE_80_MIN_RNR_TIME_S,
-			       attr->min_rnr_timer);
-		roce_set_field(qpc_mask->byte_80_rnr_rx_cqn,
-			       V2_QPC_BYTE_80_MIN_RNR_TIME_M,
-			       V2_QPC_BYTE_80_MIN_RNR_TIME_S, 0);
+		hr_reg_write(context, QPC_MIN_RNR_TIME, attr->min_rnr_timer);
+		hr_reg_clear(qpc_mask, QPC_MIN_RNR_TIME);
 	}
 
 	if (attr_mask & IB_QP_RQ_PSN) {
-		roce_set_field(context->byte_108_rx_reqepsn,
-			       V2_QPC_BYTE_108_RX_REQ_EPSN_M,
-			       V2_QPC_BYTE_108_RX_REQ_EPSN_S, attr->rq_psn);
-		roce_set_field(qpc_mask->byte_108_rx_reqepsn,
-			       V2_QPC_BYTE_108_RX_REQ_EPSN_M,
-			       V2_QPC_BYTE_108_RX_REQ_EPSN_S, 0);
+		hr_reg_write(context, QPC_RX_REQ_EPSN, attr->rq_psn);
+		hr_reg_clear(qpc_mask, QPC_RX_REQ_EPSN);
 
-		roce_set_field(context->byte_152_raq, V2_QPC_BYTE_152_RAQ_PSN_M,
-			       V2_QPC_BYTE_152_RAQ_PSN_S, attr->rq_psn - 1);
-		roce_set_field(qpc_mask->byte_152_raq,
-			       V2_QPC_BYTE_152_RAQ_PSN_M,
-			       V2_QPC_BYTE_152_RAQ_PSN_S, 0);
+		hr_reg_write(context, QPC_RAQ_PSN, attr->rq_psn - 1);
+		hr_reg_clear(qpc_mask, QPC_RAQ_PSN);
 	}
 
 	if (attr_mask & IB_QP_QKEY) {
@@ -5118,6 +4905,32 @@ static void clear_qp(struct hns_roce_qp *hr_qp)
 	hr_qp->next_sge = 0;
 }
 
+static void v2_set_flushed_fields(struct ib_qp *ibqp,
+				  struct hns_roce_v2_qp_context *context,
+				  struct hns_roce_v2_qp_context *qpc_mask)
+{
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	unsigned long sq_flag = 0;
+	unsigned long rq_flag = 0;
+
+	if (ibqp->qp_type == IB_QPT_XRC_TGT)
+		return;
+
+	spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
+	hr_reg_write(context, QPC_SQ_PRODUCER_IDX, hr_qp->sq.head);
+	hr_reg_clear(qpc_mask, QPC_SQ_PRODUCER_IDX);
+	hr_qp->state = IB_QPS_ERR;
+	spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
+
+	if (ibqp->srq || ibqp->qp_type == IB_QPT_XRC_INI) /* no RQ */
+		return;
+
+	spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
+	hr_reg_write(context, QPC_RQ_PRODUCER_IDX, hr_qp->rq.head);
+	hr_reg_clear(qpc_mask, QPC_RQ_PRODUCER_IDX);
+	spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flag);
+}
+
 static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				 const struct ib_qp_attr *attr,
 				 int attr_mask, enum ib_qp_state cur_state,
@@ -5129,8 +4942,6 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	struct hns_roce_v2_qp_context *context = ctx;
 	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	unsigned long sq_flag = 0;
-	unsigned long rq_flag = 0;
 	int ret;
 
 	if (attr_mask & ~IB_QP_ATTR_STANDARD_BITS)
@@ -5151,34 +4962,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		goto out;
 
 	/* When QP state is err, SQ and RQ WQE should be flushed */
-	if (new_state == IB_QPS_ERR) {
-		if (ibqp->qp_type != IB_QPT_XRC_TGT) {
-			spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
-			hr_qp->state = IB_QPS_ERR;
-			roce_set_field(context->byte_160_sq_ci_pi,
-				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
-				       hr_qp->sq.head);
-			roce_set_field(qpc_mask->byte_160_sq_ci_pi,
-				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-				       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
-			spin_unlock_irqrestore(&hr_qp->sq.lock, sq_flag);
-		}
-
-		if (!ibqp->srq && ibqp->qp_type != IB_QPT_XRC_INI &&
-		    ibqp->qp_type != IB_QPT_XRC_TGT) {
-			spin_lock_irqsave(&hr_qp->rq.lock, rq_flag);
-			hr_qp->state = IB_QPS_ERR;
-			roce_set_field(context->byte_84_rq_ci_pi,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
-			       hr_qp->rq.head);
-			roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
-			spin_unlock_irqrestore(&hr_qp->rq.lock, rq_flag);
-		}
-	}
+	if (new_state == IB_QPS_ERR)
+		v2_set_flushed_fields(ibqp, context, qpc_mask);
 
 	/* Configure the optional fields */
 	ret = hns_roce_v2_set_opt_fields(ibqp, attr, attr_mask, context,
@@ -5186,17 +4971,14 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	if (ret)
 		goto out;
 
-	roce_set_bit(context->byte_108_rx_reqepsn, V2_QPC_BYTE_108_INV_CREDIT_S,
+	hr_reg_write(context, QPC_INV_CREDIT,
 		     ((to_hr_qp_type(hr_qp->ibqp.qp_type) == SERV_TYPE_XRC) ||
 		     ibqp->srq) ? 1 : 0);
-	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
-		     V2_QPC_BYTE_108_INV_CREDIT_S, 0);
+	hr_reg_clear(qpc_mask, QPC_INV_CREDIT);
 
 	/* Every status migrate must change state */
-	roce_set_field(context->byte_60_qpst_tempid, V2_QPC_BYTE_60_QP_ST_M,
-		       V2_QPC_BYTE_60_QP_ST_S, new_state);
-	roce_set_field(qpc_mask->byte_60_qpst_tempid, V2_QPC_BYTE_60_QP_ST_M,
-		       V2_QPC_BYTE_60_QP_ST_S, 0);
+	hr_reg_write(context, QPC_QP_ST, new_state);
+	hr_reg_clear(qpc_mask, QPC_QP_ST);
 
 	/* SW pass context to HW */
 	ret = hns_roce_v2_qp_modify(hr_dev, context, qpc_mask, hr_qp);
@@ -5286,8 +5068,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		goto out;
 	}
 
-	state = roce_get_field(context.byte_60_qpst_tempid,
-			       V2_QPC_BYTE_60_QP_ST_M, V2_QPC_BYTE_60_QP_ST_S);
+	state = hr_reg_read(&context, QPC_QP_ST);
 	tmp_qp_state = to_ib_qp_st((enum hns_roce_v2_qp_state)state);
 	if (tmp_qp_state == -1) {
 		ibdev_err(ibdev, "Illegal ib_qp_state\n");
@@ -5296,77 +5077,45 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	}
 	hr_qp->state = (u8)tmp_qp_state;
 	qp_attr->qp_state = (enum ib_qp_state)hr_qp->state;
-	qp_attr->path_mtu = (enum ib_mtu)roce_get_field(context.byte_24_mtu_tc,
-							V2_QPC_BYTE_24_MTU_M,
-							V2_QPC_BYTE_24_MTU_S);
+	qp_attr->path_mtu = (enum ib_mtu)hr_reg_read(&context, QPC_MTU);
 	qp_attr->path_mig_state = IB_MIG_ARMED;
-	qp_attr->ah_attr.type   = RDMA_AH_ATTR_TYPE_ROCE;
+	qp_attr->ah_attr.type = RDMA_AH_ATTR_TYPE_ROCE;
 	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
 		qp_attr->qkey = le32_to_cpu(context.qkey_xrcd);
 
-	qp_attr->rq_psn = roce_get_field(context.byte_108_rx_reqepsn,
-					 V2_QPC_BYTE_108_RX_REQ_EPSN_M,
-					 V2_QPC_BYTE_108_RX_REQ_EPSN_S);
-	qp_attr->sq_psn = (u32)roce_get_field(context.byte_172_sq_psn,
-					      V2_QPC_BYTE_172_SQ_CUR_PSN_M,
-					      V2_QPC_BYTE_172_SQ_CUR_PSN_S);
-	qp_attr->dest_qp_num = (u8)roce_get_field(context.byte_56_dqpn_err,
-						  V2_QPC_BYTE_56_DQPN_M,
-						  V2_QPC_BYTE_56_DQPN_S);
-	qp_attr->qp_access_flags = ((roce_get_bit(context.byte_76_srqn_op_en,
-				    V2_QPC_BYTE_76_RRE_S)) << V2_QP_RRE_S) |
-				    ((roce_get_bit(context.byte_76_srqn_op_en,
-				    V2_QPC_BYTE_76_RWE_S)) << V2_QP_RWE_S) |
-				    ((roce_get_bit(context.byte_76_srqn_op_en,
-				    V2_QPC_BYTE_76_ATE_S)) << V2_QP_ATE_S);
+	qp_attr->rq_psn = hr_reg_read(&context, QPC_RX_REQ_EPSN);
+	qp_attr->sq_psn = (u32)hr_reg_read(&context, QPC_SQ_CUR_PSN);
+	qp_attr->dest_qp_num = (u8)hr_reg_read(&context, QPC_DQPN);
+	qp_attr->qp_access_flags =
+		((hr_reg_read(&context, QPC_RRE)) << V2_QP_RRE_S) |
+		((hr_reg_read(&context, QPC_RWE)) << V2_QP_RWE_S) |
+		((hr_reg_read(&context, QPC_ATE)) << V2_QP_ATE_S);
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC ||
 	    hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
 	    hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT) {
 		struct ib_global_route *grh =
-				rdma_ah_retrieve_grh(&qp_attr->ah_attr);
+			rdma_ah_retrieve_grh(&qp_attr->ah_attr);
 
 		rdma_ah_set_sl(&qp_attr->ah_attr,
-			       roce_get_field(context.byte_28_at_fl,
-					      V2_QPC_BYTE_28_SL_M,
-					      V2_QPC_BYTE_28_SL_S));
-		grh->flow_label = roce_get_field(context.byte_28_at_fl,
-						 V2_QPC_BYTE_28_FL_M,
-						 V2_QPC_BYTE_28_FL_S);
-		grh->sgid_index = roce_get_field(context.byte_20_smac_sgid_idx,
-						 V2_QPC_BYTE_20_SGID_IDX_M,
-						 V2_QPC_BYTE_20_SGID_IDX_S);
-		grh->hop_limit = roce_get_field(context.byte_24_mtu_tc,
-						V2_QPC_BYTE_24_HOP_LIMIT_M,
-						V2_QPC_BYTE_24_HOP_LIMIT_S);
-		grh->traffic_class = roce_get_field(context.byte_24_mtu_tc,
-						    V2_QPC_BYTE_24_TC_M,
-						    V2_QPC_BYTE_24_TC_S);
+			       hr_reg_read(&context, QPC_SL));
+		grh->flow_label = hr_reg_read(&context, QPC_FL);
+		grh->sgid_index = hr_reg_read(&context, QPC_GMV_IDX);
+		grh->hop_limit = hr_reg_read(&context, QPC_HOPLIMIT);
+		grh->traffic_class = hr_reg_read(&context, QPC_TC);
 
 		memcpy(grh->dgid.raw, context.dgid, sizeof(grh->dgid.raw));
 	}
 
 	qp_attr->port_num = hr_qp->port + 1;
 	qp_attr->sq_draining = 0;
-	qp_attr->max_rd_atomic = 1 << roce_get_field(context.byte_208_irrl,
-						     V2_QPC_BYTE_208_SR_MAX_M,
-						     V2_QPC_BYTE_208_SR_MAX_S);
-	qp_attr->max_dest_rd_atomic = 1 << roce_get_field(context.byte_140_raq,
-						     V2_QPC_BYTE_140_RR_MAX_M,
-						     V2_QPC_BYTE_140_RR_MAX_S);
-
-	qp_attr->min_rnr_timer = (u8)roce_get_field(context.byte_80_rnr_rx_cqn,
-						 V2_QPC_BYTE_80_MIN_RNR_TIME_M,
-						 V2_QPC_BYTE_80_MIN_RNR_TIME_S);
-	qp_attr->timeout = (u8)roce_get_field(context.byte_28_at_fl,
-					      V2_QPC_BYTE_28_AT_M,
-					      V2_QPC_BYTE_28_AT_S);
-	qp_attr->retry_cnt = roce_get_field(context.byte_212_lsn,
-					    V2_QPC_BYTE_212_RETRY_NUM_INIT_M,
-					    V2_QPC_BYTE_212_RETRY_NUM_INIT_S);
-	qp_attr->rnr_retry = roce_get_field(context.byte_244_rnr_rxack,
-					    V2_QPC_BYTE_244_RNR_NUM_INIT_M,
-					    V2_QPC_BYTE_244_RNR_NUM_INIT_S);
+	qp_attr->max_rd_atomic = 1 << hr_reg_read(&context, QPC_SR_MAX);
+	qp_attr->max_dest_rd_atomic = 1 << hr_reg_read(&context, QPC_RR_MAX);
+
+	qp_attr->min_rnr_timer = (u8)hr_reg_read(&context, QPC_MIN_RNR_TIME);
+	qp_attr->timeout = (u8)hr_reg_read(&context, QPC_AT);
+	qp_attr->retry_cnt = hr_reg_read(&context, QPC_RETRY_NUM_INIT);
+	qp_attr->rnr_retry = hr_reg_read(&context, QPC_RNR_NUM_INIT);
 
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index ce7068d..b47e02c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -587,372 +587,192 @@ struct hns_roce_v2_qp_context {
 
 #define QPC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_qp_context, h, l)
 
+#define QPC_TST QPC_FIELD_LOC(2, 0)
+#define QPC_SGE_SHIFT QPC_FIELD_LOC(7, 3)
+#define QPC_CNP_TIMER QPC_FIELD_LOC(31, 8)
+#define QPC_WQE_SGE_BA_L QPC_FIELD_LOC(63, 32)
+#define QPC_WQE_SGE_BA_H QPC_FIELD_LOC(92, 64)
+#define QPC_SQ_HOP_NUM QPC_FIELD_LOC(94, 93)
+#define QPC_CIRE_EN QPC_FIELD_LOC(95, 95)
+#define QPC_WQE_SGE_BA_PG_SZ QPC_FIELD_LOC(99, 96)
+#define QPC_WQE_SGE_BUF_PG_SZ QPC_FIELD_LOC(103, 100)
+#define QPC_PD QPC_FIELD_LOC(127, 104)
+#define QPC_RQ_HOP_NUM QPC_FIELD_LOC(129, 128)
+#define QPC_SGE_HOP_NUM QPC_FIELD_LOC(131, 130)
+#define QPC_RQWS QPC_FIELD_LOC(135, 132)
+#define QPC_SQ_SHIFT QPC_FIELD_LOC(139, 136)
+#define QPC_RQ_SHIFT QPC_FIELD_LOC(143, 140)
+#define QPC_GMV_IDX QPC_FIELD_LOC(159, 144)
+#define QPC_HOPLIMIT QPC_FIELD_LOC(167, 160)
+#define QPC_TC QPC_FIELD_LOC(175, 168)
+#define QPC_VLAN_ID QPC_FIELD_LOC(187, 176)
+#define QPC_MTU QPC_FIELD_LOC(191, 188)
+#define QPC_FL QPC_FIELD_LOC(211, 192)
+#define QPC_SL QPC_FIELD_LOC(215, 212)
+#define QPC_CNP_TX_FLAG QPC_FIELD_LOC(216, 216)
+#define QPC_CE_FLAG QPC_FIELD_LOC(217, 217)
+#define QPC_LBI QPC_FIELD_LOC(218, 218)
+#define QPC_AT QPC_FIELD_LOC(223, 219)
+#define QPC_DGID QPC_FIELD_LOC(351, 224)
+#define QPC_DMAC_L QPC_FIELD_LOC(383, 352)
+#define QPC_DMAC_H QPC_FIELD_LOC(399, 384)
+#define QPC_UDPSPN QPC_FIELD_LOC(415, 400)
+#define QPC_DQPN QPC_FIELD_LOC(439, 416)
+#define QPC_SQ_TX_ERR QPC_FIELD_LOC(440, 440)
+#define QPC_SQ_RX_ERR QPC_FIELD_LOC(441, 441)
+#define QPC_RQ_TX_ERR QPC_FIELD_LOC(442, 442)
+#define QPC_RQ_RX_ERR QPC_FIELD_LOC(443, 443)
+#define QPC_LP_PKTN_INI QPC_FIELD_LOC(447, 444)
 #define QPC_CONG_ALGO_TMPL_ID QPC_FIELD_LOC(455, 448)
-
-#define	V2_QPC_BYTE_4_TST_S 0
-#define V2_QPC_BYTE_4_TST_M GENMASK(2, 0)
-
-#define	V2_QPC_BYTE_4_SGE_SHIFT_S 3
-#define V2_QPC_BYTE_4_SGE_SHIFT_M GENMASK(7, 3)
-
-#define	V2_QPC_BYTE_4_SQPN_S 8
-#define V2_QPC_BYTE_4_SQPN_M  GENMASK(31, 8)
-
-#define	V2_QPC_BYTE_12_WQE_SGE_BA_S 0
-#define V2_QPC_BYTE_12_WQE_SGE_BA_M GENMASK(28, 0)
-
-#define	V2_QPC_BYTE_12_SQ_HOP_NUM_S 29
-#define V2_QPC_BYTE_12_SQ_HOP_NUM_M GENMASK(30, 29)
-
-#define V2_QPC_BYTE_12_RSVD_LKEY_EN_S 31
-
-#define	V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S 0
-#define V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M GENMASK(3, 0)
-
-#define	V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S 4
-#define V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M GENMASK(7, 4)
-
-#define	V2_QPC_BYTE_16_PD_S 8
-#define V2_QPC_BYTE_16_PD_M GENMASK(31, 8)
-
-#define	V2_QPC_BYTE_20_RQ_HOP_NUM_S 0
-#define V2_QPC_BYTE_20_RQ_HOP_NUM_M GENMASK(1, 0)
-
-#define	V2_QPC_BYTE_20_SGE_HOP_NUM_S 2
-#define V2_QPC_BYTE_20_SGE_HOP_NUM_M GENMASK(3, 2)
-
-#define	V2_QPC_BYTE_20_RQWS_S 4
-#define V2_QPC_BYTE_20_RQWS_M GENMASK(7, 4)
-
-#define	V2_QPC_BYTE_20_SQ_SHIFT_S 8
-#define V2_QPC_BYTE_20_SQ_SHIFT_M GENMASK(11, 8)
-
-#define	V2_QPC_BYTE_20_RQ_SHIFT_S 12
-#define V2_QPC_BYTE_20_RQ_SHIFT_M GENMASK(15, 12)
-
-#define	V2_QPC_BYTE_20_SGID_IDX_S 16
-#define V2_QPC_BYTE_20_SGID_IDX_M GENMASK(23, 16)
-
-#define	V2_QPC_BYTE_20_SMAC_IDX_S 24
-#define V2_QPC_BYTE_20_SMAC_IDX_M GENMASK(31, 24)
-
-#define	V2_QPC_BYTE_24_HOP_LIMIT_S 0
-#define V2_QPC_BYTE_24_HOP_LIMIT_M GENMASK(7, 0)
-
-#define	V2_QPC_BYTE_24_TC_S 8
-#define V2_QPC_BYTE_24_TC_M GENMASK(15, 8)
-
-#define	V2_QPC_BYTE_24_VLAN_ID_S 16
-#define V2_QPC_BYTE_24_VLAN_ID_M GENMASK(27, 16)
-
-#define	V2_QPC_BYTE_24_MTU_S 28
-#define V2_QPC_BYTE_24_MTU_M GENMASK(31, 28)
-
-#define	V2_QPC_BYTE_28_FL_S 0
-#define V2_QPC_BYTE_28_FL_M GENMASK(19, 0)
-
-#define	V2_QPC_BYTE_28_SL_S 20
-#define V2_QPC_BYTE_28_SL_M GENMASK(23, 20)
-
-#define V2_QPC_BYTE_28_CNP_TX_FLAG_S 24
-
-#define V2_QPC_BYTE_28_CE_FLAG_S 25
-
-#define V2_QPC_BYTE_28_LBI_S 26
-
-#define	V2_QPC_BYTE_28_AT_S 27
-#define V2_QPC_BYTE_28_AT_M GENMASK(31, 27)
-
-#define	V2_QPC_BYTE_52_DMAC_S 0
-#define V2_QPC_BYTE_52_DMAC_M GENMASK(15, 0)
-
-#define V2_QPC_BYTE_52_UDPSPN_S 16
-#define V2_QPC_BYTE_52_UDPSPN_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_56_DQPN_S 0
-#define V2_QPC_BYTE_56_DQPN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_56_SQ_TX_ERR_S 24
-#define	V2_QPC_BYTE_56_SQ_RX_ERR_S 25
-#define	V2_QPC_BYTE_56_RQ_TX_ERR_S 26
-#define	V2_QPC_BYTE_56_RQ_RX_ERR_S 27
-
-#define	V2_QPC_BYTE_56_LP_PKTN_INI_S 28
-#define V2_QPC_BYTE_56_LP_PKTN_INI_M GENMASK(31, 28)
-
-#define V2_QPC_BYTE_60_SCC_TOKEN_S 8
-#define V2_QPC_BYTE_60_SCC_TOKEN_M GENMASK(26, 8)
-
-#define	V2_QPC_BYTE_60_SQ_DB_DOING_S 27
-
-#define	V2_QPC_BYTE_60_RQ_DB_DOING_S 28
-
-#define	V2_QPC_BYTE_60_QP_ST_S 29
-#define V2_QPC_BYTE_60_QP_ST_M GENMASK(31, 29)
-
-#define	V2_QPC_BYTE_68_RQ_RECORD_EN_S 0
-
-#define	V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_S 1
-#define V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_M GENMASK(31, 1)
-
-#define	V2_QPC_BYTE_76_SRQN_S 0
-#define V2_QPC_BYTE_76_SRQN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_76_SRQ_EN_S 24
-
-#define	V2_QPC_BYTE_76_RRE_S 25
-
-#define	V2_QPC_BYTE_76_RWE_S 26
-
-#define	V2_QPC_BYTE_76_ATE_S 27
-
-#define	V2_QPC_BYTE_76_RQIE_S 28
-#define	V2_QPC_BYTE_76_EXT_ATE_S 29
-#define	V2_QPC_BYTE_76_RQ_VLAN_EN_S 30
-#define	V2_QPC_BYTE_80_RX_CQN_S 0
-#define V2_QPC_BYTE_80_RX_CQN_M GENMASK(23, 0)
-
-#define V2_QPC_BYTE_80_XRC_QP_TYPE_S 24
-
-#define	V2_QPC_BYTE_80_MIN_RNR_TIME_S 27
-#define V2_QPC_BYTE_80_MIN_RNR_TIME_M GENMASK(31, 27)
-
-#define	V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S 0
-#define V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M GENMASK(15, 0)
-
-#define	V2_QPC_BYTE_84_RQ_CONSUMER_IDX_S 16
-#define V2_QPC_BYTE_84_RQ_CONSUMER_IDX_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S 0
-#define V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M GENMASK(19, 0)
-
-#define	V2_QPC_BYTE_92_SRQ_INFO_S 20
-#define V2_QPC_BYTE_92_SRQ_INFO_M GENMASK(31, 20)
-
-#define	V2_QPC_BYTE_96_RX_REQ_MSN_S 0
-#define V2_QPC_BYTE_96_RX_REQ_MSN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S 0
-#define V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M GENMASK(19, 0)
-
-#define	V2_QPC_BYTE_104_RQ_CUR_WQE_SGE_NUM_S 24
-#define V2_QPC_BYTE_104_RQ_CUR_WQE_SGE_NUM_M GENMASK(31, 24)
-
-#define V2_QPC_BYTE_108_INV_CREDIT_S 0
-
-#define V2_QPC_BYTE_108_RX_REQ_PSN_ERR_S 3
-
-#define	V2_QPC_BYTE_108_RX_REQ_LAST_OPTYPE_S 4
-#define V2_QPC_BYTE_108_RX_REQ_LAST_OPTYPE_M GENMASK(6, 4)
-
-#define V2_QPC_BYTE_108_RX_REQ_RNR_S 7
-
-#define	V2_QPC_BYTE_108_RX_REQ_EPSN_S 8
-#define V2_QPC_BYTE_108_RX_REQ_EPSN_M GENMASK(31, 8)
-
-#define	V2_QPC_BYTE_132_TRRL_HEAD_MAX_S 0
-#define V2_QPC_BYTE_132_TRRL_HEAD_MAX_M GENMASK(7, 0)
-
-#define	V2_QPC_BYTE_132_TRRL_TAIL_MAX_S 8
-#define V2_QPC_BYTE_132_TRRL_TAIL_MAX_M GENMASK(15, 8)
-
-#define	V2_QPC_BYTE_132_TRRL_BA_S 16
-#define V2_QPC_BYTE_132_TRRL_BA_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_140_TRRL_BA_S 0
-#define V2_QPC_BYTE_140_TRRL_BA_M GENMASK(11, 0)
-
-#define	V2_QPC_BYTE_140_RR_MAX_S 12
-#define V2_QPC_BYTE_140_RR_MAX_M GENMASK(14, 12)
-
-#define	V2_QPC_BYTE_140_RQ_RTY_WAIT_DO_S 15
-
-#define	V2_QPC_BYTE_140_RAQ_TRRL_HEAD_S 16
-#define V2_QPC_BYTE_140_RAQ_TRRL_HEAD_M GENMASK(23, 16)
-
-#define	V2_QPC_BYTE_140_RAQ_TRRL_TAIL_S 24
-#define V2_QPC_BYTE_140_RAQ_TRRL_TAIL_M GENMASK(31, 24)
-
-#define	V2_QPC_BYTE_144_RAQ_RTY_INI_PSN_S 0
-#define V2_QPC_BYTE_144_RAQ_RTY_INI_PSN_M GENMASK(23, 0)
-
-#define V2_QPC_BYTE_144_RAQ_CREDIT_S 25
-#define V2_QPC_BYTE_144_RAQ_CREDIT_M GENMASK(29, 25)
-
-#define V2_QPC_BYTE_144_RESP_RTY_FLG_S 31
-
-#define	V2_QPC_BYTE_148_RQ_MSN_S 0
-#define V2_QPC_BYTE_148_RQ_MSN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_148_RAQ_SYNDROME_S 24
-#define V2_QPC_BYTE_148_RAQ_SYNDROME_M GENMASK(31, 24)
-
-#define	V2_QPC_BYTE_152_RAQ_PSN_S 0
-#define V2_QPC_BYTE_152_RAQ_PSN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_152_RAQ_TRRL_RTY_HEAD_S 24
-#define V2_QPC_BYTE_152_RAQ_TRRL_RTY_HEAD_M GENMASK(31, 24)
-
-#define	V2_QPC_BYTE_156_RAQ_USE_PKTN_S 0
-#define V2_QPC_BYTE_156_RAQ_USE_PKTN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S 0
-#define V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M GENMASK(15, 0)
-
-#define	V2_QPC_BYTE_160_SQ_CONSUMER_IDX_S 16
-#define V2_QPC_BYTE_160_SQ_CONSUMER_IDX_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S 0
-#define V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M GENMASK(19, 0)
-
-#define V2_QPC_BYTE_168_MSG_RTY_LP_FLG_S 20
-
-#define V2_QPC_BYTE_168_SQ_INVLD_FLG_S 21
-
-#define	V2_QPC_BYTE_168_LP_SGEN_INI_S 22
-#define V2_QPC_BYTE_168_LP_SGEN_INI_M GENMASK(23, 22)
-
-#define V2_QPC_BYTE_168_SQ_VLAN_EN_S 24
-#define V2_QPC_BYTE_168_POLL_DB_WAIT_DO_S 25
-#define V2_QPC_BYTE_168_SCC_TOKEN_FORBID_SQ_DEQ_S 26
-#define V2_QPC_BYTE_168_WAIT_ACK_TIMEOUT_S 27
-#define	V2_QPC_BYTE_168_IRRL_IDX_LSB_S 28
-#define V2_QPC_BYTE_168_IRRL_IDX_LSB_M GENMASK(31, 28)
-
-#define	V2_QPC_BYTE_172_ACK_REQ_FREQ_S 0
-#define V2_QPC_BYTE_172_ACK_REQ_FREQ_M GENMASK(5, 0)
-
-#define V2_QPC_BYTE_172_MSG_RNR_FLG_S 6
-
-#define V2_QPC_BYTE_172_FRE_S 7
-
-#define	V2_QPC_BYTE_172_SQ_CUR_PSN_S 8
-#define V2_QPC_BYTE_172_SQ_CUR_PSN_M GENMASK(31, 8)
-
-#define	V2_QPC_BYTE_176_MSG_USE_PKTN_S 0
-#define V2_QPC_BYTE_176_MSG_USE_PKTN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_176_IRRL_HEAD_PRE_S 24
-#define V2_QPC_BYTE_176_IRRL_HEAD_PRE_M GENMASK(31, 24)
-
-#define	V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S 0
-#define V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M GENMASK(19, 0)
-
-#define	V2_QPC_BYTE_184_IRRL_IDX_MSB_S 20
-#define V2_QPC_BYTE_184_IRRL_IDX_MSB_M GENMASK(31, 20)
-
-#define	V2_QPC_BYTE_192_CUR_SGE_IDX_S 0
-#define V2_QPC_BYTE_192_CUR_SGE_IDX_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_192_EXT_SGE_NUM_LEFT_S 24
-#define V2_QPC_BYTE_192_EXT_SGE_NUM_LEFT_M GENMASK(31, 24)
-
-#define	V2_QPC_BYTE_196_IRRL_HEAD_S 0
-#define V2_QPC_BYTE_196_IRRL_HEAD_M GENMASK(7, 0)
-
-#define	V2_QPC_BYTE_196_SQ_MAX_PSN_S 8
-#define V2_QPC_BYTE_196_SQ_MAX_PSN_M GENMASK(31, 8)
-
-#define	V2_QPC_BYTE_200_SQ_MAX_IDX_S 0
-#define V2_QPC_BYTE_200_SQ_MAX_IDX_M GENMASK(15, 0)
-
-#define	V2_QPC_BYTE_200_LCL_OPERATED_CNT_S 16
-#define V2_QPC_BYTE_200_LCL_OPERATED_CNT_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_208_IRRL_BA_S 0
-#define V2_QPC_BYTE_208_IRRL_BA_M GENMASK(25, 0)
-
-#define V2_QPC_BYTE_208_PKT_RNR_FLG_S 26
-
-#define V2_QPC_BYTE_208_PKT_RTY_FLG_S 27
-
-#define V2_QPC_BYTE_208_RMT_E2E_S 28
-
-#define	V2_QPC_BYTE_208_SR_MAX_S 29
-#define V2_QPC_BYTE_208_SR_MAX_M GENMASK(31, 29)
-
-#define	V2_QPC_BYTE_212_LSN_S 0
-#define V2_QPC_BYTE_212_LSN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_212_RETRY_NUM_INIT_S 24
-#define V2_QPC_BYTE_212_RETRY_NUM_INIT_M GENMASK(26, 24)
-
-#define	V2_QPC_BYTE_212_CHECK_FLG_S 27
-#define V2_QPC_BYTE_212_CHECK_FLG_M GENMASK(28, 27)
-
-#define	V2_QPC_BYTE_212_RETRY_CNT_S 29
-#define V2_QPC_BYTE_212_RETRY_CNT_M GENMASK(31, 29)
-
-#define	V2_QPC_BYTE_220_RETRY_MSG_MSN_S 0
-#define V2_QPC_BYTE_220_RETRY_MSG_MSN_M GENMASK(15, 0)
-
-#define	V2_QPC_BYTE_220_RETRY_MSG_PSN_S 16
-#define V2_QPC_BYTE_220_RETRY_MSG_PSN_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_224_RETRY_MSG_PSN_S 0
-#define V2_QPC_BYTE_224_RETRY_MSG_PSN_M GENMASK(7, 0)
-
-#define	V2_QPC_BYTE_224_RETRY_MSG_FPKT_PSN_S 8
-#define V2_QPC_BYTE_224_RETRY_MSG_FPKT_PSN_M GENMASK(31, 8)
-
-#define	V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S 0
-#define V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M GENMASK(19, 0)
-
-#define	V2_QPC_BYTE_232_IRRL_SGE_IDX_S 20
-#define V2_QPC_BYTE_232_IRRL_SGE_IDX_M GENMASK(28, 20)
-
-#define V2_QPC_BYTE_232_SO_LP_VLD_S 29
-#define V2_QPC_BYTE_232_FENCE_LP_VLD_S 30
-#define V2_QPC_BYTE_232_IRRL_LP_VLD_S 31
-
-#define	V2_QPC_BYTE_240_IRRL_TAIL_REAL_S 0
-#define V2_QPC_BYTE_240_IRRL_TAIL_REAL_M GENMASK(7, 0)
-
-#define	V2_QPC_BYTE_240_IRRL_TAIL_RD_S 8
-#define V2_QPC_BYTE_240_IRRL_TAIL_RD_M GENMASK(15, 8)
-
-#define	V2_QPC_BYTE_240_RX_ACK_MSN_S 16
-#define V2_QPC_BYTE_240_RX_ACK_MSN_M GENMASK(31, 16)
-
-#define	V2_QPC_BYTE_244_RX_ACK_EPSN_S 0
-#define V2_QPC_BYTE_244_RX_ACK_EPSN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_244_RNR_NUM_INIT_S 24
-#define V2_QPC_BYTE_244_RNR_NUM_INIT_M GENMASK(26, 24)
-
-#define	V2_QPC_BYTE_244_RNR_CNT_S 27
-#define V2_QPC_BYTE_244_RNR_CNT_M GENMASK(29, 27)
-
-#define V2_QPC_BYTE_244_LCL_OP_FLG_S 30
-#define V2_QPC_BYTE_244_IRRL_RD_FLG_S 31
-
-#define	V2_QPC_BYTE_248_IRRL_PSN_S 0
-#define V2_QPC_BYTE_248_IRRL_PSN_M GENMASK(23, 0)
-
-#define V2_QPC_BYTE_248_ACK_PSN_ERR_S 24
-
-#define	V2_QPC_BYTE_248_ACK_LAST_OPTYPE_S 25
-#define V2_QPC_BYTE_248_ACK_LAST_OPTYPE_M GENMASK(26, 25)
-
-#define V2_QPC_BYTE_248_IRRL_PSN_VLD_S 27
-
-#define V2_QPC_BYTE_248_RNR_RETRY_FLAG_S 28
-
-#define V2_QPC_BYTE_248_CQ_ERR_IND_S 31
-
-#define	V2_QPC_BYTE_252_TX_CQN_S 0
-#define V2_QPC_BYTE_252_TX_CQN_M GENMASK(23, 0)
-
-#define	V2_QPC_BYTE_252_SIG_TYPE_S 24
-
-#define	V2_QPC_BYTE_252_ERR_TYPE_S 25
-#define V2_QPC_BYTE_252_ERR_TYPE_M GENMASK(31, 25)
-
-#define	V2_QPC_BYTE_256_RQ_CQE_IDX_S 0
-#define V2_QPC_BYTE_256_RQ_CQE_IDX_M GENMASK(15, 0)
-
-#define	V2_QPC_BYTE_256_SQ_FLUSH_IDX_S 16
-#define V2_QPC_BYTE_256_SQ_FLUSH_IDX_M GENMASK(31, 16)
+#define QPC_SCC_TOKEN QPC_FIELD_LOC(474, 456)
+#define QPC_SQ_DB_DOING QPC_FIELD_LOC(475, 475)
+#define QPC_RQ_DB_DOING QPC_FIELD_LOC(476, 476)
+#define QPC_QP_ST QPC_FIELD_LOC(479, 477)
+#define QPC_QKEY_XRCD QPC_FIELD_LOC(511, 480)
+#define QPC_RQ_RECORD_EN QPC_FIELD_LOC(512, 512)
+#define QPC_RQ_DB_RECORD_ADDR_L QPC_FIELD_LOC(543, 513)
+#define QPC_RQ_DB_RECORD_ADDR_H QPC_FIELD_LOC(575, 544)
+#define QPC_SRQN QPC_FIELD_LOC(599, 576)
+#define QPC_SRQ_EN QPC_FIELD_LOC(600, 600)
+#define QPC_RRE QPC_FIELD_LOC(601, 601)
+#define QPC_RWE QPC_FIELD_LOC(602, 602)
+#define QPC_ATE QPC_FIELD_LOC(603, 603)
+#define QPC_RQIE QPC_FIELD_LOC(604, 604)
+#define QPC_EXT_ATE QPC_FIELD_LOC(605, 605)
+#define QPC_RQ_VLAN_EN QPC_FIELD_LOC(606, 606)
+#define QPC_RQ_RTY_TX_ERR QPC_FIELD_LOC(607, 607)
+#define QPC_RX_CQN QPC_FIELD_LOC(631, 608)
+#define QPC_XRC_QP_TYPE QPC_FIELD_LOC(632, 632)
+#define QPC_RSV3 QPC_FIELD_LOC(634, 633)
+#define QPC_MIN_RNR_TIME QPC_FIELD_LOC(639, 635)
+#define QPC_RQ_PRODUCER_IDX QPC_FIELD_LOC(655, 640)
+#define QPC_RQ_CONSUMER_IDX QPC_FIELD_LOC(671, 656)
+#define QPC_RQ_CUR_BLK_ADDR_L QPC_FIELD_LOC(703, 672)
+#define QPC_RQ_CUR_BLK_ADDR_H QPC_FIELD_LOC(723, 704)
+#define QPC_SRQ_INFO QPC_FIELD_LOC(735, 724)
+#define QPC_RX_REQ_MSN QPC_FIELD_LOC(759, 736)
+#define QPC_REDUCE_CODE QPC_FIELD_LOC(766, 760)
+#define QPC_RX_XRC_PKT_CQE_FLG QPC_FIELD_LOC(767, 767)
+#define QPC_RQ_NXT_BLK_ADDR_L QPC_FIELD_LOC(799, 768)
+#define QPC_RQ_NXT_BLK_ADDR_H QPC_FIELD_LOC(819, 800)
+#define QPC_REDUCE_EN QPC_FIELD_LOC(820, 820)
+#define QPC_FLUSH_EN QPC_FIELD_LOC(821, 821)
+#define QPC_AW_EN QPC_FIELD_LOC(822, 822)
+#define QPC_WN_EN QPC_FIELD_LOC(823, 823)
+#define QPC_RQ_CUR_WQE_SGE_NUM QPC_FIELD_LOC(831, 824)
+#define QPC_INV_CREDIT QPC_FIELD_LOC(832, 832)
+#define QPC_LAST_WRITE_TYPE QPC_FIELD_LOC(834, 833)
+#define QPC_RX_REQ_PSN_ERR QPC_FIELD_LOC(835, 835)
+#define QPC_RX_REQ_LAST_OPTYPE QPC_FIELD_LOC(838, 836)
+#define QPC_RX_REQ_RNR QPC_FIELD_LOC(839, 839)
+#define QPC_RX_REQ_EPSN QPC_FIELD_LOC(863, 840)
+#define QPC_RQ_RNR_TIMER QPC_FIELD_LOC(895, 864)
+#define QPC_RX_MSG_LEN QPC_FIELD_LOC(927, 896)
+#define QPC_RX_RKEY_PKT_INFO QPC_FIELD_LOC(959, 928)
+#define QPC_RX_VA QPC_FIELD_LOC(1023, 960)
+#define QPC_TRRL_HEAD_MAX QPC_FIELD_LOC(1031, 1024)
+#define QPC_TRRL_TAIL_MAX QPC_FIELD_LOC(1039, 1032)
+#define QPC_TRRL_BA_L QPC_FIELD_LOC(1055, 1040)
+#define QPC_TRRL_BA_M QPC_FIELD_LOC(1087, 1056)
+#define QPC_TRRL_BA_H QPC_FIELD_LOC(1099, 1088)
+#define QPC_RR_MAX QPC_FIELD_LOC(1102, 1100)
+#define QPC_RQ_RTY_WAIT_DO QPC_FIELD_LOC(1103, 1103)
+#define QPC_RAQ_TRRL_HEAD QPC_FIELD_LOC(1111, 1104)
+#define QPC_RAQ_TRRL_TAIL QPC_FIELD_LOC(1119, 1112)
+#define QPC_RAQ_RTY_INI_PSN QPC_FIELD_LOC(1143, 1120)
+#define QPC_CIRE_SLV_RQ_EN QPC_FIELD_LOC(1144, 1144)
+#define QPC_RAQ_CREDIT QPC_FIELD_LOC(1149, 1145)
+#define QPC_RQ_DB_IN_EXT QPC_FIELD_LOC(1150, 1150)
+#define QPC_RESP_RTY_FLG QPC_FIELD_LOC(1151, 1151)
+#define QPC_RAQ_MSN QPC_FIELD_LOC(1175, 1152)
+#define QPC_RAQ_SYNDROME QPC_FIELD_LOC(1183, 1176)
+#define QPC_RAQ_PSN QPC_FIELD_LOC(1207, 1184)
+#define QPC_RAQ_TRRL_RTY_HEAD QPC_FIELD_LOC(1215, 1208)
+#define QPC_RAQ_USE_PKTN QPC_FIELD_LOC(1239, 1216)
+#define QPC_RQ_SCC_TOKEN QPC_FIELD_LOC(1245, 1240)
+#define QPC_RVD10 QPC_FIELD_LOC(1247, 1246)
+#define QPC_SQ_PRODUCER_IDX QPC_FIELD_LOC(1263, 1248)
+#define QPC_SQ_CONSUMER_IDX QPC_FIELD_LOC(1279, 1264)
+#define QPC_SQ_CUR_BLK_ADDR_L QPC_FIELD_LOC(1311, 1280)
+#define QPC_SQ_CUR_BLK_ADDR_H QPC_FIELD_LOC(1331, 1312)
+#define QPC_MSG_RTY_LP_FLG QPC_FIELD_LOC(1332, 1332)
+#define QPC_SQ_INVLD_FLG QPC_FIELD_LOC(1333, 1333)
+#define QPC_LP_SGEN_INI QPC_FIELD_LOC(1335, 1334)
+#define QPC_SQ_VLAN_EN QPC_FIELD_LOC(1336, 1336)
+#define QPC_POLL_DB_WAIT_DO QPC_FIELD_LOC(1337, 1337)
+#define QPC_SCC_TOKEN_FORBID_SQ_DEQ QPC_FIELD_LOC(1338, 1338)
+#define QPC_WAIT_ACK_TIMEOUT QPC_FIELD_LOC(1339, 1339)
+#define QPC_IRRL_IDX_LSB QPC_FIELD_LOC(1343, 1340)
+#define QPC_ACK_REQ_FREQ QPC_FIELD_LOC(1349, 1344)
+#define QPC_MSG_RNR_FLG QPC_FIELD_LOC(1350, 1350)
+#define QPC_FRE QPC_FIELD_LOC(1351, 1351)
+#define QPC_SQ_CUR_PSN QPC_FIELD_LOC(1375, 1352)
+#define QPC_MSG_USE_PKTN QPC_FIELD_LOC(1399, 1376)
+#define QPC_IRRL_HEAD_PRE QPC_FIELD_LOC(1407, 1400)
+#define QPC_SQ_CUR_SGE_BLK_ADDR_L QPC_FIELD_LOC(1439, 1408)
+#define QPC_SQ_CUR_SGE_BLK_ADDR_H QPC_FIELD_LOC(1459, 1440)
+#define QPC_IRRL_IDX_MSB QPC_FIELD_LOC(1471, 1460)
+#define QPC_CUR_SGE_OFFSET QPC_FIELD_LOC(1503, 1472)
+#define QPC_CUR_SGE_IDX QPC_FIELD_LOC(1527, 1504)
+#define QPC_EXT_SGE_NUM_LEFT QPC_FIELD_LOC(1535, 1528)
+#define QPC_OWNER_MODE QPC_FIELD_LOC(1536, 1536)
+#define QPC_CIRE_SLV_SQ_EN QPC_FIELD_LOC(1537, 1537)
+#define QPC_CIRE_DOING QPC_FIELD_LOC(1538, 1538)
+#define QPC_CIRE_RESULT QPC_FIELD_LOC(1539, 1539)
+#define QPC_OWNER_DB_WAIT_DO QPC_FIELD_LOC(1540, 1540)
+#define QPC_SQ_WQE_INVLD QPC_FIELD_LOC(1541, 1541)
+#define QPC_DCA_MODE QPC_FIELD_LOC(1542, 1542)
+#define QPC_RTY_OWNER_NOCHK QPC_FIELD_LOC(1543, 1543)
+#define QPC_V2_IRRL_HEAD QPC_FIELD_LOC(1543, 1536)  //
+#define QPC_SQ_MAX_PSN QPC_FIELD_LOC(1567, 1544)
+#define QPC_SQ_MAX_IDX QPC_FIELD_LOC(1583, 1568)
+#define QPC_LCL_OPERATED_CNT QPC_FIELD_LOC(1599, 1584)
+#define QPC_IRRL_BA_L QPC_FIELD_LOC(1631, 1600)
+#define QPC_IRRL_BA_H QPC_FIELD_LOC(1657, 1632)
+#define QPC_PKT_RNR_FLG QPC_FIELD_LOC(1658, 1658)
+#define QPC_PKT_RTY_FLG QPC_FIELD_LOC(1659, 1659)
+#define QPC_RMT_E2E QPC_FIELD_LOC(1660, 1660)
+#define QPC_SR_MAX QPC_FIELD_LOC(1663, 1661)
+#define QPC_LSN QPC_FIELD_LOC(1687, 1664)
+#define QPC_RETRY_NUM_INIT QPC_FIELD_LOC(1690, 1688)
+#define QPC_CHECK_FLG QPC_FIELD_LOC(1692, 1691)
+#define QPC_RETRY_CNT QPC_FIELD_LOC(1695, 1693)
+#define QPC_SQ_TIMER QPC_FIELD_LOC(1727, 1696)
+#define QPC_RETRY_MSG_MSN QPC_FIELD_LOC(1743, 1728)
+#define QPC_RETRY_MSG_PSN_L QPC_FIELD_LOC(1759, 1744)
+#define QPC_RETRY_MSG_PSN_H QPC_FIELD_LOC(1767, 1760)
+#define QPC_RETRY_MSG_FPKT_PSN QPC_FIELD_LOC(1791, 1768)
+#define QPC_RX_SQ_CUR_BLK_ADDR_L QPC_FIELD_LOC(1823, 1792)
+#define QPC_RX_SQ_CUR_BLK_ADDR_H QPC_FIELD_LOC(1843, 1824)
+#define QPC_IRRL_SGE_IDX QPC_FIELD_LOC(1851, 1844)
+#define QPC_LSAN_EN QPC_FIELD_LOC(1852, 1852)
+#define QPC_SO_LP_VLD QPC_FIELD_LOC(1853, 1853)
+#define QPC_FENCE_LP_VLD QPC_FIELD_LOC(1854, 1854)
+#define QPC_IRRL_LP_VLD QPC_FIELD_LOC(1855, 1855)
+#define QPC_IRRL_CUR_SGE_OFFSET QPC_FIELD_LOC(1887, 1856)
+#define QPC_IRRL_TAIL_REAL QPC_FIELD_LOC(1895, 1888)
+#define QPC_IRRL_TAIL_RD QPC_FIELD_LOC(1903, 1896)
+#define QPC_RX_ACK_MSN QPC_FIELD_LOC(1919, 1904)
+#define QPC_RX_ACK_EPSN QPC_FIELD_LOC(1943, 1920)
+#define QPC_RNR_NUM_INIT QPC_FIELD_LOC(1946, 1944)
+#define QPC_RNR_CNT QPC_FIELD_LOC(1949, 1947)
+#define QPC_LCL_OP_FLG QPC_FIELD_LOC(1950, 1950)
+#define QPC_IRRL_RD_FLG QPC_FIELD_LOC(1951, 1951)
+#define QPC_IRRL_PSN QPC_FIELD_LOC(1975, 1952)
+#define QPC_ACK_PSN_ERR QPC_FIELD_LOC(1976, 1976)
+#define QPC_ACK_LAST_OPTYPE QPC_FIELD_LOC(1978, 1977)
+#define QPC_IRRL_PSN_VLD QPC_FIELD_LOC(1979, 1979)
+#define QPC_RNR_RETRY_FLAG QPC_FIELD_LOC(1980, 1980)
+#define QPC_SQ_RTY_TX_ERR QPC_FIELD_LOC(1981, 1981)
+#define QPC_LAST_IND QPC_FIELD_LOC(1982, 1982)
+#define QPC_CQ_ERR_IND QPC_FIELD_LOC(1983, 1983)
+#define QPC_TX_CQN QPC_FIELD_LOC(2007, 1984)
+#define QPC_SIG_TYPE QPC_FIELD_LOC(2008, 2008)
+#define QPC_ERR_TYPE QPC_FIELD_LOC(2015, 2009)
+#define QPC_RQ_CQE_IDX QPC_FIELD_LOC(2031, 2016)
+#define QPC_SQ_FLUSH_IDX QPC_FIELD_LOC(2047, 2032)
+
+#define RETRY_MSG_PSN_SHIFT 16
 
 #define QPCEX_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_qp_context_ex, h, l)
 
-- 
2.7.4

