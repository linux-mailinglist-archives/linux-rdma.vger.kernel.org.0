Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539854BAE9E
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiBRAhF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:37:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiBRAhE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:37:04 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107743121E
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:45 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v25so1431958oiv.2
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHH2kN1qaHun2fFYMfE2C2Cg4rCPKgUgoK974Y7RcTA=;
        b=ob0eht6Ax3rIuGVbh+3jZSXuqTwhmPwKYowK4scHDgE+hAK4CcD5DelsJbKosckwE1
         9GUK3EKw/mIzGOA6P8uXS5e8v4HqXVJnDSnbSPtawty1XNF93QlFRwfKhr/35ol7JJNc
         e/xn57EV37YXSD0VItXc0OpnbH9NW8/MHltnvf+imzhh4WK9jZYFMHP1jWqd/LooWH6P
         vykBeNdvtiiotZY5cK4HKUTnziQzVYW8AqXRHeJ+nswglZ0WFjzGyRjfTfdyon71dYlL
         FatJFcx619ciD59wJjnz3SPSEvXobP2nAgCmJcuRmllE3un2N6ZtIcewzOiSa2s95z45
         FIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHH2kN1qaHun2fFYMfE2C2Cg4rCPKgUgoK974Y7RcTA=;
        b=YswVqrJfXczhvWrnd6lxwIeR+5CWTq9kCFH+bAIGxsutuRJ7NBsXaeFjEgXqEviyWa
         fj7aAtpiq4CsCKPcFRq0P/o6qi+/K0g6I0EX/xvjHMoJVHTdnb9bbtqFkl3R6kEcT7PC
         ES43BUB+3bgYibetZd06URalleLutF7fFjYKunI38IMMNA8g5Uq1Le4y//UhNBvo8cVp
         VW66ARj2PQm58NMR+n6JuyV4I3HPxBjrtRXWjmP3EjfnEM9Zl/ho6oczgoojcyKRLvHG
         ewxJDZXVAnchTUubFip50Lc1V8fsGmr04XtM4JaQwRf1/tmtkM3RiLyWnTvzlfxukU87
         VVNA==
X-Gm-Message-State: AOAM533xPXG9RSvqmTsVjnXwNUD7F6Gst1jL+UGjUeDOsuZ7yCvAiTO7
        DfLTvQI/TkZvh1lgBpEf3vCYu4k5V7M=
X-Google-Smtp-Source: ABdhPJzBym5ObBoZEe1dEIkG4sz8M5e9Wxays/vGZxPchv6Mm5RoC6J8L7pkajpDeaapCsz4NCm18A==
X-Received: by 2002:a05:6808:1926:b0:2ce:6a75:b7f2 with SMTP id bf38-20020a056808192600b002ce6a75b7f2mr2332288oib.185.1645144604345;
        Thu, 17 Feb 2022 16:36:44 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 5/6] RDMA/rxe: For mcast copy qp list to temp array
Date:   Thu, 17 Feb 2022 18:35:43 -0600
Message-Id: <20220218003543.205799-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218003543.205799-1-rpearsonhpe@gmail.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe_rcv_mcast_pkt performs most of its work under the
rxe->mcg_lock and calls into rxe_rcv which queues the packets
to the responder and completer tasklets holding the lock which is
a very bad idea. This patch walks the qp_list in mcg and copies the
qp addresses to a temporary array under the lock but does the rest
of the work without holding the lock. The critical section is now
very small.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 103 +++++++++++++++++----------
 1 file changed, 64 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 53924453abef..9b21cbb22602 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -232,11 +232,15 @@ static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 
 static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 {
+	struct sk_buff *skb_copy;
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
+	struct rxe_pkt_info *pkt_copy;
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca;
 	struct rxe_qp *qp;
+	struct rxe_qp **qp_array;
 	union ib_gid dgid;
+	int n, nmax;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -248,68 +252,89 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 	/* lookup mcast group corresponding to mgid, takes a ref */
 	mcg = rxe_lookup_mcg(rxe, &dgid);
 	if (!mcg)
-		goto drop;	/* mcast group not registered */
+		goto err_drop;	/* mcast group not registered */
+
+	/* this is the current number of qp's attached to mcg plus a
+	 * little room in case new qp's are attached between here
+	 * and when we finish walking the qp list. If someone can
+	 * attach more than 4 new qp's we will miss forwarding
+	 * packets to those qp's. This is actually OK since UD is
+	 * a unreliable service.
+	 */
+	nmax = atomic_read(&mcg->qp_num) + 4;
+	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
+	n = 0;
 
 	spin_lock_bh(&rxe->mcg_lock);
-
-	/* this is unreliable datagram service so we let
-	 * failures to deliver a multicast packet to a
-	 * single QP happen and just move on and try
-	 * the rest of them on the list
-	 */
 	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
-		qp = mca->qp;
+		/* protect the qp pointers in the list */
+		rxe_add_ref(mca->qp);
+		qp_array[n++] = mca->qp;
+		if (n == nmax)
+			break;
+	}
+	spin_unlock_bh(&rxe->mcg_lock);
+	nmax = n;
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
 
-		/* validate qp for incoming packet */
+	for (n = 0; n < nmax; n++) {
+		qp = qp_array[n];
+
+		/* since this is an unreliable transport if
+		 * one of the qp's fails to pass these checks
+		 * just don't forward a packet and continue
+		 * on to the other qp's. If there aren't any
+		 * drop the skb
+		 */
 		err = check_type_state(rxe, pkt, qp);
-		if (err)
+		if (err) {
+			rxe_drop_ref(qp);
+			if (n == nmax - 1)
+				goto err_free;
 			continue;
+		}
 
 		err = check_keys(rxe, pkt, bth_qpn(pkt), qp);
-		if (err)
+		if (err) {
+			rxe_drop_ref(qp);
+			if (n == nmax - 1)
+				goto err_free;
 			continue;
+		}
 
-		/* for all but the last QP create a new clone of the
-		 * skb and pass to the QP. Pass the original skb to
-		 * the last QP in the list.
+		/* for all but the last qp create a new copy(clone)
+		 * of the skb and pass to the qp. Pass the original
+		 * skb to the last qp in the list unless it failed
+		 * checks above
 		 */
-		if (mca->qp_list.next != &mcg->qp_list) {
-			struct sk_buff *cskb;
-			struct rxe_pkt_info *cpkt;
-
-			cskb = skb_clone(skb, GFP_ATOMIC);
-			if (unlikely(!cskb))
+		if (n < nmax - 1) {
+			skb_copy = skb_clone(skb, GFP_KERNEL);
+			if (unlikely(!skb_copy)) {
+				rxe_drop_ref(qp);
 				continue;
+			}
 
 			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
-				kfree_skb(cskb);
-				break;
+				kfree_skb(skb_copy);
+				rxe_drop_ref(qp);
+				continue;
 			}
 
-			cpkt = SKB_TO_PKT(cskb);
-			cpkt->qp = qp;
-			rxe_add_ref(qp);
-			rxe_rcv_pkt(cpkt, cskb);
+			pkt_copy = SKB_TO_PKT(skb_copy);
+			pkt_copy->qp = qp;
+			rxe_rcv_pkt(pkt_copy, skb_copy);
 		} else {
 			pkt->qp = qp;
-			rxe_add_ref(qp);
 			rxe_rcv_pkt(pkt, skb);
-			skb = NULL;	/* mark consumed */
 		}
 	}
 
-	spin_unlock_bh(&rxe->mcg_lock);
-
-	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-
-	if (likely(!skb))
-		return;
-
-	/* This only occurs if one of the checks fails on the last
-	 * QP in the list above
-	 */
+	kfree(qp_array);
+	return;
 
-drop:
+err_free:
+	kfree(qp_array);
+err_drop:
 	kfree_skb(skb);
 	ib_device_put(&rxe->ib_dev);
 }
-- 
2.32.0

