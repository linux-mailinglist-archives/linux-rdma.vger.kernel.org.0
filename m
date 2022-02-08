Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5004AE3F9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386349AbiBHWZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386886AbiBHVRZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:25 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683F7C0612BA
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:24 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso145329oop.9
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHH2kN1qaHun2fFYMfE2C2Cg4rCPKgUgoK974Y7RcTA=;
        b=ilIuoh611GNfpBpnQeZoqJWrPVcnoGpW2gsQXAdeK1RcEGLp8QKiCMg73lkMLSLj6e
         TD7EdF7EK5rY/B3efwNPY/1HHcAP9dxA//uLQLgYn9fYA+47VqvUarc7LpiGOSGc8BDJ
         JLmreTJSUu9UZ7l2o8MLrSZVIGyqnFnHNvIAe5uaDICbu6ikSU5edsXG9f58pULFE+iW
         V2gYUuhg30HNgd05/rAP/gKrvDSB6nyIYzQN+hylgebgo8iJiQ0zFleAmmBK06o96DNZ
         Yj4QD247dH+LUpTivc++88TNhI9w2Aa352ZvgCKtKOo79hZyOxqEAzTpXt62q/YqLCho
         pYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHH2kN1qaHun2fFYMfE2C2Cg4rCPKgUgoK974Y7RcTA=;
        b=5Bo+L3MeOcQ93yP3cIVccbFBqUXlSvKEONp4yFU6SG8ws+WGjES+UZ+vDtmXtm/fQ2
         lqr9vHu2my9EFBdBD4w5dDms+j205I/iyFk1gN0mT0U55Oj4stQ46zyqQsiN6mgznavK
         4E2UiKNVEqUW/J+JfBWo4QoLDXA/RwxwMEf1A+vnVeIrw2H4tqYIyCbpL/F4ZJlw6W0m
         RutWysnmxjTt5OunzYyyxKhvUaYyrqed8X5aG+RtAynEUl2bIt/055zkvCeImVtGpDd4
         7r+4dEW/ULoLEt2Gp0gy74oW/LFyD6/GysIwfy/mFDcCuEvLqmZxmxXS9smXYXzZbGom
         e7Og==
X-Gm-Message-State: AOAM530FFVVfyIXi/r/LA+xCtFfK981LgUdEnHPEL4wXBmcW+y0oMcwx
        KdnJK9PKJkhi7r4XdJCZevFvP6BrXQg=
X-Google-Smtp-Source: ABdhPJxENCU/6oNJQtq0/Pj7n1bi16vQEIz8j2lLV0Qyn1XRioWUZeY58eb88Yo2sgxlBUqL6QR9PQ==
X-Received: by 2002:a05:6870:91c5:: with SMTP id c5mr980251oaf.203.1644355043786;
        Tue, 08 Feb 2022 13:17:23 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:23 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 10/11] RDMA/rxe: For mcast copy qp list to temp array
Date:   Tue,  8 Feb 2022 15:16:44 -0600
Message-Id: <20220208211644.123457-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208211644.123457-1-rpearsonhpe@gmail.com>
References: <20220208211644.123457-1-rpearsonhpe@gmail.com>
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

