Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33F02805D3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgJARtB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732961AbgJARs7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:48:59 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6978CC0613E2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:48:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s66so6335780otb.2
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3j4+tNhIrc4tYr+5hwVg3HjI7QSO00fdfiuuSJP/fpo=;
        b=W0ZMU6oQDhRhxPTw2c+d/s+NbWZ/UUOd/axLSP+v6L3eet6W2NzKw20YTb+C3TwaZ5
         /jb0sNcesaBMJEw1lHu5pU5BPWeVE1PD7b6lTmd5f70ThRUh4ra+8uHMJ78T35yKYXMB
         1MQsFV/rT5Lfti/IVqeM6p6jX2QLc2UNdNEsyf59jQ/s7HIpUslaQrmA2SHWnElYTZ52
         ozWy6HCegcBMECDbRsDK851s2h/YKp5uynhs1ldfkdW/0W1Ou56G/EeLVZZRRlt6ZhZ0
         MjiLeQLwRprhpKz+VMjHoDNreysWQNlNPndJrFwzaoRunXEcpyyAjWjgXfsgnbGuLNBj
         4KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3j4+tNhIrc4tYr+5hwVg3HjI7QSO00fdfiuuSJP/fpo=;
        b=W5ROOWmaUCllQhYYnjNkOcG2XGgV1W9ePVhKDVDw25pN0NyuIOCWE8RUonO4Z9UUzh
         H7OSuH2ofEtH8Y77MAnvefRp2ohIDiTZpqdO6T1Qj4fOPKEwTQ8Cxsy12v94B3SZgY5m
         lkuPwRrMgwfcz+1ENeM43zCpvp4AxUFOeVPxixtC2e34sHYXaMy1ugTwaJgbpJg4ZDxg
         3NFpFFDGrfvVidyTbeKLDDM8jUu1EL6d7wED/Pha0AXlhqC/0J1zYicOXa46T6DM9PJh
         dIgIX2FSEt/JaKN63R60gvAJ+KQnHIJqS2PwO+HBvujlcESm6HtjtmiQjSYbshj+f5bs
         xuZQ==
X-Gm-Message-State: AOAM531zoLBPrqUrbnqyvge2zZ6ZBVlVv65iI2nogXEb0Yxsp8GzIOv5
        hjDGDtdLp3G4EE8wBvknSSs=
X-Google-Smtp-Source: ABdhPJyU8LlkM8xYsYkU0QpVslYaPogmQ/pdEnWdm/JYQRpGz0cduMExzSi8A8Aey5Gw1PDe2pd3Ew==
X-Received: by 2002:a9d:6219:: with SMTP id g25mr5807053otj.58.1601574537755;
        Thu, 01 Oct 2020 10:48:57 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id c124sm1188467oib.22.2020.10.01.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:48:57 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 04/19] rdma_rxe: make pool return values position independent
Date:   Thu,  1 Oct 2020 12:48:32 -0500
Message-Id: <20201001174847.4268-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe pool manages objects which are based on a base type of
rxe_pool_entry. Once apon a time these were always the first
entry in the rxe object structs. Now the pool entries (usually
named elem or pelem) occur in more than one position. In order
to make the return values from lookup and allocate routines
work independently of the position of the pelem the offset of
pelem is added to the rxe_type_info struct and used to compute
the return value from these routines.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c |  4 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 40 +++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  5 ++--
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 ++--
 drivers/infiniband/sw/rxe/rxe_req.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  2 +-
 7 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index c02315aed8d1..b09c6594045a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -18,7 +18,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 		goto err1;
 	}
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	grp = rxe_get_key(&rxe->mc_grp_pool, mgid);
 	if (grp)
 		goto done;
 
@@ -98,7 +98,7 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mc_grp *grp;
 	struct rxe_mc_elem *elem, *tmp;
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	grp = rxe_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
 		goto err1;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 4baa2f498e9d..f40cf4df394f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -10,7 +10,7 @@
 /*
  * lfsr (linear feedback shift register) with period 255
  */
-static u8 rxe_get_key(void)
+static u8 get_key(void)
 {
 	static u32 key = 1;
 
@@ -49,7 +49,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
+	u32 lkey = mr->pelem.index << 8 | get_key();
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
 	if (mr->pelem.pool->type == RXE_TYPE_MR) {
@@ -544,7 +544,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
 	int index = key >> 8;
 
-	mr = rxe_pool_get_index(&rxe->mr_pool, index);
+	mr = rxe_get_index(&rxe->mr_pool, index);
 	if (!mr)
 		return NULL;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 30b8f037ee20..c4f1318ea761 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -13,21 +13,25 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
+		.elem_offset	= offsetof(struct rxe_ucontext, pelem),
 		.flags          = RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
+		.elem_offset	= offsetof(struct rxe_pd, pelem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
+		.elem_offset	= offsetof(struct rxe_ah, pelem),
 		.flags		= RXE_POOL_ATOMIC | RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
+		.elem_offset	= offsetof(struct rxe_srq, pelem),
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
@@ -35,6 +39,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
 		.size		= sizeof(struct rxe_qp),
+		.elem_offset	= offsetof(struct rxe_qp, pelem),
 		.cleanup	= rxe_qp_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_QP_INDEX,
@@ -43,12 +48,14 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
+		.elem_offset	= offsetof(struct rxe_cq, pelem),
 		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mr),
+		.elem_offset	= offsetof(struct rxe_mr, pelem),
 		.cleanup	= rxe_mr_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
@@ -57,6 +64,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
+		.elem_offset	= offsetof(struct rxe_mw, pelem),
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
@@ -64,6 +72,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
+		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
 		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
@@ -72,6 +81,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_ELEM] = {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
+		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
 		.flags		= RXE_POOL_ATOMIC,
 	},
 };
@@ -304,6 +314,8 @@ void rxe_drop_index(void *arg)
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	u8 *obj = NULL;
 	unsigned long flags;
 
 	might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));
@@ -330,8 +342,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
+	obj = (u8 *)elem - info->elem_offset;
 
-	return elem;
+	return obj;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
@@ -390,10 +403,12 @@ void rxe_elem_release(struct kref *kref)
 	rxe_pool_put(pool);
 }
 
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
+void *rxe_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node = NULL;
 	struct rxe_pool_entry *elem = NULL;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	u8 *obj = NULL;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
@@ -410,21 +425,25 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 			node = node->rb_left;
 		else if (elem->index < index)
 			node = node->rb_right;
-		else {
-			kref_get(&elem->ref_cnt);
+		else
 			break;
-		}
 	}
 
+	if (node) {
+		kref_get(&elem->ref_cnt);
+		obj = (u8 *)elem - info->elem_offset;
+	}
 out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
-	return node ? elem : NULL;
+	return obj;
 }
 
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
+void *rxe_get_key(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node = NULL;
 	struct rxe_pool_entry *elem = NULL;
+	struct rxe_type_info *info = &rxe_type_info[pool->type];
+	u8 *obj = NULL;
 	int cmp;
 	unsigned long flags;
 
@@ -449,10 +468,13 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 			break;
 	}
 
-	if (node)
+	if (node) {
 		kref_get(&elem->ref_cnt);
+		obj = (u8 *)elem - info->elem_offset;
+	}
+
 
 out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
-	return node ? elem : NULL;
+	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 3d722aae5f15..68c6dbeb72d4 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -36,6 +36,7 @@ struct rxe_pool_entry;
 struct rxe_type_info {
 	const char		*name;
 	size_t			size;
+	size_t			elem_offset;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_flags	flags;
 	u32			max_index;
@@ -128,10 +129,10 @@ void rxe_add_key(void *elem, void *key);
 void rxe_drop_key(void *elem);
 
 /* lookup an indexed object from index. takes a reference on object */
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
+void *rxe_get_index(struct rxe_pool *pool, u32 index);
 
 /* lookup keyed object from key. takes a reference on the object */
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
+void *rxe_get_key(struct rxe_pool *pool, void *key);
 
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index a3eed4da1540..e14cb20c4596 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -185,7 +185,7 @@ static int hdr_check(struct rxe_pkt_info *pkt)
 	if (qpn != IB_MULTICAST_QPN) {
 		index = (qpn == 1) ? port->qp_gsi_index : qpn;
 
-		qp = rxe_pool_get_index(&rxe->qp_pool, index);
+		qp = rxe_get_index(&rxe->qp_pool, index);
 		if (unlikely(!qp)) {
 			pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn);
 			goto err1;
@@ -242,7 +242,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 		memcpy(&dgid, &ipv6_hdr(skb)->daddr, sizeof(dgid));
 
 	/* lookup mcast group corresponding to mgid, takes a ref */
-	mcg = rxe_pool_get_key(&rxe->mc_grp_pool, &dgid);
+	mcg = rxe_get_key(&rxe->mc_grp_pool, &dgid);
 	if (!mcg)
 		goto err1;	/* mcast group not registered */
 
@@ -274,7 +274,7 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
 
 	spin_unlock_bh(&mcg->mcg_lock);
 
-	rxe_drop_ref(mcg);	/* drop ref from rxe_pool_get_key. */
+	rxe_drop_ref(mcg);	/* drop ref from rxe_get_key. */
 
 err1:
 	kfree_skb(skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 57236d8c2146..ea08464e461d 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -599,7 +599,7 @@ int rxe_requester(void *arg)
 			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 			struct rxe_mr *rmr;
 
-			rmr = rxe_pool_get_index(&rxe->mr_pool,
+			rmr = rxe_get_index(&rxe->mr_pool,
 						 wqe->wr.ex.invalidate_rkey >> 8);
 			if (!rmr) {
 				pr_err("No mr for key %#x\n",
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 69867bf39cfb..9f96b4b706c3 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -888,7 +888,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				wc->wc_flags |= IB_WC_WITH_INVALIDATE;
 				wc->ex.invalidate_rkey = ieth_rkey(pkt);
 
-				rmr = rxe_pool_get_index(&rxe->mr_pool,
+				rmr = rxe_get_index(&rxe->mr_pool,
 							 wc->ex.invalidate_rkey >> 8);
 				if (unlikely(!rmr)) {
 					pr_err("Bad rkey %#x invalidation\n",
-- 
2.25.1

