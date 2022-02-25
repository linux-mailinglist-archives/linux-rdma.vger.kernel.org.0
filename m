Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580F04C4F32
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiBYT7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiBYT7K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:10 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE67120EBE
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:37 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso4362919ots.7
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HEb1Gfg4HQPtTujvveAoUv4RBEDqFBnORE1eNKlElxI=;
        b=kAEPf7I89S7OZqYIPK0XkZqAqj1xSnxVPIUMYhmK4aA9DSRzVb2RtgN+Wt1KM+KH7+
         D4RKSeBC4REwEZaI2tFAwQ7bXh4NWw4a0LSliH+hrfqbzYrPoAE48xmTE7kTrK62buZF
         AKkPvoHw7HffFZgonNJ8VyTKOTr9+KtX4CAgTxJ506yzyd0IIUsJHJRaenNICqdwnKH6
         sm4mywognzYEFYceT9zYX0vBB4yRIaJXT+h2MIaXCLwZqg4+1EZnPWNkbXnajgigsC0v
         WMRbUbBNDB0Sg17+4oiTZEg/Rh4SyWxMIAAGNYW/q8qXZRsR0LKsE3qutfr5+TG+650t
         mogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEb1Gfg4HQPtTujvveAoUv4RBEDqFBnORE1eNKlElxI=;
        b=r0U7jCPRG3aiNvSameevFlzXMuzrJWQ5x/9b3tsgiq2WgQ1aXSWAm0XM3nOh1h+/Uj
         tC4KJ7vYV8Fa/Lg1r07DGQ+VlyIsbMoHDszz9oNtIhrR4vnsBaijQPiew63/VXMJiSiT
         gP/W135Ewy/OoEOGgFCRF2lpAmBUKv1ouCt5Xmr0HVnVkoeFFRD8b7gyLqDxNOgOh5dL
         dKWduUqw8AYCRSazXS0+5vdaUS6CLTSKDeoOmjg6aWCFPA0OGOboEB4YPRib2UpCHh2C
         o5FQ2buKKh2D+aMxEqmQXZ/NYRAy4YquSMbpOrPgAXKsDUJbuCQfx9UDZ52ORroYPN2u
         MX1A==
X-Gm-Message-State: AOAM530ksz7QPgx4H3G3U1Yky4mXfov9XpS2VOq3S/S2B0Go0kgt5e4k
        60MbtkHItqoH3cpoxTTxJsg=
X-Google-Smtp-Source: ABdhPJwlaqEncSFXKnigiksOWPGJgbAemJ4EAF+vvWd2gklAFSEfOLRocyb6GiHZ28cqylyoIxzYQA==
X-Received: by 2002:a9d:6489:0:b0:5ad:1cd:94b1 with SMTP id g9-20020a9d6489000000b005ad01cd94b1mr3497687otl.321.1645819117026;
        Fri, 25 Feb 2022 11:58:37 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 11/11] RDMA/rxe: Cleanup rxe_pool.c
Date:   Fri, 25 Feb 2022 13:57:51 -0600
Message-Id: <20220225195750.37802-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
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

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 110 ++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 20b97a90b4c8..8c207c90304a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -1,14 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
 #include "rxe.h"
 
-#define RXE_POOL_TIMEOUT	(200)
-#define RXE_MAX_POOL_TIMEOUTS	(3)
-#define RXE_POOL_ALIGN		(16)
+#define RXE_POOL_TIMEOUT	200		/* jiffies */
+#define RXE_MAX_POOL_TIMEOUTS	3
+
+#ifdef L1_CACHE_BYTES
+#define RXE_POOL_ALIGN		L1_CACHE_BYTES
+#else
+#define RXE_POOL_ALIGN		64
+#endif
 
 static const struct rxe_type_info {
 	const char *name;
@@ -21,7 +27,7 @@ static const struct rxe_type_info {
 	u32 max_elem;
 } rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
-		.name		= "rxe-uc",
+		.name		= "uc",
 		.size		= sizeof(struct rxe_ucontext),
 		.elem_offset	= offsetof(struct rxe_ucontext, elem),
 		.min_index	= 1,
@@ -29,7 +35,7 @@ static const struct rxe_type_info {
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_PD] = {
-		.name		= "rxe-pd",
+		.name		= "pd",
 		.size		= sizeof(struct rxe_pd),
 		.elem_offset	= offsetof(struct rxe_pd, elem),
 		.min_index	= 1,
@@ -37,7 +43,7 @@ static const struct rxe_type_info {
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_AH] = {
-		.name		= "rxe-ah",
+		.name		= "ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
 		.min_index	= RXE_MIN_AH_INDEX,
@@ -45,7 +51,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_AH_INDEX - RXE_MIN_AH_INDEX + 1,
 	},
 	[RXE_TYPE_SRQ] = {
-		.name		= "rxe-srq",
+		.name		= "srq",
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.min_index	= RXE_MIN_SRQ_INDEX,
@@ -53,7 +59,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_SRQ_INDEX - RXE_MIN_SRQ_INDEX + 1,
 	},
 	[RXE_TYPE_QP] = {
-		.name		= "rxe-qp",
+		.name		= "qp",
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
@@ -62,7 +68,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_QP_INDEX - RXE_MIN_QP_INDEX + 1,
 	},
 	[RXE_TYPE_CQ] = {
-		.name		= "rxe-cq",
+		.name		= "cq",
 		.size		= sizeof(struct rxe_cq),
 		.elem_offset	= offsetof(struct rxe_cq, elem),
 		.cleanup	= rxe_cq_cleanup,
@@ -71,7 +77,7 @@ static const struct rxe_type_info {
 		.max_elem	= UINT_MAX,
 	},
 	[RXE_TYPE_MR] = {
-		.name		= "rxe-mr",
+		.name		= "mr",
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
@@ -81,7 +87,7 @@ static const struct rxe_type_info {
 		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
 	},
 	[RXE_TYPE_MW] = {
-		.name		= "rxe-mw",
+		.name		= "mw",
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.min_index	= RXE_MIN_MW_INDEX,
@@ -90,6 +96,12 @@ static const struct rxe_type_info {
 	},
 };
 
+/**
+ * rxe_pool_init - initialize a rxe object pool
+ * @rxe: rxe device pool belongs to
+ * @pool: object pool
+ * @type: pool type
+ */
 void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 		   enum rxe_elem_type type)
 {
@@ -113,6 +125,10 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 	pool->limit.min = info->min_index;
 }
 
+/**
+ * rxe_pool_cleanup - free any remaining pool resources
+ * @pool: object pool
+ */
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
@@ -135,9 +151,15 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 
 	if (elem_count || obj_count)
 		pr_warn("Freed %d indices and %d objects from pool %s\n",
-			elem_count, obj_count, pool->name + 4);
+			elem_count, obj_count, pool->name);
 }
 
+/**
+ * rxe_alloc - allocate a new pool object
+ * @pool: object pool
+ *
+ * Returns: object on success else NULL
+ */
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
@@ -178,6 +200,13 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
+/**
+ * __rxe_add_to_pool - add rdma-core allocated object to rxe object pool
+ * @pool: object pool
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 0 on success else an error
+ */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err;
@@ -208,6 +237,13 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	return -EINVAL;
 }
 
+/**
+ * rxe_pool_get - find object in pool with given index
+ * @pool: object pool
+ * @index: index
+ *
+ * Returns: object on success else NULL
+ */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
@@ -224,6 +260,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
+/**
+ * rxe_elem_release - remove object index and complete
+ * @kref: kref embedded in pool element
+ * @flags: flags for lock release
+ *
+ * Context: called holding pool->xa.xa_lock which must be
+ *	    dropped. Called from __rxe_drop_ref() when the ref count
+ *	    reaches zero. Completes the object scheduling
+ *	    a waiter on the object.
+ */
 static void rxe_elem_release(struct kref *kref, unsigned long flags)
 	__releases(&pool->xa.xa_lock)
 {
@@ -238,13 +284,28 @@ static void rxe_elem_release(struct kref *kref, unsigned long flags)
 	complete(&elem->complete);
 }
 
+/**
+ * __rxe_add_ref - gets a kref on the object unless ref count is zero
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: 1 if reference is added else 0 because
+ *	    ref count has reached zero
+ */
 int __rxe_add_ref(struct rxe_pool_elem *elem)
 {
 	return kref_get_unless_zero(&elem->ref_cnt);
 }
 
-/* local copy of kref_put_lock_irqsave same as kref_put_lock
- * except for _irqsave locks
+/**
+ * kref_put_lock_irqsave - local copy of kref_put_lock
+ * @kref: kref embedded in elem
+ * @release: cleanup function called when ref count reaches zero
+ * @lock: irqsave spinlock to take if ref count reaches zero
+ *
+ * Same as kref_put_lock except for _irqsave locks
+ *
+ * Returns: 1 if ref count reaches zero and release is called
+ *	    while holding the lock else 0.
  */
 static int kref_put_lock_irqsave(struct kref *kref,
 		 void (*release)(struct kref *kref, unsigned long flags),
@@ -259,6 +320,15 @@ static int kref_put_lock_irqsave(struct kref *kref,
 	return 0;
 }
 
+/**
+ * __rxe_drop_ref - puts a kref on the object
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Puts a kref on the object and if ref count reaches zero
+ * takes the lock and calls release() which must free the lock.
+ *
+ * Returns: 1 if ref count reaches zero and release called else 0
+ */
 int __rxe_drop_ref(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -267,6 +337,12 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem)
 			&pool->xa.xa_lock);
 }
 
+/**
+ * __rxe_drop_wait - put a kref on object and wait for completion
+ * @elem: rxe_pool_elem embedded in object
+ *
+ * Returns: non-zero value if completion is reached else 0 if timeout
+ */
 int __rxe_drop_wait(struct rxe_pool_elem *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -275,7 +351,7 @@ int __rxe_drop_wait(struct rxe_pool_elem *elem)
 
 	if (elem->enabled) {
 		pr_warn_once("%s#%d: should be disabled by now\n",
-			     elem->pool->name + 4, elem->index);
+			     elem->pool->name, elem->index);
 		elem->enabled = false;
 	}
 
@@ -285,11 +361,11 @@ int __rxe_drop_wait(struct rxe_pool_elem *elem)
 		ret = wait_for_completion_timeout(&elem->complete, timeout);
 		if (!ret) {
 			pr_warn("Timed out waiting for %s#%d\n",
-				pool->name + 4, elem->index);
+				pool->name, elem->index);
 			if (++pool->timeouts == RXE_MAX_POOL_TIMEOUTS) {
 				timeout = 0;
 				pr_warn("Reached max %s timeouts.\n",
-					pool->name + 4);
+					pool->name);
 			}
 		}
 	}
-- 
2.32.0

