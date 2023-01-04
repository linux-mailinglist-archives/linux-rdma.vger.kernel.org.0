Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D265C1B1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 15:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjACORD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 09:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjACOQj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 09:16:39 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF46120AE
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672755386; x=1704291386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Hx7x2chCKdqX5H74YgBnQnXdtDIGKD65cL5NYH9was=;
  b=RTnxd6+XyeeYDP1hjnHT3eElcJohkwjkx6g/kXaBDJs+YkorGc2zEuNW
   MG4Nhk4u6TO26XMQuEJ9Y5vsez43A+9CIjRrK5nZi8CFdHbeG34dQkjdE
   IpYAwj4qaJ22ixs0KCvSTyIEvQdazaq6QYE/mDwdgOyJzxSRiLAMC897r
   5nj4CXx9zpXl3KtnzqDE9VxOHQvm3QfdMiIPrVxPTWjaOZTSLWeqzSpdj
   1SeIOTSBeO/z54NXDB3+3WwFOXshgs2YVoOULzVszsSMKaHKziGA6eHMM
   onl/EdvXJNVg/5jd9/dwt4iLYxc11eOKkxE4nnbeILtfLyKMQNNF1H8kG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="309436429"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="309436429"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 06:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="983578380"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="983578380"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2023 06:16:23 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH for-next 1/1] RDMA/irdma: One variable err is enough
Date:   Wed,  4 Jan 2023 01:43:33 -0500
Message-Id: <20230104064333.660344-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the function irdma_reg_user_mr, err and ret exist. Actually,
one variable err is enough.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/verbs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f6973ea55eda..f4674ecf9c8c 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2771,7 +2771,6 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	bool use_pbles = false;
 	unsigned long flags;
 	int err = -EINVAL;
-	int ret;
 
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
@@ -2871,9 +2870,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 			goto error;
 
 		if (use_pbles) {
-			ret = irdma_check_mr_contiguous(palloc,
+			err = irdma_check_mr_contiguous(palloc,
 							iwmr->page_size);
-			if (ret) {
+			if (err) {
 				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
 				iwpbl->pbl_allocated = false;
 			}
-- 
2.34.1

