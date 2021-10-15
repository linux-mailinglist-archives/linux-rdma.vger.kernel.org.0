Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3019E42FE3A
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbhJOWgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243358AbhJOWgE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:04 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52CCC061762
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:57 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso26434otl.4
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBcwCYstuuqp0cZ1Z44eMdFaEG91I+fxLxvc5AY+B4Q=;
        b=bqN30SM97yobF4QOk7OYMq2iKiVCycKqI0lkhtOqPya7I5TyeMsH2bsA4Hrv7Ms9PM
         Iu6DHnaMzlP8yNrlvVxibnYuKCkps8T/TepO0yhoIJtLIvKvuaR8GpzF0/wBW9Dy4pdT
         WftNxejjxdxzcPHEDF3Umfi76NmRWABuw8jyedcQ2Zp1LTac7scRGstI+eD65RxrFWQl
         ZY4YbFBaWuAHfK6t0CIHwxyCR8CWz3/7Gm9olfNwHySlLMHq9KvftiXJ08qpCa9oK5hx
         Burq6/GIW4o69Om8xZ8BPlPKlNogQRRxOc2uu8a+1eS9DhR3JwKeqFTQvDtqr2sLkfVW
         J5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBcwCYstuuqp0cZ1Z44eMdFaEG91I+fxLxvc5AY+B4Q=;
        b=2Egir/YawH91dPql2b1txhqp8hcLR8i8ikmll+sPopnXzDqG7oY0IAkb9Lya093TqQ
         K2jZqR9YxyzxRWWG4RO/a///ddXb198a/6+SeknSQWYmEhI9Je+NY/7bDONNycKRc763
         Oim9RY18Siwx0M/P/vp8DkdDSZIZ55Nk2pIm3OAsb9gTveGVCaT7O5yypuOyEEb0Y6bZ
         oNsmXtyzIWVM+6Ugu9GttFAXO7wyVxIFW39fbnBSLc8yXkF8wiw0bgUvXkDr+atVevO4
         xNYqLxJhawerIp/lC/SZxSagr+pt72oLrQuVSXjHsvchZZH3tqFIOMGrHK+CaStq7QxZ
         bbbA==
X-Gm-Message-State: AOAM530909FBdxjp8yo0FOozIu6q0ppdPiSNW2jQgNW4bB2LbpGPTIZ2
        mwnZeyoFGr0zEYEOxPz1TIU=
X-Google-Smtp-Source: ABdhPJxCWXSE1ngv0v2rRVEQNXCasBlIGVYXzAt2QeYm90leIX0WwEK2fyWWXZGIQPsn6RX/4EfvYA==
X-Received: by 2002:a9d:7403:: with SMTP id n3mr763766otk.9.1634337236133;
        Fri, 15 Oct 2021 15:33:56 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 02/10] RDMA/rxe: Copy setup parameters into rxe_pool
Date:   Fri, 15 Oct 2021 17:32:43 -0500
Message-Id: <20211015223250.6501-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c copy remaining pool setup parameters from rxe_pool_info into
rxe_pool. This saves looking up rxe_pool_info in the performance path.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 49 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  6 ++--
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6553ea160d4f..7250c40037b5 100644
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
@@ -384,14 +378,13 @@ void rxe_elem_release(struct kref *kref)
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
 
@@ -400,7 +393,6 @@ void rxe_elem_release(struct kref *kref)
 
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -420,7 +412,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
@@ -442,7 +434,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -466,7 +457,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
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

