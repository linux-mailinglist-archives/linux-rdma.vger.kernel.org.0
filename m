Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39F370D15
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 01:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfGVXKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 19:10:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40280 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbfGVXJO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 19:09:14 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQb-0002jy-Dj; Mon, 22 Jul 2019 17:09:13 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQV-0001Qn-7B; Mon, 22 Jul 2019 17:09:03 -0600
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
Date:   Mon, 22 Jul 2019 17:08:49 -0600
Message-Id: <20190722230859.5436-5-logang@deltatee.com>
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
Subject: [PATCH 04/14] PCI/P2PDMA: Cache the result of upstream_bridge_distance()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The result of upstream_bridge_distance() will be needed every time
we map the dma address so cache it in an xarray stored in the
provider's p2pdma struct.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d5034e28d1e1..25663c1d8bc9 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -19,10 +19,12 @@
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/iommu.h>
+#include <linux/xarray.h>
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
+	struct xarray dist_cache;
 };
 
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
@@ -98,6 +100,8 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p)
 		return -ENOMEM;
 
+	xa_init(&p2p->dist_cache);
+
 	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
 	if (!p2p->pool)
 		goto out;
@@ -390,17 +394,34 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
+	void *entry;
 	int dist;
+	int idx;
+
+	idx = (pci_domain_nr(client->bus) << 16) |
+		(client->bus->number << 8) | client->devfn;
+
+	if (provider->p2pdma) {
+		entry = xa_load(&provider->p2pdma->dist_cache, idx);
+		if (entry)
+			return xa_to_value(entry);
+	}
 
 	dist = __upstream_bridge_distance(provider, client, acs_list);
 
 	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
-		return dist;
+		goto store_and_return;
+
+	if (!root_complex_whitelist(provider) ||
+	    !root_complex_whitelist(client))
+		dist |= P2PDMA_NOT_SUPPORTED;
 
-	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
-		return dist;
+store_and_return:
+	if (provider->p2pdma)
+		xa_store(&provider->p2pdma->dist_cache, idx,
+			 xa_mk_value(dist), GFP_KERNEL);
 
-	return dist | P2PDMA_NOT_SUPPORTED;
+	return dist;
 }
 
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
-- 
2.20.1

