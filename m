Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC4273378
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgIUUER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUUER (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:17 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154AC061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:16 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id o20so3579411ook.1
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOle5EDgVolusyFyWQIjzJSZO/Rl2MDCZ7vDNXAZnjQ=;
        b=eoAEVg0oojqeZQW76EVk4yZ3IEUW3WPsPq+nZ6iQumbUPXso5Ur3jNOsicJAYFAYqE
         dylMGaa2NbOnpNqDgfKIUF/idNSiP7RoWeiRyMx7J9ogsvWQxcNsMS9qDVpIvqXEzlyt
         cNk1zCMf6LntErO6o1VV5Jw/xTW/KCvtefM/30B1CXIJYLSCPxYu5nLzuSVGwnOv9Y6a
         Dj4qYd7UeTi4a1dckK5lpDIDWfQ9FkFywDXVQmklrqRA/gJPf7Q6WoOUyuUWbakEBp1d
         6uXHAWCRPqUdswoknO6wby8LzmZvMnCgjSg8vgrERpJiN2sY3wjlxnNqDLGSwMitgag+
         julg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOle5EDgVolusyFyWQIjzJSZO/Rl2MDCZ7vDNXAZnjQ=;
        b=sG/DCZZGvxMC6xNavJJed+zVJIkV3z3xcbPe/76F5wkGaRiI4ff1d5YAG/A8OdR6m7
         ghn/atmWaNhdNrZw3IPgLDht6VtpiDuSYRBLLgrcVzf1Za0AuvwknVh0+3v33JItcbSK
         J2y0wwxqvSlfe4wwMkOuzJA2Ynd+cOjEaHGnStYH/ImvTK0nhLWYolZS093uKW1MSV/O
         5gE7tSahJAOHHDPUW0kgii0PpVT+RWBeTmUDVuSGzX4ZvoI7naBo0jalS5u5ivBcW/d3
         X7eCiV54bAJYWie8cyOeztxfgHU+CLOafiDp7aLa1xV5ul2NrsZ0HrE1hZFjordHEGV1
         ZnoQ==
X-Gm-Message-State: AOAM532y6/sh3WnIsa4KywlFsfONOZRhEVU9zJ31Fy3Onl8xI9LgE5Lq
        qCiM0KpZRQ+CqUUuLyFBTGs=
X-Google-Smtp-Source: ABdhPJwsPz/qaHp2GvI+DgED24mFf5cE9LAuqTjls+txo76qAIdSvonSNPWbwbhAi70sXjl4+GBZ3g==
X-Received: by 2002:a4a:e08a:: with SMTP id w10mr731477oos.18.1600718656089;
        Mon, 21 Sep 2020 13:04:16 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id t9sm7654394ood.30.2020.09.21.13.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 10/12] rdma_rxe: Fix pool related bugs
Date:   Mon, 21 Sep 2020 15:03:54 -0500
Message-Id: <20200921200356.8627-11-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921200356.8627-1-rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch does following:
  - Be more careful about type checking in pool APIs.
    Originally each object used in rxe had a pool_entry struct as
    the first member of it's struct. Since then about half have
    it first and the other half have it later in the struct. The
    pool APIs used void * as a hack to avoid type checking. This
    patch changes the APIs so the pool_entry struct is position
    independent. When used a parameter a macro is used to convert
    the object pointer to the entry pointer. The offset of the entry
    is stored for each pool and used to convert the entry address to
    the object address.
  - Provide locked and unlocked versions of the APIs.
    The current code uses a lock in each API to allow atomic
    updates to the pools. But some uses fail to work because they
    combined multiple pool operations and expect them to be
    atomic. As an example doing a lookup to see if a matching object
    exists for a multicast group followed by a create of a new group
    if it does not. By letting the caller take the pool lock and then
    combine unlocked operations this problem is fixed.
  - Replace calls to pool APIs with the typesafe versions.
  - Replaced a few calls to pr_warn with pr_err_once.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  12 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |   4 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |   2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  18 ++-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 216 ++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  75 ++++++---
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |   8 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  10 +-
 10 files changed, 239 insertions(+), 114 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 43394c3f29d4..68b0753ad63f 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -14,21 +14,21 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	int count;
 
 	if (cqe <= 0) {
-		pr_warn("cqe(%d) <= 0\n", cqe);
+		pr_err_once("%s: cqe(%d) <= 0\n", __func__, cqe);
 		goto err1;
 	}
 
 	if (cqe > rxe->attr.max_cqe) {
-		pr_warn("cqe(%d) > max_cqe(%d)\n",
-			cqe, rxe->attr.max_cqe);
+		pr_err_once("%s: cqe(%d) > max_cqe(%d)\n",
+			__func__, cqe, rxe->attr.max_cqe);
 		goto err1;
 	}
 
 	if (cq) {
 		count = queue_count(cq->queue);
 		if (cqe < count) {
-			pr_warn("cqe(%d) < current # elements in queue (%d)",
-				cqe, count);
+			pr_err_once("%s: cqe(%d) < current # elements in queue (%d)",
+				__func__, cqe, count);
 			goto err1;
 		}
 	}
@@ -63,7 +63,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->queue = rxe_queue_init(rxe, &cqe,
 				   sizeof(struct rxe_cqe));
 	if (!cq->queue) {
-		pr_warn("unable to create cq\n");
+		pr_err_once("%s: unable to create cq\n", __func__);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index c02315aed8d1..b09c6594045a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -18,7 +18,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 		goto err1;
 	}
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	grp = rxe_get_key(&rxe->mc_grp_pool, mgid);
 	if (grp)
 		goto done;
 
@@ -98,7 +98,7 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem, *tmp;
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	grp = rxe_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
 		goto err1;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 3a7f814f4b81..0765a3ea1a75 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -385,7 +385,7 @@ static struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 lkey)
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 
-	mr = rxe_pool_get_key(&rxe->mr_pool, &lkey);
+	mr = rxe_get_key(&rxe->mr_pool, &lkey);
 	if (!mr)
 		return NULL;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 50f3152d3b57..c58edf51a119 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -219,8 +219,10 @@ static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	u32 rkey;
 	u32 new_rkey;
 	struct rxe_mw *duplicate_mw;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct rxe_pool *pool = mw->pelem.pool;
+	unsigned long flags;
 
+	write_lock_irqsave(&pool->pool_lock, flags);
 	/* key part of new rkey is provided by user for type 2
 	 * and ibv_bind_mw() for type 1 MWs
 	 * there is a very rare chance that the new rkey will
@@ -229,15 +231,17 @@ static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	 */
 	rkey = mw->ibmw.rkey;
 	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.umw.rkey & 0x000000ff);
-	duplicate_mw = rxe_pool_get_key(&rxe->mw_pool, &new_rkey);
+	duplicate_mw = __get_key(pool, &new_rkey);
 	if (duplicate_mw) {
+		write_unlock_irqrestore(&pool->pool_lock, flags);
 		pr_err_once("new MW key is a duplicate, try another\n");
 		rxe_drop_ref(duplicate_mw);
 		return -EINVAL;
 	}
 
-	rxe_drop_key(mw);
-	rxe_add_key(mw, &new_rkey);
+	drop_key(mw);
+	add_key(mw, &new_rkey);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	mw->access = wqe->wr.wr.umw.access;
 	mw->state = RXE_MEM_STATE_VALID;
@@ -271,16 +275,14 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	unsigned long flags;
 
 	if (qp->is_user) {
-		mw = rxe_pool_get_index(&rxe->mw_pool,
-					wqe->wr.wr.umw.mw_index);
+		mw = rxe_get_index(&rxe->mw_pool, wqe->wr.wr.umw.mw_index);
 		if (!mw) {
 			pr_err_once("mw with index = %d not found\n",
 			wqe->wr.wr.umw.mw_index);
 			ret = -EINVAL;
 			goto err1;
 		}
-		mr = rxe_pool_get_index(&rxe->mr_pool,
-		wqe->wr.wr.umw.mr_index);
+		mr = rxe_get_index(&rxe->mr_pool, wqe->wr.wr.umw.mr_index);
 		if (!mr && wqe->wr.wr.umw.length) {
 			pr_err_once("mr with index = %d not found\n",
 			wqe->wr.wr.umw.mr_index);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4bcb19a7b918..1a079657e8d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -12,21 +12,25 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
+		.elem_offset	= offsetof(struct rxe_ucontext, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
+		.elem_offset	= offsetof(struct rxe_pd, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
+		.elem_offset	= offsetof(struct rxe_ah, pelem),
 		.flags		= RXE_POOL_ATOMIC | RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
+		.elem_offset	= offsetof(struct rxe_srq, pelem),
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
@@ -34,6 +38,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
 		.size		= sizeof(struct rxe_qp),
+		.elem_offset	= offsetof(struct rxe_qp, pelem),
 		.cleanup	= rxe_qp_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
@@ -42,12 +47,14 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
+		.elem_offset	= offsetof(struct rxe_cq, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mr),
+		.elem_offset	= offsetof(struct rxe_mr, pelem),
 		.cleanup	= rxe_mr_cleanup,
 		.flags		= RXE_POOL_INDEX
 				| RXE_POOL_KEY,
@@ -59,6 +66,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
+		.elem_offset	= offsetof(struct rxe_mw, pelem),
 		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX
 				| RXE_POOL_KEY,
@@ -70,6 +78,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
+		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
 		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
@@ -78,6 +87,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_ELEM] = {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
+		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
 		.flags		= RXE_POOL_ATOMIC,
 	},
 };
@@ -241,7 +251,8 @@ static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		elem = rb_entry(parent, struct rxe_pool_entry, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
+			     (u8 *)new + pool->key.key_offset,
+			     pool->key.key_size);
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
@@ -260,70 +271,91 @@ static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return 0;
 }
 
-int rxe_add_key(void *arg, void *key)
+/* add/drop index and key are called through macros */
+int __add_key(struct rxe_pool_entry *elem, void *key)
 {
 	int ret;
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	ret = insert_key(pool, elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return ret;
 }
 
-void rxe_drop_key(void *arg)
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
-	struct rxe_pool_entry *elem = arg;
+	int ret;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	rb_erase(&elem->key_node, &pool->key.tree);
+	ret = __add_key(elem, key);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
 }
 
-void rxe_add_index(void *arg)
+void __drop_key(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
+	rb_erase(&elem->key_node, &pool->key.tree);
+}
+
+
+void __rxe_drop_key(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
+	__drop_key(elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+}
+
+void __add_index(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
 	elem->index = alloc_index(pool);
 	insert_index(pool, elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void rxe_drop_index(void *arg)
+void __rxe_add_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
+	__add_index(elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+}
+
+void __drop_index(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+
 	clear_bit(elem->index - pool->index.min_index, pool->index.table);
 	rb_erase(&elem->index_node, &pool->index.tree);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void *rxe_alloc(struct rxe_pool *pool)
+void __rxe_drop_index(struct rxe_pool_entry *elem)
 {
-	struct rxe_pool_entry *elem;
+	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
+	write_lock_irqsave(&pool->pool_lock, flags);
+	__drop_index(elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+}
+
+int __add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+{
+	if (pool->state != RXE_POOL_STATE_VALID)
+		return -EINVAL;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return NULL;
-	}
 	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	if (!ib_device_try_get(&pool->rxe->ib_dev))
 		goto out_put_pool;
@@ -331,38 +363,39 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	elem = kzalloc(rxe_type_info[pool->type].size,
-				 (pool->flags & RXE_POOL_ATOMIC) ?
-				 GFP_ATOMIC : GFP_KERNEL);
-	if (!elem)
-		goto out_cnt;
-
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
 
-	return elem;
-
+	return 0;
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
 	rxe_pool_put(pool);
-	return NULL;
+	return -EINVAL;
 }
 
-int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
+	int err;
 	unsigned long flags;
 
-	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
+	write_lock_irqsave(&pool->pool_lock, flags);
+	err = __add_to_pool(pool, elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return err;
+}
+
+void *__alloc(struct rxe_pool *pool)
+{
+	void *obj;
+	struct rxe_pool_entry *elem;
+
+	if (pool->state != RXE_POOL_STATE_VALID)
+		return NULL;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return -EINVAL;
-	}
 	kref_get(&pool->ref_cnt);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	if (!ib_device_try_get(&pool->rxe->ib_dev))
 		goto out_put_pool;
@@ -370,17 +403,52 @@ int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
+	obj = kzalloc(rxe_type_info[pool->type].size, GFP_ATOMIC);
+	if (!obj)
+		goto out_cnt;
+
+	elem = (struct rxe_pool_entry *)((u8 *)obj +
+			rxe_type_info[pool->type].elem_offset);
+
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
 
-	return 0;
+	return obj;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 out_put_pool:
 	rxe_pool_put(pool);
-	return -EINVAL;
+	return NULL;
+}
+
+void *rxe_alloc(struct rxe_pool *pool)
+{
+	void *obj;
+	struct rxe_pool_entry *elem;
+	unsigned long flags;
+	int err;
+
+	/* allocate object outside of lock in case it sleeps */
+	obj = kzalloc(rxe_type_info[pool->type].size,
+			(pool->flags & RXE_POOL_ATOMIC) ?
+			GFP_ATOMIC : GFP_KERNEL);
+	if (!obj)
+		goto out;
+
+	elem = (struct rxe_pool_entry *)((u8 *)obj +
+			rxe_type_info[pool->type].elem_offset);
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	err = __add_to_pool(pool, elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+	if (err) {
+		kfree(obj);
+		obj = NULL;
+	}
+out:
+	return obj;
 }
 
 void rxe_elem_release(struct kref *kref)
@@ -394,21 +462,20 @@ void rxe_elem_release(struct kref *kref)
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC))
 		kfree(elem);
+
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 	rxe_pool_put(pool);
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+void *__get_index(struct rxe_pool *pool, u32 index)
 {
-	struct rb_node *node = NULL;
+	struct rb_node *node;
 	struct rxe_pool_entry *elem = NULL;
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
+	void *obj;
 
 	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
+		return NULL;
 
 	node = pool->index.tree.rb_node;
 
@@ -425,22 +492,32 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 		}
 	}
 
-out:
-	read_unlock_irqrestore(&pool->pool_lock, flags);
-	return node ? elem : NULL;
+	obj = (u8 *)elem - rxe_type_info[pool->type].elem_offset;
+
+	return node ? obj : NULL;
 }
 
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
+void *rxe_get_index(struct rxe_pool *pool, u32 index)
 {
-	struct rb_node *node = NULL;
-	struct rxe_pool_entry *elem = NULL;
-	int cmp;
+	void *obj;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = __get_index(pool, index);
+	read_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return obj;
+}
+
+void *__get_key(struct rxe_pool *pool, void *key)
+{
+	struct rb_node *node;
+	struct rxe_pool_entry *elem = NULL;
+	int cmp;
+	void *obj;
 
 	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
+		return NULL;
 
 	node = pool->key.tree.rb_node;
 
@@ -450,18 +527,29 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
 			     key, pool->key.key_size);
 
-		if (cmp > 0)
+		if (cmp > 0) {
 			node = node->rb_left;
-		else if (cmp < 0)
+		} else if (cmp < 0) {
 			node = node->rb_right;
-		else
+		} else {
+			kref_get(&elem->ref_cnt);
 			break;
+		}
 	}
 
-	if (node)
-		kref_get(&elem->ref_cnt);
+	obj = (u8 *)elem - rxe_type_info[pool->type].elem_offset;
 
-out:
+	return node ? obj : NULL;
+}
+
+void *rxe_get_key(struct rxe_pool *pool, void *key)
+{
+	void *obj;
+	unsigned long flags;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	obj = __get_key(pool, key);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
-	return node ? elem : NULL;
+
+	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 5be975e3d5d3..446880026805 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -36,6 +36,7 @@ struct rxe_pool_entry;
 struct rxe_type_info {
 	const char		*name;
 	size_t			size;
+	size_t			elem_offset;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_flags	flags;
 	u32			max_index;
@@ -105,35 +106,69 @@ int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
-void *rxe_alloc(struct rxe_pool *pool);
+/* in the following rxe_xxx() take pool->pool_lock
+ * and xxx() do not. Sequences of xxx() calls should be
+ * protected by taking the pool->pool_lock by caller
+ */
+void __add_index(struct rxe_pool_entry *elem);
 
-/* connect already allocated object to pool */
-int rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+#define add_index(obj) __add_index(&(obj)->pelem)
 
-/* assign an index to an indexed object and insert object into
- *  pool's rb tree
- */
-void rxe_add_index(void *elem);
+void __rxe_add_index(struct rxe_pool_entry *elem);
+
+#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
+
+void __drop_index(struct rxe_pool_entry *elem);
+
+#define drop_index(obj) __drop_index(&(obj)->pelem)
+
+void __rxe_drop_index(struct rxe_pool_entry *elem);
+
+#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
+
+int __add_key(struct rxe_pool_entry *elem, void *key);
+
+#define add_key(obj, key) __add_key(&(obj)->pelem, key)
+
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
-/* drop an index and remove object from rb tree */
-void rxe_drop_index(void *elem);
+#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
-/* assign a key to a keyed object and insert object into
- *  pool's rb tree
+void __drop_key(struct rxe_pool_entry *elem);
+
+#define drop_key(obj) __drop_key(&(obj)->pelem)
+
+void __rxe_drop_key(struct rxe_pool_entry *elem);
+
+#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
+
+int __add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+
+#define add_to_pool(pool, obj) __add_to_pool(pool, &(obj)->pelem)
+
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
+
+/* the following routines allocate new objects or
+ * lookup objects from an index or key and return
+ * the address if found. the rxe_XXX() routines take the
+ * pool->pool_lock the __xxx() do not. Sequences of
+ * unprotected pool operations should be protected by
+ * taking the pool->pool_lock by the caller
  */
-int rxe_add_key(void *elem, void *key);
+void *__alloc(struct rxe_pool *pool);
+
+void *rxe_alloc(struct rxe_pool *pool);
+
+void *__get_index(struct rxe_pool *pool, u32 index);
 
-/* remove elem from rb tree */
-void rxe_drop_key(void *elem);
+void *rxe_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup an indexed object from index. takes a reference on object */
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
+void *__get_key(struct rxe_pool *pool, void *key);
 
-/* lookup keyed object from key. takes a reference on the object */
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
+void *rxe_get_key(struct rxe_pool *pool, void *key);
 
-/* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
 
 /* take a reference on an object */
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index a3eed4da1540..50411b0069ba 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -185,7 +185,7 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	if (qpn != IB_MULTICAST_QPN) {
 		index = (qpn == 1) ? port->qp_gsi_index : qpn;
 
-		qp = rxe_pool_get_index(&rxe->qp_pool, index);
+		qp = rxe_get_index(&rxe->qp_pool, index);
 		if (unlikely(!qp)) {
 			pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn);
 			goto err1;
@@ -242,7 +242,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
 
 	/* lookup mcast group corresponding to mgid, takes a ref */
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
+	mcg = rxe_get_key(&rxe->mc_grp_pool, &dgid);
 	if (!mcg)
 		goto err1;	/* mcast group not registered */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e4de0f4a3d69..0428965c664b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -564,7 +564,7 @@ static int invalidate_key(struct rxe_qp *qp, u32 key)
 	struct rxe_mr *mr;
 
 	if (key & IS_MW) {
-		mw = rxe_pool_get_key(&rxe->mw_pool, &key);
+		mw = rxe_get_key(&rxe->mw_pool, &key);
 		if (!mw) {
 			pr_err("No mw for key %#x\n", key);
 			return -EINVAL;
@@ -572,7 +572,7 @@ static int invalidate_key(struct rxe_qp *qp, u32 key)
 		ret = rxe_invalidate_mw(qp, mw);
 		rxe_drop_ref(mw);
 	} else {
-		mr = rxe_pool_get_key(&rxe->mr_pool, &key);
+		mr = rxe_get_key(&rxe->mr_pool, &key);
 		if (!mr) {
 			pr_err("No mr for key %#x\n", key);
 			return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 846baeec61be..58d3783063bb 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -441,7 +441,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	 * since the last packet
 	 */
 	if (rkey & IS_MW) {
-		mw = rxe_pool_get_key(&rxe->mw_pool, &rkey);
+		mw = rxe_get_key(&rxe->mw_pool, &rkey);
 		if (!mw) {
 			pr_err_once("no MW found with rkey = 0x%08x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
@@ -465,7 +465,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		spin_unlock_irqrestore(&mw->lock, flags);
 		rxe_drop_ref(mw);
 	} else {
-		mr = rxe_pool_get_key(&rxe->mr_pool, &rkey);
+		mr = rxe_get_key(&rxe->mr_pool, &rkey);
 		if (!mr || (mr->rkey != rkey)) {
 			pr_err_once("no MR found with rkey = 0x%08x\n", rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
@@ -793,7 +793,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 	struct rxe_mr *mr;
 
 	if (rkey & IS_MW) {
-		mw = rxe_pool_get_key(&rxe->mw_pool, &rkey);
+		mw = rxe_get_key(&rxe->mw_pool, &rkey);
 		if (!mw) {
 			pr_err("No mw for rkey %#x\n", rkey);
 			goto err;
@@ -801,7 +801,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
 		ret = rxe_invalidate_mw(qp, mw);
 		rxe_drop_ref(mw);
 	} else {
-		mr = rxe_pool_get_key(&rxe->mr_pool, &rkey);
+		mr = rxe_get_key(&rxe->mr_pool, &rkey);
 		if (!mr || mr->ibmr.rkey != rkey) {
 			pr_err("No mr for rkey %#x\n", rkey);
 			goto err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7849d8d72d4c..8f18b992983f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -111,7 +111,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(uctx->device);
 	struct rxe_ucontext *uc = to_ruc(uctx);
 
-	return rxe_add_to_pool(&rxe->uc_pool, &uc->pelem);
+	return rxe_add_to_pool(&rxe->uc_pool, uc);
 }
 
 static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
@@ -145,7 +145,7 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	return rxe_add_to_pool(&rxe->pd_pool, &pd->pelem);
+	return rxe_add_to_pool(&rxe->pd_pool, pd);
 }
 
 static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -169,7 +169,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	if (err)
 		return err;
 
-	err = rxe_add_to_pool(&rxe->ah_pool, &ah->pelem);
+	err = rxe_add_to_pool(&rxe->ah_pool, ah);
 	if (err)
 		return err;
 
@@ -275,7 +275,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	err = rxe_add_to_pool(&rxe->srq_pool, &srq->pelem);
+	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
 		goto err1;
 
@@ -776,7 +776,7 @@ static int rxe_create_cq(struct ib_cq *ibcq,
 	if (err)
 		return err;
 
-	return rxe_add_to_pool(&rxe->cq_pool, &cq->pelem);
+	return rxe_add_to_pool(&rxe->cq_pool, cq);
 }
 
 static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
-- 
2.25.1

