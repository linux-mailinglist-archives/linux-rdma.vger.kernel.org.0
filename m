Return-Path: <linux-rdma+bounces-22406-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WX51CWD0OGozkgcAu9opvQ
	(envelope-from <linux-rdma+bounces-22406-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:37:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF76ADCC8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 10:37:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UE9YDEmP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22406-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22406-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 555D7300A4B1
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDAE39182F;
	Mon, 22 Jun 2026 08:37:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36E3911A2;
	Mon, 22 Jun 2026 08:37:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117469; cv=fail; b=m+6U20Ptk1eeOaa5Gd1gZ4wwHiFMCokjfEp7mfADz8AbH2Nbv06JXHdGAAoxBz5V0+qLrCyxX1f3wtHbLtmT4nUqeS07xxj+VMXe6oaYdTTN6eSsi2G9ghbaQ4YmWhcYxaqygdrA5cx9r9roadQdwlBM5hbVliNMUgU4LjGHUoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117469; c=relaxed/simple;
	bh=JfH7eC2xir5DBHqDXIG+9CPUaPIG27tBCjW+tcXmhWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeR7K8OrR42TuyCHGm/ePE1XwJzJRxHQFC0dvepS/v+ck+d4sUu05tyIOPTNHyXOhzX/D/kXnHpwjllcTrgEN0s6pf7S07X4jYFbVnUMio7MfUqgN3S9bvKk5I2318svNcOmQvLXp2C+yjTD4aiyHtvFYXRb1SSZ1F/7341Pszw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UE9YDEmP; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGgb78LYE5oouQC18XWacz+qtt7m0jhlRDzgbnPf/+i33ib2/zMh0zXa94wmyzbSOq4uvHCn4CSlYQajvFjgED+NiZjROw6XOBBAOC1t2mFn7h7QpceolM2BfEmC+v3FWsjLyKwwyJGsSj/MKvSxkgGMZRG61Jc9VI9SWsZLSa/Rte+HfG+xj0/1t+KKeo0VoI2f9667oLhqZyE3jIM19k2hF8oMbD27I9sVxl5c2obibIiKhi/XzfZKu9yAxB1heY0aYgqGrtRyuIbezAGGaYKPQhzg9soQ3kUwQcXpwusP/KG7AlwzHnDJqqk48tV8tbk+FVJ4CZRzgCGKcn+qvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PITvRE9bCzSQhcb5Q+awJpCDPK9jgj5CL5MlHF/hwRs=;
 b=k8SWZiUsUSQDIX8RQQFg9B8tL49iAi7OrGinhd0EsXXn16V1nw5Ldd9cPVumfwddA2O4UmzetDTSm7N3f0L++KF8Wm4Am/yLqn/1w8BtC/0GGqPMYGAV0BkhBT9fFPmEWDlN1ai0eKrvbTvOk+7gCJe4nQowzvDvt15zxe4MWjfthzPGQd/4KRiObIqRCobLWzN32xruARo9x0JlJqnjCBUguVoOfPVqi5Bo9zr7vfL6YYHMvCo0Hko7Gij7pdwJ2Pdhu6nrL5kVw4MYKabNn59/ucAL64V6k7P/hMPQSWf/oQotOVP86Lt7Vmiqqgo9qEzC8fGudsV1yVfjZe4FYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PITvRE9bCzSQhcb5Q+awJpCDPK9jgj5CL5MlHF/hwRs=;
 b=UE9YDEmP78K65oJCMKrZjJVelUaYOFq9hxrIidkResQTPP0eYdFLDf/+Xh3ZeDcqjj3cqJboRdC22vWXtDPwaFX2Efp8ApB+p2lhQx4hS4BgqrvMX3qhlN9EXuYUH2kPR86TcWQxlBpU6FwQ7ipOhyZR/D4cSlt4KTudS+jpAeNA8WF0rWJall3LfF3IjSfkvnwSFpEkTaJx+YcH27dLV80bNeWDBHsEJLsIY0/QTRn8Q1Z5YJeARcgwF+Z+YD9ulc9mFYd8LbgmTnY4ogFQlzXWarmpmb9lmki/Vj9RYZvEETIte+DMDIvVjCt8JCWfEMBH0Mkp8sd60NJSIVJ/3Q==
Received: from BYAPR21CA0020.namprd21.prod.outlook.com (2603:10b6:a03:114::30)
 by DSVPR12MB999192.namprd12.prod.outlook.com (2603:10b6:8:496::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 22 Jun
 2026 08:37:44 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::7) by BYAPR21CA0020.outlook.office365.com
 (2603:10b6:a03:114::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.3 via Frontend Transport; Mon, 22
 Jun 2026 08:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:37:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:30 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 01:37:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 22
 Jun 2026 01:37:23 -0700
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
Subject: [PATCH net V3 1/3] net/mlx5e: Fix HV VHCA stats zero-sized buffer allocation
Date: Mon, 22 Jun 2026 11:36:43 +0300
Message-ID: <20260622083646.593220-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260622083646.593220-1-tariqt@nvidia.com>
References: <20260622083646.593220-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DSVPR12MB999192:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c91df4-70d9-4532-9850-08ded03987c4
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|82310400026|36860700016|376014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	knBb1Vw4vLz6fjT6bKU29fRnr6d7S+tZgkYKpsVpf/Oi5oilFV8ViJj4B77soknXZ1XhEfNx1dU2FeKMkc4khqX3YNGmeE4AnB597agBXc7YbG3iiAFA/Sn8t1f7r1CeRUv36XviuUNb/SxsyRpHYyGPmWE/uY78oRHTSiW0OhCmpHnCBuPT45WAhGeJTIdEPyTlVFOeuJeOl6+8XdKnX6V46ZdtiFcvzkzukXfTpuBJcv448qcNz3MnCm+Osg3OWHlgb9gpxZCjwAzMmXeYz0Ws/KbPRB8dudHfceG+maPcs9NKLCTRhJ0PzXXO4X8K9pdhPBPzG9M9nZAcjpNpJilFZ+vXu1Dw8zM7e8KnBtkAisYbvSLlGFX8q9MM4ITrR6xjtgUOw9e7q9PEjC8ACXdp2hhjbAO2r2nvPaoc3iayxDiqbpxWQA34EbkxZWi2lH0rqku03POf2gRbRlGuWdd/3dS+pi7yHApA9Yfo/SgjqPAIVz0ufF0ZE6wN4yJPc75WyZVYaKo1sNqvOw9vdqLXTfbHCLBUcvoKmA7FMUjkgGVTjyCBuLKQiSYsMd1/6peHdr8mCEJ1HiGKen6brc+mc3T8k+h67rPR63lvfi5PurjhH6dIzmRxwtSjU/S3k4b8UnoHYT0IyjnCqhe2nXcrDbkRWjw20DpCi1cUe9mDQ27KZsy1JsBJ2bwH4/ZExeNBoHkHCuFmXkqBjy9CIw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(376014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gu1OwCegq0AYVU8jkERDQh67sDXYJwcdeSbRXRhluYE7dSkR5UrXhQvzwRVSghE1H7omK7KN1K+h/3TDPXUeySiuuWnjDI0orpdt0Fnsuol1capabX4iqcfMWgGTMxsuCsvee3ysDLa3cp1cxF1O5vOA3AAG2tF77FDSBzqEIasyCmo/K1GDpMyqxN7uxYQT+7HfQmrzljJUFjtjiTbqO63xmHGF3FBNFySs9dLqbMTMDzuDunRU5VOQdm+CiXlx3mfQaVhwyqlCyLUxEC+ZUjhyQbaj9D5fPi4yIhFEFQcj63Mry0sv8mnbHY7QigYCP/lcqNbF/gQpxhXTm4oeT66xyTzAG9EslTXvS69AsGZCGaYJjSkKfrrtiCuZXV6qna1/VZPWvZdn8mwNMJP89AdpGqquZn5CX9CUnudFNTpFZT520egvEV7YDff4pf6H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:37:44.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c91df4-70d9-4532-9850-08ded03987c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999192
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22406-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCFF76ADCC8

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

This mirrors the existing mlx5e pattern of preallocating arrays of
size max_nch (e.g. priv->channel_stats) and lazily populating
entries up to stats_nch on demand.

Fixes: fa691d0c9c08 ("net/mlx5e: Allocate per-channel stats dynamically at first usage")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c    | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index 195863b2c013..06cbd49d4e98 100644
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
-- 
2.44.0


