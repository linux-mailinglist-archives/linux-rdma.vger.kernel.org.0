Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20978A473
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfHLRbG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 13:31:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37858 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfHLRbG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 13:31:06 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9o-0002sd-RI; Mon, 12 Aug 2019 11:31:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9j-0002Pa-Kc; Mon, 12 Aug 2019 11:30:51 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon, 12 Aug 2019 11:30:44 -0600
Message-Id: <20190812173048.9186-11-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, Christian.Koenig@amd.com, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 10/14] PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Factor out the bus-only mapping into its own static function.  No
functional changes. The original pci_p2pdma_map_sg_attrs() will be used to
decide whether this is an appropriate way to map.

Link: https://lore.kernel.org/r/20190730163545.4915-11-logang@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 1eec7a5ec27e..771b45605853 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -792,23 +792,9 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-/**
- * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: elements in the scatterlist
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_map_sg() (if called)
- *
- * Scatterlists mapped with this function should be unmapped using
- * pci_p2pdma_unmap_sg_attrs().
- *
- * Returns the number of SG entries mapped or 0 on error.
- */
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
+static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
+		struct device *dev, struct scatterlist *sg, int nents)
 {
-	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct scatterlist *s;
 	phys_addr_t paddr;
 	int i;
@@ -824,7 +810,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		return 0;
 
 	for_each_sg(sg, s, nents, i) {
-		p2p_pgmap = to_p2p_pgmap(sg_page(s)->pgmap);
 		paddr = sg_phys(s);
 
 		s->dma_address = paddr - p2p_pgmap->bus_offset;
@@ -833,6 +818,28 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	return nents;
 }
+
+/**
+ * pci_p2pdma_map_sg - map a PCI peer-to-peer scatterlist for DMA
+ * @dev: device doing the DMA request
+ * @sg: scatter list to map
+ * @nents: elements in the scatterlist
+ * @dir: DMA direction
+ * @attrs: DMA attributes passed to dma_map_sg() (if called)
+ *
+ * Scatterlists mapped with this function should be unmapped using
+ * pci_p2pdma_unmap_sg_attrs().
+ *
+ * Returns the number of SG entries mapped or 0 on error.
+ */
+int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct pci_p2pdma_pagemap *p2p_pgmap =
+		to_p2p_pgmap(sg_page(sg)->pgmap);
+
+	return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
+}
 EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 
 /**
-- 
2.20.1

