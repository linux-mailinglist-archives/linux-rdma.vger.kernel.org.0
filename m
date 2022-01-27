Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E149ED89
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbiA0ViR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344442AbiA0ViQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:16 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658F0C06175C
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:15 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id y23so8460151oia.13
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTtTwdu5em41EWFvJMufZEtcNuGGg+0nCV4u7Ii4q58=;
        b=Ji5XCfV182dH2OnMN2vhdtzzs16cfNWv2YeE9pR3pjhFh2VJHHkmJ5mzVqrwU2+hrC
         TmacHVmRAPon5uVOhTGsWqkJI1WraW0RcQBP3dqEyedJdJc4cypCHZ1JHfyvt9ZAydtt
         xFDvnLrw0VvEG1YEth46H15TjqnOlfmpP111KfgfoTTnVwL5BrfFW4AirAxb+YT2JGrV
         EoI7FUCek/K5s09Ft99plJWs/AS6ZNyU2mlFKobmWlu7zZIEp8kvVxnU4K4WFoy+XM/t
         X/NF9+InpxYLe1UPna8TQfLVrQK/Tox/LIvuGG32YTip1gmxTsCgw+ucsMt/8VmwzKjA
         HuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTtTwdu5em41EWFvJMufZEtcNuGGg+0nCV4u7Ii4q58=;
        b=N4V6+vngoYp2xNxXbAJI8iEmhsSSKhUtQi/ACBJOMlAdrwKaKfiEV/v+Lsrzgi0haB
         Lj1dFsiPyKjmMchtADdfZyGVhbXiZ0Ra/5pg7ibA28PB0B7uB4xitAjbF0KZ5etqjGJ+
         drK0Ps6MeMw0tgsyjmOlGmgiW11wziSIvsPFpiqt2obX8iCrhfmJUbrMsa2qrrfQwd9d
         8xl9nTnPePCAeUrMHxZw+ucYh6+YA43uDQU4Yl2bLg0mMVe5HQwtnlcK1A+aOgnlcd6k
         2VTA8A4f9/SlFGIYVd1fHEgBeYHXbDlnkakCWnF1aesPSeeydXAt0bjQb/m/isNLN5YQ
         yzNg==
X-Gm-Message-State: AOAM531degF/sv/PyCxTd3vd1OVDDKYbi+PAgwn8KbFq9l5Spmjn6PW6
        is2PFuCtKr9xlRCKja3LD0foyznTRI8=
X-Google-Smtp-Source: ABdhPJyxXe97SZ8DUYMujkAnK6IXmjujFC098VWHrlxTiXY9+9HWyL328OyGa+20xQ8DYdWZ54Yl9A==
X-Received: by 2002:a54:4812:: with SMTP id j18mr8208763oij.186.1643319494811;
        Thu, 27 Jan 2022 13:38:14 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:14 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 13/26] RDMA/rxe: Remove key'ed object support
Date:   Thu, 27 Jan 2022 15:37:42 -0600
Message-Id: <20220127213755.31697-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_pool.c | 126 ---------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  38 --------
 2 files changed, 164 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index a6756aa93e2b..673b29f1f12c 100644
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
@@ -86,9 +84,6 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mcg),
 		.elem_offset	= offsetof(struct rxe_mcg, elem),
 		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY,
-		.key_offset	= offsetof(struct rxe_mcg, mgid),
-		.key_size	= sizeof(union ib_gid),
 	},
 };
 
@@ -147,12 +142,6 @@ int rxe_pool_init(
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
@@ -209,77 +198,6 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
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
@@ -443,47 +361,3 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
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

