Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A673611F9C
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJ2DKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 23:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJ2DKn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 23:10:43 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171929818
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:22 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-13ae8117023so8327945fac.9
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BkUIhKPeo9V7NcaZnYbiCv3hvi8SppsEDDvvMCB51U=;
        b=WQNZdsUj23WRZneckh8QEPvzmubw37hTFeDmbx+z7MGE45YmllCx4L3xg/ihV9ZCev
         r0bwhNiCqq+Xkjk0fl502DD3Wm6hM5QVbTb+26ZMFpo9k1pSAXRy41pLiZpW7JBK09ox
         eWzlFpck7/lp53KhLs0SP/eoxwjE8TBwwPgk2Yc8rcEoYn7G1UD2gzvo7FMi+VX3udy3
         kOB1uzlwfgTrZiTO3c4ImE8M5+SeySLNd5vtBYn4CQXOSGtUhX38h0udnt+pr7auzR97
         mwyE4Cs6LF+c6K6LqTG7EDiPjhQb73v4pLirmLWpDhAXT6U8+pZ98jYvNKs9+VG3E8s7
         Nr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BkUIhKPeo9V7NcaZnYbiCv3hvi8SppsEDDvvMCB51U=;
        b=dp6jAeKG4JQgN0rB3Sh41qfcUUl4B1ski5C80qcgkyTSyG3k0MDM+noY5gqOSyqNTU
         wGAPTZXMKUm7HV5vl5qpMEU7fR40ZqFVNlc8q5u6gzVbVW2gBNmVFYE9qdWUQsxL7Rny
         0ySt6t6fKZPfu8hsrJRoBi4fSjlv6rKtVxssEAndjYNq8zjhjzmpwJ1Z6YAhFPKLHgvU
         wnt7q1mi6wvE221n0Fe0fPpBAAw+cm6pz/Wn7ykSYzDgQWnuba2cRWmWZRZ6W9AYweUx
         ElZLRZm+UVHXalQQnyyORSVSDe15SZU4gft/mrhPVHKAna1LoofcBHinTXEuhlxxCCLX
         sphg==
X-Gm-Message-State: ACrzQf0lCslnKmJWNm+0bVASXPRHFbivU3tKWdVg18wYp6doA8YxmVXt
        qEPWYP34LAE9YOcGvMdbsl4=
X-Google-Smtp-Source: AMsMyM5BS/zP58FO2zCwkTOVXD3MXZ8P+y3y4lXbxuVzPG+frWVEj40FRWMZEX0kQ/iObaAOVOtwrA==
X-Received: by 2002:a05:6870:14c5:b0:13c:2432:6b0 with SMTP id l5-20020a05687014c500b0013c243206b0mr1294626oab.185.1667013021986;
        Fri, 28 Oct 2022 20:10:21 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-5d1e-45f3-e9b5-d771.res6.spectrum.com. [2603:8081:140c:1a00:5d1e:45f3:e9b5:d771])
        by smtp.googlemail.com with ESMTPSA id p3-20020a0568301d4300b006391adb6034sm162493oth.72.2022.10.28.20.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:10:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Ian Ziemba <ian.ziemba@hpe.com>
Subject: [PATCH for-next v3 04/13] RDMA/rxe: Handle qp error in rxe_resp.c
Date:   Fri, 28 Oct 2022 22:10:01 -0500
Message-Id: <20221029031009.64467-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029031009.64467-1-rpearsonhpe@gmail.com>
References: <20221029031009.64467-1-rpearsonhpe@gmail.com>
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

Split rxe_drain_req_pkts() into two subroutines which perform
separate tasks. Change qp error and reset states and !qp->valid
in the same way as rxe_comp.c. Flush recv wqes for qp in error.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 64 ++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c4f365449aa5..16298d88a9d7 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1028,7 +1028,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CLEANUP;
 }
 
-
 static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
 				  int opcode, const char *msg)
 {
@@ -1243,22 +1242,56 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
 	}
 }
 
-static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
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
+static int complete_flush(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
+{
+	struct rxe_cqe cqe;
+	struct ib_wc *wc = &cqe.ibwc;
+	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+
+	memset(&cqe, 0, sizeof(cqe));
 
-	if (notify)
-		return;
+	if (qp->rcq->is_user) {
+		uwc->status		= IB_WC_WR_FLUSH_ERR;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
+	} else {
+		wc->status		= IB_WC_WR_FLUSH_ERR;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
+	}
 
-	while (!qp->srq && q && queue_head(q, q->type))
+	if (rxe_cq_post(qp->rcq, &cqe, 0))
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* drain the receive queue. Complete each wqe with a flush error
+ * if notify is true or until a cq overflow occurs.
+ */
+static void rxe_drain_recv_queue(struct rxe_qp *qp, bool notify)
+{
+	struct rxe_recv_wqe *wqe;
+	struct rxe_queue *q = qp->rq.queue;
+
+	while ((wqe = queue_head(q, q->type))) {
+		if (notify && complete_flush(qp, wqe))
+			notify = 0;
 		queue_advance_consumer(q, q->type);
+	}
+
+	qp->resp.wqe = NULL;
 }
 
 int rxe_responder(void *arg)
@@ -1267,6 +1300,7 @@ int rxe_responder(void *arg)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
+	bool notify;
 	int ret;
 
 	if (!rxe_get(qp))
@@ -1274,20 +1308,16 @@ int rxe_responder(void *arg)
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-	if (!qp->valid)
-		goto exit;
-
-	switch (qp->resp.state) {
-	case QP_STATE_RESET:
-		rxe_drain_req_pkts(qp, false);
-		qp->resp.wqe = NULL;
+	if (!qp->valid || qp->resp.state == QP_STATE_ERROR ||
+	    qp->resp.state == QP_STATE_RESET) {
+		notify = qp->valid && (qp->resp.state == QP_STATE_ERROR);
+		rxe_drain_req_pkts(qp);
+		rxe_drain_recv_queue(qp, notify);
 		goto exit;
-
-	default:
-		state = RESPST_GET_REQ;
-		break;
 	}
 
+	state = RESPST_GET_REQ;
+
 	while (1) {
 		pr_debug("qp#%d state = %s\n", qp_num(qp),
 			 resp_state_name[state]);
-- 
2.34.1

