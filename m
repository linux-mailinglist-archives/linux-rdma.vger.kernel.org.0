Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4099156BF98
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 20:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiGHQri (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238805AbiGHQrc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 12:47:32 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EBF735B5
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 09:47:31 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 9r8aoCK06ZDzU9r8aojqo6; Fri, 08 Jul 2022 18:47:28 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Jul 2022 18:47:28 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH 1/2] RDMA/rtrs-clt: Use the bitmap API to allocate bitmaps
Date:   Fri,  8 Jul 2022 18:47:27 +0200
Message-Id: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 9809c3883979..06c27a3d83f5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1403,8 +1403,7 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
 	unsigned int chunk_bits;
 	int err, i;
 
-	clt->permits_map = kcalloc(BITS_TO_LONGS(clt->queue_depth),
-				   sizeof(long), GFP_KERNEL);
+	clt->permits_map = bitmap_zalloc(clt->queue_depth, GFP_KERNEL);
 	if (!clt->permits_map) {
 		err = -ENOMEM;
 		goto out_err;
@@ -1426,7 +1425,7 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
 	return 0;
 
 err_map:
-	kfree(clt->permits_map);
+	bitmap_free(clt->permits_map);
 	clt->permits_map = NULL;
 out_err:
 	return err;
@@ -1440,7 +1439,7 @@ static void free_permits(struct rtrs_clt_sess *clt)
 		wait_event(clt->permits_wait,
 			   find_first_bit(clt->permits_map, sz) >= sz);
 	}
-	kfree(clt->permits_map);
+	bitmap_free(clt->permits_map);
 	clt->permits_map = NULL;
 	kfree(clt->permits);
 	clt->permits = NULL;
-- 
2.34.1

