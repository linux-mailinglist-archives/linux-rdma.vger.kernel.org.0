Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573A66B5D8
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 04:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjAPDHI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 22:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjAPDG7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 22:06:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36987A87
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 19:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673838418; x=1705374418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulhP45X6VWqGzegBjojQgNrezNWcJtQVEwYWDPKdcsI=;
  b=LSoGDhoVyXFtN8UfWFM3zvxR8BVulAW5ihsuv/XBC8leMdv/cz+Z1ell
   4wcY2mjWJaglyLT/kcYfOFnKdqX7gLbnh9Ky1at7Sm7OABejgAdppwlP6
   1PSObsQWbWWr6EfahnSvVJqUVS0c/mCvK3kvC6YWObCAQLjQ2MV0wyjCb
   CFUCQtWODFNLGZ1kxQAgxdvrfCmrmqGBRgN5Mm8/bhSCqQYNF9gE4H1CY
   +QrBxWT1a8mKGr+e48Rxpgl9I89Sh+up6FmlPJVAGO4jTL7Z7g2hkvpAP
   CFHunoYkp3DOiXiVT6L0D9HvfXRpPzUJK/DpEfHj+gdiiX+fGYXjqjPgh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="386720792"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="386720792"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 19:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="660831306"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="660831306"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2023 19:06:56 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv3 for-next 3/4] RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
Date:   Mon, 16 Jan 2023 14:35:01 -0500
Message-Id: <20230116193502.66540-4-yanjun.zhu@intel.com>
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

Split the source codes related with QP handling into a new function.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 47 ++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 1fc9761beef4..93a8997d6267 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2835,6 +2835,38 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
 	kfree(iwmr);
 }
 
+static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
+				     struct ib_udata *udata,
+				     struct irdma_mr *iwmr)
+{
+	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	struct irdma_ucontext *ucontext = NULL;
+	unsigned long flags;
+	bool use_pbles;
+	u32 total;
+	int err;
+
+	total = req.sq_pages + req.rq_pages + 1;
+	if (total > iwmr->page_cnt)
+		return -EINVAL;
+
+	total = req.sq_pages + req.rq_pages;
+	use_pbles = total > 2;
+	err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+	if (err)
+		return err;
+
+	ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
+					     ibucontext);
+	spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
+	list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
+	iwpbl->on_list = true;
+	spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
+
+	return 0;
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2890,23 +2922,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
-		total = req.sq_pages + req.rq_pages + shadow_pgcnt;
-		if (total > iwmr->page_cnt) {
-			err = -EINVAL;
-			goto error;
-		}
-		total = req.sq_pages + req.rq_pages;
-		use_pbles = (total > 2);
-		err = irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
+		err = irdma_reg_user_mr_type_qp(req, udata, iwmr);
 		if (err)
 			goto error;
 
-		ucontext = rdma_udata_to_drv_context(udata, struct irdma_ucontext,
-						     ibucontext);
-		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
-		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
-		iwpbl->on_list = true;
-		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
 		break;
 	case IRDMA_MEMREG_TYPE_CQ:
 		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE_CQ_RESIZE)
-- 
2.27.0

