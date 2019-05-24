Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7D291CC
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbfEXHcp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 03:32:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17557 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389021AbfEXHco (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 May 2019 03:32:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 79AA5113F505E2CE7530;
        Fri, 24 May 2019 15:32:41 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 May 2019 15:32:33 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next 4/4] RDMA/hns: Remove jiffies operation in disable interrupt context
Date:   Fri, 24 May 2019 15:31:23 +0800
Message-ID: <1558683083-79692-5-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
References: <1558683083-79692-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

In some functions, the jiffies operation is unnecessary, and we
can control delay using mdelay and udelay functions only.
Especially, in hns_roce_v1_clear_hem, the function calls
spin_lock_irqsave, the context disables interrupt, so we
can not use jiffies and msleep functions.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
---
V1->V2:
1. Rewrite the commit information according to Leon Romanovsky's
reviews
---
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 21 +++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 19 ++++++++++---------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 8e29dbb..d0eacd8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -376,18 +376,19 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
 
 		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
 
-		end = msecs_to_jiffies(HW_SYNC_TIMEOUT_MSECS) + jiffies;
-		while (1) {
-			if (readl(bt_cmd) >> BT_CMD_SYNC_SHIFT) {
-				if (!(time_before(jiffies, end))) {
-					dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
-					spin_unlock_irqrestore(lock, flags);
-					return -EBUSY;
-				}
-			} else {
+		end = HW_SYNC_TIMEOUT_MSECS;
+		while (end) {
+			if (!readl(bt_cmd) >> BT_CMD_SYNC_SHIFT)
 				break;
-			}
+
 			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
+			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
+		}
+
+		if (end <= 0) {
+			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
+			spin_unlock_irqrestore(lock, flags);
+			return -EBUSY;
 		}
 
 		bt_cmd_l = (u32)bt_ba;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index c35a4de..8b3169a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -965,8 +965,7 @@ static int hns_roce_v1_recreate_lp_qp(struct hns_roce_dev *hr_dev)
 	struct hns_roce_free_mr *free_mr;
 	struct hns_roce_v1_priv *priv;
 	struct completion comp;
-	unsigned long end =
-	  msecs_to_jiffies(HNS_ROCE_V1_RECREATE_LP_QP_TIMEOUT_MSECS) + jiffies;
+	unsigned long end = HNS_ROCE_V1_RECREATE_LP_QP_TIMEOUT_MSECS;
 
 	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
 	free_mr = &priv->free_mr;
@@ -986,10 +985,11 @@ static int hns_roce_v1_recreate_lp_qp(struct hns_roce_dev *hr_dev)
 
 	queue_work(free_mr->free_mr_wq, &(lp_qp_work->work));
 
-	while (time_before_eq(jiffies, end)) {
+	while (end) {
 		if (try_wait_for_completion(&comp))
 			return 0;
 		msleep(HNS_ROCE_V1_RECREATE_LP_QP_WAIT_VALUE);
+		end -= HNS_ROCE_V1_RECREATE_LP_QP_WAIT_VALUE;
 	}
 
 	lp_qp_work->comp_flag = 0;
@@ -1103,8 +1103,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 	struct hns_roce_free_mr *free_mr;
 	struct hns_roce_v1_priv *priv;
 	struct completion comp;
-	unsigned long end =
-		msecs_to_jiffies(HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS) + jiffies;
+	unsigned long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS ;
 	unsigned long start = jiffies;
 	int npages;
 	int ret = 0;
@@ -1134,10 +1133,11 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
 
 	queue_work(free_mr->free_mr_wq, &(mr_work->work));
 
-	while (time_before_eq(jiffies, end)) {
+	while (end) {
 		if (try_wait_for_completion(&comp))
 			goto free_mr;
 		msleep(HNS_ROCE_V1_FREE_MR_WAIT_VALUE);
+		end -= HNS_ROCE_V1_FREE_MR_WAIT_VALUE;
 	}
 
 	mr_work->comp_flag = 0;
@@ -2462,10 +2462,10 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 
 	bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
 
-	end = msecs_to_jiffies(HW_SYNC_TIMEOUT_MSECS) + jiffies;
+	end = HW_SYNC_TIMEOUT_MSECS;
 	while (1) {
 		if (readl(bt_cmd) >> BT_CMD_SYNC_SHIFT) {
-			if (!(time_before(jiffies, end))) {
+			if (end < 0) {
 				dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
 				spin_unlock_irqrestore(&hr_dev->bt_cmd_lock,
 					flags);
@@ -2474,7 +2474,8 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
 		} else {
 			break;
 		}
-		msleep(HW_SYNC_SLEEP_TIME_INTERVAL);
+		mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
+		end -= HW_SYNC_SLEEP_TIME_INTERVAL;
 	}
 
 	bt_cmd_val[0] = (__le32)bt_ba;
-- 
1.9.1

