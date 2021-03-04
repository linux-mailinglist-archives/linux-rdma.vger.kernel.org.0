Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A54932DA54
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 20:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhCDTYf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 14:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhCDTYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Mar 2021 14:24:14 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871A6C061574
        for <linux-rdma@vger.kernel.org>; Thu,  4 Mar 2021 11:23:34 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id p6so6879168oot.2
        for <linux-rdma@vger.kernel.org>; Thu, 04 Mar 2021 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BeHSRxljtZ4ijzwjTRbSzPFt4juvQYsAEGcHokC31E=;
        b=n2Ls10yejC1X+ZscMusBp/jP0KhPhx9wVTS9CFDckwE1IQewwsHUlXrLR4GcMMiIQx
         UAddExJ1/8Hg5wFXEFR7IcbcuNtRsU/TQG9ZtR7H+Ok62avuGCPc0PFFd3jnWwPQe0eE
         R8iSHsMHGe/2b3qQnbZ581XBw7U3eeKAddlahJ7WrvtVqICDB34uiwWznIvqowkTr+63
         QwUOp/z9HW6gu4EnVNPtvoMv8hYUCEgj1sEeAhu8i0n2TT+Ys577JX/Dfjw5jYFv2/NG
         ehuHaP6NObIe410dise06hxAbS8th3cD8PyP5cOyxTbo8LnLBTdSB2dpyuHOrkGX3yda
         OMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BeHSRxljtZ4ijzwjTRbSzPFt4juvQYsAEGcHokC31E=;
        b=c83vX49DeRgNnqenwLL9HWwLV5AMrIH2iKJ+zKyeNGeUxmtjkJHvu5qHzuMicN3a7Q
         13XdoavIe0+gcxYQ5uo8+WuJCdlS8gjRw3zFvOCV1wR4cbg2RMC5nRltUD22J122GhPu
         rbLkZ9EYBrQPQ9AWx8W0LQSfEV9VlxnBDA1SXYBz0f8CZ5ulbD+kUyCFFPmGIM109nAe
         GI1kq8QeB9MmHtVlOdkZLlwi8IUMy1BPnuqFLkt0C271Y6hEXPSOszByBKts34wzYXnN
         5ja73zzi7N+KNZw7R3Y4bBSwqYfU37NfAgIRhfBpEXVMs/KsqH2hx58Rdgj+jXyBqcTb
         F3ow==
X-Gm-Message-State: AOAM533gQvu+hxZTsg18L2qZV80b3Y6edvMmtAN/Fxad3CpEzuxSUDLb
        XvPr15oELJYKVVtniMdB9qE=
X-Google-Smtp-Source: ABdhPJxV4w0uRo+J5CEJHFa0ecIux12MJm2bJ6qWqyAaF36zMyMDTFHJhWbpMqPPp7/ZeCYNQ9Kz2A==
X-Received: by 2002:a4a:2:: with SMTP id 2mr4553052ooh.12.1614885813847;
        Thu, 04 Mar 2021 11:23:33 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-e679-b501-499d-13c1.res6.spectrum.com. [2603:8081:140c:1a00:e679:b501:499d:13c1])
        by smtp.gmail.com with ESMTPSA id w7sm24934oie.7.2021.03.04.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 11:23:33 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3] RDMA/rxe: Fix ib_device reference counting (again)
Date:   Thu,  4 Mar 2021 13:20:49 -0600
Message-Id: <20210304192048.2958-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Bob Pearson <rpearsonhpe@gmail.com>

Three errors occurred in the fix referenced below.

1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
no error occurred causing an underflow on the reference counter.
This code is cleaned up to be clearer and easier to read.

2) Extending the reference taken by rxe_get_dev_from_net() in
rxe_udp_encap_recv() until each skb is freed was not matched by
a reference in the loopback path resulting in underflows.

3) In rxe_comp.c in rxe_completer() the function free_pkt() did
not clear skb which triggered a warning at done: and could possibly
at exit: . The WARN_ONCE() calls are not actually needed.
The call to free_pkt() is moved to the end to clearly show that
all skbs are freed.

This patch fixes these errors.

Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
Version 3:
V2 of this patch had spelling errors and style issues which are
fixed in this version.

Version 2:
v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
where it could be triggered for normal traffic. This version
replaced that with a pr_warn located correctly.

v1 of this patch placed a call to kfree_skb in an if statement
that could trigger style warnings. This version cleans that up.

 drivers/infiniband/sw/rxe/rxe_comp.c | 55 +++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
 drivers/infiniband/sw/rxe/rxe_recv.c | 59 +++++++++++++++++-----------
 3 files changed, 67 insertions(+), 57 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index a8ac791a1bb9..17a361b8dbb1 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -547,6 +547,7 @@ int rxe_completer(void *arg)
 	struct sk_buff *skb = NULL;
 	struct rxe_pkt_info *pkt = NULL;
 	enum comp_state state;
+	int ret = 0;
 
 	rxe_add_ref(qp);
 
@@ -554,7 +555,8 @@ int rxe_completer(void *arg)
 	    qp->req.state == QP_STATE_RESET) {
 		rxe_drain_resp_pkts(qp, qp->valid &&
 				    qp->req.state == QP_STATE_ERROR);
-		goto exit;
+		ret = -EAGAIN;
+		goto done;
 	}
 
 	if (qp->comp.timeout) {
@@ -564,8 +566,10 @@ int rxe_completer(void *arg)
 		qp->comp.timeout_retry = 0;
 	}
 
-	if (qp->req.need_retry)
-		goto exit;
+	if (qp->req.need_retry) {
+		ret = -EAGAIN;
+		goto done;
+	}
 
 	state = COMPST_GET_ACK;
 
@@ -636,8 +640,6 @@ int rxe_completer(void *arg)
 			break;
 
 		case COMPST_DONE:
-			if (pkt)
-				free_pkt(pkt);
 			goto done;
 
 		case COMPST_EXIT:
@@ -660,7 +662,8 @@ int rxe_completer(void *arg)
 			    qp->qp_timeout_jiffies)
 				mod_timer(&qp->retrans_timer,
 					  jiffies + qp->qp_timeout_jiffies);
-			goto exit;
+			ret = -EAGAIN;
+			goto done;
 
 		case COMPST_ERROR_RETRY:
 			/* we come here if the retry timer fired and we did
@@ -672,18 +675,18 @@ int rxe_completer(void *arg)
 			 */
 
 			/* there is nothing to retry in this case */
-			if (!wqe || (wqe->state == wqe_state_posted))
-				goto exit;
+			if (!wqe || (wqe->state == wqe_state_posted)) {
+				pr_warn("Retry attempted without a valid wqe\n");
+				ret = -EAGAIN;
+				goto done;
+			}
 
 			/* if we've started a retry, don't start another
 			 * retry sequence, unless this is a timeout.
 			 */
 			if (qp->comp.started_retry &&
-			    !qp->comp.timeout_retry) {
-				if (pkt)
-					free_pkt(pkt);
+			    !qp->comp.timeout_retry)
 				goto done;
-			}
 
 			if (qp->comp.retry_cnt > 0) {
 				if (qp->comp.retry_cnt != 7)
@@ -704,8 +707,6 @@ int rxe_completer(void *arg)
 					qp->comp.started_retry = 1;
 					rxe_run_task(&qp->req.task, 0);
 				}
-				if (pkt)
-					free_pkt(pkt);
 				goto done;
 
 			} else {
@@ -726,8 +727,8 @@ int rxe_completer(void *arg)
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
-				free_pkt(pkt);
-				goto exit;
+				ret = -EAGAIN;
+				goto done;
 			} else {
 				rxe_counter_inc(rxe,
 						RXE_CNT_RNR_RETRY_EXCEEDED);
@@ -740,25 +741,15 @@ int rxe_completer(void *arg)
 			WARN_ON_ONCE(wqe->status == IB_WC_SUCCESS);
 			do_complete(qp, wqe);
 			rxe_qp_error(qp);
-			if (pkt)
-				free_pkt(pkt);
-			goto exit;
+			ret = -EAGAIN;
+			goto done;
 		}
 	}
 
-exit:
-	/* we come here if we are done with processing and want the task to
-	 * exit from the loop calling us
-	 */
-	WARN_ON_ONCE(skb);
-	rxe_drop_ref(qp);
-	return -EAGAIN;
-
 done:
-	/* we come here if we have processed a packet we want the task to call
-	 * us again to see if there is anything else to do
-	 */
-	WARN_ON_ONCE(skb);
+	if (pkt)
+		free_pkt(pkt);
 	rxe_drop_ref(qp);
-	return 0;
+
+	return ret;
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
index 45d2f711bce2..7a49e27da23a 100644
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
 
@@ -266,39 +269,47 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
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
+	/* This only occurs if one of the checks fails on the last
+	 * QP in the list above
+	 */
+
+drop:
 	kfree_skb(skb);
 	ib_device_put(&rxe->ib_dev);
 }
-- 
2.27.0

