Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30FB352844
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhDBJKW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 05:10:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14681 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhDBJKT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Apr 2021 05:10:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBZ2H2mD7znY5Q;
        Fri,  2 Apr 2021 17:07:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 17:10:06 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Yixing Liu <liuyixing1@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 8/9] RDMA/hns: Simplify the function config_eqc()
Date:   Fri, 2 Apr 2021 17:07:33 +0800
Message-ID: <1617354454-47840-9-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
References: <1617354454-47840-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Use "hr_reg_write" replace "roce_set_filed".

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 142 ++++++++---------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 108 ++++++----------------
 2 files changed, 65 insertions(+), 185 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6a3c177..72590f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -6083,6 +6083,16 @@ static void free_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
 	hns_roce_mtr_destroy(hr_dev, &eq->mtr);
 }
 
+static void init_eq_config(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq)
+{
+	eq->db_reg = hr_dev->reg_base + ROCEE_VF_EQ_DB_CFG0_REG;
+	eq->cons_index = 0;
+	eq->over_ignore = HNS_ROCE_V2_EQ_OVER_IGNORE_0;
+	eq->coalesce = HNS_ROCE_V2_EQ_COALESCE_0;
+	eq->arm_st = HNS_ROCE_V2_EQ_ALWAYS_ARMED;
+	eq->shift = ilog2((unsigned int)eq->entries);
+}
+
 static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 		      void *mb_buf)
 {
@@ -6094,13 +6104,7 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 	eqc = mb_buf;
 	memset(eqc, 0, sizeof(struct hns_roce_eq_context));
 
-	/* init eqc */
-	eq->db_reg = hr_dev->reg_base + ROCEE_VF_EQ_DB_CFG0_REG;
-	eq->cons_index = 0;
-	eq->over_ignore = HNS_ROCE_V2_EQ_OVER_IGNORE_0;
-	eq->coalesce = HNS_ROCE_V2_EQ_COALESCE_0;
-	eq->arm_st = HNS_ROCE_V2_EQ_ALWAYS_ARMED;
-	eq->shift = ilog2((unsigned int)eq->entries);
+	init_eq_config(hr_dev, eq);
 
 	/* if not multi-hop, eqe buffer only use one trunk */
 	count = hns_roce_mtr_find(hr_dev, &eq->mtr, 0, eqe_ba, MTT_MIN_COUNT,
@@ -6110,102 +6114,34 @@ static int config_eqc(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 		return -ENOBUFS;
 	}
 
-	/* set eqc state */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQ_ST_M, HNS_ROCE_EQC_EQ_ST_S,
-		       HNS_ROCE_V2_EQ_STATE_VALID);
-
-	/* set eqe hop num */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_HOP_NUM_M,
-		       HNS_ROCE_EQC_HOP_NUM_S, eq->hop_num);
-
-	/* set eqc over_ignore */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_OVER_IGNORE_M,
-		       HNS_ROCE_EQC_OVER_IGNORE_S, eq->over_ignore);
-
-	/* set eqc coalesce */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_COALESCE_M,
-		       HNS_ROCE_EQC_COALESCE_S, eq->coalesce);
-
-	/* set eqc arm_state */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_ARM_ST_M,
-		       HNS_ROCE_EQC_ARM_ST_S, eq->arm_st);
-
-	/* set eqn */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQN_M, HNS_ROCE_EQC_EQN_S,
-		       eq->eqn);
-
-	/* set eqe_cnt */
-	roce_set_field(eqc->byte_4, HNS_ROCE_EQC_EQE_CNT_M,
-		       HNS_ROCE_EQC_EQE_CNT_S, HNS_ROCE_EQ_INIT_EQE_CNT);
-
-	/* set eqe_ba_pg_sz */
-	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_BA_PG_SZ_M,
-		       HNS_ROCE_EQC_BA_PG_SZ_S,
-		       to_hr_hw_page_shift(eq->mtr.hem_cfg.ba_pg_shift));
-
-	/* set eqe_buf_pg_sz */
-	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_BUF_PG_SZ_M,
-		       HNS_ROCE_EQC_BUF_PG_SZ_S,
-		       to_hr_hw_page_shift(eq->mtr.hem_cfg.buf_pg_shift));
-
-	/* set eq_producer_idx */
-	roce_set_field(eqc->byte_8, HNS_ROCE_EQC_PROD_INDX_M,
-		       HNS_ROCE_EQC_PROD_INDX_S, HNS_ROCE_EQ_INIT_PROD_IDX);
-
-	/* set eq_max_cnt */
-	roce_set_field(eqc->byte_12, HNS_ROCE_EQC_MAX_CNT_M,
-		       HNS_ROCE_EQC_MAX_CNT_S, eq->eq_max_cnt);
-
-	/* set eq_period */
-	roce_set_field(eqc->byte_12, HNS_ROCE_EQC_PERIOD_M,
-		       HNS_ROCE_EQC_PERIOD_S, eq->eq_period);
-
-	/* set eqe_report_timer */
-	roce_set_field(eqc->eqe_report_timer, HNS_ROCE_EQC_REPORT_TIMER_M,
-		       HNS_ROCE_EQC_REPORT_TIMER_S,
-		       HNS_ROCE_EQ_INIT_REPORT_TIMER);
-
-	/* set bt_ba [34:3] */
-	roce_set_field(eqc->eqe_ba0, HNS_ROCE_EQC_EQE_BA_L_M,
-		       HNS_ROCE_EQC_EQE_BA_L_S, bt_ba >> 3);
-
-	/* set bt_ba [64:35] */
-	roce_set_field(eqc->eqe_ba1, HNS_ROCE_EQC_EQE_BA_H_M,
-		       HNS_ROCE_EQC_EQE_BA_H_S, bt_ba >> 35);
-
-	/* set eq shift */
-	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_SHIFT_M, HNS_ROCE_EQC_SHIFT_S,
-		       eq->shift);
-
-	/* set eq MSI_IDX */
-	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_MSI_INDX_M,
-		       HNS_ROCE_EQC_MSI_INDX_S, HNS_ROCE_EQ_INIT_MSI_IDX);
-
-	/* set cur_eqe_ba [27:12] */
-	roce_set_field(eqc->byte_28, HNS_ROCE_EQC_CUR_EQE_BA_L_M,
-		       HNS_ROCE_EQC_CUR_EQE_BA_L_S, eqe_ba[0] >> 12);
-
-	/* set cur_eqe_ba [59:28] */
-	roce_set_field(eqc->byte_32, HNS_ROCE_EQC_CUR_EQE_BA_M_M,
-		       HNS_ROCE_EQC_CUR_EQE_BA_M_S, eqe_ba[0] >> 28);
-
-	/* set cur_eqe_ba [63:60] */
-	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CUR_EQE_BA_H_M,
-		       HNS_ROCE_EQC_CUR_EQE_BA_H_S, eqe_ba[0] >> 60);
-
-	/* set eq consumer idx */
-	roce_set_field(eqc->byte_36, HNS_ROCE_EQC_CONS_INDX_M,
-		       HNS_ROCE_EQC_CONS_INDX_S, HNS_ROCE_EQ_INIT_CONS_IDX);
-
-	roce_set_field(eqc->byte_40, HNS_ROCE_EQC_NXT_EQE_BA_L_M,
-		       HNS_ROCE_EQC_NXT_EQE_BA_L_S, eqe_ba[1] >> 12);
-
-	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_NXT_EQE_BA_H_M,
-		       HNS_ROCE_EQC_NXT_EQE_BA_H_S, eqe_ba[1] >> 44);
-
-	roce_set_field(eqc->byte_44, HNS_ROCE_EQC_EQE_SIZE_M,
-		       HNS_ROCE_EQC_EQE_SIZE_S,
-		       eq->eqe_size == HNS_ROCE_V3_EQE_SIZE ? 1 : 0);
+	hr_reg_write(eqc, EQC_EQ_ST, HNS_ROCE_V2_EQ_STATE_VALID);
+	hr_reg_write(eqc, EQC_EQE_HOP_NUM, eq->hop_num);
+	hr_reg_write(eqc, EQC_OVER_IGNORE, eq->over_ignore);
+	hr_reg_write(eqc, EQC_COALESCE, eq->coalesce);
+	hr_reg_write(eqc, EQC_ARM_ST, eq->arm_st);
+	hr_reg_write(eqc, EQC_EQN, eq->eqn);
+	hr_reg_write(eqc, EQC_EQE_CNT, HNS_ROCE_EQ_INIT_EQE_CNT);
+	hr_reg_write(eqc, EQC_EQE_BA_PG_SZ,
+		     to_hr_hw_page_shift(eq->mtr.hem_cfg.ba_pg_shift));
+	hr_reg_write(eqc, EQC_EQE_BUF_PG_SZ,
+		     to_hr_hw_page_shift(eq->mtr.hem_cfg.buf_pg_shift));
+	hr_reg_write(eqc, EQC_EQ_PROD_INDX, HNS_ROCE_EQ_INIT_PROD_IDX);
+	hr_reg_write(eqc, EQC_EQ_MAX_CNT, eq->eq_max_cnt);
+
+	hr_reg_write(eqc, EQC_EQ_PERIOD, eq->eq_period);
+	hr_reg_write(eqc, EQC_EQE_REPORT_TIMER, HNS_ROCE_EQ_INIT_REPORT_TIMER);
+	hr_reg_write(eqc, EQC_EQE_BA_L, bt_ba >> 3);
+	hr_reg_write(eqc, EQC_EQE_BA_H, bt_ba >> 35);
+	hr_reg_write(eqc, EQC_SHIFT, eq->shift);
+	hr_reg_write(eqc, EQC_MSI_INDX, HNS_ROCE_EQ_INIT_MSI_IDX);
+	hr_reg_write(eqc, EQC_CUR_EQE_BA_L, eqe_ba[0] >> 12);
+	hr_reg_write(eqc, EQC_CUR_EQE_BA_M, eqe_ba[0] >> 28);
+	hr_reg_write(eqc, EQC_CUR_EQE_BA_H, eqe_ba[0] >> 60);
+	hr_reg_write(eqc, EQC_EQ_CONS_INDX, HNS_ROCE_EQ_INIT_CONS_IDX);
+	hr_reg_write(eqc, EQC_NEX_EQE_BA_L, eqe_ba[1] >> 12);
+	hr_reg_write(eqc, EQC_NEX_EQE_BA_H, eqe_ba[1] >> 44);
+	hr_reg_write(eqc, EQC_EQE_SIZE,
+		     !!(eq->eqe_size == HNS_ROCE_V3_EQE_SIZE));
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 2f63c3c..f3e51d8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1980,88 +1980,32 @@ struct hns_roce_dip {
 #define HNS_ROCE_V2_VF_ABN_INT_CFG_M GENMASK(2, 0)
 #define HNS_ROCE_V2_VF_EVENT_INT_EN_M GENMASK(0, 0)
 
-/* WORD0 */
-#define HNS_ROCE_EQC_EQ_ST_S 0
-#define HNS_ROCE_EQC_EQ_ST_M GENMASK(1, 0)
-
-#define HNS_ROCE_EQC_HOP_NUM_S 2
-#define HNS_ROCE_EQC_HOP_NUM_M GENMASK(3, 2)
-
-#define HNS_ROCE_EQC_OVER_IGNORE_S 4
-#define HNS_ROCE_EQC_OVER_IGNORE_M GENMASK(4, 4)
-
-#define HNS_ROCE_EQC_COALESCE_S 5
-#define HNS_ROCE_EQC_COALESCE_M GENMASK(5, 5)
-
-#define HNS_ROCE_EQC_ARM_ST_S 6
-#define HNS_ROCE_EQC_ARM_ST_M GENMASK(7, 6)
-
-#define HNS_ROCE_EQC_EQN_S 8
-#define HNS_ROCE_EQC_EQN_M GENMASK(15, 8)
-
-#define HNS_ROCE_EQC_EQE_CNT_S 16
-#define HNS_ROCE_EQC_EQE_CNT_M GENMASK(31, 16)
-
-/* WORD1 */
-#define HNS_ROCE_EQC_BA_PG_SZ_S 0
-#define HNS_ROCE_EQC_BA_PG_SZ_M GENMASK(3, 0)
-
-#define HNS_ROCE_EQC_BUF_PG_SZ_S 4
-#define HNS_ROCE_EQC_BUF_PG_SZ_M GENMASK(7, 4)
-
-#define HNS_ROCE_EQC_PROD_INDX_S 8
-#define HNS_ROCE_EQC_PROD_INDX_M GENMASK(31, 8)
-
-/* WORD2 */
-#define HNS_ROCE_EQC_MAX_CNT_S 0
-#define HNS_ROCE_EQC_MAX_CNT_M GENMASK(15, 0)
-
-#define HNS_ROCE_EQC_PERIOD_S 16
-#define HNS_ROCE_EQC_PERIOD_M GENMASK(31, 16)
-
-/* WORD3 */
-#define HNS_ROCE_EQC_REPORT_TIMER_S 0
-#define HNS_ROCE_EQC_REPORT_TIMER_M GENMASK(31, 0)
-
-/* WORD4 */
-#define HNS_ROCE_EQC_EQE_BA_L_S 0
-#define HNS_ROCE_EQC_EQE_BA_L_M GENMASK(31, 0)
-
-/* WORD5 */
-#define HNS_ROCE_EQC_EQE_BA_H_S 0
-#define HNS_ROCE_EQC_EQE_BA_H_M GENMASK(28, 0)
-
-/* WORD6 */
-#define HNS_ROCE_EQC_SHIFT_S 0
-#define HNS_ROCE_EQC_SHIFT_M GENMASK(7, 0)
-
-#define HNS_ROCE_EQC_MSI_INDX_S 8
-#define HNS_ROCE_EQC_MSI_INDX_M GENMASK(15, 8)
-
-#define HNS_ROCE_EQC_CUR_EQE_BA_L_S 16
-#define HNS_ROCE_EQC_CUR_EQE_BA_L_M GENMASK(31, 16)
-
-/* WORD7 */
-#define HNS_ROCE_EQC_CUR_EQE_BA_M_S 0
-#define HNS_ROCE_EQC_CUR_EQE_BA_M_M GENMASK(31, 0)
-
-/* WORD8 */
-#define HNS_ROCE_EQC_CUR_EQE_BA_H_S 0
-#define HNS_ROCE_EQC_CUR_EQE_BA_H_M GENMASK(3, 0)
-
-#define HNS_ROCE_EQC_CONS_INDX_S 8
-#define HNS_ROCE_EQC_CONS_INDX_M GENMASK(31, 8)
-
-/* WORD9 */
-#define HNS_ROCE_EQC_NXT_EQE_BA_L_S 0
-#define HNS_ROCE_EQC_NXT_EQE_BA_L_M GENMASK(31, 0)
-
-/* WORD10 */
-#define HNS_ROCE_EQC_NXT_EQE_BA_H_S 0
-#define HNS_ROCE_EQC_NXT_EQE_BA_H_M GENMASK(19, 0)
-
-#define HNS_ROCE_EQC_EQE_SIZE_S 20
-#define HNS_ROCE_EQC_EQE_SIZE_M GENMASK(21, 20)
+#define EQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_eq_context, h, l)
+
+#define EQC_EQ_ST EQC_FIELD_LOC(1, 0)
+#define EQC_EQE_HOP_NUM EQC_FIELD_LOC(3, 2)
+#define EQC_OVER_IGNORE EQC_FIELD_LOC(4, 4)
+#define EQC_COALESCE EQC_FIELD_LOC(5, 5)
+#define EQC_ARM_ST EQC_FIELD_LOC(7, 6)
+#define EQC_EQN EQC_FIELD_LOC(15, 8)
+#define EQC_EQE_CNT EQC_FIELD_LOC(31, 16)
+#define EQC_EQE_BA_PG_SZ EQC_FIELD_LOC(35, 32)
+#define EQC_EQE_BUF_PG_SZ EQC_FIELD_LOC(39, 36)
+#define EQC_EQ_PROD_INDX EQC_FIELD_LOC(63, 40)
+#define EQC_EQ_MAX_CNT EQC_FIELD_LOC(79, 64)
+#define EQC_EQ_PERIOD EQC_FIELD_LOC(95, 80)
+#define EQC_EQE_REPORT_TIMER EQC_FIELD_LOC(127, 96)
+#define EQC_EQE_BA_L EQC_FIELD_LOC(159, 128)
+#define EQC_EQE_BA_H EQC_FIELD_LOC(188, 160)
+#define EQC_SHIFT EQC_FIELD_LOC(199, 192)
+#define EQC_MSI_INDX EQC_FIELD_LOC(207, 200)
+#define EQC_CUR_EQE_BA_L EQC_FIELD_LOC(223, 208)
+#define EQC_CUR_EQE_BA_M EQC_FIELD_LOC(255, 224)
+#define EQC_CUR_EQE_BA_H EQC_FIELD_LOC(259, 256)
+#define EQC_EQ_CONS_INDX EQC_FIELD_LOC(287, 264)
+#define EQC_NEX_EQE_BA_L EQC_FIELD_LOC(319, 288)
+#define EQC_NEX_EQE_BA_H EQC_FIELD_LOC(339, 320)
+#define EQC_EQE_SIZE EQC_FIELD_LOC(341, 340)
 
 #define HNS_ROCE_V2_CEQE_COMP_CQN_S 0
 #define HNS_ROCE_V2_CEQE_COMP_CQN_M GENMASK(23, 0)
-- 
2.8.1

