Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7A48885E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jan 2022 09:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiAIIfz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jan 2022 03:35:55 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:60584 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbiAIIfz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jan 2022 03:35:55 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6Tg9nH5hLFGqt6Tg9nEaxZ; Sun, 09 Jan 2022 09:35:54 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 09 Jan 2022 09:35:54 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/pvrdma: Remove useless DMA-32 fallback configuration
Date:   Sun,  9 Jan 2022 09:35:18 +0100
Message-Id: <10c29cb45d14fb8ed89cf1308c4a9a7d445c52eb.1641717275.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 105f3a155939..343288b02792 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -811,12 +811,10 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Enable 64-Bit DMA */
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0) {
-		ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (ret != 0) {
-			dev_err(&pdev->dev, "dma_set_mask failed\n");
-			goto err_free_resource;
-		}
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_mask failed\n");
+		goto err_free_resource;
 	}
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 	pci_set_master(pdev);
-- 
2.32.0

