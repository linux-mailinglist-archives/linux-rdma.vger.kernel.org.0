Return-Path: <linux-rdma+bounces-486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF581DEED
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 08:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DA41F21DAA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 07:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4A215B9;
	Mon, 25 Dec 2023 07:58:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C044BE42;
	Mon, 25 Dec 2023 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Sz9GM753sz29gV0;
	Mon, 25 Dec 2023 15:56:43 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D2C851A01A4;
	Mon, 25 Dec 2023 15:57:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 15:57:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 3/6] RDMA/hns: Alloc MTR memory before alloc_mtt()
Date: Mon, 25 Dec 2023 15:53:27 +0800
Message-ID: <20231225075330.4116470-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
References: <20231225075330.4116470-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

From: Chengchang Tang <tangchengchang@huawei.com>

MTR memory allocation do not depend on allocation of mtt.

This patch moves the allocation of mtr before mtt in preparation for
the following optimization.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_mr.c | 47 ++++++++++++++-----------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index adc401aea8df..74ea9d8482b9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -695,7 +695,7 @@ static int mtr_alloc_bufs(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 		mtr->umem = NULL;
 		mtr->kmem = hns_roce_buf_alloc(hr_dev, total_size,
 					       buf_attr->page_shift,
-					       mtr->hem_cfg.is_direct ?
+					       !mtr_has_mtt(buf_attr) ?
 					       HNS_ROCE_BUF_DIRECT : 0);
 		if (IS_ERR(mtr->kmem)) {
 			ibdev_err(ibdev, "failed to alloc kmem, ret = %ld.\n",
@@ -1054,45 +1054,52 @@ int hns_roce_mtr_create(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
 			unsigned int ba_page_shift, struct ib_udata *udata,
 			unsigned long user_addr)
 {
+	u64 pgoff = udata ? user_addr & ~PAGE_MASK : 0;
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	ret = mtr_init_buf_cfg(hr_dev, buf_attr, &mtr->hem_cfg,
-			       udata ? user_addr & ~PAGE_MASK : 0);
-	if (ret)
-		return ret;
-
-	ret = mtr_alloc_mtt(hr_dev, mtr, ba_page_shift);
-	if (ret) {
-		ibdev_err(ibdev, "failed to alloc mtr mtt, ret = %d.\n", ret);
-		return ret;
-	}
-
 	/* The caller has its own buffer list and invokes the hns_roce_mtr_map()
 	 * to finish the MTT configuration.
 	 */
 	if (buf_attr->mtt_only) {
 		mtr->umem = NULL;
 		mtr->kmem = NULL;
-		return 0;
+	} else {
+		ret = mtr_alloc_bufs(hr_dev, mtr, buf_attr, udata, user_addr);
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to alloc mtr bufs, ret = %d.\n", ret);
+			return ret;
+		}
 	}
 
-	ret = mtr_alloc_bufs(hr_dev, mtr, buf_attr, udata, user_addr);
+	ret = mtr_init_buf_cfg(hr_dev, buf_attr, &mtr->hem_cfg, pgoff);
+	if (ret)
+		goto err_init_buf;
+
+	ret = mtr_alloc_mtt(hr_dev, mtr, ba_page_shift);
 	if (ret) {
-		ibdev_err(ibdev, "failed to alloc mtr bufs, ret = %d.\n", ret);
-		goto err_alloc_mtt;
+		ibdev_err(ibdev, "failed to alloc mtr mtt, ret = %d.\n", ret);
+		goto err_init_buf;
 	}
 
+	if (buf_attr->mtt_only)
+		return 0;
+
 	/* Write buffer's dma address to MTT */
 	ret = mtr_map_bufs(hr_dev, mtr);
-	if (ret)
+	if (ret) {
 		ibdev_err(ibdev, "failed to map mtr bufs, ret = %d.\n", ret);
-	else
-		return 0;
+		goto err_alloc_mtt;
+	}
+
+	return 0;
 
-	mtr_free_bufs(hr_dev, mtr);
 err_alloc_mtt:
 	mtr_free_mtt(hr_dev, mtr);
+err_init_buf:
+	mtr_free_bufs(hr_dev, mtr);
+
 	return ret;
 }
 
-- 
2.30.0


