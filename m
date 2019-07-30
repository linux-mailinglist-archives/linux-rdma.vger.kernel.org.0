Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F27C7ADFB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfG3QgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 12:36:11 -0400
Received: from ale.deltatee.com ([207.54.116.67]:34258 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbfG3QgK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 12:36:10 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6V-0003yD-5o; Tue, 30 Jul 2019 10:36:07 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hsV6R-0001IR-Jq; Tue, 30 Jul 2019 10:35:55 -0600
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
Date:   Tue, 30 Jul 2019 10:35:36 -0600
Message-Id: <20190730163545.4915-6-logang@deltatee.com>
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
Subject: [PATCH v2 05/14] PCI/P2PDMA: Apply host bridge white list for ACS
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/pci/p2pdma.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b4ef6e8da784..10765ab90e64 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -340,15 +340,7 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
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
@@ -366,7 +358,8 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 	}
 
 	if (acs_cnt)
-		return P2PDMA_NOT_SUPPORTED | P2PDMA_ACS_FORCES_UPSTREAM;
+		return (dist_a + dist_b) | P2PDMA_ACS_FORCES_UPSTREAM |
+			P2PDMA_THRU_HOST_BRIDGE;
 
 	return dist_a + dist_b;
 }
@@ -413,7 +406,17 @@ static int upstream_bridge_distance(struct pci_dev *provider,
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

