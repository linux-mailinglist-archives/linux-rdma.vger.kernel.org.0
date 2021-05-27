Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C180639369D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhE0Tta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhE0Tt3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 15:49:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF5C061574
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:56 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so1304306otc.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/ZZs2UwjDjOD1moTiHpnQb1QJoTurjL9+h0iGRp+38=;
        b=RUY0lFQjMIrlvZjFq1MolwW2Sk0eAXuRgyGTPPOHlOVop1uAa4acvSMOVlAw6g3F78
         roSv4Cd7tK28EkljLEtGo4UpL7si/M+Gv04ngsvLjCDSovhHmWvYcxjPJ86HbbL97dPy
         6f+mJbo9GshE4ecEERk+sCZV0zxrpArfjSep+POLufjSr4V5w1lxIxWiQtwlLgkzWNg7
         +M1Lsy0nChEFQsErkLweZnNiaXzhFSawY3AXRJvWujo30CabaWGTkmLtDuTx1ZbswLjK
         pL/j5GKzTQN03sKl+YNIWG0rHwqh4+a6kTWV75DurZ2jdzryJguGQma3Xvj0U/x1mOC0
         ujHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/ZZs2UwjDjOD1moTiHpnQb1QJoTurjL9+h0iGRp+38=;
        b=BiUbJwDF0ZNEIaexsJwUyXSWbDIM+izMvNE9hp0o7Jda6SV7An3cCAL7EDL4/h06JR
         4md1DTPBDFr9gkyPzk+uo2ad4YXeiq8cCaDC/iS/tgiK8FmgksY7Cgxb0tpBET0ENoR7
         +adtLn74nNlhqDc+zcq8t13/dgmu4wIAtNQYjOKrP6sau/Asx7R+zWu3wEK+N6Xlc85/
         tM+gJtrwQdI0/c2ORr2XOxUqzEhvgU6FHIdtD6R+EVCELI7eTCe0kc99jvbvXILi8baD
         IVNKw4N5KMAQEK2R0Yfjj8afZ7BrV6piUudzXzQb4llx8VqEiMPA8StEQY4/jYmvj9Vy
         NZQA==
X-Gm-Message-State: AOAM530xCFnMi3bZon+kF50OO1KL1gQNtjIkFpuNf47r4PTlAaqO6dpI
        Nmb9wtI0Y8tshDOdsmcKpBI=
X-Google-Smtp-Source: ABdhPJx/v5MuP6LTdVDzQ13BtiBu4B0Jke+vCMKfmtB/fqSkbh03jT17QKBY3cjhf+XVG+swXiXemQ==
X-Received: by 2002:a05:6830:1013:: with SMTP id a19mr4052236otp.21.1622144875408;
        Thu, 27 May 2021 12:47:55 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-6d76-be96-2893-c13e.res6.spectrum.com. [2603:8081:140c:1a00:6d76:be96:2893:c13e])
        by smtp.gmail.com with ESMTPSA id x11sm670833otr.36.2021.05.27.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:47:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 2/3] RDMA/rxe: Protect user space index loads/stores
Date:   Thu, 27 May 2021 14:47:47 -0500
Message-Id: <20210527194748.662636-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527194748.662636-1-rpearsonhpe@gmail.com>
References: <20210527194748.662636-1-rpearsonhpe@gmail.com>
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

