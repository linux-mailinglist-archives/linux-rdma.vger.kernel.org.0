Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3692466D9D
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356434AbhLBXZJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbhLBXY6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:58 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F089C06174A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:33 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so1719793otu.10
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxnIAChd5yz7XN7CZFN7y6OIcTpmkHYw69yec4yrCJs=;
        b=FVi8duGhe3cjc1xQ1fbm+amYkaHYQcsUYUpEPAww3hNBXa9iN6YJrGWN1i2/laHWYu
         /g6kiWbLStaMws9qJ2nMRNeJDiNOnOXehoxbVUlaf9R/5KSFU8jTEvn2/Lza84nctV6L
         cGOwOxw/Ih9sbRRftsA/YFStMRwphOl/7ZlGUBdcsP5lgPuMXWgz/PqDFC3cKoSseexI
         xzcEDhBDYOopZ0PGtf9lELIibPiQcNMBra2bK5m9oXMIM4ZBfjV52FN22/nP/pwsDY0U
         cwcNdVFK157/k7U70xzwWWmpygwHdQAwx5Y6sqHlkV4Uy0iRCeEUBa5MIlKhq2YBvUzb
         YzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxnIAChd5yz7XN7CZFN7y6OIcTpmkHYw69yec4yrCJs=;
        b=eZQZ9IYsDn2ZeHZo8aHumnaENO8ciM1R2ltAqbYQkDn4cY7klGuN1borwuHmPnnRmm
         UXwDCO8MwZ8VoiwCvDiFZsvN/VcNdfeOwZpq0ww5XnLFeH3PNdFKh9UCAmU+jy9tH1LQ
         o4mmk7/GDyxCOk8i9kWfWeYhnGuGI32w8uqp77M+tbqKVx89ISocRu1OzyCwkv14gDW/
         8cFfObFpID+piZ7pNy2QiBtzrZP5NapJzdRSOGWh/BZPoHmQFv6jtp2hdhKwrZeZmyjH
         sJeTE63Or0iveM4dJNRKJF4WInB+TqJGY/SqYObnCU01KAnoOVehlnj7yvpe/LEqWzQ0
         RVlg==
X-Gm-Message-State: AOAM531Y+5Jtn670Rj3WHrOQnrCUkKQXOGbJY3+wACZ32fZXIRtJs+eT
        CLwwoQHARqLtmDQSMc9LNfgGLuHkTvs=
X-Google-Smtp-Source: ABdhPJxVYRAwDe2NLGKQwd+0M0Hyv3VgIj/+56QyPnPEAl/tojhZJ1xmdx1L/SFHmAkSW9pyfAog+w==
X-Received: by 2002:a05:6830:928:: with SMTP id v40mr13814496ott.203.1638487292878;
        Thu, 02 Dec 2021 15:21:32 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:32 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 4/8] RDMA/rxe: Fix ref error in rxe_av.c
Date:   Thu,  2 Dec 2021 17:20:31 -0600
Message-Id: <20211202232035.62299-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202232035.62299-1-rpearsonhpe@gmail.com>
References: <20211202232035.62299-1-rpearsonhpe@gmail.com>
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
index 6558602be751..02d57c894e34 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -19,7 +19,7 @@ void rxe_av_to_attr(struct rxe_av *av, struct rdma_ah_attr *attr);
 
 void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
 
-struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt);
+struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
 
 /* rxe_cq.c */
 int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
@@ -99,7 +99,8 @@ void rxe_mw_cleanup(struct rxe_pool_elem *arg);
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
index 2cb810cb890a..456e960cacd7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -293,13 +293,13 @@ static void prepare_ipv6_hdr(struct dst_entry *dst, struct sk_buff *skb,
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
 
@@ -319,11 +319,11 @@ static int prepare4(struct rxe_pkt_info *pkt, struct sk_buff *skb)
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
 
@@ -344,16 +344,17 @@ static int prepare6(struct rxe_pkt_info *pkt, struct sk_buff *skb)
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
index c8d674da5cc2..7bc1ec8a5aa6 100644
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
@@ -375,21 +375,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
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
@@ -450,13 +438,13 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
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
 
@@ -611,6 +599,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 int rxe_requester(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	struct rxe_pkt_info pkt;
 	struct sk_buff *skb;
 	struct rxe_send_wqe *wqe;
@@ -622,6 +611,8 @@ int rxe_requester(void *arg)
 	struct rxe_send_wqe rollback_wqe;
 	u32 rollback_psn;
 	struct rxe_queue *q = qp->sq.queue;
+	struct rxe_ah *ah;
+	struct rxe_av *av;
 
 	rxe_add_ref(qp);
 
@@ -708,14 +699,28 @@ int rxe_requester(void *arg)
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
@@ -723,9 +728,12 @@ int rxe_requester(void *arg)
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
@@ -754,6 +762,9 @@ int rxe_requester(void *arg)
 
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

