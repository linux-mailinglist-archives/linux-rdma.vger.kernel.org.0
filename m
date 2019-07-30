Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1B7AE04
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfG3Qgc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 12:36:32 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34270 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfG3QgK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:10 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003yJ-MY; Tue, 30 Jul 2019 10:36:09 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6S-0001Ij-6c; Tue, 30 Jul 2019 10:35:56 -0600
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
Date:   Tue, 30 Jul 2019 10:35:42 -0600
Message-Id: <20190730163545.4915-12-logang@deltatee.com>
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
Subject: [PATCH v2 11/14] PCI/P2PDMA: Store mapping method in an xarray
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When upstream_bridge_distance() is called store the method required
to map the DMA transfers in an xarray so that it can be looked up
efficiently on the hot path in pci_p2pdma_map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index fe647bd8f947..010aa8742bec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -19,10 +19,19 @@
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/iommu.h>
+#include <linux/xarray.h>
+
+enum pci_p2pdma_map_type {
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	PCI_P2PDMA_MAP_BUS_ADDR,
+	PCI_P2PDMA_MAP_THRU_IOMMU,
+};
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
+	struct xarray map_types;
 };
 
 struct pci_p2pdma_pagemap {
@@ -98,6 +107,7 @@ static void pci_p2pdma_release(void *data)
 
 	gen_pool_destroy(p2pdma->pool);
 	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
+	xa_destroy(&p2pdma->map_types);
 }
 
 static int pci_p2pdma_setup(struct pci_dev *pdev)
@@ -109,6 +119,8 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p)
 		return -ENOMEM;
 
+	xa_init(&p2p->map_types);
+
 	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
 	if (!p2p->pool)
 		goto out;
@@ -404,6 +416,12 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 	return dist_a + dist_b;
 }
 
+static int map_types_idx(struct pci_dev *client)
+{
+	return (pci_domain_nr(client->bus) << 16) |
+		(client->bus->number << 8) | client->devfn;
+}
+
 /*
  * Find the distance through the nearest common upstream bridge between
  * two PCI devices.
@@ -446,17 +464,29 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
+	enum pci_p2pdma_map_type map_type;
 	int dist;
 
 	dist = __upstream_bridge_distance(provider, client, acs_list);
 
-	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
-		return dist;
+	if (!(dist & P2PDMA_THRU_HOST_BRIDGE)) {
+		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
+		goto store_map_type_and_return;
+	}
+
+	if (host_bridge_whitelist(provider, client)) {
+		map_type = PCI_P2PDMA_MAP_THRU_IOMMU;
+	} else {
+		dist |= P2PDMA_NOT_SUPPORTED;
+		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	}
 
-	if (host_bridge_whitelist(provider, client))
-		return dist;
+store_map_type_and_return:
+	if (provider->p2pdma)
+		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
+			 xa_mk_value(map_type), GFP_KERNEL);
 
-	return dist | P2PDMA_NOT_SUPPORTED;
+	return dist;
 }
 
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
-- 
2.20.1

