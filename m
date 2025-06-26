Return-Path: <linux-rdma+bounces-11683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209BAE9F91
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB7B7A1805
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 13:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE22E7623;
	Thu, 26 Jun 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/v6Raqo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3928ECC0;
	Thu, 26 Jun 2025 13:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946312; cv=none; b=b9DbBEDsmmaME4EDDJw1cEeNUsHk2xw/xMrOq23DOZa1zsFC0PcVw2p8PbBBNGxDCRptMKT+e11HVM6qiHVA3O4V/WhAAbxEx3OI4HeDyFD8Oddk4w97sYty5/YEFrBO1ieL6JZL9I7Gn7m0ydfGQj3RHAdAORSAcXQ9sEnkmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946312; c=relaxed/simple;
	bh=LZmA8ttWnDAr8Uh4klCVaH26g2w+YXVeEc7SBMwb/eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vGSTo3WPCSI25ns7T2NV/5ASBrsZ64qqWLp1hR8TEvuMiy72osFhxf1ZXMDKZxK5sQ1VBe7aRXQ7PVN5RdzSkN32dFQktCY/03FNocDQYlwp64VrOoC9fVdd1WyiFOQ2Mp27P0DWSkxfpnD0aqfo7guihIFUVwSN0RwS+yAZP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/v6Raqo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946310; x=1782482310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LZmA8ttWnDAr8Uh4klCVaH26g2w+YXVeEc7SBMwb/eg=;
  b=R/v6RaqoiwJPXivt7Bz4r8gOmAEQrZn1F7ubkQHDCRyb8KIMqOyHRhPX
   YcUdkbE+jTkQvCCZSMlgXKKCRHxbKSz/0Xvbs/xev/iYQ2+Brbv0xvcRg
   IICB9pQUGm1nGU/oTnC7Z8MFrEatE5V57O/ux5fLwU0m6DTa+1ySVif9X
   K/tGMebRM3ElRx3XniqlvfK8ztZVw2z95wmFdccvF0VGSjr2gHhwqNia0
   6vs2Tpi7V8rOTCwUM0LMZqPXGFQ/TJiB6bUBaobGdEmO3sJCNAFCpKOPy
   ke9LBymeJJaYquGGWsMuZXKX4uBuSSG5Usgqdhrxao3GxUgYgw5a1zGHO
   w==;
X-CSE-ConnectionGUID: 3jDTtHxQTOG1OUqLrl87qA==
X-CSE-MsgGUID: EhrkMJWITnWvlexmRjPfpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="40859197"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="40859197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:58:29 -0700
X-CSE-ConnectionGUID: JKVS4KjETBmw4kA+ZqzBOQ==
X-CSE-MsgGUID: pFhsH76tS5iin3XHLcN6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="158271309"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa005.jf.intel.com with ESMTP; 26 Jun 2025 06:58:26 -0700
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
Subject: [PATCH net-next v7 0/3] dpll: add Reference SYNC feature
Date: Thu, 26 Jun 2025 15:52:16 +0200
Message-Id: <20250626135219.1769350-1-arkadiusz.kubalewski@intel.com>
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
clock signals from both inputs are used to synchronize the DPLL device.
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

v7:
- rebase.

Arkadiusz Kubalewski (3):
  dpll: add reference-sync netlink attribute
  dpll: add reference sync get/set
  ice: add ref-sync dpll pins

 Documentation/driver-api/dpll.rst             |  25 ++
 Documentation/netlink/specs/dpll.yaml         |  19 ++
 drivers/dpll/dpll_core.c                      |  45 +++
 drivers/dpll/dpll_core.h                      |   2 +
 drivers/dpll/dpll_netlink.c                   | 190 ++++++++++--
 drivers/dpll/dpll_netlink.h                   |   2 +
 drivers/dpll/dpll_nl.c                        |  10 +-
 drivers/dpll/dpll_nl.h                        |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 284 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_dpll.h     |   2 +
 include/linux/dpll.h                          |  13 +
 include/uapi/linux/dpll.h                     |   1 +
 13 files changed, 575 insertions(+), 21 deletions(-)


base-commit: 5cfb2ac2806c7a255df5184d86ffca056cd5cb5c
-- 
2.38.1


