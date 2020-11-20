Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E292BA738
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgKTKTI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 05:19:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7663 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKTKTI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 05:19:08 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ccsvq4DNHz15NkQ;
        Fri, 20 Nov 2020 18:18:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 18:18:57 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 1/2] RDMA/hns: Add support for CQ stash
Date:   Fri, 20 Nov 2020 18:17:19 +0800
Message-ID: <1605867440-2413-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
References: <1605867440-2413-1-git-send-email-liweihang@huawei.com>
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
 drivers/infiniband/hw/hns/hns_roce_common.h | 10 ++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  3 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 39 +++++++++++++++++------------
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_common.h b/drivers/infiniband/hw/hns/hns_roce_common.h
index f5669ff..41a2252 100644
--- a/drivers/infiniband/hw/hns/hns_roce_common.h
+++ b/drivers/infiniband/hw/hns/hns_roce_common.h
@@ -53,6 +53,16 @@
 #define roce_set_bit(origin, shift, val) \
 	roce_set_field((origin), (1ul << (shift)), (shift), (val))
 
+#define FIELD_LOC(field_h, field_l) field_h, field_l
+
+#define _hr_reg_enable(arr, field_h, field_l)                                  \
+	(arr)[(field_l) / 32] |=                                               \
+		(BIT((field_l) % 32)) +                                        \
+		BUILD_BUG_ON_ZERO((field_h) != (field_l)) +                    \
+		BUILD_BUG_ON_ZERO((field_l) / 32 >= ARRAY_SIZE(arr))
+
+#define hr_reg_enable(arr, field) _hr_reg_enable(arr, field)
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
index 4b82912..da7f909 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3177,6 +3177,9 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
 		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
 
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_STASH)
+		hr_reg_enable(cq_context->raw, CQC_STASH);
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

