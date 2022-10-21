Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBD607F72
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJUUCz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJUUCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:23 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2762623DF
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so2446205otp.10
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXG5CI1MZEwriHR4ZXnpg5KIBA98wlCNTK6at1ExAAU=;
        b=Tlbl/h1OPudUiVLcq1Q65GL/u9XtK54TzKm4T0lB+rTQyZuxbds0f2Lka2mGSJIPaQ
         rWdy6OQqF54eiaua8+uZZCLSgYlh81G/ENyypMpkLqpH9SHfqzM7/mFp6WP+JHcY0IRt
         6bcwuzIyMyfLrW2QNeciVXwqRSU7cRPWaGdk2KygeVbh3mALDwHpb1kkFtq5g1nVsBMw
         2HGTs44K3w/+j232RrVinGTuL+BSVtAcTKe0ybFgp4yMxw3pCNA5xD9b9AN079I409fH
         RPK/He3mkDGUkb5j2fP/2XCmKntbv2jkEBWDI0Jh17WIdwQV+K0DFvOa++W6SXItWXQB
         zHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXG5CI1MZEwriHR4ZXnpg5KIBA98wlCNTK6at1ExAAU=;
        b=Xlcqi/BGplf2IKOCsNKY0DAECxpD9VN1C4PPbbUH2qF08xi6yCAhepvXVJaitboNGX
         MHUCm8ZMaxXO0vwuErRzpUC4NolBM9g7kef7Jlt9X9ssEel6quhx2g86v/KowhrhIWa7
         T3wCm3B5VvMPPYRVxH/1WFSFKOIZTwoPDiNuP44jIttczNhN16k0C4D/6D+pYl8BpTT+
         i6+xQPH/wtlLx/u9i8RgwjXlMx+ZiOz+Ukuo+OwtTeq70DVUaM/qUkP3ASJmwXf10ajS
         cZYgTWZw93fj4sBPcfv0dPlfvZCCq4eEyzQn+udOg277GyoZ6clmUgY7M7IGPgi23sMf
         +kGg==
X-Gm-Message-State: ACrzQf0s49N1Ym5YPVYIHlquAiXfmbxThyq0oELMLfTE0FFL2OVs6yV7
        1GZo2+H1Oq0LrNs5NB/MvhA5djbydHI=
X-Google-Smtp-Source: AMsMyM5hgLouUldBDuX1D4ovGpDfPLaBOQwv1DGTjzKnXpIbXH7Kmk2S8J3nat+YLRMvZdPt5ok2ng==
X-Received: by 2002:a9d:4a1:0:b0:65c:4497:6cd9 with SMTP id 30-20020a9d04a1000000b0065c44976cd9mr10388050otm.188.1666382533647;
        Fri, 21 Oct 2022 13:02:13 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 10/18] RDMA/rxe: Handle qp error in rxe_resp.c
Date:   Fri, 21 Oct 2022 15:01:11 -0500
Message-Id: <20221021200118.2163-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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
index dd11dea70bbf..0bcdd1154641 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1025,7 +1025,6 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_CLEANUP;
 }
 
-
 static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
 				  int opcode, const char *msg)
 {
@@ -1240,22 +1239,56 @@ static enum resp_states do_class_d1e_error(struct rxe_qp *qp)
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
+int complete_flush(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
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
@@ -1264,6 +1297,7 @@ int rxe_responder(void *arg)
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	enum resp_states state;
 	struct rxe_pkt_info *pkt = NULL;
+	bool notify;
 	int ret;
 
 	if (!rxe_get(qp))
@@ -1271,20 +1305,16 @@ int rxe_responder(void *arg)
 
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

