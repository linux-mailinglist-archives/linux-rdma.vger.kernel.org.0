Return-Path: <linux-rdma+bounces-1890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BD8A05CD
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 04:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABC21F24A8C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1E64A9F;
	Thu, 11 Apr 2024 02:21:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9896311D
	for <linux-rdma@vger.kernel.org>; Thu, 11 Apr 2024 02:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712802115; cv=none; b=BUE/b4ro03ZQ3FzQYdxigdql1ab9r7/OIygvEAQlV24FCWrW6NQiw84v03WiOOQyxaESnSat+n2Jr/yrQUBhQVpGg7PguP2abcc5tOlTXgXyjdgluPBpGFm5vJpKu4qcab5XvJEbJN+zyriOb4jzvFrornqa0msTv84DtsA+gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712802115; c=relaxed/simple;
	bh=K4O8JfGTy+DNL4rSXSBHblJhqhRNzg9cqPfrHDq33q4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVMU68fLQYpTlS/If4de6lDTw5z1vGlU2ZOdg3LFuMTNl9JNbgW85AfwyXNmzkdNnBrpCK+EtyvXUOhtOu0GM1gtunY8V5kRBknZ2KdI9w5a4jm/wKgbCwoisutX+kFbj/MUoAZe1CUAdy2usX99e0nfW4ckc+49Oy9NEwQrlmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VFNfj6xXmzwRvS;
	Thu, 11 Apr 2024 10:18:53 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CFC5140414;
	Thu, 11 Apr 2024 10:21:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 10:21:49 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <linux-rdma@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <wangxi11@huawei.com>,
	<liweihang@huawei.com>, <chenglang@huawei.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net] RDMA/hns: fix return value in hns_roce_map_mr_sg
Date: Thu, 11 Apr 2024 10:27:57 +0800
Message-ID: <20240411022757.2591839-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)

As described in the ib_map_mr_sg function comment, it returns the number
of sg elements that were mapped to the memory region. However,
hns_roce_map_mr_sg returns the number of pages required for mapping the
DMA area. Fix it.

Fixes: 9b2cf76c9f05 ("RDMA/hns: Optimize PBL buffer allocation process")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 9e05b57a2d67..0c5e41d5c03d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -441,7 +441,7 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
-	int ret = 0;
+	int ret, sg_num;
 
 	mr->npages = 0;
 	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
@@ -449,10 +449,10 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	if (!mr->page_list)
 		return ret;
 
-	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
-	if (ret < 1) {
+	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	if (sg_num < 1) {
 		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
-			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
+			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
 		goto err_page_list;
 	}
 
@@ -463,17 +463,15 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
 	if (ret) {
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
-		ret = 0;
-	} else {
+		sg_num = 0;
+	} else
 		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
-		ret = mr->npages;
-	}
 
 err_page_list:
 	kvfree(mr->page_list);
 	mr->page_list = NULL;
 
-	return ret;
+	return sg_num;
 }
 
 static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
-- 
2.34.1


