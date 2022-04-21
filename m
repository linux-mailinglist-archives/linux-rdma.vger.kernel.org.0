Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DF95094BB
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383670AbiDUBoF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383668AbiDUBoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:03 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7D17046
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e656032735so2673644fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSkUR8iHoCDwj4Zz9gZcYpz6HMH9rY869OGi2lAzZt4=;
        b=fOegawjiKNomL1JphUlrIDktaUZmXLKyEhqgrMcjPmT/qFvXDoJe4lhOajVcCmozHS
         IklxTydGr3/aO5qqtbGTuq4rk1T05mCgMzlQnLrH+kw0JlhZiE5IZk8krQLnpTthsBdj
         xWt3FC0JafbXC4ZTdKJSu8w2sw6KdbzH5msZ5PrDr/WIzIJE0Ctzt0uc61jEcYib04+j
         ndakI2+TDBIStbhOQAnmWEUcRkGMFy4latodGHQ/zGeyW4h/mUI84Qm2oC/0u6Ukmdbz
         MB+1do0ImcFFg1Cx7EzcQi5FZXXXfpuO0J+uJLa+q6jyx2IqyTatIDjU8z83D5e5TJdD
         5q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSkUR8iHoCDwj4Zz9gZcYpz6HMH9rY869OGi2lAzZt4=;
        b=6VkeU+NtWb0/fO4/sNFBrQMsi9lwCJrJa1RZHp3rnWmRsIT/NHa4/giB9PkoxEcNWL
         18ouAbxqHzK4Rfu+dATFvrCoZpZ50S4Kxmp9fC9Mhdxdej0cZ0TnLHaimc4dpCt4PXI9
         m+WW3i/1aPljGbFuCQVmC0qjCaqzuabANbOlLAd0T8MzFb8KODoR3uKyVBV2tYbpARjq
         MGFgw8v0gpz3tUMMHbzJZ8KaSbJ3UH5zYyrhUbSCfkViPb1l1UniPtqrMJj01G0BUEMG
         1rL23nzpNKJ9vK5Tein5R91YIYw2fqMZTuEntEH7OfA8errblD0Nuog0ggZFLm9se8Ov
         25dg==
X-Gm-Message-State: AOAM532EUVWWrlpU6xdlhgnTwVtPrhRPCGb5ZWJdfIz0mostUN1Llbf6
        55U4Flk+MGil8YMV8WHNZuE=
X-Google-Smtp-Source: ABdhPJymekjzGraWL09YLz9gWIMyXp2u2tVIVTf58MBTv4gvpIW5EDoqLXNxnQeB9bDJobFVHOoslw==
X-Received: by 2002:a05:6870:a40a:b0:e5:c4cb:7b84 with SMTP id m10-20020a056870a40a00b000e5c4cb7b84mr2906013oal.123.1650505274715;
        Wed, 20 Apr 2022 18:41:14 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 09/10] RDMA/rxe: Convert read side locking to rcu
Date:   Wed, 20 Apr 2022 20:40:42 -0500
Message-Id: <20220421014042.26985-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use rcu_read_lock() for protecting read side operations in rxe_pool.c.
Convert write side locking to use plain spin_lock().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f5380b6bdea2..661e0af522a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -191,16 +191,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	struct xarray *xa = &pool->xa;
-	unsigned long flags;
 	void *obj;
 
-	xa_lock_irqsave(xa, flags);
+	rcu_read_lock();
 	elem = xa_load(xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
-	xa_unlock_irqrestore(xa, flags);
+	rcu_read_unlock();
 
 	return obj;
 }
@@ -217,16 +216,15 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
 	static int timeout = RXE_POOL_TIMEOUT;
-	unsigned long flags;
 	int ret, err = 0;
 	void *xa_ret;
 
+	WARN_ON(!in_task());
+
 	/* erase xarray entry to prevent looking up
 	 * the pool elem from its index
 	 */
-	xa_lock_irqsave(xa, flags);
-	xa_ret = __xa_erase(xa, elem->index);
-	xa_unlock_irqrestore(xa, flags);
+	xa_ret = xa_erase(xa, elem->index);
 	WARN_ON(xa_err(xa_ret));
 
 	/* if this is the last call to rxe_put complete the
@@ -251,7 +249,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 		pool->cleanup(elem);
 
 	if (pool->flags & RXE_POOL_ALLOC)
-		kfree(elem->obj);
+		kfree_rcu(elem->obj);
 
 	atomic_dec(&pool->num_elem);
 
@@ -270,12 +268,8 @@ int __rxe_put(struct rxe_pool_elem *elem)
 
 void __rxe_finalize(struct rxe_pool_elem *elem)
 {
-	struct xarray *xa = &elem->pool->xa;
-	unsigned long flags;
-	void *ret;
-
-	xa_lock_irqsave(xa, flags);
-	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
-	xa_unlock_irqrestore(xa, flags);
-	WARN_ON(xa_err(ret));
+	void *xa_ret;
+
+	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	WARN_ON(xa_err(xa_ret));
 }
-- 
2.32.0

