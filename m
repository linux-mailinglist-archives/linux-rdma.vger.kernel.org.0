Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DFB36EFA9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbhD2SuA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbhD2St7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 14:49:59 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8AC06138B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:12 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id p6-20020a4adc060000b02901f9a8fc324fso1266856oov.10
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ot6DW/4UHvRQa+b/PnhlC+ylAGNIjr8rvlsEuhnTXg=;
        b=JmwsyanG9sk9c00UrRBv+Wb2W1J3HkaQzagi2nLAx+66Bc/L9tMsyyNRZNGBl+tLeH
         u8diMw/fKoImWBEgsGpYyeagP7vI2c+M+zTV4I+kqHFJxDzy9lMFvAHpk5boB2pEdQs4
         icoP3u6ljGyocTBenStorU4wSJhPIReGAmKExu1bN3e4knQug1g88ZwLGiPd/o4PqZhm
         0HJeSjf9hna7Odkccc7FfyrH78nfufCcRoEY80ntmierjwxFcnDPa3wwFLxgZkI0JRlF
         JRnRrs60ZrrY2I5yF4PYa6OoGpu0c13bdOjEKMYiblIRDNfkMBvGjcNGHW+5/eOdFHQQ
         LDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ot6DW/4UHvRQa+b/PnhlC+ylAGNIjr8rvlsEuhnTXg=;
        b=ofzvtgnxMo7qhjuLhRE/qZ5me0g0U7GaZw3nWeJV52X22pm/LMafBBVeJI9IzqvInm
         4nswgfB9VGYImliHN8E6JJJEATeFNc00O/ZE0k8RCHPjDjIRT+Va3RcuToe7HWokmP3M
         8v7xqaXYJGIr8RRzHXva86roewyXImeMTqevbrBEICCwoOWLfPXLTzIKOfsrboYSQ661
         PjsAs4grQDHnFvbYoGjztjnBHDjgDQMobP5WBx/Yqpuz1LEk9zeiPHpggkNhcGOOdYvZ
         IqsAqcMbRuxeRnBA3zf7oYk8mWDuyyLRJZzmwrHWL560X3H6FYiXT5vZx46S2+8ZcaoK
         lbrQ==
X-Gm-Message-State: AOAM533AHopNWQg5o5UbityfVkWjYRBu2/hACpNdUEdUGDHXr9btbKT1
        DdBTXcZOOjDVTrXH3qjCX0w=
X-Google-Smtp-Source: ABdhPJz9RQbq9ebP/M4ZrcujTSLaz5Icvj/HoqgUIIp2dcz5HeC8UeH6GJCP7Bggs9bKxaJqXXUF7w==
X-Received: by 2002:a4a:4f4d:: with SMTP id c74mr1132278oob.92.1619722151895;
        Thu, 29 Apr 2021 11:49:11 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a63d-9643-fc29-df2a.res6.spectrum.com. [2603:8081:140c:1a00:a63d:9643:fc29:df2a])
        by smtp.gmail.com with ESMTPSA id n37sm155319otn.9.2021.04.29.11.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:49:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 02/10] RDMA/rxe: Return errors for add index and key
Date:   Thu, 29 Apr 2021 13:48:47 -0500
Message-Id: <20210429184855.54939-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
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
v6:
 Added rxe_ to static subroutine names in changed lines.
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
2.27.0

