Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101323FD3B
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHIHpb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgHIHpb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 03:45:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C73C061756;
        Sun,  9 Aug 2020 00:45:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x25so134116pff.4;
        Sun, 09 Aug 2020 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=99KLVxoGYktpAH84WHol6L1wVNytU8WR1EzojQK+pz8=;
        b=Xd0h+wS84C7743+jiJu6F/MDNB44b8vDRcmzyzHrSa3zikoSElfyGdicdY/QObsqVq
         JXB3M8Yo7WFdtPZzOvbbAPiW5P47PVYST0u1HLpazfzVyL9O8q2hjh/VRuujCbqydfsU
         LwQIEE5FsiYwwi//yXXqCbdDfYpPo8HMj0pYfpZ628WM0LffgW8laRFCc1jW1hP4tAoX
         dGDOgrmHTwdDyz68fEkWsgXGW43z4CwpsndwvT2rJOSuk9dq73X9Zn38oHizhpuPJ98p
         pZQfkL+7IGukWJc1kkGw89dwl6veFPYUp8Z3pYa5im+skuH2IlnyGj7xD5y62BEVhYlw
         DoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=99KLVxoGYktpAH84WHol6L1wVNytU8WR1EzojQK+pz8=;
        b=OOMQx6bRQIMYXcGA7wVw47gmIBZkjXLUabnTIjDWcRelR4cvwrqt1OA7GP5EAR+9Gs
         yLyn2m65khlPIrglT4nK8GG2Be0fqQrFTiVl0GdqnsSoj4eZdwo329FRugRY3KnUC5QS
         8gl+AqpLOJfKnSblmKRHETx9Fhazrj6UbbEQDepZBeVXdYXnhwOKbVgLl0tK8F062biP
         7rjzwFxexfKgHcQ+/6pVmPKTGr41/7yF+oETeSqXxFdNCCiZTV2g2QnTG9K8aIUoX3qv
         dM85ZZ/7mNbr+BH6eJhE6WWzhLgLTJOqfp/I6KcYUyP/vVRHKBZxmnPUgi3gzXCIVHlg
         aMPA==
X-Gm-Message-State: AOAM532JLOv+u+46RU5Z8POiz9jGeToNOgbr5AA+iAePpegpOLA3s3et
        I7IKdDJZR17dQBYxyHgrheM=
X-Google-Smtp-Source: ABdhPJzsoCfxEnjao2KRuJ3zQCm54AGcQIDsaAojukQtP1HlpPxerMu0nntSsKFFpS0BGPEcKWSK3A==
X-Received: by 2002:a63:5b65:: with SMTP id l37mr17172064pgm.72.1596959130108;
        Sun, 09 Aug 2020 00:45:30 -0700 (PDT)
Received: from blackclown ([103.88.82.9])
        by smtp.gmail.com with ESMTPSA id b18sm5559113pgj.12.2020.08.09.00.45.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 00:45:29 -0700 (PDT)
Date:   Sun, 9 Aug 2020 13:15:17 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, galpress@amazon.com,
        sleybo@amazon.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 5/4] RDMA/efa : Remove pci-dma-compat wrapper APIs
Message-ID: <20200809074517.GA4419@blackclown>
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
 drivers/infiniband/hw/efa/efa_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 92d701146320..bcc931ad71b0 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -405,13 +405,13 @@ static int efa_device_init(struct efa_com_dev *edev, struct pci_dev *pdev)
                return err;
        }

-       err = pci_set_dma_mask(pdev, DMA_BIT_MASK(dma_width));
+       err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_width));
        if (err) {
                dev_err(&pdev->dev, "pci_set_dma_mask failed %d\n", err);
                return err;
        }

-       err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(dma_width));
+       err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(dma_width));
        if (err) {
                dev_err(&pdev->dev,
                        "err_pci_set_consistent_dma_mask failed %d\n",
-- 
2.17.1

