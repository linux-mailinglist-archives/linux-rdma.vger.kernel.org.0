Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C32443C4F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKCFGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhKCFGN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:13 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E5C061203
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u2so2059023oiu.12
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/R+ykeP3mVH0FOzU98L3F4luQRt/iIIx3Fh9iqzT/g0=;
        b=ov623yKQ4JPVcDV3TyiE/RyhC7W1PkvPsqMTlZcNFeOnmBzO9SbcvdpvDByvnOh7OM
         jiSM+1IPzTFq9eVJizN7IfmOXdhuH2TWmaKlxEt3PiEIcTjS2vF72k24sgBTVB386i3q
         kks4XlT0v8DmF41mZhGhH2F+USJnYIL4CeKvidjsH1qKK4fgQ2Q9yRM8mWociUIbSOi5
         VYdZCsaw6ZM8pw6dZAoRSAJU9mL/MJfnPVRz/AErk/xkrHSteIJ6NfuqyB9n2FsDsmWF
         ukMte+8/F48t+aLKqPiWHMxNgLUrAZTlUWoTxw4/b9wQqTzWGIEzu+WS79L0jhSAem+H
         ZKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/R+ykeP3mVH0FOzU98L3F4luQRt/iIIx3Fh9iqzT/g0=;
        b=ODl0AmGgNRJ4f1s1D+wpCsdF7YrTZkLW88BJQkHJ271MGFb7dZIgTdvw5oO/0/wqdL
         5gElVLzCdmPHrj0SruMRUQJ2IlEWT2Go0q2/W8aFGtHtS3+prLwGwgwmq0KIxEyFjMzr
         ViG68MiDFHi+WoQIL/TSydSyth5z75nCYb9r/kSDCh8nm2/5xkGwwDzaZjzQIkFkIxe2
         tfBFlb2kFJXdsG5dN97YYubA9q6n6yeWuT+jj8Uc6eVSpDtY/qf4TmvcM7IxdFK+58Zp
         ZbW5zQFz+Y5TDg3fO4pwMCBruu1zaqNVpvYvgqQXTdXTJH+QYkaNESb7DTmwHqfSDsjA
         Vjuw==
X-Gm-Message-State: AOAM531t+csrmZ9BlCWf7g6pogJ9b8fdSWeVKhjdNYfX126tpz2xZi2Y
        V5I/A7SVs/SoYNb0g5rRxX0=
X-Google-Smtp-Source: ABdhPJxCfMrL80I7G9NUJZplNXZOeasPJcOd9FI5l2CYx8eZOL1GYwmWhJK6w4ae9RcFWMz9qPaUAQ==
X-Received: by 2002:a05:6808:8d3:: with SMTP id k19mr8482420oij.163.1635915817336;
        Tue, 02 Nov 2021 22:03:37 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 03/13] RDMA/rxe: Copy setup parameters into rxe_pool
Date:   Wed,  3 Nov 2021 00:02:32 -0500
Message-Id: <20211103050241.61293-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c copy remaining pool setup parameters from rxe_pool_info into
rxe_pool. This saves looking up rxe_pool_info in the performance path.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 56 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  4 +-
 2 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 4b4bf0e03ddd..50a92ec1a0bc 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -96,11 +96,6 @@ static const struct rxe_type_info {
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
@@ -130,35 +125,36 @@ int rxe_pool_init(
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
-	pool->index.tree	= RB_ROOT;
-	pool->key.tree		= RB_ROOT;
-	pool->cleanup		= rxe_type_info[type].cleanup;
+	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
+	pool->elem_offset	= info->elem_offset;
+	pool->flags		= info->flags;
+	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
 
 	rwlock_init(&pool->pool_lock);
 
-	if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
-		err = rxe_pool_init_index(pool,
-					  rxe_type_info[type].max_index,
-					  rxe_type_info[type].min_index);
+	if (pool->flags & RXE_POOL_INDEX) {
+		pool->index.tree = RB_ROOT;
+		err = rxe_pool_init_index(pool, info->max_index,
+					  info->min_index);
 		if (err)
 			goto out;
 	}
 
-	if (rxe_type_info[type].flags & RXE_POOL_KEY) {
-		pool->key.key_offset = rxe_type_info[type].key_offset;
-		pool->key.key_size = rxe_type_info[type].key_size;
+	if (pool->flags & RXE_POOL_KEY) {
+		pool->key.tree = RB_ROOT;
+		pool->key.key_offset = info->key_offset;
+		pool->key.key_size = info->key_size;
 	}
 
 out:
@@ -169,9 +165,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
-			pool_name(pool));
+			pool->name);
 
-	bitmap_free(pool->index.table);
+	if (pool->flags & RXE_POOL_INDEX)
+		bitmap_free(pool->index.table);
 }
 
 static u32 alloc_index(struct rxe_pool *pool)
@@ -328,18 +325,17 @@ void __rxe_drop_index(struct rxe_pool_elem *elem)
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
-	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_elem *elem;
 	u8 *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, GFP_ATOMIC);
+	obj = kzalloc(pool->elem_size, GFP_ATOMIC);
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_elem *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_elem *)(obj + pool->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
@@ -353,18 +349,17 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_elem *elem;
 	u8 *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, GFP_KERNEL);
+	obj = kzalloc(pool->elem_size, GFP_KERNEL);
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_elem *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_elem *)(obj + pool->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
@@ -396,14 +391,13 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_elem *elem =
 		container_of(kref, struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	u8 *obj;
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 		kfree(obj);
 	}
 
@@ -412,7 +406,6 @@ void rxe_elem_release(struct kref *kref)
 
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
-	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
 	u8 *obj;
@@ -432,7 +425,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
@@ -453,7 +446,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
-	const struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
 	u8 *obj;
@@ -477,7 +469,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index e6508f30bbf8..591e1c0ad438 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -45,14 +45,16 @@ struct rxe_pool_elem {
 
 struct rxe_pool {
 	struct rxe_dev		*rxe;
+	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
-	size_t			elem_size;
 	void			(*cleanup)(struct rxe_pool_elem *obj);
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

