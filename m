Return-Path: <linux-rdma+bounces-22540-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vuQzLQQjQWpBlQkAu9opvQ
	(envelope-from <linux-rdma+bounces-22540-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:35:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1766D3E83
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 15:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=ASFc3zkV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22540-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22540-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42CBF300CE5D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A593A4F35;
	Sun, 28 Jun 2026 13:34:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D91B3925
	for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2026 13:34:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782653688; cv=none; b=stUMT+LNPr0jNhCT8Lj40woaysE4kagsRH6G6+7fdHdx9gDDGtByhHDNkygAN1e0Z2VeDd9jws/LpYmAf96LSHSWnPrRKYSCBnFvvUNYdlUT+423G8G9nixmu6WCdlek2l7qSb23nkR1BhB+Re/fBjGAjEK0eluZ2ymXGwoIHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782653688; c=relaxed/simple;
	bh=PDtU59Kh3wpAJvxt30d8t2uBQhcJUhdic+cO61jC1FU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ADQ78MX+ZnWkCJl2SRmMS2SaVbaxzy9Fnp+NpwmUSAUFduIFk8zbNU6P8hI61sbqnnuILN8rT4TPaNUW36TVgqtQls+gwySlPaj/seNcYk1bjCqRd+T4vtaOay3Nh17sslqcgLiy68WO/XtD3lTR6NzurDYxRtueyHTmD+tUurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ASFc3zkV; arc=none smtp.client-ip=52.42.203.116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1782653687; x=1814189687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcDqBkMW/Ccm7VfHBJQAyTe9gLN7Dy4mW/bs1DeRSZ8=;
  b=ASFc3zkVEibRJpGa5Iw2hsxZEpT+VM+ZQRiirtdpAOx8ahCmzcQhAdfo
   qFRakFlDoi2veJMOKNR2jkE/N49UtBysnDb6ymrfkrSCCPx6UnM6a9AIv
   MTaVWmuFBqhIkuPweZMda/lgD5SjLV6/lER57uEtKP+s/uFtm/r4AicHr
   NjxtlyelH64YDviImk/FUbeZiAvx7QOB0hax2cWEaBq3VY4U7Zva2hQCU
   Q1FpySa+UrVF4YsLM9crmZH9d8QYQfZNZ1tdVX6t7iXqBue/0fWcGK7yU
   FRu7PdHqZe4S2BNXtqT9dAdPaVFmh9vv69113xVK3k0WCJQV3vsF+oXf4
   Q==;
X-CSE-ConnectionGUID: G6TqojEWT+ewYACmoX3B5Q==
X-CSE-MsgGUID: t19o+cnBSOyGDIElZ1UBpQ==
X-IronPort-AV: E=Sophos;i="6.24,230,1774310400"; 
   d="scan'208";a="22666861"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 13:34:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:32063]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.226:2525] with esmtp (Farcaster)
 id 89230b16-c588-4b86-92bf-5ae0240fdd2f; Sun, 28 Jun 2026 13:34:41 +0000 (UTC)
X-Farcaster-Flow-ID: 89230b16-c588-4b86-92bf-5ae0240fdd2f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 28 Jun 2026 13:34:40 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Sun, 28 Jun 2026
 13:34:39 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next v5 0/2] RDMA/efa: Add AH cache for AH reuse
Date: Sun, 28 Jun 2026 13:34:20 +0000
Message-ID: <20260628133422.523230-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22540-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1766D3E83

Changelog:
v5:
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
 drivers/infiniband/hw/efa/efa_ah_cache.c | 136 +++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_ah_cache.h |  40 +++++++
 drivers/infiniband/hw/efa/efa_com.c      |  12 +-
 drivers/infiniband/hw/efa/efa_com.h      |   3 +
 drivers/infiniband/hw/efa/efa_com_cmd.c  |  41 ++++++-
 drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
 8 files changed, 235 insertions(+), 11 deletions(-)
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
 create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h

-- 
2.50.1


