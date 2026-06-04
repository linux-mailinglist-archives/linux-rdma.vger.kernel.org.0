Return-Path: <linux-rdma+bounces-21755-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nRKuBaNmIWpHFwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21755-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:50:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A712763F948
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 13:50:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=kMQLuKEx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21755-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21755-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A1D030CAD18
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FC43C047;
	Thu,  4 Jun 2026 11:46:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE843CEEB
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 11:46:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573594; cv=none; b=afGp0hDEKeYRsX2GF5SywNrQMDlzF1c0TSrbeD5W3vtfeC9VwL2hvSDlQaeOgb0GhypV22LiWSy/NhOQW59d6Qac2j4l5v2ujrseZkY5yVixF6KBZiu3LiKuuw7/hEdlCiO4M6lguMDThxZBTecSNvzv1iRzC2mIIhY3nV7vzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573594; c=relaxed/simple;
	bh=E20/aU/l/snsfFoZCP68irf2Q3+4Rml6jSZbv/YdvZ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTr8VLjcSrHcuZDdPIRUXu1t6tWxTi4PmufvWuuYmI9RV3AgKFQMg/8tqybWhWKGrT8O49wkESg9PF5hTYM1QD+oHGMbq1dCDlI60361oPVX+ZmiPYo+ABho+9SKIrgov/aXbMyfSt5XTUBvxrbkzW1/acZWSHSYPhMiwlyykqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kMQLuKEx; arc=none smtp.client-ip=44.246.77.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780573593; x=1812109593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sup+nCKnLt1QZQeaRAhI5R/g9wBvQ/sZgzsyF8zzFcQ=;
  b=kMQLuKEx8XXK+fzPj2nnkRBO3UhrzFqUAJm5hiCrwyi5YFD1h0E5Af6o
   /0d//e6ZYnMTqPiB8tq3j+QBc0qa7jzWq3YIyX1ZRIFqViTdAN4EqdOjT
   NB9uGTZZUWRiASRGZBXopL0Gzi2JDDyZkGy2J3yBXfyboOElzZwkwnJxy
   djEOMTmh3x8His1Y3FOXkQvzTyTn3raYdyHKeSMNS69hgi/O7xgpeQO5q
   BJT9hbvuK3QVOF1lJr6DvdSJCIxDx7AGRLLI2Nbth9e8cQwhRTMj4aq3U
   kXMqVdfV8q6ilU44dR516Z+76z7U5c5hKhMUyDG/Rx+n3EVAojz1osuKv
   Q==;
X-CSE-ConnectionGUID: KBFOtg6dQ+qUZM8juaSvLA==
X-CSE-MsgGUID: ujBnKIGGQDek23tN+Y5fEA==
X-IronPort-AV: E=Sophos;i="6.24,187,1774310400"; 
   d="scan'208";a="21080189"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:46:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:6327]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.245:2525] with esmtp (Farcaster)
 id 81f04ecc-e82e-4825-81dd-81aa36928dd6; Thu, 4 Jun 2026 11:46:30 +0000 (UTC)
X-Farcaster-Flow-ID: 81f04ecc-e82e-4825-81dd-81aa36928dd6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 4 Jun 2026 11:46:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 4 Jun 2026
 11:46:29 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v6 0/5] Introduce Completion Counters
Date: Thu, 4 Jun 2026 11:46:22 +0000
Message-ID: <20260604114627.6086-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21755-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A712763F948

Add core infrastructure for Completion Counters, a light-weight
alternative to polling CQ for tracking operation completions. The
related rdma-core support is linked in [1].

Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
modify and read methods for both success and error counters. Add a QP
attach method on the QP object to associate a completion counter with a
queue pair.

Add EFA Completion Counters support as first implementer.

[1] https://github.com/linux-rdma/rdma-core/pull/1701

---
Chnages in v6:
- Moved to using ib_umem_get_attr util
- Resolved additional Sashiko comments
- Link to v5: https://lore.kernel.org/all/20260526090712.17575-1-mrgolin@amazon.com/
Changes in v5:
- Fixed Sashiko findings
- Minor naming improvements
- Link to v4: https://lore.kernel.org/all/20260511223721.18365-1-mrgolin@amazon.com/
Changes in v4:
- Replaced inc and set commands by a single modify command
- Changed to passing buffers as EFA specific attributes using desc
  struct aligned with the suggested common method of passing and
  consuming umem in RDMA drivers
- Link to v2: https://lore.kernel.org/all/20260416212327.18191-1-mrgolin@amazon.com/
Changes in v3:
- Skipped this version because of a wrong patch list
Changes in v2:
- United set, inc and read flows for successful and error completions
  counters
- Added comp_cntr usage count
- Minor cleanups
- Link to v1: https://lore.kernel.org/all/20260407115424.13359-1-mrgolin@amazon.com/

Michael Margolin (5):
  RDMA/core: Add Completion Counters support
  RDMA/core: Prevent destroying in-use completion counters
  RDMA/core: Add Completion Counters to resource tracking
  RDMA/efa: Update device interface
  RDMA/efa: Add Completion Counters support

 drivers/infiniband/core/Makefile              |   1 +
 drivers/infiniband/core/device.c              |   6 +
 drivers/infiniband/core/nldev.c               |   1 +
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/restrack.c            |   2 +
 drivers/infiniband/core/uverbs_cmd.c          |   1 +
 .../core/uverbs_std_types_comp_cntr.c         | 182 ++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  64 +++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 drivers/infiniband/core/verbs.c               |   8 +
 drivers/infiniband/hw/efa/efa.h               |  17 +-
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 185 +++++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 110 ++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  36 ++++
 drivers/infiniband/hw/efa/efa_io_defs.h       |  63 +++++-
 drivers/infiniband/hw/efa/efa_main.c          |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c         | 199 ++++++++++++++++++
 include/rdma/ib_verbs.h                       |  44 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/efa-abi.h                   |   6 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 ++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 23 files changed, 987 insertions(+), 10 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

-- 
2.47.3


