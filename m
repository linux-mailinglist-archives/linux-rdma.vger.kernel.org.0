Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9549ED92
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiA0ViV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbiA0ViS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:18 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116C3C061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso3869516ott.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/bmw1xcxgv8ClRBPc9ZyzRB8UlHVaxTNT3B0AOI8DE=;
        b=Zb1B/XTjebax+dCI2Ta8zwm7toAHqzfLcmuCN34IERJ9KyDnHbCPWITNe8SKKuOCFV
         OFfeAl4PmTddC6em95YR4JU2pAT2We+fdVyadpDFpYMBys+ek9GX59mGSj+daCcMVVVE
         bpHWZMH6Zaun2gJ9XSHYfT9FKcobVm6X9c0gGPKV+T7R3ZuFAe/PqQopu6ahuX8fEI1T
         9NCaxJ1et3p4WnVQmHjUmR0afhttJvBq0Ylwibk7/1iNPe1f7JVIa54uoHJa3MbBtLIq
         oBMGl+fvakgOk47+UsFUoiuv5Mtm/ztIrRPGcM4ucVpiRQh05Vqpu6hSN7zHvAPNxarS
         Nvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/bmw1xcxgv8ClRBPc9ZyzRB8UlHVaxTNT3B0AOI8DE=;
        b=m4aa0Y4BDlyI1xgyO9f1C2a1gqc8LHvzj9Wx9VbCdUPb7rpLeRq2WhHyh5wnHC3NFg
         YOPfizEVqAx4T/R/W2jwuFwdJ98969XSjfDWz7evyRQi6/7sW/mi1Ax0dxmaeggPo19D
         +LiqiGZlgDYCQnXdCm+w71h6D+yy9g94AKr+29vaGyKr0uFn9L1uCTWik+qe8lCy3iHe
         KR//Avus+Py0zXUQUBfsVcVJT7N1WEgUyDh1hhszEmXZmrV9O5y2UP3E3nmPDZ9u0otb
         6xtJqbwYTv4RNDTYrXarqgdT8CPrx12GEuOX0JsTN8/cQS7R0eOmkPFFDnz87OvqQlT8
         2FRQ==
X-Gm-Message-State: AOAM533E9GRJNOAfw6Rmz9/1WkJmqOLoUJEBD30mJ6bETZNQMuZnJDID
        ifZVc3Ut0HINTLT1GCdw7BNT6jnS9p4=
X-Google-Smtp-Source: ABdhPJxhAj3EuRqy9rkMPRaR0sY/lvvJi5533Cjr2Xr74rz+JfK29Zc5gkdmST/bqC09zHP81LtzZA==
X-Received: by 2002:a05:6830:2304:: with SMTP id u4mr3175714ote.348.1643319497446;
        Thu, 27 Jan 2022 13:38:17 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:17 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 17/26] RDMA/rxe: Separate code into subroutines
Date:   Thu, 27 Jan 2022 15:37:46 -0600
Message-Id: <20220127213755.31697-18-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cleanup rxe_mcast.c code by separating initialization and cleanup
of mca objects into subroutines. Added remaining documentation
comments.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 162 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 2 files changed, 121 insertions(+), 42 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 77f166a5d5c8..865e6e85084f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -178,7 +178,7 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 		       struct rxe_mcg **mcgp)
 {
 	struct rxe_mcg *mcg, *tmp;
-	int ret;
+	int err;
 
 	if (rxe->attr.max_mcast_grp == 0)
 		return -EINVAL;
@@ -206,12 +206,12 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	}
 
 	if (atomic_inc_return(&rxe->mcg_num) > rxe->attr.max_mcast_grp) {
-		ret = -ENOMEM;
+		err = -ENOMEM;
 		goto err_dec;
 	}
 
-	ret = rxe_mcast_add(rxe, mgid);
-	if (ret)
+	err = rxe_mcast_add(rxe, mgid);
+	if (err)
 		goto err_dec;
 
 	kref_init(&mcg->ref_cnt);
@@ -230,7 +230,7 @@ static int rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 	atomic_dec(&rxe->mcg_num);
 	spin_unlock_bh(&rxe->mcg_lock);
 	kfree(mcg);
-	return ret;
+	return err;
 }
 
 /**
@@ -269,11 +269,59 @@ void rxe_cleanup_mcg(struct kref *kref)
 	spin_unlock_bh(&rxe->mcg_lock);
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
 {
-	int err;
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
+{
+	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *new_mca;
+	int err;
 
 	/* check to see if the qp is already a member of the group */
 	spin_lock_bh(&rxe->mcg_lock);
@@ -296,61 +344,74 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		if (mca->qp == qp) {
 			kfree(new_mca);
 			err = 0;
-			goto out;
+			goto done;
 		}
 	}
 
-	if (atomic_read(&mcg->qp_num) >= rxe->attr.max_mcast_qp_attach) {
-		err = -ENOMEM;
-		goto out;
-	}
+	mca = new_mca;
+	err = __rxe_init_mca(qp, mcg, mca);
+	if (err)
+		kfree(mca);
+done:
+	spin_unlock_bh(&rxe->mcg_lock);
 
-	atomic_inc(&mcg->qp_num);
-	new_mca->qp = qp;
-	atomic_inc(&qp->mcg_num);
+	return err;
+}
+
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
 
-	list_add_tail(&new_mca->qp_list, &mcg->qp_list);
+	atomic_dec(&mcg->qp_num);
+	atomic_dec(&mcg->rxe->mcg_attach);
+	atomic_dec(&mca->qp->mcg_num);
 
-	err = 0;
-out:
-	spin_unlock_bh(&rxe->mcg_lock);
-	return err;
+	rxe_drop_ref(mca->qp);
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
-	int n;
-
-	mcg = rxe_lookup_mcg(rxe, mgid);
-	if (!mcg)
-		goto err1;
 
 	spin_lock_bh(&rxe->mcg_lock);
-
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			list_del(&mca->qp_list);
-			n = atomic_dec_return(&mcg->qp_num);
-			if (n <= 0)
+			__rxe_cleanup_mca(mca, mcg);
+			if (atomic_read(&mcg->qp_num) <= 0)
 				kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
-			atomic_dec(&qp->mcg_num);
-
 			spin_unlock_bh(&rxe->mcg_lock);
-			kref_put(&mcg->ref_cnt, __rxe_cleanup_mcg);
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
@@ -363,18 +424,35 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (err)
 		return err;
 
-	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
-
+	err = rxe_attach_mcg(mcg, qp);
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
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
+
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (!mcg)
+		return -EINVAL;
 
-	return rxe_mcast_drop_grp_elem(rxe, qp, mgid);
+	err = rxe_detach_mcg(mcg, qp);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
+	return err;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index dea24ebdb3d0..76350d43ce2a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -400,6 +400,7 @@ struct rxe_dev {
 	spinlock_t		mcg_lock; /* guard multicast groups */
 	struct rb_root		mcg_tree;
 	atomic_t		mcg_num;
+	atomic_t		mcg_attach;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

