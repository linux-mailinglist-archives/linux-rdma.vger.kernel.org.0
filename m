Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93B76AABAA
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCDRqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCDRqs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:48 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1C51B551
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:47 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bm20so4175949oib.7
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/Za0rNoBjmoBQCKcEt9mr20V3Sb0ypL/7khrurHRBE=;
        b=JJ1aLUihRHAmYtJl7F/DzXp2+xlmmZHHRwtuSeckxerwiKIZWgSmKmlZgnLLOAFE7K
         WyD/+cSFHyduNPlRUkTM9MlhuFlLRrxIt4usKi8C9NboV2YKHcBrmYgCDi7LH2LxXfj8
         ebNYLAuW2+o5DEXT9msy2c9ufV/BNxHxJA2JwDe/LecRGaEsgJ9/Jop44OELUh+HTJU8
         UlgD2EDvoRGJr3EYWan7H7Tj8XVQhk105ySdFfckq48xDGwK2J4hx9/OF7XdHfJ2Er7e
         DDJ9fAjWVnJIdTYr0wDOAdMdWbWTCTt+oAvdtQgtzXoDwwcGyUUQz1KSsjm7YJOBlOPc
         z/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/Za0rNoBjmoBQCKcEt9mr20V3Sb0ypL/7khrurHRBE=;
        b=JJeEkGXeELzoyFvCr0yaNnYHIO3YrihWLyCKdd4liNcJ5g7ptixvq3LA4Sj0ZjGMjN
         dXRTO8typpAxwQ8s+CVvxxplrbLWVaT8P6xa4yljDRNPIjRTMnqxTNSeby8lakic+Zvq
         kpQ1KT6GCh1nfMh0hsXQqnw4b0M5XDSgWPTMOI+f2yzDnZ/D9H6QjoOGMezY/2g5bZhE
         TcMxlTjBnaad08FGr7qh0hYqDhWGBOJlC7naR5cP355k9upwk5iCiIarb9ebosnGBhnO
         R4sFUsNvLUXz6tskPHyIueG3mGDW11d8lale9FYeAZDm9IGDz13riabuqAKiuIL+HP7K
         TRSQ==
X-Gm-Message-State: AO0yUKXcJ/KOIbzH7mgivLsK+u8BVvO7NUmVVAY4GLE6385OONLb2OD3
        JNTUvCYYLh0lnbM7KE3814Gn91jnhmk=
X-Google-Smtp-Source: AK7set+LiWicwCrV7DwAMFEDxxVaYEE7+YGSpWGbZgsqTIRrTlAHeKSr1TocDKiPqx738lCrKq1ZzA==
X-Received: by 2002:a05:6808:60e:b0:384:3774:603a with SMTP id y14-20020a056808060e00b003843774603amr2300983oih.14.1677952006960;
        Sat, 04 Mar 2023 09:46:46 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:46 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 4/8] RDMA/rxe: Cleanup error state handling in rxe_comp.c
Date:   Sat,  4 Mar 2023 11:45:30 -0600
Message-Id: <20230304174533.11296-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304174533.11296-1-rpearsonhpe@gmail.com>
References: <20230304174533.11296-1-rpearsonhpe@gmail.com>
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

Cleanup the handling of qp in the error state, reset state and
during rxe_qp_do_cleanup. Make the same as rxe_resp.c

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3:
  Didn't set wqe.status to IB_WC_WR_FLUSH_ERR when
  flushing send queue. This broke blktests which calls modify qp to
  set qp to IB_QPS_ERR and waits for the flushed cqe's.

 drivers/infiniband/sw/rxe/rxe_comp.c | 55 +++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_cq.c   |  1 +
 drivers/infiniband/sw/rxe/rxe_resp.c | 28 +++++++-------
 3 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index cbfa16b3a490..f7ab0dfe1034 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -542,25 +542,60 @@ static inline enum comp_state complete_wqe(struct rxe_qp *qp,
 	return COMPST_GET_WQE;
 }
 
-static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
+/* drain incoming response packet queue */
+static void drain_resp_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
-	struct rxe_send_wqe *wqe;
-	struct rxe_queue *q = qp->sq.queue;
 
 	while ((skb = skb_dequeue(&qp->resp_pkts))) {
 		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
+}
+
+/* complete send wqe with flush error */
+static int flush_send_wqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	struct rxe_cqe cqe = {};
+	struct ib_wc *wc = &cqe.ibwc;
+	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+	int err;
+
+	if (qp->is_user) {
+		uwc->wr_id = wqe->wr.wr_id;
+		uwc->status = IB_WC_WR_FLUSH_ERR;
+		uwc->qp_num = qp->ibqp.qp_num;
+	} else {
+		wc->wr_id = wqe->wr.wr_id;
+		wc->status = IB_WC_WR_FLUSH_ERR;
+		wc->qp = &qp->ibqp;
+	}
+
+	err = rxe_cq_post(qp->scq, &cqe, 0);
+	if (err)
+		rxe_dbg_cq(qp->scq, "post cq failed, err = %d", err);
+
+	return err;
+}
+
+/* drain and optionally complete the send queue
+ * if unable to complete a wqe, i.e. cq is full, stop
+ * completing and flush the remaining wqes
+ */
+static void flush_send_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_send_wqe *wqe;
+	struct rxe_queue *q = qp->sq.queue;
+	int err;
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
-			wqe->status = IB_WC_WR_FLUSH_ERR;
-			do_complete(qp, wqe);
-		} else {
-			queue_advance_consumer(q, q->type);
+			err = flush_send_wqe(qp, wqe);
+			if (err)
+				notify = 0;
 		}
+		queue_advance_consumer(q, q->type);
 	}
 }
 
@@ -589,8 +624,10 @@ int rxe_completer(struct rxe_qp *qp)
 
 	if (!qp->valid || qp->comp.state == QP_STATE_ERROR ||
 	    qp->comp.state == QP_STATE_RESET) {
-		rxe_drain_resp_pkts(qp, qp->valid &&
-				    qp->comp.state == QP_STATE_ERROR);
+		bool notify = qp->valid &&
+				(qp->comp.state == QP_STATE_ERROR);
+		drain_resp_pkts(qp);
+		flush_send_queue(qp, notify);
 		goto exit;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 22fbc198e5d1..66a13c935d50 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -114,6 +114,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
 	if (unlikely(full)) {
+		rxe_err_cq(cq, "queue full");
 		spin_unlock_irqrestore(&cq->cq_lock, flags);
 		if (cq->ibcq.event_handler) {
 			ev.device = cq->ibcq.device;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8f9bbb14fa7a..2f71183449f9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1396,7 +1396,7 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 }
 
 /* drain incoming request packet queue */
-static void rxe_drain_req_pkts(struct rxe_qp *qp)
+static void drain_req_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
 
@@ -1408,33 +1408,35 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp)
 }
 
 /* complete receive wqe with flush error */
-static int complete_flush(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
+static int flush_recv_wqe(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
 {
 	struct rxe_cqe cqe = {};
 	struct ib_wc *wc = &cqe.ibwc;
 	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+	int err;
 
 	if (qp->rcq->is_user) {
+		uwc->wr_id = wqe->wr_id;
 		uwc->status = IB_WC_WR_FLUSH_ERR;
 		uwc->qp_num = qp_num(qp);
-		uwc->wr_id = wqe->wr_id;
 	} else {
+		wc->wr_id = wqe->wr_id;
 		wc->status = IB_WC_WR_FLUSH_ERR;
 		wc->qp = &qp->ibqp;
-		wc->wr_id = wqe->wr_id;
 	}
 
-	if (rxe_cq_post(qp->rcq, &cqe, 0))
-		return -ENOMEM;
+	err = rxe_cq_post(qp->rcq, &cqe, 0);
+	if (err)
+		rxe_dbg_cq(qp->rcq, "post cq failed err = %d", err);
 
-	return 0;
+	return err;
 }
 
 /* drain and optionally complete the recive queue
  * if unable to complete a wqe stop completing and
  * just flush the remaining wqes
  */
-static void rxe_drain_recv_queue(struct rxe_qp *qp, bool notify)
+static void flush_recv_queue(struct rxe_qp *qp, bool notify)
 {
 	struct rxe_queue *q = qp->rq.queue;
 	struct rxe_recv_wqe *wqe;
@@ -1445,11 +1447,9 @@ static void rxe_drain_recv_queue(struct rxe_qp *qp, bool notify)
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
-			err = complete_flush(qp, wqe);
-			if (err) {
-				rxe_dbg_qp(qp, "complete failed for recv wqe");
+			err = flush_recv_wqe(qp, wqe);
+			if (err)
 				notify = 0;
-			}
 		}
 		queue_advance_consumer(q, q->type);
 	}
@@ -1471,8 +1471,8 @@ int rxe_responder(struct rxe_qp *qp)
 	    qp->resp.state == QP_STATE_RESET) {
 		bool notify = qp->valid &&
 				(qp->resp.state == QP_STATE_ERROR);
-		rxe_drain_req_pkts(qp);
-		rxe_drain_recv_queue(qp, notify);
+		drain_req_pkts(qp);
+		flush_recv_queue(qp, notify);
 		goto exit;
 	}
 
-- 
2.37.2

