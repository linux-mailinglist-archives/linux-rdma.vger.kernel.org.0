Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00027ADF3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfG3QgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 12:36:07 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34156 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729326AbfG3QgG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:06 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003yC-5p; Tue, 30 Jul 2019 10:36:05 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6R-0001IO-Gl; Tue, 30 Jul 2019 10:35:55 -0600
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
Date:   Tue, 30 Jul 2019 10:35:35 -0600
Message-Id: <20190730163545.4915-5-logang@deltatee.com>
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
Subject: [PATCH v2 04/14] PCI/P2PDMA: Factor out __upstream_bridge_distance()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a prep patch to create a second level helper. There are no
functional changes.

The root complex whitelist code will be moved into this function in
a subsequent patch.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/p2pdma.c | 89 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 64f5a0e30244..b4ef6e8da784 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -303,47 +303,9 @@ enum {
 	P2PDMA_NOT_SUPPORTED		= 0x08000000,
 };
 
-/*
- * Find the distance through the nearest common upstream bridge between
- * two PCI devices.
- *
- * If the two devices are the same device then 0 will be returned.
- *
- * If there are two virtual functions of the same device behind the same
- * bridge port then 2 will be returned (one step down to the PCIe switch,
- * then one step back to the same device).
- *
- * In the case where two devices are connected to the same PCIe switch, the
- * value 4 will be returned. This corresponds to the following PCI tree:
- *
- *     -+  Root Port
- *      \+ Switch Upstream Port
- *       +-+ Switch Downstream Port
- *       + \- Device A
- *       \-+ Switch Downstream Port
- *         \- Device B
- *
- * The distance is 4 because we traverse from Device A through the downstream
- * port of the switch, to the common upstream port, back up to the second
- * downstream port and then to Device B.
- *
- * Any two devices that cannot communicate using p2pdma will return the distance
- * with the flag P2PDMA_NOT_SUPPORTED.
- *
- * Any two devices that have a data path that goes through the host bridge
- * will consult a whitelist. If the host bridges are on the whitelist,
- * then the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
- * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
- * be set.
- *
- * If a bridge which has any ACS redirection bits set is in the path
- * then this functions will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
- * In this case, a list of all infringing bridge addresses will be
- * populated in acs_list (assuming it's non-null) for printk purposes.
- */
-static int upstream_bridge_distance(struct pci_dev *provider,
-				    struct pci_dev *client,
-				    struct seq_buf *acs_list)
+static int __upstream_bridge_distance(struct pci_dev *provider,
+				      struct pci_dev *client,
+				      struct seq_buf *acs_list)
 {
 	struct pci_dev *a = provider, *b = client, *bb;
 	int dist_a = 0;
@@ -409,6 +371,51 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	return dist_a + dist_b;
 }
 
+/*
+ * Find the distance through the nearest common upstream bridge between
+ * two PCI devices.
+ *
+ * If the two devices are the same device then 0 will be returned.
+ *
+ * If there are two virtual functions of the same device behind the same
+ * bridge port then 2 will be returned (one step down to the PCIe switch,
+ * then one step back to the same device).
+ *
+ * In the case where two devices are connected to the same PCIe switch, the
+ * value 4 will be returned. This corresponds to the following PCI tree:
+ *
+ *     -+  Root Port
+ *      \+ Switch Upstream Port
+ *       +-+ Switch Downstream Port
+ *       + \- Device A
+ *       \-+ Switch Downstream Port
+ *         \- Device B
+ *
+ * The distance is 4 because we traverse from Device A through the downstream
+ * port of the switch, to the common upstream port, back up to the second
+ * downstream port and then to Device B.
+ *
+ * Any two devices that cannot communicate using p2pdma will return the distance
+ * with the flag P2PDMA_NOT_SUPPORTED.
+ *
+ * Any two devices that have a data path that goes through the host bridge
+ * will consult a whitelist. If the host bridges are on the whitelist,
+ * then the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
+ * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
+ * be set.
+ *
+ * If a bridge which has any ACS redirection bits set is in the path
+ * then this functions will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
+ * In this case, a list of all infringing bridge addresses will be
+ * populated in acs_list (assuming it's non-null) for printk purposes.
+ */
+static int upstream_bridge_distance(struct pci_dev *provider,
+				    struct pci_dev *client,
+				    struct seq_buf *acs_list)
+{
+	return __upstream_bridge_distance(provider, client, acs_list);
+}
+
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
 					 struct pci_dev *client)
 {
-- 
2.20.1

