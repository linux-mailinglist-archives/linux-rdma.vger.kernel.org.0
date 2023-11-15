Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642747ECB11
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjKOTSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 14:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKOTSJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 14:18:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9FA4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Nov 2023 11:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700075886; x=1731611886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yxklAnW6KY8nVk53uBZ74UFVh1e0+Hd9iwhm608ZEy4=;
  b=mczhEOkgWWBFBYOQAL9pm1UoGpir05HcD7IyhVHOLlOSDhHAD5a+jWvj
   bSEkit4yq4JAam3me4Xc6xgJvWw4dQKYBP00zVnbc+/jJE+kU2wftsbjF
   2jc/sMCn/coyH4zKmEPFj/SG3pztaX1KgqQjkKbr1GsOWXTHjTIJC1ust
   KL+GSGAuv29+e9kTTtIwO4feppjh+nprHvK9GomKgfO8cuuD3OI/xrhfA
   7jTBeU9OeE4pHrV02RoznNI//5IGT10zjH64y5Lx4wtuxIqJa/Ndyi+/z
   JsMF8TN9zPzkJOkUrOYsNmPUxeNct0KAAms7ANiQd52IKPswV8nhcGHZH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393793039"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="393793039"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758581304"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="758581304"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.160.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:18:05 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc 2/3] RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
Date:   Wed, 15 Nov 2023 13:17:51 -0600
Message-Id: <20231115191752.266-3-shiraz.saleem@intel.com>
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

The SQ is shared for between kernel and used by storing
the kernel page pointer and passing that to a kmap_atomic().

This then requires that the alignment is PAGE_SIZE aligned.

Fix by adding an iWarp specific alignment check.

Fixes: e965ef0e7b2c ("RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp")
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6415ada63c5f..b072aa5179e0 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2934,6 +2934,11 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
 	int err;
 	u8 lvl;
 
+	/* iWarp: Catch page not starting on OS page boundary */
+	if (!rdma_protocol_roce(&iwdev->ibdev, 1) &&
+	    ib_umem_offset(iwmr->region))
+		return -EINVAL;
+
 	total = req.sq_pages + req.rq_pages + 1;
 	if (total > iwmr->page_cnt)
 		return -EINVAL;
-- 
1.8.3.1

