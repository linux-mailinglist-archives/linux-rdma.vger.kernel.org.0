Return-Path: <linux-rdma+bounces-3546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619C91ABDE
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 17:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D622828C6
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21701991A7;
	Thu, 27 Jun 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9oivpf1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F222EF2
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503611; cv=none; b=st7qNkAWgAUlrlZIFUnEd3CeHYI2FpHDkyCtoVs0UVKPDoHlew+uHjBOQstIojKHd9R2IxwbPI+Ds51XrGCw4k2MFu1P8/NkC6Ld2nBnlFsGTTa19bKt0WED7DusKOeTVxIlNsfhq08v/m3aLtKYGfCpBInsOYJ4qjQ2hRh9OJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503611; c=relaxed/simple;
	bh=PrVsn4Ig5T0EOiB5fNLqRfRJa1e0cZL1CmG9FbzWZK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiasDvg5AiOY2gczonuN186bx8K5jiCCdNwFPITJjA1qorsOmXZzFzI0aP6mOZ1R3PXWw+W+PXbn/6X91wRZ0zQA1VWGt4HbAuo355jyB5kdFrquhxklCApeYYU1oJI0V4lSUYu9Xn7LjBXoCPsanLmzR4KDmO8OtpJsaq1rK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9oivpf1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719503609; x=1751039609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PrVsn4Ig5T0EOiB5fNLqRfRJa1e0cZL1CmG9FbzWZK4=;
  b=Z9oivpf1gR4fVc7cprSHEvD3bgrRLtunqtKO9W4db1TUv7P7BZ8CbSd/
   3gY4fLRAI7ufsEwJ3Jn42I9LyCv098nJLCLQnfRWh3grtboqyE3TQi5/4
   lx+hg6+Rg5+U+f3I5i6PRqPx0ipR/LaNE2ayAwWXA5T1J/0Edwbx+VHAL
   95OdP7OVIOsm/oMofRLS6WRgmgVfBWQ10+IKzr61h6f2MCW/Wzgy3c1O/
   HBL4Fph+Qb2bwu385AUe41Fb6MfL3LED6J/haDuxkU5eoy3+Q1pVgqY44
   IXy2vuW2H/GVzMqHJrD89M2ZjhW4IvpvTUAJX+5Br5v0Chpn5dIbX4MQj
   w==;
X-CSE-ConnectionGUID: gt59dk04SSaYRBwAeVTjoA==
X-CSE-MsgGUID: avAP2zoHTQ2icVEoRg+iPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20524546"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20524546"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:53:28 -0700
X-CSE-ConnectionGUID: U98KbXlzRnGSdVhiY+yPyg==
X-CSE-MsgGUID: gZCqQe1sT5qc2eLuyBnFTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44326035"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.247.236.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 08:53:27 -0700
From: Shiraz Saleem <shiraz.saleem@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH] MAINTAINERS: Update Maintainers for irdma driver
Date: Thu, 27 Jun 2024 21:23:04 +0530
Message-Id: <20240627155304.219-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove Shiraz Saleem and add Tatyana Nikolova as co-maintainer
for irdma driver.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe03..b46161f61ff5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11066,7 +11066,7 @@ F:	include/linux/net/intel/iidc.h
 
 INTEL ETHERNET PROTOCOL DRIVER FOR RDMA
 M:	Mustafa Ismail <mustafa.ismail@intel.com>
-M:	Shiraz Saleem <shiraz.saleem@intel.com>
+M:	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/irdma/
-- 
1.8.3.1


