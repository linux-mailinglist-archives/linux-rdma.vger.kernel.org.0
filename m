Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACE131223
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 13:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFMZN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 07:25:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbgAFMZN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 07:25:13 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ABB2CFC9C47D488B6886;
        Mon,  6 Jan 2020 20:25:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 20:25:00 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 7/7] RDMA/hns: Fix coding style issues
Date:   Mon, 6 Jan 2020 20:21:16 +0800
Message-ID: <1578313276-29080-8-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
References: <1578313276-29080-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

Fix some coding style issuses without changing logic of codes, most of the
modification is unreasonable line breaks and alignments.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 167 ++++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_main.c  |  56 +++++-----
 2 files changed, 86 insertions(+), 137 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index be2e114..e391b00 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -63,20 +63,15 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
 	struct hns_roce_mr *mr = to_hr_mr(wr->mr);
 
 	/* use ib_access_flags */
-	roce_set_bit(rc_sq_wqe->byte_4,
-		     V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S,
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_BIND_EN_S,
 		     wr->access & IB_ACCESS_MW_BIND ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4,
-		     V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S,
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_ATOMIC_S,
 		     wr->access & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4,
-		     V2_RC_FRMR_WQE_BYTE_4_RR_S,
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_RR_S,
 		     wr->access & IB_ACCESS_REMOTE_READ ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4,
-		     V2_RC_FRMR_WQE_BYTE_4_RW_S,
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_RW_S,
 		     wr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0);
-	roce_set_bit(rc_sq_wqe->byte_4,
-		     V2_RC_FRMR_WQE_BYTE_4_LW_S,
+	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_FRMR_WQE_BYTE_4_LW_S,
 		     wr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0);
 
 	/* Data structure reuse may lead to confusion */
@@ -1378,7 +1373,7 @@ static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 }
 
 static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
-						  int vf_id)
+					int vf_id)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_vf_switch *swt;
@@ -1387,13 +1382,12 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 	swt = (struct hns_roce_vf_switch *)desc.data;
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_SWITCH_PARAMETER_CFG, true);
 	swt->rocee_sel |= cpu_to_le32(HNS_ICL_SWITCH_CMD_ROCEE_SEL);
-	roce_set_field(swt->fun_id,
-			VF_SWITCH_DATA_FUN_ID_VF_ID_M,
-			VF_SWITCH_DATA_FUN_ID_VF_ID_S,
-			vf_id);
+	roce_set_field(swt->fun_id, VF_SWITCH_DATA_FUN_ID_VF_ID_M,
+		       VF_SWITCH_DATA_FUN_ID_VF_ID_S, vf_id);
 	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
 	if (ret)
 		return ret;
+
 	desc.flag =
 		cpu_to_le16(HNS_ROCE_CMD_FLAG_NO_INTR | HNS_ROCE_CMD_FLAG_IN);
 	desc.flag &= cpu_to_le16(~HNS_ROCE_CMD_FLAG_WR);
@@ -1817,37 +1811,32 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 			req_a->base_addr_h =
 				cpu_to_le32(link_tbl->table.map >> 32);
 			roce_set_field(req_a->depth_pgsz_init_en,
-				       CFG_LLM_QUE_DEPTH_M,
-				       CFG_LLM_QUE_DEPTH_S,
+				       CFG_LLM_QUE_DEPTH_M, CFG_LLM_QUE_DEPTH_S,
 				       link_tbl->npages);
 			roce_set_field(req_a->depth_pgsz_init_en,
-				       CFG_LLM_QUE_PGSZ_M,
-				       CFG_LLM_QUE_PGSZ_S,
+				       CFG_LLM_QUE_PGSZ_M, CFG_LLM_QUE_PGSZ_S,
 				       link_tbl->pg_sz);
 			req_a->head_ba_l = cpu_to_le32(entry[0].blk_ba0);
 			req_a->head_ba_h_nxtptr =
 				cpu_to_le32(entry[0].blk_ba1_nxt_ptr);
-			roce_set_field(req_a->head_ptr,
-				       CFG_LLM_HEAD_PTR_M,
+			roce_set_field(req_a->head_ptr, CFG_LLM_HEAD_PTR_M,
 				       CFG_LLM_HEAD_PTR_S, 0);
 		} else {
 			req_b->tail_ba_l =
 				cpu_to_le32(entry[page_num - 1].blk_ba0);
-			roce_set_field(req_b->tail_ba_h,
-				       CFG_LLM_TAIL_BA_H_M,
+			roce_set_field(req_b->tail_ba_h, CFG_LLM_TAIL_BA_H_M,
 				       CFG_LLM_TAIL_BA_H_S,
 				       entry[page_num - 1].blk_ba1_nxt_ptr &
 				       HNS_ROCE_LINK_TABLE_BA1_M);
-			roce_set_field(req_b->tail_ptr,
-				       CFG_LLM_TAIL_PTR_M,
+			roce_set_field(req_b->tail_ptr, CFG_LLM_TAIL_PTR_M,
 				       CFG_LLM_TAIL_PTR_S,
 				       (entry[page_num - 2].blk_ba1_nxt_ptr &
 				       HNS_ROCE_LINK_TABLE_NXT_PTR_M) >>
 				       HNS_ROCE_LINK_TABLE_NXT_PTR_S);
 		}
 	}
-	roce_set_field(req_a->depth_pgsz_init_en,
-		       CFG_LLM_INIT_EN_M, CFG_LLM_INIT_EN_S, 1);
+	roce_set_field(req_a->depth_pgsz_init_en, CFG_LLM_INIT_EN_M,
+		       CFG_LLM_INIT_EN_S, 1);
 
 	return hns_roce_cmq_send(hr_dev, desc, 2);
 }
@@ -2140,11 +2129,9 @@ static int hns_roce_config_sgid_table(struct hns_roce_dev *hr_dev,
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_CFG_SGID_TB, false);
 
-	roce_set_field(sgid_tb->table_idx_rsv,
-		       CFG_SGID_TB_TABLE_IDX_M,
+	roce_set_field(sgid_tb->table_idx_rsv, CFG_SGID_TB_TABLE_IDX_M,
 		       CFG_SGID_TB_TABLE_IDX_S, gid_index);
-	roce_set_field(sgid_tb->vf_sgid_type_rsv,
-		       CFG_SGID_TB_VF_SGID_TYPE_M,
+	roce_set_field(sgid_tb->vf_sgid_type_rsv, CFG_SGID_TB_VF_SGID_TYPE_M,
 		       CFG_SGID_TB_VF_SGID_TYPE_S, sgid_type);
 
 	p = (u32 *)&gid->raw[0];
@@ -2415,8 +2402,7 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 		       V2_MPT_BYTE_4_MPT_ST_S, V2_MPT_ST_FREE);
 	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
 		       V2_MPT_BYTE_4_PD_S, mw->pdn);
-	roce_set_field(mpt_entry->byte_4_pd_hop_st,
-		       V2_MPT_BYTE_4_PBL_HOP_NUM_M,
+	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PBL_HOP_NUM_M,
 		       V2_MPT_BYTE_4_PBL_HOP_NUM_S,
 		       mw->pbl_hop_num == HNS_ROCE_HOP_NUM_0 ?
 		       0 : mw->pbl_hop_num);
@@ -2560,8 +2546,7 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_ARM_ST_M,
 		       V2_CQC_BYTE_4_ARM_ST_S, REG_NXT_CEQE);
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_SHIFT_M,
-		       V2_CQC_BYTE_4_SHIFT_S,
-		       ilog2(hr_cq->cq_depth));
+		       V2_CQC_BYTE_4_SHIFT_S, ilog2(hr_cq->cq_depth));
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_CEQN_M,
 		       V2_CQC_BYTE_4_CEQN_S, hr_cq->vector);
 
@@ -3835,13 +3820,11 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	/* Configure GID index */
 	port_num = rdma_ah_get_port_num(&attr->ah_attr);
 	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGID_IDX_M,
-		       V2_QPC_BYTE_20_SGID_IDX_S,
+		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S,
 		       hns_get_gid_index(hr_dev, port_num - 1,
 					 grh->sgid_index));
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SGID_IDX_M,
-		       V2_QPC_BYTE_20_SGID_IDX_S, 0);
+		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S, 0);
 	memcpy(&(context->dmac), dmac, sizeof(u32));
 	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, *((u16 *)(&dmac[4])));
@@ -4231,8 +4214,7 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 
 		roce_set_field(context->byte_212_lsn,
 			       V2_QPC_BYTE_212_RETRY_CNT_M,
-			       V2_QPC_BYTE_212_RETRY_CNT_S,
-			       attr->retry_cnt);
+			       V2_QPC_BYTE_212_RETRY_CNT_S, attr->retry_cnt);
 		roce_set_field(qpc_mask->byte_212_lsn,
 			       V2_QPC_BYTE_212_RETRY_CNT_M,
 			       V2_QPC_BYTE_212_RETRY_CNT_S, 0);
@@ -5152,8 +5134,7 @@ static int hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 		 */
 		dma_rmb();
 
-		cqn = roce_get_field(ceqe->comp,
-				     HNS_ROCE_V2_CEQE_COMP_CQN_M,
+		cqn = roce_get_field(ceqe->comp, HNS_ROCE_V2_CEQE_COMP_CQN_M,
 				     HNS_ROCE_V2_CEQE_COMP_CQN_S);
 
 		hns_roce_cq_completion(hr_dev, cqn);
@@ -5406,126 +5387,98 @@ static void hns_roce_config_eqc(struct hns_roce_dev *hr_dev,
 		eq->eqe_ba = eq->l0_dma;
 
 	/* set eqc state */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_EQ_ST_M,
-		       HNS_ROCE_EQC_EQ_ST_S,
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQ_ST_M, HNS_ROCE_EQC_EQ_ST_S,
 		       HNS_ROCE_V2_EQ_STATE_VALID);
 
 	/* set eqe hop num */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_HOP_NUM_M,
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_HOP_NUM_M,
 		       HNS_ROCE_EQC_HOP_NUM_S, eq->hop_num);
 
 	/* set eqc over_ignore */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_OVER_IGNORE_M,
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_OVER_IGNORE_M,
 		       HNS_ROCE_EQC_OVER_IGNORE_S, eq->over_ignore);
 
 	/* set eqc coalesce */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_COALESCE_M,
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_COALESCE_M,
 		       HNS_ROCE_EQC_COALESCE_S, eq->coalesce);
 
 	/* set eqc arm_state */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_ARM_ST_M,
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_ARM_ST_M,
 		       HNS_ROCE_EQC_ARM_ST_S, eq->arm_st);
 
 	/* set eqn */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_EQN_M,
-		       HNS_ROCE_EQC_EQN_S, eq->eqn);
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQN_M, HNS_ROCE_EQC_EQN_S,
+		       eq->eqn);
 
 	/* set eqe_cnt */
-	roce_set_field(eqc->byte_4,
-		       HNS_ROCE_EQC_EQE_CNT_M,
-		       HNS_ROCE_EQC_EQE_CNT_S,
-		       HNS_ROCE_EQ_INIT_EQE_CNT);
+	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQE_CNT_M,
+		       HNS_ROCE_EQC_EQE_CNT_S, HNS_ROCE_EQ_INIT_EQE_CNT);
 
 	/* set eqe_ba_pg_sz */
-	roce_set_field(eqc->byte_8,
-		       HNS_ROCE_EQC_BA_PG_SZ_M,
+	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_BA_PG_SZ_M,
 		       HNS_ROCE_EQC_BA_PG_SZ_S,
 		       eq->eqe_ba_pg_sz + PG_SHIFT_OFFSET);
 
 	/* set eqe_buf_pg_sz */
-	roce_set_field(eqc->byte_8,
-		       HNS_ROCE_EQC_BUF_PG_SZ_M,
+	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_BUF_PG_SZ_M,
 		       HNS_ROCE_EQC_BUF_PG_SZ_S,
 		       eq->eqe_buf_pg_sz + PG_SHIFT_OFFSET);
 
 	/* set eq_producer_idx */
-	roce_set_field(eqc->byte_8,
-		       HNS_ROCE_EQC_PROD_INDX_M,
-		       HNS_ROCE_EQC_PROD_INDX_S,
-		       HNS_ROCE_EQ_INIT_PROD_IDX);
+	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_PROD_INDX_M,
+		       HNS_ROCE_EQC_PROD_INDX_S, HNS_ROCE_EQ_INIT_PROD_IDX);
 
 	/* set eq_max_cnt */
-	roce_set_field(eqc->byte_12,
-		       HNS_ROCE_EQC_MAX_CNT_M,
+	roce_set_field(eqc->byte_12, HNS_ROCE_EQC_MAX_CNT_M,
 		       HNS_ROCE_EQC_MAX_CNT_S, eq->eq_max_cnt);
 
 	/* set eq_period */
-	roce_set_field(eqc->byte_12,
-		       HNS_ROCE_EQC_PERIOD_M,
+	roce_set_field(eqc->byte_12, HNS_ROCE_EQC_PERIOD_M,
 		       HNS_ROCE_EQC_PERIOD_S, eq->eq_period);
 
 	/* set eqe_report_timer */
-	roce_set_field(eqc->eqe_report_timer,
-		       HNS_ROCE_EQC_REPORT_TIMER_M,
+	roce_set_field(eqc->eqe_report_timer, HNS_ROCE_EQC_REPORT_TIMER_M,
 		       HNS_ROCE_EQC_REPORT_TIMER_S,
 		       HNS_ROCE_EQ_INIT_REPORT_TIMER);
 
 	/* set eqe_ba [34:3] */
-	roce_set_field(eqc->eqe_ba0,
-		       HNS_ROCE_EQC_EQE_BA_L_M,
+	roce_set_field(eqc->eqe_ba0, HNS_ROCE_EQC_EQE_BA_L_M,
 		       HNS_ROCE_EQC_EQE_BA_L_S, eq->eqe_ba >> 3);
 
 	/* set eqe_ba [64:35] */
-	roce_set_field(eqc->eqe_ba1,
-		       HNS_ROCE_EQC_EQE_BA_H_M,
+	roce_set_field(eqc->eqe_ba1, HNS_ROCE_EQC_EQE_BA_H_M,
 		       HNS_ROCE_EQC_EQE_BA_H_S, eq->eqe_ba >> 35);
 
 	/* set eq shift */
-	roce_set_field(eqc->byte_28,
-		       HNS_ROCE_EQC_SHIFT_M,
-		       HNS_ROCE_EQC_SHIFT_S, eq->shift);
+	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_SHIFT_M, HNS_ROCE_EQC_SHIFT_S,
+		       eq->shift);
 
 	/* set eq MSI_IDX */
-	roce_set_field(eqc->byte_28,
-		       HNS_ROCE_EQC_MSI_INDX_M,
-		       HNS_ROCE_EQC_MSI_INDX_S,
-		       HNS_ROCE_EQ_INIT_MSI_IDX);
+	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_MSI_INDX_M,
+		       HNS_ROCE_EQC_MSI_INDX_S, HNS_ROCE_EQ_INIT_MSI_IDX);
 
 	/* set cur_eqe_ba [27:12] */
-	roce_set_field(eqc->byte_28,
-		       HNS_ROCE_EQC_CUR_EQE_BA_L_M,
+	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_CUR_EQE_BA_L_M,
 		       HNS_ROCE_EQC_CUR_EQE_BA_L_S, eq->cur_eqe_ba >> 12);
 
 	/* set cur_eqe_ba [59:28] */
-	roce_set_field(eqc->byte_32,
-		       HNS_ROCE_EQC_CUR_EQE_BA_M_M,
+	roce_set_field(eqc->byte_32, HNS_ROCE_EQC_CUR_EQE_BA_M_M,
 		       HNS_ROCE_EQC_CUR_EQE_BA_M_S, eq->cur_eqe_ba >> 28);
 
 	/* set cur_eqe_ba [63:60] */
-	roce_set_field(eqc->byte_36,
-		       HNS_ROCE_EQC_CUR_EQE_BA_H_M,
+	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CUR_EQE_BA_H_M,
 		       HNS_ROCE_EQC_CUR_EQE_BA_H_S, eq->cur_eqe_ba >> 60);
 
 	/* set eq consumer idx */
-	roce_set_field(eqc->byte_36,
-		       HNS_ROCE_EQC_CONS_INDX_M,
-		       HNS_ROCE_EQC_CONS_INDX_S,
-		       HNS_ROCE_EQ_INIT_CONS_IDX);
+	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CONS_INDX_M,
+		       HNS_ROCE_EQC_CONS_INDX_S, HNS_ROCE_EQ_INIT_CONS_IDX);
 
 	/* set nex_eqe_ba[43:12] */
-	roce_set_field(eqc->nxt_eqe_ba0,
-		       HNS_ROCE_EQC_NXT_EQE_BA_L_M,
+	roce_set_field(eqc->nxt_eqe_ba0, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
 		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eq->nxt_eqe_ba >> 12);
 
 	/* set nex_eqe_ba[63:44] */
-	roce_set_field(eqc->nxt_eqe_ba1,
-		       HNS_ROCE_EQC_NXT_EQE_BA_H_M,
+	roce_set_field(eqc->nxt_eqe_ba1, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
 		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eq->nxt_eqe_ba >> 44);
 }
 
@@ -5825,18 +5778,16 @@ static int __hns_roce_request_irq(struct hns_roce_dev *hr_dev, int irq_num,
 
 	/* irq contains: abnormal + AEQ + CEQ */
 	for (j = 0; j < other_num; j++)
-		snprintf((char *)hr_dev->irq_names[j],
-			 HNS_ROCE_INT_NAME_LEN, "hns-abn-%d", j);
+		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
+			 "hns-abn-%d", j);
 
 	for (j = other_num; j < (other_num + aeq_num); j++)
-		snprintf((char *)hr_dev->irq_names[j],
-			 HNS_ROCE_INT_NAME_LEN, "hns-aeq-%d",
-			 j - other_num);
+		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
+			 "hns-aeq-%d", j - other_num);
 
 	for (j = (other_num + aeq_num); j < irq_num; j++)
-		snprintf((char *)hr_dev->irq_names[j],
-			 HNS_ROCE_INT_NAME_LEN, "hns-ceq-%d",
-			 j - other_num - aeq_num);
+		snprintf((char *)hr_dev->irq_names[j], HNS_ROCE_INT_NAME_LEN,
+			 "hns-ceq-%d", j - other_num - aeq_num);
 
 	for (j = 0; j < irq_num; j++) {
 		if (j < other_num)
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 854ef6e..ac2e426 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -90,7 +90,7 @@ static int hns_roce_add_gid(const struct ib_gid_attr *attr, void **context)
 static int hns_roce_del_gid(const struct ib_gid_attr *attr, void **context)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(attr->device);
-	struct ib_gid_attr zattr = { };
+	struct ib_gid_attr zattr = {};
 	u8 port = attr->port_num - 1;
 	int ret;
 
@@ -259,11 +259,11 @@ static int hns_roce_query_port(struct ib_device *ib_dev, u8 port_num,
 
 	mtu = iboe_get_mtu(net_dev->mtu);
 	props->active_mtu = mtu ? min(props->max_mtu, mtu) : IB_MTU_256;
-	props->state = (netif_running(net_dev) && netif_carrier_ok(net_dev)) ?
-			IB_PORT_ACTIVE : IB_PORT_DOWN;
-	props->phys_state = (props->state == IB_PORT_ACTIVE) ?
-			     IB_PORT_PHYS_STATE_LINK_UP :
-			     IB_PORT_PHYS_STATE_DISABLED;
+	props->state = netif_running(net_dev) && netif_carrier_ok(net_dev) ?
+		       IB_PORT_ACTIVE : IB_PORT_DOWN;
+	props->phys_state = props->state == IB_PORT_ACTIVE ?
+			    IB_PORT_PHYS_STATE_LINK_UP :
+			    IB_PORT_PHYS_STATE_DISABLED;
 
 	spin_unlock_irqrestore(&hr_dev->iboe.lock, flags);
 
@@ -481,13 +481,13 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 
 	ib_dev = &hr_dev->ib_dev;
 
-	ib_dev->node_type		= RDMA_NODE_IB_CA;
-	ib_dev->dev.parent		= dev;
+	ib_dev->node_type = RDMA_NODE_IB_CA;
+	ib_dev->dev.parent = dev;
 
-	ib_dev->phys_port_cnt		= hr_dev->caps.num_ports;
-	ib_dev->local_dma_lkey		= hr_dev->caps.reserved_lkey;
-	ib_dev->num_comp_vectors	= hr_dev->caps.num_comp_vectors;
-	ib_dev->uverbs_cmd_mask		=
+	ib_dev->phys_port_cnt = hr_dev->caps.num_ports;
+	ib_dev->local_dma_lkey = hr_dev->caps.reserved_lkey;
+	ib_dev->num_comp_vectors = hr_dev->caps.num_comp_vectors;
+	ib_dev->uverbs_cmd_mask =
 		(1ULL << IB_USER_VERBS_CMD_GET_CONTEXT) |
 		(1ULL << IB_USER_VERBS_CMD_QUERY_DEVICE) |
 		(1ULL << IB_USER_VERBS_CMD_QUERY_PORT) |
@@ -503,8 +503,7 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
 		(1ULL << IB_USER_VERBS_CMD_QUERY_QP) |
 		(1ULL << IB_USER_VERBS_CMD_DESTROY_QP);
 
-	ib_dev->uverbs_ex_cmd_mask |=
-		(1ULL << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
+	ib_dev->uverbs_ex_cmd_mask |= (1ULL << IB_USER_VERBS_EX_CMD_MODIFY_CQ);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR) {
 		ib_dev->uverbs_cmd_mask |= (1ULL << IB_USER_VERBS_CMD_REREG_MR);
@@ -589,11 +588,13 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 
 	if (hns_roce_check_whether_mhop(hr_dev, HEM_TYPE_CQE)) {
 		ret = hns_roce_init_hem_table(hr_dev,
-				      &hr_dev->mr_table.mtt_cqe_table,
-				      HEM_TYPE_CQE, hr_dev->caps.mtt_entry_sz,
-				      hr_dev->caps.num_cqe_segs, 1);
+					      &hr_dev->mr_table.mtt_cqe_table,
+					      HEM_TYPE_CQE,
+					      hr_dev->caps.mtt_entry_sz,
+					      hr_dev->caps.num_cqe_segs, 1);
 		if (ret) {
-			dev_err(dev, "Failed to init MTT CQE context memory, aborting.\n");
+			dev_err(dev,
+				"Failed to init CQE context memory, aborting.\n");
 			goto err_unmap_cqe;
 		}
 	}
@@ -633,7 +634,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_qps, 1);
 		if (ret) {
 			dev_err(dev,
-			       "Failed to init trrl_table memory, aborting.\n");
+				"Failed to init trrl_table memory, aborting.\n");
 			goto err_unmap_irrl;
 		}
 	}
@@ -653,7 +654,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_srqs, 1);
 		if (ret) {
 			dev_err(dev,
-			      "Failed to init SRQ context memory, aborting.\n");
+				"Failed to init SRQ context memory, aborting.\n");
 			goto err_unmap_cq;
 		}
 	}
@@ -692,33 +693,31 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 					      hr_dev->caps.num_qps, 1);
 		if (ret) {
 			dev_err(dev,
-			      "Failed to init SCC context memory, aborting.\n");
+				"Failed to init SCC context memory, aborting.\n");
 			goto err_unmap_idx;
 		}
 	}
 
 	if (hr_dev->caps.qpc_timer_entry_sz) {
-		ret = hns_roce_init_hem_table(hr_dev,
-					      &hr_dev->qpc_timer_table,
+		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->qpc_timer_table,
 					      HEM_TYPE_QPC_TIMER,
 					      hr_dev->caps.qpc_timer_entry_sz,
 					      hr_dev->caps.num_qpc_timer, 1);
 		if (ret) {
 			dev_err(dev,
-			      "Failed to init QPC timer memory, aborting.\n");
+				"Failed to init QPC timer memory, aborting.\n");
 			goto err_unmap_ctx;
 		}
 	}
 
 	if (hr_dev->caps.cqc_timer_entry_sz) {
-		ret = hns_roce_init_hem_table(hr_dev,
-					      &hr_dev->cqc_timer_table,
+		ret = hns_roce_init_hem_table(hr_dev, &hr_dev->cqc_timer_table,
 					      HEM_TYPE_CQC_TIMER,
 					      hr_dev->caps.cqc_timer_entry_sz,
 					      hr_dev->caps.num_cqc_timer, 1);
 		if (ret) {
 			dev_err(dev,
-			      "Failed to init CQC timer memory, aborting.\n");
+				"Failed to init CQC timer memory, aborting.\n");
 			goto err_unmap_qpc_timer;
 		}
 	}
@@ -727,8 +726,7 @@ static int hns_roce_init_hem(struct hns_roce_dev *hr_dev)
 
 err_unmap_qpc_timer:
 	if (hr_dev->caps.qpc_timer_entry_sz)
-		hns_roce_cleanup_hem_table(hr_dev,
-					   &hr_dev->qpc_timer_table);
+		hns_roce_cleanup_hem_table(hr_dev, &hr_dev->qpc_timer_table);
 
 err_unmap_ctx:
 	if (hr_dev->caps.sccc_entry_sz)
-- 
2.8.1

