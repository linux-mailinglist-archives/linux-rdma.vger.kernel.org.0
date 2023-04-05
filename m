Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6B6D735C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Apr 2023 06:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjDEE1E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Apr 2023 00:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEE1D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Apr 2023 00:27:03 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA98172C
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 21:27:02 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r14so20157444oiw.12
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 21:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680668822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZnZA0C6aViBKBdFotqbjonQKG7mf5YChVdnOfdrNcc=;
        b=NyypYq1fLbZASD/yTOWIA4KIkk8/ECYatM9rTOCq0gLKTF0yqknV1xGFpJmQfEyO0Q
         UxJjsOOfqsUE/EwIXKXEPkxGHvXz330nbtJRSMtQl3OU0TTOt8enrI9PzdtJgK3j6YjL
         o6PFLegV1FE2H4SgnPi0lqSVrxQY2t4nima3keZ2bqpUNbLZUej2YbGer0n+NFYwf1X9
         Rkjw1APqWUHp7EKLSfovXA+c3AjVMncfsda6Yc5S3/qvHvWEV+npIVHNOrTBNft8tIxm
         ZPhOnfvW6V1qfmD4XV9/q0zSQJOvyXNCN6aywc5LCWo+CKqIJRSmr5kCJgn+d3+17aTt
         I7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZnZA0C6aViBKBdFotqbjonQKG7mf5YChVdnOfdrNcc=;
        b=3OxEA6pbMomDSrDpPIX/eNpSJKOJutXancK7JWvDAoP9yGJuXlpmlcWVrHHTD8q0pX
         +D8C91+T27CXTDONUSFbQH8otsYXQqh9LLK2ltPeV+2mcd8gQ4ZEF5on2GNlAlRsewmk
         JS1OQwKrl/IWGC59Tp6r+6WfSBtLjkPUEnxomNVSZe2zcndeiq/p620uWGP5Z4b14M0Z
         sUjnlIqaEAeCQLb9YN9xRelk811tfx0t0pRtn8HNmVnOYYeMLNsB/IcqjpdxuhkbPeL/
         pUKYj8wlfFTNGIJJipy86t+IX3FETVxLGHgT3PF0ND2fIQ/gmksB9u9H52iPzo5fjoMf
         Q/ig==
X-Gm-Message-State: AAQBX9cxK54WngUDG1KXue2Xo/U1ev0Yqdjr5z9c2cCRBYzRr+2o08Mp
        CSZUk5maOaLMVWtLO1RegpY=
X-Google-Smtp-Source: AKy350Yz1EIW/GAMAeXtuQhNsCojEfAz4wcPEvh6qPeM7tXkr45VmKrsNOafc8g9BT8haHgDB1Dn7w==
X-Received: by 2002:a05:6808:5cc:b0:386:db46:f6fb with SMTP id d12-20020a05680805cc00b00386db46f6fbmr1662404oij.17.1680668821717;
        Tue, 04 Apr 2023 21:27:01 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm6321326ooa.19.2023.04.04.21.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 21:26:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/5] RDMA/rxe: Remove qp->req.state
Date:   Tue,  4 Apr 2023 23:26:09 -0500
Message-Id: <20230405042611.6467-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405042611.6467-1-rpearsonhpe@gmail.com>
References: <20230405042611.6467-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver has four different QP state variables,
    qp->attr.qp_state,
    qp->req.state,
    qp->comp.state, and
    qp->resp.state.
All of these basically carry the same information.

This patch replaces uses of qp->req.state by qp->attr.qp_state
and enum rxe_qp_state.  This is the third of three patches which
will remove all but the qp->attr.qp_state variable. This will bring
the driver closer to the IBA description.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  9 +++--
 drivers/infiniband/sw/rxe/rxe_net.c   |  4 +--
 drivers/infiniband/sw/rxe/rxe_qp.c    | 49 ++++++++-------------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++---
 drivers/infiniband/sw/rxe/rxe_req.c   | 15 ++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  4 +--
 drivers/infiniband/sw/rxe/rxe_verbs.h | 10 ------
 7 files changed, 34 insertions(+), 66 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 173ebfe784e6..979990734e0c 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -491,12 +491,11 @@ static inline enum comp_state complete_ack(struct rxe_qp *qp,
 		}
 	}
 
-	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
+	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
 		/* state_lock used by requester & completer */
 		spin_lock_bh(&qp->state_lock);
-		if ((qp->req.state == QP_STATE_DRAIN) &&
-		    (qp->comp.psn == qp->req.psn)) {
-			qp->req.state = QP_STATE_DRAINED;
+		if (qp->attr.sq_draining && qp->comp.psn == qp->req.psn) {
+			qp->attr.sq_draining = 0;
 			spin_unlock_bh(&qp->state_lock);
 
 			if (qp->ibqp.event_handler) {
@@ -723,7 +722,7 @@ int rxe_completer(struct rxe_qp *qp)
 			 * (4) the timeout parameter is set
 			 */
 			if ((qp_type(qp) == IB_QPT_RC) &&
-			    (qp->req.state == QP_STATE_READY) &&
+			    (qp_state(qp) >= IB_QPS_RTS) &&
 			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
 			    qp->qp_timeout_jiffies)
 				mod_timer(&qp->retrans_timer,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2be2425083ce..9ed81d0bd25c 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -413,8 +413,8 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	int is_request = pkt->mask & RXE_REQ_MASK;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
-	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
-	    (!is_request && (qp_state(qp) <= IB_QPS_RTR))) {
+	if ((is_request && (qp_state(qp) < IB_QPS_RTS)) ||
+	    (!is_request && (qp_state(qp) < IB_QPS_RTR))) {
 		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a4486d9c540e..b9e40ad02ac6 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -231,7 +231,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->req.wqe_index = queue_get_producer(qp->sq.queue,
 					       QUEUE_TYPE_FROM_CLIENT);
 
-	qp->req.state		= QP_STATE_RESET;
 	qp->req.opcode		= -1;
 	qp->comp.opcode		= -1;
 
@@ -394,12 +393,9 @@ int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto err1;
 	}
 
-	if (mask & IB_QP_STATE) {
-		if (cur_state == IB_QPS_SQD) {
-			if (qp->req.state == QP_STATE_DRAIN &&
-			    new_state != IB_QPS_ERR)
-				goto err1;
-		}
+	if (mask & IB_QP_STATE && cur_state == IB_QPS_SQD) {
+		if (qp->attr.sq_draining && new_state != IB_QPS_ERR)
+			goto err1;
 	}
 
 	if (mask & IB_QP_PORT) {
@@ -474,9 +470,6 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_disable_task(&qp->comp.task);
 	rxe_disable_task(&qp->req.task);
 
-	/* move qp to the reset state */
-	qp->req.state = QP_STATE_RESET;
-
 	/* drain work and packet queuesc */
 	rxe_requester(qp);
 	rxe_completer(qp);
@@ -512,22 +505,9 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 	rxe_enable_task(&qp->req.task);
 }
 
-/* drain the send queue */
-static void rxe_qp_drain(struct rxe_qp *qp)
-{
-	if (qp->sq.queue) {
-		if (qp->req.state != QP_STATE_DRAINED) {
-			qp->req.state = QP_STATE_DRAIN;
-			rxe_sched_task(&qp->comp.task);
-			rxe_sched_task(&qp->req.task);
-		}
-	}
-}
-
 /* move the qp to the error state */
 void rxe_qp_error(struct rxe_qp *qp)
 {
-	qp->req.state = QP_STATE_ERROR;
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
@@ -540,6 +520,8 @@ void rxe_qp_error(struct rxe_qp *qp)
 int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		     struct ib_udata *udata)
 {
+	enum ib_qp_state cur_state = (mask & IB_QP_CUR_STATE) ?
+				attr->cur_qp_state : qp->attr.qp_state;
 	int err;
 
 	if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
@@ -656,7 +638,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 
 		case IB_QPS_INIT:
 			rxe_dbg_qp(qp, "state -> INIT\n");
-			qp->req.state = QP_STATE_INIT;
 			break;
 
 		case IB_QPS_RTR:
@@ -665,12 +646,15 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 
 		case IB_QPS_RTS:
 			rxe_dbg_qp(qp, "state -> RTS\n");
-			qp->req.state = QP_STATE_READY;
 			break;
 
 		case IB_QPS_SQD:
 			rxe_dbg_qp(qp, "state -> SQD\n");
-			rxe_qp_drain(qp);
+			if (cur_state != IB_QPS_SQD) {
+				qp->attr.sq_draining = 1;
+				rxe_sched_task(&qp->comp.task);
+				rxe_sched_task(&qp->req.task);
+			}
 			break;
 
 		case IB_QPS_SQE:
@@ -708,16 +692,11 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	rxe_av_to_attr(&qp->pri_av, &attr->ah_attr);
 	rxe_av_to_attr(&qp->alt_av, &attr->alt_ah_attr);
 
-	if (qp->req.state == QP_STATE_DRAIN) {
-		attr->sq_draining = 1;
-		/* applications that get this state
-		 * typically spin on it. yield the
-		 * processor
-		 */
+	/* Applications that get this state typically spin on it.
+	 * Yield the processor
+	 */
+	if (qp->attr.sq_draining)
 		cond_resched();
-	} else {
-		attr->sq_draining = 0;
-	}
 
 	rxe_dbg_qp(qp, "attr->sq_draining = %d\n", attr->sq_draining);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index ac42ceccf71f..ca17ac6c5878 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -39,11 +39,12 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	}
 
 	if (pkt->mask & RXE_REQ_MASK) {
-		if (unlikely(qp_state(qp) <= IB_QPS_RTR))
+		if (unlikely(qp_state(qp) < IB_QPS_RTR))
 			return -EINVAL;
-	} else if (unlikely(qp->req.state < QP_STATE_READY ||
-				qp->req.state > QP_STATE_DRAINED))
-		return -EINVAL;
+	} else {
+		if (unlikely(qp_state(qp) < IB_QPS_RTS))
+			return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 745731140a54..8a8242512f2a 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -120,13 +120,13 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 	cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
 	prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
 
-	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
+	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
 		/* check to see if we are drained;
 		 * state_lock used by requester and completer
 		 */
 		spin_lock_bh(&qp->state_lock);
 		do {
-			if (qp->req.state != QP_STATE_DRAIN) {
+			if (!qp->attr.sq_draining) {
 				/* comp just finished */
 				spin_unlock_bh(&qp->state_lock);
 				break;
@@ -139,7 +139,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 				break;
 			}
 
-			qp->req.state = QP_STATE_DRAINED;
+			qp->attr.sq_draining = 0;
 			spin_unlock_bh(&qp->state_lock);
 
 			if (qp->ibqp.event_handler) {
@@ -159,8 +159,7 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 
 	wqe = queue_addr_from_index(q, index);
 
-	if (unlikely((qp->req.state == QP_STATE_DRAIN ||
-		      qp->req.state == QP_STATE_DRAINED) &&
+	if (unlikely((qp_state(qp) == IB_QPS_SQD) &&
 		     (wqe->state != wqe_state_processing)))
 		return NULL;
 
@@ -656,7 +655,7 @@ int rxe_requester(struct rxe_qp *qp)
 	if (unlikely(!qp->valid))
 		goto exit;
 
-	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
+	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
 		wqe = req_next_wqe(qp);
 		if (wqe)
 			/*
@@ -667,7 +666,7 @@ int rxe_requester(struct rxe_qp *qp)
 			goto exit;
 	}
 
-	if (unlikely(qp->req.state == QP_STATE_RESET)) {
+	if (unlikely(qp_state(qp) == IB_QPS_RESET)) {
 		qp->req.wqe_index = queue_get_consumer(q,
 						QUEUE_TYPE_FROM_CLIENT);
 		qp->req.opcode = -1;
@@ -836,7 +835,7 @@ int rxe_requester(struct rxe_qp *qp)
 	/* update wqe_index for each wqe completion */
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
-	qp->req.state = QP_STATE_ERROR;
+	qp->attr.qp_state = IB_QPS_ERR;
 	rxe_sched_task(&qp->comp.task);
 exit:
 	ret = -EAGAIN;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 2a5da3160db9..28799f1cacb8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -881,7 +881,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
 	if (!err)
 		rxe_sched_task(&qp->req.task);
 
-	if (unlikely(qp->req.state == QP_STATE_ERROR))
+	if (unlikely(qp_state(qp) == IB_QPS_ERR))
 		rxe_sched_task(&qp->comp.task);
 
 	return err;
@@ -900,7 +900,7 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		goto err_out;
 	}
 
-	if (unlikely(qp->req.state < QP_STATE_READY)) {
+	if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
 		*bad_wr = wr;
 		err = -EINVAL;
 		rxe_dbg_qp(qp, "qp not ready to send");
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 1ae8dfd0ce7b..26a20f088692 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -102,17 +102,7 @@ struct rxe_srq {
 	int			error;
 };
 
-enum rxe_qp_state {
-	QP_STATE_RESET,
-	QP_STATE_INIT,
-	QP_STATE_READY,
-	QP_STATE_DRAIN,		/* req only */
-	QP_STATE_DRAINED,	/* req only */
-	QP_STATE_ERROR
-};
-
 struct rxe_req_info {
-	enum rxe_qp_state	state;
 	int			wqe_index;
 	u32			psn;
 	int			opcode;
-- 
2.37.2

