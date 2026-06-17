Return-Path: <linux-rdma+bounces-22320-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BJRNKWSqMmqy3QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22320-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:08:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0CE69A6BF
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 16:08:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ave7kaGy;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22320-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22320-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 812363213401
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549D641C307;
	Wed, 17 Jun 2026 14:02:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B482F261C;
	Wed, 17 Jun 2026 14:02:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704975; cv=fail; b=q+/giXeXOJjwSxdtVqZ/+84qixbMO0WRA9xDvxVwSc2Mp3stPt7OfihTqFDr3L/M5ZVnFMLLoFTfzoyHECQS+v6hG+ftaQeuOL/sceINSd/1HvgEIyhXyy9zN3Dw9ihzNyinpoEBjFzgkE/HEJ9mc7FelGVPeqKx231WR7qJgn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704975; c=relaxed/simple;
	bh=h2YbnTwCSMRwCEOw4FVCV2Jl8G3ZHv/2C+dpOwLcPoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKYLP9EtyuN1mlBR6cYgfptZWUHOpG/kqgSMgNPyEOdKnWObysCNvmPCrneuBxJ0bbjNvl8Es4DM63Brp4MC2ZogofByyEwW2x9gO+tbrIwq4KEzjJX1VEedROxeKtTqDBLSIbszW9zdr4aehaNZFBqxlDJOtRT3u1o/fncQT5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ave7kaGy; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3n3AJi9AFJ1PcPoNwqCLm3Yyh2M6SjIp/Mb/Kz//vWR4oesI58y+GBOE5o20jUBtmoJicol4qurozvNjXu8fWt0NwPhIt+BlL60gTbEAIB4IdIfYjbuGOCtBcZWYzYEDemOPqtUVzFk0tEDocu0gKwOSGNJ00eR9nj8Q5x6kkywqJEYY/HdNZp9AXvAIYAiHUwtaPRKrD9Tz+olPhRU6EZFNWUYzJyCEu2k5On6nuX074QqTtaxa6WGMVjaNv4q7N38Dyzo65WUmS8wkqYDQx196qj3R2C7FhwdPicUHGaQ45NIT745D4BypxVY6vbB0gEDM6p6yVbGUrZ3Hafz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h7CnTer5Cz8w4ZaO/cP7Blvom/GGhM1+O1NSlanwog=;
 b=qRa/iyxx0gqCZyEgtjCSTvU5ktXshpxQUnsdS48qTODoZeLfCzzuG5KWGlZGFMvblJyHnom1BjwQcy5HdzXsiUq/XDS1af8HwSvao50WBTQH92kfVke6b0Xt4E2IqXjFHdFQkwV66TMdHPFb/oeg7nWPLobUOF3AHg8w/FpHl3OaXLrwk3N5W8pWS+Nqm7zyK+rZG0u9UrhL/e5E+Kxasz6uywniIod+dAFVKr4Rsc78sfJLDfrBfuLNmnXoOUMOmxUn0Uw5Ce/i7iIjqe4MJfGDyziBWeCNo3kfTLq9ZX33Zc38XXSV2+er39Lo4C4iwrslyUVK2OoZX+MZzO35bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h7CnTer5Cz8w4ZaO/cP7Blvom/GGhM1+O1NSlanwog=;
 b=ave7kaGyBt/a249wnXMu0LCIdREaBAfSMTQgbLNvkrR1UnhGK7h3EsUaamXXaZpz+R2NlyT2PvW2BMXTizOxUWdPO7T7CedrgGIl/Cw94ztX4ZtpbrT3/SH124oy6A2kJJDlM3XVzPcVgq+aN2OYV9xNkg62Okod3hr0oMNaMcsnGRJWMx7/tCBosvAxQ96iJUtBbZAnWz2XFR1hD90KAcrtyvK5qPU2ask1Kl7mSr7yconQyHo7rhRve1BxKi4p7saz22eTmwXPOCGsMNFkY72dmpdcVMzJUNUfjAEfQAU0cjEsarMNXJYiOgnOXkHRR1F24I1rpuZbWFzz9hklgg==
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:02:42 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::46) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 14:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 14:02:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:02:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 17
 Jun 2026 07:02:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Eran Ben Elisha <eranbe@nvidia.com>,
	Feng Liu <feliu@nvidia.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Lama
 Kayal" <lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 3/3] net/mlx5e: Fix publication race for priv->channel_stats[]
Date: Wed, 17 Jun 2026 17:01:27 +0300
Message-ID: <20260617140127.573117-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260617140127.573117-1-tariqt@nvidia.com>
References: <20260617140127.573117-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|IA0PPF0A63E7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a8f2d5-ff30-4cfe-4e6d-08decc791958
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6krYoZhC89AkSovCt8H2WeO3N8Wxg1PAqoWkJWLj8Bn5f/4nlTi1nruy4ONgNghUZjUxte38LS+yiUs2/7DDc32336jKJuY3INjJ354zKceqvfpT5rPprFHF45bpOP5Z68x8CCLsA/x8uUA112KViofpkYIf11R2V2byadiz0sx1+ygsnZdTsdbF8QGPGHv6SJo0YJS44UmWuP3lwktQEXwFtvRiQdEpd6TYus+RrsNkrffLS+YI1KuDMbtUpV3rJzWYgLhDfOcc2VP6DL2pcSH2qwLqP4DU62WaRXV4Abr5FToE/qKzBgLp9+/o9pSXKUTQOgWEFz0STLWH/V2oyoAb8gTJ6i/krcDPqWsQG4rRrTauucUn2vz6h29oshRjzy9cHJFNgIRgLj/07CZl5y5vjJNlIRmSbCC/A/Q8Gyd417fHqHnUctPYXqcxktgOW5Y1g/0vru6/vnXUYVGpsLCIFMxF+f8+o/T7bcifLryi5s6tXrmIp1aWMzeSAmT7EXlaSLX2rOS2fVWVb4dWLH3kk0/Tq7YlSoe6XBIEiU951OlS/x42yyyPvC0MrayvAmwFwJAqRjXWd0NZh4pLhH+CJqsrRmwb4G3ViSa4H6eYelFAMQPh+vn1oKdaZY/5cqYVSDgxhpLSLjzZ8N9hKiyXwDLkg9MK7Lj22mFH86zlpgTtu1gPdxE3mrCd447kRH2Chm/MsVPmvuuo9wwzoYlzVVumxARC/SdgII1XjTI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b1xv4lQDqHuWy6Ztr9EZaMnC5P8TOaE6WC90JntAya93inzy2ZTKWbbg2Qu6STkmaWYA/BcwNNn2eYuQ/J0OnQLRpG73xrORgB23qKQaoOYsgp638gAeqbEMuYwzw6wH+xXA9GoYa83xRLfxRW4mmlOUptaL0GeW7OiRH2W4l6Kqj10TpdUhahIoTtRg1q/hB8xwi8fhbu4k/7odfOUK1B9C03ge2Ek122tZbtQViW86Y/aUoBEtR1DzJkTC2JeykHvDibQKsrMHEe1wypyF+sHcl57DEgZXecL6FT3dYOzTilZJujwCHHrFBK2iPyBHp4tMVejTMa1w6jRMUKADcu+aQ6kRW/1GNpQ3SQkM/+MCRtYO/L1bBa3QZUyE+TzjEiXiKX8EJYcNMMqWh71qJreBjcWh9GEo6abBVHws5aHetqrYcb8lNyx+ODtyAl8B
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:02:42.0201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a8f2d5-ff30-4cfe-4e6d-08decc791958
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22320-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:cratiu@nvidia.com,m:eranbe@nvidia.com,m:feliu@nvidia.com,m:haiyangz@microsoft.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:noren@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D0CE69A6BF

From: Feng Liu <feliu@nvidia.com>

mlx5e_channel_stats_alloc() publishes a new entry to
priv->channel_stats[] and then increments priv->stats_nch as a
publication token, but neither store carries any memory barrier:

	priv->channel_stats[ix] = kvzalloc_node(...);
	if (!priv->channel_stats[ix])
		return -ENOMEM;
	priv->stats_nch++;

Concurrent readers compute the loop bound from priv->stats_nch and
then dereference priv->channel_stats[i] using plain accesses, e.g.

	for (i = 0; i < priv->stats_nch; i++) {
		struct mlx5e_channel_stats *cs = priv->channel_stats[i];
		... cs->rq.packets ...
	}

On weakly-ordered architectures (ARM, PowerPC, RISC-V) the writes to
channel_stats[ix] and stats_nch may become visible to other CPUs out
of program order. A reader can observe stats_nch == N while still
seeing channel_stats[N-1] == NULL, leading to a NULL pointer
dereference in the channel_stats loop.

This has been observed in production on BlueField-3 DPUs (arm64),
where ovs-vswitchd queries netdev statistics over netlink during NIC
bringup, racing mlx5e_open_channel() -> mlx5e_channel_stats_alloc()
on another CPU:

  Unable to handle kernel NULL pointer dereference at virtual address 0x840
  Hardware name: BlueField-3 DPU
  pc : mlx5e_fold_sw_stats64+0x30/0x180 [mlx5_core]
  Call trace:
   mlx5e_fold_sw_stats64+0x30/0x180 [mlx5_core]
   dev_get_stats+0x50/0xc0
   ovs_vport_get_stats+0x38/0xac [openvswitch]
   ovs_vport_cmd_fill_info+0x194/0x290 [openvswitch]
   ovs_vport_cmd_get+0xbc/0x10c [openvswitch]
   genl_family_rcv_msg_doit+0xd0/0x160
   genl_rcv_msg+0xec/0x1f0
   netlink_rcv_skb+0x64/0x130
   genl_rcv+0x40/0x60
   netlink_unicast+0x2fc/0x370
   netlink_sendmsg+0x1dc/0x454
   ...
   __arm64_sys_sendmsg+0x2c/0x40

Add mlx5e_stats_nch_write() and mlx5e_stats_nch_read() helpers in en.h
that wrap the smp_store_release()/smp_load_acquire() pair on stats_nch.
The release/acquire pair establishes the contract:

  stats_nch == N  =>  channel_stats[0..N-1] are visible and non-NULL.

Publish the stats_nch increment via mlx5e_stats_nch_write() in the
writer (mlx5e_channel_stats_alloc()), and read stats_nch via
mlx5e_stats_nch_read() in all readers: mlx5e RX/TX queue stats,
mlx5e_get_base_stats(), ethtool channels stats, IPoIB stats, the
sw_stats fold and the HV VHCA stats agent.

Fixes: fa691d0c9c08 ("net/mlx5e: Allocate per-channel stats dynamically at first usage")
Signed-off-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h       | 12 ++++++++++++
 .../ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c | 10 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 14 ++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  9 +++++----
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  3 ++-
 5 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2270e2e550dd..d507289096c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -987,6 +987,18 @@ struct mlx5e_priv {
 	struct ethtool_fec_hist_range *fec_ranges;
 };
 
+static inline u16 mlx5e_stats_nch_read(const struct mlx5e_priv *priv)
+{
+	/* Pairs with smp_store_release in mlx5e_stats_nch_write(). */
+	return smp_load_acquire(&priv->stats_nch);
+}
+
+static inline void mlx5e_stats_nch_write(struct mlx5e_priv *priv, u16 n)
+{
+	/* Pairs with smp_load_acquire in mlx5e_stats_nch_read(). */
+	smp_store_release(&priv->stats_nch, n);
+}
+
 struct mlx5e_dev {
 	struct net_device *netdev;
 	struct devlink_port dl_port;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index 2e495442a547..9747d7736d37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -33,9 +33,10 @@ mlx5e_hv_vhca_fill_ring_stats(struct mlx5e_priv *priv, int ch,
 static void mlx5e_hv_vhca_fill_stats(struct mlx5e_priv *priv, void *data,
 				     int buf_len)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int ch, i = 0;
 
-	for (ch = 0; ch < priv->stats_nch; ch++) {
+	for (ch = 0; ch < nch; ch++) {
 		void *buf = data + i;
 
 		if (WARN_ON_ONCE(buf +
@@ -50,8 +51,9 @@ static void mlx5e_hv_vhca_fill_stats(struct mlx5e_priv *priv, void *data,
 
 static int mlx5e_hv_vhca_stats_buf_size(struct mlx5e_priv *priv)
 {
-	return (sizeof(struct mlx5e_hv_vhca_per_ring_stats) *
-		priv->stats_nch);
+	u16 nch = mlx5e_stats_nch_read(priv);
+
+	return sizeof(struct mlx5e_hv_vhca_per_ring_stats) * nch;
 }
 
 static int mlx5e_hv_vhca_stats_buf_max_size(struct mlx5e_priv *priv)
@@ -106,7 +108,7 @@ static void mlx5e_hv_vhca_stats_control(struct mlx5_hv_vhca_agent *agent,
 	sagent = &priv->stats_agent;
 
 	block->version = MLX5_HV_VHCA_STATS_VERSION;
-	block->rings   = priv->stats_nch;
+	block->rings   = mlx5e_stats_nch_read(priv);
 
 	if (!block->command) {
 		cancel_delayed_work_sync(&priv->stats_agent.work);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 8f2b3abe0092..94e5352a246c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2773,7 +2773,7 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 						GFP_KERNEL, cpu_to_node(cpu));
 	if (!priv->channel_stats[ix])
 		return -ENOMEM;
-	priv->stats_nch++;
+	mlx5e_stats_nch_write(priv, priv->stats_nch + 1);
 
 	return 0;
 }
@@ -4043,9 +4043,10 @@ static int mlx5e_setup_tc(struct net_device *dev, enum tc_setup_type type,
 
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int i;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
 		struct mlx5e_rq_stats *xskrq_stats = &channel_stats->xskrq;
 		struct mlx5e_rq_stats *rq_stats = &channel_stats->rq;
@@ -5489,7 +5490,7 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	struct mlx5e_rq_stats *xskrq_stats;
 	struct mlx5e_rq_stats *rq_stats;
 
-	if (mlx5e_is_uplink_rep(priv) || !priv->stats_nch)
+	if (mlx5e_is_uplink_rep(priv) || !mlx5e_stats_nch_read(priv))
 		return;
 
 	channel_stats = priv->channel_stats[i];
@@ -5508,7 +5509,7 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5e_sq_stats *sq_stats;
 
-	if (!priv->stats_nch)
+	if (!mlx5e_stats_nch_read(priv))
 		return;
 
 	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
@@ -5525,6 +5526,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 				 struct netdev_queue_stats_tx *tx)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
+	u16 nch = mlx5e_stats_nch_read(priv);
 	struct mlx5e_ptp *ptp_channel;
 	int i, tc;
 
@@ -5533,7 +5535,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->bytes = 0;
 		rx->alloc_fail = 0;
 
-		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
+		for (i = priv->channels.params.num_channels; i < nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
 
 			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
@@ -5558,7 +5560,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->packets = 0;
 	tx->bytes = 0;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
 
 		/* handle two cases:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 1a3ecf073913..8632b73179cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -516,6 +516,7 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 {
 	struct mlx5e_sw_stats *s = &priv->stats.sw;
+	u16 nch = mlx5e_stats_nch_read(priv);
 	int i;
 
 	memset(s, 0, sizeof(*s));
@@ -523,7 +524,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 	for (i = 0; i < priv->channels.num; i++) /* for active channels only */
 		mlx5e_stats_update_stats_rq_page_pool(priv->channels.c[i]);
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats =
 			priv->channel_stats[i];
 
@@ -2615,7 +2616,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(ptp) { return; }
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 {
-	int max_nch = priv->stats_nch;
+	int max_nch = mlx5e_stats_nch_read(priv);
 
 	return (NUM_RQ_STATS * max_nch) +
 	       (NUM_CH_STATS * max_nch) +
@@ -2628,8 +2629,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(channels)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 {
+	int max_nch = mlx5e_stats_nch_read(priv);
 	bool is_xsk = priv->xsk.ever_used;
-	int max_nch = priv->stats_nch;
 	int i, j, tc;
 
 	for (i = 0; i < max_nch; i++)
@@ -2661,8 +2662,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(channels)
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(channels)
 {
+	int max_nch = mlx5e_stats_nch_read(priv);
 	bool is_xsk = priv->xsk.ever_used;
-	int max_nch = priv->stats_nch;
 	int i, j, tc;
 
 	for (i = 0; i < max_nch; i++)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 0a6003fe60e9..674bed721e63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -135,10 +135,11 @@ void mlx5i_cleanup(struct mlx5e_priv *priv)
 
 static void mlx5i_grp_sw_update_stats(struct mlx5e_priv *priv)
 {
+	u16 nch = mlx5e_stats_nch_read(priv);
 	struct rtnl_link_stats64 s = {};
 	int i, j;
 
-	for (i = 0; i < priv->stats_nch; i++) {
+	for (i = 0; i < nch; i++) {
 		struct mlx5e_channel_stats *channel_stats;
 		struct mlx5e_rq_stats *rq_stats;
 
-- 
2.44.0


