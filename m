Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB634A5216
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiAaWKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiAaWKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CAAC061401
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:10 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id b186so23383746oif.1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7mNkfbEPoi1rj5yhVKQHMSqY7aHIAY5Ekm/rxrD91Q=;
        b=GYRr4jeZCGwYD9Z1txV83M/K33/ReoRk4+f/jD0BzrcttzrugIG52SuyUjn2LNGZN1
         KiXJ7YCzZFVOhS5NpeWNwGOf5FW7cD6rbKadzmRAJyVwc40wNzT/kKqIerRuqZM3zyLR
         ZtHhIvd2U01/1htgkvC6wUWncMKetbc+QfMEXgKKwENgbLnQC0Oxkf5dJTuiEwwUEs8B
         GmEX+nOOMIvWb5NxMg9bxRISuLcv7WMz0hktCMt2wdyMvTWRtbrGMnk33XxBT6+EwUjt
         rgouFwbLCB+3No8D8swGzVx4u9u4/z/9EgJsl/0JfZo/C98s/IRPJrVgORrZf0xh0pCq
         0Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7mNkfbEPoi1rj5yhVKQHMSqY7aHIAY5Ekm/rxrD91Q=;
        b=XtEnGQa8RUPn+WPQ77VUCxIAu0BAI3z5OT4XGuybUUSrGu5nZmxLJAABWcgyYz4iYs
         Tdh+7n4qmnzldBB/5iO4uzcBxSBEZQu6HxiZd/TWA7HtZlxXyfaMfWo8zE3uiGjwe4qS
         Kx3M9JajuBk1OoesDAgLLI0r5JpkZ/eXrsmZUaey52+PrY3Yjg3tIo34EpNfqFzyJUqb
         MyQKUtvLSH3RWYHtJpFBXgyzQ4whYKrmw58gkQwbWPc4AVYZScG20Fy/1RSQmiNqSerG
         LzbWFp9cLxq9cZlw+yDjlz7aaiGaFpKDLimVRIHEKikil0ydCb1DRdh9XNCv1xKFEL9H
         gCiQ==
X-Gm-Message-State: AOAM5319b56b6hs6DItnS9u7lguOdwNcDCpoc8TUFSfB1ZrfU/Hiyat8
        YN8CQ7U8o5g4Sj2xeAd8hHY=
X-Google-Smtp-Source: ABdhPJzv0ArcNB7y4SO8sEdX/sVtP5ae/opYwjOdQb1o+deUNX2jrUI4P6/grWMnLRlJ8JRCGNVXFQ==
X-Received: by 2002:a54:4011:: with SMTP id x17mr14058186oie.255.1643667009519;
        Mon, 31 Jan 2022 14:10:09 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:09 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 07/17] RDMA/rxe: Use kzmalloc/kfree for mca
Date:   Mon, 31 Jan 2022 16:08:40 -0600
Message-Id: <20220131220849.10170-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove rxe_mca (was rxe_mc_elem) from rxe pools and use kzmalloc
and kfree to allocate and free. Use the sequence

    <lookup qp>
    new_mca = kzalloc(sizeof(*new_mca), GFP_KERNEL);
    <spin lock>
    <lookup qp again> /* in case of a race */
    <init new_mca>
    <spin unlock>

instead of GFP_ATOMIC inside of the spinlock. Add an extra reference
to multicast group to protect the pointer in the index that maps
mgid to group.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   8 --
 drivers/infiniband/sw/rxe/rxe_mcast.c | 102 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.c  |   5 --
 drivers/infiniband/sw/rxe/rxe_pool.h  |   1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 -
 5 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index fab291245366..c55736e441e7 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -29,7 +29,6 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
 	rxe_pool_cleanup(&rxe->mc_grp_pool);
-	rxe_pool_cleanup(&rxe->mc_elem_pool);
 
 	if (rxe->tfm)
 		crypto_free_shash(rxe->tfm);
@@ -163,15 +162,8 @@ static int rxe_init_pools(struct rxe_dev *rxe)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 9336295c4ee2..4a5896a225a6 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -26,30 +26,40 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /* caller should hold mc_grp_pool->pool_lock */
-static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+static int __rxe_create_grp(struct rxe_dev *rxe, struct rxe_pool *pool,
+			    union ib_gid *mgid, struct rxe_mcg **grp_p)
 {
 	int err;
 	struct rxe_mcg *grp;
 
 	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
 	if (!grp)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
+
+	err = rxe_mcast_add(rxe, mgid);
+	if (unlikely(err)) {
+		rxe_drop_ref(grp);
+		return err;
+	}
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
+
+	rxe_add_ref(grp);
 	rxe_add_key_locked(grp, mgid);
 
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
-		rxe_drop_ref(grp);
-		return ERR_PTR(err);
-	}
+	*grp_p = grp;
+	return 0;
+}
+
+/* caller is holding a ref from lookup and mcg->mcg_lock*/
+void __rxe_destroy_mcg(struct rxe_mcg *grp)
+{
+	rxe_drop_key(grp);
+	rxe_drop_ref(grp);
 
-	return grp;
+	rxe_mcast_delete(grp->rxe, &grp->mgid);
 }
 
 static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
@@ -68,10 +78,9 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (grp)
 		goto done;
 
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
+	err = __rxe_create_grp(rxe, pool, mgid, &grp);
+	if (err) {
 		write_unlock_bh(&pool->pool_lock);
-		err = PTR_ERR(grp);
 		return err;
 	}
 
@@ -85,36 +94,44 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mcg *grp)
 {
 	int err;
-	struct rxe_mca *elem;
+	struct rxe_mca *mca, *new_mca;
 
-	/* check to see of the qp is already a member of the group */
+	/* check to see if the qp is already a member of the group */
 	spin_lock_bh(&grp->mcg_lock);
-	list_for_each_entry(elem, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
+	list_for_each_entry(mca, &grp->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			spin_unlock_bh(&grp->mcg_lock);
+			return 0;
+		}
+	}
+	spin_unlock_bh(&grp->mcg_lock);
+
+	/* speculative alloc new mca without using GFP_ATOMIC */
+	new_mca = kzalloc(sizeof(*mca), GFP_KERNEL);
+	if (!new_mca)
+		return -ENOMEM;
+
+	spin_lock_bh(&grp->mcg_lock);
+	/* re-check to see if someone else just attached qp */
+	list_for_each_entry(mca, &grp->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			kfree(new_mca);
 			err = 0;
 			goto out;
 		}
 	}
+	mca = new_mca;
 
 	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	elem = rxe_alloc_locked(&rxe->mc_elem_pool);
-	if (!elem) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* each qp holds a ref on the grp */
-	rxe_add_ref(grp);
-
 	grp->num_qp++;
-	elem->qp = qp;
+	mca->qp = qp;
 	atomic_inc(&qp->mcg_num);
 
-	list_add(&elem->qp_list, &grp->qp_list);
+	list_add(&mca->qp_list, &grp->qp_list);
 
 	err = 0;
 out:
@@ -126,7 +143,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
 	struct rxe_mcg *grp;
-	struct rxe_mca *elem, *tmp;
+	struct rxe_mca *mca, *tmp;
 
 	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
@@ -134,33 +151,30 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_bh(&grp->mcg_lock);
 
-	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
-			list_del(&elem->qp_list);
+	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			list_del(&mca->qp_list);
 			grp->num_qp--;
+			if (grp->num_qp <= 0)
+				__rxe_destroy_mcg(grp);
 			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&grp->mcg_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
+			rxe_drop_ref(grp);
+			kfree(mca);
 			return 0;
 		}
 	}
 
 	spin_unlock_bh(&grp->mcg_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
+	rxe_drop_ref(grp);
 err1:
 	return -EINVAL;
 }
 
 void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mcg *grp = container_of(elem, typeof(*grp), elem);
-	struct rxe_dev *rxe = grp->rxe;
-
-	rxe_drop_key(grp);
-	rxe_mcast_delete(rxe, &grp->mgid);
+	/* nothing left to do */
 }
 
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
@@ -170,13 +184,15 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *grp;
 
-	/* takes a ref on grp if successful */
 	err = rxe_mcast_get_grp(rxe, mgid, &grp);
 	if (err)
 		return err;
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
+	if (grp->num_qp == 0)
+		__rxe_destroy_mcg(grp);
+
 	rxe_drop_ref(grp);
 	return err;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 63c594173565..a6756aa93e2b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -90,11 +90,6 @@ static const struct rxe_type_info {
 		.key_offset	= offsetof(struct rxe_mcg, mgid),
 		.key_size	= sizeof(union ib_gid),
 	},
-	[RXE_TYPE_MC_ELEM] = {
-		.name		= "rxe-mc_elem",
-		.size		= sizeof(struct rxe_mca),
-		.elem_offset	= offsetof(struct rxe_mca, elem),
-	},
 };
 
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 214279310f4d..511f81554fd1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -23,7 +23,6 @@ enum rxe_elem_type {
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
 	RXE_TYPE_MC_GRP,
-	RXE_TYPE_MC_ELEM,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 55f8ed2bc621..02745d51c163 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -363,7 +363,6 @@ struct rxe_mcg {
 };
 
 struct rxe_mca {
-	struct rxe_pool_elem	elem;
 	struct list_head	qp_list;
 	struct rxe_qp		*qp;
 };
@@ -397,7 +396,6 @@ struct rxe_dev {
 	struct rxe_pool		mr_pool;
 	struct rxe_pool		mw_pool;
 	struct rxe_pool		mc_grp_pool;
-	struct rxe_pool		mc_elem_pool;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

