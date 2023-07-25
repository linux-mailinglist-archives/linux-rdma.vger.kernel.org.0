Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F20761DC1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jul 2023 17:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGYPzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jul 2023 11:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGYPzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jul 2023 11:55:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4E2102
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jul 2023 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690300516; x=1721836516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nnCTPD6w/pQnyFKzIew+ONlM/Q+XrkXNRpqNw5f3j1A=;
  b=mlMwUoF47m4qDw8vN5Fz97BVA5yiITVcEhwn3kg/QWe8yk/opuHbIkt1
   BFT0mTuQjSX+Nf5OhLg65JNotoNIu+h7KtyvV9DWbJfsg3U8Dftor9m1p
   Wb5HagKbOGPtjVL737ASc82Oyq/Xrh3Dn30rhg4t32lmA/YBuZPBE41p+
   CA596Ap+7TKyeqTyCXn1p3tiX1Sb2uPXV+mW9JVi66YceOdht0/4gIszA
   vKNWQ/lE1KFKBZfQ2FJh+2uPV1Zfz+N9t4MBL7rlPXGLkYD4OJF5Ayf9h
   563X6jxgaW4UXOnpEDyLCWEh+h2pHYWrKaIOSE4u4dIAoneMGvCyPrm6J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431574679"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431574679"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972743803"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972743803"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.93.66.152])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:55:15 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 2/4] RDMA/irdma: Refactor error handling in create CQP
Date:   Tue, 25 Jul 2023 10:55:03 -0500
Message-Id: <20230725155505.1069-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230725155505.1069-1-shiraz.saleem@intel.com>
References: <20230725155505.1069-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sindhu Devale <sindhu.devale@intel.com>

In case of a failure in irdma_create_cqp, do not call
irdma_destroy_cqp, but cleanup all the allocated resources
in reverse order.

Drop the extra argument in irdma_destroy_cqp as its no longer needed.

Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 795f7fd4f257..369eb6b6536d 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -567,7 +567,7 @@ static void irdma_destroy_irq(struct irdma_pci_f *rf,
  * Issue destroy cqp request and
  * free the resources associated with the cqp
  */
-static void irdma_destroy_cqp(struct irdma_pci_f *rf, bool free_hwcqp)
+static void irdma_destroy_cqp(struct irdma_pci_f *rf)
 {
 	struct irdma_sc_dev *dev = &rf->sc_dev;
 	struct irdma_cqp *cqp = &rf->cqp;
@@ -575,8 +575,8 @@ static void irdma_destroy_cqp(struct irdma_pci_f *rf, bool free_hwcqp)
 
 	if (rf->cqp_cmpl_wq)
 		destroy_workqueue(rf->cqp_cmpl_wq);
-	if (free_hwcqp)
-		status = irdma_sc_cqp_destroy(dev->cqp);
+
+	status = irdma_sc_cqp_destroy(dev->cqp);
 	if (status)
 		ibdev_dbg(to_ibdev(dev), "ERR: Destroy CQP failed %d\n", status);
 
@@ -920,8 +920,8 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 
 	cqp->scratch_array = kcalloc(sqsize, sizeof(*cqp->scratch_array), GFP_KERNEL);
 	if (!cqp->scratch_array) {
-		kfree(cqp->cqp_requests);
-		return -ENOMEM;
+		status = -ENOMEM;
+		goto err_scratch;
 	}
 
 	dev->cqp = &cqp->sc_cqp;
@@ -931,15 +931,14 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 	cqp->sq.va = dma_alloc_coherent(dev->hw->device, cqp->sq.size,
 					&cqp->sq.pa, GFP_KERNEL);
 	if (!cqp->sq.va) {
-		kfree(cqp->scratch_array);
-		kfree(cqp->cqp_requests);
-		return -ENOMEM;
+		status = -ENOMEM;
+		goto err_sq;
 	}
 
 	status = irdma_obj_aligned_mem(rf, &mem, sizeof(struct irdma_cqp_ctx),
 				       IRDMA_HOST_CTX_ALIGNMENT_M);
 	if (status)
-		goto exit;
+		goto err_ctx;
 
 	dev->cqp->host_ctx_pa = mem.pa;
 	dev->cqp->host_ctx = mem.va;
@@ -965,7 +964,7 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 	status = irdma_sc_cqp_init(dev->cqp, &cqp_init_info);
 	if (status) {
 		ibdev_dbg(to_ibdev(dev), "ERR: cqp init status %d\n", status);
-		goto exit;
+		goto err_ctx;
 	}
 
 	spin_lock_init(&cqp->req_lock);
@@ -976,7 +975,7 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 		ibdev_dbg(to_ibdev(dev),
 			  "ERR: cqp create failed - status %d maj_err %d min_err %d\n",
 			  status, maj_err, min_err);
-		goto exit;
+		goto err_ctx;
 	}
 
 	INIT_LIST_HEAD(&cqp->cqp_avail_reqs);
@@ -990,8 +989,16 @@ static int irdma_create_cqp(struct irdma_pci_f *rf)
 	init_waitqueue_head(&cqp->remove_wq);
 	return 0;
 
-exit:
-	irdma_destroy_cqp(rf, false);
+err_ctx:
+	dma_free_coherent(dev->hw->device, cqp->sq.size,
+			  cqp->sq.va, cqp->sq.pa);
+	cqp->sq.va = NULL;
+err_sq:
+	kfree(cqp->scratch_array);
+	cqp->scratch_array = NULL;
+err_scratch:
+	kfree(cqp->cqp_requests);
+	cqp->cqp_requests = NULL;
 
 	return status;
 }
@@ -1746,7 +1753,7 @@ void irdma_ctrl_deinit_hw(struct irdma_pci_f *rf)
 				      rf->reset, rf->rdma_ver);
 		fallthrough;
 	case CQP_CREATED:
-		irdma_destroy_cqp(rf, true);
+		irdma_destroy_cqp(rf);
 		fallthrough;
 	case INITIAL_STATE:
 		irdma_del_init_mem(rf);
-- 
1.8.3.1

