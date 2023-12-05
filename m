Return-Path: <linux-rdma+bounces-255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C395E80435C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532BD1F2139C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B60A59;
	Tue,  5 Dec 2023 00:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIeIxLuH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED8AC
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:26:39 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1faf152a1dbso2827233fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735998; x=1702340798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvxHjSrzMnuGgT7hgLHumBNegp7XoJoR3wahzbsn2B0=;
        b=EIeIxLuH3MxCsQfdP8Kie8rZtsF0ImpH7JGafgV1I3HtK+AYLbCF0T1jrmZ0DzvRuK
         z+w49evMgchDb3FisdLSW3oqJcHsjQ5MZr5DMdUrv8RhCpQu3keQjCR4Mn6BMjMf6ftA
         gca03IHpqf7Mbrmb2QsXCPStZ5bKPiFc1QZzOf7mkFh/5IrMmA+f6LUITKD1y1zMyBDN
         rKMij37120JlO+u9m2tVHOb4u9/ph0xx5jjeWiYrqQeokeGcBQEfRcho3tv/0YM06Uuu
         0m6Rs++Nzg4V83upzBOKtXmQkWmdKgGUW+tf2wwHtyhJK5yEZUeD7q+z4c6uGVkkDT1k
         jLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735998; x=1702340798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvxHjSrzMnuGgT7hgLHumBNegp7XoJoR3wahzbsn2B0=;
        b=RB8IarTCARpijJC7cI1QIWo1FerWntnS7bBny7ceQnmxDP8z0QESSM2EcycauVNUSW
         HjxPBrkXx0ALqSYiYtJG+0Bvh86gwzTmjN1CcaseR3r2nObUfywAh9L8N/MDTQn69w3h
         QWO4yARzmPnUwEVtsHB3JFJppCDSrhxBLmX2mR7VWi7HAQLyNl2IQp9fTfGv/s+fDKHu
         kSbMzP83x1c6hlxFHIsnC6oSVgJmq/WFeMaWN1Krd+M2vQgErfL/muSVU4tBfUTUyLRo
         HPps4COuZzduVmchz56EeLdf9NKHA5WXydqeAR1N3yQ1kunTdXC+lArbifqPs4gbENFn
         fbJw==
X-Gm-Message-State: AOJu0YzsiJ54c0BASSssKY8qKfjghxeKAU3y6bbKUa2nExOptWhjT4k0
	PzrtdbWayzheIFUAqdNY31E=
X-Google-Smtp-Source: AGHT+IEN7bnNpiH4Gf/e0MD2Pv26lHhKJUFu2MwOm6w3ApGEzdqEiVzvu6bDuWJgjOvo0j3vudFQ8g==
X-Received: by 2002:a05:6870:4c17:b0:1fb:20ca:95df with SMTP id pk23-20020a0568704c1700b001fb20ca95dfmr4618673oab.39.1701735998482;
        Mon, 04 Dec 2023 16:26:38 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id se6-20020a05687122c600b001faf09f0899sm2524844oab.24.2023.12.04.16.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:26:37 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 6/7] RDMA/rxe: Cleanup mcg lifetime
Date: Mon,  4 Dec 2023 18:26:13 -0600
Message-Id: <20231205002613.10219-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205002613.10219-1-rpearsonhpe@gmail.com>
References: <20231205002613.10219-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index ac8da0bc8428..c2a28aed9d34 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -131,13 +131,31 @@ static int rxe_mcast_del(struct rxe_mcg *mcg)
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
@@ -166,23 +184,11 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
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
@@ -204,20 +210,14 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
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
@@ -228,7 +228,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 		goto out;	/* nothing to do */
 
 	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
-		err = -ENOMEM;
+		err = -EINVAL;
 		goto err_dec;
 	}
 
@@ -244,19 +244,17 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
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
@@ -264,64 +262,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
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
@@ -355,29 +301,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
@@ -394,7 +335,6 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	}
 	spin_unlock_irqrestore(&mcg->lock, flags);
 
-	/* we didn't find the qp on the list */
 	err = -EINVAL;
 	goto err_out;
 
@@ -402,23 +342,15 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
@@ -433,7 +365,6 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
  */
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *mcg;
@@ -441,20 +372,11 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
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
@@ -470,14 +392,10 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
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


