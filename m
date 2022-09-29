Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D865EEFE5
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 10:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiI2IDA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 04:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiI2IC0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 04:02:26 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 01:02:07 PDT
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45913C87C
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 01:02:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="89908527"
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="89908527"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 29 Sep 2022 17:01:01 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C9053D63BB
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 17:00:59 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id F1821BF4AF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 17:00:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.19.3.107])
        by m3004.s.css.fujitsu.com (Postfix) with ESMTP id C319F203EBCE;
        Thu, 29 Sep 2022 17:00:58 +0900 (JST)
From:   Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To:     leonro@nvidia.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove error/warning messages from packet receiver path
Date:   Thu, 29 Sep 2022 17:00:23 +0900
Message-Id: <20220929080023.304242-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Incoming packets to rxe are passed from UDP layer using an encapsulation
socket. If there are any clients reachable to a node, they can invoke the
encapsulation handler arbitrarily by sending malicious or irrelevant
packets. This can potentially cause a message overflow and a subsequent
slowdown on the node.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c |  12 +--
 drivers/infiniband/sw/rxe/rxe_net.c  |   1 -
 drivers/infiniband/sw/rxe/rxe_recv.c | 106 +++++++--------------------
 3 files changed, 28 insertions(+), 91 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index e03af3012590..46bb07c5c4df 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -151,18 +151,8 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 				payload_size(pkt) + bth_pad(pkt));
 	icrc = ~icrc;
 
-	if (unlikely(icrc != pkt_icrc)) {
-		if (skb->protocol == htons(ETH_P_IPV6))
-			pr_warn_ratelimited("bad ICRC from %pI6c\n",
-					    &ipv6_hdr(skb)->saddr);
-		else if (skb->protocol == htons(ETH_P_IP))
-			pr_warn_ratelimited("bad ICRC from %pI4\n",
-					    &ip_hdr(skb)->saddr);
-		else
-			pr_warn_ratelimited("bad ICRC from unknown\n");
-
+	if (unlikely(icrc != pkt_icrc))
 		return -EINVAL;
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c53f4529f098..35f327b9d4b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -145,7 +145,6 @@ static int rxe_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	if (skb_linearize(skb)) {
-		pr_err("skb_linearize failed\n");
 		ib_device_put(&rxe->ib_dev);
 		goto drop;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index f3ad7b6dbd97..434a693cd4a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -16,47 +16,36 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	unsigned int pkt_type;
 
 	if (unlikely(!qp->valid))
-		goto err1;
+		return -EINVAL;
 
 	pkt_type = pkt->opcode & 0xe0;
 
 	switch (qp_type(qp)) {
 	case IB_QPT_RC:
-		if (unlikely(pkt_type != IB_OPCODE_RC)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_RC))
+			return -EINVAL;
 		break;
 	case IB_QPT_UC:
-		if (unlikely(pkt_type != IB_OPCODE_UC)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_UC))
+			return -EINVAL;
 		break;
 	case IB_QPT_UD:
 	case IB_QPT_GSI:
-		if (unlikely(pkt_type != IB_OPCODE_UD)) {
-			pr_warn_ratelimited("bad qp type\n");
-			goto err1;
-		}
+		if (unlikely(pkt_type != IB_OPCODE_UD))
+			return -EINVAL;
 		break;
 	default:
-		pr_warn_ratelimited("unsupported qp type\n");
-		goto err1;
+		return -EINVAL;
 	}
 
 	if (pkt->mask & RXE_REQ_MASK) {
 		if (unlikely(qp->resp.state != QP_STATE_READY))
-			goto err1;
+			return -EINVAL;
 	} else if (unlikely(qp->req.state < QP_STATE_READY ||
-				qp->req.state > QP_STATE_DRAINED)) {
-		goto err1;
-	}
+				qp->req.state > QP_STATE_DRAINED))
+		return -EINVAL;
 
 	return 0;
-
-err1:
-	return -EINVAL;
 }
 
 static void set_bad_pkey_cntr(struct rxe_port *port)
@@ -84,26 +73,20 @@ static int check_keys(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	pkt->pkey_index = 0;
 
 	if (!pkey_match(pkey, IB_DEFAULT_PKEY_FULL)) {
-		pr_warn_ratelimited("bad pkey = 0x%x\n", pkey);
 		set_bad_pkey_cntr(port);
-		goto err1;
+		return -EINVAL;
 	}
 
 	if (qp_type(qp) == IB_QPT_UD || qp_type(qp) == IB_QPT_GSI) {
 		u32 qkey = (qpn == 1) ? GSI_QKEY : qp->attr.qkey;
 
 		if (unlikely(deth_qkey(pkt) != qkey)) {
-			pr_warn_ratelimited("bad qkey, got 0x%x expected 0x%x for qpn 0x%x\n",
-					    deth_qkey(pkt), qkey, qpn);
 			set_qkey_viol_cntr(port);
-			goto err1;
+			return -EINVAL;
 		}
 	}
 
 	return 0;
-
-err1:
-	return -EINVAL;
 }
 
 static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
@@ -112,13 +95,10 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 	struct sk_buff *skb = PKT_TO_SKB(pkt);
 
 	if (qp_type(qp) != IB_QPT_RC && qp_type(qp) != IB_QPT_UC)
-		goto done;
+		return 0;
 
-	if (unlikely(pkt->port_num != qp->attr.port_num)) {
-		pr_warn_ratelimited("port %d != qp port %d\n",
-				    pkt->port_num, qp->attr.port_num);
-		goto err1;
-	}
+	if (unlikely(pkt->port_num != qp->attr.port_num))
+		return -EINVAL;
 
 	if (skb->protocol == htons(ETH_P_IP)) {
 		struct in_addr *saddr =
@@ -126,19 +106,9 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		struct in_addr *daddr =
 			&qp->pri_av.dgid_addr._sockaddr_in.sin_addr;
 
-		if (ip_hdr(skb)->daddr != saddr->s_addr) {
-			pr_warn_ratelimited("dst addr %pI4 != qp source addr %pI4\n",
-					    &ip_hdr(skb)->daddr,
-					    &saddr->s_addr);
-			goto err1;
-		}
-
-		if (ip_hdr(skb)->saddr != daddr->s_addr) {
-			pr_warn_ratelimited("source addr %pI4 != qp dst addr %pI4\n",
-					    &ip_hdr(skb)->saddr,
-					    &daddr->s_addr);
-			goto err1;
-		}
+		if ((ip_hdr(skb)->daddr != saddr->s_addr) ||
+		    (ip_hdr(skb)->saddr != daddr->s_addr))
+			return -EINVAL;
 
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		struct in6_addr *saddr =
@@ -146,24 +116,12 @@ static int check_addr(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		struct in6_addr *daddr =
 			&qp->pri_av.dgid_addr._sockaddr_in6.sin6_addr;
 
-		if (memcmp(&ipv6_hdr(skb)->daddr, saddr, sizeof(*saddr))) {
-			pr_warn_ratelimited("dst addr %pI6 != qp source addr %pI6\n",
-					    &ipv6_hdr(skb)->daddr, saddr);
-			goto err1;
-		}
-
-		if (memcmp(&ipv6_hdr(skb)->saddr, daddr, sizeof(*daddr))) {
-			pr_warn_ratelimited("source addr %pI6 != qp dst addr %pI6\n",
-					    &ipv6_hdr(skb)->saddr, daddr);
-			goto err1;
-		}
+		if (memcmp(&ipv6_hdr(skb)->daddr, saddr, sizeof(*saddr)) ||
+		    memcmp(&ipv6_hdr(skb)->saddr, daddr, sizeof(*daddr)))
+			return -EINVAL;
 	}
 
-done:
 	return 0;
-
-err1:
-	return -EINVAL;
 }
 
 static int hdr_check(struct rxe_pkt_info *pkt)
@@ -175,24 +133,18 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	int index;
 	int err;
 
-	if (unlikely(bth_tver(pkt) != BTH_TVER)) {
-		pr_warn_ratelimited("bad tver\n");
+	if (unlikely(bth_tver(pkt) != BTH_TVER))
 		goto err1;
-	}
 
-	if (unlikely(qpn == 0)) {
-		pr_warn_once("QP 0 not supported");
+	if (unlikely(qpn == 0))
 		goto err1;
-	}
 
 	if (qpn != IB_MULTICAST_QPN) {
 		index = (qpn == 1) ? port->qp_gsi_index : qpn;
 
 		qp = rxe_pool_get_index(&rxe->qp_pool, index);
-		if (unlikely(!qp)) {
-			pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn);
+		if (unlikely(!qp))
 			goto err1;
-		}
 
 		err = check_type_state(rxe, pkt, qp);
 		if (unlikely(err))
@@ -206,10 +158,8 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 		if (unlikely(err))
 			goto err2;
 	} else {
-		if (unlikely((pkt->mask & RXE_GRH_MASK) == 0)) {
-			pr_warn_ratelimited("no grh for mcast qpn\n");
+		if (unlikely((pkt->mask & RXE_GRH_MASK) == 0))
 			goto err1;
-		}
 	}
 
 	pkt->qp = qp;
@@ -364,10 +314,8 @@ void rxe_rcv(struct sk_buff *skb)
 	if (unlikely(skb->len < RXE_BTH_BYTES))
 		goto drop;
 
-	if (rxe_chk_dgid(rxe, skb) < 0) {
-		pr_warn_ratelimited("failed checking dgid\n");
+	if (rxe_chk_dgid(rxe, skb) < 0)
 		goto drop;
-	}
 
 	pkt->opcode = bth_opcode(pkt);
 	pkt->psn = bth_psn(pkt);
-- 
2.31.1

