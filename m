Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA156BEED
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 20:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiGHQrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiGHQrl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 12:47:41 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD31735B5
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 09:47:41 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 9r8kojI1ym7vs9r8loGHRC; Fri, 08 Jul 2022 18:47:39 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 08 Jul 2022 18:47:39 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH 2/2] RDMA/rtrs-clt: Use bitmap_empty()
Date:   Fri,  8 Jul 2022 18:47:37 +0200
Message-Id: <b71ccfaf4a47dee8e1ad373604c861479d499b6b.1657298747.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
References: <ca9c5c8301d76d60de34640568b3db0d4401d050.1657298747.git.christophe.jaillet@wanadoo.fr>
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

Use bitmap_empty() instead of hand-writing them.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 06c27a3d83f5..8441f0965b56 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1433,12 +1433,10 @@ static int alloc_permits(struct rtrs_clt_sess *clt)
 
 static void free_permits(struct rtrs_clt_sess *clt)
 {
-	if (clt->permits_map) {
-		size_t sz = clt->queue_depth;
-
+	if (clt->permits_map)
 		wait_event(clt->permits_wait,
-			   find_first_bit(clt->permits_map, sz) >= sz);
-	}
+			   bitmap_empty(clt->permits_map, clt->queue_depth));
+
 	bitmap_free(clt->permits_map);
 	clt->permits_map = NULL;
 	kfree(clt->permits);
-- 
2.34.1

