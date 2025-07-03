Return-Path: <linux-rdma+bounces-11865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552ECAF72A3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D2487DFD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65B2E425D;
	Thu,  3 Jul 2025 11:39:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4C2E3B1E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542757; cv=none; b=fVT1hKc/lHdESFzluQkwaVjSD24DrJFiUwIRhVv5yEFi90SVRlgcHnAKEI4WKpffTldP0ssu9FSIjooHQW0ncz7aWvg4MW0RjkBkfFfSB1m24dsfaJOP9DGjvLmDkBeYnXmN01WvRXCTYSi2CGRii/Y7ivZqj1aW2DfQLBA2bnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542757; c=relaxed/simple;
	bh=8KbcrKQSMWoP+ChG2tVR/NRgunsZ2OiVDPwb3kNkHK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2Z5j9YMS1aHdBd7vrSOTSpSTSPW0YPNBBGWTyuvTtU6hIlyxpqRxiHvVfkpSG9PoOG5Gqiw6TQ0OhUf6MkS0XUYA1BPduA8JnPpBhRsay28+dM2mQIvSWfDxrGXosHnr2VEvRsuikodFRK4OyP9GV45HqDjXthNqCl8GWzcuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bXvrJ6CvCz2SStg;
	Thu,  3 Jul 2025 19:37:20 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BAEC1A016C;
	Thu,  3 Jul 2025 19:39:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:07 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 5/6] RDMA/hns: Drop GFP_NOWARN
Date: Thu, 3 Jul 2025 19:39:04 +0800
Message-ID: <20250703113905.3597124-6-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
References: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)

GFP_NOWARN silences all warnings on dma_alloc_coherent() failure,
which might otherwise help with troubleshooting.

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index ca0798224e56..3d479c63b117 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -249,15 +249,12 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 }
 
 static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
-					       unsigned long hem_alloc_size,
-					       gfp_t gfp_mask)
+					       unsigned long hem_alloc_size)
 {
 	struct hns_roce_hem *hem;
 	int order;
 	void *buf;
 
-	WARN_ON(gfp_mask & __GFP_HIGHMEM);
-
 	order = get_order(hem_alloc_size);
 	if (PAGE_SIZE << order != hem_alloc_size) {
 		dev_err(hr_dev->dev, "invalid hem_alloc_size: %lu!\n",
@@ -265,13 +262,12 @@ static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 		return NULL;
 	}
 
-	hem = kmalloc(sizeof(*hem),
-		      gfp_mask & ~(__GFP_HIGHMEM | __GFP_NOWARN));
+	hem = kmalloc(sizeof(*hem), GFP_KERNEL);
 	if (!hem)
 		return NULL;
 
 	buf = dma_alloc_coherent(hr_dev->dev, hem_alloc_size,
-				 &hem->dma, gfp_mask);
+				 &hem->dma, GFP_KERNEL);
 	if (!buf)
 		goto fail;
 
@@ -378,7 +374,6 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 {
 	u32 bt_size = mhop->bt_chunk_size;
 	struct device *dev = hr_dev->dev;
-	gfp_t flag;
 	u64 bt_ba;
 	u32 size;
 	int ret;
@@ -417,8 +412,7 @@ static int alloc_mhop_hem(struct hns_roce_dev *hr_dev,
 	 * alloc bt space chunk for MTT/CQE.
 	 */
 	size = table->type < HEM_TYPE_MTT ? mhop->buf_chunk_size : bt_size;
-	flag = GFP_KERNEL | __GFP_NOWARN;
-	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size, flag);
+	table->hem[index->buf] = hns_roce_alloc_hem(hr_dev, size);
 	if (!table->hem[index->buf]) {
 		ret = -ENOMEM;
 		goto err_alloc_hem;
@@ -546,9 +540,7 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 		goto out;
 	}
 
-	table->hem[i] = hns_roce_alloc_hem(hr_dev,
-				       table->table_chunk_size,
-				       GFP_KERNEL | __GFP_NOWARN);
+	table->hem[i] = hns_roce_alloc_hem(hr_dev, table->table_chunk_size);
 	if (!table->hem[i]) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.33.0


