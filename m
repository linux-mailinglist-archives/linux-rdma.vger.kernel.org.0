Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F2E66553E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 08:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjAKHjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 02:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjAKHji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 02:39:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144610FC1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673422778; x=1704958778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7s6sRHs2FlM25JGTaD0dDTQp3TtGyJdtyaFG5yVvbQ=;
  b=XRxM0frM7yVBHRoETwRDnKJSxw0ncimsokaz2m6czjN/flaoZDusdMd6
   TeY1asLL4BxkDNGqVnzQIJF0yekcAiDJcdsfamlF7yegZXqFocb/KQWB7
   2YwEswLehWpXNx4h3O0jxSXVKCrYD2QJ/WdmrmEzaadBHIi60q+2v73Fn
   ss9CIzj3LVjh0hzWBH1fMr/Iqdy4CT9G1kw9EOcMfAYu59wF9NK6reiZ1
   VVpIKGHSkRcy1bfwruqgEwW8jMiCrBmBrwNcAzfR+ln3zZmj/HIxaRoq8
   NaBaHV3noYfIacwk3s8xW10HhbYLi8mZVtyrMGvulLiF5xFrK075I//+x
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303050032"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303050032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 23:39:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659273384"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659273384"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2023 23:39:35 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv2 for-next 2/4] RDMA/irdma: Split mr alloc and free into new functions
Date:   Wed, 11 Jan 2023 19:06:15 -0500
Message-Id: <20230112000617.1659337-3-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230112000617.1659337-1-yanjun.zhu@intel.com>
References: <20230112000617.1659337-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the function irdma_reg_user_mr, the mr allocation and free
will be used by other functions. As such, the source codes related
with mr allocation and free are split into the new functions.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 74 ++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b67c14aac0f2..f4712276b920 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2792,6 +2792,48 @@ static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
 	return err;
 }
 
+static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
+					 struct ib_pd *pd, u64 virt,
+					 enum irdma_memreg_type reg_type)
+{
+	struct irdma_mr *iwmr;
+	struct irdma_pbl *iwpbl;
+	struct irdma_device *iwdev = to_iwdev(pd->device);
+	unsigned long pgsz_bitmap;
+
+	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
+	if (!iwmr)
+		return ERR_PTR(-ENOMEM);
+
+	iwpbl = &iwmr->iwpbl;
+	iwpbl->iwmr = iwmr;
+	iwmr->region = region;
+	iwmr->ibmr.pd = pd;
+	iwmr->ibmr.device = pd->device;
+	iwmr->ibmr.iova = virt;
+	iwmr->type = reg_type;
+
+	pgsz_bitmap = (reg_type == IRDMA_MEMREG_TYPE_MEM) ?
+		iwdev->rf->sc_dev.hw_attrs.page_size_cap : PAGE_SIZE;
+
+	iwmr->page_size = ib_umem_find_best_pgsz(region, pgsz_bitmap, virt);
+	if (unlikely(!iwmr->page_size)) {
+		kfree(iwmr);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	iwmr->len = region->length;
+	iwpbl->user_base = virt;
+	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
+
+	return iwmr;
+}
+
+static void irdma_free_iwmr(struct irdma_mr *iwmr)
+{
+	kfree(iwmr);
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2837,34 +2879,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return ERR_PTR(-EFAULT);
 	}
 
-	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
-	if (!iwmr) {
+	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type);
+	if (IS_ERR(iwmr)) {
 		ib_umem_release(region);
-		return ERR_PTR(-ENOMEM);
+		return (struct ib_mr *)iwmr;
 	}
 
 	iwpbl = &iwmr->iwpbl;
-	iwpbl->iwmr = iwmr;
-	iwmr->region = region;
-	iwmr->ibmr.pd = pd;
-	iwmr->ibmr.device = pd->device;
-	iwmr->ibmr.iova = virt;
-	iwmr->page_size = PAGE_SIZE;
-
-	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
-		iwmr->page_size = ib_umem_find_best_pgsz(region,
-							 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
-							 virt);
-		if (unlikely(!iwmr->page_size)) {
-			kfree(iwmr);
-			ib_umem_release(region);
-			return ERR_PTR(-EOPNOTSUPP);
-		}
-	}
-	iwmr->len = region->length;
-	iwpbl->user_base = virt;
-	iwmr->type = req.reg_type;
-	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
 
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
@@ -2917,13 +2938,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		goto error;
 	}
 
-	iwmr->type = req.reg_type;
-
 	return &iwmr->ibmr;
-
 error:
 	ib_umem_release(region);
-	kfree(iwmr);
+	irdma_free_iwmr(iwmr);
 
 	return ERR_PTR(err);
 }
-- 
2.31.1

