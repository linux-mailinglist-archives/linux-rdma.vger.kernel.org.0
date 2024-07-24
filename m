Return-Path: <linux-rdma+bounces-3973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA49B93B993
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 01:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6DB2817C1
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2024 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB7149C64;
	Wed, 24 Jul 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4zPk497"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AC145B00
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jul 2024 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864455; cv=none; b=TmiIF3AHbd7xYoeteGnT2LXXsNHr0kHKqb7fJ7drU2gXsn1LIdNARNOs4vYQnjO2b5K6YN+KvR7K0kPDBXbIA9HFpgj055imhcp5lDecZ7wC0HQWHUBARmkKmGXHOjkg8T3weADRF90XdROqPLz6bt6hGaB1tZMmksMZixD41nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864455; c=relaxed/simple;
	bh=idudZEeGuT0F22EFtKu3oVijOX0MNRJEOnoVZsWsR/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9MjH31uC5vYIi/md5vyt0kSTz8m3QP2QYha+3c12r1t683DF+ByL4oRtRH0otVm5OWRqh4ZtoagK6+rqWTJDNkESt+xFWpMgckHN2jv3j127HNHD0qFhE0/VE/4xI8/6DjfzFPUnRz2HVviZFdwvqRyByb/ddq3Rs4bqoINtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4zPk497; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721864455; x=1753400455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idudZEeGuT0F22EFtKu3oVijOX0MNRJEOnoVZsWsR/k=;
  b=I4zPk497AePeIHNjiF7ZGNMN0jl+n8QiHnmUXMIqUIIJVbhN+cTgGji0
   luWLLuVERreApFOzDW9Qiqbk1O/ppVB6sKHQDrR7Grc4hJSc6uVTBS3c1
   XOvRn2/uvgleS4YTGc4M6yH6SnGz0Cd62rfxUaSEaWHI4PlLovgFvFrwH
   mZuV8lVA7dHtSkSx0cpByXMGoV+O5b6o/0iKT4PTB2yvf/tOKGdzOUZjI
   25iPorO5DRyaoReRFTMtJ3OpGCpKqKD6/yNRbOac99HlSNTD+WLbfU4Ac
   kga5lLe2DtJWglUG7Yenz/k2PhatTQQglLhnBzA9nlo9q/ZNZKWmUHH51
   Q==;
X-CSE-ConnectionGUID: Mn5rM6adRZCO1RTj0uiFrg==
X-CSE-MsgGUID: 4T4dnf5/RBWwEgx4tPxjpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44999813"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="44999813"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:49 -0700
X-CSE-ConnectionGUID: WmPcsHIbQKOoh4PKKfw0rg==
X-CSE-MsgGUID: OUDydYSjTC6RGGV9mK4nUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52426130"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.124.96.138])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 16:40:47 -0700
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	mustafa.ismail@intel.com,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [RFC PATCH 25/25] RDMA/irdma: Update Kconfig
Date: Wed, 24 Jul 2024 18:39:17 -0500
Message-Id: <20240724233917.704-26-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
References: <20240724233917.704-1-tatyana.e.nikolova@intel.com>
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
index b6f9c41..f6b39f3 100644
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
1.8.3.1


