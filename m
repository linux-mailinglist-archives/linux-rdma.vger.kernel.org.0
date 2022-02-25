Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C5E4C4B89
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 17:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiBYQ55 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 11:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbiBYQ55 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 11:57:57 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0A1FCEA
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 08:57:23 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x6-20020a4a4106000000b003193022319cso7013772ooa.4
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 08:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KWe4opd/i3dYi0sDDyQ0PazKYHTlqtJBjl9I++fimrU=;
        b=Ry7g716N2wQItjBYVOd1CTJSjMD818qRW/bNwiqvAWXDsA3DhvsbHGA0+zMFz18iOJ
         Vgu5SyAySo1kNKe017E2PdsO9Kil2xFn7yAnE5MXbJPp9FLChaabtNHHUVZTgI/CjL+U
         JTs0ZJix2h8KdD2ZNZNNoXqK4YA9cWRhRF5uUwWAlknYry4G67KgLug61cJ32L7TKjc8
         VvvjS94woNDr0AJpbHvo6R3BvsPIRukL6a8tnjBP6IbzEIir4FNBkA3tmrn2NIicuBoA
         37Kc7XqueVliu7cEkD5NSp8m7EUckg2DrlFYjXswkjHDnF6jz5rKYGh9b91FpI60TJ+a
         AaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KWe4opd/i3dYi0sDDyQ0PazKYHTlqtJBjl9I++fimrU=;
        b=GN+hS0gNchxzi8fWR+uOlxhl4Q7bUNK8uOjZkvU1wgOYh1LZQaO3idiixEbSvzr9ed
         fB5oD1oiMv94Ti4DRZKl+KWhz+D2qkllnVq+wI8MFk2Sr6sYKLq3pslQX8YhORrUur9k
         qpDXvxncmFOiucRhLZ2todtpt6XSUJwQdMf+u3Pn8hnmaQbsbEP7kySJzBQ4AaCq2YWk
         9wa1OOoC1KlxJXra39KHL+vAUuddXcg2+rETvL7y2PJXoGc+VH4ttlNn+XkJ6+3Uf97c
         VVqzyHm/pyOJynS+xjCQw99vvlUsUqKd1xvGyCLeRoeMMh62prrVTnFOfSh1Z/DVTjrd
         Bf4A==
X-Gm-Message-State: AOAM531BfbeSgQmbtpXrYr41+wnAAEM2LT70Xb3NX9X83uAAGzwvTsCn
        aBKw3cPiMi8dSPCeQ+YWpeWRSthw2jk=
X-Google-Smtp-Source: ABdhPJw+jAXHvWTDNDLISIQ7kPoEe36q+zWL8l8drxqEhTlLT+yga7Ue5xOoT942/j6KHCg1wD1tKA==
X-Received: by 2002:a05:6870:2b09:b0:d6:d8f5:4ccc with SMTP id ld9-20020a0568702b0900b000d6d8f54cccmr1627254oab.99.1645808242583;
        Fri, 25 Feb 2022 08:57:22 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2ada-5333-cba3-b5d2.res6.spectrum.com. [2603:8081:140c:1a00:2ada:5333:cba3:b5d2])
        by smtp.googlemail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm1356582ott.2.2022.02.25.08.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:57:22 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14] RDMA/rxe: Convert mca read locking to RCU
Date:   Fri, 25 Feb 2022 10:57:11 -0600
Message-Id: <20220225165711.15062-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Replace spinlock with rcu read locks for read side operations
on mca in rxe_recv.c and rxe_mcast.c. Minor fixups and name changes
for clarity.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v14:
  This is the last patch left in the series to move multicast out
  of rxe_pools. I finally found the cause of the failure in v12
  and fixed it. I also make some cleanups to names and order of
  the subroutines to help readability. Also the rxe_destroy_mca
  subroutine which is called from call_rcu() doesn't have the spinlock
  set which required a small change.

 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 144 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   8 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
 4 files changed, 84 insertions(+), 72 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 2ffbe3390668..c7ba112d5c67 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -41,9 +41,9 @@ void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid);
+void rxe_free_mcg(struct kref *kref);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
-void rxe_cleanup_mcg(struct kref *kref);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index c399a29b648b..b854a82ae12b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -17,6 +17,12 @@
  * mca is created. It holds a pointer to the qp and is added to a list
  * of qp's that are attached to the mcg. The qp_list is used to replicate
  * mcast packets in the rxe receive path.
+ *
+ * The highest performance operations are mca list traversal when
+ * processing incoming multicast packets which need to be fanned out
+ * to the attached qp's. This list is protected by RCU locking for read
+ * operations and a spinlock in the rxe_dev struct for write operations.
+ * The red-black tree is protected by the same spinlock.
  */
 
 #include "rxe.h"
@@ -243,10 +249,10 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /**
- * rxe_cleanup_mcg - cleanup mcg for kref_put
+ * rxe_free_mcg - free mcg for kref_put
  * @kref: struct kref embnedded in mcg
  */
-void rxe_cleanup_mcg(struct kref *kref)
+void rxe_free_mcg(struct kref *kref)
 {
 	struct rxe_mcg *mcg = container_of(kref, typeof(*mcg), ref_cnt);
 
@@ -254,36 +260,21 @@ void rxe_cleanup_mcg(struct kref *kref)
 }
 
 /**
- * __rxe_destroy_mcg - destroy mcg object holding rxe->mcg_lock
+ * rxe_cleanup_mcg - cleanup mcg object
  * @mcg: the mcg object
  *
- * Context: caller is holding rxe->mcg_lock
- * no qp's are attached to mcg
+ * Context: no qp's are attached to mcg
  */
-static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
+static void rxe_cleanup_mcg(struct rxe_mcg *mcg)
 {
 	struct rxe_dev *rxe = mcg->rxe;
+	unsigned long flags;
 
-	/* remove mcg from red-black tree then drop ref */
+	spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
 	__rxe_remove_mcg(mcg);
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-
+	kref_put(&mcg->ref_cnt, rxe_free_mcg);
 	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
 	atomic_dec(&rxe->mcg_num);
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
-	unsigned long flags;
-
-	spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
-	__rxe_destroy_mcg(mcg);
 	spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
 }
 
@@ -322,11 +313,60 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 	rxe_add_ref(qp);
 	mca->qp = qp;
 
-	list_add_tail(&mca->qp_list, &mcg->qp_list);
+	kref_get(&mcg->ref_cnt);
+	mca->mcg = mcg;
+
+	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);
 
 	return 0;
 }
 
+/**
+ * rxe_destroy_mca - free mca resources
+ * @head: rcu_head embedded in mca
+ *
+ * Context: caller must hold a reference to mcg
+ *          all rcu read operations should be compelete
+ */
+static void rxe_destroy_mca(struct rcu_head *head)
+{
+	struct rxe_mca *mca = container_of(head, typeof(*mca), rcu);
+	struct rxe_mcg *mcg = mca->mcg;
+
+	/* let destroy_qp finish if this is the last ref */
+	rxe_drop_ref(mca->qp);
+
+	atomic_dec(&mcg->qp_num);
+	atomic_dec(&mcg->rxe->mcg_attach);
+
+	/* if the number of qp's attached to the
+	 * mcast group falls to zero go ahead and
+	 * tear it down. This will not free the
+	 * object since we are still holding a ref
+	 * from the caller
+	 */
+	if (atomic_read(&mcg->qp_num) <= 0)
+		rxe_cleanup_mcg(mcg);
+
+	kfree(mca);
+}
+
+/**
+ * __rxe_cleanup_mca - cleanup mca object holding lock
+ * @mca: mca object
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ */
+static void __rxe_cleanup_mca(struct rxe_mca *mca)
+{
+	list_del_rcu(&mca->qp_list);
+
+	/* let destroy_qp start if this is the last mc attach */
+	atomic_dec(&mca->qp->mcg_num);
+
+	call_rcu(&mca->rcu, rxe_destroy_mca);
+}
+
 /**
  * rxe_attach_mcg - attach qp to mcg if not already attached
  * @qp: qp object
@@ -343,14 +383,14 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	int err;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			rcu_read_unlock();
 			return 0;
 		}
 	}
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	rcu_read_unlock();
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
@@ -375,25 +415,6 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	return err;
 }
 
-/**
- * __rxe_cleanup_mca - cleanup mca object holding lock
- * @mca: mca object
- * @mcg: mcg object
- *
- * Context: caller must hold a reference to mcg and rxe->mcg_lock
- */
-static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
-{
-	list_del(&mca->qp_list);
-
-	atomic_dec(&mcg->qp_num);
-	atomic_dec(&mcg->rxe->mcg_attach);
-	atomic_dec(&mca->qp->mcg_num);
-	rxe_drop_ref(mca->qp);
-
-	kfree(mca);
-}
-
 /**
  * rxe_detach_mcg - detach qp from mcg
  * @mcg: mcg object
@@ -404,30 +425,19 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
-	struct rxe_mca *mca, *tmp;
-	unsigned long flags;
+	struct rxe_mca *mca;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
-	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
+	spin_lock_bh(&rxe->mcg_lock);
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
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
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			__rxe_cleanup_mca(mca);
+			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
 		}
 	}
 
 	/* we didn't find the qp on the list */
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return -EINVAL;
 }
 
@@ -455,9 +465,9 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	/* if we failed to attach the first qp to mcg tear it down */
 	if (atomic_read(&mcg->qp_num) == 0)
-		rxe_destroy_mcg(mcg);
+		rxe_cleanup_mcg(mcg);
 
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+	kref_put(&mcg->ref_cnt, rxe_free_mcg);
 
 	return err;
 }
@@ -482,7 +492,7 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 		return -EINVAL;
 
 	err = rxe_detach_mcg(mcg, qp);
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+	kref_put(&mcg->ref_cnt, rxe_free_mcg);
 
 	return err;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 9b21cbb22602..eda9e27e40c0 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -265,17 +265,17 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
 	n = 0;
 
-	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		/* protect the qp pointers in the list */
 		rxe_add_ref(mca->qp);
 		qp_array[n++] = mca->qp;
 		if (n == nmax)
 			break;
 	}
-	spin_unlock_bh(&rxe->mcg_lock);
+	rcu_read_unlock();
 	nmax = n;
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+	kref_put(&mcg->ref_cnt, rxe_free_mcg);
 
 	for (n = 0; n < nmax; n++) {
 		qp = qp_array[n];
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e7eff1ca75e9..897f77ff604c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -363,7 +363,9 @@ struct rxe_mcg {
 
 struct rxe_mca {
 	struct list_head	qp_list;
+	struct rcu_head		rcu;
 	struct rxe_qp		*qp;
+	struct rxe_mcg		*mcg;
 };
 
 struct rxe_port {
-- 
2.32.0

