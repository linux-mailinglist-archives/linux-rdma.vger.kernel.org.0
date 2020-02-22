Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504C7168E05
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2020 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgBVJVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Feb 2020 04:21:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgBVJVe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Feb 2020 04:21:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9F2D439E12491255A31;
        Sat, 22 Feb 2020 17:21:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Feb 2020 17:21:21 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Treat revision HIP08_A as a special case
Date:   Sat, 22 Feb 2020 17:17:19 +0800
Message-ID: <1582363039-10714-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Set revisions that equal to or higher than HIP08_B as default to maintain
backward compatibility.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dee1cc8..593bf8d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1680,7 +1680,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->max_srq_wrs	= HNS_ROCE_V2_MAX_SRQ_WR;
 	caps->max_srq_sges	= HNS_ROCE_V2_MAX_SRQ_SGE;
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B) {
 		caps->flags |= HNS_ROCE_CAP_FLAG_ATOMIC | HNS_ROCE_CAP_FLAG_MW |
 			       HNS_ROCE_CAP_FLAG_SRQ | HNS_ROCE_CAP_FLAG_FRMR |
 			       HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL;
@@ -1928,7 +1928,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 		   caps->srqc_bt_num, &caps->srqc_buf_pg_sz,
 		   &caps->srqc_ba_pg_sz, HEM_TYPE_SRQC);
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B) {
 		caps->sccc_hop_num = ctx_hop_num;
 		caps->qpc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
 		caps->cqc_timer_hop_num = HNS_ROCE_HOP_NUM_0;
@@ -1988,7 +1988,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		return ret;
 	}
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B) {
 		ret = hns_roce_query_pf_timer_resource(hr_dev);
 		if (ret) {
 			dev_err(hr_dev->dev,
@@ -1996,16 +1996,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 				ret);
 			return ret;
 		}
-	}
-
-	ret = hns_roce_alloc_vf_resource(hr_dev);
-	if (ret) {
-		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
-			ret);
-		return ret;
-	}
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B) {
 		ret = hns_roce_set_vf_switch_param(hr_dev, 0);
 		if (ret) {
 			dev_err(hr_dev->dev,
@@ -2015,6 +2006,13 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
 		}
 	}
 
+	ret = hns_roce_alloc_vf_resource(hr_dev);
+	if (ret) {
+		dev_err(hr_dev->dev, "Allocate vf resource fail, ret = %d.\n",
+			ret);
+		return ret;
+	}
+
 	hr_dev->vendor_part_id = hr_dev->pci_dev->device;
 	hr_dev->sys_image_guid = be64_to_cpu(hr_dev->ib_dev.node_guid);
 
@@ -2287,7 +2285,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 {
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B)
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B)
 		hns_roce_function_clear(hr_dev);
 
 	hns_roce_free_link_table(hr_dev, &priv->tpq);
@@ -4472,7 +4470,7 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
 		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08_B && is_udp)
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP08_B && is_udp)
 		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
 			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
 	else
-- 
2.8.1

