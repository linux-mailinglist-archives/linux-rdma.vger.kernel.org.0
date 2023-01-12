Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5366553F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jan 2023 08:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjAKHjm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Jan 2023 02:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjAKHjk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Jan 2023 02:39:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0C10FC1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Jan 2023 23:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673422779; x=1704958779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ses3ytISc0K20/28BQ2pR4CjmwnBq0s6iDODWz4JAiw=;
  b=m74qtsW2WXGqhhMjYqNrB2NIWkQPoJ9PYyztHBWgLQ7OEo57wKPWuSgl
   zH7Cft66FDN0OaYkp36SykC9JszBiknFWUqqnLD/jd63KOOBoZQbhz4Sb
   H9GGrcxESy0jsgpK7ZGBrFJ1ySS7zzMDi4ZyaqT1HDZIEo6uaLu6EAxii
   aB5i+jPbqAHLmNSttBetjfSV0mN3w17uJMurRFlywyFjpX3GfIrJENy1k
   4USRiyR/ANDrD1KDpbM5DsXrsYdDlnF9rwm994rmicIAYWtom4XyUkyyo
   fN2ZqBNoa3ddiszEFJx7C7EuAjp0nkMPAZnNj6FvzgWi9wCjuj9/8AjmN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303050040"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303050040"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 23:39:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659273401"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="659273401"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jan 2023 23:39:37 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCHv2 for-next 3/4] RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
Date:   Wed, 11 Jan 2023 19:06:16 -0500
Message-Id: <20230112000617.1659337-4-yanjun.zhu@intel.com>
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

Split the source codes related with QP handling into a new function.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 48 ++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f4712276b920..74dd1972c325 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2834,6 +2834,39 @@ static void irdma_free_iwmr(struct irdma_mr *iwmr)
 	kfree(iwmr);
 }
 
+static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
+				     struct ib_udata *udata,
+				     struct irdma_mr *iwmr)
+{
+	u32 total;
+	int err;
+	u8 shadow_pgcnt = 1;
+	bool use_pbles;
+	unsigned long flags;
+	struct irdma_ucontext *ucontext;
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
+	struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
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
@@ -2889,23 +2922,10 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
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
2.31.1

