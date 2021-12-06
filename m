Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB746A990
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 22:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350395AbhLFVSQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 16:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350425AbhLFVRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 16:17:37 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4688C0698C2
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:14:06 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id m6so23866100oim.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwpwrPOoumsEFx90rh0xREKSytlSaqsCifz9ru66LQk=;
        b=UX9aqbsH0VWAH65YiAy/2Lfl5eNkdLdpFaFHXEKZqRf/Cib67asi0Aj6oc8K8+lTAn
         kJDyPNuFYZ8P0xNk3iOM0jBRPQ8cTGSOIiJP3UKlTjFc5rjgDs65ckVMyqdrdQw37FeS
         g8TR630zdbsxOaWSJD8PhO/Gz2zv5W4Zt+apFw0rt/mI6gXhZCaWk4ekWwRYxGW3vQbq
         fBdZuRNpsy0L32J8yRs/E186taCfNvSvgKOYwffVwnO6oAyRqA3lHQ3syZxPezQLk6wz
         RzHL2uWBQ5EdVflcQU3yZ1N80rRIq8EZ47AgHshbpDc2bkXAA/75xYulUoTByzyXi45x
         vvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwpwrPOoumsEFx90rh0xREKSytlSaqsCifz9ru66LQk=;
        b=HcdwSMIpioGKXzKyReT046XODFhZ4EM2StuKIwN/zABJBGvrWbWMA8MtGgc6brV8AU
         HMUNq+h0PKnLRhXDOqXh6hUI/XICePTBzd5HPi8szgPN37ZQhNkwKniM2SUk7LROjYAg
         QGG4dKSGjjDNivXgB+/cwjSE1mxVIyamRwXxJP5vXPVcauT8STT65BS9c/ST890Azumt
         nwBPwNt8a1/BPGsksWm85DGvFeKfdnJhZJYOt0Qp9MFC4C3aB5Fak8NNCGn/ox31yQWr
         +58nx2DIOCCNzEM+PE6BGfVA/FdPsdln4YMnGeBHiz3Q5l2T64j3lSEUYZ6ZQW1v27c1
         hEHA==
X-Gm-Message-State: AOAM533vjLBhLmdyr8NbzKqit0kqM1G0cd4NBsohmOGb65MLAZqRKLuQ
        5yKDEh956MGFejFMsGpvD4w=
X-Google-Smtp-Source: ABdhPJxv201frne41vFeoi2c0VnNw+p1J4VLgm6FXoN0wdIGX3TRQAGsxHGLSAd+TsG0bCppOAAfww==
X-Received: by 2002:a05:6808:10d0:: with SMTP id s16mr1243158ois.0.1638825245935;
        Mon, 06 Dec 2021 13:14:05 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-07ad-dbeb-c616-747c.res6.spectrum.com. [2603:8081:140c:1a00:7ad:dbeb:c616:747c])
        by smtp.googlemail.com with ESMTPSA id y28sm2819111oix.57.2021.12.06.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:14:05 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 1/8] RDMA/rxe: Replace RB tree by xarray for indexes
Date:   Mon,  6 Dec 2021 15:12:36 -0600
Message-Id: <20211206211242.15528-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206211242.15528-1-rpearsonhpe@gmail.com>
References: <20211206211242.15528-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver uses red-black trees to add indices and keys
to the rxe object pool. Linux xarrays provide a better way to implement
the same functionality for indices but not keys. This patch replaces
red-black trees by xarrays for indexed objects. Since caller managed
locks for indexed objects are not used these APIs are deleted as well.

To avoid double locking since xarray already includes a spinlock replace
the rxe_pool rwlock by the spinlock included in xarray.

The RDMA objects are created and destroyed by verbs calls from rdma_core
but are looked up from indices or keys from soft IRQs so _bh style locks
are the correct type to use.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v6
  Minor fix to comment.
---
 drivers/infiniband/sw/rxe/rxe.c       | 100 ++----------
 drivers/infiniband/sw/rxe/rxe_mcast.c |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   4 -
 drivers/infiniband/sw/rxe/rxe_pool.c  | 221 ++++++++------------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  77 ++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 --
 7 files changed, 114 insertions(+), 307 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..09c73a0d8513 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -116,97 +116,31 @@ static void rxe_init_ports(struct rxe_dev *rxe)
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
-	err = rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
+	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC, rxe->max_ucontext);
+	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD, rxe->attr.max_pd);
+	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH, rxe->attr.max_ah);
+	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ, rxe->attr.max_srq);
+	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP, rxe->attr.max_qp);
+	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ, rxe->attr.max_cq);
+	rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR, rxe->attr.max_mr);
+	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW, rxe->attr.max_mw);
+	rxe_pool_init(rxe, &rxe->mc_grp_pool, RXE_TYPE_MC_GRP,
 			    rxe->attr.max_mcast_grp);
-	if (err)
-		goto err9;
-
-	err = rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
+	rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
 			    rxe->attr.max_total_mcast_qp_attach);
-	if (err)
-		goto err10;
-
-	return 0;
-
-err10:
-	rxe_pool_cleanup(&rxe->mc_grp_pool);
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
@@ -214,8 +148,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
 	mutex_init(&rxe->usdev_lock);
-
-	return 0;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
@@ -237,11 +169,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
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
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index bd1ac88b8700..1692526c5b57 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -44,7 +44,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return -EINVAL;
 
-	write_lock_bh(&pool->pool_lock);
+	rxe_pool_lock_bh(pool);
 
 	grp = rxe_pool_get_key_locked(pool, mgid);
 	if (grp)
@@ -52,13 +52,13 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	grp = create_grp(rxe, pool, mgid);
 	if (IS_ERR(grp)) {
-		write_unlock_bh(&pool->pool_lock);
+		rxe_pool_unlock_bh(pool);
 		err = PTR_ERR(grp);
 		return err;
 	}
 
 done:
-	write_unlock_bh(&pool->pool_lock);
+	rxe_pool_unlock_bh(pool);
 	*grp_p = grp;
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 25c78aade822..3c4390adfb80 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -693,7 +693,6 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
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
index 4cb003885e00..8970115b11ef 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -97,37 +97,13 @@ static const struct rxe_type_info {
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
+void rxe_pool_init(
 	struct rxe_dev		*rxe,
 	struct rxe_pool		*pool,
 	enum rxe_elem_type	type,
 	unsigned int		max_elem)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
-	int			err = 0;
 
 	memset(pool, 0, sizeof(*pool));
 
@@ -142,14 +118,13 @@ int rxe_pool_init(
 
 	atomic_set(&pool->num_elem, 0);
 
-	rwlock_init(&pool->pool_lock);
-
 	if (pool->flags & RXE_POOL_INDEX) {
-		pool->index.tree = RB_ROOT;
-		err = rxe_pool_init_index(pool, info->max_index,
-					  info->min_index);
-		if (err)
-			goto out;
+		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
+		pool->xarray.limit.max = info->max_index;
+		pool->xarray.limit.min = info->min_index;
+	} else {
+		/* if pool not indexed just use xa spin_lock */
+		spin_lock_init(&pool->xarray.xa.xa_lock);
 	}
 
 	if (pool->flags & RXE_POOL_KEY) {
@@ -157,9 +132,6 @@ int rxe_pool_init(
 		pool->key.key_offset = info->key_offset;
 		pool->key.key_size = info->key_size;
 	}
-
-out:
-	return err;
 }
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
@@ -167,51 +139,6 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool->name);
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
-	}
-
-	rb_link_node(&new->index_node, parent, link);
-	rb_insert_color(&new->index_node, &pool->index.tree);
-
-	return 0;
 }
 
 static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
@@ -262,9 +189,9 @@ int __rxe_add_key(struct rxe_pool_elem *elem, void *key)
 	struct rxe_pool *pool = elem->pool;
 	int err;
 
-	write_lock_bh(&pool->pool_lock);
+	rxe_pool_lock_bh(pool);
 	err = __rxe_add_key_locked(elem, key);
-	write_unlock_bh(&pool->pool_lock);
+	rxe_pool_unlock_bh(pool);
 
 	return err;
 }
@@ -280,55 +207,16 @@ void __rxe_drop_key(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
-	write_lock_bh(&pool->pool_lock);
+	rxe_pool_lock_bh(pool);
 	__rxe_drop_key_locked(elem);
-	write_unlock_bh(&pool->pool_lock);
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
+	rxe_pool_unlock_bh(pool);
 }
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
+	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -343,8 +231,18 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+					 pool->xarray.limit,
+					 &pool->xarray.next, GFP_ATOMIC);
+		if (err)
+			goto out_free;
+	}
+
 	return obj;
 
+out_free:
+	kfree(obj);
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	return NULL;
@@ -354,6 +252,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
+	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -368,8 +267,18 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+					 pool->xarray.limit,
+					 &pool->xarray.next, GFP_KERNEL);
+		if (err)
+			goto out_free;
+	}
+
 	return obj;
 
+out_free:
+	kfree(obj);
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	return NULL;
@@ -377,6 +286,8 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
+	int err = -EINVAL;
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -384,11 +295,19 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
+					 pool->xarray.limit,
+					 &pool->xarray.next, GFP_KERNEL);
+		if (err)
+			goto out_cnt;
+	}
+
 	return 0;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	return -EINVAL;
+	return err;
 }
 
 void rxe_elem_release(struct kref *kref)
@@ -398,6 +317,9 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool *pool = elem->pool;
 	void *obj;
 
+	if (pool->flags & RXE_POOL_INDEX)
+		__xa_erase(&pool->xarray.xa, elem->index);
+
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
@@ -409,42 +331,27 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
+/**
+ * rxe_pool_get_index - lookup object from index
+ * @pool: the object pool
+ * @index: the index of the object
+ *
+ * Returns: the object if the index exists in the pool
+ * and the reference count on the object is positive
+ * else NULL
+ */
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
-	struct rb_node *node;
 	struct rxe_pool_elem *elem;
 	void *obj;
 
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
+	rxe_pool_lock_bh(pool);
+	elem = xa_load(&pool->xarray.xa, index);
+	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	} else {
+	else
 		obj = NULL;
-	}
-
-	return obj;
-}
-
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
-{
-	void *obj;
-
-	read_lock_bh(&pool->pool_lock);
-	obj = rxe_pool_get_index_locked(pool, index);
-	read_unlock_bh(&pool->pool_lock);
+	rxe_pool_unlock_bh(pool);
 
 	return obj;
 }
@@ -486,9 +393,9 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
 	void *obj;
 
-	read_lock_bh(&pool->pool_lock);
+	rxe_pool_lock_bh(pool);
 	obj = rxe_pool_get_key_locked(pool, key);
-	read_unlock_bh(&pool->pool_lock);
+	rxe_pool_unlock_bh(pool);
 
 	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 214279310f4d..e84de5f59af1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -37,14 +37,12 @@ struct rxe_pool_elem {
 	struct rb_node		key_node;
 
 	/* only used if indexed */
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
@@ -56,12 +54,10 @@ struct rxe_pool {
 
 	/* only used if indexed */
 	struct {
-		struct rb_root		tree;
-		unsigned long		*table;
-		u32			last;
-		u32			max_index;
-		u32			min_index;
-	} index;
+		struct xarray		xa;
+		struct xa_limit		limit;
+		u32			next;
+	} xarray;
 
 	/* only used if keyed */
 	struct {
@@ -71,11 +67,10 @@ struct rxe_pool {
 	} key;
 };
 
-/* initialize a pool of objects with given limit on
- * number of elements. gets parameters from rxe_type_info
- * pool elements will be allocated out of a slab cache
- */
-int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+#define rxe_pool_lock_bh(pool) xa_lock_bh(&pool->xarray.xa)
+#define rxe_pool_unlock_bh(pool) xa_unlock_bh(&pool->xarray.xa)
+
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		  enum rxe_elem_type type, u32 max_elem);
 
 /* free resources from object pool */
@@ -91,28 +86,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
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
 /* assign a key to a keyed object and insert object into
  * pool's rb tree holding and not holding pool_lock
  */
@@ -133,11 +106,6 @@ void __rxe_drop_key(struct rxe_pool_elem *elem);
 
 #define rxe_drop_key(obj) __rxe_drop_key(&(obj)->elem)
 
-/* lookup an indexed object from index holding and not holding the pool_lock.
- * takes a reference on object
- */
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index);
-
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
 /* lookup keyed object from key holding and not holding the pool_lock.
@@ -150,10 +118,31 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
 
-/* take a reference on an object */
-#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
+/**
+ * __rxe_add_ref() - adds a reference to a pool element
+ * @elem: pool element
+ *
+ * Returns: true if the kref_get succeeds else false
+ */
+static inline bool __rxe_add_ref(struct rxe_pool_elem *elem)
+{
+	return kref_get_unless_zero(&elem->ref_cnt);
+}
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
+
+/* drop a reference to an object */
+static inline bool __rxe_drop_ref(struct rxe_pool_elem *elem)
+{
+	bool ret;
+
+	rxe_pool_lock_bh(elem->pool);
+	ret = kref_put(&elem->ref_cnt, rxe_elem_release);
+	rxe_pool_unlock_bh(elem->pool);
+
+	return ret;
+}
 
-/* drop a reference on an object */
-#define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
+#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 07ca169110bf..e3f64eae088c 100644
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
@@ -490,7 +485,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return 0;
 }
@@ -893,7 +887,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_index(mr);
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
@@ -917,7 +910,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
 
 	rxe_add_ref(pd);
 
@@ -929,7 +921,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
@@ -952,8 +943,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
@@ -964,7 +953,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.32.0

