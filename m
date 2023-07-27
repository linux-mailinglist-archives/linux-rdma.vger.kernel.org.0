Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E642765C21
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjG0T3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjG0T3e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:34 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEBC30D7
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:28 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5636425bf98so783827eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486167; x=1691090967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDt+23W+QUHsyKd1ADomZhzoJoGVn9eEM3AnTbteYHY=;
        b=iTLLi4HCigDWLpNwh5sExmKOQBqUba0w6Z3Xk4TghQO3tPHCobTzRAvmDM86e6+qjI
         BttxLNGWhsvZhNlJ0ZxyqQ1iuVOcdMLfG4QF8nfTxerRXLl/WMRAJ5MpGL42GzYxs6xJ
         a4GBpPvJKFZsW4A89/awFIejwfWu8yUMsiUKHah1aXanZm7mSTjufFWkVjE2eHUSCjBL
         GesxxvrZqaz0BTX2rLX6YkcYt2Fzxbz63zTprAgkUGPG6CZeDjL/b9YwxgbqeH1X+Xo4
         sWePNExBTb41oD7fR5cixPQrSssMqdJ5LynOFC8KUk0b+6RS2kMSGctUFE+i59sVuyt3
         f8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486167; x=1691090967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDt+23W+QUHsyKd1ADomZhzoJoGVn9eEM3AnTbteYHY=;
        b=cccgmezQ6VLEA+6As0SAhvT/jFYUrhn+JRhev14qXfNWRE8bNdhBxicDMLrxnDv+gM
         gE0A8dZ6v9Amd0ldwnk0v8qfrVae3Im4HSX0gnGdDro1f/Ib1kxI02sCIk2jHYELO8Az
         m2ytAe604w65TbSCv5bwW79NlkY/nyVdiVJnDKNgoeGfh049XGOi9XDizdcLZEo93D8w
         9ydZP7FoFB3UXioivVyhyWFNtrsfHRYYxsjDp9HLij1vBJoE+qppFQDaYvIXtMfyIW3P
         nB2KJ8xZbg+n/EAeOD519E2ltTMYoFvx4SekXeSrvbHiXgDBtVxMd0sJVl8vstmluwxk
         TnYA==
X-Gm-Message-State: ABy/qLbpmsqV7oS88kIW7O6yHWTQTv7QlJIc5Fv3SlOeDMp0pbUTeH2P
        Z2Dcvww4YGVyD14MjW+HypijdwMLzT4=
X-Google-Smtp-Source: APBJJlHrVqINHn3TMTGNOQMoICmQUhIuC68GJtZ8DHnp96bU8iqFzq3IPLLvDpOskeTfBQmc8PwztQ==
X-Received: by 2002:a4a:6558:0:b0:566:fb4c:981f with SMTP id z24-20020a4a6558000000b00566fb4c981fmr476523oog.0.1690486166489;
        Thu, 27 Jul 2023 12:29:26 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:25 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 5/8] RDMA/rxe: Isolate code to build request packet
Date:   Thu, 27 Jul 2023 14:28:29 -0500
Message-Id: <20230727192831.65495-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
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

Isolate the code to build a request packet into a single
subroutine called rxe_init_req_packet().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 127 +++++++++++++---------------
 1 file changed, 60 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e444e1f91523..27be1a946d62 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -496,14 +496,32 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	return err;
 }
 
-static struct sk_buff *init_req_packet(struct rxe_qp *qp,
-				       struct rxe_av *av,
-				       struct rxe_send_wqe *wqe,
-				       int opcode, u32 payload,
-				       struct rxe_pkt_info *pkt)
+static struct sk_buff *rxe_init_req_packet(struct rxe_qp *qp,
+					   struct rxe_send_wqe *wqe,
+					   int opcode, u32 payload,
+					   struct rxe_pkt_info *pkt)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
+	struct rxe_av *av;
+	struct rxe_ah *ah = NULL;
+	u8 *pad_addr;
+	int err;
+
+	pkt->rxe = rxe;
+	pkt->opcode = opcode;
+	pkt->qp = qp;
+	pkt->psn = qp->req.psn;
+	pkt->mask = rxe_opcode[opcode].mask;
+	pkt->wqe = wqe;
+	pkt->port_num = 1;
+
+	/* get address vector and address handle for UD qps only */
+	av = rxe_get_av(pkt, &ah);
+	if (unlikely(!av)) {
+		err = -EINVAL;
+		goto err_out;
+	}
 
 	/* length from start of bth to end of icrc */
 	pkt->pad = (-payload) & 0x3;
@@ -512,31 +530,19 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* init skb */
 	skb = rxe_init_packet(rxe, av, pkt);
-	if (unlikely(!skb))
-		return NULL;
+	if (unlikely(!skb)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
+	/* init roce headers */
 	rxe_init_roce_hdrs(qp, wqe, pkt);
 
-	return skb;
-}
-
-static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
-			 struct rxe_send_wqe *wqe, struct rxe_pkt_info *pkt,
-			 struct sk_buff *skb, u32 payload)
-{
-	u8 *pad_addr;
-	int err;
-
-	err = rxe_prepare(av, pkt, skb);
-	if (err)
-		return err;
-
+	/* init payload if any */
 	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
 		err = rxe_init_payload(qp, wqe, pkt, payload);
-		if (pkt->pad) {
-			pad_addr = payload_addr(pkt) + payload;
-			memset(pad_addr, 0, pkt->pad);
-		}
+		if (unlikely(err))
+			goto err_out;
 	} else if (pkt->mask & RXE_FLUSH_MASK) {
 		/* oA19-2: shall have no payload. */
 		wqe->dma.resid = 0;
@@ -547,7 +553,32 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 		wqe->dma.resid -= payload;
 	}
 
-	return 0;
+	/* init pad and icrc */
+	if (pkt->pad) {
+		pad_addr = payload_addr(pkt) + payload;
+		memset(pad_addr, 0, pkt->pad);
+	}
+
+	/* init IP and UDP network headers */
+	err = rxe_prepare(av, pkt, skb);
+	if (unlikely(err))
+		goto err_out;
+
+	if (ah)
+		rxe_put(ah);
+
+	return skb;
+
+err_out:
+	if (err == -EFAULT)
+		wqe->status = IB_WC_LOC_PROT_ERR;
+	else
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+	if (skb)
+		kfree_skb(skb);
+	if (ah)
+		rxe_put(ah);
+	return NULL;
 }
 
 static void update_wqe_state(struct rxe_qp *qp,
@@ -678,7 +709,6 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 int rxe_requester(struct rxe_qp *qp)
 {
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -691,8 +721,6 @@ int rxe_requester(struct rxe_qp *qp)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 	struct rxe_queue *q = qp->sq.queue;
-	struct rxe_ah *ah;
-	struct rxe_av *av;
 	unsigned long flags;
 
 	spin_lock_irqsave(&qp->state_lock, flags);
@@ -804,47 +832,12 @@ int rxe_requester(struct rxe_qp *qp)
 		payload = mtu;
 	}
 
-	pkt.rxe = rxe;
-	pkt.opcode = opcode;
-	pkt.qp = qp;
-	pkt.psn = qp->req.psn;
-	pkt.mask = rxe_opcode[opcode].mask;
-	pkt.wqe = wqe;
-
 	/* save wqe state before we build and send packet */
 	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
 
-	av = rxe_get_av(&pkt, &ah);
-	if (unlikely(!av)) {
-		rxe_dbg_qp(qp, "Failed no address vector\n");
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err;
-	}
-
-	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
-	if (unlikely(!skb)) {
-		rxe_dbg_qp(qp, "Failed allocating skb\n");
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		if (ah)
-			rxe_put(ah);
-		goto err;
-	}
-
-	err = finish_packet(qp, av, wqe, &pkt, skb, payload);
-	if (unlikely(err)) {
-		rxe_dbg_qp(qp, "Error during finish packet\n");
-		if (err == -EFAULT)
-			wqe->status = IB_WC_LOC_PROT_ERR;
-		else
-			wqe->status = IB_WC_LOC_QP_OP_ERR;
-		kfree_skb(skb);
-		if (ah)
-			rxe_put(ah);
+	skb = rxe_init_req_packet(qp, wqe, opcode, payload, &pkt);
+	if (!skb)
 		goto err;
-	}
-
-	if (ah)
-		rxe_put(ah);
 
 	/* update wqe state as though we had sent it */
 	update_wqe_state(qp, wqe, &pkt);
-- 
2.39.2

