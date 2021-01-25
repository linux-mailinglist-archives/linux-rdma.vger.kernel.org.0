Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABF302D74
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 22:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbhAYVSw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbhAYVSX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:18:23 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDDAC06178A
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:48 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id s2so12017956otp.5
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71W3O1dOs9YUN5fkCQYTn3c6Ta+pMpza3pa9aXNa424=;
        b=FBfF1eQC1CkEEXaRtP+LAMJkgxKyzW4oqtVpNBXyQoC6l9h6WENAlUXj5POyjPrfzq
         Iyzi+tQ13w+UQn0dprFymynnMpt9IlYQU+MpIOtZZH8iQUK8SitaQgGMtqOqktaZv+iV
         /tvHcYaUakQiKr2Fq6hiFBHCaONZegPTWVAWPUYQabDe2inZhLYdrhSqpwpIxjH51MF9
         bpXY72rZkN4x5W8+Ggqs42tSFBselME4/GqNGGj2g1GKUfa1S0cttVXNgapkN7KwlEfF
         LjzfyPQofUk9Ccq7uUqiTKX//5N9qshk2Ewxm00LRCTNl3JJXAUN/8+rykca7Cg15Esq
         b8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71W3O1dOs9YUN5fkCQYTn3c6Ta+pMpza3pa9aXNa424=;
        b=fMgGwVfoPAcPJOunOT3cIJ4p8Iz6Qw2g5TRRPdrRqutAS+dve7/eTCTDgxp/DoiSCv
         5bjuW5wtUc84GiIzkmtDd+URWH96yUqjwSsD7q+Y3pYJzAIzvSvpgausw4G0QDKsJcf/
         FpO9RVyP7LsttWxmO30VIVV6t8vUO0V7p9dFz1N9t2+2nclVMWnKkxwdFW2DnPLkvAb0
         Vnp9z+R90MEj7hKuRSFrDrxGLk7nro8KU8nJhfGSbwWKhmADpfORbv1hw9Uyclozn/eX
         COOVnFbSeTekgeJ8gmRlNxSscExm6p0GBwrpfWyX/ULAypMtKI/33wEkZO7PAD5xi69t
         8dLw==
X-Gm-Message-State: AOAM532SyIF6D3emSyryBHo2Y+klh3C6NpxwX3C8KAITp9BJCuUrvGaN
        JkQN13AdgYBX805r7WB+n1Y=
X-Google-Smtp-Source: ABdhPJz6jVnwe1Kkm4Zwr1eUTH9Y23o9uOSoWZUi/55CbIfOQ6rKSmb+QE9P0kw/6+cbgnTRsDEF1w==
X-Received: by 2002:a9d:3b43:: with SMTP id z61mr1788903otb.217.1611609407579;
        Mon, 25 Jan 2021 13:16:47 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 4/6] RDMA/rxe: Remove references to ib_device and pool
Date:   Mon, 25 Jan 2021 15:16:39 -0600
Message-Id: <20210125211641.2694-5-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210125211641.2694-1-rpearson@hpe.com>
References: <20210125211641.2694-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v2]
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

[v1]
The previous version only removed the ib_device reference.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 42 ++--------------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  1 -
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 0ca46bd8be51..5f85a90e5a5a 100644
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
@@ -345,11 +331,6 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 	if (pool->state != RXE_POOL_STATE_VALID)
 		return NULL;
 
-	kref_get(&pool->ref_cnt);
-
-	if (!ib_device_try_get(&pool->rxe->ib_dev))
-		goto out_put_pool;
-
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
 		goto out_cnt;
 
@@ -366,9 +347,6 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
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
index 22714dafe00d..8f8de746ca17 100644
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

