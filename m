Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A8E4A521C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiAaWKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiAaWKP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E916C061744
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:15 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id n6-20020a9d6f06000000b005a0750019a7so14427643otq.5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8FYVdtWAAqdzoqyYFlGhe2LJ7OpG5+d8J1MkrjCL+s=;
        b=k/+JKCgpwnFToKQCaHOjxxui96Wl8kxVcbKq3Amm8RgM3Dq9VDenAf9XXbBLiaLCPj
         euwCDpZsknKv4o8rD5OXrEG9ftSw0tKHzOmBJmuXQvyF6hB3e8o78RiQnR561mqgkuCc
         UdHilOq5ZeT9YMg7rf9d28IzsbyU577KVMfAIqLLdpz97wmfOty2z4Qpwbts9aFbvaLu
         xl0dBbxkWHqPSTaZSDrwSEYyt526tIPpRpkS/UVsKvh8vwO7IJFZXCxm4aD41NlbaoGu
         sz5034Z8VrazDd80AZd7QaFvP8GcxWyusoNBDcVg9gyWujRWu9sKuaJskx+mWU4roUY9
         tiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8FYVdtWAAqdzoqyYFlGhe2LJ7OpG5+d8J1MkrjCL+s=;
        b=0wWRya7XRINnNm48PiOZsw0og3nXRDFt8PHkCAUj4/hv8F/lzDf3UL14hdyVamVIu2
         6kHoY8SfahPnTP/EmMUXqzHUX1FKwe3yL5y6oNYenTJeBP2rtQxT+U8fajGKYO2YCMJS
         9Hj21Et4vlz5B9uJ4n2HojsX+1SjKZrcoFcrXOrVomkSg3t8LcqN6w8raVm5KLJUTw88
         Lor2WCHv2Joy6G0LLgt5PbI4VTgiys65WGgKWBPXTtHksP5WPqa8k+sNnIEGAMvTsEhx
         8lALAOGMUxeDKhB5oX+WybMpfYXpoQ0KwnEnxoLNlLc3uIr/8lM+YZvTNHsXHrmFATW2
         jDzg==
X-Gm-Message-State: AOAM531j6QC3ibKYbx6MmctHF2hThgXtS+4/XGnd7UQyKm/V1yDQFHqU
        V/M3CBwgyFhSf9Y74mS5afomLkQUwEo=
X-Google-Smtp-Source: ABdhPJzZ0wC89hCigctRzBxwCtuWHuJmYj4XVos4P8SrLSWlykdv+NfjmtucU+7oQGgZh6UivKbTGQ==
X-Received: by 2002:a9d:2006:: with SMTP id n6mr12335784ota.280.1643667014514;
        Mon, 31 Jan 2022 14:10:14 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:14 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 13/17] RDMA/rxe: Remove key'ed object support
Date:   Mon, 31 Jan 2022 16:08:46 -0600
Message-Id: <20220131220849.10170-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that rxe_mcast.c has it's own red-black tree support there is no
longer any requirement for key'ed objects in rxe pools. This patch
removes the key APIs and related code.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 123 ---------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  38 ---------
 2 files changed, 161 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4eff95d57aa4..fe0fcca47d8d 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -16,8 +16,6 @@ static const struct rxe_type_info {
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
-	size_t key_offset;
-	size_t key_size;
 } rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
@@ -143,12 +141,6 @@ int rxe_pool_init(
 			goto out;
 	}
 
-	if (pool->flags & RXE_POOL_KEY) {
-		pool->key.tree = RB_ROOT;
-		pool->key.key_offset = info->key_offset;
-		pool->key.key_size = info->key_size;
-	}
-
 out:
 	return err;
 }
@@ -205,77 +197,6 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
 	return 0;
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
-	write_lock_bh(&pool->pool_lock);
-	err = __rxe_add_key_locked(elem, key);
-	write_unlock_bh(&pool->pool_lock);
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
-	write_lock_bh(&pool->pool_lock);
-	__rxe_drop_key_locked(elem);
-	write_unlock_bh(&pool->pool_lock);
-}
-
 int __rxe_add_index_locked(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -439,47 +360,3 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 	return obj;
 }
-
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
-{
-	struct rb_node *node;
-	struct rxe_pool_elem *elem;
-	void *obj;
-	int cmp;
-
-	node = pool->key.tree.rb_node;
-
-	while (node) {
-		elem = rb_entry(node, struct rxe_pool_elem, key_node);
-
-		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     key, pool->key.key_size);
-
-		if (cmp > 0)
-			node = node->rb_left;
-		else if (cmp < 0)
-			node = node->rb_right;
-		else
-			break;
-	}
-
-	if (node) {
-		kref_get(&elem->ref_cnt);
-		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
-
-	return obj;
-}
-
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
-{
-	void *obj;
-
-	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_key_locked(pool, key);
-	read_unlock_bh(&pool->pool_lock);
-
-	return obj;
-}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 511f81554fd1..b6de415e10d2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -9,7 +9,6 @@
 
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
-	RXE_POOL_KEY		= BIT(2),
 	RXE_POOL_NO_ALLOC	= BIT(4),
 };
 
@@ -32,9 +31,6 @@ struct rxe_pool_elem {
 	struct kref		ref_cnt;
 	struct list_head	list;
 
-	/* only used if keyed */
-	struct rb_node		key_node;
-
 	/* only used if indexed */
 	struct rb_node		index_node;
 	u32			index;
@@ -61,13 +57,6 @@ struct rxe_pool {
 		u32			max_index;
 		u32			min_index;
 	} index;
-
-	/* only used if keyed */
-	struct {
-		struct rb_root		tree;
-		size_t			key_offset;
-		size_t			key_size;
-	} key;
 };
 
 /* initialize a pool of objects with given limit on
@@ -112,26 +101,6 @@ void __rxe_drop_index(struct rxe_pool_elem *elem);
 
 #define rxe_drop_index(obj) __rxe_drop_index(&(obj)->elem)
 
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
 /* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
  */
@@ -139,13 +108,6 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index);
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key holding and not holding the pool_lock.
- * takes a reference on the objecti
- */
-void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
-
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
-
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
 
-- 
2.32.0

