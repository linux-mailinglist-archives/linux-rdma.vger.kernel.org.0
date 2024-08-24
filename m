Return-Path: <linux-rdma+bounces-4555-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0E495DB04
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 05:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849401F2253B
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Aug 2024 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26614146D49;
	Sat, 24 Aug 2024 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbWEvmo5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C613E881;
	Sat, 24 Aug 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724469659; cv=none; b=Pbq6Zx8gAjimsLjdgGAy0PbX4i2niAuMChvP7zQdzZum73dH82ktXqYDCu+gGrBp51xhYUxez81D/lqOtwDLhmyz3Ni0fDGoIGO5u/vLpwwfxyWW36lPQQb8+DgIqlz9oAV5e1Po2+fhcLhRvuk9KqQ9QsW9VyoMbJ3Op3xBkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724469659; c=relaxed/simple;
	bh=p4YYPWWfeOTmFb2XDs2EfNnALNAekuVD4k4hsW0uCiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZwUWRYLfxvJ6f/v35/g6omGjElqVWNlKj8OYvGx9Jp5lp9QaXWrXJIhMJpG6NWLnu0Z+zrhmRiPOiSew7/y7BcDGPQm2zOopKpxa7/l2HrRJWi57YVHthVV9d9yoDwNhU/QHM0X8k5+n9qxb3I4W5VFEOnKT7D97qPIPHZyzjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbWEvmo5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724469658; x=1756005658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p4YYPWWfeOTmFb2XDs2EfNnALNAekuVD4k4hsW0uCiM=;
  b=hbWEvmo5yoMKN99VJMPuu9VA1IL/DdALjONrQEnSxW+lA2zPvD0LKgEL
   8lhLHRXnen9aHKfF3BiI+zml1we/jBU9E2UErue2M/EELMBMcebRR77sJ
   93pYAJsRlVZPFyj1hTeB8I413obPeiMmAjbsuSnuTCZTYvRnTi3bsEgU2
   b9pACnYRMMRkbP/zvVMntmpJuD4aqP5h1ggifr78hGkkgMs4pm07eCdJU
   t25+tCqvQdjtPKmRFOGRsQkalPlaFEaoNdcl0tXb0siu8JVf3MVE8vx9D
   syw5WoQdlF32opf5s4ogWgK2VBArfEU/+z9534mZIhSPdrrEKhtNr9fQd
   A==;
X-CSE-ConnectionGUID: KypEm6wNQPeBvnnIur8jBw==
X-CSE-MsgGUID: 8rgFG4rSSHq46763jXCjog==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13187840"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13187840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:53 -0700
X-CSE-ConnectionGUID: /B202zQ5RUqwbDqp79MtpA==
X-CSE-MsgGUID: 3sYwZGIdTJKeP82Y2SiHjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="99492152"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.36.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 20:20:52 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC v2 25/25] RDMA/irdma: Update Kconfig
Date: Fri, 23 Aug 2024 22:19:24 -0500
Message-Id: <20240824031924.421-26-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
References: <20240824031924.421-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiraz Saleem <shiraz.saleem@intel.com>

Update Kconfig to add dependency on idpf module. Additionally, add
IPU E2000 to list of devices supported.

Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
---
 drivers/infiniband/hw/irdma/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index b6f9c41bca51..f6b39f3a726e 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,9 +4,10 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on ICE && I40E
+	depends on (IDPF || ICE) && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	help
-	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
-	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
+	  This is an Intel(R) Ethernet Protocol Driver for RDMA that
+	  support IPU E2000 (RoCEv2), E810 (iWARP/RoCE) and X722 (iWARP)
+	  network devices.
-- 
2.42.0


