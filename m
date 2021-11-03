Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12DD443C51
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKCFGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKCFGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEAC061714
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o4so2072676oia.10
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yv4xMli1tSTH7NDt84f1gu3k7VAzAMkgzKSqG3KNSG0=;
        b=IxUfG6A8txyqFahRRwEFyZpzylxHhGCuhgsU19zy5erCPgFP67833LWVaDbflkOIoW
         MLTNHAluYITRWkwSKNFvbGiF9JcV6BdGsNPCFaicvW58UHfv/9B3vvQ1uny+a5pHorqq
         M4qV7HfN37Po1m0KOAU1zEjwfMe15PtzIi1n4ErMtJ73y2/6jY7v+yL1Hj9D6f7dIvmP
         Dm0vcA40r4cmTaB+FBMfmeWyh6eiGjoXXiDw1WCrC4uqlpsJwYOAe7s6fbInNjPWKxIO
         lbV+BP8LybGMcjlRyf7bzvHo4fIrrIsYIDiMA9nV706cyWLKeTy6RyutPaxnufPhhLi1
         /qKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yv4xMli1tSTH7NDt84f1gu3k7VAzAMkgzKSqG3KNSG0=;
        b=QmYv56mJelT6N5Tua5w92oDAPh4dN68DHwdF16ZX+lsCxBk+FlM1EhBgHYe8kWmv81
         noT8MWC4rV7fs+vcIIYHbcYN1Fzh0EA/J6vVtOvljVV8Yg8oLvpNpnhZVrGQTT7VPUhu
         S+K2bMeB2eXn0dJOXgREoWavvPnP+csEKQLzk5S/WWR0q7xcyJd8ZiFqn08C0H48gnBS
         nEveVggq9h8PI0X8AV5pOP5KudEzJv5o76h+YYzLN4WzsRDGJbCI2xR4GaR2VB/KhHk7
         tgMHV5u9loUArXh6Gr6KBKYUT6j60VMFH0CynCh9EGEiO0e+rgjugDfutXc3wZkf9MtX
         A+kw==
X-Gm-Message-State: AOAM533HNcEwqAGiioHjfDc5G6JaWtzhN0BVx+xJAQD21E89S5/AtPQL
        EbRwkCoX1thmLst64r+UXsg=
X-Google-Smtp-Source: ABdhPJw2Mces1v8JhcOI9SOzUrUqrxiLgxQagcYbmGEqxtjHLH3vdgc0RS/rFemtfFC+zi9cW9AHcA==
X-Received: by 2002:a05:6808:1802:: with SMTP id bh2mr8470127oib.105.1635915817809;
        Tue, 02 Nov 2021 22:03:37 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 04/13] RDMA/rxe: Save object pointer in pool element
Date:   Wed,  3 Nov 2021 00:02:33 -0500
Message-Id: <20211103050241.61293-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c currently there are many cases where it is necessary to
compute the offset from a pool element struct to the object containing
it in a type independent way where the offset is different for each type.
By saving a pointer to the object when they are created extra work can be
saved.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 30 ++++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 50a92ec1a0bc..276101016848 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -225,7 +225,8 @@ static int rxe_insert_key(struct rxe_pool *pool, struct rxe_pool_elem *new)
 		elem = rb_entry(parent, struct rxe_pool_elem, key_node);
 
 		cmp = memcmp((u8 *)elem + pool->key.key_offset,
-			     (u8 *)new + pool->key.key_offset, pool->key.key_size);
+			     (u8 *)new + pool->key.key_offset,
+			     pool->key.key_size);
 
 		if (cmp == 0) {
 			pr_warn("key already exists!\n");
@@ -326,7 +327,7 @@ void __rxe_drop_index(struct rxe_pool_elem *elem)
 void *rxe_alloc_locked(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
-	u8 *obj;
+	void *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -335,9 +336,10 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_elem *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
+	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
 	return obj;
@@ -350,7 +352,7 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 void *rxe_alloc(struct rxe_pool *pool)
 {
 	struct rxe_pool_elem *elem;
-	u8 *obj;
+	void *obj;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
@@ -359,9 +361,10 @@ void *rxe_alloc(struct rxe_pool *pool)
 	if (!obj)
 		goto out_cnt;
 
-	elem = (struct rxe_pool_elem *)(obj + pool->elem_offset);
+	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
 
 	elem->pool = pool;
+	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
 	return obj;
@@ -377,6 +380,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 		goto out_cnt;
 
 	elem->pool = pool;
+	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
 	return 0;
@@ -391,13 +395,13 @@ void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_elem *elem =
 		container_of(kref, struct rxe_pool_elem, ref_cnt);
 	struct rxe_pool *pool = elem->pool;
-	u8 *obj;
+	void *obj;
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
 	if (!(pool->flags & RXE_POOL_NO_ALLOC)) {
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 		kfree(obj);
 	}
 
@@ -408,7 +412,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
-	u8 *obj;
+	void *obj;
 
 	node = pool->index.tree.rb_node;
 
@@ -425,7 +429,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -435,7 +439,7 @@ void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
-	u8 *obj;
+	void *obj;
 
 	read_lock_bh(&pool->pool_lock);
 	obj = rxe_pool_get_index_locked(pool, index);
@@ -448,7 +452,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
 	struct rxe_pool_elem *elem;
-	u8 *obj;
+	void *obj;
 	int cmp;
 
 	node = pool->key.tree.rb_node;
@@ -469,7 +473,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 	if (node) {
 		kref_get(&elem->ref_cnt);
-		obj = (u8 *)elem - pool->elem_offset;
+		obj = elem->obj;
 	} else {
 		obj = NULL;
 	}
@@ -479,7 +483,7 @@ void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 
 void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
-	u8 *obj;
+	void *obj;
 
 	read_lock_bh(&pool->pool_lock);
 	obj = rxe_pool_get_key_locked(pool, key);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 591e1c0ad438..c9fa8429fcf4 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -32,6 +32,7 @@ enum rxe_elem_type {
 
 struct rxe_pool_elem {
 	struct rxe_pool		*pool;
+	void			*obj;
 	struct kref		ref_cnt;
 	struct list_head	list;
 
-- 
2.30.2

