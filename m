Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102E4C4F2E
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiBYT7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiBYT7H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:07 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A162C124C3A
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:34 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so7684089oos.10
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjjOX2o3Y+gAlo4FmhEGIuKBPbq9O0Sd7QHIrqwwMy0=;
        b=nif8EgmFMntKkfISLcBUO/BjyXbdaAM+aLagXmp2i2TEOPeT8JugEoVIEK7p44/PB0
         L9zcjVmu+U/pFbYRHzvh8X1LbQkopBw3eux36XsdSPSbmg/Qk0RuiYbyCzQ2aKN2p/Hy
         HzUnqyKyEUIElKh2vQKXDXORob/lt8QqEjP0DUvnN2ySolMcXjg2MQ3QAcCH+wdFFMhw
         ye4VOdMHZEL/QK4DtKvx5Kw6hLgBFzp9jplwnOfQFrPlldu5IDHeAX05WN8wtdMFFql2
         m4dZs7sc1WFlqfYmYaOiyHOCI+Yp3Msl6Ogo6vvHUkDcPEFHbh0drQYAg5PSLbRHu09T
         6MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjjOX2o3Y+gAlo4FmhEGIuKBPbq9O0Sd7QHIrqwwMy0=;
        b=UuOlwvwkUZISoLWmKngn+2c40V9Bt3ws6262vRse9hyef+xar2GfA7xcLSnDEqbN32
         ROFJJQBcCOIomoX08RHXxXDr1o7QXsT8mu4O0oIzqelfcjyACW+GTgYaghS7WVc1iRzz
         Ny2u+7qZsaAdR/9adufmwzSdyy3/htpBXBLYgkQNq+h01IgN1dOO1aKiqErCCp3Mkj1G
         MCQ6PScPTCql+VXMYowSigQ4F+TDA9Dx5kkHCzwNFmq6o5jaJGL9kqOyJCakp1OJ4Wje
         O4aDbjy7xx051bNYhKSgUfiirOW5pBjEooKp/vwlP5nzZMXkiW0qk9PT817I93JP3ORG
         d3Kg==
X-Gm-Message-State: AOAM530CSitQBkhGB4EhOvTmKhbrtjdeJ1IreoykZc/YvzW0pp4WgNjn
        Q0QxqhjijKRTyadhk8dtmGE=
X-Google-Smtp-Source: ABdhPJyRZETg5MJR8F3vlt42bH5qpJP1ryYjWbFOphRWASzeII787qxoz//rwoc3aXnLNiS4G5MUng==
X-Received: by 2002:a05:6870:b417:b0:d4:547c:7a76 with SMTP id x23-20020a056870b41700b000d4547c7a76mr2144291oap.65.1645819113950;
        Fri, 25 Feb 2022 11:58:33 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:33 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 07/11] RDMA/rxe: Fix ref error in rxe_av.c
Date:   Fri, 25 Feb 2022 13:57:47 -0600
Message-Id: <20220225195750.37802-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
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

The commit referenced below can take a reference to the AH which is
never dropped. This only happens in the UD request path. This patch
optionally passes that AH back to the caller so that it can hold the
reference while the AV is being accessed and then drop it. Code to
do this is added to rxe_req.c. The AV is also passed to rxe_prepare
in rxe_net.c as an optimization.

Fixes: e2fe06c90806 ("RDMA/rxe: Lookup kernel AH from ah index in UD WQEs")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c   | 19 +++++++++-
 drivers/infiniband/sw/rxe/rxe_loc.h  |  5 ++-
 drivers/infiniband/sw/rxe/rxe_net.c  | 17 +++++----
 drivers/infiniband/sw/rxe/rxe_req.c  | 55 +++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
 5 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 38c7b6fb39d7..360a567159fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -99,11 +99,14 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
 	av->network_type = type;
 }
 
-struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
+struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp)
 {
 	struct rxe_ah *ah;
 	u32 ah_num;
 
+	if (ahp)
+		*ahp = NULL;
+
 	if (!pkt || !pkt->qp)
 		return NULL;
 
@@ -117,10 +120,22 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (ah_num) {
 		/* only new user provider or kernel client */
 		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
-		if (!ah || ah->ah_num != ah_num || rxe_ah_pd(ah) != pkt->qp->pd) {
+		if (!ah) {
 			pr_warn("Unable to find AH matching ah_num\n");
 			return NULL;
 		}
+
+		if (rxe_ah_pd(ah) != pkt->qp->pd) {
+			pr_warn("PDs don't match for AH and QP\n");
+			rxe_drop_ref(ah);
+			return NULL;
+		}
+
+		if (ahp)
+			*ahp = ah;
+		else
+			rxe_drop_ref(ah);
+
 		return &ah->av;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 2ad28351ba44..c7ba112d5c67 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -19,7 +19,7 @@ void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
 
 void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
 
-struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt);
+struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
 
 /* rxe_cq.c */
 int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
@@ -94,7 +94,8 @@ void rxe_mw_cleanup(struct rxe_pool_elem *arg);
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
-int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb);
+int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
+		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index a8cfa7160478..b06f22ffc5a8 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -271,13 +271,13 @@ static void prepare_ipv6_hdr(struct dst_entry *dst, struct sk_buff *skb,
 	ip6h->payload_len = htons(skb->len - sizeof(*ip6h));
 }
 
-static int prepare4(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static int prepare4(struct rxe_av *av, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb)
 {
 	struct rxe_qp *qp = pkt->qp;
 	struct dst_entry *dst;
 	bool xnet = false;
 	__be16 df = htons(IP_DF);
-	struct rxe_av *av = rxe_get_av(pkt);
 	struct in_addr *saddr = &av->sgid_addr._sockaddr_in.sin_addr;
 	struct in_addr *daddr = &av->dgid_addr._sockaddr_in.sin_addr;
 
@@ -297,11 +297,11 @@ static int prepare4(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	return 0;
 }
 
-static int prepare6(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static int prepare6(struct rxe_av *av, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb)
 {
 	struct rxe_qp *qp = pkt->qp;
 	struct dst_entry *dst;
-	struct rxe_av *av = rxe_get_av(pkt);
 	struct in6_addr *saddr = &av->sgid_addr._sockaddr_in6.sin6_addr;
 	struct in6_addr *daddr = &av->dgid_addr._sockaddr_in6.sin6_addr;
 
@@ -322,16 +322,17 @@ static int prepare6(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	return 0;
 }
 
-int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
+		struct sk_buff *skb)
 {
 	int err = 0;
 
 	if (skb->protocol == htons(ETH_P_IP))
-		err = prepare4(pkt, skb);
+		err = prepare4(av, pkt, skb);
 	else if (skb->protocol == htons(ETH_P_IPV6))
-		err = prepare6(pkt, skb);
+		err = prepare6(av, pkt, skb);
 
-	if (ether_addr_equal(skb->dev->dev_addr, rxe_get_av(pkt)->dmac))
+	if (ether_addr_equal(skb->dev->dev_addr, av->dmac))
 		pkt->mask |= RXE_LOOPBACK_MASK;
 
 	return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 5eb89052dd66..f44535f82bea 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -358,6 +358,7 @@ static inline int get_mtu(struct rxe_qp *qp)
 }
 
 static struct sk_buff *init_req_packet(struct rxe_qp *qp,
+				       struct rxe_av *av,
 				       struct rxe_send_wqe *wqe,
 				       int opcode, int payload,
 				       struct rxe_pkt_info *pkt)
@@ -365,7 +366,6 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff		*skb;
 	struct rxe_send_wr	*ibwr = &wqe->wr;
-	struct rxe_av		*av;
 	int			pad = (-payload) & 0x3;
 	int			paylen;
 	int			solicited;
@@ -374,21 +374,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* length from start of bth to end of icrc */
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
-
-	/* pkt->hdr, port_num and mask are initialized in ifc layer */
-	pkt->rxe	= rxe;
-	pkt->opcode	= opcode;
-	pkt->qp		= qp;
-	pkt->psn	= qp->req.psn;
-	pkt->mask	= rxe_opcode[opcode].mask;
-	pkt->paylen	= paylen;
-	pkt->wqe	= wqe;
+	pkt->paylen = paylen;
 
 	/* init skb */
-	av = rxe_get_av(pkt);
-	if (!av)
-		return NULL;
-
 	skb = rxe_init_packet(rxe, av, paylen, pkt);
 	if (unlikely(!skb))
 		return NULL;
@@ -447,13 +435,13 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	return skb;
 }
 
-static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
-		       struct rxe_pkt_info *pkt, struct sk_buff *skb,
-		       int paylen)
+static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
+			 struct rxe_send_wqe *wqe, struct rxe_pkt_info *pkt,
+			 struct sk_buff *skb, int paylen)
 {
 	int err;
 
-	err = rxe_prepare(pkt, skb);
+	err = rxe_prepare(av, pkt, skb);
 	if (err)
 		return err;
 
@@ -608,6 +596,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -619,6 +608,8 @@ int rxe_requester(void *arg)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 	struct rxe_queue *q = qp->sq.queue;
+	struct rxe_ah *ah;
+	struct rxe_av *av;
 
 	rxe_add_ref(qp);
 
@@ -705,14 +696,28 @@ int rxe_requester(void *arg)
 		payload = mtu;
 	}
 
-	skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
+	pkt.rxe = rxe;
+	pkt.opcode = opcode;
+	pkt.qp = qp;
+	pkt.psn = qp->req.psn;
+	pkt.mask = rxe_opcode[opcode].mask;
+	pkt.wqe = wqe;
+
+	av = rxe_get_av(&pkt, &ah);
+	if (unlikely(!av)) {
+		pr_err("qp#%d Failed no address vector\n", qp_num(qp));
+		wqe->status = IB_WC_LOC_QP_OP_ERR;
+		goto err_drop_ah;
+	}
+
+	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
 		wqe->status = IB_WC_LOC_QP_OP_ERR;
-		goto err;
+		goto err_drop_ah;
 	}
 
-	ret = finish_packet(qp, wqe, &pkt, skb, payload);
+	ret = finish_packet(qp, av, wqe, &pkt, skb, payload);
 	if (unlikely(ret)) {
 		pr_debug("qp#%d Error during finish packet\n", qp_num(qp));
 		if (ret == -EFAULT)
@@ -720,9 +725,12 @@ int rxe_requester(void *arg)
 		else
 			wqe->status = IB_WC_LOC_QP_OP_ERR;
 		kfree_skb(skb);
-		goto err;
+		goto err_drop_ah;
 	}
 
+	if (ah)
+		rxe_drop_ref(ah);
+
 	/*
 	 * To prevent a race on wqe access between requester and completer,
 	 * wqe members state and psn need to be set before calling
@@ -751,6 +759,9 @@ int rxe_requester(void *arg)
 
 	goto next_wqe;
 
+err_drop_ah:
+	if (ah)
+		rxe_drop_ref(ah);
 err:
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c369d78fc8e8..b5ebe853748a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -633,7 +633,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	if (ack->mask & RXE_ATMACK_MASK)
 		atmack_set_orig(ack, qp->resp.atomic_orig);
 
-	err = rxe_prepare(ack, skb);
+	err = rxe_prepare(&qp->pri_av, ack, skb);
 	if (err) {
 		kfree_skb(skb);
 		return NULL;
-- 
2.32.0

