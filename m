Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBBF8A485
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfHLRbn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 13:31:43 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37744 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfHLRa7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 13:30:59 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9l-0002sa-OD; Mon, 12 Aug 2019 11:30:57 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9j-0002PR-CT; Mon, 12 Aug 2019 11:30:51 -0600
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
Date:   Mon, 12 Aug 2019 11:30:41 -0600
Message-Id: <20190812173048.9186-8-logang@deltatee.com>
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
Subject: [PATCH v3 07/14] PCI/P2PDMA: Whitelist some Intel host bridges
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Intel devices do not have good support for P2P requests that span different
host bridges as the transactions will cross the QPI/UPI bus and this does
not perform well.

Therefore, enable support for these devices only if the host bridges match.

Add Intel devices that have been tested and are known to work. There are
likely many others out there that will need to be tested and added.

Link: https://lore.kernel.org/r/20190730163545.4915-8-logang@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/p2pdma.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4b9f0903b340..2c4a8e92ed64 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -269,9 +269,30 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
-static bool __host_bridge_whitelist(struct pci_host_bridge *host)
+static const struct pci_p2pdma_whitelist_entry {
+	unsigned short vendor;
+	unsigned short device;
+	enum {
+		REQ_SAME_HOST_BRIDGE	= 1 << 0,
+	} flags;
+} pci_p2pdma_whitelist[] = {
+	/* AMD ZEN */
+	{PCI_VENDOR_ID_AMD,	0x1450,	0},
+
+	/* Intel Xeon E5/Core i7 */
+	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
+	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
+	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
+	{}
+};
+
+static bool __host_bridge_whitelist(struct pci_host_bridge *host,
+				    bool same_host_bridge)
 {
 	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
+	const struct pci_p2pdma_whitelist_entry *entry;
 	unsigned short vendor, device;
 
 	if (!root)
@@ -281,9 +302,14 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host)
 	device = root->device;
 	pci_dev_put(root);
 
-	/* AMD ZEN host bridges can do peer to peer */
-	if (vendor == PCI_VENDOR_ID_AMD && device == 0x1450)
+	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
+		if (vendor != entry->vendor || device != entry->device)
+			continue;
+		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
+			return false;
+
 		return true;
+	}
 
 	return false;
 }
@@ -300,7 +326,11 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
 	if (iommu_present(a->dev.bus) || iommu_present(b->dev.bus))
 		return false;
 
-	if (__host_bridge_whitelist(host_a) && __host_bridge_whitelist(host_b))
+	if (host_a == host_b)
+		return __host_bridge_whitelist(host_a, true);
+
+	if (__host_bridge_whitelist(host_a, false) &&
+	    __host_bridge_whitelist(host_b, false))
 		return true;
 
 	return false;
-- 
2.20.1

