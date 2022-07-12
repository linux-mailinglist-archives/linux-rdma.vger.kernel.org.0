Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A287F57175D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiGLKbd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 06:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiGLKb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 06:31:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C148CAD863
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id os14so13530472ejb.4
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLsLaFia6rSr83SuGaInd17J5TvqZbvWOaZ3ptnS7I4=;
        b=FdmFVqENBvGRFnU3rNDqodWJVsgFxbKkJFCGMi7bzXLp0IsHvbTQkT7SGcyd/Jqfa7
         lp66ud1XCo8czZwpapJWwT7yDvPbki5WBiIfgHjxX5A2xv+Y1LqhVd/xG323dU+5Yp2n
         ef3BhYk75uZqRjyAzoVKfhBc83AOw++CCqqGoKJEVM/Et1kvP+NCPyBp+pz22vszPCZW
         7T3V7hmlNmKmNS/tKVFjP/3yYFHpwS6JnSnA72aDZR6F6sGPXYhOj1A6NnRPDsoNh0JN
         ux0SRLazOhB/g5Xj9axHtcH4U4QC3nkWMykyQAS9LU4rUL7rujerQxqyGmyY8UMBzDDT
         43eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLsLaFia6rSr83SuGaInd17J5TvqZbvWOaZ3ptnS7I4=;
        b=0Nakc4kAsCFJVqho5vIWZ/S03M+WqAi+aew8Nk5mU5ZTLI6lyCMayK/lBfdpjGfOHL
         +FiAYvXtO8vQLZyLFkNQHKESiKjFj+NW8pNdjBzTtdOR+LPJ60FWMKPj9OEiWle0oRiO
         TZpLEzOXElrkZWpuo3Pj6ioVfDRDFPHJr2eQcc2JZbmkbUqnFIE5XhqELqUu5VrS55IF
         Ol4qN9cfnKpAEzbWCmU6WdQqwij9FFNfFeAwTfJWrGr4UktsOTVVEotbH13H1IHQNOqz
         or1nqqzRCH3k16u2EjwQXnXmJlqJ07rv/ucEPEBdvX2GU91cTnozB3kfAYUOlN94pHBu
         qdfA==
X-Gm-Message-State: AJIora8BO8+ZsTNpJafAIq8bustBgQQO6ugG4M+hkMUcOZeiNM3SLuFd
        aGBADELcVFO3JhrvJFGBfJbTyNswx2zEUw==
X-Google-Smtp-Source: AGRyM1sIa92Kv1iq2hYYCgJEydv+ynAKb0/thFqV6hUWb12wqYvU/3W8f2uOyWlhZFdGngk0nowQsQ==
X-Received: by 2002:a17:906:730f:b0:726:ca34:e605 with SMTP id di15-20020a170906730f00b00726ca34e605mr23174499ejc.347.1657621880170;
        Tue, 12 Jul 2022 03:31:20 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b004355d27799fsm5763419edr.96.2022.07.12.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:31:19 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, kernel test robot <oliver.sang@intel.com>,
        Gioh Kim <gi-oh.kim@ionos.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: [PATCH v2 for-next 5/5] RDMA/rtrs-srv: Do not use mempool for page allocation
Date:   Tue, 12 Jul 2022 12:31:13 +0200
Message-Id: <20220712103113.617754-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712103113.617754-1-haris.iqbal@ionos.com>
References: <20220712103113.617754-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

The mempool is for guaranteed memory allocation during
extreme VM load (see the header of mempool.c of the kernel).
But rtrs-srv allocates pages only when creating new session.
There is no need to use the mempool.

With the removal of mempool, rtrs-server no longer need to reserve
huge mount of memory, this will avoid error like this:
https://lore.kernel.org/lkml/20220620020727.GA3669@xsang-OptiPlex-9020/

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
v1 -> v2: Added Reported-by, Acked-by.
	  Changed email link to lore.kernel.org

 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 8278d3600a36..34c03bde5064 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -11,7 +11,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
 
 #include <linux/module.h>
-#include <linux/mempool.h>
 
 #include "rtrs-srv.h"
 #include "rtrs-log.h"
@@ -26,11 +25,7 @@ MODULE_LICENSE("GPL");
 #define DEFAULT_SESS_QUEUE_DEPTH 512
 #define MAX_HDR_SIZE PAGE_SIZE
 
-/* We guarantee to serve 10 paths at least */
-#define CHUNK_POOL_SZ 10
-
 static struct rtrs_rdma_dev_pd dev_pd;
-static mempool_t *chunk_pool;
 struct class *rtrs_dev_class;
 static struct rtrs_srv_ib_ctx ib_ctx;
 
@@ -1358,7 +1353,7 @@ static void free_srv(struct rtrs_srv_sess *srv)
 
 	WARN_ON(refcount_read(&srv->refcount));
 	for (i = 0; i < srv->queue_depth; i++)
-		mempool_free(srv->chunks[i], chunk_pool);
+		__free_pages(srv->chunks[i], get_order(max_chunk_size));
 	kfree(srv->chunks);
 	mutex_destroy(&srv->paths_mutex);
 	mutex_destroy(&srv->paths_ev_mutex);
@@ -1411,7 +1406,8 @@ static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 		goto err_free_srv;
 
 	for (i = 0; i < srv->queue_depth; i++) {
-		srv->chunks[i] = mempool_alloc(chunk_pool, GFP_KERNEL);
+		srv->chunks[i] = alloc_pages(GFP_KERNEL,
+					     get_order(max_chunk_size));
 		if (!srv->chunks[i])
 			goto err_free_chunks;
 	}
@@ -1424,7 +1420,7 @@ static struct rtrs_srv_sess *get_or_create_srv(struct rtrs_srv_ctx *ctx,
 
 err_free_chunks:
 	while (i--)
-		mempool_free(srv->chunks[i], chunk_pool);
+		__free_pages(srv->chunks[i], get_order(max_chunk_size));
 	kfree(srv->chunks);
 
 err_free_srv:
@@ -2273,14 +2269,10 @@ static int __init rtrs_server_init(void)
 		       err);
 		return err;
 	}
-	chunk_pool = mempool_create_page_pool(sess_queue_depth * CHUNK_POOL_SZ,
-					      get_order(max_chunk_size));
-	if (!chunk_pool)
-		return -ENOMEM;
 	rtrs_dev_class = class_create(THIS_MODULE, "rtrs-server");
 	if (IS_ERR(rtrs_dev_class)) {
 		err = PTR_ERR(rtrs_dev_class);
-		goto out_chunk_pool;
+		goto out_err;
 	}
 	rtrs_wq = alloc_workqueue("rtrs_server_wq", 0, 0);
 	if (!rtrs_wq) {
@@ -2292,9 +2284,7 @@ static int __init rtrs_server_init(void)
 
 out_dev_class:
 	class_destroy(rtrs_dev_class);
-out_chunk_pool:
-	mempool_destroy(chunk_pool);
-
+out_err:
 	return err;
 }
 
@@ -2302,7 +2292,6 @@ static void __exit rtrs_server_exit(void)
 {
 	destroy_workqueue(rtrs_wq);
 	class_destroy(rtrs_dev_class);
-	mempool_destroy(chunk_pool);
 	rtrs_rdma_dev_pd_deinit(&dev_pd);
 }
 
-- 
2.25.1

