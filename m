Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3A626D39
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiKMBIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235088AbiKMBIv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:51 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0D25C7
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:50 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMIKurErvaKaHZgyBaYTVTZbaYHPzeiTsrjhEAmq01Y=;
        b=JNPyCjhKRBpOH2+Cm9GAkc6/ittCk/5msX40M29A47nB7wewGWToV5lt9ykayP6n8R8cnN
        kt3yVuK/9/yot+JqWnDnh6G4+RYnB26pA6AeyXjJ5ldIVKm585IMQJFkaq8pN2EgsMXskI
        NdIzsaJZSVFfztok4GoXGO9P7J0z97k=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 07/12] RDMA/rtrs-srv: Remove outdated comments from create_con
Date:   Sun, 13 Nov 2022 09:08:18 +0800
Message-Id: <20221113010823.6436-8-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-1-guoqing.jiang@linux.dev>
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the orphan comments.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index f3bf5bbb4377..4c883c57c2ef 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1671,12 +1671,6 @@ static int create_con(struct rtrs_srv_path *srv_path,
 				      srv->queue_depth * (1 + 2) + 1);
 
 		max_recv_wr = srv->queue_depth + 1;
-		/*
-		 * If we have all receive requests posted and
-		 * all write requests posted and each read request
-		 * requires an invalidate request + drain
-		 * and qp gets into error state.
-		 */
 	}
 	cq_num = max_send_wr + max_recv_wr;
 	atomic_set(&con->c.sq_wr_avail, max_send_wr);
-- 
2.31.1

