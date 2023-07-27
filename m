Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA68A765C19
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 21:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjG0T3Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjG0T3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 15:29:24 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3773F2D6A
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:23 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bbdddd3c94so625584fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690486162; x=1691090962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8vVWLv3xHOZsScN9ExGukhndZ4N4biDRmrkjSQVWlU=;
        b=RBZsy8svdRHsXbsU4ps114panTuoFv6NDFQcWpQ0L9FOy2zj3Ze0VzEkxRuPCts2kk
         cPj3w8sgmZ+0q+rnpcIOehfLC/S6925J8cdb9IeCo9lk5vuvPZK7lGGCpCv3UPGnPk4j
         l8Q4977TIn76bkrFMT2MzoJpEDIdZAyS8gkDyEvT1ky/0pRnb3llm+hVdenPmLhAxAbl
         frVoVzeaV/8RmEgW0mhbeyR2C8Kg4W8BLSe9Qx6pmP0Yvt7F4kXOjqwv0nHoy2oiD/uL
         MNP38ZYFtrZkNP5hc+ZgCRXVeB8tHMo3FEAoSrtAgosWmYIF4gYWY8967EvaefABGRZG
         BRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486162; x=1691090962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8vVWLv3xHOZsScN9ExGukhndZ4N4biDRmrkjSQVWlU=;
        b=D5EqQmWGuwlFJ/hVDuEBgpmZHSwtxqf7niNnnLvnzIqVXlZ9Txe6qdaoQYC6fuM6te
         hfGUydgM/rlTL5R3wMweOL+R9sf7JfAuVMTVeX4Roez7Pc4KAVI+Xyn4u7ClCqk/BLhU
         t+0AHP0ikcGnZAWrcktevDSOgrFP+85/2youhQNVaDGpo/IZYthE33fDAMogFnolc5AF
         byvQkq2a6cN7bLDDU728yaGZlAJLUs36ZTKEsSA7ZWrE8TP5EcMQKajMHf+JM8sT8nHJ
         QJioSDtgdibcZeNqFSzs1dQRVm7bLhY/+TlZrbC5EkBEFqX+XKD1wCtTSKysXrDVK+UG
         HKIg==
X-Gm-Message-State: ABy/qLYO2w4tM0eiaAuaEPw+ne1k7OY7g4gcPOg+fuJjMhQ5dyu6Bxix
        eG6cIDnIuR/MODf8o5UB/vk=
X-Google-Smtp-Source: APBJJlFZzFe475gSFYaduncHZLipWHgoFlppN+eO3L0VxTcwIersediMPicaDayxHKTWZEki+vYpgA==
X-Received: by 2002:a05:6870:eca1:b0:1b0:5fc0:e2b5 with SMTP id eo33-20020a056870eca100b001b05fc0e2b5mr420120oab.53.1690486162485;
        Thu, 27 Jul 2023 12:29:22 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id f185-20020a4a58c2000000b005658aed310bsm955354oob.15.2023.07.27.12.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:29:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 1/8] RDMA/rxe: Add pad size to struct rxe_pkt_info
Date:   Thu, 27 Jul 2023 14:28:25 -0500
Message-Id: <20230727192831.65495-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727192831.65495-1-rpearsonhpe@gmail.com>
References: <20230727192831.65495-1-rpearsonhpe@gmail.com>
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

Add the packet pad size to struct rxe_pkt_info and use this to
simplify references to pad size in the rxe driver.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_icrc.c |  4 ++--
 drivers/infiniband/sw/rxe/rxe_recv.c |  1 +
 drivers/infiniband/sw/rxe/rxe_req.c  | 20 ++++++++++----------
 drivers/infiniband/sw/rxe/rxe_resp.c | 24 +++++++++++-------------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index 46f82b27fcd2..1dcdb87fa01a 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -22,6 +22,7 @@ struct rxe_pkt_info {
 	u16			paylen;		/* length of bth - icrc */
 	u8			port_num;	/* port pkt received on */
 	u8			opcode;		/* bth opcode of packet */
+	u8			pad;		/* pad size of packet */
 };
 
 /* Macros should be used only for received skb */
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index fdf5f08cd8f1..c9aa0995e900 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -148,7 +148,7 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 
 	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + bth_pad(pkt));
+				payload_size(pkt) + pkt->pad);
 	icrc = ~icrc;
 
 	if (unlikely(icrc != pkt_icrc))
@@ -170,6 +170,6 @@ void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
 	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + bth_pad(pkt));
+				payload_size(pkt) + pkt->pad);
 	*icrcp = ~icrc;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 5861e4244049..f912a913f89a 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -329,6 +329,7 @@ void rxe_rcv(struct sk_buff *skb)
 	pkt->psn = bth_psn(pkt);
 	pkt->qp = NULL;
 	pkt->mask |= rxe_opcode[pkt->opcode].mask;
+	pkt->pad = bth_pad(pkt);
 
 	if (unlikely(skb->len < header_size(pkt)))
 		goto drop;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d8c41fd626a9..31858761ca1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -420,18 +420,17 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff		*skb;
 	struct rxe_send_wr	*ibwr = &wqe->wr;
-	int			pad = (-payload) & 0x3;
-	int			paylen;
 	int			solicited;
 	u32			qp_num;
 	int			ack_req;
 
 	/* length from start of bth to end of icrc */
-	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
-	pkt->paylen = paylen;
+	pkt->pad = (-payload) & 0x3;
+	pkt->paylen = rxe_opcode[opcode].length + payload +
+			pkt->pad + RXE_ICRC_SIZE;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, paylen, pkt);
+	skb = rxe_init_packet(rxe, av, pkt->paylen, pkt);
 	if (unlikely(!skb))
 		return NULL;
 
@@ -450,7 +449,8 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
-	bth_init(pkt, pkt->opcode, solicited, 0, pad, IB_DEFAULT_PKEY_FULL, qp_num,
+	bth_init(pkt, pkt->opcode, solicited, 0, pkt->pad,
+		 IB_DEFAULT_PKEY_FULL, qp_num,
 		 ack_req, pkt->psn);
 
 	/* init optional headers */
@@ -499,6 +499,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 			 struct rxe_send_wqe *wqe, struct rxe_pkt_info *pkt,
 			 struct sk_buff *skb, u32 payload)
 {
+	u8 *pad_addr;
 	int err;
 
 	err = rxe_prepare(av, pkt, skb);
@@ -520,10 +521,9 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 			if (err)
 				return err;
 		}
-		if (bth_pad(pkt)) {
-			u8 *pad = payload_addr(pkt) + payload;
-
-			memset(pad, 0, bth_pad(pkt));
+		if (pkt->pad) {
+			pad_addr = payload_addr(pkt) + payload;
+			memset(pad_addr, 0, pkt->pad);
 		}
 	} else if (pkt->mask & RXE_FLUSH_MASK) {
 		/* oA19-2: shall have no payload. */
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 64c64f5f36a8..fc2f55329fa2 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -525,7 +525,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 skip_check_range:
 	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (resid > mtu) {
-			if (pktlen != mtu || bth_pad(pkt)) {
+			if (pktlen != mtu || pkt->pad) {
 				state = RESPST_ERR_LENGTH;
 				goto err;
 			}
@@ -534,7 +534,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 				state = RESPST_ERR_LENGTH;
 				goto err;
 			}
-			if ((bth_pad(pkt) != (0x3 & (-resid)))) {
+			if ((pkt->pad != (0x3 & (-resid)))) {
 				/* This case may not be exactly that
 				 * but nothing else fits.
 				 */
@@ -766,27 +766,25 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff *skb;
-	int paylen;
-	int pad;
 	int err;
 
 	/*
 	 * allocate packet
 	 */
-	pad = (-payload) & 0x3;
-	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
+	ack->pad = (-payload) & 0x3;
+	ack->paylen = rxe_opcode[opcode].length + payload +
+			ack->pad + RXE_ICRC_SIZE;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack->paylen, ack);
 	if (!skb)
 		return NULL;
 
 	ack->qp = qp;
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
-	ack->paylen = paylen;
 	ack->psn = psn;
 
-	bth_init(ack, opcode, 0, 0, pad, IB_DEFAULT_PKEY_FULL,
+	bth_init(ack, opcode, 0, 0, ack->pad, IB_DEFAULT_PKEY_FULL,
 		 qp->attr.dest_qp_num, 0, psn);
 
 	if (ack->mask & RXE_AETH_MASK) {
@@ -874,6 +872,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	int err;
 	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr;
+	u8 *pad_addr;
 
 	if (!res) {
 		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
@@ -932,10 +931,9 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 		goto err_out;
 	}
 
-	if (bth_pad(&ack_pkt)) {
-		u8 *pad = payload_addr(&ack_pkt) + payload;
-
-		memset(pad, 0, bth_pad(&ack_pkt));
+	if (ack_pkt.pad) {
+		pad_addr = payload_addr(&ack_pkt) + payload;
+		memset(pad_addr, 0, ack_pkt.pad);
 	}
 
 	/* rxe_xmit_packet always consumes the skb */
-- 
2.39.2

