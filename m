Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23D4A5220
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiAaWKT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiAaWKS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:18 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BE7C061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:18 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso14407008ott.7
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjZScGIBobsFfva4tVaWlGYA7Ed52AsbUVIfIYf+mXo=;
        b=dHq37mSidr2th7EKtwDO1F/m2aehyWPlTNNdd51j7lIuO+Lp1Me+OPVgyLo4zxWndq
         rjh/7gyY7z0t7oBFYinakAi+3RNHpUFHwbU6osTONnr1nHjfHqEArokN+sEk1azbDM/D
         6dVf6fKLlrgoJcUQtZ3TejIVujCfFc7VglLBpwzGuvGpL7xHHD2Vt7nd2vfwxPuMBJ8A
         TqHUCDp7uV7OYeyo0Kxf2mM8wl0VmZhogOdOVJps7NcdC4m366mSaV+LfPdRGiTYXBFV
         +YC0eVCGEjqoU9VZG9tXgmQX4uGWeX2H4+uLg6/xYZQYUyxy0hHmZljiYj5MivHH8l5e
         NNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjZScGIBobsFfva4tVaWlGYA7Ed52AsbUVIfIYf+mXo=;
        b=HxC25+B0kZ4TYJPO+CBUETaCBe9uV2ZUggtFGjyy81XGISA7fn6RCaAah6UM4hjQYH
         j7ubUbS9+/fA8TBHzEH710dreaqfEBdKFO7u0pJcmjM5IskNk4up3ixa3oIX872wMPnC
         3kLmSUEAUZRmZxekJ7CMrB+YMGgOPU/9etzEUCBuSk7I6FOcNOR/X9PsjtKqUYouy6DD
         UJ/Kb1AUGHVqigsinjuvYvin72rxQXfmw/Caf6zlS9V4Su6CUEB9S2crDmP3cW1aHV5/
         JbY9l3PB0F1wfeAnCPXYrD090Y0EOT6vPsg3lyF0M2EUeXfLDdd0ImlScg0j3vyXJaOl
         AejQ==
X-Gm-Message-State: AOAM5327H0VzoDVhWb6o1JgATGsbJTrhtV2abdbcSt2M3AVARwACsf4C
        7mZVpbmoXiCENRJWxMxe2mY=
X-Google-Smtp-Source: ABdhPJylawVz/C5zoBa3vVSqkPuH0CpYhJX9mFLhvZ81wpYVOXyEWDHoHiI0HEPgb7Dnp93q/IGp3g==
X-Received: by 2002:a05:6830:16cf:: with SMTP id l15mr12316326otr.378.1643667017671;
        Mon, 31 Jan 2022 14:10:17 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:17 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 17/17] RDMA/rxe: Finish cleanup of rxe_mcast.c
Date:   Mon, 31 Jan 2022 16:08:50 -0600
Message-Id: <20220131220849.10170-18-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleanup rxe_mcast.c code. Minor changes and complete comments.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 163 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 2 files changed, 124 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 2fccf69f9a4b..2e5b41063f83 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -175,6 +175,7 @@ static int __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	mcg->rxe = rxe;
 	mcg->index = rxe->mcg_next++;
 
+	/* take reference to protect pointer in red-black tree */
 	kref_get(&mcg->ref_cnt);
 	__rxe_insert_mcg(mcg);
 
@@ -263,6 +264,7 @@ void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 	struct rxe_dev *rxe = mcg->rxe;
 
 	__rxe_remove_mcg(mcg);
+	/* drop reference that protected pointer in red-black tree */
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
 	rxe_mcast_delete(rxe, &mcg->mgid);
@@ -282,11 +284,59 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 	spin_unlock_bh(&mcg->rxe->mcg_lock);
 }
 
-static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mcg *mcg)
+/**
+ * __rxe_init_mca - initialize a new mca holding lock
+ * @qp: qp object
+ * @mcg: mcg object
+ * @mca: empty space for new mca
+ *
+ * Context: caller must hold references on qp and mcg, rxe->mcg_lock
+ * and pass memory for new mca
+ *
+ * Returns: 0 on success else an error
+ */
+static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
+			  struct rxe_mca *mca)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int n;
+
+	n = atomic_inc_return(&rxe->mcg_attach);
+	if (n > rxe->attr.max_total_mcast_qp_attach) {
+		atomic_dec(&rxe->mcg_attach);
+		return -ENOMEM;
+	}
+
+	n = atomic_inc_return(&mcg->qp_num);
+	if (n > rxe->attr.max_mcast_qp_attach) {
+		atomic_dec(&mcg->qp_num);
+		atomic_dec(&rxe->mcg_attach);
+		return -ENOMEM;
+	}
+
+	atomic_inc(&qp->mcg_num);
+
+	rxe_add_ref(qp);
+	mca->qp = qp;
+
+	list_add_tail(&mca->qp_list, &mcg->qp_list);
+
+	return 0;
+}
+
+/**
+ * rxe_attach_mcg - attach qp to mcg if not already attached
+ * @mcg: mcg object
+ * @qp: qp object
+ *
+ * Context: caller must hold reference on qp and mcg.
+ * Returns: 0 on success else an error
+ */
+static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
+	struct rxe_dev *rxe = mcg->rxe;
+	struct rxe_mca *mca, *tmp;
 	int err;
-	struct rxe_mca *mca, *new_mca;
 
 	/* check to see if the qp is already a member of the group */
 	spin_lock_bh(&rxe->mcg_lock);
@@ -298,71 +348,84 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 	spin_unlock_bh(&rxe->mcg_lock);
 
-	/* speculative alloc new mca without using GFP_ATOMIC */
-	new_mca = kzalloc(sizeof(*mca), GFP_KERNEL);
-	if (!new_mca)
+	/* speculative alloc new mca */
+	mca = kzalloc(sizeof(*mca), GFP_KERNEL);
+	if (!mca)
 		return -ENOMEM;
 
 	spin_lock_bh(&rxe->mcg_lock);
 	/* re-check to see if someone else just attached qp */
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+	list_for_each_entry(tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			kfree(new_mca);
+			kfree(mca);
 			err = 0;
-			goto out;
+			goto done;
 		}
 	}
-	mca = new_mca;
 
-	if (atomic_read(&mcg->qp_num) >= rxe->attr.max_mcast_qp_attach) {
-		err = -ENOMEM;
-		goto out;
-	}
+	err = __rxe_init_mca(qp, mcg, mca);
+	if (err)
+		kfree(mca);
+done:
+	spin_unlock_bh(&rxe->mcg_lock);
 
-	atomic_inc(&mcg->qp_num);
-	mca->qp = qp;
-	atomic_inc(&qp->mcg_num);
+	return err;
+}
 
-	list_add_tail(&mca->qp_list, &mcg->qp_list);
+/**
+ * __rxe_cleanup_mca - cleanup mca object holding lock
+ * @mca: mca object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ */
+static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
+{
+	list_del(&mca->qp_list);
 
-	err = 0;
-out:
-	spin_unlock_bh(&rxe->mcg_lock);
-	return err;
+	rxe_drop_ref(mca->qp);
+
+	atomic_dec(&mcg->qp_num);
+	atomic_dec(&mcg->rxe->mcg_attach);
+	atomic_dec(&mca->qp->mcg_num);
 }
 
-static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-				   union ib_gid *mgid)
+/**
+ * rxe_detach_mcg - detach qp from mcg
+ * @mcg: mcg object
+ * @qp: qp object
+ *
+ * Returns: 0 on success else an error if qp is not attached.
+ */
+static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
-	struct rxe_mcg *mcg;
+	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
 
-	mcg = rxe_lookup_mcg(rxe, mgid);
-	if (!mcg)
-		goto err1;
-
 	spin_lock_bh(&rxe->mcg_lock);
-
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			list_del(&mca->qp_list);
-			if (atomic_dec_return(&mcg->qp_num) <= 0)
+			__rxe_cleanup_mca(mca, mcg);
+			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
-			atomic_dec(&qp->mcg_num);
-
 			spin_unlock_bh(&rxe->mcg_lock);
-			kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 			kfree(mca);
 			return 0;
 		}
 	}
-
 	spin_unlock_bh(&rxe->mcg_lock);
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-err1:
+
 	return -EINVAL;
 }
 
+/**
+ * rxe_attach_mcast - attach qp to multicast group (see IBA-11.3.1)
+ * @ibqp: (IB) qp object
+ * @mgid: multicast IP address
+ * @mlid: multicast LID, ignored for RoCEv2 (see IBA-A17.5.6)
+ *
+ * Returns: 0 on success else an errno
+ */
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	int err;
@@ -374,8 +437,11 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (err)
 		return err;
 
-	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
+	err = rxe_attach_mcg(mcg, qp);
 
+	/* this can happen if we failed to attach a first qp to mcg
+	 * go ahead and destroy mcg
+	 */
 	if (atomic_read(&mcg->qp_num) == 0)
 		rxe_destroy_mcg(mcg);
 
@@ -383,12 +449,29 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	return err;
 }
 
+/**
+ * rxe_detach_mcast - detach qp from multicast group (see IBA-11.3.2)
+ * @ibqp: address of (IB) qp object
+ * @mgid: multicast IP address
+ * @mlid: multicast LID, ignored for RoCEv2 (see IBA-A17.5.6)
+ *
+ * Returns: 0 on success else an errno
+ */
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
+	struct rxe_mcg *mcg;
+	int err;
 
-	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (!mcg)
+		return -EINVAL;
+
+	err = rxe_detach_mcg(mcg, qp);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
+	return err;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 72a913a8e0cb..716f11ec80fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -401,6 +401,7 @@ struct rxe_dev {
 	spinlock_t		mcg_lock; /* guard multicast groups */
 	struct rb_root		mcg_tree;
 	atomic_t		mcg_num;
+	atomic_t		mcg_attach;
 	unsigned int		mcg_next;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
-- 
2.32.0

