Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607C53664BC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhDUFVY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUFVY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 01:21:24 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04BDC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:51 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso33197238otv.6
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDdfcAsojNa5e4Rr2aiXxY5LTEiEkuR/p+JzBO79sU4=;
        b=kKJHhbZ/fbe1hpPOPkdEk7vE31KhzPFN/dJcLc9u4cqsG9rxanHZUfV0MHoFHZjhwr
         Y22FIqwb8AKuGTXqX7JRu2gryfnq7Z25ocluqDad86oKVLpLc80BntwZClVuuhotg67R
         kxcIGqVehXpYisVk+GBP4lrObLYMMs5JKfM97fTZ6Xn8qZuD2fz269oz+4qZ7bCwuXQM
         zN/xDww+qNmYmsPwAYSWN3UA+vIrq/M7JgBi+d/WulQmFs46yJcS1YG2rcrG85WeOeZp
         Td/qkWh7VxplAGSojlzMFsV0mVV303Fe7Lc2It16D6i4u4EWsTGGCkGXzVAXm3O6RIZG
         k1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDdfcAsojNa5e4Rr2aiXxY5LTEiEkuR/p+JzBO79sU4=;
        b=Yt0ZowAGL3Bu9PpPO/J+3Qyy5TIQ5VRrI7x0Iv36ZCrscPsd7j3OVKhvsKcSrE6/2K
         w7ybK6nRpLXXyjvClGOTgLiLfuObgwsnLesrQtDlVcALzwoa06xtRL4ybDTuQa0MC6nR
         nFJksf5CwmiUrv7XSkaAq35HY7Be2DE+NrawvuN0ZNAhqYEba4gDNpbkj2eVFK9mfnAn
         WBz/NXU6k1IOkrQXU+Ht81Q8uYYyAzLthCjw3c4Qb87VqfxQiWWcboQ9whxfNgj8gtZi
         HwjpU5sRYoIh2ox2UTXrQggLjU1OpCMgvr9Z1XLCifFlCTr3iuW8shBxsGn7AnucpehX
         ZkXw==
X-Gm-Message-State: AOAM5334g6r2DOGmYE+nHYuL9GiwGM51l5yUs0r9q+cvl/GGWJsOr6YA
        jFiuHniyLsRCCo/y2m2Tirs=
X-Google-Smtp-Source: ABdhPJyzABdAD4jygL1bGZMajahfsXYfSGkIt/1RXbB0bSOkPItfxp9iAiYvaTvjdSlPiRjUCCz3Jg==
X-Received: by 2002:a05:6830:104a:: with SMTP id b10mr1921856otp.181.1618982451212;
        Tue, 20 Apr 2021 22:20:51 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-eeb0-9b2d-35df-5cd9.res6.spectrum.com. [2603:8081:140c:1a00:eeb0:9b2d:35df:5cd9])
        by smtp.gmail.com with ESMTPSA id a19sm302041oto.50.2021.04.20.22.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 2/9] RDMA/rxe: Return errors for add index and key
Date:   Wed, 21 Apr 2021 00:20:09 -0500
Message-Id: <20210421052015.4546-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210421052015.4546-1-rpearson@hpe.com>
References: <20210421052015.4546-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify rxe_add_index() and rxe_add_key() to return an
error if the index or key is aleady present in the pool.
Currently they print a warning and silently fail with
bad consequences to the caller.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 44 ++++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.h |  8 ++---
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index d24901f2af3f..2b795e2fc4b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -183,7 +183,7 @@ static u32 alloc_index(struct rxe_pool *pool)
 	return index + pool->index.min_index;
 }
 
-static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->index.tree.rb_node;
 	struct rb_node *parent = NULL;
@@ -195,7 +195,7 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 		if (elem->index == new->index) {
 			pr_warn("element already exists!\n");
-			goto out;
+			return -EINVAL;
 		}
 
 		if (elem->index > new->index)
@@ -206,11 +206,11 @@ static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 	rb_link_node(&new->index_node, parent, link);
 	rb_insert_color(&new->index_node, &pool->index.tree);
-out:
-	return;
+
+	return 0;
 }
 
-static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 {
 	struct rb_node **link = &pool->key.tree.rb_node;
 	struct rb_node *parent = NULL;
@@ -226,7 +226,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
-			goto out;
+			return -EINVAL;
 		}
 
 		if (cmp > 0)
@@ -237,26 +237,32 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 
 	rb_link_node(&new->key_node, parent, link);
 	rb_insert_color(&new->key_node, &pool->key.tree);
-out:
-	return;
+
+	return 0;
 }
 
-void __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
+int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
+	int err;
 
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	insert_key(pool, elem);
+	err = insert_key(pool, elem);
+
+	return err;
 }
 
-void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
+	int err;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_add_key_locked(elem, key);
+	err = __rxe_add_key_locked(elem, key);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return err;
 }
 
 void __rxe_drop_key_locked(struct rxe_pool_entry *elem)
@@ -276,22 +282,28 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_add_index_locked(struct rxe_pool_entry *elem)
+int __rxe_add_index_locked(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
+	int err;
 
 	elem->index = alloc_index(pool);
-	insert_index(pool, elem);
+	err = insert_index(pool, elem);
+
+	return err;
 }
 
-void __rxe_add_index(struct rxe_pool_entry *elem)
+int __rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 	unsigned long flags;
+	int err;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_add_index_locked(elem);
+	err = __rxe_add_index_locked(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return err;
 }
 
 void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 61210b300a78..1feca1bffced 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -111,11 +111,11 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 /* assign an index to an indexed object and insert object into
  *  pool's rb tree holding and not holding the pool_lock
  */
-void __rxe_add_index_locked(struct rxe_pool_entry *elem);
+int __rxe_add_index_locked(struct rxe_pool_entry *elem);
 
 #define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->pelem)
 
-void __rxe_add_index(struct rxe_pool_entry *elem);
+int __rxe_add_index(struct rxe_pool_entry *elem);
 
 #define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
@@ -133,11 +133,11 @@ void __rxe_drop_index(struct rxe_pool_entry *elem);
 /* assign a key to a keyed object and insert object into
  * pool's rb tree holding and not holding pool_lock
  */
-void __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key);
+int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->pelem, key)
 
-void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
+int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
-- 
2.27.0

