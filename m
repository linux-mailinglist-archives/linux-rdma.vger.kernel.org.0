Return-Path: <linux-rdma+bounces-7434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECEA29114
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 15:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5693716939F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680D1D89F0;
	Wed,  5 Feb 2025 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/ZWUKBV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E016F288;
	Wed,  5 Feb 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766476; cv=none; b=ZKcIVdVbSF2bBRstvjnQMfpkpM/RojJu5gMTqyWbUUSoK2Pv3kZnwMVwNR+zTOvvXgNJasWGaZC4rrYGCCYWuFN0456huQVM7GFEW2x45FFdcTxR92Do6x3NZA82mIFXo6rlUNtu73VwwjxxyM0/kFTgLg6lJTnbUda6mK4HJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766476; c=relaxed/simple;
	bh=rDd5+AEBVvFnWWvevLz/veAtXtu4dnJimBZ2rziLMe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9cApFoejuRfltMZbd51n2xipuvCyDSbTHWYFxiLIJdDhU3qmBdCcsuXcjgR2EgjvHDl5V+FXEwdx8R4+ookyPPJYn9eIteRukJDLp79HKmh1KPvRtr042v2WEo/pJ67P7FJAbsyYAe4mfAG9hcq6mZxBlUDiX6d5dAxliqRH9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/ZWUKBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68464C4CEE2;
	Wed,  5 Feb 2025 14:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738766475;
	bh=rDd5+AEBVvFnWWvevLz/veAtXtu4dnJimBZ2rziLMe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/ZWUKBV+oMEe/aoCuMSHpIgfKzXegQZjFdM5hqBD/+SkqOxNNzyqMOdd+0mTOUyT
	 aOmrYap1v09OtkkimHsMZHiTVlEnVaTUrioW5LIalQKVX6KVa3hx5PuRyil8rrHK8l
	 a6NXAH+Zxz3cZZOOMKK97ROS2Nqwimk0yfzsAtOHcfnbt6F18e9k54nZEurCSEJfbF
	 +nGJSHlYegV/kXxcZh1gb7ss9qZUvVSyygtEXU1hKq0oBvW6Ly0SKdD+cBq1gwCEk0
	 9rW5DZE+RFdAGOF3rpxnenXvOLU0g6NpCWVYHFXh/RA5TM6u38bvvur2NpzKHn9J+T
	 JHAIBp0mWBzhg==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v7 02/17] dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
Date: Wed,  5 Feb 2025 16:40:22 +0200
Message-ID: <dc5f47ea153d23ff1fd24a8964ff5be8ee51f3e4.1738765879.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738765879.git.leonro@nvidia.com>
References: <cover.1738765879.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

To support the upcoming non-scatterlist mapping helpers, we need to go
back to have them called outside of the DMA API.  Thus move them out of
dma-map-ops.h, which is only for DMA API implementations to pci-p2pdma.h,
which is for driver use.

Note that the core helper is still not exported as the mapping is
expected to be done only by very highlevel subsystem code at least for
now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c   |  1 +
 include/linux/dma-map-ops.h | 85 -------------------------------------
 include/linux/pci-p2pdma.h  | 84 ++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.c         |  1 +
 4 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5746ffaf0061..853247c42f7d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/swiotlb.h>
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 63dd480e209b..f48e5fb88bd5 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -434,89 +434,4 @@ static inline void debug_dma_dump_mappings(struct device *dev)
 #endif /* CONFIG_DMA_API_DEBUG */
 
 extern const struct dma_map_ops dma_dummy_ops;
-
-enum pci_p2pdma_map_type {
-	/*
-	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
-	 * type hasn't been calculated yet. Functions that return this enum
-	 * never return this value.
-	 */
-	PCI_P2PDMA_MAP_UNKNOWN = 0,
-
-	/*
-	 * Not a PCI P2PDMA transfer.
-	 */
-	PCI_P2PDMA_MAP_NONE,
-
-	/*
-	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
-	 * traverse the host bridge and the host bridge is not in the
-	 * allowlist. DMA Mapping routines should return an error when
-	 * this is returned.
-	 */
-	PCI_P2PDMA_MAP_NOT_SUPPORTED,
-
-	/*
-	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
-	 * each other directly through a PCI switch and the transaction will
-	 * not traverse the host bridge. Such a mapping should program
-	 * the DMA engine with PCI bus addresses.
-	 */
-	PCI_P2PDMA_MAP_BUS_ADDR,
-
-	/*
-	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
-	 * to each other, but the transaction traverses a host bridge on the
-	 * allowlist. In this case, a normal mapping either with CPU physical
-	 * addresses (in the case of dma-direct) or IOVA addresses (in the
-	 * case of IOMMUs) should be used to program the DMA engine.
-	 */
-	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
-};
-
-struct pci_p2pdma_map_state {
-	struct dev_pagemap *pgmap;
-	enum pci_p2pdma_map_type map;
-	u64 bus_off;
-};
-
-/* helper for pci_p2pdma_state(), do not use directly */
-void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
-		struct device *dev, struct page *page);
-
-/**
- * pci_p2pdma_state - check the P2P transfer state of a page
- * @state:	P2P state structure
- * @dev:	device to transfer to/from
- * @page:	page to map
- *
- * Check if @page is a PCI P2PDMA page, and if yes of what kind.  Returns the
- * map type, and updates @state with all information needed for a P2P transfer.
- */
-static inline enum pci_p2pdma_map_type
-pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
-		struct page *page)
-{
-	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
-		if (state->pgmap != page->pgmap)
-			__pci_p2pdma_update_state(state, dev, page);
-		return state->map;
-	}
-	return PCI_P2PDMA_MAP_NONE;
-}
-
-/**
- * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
- * @state:	P2P state structure
- * @paddr:	physical address to map
- *
- * Map a physically contigous PCI_P2PDMA_MAP_BUS_ADDR transfer.
- */
-static inline dma_addr_t
-pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t paddr)
-{
-	WARN_ON_ONCE(state->map != PCI_P2PDMA_MAP_BUS_ADDR);
-	return paddr + state->bus_off;
-}
-
 #endif /* _LINUX_DMA_MAP_OPS_H */
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 2c07aa6b7665..e839f52b512b 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -104,4 +104,88 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
 	return pci_p2pmem_find_many(&client, 1);
 }
 
+enum pci_p2pdma_map_type {
+	/*
+	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
+	 * type hasn't been calculated yet. Functions that return this enum
+	 * never return this value.
+	 */
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+
+	/*
+	 * Not a PCI P2PDMA transfer.
+	 */
+	PCI_P2PDMA_MAP_NONE,
+
+	/*
+	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
+	 * traverse the host bridge and the host bridge is not in the
+	 * allowlist. DMA Mapping routines should return an error when
+	 * this is returned.
+	 */
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+
+	/*
+	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
+	 * each other directly through a PCI switch and the transaction will
+	 * not traverse the host bridge. Such a mapping should program
+	 * the DMA engine with PCI bus addresses.
+	 */
+	PCI_P2PDMA_MAP_BUS_ADDR,
+
+	/*
+	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
+	 * to each other, but the transaction traverses a host bridge on the
+	 * allowlist. In this case, a normal mapping either with CPU physical
+	 * addresses (in the case of dma-direct) or IOVA addresses (in the
+	 * case of IOMMUs) should be used to program the DMA engine.
+	 */
+	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+};
+
+struct pci_p2pdma_map_state {
+	struct dev_pagemap *pgmap;
+	enum pci_p2pdma_map_type map;
+	u64 bus_off;
+};
+
+/* helper for pci_p2pdma_state(), do not use directly */
+void __pci_p2pdma_update_state(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct page *page);
+
+/**
+ * pci_p2pdma_state - check the P2P transfer state of a page
+ * @state:	P2P state structure
+ * @dev:	device to transfer to/from
+ * @page:	page to map
+ *
+ * Check if @page is a PCI P2PDMA page, and if yes of what kind.  Returns the
+ * map type, and updates @state with all information needed for a P2P transfer.
+ */
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_state(struct pci_p2pdma_map_state *state, struct device *dev,
+		struct page *page)
+{
+	if (IS_ENABLED(CONFIG_PCI_P2PDMA) && is_pci_p2pdma_page(page)) {
+		if (state->pgmap != page->pgmap)
+			__pci_p2pdma_update_state(state, dev, page);
+		return state->map;
+	}
+	return PCI_P2PDMA_MAP_NONE;
+}
+
+/**
+ * pci_p2pdma_bus_addr_map - map a PCI_P2PDMA_MAP_BUS_ADDR P2P transfer
+ * @state:	P2P state structure
+ * @paddr:	physical address to map
+ *
+ * Map a physically contigous PCI_P2PDMA_MAP_BUS_ADDR transfer.
+ */
+static inline dma_addr_t
+pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t paddr)
+{
+	WARN_ON_ONCE(state->map != PCI_P2PDMA_MAP_BUS_ADDR);
+	return paddr + state->bus_off;
+}
+
 #endif /* _LINUX_PCI_P2P_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index e289ad27d1b5..c9b3893257d4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/slab.h>
+#include <linux/pci-p2pdma.h>
 #include "direct.h"
 
 /*
-- 
2.48.1


