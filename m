Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF58300CC7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbhAVTiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbhAVTaq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:30:46 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47606C061788
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:06 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q25so7200573oij.10
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5WqAkjvDFkAoEyL1IBjczEUhyvt4C1aoieU59QkT2M=;
        b=JRIoujqcG3HBMhJvxF9p1pqfTKP03h02gGmcPYPTYJpxA7zQxBXN6EeBiNp2qy5oCA
         tfaMC0qbnvwZgkRW9gf1F5WbBvYHW591iPiSzJdv5c52hucOsbUlH9ej8T9MP5xhDZy4
         3n6RQnOYIyJD3+iVJobROnY4TeGXANIFt36sYHXP/XkdxWxBJX3uOq2yNYpQhJH8D6zT
         1cJYo05K4eq56PItsaM9pmGPdB+QWs5Urcdl/y/gHDZQhEfyoiSsCoFVotKmp1pJA9p5
         r4ZWS3mLifIlsOqKsk31vvAiMIYwZ/H3/lTnUhHjLNy3Ow7C2iaGmXQ2RPhhrMTTAeVU
         eyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5WqAkjvDFkAoEyL1IBjczEUhyvt4C1aoieU59QkT2M=;
        b=K+FtKRlwua/jzhqTotabeIeLjzIFqGuXTrxBOv9R0v5B8FarzrNH5hjIefZ+OXCKOk
         bmSY+4uOxltZZcQyFoCfEqPC/7H9pyTFkFSnvG1wVEPseZUNIQH6VnNXzqqfM/RhzxDl
         l0z6Z4Obg4/isyurd6qAQsIG13VoPaXM/E/pGhKvg6gVQmqIxOIP/k6dKFl/nS9hpc+Q
         8X036nbxwd4ddzlatoMn9F7a7V4SBxx5xUZKno0vHkFTONmjIsfuJTta3KhSEn9Fn/j/
         bA5YszB8IOlTTmKtx7caJdpJwjqA9aILnAYFzczQr21r55ciCUXT4PBPbgz2tMKvzyNJ
         vKOQ==
X-Gm-Message-State: AOAM531njWRFVDfpTV8GMhhZAoF9Nx6CaIqaRE1aQDalmFIGX+Ihpjmi
        r/W7I3xy0gGWJyYZ49ESGk8=
X-Google-Smtp-Source: ABdhPJycXMrkDsBIt1KYQvyuurfK1DhIJqhC0LtzZydTSeteSa4i/Rrrw+g2wXEoKl5LP30aQhnYZA==
X-Received: by 2002:aca:f00a:: with SMTP id o10mr4445571oih.128.1611343805767;
        Fri, 22 Jan 2021 11:30:05 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:05 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 4/6] RDMA/rxe: Remove references to ib_device and pool
Date:   Fri, 22 Jan 2021 13:29:41 -0600
Message-Id: <20210122192943.5538-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210122192943.5538-1-rpearson@hpe.com>
References: <20210122192943.5538-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_pool.c takes references to the pool and ib_device structs
for each object allocated and also keeps an atomic num_elem
count in each pool. This is more work than is needed. Pool
allocation is only called from verbs APIs which already have
references to ib_device and pools are only diasbled when the
driver is removed so no protection of the pool addresses
are needed. The elem count is used to warn if elements are
still present in a pool when it is cleaned up which is useful.

This patch eliminates the references to the ib_device and pool
structs.

The previous version only removed the ib_device reference.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 42 ++--------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 -
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7e68f99558a7..09d8665c5343 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -142,8 +142,6 @@ int rxe_pool_init(
 
 	atomic_set(&pool->num_elem, 0);
 
-	kref_init(&pool->ref_cnt);
-
 	rwlock_init(&pool->pool_lock);
 
 	if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
@@ -165,19 +163,6 @@ int rxe_pool_init(
 	return err;
 }
 
-static void rxe_pool_release(struct kref *kref)
-{
-	struct rxe_pool *pool = container_of(kref, struct rxe_pool, ref_cnt);
-
-	pool->state = RXE_POOL_STATE_INVALID;
-	kfree(pool->index.table);
-}
-
-static void rxe_pool_put(struct rxe_pool *pool)
-{
-	kref_put(&pool->ref_cnt, rxe_pool_release);
-}
-
 void rxe_pool_cleanup(struct rxe_pool *pool)
 {
 	unsigned long flags;
@@ -189,7 +174,8 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
 			pool_name(pool));
 	write_unlock_irqrestore(&pool->pool_lock, flags);
 
-	rxe_pool_put(pool);
+	pool->state = RXE_POOL_STATE_INVALID;
+	kfree(pool->index.table);
 }
 
 static u32 alloc_index(struct rxe_pool *pool)
@@ -345,11 +331,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		return NULL;
 
-	kref_get(&pool->ref_cnt);
-
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -366,9 +347,6 @@ void *rxe_alloc__(struct rxe_pool *pool)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
-out_put_pool:
-	rxe_pool_put(pool);
 	return NULL;
 }
 
@@ -385,12 +363,8 @@ void *rxe_alloc(struct rxe_pool *pool)
 		return NULL;
 	}
 
-	kref_get(&pool->ref_cnt);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -407,9 +381,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
-out_put_pool:
-	rxe_pool_put(pool);
 	return NULL;
 }
 
@@ -422,12 +393,8 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 		read_unlock_irqrestore(&pool->pool_lock, flags);
 		return -EINVAL;
 	}
-	kref_get(&pool->ref_cnt);
 	read_unlock_irqrestore(&pool->pool_lock, flags);
 
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -438,9 +405,6 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
 
 out_cnt:
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
-out_put_pool:
-	rxe_pool_put(pool);
 	return -EINVAL;
 }
 
@@ -461,8 +425,6 @@ void rxe_elem_release(struct kref *kref)
 	}
 
 	atomic_dec(&pool->num_elem);
-	ib_device_put(&pool->rxe->ib_dev);
-	rxe_pool_put(pool);
 }
 
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index f916ad4d0406..294839d1eed8 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -68,7 +68,6 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	rwlock_t		pool_lock; /* protects pool add/del/search */
 	size_t			elem_size;
-	struct kref		ref_cnt;
 	void			(*cleanup)(struct rxe_pool_entry *obj);
 	enum rxe_pool_state	state;
 	enum rxe_pool_flags	flags;
-- 
2.27.0

