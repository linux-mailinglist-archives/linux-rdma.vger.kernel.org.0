Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7F14C4F2C
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiBYT7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiBYT7G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:06 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF1C4283
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:32 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so4380245otl.6
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5F5g9ux/AX1sqlW+WPs1Mlv9SX0IZTRxPCF2FECIeI4=;
        b=dV9oCqjVX+ybDfrL1OX58m9yGrdOnri81Qc5iqrNVMpG5CfIF4QtW0H6Gtf17biauA
         +uR++yrEnfkkbWho7ywx9eovUXtir1JSj2qyjXam4oYeTc9qVofmYQXx3uUGfBxW/vjQ
         g1jign1mhJGs7LPS4huEd8Zni1Wir8Q8fRnpWKhAschdaLz5q+7X1R0hWjz89bogcSNT
         ZJ1oJlWI+YuOQIKssHz1Xs/Qiqx5fR6BME1/Dk2WPSl7kQ/xqOW4LVn02cjs8/wUnXyp
         5q7RYtroiWfljYakQdaKcBWxIjjQj6cA3uE3xDoPsKfhCZhoiZE5eYcIpoM4xwZ4R2M5
         W4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5F5g9ux/AX1sqlW+WPs1Mlv9SX0IZTRxPCF2FECIeI4=;
        b=rzmmRRSzRfejHxQWXVSHDK1aiGb45NVO1OF4Sels2cVvFXfQ4WaiI829Qyeq5T1l/F
         CjxE7YQsX0MAdAwBfymQpqPl/pL/zTO9N+iURzHBy4UYC6B5VnDYIK+JLUdopL/l7c03
         oHW9iNFByItdA1JNGIjUs/YGYUAvm0GaPHJDWywsevX6rsjbV+xOZc6NlAO4/Q1T3AJ8
         qBc9/tYaHNkhgiP5fYPqu799/7Q4LxzJuStEWihh3MtgFw5+pxOYqOxiz3AR7/gx2wyg
         x/VuvMfQe2efqMTO7ckk/MwymRCPgdzPC4xEyiM94mE1nUy2TI8I7jOZL9ZKA35NziRo
         hCsA==
X-Gm-Message-State: AOAM531eHJ1MeMKZGHJv6pGwSalEorBTm4qyHoAaJQu8YG5NOOQSqMsJ
        I+Z0tanD/+NvwR/4+qDW+H1sYgjH5A0=
X-Google-Smtp-Source: ABdhPJzQKVNUBmLUcHEDhE4yq99pgtD/z/rIJ/P0izUJZC7nNB0XoGlRt26tiPWBXmCi6vfKlwiD+A==
X-Received: by 2002:a05:6830:314c:b0:5af:dc8a:d066 with SMTP id c12-20020a056830314c00b005afdc8ad066mr1042334ots.28.1645819111776;
        Fri, 25 Feb 2022 11:58:31 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:31 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 04/11] RDMA/rxe: Replace red-black trees by xarrays
Date:   Fri, 25 Feb 2022 13:57:44 -0600
Message-Id: <20220225195750.37802-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe.c       |  87 ++-------
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   8 -
 drivers/infiniband/sw/rxe/rxe_pool.c  | 244 ++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  43 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 --
 6 files changed, 118 insertions(+), 277 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index fce3994d8f7a..29e2b93f6d7e 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -114,83 +114,26 @@ static void rxe_init_ports(struct rxe_dev *rxe)
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
 
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
@@ -202,8 +145,6 @@ static int rxe_init(struct rxe_dev *rxe)
 	rxe->mcg_tree = RB_ROOT;
 
 	mutex_init(&rxe->usdev_lock);
-
-	return 0;
 }
 
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
@@ -225,11 +166,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
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
index 2e2d01a73639..c298467337b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -21,17 +21,20 @@ static const struct rxe_type_info {
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
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -39,7 +42,6 @@ static const struct rxe_type_info {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -48,7 +50,6 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -57,13 +58,15 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
+		.min_index	= 1,
+		.max_index	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX | RXE_POOL_ALLOC,
+		.flags		= RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 	},
@@ -71,44 +74,15 @@ static const struct rxe_type_info {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
-		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_INDEX,
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
 
@@ -123,114 +97,54 @@ int rxe_pool_init(
 
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
+	unsigned int obj_count = 0;
+
+	do {
+		elem = xa_find(&pool->xa, &index, max, XA_PRESENT);
+		if (elem) {
+			elem_count++;
+			xa_erase(&pool->xa, index);
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
+	if (elem_count || obj_count)
+		pr_warn("Freed %d indices & %d objects from pool %s\n",
+			elem_count, obj_count, pool->name + 4);
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
 
@@ -238,42 +152,77 @@ void *rxe_alloc(struct rxe_pool *pool)
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
+	unsigned long flags;
+	void *obj;
+
+	spin_lock_irqsave(&pool->xa.xa_lock, flags);
+	elem = xa_load(&pool->xa, index);
+	if (elem && kref_get_unless_zero(&elem->ref_cnt))
+		obj = elem->obj;
+	else
+		obj = NULL;
+	spin_unlock_irqrestore(&pool->xa.xa_lock, flags);
+
+	return obj;
+}
+
+static void rxe_elem_release(struct kref *kref, unsigned long flags)
+	__releases(&pool->xa.xa_lock)
 {
 	struct rxe_pool_elem *elem =
 		container_of(kref, struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
 	void *obj;
 
+	__xa_erase(&pool->xa, elem->index);
+
+	spin_unlock_irqrestore(&pool->xa.xa_lock, flags);
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
@@ -285,34 +234,31 @@ void rxe_elem_release(struct kref *kref)
 	atomic_dec(&pool->num_elem);
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+int __rxe_add_ref(struct rxe_pool_elem *elem)
 {
-	struct rxe_pool_elem *elem;
-	struct rb_node *node;
-	unsigned long flags;
-	void *obj;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
-	node = pool->index.tree.rb_node;
+	return kref_get_unless_zero(&elem->ref_cnt);
+}
 
-	while (node) {
-		elem = rb_entry(node, struct rxe_pool_elem, index_node);
+/* local copy of kref_put_lock_irqsave same as kref_put_lock
+ * except for _irqsave locks
+ */
+static int kref_put_lock_irqsave(struct kref *kref,
+		 void (*release)(struct kref *kref, unsigned long flags),
+		 spinlock_t *lock)
+{
+	unsigned long flags;
 
-		if (elem->index > index)
-			node = node->rb_left;
-		else if (elem->index < index)
-			node = node->rb_right;
-		else
-			break;
+	if (refcount_dec_and_lock_irqsave(&kref->refcount, lock, &flags)) {
+		release(kref, flags);
+		return 1;
 	}
+	return 0;
+}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
-		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
-	read_unlock_irqrestore(&pool->pool_lock, flags);
+int __rxe_drop_ref(struct rxe_pool_elem *elem)
+{
+	struct rxe_pool *pool = elem->pool;
 
-	return obj;
+	return kref_put_lock_irqsave(&elem->ref_cnt, rxe_elem_release,
+			&pool->xa.xa_lock);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index a8582ad85b1e..422987c90cb9 100644
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
 		  enum rxe_elem_type type, u32 max_elem);
 
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
+int __rxe_add_ref(struct rxe_pool_elem *elem);
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
+int __rxe_drop_ref(struct rxe_pool_elem *elem);
+
+#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
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

