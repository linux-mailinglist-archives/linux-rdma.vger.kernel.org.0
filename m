Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B244DD299
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiCRB47 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9AB243700
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso4732783otr.9
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SdF1uWi4XJsKk+Knhny+0qCi8cPiaW1ef6UDKr5t3o=;
        b=MErwI4FrxF0aWEhq1oMYAU56RtzMRpUcJSErdKfRSnyUlcrDVYXBpnb6/Byt5M4lfU
         4dP3WGtGUD8NzKTXNkTHIwgq79T4dZhnAFdaiqEoS+m7CzGdUZjm0lFvmNUme8wfYKIf
         86bm4psv55/IBYh8F/325oz8MEAq+jS8ajmdpY1/VDnF5k6MBW+LOvfgwA9fd9t+2ln/
         NrQ6jeqhHi7QU6UJ+0ex9Ci9SBru46bm7Ptth35sM2m206hAubWXW2qryb85LtgoAph5
         7GRr2d0UZ3Je6rDJumxahPNGWlYKSjfkmuw4mwi39TqxwG7bZjOx+2xr+rn7sO1ZLP6R
         4ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SdF1uWi4XJsKk+Knhny+0qCi8cPiaW1ef6UDKr5t3o=;
        b=zZ0y1AF2NSWKrqHQFxCiprWZR6o3FXNRznu8wUW+CO9u6FFOymc8ocGF53vlcCz5nT
         n285gVjQWckrtRVRWqvXDwqib/czor9iEATwqsEHMIqrTj10mRdS3nk3HkOEAV1Slewk
         u3afbUgIc0MF2cTXikSMO1xh0gIKIOADVxH3rAGn8qsNrttZTpg9P2r5FTZRMdXQSiiI
         xUstOO8VFw2SsCG+9orRXHOxJOFBuEh2987qiJgpxKkvNvtR4M1QDwSTEtTGCDSqaCjw
         n56mnx5gie9cyMxYx2shrRilVL0oGuajUG5pbhldfsJOqjwQaSISGWzZVaruCR0DQEbt
         H/oQ==
X-Gm-Message-State: AOAM531GH5JLwzGGzURCDzYZh3kzW6afFrKxn95g+hbaa6aBoZPaBwTK
        kuORklgBTjOg70VwXOfN0Zo=
X-Google-Smtp-Source: ABdhPJwLhsPCArY0Kx6h4iFy0FmSSn1w97gEaNHyDEQPyY1VzGoLDLWkLQKyweA3KZUxOG4gufQjCQ==
X-Received: by 2002:a9d:77d7:0:b0:5b2:29b0:70cb with SMTP id w23-20020a9d77d7000000b005b229b070cbmr2514561otl.276.1647568534925;
        Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:34 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 08/11] RDMA/rxe: Stop lookup of partially built objects
Date:   Thu, 17 Mar 2022 20:55:11 -0500
Message-Id: <20220318015514.231621-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318015514.231621-1-rpearsonhpe@gmail.com>
References: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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

This patch adds two new APIs rxe_finalize(obj) and
rxe_disable_lookup(obj) which enable or disable looking up pool objects
from indices using rxe_pool_get_index(). By default objects are disabled.
These APIs are used to enable looking up objects which have indices:
AH, QP, MR, and MW. They are added in create verbs after the
objects are fully initialized and as soon as possible in destroy
verbs.

Note, the sequence
	rxe_disable_lookup(obj);
	rxe_put(obj);
in destroy verbs stops the looking up of objects by clearing the
pointer in the xarray with __xa_store() before a possible
long wait until the last reference is dropped somewhere else and
the xarray entry is erased with xa_erase().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  1 +
 drivers/infiniband/sw/rxe/rxe_mw.c    |  3 +++
 drivers/infiniband/sw/rxe/rxe_pool.c  | 36 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_pool.h  |  9 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++++++
 5 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..8059f31882ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -687,6 +687,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (atomic_read(&mr->num_mw) > 0)
 		return -EINVAL;
 
+	rxe_disable_lookup(mr);
 	rxe_put(mr);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index ba3f94c69171..2464952a04d4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -25,6 +25,8 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 			RXE_MW_STATE_FREE : RXE_MW_STATE_VALID;
 	spin_lock_init(&mw->lock);
 
+	rxe_finalize(mw);
+
 	return 0;
 }
 
@@ -32,6 +34,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
 {
 	struct rxe_mw *mw = to_rmw(ibmw);
 
+	rxe_disable_lookup(mw);
 	rxe_put(mw);
 
 	return 0;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 0fdde3d46949..87b89d263f80 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -140,7 +140,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	/* allocate index in array but leave pointer as NULL so it
+	 * can't be looked up until rxe_finalize() is called */
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_free;
@@ -168,7 +170,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_cnt;
@@ -202,8 +204,12 @@ static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 	struct rxe_pool *pool = elem->pool;
+	struct xarray *xa = &pool->xa;
+	unsigned long flags;
 
-	xa_erase(&pool->xa, elem->index);
+	xa_lock_irqsave(xa, flags);
+	__xa_erase(&pool->xa, elem->index);
+	xa_unlock_irqrestore(xa, flags);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
@@ -223,3 +229,27 @@ int __rxe_put(struct rxe_pool_elem *elem)
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
+
+void __rxe_disable_lookup(struct rxe_pool_elem *elem)
+{
+	struct xarray *xa = &elem->pool->xa;
+	unsigned long flags;
+	void *ret;
+
+	xa_lock_irqsave(xa, flags);
+	ret = __xa_store(&elem->pool->xa, elem->index, NULL, GFP_KERNEL);
+	xa_unlock_irqrestore(xa, flags);
+	WARN_ON(xa_err(ret));
+}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 24bcc786c1b3..aa66d0eea13b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -63,20 +63,23 @@ void *rxe_alloc(struct rxe_pool *pool);
 
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
 
 #define rxe_read(obj) kref_read(&(obj)->elem.ref_cnt)
 
+void __rxe_finalize(struct rxe_pool_elem *elem);
+#define rxe_finalize(obj) __rxe_finalize(&(obj)->elem)
+
+void __rxe_disable_lookup(struct rxe_pool_elem *elem);
+#define rxe_disable_lookup(obj) __rxe_disable_lookup(&(obj)->elem)
+
 #endif /* RXE_POOL_H */
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 4c082ac439c6..6a83b4a630f5 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -197,6 +197,8 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	}
 
 	rxe_init_av(init_attr->ah_attr, &ah->av);
+	rxe_finalize(ah);
+
 	return 0;
 }
 
@@ -228,6 +230,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
 {
 	struct rxe_ah *ah = to_rah(ibah);
 
+	rxe_disable_lookup(ah);
 	rxe_put(ah);
 	return 0;
 }
@@ -435,6 +438,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 	if (err)
 		goto qp_init;
 
+	rxe_finalize(qp);
 	return 0;
 
 qp_init:
@@ -487,6 +491,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct rxe_qp *qp = to_rqp(ibqp);
 	int ret;
 
+	rxe_disable_lookup(qp);
 	ret = rxe_qp_chk_destroy(qp);
 	if (ret)
 		return ret;
@@ -905,6 +910,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 
 	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
+	rxe_finalize(mr);
 
 	return &mr->ibmr;
 }
@@ -933,6 +939,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	if (err)
 		goto err3;
 
+	rxe_finalize(mr);
+
 	return &mr->ibmr;
 
 err3:
@@ -965,6 +973,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	if (err)
 		goto err2;
 
+	rxe_finalize(mr);
+
 	return &mr->ibmr;
 
 err2:
-- 
2.32.0

