Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8584E30306F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 00:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbhAYVTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732575AbhAYVSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:18:23 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B0C06178B
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:48 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id n7so4408246oic.11
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsTol3rhzUxL2jFVkJX/iOKqAbW+O0NXRl4F0Z6OsCw=;
        b=rQ4NEQuk+PgwD8WI/Vy/TP2ucL9CR4Z2T3ohkZ30Pz2zw1H16h99uhtN105emhE3al
         xhuEjabdIPvS8UR4D1+hSbJzwzYrrdfQZmMBwZV3VHm+ZzPMPfbOTdq8OfrsDyuYLZ+J
         0BLKnRoWRnD9GYaleLzl59bO2lxR5vfW+GRP0M61OTSrd9n0SSQMs7PGrjP6n2nLPxKs
         R/V/5DP/LdfDuASZs0ZHSfax3tGcqCz9UVq9KVDc6fPTnOTjKbh0NZAbW5O1K7JKxYJE
         LqoBunVEPBFdIaW+WZSZc0j6h97LU6W3OsNdspXIy0yTUFuou1z4XY9Sm9QVRVFyaNNO
         xf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsTol3rhzUxL2jFVkJX/iOKqAbW+O0NXRl4F0Z6OsCw=;
        b=MUYfW+x2dqSWeG/jK4LvTD/OZIYwx4CQ+iQ9bPNtKv/cLWfji4jY1znkS53p6JmIBM
         q5IkT0YkNDZrBpEnGs8eCYtx6YGZ8lTQorpd9p/YrY+uKZQ4ARhloJEKT2fbVQ0BndLc
         LSWApuYPOpophe/zKDUaqpMkPYGQbyQhsv9LdmP8spvWeEHZKkBturYO3gru9jjG+OIJ
         zHisi9TGDhBYMmY618VUMYnAyeYNvoOR20VwfO4gWcwFDbAOKquVQ5AAO88438dVQIgx
         VHInDVIGBXmjYyj+p/wlugtXipmKU1QzieCTClXxj3aA7bFP+HoG63D3jgk65ft0JQ+k
         ro5g==
X-Gm-Message-State: AOAM530MOnf4dqHQfOMlIQEkFZjjI/A4hQ+1K2JphvdtBY3XZccfaMFa
        7DDm3yebXAj4jBqwMM67ycU=
X-Google-Smtp-Source: ABdhPJxliPQZKlf+Ud3tXg/1cSBA/NET5jw7rBWQr1RCRbndvYudbzol+0TBiPTcRPhEn2DqepaPTg==
X-Received: by 2002:aca:a844:: with SMTP id r65mr1282430oie.35.1611609408275;
        Mon, 25 Jan 2021 13:16:48 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>, zyjzyj2000@gmail.c
Subject: [PATCH for-next v3 5/6] RDMA/rxe: Remove unneeded pool->state
Date:   Mon, 25 Jan 2021 15:16:40 -0600
Message-Id: <20210125211641.2694-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125211641.2694-1-rpearson@hpe.com>
References: <20210125211641.2694-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v3]
Fixed spelling error.

rxe_pool.c uses the field pool->state to mark a pool as invalid
when it is shut down and checks it in several pool APIs to verify
that the pool has not been shut down. This is unneeded because the
pools are not marked invalid unless the entire driver is being
removed at which point no functional APIs should or could be
executing. This patch removes this field and associated code.

Suggested-by: zyjzyj2000@gmail.c
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 38 +---------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  6 -----
 2 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 5f85a90e5a5a..5aa835028460 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -157,24 +157,16 @@ int rxe_pool_init(
 		pool->key.key_size = rxe_type_info[type].key_size;
 	}
 
-	pool->state = RXE_POOL_STATE_VALID;
-
 out:
 	return err;
 }
 
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
-	unsigned long flags;
-
-	write_lock_irqsave(&pool->pool_lock, flags);
-	pool->state = RXE_POOL_STATE_INVALID;
 	if (atomic_read(&pool->num_elem) > 0)
 		pr_warn("%s pool destroyed with unfree'd elem\n",
 			pool_name(pool));
-	write_unlock_irqrestore(&pool->pool_lock, flags);
 
-	pool->state = RXE_POOL_STATE_INVALID;
 	kfree(pool->index.table);
 }
 
@@ -328,9 +320,6 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		return NULL;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -352,19 +341,10 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	unsigned long flags;
 	struct rxe_type_info *info = &rxe_type_info[pool->type];
 	struct rxe_pool_entry *elem;
 	u8 *obj;
 
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return NULL;
-	}
-
-	read_unlock_irqrestore(&pool->pool_lock, flags);
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -386,15 +366,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 {
-	unsigned long flags;
-
-	read_lock_irqsave(&pool->pool_lock, flags);
-	if (pool->state != RXE_POOL_STATE_VALID) {
-		read_unlock_irqrestore(&pool->pool_lock, flags);
-		return -EINVAL;
-	}
-	read_unlock_irqrestore(&pool->pool_lock, flags);
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -437,9 +408,6 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 
 	read_lock_irqsave(&pool->pool_lock, flags);
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
-
 	node = pool->index.tree.rb_node;
 
 	while (node) {
@@ -460,8 +428,8 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 		obj = NULL;
 	}
 
-out:
 	read_unlock_irqrestore(&pool->pool_lock, flags);
+
 	return obj;
 }
 
@@ -473,9 +441,6 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 	u8 *obj = NULL;
 	int cmp;
 
-	if (pool->state != RXE_POOL_STATE_VALID)
-		goto out;
-
 	node = pool->key.tree.rb_node;
 
 	while (node) {
@@ -499,7 +464,6 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 		obj = NULL;
 	}
 
-out:
 	return obj;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 8f8de746ca17..61210b300a78 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -46,11 +46,6 @@ struct rxe_type_info {
 
 extern struct rxe_type_info rxe_type_info[];
 
-enum rxe_pool_state {
-	RXE_POOL_STATE_INVALID,
-	RXE_POOL_STATE_VALID,
-};
-
 struct rxe_pool_entry {
 	struct rxe_pool		*pool;
 	struct kref		ref_cnt;
@@ -69,7 +64,6 @@ struct rxe_pool {
 	rwlock_t		pool_lock; /* protects pool add/del/search */
 	size_t			elem_size;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
-	enum rxe_pool_state	state;
 	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
-- 
2.27.0

