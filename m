Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56B842FE39
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbhJOWgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbhJOWgE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C95C061570
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so14811024otk.3
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYccv7B1RGBLN3kZ6DsUk/IlZiQ2zSGNu9sCcppMK0o=;
        b=D/wneBUSueb9GXQqVrgk9rBLLoOIXnwsceaSVzXQLSIvs0kbflqwS2+88hJ4Fu9CTq
         60KPa8W3e2cXk9uxoozmGk6fBc3n4WOrcRLKUxUeQ61x38LwEi3U965QeVkTUoB/hm6G
         XwR1Zrg+FW/SbcZaMpkbUiikG5Dy6BKWxUwyFCjNw9TyvpGJscogAg1vJ2ZDwhHzZxEH
         f5RcawW0g1PY6yxiW1S1FUJyUIQTMaRUW3+hBiLk2RBgjJmT5/V2cdxOB1SbGrXdadFW
         zeuqXhXQVhqRLSRdHhN7BrT0CKdXB6xmpZV8Nz4mWD+dH0MOWrDF0hC1QncNlyqnbHzd
         kaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYccv7B1RGBLN3kZ6DsUk/IlZiQ2zSGNu9sCcppMK0o=;
        b=k1Ks/vPWuOXlpC+AgZA0uqtgZyXImL0CafrXrhhwCZX87rfiHtfcI1RxOZLTFFnksR
         JrvAd6lPnEkO4DlntYI4/CNnqlQ4MAyXJ0ZJztW8FRIyNzHyx2FxEHjMiASM/4V9YOEx
         fGw1ws4NgwEI+D+dcs3MiZmJJgOTatVFU8c1LtFbZ9T859MmaENuZ8Zz+YW+f5rUOl8y
         8xfHayJyYz1LajgjPb5WLbbwlbbpHFroENcfIhtIVP+Rc2cAymVsVgOVa5E0c2rsX4Nc
         QdIMrNdOFrdajYvRWdIHgjwaSdOKSbQecpV2QpX3+PQI/MsHlAuSnVD/9oYuGAwXefMS
         rMqA==
X-Gm-Message-State: AOAM5339yREbotxbkEM8gU0m6keRWCaEob2pc27xSQ37MVUqpryaYIa+
        Cc+bGOcEZ9nzUpdMv6PKAVhZ4OwyGwc=
X-Google-Smtp-Source: ABdhPJxdOPLoqj0EiTsPDAZ8SBVWVeCyALADJcnVF4aMxqYbIE8+DOTkt/HH4ZP9k+0ereAnpCgi9Q==
X-Received: by 2002:a05:6830:30a4:: with SMTP id g4mr10208227ots.312.1634337237074;
        Fri, 15 Oct 2021 15:33:57 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:56 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 03/10] RDMA/rxe: Save object pointer in pool element
Date:   Fri, 15 Oct 2021 17:32:44 -0500
Message-Id: <20211015223250.6501-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c currently there are many cases where it is necessary to
compute the offset from a pool element struct to the object containing
the pool element in a type independent way. By saving a pointer to the
object when they are created extra work can be saved.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 25 ++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7250c40037b5..bbc8dc63f53d 100644
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
@@ -337,6 +338,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
 
 	elem->pool = pool;
+	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
 	return obj;
@@ -349,7 +351,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	unsigned long flags;
-	u8 *obj;
+	void *obj;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 	obj = rxe_alloc_locked(pool);
@@ -364,6 +366,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 		goto out_cnt;
 
 	elem->pool = pool;
+	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
 	return 0;
@@ -378,13 +381,13 @@ void rxe_elem_release(struct kref *kref)
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
 
@@ -395,7 +398,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 
 	node = pool->index.tree.rb_node;
 
@@ -412,7 +415,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -422,7 +425,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
-	u8 *obj;
+	void *obj;
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
@@ -436,7 +439,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -457,7 +460,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -467,7 +470,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
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

