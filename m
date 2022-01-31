Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD554A521B
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiAaWKR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiAaWKO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:14 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FEFC061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:14 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so29561328oih.8
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d4W/VIdBaJxzJ136KdX2FA8NCQ+FkUx44M1fpmUEF5s=;
        b=aIIRVgA0mZXL+sgOFX2GzrkkBplWnLVAX5XXneobarpY+S+bWdaMwQInIfqrUDfmKH
         yXWKPC54Im5qaIZ4qACTUh3fznjpqC7Gh0fr5zG/q0aJILFAqROUt055s3ODLTUvG9mV
         81E2w18336Xi4SWw6ptupeMDm1V40QaKFdKM2JAgCDD33sKYqP0f6sdHKmasUBj/QcO2
         dN7davXtOK08fGW1dF5dN3XYSd5Ge3C8G/vHVFEfWfPHUIbxnMmp6nDWPzsRZItpqa2l
         cNDKZef6vgd6iO48HGpSqjP0FX7gJVGc0gFme8l2sukDn/Ie+cI/aawTPS1lSy2MKGj5
         s8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d4W/VIdBaJxzJ136KdX2FA8NCQ+FkUx44M1fpmUEF5s=;
        b=Twx+blhTRYk3/0EN8O1mEsfARELcub1DLKrOBIqNGDUbl6YU744gJ3L/eVJSKw4nYh
         WVlPR/W1WkxDyBHuSJQWpntdilYaemsKJpV6Jt7QYgRFC7lVH+ThoNkQes1KQu5edOH+
         W6DI2b+ETkgpGLLXyxiIMfd7PLNR9aHOVU2DyJO5zdnDymXGsyU+KVqql6xcAbc7q+H+
         Xcc9l/Mw7yUrKZh+McSWVbxwUlOOqFo0pL8lvWhRCLjCHudVpIrJRZbg7Fo9hIXD6hf7
         cw8bQojwj+0a2HQjST4D2ToVKsDhla14NhgmZ8kUBCDtNJQx47Hdw8sVzvFVnHOFZA4a
         DpFg==
X-Gm-Message-State: AOAM530gopd0uftsMmyB0AI6GfOXX2XM8doePuUo2KjkC7w+Cn9aC956
        moUYvgSuCNX3h0J5NO4MBwe8rjcBN/Y=
X-Google-Smtp-Source: ABdhPJxIGy2oZ4BX3N6o1KhAS9sd/hkPZdWiIA95Sb+2GXzv5LHXQk3dhFf6L9jiOtORTRINQGdmnw==
X-Received: by 2002:a05:6808:1899:: with SMTP id bi25mr15307964oib.338.1643667013647;
        Mon, 31 Jan 2022 14:10:13 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:13 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 12/17] RDMA/rxe: Replace pool key by rxe->mcg_tree
Date:   Mon, 31 Jan 2022 16:08:45 -0600
Message-Id: <20220131220849.10170-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Continuing to decouple mcg from rxe pools. Create red-black tree code
in rxe_mcast.c to hold mcg index. Replace pool key calls by calls
to local red-black routines.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 233 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_pool.c  |   6 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 +
 6 files changed, 197 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 46a07e2d9dcf..310e184ae9e8 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -199,6 +199,7 @@ static int rxe_init(struct rxe_dev *rxe)
 		return err;
 
 	spin_lock_init(&rxe->mcg_lock);
+	rxe->mcg_tree = RB_ROOT;
 
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index af40e3c212fb..bd701af7758c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,7 +40,7 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-void rxe_mc_cleanup(struct rxe_pool_elem *arg);
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index d35070777214..82669d14d8a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -25,68 +25,189 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
-/* caller should hold rxe->mcg_lock */
-static int __rxe_create_mcg(struct rxe_dev *rxe, struct rxe_pool *pool,
-			    union ib_gid *mgid, struct rxe_mcg **mcg_p)
+/**
+ * __rxe_insert_mcg - insert an mcg into red-black tree (rxe->mcg_tree)
+ * @mcg: mcg object with an embedded red-black tree node
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock and
+ * is responsible to avoid adding the same mcg twice to the tree.
+ */
+static void __rxe_insert_mcg(struct rxe_mcg *mcg)
 {
-	int err;
+	struct rb_root *tree = &mcg->rxe->mcg_tree;
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *node = NULL;
+	struct rxe_mcg *tmp;
+	int cmp;
+
+	while (*link) {
+		node = *link;
+		tmp = rb_entry(node, struct rxe_mcg, node);
+
+		cmp = memcmp(&tmp->mgid, &mcg->mgid, sizeof(mcg->mgid));
+		if (cmp > 0)
+			link = &(*link)->rb_left;
+		else
+			link = &(*link)->rb_right;
+	}
+
+	rb_link_node(&mcg->node, node, link);
+	rb_insert_color(&mcg->node, tree);
+}
+
+/**
+ * __rxe_remove_mcg - remove an mcg from red-black tree holding lock
+ * @mcg: mcast group object with an embedded red-black tree node
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ */
+static void __rxe_remove_mcg(struct rxe_mcg *mcg)
+{
+	rb_erase(&mcg->node, &mcg->rxe->mcg_tree);
+}
+
+/**
+ * __rxe_lookup_mcg - lookup mcg in rxe->mcg_tree while holding lock
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ *
+ * Context: caller must hold rxe->mcg_lock
+ * Returns: mcg on success and takes a ref to mcg else NULL
+ */
+static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
+					union ib_gid *mgid)
+{
+	struct rb_root *tree = &rxe->mcg_tree;
 	struct rxe_mcg *mcg;
+	struct rb_node *node;
+	int cmp;
 
-	mcg = rxe_alloc_locked(&rxe->mc_grp_pool);
-	if (!mcg)
-		return -ENOMEM;
+	node = tree->rb_node;
+
+	while (node) {
+		mcg = rb_entry(node, struct rxe_mcg, node);
+
+		cmp = memcmp(&mcg->mgid, mgid, sizeof(*mgid));
+
+		if (cmp > 0)
+			node = node->rb_left;
+		else if (cmp < 0)
+			node = node->rb_right;
+		else
+			break;
+	}
+
+	if (node) {
+		rxe_add_ref(mcg);
+		return mcg;
+	}
+
+	return NULL;
+}
+
+/**
+ * rxe_lookup_mcg - lookup up mcg in red-back tree
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ *
+ * Returns: mcg if found else NULL
+ */
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
+{
+	struct rxe_mcg *mcg;
+
+	spin_lock_bh(&rxe->mcg_lock);
+	mcg = __rxe_lookup_mcg(rxe, mgid);
+	spin_unlock_bh(&rxe->mcg_lock);
+
+	return mcg;
+}
+
+/**
+ * __rxe_init_mcg - initialize a new mcg
+ * @rxe: rxe device
+ * @mgid: multicast address as a gid
+ * @mcg: new mcg object
+ *
+ * Context: caller should hold rxe->mcg lock
+ * Returns: 0 on success else an error
+ */
+static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
+			  struct rxe_mcg *mcg)
+{
+	int err;
 
 	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_ref(mcg);
+	if (unlikely(err))
 		return err;
-	}
 
+	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
 
 	rxe_add_ref(mcg);
-	rxe_add_key_locked(mcg, mgid);
+	__rxe_insert_mcg(mcg);
 
-	*mcg_p = mcg;
-	return 0;
-}
 
-/* caller is holding a ref from lookup and mcg->mcg_lock*/
-void __rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	rxe_drop_key(mcg);
-	rxe_drop_ref(mcg);
-
-	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
+	return 0;
 }
 
-static int rxe_mcast_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
-			     struct rxe_mcg **mcg_p)
+/**
+ * rxe_get_mcg - lookup or allocate a mcg
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ * @mcgp: address of returned mcg value
+ *
+ * Returns: 0 and sets *mcgp to mcg on success else an error
+ */
+static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
+		       struct rxe_mcg **mcgp)
 {
-	int err;
-	struct rxe_mcg *mcg;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
+	struct rxe_mcg *mcg, *tmp;
+	int err;
 
-	if (rxe->attr.max_mcast_qp_attach == 0)
+	if (rxe->attr.max_mcast_grp == 0)
 		return -EINVAL;
 
-	spin_lock_bh(&rxe->mcg_lock);
+	/* check to see if mcg already exists */
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (mcg) {
+		*mcgp = mcg;
+		return 0;
+	}
 
-	mcg = rxe_pool_get_key_locked(pool, mgid);
-	if (mcg)
-		goto done;
+	/* speculative alloc of mcg */
+	mcg = rxe_alloc(pool);
+	if (!mcg)
+		return -ENOMEM;
 
-	err = __rxe_create_mcg(rxe, pool, mgid, &mcg);
-	if (err) {
-		spin_unlock_bh(&rxe->mcg_lock);
-		return err;
+	spin_lock_bh(&rxe->mcg_lock);
+	/* re-check to see if someone else just added it */
+	tmp = __rxe_lookup_mcg(rxe, mgid);
+	if (tmp) {
+		rxe_drop_ref(mcg);
+		mcg = tmp;
+		goto out;
 	}
 
-done:
+	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
+		err = -ENOMEM;
+		goto err_dec;
+	}
+
+	err = __rxe_init_mcg(rxe, mgid, mcg);
+	if (err)
+		goto err_dec;
+out:
 	spin_unlock_bh(&rxe->mcg_lock);
-	*mcg_p = mcg;
+	*mcgp = mcg;
 	return 0;
+err_dec:
+	atomic_dec(&rxe->mcg_num);
+	spin_unlock_bh(&rxe->mcg_lock);
+	rxe_drop_ref(mcg);
+	return err;
 }
 
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
@@ -138,13 +259,42 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
+/**
+ * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
+ * @mcg: the mcg object
+ *
+ * Context: caller is holding rxe->mcg_lock, all refs to mcg are dropped
+ * no qp's are attached to mcg
+ */
+void __rxe_destroy_mcg(struct rxe_mcg *mcg)
+{
+	__rxe_remove_mcg(mcg);
+
+	rxe_drop_ref(mcg);
+
+	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
+}
+
+/**
+ * rxe_destroy_mcg - destroy mcg object
+ * @mcg: the mcg object
+ *
+ * Context: all refs to mcg are dropped, no qp's are attached to mcg
+ */
+static void rxe_destroy_mcg(struct rxe_mcg *mcg)
+{
+	spin_lock_bh(&mcg->rxe->mcg_lock);
+	__rxe_destroy_mcg(mcg);
+	spin_unlock_bh(&mcg->rxe->mcg_lock);
+}
+
 static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca, *tmp;
 
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	mcg = rxe_lookup_mcg(rxe, mgid);
 	if (!mcg)
 		goto err1;
 
@@ -170,11 +320,6 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return -EINVAL;
 }
 
-void rxe_mc_cleanup(struct rxe_pool_elem *elem)
-{
-	/* nothing left to do */
-}
-
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	int err;
@@ -182,14 +327,14 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *mcg;
 
-	err = rxe_mcast_get_mcg(rxe, mgid, &mcg);
+	err = rxe_get_mcg(rxe, mgid, &mcg);
 	if (err)
 		return err;
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
 
 	if (atomic_read(&mcg->qp_num) == 0)
-		__rxe_destroy_mcg(mcg);
+		rxe_destroy_mcg(mcg);
 
 	rxe_drop_ref(mcg);
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index a6756aa93e2b..4eff95d57aa4 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -82,13 +82,9 @@ static const struct rxe_type_info {
 		.max_index	= RXE_MAX_MW_INDEX,
 	},
 	[RXE_TYPE_MC_GRP] = {
-		.name		= "rxe-mc_grp",
+		.name		= "rxe-mcg",
 		.size		= sizeof(struct rxe_mcg),
 		.elem_offset	= offsetof(struct rxe_mcg, elem),
-		.cleanup	= rxe_mc_cleanup,
-		.flags		= RXE_POOL_KEY,
-		.key_offset	= offsetof(struct rxe_mcg, mgid),
-		.key_size	= sizeof(union ib_gid),
 	},
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 9a45743c8eaa..9a92e5a486ee 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -254,7 +254,7 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
 
 	/* lookup mcast group corresponding to mgid, takes a ref */
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
+	mcg = rxe_lookup_mcg(rxe, &dgid);
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
@@ -320,7 +320,7 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 
 	kfree(qp_array);
 
-	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	rxe_drop_ref(mcg);
 
 	if (likely(!skb))
 		return;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index b72f8f09d984..ea2d9ff29744 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -353,6 +353,7 @@ struct rxe_mw {
 
 struct rxe_mcg {
 	struct rxe_pool_elem	elem;
+	struct rb_node		node;
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	atomic_t		qp_num;
@@ -397,6 +398,8 @@ struct rxe_dev {
 	struct rxe_pool		mc_grp_pool;
 
 	spinlock_t		mcg_lock; /* guard multicast groups */
+	struct rb_root		mcg_tree;
+	atomic_t		mcg_num;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

