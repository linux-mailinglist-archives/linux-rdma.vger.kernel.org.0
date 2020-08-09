Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0109123FD23
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgHIH3m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgHIH3l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 03:29:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C1C061756;
        Sun,  9 Aug 2020 00:29:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so3219078pgn.13;
        Sun, 09 Aug 2020 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uw4AJhVOUVAPmZTUOaWlOKe34sDgFsEFEe1OfXc73/E=;
        b=tkAagPMQlJdpJJ4qZQlmkpI/R8yagVk2xbRK2v8Y9uYaYUWiAuO9JX+aJvvx011cON
         Esg7H6Ugbc1uLg5BelgZc3T86mXs37sERnrvfpDbCVfR1cK1Hy+8DCErw5jeswyCBAHb
         Tn6AMM1oKO35JiAYCDD5z3xI1OP6SwH5FjOaVg5uFrysyTFq83T9iDSdiN3lAd8K+Snk
         Ve9BIuXrBQkztKvHU+TFapwxNeRE0Y8LIwQLkI8S77rmbl85l2352GkDVrek3j5fbqMD
         H+MYJXrMR5SMieCP0Tcv+TGPL5QZpsGdukfxXOGhO3RuVuhmhs6SuTN0hhZe8fXzk7jm
         Ca0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uw4AJhVOUVAPmZTUOaWlOKe34sDgFsEFEe1OfXc73/E=;
        b=kZuMlGtv6rtXnnA+F+Yqwvq9LKGcYa96w4e7WzWPcqrhsGORcYlBEZP+q/oveX+KmF
         dnE+HWP5u5YDDXQYnJVq3dcIJWp1ssb6PIU83eFVnQRMNF42anzZdX/rx1LaViN/h3fs
         fI/cH5W8qTRqaiwj/vWntLioM9dVnDyrB8QopEVpV+4UKCfBmMAwZGd9Z0g1hQ53XBbB
         3Vxs6n0tN3RpWyAgTrTwZv3fFriIAYq9O3qC+WIPQUGs+6mw1eWwS+mtqUijzRHgiSaq
         8ynbKW8Pi6VZbwLElMH2h/wGVi97IuoV7NVgrl+1SR5s82Iq1XGciBiBaWE1lrU0S1By
         Ixdw==
X-Gm-Message-State: AOAM532zVyvyK/9dBuLxXhHGRExSpNtrHJXcdTSe8cDde0888/eaHybC
        YwtstlgiBeOQSQGjL8tWDB4=
X-Google-Smtp-Source: ABdhPJws8yMgz/33peTxloHjqq+m8aTYxNK4BPLMCQhigQHIwkQ/ijeqyEXEIr7zMk0WOqs6ERCcoQ==
X-Received: by 2002:aa7:97a3:: with SMTP id d3mr20515753pfq.178.1596958180986;
        Sun, 09 Aug 2020 00:29:40 -0700 (PDT)
Received: from blackclown ([103.88.82.9])
        by smtp.gmail.com with ESMTPSA id 25sm18241169pfh.37.2020.08.09.00.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 00:29:40 -0700 (PDT)
Date:   Sun, 9 Aug 2020 12:59:27 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/4] IB/hfi1: Remove pci-dma-compat wrapper APIs
Message-ID: <1d74b57647f511de3d5ab96dbb4149fdbce58f64.1596957073.git.usuraj35@gmail.com>
References: <cover.1596957073.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1596957073.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The legacy API wrappers in include/linux/pci-dma-compat.h
should go away as it creates unnecessary midlayering
for include/linux/dma-mapping.h APIs.

Instead use dma-mapping.h APIs directly.

The patch has been generated with the coccinelle script below
and compile-tested.

@@@@
- PCI_DMA_BIDIRECTIONAL
+ DMA_BIDIRECTIONAL

@@@@
- PCI_DMA_TODEVICE
+ DMA_TO_DEVICE

@@@@
- PCI_DMA_FROMDEVICE
+ DMA_FROM_DEVICE

@@@@
- PCI_DMA_NONE
+ DMA_NONE

@@ expression E1, E2, E3; @@
- pci_alloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_)

@@ expression E1, E2, E3; @@
- pci_zalloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_)

@@ expression E1, E2, E3, E4; @@
- pci_free_consistent(E1, E2, E3, E4)
+ dma_free_coherent(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_single(E1, E2, E3, E4)
+ dma_map_single(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_single(E1, E2, E3, E4)
+ dma_unmap_single(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4, E5; @@
- pci_map_page(E1, E2, E3, E4, E5)
+ dma_map_page(&E1->dev, E2, E3, E4, E5)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_page(E1, E2, E3, E4)
+ dma_unmap_page(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_sg(E1, E2, E3, E4)
+ dma_map_sg(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_sg(E1, E2, E3, E4)
+ dma_unmap_sg(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_cpu(E1, E2, E3, E4)
+ dma_sync_single_for_cpu(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_device(E1, E2, E3, E4)
+ dma_sync_single_for_device(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_cpu(E1, E2, E3, E4)
+ dma_sync_sg_for_cpu(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_device(E1, E2, E3, E4)
+ dma_sync_sg_for_device(&E1->dev, E2, E3, E4)

@@ expression E1, E2; @@
- pci_dma_mapping_error(E1, E2)
+ dma_mapping_error(&E1->dev, E2)

@@ expression E1, E2; @@
- pci_set_consistent_dma_mask(E1, E2)
+ dma_set_coherent_mask(&E1->dev, E2)

@@ expression E1, E2; @@
- pci_set_dma_mask(E1, E2)
+ dma_set_mask(&E1->dev, E2)

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/infiniband/hw/hfi1/pcie.c         |  8 ++++----
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 13 ++++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 18d32f053d26..a2356bfa1485 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -92,21 +92,21 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
 		goto bail;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		/*
 		 * If the 64 bit setup fails, try 32 bit.  Some systems
 		 * do not setup 64 bit maps on systems with 2GB or less
 		 * memory installed.
 		 */
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dd_dev_err(dd, "Unable to set DMA mask: %d\n", ret);
 			goto bail;
 		}
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	} else {
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 	}
 	if (ret) {
 		dd_dev_err(dd, "Unable to set DMA consistent mask: %d\n", ret);
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index f81ca20f4b69..fe737da3d1dc 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -175,8 +175,8 @@ static void unpin_rcv_pages(struct hfi1_filedata *fd,
 	struct hfi1_devdata *dd = fd->uctxt->dd;
 
 	if (mapped) {
-		pci_unmap_single(dd->pcidev, node->dma_addr,
-				 node->npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&dd->pcidev->dev, node->dma_addr,
+				 node->npages * PAGE_SIZE, DMA_FROM_DEVICE);
 		pages = &node->pages[idx];
 	} else {
 		pages = &tidbuf->pages[idx];
@@ -735,9 +735,8 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	if (!node)
 		return -ENOMEM;
 
-	phys = pci_map_single(dd->pcidev,
-			      __va(page_to_phys(pages[0])),
-			      npages * PAGE_SIZE, PCI_DMA_FROMDEVICE);
+	phys = dma_map_single(&dd->pcidev->dev, __va(page_to_phys(pages[0])),
+			      npages * PAGE_SIZE, DMA_FROM_DEVICE);
 	if (dma_mapping_error(&dd->pcidev->dev, phys)) {
 		dd_dev_err(dd, "Failed to DMA map Exp Rcv pages 0x%llx\n",
 			   phys);
@@ -779,8 +778,8 @@ static int set_rcvarray_entry(struct hfi1_filedata *fd,
 	hfi1_cdbg(TID, "Failed to insert RB node %u 0x%lx, 0x%lx %d",
 		  node->rcventry, node->notifier.interval_tree.start,
 		  node->phys, ret);
-	pci_unmap_single(dd->pcidev, phys, npages * PAGE_SIZE,
-			 PCI_DMA_FROMDEVICE);
+	dma_unmap_single(&dd->pcidev->dev, phys, npages * PAGE_SIZE,
+			 DMA_FROM_DEVICE);
 	kfree(node);
 	return -EFAULT;
 }
-- 
2.17.1

