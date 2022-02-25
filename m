Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63B4C4F29
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiBYT7D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiBYT7D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:03 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C691E10BBE3
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:30 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s5so8412554oic.10
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgk1bAQOXV5ae+SYgL8wBNjRQ2/eREQ6SY3pKMsHsQE=;
        b=iErfQxu1aurFQcgNDB/xu2yfrMQFaGtmbsrzgy05jmBENm5i6VSygeHmrZw1WrxgMD
         4axThhMmJC9tWHMci3UP5jb3yMIG3qtEfcFUWvFU1gH/PpQW7Apb03J7kE6RPd5ulbVr
         K/3EXoci8USP0COlh5dsx9YW/NzrTozwGdzqDFkNMdjsvVU86dfXeQAa4wyoiCY2o4IJ
         8l6FAJUz2b2zWOIzAyiQTAgFS2bPKT36OlozEtFKUMExykGOQKxpREB6o76DIcjo+GyP
         tCU6/ucw1lXnHY2dE22lGUrwcTgzML+NvFJHdHhqqjj3iArthcD7S8eHAJrpoR5lN1DN
         BXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgk1bAQOXV5ae+SYgL8wBNjRQ2/eREQ6SY3pKMsHsQE=;
        b=IVcVJnoBtvW7rnQPimKR+pXoAZa1uTD2kdGPiZYKTMv8C+V9VgpegW05r/rxbEQ6Qw
         5Fw7LRlaG3OQXxGz91WHnybJYz78TDHkhRU4lbeAP6oUfINzSukkWaGvV9mMNGiLffx4
         VBD4sSr6UxJ6/7Ec/LF0Efw4RBbWtCgVT1YZcJWoMecXkGuQ8CZ/GgG4DAgUbodqV5r5
         wQ4gB5JD96HGpUG9V3LDuccE8acWgUZ1N/a05pC4+go8NSuA2PmV5zb++Wcd0NoaufjO
         SvT2rP7M5wZgU+Q3SYpvVsMypIm+gajZffE1IUyMmjIzh2Jk+rdt4p1kWbGDfWjPSW5v
         lsUQ==
X-Gm-Message-State: AOAM530rAXxPH2iV5e7G50BaMtqKh4GDbYR58eXExHQhSinpl8e8Rmeu
        f6p5sTAQVHrawovEwHX0Gz5GqUakdoc=
X-Google-Smtp-Source: ABdhPJxSaLBeEnJdUTEeioYnh/Kco40WVZOQk15Mtc6ydZAEkKlA5+JjYPz6Dx2fTIqVotxXqb5msQ==
X-Received: by 2002:aca:582:0:b0:2c9:ec1c:46a5 with SMTP id 124-20020aca0582000000b002c9ec1c46a5mr701405oif.92.1645819110221;
        Fri, 25 Feb 2022 11:58:30 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:29 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 02/11] RDMA/rxe: Delete _locked() APIs for pool objects
Date:   Fri, 25 Feb 2022 13:57:42 -0600
Message-Id: <20220225195750.37802-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
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
index 63681a8398b8..0a1233b2d4c5 100644
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
@@ -327,12 +285,14 @@ void rxe_elem_release(struct kref *kref)
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
@@ -352,17 +312,6 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
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

