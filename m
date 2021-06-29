Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B894D3B7929
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbhF2UQv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhF2UQu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:16:50 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37572C061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:23 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 11so217191oid.3
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQfPuel+Ld/km4ObsU2/PoY2G39293TVnNTnnhYw84s=;
        b=n6EucDkJJrf7GKe5GCntDi8OjSiKnPV0Dl4EQnJ+NOEYm7fvocjsvcdn8vKXXzsrJQ
         b0foHRxr43086FD7hI/vmrezIyVI9PKpvE3BS5AfcW6wxVBDhKu4qXZAA3SoQQvdalpC
         n+Hdx2tB7JpRRKvFQtsnYAgcQZP6U+lf18UrX4pXb17Hb9D9qdxQkU34BPKAi2gRg3fR
         u6Zj+l7hhHdxvdZhpeWoeQ7QOV+ZqToBAWYwAdD6IN/511YNT3UgiQtE03RfD8A/Ykpm
         W9Le69WmtBrUc8HFVom1Qw08R6DtSiJofvAKHEUNUNQfvdEkyDyCPBFuNEfI4ygMwYEs
         K8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQfPuel+Ld/km4ObsU2/PoY2G39293TVnNTnnhYw84s=;
        b=jRNbA67ijSy/HpEzAtI2/LPm2rH664tSB9SH+nveDi5yvjYUvzYT7ZOqALC6Zvf2O4
         Owxu2NuUaWcx9EDzHJEGkHLgb36PaEJLz7I30pQHoHhjinMx3bJYfAwCE2Rxs2pW1rE2
         p7LNLQuOrrfsmF5w1D9dxcACdqeRFdLsrRtJqU7hrFThS3hGyoMkTKznVYRU4nnv8Bjy
         W3lAPVlwmO/SsLhxF2kz3I8eBNVeagq68iWWj4dcc5I79MJwSdMrtChZ2xlzHZhb0fTR
         NsjHPyoUjJOKqwFD9R7MlY0aOl0mGJqsZTbuOgHDXDeshIuYH8gt88UG6YNSOULvOCsR
         p4zg==
X-Gm-Message-State: AOAM5310G342MNnEuzC5oQH86R8XF/fGxjHdHhn8O0mFPkMR3owUlREl
        Zn2iHyahiP0PeRDn6eKI0L4=
X-Google-Smtp-Source: ABdhPJzZoaiC1qbsP5g90zK6KrVEYXV5Pe7MOMtnWVqAko2myvHVNLK4fdDJGuEVzJ+6zr2dspSVCg==
X-Received: by 2002:aca:ba06:: with SMTP id k6mr23006298oif.70.1624997662623;
        Tue, 29 Jun 2021 13:14:22 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id q206sm1562504oic.20.2021.06.29.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:14:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/5] RDMA/rxe: Move ICRC checking to a subroutine
Date:   Tue, 29 Jun 2021 15:14:06 -0500
Message-Id: <20210629201412.28306-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629201412.28306-1-rpearsonhpe@gmail.com>
References: <20210629201412.28306-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move the code in rxe_recv that checks the ICRC on incoming packets to a
subroutine rxe_check_icrc() and move it to rxe_icrc.c.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 38 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 ++
 drivers/infiniband/sw/rxe/rxe_recv.c | 23 ++---------------
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 66b2aad54bb7..5193dfa94a75 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -67,3 +67,41 @@ u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 			rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
 	return crc;
 }
+
+/**
+ * rxe_icrc_check - Compute ICRC for a packet and compare to the ICRC
+ *		    delivered in the packet.
+ * @skb: The packet buffer with packet info in skb->cb[] (receive path)
+ *
+ * Returns 0 on success or an error on failure
+ */
+int rxe_icrc_check(struct sk_buff *skb)
+{
+	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	__be32 *icrcp;
+	u32 pkt_icrc;
+	u32 icrc;
+
+	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
+	pkt_icrc = be32_to_cpu(*icrcp);
+
+	icrc = rxe_icrc_hdr(pkt, skb);
+	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
+				payload_size(pkt) + bth_pad(pkt));
+	icrc = (__force u32)cpu_to_be32(~icrc);
+
+	if (unlikely(icrc != pkt_icrc)) {
+		if (skb->protocol == htons(ETH_P_IPV6))
+			pr_warn_ratelimited("bad ICRC from %pI6c\n",
+					    &ipv6_hdr(skb)->saddr);
+		else if (skb->protocol == htons(ETH_P_IP))
+			pr_warn_ratelimited("bad ICRC from %pI4\n",
+					    &ip_hdr(skb)->saddr);
+		else
+			pr_warn_ratelimited("bad ICRC from unknown\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1ddb20855dee..6689e51647db 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -193,7 +193,9 @@ int rxe_completer(void *arg);
 int rxe_requester(void *arg);
 int rxe_responder(void *arg);
 
+/* rxe_icrc.c */
 u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb);
+int rxe_icrc_check(struct sk_buff *skb);
 
 void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 7a49e27da23a..8582b3163e2c 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -361,8 +361,6 @@ void rxe_rcv(struct sk_buff *skb)
 	int err;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	struct rxe_dev *rxe = pkt->rxe;
-	__be32 *icrcp;
-	u32 calc_icrc, pack_icrc;
 
 	if (unlikely(skb->len < RXE_BTH_BYTES))
 		goto drop;
@@ -384,26 +382,9 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
-	/* Verify ICRC */
-	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	pack_icrc = be32_to_cpu(*icrcp);
-
-	calc_icrc = rxe_icrc_hdr(pkt, skb);
-	calc_icrc = rxe_crc32(rxe, calc_icrc, (u8 *)payload_addr(pkt),
-			      payload_size(pkt) + bth_pad(pkt));
-	calc_icrc = (__force u32)cpu_to_be32(~calc_icrc);
-	if (unlikely(calc_icrc != pack_icrc)) {
-		if (skb->protocol == htons(ETH_P_IPV6))
-			pr_warn_ratelimited("bad ICRC from %pI6c\n",
-					    &ipv6_hdr(skb)->saddr);
-		else if (skb->protocol == htons(ETH_P_IP))
-			pr_warn_ratelimited("bad ICRC from %pI4\n",
-					    &ip_hdr(skb)->saddr);
-		else
-			pr_warn_ratelimited("bad ICRC from unknown\n");
-
+	err = rxe_icrc_check(skb);
+	if (unlikely(err))
 		goto drop;
-	}
 
 	rxe_counter_inc(rxe, RXE_CNT_RCVD_PKTS);
 
-- 
2.30.2

