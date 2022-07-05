Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1F567A84
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiGEXI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGEXIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D95510D9
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062505; x=1688598505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tztno2/cWvplr0h8cF7pth6xAlEiRhzVk91Lq2CJMCo=;
  b=W+L0RV9zRMcNT2Wycf/j4FTnzP7pT958hu4c6dxdL4901mjmL9ujXINy
   FDoBo8h+dKRvcV1llw06YKmbR6VGEauCS763lixQ7G4UkoytRkmUUIOH9
   as2C2yc/YCaEn+Y+4/CLJU2XeG7e8QEk3zSuk6h55D0eTG5tPq/+rGBS9
   VwgbN8jZ3sWKDVU/WD0EugjXgnh38xUXfIUSNMNZjl5shORqwevkHshqO
   i8Lxo9FLC20ccH1cQmjDtcF2za7r//E8tFyAEiP6/pfqrD2PCowE266Qi
   /epdHWmVwRz3UYZhhvQF03J2JvJLM7nY8Cud9wSU8PpxlhqOwhg+GX5AI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588410"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588410"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047521"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:24 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 2/7] RDMA/irdma: Add AE source to error log
Date:   Tue,  5 Jul 2022 18:08:10 -0500
Message-Id: <20220705230815.265-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220705230815.265-1-shiraz.saleem@intel.com>
References: <20220705230815.265-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

To assist with debugging add the Asynchronous Event (AE) source when
logging the abnormal AE error log message.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index dd3943d..bb60431 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -376,8 +376,8 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 				ctx_info->iwarp_info->err_rq_idx_valid = false;
 			fallthrough;
 		default:
-			ibdev_err(&iwdev->ibdev, "abnormal ae_id = 0x%x bool qp=%d qp_id = %d\n",
-				  info->ae_id, info->qp, info->qp_cq_id);
+			ibdev_err(&iwdev->ibdev, "abnormal ae_id = 0x%x bool qp=%d qp_id = %d, ae_src=%d\n",
+				  info->ae_id, info->qp, info->qp_cq_id, info->ae_src);
 			if (rdma_protocol_roce(&iwdev->ibdev, 1)) {
 				if (!info->sq && ctx_info->roce_info->err_rq_idx_valid) {
 					ctx_info->roce_info->err_rq_idx = info->wqe_idx;
-- 
1.8.3.1

