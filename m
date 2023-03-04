Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99FF6AA8E0
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 10:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCDJRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 04:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCDJR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 04:17:29 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A014484
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 01:17:27 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PTK0y1yt5znWWR;
        Sat,  4 Mar 2023 17:14:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 17:17:25 +0800
From:   Haoyue Xu <xuhaoyue1@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuhaoyue1@hisilicon.com>
Subject: [PATCH 2/2] RDMA/hns: Remove set_default function
Date:   Sat, 4 Mar 2023 17:15:55 +0800
Message-ID: <20230304091555.2241298-3-xuhaoyue1@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
References: <20230304091555.2241298-1-xuhaoyue1@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

The current driver's query about caps is completed
through command during the driver initialization phase.
If the command fails, it means that the current
hardware is untrustworthy, and there is no need for
the driver to use the default value.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 94 ----------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 30 +------
 2 files changed, 1 insertion(+), 123 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 9aa83010575e..84f1167de1d9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1960,100 +1960,6 @@ static int hns_roce_v2_set_bt(struct hns_roce_dev *hr_dev)
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
 
-/* Use default caps when hns_roce_query_pf_caps() failed or init VF profile */
-static void set_default_caps(struct hns_roce_dev *hr_dev)
-{
-	struct hns_roce_caps *caps = &hr_dev->caps;
-
-	caps->num_qps		= HNS_ROCE_V2_MAX_QP_NUM;
-	caps->max_wqes		= HNS_ROCE_V2_MAX_WQE_NUM;
-	caps->num_cqs		= HNS_ROCE_V2_MAX_CQ_NUM;
-	caps->num_srqs		= HNS_ROCE_V2_MAX_SRQ_NUM;
-	caps->min_cqes		= HNS_ROCE_MIN_CQE_NUM;
-	caps->max_cqes		= HNS_ROCE_V2_MAX_CQE_NUM;
-	caps->max_sq_sg		= HNS_ROCE_V2_MAX_SQ_SGE_NUM;
-	caps->max_rq_sg		= HNS_ROCE_V2_MAX_RQ_SGE_NUM;
-
-	caps->num_uars		= HNS_ROCE_V2_UAR_NUM;
-	caps->phy_num_uars	= HNS_ROCE_V2_PHY_UAR_NUM;
-	caps->num_aeq_vectors	= HNS_ROCE_V2_AEQE_VEC_NUM;
-	caps->num_other_vectors = HNS_ROCE_V2_ABNORMAL_VEC_NUM;
-	caps->num_comp_vectors	= 0;
-
-	caps->num_mtpts		= HNS_ROCE_V2_MAX_MTPT_NUM;
-	caps->num_pds		= HNS_ROCE_V2_MAX_PD_NUM;
-	caps->qpc_timer_bt_num	= HNS_ROCE_V2_MAX_QPC_TIMER_BT_NUM;
-	caps->cqc_timer_bt_num	= HNS_ROCE_V2_MAX_CQC_TIMER_BT_NUM;
-
-	caps->max_qp_init_rdma	= HNS_ROCE_V2_MAX_QP_INIT_RDMA;
-	caps->max_qp_dest_rdma	= HNS_ROCE_V2_MAX_QP_DEST_RDMA;
-	caps->max_sq_desc_sz	= HNS_ROCE_V2_MAX_SQ_DESC_SZ;
-	caps->max_rq_desc_sz	= HNS_ROCE_V2_MAX_RQ_DESC_SZ;
-	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
-	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
-	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
-	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
-	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
-	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
-	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
-	caps->reserved_lkey	= 0;
-	caps->reserved_pds	= 0;
-	caps->reserved_mrws	= 1;
-	caps->reserved_uars	= 0;
-	caps->reserved_cqs	= 0;
-	caps->reserved_srqs	= 0;
-	caps->reserved_qps	= HNS_ROCE_V2_RSV_QPS;
-
-	caps->qpc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->srqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->cqc_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->mpt_hop_num	= HNS_ROCE_CONTEXT_HOP_NUM;
-	caps->sccc_hop_num	= HNS_ROCE_SCCC_HOP_NUM;
-
-	caps->mtt_hop_num	= HNS_ROCE_MTT_HOP_NUM;
-	caps->wqe_sq_hop_num	= HNS_ROCE_SQWQE_HOP_NUM;
-	caps->wqe_sge_hop_num	= HNS_ROCE_EXT_SGE_HOP_NUM;
-	caps->wqe_rq_hop_num	= HNS_ROCE_RQWQE_HOP_NUM;
-	caps->cqe_hop_num	= HNS_ROCE_CQE_HOP_NUM;
-	caps->srqwqe_hop_num	= HNS_ROCE_SRQWQE_HOP_NUM;
-	caps->idx_hop_num	= HNS_ROCE_IDX_HOP_NUM;
-	caps->chunk_sz          = HNS_ROCE_V2_TABLE_CHUNK_SIZE;
-
-	caps->flags		= HNS_ROCE_CAP_FLAG_REREG_MR |
-				  HNS_ROCE_CAP_FLAG_ROCE_V1_V2 |
-				  HNS_ROCE_CAP_FLAG_CQ_RECORD_DB |
-				  HNS_ROCE_CAP_FLAG_QP_RECORD_DB;
-
-	caps->pkey_table_len[0] = 1;
-	caps->ceqe_depth	= HNS_ROCE_V2_COMP_EQE_NUM;
-	caps->aeqe_depth	= HNS_ROCE_V2_ASYNC_EQE_NUM;
-	caps->local_ca_ack_delay = 0;
-	caps->max_mtu = IB_MTU_4096;
-
-	caps->max_srq_wrs	= HNS_ROCE_V2_MAX_SRQ_WR;
-	caps->max_srq_sges	= HNS_ROCE_V2_MAX_SRQ_SGE;
-
-	caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
-		       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
-		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
-
-	caps->gid_table_len[0] = HNS_ROCE_V2_GID_INDEX_NUM;
-
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
-		caps->flags |= HNS_ROCE_CAP_FLAG_STASH |
-			       HNS_ROCE_CAP_FLAG_DIRECT_WQE |
-			       HNS_ROCE_CAP_FLAG_XRC;
-		caps->max_sq_inline = HNS_ROCE_V3_MAX_SQ_INLINE;
-	} else {
-		caps->max_sq_inline = HNS_ROCE_V2_MAX_SQ_INLINE;
-
-		/* The following configuration are only valid for HIP08 */
-		caps->qpc_sz = HNS_ROCE_V2_QPC_SZ;
-		caps->sccc_sz = HNS_ROCE_V2_SCCC_SZ;
-		caps->cqe_sz = HNS_ROCE_V2_CQE_SIZE;
-	}
-}
-
 static void calc_pg_sz(u32 obj_num, u32 obj_size, u32 hop_num, u32 ctx_bt_num,
 		       u32 *buf_page_size, u32 *bt_page_size, u32 hem_type)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index f3ebe953c6ce..1b44d2434ab4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -35,43 +35,15 @@
 
 #include <linux/bitops.h>
 
-#define HNS_ROCE_V2_MAX_QP_NUM			0x1000
-#define HNS_ROCE_V2_MAX_WQE_NUM			0x8000
-#define HNS_ROCE_V2_MAX_SRQ_WR			0x8000
-#define HNS_ROCE_V2_MAX_SRQ_SGE			64
-#define HNS_ROCE_V2_MAX_CQ_NUM			0x100000
-#define HNS_ROCE_V2_MAX_QPC_TIMER_BT_NUM	0x100
-#define HNS_ROCE_V2_MAX_CQC_TIMER_BT_NUM	0x100
-#define HNS_ROCE_V2_MAX_SRQ_NUM			0x100000
-#define HNS_ROCE_V2_MAX_CQE_NUM			0x400000
-#define HNS_ROCE_V2_MAX_RQ_SGE_NUM		64
-#define HNS_ROCE_V2_MAX_SQ_SGE_NUM		64
-#define HNS_ROCE_V2_MAX_SQ_INLINE		0x20
-#define HNS_ROCE_V3_MAX_SQ_INLINE		0x400
 #define HNS_ROCE_V2_MAX_RC_INL_INN_SZ		32
-#define HNS_ROCE_V2_UAR_NUM			256
-#define HNS_ROCE_V2_PHY_UAR_NUM			1
+#define HNS_ROCE_V2_MTT_ENTRY_SZ		64
 #define HNS_ROCE_V2_AEQE_VEC_NUM		1
 #define HNS_ROCE_V2_ABNORMAL_VEC_NUM		1
-#define HNS_ROCE_V2_MAX_MTPT_NUM		0x100000
 #define HNS_ROCE_V2_MAX_SRQWQE_SEGS		0x1000000
 #define HNS_ROCE_V2_MAX_IDX_SEGS		0x1000000
-#define HNS_ROCE_V2_MAX_PD_NUM			0x1000000
 #define HNS_ROCE_V2_MAX_XRCD_NUM		0x1000000
 #define HNS_ROCE_V2_RSV_XRCD_NUM		0
-#define HNS_ROCE_V2_MAX_QP_INIT_RDMA		128
-#define HNS_ROCE_V2_MAX_QP_DEST_RDMA		128
-#define HNS_ROCE_V2_MAX_SQ_DESC_SZ		64
-#define HNS_ROCE_V2_MAX_RQ_DESC_SZ		16
-#define HNS_ROCE_V2_IRRL_ENTRY_SZ		64
-#define HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ	100
-#define HNS_ROCE_V2_CQC_ENTRY_SZ		64
-#define HNS_ROCE_V2_SRQC_ENTRY_SZ		64
-#define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
-#define HNS_ROCE_V2_MTT_ENTRY_SZ		64
-#define HNS_ROCE_V2_IDX_ENTRY_SZ		4
 
-#define HNS_ROCE_V2_SCCC_SZ			32
 #define HNS_ROCE_V3_SCCC_SZ			64
 #define HNS_ROCE_V3_GMV_ENTRY_SZ		32
 
-- 
2.33.0

