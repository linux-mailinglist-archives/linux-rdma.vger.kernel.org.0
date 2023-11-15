Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D37ECB12
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjKOTSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 14:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKOTSK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 14:18:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58044C4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700075887; x=1731611887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwAaOc0IaDCuPKdwCBwThalNdZPi3YbAvkkuwrFm/wA=;
  b=JLSSrs3l+6ly8nKPq8lxF3bKSCIS0OiV9vJiKXx5fvdKDA+t772/RUPq
   w/V3CFm9dd54VE2gtWFW6iB67OzWV0hvNRhqtVJcwhyx2E4MtUj9vUILf
   rNRRK7evBRy/dsgBq+lnT+6KBLUyJF0DzcAWbluRI4KySYU7k2sHwm09f
   8UoKOAo1kqNjLDJYmg8BreX7gg84ConwzbPgmwdabyQmIq2UfCO2Me732
   pr0/GLNbE4CYN+5lkIjO6cPq9SqT0l6I9p6FTYThm9umBBDCt+sK+lUKv
   +xSyolsmZMj1NaazfzQyRpPWhIvy/uHfjTD1gR+F0eeU1X/ZLV6nAGP8w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393793047"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393793047"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:18:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758581312"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="758581312"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.160.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:18:06 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 3/3] RDMA/irdma: Fix support for 64k pages
Date:   Wed, 15 Nov 2023 13:17:52 -0600
Message-Id: <20231115191752.266-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231115191752.266-1-shiraz.saleem@intel.com>
References: <20231115191752.266-1-shiraz.saleem@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

Virtual QP and CQ require a 4K HW page size but the driver
passes PAGE_SIZE to ib_umem_find_best_pgsz() instead.

Fix this by using the appropriate 4k value in the bitmap passed to
ib_umem_find_best_pgsz().

Fixes: 693a5386eff0 ("RDMA/irdma: Split mr alloc and free into new functions")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index b072aa5179e0..7c31d2d606bb 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2902,7 +2902,7 @@ static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
 	iwmr->type = reg_type;
 
 	pgsz_bitmap = (reg_type == IRDMA_MEMREG_TYPE_MEM) ?
-		iwdev->rf->sc_dev.hw_attrs.page_size_cap : PAGE_SIZE;
+		iwdev->rf->sc_dev.hw_attrs.page_size_cap : SZ_4K;
 
 	iwmr->page_size = ib_umem_find_best_pgsz(region, pgsz_bitmap, virt);
 	if (unlikely(!iwmr->page_size)) {
-- 
1.8.3.1

