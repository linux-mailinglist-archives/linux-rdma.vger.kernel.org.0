Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED2E70CF0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 01:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfGVXJL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 19:09:11 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40248 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGVXJL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 19:09:11 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQb-0002jx-Dj; Mon, 22 Jul 2019 17:09:10 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hphQU-0001Qk-VM; Mon, 22 Jul 2019 17:09:03 -0600
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
Date:   Mon, 22 Jul 2019 17:08:48 -0600
Message-Id: <20190722230859.5436-4-logang@deltatee.com>
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
Subject: [PATCH 03/14] PCI/P2PDMA: Apply host bridge white list for ACS
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When a P2PDMA transfer is rejected due to ACS being set, we
can also check the white list and allow the transactions.

Do this by pushing the whitelist check into the
upstream_bridge_distance() function.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 289d03a31e7d..d5034e28d1e1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -324,15 +324,7 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 		dist_a++;
 	}
 
-	/*
-	 * Allow the connection if both devices are on a whitelisted root
-	 * complex, but add an arbitrary large value to the distance.
-	 */
-	if (root_complex_whitelist(provider) &&
-	    root_complex_whitelist(client))
-		return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
-
-	return (dist_a + dist_b) | P2PDMA_NOT_SUPPORTED;
+	return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
 
 check_b_path_acs:
 	bb = b;
@@ -350,7 +342,8 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 	}
 
 	if (acs_cnt)
-		return P2PDMA_NOT_SUPPORTED | P2PDMA_ACS_FORCES_UPSTREAM;
+		return (dist_a + dist_b) | P2PDMA_ACS_FORCES_UPSTREAM |
+			P2PDMA_THRU_HOST_BRIDGE;
 
 	return dist_a + dist_b;
 }
@@ -397,7 +390,17 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
-	return __upstream_bridge_distance(provider, client, acs_list);
+	int dist;
+
+	dist = __upstream_bridge_distance(provider, client, acs_list);
+
+	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
+		return dist;
+
+	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
+		return dist;
+
+	return dist | P2PDMA_NOT_SUPPORTED;
 }
 
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
-- 
2.20.1

