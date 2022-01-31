Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F094A5219
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiAaWKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiAaWKM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:12 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7F4C061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:12 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id u13so13359009oie.5
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZXOIkcu6HLfcWLHcXrUtsWKWCIssUMfCQdIW2FKGHD8=;
        b=ZacRhok4/ZRBYagV3hbqWYFmqklDH3KM2evkta150gUY32wFL6v6En+S/vOLTxFOBf
         agcTHeijF3F+dJkhUZUSPSqnd52cyDfqapQyUGT00ijPm/LSWzt/ca0nRmuteyMxxVhX
         HGcq+k2egR3UBOdVgBG4SQMTIUm+s9tKPUiIipkyJ5NuQilsJ0jJViA3IQ5KQwP6qNlM
         aUIGsrnxOnAjjD0qR+B1JoDplK2vvmLE0a+HwiGOvRg52I0tOSmuGNCdX4snKMHr3YRB
         AA1PWZuX9xRy7ncmRFjDLf2NAcfmku/RrI2jUhY0IssciH1O0gJJGzvzVTbDKLM5mHRh
         XI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZXOIkcu6HLfcWLHcXrUtsWKWCIssUMfCQdIW2FKGHD8=;
        b=5r7fcCWDdTMSCQCutxV2l+lK2rQcvWwCStICpeCvP/1C5bpHaP4KXxnCNr6yv1EFOB
         X2ylj5/67/EsRPdnB6LTbBmihC4lMU8/+NvjG0nDG253NqHViS0Hs/ET0A8+pQ82Xn1n
         zo6Fec1GuUYgDN1WQA+lXInQh/vxn+ijW8hJoZ04O0X/THz4GzaO8a34Hpiw1N0Q9IVG
         1ERnysUM+DMPydd+xQhaOpXWUwt/ulllNoYQHp3qlAdzkm6uDYmSvETCFTLLDrNHTgQ9
         Dfl0dbyzQ1o7T4LMkLMdAWoF26utzzQTZ76c2x/GDpCMZucISO4mVEmD/PxaCfGH9Wx6
         464A==
X-Gm-Message-State: AOAM531vkd8IuR+rX0WajKaD9jdwuQd0VYweipMs6N8FLuIL6vXW+wcP
        RNA7WZ4DsbD77o7G7D4NXhk=
X-Google-Smtp-Source: ABdhPJwIbu7Hf2WYgPbCVr6/11eFSKKrML+9V8frc2yLjJ4CN0wzPtFcmCO70Kmi72/nbCdiowkEDw==
X-Received: by 2002:a05:6808:1918:: with SMTP id bf24mr19023246oib.253.1643667012058;
        Mon, 31 Jan 2022 14:10:12 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:11 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 10/17] RDMA/rxe: Split rxe_rcv_mcast_pkt into two phases
Date:   Mon, 31 Jan 2022 16:08:43 -0600
Message-Id: <20220131220849.10170-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mcast.c | 11 ++++---
 drivers/infiniband/sw/rxe/rxe_recv.c  | 41 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  2 +-
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 29e6c9e11c77..52bd46ca22c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -122,16 +122,16 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 	mca = new_mca;
 
-	if (mcg->num_qp >= rxe->attr.max_mcast_qp_attach) {
+	if (atomic_read(&mcg->qp_num) >= rxe->attr.max_mcast_qp_attach) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	mcg->num_qp++;
+	atomic_inc(&mcg->qp_num);
 	mca->qp = qp;
 	atomic_inc(&qp->mcg_num);
 
-	list_add(&mca->qp_list, &mcg->qp_list);
+	list_add_tail(&mca->qp_list, &mcg->qp_list);
 
 	err = 0;
 out:
@@ -154,8 +154,7 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
 			list_del(&mca->qp_list);
-			mcg->num_qp--;
-			if (mcg->num_qp <= 0)
+			if (atomic_dec_return(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 			atomic_dec(&qp->mcg_num);
 
@@ -190,7 +189,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 
 	err = rxe_mcast_add_grp_elem(rxe, qp, mcg);
 
-	if (mcg->num_qp == 0)
+	if (atomic_read(&mcg->qp_num) == 0)
 		__rxe_destroy_mcg(mcg);
 
 	rxe_drop_ref(mcg);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 10020103ea4a..ed80125f1dc5 100644
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
@@ -251,15 +258,32 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
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
+		rxe_add_ref(mca->qp);
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
@@ -274,28 +298,27 @@ static void rxe_rcv_mcast_pkt(struct sk_buff *skb)
 		 * skb and pass to the QP. Pass the original skb to
 		 * the last QP in the list.
 		 */
-		if (mca->qp_list.next != &mcg->qp_list) {
-			s = skb_clone(skb, GFP_ATOMIC);
+		if (n < nmax - 1) {
+			s = skb_clone(skb, GFP_KERNEL);
 			if (unlikely(!s))
 				continue;
 
+			RXECB(s)->qp = qp;
 			if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
+				rxe_drop_ref(RXECB(s)->qp);
 				kfree_skb(s);
-				break;
+				continue;
 			}
 
-			RXECB(s)->qp = qp;
-			rxe_add_ref(qp);
 			rxe_rcv_pkt(s);
 		} else {
 			RXECB(skb)->qp = qp;
-			rxe_add_ref(qp);
 			rxe_rcv_pkt(skb);
 			skb = NULL;	/* mark consumed */
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

