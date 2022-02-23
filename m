Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B514C1F5E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbiBWXIQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiBWXIO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:14 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B9E488AB
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:46 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so117774otn.10
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2HAbOM0HiU4XXojwFnPIQRYbPadds7FYpjB1DWzjo0=;
        b=ps8aWyzZUrXMIhdMQLOMorJsMnXMXqu4QkbamS5I4oRD5MnkgZll59kfOGredo6Pl5
         Cgd6Bly7XbEFUFYcUsRcK3iveC4F9Z/LzK1KyLTKhlv9uIFtY4boXkNXOOok5fgdtSYF
         r3IMg0xSVG6MsFpabY3hJWzkzpLcW2vMmtWs47bLczCLjcxZYALYrQFMX7aFQBScTHbh
         dT7L4gbwSn1jElrEEeZKE9mugx890AjMY5QR6r+myyGFLviasVFzqgGDKjzL9y+MFYpu
         77fCBX7UEiB8+8UutKRfsu/Lh/nwwTKWDwNZhDAJd456aETb4uFcV5lelDeedrsi6vUN
         fwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2HAbOM0HiU4XXojwFnPIQRYbPadds7FYpjB1DWzjo0=;
        b=FRIwjILRuqtAT+cU3GxVYkFkatyVTz+QhJCjXYn5URTrmwrbBLcQm7lVdBQrUevvDd
         scXOxANbQZtVFX9xOzpGA6tXy4nwU0mcfx0/5r9pf9Ez/gDdOqrS8ntLOTdx7STem8+B
         es02Bs8GpTrrHKILpigxzBW9Q20YakhY56ZxS2mJ0itu3otiNlBjvP58tbRCTULHWOob
         UD0qu0MMHfVS2zHlCC1GaOKKjPKNyqGqmy4eFB4YXhqCHGKwkXMIUSYoC0/amK2xo5Sg
         1M+n8dj+VAW07YglG8p5j1LOMIjbHRKkdoRQF9vHHjRottngMnM7oPKe2VBlmavMK7NH
         /jFA==
X-Gm-Message-State: AOAM530yvEwxb2de2tnXHfA8p8+CkgGiPF0HMIVoABqAK7wHuszjYFPa
        SfcjIMEs/szq7vzsPc2ccs3DYGOiVcw=
X-Google-Smtp-Source: ABdhPJzJ9K/Fn9J2IUk5bPSCmRRAbPyV7NlxgTNDMb1mCR6QDUP1sgEJ/tfWSf2fDSUAS+0hlzSm9A==
X-Received: by 2002:a05:6830:b8c:b0:59d:67ea:5da7 with SMTP id a12-20020a0568300b8c00b0059d67ea5da7mr761320otv.38.1645657665887;
        Wed, 23 Feb 2022 15:07:45 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 6/6] RDMA/rxe: Convert mca read locking to RCU
Date:   Wed, 23 Feb 2022 17:07:08 -0600
Message-Id: <20220223230706.50332-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mcast.c | 67 ++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ++
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index c399a29b648b..b2ca4bf5658f 100644
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
@@ -299,7 +305,7 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
  * Returns: 0 on success else an error
  */
 static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
-			  struct rxe_mca *mca)
+			      struct rxe_mca *mca)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	int n;
@@ -322,7 +328,12 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 	rxe_add_ref(qp);
 	mca->qp = qp;
 
-	list_add_tail(&mca->qp_list, &mcg->qp_list);
+	kref_get(&mcg->ref_cnt);
+	mca->mcg = mcg;
+
+	init_completion(&mca->complete);
+
+	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);
 
 	return 0;
 }
@@ -343,14 +354,14 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
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
@@ -375,6 +386,20 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	return err;
 }
 
+/**
+ * __rxe_destroy_mca - free mca resources
+ * @head: rcu_head embedded in mca
+ */
+static void rxe_destroy_mca(struct rcu_head *head)
+{
+	struct rxe_mca *mca = container_of(head, typeof(*mca), rcu);
+
+	atomic_dec(&mca->qp->mcg_num);
+	rxe_drop_ref(mca->qp);
+
+	complete(&mca->complete);
+}
+
 /**
  * __rxe_cleanup_mca - cleanup mca object holding lock
  * @mca: mca object
@@ -384,14 +409,12 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
  */
 static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 {
-	list_del(&mca->qp_list);
-
+	mca->mcg = NULL;
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
-	atomic_dec(&mca->qp->mcg_num);
-	rxe_drop_ref(mca->qp);
 
-	kfree(mca);
+	list_del_rcu(&mca->qp_list);
 }
 
 /**
@@ -404,11 +427,10 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
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
 			__rxe_cleanup_mca(mca, mcg);
 
@@ -420,14 +442,25 @@ static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 			 */
 			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
+			spin_unlock_bh(&rxe->mcg_lock);
+
+			/* schedule rxe_destroy_mca and then wait for
+			 * completion before returning to rdma-core.
+			 * Having an outstanding call_rcu() causes
+			 * rdma-core to fail. It may be simpler to
+			 * just call synchronize_rcu() and then
+			 * rxe_destroy_rcu(), but this works OK.
+			 */
+			call_rcu(&mca->rcu, rxe_destroy_mca);
+			wait_for_completion(&mca->complete);
+			kfree(mca);
 
-			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
 			return 0;
 		}
 	}
 
 	/* we didn't find the qp on the list */
-	spin_unlock_irqrestore(&rxe->mcg_lock, flags);
+	spin_unlock_bh(&rxe->mcg_lock);
 	return -EINVAL;
 }
 
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
index 6b15251ff67a..14a574e6140e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -364,7 +364,10 @@ struct rxe_mcg {
 
 struct rxe_mca {
 	struct list_head	qp_list;
+	struct rcu_head		rcu;
 	struct rxe_qp		*qp;
+	struct rxe_mcg		*mcg;
+	struct completion	complete;
 };
 
 struct rxe_port {
-- 
2.32.0

