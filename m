Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F064AE3DA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386620AbiBHWYa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386866AbiBHVRT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:19 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B812CC0612B8
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:17 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so113180ooo.13
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUNciH/hkWjnuuT5P1MnljhT7pAEeg4AIrHOcJWnmPs=;
        b=io9ytJmCkvpMyiUMweIHCy52gnJncw98AoZhhKYH1Zykn74XQBwhY59T8LrK9+iT4M
         itR6U0CB3btSrHqliu7bow2d8oE+YiQGEcT0VkKHES4Q7/jDhoO1laRlQ1JTr+J73NqG
         Mwz1oqicjPXXhy93zSfqhOvYZmXUl5oQrtze1/bZQneWA1uGqol5hvacdUsNLCb8qNWB
         M/ZAZrsiFjqnT8vJ/5nggZ7ZQVQLYPcrca10unQLWkYcAjshoTrk2Fb2CrajxBPM5sot
         xB4vXBuJksDMURDhlOHRRYxSLzU8FETxI7MCfKLEF2JS/uV5udeGMoTNvO+Dp9UfhquT
         d63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUNciH/hkWjnuuT5P1MnljhT7pAEeg4AIrHOcJWnmPs=;
        b=5tgwSqj2uPVRhIIkca7PT+8Qu2KJ3JgtuKVHSz0Ek2jXiYeDuISl7HqNQovzdKiZLu
         jUoYSHfV1gI7KKt0pbr/vdXBVhCGyOk3iIX3M7TWJpcKp267r1EgLY9GjIn2A2hY9c8X
         UeI68Q2iCKwvEAWyBoQq3JCzc/54ySCdkxSowjkppc1NQIT2/hE7LWOveVpp19CpUodJ
         sDS2Bh/rs1ByclJ6ZgoSXijvbfNVI3V+Rj4nOAJH5rRtBdHZf0I/j2vR5nEJPbCveVMC
         5VSOUzw0IMQNukvG8b8l7FAqfDcaCLnM7LCrjS3ve+PS00qmoQOE4QG4SaQ21XFd4fWv
         HLsQ==
X-Gm-Message-State: AOAM530wC6Q2BATdezn/zkC07hprbxQLIOUgwyyEAwnx0WiBEK5Wk9CU
        cT/sNGil914tTM2/dbs/qUM=
X-Google-Smtp-Source: ABdhPJwHHFwc7OLTQH1CBkOFrPUNjVCjncdrAwug3lXX8oH9Qf5tOrL05BD6fCIop2qw05rvpxnr1A==
X-Received: by 2002:a05:6870:8222:: with SMTP id n34mr1019239oae.67.1644355036957;
        Tue, 08 Feb 2022 13:17:16 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:16 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 03/11] RDMA/rxe: Replace grp by mcg, mce by mca
Date:   Tue,  8 Feb 2022 15:16:37 -0600
Message-Id: <20220208211644.123457-4-rpearsonhpe@gmail.com>
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

Replace 'grp' by 'mcg', 'mce' by 'mca'.
Shorten subroutine names in rxe_mcast.c.
These name uses are more in line with other object names used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 110 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   8 +-
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 3c06b0590c82..96dc11a892a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -26,66 +26,66 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /* caller should hold rxe->mcg_lock */
-static struct rxe_mcg *__rxe_create_grp(struct rxe_dev *rxe,
+static struct rxe_mcg *__rxe_create_mcg(struct rxe_dev *rxe,
 					struct rxe_pool *pool,
 					union ib_gid *mgid)
 {
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 	int err;
 
-	grp = rxe_alloc_locked(pool);
-	if (!grp)
+	mcg = rxe_alloc_locked(pool);
+	if (!mcg)
 		return ERR_PTR(-ENOMEM);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_ref(grp);
+		rxe_drop_ref(mcg);
 		return ERR_PTR(err);
 	}
 
-	INIT_LIST_HEAD(&grp->qp_list);
-	grp->rxe = rxe;
+	INIT_LIST_HEAD(&mcg->qp_list);
+	mcg->rxe = rxe;
 
-	/* rxe_alloc_locked takes a ref on grp but that will be
-	 * dropped when grp goes out of scope. We need to take a ref
+	/* rxe_alloc_locked takes a ref on mcg but that will be
+	 * dropped when mcg goes out of scope. We need to take a ref
 	 * on the pointer that will be saved in the red-black tree
-	 * by rxe_add_key and used to lookup grp from mgid later.
+	 * by rxe_add_key and used to lookup mcg from mgid later.
 	 * Adding key makes object visible to outside so this should
 	 * be done last after the object is ready.
 	 */
-	rxe_add_ref(grp);
-	rxe_add_key_locked(grp, mgid);
+	rxe_add_ref(mcg);
+	rxe_add_key_locked(mcg, mgid);
 
-	return grp;
+	return mcg;
 }
 
-static struct rxe_mcg *rxe_mcast_get_grp(struct rxe_dev *rxe,
+static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe,
 					 union ib_gid *mgid)
 {
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return ERR_PTR(-EINVAL);
 
 	spin_lock_bh(&rxe->mcg_lock);
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (!grp)
-		grp = __rxe_create_grp(rxe, pool, mgid);
+	mcg = rxe_pool_get_key_locked(pool, mgid);
+	if (!mcg)
+		mcg = __rxe_create_mcg(rxe, pool, mgid);
 	spin_unlock_bh(&rxe->mcg_lock);
 
-	return grp;
+	return mcg;
 }
 
-static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-				  struct rxe_mcg *grp)
+static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
+				  struct rxe_mcg *mcg)
 {
 	struct rxe_mca *mca, *tmp;
 	int err;
 
 	/* check to see if the qp is already a member of the group */
 	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(mca, &grp->qp_list, qp_list) {
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
@@ -100,7 +100,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just attached qp */
-	list_for_each_entry(tmp, &grp->qp_list, qp_list) {
+	list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
 		if (tmp->qp == qp) {
 			kfree(mca);
 			err = 0;
@@ -109,7 +109,7 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	/* check limits after checking if already attached */
-	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
 		kfree(mca);
 		err = -ENOMEM;
 		goto out;
@@ -120,8 +120,8 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	mca->qp = qp;
 
 	atomic_inc(&qp->mcg_num);
-	grp->num_qp++;
-	list_add(&mca->qp_list, &grp->qp_list);
+	mcg->num_qp++;
+	list_add(&mca->qp_list, &mcg->qp_list);
 
 	err = 0;
 out:
@@ -130,21 +130,21 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 }
 
 /* caller should be holding rxe->mcg_lock */
-static void __rxe_destroy_grp(struct rxe_mcg *grp)
+static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
-	/* first remove grp from red-black tree then drop ref */
-	rxe_drop_key_locked(grp);
-	rxe_drop_ref(grp);
+	/* first remove mcg from red-black tree then drop ref */
+	rxe_drop_key_locked(mcg);
+	rxe_drop_ref(mcg);
 
-	rxe_mcast_delete(grp->rxe, &grp->mgid);
+	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
 }
 
-static void rxe_destroy_grp(struct rxe_mcg *grp)
+static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
-	struct rxe_dev *rxe = grp->rxe;
+	struct rxe_dev *rxe = mcg->rxe;
 
 	spin_lock_bh(&rxe->mcg_lock);
-	__rxe_destroy_grp(grp);
+	__rxe_destroy_mcg(mcg);
 	spin_unlock_bh(&rxe->mcg_lock);
 }
 
@@ -153,22 +153,22 @@ void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 	/* nothing left to do for now */
 }
 
-static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
+static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 	struct rxe_mca *mca, *tmp;
 	int err;
 
 	spin_lock_bh(&rxe->mcg_lock);
-	grp = rxe_pool_get_key_locked(&rxe->mc_grp_pool, mgid);
-	if (!grp) {
+	mcg = rxe_pool_get_key_locked(&rxe->mc_grp_pool, mgid);
+	if (!mcg) {
 		/* we didn't find the mcast group for mgid */
 		err = -EINVAL;
 		goto out_unlock;
 	}
 
-	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
+	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			list_del(&mca->qp_list);
 
@@ -178,16 +178,16 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			 * object since we are still holding a ref
 			 * from the get key above.
 			 */
-			grp->num_qp--;
-			if (grp->num_qp <= 0)
-				__rxe_destroy_grp(grp);
+			mcg->num_qp--;
+			if (mcg->num_qp <= 0)
+				__rxe_destroy_mcg(mcg);
 
 			atomic_dec(&qp->mcg_num);
 
 			/* drop the ref from get key. This will free the
 			 * object if num_qp is zero.
 			 */
-			rxe_drop_ref(grp);
+			rxe_drop_ref(mcg);
 			kfree(mca);
 			err = 0;
 			goto out_unlock;
@@ -195,7 +195,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	/* we didn't find the qp on the list */
-	rxe_drop_ref(grp);
+	rxe_drop_ref(mcg);
 	err = -EINVAL;
 
 out_unlock:
@@ -208,20 +208,20 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 
-	/* takes a ref on grp if successful */
-	grp = rxe_mcast_get_grp(rxe, mgid);
-	if (IS_ERR(grp))
-		return PTR_ERR(grp);
+	/* takes a ref on mcg if successful */
+	mcg = rxe_get_mcg(rxe, mgid);
+	if (IS_ERR(mcg))
+		return PTR_ERR(mcg);
 
-	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
+	err = rxe_attach_mcg(rxe, qp, mcg);
 
-	/* if we failed to attach the first qp to grp tear it down */
-	if (grp->num_qp == 0)
-		rxe_destroy_grp(grp);
+	/* if we failed to attach the first qp to mcg tear it down */
+	if (mcg->num_qp == 0)
+		rxe_destroy_mcg(mcg);
 
-	rxe_drop_ref(grp);
+	rxe_drop_ref(mcg);
 	return err;
 }
 
@@ -230,5 +230,5 @@ int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
 
-	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
+	return rxe_detach_mcg(rxe, qp, mgid);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index a084b5d69937..d91c6660e83c 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -234,7 +234,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 {
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	struct rxe_mcg *mcg;
-	struct rxe_mca *mce;
+	struct rxe_mca *mca;
 	struct rxe_qp *qp;
 	union ib_gid dgid;
 	int err;
@@ -257,8 +257,8 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	 * single QP happen and just move on and try
 	 * the rest of them on the list
 	 */
-	list_for_each_entry(mce, &mcg->qp_list, qp_list) {
-		qp = mce->qp;
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+		qp = mca->qp;
 
 		/* validate qp for incoming packet */
 		err = check_type_state(rxe, pkt, qp);
@@ -273,7 +273,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		 * skb and pass to the QP. Pass the original skb to
 		 * the last QP in the list.
 		 */
-		if (mce->qp_list.next != &mcg->qp_list) {
+		if (mca->qp_list.next != &mcg->qp_list) {
 			struct sk_buff *cskb;
 			struct rxe_pkt_info *cpkt;
 
-- 
2.32.0

