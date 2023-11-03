Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC67E0A78
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 21:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjKCUoK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 16:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjKCUoJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 16:44:09 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DBD53
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 13:44:05 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5842a7fdc61so1217031eaf.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Nov 2023 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044245; x=1699649045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ncx53wZtdrJtktFdOWOr6gN3I6qmi3w2Yix/6ZjcL+U=;
        b=CXaQNogxkR82G9v3qEYm1GToPKEF7bKUIMXNgFLH1GU+ai0Tl+Gr/pzBd5APzMHuKu
         Jc2JhM4LbyrNiCbJz3JLqACmkQBBihOzL7vEv2PGV5JNvD1kQvSabVmecgpSYoonvYMb
         Os2eb1ImLcUlZkRVhbdg0fWqbl3+2wMYmGYULFgsf+LG6k5dle+y4fqZC6S4+5HU66i1
         EbnEIIuHgq2pSlmF12WkFHTMOs6NFQOMX75npzDfOyoNDxwmm8Fgeeu6MGQ4jb2jR223
         60BtdGEuHKhpMdOJlUo/r1js/ABVa47x05b9cZhtE8oAbWYAciNJlL+5jtaEzOIm9ReP
         LDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044245; x=1699649045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ncx53wZtdrJtktFdOWOr6gN3I6qmi3w2Yix/6ZjcL+U=;
        b=nhbwmijlzl9Jj2houmPcz+q96qJTYzCelWWlW7lC9QySPGxg78buwnoRjnN6WAA2KJ
         xpTWx5kxBDJa2f28sNQxR+VqF6WWQDPZfK8B/i4LynwhvRKfkX/2FwlOVV0GLZEe4Bz+
         g8/1BKQrtyVJnRVK7zONoerwn867wH0S4NEYl2PXwYzwuXmOpZOm9JYG68SteJVedYuh
         P2wcuwBxLbE/y+48dOvXupFTx+1zLeM6KLI50BI7OJNmnNb+K75fLzYQg8FxTmSBwJr7
         iHzTWIsxNzXQKRAL9tjhebPptbT9x6Psm54Ts5lmSzQGEFbqiXuaB0kC+AgWSeEULmoy
         R6gA==
X-Gm-Message-State: AOJu0YyEe5YNLEovK5BsKCH/GKsWeCcCQzGfKtUO/KIPTmGU8E9peaWm
        5XCH1rAz4BQLflMT+/BiA1A=
X-Google-Smtp-Source: AGHT+IE2W7/y5mXVnzKAWWl8CJ7109xJUHDayVacqis8jO7+d5cG99AcEsxFg4NJA4kCz0Eh/7ML5w==
X-Received: by 2002:a4a:a649:0:b0:582:c8b4:d9df with SMTP id j9-20020a4aa649000000b00582c8b4d9dfmr22355882oom.1.1699044245050;
        Fri, 03 Nov 2023 13:44:05 -0700 (PDT)
Received: from bob-3900x.lan (2603-8081-1405-679b-6bc0-11b9-c519-2c18.res6.spectrum.com. [2603:8081:1405:679b:6bc0:11b9:c519:2c18])
        by smtp.gmail.com with ESMTPSA id v9-20020a4ae049000000b00581e5b78ce5sm447766oos.38.2023.11.03.13.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:44:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/6] RDMA/rxe: Cleanup mcg lifetime
Date:   Fri,  3 Nov 2023 15:43:25 -0500
Message-Id: <20231103204324.9606-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231103204324.9606-1-rpearsonhpe@gmail.com>
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
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

Fix up mcg reference counting so the ref count will drop
to zero correctly and move code from rxe_destroy_mcg to
rxe_cleanup_mcg since rxe_destroy is no longer needed.

Also general code cleanup. Drop comments on statics, etc.

Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 190 ++++++++------------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   2 +-
 3 files changed, 58 insertions(+), 136 deletions(-)

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
index bca5b022b797..65a420a540cd 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -23,7 +23,6 @@
 
 #include "rxe.h"
 
-/* register mcast IP and MAC addresses with net stack */
 static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -82,7 +81,6 @@ static int rxe_mcast_add(struct rxe_mcg *mcg)
 	return err;
 }
 
-/* deregister mcast IP and MAC addresses with net stack */
 static int rxe_mcast_del6(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -122,13 +120,31 @@ static int rxe_mcast_del(struct rxe_mcg *mcg)
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
@@ -144,34 +160,17 @@ static void __rxe_insert_mcg(struct rxe_mcg *mcg)
 		cmp = memcmp(&tmp->mgid, &mcg->mgid, sizeof(mcg->mgid));
 		if (cmp > 0)
 			link = &(*link)->rb_left;
-		else
+		else if (cmp < 0)
 			link = &(*link)->rb_right;
+		else
+			WARN_ON_ONCE(1);
 	}
 
 	rb_link_node_rcu(&mcg->node, node, link);
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
-/**
- * rxe_lookup_mcg - lookup mcg in rxe->mcg_tree while holding lock
- * @rxe: rxe device object
- * @mgid: multicast IP address
- *
- * Returns: mcg on success and takes a ref to mcg else NULL
- */
-struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
-					union ib_gid *mgid)
+struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rb_root *tree = &rxe->mcg_tree;
 	struct rxe_mcg *mcg;
@@ -196,21 +195,16 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe,
 	rcu_read_unlock();
 
 	if (node) {
-		kref_get(&mcg->ref_cnt);
+		/* take a ref on mcg for each lookup */
+		rxe_get_mcg(mcg);
 		return mcg;
 	}
 
 	return NULL;
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
@@ -234,22 +228,22 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
 	mcg->rxe = rxe;
+	/* take ref on mcg when created */
 	kref_init(&mcg->ref_cnt);
 	INIT_LIST_HEAD(&mcg->qp_list);
 	spin_lock_init(&mcg->lock);
-	kref_get(&mcg->ref_cnt);
-	__rxe_insert_mcg(mcg);
 
 	err = rxe_mcast_add(mcg);
 	if (err)
 		goto err_free;
 
+	/* can insert into tree now that mcg is finished */
+	__rxe_insert_mcg(mcg);
 out:
 	mutex_unlock(&rxe->mcg_mutex);
 	return mcg;
 
 err_free:
-	__rxe_remove_mcg(mcg);
 	kfree(mcg);
 err_dec:
 	atomic_dec(&rxe->mcg_num);
@@ -257,64 +251,12 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
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
@@ -348,29 +290,28 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	rxe_get(qp);
 	mca->qp = qp;
 
+	/* hold a ref on mcg for each attached qp
+	 * protects the pointers in mca->qp_list
+	 */
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
+	/* drop the ref on mcg from rxe_alloc_mcg */
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
 
@@ -395,23 +335,18 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	spin_lock_irqsave(&mcg->lock, flags);
 	list_del(&mca->qp_list);
 	spin_unlock_irqrestore(&mcg->lock, flags);
+	/* drop the ref on mcg from rxe_attach_mcg */
+	rxe_put_mcg(mcg);
 
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
 	atomic_dec(&mca->qp->mcg_num);
+	/* drop the ref on qp that was protecting mca->qp */
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
+	/* drop the ref on mcg from rxe_lookup_mcg */
+	rxe_put_mcg(mcg);
 	mutex_unlock(&rxe->mcg_mutex);
 	return err;
 }
@@ -426,7 +361,6 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
  */
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
-	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_mcg *mcg;
@@ -435,19 +369,11 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 		return -EINVAL;
 
 	/* takes a ref on mcg if successful */
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
@@ -463,14 +389,10 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
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

