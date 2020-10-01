Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51A42805DB
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgJARtK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbgJARtE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:04 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CBC0613D0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:03 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 4so1695596ooh.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fc531sLyxOZPdtcwW7cnTNlX+F5YJyjNvQPM6F5HE4c=;
        b=OMXKU1Bdat5cdjzVsq2kluicKtb59hVmTs0fdAEZRY2Bc11T1hBjdCPvmm7XxIH/3F
         6i4LOlsNZL6LakW5o0Pkk2yIMQyZ5PUM+gZAeRLAgi2Qe/ZKo/XQA3jq039mdEhgoBss
         3S6dvC2YstzO31zGyEN2SQRtHNSAsOxB+wOyiCjbubXIVtdP8XDS7L5XNmtkIK+ZK4Sm
         OCn0Ndgl9YhR0UmzbekKu6f1oZp7RCvI1W65uakXiSr0vb4SQ80oyQ2Eit3pZumwONam
         2IgNV6psN5hkggp7bOvKZxMnK5H6gms1lhPkYVzMg17833AWE9VdRLYXGrlKaIPTfgRh
         NDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fc531sLyxOZPdtcwW7cnTNlX+F5YJyjNvQPM6F5HE4c=;
        b=LxOELU7AorVRH2KiPoN9AP3Fi4lTabXcTpQdRtVCtKtFcbwHafcyQfE9WsrWoaoiI/
         NKOGeZyFZUuOVOu8o8C7TzgqEapp7Wpa07y7fGHizFGm1Xia823fkFTP0nRQqsTjm9ln
         lLBA1M/PaZadqp34BYRsqr/zlx4kbf5q4+HRWBGJazH3cj9O8FXNgL/Kx+LUhwprWD0p
         HCDTd6wb+DJOuLQv8cTgYpbJ7VtFpW6veWvMu8bw5cKbOuK+DcWVEJ1sRaARrdaFUGkS
         m+jHfqJD4ZcmU2clb2RiRQ7scg/m0wipGomL+1Kyt5vefbFj876T0PqzOXyU1UBsn38p
         a9Rg==
X-Gm-Message-State: AOAM531VYIiXMgLQioOVq0y10+YK3AQI0aKFB3lzKbAR/MAVLiy3oWht
        EBZeHqewvGhJtD/efGcxYQ8fo40wpRo=
X-Google-Smtp-Source: ABdhPJzQhR+JD5toawWp0cHuyNkjqcrWu1Q+xdHv23u6ad2Ll8tn53VchhtWi8yMjjf6Sng2J5Gj9w==
X-Received: by 2002:a4a:dc99:: with SMTP id g25mr6443442oou.64.1601574542121;
        Thu, 01 Oct 2020 10:49:02 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id y25sm1355953oti.26.2020.10.01.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 09/19] rdma_rxe: Add locked and unlocked pool APIs
Date:   Thu,  1 Oct 2020 12:48:37 -0500
Message-Id: <20201001174847.4268-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

v7:
  - Current object pool APIs use the pool_lock to protect
    concurrent execution from race conditions. Most APIs
    take the pool_lock, execute one operation and then free
    the lock.
    This patch adds unlocked versions of the APIs so that a
    caller can take the pool_lock, combine sequences of
    operations and then free the lock. This will be required
    to fix some race conditions which occur without this fix.
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 528 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h | 111 +++---
 2 files changed, 467 insertions(+), 172 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 5b83b6088975..9d53b4d71230 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -7,9 +7,8 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* info about object pools
- */
-struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
+/* info about object pools */
+static struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
@@ -62,8 +61,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.flags		= RXE_POOL_ATOMIC
 				| RXE_POOL_INDEX
 				| RXE_POOL_KEY,
-		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
+		.max_index	= RXE_MAX_MR_INDEX,
 		.key_offset	= offsetof(struct rxe_mr, ibmr.lkey)
 				  - offsetof(struct rxe_mr, pelem),
 		.key_size	= sizeof(u32),
@@ -76,8 +75,8 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.flags		= RXE_POOL_NO_ALLOC
 				| RXE_POOL_INDEX
 				| RXE_POOL_KEY,
-		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
+		.max_index	= RXE_MAX_MW_INDEX,
 		.key_offset	= offsetof(struct rxe_mw, ibmw.rkey)
 				  - offsetof(struct rxe_mw, pelem),
 		.key_size	= sizeof(u32),
@@ -106,21 +105,18 @@ static inline const char *pool_name(struct rxe_pool *pool)
 	return rxe_type_info[pool->type].name;
 }
 
-static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
+static int init_index_table(struct rxe_pool *pool, u32 indices)
 {
 	int err = 0;
 	size_t size;
 
-	if ((max - min + 1) < pool->max_elem) {
+	if (indices < pool->max_elem) {
 		pr_warn("not enough indices for max_elem\n");
 		err = -EINVAL;
 		goto out;
 	}
 
-	pool->index.max_index = max;
-	pool->index.min_index = min;
-
-	size = BITS_TO_LONGS(max - min + 1) * sizeof(long);
+	size = BITS_TO_LONGS(indices) * sizeof(long);
 	pool->index.table = kmalloc(size, GFP_KERNEL);
 	if (!pool->index.table) {
 		err = -ENOMEM;
@@ -128,31 +124,37 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 	}
 
 	pool->index.table_size = size;
-	bitmap_zero(pool->index.table, max - min + 1);
-
+	bitmap_zero(pool->index.table, indices);
 out:
 	return err;
 }
 
-int rxe_pool_init(
-	struct rxe_dev		*rxe,
-	struct rxe_pool		*pool,
-	enum rxe_elem_type	type,
-	unsigned int		max_elem)
+/**
+ * rxe_pool_init - Initialize an object pool
+ * @rxe: The rxe device containing pool
+ * @pool: The pool to initialize
+ * @type: The object type held in pool
+ * @max_elem: The pool size in elements
+ *
+ * Initialize a pool of objects with given limit on
+ * number of elements. gets parameters from rxe_type_info
+ */
+int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+		  enum rxe_elem_type type, unsigned int max_elem)
 {
-	int			err = 0;
-	size_t			size = rxe_type_info[type].size;
+	struct rxe_type_info *info = &rxe_type_info[type];
+	int err = 0;
 
 	memset(pool, 0, sizeof(*pool));
 
 	pool->rxe		= rxe;
 	pool->type		= type;
 	pool->max_elem		= max_elem;
-	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
-	pool->flags		= rxe_type_info[type].flags;
+	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
+	pool->flags		= info->flags;
 	pool->index.tree	= RB_ROOT;
 	pool->key.tree		= RB_ROOT;
-	pool->cleanup		= rxe_type_info[type].cleanup;
+	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
 
@@ -160,26 +162,27 @@ int rxe_pool_init(
 
 	rwlock_init(&pool->pool_lock);
 
-	if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
-		err = rxe_pool_init_index(pool,
-					  rxe_type_info[type].max_index,
-					  rxe_type_info[type].min_index);
+	if (info->flags & RXE_POOL_INDEX) {
+		pool->index.min_index = info->min_index;
+		pool->index.max_index = info->max_index;
+
+		err = init_index_table(pool, info->max_index
+					- info->min_index + 1);
 		if (err)
 			goto out;
 	}
 
-	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key.key_offset = rxe_type_info[type].key_offset;
-		pool->key.key_size = rxe_type_info[type].key_size;
+	if (info->flags & RXE_POOL_KEY) {
+		pool->key.key_offset = info->key_offset;
+		pool->key.key_size = info->key_size;
 	}
 
 	pool->state = RXE_POOL_STATE_VALID;
-
 out:
 	return err;
 }
 
-static void rxe_pool_release(struct kref *kref)
+static void pool_release(struct kref *kref)
 {
 	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
 
@@ -187,11 +190,19 @@ static void rxe_pool_release(struct kref *kref)
 	kfree(pool->index.table);
 }
 
-static void rxe_pool_put(struct rxe_pool *pool)
-{
-	kref_put(&pool->ref_cnt, rxe_pool_release);
-}
-
+#define pool_get(pool) kref_get(&(pool)->ref_cnt)
+#define pool_put(pool) kref_put(&(pool)->ref_cnt, pool_release)
+
+/**
+ * rxe_pool_cleanup - Cleanup an object pool
+ * @pool: The pool to cleanup
+ *
+ * Marks pool as invalid and drops a ref to the pool.
+ * When the ref count gets to zero pool_release will
+ * delete the table memory held by the pool.
+ * Pool entries hold references to the pool so it will
+ * hang around until they are all removed.
+ */
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	unsigned long flags;
@@ -203,9 +214,15 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 			pool_name(pool));
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
-	rxe_pool_put(pool);
+	pool_put(pool);
 }
 
+/*
+ * Allocate a new index in the pool from the index bit table.
+ * Search from the last allocated index forward.
+ * Caller should hold pool->pool_lock to be thread safe.
+ * There should be more possible indices than objects in the pool.
+ */
 static u32 alloc_index(struct rxe_pool *pool)
 {
 	u32 index;
@@ -215,12 +232,21 @@ static u32 alloc_index(struct rxe_pool *pool)
 	if (index >= range)
 		index = find_first_zero_bit(pool->index.table, range);
 
-	WARN_ON_ONCE(index >= range);
+	if (unlikely(index >= range))
+		pr_err("Unable to allocate a new index in %s pool\n",
+				pool_name(pool));
+
 	set_bit(index, pool->index.table);
 	pool->index.last = index;
+
 	return index + pool->index.min_index;
 }
 
+/*
+ * Insert index in index-red-black tree in pool.
+ * Used to lookup object by index. Returns an error
+ * if index is already inserted.
+ */
 static int insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->index.tree.rb_node;
@@ -232,8 +258,9 @@ static int insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		parent = *link;
 		elem = rb_entry(parent, struct rxe_pool_entry, index_node);
 
-		if (elem->index == new->index) {
-			pr_warn("element already exists!\n");
+		if (unlikely(elem->index == new->index)) {
+			pr_warn("index %d already exists in %s pool\n",
+				new->index, pool_name(pool));
 			ret = -EINVAL;
 			goto out;
 		}
@@ -250,11 +277,79 @@ static int insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return ret;
 }
 
+/**
+ * __add_index - Add index to pool entry
+ * @elem: pool entry to add index to
+ *
+ * Allocate a new index and insert into index-red-black tree.
+ * Caller should hold pool->pool_lock.
+ */
+void __add_index(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	elem->index = alloc_index(pool);
+	insert_index(pool, elem);
+}
+
+/**
+ * __rxe_add_index - Lock and add index to pool entry
+ * @elem: pool entry to add index to
+ *
+ * Allocate a new index and insert into index-red-black tree.
+ */
+void __rxe_add_index(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	unsigned long flags;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	__add_index(elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+}
+
+/**
+ * __drop_index - Remove index from pool entry
+ * @elem: pool entry to remove index from
+ *
+ * Remove index from bit table and delete entry from index-red-black tree.
+ * Caller should hold pool->pool_lock.
+ */
+void __drop_index(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
+}
+
+/**
+ * __rxe_drop_index - Lock and remove index from pool entry
+ * @elem: pool entry to remove index from
+ *
+ * Remove index from bit table and delete from index-red-black tree.
+ */
+void __rxe_drop_index(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	unsigned long flags;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	__drop_index(elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+}
+
+/*
+ * Insert key in key red-black tree in pool.
+ * Used to lookup object by key. Returns an error
+ * if key is already inserted.
+ */
 static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct rxe_pool_entry *elem;
+	int ret = 0;
 	int cmp;
 
 	while (*link) {
@@ -262,11 +357,14 @@ static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		elem = rb_entry(parent, struct rxe_pool_entry, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
+			     (u8 *)new + pool->key.key_offset,
+			     pool->key.key_size);
 
-		if (cmp == 0) {
-			pr_warn("key already exists!\n");
-			return -EAGAIN;
+		if (unlikely(cmp == 0)) {
+			pr_warn("key already exists in %s pool\n",
+				pool_name(pool));
+			ret = -EAGAIN;
+			goto out;
 		}
 
 		if (cmp > 0)
@@ -277,75 +375,98 @@ static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 	rb_link_node(&new->key_node, parent, link);
 	rb_insert_color(&new->key_node, &pool->key.tree);
-
-	return 0;
+out:
+	return ret;
 }
 
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
+/**
+ * __add_key - Add key to pool entry
+ * @elem: pool entry to add index to
+ * @key: the key to add
+ *
+ * Copy key into entry and insert into key-red-black tree.
+ * Caller should hold pool->pool_lock.
+ */
+int __add_key(struct rxe_pool_entry *elem, void *key)
 {
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
 	int ret;
+	struct rxe_pool *pool = elem->pool;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	ret = insert_key(pool, elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return ret;
 }
 
-void __rxe_drop_key(struct rxe_pool_entry *elem)
+/**
+ * __rxe_add_key - Lock and add key to pool entry
+ * @elem: pool entry to add index to
+ * @key: the key to add
+ *
+ * Copy key into entry and insert into key-red-black tree.
+ */
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
+	int ret;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->key_node, &pool->key.tree);
+	ret = __add_key(elem, key);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
 }
 
-int __rxe_add_index(struct rxe_pool_entry *elem)
+/**
+ * __drop_key - Remove key from pool entry
+ * @elem: pool entry to remove key from
+ *
+ * Delete entry from key-red-black tree.
+ * Caller should hold pool->pool_lock.
+ */
+void __drop_key(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-	int ret;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	elem->index = alloc_index(pool);
-	ret = insert_index(pool, elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 
-	return ret;
+	rb_erase(&elem->key_node, &pool->key.tree);
 }
 
-void __rxe_drop_index(struct rxe_pool_entry *elem)
+/**
+ * __rxe_drop_key - Lock and remove key from pool entry
+ * @elem: pool entry to remove key from
+ *
+ * Delete entry from key-red-black tree.
+ */
+void __rxe_drop_key(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
+	__drop_key(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void *rxe_alloc(struct rxe_pool *pool)
+/**
+ * __add_to_pool - Add pool entry allocated elsewhere to pool
+ * @pool: Pool to add entry to
+ * @elem: Pool entry to add
+ *
+ * Used to add objects allocated in rdma-core to the pool.
+ * Entry holds a reference to pool to protect the pool pointer
+ * Takes a reference to the ib_device so it can't be deleted
+ * before the pool is deleted.
+ * Returns an error if pool has been deleted or if there are
+ * too many objects in the pool.
+ * Caller should hold the pool->pool_lock.
+ */
+int __add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem;
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
-	u8 *obj = NULL;
-	unsigned long flags;
+	if (pool->state != RXE_POOL_STATE_VALID)
+		return -EINVAL;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
-
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return NULL;
-	}
-	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
+	pool_get(pool);
 
 	if (!ib_device_try_get(&pool->rxe->ib_dev))
 		goto out_put_pool;
@@ -353,85 +474,153 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	elem = kzalloc(rxe_type_info[pool->type].size,
-				 (pool->flags & RXE_POOL_ATOMIC) ?
-				 GFP_ATOMIC : GFP_KERNEL);
-	if (!elem)
-		goto out_cnt;
-
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
-	obj = (u8 *)elem - info->elem_offset;
-
-	return obj;
 
+	return 0;
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
-	rxe_pool_put(pool);
-	return NULL;
+	pool_put(pool);
+	return -EINVAL;
 }
 
+/**
+ * __rxe_add_to_pool - Lock and add pool entry allocated elsewhere to pool
+ * @pool: Pool to add entry to
+ * @elem: Pool entry to add
+ *
+ * Same as __add_to_pool except takes the pool_lock.
+ */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
+	int err;
 	unsigned long flags;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
+	write_lock_irqsave(&pool->pool_lock, flags);
+	err = __add_to_pool(pool, elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return err;
+}
+
+/**
+ * __alloc - Create a new pool entry
+ * @pool: Pool to create entry in
+ *
+ * Entry holds a reference to pool to protect the pool pointer
+ * Takes a reference to the ib_device so it can't be deleted
+ * before the pool is deleted.
+ * Returns an error pointer if pool has been deleted or if there are
+ * too many objects in the pool or it cannot get memory for the
+ * object.
+ * Caller should hold the pool->pool_lock.
+ */
+void *__alloc(struct rxe_pool *pool)
+{
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	void *obj;
+	struct rxe_pool_entry *elem;
+	int ret = 0;
+
 	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
-	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
 
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
+	pool_get(pool);
+
+	if (!ib_device_try_get(&pool->rxe->ib_dev)) {
+		ret = -EINVAL;
 		goto out_put_pool;
+	}
 
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem) {
+		ret = -EINVAL;
+		goto out_cnt;
+	}
+
+	obj = kzalloc(info->size, GFP_ATOMIC);
+	if (!obj) {
+		ret = -ENOMEM;
 		goto out_cnt;
+	}
+
+	elem = (struct rxe_pool_entry *)((u8 *)obj + info->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
 
-	return 0;
+	return obj;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
-	rxe_pool_put(pool);
-	return -EINVAL;
+	pool_put(pool);
+out:
+	return ERR_PTR(ret);
 }
 
-void rxe_elem_release(struct kref *kref)
+/**
+ * rxe_alloc - Lock and create a new pool entry
+ * @pool: Pool to create entry in
+ *
+ * Same as __alloc except holds the pool_lock.
+ */
+void *rxe_alloc(struct rxe_pool *pool)
 {
-	struct rxe_pool_entry *elem =
-		container_of(kref, struct rxe_pool_entry, ref_cnt);
-	struct rxe_pool *pool = elem->pool;
+	void *obj;
+	struct rxe_pool_entry *elem;
+	unsigned long flags;
+	int err;
 
-	if (pool->cleanup)
-		pool->cleanup(elem);
+	/* allocate object outside of lock in case it sleeps */
+	obj = kzalloc(rxe_type_info[pool->type].size,
+			(pool->flags & RXE_POOL_ATOMIC) ?
+			GFP_ATOMIC : GFP_KERNEL);
+	if (!obj)
+		goto out;
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC))
-		kfree(elem);
-	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
-	rxe_pool_put(pool);
+	elem = (struct rxe_pool_entry *)((u8 *)obj +
+			rxe_type_info[pool->type].elem_offset);
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	err = __add_to_pool(pool, elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+	if (err) {
+		kfree(obj);
+		obj = NULL;
+	}
+out:
+	return obj;
 }
 
-void *rxe_get_index(struct rxe_pool *pool, u32 index)
+/**
+ * __get_index - Lookup index in pool and return object
+ * @pool: pool to lookup index in
+ * @index: index to lookup
+ *
+ * Lookup an index in pool's index-red-black tree and retrieve
+ * pool entry with that index.
+ * Convert entry address to object address with elem_offset.
+ * Returns the object address if found else NULL if not or
+ * an error pointer if the pool has been destroyed.
+ * Caller should hold the pool->pool_lock.
+ */
+void *__get_index(struct rxe_pool *pool, u32 index)
 {
-	struct rb_node *node = NULL;
-	struct rxe_pool_entry *elem = NULL;
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
-	u8 *obj = NULL;
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
+	struct rb_node *node;
+	struct rxe_pool_entry *elem = NULL;
+	void *obj;
+	int ret = 0;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
+	if (pool->state != RXE_POOL_STATE_VALID) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	node = pool->index.tree.rb_node;
 
@@ -449,25 +638,59 @@ void *rxe_get_index(struct rxe_pool *pool, u32 index)
 	if (node) {
 		kref_get(&elem->ref_cnt);
 		obj = (u8 *)elem - info->elem_offset;
+	} else {
+		obj = NULL;
 	}
+
+	return obj;
 out:
+	return ERR_PTR(ret);
+}
+
+/**
+ * rxe_get_index - Lock and lookup index in pool and return object
+ * @pool: pool to lookup index in
+ * @index: index to lookup
+ *
+ * Same as __get_index except holds pool_lock.
+ */
+void *rxe_get_index(struct rxe_pool *pool, u32 index)
+{
+	void *obj;
+	unsigned long flags;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = __get_index(pool, index);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return obj;
 }
 
-void *rxe_get_key(struct rxe_pool *pool, void *key)
+/**
+ * __get_key - Lookup key in pool and return object
+ * @pool: pool to lookup key in
+ * @key: key to lookup
+ *
+ * Lookup a key in pool's key-red-black tree and retrieve
+ * pool entry with that key.
+ * Convert entry address to object address with elem_offset.
+ * Returns the object address if found else NULL if not or
+ * an error pointer if the pool has been destroyed.
+ * Caller should hold the pool->pool_lock.
+ */
+void *__get_key(struct rxe_pool *pool, void *key)
 {
-	struct rb_node *node = NULL;
-	struct rxe_pool_entry *elem = NULL;
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
-	u8 *obj = NULL;
+	struct rb_node *node;
+	struct rxe_pool_entry *elem = NULL;
 	int cmp;
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
+	void *obj;
+	int ret = 0;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
+	if (pool->state != RXE_POOL_STATE_VALID) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	node = pool->key.tree.rb_node;
 
@@ -488,9 +711,58 @@ void *rxe_get_key(struct rxe_pool *pool, void *key)
 	if (node) {
 		kref_get(&elem->ref_cnt);
 		obj = (u8 *)elem - info->elem_offset;
+	} else {
+		obj = NULL;
 	}
 
+	return obj;
 out:
+	return ERR_PTR(ret);
+}
+
+/**
+ * rxe_get_key - Lock and lookup key in pool and return object
+ * @pool: pool to lookup key in
+ * @key: key to lookup
+ *
+ * Same as __get_key except holds pool_lock.
+ */
+void *rxe_get_key(struct rxe_pool *pool, void *key)
+{
+	void *obj;
+	unsigned long flags;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = __get_key(pool, key);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return obj;
 }
+
+/**
+ * rxe_elem_release - Delete pool object when ref count goes to zero
+ * @kref: Reference counter contained in pool entry
+ *
+ * If pool has an object cleanup routine call it.
+ * If entry memory was allocated in pool free it.
+ */
+void rxe_elem_release(struct kref *kref)
+{
+	struct rxe_pool_entry *elem = container_of(kref,
+					struct rxe_pool_entry, ref_cnt);
+	struct rxe_pool *pool = elem->pool;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	void *obj;
+
+	if (pool->cleanup)
+		pool->cleanup(elem);
+
+	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+		obj = (u8 *)elem - info->elem_offset;
+		kfree(obj);
+	}
+
+	atomic_dec(&pool->num_elem);
+	ib_device_put(&pool->rxe->ib_dev);
+	pool_put(pool);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 5954fae6cf99..9a36b4d904fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -8,13 +8,12 @@
 #define RXE_POOL_H
 
 #define RXE_POOL_ALIGN		(16)
-#define RXE_POOL_CACHE_FLAGS	(0)
 
 enum rxe_pool_flags {
 	RXE_POOL_ATOMIC		= BIT(0),
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
-	RXE_POOL_NO_ALLOC	= BIT(4),
+	RXE_POOL_NO_ALLOC	= BIT(3),
 };
 
 enum rxe_elem_type {
@@ -39,35 +38,20 @@ struct rxe_type_info {
 	size_t			elem_offset;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_flags	flags;
-	u32			max_index;
 	u32			min_index;
+	u32			max_index;
 	size_t			key_offset;
 	size_t			key_size;
 };
 
-extern struct rxe_type_info rxe_type_info[];
-
 enum rxe_pool_state {
 	RXE_POOL_STATE_INVALID,
 	RXE_POOL_STATE_VALID,
 };
 
-struct rxe_pool_entry {
-	struct rxe_pool		*pool;
-	struct kref		ref_cnt;
-	struct list_head	list;
-
-	/* only used if keyed */
-	struct rb_node		key_node;
-
-	/* only used if indexed */
-	struct rb_node		index_node;
-	u32			index;
-};
-
 struct rxe_pool {
 	struct rxe_dev		*rxe;
-	rwlock_t		pool_lock; /* protects pool add/del/search */
+	rwlock_t		pool_lock;
 	size_t			elem_size;
 	struct kref		ref_cnt;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
@@ -77,8 +61,6 @@ struct rxe_pool {
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
-
-	/* only used if indexed */
 	struct {
 		struct rb_root		tree;
 		unsigned long		*table;
@@ -87,8 +69,6 @@ struct rxe_pool {
 		u32			max_index;
 		u32			min_index;
 	} index;
-
-	/* only used if keyed */
 	struct {
 		struct rb_root		tree;
 		size_t			key_offset;
@@ -96,53 +76,96 @@ struct rxe_pool {
 	} key;
 };
 
-/* initialize a pool of objects with given limit on
- * number of elements. gets parameters from rxe_type_info
- * pool elements will be allocated out of a slab cache
- */
+struct rxe_pool_entry {
+	struct rxe_pool		*pool;
+	struct kref		ref_cnt;
+	struct list_head	list;
+	struct rb_node		key_node;
+	struct rb_node		index_node;
+	u32			index;
+};
+
 int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		  enum rxe_elem_type type, u32 max_elem);
+		  enum rxe_elem_type type, unsigned int max_elem);
 
-/* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
-void *rxe_alloc(struct rxe_pool *pool);
-
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+/*
+ * In the following:
+ *     rxe_xxx() take pool->pool_lock and xxx() do not.
+ *     Sequences of xxx() calls may be protected by
+ *     taking the pool->pool_lock by caller.
+ *
+ *     __something(elem) take a pool entry argument, and
+ *     something(obj) take a pool object (e.g. cq, mr, etc.)
+ */
+void __add_index(struct rxe_pool_entry *elem);
 
-#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
+#define add_index(obj) __add_index(&(obj)->pelem)
 
-int __rxe_add_index(struct rxe_pool_entry *elem);
+void __rxe_add_index(struct rxe_pool_entry *elem);
 
 #define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
+void __drop_index(struct rxe_pool_entry *elem);
+
+#define drop_index(obj) __drop_index(&(obj)->pelem)
+
 void __rxe_drop_index(struct rxe_pool_entry *elem);
 
 #define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
 
+int __add_key(struct rxe_pool_entry *elem, void *key);
+
+#define add_key(obj, key) __add_key(&(obj)->pelem, key)
+
 int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
+void __drop_key(struct rxe_pool_entry *elem);
+
+#define drop_key(obj) __drop_key(&(obj)->pelem)
+
 void __rxe_drop_key(struct rxe_pool_entry *elem);
 
 #define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
 
-/* lookup an indexed object from index. takes a reference on object */
+int __add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+
+#define add_to_pool(pool, obj) __add_to_pool(pool, &(obj)->pelem)
+
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
+
+/*
+ * The following routines allocate new objects or
+ * lookup objects from an index or key and return
+ * the address if found. the rxe_XXX() routines take the
+ * pool->pool_lock the __xxx() do not. Sequences of
+ * unprotected pool operations may be protected by
+ * taking the pool->pool_lock by the caller
+ */
+void *__alloc(struct rxe_pool *pool);
+
+void *rxe_alloc(struct rxe_pool *pool);
+
+void *__get_index(struct rxe_pool *pool, u32 index);
+
 void *rxe_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key. takes a reference on the object */
+void *__get_key(struct rxe_pool *pool, void *key);
+
 void *rxe_get_key(struct rxe_pool *pool, void *key);
 
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
+/* ref counting for pool objects */
+#define rxe_add_ref(obj) kref_get(&(obj)->pelem.ref_cnt)
+
+#define rxe_drop_ref(obj) kref_put(&(obj)->pelem.ref_cnt, rxe_elem_release)
 
-/* take a reference on an object */
-#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
+#define rxe_read_ref(obj) kref_read(&(obj)->pelem.ref_cnt)
 
-/* drop a reference on an object */
-#define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
+void rxe_elem_release(struct kref *kref);
 
-#define rxe_read_ref(elem) kref_read(&(elem)->pelem.ref_cnt)
 #endif /* RXE_POOL_H */
-- 
2.25.1

