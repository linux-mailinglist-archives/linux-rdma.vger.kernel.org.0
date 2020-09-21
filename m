Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F54E273371
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIUUEL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUUEK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:10 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0BCC061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so18338310oia.8
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1TZIs7znNhkB5dcnBH7CahLIv96Wzdg/cqZF3s4VXM=;
        b=Ju1spnjPtIkGho224z8y8EhQkI6b7VQHI4oycKV3VyxzqL94jQWcP4v8cE+hbri4Tx
         EAt3XJpkC9Go3QlOtbPg3roNOwTzrGMFSJvqovYohCIveU87mUdmsFARdOhkw2slgTuW
         RBjdPTlwdHbEPy1pcI2hdZoy0FSQfWHQEHc9v979NNInrLaaD1yQLu9TIHhOH8liJHKj
         Vx1TLGn/3ziGC6bYJBAWw8O/Zpg2Jbn4/hqhEabgvqeXj9YuYX9J1g+wIu+c6henGVuh
         9nXJSga2R3vgUA+icklSsxEje+6+JBLdckaWbCnGNh0Zc35G4ir8N+3N2Tvc10fqQTYf
         HVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1TZIs7znNhkB5dcnBH7CahLIv96Wzdg/cqZF3s4VXM=;
        b=iSO/0OZoSdANbKbDX8VGq8h/xgtO0SakDO3RVvUKU57il6Hh/G/dvz4dh4NG2sYITf
         64tr7KfBq0B/ZUkxza5wcOoeQd7jAL4FLSlMBpQT36ScupLSDrzY9nFZvLG5Yl7bYHgA
         I7BKVzU3ciQQ+VTBiuIeb0v2uOsMTvn0Tq8S8uLep9AvDyZpFcDp9fuG/Y5a8JADvfkf
         DvRwLpDAByo2/Bj88UzKj5nztJ+NkFAHOEwCJnpqP6XTYdki0svCe6KuSJlbaox6XC+v
         zLZnGEFR+MGbc1Q8QKO55+7m9BXCzIU5qXwMjU0V4NwPFw1Rt5t92zCKAzZjWXCsF20H
         AzXg==
X-Gm-Message-State: AOAM531lT/W60Rq18KfzW80om7Q29XhY8pkwznEVEg5dHeQ5yd7Xpjhy
        jinsE8f6Qco3NBe4JjDxEvU=
X-Google-Smtp-Source: ABdhPJw65B8eE+bJApfQXOj8eXP9zkZwR8lHo5FvzpB916EKZ9pzYt2jPxfUDPEVQV8F4Ps3nLQ7hA==
X-Received: by 2002:aca:3a57:: with SMTP id h84mr653254oia.95.1600718649974;
        Mon, 21 Sep 2020 13:04:09 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id h24sm6208291otj.33.2020.09.21.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 03/12] rdma_rxe: Let pools support both keys and indices
Date:   Mon, 21 Sep 2020 15:03:47 -0500
Message-Id: <20200921200356.8627-4-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921200356.8627-1-rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Allow both indices and keys to exist for objects in pools.
Previously you were limited to one or the other. This will support
allowing the keys on MWs to change.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 73 ++++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h | 32 +++++++-----
 2 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 32ba47d143f3..30b8f037ee20 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -92,18 +92,18 @@ static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
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
@@ -125,7 +125,8 @@ int rxe_pool_init(
 	pool->max_elem		= max_elem;
 	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
 	pool->flags		= rxe_type_info[type].flags;
-	pool->tree		= RB_ROOT;
+	pool->index.tree	= RB_ROOT;
+	pool->key.tree		= RB_ROOT;
 	pool->cleanup		= rxe_type_info[type].cleanup;
 
 	atomic_set(&pool->num_elem, 0);
@@ -143,8 +144,8 @@ int rxe_pool_init(
 	}
 
 	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key_offset = rxe_type_info[type].key_offset;
-		pool->key_size = rxe_type_info[type].key_size;
+		pool->key.key_offset = rxe_type_info[type].key_offset;
+		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
 	pool->state = RXE_POOL_STATE_VALID;
@@ -158,7 +159,7 @@ static void rxe_pool_release(struct kref *kref)
 	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
 
 	pool->state = RXE_POOL_STATE_INVALID;
-	kfree(pool->table);
+	kfree(pool->index.table);
 }
 
 static void rxe_pool_put(struct rxe_pool *pool)
@@ -183,27 +184,27 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
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
@@ -216,25 +217,25 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
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
@@ -247,8 +248,8 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			link = &(*link)->rb_right;
 	}
 
-	rb_link_node(&new->node, parent, link);
-	rb_insert_color(&new->node, &pool->tree);
+	rb_link_node(&new->key_node, parent, link);
+	rb_insert_color(&new->key_node, &pool->key.tree);
 out:
 	return;
 }
@@ -260,7 +261,7 @@ void rxe_add_key(void *arg, void *key)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	memcpy((u8 *)elem + pool->key_offset, key, pool->key_size);
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
@@ -272,7 +273,7 @@ void rxe_drop_key(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->node, &pool->tree);
+	rb_erase(&elem->key_node, &pool->key.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -295,8 +296,8 @@ void rxe_drop_index(void *arg)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->min_index, pool->table);
-	rb_erase(&elem->node, &pool->tree);
+	clear_bit(elem->index - pool->index.min_index, pool->index.table);
+	rb_erase(&elem->index_node, &pool->index.tree);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
@@ -400,10 +401,10 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		goto out;
 
-	node = pool->tree.rb_node;
+	node = pool->index.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, node);
+		elem = rb_entry(node, struct rxe_pool_entry, index_node);
 
 		if (elem->index > index)
 			node = node->rb_left;
@@ -432,13 +433,13 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
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
2.25.1

