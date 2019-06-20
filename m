Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D534D31F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfFTQNA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:13:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59512 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732202AbfFTQNA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:13:00 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg8-00046J-T8; Thu, 20 Jun 2019 10:12:58 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-0005xF-V3; Thu, 20 Jun 2019 10:12:47 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 20 Jun 2019 10:12:40 -0600
Message-Id: <20190620161240.22738-29-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, axboe@kernel.dk, hch@lst.de, bhelgaas@google.com, dan.j.williams@intel.com, sagi@grimberg.me, kbusch@kernel.org, jgg@ziepe.ca, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [RFC PATCH 28/28] memremap: Remove PCI P2PDMA page memory type
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are no more users of MEMORY_DEVICE_PCI_P2PDMA and
is_pci_p2pdma_page(), so remove them.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/memremap.h |  5 -----
 include/linux/mm.h       | 13 -------------
 2 files changed, 18 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1732dea030b2..2e5d9fcd4d69 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -51,16 +51,11 @@ struct vmem_altmap {
  * wakeup event whenever a page is unpinned and becomes idle. This
  * wakeup is used to coordinate physical address space management (ex:
  * fs truncate/hole punch) vs pinned pages (ex: device dma).
- *
- * MEMORY_DEVICE_PCI_P2PDMA:
- * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
- * transactions.
  */
 enum memory_type {
 	MEMORY_DEVICE_PRIVATE = 1,
 	MEMORY_DEVICE_PUBLIC,
 	MEMORY_DEVICE_FS_DAX,
-	MEMORY_DEVICE_PCI_P2PDMA,
 };
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd0b5f4e1e45..f5fa9ec440e3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -966,19 +966,6 @@ static inline bool is_device_public_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
 }
 
-#ifdef CONFIG_PCI_P2PDMA
-static inline bool is_pci_p2pdma_page(const struct page *page)
-{
-	return is_zone_device_page(page) &&
-		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
-}
-#else /* CONFIG_PCI_P2PDMA */
-static inline bool is_pci_p2pdma_page(const struct page *page)
-{
-	return false;
-}
-#endif /* CONFIG_PCI_P2PDMA */
-
 #else /* CONFIG_DEV_PAGEMAP_OPS */
 static inline void dev_pagemap_get_ops(void)
 {
-- 
2.20.1

