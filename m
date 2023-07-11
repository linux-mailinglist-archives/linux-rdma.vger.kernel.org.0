Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1574F78B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGKRxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 13:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGKRxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 13:53:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0E0E6F
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jul 2023 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689097990; x=1720633990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F2/NC+YiqsViZSHTmTllYqlZHqHRHyaOZjQOiEwU2Ks=;
  b=D3pFp1dUT6qItiuJxQn2OQ8mqSTAxgafPYPklZ8sdymYybfOiMfcoqwv
   JCarqjdBLfrt+r0xQxNy9OG8N69A0VCVrHbGmOXI8y5UqCeuFQtRhkhiX
   YgEeD4cgzpqlVcg6YXnEF1FvnQ2KevMwGI2f9eMNKBEZHRuGUr2+CCS7p
   Y+rWRSC4cmQomMqqDwvF8NH/KNVcYh5hC5EJZvfUsGL9GfeA6LVJfl6OF
   +5LwN1RfEUsRDPv1IFTX2CkTALBu1zoSelvoURUclp/WFBzp/BoJXgU83
   oUz+NumAEesWCgNGcwn5Dpp8n1TroxMBXWse3aNFfXgVeZH7AtWsgZwAY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="395482607"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="395482607"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724542495"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="724542495"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.33.5])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 10:53:06 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 1/3] RDMA/irdma: Add missing read barriers
Date:   Tue, 11 Jul 2023 12:52:51 -0500
Message-Id: <20230711175253.1289-2-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230711175253.1289-1-shiraz.saleem@intel.com>
References: <20230711175253.1289-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On code inspection, there are many instances in the driver where
CEQE and AEQE fields written to by HW are read without guaranteeing
that the polarity bit has been read and checked first.

Add a read barrier to avoid reordering of loads on the CEQE/AEQE fields
prior to checking the polarity bit.

Fixes: 3f49d684256 ("RDMA/irdma: Implement HW Admin Queue OPs")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 9 ++++++++-
 drivers/infiniband/hw/irdma/puda.c | 6 ++++++
 drivers/infiniband/hw/irdma/uk.c   | 3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index d88c918..c91439f 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -3363,6 +3363,9 @@ int irdma_sc_ccq_get_cqe_info(struct irdma_sc_cq *ccq,
 	if (polarity != ccq->cq_uk.polarity)
 		return -ENOENT;
 
+	/* Ensure CEQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	get_64bit_val(cqe, 8, &qp_ctx);
 	cqp = (struct irdma_sc_cqp *)(unsigned long)qp_ctx;
 	info->error = (bool)FIELD_GET(IRDMA_CQ_ERROR, temp);
@@ -4009,13 +4012,17 @@ int irdma_sc_get_next_aeqe(struct irdma_sc_aeq *aeq,
 	u8 polarity;
 
 	aeqe = IRDMA_GET_CURRENT_AEQ_ELEM(aeq);
-	get_64bit_val(aeqe, 0, &compl_ctx);
 	get_64bit_val(aeqe, 8, &temp);
 	polarity = (u8)FIELD_GET(IRDMA_AEQE_VALID, temp);
 
 	if (aeq->polarity != polarity)
 		return -ENOENT;
 
+	/* Ensure AEQE contents are read after valid bit is checked */
+	dma_rmb();
+
+	get_64bit_val(aeqe, 0, &compl_ctx);
+
 	print_hex_dump_debug("WQE: AEQ_ENTRY WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     aeqe, 16, false);
 
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 4ec9639..5625317 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -230,6 +230,9 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 	if (valid_bit != cq_uk->polarity)
 		return -ENOENT;
 
+	/* Ensure CQE contents are read after valid bit is checked */
+	dma_rmb();
+
 	if (cq->dev->hw_attrs.uk_attrs.hw_rev >= IRDMA_GEN_2)
 		ext_valid = (bool)FIELD_GET(IRDMA_CQ_EXTCQE, qword3);
 
@@ -243,6 +246,9 @@ static int irdma_puda_poll_info(struct irdma_sc_cq *cq,
 		if (polarity != cq_uk->polarity)
 			return -ENOENT;
 
+		/* Ensure ext CQE contents are read after ext valid bit is checked */
+		dma_rmb();
+
 		IRDMA_RING_MOVE_HEAD_NOCHECK(cq_uk->cq_ring);
 		if (!IRDMA_RING_CURRENT_HEAD(cq_uk->cq_ring))
 			cq_uk->polarity = !cq_uk->polarity;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index dd428d9..ea2c077 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1527,6 +1527,9 @@ void irdma_uk_clean_cq(void *q, struct irdma_cq_uk *cq)
 		if (polarity != temp)
 			break;
 
+		/* Ensure CQE contents are read after valid bit is checked */
+		dma_rmb();
+
 		get_64bit_val(cqe, 8, &comp_ctx);
 		if ((void *)(unsigned long)comp_ctx == q)
 			set_64bit_val(cqe, 8, 0);
-- 
1.8.3.1

