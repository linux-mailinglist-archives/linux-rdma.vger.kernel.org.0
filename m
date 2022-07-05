Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52409567A8D
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiGEXJJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiGEXJF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:09:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04435167E5
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062544; x=1688598544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TUTQOZzHu9CqkDCrtW+9nL7JPLGNN/NcU9VGS4mA5pw=;
  b=NjTlAJy5ilpBPtzV1BP8XLSGI8WnsEn88YL13TY89b4H3CN91OlUZwO/
   qv8quBVYpncqa2HseGFlYKMpnZlH2bER45sEQ7+2pTO2qPivyIB5d8BXR
   Noxqa9LR/u4vXLq6cP8Jf24jDSIkBDdTfqYehyif6vSwzKy4FoNBht/AK
   vobVTGWPGqCQjYTIRrYYPkOI2EBl6fQSybhuVQlXKR0CQWThaVz9vct+F
   PL90TSx8TbEOrerpMYgcK+wnfj37y1SHjjFs2Bv8Mu3TPFCJESRvZXPKj
   stdqyzy+iyhtwOPxZvvJ82xJr6FLrSb0M8+QiIjtVV/IBiLak6d3x4gPD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284677272"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284677272"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047751"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:51 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] RDMA/irdma: Do not advertise 1GB page size for x722
Date:   Tue,  5 Jul 2022 18:08:36 -0500
Message-Id: <20220705230837.294-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

x722 does not support 1GB page size but the irdma driver
incorrectly advertises 1GB page size support for x722 device
to ib_core to compute the best page size to use on this MR.
This could lead to incorrect start offsets computed by
hardware on the MR.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/i40iw_hw.c  | 1 +
 drivers/infiniband/hw/irdma/icrdma_hw.c | 1 +
 drivers/infiniband/hw/irdma/irdma.h     | 1 +
 drivers/infiniband/hw/irdma/verbs.c     | 4 ++--
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.c b/drivers/infiniband/hw/irdma/i40iw_hw.c
index e46fc11..50299f5 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.c
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.c
@@ -201,6 +201,7 @@ void i40iw_init_hw(struct irdma_sc_dev *dev)
 	dev->hw_attrs.uk_attrs.max_hw_read_sges = I40IW_MAX_SGE_RD;
 	dev->hw_attrs.max_hw_device_pages = I40IW_MAX_PUSH_PAGE_COUNT;
 	dev->hw_attrs.uk_attrs.max_hw_inline = I40IW_MAX_INLINE_DATA_SIZE;
+	dev->hw_attrs.page_size_cap = SZ_4K | SZ_2M;
 	dev->hw_attrs.max_hw_ird = I40IW_MAX_IRD_SIZE;
 	dev->hw_attrs.max_hw_ord = I40IW_MAX_ORD_SIZE;
 	dev->hw_attrs.max_hw_wqes = I40IW_MAX_WQ_ENTRIES;
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.c b/drivers/infiniband/hw/irdma/icrdma_hw.c
index cf53b17..5986fd9 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.c
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.c
@@ -139,6 +139,7 @@ void icrdma_init_hw(struct irdma_sc_dev *dev)
 	dev->cqp_db = dev->hw_regs[IRDMA_CQPDB];
 	dev->cq_ack_db = dev->hw_regs[IRDMA_CQACK];
 	dev->irq_ops = &icrdma_irq_ops;
+	dev->hw_attrs.page_size_cap = SZ_4K | SZ_2M | SZ_1G;
 	dev->hw_attrs.max_hw_ird = ICRDMA_MAX_IRD_SIZE;
 	dev->hw_attrs.max_hw_ord = ICRDMA_MAX_ORD_SIZE;
 	dev->hw_attrs.max_stat_inst = ICRDMA_MAX_STATS_COUNT;
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 46c1233..4789e85 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -127,6 +127,7 @@ struct irdma_hw_attrs {
 	u64 max_hw_outbound_msg_size;
 	u64 max_hw_inbound_msg_size;
 	u64 max_mr_size;
+	u64 page_size_cap;
 	u32 min_hw_qp_id;
 	u32 min_hw_aeq_size;
 	u32 max_hw_aeq_size;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c4412ec..96135a2 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -32,7 +32,7 @@ static int irdma_query_device(struct ib_device *ibdev,
 	props->vendor_part_id = pcidev->device;
 
 	props->hw_ver = rf->pcidev->revision;
-	props->page_size_cap = SZ_4K | SZ_2M | SZ_1G;
+	props->page_size_cap = hw_attrs->page_size_cap;
 	props->max_mr_size = hw_attrs->max_mr_size;
 	props->max_qp = rf->max_qp - rf->used_qps;
 	props->max_qp_wr = hw_attrs->max_qp_wr;
@@ -2781,7 +2781,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 
 	if (req.reg_type == IRDMA_MEMREG_TYPE_MEM) {
 		iwmr->page_size = ib_umem_find_best_pgsz(region,
-							 SZ_4K | SZ_2M | SZ_1G,
+							 iwdev->rf->sc_dev.hw_attrs.page_size_cap,
 							 virt);
 		if (unlikely(!iwmr->page_size)) {
 			kfree(iwmr);
-- 
1.8.3.1

