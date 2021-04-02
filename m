Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739C53527BA
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhDBJBA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:01:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16331 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhDBJA7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:00:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FBYr84yjQz9vsN;
        Fri,  2 Apr 2021 16:58:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:00:48 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 6/6] RDMA/hns: Remove duplicated hem page size config code
Date:   Fri, 2 Apr 2021 16:58:16 +0800
Message-ID: <1617353896-40727-7-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
References: <1617353896-40727-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Remove duplicated code for setting hem page size in PF and VF.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 184 ++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   1 +
 3 files changed, 76 insertions(+), 110 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e631914..7309369 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -772,7 +772,6 @@ struct hns_roce_caps {
 	int		num_other_vectors;
 	u32		num_mtpts;
 	u32		num_mtt_segs;
-	u32		num_cqe_segs;
 	u32		num_srqwqe_segs;
 	u32		num_idx_segs;
 	int		reserved_mrws;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0c6bc84..8e6f9d2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -54,9 +54,6 @@ enum {
 	CMD_RST_PRC_EBUSY,
 };
 
-static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
-		       u32 *buf_page_size, u32 *bt_page_size, u32 hem_type);
-
 static inline void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
 				   struct ib_sge *sg)
 {
@@ -1907,7 +1904,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
 	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
 	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
-	caps->max_sq_inline	= HNS_ROCE_V2_MAX_SQ_INLINE;
 	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
 	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
 	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
@@ -1917,7 +1913,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->num_other_vectors = HNS_ROCE_V2_ABNORMAL_VEC_NUM;
 	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
 	caps->num_mtt_segs	= HNS_ROCE_V2_MAX_MTT_SEGS;
-	caps->num_cqe_segs	= HNS_ROCE_V2_MAX_CQE_SEGS;
 	caps->num_srqwqe_segs	= HNS_ROCE_V2_MAX_SRQWQE_SEGS;
 	caps->num_idx_segs	= HNS_ROCE_V2_MAX_IDX_SEGS;
 	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
@@ -1927,7 +1922,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
 	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
 	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
-	caps->qpc_sz		= HNS_ROCE_V2_QPC_SZ;
 	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
 	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
 	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
@@ -1935,7 +1929,6 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
 	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
 	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
-	caps->cqe_sz		= HNS_ROCE_V2_CQE_SIZE;
 	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
 	caps->reserved_lkey	= 0;
 	caps->reserved_pds	= 0;
@@ -1946,40 +1939,19 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->reserved_srqs	= 0;
 	caps->reserved_qps	= HNS_ROCE_V2_RSV_QPS;
 
-	caps->qpc_ba_pg_sz	= 0;
-	caps->qpc_buf_pg_sz	= 0;
 	caps->qpc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->srqc_ba_pg_sz	= 0;
-	caps->srqc_buf_pg_sz	= 0;
 	caps->srqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->cqc_ba_pg_sz	= 0;
-	caps->cqc_buf_pg_sz	= 0;
 	caps->cqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->mpt_ba_pg_sz	= 0;
-	caps->mpt_buf_pg_sz	= 0;
 	caps->mpt_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->mtt_ba_pg_sz	= 0;
-	caps->mtt_buf_pg_sz	= 0;
 	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
-	caps->pbl_ba_pg_sz      = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
-	caps->pbl_buf_pg_sz     = 0;
 	caps->pbl_hop_num       = HNS_ROCE_PBL_HOP_NUM;
 	caps->wqe_sq_hop_num	= HNS_ROCE_SQWQE_HOP_NUM;
 	caps->wqe_sge_hop_num	= HNS_ROCE_EXT_SGE_HOP_NUM;
 	caps->wqe_rq_hop_num	= HNS_ROCE_RQWQE_HOP_NUM;
-	caps->cqe_ba_pg_sz	= HNS_ROCE_BA_PG_SZ_SUPPORTED_256K;
-	caps->cqe_buf_pg_sz	= 0;
 	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
-	caps->srqwqe_ba_pg_sz	= 0;
-	caps->srqwqe_buf_pg_sz	= 0;
 	caps->srqwqe_hop_num	= HNS_ROCE_SRQWQE_HOP_NUM;
-	caps->idx_ba_pg_sz	= 0;
-	caps->idx_buf_pg_sz	= 0;
 	caps->idx_hop_num	= HNS_ROCE_IDX_HOP_NUM;
-	caps->eqe_ba_pg_sz      = 0;
-	caps->eqe_buf_pg_sz     = 0;
 	caps->eqe_hop_num       = HNS_ROCE_EQE_HOP_NUM;
-	caps->tsq_buf_pg_sz     = 0;
 	caps->chunk_sz          = HNS_ROCE_V2_TABLE_CHUNK_SIZE;
 
 	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
@@ -1988,11 +1960,8 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 				  HNS_ROCE_CAP_FLAG_QP_RECORD_DB;
 
 	caps->pkey_table_len[0] = 1;
-	caps->gid_table_len[0]	= HNS_ROCE_V2_GID_INDEX_NUM;
 	caps->ceqe_depth	= HNS_ROCE_V2_COMP_EQE_NUM;
 	caps->aeqe_depth	= HNS_ROCE_V2_ASYNC_EQE_NUM;
-	caps->aeqe_size		= HNS_ROCE_AEQE_SIZE;
-	caps->ceqe_size		= HNS_ROCE_CEQE_SIZE;
 	caps->local_ca_ack_delay = 0;
 	caps->max_mtu = IB_MTU_4096;
 
@@ -2005,18 +1974,11 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 
 	caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
 	caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
-	caps->qpc_timer_ba_pg_sz  = 0;
-	caps->qpc_timer_buf_pg_sz = 0;
 	caps->qpc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
 	caps->num_cqc_timer	  = HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
 	caps->cqc_timer_entry_sz  = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
-	caps->cqc_timer_ba_pg_sz  = 0;
-	caps->cqc_timer_buf_pg_sz = 0;
 	caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
 
-	caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
-	caps->sccc_ba_pg_sz	  = 0;
-	caps->sccc_buf_pg_sz	  = 0;
 	caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
@@ -2029,39 +1991,17 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
 							  caps->gmv_entry_sz);
 		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->gmv_ba_pg_sz = 0;
-		caps->gmv_buf_pg_sz = 0;
 		caps->gid_table_len[0] = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 					 caps->gmv_entry_sz);
-	}
-
-	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
-		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
-		   HEM_TYPE_QPC);
-	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
-		   caps->mpt_bt_num, &caps->mpt_buf_pg_sz, &caps->mpt_ba_pg_sz,
-		   HEM_TYPE_MTPT);
-	calc_pg_sz(caps->num_cqs, caps->cqc_entry_sz, caps->cqc_hop_num,
-		   caps->cqc_bt_num, &caps->cqc_buf_pg_sz, &caps->cqc_ba_pg_sz,
-		   HEM_TYPE_CQC);
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL)
-		calc_pg_sz(caps->num_qps, caps->sccc_sz,
-			   caps->sccc_hop_num, caps->sccc_bt_num,
-			   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
-			   HEM_TYPE_SCCC);
-
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
-		calc_pg_sz(caps->num_srqs, caps->srqc_entry_sz,
-			   caps->srqc_hop_num, caps->srqc_bt_num,
-			   &caps->srqc_buf_pg_sz, &caps->srqc_ba_pg_sz,
-			   HEM_TYPE_SRQC);
-		calc_pg_sz(caps->num_srqwqe_segs, caps->mtt_entry_sz,
-			   caps->srqwqe_hop_num, 1, &caps->srqwqe_buf_pg_sz,
-			   &caps->srqwqe_ba_pg_sz, HEM_TYPE_SRQWQE);
-		calc_pg_sz(caps->num_idx_segs, caps->idx_entry_sz,
-			   caps->idx_hop_num, 1, &caps->idx_buf_pg_sz,
-			   &caps->idx_ba_pg_sz, HEM_TYPE_IDX);
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INL_EXT;
+	} else {
+		caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
+		caps->ceqe_size = HNS_ROCE_CEQE_SIZE;
+		caps->cqe_sz = HNS_ROCE_V2_CQE_SIZE;
+		caps->qpc_sz = HNS_ROCE_V2_QPC_SZ;
+		caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
+		caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
+		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
 	}
 }
 
@@ -2107,6 +2047,70 @@ static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
 		*buf_page_size = ilog2(DIV_ROUND_UP(obj_num, obj_per_chunk));
 }
 
+static void set_hem_page_size(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_caps *caps = &hr_dev->caps;
+
+	/* EQ */
+	caps->eqe_ba_pg_sz = 0;
+	caps->eqe_buf_pg_sz = 0;
+
+	/* Link Table */
+	caps->tsq_buf_pg_sz = 0;
+
+	/* MR */
+	caps->pbl_ba_pg_sz = HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
+	caps->pbl_buf_pg_sz = 0;
+	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
+		   caps->mpt_bt_num, &caps->mpt_buf_pg_sz, &caps->mpt_ba_pg_sz,
+		   HEM_TYPE_MTPT);
+
+	/* QP */
+	caps->qpc_timer_ba_pg_sz  = 0;
+	caps->qpc_timer_buf_pg_sz = 0;
+	caps->mtt_ba_pg_sz = 0;
+	caps->mtt_buf_pg_sz = 0;
+	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
+		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
+		   HEM_TYPE_QPC);
+
+	if (caps->flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL)
+		calc_pg_sz(caps->num_qps, caps->sccc_sz, caps->sccc_hop_num,
+			   caps->sccc_bt_num, &caps->sccc_buf_pg_sz,
+			   &caps->sccc_ba_pg_sz, HEM_TYPE_SCCC);
+
+	/* CQ */
+	calc_pg_sz(caps->num_cqs, caps->cqc_entry_sz, caps->cqc_hop_num,
+		   caps->cqc_bt_num, &caps->cqc_buf_pg_sz, &caps->cqc_ba_pg_sz,
+		   HEM_TYPE_CQC);
+	calc_pg_sz(caps->max_cqes, caps->cqe_sz, caps->cqe_hop_num,
+		   1, &caps->cqe_buf_pg_sz, &caps->cqe_ba_pg_sz, HEM_TYPE_CQE);
+
+	if (caps->cqc_timer_entry_sz)
+		calc_pg_sz(caps->num_cqc_timer, caps->cqc_timer_entry_sz,
+			   caps->cqc_timer_hop_num, caps->cqc_timer_bt_num,
+			   &caps->cqc_timer_buf_pg_sz,
+			   &caps->cqc_timer_ba_pg_sz, HEM_TYPE_CQC_TIMER);
+
+	/* SRQ */
+	if (caps->flags & HNS_ROCE_CAP_FLAG_SRQ) {
+		calc_pg_sz(caps->num_srqs, caps->srqc_entry_sz,
+			   caps->srqc_hop_num, caps->srqc_bt_num,
+			   &caps->srqc_buf_pg_sz, &caps->srqc_ba_pg_sz,
+			   HEM_TYPE_SRQC);
+		calc_pg_sz(caps->num_srqwqe_segs, caps->mtt_entry_sz,
+			   caps->srqwqe_hop_num, 1, &caps->srqwqe_buf_pg_sz,
+			   &caps->srqwqe_ba_pg_sz, HEM_TYPE_SRQWQE);
+		calc_pg_sz(caps->num_idx_segs, caps->idx_entry_sz,
+			   caps->idx_hop_num, 1, &caps->idx_buf_pg_sz,
+			   &caps->idx_ba_pg_sz, HEM_TYPE_IDX);
+	}
+
+	/* GMV */
+	caps->gmv_ba_pg_sz = 0;
+	caps->gmv_buf_pg_sz = 0;
+}
+
 static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_cmq_desc desc[HNS_ROCE_QUERY_PF_CAPS_CMD_NUM];
@@ -2271,8 +2275,6 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->aeqe_size = HNS_ROCE_AEQE_SIZE;
 	caps->num_xrcds = HNS_ROCE_V2_MAX_XRCD_NUM;
 	caps->reserved_xrcds = HNS_ROCE_V2_RSV_XRCD_NUM;
-	caps->mtt_ba_pg_sz = 0;
-	caps->num_cqe_segs = HNS_ROCE_V2_MAX_CQE_SEGS;
 	caps->num_srqwqe_segs = HNS_ROCE_V2_MAX_SRQWQE_SEGS;
 	caps->num_idx_segs = HNS_ROCE_V2_MAX_IDX_SEGS;
 
@@ -2304,46 +2306,13 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
 						    caps->gmv_entry_sz);
 		caps->gmv_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->gmv_ba_pg_sz = 0;
-		caps->gmv_buf_pg_sz = 0;
 		caps->gid_table_len[0] = caps->gmv_bt_num *
 				(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
 	}
 
-	calc_pg_sz(caps->num_qps, caps->qpc_sz, caps->qpc_hop_num,
-		   caps->qpc_bt_num, &caps->qpc_buf_pg_sz, &caps->qpc_ba_pg_sz,
-		   HEM_TYPE_QPC);
-	calc_pg_sz(caps->num_mtpts, caps->mtpt_entry_sz, caps->mpt_hop_num,
-		   caps->mpt_bt_num, &caps->mpt_buf_pg_sz, &caps->mpt_ba_pg_sz,
-		   HEM_TYPE_MTPT);
-	calc_pg_sz(caps->num_cqs, caps->cqc_entry_sz, caps->cqc_hop_num,
-		   caps->cqc_bt_num, &caps->cqc_buf_pg_sz, &caps->cqc_ba_pg_sz,
-		   HEM_TYPE_CQC);
-	calc_pg_sz(caps->num_srqs, caps->srqc_entry_sz, caps->srqc_hop_num,
-		   caps->srqc_bt_num, &caps->srqc_buf_pg_sz,
-		   &caps->srqc_ba_pg_sz, HEM_TYPE_SRQC);
-
-	caps->sccc_hop_num = ctx_hop_num;
 	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 
-	calc_pg_sz(caps->num_qps, caps->sccc_sz,
-		   caps->sccc_hop_num, caps->sccc_bt_num,
-		   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
-		   HEM_TYPE_SCCC);
-	calc_pg_sz(caps->num_cqc_timer, caps->cqc_timer_entry_sz,
-		   caps->cqc_timer_hop_num, caps->cqc_timer_bt_num,
-		   &caps->cqc_timer_buf_pg_sz,
-		   &caps->cqc_timer_ba_pg_sz, HEM_TYPE_CQC_TIMER);
-
-	calc_pg_sz(caps->num_cqe_segs, caps->mtt_entry_sz, caps->cqe_hop_num,
-		   1, &caps->cqe_buf_pg_sz, &caps->cqe_ba_pg_sz, HEM_TYPE_CQE);
-	calc_pg_sz(caps->num_srqwqe_segs, caps->mtt_entry_sz,
-		   caps->srqwqe_hop_num, 1, &caps->srqwqe_buf_pg_sz,
-		   &caps->srqwqe_ba_pg_sz, HEM_TYPE_SRQWQE);
-	calc_pg_sz(caps->num_idx_segs, caps->idx_entry_sz, caps->idx_hop_num,
-		   1, &caps->idx_buf_pg_sz, &caps->idx_ba_pg_sz, HEM_TYPE_IDX);
-
 	return 0;
 }
 
@@ -2400,6 +2369,7 @@ static int hns_roce_v2_vf_profile(struct hns_roce_dev *hr_dev)
 	}
 
 	set_default_caps(hr_dev);
+	set_hem_page_size(hr_dev);
 
 	ret = hns_roce_v2_set_bt(hr_dev);
 	if (ret) {
@@ -2474,13 +2444,8 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
 	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 
-	caps->pbl_ba_pg_sz	= HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
-	caps->pbl_buf_pg_sz	= 0;
 	caps->pbl_hop_num	= HNS_ROCE_PBL_HOP_NUM;
-	caps->eqe_ba_pg_sz	= 0;
-	caps->eqe_buf_pg_sz	= 0;
 	caps->eqe_hop_num	= HNS_ROCE_EQE_HOP_NUM;
-	caps->tsq_buf_pg_sz	= 0;
 
 	ret = hns_roce_query_pf_caps(hr_dev);
 	if (ret)
@@ -2493,6 +2458,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
+	set_hem_page_size(hr_dev);
 	ret = hns_roce_v2_set_bt(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 7a25ffd..b8d0969 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -59,6 +59,7 @@
 #define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
 #define HNS_ROCE_V2_MAX_EXTEND_SGE_NUM		0x200000
 #define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
+#define HNS_ROCE_V2_MAX_SQ_INL_EXT		0x400
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
 #define HNS_ROCE_V2_UAR_NUM			256
 #define HNS_ROCE_V2_PHY_UAR_NUM			1
-- 
2.8.1

