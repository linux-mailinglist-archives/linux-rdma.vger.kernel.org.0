Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D821831CC30
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Feb 2021 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBPOk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 09:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhBPOiw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 09:38:52 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95CCC061756
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 06:38:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f14so16902437ejc.8
        for <linux-rdma@vger.kernel.org>; Tue, 16 Feb 2021 06:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWjrod3tLA4a5r6U0gY+A6F2cUnWdAOzP0CmAkChK5I=;
        b=FNf2nfByJxzYzRfMjUFw11L/DkxQx4UX1q+l3Iim05hinqqpazdPHfKdXGq7xIivqC
         REjEUk533YLoCw0savdXuDN51/fGFMH8bRhIYONM+03eZKXPYQQzucWgY8GXEMnMqLjt
         tv80TXqkJ+vQiNSld+4fUm3/5e69ZnPjtB3nWpkd4BirBYGkiQ6PR/YIh4Vt127UJwtS
         G4NvbjszxVm7AKLsKNMJRgeGS3pQqJp4Y09GlpT6+jQVLunTEl2VD3zYv6WFwuoBV8dO
         dFgXzvepxnAqZ3zxgQhsPYtpEd1pHkpP4tv8sVYOZno3RopOAe7F+r/ItT+0jJ86LbP1
         h5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IWjrod3tLA4a5r6U0gY+A6F2cUnWdAOzP0CmAkChK5I=;
        b=KbYSsog4rU9J8hFzC53uHVdEMZwz5OiYteIst9PxcMjf8RaGqgEvsYI89XSBG1w2mv
         uqNc17Kb8kEmlhcouFWzRNn/jkNfCSLM+yDcDGUphbdi1UOqGnf/DouqJmAvFvEUZpLa
         LLWQuhFMsudYndUkff5MVXehuNi/szo58t+jxMSSoDtEaYeHcaBO2ahG5O1qy1aFLN18
         hJg9XZqYaZOTW/yN5yvFhO+vVitmC/FrEoEE+tKvHwbl/wuf7TRmk1sM8mmL07iBdW2t
         w1C7OiRb5mLLSr4BTgAHBKDR9SZ0HmRO7F9jaIrx1QAvPpExqcwuqUkcAH97FdeB/uX1
         YNyw==
X-Gm-Message-State: AOAM530HDYH3GHmSNzTw9IZUfhNhZSnz182FtonuUcphO4s95VoxbHxt
        oq4Fn+vO6YxTWpxmCkUE6ybJTtgrMMR0sQ==
X-Google-Smtp-Source: ABdhPJzUs/nQIApwomT0Ogsw5v9DDvjqKb06r1b0+AIqx6mAcJA1+PPlKpj6C2yR2WEayA0LBy06HQ==
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr18909454ejx.466.1613486288175;
        Tue, 16 Feb 2021 06:38:08 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:495c:7b00:c58d:d927:ec25:bb7b])
        by smtp.gmail.com with ESMTPSA id z2sm13696909ejd.44.2021.02.16.06.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 06:38:07 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] RDMA/rtrs-srv: Suppress warnings passing zero to 'PTR_ERR'
Date:   Tue, 16 Feb 2021 15:38:07 +0100
Message-Id: <20210216143807.65923-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

smatch warnings:
drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'

Smatch seems confused by the refcount_read condition, the solution is
protect move the list_add down after full initilization of rtrs_srv.
To avoid holding the srv_mutex too long, only hold it during
the list operation as suggested by Leon.

Fixes: f0751419d3a1 ("RDMA/rtrs: Only allow addition of path to an already established session")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index eb17c3a08810..d071809e3ed2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1347,21 +1347,18 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 			return srv;
 		}
 	}
+	mutex_unlock(&ctx->srv_mutex);
 	/*
 	 * If this request is not the first connection request from the
 	 * client for this session then fail and return error.
 	 */
-	if (!first_conn) {
-		mutex_unlock(&ctx->srv_mutex);
+	if (!first_conn)
 		return ERR_PTR(-ENXIO);
-	}
 
 	/* need to allocate a new srv */
 	srv = kzalloc(sizeof(*srv), GFP_KERNEL);
-	if  (!srv) {
-		mutex_unlock(&ctx->srv_mutex);
+	if  (!srv)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	INIT_LIST_HEAD(&srv->paths_list);
 	mutex_init(&srv->paths_mutex);
@@ -1371,8 +1368,6 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 	srv->ctx = ctx;
 	device_initialize(&srv->dev);
 	srv->dev.release = rtrs_srv_dev_release;
-	list_add(&srv->ctx_list, &ctx->srv_list);
-	mutex_unlock(&ctx->srv_mutex);
 
 	srv->chunks = kcalloc(srv->queue_depth, sizeof(*srv->chunks),
 			      GFP_KERNEL);
@@ -1385,6 +1380,9 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 			goto err_free_chunks;
 	}
 	refcount_set(&srv->refcount, 1);
+	mutex_lock(&ctx->srv_mutex);
+	list_add(&srv->ctx_list, &ctx->srv_list);
+	mutex_unlock(&ctx->srv_mutex);
 
 	return srv;
 
@@ -1799,11 +1797,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 	}
 	recon_cnt = le16_to_cpu(msg->recon_cnt);
 	srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
-	/*
-	 * "refcount == 0" happens if a previous thread calls get_or_create_srv
-	 * allocate srv, but chunks of srv are not allocated yet.
-	 */
-	if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
+	if (IS_ERR(srv)) {
 		err = PTR_ERR(srv);
 		goto reject_w_err;
 	}
-- 
2.25.1

