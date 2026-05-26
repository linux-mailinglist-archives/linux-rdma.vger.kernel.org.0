Return-Path: <linux-rdma+bounces-21276-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CNFGytjFWo9UwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21276-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:08:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D790E5D3040
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 11:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A20A304358D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A63D25DD;
	Tue, 26 May 2026 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kq7Wsgcx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4C3D0BED
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786443; cv=none; b=nzVwnn/c6rGjlOd0Zmi2oyz6abvvheUiiUBXolX0e4k/UFl3TnnW6S/JAophcPsGoVsKeMxIejUxDzpEbISKCnO3Z4/e42tF1FFzamm2vnGAJnuFziFo1z3scdFv0l19ZGW8g57q2ShvLP+9rHjDXvXh4YmowbNR5kHD0tDSNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786443; c=relaxed/simple;
	bh=4rdUDyniq5gVCJAKCMV/XUOwA6SKUTkPrU0pZ44phqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZFcaVwy1nrtAj5/Qr2GAK4azILM6sr7HhANFFoR5Vk6JQiXm3HVgzkN0oWQLyz+yTpeFr/9ZjVr5EnbQY7K0PJH/AWVy81idBlJ2nKkpsIsemU/wpEgYv0rNUwE6SMse6zczO28iViaF7dvM0V4clKNXE3m4MA1tsXEksOsREVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kq7Wsgcx; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779786441; x=1811322441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/clTpHxGc12II7wChOMiKvuEHCeCpXTWqrW+lI9tnKk=;
  b=kq7Wsgcxxp7Oa212MBbB9WN6+INTzXka5/yCJWsKJs0LTHf4QFgJQP5V
   FAAsFlINZEmrbrycqm4N5Wn/WjhCs2KZYuSPzqLLazVUCT8Q/zn47lEN1
   0tkOuFaJqaHyI3cLKFSW2G7yaPo/a2fTi9RG+JyNWzX8nPQmwrpelhWnm
   9Zi7Un4e3mc8UkU9BLfEnsAZ/qWtuqeEZrZbzMuJiVuaZGT28/NtUeHDQ
   N3Wz4xUt1GdQsRAvmajt93+VKOx6NeDGtzhqBPi01arvCnFnkXE6bjVsD
   haeM7nD65lUzaVs0o8a9gefGYTEq9r6Rp63o7wPqrbgoHE+8C/X4IoSdk
   Q==;
X-CSE-ConnectionGUID: 73kgFT7QQtW11DksMrACdg==
X-CSE-MsgGUID: oWA2tn+mQheRK4oBhymRHQ==
X-IronPort-AV: E=Sophos;i="6.24,169,1774310400"; 
   d="scan'208";a="20250652"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:07:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:26797]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.135:2525] with esmtp (Farcaster)
 id 86e04707-dd8c-4e21-be57-3467cfc758d5; Tue, 26 May 2026 09:07:17 +0000 (UTC)
X-Farcaster-Flow-ID: 86e04707-dd8c-4e21-be57-3467cfc758d5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 09:07:14 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 26 May 2026
 09:07:13 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v5 0/5] Introduce Completion Counters
Date: Tue, 26 May 2026 09:07:07 +0000
Message-ID: <20260526090712.17575-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21276-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D790E5D3040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v5:
- Fixed Sashiko findings
- Minor naming improvements
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
 .../core/uverbs_std_types_comp_cntr.c         | 182 ++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  62 ++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 drivers/infiniband/core/verbs.c               |   8 +
 drivers/infiniband/hw/efa/efa.h               |  15 ++
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 185 +++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 110 ++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  36 +++
 drivers/infiniband/hw/efa/efa_io_defs.h       |  61 ++++-
 drivers/infiniband/hw/efa/efa_main.c          |   5 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 234 ++++++++++++++++++
 include/rdma/ib_verbs.h                       |  44 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/efa-abi.h                   |  19 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 +++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 23 files changed, 1030 insertions(+), 7 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

-- 
2.47.3


