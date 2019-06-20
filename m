Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234A04D320
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfFTQOC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59554 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732219AbfFTQNC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg9-00046H-Dg; Thu, 20 Jun 2019 10:13:00 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-0005x9-Lr; Thu, 20 Jun 2019 10:12:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 20 Jun 2019 10:12:38 -0600
Message-Id: <20190620161240.22738-27-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, axboe@kernel.dk, hch@lst.de, bhelgaas@google.com, dan.j.williams@intel.com, sagi@grimberg.me, kbusch@kernel.org, jgg@ziepe.ca, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 26/28] PCI/P2PDMA: Remove SGL helpers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The functions, pci_p2pmem_alloc_sgl(), pci_p2pmem_free_sgl() and
pci_p2pdma_map_sg() no longer have any callers, so remove them.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/driver-api/pci/p2pdma.rst |  9 +--
 drivers/pci/p2pdma.c                    | 95 -------------------------
 include/linux/pci-p2pdma.h              | 19 -----
 3 files changed, 3 insertions(+), 120 deletions(-)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 44deb52beeb4..5b19c420d921 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -84,9 +84,8 @@ Client Drivers
 --------------
 
 A client driver typically only has to conditionally change its DMA map
-routine to use the mapping function :c:func:`pci_p2pdma_map_sg()` instead
-of the usual :c:func:`dma_map_sg()` function. Memory mapped in this
-way does not need to be unmapped.
+routine to use the PCI bus address with :c:func:`pci_p2pmem_virt_to_bus()`
+for the DMA address instead of the usual :c:func:`dma_map_sg()` function.
 
 The client may also, optionally, make use of
 :c:func:`is_pci_p2pdma_page()` to determine when to use the P2P mapping
@@ -117,9 +116,7 @@ returned with pci_dev_put().
 
 Once a provider is selected, the orchestrator can then use
 :c:func:`pci_alloc_p2pmem()` and :c:func:`pci_free_p2pmem()` to
-allocate P2P memory from the provider. :c:func:`pci_p2pmem_alloc_sgl()`
-and :c:func:`pci_p2pmem_free_sgl()` are convenience functions for
-allocating scatter-gather lists with P2P memory.
+allocate P2P memory from the provider.
 
 Struct Page Caveats
 -------------------
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a98126ad9c3a..9b82e13f802c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -666,60 +666,6 @@ pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_virt_to_bus);
 
-/**
- * pci_p2pmem_alloc_sgl - allocate peer-to-peer DMA memory in a scatterlist
- * @pdev: the device to allocate memory from
- * @nents: the number of SG entries in the list
- * @length: number of bytes to allocate
- *
- * Return: %NULL on error or &struct scatterlist pointer and @nents on success
- */
-struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
-					 unsigned int *nents, u32 length)
-{
-	struct scatterlist *sg;
-	void *addr;
-
-	sg = kzalloc(sizeof(*sg), GFP_KERNEL);
-	if (!sg)
-		return NULL;
-
-	sg_init_table(sg, 1);
-
-	addr = pci_alloc_p2pmem(pdev, length);
-	if (!addr)
-		goto out_free_sg;
-
-	sg_set_buf(sg, addr, length);
-	*nents = 1;
-	return sg;
-
-out_free_sg:
-	kfree(sg);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(pci_p2pmem_alloc_sgl);
-
-/**
- * pci_p2pmem_free_sgl - free a scatterlist allocated by pci_p2pmem_alloc_sgl()
- * @pdev: the device to allocate memory from
- * @sgl: the allocated scatterlist
- */
-void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl)
-{
-	struct scatterlist *sg;
-	int count;
-
-	for_each_sg(sgl, sg, INT_MAX, count) {
-		if (!sg)
-			break;
-
-		pci_free_p2pmem(pdev, sg_virt(sg), sg->length);
-	}
-	kfree(sgl);
-}
-EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
-
 /**
  * pci_p2pmem_publish - publish the peer-to-peer DMA memory for use by
  *	other devices with pci_p2pmem_find()
@@ -738,47 +684,6 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-/**
- * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: elements in the scatterlist
- * @dir: DMA direction
- *
- * Scatterlists mapped with this function should not be unmapped in any way.
- *
- * Returns the number of SG entries mapped or 0 on error.
- */
-int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir)
-{
-	struct dev_pagemap *pgmap;
-	struct scatterlist *s;
-	phys_addr_t paddr;
-	int i;
-
-	/*
-	 * p2pdma mappings are not compatible with devices that use
-	 * dma_virt_ops. If the upper layers do the right thing
-	 * this should never happen because it will be prevented
-	 * by the check in pci_p2pdma_add_client()
-	 */
-	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
-			 dev->dma_ops == &dma_virt_ops))
-		return 0;
-
-	for_each_sg(sg, s, nents, i) {
-		pgmap = sg_page(s)->pgmap;
-		paddr = sg_phys(s);
-
-		s->dma_address = paddr - pgmap->pci_p2pdma_bus_offset;
-		sg_dma_len(s) = s->length;
-	}
-
-	return nents;
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
-
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index bca9bc3e5be7..4a75a3f43444 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -26,12 +26,7 @@ struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients);
 void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size);
 void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size);
 pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev, void *addr);
-struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
-					 unsigned int *nents, u32 length);
-void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
-int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		      enum dma_data_direction dir);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -69,23 +64,9 @@ static inline pci_bus_addr_t pci_p2pmem_virt_to_bus(struct pci_dev *pdev,
 {
 	return 0;
 }
-static inline struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
-		unsigned int *nents, u32 length)
-{
-	return NULL;
-}
-static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
-		struct scatterlist *sgl)
-{
-}
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
-static inline int pci_p2pdma_map_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	return 0;
-}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
-- 
2.20.1

