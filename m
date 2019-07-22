Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A218470D1B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfGVXJM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 19:09:12 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40254 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbfGVXJM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 19:09:12 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQb-0002k9-Dj; Mon, 22 Jul 2019 17:09:11 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQX-0001RH-V5; Mon, 22 Jul 2019 17:09:06 -0600
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
Date:   Mon, 22 Jul 2019 17:08:59 -0600
Message-Id: <20190722230859.5436-15-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
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
Subject: [PATCH 14/14] PCI/P2PDMA: Introduce pci_p2pdma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

pci_p2pdma_[un]map_resource() can be used to map a resource given
it's physical address and the backing pci_dev. The functions will call
dma_[un]map_resource() when appropriate.

This is for demonstration purposes only as there are no users of this
function at this time. Thus, this patch should not be merged at
this time.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index baf476039396..20c834cfd2d3 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -874,6 +874,91 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+static pci_bus_addr_t pci_p2pdma_phys_to_bus(struct pci_dev *dev,
+		phys_addr_t start, size_t size)
+{
+	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
+	phys_addr_t end = start + size;
+	struct resource_entry *window;
+
+	resource_list_for_each_entry(window, &bridge->windows) {
+		if (window->res->start <= start && window->res->end >= end)
+			return start - window->offset;
+	}
+
+	return DMA_MAPPING_ERROR;
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_phys_to_bus);
+
+/**
+ * pci_p2pdma_map_resource - map a PCI peer-to-peer physical address for DMA
+ * @provider: pci device that provides the memory backed by phys_addr
+ * @dma_dev: device doing the DMA request
+ * @phys_addr: physical address of the memory to map
+ * @size: size of the memory to map
+ * @dir: DMA direction
+ * @attrs: dma attributes passed to dma_map_resource() (if called)
+ *
+ * Maps a BAR physical address for programming a DMA engine.
+ *
+ * Returns the dma_addr_t to map or DMA_MAPPING_ERROR on failure
+ */
+dma_addr_t pci_p2pdma_map_resource(struct pci_dev *provider,
+		struct device *dma_dev, phys_addr_t phys_addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	struct pci_dev *client;
+	int dist;
+
+	client = find_parent_pci_dev(dma_dev);
+	if (!client)
+		return DMA_MAPPING_ERROR;
+
+	dist = upstream_bridge_distance(provider, client, NULL);
+	if (dist & P2PDMA_NOT_SUPPORTED)
+		return DMA_MAPPING_ERROR;
+
+	if (dist & P2PDMA_THRU_HOST_BRIDGE)
+		return dma_map_resource(dma_dev, phys_addr, size, dir, attrs);
+	else
+		return pci_p2pdma_phys_to_bus(provider, phys_addr, size);
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_map_resource);
+
+/**
+ * pci_p2pdma_unmap_resource - unmap a resource mapped with
+ *		pci_p2pdma_map_resource()
+ * @provider: pci device that provides the memory backed by phys_addr
+ * @dma_dev: device doing the DMA request
+ * @addr: dma address returned by pci_p2pdma_unmap_resource()
+ * @size: size of the memory to map
+ * @dir: DMA direction
+ * @attrs: dma attributes passed to dma_unmap_resource() (if called)
+ *
+ * Maps a BAR physical address for programming a DMA engine.
+ *
+ * Returns the dma_addr_t to map or DMA_MAPPING_ERROR on failure
+ */
+void pci_p2pdma_unmap_resource(struct pci_dev *provider,
+		struct device *dma_dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	struct pci_dev *client;
+	int dist;
+
+	client = find_parent_pci_dev(dma_dev);
+	if (!client)
+		return;
+
+	dist = upstream_bridge_distance(provider, client, NULL);
+	if (dist & P2PDMA_NOT_SUPPORTED)
+		return;
+
+	if (dist & P2PDMA_THRU_HOST_BRIDGE)
+		dma_unmap_resource(dma_dev, addr, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_resource);
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
-- 
2.20.1

