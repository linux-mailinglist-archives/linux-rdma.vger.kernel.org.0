Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759EC6BB6B9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjCOO4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjCOO42 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 10:56:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C521711E91
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678892148; x=1710428148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pv8mKG7mAPuim2wbr8Gdq3bUVFE5DsNw42s7Ov+W8Sk=;
  b=iO1dYHwG94MWJSPdU4NRR/6vXL/cF8S3LMGEjmoym635RsPwggxPkHsL
   JSJ2KPD/daH1cBwCA4iYSroOl6PD4BpjyIzqM2VZAyBFVmu3X8uEes/PH
   rKx8Zr+lG0dWVy/4ssv0sUlhJfXDHnfxbXgZaJ/7jM5npked924MqgAI9
   jpM9QStNNLWXCBd3hjjgjDbSy5XX2s5SOJw9KghmVjm5Ejs91YSTCgwr+
   muuOCtPf6V3oJ1sx7S06RowHRep/9kFLl8vNSCXYv18/VclTSzZf9Pfh+
   5TO6GS0ZNSgoVi1ng3oJMei+irS+RXF/OXWJAfw2UuUAa//TIKCoBtDqc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="321561727"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321561727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743714357"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743714357"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.255.35.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:53:31 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 3/4] RDMA/irdma: change name of interrupts
Date:   Wed, 15 Mar 2023 09:53:04 -0500
Message-Id: <20230315145305.955-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230315145305.955-1-shiraz.saleem@intel.com>
References: <20230315145305.955-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Add more information in interrupt names.

Before this patch it was:
irdma
CEQ
CEQ
...

Now:
irdma-0000:18:00.0-AEQ
irdma-0000:18:00.0-CEQ-0
irdma-0000:18:00.0-CEQ-1
...

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Suggested-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c   | 13 ++++++++++---
 drivers/infiniband/hw/irdma/main.h |  3 +++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 2e1e2ba..f683531 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1089,14 +1089,19 @@ static int irdma_cfg_ceq_vector(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
 	int status;
 
 	if (rf->msix_shared && !ceq_id) {
+		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
+			 "irdma-%s-AEQCEQ-0", dev_name(&rf->pcidev->dev));
 		tasklet_setup(&rf->dpc_tasklet, irdma_dpc);
 		status = request_irq(msix_vec->irq, irdma_irq_handler, 0,
-				     "AEQCEQ", rf);
+				     msix_vec->name, rf);
 	} else {
+		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
+			 "irdma-%s-CEQ-%d",
+			 dev_name(&rf->pcidev->dev), ceq_id);
 		tasklet_setup(&iwceq->dpc_tasklet, irdma_ceq_dpc);
 
 		status = request_irq(msix_vec->irq, irdma_ceq_handler, 0,
-				     "CEQ", iwceq);
+				     msix_vec->name, iwceq);
 	}
 	cpumask_clear(&msix_vec->mask);
 	cpumask_set_cpu(msix_vec->cpu_affinity, &msix_vec->mask);
@@ -1125,9 +1130,11 @@ static int irdma_cfg_aeq_vector(struct irdma_pci_f *rf)
 	u32 ret = 0;
 
 	if (!rf->msix_shared) {
+		snprintf(msix_vec->name, sizeof(msix_vec->name) - 1,
+			 "irdma-%s-AEQ", dev_name(&rf->pcidev->dev));
 		tasklet_setup(&rf->dpc_tasklet, irdma_dpc);
 		ret = request_irq(msix_vec->irq, irdma_irq_handler, 0,
-				  "irdma", rf);
+				  msix_vec->name, rf);
 	}
 	if (ret) {
 		ibdev_dbg(&rf->iwdev->ibdev, "ERR: aeq irq config fail\n");
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 65e966a..def6dd5 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -115,6 +115,8 @@
 #define IRDMA_REFLUSH		BIT(2)
 #define IRDMA_FLUSH_WAIT	BIT(3)
 
+#define IRDMA_IRQ_NAME_STR_LEN (64)
+
 enum init_completion_state {
 	INVALID_STATE = 0,
 	INITIAL_STATE,
@@ -212,6 +214,7 @@ struct irdma_msix_vector {
 	u32 cpu_affinity;
 	u32 ceq_id;
 	cpumask_t mask;
+	char name[IRDMA_IRQ_NAME_STR_LEN];
 };
 
 struct irdma_mc_table_info {
-- 
1.8.3.1

