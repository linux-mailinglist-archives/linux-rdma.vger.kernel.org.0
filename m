Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08036AABA9
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Mar 2023 18:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjCDRqs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 4 Mar 2023 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjCDRqs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Mar 2023 12:46:48 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33AB1B337
        for <linux-rdma@vger.kernel.org>; Sat,  4 Mar 2023 09:46:46 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-176261d7f45so6741834fac.11
        for <linux-rdma@vger.kernel.org>; Sat, 04 Mar 2023 09:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677952006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy4MUf6ImzMyVsqFV+19sqrqNEbtSZnRPY2EyyDlDOE=;
        b=HbhmKGZzLxP34K4IV2XySW6vDLlH4pqHD067FIT7OPj9BPjZODvsgFaXm8MN/SCRA0
         ZoZMg1eUHCz23VoWIGJXWJRWw0yc1MWGqEuvZcss5i6bBRJmR+211ziu3YKZg7ZXaq6C
         JNIZyPF1Lg0A91zb/8sQjqN5YCBrhjI9FbKJzrE59RHifuRbZyCV8d/gfJa1Zy6s2k98
         e0Eyu43xuvgivPup1QGyfOeNtkJhqBbIO4Yb08HTgtrbpgegxYi9N4HwnDQSZ9mY+2GY
         g2ZsM9+vbBQTrxeUBxbAdEVhEaDI2FpWZuVprnhWIdzqdNWeR1v0SqhN3bNZG6wfoL3s
         +IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677952006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy4MUf6ImzMyVsqFV+19sqrqNEbtSZnRPY2EyyDlDOE=;
        b=4Vvl2wqE2hnvnLuLcwKTCEYCviYH2CAIfWvz3q02m5D8T/Edknvz/Yn82HSwSqcUH4
         yfiGrDSILeklLOlKDby9DJG6hXfXSxsfsP4YVMsBA5X0PDGcoPR5xtkb47MstEIWb0qq
         ylAG9OgNHdPayQR81opbO3zBDG+0teNC4f6ASmXssPRR1IWFmHvJsitPWVsHYDxV4MVW
         RO15qgF9bWtrquQAWxQkwyjuax4gm4ag6qY6WNYrSqEfGZobPopkXrXuRSX11paRee8N
         uQGTu6n7nrz/IjtvxN13dlomaCoUbwTC4JOhsQJLJfpJnRT4GVelloPqyfGqMRbUFMsf
         rQew==
X-Gm-Message-State: AO0yUKXrO5j/vuwEekm1zCkAXg0cm4MHxMJzEQqRKcseM9mtVwPTS2TH
        q04eJ8RFbDG7mwT+c6j1q18=
X-Google-Smtp-Source: AK7set/PTUiO1ySDLDmwgegNFPigxrtXvBsrS0sadluOev0bVokM4Rna3Hzhi2txLV6m8ajE75J7dg==
X-Received: by 2002:a05:6870:d1c5:b0:176:46ba:2744 with SMTP id b5-20020a056870d1c500b0017646ba2744mr3968303oac.19.1677952006003;
        Sat, 04 Mar 2023 09:46:46 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-f848-0c36-f4e0-0517.res6.spectrum.com. [2603:8081:140c:1a00:f848:c36:f4e0:517])
        by smtp.gmail.com with ESMTPSA id a1-20020a056830008100b0068bcadcad5bsm2311227oto.57.2023.03.04.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 09:46:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 3/8] RDMA/rxe: Cleanup reset state handling in rxe_resp.c
Date:   Sat,  4 Mar 2023 11:45:29 -0600
Message-Id: <20230304174533.11296-4-rpearsonhpe@gmail.com>
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
during rxe_qp_do_cleanup. The error state does about the same
thing as the others but has code spread all over.

This patch combines them in a cleaner way.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h      |   1 -
 drivers/infiniband/sw/rxe/rxe_resp.c | 107 ++++++++++++++-------------
 2 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index bd8a8ea4ea8f..d33dd6cf83d3 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -133,7 +133,6 @@ enum resp_states {
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
 	RESPST_ERROR,
-	RESPST_RESET,
 	RESPST_DONE,
 	RESPST_EXIT,
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7cb1b962d665..8f9bbb14fa7a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -42,7 +42,6 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
 	[RESPST_ERROR]				= "ERROR",
-	[RESPST_RESET]				= "RESET",
 	[RESPST_DONE]				= "DONE",
 	[RESPST_EXIT]				= "EXIT",
 };
@@ -69,17 +68,6 @@ static inline enum resp_states get_req(struct rxe_qp *qp,
 {
 	struct sk_buff *skb;
 
-	if (qp->resp.state == QP_STATE_ERROR) {
-		while ((skb = skb_dequeue(&qp->req_pkts))) {
-			rxe_put(qp);
-			kfree_skb(skb);
-			ib_device_put(qp->ibqp.device);
-		}
-
-		/* go drain recv wr queue */
-		return RESPST_CHK_RESOURCE;
-	}
-
 	skb = skb_peek(&qp->req_pkts);
 	if (!skb)
 		return RESPST_EXIT;
@@ -334,24 +322,6 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 {
 	struct rxe_srq *srq = qp->srq;
 
-	if (qp->resp.state == QP_STATE_ERROR) {
-		if (qp->resp.wqe) {
-			qp->resp.status = IB_WC_WR_FLUSH_ERR;
-			return RESPST_COMPLETE;
-		} else if (!srq) {
-			qp->resp.wqe = queue_head(qp->rq.queue,
-					QUEUE_TYPE_FROM_CLIENT);
-			if (qp->resp.wqe) {
-				qp->resp.status = IB_WC_WR_FLUSH_ERR;
-				return RESPST_COMPLETE;
-			} else {
-				return RESPST_EXIT;
-			}
-		} else {
-			return RESPST_EXIT;
-		}
-	}
-
 	if (pkt->mask & (RXE_READ_OR_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		/* it is the requesters job to not send
 		 * too many read/atomic ops, we just
@@ -1425,22 +1395,66 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 	}
 }
 
-static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
+/* drain incoming request packet queue */
+static void rxe_drain_req_pkts(struct rxe_qp *qp)
 {
 	struct sk_buff *skb;
-	struct rxe_queue *q = qp->rq.queue;
 
 	while ((skb = skb_dequeue(&qp->req_pkts))) {
 		rxe_put(qp);
 		kfree_skb(skb);
 		ib_device_put(qp->ibqp.device);
 	}
+}
+
+/* complete receive wqe with flush error */
+static int complete_flush(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
+{
+	struct rxe_cqe cqe = {};
+	struct ib_wc *wc = &cqe.ibwc;
+	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+
+	if (qp->rcq->is_user) {
+		uwc->status = IB_WC_WR_FLUSH_ERR;
+		uwc->qp_num = qp_num(qp);
+		uwc->wr_id = wqe->wr_id;
+	} else {
+		wc->status = IB_WC_WR_FLUSH_ERR;
+		wc->qp = &qp->ibqp;
+		wc->wr_id = wqe->wr_id;
+	}
+
+	if (rxe_cq_post(qp->rcq, &cqe, 0))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* drain and optionally complete the recive queue
+ * if unable to complete a wqe stop completing and
+ * just flush the remaining wqes
+ */
+static void rxe_drain_recv_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_queue *q = qp->rq.queue;
+	struct rxe_recv_wqe *wqe;
+	int err;
 
-	if (notify)
+	if (qp->srq)
 		return;
 
-	while (!qp->srq && q && queue_head(q, q->type))
+	while ((wqe = queue_head(q, q->type))) {
+		if (notify) {
+			err = complete_flush(qp, wqe);
+			if (err) {
+				rxe_dbg_qp(qp, "complete failed for recv wqe");
+				notify = 0;
+			}
+		}
 		queue_advance_consumer(q, q->type);
+	}
+
+	qp->resp.wqe = NULL;
 }
 
 int rxe_responder(struct rxe_qp *qp)
@@ -1453,20 +1467,18 @@ int rxe_responder(struct rxe_qp *qp)
 	if (!rxe_get(qp))
 		return -EAGAIN;
 
-	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
-
-	if (!qp->valid)
+	if (!qp->valid || qp->resp.state == QP_STATE_ERROR ||
+	    qp->resp.state == QP_STATE_RESET) {
+		bool notify = qp->valid &&
+				(qp->resp.state == QP_STATE_ERROR);
+		rxe_drain_req_pkts(qp);
+		rxe_drain_recv_queue(qp, notify);
 		goto exit;
+	}
 
-	switch (qp->resp.state) {
-	case QP_STATE_RESET:
-		state = RESPST_RESET;
-		break;
+	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-	default:
-		state = RESPST_GET_REQ;
-		break;
-	}
+	state = RESPST_GET_REQ;
 
 	while (1) {
 		rxe_dbg_qp(qp, "state = %s\n", resp_state_name[state]);
@@ -1625,11 +1637,6 @@ int rxe_responder(struct rxe_qp *qp)
 
 			goto exit;
 
-		case RESPST_RESET:
-			rxe_drain_req_pkts(qp, false);
-			qp->resp.wqe = NULL;
-			goto exit;
-
 		case RESPST_ERROR:
 			qp->resp.goto_error = 0;
 			rxe_dbg_qp(qp, "moved to error state\n");
-- 
2.37.2

