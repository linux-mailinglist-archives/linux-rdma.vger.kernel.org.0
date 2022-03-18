Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9D4DD2A5
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiCRB5C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiCRB47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:59 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1459228D19
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:37 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id g5-20020a4ae885000000b003240bc9b2afso8640155ooe.10
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYawtwpv6Y9qKlUQoHPjSDM4jpJIEG2N3SaK8Pipadg=;
        b=pvgrlSgtMVo6rjRJWxcQnG86cYKivVMowewnJ5pfvFJqe/9VNLh+x3wPdzx51t9Fc6
         aQLP3Zjxzug7zJ5cwjdj2A40FaF33FO1L6k3l4tkpijSa6vOj71p64SbLXeYzMlJd+gQ
         i93MeBCVEK4r7iKIBImh0BH1bkxMAt2qFEmnRrfV4uPBLdAn9FYeoPYa28AA/lYkd7dW
         d6+OS8guL6XTM8QkHkjrWOTwy0FIspBj+b1rg9/ImjdJOn1abmUTEq/k49URzWIX3C0g
         96L/acGEnU17rSu3Fwv1b3ZN0O67y6pcTOl+H9z2t0zHJO6y8n4vg88cTsWv9ecbPKVI
         1rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYawtwpv6Y9qKlUQoHPjSDM4jpJIEG2N3SaK8Pipadg=;
        b=cW9rELKPRTlVaOLimMPSvoRH1pmps+RTMWJdsTzjx2KS4UuvNRt1Qk0k1b0cKkwog3
         QN26ja/4FbyBP2JTj+CH01S4/A+QXBeeYeqvH70RxFb/t8unadencPtWPPfsHo8WvDpM
         uCqEs6lEOB9hVxafjFm0T47lFf9T1B1Pz9v3Dqaw3luMKq5wspoUpJbpQdGFt92cYtb5
         O7E6lUPFXgilfAeaIaFQEOpGCKtiNwjtQF3tNvzsPq4Zd6R+s0mL2RmAq2Mq0sLnsW2z
         zjtVmjCey4bPuyBuqoHgD/H4vNB0EJSt9VC2LTrUQFxiDvCe/jWGRsL0z7qvLbrQbcHC
         +Msw==
X-Gm-Message-State: AOAM5322o4ycoE3sfDvvGMtOY2Po6dS62eP8JBwqqR5X8Mk5eSrOqG+K
        67L1v4U2fv21O0TL0qUoLGM=
X-Google-Smtp-Source: ABdhPJw4uDUgN9KwHwqDotLj+dFmDG6nJ4qHZn4ET66id++/dce64Q1THOz431hMv/enFGLE5Nq33w==
X-Received: by 2002:a05:6870:d38c:b0:dd:a1f6:2982 with SMTP id k12-20020a056870d38c00b000dda1f62982mr4811807oag.91.1647568537158;
        Thu, 17 Mar 2022 18:55:37 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 11/11] RDMA/rxe: Cleanup rxe_pool.c
Date:   Thu, 17 Mar 2022 20:55:14 -0500
Message-Id: <20220318015514.231621-12-rpearsonhpe@gmail.com>
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

Minor cleanup of rxe_pool.c. Add document comment headers for
the subroutines. Increase alignment for pool elements.
Convert some printk's to WARN-ON's.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 81 ++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index a2c74beceeae..268757a106ce 100644
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
@@ -248,16 +279,32 @@ int __rxe_cleanup(struct rxe_pool_elem *elem)
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
@@ -270,6 +317,10 @@ void __rxe_finalize(struct rxe_pool_elem *elem)
 	WARN_ON(xa_err(ret));
 }
 
+/**
+ * __rxe_disable_lookup - disable looking up object from index
+ * @elem: rxe_pool_elem embedded in object
+ */
 void __rxe_disable_lookup(struct rxe_pool_elem *elem)
 {
 	struct xarray *xa = &elem->pool->xa;
-- 
2.32.0

