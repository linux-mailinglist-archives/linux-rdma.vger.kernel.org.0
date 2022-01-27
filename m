Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8849ED8E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbiA0ViU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344428AbiA0ViS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:18 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1EAC061749
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id g205so8542751oif.5
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+jpVfY+8XlJF2Rb2+/f1AwXvaR2DR0pHXW101pfcwY=;
        b=nWnL4suqlfVxWBytEVIQeiHFCtMMnzhTH1/eqNs89zwWgVIYrrVNYtWCqRhMIuK4XH
         PT43P5uD5wYdWRRHf05TdBaM7D/lA+tIDU0GqLSOghpmxMjrnbnodxLIBQ9MBgK/F2vM
         E+a5z3uWeefHwkF2maqRbLJ6sgTgdkYFcBcamO4pSChJyz63sMP8tPKDAQu5fC6pP1TH
         SvQGFwsNHjORfHTYqzvfeMbk+BbAyBlhNUpqQKkASloZDx9htkPCOHLi+5ewz49pWjFh
         PtBRR0BrfIpZlbDigWZES1WlDMPZ5FedWLEjNEl4G83r2F58O9BuQtdOOt873TbQ5pb0
         c1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+jpVfY+8XlJF2Rb2+/f1AwXvaR2DR0pHXW101pfcwY=;
        b=JPcA6CaeHDA5JyMWA/k13HiAhTVCJL+u3npaembzx/+cW94yvYo8+uielZ55Tml4nS
         z1fdu7gbKQFFN4KGpELj1A0VZ0sCH1SP0LtlmcRrSClyRkYXry2ut64jSWOmEVmErAkk
         6p4Q+JuGSolgBJZRaPFgCS/13rmvbU3fPNkdw4aAGb9PdHU3r4sjSmN8l9/8WOwOULhI
         YtROC4imWsWSjQG5NUuB40yHz351KWnqS72l1LUFYbVYnLI0P109hvr1P71Um3XVyQ48
         igI5zocS6iNXoG8cFOrMsLY71a+6gBTQeGLyEPig/swkMYYHE9PAa7YSyTs5XIa759wX
         LEsA==
X-Gm-Message-State: AOAM530fVPq/QDLfGneIix27z8X8sJTU/4b5wVUgp2x6tBAHXLRSkC66
        05DJRELYrlXnfxNdRI0yVA8=
X-Google-Smtp-Source: ABdhPJyx8bXU3fXRad5+SKELnbXrL2yz72PKVpR1SBIEsJR7bLSeUiZfMrA3A7puOpzye0OncUmnaQ==
X-Received: by 2002:a05:6808:1b13:: with SMTP id bx19mr3437927oib.284.1643319498188;
        Thu, 27 Jan 2022 13:38:18 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:17 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 18/26] RDMA/rxe: Convert mca read locking to RCU
Date:   Thu, 27 Jan 2022 15:37:47 -0600
Message-Id: <20220127213755.31697-19-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace spinlocks with rcu read locks for read side operations
on mca.n rxe_recv.c and rxe_mcast.c. Use rcu list extensions on
write side operations and keep spinlocks to separate write threads.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 57 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 865e6e85084f..c193bd4975f7 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -27,7 +27,8 @@
  * the mcg is created and an extra kref_put when the qp count decreases
  * to zero.
  *
- * The qp list and the red-black tree are protected by a single
+ * The qp list is protected for read operations by RCU and the qp list and
+ * the red-black tree are protected for write operations by a single
  * rxe->mcg_lock per device.
  */
 
@@ -270,7 +271,7 @@ void rxe_cleanup_mcg(struct kref *kref)
 }
 
 /**
- * __rxe_init_mca - initialize a new mca holding lock
+ * __rxe_init_mca_rcu - initialize a new mca holding lock
  * @qp: qp object
  * @mcg: mcg object
  * @mca: empty space for new mca
@@ -280,7 +281,7 @@ void rxe_cleanup_mcg(struct kref *kref)
  *
  * Returns: 0 on success else an error
  */
-static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
+static int __rxe_init_mca_rcu(struct rxe_qp *qp, struct rxe_mcg *mcg,
 			  struct rxe_mca *mca)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
@@ -304,7 +305,7 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 	rxe_add_ref(qp);
 	mca->qp = qp;
 
-	list_add_tail(&mca->qp_list, &mcg->qp_list);
+	list_add_tail_rcu(&mca->qp_list, &mcg->qp_list);
 
 	return 0;
 }
@@ -324,14 +325,14 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 	int err;
 
 	/* check to see if the qp is already a member of the group */
-	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			spin_unlock_bh(&rxe->mcg_lock);
+			rcu_read_unlock();
 			return 0;
 		}
 	}
-	spin_unlock_bh(&rxe->mcg_lock);
+	rcu_read_unlock();
 
 	/* speculative alloc new mca without using GFP_ATOMIC */
 	new_mca = kzalloc(sizeof(*mca), GFP_KERNEL);
@@ -340,16 +341,19 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just attached qp */
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
+			rcu_read_unlock();
 			kfree(new_mca);
 			err = 0;
 			goto done;
 		}
 	}
+	rcu_read_unlock();
 
 	mca = new_mca;
-	err = __rxe_init_mca(qp, mcg, mca);
+	err = __rxe_init_mca_rcu(qp, mcg, mca);
 	if (err)
 		kfree(mca);
 done:
@@ -359,21 +363,23 @@ static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 }
 
 /**
- * __rxe_cleanup_mca - cleanup mca object holding lock
+ * __rxe_cleanup_mca_rcu - cleanup mca object holding lock
  * @mca: mca object
  * @mcg: mcg object
  *
  * Context: caller must hold a reference to mcg and rxe->mcg_lock
  */
-static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
+static void __rxe_cleanup_mca_rcu(struct rxe_mca *mca, struct rxe_mcg *mcg)
 {
-	list_del(&mca->qp_list);
+	list_del_rcu(&mca->qp_list);
 
 	atomic_dec(&mcg->qp_num);
 	atomic_dec(&mcg->rxe->mcg_attach);
 	atomic_dec(&mca->qp->mcg_num);
 
 	rxe_drop_ref(mca->qp);
+
+	kfree_rcu(mca, rcu);
 }
 
 /**
@@ -386,22 +392,29 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = mcg->rxe;
-	struct rxe_mca *mca, *tmp;
+	struct rxe_mca *mca;
+	int ret;
 
 	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			__rxe_cleanup_mca(mca, mcg);
-			if (atomic_read(&mcg->qp_num) <= 0)
-				kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
-			spin_unlock_bh(&rxe->mcg_lock);
-			kfree(mca);
-			return 0;
+			rcu_read_unlock();
+			goto found;
 		}
 	}
+	rcu_read_unlock();
+	ret = -EINVAL;
+	goto done;
+found:
+	__rxe_cleanup_mca_rcu(mca, mcg);
+	if (atomic_read(&mcg->qp_num) <= 0)
+		kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
+	ret = 0;
+done:
 	spin_unlock_bh(&rxe->mcg_lock);
 
-	return -EINVAL;
+	return ret;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 357a6cea1484..7f2ea61a52c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -267,13 +267,13 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
 
 	n = 0;
-	spin_lock_bh(&rxe->mcg_lock);
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(mca, &mcg->qp_list, qp_list) {
 		qp_array[n++] = mca->qp;
 		if (n == nmax)
 			break;
 	}
-	spin_unlock_bh(&rxe->mcg_lock);
+	rcu_read_unlock();
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
 	nmax = n;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 76350d43ce2a..12bff190fc1f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -365,6 +365,7 @@ struct rxe_mcg {
 struct rxe_mca {
 	struct list_head	qp_list;
 	struct rxe_qp		*qp;
+	struct rcu_head		rcu;
 };
 
 struct rxe_port {
-- 
2.32.0

