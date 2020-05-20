Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3CE1DB5AE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgETNxw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 09:53:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4829 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726853AbgETNxv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 09:53:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6857E1FA37C3D629A25E;
        Wed, 20 May 2020 21:53:48 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 21:53:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 8/9] RDMA/hns: Refactor the QP context filling process related to WQE buffer configure
Date:   Wed, 20 May 2020 21:53:18 +0800
Message-ID: <1589982799-28728-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
References: <1589982799-28728-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Split the code related to WQE buffer configure from the QPC filling
process into two functions: config_qp_sq_buf() and config_qp_rq_buf(), this
will make the code more readable.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 264 ++++++++++++++++-------------
 1 file changed, 149 insertions(+), 115 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 3d5ba9a..db9fd6c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3782,27 +3782,16 @@ static bool check_wqe_rq_mtt_count(struct hns_roce_dev *hr_dev,
 	return true;
 }
 
-static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
-				 const struct ib_qp_attr *attr, int attr_mask,
-				 struct hns_roce_v2_qp_context *context,
-				 struct hns_roce_v2_qp_context *qpc_mask)
+static int config_qp_rq_buf(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp,
+			    struct hns_roce_v2_qp_context *context,
+			    struct hns_roce_v2_qp_context *qpc_mask)
 {
-	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
-	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
-	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct ib_qp *ibqp = &hr_qp->ibqp;
 	u64 mtts[MTT_MIN_COUNT] = { 0 };
-	dma_addr_t dma_handle_3;
-	dma_addr_t dma_handle_2;
 	u64 wqe_sge_ba;
 	u32 page_size;
-	u8 port_num;
-	u64 *mtts_3;
-	u64 *mtts_2;
 	int count;
-	u8 *dmac;
-	u8 *smac;
-	int port;
 
 	/* Search qp buf's mtts */
 	page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
@@ -3813,29 +3802,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		if (!check_wqe_rq_mtt_count(hr_dev, hr_qp, count, page_size))
 			return -EINVAL;
 
-	/* Search IRRL's mtts */
-	mtts_2 = hns_roce_table_find(hr_dev, &hr_dev->qp_table.irrl_table,
-				     hr_qp->qpn, &dma_handle_2);
-	if (!mtts_2) {
-		ibdev_err(ibdev, "failed to find QP irrl_table\n");
-		return -EINVAL;
-	}
-
-	/* Search TRRL's mtts */
-	mtts_3 = hns_roce_table_find(hr_dev, &hr_dev->qp_table.trrl_table,
-				     hr_qp->qpn, &dma_handle_3);
-	if (!mtts_3) {
-		ibdev_err(ibdev, "failed to find QP trrl_table\n");
-		return -EINVAL;
-	}
-
-	if (attr_mask & IB_QP_ALT_PATH) {
-		ibdev_err(ibdev, "INIT2RTR attr_mask (0x%x) error\n",
-			  attr_mask);
-		return -EINVAL;
-	}
-
-	dmac = (u8 *)attr->ah_attr.roce.dmac;
 	context->wqe_sge_ba = cpu_to_le32(wqe_sge_ba >> 3);
 	qpc_mask->wqe_sge_ba = 0;
 
@@ -3914,23 +3880,154 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_M,
 		       V2_QPC_BYTE_104_RQ_NXT_BLK_ADDR_S, 0);
 
+	roce_set_field(context->byte_84_rq_ci_pi,
+		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
+		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, hr_qp->rq.head);
+	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
+		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
+		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
+
+	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
+		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_M,
+		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_S, 0);
+
+	return 0;
+}
+
+static int config_qp_sq_buf(struct hns_roce_dev *hr_dev,
+			    struct hns_roce_qp *hr_qp,
+			    struct hns_roce_v2_qp_context *context,
+			    struct hns_roce_v2_qp_context *qpc_mask)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	u64 sge_cur_blk = 0;
+	u64 sq_cur_blk = 0;
+	u32 page_size;
+	int count;
+
+	/* search qp buf's mtts */
+	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
+	if (count < 1) {
+		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf.\n",
+			  hr_qp->qpn);
+		return -EINVAL;
+	}
+	if (hr_qp->sge.sge_cnt > 0) {
+		page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
+		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
+					  hr_qp->sge.offset / page_size,
+					  &sge_cur_blk, 1, NULL);
+		if (count < 1) {
+			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf.\n",
+				  hr_qp->qpn);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * In v2 engine, software pass context and context mask to hardware
+	 * when modifying qp. If software need modify some fields in context,
+	 * we should set all bits of the relevant fields in context mask to
+	 * 0 at the same time, else set them to 0x1.
+	 */
+	context->sq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
+	roce_set_field(context->byte_168_irrl_idx,
+		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
+		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S,
+		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
+	qpc_mask->sq_cur_blk_addr = 0;
+	roce_set_field(qpc_mask->byte_168_irrl_idx,
+		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
+		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S, 0);
+
+	context->sq_cur_sge_blk_addr =
+		cpu_to_le32(to_hr_hw_page_addr(sge_cur_blk));
+	roce_set_field(context->byte_184_irrl_idx,
+		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
+		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
+		       upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)));
+	qpc_mask->sq_cur_sge_blk_addr = 0;
+	roce_set_field(qpc_mask->byte_184_irrl_idx,
+		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
+		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S, 0);
+
+	context->rx_sq_cur_blk_addr =
+		cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
+	roce_set_field(context->byte_232_irrl_sge,
+		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
+		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S,
+		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
+	qpc_mask->rx_sq_cur_blk_addr = 0;
+	roce_set_field(qpc_mask->byte_232_irrl_sge,
+		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
+		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S, 0);
+
+	return 0;
+}
+
+static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
+				 const struct ib_qp_attr *attr, int attr_mask,
+				 struct hns_roce_v2_qp_context *context,
+				 struct hns_roce_v2_qp_context *qpc_mask)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
+	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	dma_addr_t trrl_ba;
+	dma_addr_t irrl_ba;
+	u8 port_num;
+	u64 *mtts;
+	u8 *dmac;
+	u8 *smac;
+	int port;
+	int ret;
+
+	ret = config_qp_rq_buf(hr_dev, hr_qp, context, qpc_mask);
+	if (ret) {
+		ibdev_err(ibdev, "failed to config rq buf, ret = %d.\n", ret);
+		return ret;
+	}
+
+	/* Search IRRL's mtts */
+	mtts = hns_roce_table_find(hr_dev, &hr_dev->qp_table.irrl_table,
+				   hr_qp->qpn, &irrl_ba);
+	if (!mtts) {
+		ibdev_err(ibdev, "failed to find qp irrl_table.\n");
+		return -EINVAL;
+	}
+
+	/* Search TRRL's mtts */
+	mtts = hns_roce_table_find(hr_dev, &hr_dev->qp_table.trrl_table,
+				   hr_qp->qpn, &trrl_ba);
+	if (!mtts) {
+		ibdev_err(ibdev, "failed to find qp trrl_table.\n");
+		return -EINVAL;
+	}
+
+	if (attr_mask & IB_QP_ALT_PATH) {
+		ibdev_err(ibdev, "INIT2RTR attr_mask (0x%x) error.\n",
+			  attr_mask);
+		return -EINVAL;
+	}
+
 	roce_set_field(context->byte_132_trrl, V2_QPC_BYTE_132_TRRL_BA_M,
-		       V2_QPC_BYTE_132_TRRL_BA_S, dma_handle_3 >> 4);
+		       V2_QPC_BYTE_132_TRRL_BA_S, trrl_ba >> 4);
 	roce_set_field(qpc_mask->byte_132_trrl, V2_QPC_BYTE_132_TRRL_BA_M,
 		       V2_QPC_BYTE_132_TRRL_BA_S, 0);
-	context->trrl_ba = cpu_to_le32(dma_handle_3 >> (16 + 4));
+	context->trrl_ba = cpu_to_le32(trrl_ba >> (16 + 4));
 	qpc_mask->trrl_ba = 0;
 	roce_set_field(context->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
 		       V2_QPC_BYTE_140_TRRL_BA_S,
-		       (u32)(dma_handle_3 >> (32 + 16 + 4)));
+		       (u32)(trrl_ba >> (32 + 16 + 4)));
 	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
 		       V2_QPC_BYTE_140_TRRL_BA_S, 0);
 
-	context->irrl_ba = cpu_to_le32(dma_handle_2 >> 6);
+	context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
 	qpc_mask->irrl_ba = 0;
 	roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
 		       V2_QPC_BYTE_208_IRRL_BA_S,
-		       dma_handle_2 >> (32 + 6));
+		       irrl_ba >> (32 + 6));
 	roce_set_field(qpc_mask->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
 		       V2_QPC_BYTE_208_IRRL_BA_S, 0);
 
@@ -3967,6 +4064,8 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 					 grh->sgid_index));
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S, 0);
+
+	dmac = (u8 *)attr->ah_attr.roce.dmac;
 	memcpy(&(context->dmac), dmac, sizeof(u32));
 	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, *((u16 *)(&dmac[4])));
@@ -3991,16 +4090,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_24_mtu_tc, V2_QPC_BYTE_24_MTU_M,
 		       V2_QPC_BYTE_24_MTU_S, 0);
 
-	roce_set_field(context->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, hr_qp->rq.head);
-	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_PRODUCER_IDX_S, 0);
-
-	roce_set_field(qpc_mask->byte_84_rq_ci_pi,
-		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_M,
-		       V2_QPC_BYTE_84_RQ_CONSUMER_IDX_S, 0);
 	roce_set_bit(qpc_mask->byte_108_rx_reqepsn,
 		     V2_QPC_BYTE_108_RX_REQ_PSN_ERR_S, 0);
 	roce_set_field(qpc_mask->byte_96_rx_reqmsn, V2_QPC_BYTE_96_RX_REQ_MSN_M,
@@ -4036,30 +4125,7 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	u64 sge_cur_blk = 0;
-	u64 sq_cur_blk = 0;
-	u32 page_size;
-	int count;
-
-	/* Search qp buf's mtts */
-	count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr, 0, &sq_cur_blk, 1, NULL);
-	if (count < 1) {
-		ibdev_err(ibdev, "failed to find QP(0x%lx) SQ buf\n",
-			  hr_qp->qpn);
-		return -EINVAL;
-	}
-
-	if (hr_qp->sge.sge_cnt > 0) {
-		page_size = 1 << hr_qp->mtr.hem_cfg.buf_pg_shift;
-		count = hns_roce_mtr_find(hr_dev, &hr_qp->mtr,
-					  hr_qp->sge.offset / page_size,
-					  &sge_cur_blk, 1, NULL);
-		if (count < 1) {
-			ibdev_err(ibdev, "failed to find QP(0x%lx) SGE buf\n",
-				  hr_qp->qpn);
-			return -EINVAL;
-		}
-	}
+	int ret;
 
 	/* Not support alternate path and path migration */
 	if (attr_mask & (IB_QP_ALT_PATH | IB_QP_PATH_MIG_STATE)) {
@@ -4067,43 +4133,11 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 		return -EINVAL;
 	}
 
-	/*
-	 * In v2 engine, software pass context and context mask to hardware
-	 * when modifying qp. If software need modify some fields in context,
-	 * we should set all bits of the relevant fields in context mask to
-	 * 0 at the same time, else set them to 0x1.
-	 */
-	context->sq_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
-	roce_set_field(context->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
-	qpc_mask->sq_cur_blk_addr = 0;
-	roce_set_field(qpc_mask->byte_168_irrl_idx,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_168_SQ_CUR_BLK_ADDR_S, 0);
-
-	context->sq_cur_sge_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(sge_cur_blk));
-	roce_set_field(context->byte_184_irrl_idx,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(sge_cur_blk)));
-	qpc_mask->sq_cur_sge_blk_addr = 0;
-	roce_set_field(qpc_mask->byte_184_irrl_idx,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_M,
-		       V2_QPC_BYTE_184_SQ_CUR_SGE_BLK_ADDR_S, 0);
-
-	context->rx_sq_cur_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(sq_cur_blk));
-	roce_set_field(context->byte_232_irrl_sge,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(sq_cur_blk)));
-	qpc_mask->rx_sq_cur_blk_addr = 0;
-	roce_set_field(qpc_mask->byte_232_irrl_sge,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_M,
-		       V2_QPC_BYTE_232_RX_SQ_CUR_BLK_ADDR_S, 0);
+	ret = config_qp_sq_buf(hr_dev, hr_qp, context, qpc_mask);
+	if (ret) {
+		ibdev_err(ibdev, "failed to config sq buf, ret %d\n", ret);
+		return ret;
+	}
 
 	/*
 	 * Set some fields in context to zero, Because the default values
-- 
2.8.1

