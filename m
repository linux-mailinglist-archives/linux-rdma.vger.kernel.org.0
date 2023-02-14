Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B22A695A6C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBNHQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 02:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBNHQH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 02:16:07 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2082310B
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 23:12:44 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id k15-20020a4adfaf000000b00517450f9bd7so1435941ook.8
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 23:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccpb9eCxwIQvAE42sjHlzEpM6RBAxtNyjVLIkUt5L4E=;
        b=mpIppvKug3YGB8dSXZq+Dxj5uLiWlk0CUX2z9RU1zSOtdO++lau8xMGf1EJIlrOTp+
         +n7qAfr1/2cHME/bGOmGIJ0DLfuW9mhFPSO52c2rWXNphh1MIbMWOJJn8myS2ThM55aj
         9D/9A87rViJyEJQxlpyLosHiv0DeVxbl29b6r5Y3EVLu+7avsvXd5QlYv0VaixOhzOLb
         fd/hS0kzEYGrDYRSX2JuQv6qcqr2CdFtbx2ZUmIcCI3fXpN5H57c6SGq2AKjWf8PXRD8
         z6tvh5VaPDW3FICvRsqBU/iQM0WRSS4NA2vusMZa2dzeoJZv9VTdZc0EKyMiWrmk+lfY
         cuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccpb9eCxwIQvAE42sjHlzEpM6RBAxtNyjVLIkUt5L4E=;
        b=CcO+aAeLsrjn0Qs/9T8kBVqiypFIIjmy5f+GDIiHyBAZ3Tp4siQy0X/dC0Vx4//+qL
         pjTlFekNJaPGxeSAPbB2uaYyjkv5pZn/USjOpcgxdD8ROco0/54XcG4MjpdrCYLGodta
         9oTBDliC6xpbK62WCdQjqdFJSV8dkWD3fsMG0SXUp8JePoSr2FqntHaHo62B/f/13ZI3
         jjTKslmeANGsc5WqkFTAnoupmgNhuOcC8YkrW6Wua4Ozrp4e9cZOw3KQ3hFkejzdm2Xo
         lIEh/SHRC3s+DbHLbRZF+P60Jvpx0C/Zj/TraJEBBpCDxrVyQouV2ceA+1yEI94nP3Ft
         NANg==
X-Gm-Message-State: AO0yUKWpLDnO4TRtFyHYoOjqe8ySX5dCi+9/tWRrBNpdKfcBmQedqpKs
        vJOgrTjokWMU1oDc3YNW7WZ8+6qZdRE=
X-Google-Smtp-Source: AK7set8uGOtnhuJeTiopE+bWCP5WHV1G7sxRn1m+X0x14I5N2PETw6gNXUDJgQ45I5zDsQzDNOUYGw==
X-Received: by 2002:a4a:251e:0:b0:517:a7d1:9762 with SMTP id g30-20020a4a251e000000b00517a7d19762mr307518ooa.7.1676358763284;
        Mon, 13 Feb 2023 23:12:43 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id i9-20020a4abc09000000b004a3527e8279sm5658787oop.0.2023.02.13.23.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 23:12:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        ian.ziemba@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix missing memory barriers in rxe_queue.h
Date:   Tue, 14 Feb 2023 01:10:54 -0600
Message-Id: <20230214071053.5395-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

An earlier patch which introduced smp_load_acquire/smp_store_release
into rxe_queue.h incorrectly assumed that surrounding spin-locks in
rxe_verbs.c around queue updates for kernel ulps was sufficient to
protect the passing of data through the queues between the ulp and
the rxe tasklets. But this was incorrect. The typical sequence was

	ulp				rxe requester tasklet
	------------------------	---------------------
	spin_lock_irqsave()		wqe = queue_head(queue)
	if (!queue_full(q)) {		if (!wqe)
		spin_unlock_irqrestore		return;
		return -ENOMEM
	}				<process wqe>
	wqe = queue_producer_addr(q)
	<fill in wqe>			queue_advance_consumer(queue)
	queue_advance_producer(q)
	spin_unlock_irqrestore()

queue_head() calls queue_empty() which calls smp_load_acquire()
For user space apps queue_advance_producer() calls smp_store_release()
so that there is a memory barrier between the producer and the
consumer but for kernel ulps queue_advance_produce() just incremented
the producer index because the lock function is a release function.
But to work the barrier has to come between filling in the wqe and
updating the producer index. This patch adds the missing barriers.
It also changes the enum names for the ulp queue types to
	QUEUE_TYPE_FROM/TO_ULP instead of QUEUE_TYPE_TO/FROM_DRIVER
which is very ambiguous. This bug is suspected as the cause of very
rare lockups in a very high scale storage application. It is a bug
in any case and should be corrected.

Fixes: 0a67c46d2e99 ("RDMA/rxe: Protect user space index loads/stores")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_queue.h | 108 ++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  20 ++---
 2 files changed, 76 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index ed44042782fa..c711cb98b949 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -35,19 +35,26 @@
 /**
  * enum queue_type - type of queue
  * @QUEUE_TYPE_TO_CLIENT:	Queue is written by rxe driver and
- *				read by client. Used by rxe driver only.
+ *				read by client which may be a user space
+ *				application or a kernel ulp.
+ *				Used by rxe internals only.
  * @QUEUE_TYPE_FROM_CLIENT:	Queue is written by client and
- *				read by rxe driver. Used by rxe driver only.
- * @QUEUE_TYPE_TO_DRIVER:	Queue is written by client and
- *				read by rxe driver. Used by kernel client only.
- * @QUEUE_TYPE_FROM_DRIVER:	Queue is written by rxe driver and
- *				read by client. Used by kernel client only.
+ *				read by rxe driver.
+ *				Used by rxe internals only.
+ * @QUEUE_TYPE_FROM_ULP:	Queue is written by kernel ulp and
+ *				read by rxe driver.
+ *				Used by kernel verbs APIs only on
+ *				behalf of ulps.
+ * @QUEUE_TYPE_TO_ULP:		Queue is written by rxe driver and
+ *				read by kernel ulp.
+ *				Used by kernel verbs APIs only on
+ *				behalf of ulps.
  */
 enum queue_type {
 	QUEUE_TYPE_TO_CLIENT,
 	QUEUE_TYPE_FROM_CLIENT,
-	QUEUE_TYPE_TO_DRIVER,
-	QUEUE_TYPE_FROM_DRIVER,
+	QUEUE_TYPE_FROM_ULP,
+	QUEUE_TYPE_TO_ULP,
 };
 
 struct rxe_queue_buf;
@@ -62,9 +69,9 @@ struct rxe_queue {
 	u32			index_mask;
 	enum queue_type		type;
 	/* private copy of index for shared queues between
-	 * kernel space and user space. Kernel reads and writes
+	 * driver and clients. Driver reads and writes
 	 * this copy and then replicates to rxe_queue_buf
-	 * for read access by user space.
+	 * for read access by clients.
 	 */
 	u32			index;
 };
@@ -97,19 +104,21 @@ static inline u32 queue_get_producer(const struct rxe_queue *q,
 
 	switch (type) {
 	case QUEUE_TYPE_FROM_CLIENT:
-		/* protect user index */
+		/* used by rxe, client owns the index */
 		prod = smp_load_acquire(&q->buf->producer_index);
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
+		/* used by rxe which owns the index */
 		prod = q->index;
 		break;
-	case QUEUE_TYPE_FROM_DRIVER:
-		/* protect driver index */
-		prod = smp_load_acquire(&q->buf->producer_index);
-		break;
-	case QUEUE_TYPE_TO_DRIVER:
+	case QUEUE_TYPE_FROM_ULP:
+		/* used by ulp which owns the index */
 		prod = q->buf->producer_index;
 		break;
+	case QUEUE_TYPE_TO_ULP:
+		/* used by ulp, rxe owns the index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+		break;
 	}
 
 	return prod;
@@ -122,19 +131,21 @@ static inline u32 queue_get_consumer(const struct rxe_queue *q,
 
 	switch (type) {
 	case QUEUE_TYPE_FROM_CLIENT:
+		/* used by rxe which owns the index */
 		cons = q->index;
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
-		/* protect user index */
+		/* used by rxe, client owns the index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
-	case QUEUE_TYPE_FROM_DRIVER:
-		cons = q->buf->consumer_index;
-		break;
-	case QUEUE_TYPE_TO_DRIVER:
-		/* protect driver index */
+	case QUEUE_TYPE_FROM_ULP:
+		/* used by ulp, rxe owns the index */
 		cons = smp_load_acquire(&q->buf->consumer_index);
 		break;
+	case QUEUE_TYPE_TO_ULP:
+		/* used by ulp which owns the index */
+		cons = q->buf->consumer_index;
+		break;
 	}
 
 	return cons;
@@ -172,24 +183,31 @@ static inline void queue_advance_producer(struct rxe_queue *q,
 
 	switch (type) {
 	case QUEUE_TYPE_FROM_CLIENT:
-		pr_warn("%s: attempt to advance client index\n",
-			__func__);
+		/* used by rxe, client owns the index */
+		if (WARN_ON(1))
+			pr_warn("%s: attempt to advance client index\n",
+				__func__);
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
+		/* used by rxe which owns the index */
 		prod = q->index;
 		prod = (prod + 1) & q->index_mask;
 		q->index = prod;
-		/* protect user index */
+		/* release so client can read it safely */
 		smp_store_release(&q->buf->producer_index, prod);
 		break;
-	case QUEUE_TYPE_FROM_DRIVER:
-		pr_warn("%s: attempt to advance driver index\n",
-			__func__);
-		break;
-	case QUEUE_TYPE_TO_DRIVER:
+	case QUEUE_TYPE_FROM_ULP:
+		/* used by ulp which owns the index */
 		prod = q->buf->producer_index;
 		prod = (prod + 1) & q->index_mask;
-		q->buf->producer_index = prod;
+		/* release so rxe can read it safely */
+		smp_store_release(&q->buf->producer_index, prod);
+		break;
+	case QUEUE_TYPE_TO_ULP:
+		/* used by ulp, rxe owns the index */
+		if (WARN_ON(1))
+			pr_warn("%s: attempt to advance driver index\n",
+				__func__);
 		break;
 	}
 }
@@ -201,24 +219,30 @@ static inline void queue_advance_consumer(struct rxe_queue *q,
 
 	switch (type) {
 	case QUEUE_TYPE_FROM_CLIENT:
-		cons = q->index;
-		cons = (cons + 1) & q->index_mask;
+		/* used by rxe which owns the index */
+		cons = (q->index + 1) & q->index_mask;
 		q->index = cons;
-		/* protect user index */
+		/* release so client can read it safely */
 		smp_store_release(&q->buf->consumer_index, cons);
 		break;
 	case QUEUE_TYPE_TO_CLIENT:
-		pr_warn("%s: attempt to advance client index\n",
-			__func__);
+		/* used by rxe, client owns the index */
+		if (WARN_ON(1))
+			pr_warn("%s: attempt to advance client index\n",
+				__func__);
+		break;
+	case QUEUE_TYPE_FROM_ULP:
+		/* used by ulp, rxe owns the index */
+		if (WARN_ON(1))
+			pr_warn("%s: attempt to advance driver index\n",
+				__func__);
 		break;
-	case QUEUE_TYPE_FROM_DRIVER:
+	case QUEUE_TYPE_TO_ULP:
+		/* used by ulp which owns the index */
 		cons = q->buf->consumer_index;
 		cons = (cons + 1) & q->index_mask;
-		q->buf->consumer_index = cons;
-		break;
-	case QUEUE_TYPE_TO_DRIVER:
-		pr_warn("%s: attempt to advance driver index\n",
-			__func__);
+		/* release so rxe can read it safely */
+		smp_store_release(&q->buf->consumer_index, cons);
 		break;
 	}
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index b3ddc8dac3a3..e14050a69276 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -245,7 +245,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	int num_sge = ibwr->num_sge;
 	int full;
 
-	full = queue_full(rq->queue, QUEUE_TYPE_TO_DRIVER);
+	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
 	if (unlikely(full))
 		return -ENOMEM;
 
@@ -256,7 +256,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	for (i = 0; i < num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	recv_wqe = queue_producer_addr(rq->queue, QUEUE_TYPE_TO_DRIVER);
+	recv_wqe = queue_producer_addr(rq->queue, QUEUE_TYPE_FROM_ULP);
 	recv_wqe->wr_id = ibwr->wr_id;
 
 	memcpy(recv_wqe->dma.sge, ibwr->sg_list,
@@ -268,7 +268,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	recv_wqe->dma.cur_sge		= 0;
 	recv_wqe->dma.sge_offset	= 0;
 
-	queue_advance_producer(rq->queue, QUEUE_TYPE_TO_DRIVER);
+	queue_advance_producer(rq->queue, QUEUE_TYPE_FROM_ULP);
 
 	return 0;
 }
@@ -623,17 +623,17 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	spin_lock_irqsave(&qp->sq.sq_lock, flags);
 
-	full = queue_full(sq->queue, QUEUE_TYPE_TO_DRIVER);
+	full = queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
 
 	if (unlikely(full)) {
 		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 		return -ENOMEM;
 	}
 
-	send_wqe = queue_producer_addr(sq->queue, QUEUE_TYPE_TO_DRIVER);
+	send_wqe = queue_producer_addr(sq->queue, QUEUE_TYPE_FROM_ULP);
 	init_send_wqe(qp, ibwr, mask, length, send_wqe);
 
-	queue_advance_producer(sq->queue, QUEUE_TYPE_TO_DRIVER);
+	queue_advance_producer(sq->queue, QUEUE_TYPE_FROM_ULP);
 
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
@@ -821,12 +821,12 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	for (i = 0; i < num_entries; i++) {
-		cqe = queue_head(cq->queue, QUEUE_TYPE_FROM_DRIVER);
+		cqe = queue_head(cq->queue, QUEUE_TYPE_TO_ULP);
 		if (!cqe)
 			break;
 
 		memcpy(wc++, &cqe->ibwc, sizeof(*wc));
-		queue_advance_consumer(cq->queue, QUEUE_TYPE_FROM_DRIVER);
+		queue_advance_consumer(cq->queue, QUEUE_TYPE_TO_ULP);
 	}
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
@@ -838,7 +838,7 @@ static int rxe_peek_cq(struct ib_cq *ibcq, int wc_cnt)
 	struct rxe_cq *cq = to_rcq(ibcq);
 	int count;
 
-	count = queue_count(cq->queue, QUEUE_TYPE_FROM_DRIVER);
+	count = queue_count(cq->queue, QUEUE_TYPE_TO_ULP);
 
 	return (count > wc_cnt) ? wc_cnt : count;
 }
@@ -854,7 +854,7 @@ static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
 	if (cq->notify != IB_CQ_NEXT_COMP)
 		cq->notify = flags & IB_CQ_SOLICITED_MASK;
 
-	empty = queue_empty(cq->queue, QUEUE_TYPE_FROM_DRIVER);
+	empty = queue_empty(cq->queue, QUEUE_TYPE_TO_ULP);
 
 	if ((flags & IB_CQ_REPORT_MISSED_EVENTS) && !empty)
 		ret = 1;

base-commit: 1362eb8db8a287b5aa053f5da67733159ec13cc4
-- 
2.37.2

