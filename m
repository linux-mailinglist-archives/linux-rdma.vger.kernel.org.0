Return-Path: <linux-rdma+bounces-22860-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D2aZEeFiTWq/zAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22860-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 22:34:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB971F8E6
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 22:34:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b="Cm/ssLot";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22860-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22860-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0663A3016B7B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D253F5BF5;
	Tue,  7 Jul 2026 20:34:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44593F1AB2
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2026 20:34:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456475; cv=none; b=fKil6NJTTdI3tJ/r/FlJz6j1+P0M0fdFuxJvfcCEiZI3rDniWDWkTM65OVcgjPxkBak2Xiiq1TOEiLJDje0oZX88Yk3PPegCfJBAxW0sjJlWgtIZN0hXPxI3yE01eiO84D+dzOXVD/krXCXDLJb/xu879UY/w6fwW9hnK9qVr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456475; c=relaxed/simple;
	bh=L35sUilmaOIWYP25fzJufpklT5L6Lx8hAX4np/yP32s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=As08yTxLL4VwHM4V51DmVPdjUNJG3YLgV08fYArNZwEbx4XNlY7aKEfDhlSAydx9vdOu8LFa69N/RFikYMVPdUgqQYzSgRzeiyii3JaGvyjEnRzuL/5CfV8QbnnTag8mq/iNwlpjMPggan0/InJtnT4G3RAfgXiRERBS9i3VcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cm/ssLot; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783456473; x=1814992473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8gUMbU90GcV5h00xl5KMsF4yniSyMSLV2uZU+64MUwA=;
  b=Cm/ssLotwjZtmsieJJhUmTrs+AyX5BD3z1VGYeL1ArMf+ctd1Zsrp6Dv
   9l+hcnU3gvDhAAKcDo4AdiG4tn52dAGtPES4z5WyIOzOPvrFLneUzj8Vk
   49ryGePRCDmjj5y1HnC6XeSRKLJvg61jrKkm1u873569FmKUAR49HkjBK
   Ul8p0FmQ9M7NUYFoy/Tb6m40JFOyX6Wnakkb3GRfc8VmI7uRHhq0TQMhy
   scrhpjldvThmKJgb4uou87cJjuDWmOdmdIppQ9u8bXJNc1D8ZUwKgMrp2
   VYpBE7s+TdnQ+3e6gMpPXslvl0yB6lvzlyBbW8h9mlkbamx7J8Ro4QsDC
   Q==;
X-CSE-ConnectionGUID: LQZXR9Z4THeWUuPZ1xg2pw==
X-CSE-MsgGUID: +VhCv+/tQTCNx5Vh4tQfqQ==
X-IronPort-AV: E=Sophos;i="6.25,153,1779148800"; 
   d="scan'208";a="23137011"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 20:34:30 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:21604]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.18:2525] with esmtp (Farcaster)
 id 4e061883-58aa-4a62-9ce0-73c1cad96aa2; Tue, 7 Jul 2026 20:34:30 +0000 (UTC)
X-Farcaster-Flow-ID: 4e061883-58aa-4a62-9ce0-73c1cad96aa2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Tue, 7 Jul 2026 20:34:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Tue, 7 Jul 2026
 20:34:28 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v8 0/5] Introduce Completion Counters
Date: Tue, 7 Jul 2026 20:34:22 +0000
Message-ID: <20260707203427.6923-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22860-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFFB971F8E6

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
Changes in v8:
- Added device event counter detach support and its use in attach error
  handling
- Prevented completion counters attach to wrapper QPs
- Added max completion counters report in nldev
- Link to v7: https://lore.kernel.org/all/20260701103448.17895-1-mrgolin@amazon.com/
Changes in v7:
- Rebased on latest rdma for-next
- Link to v6: https://lore.kernel.org/all/20260604114627.6086-1-mrgolin@amazon.com/
Changes in v6:
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
 drivers/infiniband/core/nldev.c               |   4 +
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/restrack.c            |   2 +
 drivers/infiniband/core/uverbs_cmd.c          |   1 +
 .../core/uverbs_std_types_comp_cntr.c         | 182 +++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  67 +++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 drivers/infiniband/core/verbs.c               |   8 +
 drivers/infiniband/hw/efa/efa.h               |  15 ++
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 186 +++++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 134 +++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  44 ++++
 drivers/infiniband/hw/efa/efa_io_defs.h       |  20 +-
 drivers/infiniband/hw/efa/efa_main.c          |   5 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 209 ++++++++++++++++++
 include/rdma/ib_verbs.h                       |  44 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/efa-abi.h                   |   6 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 ++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 23 files changed, 993 insertions(+), 6 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

-- 
2.47.3


