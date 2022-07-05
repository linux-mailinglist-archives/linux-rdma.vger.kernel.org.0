Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C9567A83
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiGEXI1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiGEXIZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE4DFC
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062504; x=1688598504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cR+IU9F7d1rCQ/Sw9dd0AzU5qaIggNiiNV/lo8vAnU8=;
  b=LFfwkopTfJyjxo9MhM2P8VT6xRhDsgCn+VKzB+NNsqUS/QxTJzdeAZOu
   a88kGFl6qMM657hUwXTpSeDY5g2mDMjMETOd2dK0+dCFkVrrTw5mttfEd
   cwYW9D8fvk/M1FGgg04pfaJY6sVLNCHfBPFkVH9W5gMh8eK4WYh7urH8D
   JmRY5pWz9T2HkjaAQ0ZecNCBiI+bjDvQKeSIK1fEmlznUr893xvgHUyUW
   qIlik5w/p41/0tvz8wSakSbnrH3jwO0rxyNe4FFIbRFQ/JwZZqDmYXmQc
   BNmQUQVUEnhrIsk9Dudz9OjQ8SrDfXsq80lMO0ezjeTNW2XU7TgijNX/Z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588404"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588404"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:24 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047514"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:23 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 1/7] RDMA/irdma: Add 2 level PBLE support for FMR
Date:   Tue,  5 Jul 2022 18:08:09 -0500
Message-Id: <20220705230815.265-2-shiraz.saleem@intel.com>
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

Level 2 Physical Buffer List Entry (PBLE) is currently not supported for
Fast MRs which limits memory registrations to 256K pages.

Adapt irdma_set_page and irdma_alloc_mr to allow for 2 level PBLEs.

Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/main.h  |  2 +-
 drivers/infiniband/hw/irdma/verbs.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index ef862bc..65e966a 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -85,7 +85,7 @@
 #define	IRDMA_NO_QSET	0xffff
 
 #define IW_CFG_FPM_QP_COUNT		32768
-#define IRDMA_MAX_PAGES_PER_FMR		512
+#define IRDMA_MAX_PAGES_PER_FMR		262144
 #define IRDMA_MIN_PAGES_PER_FMR		1
 #define IRDMA_CQP_COMPL_RQ_WQE_FLUSHED	2
 #define IRDMA_CQP_COMPL_SQ_WQE_FLUSHED	3
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c4412ec..0f5856b 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2605,7 +2605,7 @@ static struct ib_mr *irdma_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
 	err_code = irdma_get_pble(iwdev->rf->pble_rsrc, palloc, iwmr->page_cnt,
-				  true);
+				  false);
 	if (err_code)
 		goto err_get_pble;
 
@@ -2641,8 +2641,16 @@ static int irdma_set_page(struct ib_mr *ibmr, u64 addr)
 	if (unlikely(iwmr->npages == iwmr->page_cnt))
 		return -ENOMEM;
 
-	pbl = palloc->level1.addr;
-	pbl[iwmr->npages++] = addr;
+	if (palloc->level == PBLE_LEVEL_2) {
+		struct irdma_pble_info *palloc_info =
+			palloc->level2.leaf + (iwmr->npages >> PBLE_512_SHIFT);
+
+		palloc_info->addr[iwmr->npages & (PBLE_PER_PAGE - 1)] = addr;
+	} else {
+		pbl = palloc->level1.addr;
+		pbl[iwmr->npages] = addr;
+	}
+	iwmr->npages++;
 
 	return 0;
 }
-- 
1.8.3.1

