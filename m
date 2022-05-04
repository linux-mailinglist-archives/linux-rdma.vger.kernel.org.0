Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4959C51AF10
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbiEDUc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiEDUc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 16:32:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B94F9FE
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 13:28:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so1652733otk.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PB53WT78lnKTruEf4hygy3PSHBQ7rJEyVIrO9j7RbE=;
        b=DQehWy/+SBT288Vxg7FUuWna6kulN/4gFvvMpQpwb1gMq/Esb4qc5tI7aMNZxZe0as
         RkjyV2dX00jgqtSjMOo8d6eC7T7hovdOHpylB0CUG2ttZ9lM9Mt/sjYdfex78Be+1XQu
         Or33ljR195YcB5cHMLRCjX3fwzUbn1Yw++nyoB3dbfHHPOdKpF6zm3i487KBicat6hF3
         nEURrh7FHfWzhYm6CtTdywMddtG5MGTHyntAnvDO9xXd2uJx2hJVot/YWZ+NYdIAiVKM
         FrU/dqGJNM0FSYH2cHzZnDc8LRACU9GTHkFQEFdOPXPghDyjzkoKCSrRYvhljwqUPUFS
         UvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PB53WT78lnKTruEf4hygy3PSHBQ7rJEyVIrO9j7RbE=;
        b=8NdblzYMtq26ZobFZe84y80EJE0vfO4p6yMfWfM65REgJm/iVHBBu4HxEdWKfv+75d
         EiCKvMBoTS7j5Eo38gYfpBsFyXZcQmnmMTWr/Sv0ifV7pGZuIo7AheiD5tOqJAwVf+e5
         xYJ20KJjish1V5zQMmnU9fItHN/dC4ptSt2Mg5no4dhZrbRDkVRrKDX5Rw4KDiGTvWpA
         QnqIDq7pPN+N7b/kbwgfUhCXaUPoG//d6tESfmcw0+zans/ECKxoAvex0WG29HNgd9uV
         noTxk1mlplvcw1FAMcz+J2RdIyEhj4/c1GCJxhdWN71guVyEz0oWgwIa5tBURXPHZV/3
         5GhQ==
X-Gm-Message-State: AOAM531c1mcqSyCg7UjfFiJoVya6qNnXEE4Q0o0q93zGZOse54K7gRdm
        hdq0cLuuVmiRwbu7qd1aBoE=
X-Google-Smtp-Source: ABdhPJznk6q3JDfEU2WSXMjmW82Rb262/WTWiJvuEgihLthaP1sqncfBMMGYSCDx3zP7iQf6apTnWw==
X-Received: by 2002:a05:6830:314c:b0:605:877b:15ed with SMTP id c12-20020a056830314c00b00605877b15edmr7989226ots.38.1651696129306;
        Wed, 04 May 2022 13:28:49 -0700 (PDT)
Received: from u-22.tx.rr.com (2603-8081-140c-1a00-cd3c-40a1-4c10-b905.res6.spectrum.com. [2603:8081:140c:1a00:cd3c:40a1:4c10:b905])
        by smtp.googlemail.com with ESMTPSA id l9-20020a9d7a89000000b006060322127bsm5423538otn.75.2022.05.04.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:28:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Date:   Wed,  4 May 2022 15:28:17 -0500
Message-Id: <20220504202817.98247-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
while rxe_recv.c uses _bh spinlocks for the same lock.

Additionally the current code issues a warning that _irqrestore
is restoring hardware interrupts while some interrupts are
enabled. This is traced to calls to the calls to dev_mc_add/del().

Change the locking of rxe->mcg_lock in rxe_mcast.c to use
spin_(un)lock_bh() which matches that in rxe_recv.c. Also move
the calls to dev_mc_add and dev_mc_del outside of spinlocks.

Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Addressed comments from Jason re not placing calls to dev_mc_add/del
  inside of spinlocks.

 drivers/infiniband/sw/rxe/rxe_mcast.c | 81 ++++++++++++---------------
 1 file changed, 35 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index ae8f11cb704a..873a9b10307c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -38,13 +38,13 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /**
- * rxe_mcast_delete - delete multicast address from rxe device
+ * rxe_mcast_del - delete multicast address from rxe device
  * @rxe: rxe device object
  * @mgid: multicast address as a gid
  *
  * Returns 0 on success else an error
  */
-static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
+static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
 
@@ -143,11 +143,10 @@ static struct rxe_mcg *__rxe_lookup_mcg(struct rxe_dev *rxe,
 struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	mcg = __rxe_lookup_mcg(rxe, mgid);
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 
 	return mcg;
 }
@@ -159,17 +158,10 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
  * @mcg: new mcg object
  *
  * Context: caller should hold rxe->mcg lock
- * Returns: 0 on success else an error
  */
-static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
-			  struct rxe_mcg *mcg)
+static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
+			   struct rxe_mcg *mcg)
 {
-	int err;
-
-	err = rxe_mcast_add(rxe, mgid);
-	if (unlikely(err))
-		return err;
-
 	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
 	INIT_LIST_HEAD(&mcg->qp_list);
@@ -184,8 +176,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	 */
 	kref_get(&mcg->ref_cnt);
 	__rxe_insert_mcg(mcg);
-
-	return 0;
 }
 
 /**
@@ -198,7 +188,6 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	struct rxe_mcg *mcg, *tmp;
-	unsigned long flags;
 	int err;
 
 	if (rxe->attr.max_mcast_grp == 0)
@@ -209,36 +198,38 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	if (mcg)
 		return mcg;
 
+	/* check to see if we have reached limit */
+	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
+		err = -ENOMEM;
+		goto err_dec;
+	}
+
 	/* speculative alloc of new mcg */
 	mcg = kzalloc(sizeof(*mcg), GFP_KERNEL);
 	if (!mcg)
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just added it */
 	tmp = __rxe_lookup_mcg(rxe, mgid);
 	if (tmp) {
+		spin_unlock_bh(&rxe->mcg_lock);
+		atomic_dec(&rxe->mcg_num);
 		kfree(mcg);
-		mcg = tmp;
-		goto out;
+		return tmp;
 	}
 
-	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
-		err = -ENOMEM;
-		goto err_dec;
-	}
+	__rxe_init_mcg(rxe, mgid, mcg);
+	spin_unlock_bh(&rxe->mcg_lock);
 
-	err = __rxe_init_mcg(rxe, mgid, mcg);
-	if (err)
-		goto err_dec;
-out:
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
-	return mcg;
+	/* add mcast address outside of lock */
+	err = rxe_mcast_add(rxe, mgid);
+	if (!err)
+		return mcg;
 
+	kfree(mcg);
 err_dec:
 	atomic_dec(&rxe->mcg_num);
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
-	kfree(mcg);
 	return ERR_PTR(err);
 }
 
@@ -268,7 +259,6 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 	__rxe_remove_mcg(mcg);
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
-	rxe_mcast_delete(mcg->rxe, &mcg->mgid);
 	atomic_dec(&rxe->mcg_num);
 }
 
@@ -280,11 +270,12 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
  */
 static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
-	unsigned long flags;
+	/* delete mcast address outside of lock */
+	rxe_mcast_del(mcg->rxe, &mcg->mgid);
 
-	spin_lock_irqsave(&mcg->rxe->mcg_lock, flags);
+	spin_lock_bh(&mcg->rxe->mcg_lock);
 	__rxe_destroy_mcg(mcg);
-	spin_unlock_irqrestore(&mcg->rxe->mcg_lock, flags);
+	spin_unlock_bh(&mcg->rxe->mcg_lock);
 }
 
 /**
@@ -339,25 +330,24 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
-	unsigned long flags;
 	int err;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
 		}
 	}
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
 	if (!mca)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just attached qp */
 	list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
 		if (tmp->qp == qp) {
@@ -371,7 +361,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	if (err)
 		kfree(mca);
 out:
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
@@ -405,9 +395,8 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
-	unsigned long flags;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
+	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			__rxe_cleanup_mca(mca, mcg);
@@ -421,13 +410,13 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+			spin_unlock_bh(&rxe->mcg_lock);
 			return 0;
 		}
 	}
 
 	/* we didn't find the qp on the list */
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return -EINVAL;
 }
 
-- 
2.34.1

