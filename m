Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F168E2C4F1D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 08:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgKZHGC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 02:06:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7992 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388266AbgKZHGB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 02:06:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ChTLF1Yr6zhdyc;
        Thu, 26 Nov 2020 15:05:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 15:05:49 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v4 for-next 1/2] RDMA/hns: Add support for CQ stash
Date:   Thu, 26 Nov 2020 15:04:10 +0800
Message-ID: <1606374251-21512-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1606374251-21512-1-git-send-email-liweihang@huawei.com>
References: <1606374251-21512-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

Stash is a mechanism that uses the core information carried by the ARM AXI
bus to access the L3 cache. It can be used to improve the performance by
increasing the hit ratio of L3 cache. CQs need to enable stash by default.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_common.h | 12 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 37 ++++++++++++++++-------------
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff..29469e1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -53,6 +53,18 @@
 #define roce_set_bit(origin, shift, val) \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
+#define FIELD_LOC(field_type, field_h, field_l) field_type, field_h, field_l
+
+#define _hr_reg_enable(ptr, field_type, field_h, field_l)                      \
+	({                                                                     \
+		const field_type *_ptr = ptr;                                  \
+		*((__le32 *)_ptr + (field_h) / 32) |=                          \
+			cpu_to_le32(BIT((field_l) % 32)) +                     \
+			BUILD_BUG_ON_ZERO((field_h) != (field_l));             \
+	})
+
+#define hr_reg_enable(ptr, field) _hr_reg_enable(ptr, field)
+
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
 #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 11a137f..7bd447c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -223,6 +223,7 @@ enum {
 	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
 	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
 	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
+	HNS_ROCE_CAP_FLAG_STASH			= BIT(17),
 };
 
 #define HNS_ROCE_DB_TYPE_COUNT			2
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4b82912..d0f561d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3177,6 +3177,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
 		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		hr_reg_enable(cq_context, CQC_STASH);
+
 	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 
 	roce_set_field(cq_context->byte_16_hop_addr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1409d05..917d6cf 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -267,23 +267,24 @@ enum hns_roce_sgid_type {
 };
 
 struct hns_roce_v2_cq_context {
-	__le32	byte_4_pg_ceqn;
-	__le32	byte_8_cqn;
-	__le32	cqe_cur_blk_addr;
-	__le32	byte_16_hop_addr;
-	__le32	cqe_nxt_blk_addr;
-	__le32	byte_24_pgsz_addr;
-	__le32	byte_28_cq_pi;
-	__le32	byte_32_cq_ci;
-	__le32	cqe_ba;
-	__le32	byte_40_cqe_ba;
-	__le32	byte_44_db_record;
-	__le32	db_record_addr;
-	__le32	byte_52_cqe_cnt;
-	__le32	byte_56_cqe_period_maxcnt;
-	__le32	cqe_report_timer;
-	__le32	byte_64_se_cqe_idx;
+	__le32 byte_4_pg_ceqn;
+	__le32 byte_8_cqn;
+	__le32 cqe_cur_blk_addr;
+	__le32 byte_16_hop_addr;
+	__le32 cqe_nxt_blk_addr;
+	__le32 byte_24_pgsz_addr;
+	__le32 byte_28_cq_pi;
+	__le32 byte_32_cq_ci;
+	__le32 cqe_ba;
+	__le32 byte_40_cqe_ba;
+	__le32 byte_44_db_record;
+	__le32 db_record_addr;
+	__le32 byte_52_cqe_cnt;
+	__le32 byte_56_cqe_period_maxcnt;
+	__le32 cqe_report_timer;
+	__le32 byte_64_se_cqe_idx;
 };
+
 #define HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM 0x0
 #define HNS_ROCE_V2_CQ_DEFAULT_INTERVAL	0x0
 
@@ -360,6 +361,10 @@ struct hns_roce_v2_cq_context {
 #define	V2_CQC_BYTE_64_SE_CQE_IDX_S 0
 #define	V2_CQC_BYTE_64_SE_CQE_IDX_M GENMASK(23, 0)
 
+#define CQC_FIELD_LOC(h, l) FIELD_LOC(struct hns_roce_v2_cq_context, h, l)
+
+#define CQC_STASH CQC_FIELD_LOC(63, 63)
+
 struct hns_roce_srq_context {
 	__le32	byte_4_srqn_srqst;
 	__le32	byte_8_limit_wl;
-- 
2.8.1

