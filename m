Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5B4C1F5F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiBWXIR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244718AbiBWXIO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:14 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26593584B
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:45 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id j2so658960oie.7
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHH2kN1qaHun2fFYMfE2C2Cg4rCPKgUgoK974Y7RcTA=;
        b=qXnwgm/RpwyzOWfRd3zY57PfA31hZkmSUdWO4AWtMJia4D71YceeNjh0veA2VPhwu9
         e6LX1jlCDKzx/S4L/MoIoiUV7ttbiID3CF+dauHAGEa1abbX/5EXLAVkMq5VTybpWE3z
         TkhN7jlRhsoU6k80ycSEuLFpjMcB3NLqTTwbu1RZL2vWenHbexQDIbs3xAn1I2M6Wxtq
         4BLMrm6Hw+aPMfCxqQldCwWD1QcUYZ9qF3Ov3TSZObcjPvt1DZwPyse0guMThsabs4cE
         FMw38fCatumLcDN5+oUykoY4Y59o6KMrMV4RehBY9qq3nUizo8l/klCPFGedMnnUZ/4t
         iyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHH2kN1qaHun2fFYMfE2C2Cg4rCPKgUgoK974Y7RcTA=;
        b=ft7/fhb1sF4B2+u4xdpcIBVhIZk84dpL+2ahp1v6tt0ETziALVUUOMqPhBaP7fQHwF
         Hel32tT0x9/kRj4HZ6yrLTuX6S0y2EkLsMR/95z+6De0agetpTGoRO/pZVfdzs5FRLTh
         jxcrWuFss2T595c1u4Z8Ukqq+Tnweui3j7Cj9JG4ZVHPDhTMYzbmIpNOrGkQt2KfVDGM
         liG8Kl/9SopsYvYZzlYEdYZuGHR9o1BEVUPmcGrqInWjpbhjsHSCsUY7C4IbV+D/mSeq
         AVnjEHzPQaCTpGWUm4oQY2E35uONAD54b5huMrnkuCPgNfynzyNd2JbOhD4/keA5olMC
         5LAg==
X-Gm-Message-State: AOAM530RoQycW9pXkzCLfBHhLjfDEhv2ov653DstI4DcNNoNitXAGHat
        xWQPrqCws/LT/E9JhOPnoJ8=
X-Google-Smtp-Source: ABdhPJwHFruClfEptYvG8sU/Qgd1nxvBTNnTUwNuogeYbViIoLpZlXEgt8qcmg5Nne8zZG6EQizxVg==
X-Received: by 2002:a05:6808:118e:b0:2d4:6fe7:6bd7 with SMTP id j14-20020a056808118e00b002d46fe76bd7mr1087468oil.146.1645657665256;
        Wed, 23 Feb 2022 15:07:45 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v13 for-next 5/6] RDMA/rxe: For mcast copy qp list to temp array
Date:   Wed, 23 Feb 2022 17:07:07 -0600
Message-Id: <20220223230706.50332-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
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

