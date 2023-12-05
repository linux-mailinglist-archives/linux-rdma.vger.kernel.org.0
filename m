Return-Path: <linux-rdma+bounces-251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E882804352
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9442BB20B1B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3C393;
	Tue,  5 Dec 2023 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idofMd5q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3992B0
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:24:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b88f2a37deso2981423b6e.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735859; x=1702340659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAo9Voy4RzHWA16EdVudg5saPOZLVlTIEuxiR5JPPMk=;
        b=idofMd5qJjdatpiTn32waov+vZBiP9zTmBHP3pRT+DitmlwF+2AYpd+JQWaCfgh9Fx
         MHq5pj5UmdKmH8BQZZJgVG+ZUsXwTgxy0/puk2v/io2WB39xkt1LXDUgppcPCpUgNY0X
         BNzHIwiLP5TTQ8hgAiUKWEiuB8pDA+zAznHc0k/QWX0Kj8Yoi3Im48mS0AQaa2+lOmF5
         2Rd6bQF7eUzV16OSqQSVbSz8e1tEnQcXshQG31/LNAx0CybNXAc4kCbxkf+5eeu1HXnC
         xMTiqu6p0FvTtK3fejsd77/SH16NY3eaWrdj1U9iBZIfhphGpxaruWngUAyVhfBAs+Zl
         Wnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735859; x=1702340659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAo9Voy4RzHWA16EdVudg5saPOZLVlTIEuxiR5JPPMk=;
        b=TVSFO/Qivo+7sbAgJ/RnGSXrOyBexFlq2nhXfvF1xAk2Ms/O7Ub7DyeQWZ4c7YNwt1
         MgGV6YFffqR53rZy+mXg+q+5T2gNIjKIGoZDo2mfrNLaRIY9YPT3fmJAxxpHuD8JY0SM
         Ksi3cOrPRSrSLlTs2oyZsGdmQ6ZEEcKUeQxMe0+m6XfYojcArKQKdT7OjuuPi19vsQyY
         LH1+QFOcZEoX65uOtCfiULew19cmnudb/Mf881GTNeTLjDl1cl1mSNyeZS4lmJDd9hUB
         cXdme61fFPtVwRM5VGsKPsKpRrK0+Ck7Rcz2vz55TYkUZJp1zRFhoH5DXuwDSuiTQa3a
         1dfw==
X-Gm-Message-State: AOJu0Yziww4t49nWoAvfwqGgAVooiRW3Jl/n4Ic83od6VQmmMk4hWMXV
	WTsGOW5rvlxcGn1EtXHCM/UGhT1oLcg=
X-Google-Smtp-Source: AGHT+IGJxmzXOezfV7jrF//jxSlH95eexjwnP0qKtRmDFvllNeEK3Mtb9l39IFYQ4VKPSgtMfDh3DQ==
X-Received: by 2002:a05:6808:1286:b0:3b8:b063:5059 with SMTP id a6-20020a056808128600b003b8b0635059mr5511159oiw.90.1701735859334;
        Mon, 04 Dec 2023 16:24:19 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id bi25-20020a056808189900b003b2e4754cc2sm2007066oib.26.2023.12.04.16.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:24:18 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 2/7] RDMA/rxe: Fix sending of mcast packets
Date: Mon,  4 Dec 2023 18:23:19 -0600
Message-Id: <20231205002322.10143-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205002322.10143-1-rpearsonhpe@gmail.com>
References: <20231205002322.10143-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the rdma_rxe driver does not send mcast packets correctly.
It uses the wrong qp number for the packets.

Add a mask bit to indicate that a multicast packet has been locally
sent and use to set the correct qpn for multicast packets and
identify mcast packets when sending.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c     |  7 +++++++
 drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c    |  4 +++-
 drivers/infiniband/sw/rxe/rxe_opcode.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c   |  4 ++++
 drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++++++--
 6 files changed, 25 insertions(+), 4 deletions(-)

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
index cd59666158b1..58c3f3759bf0 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -431,7 +431,9 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	rxe_icrc_generate(skb, pkt);
 
-	if (pkt->mask & RXE_LOOPBACK_MASK)
+	if (pkt->mask & RXE_MCAST_MASK)
+		err = rxe_send(skb, pkt);
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


