Return-Path: <linux-rdma+bounces-22804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lI+yIgfiS2oWcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 19:12:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA10B713B80
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 19:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=eUWzz9h5;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22804-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22804-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 506F13049513
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8472DCC13;
	Mon,  6 Jul 2026 17:00:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAE13DDAA
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2026 17:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357230; cv=none; b=qTQNa5zXxXduhnsdRab5PVZCf9tqymNma7/1V9PkOxjh6RvBIyfl5cOHv5q0SjIx/I7S3WbjW/fc4d3eDI8MgN0BU56qQgugizpq4zakYMzm9R+jlelgl4eSdHLPBOvaK0xcothtimpd2dd4kiNwkQ85BmZqMrM2sB6Y4AKrAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357230; c=relaxed/simple;
	bh=ZFyPWnTbOn3DUCPS9ZTxHdJ5Hu46L1ntywMitV3MXD0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dg238inqV21r9JuA2YJ0L3IrJCcsHScgi11zoD80yv3EaBQJUQ4v6MmjXvWXSjr4P8p3EEf0jqxJJp/kDPivDfaPZwHxyQy9rXsb1h618bo9MiC6T+QHA4QHrhH5K2riA48ErKzzcku7W5w5qeOwaQeYA7IwZcWcGQ7PaFoG/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eUWzz9h5; arc=none smtp.client-ip=52.26.1.71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783357229; x=1814893229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MUK6M0SsfX+tB4p5V56jH3ZjFuARWzJXjlJR/B590G4=;
  b=eUWzz9h5AhWLg/4UoRK1oUACitlMBzH9Eo7J3lqhYIGunKNKX3KFtZMv
   NRGG4U2bjShVxtaDG1OtfLoJTdenimy/acmm9uxBjrZIBb8RkQvyFzXfe
   I5LEecx/RfAS2P5mhOAiPUj+NH0vOdbGpbUehO3Sq4QwzE30im/S8xdfZ
   6EbRmSZeBXmAcUkp2AOq76sTOHrvxa0QCtCCEKEnjRvj1RM5BmjX9mGGF
   G6r7AZR7gT7ef323H89czqexkEDLNJZIXWCz6bATZjfbX1SSu7HWeAA0s
   X2uYSmoZkC/mIppquTuk+TKTZyrje72kXoHpbqKj80Wp0EYZZ4fkUKLfC
   g==;
X-CSE-ConnectionGUID: dqOzTbXET7aS4T3dURviMg==
X-CSE-MsgGUID: YBPGeIFRT4GgHmUPnME4CA==
X-IronPort-AV: E=Sophos;i="6.25,151,1779148800"; 
   d="scan'208";a="23180951"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 17:00:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:14502]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.112:2525] with esmtp (Farcaster)
 id 2e0ca333-87f9-40e2-b333-8a9eaf638593; Mon, 6 Jul 2026 17:00:25 +0000 (UTC)
X-Farcaster-Flow-ID: 2e0ca333-87f9-40e2-b333-8a9eaf638593
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 6 Jul 2026 17:00:25 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Mon, 6 Jul 2026
 17:00:23 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v6 0/2] RDMA/efa: Add AH cache for AH reuse
Date: Mon, 6 Jul 2026 17:00:06 +0000
Message-ID: <20260706170008.1039417-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22804-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA10B713B80

Changelog:
v6:
 * Remove rcu_barrier and kfree_rcu since all hashtable operations are
   serialized by the AH cache mutex, no concurrent readers to protect from.
v5: https://lore.kernel.org/all/20260628133422.523230-1-ynachum@amazon.com/
 * Replace the single refcount and initialized flag with two counters:
   one for entry lifetime in the hashtable and one for tracking active
   AH users.
v4: https://lore.kernel.org/all/20260608071620.1909543-1-ynachum@amazon.com/
 * Use kzalloc_obj for AH cache entry allocation instead of kzalloc
v3: https://lore.kernel.org/all/20260607161753.1607559-1-ynachum@amazon.com/
 * Address Sashiko comments in:
   https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com
v2: https://lore.kernel.org/all/20260512061121.2177521-1-ynachum@amazon.com/
 * Zero-initialize AH cache key on cache lookup.
v1: https://lore.kernel.org/all/20260510083035.458081-1-ynachum@amazon.com/

-------------------------------------------------------------------------
New EFA devices don't support the creation of multiple AHs to the same
remote on the same PD. To overcome this limitation, introduce an AH
cache that manages AH reuse transparently.

The cache uses an rhashtable keyed by (PD, GID) to track active address
handles with refcounts. On create AH, the driver returns an existing AH
number if one is already cached, or creates a new one and caches it. On
destroy AH, the driver only issues the device destroy command when the
last reference is dropped.

A per-entry mutex serializes concurrent device commands on the same
cache entry, preventing create-before-destroy races on the device.

The series was reviewed by Sashiko with Claude Opus 4.8.

Yonatan Nachum (2):
  RDMA/efa: Add initialization of AH cache rhashtable
  RDMA/efa: Add AH cache handling on create and destroy AH

 drivers/infiniband/hw/efa/Makefile       |   4 +-
 drivers/infiniband/hw/efa/efa_ah_cache.c | 135 +++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h |  39 +++++++
 drivers/infiniband/hw/efa/efa_com.c      |  12 +-
 drivers/infiniband/hw/efa/efa_com.h      |   3 +
 drivers/infiniband/hw/efa/efa_com_cmd.c  |  41 ++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
 8 files changed, 233 insertions(+), 11 deletions(-)
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h

-- 
2.50.1


