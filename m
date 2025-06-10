Return-Path: <linux-rdma+bounces-11121-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15180AD2C6E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 06:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D7F3B0C43
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 04:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A625D20D;
	Tue, 10 Jun 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGL5tcjG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EB2111;
	Tue, 10 Jun 2025 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528635; cv=none; b=n8S4P/eBfAdZEVLKL6ixEXPYx+Lil0RQjIn6g2JagSJfkx32xL8g+7JlJB0FwDx4slK+QNussMOim3hs5crw+Ks4k8Nc28Ullt60cwd4MbBew6IQEKn8pcAc+HYcBufCO/Z2CUSIFrqpVuuSD78K0GAiybPBtBkhmjD+ev+Kt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528635; c=relaxed/simple;
	bh=konwx4TqwyV3uPebPxqhKw7vEEIPBBjeI6qqhlvGDlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hccm+HyqpsZa79dSwL4ZP1n+eiGi6OCzP20Tv0qQuEAbI7xyK3oJytVEtxGOwqBLnQRTfMHu3CfnjbZOIx/e3pvxuRYfTMPa8R8HLTjiU4BqrDOoGHUq70oJ6pMsIvbH4GJLWFilL0TnRODtuo2H5gX9d49v333uADDSp1gZ9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGL5tcjG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749528633; x=1781064633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=konwx4TqwyV3uPebPxqhKw7vEEIPBBjeI6qqhlvGDlc=;
  b=KGL5tcjGd31ttx1h/syjJUi+Ovjh6Ah7Xmke6ddtTbRxCRwWu5cfI2Rx
   nAuryVfRM1YE25BMYZolZF/jnLqecUjeDXUDWkBkHXQ3LYFB853fsPVn3
   vZjZlz+k/OwuDlgbcUsdp0ac5gYwiGg48TrIVXNnzxWH0qXWTY7FJcKvw
   +tWb86Jxx65tzF2775pp9orQJPl1g+Y6mFG12A8WiNZyUlya1xW5xj3eY
   cjDD9/v2n6wgt/EBM0sJUksljznAYTKiOUFQ37g0C4u3hFB9oGAUfWrU5
   twzvGwCxRyhL+XgAJoosrcfpQWdSTvx3W7DqU+Wk/HydCWu8Cf3vdvjLr
   Q==;
X-CSE-ConnectionGUID: OvO+IDxcSayVx6jnUuJihw==
X-CSE-MsgGUID: j/agA0ZSToiGHMB/Mi4MFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51613152"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51613152"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 21:10:32 -0700
X-CSE-ConnectionGUID: g1m50XhOTBaRFLm8w8ZsPw==
X-CSE-MsgGUID: eTy5Q9CsTCu+JzVJ7G/JIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="177646691"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa002.jf.intel.com with ESMTP; 09 Jun 2025 21:10:28 -0700
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
	aleksandr.loktionov@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v5 0/3] dpll: add Reference SYNC feature
Date: Tue, 10 Jun 2025 06:04:33 +0200
Message-Id: <20250610040436.1669826-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device may support the Reference SYNC feature, which allows the
combination of two inputs into a input pair. In this configuration,
clock signals from both inputs are used to synchronize the dpll device.
The higher frequency signal is utilized for the loop bandwidth of the DPLL,
while the lower frequency signal is used to syntonize the output signal of
the DPLL device. This feature enables the provision of a high-quality loop
bandwidth signal from an external source.

A capable input provides a list of inputs that can be bound with to create
Reference SYNC. To control this feature, the user must request a
desired state for a target pin: use ``DPLL_PIN_STATE_CONNECTED`` to
enable or ``DPLL_PIN_STATE_DISCONNECTED`` to disable the feature. An input
pin can be bound to only one other pin at any given time.

Verify pins bind state/capabilities:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-get \
 --json '{"id":0}'
{'board-label': 'CVL-SDP22',
 'id': 0,
 [...]
 'reference-sync': [{'id': 1, 'state': 'disconnected'}],
 [...]}

Bind the pins by setting connected state between them:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-set \
 --json '{"id":0, "reference-sync":{"id":1, "state":"connected"}}'

Verify pins bind state:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-get \
 --json '{"id":0}'
{'board-label': 'CVL-SDP22',
 'id': 0,
 [...]
 'reference-sync': [{'id': 1, 'state': 'connected'}],
 [...]}

Unbind the pins by setting disconnected state between them:
$ ./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/dpll.yaml \
 --do pin-set \
 --json '{"id":0, "reference-sync":{"id":1, "state":"disconnected"}}'

v5:
- align description with the documentation changes,
- rebase.

Arkadiusz Kubalewski (3):
  dpll: add reference-sync netlink attribute
  dpll: add reference sync get/set
  ice: add ref-sync dpll pins

 Documentation/driver-api/dpll.rst             |  25 +++
 Documentation/netlink/specs/dpll.yaml         |  19 ++
 drivers/dpll/dpll_core.c                      |  45 +++++
 drivers/dpll/dpll_core.h                      |   2 +
 drivers/dpll/dpll_netlink.c                   | 190 ++++++++++++++++--
 drivers/dpll/dpll_netlink.h                   |   2 +
 drivers/dpll/dpll_nl.c                        |  10 +-
 drivers/dpll/dpll_nl.h                        |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 +++++++++++++++++
 include/linux/dpll.h                          |  13 ++
 include/uapi/linux/dpll.h                     |   1 +
 12 files changed, 475 insertions(+), 21 deletions(-)


base-commit: 2c7e4a2663a1ab5a740c59c31991579b6b865a26
-- 
2.38.1


