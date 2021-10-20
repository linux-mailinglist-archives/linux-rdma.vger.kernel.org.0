Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4297A4355B8
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhJTWJs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhJTWJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:46 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F5C061749
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id e59-20020a9d01c1000000b00552c91a99f7so8759079ote.6
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUZlyYFvpB1zhxSg6eTAb3KaGoV30W/+ippY3r9hWpA=;
        b=eVvVWyDhcKgHeRePEfZKP+gaIjKKqTKIDQyurjbnt1jVAOLSZAGVInqndHH5W9tsSQ
         XXCvYfObG0QPgrWjyrmsEgYynVrlFIeEUQ8d587cW5yman6140FomHr5xqkYd4oTfXhP
         ZqWoMIG+VCXTWqS/rWFvQltfv1qoDXJpcfbpMmr/s3KAyhZEdKy+B0OTvt84V5GvoY7+
         OH00i9h2J+Hk3YTtcTlxTD2Zk0cUO+2QVHnRTFg1aXtOjB2sFBf6tDyYZvIEZ7xetxhy
         yqXy9XU2dg6NhswchuUVmtzshUTQNHo8DIAkaOXOAK47jYruZTUnPAOyhLu/rWkJEvEF
         5p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUZlyYFvpB1zhxSg6eTAb3KaGoV30W/+ippY3r9hWpA=;
        b=AzY6ZpnZ/qFUYsNkJQgfrTtgRmm+1HbWRkCAJsn4Ir2EJU5cgn5LjZrnxF+56dyMXT
         OveX++q81kEXZdKbKHp9V9gJQuqFAPi6BV1l9qYADs8+FNHPKA+U3Lsz0yhWrKqeoo6U
         16cK8K4SxPpBdTPtypWn0tMnebSdBhEwnxlQ7dOhhyAiP3AG8kM83F7SI27Jm8qqXjUq
         ux0mv1bNQJrjg5pxchLLRKpnyjYZqEVjLfXeI2pGD8acD2Jn6S2iopsj5y17aSMdcFSf
         BDGkbLfOD2DcGPhuXl+yQoKRNmW5aEuIHpSQ0rlofYVCJzROpPJw//3fLVFCHGsZ1De8
         I9OQ==
X-Gm-Message-State: AOAM532nWdsBKbNHmdPIPADCI137fZmYOENm5b7vNnyrbBS+3n1uDKNu
        tdeQQ50ePGVmn1kRe60uIMNkp0dL/BY=
X-Google-Smtp-Source: ABdhPJzXuelvpQZTBu0NVQ4CemBcHoS5PcVFAKJ/R74y0ernWCNxk5gxGjYdbvqQ7rBnNH5wtcCNRw==
X-Received: by 2002:a9d:8ab:: with SMTP id 40mr295084otf.109.1634767651509;
        Wed, 20 Oct 2021 15:07:31 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 7/7] RDMA/rxe: Rename XARRAY as INDEX
Date:   Wed, 20 Oct 2021 17:05:50 -0500
Message-Id: <20211020220549.36145-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211020220549.36145-1-rpearsonhpe@gmail.com>
References: <20211020220549.36145-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rename RXE_POOL_XARRAY as RXE_POOL_INDEX and change several function
names .._index_... from .._xarray_.. which completes the process of
replacing red-black trees by xarrays.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 38 +++++++++-------------------
 drivers/infiniband/sw/rxe/rxe_pool.h |  4 +--
 2 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 6e51483c0494..6367cf68d19d 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -25,7 +25,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, elem),
-		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_AH_INDEX,
 		.max_index	= RXE_MAX_AH_INDEX,
 	},
@@ -34,7 +34,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_srq),
 		.elem_offset	= offsetof(struct rxe_srq, elem),
 		.cleanup	= rxe_srq_cleanup,
-		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_SRQ_INDEX,
 		.max_index	= RXE_MAX_SRQ_INDEX,
 	},
@@ -43,7 +43,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_qp),
 		.elem_offset	= offsetof(struct rxe_qp, elem),
 		.cleanup	= rxe_qp_cleanup,
-		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.min_index	= RXE_MIN_QP_INDEX,
 		.max_index	= RXE_MAX_QP_INDEX,
 	},
@@ -59,7 +59,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_XARRAY,
+		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.min_index	= RXE_MIN_MR_INDEX,
 	},
@@ -68,7 +68,7 @@ static const struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.size		= sizeof(struct rxe_mw),
 		.elem_offset	= offsetof(struct rxe_mw, elem),
 		.cleanup	= rxe_mw_cleanup,
-		.flags		= RXE_POOL_XARRAY | RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
 	},
@@ -103,7 +103,7 @@ void rxe_pool_init(
 
 	atomic_set(&pool->num_elem, 0);
 
-	if (info->flags & RXE_POOL_XARRAY) {
+	if (info->flags & RXE_POOL_INDEX) {
 		xa_init_flags(&pool->xarray.xa, XA_FLAGS_ALLOC);
 		pool->xarray.limit.max = info->max_index;
 		pool->xarray.limit.min = info->min_index;
@@ -173,7 +173,7 @@ static void *__rxe_alloc_locked(struct rxe_pool *pool)
 	elem->pool = pool;
 	elem->obj = obj;
 
-	if (pool->flags & RXE_POOL_XARRAY) {
+	if (pool->flags & RXE_POOL_INDEX) {
 		err = __xa_alloc_cyclic(&pool->xarray.xa, &elem->index, elem,
 					pool->xarray.limit,
 					&pool->xarray.next, GFP_KERNEL);
@@ -264,7 +264,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->pool = pool;
 	elem->obj = (u8 *)elem - pool->elem_offset;
 
-	if (pool->flags & RXE_POOL_XARRAY) {
+	if (pool->flags & RXE_POOL_INDEX) {
 		err = __xa_alloc_cyclic(&pool->xarray.xa, &elem->index, elem,
 					pool->xarray.limit,
 					&pool->xarray.next, GFP_KERNEL);
@@ -283,7 +283,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	return -EINVAL;
 }
 
-static void *__rxe_get_xarray_locked(struct rxe_pool *pool, u32 index)
+void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
 {
 	struct rxe_pool_elem *elem;
 	void *obj = NULL;
@@ -295,31 +295,17 @@ static void *__rxe_get_xarray_locked(struct rxe_pool *pool, u32 index)
 	return obj;
 }
 
-static void *__rxe_get_xarray(struct rxe_pool *pool, u32 index)
+void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
 {
 	void *obj;
 
 	xa_lock_bh(&pool->xarray.xa);
-	obj = __rxe_get_xarray_locked(pool, index);
+	obj = rxe_pool_get_index_locked(pool, index);
 	xa_unlock_bh(&pool->xarray.xa);
 
 	return obj;
 }
 
-void *rxe_pool_get_index_locked(struct rxe_pool *pool, u32 index)
-{
-	if (pool->flags & RXE_POOL_XARRAY)
-		return __rxe_get_xarray_locked(pool, index);
-	return NULL;
-}
-
-void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
-{
-	if (pool->flags & RXE_POOL_XARRAY)
-		return __rxe_get_xarray(pool, index);
-	return NULL;
-}
-
 void *rxe_pool_get_key_locked(struct rxe_pool *pool, void *key)
 {
 	struct rb_node *node;
@@ -413,7 +399,7 @@ static int __rxe_fini(struct rxe_pool_elem *elem)
 
 	done = refcount_dec_if_one(&elem->refcnt);
 	if (done) {
-		if (pool->flags & RXE_POOL_XARRAY)
+		if (pool->flags & RXE_POOL_INDEX)
 			__xa_erase(&pool->xarray.xa, elem->index);
 		if (pool->flags & RXE_POOL_KEY)
 			rb_erase(&elem->key_node, &pool->key.tree);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 191e5aea454f..95a6b1e5232f 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -14,8 +14,8 @@
 #define RXE_POOL_CACHE_FLAGS	(0)
 
 enum rxe_pool_flags {
+	RXE_POOL_INDEX		= BIT(1),
 	RXE_POOL_KEY		= BIT(2),
-	RXE_POOL_XARRAY		= BIT(3),
 	RXE_POOL_NO_ALLOC	= BIT(4),
 };
 
@@ -72,7 +72,7 @@ struct rxe_pool {
 	size_t			elem_size;
 	size_t			elem_offset;
 
-	/* only used if xarray */
+	/* only used if indexed */
 	struct {
 		struct xarray		xa;
 		struct xa_limit		limit;
-- 
2.30.2

