Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 291541380E0
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2020 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgAKKgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jan 2020 05:36:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731275AbgAKKgg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jan 2020 05:36:36 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FC15CA1B03C8324ECD7;
        Sat, 11 Jan 2020 18:36:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 18:36:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Add interfaces to get pf capabilities from firmware
Date:   Sat, 11 Jan 2020 18:32:40 +0800
Message-ID: <1578738761-3176-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
References: <1578738761-3176-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

pf capabilities are set by default for hip08 previously which should
depends on different types of hardware. So add new interfaces to get
them from firmware.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   6 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 367 ++++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 154 ++++++++++++
 3 files changed, 527 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7459ebb..a7c4ff9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -898,6 +898,12 @@ struct hns_roce_caps {
 	u32		tpq_buf_pg_sz;
 	u32		chunk_sz;	/* chunk size in non multihop mode */
 	u64		flags;
+	u16		default_ceq_max_cnt;
+	u16		default_ceq_period;
+	u16		default_aeq_max_cnt;
+	u16		default_aeq_period;
+	u16		default_aeq_arm_st;
+	u16		default_ceq_arm_st;
 };
 
 struct hns_roce_work {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3b13290..b0c799d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1598,6 +1598,373 @@ static int hns_roce_v2_set_bt(struct hns_roce_dev *hr_dev)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+static void set_default_caps(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_caps *caps = &hr_dev->caps;
+
+	caps->num_qps		= HNS_ROCE_V2_MAX_QP_NUM;
+	caps->max_wqes		= HNS_ROCE_V2_MAX_WQE_NUM;
+	caps->num_cqs		= HNS_ROCE_V2_MAX_CQ_NUM;
+	caps->num_srqs		= HNS_ROCE_V2_MAX_SRQ_NUM;
+	caps->min_cqes		= HNS_ROCE_MIN_CQE_NUM;
+	caps->max_cqes		= HNS_ROCE_V2_MAX_CQE_NUM;
+	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
+	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
+	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
+	caps->max_sq_inline	= HNS_ROCE_V2_MAX_SQ_INLINE;
+	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
+	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
+	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
+	caps->num_comp_vectors	= HNS_ROCE_V2_COMP_VEC_NUM;
+	caps->num_other_vectors = HNS_ROCE_V2_ABNORMAL_VEC_NUM;
+	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
+	caps->num_mtt_segs	= HNS_ROCE_V2_MAX_MTT_SEGS;
+	caps->num_cqe_segs	= HNS_ROCE_V2_MAX_CQE_SEGS;
+	caps->num_srqwqe_segs	= HNS_ROCE_V2_MAX_SRQWQE_SEGS;
+	caps->num_idx_segs	= HNS_ROCE_V2_MAX_IDX_SEGS;
+	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
+	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
+	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
+	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
+	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
+	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
+	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
+	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
+	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
+	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
+	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
+	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
+	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
+	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
+	caps->cq_entry_sz	= HNS_ROCE_V2_CQE_ENTRY_SIZE;
+	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
+	caps->reserved_lkey	= 0;
+	caps->reserved_pds	= 0;
+	caps->reserved_mrws	= 1;
+	caps->reserved_uars	= 0;
+	caps->reserved_cqs	= 0;
+	caps->reserved_srqs	= 0;
+	caps->reserved_qps	= HNS_ROCE_V2_RSV_QPS;
+
+	caps->qpc_ba_pg_sz	= 0;
+	caps->qpc_buf_pg_sz	= 0;
+	caps->qpc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
+	caps->srqc_ba_pg_sz	= 0;
+	caps->srqc_buf_pg_sz	= 0;
+	caps->srqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
+	caps->cqc_ba_pg_sz	= 0;
+	caps->cqc_buf_pg_sz	= 0;
+	caps->cqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
+	caps->mpt_ba_pg_sz	= 0;
+	caps->mpt_buf_pg_sz	= 0;
+	caps->mpt_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
+	caps->mtt_ba_pg_sz	= 0;
+	caps->mtt_buf_pg_sz	= 0;
+	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
+	caps->wqe_sq_hop_num	= HNS_ROCE_SQWQE_HOP_NUM;
+	caps->wqe_sge_hop_num	= HNS_ROCE_EXT_SGE_HOP_NUM;
+	caps->wqe_rq_hop_num	= HNS_ROCE_RQWQE_HOP_NUM;
+	caps->cqe_ba_pg_sz	= HNS_ROCE_BA_PG_SZ_SUPPORTED_256K;
+	caps->cqe_buf_pg_sz	= 0;
+	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
+	caps->srqwqe_ba_pg_sz	= 0;
+	caps->srqwqe_buf_pg_sz	= 0;
+	caps->srqwqe_hop_num	= HNS_ROCE_SRQWQE_HOP_NUM;
+	caps->idx_ba_pg_sz	= 0;
+	caps->idx_buf_pg_sz	= 0;
+	caps->idx_hop_num	= HNS_ROCE_IDX_HOP_NUM;
+	caps->chunk_sz		= HNS_ROCE_V2_TABLE_CHUNK_SIZE;
+
+	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
+				  HNS_ROCE_CAP_FLAG_ROCE_V1_V2 |
+				  HNS_ROCE_CAP_FLAG_RQ_INLINE |
+				  HNS_ROCE_CAP_FLAG_RECORD_DB |
+				  HNS_ROCE_CAP_FLAG_SQ_RECORD_DB;
+
+	caps->pkey_table_len[0] = 1;
+	caps->gid_table_len[0]	= HNS_ROCE_V2_GID_INDEX_NUM;
+	caps->ceqe_depth	= HNS_ROCE_V2_COMP_EQE_NUM;
+	caps->aeqe_depth	= HNS_ROCE_V2_ASYNC_EQE_NUM;
+	caps->local_ca_ack_delay = 0;
+	caps->max_mtu = IB_MTU_4096;
+
+	caps->max_srq_wrs	= HNS_ROCE_V2_MAX_SRQ_WR;
+	caps->max_srq_sges	= HNS_ROCE_V2_MAX_SRQ_SGE;
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
+		caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
+			       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
+			       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
+
+		caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
+		caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
+		caps->qpc_timer_ba_pg_sz  = 0;
+		caps->qpc_timer_buf_pg_sz = 0;
+		caps->qpc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
+		caps->num_cqc_timer	  = HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
+		caps->cqc_timer_entry_sz  = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
+		caps->cqc_timer_ba_pg_sz  = 0;
+		caps->cqc_timer_buf_pg_sz = 0;
+		caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
+
+		caps->sccc_entry_sz	  = HNS_ROCE_V2_SCCC_ENTRY_SZ;
+		caps->sccc_ba_pg_sz	  = 0;
+		caps->sccc_buf_pg_sz	  = 0;
+		caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
+	}
+}
+
+static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
+		       int *buf_page_size, int *bt_page_size, u32 hem_type)
+{
+	u64 obj_per_chunk;
+	int bt_chunk_size = 1 << PAGE_SHIFT;
+	int buf_chunk_size = 1 << PAGE_SHIFT;
+	int obj_per_chunk_default = buf_chunk_size / obj_size;
+
+	*buf_page_size = 0;
+	*bt_page_size = 0;
+
+	switch (hop_num) {
+	case 3:
+		obj_per_chunk = ctx_bt_num * (bt_chunk_size / BA_BYTE_LEN) *
+				(bt_chunk_size / BA_BYTE_LEN) *
+				(bt_chunk_size / BA_BYTE_LEN) *
+				 obj_per_chunk_default;
+		break;
+	case 2:
+		obj_per_chunk = ctx_bt_num * (bt_chunk_size / BA_BYTE_LEN) *
+				(bt_chunk_size / BA_BYTE_LEN) *
+				 obj_per_chunk_default;
+		break;
+	case 1:
+		obj_per_chunk = ctx_bt_num * (bt_chunk_size / BA_BYTE_LEN) *
+				obj_per_chunk_default;
+		break;
+	case HNS_ROCE_HOP_NUM_0:
+		obj_per_chunk = ctx_bt_num * obj_per_chunk_default;
+		break;
+	default:
+		pr_err("Table %d not support hop_num = %d!\n", hem_type,
+			hop_num);
+		return;
+	}
+
+	if (hem_type >= HEM_TYPE_MTT)
+		*bt_page_size = ilog2(DIV_ROUND_UP(obj_num, obj_per_chunk));
+	else
+		*buf_page_size = ilog2(DIV_ROUND_UP(obj_num, obj_per_chunk));
+}
+
+static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM];
+	struct hns_roce_caps *caps = &hr_dev->caps;
+	struct hns_roce_query_pf_caps_a *resp_a;
+	struct hns_roce_query_pf_caps_b *resp_b;
+	struct hns_roce_query_pf_caps_c *resp_c;
+	struct hns_roce_query_pf_caps_d *resp_d;
+	struct hns_roce_query_pf_caps_e *resp_e;
+	int ctx_hop_num;
+	int pbl_hop_num;
+	int ret;
+	int i;
+
+	for (i = 0; i < HNS_ROCE_QUERY_PF_CAPS_CMD_NUM; i++) {
+		hns_roce_cmq_setup_basic_desc(&desc[i],
+					      HNS_ROCE_OPC_QUERY_PF_CAPS_NUM,
+					      true);
+		if (i < (HNS_ROCE_QUERY_PF_CAPS_CMD_NUM - 1))
+			desc[i].flag |= cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+		else
+			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
+	}
+
+	ret = hns_roce_cmq_send(hr_dev, desc, HNS_ROCE_QUERY_PF_CAPS_CMD_NUM);
+	if (ret)
+		return ret;
+
+	resp_a = (struct hns_roce_query_pf_caps_a *)desc[0].data;
+	resp_b = (struct hns_roce_query_pf_caps_b *)desc[1].data;
+	resp_c = (struct hns_roce_query_pf_caps_c *)desc[2].data;
+	resp_d = (struct hns_roce_query_pf_caps_d *)desc[3].data;
+	resp_e = (struct hns_roce_query_pf_caps_e *)desc[4].data;
+
+	caps->local_ca_ack_delay     = resp_a->local_ca_ack_delay;
+	caps->max_sq_sg		     = le16_to_cpu(resp_a->max_sq_sg);
+	caps->max_sq_inline	     = le16_to_cpu(resp_a->max_sq_inline);
+	caps->max_rq_sg		     = le16_to_cpu(resp_a->max_rq_sg);
+	caps->max_extend_sg	     = le32_to_cpu(resp_a->max_extend_sg);
+	caps->num_qpc_timer	     = le16_to_cpu(resp_a->num_qpc_timer);
+	caps->num_cqc_timer	     = le16_to_cpu(resp_a->num_cqc_timer);
+	caps->max_srq_sges	     = le16_to_cpu(resp_a->max_srq_sges);
+	caps->num_aeq_vectors	     = resp_a->num_aeq_vectors;
+	caps->num_other_vectors	     = resp_a->num_other_vectors;
+	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
+	caps->max_rq_desc_sz	     = resp_a->max_rq_desc_sz;
+	caps->max_srq_desc_sz	     = resp_a->max_srq_desc_sz;
+	caps->cq_entry_sz	     = resp_a->cq_entry_sz;
+
+	caps->mtpt_entry_sz	     = resp_b->mtpt_entry_sz;
+	caps->irrl_entry_sz	     = resp_b->irrl_entry_sz;
+	caps->trrl_entry_sz	     = resp_b->trrl_entry_sz;
+	caps->cqc_entry_sz	     = resp_b->cqc_entry_sz;
+	caps->srqc_entry_sz	     = resp_b->srqc_entry_sz;
+	caps->idx_entry_sz	     = resp_b->idx_entry_sz;
+	caps->sccc_entry_sz	     = resp_b->scc_ctx_entry_sz;
+	caps->max_mtu		     = resp_b->max_mtu;
+	caps->qpc_entry_sz	     = le16_to_cpu(resp_b->qpc_entry_sz);
+	caps->min_cqes		     = resp_b->min_cqes;
+	caps->min_wqes		     = resp_b->min_wqes;
+	caps->page_size_cap	     = le32_to_cpu(resp_b->page_size_cap);
+	caps->pkey_table_len[0]	     = resp_b->pkey_table_len;
+	caps->phy_num_uars	     = resp_b->phy_num_uars;
+	ctx_hop_num		     = resp_b->ctx_hop_num;
+	pbl_hop_num		     = resp_b->pbl_hop_num;
+
+	caps->num_pds = 1 << roce_get_field(resp_c->cap_flags_num_pds,
+					    V2_QUERY_PF_CAPS_C_NUM_PDS_M,
+					    V2_QUERY_PF_CAPS_C_NUM_PDS_S);
+	caps->flags = roce_get_field(resp_c->cap_flags_num_pds,
+				     V2_QUERY_PF_CAPS_C_CAP_FLAGS_M,
+				     V2_QUERY_PF_CAPS_C_CAP_FLAGS_S);
+	caps->num_cqs = 1 << roce_get_field(resp_c->max_gid_num_cqs,
+					    V2_QUERY_PF_CAPS_C_NUM_CQS_M,
+					    V2_QUERY_PF_CAPS_C_NUM_CQS_S);
+	caps->gid_table_len[0] = roce_get_field(resp_c->max_gid_num_cqs,
+						V2_QUERY_PF_CAPS_C_MAX_GID_M,
+						V2_QUERY_PF_CAPS_C_MAX_GID_S);
+	caps->max_cqes = 1 << roce_get_field(resp_c->cq_depth,
+					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_M,
+					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_S);
+	caps->num_mtpts = 1 << roce_get_field(resp_c->num_mrws,
+					      V2_QUERY_PF_CAPS_C_NUM_MRWS_M,
+					      V2_QUERY_PF_CAPS_C_NUM_MRWS_S);
+	caps->num_qps = 1 << roce_get_field(resp_c->ord_num_qps,
+					    V2_QUERY_PF_CAPS_C_NUM_QPS_M,
+					    V2_QUERY_PF_CAPS_C_NUM_QPS_S);
+	caps->max_qp_init_rdma = roce_get_field(resp_c->ord_num_qps,
+						V2_QUERY_PF_CAPS_C_MAX_ORD_M,
+						V2_QUERY_PF_CAPS_C_MAX_ORD_S);
+	caps->max_qp_dest_rdma = caps->max_qp_init_rdma;
+	caps->max_wqes = 1 << le16_to_cpu(resp_c->sq_depth);
+	caps->num_srqs = 1 << roce_get_field(resp_d->wq_hop_num_max_srqs,
+					     V2_QUERY_PF_CAPS_D_NUM_SRQS_M,
+					     V2_QUERY_PF_CAPS_D_NUM_SRQS_S);
+	caps->max_srq_wrs = 1 << le16_to_cpu(resp_d->srq_depth);
+	caps->ceqe_depth = 1 << roce_get_field(resp_d->num_ceqs_ceq_depth,
+					       V2_QUERY_PF_CAPS_D_CEQ_DEPTH_M,
+					       V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S);
+	caps->num_comp_vectors = roce_get_field(resp_d->num_ceqs_ceq_depth,
+						V2_QUERY_PF_CAPS_D_NUM_CEQS_M,
+						V2_QUERY_PF_CAPS_D_NUM_CEQS_S);
+	caps->aeqe_depth = 1 << roce_get_field(resp_d->arm_st_aeq_depth,
+					       V2_QUERY_PF_CAPS_D_AEQ_DEPTH_M,
+					       V2_QUERY_PF_CAPS_D_AEQ_DEPTH_S);
+	caps->default_aeq_arm_st = roce_get_field(resp_d->arm_st_aeq_depth,
+					    V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_M,
+					    V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_S);
+	caps->default_ceq_arm_st = roce_get_field(resp_d->arm_st_aeq_depth,
+					    V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_M,
+					    V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_S);
+	caps->reserved_pds = roce_get_field(resp_d->num_uars_rsv_pds,
+					    V2_QUERY_PF_CAPS_D_RSV_PDS_M,
+					    V2_QUERY_PF_CAPS_D_RSV_PDS_S);
+	caps->num_uars = 1 << roce_get_field(resp_d->num_uars_rsv_pds,
+					     V2_QUERY_PF_CAPS_D_NUM_UARS_M,
+					     V2_QUERY_PF_CAPS_D_NUM_UARS_S);
+	caps->reserved_qps = roce_get_field(resp_d->rsv_uars_rsv_qps,
+					    V2_QUERY_PF_CAPS_D_RSV_QPS_M,
+					    V2_QUERY_PF_CAPS_D_RSV_QPS_S);
+	caps->reserved_uars = roce_get_field(resp_d->rsv_uars_rsv_qps,
+					     V2_QUERY_PF_CAPS_D_RSV_UARS_M,
+					     V2_QUERY_PF_CAPS_D_RSV_UARS_S);
+	caps->reserved_mrws = roce_get_field(resp_e->chunk_size_shift_rsv_mrws,
+					     V2_QUERY_PF_CAPS_E_RSV_MRWS_M,
+					     V2_QUERY_PF_CAPS_E_RSV_MRWS_S);
+	caps->chunk_sz = 1 << roce_get_field(resp_e->chunk_size_shift_rsv_mrws,
+					 V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_M,
+					 V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_S);
+	caps->reserved_cqs = roce_get_field(resp_e->rsv_cqs,
+					    V2_QUERY_PF_CAPS_E_RSV_CQS_M,
+					    V2_QUERY_PF_CAPS_E_RSV_CQS_S);
+	caps->reserved_srqs = roce_get_field(resp_e->rsv_srqs,
+					     V2_QUERY_PF_CAPS_E_RSV_SRQS_M,
+					     V2_QUERY_PF_CAPS_E_RSV_SRQS_S);
+	caps->reserved_lkey = roce_get_field(resp_e->rsv_lkey,
+					     V2_QUERY_PF_CAPS_E_RSV_LKEYS_M,
+					     V2_QUERY_PF_CAPS_E_RSV_LKEYS_S);
+	caps->default_ceq_max_cnt = le16_to_cpu(resp_e->ceq_max_cnt);
+	caps->default_ceq_period = le16_to_cpu(resp_e->ceq_period);
+	caps->default_aeq_max_cnt = le16_to_cpu(resp_e->aeq_max_cnt);
+	caps->default_aeq_period = le16_to_cpu(resp_e->aeq_period);
+
+	caps->qpc_timer_entry_sz = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
+	caps->cqc_timer_entry_sz = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
+	caps->mtt_entry_sz = HNS_ROCE_V2_MTT_ENTRY_SZ;
+	caps->num_mtt_segs = HNS_ROCE_V2_MAX_MTT_SEGS;
+	caps->mtt_ba_pg_sz = 0;
+	caps->num_cqe_segs = HNS_ROCE_V2_MAX_CQE_SEGS;
+	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
+	caps->num_idx_segs = HNS_ROCE_V2_MAX_IDX_SEGS;
+
+	caps->qpc_hop_num = ctx_hop_num;
+	caps->srqc_hop_num = ctx_hop_num;
+	caps->cqc_hop_num = ctx_hop_num;
+	caps->mpt_hop_num = ctx_hop_num;
+	caps->mtt_hop_num = pbl_hop_num;
+	caps->cqe_hop_num = pbl_hop_num;
+	caps->srqwqe_hop_num = pbl_hop_num;
+	caps->idx_hop_num = pbl_hop_num;
+	caps->wqe_sq_hop_num = roce_get_field(resp_d->wq_hop_num_max_srqs,
+					  V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_M,
+					  V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_S);
+	caps->wqe_sge_hop_num = roce_get_field(resp_d->wq_hop_num_max_srqs,
+					  V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_M,
+					  V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_S);
+	caps->wqe_rq_hop_num = roce_get_field(resp_d->wq_hop_num_max_srqs,
+					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_M,
+					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_S);
+
+	calc_pg_sz(caps->num_qps, caps->qpc_entry_sz, caps->qpc_hop_num,
+		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
+		   HEM_TYPE_QPC);
+	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
+		   caps->mpt_bt_num, &caps->mpt_buf_pg_sz, &caps->mpt_ba_pg_sz,
+		   HEM_TYPE_MTPT);
+	calc_pg_sz(caps->num_cqs, caps->cqc_entry_sz, caps->cqc_hop_num,
+		   caps->cqc_bt_num, &caps->cqc_buf_pg_sz, &caps->cqc_ba_pg_sz,
+		   HEM_TYPE_CQC);
+	calc_pg_sz(caps->num_srqs, caps->srqc_entry_sz, caps->srqc_hop_num,
+		   caps->srqc_bt_num, &caps->srqc_buf_pg_sz,
+		   &caps->srqc_ba_pg_sz, HEM_TYPE_SRQC);
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
+		caps->sccc_hop_num = ctx_hop_num;
+		caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
+		caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
+
+		calc_pg_sz(caps->num_qps, caps->sccc_entry_sz,
+			   caps->sccc_hop_num, caps->sccc_bt_num,
+			   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
+			   HEM_TYPE_SCCC);
+		calc_pg_sz(caps->num_cqc_timer, caps->cqc_timer_entry_sz,
+			   caps->cqc_timer_hop_num, caps->cqc_timer_bt_num,
+			   &caps->cqc_timer_buf_pg_sz,
+			   &caps->cqc_timer_ba_pg_sz, HEM_TYPE_CQC_TIMER);
+	}
+
+	calc_pg_sz(caps->num_cqe_segs, caps->mtt_entry_sz, caps->cqe_hop_num,
+		   1, &caps->cqe_buf_pg_sz, &caps->cqe_ba_pg_sz, HEM_TYPE_CQE);
+	calc_pg_sz(caps->num_srqwqe_segs, caps->mtt_entry_sz,
+		   caps->srqwqe_hop_num, 1, &caps->srqwqe_buf_pg_sz,
+		   &caps->srqwqe_ba_pg_sz, HEM_TYPE_SRQWQE);
+	calc_pg_sz(caps->num_idx_segs, caps->idx_entry_sz, caps->idx_hop_num,
+		   1, &caps->idx_buf_pg_sz, &caps->idx_ba_pg_sz, HEM_TYPE_IDX);
+
+	return 0;
+}
+
 static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_caps *caps = &hr_dev->caps;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 76a14db..c56bd31 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -85,6 +85,7 @@
 #define HNS_ROCE_V2_SRQC_ENTRY_SZ		64
 #define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
+#define HNS_ROCE_V2_IDX_ENTRY_SZ		4
 #define HNS_ROCE_V2_CQE_ENTRY_SIZE		32
 #define HNS_ROCE_V2_SCCC_ENTRY_SZ		32
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
@@ -109,6 +110,9 @@
 #define HNS_ROCE_PBL_HOP_NUM			2
 #define HNS_ROCE_EQE_HOP_NUM			2
 #define HNS_ROCE_IDX_HOP_NUM			1
+#define HNS_ROCE_SQWQE_HOP_NUM			2
+#define HNS_ROCE_EXT_SGE_HOP_NUM		1
+#define HNS_ROCE_RQWQE_HOP_NUM			2
 
 #define HNS_ROCE_V2_GID_INDEX_NUM		256
 
@@ -237,6 +241,7 @@ enum hns_roce_opcode_type {
 	HNS_ROCE_OPC_CFG_EXT_LLM			= 0x8403,
 	HNS_ROCE_OPC_CFG_TMOUT_LLM			= 0x8404,
 	HNS_ROCE_OPC_QUERY_PF_TIMER_RES			= 0x8406,
+	HNS_ROCE_OPC_QUERY_PF_CAPS_NUM                  = 0x8408,
 	HNS_ROCE_OPC_CFG_SGID_TB			= 0x8500,
 	HNS_ROCE_OPC_CFG_SMAC_TB			= 0x8501,
 	HNS_ROCE_OPC_POST_MB				= 0x8504,
@@ -1569,6 +1574,155 @@ struct hns_roce_cfg_smac_tb {
 #define CFG_SMAC_TB_VF_SMAC_H_S 0
 #define CFG_SMAC_TB_VF_SMAC_H_M GENMASK(15, 0)
 
+#define HNS_ROCE_QUERY_PF_CAPS_CMD_NUM 5
+struct hns_roce_query_pf_caps_a {
+	u8 number_ports;
+	u8 local_ca_ack_delay;
+	__le16 max_sq_sg;
+	__le16 max_sq_inline;
+	__le16 max_rq_sg;
+	__le32 max_extend_sg;
+	__le16 num_qpc_timer;
+	__le16 num_cqc_timer;
+	__le16 max_srq_sges;
+	u8 num_aeq_vectors;
+	u8 num_other_vectors;
+	u8 max_sq_desc_sz;
+	u8 max_rq_desc_sz;
+	u8 max_srq_desc_sz;
+	u8 cq_entry_sz;
+};
+
+struct hns_roce_query_pf_caps_b {
+	u8 mtpt_entry_sz;
+	u8 irrl_entry_sz;
+	u8 trrl_entry_sz;
+	u8 cqc_entry_sz;
+	u8 srqc_entry_sz;
+	u8 idx_entry_sz;
+	u8 scc_ctx_entry_sz;
+	u8 max_mtu;
+	__le16 qpc_entry_sz;
+	__le16 qpc_timer_entry_sz;
+	__le16 cqc_timer_entry_sz;
+	u8 min_cqes;
+	u8 min_wqes;
+	__le32 page_size_cap;
+	u8 pkey_table_len;
+	u8 phy_num_uars;
+	u8 ctx_hop_num;
+	u8 pbl_hop_num;
+};
+
+struct hns_roce_query_pf_caps_c {
+	__le32 cap_flags_num_pds;
+	__le32 max_gid_num_cqs;
+	__le32 cq_depth;
+	__le32 num_mrws;
+	__le32 ord_num_qps;
+	__le16 sq_depth;
+	__le16 rq_depth;
+};
+
+#define V2_QUERY_PF_CAPS_C_NUM_PDS_S 0
+#define V2_QUERY_PF_CAPS_C_NUM_PDS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_C_CAP_FLAGS_S 20
+#define V2_QUERY_PF_CAPS_C_CAP_FLAGS_M GENMASK(31, 20)
+
+#define V2_QUERY_PF_CAPS_C_NUM_CQS_S 0
+#define V2_QUERY_PF_CAPS_C_NUM_CQS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_C_MAX_GID_S 20
+#define V2_QUERY_PF_CAPS_C_MAX_GID_M GENMASK(28, 20)
+
+#define V2_QUERY_PF_CAPS_C_CQ_DEPTH_S 0
+#define V2_QUERY_PF_CAPS_C_CQ_DEPTH_M GENMASK(22, 0)
+
+#define V2_QUERY_PF_CAPS_C_NUM_MRWS_S 0
+#define V2_QUERY_PF_CAPS_C_NUM_MRWS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_C_NUM_QPS_S 0
+#define V2_QUERY_PF_CAPS_C_NUM_QPS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_C_MAX_ORD_S 20
+#define V2_QUERY_PF_CAPS_C_MAX_ORD_M GENMASK(27, 20)
+
+struct hns_roce_query_pf_caps_d {
+	__le32 wq_hop_num_max_srqs;
+	__le16 srq_depth;
+	__le16 rsv;
+	__le32 num_ceqs_ceq_depth;
+	__le32 arm_st_aeq_depth;
+	__le32 num_uars_rsv_pds;
+	__le32 rsv_uars_rsv_qps;
+};
+#define V2_QUERY_PF_CAPS_D_NUM_SRQS_S 0
+#define V2_QUERY_PF_CAPS_D_NUM_SRQS_M GENMASK(20, 0)
+
+#define V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_S 20
+#define V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_M GENMASK(21, 20)
+
+#define V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_S 22
+#define V2_QUERY_PF_CAPS_D_EX_SGE_HOP_NUM_M GENMASK(23, 22)
+
+#define V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_S 24
+#define V2_QUERY_PF_CAPS_D_SQWQE_HOP_NUM_M GENMASK(25, 24)
+
+
+#define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_S 0
+#define V2_QUERY_PF_CAPS_D_CEQ_DEPTH_M GENMASK(21, 0)
+
+#define V2_QUERY_PF_CAPS_D_NUM_CEQS_S 22
+#define V2_QUERY_PF_CAPS_D_NUM_CEQS_M GENMASK(31, 22)
+
+#define V2_QUERY_PF_CAPS_D_AEQ_DEPTH_S 0
+#define V2_QUERY_PF_CAPS_D_AEQ_DEPTH_M GENMASK(21, 0)
+
+#define V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_S 22
+#define V2_QUERY_PF_CAPS_D_AEQ_ARM_ST_M GENMASK(23, 22)
+
+#define V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_S 24
+#define V2_QUERY_PF_CAPS_D_CEQ_ARM_ST_M GENMASK(25, 24)
+
+#define V2_QUERY_PF_CAPS_D_RSV_PDS_S 0
+#define V2_QUERY_PF_CAPS_D_RSV_PDS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_D_NUM_UARS_S 20
+#define V2_QUERY_PF_CAPS_D_NUM_UARS_M GENMASK(27, 20)
+
+#define V2_QUERY_PF_CAPS_D_RSV_QPS_S 0
+#define V2_QUERY_PF_CAPS_D_RSV_QPS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_D_RSV_UARS_S 20
+#define V2_QUERY_PF_CAPS_D_RSV_UARS_M GENMASK(27, 20)
+
+struct hns_roce_query_pf_caps_e {
+	__le32 chunk_size_shift_rsv_mrws;
+	__le32 rsv_cqs;
+	__le32 rsv_srqs;
+	__le32 rsv_lkey;
+	__le16 ceq_max_cnt;
+	__le16 ceq_period;
+	__le16 aeq_max_cnt;
+	__le16 aeq_period;
+};
+
+#define V2_QUERY_PF_CAPS_E_RSV_MRWS_S 0
+#define V2_QUERY_PF_CAPS_E_RSV_MRWS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_S 20
+#define V2_QUERY_PF_CAPS_E_CHUNK_SIZE_SHIFT_M GENMASK(31, 20)
+
+#define V2_QUERY_PF_CAPS_E_RSV_CQS_S 0
+#define V2_QUERY_PF_CAPS_E_RSV_CQS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_E_RSV_SRQS_S 0
+#define V2_QUERY_PF_CAPS_E_RSV_SRQS_M GENMASK(19, 0)
+
+#define V2_QUERY_PF_CAPS_E_RSV_LKEYS_S 0
+#define V2_QUERY_PF_CAPS_E_RSV_LKEYS_M GENMASK(19, 0)
+
 struct hns_roce_cmq_desc {
 	__le16 opcode;
 	__le16 flag;
-- 
2.8.1

