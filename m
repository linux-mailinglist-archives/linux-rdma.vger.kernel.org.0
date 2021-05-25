Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84829390B9F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhEYVkD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhEYVkD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:03 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD20C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:31 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso7527962oop.9
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaVBFll1fzHgw1AwqfCJ/5vxLd0wSQ5LJxKK9vIPE14=;
        b=tTzenjF0KbavAzLozTgaAks4ZAQECwPidZ84a8TDpEjlIRcpY+j7X6oF/NWZnN63Ca
         W9ZkEJWX9Y5i0ju/i2Sg2JCEnadYGVZ3JbgJbng2H6s77fieh/zIdzdhPfX39gBD44BH
         C4pJ0p+rN6PmnOm4Qi7MegpKn54gvnDHa0i/qKg4QXqKzKyS2TS6zY32xHIUhmO4D98d
         oC5wP72q/h5WhmBvNy8F4kbdu0dJJO1GnJ5MABv/O9tMgoh6cszUObcwtwqrDIAbf2y0
         ISu++jkJKVNVB9eZksySu8pq8uaIPu61MnchNJIw8zByRvKlInLx8rRo9yYkYndQINss
         XiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaVBFll1fzHgw1AwqfCJ/5vxLd0wSQ5LJxKK9vIPE14=;
        b=SCyHxHqUWuFzoMAHa0PwAcJDhLCXah1AptFwg9OegBEHrlSEV9eFrdMISszIyLl+Of
         1nJN4pShBCFGXMTyU64y0l/eGUlhhsZj+vXev0LTqEAlPxGRyeum1died4f0wJJ1e8pB
         OgjSyA2yQEu4BQE88/N68B/nccBtbkkeyX2Go2KfDx3Efk8re+zExFHdYYHpNgwuG5Yk
         hjOjSGXaobk1HeseM8euxad/JJUCZFTvapVs/RATK6oItxZG++2iuKs1DkJsrsWW2rNG
         EiMo98Zoq62Qkox1nuiX1eAYVFz5MdL0XCZHuzawEgJu0d9Sv5Eg8XxMm6Llupvd2IKv
         5daw==
X-Gm-Message-State: AOAM531eHVbw3cG9UMyQLZGL9nfjW4+eSqhsPKKj9YSwArjDGFS+ImBZ
        xcSGWasDrSG7uNL03Ro4v0vqGjcUaziBow==
X-Google-Smtp-Source: ABdhPJzL2UlFNsqT+0PZ9O6+oNig+v2mpITBuEWdZ+ZMhcY2ZKedYI0UYpiS9wVgOYBFw4KaDtHqAQ==
X-Received: by 2002:a4a:c1:: with SMTP id 184mr24000467ooh.25.1621978710845;
        Tue, 25 May 2021 14:38:30 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id r124sm3479828oig.38.2021.05.25.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 02/10] RDMA/rxe: Return errors for add index and key
Date:   Tue, 25 May 2021 16:37:44 -0500
Message-Id: <20210525213751.629017-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify rxe_add_index() and rxe_add_key() to return an error if the index
or key is aleady present in the pool.  Currently they print a warning
and silently fail with bad consequences to the caller.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 44 ++++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.h |  8 ++---
 2 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index d24901f2af3f..df0bec719341 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -183,7 +183,7 @@ static u32 alloc_index(struct rxe_pool *pool)
 	return index + pool->index.min_index;
 }
 
-static void insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
+static int rxe_insert_index(struct rxe_pool *pool, struct rxe_pool_entry *new)
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
+static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
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
+	err = rxe_insert_key(pool, elem);
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
+	err = rxe_insert_index(pool, elem);
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
2.30.2

