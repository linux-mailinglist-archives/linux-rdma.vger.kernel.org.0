Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4740538E6DE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhEXMsu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 08:48:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3650 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhEXMst (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 08:48:49 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpcMh0n2NzNygV;
        Mon, 24 May 2021 20:43:44 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:47:19 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 24 May 2021 20:47:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Refactor capability configuration flow of VF
Date:   Mon, 24 May 2021 20:47:08 +0800
Message-ID: <1621860428-58009-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

The capbability configurations of PFs and VFs are coupled. Decoupling them
by abstracting some functions and reorganizing the configuration process.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 300 +++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   2 +-
 2 files changed, 156 insertions(+), 146 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d5e72e5..c73e375 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1675,17 +1675,7 @@ static int load_func_res_caps(struct hns_roce_dev *hr_dev, bool is_vf)
 	return 0;
 }
 
-static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
-{
-	return load_func_res_caps(hr_dev, false);
-}
-
-static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
-{
-	return load_func_res_caps(hr_dev, true);
-}
-
-static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
+static int load_pf_timer_res_caps(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc;
 	struct hns_roce_cmq_req *req = (struct hns_roce_cmq_req *)desc.data;
@@ -1705,6 +1695,29 @@ static int hns_roce_query_pf_timer_resource(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
+static int hns_roce_query_pf_resource(struct hns_roce_dev *hr_dev)
+{
+	struct device *dev = hr_dev->dev;
+	int ret;
+
+	ret = load_func_res_caps(hr_dev, false);
+	if (ret) {
+		dev_err(dev, "failed to load func caps, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = load_pf_timer_res_caps(hr_dev);
+	if (ret)
+		dev_err(dev, "failed to load timer res, ret = %d.\n", ret);
+
+	return ret;
+}
+
+static int hns_roce_query_vf_resource(struct hns_roce_dev *hr_dev)
+{
+	return load_func_res_caps(hr_dev, true);
+}
+
 static int __hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 					  u32 vf_id)
 {
@@ -1744,7 +1757,7 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev)
 	return 0;
 }
 
-static int __hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev, int vf_id)
+static int config_vf_hem_resource(struct hns_roce_dev *hr_dev, int vf_id)
 {
 	struct hns_roce_cmq_desc desc[2];
 	struct hns_roce_cmq_req *r_a = (struct hns_roce_cmq_req *)desc[0].data;
@@ -1791,11 +1804,12 @@ static int __hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev, int vf_id)
 
 static int hns_roce_alloc_vf_resource(struct hns_roce_dev *hr_dev)
 {
-	int vf_id;
+	u32 func_num = max_t(u32, 1, hr_dev->func_num);
+	u32 vf_id;
 	int ret;
 
-	for (vf_id = 0; vf_id < hr_dev->func_num; vf_id++) {
-		ret = __hns_roce_alloc_vf_resource(hr_dev, vf_id);
+	for (vf_id = 0; vf_id < func_num; vf_id++) {
+		ret = config_vf_hem_resource(hr_dev, vf_id);
 		if (ret)
 			return ret;
 	}
@@ -1849,9 +1863,9 @@ static int hns_roce_v2_set_bt(struct hns_roce_dev *hr_dev)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
+/* Use default caps when hns_roce_query_pf_caps() failed or init VF profile */
 static void set_default_caps(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_caps *caps = &hr_dev->caps;
 
 	caps->num_qps		= HNS_ROCE_V2_MAX_QP_NUM;
@@ -1863,19 +1877,18 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
 	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
 	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
+
 	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
 	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
 	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
-	caps->num_comp_vectors	=
-			min_t(u32, caps->eqc_bt_num - 1,
-			      (u32)priv->handle->rinfo.num_vectors - 2);
 	caps->num_other_vectors = HNS_ROCE_V2_ABNORMAL_VEC_NUM;
+	caps->num_comp_vectors	= 0;
+
 	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
-	caps->num_mtt_segs	= HNS_ROCE_V2_MAX_MTT_SEGS;
-	caps->num_srqwqe_segs	= HNS_ROCE_V2_MAX_SRQWQE_SEGS;
-	caps->num_idx_segs	= HNS_ROCE_V2_MAX_IDX_SEGS;
 	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
-	caps->num_xrcds		= HNS_ROCE_V2_MAX_XRCD_NUM;
+	caps->num_qpc_timer	= HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
+	caps->num_cqc_timer	= HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
+
 	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
 	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
@@ -1886,12 +1899,10 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
 	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
 	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
-	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
 	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
 	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
 	caps->reserved_lkey	= 0;
 	caps->reserved_pds	= 0;
-	caps->reserved_xrcds	= HNS_ROCE_V2_RSV_XRCD_NUM;
 	caps->reserved_mrws	= 1;
 	caps->reserved_uars	= 0;
 	caps->reserved_cqs	= 0;
@@ -1902,15 +1913,15 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->srqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
 	caps->cqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
 	caps->mpt_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
+	caps->sccc_hop_num	= HNS_ROCE_SCCC_HOP_NUM;
+
 	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
-	caps->pbl_hop_num       = HNS_ROCE_PBL_HOP_NUM;
 	caps->wqe_sq_hop_num	= HNS_ROCE_SQWQE_HOP_NUM;
 	caps->wqe_sge_hop_num	= HNS_ROCE_EXT_SGE_HOP_NUM;
 	caps->wqe_rq_hop_num	= HNS_ROCE_RQWQE_HOP_NUM;
 	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
 	caps->srqwqe_hop_num	= HNS_ROCE_SRQWQE_HOP_NUM;
 	caps->idx_hop_num	= HNS_ROCE_IDX_HOP_NUM;
-	caps->eqe_hop_num       = HNS_ROCE_EQE_HOP_NUM;
 	caps->chunk_sz          = HNS_ROCE_V2_TABLE_CHUNK_SIZE;
 
 	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
@@ -1931,36 +1942,17 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
 		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL | HNS_ROCE_CAP_FLAG_XRC;
 
-	caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
-	caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
-	caps->qpc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
-	caps->num_cqc_timer	  = HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
-	caps->cqc_timer_entry_sz  = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
-	caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
-
-	caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
+	caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
-		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
-		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
-		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
-		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
-		caps->sccc_sz = HNS_ROCE_V3_SCCC_SZ;
-		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
-		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
-							  caps->gmv_entry_sz);
-		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
-					 caps->gmv_entry_sz);
-		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;
+		caps->max_sq_inline = HNS_ROCE_V3_MAX_SQ_INLINE;
 	} else {
-		caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
-		caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
-		caps->cqe_sz = HNS_ROCE_V2_CQE_SIZE;
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
+
+		/* The following configuration are only valid for HIP08 */
 		caps->qpc_sz = HNS_ROCE_V2_QPC_SZ;
 		caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
-		caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
-		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
+		caps->cqe_sz = HNS_ROCE_V2_CQE_SIZE;
 	}
 }
 
@@ -2070,6 +2062,71 @@ static void set_hem_page_size(struct hns_roce_dev *hr_dev)
 	caps->gmv_buf_pg_sz = 0;
 }
 
+/* Apply all loaded caps before setting to hardware */
+static void apply_func_caps(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_caps *caps = &hr_dev->caps;
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+
+	/* The following configurations don't need to be got from firmware. */
+	caps->qpc_timer_entry_sz = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
+	caps->cqc_timer_entry_sz = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
+	caps->mtt_entry_sz = HNS_ROCE_V2_MTT_ENTRY_SZ;
+
+	caps->eqe_hop_num = HNS_ROCE_EQE_HOP_NUM;
+	caps->pbl_hop_num = HNS_ROCE_PBL_HOP_NUM;
+	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
+	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
+
+	caps->num_xrcds = HNS_ROCE_V2_MAX_XRCD_NUM;
+	caps->reserved_xrcds = HNS_ROCE_V2_RSV_XRCD_NUM;
+
+	caps->num_mtt_segs = HNS_ROCE_V2_MAX_MTT_SEGS;
+	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
+	caps->num_idx_segs = HNS_ROCE_V2_MAX_IDX_SEGS;
+
+	if (!caps->num_comp_vectors)
+		caps->num_comp_vectors = min_t(u32, caps->eqc_bt_num - 1,
+				  (u32)priv->handle->rinfo.num_vectors - 2);
+
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
+		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
+
+		/* The following configurations will be overwritten */
+		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
+		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
+		caps->sccc_sz = HNS_ROCE_V3_SCCC_SZ;
+
+		/* The following configurations are not got from firmware */
+		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
+
+		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
+		caps->gid_table_len[0] = caps->gmv_bt_num *
+					(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
+
+		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+							  caps->gmv_entry_sz);
+	} else {
+		u32 func_num = max_t(u32, 1, hr_dev->func_num);
+
+		caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
+		caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
+		caps->gid_table_len[0] /= func_num;
+	}
+
+	if (hr_dev->is_vf) {
+		caps->default_aeq_arm_st = 0x3;
+		caps->default_ceq_arm_st = 0x3;
+		caps->default_ceq_max_cnt = 0x1;
+		caps->default_ceq_period = 0x10;
+		caps->default_aeq_max_cnt = 0x1;
+		caps->default_aeq_period = 0x10;
+	}
+
+	set_hem_page_size(hr_dev);
+}
+
 static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM];
@@ -2119,7 +2176,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
 	caps->max_rq_desc_sz	     = resp_a->max_rq_desc_sz;
 	caps->max_srq_desc_sz	     = resp_a->max_srq_desc_sz;
-	caps->cqe_sz		     = HNS_ROCE_V2_CQE_SIZE;
+	caps->cqe_sz		     = resp_a->cqe_sz;
 
 	caps->mtpt_entry_sz	     = resp_b->mtpt_entry_sz;
 	caps->irrl_entry_sz	     = resp_b->irrl_entry_sz;
@@ -2129,7 +2186,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->idx_entry_sz	     = resp_b->idx_entry_sz;
 	caps->sccc_sz		     = resp_b->sccc_sz;
 	caps->max_mtu		     = resp_b->max_mtu;
-	caps->qpc_sz		     = HNS_ROCE_V2_QPC_SZ;
+	caps->qpc_sz		     = le16_to_cpu(resp_b->qpc_sz);
 	caps->min_cqes		     = resp_b->min_cqes;
 	caps->min_wqes		     = resp_b->min_wqes;
 	caps->page_size_cap	     = le32_to_cpu(resp_b->page_size_cap);
@@ -2154,8 +2211,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 						V2_QUERY_PF_CAPS_C_MAX_GID_M,
 						V2_QUERY_PF_CAPS_C_MAX_GID_S);
 
-	caps->gid_table_len[0] /= hr_dev->func_num;
-
 	caps->max_cqes = 1 << roce_get_field(resp_c->cq_depth,
 					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_M,
 					     V2_QUERY_PF_CAPS_C_CQ_DEPTH_S);
@@ -2226,18 +2281,8 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->default_aeq_max_cnt = le16_to_cpu(resp_e->aeq_max_cnt);
 	caps->default_aeq_period = le16_to_cpu(resp_e->aeq_period);
 
-	caps->qpc_timer_entry_sz = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
-	caps->cqc_timer_entry_sz = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
-	caps->mtt_entry_sz = HNS_ROCE_V2_MTT_ENTRY_SZ;
-	caps->num_mtt_segs = HNS_ROCE_V2_MAX_MTT_SEGS;
-	caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
-	caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
-	caps->num_xrcds = HNS_ROCE_V2_MAX_XRCD_NUM;
-	caps->reserved_xrcds = HNS_ROCE_V2_RSV_XRCD_NUM;
-	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
-	caps->num_idx_segs = HNS_ROCE_V2_MAX_IDX_SEGS;
-
 	caps->qpc_hop_num = ctx_hop_num;
+	caps->sccc_hop_num = ctx_hop_num;
 	caps->srqc_hop_num = ctx_hop_num;
 	caps->cqc_hop_num = ctx_hop_num;
 	caps->mpt_hop_num = ctx_hop_num;
@@ -2255,23 +2300,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_M,
 					  V2_QUERY_PF_CAPS_D_RQWQE_HOP_NUM_S);
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
-		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
-		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
-		caps->cqe_sz = HNS_ROCE_V3_CQE_SIZE;
-		caps->qpc_sz = HNS_ROCE_V3_QPC_SZ;
-		caps->sccc_sz = HNS_ROCE_V3_SCCC_SZ;
-		caps->gmv_entry_sz = HNS_ROCE_V3_GMV_ENTRY_SZ;
-		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
-						    caps->gmv_entry_sz);
-		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->gid_table_len[0] = caps->gmv_bt_num *
-				(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
-	}
-
-	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
-	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
-
 	return 0;
 }
 
@@ -2314,121 +2342,103 @@ static int hns_roce_config_entry_size(struct hns_roce_dev *hr_dev)
 
 static int hns_roce_v2_vf_profile(struct hns_roce_dev *hr_dev)
 {
+	struct device *dev = hr_dev->dev;
 	int ret;
 
-	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
-	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 	hr_dev->func_num = 1;
 
+	set_default_caps(hr_dev);
+
 	ret = hns_roce_query_vf_resource(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev,
-			"Query the VF resource fail, ret = %d.\n", ret);
+		dev_err(dev, "failed to query VF resource, ret = %d.\n", ret);
 		return ret;
 	}
 
-	set_default_caps(hr_dev);
-	set_hem_page_size(hr_dev);
+	apply_func_caps(hr_dev);
 
 	ret = hns_roce_v2_set_bt(hr_dev);
-	if (ret) {
-		dev_err(hr_dev->dev,
-			"Configure the VF bt attribute fail, ret = %d.\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		dev_err(dev, "failed to config VF BA table, ret = %d.\n", ret);
 
-	return 0;
+	return ret;
 }
 
-static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
+static int hns_roce_v2_pf_profile(struct hns_roce_dev *hr_dev)
 {
-	struct hns_roce_caps *caps = &hr_dev->caps;
+	struct device *dev = hr_dev->dev;
 	int ret;
 
-	ret = hns_roce_cmq_query_hw_info(hr_dev);
+	ret = hns_roce_query_func_info(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev, "Query hardware version fail, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to query func info, ret = %d.\n", ret);
 		return ret;
 	}
 
-	ret = hns_roce_query_fw_ver(hr_dev);
+	ret = hns_roce_config_global_param(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev, "Query firmware version fail, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to config global param, ret = %d.\n", ret);
 		return ret;
 	}
 
-	if (hr_dev->is_vf)
-		return hns_roce_v2_vf_profile(hr_dev);
-
-	ret = hns_roce_query_func_info(hr_dev);
+	ret = hns_roce_set_vf_switch_param(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev, "Query function info fail, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to set switch param, ret = %d.\n", ret);
 		return ret;
 	}
 
-	ret = hns_roce_config_global_param(hr_dev);
-	if (ret) {
-		dev_err(hr_dev->dev, "Configure global param fail, ret = %d.\n",
-			ret);
-		return ret;
-	}
+	ret = hns_roce_query_pf_caps(hr_dev);
+	if (ret)
+		set_default_caps(hr_dev);
 
-	/* Get pf resource owned by every pf */
 	ret = hns_roce_query_pf_resource(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev, "Query pf resource fail, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to query pf resource, ret = %d.\n", ret);
 		return ret;
 	}
 
-	ret = hns_roce_query_pf_timer_resource(hr_dev);
+	apply_func_caps(hr_dev);
+
+	ret = hns_roce_alloc_vf_resource(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev,
-			"failed to query pf timer resource, ret = %d.\n", ret);
+		dev_err(dev, "failed to alloc vf resource, ret = %d.\n", ret);
 		return ret;
 	}
 
-	ret = hns_roce_set_vf_switch_param(hr_dev);
+	ret = hns_roce_v2_set_bt(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev,
-			"failed to set function switch param, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to config BA table, ret = %d.\n", ret);
 		return ret;
 	}
 
-	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
-	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
-
-	caps->pbl_hop_num	= HNS_ROCE_PBL_HOP_NUM;
-	caps->eqe_hop_num	= HNS_ROCE_EQE_HOP_NUM;
+	/* Configure the size of QPC, SCCC, etc. */
+	return hns_roce_config_entry_size(hr_dev);
+}
 
-	ret = hns_roce_query_pf_caps(hr_dev);
-	if (ret)
-		set_default_caps(hr_dev);
+static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
+{
+	struct device *dev = hr_dev->dev;
+	int ret;
 
-	ret = hns_roce_alloc_vf_resource(hr_dev);
+	ret = hns_roce_cmq_query_hw_info(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
-			ret);
+		dev_err(dev, "failed to query hardware info, ret = %d.\n", ret);
 		return ret;
 	}
 
-	set_hem_page_size(hr_dev);
-	ret = hns_roce_v2_set_bt(hr_dev);
+	ret = hns_roce_query_fw_ver(hr_dev);
 	if (ret) {
-		dev_err(hr_dev->dev,
-			"Configure bt attribute fail, ret = %d.\n", ret);
+		dev_err(dev, "failed to query firmware info, ret = %d.\n", ret);
 		return ret;
 	}
 
-	/* Configure the size of QPC, SCCC, etc. */
-	ret = hns_roce_config_entry_size(hr_dev);
+	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
+	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 
-	return ret;
+	if (hr_dev->is_vf)
+		return hns_roce_v2_vf_profile(hr_dev);
+	else
+		return hns_roce_v2_pf_profile(hr_dev);
 }
 
 static void config_llm_table(struct hns_roce_buf *data_buf, void *cfg_buf)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index e374309..cd361c0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -59,7 +59,7 @@
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
-#define HNS_ROCE_V2_MAX_SQ_INL_EXT		0x400
+#define HNS_ROCE_V3_MAX_SQ_INLINE		0x400
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_UAR_NUM			256
 #define HNS_ROCE_V2_PHY_UAR_NUM			1
-- 
2.7.4

