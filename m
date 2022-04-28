Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BA5117E7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Apr 2022 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiD0Lr2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Apr 2022 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiD0Lr2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Apr 2022 07:47:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7B47563
        for <linux-rdma@vger.kernel.org>; Wed, 27 Apr 2022 04:44:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="247831824"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="247831824"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 04:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="533166661"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2022 04:44:13 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/rxe: Optimize the mr pool struct
Date:   Thu, 28 Apr 2022 00:10:28 -0400
Message-Id: <20220428041028.1363139-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Based on the commit c9f4c695835c ("RDMA/rxe: Reverse the sense of
RXE_POOL_NO_ALLOC"), only the mr pool uses the RXE_POOL_ALLOC,
As such, replace this flags with pool type to save memory.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 9 +++------
 drivers/infiniband/sw/rxe/rxe_pool.h | 5 -----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 793df1569ff1..138763eb0e10 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -13,7 +13,6 @@ static const struct rxe_type_info {
 	size_t size;
 	size_t elem_offset;
 	void (*cleanup)(struct rxe_pool_elem *elem);
-	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
 	u32 max_elem;
@@ -73,7 +72,6 @@ static const struct rxe_type_info {
 		.size		= sizeof(struct rxe_mr),
 		.elem_offset	= offsetof(struct rxe_mr, elem),
 		.cleanup	= rxe_mr_cleanup,
-		.flags		= RXE_POOL_ALLOC,
 		.min_index	= RXE_MIN_MR_INDEX,
 		.max_index	= RXE_MAX_MR_INDEX,
 		.max_elem	= RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
@@ -101,7 +99,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 	pool->max_elem		= info->max_elem;
 	pool->elem_size		= ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	= info->elem_offset;
-	pool->flags		= info->flags;
 	pool->cleanup		= info->cleanup;
 
 	atomic_set(&pool->num_elem, 0);
@@ -122,7 +119,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	void *obj;
 	int err;
 
-	if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
+	if (WARN_ON(!(pool->type == RXE_TYPE_MR)))
 		return NULL;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -156,7 +153,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem, gfp_t g
 {
 	int err;
 
-	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
+	if (WARN_ON(pool->type == RXE_TYPE_MR))
 		return -EINVAL;
 
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
@@ -217,7 +214,7 @@ static void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
 
-	if (pool->flags & RXE_POOL_ALLOC)
+	if (pool->type == RXE_TYPE_MR)
 		kfree(elem->obj);
 
 	atomic_dec(&pool->num_elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 12986622088b..ff5b52fe96c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,10 +7,6 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
 
-enum rxe_pool_flags {
-	RXE_POOL_ALLOC		= BIT(1),
-};
-
 enum rxe_elem_type {
 	RXE_TYPE_UC,
 	RXE_TYPE_PD,
@@ -35,7 +31,6 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
 	void			(*cleanup)(struct rxe_pool_elem *elem);
-	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
 
 	unsigned int		max_elem;
-- 
2.27.0

