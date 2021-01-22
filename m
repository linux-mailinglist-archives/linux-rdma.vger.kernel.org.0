Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719F2300CC9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbhAVTjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbhAVTar (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:30:47 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DEBC06178B
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:07 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id s2so3997027otp.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KcQeKXoCKnWw4LoGTmnpc6rvmrTrMihBUZAP9LEh1Fk=;
        b=K5afm634qhOx596XDyMhXpmrgRiVp5RY8KbjVoDuj++Qz82SyVmP2yqnhorSTKSeRh
         bvFAmI5lYjdyy8x0S7EtkQTVpPyFmCXlMDUTSaiov97+6F1/FeeWN258Z4Uw8KqmFK2V
         K8nzLLlYlK7VJXN+rPZsGWozOxhobqNyT4CseVCOm0E579/n8B031NOZePXztMd81n+l
         hNgkvaKW3ZGd8kxQ4LPWvU67o0eikI1OaFS5L/19px1t8Ud+2UfzVqwFcM4RzgmnVnSG
         zo2+pQGYs5a03txlPzvZEUSnoceVrAlZbqQ5VBseH5IqL+NHLgxKQBRI22AbtqoNEM5z
         gD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KcQeKXoCKnWw4LoGTmnpc6rvmrTrMihBUZAP9LEh1Fk=;
        b=G1lK0z3t5lsFiUiULQQUJT0DwU4WssTrVOmsKj82jgVxdIeAM0YflJwBu1SuzhJhCc
         NnxMMpu76ZZfgF6iln6SHiBzNeGmrHE0JNFGYdkW+Fvg1TCPGdR95wQPUZUTALwtUR1b
         dOepP2PbqHzfDY0y1HgcWOnUYuWpgHPg7BXLbYGUFopxGYFaWfG6id1m/aUfubtikyYt
         ScqQ2V0jzwLimPmjCpQs1HxHDoDTLqTD0aqWrtvRuNTwIpaq1HuJbreWZyL8Ql7kbnpS
         wtDleZvST5r9fdc7BLL1vvUIcOrKMhrhtbN2HB4akifBpU0aRKMqKU8aMUCjD1uaRzoK
         2Gfg==
X-Gm-Message-State: AOAM532kdq3jSUC5Tb1ygvXyiYFNCXKNmdu1858/OVdICBiuAn/2Y+Gd
        9K+T0Sz3mi1ZvgS3uPZCegM=
X-Google-Smtp-Source: ABdhPJwRt/K469CFUgDtaSQe0abuzHHEmh3iZjVF+SqVGUt52yA9usVg+9TP5Qkg43j3Ap4+GHVrWg==
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr4553738otk.89.1611343804084;
        Fri, 22 Jan 2021 11:30:04 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:03 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>, Hillf Danton <hdanton@sina.com>
Subject: [PATCH for-next v2 2/6] RDMA/rxe: Fix misleading comments and names
Date:   Fri, 22 Jan 2021 13:29:39 -0600
Message-Id: <20210122192943.5538-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122192943.5538-1-rpearson@hpe.com>
References: <20210122192943.5538-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The names and comments of the 'unlocked' pool APIs are very
misleading and not what was intended. This patch replaces
'rxe_xxx_nl' with 'rxe_xxx__' with comments indicating that the
caller is expected to hold the rxe pool lock.

Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c |  8 ++--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 22 +++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 55 +++++++++++++--------------
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 5be47ce7d319..b9f06f87866e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -15,18 +15,18 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 	int err;
 	struct rxe_mc_grp *grp;
 
-	grp = rxe_alloc_nl(&rxe->mc_grp_pool);
+	grp = rxe_alloc__(&rxe->mc_grp_pool);
 	if (!grp)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
-	rxe_add_key_nl(grp, mgid);
+	rxe_add_key__(grp, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
 	if (unlikely(err)) {
-		rxe_drop_key_nl(grp);
+		rxe_drop_key__(grp);
 		rxe_drop_ref(grp);
 		return ERR_PTR(err);
 	}
@@ -47,7 +47,7 @@ int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 
 	write_lock_irqsave(&pool->pool_lock, flags);
 
-	grp = rxe_pool_get_key_nl(pool, mgid);
+	grp = rxe_pool_get_key__(pool, mgid);
 	if (grp)
 		goto done;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index cfcd55175572..80deec1e2924 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -266,7 +266,7 @@ static void insert_key(struct rxe_pool *pool, struct rxe_pool_entry *new)
 	return;
 }
 
-void __rxe_add_key_nl(struct rxe_pool_entry *elem, void *key)
+void __rxe_add_key__(struct rxe_pool_entry *elem, void *key)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -280,11 +280,11 @@ void __rxe_add_key(struct rxe_pool_entry *elem, void *key)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_add_key_nl(elem, key);
+	__rxe_add_key__(elem, key);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_drop_key_nl(struct rxe_pool_entry *elem)
+void __rxe_drop_key__(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -297,11 +297,11 @@ void __rxe_drop_key(struct rxe_pool_entry *elem)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_key_nl(elem);
+	__rxe_drop_key__(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_add_index_nl(struct rxe_pool_entry *elem)
+void __rxe_add_index__(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -315,11 +315,11 @@ void __rxe_add_index(struct rxe_pool_entry *elem)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_add_index_nl(elem);
+	__rxe_add_index__(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void __rxe_drop_index_nl(struct rxe_pool_entry *elem)
+void __rxe_drop_index__(struct rxe_pool_entry *elem)
 {
 	struct rxe_pool *pool = elem->pool;
 
@@ -333,11 +333,11 @@ void __rxe_drop_index(struct rxe_pool_entry *elem)
 	unsigned long flags;
 
 	write_lock_irqsave(&pool->pool_lock, flags);
-	__rxe_drop_index_nl(elem);
+	__rxe_drop_index__(elem);
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 }
 
-void *rxe_alloc_nl(struct rxe_pool *pool)
+void *rxe_alloc__(struct rxe_pool *pool)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
@@ -507,7 +507,7 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-void *rxe_pool_get_key_nl(struct rxe_pool *pool, void *key)
+void *rxe_pool_get_key__(struct rxe_pool *pool, void *key)
 {
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rb_node *node;
@@ -551,7 +551,7 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 	unsigned long flags;
 
 	read_lock_irqsave(&pool->pool_lock, flags);
-	obj = rxe_pool_get_key_nl(pool, key);
+	obj = rxe_pool_get_key__(pool, key);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 373e08554c1c..b9680f9e907c 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -106,11 +106,10 @@ int rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 /* free resources from object pool */
 void rxe_pool_cleanup(struct rxe_pool *pool);
 
-/* allocate an object from pool */
-void *rxe_alloc(struct rxe_pool *pool);
+/* allocate an object from pool holding and not holding the pool lock */
+void *rxe_alloc__(struct rxe_pool *pool);
 
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
+void __rxe_add_index__(struct rxe_pool_entry *elem);
 
-#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
+#define rxe_add_index__(obj) __rxe_add_index__(&(obj)->pelem)
 
-void __rxe_add_index_nl(struct rxe_pool_entry *elem);
+void __rxe_add_index(struct rxe_pool_entry *elem);
 
-#define rxe_add_index_nl(obj) __rxe_add_index_nl(&(obj)->pelem)
+#define rxe_add_index(obj) __rxe_add_index(&(obj)->pelem)
 
 /* drop an index and remove object from rb tree
- * with and without holding the pool_lock
+ * holding and not holding the pool_lock
  */
-void __rxe_drop_index(struct rxe_pool_entry *elem);
+void __rxe_drop_index__(struct rxe_pool_entry *elem);
 
-#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
+#define rxe_drop_index__(obj) __rxe_drop_index__(&(obj)->pelem)
 
-void __rxe_drop_index_nl(struct rxe_pool_entry *elem);
+void __rxe_drop_index(struct rxe_pool_entry *elem);
 
-#define rxe_drop_index_nl(obj) __rxe_drop_index_nl(&(obj)->pelem)
+#define rxe_drop_index(obj) __rxe_drop_index(&(obj)->pelem)
 
 /* assign a key to a keyed object and insert object into
- * pool's rb tree with and without holding pool_lock
+ * pool's rb tree holding and not holding pool_lock
  */
+void __rxe_add_key__(struct rxe_pool_entry *elem, void *key);
+
+#define rxe_add_key__(obj, key) __rxe_add_key__(&(obj)->pelem, key)
+
 void __rxe_add_key(struct rxe_pool_entry *elem, void *key);
 
 #define rxe_add_key(obj, key) __rxe_add_key(&(obj)->pelem, key)
 
-void __rxe_add_key_nl(struct rxe_pool_entry *elem, void *key);
+/* remove elem from rb tree holding and not holding the pool_lock */
+void __rxe_drop_key__(struct rxe_pool_entry *elem);
 
-#define rxe_add_key_nl(obj, key) __rxe_add_key_nl(&(obj)->pelem, key)
+#define rxe_drop_key__(obj) __rxe_drop_key__(&(obj)->pelem)
 
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
+void *rxe_pool_get_index__(struct rxe_pool *pool, u32 index);
 
-void *rxe_pool_get_index_nl(struct rxe_pool *pool, u32 index);
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
 
-/* lookup keyed object from key with and without holding pool_lock.
+/* lookup keyed object from key holding and not holding the pool_lock.
  * takes a reference on the objecti
  */
-void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
+void *rxe_pool_get_key__(struct rxe_pool *pool, void *key);
 
-void *rxe_pool_get_key_nl(struct rxe_pool *pool, void *key);
+void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
 
 /* cleanup an object when all references are dropped */
 void rxe_elem_release(struct kref *kref);
-- 
2.27.0

