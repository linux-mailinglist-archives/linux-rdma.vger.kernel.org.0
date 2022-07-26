Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41963581A92
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jul 2022 21:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiGZT4k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiGZT4j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 15:56:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF22125A
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 12:56:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so11570797otk.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q5Dutfjcy5JoltIGybgob45r1suTwOMM72lw8AR9HOQ=;
        b=otqG2WupYXqqKkgl96BSk0n1oZuNEbW3rNE3fewoIU6MsxYj8xEtbE3Ps/+xokl1/e
         m3TiI1trOCux0KFrXAJeL4W+HqH/aMmU10VrZNd0GVwHvnxiAIvixhyx9Rt8Ep3kqGJ8
         7HXRKsDo497E+h/Ur5p6hWgYD/+lG7V7mKSErhjRpaemHxPiO2ZIlEKov+B4v91AzqT8
         6Ji1pOcfca2O1uVY8ctFCycpIQSQGRXpYGxT8srdwnVUfEYuMp78H3hVLH9sJPDjtZjp
         fD28ykzdxESEdeYg90xi6RjW8aAiAm2CDV5DS2CJXZ7vI0Hep9MIMWUVDuJswdsfUWei
         V85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q5Dutfjcy5JoltIGybgob45r1suTwOMM72lw8AR9HOQ=;
        b=nlWmNfnH4h2HEiURkial+P/apihiEufG4e1OsIpq68DE/TGiC2InnJIrZIYPsjXfQ7
         zU8tRXd5TyMpD/0rGhgCw//KlDU4RprtcEBOzPxCb2ZVZWBgbGZ0BbRf1fxQWKBHJESe
         /fM9bulLdYLeTwQv5m8n+tSZtyzP6Z//hywDLT9WYOTvOsKYO7qOBcguIn2GogSVshrs
         2eAInoktAUh0WXNyHbOCRZej5/rslU5A6gi1udQR1xS72aWxJjwcn0bnhvKRMD3BhorN
         DNBDeQBLiqbFak2bituXb7seBMdx5/2cd5LD4XTF/STwBOs3Vgc3YeOi8ZMo/Gcs8k8U
         bppg==
X-Gm-Message-State: AJIora/6qeRbUOVOFGOmulM5VtbLAg1rhYjwjn1QTYgTQmXBO47+pjxE
        XtxTFfu8e0Rq+GuAYmvfVxk=
X-Google-Smtp-Source: AGRyM1v+MvyMp7uqHDTxFRqPmCR9XwE8qnhfpixlF5388II24CK5I8zbSE8HutgW7R17NEjYTdrCdg==
X-Received: by 2002:a05:6830:310c:b0:61c:c2c2:f9c7 with SMTP id b12-20020a056830310c00b0061cc2c2f9c7mr7080318ots.61.1658865397905;
        Tue, 26 Jul 2022 12:56:37 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id t14-20020a056830082e00b0061c29a38b3bsm6565259ots.33.2022.07.26.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 12:56:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Cleanup rxe_init_packet()
Date:   Tue, 26 Jul 2022 14:56:03 -0500
Message-Id: <20220726195602.12368-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_loc.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c  | 49 +++++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c |  3 +-
 4 files changed, 23 insertions(+), 33 deletions(-)

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
index b36ec5c4d5e0..02a5d4ebb45e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -670,8 +670,9 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 	 */
 	pad = (-payload) & 0x3;
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
+	ack->paylen = paylen;
 
-	skb = rxe_init_packet(rxe, &qp->pri_av, paylen, ack);
+	skb = rxe_init_packet(rxe, &qp->pri_av, ack);
 	if (!skb)
 		return NULL;
 
-- 
2.34.1

