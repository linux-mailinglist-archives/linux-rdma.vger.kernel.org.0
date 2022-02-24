Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6354C2192
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiBXCIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiBXCIe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:08:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F131B370F
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:08:05 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315356356"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315356356"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268950"
Received: from intel-obmc.bj.intel.com (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by fmsmga004.fm.intel.com with ESMTP; 23 Feb 2022 18:08:03 -0800
From:   yanjun.zhu@linux.dev
To:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev, leon@kernel.org
Subject: [PATCHv2 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Date:   Thu, 24 Feb 2022 13:28:32 -0500
Message-Id: <20220224182832.3896686-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The function irdma_create_mg_ctx always returns 0,
so make it void and delete the return value check.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
V1->V2: Remove the unused ret_code and rebase to the commit 2322d17abf0a
        ("RDMA/irdma: Remove excess error variables")
---
 drivers/infiniband/hw/irdma/uda.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/uda.c b/drivers/infiniband/hw/irdma/uda.c
index 7a9988ddbd01..a247ae3142d9 100644
--- a/drivers/infiniband/hw/irdma/uda.c
+++ b/drivers/infiniband/hw/irdma/uda.c
@@ -86,8 +86,7 @@ enum irdma_status_code irdma_sc_access_ah(struct irdma_sc_cqp *cqp,
  * irdma_create_mg_ctx() - create a mcg context
  * @info: multicast group context info
  */
-static enum irdma_status_code
-irdma_create_mg_ctx(struct irdma_mcast_grp_info *info)
+static void irdma_create_mg_ctx(struct irdma_mcast_grp_info *info)
 {
 	struct irdma_mcast_grp_ctx_entry_info *entry_info = NULL;
 	u8 idx = 0; /* index in the array */
@@ -106,8 +105,6 @@ irdma_create_mg_ctx(struct irdma_mcast_grp_info *info)
 			ctx_idx++;
 		}
 	}
-
-	return 0;
 }
 
 /**
@@ -122,7 +119,6 @@ enum irdma_status_code irdma_access_mcast_grp(struct irdma_sc_cqp *cqp,
 					      u32 op, u64 scratch)
 {
 	__le64 *wqe;
-	enum irdma_status_code ret_code = 0;
 
 	if (info->mg_id >= IRDMA_UDA_MAX_FSI_MGS) {
 		ibdev_dbg(to_ibdev(cqp->dev), "WQE: mg_id out of range\n");
@@ -135,9 +131,7 @@ enum irdma_status_code irdma_access_mcast_grp(struct irdma_sc_cqp *cqp,
 		return IRDMA_ERR_RING_FULL;
 	}
 
-	ret_code = irdma_create_mg_ctx(info);
-	if (ret_code)
-		return ret_code;
+	irdma_create_mg_ctx(info);
 
 	set_64bit_val(wqe, 32, info->dma_mem_mc.pa);
 	set_64bit_val(wqe, 16,
-- 
2.27.0

