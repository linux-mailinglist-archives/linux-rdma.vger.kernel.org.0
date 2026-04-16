Return-Path: <linux-rdma+bounces-19398-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJFjKMtT4Wl5rwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19398-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 23:25:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7C414EAA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B712930CFBA6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F439DBD0;
	Thu, 16 Apr 2026 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UkZWEe/k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B953328E6
	for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2026 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374614; cv=none; b=Rzhh+njyBhyJJ9I4PafHTGxnykX3YPfovZkDVtYSxZgkQ3+gOAtaZ0S6BwdWHHgnL392CWGUbPU6Dyk6hZtLg3OT2cbKXCjDPAg4fHM7Rxhw2J+4dRpED0GxnaSizcPCia7hHadNwOpRUhq7MlsiAMW/fuOtAnA23LaV3WTEj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374614; c=relaxed/simple;
	bh=mG1zDHIHMbHQNT8EsCTjrdV6MWK0v3GLzXcVBTaDDoM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5TcGk/cFSwiPrQpY90z505k1kBRjAUm9SjWNutwcAvpowcKoYbj7aA8LmSRXC4OVK+lxozAoR9YMZeZtGbLue29ldbod92wxvd9+dMcVM63pQOfAXUklOq1uF9IE7vZ6GoDnAYi45jwJH3Q0cWFtobVBvLTvNZ5GHGOaYXnup0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UkZWEe/k; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776374613; x=1807910613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DVBgwAoM6+KJG0w316VZEVId0f2oP8mO0nwKmS8KIgM=;
  b=UkZWEe/kJjT/Mg4w8UVXuOeU89FrtqguXk/NtUHCu6UDT/he45tDwTIT
   7sdcNf9EhBw0u4nI94HYpWPMUupPclt3sgAO7g620DFQVZHaRcA94KQVU
   FhBi5uWmAia+Wb7vhUSkfBFLD4eSTr9ubwmLWkYqqx+to97KsMSGH30Gc
   tIAINS0UaW/Lax64WKdhX230Pl2Cjh2Pv+XyhHyAlfzuQ3nFu+ZhOkQmh
   gMzn4IuP5xsb3FDY1qKkAniYLzaiZWDl4jHaGvr3Go7hueBQ6pWUBKIRe
   WjG4Tsd5MxOHCaz8FylToGcfzlF64oQ2YwGp+yBKKzHwS9EwHzHqAbato
   w==;
X-CSE-ConnectionGUID: mv19TOM/SoGDBs2VoiHHKw==
X-CSE-MsgGUID: EtxR+MlYQmSrTZ0m7gGh+g==
X-IronPort-AV: E=Sophos;i="6.23,181,1770595200"; 
   d="scan'208";a="17284007"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 21:23:31 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:17082]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.88:2525] with esmtp (Farcaster)
 id 5f4de538-6496-4b72-bdc0-5637caccae72; Thu, 16 Apr 2026 21:23:30 +0000 (UTC)
X-Farcaster-Flow-ID: 5f4de538-6496-4b72-bdc0-5637caccae72
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 16 Apr 2026 21:23:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 16 Apr 2026
 21:23:29 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next v2 0/5] Introduce Completion Counters
Date: Thu, 16 Apr 2026 21:23:22 +0000
Message-ID: <20260416212327.18191-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19398-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1EA7C414EAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add core infrastructure for Completion Counters, a light-weight
alternative to polling CQ for tracking operation completions. The
related rdma-core interface proposal is linked in [1].

Define the UVERBS_OBJECT_COMP_CNTR ioctl object with create, destroy,
set, inc and read methods for both success and error counters. Add a
QP attach method on the QP object to associate a completion counter
with a queue pair.

Completion Counters can be backed by user-provided VA or dmabuf or by
internal device/driver memory. Common command infrastructure allows any
of the implementations to support the various device capabilities.

Add EFA Completion Counters support as first implementer.

[1] https://github.com/linux-rdma/rdma-core/pull/1701

---
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
 drivers/infiniband/core/device.c              |   7 +
 drivers/infiniband/core/nldev.c               |   1 +
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/restrack.c            |   2 +
 drivers/infiniband/core/uverbs_cmd.c          |   1 +
 .../core/uverbs_std_types_comp_cntr.c         | 299 ++++++++++++++++++
 drivers/infiniband/core/uverbs_std_types_qp.c |  65 +++-
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 drivers/infiniband/core/verbs.c               |   1 +
 drivers/infiniband/hw/efa/efa.h               |  13 +
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 185 ++++++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 106 +++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  36 +++
 drivers/infiniband/hw/efa/efa_io_defs.h       |  62 +++-
 drivers/infiniband/hw/efa/efa_main.c          |   6 +
 drivers/infiniband/hw/efa/efa_verbs.c         | 171 ++++++++++
 include/rdma/ib_verbs.h                       |  41 +++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/efa-abi.h                   |   1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  50 +++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  14 +
 include/uapi/rdma/ib_user_verbs.h             |   2 +-
 23 files changed, 1063 insertions(+), 7 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_comp_cntr.c

-- 
2.47.3


