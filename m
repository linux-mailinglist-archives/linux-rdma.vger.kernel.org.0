Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED207E28AF
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 16:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjKFPaA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 10:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjKFP37 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 10:29:59 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2C6100
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 07:29:56 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1e9c42fc0c9so1838859fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284595; x=1699889395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ot999bwSu+30wyuMjnVZ1J2tnwOfT2zetDIWC25BSk=;
        b=arngdwdgtvI3hHal8DnU385lQfOJomgtoQQ+MhgJYnKJJIjAhtCkz7o0nYlTQqDD90
         skmiHsiiYZFNIfkYYkXXAo4NCP2t7eXfqyPRsy4TblspRsa9oQNwDbEg8Mzu2ngPPjQe
         zxyiuDkYC5nXcAS9FL3IUAmUBKrQjthSasdHTt16AYN4WGO8iU0I/MFIbzcyNmr+We22
         5ig4GOAG8/ZUE7AG2PJurq9sIMCtGfNzvfrFkP9jEJfpEgnYsx0X4SF3XD3wyDj/k58y
         zvkSkZm0dtzhosqCHTpwes87cD7p5DPTdCeZn6qu11I3Ubeyb2KhzQTO7jiXmcqULbeN
         aZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284595; x=1699889395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ot999bwSu+30wyuMjnVZ1J2tnwOfT2zetDIWC25BSk=;
        b=th2Zd1c4Yhp4HUx6uJIkWxGfKsFLezy0uAInoN8pxRLbSyIjvkNA+uv6pwhZFYPzZT
         BYtw3wSzdHrbXulbKODAEVNjIRJlC8KbbRU0MrhSUhx5zUF1oAPjM1xLlLaZQw97HGYR
         95fN96IacvhsZ2egrZP+NK34e2e+N6T0+AWYQSe87SErgj0LXjJdoxfqbFd2p8f/pdja
         opro1J8mDaofqvaHXeDvAphKpEE7hdIVvYzNBaApUrvErWrZqc9JgtU1ObQoj7WOPLC1
         TLzSHKAHsAzFXpHoOu31Ro7Bmn0wfSTIXZAqxZINPwG20eM3NfmwRoYsKjiYJnXfJS2c
         5c1Q==
X-Gm-Message-State: AOJu0YzwzK96NRuP1DvEvvJRfcQXdL57uB0GNsflJy7e6BdUhNR49wQ5
        6z3mBMxqnA7VFu5RiP1JWpKehAthI3fYmg==
X-Google-Smtp-Source: AGHT+IEntAJJjV92zVXorPxQCX1vByno2b4tZXBw+JJKqVmmcnjiv0iRX5QRGALxO4Q6XDDghFY92w==
X-Received: by 2002:a05:6870:828a:b0:1ef:bae0:4bb8 with SMTP id q10-20020a056870828a00b001efbae04bb8mr13023oae.29.1699284595314;
        Mon, 06 Nov 2023 07:29:55 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id ds50-20020a0568705b3200b001e578de89cesm1438897oab.37.2023.11.06.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:29:54 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 6/6] RDMA/rxe: Cleanup mcg lifetime
Date:   Mon,  6 Nov 2023 09:29:29 -0600
Message-Id: <20231106152928.47869-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106152928.47869-1-rpearsonhpe@gmail.com>
References: <20231106152928.47869-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver has two different and not really
compatible ways of managing the lifetime of an mcast group,
by ref counting the mcg struct and counting the number of
attached qp's. They are each doing part of the job of cleaning
up an mcg when the last qp is detached and are racy in the
process. This patch removes using the use of the number of
qp's.

Fix up mcg reference counting so the ref count will drop
to zero correctly and move code from rxe_destroy_mcg to
rxe_cleanup_mcg since rxe_destroy is no longer needed.

This set of fixes scrambles the code in rxe_mast.c and as
a result a lot of cleanup has been done as well.

Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 170 +++++++-------------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   2 +-
 3 files changed, 46 insertions(+), 128 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 62b2b25903fc..0509ccdaa2f2 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -37,7 +37,7 @@ void rxe_cq_cleanup(struct rxe_pool_elem *elem);
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
-void rxe_cleanup_mcg(struct kref *kref);
+int rxe_put_mcg(struct rxe_mcg *mcg);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 937bfb99cf9c..57efb29702fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -124,13 +124,31 @@ static int rxe_mcast_del(struct rxe_mcg *mcg)
 	return err ?: err2;
 }
 
-/**
- * __rxe_insert_mcg - insert an mcg into red-black tree (rxe->mcg_tree)
- * @mcg: mcg object with an embedded red-black tree node
- *
- * Context: caller must hold a reference to mcg and rxe->mcg_mutex and
- * is responsible to avoid adding the same mcg twice to the tree.
- */
+static void __rxe_remove_mcg(struct rxe_mcg *mcg)
+{
+	rb_erase(&mcg->node, &mcg->rxe->mcg_tree);
+}
+
+static void rxe_cleanup_mcg(struct kref *kref)
+{
+	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
+
+	__rxe_remove_mcg(mcg);
+	rxe_mcast_del(mcg);
+	atomic_dec(&mcg->rxe->mcg_num);
+	kfree_rcu(mcg, rcu);
+}
+
+static int rxe_get_mcg(struct rxe_mcg *mcg)
+{
+	return kref_get_unless_zero(&mcg->ref_cnt);
+}
+
+int rxe_put_mcg(struct rxe_mcg *mcg)
+{
+	return kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+}
+
 static void __rxe_insert_mcg(struct rxe_mcg *mcg)
 {
 	struct rb_root *tree = &mcg->rxe->mcg_tree;
@@ -159,23 +177,11 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
 	rb_insert_color(&mcg->node, tree);
 }
 
-/**
- * __rxe_remove_mcg - remove an mcg from red-black tree holding lock
- * @mcg: mcast group object with an embedded red-black tree node
- *
- * Context: caller must hold a reference to mcg and rxe->mcg_mutex
- */
-static void __rxe_remove_mcg(struct rxe_mcg *mcg)
-{
-	rb_erase(&mcg->node, &mcg->rxe->mcg_tree);
-}
-
 /*
  * Lookup mgid in the multicast group red-black tree and try to
  * get a ref on it. Return mcg on success else NULL.
  */
-struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
-					union ib_gid *mgid)
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rb_root *tree = &rxe->mcg_tree;
 	struct rxe_mcg *mcg;
@@ -197,20 +203,14 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
 		else
 			break;
 	}
-	mcg = (node && kref_get_unless_zero(&mcg->ref_cnt)) ? mcg : NULL;
+	mcg = (node && rxe_get_mcg(mcg)) ? mcg : NULL;
 	rcu_read_unlock();
 
 	return mcg;
 }
 
-/**
- * rxe_get_mcg - lookup or allocate a mcg
- * @rxe: rxe device object
- * @mgid: multicast IP address as a gid
- *
- * Returns: mcg on success else ERR_PTR(error)
- */
-static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
+/* find an existing mcg or allocate a new one */
+static struct rxe_mcg *rxe_alloc_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg;
 	int err;
@@ -221,7 +221,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 		goto out;	/* nothing to do */
 
 	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
-		err = -ENOMEM;
+		err = -EINVAL;
 		goto err_dec;
 	}
 
@@ -237,19 +237,17 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	kref_init(&mcg->ref_cnt);
 	INIT_LIST_HEAD(&mcg->qp_list);
 	spin_lock_init(&mcg->lock);
-	kref_get(&mcg->ref_cnt);
-	__rxe_insert_mcg(mcg);
 
 	err = rxe_mcast_add(mcg);
 	if (err)
 		goto err_free;
 
+	__rxe_insert_mcg(mcg);
 out:
 	mutex_unlock(&rxe->mcg_mutex);
 	return mcg;
 
 err_free:
-	__rxe_remove_mcg(mcg);
 	kfree(mcg);
 err_dec:
 	atomic_dec(&rxe->mcg_num);
@@ -257,64 +255,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	return ERR_PTR(err);
 }
 
-/**
- * rxe_cleanup_mcg - cleanup mcg for kref_put
- * @kref: struct kref embnedded in mcg
- */
-void rxe_cleanup_mcg(struct kref *kref)
-{
-	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
-
-	kfree_rcu(mcg, rcu);
-}
-
-/**
- * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_mutex
- * @mcg: the mcg object
- *
- * Context: caller is holding rxe->mcg_mutex
- * no qp's are attached to mcg
- */
-static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	struct rxe_dev *rxe = mcg->rxe;
-
-	/* remove mcg from red-black tree then drop ref */
-	__rxe_remove_mcg(mcg);
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-
-	atomic_dec(&rxe->mcg_num);
-}
-
-/**
- * rxe_destroy_mcg - destroy mcg object
- * @mcg: the mcg object
- *
- * Context: no qp's are attached to mcg
- */
-static void rxe_destroy_mcg(struct rxe_mcg *mcg)
-{
-	/* delete mcast address outside of lock */
-	rxe_mcast_del(mcg);
-
-	mutex_lock(&mcg->rxe->mcg_mutex);
-	__rxe_destroy_mcg(mcg);
-	mutex_unlock(&mcg->rxe->mcg_mutex);
-}
-
-/**
- * rxe_attach_mcg - attach qp to mcg if not already attached
- * @qp: qp object
- * @mcg: mcg object
- *
- * Returns: 0 on success else an error
- */
-static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
+static int rxe_attach_mcg(struct rxe_qp *qp, struct rxe_mcg *mcg)
 {
 	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca;
 	unsigned long flags;
-	int err;
+	int err = 0;
 
 	mutex_lock(&rxe->mcg_mutex);
 	spin_lock_irqsave(&mcg->lock, flags);
@@ -348,29 +294,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	rxe_get(qp);
 	mca->qp = qp;
 
+	rxe_get_mcg(mcg);
+
 	spin_lock_irqsave(&mcg->lock, flags);
 	list_add_tail(&mca->qp_list, &mcg->qp_list);
 	spin_unlock_irqrestore(&mcg->lock, flags);
-out:
-	mutex_unlock(&rxe->mcg_mutex);
-	return 0;
+	goto out;
 
 err_dec_qp_num:
 	atomic_dec(&mcg->qp_num);
 err_dec_attach:
 	atomic_dec(&rxe->mcg_attach);
+out:
+	rxe_put_mcg(mcg);
 	mutex_unlock(&rxe->mcg_mutex);
 	return err;
 }
 
-/**
- * rxe_detach_mcg - detach qp from mcg
- * @mcg: mcg object
- * @qp: qp object
- *
- * Returns: 0 on success else an error if qp is not attached.
- */
-static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
+static int rxe_detach_mcg(struct rxe_qp *qp, struct rxe_mcg *mcg)
 {
 	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca;
@@ -387,7 +328,6 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	}
 	spin_unlock_irqrestore(&mcg->lock, flags);
 
-	/* we didn't find the qp on the list */
 	err = -EINVAL;
 	goto err_out;
 
@@ -395,23 +335,15 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	spin_lock_irqsave(&mcg->lock, flags);
 	list_del(&mca->qp_list);
 	spin_unlock_irqrestore(&mcg->lock, flags);
+	rxe_put_mcg(mcg);
 
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
 	atomic_dec(&mca->qp->mcg_num);
 	rxe_put(mca->qp);
 	kfree(mca);
-
-	/* if the number of qp's attached to the
-	 * mcast group falls to zero go ahead and
-	 * tear it down. This will not free the
-	 * object since we are still holding a ref
-	 * from the caller
-	 */
-	if (atomic_read(&mcg->qp_num) <= 0)
-		__rxe_destroy_mcg(mcg);
-
 err_out:
+	rxe_put_mcg(mcg);
 	mutex_unlock(&rxe->mcg_mutex);
 	return err;
 }
@@ -426,7 +358,6 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
  */
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *mcg;
@@ -434,20 +365,11 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (rxe->attr.max_mcast_grp == 0)
 		return -EINVAL;
 
-	/* takes a ref on mcg if successful */
-	mcg = rxe_get_mcg(rxe, mgid);
+	mcg = rxe_alloc_mcg(rxe, mgid);
 	if (IS_ERR(mcg))
 		return PTR_ERR(mcg);
 
-	err = rxe_attach_mcg(mcg, qp);
-
-	/* if we failed to attach the first qp to mcg tear it down */
-	if (atomic_read(&mcg->qp_num) == 0)
-		rxe_destroy_mcg(mcg);
-
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-
-	return err;
+	return rxe_attach_mcg(qp, mcg);
 }
 
 /**
@@ -463,14 +385,10 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *mcg;
-	int err;
 
 	mcg = rxe_lookup_mcg(rxe, mgid);
 	if (!mcg)
 		return -EINVAL;
 
-	err = rxe_detach_mcg(mcg, qp);
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-
-	return err;
+	return rxe_detach_mcg(qp, mcg);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 6cf0da958864..e3ec3dfc57f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -262,7 +262,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	spin_unlock_irqrestore(&mcg->lock, flags);
 
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+	rxe_put_mcg(mcg);
 
 	if (likely(!skb))
 		return;
-- 
2.40.1

