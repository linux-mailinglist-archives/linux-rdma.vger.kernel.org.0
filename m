Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D877642FE3F
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbhJOWgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbhJOWgH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F5C061762
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:34:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so14723006otq.12
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1mdN7kCN9kjK0XMT+xR4Lm7X6g+u0jgxqxhdxwqf9s=;
        b=GvZ0ULQiGeRZu5wQQZjoeh32bBktPq4McQFy6gMFR4Sqr5JZwCxisgqXtTE5eAqf0n
         CtT+6n5X8Idw97YtPAqg07WEdtCfY7d+qb/JzRiERutAZqS+6VDf+5I3tJtupT1vPIZ4
         7YszArJLMPjxE8u3P1iYtGOIEzNT44gvyDIfuzI5KwpxWgANrxS+ecCrty9KXSZ9ezq7
         CenjaZqfL7aqy7FdJeHpoOUSnK1AH86GhefmEw4ogSuYdJVELLW7kGSDbGND928EqA97
         uBpKF+JR8xs1J5rzudX/+uRX84KwoS1nVfxxDIueGQ9QjkEW5DmM/qTLH7C4CEbF5MW3
         57TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1mdN7kCN9kjK0XMT+xR4Lm7X6g+u0jgxqxhdxwqf9s=;
        b=sxiLWtWHfy/P8QHl/Xcl1DHrY9Es9AbIMgMjdM7FQ249dCeXr4chZEdvCec0I2bXxz
         ZyPYClphH1pWAzluliDubEWrcdMlmVF2awe9aGuvahpZJscyijP5cBkiEdTcLN8f7lPB
         KCOboZqhebg1f+HNBFvb9eRcVQqHy/kIRDh+u9mEq/CBsWi3D58+q3Ht/rgGknlJT1pV
         BfrXa5TkDCpuGxaf6c6SGu6vQwYWb+7Sjh82HMK19Mc2XM0RnwscKA8YVYwQQXs5xFFh
         m/HhVNApU531B0KHOEIIv2OVNZHRytL1BJ7/0VLLXUY1Owi670sYEVG7T/dvS6IYy0vJ
         Kc6g==
X-Gm-Message-State: AOAM5305XUpfU/MLbQTvQ/x44xSvlPq93H6gk2TX+oGubcAFGgdpv9qy
        PGyUXbwZQ7wmFrh5iOe1yorcG9g3rSo=
X-Google-Smtp-Source: ABdhPJwD1jHuIXj1RBTtujdbOxfdeiPzzIGvv2a8OY82tGHIseDko7zlFK9OW0PSHFOau0OMM2TMHg==
X-Received: by 2002:a05:6830:13c5:: with SMTP id e5mr10126590otq.374.1634337239739;
        Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 08/10] RDMA/rxe: Rewrite rxe_mcast.c
Date:   Fri, 15 Oct 2021 17:32:49 -0500
Message-Id: <20211015223250.6501-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rewrite rxe_mcast to support rxe_fini_ref and clean up referencing.
Drop mc_elem as rxe pool objects and just use kmalloc/kfree.
Take qp references as well as mc_grp references to force all mc groups
to be de-attached before destroying QPs. Simplify the api to rxe_verbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   8 -
 drivers/infiniband/sw/rxe/rxe_loc.h   |  11 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 205 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_net.c   |  22 ---
 drivers/infiniband/sw/rxe/rxe_pool.c  |   6 -
 drivers/infiniband/sw/rxe/rxe_pool.h  |   1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c |  12 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 +-
 8 files changed, 143 insertions(+), 125 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 8e0f9c489cab..4298a1d20ad5 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -31,7 +31,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
 	rxe_pool_cleanup(&rxe->mc_grp_pool);
-	rxe_pool_cleanup(&rxe->mc_elem_pool);
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
@@ -165,15 +164,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
 	if (err)
 		goto err9;
 
-	err = rxe_pool_init(rxe, &rxe->mc_elem_pool, RXE_TYPE_MC_ELEM,
-			    rxe->attr.max_total_mcast_qp_attach);
-	if (err)
-		goto err10;
-
 	return 0;
 
-err10:
-	rxe_pool_cleanup(&rxe->mc_grp_pool);
 err9:
 	rxe_pool_cleanup(&rxe->mw_pool);
 err8:
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index a25d1c9f6adb..78312df8eea3 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -38,19 +38,12 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 void rxe_cq_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mcast.c */
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p);
-
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mc_grp *grp);
-
+			   union ib_gid *mgid);
 int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    union ib_gid *mgid);
-
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
 
-void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-
 /* rxe_mmap.c */
 struct rxe_mmap_info {
 	struct list_head	pending_mmaps;
@@ -104,8 +97,6 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
-int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
-int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 337dc2c68051..f5a1492e9e48 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -5,116 +5,192 @@
  */
 
 #include "rxe.h"
-#include "rxe_loc.h"
 
-/* caller should hold mc_grp_pool->pool_lock */
-static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	int err;
+	unsigned char ll_addr[ETH_ALEN];
+
+	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+	err = dev_mc_add(rxe->ndev, ll_addr);
+
+	return err;
+}
+
+static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
+{
+	int err;
+	unsigned char ll_addr[ETH_ALEN];
+
+	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+	err = dev_mc_del(rxe->ndev, ll_addr);
+
+	return err;
+}
+
+static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
+		      struct rxe_mc_grp **grp_p)
+{
+	struct rxe_pool *pool = &rxe->mc_grp_pool;
 	struct rxe_mc_grp *grp;
+	unsigned long flags;
+	int err = 0;
+
+	/* Perform this while holding the mc_grp_pool lock
+	 * to prevent races where two coincident calls fail to lookup the
+	 * same group and then both create the same group.
+	 */
+	write_lock_irqsave(&pool->pool_lock, flags);
+	grp = rxe_pool_get_key_locked(pool, mgid);
+	if (grp)
+		goto done;
 
 	grp = rxe_alloc_with_key_locked(&rxe->mc_grp_pool, mgid);
-	if (!grp)
-		return ERR_PTR(-ENOMEM);
+	if (!grp) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
 
 	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_ref(grp);
-		return ERR_PTR(err);
+	if (err) {
+		rxe_fini_ref_locked(grp);
+		grp = NULL;
+		goto done;
 	}
 
-	return grp;
+	/* match the reference taken by get_key */
+	rxe_add_ref_locked(grp);
+done:
+	*grp_p = grp;
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return err;
 }
 
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p)
+static void rxe_mcast_put_grp(struct rxe_mc_grp *grp)
 {
-	int err;
-	struct rxe_mc_grp *grp;
+	struct rxe_dev *rxe = grp->rxe;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 	unsigned long flags;
 
-	if (rxe->attr.max_mcast_qp_attach == 0)
-		return -EINVAL;
-
 	write_lock_irqsave(&pool->pool_lock, flags);
 
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
-		goto done;
+	rxe_drop_ref_locked(grp);
 
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
-		write_unlock_irqrestore(&pool->pool_lock, flags);
-		err = PTR_ERR(grp);
-		return err;
+	if (rxe_read_ref(grp) == 1) {
+		rxe_mcast_delete(rxe, &grp->mgid);
+		rxe_fini_ref_locked(grp);
 	}
 
-done:
 	write_unlock_irqrestore(&pool->pool_lock, flags);
-	*grp_p = grp;
-	return 0;
 }
 
+/**
+ * rxe_mcast_add_grp_elem() - Associate a multicast address with a QP
+ * @rxe: the rxe device
+ * @qp: the QP
+ * @mgid: the multicast address
+ *
+ * Each multicast group can be associated with one or more QPs and
+ * each QP can be associated with zero or more multicast groups.
+ * Between each multicast group associated with a QP there is a
+ * rxe_mc_elem struct which has two list head structs and is joined
+ * both to a list of QPs on the multicast group and a list of groups
+ * on the QP. The elem has pointers to the group and the QP and
+ * takes a reference for each one.
+ *
+ * Return: 0 on success or an error on failure.
+ */
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mc_grp *grp)
+			   union ib_gid *mgid)
 {
-	int err;
 	struct rxe_mc_elem *elem;
+	struct rxe_mc_grp *grp;
+	int err;
+
+	if (rxe->attr.max_mcast_qp_attach == 0)
+		return -EINVAL;
+
+	/* takes a ref on grp if successful */
+	err = rxe_mcast_get_grp(rxe, mgid, &grp);
+	if (err)
+		return err;
 
-	/* check to see of the qp is already a member of the group */
 	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
+
+	/* check to see if the qp is already a member of the group */
 	list_for_each_entry(elem, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
-			err = 0;
-			goto out;
-		}
+		if (elem->qp == qp)
+			goto drop_ref;
 	}
 
 	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
-		goto out;
+		goto drop_ref;
 	}
 
-	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
-	if (!elem) {
+	if (atomic_read(&rxe->total_mcast_qp_attach) >=
+			rxe->attr.max_total_mcast_qp_attach) {
 		err = -ENOMEM;
-		goto out;
+		goto drop_ref;
 	}
 
-	/* each qp holds a ref on the grp */
-	rxe_add_ref(grp);
+	elem = kmalloc(sizeof(*elem), GFP_KERNEL);
+	if (!elem) {
+		err = -ENOMEM;
+		goto drop_ref;
+	}
 
+	atomic_inc(&rxe->total_mcast_qp_attach);
 	grp->num_qp++;
+	rxe_add_ref(qp);
 	elem->qp = qp;
+	/* still holding a ref on grp */
 	elem->grp = grp;
 
 	list_add(&elem->qp_list, &grp->qp_list);
 	list_add(&elem->grp_list, &qp->grp_list);
 
-	err = 0;
-out:
+	goto done;
+
+drop_ref:
+	rxe_drop_ref(grp);
+
+done:
 	spin_unlock_bh(&grp->mcg_lock);
 	spin_unlock_bh(&qp->grp_lock);
+
 	return err;
 }
 
+/**
+ * rxe_mcast_drop_grp_elem() - Dissociate multicast address and QP
+ * @rxe: the rxe device
+ * @qp: the QP
+ * @mgid: the multicast group
+ *
+ * Walk the list of group elements to find one which matches QP
+ * Then delete from group and qp lists and free pointers and the elem.
+ * Check to see if we have removed the last qp from group and delete
+ * it if so.
+ *
+ * Return: 0 on success else an error on failure
+ */
 int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    union ib_gid *mgid)
 {
-	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem, *tmp;
+	struct rxe_mc_grp *grp;
+	int err = 0;
 
 	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
-		goto err1;
+		return -EINVAL;
 
 	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
@@ -123,26 +199,28 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		if (elem->qp == qp) {
 			list_del(&elem->qp_list);
 			list_del(&elem->grp_list);
+			rxe_drop_ref(grp);
+			rxe_drop_ref(qp);
 			grp->num_qp--;
-
-			spin_unlock_bh(&grp->mcg_lock);
-			spin_unlock_bh(&qp->grp_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
-			return 0;
+			kfree(elem);
+			atomic_dec(&rxe->total_mcast_qp_attach);
+			goto done;
 		}
 	}
 
+	err = -EINVAL;
+done:
 	spin_unlock_bh(&grp->mcg_lock);
 	spin_unlock_bh(&qp->grp_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
-err1:
-	return -EINVAL;
+
+	rxe_mcast_put_grp(grp);
+
+	return err;
 }
 
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 {
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem;
 
@@ -162,15 +240,10 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 		list_del(&elem->qp_list);
 		grp->num_qp--;
 		spin_unlock_bh(&grp->mcg_lock);
-		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
-	}
-}
 
-void rxe_mc_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_mc_grp *grp = container_of(arg, typeof(*grp), pelem);
-	struct rxe_dev *rxe = grp->rxe;
-
-	rxe_mcast_delete(rxe, &grp->mgid);
+		kfree(elem);
+		atomic_dec(&rxe->total_mcast_qp_attach);
+		rxe_drop_ref(qp);
+		rxe_mcast_put_grp(grp);
+	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2cb810cb890a..fcdf998ec896 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,28 +20,6 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	int err;
-	unsigned char ll_addr[ETH_ALEN];
-
-	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-	err = dev_mc_add(rxe->ndev, ll_addr);
-
-	return err;
-}
-
-int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	int err;
-	unsigned char ll_addr[ETH_ALEN];
-
-	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-	err = dev_mc_del(rxe->ndev, ll_addr);
-
-	return err;
-}
-
 static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 				  struct in_addr *saddr,
 				  struct in_addr *daddr)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 955bb283c76a..59f1a1919e30 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -76,16 +76,10 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
 		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
-		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
 		.key_size	= sizeof(union ib_gid),
 	},
-	[RXE_TYPE_MC_ELEM] = {
-		.name		= "rxe-mc_elem",
-		.size		= sizeof(struct rxe_mc_elem),
-		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
-	},
 };
 
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2fe1009145a5..f04df69c52ba 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -28,7 +28,6 @@ enum rxe_elem_type {
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
 	RXE_TYPE_MC_GRP,
-	RXE_TYPE_MC_ELEM,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index ec1f72332737..1b5084fd10ab 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -984,20 +984,10 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
 
 static int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mc_grp *grp;
-
-	/* takes a ref on grp if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
-	if (err)
-		return err;
-
-	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
-	rxe_drop_ref(grp);
-	return err;
+	return rxe_mcast_add_grp_elem(rxe, qp, mgid);
 }
 
 static int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 35e041450090..4f1d7777f755 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -403,7 +403,8 @@ struct rxe_dev {
 	struct rxe_pool		mr_pool;
 	struct rxe_pool		mw_pool;
 	struct rxe_pool		mc_grp_pool;
-	struct rxe_pool		mc_elem_pool;
+
+	atomic_t		total_mcast_qp_attach;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.30.2

