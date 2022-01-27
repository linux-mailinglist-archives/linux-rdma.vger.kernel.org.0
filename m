Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC449ED95
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbiA0ViV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbiA0ViT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:19 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E41C06174E
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u129so8536772oib.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Qk2vgeclDXUdo7237r2VFHmcnL2+s+zUxnDBrX0loQ=;
        b=dQfXCJxdNahfnh9Eqp+/o9zN2ufR/jsw3tZs9MfWhev2ZQQk7hGCRpHyHytFyyWqel
         7HMYFLyfzIThEGd6XyXN651hdl6OwiaiLP4XxNO04WDo+L/MEcqKLJ/uEKz6rkSGv4XE
         strjb7WxHY4l37IvjV38OMMawiBD+ykuTSoB56ySmWmE+2GqZl0L0azkGKikVBLci2RW
         eZ1guBU9RIhFi5bWFiAZuj3YwRsz+x5KFhB1k7g53dqmaZu9tU5o+FyDIdd4G9kgDLH8
         V47Xktqf0ZXe/L6Xgy1ABm6DsIbgMbRsRcAPPyKT8WtMAzbSY7gW7XQWI6KDdvnXBXv1
         wsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Qk2vgeclDXUdo7237r2VFHmcnL2+s+zUxnDBrX0loQ=;
        b=d9Iu9TQzNlJJIfB71eDvqy/wY7UNHzxsOM8AqEp5zKF80jgoKfuEByl8u6TP2UOPn2
         WuA5gYxwD9xhV2VcWXpl/50dFoQTUx72NAvwuF5fJjwRFVSuP+Oji5w82KbuPOnDhKMk
         BfJtPqwm70DfmBNnNO6lQVJUvSy1HxJMkVOu6W59j/m0LVUCY92E4B1verx7aL9SuCQF
         gjsbUGly02YCHAZJJtZIECBvP6OxAwMDIV7z7YuikjTbSkJ+BiviN6/KqTC2f2HdaUEd
         BEXOMPow/ptBASoP+OXsE6foVNMpPufsGeYvcD2ypU3D5HIUWWtRmUYv+KINA1KOVqN+
         Y+TA==
X-Gm-Message-State: AOAM532dPfG4jiTKJlL4+6pLI2s84tHB5fjBCBx6XKqo+hQrgVm9DiYK
        ou7rzd+zuG9pK8mCZbiXIw4=
X-Google-Smtp-Source: ABdhPJykZk1CatuWq4HlHJSshOdys5l2JBiVroJdcFCO4Is9xR1+Kcx2bRHDW4tdRFGfD44jtAiemw==
X-Received: by 2002:a05:6808:10c7:: with SMTP id s7mr3360073ois.332.1643319493363;
        Thu, 27 Jan 2022 13:38:13 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:12 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 11/26] RDMA/rxe: Replace locks by rxe->mcg_lock
Date:   Thu, 27 Jan 2022 15:37:40 -0600
Message-Id: <20220127213755.31697-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Starting to decouple mcg from rxe pools, replace the spin lock
mcg->mcg_lock and the write lock pool->pool_lock by rxe->mcg_lock.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe_mcast.c | 25 ++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ++-
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index c55736e441e7..46a07e2d9dcf 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -198,6 +198,8 @@ static int rxe_init(struct rxe_dev *rxe)
 	if (err)
 		return err;
 
+	spin_lock_init(&rxe->mcg_lock);
+
 	/* init pending mmap list */
 	spin_lock_init(&rxe->mmap_offset_lock);
 	spin_lock_init(&rxe->pending_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 3b66019fc26d..62ace10206b0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -25,7 +25,7 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
-/* caller should hold mc_grp_pool->pool_lock */
+/* caller should hold mc_grp_rxe->mcg_lock */
 static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 				     struct rxe_pool *pool,
 				     union ib_gid *mgid)
@@ -39,7 +39,6 @@ static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 	rxe_add_ref(mcg);
 
 	INIT_LIST_HEAD(&mcg->qp_list);
-	spin_lock_init(&mcg->mcg_lock);
 	mcg->rxe = rxe;
 	rxe_add_key_locked(mcg, mgid);
 
@@ -63,7 +62,7 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return -EINVAL;
 
-	write_lock_bh(&pool->pool_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	mcg = rxe_pool_get_key_locked(pool, mgid);
 	if (mcg)
@@ -71,13 +70,13 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	mcg = create_grp(rxe, pool, mgid);
 	if (IS_ERR(mcg)) {
-		write_unlock_bh(&pool->pool_lock);
+		spin_unlock_bh(&rxe->mcg_lock);
 		err = PTR_ERR(mcg);
 		return err;
 	}
 
 done:
-	write_unlock_bh(&pool->pool_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	*mcgp = mcg;
 	return 0;
 }
@@ -89,21 +88,21 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mca *mca, *new_mca;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_bh(&mcg->mcg_lock);
+			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
 		}
 	}
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	new_mca = kzalloc(sizeof(*mca), GFP_KERNEL);
 	if (!new_mca)
 		return -ENOMEM;
 
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just attached qp */
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
@@ -126,7 +125,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	err = 0;
 out:
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
@@ -141,7 +140,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	if (!mcg)
 		goto err1;
 
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
@@ -151,14 +150,14 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				rxe_drop_ref(mcg);
 			atomic_dec(&qp->mcg_num);
 
-			spin_unlock_bh(&mcg->mcg_lock);
+			spin_unlock_bh(&rxe->mcg_lock);
 			rxe_drop_ref(mcg);	/* ref from get_key */
 			kfree(mca);
 			return 0;
 		}
 	}
 
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	rxe_drop_ref(mcg);			/* ref from get_key */
 err1:
 	return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 41571c6b7d98..11246589fda7 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -267,13 +267,13 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
 
 	n = 0;
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		qp_array[n++] = mca->qp;
 		if (n == nmax)
 			break;
 	}
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	nmax = n;
 
 	/* this is unreliable datagram service so we let
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index d65c358798c6..b72f8f09d984 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -353,7 +353,6 @@ struct rxe_mw {
 
 struct rxe_mcg {
 	struct rxe_pool_elem	elem;
-	spinlock_t		mcg_lock; /* guard group */
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
 	atomic_t		qp_num;
@@ -397,6 +396,8 @@ struct rxe_dev {
 	struct rxe_pool		mw_pool;
 	struct rxe_pool		mc_grp_pool;
 
+	spinlock_t		mcg_lock; /* guard multicast groups */
+
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
 
-- 
2.32.0

