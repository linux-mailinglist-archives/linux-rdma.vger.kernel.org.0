Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4389C3DAF7B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbhG2Wuj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhG2Wuj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F5DC061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z26so10522737oih.10
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oobDKmRpZg4T24wc5tjUXkb0wWmKqN1lWTB2chF+JQE=;
        b=vVaDbo40vb+ZTkoLNuLgYMMJ1z7gX/zWCQF9NhfhbipvqHAyhRKPXnxlAZVAWJzR9X
         q9vwJWD8DhB/UNbZnx96qS6p9dzrvOmBdgiTUcAPBCVAOWG2mAutIDAN2n7Z87O7M9r2
         VMFPobgMBS/hn9JwrmACBk+qGfF8BamCC2Q0PD7r1tj9PR8rvFUAAcgPfmTMJtwMYDFL
         r3usF7F+qnPVsmskal7vgg+DvKs8QRINCkmA2Vxv3PhdtOSWV7/lWcmxF0tT/tofNtcG
         irRdicIXQC8Jl5YmyeAd12rB9NWhcpm8Lm6fx3t2vlhU9xiupEWDg9l8C8iFyqcjxpg6
         xSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oobDKmRpZg4T24wc5tjUXkb0wWmKqN1lWTB2chF+JQE=;
        b=ASq1xqnkYE1aGNJsUGHu6uQeocgPD8lziRhIA/IPv+lmSnZRmQbQt1Bwom5QNqhd4V
         UAz25wElJG9Z09CsfusfAUnkY9AJQrwE74VmYXIADc7QCpNw6zICj+sCnGq0W0ATuXKG
         1aPxM4qycmlhqM1BLLZB3y8jqdM77pK7JOWiFmQQh0B28f+nZLMC+BNbm4tQptPUuL/d
         BhuiROPQZMzRc6UvUEj8NOOuh2NBmA+WgXWKLcE9Lj/cica0rt/94v+cFCVX44JfBB2A
         Wqia5PLviLXlz1EBEVLRyilD0rw0JDMmabh0f+ZuPMQ1YJMA6oofWdhQlgu6cZjU7ABl
         zvng==
X-Gm-Message-State: AOAM5324X+AU3IZc7HNuo2y0BybU17kRZeiKqDrLT7KVGPopVc/IAGYn
        2Czl/xo24DShchtGbbiggxg=
X-Google-Smtp-Source: ABdhPJzor4xxnd7B3T5wItE56bn+DQCba11BWuGDLl277cfIJ6FDbdM7kBEK1lmAqRcQRT0NHRISjQ==
X-Received: by 2002:a54:4817:: with SMTP id j23mr11429969oij.59.1627599034311;
        Thu, 29 Jul 2021 15:50:34 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c8sm779142oto.17.2021.07.29.15.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 01/13] RDMA/rxe: Decouple rxe_pkt_info from sk_buff
Date:   Thu, 29 Jul 2021 17:49:04 -0500
Message-Id: <20210729224915.38986-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently on the receive path the rxe_pkt_info struct is stored in the
skb->cb array. But this patch series requires extending it beyond 48 bytes
and it is already at the limit. This patch places a pointer to the
pkt info struct in skb->cb and allocates it separately. All instances of
freeing the skb on the receive path are collected into rxe_free_pkt() calls
which is extended to free the pkt info struct. In rxe_rcv_mcast_pkt()
if skb_clone fails continue is replaced by break since we are out of
memory and there is no point going on to the other mcast QPs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 20 +++-------------
 drivers/infiniband/sw/rxe/rxe_hdr.h  | 13 ++++++++---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  3 +++
 drivers/infiniband/sw/rxe/rxe_net.c  | 14 +++++++++--
 drivers/infiniband/sw/rxe/rxe_recv.c | 35 +++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_resp.c | 18 ++++----------
 6 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1ccd2deff835..4d62e5bdf820 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -522,11 +522,8 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 	struct rxe_send_wqe *wqe;
 	struct rxe_queue *q = qp->sq.queue;
 
-	while ((skb = skb_dequeue(&qp->resp_pkts))) {
-		rxe_drop_ref(qp);
-		kfree_skb(skb);
-		ib_device_put(qp->ibqp.device);
-	}
+	while ((skb = skb_dequeue(&qp->resp_pkts)))
+		rxe_free_pkt(SKB_TO_PKT(skb));
 
 	while ((wqe = queue_head(q, q->type))) {
 		if (notify) {
@@ -538,17 +535,6 @@ static void rxe_drain_resp_pkts(struct rxe_qp *qp, bool notify)
 	}
 }
 
-static void free_pkt(struct rxe_pkt_info *pkt)
-{
-	struct sk_buff *skb = PKT_TO_SKB(pkt);
-	struct rxe_qp *qp = pkt->qp;
-	struct ib_device *dev = qp->ibqp.device;
-
-	kfree_skb(skb);
-	rxe_drop_ref(qp);
-	ib_device_put(dev);
-}
-
 int rxe_completer(void *arg)
 {
 	struct rxe_qp *qp = (struct rxe_qp *)arg;
@@ -757,7 +743,7 @@ int rxe_completer(void *arg)
 
 done:
 	if (pkt)
-		free_pkt(pkt);
+		rxe_free_pkt(pkt);
 	rxe_drop_ref(qp);
 
 	return ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..d9d15c672f86 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -12,6 +12,7 @@
  * sk_buff for received packets.
  */
 struct rxe_pkt_info {
+	struct sk_buff		*skb;		/* back pointer to skb */
 	struct rxe_dev		*rxe;		/* device that owns packet */
 	struct rxe_qp		*qp;		/* qp that owns packet */
 	struct rxe_send_wqe	*wqe;		/* send wqe */
@@ -24,16 +25,22 @@ struct rxe_pkt_info {
 	u8			opcode;		/* bth opcode of packet */
 };
 
+/* rxe info in skb->cb */
+struct rxe_cb {
+	struct rxe_pkt_info	*pkt;		/* pointer to pkt info */
+};
+
+#define RXE_CB(skb) ((struct rxe_cb *)skb->cb)
+
 /* Macros should be used only for received skb */
 static inline struct rxe_pkt_info *SKB_TO_PKT(struct sk_buff *skb)
 {
-	BUILD_BUG_ON(sizeof(struct rxe_pkt_info) > sizeof(skb->cb));
-	return (void *)skb->cb;
+	return RXE_CB(skb)->pkt;
 }
 
 static inline struct sk_buff *PKT_TO_SKB(struct rxe_pkt_info *pkt)
 {
-	return container_of((void *)pkt, struct sk_buff, cb);
+	return pkt->skb;
 }
 
 /*
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index de75413fb4d9..b4d45c592bd7 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -139,6 +139,9 @@ static inline int qp_mtu(struct rxe_qp *qp)
 		return IB_MTU_4096;
 }
 
+/* rxe_recv.c */
+void rxe_free_pkt(struct rxe_pkt_info *pkt);
+
 static inline int rcv_wqe_size(int max_sge)
 {
 	return sizeof(struct rxe_recv_wqe) +
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 4f96437a2a8e..6212e61d267b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -155,7 +155,7 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	struct udphdr *udph;
 	struct rxe_dev *rxe;
 	struct net_device *ndev = skb->dev;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct rxe_pkt_info *pkt;
 
 	/* takes a reference on rxe->ib_dev
 	 * drop when skb is freed
@@ -172,6 +172,10 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
+	pkt = kzalloc(sizeof(*pkt), GFP_ATOMIC);
+	RXE_CB(skb)->pkt = pkt;
+	pkt->skb = skb;
+
 	udph = udp_hdr(skb);
 	pkt->rxe = rxe;
 	pkt->port_num = 1;
@@ -407,15 +411,21 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  */
 static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
-	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
+	struct rxe_pkt_info *new_pkt;
 
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
 
+	new_pkt = kzalloc(sizeof(*new_pkt), GFP_ATOMIC);
+	memcpy(new_pkt, pkt, sizeof(*pkt));
+	RXE_CB(skb)->pkt = new_pkt;
+	new_pkt->skb = skb;
+
 	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev))) {
 		kfree_skb(skb);
+		kfree(new_pkt);
 		return -EIO;
 	}
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 8ed4f3bcc779..cf5ac6bba59c 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -9,6 +9,20 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+void rxe_free_pkt(struct rxe_pkt_info *pkt)
+{
+	struct sk_buff *skb = PKT_TO_SKB(pkt);
+	struct rxe_qp *qp = pkt->qp;
+
+	if (qp)
+		rxe_drop_ref(qp);
+
+	ib_device_put(&pkt->rxe->ib_dev);
+
+	kfree_skb(skb);
+	kfree(pkt);
+}
+
 /* check that QP matches packet opcode type and is in a valid state */
 static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 			    struct rxe_qp *qp)
@@ -279,14 +293,22 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 			cskb = skb_clone(skb, GFP_ATOMIC);
 			if (unlikely(!cskb))
-				continue;
+				break;
+
+			cpkt = kzalloc(sizeof(*cpkt), GFP_ATOMIC);
+			if (unlikely(!cpkt)) {
+				kfree_skb(cskb);
+				break;
+			}
+			RXE_CB(cskb)->pkt = cpkt;
+			cpkt->skb = cskb;
 
 			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
 				kfree_skb(cskb);
+				kfree(cpkt);
 				break;
 			}
 
-			cpkt = SKB_TO_PKT(cskb);
 			cpkt->qp = qp;
 			rxe_add_ref(qp);
 			rxe_rcv_pkt(cpkt, cskb);
@@ -310,8 +332,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	 */
 
 drop:
-	kfree_skb(skb);
-	ib_device_put(&rxe->ib_dev);
+	rxe_free_pkt(SKB_TO_PKT(skb));
 }
 
 /**
@@ -396,9 +417,5 @@ void rxe_rcv(struct sk_buff *skb)
 	return;
 
 drop:
-	if (pkt->qp)
-		rxe_drop_ref(pkt->qp);
-
-	kfree_skb(skb);
-	ib_device_put(&rxe->ib_dev);
+	rxe_free_pkt(pkt);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c6a6257a299f..ac8d823eb416 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -98,11 +98,8 @@ static inline enum resp_states get_req(struct rxe_qp *qp,
 	struct sk_buff *skb;
 
 	if (qp->resp.state == QP_STATE_ERROR) {
-		while ((skb = skb_dequeue(&qp->req_pkts))) {
-			rxe_drop_ref(qp);
-			kfree_skb(skb);
-			ib_device_put(qp->ibqp.device);
-		}
+		while ((skb = skb_dequeue(&qp->req_pkts)))
+			rxe_free_pkt(SKB_TO_PKT(skb));
 
 		/* go drain recv wr queue */
 		return RESPST_CHK_RESOURCE;
@@ -1020,9 +1017,7 @@ static enum resp_states cleanup(struct rxe_qp *qp,
 
 	if (pkt) {
 		skb = skb_dequeue(&qp->req_pkts);
-		rxe_drop_ref(qp);
-		kfree_skb(skb);
-		ib_device_put(qp->ibqp.device);
+		rxe_free_pkt(SKB_TO_PKT(skb));
 	}
 
 	if (qp->resp.mr) {
@@ -1183,11 +1178,8 @@ static void rxe_drain_req_pkts(struct rxe_qp *qp, bool notify)
 	struct sk_buff *skb;
 	struct rxe_queue *q = qp->rq.queue;
 
-	while ((skb = skb_dequeue(&qp->req_pkts))) {
-		rxe_drop_ref(qp);
-		kfree_skb(skb);
-		ib_device_put(qp->ibqp.device);
-	}
+	while ((skb = skb_dequeue(&qp->req_pkts)))
+		rxe_free_pkt(SKB_TO_PKT(skb));
 
 	if (notify)
 		return;
-- 
2.30.2

