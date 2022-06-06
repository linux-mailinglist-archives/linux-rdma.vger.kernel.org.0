Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66C53E7A1
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiFFOSV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiFFOSQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:18:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786530F65
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:18:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id k11so19794741oia.12
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2rgBQ//FlEdXHgxOkf4si7osPzOsQMDg5BND1vc29k=;
        b=KElyKJzWFtUSzXaCFbDofF7bfRw4JSkVaGEwwu7RoOgWLCgaeF2YlcQErkhqTfUIXv
         9OP5pFcjE54l8VKWgu5AI/oYZWLdI9iNqsuOn4fWTX80hq8wnnfC9uP35xqpnN8vK/tD
         I4bsK8yfmjUmzWoGP/ia2mG4YK+LRPZTtqEP80rG1jGT2KXoqT/fp/GsZhbfUlnJJhq0
         9ynrcAZpd8jcUAZbsX2ukZeWVZ52n75lxfJQgNVeMUo1M2F1R23aFP5UJ0HxTApPBT5H
         dnLtYAUNOepSynNnbDoGdolkp0vpOqYKJMsCEej8ByCryzgUKhuj+583/bcWMYv4b1Vu
         WDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2rgBQ//FlEdXHgxOkf4si7osPzOsQMDg5BND1vc29k=;
        b=PcPRsUT02MQzgAR0LvgNidLqKg23TQpxn20eoAMogU/ZXkanb63Ncu+ZmG0yX8JL3c
         o1PBllMflxwWQiF9IyjS4pI8yTFj9fHeSToJm8y6RWHOO4G+QfJnYrbJn3ptgBPG4uAM
         IYMam1g7OUE7gBO+kRKHKTDN3PzibDw9Hrn3mUIJ1aeKSFq5qPWWv8NOKqGXiyWTbfMO
         fngjGmtNwkL9DD37ipR2Fq6QxOcMajbXzgexN/NSAuwwrO97PXaJ5DKofBLM/OhBhlhE
         nxtBznYpnlfKque+gnZGUaOxGQFpcGdfeQZEEuiWjC9ZHobv8C+trYWAvg4b5NQmgksk
         /GJQ==
X-Gm-Message-State: AOAM530daeP4xM+sHArop2Lq1+Js6ZBPXev8xRKfV6O4Sd9XeAUNSYGO
        5Lllcj9zytQcgnYkZK4Hlcw=
X-Google-Smtp-Source: ABdhPJwDFUA5tU3qQ24sv7oDhp6jicXredlgkASGlR91cL6pQmAfbC0PnzlA7XHK/go8dhEY8eevrg==
X-Received: by 2002:a05:6808:23c5:b0:328:a5b8:267 with SMTP id bq5-20020a05680823c500b00328a5b80267mr28137361oib.10.1654525091235;
        Mon, 06 Jun 2022 07:18:11 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id gz9-20020a056870280900b000e686d1386dsm6710097oab.7.2022.06.06.07.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:18:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v15 1/2] RDMA/rxe: Stop lookup of partially built objects
Date:   Mon,  6 Jun 2022 09:18:03 -0500
Message-Id: <20220606141804.4040-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606141804.4040-1-rpearsonhpe@gmail.com>
References: <20220606141804.4040-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_pool.c  | 93 +++++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.h  | 18 ++++--
 drivers/infiniband/sw/rxe/rxe_req.c   | 37 +++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 39 +++++++----
 6 files changed, 161 insertions(+), 32 deletions(-)

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
index 19b14826385b..7a5685f0713e 100644
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
 	if (err)
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
@@ -164,9 +171,16 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
+	init_completion(&elem->complete);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	/* AH objects are unique in that the create_ah verb
+	 * can be called in atomic context. If the create_ah
+	 * call is not sleepable use GFP_ATOMIC.
+	 */
+	gfp_flags = sleepable ? GFP_KERNEL : GFP_ATOMIC;
+
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL,
+			pool->limit, &pool->next, gfp_flags);
 	if (err)
 		goto err_cnt;
 
@@ -198,9 +212,64 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
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
@@ -209,6 +278,8 @@ static void rxe_elem_release(struct kref *kref)
 		kfree(elem->obj);
 
 	atomic_dec(&pool->num_elem);
+
+	return err;
 }
 
 int __rxe_get(struct rxe_pool_elem *elem)
@@ -220,3 +291,15 @@ int __rxe_put(struct rxe_pool_elem *elem)
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
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 9d98237389cf..e8a1664a40eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -161,16 +161,36 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
 		     (wqe->state != wqe_state_processing)))
 		return NULL;
 
-	if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
-						     (index != cons))) {
-		qp->req.wait_fence = 1;
-		return NULL;
-	}
-
 	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
 	return wqe;
 }
 
+/**
+ * rxe_wqe_is_fenced - check if next wqe is fenced
+ * @qp: the queue pair
+ * @wqe: the next wqe
+ *
+ * Returns: 1 if wqe needs to wait
+ *	    0 if wqe is ready to go
+ */
+static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
+{
+	/* Local invalidate fence (LIF) see IBA 10.6.5.1
+	 * Requires ALL previous operations on the send queue
+	 * are complete. Make mandatory for the rxe driver.
+	 */
+	if (wqe->wr.opcode == IB_WR_LOCAL_INV)
+		return qp->req.wqe_index != queue_get_consumer(qp->sq.queue,
+						QUEUE_TYPE_FROM_CLIENT);
+
+	/* Fence see IBA 10.8.3.3
+	 * Requires that all previous read and atomic operations
+	 * are complete.
+	 */
+	return (wqe->wr.send_flags & IB_SEND_FENCE) &&
+		atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
+}
+
 static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 {
 	switch (opcode) {
@@ -632,6 +652,11 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
+	if (rxe_wqe_is_fenced(qp, wqe)) {
+		qp->req.wait_fence = 1;
+		goto exit;
+	}
+
 	if (wqe->mask & WR_LOCAL_OP_MASK) {
 		ret = rxe_do_local_ops(qp, wqe);
 		if (unlikely(ret))
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

