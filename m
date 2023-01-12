Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A2665541
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjAKHjq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 02:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjAKHjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 02:39:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C21146A
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 23:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673422782; x=1704958782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfWjSzZMq0MgxI64sQZupQ6mJA+8AJceTxRER8jmzRM=;
  b=H+Pm5sYGjCpLaSySLXxm9Um2IfYtJ0TX0CiRM9IjCZmtk6BNq1I3BQio
   tTao+FPVzRZpwQhFbwmX+TMUzKuMzlj1CeJbADOeUeJyNWRvL9zuttwGr
   1L+bdewT6xFUuxuAjMK7V48sMKdv2N5o7P/BEyXQg0u241NthMMrao7/0
   6qSiViRCap4ITnmtkhUtortv1ks9Q4UgxgD1beLKOdTxKl8UOnneuvJqZ
   0wgx/3503ajg2+nWueoKK2rk8raLXZRIXS0eUCyzE9PYoL9Iz/4dEvvIo
   KtcTgHQbvFqvsuXrg0lna9xcvFGRxOKXcPskonk2jkMGxouQCrKU4Q93S
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303050053"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303050053"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 23:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659273411"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659273411"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2023 23:39:39 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv2 for-next 4/4] RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
Date:   Wed, 11 Jan 2023 19:06:17 -0500
Message-Id: <20230112000617.1659337-5-yanjun.zhu@intel.com>
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

Split the source codes related with CQ handling into a new function.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 63 +++++++++++++++++------------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 74dd1972c325..3902c74d59f2 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2867,6 +2867,40 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
 	return err;
 }
 
+static int irdma_reg_user_mr_type_cq(struct irdma_mem_reg_req req,
+				     struct ib_udata *udata,
+				     struct irdma_mr *iwmr)
+{
+	int err;
+	u8 shadow_pgcnt = 1;
+	bool use_pbles;
+	struct irdma_ucontext *ucontext;
+	unsigned long flags;
+	u32 total;
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+
+	if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
+		shadow_pgcnt = 0;
+	total = req.cq_pages + shadow_pgcnt;
+	if (total > iwmr->page_cnt)
+		return -EINVAL;
+
+	use_pbles = (req.cq_pages > 1);
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
+	return err;
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
 	struct irdma_mr *iwmr;
 	struct ib_umem *region;
 	struct irdma_mem_reg_req req;
-	u32 total;
-	u8 shadow_pgcnt = 1;
-	bool use_pbles = false;
-	unsigned long flags;
-	int err = -EINVAL;
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
2.31.1

