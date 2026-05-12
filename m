Return-Path: <linux-rdma+bounces-20459-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCNFHJvIAmrQwgEAu9opvQ
	(envelope-from <linux-rdma+bounces-20459-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:28:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE15B51B02A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA16F3100C57
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 06:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0664CA26F;
	Tue, 12 May 2026 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="kHeEob2G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06633CEA7
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566327; cv=none; b=RQ+8NRcfc8k19FKSYr4kcfNTwHhpTuhIEya/E8qhJ0yQamYkf6rPZmMLDVECZ8vgrmlUbPwxt64ZUJo5kVRxw8rzu1+oyx+inOWdmA/Q3lGF99gPHgwwLSej65IvAmApQ+OEpUqa8iLw9c1xo4RFS8az5hmMtiATx30+KMoTChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566327; c=relaxed/simple;
	bh=v/kuB1HRZkgJmETW1W1n3qnS6SYEteFoGCxzsjzSg9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JQgIlM77NwW4NkJzNg+SQtS/HplpxSTWDLUM5zig5eZxDqhp1NkYav3kH6/P2f6yuysqRaYEMfdyhtxDW7lwyKqu9WZEJRc3t+iu9jCBrJeU9I49+IU/wn0GmheGSxjHYLOLDvmAL5+Tf1R3LodTQhmTlBrbon1WezBiYuAiwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=kHeEob2G; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778566314; x=1810102314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tRQ6H2q6tMf1eWUNX6x9kusbVHsZVmqzn1NdPgZwZ4I=;
  b=kHeEob2GYISSYEdnNVWqJh3FckVkJLjMi1Nv2n4Glen5tJuxEhsHfig2
   rpBzkTWCR8Potlwp58B6mcJ/HukRSnQC6c7ww42OG9vGL3ENChiWR/+pK
   eUFINvRpxu1S2xsNVqv1Lr1y5pUOXFnPeDcDOrtLCt0XJbx9EHbqa+I9w
   J47NgUnCFBJhKfgDHy5oFMAC55VRfH3Yr7EXJAt37Qa7iZ4hwlgYDskyp
   QQepaAudwwX5Rr9dxK1gULRTsdV20vlKcaqou4bEFurJReNIswin1816+
   QnVjWB0JDkh/cEvnS0LTjCyxDVXPRQFNl0xpSiC/OX1SU1JC3EiOkSIc5
   w==;
X-CSE-ConnectionGUID: OtP2Zy2JS5Ka4i5n3XX8Zg==
X-CSE-MsgGUID: Ij5vrV36T6+8H0PO5d+V6w==
X-IronPort-AV: E=Sophos;i="6.23,230,1770595200"; 
   d="scan'208";a="19220640"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:11:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:26923]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.42:2525] with esmtp (Farcaster)
 id fda88039-3180-493c-863a-9f5c6b894059; Tue, 12 May 2026 06:11:45 +0000 (UTC)
X-Farcaster-Flow-ID: fda88039-3180-493c-863a-9f5c6b894059
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 12 May 2026 06:11:43 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 12 May 2026
 06:11:42 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v2 0/2] RDMA/efa: Add AH cache for AH reuse
Date: Tue, 12 May 2026 06:11:19 +0000
Message-ID: <20260512061121.2177521-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: EE15B51B02A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20459-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Changelog:
v2:
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

Yonatan Nachum (2):
  RDMA/efa: Add initialization of AH cache rhashtable
  RDMA/efa: Add AH cache handling on create and destroy AH

 drivers/infiniband/hw/efa/Makefile       |   4 +-
 drivers/infiniband/hw/efa/efa_ah_cache.c | 154 +++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h |  41 ++++++
 drivers/infiniband/hw/efa/efa_com.c      |  12 +-
 drivers/infiniband/hw/efa/efa_com.h      |   5 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c  |  27 ++++
 drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
 8 files changed, 245 insertions(+), 8 deletions(-)
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h

-- 
2.50.1


