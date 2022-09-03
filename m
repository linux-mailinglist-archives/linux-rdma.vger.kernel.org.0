Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA915ABCB8
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Sep 2022 06:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiICEEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Sep 2022 00:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiICEEa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Sep 2022 00:04:30 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F629FD3
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 21:04:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662177866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cedBl/jLOxYj/EuWU4qy36COFoUepZ9P8av/XRI4Y1w=;
        b=O5CF+T8gqmHER1RvwcJEKiR+Z2EpMqyhQOe2M3nZ0Y3+3/rVY9CJc4z1U3eBAQ+haWf0cn
        GTGVD5/ChBwjXJBhvhSIre8zs0brYalyxEBQLOpjPyfFnUaNRr30I7PVNsoGQylCsTVt2I
        c73pldWspOBTh8H30lA3t0SxUVJRLoU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: [Updated PATCH 3/3] RDMA/rtrs-clt: Kill xchg_paths
Date:   Sat,  3 Sep 2022 12:02:52 +0800
Message-Id: <20220903040252.29397-1-guoqing.jiang@linux.dev>
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
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c29eccdb4fd2..9586de08818f 100644
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
+		if (try_cmpxchg((typeof(ppcpu_path))ppcpu_path, &clt_path, next))
 			/*
 			 * @ppcpu_path was successfully replaced with @next,
 			 * that means that someone could also pick up the
-- 
2.31.1

