Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8551ADD78B
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Oct 2019 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfJSIzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Oct 2019 04:55:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfJSIzS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Oct 2019 04:55:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 249B7647C74ABC886516;
        Sat, 19 Oct 2019 16:55:16 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 19 Oct 2019 16:55:05 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
Date:   Sat, 19 Oct 2019 16:46:12 +0800
Message-ID: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch aims to let hip08 support communication of Unreliable
Datagram.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
V1->V2:
1. Use CAP_NET_RAW for limit the creation UD queue
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 17 ++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_qp.c    |  7 +++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7a89d66..e320ab0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -296,7 +296,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 		tmp_len = 0;
 
 		/* Corresponding to the QP type, wqe process separately */
-		if (ibqp->qp_type == IB_QPT_GSI) {
+		if (ibqp->qp_type == IB_QPT_GSI || ibqp->qp_type == IB_QPT_UD) {
 			ud_sq_wqe = wqe;
 			memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
 
@@ -417,8 +417,7 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
 			roce_set_field(ud_sq_wqe->byte_48,
 				       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_M,
 				       V2_UD_SEND_WQE_BYTE_48_SGID_INDX_S,
-				       hns_get_gid_index(hr_dev, qp->phy_port,
-							 ah->av.gid_index));
+				       ah->av.gid_index);
 
 			memcpy(&ud_sq_wqe->dgid[0], &ah->av.dgid[0],
 			       GID_LEN_V2);
@@ -3217,7 +3216,8 @@ static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
 			    struct hns_roce_v2_qp_context *context,
 			    struct hns_roce_v2_qp_context *qpc_mask)
 {
-	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI ||
+	    hr_qp->ibqp.qp_type == IB_QPT_UD)
 		roce_set_field(context->byte_4_sqpn_tst,
 			       V2_QPC_BYTE_4_SGE_SHIFT_M,
 			       V2_QPC_BYTE_4_SGE_SHIFT_S,
@@ -3737,8 +3737,9 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
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
@@ -4652,7 +4653,9 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
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
index bd78ff9..722cc5f 100644
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
@@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 	int ret;
 
 	switch (init_attr->qp_type) {
+	case IB_QPT_UD:
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
 	case IB_QPT_RC: {
 		hr_qp = kzalloc(sizeof(*hr_qp), GFP_KERNEL);
 		if (!hr_qp)
-- 
2.8.1

