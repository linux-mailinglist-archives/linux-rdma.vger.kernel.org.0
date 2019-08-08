Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B498864EF
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfHHO6U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 10:58:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733174AbfHHO6T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 10:58:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 668594B096052DE84D52;
        Thu,  8 Aug 2019 22:58:17 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 22:58:07 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V4 for-next 10/14] RDMA/hns: Remove unnecessary kzalloc
Date:   Thu, 8 Aug 2019 22:53:50 +0800
Message-ID: <1565276034-97329-11-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
References: <1565276034-97329-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

For hns_roce_v2_query_qp and hns_roce_v2_modify_qp,
we can use stack memory to create qp context data.
Make the code simpler.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
V2->V3:
1. Delete unncessary memset operation

V1->V2:
1. Fix the comment gived by Leon Romanovsky
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++-----------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index c2ad774..de02612 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4288,22 +4288,19 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct hns_roce_v2_qp_context *context;
-	struct hns_roce_v2_qp_context *qpc_mask;
+	struct hns_roce_v2_qp_context ctx[2];
+	struct hns_roce_v2_qp_context *context = ctx;
+	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
 	struct device *dev = hr_dev->dev;
 	int ret;
 
-	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
-	if (!context)
-		return -ENOMEM;
-
-	qpc_mask = context + 1;
 	/*
 	 * In v2 engine, software pass context and context mask to hardware
 	 * when modifying qp. If software need modify some fields in context,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
+	memset(context, 0, sizeof(*context));
 	memset(qpc_mask, 0xff, sizeof(*qpc_mask));
 	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
 					 new_state, context, qpc_mask);
@@ -4349,8 +4346,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_60_QP_ST_S, 0);
 
 	/* SW pass context to HW */
-	ret = hns_roce_v2_qp_modify(hr_dev, cur_state, new_state,
-				    context, hr_qp);
+	ret = hns_roce_v2_qp_modify(hr_dev, cur_state, new_state, ctx, hr_qp);
 	if (ret) {
 		dev_err(dev, "hns_roce_qp_modify failed(%d)\n", ret);
 		goto out;
@@ -4378,7 +4374,6 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 	}
 
 out:
-	kfree(context);
 	return ret;
 }
 
@@ -4429,16 +4424,12 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct hns_roce_v2_qp_context *context;
+	struct hns_roce_v2_qp_context context = {};
 	struct device *dev = hr_dev->dev;
 	int tmp_qp_state;
 	int state;
 	int ret;
 
-	context = kzalloc(sizeof(*context), GFP_KERNEL);
-	if (!context)
-		return -ENOMEM;
-
 	memset(qp_attr, 0, sizeof(*qp_attr));
 	memset(qp_init_attr, 0, sizeof(*qp_init_attr));
 
@@ -4450,14 +4441,14 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		goto done;
 	}
 
-	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp, context);
+	ret = hns_roce_v2_query_qpc(hr_dev, hr_qp, &context);
 	if (ret) {
 		dev_err(dev, "query qpc error\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	state = roce_get_field(context->byte_60_qpst_tempid,
+	state = roce_get_field(context.byte_60_qpst_tempid,
 			       V2_QPC_BYTE_60_QP_ST_M, V2_QPC_BYTE_60_QP_ST_S);
 	tmp_qp_state = to_ib_qp_st((enum hns_roce_v2_qp_state)state);
 	if (tmp_qp_state == -1) {
@@ -4467,7 +4458,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	}
 	hr_qp->state = (u8)tmp_qp_state;
 	qp_attr->qp_state = (enum ib_qp_state)hr_qp->state;
-	qp_attr->path_mtu = (enum ib_mtu)roce_get_field(context->byte_24_mtu_tc,
+	qp_attr->path_mtu = (enum ib_mtu)roce_get_field(context.byte_24_mtu_tc,
 							V2_QPC_BYTE_24_MTU_M,
 							V2_QPC_BYTE_24_MTU_S);
 	qp_attr->path_mig_state = IB_MIG_ARMED;
@@ -4475,20 +4466,20 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
 		qp_attr->qkey = V2_QKEY_VAL;
 
-	qp_attr->rq_psn = roce_get_field(context->byte_108_rx_reqepsn,
+	qp_attr->rq_psn = roce_get_field(context.byte_108_rx_reqepsn,
 					 V2_QPC_BYTE_108_RX_REQ_EPSN_M,
 					 V2_QPC_BYTE_108_RX_REQ_EPSN_S);
-	qp_attr->sq_psn = (u32)roce_get_field(context->byte_172_sq_psn,
+	qp_attr->sq_psn = (u32)roce_get_field(context.byte_172_sq_psn,
 					      V2_QPC_BYTE_172_SQ_CUR_PSN_M,
 					      V2_QPC_BYTE_172_SQ_CUR_PSN_S);
-	qp_attr->dest_qp_num = (u8)roce_get_field(context->byte_56_dqpn_err,
+	qp_attr->dest_qp_num = (u8)roce_get_field(context.byte_56_dqpn_err,
 						  V2_QPC_BYTE_56_DQPN_M,
 						  V2_QPC_BYTE_56_DQPN_S);
-	qp_attr->qp_access_flags = ((roce_get_bit(context->byte_76_srqn_op_en,
+	qp_attr->qp_access_flags = ((roce_get_bit(context.byte_76_srqn_op_en,
 				    V2_QPC_BYTE_76_RRE_S)) << V2_QP_RWE_S) |
-				    ((roce_get_bit(context->byte_76_srqn_op_en,
+				    ((roce_get_bit(context.byte_76_srqn_op_en,
 				    V2_QPC_BYTE_76_RWE_S)) << V2_QP_RRE_S) |
-				    ((roce_get_bit(context->byte_76_srqn_op_en,
+				    ((roce_get_bit(context.byte_76_srqn_op_en,
 				    V2_QPC_BYTE_76_ATE_S)) << V2_QP_ATE_S);
 
 	if (hr_qp->ibqp.qp_type == IB_QPT_RC ||
@@ -4497,43 +4488,43 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 				rdma_ah_retrieve_grh(&qp_attr->ah_attr);
 
 		rdma_ah_set_sl(&qp_attr->ah_attr,
-			       roce_get_field(context->byte_28_at_fl,
+			       roce_get_field(context.byte_28_at_fl,
 					      V2_QPC_BYTE_28_SL_M,
 					      V2_QPC_BYTE_28_SL_S));
-		grh->flow_label = roce_get_field(context->byte_28_at_fl,
+		grh->flow_label = roce_get_field(context.byte_28_at_fl,
 						 V2_QPC_BYTE_28_FL_M,
 						 V2_QPC_BYTE_28_FL_S);
-		grh->sgid_index = roce_get_field(context->byte_20_smac_sgid_idx,
+		grh->sgid_index = roce_get_field(context.byte_20_smac_sgid_idx,
 						 V2_QPC_BYTE_20_SGID_IDX_M,
 						 V2_QPC_BYTE_20_SGID_IDX_S);
-		grh->hop_limit = roce_get_field(context->byte_24_mtu_tc,
+		grh->hop_limit = roce_get_field(context.byte_24_mtu_tc,
 						V2_QPC_BYTE_24_HOP_LIMIT_M,
 						V2_QPC_BYTE_24_HOP_LIMIT_S);
-		grh->traffic_class = roce_get_field(context->byte_24_mtu_tc,
+		grh->traffic_class = roce_get_field(context.byte_24_mtu_tc,
 						    V2_QPC_BYTE_24_TC_M,
 						    V2_QPC_BYTE_24_TC_S);
 
-		memcpy(grh->dgid.raw, context->dgid, sizeof(grh->dgid.raw));
+		memcpy(grh->dgid.raw, context.dgid, sizeof(grh->dgid.raw));
 	}
 
 	qp_attr->port_num = hr_qp->port + 1;
 	qp_attr->sq_draining = 0;
-	qp_attr->max_rd_atomic = 1 << roce_get_field(context->byte_208_irrl,
+	qp_attr->max_rd_atomic = 1 << roce_get_field(context.byte_208_irrl,
 						     V2_QPC_BYTE_208_SR_MAX_M,
 						     V2_QPC_BYTE_208_SR_MAX_S);
-	qp_attr->max_dest_rd_atomic = 1 << roce_get_field(context->byte_140_raq,
+	qp_attr->max_dest_rd_atomic = 1 << roce_get_field(context.byte_140_raq,
 						     V2_QPC_BYTE_140_RR_MAX_M,
 						     V2_QPC_BYTE_140_RR_MAX_S);
-	qp_attr->min_rnr_timer = (u8)roce_get_field(context->byte_80_rnr_rx_cqn,
+	qp_attr->min_rnr_timer = (u8)roce_get_field(context.byte_80_rnr_rx_cqn,
 						 V2_QPC_BYTE_80_MIN_RNR_TIME_M,
 						 V2_QPC_BYTE_80_MIN_RNR_TIME_S);
-	qp_attr->timeout = (u8)roce_get_field(context->byte_28_at_fl,
+	qp_attr->timeout = (u8)roce_get_field(context.byte_28_at_fl,
 					      V2_QPC_BYTE_28_AT_M,
 					      V2_QPC_BYTE_28_AT_S);
-	qp_attr->retry_cnt = roce_get_field(context->byte_212_lsn,
+	qp_attr->retry_cnt = roce_get_field(context.byte_212_lsn,
 					    V2_QPC_BYTE_212_RETRY_CNT_M,
 					    V2_QPC_BYTE_212_RETRY_CNT_S);
-	qp_attr->rnr_retry = context->rq_rnr_timer;
+	qp_attr->rnr_retry = context.rq_rnr_timer;
 
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
@@ -4552,7 +4543,6 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 
 out:
 	mutex_unlock(&hr_qp->mutex);
-	kfree(context);
 	return ret;
 }
 
-- 
1.9.1

