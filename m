Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA074309D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 00:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjF2Wcz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 18:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjF2Wcn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 18:32:43 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26DC359C
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 15:31:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b867acbf6dso750131a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688077885; x=1690669885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=800WRXQ6Tm/rlujxnl9FxV7t6ZEH09a2JuLU2meIAyM=;
        b=nSs4GNxuhmzYGMKEZWWsm1sjwmTJw/6V+4Dl7TndqK5kWK9PYjRKVAr80ir1Sm8gYA
         LTbROe7dTDb9ND3t/7r2labkvB85SD8p5bg/hk3t6OKeWU+8jehB3agsW23yrp6YuvKQ
         9oLTR7yxItXC2eHkGfS7rjrn954mCa3uv+aPjkUnud2NL0x/4O6a5xIU6BIBnJHEoNNh
         1jXsVinj481/RAuBnmiaJ7/XTQVDRSLtGJrJWmAaJf6JMCyVne4Wr9oSzTGoPKvojo7w
         qlhWXmxKwO35tybkBFuL0FHmaANMbuUT7mbgFa/SP1mlH5J1N3zpLEE1V5rBuZE5Oguv
         LbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688077885; x=1690669885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=800WRXQ6Tm/rlujxnl9FxV7t6ZEH09a2JuLU2meIAyM=;
        b=imMjActvzLotbLrW8tluTY3U8i0OHyu1tHrqW/lfDCv8uvpWFIMHBx6iiryk4uN3c/
         sGepRxrfnt5jaz8E4Hdlqty4VKknH9qLWOWv22XnQLU3cqYvp4pW7Z+qOhFQZIE6YhTk
         9MD1YaNQPnpMXjm6iYZtLqhNtX2pHIMn7pxKWE+uMcJ1B3DPbU6t3XPKvmcdPJMhFJEb
         lNOs43492nFwfFx6qPQjp7PL2QhRl3XsFMKgEtPPV9DXt9EfZ/irID5PUyN4K6d+++RV
         5MTw7x4hxc7yk70KEa3EDWwX1D4Ebp6CvjWDNQNBEOFb8To/NvsSk5u0YqImWVUx2ZTt
         Ux+Q==
X-Gm-Message-State: AC+VfDxBY8lAtD0fcrKBXKgOrtJlthLztjHp6xnGYKMSHUM4Ltq5tqnh
        YefCUkAg0D3QBQZzWL2t6dob9p57flc=
X-Google-Smtp-Source: ACHHUZ7tGHTLx33j1SA3rCqMvkW36tZpL+4m0Z2+syIww1TP9dbeOsjRxqVTbYjEVibp1ZAU9zgrkg==
X-Received: by 2002:aca:f056:0:b0:3a1:d438:843c with SMTP id o83-20020acaf056000000b003a1d438843cmr3217627oih.24.1688077884873;
        Thu, 29 Jun 2023 15:31:24 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-fa73-c602-0aec-b14e.res6.spectrum.com. [2603:8081:140c:1a00:fa73:c602:aec:b14e])
        by smtp.gmail.com with ESMTPSA id f5-20020a4ab645000000b005658aed310bsm2508525ooo.15.2023.06.29.15.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:31:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, frank.zago@hpe.com,
        ian.ziemba@hpe.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix potential race in rxe_pool_get_index
Date:   Thu, 29 Jun 2023 17:30:24 -0500
Message-Id: <20230629223023.84008-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the lookup of an object from its index and taking a
reference to the object are incorrectly protected by an rcu_read_lock
but this does not make the xa_load and the kref_get combination an
atomic operation.

The various write operations need to share the xarray state in a
mixture of user, soft irq and hard irq contexts so the xa_locking
must support that.

This patch replaces the xa locks with xa_lock_irqsave.

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6215c6de3a84..f2b586249793 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -119,8 +119,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 				bool sleepable)
 {
-	int err;
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 	gfp_t gfp_flags;
+	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto err_cnt;
@@ -138,8 +140,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
 
 	if (sleepable)
 		might_sleep();
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
+	xa_lock_irqsave(xa, flags);
+	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
 			      &pool->next, gfp_flags);
+	xa_unlock_irqrestore(xa, flags);
 	if (err < 0)
 		goto err_cnt;
 
@@ -154,15 +158,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 	void *obj;
 
-	rcu_read_lock();
+	xa_lock_irqsave(xa, flags);
 	elem = xa_load(xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
 	else
 		obj = NULL;
-	rcu_read_unlock();
+	xa_unlock_irqrestore(xa, flags);
 
 	return obj;
 }
@@ -179,6 +184,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
 	static int timeout = RXE_POOL_TIMEOUT;
+	unsigned long flags;
 	int ret, err = 0;
 	void *xa_ret;
 
@@ -188,7 +194,9 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	/* erase xarray entry to prevent looking up
 	 * the pool elem from its index
 	 */
-	xa_ret = xa_erase(xa, elem->index);
+	xa_lock_irqsave(xa, flags);
+	xa_ret = __xa_erase(xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
 	WARN_ON(xa_err(xa_ret));
 
 	/* if this is the last call to rxe_put complete the
@@ -249,8 +257,12 @@ int __rxe_put(struct rxe_pool_elem *elem)
 
 void __rxe_finalize(struct rxe_pool_elem *elem)
 {
+	struct xarray *xa = &elem->pool->xa;
+	unsigned long flags;
 	void *xa_ret;
 
-	xa_ret = xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	xa_lock_irqsave(xa, flags);
+	xa_ret = __xa_store(xa, elem->index, elem, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
 	WARN_ON(xa_err(xa_ret));
 }

base-commit: 5f004bcaee4cb552cf1b46a505f18f08777db7e5
-- 
2.39.2

