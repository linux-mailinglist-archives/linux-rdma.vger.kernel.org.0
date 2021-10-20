Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED2C4355B3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJTWJo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhJTWJn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990B9C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:28 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so7909451otb.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bjnJ4oIrIHrevNzkurUP0n4Sgiwxskhb+Y0lKxYmJm4=;
        b=cmJYaR53EsMend4cBXLok192NmatNOuFaR/MY6jQ34f1QTVIA5sjTapUAeUujPq2j1
         lrFCqBSBcM7YXNUC2PZbGeUMbFuyfEvfnoc6GJNyspRBMXnx3JQHe4RMrrmiYnkp8ZXT
         NYz1aQey7m0mdJ8dAwDgxxr1HguJlocrws3zhGE3mzZi7bdxO146OeD/X5KyfBOPB0j+
         qbARXVDzfC8wn3s17hQ0s/eQHgMta+VP1ReiHdNZ1Gv0HZgVKE232rsKdcpr8qG9nSER
         zO7puz8RTiWmUti7bt+Zu1Y3Q3UejMiqw+A8fxm2eHKoUrCjBH9c+548vQ0VV0tMnVFo
         JWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjnJ4oIrIHrevNzkurUP0n4Sgiwxskhb+Y0lKxYmJm4=;
        b=Z6Jg1wg/y2Fq5prdAptfO0cbmpIR6XYM51wyJSHlZvvpkNT2dK5Ef373l4By6JwiLo
         oVl8+fdoLd7SDQhVphTbuI2YI80pmvUUTBOFi4RHhnmxBpSsX6jh/hoRDGy1ICzm8ukc
         5CaX93tbrs1Smb0+dafWh1Stf3B6UKdOs2XQzJ6mHY+pP8mSENOMkkCuXhj//GjvI0XF
         E8RSfKGC97O3/v/EyY+ccm1a2QxSXLszdERLApP3NlnUIN9Z6XevOPW5lIzSQWfNkMkt
         h0G7k+6XA6rMY+gDXbc6GrxBqgn/8Af9i0vqvZKhoImSAAx8+EF2O643wQ5cVCv9jBRp
         OSRA==
X-Gm-Message-State: AOAM530kLEM5Lc6P8AW1L5Ca+ifmJsTQNqxIuVKB66UiSCuMrG149wBi
        FEB6VQ1gFFqjZdRGE5d0WkBqMJk4K48=
X-Google-Smtp-Source: ABdhPJwLTukHN+zn1PuZswOMkXM1w7XHGgqaHOFJRZN80qH9EBty0ziuTUq+rNO6sHWm6CvQffxX+Q==
X-Received: by 2002:a05:6830:4187:: with SMTP id r7mr1576444otu.126.1634767647904;
        Wed, 20 Oct 2021 15:07:27 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:27 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/7] RDMA/rxe: Cleanup rxe_pool_entry
Date:   Wed, 20 Oct 2021 17:05:45 -0500
Message-Id: <20211020220549.36145-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020220549.36145-1-rpearsonhpe@gmail.com>
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 +--
 drivers/infiniband/sw/rxe/rxe_mw.c    |  4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 70 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 38 +++++++--------
 drivers/infiniband/sw/rxe/rxe_qp.c    |  6 +--
 drivers/infiniband/sw/rxe/rxe_srq.c   |  6 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h | 22 ++++-----
 10 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index dda510e4d904..79682a3b1357 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -139,9 +139,9 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	return 0;
 }
 
-void rxe_cq_cleanup(struct rxe_pool_entry *arg)
+void rxe_cq_cleanup(struct rxe_pool_elem *arg)
 {
-	struct rxe_cq *cq = container_of(arg, typeof(*cq), pelem);
+	struct rxe_cq *cq = container_of(arg, typeof(*cq), elem);
 
 	/* TODO get rid of this */
 	spin_lock_bh(&cq->cq_lock);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index a689ee8386b8..2d073dfd99a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -35,7 +35,7 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int new_cqe,
 
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 
-void rxe_cq_cleanup(struct rxe_pool_entry *arg);
+void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
@@ -80,7 +80,7 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
-void rxe_mr_cleanup(struct rxe_pool_entry *arg);
+void rxe_mr_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mw.c */
 int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
@@ -88,7 +88,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw);
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
 struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
-void rxe_mw_cleanup(struct rxe_pool_entry *arg);
+void rxe_mw_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_net.c */
 struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
@@ -121,7 +121,7 @@ void rxe_qp_error(struct rxe_qp *qp);
 
 void rxe_qp_destroy(struct rxe_qp *qp);
 
-void rxe_qp_cleanup(struct rxe_pool_entry *arg);
+void rxe_qp_cleanup(struct rxe_pool_elem *arg);
 
 static inline int qp_num(struct rxe_qp *qp)
 {
@@ -177,7 +177,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
-void rxe_srq_cleanup(struct rxe_pool_entry *arg);
+void rxe_srq_cleanup(struct rxe_pool_elem *arg);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6c50c8562fd8..63a36b7f2aa5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -50,7 +50,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | rxe_get_next_key(-1);
+	u32 lkey = mr->elem.index << 8 | rxe_get_next_key(-1);
 	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
 
 	/* set ibmr->l/rkey and also copy into private l/rkey
@@ -704,9 +704,9 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	return 0;
 }
 
-void rxe_mr_cleanup(struct rxe_pool_entry *arg)
+void rxe_mr_cleanup(struct rxe_pool_elem *arg)
 {
-	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
+	struct rxe_mr *mr = container_of(arg, typeof(*mr), elem);
 
 	ib_umem_release(mr->umem);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 7c264599b3d4..cd690dad9d39 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -20,7 +20,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		return ret;
 	}
 
-	mw->rkey = ibmw->rkey = (mw->pelem.index << 8) | rxe_get_next_key(-1);
+	mw->rkey = ibmw->rkey = (mw->elem.index << 8) | rxe_get_next_key(-1);
 	mw->state = (mw->ibmw.type == IB_MW_TYPE_2) ?
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
 	spin_lock_init(&mw->lock);
@@ -330,7 +330,7 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 	return mw;
 }
 
-void rxe_mw_cleanup(struct rxe_pool_entry *elem)
+void rxe_mw_cleanup(struct rxe_pool_elem *elem)
 {
 	/* nothing to do currently */
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 58f826ab3bc6..24ebd1b663c3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -12,19 +12,19 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
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
@@ -32,7 +32,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
-		.elem_offset	= offsetof(struct rxe_srq, pelem),
+		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.cleanup	= rxe_srq_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
@@ -41,7 +41,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_QP] = {
 		.name		= "rxe-qp",
 		.size		= sizeof(struct rxe_qp),
-		.elem_offset	= offsetof(struct rxe_qp, pelem),
+		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_QP_INDEX,
@@ -50,14 +50,14 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
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
 		.max_index	= RXE_MAX_MR_INDEX,
@@ -66,7 +66,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
-		.elem_offset	= offsetof(struct rxe_mw, pelem),
+		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.max_index	= RXE_MAX_MW_INDEX,
@@ -75,7 +75,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
 		.size		= sizeof(struct rxe_mc_grp),
-		.elem_offset	= offsetof(struct rxe_mc_grp, pelem),
+		.elem_offset	= offsetof(struct rxe_mc_grp, elem),
 		.flags		= RXE_POOL_KEY,
 		.key_offset	= offsetof(struct rxe_mc_grp, mgid),
 		.key_size	= sizeof(union ib_gid),
@@ -180,15 +180,15 @@ static u32 alloc_index(struct rxe_pool *pool)
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
 
 		/* this can happen if memory was recycled and/or the
 		 * old object was not deleted from the pool index
@@ -211,16 +211,16 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
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
 			     (u8 *)new + pool->key.key_offset,
@@ -243,7 +243,7 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return 0;
 }
 
-static int rxe_add_index(struct rxe_pool_entry *elem)
+static int rxe_add_index(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int err;
@@ -257,7 +257,7 @@ static int rxe_add_index(struct rxe_pool_entry *elem)
 	return err;
 }
 
-static void rxe_drop_index(struct rxe_pool_entry *elem)
+static void rxe_drop_index(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -267,7 +267,7 @@ static void rxe_drop_index(struct rxe_pool_entry *elem)
 
 static void *__rxe_alloc_locked(struct rxe_pool *pool)
 {
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	void *obj;
 	int err;
 
@@ -278,7 +278,7 @@ static void *__rxe_alloc_locked(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
+	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
 	elem->obj = obj;
@@ -300,14 +300,14 @@ static void *__rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	void *obj;
 
 	obj = __rxe_alloc_locked(pool);
 	if (!obj)
 		return NULL;
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_elem *)(obj + pool->elem_offset);
 	refcount_set(&elem->refcnt, 1);
 
 	return obj;
@@ -315,7 +315,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 {
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	void *obj;
 	int err;
 
@@ -323,7 +323,7 @@ void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 	if (!obj)
 		return NULL;
 
-	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
+	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	err = rxe_insert_key(pool, elem);
 	if (err) {
@@ -362,7 +362,7 @@ void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
 	return obj;
 }
 
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err;
 
@@ -393,13 +393,13 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	void *obj = NULL;
 
 	node = pool->index.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, index_node);
+		elem = rb_entry(node, struct rxe_pool_elem, index_node);
 
 		if (elem->index > index)
 			node = node->rb_left;
@@ -429,14 +429,14 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
-	struct rxe_pool_entry *elem;
+	struct rxe_pool_elem *elem;
 	void *obj = NULL;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
 
 	while (node) {
-		elem = rb_entry(node, struct rxe_pool_entry, key_node);
+		elem = rb_entry(node, struct rxe_pool_elem, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
 			     key, pool->key.key_size);
@@ -466,7 +466,7 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 	return obj;
 }
 
-int __rxe_add_ref_locked(struct rxe_pool_entry *elem)
+int __rxe_add_ref_locked(struct rxe_pool_elem *elem)
 {
 	int done;
 
@@ -477,7 +477,7 @@ int __rxe_add_ref_locked(struct rxe_pool_entry *elem)
 		return -EINVAL;
 }
 
-int __rxe_add_ref(struct rxe_pool_entry *elem)
+int __rxe_add_ref(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int ret;
@@ -489,7 +489,7 @@ int __rxe_add_ref(struct rxe_pool_entry *elem)
 	return ret;
 }
 
-int __rxe_drop_ref_locked(struct rxe_pool_entry *elem)
+int __rxe_drop_ref_locked(struct rxe_pool_elem *elem)
 {
 	int done;
 
@@ -500,7 +500,7 @@ int __rxe_drop_ref_locked(struct rxe_pool_entry *elem)
 		return -EINVAL;
 }
 
-int __rxe_drop_ref(struct rxe_pool_entry *elem)
+int __rxe_drop_ref(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int ret;
@@ -512,7 +512,7 @@ int __rxe_drop_ref(struct rxe_pool_entry *elem)
 	return ret;
 }
 
-static int __rxe_fini(struct rxe_pool_entry *elem)
+static int __rxe_fini(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int done;
@@ -533,7 +533,7 @@ static int __rxe_fini(struct rxe_pool_entry *elem)
 /* can only be used by pools that have a cleanup
  * routine that can run while holding a spinlock
  */
-int __rxe_fini_ref_locked(struct rxe_pool_entry *elem)
+int __rxe_fini_ref_locked(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int ret;
@@ -550,7 +550,7 @@ int __rxe_fini_ref_locked(struct rxe_pool_entry *elem)
 	return ret;
 }
 
-int __rxe_fini_ref(struct rxe_pool_entry *elem)
+int __rxe_fini_ref(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index f04df69c52ba..3e78c275c7c5 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -31,13 +31,13 @@ enum rxe_elem_type {
 	RXE_NUM_TYPES,		/* keep me last */
 };
 
-struct rxe_pool_entry;
+struct rxe_pool_elem;
 
 struct rxe_type_info {
 	const char		*name;
 	size_t			size;
 	size_t			elem_offset;
-	void			(*cleanup)(struct rxe_pool_entry *obj);
+	void			(*cleanup)(struct rxe_pool_elem *obj);
 	enum rxe_pool_flags	flags;
 	u32			max_index;
 	u32			min_index;
@@ -45,7 +45,7 @@ struct rxe_type_info {
 	size_t			key_size;
 };
 
-struct rxe_pool_entry {
+struct rxe_pool_elem {
 	struct rxe_pool		*pool;
 	void			*obj;
 	refcount_t		refcnt;
@@ -63,7 +63,7 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	void			(*cleanup)(struct rxe_pool_entry *obj);
+	void			(*cleanup)(struct rxe_pool_elem *obj);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
@@ -110,9 +110,9 @@ void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key);
 void *rxe_alloc_with_key(struct rxe_pool *pool, void *key);
 
 /* connect already allocated object to pool */
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
 
-#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
 /* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
@@ -129,32 +129,32 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
 /* take a reference on an object */
-int __rxe_add_ref_locked(struct rxe_pool_entry *elem);
+int __rxe_add_ref_locked(struct rxe_pool_elem *elem);
 
-#define rxe_add_ref_locked(obj) __rxe_add_ref_locked(&(obj)->pelem)
+#define rxe_add_ref_locked(obj) __rxe_add_ref_locked(&(obj)->elem)
 
-int __rxe_add_ref(struct rxe_pool_entry *elem);
+int __rxe_add_ref(struct rxe_pool_elem *elem);
 
-#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->pelem)
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->elem)
 
 /* drop a reference on an object */
-int __rxe_drop_ref_locked(struct rxe_pool_entry *elem);
+int __rxe_drop_ref_locked(struct rxe_pool_elem *elem);
 
-#define rxe_drop_ref_locked(obj) __rxe_drop_ref_locked(&(obj)->pelem)
+#define rxe_drop_ref_locked(obj) __rxe_drop_ref_locked(&(obj)->elem)
 
-int __rxe_drop_ref(struct rxe_pool_entry *elem);
+int __rxe_drop_ref(struct rxe_pool_elem *elem);
 
-#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->pelem)
+#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->elem)
 
 /* drop last reference on an object */
-int __rxe_fini_ref_locked(struct rxe_pool_entry *elem);
+int __rxe_fini_ref_locked(struct rxe_pool_elem *elem);
 
-#define rxe_fini_ref_locked(obj) __rxe_fini_ref_locked(&(obj)->pelem)
+#define rxe_fini_ref_locked(obj) __rxe_fini_ref_locked(&(obj)->elem)
 
-int __rxe_fini_ref(struct rxe_pool_entry *elem);
+int __rxe_fini_ref(struct rxe_pool_elem *elem);
 
-#define rxe_fini_ref(obj) __rxe_fini_ref(&(obj)->pelem)
+#define rxe_fini_ref(obj) __rxe_fini_ref(&(obj)->elem)
 
-#define rxe_read_ref(obj) refcount_read(&(obj)->pelem.refcnt)
+#define rxe_read_ref(obj) refcount_read(&(obj)->elem.refcnt)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 23b4ffe23c4f..f1b89585d6e0 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -163,7 +163,7 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 	qp->attr.path_mtu	= 1;
 	qp->mtu			= ib_mtu_enum_to_int(qp->attr.path_mtu);
 
-	qpn			= qp->pelem.index;
+	qpn			= qp->elem.index;
 	port			= &rxe->port;
 
 	switch (init->qp_type) {
@@ -825,9 +825,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 }
 
 /* called when the last reference to the qp is dropped */
-void rxe_qp_cleanup(struct rxe_pool_entry *arg)
+void rxe_qp_cleanup(struct rxe_pool_elem *arg)
 {
-	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
+	struct rxe_qp *qp = container_of(arg, typeof(*qp), elem);
 
 	rxe_qp_destroy(qp);
 	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index bb00643a2929..66273342da9f 100644
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
 
@@ -155,9 +155,9 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 	return err;
 }
 
-void rxe_srq_cleanup(struct rxe_pool_entry *arg)
+void rxe_srq_cleanup(struct rxe_pool_elem *arg)
 {
-	struct rxe_srq *srq = container_of(arg, typeof(*srq), pelem);
+	struct rxe_srq *srq = container_of(arg, typeof(*srq), elem);
 
 	if (srq->rq.queue)
 		rxe_queue_cleanup(srq->rq.queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 2b0ba33cff31..eea89873215d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -180,7 +180,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		return err;
 
 	/* create index > 0 */
-	ah->ah_num = ah->pelem.index;
+	ah->ah_num = ah->elem.index;
 
 	if (uresp) {
 		/* only if new user provider */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 0cfbef7a36c9..52e8752d2983 100644
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
@@ -208,7 +208,7 @@ struct rxe_resp_info {
 
 struct rxe_qp {
 	struct ib_qp		ibqp;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct ib_qp_attr	attr;
 	unsigned int		valid;
 	unsigned int		mtu;
@@ -308,7 +308,7 @@ static inline int rkey_is_mw(u32 rkey)
 }
 
 struct rxe_mr {
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	struct ib_mr		ibmr;
 
 	struct ib_umem		*umem;
@@ -341,7 +341,7 @@ enum rxe_mw_state {
 
 struct rxe_mw {
 	struct ib_mw		ibmw;
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	spinlock_t		lock;
 	enum rxe_mw_state	state;
 	struct rxe_qp		*qp; /* Type 2 only */
@@ -353,7 +353,7 @@ struct rxe_mw {
 };
 
 struct rxe_mc_grp {
-	struct rxe_pool_entry	pelem;
+	struct rxe_pool_elem	elem;
 	spinlock_t		mcg_lock; /* guard group */
 	struct rxe_dev		*rxe;
 	struct list_head	qp_list;
@@ -364,7 +364,7 @@ struct rxe_mc_grp {
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
+void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 
 #endif /* RXE_VERBS_H */
-- 
2.30.2

