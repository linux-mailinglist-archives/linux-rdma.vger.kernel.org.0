Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF845094BD
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383668AbiDUBoF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383675AbiDUBoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:44:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6C17049
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e656032735so2673628fac.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9WBywQ4FSEeFAOXLYlGzO0LUFUlKiXwHhfCB/z2N10=;
        b=AOmzNAeVBmZsPmOY++zMaWYJ6hcfRGec9ww14ycQ2rmc5o+sJyrlns4gpDZWrIaLU1
         ZvG25gwGD0oa6L7BCjGUjce9XVsQb9Vih5E+PYErAmDl02DSUrDNaBTEFx0fsm4KvLFk
         /Dp8eSFTTaw0pnX9V4E7RA1paJoZtOX+rcqvm642hRQ8hkWe0nC372IUSTtZrpFqZqTr
         ENa+IYDKQri92sW2lCcKemiW+wasr45DxjHdw5L/9tTA5SlU2/Qxg846Xxv+l39ecqMc
         7SAxQD5uWhDVt2GKXVCQEa9cL4hbLFsQXTTnEoyWOnPDgp8Cjv+75Tq0Z5WKFbjChZEc
         2lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9WBywQ4FSEeFAOXLYlGzO0LUFUlKiXwHhfCB/z2N10=;
        b=yJDIv9cSJsU2SEs6w7oRaVxxMjbMZKlb4qqSeYGfdjRLJwAMC/ECLQTdXNlb1Dtrm3
         2mHHK7/mSrU4zyc/0tb/YE/aqkSro7/6AtfKxlkvnOKlAY8QH8jVtI/lagbR9UBqSFD7
         PMzM8VAuRedbp+qB81BuRb+FZ1tiiy+jNKubXV8rG/jrqBe6HsEM9nut58johWZnCkIM
         dbqUA31gXteWldxWZoQDUvcLT768V8TAUZx8oXD8b7Q+ChyCnJ4jm9J1UHh/+Cn8dVgu
         4si5rv6mdAx2iTnrEbUsXEvL3Ho150WoYj8d61/58B3HSIMwxAlZhGMXOh4YEoTPPmpn
         JZpw==
X-Gm-Message-State: AOAM531/QW6gawwO4YMSZhtM+glCyOVimxTy4nXTNdIPDNL0KlELfEpo
        s63k1o+8dw/SbVsVUlKL9HlVKoad+cI=
X-Google-Smtp-Source: ABdhPJym/ataYKKKwlJH3Y0hujIgEtfKmh7Bg7SwBbywo+DowapNmdcTkDEJ8kgZ8V9iAgZvdv7HdQ==
X-Received: by 2002:a05:6870:ec8a:b0:e5:faac:cc90 with SMTP id eo10-20020a056870ec8a00b000e5faaccc90mr2857931oab.172.1650505274158;
        Wed, 20 Apr 2022 18:41:14 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 08/10] RDMA/rxe: Stop lookup of partially built objects
Date:   Wed, 20 Apr 2022 20:40:41 -0500
Message-Id: <20220421014042.26985-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220421014042.26985-1-rpearsonhpe@gmail.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
the memory.

Combined with deferring cleanup code to type specific cleanup
routines this allows all pending activity referring to objects to
complete before returning to rdma_core.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 62 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.h  | 11 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 30 ++++++++-----
 5 files changed, 90 insertions(+), 19 deletions(-)

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
index 0fdde3d46949..f5380b6bdea2 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 
+#define RXE_POOL_TIMEOUT	(200)
+#define RXE_POOL_MAX_TIMEOUTS	(3)
 #define RXE_POOL_ALIGN		(16)
 
 static const struct rxe_type_info {
@@ -139,8 +141,12 @@ void *rxe_alloc(struct rxe_pool *pool)
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
 	if (err)
 		goto err_free;
@@ -167,8 +173,9 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_cnt;
@@ -201,9 +208,44 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
+
+	complete(&elem->complete);
+}
+
+int __rxe_cleanup(struct rxe_pool_elem *elem)
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
+	 * object. It is safe to touch elem after this since
+	 * it is freed below
+	 */
+	__rxe_put(elem);
+
+	if (timeout) {
+		ret = wait_for_completion_timeout(&elem->complete, timeout);
+		if (!ret) {
+			pr_warn("Timed out waiting for %s#%d to complete\n",
+				pool->name, elem->index);
+			if (++pool->timeouts >= RXE_POOL_MAX_TIMEOUTS)
+				timeout = 0;
+
+			err = -EINVAL;
+		}
+	}
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
@@ -212,6 +254,8 @@ static void rxe_elem_release(struct kref *kref)
 		kfree(elem->obj);
 
 	atomic_dec(&pool->num_elem);
+
+	return err;
 }
 
 int __rxe_get(struct rxe_pool_elem *elem)
@@ -223,3 +267,15 @@ int __rxe_put(struct rxe_pool_elem *elem)
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
index 24bcc786c1b3..83f96b2d5096 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -28,6 +28,7 @@ struct rxe_pool_elem {
 	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
+	struct completion	complete;
 	u32			index;
 };
 
@@ -37,6 +38,7 @@ struct rxe_pool {
 	void			(*cleanup)(struct rxe_pool_elem *elem);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
+	unsigned int		timeouts;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
@@ -63,20 +65,23 @@ void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
-
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
 
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
 int __rxe_get(struct rxe_pool_elem *elem);
-
 #define rxe_get(obj) __rxe_get(&(obj)->elem)
 
 int __rxe_put(struct rxe_pool_elem *elem);
-
 #define rxe_put(obj) __rxe_put(&(obj)->elem)
 
+int __rxe_cleanup(struct rxe_pool_elem *elem);
+#define rxe_cleanup(obj) __rxe_cleanup(&(obj)->elem)
+
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
+void __rxe_finalize(struct rxe_pool_elem *elem);
+#define rxe_finalize(obj) __rxe_finalize(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7357794b951a..b003bc126fb7 100644
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
 
@@ -188,7 +188,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 		err = copy_to_user(&uresp->ah_num, &ah->ah_num,
 					 sizeof(uresp->ah_num));
 		if (err) {
-			rxe_put(ah);
+			rxe_cleanup(ah);
 			return -EFAULT;
 		}
 	} else if (ah->is_user) {
@@ -197,6 +197,8 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	}
 
 	rxe_init_av(init_attr->ah_attr, &ah->av);
+	rxe_finalize(ah);
+
 	return 0;
 }
 
@@ -228,7 +230,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
-	rxe_put(ah);
+	rxe_cleanup(ah);
 	return 0;
 }
 
@@ -313,7 +315,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	return 0;
 
 err_cleanup:
-	rxe_put(srq);
+	rxe_cleanup(srq);
 err_out:
 	return err;
 }
@@ -367,7 +369,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
 {
 	struct rxe_srq *srq = to_rsrq(ibsrq);
 
-	rxe_put(srq);
+	rxe_cleanup(srq);
 	return 0;
 }
 
@@ -434,10 +436,11 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		goto qp_init;
 
+	rxe_finalize(qp);
 	return 0;
 
 qp_init:
-	rxe_put(qp);
+	rxe_cleanup(qp);
 	return err;
 }
 
@@ -490,7 +493,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (ret)
 		return ret;
 
-	rxe_put(qp);
+	rxe_cleanup(qp);
 	return 0;
 }
 
@@ -808,7 +811,7 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	rxe_cq_disable(cq);
 
-	rxe_put(cq);
+	rxe_cleanup(cq);
 	return 0;
 }
 
@@ -903,6 +906,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
+	rxe_finalize(mr);
 
 	return &mr->ibmr;
 }
@@ -931,11 +935,13 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
@@ -963,11 +969,13 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
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
2.32.0

