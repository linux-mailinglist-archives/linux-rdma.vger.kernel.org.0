Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175C4428435
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhJKABn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhJKABn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF59C061570
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so19544922otb.1
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzmCMZl8j20s/0qoEhSwnwiK2Rb6NzK2cRE6Bz1Otfg=;
        b=Qq1Oi+3lPECp4uExduzmErI9s/gIpWgBg3/gtw982zWIBipURPg1rhV8bNrHFkDuPT
         QTJlU9ePKcOyAX2s0m5NDLSf9tk2jrq5QUgBxsnX0M+UYylLcFepnYWdHhb1GvDPbZ9O
         gF4523NYn9VqwsZjosuR3SvkuXMWSEvaYa/qSwvdL/Dk82JBBXPzcg/L/T4IT5e4wjmZ
         HPPVK+9Twu9K5TdKiFA4f9sFKe7RuDFraai+ZSCrlqdpoSbdvDDcqGXa8KdgIN3Rn7fW
         q/V8N69ruT/lupGkw0LSuk+62ebzlFIWKi3w38D3KIBF2UHFomJTscwMa0W0Vf2SsbwO
         G9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzmCMZl8j20s/0qoEhSwnwiK2Rb6NzK2cRE6Bz1Otfg=;
        b=tlmlcgovXNnWj7LM2BCwSPuueDzm58p9O6s5pquRlXC68rKPgZrq8KQ7ONoLgKI6n3
         +2OnHW7SRCMQC2pmfKhZDJPUdUvtN2eeSRQNGhJ/wNqS0Lc2Ag14tQOj7bmr7zbNazUt
         d2VIoOpgSJkmmS2h25PHS72tTHMwA6C8NLeoxsvDRK85S+4zi3X2rHNzu6hQbsc3yiv7
         E5Jp964Rbbb6utZ0onjKcQW6t9MJR+qD1Q++rvjrxWv309QplaqaI6ebPVv/uiHuRhIW
         YfTiCnpEMFBtQv3tm4ANMkNFQYlSeKE2wSTqha3IjD28WChQgmloVyjeQ4zlooZMSJvD
         YJuQ==
X-Gm-Message-State: AOAM531endJVa+Gf6N6wJr6HJM3FTBPQmTalxt4n/oTc3wh4QzNG0gnW
        YD2Xj52uPRnkEOUeulBih9wgN/hnJZ4=
X-Google-Smtp-Source: ABdhPJxIf4B/SJIGpimugVM9DSVehNPKXsSLHBJNUPIW79DmktDDCL5sqP2CgNT2L0KP8Bkvt8gAjw==
X-Received: by 2002:a05:6830:1c7c:: with SMTP id s28mr18913645otg.235.1633910383463;
        Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/6] RDMA/rxe: Copy setup parameters into rxe_pool
Date:   Sun, 10 Oct 2021 18:59:27 -0500
Message-Id: <20211010235931.24042-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c  copied remaining pool parameters from rxe_pool_info into
rxe_pool. Saves looking up rxe_pool_info in the performance path.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 47 ++++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  5 +--
 2 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7a288ebacceb..e9d74ad3f0b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -9,7 +9,7 @@
 
 /* info about object pools
  */
-struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
+static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	[RXE_TYPE_UC] = {
 		.name		= "rxe-uc",
 		.size		= sizeof(struct rxe_ucontext),
@@ -86,11 +86,6 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
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
@@ -125,35 +120,37 @@ int rxe_pool_init(
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
+	pool->flags		= info->flags;
 	pool->index.tree	= RB_ROOT;
 	pool->key.tree		= RB_ROOT;
-	pool->cleanup		= rxe_type_info[type].cleanup;
+	pool->cleanup		= info->cleanup;
+	pool->size		= info->size;
+	pool->elem_offset	= info->elem_offset;
 
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
@@ -164,7 +161,7 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
-			pool_name(pool));
+			pool->name);
 
 	kfree(pool->index.table);
 }
@@ -327,18 +324,17 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
-	obj = kzalloc(info->size, GFP_ATOMIC);
+	obj = kzalloc(pool->size, GFP_ATOMIC);
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
 
 	elem->pool = pool;
 	kref_init(&elem->ref_cnt);
@@ -382,14 +378,13 @@ void rxe_elem_release(struct kref *kref)
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
 
@@ -398,7 +393,6 @@ void rxe_elem_release(struct kref *kref)
 
 void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -418,7 +412,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
@@ -440,7 +434,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
 	u8 *obj;
@@ -464,7 +457,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - info->elem_offset;
+		obj = (u8 *)elem - pool->elem_offset;
 	} else {
 		obj = NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 1feca1bffced..cd962dc5de9d 100644
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
@@ -61,6 +59,7 @@ struct rxe_pool_entry {
 
 struct rxe_pool {
 	struct rxe_dev		*rxe;
+	const char		*name;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
 	size_t			elem_size;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
@@ -69,6 +68,8 @@ struct rxe_pool {
 
 	unsigned int		max_elem;
 	atomic_t		num_elem;
+	size_t			size;
+	size_t			elem_offset;
 
 	/* only used if indexed */
 	struct {
-- 
2.30.2

