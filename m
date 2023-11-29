Return-Path: <linux-rdma+bounces-141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3307FE0EA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263C81C20BF7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB560EDA;
	Wed, 29 Nov 2023 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnzdZ/OH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154DCD69
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701289320; x=1732825320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gAhQ/k3mdtc+HW53GS10+lrjzUcck85HlbcsrSoLCbI=;
  b=fnzdZ/OHOrAOUk9BqXBk4BmgAPLKLHmOpUprrHKC+3u9/k1sO/IlqVK5
   Fd7c+5yK5orDKHe0d1f5pH2s5cK+H9oAFQVyjle6Ey1NCmJDgKjUJsz8P
   T509Z52/HShrDy6+EOw7VBHRXZp/eEglDC7ic/rTvt+N/Xb5nd3/ezYBo
   wWlMhJ+FxDyovxcnikEaRUr2vR8aVcWxC7ZwYjfixGjkAl6LajEblvxnf
   kXTNr9wHp899JiZ5KnwbYf2UeSB2qlmPbEZqpgPmSLXTJ/nS9eZQk4wYi
   IqfTYkvuZB8AqVr9ifFo0IqWkgOLakOQx7gd6EgOFiZ5dDDHUxhapaktM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392087203"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392087203"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="859952988"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="859952988"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.161.227])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:59 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-rc 3/3] RDMA/irdma: Fix support for 64k pages
Date: Wed, 29 Nov 2023 14:21:43 -0600
Message-Id: <20231129202143.1434-4-shiraz.saleem@intel.com>
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
index fb9088392b19..b5eb8d421988 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2914,7 +2914,7 @@ static struct irdma_mr *irdma_alloc_iwmr(struct ib_umem *region,
 	iwmr->type = reg_type;
 
 	pgsz_bitmap = (reg_type == IRDMA_MEMREG_TYPE_MEM) ?
-		iwdev->rf->sc_dev.hw_attrs.page_size_cap : PAGE_SIZE;
+		iwdev->rf->sc_dev.hw_attrs.page_size_cap : SZ_4K;
 
 	iwmr->page_size = ib_umem_find_best_pgsz(region, pgsz_bitmap, virt);
 	if (unlikely(!iwmr->page_size)) {
-- 
1.8.3.1


