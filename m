Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3531530934E
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jan 2021 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhA3JYd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jan 2021 04:24:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12366 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhA3JYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jan 2021 04:24:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DSSnF6jr3z7d93;
        Sat, 30 Jan 2021 16:59:13 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 30 Jan 2021 17:00:24 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 08/12] RDMA/hns: Use new interfaces to write SRQC
Date:   Sat, 30 Jan 2021 16:58:06 +0800
Message-ID: <1611997090-48820-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
References: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Use new register operation interfaces to simplify the process of write SRQ
Context.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 160 ++++++++++++-----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  69 ++++++++++---
 2 files changed, 118 insertions(+), 111 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index dd5f7b5..105019c5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5227,19 +5227,59 @@ static int hns_roce_v2_qp_flow_control_init(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+static int hns_roce_v2_write_srqc_index_queue(struct hns_roce_srq *srq,
+					      struct hns_roce_srq_context *ctx)
+{
+	struct hns_roce_idx_que *idx_que = &srq->idx_que;
+	struct ib_device *ibdev = srq->ibsrq.device;
+	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
+	u64 mtts_idx[MTT_MIN_COUNT] = {};
+	dma_addr_t dma_handle_idx = 0;
+	int ret;
+
+	/* Get physical address of idx que buf */
+	ret = hns_roce_mtr_find(hr_dev, &idx_que->mtr, 0, mtts_idx,
+				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
+	if (ret < 1) {
+		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
+			  ret);
+		return -ENOBUFS;
+	}
+
+	hr_reg_write(ctx, SRQC_IDX_HOP_NUM,
+		     to_hr_hem_hopnum(hr_dev->caps.idx_hop_num, srq->wqe_cnt));
+
+	hr_reg_write(ctx, SRQC_IDX_BT_BA_L, dma_handle_idx >> 3);
+	hr_reg_write(ctx, SRQC_IDX_BT_BA_H, upper_32_bits(dma_handle_idx >> 3));
+
+	hr_reg_write(ctx, SRQC_IDX_BA_PG_SZ,
+		     to_hr_hw_page_shift(idx_que->mtr.hem_cfg.ba_pg_shift));
+	hr_reg_write(ctx, SRQC_IDX_BUF_PG_SZ,
+		     to_hr_hw_page_shift(idx_que->mtr.hem_cfg.buf_pg_shift));
+
+	hr_reg_write(ctx, SRQC_IDX_CUR_BLK_ADDR_L,
+		     to_hr_hw_page_addr(mtts_idx[0]));
+	hr_reg_write(ctx, SRQC_IDX_CUR_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(mtts_idx[0])));
+
+	hr_reg_write(ctx, SRQC_IDX_NXT_BLK_ADDR_L,
+		     to_hr_hw_page_addr(mtts_idx[1]));
+	hr_reg_write(ctx, SRQC_IDX_NXT_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(mtts_idx[1])));
+
+	return 0;
+}
+
 static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 {
 	struct ib_device *ibdev = srq->ibsrq.device;
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibdev);
-	struct hns_roce_srq_context *srq_context;
+	struct hns_roce_srq_context *ctx = mb_buf;
 	u64 mtts_wqe[MTT_MIN_COUNT] = {};
-	u64 mtts_idx[MTT_MIN_COUNT] = {};
 	dma_addr_t dma_handle_wqe = 0;
-	dma_addr_t dma_handle_idx = 0;
 	int ret;
 
-	srq_context = mb_buf;
-	memset(srq_context, 0, sizeof(*srq_context));
+	memset(ctx, 0, sizeof(*ctx));
 
 	/* Get the physical address of srq buf */
 	ret = hns_roce_mtr_find(hr_dev, &srq->buf_mtr, 0, mtts_wqe,
@@ -5250,98 +5290,28 @@ static int hns_roce_v2_write_srqc(struct hns_roce_srq *srq, void *mb_buf)
 		return -ENOBUFS;
 	}
 
-	/* Get physical address of idx que buf */
-	ret = hns_roce_mtr_find(hr_dev, &srq->idx_que.mtr, 0, mtts_idx,
-				ARRAY_SIZE(mtts_idx), &dma_handle_idx);
-	if (ret < 1) {
-		ibdev_err(ibdev, "failed to find mtr for SRQ idx, ret = %d.\n",
-			  ret);
-		return -ENOBUFS;
-	}
+	hr_reg_write(ctx, SRQC_SRQ_ST, 1);
+	hr_reg_write(ctx, SRQC_PD, to_hr_pd(srq->ibsrq.pd)->pdn);
+	hr_reg_write(ctx, SRQC_SRQN, srq->srqn);
+	hr_reg_write(ctx, SRQC_XRCD, 0);
+	hr_reg_write(ctx, SRQC_XRC_CQN, srq->cqn);
+	hr_reg_write(ctx, SRQC_SHIFT, ilog2(srq->wqe_cnt));
+	hr_reg_write(ctx, SRQC_RQWS,
+		     srq->max_gs <= 0 ? 0 : fls(srq->max_gs - 1));
 
-	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQ_ST_M,
-		       SRQC_BYTE_4_SRQ_ST_S, 1);
-
-	roce_set_field(srq_context->byte_4_srqn_srqst,
-		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_M,
-		       SRQC_BYTE_4_SRQ_WQE_HOP_NUM_S,
-		       to_hr_hem_hopnum(hr_dev->caps.srqwqe_hop_num,
-					srq->wqe_cnt));
-	roce_set_field(srq_context->byte_4_srqn_srqst,
-		       SRQC_BYTE_4_SRQ_SHIFT_M, SRQC_BYTE_4_SRQ_SHIFT_S,
-		       ilog2(srq->wqe_cnt));
-
-	roce_set_field(srq_context->byte_4_srqn_srqst, SRQC_BYTE_4_SRQN_M,
-		       SRQC_BYTE_4_SRQN_S, srq->srqn);
-
-	roce_set_field(srq_context->byte_8_limit_wl, SRQC_BYTE_8_SRQ_LIMIT_WL_M,
-		       SRQC_BYTE_8_SRQ_LIMIT_WL_S, 0);
-
-	roce_set_field(srq_context->byte_12_xrcd, SRQC_BYTE_12_SRQ_XRCD_M,
-		       SRQC_BYTE_12_SRQ_XRCD_S, 0);
-
-	srq_context->wqe_bt_ba = cpu_to_le32((u32)(dma_handle_wqe >> 3));
-
-	roce_set_field(srq_context->byte_24_wqe_bt_ba,
-		       SRQC_BYTE_24_SRQ_WQE_BT_BA_M,
-		       SRQC_BYTE_24_SRQ_WQE_BT_BA_S,
-		       dma_handle_wqe >> 35);
-
-	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_PD_M,
-		       SRQC_BYTE_28_PD_S, to_hr_pd(srq->ibsrq.pd)->pdn);
-	roce_set_field(srq_context->byte_28_rqws_pd, SRQC_BYTE_28_RQWS_M,
-		       SRQC_BYTE_28_RQWS_S, srq->max_gs <= 0 ? 0 :
-		       fls(srq->max_gs - 1));
-
-	srq_context->idx_bt_ba = cpu_to_le32(dma_handle_idx >> 3);
-	roce_set_field(srq_context->rsv_idx_bt_ba,
-		       SRQC_BYTE_36_SRQ_IDX_BT_BA_M,
-		       SRQC_BYTE_36_SRQ_IDX_BT_BA_S,
-		       dma_handle_idx >> 35);
-
-	srq_context->idx_cur_blk_addr =
-		cpu_to_le32(to_hr_hw_page_addr(mtts_idx[0]));
-	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
-		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_M,
-		       SRQC_BYTE_44_SRQ_IDX_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[0])));
-	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
-		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_M,
-		       SRQC_BYTE_44_SRQ_IDX_HOP_NUM_S,
-		       to_hr_hem_hopnum(hr_dev->caps.idx_hop_num,
-					srq->wqe_cnt));
-
-	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
-		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_M,
-		       SRQC_BYTE_44_SRQ_IDX_BA_PG_SZ_S,
-		to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(srq_context->byte_44_idxbufpgsz_addr,
-		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_M,
-		       SRQC_BYTE_44_SRQ_IDX_BUF_PG_SZ_S,
-		to_hr_hw_page_shift(srq->idx_que.mtr.hem_cfg.buf_pg_shift));
-
-	srq_context->idx_nxt_blk_addr =
-				cpu_to_le32(to_hr_hw_page_addr(mtts_idx[1]));
-	roce_set_field(srq_context->rsv_idxnxtblkaddr,
-		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_M,
-		       SRQC_BYTE_52_SRQ_IDX_NXT_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts_idx[1])));
-	roce_set_field(srq_context->byte_56_xrc_cqn,
-		       SRQC_BYTE_56_SRQ_XRC_CQN_M, SRQC_BYTE_56_SRQ_XRC_CQN_S,
-		       srq->cqn);
-	roce_set_field(srq_context->byte_56_xrc_cqn,
-		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_M,
-		       SRQC_BYTE_56_SRQ_WQE_BA_PG_SZ_S,
-		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(srq_context->byte_56_xrc_cqn,
-		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_M,
-		       SRQC_BYTE_56_SRQ_WQE_BUF_PG_SZ_S,
-		       to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.buf_pg_shift));
-
-	roce_set_bit(srq_context->db_record_addr_record_en,
-		     SRQC_BYTE_60_SRQ_RECORD_EN_S, 0);
+	hr_reg_write(ctx, SRQC_WQE_HOP_NUM,
+		     to_hr_hem_hopnum(hr_dev->caps.srqwqe_hop_num,
+				      srq->wqe_cnt));
 
-	return 0;
+	hr_reg_write(ctx, SRQC_WQE_BT_BA_L, dma_handle_wqe >> 3);
+	hr_reg_write(ctx, SRQC_WQE_BT_BA_H, upper_32_bits(dma_handle_wqe >> 3));
+
+	hr_reg_write(ctx, SRQC_WQE_BA_PG_SZ,
+		     to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.ba_pg_shift));
+	hr_reg_write(ctx, SRQC_WQE_BUF_PG_SZ,
+		     to_hr_hw_page_shift(srq->buf_mtr.hem_cfg.buf_pg_shift));
+
+	return hns_roce_v2_write_srqc_index_queue(srq, ctx);
 }
 
 static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cd9abdd..e46c935 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -367,24 +367,61 @@ struct hns_roce_v2_cq_context {
 #define CQC_STASH CQC_FIELD_LOC(63, 63)
 
 struct hns_roce_srq_context {
-	__le32	byte_4_srqn_srqst;
-	__le32	byte_8_limit_wl;
-	__le32	byte_12_xrcd;
-	__le32	byte_16_pi_ci;
-	__le32	wqe_bt_ba;
-	__le32	byte_24_wqe_bt_ba;
-	__le32	byte_28_rqws_pd;
-	__le32	idx_bt_ba;
-	__le32	rsv_idx_bt_ba;
-	__le32	idx_cur_blk_addr;
-	__le32	byte_44_idxbufpgsz_addr;
-	__le32	idx_nxt_blk_addr;
-	__le32	rsv_idxnxtblkaddr;
-	__le32	byte_56_xrc_cqn;
-	__le32	db_record_addr_record_en;
-	__le32	db_record_addr;
+	__le32 byte_4_srqn_srqst;
+	__le32 byte_8_limit_wl;
+	__le32 byte_12_xrcd;
+	__le32 byte_16_pi_ci;
+	__le32 wqe_bt_ba;
+	__le32 byte_24_wqe_bt_ba;
+	__le32 byte_28_rqws_pd;
+	__le32 idx_bt_ba;
+	__le32 rsv_idx_bt_ba;
+	__le32 idx_cur_blk_addr;
+	__le32 byte_44_idxbufpgsz_addr;
+	__le32 idx_nxt_blk_addr;
+	__le32 rsv_idxnxtblkaddr;
+	__le32 byte_56_xrc_cqn;
+	__le32 db_record_addr_record_en;
+	__le32 db_record_addr;
 };
 
+#define SRQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_srq_context, h, l)
+
+#define SRQC_SRQ_ST SRQC_FIELD_LOC(1, 0)
+#define SRQC_WQE_HOP_NUM SRQC_FIELD_LOC(3, 2)
+#define SRQC_SHIFT SRQC_FIELD_LOC(7, 4)
+#define SRQC_SRQN SRQC_FIELD_LOC(31, 8)
+#define SRQC_LIMIT_WL SRQC_FIELD_LOC(47, 32)
+#define SRQC_RSV0 SRQC_FIELD_LOC(63, 48)
+#define SRQC_XRCD SRQC_FIELD_LOC(87, 64)
+#define SRQC_RSV1 SRQC_FIELD_LOC(95, 88)
+#define SRQC_PRODUCER_IDX SRQC_FIELD_LOC(111, 96)
+#define SRQC_CONSUMER_IDX SRQC_FIELD_LOC(127, 112)
+#define SRQC_WQE_BT_BA_L SRQC_FIELD_LOC(159, 128)
+#define SRQC_WQE_BT_BA_H SRQC_FIELD_LOC(188, 160)
+#define SRQC_RSV2 SRQC_FIELD_LOC(191, 189)
+#define SRQC_PD SRQC_FIELD_LOC(215, 192)
+#define SRQC_RQWS SRQC_FIELD_LOC(219, 216)
+#define SRQC_RSV3 SRQC_FIELD_LOC(223, 220)
+#define SRQC_IDX_BT_BA_L SRQC_FIELD_LOC(255, 224)
+#define SRQC_IDX_BT_BA_H SRQC_FIELD_LOC(284, 256)
+#define SRQC_RSV4 SRQC_FIELD_LOC(287, 285)
+#define SRQC_IDX_CUR_BLK_ADDR_L SRQC_FIELD_LOC(319, 288)
+#define SRQC_IDX_CUR_BLK_ADDR_H SRQC_FIELD_LOC(339, 320)
+#define SRQC_RSV5 SRQC_FIELD_LOC(341, 340)
+#define SRQC_IDX_HOP_NUM SRQC_FIELD_LOC(343, 342)
+#define SRQC_IDX_BA_PG_SZ SRQC_FIELD_LOC(347, 344)
+#define SRQC_IDX_BUF_PG_SZ SRQC_FIELD_LOC(351, 348)
+#define SRQC_IDX_NXT_BLK_ADDR_L SRQC_FIELD_LOC(383, 352)
+#define SRQC_IDX_NXT_BLK_ADDR_H SRQC_FIELD_LOC(403, 384)
+#define SRQC_RSV6 SRQC_FIELD_LOC(415, 404)
+#define SRQC_XRC_CQN SRQC_FIELD_LOC(439, 416)
+#define SRQC_WQE_BA_PG_SZ SRQC_FIELD_LOC(443, 440)
+#define SRQC_WQE_BUF_PG_SZ SRQC_FIELD_LOC(447, 444)
+#define SRQC_DB_RECORD_EN SRQC_FIELD_LOC(448, 448)
+#define SRQC_DB_RECORD_ADDR_L SRQC_FIELD_LOC(479, 449)
+#define SRQC_DB_RECORD_ADDR_H SRQC_FIELD_LOC(511, 480)
+
 #define SRQC_BYTE_4_SRQ_ST_S 0
 #define SRQC_BYTE_4_SRQ_ST_M GENMASK(1, 0)
 
-- 
2.8.1

