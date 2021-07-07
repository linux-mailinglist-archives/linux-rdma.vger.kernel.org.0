Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9283BE1BA
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhGGEEZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhGGEEX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:23 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D57FC06175F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l21so1909608oig.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/QGSkWi6Ea60yNOjwWwUJ/pZm7nv6PicqaTaANR4X4=;
        b=EqlVgZ2l5V7JZ4OApLQa7rP35jt5gPEZ0+uK1VP6YZvWnK5xAAdv/S9ne3zRsab3bG
         Hf9rI4oXbuRyQRFayDCOvKEqs6H3H7vg+rtpra6kRyUnTFt7/VDnPuqGoTD/vUg951rE
         G+4rff+RmlejXLcihokT4UYayav4BBMSASkZznMz6uBvrC8N8xBmqATTDp+hf33K8tGQ
         5rdkayFOLNwQ2HXPtjaJX2f+OrA7nPeYOS+DHqJnZqSlnrUfFr+6i4PD4gxnZNzSeEwX
         lekh2kwid9MUi6q5gk6j362vf+Ye/lIQL0jBRBWh3F8mKrMDwb5jEVFlfEtk6Qnjn6DX
         VXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/QGSkWi6Ea60yNOjwWwUJ/pZm7nv6PicqaTaANR4X4=;
        b=RwVS4Oj/Ph2QyNfISyIlcb4I/OhgZx4dQ7LufDSGirvygEFKW1fJYLjb7doEQo0iHW
         SnmcMbDBhVPz7GINAYRlfAnfs1l2U2f9F4pNjABg5DT34kgcMuJOOw4deyooJCf91c3n
         0a+i1sArqGYd9KHSnup1jjzfOibcJMmzdFxqVXTMrV7E8x8qkX3imR8JA4xdGyvtDcqQ
         VyBDcOSjiRTY4G9jnPxnUW4hzlHVNJFic4wIaG17LNAWkD2EAISSQgtOgm6MLxLu2iD5
         lQAkhtlKY+IM6gpiTvswcwipOPlQKK3XJ+VEj8aB4Ir68m9Hjfb3G5BVZmDHsl6QUcjv
         DMQw==
X-Gm-Message-State: AOAM530QiCJN17/H0hJknziDihlP4+lMFwpd2FTRhDPW6ywDhzbgWcBA
        Tqbak6JHZsaD7V3vKPtEQ7A=
X-Google-Smtp-Source: ABdhPJyjloEkicBaI+WdWGftcOh6ReMCXS98H1JUgMrEDMJt4kn9+ArD5QXCWG6/AElcrt8ApFrm8Q==
X-Received: by 2002:aca:1711:: with SMTP id j17mr666390oii.69.1625630503518;
        Tue, 06 Jul 2021 21:01:43 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id l9sm979732oii.20.2021.07.06.21.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 3/9] RDMA/rxe: Fixup rxe_send and rxe_loopback
Date:   Tue,  6 Jul 2021 23:00:35 -0500
Message-Id: <20210707040040.15434-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixup rxe_send() and rxe_loopback() in rxe_net.c to have the same
calling sequence. This patch makes them static and have the same
parameter list and return value.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h |  2 --
 drivers/infiniband/sw/rxe/rxe_net.c | 28 ++++++++++++++--------------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 409d10f20948..5fc9abea88ca 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -99,8 +99,6 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
 void rxe_mw_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_net.c */
-void rxe_loopback(struct sk_buff *skb);
-int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c93a379a1b28..beaaec2e5a17 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -373,7 +373,7 @@ static void rxe_skb_tx_dtor(struct sk_buff *skb)
 	rxe_drop_ref(qp);
 }
 
-int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	int err;
 
@@ -406,19 +406,23 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 /* fix up a send packet to match the packets
  * received from UDP before looping them back
  */
-void rxe_loopback(struct sk_buff *skb)
+static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
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
-	else
-		rxe_rcv(skb);
+		return -EIO;
+	}
+
+	rxe_rcv(skb);
+
+	return 0;
 }
 
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
@@ -434,14 +438,10 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto drop;
 	}
 
-	if (pkt->mask & RXE_LOOPBACK_MASK) {
-		memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
-		rxe_loopback(skb);
-		err = 0;
-	} else {
-		err = rxe_send(pkt, skb);
-	}
-
+	if (pkt->mask & RXE_LOOPBACK_MASK)
+		err = rxe_loopback(skb, pkt);
+	else
+		err = rxe_send(skb, pkt);
 	if (err) {
 		rxe->xmit_errors++;
 		rxe_counter_inc(rxe, RXE_CNT_SEND_ERR);
-- 
2.30.2

