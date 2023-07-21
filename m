Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214A975D5F8
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGUUvL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGUUvK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:10 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583C30EA
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a3b7f992e7so1617741b6e.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972668; x=1690577468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piWlo3/tFoxJPMOCyPDxN1hN4WpGqotBjw4+5hWeBIw=;
        b=N3ouiJxZNu+IYfsBXrbv0SITQKyVAEaJIUJsryFcFVTJ74dY8MOeJ6VoPYPROdY5Zx
         nMb5ThWtd8HCUGQqy0k1o7BAwujDEmpjiDdTOFeetp06VFIEIeEtDKtrw7QBWwvbcsRT
         Cboaf2kB3NCWHdtl/oMP58rj5ONGUNEHAAY7k/ZxB/yrXJss+dFUTy1GHoybK/sl8CdR
         alZbyJyTx4QfC+4BjFGs8VHGEv7dKAWZpFrZmgMthtWOsfOKXo96jPonZSLJH7+m8+7U
         aelLApWDkMTrC20M+YbeSfUKlbgZxU6Ax8kg0KZsU5Va3w/zQQr+VZB0R/42oMOq7/fW
         mhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972668; x=1690577468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piWlo3/tFoxJPMOCyPDxN1hN4WpGqotBjw4+5hWeBIw=;
        b=VanE+ETTrtr2lXlcTYWYRq7aSpoymnLp6qmY/xFcq70dkxApIlPiALp8FEmxoHa/OZ
         vNlJXyyi1OIMsXgqeSXBd+hY3t66BAZ5AMySqHihVvITSgILeyUJ/VFg5ZqCX5S6rF7g
         0ALQUvJF1GN0h1tqMN7QqeFcv5NkZCiZGwG+EfqaIpYRicTqo7KzTDIgRD78sAPvjwB3
         zftnB41zkSldckxJ//ni1hujv4r28tnTNEvwhUgnH7/7C9JjC8aWE46t8hpoD4eAfJH9
         Yskart6J52O2TDdNI44Z4lQL1RGngl6ULES13055ehHJC4qS8WC17ZuTVLf6ij2jGejj
         bQgg==
X-Gm-Message-State: ABy/qLYhsKrXriWGaBjDTuDWJ/dzKpWwD6duD99WFPaG5z019y+MAnAB
        lpG5cmuzkt5+X7noOmaL7sI=
X-Google-Smtp-Source: APBJJlGAsh/ktYStvvs8T3mEVTy2DB3PS4cqEFNhGyX/xdNdr7iigryVn4p0qMJb7Yi1FG6otRPQZA==
X-Received: by 2002:a54:4487:0:b0:3a4:8a13:9891 with SMTP id v7-20020a544487000000b003a48a139891mr3122256oiv.16.1689972668506;
        Fri, 21 Jul 2023 13:51:08 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/9] RDMA/rxe: Fix freeing busy objects
Date:   Fri, 21 Jul 2023 15:50:16 -0500
Message-Id: <20230721205021.5394-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver calls wait_for_completion_timeout() in
rxe_complete() to wait for the references to the object to be
freed before final cleanup and returning to the rdma-core
destroy verb. If this does not happen within the timeout interval
it prints a WARN_ON and returns to the 'destroy' verb caller
without any indication that there was an error. This is incorrect.

A heavily loaded system can take an arbitrarily long time to
complete the work needed before freeing all the references with no
guarantees of performance within a specific time.

Another frequent cause of these timeouts is due to ref counting bugs
introduced by changes in the driver so it is helpful to report the
timeouts if they occur.

This patch changes the type of the rxe_cleanup() subroutine to void
and fixes calls to reflect this API change in rxe_verbs.c. This is
better aligned with the code in rdma-core which sometimes fails to
check the return value of destroy verb calls assuming they will always
succeed. Specifically this is the case for kernel qp's.

Not able to return an error, this patch puts the completion timeout or
busy wait code into a subroutine called wait_until_done(). And places
the call in a loop with a 10 second timeout that issues a WARN_ON
each pass through the loop. This is slow enough to not overload the
logs.

Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 39 ++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 79 +++++++--------------------
 3 files changed, 38 insertions(+), 82 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index b88492f5f300..9877a798258a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,7 +6,7 @@
 
 #include "rxe.h"
 
-#define RXE_POOL_TIMEOUT	(200)
+#define RXE_POOL_TIMEOUT	(10000)	/* 10 seconds */
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -175,16 +175,17 @@ static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 
-	complete(&elem->complete);
+	complete_all(&elem->complete);
 }
 
-int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
+void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 {
 	struct rxe_pool *pool = elem->pool;
 	struct xarray *xa = &pool->xa;
-	static int timeout = RXE_POOL_TIMEOUT;
+	int timeout = RXE_POOL_TIMEOUT;
+	unsigned long until;
 	unsigned long flags;
-	int ret, err = 0;
+	int ret;
 	void *xa_ret;
 
 	if (sleepable)
@@ -209,39 +210,31 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
 	 * return to rdma-core
 	 */
 	if (sleepable) {
-		if (!completion_done(&elem->complete) && timeout) {
+		while (!completion_done(&elem->complete) && timeout) {
 			ret = wait_for_completion_timeout(&elem->complete,
 					timeout);
-
-			/* Shouldn't happen. There are still references to
-			 * the object but, rather than deadlock, free the
-			 * object or pass back to rdma-core.
-			 */
-			if (WARN_ON(!ret))
-				err = -EINVAL;
+			WARN_ON(!ret);
 		}
 	} else {
-		unsigned long until = jiffies + timeout;
-
 		/* AH objects are unique in that the destroy_ah verb
 		 * can be called in atomic context. This delay
 		 * replaces the wait_for_completion call above
 		 * when the destroy_ah call is not sleepable
 		 */
-		while (!completion_done(&elem->complete) &&
-				time_before(jiffies, until))
-			mdelay(1);
-
-		if (WARN_ON(!completion_done(&elem->complete)))
-			err = -EINVAL;
+		while (!completion_done(&elem->complete) && timeout) {
+			until = jiffies + timeout;
+			while (!completion_done(&elem->complete) &&
+			       time_before(jiffies, until)) {
+				mdelay(10);
+			}
+			WARN_ON(!completion_done(&elem->complete));
+		}
 	}
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	atomic_dec(&pool->num_elem);
-
-	return err;
 }
 
 int __rxe_get(struct rxe_pool_elem *elem)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index d764c51ed6f7..efef4b05d1ed 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -71,7 +71,7 @@ int __rxe_get(struct rxe_pool_elem *elem);
 int __rxe_put(struct rxe_pool_elem *elem);
 #define rxe_put(obj) __rxe_put(&(obj)->elem)
 
-int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable);
+void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable);
 #define rxe_cleanup(obj) __rxe_cleanup(&(obj)->elem, true)
 #define rxe_cleanup_ah(obj, sleepable) __rxe_cleanup(&(obj)->elem, sleepable)
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5e93dbac17b3..67995c259916 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -218,11 +218,8 @@ static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
 static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
-	int err;
 
-	err = rxe_cleanup(uc);
-	if (err)
-		rxe_err_uc(uc, "cleanup failed, err = %d", err);
+	rxe_cleanup(uc);
 }
 
 /* pd */
@@ -248,11 +245,8 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
-	int err;
 
-	err = rxe_cleanup(pd);
-	if (err)
-		rxe_err_pd(pd, "cleanup failed, err = %d", err);
+	rxe_cleanup(pd);
 
 	return 0;
 }
@@ -266,7 +260,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	struct rxe_ah *ah = to_rah(ibah);
 	struct rxe_create_ah_resp __user *uresp = NULL;
 	bool sleepable = init_attr->flags & RDMA_CREATE_AH_SLEEPABLE;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		/* test if new user provider */
@@ -312,9 +306,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup_ah(ah, sleepable);
-	if (cleanup_err)
-		rxe_err_ah(ah, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup_ah(ah, sleepable);
 err_out:
 	rxe_err_ah(ah, "returned err = %d", err);
 	return err;
@@ -355,11 +347,8 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 	bool sleepable = flags & RDMA_DESTROY_AH_SLEEPABLE;
-	int err;
 
-	err = rxe_cleanup_ah(ah, sleepable);
-	if (err)
-		rxe_err_ah(ah, "cleanup failed, err = %d", err);
+	rxe_cleanup_ah(ah, sleepable);
 
 	return 0;
 }
@@ -372,7 +361,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
@@ -414,9 +403,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(srq);
-	if (cleanup_err)
-		rxe_err_srq(srq, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(srq);
 err_out:
 	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
@@ -515,11 +502,8 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
-	int err;
 
-	err = rxe_cleanup(srq);
-	if (err)
-		rxe_err_srq(srq, "cleanup failed, err = %d", err);
+	rxe_cleanup(srq);
 
 	return 0;
 }
@@ -532,7 +516,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	struct rxe_pd *pd = to_rpd(ibqp->pd);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_create_qp_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		if (udata->inlen) {
@@ -581,9 +565,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(qp);
-	if (cleanup_err)
-		rxe_err_qp(qp, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(qp);
 err_out:
 	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
@@ -649,9 +631,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	err = rxe_cleanup(qp);
-	if (err)
-		rxe_err_qp(qp, "cleanup failed, err = %d", err);
+	rxe_cleanup(qp);
 
 	return 0;
 
@@ -1062,7 +1042,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct rxe_dev *rxe = to_rdev(dev);
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_create_cq_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
@@ -1101,9 +1081,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(cq);
-	if (cleanup_err)
-		rxe_err_cq(cq, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(cq);
 err_out:
 	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
@@ -1208,9 +1186,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	err = rxe_cleanup(cq);
-	if (err)
-		rxe_err_cq(cq, "cleanup failed, err = %d", err);
+	rxe_cleanup(cq);
 
 	return 0;
 
@@ -1258,7 +1234,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
-	int err, cleanup_err;
+	int err;
 
 	if (access & ~RXE_ACCESS_SUPPORTED_MR) {
 		rxe_err_pd(pd, "access = %#x not supported (%#x)", access,
@@ -1290,9 +1266,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	return &mr->ibmr;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(mr);
-	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(mr);
 err_free:
 	kfree(mr);
 	rxe_err_pd(pd, "returned err = %d", err);
@@ -1339,7 +1313,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
-	int err, cleanup_err;
+	int err;
 
 	if (mr_type != IB_MR_TYPE_MEM_REG) {
 		err = -EINVAL;
@@ -1370,9 +1344,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(mr);
-	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", err);
+	rxe_cleanup(mr);
 err_free:
 	kfree(mr);
 err_out:
@@ -1383,25 +1355,16 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	int err, cleanup_err;
 
 	/* See IBA 10.6.7.2.6 */
 	if (atomic_read(&mr->num_mw) > 0) {
-		err = -EINVAL;
-		rxe_dbg_mr(mr, "mr has mw's bound");
-		goto err_out;
+		rxe_err_mr(mr, "mr has mw's bound");
+		return -EINVAL;
 	}
 
-	cleanup_err = rxe_cleanup(mr);
-	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
-
+	rxe_cleanup(mr);
 	kfree_rcu(mr, elem.rcu);
 	return 0;
-
-err_out:
-	rxe_err_mr(mr, "returned err = %d", err);
-	return err;
 }
 
 static ssize_t parent_show(struct device *device,
-- 
2.39.2

