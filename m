Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF894C4AD6
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 17:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiBYQdk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 11:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiBYQdj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 11:33:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40647188861
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645806786; x=1677342786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqkk1InaaHwaH5hNQJzomPX5ODXVbcLVGUNbLKU1Xgw=;
  b=Cq0wo/IGEdrYw95wzJ6IHxPZUj2/2REl/27eaqLbXkckRqThEuZ14A1T
   duIWgL2Qm+YAGHbU4EAOrQOrdNoyFFYQEtgdiuyDWac65PsXGA2Mez47n
   vSv8XSPTYQrM+VYsbMQMFjHcLY3YO+RGdVC8AzKtEJ4k5R173b8IcbSrx
   M8my6yH8nDuiVEUokNShg/xEU92MyRAiLvCcbJ2G9BN6IKz+B4KXGweCY
   XZOVdmSjljHd9+yYbcOtea5nFXiPJubIqWxukL6x5LIrfdoeYfLxZNOJh
   7gdseQCr+ngrvcQA42K6RyubQFkT0uNFu3F1NxH5cxivz1XPHxFNkLWRD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315744255"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="315744255"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:33:03 -0800
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="549321889"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.32.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:33:02 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH rdma-rc v1 3/3] RDMA/irdma: Remove incorrect masking of PD
Date:   Fri, 25 Feb 2022 10:32:11 -0600
Message-Id: <20220225163211.127-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220225163211.127-1-shiraz.saleem@intel.com>
References: <20220225163211.127-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

