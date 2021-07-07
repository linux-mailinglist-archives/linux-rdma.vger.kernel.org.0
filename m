Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B93BE1B9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhGGEEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGGEEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:23 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1303DC061574
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:43 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w74so1878125oiw.8
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5kzeczmKMiT45siTmiezKJGqHqWKuD9+r+3Zvf7KAs=;
        b=l6ILIkk7MGfiYbK9lmIIaWK4HlEh9BnvyBydeNmUlY2v/t8kyhGeO3trfOd303bd6t
         rG4oilYSxqXKmBZCbWgDTQzFdpEfF4YYoHtdH8bFJN9Bmx1VaTYW1R8swrb8mY2MLUSf
         uypxHPM63VQnBZQdTkXXHji6Lj8uHnWrSk8Qe4Mk+UDugsKw1o+NRe6o9e8J/DpjTZjf
         h2pLsk92qUJtiV7O1VQ7fW3cEcLIyGcnxf1avf5Jnf0coLR5M9t3DCyvf3zRV6Lg6NQ0
         nkhG1SiGp0LJzzG1fXSxgG9+XAV9FIjHDvHSEpssuX6us0xOamqkuXFn3roGSKhzB2v1
         9dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5kzeczmKMiT45siTmiezKJGqHqWKuD9+r+3Zvf7KAs=;
        b=EWGodT1Kh5XJKfk2CrjYNyq+QYc904rzUK5rwmnC7nnGbh455paqSyxws2F0EkBexB
         +BPZASAGIUFPwpAy99RR7CIIg4JkiXzd58L9kb9OB/2iSg5yBlGugEqyXDBQk1hZbobg
         QIr+DmU2wt7pvbvdvCyEYmIS9dHHikV8UeWwfLLTwjSsWRQqDFoV7JsZBJOrmDH+v2j6
         fYGU8EED/XApk33qWBQXoznecFlQa6CnTp1WV23vRvO+kZuxDRTQDbFBidC+VQfv5Cq1
         HIIEYOJetMO9BGU4aQsRSL9s/NazTRnC1qZV1QddbuaEUDGV/SNjX3jmz2XWew9Z/93O
         MmvA==
X-Gm-Message-State: AOAM531c297xsdZRpgpCd3WwPxrmBKKLt2xVpYbMQ5yQ6IDQ9s3R+MfG
        zsdgjIQnso5uarUTJKwCmkM=
X-Google-Smtp-Source: ABdhPJwJmfipPhwkUpBV06YNEJApknT8Tt9gbGJ3l57i/P4hJpmS7sxMXuHHaxAHZdr5dMq/s9kf9A==
X-Received: by 2002:aca:eb43:: with SMTP id j64mr3224641oih.101.1625630502506;
        Tue, 06 Jul 2021 21:01:42 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id 104sm1727558otm.55.2021.07.06.21.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:42 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 2/9] RDMA/rxe: Move rxe_xmit_packet to a subroutine
Date:   Tue,  6 Jul 2021 23:00:34 -0500
Message-Id: <20210707040040.15434-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_xmit_packet() was an overlong inline subroutine. This patch moves it
into rxe_net.c as an ordinary subroutine.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h | 45 ++---------------------------
 drivers/infiniband/sw/rxe/rxe_net.c | 43 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 015777e31ec9..409d10f20948 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -104,6 +104,8 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
+int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
@@ -206,47 +208,4 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
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
index dec92928a1cd..c93a379a1b28 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -421,6 +421,49 @@ void rxe_loopback(struct sk_buff *skb)
 		rxe_rcv(skb);
 }
 
+int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
+		    struct sk_buff *skb)
+{
+	int err;
+	int is_request = pkt->mask & RXE_REQ_MASK;
+	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+
+	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
+	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
+		pr_info("Packet dropped. QP is not in ready state\n");
+		goto drop;
+	}
+
+	if (pkt->mask & RXE_LOOPBACK_MASK) {
+		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
+		rxe_loopback(skb);
+		err = 0;
+	} else {
+		err = rxe_send(pkt, skb);
+	}
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
+}
+
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt)
 {
-- 
2.30.2

