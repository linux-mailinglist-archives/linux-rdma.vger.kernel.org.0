Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B766100CB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiJ0S4S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiJ0S4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:16 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267336DF8
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:13 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13c569e5ff5so3016990fac.6
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTx3ZwrPzjrPtYAsIakHh9HEYCDZ3bW/H1ENJ8+eUII=;
        b=g/V4bMmJTsF7RgXlFzw89zYoqehgKHJaaAHNbDSUUyMWP5p/sJ+FCTNBi4zm3VMH8N
         b3ki+uaCYQ9TwCLSLKLKzI9C+VlVsHUUbIDS1gL12o5Qv6ZcizZV3ivDLgsh931WDChb
         jlBz7cfK59t3tS+doMQIvkbG6/cpkSTNoRIX+AGlcs6TngzesIWswlIOftYbiwxYNDIn
         Y0/l/1zrlF+m5ox6YYkGhFgmVgRH4H76lJ9LmyoJBdLbT2+ffJW/t0VL6e9xdfyChszH
         W4TL3pBbiHQmTiUIs2bevPE5JsRNWeFPhDzRI3ABVIgzi6Ffhmt9Q3qNuPUzVoQlU1zO
         IHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTx3ZwrPzjrPtYAsIakHh9HEYCDZ3bW/H1ENJ8+eUII=;
        b=s+0Q5ZQ0saM8ayPbAIzN6r2if+BjecKDgz85dqPeyd/A/re4a2QseOiBjDIw0oRS3K
         rPnX11y09eZvKyKd+M4wXnL2SXTuIu27DavUtB0O1S4UJVPhrRkidcG68GrSf8GVXOpl
         6BKkF/DdY+oOD+7dOQEh9bxwNEpD/aHhADX8C0ONy5tCAHC4ubh+oy3Twy7gdPETLgE6
         cTSAf+HK6Tge6mz0iwQvChuuJyfoQPdGkBOaPngxhCD8+XZQQnjBps8IW1t6bC2Gwyip
         eL+d976xSvDcloueMYbA34OWpuYVjC82SDdE8uX0CafNduLE9gJTrXMw7/Za1nQT5hyd
         Odyg==
X-Gm-Message-State: ACrzQf0x2a4q8yauFnKMFbHVw7Tg3toxOm6Pq/7NFPaO6HnB/I0i4fnz
        xlaQ2FFh4+PuF9xXMBmOYOA=
X-Google-Smtp-Source: AMsMyM5Hr1WkNfT/vIjrnMQUm490Q3aORCWEzBJnO9yvNfqqnwbTNBrjloeo8GDfAxeOzBL2vTMyBw==
X-Received: by 2002:a05:6870:f5a4:b0:136:3e0d:acdd with SMTP id eh36-20020a056870f5a400b001363e0dacddmr6843821oab.298.1666896972290;
        Thu, 27 Oct 2022 11:56:12 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 01/17] RDMA/rxe: Isolate code to fill request roce headers
Date:   Thu, 27 Oct 2022 13:54:55 -0500
Message-Id: <20221027185510.33808-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
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

Isolate the code to fill in roce headers in a request packet into
a subroutine named init_roce_headers.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 106 +++++++++++++++-------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..bcfbc78c0b53 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -377,79 +377,87 @@ static inline int get_mtu(struct rxe_qp *qp)
 	return rxe->port.mtu_cap;
 }
 
-static struct sk_buff *init_req_packet(struct rxe_qp *qp,
-				       struct rxe_av *av,
-				       struct rxe_send_wqe *wqe,
-				       int opcode, u32 payload,
-				       struct rxe_pkt_info *pkt)
+static void rxe_init_roce_hdrs(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
+			       struct rxe_pkt_info *pkt, int pad)
 {
-	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
-	struct sk_buff		*skb;
-	struct rxe_send_wr	*ibwr = &wqe->wr;
-	int			pad = (-payload) & 0x3;
-	int			paylen;
-	int			solicited;
-	u32			qp_num;
-	int			ack_req;
-
-	/* length from start of bth to end of icrc */
-	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
-	pkt->paylen = paylen;
-
-	/* init skb */
-	skb = rxe_init_packet(rxe, av, paylen, pkt);
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
 
-	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL, qp_num,
-		 ack_req, pkt->psn);
+	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL,
+		 dst_qpn, ack_req, pkt->psn);
 
-	/* init optional headers */
+	/* init extended headers */
 	if (pkt->mask & RXE_RETH_MASK) {
-		reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
+		reth_set_rkey(pkt, wr->wr.rdma.rkey);
 		reth_set_va(pkt, wqe->iova);
 		reth_set_len(pkt, wqe->dma.resid);
 	}
 
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
+	int pad = (-payload) & 0x3;
+	int paylen;
+
+	/* length from start of bth to end of icrc */
+	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
+	pkt->paylen = paylen;
+
+	/* init skb */
+	skb = rxe_init_packet(rxe, av, paylen, pkt);
+	if (unlikely(!skb))
+		return NULL;
+
+	rxe_init_roce_hdrs(qp, wqe, pkt, pad);
 
 	return skb;
 }
-- 
2.34.1

