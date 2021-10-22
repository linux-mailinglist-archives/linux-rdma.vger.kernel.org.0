Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C61437E81
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhJVTVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhJVTVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:52 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D8C061766
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u69so6301471oie.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2S1efil6ZsqFNqoJw8GG9YOttb//lRdzihRS6xToN5k=;
        b=YYKgjGuPQsLW1TCPwys6dasH1RP6wn9LTx4sXFkJ0HOJHl+7rQI/GPE0/f2LKDDnrD
         d3MkJQw6ur1++KmsHtwb/DJNUOsBhgur+sBVrS9VoTsBKQqibw0fNoO0axVZE6RkRzU7
         jvNb0dbhYSoDPgnEPXk9X+lyPYYAkMAWS6VZ4JHU9QIQvMp6rx8TvvniR7dn8Jjy/uGA
         8KYDiJPBw3EfLV/tPBAvZpFopNr//+hbnTYEoDJ92nvzxNt/eMutjyXsscTDhJSKoauF
         EpWUS/x9h0+JBupX3kYMCA7XUmB3EuLsyy0Em+hgLInw8GjRVsNhPLxSyUX698mgJbsE
         abrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2S1efil6ZsqFNqoJw8GG9YOttb//lRdzihRS6xToN5k=;
        b=I3bNJ28qpz5yyWqqARiBaAyPZbFX8Li7d5595SfTjUZm9hCPra3DFZN8r0gcOIk+1T
         nm/N38vesC2mUQ9XYL4lQuFVgk1iX35iJtEZAcwzw0lBbvhGu/2s3YosE7tPv0jHoK1d
         KSYmENJvU4va5+fRR7s27Nglh7yUetsGI+hF6ilJE/C+bJnqDRDE3obYTGXTvFIAbDgg
         Evlsjz5OkvCJO8XKUcxowh7HY/FFvmDO2nflGn70AoWB1VH94zJVri/65IYDjyhOne/6
         dvUa5vaqe0u9DJwfOwsq8hOozQyE48YROs0Mxd2/6AXigK8dePKtYJlG+fFuHqJmch5Q
         4VBw==
X-Gm-Message-State: AOAM530PUjRHALy96O60fieSOvIMdy+gb+DUQhyANx57viGq8q70+UI7
        13dl1aJ9Uy5hOFOX4cWpOPk=
X-Google-Smtp-Source: ABdhPJzMjWFE9onplRcQtoBL4ueg5DLB/7dFRj+VdJqCe4SByQ/4OJvH/IyTxmtX57qna9Hq9ZNaDw==
X-Received: by 2002:a05:6808:13d4:: with SMTP id d20mr8893661oiw.154.1634930373632;
        Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 05/10] RDMA/rxe: Combine rxe_add_key with rxe_alloc
Date:   Fri, 22 Oct 2021 14:18:20 -0500
Message-Id: <20211022191824.18307-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022191824.18307-1-rpearsonhpe@gmail.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently adding and dropping a key from a rxe object requires separate
API calls from allocating and freeing the object but these are always
performed together. This patch combines these into single APIs.
This requires adding new rxe_allocate_with_key(_locked) APIs.

By combining allocating an object and adding key metadata inside a
single locked sequence and dropping the key metadata and releasing the
object the possibility of a race condition where the object state and
key metadata state are inconsistent is removed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c |  5 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 81 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 24 ++------
 3 files changed, 45 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 1c1d1b53312d..337dc2c68051 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -15,18 +15,16 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	int err;
 	struct rxe_mc_grp *grp;
 
-	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
+	grp = rxe_alloc_with_key_locked(&rxe->mc_grp_pool, mgid);
 	if (!grp)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
-	rxe_add_key_locked(grp, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_key_locked(grp);
 		rxe_drop_ref(grp);
 		return ERR_PTR(err);
 	}
@@ -174,6 +172,5 @@ void rxe_mc_cleanup(struct rxe_pool_entry *arg)
 	struct rxe_mc_grp *grp = container_of(arg, typeof(*grp), pelem);
 	struct rxe_dev *rxe = grp->rxe;
 
-	rxe_drop_key(grp);
 	rxe_mcast_delete(rxe, &grp->mgid);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index bfed7bb48cd1..7fd5543ef1ae 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -245,47 +245,6 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return 0;
 }
 
-int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	int err;
-
-	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
-	err = rxe_insert_key(pool, elem);
-
-	return err;
-}
-
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-	int err;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	err = __rxe_add_key_locked(elem, key);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-
-	return err;
-}
-
-void __rxe_drop_key_locked(struct rxe_pool_entry *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-
-	rb_erase(&elem->key_node, &pool->key.tree);
-}
-
-void __rxe_drop_key(struct rxe_pool_entry *elem)
-{
-	struct rxe_pool *pool = elem->pool;
-	unsigned long flags;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_key_locked(elem);
-	write_unlock_irqrestore(&pool->pool_lock, flags);
-}
-
 static int rxe_add_index(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
@@ -342,6 +301,31 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	return NULL;
 }
 
+void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key)
+{
+	struct rxe_pool_entry *elem;
+	u8 *obj;
+	int err;
+
+	obj = rxe_alloc_locked(pool);
+	if (!obj)
+		return NULL;
+
+	elem = (struct rxe_pool_entry *)(obj + pool->elem_offset);
+	memcpy((u8 *)elem + pool->key.key_offset, key, pool->key.key_size);
+	err = rxe_insert_key(pool, elem);
+	if (err) {
+		kfree(obj);
+		goto out_cnt;
+	}
+
+	return obj;
+
+out_cnt:
+	atomic_dec(&pool->num_elem);
+	return NULL;
+}
+
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_entry *elem;
@@ -383,6 +367,18 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
+void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
+{
+	unsigned long flags;
+	void *obj;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_alloc_with_key_locked(pool, key);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return obj;
+}
+
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
 	unsigned long flags;
@@ -424,6 +420,9 @@ void rxe_elem_release(struct kref *kref)
 	if (pool->flags & RXE_POOL_INDEX)
 		rxe_drop_index(elem);
 
+	if (pool->flags & RXE_POOL_KEY)
+		rb_erase(&elem->key_node, &pool->key.tree);
+
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
 		obj = elem->obj;
 		kfree(obj);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index f76addf87b4a..e0242d488cc8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -104,31 +104,15 @@ void *rxe_alloc_locked(struct rxe_pool *pool);
 
 void *rxe_alloc(struct rxe_pool *pool);
 
+void *rxe_alloc_with_key_locked(struct rxe_pool *pool, void *key);
+
+void *rxe_alloc_with_key(struct rxe_pool *pool, void *key);
+
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
-/* assign a key to a keyed object and insert object into
- * pool's rb tree holding and not holding pool_lock
- */
-int __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key);
-
-#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->pelem, key)
-
-int __rxe_add_key(struct rxe_pool_entry *elem, void *key);
-
-#define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
-
-/* remove elem from rb tree holding and not holding the pool_lock */
-void __rxe_drop_key_locked(struct rxe_pool_entry *elem);
-
-#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->pelem)
-
-void __rxe_drop_key(struct rxe_pool_entry *elem);
-
-#define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
-
 /* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
  */
-- 
2.30.2

