Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABB870DC5A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjEWMSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjEWMSw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 08:18:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6355119;
        Tue, 23 May 2023 05:18:50 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QQYBl5GcDzTkl3;
        Tue, 23 May 2023 20:13:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 20:18:48 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-rc 3/3] RDMA/hns: Add clear_hem return value to log
Date:   Tue, 23 May 2023 20:16:41 +0800
Message-ID: <20230523121641.3132102-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
References: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

Log return value of clear_hem() to help diagnose.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 44 ++++++++++++++++--------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index f30274986c0d..47c0efed1821 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -619,6 +619,7 @@ static void clear_mhop_hem(struct hns_roce_dev *hr_dev,
 	u32 hop_num = mhop->hop_num;
 	u32 chunk_ba_num;
 	u32 step_idx;
+	int ret;
 
 	index->inited = HEM_INDEX_BUF;
 	chunk_ba_num = mhop->bt_chunk_size / BA_BYTE_LEN;
@@ -642,16 +643,24 @@ static void clear_mhop_hem(struct hns_roce_dev *hr_dev,
 		else
 			step_idx = hop_num;
 
-		if (hr_dev->hw->clear_hem(hr_dev, table, obj, step_idx))
-			ibdev_warn(ibdev, "failed to clear hop%u HEM.\n", hop_num);
-
-		if (index->inited & HEM_INDEX_L1)
-			if (hr_dev->hw->clear_hem(hr_dev, table, obj, 1))
-				ibdev_warn(ibdev, "failed to clear HEM step 1.\n");
+		ret = hr_dev->hw->clear_hem(hr_dev, table, obj, step_idx);
+		if (ret)
+			ibdev_warn(ibdev, "failed to clear hop%u HEM, ret = %d.\n",
+				   hop_num, ret);
+
+		if (index->inited & HEM_INDEX_L1) {
+			ret = hr_dev->hw->clear_hem(hr_dev, table, obj, 1);
+			if (ret)
+				ibdev_warn(ibdev, "failed to clear HEM step 1, ret = %d.\n",
+					   ret);
+		}
 
-		if (index->inited & HEM_INDEX_L0)
-			if (hr_dev->hw->clear_hem(hr_dev, table, obj, 0))
-				ibdev_warn(ibdev, "failed to clear HEM step 0.\n");
+		if (index->inited & HEM_INDEX_L0) {
+			ret = hr_dev->hw->clear_hem(hr_dev, table, obj, 0);
+			if (ret)
+				ibdev_warn(ibdev, "failed to clear HEM step 0, ret = %d.\n",
+					   ret);
+		}
 	}
 }
 
@@ -688,6 +697,7 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 {
 	struct device *dev = hr_dev->dev;
 	unsigned long i;
+	int ret;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
 		hns_roce_table_mhop_put(hr_dev, table, obj, 1);
@@ -700,8 +710,10 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 					 &table->mutex))
 		return;
 
-	if (hr_dev->hw->clear_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT))
-		dev_warn(dev, "failed to clear HEM base address.\n");
+	ret = hr_dev->hw->clear_hem(hr_dev, table, obj, HEM_HOP_STEP_DIRECT);
+	if (ret)
+		dev_warn(dev, "failed to clear HEM base address, ret = %d.\n",
+			 ret);
 
 	hns_roce_free_hem(hr_dev, table->hem[i]);
 	table->hem[i] = NULL;
@@ -917,6 +929,8 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 {
 	struct device *dev = hr_dev->dev;
 	unsigned long i;
+	int obj;
+	int ret;
 
 	if (hns_roce_check_whether_mhop(hr_dev, table->type)) {
 		hns_roce_cleanup_mhop_hem_table(hr_dev, table);
@@ -925,9 +939,11 @@ void hns_roce_cleanup_hem_table(struct hns_roce_dev *hr_dev,
 
 	for (i = 0; i < table->num_hem; ++i)
 		if (table->hem[i]) {
-			if (hr_dev->hw->clear_hem(hr_dev, table,
-			    i * table->table_chunk_size / table->obj_size, 0))
-				dev_err(dev, "clear HEM base address failed.\n");
+			obj = i * table->table_chunk_size / table->obj_size;
+			ret = hr_dev->hw->clear_hem(hr_dev, table, obj, 0);
+			if (ret)
+				dev_err(dev, "clear HEM base address failed, ret = %d.\n",
+					ret);
 
 			hns_roce_free_hem(hr_dev, table->hem[i]);
 		}
-- 
2.30.0

