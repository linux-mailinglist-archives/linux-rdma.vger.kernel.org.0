Return-Path: <linux-rdma+bounces-16919-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H0+FVsek2mM1gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16919-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 14:40:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA424143F05
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 14:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A46030ECB36
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Feb 2026 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62BC30E858;
	Mon, 16 Feb 2026 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XRVjLTs2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A02DA762
	for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248849; cv=none; b=CC2zQjaB6N4cIuVEJ4FLsSMKynb1q4xIAVPJP4GHfxLVeLfQn6yUS5FmezJ2gAWnQBX9mnkXROq5A4x1gcCbQh4BqC0lE/NzAmIFx6dOe0u+Kh7T0I9FCz2XyoAJOw6XIZK5j2tDIcwvYmY0+QFTUslABAhjnYBxFlwE+ufEs4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248849; c=relaxed/simple;
	bh=0ZBzCxU3mJDCQMt7SURzr/c5wAbeq1TdWYhxVRFH4rU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=me0+YGGsVJxNMPDbADLet5Qz/UcVu784BcdfXW41YCOyHInGqW3hW9mlUJxMj8XasZNkr5twbAHibKuaKAG1GAChNb155srk0h6MUrFYHHkNB76+RDWuySFWsl2sG4p7AgHxcpxUo+wrvvRJxAFhzkWImaF/n99+qrcVSxERqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XRVjLTs2; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771248848; x=1802784848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qIbkHyNiyQ5mE8D5L/XoK48WcdKn/ZBXIFKSW1fPXiQ=;
  b=XRVjLTs29FKaVhsb+rXnaXrfcet/OaGPrIyPnl29aL5wLiTQwJ47L1Si
   x/qH0QaACdJ1oflq53mYZUWCKizWEmMzQMMQHthCqEXmEzuoEGvxit5Mz
   9EkDNjRieQqOwJdAJEjwE89rtn3iYBOpmvZX1benK/6ygy4tnY9NcVBcl
   9YSydbXvtBZecWh8NmOOs9kmaqG8AOI/YAB4/C7R6RuwpI8vpOf+CHwKA
   Cj6okqo4M9Iclmh1dmIZ7HuNNmwReg6UnVYELczdMpm3EzSBf/9v+ErvQ
   VKgVDLAhUrGEKQgAn3GnD/rH7T/1660fiu9edzAI766/wNneOHQWGXFmP
   A==;
X-CSE-ConnectionGUID: haaaCNeoTr+YI79OrG6T0A==
X-CSE-MsgGUID: Ctc0dF5ZTKm8FBhPgGSUWw==
X-IronPort-AV: E=Sophos;i="6.21,294,1763424000"; 
   d="scan'208";a="13144509"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:34:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:15189]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.47:2525] with esmtp (Farcaster)
 id eed07a07-41f2-4538-bfa9-cf9f76869979; Mon, 16 Feb 2026 13:34:03 +0000 (UTC)
X-Farcaster-Flow-ID: eed07a07-41f2-4538-bfa9-cf9f76869979
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 16 Feb 2026 13:34:02 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Mon, 16 Feb 2026
 13:34:01 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v2 0/3] RDMA/efa: Expose extended max inline buffer size
Date: Mon, 16 Feb 2026 13:33:48 +0000
Message-ID: <20260216133351.14896-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16919-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CA424143F05
X-Rspamd-Action: no action

Changelog:
v2:
 * Added patch 3 to use the extended inline buffer size for validation
   in QP creation.
v1: https://lore.kernel.org/all/20260215120451.18053-1-ynachum@amazon.com/

-------------------------------------------------------------------------
This series adds support for querying an extended max inline buffer size
from the EFA device.

The first patch renames the existing queue attributes structure to prepare
for adding a second queue attributes query.

The second patch introduces the new extended max inline buffer size query
and exposes this value to userspace.

The third patch updates the inline validation to use the extended inline
buffer size.

Yonatan Nachum (3):
  RDMA/efa: Rename admin queue attributes struct name for extendability
  RDMA/efa: Expose new extended max inline buff size
  RDMA/efa: Use extended inline buff size for inline validation

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 22 ++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 55 ++++++++++++-------
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  7 ++-
 include/uapi/rdma/efa-abi.h                   |  5 +-
 5 files changed, 61 insertions(+), 31 deletions(-)

-- 
2.47.3


