Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E3F2D63F6
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 18:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392031AbgLJRrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 12:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392914AbgLJRrK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 12:47:10 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF1BC0613D6
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 09:46:29 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id o11so5677296ote.4
        for <linux-rdma@vger.kernel.org>; Thu, 10 Dec 2020 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8k2Y6/Lh2y+Dzs/feqtDWzrRnjTqxnC+Yo6ftaLiYlc=;
        b=SOKGOMKucL90wD5OzGbewPUu+GcsBKicApgLkRwPDW6oRb1epoNBBxAm3VP8DJmVRX
         P5aDyob2gOup4+E87dkwC9XMvA/QaOQUX5ajz3KbZAUN8JjTpFSkQxrbRgNen0H/ZHao
         8LCesd/+Q7c8m2XpQ5iBgYNgEw/kvHH9annHJ/YA/S8NhXUJaT3io3PsUnenVyltNK7N
         Nb8VcC5Toc/dllCScgUe7mxJW8qjEdoRuFUrLI5StDDVxl93nYHEkjM8ySOICMWilYDY
         xRo7fJog0VH1zzvkKkOHWd5tsx6N3Uq9rZAVN+xUdGtTkFfsgWmMMFV+pfXScBb0IPmQ
         FRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8k2Y6/Lh2y+Dzs/feqtDWzrRnjTqxnC+Yo6ftaLiYlc=;
        b=Qquc7cOBZ3dgUwAzPSm4mVfymSe1064cwOmuhxv3VxBmDghrr7r7xeU4tspIzpiuMB
         3GjW3sqJdhLRUsTcwpZv6Qj5M/vGLZbaKRaeYLbK00OI90fkO5+YaDWOrN0kYhdmHN2s
         QWQkDaw/6oaA8ZejU1dqW7XYXjFty49pUO/XykFvmL2YPBeTazcDu/bkdl+c08dcX7cH
         EmZfP8JL9f9t1ctqMit41JeDcIeIziIqUnlttiJSZf73Hy2APksva2saUgjYfjYuRNgT
         cv56BeDZbMvclWdIbRJlJUmj75A27AEddX9QapxHjOQaPG4AyBJW/X8u+HQSelpBx/fw
         eaSQ==
X-Gm-Message-State: AOAM533N7Uz1s6Idd1rYbLvQRox/W65zJs4V71OPRBIfGUj8E3AW1l6m
        FGRjnB1DqFkVmEhU8A9QLCF8OHlfJyQ=
X-Google-Smtp-Source: ABdhPJyC1tdHduC0x3c55SK7zFC/KE9eeIVgc3vY1iWSHOnPRF0VC5NEBMU2EgKJizfTrfiFmqja4Q==
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr7041892otc.114.1607622389061;
        Thu, 10 Dec 2020 09:46:29 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f558-d5e5-8ab9-02b7.res6.spectrum.com. [2603:8081:140c:1a00:f558:d5e5:8ab9:2b7])
        by smtp.gmail.com with ESMTPSA id s26sm1220790otd.8.2020.12.10.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:46:28 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2] RDMA/rxe: Use acquire/release for memory ordering
Date:   Thu, 10 Dec 2020 11:42:59 -0600
Message-Id: <20201210174258.5234-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changed work and completion queues to use smp_load_acquire() and
smp_store_release() to synchronize between driver and users.
This commit goes with a matching series of commits in the rxe user
space provider.

v2: Addressed same issue for kernel ULPs which use rxe_post_send/recv().

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  5 --
 drivers/infiniband/sw/rxe/rxe_queue.h | 94 +++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 ----
 include/uapi/rdma/rdma_user_rxe.h     | 21 ++++++
 4 files changed, 81 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 43394c3f29d4..b315ebf041ac 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -123,11 +123,6 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	memcpy(producer_addr(cq->queue), cqe, sizeof(*cqe));
 
-	/* make sure all changes to the CQ are written before we update the
-	 * producer pointer
-	 */
-	smp_wmb();
-
 	advance_producer(cq->queue);
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 7d434a6837a7..2902ca7b288c 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -7,9 +7,11 @@
 #ifndef RXE_QUEUE_H
 #define RXE_QUEUE_H
 
+/* for definition of shared struct rxe_queue_buf */
+#include <uapi/rdma/rdma_user_rxe.h>
+
 /* implements a simple circular buffer that can optionally be
  * shared between user space and the kernel and can be resized
-
  * the requested element size is rounded up to a power of 2
  * and the number of elements in the buffer is also rounded
  * up to a power of 2. Since the queue is empty when the
@@ -17,28 +19,6 @@
  * of the queue is one less than the number of element slots
  */
 
-/* this data structure is shared between user space and kernel
- * space for those cases where the queue is shared. It contains
- * the producer and consumer indices. Is also contains a copy
- * of the queue size parameters for user space to use but the
- * kernel must use the parameters in the rxe_queue struct
- * this MUST MATCH the corresponding librxe struct
- * for performance reasons arrange to have producer and consumer
- * pointers in separate cache lines
- * the kernel should always mask the indices to avoid accessing
- * memory outside of the data area
- */
-struct rxe_queue_buf {
-	__u32			log2_elem_size;
-	__u32			index_mask;
-	__u32			pad_1[30];
-	__u32			producer_index;
-	__u32			pad_2[31];
-	__u32			consumer_index;
-	__u32			pad_3[31];
-	__u8			data[];
-};
-
 struct rxe_queue {
 	struct rxe_dev		*rxe;
 	struct rxe_queue_buf	*buf;
@@ -46,7 +26,7 @@ struct rxe_queue {
 	size_t			buf_size;
 	size_t			elem_size;
 	unsigned int		log2_elem_size;
-	unsigned int		index_mask;
+	u32			index_mask;
 };
 
 int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
@@ -76,26 +56,56 @@ static inline int next_index(struct rxe_queue *q, int index)
 
 static inline int queue_empty(struct rxe_queue *q)
 {
-	return ((q->buf->producer_index - q->buf->consumer_index)
-			& q->index_mask) == 0;
+	u32 prod;
+	u32 cons;
+
+	/* make sure all changes to queue complete before
+	 * testing queue empty
+	 */
+	prod = smp_load_acquire(&q->buf->producer_index);
+	/* same */
+	cons = smp_load_acquire(&q->buf->consumer_index);
+
+	return ((prod - cons) & q->index_mask) == 0;
 }
 
 static inline int queue_full(struct rxe_queue *q)
 {
-	return ((q->buf->producer_index + 1 - q->buf->consumer_index)
-			& q->index_mask) == 0;
+	u32 prod;
+	u32 cons;
+
+	/* make sure all changes to queue complete before
+	 * testing queue full
+	 */
+	prod = smp_load_acquire(&q->buf->producer_index);
+	/* same */
+	cons = smp_load_acquire(&q->buf->consumer_index);
+
+	return ((prod + 1 - cons) & q->index_mask) == 0;
 }
 
 static inline void advance_producer(struct rxe_queue *q)
 {
-	q->buf->producer_index = (q->buf->producer_index + 1)
-			& q->index_mask;
+	u32 prod;
+
+	prod = (q->buf->producer_index + 1) & q->index_mask;
+
+	/* make sure all changes to queue complete before
+	 * changing producer index
+	 */
+	smp_store_release(&q->buf->producer_index, prod);
 }
 
 static inline void advance_consumer(struct rxe_queue *q)
 {
-	q->buf->consumer_index = (q->buf->consumer_index + 1)
-			& q->index_mask;
+	u32 cons;
+
+	cons = (q->buf->consumer_index + 1) & q->index_mask;
+
+	/* make sure all changes to queue complete before
+	 * changing consumer index
+	 */
+	smp_store_release(&q->buf->consumer_index, cons);
 }
 
 static inline void *producer_addr(struct rxe_queue *q)
@@ -112,12 +122,28 @@ static inline void *consumer_addr(struct rxe_queue *q)
 
 static inline unsigned int producer_index(struct rxe_queue *q)
 {
-	return q->buf->producer_index;
+	u32 index;
+
+	/* make sure all changes to queue
+	 * complete before getting producer index
+	 */
+	index = smp_load_acquire(&q->buf->producer_index);
+	index &= q->index_mask;
+
+	return index;
 }
 
 static inline unsigned int consumer_index(struct rxe_queue *q)
 {
-	return q->buf->consumer_index;
+	u32 index;
+
+	/* make sure all changes to queue
+	 * complete before getting consumer index
+	 */
+	index = smp_load_acquire(&q->buf->consumer_index);
+	index &= q->index_mask;
+
+	return index;
 }
 
 static inline void *addr_from_index(struct rxe_queue *q, unsigned int index)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 2fbea2b2d72a..a031514e2f41 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -244,11 +244,6 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	recv_wqe->dma.cur_sge		= 0;
 	recv_wqe->dma.sge_offset	= 0;
 
-	/* make sure all changes to the work queue are written before we
-	 * update the producer pointer
-	 */
-	smp_wmb();
-
 	advance_producer(rq->queue);
 	return 0;
 
@@ -633,12 +628,6 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	if (unlikely(err))
 		goto err1;
 
-	/*
-	 * make sure all changes to the work queue are
-	 * written before we update the producer pointer
-	 */
-	smp_wmb();
-
 	advance_producer(sq->queue);
 	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index e591d8c1f3cf..068433e2229d 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -181,4 +181,25 @@ struct rxe_modify_srq_cmd {
 	__aligned_u64 mmap_info_addr;
 };
 
+/* This data structure is stored at the base of work and
+ * completion queues shared between user space and kernel space.
+ * It contains the producer and consumer indices. Is also
+ * contains a copy of the queue size parameters for user space
+ * to use but the kernel must use the parameters in the
+ * rxe_queue struct. For performance reasons arrange to have
+ * producer and consumer indices in separate cache lines
+ * the kernel should always mask the indices to avoid accessing
+ * memory outside of the data area
+ */
+struct rxe_queue_buf {
+	__u32			log2_elem_size;
+	__u32			index_mask;
+	__u32			pad_1[30];
+	__u32			producer_index;
+	__u32			pad_2[31];
+	__u32			consumer_index;
+	__u32			pad_3[31];
+	__u8			data[];
+};
+
 #endif /* RDMA_USER_RXE_H */
-- 
2.27.0

