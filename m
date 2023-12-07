Return-Path: <linux-rdma+bounces-319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B840B809151
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CA81C209ED
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE414F8B1;
	Thu,  7 Dec 2023 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqNpJanj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E392A1722;
	Thu,  7 Dec 2023 11:30:18 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fb9a22b4a7so787313fac.3;
        Thu, 07 Dec 2023 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701977417; x=1702582217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAo9Voy4RzHWA16EdVudg5saPOZLVlTIEuxiR5JPPMk=;
        b=TqNpJanje8kkQVMPKrLidQ738NHVW3WDmhI7totVpeNpT1a3xIBe4E6ZLeEv6lzPqo
         bOHMQjdTI950dEv2GqnlxNp3UJ66AAn0xo85NhtgnUeV3hzbD3O0g4NMX1IVCwcAB8MH
         drkvzWgdtGPlbut47n7uflG8usco/RSmlGkJ6C5/IijWt+V5cVQQbhn0GF40qDfuqWta
         5B6IY+tZenRch2Z/IhuWceQenGr/NZjDOQnDHCkzoaidlm4gWZBM7+Kmoj0pW+Uv9DOy
         iKHlYiGLftPavg/5OYCDq1SyONEt392KELJL2wsdCMX2gnaTGI9LzxWlXwYDv80hXRkP
         hgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977417; x=1702582217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAo9Voy4RzHWA16EdVudg5saPOZLVlTIEuxiR5JPPMk=;
        b=t2TrpWEbJoFMh0S65eySx7x/pVYGgJE8YUSMshLRNjhUUo9Iamc9lm5FIY7RvM0xVo
         92R9axn/X4d2+chuAVlLtEyHQnRHVOWIHq9rsGLHgeNPxHZre/soI3OsCaMP9YBnjN8q
         8IZoZO+EPznFtlLOmbq8pxW0WP75RG64x/Hr5PCnjCPM39JrApDdjXxql8/Ls6cTAzde
         wAVU1pcp9sIisDwwghC36gynnUEy0rEIr59yO8XQXM+B/fkoWhuBQ6AjlfIleJFEvD3v
         CYHtgSkvOahueRW5KjhO/kdvwkNdaJdAHbJLcs/CGVgrbOkDy6Vo6OM/M40bl+HJDvwg
         rtSg==
X-Gm-Message-State: AOJu0YxaIKTVu87wWyAuGjTUKv6hGSWa8fH5RC9ouA2P1rDOGwOOqs/8
	e4xwrrgFzHovCoZkEpttYsg=
X-Google-Smtp-Source: AGHT+IEVAmegguGtfNHWli3NSVAd9B1FfQ+9wHqXSwq9t0bBPjvI+hoO179TRxj0kIglx8x1lsh1LQ==
X-Received: by 2002:a05:6870:1f16:b0:1fb:75b:99bd with SMTP id pd22-20020a0568701f1600b001fb075b99bdmr3526861oab.108.1701977417514;
        Thu, 07 Dec 2023 11:30:17 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-ca1f-53fd-59c8-8b84.res6.spectrum.com. [2603:8081:1405:679b:ca1f:53fd:59c8:8b84])
        by smtp.gmail.com with ESMTPSA id mp23-20020a056871329700b001fb634b546dsm92347oac.14.2023.12.07.11.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:30:16 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	rain.1986.08.12@gmail.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 2/7] RDMA/rxe: Fix sending of mcast packets
Date: Thu,  7 Dec 2023 13:29:03 -0600
Message-Id: <20231207192907.10113-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207192907.10113-1-rpearsonhpe@gmail.com>
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
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


