Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009E306A29
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 02:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhA1BQg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jan 2021 20:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhA1BNS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jan 2021 20:13:18 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CF2C061756
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 17:12:38 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id q6so1036316ooo.8
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jan 2021 17:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKIQdyCHzwAbxrs2xjiN89vjSl17371ompTtgGy/hjc=;
        b=Tc8Y2OMwU3MqF66uouGBp3vShZfbvE/HKa3qGlI2Gu2omGc9T8A1ERNRP23jld1aov
         AAoY5BFqk6R+QVgBcskLYIAlndjrdsfVbRTWL0uLTm5SkpTqZXRT8zpBgQ3jlswanFRN
         /dHQ90rKWjOlqUom3qbjHDhT9Yh73OkBRx85EWG/CZ4eYaV9zF6OvPkcKDY7U4wxEGSb
         yYSX09tRtN/0/MUpGAMW9TPsShOZzFP1Bb9pNcvJtiuB/wGKFk4wh7WCttnsUKvSwp9+
         dfR4JfE0fVf25IYEEQ+oMTcRUKDtons3pV5yH4kLw5gTJg9gBiZdZASv+QzE1Uob/1xq
         RVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nKIQdyCHzwAbxrs2xjiN89vjSl17371ompTtgGy/hjc=;
        b=S/sA1ndjqLO1aXhrc6eT/EBH7h0cG4z6PxpM3nWVFLZ3WRAcMF624fYBi+LEa5NduH
         eyEvX8iHHp+vWSWXDsdv8aXBljwxBd0s/7TwxwcUHkV8fzORRG8OBWt0GKq7Xb9/mvPj
         0ETmH9u7B8yYdxJnM73sbRF4+QakM0uMSo9vDeL9nY1ir3LlXzYfCkYFM64lgoV9Mxwk
         T/oYkWOYkcojT9MM4M0u8WnLXzHKroADaK55r6aLnyq8mPWMB5KwtEZAAp5/h2JzfeAK
         Y//XgID8bllPvalMyPp6qZbnmVJCIONhATNA2EPlUvARaHV2vyh9zXkA7BFegLEszqea
         eD2A==
X-Gm-Message-State: AOAM531ffHB6eirxN1s3VwvDQ6SZ6Qljb+poRVqi8xKR5KzRT5xDkSRj
        g3mHFceGnmJ1DkFCkAxYWqw=
X-Google-Smtp-Source: ABdhPJy/t5eeHmkMs40nNxT4Wm0+eF1GMHv+B+nVSPFWASBMazM6UjE6IIKKfjNVI8DU2DsqQzjwnA==
X-Received: by 2002:a4a:3b4f:: with SMTP id s76mr9588830oos.29.1611796357418;
        Wed, 27 Jan 2021 17:12:37 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-0c9b-9470-e600-0722.res6.spectrum.com. [2603:8081:140c:1a00:c9b:9470:e600:722])
        by smtp.gmail.com with ESMTPSA id d9sm693664otb.65.2021.01.27.17.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 17:12:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_rcv_mcast_pkt
Date:   Wed, 27 Jan 2021 19:12:27 -0600
Message-Id: <20210128011226.3096-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_rcv_mcast_pkt() in rxe_recv.c can leak SKBs in error path
code. The loop over the QPs attached to a multicast group
creates new cloned SKBs for all but the last QP in the list
and passes the SKB and its clones to rxe_rcv_pkt() for further
processing. Any QPs that do not pass some checks are skipped.
If the last QP in the list fails the tests the SKB is leaked.
This patch checks if the SKB for the last QP was used and if
not frees it. Also removes a redundant loop invariant assignment.

Fixes: 8700e3e7c4857 ("Soft RoCE driver")
Fixes: 71abf20b28ff8 ("RDMA/rxe: Handle skb_clone() failure in rxe_recv.c")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index c9984a28eecc..57cc25e3b4ad 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -252,7 +252,6 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	list_for_each_entry(mce, &mcg->qp_list, qp_list) {
 		qp = mce->qp;
-		pkt = SKB_TO_PKT(skb);
 
 		/* validate qp for incoming packet */
 		err = check_type_state(rxe, pkt, qp);
@@ -264,12 +263,18 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 			continue;
 
 		/* for all but the last qp create a new clone of the
-		 * skb and pass to the qp.
+		 * skb and pass to the qp. If an error occurs in the
+		 * checks for the last qp in the list we need to
+		 * free the skb since it hasn't been passed on to
+		 * rxe_rcv_pkt() which would free it later.
 		 */
-		if (mce->qp_list.next != &mcg->qp_list)
+		if (mce->qp_list.next != &mcg->qp_list) {
 			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
-		else
+		} else {
 			per_qp_skb = skb;
+			/* show we have consumed the skb */
+			skb = NULL;
+		}
 
 		if (unlikely(!per_qp_skb))
 			continue;
@@ -284,10 +289,9 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
 
-	return;
-
 err1:
-	kfree_skb(skb);
+	if (skb)
+		kfree_skb(skb);
 }
 
 /**
-- 
2.27.0

