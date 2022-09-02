Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114605AAC3C
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiIBKTk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiIBKTj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 06:19:39 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C371B07D0
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 03:19:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662113976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LuiwVrh2iN9SSxmGQh+3vb5qsEEh733wTsRzQvoQlBA=;
        b=NI4z6H4H4ddqqMA1v/0CN+MwvctBMErBJ/Vrw9K3nsqcG4O9iLxWdiVKAOZw5YtGfuNs1k
        Pe6dfKqIahdkpK61X56usOjFsIbkqUla8zkcE+99MmYcEU1MUIX0Ia3fSX3YPKph/84CxC
        PXYpXr9yE7z1qYHRUkeQ3GAicu1fIyQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH 3/3] RDMA/rtrs-clt: Kill xchg_paths
Date:   Fri,  2 Sep 2022 18:19:22 +0800
Message-Id: <20220902101922.26273-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220902101922.26273-1-guoqing.jiang@linux.dev>
References: <20220902101922.26273-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Let's call try_cmpxchg directly for the same purpose.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c29eccdb4fd2..0661a4e69fc9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2220,17 +2220,6 @@ static void rtrs_clt_stop_and_destroy_conns(struct rtrs_clt_path *clt_path)
 	}
 }
 
-static inline bool xchg_paths(struct rtrs_clt_path __rcu **rcu_ppcpu_path,
-			      struct rtrs_clt_path *clt_path,
-			      struct rtrs_clt_path *next)
-{
-	struct rtrs_clt_path **ppcpu_path;
-
-	/* Call cmpxchg() without sparse warnings */
-	ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
-	return clt_path == cmpxchg(ppcpu_path, clt_path, next);
-}
-
 static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 {
 	struct rtrs_clt_sess *clt = clt_path->clt;
@@ -2305,7 +2294,7 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 		 * We race with IO code path, which also changes pointer,
 		 * thus we have to be careful not to overwrite it.
 		 */
-		if (xchg_paths(ppcpu_path, clt_path, next))
+		if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, clt_path, next))
 			/*
 			 * @ppcpu_path was successfully replaced with @next,
 			 * that means that someone could also pick up the
-- 
2.31.1

