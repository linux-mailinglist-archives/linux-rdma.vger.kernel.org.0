Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA472DC988
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgLPXRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbgLPXRS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:17:18 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B0C061282
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:01 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j21so3679133oou.11
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6rF+OAVZuTeZFAnM/LfFZzqXN0u42TbVx7IRY4i4rrA=;
        b=NTrks4FTwqMdmOV8zD/5qc3VFPb0ibCsoe5Sxf/LMf6BpXShoeOQGXZ97WnEezkb6C
         WDF01QWIsmmLlcjsNlmz8L8FDaVOMFP6sm8rlSGqiZwlINFv0nBbDWH50ik03kBCByzn
         xItKF5MNkNKkHIQGkJAH6qgeSl11tfiMJ8yPu1L/KY4yv2w+cP3PgVWwcn7bveCZi1v2
         SnzOkxXbbNRX87ZyVB5TmHeOz8ukQlV5XQR5/wnZIJI259Ix80y7/WRqReIVkzY8huR/
         BaqG298FfVBgrc8yjwHrhxy/t6TkDo8BWXLKiH93MN8x40s/KwK5q3pH9K+d4kaUffnW
         Wo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rF+OAVZuTeZFAnM/LfFZzqXN0u42TbVx7IRY4i4rrA=;
        b=EP5jpyPXCjogACMQKmKCTysJ8OF3m3hEk8K0LUoCGgD4C136PCZ3GQHxbkSCjAGRoG
         JYK/ILTqjrdSYzQaiRpRoicmqP0K56QFYtO+H1xJDubrdu43Y+lNPK1GvIEwbdy+M15Y
         yTQs108Z+KR5YYPs7eCXU/9GLAFdmwkAWW2lYiZuHzqOTL9W/TN4iVFgJFo8bpD+989G
         ivfB/wDbZdQ80TP1hsQXwpq2zDWDeziYBLpH+/rIXLvtOty9iikHjE5hP0T6ZMrNK3ZG
         sN0JlnketeTBmik2jutP3JVwDA3OyY2SJsC27Eyf/EJ6ClENdzx8lr34m1HECdc973LE
         DNZw==
X-Gm-Message-State: AOAM533gpQnuEmZiBsTq0DqXugk6LccIIIZ++iMSr7s1bLADXfnQ1aMf
        PZgLXrZ4/KyNxD5E7JI1psA=
X-Google-Smtp-Source: ABdhPJyRUuYwRT4zr+x2ieN4Xph8Lzz5G7UUAyKzydVXsiAUYFbPTS29IcS/FeS96lQ5vZMYmpIkjA==
X-Received: by 2002:a4a:d41a:: with SMTP id n26mr26998127oos.65.1608160561343;
        Wed, 16 Dec 2020 15:16:01 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:16:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 6/7] RDMA/rxe: Add unlocked versions of pool APIs
Date:   Wed, 16 Dec 2020 17:15:49 -0600
Message-Id: <20201216231550.27224-7-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The existing pool APIs use the rw_lock pool_lock to protect critical
sections that change the pool state. This does not correctly implement
a typical sequence like the following

        elem = <lookup key in pool>

        if found use elem else

        elem = <alloc new elem in pool>

        <add key to elem>

Which is racy if multiple threads are attempting to perform this at the
same time. We want the second thread to use the elem created by the
first thread not create two equivalent elems.

This patch adds new APIs that are the same as existing APIs but
do not take the pool_lock. A caller can then take the lock and
perform a sequence of pool operations and then release the lock.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 82 +++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h | 41 ++++++++++++--
 2 files changed, 97 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index c8a6d0d7f01a..d26730eec720 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -266,65 +266,89 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
+void __rxe_add_key_nl(struct rxe_pool_entry *elem, void *key)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
+	insert_key(pool, elem);
+}
+
 void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	insert_key(pool, elem);
+	__rxe_add_key_nl(elem, key);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
+void __rxe_drop_key_nl(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	rb_erase(&elem->key_node, &pool->key.tree);
+}
+
 void __rxe_drop_key(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->key_node, &pool->key.tree);
+	__rxe_drop_key_nl(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
+void __rxe_add_index_nl(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	elem->index = alloc_index(pool);
+	insert_index(pool, elem);
+}
+
 void __rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	elem->index = alloc_index(pool);
-	insert_index(pool, elem);
+	__rxe_add_index_nl(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
+void __rxe_drop_index_nl(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
+}
+
 void __rxe_drop_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
+	__rxe_drop_index_nl(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void *rxe_alloc(struct rxe_pool *pool)
+void *rxe_alloc_nl(struct rxe_pool *pool)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
-	unsigned long flags;
 
 	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
 
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
+	if (pool->state != RXE_POOL_STATE_VALID)
 		return NULL;
-	}
+
 	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	if (!ib_device_try_get(&pool->rxe->ib_dev))
 		goto out_put_pool;
@@ -352,11 +376,21 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+void *rxe_alloc(struct rxe_pool *pool)
 {
+	u8 *obj;
 	unsigned long flags;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_alloc_nl(pool);
+	read_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return obj;
+}
+
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+{
+	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
 	if (pool->state != RXE_POOL_STATE_VALID) {
@@ -444,16 +478,13 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
+void *rxe_pool_get_key_nl(struct rxe_pool *pool, void *key)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj = NULL;
 	int cmp;
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
 
 	if (pool->state != RXE_POOL_STATE_VALID)
 		goto out;
@@ -482,6 +513,17 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 	}
 
 out:
+	return obj;
+}
+
+void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
+{
+	u8 *obj = NULL;
+	unsigned long flags;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_pool_get_key_nl(pool, key);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 5db0bdde185e..373e08554c1c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -109,41 +109,70 @@ void rxe_pool_cleanup(struct rxe_pool *pool);
 /* allocate an object from pool */
 void *rxe_alloc(struct rxe_pool *pool);
 
+/* allocate an object from pool - no lock */
+void *rxe_alloc_nl(struct rxe_pool *pool);
+
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
 /* assign an index to an indexed object and insert object into
- *  pool's rb tree
+ *  pool's rb tree with and without holding the pool_lock
  */
 void __rxe_add_index(struct rxe_pool_entry *elem);
 
 #define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
-/* drop an index and remove object from rb tree */
+void __rxe_add_index_nl(struct rxe_pool_entry *elem);
+
+#define rxe_add_index_nl(obj) __rxe_add_index_nl(&(obj)->pelem)
+
+/* drop an index and remove object from rb tree
+ * with and without holding the pool_lock
+ */
 void __rxe_drop_index(struct rxe_pool_entry *elem);
 
 #define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
 
+void __rxe_drop_index_nl(struct rxe_pool_entry *elem);
+
+#define rxe_drop_index_nl(obj) __rxe_drop_index_nl(&(obj)->pelem)
+
 /* assign a key to a keyed object and insert object into
- *  pool's rb tree
+ * pool's rb tree with and without holding pool_lock
  */
 void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
-/* remove elem from rb tree */
+void __rxe_add_key_nl(struct rxe_pool_entry *elem, void *key);
+
+#define rxe_add_key_nl(obj, key) __rxe_add_key_nl(&(obj)->pelem, key)
+
+/* remove elem from rb tree with and without holding pool_lock */
 void __rxe_drop_key(struct rxe_pool_entry *elem);
 
 #define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
 
-/* lookup an indexed object from index. takes a reference on object */
+void __rxe_drop_key_nl(struct rxe_pool_entry *elem);
+
+#define rxe_drop_key_nl(obj) __rxe_drop_key_nl(&(obj)->pelem)
+
+/* lookup an indexed object from index with and without holding pool_lock.
+ * takes a reference on object
+ */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key. takes a reference on the object */
+void *rxe_pool_get_index_nl(struct rxe_pool *pool, u32 index);
+
+/* lookup keyed object from key with and without holding pool_lock.
+ * takes a reference on the objecti
+ */
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
+void *rxe_pool_get_key_nl(struct rxe_pool *pool, void *key);
+
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
 
-- 
2.27.0

