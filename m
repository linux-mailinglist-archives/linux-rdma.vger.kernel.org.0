Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D805E49ED9B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbiA0ViY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbiA0ViX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:23 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8BEC061748
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:23 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s9so8492894oib.11
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfM6reqAdf0gdHXElwBXQfSnLF2WGcKRIDOZUdXrjbo=;
        b=gBsPXTgvXhOT8vbdV68txvTL5s3RWs5bVEd1OCoXJeSMdyK3nzRtFcXlDDHpwKneI0
         4oK9+SDiL3K6YLu0j803tNtTiSKEHNJO72V6rIy2VEhVN0XrM7wDREyGDD58eMQp/RG8
         39Njk9ENZKkCodsv6XkYA0hCOVz/u6tHXnIfxq5tcJEkxa6cOyb9wU52PI8RE6ypw1Gt
         EYwl/K2rZO0OtjF0U24FPKqknTJb16bw4Q1DBi+kdFlD06wRjPbYCsE81nAgDrCn+HK9
         sbH6EIO3i3p0gu5PO0rGf489odUf7u7VysvwrTA61vsuSi8Wmx8CEz/KtIQpf7OvGDGA
         mCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfM6reqAdf0gdHXElwBXQfSnLF2WGcKRIDOZUdXrjbo=;
        b=1+W0ZQ9dxb8XopiD2yYU5nVk8ctiwXFSCgjl8aolB9nfBhgmS5mu/2ZZb58VEPyvIa
         nzDUiSiXMF5u73mosPDVOT1pzf1iEFPyRLFZN1mT7HUWanUgbRGcCXlTslUWARHUlB0s
         SOS/wmFQnpXgxsrRGLeWuzYZTy3QjLEHmsElpKj0cHKRozSt/IbSxAy8De7S0QK1J1ko
         2+Vz2YWeqBAzQxxx9mUXz4pRZykNL9UqY96F6arMAUeCSFNY+VasqGzpk+R5xy5kieGJ
         5g8kB/9sUUPqEEvjAybsnCmuc4rLytAp1znWwrA/sHFbOCONe8MZadYUHZVDdxx2t3fQ
         XSjw==
X-Gm-Message-State: AOAM530BblChLwdNsJlUMYjz6SaPWm0E79xINWyZToTscNGXvCDwyLtV
        1WQpf2WXiKczmyArnlJ8hqI=
X-Google-Smtp-Source: ABdhPJzxl/mm2PFYJWr/GE/st5IF6PFOlxGVyjyTc24N+RzOwqr91c9uVetJ2I2s/j2CBWxPyFR/qQ==
X-Received: by 2002:a05:6808:198f:: with SMTP id bj15mr3293003oib.119.1643319503129;
        Thu, 27 Jan 2022 13:38:23 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:22 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 25/26] RDMA/rxe: Fix ref error in rxe_av.c
Date:   Thu, 27 Jan 2022 15:37:54 -0600
Message-Id: <20220127213755.31697-26-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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
index 0bc1b7e2877c..31a052c5d5f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -19,7 +19,7 @@ void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
 
 void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
 
-struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt);
+struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
 
 /* rxe_cq.c */
 int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
@@ -95,7 +95,8 @@ void rxe_mw_cleanup(struct rxe_pool_elem *arg);
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
2.32.0

