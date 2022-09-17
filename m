Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784C05BB5D6
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIQDMw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIQDMW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:12:22 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6F7B9F9A
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:12:15 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127ba06d03fso54756413fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=pmXKEYyCNniaE+BlAFgYZOoUvItL4ct2QR9ZHK2YPsY=;
        b=p7s7+40uZTIVV0+ZpecKNQSFYtI3aNQm6ICp9dCgiPQZ2m44G8jBF+Jc5C9sO2eDmN
         OEGrHM8racrc+YJaRLjLBxerNN3zFuohaVLlbwMOZoiI++NkJPWFKk2LjKOIIg5yRAZx
         n5pMuQy3JvK8XOwSxcMv+qUFCqSuUlYQnIGZvKkyl6wezMK3C0Hhomsaa/cyhk0bUGXr
         UjDsqE0XZw8h9711k4er3rAD+zc6zXwUzpAAed4Cs4MYXS6Cwtnt0bD9Fctga/J4KmNd
         +vaeYP/vgfSZZ6Bmw4g29sFibRLlyqyBOpq1bofusrtQKu+5Kd95mu6SBvlISQtj6XKv
         +3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pmXKEYyCNniaE+BlAFgYZOoUvItL4ct2QR9ZHK2YPsY=;
        b=Vbyzy+61edCXMymOGPmBrIqMMzqZTS7l1SwkYiXBPxbeHlMr4HCOfg0ckES084et1o
         5/1fs7Gvlax7Fpytqe+MbVzEUDg96sx/kMQFHad/RMA0pF60p8OjMVMURH7xv+aHD/SS
         UL/e65GmmVkO+/DlG9H49YLHX5+Z07j5T1ir9vvedZJrARAve6h9PavRDBbLNN2oV865
         1NKmrPvSgI5050FIbZDYXEjv8I8zKWPtOP8UvmEzLscg2xU+MdwlzP7ZYggOfzw0tHmY
         G0LImNedoON/nFSlVB/GHlh55L4VDahi5D3epHlGWU2tePGJFmD14JY9G4WyRKc+Rjd+
         WLwg==
X-Gm-Message-State: ACgBeo0wj8LSWmr8ygbKCT5tL6kXit8EaRhIa/KElr/0iCK/9p9r67Od
        OInFlA5lLCIOv7s0TqlxOP4mwkJC1xg=
X-Google-Smtp-Source: AA6agR5byFRVnIq/S5Zq/pZ8Y6bumjQ4STlMmZHlvT+5D+GOUPk1gx6Z0uf48MsCYap8ZC8jVQEgzg==
X-Received: by 2002:a05:6870:538c:b0:11b:e64f:ee1b with SMTP id h12-20020a056870538c00b0011be64fee1bmr9859323oan.92.1663384334339;
        Fri, 16 Sep 2022 20:12:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id d184-20020a4a52c1000000b004320b0cc5acsm9490812oob.48.2022.09.16.20.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:12:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 11/13] RDMA/rxe: Extend rxe_req.c to support xrc qps
Date:   Fri, 16 Sep 2022 22:12:11 -0500
Message-Id: <20220917031211.21272-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

