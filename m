Return-Path: <linux-rdma+bounces-20415-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEdLDKlaAmosrgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20415-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:39:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD6517068
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 00:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3A2A301E58C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9836356754;
	Mon, 11 May 2026 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="g+t5ZZwk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82142308F23
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778539050; cv=none; b=rwnaK4KwCzll1amqNLqVmpP8C+b3W/m95GfBEQz8FAHW8BpT3/8RNe4AJKT+vvwEH2G0eQcA/3L4dD4s7WW8gP2z0TIlRwGGCDJs5vzpwPnCom7yKB66DEnbNfc/wL/g+7CN+y1Ev0EhMAdS4M2TxkWmTEnhQx1eU+7JDr5UyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778539050; c=relaxed/simple;
	bh=fGZ7vndGMyQxPWgHTfFbCZq4FPuVSp81LZiKOtTYYF8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5el4rcE6NPeyATcwmavieTGHgAjJqNR5iZRMSlwaq6ja6FB08iYAs7fS+vnkJ5s0lBEXcQu64cMa+uss5dCMNkoROg6vTENZoHu0LCRztwondO+HRTrq2evKmZs+iPwirAc/nQCnfzxpq8+RIvJ44uoYRQ9u0qi6+5kKRS68sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=g+t5ZZwk; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778539049; x=1810075049;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NlWsrNVIjYDams0OfdFclAGv8sZpWxF20Zgm85SWU4=;
  b=g+t5ZZwkLCZnKGDRmGKacdVnIeGda2AX0iV7yesEavTWPXjcYTVleAHA
   +2Ks2NqKE+ymMC2loOSnkmUCHhm8i4m8Rre4+5e7wj+kCV57m56t32ssR
   qA6k8kvUoYTfmgX+c2cweZ8Be14tGdgwhbUXOQ7MzzDi0x13C6PNhxKbI
   FY6sTXk///yqr5okUUZgwYo1hf5H6f+rzIRQcrAj5x+j2n7IxJSKRQuMm
   B8cdlzfT0rKcgeGu6VFD9Vwm48wDYb+OXrhdtTSrRAbsQdwAgLesSF+Nd
   cCyHQs194Z+TLWt/tw9fHLCXVKebFlZ0XtBQNf8AonVM0dUmfAQAeTfiv
   Q==;
X-CSE-ConnectionGUID: gAJHMyW9QuSQ0cBxQVD+Wg==
X-CSE-MsgGUID: MWx+59WUSkSGL5ZddIypAQ==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19392964"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:37:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:25353]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.175:2525] with esmtp (Farcaster)
 id 3042bacd-02c3-4d56-9c22-96a069dc0ca6; Mon, 11 May 2026 22:37:25 +0000 (UTC)
X-Farcaster-Flow-ID: 3042bacd-02c3-4d56-9c22-96a069dc0ca6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 22:37:24 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 22:37:22 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v4 0/5] Introduce Completion Counters
Date: Mon, 11 May 2026 22:37:16 +0000
Message-ID: <20260511223721.18365-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: B8BD6517068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20415-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add core infrastructure for Completion Counters, a light-weight
alternative to polling CQ for tracking operation completions. The
related rdma-core interface proposal is linked in [1].

Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
modify and read methods for both success and error counters. Add a QP
attach method on the QP object to associate a completion counter with a
queue pair.

Add EFA Completion Counters support as first implementer.

[1] https://github.com/linux-rdma/rdma-core/pull/1701

---
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

*** BLURB HERE ***

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
 .../core/uverbs_std_types_comp_cntr.c         | 183 ++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  65 ++++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 drivers/infiniband/core/verbs.c               |   1 +
 drivers/infiniband/hw/efa/efa.h               |  17 +-
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 187 +++++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 106 ++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  36 +++
 drivers/infiniband/hw/efa/efa_io_defs.h       |  64 ++++-
 drivers/infiniband/hw/efa/efa_main.c          |   7 +-
 drivers/infiniband/hw/efa/efa_verbs.c         | 229 ++++++++++++++++++
 include/rdma/ib_verbs.h                       |  44 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/efa-abi.h                   |  19 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  38 +++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  19 ++
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 23 files changed, 1024 insertions(+), 10 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

-- 
2.47.3


