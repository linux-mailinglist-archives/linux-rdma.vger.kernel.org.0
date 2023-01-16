Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73B66B5D6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 04:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjAPDG4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 22:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAPDGz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 22:06:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8E72B9
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 19:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673838414; x=1705374414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RWoHSJQZz+c1sR/jG/J8BSM+DceT39giVEwAhsyLy0=;
  b=IcOQ+h0Gw/MjwshCLrOb5fJHsFemeYNG3hPJ0WYWLTyQi0y2uyfRnZsd
   1bS1MpdbEmQ+SRQwJXGK0HmVvImZPA0UM7UwoJn3yiIrYVFsVbDe57iqO
   wPcSQ86M9DbZcRkwbdXmhj5vG2Ri/WTaDiDOwjcfNLIOTsTHuyuUoBwXB
   DZyD6t+kgYhmb5juVjVlK+IqgZ+M6GM/uS04BY8ITsmoSJ8PIsS+HOD2T
   Z1SEaXCcqutabwqvS74ToXkoe24spIE+l3kZWqskVQWnCYYTOPYoSMpJm
   mDs0GkuEpglj2WysHv6WKAWw0KXiGLbPzsekgVgCrs6dPT8r6dkszRMzD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386720781"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="386720781"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 19:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="660831295"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="660831295"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2023 19:06:52 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 for-next 1/4] RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
Date:   Mon, 16 Jan 2023 14:34:59 -0500
Message-Id: <20230116193502.66540-2-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230116193502.66540-1-yanjun.zhu@intel.com>
References: <20230116193502.66540-1-yanjun.zhu@intel.com>
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

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 82 ++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f4674ecf9c8c..45eb2d339802 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2745,6 +2745,54 @@ static int irdma_hwreg_mr(struct irdma_device *iwdev, struct irdma_mr *iwmr,
 	return ret;
 }
 
+static int irdma_reg_user_mr_type_mem(struct irdma_mr *iwmr, int access)
+{
+	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	bool use_pbles;
+	u32 stag;
+	int err;
+
+	use_pbles = iwmr->page_cnt != 1;
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
+		}
+	}
+
+	stag = irdma_create_stag(iwdev);
+	if (!stag) {
+		err = -ENOMEM;
+		goto free_pble;
+	}
+
+	iwmr->stag = stag;
+	iwmr->ibmr.rkey = stag;
+	iwmr->ibmr.lkey = stag;
+	err = irdma_hwreg_mr(iwdev, iwmr, access);
+	if (err)
+		goto err_hwreg;
+
+	return 0;
+
+err_hwreg:
+	irdma_free_stag(iwdev, stag);
+
+free_pble:
+	if (iwpbl->pble_alloc.level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
+		irdma_free_pble(iwdev->rf->pble_rsrc, &iwpbl->pble_alloc);
+
+	return err;
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2761,12 +2809,11 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
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
@@ -2817,7 +2864,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	}
 	iwmr->len = region->length;
 	iwpbl->user_base = virt;
-	palloc = &iwpbl->pble_alloc;
 	iwmr->type = req.reg_type;
 	iwmr->page_cnt = ib_umem_num_dma_blocks(region, iwmr->page_size);
 
@@ -2863,36 +2909,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
 		break;
 	case IRDMA_MEMREG_TYPE_MEM:
-		use_pbles = (iwmr->page_cnt != 1);
-
-		err = irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
+		err = irdma_reg_user_mr_type_mem(iwmr, access);
 		if (err)
 			goto error;
 
-		if (use_pbles) {
-			err = irdma_check_mr_contiguous(palloc,
-							iwmr->page_size);
-			if (err) {
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
@@ -2903,8 +2923,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return &iwmr->ibmr;
 
 error:
-	if (palloc->level != PBLE_LEVEL_0 && iwpbl->pbl_allocated)
-		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
 	ib_umem_release(region);
 	kfree(iwmr);
 
-- 
2.27.0

