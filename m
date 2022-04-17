Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112DC5035EB
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Apr 2022 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiDPKTc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 16 Apr 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiDPKTb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 16 Apr 2022 06:19:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B9C3FBC6
        for <linux-rdma@vger.kernel.org>; Sat, 16 Apr 2022 03:16:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243214267"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="243214267"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 03:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="509216069"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2022 03:16:57 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCHv2 2/2] RDMA/rxe: Use different xa locks on different path
Date:   Sat, 16 Apr 2022 22:43:43 -0400
Message-Id: <20220417024343.568777-2-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220417024343.568777-1-yanjun.zhu@linux.dev>
References: <20220417024343.568777-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function __rxe_add_to_pool is called on different path, and the
requirement of the locks is different. The function rxe_create_ah
requires xa_lock_irqsave/irqrestore while others only require xa_lock_irq.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Use pool type instead of gfp_t;
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index f1f06dc7e64f..5b097d6666eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -157,7 +157,6 @@ void *rxe_alloc(struct rxe_pool *pool)
 int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 {
 	int err;
-	unsigned long flags;
 
 	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
 		return -EINVAL;
@@ -169,10 +168,19 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
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
+		xa_lock_irq(&pool->xa);
+		err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
+					&pool->next, GFP_KERNEL);
+		xa_unlock_irq(&pool->xa);
+	}
 	if (err)
 		goto err_cnt;
 
-- 
2.27.0

