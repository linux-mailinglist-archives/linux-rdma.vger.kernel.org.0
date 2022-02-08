Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E964AE3EA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387531AbiBHWYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386877AbiBHVRU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:20 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C44C0612BA
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:20 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so182530oot.4
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5NSZgM/eetxo3VfRJ6XMU05MDJxyGmAMp/JPP6GxM7s=;
        b=gB9xCVx5goJwy3Czrk7Y78TIJSRUa3wf4SvRtNdRrlxJOyf4T6fR8A5ZTH6BOj1dNW
         tDHcq18D3mqxhfB6sKtaJLRYehNjk/+E+0z+lKRKmHFVBBJxV/vYscT7RnOgdcW4bsfU
         Ofa7kSzcwbvoy1ySznTtyeTp3QIAinHt4du3NDJX1gasAC2SVkL71x0IdOk+kW+vafSk
         dlmaSbxU8mFPexAf9gPjRavnIjOK/5qUzJQkey6vS+2niWyhX3r8nzbGnxdd9jPExVYa
         tDGXi1wC1h1EWFbvILkq9Uzxa4zkhw1kwTtuCj2anm/LRK/OIgAY+9xKCaxSX8bo22ob
         A9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NSZgM/eetxo3VfRJ6XMU05MDJxyGmAMp/JPP6GxM7s=;
        b=H/JZoDmeIw1UsLH9vxfd3eUvl1B2YbaG5wG/FUJ4F4Hd6tjRhiqS+KjhwuHcmGc4wz
         qtn0j0V2wsKQX4b6uzPnIXQSwY/4ePdVC3Jbs0qkZvO1KfpywAA0uxw2AhEJd2x6Sk5Q
         yoTQxEPX7wqt20MammNyW7WvfkSOAsm3iMnld4kK9pMqa7NZZONLGEWPvTWQsxAAOVsQ
         MdqpnU0uIL9h8QQa+5YsAu009s2l5NEl0Lg881LcbfgQg+LBSjUU3k8xpdzCzaU3bFSh
         08Ei6ZKmw8zSa9YxsCQj86/W0EA6JFuXhcBVdNDMYHPD3KRGLsjWWNRJmIvT+qimMdVv
         Z2rA==
X-Gm-Message-State: AOAM530Bom0GVvtE0PcJlsDpg3NRN6zZzqXOxjfn9xbmLUNe2K12LwOA
        uEKkUUqAakZ/D/p0WYT2cHB0qBKllBw=
X-Google-Smtp-Source: ABdhPJwoFybKweBozUvjAUiGzMhFmtWWMIMOmneHUIv4F8htYEYKwzeBY+I+9aSOWHgAcGoc20614w==
X-Received: by 2002:a05:6870:1251:: with SMTP id 17mr965219oao.254.1644355039422;
        Tue, 08 Feb 2022 13:17:19 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:19 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 06/11] RDMA/rxe: Remove key'ed object support
Date:   Tue,  8 Feb 2022 15:16:40 -0600
Message-Id: <20220208211644.123457-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208211644.123457-1-rpearsonhpe@gmail.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index a6756aa93e2b..49a25f8ceae1 100644
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
@@ -147,12 +145,6 @@ int rxe_pool_init(
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
@@ -209,77 +201,6 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
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
@@ -443,47 +364,3 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
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
index 9201bb6b8b07..2db9d9872cd1 100644
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

