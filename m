Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B6765CCA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjG0UCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjG0UCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:21 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C452D7D
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bb31245130so1123660a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488138; x=1691092938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+baivTLirFTZrY167Wk8lLnbiCM4lAjA1NOD55KQwc=;
        b=K+cQQX4nXz64l5sQcyzPaIPX1r4wGiu1hNTlmbeGO2Un4vltLitKxVw13hRo8tgqZx
         R6GuhDgA3yw5PxRWoFUOINgKtucMnKg3d3XWbfHCM+gvUM/5zCZQGVCf0waZ4cz4h4j2
         9lcr5NQVLSo4cQN5+M9iXYwDBuvRqzURwYcKoH3prd59itKYJPzUqnvHCM9m44zZQiaY
         O9wtp9DuES0BZioCn6Zr+tRRIgWKnGZHUfEBvMANtQ1/4MKYZ7VaDJLuwOBomVatTc2i
         S1zXwFyIewknJtTWijVevyWl8p2rCxdvJRqx3SjTSLu+dKo60ze4C8htwMLHIhMHZ/ds
         wOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488138; x=1691092938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+baivTLirFTZrY167Wk8lLnbiCM4lAjA1NOD55KQwc=;
        b=C9tLlvXDPWiJs7buwQ8zMjPmZy+B5q7WAUd+dQcOYj1gnBSAueOr/0j5DmV54m0s9+
         HJceeSuZTdV0JsPvH5aKJjUMORlyuDXBvI9QoaVc/zYJf1Ozj3i0JGjxv7obDOLexiWi
         uYAUUhgxXxXJQTMJnA9q+AkvfMJhwm6CIGejHeAIkuGVybMNlk8L7Q8Y+1U8REDwSKpc
         G/0sopU1xkIGaddXsNfvVKysutLajeKT/GeLy65viJRPZ/5cwZeo/TSJdHJuPYZWrDT4
         hz9vIhM4/ci1iwzfnMMNr+aTEc4NMa0Qw94WH2wessdu9pV9mQlzytWO/V+mG8A65wrg
         XRwQ==
X-Gm-Message-State: ABy/qLbO5xhRfOWK375XiKRH11RsWF4J4loqTie0Nkgzj/2KeWVSFfq8
        oy/tfAjkCS5JN1GJh867TOzCqCOLBEQ=
X-Google-Smtp-Source: APBJJlFys0pVHk2K+UMhKYjKdLPI7igTearNeL3UlX3L+N5Qc1FCxQvWT99u3c5b0tiR3ZUgKLKt1A==
X-Received: by 2002:a05:6830:10e:b0:6b9:1af3:3307 with SMTP id i14-20020a056830010e00b006b91af33307mr133010otp.17.1690488138547;
        Thu, 27 Jul 2023 13:02:18 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 07/10] RDMA/rxe: Extend response packets for frags
Date:   Thu, 27 Jul 2023 15:01:26 -0500
Message-Id: <20230727200128.65947-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
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

Extend prepare_ack_packet(), read_reply() and send_common_ack() in
rxe_resp.c to support fragmented skbs.  Adjust calls to these routines
for the changed API.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 59 ++++++++++++++++++----------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 254f2eab8d20..dc62e11dc448 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -765,14 +765,11 @@ static enum resp_states atomic_write_reply(struct rxe_qp *qp,
 
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  struct rxe_pkt_info *ack,
-					  int opcode,
-					  int payload,
-					  u32 psn,
-					  u8 syndrome)
+					  int opcode, int payload, u32 psn,
+					  u8 syndrome, bool *fragp)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff *skb;
-	int err;
 
 	ack->rxe = rxe;
 	ack->qp = qp;
@@ -788,7 +785,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->paylen = rxe_opcode[opcode].length + payload +
 			ack->pad + RXE_ICRC_SIZE;
 
-	skb = rxe_init_packet(qp, &qp->pri_av, ack, NULL);
+	skb = rxe_init_packet(qp, &qp->pri_av, ack, fragp);
 	if (!skb)
 		return NULL;
 
@@ -803,12 +800,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	if (ack->mask & RXE_ATMACK_MASK)
 		atmack_set_orig(ack, qp->resp.res->atomic.orig_val);
 
-	err = rxe_prepare(&qp->pri_av, ack, skb);
-	if (err) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	return skb;
 }
 
@@ -881,7 +872,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
 	unsigned int skb_offset = 0;
-	u8 *pad_addr;
+	enum rxe_mr_copy_op op;
+	bool frag;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
@@ -898,8 +890,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 			qp->resp.mr = NULL;
 		} else {
 			mr = rxe_recheck_mr(qp, res->read.rkey);
-			if (!mr)
-				return RESPST_ERR_RKEY_VIOLATION;
+			if (!mr) {
+				state = RESPST_ERR_RKEY_VIOLATION;
+				goto err_out;
+			}
 		}
 
 		if (res->read.resid <= mtu)
@@ -926,23 +920,33 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	payload = min_t(int, res->read.resid, mtu);
 
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
-				 res->cur_psn, AETH_ACK_UNLIMITED);
+				 res->cur_psn, AETH_ACK_UNLIMITED, &frag);
 	if (!skb) {
 		state = RESPST_ERR_RNR;
 		goto err_out;
 	}
 
+	op = frag ? RXE_FRAG_FROM_MR : RXE_COPY_FROM_MR;
 	err = rxe_copy_mr_data(skb, mr, res->read.va, payload_addr(&ack_pkt),
-			       skb_offset, payload, RXE_COPY_FROM_MR);
+			       skb_offset, payload, op);
 	if (err) {
 		kfree_skb(skb);
 		state = RESPST_ERR_RKEY_VIOLATION;
 		goto err_out;
 	}
 
-	if (ack_pkt.pad) {
-		pad_addr = payload_addr(&ack_pkt) + payload;
-		memset(pad_addr, 0, ack_pkt.pad);
+	err = rxe_prepare_pad_icrc(&ack_pkt, skb, payload, frag);
+	if (err) {
+		kfree_skb(skb);
+		state = RESPST_ERR_RNR;
+		goto err_out;
+	}
+
+	err = rxe_prepare(&qp->pri_av, &ack_pkt, skb);
+	if (err) {
+		kfree_skb(skb);
+		state = RESPST_ERR_RNR;
+		goto err_out;
 	}
 
 	/* rxe_xmit_packet always consumes the skb */
@@ -1177,10 +1181,23 @@ static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
 	struct rxe_pkt_info ack_pkt;
 	struct sk_buff *skb;
 
-	skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
+	skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn,
+				 syndrome, NULL);
 	if (!skb)
 		return -ENOMEM;
 
+	err = rxe_prepare_pad_icrc(&ack_pkt, skb, 0, false);
+	if (err) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	err = rxe_prepare(&qp->pri_av, &ack_pkt, skb);
+	if (err) {
+		kfree_skb(skb);
+		return err;
+	}
+
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
 	if (err)
 		rxe_dbg_qp(qp, "Failed sending %s\n", msg);
-- 
2.39.2

