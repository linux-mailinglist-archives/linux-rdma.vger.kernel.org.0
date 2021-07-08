Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64B23BE99B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 16:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhGGO1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 10:27:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:10995 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231643AbhGGO1f (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Jul 2021 10:27:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196479150"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="196479150"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 07:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="497955928"
Received: from unknown (HELO intel-86.bj.intel.com) ([10.238.154.86])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2021 07:24:52 -0700
From:   yanjun.zhu@linux.dev
To:     yanjun.zhu@linux.dev, zyjzyj2000@gmail.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: [PATCH 1/1] RDMA/irdma: change the returned type to void
Date:   Thu,  8 Jul 2021 02:47:52 -0400
Message-Id: <20210708064752.797520-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Since the function irdma_sc_parse_fpm_commit_buf always returns 0,
remove the returned value check and change the returned type to void.

Fixes: 3f49d6842569 ("RDMA/irdma: Implement HW Admin Queue OPs")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/hw/irdma/ctrl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index b1023a7d0bd1..c3880a85e255 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -2845,7 +2845,7 @@ static u64 irdma_sc_decode_fpm_commit(struct irdma_sc_dev *dev, __le64 *buf,
  * parses fpm commit info and copy base value
  * of hmc objects in hmc_info
  */
-static enum irdma_status_code
+static void
 irdma_sc_parse_fpm_commit_buf(struct irdma_sc_dev *dev, __le64 *buf,
 			      struct irdma_hmc_obj_info *info, u32 *sd)
 {
@@ -2915,7 +2915,6 @@ irdma_sc_parse_fpm_commit_buf(struct irdma_sc_dev *dev, __le64 *buf,
 	else
 		*sd = (u32)(size >> 21);
 
-	return 0;
 }
 
 /**
@@ -4434,9 +4433,9 @@ static enum irdma_status_code irdma_sc_cfg_iw_fpm(struct irdma_sc_dev *dev,
 	ret_code = irdma_sc_commit_fpm_val(dev->cqp, 0, hmc_info->hmc_fn_id,
 					   &commit_fpm_mem, true, wait_type);
 	if (!ret_code)
-		ret_code = irdma_sc_parse_fpm_commit_buf(dev, dev->fpm_commit_buf,
-							 hmc_info->hmc_obj,
-							 &hmc_info->sd_table.sd_cnt);
+		irdma_sc_parse_fpm_commit_buf(dev, dev->fpm_commit_buf,
+					      hmc_info->hmc_obj,
+					      &hmc_info->sd_table.sd_cnt);
 	print_hex_dump_debug("HMC: COMMIT FPM BUFFER", DUMP_PREFIX_OFFSET, 16,
 			     8, commit_fpm_mem.va, IRDMA_COMMIT_FPM_BUF_SIZE,
 			     false);
-- 
2.27.0

