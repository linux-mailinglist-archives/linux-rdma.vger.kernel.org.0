Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A14A521A
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiAaWKO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiAaWKN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F0C06173D
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:13 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v67so29534185oie.9
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyhU+SAzlULycIcyLyDOAHPl5t3FH7EOR8gipo1aZZQ=;
        b=ncTLCO+May2EkmrxW6WtEfI2yP8a05YnuM5yyZ4Ewc5uxuKHLEnLqLMQk7BXKRedld
         lhqGvanKtsXAKMKLhgUwkzYhk/AUcFSerscE459b9hrJ48XdTpoLhyJkIPsS+dG7nVo4
         VXGQbbFef+FeQVvoDbKL6GgJQGNlhSBabOR2QKJGhNd+lR86307aXJ8paFY2rWRs/L76
         orXsv6eNZLOT1jUHDC/5OgV/qO9J0jCh3X9UmIbtR7BdpTK1jYeA4DqU3so259PdsvrX
         SqHE/z9IAc10nqEXyuBve8sfRc3Bi71ThFQFnsghPQ6/jtgJhkCLCRMraj6abOZ6itdV
         Zb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyhU+SAzlULycIcyLyDOAHPl5t3FH7EOR8gipo1aZZQ=;
        b=wfRkpfPvDqVsSCh4IMEWPJ8+z1pLATPCSFlXHvIswe/e9OL8Ku3SGoKvDJOus0/9vs
         cGEzV8G1nFhxPjK9MeN8Y/a6ytPJ8bfGgRoAKaM5nL8oSEn33xQviihnNtP+0spF8QZX
         75IHnxqAC635MATssO7CVoZNjQ1tgDmkoPHB2Z9UgrAd5t+dSgPSs7qQ7rjwD5BMIV+6
         URfyi5SzWC82vKPWUMIgwfSal677X2EWaBAagxmXGJf/ECk4JAUNx+JWQ8drmZH22egm
         /slo5euIQHM6SNVY7zmwzi3NN9dKNGm5yJS2fB6q3SLxKdz28YRv3KZdLsP+EVe0EIrD
         NOeA==
X-Gm-Message-State: AOAM530qYh6Lj3ax8B7gP7cZBBpIavCJOncpuzkG2zqucYmRHY36zLXA
        aC1u9usMyrKDMcNNr2AQess9v6/A9Vk=
X-Google-Smtp-Source: ABdhPJw/BCmJkZ4CcaTR3Bn+ku9DrpIAPWfLq+VKaT9bfKCkhh4DEIHlx2XOrDW3FIsKpF5e15FspA==
X-Received: by 2002:a05:6808:1250:: with SMTP id o16mr14512371oiv.95.1643667012873;
        Mon, 31 Jan 2022 14:10:12 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:12 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 11/17] RDMA/rxe: Replace mcg locks by rxe->mcg_lock
Date:   Mon, 31 Jan 2022 16:08:44 -0600
Message-Id: <20220131220849.10170-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Starting to decouple mcg from rxe pools, replace the spin lock
mcg->mcg_lock and the read/write lock pool->pool_lock by rxe->mcg_lock.

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
index 52bd46ca22c9..d35070777214 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -25,7 +25,7 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
-/* caller should hold mc_grp_pool->pool_lock */
+/* caller should hold rxe->mcg_lock */
 static int __rxe_create_mcg(struct rxe_dev *rxe, struct rxe_pool *pool,
 			    union ib_gid *mgid, struct rxe_mcg **mcg_p)
 {
@@ -43,7 +43,6 @@ static int __rxe_create_mcg(struct rxe_dev *rxe, struct rxe_pool *pool,
 	}
 
 	INIT_LIST_HEAD(&mcg->qp_list);
-	spin_lock_init(&mcg->mcg_lock);
 	mcg->rxe = rxe;
 
 	rxe_add_ref(mcg);
@@ -72,7 +71,7 @@ static int rxe_mcast_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return -EINVAL;
 
-	write_lock_bh(&pool->pool_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	mcg = rxe_pool_get_key_locked(pool, mgid);
 	if (mcg)
@@ -80,12 +79,12 @@ static int rxe_mcast_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	err = __rxe_create_mcg(rxe, pool, mgid, &mcg);
 	if (err) {
-		write_unlock_bh(&pool->pool_lock);
+		spin_unlock_bh(&rxe->mcg_lock);
 		return err;
 	}
 
 done:
-	write_unlock_bh(&pool->pool_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	*mcg_p = mcg;
 	return 0;
 }
@@ -97,21 +96,21 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
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
@@ -135,7 +134,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	err = 0;
 out:
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
@@ -149,7 +148,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	if (!mcg)
 		goto err1;
 
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
@@ -158,14 +157,14 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				__rxe_destroy_mcg(mcg);
 			atomic_dec(&qp->mcg_num);
 
-			spin_unlock_bh(&mcg->mcg_lock);
+			spin_unlock_bh(&rxe->mcg_lock);
 			rxe_drop_ref(mcg);
 			kfree(mca);
 			return 0;
 		}
 	}
 
-	spin_unlock_bh(&mcg->mcg_lock);
+	spin_unlock_bh(&rxe->mcg_lock);
 	rxe_drop_ref(mcg);
 err1:
 	return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index ed80125f1dc5..9a45743c8eaa 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -267,14 +267,14 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
 
 	n = 0;
-	spin_lock_bh(&mcg->mcg_lock);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		rxe_add_ref(mca->qp);
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

