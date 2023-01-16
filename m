Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63966B5D9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 04:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjAPDHL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 22:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjAPDHC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 22:07:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E776AE
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 19:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673838421; x=1705374421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DDecRzImF4YUUMs2sZpFsBxS6o3DonGcFzq5A7MARg=;
  b=lhQ5N0HRbDb7iSwXT0vOGY4fSH+JztJz1B2hiG5Z+20CReEDhrxgZ+rZ
   aOH7JYXWT7DBF48JJccVi1lccgYS9bqCo28RiHMqosxzSW3Ddocp/PChv
   Vflylft3+NTL6LkeAaEJNrWg0k2ZuBpRgElGBCPN/iEt1rDsih94sq3LG
   101L1OUTwXLBlpx6fpnGgpo7RoJxtWD558yJyidyJ5oOZSKW3NSyth0wk
   oVqus6GhTcK1D/0lsyW2/p6RK8vbsKXkBhUGJ0GXFghsXBd6vHc4JbK94
   pkv3J/PD+ES3jErDQkvg3OGzF4c3u5ekbC9hTRH2YPbgvaSvqGTVHSK7t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386720800"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="386720800"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 19:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="660831313"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="660831313"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2023 19:06:58 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 for-next 4/4] RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
Date:   Mon, 16 Jan 2023 14:35:02 -0500
Message-Id: <20230116193502.66540-5-yanjun.zhu@intel.com>
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

Split the source codes related with CQ handling into a new function.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 69 +++++++++++++++++------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 93a8997d6267..6982f38596c8 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2867,6 +2867,40 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
 	return 0;
 }
 
+static int irdma_reg_user_mr_type_cq(struct irdma_mem_reg_req req,
+				     struct ib_udata *udata,
+				     struct irdma_mr *iwmr)
+{
+	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	struct irdma_ucontext *ucontext = NULL;
+	u8 shadow_pgcnt = 1;
+	unsigned long flags;
+	bool use_pbles;
+	u32 total;
+	int err;
+
+	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
+		shadow_pgcnt = 0;
+	total = req.cq_pages + shadow_pgcnt;
+	if (total > iwmr->page_cnt)
+		return -EINVAL;
+
+	use_pbles = req.cq_pages > 1;
+	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+	if (err)
+		return err;
+
+	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
+					     ibucontext);
+	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
+	list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
+	iwpbl->on_list = true;
+	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
+
+	return 0;
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2882,16 +2916,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 {
 #define IRDMA_MEM_REG_MIN_REQ_LEN offsetofend(struct irdma_mem_reg_req, sq_pages)
 	struct irdma_device *iwdev = to_iwdev(pd->device);
-	struct irdma_ucontext *ucontext;
-	struct irdma_pbl *iwpbl;
-	struct irdma_mr *iwmr;
-	struct ib_umem *region;
-	struct irdma_mem_reg_req req;
-	u32 total;
-	u8 shadow_pgcnt = 1;
-	bool use_pbles = false;
-	unsigned long flags;
-	int err = -EINVAL;
+	struct irdma_mem_reg_req req = {};
+	struct ib_umem *region = NULL;
+	struct irdma_mr *iwmr = NULL;
+	int err;
 
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
@@ -2918,8 +2946,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return (struct ib_mr *)iwmr;
 	}
 
-	iwpbl = &iwmr->iwpbl;
-
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
 		err = irdma_reg_user_mr_type_qp(req, udata, iwmr);
@@ -2928,25 +2954,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 		break;
 	case IRDMA_MEMREG_TYPE_CQ:
-		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
-			shadow_pgcnt = 0;
-		total = req.cq_pages + shadow_pgcnt;
-		if (total > iwmr->page_cnt) {
-			err = -EINVAL;
-			goto error;
-		}
-
-		use_pbles = (req.cq_pages > 1);
-		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+		err = irdma_reg_user_mr_type_cq(req, udata, iwmr);
 		if (err)
 			goto error;
-
-		ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
-						     ibucontext);
-		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
-		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
-		iwpbl->on_list = true;
-		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
 		break;
 	case IRDMA_MEMREG_TYPE_MEM:
 		err = irdma_reg_user_mr_type_mem(iwmr, access);
@@ -2955,6 +2965,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 		break;
 	default:
+		err = -EINVAL;
 		goto error;
 	}
 
-- 
2.27.0

