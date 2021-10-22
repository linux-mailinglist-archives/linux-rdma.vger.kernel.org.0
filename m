Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B52E437E7D
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhJVTVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhJVTVu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:50 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77787C061767
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:32 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t4so6288346oie.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbcglwRPTMfZy8xKDggfbfFmuRg3N89aN8c8BXW7tu8=;
        b=B6/QqTSY34FwR8srnCt3dPKnUil3tWoQCn9A8Q/SSX+tk/ScPt52/0N5+gRVWBcec+
         x5xhg3irsIXPKWwjyZ69V2xY6TjrcGLg3tSQle5h6NapBKY5FXOEFUae5roZOVidN5SA
         ff0Rb7193+xUFqCngC+DrxVGRwzAp1Pqg6+sQ6KWXvPmDvDalxO6WKR5x9nhDjevlVej
         aHly8bn+e03U7+Gn7HmetIuw9HicOcZrYeF/Z7FvcAI817plP9YL1418Lt4jfjfyWdR7
         0GwHI5ddzly+JrkM7eICotCkPESnZmsAOJD4uKuiu8gvyfGfAB0MRidUXip5sWLVpNfX
         h8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbcglwRPTMfZy8xKDggfbfFmuRg3N89aN8c8BXW7tu8=;
        b=3pSyhnxNGwA+yKfMENlCsTuaZM+iTdXY9Wnlb53JIjSNc45EoxNVTtBXba/TOiwDU2
         ppGk1ZwSCQQtZu4mS4/829yJhsMhmJZG1kqsIlQUHiayVdy+fGxid548zcXcTQvW496/
         nrJyYr3rcjAnYI2mcH3nC+UVsfPbEptERcKRGPVQqjU3YQMvGIV70z7k36WW6Awe4g84
         gcTsstJVFWlvXBxlXy0i/rk0I+DX4CSGAJ3oddqv5qyq1JvNHEIsCcw4Bmvyy12J5Ry/
         IzO5ehMq/vuNKgF8LNIU6b415AMI6/4IlBJWiyU49HnYXFSxmLmwiEB5Vy1zy4Z0I8n0
         NfdQ==
X-Gm-Message-State: AOAM530/KLbY95wClH6R4A3LzbXNOPky4M/ehSp0aPDCh6rso0Wgc3sc
        5ysAZ6yfn7q8HayZ2eal+i1AtWkMv5k=
X-Google-Smtp-Source: ABdhPJwla6IIzVzdv9uUhmHNjAf7iVDXam53Mqguio9ZOZimSvBS9yps1o68JcxCRvP8HLtE2rxSkQ==
X-Received: by 2002:aca:aa03:: with SMTP id t3mr1150519oie.47.1634930371863;
        Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 02/10] RDMA/rxe: Copy setup parameters into rxe_pool
Date:   Fri, 22 Oct 2021 14:18:17 -0500
Message-Id: <20211022191824.18307-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c copy remaining pool setup parameters from rxe_pool_info into
rxe_pool. This saves looking up rxe_pool_info in the performance path.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 54 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  6 ++--
 2 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 8138e459b6c1..86251145705f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -7,9 +7,8 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* info about object pools
- */
-struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
+/* info about object pools */
+static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
@@ -88,11 +87,6 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	},
 };
 
-static inline const char *pool_name(struct rxe_pool *pool)
-{
-	return rxe_type_info[pool->type].name;
-}
-
 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
 {
 	int err = 0;
@@ -127,35 +121,36 @@ int rxe_pool_init(
 	enum rxe_elem_type	type,
 	unsigned int		max_elem)
 {
+	const struct rxe_type_info *info = &rxe_type_info[type];
 	int			err = 0;
-	size_t			size = rxe_type_info[type].size;
 
 	memset(pool, 0, sizeof(*pool));
 
 	pool->rxe		= rxe;
+	pool->name		= info->name;
 	pool->type		= type;
 	pool->max_elem		= max_elem;
-	pool->elem_size		= ALIGN(size, RXE_POOL_ALIGN);
-	pool->flags		= rxe_type_info[type].flags;
+	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
+	pool->elem_offset	= info->elem_offset;
+	pool->flags		= info->flags;
 	pool->index.tree	= RB_ROOT;
 	pool->key.tree		= RB_ROOT;
-	pool->cleanup		= rxe_type_info[type].cleanup;
+	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
 
 	rwlock_init(&pool->pool_lock);
 
-	if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
-		err = rxe_pool_init_index(pool,
-					  rxe_type_info[type].max_index,
-					  rxe_type_info[type].min_index);
+	if (info->flags & RXE_POOL_INDEX) {
+		err = rxe_pool_init_index(pool, info->max_index,
+					  info->min_index);
 		if (err)
 			goto out;
 	}
 
-	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key.key_offset = rxe_type_info[type].key_offset;
-		pool->key.key_size = rxe_type_info[type].key_size;
+	if (info->flags & RXE_POOL_KEY) {
+		pool->key.key_offset = info->key_offset;
+		pool->key.key_size = info->key_size;
 	}
 
 out:
@@ -166,7 +161,7 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
-			pool_name(pool));
+			pool->name);
 
 	kfree(pool->index.table);
 }
@@ -329,18 +324,17 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, GFP_ATOMIC);
+	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
@@ -354,7 +348,6 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	unsigned long flags;
 	u8 *obj;
@@ -364,14 +357,14 @@ void *rxe_alloc(struct rxe_pool *pool)
 		goto out_cnt;
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
-	obj = kzalloc(info->size, GFP_KERNEL);
+	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj) {
 		atomic_dec(&pool->num_elem);
 		return NULL;
 	}
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
@@ -409,14 +402,13 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_entry *elem =
 		container_of(kref, struct rxe_pool_entry, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	u8 *obj;
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 		kfree(obj);
 	}
 
@@ -425,7 +417,6 @@ void rxe_elem_release(struct kref *kref)
 
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -445,7 +436,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
@@ -467,7 +458,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -491,7 +481,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 1feca1bffced..fb10e0098415 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -44,8 +44,6 @@ struct rxe_type_info {
 	size_t			key_size;
 };
 
-extern struct rxe_type_info rxe_type_info[];
-
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
 	struct kref		ref_cnt;
@@ -61,14 +59,16 @@ struct rxe_pool_entry {
 
 struct rxe_pool {
 	struct rxe_dev		*rxe;
+	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	size_t			elem_size;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
+	size_t			elem_size;
+	size_t			elem_offset;
 
 	/* only used if indexed */
 	struct {
-- 
2.30.2

