Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05A675D112
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGUSIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSIe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 14:08:34 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BB8E68
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 11:08:32 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b05d63080cso1571971fac.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962912; x=1690567712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl5qGFRFxsYuJOdqU7Lea5gnCaHK92CbiE5YvK2Om84=;
        b=VsrER0Np5ZfzmwmAW01fTSsnmjKmv85/CND53hhAbjL8490TaFnIqWheixLIYkV/BL
         PgFl15/75ahecRbxMBIBk+fghCVUEmYiavBRMbc4jeBwNPJ1/9g4tsd0HzcFU5d00DaY
         JFxzgiRvokV1MllJsirHTxAUYpXdGCMKF9m4x/7g+eC3Imcf2nZzYxY1shnEFQEwecwA
         i9s7DMzUvg93Z6OueFdgv/gHspcXUaoHN9AVKVL/X7BUCvyJucdC3MkRkRw0JnjEgJbN
         eZrHX4n3bSPaZL2fpqgq1weu4VyosKDocDDq93hAGHNB1hgAj0ay8ABSeuNWOGUxoe/j
         2Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962912; x=1690567712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sl5qGFRFxsYuJOdqU7Lea5gnCaHK92CbiE5YvK2Om84=;
        b=FwRIcudSQYxzsIIz4XF8jKRAyCgGmk5GJW8Hl2VmFiIpJliOiJslh7sufQqj/9vtCQ
         M0lUsrrrZCmyJEjRPRgnvxCwpti38pLavPNIcqIlb9MyrNWkHcP11aXZ7/itbHhbP0j6
         ir4ZpJs6I7NzQEfC/gqH98CeS+s5HYyrpCNT4vnFnvfnW/Ag/uLpSSWT8UeGxFopgS/6
         dhU1kHdBWEKdNYSbIdAGk3htzP2I6tObHzVTvQlckFOeRw2x3pbU4klSm6skEah4uLB6
         3gDPBnsDLmURu1owitJRFnpoXuO8pEUVcG/uCTj4LRGF/5krpIFHtTaaQDzsiOXE4LkS
         pyjw==
X-Gm-Message-State: ABy/qLa1LGtV5V6FLMDWpGR5TS0Y2EyyQpAyKE9T3BXRXBfoVRpCM753
        0flfcsLK7EpP2y10fTl1AOo=
X-Google-Smtp-Source: APBJJlF5PfYHymC275Ln18K9BLfdW2WLBZ82q3A2HwYlHAgfa7kNWuHjL2XeN4znerw8FrAzGRRP9Q==
X-Received: by 2002:a05:6870:2156:b0:1ba:3ff0:493d with SMTP id g22-20020a056870215600b001ba3ff0493dmr3110622oae.34.1689962911675;
        Fri, 21 Jul 2023 11:08:31 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-c215-5210-c1ed-1da0.res6.spectrum.com. [2603:8081:140c:1a00:c215:5210:c1ed:1da0])
        by smtp.gmail.com with ESMTPSA id p22-20020a056870a55600b001aa02b7bfabsm1754102oal.33.2023.07.21.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 11:08:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix incomplete state save in rxe_requester
Date:   Fri, 21 Jul 2023 13:04:45 -0500
Message-Id: <20230721180443.16817-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/infiniband/sw/rxe/rxe_req.c | 47 ++++++++++++++++-------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 76d85731a45f..10ff2715d9bb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -708,10 +708,11 @@ static void save_state(struct rxe_send_wqe *wqe,
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
@@ -719,10 +720,11 @@ static void rollback_state(struct rxe_send_wqe *wqe,
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
@@ -922,6 +924,9 @@ int rxe_requester(struct rxe_qp *qp)
 		payload = mtu;
 	}
 
+	/* save wqe state before we build and send packet */
+	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
+
 	skb = rxe_init_req_packet(qp, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		rxe_err_qp(qp, "failed to create packet for %s",
@@ -929,29 +934,29 @@ int rxe_requester(struct rxe_qp *qp)
 		goto err;
 	}
 
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
-- 
2.39.2

