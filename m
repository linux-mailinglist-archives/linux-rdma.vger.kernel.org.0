Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEE5EFBAC
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiI2RJ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiI2RJW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:22 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4321CEDE1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:18 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so530240ooo.8
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pmXKEYyCNniaE+BlAFgYZOoUvItL4ct2QR9ZHK2YPsY=;
        b=bA8pwMcPE/R/nSHDIqB9iir2Vr6ISeVqs5oLaWP91XAgqyBcSbnt3anehuPtbYgYVw
         TB2hm40CW/brAe+/UoX58ghu8uYUmPIvcQl1qnMJ5+iYpSQq9Dd2OGRRUgN3kQtfIBma
         thneeD2/PPPzwehd+fhL2mHEm+MxLCdckYeDhw67x6559Ql/qwgxb5n5gU9U2pz7wub5
         d8J7neyLsnCsmDxgOLFCnCS93Eap9sUfQjyYW8U7pROCG8nS35Tbj1mbTdhToh5ys+Qw
         T7G1zKBBsn6q06o6+7QrGP4xjtSeFvRk8x4DvP5DnXjX3ymQShlcl6Ndmu5KXH2cm3Xs
         IqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pmXKEYyCNniaE+BlAFgYZOoUvItL4ct2QR9ZHK2YPsY=;
        b=YxcUydr7IQLt/30hkS0WfTe4C4Hb33PKqgVw20/hrLFV57fWjI/K9VO5kCmIAeHHT+
         zudfAmT58gS2kNHB56POoN7u3uDsvQa0xfh4PmV3QPtgwoB2f7Y3bUKkE/x+LRB4tQFy
         JtsZSvIYwK01I4bOgg210QanX2V82GiPCDr30jXpgpEZdiOhlNwoPKQDzRJNtyNUC7Mh
         +pAT1Kr+/FKcwA4HoZr3Ctlox4i5GjNwNpmmvPX3tzyTMLa0BCCXXkSb4uj32kTqeJGi
         hLlVN6xokq9Bfe0nkHBuRvKBV0ytWzvttVkFfVlfB5ZiBs8LZkSvPfqYUxC/tLAqWlEA
         8uLg==
X-Gm-Message-State: ACrzQf34D0eY02wTFmRHGloMEaGMJXpiTkM4UkisI/Rc+QT9WXi20Nmc
        7/Bx1mu0o9eIXNQv/N4tL3a/RAbgF/hwOA==
X-Google-Smtp-Source: AMsMyM56NHT+MRHccmazHXly/Bbr2eZbiqMsSjyeQBJ9/rcDIVFFPKQmDGlF12vcRveFYcLNILLtxA==
X-Received: by 2002:a05:6830:349:b0:63a:cd5d:9014 with SMTP id h9-20020a056830034900b0063acd5d9014mr1769951ote.29.1664471357483;
        Thu, 29 Sep 2022 10:09:17 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 11/13] RDMA/rxe: Extend rxe_req.c to support xrc qps
Date:   Thu, 29 Sep 2022 12:08:35 -0500
Message-Id: <20220929170836.17838-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

Extend code in rxe_req.c to support xrc qp types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 38 +++++++++++++++++------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d2a9abfed596..e7bb969f97f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -229,7 +229,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 {
 	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff		*skb;
-	struct rxe_send_wr	*ibwr = &wqe->wr;
+	struct rxe_send_wr	*wr = &wqe->wr;
 	int			pad = (-payload) & 0x3;
 	int			paylen;
 	int			solicited;
@@ -246,13 +246,13 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 		return NULL;
 
 	/* init bth */
-	solicited = (ibwr->send_flags & IB_SEND_SOLICITED) &&
+	solicited = (wr->send_flags & IB_SEND_SOLICITED) &&
 			(pkt->mask & RXE_LAST_MASK) &&
 			((pkt->mask & (RXE_SEND_MASK)) ||
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
 			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
 
-	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
+	qp_num = (pkt->mask & RXE_DETH_MASK) ? wr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
 
 	ack_req = ((pkt->mask & RXE_LAST_MASK) ||
@@ -264,34 +264,37 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 		 ack_req, pkt->psn);
 
 	/* init optional headers */
+	if (pkt->mask & RXE_XRCETH_MASK)
+		xrceth_set_srqn(pkt, wr->srq_num);
+
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
+		if ((opcode & IB_OPCODE_CMD) == IB_OPCODE_COMPARE_SWAP) {
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
 		if (qp->ibqp.qp_num == 1)
 			deth_set_qkey(pkt, GSI_QKEY);
 		else
-			deth_set_qkey(pkt, ibwr->wr.ud.remote_qkey);
+			deth_set_qkey(pkt, wr->wr.ud.remote_qkey);
 		deth_set_sqp(pkt, qp->ibqp.qp_num);
 	}
 
@@ -338,8 +341,10 @@ static void update_wqe_state(struct rxe_qp *qp,
 		struct rxe_pkt_info *pkt)
 {
 	if (pkt->mask & RXE_LAST_MASK) {
-		if (qp_type(qp) == IB_QPT_RC)
+		if (qp_type(qp) == IB_QPT_RC ||
+		    qp_type(qp) == IB_QPT_XRC_INI)
 			wqe->state = wqe_state_pending;
+		/* other qp types handled in rxe_xmit_packet() */
 	} else {
 		wqe->state = wqe_state_processing;
 	}
@@ -532,9 +537,10 @@ int rxe_requester(void *arg)
 			goto done;
 	}
 
-	if (unlikely(qp_type(qp) == IB_QPT_RC &&
-		psn_compare(qp->req.psn, (qp->comp.psn +
-				RXE_MAX_UNACKED_PSNS)) > 0)) {
+	if (unlikely((qp_type(qp) == IB_QPT_RC ||
+		      qp_type(qp) == IB_QPT_XRC_INI) &&
+		     psn_compare(qp->req.psn, (qp->comp.psn +
+					RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
 		goto exit;
 	}
-- 
2.34.1

