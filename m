Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3408F7E28B1
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 16:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjKFPaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 10:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjKFPaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 10:30:01 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE3112
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 07:29:51 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d261cb07dcso2823871a34.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284591; x=1699889391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXf95k1LhyAO3Bb5IBpGSuz3pnIBLmSTOxy1G+swVis=;
        b=iI14bNYHYrfaXsAp5BvcZ9jyVd8Leo7ZX4EXTOR7EJC9thG+13+9KC1Qxq9Wg9okkT
         2XO5dBAI3azF+5u5qcNWQ5j678HLusJPz4Xv70nPZcedyitWxnzRs9pn/5KZLwXQ7tUH
         iGH7mChTxjQbcNrcp3CFsZsmw9o0oK/3TP8kBibkDcVC6H544YFzL7Lvk3kcFq4VF0G1
         VJWZywZTW4lsBnU+EUEzNRq0YYdKgcdGU7xjFqiOi27B20G3cu3PBBRMBTu8zV2M5BYf
         96nFIP1lNkYpwaI4/jmM50TJO+sYCtYIhsXsPP9sbTZhbQJbt3vnKk6cdbJvsGUZuU82
         +0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284591; x=1699889391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXf95k1LhyAO3Bb5IBpGSuz3pnIBLmSTOxy1G+swVis=;
        b=lEM0LIKJb+SBrY/Qf4QzdkApfoGIkXvO+A7MnKR6ztSNa5vCiP3M7TQDAnXedXeICP
         SLS3Pj45VKS3RwyWa+kOm41jy1D2VNcqdrFFrs+HmZZvpVaXD/U535T3XQMF0ry8LE5H
         Vx+Dn8C3sMDyzankb0xeZ2X8YyeEKvrYGMTWYWlT2SmAyNo2HHF5eG/1BturclncGmc+
         eI7OsjZWMvjdEVeB5m8oE2F7ckqScC/Gl8ZvNgxY0VEufPTykFUTZKBHJv2X79rh0+uC
         ceoJI03vG06UBLVwi9G86VzsQTN9S9ZurVYpzYT0MSd+YAyYT74+YiDPhSlGiDYdSghI
         WocA==
X-Gm-Message-State: AOJu0YzUNqap5h3m6zLlMoxlTICztZaCVnjrK+hLnpzIsvhm108Xq3eO
        4xV6Zt6MPfTyBi13nTuA6XA=
X-Google-Smtp-Source: AGHT+IHzZcL37JrrAum8o58KFpFxKrcSc8vUIoMz0H/eprQqXALDRSlTBhIjp4McuhhkNx/b4FUdvQ==
X-Received: by 2002:a05:6870:e2d0:b0:1ef:b16f:d294 with SMTP id w16-20020a056870e2d000b001efb16fd294mr28259811oad.38.1699284591227;
        Mon, 06 Nov 2023 07:29:51 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id ds50-20020a0568705b3200b001e578de89cesm1438897oab.37.2023.11.06.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:29:50 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/6] RDMA/rxe: Handle loopback of mcast packets
Date:   Mon,  6 Nov 2023 09:29:25 -0600
Message-Id: <20231106152928.47869-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106152928.47869-1-rpearsonhpe@gmail.com>
References: <20231106152928.47869-1-rpearsonhpe@gmail.com>
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

Currently the rdma_rxe driver does not send mcast packets correctly.
It does not loop mcast packets back to local qp's which belong to
the same mcast group. It also uses the wrong qp number for the
packets.

Add code to rxe_xmit_packet() to correctly handle mcast packets
which must be sent on the wire and also duplicated to any local qp's
which may belong the mcast group, but not including the sender.

Add a mask bit to indicate that a multicast packet has been locally
sent and use to set the correct qpn for multicast packets and
identify mcast packets when sending.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c     |  7 +++++++
 drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c    | 26 +++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c   |  4 ++++
 drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++++++--
 6 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 4ac17b8def28..022173eb5d75 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -7,6 +7,13 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+bool rxe_is_mcast_av(struct rxe_av *av)
+{
+	struct in6_addr *daddr = (struct in6_addr *)av->grh.dgid.raw;
+
+	return rdma_is_multicast_addr(daddr);
+}
+
 void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
 {
 	rxe_av_from_attr(rdma_ah_get_port_num(attr), av, attr);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 3d2504a0ae56..62b2b25903fc 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -8,6 +8,7 @@
 #define RXE_LOC_H
 
 /* rxe_av.c */
+bool rxe_is_mcast_av(struct rxe_av *av);
 void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av);
 int rxe_chk_ah_attr(struct rxe_dev *rxe, struct rdma_ah_attr *attr);
 void rxe_av_from_attr(u8 port_num, struct rxe_av *av,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index cd59666158b1..b72f3397ff6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -412,6 +412,28 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	return 0;
 }
 
+/*
+ * For a multicast packet, must send remotely and looback to any local qps
+ * that may belong to the mcast group.
+ */
+static int rxe_loop_and_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
+{
+	struct sk_buff *cskb;
+	int err, loc_err = 0;
+
+	if (atomic_read(&pkt->rxe->mcg_num)) {
+		loc_err = -ENOMEM;
+		cskb = skb_clone(skb, GFP_KERNEL);
+		if (cskb)
+			loc_err = rxe_loopback(cskb, pkt);
+	}
+
+	err = rxe_send(skb, pkt);
+	if (loc_err)
+		err = loc_err;
+	return err;
+}
+
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb)
 {
@@ -431,7 +453,9 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	rxe_icrc_generate(skb, pkt);
 
-	if (pkt->mask & RXE_LOOPBACK_MASK)
+	if (pkt->mask & RXE_MCAST_MASK)
+		err = rxe_loop_and_send(skb, pkt);
+	else if (pkt->mask & RXE_LOOPBACK_MASK)
 		err = rxe_loopback(skb, pkt);
 	else
 		err = rxe_send(skb, pkt);
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 5686b691d6b8..c4cf672ea26d 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -85,7 +85,7 @@ enum rxe_hdr_mask {
 	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 11),
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
-
+	RXE_MCAST_MASK		= BIT(NUM_HDR_TYPES + 13),
 	RXE_ATOMIC_WRITE_MASK   = BIT(NUM_HDR_TYPES + 14),
 
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 5861e4244049..7153de0799fc 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -217,6 +217,10 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
 		qp = mca->qp;
 
+		/* don't reply packet to sender if locally sent */
+		if (pkt->mask & RXE_MCAST_MASK && qp_num(qp) == deth_sqp(pkt))
+			continue;
+
 		/* validate qp for incoming packet */
 		err = check_type_state(rxe, pkt, qp);
 		if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d8c41fd626a9..599bec88cb54 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -442,8 +442,12 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
 			(RXE_WRITE_MASK | RXE_IMMDT_MASK));
 
-	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
-					 qp->attr.dest_qp_num;
+	if (pkt->mask & RXE_MCAST_MASK)
+		qp_num = IB_MULTICAST_QPN;
+	else if (pkt->mask & RXE_DETH_MASK)
+		qp_num = ibwr->wr.ud.remote_qpn;
+	else
+		qp_num = qp->attr.dest_qp_num;
 
 	ack_req = ((pkt->mask & RXE_END_MASK) ||
 		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
@@ -809,6 +813,9 @@ int rxe_requester(struct rxe_qp *qp)
 		goto err;
 	}
 
+	if (rxe_is_mcast_av(av))
+		pkt.mask |= RXE_MCAST_MASK;
+
 	skb = init_req_packet(qp, av, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		rxe_dbg_qp(qp, "Failed allocating skb\n");
-- 
2.40.1

