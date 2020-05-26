Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32F61A6605
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 13:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgDML6Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 07:58:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727907AbgDML6V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 07:58:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81EF83785452A375314A;
        Mon, 13 Apr 2020 19:58:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:58:11 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 4/6] RDMA/hns: Support 0 hop addressing for WQE buffer
Date:   Mon, 13 Apr 2020 19:58:09 +0800
Message-ID: <1586779091-51410-5-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
References: <1586779091-51410-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Add the zero hop addressing support by using new mtr interface for WQE
buffer and simple mtr invoking process, so WQE buffer can support hopnum
between 0 to 3.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |   4 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  80 ++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  36 +++---
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 182 +++++++---------------------
 4 files changed, 106 insertions(+), 196 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 39577c2..5df4ee3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -681,7 +681,6 @@ struct hns_roce_work {
 
 struct hns_roce_qp {
 	struct ib_qp		ibqp;
-	struct hns_roce_buf	hr_buf;
 	struct hns_roce_wq	rq;
 	struct hns_roce_db	rdb;
 	struct hns_roce_db	sdb;
@@ -691,10 +690,7 @@ struct hns_roce_qp {
 	u32			sq_signal_bits;
 	struct hns_roce_wq	sq;
 
-	struct ib_umem		*umem;
-	struct hns_roce_mtt	mtt;
 	struct hns_roce_mtr	mtr;
-	int                     wqe_bt_pg_shift;
 
 	u32			buff_size;
 	struct mutex		mutex;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 4b54906..ddf2a45 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -2479,7 +2479,6 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 }
 
 static int hns_roce_v1_qp_modify(struct hns_roce_dev *hr_dev,
-				 struct hns_roce_mtt *mtt,
 				 enum hns_roce_qp_state cur_state,
 				 enum hns_roce_qp_state new_state,
 				 struct hns_roce_qp_context *context,
@@ -2560,6 +2559,29 @@ static int hns_roce_v1_qp_modify(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static int find_wqe_mtt(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			u64 *sq_ba, u64 *rq_ba, dma_addr_t *bt_ba)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int rq_pa_start;
+	int count;
+
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, sq_ba, 1, bt_ba);
+	if (count < 1) {
+		ibdev_err(ibdev, "Failed to find SQ ba\n");
+		return -ENOBUFS;
+	}
+	rq_pa_start = hr_qp->rq.offset >> hr_qp->mtr.hem_cfg.buf_pg_shift;
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, rq_pa_start, rq_ba, 1,
+				  NULL);
+	if (!count) {
+		ibdev_err(ibdev, "Failed to find RQ ba\n");
+		return -ENOBUFS;
+	}
+
+	return 0;
+}
+
 static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			     int attr_mask, enum ib_qp_state cur_state,
 			     enum ib_qp_state new_state)
@@ -2567,25 +2589,20 @@ static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct hns_roce_sqp_context *context;
-	struct device *dev = &hr_dev->pdev->dev;
 	dma_addr_t dma_handle = 0;
 	u32 __iomem *addr;
-	int rq_pa_start;
+	u64 sq_ba = 0;
+	u64 rq_ba = 0;
 	__le32 tmp;
 	u32 reg_val;
-	u64 *mtts;
 
 	context = kzalloc(sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
 
 	/* Search QP buf's MTTs */
-	mtts = hns_roce_table_find(hr_dev, &hr_dev->mr_table.mtt_table,
-				   hr_qp->mtt.first_seg, &dma_handle);
-	if (!mtts) {
-		dev_err(dev, "qp buf pa find failed\n");
+	if (find_wqe_mtt(hr_dev, hr_qp, &sq_ba, &rq_ba, &dma_handle))
 		goto out;
-	}
 
 	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		roce_set_field(context->qp1c_bytes_4,
@@ -2599,11 +2616,11 @@ static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		roce_set_field(context->qp1c_bytes_4, QP1C_BYTES_4_PD_M,
 			       QP1C_BYTES_4_PD_S, to_hr_pd(ibqp->pd)->pdn);
 
-		context->sq_rq_bt_l = cpu_to_le32((u32)(dma_handle));
+		context->sq_rq_bt_l = cpu_to_le32(dma_handle);
 		roce_set_field(context->qp1c_bytes_12,
 			       QP1C_BYTES_12_SQ_RQ_BT_H_M,
 			       QP1C_BYTES_12_SQ_RQ_BT_H_S,
-			       ((u32)(dma_handle >> 32)));
+			       upper_32_bits(dma_handle));
 
 		roce_set_field(context->qp1c_bytes_16, QP1C_BYTES_16_RQ_HEAD_M,
 			       QP1C_BYTES_16_RQ_HEAD_S, hr_qp->rq.head);
@@ -2624,14 +2641,12 @@ static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		roce_set_field(context->qp1c_bytes_20, QP1C_BYTES_20_PKEY_IDX_M,
 			       QP1C_BYTES_20_PKEY_IDX_S, attr->pkey_index);
 
-		rq_pa_start = (u32)hr_qp->rq.offset / PAGE_SIZE;
-		context->cur_rq_wqe_ba_l =
-				cpu_to_le32((u32)(mtts[rq_pa_start]));
+		context->cur_rq_wqe_ba_l = cpu_to_le32(rq_ba);
 
 		roce_set_field(context->qp1c_bytes_28,
 			       QP1C_BYTES_28_CUR_RQ_WQE_BA_H_M,
 			       QP1C_BYTES_28_CUR_RQ_WQE_BA_H_S,
-			       (mtts[rq_pa_start]) >> 32);
+			       upper_32_bits(rq_ba));
 		roce_set_field(context->qp1c_bytes_28,
 			       QP1C_BYTES_28_RQ_CUR_IDX_M,
 			       QP1C_BYTES_28_RQ_CUR_IDX_S, 0);
@@ -2645,12 +2660,12 @@ static int hns_roce_v1_m_sqp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			       QP1C_BYTES_32_TX_CQ_NUM_S,
 			       to_hr_cq(ibqp->send_cq)->cqn);
 
-		context->cur_sq_wqe_ba_l  = cpu_to_le32((u32)mtts[0]);
+		context->cur_sq_wqe_ba_l = cpu_to_le32(sq_ba);
 
 		roce_set_field(context->qp1c_bytes_40,
 			       QP1C_BYTES_40_CUR_SQ_WQE_BA_H_M,
 			       QP1C_BYTES_40_CUR_SQ_WQE_BA_H_S,
-			       (mtts[0]) >> 32);
+			       upper_32_bits(sq_ba));
 		roce_set_field(context->qp1c_bytes_40,
 			       QP1C_BYTES_40_SQ_CUR_IDX_M,
 			       QP1C_BYTES_40_SQ_CUR_IDX_S, 0);
@@ -2716,10 +2731,10 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 	dma_addr_t dma_handle_2 = 0;
 	dma_addr_t dma_handle = 0;
 	__le32 doorbell[2] = {0};
-	int rq_pa_start = 0;
 	u64 *mtts_2 = NULL;
 	int ret = -EINVAL;
-	u64 *mtts = NULL;
+	u64 sq_ba = 0;
+	u64 rq_ba = 0;
 	int port;
 	u8 port_num;
 	u8 *dmac;
@@ -2730,12 +2745,8 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		return -ENOMEM;
 
 	/* Search qp buf's mtts */
-	mtts = hns_roce_table_find(hr_dev, &hr_dev->mr_table.mtt_table,
-				   hr_qp->mtt.first_seg, &dma_handle);
-	if (mtts == NULL) {
-		dev_err(dev, "qp buf pa find failed\n");
+	if (find_wqe_mtt(hr_dev, hr_qp, &sq_ba, &rq_ba, &dma_handle))
 		goto out;
-	}
 
 	/* Search IRRL's mtts */
 	mtts_2 = hns_roce_table_find(hr_dev, &hr_dev->qp_table.irrl_table,
@@ -2890,11 +2901,11 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 
 		dmac = (u8 *)attr->ah_attr.roce.dmac;
 
-		context->sq_rq_bt_l = cpu_to_le32((u32)(dma_handle));
+		context->sq_rq_bt_l = cpu_to_le32(dma_handle);
 		roce_set_field(context->qpc_bytes_24,
 			       QP_CONTEXT_QPC_BYTES_24_SQ_RQ_BT_H_M,
 			       QP_CONTEXT_QPC_BYTES_24_SQ_RQ_BT_H_S,
-			       ((u32)(dma_handle >> 32)));
+			       upper_32_bits(dma_handle));
 		roce_set_bit(context->qpc_bytes_24,
 			     QP_CONTEXT_QPC_BYTE_24_REMOTE_ENABLE_E2E_CREDITS_S,
 			     1);
@@ -2993,14 +3004,12 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			       QP_CONTEXT_QPC_BYTES_68_RQ_CUR_INDEX_M,
 			       QP_CONTEXT_QPC_BYTES_68_RQ_CUR_INDEX_S, 0);
 
-		rq_pa_start = (u32)hr_qp->rq.offset / PAGE_SIZE;
-		context->cur_rq_wqe_ba_l =
-				cpu_to_le32((u32)(mtts[rq_pa_start]));
+		context->cur_rq_wqe_ba_l = cpu_to_le32(rq_ba);
 
 		roce_set_field(context->qpc_bytes_76,
 			QP_CONTEXT_QPC_BYTES_76_CUR_RQ_WQE_BA_H_M,
 			QP_CONTEXT_QPC_BYTES_76_CUR_RQ_WQE_BA_H_S,
-			mtts[rq_pa_start] >> 32);
+			upper_32_bits(rq_ba));
 		roce_set_field(context->qpc_bytes_76,
 			       QP_CONTEXT_QPC_BYTES_76_RX_REQ_MSN_M,
 			       QP_CONTEXT_QPC_BYTES_76_RX_REQ_MSN_S, 0);
@@ -3075,12 +3084,12 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			goto out;
 		}
 
-		context->rx_cur_sq_wqe_ba_l = cpu_to_le32((u32)(mtts[0]));
+		context->rx_cur_sq_wqe_ba_l = cpu_to_le32(sq_ba);
 
 		roce_set_field(context->qpc_bytes_120,
 			       QP_CONTEXT_QPC_BYTES_120_RX_CUR_SQ_WQE_BA_H_M,
 			       QP_CONTEXT_QPC_BYTES_120_RX_CUR_SQ_WQE_BA_H_S,
-			       (mtts[0]) >> 32);
+			       upper_32_bits(sq_ba));
 
 		roce_set_field(context->qpc_bytes_124,
 			       QP_CONTEXT_QPC_BYTES_124_RX_ACK_MSN_M,
@@ -3223,12 +3232,12 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 			       QP_CONTEXT_QPC_BYTES_180_SQ_HEAD_M,
 			       QP_CONTEXT_QPC_BYTES_180_SQ_HEAD_S, 0);
 
-		context->tx_cur_sq_wqe_ba_l = cpu_to_le32((u32)(mtts[0]));
+		context->tx_cur_sq_wqe_ba_l = cpu_to_le32(sq_ba);
 
 		roce_set_field(context->qpc_bytes_188,
 			       QP_CONTEXT_QPC_BYTES_188_TX_CUR_SQ_WQE_BA_H_M,
 			       QP_CONTEXT_QPC_BYTES_188_TX_CUR_SQ_WQE_BA_H_S,
-			       (mtts[0]) >> 32);
+			       upper_32_bits(sq_ba));
 		roce_set_bit(context->qpc_bytes_188,
 			     QP_CONTEXT_QPC_BYTES_188_PKT_RETRY_FLG_S, 0);
 		roce_set_field(context->qpc_bytes_188,
@@ -3253,8 +3262,7 @@ static int hns_roce_v1_m_qp(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
 		       QP_CONTEXT_QPC_BYTES_144_QP_STATE_S, new_state);
 
 	/* SW pass context to HW */
-	ret = hns_roce_v1_qp_modify(hr_dev, &hr_qp->mtt,
-				    to_hns_roce_state(cur_state),
+	ret = hns_roce_v1_qp_modify(hr_dev, to_hns_roce_state(cur_state),
 				    to_hns_roce_state(new_state), context,
 				    hr_qp);
 	if (ret) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 335a637..42bca0a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -164,7 +164,7 @@ static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
 		num_in_wqe = HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE;
 	extend_sge_num = valid_num_sge - num_in_wqe;
 	sg = wr->sg_list + num_in_wqe;
-	shift = qp->hr_buf.page_shift;
+	shift = qp->mtr.hem_cfg.buf_pg_shift;
 
 	/*
 	 * Check whether wr->num_sge sges are in the same page. If not, we
@@ -3757,7 +3757,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	int port;
 
 	/* Search qp buf's mtts */
-	page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
+	page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
 	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
 				  hr_qp->rq.offset / page_size, mtts,
 				  MTT_MIN_COUNT, &wqe_sge_ba);
@@ -3831,7 +3831,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(context->byte_16_buf_ba_pg_sz,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S,
-		       hr_qp->wqe_bt_pg_shift + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.ba_pg_shift));
 	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BA_PG_SZ_S, 0);
@@ -3839,29 +3839,29 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(context->byte_16_buf_ba_pg_sz,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S,
-		       hr_dev->caps.mtt_buf_pg_sz + PG_SHIFT_OFFSET);
+		       to_hr_hw_page_shift(hr_qp->mtr.hem_cfg.buf_pg_shift));
 	roce_set_field(qpc_mask->byte_16_buf_ba_pg_sz,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_M,
 		       V2_QPC_BYTE_16_WQE_SGE_BUF_PG_SZ_S, 0);
 
-	context->rq_cur_blk_addr = cpu_to_le32(mtts[0] >> PAGE_ADDR_SHIFT);
+	context->rq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 	qpc_mask->rq_cur_blk_addr = 0;
 
 	roce_set_field(context->byte_92_srq_info,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S,
-		       mtts[0] >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(mtts[0])));
 	roce_set_field(qpc_mask->byte_92_srq_info,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_92_RQ_CUR_BLK_ADDR_S, 0);
 
-	context->rq_nxt_blk_addr = cpu_to_le32(mtts[1] >> PAGE_ADDR_SHIFT);
+	context->rq_nxt_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
 	qpc_mask->rq_nxt_blk_addr = 0;
 
 	roce_set_field(context->byte_104_rq_sge,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S,
-		       mtts[1] >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(mtts[1])));
 	roce_set_field(qpc_mask->byte_104_rq_sge,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S, 0);
@@ -3995,18 +3995,18 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	/* Search qp buf's mtts */
 	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
 	if (count < 1) {
-		ibdev_err(ibdev, "failed to find buf pa of QP(0x%lx)\n",
+		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf\n",
 			  hr_qp->qpn);
 		return -EINVAL;
 	}
 
 	if (hr_qp->sge.offset) {
-		page_size = 1 << (hr_dev->caps.mtt_buf_pg_sz + PAGE_SHIFT);
+		page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
 		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
 					  hr_qp->sge.offset / page_size,
 					  &sge_cur_blk, 1, NULL);
 		if (count < 1) {
-			ibdev_err(ibdev, "failed to find sge pa of QP(0x%lx)\n",
+			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf\n",
 				  hr_qp->qpn);
 			return -EINVAL;
 		}
@@ -4024,11 +4024,11 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	 * we should set all bits of the relevant fields in context mask to
 	 * 0 at the same time, else set them to 0x1.
 	 */
-	context->sq_cur_blk_addr = cpu_to_le32(sq_cur_blk >> PAGE_ADDR_SHIFT);
+	context->sq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
 	roce_set_field(context->byte_168_irrl_idx,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S,
-		       sq_cur_blk >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
 	qpc_mask->sq_cur_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_168_irrl_idx,
 		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
@@ -4036,26 +4036,24 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 
 	context->sq_cur_sge_blk_addr = ((ibqp->qp_type == IB_QPT_GSI) ||
 		       hr_qp->sq.max_gs > HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       cpu_to_le32(sge_cur_blk >>
-		       PAGE_ADDR_SHIFT) : 0;
+		       cpu_to_le32(to_hr_hw_page_addr(sge_cur_blk)) : 0;
 	roce_set_field(context->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
 		       ((ibqp->qp_type == IB_QPT_GSI) || hr_qp->sq.max_gs >
 		       HNS_ROCE_V2_UC_RC_SGE_NUM_IN_WQE) ?
-		       (sge_cur_blk >>
-		       (32 + PAGE_ADDR_SHIFT)) : 0);
+		       upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)) : 0);
 	qpc_mask->sq_cur_sge_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_184_irrl_idx,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
 		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S, 0);
 
 	context->rx_sq_cur_blk_addr =
-		cpu_to_le32(sq_cur_blk >> PAGE_ADDR_SHIFT);
+		cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
 	roce_set_field(context->byte_232_irrl_sge,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S,
-		       sq_cur_blk >> (32 + PAGE_ADDR_SHIFT));
+		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
 	qpc_mask->rx_sq_cur_blk_addr = 0;
 	roce_set_field(qpc_mask->byte_232_irrl_sge,
 		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 1667f37..d05d3cb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -512,63 +512,57 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 
 static int split_wqe_buf_region(struct hns_roce_dev *hr_dev,
 				struct hns_roce_qp *hr_qp,
-				struct hns_roce_buf_region *regions,
-				int region_max, int page_shift)
+				struct hns_roce_buf_attr *buf_attr)
 {
-	int page_size = 1 << page_shift;
 	bool is_extend_sge;
-	int region_cnt = 0;
 	int buf_size;
-	int buf_cnt;
+	int idx = 0;
 
-	if (hr_qp->buff_size < 1 || region_max < 1)
-		return region_cnt;
+	if (hr_qp->buff_size < 1)
+		return -EINVAL;
+
+	buf_attr->page_shift = PAGE_ADDR_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
+	buf_attr->fixed_page = true;
+	buf_attr->region_count = 0;
 
 	if (hr_qp->sge.sge_cnt > 0)
 		is_extend_sge = true;
 	else
 		is_extend_sge = false;
 
-	/* sq region */
+	/* SQ WQE */
 	if (is_extend_sge)
 		buf_size = hr_qp->sge.offset - hr_qp->sq.offset;
 	else
 		buf_size = hr_qp->rq.offset - hr_qp->sq.offset;
 
-	if (buf_size > 0 && region_cnt < region_max) {
-		buf_cnt = DIV_ROUND_UP(buf_size, page_size);
-		hns_roce_init_buf_region(&regions[region_cnt],
-					 hr_dev->caps.wqe_sq_hop_num,
-					 hr_qp->sq.offset / page_size,
-					 buf_cnt);
-		region_cnt++;
+	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
+		buf_attr->region[idx].size = buf_size;
+		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_sq_hop_num;
+		idx++;
 	}
 
-	/* sge region */
-	if (is_extend_sge) {
-		buf_size = hr_qp->rq.offset - hr_qp->sge.offset;
-		if (buf_size > 0 && region_cnt < region_max) {
-			buf_cnt = DIV_ROUND_UP(buf_size, page_size);
-			hns_roce_init_buf_region(&regions[region_cnt],
-						 hr_dev->caps.wqe_sge_hop_num,
-						 hr_qp->sge.offset / page_size,
-						 buf_cnt);
-			region_cnt++;
-		}
+	/* extend SGE in SQ WQE */
+	buf_size = hr_qp->rq.offset - hr_qp->sge.offset;
+	if (buf_size > 0 && is_extend_sge &&
+	    idx < ARRAY_SIZE(buf_attr->region)) {
+		buf_attr->region[idx].size = buf_size;
+		buf_attr->region[idx].hopnum =
+					hr_dev->caps.wqe_sge_hop_num;
+		idx++;
 	}
 
-	/* rq region */
+	/* RQ WQE */
 	buf_size = hr_qp->buff_size - hr_qp->rq.offset;
-	if (buf_size > 0) {
-		buf_cnt = DIV_ROUND_UP(buf_size, page_size);
-		hns_roce_init_buf_region(&regions[region_cnt],
-					 hr_dev->caps.wqe_rq_hop_num,
-					 hr_qp->rq.offset / page_size,
-					 buf_cnt);
-		region_cnt++;
+	if (buf_size > 0 && idx < ARRAY_SIZE(buf_attr->region)) {
+		buf_attr->region[idx].size = buf_size;
+		buf_attr->region[idx].hopnum = hr_dev->caps.wqe_rq_hop_num;
+		idx++;
 	}
 
-	return region_cnt;
+	buf_attr->region_count = idx;
+
+	return 0;
 }
 
 static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
@@ -731,72 +725,12 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 	kfree(hr_qp->rq_inl_buf.wqe_list);
 }
 
-static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
-		       u32 page_shift, bool is_user)
-{
-/* WQE buffer include 3 parts: SQ, extend SGE and RQ. */
-#define HNS_ROCE_WQE_REGION_MAX	 3
-	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX] = {};
-	dma_addr_t *buf_list[HNS_ROCE_WQE_REGION_MAX] = {};
-	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_buf_region *r;
-	int region_count;
-	int buf_count;
-	int ret;
-	int i;
-
-	region_count = split_wqe_buf_region(hr_dev, hr_qp, regions,
-					    ARRAY_SIZE(regions), page_shift);
-
-	/* alloc a tmp list to store WQE buffers address */
-	ret = hns_roce_alloc_buf_list(regions, buf_list, region_count);
-	if (ret) {
-		ibdev_err(ibdev, "Failed to alloc WQE buffer list\n");
-		return ret;
-	}
-
-	for (i = 0; i < region_count; i++) {
-		r = &regions[i];
-		if (is_user)
-			buf_count = hns_roce_get_umem_bufs(hr_dev, buf_list[i],
-					r->count, r->offset, hr_qp->umem,
-					page_shift);
-		else
-			buf_count = hns_roce_get_kmem_bufs(hr_dev, buf_list[i],
-					r->count, r->offset, &hr_qp->hr_buf);
-
-		if (buf_count != r->count) {
-			ibdev_err(ibdev, "Failed to get %s WQE buf, expect %d = %d.\n",
-				  is_user ? "user" : "kernel",
-				  r->count, buf_count);
-			ret = -ENOBUFS;
-			goto done;
-		}
-	}
-
-	hr_qp->wqe_bt_pg_shift = hr_dev->caps.mtt_ba_pg_sz;
-	hns_roce_mtr_init(&hr_qp->mtr, PAGE_SHIFT + hr_qp->wqe_bt_pg_shift,
-			  page_shift);
-	ret = hns_roce_mtr_attach(hr_dev, &hr_qp->mtr, buf_list, regions,
-				  region_count);
-	if (ret)
-		ibdev_err(ibdev, "Failed to attach WQE's mtr\n");
-
-	goto done;
-
-	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
-done:
-	hns_roce_free_buf_list(buf_list, region_count);
-
-	return ret;
-}
-
 static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct ib_qp_init_attr *init_attr,
 			struct ib_udata *udata, unsigned long addr)
 {
-	u32 page_shift = PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_buf_attr buf_attr = {};
 	bool is_rq_buf_inline;
 	int ret;
 
@@ -810,54 +744,30 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		}
 	}
 
-	if (udata) {
-		hr_qp->umem = ib_umem_get(ibdev, addr, hr_qp->buff_size, 0);
-		if (IS_ERR(hr_qp->umem)) {
-			ret = PTR_ERR(hr_qp->umem);
-			goto err_inline;
-		}
-	} else {
-		ret = hns_roce_buf_alloc(hr_dev, hr_qp->buff_size,
-					 (1 << page_shift) * 2,
-					 &hr_qp->hr_buf, page_shift);
-		if (ret)
-			goto err_inline;
+	ret = split_wqe_buf_region(hr_dev, hr_qp, &buf_attr);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to split WQE buf, ret %d\n", ret);
+		goto err_inline;
+	}
+	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
+				  PAGE_ADDR_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
+				  udata, addr);
+	if (ret) {
+		ibdev_err(ibdev, "Failed to create WQE mtr, ret %d\n", ret);
+		goto err_inline;
 	}
-
-	ret = map_wqe_buf(hr_dev, hr_qp, page_shift, udata);
-	if (ret)
-		goto err_alloc;
 
 	return 0;
-
 err_inline:
 	if (is_rq_buf_inline)
 		free_rq_inline_buf(hr_qp);
 
-err_alloc:
-	if (udata) {
-		ib_umem_release(hr_qp->umem);
-		hr_qp->umem = NULL;
-	} else {
-		hns_roce_buf_free(hr_dev, &hr_qp->hr_buf);
-	}
-
-	ibdev_err(ibdev, "Failed to alloc WQE buffer, ret %d.\n", ret);
-
 	return ret;
 }
 
 static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
-	hns_roce_mtr_cleanup(hr_dev, &hr_qp->mtr);
-	if (hr_qp->umem) {
-		ib_umem_release(hr_qp->umem);
-		hr_qp->umem = NULL;
-	}
-
-	if (hr_qp->hr_buf.npages > 0)
-		hns_roce_buf_free(hr_dev, &hr_qp->hr_buf);
-
+	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
 	if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_RQ_INLINE) &&
 	     hr_qp->rq.wqe_cnt)
 		free_rq_inline_buf(hr_qp);
@@ -1431,10 +1341,9 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 	}
 }
 
-static void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
+static inline void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
 {
-
-	return hns_roce_buf_offset(&hr_qp->hr_buf, offset);
+	return hns_roce_buf_offset(hr_qp->mtr.kmem, offset);
 }
 
 void *hns_roce_get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
@@ -1449,8 +1358,7 @@ void *hns_roce_get_send_wqe(struct hns_roce_qp *hr_qp, int n)
 
 void *hns_roce_get_extend_sge(struct hns_roce_qp *hr_qp, int n)
 {
-	return hns_roce_buf_offset(&hr_qp->hr_buf, hr_qp->sge.offset +
-					(n << hr_qp->sge.sge_shift));
+	return get_wqe(hr_qp, hr_qp->sge.offset + (n << hr_qp->sge.sge_shift));
 }
 
 bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
-- 
2.8.1

