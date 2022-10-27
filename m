Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA46100D9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiJ0S4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiJ0S4c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:32 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8FF51A06
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:27 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-13b103a3e5dso3413194fac.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOPwY/DG0MJuT0Lgeyya4NjCN0MMe0sWGf6UN1jwdp8=;
        b=G7cpjckiavAJy/DZqFr02BVpIN2j+kizxw8Zc813S3L/6ikadq+OKOMz8x2Nnf1r+K
         vTv2QTjjzG+ljA0QHpUY6Y2TjjUvfkWJgNPHUK9H47avx79FZCeiM+MFBlt97QYqJ11D
         AYHBuls/8XfwBbk40Wc7efHRzMuAe014+XnTX4e0ZuXTZT+JNosD9WqxWbFxTBIhxkMN
         KMn4mDocTmB+8wUDrD9YZV2M21zF9vY2+k0Gowsu52jrn3CvjyIGZw9jtGF2CVKntDoj
         tSWEq42E1HksYxA5V+ZypWNu7K3XTZF3kTTYbaG6xNEjq0qqsPqymaM02KiItXcvH164
         bttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOPwY/DG0MJuT0Lgeyya4NjCN0MMe0sWGf6UN1jwdp8=;
        b=E+HfLRE/obPpy56E8imfIxXABCyGmkP4IlpXmgbI6zx8WkdlSS4IkTTwEyDA1Qy1b6
         E4OBifBiNn/H+Qm02QSjt7AB1yhx79QLwvRfZBbxeFQzTA3B9TnY/hmuZq6ZZm5EZZim
         A6l7xThV1OCwOPGTFUOye5b50jHGlXWIHi3nF8KA3uWGTq/6XL5BBO0eA99O2sn6XPs/
         Da9d6eMgwU9sPj2sLSZSrjw+z0XUPIDYkTsKF0qmBMiw3GgDttSvxlFH6ElFJrJ9Y8OP
         y79HhnULQiOCekDN2AhKEJNrG+AP4HoLIUV3Tj3PfU0y8fjrvpsQC8M57ysIRwZOAccV
         9AUg==
X-Gm-Message-State: ACrzQf3e+MBrkoSUH0dhZGh8d2pBruyZrfEp6sx+9VQozQpraJYvH00N
        OFV1kLGUaVMRUvlkqhUEqxM=
X-Google-Smtp-Source: AMsMyM7PQNdOZ+WEretOnxu4dW8gKOo2rSzieM1EjMg9ChvEZlm8EzFQUQrnmlEE6G81AChjQKtqXg==
X-Received: by 2002:a05:6870:96ab:b0:13b:8fb9:47a with SMTP id o43-20020a05687096ab00b0013b8fb9047amr6267492oaq.15.1666896987125;
        Thu, 27 Oct 2022 11:56:27 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 14/17] RDMA/rxe: Extend response packets for frags
Date:   Thu, 27 Oct 2022 13:55:08 -0500
Message-Id: <20221027185510.33808-15-rpearsonhpe@gmail.com>
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

Extend prepare_ack_packet(), read_reply() and send_common_ack() in
rxe_resp.c to support fragmented skbs.  Adjust calls to these routines
for the changed API.

This is in preparation for using fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 89 +++++++++++++++++-----------
 1 file changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8868415b71b6..79dcd0f37140 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -660,10 +660,8 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 
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
@@ -682,7 +680,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	ack->psn = psn;
 	ack->port_num = 1;
 
-	skb = rxe_init_packet(qp, &qp->pri_av, ack, NULL);
+	skb = rxe_init_packet(qp, &qp->pri_av, ack, fragp);
 	if (!skb)
 		return NULL;
 
@@ -698,12 +696,14 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 		atmack_set_orig(ack, qp->resp.res->atomic.orig_val);
 
 	err = rxe_prepare(&qp->pri_av, ack, skb);
-	if (err) {
-		kfree_skb(skb);
-		return NULL;
-	}
+	if (err)
+		goto err_free_skb;
 
 	return skb;
+
+err_free_skb:
+	kfree_skb(skb);
+	return NULL;
 }
 
 /**
@@ -775,6 +775,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
 	int skb_offset = 0;
+	bool frag;
+	enum rxe_mr_copy_op op;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
@@ -787,8 +789,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
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
@@ -797,8 +801,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
 	} else {
 		mr = rxe_recheck_mr(qp, res->read.rkey);
-		if (!mr)
-			return RESPST_ERR_RKEY_VIOLATION;
+		if (!mr) {
+			state = RESPST_ERR_RKEY_VIOLATION;
+			goto err_out;
+		}
 
 		if (res->read.resid > mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
@@ -806,35 +812,33 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST;
 	}
 
-	res->state = rdatm_res_state_next;
-
 	payload = min_t(int, res->read.resid, mtu);
 
 	skb = prepare_ack_packet(qp, &ack_pkt, opcode, payload,
-				 res->cur_psn, AETH_ACK_UNLIMITED);
-	if (!skb)
-		return RESPST_ERR_RNR;
+				 res->cur_psn, AETH_ACK_UNLIMITED, &frag);
+	if (!skb) {
+		state = RESPST_ERR_RNR;
+		goto err_put_mr;
+	}
 
+	op = frag ? RXE_FRAG_FROM_MR : RXE_COPY_FROM_MR;
 	err = rxe_copy_mr_data(skb, mr, res->read.va, payload_addr(&ack_pkt),
-			       skb_offset, payload, RXE_COPY_FROM_MR);
+			       skb_offset, payload, op);
 	if (err) {
-		kfree_skb(skb);
-		rxe_put(mr);
-		return RESPST_ERR_RKEY_VIOLATION;
+		state = RESPST_ERR_RKEY_VIOLATION;
+		goto err_free_skb;
 	}
 
-	if (mr)
-		rxe_put(mr);
-
-	if (bth_pad(&ack_pkt)) {
-		u8 *pad = payload_addr(&ack_pkt) + payload;
-
-		memset(pad, 0, bth_pad(&ack_pkt));
-	}
+	err = rxe_prepare_pad_icrc(&ack_pkt, skb, payload, frag);
+	if (err)
+		goto err_free_skb;
 
 	err = rxe_xmit_packet(qp, &ack_pkt, skb);
-	if (err)
-		return RESPST_ERR_RNR;
+	if (err) {
+		/* rxe_xmit_packet will consume the packet */
+		state = RESPST_ERR_RNR;
+		goto err_put_mr;
+	}
 
 	res->read.va += payload;
 	res->read.resid -= payload;
@@ -851,6 +855,16 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		state = RESPST_CLEANUP;
 	}
 
+	/* keep these after all error exits */
+	res->state = rdatm_res_state_next;
+	rxe_put(mr);
+	return state;
+
+err_free_skb:
+	kfree_skb(skb);
+err_put_mr:
+	rxe_put(mr);
+err_out:
 	return state;
 }
 
@@ -1041,14 +1055,19 @@ static int send_common_ack(struct rxe_qp *qp, u8 syndrome, u32 psn,
 				  int opcode, const char *msg)
 {
 	int err;
-	struct rxe_pkt_info ack_pkt;
+	struct rxe_pkt_info ack;
 	struct sk_buff *skb;
+	int payload = 0;
 
-	skb = prepare_ack_packet(qp, &ack_pkt, opcode, 0, psn, syndrome);
+	skb = prepare_ack_packet(qp, &ack, opcode, payload,
+				 psn, syndrome, NULL);
 	if (!skb)
 		return -ENOMEM;
 
-	err = rxe_xmit_packet(qp, &ack_pkt, skb);
+	/* doesn't fail if frag == false */
+	(void)rxe_prepare_pad_icrc(&ack, skb, payload, false);
+
+	err = rxe_xmit_packet(qp, &ack, skb);
 	if (err)
 		pr_err_ratelimited("Failed sending %s\n", msg);
 
-- 
2.34.1

