Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC54765CC9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjG0UCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjG0UCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 16:02:21 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8FC2D45
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9f3b57c4fso1483035a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690488136; x=1691092936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oq7+WVZco7GNhADjNeQjWPDPXgE7gQpJ1x+ADfhTl7A=;
        b=KRd6nivu7qI9IwOq8hRt8zFxkjjAjN0UP0vTzPOCRdWwuZQXsGnE0m9L4GaKitpRBb
         oc5W1ptEPuJseh9yU+Gn2onKgc2OiB6AtEwLxD8W4pUuU0rBNOpPOG7clM/Ff49qCsmi
         FI6uUGbcAa4QR2Zyza7Y+XlrdRs5pON7AUdHVORrCq8HDwAdqfY7r/Xt6z7ZFUeGSubH
         Ba9ZJJAyabLrIWVjZfmK1URQ3YFiKnUq9ZlVznet8uR0iwZWYYR0kZpjWp9sRBtl0t5A
         2bCRmehUQzCAIUsG3uxS+6ZGi6KyatOLDTdKlzOXHPZwOzUI6E3QZEFjgGvC8WADULcO
         5EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690488136; x=1691092936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oq7+WVZco7GNhADjNeQjWPDPXgE7gQpJ1x+ADfhTl7A=;
        b=SBm1pllOh6iuVaim/wXwW0lwDFoEn+B5/VDT5bOw+W5/MIbqYQh6XbQnzZ9Onphxdx
         mvBK7DJ/cPo4LjBSRHU13/SDFUzepL9i7kl6FrMPkMwjFr5ZviLyedPGXyY+/xdYgczP
         0aPM3+GFwADBLqYc98S3tmvWKPv8nVwymwpuvc0zAIH/PDERDlt2l95wA01L7lHWG3YF
         kcywcWM+sxhsqLhXEzN+0jSY9HziFguKLRqWsQjc52EvSQZBCheeleTJ0w3QEEbjK/7r
         lEfpdbvr996sS3YstQT+FDIsiklGt4ko/GAYeM/dz6Ks4o5iR4oA5RpGjD1QDQjgsxSv
         wAdg==
X-Gm-Message-State: ABy/qLbedrv82IS7OGIfs2IBm62C9kHXHx5EyUdu50UDl6zVaFPWqT9c
        0KLJwVT51rXaqcPZYV3Yj252NfXq1Gs=
X-Google-Smtp-Source: APBJJlHtRfOQPKL+heq7+ro5xVaY1rm9BIGMsC6CULQ15sqY1AWaO0MeY7SsreD47Bhq6cmAUgjjcA==
X-Received: by 2002:a9d:4d94:0:b0:6b9:a186:8115 with SMTP id u20-20020a9d4d94000000b006b9a1868115mr299152otk.18.1690488136717;
        Thu, 27 Jul 2023 13:02:16 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-a360-d7ee-0b00-a1d3.res6.spectrum.com. [2603:8081:140c:1a00:a360:d7ee:b00:a1d3])
        by smtp.gmail.com with ESMTPSA id m3-20020a9d73c3000000b006b9acf5ebc0sm938142otk.76.2023.07.27.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 13:02:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 05/10] RDMA/rxe: Extend rxe_icrc.c to support frags
Date:   Thu, 27 Jul 2023 15:01:24 -0500
Message-Id: <20230727200128.65947-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
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

Extend the subroutines rxe_icrc_generate() and rxe_icrc_check()
to support skb frags.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 65 ++++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_net.c  | 51 +++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_recv.c |  1 +
 3 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index c9aa0995e900..393391863350 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -63,7 +63,7 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
 
 /**
  * rxe_icrc_hdr() - Compute the partial ICRC for the network and transport
- *		  headers of a packet.
+ *		    headers of a packet.
  * @skb: packet buffer
  * @pkt: packet information
  *
@@ -129,6 +129,56 @@ static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	return crc;
 }
 
+/**
+ * rxe_icrc_payload() - Compute the ICRC for a packet payload and also
+ *			compute the address of the icrc in the packet.
+ * @skb: packet buffer
+ * @pkt: packet information
+ * @icrc: current icrc i.e. including headers
+ * @icrcp: returned pointer to icrc in skb
+ *
+ * Return: 0 if the values match else an error
+ */
+static __be32 rxe_icrc_payload(struct sk_buff *skb, struct rxe_pkt_info *pkt,
+			       __be32 icrc, __be32 **icrcp)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	skb_frag_t *frag;
+	u8 *addr;
+	int hdr_len;
+	int len;
+	int i;
+
+	/* handle any payload left in the linear buffer */
+	hdr_len = rxe_opcode[pkt->opcode].length;
+	addr = pkt->hdr + hdr_len;
+	len = skb_tail_pointer(skb) - skb_transport_header(skb)
+		- sizeof(struct udphdr) - hdr_len;
+	if (!shinfo->nr_frags) {
+		len -= RXE_ICRC_SIZE;
+		*icrcp = (__be32 *)(addr + len);
+	}
+	if (len > 0)
+		icrc = rxe_crc32(pkt->rxe, icrc, payload_addr(pkt), len);
+	WARN_ON(len < 0);
+
+	/* handle any payload in frags */
+	for (i = 0; i < shinfo->nr_frags; i++) {
+		frag = &shinfo->frags[i];
+		addr = page_to_virt(frag->bv_page) + frag->bv_offset;
+		len = frag->bv_len;
+		if (i == shinfo->nr_frags - 1) {
+			len -= RXE_ICRC_SIZE;
+			*icrcp = (__be32 *)(addr + len);
+		}
+		if (len > 0)
+			icrc = rxe_crc32(pkt->rxe, icrc, addr, len);
+		WARN_ON(len < 0);
+	}
+
+	return icrc;
+}
+
 /**
  * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
  *		      delivered in the packet.
@@ -143,13 +193,11 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	__be32 pkt_icrc;
 	__be32 icrc;
 
-	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	pkt_icrc = *icrcp;
-
 	icrc = rxe_icrc_hdr(skb, pkt);
-	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + pkt->pad);
+	icrc = rxe_icrc_payload(skb, pkt, icrc, &icrcp);
+
 	icrc = ~icrc;
+	pkt_icrc = *icrcp;
 
 	if (unlikely(icrc != pkt_icrc))
 		return -EINVAL;
@@ -167,9 +215,8 @@ void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	__be32 *icrcp;
 	__be32 icrc;
 
-	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
 	icrc = rxe_icrc_hdr(skb, pkt);
-	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + pkt->pad);
+	icrc = rxe_icrc_payload(skb, pkt, icrc, &icrcp);
+
 	*icrcp = ~icrc;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c44ef39010f1..c43f9dd3ae6e 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -148,33 +148,53 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	struct udphdr *udph;
 	struct rxe_dev *rxe;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	u8 opcode;
+	u8 buf[1];
+	u8 *p;
 
 	/* takes a reference on rxe->ib_dev
 	 * drop when skb is freed
 	 */
 	rxe = get_rxe_from_skb(skb);
 	if (!rxe)
-		goto drop;
+		goto err_drop;
 
-	if (skb_linearize(skb)) {
-		ib_device_put(&rxe->ib_dev);
-		goto drop;
+	/* Get bth opcode out of skb, it may be in a fragment */
+	p = skb_header_pointer(skb, sizeof(struct udphdr), 1, buf);
+	if (!p)
+		goto err_device_put;
+	opcode = *p;
+
+	/* If using fragmented skbs make sure roce headers
+	 * are in linear buffer else make skb linear
+	 */
+	if (rxe_use_sg && skb_is_nonlinear(skb)) {
+		int delta = rxe_opcode[opcode].length -
+			(skb_headlen(skb) - sizeof(struct udphdr));
+
+		if (delta > 0 && !__pskb_pull_tail(skb, delta))
+			goto err_device_put;
+	} else {
+		if (skb_linearize(skb))
+			goto err_device_put;
 	}
 
 	udph = udp_hdr(skb);
 	pkt->rxe = rxe;
 	pkt->port_num = 1;
 	pkt->hdr = (u8 *)(udph + 1);
-	pkt->mask = RXE_GRH_MASK;
+	pkt->mask = rxe_opcode[opcode].mask | RXE_GRH_MASK;
 	pkt->paylen = be16_to_cpu(udph->len) - sizeof(*udph);
 
-	/* remove udp header */
 	skb_pull(skb, sizeof(struct udphdr));
 
 	rxe_rcv(skb);
 
 	return 0;
-drop:
+
+err_device_put:
+	ib_device_put(&rxe->ib_dev);
+err_drop:
 	kfree_skb(skb);
 
 	return 0;
@@ -446,24 +466,35 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  */
 static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
-	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
+	struct rxe_pkt_info *newpkt;
+	int err;
 
+	/* make loopback line up with rxe_udp_encap_recv */
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
+	skb_reset_transport_header(skb);
+
+	newpkt = SKB_TO_PKT(skb);
+	memcpy(newpkt, pkt, sizeof(*newpkt));
+	newpkt->hdr = skb_transport_header(skb) + sizeof(struct udphdr);
 
 	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev))) {
 		kfree_skb(skb);
-		return -EIO;
+		err = -EINVAL;
+		goto drop;
 	}
 
 	/* remove udp header */
 	skb_pull(skb, sizeof(struct udphdr));
 
 	rxe_rcv(skb);
-
 	return 0;
+
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f912a913f89a..940197199252 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -338,6 +338,7 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
+	/* skb->data points at UDP header */
 	err = rxe_icrc_check(skb, pkt);
 	if (unlikely(err))
 		goto drop;
-- 
2.39.2

