Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9349ED80
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiA0ViJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiA0ViI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:08 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7EFC061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:08 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s127so8598534oig.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7Re42h/hqRKORy3r1Yy/SCLyBooQ0darP9rBfE5na4=;
        b=DarlJSPv4aNsKQxFPORvTGVRtCBpGb3RnDqN+r96ZclUJROoZQdB/f6MnZcmXCpyGx
         fp8AKx9t/vRyauJvv2/kptUPo9DyobiM3hC+PFTyTyVj31aCte524127mIfaVRmN6jD3
         1E4tqeFP9XYtSApJHv60jyHU6UCBbc2u/xIYFs/fcMni035CdzjZ8FNvS7IIrdS028ub
         wr2EPK6pvD+JbXQnkEANNruhczAdtu/eqAP/vd8hRtj4HexxvWpzRoj6OYUP8HC91gQ2
         6V+4y5xfKJwcoDbv1295ERTKFQaabGbSdNxVDfjTw02rbJ3HXlCVKN/+oLWuB7kIE9B8
         bCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7Re42h/hqRKORy3r1Yy/SCLyBooQ0darP9rBfE5na4=;
        b=L4v8nPd/NTk6HJSmrq3n6NmZLam5pRBlkDNrm1ADYv7V8gC+lnAJ1sGmxEj2p++TZ0
         RmfcKBQrJ/AKJ+addqfbSaJZnoA9sUAnmu9TM7XaSTdoeI+4Wek+3TJMGyb+K8eACtrR
         1auJc7wGXnfpyqwZ5TOyqgiXhOZKfbgN3dQ+BaEeCcrLXnvfMr3+sUEq8ySWc2WBiwkV
         HHVd4WM/WFKcJ8fx/nPB77JS5xs8os2PElk4TKfci641nOq7f6k99zKn2U0uq5Boj9dO
         84Zv7xMF2u+anUXkaDsEyC/CEPWWKVKyayiZfYQqD5cdt2/zaph7Hafgth8eQ8EsBY0T
         PJhg==
X-Gm-Message-State: AOAM533ANjmayDp6RQYRnRZYkDFUCE7xdumXYv7kyOVrTavArNp8/Aec
        bQvHqZZHXLVyAH7RXfmnuEs=
X-Google-Smtp-Source: ABdhPJxNGUeTdBOGnkcLCh41sGVcY9faDIouZ9Bwi6j6VzAoN5/VadlYTBeJdVaDl5QPRRXhJTNY8A==
X-Received: by 2002:a05:6808:1598:: with SMTP id t24mr7977365oiw.50.1643319488182;
        Thu, 27 Jan 2022 13:38:08 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:07 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 03/26] RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
Date:   Thu, 27 Jan 2022 15:37:32 -0600
Message-Id: <20220127213755.31697-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rename rxe_mc_grp to rxe_mcg. Rename rxe_mc_elem to rxe_mca.
These can be read 'multicast group' and 'multicast attachment'.
'elem' collided with the use of elem in rxe pools and was a little
confusing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 26 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_pool.c  | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_recv.c  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  6 +++---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index f86e32f4e77f..949784198d80 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -26,12 +26,12 @@ static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 }
 
 /* caller should hold mc_grp_pool->pool_lock */
-static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
+static struct rxe_mcg *create_grp(struct rxe_dev *rxe,
 				     struct rxe_pool *pool,
 				     union ib_gid *mgid)
 {
 	int err;
-	struct rxe_mc_grp *grp;
+	struct rxe_mcg *grp;
 
 	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
 	if (!grp)
@@ -53,10 +53,10 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 }
 
 static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-			     struct rxe_mc_grp **grp_p)
+			     struct rxe_mcg **grp_p)
 {
 	int err;
-	struct rxe_mc_grp *grp;
+	struct rxe_mcg *grp;
 	struct rxe_pool *pool = &rxe->mc_grp_pool;
 
 	if (rxe->attr.max_mcast_qp_attach == 0)
@@ -82,10 +82,10 @@ static int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 }
 
 static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-			   struct rxe_mc_grp *grp)
+			   struct rxe_mcg *grp)
 {
 	int err;
-	struct rxe_mc_elem *elem;
+	struct rxe_mca *elem;
 
 	/* check to see of the qp is already a member of the group */
 	spin_lock_bh(&qp->grp_lock);
@@ -128,8 +128,8 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   union ib_gid *mgid)
 {
-	struct rxe_mc_grp *grp;
-	struct rxe_mc_elem *elem, *tmp;
+	struct rxe_mcg *grp;
+	struct rxe_mca *elem, *tmp;
 
 	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
@@ -162,8 +162,8 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 {
-	struct rxe_mc_grp *grp;
-	struct rxe_mc_elem *elem;
+	struct rxe_mcg *grp;
+	struct rxe_mca *elem;
 
 	while (1) {
 		spin_lock_bh(&qp->grp_lock);
@@ -171,7 +171,7 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 			spin_unlock_bh(&qp->grp_lock);
 			break;
 		}
-		elem = list_first_entry(&qp->grp_list, struct rxe_mc_elem,
+		elem = list_first_entry(&qp->grp_list, struct rxe_mca,
 					grp_list);
 		list_del(&elem->grp_list);
 		spin_unlock_bh(&qp->grp_lock);
@@ -188,7 +188,7 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 
 void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mc_grp *grp = container_of(elem, typeof(*grp), elem);
+	struct rxe_mcg *grp = container_of(elem, typeof(*grp), elem);
 	struct rxe_dev *rxe = grp->rxe;
 
 	rxe_drop_key(grp);
@@ -200,7 +200,7 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
-	struct rxe_mc_grp *grp;
+	struct rxe_mcg *grp;
 
 	/* takes a ref on grp if successful */
 	err = rxe_mcast_get_grp(rxe, mgid, &grp);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4cb003885e00..63c594173565 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -83,17 +83,17 @@ static const struct rxe_type_info {
 	},
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
-		.size		= sizeof(struct rxe_mc_grp),
-		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
+		.size		= sizeof(struct rxe_mcg),
+		.elem_offset	= offsetof(struct rxe_mcg, elem),
 		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY,
-		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
+		.key_offset	= offsetof(struct rxe_mcg, mgid),
 		.key_size	= sizeof(union ib_gid),
 	},
 	[RXE_TYPE_MC_ELEM] = {
 		.name		= "rxe-mc_elem",
-		.size		= sizeof(struct rxe_mc_elem),
-		.elem_offset	= offsetof(struct rxe_mc_elem, elem),
+		.size		= sizeof(struct rxe_mca),
+		.elem_offset	= offsetof(struct rxe_mca, elem),
 	},
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 6a6cc1fa90e4..7ff6b53555f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -233,8 +233,8 @@ static inline void rxe_rcv_pkt(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 {
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
-	struct rxe_mc_grp *mcg;
-	struct rxe_mc_elem *mce;
+	struct rxe_mcg *mcg;
+	struct rxe_mca *mce;
 	struct rxe_qp *qp;
 	union ib_gid dgid;
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e48969e8d4c8..388b7dc23dd7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -353,7 +353,7 @@ struct rxe_mw {
 	u64			length;
 };
 
-struct rxe_mc_grp {
+struct rxe_mcg {
 	struct rxe_pool_elem	elem;
 	spinlock_t		mcg_lock; /* guard group */
 	struct rxe_dev		*rxe;
@@ -364,12 +364,12 @@ struct rxe_mc_grp {
 	u16			pkey;
 };
 
-struct rxe_mc_elem {
+struct rxe_mca {
 	struct rxe_pool_elem	elem;
 	struct list_head	qp_list;
 	struct list_head	grp_list;
 	struct rxe_qp		*qp;
-	struct rxe_mc_grp	*grp;
+	struct rxe_mcg		*grp;
 };
 
 struct rxe_port {
-- 
2.32.0

