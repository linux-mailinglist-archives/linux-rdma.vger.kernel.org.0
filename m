Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC09A736DF9
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjFTNzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFTNzz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 09:55:55 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525709D
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:55:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39ca48cd4c6so3040984b6e.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687269352; x=1689861352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpJ3zW5W+VQqNHMOouMTtI43e8VFcdOhMUHhCH6t4DA=;
        b=A7+KjFnVs7+2agbove/t9+Qg3xzkmvFqmWosAwop6A9Nbj7CGRDAywwYKrgvwzc+Wx
         PLo9Pq9g6MQW2qEuogzuqSTfY71d3ER/6M0Sjyvy5PyjZ/BRjhmwUSyv/LJSHKtSS6CP
         Hkv171n/uI3oOTdB5Yr9ry0NHY86krPFXVZimAqe7nn/zBM044JU8atQIPk5moDIejNP
         l1ZN2fcdisRFIdH7vLyooLfr7MppcMB8hBkBoQk/z9/z6VsNOUzGF0LZw9PM018y+5Qf
         jZ4fXrFdceKA/RrUqLVY9klLz1XwcrUsBmi8zLftNrrhDPAYCgtiF2oNGWjb0uWnP2Vo
         rpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687269352; x=1689861352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpJ3zW5W+VQqNHMOouMTtI43e8VFcdOhMUHhCH6t4DA=;
        b=Fkwn4mQ8yRy7+o3aeRUyZpJrjvot7fsFaWk7p3+udP8j3cX4+OvPddJDL6sXSZXqJ1
         6V4vkh2/euYMdZlGRe/PB2i9SrGIx70+2jLRkLPnt/BeJ7kT7v/hKkXxHoOfEjOenGox
         UPJ8j9jA63XMokNGP3Wx0xksDyKW3L/ehTcniEia3I7MwsvrBIMZhk9myv1QncGQxfEV
         hcqslZ7Yb838xFgpHpKjwYsiJnRgj3Azs8NQ7WGQa3e7+AOW4u8As8gVNqvg83eVTj1J
         xph5a50bAF/LsafVKnCMnMqTpQ9OfimuP1QVMiN6lS6EwcEU5hNPI6rjQmGc0FXkJjsu
         Ow+Q==
X-Gm-Message-State: AC+VfDxNQ/eIu/N/CxSgnUXvEhBVIUra2QmiYuqUS3fBseh4dvZl+1nc
        7GpBvFAYScoy2vidOsObBGI=
X-Google-Smtp-Source: ACHHUZ4to82aqlaGvdSZTaCFceJFAHsQ++nLf9qI5x3NXVFvOeKiNvun+D9xk4d63tTC13X9wSU87w==
X-Received: by 2002:a05:6808:1456:b0:3a0:3374:a03d with SMTP id x22-20020a056808145600b003a03374a03dmr4290497oiv.35.1687269352449;
        Tue, 20 Jun 2023 06:55:52 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ba53-355d-2a89-4598.res6.spectrum.com. [2603:8081:140c:1a00:ba53:355d:2a89:4598])
        by smtp.gmail.com with ESMTPSA id bm9-20020a0568081a8900b003a03481094csm1091010oib.19.2023.06.20.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:55:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/3] RDMA/rxe: Move work queue code to subroutines
Date:   Tue, 20 Jun 2023 08:55:19 -0500
Message-Id: <20230620135519.9365-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230620135519.9365-1-rpearsonhpe@gmail.com>
References: <20230620135519.9365-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch:
	- Moves code to initialize a qp send work queue to a
	  subroutine named rxe_init_sq.
	- Moves code to initialize a qp recv work queue to a
	  subroutine named rxe_init_rq.
	- Moves initialization of qp request and response packet
	  queues ahead of work queue initialization so that cleanup
	  of a qp if it is not fully completed can successfully
	  attempt to drain the packet queues without a seg fault.
	- Makes minor whitespace cleanups.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 163 +++++++++++++++++++----------
 1 file changed, 108 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 95d4a6760c33..9dbb16699c36 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -180,13 +180,63 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	atomic_set(&qp->skb_out, 0);
 }
 
+static int rxe_init_sq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
+		       struct ib_udata *udata,
+		       struct rxe_create_qp_resp __user *uresp)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int wqe_size;
+	int err;
+
+	qp->sq.max_wr = init->cap.max_send_wr;
+	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+			 init->cap.max_inline_data);
+	qp->sq.max_sge = wqe_size / sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;
+	wqe_size += sizeof(struct rxe_send_wqe);
+
+	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
+				      QUEUE_TYPE_FROM_CLIENT);
+	if (!qp->sq.queue) {
+		rxe_err_qp(qp, "Unable to allocate send queue");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* prepare info for caller to mmap send queue if user space qp */
+	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
+			   qp->sq.queue->buf, qp->sq.queue->buf_size,
+			   &qp->sq.queue->ip);
+	if (err) {
+		rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
+		goto err_free;
+	}
+
+	/* return actual capabilities to caller which may be larger
+	 * than requested
+	 */
+	init->cap.max_send_wr = qp->sq.max_wr;
+	init->cap.max_send_sge = qp->sq.max_sge;
+	init->cap.max_inline_data = qp->sq.max_inline;
+
+	return 0;
+
+err_free:
+	vfree(qp->sq.queue->buf);
+	kfree(qp->sq.queue);
+	qp->sq.queue = NULL;
+err_out:
+	return err;
+}
+
 static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct ib_qp_init_attr *init, struct ib_udata *udata,
 			   struct rxe_create_qp_resp __user *uresp)
 {
 	int err;
-	int wqe_size;
-	enum queue_type type;
+
+	/* if we don't finish qp create make sure queue is valid */
+	skb_queue_head_init(&qp->req_pkts);
 
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
@@ -201,32 +251,10 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	 * (0xc000 - 0xffff).
 	 */
 	qp->src_port = RXE_ROCE_V2_SPORT + (hash_32(qp_num(qp), 14) & 0x3fff);
-	qp->sq.max_wr		= init->cap.max_send_wr;
-
-	/* These caps are limited by rxe_qp_chk_cap() done by the caller */
-	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
-			 init->cap.max_inline_data);
-	qp->sq.max_sge = init->cap.max_send_sge =
-		wqe_size / sizeof(struct ib_sge);
-	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
-	wqe_size += sizeof(struct rxe_send_wqe);
-
-	type = QUEUE_TYPE_FROM_CLIENT;
-	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
-				wqe_size, type);
-	if (!qp->sq.queue)
-		return -ENOMEM;
 
-	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
-			   qp->sq.queue->buf, qp->sq.queue->buf_size,
-			   &qp->sq.queue->ip);
-
-	if (err) {
-		vfree(qp->sq.queue->buf);
-		kfree(qp->sq.queue);
-		qp->sq.queue = NULL;
+	err = rxe_init_sq(qp, init, udata, uresp);
+	if (err)
 		return err;
-	}
 
 	qp->req.wqe_index = queue_get_producer(qp->sq.queue,
 					       QUEUE_TYPE_FROM_CLIENT);
@@ -234,8 +262,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	skb_queue_head_init(&qp->req_pkts);
-
 	rxe_init_task(&qp->req.task, qp, rxe_requester);
 	rxe_init_task(&qp->comp.task, qp, rxe_completer);
 
@@ -247,40 +273,67 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return 0;
 }
 
+static int rxe_init_rq(struct rxe_qp *qp, struct ib_qp_init_attr *init,
+		       struct ib_udata *udata,
+		       struct rxe_create_qp_resp __user *uresp)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int wqe_size;
+	int err;
+
+	qp->rq.max_wr = init->cap.max_recv_wr;
+	qp->rq.max_sge = init->cap.max_recv_sge;
+	wqe_size = sizeof(struct rxe_recv_wqe) +
+				qp->rq.max_sge*sizeof(struct ib_sge);
+
+	qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
+				      QUEUE_TYPE_FROM_CLIENT);
+	if (!qp->rq.queue) {
+		rxe_err_qp(qp, "Unable to allocate recv queue");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	/* prepare info for caller to mmap recv queue if user space qp */
+	err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
+			   qp->rq.queue->buf, qp->rq.queue->buf_size,
+			   &qp->rq.queue->ip);
+	if (err) {
+		rxe_err_qp(qp, "do_mmap_info failed, err = %d", err);
+		goto err_free;
+	}
+
+	/* return actual capabilities to caller which may be larger
+	 * than requested
+	 */
+	init->cap.max_recv_wr = qp->rq.max_wr;
+
+	return 0;
+
+err_free:
+	vfree(qp->rq.queue->buf);
+	kfree(qp->rq.queue);
+	qp->rq.queue = NULL;
+err_out:
+	return err;
+}
+
 static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    struct ib_qp_init_attr *init,
 			    struct ib_udata *udata,
 			    struct rxe_create_qp_resp __user *uresp)
 {
 	int err;
-	int wqe_size;
-	enum queue_type type;
+
+	/* if we don't finish qp create make sure queue is valid */
+	skb_queue_head_init(&qp->resp_pkts);
 
 	if (!qp->srq) {
-		qp->rq.max_wr		= init->cap.max_recv_wr;
-		qp->rq.max_sge		= init->cap.max_recv_sge;
-
-		wqe_size = rcv_wqe_size(qp->rq.max_sge);
-
-		type = QUEUE_TYPE_FROM_CLIENT;
-		qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
-					wqe_size, type);
-		if (!qp->rq.queue)
-			return -ENOMEM;
-
-		err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
-				   qp->rq.queue->buf, qp->rq.queue->buf_size,
-				   &qp->rq.queue->ip);
-		if (err) {
-			vfree(qp->rq.queue->buf);
-			kfree(qp->rq.queue);
-			qp->rq.queue = NULL;
+		err = rxe_init_rq(qp, init, udata, uresp);
+		if (err)
 			return err;
-		}
 	}
 
-	skb_queue_head_init(&qp->resp_pkts);
-
 	rxe_init_task(&qp->resp.task, qp, rxe_responder);
 
 	qp->resp.opcode		= OPCODE_NONE;
@@ -307,10 +360,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	if (srq)
 		rxe_get(srq);
 
-	qp->pd			= pd;
-	qp->rcq			= rcq;
-	qp->scq			= scq;
-	qp->srq			= srq;
+	qp->pd = pd;
+	qp->rcq = rcq;
+	qp->scq = scq;
+	qp->srq = srq;
 
 	atomic_inc(&rcq->num_wq);
 	atomic_inc(&scq->num_wq);
-- 
2.39.2

