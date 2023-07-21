Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C375D5F9
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGUUvM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGUUvL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:11 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4311B30E2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:10 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-563439ea4a2so1503066eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972669; x=1690577469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab5HfWQqqxPkl4GvltNoLygUb3ZXkv4d8gCaU1bGBsQ=;
        b=YZPXi5egj7X0sgjP4sHOeKcFh5bM9spTAGMDfhJjL5rtmoKsFgouPLBqJAtp1357L+
         PvnOgh2HvVVa83YPoNEZbGieoUGUEss5stWnFZ9Z5tiWaI1MlMILEZ0yrjSHh6T8d0Lk
         /a30ZMqb3mcjZ8aMsZX/5lTZ9otlfbS71BJdLxPJNO3+Evqr8QFcyr5eT7EDoRb9Ny2J
         MTMH++p3gE7qNNRQEtCF/Fx0KbmnOP3yC2HDFXRGoNAVDUKYMPBGM5kX/YNNhm1bP3EM
         JYXjTdf9EW3uCf/YKCFzxWHj1323b9BxP4ddUlLoF5nZS/s0SA/FM2KEYKddR5PxhWtN
         SIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972669; x=1690577469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab5HfWQqqxPkl4GvltNoLygUb3ZXkv4d8gCaU1bGBsQ=;
        b=Gq7kvN4b6U5OZ1ERVX1JA5UpjoZwi199wbCd6G+ZH3Va85BUcM04N11O9tGu9txNya
         RNH13JAABDcSMfz1jOBCZ/qsYF5zVtyFRruKvarx6l/V1wsuw/uSvSKIROZVfjD2UoA6
         FpEuVg91lh02yTRB6m29h0gNBTsXFLyJoHUQEh+gUtzKX7sVCcjRZi6W5vAsjwH4Jbhl
         o0y98BcLwORLbVa67LeXzOOFNUSexL2fLBGJExviAhxyZ2sMsJ+U1hx8bNSCWhwRz0tT
         fBd2Dtq/73GGDb4WXiBYxg4YqbGyWbI9HbpcCmu8YdUXu2Ri/6+2xjSNGp5EmVluvMQp
         ewgg==
X-Gm-Message-State: ABy/qLZnryBIAwiaW3mIqFmBEGpi1WuEwDPJPcFz1UpzOgekUFfIiVSL
        62CnrYleAZ7j5dvSILYXGLY=
X-Google-Smtp-Source: APBJJlFIMFxMKhEDOPYe56XzjfBvmq+Zcp4tmsgvXAMqg2DULJOZHfcHblQbbcpuHio9SesCb9K8ug==
X-Received: by 2002:aca:2212:0:b0:3a3:7e62:fca2 with SMTP id b18-20020aca2212000000b003a37e62fca2mr3494771oic.0.1689972669420;
        Fri, 21 Jul 2023 13:51:09 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Date:   Fri, 21 Jul 2023 15:50:17 -0500
Message-Id: <20230721205021.5394-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In cable pull testing some NICs can hold a send packet long enough
to allow ulp protocol stacks to destroy the qp and the cleanup
routines to timeout waiting for all qp references to be released.
When the NIC driver finally frees the SKB the qp pointer is no longer
valid and causes a seg fault in rxe_skb_tx_dtor().

This patch passes the qp index instead of the qp to the skb destructor
callback function. The call back is required to lookup the qp from the
index and if it has been destroyed the lookup will return NULL and the
qp will not be referenced avoiding the seg fault.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 87 ++++++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_qp.c  |  1 -
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cd59666158b1..10e4a752ff7c 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -131,19 +131,28 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 	return dst;
 }
 
+static struct rxe_dev *get_rxe_from_skb(struct sk_buff *skb)
+{
+	struct rxe_dev *rxe;
+	struct net_device *ndev = skb->dev;
+
+	rxe = rxe_get_dev_from_net(ndev);
+	if (!rxe && is_vlan_dev(ndev))
+		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
+
+	return rxe;
+}
+
 static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct udphdr *udph;
 	struct rxe_dev *rxe;
-	struct net_device *ndev = skb->dev;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 
 	/* takes a reference on rxe->ib_dev
 	 * drop when skb is freed
 	 */
-	rxe = rxe_get_dev_from_net(ndev);
-	if (!rxe && is_vlan_dev(ndev))
-		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
+	rxe = get_rxe_from_skb(skb);
 	if (!rxe)
 		goto drop;
 
@@ -345,46 +354,84 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
-	struct sock *sk = skb->sk;
-	struct rxe_qp *qp = sk->sk_user_data;
-	int skb_out = atomic_dec_return(&qp->skb_out);
+	struct rxe_dev *rxe;
+	unsigned int index;
+	struct rxe_qp *qp;
+	int skb_out;
+
+	/* takes a ref on ib device if success */
+	rxe = get_rxe_from_skb(skb);
+	if (!rxe)
+		goto out;
+
+	/* recover source qp index from sk->sk_user_data
+	 * free the reference taken in rxe_send
+	 */
+	index = (int)(uintptr_t)skb->sk->sk_user_data;
+	sock_put(skb->sk);
 
+	/* lookup qp from index, takes a ref on success */
+	qp = rxe_pool_get_index(&rxe->qp_pool, index);
+	if (!qp)
+		goto out_put_ibdev;
+
+	skb_out = atomic_dec_return(&qp->skb_out);
 	if (unlikely(qp->need_req_skb &&
 		     skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
 		rxe_sched_task(&qp->req.task);
 
 	rxe_put(qp);
+out_put_ibdev:
+	ib_device_put(&rxe->ib_dev);
+out:
+	return;
 }
 
 static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
+	struct rxe_qp *qp = pkt->qp;
+	struct sock *sk;
 	int err;
 
-	skb->destructor = rxe_skb_tx_dtor;
-	skb->sk = pkt->qp->sk->sk;
+	/* qp can be destroyed while this packet is waiting on
+	 * the tx queue. So need to protect sk.
+	 */
+	sk = qp->sk->sk;
+	sock_hold(sk);
+	skb->sk = sk;
 
-	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
+	sk->sk_user_data = (void *)(long)qp->elem.index;
+	skb->destructor = rxe_skb_tx_dtor;
+
 	if (skb->protocol == htons(ETH_P_IP)) {
-		err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
+		err = ip_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
+		err = ip6_local_out(dev_net(skb_dst(skb)->dev), sk, skb);
 	} else {
-		rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
-				skb->protocol);
-		atomic_dec(&pkt->qp->skb_out);
-		rxe_put(pkt->qp);
-		kfree_skb(skb);
-		return -EINVAL;
+		rxe_dbg_qp(qp, "Unknown layer 3 protocol: %d",
+			   skb->protocol);
+		err = -EINVAL;
+		goto err_not_sent;
 	}
 
+	/* IP consumed the packet, the destructor will handle cleanup */
 	if (unlikely(net_xmit_eval(err))) {
-		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
-		return -EAGAIN;
+		rxe_dbg_qp(qp, "Error sending packet: %d", err);
+		err = -EAGAIN;
+		goto err_out;
 	}
 
 	return 0;
+
+err_not_sent:
+	skb->destructor = NULL;
+	atomic_dec(&pkt->qp->skb_out);
+	kfree_skb(skb);
+	sock_put(sk);
+err_out:
+	return err;
 }
 
 /* fix up a send packet to match the packets
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a569b111a9d2..dcbf71031453 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -194,7 +194,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
-	qp->sk->sk->sk_user_data = qp;
 
 	/* pick a source UDP port number for this QP based on
 	 * the source QPN. this spreads traffic for different QPs
-- 
2.39.2

