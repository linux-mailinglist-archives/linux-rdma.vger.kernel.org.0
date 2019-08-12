Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39D68A46C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfHLRbF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 13:31:05 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37836 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbfHLRbF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 13:31:05 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9l-0002sZ-OI; Mon, 12 Aug 2019 11:31:03 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9j-0002PO-9o; Mon, 12 Aug 2019 11:30:51 -0600
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
Date:   Mon, 12 Aug 2019 11:30:40 -0600
Message-Id: <20190812173048.9186-7-logang@deltatee.com>
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
Subject: [PATCH v3 06/14] PCI/P2PDMA: Factor out host_bridge_whitelist()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Push both PCI devices into the whitelist checking function seeing some
hardware will require us ensuring they are on the same host bridge.

At the same time we rename root_complex_whitelist() to
host_bridge_whitelist() to match the terminology used in the code.

Link: https://lore.kernel.org/r/20190730163545.4915-7-logang@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index f7f7e5862bab..4b9f0903b340 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -269,19 +269,11 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
-/*
- * If we can't find a common upstream bridge take a look at the root
- * complex and compare it to a whitelist of known good hardware.
- */
-static bool root_complex_whitelist(struct pci_dev *dev)
+static bool __host_bridge_whitelist(struct pci_host_bridge *host)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
 	unsigned short vendor, device;
 
-	if (iommu_present(dev->dev.bus))
-		return false;
-
 	if (!root)
 		return false;
 
@@ -296,6 +288,24 @@ static bool root_complex_whitelist(struct pci_dev *dev)
 	return false;
 }
 
+/*
+ * If we can't find a common upstream bridge take a look at the root
+ * complex and compare it to a whitelist of known good hardware.
+ */
+static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
+{
+	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
+	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
+
+	if (iommu_present(a->dev.bus) || iommu_present(b->dev.bus))
+		return false;
+
+	if (__host_bridge_whitelist(host_a) && __host_bridge_whitelist(host_b))
+		return true;
+
+	return false;
+}
+
 static enum pci_p2pdma_map_type
 __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
@@ -418,8 +428,7 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 					      acs_redirects, acs_list);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
-		if (!root_complex_whitelist(provider) ||
-		    !root_complex_whitelist(client))
+		if (!host_bridge_whitelist(provider, client))
 			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-- 
2.20.1

