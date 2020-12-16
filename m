Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74532DC984
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgLPXQj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLPXQj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:16:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DFC0617A6
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id w124so26730384oia.6
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpdEfZgI1U6K2h3/ZYa6eV5wU64O80JlfodScrcgxNI=;
        b=j743CrFaclY8ZiJVV7eVkWrhox1dHgGUjCvYYl1xfLQWoKumwFvcHfs4Yt86ckgrRI
         P4Xf+y/kjR00BoYGInq0nFou+uLeU16JwiiuHy8QYS3yGOnh6jjnLQ/4lYuMGwDweds2
         VifrS8fBivDwX/Zcn2cV6Y1ZNxxn2V0JLe9BYMRl7cpouyK0rsCKOn3+xRrJzaXoAYCa
         l9It/iarK486v/RO1d4FuW1cfHlftrRjjWldANoegi1bY7BZRIdjFyqGbD22qBA81gsX
         QlZzcN1U0RcfEKqQatGEyPcreYet4Y19/Bn7JAkEFEwiqCMr63C66dOExQ1nHbmCw6yG
         Ef7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpdEfZgI1U6K2h3/ZYa6eV5wU64O80JlfodScrcgxNI=;
        b=VWQeT4ntxCYsyTlDQAWQ5lVLJSMT7P+Z1SA829uAmvG1XmxuGBYtsaSOUYuf1bHC6B
         7JqzeN0Oz+RdX/C6mMDICf4/XkavK9Yp0UeYYkZB/nflC75qhsKaRQP2+Er1DD+pWeMK
         zSqT6ruH/zXY7Hg7baMWhDjGuo2f8PvSie7vkSq4Hx46MMXvS2WFnuL6yKS1OVnxsXtS
         e3mS1r8g0yNLe2i4aZeSMAVH4VULBLA0fdcIEO/VppW1c72bKPtZ7p/SwAMcxgK9kOXJ
         jn23XuQGU+Upn+oK+X+/3S0XK4f8elKlc4/VoZkTq1JFxONyPhWkwjY9A7my/L2Whb+u
         Narg==
X-Gm-Message-State: AOAM531kKeJ2fz0qletLmDktr/CLVN1kZ0ggd+2whisFwVDtImCJuIi9
        mrCc6dL9Fg1u+rE0PjMxID8=
X-Google-Smtp-Source: ABdhPJzS/dpYtiFSBB7flCk0u5NUJIhtYBkkJSII+SgT8y7m0OOS7NzvDSwREhS6VQH0lTBkdV9tRQ==
X-Received: by 2002:aca:4d08:: with SMTP id a8mr3318238oib.128.1608160558735;
        Wed, 16 Dec 2020 15:15:58 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:15:58 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 2/7] RDMA/rxe: Let pools support both keys and indices
Date:   Wed, 16 Dec 2020 17:15:45 -0600
Message-Id: <20201216231550.27224-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow both indices and keys to exist for objects in pools.
Previously you were limited to one or the other.

This is required for later implementing rxe memory windows.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 73 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h | 32 +++++++-----
 2 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 11571ff64a8f..f1ecf5983742 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -94,18 +94,18 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 		goto out;
 	}
 
-	pool->max_index = max;
-	pool->min_index = min;
+	pool->index.max_index = max;
+	pool->index.min_index = min;
 
 	size = BITS_TO_LONGS(max - min + 1) * sizeof(long);
-	pool->table = kmalloc(size, GFP_KERNEL);
-	if (!pool->table) {
+	pool->index.table = kmalloc(size, GFP_KERNEL);
+	if (!pool->index.table) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	pool->table_size = size;
-	bitmap_zero(pool->table, max - min + 1);
+	pool->index.table_size = size;
+	bitmap_zero(pool->index.table, max - min + 1);
 
 out:
 	return err;
@@ -127,7 +127,8 @@ int rxe_pool_init(
 	pool->max_elem		= max_elem;
 	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
 	pool->flags		= rxe_type_info[type].flags;
-	pool->tree		= RB_ROOT;
+	pool->index.tree	= RB_ROOT;
+	pool->key.tree		= RB_ROOT;
 	pool->cleanup		= rxe_type_info[type].cleanup;
 
 	atomic_set(&pool->num_elem, 0);
@@ -145,8 +146,8 @@ int rxe_pool_init(
 	}
 
 	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key_offset = rxe_type_info[type].key_offset;
-		pool->key_size = rxe_type_info[type].key_size;
+		pool->key.key_offset = rxe_type_info[type].key_offset;
+		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
 	pool->state = RXE_POOL_STATE_VALID;
@@ -160,7 +161,7 @@ static void rxe_pool_release(struct kref *kref)
 	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
 
 	pool->state = RXE_POOL_STATE_INVALID;
-	kfree(pool->table);
+	kfree(pool->index.table);
 }
 
 static void rxe_pool_put(struct rxe_pool *pool)
@@ -185,27 +186,27 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 static u32 alloc_index(struct rxe_pool *pool)
 {
 	u32 index;
-	u32 range = pool->max_index - pool->min_index + 1;
+	u32 range = pool->index.max_index - pool->index.min_index + 1;
 
-	index = find_next_zero_bit(pool->table, range, pool->last);
+	index = find_next_zero_bit(pool->index.table, range, pool->index.last);
 	if (index >= range)
-		index = find_first_zero_bit(pool->table, range);
+		index = find_first_zero_bit(pool->index.table, range);
 
 	WARN_ON_ONCE(index >= range);
-	set_bit(index, pool->table);
-	pool->last = index;
-	return index + pool->min_index;
+	set_bit(index, pool->index.table);
+	pool->index.last = index;
+	return index + pool->index.min_index;
 }
 
 static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
-	struct rb_node **link = &pool->tree.rb_node;
+	struct rb_node **link = &pool->index.tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct rxe_pool_entry *elem;
 
 	while (*link) {
 		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_entry, node);
+		elem = rb_entry(parent, struct rxe_pool_entry, index_node);
 
 		if (elem->index == new->index) {
 			pr_warn("element already exists!\n");
@@ -218,25 +219,25 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			link = &(*link)->rb_right;
 	}
 
-	rb_link_node(&new->node, parent, link);
-	rb_insert_color(&new->node, &pool->tree);
+	rb_link_node(&new->index_node, parent, link);
+	rb_insert_color(&new->index_node, &pool->index.tree);
 out:
 	return;
 }
 
 static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
-	struct rb_node **link = &pool->tree.rb_node;
+	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct rxe_pool_entry *elem;
 	int cmp;
 
 	while (*link) {
 		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_entry, node);
+		elem = rb_entry(parent, struct rxe_pool_entry, key_node);
 
-		cmp = memcmp((u8 *)elem + pool->key_offset,
-			     (u8 *)new + pool->key_offset, pool->key_size);
+		cmp = memcmp((u8 *)elem + pool->key.key_offset,
+			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
@@ -249,8 +250,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			link = &(*link)->rb_right;
 	}
 
-	rb_link_node(&new->node, parent, link);
-	rb_insert_color(&new->node, &pool->tree);
+	rb_link_node(&new->key_node, parent, link);
+	rb_insert_color(&new->key_node, &pool->key.tree);
 out:
 	return;
 }
@@ -262,7 +263,7 @@ void rxe_add_key(void *arg, void *key)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	memcpy((u8 *)elem + pool->key_offset, key, pool->key_size);
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
@@ -274,7 +275,7 @@ void rxe_drop_key(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->node, &pool->tree);
+	rb_erase(&elem->key_node, &pool->key.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -297,8 +298,8 @@ void rxe_drop_index(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->min_index, pool->table);
-	rb_erase(&elem->node, &pool->tree);
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -402,10 +403,10 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		goto out;
 
-	node = pool->tree.rb_node;
+	node = pool->index.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, node);
+		elem = rb_entry(node, struct rxe_pool_entry, index_node);
 
 		if (elem->index > index)
 			node = node->rb_left;
@@ -434,13 +435,13 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		goto out;
 
-	node = pool->tree.rb_node;
+	node = pool->key.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, node);
+		elem = rb_entry(node, struct rxe_pool_entry, key_node);
 
-		cmp = memcmp((u8 *)elem + pool->key_offset,
-			     key, pool->key_size);
+		cmp = memcmp((u8 *)elem + pool->key.key_offset,
+			     key, pool->key.key_size);
 
 		if (cmp > 0)
 			node = node->rb_left;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 432745ffc8d4..3d722aae5f15 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -56,8 +56,11 @@ struct rxe_pool_entry {
 	struct kref		ref_cnt;
 	struct list_head	list;
 
-	/* only used if indexed or keyed */
-	struct rb_node		node;
+	/* only used if keyed */
+	struct rb_node		key_node;
+
+	/* only used if indexed */
+	struct rb_node		index_node;
 	u32			index;
 };
 
@@ -74,15 +77,22 @@ struct rxe_pool {
 	unsigned int		max_elem;
 	atomic_t		num_elem;
 
-	/* only used if indexed or keyed */
-	struct rb_root		tree;
-	unsigned long		*table;
-	size_t			table_size;
-	u32			max_index;
-	u32			min_index;
-	u32			last;
-	size_t			key_offset;
-	size_t			key_size;
+	/* only used if indexed */
+	struct {
+		struct rb_root		tree;
+		unsigned long		*table;
+		size_t			table_size;
+		u32			last;
+		u32			max_index;
+		u32			min_index;
+	} index;
+
+	/* only used if keyed */
+	struct {
+		struct rb_root		tree;
+		size_t			key_offset;
+		size_t			key_size;
+	} key;
 };
 
 /* initialize a pool of objects with given limit on
-- 
2.27.0

