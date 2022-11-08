Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E923F621972
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Nov 2022 17:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiKHQcn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Nov 2022 11:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiKHQck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Nov 2022 11:32:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E358BC8
        for <linux-rdma@vger.kernel.org>; Tue,  8 Nov 2022 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667925159; x=1699461159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rY0b3gUYT1pVD9EDue2NvVQdHbOY8BxOiJ9OjBAgANo=;
  b=e3GFmuxu25pmUWz5zWIuYbaTvHj01CENUTB5tNQ5mZ63gp4u0NEM0Lmm
   HqRj6H+LUMAbfAS/V8ebx6L4vLMC9vo0LUW5P54cY6dK7w8qDisisAXge
   SG1sn/5t0VNTYbxgwvtQHLjqWKcSgIX6on84dNIcNozn23jEPnSW8rt//
   UCBPeNg/qC0zBKVWsQzKBA2JbOb433S6GjClz49+R9R1Xg/7MQzSrSYFX
   2elwEM9hvoqSMd1MVIRYUJao208TqlbyUUdzyfxfZoUAYlAYRuEspSchY
   fxijwlbZQeaXl+08kHKr9LB9zehVAgC3zEzyAsiv02ha+2CEXwXcclla/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="308362504"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="308362504"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:32:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881573196"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="881573196"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.34.193])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:30:53 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v1 for-next 3/3] RDMA/irdma: Do not request 2-level PBLEs for CQ alloc
Date:   Tue,  8 Nov 2022 10:29:58 -0600
Message-Id: <20221108162958.1227-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20221108162958.1227-1-shiraz.saleem@intel.com>
References: <20221108162958.1227-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

When allocating PBLE's for a large CQ, it is possible
that a 2-level PBLE is returned which would cause the
CQ allocation to fail since 1-level is assumed and checked for.
Fix this by requesting a level one PBLE only.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 66406726..e902766 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2358,9 +2358,10 @@ static bool irdma_check_mr_contiguous(struct irdma_pble_alloc *palloc,
  * @rf: RDMA PCI function
  * @iwmr: mr pointer for this memory registration
  * @use_pbles: flag if to use pble's
+ * @lvl_1_only: request only level 1 pble if true
  */
 static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
-			     bool use_pbles)
+			     bool use_pbles, bool lvl_1_only)
 {
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
 	struct irdma_pble_alloc *palloc = &iwpbl->pble_alloc;
@@ -2371,7 +2372,7 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 
 	if (use_pbles) {
 		status = irdma_get_pble(rf->pble_rsrc, palloc, iwmr->page_cnt,
-					false);
+					lvl_1_only);
 		if (status)
 			return status;
 
@@ -2414,16 +2415,10 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	bool ret = true;
 
 	pg_size = iwmr->page_size;
-	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
+	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, true);
 	if (err)
 		return err;
 
-	if (use_pbles && palloc->level != PBLE_LEVEL_1) {
-		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
-		iwpbl->pbl_allocated = false;
-		return -ENOMEM;
-	}
-
 	if (use_pbles)
 		arr = palloc->level1.addr;
 
@@ -2899,7 +2894,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	case IRDMA_MEMREG_TYPE_MEM:
 		use_pbles = (iwmr->page_cnt != 1);
 
-		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles);
+		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
 		if (err)
 			goto error;
 
-- 
1.8.3.1

