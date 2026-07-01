Return-Path: <linux-rdma+bounces-22635-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9kZcIioSRWrO6QoAu9opvQ
	(envelope-from <linux-rdma+bounces-22635-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:12:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D549A6EDE59
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:12:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=O39cXu2j;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22635-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22635-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 985C531FF764
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3C248BD56;
	Wed,  1 Jul 2026 12:29:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75E48BD51;
	Wed,  1 Jul 2026 12:28:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908941; cv=fail; b=UhXM3PL6jwRrpTtcybf2Y1Ni1H5aZ/27br1CeQGDFcv+c+mA3Gohm6MNBuujAxLHA25Bf9u98Dj7l+Z/VwNF0n/XW7z/7xE6rXK9xN5kKK2bKQdESK6I+9GqXqkeINOStVr7d5HupnUdYw3yQv88j67bMNlfjmpKNljZfIm/FDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908941; c=relaxed/simple;
	bh=SyJ34j2tqGgH9ZMA9j5kCxNntbXlyKmZ6Nu8diOouTI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=haJhFBiClpmOznsd6qwQg+5IJRWgVoZd5CCN1knkP0KFXOkR1NUf/id5/vWaNbZrJ6x5J68lbUuneHUH4X2E3mbSjcEa5ZUUayQDefpWKkvHrgurNtf6v41KakViyvUsLwut/o+cD13osJBLKPUa6yOcL44CO/B/uyrpsetO/C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O39cXu2j; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOFqwL6c//EPn8x0ZCm8CW8BAjUGJG7nuio0Qm+QD1DzmHk1PjSDDB3OG5W+I1q/21ivXL6auXiPjaGV7r7jrzvMqIqLKKfL3FpvR9cjl3UEBmtCgkpwieeu/06xbC1FR14Jut2+HAMUg1HDnw5vPC03AJdV5e3XMK/Xwk+2zqti0Uiiu0covOFvj5/kEgD4pcn6F4dyMX8txD1+YamqqprMUFLjGVe7tyM5Ux3gitYBZ5EbYS5Ax9zJqg0QNsIxo3GYELarhGclXsMXd3D8YTeco/GBC3MA2oz/OhUYbPrsdYdWzJcRSJDth9rLwf3k52Z7bAXNbVgPMsv+do5f2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0UiMWXNqV6U1t+jCAZHPwgxcBr1BA7D7ZX3wqfO6Pk=;
 b=Yo+aUmcKY2pQkcWqL3KpyJN5zgodQybmnnepepI2sqxd/FkNWRKtzRIYOKQc7rXQXv35o5qIafLxO9HAqoXerWnScPIviS2QGIMnBgERNDgXutPvDDHuIfAzyFD5gNCKZFWQWmE18D2VW3gDWYkKGBbXcdlkv36C36+q6Y4NfvS8K9tCoasY2lTsWZdIghrFkb+s6+AqpCfSZbp/nQ3OWZDSi57InS4wAPoHq7Df0PS7sIuAPlcFb+lYkK7EwDaNv7JNKwKARiwHUhZRI2qur/hHkFTKjUk22pUG6NZ+MpM+gIsYVRB57g0Mos1YI0UI3dcH9ozCWAv57ydprun+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0UiMWXNqV6U1t+jCAZHPwgxcBr1BA7D7ZX3wqfO6Pk=;
 b=O39cXu2jTjeqaMQ5N3+IS2LYGH61c/pulFWt3u/tSEhGo5zIJXRlfnBNvqS9kGfzHoeyzCaHXfUPbZv6HkM7+mAgb0zHTbsrm8zilzQpI9/YCoUcURnsCD4QiyN8E7hcmfWfRGSpQH7XSURkNcxoK6PPvV4NmEWsOYvOPGPW/1XkGTfSJdE4QYvaL+XP2qCWLs5kpkM+Ihr7s6Y+GC3HSJGS6WiKw0P5pYM0pN7yNDNFSh4GIHJ1q6FRGa4maokU2zt793tvPDQ2czl27SFM5ZmSIUTZ5LmU4R+UwgRrq29nzrrgm1MIWHdbmtRykSXRhr5EAnU2UdsJxqhLjEkRxg==
Received: from BN9PR03CA0645.namprd03.prod.outlook.com (2603:10b6:408:13b::20)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 12:28:51 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::18) by BN9PR03CA0645.outlook.office365.com
 (2603:10b6:408:13b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 12:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 12:28:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 05:28:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 1 Jul 2026 05:28:39 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 05:28:35 -0700
From: Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 0/8] RDMA/core: Fix restrack UAF in destroy flows
Date: Wed, 1 Jul 2026 15:28:14 +0300
Message-ID: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4HRWoC/x2MQQqDMBBFryKz7kDU1IpXKS5inLSDGGWiEpDc3
 ejy/cd/JwQSpgBdcYLQwYEXn6F8FWD/xv8IecwMlaoa9VElCoVNjJ1wNw4dx3vYB2ycrjXZd6u
 1hXxehbJ8wl+QcTboKW7Qp3QBgGJGJHMAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782908915; l=3339;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=SyJ34j2tqGgH9ZMA9j5kCxNntbXlyKmZ6Nu8diOouTI=;
 b=1JNaQ2EU+yXIguEOn1VCbi5YabxUY/6CY0uaAOgMmO+XA+Cp1keye5kJqRluKjCgQoo2S5BgY
 Jb6/3YJGVa9B+lHuiKO9ui/bCG9A7cbGABVMswtRsuIrTLVWQJZjJXu
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f7bcf9-c35f-45f6-96d4-08ded76c4e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|13003099007|921020|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	XsilxEb/fUkqAjrce2mLeUiCgnRNb943O0Ae4xusBkI4MH+UHbzXvQCoKGoWsPXu0iQxnvSmVX+j3TV669vtYUFboZ3RXMqIJAZ3aLPglJ/3s1LPOsM14FF7u5KeEYJFb8dOorGqZEOMWE7EPl6KfZMcFCLUZKEvTqdEi1Jnj0pAx6jfUNs5iTOreGKuK7nJbVsnL/1NxSskWv8mdidKCZA8Se2783GtVtCmE2iNZCrTLj1J/tjSFAt7RRXkJELIxiSKD63aFkQmtt+vlcCfD8K0/2EuuxX8xyqWJIS1LeLB0J7DV/fpndHM+or7G/SlmidmYEiFZ9YMoOyZ9TgfpqFhpYlGjAQhYr3vGHOEcd7jbVPZUHat1zZkwZpzepPOQ8GyNEqQaDlzfuL/eNjLENe4Yy8lwEcIra9iKeNJdD234y5O1n/45zhsRFnIBD6IMW+4aNlbFLpIvfDzFsdJ17qeLrX2f1Un3CAwCAHVUttjbcuPwOqS80+DjrQPY3YVd4zjVmqUsK5ahIxrpHxu4gIMmkryQUrQ739TkXAPnuhqA5xlwGeDI1H1XcNL85kXbTDr/1lvftZPLVNO06C5SCDlZR5bmlcUpRmqEzYXaQg3jyIDfsuuV1LzqlH3Fmj/ZqP8BCgzrDol4zpvEEl6wSFhvXO13+Hvp6OrvyqL2HrCY/e5trf9d9SdMF1XV9Tu4C46fnMP2HCQgZF+7Alo7FHEeWpJMvcEYkQ3d/Bc9Lw7xkNSTeyleF7UdYQlDX0A
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(13003099007)(921020)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0Tt0VkrcECm/h0xG8oj/++zAh4r61x+bBhguSCgSqny2WYnUR41IJmgSnpDv7i/aMRQxHg1xXdKkQtw2ROpv9zO1cUM3V0DcVQvLOwEVwEOjQM3qZLbxmkgGLQvAhVjjlb641Gs9JFIRoHZw63FSo5sSQlOkE6w8VdMekE/Mehu1HXIbZSFtW7VaO/SGfNTBEJtrbiXgjMO7p5N9RwMGLtEG4LKNMfPuvekmTDbqRvHr5ZhbT35AgPNOhHnR+WrVhGIrvoXhrNxQ+DWT1hiUogGA43CSlJBzhqvqJ1ak5XeeQDqB8RrmxF2k8s2yVEcB8Skv6nfHUQia9V1Q9cTTmk8sp0WmSkgPAFrF5P5cCF6uxO/jVghc2NAjGkVRky13F5cSX7Rop4fjc2dr/iqAbewlfay+p/JpHv9Yvnm8/+c0kBj6sCtuZntLEphQmyGg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 12:28:50.6391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f7bcf9-c35f-45f6-96d4-08ded76c4e9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22635-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D549A6EDE59

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
 drivers/infiniband/core/restrack.c              | 167 +++++++++++++++++++-----
 drivers/infiniband/core/restrack.h              |   3 +
 drivers/infiniband/core/uverbs_std_types_dmah.c |   7 +-
 drivers/infiniband/core/verbs.c                 |  28 +++-
 6 files changed, 167 insertions(+), 45 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260701-restrack-uaf-fix-resub-6f434ec5844c

Best regards,
-- 
Edward Srouji <edwards@nvidia.com>


