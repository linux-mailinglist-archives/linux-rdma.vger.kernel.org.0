Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8B042FE41
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243378AbhJOWgJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbhJOWgI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4BC061764
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:34:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m67so15127777oif.6
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9sCSUNrdcKQ7qOdXkWQRkXdmDMPw1rZkboJhDViP6TY=;
        b=KogjXUQmqP0YZJlxlIqUhXWQbG9p5fs08p1RN7q/cFLl9Awnv6WwyjfWWZhOOVNIUl
         hkndFb3vMcQi8IAmU+l0AL6yzE8YA1IYXjT9XwfH/C/ylLbxS9/Dduk4oT2RWYmynGfS
         kgwk/9ZDFoTHzJZOKCoENlwgEg7vjEW9NiXXDQlPLad9gBX43rqi4DjsgOsSRHzein7Z
         ZR05iiOr7rnIhvzTAlo1hWycmu4h5OX/AfZOYoxuqif4iaKH1CpAuFzuMlIYMlWt5v2C
         5cidV/R2OSpXFso9wcLLR62+enOLKHCZyNJ8hWcrK6XRQtcS1ot4fs4j6x/3HQzW0FL0
         ULSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9sCSUNrdcKQ7qOdXkWQRkXdmDMPw1rZkboJhDViP6TY=;
        b=IBXjgPQSHAuRDcV7BMp+Si0GuekNRjzwJxpPJNGRC3cV2JJ3sYwNRdHvyaLMVfx9+z
         25Cs+6qXXgepfhwGyUAanebyBBjCe7CSATeNmrMOwMrAaAf6EhDg2BnC6hOnjPm8/4dp
         4chuNRC8X8nwuKvp2ILscRbREK5GBIMb2kE/FmyQv1NsIquDqkSeW0UCxoxJUcCB/jvJ
         PXRRGJlM5IT/dQ3djtX2sqivKIp+hFwOrw8s/GRrnoRka9SKKxORn9j0y3v7y5kkVrrs
         SJgfurCB5pB1buMoPMALighP8nHbpkKlOCbButLA//KmUPuRB7oPIoeNy1llrsntoRWG
         E5Gg==
X-Gm-Message-State: AOAM531DhHZYLZ0CUioQo0QVTKD/CyiHTlnChwHNN5Ctp/q06M/ggiML
        xIjAK9d+QhannOmudYnfqDIVO0Ebh5Q=
X-Google-Smtp-Source: ABdhPJzX9pepFpAKqcsxcnEKc2kjPaODSl5qD4ONhAI6VHszvkmB1e4rhLbNpBfeC90o33j8K2oY5Q==
X-Received: by 2002:a05:6808:2389:: with SMTP id bp9mr7208281oib.140.1634337240357;
        Fri, 15 Oct 2021 15:34:00 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:34:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 09/10] RDMA/rxe: Fix ref error in rxe_av.c
Date:   Fri, 15 Oct 2021 17:32:50 -0500
Message-Id: <20211015223250.6501-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/infiniband/sw/rxe/rxe_av.c   | 24 ++++++++++--
 drivers/infiniband/sw/rxe/rxe_loc.h  |  5 ++-
 drivers/infiniband/sw/rxe/rxe_net.c  | 17 +++++----
 drivers/infiniband/sw/rxe/rxe_req.c  | 55 +++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
 5 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 38c7b6fb39d7..8a6910a01e66 100644
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
 
@@ -117,10 +120,25 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (ah_num) {
 		/* only new user provider or kernel client */
 		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
-		if (!ah || ah->ah_num != ah_num || rxe_ah_pd(ah) != pkt->qp->pd) {
-			pr_warn("Unable to find AH matching ah_num\n");
+		if (!ah) {
+			pr_warn("%s: Unable to find AH matching ah_num\n",
+				__func__);
+			return NULL;
+		}
+
+		if (rxe_ah_pd(ah) != pkt->qp->pd) {
+			pr_warn("%s: PDs don't match for AH and QP\n",
+				__func__);
+			rxe_drop_ref(ah);
 			return NULL;
 		}
+
+		/* let caller hold ref to ah */
+		if (ahp)
+			*ahp = ah;
+		else
+			rxe_drop_ref(ah);
+
 		return &ah->av;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 78312df8eea3..a689ee8386b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -19,7 +19,7 @@ void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
 
 void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
 
-struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt);
+struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
 
 /* rxe_cq.c */
 int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
@@ -93,7 +93,8 @@ void rxe_mw_cleanup(struct rxe_pool_entry *arg);
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
index fcdf998ec896..996aabd6e57b 100644
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
index 0c9d2af15f3d..891cf98c74a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -361,6 +361,7 @@ static inline int get_mtu(struct rxe_qp *qp)
 }
 
 static struct sk_buff *init_req_packet(struct rxe_qp *qp,
+				       struct rxe_av *av,
 				       struct rxe_send_wqe *wqe,
 				       int opcode, int payload,
 				       struct rxe_pkt_info *pkt)
@@ -368,7 +369,6 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	struct rxe_dev		*rxe = to_rdev(qp->ibqp.device);
 	struct sk_buff		*skb;
 	struct rxe_send_wr	*ibwr = &wqe->wr;
-	struct rxe_av		*av;
 	int			pad = (-payload) & 0x3;
 	int			paylen;
 	int			solicited;
@@ -378,21 +378,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
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
@@ -453,13 +441,13 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
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
 
@@ -614,6 +602,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -625,6 +614,8 @@ int rxe_requester(void *arg)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 	struct rxe_queue *q = qp->sq.queue;
+	struct rxe_ah *ah;
+	struct rxe_av *av;
 
 	rxe_add_ref(qp);
 
@@ -711,14 +702,28 @@ int rxe_requester(void *arg)
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
@@ -726,9 +731,12 @@ int rxe_requester(void *arg)
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
@@ -757,6 +765,9 @@ int rxe_requester(void *arg)
 
 	goto next_wqe;
 
+err_drop_ah:
+	if (ah)
+		rxe_drop_ref(ah);
 err:
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e8f435fa6e4d..f589f4dde35c 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -632,7 +632,7 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	if (ack->mask & RXE_ATMACK_MASK)
 		atmack_set_orig(ack, qp->resp.atomic_orig);
 
-	err = rxe_prepare(ack, skb);
+	err = rxe_prepare(&qp->pri_av, ack, skb);
 	if (err) {
 		kfree_skb(skb);
 		return NULL;
-- 
2.30.2

