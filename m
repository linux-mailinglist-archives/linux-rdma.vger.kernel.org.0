Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5CB3B792A
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhF2UQw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhF2UQw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:16:52 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234FC061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id bc18-20020a0568201692b029024c6dbc2073so2936008oob.8
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FURDBWmdNtUGjZ1Z7RMoVulI+31O7fZVecU66GbrFns=;
        b=GsmISUtCxIG9cv5gaLBzityGewszWch3Byq3m5Mo3wpG+dD5bj5Sg7sETQ6WBFwTw8
         pnC7lrAvYFz+OwNlOEey3NpGluUKRpMFjQFAN1D3iFcvvqLKtfLsBnQsIDvqtn7k+z2I
         L0eo1AdCIkwjUA/7HQCGqL1PEDNwKTZOquzFGiSnj8zOc0mNaYwRitdW0iZaslQ2GOiU
         ROJjv4c4TIpvC3fMwnNRqjMAbLO4d0koGmO9H7MzAw8VwT0sixBVCaY/uviT5crawJmw
         jveqzfC92XfU7NjtgWVjAvkxmpTJDUEx+O6fxWddRyZo0d9orTcAewiJSeeDPiA0/VFR
         YGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FURDBWmdNtUGjZ1Z7RMoVulI+31O7fZVecU66GbrFns=;
        b=ix5/45dwEHoZQPtl+bhfeA4pwtV7S/DCkYDxKY0k5zZ1QxMIzaMQz9UevqPvzmDqnY
         dck6AgCTSAVhn8unuNTIujbzqZ+/Avc85yE3u1BYzOfjrCWIZe19iPg8drneUDRuyWJW
         mlW5JqD8lYa41EHeO09wEBacrelP3oiqVgUilJ68HVhaqiWVcjFitN7uh3bnP7NdYs9r
         1vDQxuvPGQxDuMtmMFhS8R54Xmm+bt6d/aNLXRTq4N8QUGYs7GZKak9HVRyu4uxwNdSN
         91ciwbnO/dNWK1R0R9HFuWzp3hcyMAJ2glFXvqbwEYALfHStUjgpDRaXGuWPn273Ysnl
         +30g==
X-Gm-Message-State: AOAM530Ra7In6qGJjLvSH7J2Z1VRvJA1R60qVsrNb3tsMweTACfnnPY0
        8A9KeG68EBK8DMu6JEDX4W8=
X-Google-Smtp-Source: ABdhPJxzytezm1GDxkwTkU2oQxNntpAtGWGqusJCHnqs1h3gQLTlmw+4E33YxLcqSWkmlVPC8BpS+A==
X-Received: by 2002:a4a:b443:: with SMTP id h3mr5551719ooo.24.1624997663460;
        Tue, 29 Jun 2021 13:14:23 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id z6sm4103618oiz.39.2021.06.29.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:14:23 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/5] RDMA/rxe: Move rxe_xmit_packet to a subroutine
Date:   Tue, 29 Jun 2021 15:14:07 -0500
Message-Id: <20210629201412.28306-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629201412.28306-1-rpearsonhpe@gmail.com>
References: <20210629201412.28306-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_xmit_packet() was an overlong inline subroutine. Move it
into rxe_net.c as an ordinary subroutine. Change rxe_loopback() and
rxe_send() to static subroutines since they are no longer shared.
Allow rxe_loopback to return an error.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 47 ++-----------------------
 drivers/infiniband/sw/rxe/rxe_net.c | 54 ++++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 6689e51647db..3468a61efe4e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -99,11 +99,11 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
-void rxe_loopback(struct sk_buff *skb);
-int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
+int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
@@ -206,47 +206,4 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
 }
 
-static inline int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
-				  struct sk_buff *skb)
-{
-	int err;
-	int is_request = pkt->mask & RXE_REQ_MASK;
-	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
-
-	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
-	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
-		goto drop;
-	}
-
-	if (pkt->mask & RXE_LOOPBACK_MASK) {
-		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
-		rxe_loopback(skb);
-		err = 0;
-	} else {
-		err = rxe_send(pkt, skb);
-	}
-
-	if (err) {
-		rxe->xmit_errors++;
-		rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
-		return err;
-	}
-
-	if ((qp_type(qp) != IB_QPT_RC) &&
-	    (pkt->mask & RXE_END_MASK)) {
-		pkt->wqe->state = wqe_state_done;
-		rxe_run_task(&qp->comp.task, 1);
-	}
-
-	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
-	goto done;
-
-drop:
-	kfree_skb(skb);
-	err = 0;
-done:
-	return err;
-}
-
 #endif /* RXE_LOC_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index dec92928a1cd..6968c247bcf7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -373,7 +373,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 	rxe_drop_ref(qp);
 }
 
-int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	int err;
 
@@ -406,19 +406,63 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 /* fix up a send packet to match the packets
  * received from UDP before looping them back
  */
-void rxe_loopback(struct sk_buff *skb)
+static int rxe_loopback(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
 
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
 
-	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev)))
+	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev))) {
 		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rxe_rcv(skb);
+
+	return 0;
+}
+
+int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+		  struct sk_buff *skb)
+{
+	int is_request = pkt->mask & RXE_REQ_MASK;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+	int err;
+
+	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
+	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
+		pr_info("Packet dropped. QP is not in ready state\n");
+		goto drop;
+	}
+
+	if (pkt->mask & RXE_LOOPBACK_MASK)
+		err = rxe_loopback(pkt, skb);
 	else
-		rxe_rcv(skb);
+		err = rxe_send(pkt, skb);
+
+	if (err) {
+		rxe->xmit_errors++;
+		rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
+		return err;
+	}
+
+	if ((qp_type(qp) != IB_QPT_RC) &&
+	    (pkt->mask & RXE_END_MASK)) {
+		pkt->wqe->state = wqe_state_done;
+		rxe_run_task(&qp->comp.task, 1);
+	}
+
+	rxe_counter_inc(rxe, RXE_CNT_SENT_PKTS);
+	goto done;
+
+drop:
+	kfree_skb(skb);
+	err = 0;
+done:
+	return err;
 }
 
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-- 
2.30.2

