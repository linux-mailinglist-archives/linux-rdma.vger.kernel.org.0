Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0B626D3C
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Nov 2022 02:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiKMBI7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Nov 2022 20:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiKMBI5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Nov 2022 20:08:57 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB51A190
        for <linux-rdma@vger.kernel.org>; Sat, 12 Nov 2022 17:08:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668301734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GI+N4DZ/N9r46P6gR7pi1nlnhW04QcncRt3cBrWRYbg=;
        b=u07R6Ks8xjMB1MPxwEuuSPaO9992bCi9eDtpCuJwr/2lHhsghWTsZ5H+r4v8hCU8Rx6/da
        OjCKMNcYj/GC7F3faJEZClyXBGRGDAG7gMVZJy4ByGMyy0+1XO6Ors/PyV/wOGQc1vTops
        ix3enZwOiJdP/SmdVyf4qM0JSIDHVmY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH RFC 10/12] RDMA/rtrs-srv: Remove paths_num
Date:   Sun, 13 Nov 2022 09:08:21 +0800
Message-Id: <20221113010823.6436-11-guoqing.jiang@linux.dev>
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

The paths_num is only increased by rtrs_rdma_connect -> __alloc_path
which is only one time thing, so is the decreasing of it given only
rtrs_srv_close_work -> del_path_from_srv, which means paths_num should
always be 1.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 --------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index e2ea09a8def7..400cf8ae34a3 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1437,8 +1437,6 @@ static void __add_path_to_srv(struct rtrs_srv_sess *srv,
 			      struct rtrs_srv_path *srv_path)
 {
 	list_add_tail(&srv_path->s.entry, &srv->paths_list);
-	srv->paths_num++;
-	WARN_ON(srv->paths_num >= MAX_PATHS_NUM);
 }
 
 static void del_path_from_srv(struct rtrs_srv_path *srv_path)
@@ -1450,8 +1448,6 @@ static void del_path_from_srv(struct rtrs_srv_path *srv_path)
 
 	mutex_lock(&srv->paths_mutex);
 	list_del(&srv_path->s.entry);
-	WARN_ON(!srv->paths_num);
-	srv->paths_num--;
 	mutex_unlock(&srv->paths_mutex);
 }
 
@@ -1719,10 +1715,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	char str[NAME_MAX];
 	struct rtrs_addr path;
 
-	if (srv->paths_num >= MAX_PATHS_NUM) {
-		err = -ECONNRESET;
-		goto err;
-	}
 	if (__is_path_w_addr_exists(srv, &cm_id->route.addr)) {
 		err = -EEXIST;
 		pr_err("Path with same addr exists\n");
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index eccc432b0715..8e4fcb578f49 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -100,7 +100,6 @@ struct rtrs_srv_sess {
 	struct list_head	paths_list;
 	int			paths_up;
 	struct mutex		paths_ev_mutex;
-	size_t			paths_num;
 	struct mutex		paths_mutex;
 	uuid_t			paths_uuid;
 	refcount_t		refcount;
-- 
2.31.1

