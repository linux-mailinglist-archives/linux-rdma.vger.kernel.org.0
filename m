Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB0E4D33C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfFTQOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:14:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59468 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732159AbfFTQM5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:12:57 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg7-00046V-8b; Thu, 20 Jun 2019 10:12:56 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hdzg6-0005xC-QR; Thu, 20 Jun 2019 10:12:46 -0600
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
Date:   Thu, 20 Jun 2019 10:12:39 -0600
Message-Id: <20190620161240.22738-28-logang@deltatee.com>
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
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [RFC PATCH 27/28] PCI/P2PDMA: Remove struct pages that back P2PDMA memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are no more users of the struct pages that back P2P memory,
so convert the devm_memremap_pages() call to devm_memremap() to remove
them.

The percpu_ref and completion are retained in struct p2pdma to track
when there is no memory allocated out of the genpool and it is safe
to free it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 107 +++++++++++++------------------------------
 1 file changed, 33 insertions(+), 74 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9b82e13f802c..83d93911f792 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -22,10 +22,6 @@
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
-};
-
-struct p2pdma_pagemap {
-	struct dev_pagemap pgmap;
 	struct percpu_ref ref;
 	struct completion ref_done;
 };
@@ -78,29 +74,12 @@ static const struct attribute_group p2pmem_group = {
 	.name = "p2pmem",
 };
 
-static struct p2pdma_pagemap *to_p2p_pgmap(struct percpu_ref *ref)
-{
-	return container_of(ref, struct p2pdma_pagemap, ref);
-}
-
 static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
 {
-	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
+	struct pci_p2pdma *p2pdma =
+		container_of(ref, struct pci_p2pdma, ref);
 
-	complete(&p2p_pgmap->ref_done);
-}
-
-static void pci_p2pdma_percpu_kill(struct percpu_ref *ref)
-{
-	percpu_ref_kill(ref);
-}
-
-static void pci_p2pdma_percpu_cleanup(struct percpu_ref *ref)
-{
-	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
-
-	wait_for_completion(&p2p_pgmap->ref_done);
-	percpu_ref_exit(&p2p_pgmap->ref);
+	complete(&p2pdma->ref_done);
 }
 
 static void pci_p2pdma_release(void *data)
@@ -111,6 +90,10 @@ static void pci_p2pdma_release(void *data)
 	if (!p2pdma)
 		return;
 
+	percpu_ref_kill(&p2pdma->ref);
+	wait_for_completion(&p2pdma->ref_done);
+	percpu_ref_exit(&p2pdma->ref);
+
 	/* Flush and disable pci_alloc_p2p_mem() */
 	pdev->p2pdma = NULL;
 	synchronize_rcu();
@@ -128,10 +111,17 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p)
 		return -ENOMEM;
 
+	init_completion(&p2p->ref_done);
+
 	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
 	if (!p2p->pool)
 		goto out;
 
+	error = percpu_ref_init(&p2p->ref, pci_p2pdma_percpu_release, 0,
+				GFP_KERNEL);
+	if (error)
+		goto out_pool_destroy;
+
 	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_release, pdev);
 	if (error)
 		goto out_pool_destroy;
@@ -165,8 +155,7 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			    u64 offset)
 {
-	struct p2pdma_pagemap *p2p_pgmap;
-	struct dev_pagemap *pgmap;
+	struct resource res;
 	void *addr;
 	int error;
 
@@ -188,50 +177,26 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			return error;
 	}
 
-	p2p_pgmap = devm_kzalloc(&pdev->dev, sizeof(*p2p_pgmap), GFP_KERNEL);
-	if (!p2p_pgmap)
-		return -ENOMEM;
+	res.start = pci_resource_start(pdev, bar) + offset;
+	res.end = res.start + size - 1;
+	res.flags = pci_resource_flags(pdev, bar);
 
-	init_completion(&p2p_pgmap->ref_done);
-	error = percpu_ref_init(&p2p_pgmap->ref,
-			pci_p2pdma_percpu_release, 0, GFP_KERNEL);
-	if (error)
-		goto pgmap_free;
-
-	pgmap = &p2p_pgmap->pgmap;
-
-	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
-	pgmap->res.end = pgmap->res.start + size - 1;
-	pgmap->res.flags = pci_resource_flags(pdev, bar);
-	pgmap->ref = &p2p_pgmap->ref;
-	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
-	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
-		pci_resource_start(pdev, bar);
-	pgmap->kill = pci_p2pdma_percpu_kill;
-	pgmap->cleanup = pci_p2pdma_percpu_cleanup;
-
-	addr = devm_memremap_pages(&pdev->dev, pgmap);
-	if (IS_ERR(addr)) {
-		error = PTR_ERR(addr);
-		goto pgmap_free;
-	}
+	addr = devm_memremap(&pdev->dev, res.start, size, MEMREMAP_WC);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
-	error = gen_pool_add_owner(pdev->p2pdma->pool, (unsigned long)addr,
-			pci_bus_address(pdev, bar) + offset,
-			resource_size(&pgmap->res), dev_to_node(&pdev->dev),
-			&p2p_pgmap->ref);
+	error = gen_pool_add_virt(pdev->p2pdma->pool, (unsigned long)addr,
+				  pci_bus_address(pdev, bar) + offset, size,
+				  dev_to_node(&pdev->dev));
 	if (error)
 		goto pages_free;
 
-	pci_info(pdev, "added peer-to-peer DMA memory %pR\n",
-		 &pgmap->res);
+	pci_info(pdev, "added peer-to-peer DMA memory %pR\n", &res);
 
 	return 0;
 
 pages_free:
-	devm_memunmap_pages(&pdev->dev, pgmap);
-pgmap_free:
-	devm_kfree(&pdev->dev, p2p_pgmap);
+	devm_memunmap(&pdev->dev, addr);
 	return error;
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
@@ -601,7 +566,6 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_find_many);
 void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 {
 	void *ret = NULL;
-	struct percpu_ref *ref;
 
 	/*
 	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
@@ -612,16 +576,13 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 	if (unlikely(!pdev->p2pdma))
 		goto out;
 
-	ret = (void *)gen_pool_alloc_owner(pdev->p2pdma->pool, size,
-			(void **) &ref);
-	if (!ret)
+	if (unlikely(!percpu_ref_tryget_live(&pdev->p2pdma->ref)))
 		goto out;
 
-	if (unlikely(!percpu_ref_tryget_live(ref))) {
-		gen_pool_free(pdev->p2pdma->pool, (unsigned long) ret, size);
-		ret = NULL;
-		goto out;
-	}
+	ret = (void *)gen_pool_alloc(pdev->p2pdma->pool, size);
+	if (!ret)
+		percpu_ref_put(&pdev->p2pdma->ref);
+
 out:
 	rcu_read_unlock();
 	return ret;
@@ -636,11 +597,9 @@ EXPORT_SYMBOL_GPL(pci_alloc_p2pmem);
  */
 void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
 {
-	struct percpu_ref *ref;
+	gen_pool_free(pdev->p2pdma->pool, (uintptr_t)addr, size);
 
-	gen_pool_free_owner(pdev->p2pdma->pool, (uintptr_t)addr, size,
-			(void **) &ref);
-	percpu_ref_put(ref);
+	percpu_ref_put(&pdev->p2pdma->ref);
 }
 EXPORT_SYMBOL_GPL(pci_free_p2pmem);
 
-- 
2.20.1

