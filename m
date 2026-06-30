Return-Path: <linux-rdma+bounces-22593-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pODTKRGzQ2qVfQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22593-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 14:14:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BD6E40DA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 14:14:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=YbWAHt26;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22593-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22593-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F64331D4E0F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423EB407569;
	Tue, 30 Jun 2026 11:52:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE31D406834;
	Tue, 30 Jun 2026 11:52:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820361; cv=fail; b=LUuB61iawlQrpGnO2fmERniJn6fNsh4set/wyuTaJhyHPxfWLM3r5tpQoJonnSqdthy2yBU7qo2GJ3IsT62MPH+WVjz8x7uaydqNokKumnsAk+N7PJbFo+Mt11TVQJqUzBgR2YtO8gTjIB9q5vCWwXzma3roD6/N5YrFhckHZdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820361; c=relaxed/simple;
	bh=1m+s8kIiEjjOPumNxHzP3ywqwpk+EW/ybtnkn02HQmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnrwnjpflRd6pKPa9DLbQEbtHGHTMieBFiOsmQQ6+7Kcnb17Wc4G8kl3AoZD7SzTxbo9OK+l+gPgKsHeT+Abp9Yd7Jnko+jnmUaxL4pIWtep1bdaFRw1ru5j0v5NgyUER/bvG7LVoHoWWYzqftZnskHkgU41Q1cVldZSv2FtxZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YbWAHt26; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITkKnmrguHsJoWOMxpIB3HaR/LaM4t01cbTjN4TjABaTt11sIQhnOlvcc2SipjUCfxFduTFWBbI+7bG6V2QaTmxEQcN1uxHfL+2lzWzBdoUcFnqfSmw8XiJ4QZG4E3pwnJSrMhnRA0+JiGrGYF2phnsgKTj/CBUosPuevmRAmglSGR33OKMUFtL0a5DHbcRl65kGWr+TA0d1DVnioaRGo9hbI98tj7QluTRVfuUlieTOpcyLHFdRvFnZkYt8Rj592Tnnjo6l23/nU8Keijp0Cq9J9b0eLgMxB9kdDcAsJ/J9V1pJ39Jsm60yjIBVCYVTd0dbj5kloMhghbs3XnpkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+R5svDDTBXJ6g+cSJeJHI/O8ToVPhciOqEqOQ4CCHk=;
 b=qcN0CssCZS3ewfA0BHuY6Tg7+sAE5L93Ij9iBiiFEiQmCuz3GALMUZnXpivs3PmBz13Z0PcFVvoyAz8FEHVmUcpFLcjPcTlLqGLS4ht6mANB70mW8rA+YH34uf1o9DwNIQc6vgykpK+CM/LxuYOQZZkgbFFhQFG4EEwKesGx4+9IUEj/rGMt7TYbw4F396BRdob6ZtjcqYgR2XojJPFc1LCtR4lXsr/RjpDvhObki1KYIsKBnh9GIFupksu90TsGi/3QC6tf6M9wsDGGkvia/fx9x/V89ErOwWz+4PPZteiUI2FmO1RlhPJ9kZ4dYscvcDLomchVlnsuPPxFdCzfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+R5svDDTBXJ6g+cSJeJHI/O8ToVPhciOqEqOQ4CCHk=;
 b=YbWAHt26Tyngy8fnODLos9SunbH9q5WTufWgvoHXN5M7c4sIujnn8jURGXUuLnJS+FJ4zPsC5cdlRqbW3APaXbvhYhDTwQCnV7nNy7b36ac407oauLG6G4MjOqzn1HzjEM4yQTSt+JUJHK4M3tN0CmigYFEgFS3jd5mMPa71jS6vQmmajAPlx9yHwhVv7cAEFAMzqxTGPkypW9jMJP0STT8tTsgWjIiQUwgPj9VrGht5C0Bm/icVJi80KAf8qyNby2NF/53qthcbQ9BXzxrb5rN1znHP2s2KjnfcYZRZxVf73v6apqKIVUqOBP6H2te+KqoV/XE/o21mZWxUujxZ6A==
Received: from DS1PR07CA0005.namprd07.prod.outlook.com (2603:10b6:8:456::9) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Tue, 30 Jun 2026 11:52:35 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:456:cafe::5b) by DS1PR07CA0005.outlook.office365.com
 (2603:10b6:8:456::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 11:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:52:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:52:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>,
	Feng Liu <feliu@nvidia.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Lama
 Kayal" <lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Simon Horman
	<horms@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Kees Cook
	<kees@kernel.org>, Eran Ben Elisha <eranbe@mellanox.com>, Saeed Mahameed
	<saeedm@mellanox.com>
Subject: [PATCH net V4 1/3] net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
Date: Tue, 30 Jun 2026 14:51:49 +0300
Message-ID: <20260630115151.729219-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630115151.729219-1-tariqt@nvidia.com>
References: <20260630115151.729219-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8250e049-1e12-463b-b616-08ded69e1375
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	t44wSEnpImdmS4T4FI9ZhaGolzRpibGvYIwIZYjZCo2OjMgbSZTWI4MEjzZCKNJtFlu+zLTKsQBXSl2Qfn9dHFTNOlfTiia/vAbMwfiPtix72DoCoS5WvkOp2U2bOMsZlUHqueNcztMQWkoh1uct12BWl8FwvdHcWdwy5qQ0PmEabJNEmTRmUQpEejayhgCobqqzoi18sB9GNuRNk6BPbJqZjDNtYWIEpMrhRgcWWDWFfRuPt3eM4jw8cIkDGkuoYQBfrvXL8B9ueAO8fha09ya8PFHSJhoWaJW2C+PVZJSvQLg1M8bwL/Fm+c415h/56BJZf8Oh+mLKOxSnzHUQC9J+qAxhs1HYofQAlUZUlsBVJlP6ja3ochnH63Cujf/n1VBo3yyyAIWub8l1tfGV2HIXGcLrBDrQbWEd6HsIQU0xc1UwXwkBV5FMH2xG1LcNXI0H3ihsHyEHZuS3rEn1N6E5E+93b39f3P2MSyNRidkuN/4VII5H7WV6/VxqhCGjiCyaVgoqkw1R2uV89yJoJzwhZdxAVO486KB2727RwCd/QE8u76oPhLM+zrzcm7uZPwdJvESP8LSBDaoxYXUFfYRBU26h3GfwGS1Nw21Lyz3Ur3Own23W8jJJCpWK4IW9DZmhiHdXMC7hqd/wlqn2sLMB/qrVr9o7se2FddPWuDIJXIpdZn9/G9JQGKIYRsQ1u3wve6b1I78K/VtwErcduw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eCJFNFZQmPD6ipMCUFMTRhHbzpCwTxDNQxtcF0nqwQc0na/dtZ+XsQXagafmJJsSOW6SYZbz/EZ1PNFyqi80ZBD6ltajO8BaQ3MofAkSLY6jhaq8FS6gAACqy05z68V2DJcqR/DV+1Sr5LQkNuPIxQ47gCZPXtfErtlLg+nzO65J6hFbprZqFhJk/UcfZ8Q3H8BEpxJJao5jqMU5wXkrirVc2Wz9dKqmB96WldCXOeeRFejI/VcU+uJ5pYlqRGVUhxvwiMWlPF4SBJa7Voj6ZNBJ5Plx5zkvDfUOO1z1ZsjOYehdIPWbN6Em2o3kGCsV5etZFIh9kOC2YwT8abYz6FRpgeCek0+aKF82MwgTs6U/Z+agYGhf0N3oz/2tm8SxXJCKulIFfXSkzzZd+oOx6UjmfWMjq8f3R9uAQmxyM/4fKgZzQdQ8F/qrdxd3d/B4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:52:35.1218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8250e049-1e12-463b-b616-08ded69e1375
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22593-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:gal@nvidia.com,m:alazar@nvidia.com,m:horms@kernel.org,m:cjubran@nvidia.com,m:kees@kernel.org,m:eranbe@mellanox.com,m:saeedm@mellanox.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 078BD6E40DA

From: Feng Liu <feliu@nvidia.com>

mlx5e_hv_vhca_stats_create() is called from mlx5e_nic_enable(),
before mlx5e_open(). At that point priv->stats_nch is still zero,
because it is only ever incremented in mlx5e_channel_stats_alloc(),
which is reached only from mlx5e_open_channel().

mlx5e_hv_vhca_stats_buf_size() therefore returns 0, and
kvzalloc(0, GFP_KERNEL) returns ZERO_SIZE_PTR ((void *)16) rather
than NULL. The "if (!buf)" guard does not catch this, and
mlx5e_hv_vhca_stats_create() completes "successfully" with
priv->stats_agent.buf set to ZERO_SIZE_PTR.

Once channels are opened (priv->stats_nch > 0) and the hypervisor
enables stats reporting, mlx5e_hv_vhca_stats_work() recomputes
buf_len using the new non-zero stats_nch and calls
memset(buf, 0, buf_len) on ZERO_SIZE_PTR, faulting at address 0x10.

Allocate the buffer based on priv->max_nch, which is set in
mlx5e_priv_init() and is the upper bound on stats_nch:

  - Add a separate helper mlx5e_hv_vhca_stats_buf_max_size() that
    returns sizeof(per_ring_stats) * max(max_nch, stats_nch), and
    use it for the kvzalloc() in mlx5e_hv_vhca_stats_create().
  - Keep mlx5e_hv_vhca_stats_buf_size() (which returns based on
    stats_nch) for the worker's active payload size, so the wire
    format (block->rings = stats_nch) and the amount of data filled
    by mlx5e_hv_vhca_fill_stats() are unchanged.

The max(max_nch, stats_nch) guard handles the rare case where
mlx5e_attach_netdev() recomputes max_nch downward across a
detach/resume cycle while priv->stats_nch persists (mlx5e_detach_netdev
does not call mlx5e_priv_cleanup, so stats_nch is only reset when
the netdev is destroyed). Without the guard, the worker could compute
buf_len from stats_nch and overrun the smaller buffer allocated based
on the reduced max_nch.

Allocating a non-zero buffer also makes the kvzalloc() failure path in
mlx5e_hv_vhca_stats_create() reachable for the first time: it returns
early without (re)creating the agent. Clear
priv->stats_agent.{agent,buf} in mlx5e_hv_vhca_stats_destroy() after
freeing them, so that if a later create() bails out on this path, a
subsequent teardown does not double-free the stale agent/buffer left
from a previous enable/disable cycle.

This mirrors the existing mlx5e pattern of preallocating arrays of
size max_nch (e.g. priv->channel_stats) and lazily populating
entries up to stats_nch on demand.

Fixes: fa691d0c9c08 ("net/mlx5e: Allocate per-channel stats dynamically at first usage")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index 195863b2c013..72f3ca4dd076 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -54,6 +54,12 @@ static int mlx5e_hv_vhca_stats_buf_size(struct mlx5e_priv *priv)
 		priv->stats_nch);
 }
 
+static int mlx5e_hv_vhca_stats_buf_max_size(struct mlx5e_priv *priv)
+{
+	return (sizeof(struct mlx5e_hv_vhca_per_ring_stats) *
+		max(priv->max_nch, priv->stats_nch));
+}
+
 static void mlx5e_hv_vhca_stats_work(struct work_struct *work)
 {
 	struct mlx5e_hv_vhca_stats_agent *sagent;
@@ -122,7 +128,7 @@ static void mlx5e_hv_vhca_stats_cleanup(struct mlx5_hv_vhca_agent *agent)
 
 void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
 {
-	int buf_len = mlx5e_hv_vhca_stats_buf_size(priv);
+	int buf_len = mlx5e_hv_vhca_stats_buf_max_size(priv);
 	struct mlx5_hv_vhca_agent *agent;
 
 	priv->stats_agent.buf = kvzalloc(buf_len, GFP_KERNEL);
@@ -155,5 +161,7 @@ void mlx5e_hv_vhca_stats_destroy(struct mlx5e_priv *priv)
 		return;
 
 	mlx5_hv_vhca_agent_destroy(priv->stats_agent.agent);
+	priv->stats_agent.agent = NULL;
 	kvfree(priv->stats_agent.buf);
+	priv->stats_agent.buf = NULL;
 }
-- 
2.44.0


