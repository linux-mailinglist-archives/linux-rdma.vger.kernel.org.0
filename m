Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2361FB6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfGHNoy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729815AbfGHNox (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 997953B5A8A123DBA30E;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:39 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: optimize the duplicated code for qpc setting flow
Date:   Mon, 8 Jul 2019 21:41:21 +0800
Message-ID: <1562593285-8037-6-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
References: <1562593285-8037-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Currently, more than 20 lines of duplicate code exist in function
'modify_qp_init_to_init' and function 'modify_qp_reset_to_init',
which affects the readability of the code.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 96 ++++++++++++------------------
 1 file changed, 38 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index edc5dd2..c2ddfc1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3118,6 +3118,43 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
 	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
 }
 
+static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
+			    struct hns_roce_v2_qp_context *context,
+			    struct hns_roce_v2_qp_context *qpc_mask)
+{
+	if (hr_qp->ibqp.qp_type == IB_QPT_GSI)
+		roce_set_field(context->byte_4_sqpn_tst,
+			       V2_QPC_BYTE_4_SGE_SHIFT_M,
+			       V2_QPC_BYTE_4_SGE_SHIFT_S,
+			       ilog2((unsigned int)hr_qp->sge.sge_cnt));
+	else
+		roce_set_field(context->byte_4_sqpn_tst,
+			       V2_QPC_BYTE_4_SGE_SHIFT_M,
+			       V2_QPC_BYTE_4_SGE_SHIFT_S,
+			       hr_qp->sq.max_gs >
+			       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE ?
+			       ilog2((unsigned int)hr_qp->sge.sge_cnt) : 0);
+
+	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SGE_SHIFT_M,
+		       V2_QPC_BYTE_4_SGE_SHIFT_S, 0);
+
+	roce_set_field(context->byte_20_smac_sgid_idx,
+		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S,
+		       ilog2((unsigned int)hr_qp->sq.wqe_cnt));
+	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
+		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S, 0);
+
+	roce_set_field(context->byte_20_smac_sgid_idx,
+		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S,
+		       (hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
+		       hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT ||
+		       hr_qp->ibqp.srq) ? 0 :
+		       ilog2((unsigned int)hr_qp->rq.wqe_cnt));
+
+	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
+		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S, 0);
+}
+
 static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 				    const struct ib_qp_attr *attr,
 				    int attr_mask,
@@ -3138,21 +3175,6 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
 		       V2_QPC_BYTE_4_TST_S, 0);
 
-	if (ibqp->qp_type == IB_QPT_GSI)
-		roce_set_field(context->byte_4_sqpn_tst,
-			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S,
-			       ilog2((unsigned int)hr_qp->sge.sge_cnt));
-	else
-		roce_set_field(context->byte_4_sqpn_tst,
-			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S,
-			       hr_qp->sq.max_gs > 2 ?
-			       ilog2((unsigned int)hr_qp->sge.sge_cnt) : 0);
-
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SGE_SHIFT_M,
-		       V2_QPC_BYTE_4_SGE_SHIFT_S, 0);
-
 	roce_set_field(context->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
 		       V2_QPC_BYTE_4_SQPN_S, hr_qp->qpn);
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SQPN_M,
@@ -3168,19 +3190,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx, V2_QPC_BYTE_20_RQWS_M,
 		       V2_QPC_BYTE_20_RQWS_S, 0);
 
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S,
-		       ilog2((unsigned int)hr_qp->sq.wqe_cnt));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S, 0);
-
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S,
-		       (hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
-		       hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT || ibqp->srq) ? 0 :
-		       ilog2((unsigned int)hr_qp->rq.wqe_cnt));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S, 0);
+	set_qpc_wqe_cnt(hr_qp, context, qpc_mask);
 
 	/* No VLAN need to set 0xFFF */
 	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
@@ -3456,22 +3466,6 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_TST_M,
 		       V2_QPC_BYTE_4_TST_S, 0);
 
-	if (ibqp->qp_type == IB_QPT_GSI)
-		roce_set_field(context->byte_4_sqpn_tst,
-			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S,
-			       ilog2((unsigned int)hr_qp->sge.sge_cnt));
-	else
-		roce_set_field(context->byte_4_sqpn_tst,
-			       V2_QPC_BYTE_4_SGE_SHIFT_M,
-			       V2_QPC_BYTE_4_SGE_SHIFT_S,
-			       hr_qp->sq.max_gs >
-			       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE ?
-			       ilog2((unsigned int)hr_qp->sge.sge_cnt) : 0);
-
-	roce_set_field(qpc_mask->byte_4_sqpn_tst, V2_QPC_BYTE_4_SGE_SHIFT_M,
-		       V2_QPC_BYTE_4_SGE_SHIFT_S, 0);
-
 	if (attr_mask & IB_QP_ACCESS_FLAGS) {
 		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
 			     !!(attr->qp_access_flags & IB_ACCESS_REMOTE_READ));
@@ -3506,20 +3500,6 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
 			     0);
 	}
 
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S,
-		       ilog2((unsigned int)hr_qp->sq.wqe_cnt));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_SQ_SHIFT_M, V2_QPC_BYTE_20_SQ_SHIFT_S, 0);
-
-	roce_set_field(context->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S,
-		       (hr_qp->ibqp.qp_type == IB_QPT_XRC_INI ||
-		       hr_qp->ibqp.qp_type == IB_QPT_XRC_TGT || ibqp->srq) ? 0 :
-		       ilog2((unsigned int)hr_qp->rq.wqe_cnt));
-	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-		       V2_QPC_BYTE_20_RQ_SHIFT_M, V2_QPC_BYTE_20_RQ_SHIFT_S, 0);
-
 	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
 		       V2_QPC_BYTE_16_PD_S, to_hr_pd(ibqp->pd)->pdn);
 	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
-- 
1.9.1

