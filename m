Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466F332C3CA
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 01:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhCCX7p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Mar 2021 18:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCCXC5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Mar 2021 18:02:57 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECADC061756
        for <linux-rdma@vger.kernel.org>; Wed,  3 Mar 2021 15:02:13 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d9so25304872ote.12
        for <linux-rdma@vger.kernel.org>; Wed, 03 Mar 2021 15:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5WYOcU6TziDLlNIm+VhLKSogzxNrmqNnllIcQDH2j6s=;
        b=jPM1JBCGH7/I+AoBeVXLIvAEU3uDsY0K5GJHtxiY/ne10QuZvm/bw4uIV8B4hQzx0J
         BDIwEnsAGky2hyJ5DFu1h84seZ8UuD7k5ZXNPqJxSJDKX2Maj5lxxIi5WCbF3KH9ItKR
         X4bcVOyZzn5cRnAuLMsIFxYyY4Bs5/RVzXZVyBqhQfWzZi+ZZmrYGR84kQj9gy6V7v3p
         7wu/OTMgnfwhOFtynPoWiyOS8SV2kgNUgj09UPBS1b+l0YwUntXFkusREtzi9GbeqVVm
         U7Rmdb/FK/iSWdOU44oNqPVMdQvO5W6aw4j3H1Kk+CZJu65x2HbXiBnuXqN6H4Q8LoQl
         sR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5WYOcU6TziDLlNIm+VhLKSogzxNrmqNnllIcQDH2j6s=;
        b=kNusUQU0yb93NHgKgB9hVCUy4CdgFF+sIPS/eU6afefMw76WKW51svIl5hMp/2hImZ
         UIZosQ0NPxvEBKGakTXTy0nqvmc5aQ3LuHRBBa2sL1HfS5VXqKJUFHahYeGqBvfy59rn
         +XSLxQ6sSIRoD9kTswFYxyx+zvRfJ8bx1vwQiSyWTfBPw+O2H80tt0mmpGE/+BKoh9QL
         h//aa6BGXQenhKSo7OZMGJVz3USqQ73vJ7OL/PEIaUnYLW1kvRHVyOxmnrKZCPYa2tq3
         w67iZC0LKa7K8OlN1U2SSHt94OQ/c5P5+hxgDC+4g/8QGyN5xkLttSMFUsAnryEJ3/tO
         Im1w==
X-Gm-Message-State: AOAM533DCCxziBcm4iLdhSL/JaPBvh52iL8j6PTw93HyjGr0CvzisVsE
        M1hY80aE4VivAX4rR7fTPHE=
X-Google-Smtp-Source: ABdhPJxzl/lJnVrVzvMMrm3mCqVzD/AGBHRb4Pddzc93PUIngGRVloo5k9ti6RN4Oau0Fr2IT+Aeaw==
X-Received: by 2002:a9d:3ec9:: with SMTP id b67mr23570otc.168.1614812532425;
        Wed, 03 Mar 2021 15:02:12 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8884-260e-7805-4030.res6.spectrum.com. [2603:8081:140c:1a00:8884:260e:7805:4030])
        by smtp.gmail.com with ESMTPSA id f189sm1118840oia.44.2021.03.03.15.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 15:02:10 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix ib_device reference counting (again)
Date:   Wed,  3 Mar 2021 16:56:29 -0600
Message-Id: <20210303225628.2836-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Three errors occurred in the fix referenced below.

1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
no error occured causing an underflow on the reference counter.
This code is cleaned up to be clearer and easier to read.

2) Extending the reference taken by rxe_get_dev_from_net() in
rxe_udp_encap_recv() until each skb is freed was not matched by
a reference in the loopback path resulting in underflows.

3) In rxe_comp.c the function free_pkt() did not clear skb which
triggered a warning at done: and could possibly at exit: in
rxe_completer(). The WARN_ONCE() calls are not actually needed.

This patch fixes these errors.

Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
Version 2:
v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
where it could be triggered for normal traffic. This version
replaced that with a pr_warn located correctly.

v1 of this patch placed a call to kfree_skb in an if statement
that could trigger style warnings. This version cleans that up.

 drivers/infiniband/sw/rxe/rxe_comp.c |  6 +--
 drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
 drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a8ac791a1bb9..96e5a73579f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -672,8 +672,10 @@ int rxe_completer(void *arg)
 			 */
 
 			/* there is nothing to retry in this case */
-			if (!wqe || (wqe->state == wqe_state_posted))
+			if (!wqe || (wqe->state == wqe_state_posted)) {
+				pr_warn("Retry attempted without a valid wqe\n");
 				goto exit;
+			}
 
 			/* if we've started a retry, don't start another
 			 * retry sequence, unless this is a timeout.
@@ -750,7 +752,6 @@ int rxe_completer(void *arg)
 	/* we come here if we are done with processing and want the task to
 	 * exit from the loop calling us
 	 */
-	WARN_ON_ONCE(skb);
 	rxe_drop_ref(qp);
 	return -EAGAIN;
 
@@ -758,7 +759,6 @@ int rxe_completer(void *arg)
 	/* we come here if we have processed a packet we want the task to call
 	 * us again to see if there is anything else to do
 	 */
-	WARN_ON_ONCE(skb);
 	rxe_drop_ref(qp);
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0701bd1ffd1a..01662727dca0 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -407,14 +407,22 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	return 0;
 }
 
+/* fix up a send packet to match the packets
+ * received from UDP before looping them back
+ */
 void rxe_loopback(struct sk_buff *skb)
 {
+	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
 		skb_pull(skb, sizeof(struct ipv6hdr));
 
-	rxe_rcv(skb);
+	if (WARN_ON(!ib_device_try_get(&pkt->rxe->ib_dev)))
+		kfree_skb(skb);
+	else
+		rxe_rcv(skb);
 }
 
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 45d2f711bce2..2b2465744896 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -237,8 +237,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	struct rxe_mc_elem *mce;
 	struct rxe_qp *qp;
 	union ib_gid dgid;
-	struct sk_buff *per_qp_skb;
-	struct rxe_pkt_info *per_qp_pkt;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -250,10 +248,15 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	/* lookup mcast group corresponding to mgid, takes a ref */
 	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
 	if (!mcg)
-		goto err1;	/* mcast group not registered */
+		goto drop;	/* mcast group not registered */
 
 	spin_lock_bh(&mcg->mcg_lock);
 
+	/* this is unreliable datagram service so we let
+	 * failures to deliver a multicast packet to a
+	 * single QP happen and just move on and try
+	 * the rest of them on the list
+	 */
 	list_for_each_entry(mce, &mcg->qp_list, qp_list) {
 		qp = mce->qp;
 
@@ -266,39 +269,48 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		if (err)
 			continue;
 
-		/* for all but the last qp create a new clone of the
-		 * skb and pass to the qp. If an error occurs in the
-		 * checks for the last qp in the list we need to
-		 * free the skb since it hasn't been passed on to
-		 * rxe_rcv_pkt() which would free it later.
+		/* for all but the last QP create a new clone of the
+		 * skb and pass to the QP. Pass the original skb to
+		 * the last QP in the list.
 		 */
 		if (mce->qp_list.next != &mcg->qp_list) {
-			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
-				kfree_skb(per_qp_skb);
+			struct sk_buff *cskb;
+			struct rxe_pkt_info *cpkt;
+
+			cskb = skb_clone(skb, GFP_ATOMIC);
+			if (unlikely(!cskb))
 				continue;
+
+			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
+				kfree_skb(cskb);
+				break;
 			}
+
+			cpkt = SKB_TO_PKT(cskb);
+			cpkt->qp = qp;
+			rxe_add_ref(qp);
+			rxe_rcv_pkt(cpkt, cskb);
 		} else {
-			per_qp_skb = skb;
-			/* show we have consumed the skb */
-			skb = NULL;
+			pkt->qp = qp;
+			rxe_add_ref(qp);
+			rxe_rcv_pkt(pkt, skb);
+			skb = NULL;	/* mark consumed */
 		}
-
-		if (unlikely(!per_qp_skb))
-			continue;
-
-		per_qp_pkt = SKB_TO_PKT(per_qp_skb);
-		per_qp_pkt->qp = qp;
-		rxe_add_ref(qp);
-		rxe_rcv_pkt(per_qp_pkt, per_qp_skb);
 	}
 
 	spin_unlock_bh(&mcg->mcg_lock);
 
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
 
-err1:
-	/* free skb if not consumed */
+	if (likely(!skb))
+		return;
+
+	/* Fall through to drop packet
+	 * This only occurs if one of the checks fails on the last
+	 * QP in the list above
+	 */
+
+drop:
 	kfree_skb(skb);
 	ib_device_put(&rxe->ib_dev);
 }
-- 
2.27.0

