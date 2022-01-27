Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A039749ED84
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbiA0ViM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344415AbiA0ViL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:11 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC5C061748
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:11 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m9so8483593oia.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKRcqVX17NA8lrzAfHpc3YdddULFvuDyZlT6fgrQiWk=;
        b=Xsd4KLgFY0YN/jU8vIEHSpBq4VNDXfoQsJspjQu2sMx8ZG5hf00oVOb2izUR2OdXt+
         J8poBFSmcxn0GKCSCsWOWPST+Ovkv9iSzYlPqpA+7w5gnVKjzuO+WlhAgJH0S8BdiLU3
         QNOPDX0KaTFQLGISveBveeW+weuQmxlqII8zjWBG40EVznZ1LC8kDH6PWbvpbLvMBMz2
         h+4oBkhHu171EGg1ceKwdW4pqDgHaXfOfoOrb/LEtBuC9xgKH2TOSH2i9kaRC0J9Bz84
         DNor69rJMh4iYv0OdiSBaomif9C1y70V6C2d6qLDxC8W0XHMhA7vZcIR6itShcNJ4QYZ
         I38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKRcqVX17NA8lrzAfHpc3YdddULFvuDyZlT6fgrQiWk=;
        b=T4TCWNipLJPejnGd8rWaFZ7tIrF1mZvnu+Ork1w0wzasxYhXcrRi9rUKwdy1BrpohW
         F26RSoIqFYu0CQ8xAR8G0WtMipERAWbLnE5tIiLaC1kmnAMHtff14ZivRNb4AyLZr9BB
         Ovfyy1ToyOLyfA9RO2SXNVg4/sdO2KkZsAdmDnE+cL50kipK9GnPLzwxCIWTKNAReYX7
         acvVVdz+RulgqdmGtcolSwa87pT6d8SZj3oODlAwWtn7ECHL1HBPuOTGKiZ9Dxcjaenl
         UNmdrxlok52SHmDvsSRbSR/aYymP7tXlZeNajtmXLhNLi9LkvCyOS3ZIgnzq5lL5qk9s
         fABw==
X-Gm-Message-State: AOAM532ZkipRuQ2XmAUiXziO6d0NAT5lvuvgnORRkJlJAiW+Xm+UKSjz
        9mp2sc+Iy+LaM4SVD8rJEJVgfbgvYZk=
X-Google-Smtp-Source: ABdhPJyR7NZyhlTcjkpwE9ka1PNwYI/0OzWoKEm2ZFfbZh9damou+6vkST7h9toI6ZoF5E7/N+CMDw==
X-Received: by 2002:aca:1011:: with SMTP id 17mr3370347oiq.27.1643319490811;
        Thu, 27 Jan 2022 13:38:10 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:10 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 07/26] RDMA/rxe: Use kzmalloc/kfree for mca
Date:   Thu, 27 Jan 2022 15:37:36 -0600
Message-Id: <20220127213755.31697-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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
to mcg when a new one is created and drop when the last qp is detached.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  8 -----
 drivers/infiniband/sw/rxe/rxe_mcast.c | 51 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  5 ---
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 --
 5 files changed, 30 insertions(+), 37 deletions(-)

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
index 9336295c4ee2..39f38ee665f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -36,6 +36,7 @@ static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
 	if (!grp)
 		return ERR_PTR(-ENOMEM);
+	rxe_add_ref(grp);
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
@@ -85,12 +86,28 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
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
@@ -101,20 +118,11 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
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
+	new_mca->qp = qp;
 	atomic_inc(&qp->mcg_num);
 
-	list_add(&elem->qp_list, &grp->qp_list);
+	list_add(&new_mca->qp_list, &grp->qp_list);
 
 	err = 0;
 out:
@@ -126,7 +134,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
 	struct rxe_mcg *grp;
-	struct rxe_mca *elem, *tmp;
+	struct rxe_mca *mca, *tmp;
 
 	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
@@ -134,16 +142,17 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_bh(&grp->mcg_lock);
 
-	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
-			list_del(&elem->qp_list);
+	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			list_del(&mca->qp_list);
 			grp->num_qp--;
+			if (grp->num_qp <= 0)
+				rxe_drop_ref(grp);
 			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&grp->mcg_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
 			rxe_drop_ref(grp);	/* ref from get_key */
+			kfree(mca);
 			return 0;
 		}
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

