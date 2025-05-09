Return-Path: <linux-rdma+bounces-10200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B268AB13D3
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 14:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CB3522E0E
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82A290D9B;
	Fri,  9 May 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkgAuKj2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887E28EA44;
	Fri,  9 May 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795170; cv=none; b=UgR0IlgyCr6yby37xszF4Cjf0Bp+7YUInTBKzSKG8mdgM/ykrvGbkeF07u/+kSdGOK5EIdqCEUQBO8YZ/jG2v+Yc2K8YJiA3n3yGDwwp6AQ5JDbfU8cN3PlxOKckPhJ615bjN3PCEf8iTGqJLlZEkA2fJGNiZf2IfARitDDY01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795170; c=relaxed/simple;
	bh=BgRoUXYcSrAqisgxPiDX6UXaKvPPaCgwsEZyfhyMlFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LC7uaEPN/kH27z61pmMMrahLhtrUL4N0clE3htgZabM6YB/v6joc+QtIKIvE1J1tNtyCulAXjJ7oWafno0UAmX6/ghaHejINY7b1RNjGFC86VT2OCwxgsMNVk9t/VVjMIBCtWBweGU+Olji7TOgAzCu5wIy5uK+tuMB7MW86Nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkgAuKj2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746795169; x=1778331169;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BgRoUXYcSrAqisgxPiDX6UXaKvPPaCgwsEZyfhyMlFw=;
  b=CkgAuKj2My4lk1JD/F4A5meH4iJsUwEpSm/m1aqb5FG2WHiAVcemvKUE
   Qm5awLe23Lr1NMBQbr6FD7SjEWiVsaVgh+XeN4YiRLUb9TWHX//rpwf+x
   TiDxN6yT6XKt3DiNuW6kYW9UFx7z5f2UzSoHGbmDzWZP6UPbYojsIU/zy
   zzBWjWUnXCtmvo/1z3LA1yrU25Tn3wFtZmXRaLd/0VY08mduSN4alZg+j
   XaF9FAIAywZ4dxnYZfqH0/ldIIxM7VnrkdwaRT/6eg1slb2zkV2SBramK
   6mH8jcs3XFKbyI314LHgQcujyaiXw6zYODEYtszm5MuLGrwgLZUAWwTdu
   Q==;
X-CSE-ConnectionGUID: RSQlkGvHRb6l0DN4TlFUiQ==
X-CSE-MsgGUID: SwwYXuLUQ4emDGyVODG5xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66027268"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="66027268"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 05:52:49 -0700
X-CSE-ConnectionGUID: BZDHX1swTe6uzMx0D0o0oQ==
X-CSE-MsgGUID: 5ESaZ+aCS+yJh0Vw/9f4vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141828269"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa004.fm.intel.com with ESMTP; 09 May 2025 05:52:43 -0700
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
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net-next v2 0/3] dpll: add Reference SYNC feature
Date: Fri,  9 May 2025 14:46:48 +0200
Message-Id: <20250509124651.1227098-1-arkadiusz.kubalewski@intel.com>
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

v2:
- improved cover letter description of the feature

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


base-commit: 46431fd5224f7f3bab2823992ae1cf6f2700f1ce
-- 
2.38.1


