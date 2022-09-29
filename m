Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B645EFBA8
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiI2RJU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiI2RJR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:17 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5AA1CEDE1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:14 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id k10-20020a4ad10a000000b004756ab911f8so531549oor.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5dCbi8WvmUR9/WJbqIz+oTkaGf+yKmfm7XOCy0KBaWM=;
        b=SFH3XLFuGRsU6fJ6AyVIINUivFWxciblkMFTnSZGaDh1w8beNTOwU1CBJTADAoMWuD
         eLJ+lj5Zn+3wbDocInmvYshJiXK/YOcT2CMBVSuoRx1BhGkT1EOy8S82a2YpXGgv/yDY
         eNnc7H6YgPJLPQ69DVKzzmiqCuhy5fqOw07oyiIV3nzk8atID5b5ZxT/b11QcnjjokTV
         4slRn+jjR1l1kFLE9gJwh4ytCyFXjVhu4aw26I2UPkBbzeyzRjJSKAkUijfroI4zwfPY
         EGYiUOOVnrO+wp6e38pF69LTC8IOFVfywaPSYOS4pBkM5mxvUISwM7H8pi72wROFOKzO
         VIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5dCbi8WvmUR9/WJbqIz+oTkaGf+yKmfm7XOCy0KBaWM=;
        b=AyJxckxAlLMnJ9zNPJfsvmMsRl8hfnpNMVkcJvMtf7Buwyr0hZPuo/gM+hWn1rPHY4
         yf/KpnByu0nDaRajxah0OA+vzwXf2ECJKG4VsbCx/WnTyZ293cCPy6Uwk11nZpE73iHZ
         TSJEmiU8csIZMLlKaFeSmFf5o0RHT6h8fSXcS4wbrWzjRRtynSd5P1Sd+0t/c5FeFXd/
         0/pn4oYk01+EL4hnqroBGHulcCBnGqSBCvA0S7usBgRbRJuDjsmrDlz+sr03oY4w7xmS
         x27JG1xZZF789q+cHN48ioLDmuL//bUlY+70eAPzX7u8GcEQ/HfyJ3bL/crXcMQp/FYN
         D60w==
X-Gm-Message-State: ACrzQf0jXHiVQjd64/Lz3uZIyqig8Wwpwe3vrSIz4MPuUZ9IgHS6QmK7
        IXY7g9Ye22cbYX2Miu0M2klCgYEfAdW0CA==
X-Google-Smtp-Source: AMsMyM7k0cpon0mHW10jQZo8w7eT5DVzLPnauTT5oFv+5tU165fVXL2YINe4vrw/DiEdUHJpJGnqoA==
X-Received: by 2002:a05:6820:1b1a:b0:476:805:101a with SMTP id bv26-20020a0568201b1a00b004760805101amr1771330oob.79.1664471354098;
        Thu, 29 Sep 2022 10:09:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 08/13] RDMA/rxe: Extend rxe_qp.c to support xrc qps
Date:   Thu, 29 Sep 2022 12:08:32 -0500
Message-Id: <20220929170836.17838-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

Extend code in rxe_qp.c to support xrc qp types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Rebased to current for-next.

 drivers/infiniband/sw/rxe/rxe_av.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   7 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 308 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  22 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 5 files changed, 200 insertions(+), 141 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 3b05314ca739..c8f3ec53aa79 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -110,7 +110,8 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
 	if (!pkt || !pkt->qp)
 		return NULL;
 
-	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
+	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC ||
+			qp_type(pkt->qp) == IB_QPT_XRC_INI)
 		return &pkt->qp->pri_av;
 
 	if (!pkt->wqe)
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index a806737168d0..1eba6384b6a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -103,11 +103,12 @@ const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 int next_opcode(struct rxe_qp *qp, struct rxe_send_wqe *wqe, u32 opcode);
 
 /* rxe_qp.c */
-int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
-int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
+int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp *ibqp,
+		    struct ib_qp_init_attr *init);
+int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 		     struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
-		     struct ib_pd *ibpd, struct ib_udata *udata);
+		     struct ib_udata *udata);
 int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init);
 int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		    struct ib_qp_attr *attr, int mask);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a62bab88415c..5782f8aa2213 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -56,34 +56,45 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
 	return -EINVAL;
 }
 
-int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init)
+int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp *ibqp,
+		    struct ib_qp_init_attr *init)
 {
+	struct ib_pd *ibpd = ibqp->pd;
 	struct ib_qp_cap *cap = &init->cap;
 	struct rxe_port *port;
 	int port_num = init->port_num;
 
+	if (init->create_flags)
+		return -EOPNOTSUPP;
+
 	switch (init->qp_type) {
 	case IB_QPT_GSI:
 	case IB_QPT_RC:
 	case IB_QPT_UC:
 	case IB_QPT_UD:
+		if (!ibpd || !init->recv_cq || !init->send_cq)
+			return -EINVAL;
+		break;
+	case IB_QPT_XRC_INI:
+		if (!init->send_cq)
+			return -EINVAL;
+		break;
+	case IB_QPT_XRC_TGT:
+		if (!init->xrcd)
+			return -EINVAL;
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	if (!init->recv_cq || !init->send_cq) {
-		pr_debug("missing cq\n");
-		goto err1;
+	if (init->qp_type != IB_QPT_XRC_TGT) {
+		if (rxe_qp_chk_cap(rxe, cap, !!(init->srq || init->xrcd)))
+			goto err1;
 	}
 
-	if (rxe_qp_chk_cap(rxe, cap, !!init->srq))
-		goto err1;
-
 	if (init->qp_type == IB_QPT_GSI) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, port_num)) {
 			pr_debug("invalid port = %d\n", port_num);
-			goto err1;
 		}
 
 		port = &rxe->port;
@@ -148,49 +159,83 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
 static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 			     struct ib_qp_init_attr *init)
 {
-	struct rxe_port *port;
-	u32 qpn;
-
+	qp->ibqp.qp_type	= init->qp_type;
 	qp->sq_sig_type		= init->sq_sig_type;
 	qp->attr.path_mtu	= 1;
 	qp->mtu			= ib_mtu_enum_to_int(qp->attr.path_mtu);
 
-	qpn			= qp->elem.index;
-	port			= &rxe->port;
-
 	switch (init->qp_type) {
 	case IB_QPT_GSI:
 		qp->ibqp.qp_num		= 1;
-		port->qp_gsi_index	= qpn;
+		rxe->port.qp_gsi_index	= qp->elem.index;
 		qp->attr.port_num	= init->port_num;
 		break;
 
 	default:
-		qp->ibqp.qp_num		= qpn;
+		qp->ibqp.qp_num		= qp->elem.index;
 		break;
 	}
 
 	spin_lock_init(&qp->state_lock);
 
-	spin_lock_init(&qp->req.task.state_lock);
-	spin_lock_init(&qp->resp.task.state_lock);
-	spin_lock_init(&qp->comp.task.state_lock);
-
-	spin_lock_init(&qp->sq.sq_lock);
-	spin_lock_init(&qp->rq.producer_lock);
-	spin_lock_init(&qp->rq.consumer_lock);
-
 	atomic_set(&qp->ssn, 0);
 	atomic_set(&qp->skb_out, 0);
 }
 
+static int rxe_prepare_send_queue(struct rxe_dev *rxe, struct rxe_qp *qp,
+			struct ib_qp_init_attr *init, struct ib_udata *udata,
+			struct rxe_create_qp_resp __user *uresp)
+{
+	struct rxe_queue *q;
+	int wqe_size;
+	int err;
+
+	qp->sq.max_wr = init->cap.max_send_wr;
+
+	wqe_size = init->cap.max_send_sge*sizeof(struct ib_sge);
+	wqe_size = max_t(int, wqe_size, init->cap.max_inline_data);
+
+	qp->sq.max_sge = wqe_size/sizeof(struct ib_sge);
+	qp->sq.max_inline = wqe_size;
+	wqe_size += sizeof(struct rxe_send_wqe);
+
+	q = rxe_queue_init(rxe, &qp->sq.max_wr, wqe_size,
+			   QUEUE_TYPE_FROM_CLIENT);
+	if (!q)
+		return -ENOMEM;
+
+	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
+			   q->buf, q->buf_size, &q->ip);
+
+	if (err) {
+		vfree(q->buf);
+		kfree(q);
+		return err;
+	}
+
+	init->cap.max_send_sge = qp->sq.max_sge;
+	init->cap.max_inline_data = qp->sq.max_inline;
+
+	qp->sq.queue = q;
+
+	return 0;
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
+	err = rxe_prepare_send_queue(rxe, qp, init, udata, uresp);
+	if (err)
+		return err;
+
+	spin_lock_init(&qp->sq.sq_lock);
+	spin_lock_init(&qp->req.task.state_lock);
+	spin_lock_init(&qp->comp.task.state_lock);
+
+	skb_queue_head_init(&qp->resp_pkts);
 
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
@@ -205,32 +250,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
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
-
-	err = do_mmap_info(rxe, uresp ? &uresp->sq_mi : NULL, udata,
-			   qp->sq.queue->buf, qp->sq.queue->buf_size,
-			   &qp->sq.queue->ip);
-
-	if (err) {
-		vfree(qp->sq.queue->buf);
-		kfree(qp->sq.queue);
-		qp->sq.queue = NULL;
-		return err;
-	}
 
 	qp->req.wqe_index = queue_get_producer(qp->sq.queue,
 					       QUEUE_TYPE_FROM_CLIENT);
@@ -240,57 +259,71 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
-	skb_queue_head_init(&qp->req_pkts);
-
 	rxe_init_task(&qp->req.task, qp,
 		      rxe_requester, "req");
 	rxe_init_task(&qp->comp.task, qp,
 		      rxe_completer, "comp");
 
 	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
-	if (init->qp_type == IB_QPT_RC) {
+	if (init->qp_type == IB_QPT_RC || init->qp_type == IB_QPT_XRC_INI) {
 		timer_setup(&qp->rnr_nak_timer, rnr_nak_timer, 0);
 		timer_setup(&qp->retrans_timer, retransmit_timer, 0);
 	}
 	return 0;
 }
 
+static int rxe_prepare_recv_queue(struct rxe_dev *rxe, struct rxe_qp *qp,
+			struct ib_qp_init_attr *init, struct ib_udata *udata,
+			struct rxe_create_qp_resp __user *uresp)
+{
+	struct rxe_queue *q;
+	int wqe_size;
+	int err;
+
+	qp->rq.max_wr = init->cap.max_recv_wr;
+	qp->rq.max_sge = init->cap.max_recv_sge;
+
+	wqe_size = sizeof(struct rxe_recv_wqe) +
+		   qp->rq.max_sge*sizeof(struct ib_sge);
+
+	q = rxe_queue_init(rxe, &qp->rq.max_wr, wqe_size,
+			   QUEUE_TYPE_FROM_CLIENT);
+	if (!q)
+		return -ENOMEM;
+
+	err = do_mmap_info(rxe, uresp ? &uresp->rq_mi : NULL, udata,
+			   q->buf, q->buf_size, &q->ip);
+
+	if (err) {
+		vfree(q->buf);
+		kfree(q);
+		return err;
+	}
+
+	qp->rq.queue = q;
+
+	return 0;
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
 
-	if (!qp->srq) {
-		qp->rq.max_wr		= init->cap.max_recv_wr;
-		qp->rq.max_sge		= init->cap.max_recv_sge;
-
-		wqe_size = rcv_wqe_size(qp->rq.max_sge);
-
-		pr_debug("qp#%d max_wr = %d, max_sge = %d, wqe_size = %d\n",
-			 qp_num(qp), qp->rq.max_wr, qp->rq.max_sge, wqe_size);
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
+	if (!qp->srq && qp_type(qp) != IB_QPT_XRC_TGT) {
+		err = rxe_prepare_recv_queue(rxe, qp, init, udata, uresp);
+		if (err)
 			return err;
-		}
+
+		spin_lock_init(&qp->rq.producer_lock);
+		spin_lock_init(&qp->rq.consumer_lock);
 	}
 
-	skb_queue_head_init(&qp->resp_pkts);
+	spin_lock_init(&qp->resp.task.state_lock);
+
+	skb_queue_head_init(&qp->req_pkts);
 
 	rxe_init_task(&qp->resp.task, qp,
 		      rxe_responder, "resp");
@@ -303,64 +336,82 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 }
 
 /* called by the create qp verb */
-int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
+int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp,
 		     struct ib_qp_init_attr *init,
 		     struct rxe_create_qp_resp __user *uresp,
-		     struct ib_pd *ibpd,
 		     struct ib_udata *udata)
 {
 	int err;
+	struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
 	struct rxe_cq *rcq = to_rcq(init->recv_cq);
 	struct rxe_cq *scq = to_rcq(init->send_cq);
-	struct rxe_srq *srq = init->srq ? to_rsrq(init->srq) : NULL;
+	struct rxe_srq *srq = to_rsrq(init->srq);
+	struct rxe_xrcd *xrcd = to_rxrcd(init->xrcd);
 
-	rxe_get(pd);
-	rxe_get(rcq);
-	rxe_get(scq);
-	if (srq)
+	if (pd) {
+		rxe_get(pd);
+		qp->pd = pd;
+	}
+	if (rcq) {
+		rxe_get(rcq);
+		qp->rcq = rcq;
+		atomic_inc(&rcq->num_wq);
+	}
+	if (scq) {
+		rxe_get(scq);
+		qp->scq = scq;
+		atomic_inc(&scq->num_wq);
+	}
+	if (srq) {
 		rxe_get(srq);
-
-	qp->pd			= pd;
-	qp->rcq			= rcq;
-	qp->scq			= scq;
-	qp->srq			= srq;
-
-	atomic_inc(&rcq->num_wq);
-	atomic_inc(&scq->num_wq);
+		qp->srq = srq;
+	}
+	if (xrcd) {
+		rxe_get(xrcd);
+		qp->xrcd = xrcd;
+	}
 
 	rxe_qp_init_misc(rxe, qp, init);
 
-	err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
-	if (err)
-		goto err1;
+	switch (init->qp_type) {
+	case IB_QPT_RC:
+	case IB_QPT_UC:
+	case IB_QPT_GSI:
+	case IB_QPT_UD:
+		err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
+		if (err)
+			goto err_out;
 
-	err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
-	if (err)
-		goto err2;
+		err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
+		if (err)
+			goto err_unwind;
+		break;
+	case IB_QPT_XRC_INI:
+		err = rxe_qp_init_req(rxe, qp, init, udata, uresp);
+		if (err)
+			goto err_out;
+		break;
+	case IB_QPT_XRC_TGT:
+		err = rxe_qp_init_resp(rxe, qp, init, udata, uresp);
+		if (err)
+			goto err_out;
+		break;
+	default:
+		/* not reached */
+		err = -EOPNOTSUPP;
+		goto err_out;
+	};
 
 	qp->attr.qp_state = IB_QPS_RESET;
 	qp->valid = 1;
 
 	return 0;
 
-err2:
+err_unwind:
 	rxe_queue_cleanup(qp->sq.queue);
 	qp->sq.queue = NULL;
-err1:
-	atomic_dec(&rcq->num_wq);
-	atomic_dec(&scq->num_wq);
-
-	qp->pd = NULL;
-	qp->rcq = NULL;
-	qp->scq = NULL;
-	qp->srq = NULL;
-
-	if (srq)
-		rxe_put(srq);
-	rxe_put(scq);
-	rxe_put(rcq);
-	rxe_put(pd);
-
+err_out:
+	/* rxe_qp_cleanup handles the rest */
 	return err;
 }
 
@@ -485,7 +536,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* stop request/comp */
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (qp_type(qp) == IB_QPT_RC ||
+		    qp_type(qp) == IB_QPT_XRC_INI)
 			rxe_disable_task(&qp->comp.task);
 		rxe_disable_task(&qp->req.task);
 	}
@@ -529,7 +581,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_enable_task(&qp->resp.task);
 
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (qp_type(qp) == IB_QPT_RC ||
+		    qp_type(qp) == IB_QPT_XRC_INI)
 			rxe_enable_task(&qp->comp.task);
 
 		rxe_enable_task(&qp->req.task);
@@ -542,7 +595,8 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (qp_type(qp) == IB_QPT_RC)
+			if (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_INI)
 				rxe_run_task(&qp->comp.task, 1);
 			else
 				__rxe_do_task(&qp->comp.task);
@@ -562,7 +616,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 	/* drain work and packet queues */
 	rxe_run_task(&qp->resp.task, 1);
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI)
 		rxe_run_task(&qp->comp.task, 1);
 	else
 		__rxe_do_task(&qp->comp.task);
@@ -672,7 +726,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		qp->attr.sq_psn = (attr->sq_psn & BTH_PSN_MASK);
 		qp->req.psn = qp->attr.sq_psn;
 		qp->comp.psn = qp->attr.sq_psn;
-		pr_debug("qp#%d set req psn = 0x%x\n", qp_num(qp), qp->req.psn);
+		pr_debug("qp#%d set req psn = %d comp psn = %d\n", qp_num(qp),
+				qp->req.psn, qp->comp.psn);
 	}
 
 	if (mask & IB_QP_PATH_MIG_STATE)
@@ -787,7 +842,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	qp->qp_timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
 
-	if (qp_type(qp) == IB_QPT_RC) {
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
@@ -807,6 +862,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
 
+	if (qp->xrcd)
+		rxe_put(qp->xrcd);
+
 	if (qp->srq)
 		rxe_put(qp->srq);
 
@@ -829,7 +887,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->resp.mr)
 		rxe_put(qp->resp.mr);
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI)
 		sk_dst_reset(qp->sk->sk);
 
 	free_rd_atomic_resources(qp);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index cee31b650fe0..b490f7d53d72 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -415,7 +415,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
-	struct rxe_pd *pd = to_rpd(ibqp->pd);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
@@ -423,16 +422,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
 		uresp = udata->outbuf;
-	}
-
-	if (init->create_flags)
-		return -EOPNOTSUPP;
 
-	err = rxe_qp_chk_init(rxe, init);
-	if (err)
-		return err;
-
-	if (udata) {
 		if (udata->inlen)
 			return -EINVAL;
 
@@ -441,11 +431,15 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 		qp->is_user = false;
 	}
 
+	err = rxe_qp_chk_init(rxe, ibqp, init);
+	if (err)
+		return err;
+
 	err = rxe_add_to_pool(&rxe->qp_pool, qp);
 	if (err)
 		return err;
 
-	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
+	err = rxe_qp_from_init(rxe, qp, init, uresp, udata);
 	if (err)
 		goto qp_init;
 
@@ -516,6 +510,9 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	int num_sge = ibwr->num_sge;
 	struct rxe_sq *sq = &qp->sq;
 
+	if (unlikely(qp_type(qp) == IB_QPT_XRC_TGT))
+		return -EOPNOTSUPP;
+
 	if (unlikely(num_sge > sq->max_sge))
 		goto err1;
 
@@ -739,8 +736,9 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		/* Utilize process context to do protocol processing */
 		rxe_run_task(&qp->req.task, 0);
 		return 0;
-	} else
+	} else {
 		return rxe_post_send_kernel(qp, wr, bad_wr);
+	}
 }
 
 static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 465af1517112..582ffdecb9e9 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -230,6 +230,7 @@ struct rxe_qp {
 	struct rxe_srq		*srq;
 	struct rxe_cq		*scq;
 	struct rxe_cq		*rcq;
+	struct rxe_xrcd		*xrcd;
 
 	enum ib_sig_type	sq_sig_type;
 
-- 
2.34.1

