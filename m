Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEABC3B475F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYQ0m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 12:26:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:59672 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229776AbhFYQ0l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 12:26:41 -0400
IronPort-SDR: DNddNItpuJee8DfRw8DpN2q2S/WOhr0UYxfIL/nKvb85pAtT8KCQJVHN9j5lbD1t5pjwHI6ruv
 cshknqMCGBkQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="268831265"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="268831265"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 09:24:20 -0700
IronPort-SDR: 1/lIli9fowmimqUECVCwGKCbuyxqPVS7kpzwGAnylaKGXUbl0LRroQq6n0+smVSzhsWx6NMj+g
 YvNgYzCC47QQ==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="624564431"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.212.85.35])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 09:24:19 -0700
From:   Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com,
        coverity-bot <keescook+coverity-bot@chromium.org>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH v2 rdma-next 2/2] RDMA/irdma: Fix potential overflow expression in irdma_prm_get_pbles
Date:   Fri, 25 Jun 2021 11:23:29 -0500
Message-Id: <20210625162329.1654-3-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210625162329.1654-1-tatyana.e.nikolova@intel.com>
References: <20210625162329.1654-1-tatyana.e.nikolova@intel.com>
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
index ea1df5918c11..5bbe44e54f9a 100644
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
+	bits_needed = DIV_ROUND_UP_ULL(mem_size, BIT_ULL(pprm->pble_shift));
 
 	spin_lock_irqsave(&pprm->prm_lock, flags);
 	while (chunk_entry != &pprm->clist) {
-- 
2.27.0

