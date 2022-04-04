Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE04F1F23
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiDDWaN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345323AbiDDW2X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:23 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5821051E6D
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id k10so11535757oia.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACEymdZ+o6PzYutMiFq8CSopxsHRpbZdzFfwaeopvi0=;
        b=YilbgnBSlpCnDrVP88PWj9EaLjZMPJzNlA3pWM33wSWuW7GhzbL+OCrDJz2xseSAvd
         PHoqYxAGlCvKKgbl3lQE/9jM2OfE6X4us5sC0+tftmRHx7NAvgHR/EzfYfZled0ezFHp
         t7cH/upklCViU9XS0ZOJbg0Rz+VP4UlvHzEzuzg7SC6h8TFXNihIBO+RQRlJws7N19S5
         3n38Q4Z0cFdxTP8mW/xPTJvtwpPYPn+wqD4tjFXN6OIJfafwASlWFmbayhBWKAPSQGHS
         vqW0hAQEr65g/OWX9GpZIZY/A+H8HjXYkGxnfWzhZS239hllv12ZEJe2o7d84TOzsgbk
         Cqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACEymdZ+o6PzYutMiFq8CSopxsHRpbZdzFfwaeopvi0=;
        b=TL983wZxGj65Zz4T+5uB8P9UMYFIFNcjvX85XHs6SdHeFjvaLF6MsuyIMghQKtGsBp
         pWnJYUj5vyoR6A3O/iruf2VnD8K7y/IgvMmIkO5GZAoR+ndZwV679fb9gMLVkGD+ksxG
         l3qubvoVJ8+UmeIKbYc79YFJMUGnlK00TWZ4Zodao3DfRuZAUee+L+NFztZB3pIP5ko7
         3ZFE7l/RiwI2e66CWZBTZEeqrlLysPjAPLcS8rSVLbTUyes27/c0fQzuO6xc6kdOGWMk
         CuGH2ncMUi62IJdW3wPWipWehEBGvvpH+Wwsp8jCl4AZgor4PK2fcQd3g9JhbE7MjHoy
         giCQ==
X-Gm-Message-State: AOAM532nksHMkGyrrspkYe7gaLXdte6dj+TUgw11BYSXbn+OvT1eGkQ8
        +0L5yOtVfKwKmG5CHVJA38k=
X-Google-Smtp-Source: ABdhPJxo769nYuOrhFh4SQ6UHuwYW4Y1isFIrlZq0+kKeQig9mMGPZLDGAPcrGIyzkhNQux+B/yUhg==
X-Received: by 2002:a05:6808:168b:b0:2f7:338b:7a55 with SMTP id bb11-20020a056808168b00b002f7338b7a55mr153432oib.133.1649109091647;
        Mon, 04 Apr 2022 14:51:31 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 10/10] RDMA/rxe: Cleanup rxe_pool.c
Date:   Mon,  4 Apr 2022 16:51:00 -0500
Message-Id: <20220404215059.39819-11-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_pool.c | 89 +++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index cbe7b05c3b66..3b98650fb971 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -8,7 +8,7 @@
 
 #define RXE_POOL_TIMEOUT	(200)
 #define RXE_POOL_MAX_TIMEOUTS	(3)
-#define RXE_POOL_ALIGN		(16)
+#define RXE_POOL_ALIGN		(64)
 
 static const struct rxe_type_info {
 	const char *name;
@@ -120,24 +120,35 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 	WARN_ON(!xa_empty(&pool->xa));
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
 	struct rxe_pool_elem *elem;
 	void *obj;
-	int err;
+	int err = -EINVAL;
 
 	if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
-		return NULL;
+		goto err_out;
+
+	if (WARN_ON(!in_task()))
+		goto err_out;
 
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
-
 	elem->pool = pool;
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
@@ -154,20 +165,32 @@ void *rxe_alloc(struct rxe_pool *pool)
 
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
@@ -177,15 +200,23 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
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
@@ -203,6 +234,10 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
+/**
+ * rxe_elem_release - complete object when last reference is dropped
+ * @kref: kref contained in rxe_pool_elem
+ */
 static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
@@ -210,6 +245,12 @@ static void rxe_elem_release(struct kref *kref)
 	complete(&elem->complete);
 }
 
+/**
+ * __rxe_cleanup - cleanup object after waiting for all refs to be dropped
+ * @elem: rxe_pool_elem
+ *
+ * Returns: 0 on success else an error
+ */
 int __rxe_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -229,7 +270,7 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 
 	/* if this is the last call to rxe_put complete the
 	 * object. It is safe to touch elem after this since
-	 * it is freed below
+	 * it is freed below if locally allocated
 	 */
 	__rxe_put(elem);
 
@@ -256,16 +297,32 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
 	return err;
 }
 
+/**
+ * __rxe_get - takes a ref on the object unless ref count is zero
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if reference is added else 0
+ */
 int __rxe_get(struct rxe_pool_elem *elem)
 {
 	return kref_get_unless_zero(&elem->ref_cnt);
 }
 
+/**
+ * __rxe_put - puts a ref on the object
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if ref count reaches zero and release called else 0
+ */
 int __rxe_put(struct rxe_pool_elem *elem)
 {
 	return kref_put(&elem->ref_cnt, rxe_elem_release);
 }
 
+/**
+ * __rxe_finalize - enable looking up object from index
+ * @elem: rxe_pool_elem embedded in object
+ */
 void __rxe_finalize(struct rxe_pool_elem *elem)
 {
 	struct xarray *xa = &elem->pool->xa;
-- 
2.32.0

