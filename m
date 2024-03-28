Return-Path: <linux-rdma+bounces-1267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B9871D57
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CCF1F2387C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 11:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB75BAF6;
	Tue,  5 Mar 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtR+RVnD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07475676A;
	Tue,  5 Mar 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637555; cv=none; b=sfoHu4AomiLMp3L63kf1/xlAUylwmzm35t7Fxe7AKgRh1gfLPkpRyWBjfYNmfRLZm2QK79MKmmn/Kb2G85BGJJnBlS6F7HX+VIP/RdleuHTnsewWAmVCEEMaTNSbhaX5/GYUdGZnlu9XpCbva6u+mqhqLRAJIdpqEmS6lQT+bSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637555; c=relaxed/simple;
	bh=fDITfGtiOJR6jcG42lBCR+mHX3ThOxLIN0l1OlLSZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0dGs4oq7SJth9HGvCYLWg3v5rQ/EzMlc8fmfv5XvhkiYP5FQbPzpMhlZLUwZG/T/KZgg7ReLmTZgo+8/qtGeYeCFFzFbIKSZQlx2dd9+ffJbTlkQiVrzOH3IuuCugPsLgaEdh0iH5Ena75xtbldT3lTdi66vfvxG2r3r5y+KTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtR+RVnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF30FC43399;
	Tue,  5 Mar 2024 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637554;
	bh=fDITfGtiOJR6jcG42lBCR+mHX3ThOxLIN0l1OlLSZWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtR+RVnDuKHTmkad8An+k+08jfF/EbhAR2Ufm0sY+g7oiOpnM3KqMyBeFha9FWL7u
	 b2boG4rlmSWII7lfBNUMjOhEuaYoY23cUWa/HkOBe/t6ai8nTS3MPFMk2LN3IkjZ39
	 BMLsiBs1EKWHs80tDc5Rxm7i3whu9DKChJtmQbKiYp5rHil6wGXNsTaJJ7p90P7Z28
	 VxkSTyod4a91q2BlUn5JwOCrTAHYYFefrP6ABgy8IV3ATLOOz7Lpps3mK9vbjNmWWb
	 ve/h7tSzs2BOjn9kxTPFrDD5D+Rg1KdtwI3dCfQbpH++v7TFOZIIYca6Gx4SZqTQtc
	 DbdmkCjQVpg1g==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC RESEND 05/16] iommu/dma: Prepare map/unmap page functions to receive IOVA
Date: Tue,  5 Mar 2024 13:18:36 +0200
Message-ID: <13187a8682ab4f8708ca88cc4363f90e64e14ccc.1709635535.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709635535.git.leon@kernel.org>
References: <cover.1709635535.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Extend the existing map_page/unmap_page function implementations to get
preallocated IOVA. In such case, the IOVA allocation needs to be
skipped, but rest of the code stays the same.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 68 ++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e55726783501..dbdd373a609a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -824,7 +824,7 @@ static void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 }
 
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
-		size_t size)
+			      size_t size, bool free_iova)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -843,17 +843,19 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	__iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
+	if (free_iova)
+		__iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-		size_t size, int prot, u64 dma_mask)
+				  dma_addr_t iova, size_t size, int prot,
+				  u64 dma_mask)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_off = iova_offset(iovad, phys);
-	dma_addr_t iova;
+	bool no_iova = !iova;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
@@ -861,12 +863,14 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	size = iova_align(iovad, size + iova_off);
 
-	iova = __iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+	if (no_iova)
+		iova = __iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map(domain, iova, phys - iova_off, size, prot, GFP_ATOMIC)) {
-		__iommu_dma_free_iova(cookie, iova, size, NULL);
+		if (no_iova)
+			__iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -1031,7 +1035,7 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return vaddr;
 
 out_unmap:
-	__iommu_dma_unmap(dev, *dma_handle, size);
+	__iommu_dma_unmap(dev, *dma_handle, size, true);
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	return NULL;
 }
@@ -1060,7 +1064,7 @@ static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
 {
 	struct dma_sgt_handle *sh = sgt_handle(sgt);
 
-	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size);
+	__iommu_dma_unmap(dev, sgt->sgl->dma_address, size, true);
 	__iommu_dma_free_pages(sh->pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	sg_free_table(&sh->sgt);
 	kfree(sh);
@@ -1131,9 +1135,11 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
 }
 
-static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+static dma_addr_t __iommu_dma_map_pages(struct device *dev, struct page *page,
+					unsigned long offset, dma_addr_t iova,
+					size_t size,
+					enum dma_data_direction dir,
+					unsigned long attrs)
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
@@ -1141,7 +1147,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	dma_addr_t iova, dma_mask = dma_get_mask(dev);
+	dma_addr_t addr, dma_mask = dma_get_mask(dev);
 
 	/*
 	 * If both the physical buffer start address and size are
@@ -1182,14 +1188,23 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
+	addr = __iommu_dma_map(dev, phys, iova, size, prot, dma_mask);
+	if (addr == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
-	return iova;
+	return addr;
 }
 
-static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return __iommu_dma_map_pages(dev, page, offset, 0, size, dir, attrs);
+}
+
+static void __iommu_dma_unmap_pages(struct device *dev, dma_addr_t dma_handle,
+				    size_t size, enum dma_data_direction dir,
+				    unsigned long attrs, bool free_iova)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	phys_addr_t phys;
@@ -1201,12 +1216,19 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu(phys, size, dir);
 
-	__iommu_dma_unmap(dev, dma_handle, size);
+	__iommu_dma_unmap(dev, dma_handle, size, free_iova);
 
 	if (unlikely(is_swiotlb_buffer(dev, phys)))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 
+static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+				 size_t size, enum dma_data_direction dir,
+				 unsigned long attrs)
+{
+	__iommu_dma_unmap_pages(dev, dma_handle, size, dir, attrs, true);
+}
+
 /*
  * Prepare a successfully-mapped scatterlist to give back to the caller.
  *
@@ -1509,13 +1531,13 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	}
 
 	if (end)
-		__iommu_dma_unmap(dev, start, end - start);
+		__iommu_dma_unmap(dev, start, end - start, true);
 }
 
 static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	return __iommu_dma_map(dev, phys, size,
+	return __iommu_dma_map(dev, phys, 0, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
 			dma_get_mask(dev));
 }
@@ -1523,7 +1545,7 @@ static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 static void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_unmap(dev, handle, size, true);
 }
 
 static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
@@ -1560,7 +1582,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t handle, unsigned long attrs)
 {
-	__iommu_dma_unmap(dev, handle, size);
+	__iommu_dma_unmap(dev, handle, size, true);
 	__iommu_dma_free(dev, size, cpu_addr);
 }
 
@@ -1626,7 +1648,7 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	if (!cpu_addr)
 		return NULL;
 
-	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
+	*handle = __iommu_dma_map(dev, page_to_phys(page), 0, size, ioprot,
 			dev->coherent_dma_mask);
 	if (*handle == DMA_MAPPING_ERROR) {
 		__iommu_dma_free(dev, size, cpu_addr);
-- 
2.44.0


