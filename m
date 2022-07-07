Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC63C56A547
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiGGOWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiGGOWH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 10:22:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C410E1C136
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 07:22:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r21so3922224eju.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sm88g2jYKtACpjqLwOPhgJtSKR5newRCaR/+fqpcw4Q=;
        b=KmkpuORm84QPsvOuq0sRXI/pU13ZjAbQ1Ug+Fidd1WE1r8txBb7qw2hYuyXjwrylRA
         IiJcGKkptYWck0KstfYGOC8x1GwJBIbffje4tw9QMiHPJUlOewp2N1ler159EhGC38cp
         hVA6RIOtUdPPnT28SfKRVpsXh0hlj6TIs2DXMy9RPYLdF9WHC35ZZN/B69UUGqrD0P1/
         7HDCGjPXb0S4pNhoWxbNEVAnepAmWY2WM76M1bLqanwLe68aHDhYe2wQ4h8ZvPTUqJK4
         /fSnqwSiX1wjP6Eor9JgoJCJfR4yuCaFsTKNx1cLLtL2nH7rqcdGCTBn3FmRmEiBcvZZ
         XajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sm88g2jYKtACpjqLwOPhgJtSKR5newRCaR/+fqpcw4Q=;
        b=Tp8kHqvxmI0FGryXP37ifxEuzePWFodhQfN+WHyloxgmlgtUku8fcKiSRvd10hLrt+
         8A+kt5PNwn2shFp3Xed230Jwsue6u1fj4WdK2QZEi0fH63+AsNz3aySGLATUiBIjJUhH
         GN0aiYjPlZQUmu7LRUuB2X1R5k9ElwaGoRISVBwvXCpVKmRQnAVizaipacg48NS/KWUG
         8UxkHJqV4mOTQFIltsBpFtGzmoKz2oKYPPfcNLJyfbXRfuCWDGxUvkha5QSRCvhRH2Ux
         XoqYpCOGKDAbHyajrXUGaSgBMdOncEE4ZKCl8ar7PrCdW45kR9I2Ov5rleKM1knh5+Go
         U55A==
X-Gm-Message-State: AJIora+BvH3eRBBv2Sym+PHm37DJ2MnEIX5wD1eyg1c/ldCGnMaEfBWQ
        kstlXsDM8zyJvYxT4spfI+gBA86miCj6Fw==
X-Google-Smtp-Source: AGRyM1vDzkADFeBsohgOyDcVT3C8SB+4Zx0pQi8cV7FxDrxNnhx+9wh9kfvTuHBO9aL3bgpbG9z+Kg==
X-Received: by 2002:a17:906:3f49:b0:722:e1d2:f857 with SMTP id f9-20020a1709063f4900b00722e1d2f857mr45712084ejj.15.1657203724241;
        Thu, 07 Jul 2022 07:22:04 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072b13fa5e4csm693807ejo.58.2022.07.07.07.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:22:03 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 5/5] RDMA/rtrs-srv: Do not use mempool for page allocation
Date:   Thu,  7 Jul 2022 16:21:44 +0200
Message-Id: <20220707142144.459751-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707142144.459751-1-haris.iqbal@ionos.com>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
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
https://www.spinics.net/lists/kernel/msg4404829.html

Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
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

