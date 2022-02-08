Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E75E4AE3FA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387563AbiBHWZE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386862AbiBHVRS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:18 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA078C0612BE
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:16 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so182357oot.4
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=05c42XlWl134ALUFlEKXcrK4+zBYz/latDBJjpL3jn8=;
        b=IB8WHbIgG3P2/ouWRnaqemPXfmkq30IF37lb9bEwLx4OyqgTvjTB77E/DcYRa+za0w
         uxkHxgLy6tXX4n494TRp6HHD47MW+VgizWfLKli5DEaM2eKIv+rhi/lBhZh+c/ahLccB
         R0WQS3x5IlztDEsIxQyIhNzVFFw/hBt8knbM/YA/1cullbL+GmcGc+fwgowKfff3iO3N
         BTKSOJzQRfOn7SwnZpqVdgI345X2XyqwQEOLyoxTU1IL4bUazGZu3rpJ+rvheQe5harU
         cjxEqpGeo3WWxHuCgVfi9Z66TCEiLmB2uxd3sVhkVcmCzA7qCNPIEh4fRdliEDL6FQt6
         sRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=05c42XlWl134ALUFlEKXcrK4+zBYz/latDBJjpL3jn8=;
        b=npX3Tpr8OXInOJHGHfR0uP13BAW/foj1g+ddhQ9cCpDnhlBZ2bFrW3tYXFN8d5cByw
         PMxTtCW6d1B4wbv3DOkvNnT6PzPcnygaMoE9zL7HswCXJ2cMkdbquAqq2b/FN6x8V0Nc
         nEA088SrrjTLIJH2Y9HYioigglK8jMK//LX6lmhvzwlUQ871HRBAC827YS+AtFNPqora
         gsI4Ca+gu3ivudCRgsbLgaeql0SPrsEBGRvrYRFwCvrDLcXtQe8CYiGlepyhemOhYG4k
         LLOvVaNmRM858qrvLpQ+Jy8zZ2WBCq1qS2xZl/fsZ/QeGoP05lsOAUlorltH9NvjC+MM
         emUQ==
X-Gm-Message-State: AOAM532kZ7eu1sd5znuGMKbQgWbDntqlgKkAkUHMCEu6u/IWBV56QwvE
        00MLOb84DNZFkzzuKwq6mFw=
X-Google-Smtp-Source: ABdhPJxmgzInN8g5kbYQLHQRbmvxWxsc3ldby6MBrtC75vZ/tKAc3CynHVDzADjgIpqR+l/957gEIQ==
X-Received: by 2002:a05:6871:4c1:: with SMTP id n1mr951106oai.255.1644355035893;
        Tue, 08 Feb 2022 13:17:15 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:15 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 02/11] RDMA/rxe: Use kzmalloc/kfree for mca
Date:   Tue,  8 Feb 2022 15:16:36 -0600
Message-Id: <20220208211644.123457-3-rpearsonhpe@gmail.com>
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

Remove rxe_mca (was rxe_mc_elem) from rxe pools and use kzmalloc
and kfree to allocate and free in rxe_mcast.c. Call kzalloc
outside of spinlocks to avoid having to use GFP_ATOMIC.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   8 --
 drivers/infiniband/sw/rxe/rxe_mcast.c | 191 ++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.c  |   5 -
 drivers/infiniband/sw/rxe/rxe_pool.h  |   3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 -
 5 files changed, 120 insertions(+), 89 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index e74c4216b314..7386a51b953d 100644
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
index 4828274efbd4..3c06b0590c82 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -26,94 +26,102 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /* caller should hold rxe->mcg_lock */
-static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
-				     struct rxe_pool *pool,
-				     union ib_gid *mgid)
+static struct rxe_mcg *__rxe_create_grp(struct rxe_dev *rxe,
+					struct rxe_pool *pool,
+					union ib_gid *mgid)
 {
-	int err;
 	struct rxe_mcg *grp;
+	int err;
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
+	grp = rxe_alloc_locked(pool);
 	if (!grp)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_LIST_HEAD(&grp->qp_list);
-	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
-
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
 		rxe_drop_ref(grp);
 		return ERR_PTR(err);
 	}
 
+	INIT_LIST_HEAD(&grp->qp_list);
+	grp->rxe = rxe;
+
+	/* rxe_alloc_locked takes a ref on grp but that will be
+	 * dropped when grp goes out of scope. We need to take a ref
+	 * on the pointer that will be saved in the red-black tree
+	 * by rxe_add_key and used to lookup grp from mgid later.
+	 * Adding key makes object visible to outside so this should
+	 * be done last after the object is ready.
+	 */
+	rxe_add_ref(grp);
+	rxe_add_key_locked(grp, mgid);
+
 	return grp;
 }
 
-static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-			     struct rxe_mcg **grp_p)
+static struct rxe_mcg *rxe_mcast_get_grp(struct rxe_dev *rxe,
+					 union ib_gid *mgid)
 {
-	int err;
 	struct rxe_mcg *grp;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	spin_lock_bh(&rxe->mcg_lock);
-
 	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
-		goto done;
-
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
-		spin_unlock_bh(&rxe->mcg_lock);
-		err = PTR_ERR(grp);
-		return err;
-	}
-
-done:
+	if (!grp)
+		grp = __rxe_create_grp(rxe, pool, mgid);
 	spin_unlock_bh(&rxe->mcg_lock);
-	*grp_p = grp;
-	return 0;
+
+	return grp;
 }
 
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mcg *grp)
+				  struct rxe_mcg *grp)
 {
+	struct rxe_mca *mca, *tmp;
 	int err;
-	struct rxe_mca *elem;
 
-	/* check to see of the qp is already a member of the group */
+	/* check to see if the qp is already a member of the group */
+	spin_lock_bh(&rxe->mcg_lock);
+	list_for_each_entry(mca, &grp->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			spin_unlock_bh(&rxe->mcg_lock);
+			return 0;
+		}
+	}
+	spin_unlock_bh(&rxe->mcg_lock);
+
+	/* speculative alloc new mca without using GFP_ATOMIC */
+	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
+	if (!mca)
+		return -ENOMEM;
+
 	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(elem, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
+	/* re-check to see if someone else just attached qp */
+	list_for_each_entry(tmp, &grp->qp_list, qp_list) {
+		if (tmp->qp == qp) {
+			kfree(mca);
 			err = 0;
 			goto out;
 		}
 	}
 
+	/* check limits after checking if already attached */
 	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
+		kfree(mca);
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
+	/* protect pointer to qp in mca */
+	rxe_add_ref(qp);
+	mca->qp = qp;
 
-	grp->num_qp++;
-	elem->qp = qp;
 	atomic_inc(&qp->mcg_num);
-
-	list_add(&elem->qp_list, &grp->qp_list);
+	grp->num_qp++;
+	list_add(&mca->qp_list, &grp->qp_list);
 
 	err = 0;
 out:
@@ -121,45 +129,78 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
+/* caller should be holding rxe->mcg_lock */
+static void __rxe_destroy_grp(struct rxe_mcg *grp)
+{
+	/* first remove grp from red-black tree then drop ref */
+	rxe_drop_key_locked(grp);
+	rxe_drop_ref(grp);
+
+	rxe_mcast_delete(grp->rxe, &grp->mgid);
+}
+
+static void rxe_destroy_grp(struct rxe_mcg *grp)
+{
+	struct rxe_dev *rxe = grp->rxe;
+
+	spin_lock_bh(&rxe->mcg_lock);
+	__rxe_destroy_grp(grp);
+	spin_unlock_bh(&rxe->mcg_lock);
+}
+
+void rxe_mc_cleanup(struct rxe_pool_elem *elem)
+{
+	/* nothing left to do for now */
+}
+
 static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
 	struct rxe_mcg *grp;
-	struct rxe_mca *elem, *tmp;
-
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
-	if (!grp)
-		goto err1;
+	struct rxe_mca *mca, *tmp;
+	int err;
 
 	spin_lock_bh(&rxe->mcg_lock);
+	grp = rxe_pool_get_key_locked(&rxe->mc_grp_pool, mgid);
+	if (!grp) {
+		/* we didn't find the mcast group for mgid */
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			list_del(&mca->qp_list);
 
-	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
-			list_del(&elem->qp_list);
+			/* if the number of qp's attached to the
+			 * mcast group falls to zero go ahead and
+			 * tear it down. This will not free the
+			 * object since we are still holding a ref
+			 * from the get key above.
+			 */
 			grp->num_qp--;
+			if (grp->num_qp <= 0)
+				__rxe_destroy_grp(grp);
+
 			atomic_dec(&qp->mcg_num);
 
-			spin_unlock_bh(&rxe->mcg_lock);
-			rxe_drop_ref(elem);
-			rxe_drop_ref(grp);	/* ref held by QP */
-			rxe_drop_ref(grp);	/* ref from get_key */
-			return 0;
+			/* drop the ref from get key. This will free the
+			 * object if num_qp is zero.
+			 */
+			rxe_drop_ref(grp);
+			kfree(mca);
+			err = 0;
+			goto out_unlock;
 		}
 	}
 
-	spin_unlock_bh(&rxe->mcg_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
-err1:
-	return -EINVAL;
-}
-
-void rxe_mc_cleanup(struct rxe_pool_elem *elem)
-{
-	struct rxe_mcg *grp = container_of(elem, typeof(*grp), elem);
-	struct rxe_dev *rxe = grp->rxe;
+	/* we didn't find the qp on the list */
+	rxe_drop_ref(grp);
+	err = -EINVAL;
 
-	rxe_drop_key(grp);
-	rxe_mcast_delete(rxe, &grp->mgid);
+out_unlock:
+	spin_unlock_bh(&rxe->mcg_lock);
+	return err;
 }
 
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
@@ -170,12 +211,16 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_mcg *grp;
 
 	/* takes a ref on grp if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
-	if (err)
-		return err;
+	grp = rxe_mcast_get_grp(rxe, mgid);
+	if (IS_ERR(grp))
+		return PTR_ERR(grp);
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
 
+	/* if we failed to attach the first qp to grp tear it down */
+	if (grp->num_qp == 0)
+		rxe_destroy_grp(grp);
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
index 214279310f4d..9201bb6b8b07 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -23,7 +23,6 @@ enum rxe_elem_type {
 	RXE_TYPE_MR,
 	RXE_TYPE_MW,
 	RXE_TYPE_MC_GRP,
-	RXE_TYPE_MC_ELEM,
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
@@ -156,4 +155,6 @@ void rxe_elem_release(struct kref *kref);
 /* drop a reference on an object */
 #define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
 
+#define rxe_read_ref(obj) kref_read(&(obj)->elem.ref_cnt)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 9940c69cbb63..1b0f40881895 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -362,7 +362,6 @@ struct rxe_mcg {
 };
 
 struct rxe_mca {
-	struct rxe_pool_elem	elem;
 	struct list_head	qp_list;
 	struct rxe_qp		*qp;
 };
@@ -396,7 +395,6 @@ struct rxe_dev {
 	struct rxe_pool		mr_pool;
 	struct rxe_pool		mw_pool;
 	struct rxe_pool		mc_grp_pool;
-	struct rxe_pool		mc_elem_pool;
 
 	spinlock_t		mcg_lock;
 
-- 
2.32.0

