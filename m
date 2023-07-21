Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B875D558
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGUUI0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGUUI0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:08:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE3930CD
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:08:25 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a43cbb432aso1606858b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689970104; x=1690574904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlwAj3cqQSKPhIryfc1yoFQtvY6/fxtbvXyiBff2/34=;
        b=C4otNjDDAXc6EaTeBjl4IfeyjQL6FVNycbmqiCxqJ0Rbu+8ohDNvpPbFLAigLyMyc8
         X4vDY2RcGm34SdXPWiYrzfKoXZc9l98Az0tOw7lpC5se5CkQQRIx1aEysoX4FBtAMgsu
         F2XJ+lmsXZMfAfztFci1S4omKGha7FuWC3McBQw7pEBZ90xo8sMlinmnTB5RcIQagNsb
         f3mom+MJ6iWLa31qWUJwQ1YXsO2f/L/QU8EQBlrfNZvhwqlU1gedCU63VYmdtuHQAMRu
         PA/hxDO5Qz4XeriWmdoX3+r4Sl1r9/JdDEgF91XL99AlSk3M4csVY/qQMrmxzq4bwZX8
         XezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970104; x=1690574904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlwAj3cqQSKPhIryfc1yoFQtvY6/fxtbvXyiBff2/34=;
        b=g+0pasYycJE80yUjSNIH09HkXZfzJLPc28VYxTy0lAR8qipXzjS1cOh4hWYct2JLnK
         Ou3pmnNuK9mMq1MqkK6rVDHdyWqxQ7xYQLypbdp0HihVI5Fvtu6ERo6PdxFbYcWRrftR
         p3sTb95aKfsl0W/ixCrrjmfUvWTl1y1eWtTmyXJjLDmzly5QoBE94SKNHmB2hreXJEXr
         KH6Bp0VgZ3DkXdu5QuegoGX3jDUhfgaAuz3zuRn0IfePPbY1gecd5bI4K3rGNpeyCQYW
         jHPPQDjeBKSJbBTQjoGmtGUIWq1W1CaLVsYaMN1UT+fftVBZeMcu1vat26bcYKfC6Ovq
         9IeQ==
X-Gm-Message-State: ABy/qLYOLvsXtSBiTTaqQp8hHc5HNIjTaGZKiBxIG1g5rh8xCsL2c7B7
        pBoMKQ/aEbyMGaGONW9Rct4=
X-Google-Smtp-Source: APBJJlGakhhQXgI6/J9l2+paKsCJvDIrmvWpY401IjCG/OklYb4AuvDCu5F29it28bO0cQ8C0tYzDw==
X-Received: by 2002:a54:478e:0:b0:3a1:e5b1:f915 with SMTP id o14-20020a54478e000000b003a1e5b1f915mr3303052oic.55.1689970104388;
        Fri, 21 Jul 2023 13:08:24 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id f7-20020a05680807c700b003a40b3fce01sm1777642oij.10.2023.07.21.13.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:08:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix incomplete state save in rxe_requester
Date:   Fri, 21 Jul 2023 15:07:49 -0500
Message-Id: <20230721200748.4604-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If a send packet is dropped by the IP layer in rxe_requester()
the call to rxe_xmit_packet() can fail with err == -EAGAIN.
To recover, the state of the wqe is restored to the state before
the packet was sent so it can be resent. However, the routines
that save and restore the state miss a significnt part of the
variable state in the wqe, the dma struct which is used to process
through the sge table. And, the state is not saved before the packet
is built which modifies the dma struct.

Under heavy stress testing with many QPs on a fast node sending
large messages to a slow node dropped packets are observed and
the resent packets are corrupted because the dma struct was not
restored. This patch fixes this behavior and allows the test cases
to succeed.

Fixes: 3050b9985024 ("IB/rxe: Fix race condition between requester and completer")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Rebased to for-next

 drivers/infiniband/sw/rxe/rxe_req.c | 45 ++++++++++++++++-------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 2171f19494bc..d8c41fd626a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -578,10 +578,11 @@ static void save_state(struct rxe_send_wqe *wqe,
 		       struct rxe_send_wqe *rollback_wqe,
 		       u32 *rollback_psn)
 {
-	rollback_wqe->state     = wqe->state;
+	rollback_wqe->state = wqe->state;
 	rollback_wqe->first_psn = wqe->first_psn;
-	rollback_wqe->last_psn  = wqe->last_psn;
-	*rollback_psn		= qp->req.psn;
+	rollback_wqe->last_psn = wqe->last_psn;
+	rollback_wqe->dma = wqe->dma;
+	*rollback_psn = qp->req.psn;
 }
 
 static void rollback_state(struct rxe_send_wqe *wqe,
@@ -589,10 +590,11 @@ static void rollback_state(struct rxe_send_wqe *wqe,
 			   struct rxe_send_wqe *rollback_wqe,
 			   u32 rollback_psn)
 {
-	wqe->state     = rollback_wqe->state;
+	wqe->state = rollback_wqe->state;
 	wqe->first_psn = rollback_wqe->first_psn;
-	wqe->last_psn  = rollback_wqe->last_psn;
-	qp->req.psn    = rollback_psn;
+	wqe->last_psn = rollback_wqe->last_psn;
+	wqe->dma = rollback_wqe->dma;
+	qp->req.psn = rollback_psn;
 }
 
 static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
@@ -797,6 +799,9 @@ int rxe_requester(struct rxe_qp *qp)
 	pkt.mask = rxe_opcode[opcode].mask;
 	pkt.wqe = wqe;
 
+	/* save wqe state before we build and send packet */
+	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
+
 	av = rxe_get_av(&pkt, &ah);
 	if (unlikely(!av)) {
 		rxe_dbg_qp(qp, "Failed no address vector\n");
@@ -829,29 +834,29 @@ int rxe_requester(struct rxe_qp *qp)
 	if (ah)
 		rxe_put(ah);
 
-	/*
-	 * To prevent a race on wqe access between requester and completer,
-	 * wqe members state and psn need to be set before calling
-	 * rxe_xmit_packet().
-	 * Otherwise, completer might initiate an unjustified retry flow.
-	 */
-	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
+	/* update wqe state as though we had sent it */
 	update_wqe_state(qp, wqe, &pkt);
 	update_wqe_psn(qp, wqe, &pkt, payload);
 
 	err = rxe_xmit_packet(qp, &pkt, skb);
 	if (err) {
-		qp->need_req_skb = 1;
+		if (err != -EAGAIN) {
+			wqe->status = IB_WC_LOC_QP_OP_ERR;
+			goto err;
+		}
 
+		/* the packet was dropped so reset wqe to the state
+		 * before we sent it so we can try to resend
+		 */
 		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
 
-		if (err == -EAGAIN) {
-			rxe_sched_task(&qp->req.task);
-			goto exit;
-		}
+		/* force a delay until the dropped packet is freed and
+		 * the send queue is drained below the low water mark
+		 */
+		qp->need_req_skb = 1;
 
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err;
+		rxe_sched_task(&qp->req.task);
+		goto exit;
 	}
 
 	update_state(qp, &pkt);

base-commit: b3d2b014b259ba758d72d7026685091bde1cf2d6
-- 
2.39.2

