Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DCF443C4E
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKCFGN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKCFGM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:12 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E59C061714
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:36 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id w23-20020a4a9d17000000b002bb72fd39f3so419776ooj.11
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doPL5wOuXi1kwVGBsKj1wzBKA2RLhrEoIHk1bncKoGs=;
        b=Ct7Dw9iWB4C4ZYh7HaqVKEeEIQoLWvRgy34n+bxLJ663MV/aMLN56qPiLemNdW2FSz
         N1/DwBNp9EbnTOOQ0B4HRikHwv10xJ7Vac5ZFf41B84U6Q0XSdIqqzzbZf3DwfebEygE
         6upsFQedDROejWqGvlSwRr5ya4oNbrbJt/MMbczkxKgFmRuNx+K9xJKDMfL6eiGUf13z
         dXBxsZH7ZF+oB2Ps7Sme+8kPEfO1CdytoJBHAy6HoGzIYwewxvBURY+TNyarK5fP/wu6
         mdt9AuGFVRzE0+06yV8oSP5QxmrnNhL0i+fo7Id/yswAV44CY+OsLxcAzOAvqME6VS1p
         5X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doPL5wOuXi1kwVGBsKj1wzBKA2RLhrEoIHk1bncKoGs=;
        b=PemzwBrZm4IdlTj+QcwhFLZETWK+OOJml64oJ/Ccdr+TYUOJniIa/O3E1pVB17FYf9
         NehtaxYUlbbjTSAG0YMrlX1Y4ibDuiSrLNy1PIgKpRAttUv2LoWdrCO71CAA/1py4HbJ
         56SWAXYMlkgseHTNj0+nMIe9IVNHZx/4tz/QzeYD51Rw5Yfe3wbPwn5d+fwRvLBywkd9
         VlTCl1O7TETMWZm5YxdCAGlTFX9i38GbsfQUyJYItgnCyF5PcEo4sbzHFqu2zzcaJv6Y
         6rqhmx9ZwaZ6Kp6V7fMVlZN/f/Szz6TuJ7BO2IW9lap0sdjckegEa1Ii9eZSA/pAT5Bo
         IOpA==
X-Gm-Message-State: AOAM530EhnAECTzb5zoxx9dEtxHfkQxsXpRLlHKo0Uivw2xHVudkHGOR
        O//puSxGZpzuUwRg3AKU4OM=
X-Google-Smtp-Source: ABdhPJxhiK9NaE6ohQ2akzSGp8P0c5rZlrOAiGQS7aXPnZWjxioUjrluyq7fU0KPwiU9yf32anSRmQ==
X-Received: by 2002:a4a:b645:: with SMTP id f5mr18366604ooo.67.1635915816194;
        Tue, 02 Nov 2021 22:03:36 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 01/13] RDMA/rxe: Replace irqsave locks with bh locks
Date:   Wed,  3 Nov 2021 00:02:30 -0500
Message-Id: <20211103050241.61293-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Most of the locks in the rxe driver are _irqsave/restore locks but
in fact there are no interrupt threads that run rxe code or share data
with rxe. There are softirq threads and data sharing so the appropriate
lock type is _bh. This patch replaces all irqsave type locks with bh
type locks.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  8 +++----
 drivers/infiniband/sw/rxe/rxe_cq.c    | 20 +++++++-----------
 drivers/infiniband/sw/rxe/rxe_mcast.c |  7 +++----
 drivers/infiniband/sw/rxe/rxe_mw.c    | 15 ++++++--------
 drivers/infiniband/sw/rxe/rxe_pool.c  | 30 +++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_queue.c |  9 ++++----
 drivers/infiniband/sw/rxe/rxe_req.c   | 11 ++++------
 drivers/infiniband/sw/rxe/rxe_task.c  | 18 +++++++---------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 27 ++++++++++--------------
 9 files changed, 59 insertions(+), 86 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d771ba8449a1..f363fe3fa414 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -458,8 +458,6 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 					   struct rxe_pkt_info *pkt,
 					   struct rxe_send_wqe *wqe)
 {
-	unsigned long flags;
-
 	if (wqe->has_rd_atomic) {
 		wqe->has_rd_atomic = 0;
 		atomic_inc(&qp->req.rd_atomic);
@@ -472,11 +470,11 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 
 	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
 		/* state_lock used by requester & completer */
-		spin_lock_irqsave(&qp->state_lock, flags);
+		spin_lock_bh(&qp->state_lock);
 		if ((qp->req.state == QP_STATE_DRAIN) &&
 		    (qp->comp.psn == qp->req.psn)) {
 			qp->req.state = QP_STATE_DRAINED;
-			spin_unlock_irqrestore(&qp->state_lock, flags);
+			spin_unlock_bh(&qp->state_lock);
 
 			if (qp->ibqp.event_handler) {
 				struct ib_event ev;
@@ -488,7 +486,7 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 					qp->ibqp.qp_context);
 			}
 		} else {
-			spin_unlock_irqrestore(&qp->state_lock, flags);
+			spin_unlock_bh(&qp->state_lock);
 		}
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 6848426c074f..84bd8669a80f 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -42,14 +42,13 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 static void rxe_send_complete(struct tasklet_struct *t)
 {
 	struct rxe_cq *cq = from_tasklet(cq, t, comp_task);
-	unsigned long flags;
 
-	spin_lock_irqsave(&cq->cq_lock, flags);
+	spin_lock_bh(&cq->cq_lock);
 	if (cq->is_dying) {
-		spin_unlock_irqrestore(&cq->cq_lock, flags);
+		spin_unlock_bh(&cq->cq_lock);
 		return;
 	}
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
+	spin_unlock_bh(&cq->cq_lock);
 
 	cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
 }
@@ -106,15 +105,14 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
 	struct ib_event ev;
-	unsigned long flags;
 	int full;
 	void *addr;
 
-	spin_lock_irqsave(&cq->cq_lock, flags);
+	spin_lock_bh(&cq->cq_lock);
 
 	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	if (unlikely(full)) {
-		spin_unlock_irqrestore(&cq->cq_lock, flags);
+		spin_unlock_bh(&cq->cq_lock);
 		if (cq->ibcq.event_handler) {
 			ev.device = cq->ibcq.device;
 			ev.element.cq = &cq->ibcq;
@@ -130,7 +128,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
+	spin_unlock_bh(&cq->cq_lock);
 
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
 	    (cq->notify == IB_CQ_SOLICITED && solicited)) {
@@ -143,11 +141,9 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 void rxe_cq_disable(struct rxe_cq *cq)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&cq->cq_lock, flags);
+	spin_lock_bh(&cq->cq_lock);
 	cq->is_dying = true;
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
+	spin_unlock_bh(&cq->cq_lock);
 }
 
 void rxe_cq_cleanup(struct rxe_pool_entry *arg)
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 1c1d1b53312d..ba6275fd3edb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -40,12 +40,11 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 	int err;
 	struct rxe_mc_grp *grp;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
-	unsigned long flags;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
 		return -EINVAL;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
+	write_lock_bh(&pool->pool_lock);
 
 	grp = rxe_pool_get_key_locked(pool, mgid);
 	if (grp)
@@ -53,13 +52,13 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	grp = create_grp(rxe, pool, mgid);
 	if (IS_ERR(grp)) {
-		write_unlock_irqrestore(&pool->pool_lock, flags);
+		write_unlock_bh(&pool->pool_lock);
 		err = PTR_ERR(grp);
 		return err;
 	}
 
 done:
-	write_unlock_irqrestore(&pool->pool_lock, flags);
+	write_unlock_bh(&pool->pool_lock);
 	*grp_p = grp;
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 9534a7fe1a98..3cbd38578230 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -56,11 +56,10 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
 	struct rxe_pd *pd = to_rpd(ibmw->pd);
-	unsigned long flags;
 
-	spin_lock_irqsave(&mw->lock, flags);
+	spin_lock_bh(&mw->lock);
 	rxe_do_dealloc_mw(mw);
-	spin_unlock_irqrestore(&mw->lock, flags);
+	spin_unlock_bh(&mw->lock);
 
 	rxe_drop_ref(mw);
 	rxe_drop_ref(pd);
@@ -197,7 +196,6 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 mw_rkey = wqe->wr.wr.mw.mw_rkey;
 	u32 mr_lkey = wqe->wr.wr.mw.mr_lkey;
-	unsigned long flags;
 
 	mw = rxe_pool_get_index(&rxe->mw_pool, mw_rkey >> 8);
 	if (unlikely(!mw)) {
@@ -225,7 +223,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		mr = NULL;
 	}
 
-	spin_lock_irqsave(&mw->lock, flags);
+	spin_lock_bh(&mw->lock);
 
 	ret = rxe_check_bind_mw(qp, wqe, mw, mr);
 	if (ret)
@@ -233,7 +231,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	rxe_do_bind_mw(qp, wqe, mw, mr);
 err_unlock:
-	spin_unlock_irqrestore(&mw->lock, flags);
+	spin_unlock_bh(&mw->lock);
 err_drop_mr:
 	if (mr)
 		rxe_drop_ref(mr);
@@ -280,7 +278,6 @@ static void rxe_do_invalidate_mw(struct rxe_mw *mw)
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	unsigned long flags;
 	struct rxe_mw *mw;
 	int ret;
 
@@ -295,7 +292,7 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 		goto err_drop_ref;
 	}
 
-	spin_lock_irqsave(&mw->lock, flags);
+	spin_lock_bh(&mw->lock);
 
 	ret = rxe_check_invalidate_mw(qp, mw);
 	if (ret)
@@ -303,7 +300,7 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
 
 	rxe_do_invalidate_mw(mw);
 err_unlock:
-	spin_unlock_irqrestore(&mw->lock, flags);
+	spin_unlock_bh(&mw->lock);
 err_drop_ref:
 	rxe_drop_ref(mw);
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 2e80bb6aa957..30178501bb2c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -261,12 +261,11 @@ int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
 int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
 	int err;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
+	write_lock_bh(&pool->pool_lock);
 	err = __rxe_add_key_locked(elem, key);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
+	write_unlock_bh(&pool->pool_lock);
 
 	return err;
 }
@@ -281,11 +280,10 @@ void __rxe_drop_key_locked(struct rxe_pool_entry *elem)
 void __rxe_drop_key(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
+	write_lock_bh(&pool->pool_lock);
 	__rxe_drop_key_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
+	write_unlock_bh(&pool->pool_lock);
 }
 
 int __rxe_add_index_locked(struct rxe_pool_entry *elem)
@@ -302,12 +300,11 @@ int __rxe_add_index_locked(struct rxe_pool_entry *elem)
 int __rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
 	int err;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
+	write_lock_bh(&pool->pool_lock);
 	err = __rxe_add_index_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
+	write_unlock_bh(&pool->pool_lock);
 
 	return err;
 }
@@ -323,11 +320,10 @@ void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
 void __rxe_drop_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
 
-	write_lock_irqsave(&pool->pool_lock, flags);
+	write_lock_bh(&pool->pool_lock);
 	__rxe_drop_index_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
+	write_unlock_bh(&pool->pool_lock);
 }
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
@@ -447,11 +443,10 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	u8 *obj;
-	unsigned long flags;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
+	read_lock_bh(&pool->pool_lock);
 	obj = rxe_pool_get_index_locked(pool, index);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
+	read_unlock_bh(&pool->pool_lock);
 
 	return obj;
 }
@@ -493,11 +488,10 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
 	u8 *obj;
-	unsigned long flags;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
+	read_lock_bh(&pool->pool_lock);
 	obj = rxe_pool_get_key_locked(pool, key);
-	read_unlock_irqrestore(&pool->pool_lock, flags);
+	read_unlock_bh(&pool->pool_lock);
 
 	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 6e6e023c1b45..a1b283dd2d4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -151,7 +151,6 @@ int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
 	struct rxe_queue *new_q;
 	unsigned int num_elem = *num_elem_p;
 	int err;
-	unsigned long flags = 0, flags1;
 
 	new_q = rxe_queue_init(q->rxe, &num_elem, elem_size, q->type);
 	if (!new_q)
@@ -165,17 +164,17 @@ int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
 		goto err1;
 	}
 
-	spin_lock_irqsave(consumer_lock, flags1);
+	spin_lock_bh(consumer_lock);
 
 	if (producer_lock) {
-		spin_lock_irqsave(producer_lock, flags);
+		spin_lock_bh(producer_lock);
 		err = resize_finish(q, new_q, num_elem);
-		spin_unlock_irqrestore(producer_lock, flags);
+		spin_unlock_bh(producer_lock);
 	} else {
 		err = resize_finish(q, new_q, num_elem);
 	}
 
-	spin_unlock_irqrestore(consumer_lock, flags1);
+	spin_unlock_bh(consumer_lock);
 
 	rxe_queue_cleanup(new_q);	/* new/old dep on err */
 	if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0c9d2af15f3d..c8d674da5cc2 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -110,7 +110,6 @@ void rnr_nak_timer(struct timer_list *t)
 static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 {
 	struct rxe_send_wqe *wqe;
-	unsigned long flags;
 	struct rxe_queue *q = qp->sq.queue;
 	unsigned int index = qp->req.wqe_index;
 	unsigned int cons;
@@ -124,25 +123,23 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		/* check to see if we are drained;
 		 * state_lock used by requester and completer
 		 */
-		spin_lock_irqsave(&qp->state_lock, flags);
+		spin_lock_bh(&qp->state_lock);
 		do {
 			if (qp->req.state != QP_STATE_DRAIN) {
 				/* comp just finished */
-				spin_unlock_irqrestore(&qp->state_lock,
-						       flags);
+				spin_unlock_bh(&qp->state_lock);
 				break;
 			}
 
 			if (wqe && ((index != cons) ||
 				(wqe->state != wqe_state_posted))) {
 				/* comp not done yet */
-				spin_unlock_irqrestore(&qp->state_lock,
-						       flags);
+				spin_unlock_bh(&qp->state_lock);
 				break;
 			}
 
 			qp->req.state = QP_STATE_DRAINED;
-			spin_unlock_irqrestore(&qp->state_lock, flags);
+			spin_unlock_bh(&qp->state_lock);
 
 			if (qp->ibqp.event_handler) {
 				struct ib_event ev;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 6951fdcb31bf..0c4db5bb17d7 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -32,25 +32,24 @@ void rxe_do_task(struct tasklet_struct *t)
 {
 	int cont;
 	int ret;
-	unsigned long flags;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
 
-	spin_lock_irqsave(&task->state_lock, flags);
+	spin_lock_bh(&task->state_lock);
 	switch (task->state) {
 	case TASK_STATE_START:
 		task->state = TASK_STATE_BUSY;
-		spin_unlock_irqrestore(&task->state_lock, flags);
+		spin_unlock_bh(&task->state_lock);
 		break;
 
 	case TASK_STATE_BUSY:
 		task->state = TASK_STATE_ARMED;
 		fallthrough;
 	case TASK_STATE_ARMED:
-		spin_unlock_irqrestore(&task->state_lock, flags);
+		spin_unlock_bh(&task->state_lock);
 		return;
 
 	default:
-		spin_unlock_irqrestore(&task->state_lock, flags);
+		spin_unlock_bh(&task->state_lock);
 		pr_warn("%s failed with bad state %d\n", __func__, task->state);
 		return;
 	}
@@ -59,7 +58,7 @@ void rxe_do_task(struct tasklet_struct *t)
 		cont = 0;
 		ret = task->func(task->arg);
 
-		spin_lock_irqsave(&task->state_lock, flags);
+		spin_lock_bh(&task->state_lock);
 		switch (task->state) {
 		case TASK_STATE_BUSY:
 			if (ret)
@@ -81,7 +80,7 @@ void rxe_do_task(struct tasklet_struct *t)
 			pr_warn("%s failed with bad state %d\n", __func__,
 				task->state);
 		}
-		spin_unlock_irqrestore(&task->state_lock, flags);
+		spin_unlock_bh(&task->state_lock);
 	} while (cont);
 
 	task->ret = ret;
@@ -106,7 +105,6 @@ int rxe_init_task(void *obj, struct rxe_task *task,
 
 void rxe_cleanup_task(struct rxe_task *task)
 {
-	unsigned long flags;
 	bool idle;
 
 	/*
@@ -116,9 +114,9 @@ void rxe_cleanup_task(struct rxe_task *task)
 	task->destroyed = true;
 
 	do {
-		spin_lock_irqsave(&task->state_lock, flags);
+		spin_lock_bh(&task->state_lock);
 		idle = (task->state == TASK_STATE_START);
-		spin_unlock_irqrestore(&task->state_lock, flags);
+		spin_unlock_bh(&task->state_lock);
 	} while (!idle);
 
 	tasklet_kill(&task->tasklet);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0aa0d7e52773..dcb7436b9346 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -383,10 +383,9 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 			     const struct ib_recv_wr **bad_wr)
 {
 	int err = 0;
-	unsigned long flags;
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
-	spin_lock_irqsave(&srq->rq.producer_lock, flags);
+	spin_lock_bh(&srq->rq.producer_lock);
 
 	while (wr) {
 		err = post_one_recv(&srq->rq, wr);
@@ -395,7 +394,7 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
 		wr = wr->next;
 	}
 
-	spin_unlock_irqrestore(&srq->rq.producer_lock, flags);
+	spin_unlock_bh(&srq->rq.producer_lock);
 
 	if (err)
 		*bad_wr = wr;
@@ -634,19 +633,18 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	int err;
 	struct rxe_sq *sq = &qp->sq;
 	struct rxe_send_wqe *send_wqe;
-	unsigned long flags;
 	int full;
 
 	err = validate_send_wr(qp, ibwr, mask, length);
 	if (err)
 		return err;
 
-	spin_lock_irqsave(&qp->sq.sq_lock, flags);
+	spin_lock_bh(&qp->sq.sq_lock);
 
 	full = queue_full(sq->queue, QUEUE_TYPE_TO_DRIVER);
 
 	if (unlikely(full)) {
-		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
+		spin_unlock_bh(&qp->sq.sq_lock);
 		return -ENOMEM;
 	}
 
@@ -655,7 +653,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	queue_advance_producer(sq->queue, QUEUE_TYPE_TO_DRIVER);
 
-	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
+	spin_unlock_bh(&qp->sq.sq_lock);
 
 	return 0;
 }
@@ -735,7 +733,6 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	int err = 0;
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_rq *rq = &qp->rq;
-	unsigned long flags;
 
 	if (unlikely((qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
 		*bad_wr = wr;
@@ -749,7 +746,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		goto err1;
 	}
 
-	spin_lock_irqsave(&rq->producer_lock, flags);
+	spin_lock_bh(&rq->producer_lock);
 
 	while (wr) {
 		err = post_one_recv(rq, wr);
@@ -760,7 +757,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 		wr = wr->next;
 	}
 
-	spin_unlock_irqrestore(&rq->producer_lock, flags);
+	spin_unlock_bh(&rq->producer_lock);
 
 	if (qp->resp.state == QP_STATE_ERROR)
 		rxe_run_task(&qp->resp.task, 1);
@@ -841,9 +838,8 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 	int i;
 	struct rxe_cq *cq = to_rcq(ibcq);
 	struct rxe_cqe *cqe;
-	unsigned long flags;
 
-	spin_lock_irqsave(&cq->cq_lock, flags);
+	spin_lock_bh(&cq->cq_lock);
 	for (i = 0; i < num_entries; i++) {
 		cqe = queue_head(cq->queue, QUEUE_TYPE_FROM_DRIVER);
 		if (!cqe)
@@ -852,7 +848,7 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
 		queue_advance_consumer(cq->queue, QUEUE_TYPE_FROM_DRIVER);
 	}
-	spin_unlock_irqrestore(&cq->cq_lock, flags);
+	spin_unlock_bh(&cq->cq_lock);
 
 	return i;
 }
@@ -870,11 +866,10 @@ static int rxe_peek_cq(struct ib_cq *ibcq, int wc_cnt)
 static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
-	unsigned long irq_flags;
 	int ret = 0;
 	int empty;
 
-	spin_lock_irqsave(&cq->cq_lock, irq_flags);
+	spin_lock_bh(&cq->cq_lock);
 	if (cq->notify != IB_CQ_NEXT_COMP)
 		cq->notify = flags & IB_CQ_SOLICITED_MASK;
 
@@ -883,7 +878,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
 		ret = 1;
 
-	spin_unlock_irqrestore(&cq->cq_lock, irq_flags);
+	spin_unlock_bh(&cq->cq_lock);
 
 	return ret;
 }
-- 
2.30.2

