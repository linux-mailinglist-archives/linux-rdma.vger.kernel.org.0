Return-Path: <linux-rdma+bounces-23080-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k6E9BjqaU2qwcAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23080-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 15:44:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FC744D69
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 15:44:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=LAHX5iGq;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23080-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23080-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F26B300D9D0
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886C37475B;
	Sun, 12 Jul 2026 13:44:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BC0188596
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 13:44:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863863; cv=none; b=GkBd9zz98zSr8eTsBjPVywOEkl4H/97sdj0dQe6DN1VWAa7iaeTZfkhvHs/nmU1R+4v/Rp0TF2+7Kw4I3BR2B3ZwcfXBU5DiP/pXwwMG2zofEmOnTcOHLfioyiCRmcWir+ZexwHinyzHUm3ljhsL+RDUKpxRTvZ/8BDWTjNgh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863863; c=relaxed/simple;
	bh=/35a1UjpP4gldvo4aDBE5ZQc4W8RqOPKUkKeIoIvDOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS9rG20JRVySxsWcUBPv1GRfJQwOswfeD5LJ0y+NuDtjxZ+Tgvt31wQLG7U8pCEXVV/KbD8EAjEfUenSqmyBTeXI60LZQ60KkgeblANO1PP4d42GSkPgXHJUbEMxX3Ucp7IovMMBNmiaHA8PYbWHMhljzl5uX/co0v3X7dOJopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LAHX5iGq; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783863862; x=1815399862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IB1Jg5I3wHtlovx++uiVz7QwfG54lb+N+EDl7GukyOw=;
  b=LAHX5iGqKAPNAbACQo111Ew1N/rRubq9/IUrfpIIUcaI9PJdSdVGQX+U
   RBu8dA+7qDGGKfaKlmZV4OxS9jL1fp4dYdrx4Jrntdqy9h5viLXCqzv02
   /JIY8KCRxKJ1VzJMWElPnrFG3HLGRhtyhJwKbKeF0GpcDNuEYAQSd0mFb
   r7BIbmwQoITDiApaeVlUO2uFu849c+m56nhvJjVU0sZMV+uQX18qFgAcP
   5QXzBBWomNlyq7ke7dL2zT3OawnsbqGXO8DiO2OmO3kpzL1lmTltnmtjk
   3lY7AZMMFPcux/alxkhOy24Qw4AV849QPRD5rSrzBGwnExih3t3r7ACF+
   g==;
X-CSE-ConnectionGUID: M/K1OmCFQd6YgwKfkr/JKg==
X-CSE-MsgGUID: Eeln9dyDRraiGBKTof/lUA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23408803"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 13:44:19 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:29374]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525] with esmtp (Farcaster)
 id 779eee31-d85c-4f54-950b-9a6f52c7e4dc; Sun, 12 Jul 2026 13:44:19 +0000 (UTC)
X-Farcaster-Flow-ID: 779eee31-d85c-4f54-950b-9a6f52c7e4dc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sun, 12 Jul 2026 13:44:19 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Sun, 12 Jul 2026
 13:44:17 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>, "Anas
 Mousa" <anasmous@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Add EFA 0xefa4 PCI ID
Date: Sun, 12 Jul 2026 13:44:13 +0000
Message-ID: <20260712134413.19226-3-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260712134413.19226-1-mrgolin@amazon.com>
References: <20260712134413.19226-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
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
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:anasmous@amazon.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23080-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C27FC744D69

From: Anas Mousa <anasmous@amazon.com>

Add support for 0xefa4 devices.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Anas Mousa <anasmous@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 97da8e828e34..ee09dc1e0b43 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -17,12 +17,14 @@
 #define PCI_DEV_ID_EFA1_VF 0xefa1
 #define PCI_DEV_ID_EFA2_VF 0xefa2
 #define PCI_DEV_ID_EFA3_VF 0xefa3
+#define PCI_DEV_ID_EFA4_VF 0xefa4
 
 static const struct pci_device_id efa_pci_tbl[] = {
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA0_VF) },
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA1_VF) },
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA2_VF) },
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA3_VF) },
+	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA4_VF) },
 	{ }
 };
 
-- 
2.47.3


