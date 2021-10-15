Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5242FE3E
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbhJOWgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243364AbhJOWgG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:06 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE9C061570
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so5843ote.6
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+YSfFZg68UPAaK98QVqm3782JOahrkZ3lmkfME30F4=;
        b=NTJcZGB/VbGEamcvea4Sq37NCiL/GLaUnoSQeqehUBem/6ptpoeMrWX30miAKE2Udh
         5O/Y7RiGNo38y5R1AG5dU92qwBpELjo7C1B5uu/jp9aP4q46WksTv+ToTOfrRG/b6Vhm
         z2qom+a2MRjlrKnntK7InGYZP0aWknLlKyupwqyz/hgktrJNigIPB3ehUrYkHbGoKVm3
         n3jrvjm8A9vzVCK7LkrsX3pUHOIh6IEk7bQ3cmt84WPULPIaAxwLoNAu1BaJspYx8LNB
         /z6ihwMaVzJ1MDR7nQvl00Vum3zESofuNyYKiLlJ4Kq6AXMa32zMX0Sfs9u1vMdjNafy
         NjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+YSfFZg68UPAaK98QVqm3782JOahrkZ3lmkfME30F4=;
        b=XQv0wip8UQXpzhQJvfN3DWPhIHAfrE4mT+D0U22nYW3TgdP7znWivZHjnm0Iy3h6Ul
         /Kkh5R/WHkUurW/n0TjBPoo15Hs84gD4YVWIoSpvhabLV4AIekEfh9OOYvxTqu/EERNt
         GruIbXe8IQ3ESu0kuErNk/222fESIS3LY74IJ3tSTzM/6MLIMmWs2AuYTbOsmJmy/6LQ
         N295rwyKC9Rt278jl0DTz6L3U9gLL5VWPvbxQBp0uIfyPfpHHvJeIviACZYDTnIdFkUI
         OdA1HCLsbFlpq+jvfeFJZWDq/hiZXKcCC3VxnwYY6PNIVYasi98pPHQNU7sxVb63Ks0H
         198A==
X-Gm-Message-State: AOAM530TUYKb2P8T/TydH0DSRctCJ4aXZg4IoXUevO0nJ8V+DUmWaxze
        VPBeEDEjVon5DmFgY7A4zRo=
X-Google-Smtp-Source: ABdhPJzMzMy+VUJm+W0eg0jEaR+E6761ete7F+3BLmzuDu5jAMEDMcFgrfvCjRTfcYlHtrcAl5DC8g==
X-Received: by 2002:a9d:490e:: with SMTP id e14mr10188157otf.194.1634337239245;
        Fri, 15 Oct 2021 15:33:59 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 07/10] RDMA/rxe: Separate out last rxe_drop_ref
Date:   Fri, 15 Oct 2021 17:32:48 -0500
Message-Id: <20211015223250.6501-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe_drop_ref() can be called from a destroy or deallocate
verb or from someone releasing a reference protecting a pointer. This
leads to the possibility that the object will be destroyed after rdma-core
thinks it has. This was the original intent of using kref's but can
cause other problems.

This patch separates out the last rxe_drop_ref as rxe_fini_ref()
which can return an error if the object is not ready to be destroyed
and changes rxe_drop_ref() to return an error if the object has already
been destroyed. Now the destroy verbs will return -EBUSY if the object
cannot be destroyed and other add/drop references will return -EINVAL
if the object has already or would be destroyed. Correct programs should
not normally return these values.

Locking is added so that cleanup is executed atomically. Some drop
references have their order changed so references are dropped after
the pointer they protect has been successfully removed.

This patch exposes some referencing errors which are addressed in the
following patches.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    |   9 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  23 ++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 148 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  37 ++++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |   1 +
 drivers/infiniband/sw/rxe/rxe_srq.c   |   8 ++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  40 ++++---
 9 files changed, 192 insertions(+), 87 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 6848426c074f..0c05d612ae63 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -141,18 +141,15 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	return 0;
 }
 
-void rxe_cq_disable(struct rxe_cq *cq)
+void rxe_cq_cleanup(struct rxe_pool_entry *arg)
 {
+	struct rxe_cq *cq = container_of(arg, typeof(*cq), pelem);
 	unsigned long flags;
 
+	/* TODO get rid of this */
 	spin_lock_irqsave(&cq->cq_lock, flags);
 	cq->is_dying = true;
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
-}
-
-void rxe_cq_cleanup(struct rxe_pool_entry *arg)
-{
-	struct rxe_cq *cq = container_of(arg, typeof(*cq), pelem);
 
 	if (cq->queue)
 		rxe_queue_cleanup(cq->queue);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1ca43b859d80..a25d1c9f6adb 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -35,8 +35,6 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int new_cqe,
 
 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited);
 
-void rxe_cq_disable(struct rxe_cq *cq);
-
 void rxe_cq_cleanup(struct rxe_pool_entry *arg);
 
 /* rxe_mcast.c */
@@ -187,6 +185,7 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
 int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 		      struct ib_srq_attr *attr, enum ib_srq_attr_mask mask,
 		      struct rxe_modify_srq_cmd *ucmd, struct ib_udata *udata);
+void rxe_srq_cleanup(struct rxe_pool_entry *arg);
 
 void rxe_dealloc(struct ib_device *ib_dev);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6e71f67ccfe9..6c50c8562fd8 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -684,6 +684,8 @@ int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr)
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
+	struct rxe_pd *pd = mr_pd(mr);
+	int err;
 
 	if (atomic_read(&mr->num_mw) > 0) {
 		pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
@@ -692,8 +694,12 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	mr->state = RXE_MR_STATE_INVALID;
-	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_ref(mr);
+
+	err = rxe_fini_ref(mr);
+	if (err)
+		return err;
+
+	rxe_drop_ref(pd);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 854d0c283521..599699f93332 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -56,12 +56,15 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 	struct rxe_mw *mw = to_rmw(ibmw);
 	struct rxe_pd *pd = to_rpd(ibmw->pd);
 	unsigned long flags;
+	int err;
 
 	spin_lock_irqsave(&mw->lock, flags);
 	rxe_do_dealloc_mw(mw);
 	spin_unlock_irqrestore(&mw->lock, flags);
 
-	rxe_drop_ref(mw);
+	err = rxe_fini_ref(mw);
+	if (err)
+		return err;
 	rxe_drop_ref(pd);
 
 	return 0;
@@ -177,9 +180,9 @@ static void rxe_do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	}
 
 	if (mw->length) {
+		/* take over ref on mr from caller */
 		mw->mr = mr;
 		atomic_inc(&mr->num_mw);
-		rxe_add_ref(mr);
 	}
 
 	if (mw->ibmw.type == IB_MW_TYPE_2) {
@@ -192,7 +195,7 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 {
 	int ret;
 	struct rxe_mw *mw;
-	struct rxe_mr *mr;
+	struct rxe_mr *mr = NULL;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 	u32 mw_rkey = wqe->wr.wr.mw.mw_rkey;
 	u32 mr_lkey = wqe->wr.wr.mw.mr_lkey;
@@ -217,25 +220,23 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 		}
 
 		if (unlikely(mr->lkey != mr_lkey)) {
+			rxe_drop_ref(mr);
 			ret = -EINVAL;
-			goto err_drop_mr;
+			goto err_drop_mw;
 		}
-	} else {
-		mr = NULL;
 	}
 
 	spin_lock_irqsave(&mw->lock, flags);
-
 	ret = rxe_check_bind_mw(qp, wqe, mw, mr);
-	if (ret)
+	if (ret) {
+		if (mr)
+			rxe_drop_ref(mr);
 		goto err_unlock;
+	}
 
 	rxe_do_bind_mw(qp, wqe, mw, mr);
 err_unlock:
 	spin_unlock_irqrestore(&mw->lock, flags);
-err_drop_mr:
-	if (mr)
-		rxe_drop_ref(mr);
 err_drop_mw:
 	rxe_drop_ref(mw);
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index e9c5e4e887c3..955bb283c76a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -33,6 +33,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, pelem),
+		.cleanup	= rxe_srq_cleanup,
 		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
@@ -195,8 +196,11 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		parent = *link;
 		elem = rb_entry(parent, struct rxe_pool_entry, index_node);
 
-		if (elem->index == new->index) {
-			pr_warn("element with index = 0x%x already exists!\n",
+		/* this can happen if memory was recycled and/or the
+		 * old object was not deleted from the pool index
+		 */
+		if (unlikely(elem == new || elem->index == new->index)) {
+			pr_warn("%s#%d: already in pool\n", pool->name,
 					new->index);
 			return -EINVAL;
 		}
@@ -310,7 +314,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 		return NULL;
 
 	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
-	kref_init(&elem->ref_cnt);
+	refcount_set(&elem->refcnt, 1);
 
 	return obj;
 }
@@ -333,7 +337,7 @@ void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 		goto out_cnt;
 	}
 
-	kref_init(&elem->ref_cnt);
+	refcount_set(&elem->refcnt, 1);
 
 	return obj;
 
@@ -384,7 +388,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 			goto out_cnt;
 	}
 
-	kref_init(&elem->ref_cnt);
+	refcount_set(&elem->refcnt, 1);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return 0;
@@ -395,30 +399,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 	return -EINVAL;
 }
 
-void rxe_elem_release(struct kref *kref)
-{
-	struct rxe_pool_entry *elem =
-		container_of(kref, struct rxe_pool_entry, ref_cnt);
-	struct rxe_pool *pool = elem->pool;
-	void *obj;
-
-	if (pool->cleanup)
-		pool->cleanup(elem);
-
-	if (pool->flags & RXE_POOL_INDEX)
-		rxe_drop_index(elem);
-
-	if (pool->flags & RXE_POOL_KEY)
-		rb_erase(&elem->key_node, &pool->key.tree);
-
-	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
-		obj = elem->obj;
-		kfree(obj);
-	}
-
-	atomic_dec(&pool->num_elem);
-}
-
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
@@ -438,7 +418,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 			break;
 	}
 
-	if (node && kref_get_unless_zero(&elem->ref_cnt))
+	if (node && refcount_inc_not_zero(&elem->refcnt))
 		obj = elem->obj;
 
 	return obj;
@@ -479,7 +459,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 			break;
 	}
 
-	if (node && kref_get_unless_zero(&elem->ref_cnt))
+	if (node && refcount_inc_not_zero(&elem->refcnt))
 		obj = elem->obj;
 
 	return obj;
@@ -496,3 +476,109 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 
 	return obj;
 }
+
+int __rxe_add_ref_locked(struct rxe_pool_entry *elem)
+{
+	int done;
+
+	done = refcount_inc_not_zero(&elem->refcnt);
+	if (done)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+int __rxe_add_ref(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	ret = __rxe_add_ref_locked(elem);
+	read_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
+}
+
+int __rxe_drop_ref_locked(struct rxe_pool_entry *elem)
+{
+	int done;
+
+	done = refcount_dec_not_one(&elem->refcnt);
+	if (done)
+		return 0;
+	else
+		return -EINVAL;
+}
+
+int __rxe_drop_ref(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	ret = __rxe_drop_ref_locked(elem);
+	read_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return ret;
+}
+
+static int __rxe_fini(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	int done;
+
+	done = refcount_dec_if_one(&elem->refcnt);
+	if (done) {
+		if (pool->flags & RXE_POOL_INDEX)
+			rxe_drop_index(elem);
+		if (pool->flags & RXE_POOL_KEY)
+			rb_erase(&elem->key_node, &pool->key.tree);
+		atomic_dec(&pool->num_elem);
+		return 0;
+	} else {
+		return -EBUSY;
+	}
+}
+
+/* can only be used by pools that have a cleanup
+ * routine that can run while holding a spinlock
+ */
+int __rxe_fini_ref_locked(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	int ret;
+
+	ret = __rxe_fini(elem);
+
+	if (!ret) {
+		if (pool->cleanup)
+			pool->cleanup(elem);
+		if (!(pool->flags & RXE_POOL_NO_ALLOC))
+			kfree(elem->obj);
+	}
+
+	return ret;
+}
+
+int __rxe_fini_ref(struct rxe_pool_entry *elem)
+{
+	struct rxe_pool *pool = elem->pool;
+	unsigned long flags;
+	int ret;
+
+	read_lock_irqsave(&pool->pool_lock, flags);
+	ret = __rxe_fini(elem);
+	read_unlock_irqrestore(&pool->pool_lock, flags);
+
+	if (!ret) {
+		if (pool->cleanup)
+			pool->cleanup(elem);
+		if (!(pool->flags & RXE_POOL_NO_ALLOC))
+			kfree(elem->obj);
+	}
+
+	return ret;
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 50083cb9530e..2fe1009145a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,6 +7,8 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
 
+#include <linux/refcount.h>
+
 #define RXE_POOL_ALIGN		(16)
 #define RXE_POOL_CACHE_FLAGS	(0)
 
@@ -47,7 +49,7 @@ struct rxe_type_info {
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
 	void			*obj;
-	struct kref		ref_cnt;
+	refcount_t		refcnt;
 	struct list_head	list;
 
 	/* only used if keyed */
@@ -127,24 +129,33 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
-
 /* take a reference on an object */
-static inline int __rxe_add_ref(struct rxe_pool_entry *elem)
-{
-	int ret = kref_get_unless_zero(&elem->ref_cnt);
+int __rxe_add_ref_locked(struct rxe_pool_entry *elem);
 
-	if (unlikely(!ret))
-		pr_warn("Taking a reference on a %s object that is already destroyed\n",
-			elem->pool->name);
+#define rxe_add_ref_locked(obj) __rxe_add_ref_locked(&(obj)->pelem)
 
-	return (ret) ? 0 : -EINVAL;
-}
+int __rxe_add_ref(struct rxe_pool_entry *elem);
 
 #define rxe_add_ref(obj) __rxe_add_ref(&(obj)->pelem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(obj) kref_put(&(obj)->pelem.ref_cnt, rxe_elem_release)
+int __rxe_drop_ref_locked(struct rxe_pool_entry *elem);
+
+#define rxe_drop_ref_locked(obj) __rxe_drop_ref_locked(&(obj)->pelem)
+
+int __rxe_drop_ref(struct rxe_pool_entry *elem);
+
+#define rxe_drop_ref(obj) __rxe_drop_ref(&(obj)->pelem)
+
+/* drop last reference on an object */
+int __rxe_fini_ref_locked(struct rxe_pool_entry *elem);
+
+#define rxe_fini_ref_locked(obj) __rxe_fini_ref_locked(&(obj)->pelem)
+
+int __rxe_fini_ref(struct rxe_pool_entry *elem);
+
+#define rxe_fini_ref(obj) __rxe_fini_ref(&(obj)->pelem)
+
+#define rxe_read_ref(obj) refcount_read(&(obj)->pelem.refcnt)
 
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 975321812c87..7503aebddcf4 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -835,5 +835,6 @@ void rxe_qp_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_qp *qp = container_of(arg, typeof(*qp), pelem);
 
+	rxe_qp_destroy(qp);
 	execute_in_process_context(rxe_qp_do_cleanup, &qp->cleanup_work);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index eb1c4c3b3a78..bb00643a2929 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -154,3 +154,11 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
 	srq->rq.queue = NULL;
 	return err;
 }
+
+void rxe_srq_cleanup(struct rxe_pool_entry *arg)
+{
+	struct rxe_srq *srq = container_of(arg, typeof(*srq), pelem);
+
+	if (srq->rq.queue)
+		rxe_queue_cleanup(srq->rq.queue);
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 84ea03bc6a26..ec1f72332737 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -115,7 +115,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_drop_ref(uc);
+	rxe_fini_ref(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -149,8 +149,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_drop_ref(pd);
-	return 0;
+	return rxe_fini_ref(pd);
 }
 
 static int rxe_create_ah(struct ib_ah *ibah,
@@ -228,8 +227,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_drop_ref(ah);
-	return 0;
+	return rxe_fini_ref(ah);
 }
 
 static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
@@ -313,8 +311,8 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err2:
+	rxe_fini_ref(srq);
 	rxe_drop_ref(pd);
-	rxe_drop_ref(srq);
 err1:
 	return err;
 }
@@ -367,12 +365,15 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
 static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
+	struct rxe_pd *pd = srq->pd;
+	int err;
 
-	if (srq->rq.queue)
-		rxe_queue_cleanup(srq->rq.queue);
+	err = rxe_fini_ref(srq);
+	if (err)
+		return err;
+
+	rxe_drop_ref(pd);
 
-	rxe_drop_ref(srq->pd);
-	rxe_drop_ref(srq);
 	return 0;
 }
 
@@ -437,12 +438,12 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
 	if (err)
-		goto qp_init;
+		goto err_fini;
 
 	return 0;
 
-qp_init:
-	rxe_drop_ref(qp);
+err_fini:
+	rxe_fini_ref(qp);
 	return err;
 }
 
@@ -485,9 +486,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct rxe_qp *qp = to_rqp(ibqp);
 
-	rxe_qp_destroy(qp);
-	rxe_drop_ref(qp);
-	return 0;
+	return rxe_fini_ref(qp);
 }
 
 static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
@@ -797,10 +796,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
-	rxe_cq_disable(cq);
-
-	rxe_drop_ref(cq);
-	return 0;
+	return rxe_fini_ref(cq);
 }
 
 static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
@@ -924,8 +920,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
+	rxe_fini_ref(mr);
 	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -956,8 +952,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
+	rxe_fini_ref(mr);
 	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.30.2

