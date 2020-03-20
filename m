Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD35918C5BF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 04:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTD1k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 23:27:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbgCTD1j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 23:27:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 696548C2165828C025A9;
        Fri, 20 Mar 2020 11:27:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Mar 2020 11:27:27 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 08/10] RDMA/hns: Remove redundant qpc setup operations
Date:   Fri, 20 Mar 2020 11:23:40 +0800
Message-ID: <1584674622-52773-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
References: <1584674622-52773-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Before calling modify_qp_reset_to_init(), the entire qpc mask has been
cleared, so it is no longer necessary to clear the specific fields in the
mask.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 237 +----------------------------
 1 file changed, 1 insertion(+), 236 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index bd14e71..2b03c72 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3541,14 +3541,9 @@ static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 			       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE ?
 			       ilog2((unsigned int)hr_qp->sge.sge_cnt) : 0);
 
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SGE_SHIFT_M,
-		       V2_QPC_BYTE_4_SGE_SHIFT_S, 0);
-
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S,
 		       ilog2((unsigned int)hr_qp->sq.wqe_cnt));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S, 0);
 
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S,
@@ -3556,9 +3551,6 @@ static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 		       hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT ||
 		       hr_qp->ibqp.srq) ? 0 :
 		       ilog2((unsigned int)hr_qp->rq.wqe_cnt));
-
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S, 0);
 }
 
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
@@ -3578,280 +3570,53 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	 */
 	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
 		       V2_QPC_BYTE_4_TST_S, to_hr_qp_type(hr_qp->ibqp.qp_type));
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
-		       V2_QPC_BYTE_4_TST_S, 0);
 
 	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
 		       V2_QPC_BYTE_4_SQPN_S, hr_qp->qpn);
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
-		       V2_QPC_BYTE_4_SQPN_S, 0);
 
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
 		       V2_QPC_BYTE_16_PD_S, to_hr_pd(ibqp->pd)->pdn);
-	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-		       V2_QPC_BYTE_16_PD_S, 0);
 
 	roce_set_field(context->byte_20_smac_sgid_idx, V2_QPC_BYTE_20_RQWS_M,
 		       V2_QPC_BYTE_20_RQWS_S, ilog2(hr_qp->rq.max_gs));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx, V2_QPC_BYTE_20_RQWS_M,
-		       V2_QPC_BYTE_20_RQWS_S, 0);
 
 	set_qpc_wqe_cnt(hr_qp, context, qpc_mask);
 
 	/* No VLAN need to set 0xFFF */
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
 		       V2_QPC_BYTE_24_VLAN_ID_S, 0xfff);
-	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
-		       V2_QPC_BYTE_24_VLAN_ID_S, 0);
 
-	/*
-	 * Set some fields in context to zero, Because the default values
-	 * of all fields in context are zero, we need not set them to 0 again.
-	 * but we should set the relevant fields of context mask to 0.
-	 */
-	roce_set_bit(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_SQ_TX_ERR_S, 0);
-	roce_set_bit(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_SQ_RX_ERR_S, 0);
-	roce_set_bit(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_RQ_TX_ERR_S, 0);
-	roce_set_bit(qpc_mask->byte_56_dqpn_err, V2_QPC_BYTE_56_RQ_RX_ERR_S, 0);
-
-	roce_set_field(qpc_mask->byte_60_qpst_tempid, V2_QPC_BYTE_60_TEMPID_M,
-		       V2_QPC_BYTE_60_TEMPID_S, 0);
-
-	roce_set_field(qpc_mask->byte_60_qpst_tempid,
-		       V2_QPC_BYTE_60_SCC_TOKEN_M, V2_QPC_BYTE_60_SCC_TOKEN_S,
-		       0);
-	roce_set_bit(qpc_mask->byte_60_qpst_tempid,
-		     V2_QPC_BYTE_60_SQ_DB_DOING_S, 0);
-	roce_set_bit(qpc_mask->byte_60_qpst_tempid,
-		     V2_QPC_BYTE_60_RQ_DB_DOING_S, 0);
-	roce_set_bit(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_CNP_TX_FLAG_S, 0);
-	roce_set_bit(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_CE_FLAG_S, 0);
-
-	if (hr_qp->rdb_en) {
+	if (hr_qp->rdb_en)
 		roce_set_bit(context->byte_68_rq_db,
 			     V2_QPC_BYTE_68_RQ_RECORD_EN_S, 1);
-		roce_set_bit(qpc_mask->byte_68_rq_db,
-			     V2_QPC_BYTE_68_RQ_RECORD_EN_S, 0);
-	}
 
 	roce_set_field(context->byte_68_rq_db,
 		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_M,
 		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_S,
 		       ((u32)hr_qp->rdb.dma) >> 1);
-	roce_set_field(qpc_mask->byte_68_rq_db,
-		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_M,
-		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_S, 0);
 	context->rq_db_record_addr = cpu_to_le32(hr_qp->rdb.dma >> 32);
-	qpc_mask->rq_db_record_addr = 0;
 
 	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RQIE_S,
 		    (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) ? 1 : 0);
-	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_RQIE_S, 0);
 
 	roce_set_field(context->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
 		       V2_QPC_BYTE_80_RX_CQN_S, to_hr_cq(ibqp->recv_cq)->cqn);
-	roce_set_field(qpc_mask->byte_80_rnr_rx_cqn, V2_QPC_BYTE_80_RX_CQN_M,
-		       V2_QPC_BYTE_80_RX_CQN_S, 0);
 	if (ibqp->srq) {
 		roce_set_field(context->byte_76_srqn_op_en,
 			       V2_QPC_BYTE_76_SRQN_M, V2_QPC_BYTE_76_SRQN_S,
 			       to_hr_srq(ibqp->srq)->srqn);
-		roce_set_field(qpc_mask->byte_76_srqn_op_en,
-			       V2_QPC_BYTE_76_SRQN_M, V2_QPC_BYTE_76_SRQN_S, 0);
 		roce_set_bit(context->byte_76_srqn_op_en,
 			     V2_QPC_BYTE_76_SRQ_EN_S, 1);
-		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
-			     V2_QPC_BYTE_76_SRQ_EN_S, 0);
 	}
 
-	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
-	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_S, 0);
-
-	roce_set_field(qpc_mask->byte_92_srq_info, V2_QPC_BYTE_92_SRQ_INFO_M,
-		       V2_QPC_BYTE_92_SRQ_INFO_S, 0);
-
-	roce_set_field(qpc_mask->byte_96_rx_reqmsn, V2_QPC_BYTE_96_RX_REQ_MSN_M,
-		       V2_QPC_BYTE_96_RX_REQ_MSN_S, 0);
-
-	roce_set_field(qpc_mask->byte_104_rq_sge,
-		       V2_QPC_BYTE_104_RQ_CUR_WQE_SGE_NUM_M,
-		       V2_QPC_BYTE_104_RQ_CUR_WQE_SGE_NUM_S, 0);
-
-	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
-		     V2_QPC_BYTE_108_RX_REQ_PSN_ERR_S, 0);
-	roce_set_field(qpc_mask->byte_108_rx_reqepsn,
-		       V2_QPC_BYTE_108_RX_REQ_LAST_OPTYPE_M,
-		       V2_QPC_BYTE_108_RX_REQ_LAST_OPTYPE_S, 0);
-	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
-		     V2_QPC_BYTE_108_RX_REQ_RNR_S, 0);
-
-	qpc_mask->rq_rnr_timer = 0;
-	qpc_mask->rx_msg_len = 0;
-	qpc_mask->rx_rkey_pkt_info = 0;
-	qpc_mask->rx_va = 0;
-
-	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_HEAD_MAX_M,
-		       V2_QPC_BYTE_132_TRRL_HEAD_MAX_S, 0);
-	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_TAIL_MAX_M,
-		       V2_QPC_BYTE_132_TRRL_TAIL_MAX_S, 0);
-
-	roce_set_bit(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RQ_RTY_WAIT_DO_S,
-		     0);
-	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RAQ_TRRL_HEAD_M,
-		       V2_QPC_BYTE_140_RAQ_TRRL_HEAD_S, 0);
-	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_RAQ_TRRL_TAIL_M,
-		       V2_QPC_BYTE_140_RAQ_TRRL_TAIL_S, 0);
-
-	roce_set_field(qpc_mask->byte_144_raq,
-		       V2_QPC_BYTE_144_RAQ_RTY_INI_PSN_M,
-		       V2_QPC_BYTE_144_RAQ_RTY_INI_PSN_S, 0);
-	roce_set_field(qpc_mask->byte_144_raq, V2_QPC_BYTE_144_RAQ_CREDIT_M,
-		       V2_QPC_BYTE_144_RAQ_CREDIT_S, 0);
-	roce_set_bit(qpc_mask->byte_144_raq, V2_QPC_BYTE_144_RESP_RTY_FLG_S, 0);
-
-	roce_set_field(qpc_mask->byte_148_raq, V2_QPC_BYTE_148_RQ_MSN_M,
-		       V2_QPC_BYTE_148_RQ_MSN_S, 0);
-	roce_set_field(qpc_mask->byte_148_raq, V2_QPC_BYTE_148_RAQ_SYNDROME_M,
-		       V2_QPC_BYTE_148_RAQ_SYNDROME_S, 0);
-
-	roce_set_field(qpc_mask->byte_152_raq, V2_QPC_BYTE_152_RAQ_PSN_M,
-		       V2_QPC_BYTE_152_RAQ_PSN_S, 0);
-	roce_set_field(qpc_mask->byte_152_raq,
-		       V2_QPC_BYTE_152_RAQ_TRRL_RTY_HEAD_M,
-		       V2_QPC_BYTE_152_RAQ_TRRL_RTY_HEAD_S, 0);
-
-	roce_set_field(qpc_mask->byte_156_raq, V2_QPC_BYTE_156_RAQ_USE_PKTN_M,
-		       V2_QPC_BYTE_156_RAQ_USE_PKTN_S, 0);
-
-	roce_set_field(qpc_mask->byte_160_sq_ci_pi,
-		       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-		       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
-	roce_set_field(qpc_mask->byte_160_sq_ci_pi,
-		       V2_QPC_BYTE_160_SQ_CONSUMER_IDX_M,
-		       V2_QPC_BYTE_160_SQ_CONSUMER_IDX_S, 0);
-
-	roce_set_bit(qpc_mask->byte_168_irrl_idx,
-		     V2_QPC_BYTE_168_POLL_DB_WAIT_DO_S, 0);
-	roce_set_bit(qpc_mask->byte_168_irrl_idx,
-		     V2_QPC_BYTE_168_SCC_TOKEN_FORBID_SQ_DEQ_S, 0);
-	roce_set_bit(qpc_mask->byte_168_irrl_idx,
-		     V2_QPC_BYTE_168_WAIT_ACK_TIMEOUT_S, 0);
-	roce_set_bit(qpc_mask->byte_168_irrl_idx,
-		     V2_QPC_BYTE_168_MSG_RTY_LP_FLG_S, 0);
-	roce_set_bit(qpc_mask->byte_168_irrl_idx,
-		     V2_QPC_BYTE_168_SQ_INVLD_FLG_S, 0);
-	roce_set_field(qpc_mask->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_IRRL_IDX_LSB_M,
-		       V2_QPC_BYTE_168_IRRL_IDX_LSB_S, 0);
-
 	roce_set_field(context->byte_172_sq_psn, V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
 		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, 4);
-	roce_set_field(qpc_mask->byte_172_sq_psn,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_M,
-		       V2_QPC_BYTE_172_ACK_REQ_FREQ_S, 0);
-
-	roce_set_bit(qpc_mask->byte_172_sq_psn, V2_QPC_BYTE_172_MSG_RNR_FLG_S,
-		     0);
 
 	roce_set_bit(context->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 1);
-	roce_set_bit(qpc_mask->byte_172_sq_psn, V2_QPC_BYTE_172_FRE_S, 0);
-
-	roce_set_field(qpc_mask->byte_176_msg_pktn,
-		       V2_QPC_BYTE_176_MSG_USE_PKTN_M,
-		       V2_QPC_BYTE_176_MSG_USE_PKTN_S, 0);
-	roce_set_field(qpc_mask->byte_176_msg_pktn,
-		       V2_QPC_BYTE_176_IRRL_HEAD_PRE_M,
-		       V2_QPC_BYTE_176_IRRL_HEAD_PRE_S, 0);
-
-	roce_set_field(qpc_mask->byte_184_irrl_idx,
-		       V2_QPC_BYTE_184_IRRL_IDX_MSB_M,
-		       V2_QPC_BYTE_184_IRRL_IDX_MSB_S, 0);
-
-	qpc_mask->cur_sge_offset = 0;
-
-	roce_set_field(qpc_mask->byte_192_ext_sge,
-		       V2_QPC_BYTE_192_CUR_SGE_IDX_M,
-		       V2_QPC_BYTE_192_CUR_SGE_IDX_S, 0);
-	roce_set_field(qpc_mask->byte_192_ext_sge,
-		       V2_QPC_BYTE_192_EXT_SGE_NUM_LEFT_M,
-		       V2_QPC_BYTE_192_EXT_SGE_NUM_LEFT_S, 0);
-
-	roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_IRRL_HEAD_M,
-		       V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
-
-	roce_set_field(qpc_mask->byte_200_sq_max, V2_QPC_BYTE_200_SQ_MAX_IDX_M,
-		       V2_QPC_BYTE_200_SQ_MAX_IDX_S, 0);
-	roce_set_field(qpc_mask->byte_200_sq_max,
-		       V2_QPC_BYTE_200_LCL_OPERATED_CNT_M,
-		       V2_QPC_BYTE_200_LCL_OPERATED_CNT_S, 0);
-
-	roce_set_bit(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_PKT_RNR_FLG_S, 0);
-	roce_set_bit(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_PKT_RTY_FLG_S, 0);
-
-	roce_set_field(qpc_mask->byte_212_lsn, V2_QPC_BYTE_212_CHECK_FLG_M,
-		       V2_QPC_BYTE_212_CHECK_FLG_S, 0);
-
-	qpc_mask->sq_timer = 0;
-
-	roce_set_field(qpc_mask->byte_220_retry_psn_msn,
-		       V2_QPC_BYTE_220_RETRY_MSG_MSN_M,
-		       V2_QPC_BYTE_220_RETRY_MSG_MSN_S, 0);
-	roce_set_field(qpc_mask->byte_232_irrl_sge,
-		       V2_QPC_BYTE_232_IRRL_SGE_IDX_M,
-		       V2_QPC_BYTE_232_IRRL_SGE_IDX_S, 0);
-
-	roce_set_bit(qpc_mask->byte_232_irrl_sge, V2_QPC_BYTE_232_SO_LP_VLD_S,
-		     0);
-	roce_set_bit(qpc_mask->byte_232_irrl_sge,
-		     V2_QPC_BYTE_232_FENCE_LP_VLD_S, 0);
-	roce_set_bit(qpc_mask->byte_232_irrl_sge, V2_QPC_BYTE_232_IRRL_LP_VLD_S,
-		     0);
-
-	qpc_mask->irrl_cur_sge_offset = 0;
-
-	roce_set_field(qpc_mask->byte_240_irrl_tail,
-		       V2_QPC_BYTE_240_IRRL_TAIL_REAL_M,
-		       V2_QPC_BYTE_240_IRRL_TAIL_REAL_S, 0);
-	roce_set_field(qpc_mask->byte_240_irrl_tail,
-		       V2_QPC_BYTE_240_IRRL_TAIL_RD_M,
-		       V2_QPC_BYTE_240_IRRL_TAIL_RD_S, 0);
-	roce_set_field(qpc_mask->byte_240_irrl_tail,
-		       V2_QPC_BYTE_240_RX_ACK_MSN_M,
-		       V2_QPC_BYTE_240_RX_ACK_MSN_S, 0);
-
-	roce_set_field(qpc_mask->byte_248_ack_psn, V2_QPC_BYTE_248_IRRL_PSN_M,
-		       V2_QPC_BYTE_248_IRRL_PSN_S, 0);
-	roce_set_bit(qpc_mask->byte_248_ack_psn, V2_QPC_BYTE_248_ACK_PSN_ERR_S,
-		     0);
-	roce_set_field(qpc_mask->byte_248_ack_psn,
-		       V2_QPC_BYTE_248_ACK_LAST_OPTYPE_M,
-		       V2_QPC_BYTE_248_ACK_LAST_OPTYPE_S, 0);
-	roce_set_bit(qpc_mask->byte_248_ack_psn, V2_QPC_BYTE_248_IRRL_PSN_VLD_S,
-		     0);
-	roce_set_bit(qpc_mask->byte_248_ack_psn,
-		     V2_QPC_BYTE_248_RNR_RETRY_FLAG_S, 0);
-	roce_set_bit(qpc_mask->byte_248_ack_psn, V2_QPC_BYTE_248_CQ_ERR_IND_S,
-		     0);
 
 	hr_qp->access_flags = attr->qp_access_flags;
 	roce_set_field(context->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
 		       V2_QPC_BYTE_252_TX_CQN_S, to_hr_cq(ibqp->send_cq)->cqn);
-	roce_set_field(qpc_mask->byte_252_err_txcqn, V2_QPC_BYTE_252_TX_CQN_M,
-		       V2_QPC_BYTE_252_TX_CQN_S, 0);
-
-	roce_set_field(qpc_mask->byte_252_err_txcqn, V2_QPC_BYTE_252_ERR_TYPE_M,
-		       V2_QPC_BYTE_252_ERR_TYPE_S, 0);
-
-	roce_set_field(qpc_mask->byte_256_sqflush_rqcqe,
-		       V2_QPC_BYTE_256_RQ_CQE_IDX_M,
-		       V2_QPC_BYTE_256_RQ_CQE_IDX_S, 0);
-	roce_set_field(qpc_mask->byte_256_sqflush_rqcqe,
-		       V2_QPC_BYTE_256_SQ_FLUSH_IDX_M,
-		       V2_QPC_BYTE_256_SQ_FLUSH_IDX_S, 0);
 }
 
 static void modify_qp_init_to_init(struct ib_qp *ibqp,
-- 
2.8.1

