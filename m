Return-Path: <linux-rdma+bounces-21943-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z6ZeFneAJmpcXgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21943-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 10:42:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72B654295
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 10:42:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=gtva1JZ3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21943-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21943-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 224B8301F804
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 08:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8E3B0AE3;
	Mon,  8 Jun 2026 08:37:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0A3B3883
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 08:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907871; cv=none; b=PNJ+/+HrYIj6YIqzp+0ScLEQeIOZXzAGCPf2LYiTYSgC1C6Ey7ohTLFjWeuVZ6snnMXmOzarumP7peaFp+WvYk8Z4YwwxwGHZuUcdEVjZUvWzPKe017Fwc8MHNs10ne2bgjZHhvYOYBcKODTpUVoUegdqKY4VgcqY3aYpofLy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907871; c=relaxed/simple;
	bh=rtVKbiqIOHohbPZaJyB6f+NlD8OWOwViYSYHXX5K6HA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=No6her2lZl/FsHtEQlLLb+1qNssYU0+VeJ/DaQUfLvPIJyXrHQVTFPty9HCDQ+ItWHCD8mLhXV+uHW9iHi8oqGp7p/5KEQjf0ZRs6pxAM3geYeDA8DRKp+/EY7WLyYXZQDoq61eVvVAbnqn2NK0+EkvoBPVayX4eW1SXxS02ViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gtva1JZ3; arc=none smtp.client-ip=52.12.53.23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780907868; x=1812443868;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fSVJF8rDegJHjb5zNs9kowx2io0gX6foslvBKlRQzXU=;
  b=gtva1JZ334rsxZl7ovG9vep49HJ+abCtYZsR7xsGIAdETvheVx/0F5FO
   D3Z5V5k0XWyqGrbBaf04vAjftd5C5WQGnFNZfkL09KbURlfJVSqItaJsp
   5ciCnPtgU6fvtvtpgxbNMO1fbEmL4jcu3wJEtABW6u25noObtTztkhXgy
   EXfdZ2hWdns8RqShI1KkYoZHAFl4hhiTz8axinS/IDO24VrjsDt40/AcV
   KyE/iSXBZJdGW6D5WZSCuQ9sWtACsL8B7vgo3WUpL9KVuS/PLdjfqJ1V1
   46xny0BmH8RNeHwX55Pd5PKdbtB6ftBR5orpIVHidA28nGTNuBGj0XaRh
   g==;
X-CSE-ConnectionGUID: TY+/M94+T5WkykWyEGzEdA==
X-CSE-MsgGUID: 1By/zohfSjSLWHEduBrDCg==
X-IronPort-AV: E=Sophos;i="6.24,194,1774310400"; 
   d="scan'208";a="21182531"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:37:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:6983]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.151:2525] with esmtp (Farcaster)
 id a509ba79-8ada-4dbf-b201-20b952f98e39; Mon, 8 Jun 2026 08:37:43 +0000 (UTC)
X-Farcaster-Flow-ID: a509ba79-8ada-4dbf-b201-20b952f98e39
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:37:43 +0000
Received: from dev-dsk-tomsela-1c-ce9cc34e.eu-west-1.amazon.com (10.15.30.17)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 8 Jun 2026 08:37:41 +0000
From: Tom Sela <tomsela@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<mrgolin@amazon.com>, <tomsela@amazon.com>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Report 800 and 1600 Gbps link speed
Date: Mon, 8 Jun 2026 08:37:36 +0000
Message-ID: <20260608083736.48454-1-tomsela@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-21943-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:tomsela@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:ynachum@amazon.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tomsela@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tomsela@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE72B654295

Add support for reporting 800 Gbps as 8X NDR and 1600 Gbps as 8X XDR
link speeds.

Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Tom Sela <tomsela@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 434d60235945..5cd34746e6a6 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -282,7 +282,13 @@ static void efa_link_gbps_to_speed_and_width(u16 gbps,
 					     enum ib_port_speed *speed,
 					     enum ib_port_width *width)
 {
-	if (gbps >= 400) {
+	if (gbps >= 1600) {
+		*width = IB_WIDTH_8X;
+		*speed = IB_SPEED_XDR;
+	} else if (gbps >= 800) {
+		*width = IB_WIDTH_8X;
+		*speed = IB_SPEED_NDR;
+	} else if (gbps >= 400) {
 		*width = IB_WIDTH_8X;
 		*speed = IB_SPEED_HDR;
 	} else if (gbps >= 200) {
-- 
2.47.3


