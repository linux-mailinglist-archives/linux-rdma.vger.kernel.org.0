Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48580437E82
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJVTVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhJVTVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBFC061764
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s9so6290603oiw.6
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8y78ZaV1B/wQ9a1MLTFolvspCOSODCAFf3Dp4TXSvs=;
        b=mVQmBX6cPwnZWQDQU9dqf1BcoeuHla/ZnDuLH4jjaEFECXeCACNsUjoBDQFrRCI3NO
         esguPiPB4v8VN8E9R9WRwS4sgrnrYN58KdS45iuIwOe9wBFzDt+CF9mGCpxPGXSJcY9q
         xFtwZbLeWxMmTJr7Oy1OjTRurTlMrU+nm08AsMrjPm4ghv3QOKmIb5lQt5P/5OVZarej
         RE1Vj+cbwOXySJkkuTiyfqWvXbMuj8GgBESofuK6fSJZVpsxeRVtjCdwfo6XoW4P6h9/
         nZEinNkoFfrlIbFyMPXkrPDIlkV8JFXMcvGfPgdpds4yrfj4BFNffV0o9LrftcbeasIr
         cHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v8y78ZaV1B/wQ9a1MLTFolvspCOSODCAFf3Dp4TXSvs=;
        b=0skJozMiTYEChEIaNN9tm6Kjx/Daa7wF7v0GRAK6WnLQrEgYtP0mu0/DwJHXkeg7Fy
         UOoks9RONzuDzH25IjvEEoohMt3DOyhe9YIKtM9S6DHqjVzGTyrD6OF+x7A9d/3qsSvy
         5w971+rI7QcVbDudjI47ZJiRKbcIV2OMIgxkIkPrb7tItnB0BgZ2PcKDigWIKmReLu2M
         Z2/aiL6UTiikVBwaSYsDjpIWVMg+mN+uT13Sh8TZQnIY3dQ8SDgIsTcx8Z9PxlLLlWic
         3Fbf914XUtoQ5gj2LW1IbOicEJDIbCFPzTkzUrjEb5FoJqoWeubeIxpKPJgJeS+v9xG1
         JuOQ==
X-Gm-Message-State: AOAM533ZXaoHZGZ9rXamkBVA3og0ESoS93cevOKRa9Pert3sepVRnqKH
        WRhPCii5QEyGrk345p72/eC5n1LoLZg=
X-Google-Smtp-Source: ABdhPJwp4Zd0RX6bX56PqovmrU4HIegwdcD1cZD3VnoraR7eynFognr+1+Q8fgOAQlP7lQwlvnDk+Q==
X-Received: by 2002:aca:bac3:: with SMTP id k186mr11478995oif.82.1634930374167;
        Fri, 22 Oct 2021 12:19:34 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 06/10] RDMA/rxe: Separate out last rxe_drop_ref
Date:   Fri, 22 Oct 2021 14:18:21 -0500
Message-Id: <20211022191824.18307-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
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

This patch also separates out the last rxe_drop_ref as rxe_fini_ref() which
can return an error if the object is not ready to be destroyed and changes
rxe_drop_ref() to return an error if the object has already been destroyed.
Now the destroy verbs will return -EBUSY if the object cannot be destroyed
and other add/drop references will return -EINVAL if the object has already
or would be destroyed. Correct programs should not normally return these
values.

Locking is added so that cleanup is executed atomically. Some drop
references have their order changed so references are dropped after
the pointer they protect has been successfully removed.

This change requires that rxe_qp_destroy() be moved from the object
cleanup routine to rxe_destroy_qp() the main verb API for destroying
the QP so that the first stage of cleanup can operate while the QP
reference count is still positive.

This patch exposes some referencing errors which are addressed in the
following patches.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h       |   1 +
 drivers/infiniband/sw/rxe/rxe_av.c    |   1 +
 drivers/infiniband/sw/rxe/rxe_cq.c    |   9 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  23 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 233 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  32 +++-
 drivers/infiniband/sw/rxe/rxe_srq.c   |   8 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  42 +++--
 10 files changed, 253 insertions(+), 109 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 1bb3fb618bf5..adecf146d999 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/skbuff.h>
+#include <linux/refcount.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 38c7b6fb39d7..5084841a7cd0 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -117,6 +117,7 @@ struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 	if (ah_num) {
 		/* only new user provider or kernel client */
 		ah = rxe_pool_get_index(&pkt->rxe->ah_pool, ah_num);
+		rxe_drop_ref(ah);
 		if (!ah || ah->ah_num != ah_num || rxe_ah_pd(ah) != pkt->qp->pd) {
 			pr_warn("Unable to find AH matching ah_num\n");
 			return NULL;
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
index 7fd5543ef1ae..4be43ae58219 100644
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
@@ -195,9 +196,13 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		parent = *link;
 		elem = rb_entry(parent, struct rxe_pool_entry, index_node);
 
-		if (elem->index == new->index) {
-			pr_warn("element with index = 0x%x already exists!\n",
-					new->index);
+		/* this can happen if memory was recycled and/or the
+		 * old object was not deleted from the pool index
+		 */
+		if (unlikely(elem == new || elem->index == new->index)) {
+			pr_warn("%s#%d rf=%d: already in pool\n",
+					pool->name, new->index,
+					refcount_read(&new->refcnt));
 			return -EINVAL;
 		}
 
@@ -281,21 +286,20 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 		goto out_cnt;
 
 	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
-
 	elem->pool = pool;
 	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
+	refcount_set(&elem->refcnt, 1);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
-		if (err) {
-			kfree(elem);
-			goto out_cnt;
-		}
+		if (err)
+			goto out_free;
 	}
 
 	return obj;
 
+out_free:
+	kfree(elem);
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	return NULL;
@@ -307,20 +311,33 @@ void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 	u8 *obj;
 	int err;
 
-	obj = rxe_alloc_locked(pool);
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+		goto out_cnt;
+
+	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
 	if (!obj)
-		return NULL;
+		goto out_cnt;
+
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
+	elem->pool = pool;
+	elem->obj = obj;
+	refcount_set(&elem->refcnt, 1);
+
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err)
+			goto out_free;
+	}
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	err = rxe_insert_key(pool, elem);
-	if (err) {
-		kfree(obj);
-		goto out_cnt;
-	}
+	if (err)
+		goto out_free;
 
 	return obj;
 
+out_free:
+	kfree(obj);
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	return NULL;
@@ -348,19 +365,19 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 	elem->pool = pool;
 	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
+	refcount_set(&elem->refcnt, 1);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
-		if (err) {
-			kfree(elem);
-			goto out_cnt;
-		}
+		if (err)
+			goto out_free;
 	}
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
 
+out_free:
+	kfree(elem);
 out_cnt:
 	atomic_dec(&pool->num_elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
@@ -369,14 +386,48 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
 {
+	struct rxe_pool_entry *elem;
 	unsigned long flags;
-	void *obj;
+	u8 *obj;
+	int err;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
+		goto out_cnt;
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	obj = kzalloc(pool->elem_size, GFP_KERNEL);
+	if (!obj) {
+		atomic_dec(&pool->num_elem);
+		return NULL;
+	}
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	obj = rxe_alloc_with_key_locked(pool, key);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
+	elem->pool = pool;
+	elem->obj = obj;
+	refcount_set(&elem->refcnt, 1);
+
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err)
+			goto out_free;
+	}
+
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
+	err = rxe_insert_key(pool, elem);
+	if (err)
+		goto out_free;
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
+
+out_free:
+	kfree(elem);
+out_cnt:
+	atomic_dec(&pool->num_elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
@@ -390,7 +441,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
-	kref_init(&elem->ref_cnt);
+	refcount_set(&elem->refcnt, 1);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
@@ -407,35 +458,11 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
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
 	struct rxe_pool_entry *elem;
-	void *obj;
+	void *obj = NULL;
 
 	node = pool->index.tree.rb_node;
 
@@ -450,12 +477,8 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 			break;
 	}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
+	if (node && refcount_inc_not_zero(&elem->refcnt))
 		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
 
 	return obj;
 }
@@ -476,7 +499,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	void *obj;
+	void *obj = NULL;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -495,12 +518,8 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 			break;
 	}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
+	if (node && refcount_inc_not_zero(&elem->refcnt))
 		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
 
 	return obj;
 }
@@ -516,3 +535,97 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 
 	return obj;
 }
+
+int __rxe_add_ref_locked(struct rxe_pool_entry *elem)
+{
+	return refcount_inc_not_zero(&elem->refcnt) ? 0 : -EINVAL;
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
+	return refcount_dec_not_one(&elem->refcnt) ? 0 : -EINVAL;
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
index e0242d488cc8..7df52d34e306 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -47,7 +47,7 @@ struct rxe_type_info {
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
 	void			*obj;
-	struct kref		ref_cnt;
+	refcount_t		refcnt;
 	struct list_head	list;
 
 	/* only used if keyed */
@@ -127,13 +127,33 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
-/* cleanup an object when all references are dropped */
-void rxe_elem_release(struct kref *kref);
-
 /* take a reference on an object */
-#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
+int __rxe_add_ref_locked(struct rxe_pool_entry *elem);
+
+#define rxe_add_ref_locked(obj) __rxe_add_ref_locked(&(obj)->pelem)
+
+int __rxe_add_ref(struct rxe_pool_entry *elem);
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->pelem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
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
index 84ea03bc6a26..61fa633775f3 100644
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
@@ -188,7 +187,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_drop_ref(ah);
+			rxe_fini_ref(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
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
+
+	err = rxe_fini_ref(srq);
+	if (err)
+		return err;
 
-	if (srq->rq.queue)
-		rxe_queue_cleanup(srq->rq.queue);
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
 
@@ -486,8 +487,8 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 
 	rxe_qp_destroy(qp);
-	rxe_drop_ref(qp);
-	return 0;
+
+	return rxe_fini_ref(qp);
 }
 
 static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
@@ -797,10 +798,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 {
 	struct rxe_cq *cq = to_rcq(ibcq);
 
-	rxe_cq_disable(cq);
-
-	rxe_drop_ref(cq);
-	return 0;
+	return rxe_fini_ref(cq);
 }
 
 static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
@@ -924,8 +922,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return &mr->ibmr;
 
 err3:
+	rxe_fini_ref(mr);
 	rxe_drop_ref(pd);
-	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -956,8 +954,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
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

