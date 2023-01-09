Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC7661CAB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 04:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjAID11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 8 Jan 2023 22:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbjAID1Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 8 Jan 2023 22:27:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11175F82
        for <linux-rdma@vger.kernel.org>; Sun,  8 Jan 2023 19:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673234843; x=1704770843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wsxyWyMWTKYezzOZhlbRwR5H2gMsE2FpVFvBGup9yvQ=;
  b=g0m1dmi/JORXjI1MvTeGfQK/exPUXxcqgb3HeDfVvOzm93Z/D2kLYORl
   MlCdUdjNQtHxvjINhoSz9r1OgVRwnb9fpyii2WBDKOF/eLDEpvzt1UBza
   HaSYhFWkp3gb1yc3yTTyiXxk44AP7SUjw7uhoMpo5Y/R2e2NJNVigIGmL
   HID39dkSVxrGFvrJmEH+l/diz9zKza4OEcm253DyZhSAES15MUozelvoK
   0D8WOUQmf4csppGeueDzRyIPRQvVuLW30qF7rMrnYrFBMwZ9WWe2chH1F
   Bee22cOWUzfsnYZwHKTH30VOJQ3uxjGvhEOiSX1toVA8NLyFkXI2e52Ml
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="321487939"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321487939"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 19:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="649882081"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="649882081"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2023 19:27:19 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 4/4] RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
Date:   Mon,  9 Jan 2023 14:54:02 -0500
Message-Id: <20230109195402.1339737-5-yanjun.zhu@intel.com>
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

Split the source codes related with CQ handling into a new function.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 60 +++++++++++++++++------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e90eba73c396..b4befbafb830 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2864,6 +2864,40 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
 	return err;
 }
 
+static int irdma_reg_user_mr_type_cq(struct irdma_device *iwdev,
+				     struct irdma_mr *iwmr,
+				     struct ib_udata *udata,
+				     struct irdma_mem_reg_req req)
+{
+	int err = 0;
+	u8 shadow_pgcnt = 1;
+	bool use_pbles = false;
+	struct irdma_ucontext *ucontext;
+	unsigned long flags;
+	u32 total;
+	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
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
@@ -2879,15 +2913,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
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
 	int err = -EINVAL;
 
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
@@ -2915,8 +2943,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		return (struct ib_mr *)iwmr;
 	}
 
-	iwpbl = &iwmr->iwpbl;
-
 	switch (req.reg_type) {
 	case IRDMA_MEMREG_TYPE_QP:
 		err = irdma_reg_user_mr_type_qp(req, iwdev, udata, iwmr);
@@ -2925,25 +2951,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
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
+		err = irdma_reg_user_mr_type_cq(iwdev, iwmr, udata, req);
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
 		err = irdma_reg_user_mr_type_mem(iwdev, iwmr, access);
-- 
2.31.1

