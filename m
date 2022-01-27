Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4313049ED96
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbiA0ViX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiA0ViV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:21 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFCDC061748
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:21 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u129so8536996oib.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTVtqibSyCIZK0XHFX37ITeq/GnWKAOVSzdnkqYx3rg=;
        b=Y3OVG0SSMH+lRTciZQmnJ6IdDy+eXHD1IlFyhVpSntwnQxdzt3Dz3IPlr3ngJjkBFk
         G+Wdd5l9rWiufvE32g7puzgXTYZTqOsrnUV6sSA42OqniwOxmEtHL7u3fO+UqTrH7CuM
         STVv5Jjig0ynepeQBZo0d2xIbCpcZulQzuBkc6Pk7HErTYVVgXMyQPv0nAYKYZNKl+e7
         uvw627kol2jdW6sxjE1PbAP/UvJA8V+x/0XbE2V8q1Hroku9bK6w8WqJzyJrR9+AeIL/
         KB7M8gvXEey8FFO/jJwYmq5iywLs2HPMHeWdONB8mnZmAwQKnX2iieOf7saQBhVcC1f3
         bydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTVtqibSyCIZK0XHFX37ITeq/GnWKAOVSzdnkqYx3rg=;
        b=Dv3DDQvj/tf7Och0hVGiOf3yLUA/HaQCGbBbYa7FNXeIbl3IgTavXaaxrMTCUIzDZD
         mv951fHEyW5FkP2+wyoKuCsVmlDUQN4fNwqG2L/FgVMPSPNnlpf1v8fGAp7OaO2c971o
         owklveF5m3qQLRBgiouj6qaClCBbSxa31T1DrGYWTEgS/Q0NO/LQf8tDmtzW/kxT7Jbu
         fK71YYdOLESYTM9oxMmoHZETgnAWqey4/LzpmiCGtmR5eAqmBdc88yicY57/lZTFvkAE
         9O7+PlxBDZUcVoIx4+fWmuFsewMOLsWTNa4TbkexGCqgGHuG12VpYS2Q5BB4eQX7rb10
         lVgw==
X-Gm-Message-State: AOAM530xQ8G+KkZ5aWEdwZovnD2d8hOi5wmMpFPF8tC2mzOGjQbl6OFh
        GHEXigUFaOeWx2Tepvbe5Kk=
X-Google-Smtp-Source: ABdhPJxB6/2dR1eAbVStuoByXyd1w/RzUBEcjrmoU1q+TxCTW080bnTODaFnujDONGylMpF5pZ8GbQ==
X-Received: by 2002:a05:6808:13cb:: with SMTP id d11mr3813909oiw.25.1643319500859;
        Thu, 27 Jan 2022 13:38:20 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:20 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 22/26] RDMA/rxe: Replace red-black trees by xarrays
Date:   Thu, 27 Jan 2022 15:37:51 -0600
Message-Id: <20220127213755.31697-23-rpearsonhpe@gmail.com>
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
red-black trees by xarrays for pool objects.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  86 ++--------
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   8 -
 drivers/infiniband/sw/rxe/rxe_pool.c  | 218 +++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  40 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 --
 6 files changed, 98 insertions(+), 267 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 74c5521e9b3d..de94947df18f 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -114,83 +114,27 @@ static void rxe_init_ports(struct rxe_dev *rxe)
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
 
-	err = rxe_init_pools(rxe);
-	if (err)
-		return err;
+	rxe_init_pools(rxe);
 
 	spin_lock_init(&rxe->mcg_lock);
 	rxe->mcg_tree = RB_ROOT;
@@ -201,8 +145,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
 	mutex_init(&rxe->usdev_lock);
-
-	return 0;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
@@ -224,11 +166,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
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
index 32dd8c0b8b9e..7df36c40eec2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -20,7 +20,6 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		return ret;
 	}
 
-	rxe_add_index(mw);
 	mw->rkey = ibmw->rkey = (mw->elem.index << 8) | rxe_get_next_key(-1);
 	mw->state = (mw->ibmw.type == IB_MW_TYPE_2) ?
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
@@ -329,10 +328,3 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 
 	return mw;
 }
-
-void rxe_mw_cleanup(struct rxe_pool_elem *elem)
-{
-	struct rxe_mw *mw = container_of(elem, typeof(*mw), elem);
-
-	rxe_drop_index(mw);
-}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index a024c3bf8696..928bc56b439f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -21,11 +21,15 @@ static const struct rxe_type_info {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
@@ -57,6 +61,8 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
@@ -71,44 +77,16 @@ static const struct rxe_type_info {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
-		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX,
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
 
@@ -125,110 +103,54 @@ int rxe_pool_init(
 
 	rwlock_init(&pool->pool_lock);
 
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
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+	pool->limit.max = info->max_index;
+	pool->limit.min = info->min_index;
 }
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
-	if (atomic_read(&pool->num_elem) > 0)
-		pr_warn("%s pool destroyed with unfree'd elem\n",
-			pool->name);
-
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
 	struct rxe_pool_elem *elem;
-
-	while (*link) {
-		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_elem, index_node);
-
-		if (elem->index == new->index) {
-			pr_warn("element already exists!\n");
-			return -EINVAL;
+	unsigned long index = 0;
+	unsigned long max = ULONG_MAX;
+	unsigned int elem_count = 0;
+	unsigned int free_count = 0;
+
+	do {
+		elem = xa_find(&pool->xa, &index, max, XA_PRESENT);
+		if (elem) {
+			elem_count++;
+			xa_erase(&pool->xa, index);
+			if (pool->flags & RXE_POOL_ALLOC) {
+				kfree(elem->obj);
+				free_count++;
+			}
 		}
+	} while (elem);
 
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
-}
-
-int __rxe_add_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	write_lock_bh(&pool->pool_lock);
-	elem->index = alloc_index(pool);
-	err = rxe_insert_index(pool, elem);
-	write_unlock_bh(&pool->pool_lock);
-
-	return err;
-}
-
-void __rxe_drop_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	write_lock_bh(&pool->pool_lock);
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
-	write_unlock_bh(&pool->pool_lock);
+	if (elem_count || free_count)
+		pr_warn("Freed %d indices and %d objects from pool %s\n",
+				elem_count, free_count, pool->name);
 }
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
+	int err;
 
 	if (!(pool->flags & RXE_POOL_ALLOC)) {
-		pr_warn_once("%s: Pool %s must call rxe_add_to_pool\n",
+		pr_warn_once("%s: pool %s must call rxe_add_to_pool\n",
 				__func__, pool->name);
 		return NULL;
 	}
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_cnt;
 
 	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
-		goto out_cnt;
+		goto err_cnt;
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
@@ -236,36 +158,66 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	err = xa_alloc_cyclic_bh(&pool->xa, &elem->index, elem, pool->limit,
+			&pool->next, GFP_KERNEL);
+	if (err)
+		goto err_free;
+
 	return obj;
 
-out_cnt:
+err_free:
+	kfree(obj);
+err_cnt:
 	atomic_dec(&pool->num_elem);
 	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
+	int err;
+
 	if (pool->flags & RXE_POOL_ALLOC) {
-		pr_warn_once("%s: Pool %s must call rxe_alloc\n",
+		pr_warn_once("%s: pool %s must call rxe_alloc\n",
 				__func__, pool->name);
 		return -EINVAL;
 	}
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_cnt;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
+	err = xa_alloc_cyclic_bh(&pool->xa, &elem->index, elem, pool->limit,
+			&pool->next, GFP_KERNEL);
+	if (err)
+		goto err_cnt;
+
 	return 0;
 
-out_cnt:
+err_cnt:
 	atomic_dec(&pool->num_elem);
 	return -EINVAL;
 }
 
-void rxe_elem_release(struct kref *kref)
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+{
+	struct rxe_pool_elem *elem;
+	void *obj;
+
+	read_lock_bh(&pool->pool_lock);
+	elem = xa_load(&pool->xa, index);
+	if (elem && kref_get_unless_zero(&elem->ref_cnt))
+		obj = elem->obj;
+	else
+		obj = NULL;
+	read_unlock_bh(&pool->pool_lock);
+
+	return obj;
+}
+
+static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem =
 		container_of(kref, struct rxe_pool_elem, ref_cnt);
@@ -280,36 +232,16 @@ void rxe_elem_release(struct kref *kref)
 		kfree(obj);
 	}
 
+	xa_erase(&pool->xa, elem->index);
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+int __rxe_add_ref(struct rxe_pool_elem *elem)
 {
-	struct rb_node *node;
-	struct rxe_pool_elem *elem;
-	void *obj;
-
-	read_lock_bh(&pool->pool_lock);
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
-	if (node) {
-		kref_get(&elem->ref_cnt);
-		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
-	read_unlock_bh(&pool->pool_lock);
+	return kref_get_unless_zero(&elem->ref_cnt);
+}
 
-	return obj;
+int __rxe_drop_ref(struct rxe_pool_elem *elem)
+{
+	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 3d3470d0e3c8..c985ed519066 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -29,9 +29,6 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
-
-	/* only used if indexed */
-	struct rb_node		index_node;
 	u32			index;
 };
 
@@ -48,21 +45,17 @@ struct rxe_pool {
 	size_t			elem_size;
 	size_t			elem_offset;
 
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
+	int			locked;	/* ?? */
 };
 
 /* initialize a pool of objects with given limit on
  * number of elements. gets parameters from rxe_type_info
  * pool elements will be allocated out of a slab cache
  */
-int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		  enum rxe_elem_type type, u32 max_elem);
 
 /* free resources from object pool */
@@ -76,28 +69,17 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
-/* assign an index to an indexed object and insert object into
- * pool's rb tree
- */
-int __rxe_add_index(struct rxe_pool_elem *elem);
-
-#define rxe_add_index(obj) __rxe_add_index(&(obj)->elem)
-
-/* drop an index and remove object from rb tree */
-void __rxe_drop_index(struct rxe_pool_elem *elem);
-
-#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->elem)
-
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
-
 /* take a reference on an object */
-#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
+int __rxe_add_ref(struct rxe_pool_elem *elem);
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
+int __rxe_drop_ref(struct rxe_pool_elem *elem);
+
+#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9f0aef4b649d..3ca374f1cf9b 100644
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
@@ -500,7 +495,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		return ret;
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return 0;
 }
@@ -903,7 +897,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_index(mr);
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
@@ -927,7 +920,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
 
 	rxe_add_ref(pd);
 
@@ -939,7 +931,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
@@ -962,8 +953,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
@@ -974,7 +963,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.32.0

