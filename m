Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24EC4AE3F6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353601AbiBHWZA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386871AbiBHVRU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:20 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42990C0612BC
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:19 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so113248ooo.13
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YtBCKzCWxeoCaS5cF/oPWG1hIXwVDdb+8ZUmhXUBmw=;
        b=fucyRGOcJv+lS8ga10DBO8uv6WFIPGlamXEvi1eUDsUxs81LjkCFTuiW36gjt+bNbO
         HKJr1oxKR4LO3q4LOfzicDcDC+D9AEf9wQo4s0axhXH6M50m+QJdJF1e/3tCP4xzJ4kT
         NSrZyW0xKLETdAvStzwIWe8YSa8Rp137UJakr/NLuYoT06TW6ufqdfQQuPuE+TLt2WLg
         IccMzafoV/64CGShMw1itMLdzbniH6c18ChuHQole45mxWlV0SbFVoa8fneSTysXrJlY
         wlENdMdvPDpvYdaipT4M2Mf1TD72msUoU5J/hS2X06ItOYAyH1TdNwF0cmS9P+342/5K
         GyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YtBCKzCWxeoCaS5cF/oPWG1hIXwVDdb+8ZUmhXUBmw=;
        b=52eggqhKQan0xyau85JDniMO9LjWAescK083HL54HRbrMYIAGxyh8HVCOo1IHFFpeN
         6xu00IVDIPJeWALHW+9Nqt/i4ROqeNyvzolyi/CClMVXCDivqYX4cw6jXFQlxNPUN/Xe
         AJxQnkQ/7bziFrnl7+ehoFsERDzG/P04llrOGl0T+CXdjjOeQfc4zUh4vUoIJkj2MmRb
         7sU2Tg+rgJYiy0ITHRl+QrRwSTXys/dyrMAzesxLI8Z6C1/fyVACJ6zq3l8ASUOihCQV
         YHrbL23UKCcmhW2sBSckYhuXLK/5o0PsGVJw8P4APKyEXBEHRbyjIrLn2r7kR5n8fyK6
         3ROA==
X-Gm-Message-State: AOAM533aDxjsM6TzqrisstFDlqikAFhYdigPN6QmCuqbGjc1DAz6avAd
        rRV2STKYqCRHR1Fc6Q7rH4s=
X-Google-Smtp-Source: ABdhPJzfifgtR9SdJ+8gl4r4NDf1AHPW8RHw/HQSE+kjeZhxbrLhKCJtznGQqVRx0oLxBGI8p6jdeA==
X-Received: by 2002:a05:6870:c90d:: with SMTP id hj13mr1031000oab.332.1644355038593;
        Tue, 08 Feb 2022 13:17:18 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:18 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 05/11] RDMA/rxe: Replace pool key by rxe->mcg_tree
Date:   Tue,  8 Feb 2022 15:16:39 -0600
Message-Id: <20220208211644.123457-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208211644.123457-1-rpearsonhpe@gmail.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
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

Continuing to decouple mcg from rxe pools. Create red-black tree code
in rxe_mcast.c to hold mcg index. Replace pool key calls by calls
to local red-black routines.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 258 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   6 +-
 5 files changed, 210 insertions(+), 63 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 7386a51b953d..dc36148272dd 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -203,7 +203,9 @@ static int rxe_init(struct rxe_dev *rxe)
 	spin_lock_init(&rxe->pending_lock);
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
+	/* init multicast support */
 	spin_lock_init(&rxe->mcg_lock);
+	rxe->mcg_tree = RB_ROOT;
 
 	mutex_init(&rxe->usdev_lock);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index af40e3c212fb..d41831878fa6 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,9 +40,10 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-void rxe_mc_cleanup(struct rxe_pool_elem *arg);
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
+void rxe_mc_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 2c6cb2eb5ac1..78d696cd40d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -25,56 +25,225 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
-/* caller should hold rxe->mcg_lock */
-static struct rxe_mcg *__rxe_create_mcg(struct rxe_dev *rxe,
-					struct rxe_pool *pool,
+/**
+ * __rxe_insert_mcg - insert an mcg into red-black tree (rxe->mcg_tree)
+ * @mcg: mcg object with an embedded red-black tree node
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock and
+ * is responsible to avoid adding the same mcg twice to the tree.
+ */
+static void __rxe_insert_mcg(struct rxe_mcg *mcg)
+{
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
 					union ib_gid *mgid)
 {
+	struct rb_root *tree = &rxe->mcg_tree;
 	struct rxe_mcg *mcg;
-	int err;
+	struct rb_node *node;
+	int cmp;
 
-	mcg = rxe_alloc_locked(pool);
-	if (!mcg)
-		return ERR_PTR(-ENOMEM);
+	node = tree->rb_node;
 
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_ref(mcg);
-		return ERR_PTR(err);
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
 	}
 
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
+
+	err = rxe_mcast_add(rxe, mgid);
+	if (unlikely(err))
+		return err;
+
+	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
 
-	/* rxe_alloc_locked takes a ref on mcg but that will be
+	/* caller holds a ref on mcg but that will be
 	 * dropped when mcg goes out of scope. We need to take a ref
 	 * on the pointer that will be saved in the red-black tree
-	 * by rxe_add_key and used to lookup mcg from mgid later.
-	 * Adding key makes object visible to outside so this should
+	 * by __rxe_insert_mcg and used to lookup mcg from mgid later.
+	 * Inserting mcg makes it visible to outside so this should
 	 * be done last after the object is ready.
 	 */
 	rxe_add_ref(mcg);
-	rxe_add_key_locked(mcg, mgid);
+	__rxe_insert_mcg(mcg);
 
-	return mcg;
+	return 0;
 }
 
-static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe,
-					 union ib_gid *mgid)
+/**
+ * rxe_get_mcg - lookup or allocate a mcg
+ * @rxe: rxe device object
+ * @mgid: multicast IP address as a gid
+ *
+ * Returns: mcg on success else ERR_PTR(error)
+ */
+static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	struct rxe_mcg *mcg;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
+	struct rxe_mcg *mcg, *tmp;
+	int err;
 
-	if (rxe->attr.max_mcast_qp_attach == 0)
+	if (rxe->attr.max_mcast_grp == 0)
 		return ERR_PTR(-EINVAL);
 
-	spin_lock_bh(&rxe->mcg_lock);
-	mcg = rxe_pool_get_key_locked(pool, mgid);
+	/* check to see if mcg already exists */
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (mcg)
+		return mcg;
+
+	/* speculative alloc of new mcg */
+	mcg = rxe_alloc(pool);
 	if (!mcg)
-		mcg = __rxe_create_mcg(rxe, pool, mgid);
-	spin_unlock_bh(&rxe->mcg_lock);
+		return ERR_PTR(-ENOMEM);
 
+	spin_lock_bh(&rxe->mcg_lock);
+	/* re-check to see if someone else just added it */
+	tmp = __rxe_lookup_mcg(rxe, mgid);
+	if (tmp) {
+		rxe_drop_ref(mcg);
+		mcg = tmp;
+		goto out;
+	}
+
+	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
+		err = -ENOMEM;
+		goto err_dec;
+	}
+
+	err = __rxe_init_mcg(rxe, mgid, mcg);
+	if (err)
+		goto err_dec;
+out:
+	spin_unlock_bh(&rxe->mcg_lock);
 	return mcg;
+
+err_dec:
+	atomic_dec(&rxe->mcg_num);
+	spin_unlock_bh(&rxe->mcg_lock);
+	rxe_drop_ref(mcg);
+	return ERR_PTR(err);
+}
+
+/**
+ * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
+ * @mcg: the mcg object
+ *
+ * Context: caller is holding rxe->mcg_lock
+ * no qp's are attached to mcg
+ */
+static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
+{
+	/* remove mcg from red-black tree then drop ref */
+	__rxe_remove_mcg(mcg);
+	rxe_drop_ref(mcg);
+
+	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
+}
+
+/**
+ * rxe_destroy_mcg - destroy mcg object
+ * @mcg: the mcg object
+ *
+ * Context: no qp's are attached to mcg
+ */
+static void rxe_destroy_mcg(struct rxe_mcg *mcg)
+{
+	spin_lock_bh(&mcg->rxe->mcg_lock);
+	__rxe_destroy_mcg(mcg);
+	spin_unlock_bh(&mcg->rxe->mcg_lock);
+}
+
+void rxe_mc_cleanup(struct rxe_pool_elem *elem)
+{
+	/* nothing left to do for now */
 }
 
 static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
@@ -129,30 +298,6 @@ static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
-/* caller should be holding rxe->mcg_lock */
-static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	/* first remove mcg from red-black tree then drop ref */
-	rxe_drop_key_locked(mcg);
-	rxe_drop_ref(mcg);
-
-	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
-}
-
-static void rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	struct rxe_dev *rxe = mcg->rxe;
-
-	spin_lock_bh(&rxe->mcg_lock);
-	__rxe_destroy_mcg(mcg);
-	spin_unlock_bh(&rxe->mcg_lock);
-}
-
-void rxe_mc_cleanup(struct rxe_pool_elem *elem)
-{
-	/* nothing left to do for now */
-}
-
 static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
@@ -160,17 +305,16 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mca *mca, *tmp;
 	int err;
 
-	spin_lock_bh(&rxe->mcg_lock);
-	mcg = rxe_pool_get_key_locked(&rxe->mc_grp_pool, mgid);
-	if (!mcg) {
-		/* we didn't find the mcast group for mgid */
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (!mcg)
+		return -EINVAL;
 
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			list_del(&mca->qp_list);
+			atomic_dec(&qp->mcg_num);
+			rxe_drop_ref(qp);
 
 			/* if the number of qp's attached to the
 			 * mcast group falls to zero go ahead and
@@ -181,10 +325,8 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 			if (atomic_dec_return(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
-			atomic_dec(&qp->mcg_num);
-
 			/* drop the ref from get key. This will free the
-			 * object if num_qp is zero.
+			 * object if qp_num is zero.
 			 */
 			rxe_drop_ref(mcg);
 			kfree(mca);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index d91c6660e83c..fb265902f7e3 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -246,7 +246,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
 
 	/* lookup mcast group corresponding to mgid, takes a ref */
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
+	mcg = rxe_lookup_mcg(rxe, &dgid);
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
@@ -300,7 +300,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	spin_unlock_bh(&rxe->mcg_lock);
 
-	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	rxe_drop_ref(mcg);
 
 	if (likely(!skb))
 		return;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 3790163bb265..caa5b1b05019 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -353,6 +353,7 @@ struct rxe_mw {
 
 struct rxe_mcg {
 	struct rxe_pool_elem	elem;
+	struct rb_node		node;
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	union ib_gid		mgid;
@@ -396,7 +397,10 @@ struct rxe_dev {
 	struct rxe_pool		mw_pool;
 	struct rxe_pool		mc_grp_pool;
 
+	/* multicast support */
 	spinlock_t		mcg_lock;
+	struct rb_root		mcg_tree;
+	atomic_t		mcg_num;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
@@ -477,6 +481,4 @@ static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
-void rxe_mc_cleanup(struct rxe_pool_elem *elem);
-
 #endif /* RXE_VERBS_H */
-- 
2.32.0

