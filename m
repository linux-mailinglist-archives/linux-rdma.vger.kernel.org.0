Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B04CCA8E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiCDAJg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiCDAJf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:35 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8EA49277
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:47 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 40-20020a9d032b000000b005b02923e2e6so6065719otv.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTCCDs60aK4EDN4BuvxmI18oOfluSAUk7qcm893+q7A=;
        b=oCbJeYH8C3+aCcvVJRbSihcs5qz+inAjrf+j+QIU2HTT4gXZsGQkDIQAJe/9xc+uUt
         +yjfZ7hlejl8pGJBxIlD9rhIA0wSHCLdZbGua2F+YcVwgXSgFn7d5QzO5RO0wkNWdaLM
         2Pz6d6ehwerp5CgJ+hMuXsbIJuSZxCip3Z02FKHCNrXscUcA6ZD4KCOgCZmQsP+oUq4p
         ARTORNbzFOJ9B/jYn5LNflrN/15vtUemoOACutjVEhOg86Q8WF+UQ+XxE7GLn2FQ09Wi
         hEuSaQAcUpMon3KRTdswACX3Qh4xC4FV8dTlPAo/ky/OWppp6tU9SwdHz586DOpFXZlw
         e+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTCCDs60aK4EDN4BuvxmI18oOfluSAUk7qcm893+q7A=;
        b=emVnR2xS1kDam2ktm0UvGS/7f16ed/OFhLohFTHOcJwaN+5Dfzyvu4u7Xg1R3XrhdP
         lDvjPIP9XS/HERxTzWuVdMmh0nla8DUB/ken5buuZkB8qnFevmUyxQcFR0LVKdI5qctO
         m6cYNNngM8UkBNqe+REV++JsW0NUgxV/tpHyiHhucw5iKg88pfykmX+bB4ycvNHRgdQ0
         YdEPGquTNta1T2xsRiO50mSmLINknStbVxPN2HTvdODdxw+bO4UjGd7YsLgDnJsZcLcq
         JxKrUZ/Yq62DE1nc4MqhbfbKALWe1ZQ0axLXF7NWsgiTYcQZBx9nkofbX0lZ8Q9VP3Fd
         l+Ow==
X-Gm-Message-State: AOAM533JVBG7sqZpD9gAlOSKrO4bZJR8ATh+BeVvHpnFco2hKcvqYi1b
        CteLoPuABWLnyaFgm6JQuIlwuHhJgL8=
X-Google-Smtp-Source: ABdhPJyiENDX6vSsKrF+sS2RwwfmK+HfQIWJTVKYd4TbogDpi6O/oIAkbIWBeOOolew2PW7CCV2fnA==
X-Received: by 2002:a9d:da6:0:b0:59f:a2fa:a158 with SMTP id 35-20020a9d0da6000000b0059fa2faa158mr20361761ots.20.1646352527224;
        Thu, 03 Mar 2022 16:08:47 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 08/13] RDMA/rxe: Replace red-black trees by xarrays
Date:   Thu,  3 Mar 2022 18:08:04 -0600
Message-Id: <20220304000808.225811-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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

Currently the rxe driver uses red-black trees to add indices to the rxe
object pools. Linux xarrays provide a better way to implement the same
functionality for indices. This patch replaces red-black trees by xarrays
for pool objects. Since xarrays already have a spinlock use that in place
of the pool rwlock. Make sure that all changes in the xarray(index) and
kref(ref counnt) occur atomically.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  80 ++-------
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   8 -
 drivers/infiniband/sw/rxe/rxe_pool.c  | 236 +++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  43 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 --
 6 files changed, 103 insertions(+), 277 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index dc1f9dd70966..2dae7538a2ea 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -114,75 +114,26 @@ static void rxe_init_ports(struct rxe_dev *rxe)
 }
 
 /* init pools of managed objects */
-static int rxe_init_pools(struct rxe_dev *rxe)
+static void rxe_init_pools(struct rxe_dev *rxe)
 {
-	int err;
-
-	err = rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC);
-	if (err)
-		goto err1;
-
-	err = rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD);
-	if (err)
-		goto err2;
-
-	err = rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH);
-	if (err)
-		goto err3;
-
-	err = rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ);
-	if (err)
-		goto err4;
-
-	err = rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP);
-	if (err)
-		goto err5;
-
-	err = rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ);
-	if (err)
-		goto err6;
-
-	err = rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR);
-	if (err)
-		goto err7;
-
-	err = rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW);
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
+	rxe_pool_init(rxe, &rxe->uc_pool, RXE_TYPE_UC);
+	rxe_pool_init(rxe, &rxe->pd_pool, RXE_TYPE_PD);
+	rxe_pool_init(rxe, &rxe->ah_pool, RXE_TYPE_AH);
+	rxe_pool_init(rxe, &rxe->srq_pool, RXE_TYPE_SRQ);
+	rxe_pool_init(rxe, &rxe->qp_pool, RXE_TYPE_QP);
+	rxe_pool_init(rxe, &rxe->cq_pool, RXE_TYPE_CQ);
+	rxe_pool_init(rxe, &rxe->mr_pool, RXE_TYPE_MR);
+	rxe_pool_init(rxe, &rxe->mw_pool, RXE_TYPE_MW);
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
 
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
@@ -194,8 +145,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	rxe->mcg_tree = RB_ROOT;
 
 	mutex_init(&rxe->usdev_lock);
-
-	return 0;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
@@ -217,12 +166,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
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
index c50baeb10bd2..b0dfeb08a470 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -22,19 +22,22 @@ static const struct rxe_type_info {
 		.name		= "uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
@@ -43,7 +46,6 @@ static const struct rxe_type_info {
 		.name		= "srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
@@ -53,7 +55,6 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 		.max_elem	= RXE_MAX_QP_INDEX - RXE_MIN_QP_INDEX + 1,
@@ -63,6 +64,8 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
@@ -70,7 +73,7 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
+		.flags		= RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
@@ -79,44 +82,16 @@ static const struct rxe_type_info {
 		.name		= "mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
-		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.max_elem	= RXE_MAX_MW_INDEX - RXE_MIN_MW_INDEX + 1,
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
-	enum rxe_elem_type	type)
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+		   enum rxe_elem_type type)
 {
 	const struct rxe_type_info *info = &rxe_type_info[type];
-	int			err = 0;
 
 	memset(pool, 0, sizeof(*pool));
 
@@ -131,111 +106,52 @@ int rxe_pool_init(
 
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
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+	pool->limit.min = info->min_index;
+	pool->limit.max = info->max_index;
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
+	struct xarray *xa = &pool->xa;
+	unsigned long index = 0;
+	unsigned long max = ULONG_MAX;
+	unsigned int elem_count = 0;
+	unsigned int obj_count = 0;
+
+	do {
+		elem = xa_find(xa, &index, max, XA_PRESENT);
+		if (elem) {
+			elem_count++;
+			xa_erase(xa, index);
+			if (pool->flags & RXE_POOL_ALLOC) {
+				kfree(elem->obj);
+				obj_count++;
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
-	unsigned long flags;
-	int err;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	elem->index = alloc_index(pool);
-	err = rxe_insert_index(pool, elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-
-	return err;
-}
-
-void __rxe_drop_index(struct rxe_pool_elem *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	clear_bit(elem->index - pool->index.min_index, pool->index.table);
-	rb_erase(&elem->index_node, &pool->index.tree);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
+	if (WARN_ON(elem_count || obj_count))
+		pr_debug("Freed %d indices and %d objects from pool %s\n",
+			elem_count, obj_count, pool->name);
 }
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
 	void *obj;
+	int err;
 
 	if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
 		return NULL;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_cnt;
 
 	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
-		goto out_cnt;
+		goto err_cnt;
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
@@ -243,78 +159,86 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+			      &pool->next, GFP_KERNEL);
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
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
 		return -EINVAL;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
+		goto err_cnt;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+			      &pool->next, GFP_KERNEL);
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
 {
-	struct rxe_pool_elem *elem =
-		container_of(kref, struct rxe_pool_elem, ref_cnt);
-	struct rxe_pool *pool = elem->pool;
+	struct rxe_pool_elem *elem;
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 	void *obj;
 
-	if (pool->cleanup)
-		pool->cleanup(elem);
-
-	if (pool->flags & RXE_POOL_ALLOC) {
+	xa_lock_irqsave(xa, flags);
+	elem = xa_load(xa, index);
+	if (elem && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-		kfree(obj);
-	}
+	else
+		obj = NULL;
+	xa_unlock_irqrestore(xa, flags);
 
-	atomic_dec(&pool->num_elem);
+	return obj;
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+static void rxe_elem_release(struct kref *kref)
 {
-	struct rxe_pool_elem *elem;
-	struct rb_node *node;
-	unsigned long flags;
-	void *obj;
+	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
+	struct rxe_pool *pool = elem->pool;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
-	node = pool->index.tree.rb_node;
+	xa_erase(&pool->xa, elem->index);
 
-	while (node) {
-		elem = rb_entry(node, struct rxe_pool_elem, index_node);
+	if (pool->cleanup)
+		pool->cleanup(elem);
 
-		if (elem->index > index)
-			node = node->rb_left;
-		else if (elem->index < index)
-			node = node->rb_right;
-		else
-			break;
-	}
+	if (pool->flags & RXE_POOL_ALLOC)
+		kfree(elem->obj);
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
-		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
-	read_unlock_irqrestore(&pool->pool_lock, flags);
+	atomic_dec(&pool->num_elem);
+}
 
-	return obj;
+int __rxe_get(struct rxe_pool_elem *elem)
+{
+	return kref_get_unless_zero(&elem->ref_cnt);
+}
+
+int __rxe_put(struct rxe_pool_elem *elem)
+{
+	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 5f34d232d7f4..d1e05d384b2c 100644
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
@@ -29,16 +28,12 @@ struct rxe_pool_elem {
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
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
@@ -48,21 +43,16 @@ struct rxe_pool {
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
 };
 
 /* initialize a pool of objects with given limit on
  * number of elements. gets parameters from rxe_type_info
  * pool elements will be allocated out of a slab cache
  */
-int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
+void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		  enum rxe_elem_type type);
 
 /* free resources from object pool */
@@ -76,29 +66,18 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
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
+int __rxe_get(struct rxe_pool_elem *elem);
+
+#define rxe_add_ref(obj) __rxe_get(&(obj)->elem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
+int __rxe_put(struct rxe_pool_elem *elem);
+
+#define rxe_drop_ref(obj) __rxe_put(&(obj)->elem)
 
 #define rxe_read_ref(obj) kref_read(&(obj)->elem.ref_cnt)
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 80df9a8f71a1..f0c5715ac500 100644
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
@@ -438,7 +435,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		return err;
 
-	rxe_add_index(qp);
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
 	if (err)
 		goto qp_init;
@@ -446,7 +442,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return err;
 }
@@ -501,7 +496,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		return ret;
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return 0;
 }
@@ -908,7 +902,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_index(mr);
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
@@ -932,7 +925,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
 
 	rxe_add_ref(pd);
 
@@ -944,7 +936,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
@@ -967,8 +958,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
@@ -979,7 +968,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.32.0

