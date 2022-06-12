Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB3547CD3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jun 2022 00:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiFLWfS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jun 2022 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbiFLWfR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jun 2022 18:35:17 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D092252F
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 15:35:16 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q11so5884192oih.10
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmO5WOx0Adf70BeTgr916C9RJQkdwee8L8nECkk2U2I=;
        b=mA85pftMqJHKS1VCRfET4eYkxvYAmURJ7dSKR4JUZZ7eprzTUOnRUCfqPO7zsadnJX
         1r6U/6JZHCpl7OSzNOXQutl8xmiLq6VQwiDN3g057nHcrOfA6slk+L6c+YRpHuDjZhj7
         UV11+1lCmXe+yh21gvxTJX4TJWIv93j0tWnoboe5ZLt7rUE9tvg5pULLRISny2FrSSUP
         VV+z7sUWcOQhjfq8/VXFzMdavlbbMSLClRat4ErJpPu2O5s+KLUosOH4KAckp26PewyM
         geV6zfk7avnKCbowilEfiTw72QYzDEuEP+fVs1v9bRnJFgTZefrKLdE1LizjM1+iZ7pT
         GEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmO5WOx0Adf70BeTgr916C9RJQkdwee8L8nECkk2U2I=;
        b=fFk7zWXLYtq2HOhfc4DSL/bAT+J1Itxq4HkXwERvCDuULFWNwfJ+flARxPSCf+HNop
         jAV4lsnWbCC1emwiCup3aSCErZvmjmUSnQsrfwgKLHG3sJcP8O36lm8BoyZya3Big6SD
         Fv8rCSoYiHCsHV5m1gQJVIYS+aPaHDYNIRqfiW8MEs1zWddNZzsTAHGlzbpjK+U2+Bsi
         GFvakHR9JsxzsKBlU9MomJvEDSfrF1Z16b7FW5gFV5SIj4bGAUwQc5qDbWXAiUmi9mo3
         1pw6VSS2AUUyh/1IgcqEaJRXmSqHm22QLGDl2QtNEQCoa9ZOKF6XMm/35kljCvUWMpDC
         4/9Q==
X-Gm-Message-State: AOAM533PdOlMuLKQfdcIkCnn3PF0t3HMgUVQnRWVT5RCWLDer6RvGnIK
        usarMG3xNPtnvkyJOWzCTMY=
X-Google-Smtp-Source: ABdhPJybeR+CYHmySMw9Qx1QOP13AoU6GE9h4YDORtUopa4FM4G70FWE759LyAt1EBLJ9FCJ+yOsew==
X-Received: by 2002:a54:4503:0:b0:32f:4c19:cecd with SMTP id l3-20020a544503000000b0032f4c19cecdmr363090oil.158.1655073315664;
        Sun, 12 Jun 2022 15:35:15 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id y185-20020aca32c2000000b00326414c1bb7sm2562421oiy.35.2022.06.12.15.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:35:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, frank.zago@hpe.com,
        ian.ziemba@hpe.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v16 1/2] RDMA/rxe: Stop lookup of partially built objects
Date:   Sun, 12 Jun 2022 17:34:34 -0500
Message-Id: <20220612223434.31462-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220612223434.31462-1-rpearsonhpe@gmail.com>
References: <20220612223434.31462-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver has a security weakness due to giving
objects which are partially initialized indices allowing external
actors to gain access to them by sending packets which refer to
their index (e.g. qpn, rkey, etc) causing unpredictable results.

This patch adds a new API rxe_finalize(obj) which enables looking up
pool objects from indices using rxe_pool_get_index() for
AH, QP, MR, and MW. They are added in create verbs only after the
objects are fully initialized.

It also adds wait for completion to destroy/dealloc verbs to assure that
all references have been dropped before returning to rdma_core by
implementing a new rxe_pool API rxe_cleanup() which drops a reference
to the object and then waits for all other references to be dropped.
When the last reference is dropped the object is completed by kref.
After that it cleans up the object and if locally allocated frees
the memory. In the special case of address handle objects the delay
is implemented separately if the destroy_ah call is not sleepable.

Combined with deferring cleanup code to type specific cleanup
routines this allows all pending activity referring to objects to
complete before returning to rdma_core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 97 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.h  | 18 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 39 +++++++----
 5 files changed, 133 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..9a5c2af6a56f 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -687,7 +687,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
 
-	rxe_put(mr);
+	rxe_cleanup(mr);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index 2e1fa844fabf..86e63d7dc1f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -33,6 +33,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
 	spin_lock_init(&mw->lock);
 
+	rxe_finalize(mw);
+
 	return 0;
 }
 
@@ -40,7 +42,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
 
-	rxe_put(mw);
+	rxe_cleanup(mw);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index e9f3bbd8d605..8d8f5e409585 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,7 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_TIMEOUT	(200)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -136,8 +137,12 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	/* allocate index in array but leave pointer as NULL so it
+	 * can't be looked up until rxe_finalize() is called
+	 */
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err < 0)
 		goto err_free;
@@ -151,9 +156,11 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
+				bool sleepable)
 {
 	int err;
+	gfp_t gfp_flags;
 
 	if (WARN_ON(pool->type == RXE_TYPE_MR))
 		return -EINVAL;
@@ -164,9 +171,18 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
-
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	init_completion(&elem->complete);
+
+	/* AH objects are unique in that the create_ah verb
+	 * can be called in atomic context. If the create_ah
+	 * call is not sleepable use GFP_ATOMIC.
+	 */
+	gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
+
+	if (sleepable)
+		might_sleep();
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
+			      &pool->next, gfp_flags);
 	if (err < 0)
 		goto err_cnt;
 
@@ -198,9 +214,64 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
+
+	complete(&elem->complete);
+}
+
+int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
+{
 	struct rxe_pool *pool = elem->pool;
+	struct xarray *xa = &pool->xa;
+	static int timeout = RXE_POOL_TIMEOUT;
+	unsigned long flags;
+	int ret, err = 0;
+	void *xa_ret;
 
-	xa_erase(&pool->xa, elem->index);
+	/* erase xarray entry to prevent looking up
+	 * the pool elem from its index
+	 */
+	xa_lock_irqsave(xa, flags);
+	xa_ret = __xa_erase(xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
+	WARN_ON(xa_err(xa_ret));
+
+	/* if this is the last call to rxe_put complete the
+	 * object. It is safe to touch obj->elem after this since
+	 * it is freed below
+	 */
+	__rxe_put(elem);
+
+	/* wait until all references to the object have been
+	 * dropped before final object specific cleanup and
+	 * return to rdma-core
+	 */
+	if (sleepable) {
+		if (!completion_done(&elem->complete) && timeout) {
+			ret = wait_for_completion_timeout(&elem->complete,
+					timeout);
+
+			/* Shouldn't happen. There are still references to
+			 * the object but, rather than deadlock, free the
+			 * object or pass back to rdma-core.
+			 */
+			if (WARN_ON(!ret))
+				err = -EINVAL;
+		}
+	} else {
+		unsigned long until = jiffies + timeout;
+
+		/* AH objects are unique in that the destroy_ah verb
+		 * can be called in atomic context. This delay
+		 * replaces the wait_for_completion call above
+		 * when the destroy_ah call is not sleepable
+		 */
+		while (!completion_done(&elem->complete) &&
+				time_before(jiffies, until))
+			mdelay(1);
+
+		if (WARN_ON(!completion_done(&elem->complete)))
+			err = -EINVAL;
+	}
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
@@ -209,6 +280,8 @@ static void rxe_elem_release(struct kref *kref)
 		kfree(elem->obj);
 
 	atomic_dec(&pool->num_elem);
+
+	return err;
 }
 
 int __rxe_get(struct rxe_pool_elem *elem)
@@ -220,3 +293,15 @@ int __rxe_put(struct rxe_pool_elem *elem)
 {
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
+
+void __rxe_finalize(struct rxe_pool_elem *elem)
+{
+	struct xarray *xa = &elem->pool->xa;
+	unsigned long flags;
+	void *ret;
+
+	xa_lock_irqsave(xa, flags);
+	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
+	WARN_ON(xa_err(ret));
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 0860660d65ec..9d83cb32092f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -24,6 +24,7 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
+	struct completion	complete;
 	u32			index;
 };
 
@@ -57,21 +58,28 @@ void rxe_pool_cleanup(struct rxe_pool *pool);
 void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
-
-#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
+				bool sleepable);
+#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem, true)
+#define rxe_add_to_pool_ah(pool, obj, sleepable) __rxe_add_to_pool(pool, \
+				&(obj)->elem, sleepable)
 
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
 int __rxe_get(struct rxe_pool_elem *elem);
-
 #define rxe_get(obj) __rxe_get(&(obj)->elem)
 
 int __rxe_put(struct rxe_pool_elem *elem);
-
 #define rxe_put(obj) __rxe_put(&(obj)->elem)
 
+int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable);
+#define rxe_cleanup(obj) __rxe_cleanup(&(obj)->elem, true)
+#define rxe_cleanup_ah(obj, sleepable) __rxe_cleanup(&(obj)->elem, sleepable)
+
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
+void __rxe_finalize(struct rxe_pool_elem *elem);
+#define rxe_finalize(obj) __rxe_finalize(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9d995854a174..151c6280abd5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -115,7 +115,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
 {
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	rxe_put(uc);
+	rxe_cleanup(uc);
 }
 
 static int rxe_port_immutable(struct ib_device *dev, u32 port_num,
@@ -149,7 +149,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	rxe_put(pd);
+	rxe_cleanup(pd);
 	return 0;
 }
 
@@ -176,7 +176,8 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	if (err)
 		return err;
 
-	err = rxe_add_to_pool(&rxe->ah_pool, ah);
+	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah,
+			init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
 	if (err)
 		return err;
 
@@ -188,7 +189,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_put(ah);
+			rxe_cleanup(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -197,6 +198,8 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	}
 
 	rxe_init_av(init_attr->ah_attr, &ah->av);
+	rxe_finalize(ah);
+
 	return 0;
 }
 
@@ -228,7 +231,8 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_put(ah);
+	rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
+
 	return 0;
 }
 
@@ -308,12 +312,13 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 
 	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
 	if (err)
-		goto err_put;
+		goto err_cleanup;
 
 	return 0;
 
-err_put:
-	rxe_put(srq);
+err_cleanup:
+	rxe_cleanup(srq);
+
 	return err;
 }
 
@@ -362,7 +367,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
-	rxe_put(srq);
+	rxe_cleanup(srq);
 	return 0;
 }
 
@@ -429,10 +434,11 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		goto qp_init;
 
+	rxe_finalize(qp);
 	return 0;
 
 qp_init:
-	rxe_put(qp);
+	rxe_cleanup(qp);
 	return err;
 }
 
@@ -485,7 +491,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	rxe_put(qp);
+	rxe_cleanup(qp);
 	return 0;
 }
 
@@ -803,7 +809,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	rxe_cq_disable(cq);
 
-	rxe_put(cq);
+	rxe_cleanup(cq);
 	return 0;
 }
 
@@ -898,6 +904,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
+	rxe_finalize(mr);
 
 	return &mr->ibmr;
 }
@@ -926,11 +933,13 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	if (err)
 		goto err3;
 
+	rxe_finalize(mr);
+
 	return &mr->ibmr;
 
 err3:
 	rxe_put(pd);
-	rxe_put(mr);
+	rxe_cleanup(mr);
 err2:
 	return ERR_PTR(err);
 }
@@ -958,11 +967,13 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (err)
 		goto err2;
 
+	rxe_finalize(mr);
+
 	return &mr->ibmr;
 
 err2:
 	rxe_put(pd);
-	rxe_put(mr);
+	rxe_cleanup(mr);
 err1:
 	return ERR_PTR(err);
 }
-- 
2.34.1

