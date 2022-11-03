Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24C46185D6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiKCRLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKCRKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:47 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD712655
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y67so2672017oiy.1
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOrCfxbhHa4AcI2L2O/I+6YAaOAln5/3tFPHUtWRx98=;
        b=nihsgTkIPumc2DEOTF/H1SFYnpCvOg8dWFd63jGnrov2Yy14O+p0IXvUQke8OhDW3A
         VmRTBliEtHK5pI4Chj64Qw2LWtzJumsyBkhCc+LrJzrPyJlO5cGNRPve19WX0klZmp0H
         piVT4xFGIq1lIf3iJ742nnA9N1SrUx96TKZ0jWazRCnseVr2i1FfBki6+n19PIM6HARc
         KXHjOtB+oq2mORhjrgZSqb8415cx3TK2LE43JhcGYVVpDWj4H2CzMIPBYmrH5ajakXjQ
         zIipKzBYSRiKPUzQdhagpfCXMvbkhwgomGgGWL8yBbl3/6WHivwtVFOYljLsUWx7vJwF
         uAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOrCfxbhHa4AcI2L2O/I+6YAaOAln5/3tFPHUtWRx98=;
        b=2MWLgKzJOivTKRr07NHlca/55jLWSMSihRlPWlEEumUl63SF5UDPt61ZqAiBztc1fe
         eZHzJgZeySXNczUOCs87AyKc2ji25doMfEPOG0mt80qhWFjC144urSCqm6KiKF86w2gZ
         iQlqul2lbirPbeL67ykQSqiIBCggU2j5U3hmYNQmZGna04/QZaHp1aB4Ra/if0WS+ezP
         OEbKYZ95ph6yB65D+r9+X/5u2o942BnQ19VsL7jxBJxIj+ILNlYR2bx3cqg6Nska408e
         Nlbb3vcH5fdz2LZlEmyqETfcTeWBr099igHCTL7XkpMLSCw5nJLxQczI4/SYTceHiI9g
         m0ZQ==
X-Gm-Message-State: ACrzQf3tc3ANnpejUCa/04lnMkqfbvPUxB//qeWD2AabrxjfIuw22POM
        ClaSeyhN8m3BpfiNq90wJ7g=
X-Google-Smtp-Source: AMsMyM7uWjHac2qFxD1q8GLM4e8OjgL5OWpZuDvUpqhLWTYip3xWrWmU0GrGyBoKy63bAUEHtL0zvw==
X-Received: by 2002:a05:6808:ecc:b0:351:5b2e:e161 with SMTP id q12-20020a0568080ecc00b003515b2ee161mr25018070oiv.259.1667495439930;
        Thu, 03 Nov 2022 10:10:39 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v2 06/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_net.c
Date:   Thu,  3 Nov 2022 12:10:04 -0500
Message-Id: <20221103171013.20659-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace (some) calls to pr_xxx() in rxe_net.c with rxe_dbg_xxx().
Calls with a rxe device not yet in scope are left as is.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Fixed incorrect parameter list in rxe_find_route6() in the #else case.
Reported-by: kernel test robot <lkp@intel.com>

 drivers/infiniband/sw/rxe/rxe_net.c | 38 ++++++++++++++++-------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c36cad9c7a66..e02e1624bcf4 100644
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
 
@@ -77,7 +79,8 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 
 #else
 
-static struct dst_entry *rxe_find_route6(struct net_device *ndev,
+static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
+					 struct net_device *ndev,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
 {
@@ -105,14 +108,14 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 
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
@@ -282,7 +285,7 @@ static int prepare4(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 	dst = rxe_find_route(skb->dev, qp, av);
 	if (!dst) {
-		pr_err("Host not reachable\n");
+		rxe_dbg_qp(qp, "Host not reachable\n");
 		return -EHOSTUNREACH;
 	}
 
@@ -306,7 +309,7 @@ static int prepare6(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 	dst = rxe_find_route(skb->dev, qp, av);
 	if (!dst) {
-		pr_err("Host not reachable\n");
+		rxe_dbg_qp(qp, "Host not reachable\n");
 		return -EHOSTUNREACH;
 	}
 
@@ -365,7 +368,8 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
 	} else {
-		pr_err("Unknown layer 3 protocol: %d\n", skb->protocol);
+		rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
+				skb->protocol);
 		atomic_dec(&pkt->qp->skb_out);
 		rxe_put(pkt->qp);
 		kfree_skb(skb);
@@ -373,7 +377,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	}
 
 	if (unlikely(net_xmit_eval(err))) {
-		pr_debug("error sending packet: %d\n", err);
+		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
 		return -EAGAIN;
 	}
 
@@ -411,7 +415,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
 	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
+		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
 
@@ -592,7 +596,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 		rxe_port_down(rxe);
 		break;
 	case NETDEV_CHANGEMTU:
-		pr_info("%s changed mtu to %d\n", ndev->name, ndev->mtu);
+		rxe_dbg(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
 	case NETDEV_CHANGE:
@@ -604,7 +608,7 @@ static int rxe_notify(struct notifier_block *not_blk,
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

