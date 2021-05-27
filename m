Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDA39369E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 21:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhE0Ttb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 15:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhE0Tta (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 15:49:30 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36199C061760
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:55 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso1354919ote.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 May 2021 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RBMpE8M6i9bxS0cDKDYwoGBVazGOQcB7BLfItbhyKxY=;
        b=Dce2fxXtJ/Z6q3dQqLYmXEde7jiIZYpEQ32ucG7B/CqYXfzhFoRR6rjZP84tOjb//N
         uJlhxmE0vbM5hJJdYgvCS4j753BLyCQSe6PyOeDo68wQjhrmRlwXqxAVqcthr5Dd1RtJ
         b4/+RaMfhinlhOVoAeMhYTuWOw0V8H03sDr6Lf9jZ3sz/7AUupFeEmn0kdQFH75FdDms
         o67Fnahpr6W0yN8uQj7nKW1euQtGIReau55Ns0nWJSv2rRGBHxkdXd+YLAcE/V3dtWf+
         5ZAvAamOBFXVodycWk7j9inW+fLoPvKqkV3FE+bARtvnm4aSOJQPOQbQX6rTXV4KpGfU
         CSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RBMpE8M6i9bxS0cDKDYwoGBVazGOQcB7BLfItbhyKxY=;
        b=p3KKiqiR4qCAMygWABkvi1JZCGH/c6Gx20Gk60M/cqFPhCCE1FTgglMdZFtqOjvRqU
         ECN7jW5GDDaZXR3/NeIEUJCqOJHaaZN23DsssXiTFNFkl93EeyPfBuzV661Wb9JSRHI4
         GN4urcKeWGcpCxEykFjnopWeq1tdcLTPEhMTT4hO+JS2hFknp0kTf3FAtEhcHTqW/CG6
         ADY1jzIXePOlbfXGpufYCGLeZLJ4cOJx0o5DMAMwHWU4wU1uaOY/3q5kJXkdbO1i0Hvb
         wyaXeLVhCvMCykIWOT/PPoUmqp/hDDxk5xDHCC58hNt9qvQjT8orzVnvSydA9T0Ooy0W
         vf5Q==
X-Gm-Message-State: AOAM530Um8DWqjzT+IwdbUaV2NxKYGm6WCQOp8PJy8DuP0RIj+murFJW
        hWF9Lg/D/vGRjF9tzxClji4=
X-Google-Smtp-Source: ABdhPJz2lR2oJlFEsZ3CdKCDo2aDa3ovujqdtlDARlgAosutUeezfDc9MkDIp/UGM2kHYI2fN2yipw==
X-Received: by 2002:a05:6830:108a:: with SMTP id y10mr4015910oto.187.1622144874642;
        Thu, 27 May 2021 12:47:54 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-6d76-be96-2893-c13e.res6.spectrum.com. [2603:8081:140c:1a00:6d76:be96:2893:c13e])
        by smtp.gmail.com with ESMTPSA id d67sm643038oia.56.2021.05.27.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:47:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 1/3] RDMA/rxe: Add a type flag to rxe_queue structs
Date:   Thu, 27 May 2021 14:47:46 -0500
Message-Id: <20210527194748.662636-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210527194748.662636-1-rpearsonhpe@gmail.com>
References: <20210527194748.662636-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To create optimal code only want to use smp_load_acquire() and
smp_store_release() for user indices in rxe_queue APIs since
kernel indices are protected by locks which also act as memory
barriers. By adding a type to the queues we can determine which
indices need to be protected.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  4 +++-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 12 ++++++++----
 drivers/infiniband/sw/rxe/rxe_queue.c |  8 ++++----
 drivers/infiniband/sw/rxe/rxe_queue.h | 13 ++++++++++---
 drivers/infiniband/sw/rxe/rxe_srq.c   |  4 +++-
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index b315ebf041ac..1d4d8a31bc12 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -59,9 +59,11 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     struct rxe_create_cq_resp __user *uresp)
 {
 	int err;
+	enum queue_type type;
 
+	type = uresp ? QUEUE_TYPE_TO_USER : QUEUE_TYPE_KERNEL;
 	cq->queue = rxe_queue_init(rxe, &cqe,
-				   sizeof(struct rxe_cqe));
+			sizeof(struct rxe_cqe), type);
 	if (!cq->queue) {
 		pr_warn("unable to create cq\n");
 		return -ENOMEM;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 34ae957a315c..9bd6bf8f9bd9 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -206,6 +206,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 {
 	int err;
 	int wqe_size;
+	enum queue_type type;
 
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
@@ -231,7 +232,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
 	wqe_size += sizeof(struct rxe_send_wqe);
 
-	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size);
+	type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
+	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
+				wqe_size, type);
 	if (!qp->sq.queue)
 		return -ENOMEM;
 
@@ -273,6 +276,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 {
 	int err;
 	int wqe_size;
+	enum queue_type type;
 
 	if (!qp->srq) {
 		qp->rq.max_wr		= init->cap.max_recv_wr;
@@ -283,9 +287,9 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 		pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
 			 qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
 
-		qp->rq.queue = rxe_queue_init(rxe,
-					      &qp->rq.max_wr,
-					      wqe_size);
+		type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
+		qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
+					wqe_size, type);
 		if (!qp->rq.queue)
 			return -ENOMEM;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index fa69241b1187..8f844d0b9e77 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -52,9 +52,8 @@ inline void rxe_queue_reset(struct rxe_queue *q)
 	memset(q->buf->data, 0, q->buf_size - sizeof(struct rxe_queue_buf));
 }
 
-struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe,
-				 int *num_elem,
-				 unsigned int elem_size)
+struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
+			unsigned int elem_size, enum queue_type type)
 {
 	struct rxe_queue *q;
 	size_t buf_size;
@@ -69,6 +68,7 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe,
 		goto err1;
 
 	q->rxe = rxe;
+	q->type = type;
 
 	/* used in resize, only need to copy used part of queue */
 	q->elem_size = elem_size;
@@ -136,7 +136,7 @@ int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
 	int err;
 	unsigned long flags = 0, flags1;
 
-	new_q = rxe_queue_init(q->rxe, &num_elem, elem_size);
+	new_q = rxe_queue_init(q->rxe, &num_elem, elem_size, q->type);
 	if (!new_q)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 2902ca7b288c..4512745419f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -19,6 +19,13 @@
  * of the queue is one less than the number of element slots
  */
 
+/* type of queue */
+enum queue_type {
+	QUEUE_TYPE_KERNEL,
+	QUEUE_TYPE_TO_USER,
+	QUEUE_TYPE_FROM_USER,
+};
+
 struct rxe_queue {
 	struct rxe_dev		*rxe;
 	struct rxe_queue_buf	*buf;
@@ -27,6 +34,7 @@ struct rxe_queue {
 	size_t			elem_size;
 	unsigned int		log2_elem_size;
 	u32			index_mask;
+	enum queue_type		type;
 };
 
 int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
@@ -35,9 +43,8 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
 
 void rxe_queue_reset(struct rxe_queue *q);
 
-struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe,
-				 int *num_elem,
-				 unsigned int elem_size);
+struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
+			unsigned int elem_size, enum queue_type type);
 
 int rxe_queue_resize(struct rxe_queue *q, unsigned int *num_elem_p,
 		     unsigned int elem_size, struct ib_udata *udata,
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index 41b0d1e11baf..52c5593741ec 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -78,6 +78,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	int err;
 	int srq_wqe_size;
 	struct rxe_queue *q;
+	enum queue_type type;
 
 	srq->ibsrq.event_handler	= init->event_handler;
 	srq->ibsrq.srq_context		= init->srq_context;
@@ -91,8 +92,9 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	spin_lock_init(&srq->rq.producer_lock);
 	spin_lock_init(&srq->rq.consumer_lock);
 
+	type = uresp ? QUEUE_TYPE_FROM_USER : QUEUE_TYPE_KERNEL;
 	q = rxe_queue_init(rxe, &srq->rq.max_wr,
-			   srq_wqe_size);
+			srq_wqe_size, type);
 	if (!q) {
 		pr_warn("unable to allocate queue for srq\n");
 		return -ENOMEM;
-- 
2.30.2

