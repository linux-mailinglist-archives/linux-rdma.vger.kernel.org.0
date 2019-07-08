Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67C761FB4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGHNox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731409AbfGHNox (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Jul 2019 09:44:53 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 72BF59E27B738303031A;
        Mon,  8 Jul 2019 21:44:49 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 8 Jul 2019 21:44:39 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/9] RDMA/hns: Refactor for hns_roce_v2_modify_qp function
Date:   Mon, 8 Jul 2019 21:41:19 +0800
Message-ID: <1562593285-8037-4-git-send-email-oulijun@huawei.com>
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

This patch packages some lines which exist hns_roce_v2_modify_qp
function into the new function. The codes refactored mainly
include some absolute fields of qp context and some optional
fields of qp context.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Xi Wang <wangxi11@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 356 +++++++++++++++++------------
 1 file changed, 206 insertions(+), 150 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b76e3be..edc5dd2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3974,30 +3974,119 @@ static inline bool hns_roce_v2_check_qp_stat(enum ib_qp_state cur_state,
 
 }
 
-static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
-				 const struct ib_qp_attr *attr,
-				 int attr_mask, enum ib_qp_state cur_state,
-				 enum ib_qp_state new_state)
+static int hns_roce_v2_set_path(struct ib_qp *ibqp,
+				const struct ib_qp_attr *attr,
+				int attr_mask,
+				struct hns_roce_v2_qp_context *context,
+				struct hns_roce_v2_qp_context *qpc_mask)
 {
+	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct hns_roce_v2_qp_context *context;
-	struct hns_roce_v2_qp_context *qpc_mask;
-	struct device *dev = hr_dev->dev;
-	int ret = -EINVAL;
+	const struct ib_gid_attr *gid_attr = NULL;
+	int is_roce_protocol;
+	bool is_udp = false;
+	u16 vlan = 0xffff;
+	u8 ib_port;
+	u8 hr_port;
+	int ret;
 
-	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
-	if (!context)
-		return -ENOMEM;
+	ib_port = (attr_mask & IB_QP_PORT) ? attr->port_num : hr_qp->port + 1;
+	hr_port = ib_port - 1;
+	is_roce_protocol = rdma_cap_eth_ah(&hr_dev->ib_dev, ib_port) &&
+			   rdma_ah_get_ah_flags(&attr->ah_attr) & IB_AH_GRH;
+
+	if (is_roce_protocol) {
+		gid_attr = attr->ah_attr.grh.sgid_attr;
+		ret = rdma_read_gid_l2_fields(gid_attr, &vlan, NULL);
+		if (ret)
+			return ret;
+
+		if (gid_attr)
+			is_udp = (gid_attr->gid_type ==
+				 IB_GID_TYPE_ROCE_UDP_ENCAP);
+	}
+
+	if (vlan < VLAN_CFI_MASK) {
+		roce_set_bit(context->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 1);
+		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
+			     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 0);
+		roce_set_bit(context->byte_168_irrl_idx,
+			     V2_QPC_BYTE_168_SQ_VLAN_EN_S, 1);
+		roce_set_bit(qpc_mask->byte_168_irrl_idx,
+			     V2_QPC_BYTE_168_SQ_VLAN_EN_S, 0);
+	}
+
+	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
+		       V2_QPC_BYTE_24_VLAN_ID_S, vlan);
+	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_VLAN_ID_M,
+		       V2_QPC_BYTE_24_VLAN_ID_S, 0);
+
+	if (grh->sgid_index >= hr_dev->caps.gid_table_len[hr_port]) {
+		dev_err(hr_dev->dev, "sgid_index(%u) too large. max is %d\n",
+			grh->sgid_index, hr_dev->caps.gid_table_len[hr_port]);
+		return -EINVAL;
+	}
+
+	if (attr->ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE) {
+		dev_err(hr_dev->dev, "ah attr is not RDMA roce type\n");
+		return -EINVAL;
+	}
+
+	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_UDPSPN_M,
+		       V2_QPC_BYTE_52_UDPSPN_S,
+		       is_udp ? 0x12b7 : 0);
+
+	roce_set_field(qpc_mask->byte_52_udpspn_dmac, V2_QPC_BYTE_52_UDPSPN_M,
+		       V2_QPC_BYTE_52_UDPSPN_S, 0);
+
+	roce_set_field(context->byte_20_smac_sgid_idx,
+		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S,
+		       grh->sgid_index);
+
+	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
+		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S, 0);
+
+	roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
+		       V2_QPC_BYTE_24_HOP_LIMIT_S, grh->hop_limit);
+	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_HOP_LIMIT_M,
+		       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
+
+	if (hr_dev->pci_dev->revision == 0x21 && is_udp)
+		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
+			       V2_QPC_BYTE_24_TC_S, grh->traffic_class >> 2);
+	else
+		roce_set_field(context->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
+			       V2_QPC_BYTE_24_TC_S, grh->traffic_class);
+	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
+		       V2_QPC_BYTE_24_TC_S, 0);
+	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
+		       V2_QPC_BYTE_28_FL_S, grh->flow_label);
+	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
+		       V2_QPC_BYTE_28_FL_S, 0);
+	memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
+	memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
+	roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
+		       V2_QPC_BYTE_28_SL_S, rdma_ah_get_sl(&attr->ah_attr));
+	roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
+		       V2_QPC_BYTE_28_SL_S, 0);
+	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+
+	return 0;
+}
+
+static int hns_roce_v2_set_abs_fields(struct ib_qp *ibqp,
+				      const struct ib_qp_attr *attr,
+				      int attr_mask,
+				      enum ib_qp_state cur_state,
+				      enum ib_qp_state new_state,
+				      struct hns_roce_v2_qp_context *context,
+				      struct hns_roce_v2_qp_context *qpc_mask)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	int ret = 0;
 
-	qpc_mask = context + 1;
-	/*
-	 * In v2 engine, software pass context and context mask to hardware
-	 * when modifying qp. If software need modify some fields in context,
-	 * we should set all bits of the relevant fields in context mask to
-	 * 0 at the same time, else set them to 0x1.
-	 */
-	memset(qpc_mask, 0xff, sizeof(*qpc_mask));
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		memset(qpc_mask, 0, sizeof(*qpc_mask));
 		modify_qp_reset_to_init(ibqp, attr, attr_mask, context,
@@ -4019,134 +4108,30 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		/* Nothing */
 		;
 	} else {
-		dev_err(dev, "Illegal state for QP!\n");
+		dev_err(hr_dev->dev, "Illegal state for QP!\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* When QP state is err, SQ and RQ WQE should be flushed */
-	if (new_state == IB_QPS_ERR) {
-		roce_set_field(context->byte_160_sq_ci_pi,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
-			       hr_qp->sq.head);
-		roce_set_field(qpc_mask->byte_160_sq_ci_pi,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
+out:
+	return ret;
+}
 
-		if (!ibqp->srq) {
-			roce_set_field(context->byte_84_rq_ci_pi,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
-			       hr_qp->rq.head);
-			roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
-		}
-	}
+static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
+				      const struct ib_qp_attr *attr,
+				      int attr_mask,
+				      struct hns_roce_v2_qp_context *context,
+				      struct hns_roce_v2_qp_context *qpc_mask)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	int ret = 0;
 
 	if (attr_mask & IB_QP_AV) {
-		const struct ib_global_route *grh =
-					    rdma_ah_read_grh(&attr->ah_attr);
-		const struct ib_gid_attr *gid_attr = NULL;
-		int is_roce_protocol;
-		u16 vlan = 0xffff;
-		u8 ib_port;
-		u8 hr_port;
-
-		ib_port = (attr_mask & IB_QP_PORT) ? attr->port_num :
-			   hr_qp->port + 1;
-		hr_port = ib_port - 1;
-		is_roce_protocol = rdma_cap_eth_ah(&hr_dev->ib_dev, ib_port) &&
-			       rdma_ah_get_ah_flags(&attr->ah_attr) & IB_AH_GRH;
-
-		if (is_roce_protocol) {
-			gid_attr = attr->ah_attr.grh.sgid_attr;
-			ret = rdma_read_gid_l2_fields(gid_attr, &vlan, NULL);
-			if (ret)
-				goto out;
-		}
-
-		if (vlan < VLAN_CFI_MASK) {
-			roce_set_bit(context->byte_76_srqn_op_en,
-				     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 1);
-			roce_set_bit(qpc_mask->byte_76_srqn_op_en,
-				     V2_QPC_BYTE_76_RQ_VLAN_EN_S, 0);
-			roce_set_bit(context->byte_168_irrl_idx,
-				     V2_QPC_BYTE_168_SQ_VLAN_EN_S, 1);
-			roce_set_bit(qpc_mask->byte_168_irrl_idx,
-				     V2_QPC_BYTE_168_SQ_VLAN_EN_S, 0);
-		}
-
-		roce_set_field(context->byte_24_mtu_tc,
-			       V2_QPC_BYTE_24_VLAN_ID_M,
-			       V2_QPC_BYTE_24_VLAN_ID_S, vlan);
-		roce_set_field(qpc_mask->byte_24_mtu_tc,
-			       V2_QPC_BYTE_24_VLAN_ID_M,
-			       V2_QPC_BYTE_24_VLAN_ID_S, 0);
-
-		if (grh->sgid_index >= hr_dev->caps.gid_table_len[hr_port]) {
-			dev_err(hr_dev->dev,
-				"sgid_index(%u) too large. max is %d\n",
-				grh->sgid_index,
-				hr_dev->caps.gid_table_len[hr_port]);
-			ret = -EINVAL;
-			goto out;
-		}
-
-		if (attr->ah_attr.type != RDMA_AH_ATTR_TYPE_ROCE) {
-			dev_err(hr_dev->dev, "ah attr is not RDMA roce type\n");
-			ret = -EINVAL;
-			goto out;
-		}
-
-		roce_set_field(context->byte_52_udpspn_dmac,
-			   V2_QPC_BYTE_52_UDPSPN_M, V2_QPC_BYTE_52_UDPSPN_S,
-			   (gid_attr->gid_type != IB_GID_TYPE_ROCE_UDP_ENCAP) ?
-			   0 : 0x12b7);
-
-		roce_set_field(qpc_mask->byte_52_udpspn_dmac,
-			       V2_QPC_BYTE_52_UDPSPN_M,
-			       V2_QPC_BYTE_52_UDPSPN_S, 0);
-
-		roce_set_field(context->byte_20_smac_sgid_idx,
-			       V2_QPC_BYTE_20_SGID_IDX_M,
-			       V2_QPC_BYTE_20_SGID_IDX_S, grh->sgid_index);
-
-		roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
-			       V2_QPC_BYTE_20_SGID_IDX_M,
-			       V2_QPC_BYTE_20_SGID_IDX_S, 0);
-
-		roce_set_field(context->byte_24_mtu_tc,
-			       V2_QPC_BYTE_24_HOP_LIMIT_M,
-			       V2_QPC_BYTE_24_HOP_LIMIT_S, grh->hop_limit);
-		roce_set_field(qpc_mask->byte_24_mtu_tc,
-			       V2_QPC_BYTE_24_HOP_LIMIT_M,
-			       V2_QPC_BYTE_24_HOP_LIMIT_S, 0);
-
-		if (hr_dev->pci_dev->revision == 0x21 &&
-		    gid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-			roce_set_field(context->byte_24_mtu_tc,
-				       V2_QPC_BYTE_24_TC_M, V2_QPC_BYTE_24_TC_S,
-				       grh->traffic_class >> 2);
-		else
-			roce_set_field(context->byte_24_mtu_tc,
-				       V2_QPC_BYTE_24_TC_M, V2_QPC_BYTE_24_TC_S,
-				       grh->traffic_class);
-		roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_TC_M,
-			       V2_QPC_BYTE_24_TC_S, 0);
-		roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
-			       V2_QPC_BYTE_28_FL_S, grh->flow_label);
-		roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_FL_M,
-			       V2_QPC_BYTE_28_FL_S, 0);
-		memcpy(context->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
-		memset(qpc_mask->dgid, 0, sizeof(grh->dgid.raw));
-		roce_set_field(context->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
-			       V2_QPC_BYTE_28_SL_S,
-			       rdma_ah_get_sl(&attr->ah_attr));
-		roce_set_field(qpc_mask->byte_28_at_fl, V2_QPC_BYTE_28_SL_M,
-			       V2_QPC_BYTE_28_SL_S, 0);
-		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+		ret = hns_roce_v2_set_path(ibqp, attr, attr_mask, context,
+					   qpc_mask);
+		if (ret)
+			return ret;
 	}
 
 	if (attr_mask & IB_QP_TIMEOUT) {
@@ -4158,7 +4143,8 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 				       V2_QPC_BYTE_28_AT_M, V2_QPC_BYTE_28_AT_S,
 				       0);
 		} else {
-			dev_warn(dev, "Local ACK timeout shall be 0 to 30.\n");
+			dev_warn(hr_dev->dev,
+				 "Local ACK timeout shall be 0 to 30.\n");
 		}
 	}
 
@@ -4196,6 +4182,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 			       V2_QPC_BYTE_244_RNR_CNT_S, 0);
 	}
 
+	/* RC&UC&UD required attr */
 	if (attr_mask & IB_QP_SQ_PSN) {
 		roce_set_field(context->byte_172_sq_psn,
 			       V2_QPC_BYTE_172_SQ_CUR_PSN_M,
@@ -4295,6 +4282,83 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 		hr_qp->qkey = attr->qkey;
 	}
 
+	return ret;
+}
+
+static void hns_roce_v2_record_opt_fields(struct ib_qp *ibqp,
+					  const struct ib_qp_attr *attr,
+					  int attr_mask)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+
+	if (attr_mask & IB_QP_ACCESS_FLAGS)
+		hr_qp->atomic_rd_en = attr->qp_access_flags;
+
+	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
+		hr_qp->resp_depth = attr->max_dest_rd_atomic;
+	if (attr_mask & IB_QP_PORT) {
+		hr_qp->port = attr->port_num - 1;
+		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
+	}
+}
+
+static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
+				 const struct ib_qp_attr *attr,
+				 int attr_mask, enum ib_qp_state cur_state,
+				 enum ib_qp_state new_state)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct hns_roce_v2_qp_context *context;
+	struct hns_roce_v2_qp_context *qpc_mask;
+	struct device *dev = hr_dev->dev;
+	int ret = -EINVAL;
+
+	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
+	if (!context)
+		return -ENOMEM;
+
+	qpc_mask = context + 1;
+	/*
+	 * In v2 engine, software pass context and context mask to hardware
+	 * when modifying qp. If software need modify some fields in context,
+	 * we should set all bits of the relevant fields in context mask to
+	 * 0 at the same time, else set them to 0x1.
+	 */
+	memset(qpc_mask, 0xff, sizeof(*qpc_mask));
+	ret = hns_roce_v2_set_abs_fields(ibqp, attr, attr_mask, cur_state,
+					 new_state, context, qpc_mask);
+	if (ret)
+		goto out;
+
+	/* When QP state is err, SQ and RQ WQE should be flushed */
+	if (new_state == IB_QPS_ERR) {
+		roce_set_field(context->byte_160_sq_ci_pi,
+			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
+			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S,
+			       hr_qp->sq.head);
+		roce_set_field(qpc_mask->byte_160_sq_ci_pi,
+			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_M,
+			       V2_QPC_BYTE_160_SQ_PRODUCER_IDX_S, 0);
+
+		if (!ibqp->srq) {
+			roce_set_field(context->byte_84_rq_ci_pi,
+			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
+			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S,
+			       hr_qp->rq.head);
+			roce_set_field(qpc_mask->byte_84_rq_ci_pi,
+			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
+			       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
+		}
+	}
+
+	/* Configure the optional fields */
+	ret = hns_roce_v2_set_opt_fields(ibqp, attr, attr_mask, context,
+					 qpc_mask);
+	if (ret)
+		goto out;
+
 	roce_set_bit(context->byte_108_rx_reqepsn, V2_QPC_BYTE_108_INV_CREDIT_S,
 		     ibqp->srq ? 1 : 0);
 	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
@@ -4316,15 +4380,7 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
 
 	hr_qp->state = new_state;
 
-	if (attr_mask & IB_QP_ACCESS_FLAGS)
-		hr_qp->atomic_rd_en = attr->qp_access_flags;
-
-	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC)
-		hr_qp->resp_depth = attr->max_dest_rd_atomic;
-	if (attr_mask & IB_QP_PORT) {
-		hr_qp->port = attr->port_num - 1;
-		hr_qp->phy_port = hr_dev->iboe.phy_port[hr_qp->port];
-	}
+	hns_roce_v2_record_opt_fields(ibqp, attr, attr_mask);
 
 	if (new_state == IB_QPS_RESET && !ibqp->uobject) {
 		hns_roce_v2_cq_clean(to_hr_cq(ibqp->recv_cq), hr_qp->qpn,
-- 
1.9.1

