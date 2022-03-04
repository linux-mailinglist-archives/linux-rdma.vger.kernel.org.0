Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0325A4CCA87
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiCDAJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiCDAJa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:30 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBC3EABB
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:42 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id k2so6369300oia.2
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l761pQymdNatlFWaay1PB2J0pvW/7MChQpkaTgqRXRo=;
        b=IneiAbbDxpR5VJG1U6R57+sKsMI3OhGdP2tShrCSqyMrgQjBK5w6BsevhNi+7XYFKH
         ojoYPSxO3FUhGiuB0hAfGjm/PvvyiYuu3gMvw9tWzJ+wHs1iYIlm6CQAAOpz6lDlNoXL
         qrUdKO6J9np4EUwbYZ4NgWMT7xg9WfuRaK2Y9yyU4Q/xFmkabMv8bu2K2Ow5jSgIKqYh
         j4OqkOmhKiHiPjPi7mB875TYOUPia6io4nfcgtKwTD+wLYM/8rk6Er5Drd3Rc4+somWZ
         My49lri3mkuGO9m5xCleZKgZnXwqaTxyaVqCS/5V+oIco8PNdLJWuYYXQ6YzTmi/M/0C
         r7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l761pQymdNatlFWaay1PB2J0pvW/7MChQpkaTgqRXRo=;
        b=BNELhuY+LzIqI/nWKcvZYwpT3MGH6xQIJzzKaWAYUDGDO4NHZ3RFVcDGrwwb73yyzG
         7lsptNqio6amZEu3zZHKhn22d2SEOuS9fX9ZcU1yBgrzngSs9Enxy7I8vwkZdlyyd2kw
         9u2diR3IQ+cQwAzt5oGqlAvg82KZsONSqYifFL/eU94dd3uq5uXdJNc2rHyjE94Fz+qA
         21pa3JXe5tfrqZpV3PcSJscOoePCZNurhlUBRiSmdBqNccyg6md58YMUnTolBB9iV7hj
         h6b+OAHjNs9YE0+kewAiJpn8RbPu4DcoSvJoSmzzWi+pfwQeGgE+6S9jxi+Q1NDj1usc
         EDrQ==
X-Gm-Message-State: AOAM532J8Rad22s8abhuerI25PmoBVkbRBf7YoUu09IpkvbyTFHc4pyI
        X9UsK+g38MwNW49ud4I2VFo=
X-Google-Smtp-Source: ABdhPJzWdHGQzDhTsAWW0+aKyNdm8M7hB2Utv+bKjTKSCr4V9C/e4pm349+JJPAfXkRgv5+CecqMLw==
X-Received: by 2002:a05:6808:488:b0:2d4:fb86:6fed with SMTP id z8-20020a056808048800b002d4fb866fedmr7070599oid.133.1646352522312;
        Thu, 03 Mar 2022 16:08:42 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:42 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 01/13] RDMA/rxe: Fix ref error in rxe_av.c
Date:   Thu,  3 Mar 2022 18:07:57 -0600
Message-Id: <20220304000808.225811-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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
index 409efeecd581..2ffbe3390668 100644
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

