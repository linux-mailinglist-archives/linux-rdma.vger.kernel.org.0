Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C58443C50
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhKCFGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhKCFGN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67DFC061714
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q124so2125522oig.3
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBJTyqKi23t4xAFGndjDSrccnBJHyAeCYiXI2pY8bos=;
        b=IOSvDXv6mjSgs+Up8vIFaJ7NH4BIp57OrrNZJey5SwPoATtj0bCld7ZcVZEmVKDLGZ
         gXIt/WISv5aeBCOaijaKSyyPUEn+EF0C+IFIYH0C4N3mIv2EKbhS1QqXJo2QRKQbFHT9
         ete1KK7jN94UMX7V+/rLDsQ3OzPeEOj0feU4fLvFzy/7vpRkdNk6gBEhYlw3ePA2kgma
         YOMTyM+bit6V/pUrfZT4nZzl0tgikehB/FQE9DSF4VtEuxwIQlluiZ6bHCRnkIlxxnGk
         RiqEj/I7p+vKsTZ35kTK8Z6hxi0sopd2qqQ3Svny5U410Wxe0Rw984hTBNzqU/L7VQBj
         tQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBJTyqKi23t4xAFGndjDSrccnBJHyAeCYiXI2pY8bos=;
        b=Q64iunMEDu0DWs3O7XK+TeIcK6w/iYdSqmzwK+2HXFHWNE5sDkQSSAyWAbSGaXrMRC
         SUv9s1DfLKevXy2j3orWI5gtylCd6lvEFyijj5QLqhFiuHqVl4PE8n3TecawohQf/Utp
         e22kGe8cBSHVYnFEYymMDptkGSfe1bq5VkHhYMPrXrSEu9mt6D+Zdy/xCcVe6jiGNL+E
         OmD1faAzPwkvlLiXu0amQrJjpPQNnbfvJkPIlP52e4ejCxcC/xZJ9M0DjvzIKCJodaW1
         6c6xNKucuXMonL8GF9AlLI99bKvp5JDOk3mMM9hUNcqep64HFH58A8++PZ1zP3IKYKe2
         ywYQ==
X-Gm-Message-State: AOAM530DLG+ebqn1YKjjbqKnUOBBOw6uiPLcEGNk3ZOKZv4OTJnY1I8h
        87/uf/w+k0hJZI3tp+ZWUEaaSbtDGaA=
X-Google-Smtp-Source: ABdhPJwjJahLNkbHZryyDkOjdTQJ16RWcL96lXjkEPgFIdaolzRc8QHSkcmEkRzu6sF/c08qVA6DgQ==
X-Received: by 2002:aca:4b56:: with SMTP id y83mr3166003oia.114.1635915816789;
        Tue, 02 Nov 2021 22:03:36 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 02/13] RDMA/rxe: Cleanup rxe_pool_entry
Date:   Wed,  3 Nov 2021 00:02:31 -0500
Message-Id: <20211103050241.61293-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently three different names are used to describe rxe pool elements.
They are referred to as entries, elems or pelems. This patch chooses one
'elem' and changes the other ones.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   | 10 ++--
 drivers/infiniband/sw/rxe/rxe_mcast.c |  4 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 +--
 drivers/infiniband/sw/rxe/rxe_mw.c    |  6 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 72 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 46 ++++++++---------
 drivers/infiniband/sw/rxe/rxe_qp.c    |  6 +--
 drivers/infiniband/sw/rxe/rxe_srq.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h | 22 ++++----
 11 files changed, 89 insertions(+), 91 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 84bd8669a80f..6baaaa34458e 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -146,9 +146,9 @@ void rxe_cq_disable(struct rxe_cq *cq)
 	spin_unlock_bh(&cq->cq_lock);
 }
 
-void rxe_cq_cleanup(struct rxe_pool_entry *arg)
+void rxe_cq_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_cq *cq = container_of(arg, typeof(*cq), pelem);
+	struct rxe_cq *cq = container_of(elem, typeof(*cq), elem);
 
 	if (cq->queue)
 		rxe_queue_cleanup(cq->queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1ca43b859d80..b1e174afb1d4 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -37,7 +37,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 
 void rxe_cq_disable(struct rxe_cq *cq);
 
-void rxe_cq_cleanup(struct rxe_pool_entry *arg);
+void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
 int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
@@ -51,7 +51,7 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
 
-void rxe_mc_cleanup(struct rxe_pool_entry *arg);
+void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mmap.c */
 struct rxe_mmap_info {
@@ -89,7 +89,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
-void rxe_mr_cleanup(struct rxe_pool_entry *arg);
+void rxe_mr_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
@@ -97,7 +97,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
-void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+void rxe_mw_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
@@ -131,7 +131,7 @@ void rxe_qp_error(struct rxe_qp *qp);
 
 void rxe_qp_destroy(struct rxe_qp *qp);
 
-void rxe_qp_cleanup(struct rxe_pool_entry *arg);
+void rxe_qp_cleanup(struct rxe_pool_elem *elem);
 
 static inline int qp_num(struct rxe_qp *qp)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index ba6275fd3edb..bd1ac88b8700 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -168,9 +168,9 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 	}
 }
 
-void rxe_mc_cleanup(struct rxe_pool_entry *arg)
+void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mc_grp *grp = container_of(arg, typeof(*grp), pelem);
+	struct rxe_mc_grp *grp = container_of(elem, typeof(*grp), elem);
 	struct rxe_dev *rxe = grp->rxe;
 
 	rxe_drop_key(grp);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 53271df10e47..25c78aade822 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -50,7 +50,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | rxe_get_next_key(-1);
+	u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
 	/* set ibmr->l/rkey and also copy into private l/rkey
@@ -699,9 +699,9 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	return 0;
 }
 
-void rxe_mr_cleanup(struct rxe_pool_entry *arg)
+void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
+	struct rxe_mr *mr = container_of(elem, typeof(*mr), elem);
 
 	ib_umem_release(mr->umem);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 3cbd38578230..32dd8c0b8b9e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -21,7 +21,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	}
 
 	rxe_add_index(mw);
-	mw->rkey = ibmw->rkey = (mw->pelem.index << 8) | rxe_get_next_key(-1);
+	mw->rkey = ibmw->rkey = (mw->elem.index << 8) | rxe_get_next_key(-1);
 	mw->state = (mw->ibmw.type == IB_MW_TYPE_2) ?
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
 	spin_lock_init(&mw->lock);
@@ -330,9 +330,9 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 	return mw;
 }
 
-void rxe_mw_cleanup(struct rxe_pool_entry *elem)
+void rxe_mw_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
+	struct rxe_mw *mw = container_of(elem, typeof(*mw), elem);
 
 	rxe_drop_index(mw);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 30178501bb2c..4b4bf0e03ddd 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -11,7 +11,7 @@ static const struct rxe_type_info {
 	const char *name;
 	size_t size;
 	size_t elem_offset;
-	void (*cleanup)(struct rxe_pool_entry *obj);
+	void (*cleanup)(struct rxe_pool_elem *obj);
 	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
@@ -21,19 +21,19 @@ static const struct rxe_type_info {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
-		.elem_offset	= offsetof(struct rxe_ucontext, pelem),
+		.elem_offset	= offsetof(struct rxe_ucontext, elem),
 		.flags          = RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_PD] = {
 		.name		= "rxe-pd",
 		.size		= sizeof(struct rxe_pd),
-		.elem_offset	= offsetof(struct rxe_pd, pelem),
+		.elem_offset	= offsetof(struct rxe_pd, elem),
 		.flags		= RXE_POOL_NO_ALLOC,
 	},
 	[RXE_TYPE_AH] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
-		.elem_offset	= offsetof(struct rxe_ah, pelem),
+		.elem_offset	= offsetof(struct rxe_ah, elem),
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
@@ -41,7 +41,7 @@ static const struct rxe_type_info {
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
-		.elem_offset	= offsetof(struct rxe_srq, pelem),
+		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
@@ -49,7 +49,7 @@ static const struct rxe_type_info {
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
 		.size		= sizeof(struct rxe_qp),
-		.elem_offset	= offsetof(struct rxe_qp, pelem),
+		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_QP_INDEX,
@@ -58,14 +58,14 @@ static const struct rxe_type_info {
 	[RXE_TYPE_CQ] = {
 		.name		= "rxe-cq",
 		.size		= sizeof(struct rxe_cq),
-		.elem_offset	= offsetof(struct rxe_cq, pelem),
+		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.flags          = RXE_POOL_NO_ALLOC,
 		.cleanup	= rxe_cq_cleanup,
 	},
 	[RXE_TYPE_MR] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mr),
-		.elem_offset	= offsetof(struct rxe_mr, pelem),
+		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
 		.flags		= RXE_POOL_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
@@ -74,7 +74,7 @@ static const struct rxe_type_info {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
-		.elem_offset	= offsetof(struct rxe_mw, pelem),
+		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_MW_INDEX,
@@ -83,7 +83,7 @@ static const struct rxe_type_info {
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
-		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
+		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
 		.cleanup	= rxe_mc_cleanup,
 		.flags		= RXE_POOL_KEY,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
@@ -92,7 +92,7 @@ static const struct rxe_type_info {
 	[RXE_TYPE_MC_ELEM] = {
 		.name		= "rxe-mc_elem",
 		.size		= sizeof(struct rxe_mc_elem),
-		.elem_offset	= offsetof(struct rxe_mc_elem, pelem),
+		.elem_offset	= offsetof(struct rxe_mc_elem, elem),
 	},
 };
 
@@ -189,15 +189,15 @@ static u32 alloc_index(struct rxe_pool *pool)
 	return index + pool->index.min_index;
 }
 
-static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_elem *new)
 {
 	struct rb_node **link = &pool->index.tree.rb_node;
 	struct rb_node *parent = NULL;
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 
 	while (*link) {
 		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_entry, index_node);
+		elem = rb_entry(parent, struct rxe_pool_elem, index_node);
 
 		if (elem->index == new->index) {
 			pr_warn("element already exists!\n");
@@ -216,16 +216,16 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return 0;
 }
 
-static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
 {
 	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	int cmp;
 
 	while (*link) {
 		parent = *link;
-		elem = rb_entry(parent, struct rxe_pool_entry, key_node);
+		elem = rb_entry(parent, struct rxe_pool_elem, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
 			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
@@ -247,7 +247,7 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return 0;
 }
 
-int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
+int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 	int err;
@@ -258,7 +258,7 @@ int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
 	return err;
 }
 
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
+int __rxe_add_key(struct rxe_pool_elem *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 	int err;
@@ -270,14 +270,14 @@ int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 	return err;
 }
 
-void __rxe_drop_key_locked(struct rxe_pool_entry *elem)
+void __rxe_drop_key_locked(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
 	rb_erase(&elem->key_node, &pool->key.tree);
 }
 
-void __rxe_drop_key(struct rxe_pool_entry *elem)
+void __rxe_drop_key(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -286,7 +286,7 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
 	write_unlock_bh(&pool->pool_lock);
 }
 
-int __rxe_add_index_locked(struct rxe_pool_entry *elem)
+int __rxe_add_index_locked(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int err;
@@ -297,7 +297,7 @@ int __rxe_add_index_locked(struct rxe_pool_entry *elem)
 	return err;
 }
 
-int __rxe_add_index(struct rxe_pool_entry *elem)
+int __rxe_add_index(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int err;
@@ -309,7 +309,7 @@ int __rxe_add_index(struct rxe_pool_entry *elem)
 	return err;
 }
 
-void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
+void __rxe_drop_index_locked(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -317,7 +317,7 @@ void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
 	rb_erase(&elem->index_node, &pool->index.tree);
 }
 
-void __rxe_drop_index(struct rxe_pool_entry *elem)
+void __rxe_drop_index(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -329,7 +329,7 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
 	const struct rxe_type_info *info = &rxe_type_info[pool->type];
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	u8 *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -339,7 +339,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_elem *)(obj + info->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
@@ -354,7 +354,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	const struct rxe_type_info *info = &rxe_type_info[pool->type];
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	u8 *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -364,7 +364,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_elem *)(obj + info->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
@@ -376,7 +376,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -393,8 +393,8 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 
 void rxe_elem_release(struct kref *kref)
 {
-	struct rxe_pool_entry *elem =
-		container_of(kref, struct rxe_pool_entry, ref_cnt);
+	struct rxe_pool_elem *elem =
+		container_of(kref, struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
 	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	u8 *obj;
@@ -414,13 +414,13 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	u8 *obj;
 
 	node = pool->index.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, index_node);
+		elem = rb_entry(node, struct rxe_pool_elem, index_node);
 
 		if (elem->index > index)
 			node = node->rb_left;
@@ -455,14 +455,14 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	u8 *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, key_node);
+		elem = rb_entry(node, struct rxe_pool_elem, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
 			     key, pool->key.key_size);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 8ecd9f870aea..e6508f30bbf8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -30,9 +30,7 @@ enum rxe_elem_type {
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
-struct rxe_pool_entry;
-
-struct rxe_pool_entry {
+struct rxe_pool_elem {
 	struct rxe_pool		*pool;
 	struct kref		ref_cnt;
 	struct list_head	list;
@@ -49,7 +47,7 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
 	size_t			elem_size;
-	void			(*cleanup)(struct rxe_pool_entry *obj);
+	void			(*cleanup)(struct rxe_pool_elem *obj);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
@@ -89,51 +87,51 @@ void *rxe_alloc_locked(struct rxe_pool *pool);
 void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
-#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
 /* assign an index to an indexed object and insert object into
  *  pool's rb tree holding and not holding the pool_lock
  */
-int __rxe_add_index_locked(struct rxe_pool_entry *elem);
+int __rxe_add_index_locked(struct rxe_pool_elem *elem);
 
-#define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->pelem)
+#define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->elem)
 
-int __rxe_add_index(struct rxe_pool_entry *elem);
+int __rxe_add_index(struct rxe_pool_elem *elem);
 
-#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
+#define rxe_add_index(obj) __rxe_add_index(&(obj)->elem)
 
 /* drop an index and remove object from rb tree
  * holding and not holding the pool_lock
  */
-void __rxe_drop_index_locked(struct rxe_pool_entry *elem);
+void __rxe_drop_index_locked(struct rxe_pool_elem *elem);
 
-#define rxe_drop_index_locked(obj) __rxe_drop_index_locked(&(obj)->pelem)
+#define rxe_drop_index_locked(obj) __rxe_drop_index_locked(&(obj)->elem)
 
-void __rxe_drop_index(struct rxe_pool_entry *elem);
+void __rxe_drop_index(struct rxe_pool_elem *elem);
 
-#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
+#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->elem)
 
 /* assign a key to a keyed object and insert object into
  * pool's rb tree holding and not holding pool_lock
  */
-int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key);
+int __rxe_add_key_locked(struct rxe_pool_elem *elem, void *key);
 
-#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->pelem, key)
+#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->elem, key)
 
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
+int __rxe_add_key(struct rxe_pool_elem *elem, void *key);
 
-#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
+#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->elem, key)
 
 /* remove elem from rb tree holding and not holding the pool_lock */
-void __rxe_drop_key_locked(struct rxe_pool_entry *elem);
+void __rxe_drop_key_locked(struct rxe_pool_elem *elem);
 
-#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->pelem)
+#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->elem)
 
-void __rxe_drop_key(struct rxe_pool_entry *elem);
+void __rxe_drop_key(struct rxe_pool_elem *elem);
 
-#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
+#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->elem)
 
 /* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
@@ -153,9 +151,9 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 void rxe_elem_release(struct kref *kref);
 
 /* take a reference on an object */
-#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
+#define rxe_add_ref(obj) kref_get(&(obj)->elem.ref_cnt)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
+#define rxe_drop_ref(obj) kref_put(&(obj)->elem.ref_cnt, rxe_elem_release)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 975321812c87..864bb3ef145f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -167,7 +167,7 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->attr.path_mtu	= 1;
 	qp->mtu			= ib_mtu_enum_to_int(qp->attr.path_mtu);
 
-	qpn			= qp->pelem.index;
+	qpn			= qp->elem.index;
 	port			= &rxe->port;
 
 	switch (init->qp_type) {
@@ -831,9 +831,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 }
 
 /* called when the last reference to the qp is dropped */
-void rxe_qp_cleanup(struct rxe_pool_entry *arg)
+void rxe_qp_cleanup(struct rxe_pool_elem *elem)
 {
-	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
+	struct rxe_qp *qp = container_of(elem, typeof(*qp), elem);
 
 	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index eb1c4c3b3a78..0c0721f04357 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -83,7 +83,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 	srq->ibsrq.event_handler	= init->event_handler;
 	srq->ibsrq.srq_context		= init->srq_context;
 	srq->limit		= init->attr.srq_limit;
-	srq->srq_num		= srq->pelem.index;
+	srq->srq_num		= srq->elem.index;
 	srq->rq.max_wr		= init->attr.max_wr;
 	srq->rq.max_sge		= init->attr.max_sge;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index dcb7436b9346..07ca169110bf 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -182,7 +182,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 
 	/* create index > 0 */
 	rxe_add_index(ah);
-	ah->ah_num = ah->pelem.index;
+	ah->ah_num = ah->elem.index;
 
 	if (uresp) {
 		/* only if new user provider */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 35e041450090..caf1ce118765 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -35,17 +35,17 @@ static inline int psn_compare(u32 psn_a, u32 psn_b)
 
 struct rxe_ucontext {
 	struct ib_ucontext ibuc;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 };
 
 struct rxe_pd {
 	struct ib_pd            ibpd;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 };
 
 struct rxe_ah {
 	struct ib_ah		ibah;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct rxe_av		av;
 	bool			is_user;
 	int			ah_num;
@@ -60,7 +60,7 @@ struct rxe_cqe {
 
 struct rxe_cq {
 	struct ib_cq		ibcq;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
 	u8			notify;
@@ -95,7 +95,7 @@ struct rxe_rq {
 
 struct rxe_srq {
 	struct ib_srq		ibsrq;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct rxe_pd		*pd;
 	struct rxe_rq		rq;
 	u32			srq_num;
@@ -209,7 +209,7 @@ struct rxe_resp_info {
 
 struct rxe_qp {
 	struct ib_qp		ibqp;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct ib_qp_attr	attr;
 	unsigned int		valid;
 	unsigned int		mtu;
@@ -309,7 +309,7 @@ static inline int rkey_is_mw(u32 rkey)
 }
 
 struct rxe_mr {
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct ib_mr		ibmr;
 
 	struct ib_umem		*umem;
@@ -342,7 +342,7 @@ enum rxe_mw_state {
 
 struct rxe_mw {
 	struct ib_mw		ibmw;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	spinlock_t		lock;
 	enum rxe_mw_state	state;
 	struct rxe_qp		*qp; /* Type 2 only */
@@ -354,7 +354,7 @@ struct rxe_mw {
 };
 
 struct rxe_mc_grp {
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	spinlock_t		mcg_lock; /* guard group */
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
@@ -365,7 +365,7 @@ struct rxe_mc_grp {
 };
 
 struct rxe_mc_elem {
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct list_head	qp_list;
 	struct list_head	grp_list;
 	struct rxe_qp		*qp;
@@ -484,6 +484,6 @@ static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
 
 int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
 
-void rxe_mc_cleanup(struct rxe_pool_entry *arg);
+void rxe_mc_cleanup(struct rxe_pool_elem *elem);
 
 #endif /* RXE_VERBS_H */
-- 
2.30.2

