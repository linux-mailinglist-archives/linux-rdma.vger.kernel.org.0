Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369E1428437
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhJKABp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhJKABo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:44 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28965C061570
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id k2-20020a056830168200b0054e523d242aso9934345otr.6
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZo61CQD8JH8PSyNFaj4kDsMRGsrpcIrwUfaQLSr0zM=;
        b=F7HZTR5AV1yOqsvkt8RCiqa7u+1QNu3igwh5ZdwCqfxmo+/NjhSPoULfnxKTMbDXMu
         tNWqRqwFtqBz9SOJesX6v5na1jh8YxOQjU4+LsAfCZCE60tnPxV9+yJ91OX3cjriMRTZ
         vUC2dF05QuQryFX+cK2PL25S56Rv2p75AznkoQ9ug6Ez20vQ3X0lk4pkU8IXHN1uKgsR
         9Ds4NtJaVKTlOVvBo5q/j5Wdz8+nWs6Ie0h7MNIXTUPrbAH60u8PqtFmJVfsANd94Qaj
         KTSs1Ps9Ijt3eZpEpoANF95owiSWe3nu3dntpjpL21MFuTOWCeKWS67mfrQICzmPtCT2
         2HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZo61CQD8JH8PSyNFaj4kDsMRGsrpcIrwUfaQLSr0zM=;
        b=jKHavXkPC1dGiuzzlx8T5G7QbahJwilr1NlJ+GnGpgm4VGkfNa6KxMeyLRAYOywTuE
         1QRF6FjtdKv/Grh23xkSj1MwaBqq++d5++qgIaV8nHKiY2509pG6i7a9VmS8RECVHdcE
         9bHkiWxGvhUDrxN6ScCmsCJvkUi44mj0Fe06ZXHOn4svoIz4Craqf0mheE6eToxcrS3j
         ICNdh11t2opkfWV2ZqNCOvxrX/nONxu0glueK8ncn1nD7PxULojpZTQAgR3arx4qSELH
         9Dt2/l/PxXk7p5y0Dy1bC/f6cB78oBSDHimRFC9H1JKvMitQa8QJ8yjm7n1IOxy1Z7ty
         qi+g==
X-Gm-Message-State: AOAM5319F4ilD6dLlC2qZGaFxlpgQJff9jScxmm7vxnO8EXSHmAr+MA3
        Uc1/8fUE3IQtF+VaaaeM87IOEUGaTpA=
X-Google-Smtp-Source: ABdhPJxKJV0ISa0TuP9CIL0ligZpvXdhjiMwlnCxKUdrGXHMBO+zvrayG7SlTlVLeKDPY3C13T2OWg==
X-Received: by 2002:a9d:7696:: with SMTP id j22mr18302119otl.290.1633910384504;
        Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/6] RDMA/rxe: Combine rxe_add_index with rxe_alloc
Date:   Sun, 10 Oct 2021 18:59:29 -0500
Message-Id: <20211010235931.24042-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rxe objects which have an index require adding and dropping
the indices in a separate API call from allocating and freeing the
object. These are always performed together so this patch combines
them in a single operation.

By taking a single pool lock around allocating the object and adding
the index metadata or dropping the index metadata and releasing the
object the possibility of a race condition where the metadata is not
consistent with the state of the object is removed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |  5 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 59 +++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 22 ----------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 -----
 5 files changed, 33 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 53271df10e47..6e71f67ccfe9 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -693,7 +693,6 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 9534a7fe1a98..854d0c283521 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -20,7 +20,6 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 		return ret;
 	}
 
-	rxe_add_index(mw);
 	mw->rkey = ibmw->rkey = (mw->pelem.index << 8) | rxe_get_next_key(-1);
 	mw->state = (mw->ibmw.type == IB_MW_TYPE_2) ?
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
@@ -335,7 +334,5 @@ struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
 
 void rxe_mw_cleanup(struct rxe_pool_entry *elem)
 {
-	struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
-
-	rxe_drop_index(mw);
+	/* nothing to do currently */
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4caaecdb0d68..d55a40291692 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -166,12 +166,16 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	kfree(pool->index.table);
 }
 
+/* should never fail because there are at least as many indices as
+ * max objects
+ */
 static u32 alloc_index(struct rxe_pool *pool)
 {
 	u32 index;
 	u32 range = pool->index.max_index - pool->index.min_index + 1;
 
-	index = find_next_zero_bit(pool->index.table, range, pool->index.last);
+	index = find_next_zero_bit(pool->index.table, range,
+				   pool->index.last);
 	if (index >= range)
 		index = find_first_zero_bit(pool->index.table, range);
 
@@ -192,7 +196,8 @@ static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		elem = rb_entry(parent, struct rxe_pool_entry, index_node);
 
 		if (elem->index == new->index) {
-			pr_warn("element already exists!\n");
+			pr_warn("element with index = 0x%x already exists!\n",
+					new->index);
 			return -EINVAL;
 		}
 
@@ -280,31 +285,21 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-int __rxe_add_index_locked(struct rxe_pool_entry *elem)
+static int rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	int err;
 
 	elem->index = alloc_index(pool);
 	err = rxe_insert_index(pool, elem);
+	if (err)
+		clear_bit(elem->index - pool->index.min_index,
+			  pool->index.table);
 
 	return err;
 }
 
-int __rxe_add_index(struct rxe_pool_entry *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-	int err;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	err = __rxe_add_index_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-
-	return err;
-}
-
-void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
+static void rxe_drop_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -312,20 +307,11 @@ void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
 	rb_erase(&elem->index_node, &pool->index.tree);
 }
 
-void __rxe_drop_index(struct rxe_pool_entry *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_index_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-}
-
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
 	u8 *obj;
+	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -340,6 +326,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err) {
+			kfree(obj);
+			goto out_cnt;
+		}
+	}
+
 	return obj;
 
 out_cnt:
@@ -361,6 +355,8 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
+	int err;
+
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -368,6 +364,12 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err)
+			goto out_cnt;
+	}
+
 	return 0;
 
 out_cnt:
@@ -385,6 +387,9 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
+	if (pool->flags & RXE_POOL_INDEX)
+		rxe_drop_index(elem);
+
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
 		obj = elem->obj;
 		kfree(obj);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 570bda77f4a6..41eaf47a64a3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -110,28 +110,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
-/* assign an index to an indexed object and insert object into
- *  pool's rb tree holding and not holding the pool_lock
- */
-int __rxe_add_index_locked(struct rxe_pool_entry *elem);
-
-#define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->pelem)
-
-int __rxe_add_index(struct rxe_pool_entry *elem);
-
-#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
-
-/* drop an index and remove object from rb tree
- * holding and not holding the pool_lock
- */
-void __rxe_drop_index_locked(struct rxe_pool_entry *elem);
-
-#define rxe_drop_index_locked(obj) __rxe_drop_index_locked(&(obj)->pelem)
-
-void __rxe_drop_index(struct rxe_pool_entry *elem);
-
-#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
-
 /* assign a key to a keyed object and insert object into
  * pool's rb tree holding and not holding pool_lock
  */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c49ba0381964..bc40200436f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -409,7 +409,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		return err;
 
-	rxe_add_index(qp);
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
 	if (err)
 		goto qp_init;
@@ -417,7 +416,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return err;
 }
@@ -462,7 +460,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return 0;
 }
@@ -871,7 +868,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_index(mr);
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
@@ -895,8 +891,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
@@ -907,7 +901,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
@@ -930,8 +923,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
@@ -942,7 +933,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.30.2

