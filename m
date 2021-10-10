Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BCA428438
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhJKABq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhJKABp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F49EC061745
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:46 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so5511983otl.11
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71PXaA7yP3wDtW5Q8hrVVXYFMdWArlzEGIj033qe1Y4=;
        b=iE8ZasdUFeSgPoZxE8HYW4mCi9NKrOnfHgRHzE17+0DB12owJvxVXziy3/VplsDvee
         pDLzzy0OCwWn/9LhVai/8XzBfS9A//jFxd+SKZdAwRy3PiTtM4bOeNDXZKlJVTcHm57h
         N2ZiyJHMbzxb9/DA+rZsQRK3rb68vjH3c0KFKiOAfn6RgatlZDv2eUVoKEzPmZvqVvlL
         bwLC1km2BO6TfUYTiyQd2p9vf3Rx0dGvvJE4HWgRhiLPtFlZohJE4cEwey8QCtJw+IGC
         tVs0g3oj32ptxFt2jYfBQorwXvt1IYvmqtCSctq9r8kyg8xmT2MsE1XV1wZA/+r30KcB
         OzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71PXaA7yP3wDtW5Q8hrVVXYFMdWArlzEGIj033qe1Y4=;
        b=G6nFRFD83NkZma1z5vSak4wLl9wVFwTzHqfso8RcexYq/hUWbD1186comW7kMY1662
         dLttF4f6/OKD/Zie7y1FUyA8nxoPAj5wts69TMW+gjaoTzJAnN/uE83cBYcFcHrjhOdJ
         EGPiWvHNK5QGFPRSaNYwp6QEdnH+F6Py8nLLDnR2DhVPE1gmFbRdXC10VgjpaLK4jEBC
         ire3iHD3/gs0/qpZ0AHMsneIaur3G/271wp5Cuh/4tBXdrWu9OomL768KRhbO0wTGL4u
         hsTQb3M1diEQiU0UZup3zwoO1yNYfadj4N0yNqtcEz+8nJPH264X1ZTHnjzzIbHoxZuD
         cyBg==
X-Gm-Message-State: AOAM531VjUpnzHKQumZyWL//Lo9kKOlKDlk/g/Igfr9KfdBLHptnSf5v
        YAkXpaDJuzwa15Zd2jsn/kOx+5qGt4o=
X-Google-Smtp-Source: ABdhPJyGdz61qNIj0LgT0qn8cE3xIm+Yekrqx9HYv/++z72t1cpxHkGUmrOWkg/Lun+etajxoRGpGA==
X-Received: by 2002:a05:6830:20da:: with SMTP id z26mr19149131otq.359.1633910385599;
        Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/6] RDMA/rxe: Fix potential race condition in rxe_pool
Date:   Sun, 10 Oct 2021 18:59:31 -0500
Message-Id: <20211010235931.24042-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently there is a possible race condition related to rxe indexed or
keyed objects where one thread is the last one holding a reference to
an object and drops that reference triggering a call to rxe_elem_release()
while at the same time another thread looks up the object from its index
or key by calling rxe_pool_get_index(/_key). This can happen if an
unexpected packet arrives as a result of a retry attempt and looks up
its rkey or a multicast packet arrives just as the verbs consumer drops
the mcast group.

Add locking to prevent looking up an object from its index or key
while another thread is trying to destroy the object.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 53 +++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_pool.h | 15 ++++++--
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 70f407108b92..c6a583894956 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -266,10 +266,10 @@ static void rxe_drop_index(struct rxe_pool_entry *elem)
 	rb_erase(&elem->index_node, &pool->index.tree);
 }
 
-void *rxe_alloc_locked(struct rxe_pool *pool)
+static void *__rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 	int err;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -279,11 +279,10 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
 	elem->obj = obj;
-	kref_init(&elem->ref_cnt);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
@@ -300,17 +299,32 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	return NULL;
 }
 
+void *rxe_alloc_locked(struct rxe_pool *pool)
+{
+	struct rxe_pool_entry *elem;
+	void *obj;
+
+	obj = __rxe_alloc_locked(pool);
+	if (!obj)
+		return NULL;
+
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	kref_init(&elem->ref_cnt);
+
+	return obj;
+}
+
 void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rxe_pool_entry *elem;
-	u8 *obj;
+	void *obj;
 	int err;
 
-	obj = rxe_alloc_locked(pool);
+	obj = __rxe_alloc_locked(pool);
 	if (!obj)
 		return NULL;
 
-	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_entry *)((u8 *)obj + pool->elem_offset);
 	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
 	err = rxe_insert_key(pool, elem);
 	if (err) {
@@ -318,6 +332,8 @@ void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
 		goto out_cnt;
 	}
 
+	kref_init(&elem->ref_cnt);
+
 	return obj;
 
 out_cnt:
@@ -351,14 +367,15 @@ void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
+	unsigned long flags;
 	int err;
 
+	write_lock_irqsave(&pool->pool_lock, flags);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
-	kref_init(&elem->ref_cnt);
 
 	if (pool->flags & RXE_POOL_INDEX) {
 		err = rxe_add_index(elem);
@@ -366,10 +383,14 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 			goto out_cnt;
 	}
 
+	kref_init(&elem->ref_cnt);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return 0;
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 	return -EINVAL;
 }
 
@@ -401,7 +422,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	void *obj;
+	void *obj = NULL;
 
 	node = pool->index.tree.rb_node;
 
@@ -416,12 +437,8 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 			break;
 	}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
+	if (node && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
 
 	return obj;
 }
@@ -442,7 +459,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_entry *elem;
-	void *obj;
+	void *obj = NULL;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -461,12 +478,8 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 			break;
 	}
 
-	if (node) {
-		kref_get(&elem->ref_cnt);
+	if (node && kref_get_unless_zero(&elem->ref_cnt))
 		obj = elem->obj;
-	} else {
-		obj = NULL;
-	}
 
 	return obj;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index ad287c4ddc1a..43dac03ad82e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -132,9 +132,20 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 void rxe_elem_release(struct kref *kref);
 
 /* take a reference on an object */
-#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
+static inline int __rxe_add_ref(struct rxe_pool_entry *elem)
+{
+	int ret = kref_get_unless_zero(&elem->ref_cnt);
+
+	if (unlikely(!ret))
+		pr_warn("Taking a reference on a %s object that is already destroyed\n",
+			elem->pool->name);
+
+	return (ret) ? 0 : -EINVAL;
+}
+
+#define rxe_add_ref(obj) __rxe_add_ref(&(obj)->pelem)
 
 /* drop a reference on an object */
-#define rxe_drop_ref(elem) kref_put(&(elem)->pelem.ref_cnt, rxe_elem_release)
+#define rxe_drop_ref(obj) kref_put(&(obj)->pelem.ref_cnt, rxe_elem_release)
 
 #endif /* RXE_POOL_H */
-- 
2.30.2

