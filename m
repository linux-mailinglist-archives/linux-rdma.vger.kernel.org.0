Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7D296A72
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375770AbgJWHoC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375768AbgJWHoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:44:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC89C0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gs25so1070327ejb.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=diduN3jCpnaYzfrSilCGd45/1ZVjBQlx57tpnHfb60U=;
        b=BqWS6YlsUUTH9KlBAdrNo3o/5AyCC2ydjA06Cg5GTkWTuDaLi/rfZnAp9MqW4+TUUt
         /h3T+WgQxQn5XilDWMCXpMjvqCutufHRFUKrN3PMIBa2SNmyPdgkFCHMkO8WrOYVnUzn
         FGLnel/GacXOaOGKBrcfXond0l/oBfGUdLAF2mkQTIJOIFODdpwMPa90bn8ELXBEOy0k
         gc1hLfIaqDVShPBkPP41S831FusTvEcEoxmdcTy78lF3tOcfgQvjoc15SxC8KvjCHsvX
         ++SvGHVaxWvS0gJUSVD9S3AurGOxdZnzGYaSb7w8e58GONIg+yWmebZgA13Q62gKwOvs
         09HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diduN3jCpnaYzfrSilCGd45/1ZVjBQlx57tpnHfb60U=;
        b=JReBFTIGVj4japGQMFM1IkSVtvDfMqfumScrukwi4FCxAzBBSRJE1KvJKQk/dvQrA5
         V9/33k7Wn6q2fT5lJwwEnrHwzPloeMsVjcd/X3RfQV2Mge9OnRI4f1bf6+WPpGrlBHId
         s20A7OpN5M4FamQ7eYkTFbS3xY1C2BfXhVY8vloEHOjUteBL0DtSaIZiiUUWQZrn1lm4
         dSxU7CQRLkOmE5NjJts43dbQbIuj47I8kyCsqFvFdBg/PISURxTxtD18uzcWDAoewOhl
         7+osQ6Iw8hIx6smoEzAgFHLuMcLs04p65bAQwWehbJauorTKzT6M4V4JOSi0Ta7mjl3g
         lUvw==
X-Gm-Message-State: AOAM533WP6djAofpY01VLEONhH9255Od/sxgorEWWcrOop3CrlE7Q669
        50PCJFmwMXBSLNPuVW3XQ7PnrcKhsR5Tgg==
X-Google-Smtp-Source: ABdhPJzcAUtTejlea70AuXFSEYK3JG8swW+BrJyOmTDQuc3VI0N4Olqh3GNKSzbrkxy7kiwslboKpw==
X-Received: by 2002:a17:906:76d5:: with SMTP id q21mr757957ejn.415.1603439039639;
        Fri, 23 Oct 2020 00:43:59 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:43:59 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCHv2 for-next 05/12] RDMA/rtrs-srv: don't guard the whole __alloc_srv with srv_mutex
Date:   Fri, 23 Oct 2020 09:43:46 +0200
Message-Id: <20201023074353.21946-6-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The purpose of srv_mutex is to protect srv_list as in put_srv, so no need
to hold it when allocate memory for srv since it could be time consuming.

Otherwise if one machine has limited memory, rsrv_close_work could be
blocked for a longer time due to the mutex is held by get_or_create_srv
since it can't get memory in time.

[13327733.807781] INFO: task kworker/1:1:27478 blocked for more than 120 seconds.
[13327733.854623]       Tainted: G           O    4.14.171-1-storage #4.14.171-1.3~deb9
[13327733.902461] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[13327733.953930] kworker/1:1     D    0 27478      2 0x80000000
[13327733.953938] Workqueue: rtrs_server_wq rtrs_srv_close_work [rtrs_server]
[13327733.953939] Call Trace:
[13327733.953945]  ? __schedule+0x38c/0x7e0
[13327733.953946]  schedule+0x32/0x80
[13327733.953948]  schedule_preempt_disabled+0xa/0x10
[13327733.953949]  __mutex_lock.isra.2+0x25e/0x4d0
[13327733.953954]  ? put_srv+0x44/0x100 [rtrs_server]
[13327733.953958]  put_srv+0x44/0x100 [rtrs_server]
[13327733.953961]  rtrs_srv_close_work+0x16c/0x280 [rtrs_server]
[13327733.953966]  process_one_work+0x1c5/0x3c0
[13327733.953969]  worker_thread+0x47/0x3e0
[13327733.953970]  kthread+0xfc/0x130
[13327733.953972]  ? trace_event_raw_event_workqueue_execute_start+0xa0/0xa0
[13327733.953973]  ? kthread_create_on_node+0x70/0x70
[13327733.953974]  ret_from_fork+0x1f/0x30

Let's move all the logics from  __find_srv_and_get and __alloc_srv to
get_or_create_srv, and remove the two functions. Then it should be safe
for multiple processes to access the same srv since it is protected
with srv_mutex.

And since we don't want to allocate chunks with srv_mutex held, let's
check the srv->refcount after get srv because the chunks could not be
allocated yet.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 86 +++++++++++---------------
 1 file changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d6f93601712e..1cb778aff3c5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1328,17 +1328,42 @@ static void rtrs_srv_dev_release(struct device *dev)
 	kfree(srv);
 }
 
-static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
-				     const uuid_t *paths_uuid)
+static void free_srv(struct rtrs_srv *srv)
+{
+	int i;
+
+	WARN_ON(refcount_read(&srv->refcount));
+	for (i = 0; i < srv->queue_depth; i++)
+		mempool_free(srv->chunks[i], chunk_pool);
+	kfree(srv->chunks);
+	mutex_destroy(&srv->paths_mutex);
+	mutex_destroy(&srv->paths_ev_mutex);
+	/* last put to release the srv structure */
+	put_device(&srv->dev);
+}
+
+static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
+					   const uuid_t *paths_uuid)
 {
 	struct rtrs_srv *srv;
 	int i;
 
+	mutex_lock(&ctx->srv_mutex);
+	list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
+		if (uuid_equal(&srv->paths_uuid, paths_uuid) &&
+		    refcount_inc_not_zero(&srv->refcount)) {
+			mutex_unlock(&ctx->srv_mutex);
+			return srv;
+		}
+	}
+
+	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
-	if  (!srv)
+	if  (!srv) {
+		mutex_unlock(&ctx->srv_mutex);
 		return NULL;
+	}
 
-	refcount_set(&srv->refcount, 1);
 	INIT_LIST_HEAD(&srv->paths_list);
 	mutex_init(&srv->paths_mutex);
 	mutex_init(&srv->paths_ev_mutex);
@@ -1347,6 +1372,8 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
 	srv->ctx = ctx;
 	device_initialize(&srv->dev);
 	srv->dev.release = rtrs_srv_dev_release;
+	list_add(&srv->ctx_list, &ctx->srv_list);
+	mutex_unlock(&ctx->srv_mutex);
 
 	srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
 			      GFP_KERNEL);
@@ -1358,7 +1385,7 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
 		if (!srv->chunks[i])
 			goto err_free_chunks;
 	}
-	list_add(&srv->ctx_list, &ctx->srv_list);
+	refcount_set(&srv->refcount, 1);
 
 	return srv;
 
@@ -1369,52 +1396,9 @@ static struct rtrs_srv *__alloc_srv(struct rtrs_srv_ctx *ctx,
 
 err_free_srv:
 	kfree(srv);
-
 	return NULL;
 }
 
-static void free_srv(struct rtrs_srv *srv)
-{
-	int i;
-
-	WARN_ON(refcount_read(&srv->refcount));
-	for (i = 0; i < srv->queue_depth; i++)
-		mempool_free(srv->chunks[i], chunk_pool);
-	kfree(srv->chunks);
-	mutex_destroy(&srv->paths_mutex);
-	mutex_destroy(&srv->paths_ev_mutex);
-	/* last put to release the srv structure */
-	put_device(&srv->dev);
-}
-
-static inline struct rtrs_srv *__find_srv_and_get(struct rtrs_srv_ctx *ctx,
-						   const uuid_t *paths_uuid)
-{
-	struct rtrs_srv *srv;
-
-	list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
-		if (uuid_equal(&srv->paths_uuid, paths_uuid) &&
-		    refcount_inc_not_zero(&srv->refcount))
-			return srv;
-	}
-
-	return NULL;
-}
-
-static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
-					   const uuid_t *paths_uuid)
-{
-	struct rtrs_srv *srv;
-
-	mutex_lock(&ctx->srv_mutex);
-	srv = __find_srv_and_get(ctx, paths_uuid);
-	if (!srv)
-		srv = __alloc_srv(ctx, paths_uuid);
-	mutex_unlock(&ctx->srv_mutex);
-
-	return srv;
-}
-
 static void put_srv(struct rtrs_srv *srv)
 {
 	if (refcount_dec_and_test(&srv->refcount)) {
@@ -1813,7 +1797,11 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	recon_cnt = le16_to_cpu(msg->recon_cnt);
 	srv = get_or_create_srv(ctx, &msg->paths_uuid);
-	if (!srv) {
+	/*
+	 * "refcount == 0" happens if a previous thread calls get_or_create_srv
+	 * allocate srv, but chunks of srv are not allocated yet.
+	 */
+	if (!srv || refcount_read(&srv->refcount) == 0) {
 		err = -ENOMEM;
 		goto reject_w_err;
 	}
-- 
2.25.1

