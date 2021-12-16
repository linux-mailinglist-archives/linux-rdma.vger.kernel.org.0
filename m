Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB664780A9
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhLPXeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 18:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhLPXeB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 18:34:01 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E64C061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:01 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso814473otr.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugpQMgFCHMdTH1QwRKVau8nh91zaNwjtsyBTN7Vtutw=;
        b=EMuzslA7+VuA3bCba+tVZOdht7QmV41tHIzITs8BHIw48VUYDEEw7hVXDgP3MRKyaQ
         SkSMZ10CReHTURbyWcu+ZsgfMiTuTAkbAF7Nk7uUS9KKRXQNbyu4/sOKHK86n7N/z+j/
         Z6MkJe/U5R8uQ7ozUfw6AyRCj5cQqnaglWvrDR8tbxSHAHGa3ED+3c8wJwow4YN99ARB
         yQtzlHsqoJBykfQjw4oPNC1LyEw1ZfdLf6zYoGnrB1xuiZFhNdueqHRijmXUddz4yVLJ
         Qw4+hP5no4GejN8wbAet1dp5sKgHrB3CoNrRD9bFEl08/TXKlo3Z0u7Kmuk7pKLVvyYW
         ncZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugpQMgFCHMdTH1QwRKVau8nh91zaNwjtsyBTN7Vtutw=;
        b=MK/aTknhMMLMByIgd41P+koLEpdNlhiIudwjKXvAgWksI30G1jxta9UI/am1L/P73K
         mir7aIXb7Qh8ZT3jO4C2gvak1vypHJ87FDo3v9aiwy+gB1aZRv5bSk1+EuMnPZ8tYOMO
         J4gS1GhtXhoKxbtinhGpeUodIKUw1Al/WCC4DX/qWeH2df07ZMwssCbplkOut77+zita
         Rt4nd8FMkXoNTZAM0HPFhAk+cYCOtFzjRg1kVGyZTIIjM3YSh2OJJEvMThlRTGuny6oI
         5mlIpONZf4oCMCbDOfXREnfInUVq4/Of7WU43TUZaQEWhgjve8tTJpWHQXKrTdPaKJVn
         U3KQ==
X-Gm-Message-State: AOAM530zb+ksLERLngE0lxvlXViGp/2v4T9ZzYz/VpnloX1OZQnMqLiO
        uJDXg+Om31kfON9s22ao8Tc=
X-Google-Smtp-Source: ABdhPJw9tJclnZDDMtLQ9SVC5LDsRtoQUSpXPDABK3znBkBEqx12yVFF+4GMF1/GnBwTQi+eBKIS1Q==
X-Received: by 2002:a9d:1ca9:: with SMTP id l41mr324901ota.341.1639697640839;
        Thu, 16 Dec 2021 15:34:00 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ec41-d089-dfdb-6fb5.res6.spectrum.com. [2603:8081:140c:1a00:ec41:d089:dfdb:6fb5])
        by smtp.googlemail.com with ESMTPSA id w19sm1253888oih.44.2021.12.16.15.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:34:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 3/8] RDMA/rxe: Cleanup pool APIs for keyed objects
Date:   Thu, 16 Dec 2021 17:31:57 -0600
Message-Id: <20211216233201.14893-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216233201.14893-1-rpearsonhpe@gmail.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Simplify the rxe pool APIs for keyed objects. Eliminate xxx_locked()
APIs. Merge rxe_drop_key into rxe_drop_ref. Replace separate rxe_get_key,
and add_key by one call rxe_add_key which looks up and if necessary
allocates a new object. This routine is written to avoid using GFP_ATOMIC
by maintaining a free list of objects allocated without holding a spinlock.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v8
  Corrected an additional race condition where another tread uses the
  remaining objects on the free list after this thread creates them before
  they are used.

 drivers/infiniband/sw/rxe/rxe_loc.h   |   5 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  46 ++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 297 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  59 +----
 4 files changed, 187 insertions(+), 220 deletions(-)

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
index d1981309aa23..a5ff2fd692c9 100644
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
@@ -112,7 +114,9 @@ void rxe_pool_init(
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
 	pool->flags		= info->flags;
+	pool->init		= info->init;
 	pool->cleanup		= info->cleanup;
+	INIT_LIST_HEAD(&pool->free_list);
 
 	atomic_set(&pool->num_elem, 0);
 
@@ -132,83 +136,23 @@ void rxe_pool_init(
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
-	if (atomic_read(&pool->num_elem) > 0)
-		pr_warn("%s pool destroyed with unfree'd elem\n",
-			pool->name);
-}
-
-static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
-{
-	struct rb_node **link = &pool->key.tree.rb_node;
-	struct rb_node *parent = NULL;
 	struct rxe_pool_elem *elem;
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
 
 	rxe_pool_lock_bh(pool);
-	err = __rxe_add_key_locked(elem, key);
+	while (!list_empty(&pool->free_list)) {
+		elem = list_first_entry(&pool->free_list,
+				struct rxe_pool_elem, list);
+		list_del(&elem->list);
+		__rxe_drop_ref(elem);
+	}
 	rxe_pool_unlock_bh(pool);
 
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
+	if (atomic_read(&pool->num_elem) > 0)
+		pr_warn("%s pool destroyed with unfree'd elem\n",
+			pool->name);
 }
 
-void *rxe_alloc_locked(struct rxe_pool *pool)
+void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
@@ -217,7 +161,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
+	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
 		goto out_cnt;
 
@@ -227,42 +171,12 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
-					 pool->xarray.limit,
-					 &pool->xarray.next, GFP_ATOMIC);
+	if (pool->init) {
+		err = pool->init(elem);
 		if (err)
 			goto out_free;
 	}
 
-	return obj;
-
-out_free:
-	kfree(obj);
-out_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
-}
-
-void *rxe_alloc(struct rxe_pool *pool)
-{
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
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
 					 pool->xarray.limit,
@@ -291,6 +205,12 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
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
@@ -306,27 +226,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
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
-		xa_erase(&pool->xarray.xa, elem->index);
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
@@ -339,18 +238,17 @@ void rxe_elem_release(struct kref *kref)
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
-	void *obj;
+	void *obj = NULL;
 
 	elem = xa_load(&pool->xarray.xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	else
-		obj = NULL;
 
 	return obj;
 }
 
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
+/* lookup key in pool. Caller must hold pool lock */
+static void *__rxe_get_key(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
@@ -362,7 +260,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 	while (node) {
 		elem = rb_entry(node, struct rxe_pool_elem, key_node);
 
-		cmp = memcmp((u8 *)elem + pool->key.key_offset,
+		cmp = memcmp((u8 *)elem->obj + pool->key.key_offset,
 			     key, pool->key.key_size);
 
 		if (cmp > 0)
@@ -383,13 +281,150 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
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
+		cmp = memcmp(key, (u8 *)elem->obj + pool->key.key_offset,
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
+	memcpy((u8 *)new->obj + pool->key.key_offset, key,
+			pool->key.key_size);
+
+	return 0;
+}
+
+/**
+ * rxe_pool_get_key() - lookup key in pool and return object
+ * @pool: the object pool
+ * @key: the key
+ *
+ * Returns: if the object matching key is present in pool
+ *	    return its address and take a reference else NULL
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
+ * Context: should be called in process context without holding
+ *	    any spin locks. Currently this is only used for the
+ *	    de/attach multicast group verbs.
+ *
+ * Returns: If object matching key is present in pool return
+ *	    its address and take a reference else allocate a
+ *	    new object from free list, add key and return its address
+ *	    with one reference.
+ */
+void *rxe_pool_add_key(struct rxe_pool *pool, void *key)
+{
+	struct rxe_pool_elem *elem;
+	void *obj;
+	int again = 1;
+
+again:
+	/* unless we are out of memory will add one or more
+	 * elements to the free list if it is currently empty
+	 */
+	if (list_empty(&pool->free_list)) {
+		obj = rxe_alloc(pool);
+		if (obj) {
+			elem = (struct rxe_pool_elem *)((u8 *)obj +
+					pool->elem_offset);
+			rxe_pool_lock_bh(pool);
+			list_add(&pool->free_list, &elem->list);
+			rxe_pool_unlock_bh(pool);
+		} else {
+			/* we are out of memory don't retry */
+			again = 0;
+		}
+	}
+
+	rxe_pool_lock_bh(pool);
+	obj = __rxe_get_key(pool, key);
+	if (obj)
+		goto done;
+
+	if (list_empty(&pool->free_list)) {
+		if (again) {
+			/* someone may have grabbed the last
+			 * member of the free list while we didn't
+			 * hold the lock so worth trying again
+			 * This should be a rare event
+			 */
+			rxe_pool_unlock_bh(pool);
+			goto again;
+		}
+		pr_warn("Unable to allocate a new %s object\n",
+				pool->name);
+		goto done;
+	}
+
+	elem = list_first_entry(&pool->free_list, struct rxe_pool_elem, list);
+	list_del(&elem->list);
+	__rxe_add_key(elem, key);
+	obj = elem->obj;
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
+		xa_erase(&pool->xarray.xa, elem->index);
+	else if (pool->flags & RXE_POOL_KEY)
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
index 514be1582bce..894ffef4d6bd 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -43,9 +43,11 @@ struct rxe_pool_elem {
 struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
-	void			(*cleanup)(struct rxe_pool_elem *obj);
+	int			(*init)(struct rxe_pool_elem *elem);
+	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
+	struct list_head	free_list;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
@@ -71,78 +73,33 @@ struct rxe_pool {
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
- */
 static inline void __rxe_add_ref(struct rxe_pool_elem *elem)
 {
-	return kref_get(&elem->ref_cnt);
+	kref_get(&elem->ref_cnt);
 }
-
 #define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
-/**
- * __rxe_drop_ref() - drops a reference to a pool element
- * @elem: pool element
- *
- * Drop reference to pool element and call rxe_elem_release() if
- * the reference count reaches zero.
- *
- * Returns: 1 if rxe_elem_release is called else 0.
- */
+void rxe_elem_release(struct kref *kref);
+
 static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
 {
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
-
 #define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 #endif /* RXE_POOL_H */
-- 
2.32.0

