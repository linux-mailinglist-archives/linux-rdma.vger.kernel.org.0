Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC22707FE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIRVQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgIRVQC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:16:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E1C0613D2
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:16:02 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e23so6671818otk.7
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dm44RId9KH8+mvs5fm3rx4HEXZgwgoB+lS1+H9/Acoo=;
        b=WJTFqLpUODjAIHTdcyvVobkHPv+nmxyoKhe7fIy/vKWHs9XniVlYOaA3UpGSR7/Y7M
         x5ipJKQT/RBmzBhFRWWDc9fthnW0roUfPUdtAroOIQYEB9TD3GEHXF9emqIFJlFC2RpY
         UrJbPDkkxyqCoX41dAjJpVpHzyRRswE0jiqjKVqDGAjeZyYak8MMH0Jvdulmd+OoedRF
         p8AqLqWgPpswdAIrNQUMBt9QdYpm9gQcvVgWOysyeAZibozwsgNXQ3Ji3Kn6+03tLeB1
         ofJvAeOVA9OdTF390+Bz5WZ7v9UV3xwljV+YlHv9oy/pM2YOsxtiC1RmV46e+UXYuJWL
         93wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm44RId9KH8+mvs5fm3rx4HEXZgwgoB+lS1+H9/Acoo=;
        b=c0llXeUMMWgcNVom0hAVcENW/Xsx42VcfudNbiLRv6AtXSyMhM4C+nrWJsoQd5po+A
         zFzfSJBq7FWF3LZ0EqFLg66hFv3n2Z6P1pWzdJAppwnNpi1u4noOW6J8hU8kJYUHl2bt
         SpgxAMbKeyODtlUb0OXpomYekZp36BsxHoKeuEz83ZLkE9AbBJ5LPqI3wmwv/u0XIdY7
         stbPHJNh+FTUlbA1Nnuzsek1wcOFL0Qa85Q4eJVydPFalwGn3IUjPt40fc7v0uqNxkyy
         vLrP2hb/WdLZE9PCY9fZhlsetuSAES9lDHhEoPx+vre3ZBcdFfePnCen5wONZj8MKK13
         l1/g==
X-Gm-Message-State: AOAM531HMSh62d8GTe3J6B6BfXMgRVSi/7IrOiCBVUeM2qHwfY+dA6r8
        DtHx5GkW/sx+eNrXjC1p2RUQEtNee7Y=
X-Google-Smtp-Source: ABdhPJzO5Htp1mN2UOzpksdpoWNvc+jqClrsJKCxMtRHLaNE4ChN4qEzqWUdkf9mcoJb+TQyxc7luw==
X-Received: by 2002:a9d:7448:: with SMTP id p8mr11294711otk.306.1600463761862;
        Fri, 18 Sep 2020 14:16:01 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id i205sm3768507oih.23.2020.09.18.14.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:16:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 12/12] rdma_rxe: Fix bugs in the multicast receive path
Date:   Fri, 18 Sep 2020 16:15:17 -0500
Message-Id: <20200918211517.5295-13-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch does the following
  - Fix a bug in rxe_rcv.
    The current code calls rxe_match_dgid which checks to see if the
    destination ip address (dgid) matches one of the addresses in
    the gid table. This is ok for unicast adfdresses but not mcast
    addresses. Because of this all mcast packets were previously
    dropped.
  - Fix a bug in rxe_rcv_mcast_pkt.
    The current code is just wrong. It assumed that it could pass
    the same skb to rxe_rcv_pkt changing the qp pointer as it went
    when multiple QPs were attached to the same mcast address. In
    fact each QP needs a separate clone of the skb which it will
    delete later.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 50411b0069ba..3522b8c4a267 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -233,6 +233,8 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	struct rxe_mc_elem *mce;
 	struct rxe_qp *qp;
 	union ib_gid dgid;
+	struct sk_buff *per_qp_skb;
+	struct rxe_pkt_info *per_qp_pkt;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -261,42 +263,37 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		if (err)
 			continue;
 
-		/* if *not* the last qp in the list
-		 * increase the users of the skb then post to the next qp
+		/* for all but the last qp create a new clone of the
+		 * skb and pass to the qp.
+		 * This effectively reverts an earlier change
+		 * which did not work. The pkt struct is contained
+		 * in the skb so each time you changed pkt you also
+		 * changed all the earlier pkts as well. Caused a mess.
 		 */
 		if (mce->qp_list.next != &mcg->qp_list)
-			skb_get(skb);
+			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
+		else
+			per_qp_skb = skb;
 
-		pkt->qp = qp;
+		per_qp_pkt = SKB_TO_PKT(per_qp_skb);
+		per_qp_pkt->qp = qp;
 		rxe_add_ref(qp);
-		rxe_rcv_pkt(pkt, skb);
+		rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
 	}
 
 	spin_unlock_bh(&mcg->mcg_lock);
-
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	return;
 
 err1:
 	kfree_skb(skb);
+	return;
 }
 
-static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb)
+static int rxe_match_dgid(struct rxe_dev *rxe, struct sk_buff *skb,
+			  union ib_gid *pdgid)
 {
-	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	const struct ib_gid_attr *gid_attr;
-	union ib_gid dgid;
-	union ib_gid *pdgid;
-
-	if (pkt->mask & RXE_LOOPBACK_MASK)
-		return 0;
-
-	if (skb->protocol == htons(ETH_P_IP)) {
-		ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
-				       (struct in6_addr *)&dgid);
-		pdgid = &dgid;
-	} else {
-		pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
-	}
 
 	gid_attr = rdma_find_gid_by_port(&rxe->ib_dev, pdgid,
 					 IB_GID_TYPE_ROCE_UDP_ENCAP,
@@ -314,17 +311,32 @@ void rxe_rcv(struct sk_buff *skb)
 	int err;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	struct rxe_dev *rxe = pkt->rxe;
+	union ib_gid dgid;
+	union ib_gid *pdgid;
 	__be32 *icrcp;
 	u32 calc_icrc, pack_icrc;
+	int is_mc;
 
 	pkt->offset = 0;
 
 	if (unlikely(skb->len < pkt->offset + RXE_BTH_BYTES))
 		goto drop;
 
-	if (rxe_match_dgid(rxe, skb) < 0) {
-		pr_warn_ratelimited("failed matching dgid\n");
-		goto drop;
+	if (skb->protocol == htons(ETH_P_IP)) {
+		ipv6_addr_set_v4mapped(ip_hdr(skb)->daddr,
+				       (struct in6_addr *)&dgid);
+		pdgid = &dgid;
+	} else {
+		pdgid = (union ib_gid *)&ipv6_hdr(skb)->daddr;
+	}
+
+	is_mc = rdma_is_multicast_addr((struct in6_addr *)pdgid);
+
+	if (!(pkt->mask & RXE_LOOPBACK_MASK) && !is_mc) {
+		if (rxe_match_dgid(rxe, skb, pdgid) < 0) {
+			pr_warn_ratelimited("failed matching dgid\n");
+			goto drop;
+		}
 	}
 
 	pkt->opcode = bth_opcode(pkt);
-- 
2.25.1

