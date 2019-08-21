Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8697A84
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfHUNR5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:17:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbfHUNR4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:17:56 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E4FF647B4B2BD5F482DC;
        Wed, 21 Aug 2019 21:17:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 21 Aug 2019 21:17:47 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 5/9] RDMA/hns: Fix cast from or to restricted __le32 for driver
Date:   Wed, 21 Aug 2019 21:14:32 +0800
Message-ID: <1566393276-42555-6-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Sparse is whining about the u32 and __le32 mixed usage in the driver.
The roce_set_field() is used to __le32 data of hardware only.
If a variable is not delivered to the hardware, the __le32 type and
related operations are not required.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c    |  34 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  37 ++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 141 ++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   7 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   8 +-
 6 files changed, 105 insertions(+), 126 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 5eb7134..96d1302 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -657,7 +657,7 @@ struct hns_roce_qp {
 	u8			rdb_en;
 	u8			sdb_en;
 	u32			doorbell_qpn;
-	__le32			sq_signal_bits;
+	u32			sq_signal_bits;
 	u32			sq_next_wqe;
 	struct hns_roce_wq	sq;
 
@@ -712,7 +712,7 @@ enum {
 };
 
 struct hns_roce_ceqe {
-	u32			comp;
+	__le32			comp;
 };
 
 struct hns_roce_aeqe {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index f2c4fef..e822157 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -368,9 +368,9 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 	unsigned long flags;
 	struct hns_roce_hem_iter iter;
 	void __iomem *bt_cmd;
-	u32 bt_cmd_h_val = 0;
-	u32 bt_cmd_val[2];
-	u32 bt_cmd_l = 0;
+	__le32 bt_cmd_val[2];
+	__le32 bt_cmd_h = 0;
+	__le32 bt_cmd_l = 0;
 	u64 bt_ba = 0;
 	int ret = 0;
 
@@ -380,30 +380,20 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 
 	switch (table->type) {
 	case HEM_TYPE_QPC:
-		roce_set_field(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, HEM_TYPE_QPC);
-		break;
 	case HEM_TYPE_MTPT:
-		roce_set_field(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S,
-			       HEM_TYPE_MTPT);
-		break;
 	case HEM_TYPE_CQC:
-		roce_set_field(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, HEM_TYPE_CQC);
-		break;
 	case HEM_TYPE_SRQC:
-		roce_set_field(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S,
-			       HEM_TYPE_SRQC);
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
+			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
 		break;
 	default:
 		return ret;
 	}
-	roce_set_field(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
+
+	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
 		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
-	roce_set_bit(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
-	roce_set_bit(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
 
 	/* Currently iter only a chunk */
 	for (hns_roce_hem_first(table->hem[i], &iter);
@@ -429,13 +419,13 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 			return -EBUSY;
 		}
 
-		bt_cmd_l = (u32)bt_ba;
-		roce_set_field(bt_cmd_h_val, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
+		bt_cmd_l = cpu_to_le32(bt_ba);
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
 			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
 			       bt_ba >> BT_BA_SHIFT);
 
 		bt_cmd_val[0] = bt_cmd_l;
-		bt_cmd_val[1] = bt_cmd_h_val;
+		bt_cmd_val[1] = bt_cmd_h;
 		hns_roce_write64_k(bt_cmd_val,
 				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
 		spin_unlock_irqrestore(lock, flags);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 73d17a3..ec6ffe6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -73,7 +73,7 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 	int ps_opcode = 0, i = 0;
 	unsigned long flags = 0;
 	void *wqe = NULL;
-	u32 doorbell[2];
+	__le32 doorbell[2];
 	int nreq = 0;
 	u32 ind = 0;
 	int ret = 0;
@@ -332,10 +332,10 @@ static int hns_roce_v1_post_send(struct ib_qp *ibqp,
 			       SQ_DOORBELL_U32_8_QPN_S, qp->doorbell_qpn);
 		roce_set_bit(sq_db.u32_8, SQ_DOORBELL_HW_SYNC_S, 1);
 
-		doorbell[0] = le32_to_cpu(sq_db.u32_4);
-		doorbell[1] = le32_to_cpu(sq_db.u32_8);
+		doorbell[0] = sq_db.u32_4;
+		doorbell[1] = sq_db.u32_8;
 
-		hns_roce_write64_k((__le32 *)doorbell, qp->sq.db_reg_l);
+		hns_roce_write64_k(doorbell, qp->sq.db_reg_l);
 		qp->sq_next_wqe = ind;
 	}
 
@@ -360,7 +360,7 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct device *dev = &hr_dev->pdev->dev;
 	struct hns_roce_rq_db rq_db;
-	uint32_t doorbell[2] = {0};
+	__le32 doorbell[2] = {0};
 
 	spin_lock_irqsave(&hr_qp->rq.lock, flags);
 	ind = hr_qp->rq.head & (hr_qp->rq.wqe_cnt - 1);
@@ -434,11 +434,10 @@ static int hns_roce_v1_post_recv(struct ib_qp *ibqp,
 			roce_set_bit(rq_db.u32_8, RQ_DOORBELL_U32_8_HW_SYNC_S,
 				     1);
 
-			doorbell[0] = le32_to_cpu(rq_db.u32_4);
-			doorbell[1] = le32_to_cpu(rq_db.u32_8);
+			doorbell[0] = rq_db.u32_4;
+			doorbell[1] = rq_db.u32_8;
 
-			hns_roce_write64_k((__le32 *)doorbell,
-					   hr_qp->rq.db_reg_l);
+			hns_roce_write64_k(doorbell, hr_qp->rq.db_reg_l);
 		}
 	}
 	spin_unlock_irqrestore(&hr_qp->rq.lock, flags);
@@ -712,7 +711,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	struct ib_cq *cq;
 	struct ib_pd *pd;
 	union ib_gid dgid;
-	u64 subnet_prefix;
+	__be64 subnet_prefix;
 	int attr_mask = 0;
 	int ret;
 	int i, j;
@@ -2160,7 +2159,7 @@ static int hns_roce_v1_req_notify_cq(struct ib_cq *ibcq,
 {
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	u32 notification_flag;
-	__le32 doorbell[2];
+	__le32 doorbell[2] = {};
 
 	notification_flag = (flags & IB_CQ_SOLICITED_MASK) ==
 			    IB_CQ_SOLICITED ? CQ_DB_REQ_NOT : CQ_DB_REQ_NOT_SOL;
@@ -2435,18 +2434,12 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 
 	switch (table->type) {
 	case HEM_TYPE_QPC:
-		roce_set_field(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, HEM_TYPE_QPC);
 		bt_ba = priv->bt_table.qpc_buf.map >> 12;
 		break;
 	case HEM_TYPE_MTPT:
-		roce_set_field(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, HEM_TYPE_MTPT);
 		bt_ba = priv->bt_table.mtpt_buf.map >> 12;
 		break;
 	case HEM_TYPE_CQC:
-		roce_set_field(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, HEM_TYPE_CQC);
 		bt_ba = priv->bt_table.cqc_buf.map >> 12;
 		break;
 	case HEM_TYPE_SRQC:
@@ -2455,6 +2448,8 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 	default:
 		return 0;
 	}
+	roce_set_field(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
+			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
 	roce_set_field(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
 		ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
 	roce_set_bit(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
@@ -2479,7 +2474,7 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 		end -= HW_SYNC_SLEEP_TIME_INTERVAL;
 	}
 
-	bt_cmd_val[0] = (__le32)bt_ba;
+	bt_cmd_val[0] = cpu_to_le32(bt_ba);
 	roce_set_field(bt_cmd_val[1], ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
 		ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S, bt_ba >> 32);
 	hns_roce_write64_k(bt_cmd_val, hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
@@ -2622,7 +2617,7 @@ static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			       QP1C_BYTES_16_PORT_NUM_S, hr_qp->phy_port);
 		roce_set_bit(context->qp1c_bytes_16,
 			     QP1C_BYTES_16_SIGNALING_TYPE_S,
-			     le32_to_cpu(hr_qp->sq_signal_bits));
+			     hr_qp->sq_signal_bits);
 		roce_set_bit(context->qp1c_bytes_16, QP1C_BYTES_16_RQ_BA_FLG_S,
 			     1);
 		roce_set_bit(context->qp1c_bytes_16, QP1C_BYTES_16_SQ_BA_FLG_S,
@@ -2928,7 +2923,7 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			     1);
 		roce_set_bit(context->qpc_bytes_32,
 			     QP_CONTEXT_QPC_BYTE_32_SIGNALING_TYPE_S,
-			     le32_to_cpu(hr_qp->sq_signal_bits));
+			     hr_qp->sq_signal_bits);
 
 		port = (attr_mask & IB_QP_PORT) ? (attr->port_num - 1) :
 			hr_qp->port;
@@ -3573,7 +3568,7 @@ static int hns_roce_v1_q_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->retry_cnt = roce_get_field(context->qpc_bytes_148,
 			     QP_CONTEXT_QPC_BYTES_148_RETRY_COUNT_M,
 			     QP_CONTEXT_QPC_BYTES_148_RETRY_COUNT_S);
-	qp_attr->rnr_retry = (u8)context->rnr_retry;
+	qp_attr->rnr_retry = (u8)le32_to_cpu(context->rnr_retry);
 
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d4c4c41..7730983 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1039,7 +1039,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	 * If the command is sync, wait for the firmware to write back,
 	 * if multi descriptors to be sent, use the first one to check
 	 */
-	if ((desc->flag) & HNS_ROCE_CMD_FLAG_NO_INTR) {
+	if (le16_to_cpu(desc->flag) & HNS_ROCE_CMD_FLAG_NO_INTR) {
 		do {
 			if (hns_roce_cmq_csq_done(hr_dev))
 				break;
@@ -1056,7 +1056,7 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 			desc_to_use = &csq->desc[ntc];
 			desc[handle] = *desc_to_use;
 			dev_dbg(hr_dev->dev, "Get cmq desc:\n");
-			desc_ret = desc[handle].retval;
+			desc_ret = le16_to_cpu(desc[handle].retval);
 			if (desc_ret == CMD_EXEC_SUCCESS)
 				ret = 0;
 			else
@@ -1119,7 +1119,7 @@ static int hns_roce_cmq_query_hw_info(struct hns_roce_dev *hr_dev)
 		return ret;
 
 	resp = (struct hns_roce_query_version *)desc.data;
-	hr_dev->hw_rev = le32_to_cpu(resp->rocee_hw_version);
+	hr_dev->hw_rev = le16_to_cpu(resp->rocee_hw_version);
 	hr_dev->vendor_id = hr_dev->pci_dev->vendor;
 
 	return 0;
@@ -1293,7 +1293,7 @@ static int hns_roce_set_vf_switch_param(struct hns_roce_dev *hr_dev,
 
 	swt = (struct hns_roce_vf_switch *)desc.data;
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_SWITCH_PARAMETER_CFG, true);
-	swt->rocee_sel |= cpu_to_le16(HNS_ICL_SWITCH_CMD_ROCEE_SEL);
+	swt->rocee_sel |= cpu_to_le32(HNS_ICL_SWITCH_CMD_ROCEE_SEL);
 	roce_set_field(swt->fun_id,
 			VF_SWITCH_DATA_FUN_ID_VF_ID_M,
 			VF_SWITCH_DATA_FUN_ID_VF_ID_S,
@@ -1719,9 +1719,10 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 			desc[i].flag &= ~cpu_to_le16(HNS_ROCE_CMD_FLAG_NEXT);
 
 		if (i == 0) {
-			req_a->base_addr_l = link_tbl->table.map & 0xffffffff;
-			req_a->base_addr_h = (link_tbl->table.map >> 32) &
-					     0xffffffff;
+			req_a->base_addr_l =
+				cpu_to_le32(link_tbl->table.map & 0xffffffff);
+			req_a->base_addr_h =
+				cpu_to_le32(link_tbl->table.map >> 32);
 			roce_set_field(req_a->depth_pgsz_init_en,
 				       CFG_LLM_QUE_DEPTH_M,
 				       CFG_LLM_QUE_DEPTH_S,
@@ -1730,13 +1731,15 @@ static int hns_roce_config_link_table(struct hns_roce_dev *hr_dev,
 				       CFG_LLM_QUE_PGSZ_M,
 				       CFG_LLM_QUE_PGSZ_S,
 				       link_tbl->pg_sz);
-			req_a->head_ba_l = entry[0].blk_ba0;
-			req_a->head_ba_h_nxtptr = entry[0].blk_ba1_nxt_ptr;
+			req_a->head_ba_l = cpu_to_le32(entry[0].blk_ba0);
+			req_a->head_ba_h_nxtptr =
+				cpu_to_le32(entry[0].blk_ba1_nxt_ptr);
 			roce_set_field(req_a->head_ptr,
 				       CFG_LLM_HEAD_PTR_M,
 				       CFG_LLM_HEAD_PTR_S, 0);
 		} else {
-			req_b->tail_ba_l = entry[page_num - 1].blk_ba0;
+			req_b->tail_ba_l =
+				cpu_to_le32(entry[page_num - 1].blk_ba0);
 			roce_set_field(req_b->tail_ba_h,
 				       CFG_LLM_TAIL_BA_H_M,
 				       CFG_LLM_TAIL_BA_H_S,
@@ -1812,17 +1815,13 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 
 		link_tbl->pg_list[i].map = t;
 
-		entry[i].blk_ba0 = (t >> 12) & 0xffffffff;
-		roce_set_field(entry[i].blk_ba1_nxt_ptr,
-			       HNS_ROCE_LINK_TABLE_BA1_M,
-			       HNS_ROCE_LINK_TABLE_BA1_S,
-			       t >> 44);
+		entry[i].blk_ba0 = (u32)(t >> 12);
+		entry[i].blk_ba1_nxt_ptr = (u32)(t >> 44);
 
 		if (i < (pg_num - 1))
-			roce_set_field(entry[i].blk_ba1_nxt_ptr,
-				       HNS_ROCE_LINK_TABLE_NXT_PTR_M,
-				       HNS_ROCE_LINK_TABLE_NXT_PTR_S,
-				       i + 1);
+			entry[i].blk_ba1_nxt_ptr |=
+				(i + 1) << HNS_ROCE_LINK_TABLE_NXT_PTR_S;
+
 	}
 	link_tbl->npages = pg_num;
 	link_tbl->pg_sz = buf_chk_sz;
@@ -1947,7 +1946,7 @@ static int hns_roce_query_mbox_status(struct hns_roce_dev *hr_dev)
 	if (status)
 		return status;
 
-	return cpu_to_le32(mb_st->mb_status_hw_run);
+	return le32_to_cpu(mb_st->mb_status_hw_run);
 }
 
 static int hns_roce_v2_cmd_pending(struct hns_roce_dev *hr_dev)
@@ -1973,10 +1972,10 @@ static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev, u64 in_param,
 
 	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_POST_MB, false);
 
-	mb->in_param_l = cpu_to_le64(in_param);
-	mb->in_param_h = cpu_to_le64(in_param) >> 32;
-	mb->out_param_l = cpu_to_le64(out_param);
-	mb->out_param_h = cpu_to_le64(out_param) >> 32;
+	mb->in_param_l = cpu_to_le32(in_param);
+	mb->in_param_h = cpu_to_le32(in_param >> 32);
+	mb->out_param_l = cpu_to_le32(out_param);
+	mb->out_param_h = cpu_to_le32(out_param >> 32);
 	mb->cmd_tag = cpu_to_le32(in_modifier << 8 | op);
 	mb->token_event_en = cpu_to_le32(event << 16 | token);
 
@@ -2118,7 +2117,7 @@ static int hns_roce_v2_set_mac(struct hns_roce_dev *hr_dev, u8 phy_port,
 	roce_set_field(smac_tb->vf_smac_h_rsv,
 		       CFG_SMAC_TB_VF_SMAC_H_M,
 		       CFG_SMAC_TB_VF_SMAC_H_S, reg_smac_h);
-	smac_tb->vf_smac_l = reg_smac_l;
+	smac_tb->vf_smac_l = cpu_to_le32(reg_smac_l);
 
 	return hns_roce_cmq_send(hr_dev, &desc, 1);
 }
@@ -2473,29 +2472,26 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_4_SHIFT_S, ilog2((unsigned int)nent));
 	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_CEQN_M,
 		       V2_CQC_BYTE_4_CEQN_S, vector);
-	cq_context->byte_4_pg_ceqn = cpu_to_le32(cq_context->byte_4_pg_ceqn);
 
 	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQN_M,
 		       V2_CQC_BYTE_8_CQN_S, hr_cq->cqn);
 
-	cq_context->cqe_cur_blk_addr = (u32)(mtts[0] >> PAGE_ADDR_SHIFT);
-	cq_context->cqe_cur_blk_addr =
-				cpu_to_le32(cq_context->cqe_cur_blk_addr);
+	cq_context->cqe_cur_blk_addr = cpu_to_le32(mtts[0] >> PAGE_ADDR_SHIFT);
 
 	roce_set_field(cq_context->byte_16_hop_addr,
 		       V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M,
 		       V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S,
-		       cpu_to_le32((mtts[0]) >> (32 + PAGE_ADDR_SHIFT)));
+		       mtts[0] >> (32 + PAGE_ADDR_SHIFT));
 	roce_set_field(cq_context->byte_16_hop_addr,
 		       V2_CQC_BYTE_16_CQE_HOP_NUM_M,
 		       V2_CQC_BYTE_16_CQE_HOP_NUM_S, hr_dev->caps.cqe_hop_num ==
 		       HNS_ROCE_HOP_NUM_0 ? 0 : hr_dev->caps.cqe_hop_num);
 
-	cq_context->cqe_nxt_blk_addr = (u32)(mtts[1] >> PAGE_ADDR_SHIFT);
+	cq_context->cqe_nxt_blk_addr = cpu_to_le32(mtts[1] >> PAGE_ADDR_SHIFT);
 	roce_set_field(cq_context->byte_24_pgsz_addr,
 		       V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_M,
 		       V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_S,
-		       cpu_to_le32((mtts[1]) >> (32 + PAGE_ADDR_SHIFT)));
+		       mtts[1] >> (32 + PAGE_ADDR_SHIFT));
 	roce_set_field(cq_context->byte_24_pgsz_addr,
 		       V2_CQC_BYTE_24_CQE_BA_PG_SZ_M,
 		       V2_CQC_BYTE_24_CQE_BA_PG_SZ_S,
@@ -2505,7 +2501,7 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_24_CQE_BUF_PG_SZ_S,
 		       hr_dev->caps.cqe_buf_pg_sz + PG_SHIFT_OFFSET);
 
-	cq_context->cqe_ba = (u32)(dma_handle >> 3);
+	cq_context->cqe_ba = cpu_to_le32(dma_handle >> 3);
 
 	roce_set_field(cq_context->byte_40_cqe_ba, V2_CQC_BYTE_40_CQE_BA_M,
 		       V2_CQC_BYTE_40_CQE_BA_S, (dma_handle >> (32 + 3)));
@@ -2518,7 +2514,7 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_44_DB_RECORD_ADDR_M,
 		       V2_CQC_BYTE_44_DB_RECORD_ADDR_S,
 		       ((u32)hr_cq->db.dma) >> 1);
-	cq_context->db_record_addr = hr_cq->db.dma >> 32;
+	cq_context->db_record_addr = cpu_to_le32(hr_cq->db.dma >> 32);
 
 	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
 		       V2_CQC_BYTE_56_CQ_MAX_CNT_M,
@@ -2536,7 +2532,7 @@ static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibcq->device);
 	struct hns_roce_cq *hr_cq = to_hr_cq(ibcq);
 	u32 notification_flag;
-	u32 doorbell[2];
+	__le32 doorbell[2];
 
 	doorbell[0] = 0;
 	doorbell[1] = 0;
@@ -2663,9 +2659,9 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		++wq->tail;
 	} else if ((*cur_qp)->ibqp.srq) {
 		srq = to_hr_srq((*cur_qp)->ibqp.srq);
-		wqe_ctr = le16_to_cpu(roce_get_field(cqe->byte_4,
-						     V2_CQE_BYTE_4_WQE_INDX_M,
-						     V2_CQE_BYTE_4_WQE_INDX_S));
+		wqe_ctr = (u16)roce_get_field(cqe->byte_4,
+					      V2_CQE_BYTE_4_WQE_INDX_M,
+					      V2_CQE_BYTE_4_WQE_INDX_S);
 		wc->wr_id = srq->wrid[wqe_ctr];
 		hns_roce_free_srq_wqe(srq, wqe_ctr);
 	} else {
@@ -3240,7 +3236,7 @@ static void modify_qp_reset_to_init(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_68_rq_db,
 		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_M,
 		       V2_QPC_BYTE_68_RQ_DB_RECORD_ADDR_S, 0);
-	context->rq_db_record_addr = hr_qp->rdb.dma >> 32;
+	context->rq_db_record_addr = cpu_to_le32(hr_qp->rdb.dma >> 32);
 	qpc_mask->rq_db_record_addr = 0;
 
 	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RQIE_S,
@@ -3623,7 +3619,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	}
 
 	dmac = (u8 *)attr->ah_attr.roce.dmac;
-	context->wqe_sge_ba = (u32)(wqe_sge_ba >> 3);
+	context->wqe_sge_ba = cpu_to_le32(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
 
 	/*
@@ -3679,7 +3675,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S, 0);
 
-	context->rq_cur_blk_addr = (u32)(mtts[0] >> PAGE_ADDR_SHIFT);
+	context->rq_cur_blk_addr = cpu_to_le32(mtts[0] >> PAGE_ADDR_SHIFT);
 	qpc_mask->rq_cur_blk_addr = 0;
 
 	roce_set_field(context->byte_92_srq_info,
@@ -3690,7 +3686,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S, 0);
 
-	context->rq_nxt_blk_addr = (u32)(mtts[1] >> PAGE_ADDR_SHIFT);
+	context->rq_nxt_blk_addr = cpu_to_le32(mtts[1] >> PAGE_ADDR_SHIFT);
 	qpc_mask->rq_nxt_blk_addr = 0;
 
 	roce_set_field(context->byte_104_rq_sge,
@@ -3705,7 +3701,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_132_TRRL_BA_S, dma_handle_3 >> 4);
 	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_BA_M,
 		       V2_QPC_BYTE_132_TRRL_BA_S, 0);
-	context->trrl_ba = (u32)(dma_handle_3 >> (16 + 4));
+	context->trrl_ba = cpu_to_le32(dma_handle_3 >> (16 + 4));
 	qpc_mask->trrl_ba = 0;
 	roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
 		       V2_QPC_BYTE_140_TRRL_BA_S,
@@ -3713,7 +3709,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
 		       V2_QPC_BYTE_140_TRRL_BA_S, 0);
 
-	context->irrl_ba = (u32)(dma_handle_2 >> 6);
+	context->irrl_ba = cpu_to_le32(dma_handle_2 >> 6);
 	qpc_mask->irrl_ba = 0;
 	roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
 		       V2_QPC_BYTE_208_IRRL_BA_S,
@@ -3861,7 +3857,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	context->sq_cur_blk_addr = (u32)(sq_cur_blk >> PAGE_ADDR_SHIFT);
+	context->sq_cur_blk_addr = cpu_to_le32(sq_cur_blk >> PAGE_ADDR_SHIFT);
 	roce_set_field(context->byte_168_irrl_idx,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S,
@@ -3873,8 +3869,8 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 
 	context->sq_cur_sge_blk_addr = ((ibqp->qp_type == IB_QPT_GSI) ||
 		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       ((u32)(sge_cur_blk >>
-		       PAGE_ADDR_SHIFT)) : 0;
+		       cpu_to_le32(sge_cur_blk >>
+		       PAGE_ADDR_SHIFT) : 0;
 	roce_set_field(context->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
@@ -3887,7 +3883,8 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S, 0);
 
-	context->rx_sq_cur_blk_addr = (u32)(sq_cur_blk >> PAGE_ADDR_SHIFT);
+	context->rx_sq_cur_blk_addr =
+		cpu_to_le32(sq_cur_blk >> PAGE_ADDR_SHIFT);
 	roce_set_field(context->byte_232_irrl_sge,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S,
@@ -4262,7 +4259,7 @@ static int hns_roce_v2_set_opt_fields(struct ib_qp *ibqp,
 	}
 
 	if (attr_mask & IB_QP_QKEY) {
-		context->qkey_xrcd = attr->qkey;
+		context->qkey_xrcd = cpu_to_le32(attr->qkey);
 		qpc_mask->qkey_xrcd = 0;
 		hr_qp->qkey = attr->qkey;
 	}
@@ -4531,7 +4528,7 @@ static int hns_roce_v2_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 	qp_attr->retry_cnt = roce_get_field(context.byte_212_lsn,
 					    V2_QPC_BYTE_212_RETRY_CNT_M,
 					    V2_QPC_BYTE_212_RETRY_CNT_S);
-	qp_attr->rnr_retry = context.rq_rnr_timer;
+	qp_attr->rnr_retry = le32_to_cpu(context.rq_rnr_timer);
 
 done:
 	qp_attr->cur_qp_state = qp_attr->qp_state;
@@ -4860,7 +4857,7 @@ static void hns_roce_v2_init_irq_work(struct hns_roce_dev *hr_dev,
 static void set_eq_cons_index_v2(struct hns_roce_eq *eq)
 {
 	struct hns_roce_dev *hr_dev = eq->hr_dev;
-	u32 doorbell[2];
+	__le32 doorbell[2];
 
 	doorbell[0] = 0;
 	doorbell[1] = 0;
@@ -5125,14 +5122,14 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 	int_st = roce_read(hr_dev, ROCEE_VF_ABN_INT_ST_REG);
 	int_en = roce_read(hr_dev, ROCEE_VF_ABN_INT_EN_REG);
 
-	if (roce_get_bit(int_st, HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S)) {
+	if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S)) {
 		struct pci_dev *pdev = hr_dev->pci_dev;
 		struct hnae3_ae_dev *ae_dev = pci_get_drvdata(pdev);
 		const struct hnae3_ae_ops *ops = ae_dev->ops;
 
 		dev_err(dev, "AEQ overflow!\n");
 
-		roce_set_bit(int_st, HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S, 1);
+		int_st |= 1 << HNS_ROCE_V2_VF_INT_ST_AEQ_OVERFLOW_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG, int_st);
 
 		/* Set reset level for reset_event() */
@@ -5142,27 +5139,27 @@ static irqreturn_t hns_roce_v2_msix_interrupt_abn(int irq, void *dev_id)
 		if (ops->reset_event)
 			ops->reset_event(pdev, NULL);
 
-		roce_set_bit(int_en, HNS_ROCE_V2_VF_ABN_INT_EN_S, 1);
+		int_en |= 1 << HNS_ROCE_V2_VF_ABN_INT_EN_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
 
 		int_work = 1;
-	} else if (roce_get_bit(int_st,	HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S)) {
+	} else if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S)) {
 		dev_err(dev, "BUS ERR!\n");
 
-		roce_set_bit(int_st, HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S, 1);
+		int_st |= 1 << HNS_ROCE_V2_VF_INT_ST_BUS_ERR_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG, int_st);
 
-		roce_set_bit(int_en, HNS_ROCE_V2_VF_ABN_INT_EN_S, 1);
+		int_en |= 1 << HNS_ROCE_V2_VF_ABN_INT_EN_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
 
 		int_work = 1;
-	} else if (roce_get_bit(int_st,	HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S)) {
+	} else if (int_st & BIT(HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S)) {
 		dev_err(dev, "OTHER ERR!\n");
 
-		roce_set_bit(int_st, HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S, 1);
+		int_st |= 1 << HNS_ROCE_V2_VF_INT_ST_OTHER_ERR_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_ST_REG, int_st);
 
-		roce_set_bit(int_en, HNS_ROCE_V2_VF_ABN_INT_EN_S, 1);
+		int_en |= 1 << HNS_ROCE_V2_VF_ABN_INT_EN_S;
 		roce_write(hr_dev, ROCEE_VF_ABN_INT_EN_REG, int_en);
 
 		int_work = 1;
@@ -5972,7 +5969,7 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(srq_context->byte_24_wqe_bt_ba,
 		       SRQC_BYTE_24_SRQ_WQE_BT_BA_M,
 		       SRQC_BYTE_24_SRQ_WQE_BT_BA_S,
-		       cpu_to_le32(dma_handle_wqe >> 35));
+		       dma_handle_wqe >> 35);
 
 	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_PD_M,
 		       SRQC_BYTE_28_PD_S, pdn);
@@ -5980,20 +5977,18 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       SRQC_BYTE_28_RQWS_S, srq->max_gs <= 0 ? 0 :
 		       fls(srq->max_gs - 1));
 
-	srq_context->idx_bt_ba = (u32)(dma_handle_idx >> 3);
-	srq_context->idx_bt_ba = cpu_to_le32(srq_context->idx_bt_ba);
+	srq_context->idx_bt_ba = cpu_to_le32(dma_handle_idx >> 3);
 	roce_set_field(srq_context->rsv_idx_bt_ba,
 		       SRQC_BYTE_36_SRQ_IDX_BT_BA_M,
 		       SRQC_BYTE_36_SRQ_IDX_BT_BA_S,
-		       cpu_to_le32(dma_handle_idx >> 35));
+		       dma_handle_idx >> 35);
 
-	srq_context->idx_cur_blk_addr = (u32)(mtts_idx[0] >> PAGE_ADDR_SHIFT);
 	srq_context->idx_cur_blk_addr =
-				     cpu_to_le32(srq_context->idx_cur_blk_addr);
+		cpu_to_le32(mtts_idx[0] >> PAGE_ADDR_SHIFT);
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_M,
 		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_S,
-		       cpu_to_le32((mtts_idx[0]) >> (32 + PAGE_ADDR_SHIFT)));
+		       mtts_idx[0] >> (32 + PAGE_ADDR_SHIFT));
 	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
 		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M,
 		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S,
@@ -6009,13 +6004,12 @@ static void hns_roce_v2_write_srqc(struct hns_roce_dev *hr_dev,
 		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
 		       hr_dev->caps.idx_buf_pg_sz);
 
-	srq_context->idx_nxt_blk_addr = (u32)(mtts_idx[1] >> PAGE_ADDR_SHIFT);
 	srq_context->idx_nxt_blk_addr =
-				   cpu_to_le32(srq_context->idx_nxt_blk_addr);
+		cpu_to_le32(mtts_idx[1] >> PAGE_ADDR_SHIFT);
 	roce_set_field(srq_context->rsv_idxnxtblkaddr,
 		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_M,
 		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_S,
-		       cpu_to_le32((mtts_idx[1]) >> (32 + PAGE_ADDR_SHIFT)));
+		       mtts_idx[1] >> (32 + PAGE_ADDR_SHIFT));
 	roce_set_field(srq_context->byte_56_xrc_cqn,
 		       SRQC_BYTE_56_SRQ_XRC_CQN_M, SRQC_BYTE_56_SRQ_XRC_CQN_S,
 		       cqn);
@@ -6209,9 +6203,10 @@ static int hns_roce_v2_post_srq_recv(struct ib_srq *ibsrq,
 		 */
 		wmb();
 
-		srq_db.byte_4 = HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
-				(srq->srqn & V2_DB_BYTE_4_TAG_M);
-		srq_db.parameter = srq->head;
+		srq_db.byte_4 =
+			cpu_to_le32(HNS_ROCE_V2_SRQ_DB << V2_DB_BYTE_4_CMD_S |
+				    (srq->srqn & V2_DB_BYTE_4_TAG_M));
+		srq_db.parameter = cpu_to_le32(srq->head);
 
 		hns_roce_write64(hr_dev, (__le32 *)&srq_db, srq->db_reg_l);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 8157679..5f8416b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -1426,7 +1426,7 @@ static int hns_roce_set_page(struct ib_mr *ibmr, u64 addr)
 {
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 
-	mr->pbl_buf[mr->npages++] = cpu_to_le64(addr);
+	mr->pbl_buf[mr->npages++] = addr;
 
 	return 0;
 }
@@ -1597,10 +1597,9 @@ static int hns_roce_write_mtr(struct hns_roce_dev *hr_dev,
 		/* Save page addr, low 12 bits : 0 */
 		for (i = 0; i < count; i++) {
 			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
-				mtts[i] = cpu_to_le64(bufs[npage] >>
-							PAGE_ADDR_SHIFT);
+				mtts[i] = bufs[npage] >> PAGE_ADDR_SHIFT;
 			else
-				mtts[i] = cpu_to_le64(bufs[npage]);
+				mtts[i] = bufs[npage];
 
 			npage++;
 		}
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7e10820..ca0e2b7 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -690,7 +690,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				     struct ib_udata *udata, unsigned long sqpn,
 				     struct hns_roce_qp *hr_qp)
 {
-	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { 0 };
+	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
 	struct device *dev = hr_dev->dev;
 	struct hns_roce_ib_create_qp ucmd;
 	struct hns_roce_ib_create_qp_resp resp = {};
@@ -712,9 +712,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	hr_qp->ibqp.qp_type = init_attr->qp_type;
 
 	if (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR)
-		hr_qp->sq_signal_bits = cpu_to_le32(IB_SIGNAL_ALL_WR);
+		hr_qp->sq_signal_bits = IB_SIGNAL_ALL_WR;
 	else
-		hr_qp->sq_signal_bits = cpu_to_le32(IB_SIGNAL_REQ_WR);
+		hr_qp->sq_signal_bits = IB_SIGNAL_REQ_WR;
 
 	ret = hns_roce_set_rq_size(hr_dev, &init_attr->cap, udata,
 				   hns_roce_qp_has_rq(init_attr), hr_qp);
@@ -937,7 +937,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	if (sqpn)
 		hr_qp->doorbell_qpn = 1;
 	else
-		hr_qp->doorbell_qpn = cpu_to_le64(hr_qp->qpn);
+		hr_qp->doorbell_qpn = (u32)hr_qp->qpn;
 
 	if (udata) {
 		ret = ib_copy_to_udata(udata, &resp,
-- 
2.8.1

