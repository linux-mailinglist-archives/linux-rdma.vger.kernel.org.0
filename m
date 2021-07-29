Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5513DAEE4
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhG2Way (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhG2Way (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:30:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67A8C0613C1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:30:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id y18so10499747oiv.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFwDpA1rWeu46+ZSonfzOtXEDNtKkZgdP4hkzldZ6yI=;
        b=LNlCx9Ida3NA5Kcntw6D48hRzpt06FMkyKvKMF035LLBrfKeGyh1v3yr6sLO8amzjX
         JzS31kJkRh3rU2pC65gzKkaupeLlO5KtADbOEc9x5LPidaMz3N2cMc10CvriZmStzoWQ
         998lSVuEel3zefjHrKZwovSWj73km2437Rgmw1hcLC4S6Sn/k9RcY2+SoxJw0m3KwAFy
         wtoRX6mUU4tgocQHMsfzGG++Vx5Un4Tp9zMia2AdIt0ugFfdyVe5bgUb4S8vle0uKFZz
         +RySNq7jYrz7Xrx/GYlKi/TboG9pqO6bJl3zJf+eqaXAdgaHwTmKmNH8hi6B7OEBhtsu
         xntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFwDpA1rWeu46+ZSonfzOtXEDNtKkZgdP4hkzldZ6yI=;
        b=Sd0IhAILLpqyn+Zb/2/6SEVbGa6pwDc5kvOZ/6DOa2EMUGSNKnBYwD/Jup1eb5Lm0X
         XUdhsid/avo9OIgDk/hrxnnniDrHvjhA8CIDO4vIQP/z1YGIvi0FQ11Wz3uRlquKpo11
         Ph1I/BkzS04YDy+afyAEiUVhd9QYbTUYOeB6ei5PqBRbztkduAt6zObMShtDtB2L96cR
         EA89HxEEI00tn6OZMFbx68o3TivXtZfspuTqpKajXrXhCgXX9lRwPcJ8kIBrkL4xwaWg
         F/TgIgEEh2DWFXWrrzxsZ0xeVbC9RygNgS+nj0Wl65m5/PfP8XpmbtYfDBIO8wCtxHB5
         RThw==
X-Gm-Message-State: AOAM532gEixtbrqC3elc+46/UwBlrnl9Et3gpv0+IakcmfQPkPEGorfy
        ztMA9QzfvEuXP9t0CdDg6nE=
X-Google-Smtp-Source: ABdhPJwif6Vs7Ny+yBu+LJgyoe4whbbWH2xfaVHLI7cD73ph4+K/c8hFdWJl7+Iv3WifqWBzGjFNZA==
X-Received: by 2002:aca:2403:: with SMTP id n3mr2973178oic.109.1627597849035;
        Thu, 29 Jul 2021 15:30:49 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id t4sm820386oiw.19.2021.07.29.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:30:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/2] RDMA/rxe: Let rdma-core manage PDs
Date:   Thu, 29 Jul 2021 17:30:10 -0500
Message-Id: <20210729223010.31007-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729223010.31007-1-rpearsonhpe@gmail.com>
References: <20210729223010.31007-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently several rxe objects hold references to PDs which are ref-
counted. This replicates work already done by RDMA core which takes
references to PDs in the ib objects which are contained in the rxe
objects. This patch removes struct rxe_pd from rxe objects and removes
reference counting for PDs except for PD alloc and PD dealloc. It also
adds inline extractor routines which return PDs from the PDs in the
ib objects. The names of these are made consistent including a rxe_
prefix.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c    |  3 ++-
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  7 +++---
 drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
 drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 28 +++++++++++++++---------
 10 files changed, 49 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 38c7b6fb39d7..0bbaff74476b 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -117,7 +117,8 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (ah_num) {
 		/* only new user provider or kernel client */
 		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
-		if (!ah || ah->ah_num != ah_num || rxe_ah_pd(ah) != pkt->qp->pd) {
+		if (!ah || ah->ah_num != ah_num ||
+		    rxe_ah_pd(ah) != rxe_qp_pd(pkt->qp)) {
 			pr_warn("Unable to find AH matching ah_num\n");
 			return NULL;
 		}
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ed4e3f29bd65..b0294f8df94f 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -344,7 +344,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 {
 	int ret;
 
-	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
+	ret = copy_data(rxe_qp_pd(qp), IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
 			payload_size(pkt), RXE_TO_MR_OBJ);
 	if (ret) {
@@ -366,7 +366,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
 	u64 atomic_orig = atmack_orig(pkt);
 
-	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
+	ret = copy_data(rxe_qp_pd(qp), IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, &atomic_orig,
 			sizeof(u64), RXE_TO_MR_OBJ);
 	if (ret) {
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index f0c954575bde..000607f4e40c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -110,10 +110,10 @@ int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
 
-int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
+int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 		     struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
-		     struct ib_pd *ibpd, struct ib_udata *udata);
+		     struct ib_udata *udata);
 
 int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 1ee5bd8291e5..14bfd729b09f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -500,9 +500,9 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	if (!mr)
 		return NULL;
 
-	if (unlikely((type == RXE_LOOKUP_LOCAL && mr_lkey(mr) != key) ||
-		     (type == RXE_LOOKUP_REMOTE && mr_rkey(mr) != key) ||
-		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
+	if (unlikely((type == RXE_LOOKUP_LOCAL && rxe_mr_lkey(mr) != key) ||
+		     (type == RXE_LOOKUP_REMOTE && rxe_mr_rkey(mr) != key) ||
+		     rxe_mr_pd(mr) != pd || (access && !(access & mr->access)) ||
 		     mr->state != RXE_MR_STATE_VALID)) {
 		rxe_drop_ref(mr);
 		mr = NULL;
@@ -558,7 +558,6 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	mr->state = RXE_MR_STATE_ZOMBIE;
-	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 5ba77df7598e..17936a0b8320 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -8,17 +8,12 @@
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
-	struct rxe_pd *pd = to_rpd(ibmw->pd);
 	struct rxe_dev *rxe = to_rdev(ibmw->device);
 	int ret;
 
-	rxe_add_ref(pd);
-
 	ret = rxe_add_to_pool(&rxe->mw_pool, mw);
-	if (ret) {
-		rxe_drop_ref(pd);
+	if (ret)
 		return ret;
-	}
 
 	rxe_add_index(mw);
 	ibmw->rkey = (mw->pelem.index << 8) | rxe_get_next_key(-1);
@@ -55,7 +50,6 @@ static void rxe_do_dealloc_mw(struct rxe_mw *mw)
 int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
-	struct rxe_pd *pd = to_rpd(ibmw->pd);
 	unsigned long flags;
 
 	spin_lock_irqsave(&mw->lock, flags);
@@ -63,7 +57,6 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	spin_unlock_irqrestore(&mw->lock, flags);
 
 	rxe_drop_ref(mw);
-	rxe_drop_ref(pd);
 
 	return 0;
 }
@@ -94,7 +87,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 
 		/* C10-72 */
-		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
+		if (unlikely(rxe_qp_pd(qp) != rxe_mw_pd(mw))) {
 			pr_err_once(
 				"attempt to bind type 2 MW with qp with different PD\n");
 			return -EINVAL;
@@ -108,7 +101,7 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		}
 	}
 
-	if (unlikely((wqe->wr.wr.mw.rkey & 0xff) == (mw->ibmw.rkey & 0xff))) {
+	if (unlikely((wqe->wr.wr.mw.rkey & 0xff) == (rxe_mw_rkey(mw) & 0xff))) {
 		pr_err_once("attempt to bind MW with same key\n");
 		return -EINVAL;
 	}
@@ -164,7 +157,7 @@ static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	u32 rkey;
 	u32 new_rkey;
 
-	rkey = mw->ibmw.rkey;
+	rkey = rxe_mw_rkey(mw);
 	new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.mw.rkey & 0x000000ff);
 
 	mw->ibmw.rkey = new_rkey;
@@ -206,7 +199,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		goto err;
 	}
 
-	if (unlikely(mw->ibmw.rkey != wqe->wr.wr.mw.mw_rkey)) {
+	if (unlikely(rxe_mw_rkey(mw) != wqe->wr.wr.mw.mw_rkey)) {
 		ret = -EINVAL;
 		goto err_drop_mw;
 	}
@@ -219,7 +212,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 			goto err_drop_mw;
 		}
 
-		if (unlikely(mr->ibmr.lkey != wqe->wr.wr.mw.mr_lkey)) {
+		if (unlikely(rxe_mr_lkey(mr) != wqe->wr.wr.mw.mr_lkey)) {
 			ret = -EINVAL;
 			goto err_drop_mr;
 		}
@@ -289,12 +282,12 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
 	if (!mw) {
 		ret = -EINVAL;
-		goto err;
+		goto err_out;
 	}
 
-	if (rkey != mw->ibmw.rkey) {
+	if (rkey != rxe_mw_rkey(mw)) {
 		ret = -EINVAL;
-		goto err_drop_ref;
+		goto err_drop_mw_ref;
 	}
 
 	spin_lock_irqsave(&mw->lock, flags);
@@ -306,16 +299,16 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 	rxe_do_invalidate_mw(mw);
 err_unlock:
 	spin_unlock_irqrestore(&mw->lock, flags);
-err_drop_ref:
+err_drop_mw_ref:
 	rxe_drop_ref(mw);
-err:
+err_out:
 	return ret;
 }
 
 struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
+	struct rxe_pd *pd = rxe_qp_pd(qp);
 	struct rxe_mw *mw;
 	int index = rkey >> 8;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 2e923af642f8..ca8d7da74969 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -324,10 +324,9 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 }
 
 /* called by the create qp verb */
-int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
+int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 		     struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
-		     struct ib_pd *ibpd,
 		     struct ib_udata *udata)
 {
 	int err;
@@ -335,13 +334,11 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	struct rxe_cq *scq = to_rcq(init->send_cq);
 	struct rxe_srq *srq = init->srq ? to_rsrq(init->srq) : NULL;
 
-	rxe_add_ref(pd);
 	rxe_add_ref(rcq);
 	rxe_add_ref(scq);
 	if (srq)
 		rxe_add_ref(srq);
 
-	qp->pd			= pd;
 	qp->rcq			= rcq;
 	qp->scq			= scq;
 	qp->srq			= srq;
@@ -364,7 +361,6 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 err2:
 	rxe_queue_cleanup(qp->sq.queue);
 err1:
-	qp->pd = NULL;
 	qp->rcq = NULL;
 	qp->scq = NULL;
 	qp->srq = NULL;
@@ -373,7 +369,6 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 		rxe_drop_ref(srq);
 	rxe_drop_ref(scq);
 	rxe_drop_ref(rcq);
-	rxe_drop_ref(pd);
 
 	return err;
 }
@@ -817,8 +812,6 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		rxe_drop_ref(qp->scq);
 	if (qp->rcq)
 		rxe_drop_ref(qp->rcq);
-	if (qp->pd)
-		rxe_drop_ref(qp->pd);
 
 	if (qp->resp.mr) {
 		rxe_drop_ref(qp->resp.mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3118e444ebfc..70a238085abb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -472,7 +472,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			wqe->dma.resid -= paylen;
 			wqe->dma.sge_offset += paylen;
 		} else {
-			err = copy_data(qp->pd, 0, &wqe->dma,
+			err = copy_data(rxe_qp_pd(qp), 0, &wqe->dma,
 					payload_addr(pkt), paylen,
 					RXE_FROM_MR_OBJ);
 			if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 76bc070edea4..29b56d52e2c7 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -466,7 +466,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		rxe_drop_ref(mw);
 		rxe_add_ref(mr);
 	} else {
-		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
+		mr = lookup_mr(rxe_qp_pd(qp), access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
 			pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
@@ -519,7 +519,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 {
 	int err;
 
-	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
+	err = copy_data(rxe_qp_pd(qp), IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
 			data_addr, data_len, RXE_TO_MR_OBJ);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 23b2fd43e0ce..bdd350e02d42 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -288,7 +288,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
-	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
 
@@ -306,25 +305,21 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
 	if (err)
-		goto err1;
+		goto err_out;
 
 	err = rxe_add_to_pool(&rxe->srq_pool, srq);
 	if (err)
-		goto err1;
-
-	rxe_add_ref(pd);
-	srq->pd = pd;
+		goto err_out;
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
-		goto err2;
+		goto err_drop_srq_ref;
 
 	return 0;
 
-err2:
-	rxe_drop_ref(pd);
+err_drop_srq_ref:
 	rxe_drop_ref(srq);
-err1:
+err_out:
 	return err;
 }
 
@@ -380,7 +375,6 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
-	rxe_drop_ref(srq->pd);
 	rxe_drop_ref(srq);
 	return 0;
 }
@@ -415,7 +409,6 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
-	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_qp *qp;
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
@@ -450,7 +443,7 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 
 	rxe_add_index(qp);
 
-	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibpd, udata);
+	err = rxe_qp_from_init(rxe, qp, init, uresp, udata);
 	if (err)
 		goto err3;
 
@@ -912,7 +905,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 		return ERR_PTR(-ENOMEM);
 
 	rxe_add_index(mr);
-	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
@@ -937,8 +929,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_index(mr);
 
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
 		goto err3;
@@ -946,7 +936,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
-	rxe_drop_ref(pd);
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
@@ -972,8 +961,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	rxe_add_index(mr);
 
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
 		goto err2;
@@ -981,7 +968,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6e48dcd21c5f..6b2dcbfcd404 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -98,7 +98,6 @@ struct rxe_rq {
 struct rxe_srq {
 	struct ib_srq		ibsrq;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_rq		rq;
 	u32			srq_num;
 	bool			is_user;
@@ -218,7 +217,6 @@ struct rxe_qp {
 	unsigned int		mtu;
 	bool			is_user;
 
-	struct rxe_pd		*pd;
 	struct rxe_srq		*srq;
 	struct rxe_cq		*scq;
 	struct rxe_cq		*rcq;
@@ -470,24 +468,24 @@ static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
-static inline struct rxe_pd *mr_pd(struct rxe_mr *mr)
+static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
 {
-	return to_rpd(mr->ibmr.pd);
+	return to_rpd(ah->ibah.pd);
 }
 
-static inline u32 mr_lkey(struct rxe_mr *mr)
+static inline struct rxe_pd *rxe_mr_pd(struct rxe_mr *mr)
 {
-	return mr->ibmr.lkey;
+	return to_rpd(mr->ibmr.pd);
 }
 
-static inline u32 mr_rkey(struct rxe_mr *mr)
+static inline u32 rxe_mr_lkey(struct rxe_mr *mr)
 {
-	return mr->ibmr.rkey;
+	return mr->ibmr.lkey;
 }
 
-static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
+static inline u32 rxe_mr_rkey(struct rxe_mr *mr)
 {
-	return to_rpd(ah->ibah.pd);
+	return mr->ibmr.rkey;
 }
 
 static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
@@ -500,6 +498,16 @@ static inline u32 rxe_mw_rkey(struct rxe_mw *mw)
 	return mw->ibmw.rkey;
 }
 
+static inline struct rxe_pd *rxe_qp_pd(struct rxe_qp *qp)
+{
+	return to_rpd(qp->ibqp.pd);
+}
+
+static inline struct rxe_pd *rxe_srq_pd(struct rxe_srq *srq)
+{
+	return to_rpd(srq->ibsrq.pd);
+}
+
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
 void rxe_mc_cleanup(struct rxe_pool_entry *arg);
-- 
2.30.2

