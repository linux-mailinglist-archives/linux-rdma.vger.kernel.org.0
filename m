Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7B661CA9
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 04:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjAID1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Jan 2023 22:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjAID1T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Jan 2023 22:27:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD35F88
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 19:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673234838; x=1704770838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pYaNJkEeFaIKWxO+2PWXwvoGZcz6FH7q7/PzNTCPpGs=;
  b=HMAKphiv/wV5c5o+AutIGoypX1TMOuFuH0VTV8X+f+VZSiOAZY+Ayzoo
   +lF1YYPQTOkFkfSU5VMsY6T2bTlcMIvnEnbXzoDbgDfBF4An1bE++ukPV
   mFzZrN31+ZPb1QVLD3taNPxQCdfzJZ/Cq5mBv4xKt45xRljHUFGnBx++5
   sjm4RzAUzoOgASmnTEo4v1RQ9ldT+3fYre7XMuSg+NBZ7PbZcj6H4ETNM
   3B7NDwX0tGL5bA2iara99KAjEl4zjeltzLgmMlvsWjSlTw28uWywbEjq0
   4zUI7FAcba1xTZk5cPiI+oFwuSjj19odmPZC20G1hJWN+POjoE9Lx0ORC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321487930"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321487930"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 19:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649882068"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649882068"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 19:27:14 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 2/4] RDMA/irdma: Split mr alloc and free into new functions
Date:   Mon,  9 Jan 2023 14:54:00 -0500
Message-Id: <20230109195402.1339737-3-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230109195402.1339737-1-yanjun.zhu@intel.com>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 drivers/infiniband/hw/irdma/verbs.c | 78 ++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 40109da6489a..5cff8656d79e 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2794,6 +2794,52 @@ static int irdma_reg_user_mr_type_mem(struct irdma_device *iwdev,
 	return err;
 }
 
+static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
+					 struct ib_pd *pd, u64 virt,
+					 __u16 reg_type,
+					 struct irdma_device *iwdev)
+{
+	struct irdma_mr *iwmr;
+	struct irdma_pbl *iwpbl;
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
+	iwmr->page_size = PAGE_SIZE;
+	iwmr->type = reg_type;
+
+	if (reg_type == IRDMA_MEMREG_TYPE_MEM) {
+		iwmr->page_size = ib_umem_find_best_pgsz(region,
+							 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
+							 virt);
+		if (unlikely(!iwmr->page_size)) {
+			kfree(iwmr);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	}
+
+	iwmr->len = region->length;
+	iwpbl->user_base = virt;
+	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
+
+	return iwmr;
+}
+
+/*
+ * This function frees the resources from irdma_alloc_iwmr
+ */
+static void irdma_free_iwmr(struct irdma_mr *iwmr)
+{
+	kfree(iwmr);
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2839,34 +2885,13 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return ERR_PTR(-EFAULT);
 	}
 
-	iwmr = kzalloc(sizeof(*iwmr), GFP_KERNEL);
-	if (!iwmr) {
+	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type, iwdev);
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
@@ -2918,13 +2943,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
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
2.27.0

