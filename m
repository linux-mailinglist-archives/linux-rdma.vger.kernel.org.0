Return-Path: <linux-rdma+bounces-139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F77FE0E8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C1E2820CD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5473A60ECE;
	Wed, 29 Nov 2023 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXX1lmsF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635B7D68
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701289319; x=1732825319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FD3Cpl+NSRM+pGDUUxktd282jnbtSkzMCReDFdmqAnI=;
  b=PXX1lmsFxSHmlbRgTrNGUL7UIM6x3i5aSj3NyuxVtc4MPkPiRJxnfszY
   njWm48kUI+uYcdPZHaEJlFa+fRBhBujfRWgvi6lg4Ujc+qPKSvG2GG6e8
   f2q6N0+C3odygj5fPgYyTts4tRlGkFdw6qE4axFAGGau8fyMBElVq46PZ
   TDEI0aIX+qOLdZm0xXW+c9OS0H01Bk0+muTRFbXi1UY4hsIEzG89HJ5/Q
   wbXtJ1ohu2Ge3AIqoj5cDaUpM0v63RExTwJZgDwOkgbczYpoYQx9MDaNZ
   5WQVs1dkyZhH+dHd54EJSsU2UG/9QG4xlgCMtUKQ9PA7y6F8qZGYPE5Xu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392087198"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392087198"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="859952984"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="859952984"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.161.227])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:58 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-rc 2/3] RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
Date: Wed, 29 Nov 2023 14:21:42 -0600
Message-Id: <20231129202143.1434-3-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20231129202143.1434-1-shiraz.saleem@intel.com>
References: <20231129202143.1434-1-shiraz.saleem@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 5fa88e6cca4e..fb9088392b19 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2946,6 +2946,11 @@ static int irdma_reg_user_mr_type_qp(struct irdma_mem_reg_req req,
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


