Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D2B42FE3D
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbhJOWgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbhJOWgG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:06 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9DC061764
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so14860208ott.2
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POUkgMs77Z6vULT8VzPbqJDx+GoVIJ6/p4tfX7cfkxI=;
        b=kFn4XjPDSa1wcyKlbnxUVOy9GHHjnUNETU1sxQyKDXyb7vvTcQSjC/ItO4WPYboydU
         qrKNmwshWSmOp8LyxL+pZaARe8106fOK2jWU2kte1uAdSTU0ZhfCRG8NBqQTABJCaPZy
         KwDTuyLeWWsthS2iB/15TdbENHX+pNtWrSlEbbXdomBsYYFMaBR0eSgr9zKXLxfR2abl
         JBFaX+ecXrC56BQId1hY3t5IkuDj3sqrKBjJj88LGbC8ik5fIxcLrMSeI2O6Xz9yeZqg
         ifeaj/UC3zhilGWTWXJrRX7n1JjXniwnV56S2WsMDH6FmM0D0LVy1HqCzmP5pOYASxkD
         2D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POUkgMs77Z6vULT8VzPbqJDx+GoVIJ6/p4tfX7cfkxI=;
        b=gPxdnKL6XT33LKiGPUvIL0VMUDeU9N+hLWOU/jTVTMG5LiZc9w6bcVVggLVp94WpZn
         wuVhCHAztMqD9Lo6+Gpah4atK7AQcq7YcACWPC58a5ieiR4/tchwQEstLDWIyX/3W+qn
         jDQTcjDMyfxSRG0v81+5i72PWdd0MnFfLdJVMGd3YmwxBwPjouXvTqh8ldVLl1BAfa+2
         uEtBLwyGApuU2msHQbzwZ2x3lAcv1cISQVntMN1NzVh8ncGkU7pQ+BofK8gonMZMtYSy
         c0k4r6cXbzH9cgCoAnT5ohes9tjJfHzb/K+9DBFTKCI93TnFfQltsa1EkVuacfKtjs4r
         CC3g==
X-Gm-Message-State: AOAM5329tA1B/i+c6tq6xPtxZw0B+1zOMCLOHTYkkq+iVOjZZnL/hwlP
        uE9Py8pCqYTtEv7QHRI9y5LgKF40UoU=
X-Google-Smtp-Source: ABdhPJy2akHPb11o/odFXnkYpDAeaB3/m1Imo5dKL3TrvqrLj9nkF04jNVaaXlPP8tRo7cW/f7eaOw==
X-Received: by 2002:a9d:61c7:: with SMTP id h7mr10421525otk.21.1634337238687;
        Fri, 15 Oct 2021 15:33:58 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 06/10] RDMA/rxe: Fix potential race condition in rxe_pool
Date:   Fri, 15 Oct 2021 17:32:47 -0500
Message-Id: <20211015223250.6501-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently there is a possible race condition related to rxe indexed or
keyed objects where one thread is the last one holding a reference to
an object and drops that reference triggering a call to rxe_elem_release()
while at the same time another thread looks up the object from its index
or key by calling rxe_pool_get_index(/_key). This can happen if an
unexpected packet arrives as a result of a retry attempt and looks up
its rkey or a multicast packet arrives just as the verbs consumer drops
the mcast group.

Add locking to prevent looking up an object from its index or key
while another thread is trying to destroy the object.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 51 +++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.h | 15 ++++++--
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index b0963eca75c7..e9c5e4e887c3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -267,7 +267,7 @@ static void rxe_drop_index(struct rxe_pool_entry *elem)
 	rb_erase(&elem->index_node, &pool->index.tree);
 }
 
-void *rxe_alloc_locked(struct rxe_pool *pool)
+static void *__rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
 	void *obj;
@@ -280,11 +280,10 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
 	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
@@ -301,17 +300,32 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	return NULL;
 }
 
+void *rxe_alloc_locked(struct rxe_pool *pool)
+{
+	struct rxe_pool_entry *elem;
+	void *obj;
+
+	obj = __rxe_alloc_locked(pool);
+	if (!obj)
+		return NULL;
+
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	kref_init(&elem->ref_cnt);
+
+	return obj;
+}
+
 void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 	int err;
 
-	obj = rxe_alloc_locked(pool);
+	obj = __rxe_alloc_locked(pool);
 	if (!obj)
 		return NULL;
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	err = rxe_insert_key(pool, elem);
 	if (err) {
@@ -319,6 +333,8 @@ void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 		goto out_cnt;
 	}
 
+	kref_init(&elem->ref_cnt);
+
 	return obj;
 
 out_cnt:
@@ -352,14 +368,15 @@ void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
+	unsigned long flags;
 	int err;
 
+	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
-	kref_init(&elem->ref_cnt);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
@@ -367,10 +384,14 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 			goto out_cnt;
 	}
 
+	kref_init(&elem->ref_cnt);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return 0;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 	return -EINVAL;
 }
 
@@ -402,7 +423,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	void *obj;
+	void *obj = NULL;
 
 	node = pool->index.tree.rb_node;
 
@@ -417,12 +438,8 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 			break;
 	}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
+	if (node && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
 
 	return obj;
 }
@@ -443,7 +460,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	void *obj;
+	void *obj = NULL;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -462,12 +479,8 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 			break;
 	}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
+	if (node && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
 
 	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index e0242d488cc8..50083cb9530e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -131,9 +131,20 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 void rxe_elem_release(struct kref *kref);
 
 /* take a reference on an object */
-#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
+static inline int __rxe_add_ref(struct rxe_pool_entry *elem)
+{
+	int ret = kref_get_unless_zero(&elem->ref_cnt);
+
+	if (unlikely(!ret))
+		pr_warn("Taking a reference on a %s object that is already destroyed\n",
+			elem->pool->name);
+
+	return (ret) ? 0 : -EINVAL;
+}
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->pelem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
+#define rxe_drop_ref(obj) kref_put(&(obj)->pelem.ref_cnt, rxe_elem_release)
 
 #endif /* RXE_POOL_H */
-- 
2.30.2

