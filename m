Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF7613EF9
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJaU2e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJaU2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:28:33 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91D13CC8
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:32 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id r76so7425042oie.13
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+WYMXQX2dKXNDBeVU1IFd90dts9p1P8JVwi8WrPSSM=;
        b=XzzXvsb/FpwhKMPV76CMdGdHTRr9NyuvW/t8SFQ7cV9BhYBCpGdEsEnc4m+pHJmMoT
         U2Dn9d3li6MNpUg4ZE663lkEPgQTVYBnyMRF3mhCCtrquu3UApgmZRVMWCMH8cPX4wf0
         HhCeVIs6bJY57y8/22I307ORsEOF4UqKS+ib/yZyImRMm2VVeHhiD/DnXKR2WP9yn2eL
         uJPiR2uMUQpCycVRuVjmHi8TyFkkzerhu+BpSiFP5jLJF5vA4VTYiQnnVneLheJSvnBv
         nxHt/mq+9hDG5aVK0rbx1EobzFgIA+4QA/MCIScrPEWhoyma2Medwe8nzl6/PPLminxv
         REDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+WYMXQX2dKXNDBeVU1IFd90dts9p1P8JVwi8WrPSSM=;
        b=qMW7HpRZTMBfqiogsnfH3IJGvLZC++khw5/uELIiZ8i+JJf5RUxHsPnqImRFd9td+t
         m2kvtZrs2u5MJoxh3K2C62HEOkynGULS4EpSLvZHgvzTAb14d3E/hjzfwTNHBOtyX3U2
         tx7uCy10w4LbEc5hDzUhRRlOwBCxkKcCN/rqFNQLLhCKGYohaJq94h4RJjDL8CebfEUF
         08BXU9VWPP3AWNTwikBtEbdafj+OdiMwekRtaQWKdSyHO9/JMJRYV7GDGvqbh+WyTjDm
         15BUq9J7GeHipDXEMKvbYZYmQxdkFTQ6l31gBjFL+7fpNygSCNVbW1me+79nfuQh6hqV
         5AMQ==
X-Gm-Message-State: ACrzQf0XAYOXqc1MiibRBJYulS4CE4mRsYiW6neq+ayxENgvnHdOdq7+
        ZDC//4fhRzuwAnHhZfoG1IcdpI0/bFk=
X-Google-Smtp-Source: AMsMyM6pjQQ6h/Zk5ISK/VOJaTXw5NhysvgSDWhTNTM2LE/K8/mz0ehMjEp1ZsNcW8+q1axp5NjZ3g==
X-Received: by 2002:aca:34c5:0:b0:353:f98f:641e with SMTP id b188-20020aca34c5000000b00353f98f641emr16070931oia.94.1667248112580;
        Mon, 31 Oct 2022 13:28:32 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id w1-20020a056808018100b00342e8bd2299sm2721215oic.6.2022.10.31.13.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:28:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 04/18] RDMA/rxe: Isolate code to build request packet
Date:   Mon, 31 Oct 2022 15:27:53 -0500
Message-Id: <20221031202805.19138-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031202805.19138-1-rpearsonhpe@gmail.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
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

Isolate all the code to build a request packet into a single
subroutine called rxe_init_req_packet().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c  | 121 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_resp.c |  11 +--
 2 files changed, 58 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e9e865a5674f..6177c513e5b5 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -456,51 +456,76 @@ static int rxe_init_payload(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
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
-	int pad = (-payload) & 0x3;
-	int paylen;
+	struct sk_buff *skb = NULL;
+	struct rxe_av *av;
+	struct rxe_ah *ah = NULL;
+	void *padp;
+	int pad;
+	int err = -EINVAL;
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
+	if (unlikely(!av))
+		goto err_out;
 
 	/* length from start of bth to end of icrc */
-	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
-	pkt->paylen = paylen;
+	pad = (-payload) & 0x3;
+	pkt->paylen = rxe_opcode[opcode].length + payload +
+						pad + RXE_ICRC_SIZE;
 
 	/* init skb */
 	skb = rxe_init_packet(rxe, av, pkt);
 	if (unlikely(!skb))
-		return NULL;
+		goto err_out;
 
 	rxe_init_roce_hdrs(qp, wqe, pkt, pad);
 
-	return skb;
-}
+	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
+		err = rxe_init_payload(qp, wqe, pkt, payload);
+		if (err)
+			goto err_out;
+	}
 
-static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
-			 struct rxe_send_wqe *wqe, struct rxe_pkt_info *pkt,
-			 struct sk_buff *skb, u32 payload)
-{
-	int err;
+	if (pad) {
+		padp = payload_addr(pkt) + payload;
+		memset(padp, 0, pad);
+	}
 
+	/* IP and UDP network headers */
 	err = rxe_prepare(av, pkt, skb);
 	if (err)
-		return err;
+		goto err_out;
 
-	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
-		err = rxe_init_payload(qp, wqe, pkt, payload);
-		if (bth_pad(pkt)) {
-			u8 *pad = payload_addr(pkt) + payload;
+	if (ah)
+		rxe_put(ah);
 
-			memset(pad, 0, bth_pad(pkt));
-		}
-	}
+	return skb;
 
-	return 0;
+err_out:
+	if (err == -EFAULT)
+		wqe->status = IB_WC_LOC_PROT_ERR;
+	else
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+	if (skb)
+		kfree_skb(skb);
+	if (ah)
+		rxe_put(ah);
+
+	return NULL;
 }
 
 static void update_wqe_state(struct rxe_qp *qp,
@@ -630,7 +655,6 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -643,8 +667,6 @@ int rxe_requester(void *arg)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 	struct rxe_queue *q = qp->sq.queue;
-	struct rxe_ah *ah;
-	struct rxe_av *av;
 
 	if (!rxe_get(qp))
 		return -EAGAIN;
@@ -753,44 +775,9 @@ int rxe_requester(void *arg)
 		payload = mtu;
 	}
 
-	pkt.rxe = rxe;
-	pkt.opcode = opcode;
-	pkt.qp = qp;
-	pkt.psn = qp->req.psn;
-	pkt.mask = rxe_opcode[opcode].mask;
-	pkt.wqe = wqe;
-
-	av = rxe_get_av(&pkt, &ah);
-	if (unlikely(!av)) {
-		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err;
-	}
-
-	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
-	if (unlikely(!skb)) {
-		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
-		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		if (ah)
-			rxe_put(ah);
-		goto err;
-	}
-
-	err = finish_packet(qp, av, wqe, &pkt, skb, payload);
-	if (unlikely(err)) {
-		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
-		if (err == -EFAULT)
-			wqe->status = IB_WC_LOC_PROT_ERR;
-		else
-			wqe->status = IB_WC_LOC_QP_OP_ERR;
-		kfree_skb(skb);
-		if (ah)
-			rxe_put(ah);
+	skb = rxe_init_req_packet(qp, wqe, opcode, payload, &pkt);
+	if (unlikely(!skb))
 		goto err;
-	}
-
-	if (ah)
-		rxe_put(ah);
 
 	/*
 	 * To prevent a race on wqe access between requester and completer,
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c7f60c7b361c..44b5c159cef9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -665,22 +665,19 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	int pad;
 	int err;
 
-	/*
-	 * allocate packet
-	 */
 	pad = (-payload) & 0x3;
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
 	ack->paylen = paylen;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
-	if (!skb)
-		return NULL;
-
 	ack->qp = qp;
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
 	ack->psn = psn;
 
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
+	if (!skb)
+		return NULL;
+
 	bth_init(ack, opcode, 0, 0, pad, IB_DEFAULT_PKEY_FULL,
 		 qp->attr.dest_qp_num, 0, psn);
 
-- 
2.34.1

