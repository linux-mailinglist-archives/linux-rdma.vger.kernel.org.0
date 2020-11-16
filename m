Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0162B433C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKPMA1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 07:00:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7916 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgKPMA1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 07:00:27 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZSLc0tv7z6xlZ;
        Mon, 16 Nov 2020 20:00:08 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 20:00:12 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v2 for-next 1/2] RDMA/hns: Add support for CQ stash
Date:   Mon, 16 Nov 2020 19:58:38 +0800
Message-ID: <1605527919-48769-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
References: <1605527919-48769-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_common.h | 12 +++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
 4 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff..8d96c4e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -53,6 +53,18 @@
 #define roce_set_bit(origin, shift, val) \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
+#define FIELD_LOC(field_h, field_l) field_h, field_l
+
+#define _hr_reg_set(arr, field_h, field_l)                                     \
+	do {                                                                   \
+		BUILD_BUG_ON(((field_h) / 32) != ((field_l) / 32));            \
+		BUILD_BUG_ON((field_h) / 32 >= ARRAY_SIZE(arr));               \
+		(arr)[(field_h) / 32] |=                                       \
+			cpu_to_le32(GENMASK((field_h) % 32, (field_l) % 32));  \
+	} while (0)
+
+#define hr_reg_set(arr, field) _hr_reg_set(arr, field)
+
 #define ROCEE_GLB_CFG_ROCEE_DB_SQ_MODE_S 3
 #define ROCEE_GLB_CFG_ROCEE_DB_OTH_MODE_S 4
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 1d99022..ab7df8e 100644
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
index 4d697e4..5fd0458 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3177,6 +3177,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
 		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		hr_reg_set(cq_context->raw, CQC_STASH);
+
 	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 
 	roce_set_field(cq_context->byte_16_hop_addr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 1409d05..50a5187 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -267,22 +267,27 @@ enum hns_roce_sgid_type {
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
+	union {
+		struct {
+			__le32 byte_4_pg_ceqn;
+			__le32 byte_8_cqn;
+			__le32 cqe_cur_blk_addr;
+			__le32 byte_16_hop_addr;
+			__le32 cqe_nxt_blk_addr;
+			__le32 byte_24_pgsz_addr;
+			__le32 byte_28_cq_pi;
+			__le32 byte_32_cq_ci;
+			__le32 cqe_ba;
+			__le32 byte_40_cqe_ba;
+			__le32 byte_44_db_record;
+			__le32 db_record_addr;
+			__le32 byte_52_cqe_cnt;
+			__le32 byte_56_cqe_period_maxcnt;
+			__le32 cqe_report_timer;
+			__le32 byte_64_se_cqe_idx;
+		};
+		__le32 raw[16];
+	};
 };
 #define HNS_ROCE_V2_CQ_DEFAULT_BURST_NUM 0x0
 #define HNS_ROCE_V2_CQ_DEFAULT_INTERVAL	0x0
@@ -360,6 +365,8 @@ struct hns_roce_v2_cq_context {
 #define	V2_CQC_BYTE_64_SE_CQE_IDX_S 0
 #define	V2_CQC_BYTE_64_SE_CQE_IDX_M GENMASK(23, 0)
 
+#define CQC_STASH FIELD_LOC(63, 63)
+
 struct hns_roce_srq_context {
 	__le32	byte_4_srqn_srqst;
 	__le32	byte_8_limit_wl;
-- 
2.8.1

