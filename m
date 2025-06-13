Return-Path: <linux-rdma+bounces-11307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5412BAD95F8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 22:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BBF3BADBD
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 20:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE11246774;
	Fri, 13 Jun 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCtdbqq6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C72343B6;
	Fri, 13 Jun 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845583; cv=none; b=eX/+chosiQxGfX6pnBTXNRwloztWZGd7wSoFOZ6W3ced9nTd50DcLxp210xI3uKqUNJzg1rag6ksZHFPIb9qMu26MiWaN2TZIA+Qn7QTlob6lbLvipqzPcKrTkGsn1eMhcVtQ4ZL2ivfZalmLkJRkDyqGZZzFIKcM8fGPmvbUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845583; c=relaxed/simple;
	bh=kD2ynVceQcdQa7T8ECS2SFeAwaNQpSN34BKH9Gb6w4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljoaBQrxQ0nJ6jtTpgkvzxWRc4gd/bBeKwIgmiTg291ALIVhuJ5UNtMk/AVgh81d5MBLZj0eTY4gpkipkFYSj/LFKHmSAqtoqVauFL1rUIPRJvzrSQ2JlOCEon2dXC2jOZlZ8ArQV52YhdKfpODCjqSDsj3whDFQnHRh8zkLpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCtdbqq6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749845582; x=1781381582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kD2ynVceQcdQa7T8ECS2SFeAwaNQpSN34BKH9Gb6w4Q=;
  b=iCtdbqq6EDT+33VTE5R8i30vEAMwsDu1vuYNsEePH2EM27XR+5x1JOLg
   WOlMrwY23bDLeZZpQ7/Md/BoY/oUWmyS20RzazGkwwe3n+gdKBbFsJDf0
   u/obkquMH9Fv0oNgq3oxgqq8RQtC7wwtOr923JoaEmVAGV7EOzI1z3rrL
   UjA/R9zsbNguUEX/PMw9vVKjpsuDz5FXkMkunnueTp5DYAenPcGwqboPa
   fiE6OaVJL4zRUxoCAiazzTklgzXCKC1pMeoLKhMiWMxnnRcdBkWMYacxU
   bVLDVjXRo6Q17dolnckMoiYAcZy/wi7mOW5KVtDTM2kvONiYZEuEWbvpf
   g==;
X-CSE-ConnectionGUID: z+OmUUhmTMmc+GNKRZg55Q==
X-CSE-MsgGUID: srKTznbiT9aohxIpD8g2Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51300341"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51300341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 13:13:01 -0700
X-CSE-ConnectionGUID: 7Rh7IRO2T12iXHL5n4lJng==
X-CSE-MsgGUID: Civ3vyrtQKiNN7pquM/9PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148456793"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa007.jf.intel.com with ESMTP; 13 Jun 2025 13:12:56 -0700
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
Subject: [PATCH net-next v6 0/3] dpll: add Reference SYNC feature
Date: Fri, 13 Jun 2025 22:06:52 +0200
Message-Id: <20250613200655.1712561-1-arkadiusz.kubalewski@intel.com>
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

v6:
- rebase,
- 'dpll' -> 'DPLL'.

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


base-commit: 08207f42d3ffee43c97f16baf03d7426a3c353ca
-- 
2.38.1


