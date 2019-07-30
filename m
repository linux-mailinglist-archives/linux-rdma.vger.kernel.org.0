Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280207ADF6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfG3QgI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 12:36:08 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34198 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfG3QgH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:07 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003yB-5n; Tue, 30 Jul 2019 10:36:06 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6R-0001IL-Do; Tue, 30 Jul 2019 10:35:55 -0600
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
        Logan Gunthorpe <logang@deltatee.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date:   Tue, 30 Jul 2019 10:35:34 -0600
Message-Id: <20190730163545.4915-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, bhelgaas@google.com, hch@lst.de, jgg@mellanox.com, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, dan.j.williams@intel.com, epilmore@gigaio.com, sbates@raithlin.com, logang@deltatee.com, Christian.Koenig@amd.com, christian.koenig@amd.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported result upstream_bridge_distance()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add constant flags to indicate two devices are not supported or whether
the data path goes through the host bridge instead of using the negative
values -1 and -2.

This helps annotate the code better, but the main reason is so we
can use the information to store the required mapping method in an
xarray.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/p2pdma.c | 52 ++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 93fbda14f4a9..64f5a0e30244 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -289,6 +289,20 @@ static bool root_complex_whitelist(struct pci_dev *dev)
 	return false;
 }
 
+enum {
+	/*
+	 * These arbitrary offset are or'd onto the upstream distance
+	 * calculation for the following conditions:
+	 */
+
+	/* The data path includes the host-bridge */
+	P2PDMA_THRU_HOST_BRIDGE		= 0x02000000,
+	/* The data path is forced through the host-bridge due to ACS */
+	P2PDMA_ACS_FORCES_UPSTREAM	= 0x04000000,
+	/* The data path is not supported by P2PDMA */
+	P2PDMA_NOT_SUPPORTED		= 0x08000000,
+};
+
 /*
  * Find the distance through the nearest common upstream bridge between
  * two PCI devices.
@@ -313,22 +327,17 @@ static bool root_complex_whitelist(struct pci_dev *dev)
  * port of the switch, to the common upstream port, back up to the second
  * downstream port and then to Device B.
  *
- * Any two devices that don't have a common upstream bridge will return -1.
- * In this way devices on separate PCIe root ports will be rejected, which
- * is what we want for peer-to-peer seeing each PCIe root port defines a
- * separate hierarchy domain and there's no way to determine whether the root
- * complex supports forwarding between them.
+ * Any two devices that cannot communicate using p2pdma will return the distance
+ * with the flag P2PDMA_NOT_SUPPORTED.
  *
- * In the case where two devices are connected to different PCIe switches,
- * this function will still return a positive distance as long as both
- * switches eventually have a common upstream bridge. Note this covers
- * the case of using multiple PCIe switches to achieve a desired level of
- * fan-out from a root port. The exact distance will be a function of the
- * number of switches between Device A and Device B.
+ * Any two devices that have a data path that goes through the host bridge
+ * will consult a whitelist. If the host bridges are on the whitelist,
+ * then the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
+ * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
+ * be set.
  *
  * If a bridge which has any ACS redirection bits set is in the path
- * then this functions will return -2. This is so we reject any
- * cases where the TLPs are forwarded up into the root complex.
+ * then this functions will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
  * In this case, a list of all infringing bridge addresses will be
  * populated in acs_list (assuming it's non-null) for printk purposes.
  */
@@ -375,9 +384,9 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	 */
 	if (root_complex_whitelist(provider) &&
 	    root_complex_whitelist(client))
-		return 0x1000 + dist_a + dist_b;
+		return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
 
-	return -1;
+	return (dist_a + dist_b) | P2PDMA_NOT_SUPPORTED;
 
 check_b_path_acs:
 	bb = b;
@@ -395,7 +404,7 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	}
 
 	if (acs_cnt)
-		return -2;
+		return P2PDMA_NOT_SUPPORTED | P2PDMA_ACS_FORCES_UPSTREAM;
 
 	return dist_a + dist_b;
 }
@@ -411,16 +420,17 @@ static int upstream_bridge_distance_warn(struct pci_dev *provider,
 		return -ENOMEM;
 
 	ret = upstream_bridge_distance(provider, client, &acs_list);
-	if (ret == -2) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as ACS redirect is set between the client and provider (%s)\n",
+	if (ret & P2PDMA_ACS_FORCES_UPSTREAM) {
+		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
 		/* Drop final semicolon */
 		acs_list.buffer[acs_list.len-1] = 0;
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 acs_list.buffer);
+	}
 
-	} else if (ret < 0) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge\n",
+	if (ret & P2PDMA_NOT_SUPPORTED) {
+		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
 			 pci_name(provider));
 	}
 
@@ -484,7 +494,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 
 		pci_dev_put(pci_client);
 
-		if (ret < 0)
+		if (ret & P2PDMA_NOT_SUPPORTED)
 			not_supported = true;
 
 		if (not_supported && !verbose)
-- 
2.20.1

