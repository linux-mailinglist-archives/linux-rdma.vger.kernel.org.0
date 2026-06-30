Return-Path: <linux-rdma+bounces-22592-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BuTXMgqzQ2qPfQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22592-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 14:14:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE06E40D1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 14:14:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=c9Cy7gpD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22592-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22592-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D21A30FF8A2
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C23406825;
	Tue, 30 Jun 2026 11:52:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4C3FFACC;
	Tue, 30 Jun 2026 11:52:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820354; cv=fail; b=M/C8dmufHk/Kwz9xDql5fKBhG2WHr1f9kcActEoLFz6JqYaETKGiv5Bd6iz7Z4WIs+2MWWQp3TjgVDF+qKaW6ADpTlLf88H1KYaaIC3MtiDnRPXVda0+F6313h6YVn/PfP/hkxde6jrKhTv8Bxqwm4yAEaqkE2Oyw+C4J3R0YsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820354; c=relaxed/simple;
	bh=/TV1PvlCIWJJRoDLgn7kXO1d2Zur41kJbSq4yLI/3r4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XSL9U2ab6MhPjIztq70WGZtiUwuMo0DNIrp2Kaw9V++CVJHc+ZIlKHS+ZF6CmEiBhLLpLbqN6G50EL7goD3T2YNw0W1i7WDSNY8X0fD2nyoXUTVR0yErTwGLx0gk8LjrwyIoH7WFsPwzswnlh9GEwAdBB3KC8YpAoH0l/X6imHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c9Cy7gpD; arc=fail smtp.client-ip=52.101.61.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyyrZnMyJD9ZkA/BuTr1EPbJKXwQrZSzbiuFqC5vKDs7vaRtrO1AR3YCHbW/pac9nVSUgSvgvx5HEqxDmltCmAGgw/ysQB7LEoCTM4YEUmnEyUURhTiS9/b19bw+bcNzuSRfBNgVScd06p3BkJuLozkyfBsmvypWFojqwYBc2CUqGlR5CBrt6OI++Zo/zJsNwX6DMvDkuc4Ba86X0UnLQUoprP63g8lauF+V9TMMc8MLWrD78VFwQsgXJO/j7b5yf3rm1moKgYWlqVfcEaDuqkdnn8sX47O2ocAnIDVquWxVzT8X6N6Ixsa9w9xwUJzeyze+oT5cmaxll5DDQAA+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XZ/mThXl0mlgaGXAO5Vo4vz5TUy9gA/FC1kY8OhS4Q=;
 b=nteMv6uITxeY/SUT5m2P0hZ7yxUK8OdGigoxd6iKLimprt3Mxj1cOi6gKt5THbpmkSz0BX5x8G9wxWaU+vgbLtw8Bo1QmetTh00ZGoRVcF3ZeDg22Dh1SlP7hvxFEFTavsPJuRmjGNyDoy3T5l2YHrVCcMLg9fGZCnKKDhj/7NXLFRGc09MQZpwgzxmW71PyK0IASHpoqNTLEy/d7syV7dclyk8Xsvq4WutFZn2wvEIK89ksC2sl0cyrxkAdQ7IZZwq2wg4NbAUaDyckO/1H6CBDD2oj9hpD635Vf7VemXVFWbkYrQze4nt1lXL5lLb6fLOmQ7MwMRyaI+cY5lsOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XZ/mThXl0mlgaGXAO5Vo4vz5TUy9gA/FC1kY8OhS4Q=;
 b=c9Cy7gpDIIn5us2rWpqhzJlCVx5nTZrQBYHE86IJY5CK5yLlbX69+PKCgrOHXIjSGwKWy7W3Gcn4NO6QRr+gCMbIRV3B+TS4FlgrZPqJny/7F6Q56/E42gSAlzQzIapgUntYi9X3z4BYYThq2KO+HQQr0fIEVDTurcxxuc6CVsd8Pttg6NGFXLKPyVBSRb6QHha+52WMj/6BYn+6SOh+fdMumFp9vl6jJe4R72CbgP6M3mHLN5c8FbgNbKEzUSFTBB8guNUKWHZmMjjwRQVGkAT+O5h99MMqVqRdNzaYJ6noJ6fAhcKGHXd1zaOxMVEKCV7MF0vZP2uCZw5YWJCVvg==
Received: from DS7P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::9) by
 CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 11:52:28 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:25e:cafe::7b) by DS7P221CA0032.outlook.office365.com
 (2603:10b6:8:25e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 11:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:52:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:52:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:52:04 -0700
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
Subject: [PATCH net V4 0/3] net/mlx5e: Fix crashes in dynamic per-channel stats and HV VHCA agent
Date: Tue, 30 Jun 2026 14:51:48 +0300
Message-ID: <20260630115151.729219-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5cfef8-f3c7-43b1-e4f1-08ded69e0f32
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	smczAsRuYUvqXNS9CCjZHyVomzwJghLvits8pb7YUjY5Wo2MmiieGCBh1z8Gm04WySlrFuopo7P8fNn14m03jvzvMc3I25s0lUo5uAG9rPOEOp6/7JGl3kTJZ9lvIvlMhHcqKBLqeIt1RqjEc0gsF0bzvzCC5vIv7sg6+pJFmu/XDDI7Akvw6ossNBS0r4HfQR0cagKSgMlgm0L/1Nbj0MhB25dbAXWBxqFTqNQ6EEvKfJcSFQXZA/9VV9Fkv8cvboHX2FK8Izb3GA4yDZhD3ePkhgmwiEK2grEDfVUpiaoGi0odiSOuH52h6b5T1s0yM69+kkxK2u+lu8i8tPxG4besSePNaYcfE87lFYd15hvHGl0rcrfet7+PYSmFJdGXl22PIFRvKj2pmrYP5tAvixXq9oOBgp2sOj2Feulx8aS5/qoDRYoxsR/ZSRqcU7qlL9+whz7mEz09U9Al85UgaHLZ2095l7cjN5T43NUDsjgG1BSdWUIQvqmgxttuwDSdBDWK9tvmHY+8RHjqkDdhObZW4/aoRe7oFZT6vzSgQYwM2EwT1Uek4ShIOX6JE4TuTWs5sEeJE/H41WFnvYPErKZCzu4NyMEmjjhRZDvFQxFSU2Y4Dz1jvjtIKDfacrFcu1CybdlrpPsasmAYWYitfaFfnpR0XH+PIYd6TwkKomZ2zPIckk0ktrU0lSBa8dnoLgFtpKvNnOkXhmonIUdE2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v1FW2dkPRqBMTdywrPxXJrTml74+YgJ6kSW40FkVDPhR/m176feK6MBDySM019acodfyyCu3ioLf7nq9SWFe6kovRB7NkwCX90hM1S8qdNPkLsGkL8t7A9JFl4PFQT//YIx5Zr/F+ceTTCVlnVj2sOrRpqIOFLyGCeLU0/uDD6XsRBb170O4AoHdqu0ANshtsxfU+e6emSgZP5PX0XsUHVZ2iDAbCiQBZB9tWTVbKp3EsoDrZ/QXBFBk5Dbv2bWrMxihc94eoy7wue+A/VmhKkMHRtZKawCqYyeNQ7QBuIFVXp08MGdfZeDJYqEXehY3BPJoNnul+OUVp0qzvFzaQTr7chLOngPg0Cfef4qMJ6vRfEhCgFKxdIEhRvZDnjLHKn0UKfjLWcAgchro+FryIVWvPknDdbqCrJgHFeryKptXUXB7LNgdPBHs3mzox07x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:52:27.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5cfef8-f3c7-43b1-e4f1-08ded69e0f32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22592-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DDE06E40D1

Hi,

Since per-channel stats were converted to be allocated and published
lazily at first channel open in commit fa691d0c9c08 ("net/mlx5e:
Allocate per-channel stats dynamically at first usage"),
priv->channel_stats[] and priv->stats_nch are filled in
incrementally during interface bring-up. This opened a window in
which the various stats readers - most of them reachable from
userspace via netlink/netdev stats queries - can race with
mlx5e_open_channel() on another CPU and observe partially
initialized state. The HV VHCA stats agent, which is created
before the channels are opened, hits related problems of its own.

This series by Feng fixes the resulting crashes.

Regards,
Tariq

V4:
- Patch 1/3: also clear priv->stats_agent.{agent,buf} to NULL in
  mlx5e_hv_vhca_stats_destroy() after freeing them. Making the
  allocation non-zero in V3 made the kvzalloc() failure path in
  mlx5e_hv_vhca_stats_create() reachable for the first time; without
  the NULL assignments a failed create followed by destroy would
  double-free stale pointers from a previous cycle.
  (Caught by Simon Horman.)

V3:
https://lore.kernel.org/all/20260622083646.593220-1-tariqt@nvidia.com/

V2:
https://lore.kernel.org/all/20260617140127.573117-1-tariqt@nvidia.com/

Feng Liu (3):
  net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
  net/mlx5e: Fix HV VHCA stats agent registration race
  net/mlx5e: Fix publication race for priv->channel_stats[]

 drivers/net/ethernet/mellanox/mlx5/core/en.h  | 12 ++++++
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     | 37 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++---
 .../ethernet/mellanox/mlx5/core/en_stats.c    |  9 +++--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |  3 +-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.c |  8 +++-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.h |  6 ++-
 7 files changed, 62 insertions(+), 27 deletions(-)


base-commit: dbf803bc4a8b0522c9a12560c20905a5952d1cb9
-- 
2.44.0


