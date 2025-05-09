Return-Path: <linux-rdma+bounces-10231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 704F5AB1DB8
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C63B21A5E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2F25EFAA;
	Fri,  9 May 2025 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOcR6W9X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707425E83D;
	Fri,  9 May 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821241; cv=none; b=QjT13bZZ5hx7tJgAmgW6CcZUX1+B6/oeUS4uKXN200iUqjaGJf/6DsPaAW+xNHzVwjZ5+T/qRPc6V6tMtst1Jzhp4uVaHkVrKYi/4lsmrZOV4ZGMdG1QDWIrV39Mxts9fEg1R6x1DwAPm+eFJ3pfdHpRK5MySq5JVWNnM58758A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821241; c=relaxed/simple;
	bh=qY0noNp0Yi5CsBV66H4PkVTpw4dzy8bdU36oXBSY9EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwtZmSj992cRpPZLB/fHrPoqNR0uxkWXiorNCP4d26ouD8kvEjrt+qONHyHIX0hMiwqwuKXb6sz/wO9GetEqW29wLac5ZarfmNdS2oms/Dpi5TrXruaE8mu49mdEiuiq66Sz/ykS3/ygShxKIGHtXVnBTjT+DJyEbDhRKkzLPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOcR6W9X; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746821239; x=1778357239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qY0noNp0Yi5CsBV66H4PkVTpw4dzy8bdU36oXBSY9EQ=;
  b=QOcR6W9X5Eh4HOBtAqxYQn8f2oL+pUcwWRTL2KFgZx2aaBFPOgylT7pt
   Ug6cqnq5MY7iV/IrRcask143nBSC3vzJXwIeHwZyIbtvkb45bD4QrR1yP
   0jJZSSLI/CjnaX5hqSO+xwZpz+sFJkz7IKAP1kChfYLQZF8FTnuuMxHjG
   HUpNIIAGbHAGpw9lCg4IFnnfS0SjK0YlAZAMadiHmlquOVWpQVEUsFhgb
   3vTWqvxs7NtdWEK8ui2k7jV6gzKHrUfsWHmnpyEAH04EZZuW27iifEnYu
   nilEhNQYzEzAcJV+eN28HDcp6myJ7fxSsXUGBKngjk8JF2V/ExZpcJbWI
   A==;
X-CSE-ConnectionGUID: OK5n04UvSIGckuOqK0A1GQ==
X-CSE-MsgGUID: JPICBzDxSiGlnMGdOZAFYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36289872"
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="36289872"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 13:07:18 -0700
X-CSE-ConnectionGUID: gb2bat9jSVu3wpnZJpd3JQ==
X-CSE-MsgGUID: DeHAmubxSuyvbUSNh0FAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,276,1739865600"; 
   d="scan'208";a="140780366"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 May 2025 13:07:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	tatyana.e.nikolova@intel.com,
	david.m.ertman@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH net-next,rdma-next v2 0/5][pull request] Prepare for Intel IPU E2000 (GEN3)
Date: Fri,  9 May 2025 13:07:06 -0700
Message-ID: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first part in introducing RDMA support for idpf.
This shared pull request targets both net-next and rdma-next branches
and is based on tag v6.15-rc1.

v2:
- Free cdev_info and iidc_priv in ice_deinit_rdma() (patch 5)

v1: https://lore.kernel.org/all/20250505212037.2092288-1-anthony.l.nguyen@intel.com/

IWL reviews:
[v5] https://lore.kernel.org/all/20250416021549.606-1-tatyana.e.nikolova@intel.com/
[v4] https://lore.kernel.org/all/20250225050428.2166-1-tatyana.e.nikolova@intel.com/
[v3] https://lore.kernel.org/all/20250207194931.1569-1-tatyana.e.nikolova@intel.com/
[v2] https://lore.kernel.org/all/20240824031924.421-1-tatyana.e.nikolova@intel.com/
[v1] https://lore.kernel.org/all/20240724233917.704-1-tatyana.e.nikolova@intel.com/

There are a few minor conflicts that exist with this series and the
respective trees:

net-next:
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@@ -9341,9 -9310,8 +9341,10 @@@ ice_setup_tc(struct net_device *netdev
             void *type_data)
  {
        struct ice_netdev_priv *np = netdev_priv(netdev);
 +      enum flow_block_binder_type binder_type;
+       struct iidc_rdma_core_dev_info *cdev;
        struct ice_pf *pf = np->vsi->back;
 +      flow_setup_cb_t *flower_handler;
        bool locked = false;
        int err;

RDMA for-rc series [1] (showing direct conflicts):
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@@ -221,8 -221,8 +221,8 @@@ static int irdma_init_interrupts(struc
                        break;

        if (i < IRDMA_MIN_MSIX) {
-               for (; i > 0; i--)
+               while (--i >= 0)
 -                      ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
 +                      ice_free_rdma_qvector(cdev, &rf->msix_entries[i]);

                kfree(rf->msix_entries);
                return -ENOMEM;


@@@ -245,40 -245,35 +245,42 @@@ static void irdma_deinit_interrupts(str

  static void irdma_remove(struct auxiliary_device *aux_dev)
  {

...

+       kfree(iwdev->rf);
+
 -      pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(pf->pdev->devfn));
 +      pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(cdev_info->pdev->devfn));
  }

[1] https://lore.kernel.org/linux-rdma/174514658010.719262.13870226048967432907.b4-ty@kernel.org/

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/linux.git for-next

for you to fetch changes up to c24a65b6a27c78d8540409800886b6622ea86ebf:

  iidc/ice/irdma: Update IDC to support multiple consumers (2025-05-09 11:35:43 -0700)

----------------------------------------------------------------
Tatyana Nikolova says:

To align with review comments, the patch series introducing RDMA
RoCEv2 support for the Intel Infrastructure Processing Unit (IPU)
E2000 line of products is going to be submitted in three parts:

1. Modify ice to use specific and common IIDC definitions and
   pass a core device info to irdma.

2. Add RDMA support to idpf and modify idpf to use specific and
   common IIDC definitions and pass a core device info to irdma.

3. Add RDMA RoCEv2 support for the E2000 products, referred to as
   GEN3 to irdma.

This first part is a 5 patch series based on the original
"iidc/ice/irdma: Update IDC to support multiple consumers" patch
to allow for multiple CORE PCI drivers, using the auxbus.

Patches:
1) Move header file to new name for clarity and replace ice
   specific DSCP define with a kernel equivalent one in irdma
2) Unify naming convention
3) Separate header file into common and driver specific info
4) Replace ice specific DSCP define with a kernel equivalent
   one in ice
5) Implement core device info struct and update drivers to use it

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

----------------------------------------------------------------
Dave Ertman (4):
  iidc/ice/irdma: Rename IDC header file
  iidc/ice/irdma: Rename to iidc_* convention
  iidc/ice/irdma: Break iidc.h into two headers
  iidc/ice/irdma: Update IDC to support multiple consumers

Tatyana Nikolova (1):
  ice: Replace ice specific DSCP mapping num with a kernel define

 MAINTAINERS                                   |   2 +-
 drivers/infiniband/hw/irdma/main.c            | 125 ++++++-----
 drivers/infiniband/hw/irdma/main.h            |   3 +-
 drivers/infiniband/hw/irdma/osdep.h           |   2 +-
 drivers/infiniband/hw/irdma/type.h            |   4 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  45 +++-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |  47 +++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |   9 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      | 207 +++++++++++-------
 drivers/net/ethernet/intel/ice/ice_idc_int.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 include/linux/net/intel/iidc.h                | 109 ---------
 include/linux/net/intel/iidc_rdma.h           |  68 ++++++
 include/linux/net/intel/iidc_rdma_ice.h       |  70 ++++++
 19 files changed, 452 insertions(+), 288 deletions(-)
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h
 create mode 100644 include/linux/net/intel/iidc_rdma_ice.h

