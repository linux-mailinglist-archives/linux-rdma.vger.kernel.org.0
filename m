Return-Path: <linux-rdma+bounces-20297-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePuJFEhCAGqcFQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20297-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:31:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBD05031A6
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5B1330028FA
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F340C35E943;
	Sun, 10 May 2026 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xm4IaK4/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C551EE01A
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401856; cv=none; b=YJGOVXwyVZqRxsf7nVBZv7cfiUTkwWob7MJM6xWde7uyUM8L1Q1Am0qnhlbgp3g2anR9TKL8PGCz+5xlgJPDpPvr6SmEco044cBCo2Qduty8sG9AI3fWtBs9tiXjn/vnvgU9Oyhv+dsaIDB1ZjiARAKKCE3dY0nCdeu/SmF13ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401856; c=relaxed/simple;
	bh=hBkrKDOLqtaFQhZmKCB7XLYvnq+vKA3KPZaxKnYIqdc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r9I0BVw1kGcBNlWCClNHOe1uf8AcNj+cl7bLGanHWo4bF5VQXzavStvgDUDlCu2ZssECyEZP8hR3S9DutyzKC8P2HFKYy8JpcxOGTatqSEhNtmGyRvC9Ypu9kmLtxwh0eLsnAfk8dJxrQBMnfTfqTWcecWKF4M1q4+faZFkdCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xm4IaK4/; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778401855; x=1809937855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6DGgXI+wUuTLkhdgjyzP5Dcfsa/0/Cj2ppv4/2zAG1c=;
  b=Xm4IaK4/aCoy0ycGgSU4iCVhIUEnzuKNvFfNrsvT2tEDUheIH8ABdlu6
   9XeXqsGgzP5arMO6K7UGh1LDL5YFXuRKY/+rDcqp20Q7WEpeGhp+q/ZSo
   M0VcPZjqUPq6nd+4oHfyRNIuEn1ANLzv0g2eoKn1m+ntUxvhoeucvF9Hf
   FMKJlJCEgtdRbdr6wKyKjQa5awSiRrs4DeVFxOL45bDeE2ygxj58Vpfjb
   WJ7WtdU+1luaI+WeSCOJLjF/SA+WX34YG1+LK1s0BCmdI5wQkePk4pgOu
   Tr7OMpswHdmmPt7pbkzX9o0uuOQNkcPMjkYSSR+kWExBkD9Zl1rWnMeoH
   Q==;
X-CSE-ConnectionGUID: RPjWSManSnO2W0Zd3sEQWg==
X-CSE-MsgGUID: tE/PmdQ2T0WuZtEN00e0sA==
X-IronPort-AV: E=Sophos;i="6.23,227,1770595200"; 
   d="scan'208";a="19070529"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 08:30:53 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:9611]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.175:2525] with esmtp (Farcaster)
 id 47e45a8d-873c-4f05-9a6a-e9d82a7423f8; Sun, 10 May 2026 08:30:52 +0000 (UTC)
X-Farcaster-Flow-ID: 47e45a8d-873c-4f05-9a6a-e9d82a7423f8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 10 May 2026 08:30:52 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Sun, 10 May 2026
 08:30:51 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-next 0/2] RDMA/efa: Add AH cache for AH reuse
Date: Sun, 10 May 2026 08:30:33 +0000
Message-ID: <20260510083035.458081-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Queue-Id: 1FBD05031A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20297-lists,linux-rdma=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


