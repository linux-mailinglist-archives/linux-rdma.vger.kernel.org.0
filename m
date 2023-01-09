Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31484661CA8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 04:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjAID1Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Jan 2023 22:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjAID1P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Jan 2023 22:27:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B3559D
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673234834; x=1704770834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D5TOZ1AOPJ7hgU++8UqITuibbNA0kpi+Nu3NUol/muI=;
  b=JZmr7IbB36xXUDgyV7i0dRxhZ9bHy7/xhfZfb0DtBt4QXxYxhjBdhRXI
   vRYC0wT7BAKWc935yX535vxxjT8MHZJa74PgztwrEIvubAydnImhaSDUv
   cKoO9rsRfbhzwAIf9kBcC2RCWLkzv5pWWVatRF/aw7v3+DrzpZEi2z9jA
   8Ux+y11ODgzCnq8vR9jbUNioadbh/EFjjuQ2c2nW23GQZ5oPjQvGAw1f3
   gj7qBK7TOLBr6EYrgykoV2qgpDU2NjpHxTMrYFx+PI13vP5G7wpUzzeVZ
   eVapAHhnbvN6I5hRc4nlwGqNBm5uwqSTcwA7Q57032BFDsOnzajiHRB2z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321487923"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321487923"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 19:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649882054"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649882054"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 19:27:11 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 1/4] RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
Date:   Mon,  9 Jan 2023 14:53:59 -0500
Message-Id: <20230109195402.1339737-2-yanjun.zhu@intel.com>
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

The source codes related with IRDMA_MEMREG_TYPE_MEM are split
into a new function irdma_reg_user_mr_type_mem.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 85 +++++++++++++++++------------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f6973ea55eda..40109da6489a 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2745,6 +2745,55 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	return ret;
 }
 
+static int irdma_reg_user_mr_type_mem(struct irdma_device *iwdev,
+				      struct irdma_mr *iwmr, int access)
+{
+	int err = 0;
+	bool use_pbles = false;
+	u32 stag = 0;
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+
+	use_pbles = (iwmr->page_cnt != 1);
+
+	err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
+	if (err)
+		return err;
+
+	if (use_pbles) {
+		err = irdma_check_mr_contiguous(&iwpbl->pble_alloc,
+						iwmr->page_size);
+		if (err) {
+			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
+			iwpbl->pbl_allocated = false;
+			return err;
+		}
+	}
+
+	stag = irdma_create_stag(iwdev);
+	if (!stag) {
+		if (use_pbles) {
+			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
+			iwpbl->pbl_allocated = false;
+		}
+		return -ENOMEM;
+	}
+
+	iwmr->stag = stag;
+	iwmr->ibmr.rkey = stag;
+	iwmr->ibmr.lkey = stag;
+	err = irdma_hwreg_mr(iwdev, iwmr, access);
+	if (err) {
+		irdma_free_stag(iwdev, stag);
+		if (use_pbles) {
+			irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
+			iwpbl->pbl_allocated = false;
+		}
+		return err;
+	}
+
+	return err;
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2761,17 +2810,15 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 #define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct irdma_ucontext *ucontext;
-	struct irdma_pble_alloc *palloc;
 	struct irdma_pbl *iwpbl;
 	struct irdma_mr *iwmr;
 	struct ib_umem *region;
 	struct irdma_mem_reg_req req;
-	u32 total, stag = 0;
+	u32 total;
 	u8 shadow_pgcnt = 1;
 	bool use_pbles = false;
 	unsigned long flags;
 	int err = -EINVAL;
-	int ret;
 
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
@@ -2818,7 +2865,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	}
 	iwmr->len = region->length;
 	iwpbl->user_base = virt;
-	palloc = &iwpbl->pble_alloc;
 	iwmr->type = req.reg_type;
 	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
 
@@ -2864,36 +2910,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
 		break;
 	case IRDMA_MEMREG_TYPE_MEM:
-		use_pbles = (iwmr->page_cnt != 1);
-
-		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
+		err = irdma_reg_user_mr_type_mem(iwdev, iwmr, access);
 		if (err)
 			goto error;
-
-		if (use_pbles) {
-			ret = irdma_check_mr_contiguous(palloc,
-							iwmr->page_size);
-			if (ret) {
-				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
-				iwpbl->pbl_allocated = false;
-			}
-		}
-
-		stag = irdma_create_stag(iwdev);
-		if (!stag) {
-			err = -ENOMEM;
-			goto error;
-		}
-
-		iwmr->stag = stag;
-		iwmr->ibmr.rkey = stag;
-		iwmr->ibmr.lkey = stag;
-		err = irdma_hwreg_mr(iwdev, iwmr, access);
-		if (err) {
-			irdma_free_stag(iwdev, stag);
-			goto error;
-		}
-
 		break;
 	default:
 		goto error;
@@ -2904,8 +2923,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return &iwmr->ibmr;
 
 error:
-	if (palloc->level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
-		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
 	ib_umem_release(region);
 	kfree(iwmr);
 
-- 
2.27.0

