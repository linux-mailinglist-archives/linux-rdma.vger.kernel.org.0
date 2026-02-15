Return-Path: <linux-rdma+bounces-16893-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Si39AHe2kWmTlgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16893-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:05:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334B13E9F7
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 13:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A880300EABA
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DB284682;
	Sun, 15 Feb 2026 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NGT+qi2N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DC1A9FAB
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771157106; cv=none; b=LVzADOCqpz+HVVWLoQvVmwO4BTDs97S/hPykd6V8QK5VSyrUWPJFcnc6crOUXXXIvlzpQ4kvOhwZM50JN+GQMnqs5RDrvuDofWFFISifncDabl1qls6Ns+I9afgDxMWAplktCfAwIQZsiEAALGCfuU0cfHmM63qUWNLblHNwBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771157106; c=relaxed/simple;
	bh=R5uA7nkJtIT6UdzbP19orMMtZD3Z1O60js8Fv2yjBJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pM4dF0XzH3K0qHujrMtFsCktjcVlxizsyGIdGCKm2jsjJXUtzNwB/SoCjDSKisVvb7oUrORfW9TTxI/aJLXQ3gkdZV5MrUPok/G80gvbREXxWvO0flgLD/Ng5hGF7TXhGLcyMF+s+GygtPtPZ41lriLpU5br8oM+ehQjV58DvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NGT+qi2N; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771157105; x=1802693105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QS7M1MnNAQ/v7pmmJ5/Xskg1sCLxSpdu4EGdfJ+MvT4=;
  b=NGT+qi2NqkadyYLbnDHX01cJaEpWTs7dORo3T2PlHBbJFsDlpBaPy04H
   jn3fXVxCFYt4JBjADbBaUf62HAi755YvElzcVVa26p0zTLuyEjbwEYymZ
   4jwPv5arK/8uupoDJvev1bzqyE+MQ0+MoBiwGmslYvMAGINgjNttvvayk
   +eheC4UmDTx3zG1J84O482yu99McACHNdzr7LEQ+nDwdnwSx1amu3yQqS
   p1PGOdZbeen2VJinTSxdfCnihwCETRBpV6mrdpqSkidwrxSNXtMOn4qXL
   IIrlxEMuuIcb/Q2GiGyqdSHHRtg6nvETLa4k5wEN2iWF1CoEgr8gNkoWm
   A==;
X-CSE-ConnectionGUID: Rh8FSiWAT9+DszGWtLidtw==
X-CSE-MsgGUID: bDMw1h6PRs6K/deQLRvG/Q==
X-IronPort-AV: E=Sophos;i="6.21,292,1763424000"; 
   d="scan'208";a="12933571"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 12:05:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:19796]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.75:2525] with esmtp (Farcaster)
 id d7c3ee89-aad2-4b79-8ac6-1a8c635cba6d; Sun, 15 Feb 2026 12:05:01 +0000 (UTC)
X-Farcaster-Flow-ID: d7c3ee89-aad2-4b79-8ac6-1a8c635cba6d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Sun, 15 Feb 2026 12:05:01 +0000
Received: from dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com
 (10.253.69.224) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Sun, 15 Feb 2026
 12:05:00 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 0/2] RDMA/efa: Expose extended max inline buffer size
Date: Sun, 15 Feb 2026 12:04:49 +0000
Message-ID: <20260215120451.18053-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16893-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3334B13E9F7
X-Rspamd-Action: no action

This series adds support for querying an extended max inline buffer size
from the EFA device.

The first patch renames the existing queue attributes structure to prepare
for adding a second queue attributes query.

The second patch introduces the new extended max inline buffer size query
and exposes this value to userspace.

Yonatan Nachum (2):
  RDMA/efa: Rename admin queue attributes struct name for extendability
  RDMA/efa: Expose new extended max inline buff size

 .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 22 ++++++--
 drivers/infiniband/hw/efa/efa_com_cmd.c       | 55 ++++++++++++-------
 drivers/infiniband/hw/efa/efa_com_cmd.h       |  3 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  3 +-
 include/uapi/rdma/efa-abi.h                   |  5 +-
 5 files changed, 59 insertions(+), 29 deletions(-)

-- 
2.47.3


