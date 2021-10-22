Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE010437E80
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhJVTVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhJVTVv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:51 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DEEC061764
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l24-20020a9d1c98000000b00552a5c6b23cso5588616ota.9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCSiWNX7UzpWNu1lCclCKSJe3izPc3P9KkbPQuhLTo4=;
        b=ekegE/yjr1OTBMIesjGRVHx+ogHZj5XCjNdAVwA7+MDrcV5vyQU8YqVmDwb5iltQns
         /ih9+w+nQQ6fiZR4zy+bhpArzZvvWC3bNJPRvGpIJEPTYN3zg+PAdd/k+SOAs4IsyPJR
         euoi88SDEcqRyc/tGVSO6gHzR0gyRG6f2Yaan3mn9zYQz2kOOmQk6Tn51tMEkT6wk/IP
         cjNlObVKLUk7wZcPSc6/61MWDQE6GC3nncLs1Z1yQvpMqCwnGV38yCgTA4oy32tpRvo8
         tekGpJF8vX6//UI0S7q6jJgVmoSi/DkRa941ajAJw+VKtMxHM4cSsZTrPyphLz9qDBpP
         zaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCSiWNX7UzpWNu1lCclCKSJe3izPc3P9KkbPQuhLTo4=;
        b=REaLAaOy9MjdkKrsYSkwGNBA6flmCbVMeu7IrE1m4XE8xFbzasH+HuKC1AhlLNhzxc
         zj0FCb46F3mdBA/QXhcCPQRj21rikA4bnPqVziFeCMtEdJXh8NaDgxI1jeeOf/c3p5gq
         bj32cF31mNJH76ayFDSgIsLTlNr12cyGJc2ECw3tF7D+RQtQuvh+q9yALrYAlMLyDEGl
         WLP3ARyB3MLeZsf5+2bdfKZ8dvt0MPtII7XbG2+3YjeOf3m4XXiWTCT2mupDhdXofzhw
         d+ZgJtg/lZikV9SHGytw7vz5ad3sdUroxDJHvvyCKu037MNzBuguoxgrzJbZ3AVqk5A5
         e42A==
X-Gm-Message-State: AOAM5333OvlQz37HAMtiYslRIp72E1LjfoEsZaoTWbOVfFgLJq98QpPk
        1VbKrx2+clKWHz172hR+p+Q=
X-Google-Smtp-Source: ABdhPJyJQTobpapQSO53Aajh07c3Lly8X7mPTLECW04x/qkahzXnSisZWPZkIbUv2hW0FkcheweIiQ==
X-Received: by 2002:a05:6830:96:: with SMTP id a22mr1427828oto.249.1634930373081;
        Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 04/10] RDMA/rxe: Combine rxe_add_index with rxe_alloc
Date:   Fri, 22 Oct 2021 14:18:19 -0500
Message-Id: <20211022191824.18307-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mw.c    |  5 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 67 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 22 ---------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ------
 5 files changed, 41 insertions(+), 67 deletions(-)

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
index 2655bd372f59..bfed7bb48cd1 100644
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
 
@@ -281,31 +286,21 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
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
 
@@ -313,20 +308,11 @@ void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
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
 	void *obj;
+	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -341,6 +327,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err) {
+			kfree(elem);
+			goto out_cnt;
+		}
+	}
+
 	return obj;
 
 out_cnt:
@@ -353,6 +347,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	unsigned long flags;
 	void *obj;
+	int err;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -370,6 +365,14 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err) {
+			kfree(elem);
+			goto out_cnt;
+		}
+	}
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
@@ -383,6 +386,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
 	unsigned long flags;
+	int err;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -391,6 +395,12 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+
+	if (pool->flags & RXE_POOL_INDEX) {
+		err = rxe_add_index(elem);
+		if (err)
+			goto out_cnt;
+	}
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return 0;
@@ -411,6 +421,9 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
+	if (pool->flags & RXE_POOL_INDEX)
+		rxe_drop_index(elem);
+
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
 		obj = elem->obj;
 		kfree(obj);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index e9bda4b14f86..f76addf87b4a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -109,28 +109,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
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
index 0aa0d7e52773..84ea03bc6a26 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -181,7 +181,6 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		return err;
 
 	/* create index > 0 */
-	rxe_add_index(ah);
 	ah->ah_num = ah->pelem.index;
 
 	if (uresp) {
@@ -189,7 +188,6 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_drop_index(ah);
 			rxe_drop_ref(ah);
 			return -EFAULT;
 		}
@@ -230,7 +228,6 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_drop_index(ah);
 	rxe_drop_ref(ah);
 	return 0;
 }
@@ -438,7 +435,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		return err;
 
-	rxe_add_index(qp);
 	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
 	if (err)
 		goto qp_init;
@@ -446,7 +442,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	return 0;
 
 qp_init:
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return err;
 }
@@ -491,7 +486,6 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 
 	rxe_qp_destroy(qp);
-	rxe_drop_index(qp);
 	rxe_drop_ref(qp);
 	return 0;
 }
@@ -898,7 +892,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_add_index(mr);
 	rxe_add_ref(pd);
 	rxe_mr_init_dma(pd, access, mr);
 
@@ -922,8 +915,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 		goto err2;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
@@ -934,7 +925,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 
 err3:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err2:
 	return ERR_PTR(err);
@@ -957,8 +947,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_add_index(mr);
-
 	rxe_add_ref(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
@@ -969,7 +957,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 
 err2:
 	rxe_drop_ref(pd);
-	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
 err1:
 	return ERR_PTR(err);
-- 
2.30.2

