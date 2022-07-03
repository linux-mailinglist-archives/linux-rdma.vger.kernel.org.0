Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1EE5645A0
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Jul 2022 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiGCHm6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 3 Jul 2022 03:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiGCHmz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 3 Jul 2022 03:42:55 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403764C6
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 00:42:54 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7uFmo6kcZP8Ap7uFmoDLDw; Sun, 03 Jul 2022 09:42:52 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Jul 2022 09:42:52 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Roland Dreier <rolandd@cisco.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/qib: Use the bitmap API when applicable
Date:   Sun,  3 Jul 2022 09:42:48 +0200
Message-Id: <33d8992586d382bec8b8efd83e4729fb7feaf89e.1656834106.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using the bitmap API is less verbose than hand writing them.
It also improves the semantic.

While at it, initialize the bitmaps. It can't hurt.

Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand adapters")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/qib/qib_iba7322.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index ceed302cf6a0..6861c6384f18 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -2850,9 +2850,9 @@ static void qib_setup_7322_cleanup(struct qib_devdata *dd)
 
 	qib_7322_free_irq(dd);
 	kfree(dd->cspec->cntrs);
-	kfree(dd->cspec->sendchkenable);
-	kfree(dd->cspec->sendgrhchk);
-	kfree(dd->cspec->sendibchk);
+	bitmap_free(dd->cspec->sendchkenable);
+	bitmap_free(dd->cspec->sendgrhchk);
+	bitmap_free(dd->cspec->sendibchk);
 	kfree(dd->cspec->msix_entries);
 	for (i = 0; i < dd->num_pports; i++) {
 		unsigned long flags;
@@ -6383,18 +6383,11 @@ static int qib_init_7322_variables(struct qib_devdata *dd)
 	features = qib_7322_boardname(dd);
 
 	/* now that piobcnt2k and 4k set, we can allocate these */
-	sbufcnt = dd->piobcnt2k + dd->piobcnt4k +
-		NUM_VL15_BUFS + BITS_PER_LONG - 1;
-	sbufcnt /= BITS_PER_LONG;
-	dd->cspec->sendchkenable =
-		kmalloc_array(sbufcnt, sizeof(*dd->cspec->sendchkenable),
-			      GFP_KERNEL);
-	dd->cspec->sendgrhchk =
-		kmalloc_array(sbufcnt, sizeof(*dd->cspec->sendgrhchk),
-			      GFP_KERNEL);
-	dd->cspec->sendibchk =
-		kmalloc_array(sbufcnt, sizeof(*dd->cspec->sendibchk),
-			      GFP_KERNEL);
+	sbufcnt = dd->piobcnt2k + dd->piobcnt4k + NUM_VL15_BUFS;
+
+	dd->cspec->sendchkenable = bitmap_zalloc(sbufcnt, GFP_KERNEL);
+	dd->cspec->sendgrhchk = bitmap_zalloc(sbufcnt, GFP_KERNEL);
+	dd->cspec->sendibchk = bitmap_zalloc(sbufcnt, GFP_KERNEL);
 	if (!dd->cspec->sendchkenable || !dd->cspec->sendgrhchk ||
 		!dd->cspec->sendibchk) {
 		ret = -ENOMEM;
-- 
2.34.1

