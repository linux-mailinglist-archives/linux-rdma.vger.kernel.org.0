Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400155B1927
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiIHJqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiIHJqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 05:46:36 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FBD11978B
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 02:46:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662630392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCI+PEE3yBXYxC/o+SmMDoeYy++YP5nDNCQqqu4eeaA=;
        b=J27eSsBl1xrF54hUwcS0zcaPmr4+wAwBiiYo5Rzp3+LMk2DKEK1/IPHiMGEUS4O9ejBCxC
        sy4/JgWj6hPpBL8Y4pw5E5dyfz+bFvcB1d0hVtec6bVrNzYarFGhDbKaKjYouYGBWZhniN
        9eRF3fGmb3dmwSggbU+NQt0cZsoVodU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V2 3/3] RDMA/rtrs-clt: Kill xchg_paths
Date:   Thu,  8 Sep 2022 17:45:48 +0800
Message-Id: <20220908094548.4115-4-guoqing.jiang@linux.dev>
In-Reply-To: <20220908094548.4115-1-guoqing.jiang@linux.dev>
References: <20220908094548.4115-1-guoqing.jiang@linux.dev>
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

Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c29eccdb4fd2..2428bf5d07e3 100644
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
@@ -2305,7 +2294,8 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 		 * We race with IO code path, which also changes pointer,
 		 * thus we have to be careful not to overwrite it.
 		 */
-		if (xchg_paths(ppcpu_path, clt_path, next))
+		if (try_cmpxchg((struct rtrs_clt_path **)ppcpu_path,
+				&clt_path, next))
 			/*
 			 * @ppcpu_path was successfully replaced with @next,
 			 * that means that someone could also pick up the
-- 
2.31.1

