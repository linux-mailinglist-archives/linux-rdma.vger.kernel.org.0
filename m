Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9654AE3E4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386838AbiBHWYi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386885AbiBHVRZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B0DC0612B8
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:24 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i5so478450oih.1
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqRAEa887JpXbjOAQTwV/4n6IwZcJpoqvAlHonjohs0=;
        b=ZpnnO7x/QQWXRS9w7CyT6sMcbSHO/U/OWnXoENCTSq4HUHncFJG29troKP0X77B3Og
         MzBTMxZst/DtUts/z9FEyhLDi1h6RRyc5vapC11AjfmOPYsSfs1Zl5u4lkRMFcEnc61W
         tinwqaVQsMi/2EPVKOTanl5ynWp+D9FFopoa3hJCpRhG5ITs76acxPnIX7CQMuNvhj46
         MRQOsflBnHzZZ+Ju3c8taWg4xcYi3srUdxEI0H2Dh53Jr5iPVfOUf0zUsjI6ba6Ky6jY
         kwWQeMJkXgdgbv7nrmZLNDtwC2Aidfi4TT3iNtLc42QERc4wGA/2LUIlQfCFH/W6Iaem
         oRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqRAEa887JpXbjOAQTwV/4n6IwZcJpoqvAlHonjohs0=;
        b=vMa1hJB6GCkWEDMjDUrAuyGJEXEnZAvOx52YoQ/1V0Fy+lcohDYxrQbMvqg+4W2kzw
         7DctYLx5LSNtn+KhCmO/umvRXLMwO7c0T50vDwL/EAlKMDtFf8zOEmCTb4FK3eriJ3sb
         yjJAXVXjQQ10vcoqy4bZ7LWTXQTPpeTxIdbE1ZDIUag5LsGq3Bcd+nvapQwzofPjMGyF
         QAneedVyhCkAr7tNJK7RxTmLA4/6c0w2QLHEnd+8vtVkFPN41es8oNF+dHDkIEyLpikO
         wxJSQkoCcZa6SN8FihVQ2kAxiRDnoysAGvLSe2SdGuWHSQUYIBY1UH5F1jRVvN3hz4Q3
         WeeA==
X-Gm-Message-State: AOAM5315gdSxLqkXCfDgNi132UO5HVD9tYCXLY0g9g5BztkbEDE4rJAJ
        xyR9Got2Z2/XoB1gpG+WPzc=
X-Google-Smtp-Source: ABdhPJw7VUdzHblzaXmv2ONH7UyldfM8ItX7njYoP0YrKwGu98+QNxjT5tbGw6aIn+kOWHMKRy/YWw==
X-Received: by 2002:a05:6808:150d:: with SMTP id u13mr1429205oiw.55.1644355043026;
        Tue, 08 Feb 2022 13:17:23 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:22 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 09/11] RDMA/rxe: Finish cleanup of rxe_mcast.c
Date:   Tue,  8 Feb 2022 15:16:43 -0600
Message-Id: <20220208211644.123457-10-rpearsonhpe@gmail.com>
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

Cleanup rxe_mcast.c code. Minor changes and complete comments.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 189 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 2 files changed, 144 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 846147878607..b66839276aa6 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,12 +1,33 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+/*
+ * rxe_mcast.c implements driver support for multicast transport.
+ * It is based on two data structures struct rxe_mcg ('mcg') and
+ * struct rxe_mca ('mca'). An mcg is allocated each time a qp is
+ * attached to a new mgid for the first time. These are indexed by
+ * a red-black tree using the mgid. This data structure is searched
+ * for the mcg when a multicast packet is received and when another
+ * qp is attached to the same mgid. It is cleaned up when the last qp
+ * is detached from the mcg. Each time a qp is attached to an mcg an
+ * mca is created. It holds a pointer to the qp and is added to a list
+ * of qp's that are attached to the mcg. The qp_list is used to replicate
+ * mcast packets in the rxe receive path.
+ */
+
 #include "rxe.h"
-#include "rxe_loc.h"
 
+/**
+ * rxe_mcast_add - add multicast address to rxe device
+ * @rxe: rxe device object
+ * @mgid: multicast address as a gid
+ *
+ * Returns 0 on success else an error
+ */
 static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -16,6 +37,13 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_add(rxe->ndev, ll_addr);
 }
 
+/**
+ * rxe_mcast_delete - delete multicast address from rxe device
+ * @rxe: rxe device object
+ * @mgid: multicast address as a gid
+ *
+ * Returns 0 on success else an error
+ */
 static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -214,7 +242,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 
 /**
  * rxe_cleanup_mcg - cleanup mcg for kref_put
- * @kref:
+ * @kref: struct kref embedded in mcg
  */
 void rxe_cleanup_mcg(struct kref *kref)
 {
@@ -255,9 +283,57 @@ static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 	spin_unlock_bh(&mcg->rxe->mcg_lock);
 }
 
-static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
-				  struct rxe_mcg *mcg)
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
+ * @qp: qp object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold reference on qp and mcg.
+ * Returns: 0 on success else an error
+ */
+static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
+	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
 	int err;
 
@@ -286,73 +362,77 @@ static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	/* check limits after checking if already attached */
-	if (atomic_inc_return(&mcg->qp_num) > rxe->attr.max_mcast_qp_attach) {
-		atomic_dec(&mcg->qp_num);
+	err = __rxe_init_mca(qp, mcg, mca);
+	if (err)
 		kfree(mca);
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/* protect pointer to qp in mca */
-	rxe_add_ref(qp);
-	mca->qp = qp;
-
-	atomic_inc(&qp->mcg_num);
-	list_add(&mca->qp_list, &mcg->qp_list);
-
-	err = 0;
 out:
 	spin_unlock_bh(&rxe->mcg_lock);
 	return err;
 }
 
-static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
-				   union ib_gid *mgid)
+/**
+ * __rxe_cleanup_mca - cleanup mca object holding lock
+ * @mca: mca object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold a reference to mcg and rxe->mcg_lock
+ */
+static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 {
-	struct rxe_mcg *mcg;
-	struct rxe_mca *mca, *tmp;
-	int err;
+	list_del(&mca->qp_list);
 
-	mcg = rxe_lookup_mcg(rxe, mgid);
-	if (!mcg)
-		return -EINVAL;
+	atomic_dec(&mcg->qp_num);
+	atomic_dec(&mcg->rxe->mcg_attach);
+	atomic_dec(&mca->qp->mcg_num);
+	rxe_drop_ref(mca->qp);
+
+	kfree(mca);
+}
+
+/**
+ * rxe_detach_mcg - detach qp from mcg
+ * @mcg: mcg object
+ * @qp: qp object
+ *
+ * Returns: 0 on success else an error if qp is not attached.
+ */
+static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
+{
+	struct rxe_dev *rxe = mcg->rxe;
+	struct rxe_mca *mca, *tmp;
 
 	spin_lock_bh(&rxe->mcg_lock);
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
-			list_del(&mca->qp_list);
-			atomic_dec(&qp->mcg_num);
-			rxe_drop_ref(qp);
+			__rxe_cleanup_mca(mca, mcg);
 
 			/* if the number of qp's attached to the
 			 * mcast group falls to zero go ahead and
 			 * tear it down. This will not free the
 			 * object since we are still holding a ref
-			 * from the get key above.
+			 * from the caller
 			 */
-			if (atomic_dec_return(&mcg->qp_num) <= 0)
+			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
-			/* drop the ref from get key. This will free the
-			 * object if qp_num is zero.
-			 */
-			kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-			kfree(mca);
-			err = 0;
-			goto out_unlock;
+			spin_unlock_bh(&rxe->mcg_lock);
+			return 0;
 		}
 	}
 
 	/* we didn't find the qp on the list */
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-	err = -EINVAL;
-
-out_unlock:
 	spin_unlock_bh(&rxe->mcg_lock);
-	return err;
+	return -EINVAL;
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
@@ -365,7 +445,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (IS_ERR(mcg))
 		return PTR_ERR(mcg);
 
-	err = rxe_attach_mcg(rxe, qp, mcg);
+	err = rxe_attach_mcg(mcg, qp);
 
 	/* if we failed to attach the first qp to mcg tear it down */
 	if (atomic_read(&mcg->qp_num) == 0)
@@ -375,12 +455,29 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
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
 
-	return rxe_detach_mcg(rxe, qp, mgid);
+	err = rxe_detach_mcg(mcg, qp);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
+	return err;
 }
 
 /**
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 20fe3ee6589d..6b15251ff67a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -401,6 +401,7 @@ struct rxe_dev {
 	spinlock_t		mcg_lock;
 	struct rb_root		mcg_tree;
 	atomic_t		mcg_num;
+	atomic_t		mcg_attach;
 
 	spinlock_t		pending_lock; /* guard pending_mmaps */
 	struct list_head	pending_mmaps;
-- 
2.32.0

