Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E77F661CAA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 04:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjAID1Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Jan 2023 22:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAID1Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Jan 2023 22:27:24 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1E5F71
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 19:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673234843; x=1704770843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pP7SyOwEtcdheH39+XOlykZS/b1Bnwo6DSDMjs80pI=;
  b=PKjFXw+9RJFAHbxIpu7ZA9KdWLlTvALTvSLJQlAsXmYPHKWwOZ8BB9Vc
   IbjjaXY006S8wUvjeQQvuZxrQ+ufGuCK3mdh+BSlmEHmBctTgxL+Zdxly
   pY67zOf3tV0Ltdn9CrG2Vkl4hn24lVPL4jLYPRi62SARZpDVmdUHDFB+o
   5HDR3kXc1Dw7wNOMbzok2ZZCCJIFnWPelqwqPUAMWmfdQe1DqQOwKQDWL
   3qZXAm3dfRxRmWVw5v/KOiO0WHGrYZ9EKvel7b2Wzn6tSuRxd0uJCcT4F
   PyRiMLlaoTrKF6BEB7qhFi87TD6MQpPmrcJJVOwRiB8lZAKPmTAuegbhM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321487935"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321487935"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 19:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649882076"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649882076"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 19:27:17 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 3/4] RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
Date:   Mon,  9 Jan 2023 14:54:01 -0500
Message-Id: <20230109195402.1339737-4-yanjun.zhu@intel.com>
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

Split the source codes related with QP handling into a new function.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 48 ++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 287d4313f14d..e90eba73c396 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2831,6 +2831,39 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
 	kfree(iwmr);
 }
 
+static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
+				     struct irdma_device *iwdev,
+				     struct ib_udata *udata,
+				     struct irdma_mr *iwmr)
+{
+	u32 total;
+	int err = 0;
+	u8 shadow_pgcnt = 1;
+	bool use_pbles = false;
+	unsigned long flags;
+	struct irdma_ucontext *ucontext;
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+
+	total = req.sq_pages + req.rq_pages + shadow_pgcnt;
+	if (total > iwmr->page_cnt)
+		return -EINVAL;
+
+	total = req.sq_pages + req.rq_pages;
+	use_pbles = (total > 2);
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
+	return err;
+}
+
 /**
  * irdma_reg_user_mr - Register a user memory region
  * @pd: ptr of pd
@@ -2886,23 +2919,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
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
+		err = irdma_reg_user_mr_type_qp(req, iwdev, udata, iwmr);
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
2.31.1

