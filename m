Return-Path: <linux-rdma+bounces-10551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090BBAC1127
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE8A22464
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767CD28C875;
	Thu, 22 May 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxzAbpMy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76051248862;
	Thu, 22 May 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931749; cv=none; b=pFwrunwBQBRo6Z9yCux4+TOIu3vd8qCiB0Lp9jRiS9jLmD5BSCeTqmBoLFrH5VlEy33xGapga5Pp6ubjUMRFjVJilHmaKsf/ohuHegmb1hIXD+8AjUaHmiEZgNd9PFAjCoxdtwtTXoy2iuqn5kAlH3p0jiqP7V0AnyAQ0lz//HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931749; c=relaxed/simple;
	bh=ux9eZaPRebseznFfCMQVDgdu76v+ODiKx1nrwgRY7uY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRNhd2W69QRFsSGmjDeWHCPRS6zZSVp1pvT7gTY3fZPHsxledat3VnCrb+HG3P949CmDa6IzOfvPemVVemYFQsO9WXrXE7MqUPWuau1z7uQI9useysIAyEW0o/CxNJF0y1cc1WDvQt4PPd8FEL9L1Ms7QVmaiVD51Ew0U8BC3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxzAbpMy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747931748; x=1779467748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ux9eZaPRebseznFfCMQVDgdu76v+ODiKx1nrwgRY7uY=;
  b=mxzAbpMyKlHQuZ9GUoLLSZD0gPzxppvRMwercBiwLo/HV+CKJ26K6W9o
   3DHLOOGw+yirprZJqmgg3WlBmq0ZG2WprDgdMsjMJ/taLnPYvrqTRexFY
   LP8k6h+awJ6Nl1vVZvCAoSTzh6/nxHH+R/Q1+E6X8FKAisC6di1v5AwpW
   XTxVxsOyit5UIw4JTYfLyfbJR/xB5qGaFH+ld6TretUvf40h/bTgzeV/l
   2uz3h7BVps6MVKMuS/4HgKXkuxXIgRmhWzIb3G1osrzDrDlknoSckqDpa
   9eRubHyS13+2ofzY6pP/7I2neoGTxQuxRczSQxPEgQklq9djSyHG21EAF
   g==;
X-CSE-ConnectionGUID: A5K775xTTceD33WfZD1F7A==
X-CSE-MsgGUID: KEPc6NbOTg2/9qqNUOlMUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49889025"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49889025"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:35:47 -0700
X-CSE-ConnectionGUID: a6/QFpl9RSWoEr/nOLM3sQ==
X-CSE-MsgGUID: WjNNFZnOQTmzoaUNJRYBHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145631339"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 22 May 2025 09:35:42 -0700
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
Subject: [PATCH net-next v3 0/3] dpll: add Reference SYNC feature
Date: Thu, 22 May 2025 18:29:35 +0200
Message-Id: <20250522162938.1490791-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device may support the Reference SYNC feature, which allows the
combination of two inputs into a Reference SYNC pair. In this
configuration, clock signals from both inputs are used to synchronize
the dpll device. The higher frequency signal is utilized for the loop
bandwidth of the DPLL, while the lower frequency signal is used to
syntonize the output signal of the DPLL device. This feature enables
the provision of a high-quality loop bandwidth signal from an external
source.

A capable input provides a list of inputs that can be paired to create
a Reference SYNC pair. To control this feature, the user must request a
desired state for a target pin: use ``DPLL_PIN_STATE_CONNECTED`` to
enable or ``DPLL_PIN_STATE_DISCONNECTED`` to disable the feature. Only
two pins can be bound to form a Reference SYNC pair at any given time.

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

v3:
- no change.

Arkadiusz Kubalewski (3):
  dpll: add reference-sync netlink attribute
  dpll: add reference sync get/set
  ice: add ref-sync dpll pins

 Documentation/driver-api/dpll.rst             |  25 +++
 Documentation/netlink/specs/dpll.yaml         |  19 ++
 drivers/dpll/dpll_core.c                      |  27 +++
 drivers/dpll/dpll_core.h                      |   2 +
 drivers/dpll/dpll_netlink.c                   | 188 ++++++++++++++++--
 drivers/dpll/dpll_nl.c                        |  10 +-
 drivers/dpll/dpll_nl.h                        |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 186 +++++++++++++++++
 include/linux/dpll.h                          |  10 +
 include/uapi/linux/dpll.h                     |   1 +
 11 files changed, 451 insertions(+), 20 deletions(-)


base-commit: 4ff4d86f6cceb6bea583bdb230e5439655778cce
-- 
2.38.1


