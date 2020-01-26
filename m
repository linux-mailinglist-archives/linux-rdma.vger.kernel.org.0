Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F105C149B32
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgAZOz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jan 2020 09:55:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgAZOz2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Jan 2020 09:55:28 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1F3537637DEDCC16484;
        Sun, 26 Jan 2020 22:55:23 +0800 (CST)
Received: from SZA160416817.china.huawei.com (10.45.215.46) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sun, 26 Jan 2020 22:55:16 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Cleanups of magic numbers
Date:   Sun, 26 Jan 2020 22:55:04 +0800
Message-ID: <20200126145504.9700-1-liweihang@huawei.com>
X-Mailer: git-send-email 2.10.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.45.215.46]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Some magic numbers are hard to understand, so replace them with macros
or add some comments for them.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Yixian Liu <liuyixian@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 10 +++++-----
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 23 +++++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  3 ++-
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a7c4ff9..3b3d6fe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -881,7 +881,7 @@ struct hns_roce_caps {
 	u32		cqc_timer_ba_pg_sz;
 	u32		cqc_timer_buf_pg_sz;
 	u32		cqc_timer_hop_num;
-	u32		cqe_ba_pg_sz;
+	u32             cqe_ba_pg_sz;	/* page_size = 4K*(2^cqe_ba_pg_sz) */
 	u32		cqe_buf_pg_sz;
 	u32		cqe_hop_num;
 	u32		srqwqe_ba_pg_sz;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 12c4cd8..b866878 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1999,7 +1999,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
-	if (hr_dev->pci_dev->revision == 0x21) {
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
 		ret = hns_roce_query_pf_timer_resource(hr_dev);
 		if (ret) {
 			dev_err(hr_dev->dev,
@@ -2016,7 +2016,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
-	if (hr_dev->pci_dev->revision == 0x21) {
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
 		ret = hns_roce_set_vf_switch_param(hr_dev, 0);
 		if (ret) {
 			dev_err(hr_dev->dev,
@@ -2298,7 +2298,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
-	if (hr_dev->pci_dev->revision == 0x21)
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B)
 		hns_roce_function_clear(hr_dev);
 
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
@@ -2757,7 +2757,7 @@ static void hns_roce_free_srq_wqe(struct hns_roce_srq *srq, int wqe_index)
 
 static void hns_roce_v2_cq_set_ci(struct hns_roce_cq *hr_cq, u32 cons_index)
 {
-	*hr_cq->set_ci_db = cons_index & 0xffffff;
+	*hr_cq->set_ci_db = cons_index & V2_CQ_DB_PARAMETER_CONS_IDX_M;
 }
 
 static void __hns_roce_v2_cq_clean(struct hns_roce_cq *hr_cq, u32 qpn,
@@ -4475,7 +4475,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
 		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
 
-	if (hr_dev->pci_dev->revision == 0x21 && is_udp)
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B && is_udp)
 		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
 	else
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7c8de1e..d4b0d78 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -309,7 +309,7 @@ static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
 
 		max_cnt = max(1U, cap->max_recv_sge);
 		hr_qp->rq.max_gs = roundup_pow_of_two(max_cnt);
-		if (hr_dev->caps.max_rq_sg <= 2)
+		if (hr_dev->caps.max_rq_sg <= HNS_ROCE_SGE_IN_WQE)
 			hr_qp->rq.wqe_shift =
 					ilog2(hr_dev->caps.max_rq_desc_sz);
 		else
@@ -370,16 +370,17 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 	hr_qp->sq.wqe_shift = ucmd->log_sq_stride;
 
 	max_cnt = max(1U, cap->max_send_sge);
-	if (hr_dev->caps.max_sq_sg <= 2)
+	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
 		hr_qp->sq.max_gs = roundup_pow_of_two(max_cnt);
 	else
 		hr_qp->sq.max_gs = max_cnt;
 
-	if (hr_qp->sq.max_gs > 2)
+	if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE)
 		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
 							(hr_qp->sq.max_gs - 2));
 
-	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision == 0x20)) {
+	if (hr_qp->sq.max_gs > HNS_ROCE_SGE_IN_WQE &&
+	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
 		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
 			dev_err(hr_dev->dev,
 				"The extended sge cnt error! sge_cnt=%d\n",
@@ -392,7 +393,7 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 	ex_sge_num = hr_qp->sge.sge_cnt;
 
 	/* Get buf size, SQ and RQ  are aligned to page_szie */
-	if (hr_dev->caps.max_sq_sg <= 2) {
+	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
 		hr_qp->buff_size = round_up((hr_qp->rq.wqe_cnt <<
 					     hr_qp->rq.wqe_shift), PAGE_SIZE) +
 				   round_up((hr_qp->sq.wqe_cnt <<
@@ -528,13 +529,15 @@ static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
 	}
 
 	/* ud sqwqe's sge use extend sge */
-	if (hr_dev->caps.max_sq_sg > 2 && hr_qp->ibqp.qp_type == IB_QPT_GSI) {
+	if (hr_dev->hw_rev != HNS_ROCE_HW_VER1 &&
+	    hr_qp->ibqp.qp_type == IB_QPT_GSI) {
 		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
 				     hr_qp->sq.max_gs);
 		hr_qp->sge.sge_shift = 4;
 	}
 
-	if ((hr_qp->sq.max_gs > 2) && hr_dev->pci_dev->revision == 0x20) {
+	if (hr_qp->sq.max_gs > 2 &&
+	    hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_A) {
 		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
 			dev_err(dev, "The extended sge cnt error! sge_cnt=%d\n",
 				hr_qp->sge.sge_cnt);
@@ -577,7 +580,7 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 
 	/* Get data_seg numbers */
 	max_cnt = max(1U, cap->max_send_sge);
-	if (hr_dev->caps.max_sq_sg <= 2)
+	if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
 		hr_qp->sq.max_gs = roundup_pow_of_two(max_cnt);
 	else
 		hr_qp->sq.max_gs = max_cnt;
@@ -593,7 +596,7 @@ static int hns_roce_set_kernel_sq_size(struct hns_roce_dev *hr_dev,
 	hr_qp->sq.offset = 0;
 	size = round_up(hr_qp->sq.wqe_cnt << hr_qp->sq.wqe_shift, page_size);
 
-	if (hr_dev->caps.max_sq_sg > 2 && hr_qp->sge.sge_cnt) {
+	if (hr_dev->hw_rev != HNS_ROCE_HW_VER1 && hr_qp->sge.sge_cnt) {
 		hr_qp->sge.sge_cnt = max(page_size/(1 << hr_qp->sge.sge_shift),
 					 (u32)hr_qp->sge.sge_cnt);
 		hr_qp->sge.offset = size;
@@ -1078,7 +1081,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
 
 		/* when hw version is v1, the sqpn is allocated */
-		if (hr_dev->caps.max_sq_sg <= 2)
+		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
 			hr_qp->ibqp.qp_num = HNS_ROCE_MAX_PORTS +
 					     hr_dev->iboe.phy_port[hr_qp->port];
 		else
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 7113ebf..b5d7730 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -380,7 +380,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	srq->wqe_cnt = roundup_pow_of_two(init_attr->attr.max_wr + 1);
 	srq->max_gs = init_attr->attr.max_sge;
 
-	srq_desc_size = roundup_pow_of_two(max(16, 16 * srq->max_gs));
+	srq_desc_size = roundup_pow_of_two(max(HNS_ROCE_SGE_SIZE,
+					HNS_ROCE_SGE_SIZE * srq->max_gs));
 
 	srq->wqe_shift = ilog2(srq_desc_size);
 
-- 
2.8.1


