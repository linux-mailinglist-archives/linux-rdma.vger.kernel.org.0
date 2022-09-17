Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD85BB5CD
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIQDLx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiIQDLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11685BD131
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w10-20020a056830410a00b00655d70a1aeaso3735672ott.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pmXKEYyCNniaE+BlAFgYZOoUvItL4ct2QR9ZHK2YPsY=;
        b=Lyu4eq4z5AC2lHQaDfwGhtqfQaNFXwD6WzZM+x8/JWz3hcpi6R+PzXBWLRWqsPOvWw
         jtbBdTrl67Thax0y6XHukmbKwW1brX1rW1WepWnFx6txaYmRDTCMHbbFdNa5LwzHH8c2
         jYotEArdodUwcNgQ8HYbsuQa/mRz4VUwmYvwvK3LFkYfsa8Wc6YTWKAABXtX7Z9Mup7Y
         HbuixmSHvViVNu9dV0SGN4STrBAkw1cirOlPZs1EwRvKeVxg+0obSwVAOTJoOdM8cZEs
         Lz4YgVPnv6br4wRxMtO450csT11R9IgM789YLWb7DDmyBJopn1+/u2DRCnwcfaBeZqk9
         re/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pmXKEYyCNniaE+BlAFgYZOoUvItL4ct2QR9ZHK2YPsY=;
        b=KnQGxp0paQWaoGR37/SCfRavJ7/tt2m6OejA1GMZpa2Unqfag2WrpC32vZQgWLkzwT
         aFAnZ+/6fz5wFHwX9DACR7JehPdW35xdjUYCUgSClMxyPjgnPQgOqJn4kPAgPERJmadc
         xBV7bXp5/eoH5PKVksIx4P8ljdY3j6WWJoytC5m0s4QaLXOooyKuaCdJm4dazMGpyFXX
         f9Pk0RpnTrgndm2baoExSOKrZ/U/j2j3tvogVlE35Og79np9grH60cTmoRux0PeRXMZP
         CmhgFrGj8T46cuog7dr+TkzpxkWCEpd2yLwO3dkoAFTUw1iKT2esXWBGtj8EpDjFWNrx
         HO8g==
X-Gm-Message-State: ACrzQf0cpohzk4ftvlvdvlipuQDDlxTenW+MyDL8PDada8yLODqhmhp8
        gCRZGkjI5K1og2A6Z9pggDg=
X-Google-Smtp-Source: AMsMyM5p37aNwpquMqvJaPeAPQBhZ3WeusMdr9IWMOP9C/2Ky8GkPTQWO1ogHComC9cqzcqB34m+4A==
X-Received: by 2002:a05:6830:4193:b0:656:d1eb:a000 with SMTP id r19-20020a056830419300b00656d1eba000mr3609896otu.109.1663384278385;
        Fri, 16 Sep 2022 20:11:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 11/13] RDMA/rxe: Extend rxe_req.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:11:02 -0500
Message-Id: <20220917031104.21222-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

