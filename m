Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2F7AE18
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfG3QhO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 12:37:14 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34122 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfG3QgE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:04 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003y9-5l; Tue, 30 Jul 2019 10:36:03 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6R-0001IF-4r; Tue, 30 Jul 2019 10:35:55 -0600
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
Date:   Tue, 30 Jul 2019 10:35:32 -0600
Message-Id: <20190730163545.4915-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
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
Subject: [PATCH v2 01/14] PCI/P2PDMA: Introduce private pagemap structure
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the PCI bus offset from the generic dev_pagemap structure to a
specific pci_p2pdma_pagemap structure.

This structure will grow in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c     | 26 ++++++++++++++++++++------
 include/linux/memremap.h |  1 -
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 234476226529..03e9c887bdfb 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -25,6 +25,16 @@ struct pci_p2pdma {
 	bool p2pmem_published;
 };
 
+struct pci_p2pdma_pagemap {
+	struct dev_pagemap pgmap;
+	u64 bus_offset;
+};
+
+static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
+{
+	return container_of(pgmap, struct pci_p2pdma_pagemap, pgmap);
+}
+
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -135,6 +145,7 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			    u64 offset)
 {
+	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct dev_pagemap *pgmap;
 	void *addr;
 	int error;
@@ -157,14 +168,17 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			return error;
 	}
 
-	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
-	if (!pgmap)
+	p2p_pgmap = devm_kzalloc(&pdev->dev, sizeof(*p2p_pgmap), GFP_KERNEL);
+	if (!p2p_pgmap)
 		return -ENOMEM;
+
+	pgmap = &p2p_pgmap->pgmap;
 	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
 	pgmap->res.end = pgmap->res.start + size - 1;
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
-	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
+
+	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
 
 	addr = devm_memremap_pages(&pdev->dev, pgmap);
@@ -720,7 +734,7 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		      enum dma_data_direction dir)
 {
-	struct dev_pagemap *pgmap;
+	struct pci_p2pdma_pagemap *p2p_pgmap;
 	struct scatterlist *s;
 	phys_addr_t paddr;
 	int i;
@@ -736,10 +750,10 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		return 0;
 
 	for_each_sg(sg, s, nents, i) {
-		pgmap = sg_page(s)->pgmap;
+		p2p_pgmap = to_p2p_pgmap(sg_page(s)->pgmap);
 		paddr = sg_phys(s);
 
-		s->dma_address = paddr - pgmap->pci_p2pdma_bus_offset;
+		s->dma_address = paddr - p2p_pgmap->bus_offset;
 		sg_dma_len(s) = s->length;
 	}
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..b459518ce475 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -112,7 +112,6 @@ struct dev_pagemap {
 	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
-	u64 pci_p2pdma_bus_offset;
 	const struct dev_pagemap_ops *ops;
 };
 
-- 
2.20.1

