Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF5390FD4
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 06:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhEZEzB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 00:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEZEyy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 00:54:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272EC06175F
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 21:52:23 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so6537633otl.3
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 21:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+3RAKsMXrhAs6qVSYob13c/f8h3lLGknkxrAdTz4KA=;
        b=bJU7SU+OUDHcX2AOpDF4VExc+xU9fcZtaxdvoLdzvZZtdenWl8NVLuNbMwWpSgvYxj
         0auLGU/htYHRYIiB4zws3f5a1HohpT0HsJitUjQJVl2MIj8yrxE4Ndk30SWaZkwf699K
         4ZDD2bbVFy+g6IZfcoTSgRNUPeKdfF1XDFP4bKDZUQHTVzDDoy/RMbsAYoRULvS3ExWc
         4OaojN8eGzaICVnRGvWh2I62EXe8jgtwc2/BturRneb5YO7gy1wOs6gpBk0vQV0OO8AE
         XzbPrSW6S6Hxf/0dxoP9iYivG4TLxrCyrGdwWBOxWM3AVwCMdDGy6uOYnDBhk5yIa+ac
         vaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+3RAKsMXrhAs6qVSYob13c/f8h3lLGknkxrAdTz4KA=;
        b=rUeV6yoOX6+RI3swsvkQ3M+KCgf2jIAyvg1d0dEOAh7Zyvv/eqdgDytV2b9oyx/8J+
         sArGurs8q2rV5yTofSNnh3mJKc1RWz6bUPeetEFjJHklVxuHaCINVgDY5PmnRDNFSKIZ
         qR3MldH0lnOZ+qv5myic5y3N13ZcclFh1Qe/j6d6cQU3HxWnt+ciEHRgnUlyq3IlJ1qb
         7gz8Gd7uK+vYgvG4xYIEnuMeHirComQkCgqzlCS4n0u4n+LUP51CibHSCt74W5QR1THc
         49u6XiF/y9TwWdo9eHux4+NnNKUDo97aqyK9hiZiqhELYiSchxhpffI5D/lKUfAc6z7s
         anlQ==
X-Gm-Message-State: AOAM533rE5d3/FX8Ggnw5rUhM8ylVqrUAjCJhGgFwm0zGcxx10NRCNV6
        tfHHnQLFgCJrELaCDjz8p9o=
X-Google-Smtp-Source: ABdhPJyAc00w/6EVLpBR5yWqOSQVf6vL/6mC6PeD/lA4rogtdzjxrzDcG80RzWUtcWmpzbmvbbUhuw==
X-Received: by 2002:a9d:6944:: with SMTP id p4mr878279oto.157.1622004742708;
        Tue, 25 May 2021 21:52:22 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a858-04cc-9df4-eb0d.res6.spectrum.com. [2603:8081:140c:1a00:a858:4cc:9df4:eb0d])
        by smtp.gmail.com with ESMTPSA id t26sm4233958otc.23.2021.05.25.21.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 21:52:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/2] RDMA/rxe: Protect user space index loads/stores
Date:   Tue, 25 May 2021 23:51:40 -0500
Message-Id: <20210526045139.634978-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526045139.634978-1-rpearsonhpe@gmail.com>
References: <20210526045139.634978-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify the queue APIs to protect all user space index loads
with smp_load_acquire() and all user space index stores with
smp_store_release(). Base this on the types of the queues which
can be one of ..KERNEL, ..FROM_USER, ..TO_USER. Kernel space
indices are protected by locks which also provide memory barriers.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  In v2 use queue type to selectively protect user space indices.
---
 drivers/infiniband/sw/rxe/rxe_queue.h | 168 ++++++++++++++++++--------
 1 file changed, 117 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 4512745419f8..6e705e09d357 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -66,12 +66,22 @@ static inline int queue_empty(struct rxe_queue *q)
 	u32 prod;
 	u32 cons;
 
-	/* make sure all changes to queue complete before
-	 * testing queue empty
-	 */
-	prod = smp_load_acquire(&q->buf->producer_index);
-	/* same */
-	cons = smp_load_acquire(&q->buf->consumer_index);
+	switch (q->type) {
+	case QUEUE_TYPE_FROM_USER:
+		/* protect user space index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+		cons = q->buf->consumer_index;
+		break;
+	case QUEUE_TYPE_TO_USER:
+		prod = q->buf->producer_index;
+		/* protect user space index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+		break;
+	case QUEUE_TYPE_KERNEL:
+		prod = q->buf->producer_index;
+		cons = q->buf->consumer_index;
+		break;
+	}
 
 	return ((prod - cons) & q->index_mask) == 0;
 }
@@ -81,95 +91,151 @@ static inline int queue_full(struct rxe_queue *q)
 	u32 prod;
 	u32 cons;
 
-	/* make sure all changes to queue complete before
-	 * testing queue full
-	 */
-	prod = smp_load_acquire(&q->buf->producer_index);
-	/* same */
-	cons = smp_load_acquire(&q->buf->consumer_index);
+	switch (q->type) {
+	case QUEUE_TYPE_FROM_USER:
+		/* protect user space index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+		cons = q->buf->consumer_index;
+		break;
+	case QUEUE_TYPE_TO_USER:
+		prod = q->buf->producer_index;
+		/* protect user space index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+		break;
+	case QUEUE_TYPE_KERNEL:
+		prod = q->buf->producer_index;
+		cons = q->buf->consumer_index;
+		break;
+	}
 
 	return ((prod + 1 - cons) & q->index_mask) == 0;
 }
 
-static inline void advance_producer(struct rxe_queue *q)
+static inline unsigned int queue_count(const struct rxe_queue *q)
 {
 	u32 prod;
+	u32 cons;
 
-	prod = (q->buf->producer_index + 1) & q->index_mask;
+	switch (q->type) {
+	case QUEUE_TYPE_FROM_USER:
+		/* protect user space index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+		cons = q->buf->consumer_index;
+		break;
+	case QUEUE_TYPE_TO_USER:
+		prod = q->buf->producer_index;
+		/* protect user space index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+		break;
+	case QUEUE_TYPE_KERNEL:
+		prod = q->buf->producer_index;
+		cons = q->buf->consumer_index;
+		break;
+	}
+
+	return (prod - cons) & q->index_mask;
+}
+
+static inline void advance_producer(struct rxe_queue *q)
+{
+	u32 prod;
 
-	/* make sure all changes to queue complete before
-	 * changing producer index
-	 */
-	smp_store_release(&q->buf->producer_index, prod);
+	if (q->type == QUEUE_TYPE_FROM_USER) {
+		/* protect user space index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+		prod = (prod + 1) & q->index_mask;
+		/* same */
+		smp_store_release(&q->buf->producer_index, prod);
+	} else {
+		prod = q->buf->producer_index;
+		q->buf->producer_index = (prod + 1) & q->index_mask;
+	}
 }
 
 static inline void advance_consumer(struct rxe_queue *q)
 {
 	u32 cons;
 
-	cons = (q->buf->consumer_index + 1) & q->index_mask;
-
-	/* make sure all changes to queue complete before
-	 * changing consumer index
-	 */
-	smp_store_release(&q->buf->consumer_index, cons);
+	if (q->type == QUEUE_TYPE_TO_USER) {
+		/* protect user space index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+		cons = (cons + 1) & q->index_mask;
+		/* same */
+		smp_store_release(&q->buf->consumer_index, cons);
+	} else {
+		cons = q->buf->consumer_index;
+		q->buf->consumer_index = (cons + 1) & q->index_mask;
+	}
 }
 
 static inline void *producer_addr(struct rxe_queue *q)
 {
-	return q->buf->data + ((q->buf->producer_index & q->index_mask)
-				<< q->log2_elem_size);
+	u32 prod;
+
+	if (q->type == QUEUE_TYPE_FROM_USER)
+		/* protect user space index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+	else
+		prod = q->buf->producer_index;
+
+	return q->buf->data + ((prod & q->index_mask) << q->log2_elem_size);
 }
 
 static inline void *consumer_addr(struct rxe_queue *q)
 {
-	return q->buf->data + ((q->buf->consumer_index & q->index_mask)
-				<< q->log2_elem_size);
+	u32 cons;
+
+	if (q->type == QUEUE_TYPE_TO_USER)
+		/* protect user space index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+	else
+		cons = q->buf->consumer_index;
+
+	return q->buf->data + ((cons & q->index_mask) << q->log2_elem_size);
 }
 
 static inline unsigned int producer_index(struct rxe_queue *q)
 {
-	u32 index;
+	u32 prod;
+
+	if (q->type == QUEUE_TYPE_FROM_USER)
+		/* protect user space index */
+		prod = smp_load_acquire(&q->buf->producer_index);
+	else
+		prod = q->buf->producer_index;
 
-	/* make sure all changes to queue
-	 * complete before getting producer index
-	 */
-	index = smp_load_acquire(&q->buf->producer_index);
-	index &= q->index_mask;
+	prod &= q->index_mask;
 
-	return index;
+	return prod;
 }
 
 static inline unsigned int consumer_index(struct rxe_queue *q)
 {
-	u32 index;
+	u32 cons;
 
-	/* make sure all changes to queue
-	 * complete before getting consumer index
-	 */
-	index = smp_load_acquire(&q->buf->consumer_index);
-	index &= q->index_mask;
+	if (q->type == QUEUE_TYPE_TO_USER)
+		/* protect user space index */
+		cons = smp_load_acquire(&q->buf->consumer_index);
+	else
+		cons = q->buf->consumer_index;
 
-	return index;
+	cons &= q->index_mask;
+
+	return cons;
 }
 
-static inline void *addr_from_index(struct rxe_queue *q, unsigned int index)
+static inline void *addr_from_index(struct rxe_queue *q,
+				unsigned int index)
 {
 	return q->buf->data + ((index & q->index_mask)
 				<< q->buf->log2_elem_size);
 }
 
 static inline unsigned int index_from_addr(const struct rxe_queue *q,
-					   const void *addr)
+				const void *addr)
 {
 	return (((u8 *)addr - q->buf->data) >> q->log2_elem_size)
-		& q->index_mask;
-}
-
-static inline unsigned int queue_count(const struct rxe_queue *q)
-{
-	return (q->buf->producer_index - q->buf->consumer_index)
-		& q->index_mask;
+				& q->index_mask;
 }
 
 static inline void *queue_head(struct rxe_queue *q)
-- 
2.30.2

