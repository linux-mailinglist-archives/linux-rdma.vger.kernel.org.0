Return-Path: <linux-rdma+bounces-7461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC3A2997E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C9168D91
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1B1FECB8;
	Wed,  5 Feb 2025 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHJAUnew"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236213D897;
	Wed,  5 Feb 2025 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781725; cv=none; b=rEIdDauqpoex2Ope32F7ORr9grG0U2Dn7a2NKa0b++CAM1seJ75Vfhd2bL1kYQUY1zun58azVzEP2XShoyPvldofdKKKs9umplXICJNoib3BJOYMhWAE/340yqz7aelKwPgyHXxXkU9y6M9O4ce16nETy0iZonz/1BL4RZt5hYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781725; c=relaxed/simple;
	bh=blZzStUguJTPF9r5EOq/Fb29tZGv11ajgYw7BqZJ2qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MnJeIa2z47yghoImaF5lMu9WgsJGeoRJi6DctTPlvt1PJ44mMFXGqEqcZ4m3z0Ossw7xMbMVPGbxeTCWZZrxhjA+5FWZ4cgfL8CgS+zLr6Wkl+e59rBvKeA7vmOxPmugtK8+o4gCedKYZQG8FJGWn1udrPIx4icY3eZdhZrOau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHJAUnew; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738781724; x=1770317724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=blZzStUguJTPF9r5EOq/Fb29tZGv11ajgYw7BqZJ2qQ=;
  b=kHJAUnewi/++uM0v1rtaBvCFYPzpGnR0q76Zjc6Ddvr9VGKu+rd6qAvV
   pWvEdYdJJRiWBNWyLSq+FrTpGmioXN1KSi3if33eeuyAn6QIRrxSOm4Pq
   vwNYovir8/f7zd/KCVWCpwyOGjkuGL3CxgoNStq8+PZ85RnacI843ByRN
   PlSzid4T4iBis3yZhfIDCgi/ic1I1FACbcd11+5NkO9iCEN1yDMh2dNKl
   fUptv7Q4T6YasF8QSjPMd4lFuc8o8XNMOe/o1Pm2svvgmKgxW1J47+1tO
   FMwE/k1a95K+5eVj5ZaieaNFLyZ6TNBVT67wuB9gUM7bm8wUTesO8TgSH
   w==;
X-CSE-ConnectionGUID: mJSiLmEtQHe+OgvwDf632Q==
X-CSE-MsgGUID: UaYC8WXZS/qKrn/1l7YnPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61834382"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="61834382"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 10:55:23 -0800
X-CSE-ConnectionGUID: +rJqBstpRImIWpG4ngLcAw==
X-CSE-MsgGUID: L9559HeDT0201GKnkVuq3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="111515237"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 05 Feb 2025 10:55:21 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	tatyana.e.nikolova@intel.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v2 0/9][pull request] ice: managing MSI-X in driver
Date: Wed,  5 Feb 2025 10:55:00 -0800
Message-ID: <20250205185512.895887-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit c2933b2befe25309f4c5cfbea0ca80909735fd76:

  Merge tag 'net-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-30 12:24:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git for-next

for you to fetch changes up to d67627e7b53203ca150e54723abbed81a0716286:

  ice: init flow director before RDMA (2025-02-05 09:04:58 -0800)

----------------------------------------------------------------
Michal Swiatkowski says:

It is another try to allow user to manage amount of MSI-X used for each
feature in ice. First was via devlink resources API, it wasn't accepted
in upstream. Also static MSI-X allocation using devlink resources isn't
really user friendly.

This try is using more dynamic way. "Dynamic" across whole kernel when
platform supports it and "dynamic" across the driver when not.

To achieve that reuse global devlink parameter pf_msix_max and
pf_msix_min. It fits how ice hardware counts MSI-X. In case of ice amount
of MSI-X reported on PCI is a whole MSI-X for the card (with MSI-X for
VFs also). Having pf_msix_max allow user to statically set how many
MSI-X he wants on PF and how many should be reserved for VFs.

pf_msix_min is used to set minimum number of MSI-X with which ice driver
should probe correctly.

Meaning of this field in case of dynamic vs static allocation:
- on system with dynamic MSI-X allocation support
 * alloc pf_msix_min as static, rest will be allocated dynamically
- on system without dynamic MSI-X allocation support
 * try alloc pf_msix_max as static, minimum acceptable result is
 pf_msix_min

As Jesse and Piotr suggested pf_msix_max and pf_msix_min can (an
probably should) be stored in NVM. This patchset isn't implementing
that.

Dynamic (kernel or driver) way means that splitting MSI-X across the
RDMA and eth in case there is a MSI-X shortage isn't correct. Can work
when dynamic is only on driver site, but can't when dynamic is on kernel
site.

Let's remove this code and move to MSI-X allocation feature by feature.
If there is no more MSI-X for a feature, a feature is working with less
MSI-X or it is turned off.

There is a regression here. With MSI-X splitting user can run RDMA and
eth even on system with not enough MSI-X. Now only eth will work. RDMA
can be turned on by changing number of PF queues (lowering) and reprobe
RDMA driver.

Example:
72 CPU number, eth, RDMA and flow director (1 MSI-X), 1 MSI-X for OICR
on PF, and 1 more for RDMA. Card is using 1 + 72 + 1 + 72 + 1 = 147.

We set pf_msix_min = 2, pf_msix_max = 128

OICR: 1
eth: 72
flow director: 1
RDMA: 128 - 74 = 54

We can change number of queues on pf to 36 and do devlink reinit

OICR: 1
eth: 36
RDMA: 73
flow director: 1

We can also (implemented in "ice: enable_rdma devlink param") turned
RDMA off.

OICR: 1
eth: 72
RDMA: 0 (turned off)
flow director: 1

After this changes we have a static base vector for SRIOV (SIOV probably
in the feature). Last patch from this series is simplifying managing VF
MSI-X code based on static vector.

Now changing queues using ethtool is also changing MSI-X. If there is
enough MSI-X it is always one to one. When there is not enough there
will be more queues than MSI-X.
----------------------------------------------------------------
netdev:
v1 --> v2: [10]
 * Remove extack message from min and max validate functions (patch 2)
 * Remove min check from ice_devlink_msix_max_pf_validate() and max
   check from ice_devlink_msix_min_pf_validate() (patch 2)
 * Add Tony's sign-off (all)

IWL [9]:

v8 --> v9: [8]
 * add tested-by tags
 * v8 was send incorrect, fix it here

v7 --> v8: [7]
 * fix unrolling in devlink parameters register function (patch 2)

v6 --> v7: [6]
 * use vu32 for devlink MSI-X parameters instead of u16 (patch 2)
 * < instead of <= for MSI-X min parameter validation (patch 2)
 * use u32 for MSI-X values (patch 2, 8)

v5 --> v6: [5]
 * set default MSI-X max value based on needs instead of const define
   (patch 3)

v4 --> v5: [4]
 * count combined queues in ethtool for case the vectors aren't mapped
   1:1 to queues (patch 1)
 * change min_t to min where the casting isn't needed (and can hide
   problems) (patch 4)
 * load msix_max and msix_min value after devlink reload; it accidentally
   wasn't added after removing loading in probe path to mitigate error
   from devl_para_driverinit...() (patch 2)
 * add documentation in develink/ice for new parameters (patch 2)

v3 --> v4: [3]
 * drop unnecessary text in devlink validation comments
 * assume that devl_param_driverinit...() shouldn't return error in
   normal execution path

v2 --> v3: [2]
 * move flow director init before RDMA init
 * fix unrolling RDMA MSI-X allocation
 * add comment in commit message about lowering control RDMA MSI-X
   amount

v1 --> v2: [1]
 * change permanent MSI-X cmode parameters to driverinit
 * remove locking during devlink parameter registration (it is now
   locked for whole init/deinit part)

[10] https://lore.kernel.org/netdev/20250203210940.328608-1-anthony.l.nguyen@intel.com/
[9] https://lore.kernel.org/netdev/20241203065817.13475-1-michal.swiatkowski@linux.intel.com/
[8] https://lore.kernel.org/netdev/20241114122009.97416-1-michal.swiatkowski@linux.intel.com/
[7] https://lore.kernel.org/netdev/20241104121337.129287-1-michal.swiatkowski@linux.intel.com/
[6] https://lore.kernel.org/netdev/20241028100341.16631-1-michal.swiatkowski@linux.intel.com/
[5] https://lore.kernel.org/netdev/20241024121230.5861-1-michal.swiatkowski@linux.intel.com/
[4] https://lore.kernel.org/netdev/20240930120402.3468-1-michal.swiatkowski@linux.intel.com/
[3] https://lore.kernel.org/netdev/20240808072016.10321-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20240801093115.8553-1-michal.swiatkowski@linux.intel.com/
[1] https://lore.kernel.org/netdev/20240213073509.77622-1-michal.swiatkowski@linux.intel.com/
----------------------------------------------------------------
Michal Swiatkowski (9):
      ice: count combined queues using Rx/Tx count
      ice: devlink PF MSI-X max and min parameter
      ice: remove splitting MSI-X between features
      ice: get rid of num_lan_msix field
      ice, irdma: move interrupts code to irdma
      ice: treat dyn_allowed only as suggestion
      ice: enable_rdma devlink param
      ice: simplify VF MSI-X managing
      ice: init flow director before RDMA

 Documentation/networking/devlink/ice.rst         |  11 +
 drivers/infiniband/hw/irdma/hw.c                 |   2 -
 drivers/infiniband/hw/irdma/main.c               |  46 +++-
 drivers/infiniband/hw/irdma/main.h               |   3 +
 drivers/net/ethernet/intel/ice/devlink/devlink.c | 102 +++++++++
 drivers/net/ethernet/intel/ice/ice.h             |  21 +-
 drivers/net/ethernet/intel/ice/ice_base.c        |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |   9 +-
 drivers/net/ethernet/intel/ice/ice_idc.c         |  64 ++----
 drivers/net/ethernet/intel/ice/ice_irq.c         | 275 +++++++----------------
 drivers/net/ethernet/intel/ice/ice_irq.h         |  13 +-
 drivers/net/ethernet/intel/ice/ice_lib.c         |  35 ++-
 drivers/net/ethernet/intel/ice/ice_main.c        |   6 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c       | 154 +------------
 include/linux/net/intel/iidc.h                   |   2 +
 15 files changed, 329 insertions(+), 424 deletions(-)

