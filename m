Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652F648F4C1
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jan 2022 05:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiAOE35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 23:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiAOE35 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 23:29:57 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D28C061574
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 20:29:57 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso12512275otr.6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 20:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R11qtTIKU1LpoNy0GmDSCBWb3rYyFQcOG6D/9cEQPmw=;
        b=GTBiWwZ/D6/XADY2GSxA/watpjBjNRav9dmKlMw38eqncHyvHHoaVg7XEEu3qDiXzQ
         rMkYbtmVBbn0mwYh6SpxojU/G5VWysvolbU4wCL5M7vMIPcfJQOcM72CdSrsm+W0QrdA
         Cvy6zCP+7iIK4ylMQkyrYxHxaINxNl2pYWo2siu/5HkvWbxOm4/3hFda6EBhSWmafMVJ
         jY95iYUv4Sq6BIzaSuKxMXX5VynqXBQ5B9Rs4K9X2UIUXSGcsgyeeoRrUzeuk0ilzfGF
         z6HQoFfF49m9cshfCZR/ukvneojhaUIBbiU9Bq3vbDNKD4HgJArbqGF4vVicT9vi68pw
         1QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R11qtTIKU1LpoNy0GmDSCBWb3rYyFQcOG6D/9cEQPmw=;
        b=tw8pWFRXASsr0bVfFUvw9qtjoJ3J8IRH02c0Xn+DIrz+XNqxORceP5UjfW7d301Hq0
         Z8GbL25t3zN2HYbiID43TbfZHUOda90oFMo2cr97lMmiIW4inm22f9alWxuFFQ8ix89v
         syGvgzod0dCViNa6pjif7ehy0KJRQfHkGRFEedVlP48DXiS+d3r58NipAr29dR/9QM4X
         MgxwEHabQBXFIk9cFzP10IEL4SUJPt1m8wcbVu/C0PVw9fPEbU6EbRpWM/gcGefc7PBJ
         X8AWkCOxZI6+5pLWoZrusRYqqftGPUduA9i9aZdW7P61E/G0ML9Run4IGaPr6w6ZMM9k
         CtPg==
X-Gm-Message-State: AOAM532+ZqGhx0PXT+V/OJ/XRQC7XBhRAMEUQjBTb+jitE1KfQs51N53
        kasEWS0dG91rfpH78/YiPQDSB5SMuxw=
X-Google-Smtp-Source: ABdhPJyCaqs4zSEY9C1GhFAfzEwoaueptjc/hpKNwM+Sh0+Fk6WPlTgUqI6v0Si1atS9BkdK8TU45g==
X-Received: by 2002:a9d:7581:: with SMTP id s1mr9335572otk.57.1642220996418;
        Fri, 14 Jan 2022 20:29:56 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id k8sm2757515oon.2.2022.01.14.20.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:29:55 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 2/4] RDMA/rxe: Replace RB tree by xarray for indexes
Date:   Fri, 14 Jan 2022 22:29:09 -0600
Message-Id: <20220115042910.40181-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220115042910.40181-1-rpearsonhpe@gmail.com>
References: <20220115042910.40181-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver uses red-black trees to add indices
to the rxe object pool. Linux xarrays provide a better way to implement
the same functionality for indices. This patch replaces
red-black trees by xarrays for indexed objects. Since caller managed
locks for indexed objects are not used these APIs are deleted as well.

To avoid double locking since xarray already includes a spinlock replace
the rxe_pool rwlock by the spinlock included in xarray.

The RDMA objects are created and destroyed by verbs calls from rdma_core
but are looked up from indices or keys from soft IRQs so _bh style locks
are the correct type to use.

A private copy of kref_put_lock that calls a private copy of
refcount_dec_and_lock which uses _bh locks.  This routine generates
a sparse warning as does the original refcount_dec_and_lock routine.
There does not seem to be a way to annotate this away.

There is only one remaining object type that allocates its own memory,
that is MR, so the sense of RXE_POOL_NO_ALLOC is changed to
RXE_POOL_ALLOC. Last ditch code is added to free MRs allocated by rxe
if applications do not free their objects. rdma/core is responsible
for freeing objects it allocated which covers the remaining cases for
applications which do not clean up.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  87 +-----
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   4 -
 drivers/infiniband/sw/rxe/rxe_pool.c  | 371 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  72 +----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 -
 6 files changed, 205 insertions(+), 342 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index c560d467a972..2952b27b3f20 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -112,83 +112,26 @@ static void rxe_init_ports(struct rxe_dev *rxe)
 }
 
 /* init pools of managed objects */
-static int rxe_init_pools(struct rxe_dev *rxe)
+static void rxe_init_pools(struct rxe_dev *rxe)
 {
-	int err;
-
-	err = rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC,
-			    rxe->max_ucontext);
-	if (err)
-		goto err1;
-
-	err = rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD,
-			    rxe->attr.max_pd);
-	if (err)
-		goto err2;
-
-	err = rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH,
-			    rxe->attr.max_ah);
-	if (err)
-		goto err3;
-
-	err = rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ,
-			    rxe->attr.max_srq);
-	if (err)
-		goto err4;
-
-	err = rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP,
-			    rxe->attr.max_qp);
-	if (err)
-		goto err5;
-
-	err = rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ,
-			    rxe->attr.max_cq);
-	if (err)
-		goto err6;
-
-	err = rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR,
-			    rxe->attr.max_mr);
-	if (err)
-		goto err7;
-
-	err = rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW,
-			    rxe->attr.max_mw);
-	if (err)
-		goto err8;
-
-	return 0;
-
-err8:
-	rxe_pool_cleanup(&rxe->mr_pool);
-err7:
-	rxe_pool_cleanup(&rxe->cq_pool);
-err6:
-	rxe_pool_cleanup(&rxe->qp_pool);
-err5:
-	rxe_pool_cleanup(&rxe->srq_pool);
-err4:
-	rxe_pool_cleanup(&rxe->ah_pool);
-err3:
-	rxe_pool_cleanup(&rxe->pd_pool);
-err2:
-	rxe_pool_cleanup(&rxe->uc_pool);
-err1:
-	return err;
+	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC, rxe->max_ucontext);
+	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD, rxe->attr.max_pd);
+	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH, rxe->attr.max_ah);
+	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ, rxe->attr.max_srq);
+	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP, rxe->attr.max_qp);
+	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ, rxe->attr.max_cq);
+	rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR, rxe->attr.max_mr);
+	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW, rxe->attr.max_mw);
 }
 
 /* initialize rxe device state */
-static int rxe_init(struct rxe_dev *rxe)
+static void rxe_init(struct rxe_dev *rxe)
 {
-	int err;
-
 	/* init default device parameters */
 	rxe_init_device_param(rxe);
 
 	rxe_init_ports(rxe);
-
-	err = rxe_init_pools(rxe);
-	if (err)
-		return err;
+	rxe_init_pools(rxe);
 
 	spin_lock_init(&rxe->mcg_lock);
 	rxe->mcg_tree = RB_ROOT;
@@ -199,8 +142,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
 	mutex_init(&rxe->usdev_lock);
-
-	return 0;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
@@ -222,11 +163,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
  */
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 {
-	int err;
-
-	err = rxe_init(rxe);
-	if (err)
-		return err;
+	rxe_init(rxe);
 
 	rxe_set_mtu(rxe, mtu);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 453ef3c9d535..35628b8a00b4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -691,7 +691,6 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 32dd8c0b8b9e..3ae981d77c25 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -20,7 +20,6 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		return ret;
 	}
 
-	rxe_add_index(mw);
 	mw->rkey = ibmw->rkey = (mw->elem.index << 8) | rxe_get_next_key(-1);
 	mw->state = (mw->ibmw.type == IB_MW_TYPE_2) ?
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
@@ -332,7 +331,4 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 
 void rxe_mw_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mw *mw = container_of(elem, typeof(*mw), elem);
-
-	rxe_drop_index(mw);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4e558d5e0ded..14c67e2a0904 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/refcount.h>
 #include "rxe.h"
 
 #define RXE_POOL_ALIGN		(16)
@@ -23,19 +24,17 @@ static const struct rxe_type_info {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
-		.flags          = RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
-		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -43,7 +42,7 @@ static const struct rxe_type_info {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -52,7 +51,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -60,7 +59,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
-		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
@@ -68,7 +66,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 	},
@@ -77,43 +75,16 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
 };
 
-static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
-{
-	int err = 0;
-
-	if ((max - min + 1) < pool->max_elem) {
-		pr_warn("not enough indices for max_elem\n");
-		err = -EINVAL;
-		goto out;
-	}
-
-	pool->index.max_index = max;
-	pool->index.min_index = min;
-
-	pool->index.table = bitmap_zalloc(max - min + 1, GFP_KERNEL);
-	if (!pool->index.table) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-out:
-	return err;
-}
-
-int rxe_pool_init(
-	struct rxe_dev		*rxe,
-	struct rxe_pool		*pool,
-	enum rxe_elem_type	type,
-	unsigned int		max_elem)
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+		   enum rxe_elem_type type, unsigned int max_elem)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
-	int			err = 0;
 
 	memset(pool, 0, sizeof(*pool));
 
@@ -128,148 +99,69 @@ int rxe_pool_init(
 
 	atomic_set(&pool->num_elem, 0);
 
-	rwlock_init(&pool->pool_lock);
-
-	if (pool->flags & RXE_POOL_INDEX) {
-		pool->index.tree = RB_ROOT;
-		err = rxe_pool_init_index(pool, info->max_index,
-					  info->min_index);
-		if (err)
-			goto out;
-	}
-
-out:
-	return err;
+	/* used for pools with RXE_POOL_INDEX and
+	 * the xa spinlock for other pools
+	 */
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+	pool->limit.max = info->max_index;
+	pool->limit.min = info->min_index;
 }
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
+	struct rxe_pool_elem *elem;
+
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool->name);
 
-	if (pool->flags & RXE_POOL_INDEX)
-		bitmap_free(pool->index.table);
-}
-
-static u32 alloc_index(struct rxe_pool *pool)
-{
-	u32 index;
-	u32 range = pool->index.max_index - pool->index.min_index + 1;
-
-	index = find_next_zero_bit(pool->index.table, range, pool->index.last);
-	if (index >= range)
-		index = find_first_zero_bit(pool->index.table, range);
-
-	WARN_ON_ONCE(index >= range);
-	set_bit(index, pool->index.table);
-	pool->index.last = index;
-	return index + pool->index.min_index;
-}
-
-static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
-{
-	struct rb_node **link = &pool->index.tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct rxe_pool_elem *elem;
-
-	while (*link) {
-		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_elem, index_node);
-
-		if (elem->index == new->index) {
-			pr_warn("element already exists!\n");
-			return -EINVAL;
-		}
-
-		if (elem->index > new->index)
-			link = &(*link)->rb_left;
-		else
-			link = &(*link)->rb_right;
+	if (pool->flags & RXE_POOL_INDEX) {
+		unsigned long index = 0;
+		unsigned long max = ULONG_MAX;
+		unsigned int elem_count = 0;
+		unsigned int free_count = 0;
+
+		do {
+			elem = xa_find(&pool->xa, &index, max, XA_PRESENT);
+			if (elem) {
+				elem_count++;
+				xa_erase(&pool->xa, index);
+				if (pool->flags & RXE_POOL_ALLOC) {
+					kfree(elem->obj);
+					free_count++;
+				}
+			}
+
+		} while (elem);
+
+		if (elem_count || free_count)
+			pr_warn("Freed %d indices, %d objects\n",
+				elem_count, free_count);
 	}
 
-	rb_link_node(&new->index_node, parent, link);
-	rb_insert_color(&new->index_node, &pool->index.tree);
-
-	return 0;
-}
-
-int __rxe_add_index_locked(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	elem->index = alloc_index(pool);
-	err = rxe_insert_index(pool, elem);
-
-	return err;
-}
-
-int __rxe_add_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	write_lock_bh(&pool->pool_lock);
-	err = __rxe_add_index_locked(elem);
-	write_unlock_bh(&pool->pool_lock);
-
-	return err;
-}
-
-void __rxe_drop_index_locked(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
-}
-
-void __rxe_drop_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	write_lock_bh(&pool->pool_lock);
-	__rxe_drop_index_locked(elem);
-	write_unlock_bh(&pool->pool_lock);
-}
-
-void *rxe_alloc_locked(struct rxe_pool *pool)
-{
-	struct rxe_pool_elem *elem;
-	void *obj;
-
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
-
-	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
-	if (!obj)
-		goto out_cnt;
-
-	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
-
-	elem->pool = pool;
-	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
-
-	return obj;
-
-out_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
+	xa_destroy(&pool->xa);
 }
 
+/**
+ * rxe_alloc() - create a new rxe object
+ * @pool: rxe object pool
+ *
+ * Adds a new object to object pool allocating the storage here.
+ * If object pool has an index add elem to xarray.
+ *
+ * Returns: the object on success else NULL
+ */
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_cnt;
 
 	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
-		goto out_cnt;
+		goto err_cnt;
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
@@ -277,40 +169,117 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		int err = xa_alloc_cyclic_bh(&pool->xa, &elem->index,
+					     elem, pool->limit,
+					     &pool->next, GFP_KERNEL);
+		if (err)
+			goto err_free;
+	}
+
 	return obj;
 
-out_cnt:
+err_free:
+	kfree(obj);
+err_cnt:
 	atomic_dec(&pool->num_elem);
 	return NULL;
 }
 
+/**
+ * __rxe_add_to_pool() - add pool element to object pool
+ * @pool: rxe object pool
+ * @elem: a pool element embedded in a rxe object
+ *
+ * Adds a rxe pool element to object pool when the storage is
+ * allocated by rdma/core before calling the verb that creates
+ * the object. If object pool has an index add elem to xarray.
+ *
+ * The rxe_add_to_pool() macro converts the 2nd argument from
+ * an object to a pool element embedded in the object.
+ *
+ * Returns: 0 on success else an error
+ */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_cnt;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		int err = xa_alloc_cyclic_bh(&pool->xa, &elem->index,
+					     elem, pool->limit,
+					     &pool->next, GFP_KERNEL);
+		if (err)
+			goto err_cnt;
+	}
+
 	return 0;
 
-out_cnt:
+err_cnt:
 	atomic_dec(&pool->num_elem);
 	return -EINVAL;
 }
 
-void rxe_elem_release(struct kref *kref)
+/**
+ * rxe_pool_get_index - lookup object from index
+ * @pool: the object pool
+ * @index: the index of the object
+ *
+ * Acquire the xa spinlock to make looking up the object from
+ * its index atomic with the call to kref_get_unless_zero() to avoid
+ * a race condition with a second thread deleting the object
+ * before we can acquire the reference.
+ *
+ * Returns: the object if the index exists in the pool
+ * and the reference count on the object is positive
+ * else NULL
+ */
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+{
+	struct rxe_pool_elem *elem;
+	void *obj;
+
+	xa_lock_bh(&pool->xa);
+	elem = xa_load(&pool->xa, index);
+	if (elem && kref_get_unless_zero(&elem->ref_cnt))
+		obj = elem->obj;
+	else
+		obj = NULL;
+	xa_unlock_bh(&pool->xa);
+
+	return obj;
+}
+
+/**
+ * rxe_elem_release() - cleanup object
+ * @kref: pointer to kref embedded in pool element
+ *
+ * The kref_put_lock() call in rxe_drop_ref() takes the
+ * xa spinlock if the ref count goes to zero which is then
+ * released here after removing the xarray entry to prevent
+ * overlapping with rxe_get_index().
+ */
+static void rxe_elem_release(struct kref *kref)
+	__releases(&pool->xa.xa_lock)
 {
 	struct rxe_pool_elem *elem =
 		container_of(kref, struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
 	void *obj;
 
+	if (pool->flags & RXE_POOL_INDEX)
+		__xa_erase(&pool->xa, elem->index);
+
+	xa_unlock_bh(&pool->xa);
+
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
+	if (pool->flags & RXE_POOL_ALLOC) {
 		obj = elem->obj;
 		kfree(obj);
 	}
@@ -318,42 +287,60 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
+/**
+ * __rxe_add_ref() - takes a ref on pool element
+ * @elem: pool element
+ *
+ * Takes a ref on pool element if count is not zero
+ *
+ * The rxe_add_ref() macro converts argument from object to pool element
+ *
+ * Returns 1 if successful else 0
+ */
+int __rxe_add_ref(struct rxe_pool_elem *elem)
 {
-	struct rb_node *node;
-	struct rxe_pool_elem *elem;
-	void *obj;
-
-	node = pool->index.tree.rb_node;
-
-	while (node) {
-		elem = rb_entry(node, struct rxe_pool_elem, index_node);
+	return kref_get_unless_zero(&elem->ref_cnt);
+}
 
-		if (elem->index > index)
-			node = node->rb_left;
-		else if (elem->index < index)
-			node = node->rb_right;
-		else
-			break;
-	}
+static bool refcount_dec_and_lock_bh(refcount_t *r, spinlock_t *lock)
+	__acquires(lock) __releases(lock)
+{
+	if (refcount_dec_not_one(r))
+		return false;
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
-		obj = elem->obj;
-	} else {
-		obj = NULL;
+	spin_lock_bh(lock);
+	if (!refcount_dec_and_test(r)) {
+		spin_unlock_bh(lock);
+		return false;
 	}
 
-	return obj;
+	return true;
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+static int kref_put_lock_bh(struct kref *kref,
+				void (*release)(struct kref *kref),
+				spinlock_t *lock)
 {
-	void *obj;
-
-	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_index_locked(pool, index);
-	read_unlock_bh(&pool->pool_lock);
+	if (refcount_dec_and_lock_bh(&kref->refcount, lock)) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
 
-	return obj;
+/**
+ * __rxe_drop_ref() - drops a ref on pool element
+ * @elem: pool element
+ *
+ * Drops a ref on pool element and if count goes to zero atomically
+ * acquires the xa lock and then calls rxe_elem_release() holding the lock
+ *
+ * The rxe_drop_ref() macro converts argument from object to pool element
+ *
+ * Returns 1 if rxe_elem_release called else 0
+ */
+int __rxe_drop_ref(struct rxe_pool_elem *elem)
+{
+	return kref_put_lock_bh(&elem->ref_cnt, rxe_elem_release,
+			    &elem->pool->xa.xa_lock);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b6de415e10d2..0ff5e1d8b935 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,9 +7,11 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
 
+#include <linux/xarray.h>
+
 enum rxe_pool_flags {
 	RXE_POOL_INDEX		= BIT(1),
-	RXE_POOL_NO_ALLOC	= BIT(4),
+	RXE_POOL_ALLOC		= BIT(2),
 };
 
 enum rxe_elem_type {
@@ -30,16 +32,12 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
-
-	/* only used if indexed */
-	struct rb_node		index_node;
 	u32			index;
 };
 
 struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
-	rwlock_t		pool_lock; /* protects pool add/del/search */
 	void			(*cleanup)(struct rxe_pool_elem *obj);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
@@ -48,73 +46,31 @@ struct rxe_pool {
 	atomic_t		num_elem;
 	size_t			elem_size;
 	size_t			elem_offset;
-
-	/* only used if indexed */
-	struct {
-		struct rb_root		tree;
-		unsigned long		*table;
-		u32			last;
-		u32			max_index;
-		u32			min_index;
-	} index;
+	struct xarray		xa;
+	struct xa_limit		limit;
+	u32			next;
+	int			locked;
 };
 
-/* initialize a pool of objects with given limit on
- * number of elements. gets parameters from rxe_type_info
- * pool elements will be allocated out of a slab cache
- */
-int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
-		  enum rxe_elem_type type, u32 max_elem);
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+		   enum rxe_elem_type type, u32 max_elem);
 
-/* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool holding and not holding the pool lock */
-void *rxe_alloc_locked(struct rxe_pool *pool);
-
 void *rxe_alloc(struct rxe_pool *pool);
 
-/* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
-/* assign an index to an indexed object and insert object into
- *  pool's rb tree holding and not holding the pool_lock
- */
-int __rxe_add_index_locked(struct rxe_pool_elem *elem);
-
-#define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->elem)
-
-int __rxe_add_index(struct rxe_pool_elem *elem);
-
-#define rxe_add_index(obj) __rxe_add_index(&(obj)->elem)
-
-/* drop an index and remove object from rb tree
- * holding and not holding the pool_lock
- */
-void __rxe_drop_index_locked(struct rxe_pool_elem *elem);
-
-#define rxe_drop_index_locked(obj) __rxe_drop_index_locked(&(obj)->elem)
-
-void __rxe_drop_index(struct rxe_pool_elem *elem);
-
-#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->elem)
-
-/* lookup an indexed object from index holding and not holding the pool_lock.
- * takes a reference on object
- */
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index);
-
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
+int __rxe_add_ref(struct rxe_pool_elem *elem);
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
-/* take a reference on an object */
-#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
+int __rxe_drop_ref(struct rxe_pool_elem *elem);
 
-/* drop a reference on an object */
-#define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
+#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f7682541f9af..bc3094d851f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -181,7 +181,6 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		return err;
 
 	/* create index > 0 */
-	rxe_add_index(ah);
 	ah->ah_num = ah->elem.index;
 
 	if (uresp) {
@@ -189,7 +188,6 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_drop_index(ah);
 			rxe_drop_ref(ah);
 			return -EFAULT;
 		}
@@ -230,7 +228,6 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_drop_index(ah);
 	rxe_drop_ref(ah);
 	return 0;
 }
@@ -437,7 +434,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		return err;
 
-	rxe_add_index(qp);
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
 	if (err)
 		goto qp_init;
@@ -445,7 +441,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return err;
 }
@@ -495,7 +490,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return 0;
 }
@@ -898,7 +892,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_index(mr);
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
@@ -922,7 +915,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
 
 	rxe_add_ref(pd);
 
@@ -934,7 +926,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
@@ -957,8 +948,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
@@ -969,7 +958,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.32.0

