Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659C1245320
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgHOV6l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgHOVv4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:56 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DFC0612A9
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:04 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v6so9231626ota.13
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNn6DgF0DEbAh+W686WloM5i48GDC+a89KgrtroiUmU=;
        b=fo/bk+X7uP/mRjG2CA40VzsFYEr/KbI3JoEPYa31jkdBMdalfUdTB8DDxB8q+dinaT
         VUqHdoLr6fNsmjGtkGKO3UU/jMLD+qQnWGvGfTBIjqClOcJ2qtuTTOrL941iZqhRCc9c
         /J6RhZ+i8vhl+n8ocH16TOr68hOovia45xiCducI7waInpplEttwgVG5R4/mZzPckOBu
         ftEjnUJ52OJ44CvmD1N7iRgolT1Q+q5sWf76/oEzl2bpJQCDPAKZs05ZRICpewMqshad
         As+dkQNa//Ya555Owcn++FJcgDN1outJJCHDchMIW92Mf3JRpAWN3MzKIC/CidjlDK9S
         GKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNn6DgF0DEbAh+W686WloM5i48GDC+a89KgrtroiUmU=;
        b=j0SVZzotrsi0CXjwpB7oC0o/afoE2YsgRKvijScF5T+KV4JIlDsusSnWTMscNZkQ7j
         q076PahlTWm1EPQbhDyON6eEYCV+yNBS5chp5FXeqsEyVDAuUzk8iXaABLMtVtfEZyM7
         Ry+5ujV0B0/KtrXPm9qif9u5O7xWmhq6qca4/xH7mC2cbGpGKLBBoOvW3H83pmpv9rTk
         okMRAbaI0uhgiDA2FzLyOEHCNAEj7VVOM3cXzq5Qy5tdOglCVIUeSqfijAiklJaMx7cv
         Jh5uDktM/VM5gLmQCQZWic1ce9P4Ce/vh3a38OHUH+QcQHs6pLxz0iqJntU7NTZvyhhQ
         euxA==
X-Gm-Message-State: AOAM530Wm8mcHMB1NhWno1uty930NasBYld+A84r7MCIvYwgmVRvQPOz
        y1xiCwSkKya2q1ItVJPv9ydbyj+nYTXppw==
X-Google-Smtp-Source: ABdhPJz9kAuXAheuMALlKHzaXjUh11JgZPzXQw1lH1jKLWJ3vXGYBn1CocGrI0cMebdeDs/Lh31Unw==
X-Received: by 2002:a9d:454d:: with SMTP id p13mr4021976oti.294.1597467603153;
        Fri, 14 Aug 2020 22:00:03 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id 3sm2194979oix.24.2020.08.14.22.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 11/20] Gave MRs and MWs both keys and indices
Date:   Fri, 14 Aug 2020 23:58:35 -0500
Message-Id: <20200815045912.8626-12-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Finished decoupling indices and keys for MW and MR
objects. Now user space can refer to an object by index and kernel can lookup
object with l/rkey.

Tweaked the user/kernel ABI for rxe WQEs to use indices instead of rkeys to
identify MWs and MRs.

Type 1 MWs can now be bound with the ibv_bind_mw api.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +
 drivers/infiniband/sw/rxe/rxe_mr.c    |  55 +++++++-----
 drivers/infiniband/sw/rxe/rxe_mw.c    | 116 ++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_pool.c  |  30 ++++---
 drivers/infiniband/sw/rxe/rxe_pool.h  |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  28 ++++++-
 include/uapi/rdma/rdma_user_rxe.h     |  34 +++++++-
 7 files changed, 212 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 02df9bf76d1a..87d323b1ba07 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -98,6 +98,8 @@ struct rxe_mmap_info *rxe_create_mmap_info(struct rxe_dev *dev, u32 size,
 int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 
 /* rxe_mr.c */
+void rxe_set_mr_lkey(struct rxe_mr *mr);
+
 enum copy_direction {
 	to_mr_obj,
 	from_mr_obj,
@@ -137,6 +139,7 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
 
 /* rxe_mw.c */
+void rxe_set_mw_rkey(struct rxe_mw *mw);
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata);
 int rxe_dealloc_mw(struct ib_mw *ibmw);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 0606f04e1d18..ba4e33227633 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -34,6 +34,23 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* choose a unique non zero random number for lkey */
+void rxe_set_mr_lkey(struct rxe_mr *mr)
+{
+	int ret;
+	u32 lkey;
+
+next_lkey:
+	get_random_bytes(&lkey, sizeof(lkey));
+	lkey &= 0x7fffffff;
+	if (unlikely(lkey == 0))
+		goto next_lkey;
+	ret = rxe_add_key(mr, &lkey);
+	if (unlikely(ret == -EAGAIN))
+		goto next_lkey;
+}
+
+#if 0
 /*
  * lfsr (linear feedback shift register) with period 255
  */
@@ -50,6 +67,7 @@ static u8 rxe_get_key(void)
 
 	return key;
 }
+#endif
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
@@ -76,16 +94,16 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 static void rxe_mr_init(int access, struct rxe_mr *mr)
 {
-	u32 lkey = mr->pelem.index << 8 | rxe_get_key();
-	u32 rkey = (access & IB_ACCESS_REMOTE) ? lkey : 0;
+	rxe_set_mr_lkey(mr);
 
-	if (mr->pelem.pool->type == RXE_TYPE_MR) {
-		mr->ibmr.lkey		= lkey;
-		mr->ibmr.rkey		= rkey;
-	}
+	if (access & IB_ACCESS_REMOTE)
+		mr->ibmr.rkey = mr->ibmr.lkey;
+	else
+		mr->ibmr.rkey = 0;
 
-	mr->lkey		= lkey;
-	mr->rkey		= rkey;
+	// TODO we shouldn't carry two copies
+	mr->lkey		= mr->ibmr.lkey;
+	mr->rkey		= mr->ibmr.rkey;
 	mr->state		= RXE_MEM_STATE_INVALID;
 	mr->type		= RXE_MEM_TYPE_NONE;
 	mr->map_shift		= ilog2(RXE_BUF_PER_MAP);
@@ -155,9 +173,9 @@ void rxe_mr_init_dma(struct rxe_pd *pd,
 	mr->type		= RXE_MEM_TYPE_DMA;
 }
 
-int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
-		      u64 length, u64 iova, int access, struct ib_udata *udata,
-		      struct rxe_mr *mr)
+int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length,
+		     u64 iova, int access, struct ib_udata *udata,
+		     struct rxe_mr *mr)
 {
 	struct rxe_map		**map;
 	struct rxe_phys_buf	*buf = NULL;
@@ -233,15 +251,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start,
 	return err;
 }
 
-int rxe_mr_init_fast(struct rxe_pd *pd,
-		      int max_pages, struct rxe_mr *mr)
+int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages,
+		     struct rxe_mr *mr)
 {
 	int err;
 
 	rxe_mr_init(0, mr);
 
 	/* In fastreg, we also set the rkey */
-	mr->ibmr.rkey = mr->ibmr.lkey;
+	mr->rkey = mr->ibmr.rkey = mr->ibmr.lkey;
 
 	err = rxe_mr_alloc(mr, max_pages);
 	if (err)
@@ -564,18 +582,17 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
  * (4) verify that mr state is valid
  */
 struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
-			   enum lookup_type type)
+			 enum lookup_type type)
 {
 	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
-	int index = key >> 8;
 
-	mr = rxe_pool_get_index(&rxe->mr_pool, index);
+	mr = rxe_pool_get_key(&rxe->mr_pool, &key);
 	if (!mr)
 		return NULL;
 
-	if (unlikely((type == lookup_local && mr->lkey != key) ||
-		     (type == lookup_remote && mr->rkey != key) ||
+	if (unlikely((type == lookup_local && mr->ibmr.lkey != key) ||
+		     (type == lookup_remote && mr->ibmr.rkey != key) ||
 		     mr->pd != pd ||
 		     (access && !(access & mr->access)) ||
 		     mr->state != RXE_MEM_STATE_VALID)) {
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 230263c6d3e5..b45a04efa4a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -35,49 +35,95 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* choose a unique non zero random number for rkey */
+void rxe_set_mw_rkey(struct rxe_mw *mw)
+{
+	int ret;
+	u32 rkey;
+
+next_rkey:
+	get_random_bytes(&rkey, sizeof(rkey));
+	if (unlikely(rkey == 0))
+		goto next_rkey;
+	rkey |= 0x80000000;
+	ret = rxe_add_key(mw, &rkey);
+	if (unlikely(ret == -EAGAIN))
+		goto next_rkey;
+}
+
 /* place holder alloc and dealloc routines
- * need to add cross references between qp and mr with mw
+ * TODO add cross references between qp and mr with mw
  * and cleanup when one side is deleted. Enough to make
  * verbs function correctly for now */
 struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
 			   struct ib_udata *udata)
 {
+	int ret;
+	struct rxe_mw *mw;
 	struct rxe_pd *pd = to_rpd(ibpd);
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
-	struct rxe_mw *mw;
-	u32 rkey;
-	u8 key;
+	struct rxe_alloc_mw_resp __user *uresp;
+
+	if (udata) {
+		if (udata->outlen < sizeof(*uresp)) {
+			ret = -EINVAL;
+			goto err1;
+		}
+	}
 
 	if (unlikely((type != IB_MW_TYPE_1) &&
-		     (type != IB_MW_TYPE_2)))
-		return ERR_PTR(-EINVAL);
+		     (type != IB_MW_TYPE_2))) {
+		ret = -EINVAL;
+		goto err1;
+	}
 
 	rxe_add_ref(pd);
 
 	mw = rxe_alloc(&rxe->mw_pool);
 	if (!mw) {
 		rxe_drop_ref(pd);
-		return ERR_PTR(-ENOMEM);
+		ret = -ENOMEM;
+		goto err1;
 	}
 
-	/* pick a random key part as a starting point */
 	rxe_add_index(mw);
-	get_random_bytes(&key, sizeof(key));
-	rkey = mw->pelem.index << 8 | key;
+	rxe_set_mw_rkey(mw);
+
+	pr_info("rxe_alloc_mw: index = 0x%08x, rkey = 0x%08x\n",
+			mw->pelem.index, mw->ibmw.rkey);
 
 	spin_lock_init(&mw->lock);
+
+	if (type == IB_MW_TYPE_2) {
+		mw->state		= RXE_MW_STATE_FREE;
+	} else {
+		mw->state		= RXE_MW_STATE_VALID;
+	}
+
 	mw->qp			= NULL;
 	mw->mr			= NULL;
 	mw->addr		= 0;
 	mw->length		= 0;
         mw->ibmw.pd		= ibpd;
         mw->ibmw.type		= type;
-        mw->ibmw.rkey		= rkey;
-	mw->state		= (type == IB_MW_TYPE_2) ?
-					RXE_MW_STATE_FREE :
-					RXE_MW_STATE_VALID;
+
+	if (udata) {
+		uresp = udata->outbuf;
+		if (copy_to_user(&uresp->index, &mw->pelem.index,
+				 sizeof(u32))) {
+			ret = -EFAULT;
+			goto err2;
+		}
+	}
 
 	return &mw->ibmw;
+err2:
+	rxe_drop_key(mw);
+	rxe_drop_index(mw);
+	rxe_drop_ref(mw);
+	rxe_drop_ref(pd);
+err1:
+	return ERR_PTR(ret);
 }
 
 int rxe_dealloc_mw(struct ib_mw *ibmw)
@@ -90,8 +136,9 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	mw->state = RXE_MW_STATE_INVALID;
 	spin_unlock_irqrestore(&mw->lock, flags);
 
-	rxe_drop_ref(pd);
+	rxe_drop_key(mw);
 	rxe_drop_index(mw);
+	rxe_drop_ref(pd);
 	rxe_drop_ref(mw);
 
 	return 0;
@@ -99,6 +146,41 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 
 int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
-	pr_err("rxe_bind_mw: not implemented\n");
-	return -ENOSYS;
+	struct rxe_mw *mw;
+	struct rxe_mr *mr;
+
+	pr_info("rxe_bind_mw: called\n");
+
+	if (qp->is_user) {
+	} else {
+		mw = to_rmw(wqe->wr.wr.kmw.ibmw);
+		mr = to_rmr(wqe->wr.wr.kmw.ibmr);
+	}
+
+#if 0
+	wqe->wr.wr.bind_mw
+	__aligned_u64	addr;
+	__aligned_u64	length;
+	__u32	mr_rkey;
+	__u32	mw_rkey;
+	__u32	rkey;
+	__u32	access;
+
+	mw
+	struct rxe_pool_entry	pelem;			// alloc
+	struct ib_mw		ibmw;			// alloc
+		struct ib_device	*device;	// alloc
+		struct ib_pd		*pd;		// alloc
+		struct ib_uobject	*uobject;	// alloc
+		u32			rkey;
+		enum ib_mw_type         type;		// alloc
+	struct rxe_qp		*qp;			// bind
+	struct rxe_mem		*mr;			// bind
+	spinlock_t		lock;			// alloc
+	enum rxe_mw_state	state;			// all
+	u32			access;			// bind
+	u64			addr;			// bind
+	u64			length;			// bind
+#endif
+	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index e157bf945175..35e9646e104c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -34,10 +34,6 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* info about object pools
- * note that mr and mw share a single index space
- * so that one can map an lkey to the correct type of object
- */
 struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
@@ -79,16 +75,22 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-mr",
 		.size		= sizeof(struct rxe_mr),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
+		.key_offset	= offsetof(struct rxe_mr, ibmr.lkey),
+		.key_size	= sizeof(u32),
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
 		.size		= sizeof(struct rxe_mw),
-		.flags		= RXE_POOL_INDEX,
+		.flags		= RXE_POOL_INDEX
+				| RXE_POOL_KEY,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
+		.key_offset	= offsetof(struct rxe_mw, ibmw.rkey),
+		.key_size	= sizeof(u32),
 	},
 	[RXE_TYPE_MC_GRP] = {
 		.name		= "rxe-mc_grp",
@@ -308,8 +310,9 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
+	int ret;
 	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct rxe_pool_entry *elem;
@@ -323,7 +326,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
 
 		if (cmp == 0) {
-			pr_warn("key already exists!\n");
+			ret = -EAGAIN;
 			goto out;
 		}
 
@@ -335,20 +338,25 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 	rb_link_node(&new->key_node, parent, link);
 	rb_insert_color(&new->key_node, &pool->key.tree);
+
+	ret = 0;
 out:
-	return;
+	return ret;
 }
 
-void rxe_add_key(void *arg, void *key)
+int rxe_add_key(void *arg, void *key)
 {
+	int ret;
 	struct rxe_pool_entry *elem = arg;
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	insert_key(pool, elem);
+	ret = insert_key(pool, elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
 }
 
 void rxe_drop_key(void *arg)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index bd684df6d847..0ba811456f79 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -156,7 +156,7 @@ void rxe_drop_index(void *elem);
 /* assign a key to a keyed object and insert object into
  *  pool's rb tree
  */
-void rxe_add_key(void *elem, void *key);
+int rxe_add_key(void *elem, void *key);
 
 /* remove elem from rb tree */
 void rxe_drop_key(void *elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index cac0f3f0c7c1..29191cacfc56 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -911,9 +911,20 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 				     int access, struct ib_udata *udata)
 {
 	int err;
+	struct rxe_mr *mr;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
-	struct rxe_mr *mr;
+	struct rxe_reg_mr_resp __user *uresp = NULL;
+
+	if (udata) {
+		if (udata->outlen < sizeof(*uresp)) {
+			err = -EINVAL;
+			goto err2;
+		}
+		uresp = udata->outbuf;
+	}
+
+	rxe_add_ref(pd);
 
 	mr = rxe_alloc(&rxe->mr_pool);
 	if (!mr) {
@@ -923,19 +934,28 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 	rxe_add_index(mr);
 
-	rxe_add_ref(pd);
-
 	err = rxe_mr_init_user(pd, start, length, iova,
 				access, udata, mr);
 	if (err)
 		goto err3;
 
+	pr_info("rxe_reg_user_mr: index = 0x%08x, rkey = 0x%08x\n",
+			mr->pelem.index, mr->ibmr.rkey);
+
+	if (uresp) {
+		if (copy_to_user(&uresp->index, &mr->pelem.index,
+				 sizeof(uresp->index))) {
+			err = -EFAULT;
+			goto err3;
+		}
+	}
+
 	return &mr->ibmr;
 
 err3:
-	rxe_drop_ref(pd);
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
+	rxe_drop_ref(pd);
 err2:
 	return ERR_PTR(err);
 }
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index f88867d85c3f..c1e84cd69c37 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -96,12 +96,28 @@ struct rxe_send_wr {
 		struct {
 			__aligned_u64	addr;
 			__aligned_u64	length;
-			__u32	mr_rkey;
-			__u32	mw_rkey;
+			__u32	mr_index;
+			__u32   pad1;
+			__u32	mw_index;
+			__u32   pad2;
 			__u32	rkey;
 			__u32	access;
-		} bind_mw;
-		/* reg is only used by the kernel and is not part of the uapi */
+		} umw;
+		/* below are only used by the kernel */
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			union {
+				struct ib_mr	*ibmr;
+				__aligned_u64   reserved1;
+			};
+			union {
+				struct ib_mw	*ibmw;
+				__aligned_u64   reserved2;
+			};
+			__u32	rkey;
+			__u32	access;
+		} kmw;
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -183,4 +199,14 @@ struct rxe_modify_srq_cmd {
 	__aligned_u64 mmap_info_addr;
 };
 
+struct rxe_reg_mr_resp {
+	__u32 index;
+	__u32 reserved;
+};
+
+struct rxe_alloc_mw_resp {
+	__u32 index;
+	__u32 reserved;
+};
+
 #endif /* RDMA_USER_RXE_H */
-- 
2.25.1

