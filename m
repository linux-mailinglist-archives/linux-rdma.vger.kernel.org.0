Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6194570A9F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 21:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiGKTVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiGKTVo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 15:21:44 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D744877483
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 12:21:43 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id AyyToa9r026JCAyyToNQOs; Mon, 11 Jul 2022 21:21:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 11 Jul 2022 21:21:42 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/irdma: Use the bitmap API to allocate bitmaps
Date:   Mon, 11 Jul 2022 21:21:39 +0200
Message-Id: <1f671b1af5881723ee265a0a12809c92950e58aa.1657567269.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/irdma/hw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index dd3943d22dc6..675b138e8ef0 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1543,7 +1543,7 @@ static void irdma_del_init_mem(struct irdma_pci_f *rf)
 			  rf->obj_mem.pa);
 	rf->obj_mem.va = NULL;
 	if (rf->rdma_ver != IRDMA_GEN_1) {
-		kfree(rf->allocated_ws_nodes);
+		bitmap_free(rf->allocated_ws_nodes);
 		rf->allocated_ws_nodes = NULL;
 	}
 	kfree(rf->ceqlist);
@@ -1972,9 +1972,8 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 	u32 ret;
 
 	if (rf->rdma_ver != IRDMA_GEN_1) {
-		rf->allocated_ws_nodes =
-			kcalloc(BITS_TO_LONGS(IRDMA_MAX_WS_NODES),
-				sizeof(unsigned long), GFP_KERNEL);
+		rf->allocated_ws_nodes = bitmap_zalloc(IRDMA_MAX_WS_NODES,
+						       GFP_KERNEL);
 		if (!rf->allocated_ws_nodes)
 			return -ENOMEM;
 
@@ -2023,7 +2022,7 @@ u32 irdma_initialize_hw_rsrc(struct irdma_pci_f *rf)
 	return 0;
 
 mem_rsrc_kzalloc_fail:
-	kfree(rf->allocated_ws_nodes);
+	bitmap_free(rf->allocated_ws_nodes);
 	rf->allocated_ws_nodes = NULL;
 
 	return ret;
-- 
2.34.1

