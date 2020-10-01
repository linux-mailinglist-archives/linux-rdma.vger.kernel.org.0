Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899372805DC
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgJARtL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbgJARtH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:07 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE2C0613E5
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x14so6476186oic.9
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/EVf/acTWOTeXlExnzmqEgiMNsr5DangUbYAmxCMVM=;
        b=JdJeV2FCKs8be345iDNAgWKbm7vq7HOfRnoGBXA++/UphYiB/LPhw9vYCFQV3jbE1y
         g7jDzqTmiEICtYoSB6f/BriReeE6G/W/plTnveXsGqzhXDd+IFJ5ksFwREbYx959pNGz
         EX4HVjdcRtJqrXOO/nwslvbcygEFTQepeqWuj0cSoqNssu3NPrGytJvP6el85OaTvxMi
         5iTJvFjyegFSnwiHWLQV0S8P0euE08ftecB5pbis/WO2XYVy/KvYUoEgOTjDjqc5eFQq
         B/oOnZAvv9o6UloJLrO3u+wTrRN1R8WdUbUaZ5gDlUvgt02t5pEOnD5uyCWQj0RVEKNO
         fKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/EVf/acTWOTeXlExnzmqEgiMNsr5DangUbYAmxCMVM=;
        b=kphEZ5wg1nV4od13zya/G8ZYvvQaXsg9rYEirhEzCkzpgtrYJmmk6AiApYToNnj7C7
         F8+lTyuZpxJmxprsif7TuVlYJNO7qzqUhktb8NgeDm2Ifvpgn7qBd9dHON+mVeBZE1Tv
         QVgCv4A5zliI6r3lX1AZfqISTZBhOZ+Zhxhk69e0IVw6UIxAVqBJoTOQhyVOO7ABw0Uq
         vayXwZOPKxrRi3MoRCBULSPRTAeB3jqJWI+hLqUOat7YztMaUg9oZnLrYvtUYiGIGa+7
         YYHg0Iem3L8gOcU+EI2QHPRIwK/J8wAkyxG+lBHcdO/J7ET6T6viO1Us0hLAZbejwTIX
         kPsQ==
X-Gm-Message-State: AOAM531UchODLP5oTv+jeZqVrwFtTXwMoW0ZWpY0S/7ybDLPwijdlewd
        sqUwjSRIR/vUwv232TCpnS8=
X-Google-Smtp-Source: ABdhPJzsdGIjC7NAKQmGmOhLJK0ltXlNSyyzq4MTPF4rADxxa+v22AO5bSzvkWUx3Cg/EQ2Vz2q7bA==
X-Received: by 2002:aca:abc7:: with SMTP id u190mr679098oie.146.1601574546192;
        Thu, 01 Oct 2020 10:49:06 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id q184sm1492910ooq.40.2020.10.01.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:05 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 14/19] rdma_rxe: Fix bugs in the multicast receive path
Date:   Thu,  1 Oct 2020 12:48:42 -0500
Message-Id: <20201001174847.4268-15-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
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
 drivers/infiniband/sw/rxe/rxe_recv.c | 61 ++++++++++++++++------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index e14cb20c4596..dbb623ec5eaa 100644
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
@@ -261,42 +263,36 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
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
-	rxe_drop_ref(mcg);	/* drop ref from rxe_get_key. */
+	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	return;
 
 err1:
 	kfree_skb(skb);
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
@@ -314,17 +310,32 @@ void rxe_rcv(struct sk_buff *skb)
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

