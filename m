Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA037E0A73
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjKCUoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 16:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCUoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 16:44:06 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056ACA2
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 13:44:03 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581de3e691dso1191313eaf.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Nov 2023 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044240; x=1699649040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI9XD96G3rYBhxmVpBLEJlvEkcRwwcRbcBDXTTzKEj8=;
        b=esJzcmQPVSUuXqiwhFncT9ea7tME7c/1rCcuLdudhEXe/GBf9nGkh7fjctf2+8hY+r
         +I4ACtZIlyRBhd+sO+wo73cgJohHPKDq2flKTLtCzrGp1VbSL3U4SLI2BnkRf3s+/3QW
         yZa5Dad79mqYa3J/F3XX8HpXR5c/6roHlj8ci95hVIwsiUgd9LUjUPlwDNroMo9kbzrJ
         6bCSS3izlCu+AoWTYEXacM97wS7LrpoKbO2k2kYsmj6SQO0eCKFm2kSR6OhVR6zl4G2E
         yxoZ+c8qd2phbHc36WE6U5kLJCOR4JR0zj7G+G5KERhbXiLCLOQVhVQ/csqvqzwz3/PW
         Wucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044240; x=1699649040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI9XD96G3rYBhxmVpBLEJlvEkcRwwcRbcBDXTTzKEj8=;
        b=F8+dcj4yHbmngaH9ENCbca+7CLPh7JKhS/5mryuvpxtZJavhNxNsxTsXb8xut+rdLw
         dS5Kpb1AmV+hPwtE36XRWuF4Hqd4f7gKby7BtVJDlgDO2HXtkgA+Btz4/lJDdASsitfY
         /1cGZUWN5UNzEZBWBIvT1lGWO5IEblLRz9s/qJF0tMdG58OYddW4nPc4DkRGlcL/IJxV
         0UzVSb6VAI+VvZwQLGhAgsYvlGjw+FUh0/o0EUQIig4jke51LqK3b2us127DDkfp/yQr
         6fqUjUArYN6pFIFnEW4BsDoeiUzHNt3Zy24b5lvaSy4nF4dpuTJVNUIMnAFKpuYyPeuP
         C63w==
X-Gm-Message-State: AOJu0YwGE9LO9j5AnopbTDM3Z8UPQsBj00zrt4AG3PCdj298VxLqSzRx
        DJACzz4deO9oHGknBfuHTlc=
X-Google-Smtp-Source: AGHT+IHNi7BEeoLKz9xWjMsgqOqWlLtKIEudka1XTJCd7KEDkYsJMGEW7mA8vUjbiBpc49lgqSZsHw==
X-Received: by 2002:a4a:c884:0:b0:586:881d:ea25 with SMTP id t4-20020a4ac884000000b00586881dea25mr23279524ooq.6.1699044240312;
        Fri, 03 Nov 2023 13:44:00 -0700 (PDT)
Received: from bob-3900x.lan (2603-8081-1405-679b-6bc0-11b9-c519-2c18.res6.spectrum.com. [2603:8081:1405:679b:6bc0:11b9:c519:2c18])
        by smtp.gmail.com with ESMTPSA id v9-20020a4ae049000000b00581e5b78ce5sm447766oos.38.2023.11.03.13.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:43:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/6] RDMA/rxe: Handle loopback of mcast packets
Date:   Fri,  3 Nov 2023 15:43:21 -0500
Message-Id: <20231103204324.9606-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231103204324.9606-1-rpearsonhpe@gmail.com>
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
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

Add a mask bit to indicate that a multicast packet has been locally
sent and use to set the correct qpn for multicast packets.

Add code to rxe_xmit_packet() to correctly handle multicast packets
which must be sent on the wire and also duplicated to any local qps
which may belong the multicast group, but not including the sender.

Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c     |  7 +++++++
 drivers/infiniband/sw/rxe/rxe_loc.h    |  1 +
 drivers/infiniband/sw/rxe/rxe_net.c    | 25 ++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c   |  4 ++++
 drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++++++--
 6 files changed, 46 insertions(+), 4 deletions(-)

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
index cd59666158b1..2fad56fc95e7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -412,6 +412,27 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	return 0;
 }
 
+/* for a multicast packet must send remotely and looback to any local qps
+ * that may belong to the mcast group
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
@@ -431,7 +452,9 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
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

