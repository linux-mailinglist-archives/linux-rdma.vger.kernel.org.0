Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEA254ACB
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0QiI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 12:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0QiH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Aug 2020 12:38:07 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9700C061264
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 09:38:07 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id u28so1362931ooe.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Aug 2020 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Lq4j9zVMzBdwPoubpN2chrHR0/6W3MajBVa3dvvLU=;
        b=uTkIm9NdYURMDrhSW2YF9tdNTpYZ0qsmb6+fUYTc0JjPo9/Bs/8aT2xS8LNwP5kkFb
         Ptw4AWKvHmCvhIfNPpprKElik1R4+Lyg7Xj3Cyd24cWQXkdkW68yCWOc+CT8Qi7kxbxn
         fbC+UeDFipqDibctxw/XfwdVM9aiODcRQsQXxM9/53E1ZHR1GjN00TjsI68E91M9INBv
         9F1yYzmgU6JWlc7iPx0yKv3s5GtQ4oWWtr511ZzG7WmKZCOCgGC0KjcAfAra0fPHbUeK
         WzfFtCrCqdDK+tlWgoz5IlgRGaJpSib55UHggu2FGsZk7QA+jBm8xDPxu8JgCZf4J+6r
         +6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N6Lq4j9zVMzBdwPoubpN2chrHR0/6W3MajBVa3dvvLU=;
        b=QCAuduEfo5Rx9hRE9iMtQM/mQ4/JebDT/wq8BBsMbUhAwI3Pyq8n58pYkf3h7SyO72
         5uxMsbzAMo48oCCrqlfYoqr+ilkfxWgphRfNzcc/d0MpbZcQ3DKABN1Bg/2ujDIHEyQ1
         G95C4aAxVnKSaz+gGKfrmHRA8tp5DA1ikKhsGxwNoy2ZqGgCl8jKiOLF1xHFYnlOvueh
         y7ACZRmtwet+TFkS/eXqeYpWyq9W2L+ZOMSMzvK+Pzfl3Q01Zr/4oeOmPRQeJa4WTbEO
         XG1/8D/RZ6Q++kih1Ouulyl9aziU7x72LjitCOS2G/FIH3bIzX/lUYkDrLcvmkFivYaA
         PbLA==
X-Gm-Message-State: AOAM532M145zeJelN3nuISd5O6BY4eFzrzLTXbf41ho7oMV7nZvBDYIi
        ive03Wdd4WSNb9vWZm+Dk/8=
X-Google-Smtp-Source: ABdhPJzkz/EWOR8W6wGpKE+nmyBDr09cRVRh6yDThmJykV33Oe7EU2K2A6FJkBtjf2lZ4bomnnqhIw==
X-Received: by 2002:a4a:bd8c:: with SMTP id k12mr1608883oop.24.1598546286920;
        Thu, 27 Aug 2020 09:38:06 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4872:b571:a2a4:b341])
        by smtp.gmail.com with ESMTPSA id q187sm543674oig.49.2020.08.27.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 09:38:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 for-next] rdma_rxe: address an issue with hardened user copy
Date:   Thu, 27 Aug 2020 11:35:36 -0500
Message-Id: <20200827163535.2632-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change rxe pools to use kzalloc instead of kmem_cache to allocate
memory for rxe objects.

difference v1-v2:
	ported patch to current for-next branch

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  8 ----
 drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
 3 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 904351bcb9ce..3cba4a1f5070 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -309,13 +309,6 @@ static int __init rxe_module_init(void)
 {
 	int err;
 
-	/* initialize slab caches for managed objects */
-	err = rxe_cache_init();
-	if (err) {
-		pr_err("unable to init object pools\n");
-		return err;
-	}
-
 	err = rxe_net_init();
 	if (err)
 		return err;
@@ -330,7 +323,6 @@ static void __exit rxe_module_exit(void)
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
-	rxe_cache_exit();
 
 	pr_info("unloaded\n");
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index fbcbac52290b..25bb04c82779 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -110,62 +110,6 @@ static inline const char *pool_name(struct rxe_pool *pool)
 	return rxe_type_info[pool->type].name;
 }
 
-static inline struct kmem_cache *pool_cache(struct rxe_pool *pool)
-{
-	return rxe_type_info[pool->type].cache;
-}
-
-static void rxe_cache_clean(size_t cnt)
-{
-	int i;
-	struct rxe_type_info *type;
-
-	for (i = 0; i < cnt; i++) {
-		type = &rxe_type_info[i];
-		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
-			kmem_cache_destroy(type->cache);
-			type->cache = NULL;
-		}
-	}
-}
-
-int rxe_cache_init(void)
-{
-	int err;
-	int i;
-	size_t size;
-	struct rxe_type_info *type;
-
-	for (i = 0; i < RXE_NUM_TYPES; i++) {
-		type = &rxe_type_info[i];
-		size = ALIGN(type->size, RXE_POOL_ALIGN);
-		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
-			type->cache =
-				kmem_cache_create(type->name, size,
-						  RXE_POOL_ALIGN,
-						  RXE_POOL_CACHE_FLAGS, NULL);
-			if (!type->cache) {
-				pr_err("Unable to init kmem cache for %s\n",
-				       type->name);
-				err = -ENOMEM;
-				goto err1;
-			}
-		}
-	}
-
-	return 0;
-
-err1:
-	rxe_cache_clean(i);
-
-	return err;
-}
-
-void rxe_cache_exit(void)
-{
-	rxe_cache_clean(RXE_NUM_TYPES);
-}
-
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 {
 	int err = 0;
@@ -406,7 +350,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	elem = kmem_cache_zalloc(pool_cache(pool),
+	elem = kzalloc(rxe_type_info[pool->type].size,
 				 (pool->flags & RXE_POOL_ATOMIC) ?
 				 GFP_ATOMIC : GFP_KERNEL);
 	if (!elem)
@@ -468,7 +412,7 @@ void rxe_elem_release(struct kref *kref)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC))
-		kmem_cache_free(pool_cache(pool), elem);
+		kfree(elem);
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 	rxe_pool_put(pool);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2f2cff1cbe43..f249eca6b5f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -69,7 +69,6 @@ struct rxe_type_info {
 	u32			min_index;
 	size_t			key_offset;
 	size_t			key_size;
-	struct kmem_cache	*cache;
 };
 
 extern struct rxe_type_info rxe_type_info[];
@@ -113,12 +112,6 @@ struct rxe_pool {
 	size_t			key_size;
 };
 
-/* initialize slab caches for managed objects */
-int rxe_cache_init(void);
-
-/* cleanup slab caches for managed objects */
-void rxe_cache_exit(void);
-
 /* initialize a pool of objects with given limit on
  * number of elements. gets parameters from rxe_type_info
  * pool elements will be allocated out of a slab cache
-- 
2.25.1

