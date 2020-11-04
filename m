Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2602A6117
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 11:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKDKEH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKDKEG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 05:04:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C1AC0613D3;
        Wed,  4 Nov 2020 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6i+ZQBC5XZcaf/YFDznwfiEdycwkjc1Y9jVRZuhej00=; b=EEsSY1SE1ycXZds8C5zXuT2rNU
        wEt9xgUKkJC3uwssz+wbEBCbh2683NvuBQCvVxLGjNEajY7HYVdVD+901XY7qNQj0BAQLx6O3a1HC
        +N5PBjEEUyS+7SUFUfpoPyjNtOeXNldty9ubIwwFp/EnDGJm5tkmw3KqsS4xX6r+CbWXe51Wsyd0n
        IYEEydUpwYb+w6FtFSr67Yc5ncMpTzaRJkYHT6rbATHROsHhTkMpvPhYD6R8Lw+XdwzYbhG/To7Iz
        6W4fZrDN13EHcgRek1qlmkbKng5ueKtK0OeZJKm4OLtGC9mRd7knjjxFTnE962dSptKetH0WPLdAg
        RF+HS9/g==;
Received: from 089144208145.atnat0017.highway.a1.net ([89.144.208.145] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaFe6-0003Mp-Vm; Wed, 04 Nov 2020 10:04:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH 5/5] dma-mapping: remove dma_virt_ops
Date:   Wed,  4 Nov 2020 10:50:52 +0100
Message-Id: <20201104095052.1222754-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104095052.1222754-1-hch@lst.de>
References: <20201104095052.1222754-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that the RDMA core deals with devices that only do DMA mapping in
lower layers properly, there is no user for dma_virt_ops and it can
be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h |  2 --
 kernel/dma/Kconfig          |  5 ---
 kernel/dma/Makefile         |  1 -
 kernel/dma/virt.c           | 61 -------------------------------------
 4 files changed, 69 deletions(-)
 delete mode 100644 kernel/dma/virt.c

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 956151052d4542..2aaed35b556df4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -565,6 +565,4 @@ static inline int dma_mmap_wc(struct device *dev,
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
 
-extern const struct dma_map_ops dma_virt_ops;
-
 #endif /* _LINUX_DMA_MAPPING_H */
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a2145889..fd2db2665fc691 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -75,11 +75,6 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
-config DMA_VIRT_OPS
-	bool
-	depends on HAS_DMA
-	select DMA_OPS
-
 config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index dc755ab68aabf9..cd1d86358a7a62 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -5,7 +5,6 @@ obj-$(CONFIG_DMA_OPS)			+= ops_helpers.o
 obj-$(CONFIG_DMA_OPS)			+= dummy.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
-obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
diff --git a/kernel/dma/virt.c b/kernel/dma/virt.c
deleted file mode 100644
index 59d32317dd574a..00000000000000
--- a/kernel/dma/virt.c
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DMA operations that map to virtual addresses without flushing memory.
- */
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/dma-map-ops.h>
-#include <linux/scatterlist.h>
-
-static void *dma_virt_alloc(struct device *dev, size_t size,
-			    dma_addr_t *dma_handle, gfp_t gfp,
-			    unsigned long attrs)
-{
-	void *ret;
-
-	ret = (void *)__get_free_pages(gfp | __GFP_ZERO, get_order(size));
-	if (ret)
-		*dma_handle = (uintptr_t)ret;
-	return ret;
-}
-
-static void dma_virt_free(struct device *dev, size_t size,
-			  void *cpu_addr, dma_addr_t dma_addr,
-			  unsigned long attrs)
-{
-	free_pages((unsigned long)cpu_addr, get_order(size));
-}
-
-static dma_addr_t dma_virt_map_page(struct device *dev, struct page *page,
-				    unsigned long offset, size_t size,
-				    enum dma_data_direction dir,
-				    unsigned long attrs)
-{
-	return (uintptr_t)(page_address(page) + offset);
-}
-
-static int dma_virt_map_sg(struct device *dev, struct scatterlist *sgl,
-			   int nents, enum dma_data_direction dir,
-			   unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg_page(sg));
-		sg_dma_address(sg) = (uintptr_t)sg_virt(sg);
-		sg_dma_len(sg) = sg->length;
-	}
-
-	return nents;
-}
-
-const struct dma_map_ops dma_virt_ops = {
-	.alloc			= dma_virt_alloc,
-	.free			= dma_virt_free,
-	.map_page		= dma_virt_map_page,
-	.map_sg			= dma_virt_map_sg,
-	.alloc_pages		= dma_common_alloc_pages,
-	.free_pages		= dma_common_free_pages,
-};
-EXPORT_SYMBOL(dma_virt_ops);
-- 
2.28.0

