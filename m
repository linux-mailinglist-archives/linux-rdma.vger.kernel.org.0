Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546793D692B
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 00:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhGZVUR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhGZVUR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 17:20:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38BC061757
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jul 2021 15:00:44 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 48-20020a9d0bb30000b02904cd671b911bso11512716oth.1
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jul 2021 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEPGroAaO58UNcvq57uMS6I9hgB+q5+dcj1EP3HTnTU=;
        b=OD2T4umybLIVP9HGsbVY+iPMAAJqdKDHmVWZWElCksO2M2amaMlaQ/Gq6JiS7wnTJg
         UM6VHRPT5AZ7XNBEkFPdpsy1bcSuTaCwFbYlshb/GQCK/ltpxNCBwIFmNxlaA1bFL8kw
         fpACZA1nSjQSb3MeFYni4ukzbQ0c+MCL7KY/N3ARbOMyO25FyOVHvouApb8DBqbkY5Te
         z0cXNY/S8LsGGKAvVf4KAc3Cn+Fh6NO9XYNQIUpagl89DbHzMqKjxUUgBK20ctXX4stS
         QdP3t6PkhGBP7pTplqCT+Hfd3UCYYQWVMOvxTJjoSzjsCaKy4aYQUGGTBZrjSzWfTgmz
         jO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kEPGroAaO58UNcvq57uMS6I9hgB+q5+dcj1EP3HTnTU=;
        b=jJjU0STunmpwhRomKiMqmlYOSRkTXQdGVRr9tXQp194ct15kUgMWB2zTFuCwrom0Ub
         xy3Q6Dgm85yS3QHYhMXitRCx/K90IJqTxgbTXfjoOVUd9SpEfuPes8RP4c/Vw8LVjHhR
         CGGG0+u/QPNzaPWReuWzOjzvErihyCW1cVJTWXCZiYh9bt9Q2bElfyQxvSpbW0xJXHGd
         1xy9/uvCno/DeomRyYe1VR4JYbij3M86DNj2Rs898Pna9zpisI727YY8eZFokhPxDyCX
         Zrw/axvv5VKUpNLSuIaodAY/802eeH13f10dXeYkctIJQ+8ix8lpVBikrFkxWSYk1LFB
         yL8A==
X-Gm-Message-State: AOAM531DSmIJX0AzmMiv8ZsyXqDptT3hA+HcKbZ48pMu9Kz3SlObXbOs
        zXJ4gjSlvSxZTaYu/rYX8hs=
X-Google-Smtp-Source: ABdhPJyfYPgH5qoB5hEqlO5/rq+yypsGQHRFFOkEsgF0OmeoSCLQPzvg5Tj2giXbci9fODVY/x5r0Q==
X-Received: by 2002:a05:6830:2b23:: with SMTP id l35mr5850176otv.21.1627336844032;
        Mon, 26 Jul 2021 15:00:44 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-f80f-33e2-d912-0c74.res6.spectrum.com. [2603:8081:140c:1a00:f80f:33e2:d912:c74])
        by smtp.gmail.com with ESMTPSA id x3sm214169otr.69.2021.07.26.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:00:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Let rdma-core manage PDs
Date:   Mon, 26 Jul 2021 16:58:16 -0500
Message-Id: <20210726215815.17056-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
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
 drivers/infiniband/sw/rxe/rxe_comp.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  4 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +++----
 drivers/infiniband/sw/rxe/rxe_mw.c    | 31 +++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_qp.c    |  9 +-------
 drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 26 ++++++----------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 24 +++++++++++++++------
 9 files changed, 48 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2d802c776fd..92fca06838b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -347,7 +347,7 @@ static inline enum comp_state do_read(struct rxe_qp *qp,
 {
 	int ret;
 
-	ret = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE,
+	ret = copy_data(rxe_qp_pd(qp), IB_ACCESS_LOCAL_WRITE,
 			&wqe->dma, payload_addr(pkt),
 			payload_size(pkt), RXE_TO_MR_OBJ);
 	if (ret) {
@@ -369,7 +369,7 @@ static inline enum comp_state do_atomic(struct rxe_qp *qp,
 
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
index 1ee5bd8291e5..42d8a268bb5a 100644
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
@@ -558,7 +558,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	mr->state = RXE_MR_STATE_ZOMBIE;
-	rxe_drop_ref(mr_pd(mr));
+	rxe_drop_ref(rxe_mr_pd(mr));
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
index 1ab6af7ddb25..5f3dda69e5b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -328,10 +328,9 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
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
@@ -339,13 +338,11 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
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
@@ -368,7 +365,6 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 err2:
 	rxe_queue_cleanup(qp->sq.queue);
 err1:
-	qp->pd = NULL;
 	qp->rcq = NULL;
 	qp->scq = NULL;
 	qp->srq = NULL;
@@ -377,7 +373,6 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 		rxe_drop_ref(srq);
 	rxe_drop_ref(scq);
 	rxe_drop_ref(rcq);
-	rxe_drop_ref(pd);
 
 	return err;
 }
@@ -821,8 +816,6 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		rxe_drop_ref(qp->scq);
 	if (qp->rcq)
 		rxe_drop_ref(qp->rcq);
-	if (qp->pd)
-		rxe_drop_ref(qp->pd);
 
 	if (qp->resp.mr) {
 		rxe_drop_ref(qp->resp.mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3894197a82f6..cc5c0406b055 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -481,7 +481,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			wqe->dma.resid -= paylen;
 			wqe->dma.sge_offset += paylen;
 		} else {
-			err = copy_data(qp->pd, 0, &wqe->dma,
+			err = copy_data(rxe_qp_pd(qp), 0, &wqe->dma,
 					payload_addr(pkt), paylen,
 					RXE_FROM_MR_OBJ);
 			if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 685b8aebd627..59351919b3c0 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -482,7 +482,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		rxe_drop_ref(mw);
 		rxe_add_ref(mr);
 	} else {
-		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
+		mr = lookup_mr(rxe_qp_pd(qp), access, rkey, RXE_LOOKUP_REMOTE);
 		if (!mr) {
 			pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
 			state = RESPST_ERR_RKEY_VIOLATION;
@@ -535,7 +535,7 @@ static enum resp_states send_data_in(struct rxe_qp *qp, void *data_addr,
 {
 	int err;
 
-	err = copy_data(qp->pd, IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
+	err = copy_data(rxe_qp_pd(qp), IB_ACCESS_LOCAL_WRITE, &qp->resp.wqe->dma,
 			data_addr, data_len, RXE_TO_MR_OBJ);
 	if (unlikely(err))
 		return (err == -ENOSPC) ? RESPST_ERR_LENGTH
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f7b1a1f64c13..f348e94ad030 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -270,7 +270,6 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibsrq->device);
-	struct rxe_pd *pd = to_rpd(ibsrq->pd);
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 	struct rxe_create_srq_resp __user *uresp = NULL;
 
@@ -288,25 +287,21 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
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
 
@@ -362,7 +357,6 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
 
-	rxe_drop_ref(srq->pd);
 	rxe_drop_ref(srq);
 	return 0;
 }
@@ -397,7 +391,6 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
-	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_qp *qp;
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
@@ -432,7 +425,7 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 
 	rxe_add_index(qp);
 
-	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibpd, udata);
+	err = rxe_qp_from_init(rxe, qp, init, uresp, udata);
 	if (err)
 		goto err3;
 
@@ -918,7 +911,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 		return ERR_PTR(-ENOMEM);
 
 	rxe_add_index(mr);
-	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
 	return &mr->ibmr;
@@ -943,8 +935,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_index(mr);
 
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
 		goto err3;
@@ -952,7 +942,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
-	rxe_drop_ref(pd);
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
@@ -978,8 +967,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 	rxe_add_index(mr);
 
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
 		goto err2;
@@ -987,7 +974,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_drop_ref(pd);
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 959a3260fcab..176b9f6dff6e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -46,7 +46,6 @@ struct rxe_pd {
 struct rxe_ah {
 	struct ib_ah		ibah;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_av		av;
 };
 
@@ -97,7 +96,6 @@ struct rxe_rq {
 struct rxe_srq {
 	struct ib_srq		ibsrq;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_rq		rq;
 	u32			srq_num;
 	bool			is_user;
@@ -217,7 +215,6 @@ struct rxe_qp {
 	unsigned int		mtu;
 	bool			is_user;
 
-	struct rxe_pd		*pd;
 	struct rxe_srq		*srq;
 	struct rxe_cq		*scq;
 	struct rxe_cq		*rcq;
@@ -469,17 +466,22 @@ static inline struct rxe_mw *to_rmw(struct ib_mw *mw)
 	return mw ? container_of(mw, struct rxe_mw, ibmw) : NULL;
 }
 
-static inline struct rxe_pd *mr_pd(struct rxe_mr *mr)
+static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
+{
+	return to_rpd(ah->ibah.pd);
+}
+
+static inline struct rxe_pd *rxe_mr_pd(struct rxe_mr *mr)
 {
 	return to_rpd(mr->ibmr.pd);
 }
 
-static inline u32 mr_lkey(struct rxe_mr *mr)
+static inline u32 rxe_mr_lkey(struct rxe_mr *mr)
 {
 	return mr->ibmr.lkey;
 }
 
-static inline u32 mr_rkey(struct rxe_mr *mr)
+static inline u32 rxe_mr_rkey(struct rxe_mr *mr)
 {
 	return mr->ibmr.rkey;
 }
@@ -494,6 +496,16 @@ static inline u32 rxe_mw_rkey(struct rxe_mw *mw)
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

