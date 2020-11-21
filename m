Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEC42BBE49
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Nov 2020 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgKUJvc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Nov 2020 04:51:32 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:36781 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgKUJvb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Nov 2020 04:51:31 -0500
Received: from localhost.localdomain ([81.185.161.242])
        by mwinf5d61 with ME
        id uxrS230045E5lq903xrSLm; Sat, 21 Nov 2020 10:51:27 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Nov 2020 10:51:27 +0100
X-ME-IP: 81.185.161.242
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] IB/qib: Use dma_set_mask_and_coherent to simplify code
Date:   Sat, 21 Nov 2020 10:51:27 +0100
Message-Id: <20201121095127.1335228-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/qib/qib_pcie.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 3dc6ce033319..2e07b3749b88 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -90,25 +90,18 @@ int qib_pcie_init(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto bail;
 	}
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
 		/*
 		 * If the 64 bit setup fails, try 32 bit.  Some systems
 		 * do not setup 64 bit maps on systems with 2GB or less
 		 * memory installed.
 		 */
-		ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (ret) {
 			qib_devinfo(pdev, "Unable to set DMA mask: %d\n", ret);
 			goto bail;
 		}
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
-	} else
-		ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (ret) {
-		qib_early_err(&pdev->dev,
-			      "Unable to set DMA consistent mask: %d\n", ret);
-		goto bail;
 	}
 
 	pci_set_master(pdev);
-- 
2.27.0

