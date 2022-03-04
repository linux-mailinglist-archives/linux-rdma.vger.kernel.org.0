Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB454CCA8A
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiCDAJd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiCDAJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:32 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0EA4739D
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:45 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso6043232otf.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ogoeYaZbfYCtUhjokZrOpx/fxsyeSs3uXBu3OTPLTd0=;
        b=J+Cg4gFTjxgC2PLDdYtXfuITuAl0UlQWTN09s6ENz9MKMl/X0ZFcWVnJfpLG+udUkJ
         ODF2krQRarDIJr+LXyTyKYQv1llIEHAr+KMoLLLR8DXg4moRCpFjYdvSGT1E7M8GWl7F
         AWGOaZ066aGhyBr91HJvW3BmcfQ4RapvS1X6APiJjSg9tv898erFBOAovPXInGjsiBKj
         EgnNOJXu3ZBVbJsEB7MQDfk0eqKc8f6cScRQ+/Th2H/vWEPSTEEy6Cfws5XgEfBExSMJ
         fzh2KRwKFeJKbXYX/8PYFWZN4I9Okoh+30NhWCbOBugDgLwXVML4t5SJ3c0rKsm9lx8d
         KJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ogoeYaZbfYCtUhjokZrOpx/fxsyeSs3uXBu3OTPLTd0=;
        b=7Mz3opMAtRrma0+GVzcPUHLtuwSM4s/ljBq1M6SoQdZ6+o9zWaP7lbx1hlTY7VNh63
         okiozmhPKWfDcLFvT1PTPx5f6ZewoOlYgOnv7USFH4vAVLIoMzCB7J4azwDzI8g71yg0
         6OkecONOuHD1l7YUp4HkWUO/Ht4v3x0yVgnHDEGHCIZHAub3ZAR+HxKzHhZrvD66EtEY
         Wu7tIYVud1Pf7dWAd4Kd8RmNNCie7mAaHN944lsFg6KumPJUF9uX0e8/0NU/Vs1wmCAi
         3R0vpVGnPc6XdAp5l+ke+yJ0nDEB6VeLoThhISs7TfyR1EVHVnvRuyR185JWb/qgCt/I
         b82Q==
X-Gm-Message-State: AOAM5322xEghG/k8n43h3ZlC9afjj259YH6hY7kGoVd5jabd1h3X0wlp
        hyFfM/GrRCzrpqMe37t60sM=
X-Google-Smtp-Source: ABdhPJy/OzDJoq9uh25bo3lVKakxsiCT2SDuk34BqljR3OLB7oRuWGYhQrKap+yz3nO3cr6zOBxcpg==
X-Received: by 2002:a9d:6e01:0:b0:5af:5d9d:4039 with SMTP id e1-20020a9d6e01000000b005af5d9d4039mr19857342otr.280.1646352524479;
        Thu, 03 Mar 2022 16:08:44 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 04/13] RDMA/rxe: Delete _locked() APIs for pool objects
Date:   Thu,  3 Mar 2022 18:08:00 -0600
Message-Id: <20220304000808.225811-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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

Since caller managed locks for indexed objects are no longer used
these APIs are deleted.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 67 ++++------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h | 24 ++--------
 2 files changed, 12 insertions(+), 79 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 239c24544ff2..2e3543dde000 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -189,17 +189,6 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
 	return 0;
 }
 
-int __rxe_add_index_locked(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	elem->index = alloc_index(pool);
-	err = rxe_insert_index(pool, elem);
-
-	return err;
-}
-
 int __rxe_add_index(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -207,55 +196,24 @@ int __rxe_add_index(struct rxe_pool_elem *elem)
 	int err;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	err = __rxe_add_index_locked(elem);
+	elem->index = alloc_index(pool);
+	err = rxe_insert_index(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return err;
 }
 
-void __rxe_drop_index_locked(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
-}
-
 void __rxe_drop_index(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_index_locked(elem);
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void *rxe_alloc_locked(struct rxe_pool *pool)
-{
-	struct rxe_pool_elem *elem;
-	void *obj;
-
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
-
-	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
-	if (!obj)
-		goto out_cnt;
-
-	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
-
-	elem->pool = pool;
-	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
-
-	return obj;
-
-out_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
-}
-
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
@@ -321,12 +279,14 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
-	struct rb_node *node;
 	struct rxe_pool_elem *elem;
+	struct rb_node *node;
+	unsigned long flags;
 	void *obj;
 
+	read_lock_irqsave(&pool->pool_lock, flags);
 	node = pool->index.tree.rb_node;
 
 	while (node) {
@@ -346,17 +306,6 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 	} else {
 		obj = NULL;
 	}
-
-	return obj;
-}
-
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
-{
-	unsigned long flags;
-	void *obj;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
-	obj = rxe_pool_get_index_locked(pool, index);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 44b944c8c360..7fec5d96d695 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -68,9 +68,7 @@ int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool holding and not holding the pool lock */
-void *rxe_alloc_locked(struct rxe_pool *pool);
-
+/* allocate an object from pool */
 void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
@@ -79,32 +77,18 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
 /* assign an index to an indexed object and insert object into
- *  pool's rb tree holding and not holding the pool_lock
+ * pool's rb tree
  */
-int __rxe_add_index_locked(struct rxe_pool_elem *elem);
-
-#define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->elem)
-
 int __rxe_add_index(struct rxe_pool_elem *elem);
 
 #define rxe_add_index(obj) __rxe_add_index(&(obj)->elem)
 
-/* drop an index and remove object from rb tree
- * holding and not holding the pool_lock
- */
-void __rxe_drop_index_locked(struct rxe_pool_elem *elem);
-
-#define rxe_drop_index_locked(obj) __rxe_drop_index_locked(&(obj)->elem)
-
+/* drop an index and remove object from rb tree */
 void __rxe_drop_index(struct rxe_pool_elem *elem);
 
 #define rxe_drop_index(obj) __rxe_drop_index(&(obj)->elem)
 
-/* lookup an indexed object from index holding and not holding the pool_lock.
- * takes a reference on object
- */
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index);
-
+/* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
 /* cleanup an object when all references are dropped */
-- 
2.32.0

