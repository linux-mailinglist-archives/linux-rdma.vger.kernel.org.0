Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8350AE76
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 05:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443717AbiDVDUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 23:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443718AbiDVDUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 23:20:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC22C44766
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 20:17:49 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350994648"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350994648"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615218057"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 20:17:48 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 3/4] RDMA/rxe: Use different xa locks on different path
Date:   Fri, 22 Apr 2022 15:44:15 -0400
Message-Id: <20220422194416.983549-3-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220422194416.983549-1-yanjun.zhu@linux.dev>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function __rxe_add_to_pool is called on different paths, and the
requirement of the locks is different. The function rxe_create_ah
requires xa_lock_irqsave/irqrestore while others only require xa_lock_irq.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 7b12a52fed35..3f3fa2123f30 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -155,7 +155,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err;
-	unsigned long flags;
 
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
 		return -EINVAL;
@@ -167,10 +166,17 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	xa_lock_irqsave(&pool->xa, flags);
-	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-				&pool->next, GFP_ATOMIC);
-	xa_unlock_irqrestore(&pool->xa, flags);
+	if (pool->type == RXE_TYPE_AH) {
+		unsigned long flags;
+
+		xa_lock_irqsave(&pool->xa, flags);
+		err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+					&pool->next, GFP_ATOMIC);
+		xa_unlock_irqrestore(&pool->xa, flags);
+	} else {
+		err = xa_alloc_cyclic_irq(&pool->xa, &elem->index, elem, pool->limit,
+					  &pool->next, GFP_KERNEL);
+	}
 	if (err)
 		goto err_cnt;
 
-- 
2.27.0

