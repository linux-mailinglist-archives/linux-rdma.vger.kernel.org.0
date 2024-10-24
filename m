Return-Path: <linux-rdma+bounces-5502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B19AE54A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 14:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36061C253BC
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45061DFE4;
	Thu, 24 Oct 2024 12:46:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903E1E86E;
	Thu, 24 Oct 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773985; cv=none; b=lCcIDElqht2zeWKrQAL/PotNMVDU2cVpvPjaAFUuoOQzr5Siqnuvga29S2eXM4sSxk7hGanTrNolOZAlhFspc2Va+JFuUN43hKx7iiln+xt5WuuNIg2Z0wVNWpJID6bzCtmp3dbHwwztC0iJt3/lS2Uh5z51mk3cfKVwXkWWkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773985; c=relaxed/simple;
	bh=MylXUyfmH/ZmS86o3jrFOLJqZnifckTuG7LXrhA0IZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHeErDMudLF+ynsR/EtxF47Vi8Mh+Cpa42QgUQI6fsLbAZpg2FuLs4rfouElrBxVNkXCQ/H6Veal4reUrNJj6UlGBiYgEf8mpluY2GrOIE2XefO7NxDKR1up8caVtwCJj73EwjLQJmvHTASZCnvUgxUly95QcrAT1ktjY2wdDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZ5Fx5KH0zpWvZ;
	Thu, 24 Oct 2024 20:44:21 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DF22180103;
	Thu, 24 Oct 2024 20:46:18 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 20:46:17 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 for-rc 4/5] RDMA/hns: Use dev_* printings in hem code instead of ibdev_*
Date: Thu, 24 Oct 2024 20:39:59 +0800
Message-ID: <20241024124000.2931869-5-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
References: <20241024124000.2931869-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


