Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D74355B5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJTWJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhJTWJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:44 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E295DC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id s2-20020a4ac102000000b002b722c09046so2440696oop.2
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzZRpML2iAuglAg/yb93zs5By5zgGvMyEflwpHWoCdE=;
        b=qDIWtK00L40Oz2k9cBhS3aJrj0WMhNjJiNzugCELg433FcJuzGavw29Xnr2Seu7JwH
         hr4fxYGvFs3CtrWv9QcClva2wb65j42yYe3LHhAqhEctJliIrrEUXiLU0r1J2o5YJDdZ
         WUYfgwX0yr1PVlrY+To7W62zYUC70ick3rjzDYrXRsw5vqvenMytb8kFlQ9nWokUeLpR
         vr4Ur5+g+KyTHqxmen+D4wRlUjgeKkxaszFijdT+ymYxHXzQykV8RZ60NBdvlD6HBES0
         H3o294BlPnIfyZpH8I7Ks3WFQYPdSYXKX08pHwJyPsl8BhiN0h/G1P8Yz1/e9fZT0XDz
         ta0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzZRpML2iAuglAg/yb93zs5By5zgGvMyEflwpHWoCdE=;
        b=5slXC8cvuJVbmQJw7A7It1DHG8OocfKOzNNsQ/UtaEJmmZJ77ibkPW+aMFfN0O7lFJ
         eM9YNdkQB0r/AZKxszyV6AN1JejW+zhRLB4mvBZlN9ahdhuK+0jCqsnMTmm+9/dcgbCn
         LNoDVkQesfwPrmg9Y6B7WZfQh99LECx1rMaYzUj7piHDnRi7LPG1rE4bK+ojHbyuiy70
         XGCxbtLZegxEoNJsZsDvqRmQevrkrOs37AU/du27Myze+h9njiNLepMdzMDDh+6OT/pE
         BVP1OTr9gykcTVwPiv8yqX8mIalO//zGS60hwZ8u/3uZ9g2YtDQBy26HOlapdsgdHvqF
         FhCg==
X-Gm-Message-State: AOAM531hny9YtQZJfcItJLTZ6J3GcJRXvMOzGAZmjw+twyMg4lX5fKvF
        yzMWSx/6pY33jHdS8mG0w0c5HT2mhok=
X-Google-Smtp-Source: ABdhPJxlJz5FP/BlzAmc1Oc2H1jzzse68icIePXn0nCpZwxyFDF8cqsHyawJ0Evz+y47m1NI5jwEEQ==
X-Received: by 2002:a4a:d84e:: with SMTP id g14mr1434291oov.62.1634767649343;
        Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 4/7] RDMA/rxe: Replace pool_lock by xa_lock
Date:   Wed, 20 Oct 2021 17:05:47 -0500
Message-Id: <20211020220549.36145-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020220549.36145-1-rpearsonhpe@gmail.com>
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c xa_alloc_bh and xa_erase_bh and variants already include
	spin_lock_bh()
	__xa_alloc()
	spin_unlock_bh()
So we are double locking. Replacing pool_lock by xa_lock and using xa_lock
in all the places that were previously locked by pool_lock but dropping the
double locks is a performance improvement.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 54 ++++++++++++++--------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index ba5c600fa9e8..1b7269dd6d9e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -133,8 +133,6 @@ int rxe_pool_init(
 
 	atomic_set(&pool->num_elem, 0);
 
-	rwlock_init(&pool->pool_lock);
-
 	if (info->flags & RXE_POOL_XARRAY) {
 		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
 		pool->xarray.limit.max = info->max_index;
@@ -292,9 +290,9 @@ static void *__rxe_alloc_locked(struct rxe_pool *pool)
 	elem->obj = obj;
 
 	if (pool->flags & RXE_POOL_XARRAY) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
-					 pool->xarray.limit,
-					 &pool->xarray.next, GFP_KERNEL);
+		err = __xa_alloc_cyclic(&pool->xarray.xa, &elem->index, elem,
+					pool->xarray.limit,
+					&pool->xarray.next, GFP_KERNEL);
 		if (err)
 			goto err;
 	}
@@ -359,9 +357,9 @@ void *rxe_alloc(struct rxe_pool *pool)
 {
 	void *obj;
 
-	write_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	obj = rxe_alloc_locked(pool);
-	write_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return obj;
 }
@@ -370,9 +368,9 @@ void *rxe_alloc_with_key(struct rxe_pool *pool, void *key)
 {
 	void *obj;
 
-	write_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	obj = rxe_alloc_with_key_locked(pool, key);
-	write_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return obj;
 }
@@ -381,7 +379,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err;
 
-	write_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto err;
 
@@ -389,9 +387,9 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 
 	if (pool->flags & RXE_POOL_XARRAY) {
-		err = xa_alloc_cyclic_bh(&pool->xarray.xa, &elem->index, elem,
-					 pool->xarray.limit,
-					 &pool->xarray.next, GFP_KERNEL);
+		err = __xa_alloc_cyclic(&pool->xarray.xa, &elem->index, elem,
+					pool->xarray.limit,
+					&pool->xarray.next, GFP_KERNEL);
 		if (err)
 			goto err;
 	}
@@ -403,13 +401,13 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	}
 
 	refcount_set(&elem->refcnt, 1);
-	write_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return 0;
 
 err:
 	atomic_dec(&pool->num_elem);
-	write_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 	return -EINVAL;
 }
 
@@ -442,9 +440,9 @@ static void *__rxe_get_index(struct rxe_pool *pool, u32 index)
 {
 	void *obj;
 
-	read_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	obj = __rxe_get_index_locked(pool, index);
-	read_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return obj;
 }
@@ -465,9 +463,9 @@ static void *__rxe_get_xarray(struct rxe_pool *pool, u32 index)
 {
 	void *obj;
 
-	read_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	obj = __rxe_get_xarray_locked(pool, index);
-	read_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return obj;
 }
@@ -523,9 +521,9 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
 {
 	void *obj;
 
-	read_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	obj = rxe_pool_get_key_locked(pool, key);
-	read_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return obj;
 }
@@ -546,9 +544,9 @@ int __rxe_add_ref(struct rxe_pool_elem *elem)
 	struct rxe_pool *pool = elem->pool;
 	int ret;
 
-	read_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	ret = __rxe_add_ref_locked(elem);
-	read_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return ret;
 }
@@ -569,9 +567,9 @@ int __rxe_drop_ref(struct rxe_pool_elem *elem)
 	struct rxe_pool *pool = elem->pool;
 	int ret;
 
-	read_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	ret = __rxe_drop_ref_locked(elem);
-	read_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	return ret;
 }
@@ -584,7 +582,7 @@ static int __rxe_fini(struct rxe_pool_elem *elem)
 	done = refcount_dec_if_one(&elem->refcnt);
 	if (done) {
 		if (pool->flags & RXE_POOL_XARRAY)
-			xa_erase(&pool->xarray.xa, elem->index);
+			__xa_erase(&pool->xarray.xa, elem->index);
 		if (pool->flags & RXE_POOL_INDEX)
 			rxe_drop_index(elem);
 		if (pool->flags & RXE_POOL_KEY)
@@ -621,9 +619,9 @@ int __rxe_fini_ref(struct rxe_pool_elem *elem)
 	struct rxe_pool *pool = elem->pool;
 	int ret;
 
-	read_lock_bh(&pool->pool_lock);
+	xa_lock_bh(&pool->xarray.xa);
 	ret = __rxe_fini(elem);
-	read_unlock_bh(&pool->pool_lock);
+	xa_unlock_bh(&pool->xarray.xa);
 
 	if (!ret) {
 		if (pool->cleanup)
-- 
2.30.2

