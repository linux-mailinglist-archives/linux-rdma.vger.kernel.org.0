Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A24302D72
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 22:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbhAYVSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbhAYVR4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:17:56 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854DC061786
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:46 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id h6so14956383oie.5
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z019pMrIdk7T2xOU6DabaUb3qTUzcQVh5XZ76sNd5OE=;
        b=gMooDl+gAfH+vFofvoxtgZIGrddAZCnWtkHwbFYDx6x2Ph9CZ4vyqL952l6Wk1sYen
         QjhCmxoToKDPNo8J5MFC4XJGrHXpcapjUFysN7bPPTnx+EAYRnCV/E2+SSz+sR4lQn1h
         1gNF+YdAztezEH79KWWu8DhOPiYaz+L7n40GQ1J0BYO2sUmSpyk/r1NxzS4Vs4xCeQcF
         cCISAMwToS+GEi8W/jPR3mnip4kiAiuk8gOb31laTeZ28sTj9DhL5Sp+CK0On/HkPA5e
         Cd/h5035efaRJXU+pgzaDVts3KxsoI4KRu0F+kxz+9CILlq5fKdtloFtpxfeBg9iodHw
         kG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z019pMrIdk7T2xOU6DabaUb3qTUzcQVh5XZ76sNd5OE=;
        b=skxoSm5RFSgkowOvtiLFN2pqTbzx3+Ua7+SNM2jnnvEg5PMeLHSeOP0hayiNZbf7Im
         XNF1L/Kcp9cOxp18W9GwBWD7hG8SJWdNf4YGZ9N0wyRroM/ttjFK0YscObuABiRGvFB9
         x0lolvUxveFlKzjDGo0BwzfiQUU51tOm/tm1Gql0/wba7cRns7E5RcRFrodQaehrvh2T
         tTTQcI+4CpeaOAhT61mfrqCN3gIZDQ3nGrkG+ZIr1ovo6wjVs5MQ+JwaNa9+e/1R08Vj
         xlq2nYe+FVxFOic6KpDXhxfTCRGAW3nuHmsXnb3aPyD3Lmx/YdJczAAUVyBallZBZoz8
         WchQ==
X-Gm-Message-State: AOAM533exN+LojzNu9gbhIto6CR+tmADCN/LALGTzFGuGzxs2RJj4CVy
        qx6b7pFpUDiStUuq6kiFto4=
X-Google-Smtp-Source: ABdhPJycnUu4Rs5QxAvU6AtljOFZ7sHOcrOzAc0TSUESL+rHSQVtFe1ltNMtJdmyyCNax6lJjlERqg==
X-Received: by 2002:aca:c085:: with SMTP id q127mr1331043oif.70.1611609406121;
        Mon, 25 Jan 2021 13:16:46 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:45 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>, Hillf Danton <hdanton@sina.com>
Subject: [PATCH for-next v3 2/6] RDMA/rxe: Fix misleading comments and names
Date:   Mon, 25 Jan 2021 15:16:37 -0600
Message-Id: <20210125211641.2694-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125211641.2694-1-rpearson@hpe.com>
References: <20210125211641.2694-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v3]
Was rxe_xxx__() changed to rxe_xxx_locked()
Suggested-by: jgg@nvidia.com

The names and comments of the 'unlocked' pool APIs are very
misleading and not what was intended. This patch replaces
'rxe_xxx_nl' with 'rxe_xxx_locked' with comments indicating that the
caller is expected to hold the rxe pool lock.

Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c |  8 ++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 22 +++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 55 +++++++++++++--------------
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 5be47ce7d319..0ea9a5aa4ec0 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -15,18 +15,18 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	int err;
 	struct rxe_mc_grp *grp;
 
-	grp = rxe_alloc_nl(&rxe->mc_grp_pool);
+	grp = rxe_alloc_locked(&rxe->mc_grp_pool);
 	if (!grp)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
-	rxe_add_key_nl(grp, mgid);
+	rxe_add_key_locked(grp, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_key_nl(grp);
+		rxe_drop_key_locked(grp);
 		rxe_drop_ref(grp);
 		return ERR_PTR(err);
 	}
@@ -47,7 +47,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 
-	grp = rxe_pool_get_key_nl(pool, mgid);
+	grp = rxe_pool_get_key_locked(pool, mgid);
 	if (grp)
 		goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index cfcd55175572..5ca54e09cd0e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -266,7 +266,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-void __rxe_add_key_nl(struct rxe_pool_entry *elem, void *key)
+void __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -280,11 +280,11 @@ void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_add_key_nl(elem, key);
+	__rxe_add_key_locked(elem, key);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_drop_key_nl(struct rxe_pool_entry *elem)
+void __rxe_drop_key_locked(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -297,11 +297,11 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_key_nl(elem);
+	__rxe_drop_key_locked(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_add_index_nl(struct rxe_pool_entry *elem)
+void __rxe_add_index_locked(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -315,11 +315,11 @@ void __rxe_add_index(struct rxe_pool_entry *elem)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_add_index_nl(elem);
+	__rxe_add_index_locked(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_drop_index_nl(struct rxe_pool_entry *elem)
+void __rxe_drop_index_locked(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -333,11 +333,11 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_index_nl(elem);
+	__rxe_drop_index_locked(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void *rxe_alloc_nl(struct rxe_pool *pool)
+void *rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
@@ -507,7 +507,7 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-void *rxe_pool_get_key_nl(struct rxe_pool *pool, void *key)
+void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
@@ -551,7 +551,7 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
-	obj = rxe_pool_get_key_nl(pool, key);
+	obj = rxe_pool_get_key_locked(pool, key);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 373e08554c1c..a75ac2d2847a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -106,11 +106,10 @@ int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
-void *rxe_alloc(struct rxe_pool *pool);
+/* allocate an object from pool holding and not holding the pool lock */
+void *rxe_alloc_locked(struct rxe_pool *pool);
 
-/* allocate an object from pool - no lock */
-void *rxe_alloc_nl(struct rxe_pool *pool);
+void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
@@ -118,60 +117,60 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem);
 #define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->pelem)
 
 /* assign an index to an indexed object and insert object into
- *  pool's rb tree with and without holding the pool_lock
+ *  pool's rb tree holding and not holding the pool_lock
  */
-void __rxe_add_index(struct rxe_pool_entry *elem);
+void __rxe_add_index_locked(struct rxe_pool_entry *elem);
 
-#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
+#define rxe_add_index_locked(obj) __rxe_add_index_locked(&(obj)->pelem)
 
-void __rxe_add_index_nl(struct rxe_pool_entry *elem);
+void __rxe_add_index(struct rxe_pool_entry *elem);
 
-#define rxe_add_index_nl(obj) __rxe_add_index_nl(&(obj)->pelem)
+#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
 /* drop an index and remove object from rb tree
- * with and without holding the pool_lock
+ * holding and not holding the pool_lock
  */
-void __rxe_drop_index(struct rxe_pool_entry *elem);
+void __rxe_drop_index_locked(struct rxe_pool_entry *elem);
 
-#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
+#define rxe_drop_index_locked(obj) __rxe_drop_index_locked(&(obj)->pelem)
 
-void __rxe_drop_index_nl(struct rxe_pool_entry *elem);
+void __rxe_drop_index(struct rxe_pool_entry *elem);
 
-#define rxe_drop_index_nl(obj) __rxe_drop_index_nl(&(obj)->pelem)
+#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
 
 /* assign a key to a keyed object and insert object into
- * pool's rb tree with and without holding pool_lock
+ * pool's rb tree holding and not holding pool_lock
  */
+void __rxe_add_key_locked(struct rxe_pool_entry *elem, void *key);
+
+#define rxe_add_key_locked(obj, key) __rxe_add_key_locked(&(obj)->pelem, key)
+
 void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
-void __rxe_add_key_nl(struct rxe_pool_entry *elem, void *key);
+/* remove elem from rb tree holding and not holding the pool_lock */
+void __rxe_drop_key_locked(struct rxe_pool_entry *elem);
 
-#define rxe_add_key_nl(obj, key) __rxe_add_key_nl(&(obj)->pelem, key)
+#define rxe_drop_key_locked(obj) __rxe_drop_key_locked(&(obj)->pelem)
 
-/* remove elem from rb tree with and without holding pool_lock */
 void __rxe_drop_key(struct rxe_pool_entry *elem);
 
 #define rxe_drop_key(obj) __rxe_drop_key(&(obj)->pelem)
 
-void __rxe_drop_key_nl(struct rxe_pool_entry *elem);
-
-#define rxe_drop_key_nl(obj) __rxe_drop_key_nl(&(obj)->pelem)
-
-/* lookup an indexed object from index with and without holding pool_lock.
+/* lookup an indexed object from index holding and not holding the pool_lock.
  * takes a reference on object
  */
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
+void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index);
 
-void *rxe_pool_get_index_nl(struct rxe_pool *pool, u32 index);
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key with and without holding pool_lock.
+/* lookup keyed object from key holding and not holding the pool_lock.
  * takes a reference on the objecti
  */
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
+void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key);
 
-void *rxe_pool_get_key_nl(struct rxe_pool *pool, void *key);
+void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
-- 
2.27.0

