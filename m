Return-Path: <linux-rdma+bounces-1254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE01871BA5
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 11:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67CA283C5A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A817581E;
	Tue,  5 Mar 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsJGaL+D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A475803;
	Tue,  5 Mar 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634187; cv=none; b=iRWTe7Xr4+Vazkmfk9bQhcGWE+uMQMI4y9K0Yvz+vec0T6i51vokTybBxAZFK5hea8JbjbT0tGWL9f0sWTF6XiSJ8gle2DJcKqZGa/0FqwF99l45Tu25CYj9VKIBJBTTROidDTCWV9g41aLKWN1J8TD3weHy7PovVY0/lXvlIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634187; c=relaxed/simple;
	bh=inT0MN5YzB4Hs5AmOhFFcCz6zSy1Lq0FeGslm64Slg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Od4YbI/GbTaseVYksBwayfgPyo5fuyr2wPpBLyYU0nTvc9j1Ylmr7csqtyPNKBZaR0wF0NYHx5BIogPmdzRjkNL09hKYOcKqP4o4WO6jF9ExLHF79esr6VOrAOd6vdJSMOBlR/xA9Kx4+JZJ1G63yUG3N67y3yPl3OI62xQ7X8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsJGaL+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BA0C433F1;
	Tue,  5 Mar 2024 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634187;
	bh=inT0MN5YzB4Hs5AmOhFFcCz6zSy1Lq0FeGslm64Slg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsJGaL+DkLkgIabckqVwTeJY8qVb0nl4GLcoHjh2QNL068AmjRXCZbXFPHPdFWhVt
	 hoeI9wrJ7TmgpbCIKQsrK2uuQqzsUHmUqkVdg+8SbVuLVrbKxQN7wSwpBVdP9t4q44
	 fuo8iovWqqqpsJIzPT+ZmvEzOVuGSJVw+Hw0aNtMbA5cl6E8hMaycw1RO84Ss7julD
	 eB8htXDX67+eUjMzdzkmX9r5+VqzTUzavlw9fOUgqWqhn6hK74sWzHVzEDPcRL5C3v
	 eyRVlLdBQ3UtZskG9J0Qkq1Bzb+4c24rjSsXmZ8jyBX7vd/ZjMN0TLRuTpZXPU8dTq
	 L8RXY7cRhg3HA==
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
Subject: [RFC 10/16] RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
Date: Tue,  5 Mar 2024 12:22:11 +0200
Message-ID: <8c6d5e7db2d1a01888cc7b9b9850b05e19c75c64.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

RDMA UMEM never supported DMA addresses returned from SWIOTLB, as these
addresses should be programmed to the hardware which is not aware that
it is bounce buffers and not real ones.

Instead of silently leave broken system for the users who didn't
know it, let's be explicit and return an error to them.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-attributes.rst |  7 +++
 drivers/infiniband/core/umem_odp.c        | 77 +++++++++++------------
 include/linux/dma-mapping.h               |  6 ++
 kernel/dma/direct.h                       |  4 +-
 kernel/dma/mapping.c                      |  4 ++
 5 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 1887d92e8e92..b337ec65d506 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -130,3 +130,10 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
 subsystem that the buffer is fully accessible at the elevated privilege
 level (and ideally inaccessible or at least read-only at the
 lesser-privileged levels).
+
+DMA_ATTR_NO_TRANSLATION
+-----------------------
+
+This attribute is used to indicate to the DMA-mapping subsystem that the
+buffer is not subject to any address translation.  This is used for devices
+that doesn't need buffer bouncing or fixing DMA addresses.
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 1301009a6b78..57c56000f60e 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -50,51 +50,50 @@
 static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 				   const struct mmu_interval_notifier_ops *ops)
 {
+	size_t page_size = 1UL << umem_odp->page_shift;
 	struct ib_device *dev = umem_odp->umem.ibdev;
+	size_t ndmas, npfns;
+	unsigned long start;
+	unsigned long end;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
 	mutex_init(&umem_odp->umem_mutex);
 
-	if (!umem_odp->is_implicit_odp) {
-		size_t page_size = 1UL << umem_odp->page_shift;
-		unsigned long start;
-		unsigned long end;
-		size_t ndmas, npfns;
-
-		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
-		if (check_add_overflow(umem_odp->umem.address,
-				       (unsigned long)umem_odp->umem.length,
-				       &end))
-			return -EOVERFLOW;
-		end = ALIGN(end, page_size);
-		if (unlikely(end < page_size))
-			return -EOVERFLOW;
-
-		ndmas = (end - start) >> umem_odp->page_shift;
-		if (!ndmas)
-			return -EINVAL;
-
-		npfns = (end - start) >> PAGE_SHIFT;
-		umem_odp->pfn_list = kvcalloc(
-			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
-		if (!umem_odp->pfn_list)
-			return -ENOMEM;
-
-
-		umem_odp->iova.dev = dev->dma_device;
-		umem_odp->iova.size = end - start;
-		umem_odp->iova.dir = DMA_BIDIRECTIONAL;
-		ret = ib_dma_alloc_iova(dev, &umem_odp->iova);
-		if (ret)
-			goto out_pfn_list;
-
-		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
-						   umem_odp->umem.owning_mm,
-						   start, end - start, ops);
-		if (ret)
-			goto out_free_iova;
-	}
+	if (umem_odp->is_implicit_odp)
+		return 0;
+
+	start = ALIGN_DOWN(umem_odp->umem.address, page_size);
+	if (check_add_overflow(umem_odp->umem.address,
+			       (unsigned long)umem_odp->umem.length, &end))
+		return -EOVERFLOW;
+	end = ALIGN(end, page_size);
+	if (unlikely(end < page_size))
+		return -EOVERFLOW;
+
+	ndmas = (end - start) >> umem_odp->page_shift;
+	if (!ndmas)
+		return -EINVAL;
+
+	npfns = (end - start) >> PAGE_SHIFT;
+	umem_odp->pfn_list =
+		kvcalloc(npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
+	if (!umem_odp->pfn_list)
+		return -ENOMEM;
+
+	umem_odp->iova.dev = dev->dma_device;
+	umem_odp->iova.size = end - start;
+	umem_odp->iova.dir = DMA_BIDIRECTIONAL;
+	umem_odp->iova.attrs = DMA_ATTR_NO_TRANSLATION;
+	ret = ib_dma_alloc_iova(dev, &umem_odp->iova);
+	if (ret)
+		goto out_pfn_list;
+
+	ret = mmu_interval_notifier_insert(&umem_odp->notifier,
+					   umem_odp->umem.owning_mm, start,
+					   end - start, ops);
+	if (ret)
+		goto out_free_iova;
 
 	return 0;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 91cc084adb53..89945e707a9b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -62,6 +62,12 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_NO_TRANSLATION: used to indicate that the buffer should not be mapped
+ * through address translation.
+ */
+#define DMA_ATTR_NO_TRANSLATION		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 1c30e1cd607a..1c9ec204c999 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -92,6 +92,8 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	if (is_swiotlb_force_bounce(dev)) {
 		if (is_pci_p2pdma_page(page))
 			return DMA_MAPPING_ERROR;
+		if (attrs & DMA_ATTR_NO_TRANSLATION)
+			return DMA_MAPPING_ERROR;
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
@@ -99,7 +101,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	    dma_kmalloc_needs_bounce(dev, size, dir)) {
 		if (is_pci_p2pdma_page(page))
 			return DMA_MAPPING_ERROR;
-		if (is_swiotlb_active(dev))
+		if (is_swiotlb_active(dev) && !(attrs & DMA_ATTR_NO_TRANSLATION))
 			return swiotlb_map(dev, phys, size, dir, attrs);
 
 		dev_WARN_ONCE(dev, 1,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f989c64622c2..49b1fde510c5 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -188,6 +188,10 @@ int dma_alloc_iova(struct dma_iova_attrs *iova)
 	struct device *dev = iova->dev;
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
+	if (dma_map_direct(dev, ops) && is_swiotlb_force_bounce(dev) &&
+	    iova->attrs & DMA_ATTR_NO_TRANSLATION)
+		return -EOPNOTSUPP;
+
 	if (dma_map_direct(dev, ops) || !ops->alloc_iova) {
 		iova->addr = 0;
 		return 0;
-- 
2.44.0


