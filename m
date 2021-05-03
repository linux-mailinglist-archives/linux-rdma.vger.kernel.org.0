Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE31D3711B8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhECGtR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 02:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhECGtP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 02:49:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F99BC06174A
        for <linux-rdma@vger.kernel.org>; Sun,  2 May 2021 23:48:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i190so3453730pfc.12
        for <linux-rdma@vger.kernel.org>; Sun, 02 May 2021 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ydJlfORRJGno2vbsBJz/rxcGZaiw0BGJ6KRAYYnVMT0=;
        b=NgjhKP1DLi4yzeGfhBbyeRVF/WM1UzdLzGMI/+mcUs/ifiHCCsQzZ4Y3by10Lu+S7x
         PedAZBKvBVzOumykgkiUEE6sIisxo2AeTFY9Z/Y2b/scj7BgJdolNmJzFcuOuRFZnTC8
         cZTbKIPubtHKQ2ijo5hXSjzrC1ubiXKjn8P8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ydJlfORRJGno2vbsBJz/rxcGZaiw0BGJ6KRAYYnVMT0=;
        b=dQtq0kX7RXw1LbibAbXiGxVpVN6+dlbB9Cga9NQuSA8tOg5l1KpbN9HFjB5JkheZh3
         FluJsU6BZZzkckGTKV2dAM9pzdATnJxg3ET8RbYEMe3QrjdkDyJR3tvRaFkZ662wWKAy
         +lATJD2arwn2BnoYaxxnALx4S19noIL8mWWg/Zpf/4juqiMkmdn7oloGZ1pl/YfA9NKG
         yHKgd8La08NEK5G05TADZpQKf6qaKarxGSnBad2BHWrauPWCvQZ3ISICD7676SNwatHQ
         Z1xOPfM/+OWbxrdW6PX3bOZRXt6PQsZQrLMDLhROPnoT/dxVT2H6Otcc1hqoRCw77xPu
         rxXg==
X-Gm-Message-State: AOAM5307tyw+c3NZPQcJ8/Uk+4JZeMIb8xoEUsQepmD6r8mH1DUnwiDJ
        Qa2iQMEo32UaB8O/bAeNOe+fH5EWF6feMvSW4mglp0AeW6W5ZvoO3S4aQJRIXlx9at1/eTZm88z
        NFDyTrdM0XpPGdZ4UR8hQWHEIYHr6yXz294QXfOP+pu+vuRtq88AaXxYrHB3CZZURQS5NHxU94W
        U9yPVOmGh9
X-Google-Smtp-Source: ABdhPJxkerP1deT0pbsKPSF9BIJYdtmH9UVlB787J3KZ4JoKQtSOZEqiEv+ZHEzNPmCRAGsvrrRFXg==
X-Received: by 2002:a05:6a00:bc7:b029:28e:aa38:6332 with SMTP id x7-20020a056a000bc7b029028eaa386332mr2027324pfu.34.1620024500498;
        Sun, 02 May 2021 23:48:20 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i9sm19585389pjh.9.2021.05.02.23.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 23:48:20 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [rdma-core 3/4] bnxt_re/lib: consolidate hwque and swque in common structure
Date:   Mon,  3 May 2021 12:18:01 +0530
Message-Id: <20210503064802.457482-4-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503064802.457482-1-devesh.sharma@broadcom.com>
References: <20210503064802.457482-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f15a9a05c167588b"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000f15a9a05c167588b
Content-Transfer-Encoding: 8bit

Consolidating hardware queue (hwque) and software queue (swque)
under a single bookkeeping data structure bnxt_re_joint_queue.

This is to ease the hardware and software queue management. Further
reduces the size of bnxt_re_qp structure.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/db.c    |   6 +-
 providers/bnxt_re/main.h  |  13 ++--
 providers/bnxt_re/verbs.c | 133 +++++++++++++++++++++-----------------
 3 files changed, 87 insertions(+), 65 deletions(-)

diff --git a/providers/bnxt_re/db.c b/providers/bnxt_re/db.c
index 85da182e..3c797573 100644
--- a/providers/bnxt_re/db.c
+++ b/providers/bnxt_re/db.c
@@ -63,7 +63,8 @@ void bnxt_re_ring_rq_db(struct bnxt_re_qp *qp)
 {
 	struct bnxt_re_db_hdr hdr;
 
-	bnxt_re_init_db_hdr(&hdr, qp->rqq->tail, qp->qpid, BNXT_RE_QUE_TYPE_RQ);
+	bnxt_re_init_db_hdr(&hdr, qp->jrqq->hwque->tail,
+			    qp->qpid, BNXT_RE_QUE_TYPE_RQ);
 	bnxt_re_ring_db(qp->udpi, &hdr);
 }
 
@@ -71,7 +72,8 @@ void bnxt_re_ring_sq_db(struct bnxt_re_qp *qp)
 {
 	struct bnxt_re_db_hdr hdr;
 
-	bnxt_re_init_db_hdr(&hdr, qp->sqq->tail, qp->qpid, BNXT_RE_QUE_TYPE_SQ);
+	bnxt_re_init_db_hdr(&hdr, qp->jsqq->hwque->tail,
+			    qp->qpid, BNXT_RE_QUE_TYPE_SQ);
 	bnxt_re_ring_db(qp->udpi, &hdr);
 }
 
diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index 368297e6..d470e30a 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -120,13 +120,18 @@ struct bnxt_re_srq {
 	bool arm_req;
 };
 
+struct bnxt_re_joint_queue {
+	struct bnxt_re_queue *hwque;
+	struct bnxt_re_wrid *swque;
+	uint32_t start_idx;
+	uint32_t last_idx;
+};
+
 struct bnxt_re_qp {
 	struct ibv_qp ibvqp;
 	struct bnxt_re_chip_ctx *cctx;
-	struct bnxt_re_queue *sqq;
-	struct bnxt_re_wrid *swrid;
-	struct bnxt_re_queue *rqq;
-	struct bnxt_re_wrid *rwrid;
+	struct bnxt_re_joint_queue *jsqq;
+	struct bnxt_re_joint_queue *jrqq;
 	struct bnxt_re_srq *srq;
 	struct bnxt_re_cq *scq;
 	struct bnxt_re_cq *rcq;
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 760e840a..4344b3dd 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -242,7 +242,7 @@ static uint8_t bnxt_re_poll_err_scqe(struct bnxt_re_qp *qp,
 				     struct bnxt_re_bcqe *hdr,
 				     struct bnxt_re_req_cqe *scqe, int *cnt)
 {
-	struct bnxt_re_queue *sq = qp->sqq;
+	struct bnxt_re_queue *sq = qp->jsqq->hwque;
 	struct bnxt_re_context *cntx;
 	struct bnxt_re_wrid *swrid;
 	struct bnxt_re_psns *spsn;
@@ -252,7 +252,7 @@ static uint8_t bnxt_re_poll_err_scqe(struct bnxt_re_qp *qp,
 
 	scq = to_bnxt_re_cq(qp->ibvqp.send_cq);
 	cntx = to_bnxt_re_context(scq->ibvcq.context);
-	swrid = &qp->swrid[head];
+	swrid = &qp->jsqq->swque[head];
 	spsn = swrid->psns;
 
 	*cnt = 1;
@@ -267,7 +267,7 @@ static uint8_t bnxt_re_poll_err_scqe(struct bnxt_re_qp *qp,
 			BNXT_RE_PSNS_OPCD_MASK;
 	ibvwc->byte_len = 0;
 
-	bnxt_re_incr_head(qp->sqq);
+	bnxt_re_incr_head(sq);
 
 	if (qp->qpst != IBV_QPS_ERR)
 		qp->qpst = IBV_QPS_ERR;
@@ -284,14 +284,14 @@ static uint8_t bnxt_re_poll_success_scqe(struct bnxt_re_qp *qp,
 					 struct bnxt_re_req_cqe *scqe,
 					 int *cnt)
 {
-	struct bnxt_re_queue *sq = qp->sqq;
+	struct bnxt_re_queue *sq = qp->jsqq->hwque;
 	struct bnxt_re_wrid *swrid;
 	struct bnxt_re_psns *spsn;
-	uint8_t pcqe = false;
 	uint32_t head = sq->head;
+	uint8_t pcqe = false;
 	uint32_t cindx;
 
-	swrid = &qp->swrid[head];
+	swrid = &qp->jsqq->swque[head];
 	spsn = swrid->psns;
 	cindx = le32toh(scqe->con_indx);
 
@@ -361,8 +361,8 @@ static int bnxt_re_poll_err_rcqe(struct bnxt_re_qp *qp, struct ibv_wc *ibvwc,
 	cntx = to_bnxt_re_context(rcq->ibvcq.context);
 
 	if (!qp->srq) {
-		rq = qp->rqq;
-		ibvwc->wr_id = qp->rwrid[rq->head].wrid;
+		rq = qp->jrqq->hwque;
+		ibvwc->wr_id = qp->jrqq->swque[rq->head].wrid;
 	} else {
 		struct bnxt_re_srq *srq;
 		int tag;
@@ -423,8 +423,8 @@ static void bnxt_re_poll_success_rcqe(struct bnxt_re_qp *qp,
 
 	rcqe = cqe;
 	if (!qp->srq) {
-		rq = qp->rqq;
-		ibvwc->wr_id = qp->rwrid[rq->head].wrid;
+		rq = qp->jrqq->hwque;
+		ibvwc->wr_id = qp->jrqq->swque[rq->head].wrid;
 	} else {
 		struct bnxt_re_srq *srq;
 		int tag;
@@ -648,13 +648,13 @@ static int bnxt_re_poll_flush_wqes(struct bnxt_re_cq *cq,
 			if (sq_list) {
 				qp = container_of(cur, struct bnxt_re_qp,
 						  snode);
-				que = qp->sqq;
-				wridp = qp->swrid;
+				que = qp->jsqq->hwque;
+				wridp = qp->jsqq->swque;
 			} else {
 				qp = container_of(cur, struct bnxt_re_qp,
 						  rnode);
-				que = qp->rqq;
-				wridp = qp->rwrid;
+				que = qp->jrqq->hwque;
+				wridp = qp->jrqq->swque;
 			}
 			if (bnxt_re_is_que_empty(que))
 				continue;
@@ -802,55 +802,68 @@ static int bnxt_re_check_qp_limits(struct bnxt_re_context *cntx,
 
 static void bnxt_re_free_queue_ptr(struct bnxt_re_qp *qp)
 {
-	if (qp->rqq)
-		free(qp->rqq);
-	if (qp->sqq)
-		free(qp->sqq);
+	free(qp->jrqq->hwque);
+	free(qp->jrqq);
+	free(qp->jsqq->hwque);
+	free(qp->jsqq);
 }
 
 static int bnxt_re_alloc_queue_ptr(struct bnxt_re_qp *qp,
 				   struct ibv_qp_init_attr *attr)
 {
-	qp->sqq = calloc(1, sizeof(struct bnxt_re_queue));
-	if (!qp->sqq)
-		return -ENOMEM;
+	int rc = -ENOMEM;
+
+	qp->jsqq = calloc(1, sizeof(struct bnxt_re_joint_queue));
+	if (!qp->jsqq)
+		return rc;
+	qp->jsqq->hwque = calloc(1, sizeof(struct bnxt_re_queue));
+	if (!qp->jsqq->hwque)
+		goto fail;
+
 	if (!attr->srq) {
-		qp->rqq = calloc(1, sizeof(struct bnxt_re_queue));
-		if (!qp->rqq) {
-			free(qp->sqq);
-			return -ENOMEM;
+		qp->jrqq = calloc(1, sizeof(struct bnxt_re_joint_queue));
+		if (!qp->jrqq) {
+			free(qp->jsqq);
+			goto fail;
 		}
+		qp->jrqq->hwque = calloc(1, sizeof(struct bnxt_re_queue));
+		if (!qp->jrqq->hwque)
+			goto fail;
 	}
 
 	return 0;
+fail:
+	bnxt_re_free_queue_ptr(qp);
+	return rc;
 }
 
 static void bnxt_re_free_queues(struct bnxt_re_qp *qp)
 {
-	if (qp->rqq) {
-		if (qp->rwrid)
-			free(qp->rwrid);
-		pthread_spin_destroy(&qp->rqq->qlock);
-		bnxt_re_free_aligned(qp->rqq);
+	if (qp->jrqq) {
+		if (qp->jrqq->swque)
+			free(qp->jrqq->swque);
+		pthread_spin_destroy(&qp->jrqq->hwque->qlock);
+		bnxt_re_free_aligned(qp->jrqq->hwque);
 	}
 
-	if (qp->swrid)
-		free(qp->swrid);
-	pthread_spin_destroy(&qp->sqq->qlock);
-	bnxt_re_free_aligned(qp->sqq);
+	if (qp->jsqq->swque)
+		free(qp->jsqq->swque);
+	pthread_spin_destroy(&qp->jsqq->hwque->qlock);
+	bnxt_re_free_aligned(qp->jsqq->hwque);
 }
 
 static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 				struct ibv_qp_init_attr *attr,
 				uint32_t pg_size) {
 	struct bnxt_re_psns_ext *psns_ext;
+	struct bnxt_re_wrid *swque;
 	struct bnxt_re_queue *que;
 	struct bnxt_re_psns *psns;
 	uint32_t psn_depth;
 	uint32_t psn_size;
 	int ret, indx;
 
-	que = qp->sqq;
+	que = qp->jsqq->hwque;
 	que->stride = bnxt_re_get_sqe_sz();
 	/* 8916 adjustment */
 	que->depth = roundup_pow_of_two(attr->cap.max_send_wr + 1 +
@@ -870,7 +883,7 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 	 * is UD-qp. UD-qp use this memory to maintain WC-opcode.
 	 * See definition of bnxt_re_fill_psns() for the use case.
 	 */
-	ret = bnxt_re_alloc_aligned(qp->sqq, pg_size);
+	ret = bnxt_re_alloc_aligned(que, pg_size);
 	if (ret)
 		return ret;
 	/* exclude psns depth*/
@@ -878,36 +891,38 @@ static int bnxt_re_alloc_queues(struct bnxt_re_qp *qp,
 	/* start of spsn space sizeof(struct bnxt_re_psns) each. */
 	psns = (que->va + que->stride * que->depth);
 	psns_ext = (struct bnxt_re_psns_ext *)psns;
-	pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
-	qp->swrid = calloc(que->depth, sizeof(struct bnxt_re_wrid));
-	if (!qp->swrid) {
+	swque = calloc(que->depth, sizeof(struct bnxt_re_wrid));
+	if (!swque) {
 		ret = -ENOMEM;
 		goto fail;
 	}
 
 	for (indx = 0 ; indx < que->depth; indx++, psns++)
-		qp->swrid[indx].psns = psns;
+		swque[indx].psns = psns;
 	if (bnxt_re_is_chip_gen_p5(qp->cctx)) {
 		for (indx = 0 ; indx < que->depth; indx++, psns_ext++) {
-			qp->swrid[indx].psns_ext = psns_ext;
-			qp->swrid[indx].psns = (struct bnxt_re_psns *)psns_ext;
+			swque[indx].psns_ext = psns_ext;
+			swque[indx].psns = (struct bnxt_re_psns *)psns_ext;
 		}
 	}
+	qp->jsqq->swque = swque;
 
 	qp->cap.max_swr = que->depth;
+	pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
 
-	if (qp->rqq) {
-		que = qp->rqq;
+	if (qp->jrqq) {
+		que = qp->jrqq->hwque;
 		que->stride = bnxt_re_get_rqe_sz();
 		que->depth = roundup_pow_of_two(attr->cap.max_recv_wr + 1);
 		que->diff = que->depth - attr->cap.max_recv_wr;
-		ret = bnxt_re_alloc_aligned(qp->rqq, pg_size);
+		ret = bnxt_re_alloc_aligned(que, pg_size);
 		if (ret)
 			goto fail;
 		pthread_spin_init(&que->qlock, PTHREAD_PROCESS_PRIVATE);
 		/* For RQ only bnxt_re_wri.wrid is used. */
-		qp->rwrid = calloc(que->depth, sizeof(struct bnxt_re_wrid));
-		if (!qp->rwrid) {
+		qp->jrqq->swque = calloc(que->depth,
+					 sizeof(struct bnxt_re_wrid));
+		if (!qp->jrqq->swque) {
 			ret = -ENOMEM;
 			goto fail;
 		}
@@ -946,8 +961,8 @@ struct ibv_qp *bnxt_re_create_qp(struct ibv_pd *ibvpd,
 		goto failq;
 	/* Fill ibv_cmd */
 	cap = &qp->cap;
-	req.qpsva = (uintptr_t)qp->sqq->va;
-	req.qprva = qp->rqq ? (uintptr_t)qp->rqq->va : 0;
+	req.qpsva = (uintptr_t)qp->jsqq->hwque->va;
+	req.qprva = qp->jrqq ? (uintptr_t)qp->jrqq->hwque->va : 0;
 	req.qp_handle = (uintptr_t)qp;
 
 	if (ibv_cmd_create_qp(ibvpd, &qp->ibvqp, attr, &req.ibv_cmd, sizeof(req),
@@ -995,11 +1010,11 @@ int bnxt_re_modify_qp(struct ibv_qp *ibvqp, struct ibv_qp_attr *attr,
 			qp->qpst = attr->qp_state;
 			/* transition to reset */
 			if (qp->qpst == IBV_QPS_RESET) {
-				qp->sqq->head = 0;
-				qp->sqq->tail = 0;
-				if (qp->rqq) {
-					qp->rqq->head = 0;
-					qp->rqq->tail = 0;
+				qp->jsqq->hwque->head = 0;
+				qp->jsqq->hwque->tail = 0;
+				if (qp->jrqq) {
+					qp->jrqq->hwque->head = 0;
+					qp->jrqq->hwque->tail = 0;
 				}
 			}
 		}
@@ -1257,7 +1272,7 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 		      struct ibv_send_wr **bad)
 {
 	struct bnxt_re_qp *qp = to_bnxt_re_qp(ibvqp);
-	struct bnxt_re_queue *sq = qp->sqq;
+	struct bnxt_re_queue *sq = qp->jsqq->hwque;
 	struct bnxt_re_wrid *wrid;
 	uint8_t is_inline = false;
 	struct bnxt_re_bsqe *hdr;
@@ -1289,7 +1304,7 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 		}
 
 		sqe = (void *)(sq->va + (sq->tail * sq->stride));
-		wrid = &qp->swrid[sq->tail];
+		wrid = &qp->jsqq->swque[sq->tail];
 
 		memset(sqe, 0, bnxt_re_get_sqe_sz());
 		hdr = sqe;
@@ -1376,7 +1391,7 @@ static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
 	uint32_t hdrval;
 
 	sge = (rqe + bnxt_re_get_rqe_hdr_sz());
-	wrid = &qp->rwrid[qp->rqq->tail];
+	wrid = &qp->jrqq->swque[qp->jrqq->hwque->tail];
 
 	len = bnxt_re_build_sge(sge, wr->sg_list, wr->num_sge, false);
 	wqe_sz = wr->num_sge + (bnxt_re_get_rqe_hdr_sz() >> 4); /* 16B align */
@@ -1388,7 +1403,7 @@ static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
 	hdrval = BNXT_RE_WR_OPCD_RECV;
 	hdrval |= ((wqe_sz & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT);
 	hdr->rsv_ws_fl_wt = htole32(hdrval);
-	hdr->wrid = htole32(qp->rqq->tail);
+	hdr->wrid = htole32(qp->jrqq->hwque->tail);
 
 	/* Fill wrid */
 	wrid->wrid = wr->wr_id;
@@ -1402,7 +1417,7 @@ int bnxt_re_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 		      struct ibv_recv_wr **bad)
 {
 	struct bnxt_re_qp *qp = to_bnxt_re_qp(ibvqp);
-	struct bnxt_re_queue *rq = qp->rqq;
+	struct bnxt_re_queue *rq = qp->jrqq->hwque;
 	void *rqe;
 	int ret;
 
-- 
2.25.1


--000000000000f15a9a05c167588b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHlgUO25JL8FdAPCQe9pj0a3u/xe
4Syl51rzXV2MWxpuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUwMzA2NDgyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA/Tsh/XJo74HyZjAiUIV3wwy09qc7yEjq7XB3M+pMuh6Al
Ect7JzmEbP2GxPLiPvMWNTl3pyPsAMqmL+aF2iAbvH74Wtjp41yKzH+Rgm5H47s1P+c3jictA157
ZlG+JdyJ/wDzeXGNmjk3sjd7toGnBCzK0d/Y7yVOhObT/GsEZXGajcR/sY395tv8grcP8tjwcfw+
eYe0XAzLsfns7ajwr6iYxtrJd88F0QAmK+DL8h4C4JHM/l1kxThmpDLtsP7LlLINoBfwDXab04TL
zytsQPdymEaKVzXqiI9YU0d/YvfAMrtzxuHlw4XJlpOZRsxgB0/iDUOivN7KZL7n8KLs
--000000000000f15a9a05c167588b--
