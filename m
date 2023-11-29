Return-Path: <linux-rdma+bounces-138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2267FE0E6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B365282007
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA360EC8;
	Wed, 29 Nov 2023 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8wOkIzU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069F8F
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701289318; x=1732825318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YfvxXlILWLoUrRdfY091vC8v7XL3slbOZIDf8yIGBRY=;
  b=X8wOkIzU5fOlxVo2sAEaBd9SFz6aK/MJqWKCIFeKUcLr1oX1wsrRWaHx
   ZFTz6H/kJdFgekqvCRza1ZCbrw0f94zlndqlfXjrJoyhuwfagjfL75fWd
   upmvNXfDnskMgVqZq5lpTad5fcGpNwwWbBtaFWfWSt3n+NEZuHSAZqdtF
   CkEZA6yDJ/gVCj4sQF88sLbnob9UmjLkfagsiB2RjcpQFIzYvEJvikmpv
   74BXxrTnHqhUlZVLN3j/CJWuh726Y7zFZ/mS5mpY/FrAgE/C7rA5gsAgg
   CNMUTv+qXuIXXCZnEOjyfrgbFKT9C/prLNknA8njkPmwyFpq1wXBXliQc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392087192"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392087192"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="859952975"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="859952975"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.124.161.227])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 12:21:57 -0800
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-rc 0/3] Fixes for 64K page size support
Date: Wed, 29 Nov 2023 14:21:40 -0600
Message-Id: <20231129202143.1434-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a three patch series.

The first core hunk corrects the core iterator to use __sg_advance to skip
preceding 4k HCA pages.

The second patch corrects an iWarp issue where the SQ must be PAGE_SIZE
aligned.

The third patch corrects an issue with the RDMA driver use of
ib_umem_find_best_pgsz(). QP and CQ allocations pass PAGE_SIZE as the
only bitmap bit. This is incorrect and should use the precise 4k value.

v1->v2: Add a umem specific block iter next function

Mike Marciniszyn (3):
  RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz
  RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
  RDMA/irdma: Fix support for 64k pages

 drivers/infiniband/core/umem.c      | 6 ------
 drivers/infiniband/hw/irdma/verbs.c | 7 ++++++-
 include/rdma/ib_umem.h              | 9 ++++++++-
 include/rdma/ib_verbs.h             | 1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

-- 
1.8.3.1


