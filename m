Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39824C7EE
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgHTWre (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6DC061342
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id o21so3298917oie.12
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbzzSd6+FtCs2j1YkR2VUZSVZcYZF2OksTewulq0h2Q=;
        b=aw5IgqfVrtoXXDRULyVHLD53/n59dfwYkZw2CYIXCviIK5/yhHAEkkhA4fR2Bf/J8C
         4oYj6ad628CbwuNfRRXifSwrOYWmrACSVJv/rOncPYThssmqf3LG7/gxhWLTNuOxRxGA
         jsneL5hTqupM9dU9ob43fFe1XDqLQumiFzqkkZVmc8lAg+p6tig8e5orrr7ZkNUDwxtj
         2yu76ILpx14fzilscul5dEbVKNLA2dR+OwpGzC1EsjZJ/ctxAcATmoqRcy6dmH2RoZPL
         wfLYU+RWyPWZGLI/oRP7c5xWyoxGM0H2dIagrbcp6nzsJkKzTtrCzyf+j1QExrKXwGUp
         ip7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LbzzSd6+FtCs2j1YkR2VUZSVZcYZF2OksTewulq0h2Q=;
        b=MGe84CFo6+T1LD2B2Y0wQzlITXsZ1ySiUhHwThb9nlb/UBH+hFgbonVbLxYqbaJVma
         K2qWHF4YLG94/89trlHn/Cp8a+HHvAqWaZYGtWuLo4fI5ZmXwD2ruBze7I70Yzhro/CC
         GIl+xifoiYUhO7HDi76tydshGcRw1c8EeR/TE098CgPyH8SORoLu3HLm2y2EMVhP7RgN
         tFGn3G2oA/XkSMwCAvsCFDYMbJof+VgT7pkt+/Y+z8tnHgbVAzJ+EFqKMToPJu+QdtXb
         2BGntWPry72Leqdnsmj4RavipJeuTE7feibil+9QGgnqW8e+BrKdjzQqXBviwJBMBxZd
         UKQw==
X-Gm-Message-State: AOAM532BByvDqAaDsec2MLeamw0xGF3quKvSAZECqUG4/ZgY0zFC1UZ/
        3JDt9I6cpCNT7z827CvBo3rMztxiWQ5jSA==
X-Google-Smtp-Source: ABdhPJxjI2gWeX8v/d26qIWLvnCOvcTa/5US01cXesyzR9LEBT0ZqnKvSL9QWIHYidVUEDxqNxOLPQ==
X-Received: by 2002:aca:ebcd:: with SMTP id j196mr93952oih.43.1597963640163;
        Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id j9sm751820otn.67.2020.08.20.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 09/17] rdma_rxe: Extended pools to support both keys and indices
Date:   Thu, 20 Aug 2020 17:46:30 -0500
Message-Id: <20200820224638.3212-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allowed both indices and keys to exist for objects in the pools.
Previously you were limited to one or the other. This will support
allowing the keys on MWs to change.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 73 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h | 32 +++++++-----
 2 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ad6f50e8b57a..f9f16e7ed0f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -152,18 +152,18 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
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
@@ -185,7 +185,8 @@ int rxe_pool_init(
 	pool->max_elem		= max_elem;
 	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
 	pool->flags		= rxe_type_info[type].flags;
-	pool->tree		= RB_ROOT;
+	pool->index.tree	= RB_ROOT;
+	pool->key.tree		= RB_ROOT;
 	pool->cleanup		= rxe_type_info[type].cleanup;
 
 	atomic_set(&pool->num_elem, 0);
@@ -203,8 +204,8 @@ int rxe_pool_init(
 	}
 
 	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key_offset = rxe_type_info[type].key_offset;
-		pool->key_size = rxe_type_info[type].key_size;
+		pool->key.key_offset = rxe_type_info[type].key_offset;
+		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
 	pool->state = RXE_POOL_STATE_VALID;
@@ -218,7 +219,7 @@ static void rxe_pool_release(struct kref *kref)
 	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
 
 	pool->state = RXE_POOL_STATE_INVALID;
-	kfree(pool->table);
+	kfree(pool->index.table);
 }
 
 static void rxe_pool_put(struct rxe_pool *pool)
@@ -243,27 +244,27 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
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
@@ -276,25 +277,25 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
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
@@ -307,8 +308,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			link = &(*link)->rb_right;
 	}
 
-	rb_link_node(&new->node, parent, link);
-	rb_insert_color(&new->node, &pool->tree);
+	rb_link_node(&new->key_node, parent, link);
+	rb_insert_color(&new->key_node, &pool->key.tree);
 out:
 	return;
 }
@@ -320,7 +321,7 @@ void rxe_add_key(void *arg, void *key)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	memcpy((u8 *)elem + pool->key_offset, key, pool->key_size);
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
@@ -332,7 +333,7 @@ void rxe_drop_key(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->node, &pool->tree);
+	rb_erase(&elem->key_node, &pool->key.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -355,8 +356,8 @@ void rxe_drop_index(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->min_index, pool->table);
-	rb_erase(&elem->node, &pool->tree);
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -460,10 +461,10 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		goto out;
 
-	node = pool->tree.rb_node;
+	node = pool->index.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, node);
+		elem = rb_entry(node, struct rxe_pool_entry, index_node);
 
 		if (elem->index > index)
 			node = node->rb_left;
@@ -492,13 +493,13 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
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
index c5a7721c8fde..664153bf9392 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -59,8 +59,11 @@ struct rxe_pool_entry {
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
 
@@ -77,15 +80,22 @@ struct rxe_pool {
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
 
 /* initialize slab caches for managed objects */
-- 
2.25.1

