Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422F358F59
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhDHVlR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbhDHVlQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:16 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23CFC061761
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so3776742ote.6
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDdfcAsojNa5e4Rr2aiXxY5LTEiEkuR/p+JzBO79sU4=;
        b=eesKVAhhEq1blLbcDeRryauRAvg1JRzwLl55L+ff0aygtz3w+o63id9NfJM8o6vKzZ
         Xh0FFhdVzNXzTERCuZKsM21v3LKzzyA1hrxIU07kE67hxwKhA+Hfwe1b76c0tmPLmJZA
         MDWNXC3NoOYq82uWeGb95LTryOi/sgDKKx1PT/SKDicnvhqLEvhTYQB+ZCrHAusbDEVr
         hNeCQG6vlr8wOSbs+uPhTISQBfW2fTggGW28wIqT1VwrcEGrU2Udd9UqTdkKFyK0iyat
         4mBpEBfnmGFT0d3aURdxubUmCEc/OclthydOE44hd3hVmzdyeeg1JtXLe4HysyRYdIaT
         hI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDdfcAsojNa5e4Rr2aiXxY5LTEiEkuR/p+JzBO79sU4=;
        b=Box7+4rJEUK4NRetpeKPnvoUvMhoOLD1qf7raBbTGG7s91GwYliZfriv+sxGxM+iNx
         YlsqamJf+9NHegrQGNOMVgGiSQhI2VXNQAJXmx4pJbiLPRYq9iKRhR6Qm0HEfU+NFgXh
         agX6aJONbSshoTqmCyC0uazhFtYKjwBGOk2XUjblJUlHevyBb/sxZNMsPD6AGmHDRVmb
         tj/mZ+Rihz/JJj5WEtQaqIxe49i1DTIRPEbq3SKHrRPWKriaUUdsOsm05mnzoANXSIds
         7XSXgAvXRZCRsZ3Tfmtr1GoTBaimtRlwQXPz8VX0ToGU+xP0R48mzkCzPXEF2/eL/t+K
         bHVg==
X-Gm-Message-State: AOAM531cycKFIarimwibc8G0GJkEGyJDpnLj70LX0nFn3atcrgsPCq+v
        +SR3UZDZERkGoGNvIfEqzWU=
X-Google-Smtp-Source: ABdhPJw+kCZ/Te3lcPNybfVJfc4U6SvOwk9Aqeo5mkqjrC6/X/7C+6iXagLux/M+whclff9ICx7CLw==
X-Received: by 2002:a9d:20c6:: with SMTP id x64mr9531961ota.262.1617918064178;
        Thu, 08 Apr 2021 14:41:04 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id m127sm131114oib.32.2021.04.08.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:03 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 2/9] RDMA/rxe: Return errors for add index and key
Date:   Thu,  8 Apr 2021 16:40:34 -0500
Message-Id: <20210408214040.2956-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
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

