Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F3D3B0BE1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFVRz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 13:55:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:40104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhFVRz0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 13:55:26 -0400
IronPort-SDR: XYXKgmzwGEDmHTtDxU6+Eok2Gc7YloQmm0HcWEBsyzcmIhPut/CTiHcpoR0IVbip/fC8nPdSO/
 0LQ4Xkb5KzKA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="292738734"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292738734"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:53:10 -0700
IronPort-SDR: EOthb10JtN4u14hWX+3FVlNUaQMzq3OD+Ch+Z1Cs1MasFYAXLPIZ+fuD+ifgvCiRYtveOjLQpr
 DdC9DWadKRNA==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="555863813"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.1.140])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:53:09 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 2/3] RDMA/irdma: Check return value from ib_umem_find_best_pgsz
Date:   Tue, 22 Jun 2021 12:52:31 -0500
Message-Id: <20210622175232.439-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shiraz Saleem <shiraz.saleem@intel.com>

iwmr->page_size stores the return from ib_umem_find_best_pgsz
and maybe zero when used in ib_umem_num_dma_blocks thus causing
a divide by zero error.

Fix this by erroring out of irdma_reg_user when 0 is returned
from ib_umem_find_best_pgsz.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1505149 ("Integer handling issues")
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 8bd31656a83a..2c4f67fac360 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2782,10 +2782,16 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	iwmr->ibmr.iova = virt;
 	iwmr->page_size = PAGE_SIZE;
 
-	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM)
+	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
 		iwmr->page_size = ib_umem_find_best_pgsz(region,
 							 SZ_4K | SZ_2M | SZ_1G,
 							 virt);
+		if (unlikely(!iwmr->page_size)) {
+			kfree(iwmr);
+			ib_umem_release(region);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	}
 	iwmr->len = region->length;
 	iwpbl->user_base = virt;
 	palloc = &iwpbl->pble_alloc;
-- 
2.27.0

