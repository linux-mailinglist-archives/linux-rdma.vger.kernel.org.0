Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B397A567A87
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGEXIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 19:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiGEXI2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 19:08:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DF15FBF
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 16:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657062506; x=1688598506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btFaKB8EN9a59bp0n0+FTL8jAf4Y1q9R+oHzFVj8WC0=;
  b=FV/dRS8cjILXxe4oXwfRKl89bL1Qr8XyUhICuDvjGj5h8Iiua1KN2Zcn
   YMKLG3o6CvAyNGyuQBMJKUYH8FIc/7Ya5vDZ/DxATszUru97xqwvnrcab
   CaShoncCKUdUMGBp2FPO1JNLFHLS8Qoz95dAIdlpXAw9WTUAHRkFCh5dp
   OXn9PCcpjTiHKDD79lyG1ro4aTHBq2v0NcpxQoKwgzuGvyfRJRNXwOrjT
   8A4tNQC2tCqv8Ewcnq21rbUWtgrbl0EIyzlXt9yhxgWBf7Fk2wwVII48e
   gHZknxD9O/G7I/HDXgNgtMF0ZCEiU5voIPYe7Y3TCckAUZPEvLz4FWw+k
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266588420"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="266588420"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="620047537"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.212.17.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 16:08:25 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, Nayan Kumar <nayan.kumar@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 4/7] RDMA/irdma: Make resource distribution algorithm more QP oriented
Date:   Tue,  5 Jul 2022 18:08:12 -0500
Message-Id: <20220705230815.265-5-shiraz.saleem@intel.com>
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

From: Nayan Kumar <nayan.kumar@intel.com>

Adapt the resource distribution algorithm in irdma_cfg_fpm_val to be more
QP oriented. If the configuration is too big for the available memory,
trim the MR and PBLE's first before trimming the QPs. This also avoids
having to double QPs requested as input to algorithm for GEN1 devices.

Signed-off-by: Nayan Kumar <nayan.kumar@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/ctrl.c | 8 +++++---
 drivers/infiniband/hw/irdma/hw.c   | 5 +----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 58c0e18..a41e0d2 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -4872,10 +4872,12 @@ int irdma_cfg_fpm_val(struct irdma_sc_dev *dev, u32 qp_count)
 
 		sd_diff = sd_needed - hmc_fpm_misc->max_sds;
 		if (sd_diff > 128) {
-			if (qpwanted > 128 && sd_diff > 144)
+			if (!(loop_count % 2) && qpwanted > 128) {
 				qpwanted /= 2;
-			mrwanted /= 2;
-			pblewanted /= 2;
+			} else {
+				mrwanted /= 2;
+				pblewanted /= 2;
+			}
 			continue;
 		}
 		if (dev->cqp->hmc_profile != IRDMA_HMC_PROFILE_FAVOR_VF &&
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index bb60431..8abbd50 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1512,10 +1512,7 @@ static int irdma_hmc_setup(struct irdma_pci_f *rf)
 	int status;
 	u32 qpcnt;
 
-	if (rf->rdma_ver == IRDMA_GEN_1)
-		qpcnt = rsrc_limits_table[rf->limits_sel].qplimit * 2;
-	else
-		qpcnt = rsrc_limits_table[rf->limits_sel].qplimit;
+	qpcnt = rsrc_limits_table[rf->limits_sel].qplimit;
 
 	rf->sd_type = IRDMA_SD_TYPE_DIRECT;
 	status = irdma_cfg_fpm_val(&rf->sc_dev, qpcnt);
-- 
1.8.3.1

