Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C724FE476
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356925AbiDLPSt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356926AbiDLPSl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 11:18:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F9A5E761
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 08:16:21 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262147264"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="262147264"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 08:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="572803096"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2022 08:16:18 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev,
        linux-rdma@vger.kernel.org
Cc:     Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCHv3 1/1] RDMA/rxe: Fix a dead lock problem
Date:   Wed, 13 Apr 2022 03:42:08 -0400
Message-Id: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

This is a dead lock problem.
The xa_lock first is acquired in this:

{SOFTIRQ-ON-W} state was registered at:

  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock+0x33/0x80
  __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
  __ib_alloc_pd+0xf9/0x550 [ib_core]
  ib_mad_init_device+0x2d9/0xd20 [ib_core]
  add_client_context+0x2fa/0x450 [ib_core]
  enable_device_and_get+0x1b7/0x350 [ib_core]
  ib_register_device+0x757/0xaf0 [ib_core]
  rxe_register_device+0x2eb/0x390 [rdma_rxe]
  rxe_net_add+0x83/0xc0 [rdma_rxe]
  rxe_newlink+0x76/0x90 [rdma_rxe]
  nldev_newlink+0x245/0x3e0 [ib_core]
  rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
  rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
  netlink_unicast+0x43b/0x640
  netlink_sendmsg+0x7eb/0xc40
  sock_sendmsg+0xe0/0x110
  __sys_sendto+0x1d7/0x2b0
  __x64_sys_sendto+0xdd/0x1b0
  do_syscall_64+0x37/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Then xa_lock is acquired in this:

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
  rxe_requester+0x75b/0x4a90 [rdma_rxe]
  rxe_do_task+0x134/0x230 [rdma_rxe]
  tasklet_action_common.isra.12+0x1f7/0x2d0
  __do_softirq+0x1ea/0xa4c
  run_ksoftirqd+0x32/0x60
  smpboot_thread_fn+0x503/0x860
  kthread+0x29b/0x340
  ret_from_fork+0x1f/0x30
 </TASK>

From the above, in the function __rxe_add_to_pool,
xa_lock is acquired. Then the function __rxe_add_to_pool
is interrupted by softirq. The function
rxe_pool_get_index will also acquire xa_lock.

Finally, the dead lock appears.

[  296.806097]        CPU0
[  296.808550]        ----
[  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
[  296.814583]   <Interrupt>
[  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
[  296.820961]
                 *** DEADLOCK ***

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
        GFP_ATOMIC is used in __rxe_add_to_pool.
V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 87066d04ed18..b9b147df4020 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	xa_lock_bh(&pool->xa);
+	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+				&pool->next, GFP_KERNEL);
+	xa_unlock_bh(&pool->xa);
 	if (err)
 		goto err_free;
 
@@ -166,8 +168,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	xa_lock_irq(&pool->xa);
+	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+				&pool->next, GFP_ATOMIC);
+	xa_unlock_irq(&pool->xa);
 	if (err)
 		goto err_cnt;
 
@@ -200,8 +204,11 @@ static void rxe_elem_release(struct kref *kref)
 {
 	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
 	struct rxe_pool *pool = elem->pool;
+	unsigned long flags;
 
-	xa_erase(&pool->xa, elem->index);
+	xa_lock_irqsave(&pool->xa, flags);
+	__xa_erase(&pool->xa, elem->index);
+	xa_unlock_irqrestore(&pool->xa, flags);
 
 	if (pool->cleanup)
 		pool->cleanup(elem);
-- 
2.27.0

