Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2719F4033CD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 07:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhIHFau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 01:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbhIHFaq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 01:30:46 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAFDC0613D9
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 22:29:39 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s20so1663283oiw.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 22:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW2xj3CbkupNbboVaqs0ID/AwXh7OZxgt0XcZ/wXyZg=;
        b=Ohzrxmq5D7uKhggNuxSfDQlmEmygpmiUzqaJBksYd4ytVlK87zRGmxkQZL05mXmCU1
         k1FU9LYZ2S0T/9oghU7yohR9J1cS6SrKs6uIlw9DCMtg2ThkQhIY0ohESzxoceBDAIPs
         1eVq2sjAKPKIHhVY1dYpCUuycmzx4l1FNWdfFEh93gzS2Nc4xpqlCY//pyWDOcCcxg2Y
         nDjiCagiwGIGdG749hXYb1MxwOtAvhGfij1ezGCp2qr5ZV+9y+5N+LyCXvYPrJ9T888y
         EVbUTKSay3AEPDAI5lpciAbSK55Wvd/ubY5T660w4ezNvNAIr3mO4s58rIPT3t30do9d
         8YAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW2xj3CbkupNbboVaqs0ID/AwXh7OZxgt0XcZ/wXyZg=;
        b=GeLXPmTFg2ql+zDV1EmzkFPhqspEn5b3mG+6mgfKyC4gDQYK8waegIO/GTfkLXlcd6
         /qWJAEUsHDiV+TG5ye8EFc+9eRedgqQ4n+FVxpl9F+SXC2aSqGtHTcuojoQEvzX8SO3H
         JU8Kev8vLWuWvzzmsr1Xj0+yx9PEB/Q8PXB/ORuywhuE/AAYKxyMIFT4ibYIlW6jwe5W
         SuTh5wp2yyOHiII8JKc2mcd9TEkYVJGU+vSuWT1BFpc4awihcV8U+DsuiZu0N3lWR/B/
         cHgv3Q3O3aMefWDVLpj3QZcBKWN9pAKpgVv1efDdCQxzOtqq5Pz0kJXb2vE5VFeWyJyk
         0PGA==
X-Gm-Message-State: AOAM53340ib96GAsmkfbtmtCDxlpt6i5pZJJFiNO9eTewLoVJYpioiCt
        mYaMe3zYj11puBp557G17aE=
X-Google-Smtp-Source: ABdhPJzbLlfQ1DVRRc9uHnhZatLDEZQAbnefyQz9izEHZ81FFOoqxjnK9/RdiH4c8AumN0XNg3E2jw==
X-Received: by 2002:a05:6808:618:: with SMTP id y24mr1165472oih.179.1631078978411;
        Tue, 07 Sep 2021 22:29:38 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-4049-a9c6-d3dc-35fa.res6.spectrum.com. [2603:8081:140c:1a00:4049:a9c6:d3dc:35fa])
        by smtp.gmail.com with ESMTPSA id bf6sm281183oib.0.2021.09.07.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 22:29:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/5] RDMA/rxe: Add memory barriers to kernel queues
Date:   Wed,  8 Sep 2021 00:29:24 -0500
Message-Id: <20210908052928.17375-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908052928.17375-1-rpearsonhpe@gmail.com>
References: <20210908052928.17375-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Earlier patches added memory barriers to protect user space to kernel
space communications. This patch extends that to the case where queues
are used between kernel space threads.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Rebase on version 5.14.

 drivers/infiniband/sw/rxe/rxe_comp.c  | 10 +---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 25 ++-------
 drivers/infiniband/sw/rxe/rxe_qp.c    | 10 ++--
 drivers/infiniband/sw/rxe/rxe_queue.h | 73 ++++++++-------------------
 drivers/infiniband/sw/rxe/rxe_req.c   | 21 ++------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 38 ++++----------
 drivers/infiniband/sw/rxe/rxe_srq.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 53 ++++---------------
 8 files changed, 55 insertions(+), 177 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2d802c776fd..ed4e3f29bd65 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -142,10 +142,7 @@ static inline enum comp_state get_wqe(struct rxe_qp *qp,
 	/* we come here whether or not we found a response packet to see if
 	 * there are any posted WQEs
 	 */
-	if (qp->is_user)
-		wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_USER);
-	else
-		wqe = queue_head(qp->sq.queue, QUEUE_TYPE_KERNEL);
+	wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 	*wqe_p = wqe;
 
 	/* no WQE or requester has not started it yet */
@@ -432,10 +429,7 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 	if (post)
 		make_send_cqe(qp, wqe, &cqe);
 
-	if (qp->is_user)
-		advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_USER);
-	else
-		advance_consumer(qp->sq.queue, QUEUE_TYPE_KERNEL);
+	advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (post)
 		rxe_cq_post(qp->scq, &cqe, 0);
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index aef288f164fd..4e26c2ea4a59 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -25,11 +25,7 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	}
 
 	if (cq) {
-		if (cq->is_user)
-			count = queue_count(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			count = queue_count(cq->queue, QUEUE_TYPE_KERNEL);
-
+		count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
 		if (cqe < count) {
 			pr_warn("cqe(%d) < current # elements in queue (%d)",
 				cqe, count);
@@ -65,7 +61,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	int err;
 	enum queue_type type;
 
-	type = uresp ? QUEUE_TYPE_TO_USER : QUEUE_TYPE_KERNEL;
+	type = QUEUE_TYPE_TO_CLIENT;
 	cq->queue = rxe_queue_init(rxe, &cqe,
 			sizeof(struct rxe_cqe), type);
 	if (!cq->queue) {
@@ -117,11 +113,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
-	if (cq->is_user)
-		full = queue_full(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		full = queue_full(cq->queue, QUEUE_TYPE_KERNEL);
-
+	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	if (unlikely(full)) {
 		spin_unlock_irqrestore(&cq->cq_lock, flags);
 		if (cq->ibcq.event_handler) {
@@ -134,17 +126,10 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 		return -EBUSY;
 	}
 
-	if (cq->is_user)
-		addr = producer_addr(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		addr = producer_addr(cq->queue, QUEUE_TYPE_KERNEL);
-
+	addr = producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	memcpy(addr, cqe, sizeof(*cqe));
 
-	if (cq->is_user)
-		advance_producer(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		advance_producer(cq->queue, QUEUE_TYPE_KERNEL);
+	advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 1ab6af7ddb25..2e923af642f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -231,7 +231,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
 	wqe_size += sizeof(struct rxe_send_wqe);
 
-	type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
+	type = QUEUE_TYPE_FROM_CLIENT;
 	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
 				wqe_size, type);
 	if (!qp->sq.queue)
@@ -248,12 +248,8 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 		return err;
 	}
 
-	if (qp->is_user)
 		qp->req.wqe_index = producer_index(qp->sq.queue,
-						QUEUE_TYPE_FROM_USER);
-	else
-		qp->req.wqe_index = producer_index(qp->sq.queue,
-						QUEUE_TYPE_KERNEL);
+					QUEUE_TYPE_FROM_CLIENT);
 
 	qp->req.state		= QP_STATE_RESET;
 	qp->req.opcode		= -1;
@@ -293,7 +289,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
 			 qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
 
-		type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
+		type = QUEUE_TYPE_FROM_CLIENT;
 		qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
 					wqe_size, type);
 		if (!qp->rq.queue)
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 2702b0e55fc3..d465aa9342e1 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -35,9 +35,8 @@
 
 /* type of queue */
 enum queue_type {
-	QUEUE_TYPE_KERNEL,
-	QUEUE_TYPE_TO_USER,
-	QUEUE_TYPE_FROM_USER,
+	QUEUE_TYPE_TO_CLIENT,
+	QUEUE_TYPE_FROM_CLIENT,
 };
 
 struct rxe_queue {
@@ -87,20 +86,16 @@ static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		cons = q->buf->consumer_index;
-		break;
 	}
 
 	return ((prod - cons) & q->index_mask) == 0;
@@ -112,20 +107,16 @@ static inline int queue_full(struct rxe_queue *q, enum queue_type type)
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		cons = q->buf->consumer_index;
-		break;
 	}
 
 	return ((prod + 1 - cons) & q->index_mask) == 0;
@@ -138,20 +129,16 @@ static inline unsigned int queue_count(const struct rxe_queue *q,
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		cons = q->buf->consumer_index;
-		break;
 	}
 
 	return (prod - cons) & q->index_mask;
@@ -162,7 +149,7 @@ static inline void advance_producer(struct rxe_queue *q, enum queue_type type)
 	u32 prod;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		pr_warn_once("Normally kernel should not write user space index\n");
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
@@ -170,15 +157,11 @@ static inline void advance_producer(struct rxe_queue *q, enum queue_type type)
 		/* same */
 		smp_store_release(&q->buf->producer_index, prod);
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
 		q->index = (prod + 1) & q->index_mask;
 		q->buf->producer_index = q->index;
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		q->buf->producer_index = (prod + 1) & q->index_mask;
-		break;
 	}
 }
 
@@ -187,12 +170,12 @@ static inline void advance_consumer(struct rxe_queue *q, enum queue_type type)
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		cons = q->index;
 		q->index = (cons + 1) & q->index_mask;
 		q->buf->consumer_index = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		pr_warn_once("Normally kernel should not write user space index\n");
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
@@ -200,10 +183,6 @@ static inline void advance_consumer(struct rxe_queue *q, enum queue_type type)
 		/* same */
 		smp_store_release(&q->buf->consumer_index, cons);
 		break;
-	case QUEUE_TYPE_KERNEL:
-		cons = q->buf->consumer_index;
-		q->buf->consumer_index = (cons + 1) & q->index_mask;
-		break;
 	}
 }
 
@@ -212,17 +191,14 @@ static inline void *producer_addr(struct rxe_queue *q, enum queue_type type)
 	u32 prod;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		prod &= q->index_mask;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		break;
 	}
 
 	return q->buf->data + (prod << q->log2_elem_size);
@@ -233,17 +209,14 @@ static inline void *consumer_addr(struct rxe_queue *q, enum queue_type type)
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		cons &= q->index_mask;
 		break;
-	case QUEUE_TYPE_KERNEL:
-		cons = q->buf->consumer_index;
-		break;
 	}
 
 	return q->buf->data + (cons << q->log2_elem_size);
@@ -255,17 +228,14 @@ static inline unsigned int producer_index(struct rxe_queue *q,
 	u32 prod;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		prod &= q->index_mask;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		break;
 	}
 
 	return prod;
@@ -277,17 +247,14 @@ static inline unsigned int consumer_index(struct rxe_queue *q,
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		cons &= q->index_mask;
 		break;
-	case QUEUE_TYPE_KERNEL:
-		cons = q->buf->consumer_index;
-		break;
 	}
 
 	return cons;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3894197a82f6..22c3edb28945 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -49,13 +49,8 @@ static void req_retry(struct rxe_qp *qp)
 	unsigned int cons;
 	unsigned int prod;
 
-	if (qp->is_user) {
-		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
-		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
-	} else {
-		cons = consumer_index(q, QUEUE_TYPE_KERNEL);
-		prod = producer_index(q, QUEUE_TYPE_KERNEL);
-	}
+	cons = consumer_index(q, QUEUE_TYPE_FROM_CLIENT);
+	prod = producer_index(q, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->req.wqe_index	= cons;
 	qp->req.psn		= qp->comp.psn;
@@ -121,15 +116,9 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	unsigned int cons;
 	unsigned int prod;
 
-	if (qp->is_user) {
-		wqe = queue_head(q, QUEUE_TYPE_FROM_USER);
-		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
-		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
-	} else {
-		wqe = queue_head(q, QUEUE_TYPE_KERNEL);
-		cons = consumer_index(q, QUEUE_TYPE_KERNEL);
-		prod = producer_index(q, QUEUE_TYPE_KERNEL);
-	}
+	wqe = queue_head(q, QUEUE_TYPE_FROM_CLIENT);
+	cons = consumer_index(q, QUEUE_TYPE_FROM_CLIENT);
+	prod = producer_index(q, QUEUE_TYPE_FROM_CLIENT);
 
 	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
 		/* check to see if we are drained;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5501227ddc65..596be002d33d 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -303,10 +303,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 
 	spin_lock_bh(&srq->rq.consumer_lock);
 
-	if (qp->is_user)
-		wqe = queue_head(q, QUEUE_TYPE_FROM_USER);
-	else
-		wqe = queue_head(q, QUEUE_TYPE_KERNEL);
+	wqe = queue_head(q, QUEUE_TYPE_FROM_CLIENT);
 	if (!wqe) {
 		spin_unlock_bh(&srq->rq.consumer_lock);
 		return RESPST_ERR_RNR;
@@ -322,13 +319,8 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	memcpy(&qp->resp.srq_wqe, wqe, size);
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
-	if (qp->is_user) {
-		advance_consumer(q, QUEUE_TYPE_FROM_USER);
-		count = queue_count(q, QUEUE_TYPE_FROM_USER);
-	} else {
-		advance_consumer(q, QUEUE_TYPE_KERNEL);
-		count = queue_count(q, QUEUE_TYPE_KERNEL);
-	}
+	advance_consumer(q, QUEUE_TYPE_FROM_CLIENT);
+	count = queue_count(q, QUEUE_TYPE_FROM_CLIENT);
 
 	if (srq->limit && srq->ibsrq.event_handler && (count < srq->limit)) {
 		srq->limit = 0;
@@ -357,12 +349,8 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 			qp->resp.status = IB_WC_WR_FLUSH_ERR;
 			return RESPST_COMPLETE;
 		} else if (!srq) {
-			if (qp->is_user)
-				qp->resp.wqe = queue_head(qp->rq.queue,
-						QUEUE_TYPE_FROM_USER);
-			else
-				qp->resp.wqe = queue_head(qp->rq.queue,
-						QUEUE_TYPE_KERNEL);
+			qp->resp.wqe = queue_head(qp->rq.queue,
+					QUEUE_TYPE_FROM_CLIENT);
 			if (qp->resp.wqe) {
 				qp->resp.status = IB_WC_WR_FLUSH_ERR;
 				return RESPST_COMPLETE;
@@ -389,12 +377,8 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		if (srq)
 			return get_srq_wqe(qp);
 
-		if (qp->is_user)
-			qp->resp.wqe = queue_head(qp->rq.queue,
-					QUEUE_TYPE_FROM_USER);
-		else
-			qp->resp.wqe = queue_head(qp->rq.queue,
-					QUEUE_TYPE_KERNEL);
+		qp->resp.wqe = queue_head(qp->rq.queue,
+				QUEUE_TYPE_FROM_CLIENT);
 		return (qp->resp.wqe) ? RESPST_CHK_LENGTH : RESPST_ERR_RNR;
 	}
 
@@ -936,12 +920,8 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	}
 
 	/* have copy for srq and reference for !srq */
-	if (!qp->srq) {
-		if (qp->is_user)
-			advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_USER);
-		else
-			advance_consumer(qp->rq.queue, QUEUE_TYPE_KERNEL);
-	}
+	if (!qp->srq)
+		advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->resp.wqe = NULL;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 610c98d24b5c..a9e7817e2732 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -93,7 +93,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	spin_lock_init(&srq->rq.producer_lock);
 	spin_lock_init(&srq->rq.consumer_lock);
 
-	type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
+	type = QUEUE_TYPE_FROM_CLIENT;
 	q = rxe_queue_init(rxe, &srq->rq.max_wr,
 			srq_wqe_size, type);
 	if (!q) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 267b5a9c345d..dc70e3edeba6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -218,11 +218,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	int num_sge = ibwr->num_sge;
 	int full;
 
-	if (rq->is_user)
-		full = queue_full(rq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		full = queue_full(rq->queue, QUEUE_TYPE_KERNEL);
-
+	full = queue_full(rq->queue, QUEUE_TYPE_FROM_CLIENT);
 	if (unlikely(full)) {
 		err = -ENOMEM;
 		goto err1;
@@ -237,11 +233,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	for (i = 0; i < num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	if (rq->is_user)
-		recv_wqe = producer_addr(rq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		recv_wqe = producer_addr(rq->queue, QUEUE_TYPE_KERNEL);
-
+	recv_wqe = producer_addr(rq->queue, QUEUE_TYPE_FROM_CLIENT);
 	recv_wqe->wr_id = ibwr->wr_id;
 	recv_wqe->num_sge = num_sge;
 
@@ -254,10 +246,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	recv_wqe->dma.cur_sge		= 0;
 	recv_wqe->dma.sge_offset	= 0;
 
-	if (rq->is_user)
-		advance_producer(rq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		advance_producer(rq->queue, QUEUE_TYPE_KERNEL);
+	advance_producer(rq->queue, QUEUE_TYPE_FROM_CLIENT);
 
 	return 0;
 
@@ -633,27 +622,17 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
-	if (qp->is_user)
-		full = queue_full(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		full = queue_full(sq->queue, QUEUE_TYPE_KERNEL);
+	full = queue_full(sq->queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (unlikely(full)) {
 		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 		return -ENOMEM;
 	}
 
-	if (qp->is_user)
-		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
-
+	send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_CLIENT);
 	init_send_wqe(qp, ibwr, mask, length, send_wqe);
 
-	if (qp->is_user)
-		advance_producer(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
+	advance_producer(sq->queue, QUEUE_TYPE_FROM_CLIENT);
 
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
@@ -845,18 +824,12 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
-		if (cq->is_user)
-			cqe = queue_head(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
+		cqe = queue_head(cq->queue, QUEUE_TYPE_TO_CLIENT);
 		if (!cqe)
 			break;
 
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
-		if (cq->is_user)
-			advance_consumer(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
+		advance_consumer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	}
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
@@ -868,10 +841,7 @@ static int rxe_peek_cq(struct ib_cq *ibcq, int wc_cnt)
 	struct rxe_cq *cq = to_rcq(ibcq);
 	int count;
 
-	if (cq->is_user)
-		count = queue_count(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		count = queue_count(cq->queue, QUEUE_TYPE_KERNEL);
+	count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
 	return (count > wc_cnt) ? wc_cnt : count;
 }
@@ -887,10 +857,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	if (cq->notify != IB_CQ_NEXT_COMP)
 		cq->notify = flags & IB_CQ_SOLICITED_MASK;
 
-	if (cq->is_user)
-		empty = queue_empty(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		empty = queue_empty(cq->queue, QUEUE_TYPE_KERNEL);
+	empty = queue_empty(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
 	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
 		ret = 1;
-- 
2.30.2

