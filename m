Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF964CCA93
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiCDAJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiCDAJj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:39 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001A40E56
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:51 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id z7so6393142oid.4
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFMA80fY+emg/ziM5RYoXYxNAJGSLagKIl++pDhI8cY=;
        b=C7hIhAfhH1hlocj0goWS+DNt5AxCGlzoLGcVxeE/pKWe1eWucqjFQF72vZTvD0aJCU
         /PCLvsY1MbeZ/sFypaS4VJC/hlNshhiICQ0DKq5LCVFz8S028t/H6k9tuLCwjJ1M6aSz
         rt8SrZYyjiYoTmyxdzkW2l5PaP6KwilYFQyEBMqQ5Bv4vxFUrBBXl9qfA3WPgp6ACFvY
         d6P33oB1hwCmi8vazhez0BA3O7cRid4ufb52/ocGYifnMgX4sdIDiTgeMUkXo05ru+Gu
         XLuReiElMlLbFHcPRYrHBUxyWix5t0u7v6uY3BRZ1W2TASjY6hhFLkmARwB9KXOXX9mS
         GnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFMA80fY+emg/ziM5RYoXYxNAJGSLagKIl++pDhI8cY=;
        b=G5J9b0W9F806OZ8CLZ7wD0NjvuiZLI52cRp/zn6NH/c2GvjIBNhkkWmFyGVXDVorKL
         2wDVAHU2AuCw536l5BgiqYwKD9gKA1RPW3V8dciox2cchRJ1/b+Rxok66NiynwlA8bYu
         dKWoqYpfSRHJyCdQg0IJJ69v2de7MH9GG6UJQ3C+RcqQCULctSMRKUK6HbPXixGAAk4C
         rezzbrMO2ig9Uu1HkSL/MFBXPRWcHsIFFt27dQ3QnTs2Fe2K54DWMpnc/zVv1QYJQ48q
         i7V6uMeuDrfF94ed1RRvJmQt+Zc3H6lF3crxu/Fbk9JAtBNVN0akwJt5algyoGNoPKEt
         XGBA==
X-Gm-Message-State: AOAM530LHcRUi0/JmDPfqZTJMTJY9GRtrs1dKdvEZ48HOm3fpu2F6YLH
        sTTY6LQMmh/Tyq32lcFDlbM=
X-Google-Smtp-Source: ABdhPJzhEx4wopXcO0i8v3Eb438BFhY1GqseizGshuArID3qWkdXXgVa+BXNpCU2QTbCGJRS65NvTA==
X-Received: by 2002:a05:6808:1b12:b0:2d4:51b4:9ee with SMTP id bx18-20020a0568081b1200b002d451b409eemr6955323oib.116.1646352530711;
        Thu, 03 Mar 2022 16:08:50 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:50 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 13/13] RDMA/rxe: Cleanup rxe_pool.c
Date:   Thu,  3 Mar 2022 18:08:09 -0600
Message-Id: <20220304000808.225811-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304000808.225811-1-rpearsonhpe@gmail.com>
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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

Minor cleanup of rxe_pool.c. Add document comment headers for
the subroutines. Increase alignment for pool elements.
Convert some printk's to WARN-ON's.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 129 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  27 ++----
 2 files changed, 115 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ec464b03d120..d5cd0e71e9a0 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -1,14 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
 #include "rxe.h"
 
-#define RXE_POOL_TIMEOUT	(200)
-#define RXE_POOL_MAX_TIMEOUTS	(3)
-#define RXE_POOL_ALIGN		(16)
+#define RXE_POOL_TIMEOUT	(200)	/* jiffies */
+#define RXE_POOL_ALIGN		(64)
 
 static const struct rxe_type_info {
 	const char *name;
@@ -90,6 +90,14 @@ static const struct rxe_type_info {
 	},
 };
 
+/**
+ * rxe_pool_init - initialize a rxe object pool
+ * @rxe: rxe device pool belongs to
+ * @pool: object pool
+ * @type: pool type
+ *
+ * Called from rxe_init()
+ */
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		   enum rxe_elem_type type)
 {
@@ -113,6 +121,12 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 	pool->limit.max = info->max_index;
 }
 
+/**
+ * rxe_pool_cleanup - free any remaining pool resources
+ * @pool: object pool
+ *
+ * Called from rxe_dealloc()
+ */
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
@@ -136,24 +150,37 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 
 	if (WARN_ON(elem_count || obj_count))
 		pr_debug("Freed %d indices and %d objects from pool %s\n",
-			elem_count, obj_count, pool->name);
+			 elem_count, obj_count, pool->name);
 }
 
+/**
+ * rxe_alloc - allocate a new pool object
+ * @pool: object pool
+ *
+ * Context: in task.
+ * Returns: object on success else an ERR_PTR
+ */
 void *rxe_alloc(struct rxe_pool *pool)
 {
+	struct xarray *xa = &pool->xa;
 	struct rxe_pool_elem *elem;
 	void *obj;
-	int err;
+	int err = -EINVAL;
 
 	if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
-		return NULL;
+		goto err_out;
+
+	if (WARN_ON(!in_task()))
+		goto err_dec;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto err_cnt;
+		goto err_dec;
 
 	obj = kzalloc(pool->elem_size, GFP_KERNEL);
-	if (!obj)
-		goto err_cnt;
+	if (!obj) {
+		err = -ENOMEM;
+		goto err_dec;
+	}
 
 	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
@@ -162,7 +189,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	kref_init(&elem->ref_cnt);
 	init_completion(&elem->complete);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
+	err = xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_free;
@@ -171,38 +198,59 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 err_free:
 	kfree(obj);
-err_cnt:
+err_dec:
 	atomic_dec(&pool->num_elem);
-	return NULL;
+err_out:
+	return ERR_PTR(err);
 }
 
+/**
+ * __rxe_add_to_pool - add rdma-core allocated object to rxe object pool
+ * @pool: object pool
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Context: in task.
+ * Returns: 0 on success else an error
+ */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
-	int err;
+	struct xarray *xa = &pool->xa;
+	int err = -EINVAL;
 
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
-		return -EINVAL;
+		goto err_out;
+
+	if (WARN_ON(!in_task()))
+		goto err_out;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto err_cnt;
+		goto err_dec;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 	init_completion(&elem->complete);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
+	err = xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
 			      &pool->next, GFP_KERNEL);
 	if (err)
-		goto err_cnt;
+		goto err_dec;
 
 	return 0;
 
-err_cnt:
+err_dec:
 	atomic_dec(&pool->num_elem);
-	return -EINVAL;
+err_out:
+	return err;
 }
 
+/**
+ * rxe_pool_get_index - find object in pool with given index
+ * @pool: object pool
+ * @index: index
+ *
+ * Returns: object on success else NULL
+ */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
@@ -220,6 +268,12 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
+/**
+ * rxe_elem_release - remove object index and complete
+ * @kref: kref embedded in pool element
+ *
+ * Context: ref count of pool object has reached zero.
+ */
 static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
@@ -234,6 +288,12 @@ static void rxe_elem_release(struct kref *kref)
 	complete(&elem->complete);
 }
 
+/**
+ * __rxe_wait - put a ref on object and wait for completion
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 0 if object did not timeout else an error
+ */
 int __rxe_wait(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -244,12 +304,9 @@ int __rxe_wait(struct rxe_pool_elem *elem)
 
 	if (timeout) {
 		ret = wait_for_completion_timeout(&elem->complete, timeout);
-		if (!ret) {
-			pr_warn("Timed out waiting for %s#%d to complete\n",
+		if (WARN_ON(!ret)) {
+			pr_debug("Timed out waiting for %s#%d to complete\n",
 				pool->name, elem->index);
-			if (++pool->timeouts >= RXE_POOL_MAX_TIMEOUTS)
-				timeout = 0;
-
 			err = -EINVAL;
 		}
 	}
@@ -265,16 +322,34 @@ int __rxe_wait(struct rxe_pool_elem *elem)
 	return err;
 }
 
+/**
+ * __rxe_add_ref - takes a ref on the object unless ref count is zero
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if reference is added else 0
+ */
 int __rxe_get(struct rxe_pool_elem *elem)
 {
 	return kref_get_unless_zero(&elem->ref_cnt);
 }
 
+/**
+ * __rxe_drop_ref - puts a ref on the object
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if ref count reaches zero and release called else 0
+ */
 int __rxe_put(struct rxe_pool_elem *elem)
 {
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
+/**
+ * __rxe_show - enable looking up object from index
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns 0 on success else an error
+ */
 int __rxe_show(struct rxe_pool_elem *elem)
 {
 	struct xarray *xa = &elem->pool->xa;
@@ -290,6 +365,12 @@ int __rxe_show(struct rxe_pool_elem *elem)
 		return 0;
 }
 
+/**
+ * __rxe_hide - disable looking up object from index
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns 0 on success else an error
+ */
 int __rxe_hide(struct rxe_pool_elem *elem)
 {
 	struct xarray *xa = &elem->pool->xa;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0529ad8e819b..73f549efe632 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -906,8 +906,8 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(mr))
+		return (void *)mr;
 
 	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
@@ -928,26 +928,22 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err2;
-	}
-
+	if (IS_ERR(mr))
+		return (void *)mr;
 
 	rxe_get(pd);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
-		goto err3;
+		goto err;
 
 	rxe_show(mr);
 
 	return &mr->ibmr;
 
-err3:
+err:
 	rxe_put(pd);
 	rxe_wait(mr);
-err2:
 	return ERR_PTR(err);
 }
 
@@ -963,25 +959,22 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		return ERR_PTR(-EINVAL);
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	if (IS_ERR(mr))
+		return (void *)mr;
 
 	rxe_get(pd);
 
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
-		goto err2;
+		goto err;
 
 	rxe_show(mr);
 
 	return &mr->ibmr;
 
-err2:
+err:
 	rxe_put(pd);
 	rxe_wait(mr);
-err1:
 	return ERR_PTR(err);
 }
 
-- 
2.32.0

