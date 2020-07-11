Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908BB21C312
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2020 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGKHb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jul 2020 03:31:27 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:43418 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgGKHb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 11 Jul 2020 03:31:26 -0400
Received: from localhost.localdomain ([93.22.151.150])
        by mwinf5d86 with ME
        id 1jXM2300K3Ewh7h03jXMGu; Sat, 11 Jul 2020 09:31:23 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jul 2020 09:31:23 +0200
X-ME-IP: 93.22.151.150
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     benve@cisco.com, neescoba@cisco.com, pkaustub@cisco.com,
        dledford@redhat.com, jgg@ziepe.ca, hch@infradead.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] RDMA/usnic: switch from 'pci_' to 'dma_' API
Date:   Sat, 11 Jul 2020 09:31:20 +0200
Message-Id: <20200711073120.249146-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script bellow.
It has been compile tested.

When memory is allocated, GFP_ATOMIC should be used to be consistent with
the surrounding code.

@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
---
 drivers/infiniband/hw/usnic/usnic_fwd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_fwd.c b/drivers/infiniband/hw/usnic/usnic_fwd.c
index 7875883621f4..398c4c00b932 100644
--- a/drivers/infiniband/hw/usnic/usnic_fwd.c
+++ b/drivers/infiniband/hw/usnic/usnic_fwd.c
@@ -214,7 +214,7 @@ usnic_fwd_alloc_flow(struct usnic_fwd_dev *ufdev, struct filter *filter,
 	if (!flow)
 		return ERR_PTR(-ENOMEM);
 
-	tlv = pci_alloc_consistent(pdev, tlv_size, &tlv_pa);
+	tlv = dma_alloc_coherent(&pdev->dev, tlv_size, &tlv_pa, GFP_ATOMIC);
 	if (!tlv) {
 		usnic_err("Failed to allocate memory\n");
 		status = -ENOMEM;
@@ -258,7 +258,7 @@ usnic_fwd_alloc_flow(struct usnic_fwd_dev *ufdev, struct filter *filter,
 
 out_free_tlv:
 	spin_unlock(&ufdev->lock);
-	pci_free_consistent(pdev, tlv_size, tlv, tlv_pa);
+	dma_free_coherent(&pdev->dev, tlv_size, tlv, tlv_pa);
 	if (!status)
 		return flow;
 out_free_flow:
-- 
2.25.1

