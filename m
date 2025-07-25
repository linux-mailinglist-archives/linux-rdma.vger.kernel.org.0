Return-Path: <linux-rdma+bounces-12477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1ABB11829
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 07:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDD87A6614
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jul 2025 05:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B626CE1C;
	Fri, 25 Jul 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Lm6sDPz4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F876026
	for <linux-rdma@vger.kernel.org>; Fri, 25 Jul 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423175; cv=none; b=os8ATehaJFgb0m1Q67SoRVzJlSl9DRV0Ur/hJmCmXz9AgDCAW6Uvo6Hmtdq171/BqzWIYrIPFMgFMJlaYeIZv/GlYmKe1X5SiPjVt+bwbfowIBV4pGklhWkPMmmWfmNFlsncBOqSuoJQCCz/lSZvb22Eh4YLN9I1KrwacDz9aH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423175; c=relaxed/simple;
	bh=dOC9WO5Wh7HJ04uRJuqoj1eYJmIH4+6LCic7tuN/OQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+s5MOlge6rKwFCTRAFYHUaelMtmf87bUADPdm10smtC/1ghT1p+n3/FfraYl1H5zYZNiOsszm5dAHsd/2bul5/VERtzGq5scnG6u2SkqTlhGlK25efKNg4d+GMd+qF2GIWLjbk/i2OLoOXCkfZcB8uQwNBH8Dtw3+tLsWc04QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Lm6sDPz4; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753423171; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=E/wPF6w22BeINCrWvDxQYTml5wrSv6tobP6v5M8Hxi8=;
	b=Lm6sDPz4yYF1jOPmUxjBnqlKMSBU7sliyxXxV8uGSKf46hHt3bs5O1m3h4atew9ASUp0y+6FTIoG/8n2lzQn29u2mMvOxIWZOtLqhOZqQdhNnvUqqrflEvDABnpO02i/nGJZmS0Uu6ki3eQ0ZazC3lSdNWBNP6lBhIoOjxD6Zzw=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WjwDLDM_1753422852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 13:54:12 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com
Subject: [PATCH for-next 1/3] RDMA/erdma: Use dma_map_page to map scatter MTT buffer
Date: Fri, 25 Jul 2025 13:53:54 +0800
Message-ID: <20250725055410.67520-2-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
References: <20250725055410.67520-1-boshiyu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each high-level indirect MTT entry is assumed to point to exactly one page
of the low-level MTT buffer, but dma_map_sg may merge contiguous physical
pages when mapping. To avoid extra overhead from splitting merged regions,
use dma_map_page to map the scatter MTT buffer page by page.

Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 110 ++++++++++++++--------
 drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
 2 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 94c211df09d8..b4dadd306837 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -149,7 +149,7 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 			req.phy_addr[0] = mr->mem.mtt->buf_dma;
 			mtt_level = ERDMA_MR_MTT_1LEVEL;
 		} else {
-			req.phy_addr[0] = sg_dma_address(mr->mem.mtt->sglist);
+			req.phy_addr[0] = mr->mem.mtt->dma_addrs[0];
 			mtt_level = mr->mem.mtt->level;
 		}
 	} else if (mr->type != ERDMA_MR_TYPE_DMA) {
@@ -626,18 +626,27 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
 	return ERR_PTR(-ENOMEM);
 }
 
-static void erdma_destroy_mtt_buf_sg(struct erdma_dev *dev,
-				     struct erdma_mtt *mtt)
+static void erdma_unmap_page_list(struct erdma_dev *dev, dma_addr_t *pg_dma,
+				  u32 npages)
 {
-	dma_unmap_sg(&dev->pdev->dev, mtt->sglist,
-		     DIV_ROUND_UP(mtt->size, PAGE_SIZE), DMA_TO_DEVICE);
-	vfree(mtt->sglist);
+	u32 i;
+
+	for (i = 0; i < npages; i++)
+		dma_unmap_page(&dev->pdev->dev, pg_dma[i], PAGE_SIZE,
+			       DMA_TO_DEVICE);
+}
+
+static void erdma_destroy_mtt_buf_dma_addrs(struct erdma_dev *dev,
+					    struct erdma_mtt *mtt)
+{
+	erdma_unmap_page_list(dev, mtt->dma_addrs, mtt->npages);
+	vfree(mtt->dma_addrs);
 }
 
 static void erdma_destroy_scatter_mtt(struct erdma_dev *dev,
 				      struct erdma_mtt *mtt)
 {
-	erdma_destroy_mtt_buf_sg(dev, mtt);
+	erdma_destroy_mtt_buf_dma_addrs(dev, mtt);
 	vfree(mtt->buf);
 	kfree(mtt);
 }
@@ -645,50 +654,69 @@ static void erdma_destroy_scatter_mtt(struct erdma_dev *dev,
 static void erdma_init_middle_mtt(struct erdma_mtt *mtt,
 				  struct erdma_mtt *low_mtt)
 {
-	struct scatterlist *sg;
-	u32 idx = 0, i;
+	dma_addr_t *pg_addr = mtt->buf;
+	u32 i;
 
-	for_each_sg(low_mtt->sglist, sg, low_mtt->nsg, i)
-		mtt->buf[idx++] = sg_dma_address(sg);
+	for (i = 0; i < low_mtt->npages; i++)
+		pg_addr[i] = low_mtt->dma_addrs[i];
 }
 
-static int erdma_create_mtt_buf_sg(struct erdma_dev *dev, struct erdma_mtt *mtt)
+static u32 vmalloc_to_dma_addrs(struct erdma_dev *dev, dma_addr_t **dma_addrs,
+				void *buf, u64 len)
 {
-	struct scatterlist *sglist;
-	void *buf = mtt->buf;
-	u32 npages, i, nsg;
+	dma_addr_t *pg_dma;
 	struct page *pg;
+	u32 npages, i;
+	void *addr;
 
-	/* Failed if buf is not page aligned */
-	if ((uintptr_t)buf & ~PAGE_MASK)
-		return -EINVAL;
-
-	npages = DIV_ROUND_UP(mtt->size, PAGE_SIZE);
-	sglist = vzalloc(npages * sizeof(*sglist));
-	if (!sglist)
-		return -ENOMEM;
+	npages = (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
+		 PAGE_SHIFT;
+	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
+	if (!pg_dma)
+		return 0;
 
-	sg_init_table(sglist, npages);
+	addr = buf;
 	for (i = 0; i < npages; i++) {
-		pg = vmalloc_to_page(buf);
+		pg = vmalloc_to_page(addr);
 		if (!pg)
 			goto err;
-		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
-		buf += PAGE_SIZE;
+
+		pg_dma[i] = dma_map_page(&dev->pdev->dev, pg, 0, PAGE_SIZE,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(&dev->pdev->dev, pg_dma[i]))
+			goto err;
+
+		addr += PAGE_SIZE;
 	}
 
-	nsg = dma_map_sg(&dev->pdev->dev, sglist, npages, DMA_TO_DEVICE);
-	if (!nsg)
-		goto err;
+	*dma_addrs = pg_dma;
 
-	mtt->sglist = sglist;
-	mtt->nsg = nsg;
+	return npages;
+err:
+	erdma_unmap_page_list(dev, pg_dma, i);
+	vfree(pg_dma);
 
 	return 0;
-err:
-	vfree(sglist);
+}
 
-	return -ENOMEM;
+static int erdma_create_mtt_buf_dma_addrs(struct erdma_dev *dev,
+					  struct erdma_mtt *mtt)
+{
+	dma_addr_t *addrs;
+	u32 npages;
+
+	/* Failed if buf is not page aligned */
+	if ((uintptr_t)mtt->buf & ~PAGE_MASK)
+		return -EINVAL;
+
+	npages = vmalloc_to_dma_addrs(dev, &addrs, mtt->buf, mtt->size);
+	if (!npages)
+		return -ENOMEM;
+
+	mtt->dma_addrs = addrs;
+	mtt->npages = npages;
+
+	return 0;
 }
 
 static struct erdma_mtt *erdma_create_scatter_mtt(struct erdma_dev *dev,
@@ -707,12 +735,12 @@ static struct erdma_mtt *erdma_create_scatter_mtt(struct erdma_dev *dev,
 	if (!mtt->buf)
 		goto err_free_mtt;
 
-	ret = erdma_create_mtt_buf_sg(dev, mtt);
+	ret = erdma_create_mtt_buf_dma_addrs(dev, mtt);
 	if (ret)
 		goto err_free_mtt_buf;
 
-	ibdev_dbg(&dev->ibdev, "create scatter mtt, size:%lu, nsg:%u\n",
-		  mtt->size, mtt->nsg);
+	ibdev_dbg(&dev->ibdev, "create scatter mtt, size:%lu, npages:%u\n",
+		  mtt->size, mtt->npages);
 
 	return mtt;
 
@@ -746,8 +774,8 @@ static struct erdma_mtt *erdma_create_mtt(struct erdma_dev *dev, size_t size,
 	level = 1;
 
 	/* convergence the mtt table. */
-	while (mtt->nsg != 1 && level <= 3) {
-		tmp_mtt = erdma_create_scatter_mtt(dev, MTT_SIZE(mtt->nsg));
+	while (mtt->npages != 1 && level <= 3) {
+		tmp_mtt = erdma_create_scatter_mtt(dev, MTT_SIZE(mtt->npages));
 		if (IS_ERR(tmp_mtt)) {
 			ret = PTR_ERR(tmp_mtt);
 			goto err_free_mtt;
@@ -765,7 +793,7 @@ static struct erdma_mtt *erdma_create_mtt(struct erdma_dev *dev, size_t size,
 
 	mtt->level = level;
 	ibdev_dbg(&dev->ibdev, "top mtt: level:%d, dma_addr 0x%llx\n",
-		  mtt->level, mtt->sglist[0].dma_address);
+		  mtt->level, mtt->dma_addrs[0]);
 
 	return mtt;
 err_free_mtt:
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index ef411b81fbd7..7d8d3fe501d5 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -99,8 +99,8 @@ struct erdma_mtt {
 	union {
 		dma_addr_t buf_dma;
 		struct {
-			struct scatterlist *sglist;
-			u32 nsg;
+			dma_addr_t *dma_addrs;
+			u32 npages;
 			u32 level;
 		};
 	};
-- 
2.46.0


