Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE284355B4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhJTWJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTWJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE9C061749
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x27-20020a9d459b000000b0055303520cc4so9959503ote.13
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kwDB+WyuiMNWaO6iHCXpNevUwT5XXkj0VKU7Sq+tro=;
        b=GzybidH8pB5FS3vc2kSbMIhJwoHXBYJMjt2upop7bgfU7l0TjyNjz9IkJ4070EQ/1t
         tfXG/WQ0ytxAw1jBQEZguYlwYIi03k9NJkEUehphyOE+wbZuhGoSZ+haBVW3sGoUCBVw
         W9Ag8ELo8fts9/bYf/Mow8q6hmN6UEOKCNG4M3otmNqNy3NjnN+/bMnisIhA6bIkOVoN
         Cbr7Qkgq8z54jI4WRFBh8DHKo2CLqvJg97nQB1ZJjeipYrivJ5+ZxzARUyukMTizn2Tv
         shfBdemZ83QIRtccgwtVS0Qu/9982mu9rADQrD9k9ANAK65NAwvTNln2Eq87k3Zb57QB
         6iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kwDB+WyuiMNWaO6iHCXpNevUwT5XXkj0VKU7Sq+tro=;
        b=mWZzc3JzSm7NWycXiKfQeaDyXwGp+7pAH4iK/faqxRQGAli9P0Th105jmHtPdAXG7I
         iGZSCT8jL2K2LEV3cq0QCLePiZ2dDdGGa2YQPqPVGsPSXfgFWeoZnd67mjQv8sZp+1tx
         E8AtIxg0xaonvO8dRQBvLMpuflqNG6jyDREuVCLMfcUpIEdsjOScw4C0pkkBl/JGu3aW
         jGEXCxODzK2U+A1K4/z9yVxgfFCsD6FFP2pdEvqfqBMDKBIPzs/j/2C77SYnCQa6zHcD
         h/hrT8vKZNzsneSLlD6W6JqE521Bf8UFLVekWmRO7VDRpcfUnA7L0Cteru4V7ReDGYlF
         O4PQ==
X-Gm-Message-State: AOAM531oJUXQn19gcZoO64KpPxpfO5fb4e/rkdSOc+uNdY8kDcD9b1wZ
        PQRnLXOpvhlMUUXwlNaZfegXffopU08=
X-Google-Smtp-Source: ABdhPJw/hhxWft9cBcsTfG1O3HBHODotqTtP/Na8ab67+mZC2OVMQTTqMZ95eO2pwFN0K2zm1JQvXg==
X-Received: by 2002:a05:6830:19f5:: with SMTP id t21mr1473321ott.293.1634767648620;
        Wed, 20 Oct 2021 15:07:28 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/7] RDMA/rxe: Add xarray support to rxe_pool.c
Date:   Wed, 20 Oct 2021 17:05:46 -0500
Message-Id: <20211020220549.36145-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020220549.36145-1-rpearsonhpe@gmail.com>
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver uses red-black trees to add indices and keys
to the rxe object pool. Linux xarrays provide a better way to implement
the same functionality for indices but not keys. This patch adds a
second alternative to adding indices based on cyclic allocating xarrays.
The AH pool is modified to hold either xarrays or red-black trees.
The code is tested for both options.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 100 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_pool.h |   9 +++
 2 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 24ebd1b663c3..ba5c600fa9e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -25,7 +25,8 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		//.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -128,15 +129,20 @@ int rxe_pool_init(
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
 	pool->flags		= info->flags;
-	pool->index.tree	= RB_ROOT;
-	pool->key.tree		= RB_ROOT;
 	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
 
 	rwlock_init(&pool->pool_lock);
 
+	if (info->flags & RXE_POOL_XARRAY) {
+		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
+		pool->xarray.limit.max = info->max_index;
+		pool->xarray.limit.min = info->min_index;
+	}
+
 	if (info->flags & RXE_POOL_INDEX) {
+		pool->index.tree = RB_ROOT;
 		err = rxe_pool_init_index(pool, info->max_index,
 					  info->min_index);
 		if (err)
@@ -144,6 +150,7 @@ int rxe_pool_init(
 	}
 
 	if (info->flags & RXE_POOL_KEY) {
+		pool->key.tree = RB_ROOT;
 		pool->key.key_offset = info->key_offset;
 		pool->key.key_size = info->key_size;
 	}
@@ -158,7 +165,8 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool->name);
 
-	kfree(pool->index.table);
+	if (pool->flags & RXE_POOL_INDEX)
+		kfree(pool->index.table);
 }
 
 /* should never fail because there are at least as many indices as
@@ -272,28 +280,35 @@ static void *__rxe_alloc_locked(struct rxe_pool *pool)
 	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err;
 
 	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
 	if (!obj)
-		goto out_cnt;
+		goto err;
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
 	elem->obj = obj;
 
+	if (pool->flags & RXE_POOL_XARRAY) {
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+					 pool->xarray.limit,
+					 &pool->xarray.next, GFP_KERNEL);
+		if (err)
+			goto err;
+	}
+
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
-		if (err) {
-			kfree(obj);
-			goto out_cnt;
-		}
+		if (err)
+			goto err;
 	}
 
 	return obj;
 
-out_cnt:
+err:
+	kfree(obj);
 	atomic_dec(&pool->num_elem);
 	return NULL;
 }
@@ -368,15 +383,23 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 
 	write_lock_bh(&pool->pool_lock);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 
+	if (pool->flags & RXE_POOL_XARRAY) {
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+					 pool->xarray.limit,
+					 &pool->xarray.next, GFP_KERNEL);
+		if (err)
+			goto err;
+	}
+
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
 		if (err)
-			goto out_cnt;
+			goto err;
 	}
 
 	refcount_set(&elem->refcnt, 1);
@@ -384,13 +407,13 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 
 	return 0;
 
-out_cnt:
+err:
 	atomic_dec(&pool->num_elem);
 	write_unlock_bh(&pool->pool_lock);
 	return -EINVAL;
 }
 
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
+static void *__rxe_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
@@ -415,17 +438,58 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+static void *__rxe_get_index(struct rxe_pool *pool, u32 index)
+{
+	void *obj;
+
+	read_lock_bh(&pool->pool_lock);
+	obj = __rxe_get_index_locked(pool, index);
+	read_unlock_bh(&pool->pool_lock);
+
+	return obj;
+}
+
+static void *__rxe_get_xarray_locked(struct rxe_pool *pool, u32 index)
+{
+	struct rxe_pool_elem *elem;
+	void *obj = NULL;
+
+	elem = xa_load(&pool->xarray.xa, index);
+	if (elem && refcount_inc_not_zero(&elem->refcnt))
+		obj = elem->obj;
+
+	return obj;
+}
+
+static void *__rxe_get_xarray(struct rxe_pool *pool, u32 index)
 {
 	void *obj;
 
 	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_index_locked(pool, index);
+	obj = __rxe_get_xarray_locked(pool, index);
 	read_unlock_bh(&pool->pool_lock);
 
 	return obj;
 }
 
+void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
+{
+	if (pool->flags & RXE_POOL_XARRAY)
+		return __rxe_get_xarray_locked(pool, index);
+	if (pool->flags & RXE_POOL_INDEX)
+		return __rxe_get_index_locked(pool, index);
+	return NULL;
+}
+
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+{
+	if (pool->flags & RXE_POOL_XARRAY)
+		return __rxe_get_xarray(pool, index);
+	if (pool->flags & RXE_POOL_INDEX)
+		return __rxe_get_index(pool, index);
+	return NULL;
+}
+
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
@@ -519,6 +583,8 @@ static int __rxe_fini(struct rxe_pool_elem *elem)
 
 	done = refcount_dec_if_one(&elem->refcnt);
 	if (done) {
+		if (pool->flags & RXE_POOL_XARRAY)
+			xa_erase(&pool->xarray.xa, elem->index);
 		if (pool->flags & RXE_POOL_INDEX)
 			rxe_drop_index(elem);
 		if (pool->flags & RXE_POOL_KEY)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 3e78c275c7c5..f9c4f09cdcc9 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -8,6 +8,7 @@
 #define RXE_POOL_H
 
 #include <linux/refcount.h>
+#include <linux/xarray.h>
 
 #define RXE_POOL_ALIGN		(16)
 #define RXE_POOL_CACHE_FLAGS	(0)
@@ -15,6 +16,7 @@
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
+	RXE_POOL_XARRAY		= BIT(3),
 	RXE_POOL_NO_ALLOC	= BIT(4),
 };
 
@@ -72,6 +74,13 @@ struct rxe_pool {
 	size_t			elem_size;
 	size_t			elem_offset;
 
+	/* only used if xarray */
+	struct {
+		struct xarray		xa;
+		struct xa_limit		limit;
+		u32			next;
+	} xarray;
+
 	/* only used if indexed */
 	struct {
 		struct rb_root		tree;
-- 
2.30.2

