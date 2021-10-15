Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C378842FE3C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbhJOWgG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbhJOWgF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09AFC061764
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:58 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso26545otl.4
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12QLK1J0GgEI3o/qAvDD6/aX7RFH2+9IU9HSCaBOOvo=;
        b=lDD7/LovWnK0SqaYsP4RG89Pfyhn23WazvKyfunvFbFc+0w53+qGKb+8ZLqd/W+8y9
         ZmelyqU01mAsQuBGiMYsOmNRoESih1rSLeynF8kcT6mNYBOPCu7EGPRudeeQ8tmNc60h
         abcjd0DlaJUq4IyKmL6WtiNYb/KRAZp+8A72cWxtByJK4FOnSnMEdNJrpRditIqt58YJ
         H/ltksmqdGVEaoFln/DAI7pZXvqCjTho3qkxw8DvpNgKZ05Q0HjTbhFl+zLXVtN/3OqU
         M7r4L6/uyMHQAcgjtmmCjiaqRj3vOyp//HPXlbxy5hW3ITuMU+/t7cAU3hmNhOAwAeHN
         ZW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12QLK1J0GgEI3o/qAvDD6/aX7RFH2+9IU9HSCaBOOvo=;
        b=VR1OEhFCXwZaS8mfCl4T7Yp1wsAeaOZ9aceHmJ0ofbqXocrWQHTNzG+OCezmrvdBpD
         bbnInnIRUM0abxCvGsIayxLJklRu3dirLFEg3Dw0AkQgDsQV7/5nBjJY6cog4FBfg+nD
         DpXEyeaivKyonsaYe+IEosl3uUCHPcH5Rvc+SYe11WrqmXFZWAQVwP2F2VfRaiHpFM/p
         gXq0iHGMTyMqWLUY238luk6SDGsmDRmXvbw1uW6w41hvkCDzsx582PJ5cPN2XeSB0JJ1
         SVFPeRjrc6cG9Yx5vNoXL37KZqB8sAeOB80p9oA/a6KD5oHugo7VgkJoQorOA93hqACT
         YklA==
X-Gm-Message-State: AOAM533YT9ozpA34WqPGmdzhQTYINdI/JxnIqa3+5EOmAlHM30L26Kk3
        d0IXQ6uNCQTbEqJMZmtw1s0=
X-Google-Smtp-Source: ABdhPJw5T9XgzqEiNjsGb1bRv76cHmA9xHYpgCUiIoiIFMB3earZK4wCTiLYzcXw7TxadTazfJ44pA==
X-Received: by 2002:a05:6830:1293:: with SMTP id z19mr6516095otp.353.1634337238207;
        Fri, 15 Oct 2021 15:33:58 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:57 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 05/10] RDMA/rxe: Combine rxe_add_key with rxe_alloc
Date:   Fri, 15 Oct 2021 17:32:46 -0500
Message-Id: <20211015223250.6501-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
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
index b030a774c251..b0963eca75c7 100644
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
 	unsigned long flags;
@@ -354,6 +338,18 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return obj;
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
 	int err;
@@ -391,6 +387,9 @@ void rxe_elem_release(struct kref *kref)
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

