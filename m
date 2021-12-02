Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6162B466D98
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356316AbhLBXZB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbhLBXYz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:55 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4226C06174A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:32 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so444729oog.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyM4ByteBLMw8dum+xPU7aN5hvdYFkkn1V3i64FvsUw=;
        b=BfvEe8edHABSNePSADJaq+keNAK6Jyqwb/e7KS1JilUd5VrqN79kyjL13cmBr3tRMq
         fr9e/hkNS8SZZEv39o7ySK84+a5CbxrZrjYqAekl2xu33jlbX9JntLTePOPgdynvWJvb
         S+ibPTWMGVMHT3HBhmsy9GWbsfbn1Kb6YXoA+tU0ppcAOMLMz1M/9CNiP+LBznSNNGbD
         37xo2L8BlbwVNo7XuS+biFsJlrAoeGLjgqI+UvSr3xuK3nsi83jzsG508FTFWZvSBI6M
         NVBkp3lan6WFpIhxQvmpOGxqytonso73gQPzHLkhc5Wu5Xgn7T6xzIeCzM1Ba7zjLr/q
         SrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyM4ByteBLMw8dum+xPU7aN5hvdYFkkn1V3i64FvsUw=;
        b=Ga4esc1Bs5U+e6KVkLMapGkFQKj3Jx2J0Butovc+ch/npIhJ5BE2bWdGYsfWjo/GdR
         8ZHu/3blCn3pTsG5rvO7VtlEJTnCgqx0sA93FGnv14Jr8jybfJuiD+RH2rmLE3Kc+SPG
         mWXS0032QwpuTNMUJKATt02YwLhpVnmt7qn634K+rH5W8Hpc8m26ZZiOx+fHd1FdjDUZ
         N17dYN21f/DLw73BkH5+q4bfjaWWoZCJkaQGl/RvMS3b5+fQPVlsqBCJWIsfo2hIfpAT
         736BFeT6EkSch5EG0G5Wh2Z/L8228v2znel3Nbu37ZRghT9Hnh2FGMpBXLLr5o+CY1q6
         Vulw==
X-Gm-Message-State: AOAM530Kd7cRhbUZ4gAa5yU7rGsthBRsG7f0z8NkXXYXBQsvZyBenRgn
        aZANU70Y4ZmDLPAiH+f+1D4=
X-Google-Smtp-Source: ABdhPJxqbhv0pUEOR0TxueP86d5MwMk3yyqDldezOKtQkhU2LxHlpKsPB+Wv5f+pkULPlHnf0d6W4A==
X-Received: by 2002:a4a:8515:: with SMTP id k21mr10239398ooh.71.1638487292215;
        Thu, 02 Dec 2021 15:21:32 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:31 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 3/8] RDMA/rxe: Cleanup pool APIs for keyed objects
Date:   Thu,  2 Dec 2021 17:20:30 -0600
Message-Id: <20211202232035.62299-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202232035.62299-1-rpearsonhpe@gmail.com>
References: <20211202232035.62299-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Simplify the rxe pool APIs for keyed objects. Eliminate xxx_locked()
APIs. Merge rxe_drop_key into rxe_drop_ref. Replace separate rxe_get_key,
and add_key by one call rxe_add_key which looks up and if necessary
creates a new object.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   5 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  46 ++---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 249 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  50 +-----
 4 files changed, 139 insertions(+), 211 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b1e174afb1d4..6558602be751 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,17 +40,14 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
+int rxe_init_grp(struct rxe_pool_elem *elem);
 int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 		      struct rxe_mc_grp **grp_p);
-
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mc_grp *grp);
-
 int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    union ib_gid *mgid);
-
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
-
 void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mmap.c */
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 1692526c5b57..e110c4d3fbf4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -7,59 +7,38 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* caller should hold mc_grp_pool->pool_lock */
-static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+int rxe_init_grp(struct rxe_pool_elem *elem)
 {
+	struct rxe_dev *rxe = elem->pool->rxe;
+	struct rxe_mc_grp *grp = elem->obj;
 	int err;
-	struct rxe_mc_grp *grp;
-
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
-	if (!grp)
-		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
 
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
+	err = rxe_mcast_add(rxe, &grp->mgid);
+	if (err)
 		rxe_drop_ref(grp);
-		return ERR_PTR(err);
-	}
 
-	return grp;
+	return err;
 }
 
 int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 		      struct rxe_mc_grp **grp_p)
 {
-	int err;
-	struct rxe_mc_grp *grp;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
+	struct rxe_mc_grp *grp;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return -EINVAL;
 
-	rxe_pool_lock_bh(pool);
-
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
-		goto done;
-
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
-		rxe_pool_unlock_bh(pool);
-		err = PTR_ERR(grp);
-		return err;
-	}
+	grp = rxe_pool_add_key(pool, mgid);
+	if (!grp)
+		return -EINVAL;
 
-done:
-	rxe_pool_unlock_bh(pool);
 	*grp_p = grp;
+
 	return 0;
 }
 
@@ -84,7 +63,7 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto out;
 	}
 
-	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
+	elem = rxe_alloc(&rxe->mc_elem_pool);
 	if (!elem) {
 		err = -ENOMEM;
 		goto out;
@@ -173,6 +152,5 @@ void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 	struct rxe_mc_grp *grp = container_of(elem, typeof(*grp), elem);
 	struct rxe_dev *rxe = grp->rxe;
 
-	rxe_drop_key(grp);
 	rxe_mcast_delete(rxe, &grp->mgid);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7d70a493a4b0..fea28a48b36b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -12,7 +12,8 @@ static const struct rxe_type_info {
 	const char *name;
 	size_t size;
 	size_t elem_offset;
-	void (*cleanup)(struct rxe_pool_elem *obj);
+	int (*init)(struct rxe_pool_elem *elem);
+	void (*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
@@ -82,6 +83,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
 		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
+		.init		= rxe_init_grp,
 		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY | RXE_POOL_ALLOC,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
@@ -112,6 +114,7 @@ void rxe_pool_init(
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
 	pool->flags		= info->flags;
+	pool->init		= info->init;
 	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
@@ -139,78 +142,7 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 			pool->name);
 }
 
-static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
-{
-	struct rb_node **link = &pool->key.tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct rxe_pool_elem *elem;
-	int cmp;
-
-	while (*link) {
-		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_elem, key_node);
-
-		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     (u8 *)new + pool->key.key_offset,
-			     pool->key.key_size);
-
-		if (cmp == 0) {
-			pr_warn("key already exists!\n");
-			return -EINVAL;
-		}
-
-		if (cmp > 0)
-			link = &(*link)->rb_left;
-		else
-			link = &(*link)->rb_right;
-	}
-
-	rb_link_node(&new->key_node, parent, link);
-	rb_insert_color(&new->key_node, &pool->key.tree);
-
-	return 0;
-}
-
-int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key)
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
-int __rxe_add_key(struct rxe_pool_elem *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	rxe_pool_lock_bh(pool);
-	err = __rxe_add_key_locked(elem, key);
-	rxe_pool_unlock_bh(pool);
-
-	return err;
-}
-
-void __rxe_drop_key_locked(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	rb_erase(&elem->key_node, &pool->key.tree);
-}
-
-void __rxe_drop_key(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	rxe_pool_lock_bh(pool);
-	__rxe_drop_key_locked(elem);
-	rxe_pool_unlock_bh(pool);
-}
-
-void *rxe_alloc_locked(struct rxe_pool *pool)
+static void *__rxe_alloc(struct rxe_pool *pool, gfp_t flags)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
@@ -219,7 +151,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
+	obj = kzalloc(pool->elem_size, flags);
 	if (!obj)
 		goto out_cnt;
 
@@ -229,6 +161,12 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->init) {
+		err = pool->init(elem);
+		if (err)
+			goto out_free;
+	}
+
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
 					 pool->xarray.limit,
@@ -248,38 +186,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	struct rxe_pool_elem *elem;
-	void *obj;
-	int err;
-
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
-
-	obj = kzalloc(pool->elem_size, GFP_KERNEL);
-	if (!obj)
-		goto out_cnt;
-
-	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
-
-	elem->pool = pool;
-	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
-
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
-					 pool->xarray.limit,
-					 &pool->xarray.next, GFP_KERNEL);
-		if (err)
-			goto out_free;
-	}
-
-	return obj;
-
-out_free:
-	kfree(obj);
-out_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
+	return __rxe_alloc(pool, GFP_KERNEL);
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
@@ -293,6 +200,12 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->init) {
+		err = pool->init(elem);
+		if (err)
+			goto out_cnt;
+	}
+
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
 					 pool->xarray.limit,
@@ -308,27 +221,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	return err;
 }
 
-void rxe_elem_release(struct kref *kref)
-{
-	struct rxe_pool_elem *elem =
-		container_of(kref, struct rxe_pool_elem, ref_cnt);
-	struct rxe_pool *pool = elem->pool;
-	void *obj;
-
-	if (pool->flags & RXE_POOL_INDEX)
-		__xa_erase(&pool->xarray.xa, elem->index);
-
-	if (pool->cleanup)
-		pool->cleanup(elem);
-
-	if (pool->flags & RXE_POOL_ALLOC) {
-		obj = elem->obj;
-		kfree(obj);
-	}
-
-	atomic_dec(&pool->num_elem);
-}
-
 /**
  * rxe_pool_get_index - lookup object from index
  * @pool: the object pool
@@ -353,7 +245,8 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
+/* lookup key in pool. Caller must hold pool lock */
+static void *__rxe_get_key(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
@@ -386,13 +279,111 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 	return obj;
 }
 
+/* add key to pool. Caller must hold pool lock */
+static int __rxe_add_key(struct rxe_pool_elem *new, void *key)
+{
+	struct rxe_pool *pool = new->pool;
+	struct rb_node **link = &pool->key.tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct rxe_pool_elem *elem;
+	int cmp;
+
+	while (*link) {
+		parent = *link;
+		elem = rb_entry(parent, struct rxe_pool_elem, key_node);
+
+		cmp = memcmp(key, (u8 *)elem + pool->key.key_offset,
+			     pool->key.key_size);
+		if (cmp == 0) {
+			pr_warn("key already exists!\n");
+			return -EINVAL;
+		}
+
+		if (cmp > 0)
+			link = &(*link)->rb_left;
+		else
+			link = &(*link)->rb_right;
+	}
+
+	rb_link_node(&new->key_node, parent, link);
+	rb_insert_color(&new->key_node, &pool->key.tree);
+
+	memcpy((u8 *)new + pool->key.key_offset, key, pool->key.key_size);
+
+	return 0;
+}
+
+/**
+ * rxe_pool_get_key() - lookup key in pool and return object
+ * @pool: the object pool
+ * @key: the key
+ *
+ * Returns: the address of the object if present else NULL
+ */
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
 	void *obj;
 
 	rxe_pool_lock_bh(pool);
-	obj = rxe_pool_get_key_locked(pool, key);
+	obj = __rxe_get_key(pool, key);
+	rxe_pool_unlock_bh(pool);
+
+	return obj;
+}
+
+/**
+ * rxe_pool_add_key() - lookup or add object with key in pool
+ * @pool: the object pool
+ * @key: the key
+ *
+ * Returns: If object matching key is present in pool return
+ *	    its address and take a reference else allocate a
+ *	    new object to pool with key and return its address
+ *	    with one reference.
+ */
+void *rxe_pool_add_key(struct rxe_pool *pool, void *key)
+{
+	void *obj;
+
+	rxe_pool_lock_bh(pool);
+	obj = __rxe_get_key(pool, key);
+	if (obj)
+		goto done;
+
+	obj = __rxe_alloc(pool, GFP_ATOMIC);
+	if (!obj)
+		goto done;
+
+	__rxe_add_key(obj, key);
+done:
 	rxe_pool_unlock_bh(pool);
 
 	return obj;
 }
+
+/**
+ * rxe_elem_release() - cleanup pool element when last reference dropped
+ * @kref: address of the kref contained in pool element
+ *
+ * Caller should hold pool lock
+ */
+void rxe_elem_release(struct kref *kref)
+{
+	struct rxe_pool_elem *elem =
+		container_of(kref, struct rxe_pool_elem, ref_cnt);
+	struct rxe_pool *pool = elem->pool;
+
+	if (pool->flags & RXE_POOL_INDEX)
+		__xa_erase(&pool->xarray.xa, elem->index);
+
+	if (pool->flags & RXE_POOL_KEY)
+		rb_erase(&elem->key_node, &pool->key.tree);
+
+	if (pool->cleanup)
+		pool->cleanup(elem);
+
+	if (pool->flags & RXE_POOL_ALLOC)
+		kfree(elem->obj);
+
+	atomic_dec(&pool->num_elem);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2731ede2310c..01f23f57d666 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -43,7 +43,8 @@ struct rxe_pool_elem {
 struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
-	void			(*cleanup)(struct rxe_pool_elem *obj);
+	int			(*init)(struct rxe_pool_elem *elem);
+	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
@@ -71,67 +72,29 @@ struct rxe_pool {
 #define rxe_pool_unlock_bh(pool) xa_unlock_bh(&pool->xarray.xa)
 
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		  enum rxe_elem_type type, u32 max_elem);
+		   enum rxe_elem_type type, u32 max_elem);
 
-/* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool holding and not holding the pool lock */
-void *rxe_alloc_locked(struct rxe_pool *pool);
-
 void *rxe_alloc(struct rxe_pool *pool);
 
-/* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
-
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
-/* assign a key to a keyed object and insert object into
- * pool's rb tree holding and not holding pool_lock
- */
-int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key);
-
-#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->elem, key)
-
-int __rxe_add_key(struct rxe_pool_elem *elem, void *key);
-
-#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->elem, key)
-
-/* remove elem from rb tree holding and not holding the pool_lock */
-void __rxe_drop_key_locked(struct rxe_pool_elem *elem);
-
-#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->elem)
-
-void __rxe_drop_key(struct rxe_pool_elem *elem);
-
-#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->elem)
-
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key holding and not holding the pool_lock.
- * takes a reference on the objecti
- */
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
-
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
+void *rxe_pool_add_key(struct rxe_pool *pool, void *key);
 
-/**
- * __rxe_add_ref() - adds a reference to a pool element
- * @elem: pool element
- *
- * Returns: true if the kref_get succeeds else false
- */
 static inline bool __rxe_add_ref(struct rxe_pool_elem *elem)
 {
 	return kref_get_unless_zero(&elem->ref_cnt);
 }
-
 #define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
-/* drop a reference to an object */
+void rxe_elem_release(struct kref *kref);
+
 static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
 {
 	bool ret;
@@ -142,7 +105,6 @@ static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
 
 	return ret;
 }
-
 #define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 #endif /* RXE_POOL_H */
-- 
2.32.0

