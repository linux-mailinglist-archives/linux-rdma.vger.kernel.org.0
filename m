Return-Path: <linux-rdma+bounces-234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA90803EF5
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAD81C20B5D
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627CB33CCF;
	Mon,  4 Dec 2023 20:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIxwEIvb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C11D2
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:04:14 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d06bfadf8so3561508eaf.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720253; x=1702325053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faFndcVEGOusd95yP5wIIwP8EG4hzR/8+1lt60PbKyk=;
        b=ZIxwEIvbq47sefbJe3JVDT0I8D1XcED3xokzxxVveQx02oKpNGpER+wGTHnkTS85bd
         b4NRKzUW5IJHspOyvRGBpA9Y814TckzoHgZTGEPmjdfumEwdINpjzWcAfzaOkb75v02B
         3VA/IjEHXy2JO/egnDosE/q9KDSkq+Sy5UP9awruj1ZiVu8B25duRU7tWYhNrUuYgqMY
         DKQOD0phhBuDA4/s/HFpfYwnnq+DqYJonmlSscy90GOhF1jiBqbhgPbuMdUQaO/3nyJJ
         1RlLnkCd90bO7I4klwnNz0MaW7gULbZrncDEn+UdVNlbZUBINomENyOTbyZW8lQQJyFj
         f4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720253; x=1702325053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faFndcVEGOusd95yP5wIIwP8EG4hzR/8+1lt60PbKyk=;
        b=TbkNn0VRptvanlrOsmGObtpbmcbmd6FITnqeKyZwcl3x003wFPneGNdP4ETefq6dH1
         FaAfRb+ORmc53ZzDbqquq30iBzqCA2qTINqIMxKPUk1oNxIgtx4APOO8D1HD33M2DgYx
         ghAM9WbD0tLDvx1K7eG3dCpHGB2L+K6OOtqI0dknXhJPb2jMGulDRECaivKL+w5zzf4r
         yjJGrRK4vsaXAd5RrcbJmrx4S2x1eJbFjBn1HAM7apKlkjEna2B7JF/zKFMnHxv1+/Fi
         kPOAnCsZ1AvGspUliToJ5Hx0sVoNCwWv2GuHRhZN5MZXkCfEkOVEjk36XVzenYeBat53
         2ARw==
X-Gm-Message-State: AOJu0YxuFrsCROSjX8O745nnbYEg8SIbvZTuh3umWbHzQyzUU0r3DZWW
	bOgOYcXHdMoMN/eD93xDuow=
X-Google-Smtp-Source: AGHT+IFjoQw2Nf1SsCJg6RHH42ACnJqWlJlrOARCkXQguAjPK6+L3r8ZRDBSUwgPbIgFjPYXPnYddw==
X-Received: by 2002:a05:6820:502:b0:58d:6c99:fddb with SMTP id m2-20020a056820050200b0058d6c99fddbmr4959158ooj.8.1701720253498;
        Mon, 04 Dec 2023 12:04:13 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id e72-20020a4a554b000000b0054f85f67f31sm537281oob.46.2023.12.04.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:04:13 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 5/7] RDMA/rxe: Split multicast lock
Date: Mon,  4 Dec 2023 14:03:41 -0600
Message-Id: <20231204200342.7125-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204200342.7125-1-rpearsonhpe@gmail.com>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split rxe->mcg_lock into two locks. One to protect mcg->qp_list
and one to protect rxe->mcg_tree (red-black tree) write side
operations and provide serialization between rxe_attach_mcast
and rxe_detach_mcast.

Make the qp_list lock a spin_lock_irqsave lock and move to the
mcg struct. It protects the qp_list from simultaneous access
from rxe_mcast.c and rxe_recv.c when processing incoming multi-
cast packets. In theory some ethernet driver could bypass NAPI
so an irq lock is better than a bh lock.

Make the mcg_tree lock a mutex since the attach/detach APIs are
not called in atomic context. This allows some significant cleanup
since we can call kzalloc while holding the mutex so some recheck
code can be eliminated.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |   2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 254 ++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 +-
 4 files changed, 105 insertions(+), 159 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 54c723a6edda..147cb16e937d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -142,7 +142,7 @@ static void rxe_init(struct rxe_dev *rxe)
 	INIT_LIST_HEAD(&rxe->pending_mmaps);
 
 	/* init multicast support */
-	spin_lock_init(&rxe->mcg_lock);
+	mutex_init(&rxe->mcg_mutex);
 	rxe->mcg_tree = RB_ROOT;
 
 	mutex_init(&rxe->usdev_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 428ecc510fdd..990d5f6ab0eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -133,7 +133,7 @@ static int rxe_mcast_del(struct rxe_mcg *mcg)
  * __rxe_insert_mcg - insert an mcg into red-black tree (rxe->mcg_tree)
  * @mcg: mcg object with an embedded red-black tree node
  *
- * Context: caller must hold a reference to mcg and rxe->mcg_lock and
+ * Context: caller must hold a reference to mcg and rxe->mcg_mutex and
  * is responsible to avoid adding the same mcg twice to the tree.
  */
 static void __rxe_insert_mcg(struct rxe_mcg *mcg)
@@ -168,7 +168,7 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
  * __rxe_remove_mcg - remove an mcg from red-black tree holding lock
  * @mcg: mcast group object with an embedded red-black tree node
  *
- * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ * Context: caller must hold a reference to mcg and rxe->mcg_mutex
  */
 static void __rxe_remove_mcg(struct rxe_mcg *mcg)
 {
@@ -208,34 +208,6 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
 	return mcg;
 }
 
-/**
- * __rxe_init_mcg - initialize a new mcg
- * @rxe: rxe device
- * @mgid: multicast address as a gid
- * @mcg: new mcg object
- *
- * Context: caller should hold rxe->mcg lock
- */
-static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
-			   struct rxe_mcg *mcg)
-{
-	kref_init(&mcg->ref_cnt);
-	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
-	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
-	INIT_LIST_HEAD(&mcg->qp_list);
-	mcg->rxe = rxe;
-
-	/* caller holds a ref on mcg but that will be
-	 * dropped when mcg goes out of scope. We need to take a ref
-	 * on the pointer that will be saved in the red-black tree
-	 * by __rxe_insert_mcg and used to lookup mcg from mgid later.
-	 * Inserting mcg makes it visible to outside so this should
-	 * be done last after the object is ready.
-	 */
-	kref_get(&mcg->ref_cnt);
-	__rxe_insert_mcg(mcg);
-}
-
 /**
  * rxe_get_mcg - lookup or allocate a mcg
  * @rxe: rxe device object
@@ -245,51 +217,48 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
  */
 static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	struct rxe_mcg *mcg, *tmp;
+	struct rxe_mcg *mcg;
 	int err;
 
-	if (rxe->attr.max_mcast_grp == 0)
-		return ERR_PTR(-EINVAL);
-
-	/* check to see if mcg already exists */
+	mutex_lock(&rxe->mcg_mutex);
 	mcg = rxe_lookup_mcg(rxe, mgid);
 	if (mcg)
-		return mcg;
+		goto out;	/* nothing to do */
 
-	/* check to see if we have reached limit */
 	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
 		err = -ENOMEM;
 		goto err_dec;
 	}
 
-	/* speculative alloc of new mcg */
 	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
 	if (!mcg) {
 		err = -ENOMEM;
 		goto err_dec;
 	}
 
-	spin_lock_bh(&rxe->mcg_lock);
-	/* re-check to see if someone else just added it */
-	tmp = rxe_lookup_mcg(rxe, mgid);
-	if (tmp) {
-		spin_unlock_bh(&rxe->mcg_lock);
-		atomic_dec(&rxe->mcg_num);
-		kfree(mcg);
-		return tmp;
-	}
-
-	__rxe_init_mcg(rxe, mgid, mcg);
-	spin_unlock_bh(&rxe->mcg_lock);
+	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
+	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
+	mcg->rxe = rxe;
+	kref_init(&mcg->ref_cnt);
+	INIT_LIST_HEAD(&mcg->qp_list);
+	spin_lock_init(&mcg->lock);
+	kref_get(&mcg->ref_cnt);
+	__rxe_insert_mcg(mcg);
 
-	/* add mcast address outside of lock */
 	err = rxe_mcast_add(mcg);
-	if (!err)
-		return mcg;
+	if (err)
+		goto err_free;
+
+out:
+	mutex_unlock(&rxe->mcg_mutex);
+	return mcg;
 
+err_free:
+	__rxe_remove_mcg(mcg);
 	kfree(mcg);
 err_dec:
 	atomic_dec(&rxe->mcg_num);
+	mutex_unlock(&rxe->mcg_mutex);
 	return ERR_PTR(err);
 }
 
@@ -305,10 +274,10 @@ void rxe_cleanup_mcg(struct kref *kref)
 }
 
 /**
- * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
+ * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_mutex
  * @mcg: the mcg object
  *
- * Context: caller is holding rxe->mcg_lock
+ * Context: caller is holding rxe->mcg_mutex
  * no qp's are attached to mcg
  */
 static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
@@ -333,151 +302,123 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 	/* delete mcast address outside of lock */
 	rxe_mcast_del(mcg);
 
-	spin_lock_bh(&mcg->rxe->mcg_lock);
+	mutex_lock(&mcg->rxe->mcg_mutex);
 	__rxe_destroy_mcg(mcg);
-	spin_unlock_bh(&mcg->rxe->mcg_lock);
+	mutex_unlock(&mcg->rxe->mcg_mutex);
 }
 
 /**
- * __rxe_init_mca - initialize a new mca holding lock
+ * rxe_attach_mcg - attach qp to mcg if not already attached
  * @qp: qp object
  * @mcg: mcg object
- * @mca: empty space for new mca
- *
- * Context: caller must hold references on qp and mcg, rxe->mcg_lock
- * and pass memory for new mca
  *
  * Returns: 0 on success else an error
  */
-static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
-			  struct rxe_mca *mca)
+static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	int n;
+	struct rxe_dev *rxe = mcg->rxe;
+	struct rxe_mca *mca;
+	unsigned long flags;
+	int err;
 
-	n = atomic_inc_return(&rxe->mcg_attach);
-	if (n > rxe->attr.max_total_mcast_qp_attach) {
-		atomic_dec(&rxe->mcg_attach);
-		return -ENOMEM;
+	mutex_lock(&rxe->mcg_mutex);
+	spin_lock_irqsave(&mcg->lock, flags);
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+		if (mca->qp == qp) {
+			spin_unlock_irqrestore(&mcg->lock, flags);
+			goto out;	/* nothing to do */
+		}
 	}
+	spin_unlock_irqrestore(&mcg->lock, flags);
 
-	n = atomic_inc_return(&mcg->qp_num);
-	if (n > rxe->attr.max_mcast_qp_attach) {
-		atomic_dec(&mcg->qp_num);
-		atomic_dec(&rxe->mcg_attach);
-		return -ENOMEM;
+	if (atomic_inc_return(&rxe->mcg_attach) >
+	    rxe->attr.max_total_mcast_qp_attach) {
+		err = -EINVAL;
+		goto err_dec_attach;
 	}
 
-	atomic_inc(&qp->mcg_num);
+	if (atomic_inc_return(&mcg->qp_num) >
+	    rxe->attr.max_mcast_qp_attach) {
+		err = -EINVAL;
+		goto err_dec_qp_num;
+	}
+
+	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
+	if (!mca) {
+		err = -ENOMEM;
+		goto err_dec_qp_num;
+	}
 
+	atomic_inc(&qp->mcg_num);
 	rxe_get(qp);
 	mca->qp = qp;
 
+	spin_lock_irqsave(&mcg->lock, flags);
 	list_add_tail(&mca->qp_list, &mcg->qp_list);
-
+	spin_unlock_irqrestore(&mcg->lock, flags);
+out:
+	mutex_unlock(&rxe->mcg_mutex);
 	return 0;
+
+err_dec_qp_num:
+	atomic_dec(&mcg->qp_num);
+err_dec_attach:
+	atomic_dec(&rxe->mcg_attach);
+	mutex_unlock(&rxe->mcg_mutex);
+	return err;
 }
 
 /**
- * rxe_attach_mcg - attach qp to mcg if not already attached
- * @qp: qp object
+ * rxe_detach_mcg - detach qp from mcg
  * @mcg: mcg object
+ * @qp: qp object
  *
- * Context: caller must hold reference on qp and mcg.
- * Returns: 0 on success else an error
+ * Returns: 0 on success else an error if qp is not attached.
  */
-static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
+static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
-	struct rxe_mca *mca, *tmp;
-	int err;
+	struct rxe_mca *mca;
+	unsigned long flags;
+	int err = 0;
 
-	/* check to see if the qp is already a member of the group */
-	spin_lock_bh(&rxe->mcg_lock);
+	mutex_lock(&rxe->mcg_mutex);
+	spin_lock_irqsave(&mcg->lock, flags);
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_bh(&rxe->mcg_lock);
-			return 0;
+			spin_unlock_irqrestore(&mcg->lock, flags);
+			goto found;
 		}
 	}
-	spin_unlock_bh(&rxe->mcg_lock);
+	spin_unlock_irqrestore(&mcg->lock, flags);
 
-	/* speculative alloc new mca without using GFP_ATOMIC */
-	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
-	if (!mca)
-		return -ENOMEM;
-
-	spin_lock_bh(&rxe->mcg_lock);
-	/* re-check to see if someone else just attached qp */
-	list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
-		if (tmp->qp == qp) {
-			kfree(mca);
-			err = 0;
-			goto out;
-		}
-	}
-
-	err = __rxe_init_mca(qp, mcg, mca);
-	if (err)
-		kfree(mca);
-out:
-	spin_unlock_bh(&rxe->mcg_lock);
-	return err;
-}
+	/* we didn't find the qp on the list */
+	err = -EINVAL;
+	goto err_out;
 
-/**
- * __rxe_cleanup_mca - cleanup mca object holding lock
- * @mca: mca object
- * @mcg: mcg object
- *
- * Context: caller must hold a reference to mcg and rxe->mcg_lock
- */
-static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
-{
+found:
+	spin_lock_irqsave(&mcg->lock, flags);
 	list_del(&mca->qp_list);
+	spin_unlock_irqrestore(&mcg->lock, flags);
 
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
 	atomic_dec(&mca->qp->mcg_num);
 	rxe_put(mca->qp);
-
 	kfree(mca);
-}
-
-/**
- * rxe_detach_mcg - detach qp from mcg
- * @mcg: mcg object
- * @qp: qp object
- *
- * Returns: 0 on success else an error if qp is not attached.
- */
-static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
-{
-	struct rxe_dev *rxe = mcg->rxe;
-	struct rxe_mca *mca, *tmp;
 
-	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
-		if (mca->qp == qp) {
-			__rxe_cleanup_mca(mca, mcg);
-
-			/* if the number of qp's attached to the
-			 * mcast group falls to zero go ahead and
-			 * tear it down. This will not free the
-			 * object since we are still holding a ref
-			 * from the caller
-			 */
-			if (atomic_read(&mcg->qp_num) <= 0)
-				__rxe_destroy_mcg(mcg);
-
-			spin_unlock_bh(&rxe->mcg_lock);
-			return 0;
-		}
-	}
+	/* if the number of qp's attached to the
+	 * mcast group falls to zero go ahead and
+	 * tear it down. This will not free the
+	 * object since we are still holding a ref
+	 * from the caller
+	 */
+	if (atomic_read(&mcg->qp_num) <= 0)
+		__rxe_destroy_mcg(mcg);
 
-	/* we didn't find the qp on the list */
-	spin_unlock_bh(&rxe->mcg_lock);
-	return -EINVAL;
+err_out:
+	mutex_unlock(&rxe->mcg_mutex);
+	return err;
 }
 
 /**
@@ -495,6 +436,9 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *mcg;
 
+	if (rxe->attr.max_mcast_grp == 0)
+		return -EINVAL;
+
 	/* takes a ref on mcg if successful */
 	mcg = rxe_get_mcg(rxe, mgid);
 	if (IS_ERR(mcg))
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 7153de0799fc..6cf0da958864 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -194,6 +194,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	struct rxe_mca *mca;
 	struct rxe_qp *qp;
 	union ib_gid dgid;
+	unsigned long flags;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -207,7 +208,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
-	spin_lock_bh(&rxe->mcg_lock);
+	spin_lock_irqsave(&mcg->lock, flags);
 
 	/* this is unreliable datagram service so we let
 	 * failures to deliver a multicast packet to a
@@ -259,7 +260,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		}
 	}
 
-	spin_unlock_bh(&rxe->mcg_lock);
+	spin_unlock_irqrestore(&mcg->lock, flags);
 
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 8058e5039322..f21963dcb2c8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -351,6 +351,7 @@ struct rxe_mcg {
 	struct list_head	qp_list;
 	union ib_gid		mgid;
 	atomic_t		qp_num;
+	spinlock_t		lock;	/* protect qp_list */
 	u32			qkey;
 	u16			pkey;
 	bool			is_ipv6;
@@ -390,7 +391,7 @@ struct rxe_dev {
 	struct rxe_pool		mw_pool;
 
 	/* multicast support */
-	spinlock_t		mcg_lock;
+	struct mutex		mcg_mutex;
 	struct rb_root		mcg_tree;
 	atomic_t		mcg_num;
 	atomic_t		mcg_attach;
-- 
2.40.1


