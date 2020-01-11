Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFAF1380DE
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2020 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgAKKgf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jan 2020 05:36:35 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729511AbgAKKgf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jan 2020 05:36:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4994D78A8581ECE5D130;
        Sat, 11 Jan 2020 18:36:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 18:36:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Get pf capabilities from firmware
Date:   Sat, 11 Jan 2020 18:32:41 +0800
Message-ID: <1578738761-3176-4-git-send-email-liweihang@huawei.com>
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

Get pf capabilities from firmware according to different hardwares, if it
fails, all capabilities will be set with a default value.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 113 +----------------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   2 +
 2 files changed, 6 insertions(+), 109 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b0c799d..a523bfd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2029,127 +2029,22 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
 	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 
-	caps->num_qps		= HNS_ROCE_V2_MAX_QP_NUM;
-	caps->max_wqes		= HNS_ROCE_V2_MAX_WQE_NUM;
-	caps->num_cqs		= HNS_ROCE_V2_MAX_CQ_NUM;
-	caps->num_srqs		= HNS_ROCE_V2_MAX_SRQ_NUM;
-	caps->min_cqes		= HNS_ROCE_MIN_CQE_NUM;
-	caps->max_cqes		= HNS_ROCE_V2_MAX_CQE_NUM;
-	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
-	caps->max_extend_sg	= HNS_ROCE_V2_MAX_EXTEND_SGE_NUM;
-	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
-	caps->max_sq_inline	= HNS_ROCE_V2_MAX_SQ_INLINE;
-	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
-	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
-	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
-	caps->num_comp_vectors	= HNS_ROCE_V2_COMP_VEC_NUM;
-	caps->num_other_vectors	= HNS_ROCE_V2_ABNORMAL_VEC_NUM;
-	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
 	caps->num_mtt_segs	= HNS_ROCE_V2_MAX_MTT_SEGS;
 	caps->num_cqe_segs	= HNS_ROCE_V2_MAX_CQE_SEGS;
 	caps->num_srqwqe_segs	= HNS_ROCE_V2_MAX_SRQWQE_SEGS;
 	caps->num_idx_segs	= HNS_ROCE_V2_MAX_IDX_SEGS;
-	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
-	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
-	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
-	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
-	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
-	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
-	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
-	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
-	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
-	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
-	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
-	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
-	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
-	caps->idx_entry_sz	= 4;
-	caps->cq_entry_sz	= HNS_ROCE_V2_CQE_ENTRY_SIZE;
-	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
-	caps->reserved_lkey	= 0;
-	caps->reserved_pds	= 0;
-	caps->reserved_mrws	= 1;
-	caps->reserved_uars	= 0;
-	caps->reserved_cqs	= 0;
-	caps->reserved_srqs	= 0;
-	caps->reserved_qps	= HNS_ROCE_V2_RSV_QPS;
 
-	caps->qpc_ba_pg_sz	= 0;
-	caps->qpc_buf_pg_sz	= 0;
-	caps->qpc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->srqc_ba_pg_sz	= 0;
-	caps->srqc_buf_pg_sz	= 0;
-	caps->srqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->cqc_ba_pg_sz	= 0;
-	caps->cqc_buf_pg_sz	= 0;
-	caps->cqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->mpt_ba_pg_sz	= 0;
-	caps->mpt_buf_pg_sz	= 0;
-	caps->mpt_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->pbl_ba_pg_sz	= 2;
+	caps->pbl_ba_pg_sz	= HNS_ROCE_BA_PG_SZ_SUPPORTED_16K;
 	caps->pbl_buf_pg_sz	= 0;
 	caps->pbl_hop_num	= HNS_ROCE_PBL_HOP_NUM;
-	caps->mtt_ba_pg_sz	= 0;
-	caps->mtt_buf_pg_sz	= 0;
-	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
-	caps->wqe_sq_hop_num	= 2;
-	caps->wqe_sge_hop_num	= 1;
-	caps->wqe_rq_hop_num	= 2;
-	caps->cqe_ba_pg_sz	= 6;
-	caps->cqe_buf_pg_sz	= 0;
-	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
-	caps->srqwqe_ba_pg_sz	= 0;
-	caps->srqwqe_buf_pg_sz	= 0;
-	caps->srqwqe_hop_num	= HNS_ROCE_SRQWQE_HOP_NUM;
-	caps->idx_ba_pg_sz	= 0;
-	caps->idx_buf_pg_sz	= 0;
-	caps->idx_hop_num	= HNS_ROCE_IDX_HOP_NUM;
 	caps->eqe_ba_pg_sz	= 0;
 	caps->eqe_buf_pg_sz	= 0;
 	caps->eqe_hop_num	= HNS_ROCE_EQE_HOP_NUM;
 	caps->tsq_buf_pg_sz	= 0;
-	caps->chunk_sz		= HNS_ROCE_V2_TABLE_CHUNK_SIZE;
-
-	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
-				  HNS_ROCE_CAP_FLAG_ROCE_V1_V2 |
-				  HNS_ROCE_CAP_FLAG_RQ_INLINE |
-				  HNS_ROCE_CAP_FLAG_RECORD_DB |
-				  HNS_ROCE_CAP_FLAG_SQ_RECORD_DB;
-
-	if (hr_dev->pci_dev->revision == 0x21)
-		caps->flags |= HNS_ROCE_CAP_FLAG_MW |
-			       HNS_ROCE_CAP_FLAG_FRMR;
 
-	caps->pkey_table_len[0] = 1;
-	caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
-	caps->ceqe_depth	= HNS_ROCE_V2_COMP_EQE_NUM;
-	caps->aeqe_depth	= HNS_ROCE_V2_ASYNC_EQE_NUM;
-	caps->local_ca_ack_delay = 0;
-	caps->max_mtu = IB_MTU_4096;
-
-	caps->max_srq_wrs	= HNS_ROCE_V2_MAX_SRQ_WR;
-	caps->max_srq_sges	= HNS_ROCE_V2_MAX_SRQ_SGE;
-
-	if (hr_dev->pci_dev->revision == 0x21) {
-		caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC |
-			       HNS_ROCE_CAP_FLAG_SRQ |
-			       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
-
-		caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
-		caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
-		caps->qpc_timer_ba_pg_sz  = 0;
-		caps->qpc_timer_buf_pg_sz = 0;
-		caps->qpc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
-		caps->num_cqc_timer	  = HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
-		caps->cqc_timer_entry_sz  = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
-		caps->cqc_timer_ba_pg_sz  = 0;
-		caps->cqc_timer_buf_pg_sz = 0;
-		caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
-
-		caps->sccc_entry_sz	= HNS_ROCE_V2_SCCC_ENTRY_SZ;
-		caps->sccc_ba_pg_sz	= 0;
-		caps->sccc_buf_pg_sz    = 0;
-		caps->sccc_hop_num	= HNS_ROCE_SCCC_HOP_NUM;
-	}
+	ret = hns_roce_query_pf_caps(hr_dev);
+	if (ret)
+		set_default_caps(hr_dev);
 
 	ret = hns_roce_v2_set_bt(hr_dev);
 	if (ret)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index c56bd31..539cea2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -114,6 +114,8 @@
 #define HNS_ROCE_EXT_SGE_HOP_NUM		1
 #define HNS_ROCE_RQWQE_HOP_NUM			2
 
+#define HNS_ROCE_BA_PG_SZ_SUPPORTED_256K	6
+#define HNS_ROCE_BA_PG_SZ_SUPPORTED_16K		2
 #define HNS_ROCE_V2_GID_INDEX_NUM		256
 
 #define HNS_ROCE_V2_TABLE_CHUNK_SIZE		(1 << 18)
-- 
2.8.1

