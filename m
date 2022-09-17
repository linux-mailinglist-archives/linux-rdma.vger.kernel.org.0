Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEA5BB5C4
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIQDLA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQDKy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:10:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF874DF25
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:51 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id e35-20020a9d01a6000000b0065798eb8754so7026142ote.2
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PIF/daVr5yYMTgWd7zk0PdSI0kMkAwJNKjUQnaP5nw8=;
        b=WocLRzAuGwlclYSMBqEtxO9BCF25EeHaZZZRdq64D6sRmrCVxJdAVrDjkxxRV+woqK
         DMGrBJol4cmu+rPBXmHUb6wkY0FaVd3o7B0rQhAGWoZwlr2TTzCW0gSdsoVIw8dTezyk
         T+s+YD1BS+Yr44ulYkTlw8vkdn6JAGzzYiA8Mv4uI7UT9Gb62DmJU4hSTbNXY8RVGxIK
         4lebzexNgP8bnHp7cO0OvBmmbVh3mnn7O6NIaf0oo3gSCiSn38YpEyy55A1rGb2fHtD8
         qOeN6yW82haFEC9M+6dBo2xeVH2HQFHQkVUqJIMCy3r4XqfyjLaD20mYAob8VwZ9X8vk
         lA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PIF/daVr5yYMTgWd7zk0PdSI0kMkAwJNKjUQnaP5nw8=;
        b=iRMSh1323wm65NqFjMNE3w9ZUfPzV84LdOWeX9zBoYS2d+eGaNBS7iVK6/CCGsuWnh
         kJurSaZWJImcxIKJrIS/7YPgj6Wwc9gOFOOda3EcD61p6ftdiVSVrjU0TgvTTaONt40t
         Gb7xQQasy1PQXsrhZQCAKhlXmRDedXBW7zof8BxXFNxYZgnoQn3dbINTrXJyq+lFD8n0
         G1eTdOrAG4UQwqGF2tOmPtQS1CZIRCKYBS+3Itx1tE6E6QKDQgEY9a5N76svCGL+i8z+
         SfNXQPhFsh2EezSWzxQhS2SRl82TwwAW8hwTiaIJ0fxEJWvGZKlpdThId18TMeqvzicm
         i5hg==
X-Gm-Message-State: ACrzQf0Z7J8/o6Fq0p9P6WcTV/IySarQTL/9tG/+UmwWW3isbNASnTBM
        IA8+Ds2McYMzf4WK/0+FIVE=
X-Google-Smtp-Source: AMsMyM40LaD5BfusIo8aTqP8bV4y/IZ7tQHFku7q+/2tC2KZmpbIQOtK1s87Y64Pqaae2jPpTkxH6w==
X-Received: by 2002:a05:6830:1e16:b0:655:e44b:6241 with SMTP id s22-20020a0568301e1600b00655e44b6241mr3535240otr.229.1663384251065;
        Fri, 16 Sep 2022 20:10:51 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm4464800oab.3.2022.09.16.20.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:10:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 08/13] RDMA/rxe: Extend rxe_qp.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:10:27 -0500
Message-Id: <20220917031028.21187-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031028.21187-1-rpearsonhpe@gmail.com>
References: <20220917031028.21187-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_av.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   7 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 307 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  22 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 5 files changed, 200 insertions(+), 140 deletions(-)

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
index 5526d83697c7..c6fb93a749ad 100644
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
index 1dcbeacb3122..6cbc842b8cbb 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -56,30 +56,42 @@ static int rxe_qp_chk_cap(struct rxe_dev *rxe, struct ib_qp_cap *cap,
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
-		pr_warn("missing cq\n");
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
 			pr_warn("invalid port = %d\n", port_num);
@@ -148,49 +160,83 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
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
@@ -205,32 +251,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
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
@@ -240,57 +260,71 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
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
@@ -303,64 +337,82 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
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
 
@@ -486,7 +538,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 
 	/* stop request/comp */
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (qp_type(qp) == IB_QPT_RC ||
+		    qp_type(qp) == IB_QPT_XRC_INI)
 			rxe_disable_task(&qp->comp.task);
 		rxe_disable_task(&qp->req.task);
 	}
@@ -530,7 +583,8 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_enable_task(&qp->resp.task);
 
 	if (qp->sq.queue) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (qp_type(qp) == IB_QPT_RC ||
+		    qp_type(qp) == IB_QPT_XRC_INI)
 			rxe_enable_task(&qp->comp.task);
 
 		rxe_enable_task(&qp->req.task);
@@ -543,7 +597,8 @@ static void rxe_qp_drain(struct rxe_qp *qp)
 	if (qp->sq.queue) {
 		if (qp->req.state != QP_STATE_DRAINED) {
 			qp->req.state = QP_STATE_DRAIN;
-			if (qp_type(qp) == IB_QPT_RC)
+			if (qp_type(qp) == IB_QPT_RC ||
+			    qp_type(qp) == IB_QPT_XRC_INI)
 				rxe_run_task(&qp->comp.task, 1);
 			else
 				__rxe_do_task(&qp->comp.task);
@@ -563,7 +618,7 @@ void rxe_qp_error(struct rxe_qp *qp)
 	/* drain work and packet queues */
 	rxe_run_task(&qp->resp.task, 1);
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI)
 		rxe_run_task(&qp->comp.task, 1);
 	else
 		__rxe_do_task(&qp->comp.task);
@@ -673,7 +728,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		qp->attr.sq_psn = (attr->sq_psn & BTH_PSN_MASK);
 		qp->req.psn = qp->attr.sq_psn;
 		qp->comp.psn = qp->attr.sq_psn;
-		pr_debug("qp#%d set req psn = 0x%x\n", qp_num(qp), qp->req.psn);
+		pr_debug("qp#%d set req psn = %d comp psn = %d\n", qp_num(qp),
+				qp->req.psn, qp->comp.psn);
 	}
 
 	if (mask & IB_QP_PATH_MIG_STATE)
@@ -788,7 +844,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	qp->qp_timeout_jiffies = 0;
 	rxe_cleanup_task(&qp->resp.task);
 
-	if (qp_type(qp) == IB_QPT_RC) {
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI) {
 		del_timer_sync(&qp->retrans_timer);
 		del_timer_sync(&qp->rnr_nak_timer);
 	}
@@ -808,6 +864,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
 
+	if (qp->xrcd)
+		rxe_put(qp->xrcd);
+
 	if (qp->srq)
 		rxe_put(qp->srq);
 
@@ -830,7 +889,7 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 	if (qp->resp.mr)
 		rxe_put(qp->resp.mr);
 
-	if (qp_type(qp) == IB_QPT_RC)
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_XRC_INI)
 		sk_dst_reset(qp->sk->sk);
 
 	free_rd_atomic_resources(qp);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index ef86f0c5890e..59ba11e52bac 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -416,7 +416,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
-	struct rxe_pd *pd = to_rpd(ibqp->pd);
 	struct rxe_qp *qp = to_rqp(ibqp);
 	struct rxe_create_qp_resp __user *uresp = NULL;
 
@@ -424,16 +423,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
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
 
@@ -442,11 +432,15 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
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
 
@@ -517,6 +511,9 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	int num_sge = ibwr->num_sge;
 	struct rxe_sq *sq = &qp->sq;
 
+	if (unlikely(qp_type(qp) == IB_QPT_XRC_TGT))
+		return -EOPNOTSUPP;
+
 	if (unlikely(num_sge > sq->max_sge))
 		goto err1;
 
@@ -740,8 +737,9 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
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
index 7dab7fa3ba6c..ee482a0569b8 100644
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

