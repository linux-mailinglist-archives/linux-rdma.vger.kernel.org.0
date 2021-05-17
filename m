Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9A382D88
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 15:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbhEQNhF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbhEQNhF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 May 2021 09:37:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A59C061573
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 06:35:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j12so4659768pgh.7
        for <linux-rdma@vger.kernel.org>; Mon, 17 May 2021 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=AxKOcj0CuJv3ktci/J/Y4SI3lM8VlLIcoZWORiV/bCI=;
        b=LefU3zZdWe/fbdBzSiCAnS5WpWptVm0OX06O/9tAGl4V9KBuem+kNAINZn0KqZyM1A
         TLSJPFWUXSFDuMBg78GekHLOh1E6OSVOb2+YE79vZuSCyv5aWdhTKiC35+TCar46gVeD
         269mJH/kEHvrOPLY5fXQVRf1eDQ+Qu5g3sPHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=AxKOcj0CuJv3ktci/J/Y4SI3lM8VlLIcoZWORiV/bCI=;
        b=POzmMjCmIm8R+O2MNmb9E7Gcq4eTteD3y164nEjz7G3eVJglL8Cp4K+naTygnePQil
         ma/CS+qfyIWNOJ7pMvNQARRoGPx9fIxCdPfv+uYUCd7Vr01IAnHGjb6B6IsWilUxv5vt
         ua8xtHftvKItFTNmJ4FNIcDTc3/qYCSkNKNhQFGHYR0PRsDwUKx5T5+KRGa007k7DvHP
         jnYXXS9QvsjApXKS73eFTcsQhbEuVny72A8X0Q693lqZs389edoJWx3lZdrju7pung49
         IuufYFv6bp1UTDh81tJHOw68MdYwK0BbFw84GaXawHVWz2nkcLTLUBEGwc9BmOXHXB1Z
         kEmw==
X-Gm-Message-State: AOAM531n29WAJIbYjcl6KYm97zgiKl00LHC4SnVbkLd0uL/SWx+qlQOK
        9HlpfTAtaX6Fg5wdQWx0gr+iIqC4S/9Fglc2cfWwu8/U+uK/L3pdJf7QWQccN3lZyQt/CYtBDoM
        NxzqxG+x6Hev6XkRjuwEhTXLL2ENEDRsLz28FU1X24mYLueZ2sFi0ejjAjoA0nyvV1EOD9VqfIA
        P3Gpq0ZHKG
X-Google-Smtp-Source: ABdhPJyZcYXfXPgzI8Dn4FKaNiwb/9nvpWZe0pL7cBhMhhVR6sLJn74ErwZEOiaTeb83AaR93W41CQ==
X-Received: by 2002:a62:b604:0:b029:2d5:d7b8:b531 with SMTP id j4-20020a62b6040000b02902d5d7b8b531mr16559581pff.31.1621258547394;
        Mon, 17 May 2021 06:35:47 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b6sm10953618pjk.13.2021.05.17.06.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:35:47 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH V2 INTERNAL 3/4] bnxt_re/lib: Use separate indices for shadow queue
Date:   Mon, 17 May 2021 19:05:31 +0530
Message-Id: <20210517133532.774998-4-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517133532.774998-1-devesh.sharma@broadcom.com>
References: <20210517133532.774998-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d9cc1305c286ab7d"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000d9cc1305c286ab7d
Content-Transfer-Encoding: 8bit

The shadow queue is used for wrid and flush wqe management.
The indices used in this queue are independent to what is
actually used by hardware. Thus, detaching the shadow queue
indices from hardware queue indices. This even more useful
when the hardware queue indices has alignment other than wqe
boundary.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/main.h   |  20 ++++++
 providers/bnxt_re/memory.h |   8 +--
 providers/bnxt_re/verbs.c  | 128 ++++++++++++++++++++++---------------
 3 files changed, 101 insertions(+), 55 deletions(-)

diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index 94d42958..ad660e1a 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -437,4 +437,24 @@ static inline void bnxt_re_change_cq_phase(struct bnxt_re_cq *cq)
 	if (!cq->cqq.head)
 		cq->phase = (~cq->phase & BNXT_RE_BCQE_PH_MASK);
 }
+
+static inline void *bnxt_re_get_swqe(struct bnxt_re_joint_queue *jqq,
+				     uint32_t *wqe_idx)
+{
+	if (wqe_idx)
+		*wqe_idx = jqq->start_idx;
+	return &jqq->swque[jqq->start_idx];
+}
+
+static inline void bnxt_re_jqq_mod_start(struct bnxt_re_joint_queue *jqq,
+					 uint32_t idx)
+{
+	jqq->start_idx = jqq->swque[idx].next_idx;
+}
+
+static inline void bnxt_re_jqq_mod_last(struct bnxt_re_joint_queue *jqq,
+					uint32_t idx)
+{
+	jqq->last_idx = jqq->swque[idx].next_idx;
+}
 #endif
diff --git a/providers/bnxt_re/memory.h b/providers/bnxt_re/memory.h
index 75564c43..5bcdef9a 100644
--- a/providers/bnxt_re/memory.h
+++ b/providers/bnxt_re/memory.h
@@ -97,14 +97,14 @@ static inline uint32_t bnxt_re_incr(uint32_t val, uint32_t max)
 	return (++val & (max - 1));
 }
 
-static inline void bnxt_re_incr_tail(struct bnxt_re_queue *que)
+static inline void bnxt_re_incr_tail(struct bnxt_re_queue *que, uint8_t cnt)
 {
-	que->tail = bnxt_re_incr(que->tail, que->depth);
+	que->tail = (que->tail + cnt) & (que->depth - 1);
 }
 
-static inline void bnxt_re_incr_head(struct bnxt_re_queue *que)
+static inline void bnxt_re_incr_head(struct bnxt_re_queue *que, uint8_t cnt)
 {
-	que->head = bnxt_re_incr(que->head, que->depth);
+	que->head = (que->head + cnt) & (que->depth - 1);
 }
 
 #endif
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 8507617b..9c3cfbd3 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -247,10 +247,12 @@ static uint8_t bnxt_re_poll_err_scqe(struct bnxt_re_qp *qp,
 	struct bnxt_re_wrid *swrid;
 	struct bnxt_re_psns *spsn;
 	struct bnxt_re_cq *scq;
-	uint32_t head = sq->head;
 	uint8_t status;
+	uint32_t head;
 
 	scq = to_bnxt_re_cq(qp->ibvqp.send_cq);
+
+	head = qp->jsqq->last_idx;
 	cntx = to_bnxt_re_context(scq->ibvcq.context);
 	swrid = &qp->jsqq->swque[head];
 	spsn = swrid->psns;
@@ -267,7 +269,8 @@ static uint8_t bnxt_re_poll_err_scqe(struct bnxt_re_qp *qp,
 			BNXT_RE_PSNS_OPCD_MASK;
 	ibvwc->byte_len = 0;
 
-	bnxt_re_incr_head(sq);
+	bnxt_re_incr_head(sq, swrid->slots);
+	bnxt_re_jqq_mod_last(qp->jsqq, head);
 
 	if (qp->qpst != IBV_QPS_ERR)
 		qp->qpst = IBV_QPS_ERR;
@@ -287,13 +290,14 @@ static uint8_t bnxt_re_poll_success_scqe(struct bnxt_re_qp *qp,
 	struct bnxt_re_queue *sq = qp->jsqq->hwque;
 	struct bnxt_re_wrid *swrid;
 	struct bnxt_re_psns *spsn;
-	uint32_t head = sq->head;
 	uint8_t pcqe = false;
 	uint32_t cindx;
+	uint32_t head;
 
+	head = qp->jsqq->last_idx;
 	swrid = &qp->jsqq->swque[head];
 	spsn = swrid->psns;
-	cindx = le32toh(scqe->con_indx);
+	cindx = le32toh(scqe->con_indx) & (qp->cap.max_swr - 1);
 
 	if (!(swrid->sig & IBV_SEND_SIGNALED)) {
 		*cnt = 0;
@@ -313,8 +317,10 @@ static uint8_t bnxt_re_poll_success_scqe(struct bnxt_re_qp *qp,
 		*cnt = 1;
 	}
 
-	bnxt_re_incr_head(sq);
-	if (sq->head != cindx)
+	bnxt_re_incr_head(sq, swrid->slots);
+	bnxt_re_jqq_mod_last(qp->jsqq, head);
+
+	if (qp->jsqq->last_idx != cindx)
 		pcqe = true;
 
 	return pcqe;
@@ -352,23 +358,29 @@ static void bnxt_re_release_srqe(struct bnxt_re_srq *srq, int tag)
 static int bnxt_re_poll_err_rcqe(struct bnxt_re_qp *qp, struct ibv_wc *ibvwc,
 				 struct bnxt_re_bcqe *hdr, void *cqe)
 {
+	struct bnxt_re_context *cntx;
+	struct bnxt_re_wrid *swque;
 	struct bnxt_re_queue *rq;
+	uint8_t status, cnt = 0;
 	struct bnxt_re_cq *rcq;
-	struct bnxt_re_context *cntx;
-	uint8_t status;
+	uint32_t head = 0;
 
 	rcq = to_bnxt_re_cq(qp->ibvqp.recv_cq);
 	cntx = to_bnxt_re_context(rcq->ibvcq.context);
 
 	if (!qp->srq) {
 		rq = qp->jrqq->hwque;
-		ibvwc->wr_id = qp->jrqq->swque[rq->head].wrid;
+		head = qp->jrqq->last_idx;
+		swque = &qp->jrqq->swque[head];
+		ibvwc->wr_id = swque->wrid;
+		cnt = swque->slots;
 	} else {
 		struct bnxt_re_srq *srq;
 		int tag;
 
 		srq = qp->srq;
 		rq = srq->srqq;
+		cnt = 1;
 		tag = le32toh(hdr->qphi_rwrid) & BNXT_RE_BCQE_RWRID_MASK;
 		ibvwc->wr_id = srq->srwrid[tag].wrid;
 		bnxt_re_release_srqe(srq, tag);
@@ -387,7 +399,10 @@ static int bnxt_re_poll_err_rcqe(struct bnxt_re_qp *qp, struct ibv_wc *ibvwc,
 	ibvwc->wc_flags = 0;
 	if (qp->qptyp == IBV_QPT_UD)
 		ibvwc->src_qp = 0;
-	bnxt_re_incr_head(rq);
+
+	if (!qp->srq)
+		bnxt_re_jqq_mod_last(qp->jrqq, head);
+	bnxt_re_incr_head(rq, cnt);
 
 	if (!qp->srq) {
 		pthread_spin_lock(&cntx->fqlock);
@@ -417,14 +432,20 @@ static void bnxt_re_poll_success_rcqe(struct bnxt_re_qp *qp,
 				      struct ibv_wc *ibvwc,
 				      struct bnxt_re_bcqe *hdr, void *cqe)
 {
-	struct bnxt_re_queue *rq;
-	struct bnxt_re_rc_cqe *rcqe;
 	uint8_t flags, is_imm, is_rdma;
+	struct bnxt_re_rc_cqe *rcqe;
+	struct bnxt_re_wrid *swque;
+	struct bnxt_re_queue *rq;
+	uint32_t head = 0;
+	uint8_t cnt = 0;
 
 	rcqe = cqe;
 	if (!qp->srq) {
 		rq = qp->jrqq->hwque;
-		ibvwc->wr_id = qp->jrqq->swque[rq->head].wrid;
+		head = qp->jrqq->last_idx;
+		swque = &qp->jrqq->swque[head];
+		ibvwc->wr_id = swque->wrid;
+		cnt = swque->slots;
 	} else {
 		struct bnxt_re_srq *srq;
 		int tag;
@@ -433,6 +454,7 @@ static void bnxt_re_poll_success_rcqe(struct bnxt_re_qp *qp,
 		rq = srq->srqq;
 		tag = le32toh(hdr->qphi_rwrid) & BNXT_RE_BCQE_RWRID_MASK;
 		ibvwc->wr_id = srq->srwrid[tag].wrid;
+		cnt = 1;
 		bnxt_re_release_srqe(srq, tag);
 	}
 
@@ -463,7 +485,9 @@ static void bnxt_re_poll_success_rcqe(struct bnxt_re_qp *qp,
 	if (qp->qptyp == IBV_QPT_UD)
 		bnxt_re_fill_ud_cqe(ibvwc, hdr, cqe);
 
-	bnxt_re_incr_head(rq);
+	if (!qp->srq)
+		bnxt_re_jqq_mod_last(qp->jrqq, head);
+	bnxt_re_incr_head(rq, cnt);
 }
 
 static uint8_t bnxt_re_poll_rcqe(struct bnxt_re_qp *qp, struct ibv_wc *ibvwc,
@@ -575,7 +599,7 @@ static int bnxt_re_poll_one(struct bnxt_re_cq *cq, int nwc, struct ibv_wc *wc)
 			*qp_handle = 0x0ULL; /* mark cqe as read */
 			qp_handle = NULL;
 		}
-		bnxt_re_incr_head(&cq->cqq);
+		bnxt_re_incr_head(&cq->cqq, 1);
 		bnxt_re_change_cq_phase(cq);
 skipp_real:
 		if (cnt) {
@@ -592,21 +616,21 @@ skipp_real:
 	return dqed;
 }
 
-static int bnxt_re_poll_flush_wcs(struct bnxt_re_queue *que,
-				  struct bnxt_re_wrid *wridp,
+static int bnxt_re_poll_flush_wcs(struct bnxt_re_joint_queue *jqq,
 				  struct ibv_wc *ibvwc, uint32_t qpid,
 				  int nwc)
 {
+	uint8_t opcode = IBV_WC_RECV;
+	struct bnxt_re_queue *que;
 	struct bnxt_re_wrid *wrid;
 	struct bnxt_re_psns *psns;
-	uint32_t cnt = 0, head;
-	uint8_t opcode = IBV_WC_RECV;
+	uint32_t cnt = 0;
 
+	que = jqq->hwque;
 	while (nwc) {
 		if (bnxt_re_is_que_empty(que))
 			break;
-		head = que->head;
-		wrid = &wridp[head];
+		wrid = &jqq->swque[jqq->last_idx];
 		if (wrid->psns) {
 			psns = wrid->psns;
 			opcode = (le32toh(psns->opc_spsn) >>
@@ -621,7 +645,8 @@ static int bnxt_re_poll_flush_wcs(struct bnxt_re_queue *que,
 		ibvwc->byte_len = 0;
 		ibvwc->wc_flags = 0;
 
-		bnxt_re_incr_head(que);
+		bnxt_re_jqq_mod_last(jqq, jqq->last_idx);
+		bnxt_re_incr_head(que, wrid->slots);
 		nwc--;
 		cnt++;
 		ibvwc++;
@@ -636,8 +661,7 @@ static int bnxt_re_poll_flush_wqes(struct bnxt_re_cq *cq,
 				   int32_t nwc)
 {
 	struct bnxt_re_fque_node *cur, *tmp;
-	struct bnxt_re_wrid *wridp;
-	struct bnxt_re_queue *que;
+	struct bnxt_re_joint_queue *jqq;
 	struct bnxt_re_qp *qp;
 	bool sq_list = false;
 	uint32_t polled = 0;
@@ -648,18 +672,15 @@ static int bnxt_re_poll_flush_wqes(struct bnxt_re_cq *cq,
 			if (sq_list) {
 				qp = container_of(cur, struct bnxt_re_qp,
 						  snode);
-				que = qp->jsqq->hwque;
-				wridp = qp->jsqq->swque;
+				jqq = qp->jsqq;
 			} else {
 				qp = container_of(cur, struct bnxt_re_qp,
 						  rnode);
-				que = qp->jrqq->hwque;
-				wridp = qp->jrqq->swque;
+				jqq = qp->jrqq;
 			}
-			if (bnxt_re_is_que_empty(que))
+			if (bnxt_re_is_que_empty(jqq->hwque))
 				continue;
-			polled += bnxt_re_poll_flush_wcs(que, wridp,
-							 ibvwc + polled,
+			polled += bnxt_re_poll_flush_wcs(jqq, ibvwc + polled,
 							 qp->qpid,
 							 nwc - polled);
 			if (!(nwc - polled))
@@ -1164,14 +1185,17 @@ static void bnxt_re_fill_psns(struct bnxt_re_qp *qp, struct bnxt_re_wrid *wrid,
 		psns_ext->st_slot_idx = 0;
 }
 
-static void bnxt_re_fill_wrid(struct bnxt_re_wrid *wrid, struct ibv_send_wr *wr,
-			      uint32_t len, uint8_t sqsig)
+static void bnxt_re_fill_wrid(struct bnxt_re_wrid *wrid, uint64_t wr_id,
+			      uint32_t len, uint8_t sqsig, uint32_t st_idx,
+			      uint8_t slots)
 {
-	wrid->wrid = wr->wr_id;
+	wrid->wrid = wr_id;
 	wrid->bytes = len;
 	wrid->sig = 0;
-	if (wr->send_flags & IBV_SEND_SIGNALED || sqsig)
+	if (sqsig)
 		wrid->sig = IBV_SEND_SIGNALED;
+	wrid->st_slot_idx = st_idx;
+	wrid->slots = slots;
 }
 
 static int bnxt_re_build_send_sqe(struct bnxt_re_qp *qp, void *wqe,
@@ -1290,6 +1314,8 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 	struct bnxt_re_bsqe *hdr;
 	int ret = 0, bytes = 0;
 	bool ring_db = false;
+	uint32_t swq_idx;
+	uint32_t sig;
 	void *sqe;
 
 	pthread_spin_lock(&sq->qlock);
@@ -1316,8 +1342,6 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 		}
 
 		sqe = (void *)(sq->va + (sq->tail * sq->stride));
-		wrid = &qp->jsqq->swque[sq->tail];
-
 		memset(sqe, 0, bnxt_re_get_sqe_sz());
 		hdr = sqe;
 		is_inline = bnxt_re_set_hdr_flags(hdr, wr->send_flags,
@@ -1365,9 +1389,12 @@ int bnxt_re_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			break;
 		}
 
-		bnxt_re_fill_wrid(wrid, wr, bytes, qp->cap.sqsig);
+		wrid = bnxt_re_get_swqe(qp->jsqq, &swq_idx);
+		sig = ((wr->send_flags & IBV_SEND_SIGNALED) || qp->cap.sqsig);
+		bnxt_re_fill_wrid(wrid, wr->wr_id, bytes, sig, sq->tail, 1);
 		bnxt_re_fill_psns(qp, wrid, wr->opcode, bytes);
-		bnxt_re_incr_tail(sq);
+		bnxt_re_jqq_mod_start(qp->jsqq, swq_idx);
+		bnxt_re_incr_tail(sq, 1);
 		qp->wqe_cnt++;
 		wr = wr->next;
 		ring_db = true;
@@ -1394,16 +1421,14 @@ bad_wr:
 }
 
 static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
-			     void *rqe)
+			     void *rqe, uint32_t idx)
 {
 	struct bnxt_re_brqe *hdr = rqe;
-	struct bnxt_re_wrid *wrid;
 	struct bnxt_re_sge *sge;
 	int wqe_sz, len;
 	uint32_t hdrval;
 
 	sge = (rqe + bnxt_re_get_rqe_hdr_sz());
-	wrid = &qp->jrqq->swque[qp->jrqq->hwque->tail];
 
 	len = bnxt_re_build_sge(sge, wr->sg_list, wr->num_sge, false);
 	wqe_sz = wr->num_sge + (bnxt_re_get_rqe_hdr_sz() >> 4); /* 16B align */
@@ -1415,12 +1440,7 @@ static int bnxt_re_build_rqe(struct bnxt_re_qp *qp, struct ibv_recv_wr *wr,
 	hdrval = BNXT_RE_WR_OPCD_RECV;
 	hdrval |= ((wqe_sz & BNXT_RE_HDR_WS_MASK) << BNXT_RE_HDR_WS_SHIFT);
 	hdr->rsv_ws_fl_wt = htole32(hdrval);
-	hdr->wrid = htole32(qp->jrqq->hwque->tail);
-
-	/* Fill wrid */
-	wrid->wrid = wr->wr_id;
-	wrid->bytes = len; /* N.A. for RQE */
-	wrid->sig = 0; /* N.A. for RQE */
+	hdr->wrid = htole32(idx);
 
 	return len;
 }
@@ -1430,6 +1450,8 @@ int bnxt_re_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 {
 	struct bnxt_re_qp *qp = to_bnxt_re_qp(ibvqp);
 	struct bnxt_re_queue *rq = qp->jrqq->hwque;
+	struct bnxt_re_wrid *swque;
+	uint32_t swq_idx;
 	void *rqe;
 	int ret;
 
@@ -1451,14 +1473,18 @@ int bnxt_re_post_recv(struct ibv_qp *ibvqp, struct ibv_recv_wr *wr,
 
 		rqe = (void *)(rq->va + (rq->tail * rq->stride));
 		memset(rqe, 0, bnxt_re_get_rqe_sz());
-		ret = bnxt_re_build_rqe(qp, wr, rqe);
+		swque = bnxt_re_get_swqe(qp->jrqq, &swq_idx);
+		ret = bnxt_re_build_rqe(qp, wr, rqe, swq_idx);
 		if (ret < 0) {
 			pthread_spin_unlock(&rq->qlock);
 			*bad = wr;
 			return ENOMEM;
 		}
 
-		bnxt_re_incr_tail(rq);
+		swque = bnxt_re_get_swqe(qp->jrqq, NULL);
+		bnxt_re_fill_wrid(swque, wr->wr_id, ret, 0, rq->tail, 1);
+		bnxt_re_jqq_mod_start(qp->jrqq, swq_idx);
+		bnxt_re_incr_tail(rq, 1);
 		wr = wr->next;
 		bnxt_re_ring_rq_db(qp);
 	}
@@ -1666,7 +1692,7 @@ int bnxt_re_post_srq_recv(struct ibv_srq *ibvsrq, struct ibv_recv_wr *wr,
 		}
 
 		srq->start_idx = srq->srwrid[srq->start_idx].next_idx;
-		bnxt_re_incr_tail(rq);
+		bnxt_re_incr_tail(rq, 1);
 		wr = wr->next;
 		bnxt_re_ring_srq_db(srq);
 		count++;
-- 
2.25.1


--000000000000d9cc1305c286ab7d
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
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFDvZ/FvYs2ZM1Ya9L0PU/aT7DOb
wfm7M+CxJhdoGYSKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxNzEzMzU0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAOlDdbpV42MklAtTLu7HWe/CBdMungNJ1sJix6arY/EVBf
jD3fT9925CUDz4kSU0djVN8BkrP9ohoJd4e08nzEmh3tTG7Yz7eIVLsXhPdM9Zi7dsuzPh9XPpbu
EcjI8weFMKOQEEdK4K/r5WPcFp5iRtBpsoX9XXRUKzu7UcceHs4YVzJ1kDZCHWq7a2EAq5Ldi3WI
4H0aGfHl0BNHRGaJ2u4SWRiHwrIB92OI89HhSk1pxAGfRnWYieKBhIFA43M/g6c8Y8CBemfabNhW
9VenJ9P7ucoASWaE2JsO5TWDbBrFotdB4v7lkvEnmvx+/Vi0Q1Coo7xmP/bl+Bs8Zqml
--000000000000d9cc1305c286ab7d--
