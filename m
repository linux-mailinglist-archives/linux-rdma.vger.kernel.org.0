Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A0390FD3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 06:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhEZEzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 00:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhEZEy4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 00:54:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F62C061756
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 21:52:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v22so358020oic.2
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCQmoXiRdmZr93449+4D6oWg487TgdyZgirsJzAaqUE=;
        b=nAaL+NuSNdgjFpeuLx6zheHsieOmGzDrajfVtt1BM80x9ZrEfr2tzYd+NOFBrIvy2E
         zqYgWbDJiVHCaxuJxYm7b/yIYw6bNybOMNThtynZ8VQmUlZZLxgjFGINSaLwnfOCTllx
         Wes7UzpKpKKZogWt9qSH1OxIb7LW5fYE95+ybDwwhLzp977lHwm4fh5N364qk7CvKegt
         wcaQ1PD+Y1z/+vmWxdZpOSjZcGgOetg2aEgrsexfDEtwx2XF5runnLpOi1W2t8RmIVio
         yw/xc556lfzSdLZPVajnCDc9eQormtIis649TN5CZMvloBBGi1LdeGcgAovZuUse6YfT
         tZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCQmoXiRdmZr93449+4D6oWg487TgdyZgirsJzAaqUE=;
        b=N4JPZ2pmNi3gY6ixRA8fJdbLVD9aE0NAhoaqj1/sVxs2BY+iAP1KDwOEUtYWGPixp8
         mTu53wQUpOeW6bxji98XfHYv2PV4aY9YGCB1Fw7+YHHfN6IowA8oGgR6smEMTAVd7ynW
         XUcoX0zmUt0pL0BrNZdilZRmQsNgqApQzIRhIXlvHO8I3mYiC0im/GKjdgnkr6D3xqk3
         We38Uk2/6Nrwg8Nc2NbJJry1/pZHYAmmlZCP0mDlU9q1kbpKulFeTlEGmRu763FkwW7F
         PXZhbQ4Fz+vYUvOC1/BFVT5TzQudHiZfax3yD9JqPFJ4KsRij9NZsn5yczgX5wbeeX0m
         ooLA==
X-Gm-Message-State: AOAM532x34mJqCdNEfhgo46xLTef1/UcL4E7V23kQowcy2Wf35ZCtrr/
        MbhqtX7wc7LQf59EdW6yTqvETczej5Vopg==
X-Google-Smtp-Source: ABdhPJy31k5kMyQTgQGpnKgUIXaaj5DwDBLo1lJo7oylBxXXyTlkSfgTztebFZaJdgAMyo6YalCBhQ==
X-Received: by 2002:a54:4594:: with SMTP id z20mr652795oib.100.1622004741918;
        Tue, 25 May 2021 21:52:21 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a858-04cc-9df4-eb0d.res6.spectrum.com. [2603:8081:140c:1a00:a858:4cc:9df4:eb0d])
        by smtp.gmail.com with ESMTPSA id x5sm4093292otg.76.2021.05.25.21.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 21:52:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/2] RDMA/rxe: Add a type flag to rxe_queue structs
Date:   Tue, 25 May 2021 23:51:39 -0500
Message-Id: <20210526045139.634978-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210526045139.634978-1-rpearsonhpe@gmail.com>
References: <20210526045139.634978-1-rpearsonhpe@gmail.com>
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
v2:
  This patch added in v2 to add the type field.
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

