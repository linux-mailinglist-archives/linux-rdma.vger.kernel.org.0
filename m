Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7475B30145B
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 10:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbhAWJvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Jan 2021 04:51:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11184 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbhAWJvA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Jan 2021 04:51:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DNBCg4wfbzl6m9;
        Sat, 23 Jan 2021 17:48:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 23 Jan 2021 17:50:10 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 3/3] RDMA/hns: Use new interface to set MPT related fields
Date:   Sat, 23 Jan 2021 17:48:02 +0800
Message-ID: <1611395282-991-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611395282-991-1-git-send-email-liweihang@huawei.com>
References: <1611395282-991-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Achieve hr_reg_write() to simply the codes to fill fields.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 22 ++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 54 +++++++++++++----------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++++++
 3 files changed, 85 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index 5afee04..3ca6e88 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -32,6 +32,7 @@
 
 #ifndef _HNS_ROCE_COMMON_H
 #define _HNS_ROCE_COMMON_H
+#include <linux/bitfield.h>
 
 #define roce_write(dev, reg, val)	writel((val), (dev)->reg_base + (reg))
 #define roce_read(dev, reg)		readl((dev)->reg_base + (reg))
@@ -65,6 +66,27 @@
 
 #define hr_reg_enable(ptr, field) _hr_reg_enable(ptr, field)
 
+#define _hr_reg_clear(ptr, field_type, field_h, field_l)                       \
+	({                                                                     \
+		const field_type *_ptr = ptr;                                  \
+		*((__le32 *)_ptr + (field_h) / 32) &=                          \
+			cpu_to_le32(                                           \
+				~GENMASK((field_h) % 32, (field_l) % 32)) +    \
+			BUILD_BUG_ON_ZERO(((field_h) / 32) !=                  \
+					  ((field_l) / 32));                   \
+	})
+
+#define hr_reg_clear(ptr, field) _hr_reg_clear(ptr, field)
+
+#define _hr_reg_write(ptr, field_type, field_h, field_l, val)                  \
+	({                                                                     \
+		_hr_reg_clear(ptr, field_type, field_h, field_l);              \
+		*((__le32 *)ptr + (field_h) / 32) |= cpu_to_le32(FIELD_PREP(   \
+			GENMASK((field_h) % 32, (field_l) % 32), val));        \
+	})
+
+#define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
+
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
 #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 16ef631..a5bbfb1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2880,36 +2880,20 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 	mpt_entry = mb_buf;
 	memset(mpt_entry, 0, sizeof(*mpt_entry));
 
-	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_MPT_ST_M,
-		       V2_MPT_BYTE_4_MPT_ST_S, V2_MPT_ST_VALID);
-	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PBL_HOP_NUM_M,
-		       V2_MPT_BYTE_4_PBL_HOP_NUM_S, mr->pbl_hop_num ==
-		       HNS_ROCE_HOP_NUM_0 ? 0 : mr->pbl_hop_num);
-	roce_set_field(mpt_entry->byte_4_pd_hop_st,
-		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_M,
-		       V2_MPT_BYTE_4_PBL_BA_PG_SZ_S,
-		       to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
-	roce_set_field(mpt_entry->byte_4_pd_hop_st, V2_MPT_BYTE_4_PD_M,
-		       V2_MPT_BYTE_4_PD_S, mr->pd);
-
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_RA_EN_S, 0);
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_R_INV_EN_S, 0);
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_L_INV_EN_S, 1);
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_BIND_EN_S,
-		     (mr->access & IB_ACCESS_MW_BIND ? 1 : 0));
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_ATOMIC_EN_S,
-		     mr->access & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_RR_EN_S,
-		     (mr->access & IB_ACCESS_REMOTE_READ ? 1 : 0));
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_RW_EN_S,
-		     (mr->access & IB_ACCESS_REMOTE_WRITE ? 1 : 0));
-	roce_set_bit(mpt_entry->byte_8_mw_cnt_en, V2_MPT_BYTE_8_LW_EN_S,
-		     (mr->access & IB_ACCESS_LOCAL_WRITE ? 1 : 0));
-
-	roce_set_bit(mpt_entry->byte_12_mw_pa, V2_MPT_BYTE_12_PA_S,
-		     mr->type == MR_TYPE_MR ? 0 : 1);
-	roce_set_bit(mpt_entry->byte_12_mw_pa, V2_MPT_BYTE_12_INNER_PA_VLD_S,
-		     1);
+	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_VALID);
+	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
+	hr_reg_enable(mpt_entry, MPT_L_INV_EN);
+
+	hr_reg_write(mpt_entry, MPT_BIND_EN,
+		     !!(mr->access & IB_ACCESS_MW_BIND));
+	hr_reg_write(mpt_entry, MPT_ATOMIC_EN,
+		     !!(mr->access & IB_ACCESS_REMOTE_ATOMIC));
+	hr_reg_write(mpt_entry, MPT_RR_EN,
+		     !!(mr->access & IB_ACCESS_REMOTE_READ));
+	hr_reg_write(mpt_entry, MPT_RW_EN,
+		     !!(mr->access & IB_ACCESS_REMOTE_WRITE));
+	hr_reg_write(mpt_entry, MPT_LW_EN,
+		     !!((mr->access & IB_ACCESS_LOCAL_WRITE)));
 
 	mpt_entry->len_l = cpu_to_le32(lower_32_bits(mr->size));
 	mpt_entry->len_h = cpu_to_le32(upper_32_bits(mr->size));
@@ -2917,9 +2901,19 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
 	mpt_entry->va_l = cpu_to_le32(lower_32_bits(mr->iova));
 	mpt_entry->va_h = cpu_to_le32(upper_32_bits(mr->iova));
 
+	if (mr->type != MR_TYPE_MR)
+		hr_reg_enable(mpt_entry, MPT_PA);
+
 	if (mr->type == MR_TYPE_DMA)
 		return 0;
 
+	if (mr->pbl_hop_num != HNS_ROCE_HOP_NUM_0)
+		hr_reg_write(mpt_entry, MPT_PBL_HOP_NUM, mr->pbl_hop_num);
+
+	hr_reg_write(mpt_entry, MPT_PBL_BA_PG_SZ,
+		     to_hr_hw_page_shift(mr->pbl_mtr.hem_cfg.ba_pg_shift));
+	hr_reg_enable(mpt_entry, MPT_INNER_PA_VLD);
+
 	ret = set_mtpt_pbl(hr_dev, mpt_entry, mr);
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index bdaccf8..69bc072 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -993,6 +993,45 @@ struct hns_roce_v2_mpt_entry {
 	__le32	byte_64_buf_pa1;
 };
 
+#define MPT_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_mpt_entry, h, l)
+
+#define MPT_ST MPT_FIELD_LOC(1, 0)
+#define MPT_PBL_HOP_NUM MPT_FIELD_LOC(3, 2)
+#define MPT_PBL_BA_PG_SZ MPT_FIELD_LOC(7, 4)
+#define MPT_PD MPT_FIELD_LOC(31, 8)
+#define MPT_RA_EN MPT_FIELD_LOC(32, 32)
+#define MPT_R_INV_EN MPT_FIELD_LOC(33, 33)
+#define MPT_L_INV_EN MPT_FIELD_LOC(34, 34)
+#define MPT_BIND_EN MPT_FIELD_LOC(35, 35)
+#define MPT_ATOMIC_EN MPT_FIELD_LOC(36, 36)
+#define MPT_RR_EN MPT_FIELD_LOC(37, 37)
+#define MPT_RW_EN MPT_FIELD_LOC(38, 38)
+#define MPT_LW_EN MPT_FIELD_LOC(39, 39)
+#define MPT_MW_CNT MPT_FIELD_LOC(63, 40)
+#define MPT_FRE MPT_FIELD_LOC(64, 64)
+#define MPT_PA MPT_FIELD_LOC(65, 65)
+#define MPT_ZBVA MPT_FIELD_LOC(66, 66)
+#define MPT_SHARE MPT_FIELD_LOC(67, 67)
+#define MPT_MR_MW MPT_FIELD_LOC(68, 68)
+#define MPT_BPD MPT_FIELD_LOC(69, 69)
+#define MPT_BQP MPT_FIELD_LOC(70, 70)
+#define MPT_INNER_PA_VLD MPT_FIELD_LOC(71, 71)
+#define MPT_MW_BIND_QPN MPT_FIELD_LOC(95, 72)
+#define MPT_BOUND_LKEY MPT_FIELD_LOC(127, 96)
+#define MPT_LEN MPT_FIELD_LOC(191, 128)
+#define MPT_LKEY MPT_FIELD_LOC(223, 192)
+#define MPT_VA MPT_FIELD_LOC(287, 224)
+#define MPT_PBL_SIZE MPT_FIELD_LOC(319, 288)
+#define MPT_PBL_BA MPT_FIELD_LOC(380, 320)
+#define MPT_BLK_MODE MPT_FIELD_LOC(381, 381)
+#define MPT_RSV0 MPT_FIELD_LOC(383, 382)
+#define MPT_PA0 MPT_FIELD_LOC(441, 384)
+#define MPT_BOUND_VA MPT_FIELD_LOC(447, 442)
+#define MPT_PA1 MPT_FIELD_LOC(505, 448)
+#define MPT_PERSIST_EN MPT_FIELD_LOC(506, 506)
+#define MPT_RSV2 MPT_FIELD_LOC(507, 507)
+#define MPT_PBL_BUF_PG_SZ MPT_FIELD_LOC(511, 508)
+
 #define V2_MPT_BYTE_4_MPT_ST_S 0
 #define V2_MPT_BYTE_4_MPT_ST_M GENMASK(1, 0)
 
-- 
2.8.1

