Return-Path: <linux-rdma+bounces-5476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2549AA0FC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 13:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC83283ADB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3C219CC16;
	Tue, 22 Oct 2024 11:16:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DE199FB4;
	Tue, 22 Oct 2024 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595798; cv=none; b=G4bJrzXWoQ3q+RQTgMiQZkCa1EVvLy5lLzqe1IMia9A0W0RSIYO1ABBit7EH1PjgKo1yv8lOhHH+ZYhUrR6fSUUaCZJ5gKZb+xG81ch2pwHMq9noKOAPbijqKzWuzRSB8nryY/b4OoibeLowI8/3zW3okNM7PoZRXZT64/2QS+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595798; c=relaxed/simple;
	bh=MylXUyfmH/ZmS86o3jrFOLJqZnifckTuG7LXrhA0IZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9kecxFhiwfLe5dONgN7cFSievUK/V4iEDGKV6S4kJaIznfpSBoY3Cr9Eq30rzPTQjxCW/W9OKsj7l6I72VeXcEQOoqlnTgU0r84lKSPMq/+7d5bzksbdQ50VWDAupiNF3MxYjTMuTdZUi4hgNUiR9kTx/aYNC+lyW+B7urUngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XXqMx5TtKz1SD0G;
	Tue, 22 Oct 2024 19:15:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 44EE91A016C;
	Tue, 22 Oct 2024 19:16:32 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 19:16:31 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 4/5] RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
Date: Tue, 22 Oct 2024 19:10:16 +0800
Message-ID: <20241022111017.946170-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
References: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

The hem code is executed before ib_dev is registered, so use dev_*
printing instead of ibdev_* to avoid log like this:

(null): set HEM address to HW failed!

Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 44 ++++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index c7c167e2a045..ee5d2c1bb5ca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -300,7 +300,7 @@ static int calc_hem_config(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_mhop *mhop,
 			   struct hns_roce_hem_index *index)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct device *dev = hr_dev->dev;
 	unsigned long mhop_obj = obj;
 	u32 l0_idx, l1_idx, l2_idx;
 	u32 chunk_ba_num;
@@ -331,14 +331,14 @@ static int calc_hem_config(struct hns_roce_dev *hr_dev,
 		index->buf = l0_idx;
 		break;
 	default:
-		ibdev_err(ibdev, "table %u not support mhop.hop_num = %u!\n",
-			  table->type, mhop->hop_num);
+		dev_err(dev, "table %u not support mhop.hop_num = %u!\n",
+			table->type, mhop->hop_num);
 		return -EINVAL;
 	}
 
 	if (unlikely(index->buf >= table->num_hem)) {
-		ibdev_err(ibdev, "table %u exceed hem limt idx %llu, max %lu!\n",
-			  table->type, index->buf, table->num_hem);
+		dev_err(dev, "table %u exceed hem limt idx %llu, max %lu!\n",
+			table->type, index->buf, table->num_hem);
 		return -EINVAL;
 	}
 
@@ -448,14 +448,14 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
 			struct hns_roce_hem_mhop *mhop,
 			struct hns_roce_hem_index *index)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct device *dev = hr_dev->dev;
 	u32 step_idx;
 	int ret = 0;
 
 	if (index->inited & HEM_INDEX_L0) {
 		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 0);
 		if (ret) {
-			ibdev_err(ibdev, "set HEM step 0 failed!\n");
+			dev_err(dev, "set HEM step 0 failed!\n");
 			goto out;
 		}
 	}
@@ -463,7 +463,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
 	if (index->inited & HEM_INDEX_L1) {
 		ret = hr_dev->hw->set_hem(hr_dev, table, obj, 1);
 		if (ret) {
-			ibdev_err(ibdev, "set HEM step 1 failed!\n");
+			dev_err(dev, "set HEM step 1 failed!\n");
 			goto out;
 		}
 	}
@@ -475,7 +475,7 @@ static int set_mhop_hem(struct hns_roce_dev *hr_dev,
 			step_idx = mhop->hop_num;
 		ret = hr_dev->hw->set_hem(hr_dev, table, obj, step_idx);
 		if (ret)
-			ibdev_err(ibdev, "set HEM step last failed!\n");
+			dev_err(dev, "set HEM step last failed!\n");
 	}
 out:
 	return ret;
@@ -485,14 +485,14 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_hem_table *table,
 				   unsigned long obj)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_hem_index index = {};
 	struct hns_roce_hem_mhop mhop = {};
+	struct device *dev = hr_dev->dev;
 	int ret;
 
 	ret = calc_hem_config(hr_dev, table, obj, &mhop, &index);
 	if (ret) {
-		ibdev_err(ibdev, "calc hem config failed!\n");
+		dev_err(dev, "calc hem config failed!\n");
 		return ret;
 	}
 
@@ -504,7 +504,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 
 	ret = alloc_mhop_hem(hr_dev, table, &mhop, &index);
 	if (ret) {
-		ibdev_err(ibdev, "alloc mhop hem failed!\n");
+		dev_err(dev, "alloc mhop hem failed!\n");
 		goto out;
 	}
 
@@ -512,7 +512,7 @@ static int hns_roce_table_mhop_get(struct hns_roce_dev *hr_dev,
 	if (table->type < HEM_TYPE_MTT) {
 		ret = set_mhop_hem(hr_dev, table, obj, &mhop, &index);
 		if (ret) {
-			ibdev_err(ibdev, "set HEM address to HW failed!\n");
+			dev_err(dev, "set HEM address to HW failed!\n");
 			goto err_alloc;
 		}
 	}
@@ -575,7 +575,7 @@ static void clear_mhop_hem(struct hns_roce_dev *hr_dev,
 			   struct hns_roce_hem_mhop *mhop,
 			   struct hns_roce_hem_index *index)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct device *dev = hr_dev->dev;
 	u32 hop_num = mhop->hop_num;
 	u32 chunk_ba_num;
 	u32 step_idx;
@@ -605,21 +605,21 @@ static void clear_mhop_hem(struct hns_roce_dev *hr_dev,
 
 		ret = hr_dev->hw->clear_hem(hr_dev, table, obj, step_idx);
 		if (ret)
-			ibdev_warn(ibdev, "failed to clear hop%u HEM, ret = %d.\n",
-				   hop_num, ret);
+			dev_warn(dev, "failed to clear hop%u HEM, ret = %d.\n",
+				 hop_num, ret);
 
 		if (index->inited & HEM_INDEX_L1) {
 			ret = hr_dev->hw->clear_hem(hr_dev, table, obj, 1);
 			if (ret)
-				ibdev_warn(ibdev, "failed to clear HEM step 1, ret = %d.\n",
-					   ret);
+				dev_warn(dev, "failed to clear HEM step 1, ret = %d.\n",
+					 ret);
 		}
 
 		if (index->inited & HEM_INDEX_L0) {
 			ret = hr_dev->hw->clear_hem(hr_dev, table, obj, 0);
 			if (ret)
-				ibdev_warn(ibdev, "failed to clear HEM step 0, ret = %d.\n",
-					   ret);
+				dev_warn(dev, "failed to clear HEM step 0, ret = %d.\n",
+					 ret);
 		}
 	}
 }
@@ -629,14 +629,14 @@ static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 				    unsigned long obj,
 				    int check_refcount)
 {
-	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_hem_index index = {};
 	struct hns_roce_hem_mhop mhop = {};
+	struct device *dev = hr_dev->dev;
 	int ret;
 
 	ret = calc_hem_config(hr_dev, table, obj, &mhop, &index);
 	if (ret) {
-		ibdev_err(ibdev, "calc hem config failed!\n");
+		dev_err(dev, "calc hem config failed!\n");
 		return;
 	}
 
-- 
2.33.0


