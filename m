Return-Path: <linux-rdma+bounces-9456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02840A8A6A9
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEC319015A4
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Apr 2025 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9556922ACDA;
	Tue, 15 Apr 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/Ftay8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F9224B15;
	Tue, 15 Apr 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741353; cv=none; b=rSCTtUuSqmtuOqHFexp6IoSHsbRGwH7zFZQ8Yo+1ccUUKfDBpIBVVFUaANhGRxMzoXKu4gGiWRz6UPdxv/IMZpgNTyibpdRNxWvb1I6+azekkEokS4RVtPnUJEtiAjvTlAzaXpYF/L7DHVzp60DiR4JTS0kQFpSG49+qDLSAuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741353; c=relaxed/simple;
	bh=ACsz5+px0bR6kQmYG2+nzuzYCELnwAOWmMaj7t8P0E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lR6QF9xRJ1TToHTjNnU6qq4CQTcHMyvTErNxXQaVmSRed8xw54eY8AJl4vjmdV6fSwe7barXeb1n3MkTJ16b5WISJj2I6qGd8seQhzmk+DJjIoethK2GAEz8kDi1VereuiRp3+WOn2H1aV5zaaE7+RjHcnGnYfO77id4k9cUUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/Ftay8O; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744741349; x=1776277349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ACsz5+px0bR6kQmYG2+nzuzYCELnwAOWmMaj7t8P0E0=;
  b=I/Ftay8OOtQwjqnzYfC3gEdI74mKQOUKa5HgyCfovxGQVsRblIAkK2iE
   7hOTANX1B7dlhyLHIk92xMnxFbbGU3SsKtSeMiYFhgQTpvOndbZKL4BKy
   SMUJ2V9B2oVib9R3ekfjwwujRqHltnzvjoWAldhPae7yiM9hHyoQ1bxYg
   rAbJos1hXOsHgsQLWnvN7Hh1Zr11heh401YLqE2dmUeUU3w50kSpU0JmA
   XIUQJcTlp4hcTcA+jC2DVrEslS59tbLIVK6ei1KgP78SEYA+S9nlqc/xZ
   0u/xN/L4ByizafEtgk6EIuBiG7z4QDXU6qoj8yICIWmOjRepIO7Iqtpr6
   g==;
X-CSE-ConnectionGUID: hWSyUXedTsit/yY6e4hLsg==
X-CSE-MsgGUID: fZ/c78scTOWQzpn8/rJGmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="45981182"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45981182"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 11:22:29 -0700
X-CSE-ConnectionGUID: +z+arMk5Sjei11MzrSuWfQ==
X-CSE-MsgGUID: MD5N2tu/Q7SjEDDr4ACyUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130512705"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa008.fm.intel.com with ESMTP; 15 Apr 2025 11:21:25 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	jonathan.lemon@gmail.com,
	richardcochran@gmail.com,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v2 0/4] dpll: add all inputs phase offset monitor
Date: Tue, 15 Apr 2025 20:15:39 +0200
Message-Id: <20250415181543.1072342-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple dpll device level feature and capabilties infrastructure over
netlink dpll interface.
Using new infrastructure add new feature: ALL_INPUTS_PHASE_OFFSET_MONITOR.
Allow users control with two new attributes:
- DPLL_A_CAPABILITIES - for checking if dpll device is capable,
- DPLL_A_FEATURES - for enable/disable a features.
Implement feature in ice driver for dpll-enabled devices.

Verify capability:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[{'capabilities': set(),
  'clock-id': 4658613174691613800,
  'features': set(),
  'id': 0,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'type': 'eec'},
 {'capabilities': {'all-inputs-phase-offset-monitor'},
  'clock-id': 4658613174691613800,
  'features': set(),
  'id': 1,
  'lock-status': 'locked-ho-acq',
  'mode': 'automatic',
  'mode-supported': ['automatic'],
  'module-name': 'ice',
  'type': 'pps'}]

Enable the feature:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do device-set --json '{"id":1, \
 "features":"all-inputs-phase-offset-monitor"}'

Verify feature is enabled:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --dump device-get
[
 [...]
 {'capabilities': {'all-inputs-phase-offset-monitor'},
  'clock-id': 4658613174691613800,
  'features': {'all-inputs-phase-offset-monitor'},
  'id': 1,
 [...]
]

Disable the feature:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do device-set --json '{"id":1, \
 "features":0}'


Arkadiusz Kubalewski (4):
  dpll: use struct dpll_device_info for dpll registration
  dpll: add features and capabilities to dpll device spec
  dpll: features_get/set callbacks
  ice: add phase offset monitor for all PPS dpll inputs

 Documentation/netlink/specs/dpll.yaml         |  25 +++
 drivers/dpll/dpll_core.c                      |  34 +--
 drivers/dpll/dpll_core.h                      |   2 +-
 drivers/dpll/dpll_netlink.c                   |  86 +++++++-
 drivers/dpll/dpll_nl.c                        |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 195 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   7 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |  10 +-
 drivers/ptp/ptp_ocp.c                         |   7 +-
 include/linux/dpll.h                          |  16 +-
 include/uapi/linux/dpll.h                     |  13 ++
 15 files changed, 417 insertions(+), 36 deletions(-)


base-commit: bbfc077d457272bcea4f14b3a28247ade99b196d
-- 
2.38.1


