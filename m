Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C7D38C322
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhEUJcA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:32:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5716 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbhEUJbr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:31:47 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fmh7X18hFzqVWm;
        Fri, 21 May 2021 17:26:32 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:03 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:30:03 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, "Xi Wang" <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 5/5] RDMA/hns: Clean the hardware related code for HEM
Date:   Fri, 21 May 2021 17:29:55 +0800
Message-ID: <1621589395-2435-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
References: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Move the HIP06 related code to the hw v1 source file for HEM.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 -
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 82 +----------------------------
 drivers/infiniband/hw/hns/hns_roce_hem.h    |  9 +---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 77 +++++++++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |  5 ++
 5 files changed, 85 insertions(+), 90 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 02fffb7..c6cacd2 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -47,8 +47,6 @@
 
 #define HNS_ROCE_IB_MIN_SQ_STRIDE		6
 
-#define HNS_ROCE_BA_SIZE			(32 * 4096)
-
 #define BA_BYTE_LEN				8
 
 /* Hardware specification only for v1 engine */
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index fe6940b..7fdeedd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -36,9 +36,6 @@
 #include "hns_roce_hem.h"
 #include "hns_roce_common.h"
 
-#define DMA_ADDR_T_SHIFT		12
-#define BT_BA_SHIFT			32
-
 #define HEM_INDEX_BUF			BIT(0)
 #define HEM_INDEX_L0			BIT(1)
 #define HEM_INDEX_L1			BIT(2)
@@ -337,81 +334,6 @@ void hns_roce_free_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem *hem)
 	kfree(hem);
 }
 
-static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_hem_table *table, unsigned long obj)
-{
-	spinlock_t *lock = &hr_dev->bt_cmd_lock;
-	struct device *dev = hr_dev->dev;
-	struct hns_roce_hem_iter iter;
-	void __iomem *bt_cmd;
-	__le32 bt_cmd_val[2];
-	__le32 bt_cmd_h = 0;
-	unsigned long flags;
-	__le32 bt_cmd_l;
-	int ret = 0;
-	u64 bt_ba;
-	long end;
-
-	/* Find the HEM(Hardware Entry Memory) entry */
-	unsigned long i = (obj & (table->num_obj - 1)) /
-			  (table->table_chunk_size / table->obj_size);
-
-	switch (table->type) {
-	case HEM_TYPE_QPC:
-	case HEM_TYPE_MTPT:
-	case HEM_TYPE_CQC:
-	case HEM_TYPE_SRQC:
-		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
-			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
-		break;
-	default:
-		return ret;
-	}
-
-	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
-		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
-	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
-	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
-
-	/* Currently iter only a chunk */
-	for (hns_roce_hem_first(table->hem[i], &iter);
-	     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
-		bt_ba = hns_roce_hem_addr(&iter) >> DMA_ADDR_T_SHIFT;
-
-		spin_lock_irqsave(lock, flags);
-
-		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
-
-		end = HW_SYNC_TIMEOUT_MSECS;
-		while (end > 0) {
-			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
-				break;
-
-			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
-			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
-		}
-
-		if (end <= 0) {
-			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
-			spin_unlock_irqrestore(lock, flags);
-			return -EBUSY;
-		}
-
-		bt_cmd_l = cpu_to_le32(bt_ba);
-		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
-			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
-			       bt_ba >> BT_BA_SHIFT);
-
-		bt_cmd_val[0] = bt_cmd_l;
-		bt_cmd_val[1] = bt_cmd_h;
-		hns_roce_write64_k(bt_cmd_val,
-				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
-		spin_unlock_irqrestore(lock, flags);
-	}
-
-	return ret;
-}
-
 static int calc_hem_config(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_table *table, unsigned long obj,
 			   struct hns_roce_hem_mhop *mhop,
@@ -677,7 +599,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	}
 
 	/* Set HEM base address(128K/page, pa) to Hardware */
-	if (hns_roce_set_hem(hr_dev, table, obj)) {
+	if (hr_dev->hw->set_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT)) {
 		hns_roce_free_hem(hr_dev, table->hem[i]);
 		table->hem[i] = NULL;
 		ret = -ENODEV;
@@ -782,7 +704,7 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 					 &table->mutex))
 		return;
 
-	if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
+	if (hr_dev->hw->clear_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT))
 		dev_warn(dev, "failed to clear HEM base address.\n");
 
 	hns_roce_free_hem(hr_dev, table->hem[i]);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index ffa65e8..2d84a6b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -34,9 +34,7 @@
 #ifndef _HNS_ROCE_HEM_H
 #define _HNS_ROCE_HEM_H
 
-#define HW_SYNC_SLEEP_TIME_INTERVAL	20
-#define HW_SYNC_TIMEOUT_MSECS           (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
-#define BT_CMD_SYNC_SHIFT		31
+#define HEM_HOP_STEP_DIRECT 0xff
 
 enum {
 	/* MAP HEM(Hardware Entry Memory) */
@@ -74,11 +72,6 @@ enum {
 	(type >= HEM_TYPE_MTT && hop_num == 1) || \
 	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
 
-enum {
-	 HNS_ROCE_HEM_PAGE_SHIFT = 12,
-	 HNS_ROCE_HEM_PAGE_SIZE  = 1 << HNS_ROCE_HEM_PAGE_SHIFT,
-};
-
 struct hns_roce_hem_chunk {
 	struct list_head	 list;
 	int			 npages;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 620acf6..0c836cc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -462,6 +462,82 @@ static void hns_roce_set_db_event_mode(struct hns_roce_dev *hr_dev,
 	roce_write(hr_dev, ROCEE_GLB_CFG_REG, val);
 }
 
+static int hns_roce_v1_set_hem(struct hns_roce_dev *hr_dev,
+			       struct hns_roce_hem_table *table, int obj,
+			       int step_idx)
+{
+	spinlock_t *lock = &hr_dev->bt_cmd_lock;
+	struct device *dev = hr_dev->dev;
+	struct hns_roce_hem_iter iter;
+	void __iomem *bt_cmd;
+	__le32 bt_cmd_val[2];
+	__le32 bt_cmd_h = 0;
+	unsigned long flags;
+	__le32 bt_cmd_l;
+	int ret = 0;
+	u64 bt_ba;
+	long end;
+
+	/* Find the HEM(Hardware Entry Memory) entry */
+	unsigned long i = (obj & (table->num_obj - 1)) /
+			  (table->table_chunk_size / table->obj_size);
+
+	switch (table->type) {
+	case HEM_TYPE_QPC:
+	case HEM_TYPE_MTPT:
+	case HEM_TYPE_CQC:
+	case HEM_TYPE_SRQC:
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_M,
+			ROCEE_BT_CMD_H_ROCEE_BT_CMD_MDF_S, table->type);
+		break;
+	default:
+		return ret;
+	}
+
+	roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_M,
+		       ROCEE_BT_CMD_H_ROCEE_BT_CMD_IN_MDF_S, obj);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_S, 0);
+	roce_set_bit(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_HW_SYNS_S, 1);
+
+	/* Currently iter only a chunk */
+	for (hns_roce_hem_first(table->hem[i], &iter);
+	     !hns_roce_hem_last(&iter); hns_roce_hem_next(&iter)) {
+		bt_ba = hns_roce_hem_addr(&iter) >> HNS_HW_PAGE_SHIFT;
+
+		spin_lock_irqsave(lock, flags);
+
+		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
+
+		end = HW_SYNC_TIMEOUT_MSECS;
+		while (end > 0) {
+			if (!(readl(bt_cmd) >> BT_CMD_SYNC_SHIFT))
+				break;
+
+			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
+			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
+		}
+
+		if (end <= 0) {
+			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
+			spin_unlock_irqrestore(lock, flags);
+			return -EBUSY;
+		}
+
+		bt_cmd_l = cpu_to_le32(bt_ba);
+		roce_set_field(bt_cmd_h, ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_M,
+			       ROCEE_BT_CMD_H_ROCEE_BT_CMD_BA_H_S,
+			       upper_32_bits(bt_ba));
+
+		bt_cmd_val[0] = bt_cmd_l;
+		bt_cmd_val[1] = bt_cmd_h;
+		hns_roce_write64_k(bt_cmd_val,
+				   hr_dev->reg_base + ROCEE_BT_CMD_L_REG);
+		spin_unlock_irqrestore(lock, flags);
+	}
+
+	return ret;
+}
+
 static void hns_roce_set_db_ext_mode(struct hns_roce_dev *hr_dev, u32 sdb_mode,
 				     u32 odb_mode)
 {
@@ -4352,6 +4428,7 @@ static const struct hns_roce_hw hns_roce_hw_v1 = {
 	.set_mtu = hns_roce_v1_set_mtu,
 	.write_mtpt = hns_roce_v1_write_mtpt,
 	.write_cqc = hns_roce_v1_write_cqc,
+	.set_hem = hns_roce_v1_set_hem,
 	.clear_hem = hns_roce_v1_clear_hem,
 	.modify_qp = hns_roce_v1_modify_qp,
 	.dereg_mr = hns_roce_v1_dereg_mr,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
index 8438323..60fdcba 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.h
@@ -1085,6 +1085,11 @@ struct hns_roce_db_table {
 	struct hns_roce_ext_db *ext_db;
 };
 
+#define HW_SYNC_SLEEP_TIME_INTERVAL 20
+#define HW_SYNC_TIMEOUT_MSECS (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
+#define BT_CMD_SYNC_SHIFT 31
+#define HNS_ROCE_BA_SIZE (32 * 4096)
+
 struct hns_roce_bt_table {
 	struct hns_roce_buf_list qpc_buf;
 	struct hns_roce_buf_list mtpt_buf;
-- 
2.7.4

