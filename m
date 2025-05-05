Return-Path: <linux-rdma+bounces-9979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD06DAA9DEE
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA5F189F358
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AE426FA4C;
	Mon,  5 May 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gw8DHIM+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7525A2AA;
	Mon,  5 May 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480057; cv=none; b=HYqr92CuMFaeRcQZNRJ39Bps3tsl98J+mDcDYj1TXyYA9xwtfyty1pLTDPO5NA6g7dtCMb5iI7bKtqW2CPT75ueLHSbEAIy5sVxPGE+qUuzurtK9IMrhgw5rVo4fx+mcERUxYD3ZYoYKQBsZDthK562YLwiOf37WzRxKUMWIISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480057; c=relaxed/simple;
	bh=wgAaW/NfV8YKTFUVADXC4wAnf8itqyWKdPvOxGbGlGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQd6YzWGpvdd72/t7R1GROgsoLTjKAyr3XLHO5Ibpkb44ithUbI4H5pKhhiBa+ri8I0pULz2nGaRRbesf3rSkbldzXh9QWJWqmTnX62EUfXzHZAH1VcltEuyxCXy4hDu//IFQ3EgATpSYKXrhQ3Whld3qPwMsa1Rm7KuR6Shj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gw8DHIM+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746480055; x=1778016055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wgAaW/NfV8YKTFUVADXC4wAnf8itqyWKdPvOxGbGlGg=;
  b=gw8DHIM+tvrJah5zFH0FS11yvyJh5LOEPobuftP6pFkJx45EsehDG8Lp
   5pLVUEKbm0gS3AlgEClefEQXkKJM+pq7WeoLO8rUILhSKIt5TAvA3jz7K
   uRSPzOGzK7VigbwoR+e4hpWO1bnjXHhan2jtQqz/Bzy6SVhnvbN1ejMVf
   CIXmw0egYPZ1z43YyuJuPy4cTrMAXE2/zVGlyhJv2bOVYcD0X+4SzY8X2
   s7WmupCie9orLiI2PbHRfQZ9j3Re3A19ONgQLS5k6EHCqNtIEpGkVcwdf
   0rEqhdLVSOkqyoDessVRSp/GOjPq2ApFXJcf0QOLFFJBR9iVH7vJ7JlXW
   w==;
X-CSE-ConnectionGUID: fvQA6iYZROmOwGIiIy34+A==
X-CSE-MsgGUID: sruRpCWISkS5ePwV/HyhZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51762212"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="51762212"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 14:20:54 -0700
X-CSE-ConnectionGUID: 8TfuSweETb6fH4JG2v98aA==
X-CSE-MsgGUID: Ky3HfmB3TWqxTwJX6r4ZPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="140352867"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 May 2025 14:20:53 -0700
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
Subject: [PATCH net-next,rdma-next 0/5][pull request] Prepare for Intel IPU E2000 (GEN3)
Date: Mon,  5 May 2025 14:20:29 -0700
Message-ID: <20250505212037.2092288-1-anthony.l.nguyen@intel.com>
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

for you to fetch changes up to 8d7be3651c9a6c2b5bc952356536cbd9f4a722b2:

  iidc/ice/irdma: Update IDC to support multiple consumers (2025-04-30 13:22:27 -0700)

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

 MAINTAINERS                                      |   2 +-
 drivers/infiniband/hw/irdma/main.c               | 125 +++++++-------
 drivers/infiniband/hw/irdma/main.h               |   3 +-
 drivers/infiniband/hw/irdma/osdep.h              |   2 +-
 drivers/infiniband/hw/irdma/type.h               |   4 +-
 drivers/net/ethernet/intel/ice/devlink/devlink.c |  45 +++--
 drivers/net/ethernet/intel/ice/ice.h             |   6 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c         |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c     |  47 +++++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h     |   9 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |   8 +-
 drivers/net/ethernet/intel/ice/ice_idc.c         | 204 ++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_idc_int.h     |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c        |  18 +-
 drivers/net/ethernet/intel/ice/ice_type.h        |   6 +-
 include/linux/net/intel/iidc.h                   | 109 ------------
 include/linux/net/intel/iidc_rdma.h              |  68 ++++++++
 include/linux/net/intel/iidc_rdma_ice.h          |  70 ++++++++
 19 files changed, 449 insertions(+), 288 deletions(-)
 delete mode 100644 include/linux/net/intel/iidc.h
 create mode 100644 include/linux/net/intel/iidc_rdma.h
 create mode 100644 include/linux/net/intel/iidc_rdma_ice.h

