Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0578A468
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfHLRbC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 13:31:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37770 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfHLRbB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 13:31:01 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9l-0002sW-OJ; Mon, 12 Aug 2019 11:31:00 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hxE9i-0002PF-Vp; Mon, 12 Aug 2019 11:30:51 -0600
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
Date:   Mon, 12 Aug 2019 11:30:37 -0600
Message-Id: <20190812173048.9186-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
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
Subject: [PATCH v3 03/14] PCI/P2PDMA: Add constants for map type results to upstream_bridge_distance()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add constant flags to indicate how two devices will be mapped or if they
are unsupported. upstream_bridge_distance() will now return the
mapping type and the distance in a passed-by-reference argument.

This helps annotate the code better, but the main reason is so we can use
the information to store the required mapping method in an xarray.

Link: https://lore.kernel.org/r/20190730163545.4915-4-logang@deltatee.com
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/p2pdma.c | 95 +++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 93fbda14f4a9..8f0688201aec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -20,6 +20,13 @@
 #include <linux/seq_buf.h>
 #include <linux/iommu.h>
 
+enum pci_p2pdma_map_type {
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	PCI_P2PDMA_MAP_BUS_ADDR,
+	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+};
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -313,34 +320,33 @@ static bool root_complex_whitelist(struct pci_dev *dev)
  * port of the switch, to the common upstream port, back up to the second
  * downstream port and then to Device B.
  *
- * Any two devices that don't have a common upstream bridge will return -1.
- * In this way devices on separate PCIe root ports will be rejected, which
- * is what we want for peer-to-peer seeing each PCIe root port defines a
- * separate hierarchy domain and there's no way to determine whether the root
- * complex supports forwarding between them.
+ * Any two devices that cannot communicate using p2pdma will return
+ * PCI_P2PDMA_MAP_NOT_SUPPORTED.
+ *
+ * Any two devices that have a data path that goes through the host bridge
+ * will consult a whitelist. If the host bridges are on the whitelist,
+ * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
  *
- * In the case where two devices are connected to different PCIe switches,
- * this function will still return a positive distance as long as both
- * switches eventually have a common upstream bridge. Note this covers
- * the case of using multiple PCIe switches to achieve a desired level of
- * fan-out from a root port. The exact distance will be a function of the
- * number of switches between Device A and Device B.
+ * If either bridge is not on the whitelist this function returns
+ * PCI_P2PDMA_MAP_NOT_SUPPORTED.
  *
- * If a bridge which has any ACS redirection bits set is in the path
- * then this functions will return -2. This is so we reject any
- * cases where the TLPs are forwarded up into the root complex.
- * In this case, a list of all infringing bridge addresses will be
- * populated in acs_list (assuming it's non-null) for printk purposes.
+ * If a bridge which has any ACS redirection bits set is in the path,
+ * acs_redirects will be set to true. In this case, a list of all infringing
+ * bridge addresses will be populated in acs_list (assuming it's non-null)
+ * for printk purposes.
  */
-static int upstream_bridge_distance(struct pci_dev *provider,
-				    struct pci_dev *client,
-				    struct seq_buf *acs_list)
+static enum pci_p2pdma_map_type
+upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
+		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
 	struct pci_dev *a = provider, *b = client, *bb;
 	int dist_a = 0;
 	int dist_b = 0;
 	int acs_cnt = 0;
 
+	if (acs_redirects)
+		*acs_redirects = false;
+
 	/*
 	 * Note, we don't need to take references to devices returned by
 	 * pci_upstream_bridge() seeing we hold a reference to a child
@@ -369,15 +375,18 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 		dist_a++;
 	}
 
+	if (dist)
+		*dist = dist_a + dist_b;
+
 	/*
 	 * Allow the connection if both devices are on a whitelisted root
 	 * complex, but add an arbitrary large value to the distance.
 	 */
 	if (root_complex_whitelist(provider) &&
 	    root_complex_whitelist(client))
-		return 0x1000 + dist_a + dist_b;
+		return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 
-	return -1;
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 
 check_b_path_acs:
 	bb = b;
@@ -394,33 +403,44 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 		bb = pci_upstream_bridge(bb);
 	}
 
-	if (acs_cnt)
-		return -2;
+	if (dist)
+		*dist = dist_a + dist_b;
 
-	return dist_a + dist_b;
+	if (acs_cnt) {
+		if (acs_redirects)
+			*acs_redirects = true;
+
+		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	}
+
+	return PCI_P2PDMA_MAP_BUS_ADDR;
 }
 
-static int upstream_bridge_distance_warn(struct pci_dev *provider,
-					 struct pci_dev *client)
+static enum pci_p2pdma_map_type
+upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
+			      int *dist)
 {
 	struct seq_buf acs_list;
+	bool acs_redirects;
 	int ret;
 
 	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
 	if (!acs_list.buffer)
 		return -ENOMEM;
 
-	ret = upstream_bridge_distance(provider, client, &acs_list);
-	if (ret == -2) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as ACS redirect is set between the client and provider (%s)\n",
+	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
+				       &acs_list);
+	if (acs_redirects) {
+		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
 		/* Drop final semicolon */
 		acs_list.buffer[acs_list.len-1] = 0;
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 acs_list.buffer);
+	}
 
-	} else if (ret < 0) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge\n",
+	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
+		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
 			 pci_name(provider));
 	}
 
@@ -452,7 +472,8 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 {
 	bool not_supported = false;
 	struct pci_dev *pci_client;
-	int distance = 0;
+	int total_dist = 0;
+	int distance;
 	int i, ret;
 
 	if (num_clients == 0)
@@ -477,26 +498,26 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 
 		if (verbose)
 			ret = upstream_bridge_distance_warn(provider,
-							    pci_client);
+					pci_client, &distance);
 		else
 			ret = upstream_bridge_distance(provider, pci_client,
-						       NULL);
+						       &distance, NULL, NULL);
 
 		pci_dev_put(pci_client);
 
-		if (ret < 0)
+		if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED)
 			not_supported = true;
 
 		if (not_supported && !verbose)
 			break;
 
-		distance += ret;
+		total_dist += distance;
 	}
 
 	if (not_supported)
 		return -1;
 
-	return distance;
+	return total_dist;
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_distance_many);
 
-- 
2.20.1

