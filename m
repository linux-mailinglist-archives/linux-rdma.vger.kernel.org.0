Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8471488859
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jan 2022 09:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiAIIbF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jan 2022 03:31:05 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:59555 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiAIIbF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jan 2022 03:31:05 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 6TbRnH3f3FGqt6TbRnEa6m; Sun, 09 Jan 2022 09:31:02 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 09 Jan 2022 09:31:02 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] IB/mthca: Remove useless DMA-32 fallback configuration
Date:   Sun,  9 Jan 2022 09:30:09 +0100
Message-Id: <4aeb3dcf39490334acf583e723a08ea7262b0912.1641716983.git.christophe.jaillet@wanadoo.fr>
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
 drivers/infiniband/hw/mthca/mthca_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index f507c4cd46d3..b54bc8865dae 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -939,12 +939,8 @@ static int __mthca_init_one(struct pci_dev *pdev, int hca_type)
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err) {
-		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit PCI DMA mask.\n");
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev, "Can't set PCI DMA mask, aborting.\n");
-			goto err_free_res;
-		}
+		dev_err(&pdev->dev, "Can't set PCI DMA mask, aborting.\n");
+		goto err_free_res;
 	}
 
 	/* We can handle large RDMA requests, so allow larger segments. */
-- 
2.32.0

