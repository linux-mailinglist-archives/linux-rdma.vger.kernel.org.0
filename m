Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFA4A5217
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiAaWKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiAaWKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:11 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDBBC06173D
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:11 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m10so4537080oie.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N8RcOh3BB2FN1HL0D8zh2H7knefO2CFiWRvnb32iFdI=;
        b=j2JdxPZlBLAHAwd7obW1DUBGmkNPpBEvqDEY3f78rU5F2fa+JlOC5F3BXoIpAH5upm
         Fbd9LvXgl8zqSaIvgyzQgWIRflOCbScjJpRJ02Woj9ONQQju+hvNz8hteSIa4LOBzURA
         7k4EQuY493VMWb0capsvNrT7NpWPXOQgwFdz+2l6fmQAbF9uOUqVaHcUPJFD3qOXPWOr
         W0YVAzKVg89GzlRtez6pTDLiiyvdAk4pO+QgQGhL3c7GT38FklfvLnRVGRRiS18nTDGK
         eudA8hckJjS+1z2J3h3khiU6OJxbbeKn1Zubt/gs4m6P2pB7yo/vpkrcig0qcHIqi8iZ
         WGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N8RcOh3BB2FN1HL0D8zh2H7knefO2CFiWRvnb32iFdI=;
        b=2tygyEvYQQD7S+Vum200O1I/NTnUNWbf1axS7fHYqRxDi/N3dRXa+Ed5Q6tG3M/kQI
         /z71daFsrhDvrjqWNfTxkSYbgfGryMbuUskgU5Hfc+VHrpLqen3o6SsYoWkGUbi3Vpsw
         Sk7Hq7472qC/FzmGLAVFnA77PWjbjWUmp67i4teyUsBkTn1zFSWbO1pvGzQBVyQlIVFR
         7thV8qRFVOeAtP7Lk1Df6Z0QnfBekaYpuXiL2rISDMMK2tGDZsQhqbtCOh5iy44kiRvo
         MNr9fYCgSDd0O/J6ejt8V6dHQ89iF6sSN5KMOz6TQmH9JndC9SNb6MuUaZDq9SQqft0l
         WUMw==
X-Gm-Message-State: AOAM530kQAjcSYojIKFunTIS2Mgrex1XiINGrv/XcUu1kJRFWgOJ/YVY
        8PLKTjo/EXo2QiCFhwbO2XU=
X-Google-Smtp-Source: ABdhPJy9ubc5+wRsHyFOEKVgKUgSwiwajn6tFI84ARmtPSjJCV5zUlOUkx30BTX8QPmPSd0L9KIQPA==
X-Received: by 2002:a05:6808:210c:: with SMTP id r12mr14731219oiw.221.1643667010405;
        Mon, 31 Jan 2022 14:10:10 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:10 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 08/17] RDMA/rxe: Rename grp to mcg and mce to mca
Date:   Mon, 31 Jan 2022 16:08:41 -0600
Message-Id: <20220131220849.10170-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_mcast.c and rxe_recv.c replace 'grp' by 'mcg' and 'mce' by 'mca'.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 104 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |   8 +-
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 4a5896a225a6..29e6c9e11c77 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -26,47 +26,47 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /* caller should hold mc_grp_pool->pool_lock */
-static int __rxe_create_grp(struct rxe_dev *rxe, struct rxe_pool *pool,
-			    union ib_gid *mgid, struct rxe_mcg **grp_p)
+static int __rxe_create_mcg(struct rxe_dev *rxe, struct rxe_pool *pool,
+			    union ib_gid *mgid, struct rxe_mcg **mcg_p)
 {
 	int err;
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
-	if (!grp)
+	mcg = rxe_alloc_locked(&rxe->mc_grp_pool);
+	if (!mcg)
 		return -ENOMEM;
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_ref(grp);
+		rxe_drop_ref(mcg);
 		return err;
 	}
 
-	INIT_LIST_HEAD(&grp->qp_list);
-	spin_lock_init(&grp->mcg_lock);
-	grp->rxe = rxe;
+	INIT_LIST_HEAD(&mcg->qp_list);
+	spin_lock_init(&mcg->mcg_lock);
+	mcg->rxe = rxe;
 
-	rxe_add_ref(grp);
-	rxe_add_key_locked(grp, mgid);
+	rxe_add_ref(mcg);
+	rxe_add_key_locked(mcg, mgid);
 
-	*grp_p = grp;
+	*mcg_p = mcg;
 	return 0;
 }
 
 /* caller is holding a ref from lookup and mcg->mcg_lock*/
-void __rxe_destroy_mcg(struct rxe_mcg *grp)
+void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
-	rxe_drop_key(grp);
-	rxe_drop_ref(grp);
+	rxe_drop_key(mcg);
+	rxe_drop_ref(mcg);
 
-	rxe_mcast_delete(grp->rxe, &grp->mgid);
+	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
 }
 
-static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-			     struct rxe_mcg **grp_p)
+static int rxe_mcast_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
+			     struct rxe_mcg **mcg_p)
 {
 	int err;
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
@@ -74,11 +74,11 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	write_lock_bh(&pool->pool_lock);
 
-	grp = rxe_pool_get_key_locked(pool, mgid);
-	if (grp)
+	mcg = rxe_pool_get_key_locked(pool, mgid);
+	if (mcg)
 		goto done;
 
-	err = __rxe_create_grp(rxe, pool, mgid, &grp);
+	err = __rxe_create_mcg(rxe, pool, mgid, &mcg);
 	if (err) {
 		write_unlock_bh(&pool->pool_lock);
 		return err;
@@ -86,34 +86,34 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 done:
 	write_unlock_bh(&pool->pool_lock);
-	*grp_p = grp;
+	*mcg_p = mcg;
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
@@ -122,52 +122,52 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 	mca = new_mca;
 
-	if (grp->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	grp->num_qp++;
+	mcg->num_qp++;
 	mca->qp = qp;
 	atomic_inc(&qp->mcg_num);
 
-	list_add(&mca->qp_list, &grp->qp_list);
+	list_add(&mca->qp_list, &mcg->qp_list);
 
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
-				__rxe_destroy_mcg(grp);
+			mcg->num_qp--;
+			if (mcg->num_qp <= 0)
+				__rxe_destroy_mcg(mcg);
 			atomic_dec(&qp->mcg_num);
 
-			spin_unlock_bh(&grp->mcg_lock);
-			rxe_drop_ref(grp);
+			spin_unlock_bh(&mcg->mcg_lock);
+			rxe_drop_ref(mcg);
 			kfree(mca);
 			return 0;
 		}
 	}
 
-	spin_unlock_bh(&grp->mcg_lock);
-	rxe_drop_ref(grp);
+	spin_unlock_bh(&mcg->mcg_lock);
+	rxe_drop_ref(mcg);
 err1:
 	return -EINVAL;
 }
@@ -182,18 +182,18 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mcg *grp;
+	struct rxe_mcg *mcg;
 
-	err = rxe_mcast_get_grp(rxe, mgid, &grp);
+	err = rxe_mcast_get_mcg(rxe, mgid, &mcg);
 	if (err)
 		return err;
 
-	err = rxe_mcast_add_grp_elem(rxe, qp, grp);
+	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
 
-	if (grp->num_qp == 0)
-		__rxe_destroy_mcg(grp);
+	if (mcg->num_qp == 0)
+		__rxe_destroy_mcg(mcg);
 
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

