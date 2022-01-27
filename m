Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37649ED8B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbiA0ViT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbiA0ViN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCEC061749
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:13 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u129so8536321oib.4
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xcskru2ZEKc8psByd3UYRhdd+k0OhRhy/pBOrm7y3Do=;
        b=ClTmqVtEhibVEqVQRg2oOjnJOFa2jyKhAEvhCchPjfVRiwUS/xlYH7Oz8MkGkO6c2m
         rx7rvIDGX1pEWwNysW5nI4FfetN6qFP7ZmdQPYzoG2Sf/YTDfk3GJuKF3G0vzgpUF1cL
         WmPx3k6QWGkYJ1fllmae17vMhP9J41a6uARtPaevqRUFVmJXbhqtMRLi9gCRBWJ72ohl
         l+QCPc+zXYBG6QsASaUPzfSUwIy5MgR7QaOYAG4GCQmnuCDnOXawXeyh7vhFA7h/0Q9s
         5mqi6LUA6jWPodpZrulCaFrCmLrLLs+8eJse5BkfnHBXB1LPv/L9xPWXT2v2frXq4/f8
         pRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xcskru2ZEKc8psByd3UYRhdd+k0OhRhy/pBOrm7y3Do=;
        b=wHwblsPLn1GMt9cVw6/cVcRd8eYvC4M5bAhWhaP8c4hk21AUxkBMFWPNSh5XzoGobi
         kJZE4om+wvCpR6vOwlVyWUz1DPw1dB+gf75d7H5XVAMFvAX8NsWZiOt26fIoccRGkmGG
         araNvAxBQmqcZEqPdDVSVNsnubBmdLL7t3BbQ41Np1amJYLvXmilMmI7E8rhM187PM12
         Kuh5JUSy6ciZAHdPiDiJJUTnHiWkNoOgCQwhA0WQuCx8y7kM8v23mUj8Vp58y3g5oPtO
         ORtF3e3yUl/DjI5swDZKCFlf/cvvnE7Hrda62nNrKMFuFSQ9oL+8RlSpWUIYZoFqAWVa
         fKew==
X-Gm-Message-State: AOAM532WK5E47xrc2ihpQr9hHnYG58cQEMFEgrlA5OqwQY6MTnqPthVz
        aTYFvyueMkk21RmiclHPALUuZYKsXDk=
X-Google-Smtp-Source: ABdhPJy2EDdTEhQxLKDPDtyaBpKGHzPxoS3eRAGUR2zeqpG1Il2Oh07PoSf72qQRU8WdYP7KttEe7A==
X-Received: by 2002:a05:6808:1645:: with SMTP id az5mr6707957oib.313.1643319492711;
        Thu, 27 Jan 2022 13:38:12 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:12 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 10/26] RDMA/rxe: Split rxe_rcv_mcast_pkt into two phases
Date:   Thu, 27 Jan 2022 15:37:39 -0600
Message-Id: <20220127213755.31697-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe_rcv_mcast_pkt performs most of its work under the
mcg->mcg_lock and calls into rxe_rcv which queues the packets
to the responder and completer tasklets holding the lock which is
a very bad idea. This patch walks the qp_list in mcg and copies the
qp addresses to a dynamically allocated array under the lock but
does the rest of the work without holding the lock. The critical
section is now very small.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 11 +++++----
 drivers/infiniband/sw/rxe/rxe_recv.c  | 33 +++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index ed1b9ca65da3..3b66019fc26d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -113,16 +113,16 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		}
 	}
 
-	if (mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (atomic_read(&mcg->qp_num) >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	mcg->num_qp++;
+	atomic_inc(&mcg->qp_num);
 	new_mca->qp = qp;
 	atomic_inc(&qp->mcg_num);
 
-	list_add(&new_mca->qp_list, &mcg->qp_list);
+	list_add_tail(&new_mca->qp_list, &mcg->qp_list);
 
 	err = 0;
 out:
@@ -135,6 +135,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 {
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca, *tmp;
+	int n;
 
 	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
 	if (!mcg)
@@ -145,8 +146,8 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			list_del(&mca->qp_list);
-			mcg->num_qp--;
-			if (mcg->num_qp <= 0)
+			n = atomic_dec_return(&mcg->qp_num);
+			if (n <= 0)
 				rxe_drop_ref(mcg);
 			atomic_dec(&qp->mcg_num);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 10020103ea4a..41571c6b7d98 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -229,6 +229,11 @@ static inline void rxe_rcv_pkt(struct sk_buff *skb)
 		rxe_comp_queue_pkt(RXECB(skb)->qp, skb);
 }
 
+/* split processing of the qp list into two stages.
+ * first just make a simple linear array from the
+ * current list while holding the lock and then
+ * process each qp without holding the lock.
+ */
 static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 {
 	struct sk_buff *s;
@@ -237,7 +242,9 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 	struct rxe_mcg *mcg;
 	struct rxe_mca *mca;
 	struct rxe_qp *qp;
+	struct rxe_qp **qp_array;
 	union ib_gid dgid;
+	int n, nmax;
 	int err;
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -251,15 +258,31 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 	if (!mcg)
 		goto drop;	/* mcast group not registered */
 
+	/* this is the current number of qp's attached to mcg plus a
+	 * little room in case new qp's are attached. It isn't wrong
+	 * to miss some qp's since it is just a matter of precisely
+	 * when the packet is assumed to be received.
+	 */
+	nmax = atomic_read(&mcg->qp_num) + 2;
+	qp_array = kmalloc_array(nmax, sizeof(qp), GFP_KERNEL);
+
+	n = 0;
 	spin_lock_bh(&mcg->mcg_lock);
+	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
+		qp_array[n++] = mca->qp;
+		if (n == nmax)
+			break;
+	}
+	spin_unlock_bh(&mcg->mcg_lock);
+	nmax = n;
 
 	/* this is unreliable datagram service so we let
 	 * failures to deliver a multicast packet to a
 	 * single QP happen and just move on and try
 	 * the rest of them on the list
 	 */
-	list_for_each_entry(mca, &mcg->qp_list, qp_list) {
-		qp = mca->qp;
+	for (n = 0; n < nmax; n++) {
+		qp = qp_array[n];
 
 		/* validate qp for incoming packet */
 		err = check_type_state(rxe, pkt, qp);
@@ -274,8 +297,8 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 		 * skb and pass to the QP. Pass the original skb to
 		 * the last QP in the list.
 		 */
-		if (mca->qp_list.next != &mcg->qp_list) {
-			s = skb_clone(skb, GFP_ATOMIC);
+		if (n < nmax - 1) {
+			s = skb_clone(skb, GFP_KERNEL);
 			if (unlikely(!s))
 				continue;
 
@@ -295,7 +318,7 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 		}
 	}
 
-	spin_unlock_bh(&mcg->mcg_lock);
+	kfree(qp_array);
 
 	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 02745d51c163..d65c358798c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -356,8 +356,8 @@ struct rxe_mcg {
 	spinlock_t		mcg_lock; /* guard group */
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
+	atomic_t		qp_num;
 	union ib_gid		mgid;
-	int			num_qp;
 	u32			qkey;
 	u16			pkey;
 };
-- 
2.32.0

