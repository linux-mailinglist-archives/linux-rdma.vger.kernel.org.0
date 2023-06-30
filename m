Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40847743FF9
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 18:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjF3QlI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jun 2023 12:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjF3Qk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jun 2023 12:40:57 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F23AAF
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jun 2023 09:40:55 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b093c318b0so1780980fac.2
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jun 2023 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688143254; x=1690735254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Tj1ZYiVaERSKjW/IT/23m1eJD0+bRKg2fdphDjHUUk=;
        b=DltWyo+v3yGQio7AmpAM7lOt3RI02Kiq1/3mwWOoTelgZ58UmW08H7juaKViL0dC0r
         BuGdb353rnKwp3/EZfxmGZoLaSW3MsUseuYennggRWoAO0i5cky8X9bXweKgshaEajB7
         80uykUDUQ1zNYfrbsZ0eZEjAh2MWrIBk1OXIN4xGLbhjDBoWc3nLp4rytCHIyfFisTs+
         GqmnlKMtWmHM40mWnU2S/KFvZ29yVd9YEDEqJrmFDhrRKTN68VLaU9DK3RwDX09btBY6
         7jiHI5vLzJRGylHsndmC2ru21qNebROOtrR2xVVYhHOM8iBJ06hOUS364mG1cvTRbymC
         JGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143254; x=1690735254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Tj1ZYiVaERSKjW/IT/23m1eJD0+bRKg2fdphDjHUUk=;
        b=BSdcdwZ4SA9tRvP7TfA0+ObVO+NuVBjSQyQM+u+vamqgAMOk7K3t6dyCDy2oSm5WUz
         EsmP3ByMlQU69GT1w3szXrxh/lCMacwe7i0mNCvs+bFov6cmz+q7DjiQraBGHIn/q2bZ
         3jMR/IUnsUjh4ZoF79aAZPUnDnyvHC4Vm90ufKE3GdAAxLpjvL9rVCWRfeK12vrUKoWh
         4WHUFtQMarjtPG0ab8CNMl1Ev+uhXF6f54wVuhd9KslzoXCtToct4DSRnNRHwbx7H03l
         lsp34Ur8E8PfU6YDpx0PsfjN5PhtZqXN7f4yUFEOuSZWI6dXPKCF8uCOrvo6DVgY6LB5
         W9Cg==
X-Gm-Message-State: ABy/qLZEFDyWGJf1GT4K8doTd6L1dm94VHbBFGZEtyMiTxkEMPRj01Fh
        OP/TX64dHmCQFW3Jih5/XBJ9vN1IkLw=
X-Google-Smtp-Source: APBJJlHYp0HRANRvK7WlFDreNH5dYhcYYnDgh/19k67a/72qfiSNfIQeIIywfORWj3aWq20zvY39Gw==
X-Received: by 2002:a05:6871:4584:b0:1b0:4b1e:f394 with SMTP id nl4-20020a056871458400b001b04b1ef394mr3627876oab.11.1688143254496;
        Fri, 30 Jun 2023 09:40:54 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-fa73-c602-0aec-b14e.res6.spectrum.com. [2603:8081:140c:1a00:fa73:c602:aec:b14e])
        by smtp.gmail.com with ESMTPSA id m19-20020a4ae3d3000000b0056520f122eesm3485397oov.44.2023.06.30.09.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:40:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, frank.zago@hpe.com,
        ian.ziemba@hpe.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix freeing busy objects
Date:   Fri, 30 Jun 2023 11:38:28 -0500
Message-Id: <20230630163827.95373-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Currently the rxe driver calls wait_for_completion_timeout() in
rxe_complete() to wait until all the references to the object have
been freed before final cleanup and returning to the rdma-core
destroy verb. If this does not happen within the timeout interval
it prints a WARN_ON and returns to the 'destroy' verb caller
without any indication that there was an error. This is incorrect.

A very heavily loaded system can take an arbitrarily long time to
complete the work needed before freeing all the references with no
guarantees of performance within a specific time. This has been
observed in high stress high scale testing of the rxe driver.

Another frequent cause of these timeouts is due to ref counting bugs
introduced by changes in the driver so it is helpful to continue
to report the timeouts.

This patch puts the completion timeout call in a loop with a 10 second
timeout and issues a WARN_ON each pass through the loop. The case
for objects that cannot sleep is treated similarly. It also changes
the type of the rxe_cleanup() subroutine to void and fixes calls to
reflect this API change. This is better aligned with the code in
rdma-core which sometimes fails to check the return value of
destroy verb calls assuming they will always succeed. Specifically
this is the case for kernel qp's.

Fixes: 215d0a755e1b ("RDMA/rxe: Stop lookup of partially built objects")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  |  39 ++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 108 ++++++++++----------------
 3 files changed, 56 insertions(+), 93 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6215c6de3a84..819dc30a7a96 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,7 +6,7 @@
 
 #include "rxe.h"
 
-#define RXE_POOL_TIMEOUT	(200)
+#define RXE_POOL_TIMEOUT	(10000)	/* 10 seconds */
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -171,15 +171,16 @@ static void rxe_elem_release(struct kref *kref)
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
-	int ret, err = 0;
+	int timeout = RXE_POOL_TIMEOUT;
+	unsigned long until;
+	int ret;
 	void *xa_ret;
 
 	if (sleepable)
@@ -202,39 +203,31 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
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
index b42e26427a70..14facdb45aad 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -70,7 +70,7 @@ int __rxe_get(struct rxe_pool_elem *elem);
 int __rxe_put(struct rxe_pool_elem *elem);
 #define rxe_put(obj) __rxe_put(&(obj)->elem)
 
-int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable);
+void __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable);
 #define rxe_cleanup(obj) __rxe_cleanup(&(obj)->elem, true)
 #define rxe_cleanup_ah(obj, sleepable) __rxe_cleanup(&(obj)->elem, sleepable)
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f4321a172000..a5e639ee2217 100644
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
@@ -265,7 +259,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	struct rxe_dev *rxe = to_rdev(ibah->device);
 	struct rxe_ah *ah = to_rah(ibah);
 	struct rxe_create_ah_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		/* test if new user provider */
@@ -312,9 +306,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(ah);
-	if (cleanup_err)
-		rxe_err_ah(ah, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(ah);
 err_out:
 	rxe_err_ah(ah, "returned err = %d", err);
 	return err;
@@ -354,11 +346,8 @@ static int rxe_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
 static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
-	int err;
 
-	err = rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
-	if (err)
-		rxe_err_ah(ah, "cleanup failed, err = %d", err);
+	rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
 
 	return 0;
 }
@@ -371,12 +360,12 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
 			err = -EINVAL;
-			rxe_err_dev(rxe, "malformed udata");
+			rxe_dbg_dev(rxe, "malformed udata");
 			goto err_out;
 		}
 		uresp = udata->outbuf;
@@ -413,9 +402,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(srq);
-	if (cleanup_err)
-		rxe_err_srq(srq, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(srq);
 err_out:
 	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
@@ -514,11 +501,8 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
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
@@ -531,7 +515,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	struct rxe_pd *pd = to_rpd(ibqp->pd);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_create_qp_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		if (udata->inlen) {
@@ -580,9 +564,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(qp);
-	if (cleanup_err)
-		rxe_err_qp(qp, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(qp);
 err_out:
 	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
@@ -648,9 +630,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	err = rxe_cleanup(qp);
-	if (err)
-		rxe_err_qp(qp, "cleanup failed, err = %d", err);
+	rxe_cleanup(qp);
 
 	return 0;
 
@@ -675,12 +655,12 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	do {
 		mask = wr_opcode_mask(ibwr->opcode, qp);
 		if (!mask) {
-			rxe_err_qp(qp, "bad wr opcode for qp type");
+			rxe_dbg_qp(qp, "bad wr opcode for qp type");
 			break;
 		}
 
 		if (num_sge > sq->max_sge) {
-			rxe_err_qp(qp, "num_sge > max_sge");
+			rxe_dbg_qp(qp, "num_sge > max_sge");
 			break;
 		}
 
@@ -689,27 +669,27 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 			length += ibwr->sg_list[i].length;
 
 		if (length > (1UL << 31)) {
-			rxe_err_qp(qp, "message length too long");
+			rxe_dbg_qp(qp, "message length too long");
 			break;
 		}
 
 		if (mask & WR_ATOMIC_MASK) {
 			if (length != 8) {
-				rxe_err_qp(qp, "atomic length != 8");
+				rxe_dbg_qp(qp, "atomic length != 8");
 				break;
 			}
 			if (atomic_wr(ibwr)->remote_addr & 0x7) {
-				rxe_err_qp(qp, "misaligned atomic address");
+				rxe_dbg_qp(qp, "misaligned atomic address");
 				break;
 			}
 		}
 		if (ibwr->send_flags & IB_SEND_INLINE) {
 			if (!(mask & WR_INLINE_MASK)) {
-				rxe_err_qp(qp, "opcode doesn't support inline data");
+				rxe_dbg_qp(qp, "opcode doesn't support inline data");
 				break;
 			}
 			if (length > sq->max_inline) {
-				rxe_err_qp(qp, "inline length too big");
+				rxe_dbg_qp(qp, "inline length too big");
 				break;
 			}
 		}
@@ -747,7 +727,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 		case IB_WR_SEND:
 			break;
 		default:
-			rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP",
+			rxe_dbg_qp(qp, "bad wr opcode %d for UD/GSI QP",
 					wr->opcode);
 			return -EINVAL;
 		}
@@ -795,7 +775,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 		case IB_WR_ATOMIC_WRITE:
 			break;
 		default:
-			rxe_err_qp(qp, "unsupported wr opcode %d",
+			rxe_dbg_qp(qp, "unsupported wr opcode %d",
 					wr->opcode);
 			return -EINVAL;
 			break;
@@ -871,7 +851,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr)
 
 	full = queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
 	if (unlikely(full)) {
-		rxe_err_qp(qp, "send queue full");
+		rxe_dbg_qp(qp, "send queue full");
 		return -ENOMEM;
 	}
 
@@ -923,14 +903,14 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	/* caller has already called destroy_qp */
 	if (WARN_ON_ONCE(!qp->valid)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		rxe_err_qp(qp, "qp has been destroyed");
+		rxe_dbg_qp(qp, "qp has been destroyed");
 		return -EINVAL;
 	}
 
 	if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
 		*bad_wr = wr;
-		rxe_err_qp(qp, "qp not ready to send");
+		rxe_dbg_qp(qp, "qp not ready to send");
 		return -EINVAL;
 	}
 	spin_unlock_irqrestore(&qp->state_lock, flags);
@@ -997,7 +977,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	return 0;
 
 err_out:
-	rxe_dbg("returned err = %d", err);
+	rxe_err("returned err = %d", err);
 	return err;
 }
 
@@ -1013,7 +993,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	/* caller has already called destroy_qp */
 	if (WARN_ON_ONCE(!qp->valid)) {
 		spin_unlock_irqrestore(&qp->state_lock, flags);
-		rxe_err_qp(qp, "qp has been destroyed");
+		rxe_dbg_qp(qp, "qp has been destroyed");
 		return -EINVAL;
 	}
 
@@ -1061,7 +1041,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct rxe_dev *rxe = to_rdev(dev);
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_create_cq_resp __user *uresp = NULL;
-	int err, cleanup_err;
+	int err;
 
 	if (udata) {
 		if (udata->outlen < sizeof(*uresp)) {
@@ -1100,9 +1080,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	return 0;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(cq);
-	if (cleanup_err)
-		rxe_err_cq(cq, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(cq);
 err_out:
 	rxe_err_dev(rxe, "returned err = %d", err);
 	return err;
@@ -1207,9 +1185,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	err = rxe_cleanup(cq);
-	if (err)
-		rxe_err_cq(cq, "cleanup failed, err = %d", err);
+	rxe_cleanup(cq);
 
 	return 0;
 
@@ -1257,10 +1233,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
-	int err, cleanup_err;
+	int err;
 
 	if (access & ~RXE_ACCESS_SUPPORTED_MR) {
-		rxe_err_pd(pd, "access = %#x not supported (%#x)", access,
+		rxe_dbg_pd(pd, "access = %#x not supported (%#x)", access,
 				RXE_ACCESS_SUPPORTED_MR);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
@@ -1289,9 +1265,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	return &mr->ibmr;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(mr);
-	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(mr);
 err_free:
 	kfree(mr);
 	rxe_err_pd(pd, "returned err = %d", err);
@@ -1311,7 +1285,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 	 * rereg_pd and rereg_access
 	 */
 	if (flags & ~RXE_MR_REREG_SUPPORTED) {
-		rxe_err_mr(mr, "flags = %#x not supported", flags);
+		rxe_dbg_mr(mr, "flags = %#x not supported", flags);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
@@ -1323,7 +1297,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
 
 	if (flags & IB_MR_REREG_ACCESS) {
 		if (access & ~RXE_ACCESS_SUPPORTED_MR) {
-			rxe_err_mr(mr, "access = %#x not supported", access);
+			rxe_dbg_mr(mr, "access = %#x not supported", access);
 			return ERR_PTR(-EOPNOTSUPP);
 		}
 		mr->access = access;
@@ -1338,7 +1312,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_mr *mr;
-	int err, cleanup_err;
+	int err;
 
 	if (mr_type != IB_MR_TYPE_MEM_REG) {
 		err = -EINVAL;
@@ -1369,9 +1343,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err_cleanup:
-	cleanup_err = rxe_cleanup(mr);
-	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", err);
+	rxe_cleanup(mr);
 err_free:
 	kfree(mr);
 err_out:
@@ -1382,7 +1354,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
-	int err, cleanup_err;
+	int err;
 
 	/* See IBA 10.6.7.2.6 */
 	if (atomic_read(&mr->num_mw) > 0) {
@@ -1391,9 +1363,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	cleanup_err = rxe_cleanup(mr);
-	if (cleanup_err)
-		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
+	rxe_cleanup(mr);
 
 	kfree_rcu(mr);
 	return 0;
@@ -1524,7 +1494,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-		rxe_dbg_dev(rxe, "failed with error %d\n", err);
+		rxe_err_dev(rxe, "failed with error %d\n", err);
 
 	/*
 	 * Note that rxe may be invalid at this point if another thread

base-commit: 5f004bcaee4cb552cf1b46a505f18f08777db7e5
-- 
2.39.2

