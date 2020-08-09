Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB43E23FD33
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 09:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHIHdr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgHIHdr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 03:33:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28588C061756;
        Sun,  9 Aug 2020 00:33:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so3497474pfn.0;
        Sun, 09 Aug 2020 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WZOtmEvxCn7v3WdQf7nTtkGqxqBfHwfePf0SShmSnEs=;
        b=g3xjq6WDE2JHOHG8sn+Dug1jZhh1k+4Vl8O7mn4+vVnAxIbENpH+xsHH4kcKfjD726
         dCt/8BVyjrjNbDVyrue4B3m91i742Scq+ZT77Ey5pqerxKpyEzfEx8YqAp8VUZ9sF5Fr
         xOcRe8ZP2d+y2VqhUJCOn+lb1lBuzY84Ku2szgOWPekTE3Rn0KfqNYMpdmJfn7Ivl8lo
         uywKHLjnoBeEZHSlMcOGOslm4EPRsC12i6pUQSqkBIcbFzrPTosaGgmTZ5DEm/R9T6ZA
         /11lfVOLWXMAlSjqZYwdukKjCteraEYHZ9dMCuN6Lqt+oepGxoE6WbNkHbx1JWFZde9S
         EgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WZOtmEvxCn7v3WdQf7nTtkGqxqBfHwfePf0SShmSnEs=;
        b=TfdC8s9K1gI5aPcZXHgMK1qbDDfy8768uLw/Ww2zKYe67mtob/3nb/uCc+ytjS68gq
         Vw5EEKRMQXxhYiclDgzyqaILfcSyegLAD0Z6WDuIBPpXfs6Te4TMYZaMH2CaTAg3UGrk
         h32wIZCvRdyumU82fmIC6ZbJqP5s0PhI2WlDtnRmXczDpvj3z1qBRQ+2r1M1UjZJmNzp
         xbwT/c7Ggk8SllnNuSL9/kOu61qQ+soVWRUIRNC3P/Ns04gk1sdTkyl3W1Z7yWs4+KNy
         FN3XZ6DkszItBMkmn8i13XWxt7AxhWnHo1y+uWNjLmehH206FrtnYOE8UlAtxJKhou6D
         3Yug==
X-Gm-Message-State: AOAM532jiqR4oHI7hJPosY6ozJhPQky+lESChvaMdrnhUFkSJGmKgpMS
        VKAapT8uASbOCLe0E/5md9w=
X-Google-Smtp-Source: ABdhPJzT9snL3ubyfewamf+zN8YRVQffeAGJ3brjFc/lUodTbxdZO0mAzv29Ik947iqOHeadlh3ddA==
X-Received: by 2002:a62:7794:: with SMTP id s142mr19260524pfc.99.1596958426667;
        Sun, 09 Aug 2020 00:33:46 -0700 (PDT)
Received: from blackclown ([103.88.82.9])
        by smtp.gmail.com with ESMTPSA id p20sm15773023pjz.49.2020.08.09.00.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 00:33:46 -0700 (PDT)
Date:   Sun, 9 Aug 2020 13:03:33 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, aditr@vmware.com,
        pv-drivers@vmware.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 4/4] RDMA/pvrdma: Remove pci-dma-compat wrapper APIs
Message-ID: <57d345ca9a34f2b75b8b3a46bf473772194a0681.1596957073.git.usuraj35@gmail.com>
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
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 780fd2dfc07e..3c7802f7e298 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -839,15 +839,15 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Enable 64-Bit DMA */
-	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) == 0) {
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
 		if (ret != 0) {
 			dev_err(&pdev->dev,
 				"pci_set_consistent_dma_mask failed\n");
 			goto err_free_resource;
 		}
 	} else {
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret != 0) {
 			dev_err(&pdev->dev,
 				"pci_set_dma_mask failed\n");
-- 
2.17.1

