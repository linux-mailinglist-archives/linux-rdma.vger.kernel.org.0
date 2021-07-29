Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A339B3DAF84
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhG2Wus (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbhG2Wur (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:47 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BA6C061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so1969827ooq.13
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZMX5+qZmU8ZpwSCLqdM7bKWpyQYEXYrHTqSQbMUjT4c=;
        b=nYKPa1E0fyEv/gQA2WZDFOKVnfBETFrotOOTdjuMmpeiM9vK9eCmXTjehsx+u2hA6V
         dbcKpPllrGRn7wjE6Aw5vUAzQ5OFKK+AXRLdgtPut7wbELW+sK/wqGNe5Tk0C4hBs5Yv
         fEfNEjfl86O/XME6Przf1DmPAXYZqvHngksI0Ma+2bvPTovp4M5y3haPE32WtD5Fnsn7
         VrFJXzQrYlmPY5Of0QgvNG7f5lXudobl8yPBsnqOaxz9+0QoWaHpFJlwntN4Gtb6m2rv
         7wYWFM1T1YrnTrduBv+gb6f9+LZWAlUPqpJDbkrUni6p/Wz9VD+QI2CwxlRuP/4el9NI
         hdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMX5+qZmU8ZpwSCLqdM7bKWpyQYEXYrHTqSQbMUjT4c=;
        b=mvQzZx1R3VuwRQogAzQJPFGQQsjNPc3xfqitTo3TzDzXj42tPYyj4X3fHl7d5V8RP6
         bd4c037cmrTiFSCs8inUR+NrLwfeXRLd+fslWuDS0iJZfdAULplpfFrPQIJkKuMrZqYr
         4NB61TEL4+wVj59mlpvpGGnHvj1Weo7erif4TCXVAlohB6hlhh4t68Vyvhgp/656JLXz
         3HNnY5kg2uNkJM/EUpAQX84cUmNCm5HLw+bTp01bK6HD3LRsi653wN4rE+2HzN10A0Jy
         ynD5HrnWzpqnZr8m3ADOqlLjeyvw+WvlEnMsS5NQbSSrgEtlc3I1F1TYl/AuYeQ4Isa7
         +UIQ==
X-Gm-Message-State: AOAM53069qCFvMI/cKbBrb/f99eQM7uNK6egvq2F8tkTM3Ups6meDVjC
        0jYHEPM967SiKh2SryMlf/s=
X-Google-Smtp-Source: ABdhPJxbgrk9ZlDCbCAwyNVIS4uJrZl/d2NoaKjTWh4Ya5xbxTi3AtOjYCEd5S49sS7ttupNwcGpIg==
X-Received: by 2002:a4a:b6ca:: with SMTP id w10mr4396688ooo.17.1627599042240;
        Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c18sm824645ots.81.2021.07.29.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 11/13] RDMA/rxe: Extend rxe_verbs and rxe_qp to support XRC
Date:   Thu, 29 Jul 2021 17:49:14 -0500
Message-Id: <20210729224915.38986-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe_verbs.c and rxe_qp.c to support XRC QP types.
This patch supports ib_create_qp, ib_query_qp, ib_modify_qp and
ib_destroy_qp for IB_QPT_XRC_INI and IB_QPT_XRC_TGT QP types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 235 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |   8 +-
 3 files changed, 141 insertions(+), 106 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index eac56e0c64ba..790884a5e9d5 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -115,7 +115,7 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 		     struct rxe_create_qp_resp __user *uresp,
 		     struct ib_udata *udata);
 
-int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init);
+void rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init);
 
 int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		    struct ib_qp_attr *attr, int mask);
@@ -123,7 +123,7 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr,
 		     int mask, struct ib_udata *udata);
 
-int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask);
+void rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask);
 
 void rxe_qp_error(struct rxe_qp *qp);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 177edf684f2a..3ff9c832047c 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -68,16 +68,23 @@ int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
 	case IB_QPT_RC:
 	case IB_QPT_UC:
 	case IB_QPT_UD:
+		if (!init->recv_cq || !init->send_cq) {
+			pr_warn("missing cq\n");
+			goto err1;
+		}
+		break;
+	case IB_QPT_XRC_INI:
+		if (!init->send_cq) {
+			pr_warn("missing send cq\n");
+			goto err1;
+		}
+		break;
+	case IB_QPT_XRC_TGT:
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	if (!init->recv_cq || !init->send_cq) {
-		pr_warn("missing cq\n");
-		goto err1;
-	}
-
 	if (rxe_qp_chk_cap(rxe, cap, !!init->srq))
 		goto err1;
 
@@ -199,48 +206,30 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	atomic_set(&qp->skb_out, 0);
 }
 
-static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct ib_qp_init_attr *init, struct ib_udata *udata,
-			   struct rxe_create_qp_resp __user *uresp)
+static int rxe_qp_init_sq(struct rxe_dev *rxe, struct rxe_qp *qp,
+			  struct ib_qp_init_attr *init, struct ib_udata *udata,
+			  struct rxe_create_qp_resp __user *uresp)
 {
-	int err;
 	int wqe_size;
-	enum queue_type type;
-
-	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
-	if (err < 0)
-		return err;
-	qp->sk->sk->sk_user_data = qp;
-
-	/* pick a source UDP port number for this QP based on
-	 * the source QPN. this spreads traffic for different QPs
-	 * across different NIC RX queues (while using a single
-	 * flow for a given QP to maintain packet order).
-	 * the port number must be in the Dynamic Ports range
-	 * (0xc000 - 0xffff).
-	 */
-	qp->src_port = RXE_ROCE_V2_SPORT +
-		(hash_32_generic(rxe_qp_num(qp), 14) & 0x3fff);
-	qp->sq.max_wr		= init->cap.max_send_wr;
+	int err;
 
-	/* These caps are limited by rxe_qp_chk_cap() done by the caller */
-	wqe_size = max_t(int, init->cap.max_send_sge * sizeof(struct ib_sge),
+	qp->sq.max_wr = init->cap.max_send_wr;
+	wqe_size = max_t(int, init->cap.max_send_sge*sizeof(struct ib_sge),
 			 init->cap.max_inline_data);
-	qp->sq.max_sge = init->cap.max_send_sge =
-		wqe_size / sizeof(struct ib_sge);
+	qp->sq.max_sge = init->cap.max_send_sge = wqe_size/
+						sizeof(struct ib_sge);
 	qp->sq.max_inline = init->cap.max_inline_data = wqe_size;
+
 	wqe_size += sizeof(struct rxe_send_wqe);
 
-	type = QUEUE_TYPE_FROM_CLIENT;
 	qp->sq.queue = rxe_queue_init(rxe, &qp->sq.max_wr,
-				wqe_size, type);
+				      wqe_size, QUEUE_TYPE_FROM_CLIENT);
 	if (!qp->sq.queue)
 		return -ENOMEM;
 
 	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
 			   qp->sq.queue->buf, qp->sq.queue->buf_size,
 			   &qp->sq.queue->ip);
-
 	if (err) {
 		vfree(qp->sq.queue->buf);
 		kfree(qp->sq.queue);
@@ -248,14 +237,38 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 		return err;
 	}
 
-		qp->req.wqe_index = producer_index(qp->sq.queue,
-					QUEUE_TYPE_FROM_CLIENT);
+	qp->req.wqe_index = producer_index(qp->sq.queue,
+					   QUEUE_TYPE_FROM_CLIENT);
 
-	qp->req.state		= QP_STATE_RESET;
-	qp->req.opcode		= -1;
-	qp->comp.opcode		= -1;
+	qp->req.state = QP_STATE_RESET;
+	qp->req.opcode = -1;
+	qp->comp.opcode = -1;
 
 	spin_lock_init(&qp->sq.sq_lock);
+
+	return 0;
+}
+
+static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
+			   struct ib_qp_init_attr *init, struct ib_udata *udata,
+			   struct rxe_create_qp_resp __user *uresp)
+{
+	int err;
+
+	/* pick a source UDP port number for this QP based on
+	 * the source QPN. this spreads traffic for different QPs
+	 * across different NIC RX queues (while using a single
+	 * flow for a given QP to maintain packet order).
+	 * the port number must be in the Dynamic Ports range
+	 * (0xc000 - 0xffff).
+	 */
+	qp->src_port = RXE_ROCE_V2_SPORT +
+		(hash_32_generic(rxe_qp_num(qp), 14) & 0x3fff);
+
+	err = rxe_qp_init_sq(rxe, qp, init, udata, uresp);
+	if (err)
+		return err;
+
 	skb_queue_head_init(&qp->req_pkts);
 
 	rxe_init_task(rxe, &qp->req.task, qp,
@@ -264,10 +277,51 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 		      rxe_completer, "comp");
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
-	if (init->qp_type == IB_QPT_RC) {
+
+	if (init->qp_type == IB_QPT_RC ||
+	    init->qp_type == IB_QPT_XRC_INI) {
 		timer_setup(&qp->rnr_nak_timer, rnr_nak_timer, 0);
 		timer_setup(&qp->retrans_timer, retransmit_timer, 0);
 	}
+
+	return 0;
+}
+
+static int rxe_qp_init_rq(struct rxe_dev *rxe, struct rxe_qp *qp,
+			  struct ib_qp_init_attr *init,
+			  struct ib_udata *udata,
+			  struct rxe_create_qp_resp __user *uresp)
+{
+	int wqe_size;
+	int err;
+
+	qp->rq.max_wr		= init->cap.max_recv_wr;
+	qp->rq.max_sge		= init->cap.max_recv_sge;
+
+	wqe_size = rcv_wqe_size(qp->rq.max_sge);
+
+	pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
+		 rxe_qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
+
+	qp->rq.queue = rxe_queue_init(rxe, &qp->rq.max_wr,
+				      wqe_size, QUEUE_TYPE_FROM_CLIENT);
+	if (!qp->rq.queue)
+		return -ENOMEM;
+
+	err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
+			   qp->rq.queue->buf, qp->rq.queue->buf_size,
+			   &qp->rq.queue->ip);
+	if (err) {
+		vfree(qp->rq.queue->buf);
+		kfree(qp->rq.queue);
+		qp->rq.queue = NULL;
+		return err;
+	}
+
+	spin_lock_init(&qp->rq.producer_lock);
+	spin_lock_init(&qp->rq.consumer_lock);
+	qp->rq.is_user = qp->is_user;
+
 	return 0;
 }
 
@@ -277,48 +331,21 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    struct rxe_create_qp_resp __user *uresp)
 {
 	int err;
-	int wqe_size;
-	enum queue_type type;
 
-	if (!rxe_qp_srq(qp)) {
-		qp->rq.max_wr		= init->cap.max_recv_wr;
-		qp->rq.max_sge		= init->cap.max_recv_sge;
-
-		wqe_size = rcv_wqe_size(qp->rq.max_sge);
-
-		pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
-			 rxe_qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
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
+	if (!rxe_qp_srq(qp) && rxe_qp_type(qp) != IB_QPT_XRC_TGT) {
+		err = rxe_qp_init_rq(rxe, qp, init, udata, uresp);
+		if (err)
 			return err;
-		}
 	}
 
-	spin_lock_init(&qp->rq.producer_lock);
-	spin_lock_init(&qp->rq.consumer_lock);
-
-	qp->rq.is_user = qp->is_user;
-
 	skb_queue_head_init(&qp->resp_pkts);
 
 	rxe_init_task(rxe, &qp->resp.task, qp,
 		      rxe_responder, "resp");
 
-	qp->resp.opcode		= OPCODE_NONE;
-	qp->resp.msn		= 0;
-	qp->resp.state		= QP_STATE_RESET;
+	qp->resp.opcode = OPCODE_NONE;
+	qp->resp.msn = 0;
+	qp->resp.state = QP_STATE_RESET;
 
 	return 0;
 }
@@ -331,15 +358,24 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 {
 	int err;
 
+	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
+	if (err < 0)
+		return err;
+	qp->sk->sk->sk_user_data = qp;
+
 	rxe_qp_init_misc(rxe, qp, init);
 
-	err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
-	if (err)
-		goto err1;
+	if (rxe_qp_type(qp) != IB_QPT_XRC_TGT) {
+		err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
+		if (err)
+			goto err1;
+	}
 
-	err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
-	if (err)
-		goto err2;
+	if (rxe_qp_type(qp) != IB_QPT_XRC_INI) {
+		err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
+		if (err)
+			goto err2;
+	}
 
 	qp->attr.qp_state = IB_QPS_RESET;
 	qp->valid = 1;
@@ -352,30 +388,21 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return err;
 }
 
-/* called by the query qp verb */
-int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init)
+void rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init)
 {
-	init->event_handler		= qp->ibqp.event_handler;
-	init->qp_context		= qp->ibqp.qp_context;
-	init->send_cq			= qp->ibqp.send_cq;
-	init->recv_cq			= qp->ibqp.recv_cq;
-	init->srq			= qp->ibqp.srq;
-
 	init->cap.max_send_wr		= qp->sq.max_wr;
 	init->cap.max_send_sge		= qp->sq.max_sge;
 	init->cap.max_inline_data	= qp->sq.max_inline;
 
 	if (!rxe_qp_srq(qp)) {
-		init->cap.max_recv_wr		= qp->rq.max_wr;
-		init->cap.max_recv_sge		= qp->rq.max_sge;
+		init->cap.max_recv_wr = qp->rq.max_wr;
+		init->cap.max_recv_sge = qp->rq.max_sge;
+	} else {
+		init->cap.max_recv_wr = 0;
+		init->cap.max_recv_sge = 0;
 	}
 
 	init->sq_sig_type		= qp->sq_sig_type;
-
-	init->qp_type			= rxe_qp_type(qp);
-	init->port_num			= 1;
-
-	return 0;
 }
 
 /* called by the modify qp verb, this routine checks all the parameters before
@@ -517,7 +544,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_enable_task(&qp->resp.task);
 
 	if (qp->sq.queue) {
-		if (rxe_qp_type(qp) == IB_QPT_RC)
+		if (rxe_qp_type(qp) == IB_QPT_RC ||
+		    rxe_qp_type(qp) == IB_QPT_XRC_INI)
 			rxe_enable_task(&qp->comp.task);
 
 		rxe_enable_task(&qp->req.task);
@@ -530,7 +558,8 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (rxe_qp_type(qp) == IB_QPT_RC)
+			if (rxe_qp_type(qp) == IB_QPT_RC ||
+			    rxe_qp_type(qp) == IB_QPT_XRC_INI)
 				rxe_run_task(&qp->comp.task, 1);
 			else
 				__rxe_do_task(&qp->comp.task);
@@ -549,7 +578,8 @@ void rxe_qp_error(struct rxe_qp *qp)
 	/* drain work and packet queues */
 	rxe_run_task(&qp->resp.task, 1);
 
-	if (rxe_qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_INI)
 		rxe_run_task(&qp->comp.task, 1);
 	else
 		__rxe_do_task(&qp->comp.task);
@@ -715,7 +745,7 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 }
 
 /* called by the query qp verb */
-int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
+void rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 {
 	*attr = qp->attr;
 
@@ -744,10 +774,6 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	} else {
 		attr->sq_draining = 0;
 	}
-
-	pr_debug("attr->sq_draining = %d\n", attr->sq_draining);
-
-	return 0;
 }
 
 /* called by the destroy qp verb */
@@ -757,7 +783,8 @@ void rxe_qp_destroy(struct rxe_qp *qp)
 	qp->qp_timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
 
-	if (rxe_qp_type(qp) == IB_QPT_RC) {
+	if (rxe_qp_type(qp) == IB_QPT_RC ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_INI) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
@@ -791,7 +818,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 		qp->resp.mr = NULL;
 	}
 
-	if (rxe_qp_type(qp) == IB_QPT_RC)
+	if (rxe_qp_type(qp) == IB_QPT_RC ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_INI ||
+	    rxe_qp_type(qp) == IB_QPT_XRC_TGT)
 		sk_dst_reset(qp->sk->sk);
 
 	free_rd_atomic_resources(qp);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index fbd1e2d70682..f5014a187411 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -426,7 +426,7 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 				   struct ib_udata *udata)
 {
 	int err;
-	struct rxe_dev *rxe = to_rdev(ibpd->device);
+	struct rxe_dev *rxe;
 	struct rxe_qp *qp;
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
@@ -436,6 +436,12 @@ static struct ib_qp *rxe_create_qp(struct ib_pd *ibpd,
 		uresp = udata->outbuf;
 	}
 
+	/* at least one of PD or XRCD is valid */
+	if (ibpd)
+		rxe = to_rdev(ibpd->device);
+	else
+		rxe = to_rdev(init->xrcd->device);
+
 	if (init->create_flags)
 		return ERR_PTR(-EOPNOTSUPP);
 
-- 
2.30.2

