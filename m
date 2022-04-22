Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F146450AE74
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 05:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443716AbiDVDUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 23:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443717AbiDVDUj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 23:20:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCB44766
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 20:17:48 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350994645"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350994645"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615218047"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 20:17:46 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Cc:     Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 2/4] RDMA/rxe: Fix dead lock caused by rxe_alloc interrupted by rxe_pool_get_index
Date:   Fri, 22 Apr 2022 15:44:14 -0400
Message-Id: <20220422194416.983549-2-yanjun.zhu@linux.dev>
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

The ah_pool xa_lock first is acquired in this:

{SOFTIRQ-ON-W} state was registered at:
  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock+0x33/0x80
  rxe_alloc+0x1be/0x290 [rdma_rxe]

Then ah_pool xa_lock is acquired in this:

{IN-SOFTIRQ-W}:
  <TASK>
  __lock_acquire+0x1565/0x34a0
  lock_acquire+0x1d2/0x5a0
  _raw_spin_lock_irqsave+0x42/0x90
  rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
  </TASK>

From the above, in the function rxe_alloc,
xa_lock is acquired. Then the function rxe_alloc
is interrupted by softirq. The function
rxe_pool_get_index will also acquire xa_lock.

Finally, the dead lock appears.

        CPU0
        ----
   lock(&xa->xa_lock#15);  <----- rxe_alloc
   <Interrupt>
     lock(&xa->xa_lock#15); <---- rxe_pool_get_index

    *** DEADLOCK ***

Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 67f1d4733682..7b12a52fed35 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -138,8 +138,8 @@ void *rxe_alloc(struct rxe_pool *pool)
 	elem->obj = obj;
 	kref_init(&elem->ref_cnt);
 
-	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-			      &pool->next, GFP_KERNEL);
+	err = xa_alloc_cyclic_irq(&pool->xa, &elem->index, elem, pool->limit,
+				  &pool->next, GFP_KERNEL);
 	if (err)
 		goto err_free;
 
-- 
2.27.0

