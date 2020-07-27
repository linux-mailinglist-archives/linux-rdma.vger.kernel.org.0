Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E25522E75D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgG0ILx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 04:11:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbgG0ILw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jul 2020 04:11:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79FC4A8A39B98FA24A2E;
        Mon, 27 Jul 2020 16:11:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 16:11:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/7] RDMA/hns: Remove support for HIP08A
Date:   Mon, 27 Jul 2020 16:10:45 +0800
Message-ID: <1595837449-29193-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
References: <1595837449-29193-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

HIP08_A is an engineering sample, and all of them have been already
replaced by HIP08_B. So remove the relevant code.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 97 ++++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 10 ---
 2 files changed, 45 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0eab92a..f5f0862 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1744,27 +1744,25 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_srq_wrs	= HNS_ROCE_V2_MAX_SRQ_WR;
 	caps->max_srq_sges	= HNS_ROCE_V2_MAX_SRQ_SGE;
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B) {
-		caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
-			       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
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
-		caps->sccc_entry_sz	  = HNS_ROCE_V2_SCCC_ENTRY_SZ;
-		caps->sccc_ba_pg_sz	  = 0;
-		caps->sccc_buf_pg_sz	  = 0;
-		caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
-	}
+	caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
+		       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
+		       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
+
+	caps->num_qpc_timer	  = HNS_ROCE_V2_MAX_QPC_TIMER_NUM;
+	caps->qpc_timer_entry_sz  = HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ;
+	caps->qpc_timer_ba_pg_sz  = 0;
+	caps->qpc_timer_buf_pg_sz = 0;
+	caps->qpc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
+	caps->num_cqc_timer	  = HNS_ROCE_V2_MAX_CQC_TIMER_NUM;
+	caps->cqc_timer_entry_sz  = HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ;
+	caps->cqc_timer_ba_pg_sz  = 0;
+	caps->cqc_timer_buf_pg_sz = 0;
+	caps->cqc_timer_hop_num   = HNS_ROCE_HOP_NUM_0;
+
+	caps->sccc_entry_sz	  = HNS_ROCE_V2_SCCC_ENTRY_SZ;
+	caps->sccc_ba_pg_sz	  = 0;
+	caps->sccc_buf_pg_sz	  = 0;
+	caps->sccc_hop_num	  = HNS_ROCE_SCCC_HOP_NUM;
 }
 
 static void calc_pg_sz(int obj_num, int obj_size, int hop_num, int ctx_bt_num,
@@ -1995,20 +1993,18 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		   caps->srqc_bt_num, &caps->srqc_buf_pg_sz,
 		   &caps->srqc_ba_pg_sz, HEM_TYPE_SRQC);
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B) {
-		caps->sccc_hop_num = ctx_hop_num;
-		caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
-		caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
+	caps->sccc_hop_num = ctx_hop_num;
+	caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
+	caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 
-		calc_pg_sz(caps->num_qps, caps->sccc_entry_sz,
-			   caps->sccc_hop_num, caps->sccc_bt_num,
-			   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
-			   HEM_TYPE_SCCC);
-		calc_pg_sz(caps->num_cqc_timer, caps->cqc_timer_entry_sz,
-			   caps->cqc_timer_hop_num, caps->cqc_timer_bt_num,
-			   &caps->cqc_timer_buf_pg_sz,
-			   &caps->cqc_timer_ba_pg_sz, HEM_TYPE_CQC_TIMER);
-	}
+	calc_pg_sz(caps->num_qps, caps->sccc_entry_sz,
+		   caps->sccc_hop_num, caps->sccc_bt_num,
+		   &caps->sccc_buf_pg_sz, &caps->sccc_ba_pg_sz,
+		   HEM_TYPE_SCCC);
+	calc_pg_sz(caps->num_cqc_timer, caps->cqc_timer_entry_sz,
+		   caps->cqc_timer_hop_num, caps->cqc_timer_bt_num,
+		   &caps->cqc_timer_buf_pg_sz,
+		   &caps->cqc_timer_ba_pg_sz, HEM_TYPE_CQC_TIMER);
 
 	calc_pg_sz(caps->num_cqe_segs, caps->mtt_entry_sz, caps->cqe_hop_num,
 		   1, &caps->cqe_buf_pg_sz, &caps->cqe_ba_pg_sz, HEM_TYPE_CQE);
@@ -2055,22 +2051,19 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B) {
-		ret = hns_roce_query_pf_timer_resource(hr_dev);
-		if (ret) {
-			dev_err(hr_dev->dev,
-				"Query pf timer resource fail, ret = %d.\n",
-				ret);
-			return ret;
-		}
+	ret = hns_roce_query_pf_timer_resource(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"failed to query pf timer resource, ret = %d.\n", ret);
+		return ret;
+	}
 
-		ret = hns_roce_set_vf_switch_param(hr_dev, 0);
-		if (ret) {
-			dev_err(hr_dev->dev,
-				"Set function switch param fail, ret = %d.\n",
-				ret);
-			return ret;
-		}
+	ret = hns_roce_set_vf_switch_param(hr_dev, 0);
+	if (ret) {
+		dev_err(hr_dev->dev,
+			"failed to set function switch param, ret = %d.\n",
+			ret);
+		return ret;
 	}
 
 	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
@@ -2336,8 +2329,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B)
-		hns_roce_function_clear(hr_dev);
+	hns_roce_function_clear(hr_dev);
 
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
 	hns_roce_free_link_table(hr_dev, &priv->tsq);
@@ -4231,12 +4223,13 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
 		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
 
-	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B && is_udp)
+	if (is_udp)
 		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
 	else
 		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 			       V2_QPC_BYTE_24_TC_S, grh->traffic_class);
+
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 		       V2_QPC_BYTE_24_TC_S, 0);
 	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index a0a47bd..e94ca13 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -411,7 +411,6 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
 				struct hns_roce_qp *hr_qp,
 				struct ib_qp_cap *cap)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	u32 cnt;
 
 	cnt = max(1U, cap->max_send_sge);
@@ -431,15 +430,6 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev, u32 sq_wqe_cnt,
 	} else if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE) {
 		cnt = roundup_pow_of_two(sq_wqe_cnt *
 				     (hr_qp->sq.max_gs - HNS_ROCE_SGE_IN_WQE));
-
-		if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
-			if (cnt > hr_dev->caps.max_extend_sg) {
-				ibdev_err(ibdev,
-					  "failed to check exSGE num, exSGE num = %d.\n",
-					  cnt);
-				return -EINVAL;
-			}
-		}
 	} else {
 		cnt = 0;
 	}
-- 
2.8.1

