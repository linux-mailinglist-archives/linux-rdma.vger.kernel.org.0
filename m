Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64CE4A5218
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiAaWKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiAaWKL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:11 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69CAC06173E
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:11 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m9so29503470oia.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Qfvp20206DcmKvuNv+j3mvuVrDOObPq3yGtKsY16FI=;
        b=cPUtk6PcjbHwBNeifn7PbzYRFzolu/hGSZN/4F/iTnSf2tZKZeMhRLMuozLjbX+d6h
         y2d3jgbXKLPgWarz6nFf1bri4UUYY5tVblG/VS6/mod/sjhd/LjKER1l3CzjjmlGtFgG
         wsKVU5DD/YB9I3ob2S7slPpRVky6QPhfJOnK3iIOwNfVnETwIKvybuBWfl4Q6HUD6spb
         91bJYOeBIMyI7Kooq5Lz8DjhwHNzzZw28qWihk1Mi5eGOjM683rHZi6rVzzJG5lGBVfA
         RSDCCrPnBq82/TYVVe92wxZet+RPOt+vB6IOr0lV3T4s+UonKsFMVnvB7R8unWxglXlT
         tY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Qfvp20206DcmKvuNv+j3mvuVrDOObPq3yGtKsY16FI=;
        b=3ywEoMJYre3ccsG/TjP5E8kxAShCHl3DMaPksVJuCTGWUfMuM6BgGW9z9DinlYfvTa
         sVr3t69Gte5SGFfLsUP3VJlmwxxVfYLODODl3qFb+tFXkmh59b+kLwSfRIuo5ajVOjkO
         zdhDJCN7kC6uenyDO/DxY928wMvL1o7msKrYmh2sbl4QCaNxXdyN6BFWF3Z/CnsN+Zkr
         oDUksJq4IH7cRI+NfNsyMSWmAfMtweFQYlZy6NY4S8WKPkImvxbOux9BowXCRPKJWTW0
         Dkpbws1hAlWeyFkmxLSN/1EM9fkFsQioDrQEibvcKcywnBd/6BPsggygfvexGxFYFLK3
         TG+g==
X-Gm-Message-State: AOAM530FFN3HSOz4T1S0mpEcyBjUNhet10XYlcwfh2M4gAbDpVeimkCQ
        FNyHd13TD1eyFAveDTOmIrk=
X-Google-Smtp-Source: ABdhPJykhveKLG1JySaJwQR3xJijJ1VvQy14dzqU5PJKB1L1lDuTzxrsq4sYuPOVda/7s3xvFXQrIA==
X-Received: by 2002:a05:6808:1491:: with SMTP id e17mr18648023oiw.123.1643667011282;
        Mon, 31 Jan 2022 14:10:11 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:10 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 09/17] RDMA/rxe: Introduce RXECB(skb)
Date:   Mon, 31 Jan 2022 16:08:42 -0600
Message-Id: <20220131220849.10170-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a #define RXECB(skb) to rxe_hdr.h as a short cut to
refer to single members of rxe_pkt_info which is stored in skb->cb
in the receive path. Use this to make some cleanups in rxe_recv.c

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h  |  3 ++
 drivers/infiniband/sw/rxe/rxe_recv.c | 55 +++++++++++++---------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..2a85d1e40e6a 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -36,6 +36,9 @@ static inline struct sk_buff *PKT_TO_SKB(struct rxe_pkt_info *pkt)
 	return container_of((void *)pkt, struct sk_buff, cb);
 }
 
+/* alternative to access a single element of rxe_pkt_info from skb */
+#define RXECB(skb) ((struct rxe_pkt_info *)((skb)->cb))
+
 /*
  * IBA header types and methods
  *
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 814a002b8911..10020103ea4a 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -107,17 +107,15 @@ static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	return -EINVAL;
 }
 
-static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
+static int check_addr(struct rxe_dev *rxe, struct sk_buff *skb,
 		      struct rxe_qp *qp)
 {
-	struct sk_buff *skb = PKT_TO_SKB(pkt);
-
 	if (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_UC)
 		goto done;
 
-	if (unlikely(pkt->port_num != qp->attr.port_num)) {
+	if (unlikely(RXECB(skb)->port_num != qp->attr.port_num)) {
 		pr_warn_ratelimited("port %d != qp port %d\n",
-				    pkt->port_num, qp->attr.port_num);
+				    RXECB(skb)->port_num, qp->attr.port_num);
 		goto err1;
 	}
 
@@ -167,8 +165,9 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	return -EINVAL;
 }
 
-static int hdr_check(struct rxe_pkt_info *pkt)
+static int hdr_check(struct sk_buff *skb)
 {
+	struct rxe_pkt_info *pkt = RXECB(skb);
 	struct rxe_dev *rxe = pkt->rxe;
 	struct rxe_port *port = &rxe->port;
 	struct rxe_qp *qp = NULL;
@@ -199,7 +198,7 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		if (unlikely(err))
 			goto err2;
 
-		err = check_addr(rxe, pkt, qp);
+		err = check_addr(rxe, skb, qp);
 		if (unlikely(err))
 			goto err2;
 
@@ -222,17 +221,19 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	return -EINVAL;
 }
 
-static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static inline void rxe_rcv_pkt(struct sk_buff *skb)
 {
-	if (pkt->mask & RXE_REQ_MASK)
-		rxe_resp_queue_pkt(pkt->qp, skb);
+	if (RXECB(skb)->mask & RXE_REQ_MASK)
+		rxe_resp_queue_pkt(RXECB(skb)->qp, skb);
 	else
-		rxe_comp_queue_pkt(pkt->qp, skb);
+		rxe_comp_queue_pkt(RXECB(skb)->qp, skb);
 }
 
-static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
+static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 {
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct sk_buff *s;
+	struct rxe_pkt_info *pkt = RXECB(skb);
+	struct rxe_dev *rxe = pkt->rxe;
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca;
 	struct rxe_qp *qp;
@@ -274,26 +275,22 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		 * the last QP in the list.
 		 */
 		if (mca->qp_list.next != &mcg->qp_list) {
-			struct sk_buff *cskb;
-			struct rxe_pkt_info *cpkt;
-
-			cskb = skb_clone(skb, GFP_ATOMIC);
-			if (unlikely(!cskb))
+			s = skb_clone(skb, GFP_ATOMIC);
+			if (unlikely(!s))
 				continue;
 
 			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
-				kfree_skb(cskb);
+				kfree_skb(s);
 				break;
 			}
 
-			cpkt = SKB_TO_PKT(cskb);
-			cpkt->qp = qp;
+			RXECB(s)->qp = qp;
 			rxe_add_ref(qp);
-			rxe_rcv_pkt(cpkt, cskb);
+			rxe_rcv_pkt(s);
 		} else {
-			pkt->qp = qp;
+			RXECB(skb)->qp = qp;
 			rxe_add_ref(qp);
-			rxe_rcv_pkt(pkt, skb);
+			rxe_rcv_pkt(skb);
 			skb = NULL;	/* mark consumed */
 		}
 	}
@@ -326,7 +323,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
  */
 static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 {
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct rxe_pkt_info *pkt = RXECB(skb);
 	const struct ib_gid_attr *gid_attr;
 	union ib_gid dgid;
 	union ib_gid *pdgid;
@@ -359,7 +356,7 @@ static int rxe_chk_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
 void rxe_rcv(struct sk_buff *skb)
 {
 	int err;
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct rxe_pkt_info *pkt = RXECB(skb);
 	struct rxe_dev *rxe = pkt->rxe;
 
 	if (unlikely(skb->len < RXE_BTH_BYTES))
@@ -378,7 +375,7 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(skb->len < header_size(pkt)))
 		goto drop;
 
-	err = hdr_check(pkt);
+	err = hdr_check(skb);
 	if (unlikely(err))
 		goto drop;
 
@@ -389,9 +386,9 @@ void rxe_rcv(struct sk_buff *skb)
 	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
 
 	if (unlikely(bth_qpn(pkt) == IB_MULTICAST_QPN))
-		rxe_rcv_mcast_pkt(rxe, skb);
+		rxe_rcv_mcast_pkt(skb);
 	else
-		rxe_rcv_pkt(pkt, skb);
+		rxe_rcv_pkt(skb);
 
 	return;
 
-- 
2.32.0

