Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2F49ED88
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbiA0ViR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344436AbiA0ViQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:16 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0800C06175A
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:14 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id g205so8542403oif.5
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7pk3vhMtPwznDg39XcANW8sSNurQHc3ldY1ET245D0=;
        b=cWz50evUl0ape74OENewsWkvu/YL0zBI4KAQ6NYvVITBpjuYp2xR3SV+W8k7qqJfxi
         D+siUgY/R+SBHCu3C7EI/eNbb9OTXUPiSxfqpxuJ5+M5vkm1Cytcp1XrsIPxN9aM2x1k
         g73vmsL3iU3W52qfJwrfgY6hHEW3jFirpm1b1hk9ud8IUoekdkFg+AngWulfIoFgHXHP
         Uyh2/SM+/SMQjFO8+XktUkCjdk12zmTXoRKLdOWjj9FB1GqsK/YqSc7p3xdh/cgDTapG
         P7mg7AbuB4xKc8Nnv0q3feLv1blEeTfuqeNKLgXw3/twsC+wQORpTQl8M+wKNUzswKoE
         054A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E7pk3vhMtPwznDg39XcANW8sSNurQHc3ldY1ET245D0=;
        b=jJd5KoB+/K5OQt/DRU6NZeufiGBFfG13WwbEKZWMQqDK+8vvh9fsJmO5PMO+GU+96t
         hobXaLrLFFNxRgSDWh/2X11jjvCYGW6XIb/VBDJ4caRORzdB3Gg5Fi2oKOtCpkQ2X4W+
         oXz2xEcemO6nwz/vpP4qlXOXBU3r1bSb/hokwxVsqQNHXO2Eszx39r4Lmq6+sP1tA7nT
         5Tfx7MVSlViMxEnIFr5NW2KAocPonQjzsjY8Xo412KA45fq7IKqdKiqy2gdBtvuB5kQm
         Fy8sAWy/KNbA03/AIwB8XA58w9tpQuOt1B+iZ01WPQVyYEzFyPWZXvIOy/xDcRdaAEu2
         Pr6A==
X-Gm-Message-State: AOAM531KBk2nm+xDSgx7btpfmvkTZv55AOM0ecJf+yRKbu0Er8Q66nq+
        F9BJMjDnPuOAHIfOAfDlD5i+dW+PRn0=
X-Google-Smtp-Source: ABdhPJwERq6AZQluPlyZ7G7/lVITSe/3pTnMiLOE59i8CatsqNB3qu+uCJHu2CFnXK1KJ4idg6xEyg==
X-Received: by 2002:aca:4286:: with SMTP id p128mr3425142oia.220.1643319494113;
        Thu, 27 Jan 2022 13:38:14 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:13 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 12/26] RDMA/rxe: Replace pool key by rxe->mcg_tree
Date:   Thu, 27 Jan 2022 15:37:41 -0600
Message-Id: <20220127213755.31697-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Continuing to decouple mcg from rxe pools. Create red-black tree code
in rxe_mcast.c to hold mcg index.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 187 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 +
 5 files changed, 159 insertions(+), 39 deletions(-)

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
index af40e3c212fb..d9faf3a1ee61 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,9 +40,10 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-void rxe_mc_cleanup(struct rxe_pool_elem *arg);
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
+void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 62ace10206b0..4c3eb9c723b4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -25,60 +25,172 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
-/* caller should hold mc_grp_rxe->mcg_lock */
-static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+/**
+ * __rxe_insert_mcg - insert an mcg into red-black tree (rxe->mcg_tree)
+ * @mcg: mcast group object with an embedded red-black tree node
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
-		return ERR_PTR(-ENOMEM);
-	rxe_add_ref(mcg);
+	node = tree->rb_node;
 
-	INIT_LIST_HEAD(&mcg->qp_list);
-	mcg->rxe = rxe;
-	rxe_add_key_locked(mcg, mgid);
+	while (node) {
+		mcg = rb_entry(node, struct rxe_mcg, node);
 
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_key_locked(mcg);
-		rxe_drop_ref(mcg);
-		return ERR_PTR(err);
+		cmp = memcmp(&mcg->mgid, mgid, sizeof(*mgid));
+
+		if (cmp > 0)
+			node = node->rb_left;
+		else if (cmp < 0)
+			node = node->rb_right;
+		else
+			break;
 	}
 
-	return mcg;
+	if (node) {
+		rxe_add_ref(mcg);
+		return mcg;
+	}
+
+	return NULL;
 }
 
-static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-			     struct rxe_mcg **mcgp)
+/**
+ * rxe_lookup_mcg - lookup up mcg in red-back tree
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ *
+ * Returns: mcg if found else NULL
+ */
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	int err;
 	struct rxe_mcg *mcg;
+
+	spin_lock_bh(&rxe->mcg_lock);
+	mcg = __rxe_lookup_mcg(rxe, mgid);
+	spin_unlock_bh(&rxe->mcg_lock);
+
+	return mcg;
+}
+
+/**
+ * rxe_get_mcg - lookup or allocate a mcg
+ * @rxe: rxe device object
+ * @mgid: multicast IP address
+ * @mcgp: address of returned mcg value
+ *
+ * Adds one ref if mcg already exists else add a second reference
+ * which is dropped when qp_num goes to zero.
+ *
+ * Returns: 0 and sets *mcgp to mcg on success else an error
+ */
+static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
+		       struct rxe_mcg **mcgp)
+{
+	struct rxe_mcg *mcg, *tmp;
+	int ret;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
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
+	/* speculative alloc of mcg without using GFP_ATOMIC */
+	mcg = rxe_alloc(pool);
+	if (!mcg)
+		return -ENOMEM;
 
-	mcg = create_grp(rxe, pool, mgid);
-	if (IS_ERR(mcg)) {
+	spin_lock_bh(&rxe->mcg_lock);
+	/* re-check to see if someone else just added it */
+	tmp = __rxe_lookup_mcg(rxe, mgid);
+	if (tmp) {
 		spin_unlock_bh(&rxe->mcg_lock);
-		err = PTR_ERR(mcg);
-		return err;
+		rxe_drop_ref(mcg);
+		mcg = tmp;
+		goto out;
 	}
 
-done:
+	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp)
+		goto err_dec;
+
+	ret = rxe_mcast_add(rxe, mgid);
+	if (ret)
+		goto err_out;
+
+	rxe_add_ref(mcg);
+	mcg->rxe = rxe;
+	memcpy(&mcg->mgid, mgid, sizeof(*mgid));
+	INIT_LIST_HEAD(&mcg->qp_list);
+	atomic_inc(&rxe->mcg_num);
+	__rxe_insert_mcg(mcg);
 	spin_unlock_bh(&rxe->mcg_lock);
+out:
 	*mcgp = mcg;
 	return 0;
+
+err_dec:
+	atomic_dec(&rxe->mcg_num);
+	ret = -ENOMEM;
+err_out:
+	spin_unlock_bh(&rxe->mcg_lock);
+	rxe_drop_ref(mcg);
+	return ret;
 }
 
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
@@ -136,7 +248,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mca *mca, *tmp;
 	int n;
 
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	mcg = rxe_lookup_mcg(rxe, mgid);
 	if (!mcg)
 		goto err1;
 
@@ -151,14 +263,14 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&rxe->mcg_lock);
-			rxe_drop_ref(mcg);	/* ref from get_key */
+			rxe_drop_ref(mcg);
 			kfree(mca);
 			return 0;
 		}
 	}
 
 	spin_unlock_bh(&rxe->mcg_lock);
-	rxe_drop_ref(mcg);			/* ref from get_key */
+	rxe_drop_ref(mcg);
 err1:
 	return -EINVAL;
 }
@@ -168,7 +280,10 @@ void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 	struct rxe_mcg *mcg = container_of(elem, typeof(*mcg), elem);
 	struct rxe_dev *rxe = mcg->rxe;
 
-	rxe_drop_key(mcg);
+	spin_lock_bh(&rxe->mcg_lock);
+	__rxe_remove_mcg(mcg);
+	spin_unlock_bh(&rxe->mcg_lock);
+
 	rxe_mcast_delete(rxe, &mcg->mgid);
 }
 
@@ -180,7 +295,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_mcg *mcg;
 
 	/* takes a ref on mcg if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &mcg);
+	err = rxe_get_mcg(rxe, mgid, &mcg);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 11246589fda7..f1ca83e09160 100644
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

