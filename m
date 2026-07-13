Return-Path: <linux-rdma+bounces-23139-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WMeZBJsGVWpUjAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23139-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:39:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698D74D24F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:39:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=aYgH89eU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23139-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23139-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B35D302418E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA1A3546C0;
	Mon, 13 Jul 2026 15:38:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A82EA468;
	Mon, 13 Jul 2026 15:38:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957117; cv=fail; b=Dzlw3ie8EySYhQ/Sx8USQxn+LsuEQEyAtUBfIYSdtrMAW8pSL77QdmcUKEIJ8hZCj2hH5y59m+jcDl0r5aV7F+JBTW2BV6t3VD8eu3MhGJIfYApDLzg7F88IDz3aDBYc0KJm6HkpaCsWIfVkyDbPZqbbOHQ7eb/eQgfYNckdJnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957117; c=relaxed/simple;
	bh=OO30wvV6LH37hxt4MXjxegRbNqSrQx/xuWXGWRUsOss=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pBzIaCc+krPdR0lipMsncU0SLH3sqP9NBCZOHngQ0XImQVcukDrFFE9GJ3kMuY8F5QGpA2LQgGacaWZcUwiSn+PcH93RZdHaIyYlRlEyuk3vVMGcIOGVMmFY8htsAltnuQK+1kQS4b+r78ZXlT1l2yo6BSYVQmfnlS81uc9sFcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYgH89eU; arc=fail smtp.client-ip=52.101.201.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/dPbC1KU7OZnuyrOKSWH+KVP9YBDT1N6u/GK0fFavvy2L30DJ5CXBgBL7BYv3F+g5KP5NB9sM1n0+DZYjoozaaaTrdAujB/GVRiA6M8TeYpgwc72jlqQxfUB51nHGY1bDHCTs/7XKdpfBLQzWdhLwaV6qNe7HMbFYGxzX0G0+vdqgxe4SaOOPBZ3ZfyI5HuB7+lHXFQcT93QJHBxS+td2+SybM8kXhWDPkL4MTW1lsRxLtWs6zaFPRD6wwLl+QVb634jJt0/B9zuMqHznvxYPDOQtbCnfGDLnBOjvLDwjqcAxa2SvD0TBJ9+mvyJA7B+SYrLSWIZ4QmOsBg0lNqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGgF9HpxmoGqgetb1TVDIudYDYteqvfKqcZ461uAdac=;
 b=kYZKxJABgw7q9HmYJvFxADPs5yRzhK0h0FkFIc40oPIRTzCwumH+kcWyNU/t31POx8L4q6ATo15D6sqX11ldQIxiDhQt77t9owEEng4e9sXJkUa25WmqBTbkz9MkDGqj/3ysl8djyamSb2K2+wCVL6hBg4/EJYbLHElmIXiLGDzGIobValKBQAab2ptSXN9CEeiy/LsiwucTde0MHdyOLbDGm5xYzk/AAfTggPNBlmM41UY10wjYpSEb49OmiiSKA7JHFOEbwFFXVjvlHgS29JVrho2vuRXpEGydOkPDpng0whwiPhM3+n6NUFVdhqO3R2qrsLZdYxB3s+wkONCzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGgF9HpxmoGqgetb1TVDIudYDYteqvfKqcZ461uAdac=;
 b=aYgH89eUcTByr+LiINzLO7DLZ5lRdONLDwrRtYggnFhsCkbqE6ZY0rHpSshzLvvbItIpkL4HNVgxo4LwKT7zVRbz/XNcIy4TruRAoD4qOu7s8hq4TXvcrw70eVT+JclNaZMUEDjgI5mBmGxzc5kR5+8NkOkCsNJyHEDGgae4q/jG302BX0nyuzPQm0raa0EwDV0PmdiM4fJU60fyCjVvDELgi6eqB1xP5MCAvRIp39OUbpgzobYcXHfa1fueDjc3EEj0RiChxkg7aDFZ4SOHVmeGG/pB7HVcuTQ+oeWn2Rz/gQD8cAM1Mm6jUt0q9rkBnWa4KhpYip7c5Elf6MqJoQ==
Received: from SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 15:38:29 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::82) by SJ0PR03CA0191.outlook.office365.com
 (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 15:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 15:38:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:10 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 08:38:09 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 13
 Jul 2026 08:38:05 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next v2 0/8] RDMA/core: Fix restrack UAF in destroy
 flows
Date: Mon, 13 Jul 2026 18:37:59 +0300
Message-ID: <20260713-restrack-uaf-fix-resub-v2-0-bbe8bb270d51@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFcGVWoC/4WNTQ7CIBCFr9LM2jEUEY0r72G6wGGwEyM10JKap
 ncXewGX7+97C2ROwhkuzQKJi2QZYhV61wD1Lj4YxVcNWmmrTqrFxHlMjp44uYBB5p8x3dEGczB
 Mx7MxBHX8TlzDDXyD5F8OI88jdDXqJY9D+myXpd0K/+ilRYVkrSLvjA/aXWMRL25Pwwu6dV2/H
 KfancgAAAA=
X-Change-ID: 20260701-restrack-uaf-fix-resub-6f434ec5844c
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>, Majd Dibbiny
	<majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783957085; l=3657;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=OO30wvV6LH37hxt4MXjxegRbNqSrQx/xuWXGWRUsOss=;
 b=UtFLvqVIAaOJwdr0icBhKJbzQB4v8+OzrJdjGGSIZd/c5CYNX/UVib5Tub1XU/bfdU2SQvpeH
 HLj+ysXxdaQCG+H0whHVYAxfoZP61HQvKXW/bfxlo1o8Z/6NYRi4NNI
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: a42096c6-50c2-4ea4-a382-08dee0f4c85c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|921020|13003099007|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	OeoNQ5rKUpsZNQsnnX/gpZlXcKHQ0ZorL8zUzAWbACxyWXk7en1rlYF1a7VIuHsY061WJCXkszR0zYCpwy0i5pHwjsWL1NFYLOEkOWyQcNy2H3kp0SLr0vkIOhoSZBQee0zZc8bJrikRokFSvjP83chRQqOhkrTt9AVwcejJm472fbudnNJaO4MhaiN6Sw6QBRricCS3Ru0U73b/QT9KMwoiLaWiNAg60F6J2QYFoWIGulU60ZFOjCSmkz/x4yzlvI2or2ylfTxPQRtcDy8LqKbp3JhPYwInc6nI8p6/kg0VVsOr24PHDTe2a/nTc4auNAz+HAdVfOyJx/cRn2ofj1YBSeLDYOAPlb+FC3mrIZ8jKtMz1N1Pb737L/A2MKNIBaqoFw9gxTZ7tYOs/WY7k2/Dl0ReQAW8IC+Xq0rjHVp/eAWbVqpcy5zqmUzIEAZ0gfq0tGHOEunTFvCVsHJhp6uwaLns1mGjkt8yhHRkIcHc4Qji/zPfgVEwIe6O3hKaWYyYwC819xAae4Q86Md3pyTfYiin2lKYqDtAxSLwXilpmJJcSfb7SVwt+E0f6+UjX9r1MYbDQKtcY5RlqeXHcSBuue6X0ugVo7l+XV23gBHs6h2h7g5zcG05mPkCexNdBWSUUPTOAuHrDqZFNHK5p3bSBmjaNyhu4vbA06AMY1thjjiWKardzN5jhT6rS2aF6Nb0iNbKL34HwR+hCYpgV2QBljciEmsVl9WhC6NwLWkv8gPyfBDLje4a0iuhcee+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(921020)(13003099007)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QOB0UXV6jOoL8iuafdlOPdOnrHII74chQVL78+B/nmWWBStWn1QLDIK3u8tZBntcWS07JOjHQt+WGFwryMeJ4hzU7LhE+XVo6Z0mOyXt8zSqfYwK497pIdO92ZI5tph1ZlJR9vBVO6L5LDEsl14o57KPqSS3YPi1PPh5hBkMAq1YqmZC83NiND7+2QCcoR3TJeI0QzJTsb+maUOs3b3aVNfcGHd9+YgOeHToEDdYWM/q8Ur64iAnhdXGlmFyLNbOqnWpx0isFEFEtgPYPki7ODppWQGJg34ZKEJAPH72lduNEZT3JGs2AOjx8YK97UMjCA04WZBGM/ikMejCE1X28P5mtF5b4PkcV5dCMdNq5u1L1xit3rgfdxBfArmLTJiD3TIEqDIsiOVNpI69WkNFX65FqUlyNcqh5y/2rszpMHICQPZwAnz/AEJK0a6hS1xq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 15:38:27.0890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42096c6-50c2-4ea4-a382-08dee0f4c85c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23139-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7698D74D24F

The resource-tracking (restrack) database is the back-end for the netlink
"rdma resource show" interface which pins objects with
rdma_restrack_get().

QP/CQ/SRQ/PD/DMAH/counter destroy paths currently call
rdma_restrack_del() at the very end of ib_destroy_*_user() (or its
equivalent), i.e. after device->ops.destroy_*() has already freed the
vendor object. A concurrent netlink dump can therefore look the entry
up, take a reference via rdma_restrack_get(), and then dereference
already freed memory - most visibly through ib_query_qp() during
fill_res_qp_entry_query(), which produced the crash logged in patch 2.

Fix this by splitting the delete into a begin/commit/abort sequence:
begin_del() parks the entry as XA_ZERO_ENTRY (so lookups return NULL),
drops the birth reference and waits for in-flight readers to drain,
while keeping the index reserved. The destroy paths run begin_del()
first, then commit_del() on success or abort_del() on error.
abort_del() re-inserts into the reserved slot, so it needs no allocation
and cannot fail.

An earlier submission [1] carried the two preparatory cleanups that
removed broken restrack tracking for DCT and raw-packet RSS QPs (whose
IDs are never actually installed in the xarray) and those have been
picked up.  This series is a standalone resend of the remaining fixes,
rebased on top of rdma-next and reworked according to Jason's feedback.

There is a small race between rdma_restrack_begin_del() and
rdma_restrack_add() for a new QP with the same ID, whereas if
rdma_restrack_begin() was called, then the provider destroys that QP,
and recreates a new one with the same ID and calls rdma_restrack_add()
before rdma_restrack_commit_del() can be called, the addition of the new
QP to restrack would fail, the new QP creation would succeed but it
simply wont be tracked.
This wasn't fixed as the race-window is really small and the worst case
scenario is an untracked QP and fixing that would needlessly clutter the
code.

[1] https://lore.kernel.org/linux-rdma/20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com/

Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
Changes in v2:
- Collapsed the "no_track" case in rdma_restrack_begin_del() and
  rdma_restrack_abort_del() into the shared drain/restore helpers,
  removing the duplicated put/wait. No functional change.
- Link to v1: https://lore.kernel.org/r/20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com

---
Patrisious Haddad (8):
      RDMA/core: Add rdma_restrack_begin/abort/commit_del() operations
      RDMA/core: Fix use after free in ib_query_qp()
      RDMA/core: Fix potential use after free in ib_destroy_cq_user()
      RDMA/core: Fix potential use after free in ib_destroy_srq_user()
      RDMA/core: Fix potential use after free in counter_release()
      RDMA/core: Fix potential use after free in ib_free_cq()
      RDMA/core: Fix potential use after free in uverbs_free_dmah()
      RDMA/core: Fix potential use after free in ib_dealloc_pd_user()

 drivers/infiniband/core/counters.c              |   5 +-
 drivers/infiniband/core/cq.c                    |   2 +-
 drivers/infiniband/core/restrack.c              | 165 +++++++++++++++++++-----
 drivers/infiniband/core/restrack.h              |   3 +
 drivers/infiniband/core/uverbs_std_types_dmah.c |   7 +-
 drivers/infiniband/core/verbs.c                 |  28 +++-
 6 files changed, 165 insertions(+), 45 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260701-restrack-uaf-fix-resub-6f434ec5844c

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


