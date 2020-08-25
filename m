Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226B7251DB5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYRBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYRBQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 13:01:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D2DC061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 10:01:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n128so12252420oif.0
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uup6a/QG3ory1pv7v44s12RC7IJfnGB6j5bfAcfD8ks=;
        b=JkjyyEBvakNZoXW+pKHWSvTRo9Deu4+6rbXHKuLUvWYFpNoSQCXzC9tfvaD6KB04bs
         Md3W3Ttl1zJBy98yoX/JsiB/KyK0wJJXmkAkCJQU09KtaQdC8gvRmm0hBhgpE2EvfeOd
         PuaTAunNsUPebkWZusKqy4oNmACoJDHTI4rQlezfidnyIywQOoqw0HIMhlK1/VJB+FgV
         X7YjcCdI+8v+JwocZZa5UmxP4+gtPfFuWnjFBnpsk1Ofw5Cr7H5yOIZS/ZP7tuFJlwFo
         dKOfjMhjLl5Czxz8G8O/mtVdCT1utaRKChOgx5euBc0CKQt9g8eDvMqIu//PrKAcMJY7
         NCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uup6a/QG3ory1pv7v44s12RC7IJfnGB6j5bfAcfD8ks=;
        b=qVIZZpVTGg2QvbymIbeTqqD2UoZ31SH6R5iWiYBFR07Ig+alMQo9myld7BKHQLCMz5
         aiHpy+Rk9Wbg23oCAS2qSmhfGqaPBDinkcUG358AD3/CfV9h6TT/CVqI1MhExFWjR7c1
         RC+RBukJpWkW9KTrQawKaNRg2Esx0WydZfEB3rugJSH2YA/q0klI0luzQuzR9xYvdV4F
         jNYiAivXisFsJ3T+suZyRTHR4CY+JvB/TGx8+OFd1MCmLo5ph81mb1quCZDxxsGfro1U
         5RkM8DckRT2FQi1rWBcJHL28Cznwcw5X3468tn9ESnwXwlMqNXtGB8p4rQmErUGegj48
         ABYQ==
X-Gm-Message-State: AOAM530PDYEKWZ05FqhsdQOD463iOZuf+GtmTSjYUyzM5iJeGQzxklvw
        my2IL8ObAg4Rknoe1nF5WfRndSYPORBLZQ==
X-Google-Smtp-Source: ABdhPJwu9RkRqvNqi7oc+qQ2P2SqZmvGhtN7705nFhkmJyr60ZrBWTCaK/qPpR0qNHW9QvYEK4wMXQ==
X-Received: by 2002:aca:1016:: with SMTP id 22mr1506030oiq.63.1598374875888;
        Tue, 25 Aug 2020 10:01:15 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d277:9c63:7fd2:8e07])
        by smtp.gmail.com with ESMTPSA id s7sm373864oig.48.2020.08.25.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:01:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] rdma_rxe: address an issue with hardened user copy
Date:   Tue, 25 Aug 2020 11:58:37 -0500
Message-Id: <20200825165836.27477-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change rxe pools to use kzalloc instead of kmem_cache to allocate
memory for rxe objects.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c      |  8 ----
 drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
 3 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index cc395da13eff..a1ff70e0b1f8 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -277,13 +277,6 @@ static int __init rxe_module_init(void)
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
@@ -298,7 +291,6 @@ static void __exit rxe_module_exit(void)
 	rdma_link_unregister(&rxe_link_ops);
 	ib_unregister_driver(RDMA_DRIVER_RXE);
 	rxe_net_exit();
-	rxe_cache_exit();
 
 	pr_info("unloaded\n");
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index c0fab4a65f9e..70fc9f7a25b6 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -84,62 +84,6 @@ static inline const char *pool_name(struct rxe_pool *pool)
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
@@ -381,7 +325,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	elem = kmem_cache_zalloc(pool_cache(pool),
+	elem = kzalloc(rxe_type_info[pool->type].size,
 				 (pool->flags & RXE_POOL_ATOMIC) ?
 				 GFP_ATOMIC : GFP_KERNEL);
 	if (!elem)
@@ -443,7 +387,7 @@ void rxe_elem_release(struct kref *kref)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC))
-		kmem_cache_free(pool_cache(pool), elem);
+		kfree(elem);
 	atomic_dec(&pool->num_elem);
 	ib_device_put(&pool->rxe->ib_dev);
 	rxe_pool_put(pool);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 64d92be3f060..3d722aae5f15 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -42,7 +42,6 @@ struct rxe_type_info {
 	u32			min_index;
 	size_t			key_offset;
 	size_t			key_size;
-	struct kmem_cache	*cache;
 };
 
 extern struct rxe_type_info rxe_type_info[];
@@ -96,12 +95,6 @@ struct rxe_pool {
 	} key;
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

