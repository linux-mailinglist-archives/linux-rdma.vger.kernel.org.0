Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7387039369F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 21:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhE0Ttc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 15:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhE0Ttc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 15:49:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB30C061761
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:56 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so1325241oty.7
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uw/zWsViTPqhozjaqBAAzRkFj1TLChWxR/arNG9OJE=;
        b=Q3+wPgdi90PJ9o1eis/XRfWP3LzLURkzor3os0FULgCmSnUJQbqfBSsH7aP7xMK8Sq
         /us886c0y47IcktXeaSAOv3NCIV6Rgev/sr+ET+DkbRvOks6uJJ2JdEddWbgmGy4HvMr
         pR1k/lHkUkuElqcptRjzdZY+ebSymTLvkdjMAC4Shxn/P23CNHsQwmGw5Ix/MzRZZshI
         FF2YsihqyoBa4ofrQ59zT7FQI7T/zlWbdm2aE1j6WjM2ShkI/LwYdFLESMqHuIvMi/I/
         FhrKIKDtnQefElIcF8I1i9Zsxj/dioEoQyefKmH8M6CYcuDNAQlZsuxkKxOx4tGnJCZc
         0G+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uw/zWsViTPqhozjaqBAAzRkFj1TLChWxR/arNG9OJE=;
        b=cn9ixMmOAFaGHAXywMwxRzg/gd1sKV4FsOP3oI8yHWDQvqITy3kbG8NaTsK3/qZJ5F
         zL+UZ37UmrT2dKWy11IF0UaYEcygfmavOzSkvrNrsyUsUV00aPBUAm9HuzGkqMvBQaA3
         1Wxn8HWSBB21e3SxZAO8U7Y36QXY6LE2Y7rMT7jJLXqLrcNVXZCNGJsxKba4Ls8TGP9w
         ZsPmiV6Ckp3++ZXiCXzolfcwo4PEJ9qaAaCgpfJ/qPBZojbz6WTPzRM13hBxSFqUYjMx
         A3QX3EnGINrzaHe152anFCS06BkPRy99KoQ7YGdmkdV1GPlZKjvTi33sVlxG76BQVebC
         dp9Q==
X-Gm-Message-State: AOAM532erlaIvaAKYmHii93IxDqTbhspXEgifqgQ12K915LvBhQRUEU9
        +KwphXrgJIcOKSIIE78Cieg=
X-Google-Smtp-Source: ABdhPJyBG7YU81/LJBkhl68R5KVTl5PL+Uu/Mvj5DWAFSwY+Gr0hZPM3rlEzXYDiPcL9MmkshQCmfA==
X-Received: by 2002:a9d:7494:: with SMTP id t20mr4101496otk.16.1622144876236;
        Thu, 27 May 2021 12:47:56 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-6d76-be96-2893-c13e.res6.spectrum.com. [2603:8081:140c:1a00:6d76:be96:2893:c13e])
        by smtp.gmail.com with ESMTPSA id v19sm690262otq.35.2021.05.27.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:47:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 3/3] RDMA/rxe: Protext kernel index from user space
Date:   Thu, 27 May 2021 14:47:48 -0500
Message-Id: <20210527194748.662636-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527194748.662636-1-rpearsonhpe@gmail.com>
References: <20210527194748.662636-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In order to prevent user space from modifying the index that
belongs to the kernel for shared queues let the kernel use
a local copy of the index and copy any new values of that index
to the shared rxe_queue_bus struct.

This adds more switch statements which decrease the peformance
of the queue API. Move the type into the parameter list for these
functions so that the compiler can optimize out the switch
statements when the explicit type is known. Modify all the calls
in the driver on performance paths to pass in the explicit queue
type.

Link: https://lore.kernel.org/linux-rdma/20210526165239.GP1002214@@nvidia.com/
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  31 ++++--
 drivers/infiniband/sw/rxe/rxe_cq.c    |  28 ++++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_queue.c |  13 +--
 drivers/infiniband/sw/rxe/rxe_queue.h | 145 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_req.c   |  46 ++++++--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  44 ++++++--
 drivers/infiniband/sw/rxe/rxe_srq.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  80 +++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |   5 +-
 10 files changed, 305 insertions(+), 98 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 207aa7ef52c4..d4ceb81a96df 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -142,7 +142,10 @@ static inline enum comp_state get_wqe(struct rxe_qp *qp,
 	/* we come here whether or not we found a response packet to see if
 	 * there are any posted WQEs
 	 */
-	wqe = queue_head(qp->sq.queue);
+	if (qp->is_user)
+		wqe = queue_head(qp->sq.queue, QUEUE_TYPE_FROM_USER);
+	else
+		wqe = queue_head(qp->sq.queue, QUEUE_TYPE_KERNEL);
 	*wqe_p = wqe;
 
 	/* no WQE or requester has not started it yet */
@@ -415,16 +418,23 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_cqe cqe;
+	bool post;
+
+	/* do we need to post a completion */
+	post = ((qp->sq_sig_type == IB_SIGNAL_ALL_WR) ||
+			(wqe->wr.send_flags & IB_SEND_SIGNALED) ||
+			wqe->status != IB_WC_SUCCESS);
 
-	if ((qp->sq_sig_type == IB_SIGNAL_ALL_WR) ||
-	    (wqe->wr.send_flags & IB_SEND_SIGNALED) ||
-	    wqe->status != IB_WC_SUCCESS) {
+	if (post)
 		make_send_cqe(qp, wqe, &cqe);
-		advance_consumer(qp->sq.queue);
+
+	if (qp->is_user)
+		advance_consumer(qp->sq.queue, QUEUE_TYPE_FROM_USER);
+	else
+		advance_consumer(qp->sq.queue, QUEUE_TYPE_KERNEL);
+
+	if (post)
 		rxe_cq_post(qp->scq, &cqe, 0);
-	} else {
-		advance_consumer(qp->sq.queue);
-	}
 
 	if (wqe->wr.opcode == IB_WR_SEND ||
 	    wqe->wr.opcode == IB_WR_SEND_WITH_IMM ||
@@ -512,6 +522,7 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 {
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
+	struct rxe_queue *q = qp->sq.queue;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
 		rxe_drop_ref(qp);
@@ -519,12 +530,12 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 		ib_device_put(qp->ibqp.device);
 	}
 
-	while ((wqe = queue_head(qp->sq.queue))) {
+	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
 			wqe->status = IB_WC_WR_FLUSH_ERR;
 			do_complete(qp, wqe);
 		} else {
-			advance_consumer(qp->sq.queue);
+			advance_consumer(q, q->type);
 		}
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 1d4d8a31bc12..aef288f164fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -25,7 +25,11 @@ int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
 	}
 
 	if (cq) {
-		count = queue_count(cq->queue);
+		if (cq->is_user)
+			count = queue_count(cq->queue, QUEUE_TYPE_TO_USER);
+		else
+			count = queue_count(cq->queue, QUEUE_TYPE_KERNEL);
+
 		if (cqe < count) {
 			pr_warn("cqe(%d) < current # elements in queue (%d)",
 				cqe, count);
@@ -108,10 +112,17 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 {
 	struct ib_event ev;
 	unsigned long flags;
+	int full;
+	void *addr;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
-	if (unlikely(queue_full(cq->queue))) {
+	if (cq->is_user)
+		full = queue_full(cq->queue, QUEUE_TYPE_TO_USER);
+	else
+		full = queue_full(cq->queue, QUEUE_TYPE_KERNEL);
+
+	if (unlikely(full)) {
 		spin_unlock_irqrestore(&cq->cq_lock, flags);
 		if (cq->ibcq.event_handler) {
 			ev.device = cq->ibcq.device;
@@ -123,9 +134,18 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 		return -EBUSY;
 	}
 
-	memcpy(producer_addr(cq->queue), cqe, sizeof(*cqe));
+	if (cq->is_user)
+		addr = producer_addr(cq->queue, QUEUE_TYPE_TO_USER);
+	else
+		addr = producer_addr(cq->queue, QUEUE_TYPE_KERNEL);
+
+	memcpy(addr, cqe, sizeof(*cqe));
+
+	if (cq->is_user)
+		advance_producer(cq->queue, QUEUE_TYPE_TO_USER);
+	else
+		advance_producer(cq->queue, QUEUE_TYPE_KERNEL);
 
-	advance_producer(cq->queue);
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
 	if ((cq->notify == IB_CQ_NEXT_COMP) ||
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 9bd6bf8f9bd9..a9256862464b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -248,7 +248,13 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 		return err;
 	}
 
-	qp->req.wqe_index	= producer_index(qp->sq.queue);
+	if (qp->is_user)
+		qp->req.wqe_index = producer_index(qp->sq.queue,
+						QUEUE_TYPE_FROM_USER);
+	else
+		qp->req.wqe_index = producer_index(qp->sq.queue,
+						QUEUE_TYPE_KERNEL);
+
 	qp->req.state		= QP_STATE_RESET;
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
@@ -306,6 +312,8 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
 
+	qp->rq.is_user = qp->is_user;
+
 	skb_queue_head_init(&qp->resp_pkts);
 
 	rxe_init_task(rxe, &qp->resp.task, qp,
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 8f844d0b9e77..85b812586ed4 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -111,14 +111,15 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
 static int resize_finish(struct rxe_queue *q, struct rxe_queue *new_q,
 			 unsigned int num_elem)
 {
-	if (!queue_empty(q) && (num_elem < queue_count(q)))
+	if (!queue_empty(q, q->type) && (num_elem < queue_count(q, q->type)))
 		return -EINVAL;
 
-	while (!queue_empty(q)) {
-		memcpy(producer_addr(new_q), consumer_addr(q),
-		       new_q->elem_size);
-		advance_producer(new_q);
-		advance_consumer(q);
+	while (!queue_empty(q, q->type)) {
+		memcpy(producer_addr(new_q, new_q->type),
+					consumer_addr(q, q->type),
+					new_q->elem_size);
+		advance_producer(new_q, new_q->type);
+		advance_consumer(q, q->type);
 	}
 
 	swap(*q, *new_q);
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 6e705e09d357..2702b0e55fc3 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -17,6 +17,20 @@
  * up to a power of 2. Since the queue is empty when the
  * producer and consumer indices match the maximum capacity
  * of the queue is one less than the number of element slots
+ *
+ * Notes:
+ *   - Kernel space indices are always masked off to q->index_mask
+ *   before storing so do not need to be checked on reads.
+ *   - User space indices may be out of range and must be
+ *   masked before use when read.
+ *   - The kernel indices for shared queues must not be written
+ *   by user space so a local copy is used and a shared copy is
+ *   stored when the local copy changes.
+ *   - By passing the type in the parameter list separate from q
+ *   the compiler can eliminate the switch statement when the
+ *   actual queue type is known when the function is called.
+ *   In the performance path this is done. In less critical
+ *   paths just q->type is passed.
  */
 
 /* type of queue */
@@ -35,6 +49,12 @@ struct rxe_queue {
 	unsigned int		log2_elem_size;
 	u32			index_mask;
 	enum queue_type		type;
+	/* private copy of index for shared queues between
+	 * kernel space and user space. Kernel reads and writes
+	 * this copy and then replicates to rxe_queue_buf
+	 * for read access by user space.
+	 */
+	u32			index;
 };
 
 int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
@@ -61,19 +81,19 @@ static inline int next_index(struct rxe_queue *q, int index)
 	return (index + 1) & q->buf->index_mask;
 }
 
-static inline int queue_empty(struct rxe_queue *q)
+static inline int queue_empty(struct rxe_queue *q, enum queue_type type)
 {
 	u32 prod;
 	u32 cons;
 
-	switch (q->type) {
+	switch (type) {
 	case QUEUE_TYPE_FROM_USER:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
-		cons = q->buf->consumer_index;
+		cons = q->index;
 		break;
 	case QUEUE_TYPE_TO_USER:
-		prod = q->buf->producer_index;
+		prod = q->index;
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
@@ -86,19 +106,19 @@ static inline int queue_empty(struct rxe_queue *q)
 	return ((prod - cons) & q->index_mask) == 0;
 }
 
-static inline int queue_full(struct rxe_queue *q)
+static inline int queue_full(struct rxe_queue *q, enum queue_type type)
 {
 	u32 prod;
 	u32 cons;
 
-	switch (q->type) {
+	switch (type) {
 	case QUEUE_TYPE_FROM_USER:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
-		cons = q->buf->consumer_index;
+		cons = q->index;
 		break;
 	case QUEUE_TYPE_TO_USER:
-		prod = q->buf->producer_index;
+		prod = q->index;
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
@@ -111,19 +131,20 @@ static inline int queue_full(struct rxe_queue *q)
 	return ((prod + 1 - cons) & q->index_mask) == 0;
 }
 
-static inline unsigned int queue_count(const struct rxe_queue *q)
+static inline unsigned int queue_count(const struct rxe_queue *q,
+					enum queue_type type)
 {
 	u32 prod;
 	u32 cons;
 
-	switch (q->type) {
+	switch (type) {
 	case QUEUE_TYPE_FROM_USER:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
-		cons = q->buf->consumer_index;
+		cons = q->index;
 		break;
 	case QUEUE_TYPE_TO_USER:
-		prod = q->buf->producer_index;
+		prod = q->index;
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
@@ -136,90 +157,138 @@ static inline unsigned int queue_count(const struct rxe_queue *q)
 	return (prod - cons) & q->index_mask;
 }
 
-static inline void advance_producer(struct rxe_queue *q)
+static inline void advance_producer(struct rxe_queue *q, enum queue_type type)
 {
 	u32 prod;
 
-	if (q->type == QUEUE_TYPE_FROM_USER) {
+	switch (type) {
+	case QUEUE_TYPE_FROM_USER:
+		pr_warn_once("Normally kernel should not write user space index\n");
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		prod = (prod + 1) & q->index_mask;
 		/* same */
 		smp_store_release(&q->buf->producer_index, prod);
-	} else {
+		break;
+	case QUEUE_TYPE_TO_USER:
+		prod = q->index;
+		q->index = (prod + 1) & q->index_mask;
+		q->buf->producer_index = q->index;
+		break;
+	case QUEUE_TYPE_KERNEL:
 		prod = q->buf->producer_index;
 		q->buf->producer_index = (prod + 1) & q->index_mask;
+		break;
 	}
 }
 
-static inline void advance_consumer(struct rxe_queue *q)
+static inline void advance_consumer(struct rxe_queue *q, enum queue_type type)
 {
 	u32 cons;
 
-	if (q->type == QUEUE_TYPE_TO_USER) {
+	switch (type) {
+	case QUEUE_TYPE_FROM_USER:
+		cons = q->index;
+		q->index = (cons + 1) & q->index_mask;
+		q->buf->consumer_index = q->index;
+		break;
+	case QUEUE_TYPE_TO_USER:
+		pr_warn_once("Normally kernel should not write user space index\n");
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		cons = (cons + 1) & q->index_mask;
 		/* same */
 		smp_store_release(&q->buf->consumer_index, cons);
-	} else {
+		break;
+	case QUEUE_TYPE_KERNEL:
 		cons = q->buf->consumer_index;
 		q->buf->consumer_index = (cons + 1) & q->index_mask;
+		break;
 	}
 }
 
-static inline void *producer_addr(struct rxe_queue *q)
+static inline void *producer_addr(struct rxe_queue *q, enum queue_type type)
 {
 	u32 prod;
 
-	if (q->type == QUEUE_TYPE_FROM_USER)
+	switch (type) {
+	case QUEUE_TYPE_FROM_USER:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
-	else
+		prod &= q->index_mask;
+		break;
+	case QUEUE_TYPE_TO_USER:
+		prod = q->index;
+		break;
+	case QUEUE_TYPE_KERNEL:
 		prod = q->buf->producer_index;
+		break;
+	}
 
-	return q->buf->data + ((prod & q->index_mask) << q->log2_elem_size);
+	return q->buf->data + (prod << q->log2_elem_size);
 }
 
-static inline void *consumer_addr(struct rxe_queue *q)
+static inline void *consumer_addr(struct rxe_queue *q, enum queue_type type)
 {
 	u32 cons;
 
-	if (q->type == QUEUE_TYPE_TO_USER)
+	switch (type) {
+	case QUEUE_TYPE_FROM_USER:
+		cons = q->index;
+		break;
+	case QUEUE_TYPE_TO_USER:
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
-	else
+		cons &= q->index_mask;
+		break;
+	case QUEUE_TYPE_KERNEL:
 		cons = q->buf->consumer_index;
+		break;
+	}
 
-	return q->buf->data + ((cons & q->index_mask) << q->log2_elem_size);
+	return q->buf->data + (cons << q->log2_elem_size);
 }
 
-static inline unsigned int producer_index(struct rxe_queue *q)
+static inline unsigned int producer_index(struct rxe_queue *q,
+						enum queue_type type)
 {
 	u32 prod;
 
-	if (q->type == QUEUE_TYPE_FROM_USER)
+	switch (type) {
+	case QUEUE_TYPE_FROM_USER:
 		/* protect user space index */
 		prod = smp_load_acquire(&q->buf->producer_index);
-	else
+		prod &= q->index_mask;
+		break;
+	case QUEUE_TYPE_TO_USER:
+		prod = q->index;
+		break;
+	case QUEUE_TYPE_KERNEL:
 		prod = q->buf->producer_index;
-
-	prod &= q->index_mask;
+		break;
+	}
 
 	return prod;
 }
 
-static inline unsigned int consumer_index(struct rxe_queue *q)
+static inline unsigned int consumer_index(struct rxe_queue *q,
+						enum queue_type type)
 {
 	u32 cons;
 
-	if (q->type == QUEUE_TYPE_TO_USER)
+	switch (type) {
+	case QUEUE_TYPE_FROM_USER:
+		cons = q->index;
+		break;
+	case QUEUE_TYPE_TO_USER:
 		/* protect user space index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
-	else
+		cons &= q->index_mask;
+		break;
+	case QUEUE_TYPE_KERNEL:
 		cons = q->buf->consumer_index;
-
-	cons &= q->index_mask;
+		break;
+	}
 
 	return cons;
 }
@@ -238,9 +307,9 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
 				& q->index_mask;
 }
 
-static inline void *queue_head(struct rxe_queue *q)
+static inline void *queue_head(struct rxe_queue *q, enum queue_type type)
 {
-	return queue_empty(q) ? NULL : consumer_addr(q);
+	return queue_empty(q, type) ? NULL : consumer_addr(q, type);
 }
 
 #endif /* RXE_QUEUE_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 52ddf2d1fe61..bd6b747034e7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -45,14 +45,24 @@ static void req_retry(struct rxe_qp *qp)
 	unsigned int mask;
 	int npsn;
 	int first = 1;
+	struct rxe_queue *q = qp->sq.queue;
+	unsigned int cons;
+	unsigned int prod;
 
-	qp->req.wqe_index	= consumer_index(qp->sq.queue);
+	if (qp->is_user) {
+		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
+		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
+	} else {
+		cons = consumer_index(q, QUEUE_TYPE_KERNEL);
+		prod = producer_index(q, QUEUE_TYPE_KERNEL);
+	}
+
+	qp->req.wqe_index	= cons;
 	qp->req.psn		= qp->comp.psn;
 	qp->req.opcode		= -1;
 
-	for (wqe_index = consumer_index(qp->sq.queue);
-		wqe_index != producer_index(qp->sq.queue);
-		wqe_index = next_index(qp->sq.queue, wqe_index)) {
+	for (wqe_index = cons; wqe_index != prod;
+			wqe_index = next_index(q, wqe_index)) {
 		wqe = addr_from_index(qp->sq.queue, wqe_index);
 		mask = wr_opcode_mask(wqe->wr.opcode, qp);
 
@@ -104,8 +114,22 @@ void rnr_nak_timer(struct timer_list *t)
 
 static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 {
-	struct rxe_send_wqe *wqe = queue_head(qp->sq.queue);
+	struct rxe_send_wqe *wqe;
 	unsigned long flags;
+	struct rxe_queue *q = qp->sq.queue;
+	unsigned int index = qp->req.wqe_index;
+	unsigned int cons;
+	unsigned int prod;
+
+	if (qp->is_user) {
+		wqe = queue_head(q, QUEUE_TYPE_FROM_USER);
+		cons = consumer_index(q, QUEUE_TYPE_FROM_USER);
+		prod = producer_index(q, QUEUE_TYPE_FROM_USER);
+	} else {
+		wqe = queue_head(q, QUEUE_TYPE_KERNEL);
+		cons = consumer_index(q, QUEUE_TYPE_KERNEL);
+		prod = producer_index(q, QUEUE_TYPE_KERNEL);
+	}
 
 	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
 		/* check to see if we are drained;
@@ -120,8 +144,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 				break;
 			}
 
-			if (wqe && ((qp->req.wqe_index !=
-				consumer_index(qp->sq.queue)) ||
+			if (wqe && ((index != cons) ||
 				(wqe->state != wqe_state_posted))) {
 				/* comp not done yet */
 				spin_unlock_irqrestore(&qp->state_lock,
@@ -144,10 +167,10 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		} while (0);
 	}
 
-	if (qp->req.wqe_index == producer_index(qp->sq.queue))
+	if (index == prod)
 		return NULL;
 
-	wqe = addr_from_index(qp->sq.queue, qp->req.wqe_index);
+	wqe = addr_from_index(q, index);
 
 	if (unlikely((qp->req.state == QP_STATE_DRAIN ||
 		      qp->req.state == QP_STATE_DRAINED) &&
@@ -155,7 +178,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		return NULL;
 
 	if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
-		     (qp->req.wqe_index != consumer_index(qp->sq.queue)))) {
+						     (index != cons))) {
 		qp->req.wait_fence = 1;
 		return NULL;
 	}
@@ -629,6 +652,7 @@ int rxe_requester(void *arg)
 	int ret;
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
+	struct rxe_queue *q = qp->sq.queue;
 
 	rxe_add_ref(qp);
 
@@ -637,7 +661,7 @@ int rxe_requester(void *arg)
 		goto exit;
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
-		qp->req.wqe_index = consumer_index(qp->sq.queue);
+		qp->req.wqe_index = consumer_index(q, q->type);
 		qp->req.opcode = -1;
 		qp->req.need_rd_atomic = 0;
 		qp->req.wait_psn = 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 1ea576d42882..78c052c04615 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -295,13 +295,17 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	struct rxe_queue *q = srq->rq.queue;
 	struct rxe_recv_wqe *wqe;
 	struct ib_event ev;
+	unsigned int count;
 
 	if (srq->error)
 		return RESPST_ERR_RNR;
 
 	spin_lock_bh(&srq->rq.consumer_lock);
 
-	wqe = queue_head(q);
+	if (qp->is_user)
+		wqe = queue_head(q, QUEUE_TYPE_FROM_USER);
+	else
+		wqe = queue_head(q, QUEUE_TYPE_KERNEL);
 	if (!wqe) {
 		spin_unlock_bh(&srq->rq.consumer_lock);
 		return RESPST_ERR_RNR;
@@ -311,10 +315,15 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	memcpy(&qp->resp.srq_wqe, wqe, sizeof(qp->resp.srq_wqe));
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
-	advance_consumer(q);
+	if (qp->is_user) {
+		advance_consumer(q, QUEUE_TYPE_FROM_USER);
+		count = queue_count(q, QUEUE_TYPE_FROM_USER);
+	} else {
+		advance_consumer(q, QUEUE_TYPE_KERNEL);
+		count = queue_count(q, QUEUE_TYPE_KERNEL);
+	}
 
-	if (srq->limit && srq->ibsrq.event_handler &&
-	    (queue_count(q) < srq->limit)) {
+	if (srq->limit && srq->ibsrq.event_handler && (count < srq->limit)) {
 		srq->limit = 0;
 		goto event;
 	}
@@ -341,7 +350,12 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 			qp->resp.status = IB_WC_WR_FLUSH_ERR;
 			return RESPST_COMPLETE;
 		} else if (!srq) {
-			qp->resp.wqe = queue_head(qp->rq.queue);
+			if (qp->is_user)
+				qp->resp.wqe = queue_head(qp->rq.queue,
+						QUEUE_TYPE_FROM_USER);
+			else
+				qp->resp.wqe = queue_head(qp->rq.queue,
+						QUEUE_TYPE_KERNEL);
 			if (qp->resp.wqe) {
 				qp->resp.status = IB_WC_WR_FLUSH_ERR;
 				return RESPST_COMPLETE;
@@ -368,7 +382,12 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		if (srq)
 			return get_srq_wqe(qp);
 
-		qp->resp.wqe = queue_head(qp->rq.queue);
+		if (qp->is_user)
+			qp->resp.wqe = queue_head(qp->rq.queue,
+					QUEUE_TYPE_FROM_USER);
+		else
+			qp->resp.wqe = queue_head(qp->rq.queue,
+					QUEUE_TYPE_KERNEL);
 		return (qp->resp.wqe) ? RESPST_CHK_LENGTH : RESPST_ERR_RNR;
 	}
 
@@ -939,8 +958,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	}
 
 	/* have copy for srq and reference for !srq */
-	if (!qp->srq)
-		advance_consumer(qp->rq.queue);
+	if (!qp->srq) {
+		if (qp->is_user)
+			advance_consumer(qp->rq.queue, QUEUE_TYPE_FROM_USER);
+		else
+			advance_consumer(qp->rq.queue, QUEUE_TYPE_KERNEL);
+	}
 
 	qp->resp.wqe = NULL;
 
@@ -1206,6 +1229,7 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 {
 	struct sk_buff *skb;
+	struct rxe_queue *q = qp->rq.queue;
 
 	while ((skb = skb_dequeue(&qp->req_pkts))) {
 		rxe_drop_ref(qp);
@@ -1216,8 +1240,8 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	if (notify)
 		return;
 
-	while (!qp->srq && qp->rq.queue && queue_head(qp->rq.queue))
-		advance_consumer(qp->rq.queue);
+	while (!qp->srq && q && queue_head(q, q->type))
+		advance_consumer(q, q->type);
 }
 
 int rxe_responder(void *arg)
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 52c5593741ec..610c98d24b5c 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -86,6 +86,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	srq->srq_num		= srq->pelem.index;
 	srq->rq.max_wr		= init->attr.max_wr;
 	srq->rq.max_sge		= init->attr.max_sge;
+	srq->rq.is_user		= srq->is_user;
 
 	srq_wqe_size		= rcv_wqe_size(srq->rq.max_sge);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 3e0bab4994d1..a055d4c76f4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -216,8 +216,14 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	u32 length;
 	struct rxe_recv_wqe *recv_wqe;
 	int num_sge = ibwr->num_sge;
+	int full;
 
-	if (unlikely(queue_full(rq->queue))) {
+	if (rq->is_user)
+		full = queue_full(rq->queue, QUEUE_TYPE_FROM_USER);
+	else
+		full = queue_full(rq->queue, QUEUE_TYPE_KERNEL);
+
+	if (unlikely(full)) {
 		err = -ENOMEM;
 		goto err1;
 	}
@@ -231,7 +237,11 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	for (i = 0; i < num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	recv_wqe = producer_addr(rq->queue);
+	if (rq->is_user)
+		recv_wqe = producer_addr(rq->queue, QUEUE_TYPE_FROM_USER);
+	else
+		recv_wqe = producer_addr(rq->queue, QUEUE_TYPE_KERNEL);
+
 	recv_wqe->wr_id = ibwr->wr_id;
 	recv_wqe->num_sge = num_sge;
 
@@ -244,7 +254,11 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	recv_wqe->dma.cur_sge		= 0;
 	recv_wqe->dma.sge_offset	= 0;
 
-	advance_producer(rq->queue);
+	if (rq->is_user)
+		advance_producer(rq->queue, QUEUE_TYPE_FROM_USER);
+	else
+		advance_producer(rq->queue, QUEUE_TYPE_KERNEL);
+
 	return 0;
 
 err1:
@@ -267,6 +281,9 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
 		uresp = udata->outbuf;
+		srq->is_user = true;
+	} else {
+		srq->is_user = false;
 	}
 
 	err = rxe_srq_chk_attr(rxe, NULL, &init->attr, IB_SRQ_INIT_MASK);
@@ -408,7 +425,9 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 			err = -EINVAL;
 			goto err2;
 		}
-		qp->is_user = 1;
+		qp->is_user = true;
+	} else {
+		qp->is_user = false;
 	}
 
 	rxe_add_index(qp);
@@ -613,6 +632,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	struct rxe_sq *sq = &qp->sq;
 	struct rxe_send_wqe *send_wqe;
 	unsigned long flags;
+	int full;
 
 	err = validate_send_wr(qp, ibwr, mask, length);
 	if (err)
@@ -620,22 +640,31 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
-	if (unlikely(queue_full(sq->queue))) {
-		err = -ENOMEM;
-		goto err1;
+	if (qp->is_user)
+		full = queue_full(sq->queue, QUEUE_TYPE_FROM_USER);
+	else
+		full = queue_full(sq->queue, QUEUE_TYPE_KERNEL);
+
+	if (unlikely(full)) {
+		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
+		return -ENOMEM;
 	}
 
-	send_wqe = producer_addr(sq->queue);
+	if (qp->is_user)
+		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_USER);
+	else
+		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
+
 	init_send_wqe(qp, ibwr, mask, length, send_wqe);
 
-	advance_producer(sq->queue);
+	if (qp->is_user)
+		advance_producer(sq->queue, QUEUE_TYPE_FROM_USER);
+	else
+		advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
+
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
 	return 0;
-
-err1:
-	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
-	return err;
 }
 
 static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
@@ -823,12 +852,18 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
-		cqe = queue_head(cq->queue);
+		if (cq->is_user)
+			cqe = queue_head(cq->queue, QUEUE_TYPE_TO_USER);
+		else
+			cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
 		if (!cqe)
 			break;
 
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
-		advance_consumer(cq->queue);
+		if (cq->is_user)
+			advance_consumer(cq->queue, QUEUE_TYPE_TO_USER);
+		else
+			advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
 	}
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
@@ -838,7 +873,12 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 static int rxe_peek_cq(struct ib_cq *ibcq, int wc_cnt)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
-	int count = queue_count(cq->queue);
+	int count;
+
+	if (cq->is_user)
+		count = queue_count(cq->queue, QUEUE_TYPE_TO_USER);
+	else
+		count = queue_count(cq->queue, QUEUE_TYPE_KERNEL);
 
 	return (count > wc_cnt) ? wc_cnt : count;
 }
@@ -848,12 +888,18 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	struct rxe_cq *cq = to_rcq(ibcq);
 	unsigned long irq_flags;
 	int ret = 0;
+	int empty;
 
 	spin_lock_irqsave(&cq->cq_lock, irq_flags);
 	if (cq->notify != IB_CQ_NEXT_COMP)
 		cq->notify = flags & IB_CQ_SOLICITED_MASK;
 
-	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !queue_empty(cq->queue))
+	if (cq->is_user)
+		empty = queue_empty(cq->queue, QUEUE_TYPE_TO_USER);
+	else
+		empty = queue_empty(cq->queue, QUEUE_TYPE_KERNEL);
+
+	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
 		ret = 1;
 
 	spin_unlock_irqrestore(&cq->cq_lock, irq_flags);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index cf8cae64f7df..959a3260fcab 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -77,6 +77,7 @@ enum wqe_state {
 };
 
 struct rxe_sq {
+	bool			is_user;
 	int			max_wr;
 	int			max_sge;
 	int			max_inline;
@@ -85,6 +86,7 @@ struct rxe_sq {
 };
 
 struct rxe_rq {
+	bool			is_user;
 	int			max_wr;
 	int			max_sge;
 	spinlock_t		producer_lock; /* guard queue producer */
@@ -98,6 +100,7 @@ struct rxe_srq {
 	struct rxe_pd		*pd;
 	struct rxe_rq		rq;
 	u32			srq_num;
+	bool			is_user;
 
 	int			limit;
 	int			error;
@@ -212,7 +215,7 @@ struct rxe_qp {
 	struct ib_qp_attr	attr;
 	unsigned int		valid;
 	unsigned int		mtu;
-	int			is_user;
+	bool			is_user;
 
 	struct rxe_pd		*pd;
 	struct rxe_srq		*srq;
-- 
2.30.2

