Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96E66A6721
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 05:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCAEwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 23:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjCAEwp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 23:52:45 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BA29414
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:44 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id r40so8846129oiw.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 20:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hb4W3eRdGXxFck4oRRG5xPXA7mfBtsT9lcIN41QQXlM=;
        b=Tsvs8HH+STiwuYwZmlQfbbX9oaUmKW11LEKbVCbZZJMBethvaInvxHeP84FOTwqKm2
         jUM0B0+kyCAW03orqgOcA9Vnetg8uqnrFVOh+l1dQYPUEqnTIEt2Z8hLfRrZ2Fmajiqa
         +19VBlUrgczEvF3Cbq/Nw+FuEHT/xVdtTMUx8wNPI3UOqyCUTVxmgYOLTLM6fg3m+18i
         kE8NOdQ3p2CTM09R2S1Wih771n9yHdJ6cjThYvHnEGEdgEDq9ou9qqvkF70fitp7imYo
         Z4F4Bj7xGKcZh8ugLoiMM1YRkYcQUjSnUGmSLLr5Q0eInHTpMXBiKRJFQCn5VOsNAWNu
         mcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb4W3eRdGXxFck4oRRG5xPXA7mfBtsT9lcIN41QQXlM=;
        b=2Yi+Kz5BDeYNVrAoktrwinMY6YUgSsnzWdy5AOaBjAdZWQrWrMUOSvmZMHvT6hDzcS
         0+cH3ya6idlHH02M6qex8VtVJwiVFtjFy6w3Y5Y51SDfTVYi0O/tKme6oFg3Pmxyrq7H
         WOqzfdj6VP5J7/0/jNe55EHeOIy3ugAmxp82SYBNJScN5K89dT6z8iGTi5QcF8ddklTX
         xSaie4aEFvDlnKNHdLTv65ohWEggOtCQtlWWuG6k9heK9dn1JNfVCehxdLQYg/iK2LYN
         Qh1+2PhDAosWsSptgQ0KGTNYlSRkDkvHYpCYo7ddTibsGqi+T2CNDzu1p+xFBWcT18Ys
         aSfA==
X-Gm-Message-State: AO0yUKXo/d/rvwvHYuiLlG2bTdDsJu8boDu9R51g0fzbIcqit6rNy1DT
        beqsV2YfpT+2HQH08lHzDIE=
X-Google-Smtp-Source: AK7set8wmvmPlnFldMX4tdK6vCbBooEAeTEaKipx7YUPuxcSRwBMZue8uUQX+Sh5B/5tQvvlN+F9rA==
X-Received: by 2002:a05:6808:f04:b0:37a:2bf0:5014 with SMTP id m4-20020a0568080f0400b0037a2bf05014mr7531211oiw.2.1677646364038;
        Tue, 28 Feb 2023 20:52:44 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm5309604oib.13.2023.02.28.20.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:52:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        matsuda-daisuke@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v2 4/8] RDMA/rxe: Cleanup error state handling in rxe_comp.c
Date:   Tue, 28 Feb 2023 22:51:51 -0600
Message-Id: <20230301045154.23733-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301045154.23733-1-rpearsonhpe@gmail.com>
References: <20230301045154.23733-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_comp.c | 55 +++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_resp.c | 28 +++++++-------
 2 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index cbfa16b3a490..ebece584a020 100644
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
+		uwc->status = wqe->status;
+		uwc->qp_num = qp->ibqp.qp_num;
+	} else {
+		wc->wr_id = wqe->wr.wr_id;
+		wc->status = wqe->status;
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
+ * if unable to complete a wqe stop completing
+ * and flush the remaining wqes
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

