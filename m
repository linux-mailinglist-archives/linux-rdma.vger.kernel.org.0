Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644B23B0BE2
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 19:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhFVRz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 13:55:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:40104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232225AbhFVRz1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 13:55:27 -0400
IronPort-SDR: BnNqESb52S/WH+lTQ0jhZ5whHScrW9H+2IVJldXO+Bl7KNukCcicA9HfAXHdj/A1PnKUWaob6a
 CxreuszZKWBw==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="292738737"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="292738737"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:53:11 -0700
IronPort-SDR: Vx5FcMMXDGnZ5GSwMSMquA2bZmrvZ0UqTWvq7llRhHZiIgZkci1g5ISzE94w6/RS6HxhlnGtq5
 jj2rZq2+OzVA==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="555863817"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.1.140])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 10:53:10 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH rdma-next 3/3] RDMA/irdma: Fix potential overflow expression in irdma_prm_get_pbles
Date:   Tue, 22 Jun 2021 12:52:32 -0500
Message-Id: <20210622175232.439-4-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shiraz Saleem <shiraz.saleem@intel.com>

Coverity reports a signed 32-bit overflow on "1 << pprm->pble_shift" when
used expression to compute bits_needed that expects 64bit, unsigned.

Fix this by using the 1ULL in the left shift operator and convert
mem_size to u64.

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1505157 ("Integer handling issues")
Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/pble.h  | 2 +-
 drivers/infiniband/hw/irdma/utils.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
index e4e635dc4fd9..e1b3b8118a2c 100644
--- a/drivers/infiniband/hw/irdma/pble.h
+++ b/drivers/infiniband/hw/irdma/pble.h
@@ -121,7 +121,7 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
 					      struct irdma_chunk *pchunk);
 enum irdma_status_code
 irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
-		    struct irdma_pble_chunkinfo *chunkinfo, u32 mem_size,
+		    struct irdma_pble_chunkinfo *chunkinfo, u64 mem_size,
 		    u64 **vaddr, u64 *fpm_addr);
 void irdma_prm_return_pbles(struct irdma_pble_prm *pprm,
 			    struct irdma_pble_chunkinfo *chunkinfo);
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index ea1df5918c11..e50b6f89b37e 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2314,7 +2314,7 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
  */
 enum irdma_status_code
 irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
-		    struct irdma_pble_chunkinfo *chunkinfo, u32 mem_size,
+		    struct irdma_pble_chunkinfo *chunkinfo, u64 mem_size,
 		    u64 **vaddr, u64 *fpm_addr)
 {
 	u64 bits_needed;
@@ -2326,7 +2326,7 @@ irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
 	*vaddr = NULL;
 	*fpm_addr = 0;
 
-	bits_needed = (mem_size + (1 << pprm->pble_shift) - 1) >> pprm->pble_shift;
+	bits_needed = (mem_size + BIT_ULL(pprm->pble_shift) - 1) >> pprm->pble_shift;
 
 	spin_lock_irqsave(&pprm->prm_lock, flags);
 	while (chunk_entry != &pprm->clist) {
-- 
2.27.0

