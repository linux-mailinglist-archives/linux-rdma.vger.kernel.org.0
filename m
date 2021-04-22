Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3B6367941
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhDVF3Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhDVF3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:24 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0DC06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v19-20020a0568300913b029028423b78c2dso32453900ott.8
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDdfcAsojNa5e4Rr2aiXxY5LTEiEkuR/p+JzBO79sU4=;
        b=UGHFACBURj75mISjzBpqteHorU+W1Vklj0CRvj4lsVPObMx7GiBLWaQupNd/IhuVf0
         KN8KWMB/P1xMFTkqlWb2O/2AkpFOnXPyAGQ2KdkuaOoXMKkY0YILYEWUz/Iw8ei4gMOb
         +3ZsPHYmgOkZLFv9TVRDKj9ycsIJufUVQ3/yE53iC1xzuDeAXlFbbxpF5MRa27W+V90X
         a7GE992nHzGmTz1RdRbq+AH0cfL7ISyC2v7Qz9o+0HdY0JMtIDwYVFZb7OPlT3OVrfS0
         B787xgYU7IHG0oqwYZvjZlhPN1ahPHvdh4QVCt60W8wCqe8Paoqqy737kcUVCt52oc0n
         B6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDdfcAsojNa5e4Rr2aiXxY5LTEiEkuR/p+JzBO79sU4=;
        b=ZHBFS9KC+GcIS1VJ5bMZyAEnYByHU4+cjtAt0aAkWv9fvQL1IGQbHSudydhzHnptqF
         N0XTEtQxTghzOgTTeMxG0jKAABgAH7B4ka3UjqIElaJeq12d1qQOMyKwBa+Xq6cxdNJz
         lxoSB++GU/3qm6iEGLGfbUiD8AzpRPFGZjVsdiM0/f35KXuZl9E8M/36Wfb08SD9ew3R
         mIHHrn23WNwkundW/UuUptLDsv8rNM8vYGxgIuqZg6DM6CrIJC+y3oUlpw6mn/CX0Qyb
         L9oYXQJS8mPJUhlu+x2TBsl/S26Fgi+RpUCPT81SrN50ZjznuTnUawrXAHMrx0aOKPtT
         NiGA==
X-Gm-Message-State: AOAM531XfHKzQiirxb5awDe0cOYLIfSoPH6pNzE5ldcV5YWPzQ8MG8nb
        HwWdXk63wP/FF1H26NPeZjizOAQhl2Q=
X-Google-Smtp-Source: ABdhPJysodWvhhMpeI2+hwlUHukA0fVDHpPZKwG6jSVymzZg9PhUs1z9q0NNDN5Q71C7h+bxHnICOw==
X-Received: by 2002:a05:6830:57b:: with SMTP id f27mr1369631otc.234.1619069330145;
        Wed, 21 Apr 2021 22:28:50 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id u1sm431124otj.43.2021.04.21.22.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 02/10] RDMA/rxe: Return errors for add index and key
Date:   Thu, 22 Apr 2021 00:28:15 -0500
Message-Id: <20210422052822.36527-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422052822.36527-1-rpearson@hpe.com>
References: <20210422052822.36527-1-rpearson@hpe.com>
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

