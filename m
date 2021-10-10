Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379ED428439
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbhJKABq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhJKABo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9114BC061570
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id e63so1650472oif.8
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPkkigCephKmdCnyXY+7JbFldIGQ4pdkQBhuDUMy8j8=;
        b=SIA4Mx+8YjI3ZoKq8SYzBGQCRKWTqNp2SAEy8iOQvGHQUFbIZ88LYiyEdgbqVOfutL
         SKnKfEe+WifeJtECmjGEkkq4iK4PYhAH+K/8zH5bUUXVwDrWYKN+cMK3ivbWoHLoxzb3
         AWVivp72H2+wb8gjg7870kL2eZf9jp+8ijMDacGqSgE1QlMJuUMFZpF3v42O4XUlCG/1
         7uSBVz0ppfBTSoOAJZ4AI41x8jZWw01UT3tXVx2SMlNi6HbqZDjnJ1CLdQzrp7kpKswD
         Ix9JO5VRvCIiL6MLAzLSGcqZim+xh2MfKnlNlHQpk0oThv0rhrAyVw6eqM5KNpAItzRj
         Rxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPkkigCephKmdCnyXY+7JbFldIGQ4pdkQBhuDUMy8j8=;
        b=MBEOfAdcHOjQKxnuTWrrAb2+x4haGq/Ua6QuTRlDOsAc6Pcnu3/Mit7VmbXw4Sc+DZ
         SuR2ZMhaaOMW4dtq3bmFHCWNlEdDCPJOyUqquN7NzslDt3N3mrYU5S91gdfwngFaPbMp
         hqykE2xWGGZgijofvT2SFSK7kQTa2mKKb5lIpTZXxB25xM8DY0j66jB8W3RIRJBF8UiZ
         jzVgWi4xWOcDs8Dz7YG9ZY9Q+6cEk+C2BNl1iao+wTKjv0zMMwsF0wZBzDJlBJjRLGb1
         y3GfHQ4IbZs77NNy6pI88jZ7WBqCnBthzWs/r4odwip0oU9KmT1noourGS2OS10dEnTE
         Wa7w==
X-Gm-Message-State: AOAM532JRdpf+HH2uxUeZAL1JN2JccHQiDJhf3RZNTLXRyk4idCglUXo
        C0OJGSDOKb2TZYvWDYcyEJWoOgxbHa0=
X-Google-Smtp-Source: ABdhPJwS9wu8N7DQQ2ZgFf/KhF+pRgWeympFwQAofIkGCOybminFANxSsyy8OTtjk6/7mo4vKGpwBg==
X-Received: by 2002:aca:6246:: with SMTP id w67mr13675049oib.44.1633910385015;
        Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/6] RDMA/rxe: Combine rxe_add_key with rxe_alloc
Date:   Sun, 10 Oct 2021 18:59:30 -0500
Message-Id: <20211010235931.24042-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently adding and dropping a key from a rxe object requires separate
API calls from allocating and freeing the object but these are always
performed together. This patch combines these into single APIs.
This requires adding new rxe_allocate_with_key(_locked) APIs.

By combining allocating an object and adding key metadata inside a
single locked sequence and dropping the key metadata and releasing the
object the possibility of a race condition where the object state and
key metadata state are inconsistent is removed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c |  5 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 81 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 24 ++------
 3 files changed, 45 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 1c1d1b53312d..337dc2c68051 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -15,18 +15,16 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	int err;
 	struct rxe_mc_grp *grp;
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
+	grp = rxe_alloc_with_key_locked(&rxe->mc_grp_pool, mgid);
 	if (!grp)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
 		rxe_drop_ref(grp);
 		return ERR_PTR(err);
 	}
@@ -174,6 +172,5 @@ void rxe_mc_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mc_grp *grp = container_of(arg, typeof(*grp), pelem);
 	struct rxe_dev *rxe = grp->rxe;
 
-	rxe_drop_key(grp);
 	rxe_mcast_delete(rxe, &grp->mgid);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index d55a40291692..70f407108b92 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -244,47 +244,6 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return 0;
 }
 
-int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	err = rxe_insert_key(pool, elem);
-
-	return err;
-}
-
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-	int err;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	err = __rxe_add_key_locked(elem, key);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-
-	return err;
-}
-
-void __rxe_drop_key_locked(struct rxe_pool_entry *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	rb_erase(&elem->key_node, &pool->key.tree);
-}
-
-void __rxe_drop_key(struct rxe_pool_entry *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_key_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-}
-
 static int rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -341,6 +300,31 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	return NULL;
 }
 
+void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
+{
+	struct rxe_pool_entry *elem;
+	u8 *obj;
+	int err;
+
+	obj = rxe_alloc_locked(pool);
+	if (!obj)
+		return NULL;
+
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
+	err = rxe_insert_key(pool, elem);
+	if (err) {
+		kfree(obj);
+		goto out_cnt;
+	}
+
+	return obj;
+
+out_cnt:
+	atomic_dec(&pool->num_elem);
+	return NULL;
+}
+
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	unsigned long flags;
@@ -353,6 +337,18 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return obj;
 }
 
+void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
+{
+	unsigned long flags;
+	void *obj;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_alloc_with_key_locked(pool, key);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return obj;
+}
+
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
 	int err;
@@ -390,6 +386,9 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->flags & RXE_POOL_INDEX)
 		rxe_drop_index(elem);
 
+	if (pool->flags & RXE_POOL_KEY)
+		rb_erase(&elem->key_node, &pool->key.tree);
+
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
 		obj = elem->obj;
 		kfree(obj);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 41eaf47a64a3..ad287c4ddc1a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -105,31 +105,15 @@ void *rxe_alloc_locked(struct rxe_pool *pool);
 
 void *rxe_alloc(struct rxe_pool *pool);
 
+void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key);
+
+void *rxe_alloc_with_key(struct rxe_pool *pool, void *key);
+
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
-/* assign a key to a keyed object and insert object into
- * pool's rb tree holding and not holding pool_lock
- */
-int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key);
-
-#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->pelem, key)
-
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
-
-#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
-
-/* remove elem from rb tree holding and not holding the pool_lock */
-void __rxe_drop_key_locked(struct rxe_pool_entry *elem);
-
-#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->pelem)
-
-void __rxe_drop_key(struct rxe_pool_entry *elem);
-
-#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
-
 /* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
  */
-- 
2.30.2

