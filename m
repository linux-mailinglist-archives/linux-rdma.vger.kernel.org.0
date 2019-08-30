Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39786A3326
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfH3IyS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 04:54:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727294AbfH3IyS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 04:54:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 187238F30301A26F8A09;
        Fri, 30 Aug 2019 16:54:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 16:54:07 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next] RDMA/hns: Add UD support for hip08
Date:   Fri, 30 Aug 2019 16:50:56 +0800
Message-ID: <1567155056-38660-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

This patch aims to let hip08 support communication of Unreliable
Datagram.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 17 ++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  5 +++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 206dfdb..e27d864a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -296,7 +296,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		tmp_len = 0;
 
 		/* Corresponding to the QP type, wqe process separately */
-		if (ibqp->qp_type == IB_QPT_GSI) {
+		if (ibqp->qp_type == IB_QPT_GSI || ibqp->qp_type == IB_QPT_UD) {
 			ud_sq_wqe = wqe;
 			memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
 
@@ -420,8 +420,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->byte_48,
 				       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M,
 				       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S,
-				       hns_get_gid_index(hr_dev, qp->phy_port,
-							 ah->av.gid_index));
+				       ah->av.gid_index);
 
 			memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0],
 			       GID_LEN_V2);
@@ -3130,7 +3129,8 @@ static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
 			    struct hns_roce_v2_qp_context *qpc_mask)
 {
-	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI ||
+	    hr_qp->ibqp.qp_type == IB_QPT_UD)
 		roce_set_field(context->byte_4_sqpn_tst,
 			       V2_QPC_BYTE_4_SGE_SHIFT_M,
 			       V2_QPC_BYTE_4_SGE_SHIFT_S,
@@ -3650,8 +3650,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(context->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_S,
-		       ((ibqp->qp_type == IB_QPT_GSI) ||
-		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
+		       ((ibqp->qp_type == IB_QPT_GSI ||
+			ibqp->qp_type == IB_QPT_UD) ||
+			hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
 		       hr_dev->caps.wqe_sge_hop_num : 0);
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGE_HOP_NUM_M,
@@ -4564,7 +4565,9 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	if (hr_qp->ibqp.qp_type == IB_QPT_RC && hr_qp->state != IB_QPS_RESET) {
+	if ((hr_qp->ibqp.qp_type == IB_QPT_RC ||
+	     hr_qp->ibqp.qp_type == IB_QPT_UD) &&
+	    hr_qp->state != IB_QPS_RESET) {
 		/* Modify qp to reset before destroying qp */
 		ret = hns_roce_v2_modify_qp(&hr_qp->ibqp, NULL, 0,
 					    hr_qp->state, IB_QPS_RESET);
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index ba81768..5374cd0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
 		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
 							(hr_qp->sq.max_gs - 2));
 
+	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
+		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
+						       hr_qp->sq.max_gs);
+
 	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision == 0x20)) {
 		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
 			dev_err(hr_dev->dev,
@@ -1005,6 +1009,7 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	int ret;
 
 	switch (init_attr->qp_type) {
+	case IB_QPT_UD:
 	case IB_QPT_RC: {
 		hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
 		if (!hr_qp)
-- 
2.8.1

