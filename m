Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF03D42FE38
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhJOWgD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbhJOWgD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:03 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CFC061570
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:56 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso4539393otv.0
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8w+RS10CLLhJABVXoee8/sARMH0zV70Q2mKDEBrpqQ=;
        b=UIp/M44q+r4/bGIUztGM9bssK/MCbjrVHNm/zNAxGtLy6D/kzeY8KckWmXr4TeRNyZ
         gswsSgOdz7hi/wPTZPxX/R5ngn05O10WT8O12HAJqLW37SY/g2DsvtsEc6IjqQAh+x2e
         zKwEFOcdDy21T3oeuQdCJhjXp8Nqgv8D+8x+qa1IylQl5gziw9n5PRbQwC3IcDMDlzbW
         VXsKV3aPTYgsIl55Z9MWay29hu4TxKIuvHSMakh0/1hMBHXhbxdDOVToiFHtfMImLvVA
         YL/UW8X0TdkBWiQFg+PM8tjOBW1kzgG74QW0W5Z+zpqtNMH5A9MvX5KnW7T2PXfdDh9v
         kliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8w+RS10CLLhJABVXoee8/sARMH0zV70Q2mKDEBrpqQ=;
        b=O/ooLdSaQpALubpAA5EkdVBl8+bgSd2jJ//ooEZm3RCJWwAhKfN2kVEwN6yfq6fUvB
         v7mG34lqoGgtt19wcwgCQabzRTgcMj28hJky5d7KhShYRiw+rWIis7ACzoyH3EPjnKDD
         g/3KG5XWPRDqAfcwkOPk50KOjEHRlHP3m3IIKRkjOAr2H5gdNmpxfabQp5DY6uEWDhzm
         ltxLNm3CSWzX+JNWqXR5fi3sH8Q2+Ef5MuXbvT6orbAWBPZpYiU22fjIKblmthdE86N+
         fpqDUHxYF07eBMKu6e/8GcUzirFIiRWetnhzT5PLZ9mDwiuNIwYGSNrX1BxHjuWt+KuQ
         xolQ==
X-Gm-Message-State: AOAM533gfPizXGtZ7yT6Fkg0mpxT4Daq8xUdXS9JLPyvBSzdGTt0e1wq
        FYqkYeMfPHtAg7Z8mMmrVB8=
X-Google-Smtp-Source: ABdhPJzqe8tmyILa4AM5tTBOD7JW/4piUnbmvQJC76/w6DE5orizFLT/uRrO4wdsYRhTMsl1Kj0e7A==
X-Received: by 2002:a05:6830:240e:: with SMTP id j14mr9927590ots.354.1634337235595;
        Fri, 15 Oct 2021 15:33:55 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 01/10] RDMA/rxe: Make rxe_alloc() take pool lock
Date:   Fri, 15 Oct 2021 17:32:42 -0500
Message-Id: <20211015223250.6501-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015223250.6501-1-rpearsonhpe@gmail.com>
References: <20211015223250.6501-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_pool.c there are two separate pool APIs for creating a new object
rxe_alloc() and rxe_alloc_locked(). Currently they are identical.
Make rxe_alloc() take the pool lock which is in line with the other
APIs in the library and was the original intent.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7b4cb46edfd9..6553ea160d4f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -354,27 +354,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
 
 void *rxe_alloc(struct rxe_pool *pool)
 {
-	struct rxe_type_info *info = &rxe_type_info[pool->type];
-	struct rxe_pool_entry *elem;
+	unsigned long flags;
 	u8 *obj;
 
-	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
-		goto out_cnt;
-
-	obj = kzalloc(info->size, GFP_KERNEL);
-	if (!obj)
-		goto out_cnt;
-
-	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
-
-	elem->pool = pool;
-	kref_init(&elem->ref_cnt);
+	write_lock_irqsave(&pool->pool_lock, flags);
+	obj = rxe_alloc_locked(pool);
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 
 	return obj;
-
-out_cnt:
-	atomic_dec(&pool->num_elem);
-	return NULL;
 }
 
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_entry *elem)
-- 
2.30.2

