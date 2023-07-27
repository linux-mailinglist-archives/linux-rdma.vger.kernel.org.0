Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A0765C1C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjG0T3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjG0T3Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:25 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1C2D68
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:24 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5607cdb0959so772597eaf.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486163; x=1691090963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNMwUm9bjNnK7SYOx3BfAILkRaWNStS5XUcYTZh2C8o=;
        b=J/630uKxCerImsloN7okbClP5sRUrdICiz2UpRXt3HBSLgPmKRDzGhrfokKn5lslE3
         +zX+0x5PBRYQlB2rcpsZfQSjVBVIc4vxQ3vm3T9jdcL5Oc2OAZirVuG7tCqnYV5L6pLI
         /0Z1vuRajCG4pYmWMpP7QDLTV2RV15TFfwW86YaU/QbgqGqdBDRT+HJ2txB+VWuAwE7Y
         SQrZhBxjgvDwmGg1BVKLYt3UaXATH8htWCfmqvVHxTDJ6ryif6fRgGUT9ER5rKbIxZ47
         h+aEC5Xfo29yeoUKgWjuLPaG27B9mhhm8vTlkGp0WQBSuQ6oGe1dUdqVuorkowzkjd1b
         3c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486163; x=1691090963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNMwUm9bjNnK7SYOx3BfAILkRaWNStS5XUcYTZh2C8o=;
        b=LXEaRKseZyLLOBIBCtQqofaaNSMC5S8pkF9X1+6vY5Kbl9/Wd47pS8+QfYpRFs7VlN
         xxBd4qMjvhH8qRXrjJgAP0ldJ6IQWEIJzgqAPJzx8iUqSMArMTU3fXr3X/VvGgKJm0kt
         6BZOfa95aPE93u1L8P4qy6LbfbAu1u0qfoKXRdpVOMexdTpHXaBBK9kOzfgMSMpgUPIl
         q2ABJpGagG4UiAO7e1wTi+YL2E60JIAJdPBOaX1/fK6JgZsmEHQTTKRLHht95b2EtOUV
         6MDrpY0Od2As07aN06QDD8GYpafLWQuFp0HKn6eo4hUhew1vopC6jcaINAFfAGUCnSjC
         BzXA==
X-Gm-Message-State: ABy/qLbjoYM7gLagT81qnGd63WZ+S7G72eugz/Sy43iP0bs4y8BXDIFa
        vnxfv2nC0EKkcFqQfTBZi6A=
X-Google-Smtp-Source: APBJJlHWLDoQLU7rrYyYKwXMdCkVA3FxaeWF/ISpKjrQtqescRQekC8+0eR0VJ8+Xig8xZK64kffog==
X-Received: by 2002:a4a:7607:0:b0:566:fdb9:4378 with SMTP id t7-20020a4a7607000000b00566fdb94378mr426340ooc.1.1690486163408;
        Thu, 27 Jul 2023 12:29:23 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 2/8] RDMA/rxe: Isolate code to fill request roce headers
Date:   Thu, 27 Jul 2023 14:28:26 -0500
Message-Id: <20230727192831.65495-3-rpearsonhpe@gmail.com>
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

Isolate the code to fill in roce headers in a request packet into
a subroutine named rxe_init_roce_hdrs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 108 +++++++++++++++-------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 31858761ca1e..6e9c8da001a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -411,86 +411,92 @@ static inline int get_mtu(struct rxe_qp *qp)
 	return rxe->port.mtu_cap;
 }
 
-static struct sk_buff *init_req_packet(struct rxe_qp *qp,
-				       struct rxe_av *av,
-				       struct rxe_send_wqe *wqe,
-				       int opcode, u32 payload,
-				       struct rxe_pkt_info *pkt)
+static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			       struct rxe_pkt_info *pkt)
 {
-	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
-	struct sk_buff		*skb;
-	struct rxe_send_wr	*ibwr = &wqe->wr;
-	int			solicited;
-	u32			qp_num;
-	int			ack_req;
-
-	/* length from start of bth to end of icrc */
-	pkt->pad = (-payload) & 0x3;
-	pkt->paylen = rxe_opcode[opcode].length + payload +
-			pkt->pad + RXE_ICRC_SIZE;
-
-	/* init skb */
-	skb = rxe_init_packet(rxe, av, pkt->paylen, pkt);
-	if (unlikely(!skb))
-		return NULL;
+	struct rxe_send_wr *wr = &wqe->wr;
+	int is_send;
+	int is_write_imm;
+	int is_end;
+	int solicited;
+	u32 dst_qpn;
+	u32 qkey;
+	int ack_req;
 
 	/* init bth */
-	solicited = (ibwr->send_flags & IB_SEND_SOLICITED) &&
-			(pkt->mask & RXE_END_MASK) &&
-			((pkt->mask & (RXE_SEND_MASK)) ||
-			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
-			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
-
-	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
-					 qp->attr.dest_qp_num;
-
-	ack_req = ((pkt->mask & RXE_END_MASK) ||
-		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+	is_send = pkt->mask & RXE_SEND_MASK;
+	is_write_imm = (pkt->mask & RXE_WRITE_MASK) &&
+		       (pkt->mask & RXE_IMMDT_MASK);
+	is_end = pkt->mask & RXE_END_MASK;
+	solicited = (wr->send_flags & IB_SEND_SOLICITED) && is_end &&
+		    (is_send || is_write_imm);
+	dst_qpn = (pkt->mask & RXE_DETH_MASK) ? wr->wr.ud.remote_qpn :
+					       qp->attr.dest_qp_num;
+	ack_req = is_end || (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK);
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
 	bth_init(pkt, pkt->opcode, solicited, 0, pkt->pad,
-		 IB_DEFAULT_PKEY_FULL, qp_num,
-		 ack_req, pkt->psn);
+		 IB_DEFAULT_PKEY_FULL, dst_qpn, ack_req, pkt->psn);
 
-	/* init optional headers */
+	/* init extended headers */
 	if (pkt->mask & RXE_RETH_MASK) {
 		if (pkt->mask & RXE_FETH_MASK)
-			reth_set_rkey(pkt, ibwr->wr.flush.rkey);
+			reth_set_rkey(pkt, wr->wr.flush.rkey);
 		else
-			reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
+			reth_set_rkey(pkt, wr->wr.rdma.rkey);
 		reth_set_va(pkt, wqe->iova);
 		reth_set_len(pkt, wqe->dma.resid);
 	}
 
-	/* Fill Flush Extension Transport Header */
 	if (pkt->mask & RXE_FETH_MASK)
-		feth_init(pkt, ibwr->wr.flush.type, ibwr->wr.flush.level);
+		feth_init(pkt, wr->wr.flush.type, wr->wr.flush.level);
 
 	if (pkt->mask & RXE_IMMDT_MASK)
-		immdt_set_imm(pkt, ibwr->ex.imm_data);
+		immdt_set_imm(pkt, wr->ex.imm_data);
 
 	if (pkt->mask & RXE_IETH_MASK)
-		ieth_set_rkey(pkt, ibwr->ex.invalidate_rkey);
+		ieth_set_rkey(pkt, wr->ex.invalidate_rkey);
 
 	if (pkt->mask & RXE_ATMETH_MASK) {
 		atmeth_set_va(pkt, wqe->iova);
-		if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
-			atmeth_set_swap_add(pkt, ibwr->wr.atomic.swap);
-			atmeth_set_comp(pkt, ibwr->wr.atomic.compare_add);
+		if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
+			atmeth_set_swap_add(pkt, wr->wr.atomic.swap);
+			atmeth_set_comp(pkt, wr->wr.atomic.compare_add);
 		} else {
-			atmeth_set_swap_add(pkt, ibwr->wr.atomic.compare_add);
+			atmeth_set_swap_add(pkt, wr->wr.atomic.compare_add);
 		}
-		atmeth_set_rkey(pkt, ibwr->wr.atomic.rkey);
+		atmeth_set_rkey(pkt, wr->wr.atomic.rkey);
 	}
 
 	if (pkt->mask & RXE_DETH_MASK) {
-		if (qp->ibqp.qp_num == 1)
-			deth_set_qkey(pkt, GSI_QKEY);
-		else
-			deth_set_qkey(pkt, ibwr->wr.ud.remote_qkey);
-		deth_set_sqp(pkt, qp->ibqp.qp_num);
+		qkey = (qp->ibqp.qp_num == 1) ? GSI_QKEY :
+						wr->wr.ud.remote_qkey;
+		deth_set_qkey(pkt, qkey);
+		deth_set_sqp(pkt, qp_num(qp));
 	}
+}
+
+static struct sk_buff *init_req_packet(struct rxe_qp *qp,
+				       struct rxe_av *av,
+				       struct rxe_send_wqe *wqe,
+				       int opcode, u32 payload,
+				       struct rxe_pkt_info *pkt)
+{
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	struct sk_buff *skb;
+
+	/* length from start of bth to end of icrc */
+	pkt->pad = (-payload) & 0x3;
+	pkt->paylen = rxe_opcode[opcode].length + payload +
+			pkt->pad + RXE_ICRC_SIZE;
+
+	/* init skb */
+	skb = rxe_init_packet(rxe, av, pkt->paylen, pkt);
+	if (unlikely(!skb))
+		return NULL;
+
+	rxe_init_roce_hdrs(qp, wqe, pkt);
 
 	return skb;
 }
-- 
2.39.2

