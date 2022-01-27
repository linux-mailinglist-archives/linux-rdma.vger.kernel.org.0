Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25C049ED85
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344406AbiA0ViM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbiA0ViM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:12 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C65C061747
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:12 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m9so8483639oia.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2qlmGdU5fOOh7j0lEey+Dd6zBF++m9TinfKtP81AS0=;
        b=nKyZvDrlcC76WCPnbmfz24/DszgHSLKVa4zFE9kVvPt6c3QsjlXu7U4pZNYvjObIbL
         Oku6+G/j1nK/3aBnHX1is8zlReJVDMlDBmEj+2011tCMPn+AzzmKqJMQE+42D/UM+QtU
         NdOn4L6MfrkX29Edjq6agiHX81SPuAb4NNagx39pkqffUJ1P0IsAgwszNTAFWndmEBF7
         3Ijzl/zVLbirZSKdW5vdomWfdj2vLsBbQa6KpC1CDYnURjq6vDc5fYf3cxxrDR2u1ekO
         W2EhYbfzggymm6Suexn8bmoYkI6FCFALo7mAdPWtHvplEBOkve2VIX/HgdXHIff89i2/
         D4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2qlmGdU5fOOh7j0lEey+Dd6zBF++m9TinfKtP81AS0=;
        b=nv/cTuf34Ipr4oa2dgEd+el4n1XAU0QqJIYy/pS7Na9F+ijzKvmSCi04W6dPlK/DV2
         JiwS2aHin3uf18/ujzXjzP84NU4w0/UVZjbaj/cwYwk4F+HpNmmg52jDM+UUed2bGrhP
         oenPS1JI8tiAx2+n2gojOBopR1xGkVz3OtzAFYlnW/N0R6Fnxx6rWDZ0Svu7Yf9wZo3E
         s/gj9ozd/rS5gGnv+aRUWwmUYS+QF40uK+cHUbzIvn1AMuvvR+F22fAIW+KXrRG1J+QF
         7+SCR2egvVHXUxbTNKePfrr4lHtfmsHJCYCJmL1OWZkoVHP0Yh7PIYDoFeLOwp5/YbYN
         OUqQ==
X-Gm-Message-State: AOAM530Zi/5xZN3GoNlZc5G2HCsaZhmS365FhUO8XpttSCYSLqjuyCzD
        8i30aml+qwQRK5KVZMDRgls=
X-Google-Smtp-Source: ABdhPJxc6U50KUFLj8rvwdjIcbsYemIZl2EqcX2QICIkPG4wMJBjaogkW6/+IoUwmyqRDqW7NID0vg==
X-Received: by 2002:a05:6808:1452:: with SMTP id x18mr3777795oiv.30.1643319491475;
        Thu, 27 Jan 2022 13:38:11 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:11 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 08/26] RDMA/rxe: Rename grp to mcg and mce to mca
Date:   Thu, 27 Jan 2022 15:37:37 -0600
Message-Id: <20220127213755.31697-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_mcast.c and rxe_recv.c replace 'grp' by 'mcg' and 'mce' by 'mca'.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 102 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   8 +-
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 39f38ee665f2..ed1b9ca65da3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -31,33 +31,33 @@ static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 				     union ib_gid *mgid)
 {
 	int err;
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
-	if (!grp)
+	mcg = rxe_alloc_locked(&rxe->mc_grp_pool);
+	if (!mcg)
 		return ERR_PTR(-ENOMEM);
-	rxe_add_ref(grp);
+	rxe_add_ref(mcg);
 
-	INIT_LIST_HEAD(&grp->qp_list);
-	spin_lock_init(&grp->mcg_lock);
-	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
+	INIT_LIST_HEAD(&mcg->qp_list);
+	spin_lock_init(&mcg->mcg_lock);
+	mcg->rxe = rxe;
+	rxe_add_key_locked(mcg, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
-		rxe_drop_ref(grp);
+		rxe_drop_key_locked(mcg);
+		rxe_drop_ref(mcg);
 		return ERR_PTR(err);
 	}
 
-	return grp;
+	return mcg;
 }
 
 static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-			     struct rxe_mcg **grp_p)
+			     struct rxe_mcg **mcgp)
 {
 	int err;
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
@@ -65,47 +65,47 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	write_lock_bh(&pool->pool_lock);
 
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
+	mcg = rxe_pool_get_key_locked(pool, mgid);
+	if (mcg)
 		goto done;
 
-	grp = create_grp(rxe, pool, mgid);
-	if (IS_ERR(grp)) {
+	mcg = create_grp(rxe, pool, mgid);
+	if (IS_ERR(mcg)) {
 		write_unlock_bh(&pool->pool_lock);
-		err = PTR_ERR(grp);
+		err = PTR_ERR(mcg);
 		return err;
 	}
 
 done:
 	write_unlock_bh(&pool->pool_lock);
-	*grp_p = grp;
+	*mcgp = mcg;
 	return 0;
 }
 
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mcg *grp)
+			   struct rxe_mcg *mcg)
 {
 	int err;
 	struct rxe_mca *mca, *new_mca;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_bh(&grp->mcg_lock);
-	list_for_each_entry(mca, &grp->qp_list, qp_list) {
+	spin_lock_bh(&mcg->mcg_lock);
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_bh(&grp->mcg_lock);
+			spin_unlock_bh(&mcg->mcg_lock);
 			return 0;
 		}
 	}
-	spin_unlock_bh(&grp->mcg_lock);
+	spin_unlock_bh(&mcg->mcg_lock);
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	new_mca = kzalloc(sizeof(*mca), GFP_KERNEL);
 	if (!new_mca)
 		return -ENOMEM;
 
-	spin_lock_bh(&grp->mcg_lock);
+	spin_lock_bh(&mcg->mcg_lock);
 	/* re-check to see if someone else just attached qp */
-	list_for_each_entry(mca, &grp->qp_list, qp_list) {
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			kfree(new_mca);
 			err = 0;
@@ -113,63 +113,63 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	grp->num_qp++;
+	mcg->num_qp++;
 	new_mca->qp = qp;
 	atomic_inc(&qp->mcg_num);
 
-	list_add(&new_mca->qp_list, &grp->qp_list);
+	list_add(&new_mca->qp_list, &mcg->qp_list);
 
 	err = 0;
 out:
-	spin_unlock_bh(&grp->mcg_lock);
+	spin_unlock_bh(&mcg->mcg_lock);
 	return err;
 }
 
 static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 	struct rxe_mca *mca, *tmp;
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
-	if (!grp)
+	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	if (!mcg)
 		goto err1;
 
-	spin_lock_bh(&grp->mcg_lock);
+	spin_lock_bh(&mcg->mcg_lock);
 
-	list_for_each_entry_safe(mca, tmp, &grp->qp_list, qp_list) {
+	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			list_del(&mca->qp_list);
-			grp->num_qp--;
-			if (grp->num_qp <= 0)
-				rxe_drop_ref(grp);
+			mcg->num_qp--;
+			if (mcg->num_qp <= 0)
+				rxe_drop_ref(mcg);
 			atomic_dec(&qp->mcg_num);
 
-			spin_unlock_bh(&grp->mcg_lock);
-			rxe_drop_ref(grp);	/* ref from get_key */
+			spin_unlock_bh(&mcg->mcg_lock);
+			rxe_drop_ref(mcg);	/* ref from get_key */
 			kfree(mca);
 			return 0;
 		}
 	}
 
-	spin_unlock_bh(&grp->mcg_lock);
-	rxe_drop_ref(grp);			/* ref from get_key */
+	spin_unlock_bh(&mcg->mcg_lock);
+	rxe_drop_ref(mcg);			/* ref from get_key */
 err1:
 	return -EINVAL;
 }
 
 void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mcg *grp = container_of(elem, typeof(*grp), elem);
-	struct rxe_dev *rxe = grp->rxe;
+	struct rxe_mcg *mcg = container_of(elem, typeof(*mcg), elem);
+	struct rxe_dev *rxe = mcg->rxe;
 
-	rxe_drop_key(grp);
-	rxe_mcast_delete(rxe, &grp->mgid);
+	rxe_drop_key(mcg);
+	rxe_mcast_delete(rxe, &mcg->mgid);
 }
 
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
@@ -177,16 +177,16 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 
-	/* takes a ref on grp if successful */
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
+	/* takes a ref on mcg if successful */
+	err = rxe_mcast_get_grp(rxe, mgid, &mcg);
 	if (err)
 		return err;
 
-	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
+	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
 
-	rxe_drop_ref(grp);
+	rxe_drop_ref(mcg);
 	return err;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 7ff6b53555f4..814a002b8911 100644
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

