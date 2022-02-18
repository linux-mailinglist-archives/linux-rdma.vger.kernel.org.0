Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA784BAEA0
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiBRAhH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:37:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBRAhG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:37:06 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636631204
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:47 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id p206-20020a4a2fd7000000b0031bfec11983so1625554oop.13
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3jITvxHsmfjM2foI63paWiJpQ6hbFJZ0L2SyxXtHAA=;
        b=QEWe+6a0v88BxtXZRQuvkAOVe0VdFyl41Fe1eWq0fzz9yWj14wVXntlgNxvipYdY7N
         dy0S46H4WkQCsf0xpAEIO6A+DdP6jANaXWZqB5sguE3KQEJzi5yVI95zyCSda11XiFIH
         gNL735d+d54S58DfEUV4SJjwqTE+6PGbGGBsK+rfIe4DKvt4Iyt6GDPlz3cV+E4kZR6a
         3igxfH8snFZBIL5mrWM0mclVb2orwvTgX/8kRJAojU09ibJgyVrOaSpmxSDan2/AMuuJ
         Zqdu00h2X34EXWpiSC5E8p6y6nls2fdYod5vKg9DCHwmtcSEU2y6xlzFWVHYaNhDFmbd
         yQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3jITvxHsmfjM2foI63paWiJpQ6hbFJZ0L2SyxXtHAA=;
        b=dSmmGngB/UVrxi9E2ClwTwmqGwXBYTc4PEMrczPP0yHTujjuMzTn04cwGVdQw7H0Eq
         UoUAEvuMa3zZ78Uh9aNb2YyL9YnW/NlSt7Bv9t6RXf3Gxoe/TTOjT3bj9kUvWcsInO7i
         3vkLDRqE8eD0aHiOJa/g3WuaBG/xMfkj6l/KSAVbMMqFKi716X+S8aYhsU/lU+KaHnG3
         Fgyny2GNQXWLEQIOQHHAr3M++gt0OfuL+Y0seqrHze5LiL2hjEt13NsMTUY0zpqgIQXt
         mveJBDjEwV+CPYtSIIgLBNtAstkeDFLla5GigMkhxo0vijs8vGdJV2M4QqAHzugYJubn
         h1tg==
X-Gm-Message-State: AOAM531jBGYab1wiXeXGvN9Ut6LWDBlUXy98TbxcC3/+h+vfSc+R207x
        WJiL4CU0PfFBPuP6HTBrAgo=
X-Google-Smtp-Source: ABdhPJz4ly0mRQajTi2TXMMVZVSuSGOQk1d7O9rXBYf1qIhahZbejZT2snsCVDAOWJHVBz/A43jtcA==
X-Received: by 2002:a05:6870:d58b:b0:d2:8d1d:c12 with SMTP id u11-20020a056870d58b00b000d28d1d0c12mr3432189oao.108.1645144605115;
        Thu, 17 Feb 2022 16:36:45 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 6/6] RDMA/rxe: Convert mca read locking to RCU
Date:   Thu, 17 Feb 2022 18:35:44 -0600
Message-Id: <20220218003543.205799-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218003543.205799-1-rpearsonhpe@gmail.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
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
on mca in rxe_recv.c and rxe_mcast.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 97 +++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +
 3 files changed, 67 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 349a6fac2fcc..2bfec3748e1e 100644
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
@@ -288,7 +294,7 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 }
 
 /**
- * __rxe_init_mca - initialize a new mca holding lock
+ * __rxe_init_mca_rcu - initialize a new mca holding lock
  * @qp: qp object
  * @mcg: mcg object
  * @mca: empty space for new mca
@@ -298,8 +304,8 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
  *
  * Returns: 0 on success else an error
  */
-static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
-			  struct rxe_mca *mca)
+static int __rxe_init_mca_rcu(struct rxe_qp *qp, struct rxe_mcg *mcg,
+			      struct rxe_mca *mca)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	int n;
@@ -322,7 +328,10 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 	rxe_add_ref(qp);
 	mca->qp = qp;
 
-	list_add_tail(&mca->qp_list, &mcg->qp_list);
+	kref_get(&mcg->ref_cnt);
+	mca->mcg = mcg;
+
+	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);
 
 	return 0;
 }
@@ -343,14 +352,14 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
@@ -367,7 +376,7 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 		}
 	}
 
-	err = __rxe_init_mca(qp, mcg, mca);
+	err = __rxe_init_mca_rcu(qp, mcg, mca);
 	if (err)
 		kfree(mca);
 out:
@@ -376,15 +385,16 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 }
 
 /**
- * __rxe_cleanup_mca - cleanup mca object holding lock
- * @mca: mca object
- * @mcg: mcg object
+ * __rxe_destroy_mca - free mca resources
+ * @head: rcu_head embedded in mca
  *
  * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ *          all rcu read operations should be compelete
  */
-static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
+static void __rxe_destroy_mca(struct rcu_head *head)
 {
-	list_del(&mca->qp_list);
+	struct rxe_mca *mca = container_of(head, typeof(*mca), rcu);
+	struct rxe_mcg *mcg = mca->mcg;
 
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
@@ -394,6 +404,19 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 	kfree(mca);
 }
 
+/**
+ * __rxe_cleanup_mca_rcu - cleanup mca object holding lock
+ * @mca: mca object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ */
+static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)
+{
+	list_del_rcu(&mca->qp_list);
+	call_rcu(&mca->rcu, __rxe_destroy_mca);
+}
+
 /**
  * rxe_detach_mcg - detach qp from mcg
  * @mcg: mcg object
@@ -404,31 +427,35 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
-	struct rxe_mca *mca, *tmp;
-	unsigned long flags;
+	struct rxe_mca *mca;
+	int ret;
 
-	spin_lock_irqsave(&rxe->mcg_lock, flags);
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
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
-			return 0;
-		}
+	spin_lock_bh(&rxe->mcg_lock);
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
+		if (mca->qp == qp)
+			goto found;
 	}
 
 	/* we didn't find the qp on the list */
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
-	return -EINVAL;
+	ret = -EINVAL;
+	goto done;
+
+found:
+	__rxe_cleanup_mca_rcu(mca, mcg);
+
+	/* if the number of qp's attached to the
+	 * mcast group falls to zero go ahead and
+	 * tear it down. This will not free the
+	 * object since we are still holding a ref
+	 * from the caller
+	 */
+	if (atomic_read(&mcg->qp_num) <= 0)
+		__rxe_destroy_mcg(mcg);
+
+	ret = 0;
+done:
+	spin_unlock_bh(&rxe->mcg_lock);
+	return ret;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 9b21cbb22602..c2cab85c6576 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -265,15 +265,15 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
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
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6b15251ff67a..4ee51de50b95 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -364,7 +364,9 @@ struct rxe_mcg {
 
 struct rxe_mca {
 	struct list_head	qp_list;
+	struct rcu_head		rcu;
 	struct rxe_qp		*qp;
+	struct rxe_mcg		*mcg;
 };
 
 struct rxe_port {
-- 
2.32.0

