Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010449ED99
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbiA0ViX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbiA0ViW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:22 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF1EC06173B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:22 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id b186so2348736oif.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsNeCMZKEAKvNRklFyxWkKaXRDoIJC31vUhT7QS4tLs=;
        b=dQKarUH8oAGX7EoRjIXZl3X0RXceu9KzByqA/XtR2VVDtcyeJ/goCgj30/yNPrAMv0
         lWimsfV6lb7ttZX/Cg/z9LNuwY+hZyjXerY4ELTksuNIm+8fBSNzg6JRKSA5A+TofdC5
         3ioID6+KN6871iiZmJQnfY504Fsgdywnf7rofy1lAB4zIhlWARQNNrnbXEJaLxarZnDU
         BNktmljvWCUh0aK3dEKKlO/ZN9qfyQ7kmiVMindIZDLmvW7dcaSE4LR+eHCFhzSOGIbt
         GnErsS4bh8MBNr76ToKgYpqej4RB0BrEDeEzCNBnATtxVaYYKsRlR8UH3AxXnmAw1Lp8
         p4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsNeCMZKEAKvNRklFyxWkKaXRDoIJC31vUhT7QS4tLs=;
        b=JRjTiyt0aEsTiBX04L0d4Y3zEJS/6ELHMGUIuFVpPPMHaarXuG3tHZ3IkJ5j3AzkH4
         3abmbrCQlS5U+ZxDQf9l5ACeo81T9YyLZ4+TLPhk69AoHHSjw/h1RKSY3uizvJcZTrbK
         LnVKVMi5idkkc+K9dQWtbJcpZmJaab+KsDKN25ioIINFIove6PXl/KwOmPuRcfQWAXE+
         LaIhZO9gaKsOZqgyJ6wvtQ59rU4UomxSnfqr9IqNmumu+tpFaGsjbCQNeSeeq2Tard+R
         kTd6a8tozSYD0n5kgnSMHGyR3i6nqGuQikZNsQ1XxWv3pLRyvo0MuFhY4+Cd17DAPKkO
         V9Vw==
X-Gm-Message-State: AOAM532wu9+yDA37HMTYYY+sUgqyXvTucx+JoMHp0hmdrOa/yYqDn6x7
        KbJZl1TaYSigbC70puZBYi8=
X-Google-Smtp-Source: ABdhPJzTGQ+E5TlCscn1iVvqnAnZxuXAhIosXg9VuZ5Ce7CasrZ2cSkKr5BHafm1ee9U9Zxps0etUA==
X-Received: by 2002:a05:6808:1a18:: with SMTP id bk24mr8475288oib.237.1643319501678;
        Thu, 27 Jan 2022 13:38:21 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:21 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 23/26] RDMA/rxe: Change pool locking to RCU
Date:   Thu, 27 Jan 2022 15:37:52 -0600
Message-Id: <20220127213755.31697-24-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver uses red-black trees to add indices
to the rxe object pool. Linux xarrays provide a better way to implement
the same functionality for indices. This patch replaces
red-black trees by xarrays for indexed objects.

Read side operations are protected by rcu_read_lock and write side
operations which are all from verbs API calls are protected by
the xa_lock spinlock.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 50 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 19 ++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 928bc56b439f..18cdf5e0ad4e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
@@ -35,7 +36,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -43,7 +43,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -52,7 +51,6 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -69,7 +67,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
+		.flags		= RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 	},
@@ -77,7 +75,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
@@ -100,14 +97,14 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
-
-	rwlock_init(&pool->pool_lock);
+	spin_lock_init(&pool->xa.xa_lock);
 
 	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
 	pool->limit.max = info->max_index;
 	pool->limit.min = info->min_index;
 }
 
+/* runs single threaded at driver shutdown */
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
@@ -204,36 +201,42 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
-	void *obj;
+	void *obj = NULL;
 
-	read_lock_bh(&pool->pool_lock);
+	rcu_read_lock();
 	elem = xa_load(&pool->xa, index);
 	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	else
-		obj = NULL;
-	read_unlock_bh(&pool->pool_lock);
+	rcu_read_unlock();
 
 	return obj;
 }
 
-static void rxe_elem_release(struct kref *kref)
+static void rxe_obj_free_rcu(struct rcu_head *rcu)
 {
-	struct rxe_pool_elem *elem =
-		container_of(kref, struct rxe_pool_elem, ref_cnt);
+	struct rxe_pool_elem *elem = container_of(rcu, typeof(*elem), rcu);
+
+	kfree(elem->obj);
+}
+
+static void __rxe_elem_release_rcu(struct kref *kref)
+	__releases(&pool->xa.xa_lock)
+{
+	struct rxe_pool_elem *elem = container_of(kref,
+					struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	void *obj;
+
+	__xa_erase(&pool->xa, elem->index);
+
+	spin_unlock(&pool->xa.xa_lock);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (pool->flags & RXE_POOL_ALLOC) {
-		obj = elem->obj;
-		kfree(obj);
-	}
-
-	xa_erase(&pool->xa, elem->index);
 	atomic_dec(&pool->num_elem);
+
+	if (pool->flags & RXE_POOL_ALLOC)
+		call_rcu(&elem->rcu, rxe_obj_free_rcu);
 }
 
 int __rxe_add_ref(struct rxe_pool_elem *elem)
@@ -243,5 +246,6 @@ int __rxe_add_ref(struct rxe_pool_elem *elem)
 
 int __rxe_drop_ref(struct rxe_pool_elem *elem)
 {
-	return kref_put(&elem->ref_cnt, rxe_elem_release);
+	return kref_put_lock(&elem->ref_cnt, __rxe_elem_release_rcu,
+			&elem->pool->xa.xa_lock);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index c985ed519066..40026d746563 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -8,8 +8,7 @@
 #define RXE_POOL_H
 
 enum rxe_pool_flags {
-	RXE_POOL_INDEX		= BIT(1),
-	RXE_POOL_ALLOC		= BIT(2),
+	RXE_POOL_ALLOC		= BIT(1),
 };
 
 enum rxe_elem_type {
@@ -29,13 +28,13 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
+	struct rcu_head		rcu;
 	u32			index;
 };
 
 struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
-	rwlock_t		pool_lock; /* protects pool add/del/search */
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
@@ -48,38 +47,24 @@ struct rxe_pool {
 	struct xarray		xa;
 	struct xa_limit		limit;
 	u32			next;
-	int			locked;	/* ?? */
 };
 
-/* initialize a pool of objects with given limit on
- * number of elements. gets parameters from rxe_type_info
- * pool elements will be allocated out of a slab cache
- */
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		  enum rxe_elem_type type, u32 max_elem);
 
-/* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
 void *rxe_alloc(struct rxe_pool *pool);
 
-/* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
-
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
-/* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* take a reference on an object */
 int __rxe_add_ref(struct rxe_pool_elem *elem);
-
 #define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
-/* drop a reference on an object */
 int __rxe_drop_ref(struct rxe_pool_elem *elem);
-
 #define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 12bff190fc1f..d70d44392c32 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -309,6 +309,7 @@ static inline int rkey_is_mw(u32 rkey)
 struct rxe_mr {
 	struct rxe_pool_elem	elem;
 	struct ib_mr		ibmr;
+	struct rcu_head		rcu;
 
 	struct ib_umem		*umem;
 
-- 
2.32.0

