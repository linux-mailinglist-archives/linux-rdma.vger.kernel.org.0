Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF7395B0C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEaNBm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 09:01:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3305 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhEaNBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 09:01:33 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FtwHf0BWdz1BH0P;
        Mon, 31 May 2021 20:55:10 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 20:59:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 20:59:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 2/7] RDMA/hns: Use new interface to write CQ context.
Date:   Mon, 31 May 2021 20:59:29 +0800
Message-ID: <1622465974-20415-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
References: <1622465974-20415-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Use hr_reg_*() to write CQ context, it's simpler than roce_set_*().

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 111 ++++++++++-------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  87 +++++++++++-----------
 2 files changed, 78 insertions(+), 120 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fbc45b9..f1acc05 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3280,73 +3280,44 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	cq_context = mb_buf;
 	memset(cq_context, 0, sizeof(*cq_context));
 
-	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_CQ_ST_M,
-		       V2_CQC_BYTE_4_CQ_ST_S, V2_CQ_STATE_VALID);
-	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_ARM_ST_M,
-		       V2_CQC_BYTE_4_ARM_ST_S, REG_NXT_CEQE);
-	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_SHIFT_M,
-		       V2_CQC_BYTE_4_SHIFT_S, ilog2(hr_cq->cq_depth));
-	roce_set_field(cq_context->byte_4_pg_ceqn, V2_CQC_BYTE_4_CEQN_M,
-		       V2_CQC_BYTE_4_CEQN_S, hr_cq->vector);
-
-	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQN_M,
-		       V2_CQC_BYTE_8_CQN_S, hr_cq->cqn);
-
-	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQE_SIZE_M,
-		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
-		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
+	hr_reg_write(cq_context, CQC_CQ_ST, V2_CQ_STATE_VALID);
+	hr_reg_write(cq_context, CQC_ARM_ST, REG_NXT_CEQE);
+	hr_reg_write(cq_context, CQC_SHIFT, ilog2(hr_cq->cq_depth));
+	hr_reg_write(cq_context, CQC_CEQN, hr_cq->vector);
+	hr_reg_write(cq_context, CQC_CQN, hr_cq->cqn);
+
+	if (hr_cq->cqe_size == HNS_ROCE_V3_CQE_SIZE)
+		hr_reg_write(cq_context, CQC_CQE_SIZE, CQE_SIZE_64B);
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
 		hr_reg_enable(cq_context, CQC_STASH);
 
-	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
-
-	roce_set_field(cq_context->byte_16_hop_addr,
-		       V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M,
-		       V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts[0])));
-	roce_set_field(cq_context->byte_16_hop_addr,
-		       V2_CQC_BYTE_16_CQE_HOP_NUM_M,
-		       V2_CQC_BYTE_16_CQE_HOP_NUM_S, hr_dev->caps.cqe_hop_num ==
-		       HNS_ROCE_HOP_NUM_0 ? 0 : hr_dev->caps.cqe_hop_num);
-
-	cq_context->cqe_nxt_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[1]));
-	roce_set_field(cq_context->byte_24_pgsz_addr,
-		       V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_M,
-		       V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_S,
-		       upper_32_bits(to_hr_hw_page_addr(mtts[1])));
-	roce_set_field(cq_context->byte_24_pgsz_addr,
-		       V2_CQC_BYTE_24_CQE_BA_PG_SZ_M,
-		       V2_CQC_BYTE_24_CQE_BA_PG_SZ_S,
-		       to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(cq_context->byte_24_pgsz_addr,
-		       V2_CQC_BYTE_24_CQE_BUF_PG_SZ_M,
-		       V2_CQC_BYTE_24_CQE_BUF_PG_SZ_S,
-		       to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.buf_pg_shift));
-
-	cq_context->cqe_ba = cpu_to_le32(dma_handle >> 3);
-
-	roce_set_field(cq_context->byte_40_cqe_ba, V2_CQC_BYTE_40_CQE_BA_M,
-		       V2_CQC_BYTE_40_CQE_BA_S, (dma_handle >> (32 + 3)));
-
-	roce_set_bit(cq_context->byte_44_db_record,
-		     V2_CQC_BYTE_44_DB_RECORD_EN_S,
+	hr_reg_write(cq_context, CQC_CQE_CUR_BLK_ADDR_L,
+		     to_hr_hw_page_addr(mtts[0]));
+	hr_reg_write(cq_context, CQC_CQE_CUR_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(mtts[0])));
+	hr_reg_write(cq_context, CQC_CQE_HOP_NUM, hr_dev->caps.cqe_hop_num ==
+		     HNS_ROCE_HOP_NUM_0 ? 0 : hr_dev->caps.cqe_hop_num);
+	hr_reg_write(cq_context, CQC_CQE_NEX_BLK_ADDR_L,
+		     to_hr_hw_page_addr(mtts[1]));
+	hr_reg_write(cq_context, CQC_CQE_NEX_BLK_ADDR_H,
+		     upper_32_bits(to_hr_hw_page_addr(mtts[1])));
+	hr_reg_write(cq_context, CQC_CQE_BAR_PG_SZ,
+		     to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.ba_pg_shift));
+	hr_reg_write(cq_context, CQC_CQE_BUF_PG_SZ,
+		     to_hr_hw_page_shift(hr_cq->mtr.hem_cfg.buf_pg_shift));
+	hr_reg_write(cq_context, CQC_CQE_BA_L, dma_handle >> 3);
+	hr_reg_write(cq_context, CQC_CQE_BA_H, (dma_handle >> (32 + 3)));
+	hr_reg_write(cq_context, CQC_DB_RECORD_EN,
 		     (hr_cq->flags & HNS_ROCE_CQ_FLAG_RECORD_DB) ? 1 : 0);
-
-	roce_set_field(cq_context->byte_44_db_record,
-		       V2_CQC_BYTE_44_DB_RECORD_ADDR_M,
-		       V2_CQC_BYTE_44_DB_RECORD_ADDR_S,
-		       ((u32)hr_cq->db.dma) >> 1);
-	cq_context->db_record_addr = cpu_to_le32(hr_cq->db.dma >> 32);
-
-	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_MAX_CNT_M,
-		       V2_CQC_BYTE_56_CQ_MAX_CNT_S,
-		       HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM);
-	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_PERIOD_M,
-		       V2_CQC_BYTE_56_CQ_PERIOD_S,
-		       HNS_ROCE_V2_CQ_DEFAULT_INTERVAL);
+	hr_reg_write(cq_context, CQC_CQE_DB_RECORD_ADDR_L,
+		     ((u32)hr_cq->db.dma) >> 1);
+	hr_reg_write(cq_context, CQC_CQE_DB_RECORD_ADDR_H,
+		     hr_cq->db.dma >> 32);
+	hr_reg_write(cq_context, CQC_CQ_MAX_CNT,
+		     HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM);
+	hr_reg_write(cq_context, CQC_CQ_PERIOD,
+		     HNS_ROCE_V2_CQ_DEFAULT_INTERVAL);
 }
 
 static int hns_roce_v2_req_notify_cq(struct ib_cq *ibcq,
@@ -5748,18 +5719,10 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 
 	memset(cqc_mask, 0xff, sizeof(*cqc_mask));
 
-	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_MAX_CNT_M, V2_CQC_BYTE_56_CQ_MAX_CNT_S,
-		       cq_count);
-	roce_set_field(cqc_mask->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_MAX_CNT_M, V2_CQC_BYTE_56_CQ_MAX_CNT_S,
-		       0);
-	roce_set_field(cq_context->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_PERIOD_M, V2_CQC_BYTE_56_CQ_PERIOD_S,
-		       cq_period);
-	roce_set_field(cqc_mask->byte_56_cqe_period_maxcnt,
-		       V2_CQC_BYTE_56_CQ_PERIOD_M, V2_CQC_BYTE_56_CQ_PERIOD_S,
-		       0);
+	hr_reg_write(cq_context, CQC_CQ_MAX_CNT, cq_count);
+	hr_reg_clear(cqc_mask, CQC_CQ_MAX_CNT);
+	hr_reg_write(cq_context, CQC_CQ_PERIOD, cq_period);
+	hr_reg_clear(cqc_mask, CQC_CQ_PERIOD);
 
 	ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0, hr_cq->cqn, 1,
 				HNS_ROCE_CMD_MODIFY_CQC,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index cd361c0..ce7068d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -165,6 +165,11 @@ enum {
 	REG_NXT_SE_CEQE = 0x3
 };
 
+enum {
+	CQE_SIZE_32B = 0x0,
+	CQE_SIZE_64B = 0x1
+};
+
 #define V2_CQ_DB_REQ_NOT_SOL			0
 #define V2_CQ_DB_REQ_NOT			1
 
@@ -306,67 +311,24 @@ struct hns_roce_v2_cq_context {
 #define HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM 0x0
 #define HNS_ROCE_V2_CQ_DEFAULT_INTERVAL	0x0
 
-#define	V2_CQC_BYTE_4_CQ_ST_S 0
-#define V2_CQC_BYTE_4_CQ_ST_M GENMASK(1, 0)
-
-#define	V2_CQC_BYTE_4_POLL_S 2
-
-#define	V2_CQC_BYTE_4_SE_S 3
-
-#define	V2_CQC_BYTE_4_OVER_IGNORE_S 4
-
-#define	V2_CQC_BYTE_4_COALESCE_S 5
-
 #define	V2_CQC_BYTE_4_ARM_ST_S 6
 #define V2_CQC_BYTE_4_ARM_ST_M GENMASK(7, 6)
 
-#define	V2_CQC_BYTE_4_SHIFT_S 8
-#define V2_CQC_BYTE_4_SHIFT_M GENMASK(12, 8)
-
-#define	V2_CQC_BYTE_4_CMD_SN_S 13
-#define V2_CQC_BYTE_4_CMD_SN_M GENMASK(14, 13)
-
 #define	V2_CQC_BYTE_4_CEQN_S 15
 #define V2_CQC_BYTE_4_CEQN_M GENMASK(23, 15)
 
-#define	V2_CQC_BYTE_4_PAGE_OFFSET_S 24
-#define V2_CQC_BYTE_4_PAGE_OFFSET_M GENMASK(31, 24)
-
 #define	V2_CQC_BYTE_8_CQN_S 0
 #define V2_CQC_BYTE_8_CQN_M GENMASK(23, 0)
 
-#define V2_CQC_BYTE_8_CQE_SIZE_S 27
-#define V2_CQC_BYTE_8_CQE_SIZE_M GENMASK(28, 27)
-
-#define	V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S 0
-#define V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M GENMASK(19, 0)
-
 #define	V2_CQC_BYTE_16_CQE_HOP_NUM_S 30
 #define V2_CQC_BYTE_16_CQE_HOP_NUM_M GENMASK(31, 30)
 
-#define	V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_S 0
-#define V2_CQC_BYTE_24_CQE_NXT_BLK_ADDR_M GENMASK(19, 0)
-
-#define	V2_CQC_BYTE_24_CQE_BA_PG_SZ_S 24
-#define V2_CQC_BYTE_24_CQE_BA_PG_SZ_M GENMASK(27, 24)
-
-#define	V2_CQC_BYTE_24_CQE_BUF_PG_SZ_S 28
-#define V2_CQC_BYTE_24_CQE_BUF_PG_SZ_M GENMASK(31, 28)
-
 #define	V2_CQC_BYTE_28_CQ_PRODUCER_IDX_S 0
 #define V2_CQC_BYTE_28_CQ_PRODUCER_IDX_M GENMASK(23, 0)
 
 #define	V2_CQC_BYTE_32_CQ_CONSUMER_IDX_S 0
 #define V2_CQC_BYTE_32_CQ_CONSUMER_IDX_M GENMASK(23, 0)
 
-#define	V2_CQC_BYTE_40_CQE_BA_S 0
-#define V2_CQC_BYTE_40_CQE_BA_M GENMASK(28, 0)
-
-#define	V2_CQC_BYTE_44_DB_RECORD_EN_S 0
-
-#define	V2_CQC_BYTE_44_DB_RECORD_ADDR_S 1
-#define	V2_CQC_BYTE_44_DB_RECORD_ADDR_M GENMASK(31, 1)
-
 #define	V2_CQC_BYTE_52_CQE_CNT_S 0
 #define	V2_CQC_BYTE_52_CQE_CNT_M GENMASK(23, 0)
 
@@ -376,12 +338,45 @@ struct hns_roce_v2_cq_context {
 #define	V2_CQC_BYTE_56_CQ_PERIOD_S 16
 #define V2_CQC_BYTE_56_CQ_PERIOD_M GENMASK(31, 16)
 
-#define	V2_CQC_BYTE_64_SE_CQE_IDX_S 0
-#define	V2_CQC_BYTE_64_SE_CQE_IDX_M GENMASK(23, 0)
-
 #define CQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_cq_context, h, l)
 
+#define CQC_CQ_ST CQC_FIELD_LOC(1, 0)
+#define CQC_POLL CQC_FIELD_LOC(2, 2)
+#define CQC_SE CQC_FIELD_LOC(3, 3)
+#define CQC_OVER_IGNORE CQC_FIELD_LOC(4, 4)
+#define CQC_ARM_ST CQC_FIELD_LOC(7, 6)
+#define CQC_SHIFT CQC_FIELD_LOC(12, 8)
+#define CQC_CMD_SN CQC_FIELD_LOC(14, 13)
+#define CQC_CEQN CQC_FIELD_LOC(23, 15)
+#define CQC_CQN CQC_FIELD_LOC(55, 32)
+#define CQC_POE_EN CQC_FIELD_LOC(56, 56)
+#define CQC_POE_NUM CQC_FIELD_LOC(58, 57)
+#define CQC_CQE_SIZE CQC_FIELD_LOC(60, 59)
+#define CQC_CQ_CNT_MODE CQC_FIELD_LOC(61, 61)
 #define CQC_STASH CQC_FIELD_LOC(63, 63)
+#define CQC_CQE_CUR_BLK_ADDR_L CQC_FIELD_LOC(95, 64)
+#define CQC_CQE_CUR_BLK_ADDR_H CQC_FIELD_LOC(115, 96)
+#define CQC_POE_QID CQC_FIELD_LOC(125, 116)
+#define CQC_CQE_HOP_NUM CQC_FIELD_LOC(127, 126)
+#define CQC_CQE_NEX_BLK_ADDR_L CQC_FIELD_LOC(159, 128)
+#define CQC_CQE_NEX_BLK_ADDR_H CQC_FIELD_LOC(179, 160)
+#define CQC_CQE_BAR_PG_SZ CQC_FIELD_LOC(187, 184)
+#define CQC_CQE_BUF_PG_SZ CQC_FIELD_LOC(191, 188)
+#define CQC_CQ_PRODUCER_IDX CQC_FIELD_LOC(215, 192)
+#define CQC_CQ_CONSUMER_IDX CQC_FIELD_LOC(247, 224)
+#define CQC_CQE_BA_L CQC_FIELD_LOC(287, 256)
+#define CQC_CQE_BA_H CQC_FIELD_LOC(316, 288)
+#define CQC_POE_QID_H_0 CQC_FIELD_LOC(319, 317)
+#define CQC_DB_RECORD_EN CQC_FIELD_LOC(320, 320)
+#define CQC_CQE_DB_RECORD_ADDR_L CQC_FIELD_LOC(351, 321)
+#define CQC_CQE_DB_RECORD_ADDR_H CQC_FIELD_LOC(383, 352)
+#define CQC_CQE_CNT CQC_FIELD_LOC(407, 384)
+#define CQC_CQ_MAX_CNT CQC_FIELD_LOC(431, 416)
+#define CQC_CQ_PERIOD CQC_FIELD_LOC(447, 432)
+#define CQC_CQE_REPORT_TIMER CQC_FIELD_LOC(471, 448)
+#define CQC_WR_CQE_IDX CQC_FIELD_LOC(479, 472)
+#define CQC_SE_CQE_IDX CQC_FIELD_LOC(503, 480)
+#define CQC_POE_QID_H_1 CQC_FIELD_LOC(511, 511)
 
 struct hns_roce_srq_context {
 	__le32 byte_4_srqn_srqst;
-- 
2.7.4

