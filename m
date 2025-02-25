Return-Path: <linux-rdma+bounces-8056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A36EA4346D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 06:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45C33B7A7D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76792155744;
	Tue, 25 Feb 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzU9worL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A569C7EF09;
	Tue, 25 Feb 2025 05:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459935; cv=none; b=sZorCbjWwRQjVi/szb7blp3q4GUvQT3BApYzsH+aeQj70k9/BUDitXHbxlPetjIOtlQ8zi1QPsncVpGJlr228lwGQFmTErCHH5EGS3agxFC3pLN64YyydLLg90qZognupNCXXMOKnGvvuR4BOFLH8pT/inzagi2nH3DAa9TG14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459935; c=relaxed/simple;
	bh=4EoFHydMSPUuRYDVxFvSPsyBP8kzcKATNbkRd22e18M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GX96liVvEntx2arA9bE8wZV1Z0BCsVpG97BgTrZQ653gykRFGBqUWC8TBVgFNZoJ8Q+hY3FiXnvG33d+bMDE4z1zLtqqmsM7iu+EyBLGnWgLboTDaKccrwsLeJb3Dgx9dQ7loGiYcpcWCRXQFI/IQ+DKpOB0Q+oMJlKatuN04tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzU9worL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740459934; x=1771995934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4EoFHydMSPUuRYDVxFvSPsyBP8kzcKATNbkRd22e18M=;
  b=gzU9worLgiDMPi4x7gqVtqYaYpPZ/oC9g9h6imqF74HTrwkYezH4kohp
   eGd1zpo+dt80pn1b5OoB4i0yr3h02mLrHZII2YYQLr/6WqfpDrZ6EC4rZ
   ULrBH1hkdZb2k1nCXIr0gZLoKLmKEMIAq/ehcbrYH9pJhIWJFOMXphQVM
   MhaRvXXy40xsVhbS/kTsHZloV5LGuUeAMQOwlnXDjU2J67KXpUU4h8LpF
   5+S3LR/qPeWlf8iIxVE3wSFoOpglC+fuJ2itskJ0GZ4fD/fEECEJF6+co
   kk7IsS5l1cSKyvr7xf14XForZDSNVs+vRCrA0GWCrbWN+u5w2303JWmmb
   Q==;
X-CSE-ConnectionGUID: QsW4Ala4SNygNAGPbOH9JQ==
X-CSE-MsgGUID: pSMTjAPMToaXYqLIl0WRag==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44075725"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="44075725"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 21:05:33 -0800
X-CSE-ConnectionGUID: LXeW1j1sRqGQzAwchtkDbA==
X-CSE-MsgGUID: xmQadiNhQfCRcpXFG2Q8RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="116773605"
Received: from tenikolo-mobl1.amr.corp.intel.com ([10.246.115.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 21:05:32 -0800
From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
To: jgg@nvidia.com,
	leon@kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	david.m.ertman@intel.com,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [iwl-next v4 0/1] Add RDMA support for Intel IPU E2000 (GEN3)
Date: Mon, 24 Feb 2025 23:04:27 -0600
Message-Id: <20250225050428.2166-1-tatyana.e.nikolova@intel.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To align with review comments, the patch series [1] introducing RDMA
RoCEv2 support for the Intel Infrastructure Processing Unit (IPU) E2000
line of products is going to be submitted in three parts:

1. Allow for multiple consumers in the Inter-Driver Communication (IDC)
interface and modify ice to use the generalized IDC definitions. 

2. Adapt idpf to the IDC definitions and add RDMA support to idpf.

3. Add RDMA RoCEv2 support for the E2000 products, referred to as GEN3
in irdma.

This first part is a single patch - "iidc/ice/irdma: Update IDC to support
multiple consumers" which allows for multiple consumers using auxiliary bus,
implementing an "ops" struct and core_dev_info struct.

This patch is based on v6.14-rc1.

[1] https://lore.kernel.org/intel-wired-lan/20250207194931.1569-1-tatyana.e.nikolova@intel.com/

Dave Ertman (1):
  iidc/ice/irdma: Update IDC to support multiple consumers

 drivers/infiniband/hw/irdma/main.c            | 110 ++++----
 drivers/infiniband/hw/irdma/main.h            |   3 +-
 drivers/infiniband/hw/irdma/osdep.h           |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  40 ++-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  46 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      | 255 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 include/linux/net/intel/idc_rdma.h            | 138 ++++++++++
 include/linux/net/intel/iidc.h                | 107 --------
 include/linux/net/intel/iidc_rdma.h           |  67 +++++
 14 files changed, 527 insertions(+), 284 deletions(-)
 create mode 100644 include/linux/net/intel/idc_rdma.h
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h

-- 
2.37.3


