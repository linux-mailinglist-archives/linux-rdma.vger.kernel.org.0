Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE14A5212
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiAaWKH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiAaWKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:07 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BDEC061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:07 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r27so7386980oiw.4
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/7Re42h/hqRKORy3r1Yy/SCLyBooQ0darP9rBfE5na4=;
        b=fJwJqsay9x4EJRhhEu4+iJx+t0NGFtJ6imalzwG0/XmFkQ+j7YldxLiUs6qt4EhDnt
         VzfA34uRPEzx9B0rK52fTmtXTcAaKeow5vqg4Ud3cyVmX5thKPItDPtXcqDEWgAwXw4X
         FiML4EAiL2mZXWfwySJ1gZX1etO4doHHuxcEn5GV7KjOeNfsFadhbglywaT7Tfy8GejE
         sqdIsHE8O5UGJnHDDs/LSnOAzgOYRfs030i01FmxPJMEh0YmvtxGRNaj5cQ+LRkwF6gV
         hXz3UuyngbfudH2/a+rcV/6hGEgC9bdhi4vAS/hajR8ckgRyBfTBC9QJLgzVVRjdHJfY
         uywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/7Re42h/hqRKORy3r1Yy/SCLyBooQ0darP9rBfE5na4=;
        b=3JN8bHbTAD2sLCTzbhVR5CXBvOLX2grSAGbhlrguiz3jyKKLrqxB/rFGHcA1H2WiNg
         jExs2wyrZIWPKfrbYw3a0YYfm2zDahwAKNJ+Jz42vUDG+xxbaNh79QwPu2vAXLrPB0PK
         KcbNc46t+9HaMq2GoV7ecaDaqXm5z2qbrgNX0tlOyX0Jgp1XpPghorLAeWpUyco+cpF4
         7PEMBkqEs3J+XNwVGHab40Pqug5XNP5fqPkDamdxpPCKKZo247RbjVGuY5GxYnUefzdX
         BXMxvc4pAxA9ayd7wU37CGBg1vcXYDCQapj5oPiMda9uIjMqIECLFU9uAdrEyuaugSIy
         FohQ==
X-Gm-Message-State: AOAM532uMD/QmQRCvFDSoxF13nH/HhhQVxhB9Mam7lnA+SEzOV9CGz+o
        JGjCkldtDp4a4RWL3exeFYJssVCXkgM=
X-Google-Smtp-Source: ABdhPJxPamyVk/ZpyMrhw9tRYIWt0dBTDIby7NFdpgPH/DbI/nWsfcx0orNS/2IbKVZ16yQWvdf7ZQ==
X-Received: by 2002:aca:b7c1:: with SMTP id h184mr19242893oif.36.1643667006487;
        Mon, 31 Jan 2022 14:10:06 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 03/17] RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
Date:   Mon, 31 Jan 2022 16:08:36 -0600
Message-Id: <20220131220849.10170-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
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

