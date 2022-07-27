Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D1582D9A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbiG0RAp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241449AbiG0Q7p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 12:59:45 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50EA5721F
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:37:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u9so21403220oiv.12
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKZh/72/EAGXYXpTbXQSYcyQa5mEwbwfvxw2U+ttGR8=;
        b=K9qo/OdZI3Nk+vFMLiJRSBSca5qDeME1b7GVubFbuCxIr9J0wK2MPvcpyADhAVVSvn
         2YS99KLcxSCym9xFIxbF8S+A+wZOuGiw2BMvK6H4kKgcnn7LtKLEYB21x7M0aKwkIEKq
         Inz/rDbmIA4XbdD8uXhTZoziUAH1fNHHN+0kqR5Q+FSCRP12BVJ/ccVxPaxeFIkfKPcr
         xII+A1oWrJ3xeD4vAFniz8LnWb3UF/GctxhgOzmsP6ZrdT7P5TFpifEHtXUORBBrtRJ2
         B6sxaFB7Rg4kOU1oGqv1aOebDuFJS26pTIKB/Mr0+1inrAbEHl3+gPVc7zI7B6dGoiPf
         X0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKZh/72/EAGXYXpTbXQSYcyQa5mEwbwfvxw2U+ttGR8=;
        b=Jbl3SNHVa8N8hjROhRxTWgyqbRswdZityRNlmn5pQAriDrfblhF7aw5kJvnPPz/ily
         W5tWv9MtC/yZF733YW9/MYDvcMc1Aaq0sHVGdIf9TsItPSn5FdbToAFYHuWEY7WRVxs+
         VOK9yw8mH9otFzFnadtz2DAlOvlpgDTJRA/2YhcN0Uxs7oBHDp3ScLlHYzwZvX9qfmun
         RKZ/rwqqztWTjpQTSkrgByxb89jxwJIxVIeJkY3AzDJ/j5kNXpvpi3PSSQXCKQJHpQCh
         Fgu4kiIQTFVzHFVbU/ZuG05526Bpawjrk/va4NS3x/lq7BtShHUFa5V5R+yPlCz3Ivi1
         y9Cw==
X-Gm-Message-State: AJIora8VhXCDqrqnEq5uxbi4jPIXfGUz04XoXk2EI50x2/J9GKafAoNq
        2Nt2AOOAFQK8YGcfaftqW8M=
X-Google-Smtp-Source: AGRyM1uEGyWSH2Yu87/tPzhzPKBrEC/ocSZUsfuGsxBTImf9FNm5uYBwg/o1ev7OxBXP3cak1WSrBw==
X-Received: by 2002:a05:6808:114b:b0:33a:6cc9:fa45 with SMTP id u11-20020a056808114b00b0033a6cc9fa45mr2288197oiu.18.1658939856677;
        Wed, 27 Jul 2022 09:37:36 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id l9-20020a056870204900b0010d2da48d2csm9110775oad.31.2022.07.27.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:37:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, haris.iqbal@ionos.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Cleanup rxe_init_packet()
Date:   Wed, 27 Jul 2022 11:36:52 -0500
Message-Id: <20220727163651.6967-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently rxe_init_packet() recomputes ndev from the address
vector but struct rxe_dev already holds a reference to ndev.

Cleanup rxe_init_packet to use the value of ndev in rxe and drop
an unneeded parameter paylen since it is already carried in the
packet info struct.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Per Haris Iqbal remove redundant 'ack->paylen = paylen'

 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 49 +++++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  4 +--
 4 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index f9af30f582c6..7f98d296bc0d 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -93,7 +93,7 @@ void rxe_mw_cleanup(struct rxe_pool_elem *elem);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt);
+				struct rxe_pkt_info *pkt);
 int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 		struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c53f4529f098..4a091f236dde 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -443,18 +443,22 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	return err;
 }
 
+/**
+ * rxe_init_packet - allocate and initialize a new skb
+ * @rxe: rxe device
+ * @av: remote address vector
+ * @pkt: packet info
+ *
+ * Returns: an skb on success else NULL
+ */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
-				int paylen, struct rxe_pkt_info *pkt)
+				struct rxe_pkt_info *pkt)
 {
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
-	struct net_device *ndev;
-	const struct ib_gid_attr *attr;
+	struct net_device *ndev = rxe->ndev;
 	const int port_num = 1;
-
-	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
-	if (IS_ERR(attr))
-		return NULL;
+	int skb_size;
 
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
@@ -463,26 +467,13 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct ipv6hdr);
 
-	rcu_read_lock();
-	ndev = rdma_read_gid_attr_ndev_rcu(attr);
-	if (IS_ERR(ndev)) {
-		rcu_read_unlock();
-		goto out;
-	}
-	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
-			GFP_ATOMIC);
-
-	if (unlikely(!skb)) {
-		rcu_read_unlock();
-		goto out;
-	}
-
-	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
-
-	/* FIXME: hold reference to this netdev until life of this skb. */
-	skb->dev	= ndev;
-	rcu_read_unlock();
+	skb_size = LL_RESERVED_SPACE(ndev) + hdr_len + pkt->paylen;
+	skb = alloc_skb(skb_size, GFP_ATOMIC);
+	if (unlikely(!skb))
+		return NULL;
 
+	skb_reserve(skb, LL_RESERVED_SPACE(ndev) + hdr_len);
+	skb->dev = ndev;
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		skb->protocol = htons(ETH_P_IP);
 	else
@@ -490,11 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	pkt->rxe	= rxe;
 	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put(skb, paylen);
-	pkt->mask	|= RXE_GRH_MASK;
+	pkt->hdr	= skb_put(skb, pkt->paylen);
+	pkt->mask      |= RXE_GRH_MASK;
 
-out:
-	rdma_put_gid_attr(attr);
 	return skb;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 49e8f54db6f5..e72db960d7ea 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -397,7 +397,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	pkt->paylen = paylen;
 
 	/* init skb */
-	skb = rxe_init_packet(rxe, av, paylen, pkt);
+	skb = rxe_init_packet(rxe, av, pkt);
 	if (unlikely(!skb))
 		return NULL;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index b36ec5c4d5e0..19d0537278f6 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -670,15 +670,15 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	 */
 	pad = (-payload) & 0x3;
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
+	ack->paylen = paylen;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
 	if (!skb)
 		return NULL;
 
 	ack->qp = qp;
 	ack->opcode = opcode;
 	ack->mask = rxe_opcode[opcode].mask;
-	ack->paylen = paylen;
 	ack->psn = psn;
 
 	bth_init(ack, opcode, 0, 0, pad, IB_DEFAULT_PKEY_FULL,
-- 
2.34.1

