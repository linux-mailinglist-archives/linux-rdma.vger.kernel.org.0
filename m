Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD256C0AF
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiGHRhU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 13:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiGHRhT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 13:37:19 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DD606A4
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 10:37:17 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 9rukoBmwMvNzH9ruko3RGi; Fri, 08 Jul 2022 19:37:16 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Jul 2022 19:37:16 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH 1/2] RDMA/erdma: Use the bitmap API to allocate bitmaps
Date:   Fri,  8 Jul 2022 19:37:12 +0200
Message-Id: <2764b6e204b32ef8c198a5efaf6c6bc4119f7665.1657301795.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use [devm_]bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 7 +++----
 drivers/infiniband/hw/erdma/erdma_main.c | 9 ++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index 0cf5032d4b78..0489838d9717 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -78,10 +78,9 @@ static int erdma_cmdq_wait_res_init(struct erdma_dev *dev,
 		return -ENOMEM;
 
 	spin_lock_init(&cmdq->lock);
-	cmdq->comp_wait_bitmap =
-		devm_kcalloc(&dev->pdev->dev,
-			     BITS_TO_LONGS(cmdq->max_outstandings),
-			     sizeof(unsigned long), GFP_KERNEL);
+	cmdq->comp_wait_bitmap = devm_bitmap_zalloc(&dev->pdev->dev,
+						    cmdq->max_outstandings,
+						    GFP_KERNEL);
 	if (!cmdq->comp_wait_bitmap) {
 		devm_kfree(&dev->pdev->dev, cmdq->wait_pool);
 		return -ENOMEM;
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 27484bea51d9..7e1e27acb404 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -423,9 +423,8 @@ static int erdma_res_cb_init(struct erdma_dev *dev)
 	for (i = 0; i < ERDMA_RES_CNT; i++) {
 		dev->res_cb[i].next_alloc_idx = 1;
 		spin_lock_init(&dev->res_cb[i].lock);
-		dev->res_cb[i].bitmap =
-			kcalloc(BITS_TO_LONGS(dev->res_cb[i].max_cap),
-				sizeof(unsigned long), GFP_KERNEL);
+		dev->res_cb[i].bitmap = bitmap_zalloc(dev->res_cb[i].max_cap,
+						      GFP_KERNEL);
 		/* We will free the memory in erdma_res_cb_free */
 		if (!dev->res_cb[i].bitmap)
 			goto err;
@@ -435,7 +434,7 @@ static int erdma_res_cb_init(struct erdma_dev *dev)
 
 err:
 	for (j = 0; j < i; j++)
-		kfree(dev->res_cb[j].bitmap);
+		bitmap_free(dev->res_cb[j].bitmap);
 
 	return -ENOMEM;
 }
@@ -445,7 +444,7 @@ static void erdma_res_cb_free(struct erdma_dev *dev)
 	int i;
 
 	for (i = 0; i < ERDMA_RES_CNT; i++)
-		kfree(dev->res_cb[i].bitmap);
+		bitmap_free(dev->res_cb[i].bitmap);
 }
 
 static const struct ib_device_ops erdma_device_ops = {
-- 
2.34.1

