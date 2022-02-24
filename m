Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA2B4C21BB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiBXCZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBXCZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:25:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785C22EDCB
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645669488; x=1677205488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqkk1InaaHwaH5hNQJzomPX5ODXVbcLVGUNbLKU1Xgw=;
  b=WPp0PN8mM6Maj1kvTuHHCXC4DvbpDTKOh67C0/wdesOpd6wvP1+1TFeG
   EAu77FtGJgE4vDAzohwnIqUXrMD/LweYpLWUBRNnMT/xOCvO5PivCjCJm
   oQbw8Z4CoG4evoPyjNOe8+lBC/DVABh1I5iiZ4/nfpqqkvHR/LyPmXsnE
   QbwvkeYzyafAjAvLKTI+GF6fSqg7tPB44kxTo/joVizRCQiHqqZlE2yWh
   5acq2dAdKPu9sieREc79Wc5aNVpazVaYNOo6cRn4veXBwCrKHYe2wfdlB
   MjbpJQuOEjaG+maYj6QMasfS2EHDkEETVAkVLzSDt+dmJxC75leyBaDJm
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="235627972"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="235627972"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="548513130"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.38.207])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:58:51 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc 3/3] RDMA/irdma: Remove incorrect masking of PD
Date:   Wed, 23 Feb 2022 18:58:42 -0600
Message-Id: <20220224005842.1707-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224005842.1707-1-shiraz.saleem@intel.com>
References: <20220224005842.1707-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mustafa Ismail <mustafa.ismail@intel.com>

The PD id is masked with 0x7fff, while PD can be 18 bits for GEN2 HW.
Remove the masking as it should not be needed and can cause incorrect
PD id to be used.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 460e757..1bf6404 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2509,7 +2509,7 @@ static int irdma_dealloc_mw(struct ib_mw *ibmw)
 	cqp_info = &cqp_request->info;
 	info = &cqp_info->in.u.dealloc_stag.info;
 	memset(info, 0, sizeof(*info));
-	info->pd_id = iwpd->sc_pd.pd_id & 0x00007fff;
+	info->pd_id = iwpd->sc_pd.pd_id;
 	info->stag_idx = ibmw->rkey >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->mr = false;
 	cqp_info->cqp_cmd = IRDMA_OP_DEALLOC_STAG;
@@ -3021,7 +3021,7 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	cqp_info = &cqp_request->info;
 	info = &cqp_info->in.u.dealloc_stag.info;
 	memset(info, 0, sizeof(*info));
-	info->pd_id = iwpd->sc_pd.pd_id & 0x00007fff;
+	info->pd_id = iwpd->sc_pd.pd_id;
 	info->stag_idx = ib_mr->rkey >> IRDMA_CQPSQ_STAG_IDX_S;
 	info->mr = true;
 	if (iwpbl->pbl_allocated)
-- 
1.8.3.1

