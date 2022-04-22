Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019D50AE73
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 05:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiDVDUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 23:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443716AbiDVDUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 23:20:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCFA4D623
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 20:17:47 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350994641"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350994641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:17:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615218036"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 20:17:45 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Cc:     Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool interrupted by rxe_pool_get_index
Date:   Fri, 22 Apr 2022 15:44:13 -0400
Message-Id: <20220422194416.983549-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
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

This is a dead lock problem.
The ah_pool xa_lock first is acquired in this:

{SOFTIRQ-ON-W} state was registered at:

  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock+0x33/0x80
  __rxe_add_to_pool+0x183/0x230 [rdma_rxe]

Then ah_pool xa_lock is acquired in this:

{IN-SOFTIRQ-W}:

Call Trace:
 <TASK>
  dump_stack_lvl+0x44/0x57
  mark_lock.part.52.cold.79+0x3c/0x46
  __lock_acquire+0x1565/0x34a0
  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock_irqsave+0x42/0x90
  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
  rxe_get_av+0x168/0x2a0 [rdma_rxe]
</TASK>

From the above, in the function __rxe_add_to_pool,
xa_lock is acquired. Then the function __rxe_add_to_pool
is interrupted by softirq. The function
rxe_pool_get_index will also acquire xa_lock.

Finally, the dead lock appears.

        CPU0
        ----
   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
   <Interrupt>
     lock(&xa->xa_lock#15); <---- rxe_pool_get_index

                 *** DEADLOCK ***

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V5->V6: One dead lock fix in one commit
V4->V5: Commit logs are changed.
V3->V4: xa_lock_irq locks are used.
V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
        GFP_ATOMIC is used in __rxe_add_to_pool.
V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87066d04ed18..67f1d4733682 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
 
 	atomic_set(&pool->num_elem, 0);
 
-	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	pool->limit.min = info->min_index;
 	pool->limit.max = info->max_index;
 }
@@ -155,6 +155,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err;
+	unsigned long flags;
 
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
 		return -EINVAL;
@@ -166,8 +167,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	xa_lock_irqsave(&pool->xa, flags);
+	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+				&pool->next, GFP_ATOMIC);
+	xa_unlock_irqrestore(&pool->xa, flags);
 	if (err)
 		goto err_cnt;
 
@@ -201,7 +204,7 @@ static void rxe_elem_release(struct kref *kref)
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 	struct rxe_pool *pool = elem->pool;
 
-	xa_erase(&pool->xa, elem->index);
+	xa_erase_irq(&pool->xa, elem->index);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
-- 
2.27.0

