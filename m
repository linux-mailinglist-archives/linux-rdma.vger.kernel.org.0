Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764AA27337A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIUUES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUUES (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:18 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C780C061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a3so18408750oib.4
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jp7ZZYgIOdVyNmoMY+S8yOvgoAMhSFL6qtsTnPRp9iQ=;
        b=B3bYwBm8COFdgMgZj4UgpbkwHO4DiX3Kd3cV9rosSdPyp13/uvB0Rt3/YFxvtNtT81
         2FkO6KMd4sz+BBD2n9RQRGEmltmxXqqNIvToGwUjIfWtpTFWNDQchcn2AiaaRswalln3
         yuG5f72MRDkgLID1iwl7dTySWiHLAZuuLtw4iZclxL2mjO0n42p1ZAiQphIEm15aT478
         EUSWrQqI/oAkEXshHbTuzZKkFKlRp0l8JeMS4Xb8gZpiuVTfRDvBwUv/qvYh/ZcUGoY5
         uDcDMVyrroJflliszoLESoEfR76pxDmPB/fkUDA3AijzEIe5+/RSrxCjSXf4cI9yAqNq
         c3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jp7ZZYgIOdVyNmoMY+S8yOvgoAMhSFL6qtsTnPRp9iQ=;
        b=dxhet1ldbttYay3nUpxv/fACW4AvAAtHQQZOfywn2G0PtdY4P0pLcBT18zZ/4hIOou
         7k38uVI+zzGVVrykDJ5mUdze7lOvLfRAvrnnsJunqO41MpdruMjjH6AhOV1+Zgv8ZcMX
         9CgKj6UOaZzm8oiar2NvPBywknIEpodTaPJkq76dtUpopMK1OCGrQuPEmT9ok2FxLNgg
         KwZBzMwPAFdWwAvSivC/7G9VqnrldTIvWC1E4lb9/AfvC9dACGLrkqWPcon9DeMGJE7o
         icpASvfHmJtpPVdSNWMcmnee068irVufJPxaruct3qLq3BO+7VlT5NFKMVNiVLgutX7W
         J7lA==
X-Gm-Message-State: AOAM532AYnWUYGzRQzpRD4wfL1gjG01zgACmrPNEzFaZeNP7wCvqZFGl
        hRkFBAFfWI9kDmMXZRSm0lw=
X-Google-Smtp-Source: ABdhPJzDZCELtW8kT62Qd0XrNbl0xvcMY+KiEYqPQ3rE+xohP+DgCRN29lN56r/jmydirjYCYARijA==
X-Received: by 2002:a05:6808:8f3:: with SMTP id d19mr636421oic.36.1600718657819;
        Mon, 21 Sep 2020 13:04:17 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id u68sm24285otb.9.2020.09.21.13.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 12/12] rdma_rxe: Fix bugs in the multicast receive path
Date:   Mon, 21 Sep 2020 15:03:56 -0500
Message-Id: <20200921200356.8627-13-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921200356.8627-1-rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
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
index 50411b0069ba..bc86ebbd2c8c 100644
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

