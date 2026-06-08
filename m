Return-Path: <linux-rdma+bounces-21970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KKMBMu3LJmrXkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:04:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D3656E81
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PorufVXY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21970-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21970-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 559D93050DF9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE103CFF5C;
	Mon,  8 Jun 2026 13:58:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532A3C4B78;
	Mon,  8 Jun 2026 13:58:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927094; cv=fail; b=VQIr1gEMYTjkNIYL5lsBGeP3Xp/eIvz9hGmyPqq29JwMTSzibbpO3+kjEbpHO2CrqUYHxqneDMBrSC37OfRnV546qxIFDoRNTlCiHyatR3javeV/fljWreMetg5Rkw/VOhzetRtz18TrJgj+022Vlota6+dnbgVHCORscB3DJc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927094; c=relaxed/simple;
	bh=GAY2NVhuMjHg85rTH3Zb6+oE3zluy+H6QnhBlBejLak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDng06HB3DzHef7Td9PVSwCIleqh3sT9H/xJI9hj6h+WmEInAfzzM9AnxQ9p2Qgim9x2Guo1s+HJgHYsrZd/VV5Z/t9Me/HFval5FldfhnlXc7V5bbT1Xj5twtmeBWY1Gha7hbU+O62i0nCKEkJ5mJm3GzZqshiWJkm0i4mf9bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PorufVXY; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEfnERIKkjTSq4HPxp2Or7waZ/Tl1YDxwHPwKNbnp6y9YxunLgNoba41iv5DllilBrt4K09F9g5iVpXTTJ0Mul9RkNNlJatYGYYXPhTScTftZxO6fUmw+08ovzuinDL+qDc9GYUGH2tlbAhpuyl6U9IRdsXW2aUOx0eNN8EY9eJJ08sRNUtwuLhXrlPKrajfRSvnDow4+Yq41UpTdeoiHawR9FJOVeSLTKERKnbZACO7ke71yMnT5M0NFxf6+veFUPcXTJ2oHg7xaP8J8IH7yG4Q+Wy6DW4vPikYYqZO7Njx01SSNuS6Ml3bWPuDbBHhZX2ZRQGXTSq/BCC1bw+aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG7jsmfOSD4ey6cDdPClVPpcORihIp2UVzXoD+DWe3o=;
 b=AmnsMb3bzOTbYb/rsYq6Z2UtfEx8hsQH5wlp8e83ncWYpDPJqyIERUKd5KhZpJ0Ibdo4q3l0TF/SARRGiz/2AvFuDeHHW8lJO5YfDUXtY3KUuEDUEeV/OUXH2W1EWHnOsvRu3BZMHZI3jmx4n9uW4+fkh4JFnMBZ3WsFDBH7Vlpn/1Pl6eSCNE9oery/ZVJ2x8oWVEWl5fDY4Uond+UYTscS5UKBXnk+Fi/K6XSqqGaUJy0LA4q9v8hgMR+tiM2oxJhmIeNdNlQUtxMfzAU9HgSCG0CRoSVqc6YLYbzGTsDbwFP0dAm+M5IwpFcqwibuI3I7aRxIMTxSH1M2Zgbg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG7jsmfOSD4ey6cDdPClVPpcORihIp2UVzXoD+DWe3o=;
 b=PorufVXYUjBQTwemVHCcBMXZtTlasnXe2WRcl8HN/dXvtgT2aF/tDWPUPxSAN/vI8bzNsJQhWtNKd8fiWvC+N8w9rDsJelVegBPTTZ9FIBMpiFCPZPQtKs8J/aLNtcVcoKlyvRD7dh9KjPTZrq30iRqMIJKwThIsVD7SNbLLafLzNz7o95zsaoYeJ4jY/iYubYC0q9u64hEtPOLd1MBMhXN8TWZgomyR5jgkXzldl9iXB5rSJEkjUA+lReR+VVgxr2Ro0sCSGCU/7mlT2APwHHVCJR4kvW+iEM38VRc5befT1F3n1QzuazL759KMQ/g7zK6FhbG+Zh8FfCTt8+I62A==
Received: from BN9PR03CA0685.namprd03.prod.outlook.com (2603:10b6:408:10e::30)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:58:10 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::10) by BN9PR03CA0685.outlook.office365.com
 (2603:10b6:408:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:58:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:57:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:57:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:57:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 15/15] net/mlx5: SD, enable SD over ECPF and allow switchdev transition
Date: Mon, 8 Jun 2026 16:55:47 +0300
Message-ID: <20260608135547.482825-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: c613ff67-68de-4a74-dbc4-08dec565f984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FAlr/k4V3R1yNFI28DDNNI7jvq0xi7MuBhglYVgfUpbCjUPWaZXJUzYCbtXJFMl90r6c5FucvZfOiLse1bZHtm0L+Yt2+xGqkXjNTKH2lBcYtkDqb1yRetHSJIJbDwEw2ymIhSz6vZETbiOO5LeTeuDJywp2KWq7GPsetqG+iHVpmpjBaL86wt/ph1LIoIcCEAPWlWGOUoExEoJxR6Ql/7/dleqCAV1d2v3UnoaRhv7CEMsc4xdDpP13dCHfog8nJM5HtN1HQn8p9sQq4oi6mYzVlZDSStqbfrpkVZdcPSo5Mu0xzEwW4KKnwKgXb9DT7t3VDhOxtPGqwrWBgrjzE9yyotYFCU1lRu5HuyA+NGcnZPh5i1qUEKBBHypOQW6SvR4s3Wv/1xjm7MsGABcXdRjivwO8v3H6PePSaEgIhhbqcScFNHQiIKu4POc510yTq5hDSliNYekMeCIbivuzK01Np46ktZHIqxp0RNgga3vnLwy+dTBLPiANJWeQSqSsMByVgbwkuO/ObJJbQUXNkz8CUgAm2s4XMhmEoWx/maKCxwWRozZiQVEeAxxBUdXxP12hUuZzQ1pCxpLcjDporIVJL/3rnWN4TwF8IWaQP92zlpKjlQZPqpcSD5Md/PIMo2ydVGMfhsXnH/EQe7p47hWrfU21FHKnX6R47SPCF3dnEB7/eykKn7w6PKzX7+1r/Qrd3Y/tB71v7wsvBdtQactkOgnb7RsQKpnA1LIVVyE=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hNTK4IzHH4XNt/Vrruuqb/LRzAXoXEhrp5FadbjNe9ZRLuiL2SPd8Dd07DkPE92IufCwOyEAOD/JWnlwpw/HNVbIP++4CN4P60zV6cErMqW8cMPezATHHJ25zSqFsPcNAy0TZyfDWqg4aaoZhvtgUx/MVomoieXW2PkLI0YIVo6Fv37qD/J4WB3N+LNVabdhFEIfnf+b69FXj2tpOvVJLIOJrAtRMLecTSekdO3kAf+BITs617sDzwXe9iv4iAzsFIC/kUvwl4JNTMRJ2kFUg9X/FKBBrbeqPqChOlUUlUbH0KxxO7pD5+56Z45rRDLWZSN3cdQmuAUbLj3T0vWVHUAEBxo/oS478OzRu8SvhjsC5ptIz+xTXpcQAgFEFS7KSMbL8aRgCqC8C83jHIM0yH035StXfVyx7goaWs3SuCHdApx3Mzu3u6nfTmWrc8dF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:58:09.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c613ff67-68de-4a74-dbc4-08dec565f984
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21970-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F0D3656E81

From: Shay Drory <shayd@nvidia.com>

Remove the restriction blocking SD on embedded CPU PFs (ECPF), enabling
SD functionality on BlueField DPUs. Remove the blocker preventing SD
devices from transitioning to switchdev mode.

The infrastructure added in earlier patches properly handles this case.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    | 6 ------
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c          | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 9aec470fe126..cc791f2f63b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4451,12 +4451,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && mlx5_get_sd(esw->dev)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when multi-PF netdev (Socket Direct) is configured.");
-		return -EPERM;
-	}
-
 	/* Avoid try_lock, active/inactive mode change is not restricted */
 	if (mlx5_devlink_switchdev_active_mode_change(esw, mode))
 		return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index d74a5a2862cb..ec01aecf3370 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -222,10 +222,6 @@ bool mlx5_sd_is_supported(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_pf(dev))
 		return false;
 
-	/* Block on embedded CPU PFs */
-	if (mlx5_core_is_ecpf(dev))
-		return false;
-
 	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
 	if (err || !sd_group)
 		return false;
@@ -252,10 +248,6 @@ static int sd_init(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_pf(dev))
 		return 0;
 
-	/* Block on embedded CPU PFs */
-	if (mlx5_core_is_ecpf(dev))
-		return 0;
-
 	err = mlx5_query_nic_vport_sd_group(dev, &sd_group);
 	if (err)
 		return err;
-- 
2.44.0


