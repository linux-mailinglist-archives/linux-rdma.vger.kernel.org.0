Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5509E49ED97
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbiA0ViW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344422AbiA0ViU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:20 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F01C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:20 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so3860584ota.10
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7m1BGBziqwvyvCrwIk/mIsGbri46HjiDVdhAI03lww=;
        b=idhfjdqrY8NMtra/jlxwJ4hBj85yhbbx7+/JjbJePugurWwzEGO9trPIj4pn7u/AIh
         RSmc14aZt4NtVR1m5JT2FcdAUNogNfce16SLbt8+oWkhsdcNkYK1MAC8xDHeHpYyxOpl
         EA551Ei9GyQokKvZhTg/U5XsQxqiSC9ZP3URd0uJXXO2hQGK16mXI4Gfh5m9wUoT6xr+
         47JC3mNVR8/M4jBDHMG2fk19DfQRWj2w/8cawwH1Yj7rMnxg9Ex8FvFXvDLgurRRBRyj
         YvF9hm+qMyDq3NqHAfA/EGkv7f7tlg0WgzjdzALCxQVbcZINWha4dcGtd3g4H5wK0gnK
         dhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7m1BGBziqwvyvCrwIk/mIsGbri46HjiDVdhAI03lww=;
        b=yNfl/9x6LaB+ZQyoAFAy1qlb6oOWou1mFsjsIF/6m3xHVx+r0Wvpmqsqk09eb1Hx1D
         UPDo1Nv53u56DTpcq9+UDoJN0dwssXvuZqLAdJuIEDRgOhFo0VuOJjH8IyML8OCl+E6+
         WHfV6qFMxCFXW9Lj8wsNx5ERjJjJIA0+/qN6qFeChM0oMgMgiGqqvZZ31sfVt+K8smgn
         X/onAXIltwkZdS+M2EUUS13BrY42uN67k6w5TQGewmUBx2EanneTG/e47uVGPF8OKalw
         2dtvkLY/lMrcXYm8VTItjtTx2ezogyCN2SCbuhyR/gcnSs3fRB12bZXdIc86G+GwbG1u
         IxbQ==
X-Gm-Message-State: AOAM530RctS5O5euRebmHEc861PoIA66NoisDSwTexjgB24o5uQbv3N1
        cWbtHBzG701hhJTUjZkI6pELieR3RxQ=
X-Google-Smtp-Source: ABdhPJwX6Lm+zBr7PwduQzHC3tGPZUCEqwQeOI0eS03Ar1oI8EMaQ9I/cw3G1wB1oYLnmcMnH+Lw5Q==
X-Received: by 2002:a05:6830:2433:: with SMTP id k19mr3111297ots.216.1643319499555;
        Thu, 27 Jan 2022 13:38:19 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:19 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 20/26] RDMA/rxe: Delete _locked() APIs for pool objects
Date:   Thu, 27 Jan 2022 15:37:49 -0600
Message-Id: <20220127213755.31697-21-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since caller managed locks for indexed objects are no longer used
these APIs are deleted.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 63 +++-------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h | 24 ++---------
 2 files changed, 10 insertions(+), 77 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 8fc3f0026f69..b3c74988b0e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -189,71 +189,29 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
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
 	int err;
 
 	write_lock_bh(&pool->pool_lock);
-	err = __rxe_add_index_locked(elem);
+	elem->index = alloc_index(pool);
+	err = rxe_insert_index(pool, elem);
 	write_unlock_bh(&pool->pool_lock);
 
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
 
 	write_lock_bh(&pool->pool_lock);
-	__rxe_drop_index_locked(elem);
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
 	write_unlock_bh(&pool->pool_lock);
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
@@ -325,12 +283,13 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
 	void *obj;
 
+	read_lock_bh(&pool->pool_lock);
 	node = pool->index.tree.rb_node;
 
 	while (node) {
@@ -350,16 +309,6 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 	} else {
 		obj = NULL;
 	}
-
-	return obj;
-}
-
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
-{
-	void *obj;
-
-	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_index_locked(pool, index);
 	read_unlock_bh(&pool->pool_lock);
 
 	return obj;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index ca7e5c4c44cf..b7babf4789c7 100644
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

