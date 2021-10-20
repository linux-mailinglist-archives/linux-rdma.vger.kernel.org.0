Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F174355B7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhJTWJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhJTWJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E26C061755
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:31 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so9950699otq.12
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgyveUkEe5u5puSO4RzEPy3L3LnUJeIaV2h+HvJ3SmE=;
        b=dG4lbTVNvGWMHO9Y7AYXUBn98aQYhsJgepy79mDUXMJenUzryiEkgdsxZqsyr/LME8
         vqy1xesA7SiWBWmnS+YcCAZZ4lDqjxrGD+0naw5sO1Nmqdw5oMpQaVw3Ku9Tvl8z4J2S
         Ip2e3l6ZjIuEjHP30F6Yv4ne312tRuAXAVe/V9Tpr6gCa1jq2aSS+cXPJ5p9jPW/fL5u
         R4DjRsXfIf16GYRkBzBXNOc1yEFTgVYZofMCO2c9wNykjroUTOnXf2BZdq0nUpMum2jf
         8m64Tur3547gbmbzAJtdWnoWbCaVQPammBOCfkynQ5wXMWjITSFhBfkYNQBuyH5NeRSW
         G2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgyveUkEe5u5puSO4RzEPy3L3LnUJeIaV2h+HvJ3SmE=;
        b=ZTmpmpy7eqL/HKf6Cwq4ecnW98P+8nzyqtvCkUb0mdlHkfpkd1AwNEypQfH+7Eq0QW
         CcNHneg8AHczmg9KFKpEEXM0gbeQlY4V+iMwrEbqlQHUtN/3eUCdroOTch9QWQJSU23b
         yPShKHe9JDITlejS39ESi+E0bhVXUNF/Iw2c8QZ+z03M4+yUVPTY81wMItnhfuG/6S8j
         857zBXel79DqAAGolekuApZ4u/2497wlRQ9P/nasf8sRCNcLmoj89DHCTUwm/YX6HcFI
         pfUcYHmLEY3gEWU58ouDAT6iMOM7qJ9qnoEfMU4gpeZLedOqRLI/QA3FPj/ABtqkOkfe
         hR1A==
X-Gm-Message-State: AOAM533Em4rs1j3TIydqLQhC4mmWLHzTZWLnQezKVu1W6nHvWY+y2Oau
        FAjcupTvHH3bbB/nVYBoDv49uBb/9lk=
X-Google-Smtp-Source: ABdhPJzVlMdLBN+G7SEtugrIaUuYhzcOOnJweEnHBQSlWMUTbi2UbYnLdEk9/n6NT7CHT3goxRPXkg==
X-Received: by 2002:a05:6830:1d85:: with SMTP id y5mr1539571oti.316.1634767650800;
        Wed, 20 Oct 2021 15:07:30 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/7] RDMA/rxe: Remove old index code from rxe_pool.c
Date:   Wed, 20 Oct 2021 17:05:49 -0500
Message-Id: <20211020220549.36145-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020220549.36145-1-rpearsonhpe@gmail.com>
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove all red-black tree based index code from rxe_pool.c.
Change some functions from int to void as errors are no longer returned.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  86 ++------------
 drivers/infiniband/sw/rxe/rxe_pool.c | 171 +--------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  14 +--
 3 files changed, 15 insertions(+), 256 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 4298a1d20ad5..804c5630ed55 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -115,90 +115,37 @@ static void rxe_init_ports(struct rxe_dev *rxe)
 }
 
 /* init pools of managed objects */
-static int rxe_init_pools(struct rxe_dev *rxe)
+static void rxe_init_pools(struct rxe_dev *rxe)
 {
-	int err;
-
-	err = rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC,
+	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC,
 			    rxe->max_ucontext);
-	if (err)
-		goto err1;
-
-	err = rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD,
+	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD,
 			    rxe->attr.max_pd);
-	if (err)
-		goto err2;
-
-	err = rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH,
+	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH,
 			    rxe->attr.max_ah);
-	if (err)
-		goto err3;
-
-	err = rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ,
+	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ,
 			    rxe->attr.max_srq);
-	if (err)
-		goto err4;
-
-	err = rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP,
+	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP,
 			    rxe->attr.max_qp);
-	if (err)
-		goto err5;
-
-	err = rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ,
+	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ,
 			    rxe->attr.max_cq);
-	if (err)
-		goto err6;
-
-	err = rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR,
+	rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR,
 			    rxe->attr.max_mr);
-	if (err)
-		goto err7;
-
-	err = rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW,
+	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW,
 			    rxe->attr.max_mw);
-	if (err)
-		goto err8;
-
-	err = rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
+	rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
 			    rxe->attr.max_mcast_grp);
-	if (err)
-		goto err9;
-
-	return 0;
-
-err9:
-	rxe_pool_cleanup(&rxe->mw_pool);
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
 
-	err = rxe_init_pools(rxe);
-	if (err)
-		return err;
+	rxe_init_pools(rxe);
 
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
@@ -206,8 +153,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
 	mutex_init(&rxe->usdev_lock);
-
-	return 0;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
@@ -229,12 +174,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
  */
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
 {
-	int err;
-
-	err = rxe_init(rxe);
-	if (err)
-		return err;
-
+	rxe_init(rxe);
 	rxe_set_mtu(rxe, mtu);
 
 	return rxe_register_device(rxe, ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 364449c284a3..6e51483c0494 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -82,42 +82,13 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	},
 };
 
-static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
-{
-	int err = 0;
-	size_t size;
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
-	size = BITS_TO_LONGS(max - min + 1) * sizeof(long);
-	pool->index.table = kmalloc(size, GFP_KERNEL);
-	if (!pool->index.table) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	pool->index.table_size = size;
-	bitmap_zero(pool->index.table, max - min + 1);
-
-out:
-	return err;
-}
-
-int rxe_pool_init(
+void rxe_pool_init(
 	struct rxe_dev		*rxe,
 	struct rxe_pool		*pool,
 	enum rxe_elem_type	type,
 	unsigned int		max_elem)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
-	int			err = 0;
 
 	memset(pool, 0, sizeof(*pool));
 
@@ -138,22 +109,11 @@ int rxe_pool_init(
 		pool->xarray.limit.min = info->min_index;
 	}
 
-	if (info->flags & RXE_POOL_INDEX) {
-		pool->index.tree = RB_ROOT;
-		err = rxe_pool_init_index(pool, info->max_index,
-					  info->min_index);
-		if (err)
-			goto out;
-	}
-
 	if (info->flags & RXE_POOL_KEY) {
 		pool->key.tree = RB_ROOT;
 		pool->key.key_offset = info->key_offset;
 		pool->key.key_size = info->key_size;
 	}
-
-out:
-	return err;
 }
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
@@ -161,59 +121,6 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool->name);
-
-	if (pool->flags & RXE_POOL_INDEX)
-		kfree(pool->index.table);
-}
-
-/* should never fail because there are at least as many indices as
- * max objects
- */
-static u32 alloc_index(struct rxe_pool *pool)
-{
-	u32 index;
-	u32 range = pool->index.max_index - pool->index.min_index + 1;
-
-	index = find_next_zero_bit(pool->index.table, range,
-				   pool->index.last);
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
-		/* this can happen if memory was recycled and/or the
-		 * old object was not deleted from the pool index
-		 */
-		if (unlikely(elem == new || elem->index == new->index)) {
-			pr_warn("%s#%d: already in pool\n", pool->name,
-					new->index);
-			return -EINVAL;
-		}
-
-		if (elem->index > new->index)
-			link = &(*link)->rb_left;
-		else
-			link = &(*link)->rb_right;
-	}
-
-	rb_link_node(&new->index_node, parent, link);
-	rb_insert_color(&new->index_node, &pool->index.tree);
-
-	return 0;
 }
 
 static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
@@ -248,28 +155,6 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
 	return 0;
 }
 
-static int rxe_add_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	elem->index = alloc_index(pool);
-	err = rxe_insert_index(pool, elem);
-	if (err)
-		clear_bit(elem->index - pool->index.min_index,
-			  pool->index.table);
-
-	return err;
-}
-
-static void rxe_drop_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
-}
-
 static void *__rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
@@ -296,12 +181,6 @@ static void *__rxe_alloc_locked(struct rxe_pool *pool)
 			goto err;
 	}
 
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = rxe_add_index(elem);
-		if (err)
-			goto err;
-	}
-
 	return obj;
 
 err:
@@ -393,12 +272,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 			goto err;
 	}
 
-	if (pool->flags & RXE_POOL_INDEX) {
-		err = rxe_add_index(elem);
-		if (err)
-			goto err;
-	}
-
 	refcount_set(&elem->refcnt, 1);
 	xa_unlock_bh(&pool->xarray.xa);
 
@@ -410,42 +283,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	return -EINVAL;
 }
 
-static void *__rxe_get_index_locked(struct rxe_pool *pool, u32 index)
-{
-	struct rb_node *node;
-	struct rxe_pool_elem *elem;
-	void *obj = NULL;
-
-	node = pool->index.tree.rb_node;
-
-	while (node) {
-		elem = rb_entry(node, struct rxe_pool_elem, index_node);
-
-		if (elem->index > index)
-			node = node->rb_left;
-		else if (elem->index < index)
-			node = node->rb_right;
-		else
-			break;
-	}
-
-	if (node && refcount_inc_not_zero(&elem->refcnt))
-		obj = elem->obj;
-
-	return obj;
-}
-
-static void *__rxe_get_index(struct rxe_pool *pool, u32 index)
-{
-	void *obj;
-
-	xa_lock_bh(&pool->xarray.xa);
-	obj = __rxe_get_index_locked(pool, index);
-	xa_unlock_bh(&pool->xarray.xa);
-
-	return obj;
-}
-
 static void *__rxe_get_xarray_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
@@ -473,8 +310,6 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	if (pool->flags & RXE_POOL_XARRAY)
 		return __rxe_get_xarray_locked(pool, index);
-	if (pool->flags & RXE_POOL_INDEX)
-		return __rxe_get_index_locked(pool, index);
 	return NULL;
 }
 
@@ -482,8 +317,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	if (pool->flags & RXE_POOL_XARRAY)
 		return __rxe_get_xarray(pool, index);
-	if (pool->flags & RXE_POOL_INDEX)
-		return __rxe_get_index(pool, index);
 	return NULL;
 }
 
@@ -582,8 +415,6 @@ static int __rxe_fini(struct rxe_pool_elem *elem)
 	if (done) {
 		if (pool->flags & RXE_POOL_XARRAY)
 			__xa_erase(&pool->xarray.xa, elem->index);
-		if (pool->flags & RXE_POOL_INDEX)
-			rxe_drop_index(elem);
 		if (pool->flags & RXE_POOL_KEY)
 			rb_erase(&elem->key_node, &pool->key.tree);
 		atomic_dec(&pool->num_elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index f9c4f09cdcc9..191e5aea454f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -14,7 +14,6 @@
 #define RXE_POOL_CACHE_FLAGS	(0)
 
 enum rxe_pool_flags {
-	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
 	RXE_POOL_XARRAY		= BIT(3),
 	RXE_POOL_NO_ALLOC	= BIT(4),
@@ -57,7 +56,6 @@ struct rxe_pool_elem {
 	struct rb_node		key_node;
 
 	/* only used if indexed */
-	struct rb_node		index_node;
 	u32			index;
 };
 
@@ -81,16 +79,6 @@ struct rxe_pool {
 		u32			next;
 	} xarray;
 
-	/* only used if indexed */
-	struct {
-		struct rb_root		tree;
-		unsigned long		*table;
-		size_t			table_size;
-		u32			last;
-		u32			max_index;
-		u32			min_index;
-	} index;
-
 	/* only used if keyed */
 	struct {
 		struct rb_root		tree;
@@ -103,7 +91,7 @@ struct rxe_pool {
  * number of elements. gets parameters from rxe_type_info
  * pool elements will be allocated out of a slab cache
  */
-int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		  enum rxe_elem_type type, u32 max_elem);
 
 /* free resources from object pool */
-- 
2.30.2

