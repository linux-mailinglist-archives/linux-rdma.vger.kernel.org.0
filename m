Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A16735E6B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFSUWD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFSUWA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 16:22:00 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEDBCC
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:21:59 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a49716e9c5so3957961fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206118; x=1689798118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpJ3zW5W+VQqNHMOouMTtI43e8VFcdOhMUHhCH6t4DA=;
        b=dOms81A8EPsI2L1AZruRbcJXGodkSH7kDn9fIDbgRiXFmjscDBvaA7Pjni6/Vkc05T
         taSKkGsTJflNI6A3m0yRVtXKKbsZbROA+gN0JyTmaBjI1WQHbVeM0Ci531er+hrdqJJr
         a+ySoe9DwVR7XsHcxqhBM4d+OSAm3T5VcJexozttng0pYbtB0T2oxbBjnUdZ4Bd1l0Mf
         tndcLWGWUuAjtz9cCB5UpS4fQ7Y0EBOtobKWeE0IbDKloaJmTuPAaXNOMEi1CEuKiS3t
         tWf912wRzAKDVR/qlHxEzNiNIOazQa2Bht359xUq4EkIgYW7514iTtI3mgUmMABRAHxe
         aPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206118; x=1689798118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpJ3zW5W+VQqNHMOouMTtI43e8VFcdOhMUHhCH6t4DA=;
        b=Cd9JUBPi4q53RmkTEgb3lZKhstVQj56+pwTtyrR8U03779AmInJ3i+jcMIhtWKFIkL
         /1ZmmmmkUhX9OZ8M8+rtkej/nn1kInegVIcHOcY+ZEjkm1hl5lK0hMm9EAIUsOGUjIGa
         27dJAlzypeTbYdMLOZvxIeEF1ZTImVonZW2nEe7r2GWaIPWHx84fVzHH/OiMoqq2kNy8
         bybur42A9f3WkmhcNFb6KSfNqy8N1Qkv0lwXIhWzBvepNAk7nBLxWUf/YX+XQvWztOp/
         WsIvb576qr8yXMqpsR8nuXK8voBgIgEjIemdCb08Vm+pqxaUmzh7EQeAFdDkPaPYg1MU
         66OA==
X-Gm-Message-State: AC+VfDxfmzY5Sr9QKsvBZZVUp4xNmYaCSYYMMZrzlDCoSemHkxJ33pvH
        D8uonUSIHlopLNz3G6HL0zA=
X-Google-Smtp-Source: ACHHUZ4oAPY9J5rMuauoCzgNooV4bs24pzad89Kl+mIvvrkKL/6oH+5+zCJQKTcZarCA8sQgA+OHFg==
X-Received: by 2002:a05:6871:556:b0:1aa:30e3:6a6f with SMTP id t22-20020a056871055600b001aa30e36a6fmr2040911oal.50.1687206118603;
        Mon, 19 Jun 2023 13:21:58 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-773b-851f-3075-b82a.res6.spectrum.com. [2603:8081:140c:1a00:773b:851f:3075:b82a])
        by smtp.gmail.com with ESMTPSA id kw41-20020a056870ac2900b001a6a3f99691sm311368oab.27.2023.06.19.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:21:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/3] RDMA/rxe: Move work queue code to subroutines
Date:   Mon, 19 Jun 2023 15:21:10 -0500
Message-Id: <20230619202110.45680-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619202110.45680-1-rpearsonhpe@gmail.com>
References: <20230619202110.45680-1-rpearsonhpe@gmail.com>
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

