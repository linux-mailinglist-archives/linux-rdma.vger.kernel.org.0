Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B896100D7
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiJ0S4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiJ0S40 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 14:56:26 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B45245B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id g10so3366946oif.10
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eICWrQ7xHhpVUrkestzZklAvgiBj6omyV1K9w85HBQ8=;
        b=SMIUoK6NQSdXNrPeBM/d2iocEn6vEzWJCC9gxkyDeGiLaFrgXGbyiDPRUuA5J15Wi1
         +llZqBs2RMxv5mS/MTqx2qb4ISW3JtY4+AWNPZXXXnz4303TDN/856WfA+8pwmBROnKv
         UHzhz3jq/5cR28L9NdizaBCMu0t7YhopbLQBC56it2wx8T4r+fUD/7UaKnz6G7MopUMP
         ULqdAE5dZuC1jFM8hVN5j2PXQ5oL6Wju/WWuo4jT6mR/edIse14rA2XJK3KoUHKFE0+s
         8fk4fip8BWn9d+x9dQXzf2fZGu2Hu8XMAe0lZGDn7aLd9gC0kWlITRnfybnqworgHjjl
         Go8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eICWrQ7xHhpVUrkestzZklAvgiBj6omyV1K9w85HBQ8=;
        b=gKM7FVdP4grvsWw6WZPRqq+0WLZMv37uCm3UWh4KwQoK/Bbu+2D+ienrzvTa4+Cbg0
         wYFjqXJULWLgcJIZEpeop5FJs/OYk5ZB0rmNF/3Hrua68deMVy3jN3mu9yiFCn+2uBDp
         rEjancB20R1tlDrqSR4MYH38T6++8SXwK0nEzOVeaoQdaKFaAVZbK7qJkzaPMrG7oCk1
         5Fc5lOW/ww6uT0hA2KP2Ds66YtH0v8auVRmvw62YULvRJC+7YtuGorXKiltSknpXDmB7
         DmHvQTxlQJhcMGaIHBrFKwWR6an9cDw99Kw0T1sEKrcm9NN0F4cqNAin20YucllTSikx
         KxGg==
X-Gm-Message-State: ACrzQf1XrlQWVLQsKVTJiZTofaSqrjqD95gzjdavByygW6xIpY6x5F0S
        v6KqOv/dE4QblllugXotVriJon8wsUk=
X-Google-Smtp-Source: AMsMyM79ONTjgONkvIFbtnc9VeSCOG3rPIlaeGA2S9YiuTnnbz+5b1CGRxfzA8d185a1AXMvZfZ64g==
X-Received: by 2002:aca:230e:0:b0:354:b67d:aa4 with SMTP id e14-20020aca230e000000b00354b67d0aa4mr5925559oie.74.1666896984947;
        Thu, 27 Oct 2022 11:56:24 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f015-3653-e617-fa3f.res6.spectrum.com. [2603:8081:140c:1a00:f015:3653:e617:fa3f])
        by smtp.googlemail.com with ESMTPSA id f1-20020a4a8f41000000b0049602fb9b4csm732736ool.46.2022.10.27.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:56:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 12/17] RDMA/rxe: Extend rxe_icrc.c to support frags
Date:   Thu, 27 Oct 2022 13:55:06 -0500
Message-Id: <20221027185510.33808-13-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027185510.33808-1-rpearsonhpe@gmail.com>
References: <20221027185510.33808-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend the subroutines rxe_icrc_generate() and rxe_icrc_check()
to support skb frags.

This is in preparation for supporting fragmented skbs.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 65 ++++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_net.c  | 55 ++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_recv.c |  1 +
 3 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 46bb07c5c4df..5f1d24e37c36 100644
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
+__be32 rxe_icrc_payload(struct sk_buff *skb, struct rxe_pkt_info *pkt,
+			__be32 icrc, __be32 **icrcp)
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
-				payload_size(pkt) + bth_pad(pkt));
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
-				payload_size(pkt) + bth_pad(pkt));
+	icrc = rxe_icrc_payload(skb, pkt, icrc, &icrcp);
+
 	*icrcp = ~icrc;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c6d8f5c80562..395e9d7d81c3 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -134,32 +134,51 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	struct rxe_dev *rxe;
 	struct net_device *ndev = skb->dev;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	u8 opcode;
+	u8 buf[1];
+	u8 *p;
 
-	/* takes a reference on rxe->ib_dev
-	 * drop when skb is freed
-	 */
+	/* Takes a reference on rxe->ib_dev. Drop when skb is freed */
 	rxe = rxe_get_dev_from_net(ndev);
 	if (!rxe && is_vlan_dev(ndev))
 		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
 	if (!rxe)
-		goto drop;
+		goto err_drop;
 
-	if (skb_linearize(skb)) {
-		ib_device_put(&rxe->ib_dev);
-		goto drop;
+	/* Get bth opcode out of skb */
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
 
 	rxe_rcv(skb);
 
 	return 0;
-drop:
+
+err_device_put:
+	ib_device_put(&rxe->ib_dev);
+err_drop:
 	kfree_skb(skb);
 
 	return 0;
@@ -385,21 +404,32 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
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
 
 	rxe_rcv(skb);
-
 	return 0;
+
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
@@ -415,6 +445,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		goto drop;
 	}
 
+	/* skb->data points at IP header */
 	rxe_icrc_generate(skb, pkt);
 
 	if (pkt->mask & RXE_LOOPBACK_MASK)
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 434a693cd4a5..ba786e5c6266 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -329,6 +329,7 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(err))
 		goto drop;
 
+	/* skb->data points at UDP header */
 	err = rxe_icrc_check(skb, pkt);
 	if (unlikely(err))
 		goto drop;
-- 
2.34.1

