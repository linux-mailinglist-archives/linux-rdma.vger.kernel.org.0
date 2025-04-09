Return-Path: <linux-rdma+bounces-9297-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0863DA82AA3
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 17:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20E61B62339
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C66266B4D;
	Wed,  9 Apr 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BewS2i+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD91482F5;
	Wed,  9 Apr 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212715; cv=none; b=pQq38+D9FuToA11ZH6FV+WEtzcTHqsqrSZ12WvkRrRCSZA4PWRk7D+S+n1MjTd3k5xUu4ngB6CW52wII5Z/2JMmBGfP83WxqbdmNavfrsFviWwmWis/bvM19n5DgOlcJQGqTyo796RWqeCWyZ45Vy2hkenu6aQTb8K1Yrge327Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212715; c=relaxed/simple;
	bh=0x1dvjO2FZF9lCAIOsZJnj7gZRIyKdsq/t4wPmc2CzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=msuFjLNYIY9B/3aJRRBPplceOIdNkx3K+xTXvCFtyG5dtToiV5DwqfS0/gIzrUIe926UGUqqLsk98TD8JolGH2NdAdsP0C8lqu0G4pLrXasrhdlLu7dUb1PCv/2kbI6QFWP0N1FRUkEvzRcfV+6bbbCUHsjQH0F9mipFBRNetuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BewS2i+k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212714; x=1775748714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0x1dvjO2FZF9lCAIOsZJnj7gZRIyKdsq/t4wPmc2CzQ=;
  b=BewS2i+k3PSEnIf0L9Ppy3rfZqSIvzV6OVvPllXyGd6hPIQ6TseaH4Vd
   xJ8uEzY8EqbAQzWXNKvCgj+8EmjZSFVFls1dlOoBJc8UY7UxEsja9/DBW
   IH1TPTxqUdPtL7CSh54C9qjl8n/t2vJgANk7tl0MKceLf16a3tcenlaMo
   XXeoSW5Xb4wlEWNnF09W1v/bXNwnB6NwJoR1d1WuU1yklwzitx4guRNnh
   Ly5zpThdc5Jf53lWSRSljr8EysKPKt6o9e25fX5IWUSTymbvzf2FrL+ct
   SQizg0gciGxaD/S5tBUmpZiNP+PKiEggHzQN9GhEGdV4IWH8nJ48LC2//
   A==;
X-CSE-ConnectionGUID: PSOSY5XIRwu6ZUr/o8AnuQ==
X-CSE-MsgGUID: VC8UV+IXTKWGwAmHDMDleg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="71072082"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="71072082"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:31:53 -0700
X-CSE-ConnectionGUID: 31pjvctNTSOH6O3KCL536Q==
X-CSE-MsgGUID: qgtNr2MDS+6UjXITr6JEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="151795982"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 09 Apr 2025 08:31:49 -0700
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
Subject: [PATCH net-next v1 0/4] dpll: add all inputs phase offset monitor
Date: Wed,  9 Apr 2025 17:25:54 +0200
Message-Id: <20250409152558.1007335-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple dpll device level feature and capabilities infrastructure over
netlink dpll interface.
Using new infrastructure add new feature: ALL_INPUTS_PHASE_OFFSET_MONITOR.
Allow users control with two new attributes:
- DPLL_A_CAPABILITIES - for checking if dpll device is capable,
- DPLL_A_FEATURES - for enable/disable a features.
Implement feature in ice driver for dpll-enabled devices.

Arkadiusz Kubalewski (4):
  dpll: add features and capabilities to dpll device spec
  dpll: pass capabilities on device register
  dpll: features_get/set callbacks
  ice: add phase offset monitor for all PPS dpll inputs

 Documentation/netlink/specs/dpll.yaml         |  25 +++
 drivers/dpll/dpll_core.c                      |   5 +-
 drivers/dpll/dpll_core.h                      |   2 +
 drivers/dpll/dpll_netlink.c                   |  78 +++++++-
 drivers/dpll/dpll_nl.c                        |   5 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  20 ++
 drivers/net/ethernet/intel/ice/ice_common.c   |  26 +++
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 188 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   4 +
 .../net/ethernet/mellanox/mlx5/core/dpll.c    |   2 +-
 drivers/ptp/ptp_ocp.c                         |   2 +-
 include/linux/dpll.h                          |   7 +-
 include/uapi/linux/dpll.h                     |  13 ++
 15 files changed, 374 insertions(+), 12 deletions(-)


base-commit: 420aabef3ab5fa743afb4d3d391f03ef0e777ca8
-- 
2.38.1


