Return-Path: <linux-rdma+bounces-22167-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LCDHKZrwK2qSIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22167-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:42:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149BE679095
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:42:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lwbBVcQj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22167-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22167-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C2693168DA1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38D3D902C;
	Fri, 12 Jun 2026 11:40:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6138644D;
	Fri, 12 Jun 2026 11:40:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264451; cv=fail; b=Kad4txQeVXHc9sQ7ah+3Lgctejq0dAtH7P9mS/yuXPYdAOIBB6Gstgl/lxD5BudbFXErY9qCD6cQLRDug52DCjMGdDEmC6yev8ymUm3HT9cFKM6pgY0yTO/d4C64V2CQvJKmzswc8UGUp4MP85bm1yCR/KsBUJ1om8ZJdJkLhOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264451; c=relaxed/simple;
	bh=Z/4gpx6VstyCVW03PzpCd/BGXx5Vtn9OHt/ijK9Sf94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqUU2fanu9LFUcU340qXnzjMWbGXy1bF3d2WLqYgfhsF5hUeNzz7KDkph0h74jru/EADRW5cYg+krt1Tsz8hh4c94QpQZE1nxMwejRMA2pabGSP2hxnyW0zzQsQZwDr/NFyYcQLJEXtuwaHPtGZfGqbfMXS7JW0MQQbG6LxhAvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwbBVcQj; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgvuU4pMiL3Mu9x/dIqf5mWazI89E/OOrkcn50JOK+TMJtOfS5HP3Bs5BsWSt4h9EmPxZMDnM6UTwqEcOHS26i2k0UgNpdOD7qNY7doW6qno/EyYXLFO0ZnUmG9FI1B8DHzonQq7InfDnejtv5jT+rvrT8W0XKj/9ZKp6lyhApD1lJVjrBjjXoCOgbPP7NUPiVOjOCgZqv3I3SkSrMp4aOPXDx6WwUJjP6+06h5RqRM/WtJGW26pfVm3L+ENuqnZ00hFNOpZ6taawxCj97puPPvng3otIyn4qDbPFXBTJQvIzoOWkpGsz+hv2SW2IfB4sIWekNtL5MAAdXTWrh65xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oaAA6R29GttAJySUj33/K4yDMna8Qo2SfZ5+qAqXC0=;
 b=txQZKpOMbxBkFSXS6ET+w1jU8H1ubUDL25W49qpDDhd5gPY53PnOP/8wTXnshM3KRVuHU1qk1gaFGAb+v8OyqpP2Q9B8EC0RZnYscFyo2HZ7KesSweMslsFunyVLi/pZf7F12Yfaor+/533fJugjjoLMxjz5z5lFJrpeBtwv+upGUv6+Ghy3edYR/MdfIlopQmMkMYRXY4G3VlYu+saHHB1ocPn64LVS090WNXiBPKUlPT0OVduo6ddbrMLozGz5dcUxY2Hs+KTtqjgfaeExkrs4RLWnfSpGxwfUub36DdUHQBeE/51xUDtOzF2KR5l9hUuXZwf7n3Bif7nx8Sv19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oaAA6R29GttAJySUj33/K4yDMna8Qo2SfZ5+qAqXC0=;
 b=lwbBVcQjY/CJrKmnt/MNQqFeEt8gl+Xp0Kg0S/w8hSouZk+Untt5kutCTeK9rPGxZknpCXiDp/J1DYblLEILoukIKahoOJvZPgngi8wjlBjTEf+Oj2MWkVx90RDVoA0KFJ9/x4AIKiFSPw89ruU3ZFc3w/WnGsTBbVTEkTptyhR+2yNwLT1BFtieno2nv31EpIixNFeuscweC1qMNbMwEp5GZxdsdoSno2u1hLJVeoHT0kn0Fjpr0PT+MauO1PUY9UT9sh8SCgzht+A/IM5X3y3z5OQ4kBMgASjzcrnfInFcnYVmSx82F4CkPyjmK3BjEQEjK1jdnuxdDf8xoZ2lLA==
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:40:40 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::74) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Fri, 12
 Jun 2026 11:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 11:40:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 09/15] net/mlx5: LAG, store demux resources per master lag_func
Date: Fri, 12 Jun 2026 14:38:58 +0300
Message-ID: <20260612113904.537595-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d84c08f-6b14-4def-7599-08dec8776da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|3023799007|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	U44mOhvV6mdSyvCts5Iwr1tlI4UkhJZZcx049/XO/IEYgKuCFZaoWWsRXrJr2oHfdlVKjTk50+v3EH4a2MmORYbweJPe9ITQWKwuqxs2FrtYs3SIXKNZ3b6itFlD3y94ld1VK9EzhW8cosBcHCKurUEQoqR6JVzXipo0b6xWd6/BTZefv+yQb5Z+bAaX5sDtRNTz9PcXO4T0/GKP2bYj/oP1/JLtA0Jtn4jk+LohxMv+iqoB7tuqUi0jEgipFeXIRzw/61TRvB5kMShLMnfNXtih8Szk/y0E4b7B2kXqtuOVw6fRGvZpMUMKUW7xjMFZyPJ79i6hpedeTrcLYeQ/1zzn/DzRU4DCpiQyeMtCkMSdgMKZqqHWGzhRCB4TlMxRQSDmHy5ngEYpOlSid9NUR6m/RB465KcYRtyFwvG9GvctTh2buDqtoYfzlIBvtRtPnUG/O7QxTEaGESNc22Iv7xhXubwz34SaYocnrxvLbSyqlslt/ZsBaecbCe7/yl5fDWuiJQr6QwDRBDE39pxxgFuCn2/hnkeEfI2mCMWroKJ8hBtcgYxUCqQPFbxsYv9/vbi0DAPX1dk5AmH49tbVv9w7TNzqNjGmShM+ZaR4ZvhnhJgPqK95m95aSA0EJKJfKI7bptWk6i8wEQNJ8erPzoEu1KGtN8KjXtZLkn4p0rVGciDZjx7z+yPEuQmPdriz8eNdq7AZzqf51Eg8G+6b0CLeKgHPxloee9Zrr/wby9s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(3023799007)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cORjx6voMbH/grvaL3m/jhJSAJ2X5QPKm52K/EoNYmklyprTbmbt5jCfVBTtw67s6oT35pHWW81GLgDloXkKbzr6C7Ukbivr4iinzDiMqXsuSkGbZ32YHZiiL7J2FH28f04GpJaYj779a3H7u9dGHOEM96KJBeXvWOt0avMtC2URwt2fTas6q/Ld9j4yhsQN2cmaSQLPHPxoCJgD7uXOZRfoguvxxEF1u0Xv3pPfNFL0Sbt1ASwT3d3tjhmMrnKq36XXx3V+OlPP1aF+skbIxpUmPaEvp3KuBEQVKQSBt8cVqKRP5iHDKEZaHe18FIAVQlHy59z/0rvXgYt1SOlwLoRyXr5d75/64pC157AtdsrjeDO/RJjU52HbpiJ54JMGKOJuN4mUKYcBcwokpYbBBwJpZaBUdF54PNV1aFv3Eg9RNKBM4PHU7mtWAr8MFQz8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:39.7585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d84c08f-6b14-4def-7599-08dec8776da1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22167-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 149BE679095

From: Shay Drory <shayd@nvidia.com>

The lag demux resources (flow table, flow group, and rules xarray)
are stored on the shared ldev. With Socket Direct, multiple SD groups
each create their own demux FT/FG during their master's IB device
initialization. Since they all write to the same ldev fields, the
second group's init overwrites the first group's pointers, leaking
the first group's FT/FG.

During teardown, the cleanup uses the overwritten pointers, destroying
the wrong group's resources and leaving leaked flow tables in the LAG
namespace. These leaked tables can interfere with subsequently created
demux tables.

Move the demux resources from the shared ldev to per-master lag_func
instances. Each master device now owns its own independent demux
state. The rule_add and rule_del helpers look up the appropriate
master's lag_func via the existing filter/group infrastructure.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 95 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  7 +-
 2 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index dd3f18f85466..e23c1e81b98f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1590,7 +1590,7 @@ struct mlx5_devcom_comp_dev *mlx5_lag_get_devcom_comp(struct mlx5_lag *ldev)
 
 static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
 				     struct mlx5_flow_table_attr *ft_attr,
-				     struct mlx5_lag *ldev)
+				     struct lag_func *pf)
 {
 #ifdef CONFIG_MLX5_ESWITCH
 	struct mlx5_flow_namespace *ns;
@@ -1601,20 +1601,20 @@ static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
 	if (!ns)
 		return 0;
 
-	ldev->lag_demux_ft = mlx5_create_flow_table(ns, ft_attr);
-	if (IS_ERR(ldev->lag_demux_ft))
-		return PTR_ERR(ldev->lag_demux_ft);
+	pf->lag_demux_ft = mlx5_create_flow_table(ns, ft_attr);
+	if (IS_ERR(pf->lag_demux_ft))
+		return PTR_ERR(pf->lag_demux_ft);
 
 	fg = mlx5_esw_lag_demux_fg_create(dev->priv.eswitch,
-					  ldev->lag_demux_ft);
+					  pf->lag_demux_ft);
 	if (IS_ERR(fg)) {
 		err = PTR_ERR(fg);
-		mlx5_destroy_flow_table(ldev->lag_demux_ft);
-		ldev->lag_demux_ft = NULL;
+		mlx5_destroy_flow_table(pf->lag_demux_ft);
+		pf->lag_demux_ft = NULL;
 		return err;
 	}
 
-	ldev->lag_demux_fg = fg;
+	pf->lag_demux_fg = fg;
 	return 0;
 #else
 	return -EOPNOTSUPP;
@@ -1623,7 +1623,7 @@ static int mlx5_lag_demux_ft_fg_init(struct mlx5_core_dev *dev,
 
 static int mlx5_lag_demux_fw_init(struct mlx5_core_dev *dev,
 				  struct mlx5_flow_table_attr *ft_attr,
-				  struct mlx5_lag *ldev)
+				  struct lag_func *pf)
 {
 	struct mlx5_flow_namespace *ns;
 	int err;
@@ -1632,12 +1632,12 @@ static int mlx5_lag_demux_fw_init(struct mlx5_core_dev *dev,
 	if (!ns)
 		return 0;
 
-	ldev->lag_demux_fg = NULL;
+	pf->lag_demux_fg = NULL;
 	ft_attr->max_fte = 1;
-	ldev->lag_demux_ft = mlx5_create_lag_demux_flow_table(ns, ft_attr);
-	if (IS_ERR(ldev->lag_demux_ft)) {
-		err = PTR_ERR(ldev->lag_demux_ft);
-		ldev->lag_demux_ft = NULL;
+	pf->lag_demux_ft = mlx5_create_lag_demux_flow_table(ns, ft_attr);
+	if (IS_ERR(pf->lag_demux_ft)) {
+		err = PTR_ERR(pf->lag_demux_ft);
+		pf->lag_demux_ft = NULL;
 		return err;
 	}
 
@@ -1648,6 +1648,7 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 			struct mlx5_flow_table_attr *ft_attr)
 {
 	struct mlx5_lag *ldev;
+	struct lag_func *pf;
 
 	if (!ft_attr)
 		return -EINVAL;
@@ -1656,12 +1657,16 @@ int mlx5_lag_demux_init(struct mlx5_core_dev *dev,
 	if (!ldev)
 		return -ENODEV;
 
-	xa_init(&ldev->lag_demux_rules);
+	pf = mlx5_lag_pf_by_dev(ldev, dev);
+	if (!pf)
+		return -ENODEV;
+
+	xa_init(&pf->lag_demux_rules);
 
 	if (mlx5_get_sd(dev))
-		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, ldev);
+		return mlx5_lag_demux_ft_fg_init(dev, ft_attr, pf);
 
-	return mlx5_lag_demux_fw_init(dev, ft_attr, ldev);
+	return mlx5_lag_demux_fw_init(dev, ft_attr, pf);
 }
 EXPORT_SYMBOL(mlx5_lag_demux_init);
 
@@ -1670,40 +1675,63 @@ void mlx5_lag_demux_cleanup(struct mlx5_core_dev *dev)
 	struct mlx5_flow_handle *rule;
 	struct mlx5_lag *ldev;
 	unsigned long vport_num;
+	struct lag_func *pf;
 
 	ldev = mlx5_lag_dev(dev);
 	if (!ldev)
 		return;
 
-	xa_for_each(&ldev->lag_demux_rules, vport_num, rule)
+	pf = mlx5_lag_pf_by_dev(ldev, dev);
+	if (!pf)
+		return;
+
+	xa_for_each(&pf->lag_demux_rules, vport_num, rule)
 		mlx5_del_flow_rules(rule);
-	xa_destroy(&ldev->lag_demux_rules);
+	xa_destroy(&pf->lag_demux_rules);
 
-	if (ldev->lag_demux_fg)
-		mlx5_destroy_flow_group(ldev->lag_demux_fg);
-	if (ldev->lag_demux_ft)
-		mlx5_destroy_flow_table(ldev->lag_demux_ft);
-	ldev->lag_demux_fg = NULL;
-	ldev->lag_demux_ft = NULL;
+	if (pf->lag_demux_fg)
+		mlx5_destroy_flow_group(pf->lag_demux_fg);
+	if (pf->lag_demux_ft)
+		mlx5_destroy_flow_table(pf->lag_demux_ft);
+	pf->lag_demux_fg = NULL;
+	pf->lag_demux_ft = NULL;
 }
 EXPORT_SYMBOL(mlx5_lag_demux_cleanup);
 
+static struct lag_func *mlx5_lag_dev_get_master_pf(struct mlx5_lag *ldev,
+						   struct mlx5_core_dev *dev)
+{
+	u32 filter = mlx5_lag_get_filter(ldev, dev);
+	int idx;
+
+	idx = mlx5_lag_get_dev_index_by_seq_filter(ldev, MLX5_LAG_P1, filter);
+	if (idx < 0)
+		return NULL;
+
+	return mlx5_lag_pf(ldev, idx);
+}
+
 int mlx5_lag_demux_rule_add(struct mlx5_core_dev *vport_dev, u16 vport_num,
 			    int index)
 {
 	struct mlx5_flow_handle *rule;
+	struct lag_func *master;
 	struct mlx5_lag *ldev;
 	int err;
 
 	ldev = mlx5_lag_dev(vport_dev);
-	if (!ldev || !ldev->lag_demux_fg)
+	if (!ldev)
 		return 0;
 
-	if (xa_load(&ldev->lag_demux_rules, index))
+	master = mlx5_lag_dev_get_master_pf(ldev, vport_dev);
+	if (!master || !master->lag_demux_fg)
+		return 0;
+
+	if (xa_load(&master->lag_demux_rules, index))
 		return 0;
 
 	rule = mlx5_esw_lag_demux_rule_create(vport_dev->priv.eswitch,
-					      vport_num, ldev->lag_demux_ft);
+					      vport_num, master->lag_demux_ft);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		mlx5_core_warn(vport_dev,
@@ -1712,7 +1740,7 @@ int mlx5_lag_demux_rule_add(struct mlx5_core_dev *vport_dev, u16 vport_num,
 		return err;
 	}
 
-	err = xa_err(xa_store(&ldev->lag_demux_rules, index, rule,
+	err = xa_err(xa_store(&master->lag_demux_rules, index, rule,
 			      GFP_KERNEL));
 	if (err) {
 		mlx5_del_flow_rules(rule);
@@ -1728,13 +1756,18 @@ EXPORT_SYMBOL(mlx5_lag_demux_rule_add);
 void mlx5_lag_demux_rule_del(struct mlx5_core_dev *dev, int index)
 {
 	struct mlx5_flow_handle *rule;
+	struct lag_func *master_pf;
 	struct mlx5_lag *ldev;
 
 	ldev = mlx5_lag_dev(dev);
-	if (!ldev || !ldev->lag_demux_fg)
+	if (!ldev)
+		return;
+
+	master_pf = mlx5_lag_dev_get_master_pf(ldev, dev);
+	if (!master_pf || !master_pf->lag_demux_fg)
 		return;
 
-	rule = xa_erase(&ldev->lag_demux_rules, index);
+	rule = xa_erase(&master_pf->lag_demux_rules, index);
 	if (rule)
 		mlx5_del_flow_rules(rule);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 0296f752bb4c..d645c2cfca4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -59,6 +59,10 @@ struct lag_func {
 	struct mlx5_nb port_change_nb;
 	u32 group_id;        /* SD group ID, 0 = not SD */
 	bool sd_fdb_active;  /* set on all SD group members */
+	/* Lag demux resources - only populated on master devices */
+	struct mlx5_flow_table   *lag_demux_ft;
+	struct mlx5_flow_group   *lag_demux_fg;
+	struct xarray		  lag_demux_rules;
 };
 
 /* Used for collection of netdev event info. */
@@ -95,9 +99,6 @@ struct mlx5_lag {
 	/* Protect lag fields/state changes */
 	struct mutex		  lock;
 	struct lag_mpesw	  lag_mpesw;
-	struct mlx5_flow_table   *lag_demux_ft;
-	struct mlx5_flow_group   *lag_demux_fg;
-	struct xarray		  lag_demux_rules;
 };
 
 static inline struct mlx5_lag *
-- 
2.44.0


