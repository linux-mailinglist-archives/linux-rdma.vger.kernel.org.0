Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7350AE75
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 05:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443719AbiDVDUp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443718AbiDVDUm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 23:20:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A844766
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 20:17:51 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350994649"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350994649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 20:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="615218071"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 20:17:49 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev
Subject: [PATCH 4/4] RDMA/rxe: Check RDMA_CREATE_AH_SLEEPABLE in creating AH
Date:   Fri, 22 Apr 2022 15:44:16 -0400
Message-Id: <20220422194416.983549-4-yanjun.zhu@linux.dev>
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

During creating AH, the flag RDMA_CREATE_AH_SLEEPABLE should
be tested.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_mw.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 14 ++++++++------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  4 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++++++++++------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
index c86b2efd58f2..9d72dcc9060d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mw.c
+++ b/drivers/infiniband/sw/rxe/rxe_mw.c
@@ -14,7 +14,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 
 	rxe_get(pd);
 
-	ret = rxe_add_to_pool(&rxe->mw_pool, mw);
+	ret = rxe_add_to_pool(&rxe->mw_pool, mw, GFP_KERNEL);
 	if (ret) {
 		rxe_put(pd);
 		return ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 3f3fa2123f30..5555060702fd 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -152,7 +152,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	return NULL;
 }
 
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem, gfp_t gfp)
 {
 	int err;
 
@@ -166,16 +166,18 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
 	elem->obj = (u8 *)elem - pool->elem_offset;
 	kref_init(&elem->ref_cnt);
 
-	if (pool->type == RXE_TYPE_AH) {
+	if ((pool->type == RXE_TYPE_AH) && (gfp & GFP_ATOMIC)) {
 		unsigned long flags;
 
 		xa_lock_irqsave(&pool->xa, flags);
-		err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
-					&pool->next, GFP_ATOMIC);
+		err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem,
+					pool->limit, &pool->next,
+					GFP_ATOMIC);
 		xa_unlock_irqrestore(&pool->xa, flags);
 	} else {
-		err = xa_alloc_cyclic_irq(&pool->xa, &elem->index, elem, pool->limit,
-					  &pool->next, GFP_KERNEL);
+		err = xa_alloc_cyclic_irq(&pool->xa, &elem->index, elem,
+					  pool->limit, &pool->next,
+					  GFP_KERNEL);
 	}
 	if (err)
 		goto err_cnt;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 24bcc786c1b3..12986622088b 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -62,9 +62,9 @@ void rxe_pool_cleanup(struct rxe_pool *pool);
 void *rxe_alloc(struct rxe_pool *pool);
 
 /* connect already allocated object to pool */
-int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem);
+int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem, gfp_t gfp);
 
-#define rxe_add_to_pool(pool, obj) __rxe_add_to_pool(pool, &(obj)->elem)
+#define rxe_add_to_pool(pool, obj, gfp) __rxe_add_to_pool(pool, &(obj)->elem, gfp)
 
 /* lookup an indexed object from index. takes a reference on object */
 void *rxe_pool_get_index(struct rxe_pool *pool, u32 index);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 67184b0281a0..dce665e74fa7 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -108,7 +108,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibuc->device);
 	struct rxe_ucontext *uc = to_ruc(ibuc);
 
-	return rxe_add_to_pool(&rxe->uc_pool, uc);
+	return rxe_add_to_pool(&rxe->uc_pool, uc, GFP_KERNEL);
 }
 
 static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
@@ -142,7 +142,7 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
 	struct rxe_pd *pd = to_rpd(ibpd);
 
-	return rxe_add_to_pool(&rxe->pd_pool, pd);
+	return rxe_add_to_pool(&rxe->pd_pool, pd, GFP_KERNEL);
 }
 
 static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
@@ -162,6 +162,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	struct rxe_ah *ah = to_rah(ibah);
 	struct rxe_create_ah_resp __user *uresp = NULL;
 	int err;
+	gfp_t gfp;
 
 	if (udata) {
 		/* test if new user provider */
@@ -176,7 +177,12 @@ static int rxe_create_ah(struct ib_ah *ibah,
 	if (err)
 		return err;
 
-	err = rxe_add_to_pool(&rxe->ah_pool, ah);
+	if (init_attr->flags & RDMA_CREATE_AH_SLEEPABLE)
+		gfp = GFP_KERNEL;
+	else
+		gfp = GFP_ATOMIC;
+
+	err = rxe_add_to_pool(&rxe->ah_pool, ah, gfp);
 	if (err)
 		return err;
 
@@ -299,7 +305,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
 	if (err)
 		goto err1;
 
-	err = rxe_add_to_pool(&rxe->srq_pool, srq);
+	err = rxe_add_to_pool(&rxe->srq_pool, srq, GFP_KERNEL);
 	if (err)
 		goto err1;
 
@@ -431,7 +437,7 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
 		qp->is_user = false;
 	}
 
-	err = rxe_add_to_pool(&rxe->qp_pool, qp);
+	err = rxe_add_to_pool(&rxe->qp_pool, qp, GFP_KERNEL);
 	if (err)
 		return err;
 
@@ -800,7 +806,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (err)
 		return err;
 
-	return rxe_add_to_pool(&rxe->cq_pool, cq);
+	return rxe_add_to_pool(&rxe->cq_pool, cq, GFP_KERNEL);
 }
 
 static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
-- 
2.27.0

