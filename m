Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658C9615329
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiKAUX5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiKAUXz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:23:55 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37501C416
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:23:53 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13bd19c3b68so18085997fac.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzBPHRxaUUb1Zoh6Me3eudM5Ah8347rqn+cCcX54UDE=;
        b=cGUor6IA8zDHFokcqA+4nrw2gHMQInMJc3U2avcPg8GS49GlXOC25gKtnTEhRsV68w
         xGuFtZGUnGZfF7bI0Wv63Ve5RdlWop0sUZKzTAigWdOodxdsb972zG42YEbTMdYMZXcC
         lcZC/lAge0c/Om0N9aQ6yww+edfF4qzym9FwOD4amoonQZllxj1D7CBJlVjf+9V2WmMB
         iPlbqkvIdSzi0rWRIqtWdMC5arw5P1iLs9qK84PqdYasn5mrNyf1Wn5PEMDXrG8edJSu
         Kp8nnK++SnovQljbCCz4o45KMzANvFGjO11Dos9GCeqKYAFiP9x67mLTPQNibS3x8ln/
         G+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzBPHRxaUUb1Zoh6Me3eudM5Ah8347rqn+cCcX54UDE=;
        b=kFjhemyKBSG6at6WF0K0M/MXQbVleyWJg1EVuG1eOC8mTTnVKpwK/+AyD8dZYJJkk8
         Bk0Hin2Nx7ZgswbpjV6CswU4mQxlY+h65wrD0z7I6tk2rbCrdqqir8NNBrwKilQPGPE7
         6NCXPmXtfWBj0sFv5vVOBfdw2edee7ahWYvDWeOt5nof1bZNa1FJ/vrcPcJTN8C1F7LZ
         EdTqgGRfMkfnC3itYf8LuT5cxmd2c32HgopaTb/bQnGRwj7O1QX4YMkPQlHY4DtXnp+N
         6jNMPyB98riNatpgJXGhaXr2Vfg0x+QX3XRU4IxnQ+UCq9Xl4u1EjTEkCwHiExKooGPn
         mkrg==
X-Gm-Message-State: ACrzQf3ibwrOw1eqZSFxlPvX1cLMSbxjEV+aRzvCbetljZGpKk1m20ln
        MyEjfa1LV3QBqU4f/c0iEnI=
X-Google-Smtp-Source: AMsMyM7gP8Q6dAuPx2vcE0vBHJZJm+oVjAW76HikakWD0C5mPVeAtqrNtWuQGVXoSth/LRY4er97Fw==
X-Received: by 2002:a05:6871:1d2:b0:13d:1aee:a7e5 with SMTP id q18-20020a05687101d200b0013d1aeea7e5mr5392338oad.241.1667334233227;
        Tue, 01 Nov 2022 13:23:53 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:23:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 06/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_net.c
Date:   Tue,  1 Nov 2022 15:22:31 -0500
Message-Id: <20221101202238.32836-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace some calls to rxe_err/warn() in rxe_net.c with rxe_dbg_qp().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 35 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c36cad9c7a66..76a7668ca5bc 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,9 +20,10 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-static struct dst_entry *rxe_find_route4(struct net_device *ndev,
-				  struct in_addr *saddr,
-				  struct in_addr *daddr)
+static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
+					 struct net_device *ndev,
+					 struct in_addr *saddr,
+					 struct in_addr *daddr)
 {
 	struct rtable *rt;
 	struct flowi4 fl = { { 0 } };
@@ -35,7 +36,7 @@ static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 
 	rt = ip_route_output_key(&init_net, &fl);
 	if (IS_ERR(rt)) {
-		pr_err_ratelimited("no route to %pI4\n", &daddr->s_addr);
+		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
 		return NULL;
 	}
 
@@ -43,7 +44,8 @@ static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static struct dst_entry *rxe_find_route6(struct net_device *ndev,
+static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
+					 struct net_device *ndev,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
 {
@@ -60,12 +62,12 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 					       recv_sockets.sk6->sk, &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
-		pr_err_ratelimited("no route to %pI6\n", daddr);
+		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		return NULL;
 	}
 
 	if (unlikely(ndst->error)) {
-		pr_err("no route to %pI6\n", daddr);
+		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		goto put;
 	}
 
@@ -105,14 +107,14 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 
 			saddr = &av->sgid_addr._sockaddr_in.sin_addr;
 			daddr = &av->dgid_addr._sockaddr_in.sin_addr;
-			dst = rxe_find_route4(ndev, saddr, daddr);
+			dst = rxe_find_route4(qp, ndev, saddr, daddr);
 		} else if (av->network_type == RXE_NETWORK_TYPE_IPV6) {
 			struct in6_addr *saddr6;
 			struct in6_addr *daddr6;
 
 			saddr6 = &av->sgid_addr._sockaddr_in6.sin6_addr;
 			daddr6 = &av->dgid_addr._sockaddr_in6.sin6_addr;
-			dst = rxe_find_route6(ndev, saddr6, daddr6);
+			dst = rxe_find_route6(qp, ndev, saddr6, daddr6);
 #if IS_ENABLED(CONFIG_IPV6)
 			if (dst)
 				qp->dst_cookie =
@@ -282,7 +284,7 @@ static int prepare4(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 	dst = rxe_find_route(skb->dev, qp, av);
 	if (!dst) {
-		pr_err("Host not reachable\n");
+		rxe_dbg_qp(qp, "Host not reachable\n");
 		return -EHOSTUNREACH;
 	}
 
@@ -306,7 +308,7 @@ static int prepare6(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 	dst = rxe_find_route(skb->dev, qp, av);
 	if (!dst) {
-		pr_err("Host not reachable\n");
+		rxe_dbg_qp(qp, "Host not reachable\n");
 		return -EHOSTUNREACH;
 	}
 
@@ -365,7 +367,8 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	} else {
-		pr_err("Unknown layer 3 protocol: %d\n", skb->protocol);
+		rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
+				skb->protocol);
 		atomic_dec(&pkt->qp->skb_out);
 		rxe_put(pkt->qp);
 		kfree_skb(skb);
@@ -373,7 +376,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	}
 
 	if (unlikely(net_xmit_eval(err))) {
-		pr_debug("error sending packet: %d\n", err);
+		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
 		return -EAGAIN;
 	}
 
@@ -411,7 +414,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
 	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
+		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
 
@@ -592,7 +595,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 		rxe_port_down(rxe);
 		break;
 	case NETDEV_CHANGEMTU:
-		pr_info("%s changed mtu to %d\n", ndev->name, ndev->mtu);
+		rxe_dbg(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
 	case NETDEV_CHANGE:
@@ -604,7 +607,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
 	default:
-		pr_info("ignoring netdev event = %ld for %s\n",
+		rxe_dbg(rxe, "ignoring netdev event = %ld for %s\n",
 			event, ndev->name);
 		break;
 	}
-- 
2.34.1

