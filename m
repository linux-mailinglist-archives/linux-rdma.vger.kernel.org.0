Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5F2452B1
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgHOVyV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgHOVwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCABC0612A8
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:03 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y30so2348820ooj.3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8ZzdTqBaA6hLa0ubKxz+8bLIrVTULNlByYnBjQyRg0=;
        b=tspgzCQjDE0lvZZChKO/Xko38qBhhIcQJjYKC+RE4ZBeVlUwkGn4T34OBeev8C8UNy
         6t28w3kxKn+ItdWaJcHMl7wIPLbfv2ZvOaaretFTP2kOhHi3RTCK+NEG+P+Tz7anDNad
         WrOrDRoCFdaelaXyzEqA3qiM+H7Zd5q45rzahtzlTCtkxf+0zZk68a7edHyUMYUvBspO
         AuSb8+1CCTEnreaIT34PpPh/1KsWHIJ8m59pCBYdM7HfO/njbpr4rHLOzRsCRF1IUnu5
         m+rfQTp1rrrbLi363cbkt/Riz5kl8Yt6yBnRmUr/qdN+LSpW7OednhEHih1n/Fmik6on
         HRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8ZzdTqBaA6hLa0ubKxz+8bLIrVTULNlByYnBjQyRg0=;
        b=J6UKjghlmlAWaPBxa/n8rQl1ig8d7Pu21nFr8PFryCfa38U5SOadgUp0VJkZ6/OxPb
         l8SDsM4qc/0exwWiuALV9argb/ozsAT65BpuXHmGdNShC5jjlKmrQHdXJiZ+/rypmQ39
         f2vKQlfkrWL9Eon7fwSwTYW4n+/JDuVHvph8l+Xs8MgHKNx2780vEs3za5sJCzYfqtXs
         iA85VmQfJN5woLOTuDbvm+UGyfKcrlpKb10IjjA5ThKU5/JmFjSOFFVwmq7B7IzeSsqy
         4UA6xWTRCXoE1CSLUdhp/NSQaXvl+7Ks5cjCME3InZePRQMCNnAYzCbKgipz/UWSV1oU
         h5EQ==
X-Gm-Message-State: AOAM530M+xQUf4GX1KGiaMYjYlrtH/RKmBuoE6cFJSJqaF3GTsrcjzu3
        HP6KHZshodepI4nCpdhC3ELwwHlzLVeX6A==
X-Google-Smtp-Source: ABdhPJzOOphD+EfQrmuXIQhGnKcggrgjt2HbQh3iju8pIfmo8AIQTJ30xIdUwrEGrwzY6YQ6u+s8rw==
X-Received: by 2002:a4a:3443:: with SMTP id n3mr4137494oof.30.1597467602299;
        Fri, 14 Aug 2020 22:00:02 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id r124sm2207636oib.22.2020.08.14.22.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 10/20] Extended pools to support both keys and indices
Date:   Fri, 14 Aug 2020 23:58:34 -0500
Message-Id: <20200815045912.8626-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
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
index 32b86a9979e6..e157bf945175 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -177,18 +177,18 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
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
@@ -210,7 +210,8 @@ int rxe_pool_init(
 	pool->max_elem		= max_elem;
 	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
 	pool->flags		= rxe_type_info[type].flags;
-	pool->tree		= RB_ROOT;
+	pool->index.tree	= RB_ROOT;
+	pool->key.tree		= RB_ROOT;
 	pool->cleanup		= rxe_type_info[type].cleanup;
 
 	atomic_set(&pool->num_elem, 0);
@@ -228,8 +229,8 @@ int rxe_pool_init(
 	}
 
 	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key_offset = rxe_type_info[type].key_offset;
-		pool->key_size = rxe_type_info[type].key_size;
+		pool->key.key_offset = rxe_type_info[type].key_offset;
+		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
 	pool->state = RXE_POOL_STATE_VALID;
@@ -243,7 +244,7 @@ static void rxe_pool_release(struct kref *kref)
 	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
 
 	pool->state = RXE_POOL_STATE_INVALID;
-	kfree(pool->table);
+	kfree(pool->index.table);
 }
 
 static void rxe_pool_put(struct rxe_pool *pool)
@@ -268,27 +269,27 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
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
@@ -301,25 +302,25 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
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
@@ -332,8 +333,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			link = &(*link)->rb_right;
 	}
 
-	rb_link_node(&new->node, parent, link);
-	rb_insert_color(&new->node, &pool->tree);
+	rb_link_node(&new->key_node, parent, link);
+	rb_insert_color(&new->key_node, &pool->key.tree);
 out:
 	return;
 }
@@ -345,7 +346,7 @@ void rxe_add_key(void *arg, void *key)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	memcpy((u8 *)elem + pool->key_offset, key, pool->key_size);
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
@@ -357,7 +358,7 @@ void rxe_drop_key(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->node, &pool->tree);
+	rb_erase(&elem->key_node, &pool->key.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -380,8 +381,8 @@ void rxe_drop_index(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->min_index, pool->table);
-	rb_erase(&elem->node, &pool->tree);
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -485,10 +486,10 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		goto out;
 
-	node = pool->tree.rb_node;
+	node = pool->index.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, node);
+		elem = rb_entry(node, struct rxe_pool_entry, index_node);
 
 		if (elem->index > index)
 			node = node->rb_left;
@@ -517,13 +518,13 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
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
index 2f2cff1cbe43..bd684df6d847 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -84,8 +84,11 @@ struct rxe_pool_entry {
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
 
@@ -102,15 +105,22 @@ struct rxe_pool {
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

