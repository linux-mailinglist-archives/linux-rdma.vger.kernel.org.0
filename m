Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613C540B51E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhINQoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhINQoL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 12:44:11 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DC6C061762
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:53 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so19368756otk.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gBHDkRFw7OL6G6k4W3UEX7ja8Phy+AF6/axv0O9kq34=;
        b=csGTTMT9rIG/plAXX13C8xU65niIqqdRGHKp9S+v/9RqTR6z6rVyFsV4ZgLCtKvt1v
         yntDexHGy8aKlD+KqtIQ6eCngKJ5w6N/dDlguGzdgL5LeVCOX/vwmdTYz/Tj3H1FFi/j
         jIjqHZJmjzNetm5oI+PlQCJp0VHGyx+u9FMt5EA0JEVtBIl0cuqnWQRglXwVsthWIQVD
         YSFNo/UoFcaz7KQMwK4iWFNJOt3Ppbq/1XXVS1draELw1Hqis230R9x8xziJAIQYsdkG
         mqkScXROpqcIvIfUyHgYRvTLKL820w9PiYmTKW8W19kn5TDLZO66fCOrXNfDwVantIW9
         diBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gBHDkRFw7OL6G6k4W3UEX7ja8Phy+AF6/axv0O9kq34=;
        b=z5pQxwYhi6IzA3YNFvxPxrywUoXyobqDegeWGs6TeH9P7nyz1TF/EOlGusCANw/Ec5
         E3lxt1ZemZLVMt0P7m2jq3c4wxqY4Ma26xGcuWje449AYs6lrtJljzqmmoLtBwz3+CaO
         oUbv6bmrE0p7O3xyvo3QzZlxJyJlFo9VdlrueGxRneN//lizyi75bAsWV+kcVsx2SPp8
         Vci4Hiy9Nq3vN/+FZqULhIvifyAXEtw9zpZ8fHSz0iwfLEbagCGnbSA/vRc/tKwy7Nfe
         riUNyOxj8FpA4FiwlnJ4vk7EWCQEgrJQfmaSQN2Mb2Femn2P/9Xl5n9tvqRANZP13UFA
         eIFg==
X-Gm-Message-State: AOAM5302ry335XITS4Iji412o0bqbuPcTc9ChZ4oheAL4M32zLLzMRnw
        mAcMyNNvheJEV39Kvuoc7cw=
X-Google-Smtp-Source: ABdhPJzGHBA596XBTmD5/ZTACkC0LiOyyDbM0ixNuNFR8ysnp8XuWlqK1gREvMAsAkxywYGfjzoUng==
X-Received: by 2002:a9d:5d01:: with SMTP id b1mr15550474oti.263.1631637772886;
        Tue, 14 Sep 2021 09:42:52 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-61e3-00cf-5364-0046.res6.spectrum.com. [2603:8081:140c:1a00:61e3:cf:5364:46])
        by smtp.gmail.com with ESMTPSA id k1sm2850263otr.43.2021.09.14.09.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:42:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp, rao.shoaib@oracle.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v4 1/5] RDMA/rxe: Add memory barriers to kernel queues
Date:   Tue, 14 Sep 2021 11:42:03 -0500
Message-Id: <20210914164206.19768-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Earlier patches added memory barriers to protect user space to kernel
space communications. The user space queues were previously shown to
have occasional memory synchonization errors which were removed by
adding smp_load_acquire, smp_store_release barriers.  This patch extends
that to the case where queues are used between kernel space threads.

This patch also extends the queue types to include kernel ULP queues
which access the other end of the queues in kernel verbs calls like
poll_cq and post_send/recv.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
 drivers/infiniband/sw/rxe/rxe_qp.c    |  12 +-
 drivers/infiniband/sw/rxe/rxe_queue.c |  30 ++-
 drivers/infiniband/sw/rxe/rxe_queue.h | 292 +++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_req.c   |  37 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  40 +---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  53 +----
 9 files changed, 189 insertions(+), 314 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2d802c776fd..48a3864ada29 100644
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
+	queue_advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	if (post)
 		rxe_cq_post(qp->scq, &cqe, 0);
@@ -539,7 +533,7 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 			wqe->status = IB_WC_WR_FLUSH_ERR;
 			do_complete(qp, wqe);
 		} else {
-			advance_consumer(q, q->type);
+			queue_advance_consumer(q, q->type);
 		}
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index aef288f164fd..4eedaa0244b3 100644
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
+	addr = queue_producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	memcpy(addr, cqe, sizeof(*cqe));
 
-	if (cq->is_user)
-		advance_producer(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		advance_producer(cq->queue, QUEUE_TYPE_KERNEL);
+	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 1ab6af7ddb25..a13991a003d0 100644
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
-		qp->req.wqe_index = producer_index(qp->sq.queue,
-						QUEUE_TYPE_FROM_USER);
-	else
-		qp->req.wqe_index = producer_index(qp->sq.queue,
-						QUEUE_TYPE_KERNEL);
+	qp->req.wqe_index = queue_get_producer(qp->sq.queue,
+					       QUEUE_TYPE_FROM_CLIENT);
 
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
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 72d95398e604..6e6e023c1b45 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -111,17 +111,33 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 static int resize_finish(struct rxe_queue *q, struct rxe_queue *new_q,
 			 unsigned int num_elem)
 {
-	if (!queue_empty(q, q->type) && (num_elem < queue_count(q, q->type)))
+	enum queue_type type = q->type;
+	u32 prod;
+	u32 cons;
+
+	if (!queue_empty(q, q->type) && (num_elem < queue_count(q, type)))
 		return -EINVAL;
 
-	while (!queue_empty(q, q->type)) {
-		memcpy(producer_addr(new_q, new_q->type),
-					consumer_addr(q, q->type),
-					new_q->elem_size);
-		advance_producer(new_q, new_q->type);
-		advance_consumer(q, q->type);
+	prod = queue_get_producer(new_q, type);
+	cons = queue_get_consumer(q, type);
+
+	while (!queue_empty(q, type)) {
+		memcpy(queue_addr_from_index(new_q, prod),
+		       queue_addr_from_index(q, cons), new_q->elem_size);
+		prod = queue_next_index(new_q, prod);
+		cons = queue_next_index(q, cons);
 	}
 
+	new_q->buf->producer_index = prod;
+	q->buf->consumer_index = cons;
+
+	/* update private index copies */
+	if (type == QUEUE_TYPE_TO_CLIENT)
+		new_q->index = new_q->buf->producer_index;
+	else
+		q->index = q->buf->consumer_index;
+
+	/* exchange rxe_queue headers */
 	swap(*q, *new_q);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 2702b0e55fc3..6227112ef7a2 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -10,34 +10,47 @@
 /* for definition of shared struct rxe_queue_buf */
 #include <uapi/rdma/rdma_user_rxe.h>
 
-/* implements a simple circular buffer that can optionally be
- * shared between user space and the kernel and can be resized
- * the requested element size is rounded up to a power of 2
- * and the number of elements in the buffer is also rounded
- * up to a power of 2. Since the queue is empty when the
- * producer and consumer indices match the maximum capacity
- * of the queue is one less than the number of element slots
+/* Implements a simple circular buffer that is shared between user
+ * and the driver and can be resized. The requested element size is
+ * rounded up to a power of 2 and the number of elements in the buffer
+ * is also rounded up to a power of 2. Since the queue is empty when
+ * the producer and consumer indices match the maximum capacity of the
+ * queue is one less than the number of element slots.
  *
  * Notes:
- *   - Kernel space indices are always masked off to q->index_mask
- *   before storing so do not need to be checked on reads.
- *   - User space indices may be out of range and must be
- *   masked before use when read.
- *   - The kernel indices for shared queues must not be written
- *   by user space so a local copy is used and a shared copy is
- *   stored when the local copy changes.
+ *   - The driver indices are always masked off to q->index_mask
+ *     before storing so do not need to be checked on reads.
+ *   - The user whether user space or kernel is generally
+ *     not trusted so its parameters are masked to make sure
+ *     they do not access the queue out of bounds on reads.
+ *   - The driver indices for queues must not be written
+ *     by user so a local copy is used and a shared copy is
+ *     stored when the local copy is changed.
  *   - By passing the type in the parameter list separate from q
- *   the compiler can eliminate the switch statement when the
- *   actual queue type is known when the function is called.
- *   In the performance path this is done. In less critical
- *   paths just q->type is passed.
+ *     the compiler can eliminate the switch statement when the
+ *     actual queue type is known when the function is called at
+ *     compile time.
+ *   - These queues are lock free. The user and driver must protect
+ *     changes to their end of the queues with locks if more than one
+ *     CPU can be accessing it at the same time.
  */
 
-/* type of queue */
+/**
+ * enum queue_type - type of queue
+ * @QUEUE_TYPE_TO_CLIENT:	Queue is written by rxe driver and
+ *				read by client. Used by rxe driver only.
+ * @QUEUE_TYPE_FROM_CLIENT:	Queue is written by client and
+ *				read by rxe driver. Used by rxe driver only.
+ * @QUEUE_TYPE_TO_DRIVER:	Queue is written by client and
+ *				read by rxe driver. Used by kernel client only.
+ * @QUEUE_TYPE_FROM_DRIVER:	Queue is written by rxe driver and
+ *				read by client. Used by kernel client only.
+ */
 enum queue_type {
-	QUEUE_TYPE_KERNEL,
-	QUEUE_TYPE_TO_USER,
-	QUEUE_TYPE_FROM_USER,
+	QUEUE_TYPE_TO_CLIENT,
+	QUEUE_TYPE_FROM_CLIENT,
+	QUEUE_TYPE_TO_DRIVER,
+	QUEUE_TYPE_FROM_DRIVER,
 };
 
 struct rxe_queue {
@@ -69,238 +82,171 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
 		     unsigned int elem_size, struct ib_udata *udata,
 		     struct mminfo __user *outbuf,
-		     /* Protect producers while resizing queue */
-		     spinlock_t *producer_lock,
-		     /* Protect consumers while resizing queue */
-		     spinlock_t *consumer_lock);
+		     spinlock_t *producer_lock, spinlock_t *consumer_lock);
 
 void rxe_queue_cleanup(struct rxe_queue *queue);
 
-static inline int next_index(struct rxe_queue *q, int index)
+static inline u32 queue_next_index(struct rxe_queue *q, int index)
 {
-	return (index + 1) & q->buf->index_mask;
+	return (index + 1) & q->index_mask;
 }
 
-static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
+static inline u32 queue_get_producer(const struct rxe_queue *q,
+				     enum queue_type type)
 {
 	u32 prod;
-	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		/* protect user space index */
+	case QUEUE_TYPE_FROM_CLIENT:
+		/* protect user index */
 		prod = smp_load_acquire(&q->buf->producer_index);
-		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
-		/* protect user space index */
-		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
-	case QUEUE_TYPE_KERNEL:
+	case QUEUE_TYPE_FROM_DRIVER:
+		/* protect driver index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+		break;
+	case QUEUE_TYPE_TO_DRIVER:
 		prod = q->buf->producer_index;
-		cons = q->buf->consumer_index;
 		break;
 	}
 
-	return ((prod - cons) & q->index_mask) == 0;
+	return prod;
 }
 
-static inline int queue_full(struct rxe_queue *q, enum queue_type type)
+static inline u32 queue_get_consumer(const struct rxe_queue *q,
+				     enum queue_type type)
 {
-	u32 prod;
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		/* protect user space index */
-		prod = smp_load_acquire(&q->buf->producer_index);
+	case QUEUE_TYPE_FROM_CLIENT:
 		cons = q->index;
 		break;
-	case QUEUE_TYPE_TO_USER:
-		prod = q->index;
-		/* protect user space index */
+	case QUEUE_TYPE_TO_CLIENT:
+		/* protect user index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
+	case QUEUE_TYPE_FROM_DRIVER:
 		cons = q->buf->consumer_index;
 		break;
+	case QUEUE_TYPE_TO_DRIVER:
+		/* protect driver index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+		break;
 	}
 
-	return ((prod + 1 - cons) & q->index_mask) == 0;
+	return cons;
 }
 
-static inline unsigned int queue_count(const struct rxe_queue *q,
-					enum queue_type type)
+static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
 {
-	u32 prod;
-	u32 cons;
-
-	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		/* protect user space index */
-		prod = smp_load_acquire(&q->buf->producer_index);
-		cons = q->index;
-		break;
-	case QUEUE_TYPE_TO_USER:
-		prod = q->index;
-		/* protect user space index */
-		cons = smp_load_acquire(&q->buf->consumer_index);
-		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		cons = q->buf->consumer_index;
-		break;
-	}
+	u32 prod = queue_get_producer(q, type);
+	u32 cons = queue_get_consumer(q, type);
 
-	return (prod - cons) & q->index_mask;
+	return ((prod - cons) & q->index_mask) == 0;
 }
 
-static inline void advance_producer(struct rxe_queue *q, enum queue_type type)
+static inline int queue_full(struct rxe_queue *q, enum queue_type type)
 {
-	u32 prod;
+	u32 prod = queue_get_producer(q, type);
+	u32 cons = queue_get_consumer(q, type);
 
-	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		pr_warn_once("Normally kernel should not write user space index\n");
-		/* protect user space index */
-		prod = smp_load_acquire(&q->buf->producer_index);
-		prod = (prod + 1) & q->index_mask;
-		/* same */
-		smp_store_release(&q->buf->producer_index, prod);
-		break;
-	case QUEUE_TYPE_TO_USER:
-		prod = q->index;
-		q->index = (prod + 1) & q->index_mask;
-		q->buf->producer_index = q->index;
-		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		q->buf->producer_index = (prod + 1) & q->index_mask;
-		break;
-	}
+	return ((prod + 1 - cons) & q->index_mask) == 0;
 }
 
-static inline void advance_consumer(struct rxe_queue *q, enum queue_type type)
+static inline u32 queue_count(const struct rxe_queue *q,
+					enum queue_type type)
 {
-	u32 cons;
+	u32 prod = queue_get_producer(q, type);
+	u32 cons = queue_get_consumer(q, type);
 
-	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		cons = q->index;
-		q->index = (cons + 1) & q->index_mask;
-		q->buf->consumer_index = q->index;
-		break;
-	case QUEUE_TYPE_TO_USER:
-		pr_warn_once("Normally kernel should not write user space index\n");
-		/* protect user space index */
-		cons = smp_load_acquire(&q->buf->consumer_index);
-		cons = (cons + 1) & q->index_mask;
-		/* same */
-		smp_store_release(&q->buf->consumer_index, cons);
-		break;
-	case QUEUE_TYPE_KERNEL:
-		cons = q->buf->consumer_index;
-		q->buf->consumer_index = (cons + 1) & q->index_mask;
-		break;
-	}
+	return (prod - cons) & q->index_mask;
 }
 
-static inline void *producer_addr(struct rxe_queue *q, enum queue_type type)
+static inline void queue_advance_producer(struct rxe_queue *q,
+					  enum queue_type type)
 {
 	u32 prod;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		/* protect user space index */
-		prod = smp_load_acquire(&q->buf->producer_index);
-		prod &= q->index_mask;
+	case QUEUE_TYPE_FROM_CLIENT:
+		pr_warn("%s: attempt to advance client index\n",
+			__func__);
 		break;
-	case QUEUE_TYPE_TO_USER:
+	case QUEUE_TYPE_TO_CLIENT:
 		prod = q->index;
+		prod = (prod + 1) & q->index_mask;
+		q->index = prod;
+		/* protect user index */
+		smp_store_release(&q->buf->producer_index, prod);
+		break;
+	case QUEUE_TYPE_FROM_DRIVER:
+		pr_warn("%s: attempt to advance driver index\n",
+			__func__);
 		break;
-	case QUEUE_TYPE_KERNEL:
+	case QUEUE_TYPE_TO_DRIVER:
 		prod = q->buf->producer_index;
+		prod = (prod + 1) & q->index_mask;
+		q->buf->producer_index = prod;
 		break;
 	}
-
-	return q->buf->data + (prod << q->log2_elem_size);
 }
 
-static inline void *consumer_addr(struct rxe_queue *q, enum queue_type type)
+static inline void queue_advance_consumer(struct rxe_queue *q,
+					  enum queue_type type)
 {
 	u32 cons;
 
 	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
+	case QUEUE_TYPE_FROM_CLIENT:
 		cons = q->index;
+		cons = (cons + 1) & q->index_mask;
+		q->index = cons;
+		/* protect user index */
+		smp_store_release(&q->buf->consumer_index, cons);
 		break;
-	case QUEUE_TYPE_TO_USER:
-		/* protect user space index */
-		cons = smp_load_acquire(&q->buf->consumer_index);
-		cons &= q->index_mask;
+	case QUEUE_TYPE_TO_CLIENT:
+		pr_warn("%s: attempt to advance client index\n",
+			__func__);
 		break;
-	case QUEUE_TYPE_KERNEL:
+	case QUEUE_TYPE_FROM_DRIVER:
 		cons = q->buf->consumer_index;
+		cons = (cons + 1) & q->index_mask;
+		q->buf->consumer_index = cons;
+		break;
+	case QUEUE_TYPE_TO_DRIVER:
+		pr_warn("%s: attempt to advance driver index\n",
+			__func__);
 		break;
 	}
-
-	return q->buf->data + (cons << q->log2_elem_size);
 }
 
-static inline unsigned int producer_index(struct rxe_queue *q,
-						enum queue_type type)
+static inline void *queue_producer_addr(struct rxe_queue *q,
+					enum queue_type type)
 {
-	u32 prod;
+	u32 prod = queue_get_producer(q, type);
 
-	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		/* protect user space index */
-		prod = smp_load_acquire(&q->buf->producer_index);
-		prod &= q->index_mask;
-		break;
-	case QUEUE_TYPE_TO_USER:
-		prod = q->index;
-		break;
-	case QUEUE_TYPE_KERNEL:
-		prod = q->buf->producer_index;
-		break;
-	}
-
-	return prod;
+	return q->buf->data + (prod << q->log2_elem_size);
 }
 
-static inline unsigned int consumer_index(struct rxe_queue *q,
-						enum queue_type type)
+static inline void *queue_consumer_addr(struct rxe_queue *q,
+					enum queue_type type)
 {
-	u32 cons;
-
-	switch (type) {
-	case QUEUE_TYPE_FROM_USER:
-		cons = q->index;
-		break;
-	case QUEUE_TYPE_TO_USER:
-		/* protect user space index */
-		cons = smp_load_acquire(&q->buf->consumer_index);
-		cons &= q->index_mask;
-		break;
-	case QUEUE_TYPE_KERNEL:
-		cons = q->buf->consumer_index;
-		break;
-	}
+	u32 cons = queue_get_consumer(q, type);
 
-	return cons;
+	return q->buf->data + (cons << q->log2_elem_size);
 }
 
-static inline void *addr_from_index(struct rxe_queue *q,
-				unsigned int index)
+static inline void *queue_addr_from_index(struct rxe_queue *q, u32 index)
 {
 	return q->buf->data + ((index & q->index_mask)
-				<< q->buf->log2_elem_size);
+				<< q->log2_elem_size);
 }
 
-static inline unsigned int index_from_addr(const struct rxe_queue *q,
+static inline u32 queue_index_from_addr(const struct rxe_queue *q,
 				const void *addr)
 {
 	return (((u8 *)addr - q->buf->data) >> q->log2_elem_size)
@@ -309,7 +255,7 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
 
 static inline void *queue_head(struct rxe_queue *q, enum queue_type type)
 {
-	return queue_empty(q, type) ? NULL : consumer_addr(q, type);
+	return queue_empty(q, type) ? NULL : queue_consumer_addr(q, type);
 }
 
 #endif /* RXE_QUEUE_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3894197a82f6..801e36cefc29 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -49,21 +49,16 @@ static void req_retry(struct rxe_qp *qp)
 	unsigned int cons;
 	unsigned int prod;
 
-	if (qp->is_user) {
-		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
-		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
-	} else {
-		cons = consumer_index(q, QUEUE_TYPE_KERNEL);
-		prod = producer_index(q, QUEUE_TYPE_KERNEL);
-	}
+	cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
+	prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->req.wqe_index	= cons;
 	qp->req.psn		= qp->comp.psn;
 	qp->req.opcode		= -1;
 
 	for (wqe_index = cons; wqe_index != prod;
-			wqe_index = next_index(q, wqe_index)) {
-		wqe = addr_from_index(qp->sq.queue, wqe_index);
+			wqe_index = queue_next_index(q, wqe_index)) {
+		wqe = queue_addr_from_index(qp->sq.queue, wqe_index);
 		mask = wr_opcode_mask(wqe->wr.opcode, qp);
 
 		if (wqe->state == wqe_state_posted)
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
+	cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
+	prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
 
 	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
 		/* check to see if we are drained;
@@ -170,7 +159,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	if (index == prod)
 		return NULL;
 
-	wqe = addr_from_index(q, index);
+	wqe = queue_addr_from_index(q, index);
 
 	if (unlikely((qp->req.state == QP_STATE_DRAIN ||
 		      qp->req.state == QP_STATE_DRAINED) &&
@@ -560,7 +549,8 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	qp->req.opcode = pkt->opcode;
 
 	if (pkt->mask & RXE_END_MASK)
-		qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
+		qp->req.wqe_index = queue_next_index(qp->sq.queue,
+						     qp->req.wqe_index);
 
 	qp->need_req_skb = 0;
 
@@ -614,7 +604,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	wqe->state = wqe_state_done;
 	wqe->status = IB_WC_SUCCESS;
-	qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
+	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 
 	if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
 	    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
@@ -645,7 +635,8 @@ int rxe_requester(void *arg)
 		goto exit;
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
-		qp->req.wqe_index = consumer_index(q, q->type);
+		qp->req.wqe_index = queue_get_consumer(q,
+						QUEUE_TYPE_FROM_CLIENT);
 		qp->req.opcode = -1;
 		qp->req.need_rd_atomic = 0;
 		qp->req.wait_psn = 0;
@@ -711,7 +702,7 @@ int rxe_requester(void *arg)
 			wqe->last_psn = qp->req.psn;
 			qp->req.psn = (qp->req.psn + 1) & BTH_PSN_MASK;
 			qp->req.opcode = IB_OPCODE_UD_SEND_ONLY;
-			qp->req.wqe_index = next_index(qp->sq.queue,
+			qp->req.wqe_index = queue_next_index(qp->sq.queue,
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 5501227ddc65..c5a0b1f5747a 100644
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
+	queue_advance_consumer(q, QUEUE_TYPE_FROM_CLIENT);
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
+		queue_advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_CLIENT);
 
 	qp->resp.wqe = NULL;
 
@@ -1213,7 +1193,7 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 		return;
 
 	while (!qp->srq && q && queue_head(q, q->type))
-		advance_consumer(q, q->type);
+		queue_advance_consumer(q, q->type);
 }
 
 int rxe_responder(void *arg)
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
index 267b5a9c345d..46eaa1c5d4b3 100644
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
+	full = queue_full(rq->queue, QUEUE_TYPE_TO_DRIVER);
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
+	recv_wqe = queue_producer_addr(rq->queue, QUEUE_TYPE_TO_DRIVER);
 	recv_wqe->wr_id = ibwr->wr_id;
 	recv_wqe->num_sge = num_sge;
 
@@ -254,10 +246,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	recv_wqe->dma.cur_sge		= 0;
 	recv_wqe->dma.sge_offset	= 0;
 
-	if (rq->is_user)
-		advance_producer(rq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		advance_producer(rq->queue, QUEUE_TYPE_KERNEL);
+	queue_advance_producer(rq->queue, QUEUE_TYPE_TO_DRIVER);
 
 	return 0;
 
@@ -633,27 +622,17 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
-	if (qp->is_user)
-		full = queue_full(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		full = queue_full(sq->queue, QUEUE_TYPE_KERNEL);
+	full = queue_full(sq->queue, QUEUE_TYPE_TO_DRIVER);
 
 	if (unlikely(full)) {
 		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 		return -ENOMEM;
 	}
 
-	if (qp->is_user)
-		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
-
+	send_wqe = queue_producer_addr(sq->queue, QUEUE_TYPE_TO_DRIVER);
 	init_send_wqe(qp, ibwr, mask, length, send_wqe);
 
-	if (qp->is_user)
-		advance_producer(sq->queue, QUEUE_TYPE_FROM_USER);
-	else
-		advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
+	queue_advance_producer(sq->queue, QUEUE_TYPE_TO_DRIVER);
 
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
@@ -845,18 +824,12 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
-		if (cq->is_user)
-			cqe = queue_head(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
+		cqe = queue_head(cq->queue, QUEUE_TYPE_FROM_DRIVER);
 		if (!cqe)
 			break;
 
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
-		if (cq->is_user)
-			advance_consumer(cq->queue, QUEUE_TYPE_TO_USER);
-		else
-			advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
+		queue_advance_consumer(cq->queue, QUEUE_TYPE_FROM_DRIVER);
 	}
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
@@ -868,10 +841,7 @@ static int rxe_peek_cq(struct ib_cq *ibcq, int wc_cnt)
 	struct rxe_cq *cq = to_rcq(ibcq);
 	int count;
 
-	if (cq->is_user)
-		count = queue_count(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		count = queue_count(cq->queue, QUEUE_TYPE_KERNEL);
+	count = queue_count(cq->queue, QUEUE_TYPE_FROM_DRIVER);
 
 	return (count > wc_cnt) ? wc_cnt : count;
 }
@@ -887,10 +857,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	if (cq->notify != IB_CQ_NEXT_COMP)
 		cq->notify = flags & IB_CQ_SOLICITED_MASK;
 
-	if (cq->is_user)
-		empty = queue_empty(cq->queue, QUEUE_TYPE_TO_USER);
-	else
-		empty = queue_empty(cq->queue, QUEUE_TYPE_KERNEL);
+	empty = queue_empty(cq->queue, QUEUE_TYPE_FROM_DRIVER);
 
 	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
 		ret = 1;
-- 
2.30.2

