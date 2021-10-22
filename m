Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F248E437E7F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhJVTVv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhJVTVu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:50 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FC9C061764
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id g125so6281299oif.9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGV8bQQ2OeynsaVnpL6jsvyDeqqscqJWP4zU/ZdYmB0=;
        b=UsO2TLwMxvZFdopqGcg6YOOHbmdAnOWA3JQ291o5hZxef3hcGL3MupF+NzKSNKSqP6
         +JEHL/BoETn7fer6o1f1g5hWwN5KqpwTKOuqVTA690kLx5PToaOjenuwpZEQlNB2p4Qp
         fO2XhFx9hSwnJLERKTuQfP5DXKoW63aUNGXuNfcLa8UWqBPiQyiBSvc4FLe1uuaxlFp2
         0NCz28HyIg7obKv5RRA/lqQCusr+xSL4ga9NA1fD+YH2+rxjx/nwOmL6GlsMSEtq0sUH
         48g9ZFG66cawWCTu+RaNVZhklFuiz/M+mucQ1RFcqWT+yNrOxkNvll2Nbv34gnhsIZ9t
         dO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGV8bQQ2OeynsaVnpL6jsvyDeqqscqJWP4zU/ZdYmB0=;
        b=hG1XY3PyExQl2rKeUv06G9zUQFsMxNjGHLgZ+ew/qbv6zisQQBb6Qahxct7Uz5ZcsS
         VOfgkKgoR0ib0qNsAYwDJ7RBqUQ/kCsd/75iz5prpy3y4GBtHOCKOGeSR8sT4hphOGi6
         sGKSdEAF6VKXmnFTI++PT19XttUj53vCysLfRvqR5gBthzJ0STLzC6FC4ttduLAXFJ6G
         151CtP7ZtzNj5Owqd3fVL/hSK5QzdzUAkCDU5sCqGRpyYsTPgNXmOtptm8RrZpqk4h4O
         IvHIft7fv/HEOM1bSRBPhuw6qlzhzUpAWbvDn7RH1xhoQuhLr5JLAf9ZY8X4giCWADYT
         iJyw==
X-Gm-Message-State: AOAM532nL6y2X7yZOoTamsYBhovPEvKlo7rlAtIO/TQgZYUEGQnGdhpu
        N6ToPz4dgwGDSmmoalA9nYM=
X-Google-Smtp-Source: ABdhPJwNSAOd3iKJsC1z5WQeO31WMrYzWPtOjah5zdra59I11pz3KgKwy+AAt+2s6piThtR3xEKQ0g==
X-Received: by 2002:a05:6808:1444:: with SMTP id x4mr1150191oiv.157.1634930372491;
        Fri, 22 Oct 2021 12:19:32 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 03/10] RDMA/rxe: Save object pointer in pool element
Date:   Fri, 22 Oct 2021 14:18:18 -0500
Message-Id: <20211022191824.18307-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c currently there are many cases where it is necessary to
compute the offset from a pool element struct to the object containing
it in a type independent way where the offset is different for each type.
By saving a pointer to the object when they are created extra work can be
saved.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 30 ++++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 86251145705f..2655bd372f59 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -220,7 +220,8 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 		elem = rb_entry(parent, struct rxe_pool_entry, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
+			     (u8 *)new + pool->key.key_offset,
+			     pool->key.key_size);
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
@@ -325,7 +326,7 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -334,9 +335,10 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
+	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
 	return obj;
@@ -350,7 +352,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
 	unsigned long flags;
-	u8 *obj;
+	void *obj;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -364,8 +366,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 	}
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 	elem->pool = pool;
+	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
@@ -386,6 +389,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 		goto out_cnt;
 
 	elem->pool = pool;
+	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
@@ -402,13 +406,13 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_entry *elem =
 		container_of(kref, struct rxe_pool_entry, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	u8 *obj;
+	void *obj;
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 		kfree(obj);
 	}
 
@@ -419,7 +423,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 
 	node = pool->index.tree.rb_node;
 
@@ -436,7 +440,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -446,7 +450,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
-	u8 *obj;
+	void *obj;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
@@ -460,7 +464,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -481,7 +485,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -491,7 +495,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
-	u8 *obj;
+	void *obj;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index fb10e0098415..e9bda4b14f86 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,6 +46,7 @@ struct rxe_type_info {
 
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
+	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
 
-- 
2.30.2

