Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2536100CE
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiJ0S4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiJ0S4Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:16 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ABF248C0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:15 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id g10so3366219oif.10
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PvhWMu9/x3vdMmCVm42c5SotIg29dsGdluHAkSLFeE=;
        b=FLJ63mZkwgFpmdNwy30fBpNjbVdj+EXro/fl8lUPl11SyqHeQ40Qg1NMFkqEM7lOVN
         GxjQCqlGBZze8hOW5L3PxOV9KE7aRAcaHtIUu3J/nw3GJDZjbekdcrLsGwWtSAmisjPD
         SyoFKFVSQVofh0cgaDcASOCzzA8b++r7EAbmByXljhZvccfPXVnpHuWdFY4hOMqKXG9s
         UNqEVdkv8A4rwGXJ6yQrZit1WCaGnbcIFqegZAqtQKNg7VyvL827oYboaIFDSNw7FWYe
         oFYxvDmDuHo/BZr6wRaLnBFc6zghXm3ShKeuopptgKDiaSZTS5LT2zKJApeuQc/EnG7x
         XcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PvhWMu9/x3vdMmCVm42c5SotIg29dsGdluHAkSLFeE=;
        b=t+U+HvyUQAKHtE5CaRH6EE/1e4+aOhGKJvOcPR1SGjqSYURXak/p7sZ1xW5ziCVJsD
         rOqcK59YA2eP2dlKgo2/DxGYjxbSKn3T50zg6C0m/l77Y4nxDkgub3DL5lHTekP94M6B
         yHPdLQJh/g3EGOqkOGNoGSBuGj5umS/sRafnqHmwD8NaepOeIvoORRV7ZJ5xz9Q63hFU
         PoXQtNcWEfntek1gVuoxNdByNJHYW9pcFo70RDI/dxH86UWJ/zdIL0A82lzDQzm2fXZP
         0bUSksIPux0HT2938n6+aWOdpJ0zTMY4oZmJnW2KOTde/ZNnulbFf/WePkoRu0MlMmad
         Le2w==
X-Gm-Message-State: ACrzQf1SgMKQtRyiRCxxCrBYmfvJoFJR08+qikACH0wjGddCXWHPeZLP
        liLCOFAm83zYOpmyHkREu4U=
X-Google-Smtp-Source: AMsMyM4CpKLfGirtY/N/4h/NctPVDszfshzIvDgHQkZyd6CrrIF7Gnd5Zj9eb2AMpNw6kbFXxSdzQg==
X-Received: by 2002:a05:6808:ec2:b0:351:3762:5ff2 with SMTP id q2-20020a0568080ec200b0035137625ff2mr5577398oiv.218.1666896974345;
        Thu, 27 Oct 2022 11:56:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/17] RDMA/rxe: Isolate code to build request packet
Date:   Thu, 27 Oct 2022 13:54:57 -0500
Message-Id: <20221027185510.33808-4-rpearsonhpe@gmail.com>
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

Isolate all the code to build a request packet into a single
subroutine called rxe_init_req_packet().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h  |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  |   6 +-
 drivers/infiniband/sw/rxe/rxe_req.c  | 121 ++++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_resp.c |  11 +--
 4 files changed, 62 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index c2a5c8814a48..574a6afc1199 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -92,7 +92,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt);
+				struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 35f327b9d4b8..1e4456f5cda2 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -443,7 +443,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 }
 
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt)
+				struct rxe_pkt_info *pkt)
 {
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
@@ -468,7 +468,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		rcu_read_unlock();
 		goto out;
 	}
-	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
+	skb = alloc_skb(pkt->paylen + hdr_len + LL_RESERVED_SPACE(ndev),
 			GFP_ATOMIC);
 
 	if (unlikely(!skb)) {
@@ -489,7 +489,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	pkt->rxe	= rxe;
 	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put(skb, paylen);
+	pkt->hdr	= skb_put(skb, pkt->paylen);
 	pkt->mask	|= RXE_GRH_MASK;
 
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 10a75f4e3608..8cc683ebf536 100644
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
 	struct sk_buff *skb;
-	int pad = (-payload) & 0x3;
-	int paylen;
+	struct rxe_av *av;
+	struct rxe_ah *ah;
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
-	skb = rxe_init_packet(rxe, av, paylen, pkt);
+	skb = rxe_init_packet(rxe, av, pkt);
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
index 95d372db934d..a00885799619 100644
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
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
-	if (!skb)
-		return NULL;
-
 	ack->qp = qp;
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
 	ack->paylen = paylen;
 	ack->psn = psn;
 
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
+	if (!skb)
+		return NULL;
+
 	bth_init(ack, opcode, 0, 0, pad, IB_DEFAULT_PKEY_FULL,
 		 qp->attr.dest_qp_num, 0, psn);
 
-- 
2.34.1

