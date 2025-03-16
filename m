Return-Path: <linux-rdma+bounces-8728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92DA634A1
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258A4171887
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F819CC29;
	Sun, 16 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n3FCQWxy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEAE19C540;
	Sun, 16 Mar 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112901; cv=fail; b=tgzGvFVh9hB3Rx0e1B6Bt1lj0zcjVw/B0FePiXxcF6zMcC/2TcBqQea2M6tn4IQbAClF54OK9kzB3tHvXbJtUv+HvphEWcmekVwQ6p94osSctKpwCWJt/ogd3g53lHs6uIDCjNask8XO9QocpToUemVTtAVpnjUZv42U6OCvD+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112901; c=relaxed/simple;
	bh=7MBAGE3OuJMkP1YXeqHmFJ34qMeFUUlGkds/zuWE3SY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2OVFg1XUtfWMm7XLI+X/jw8jHQEdljmpaKQlGMyE9hkKm3yXSJrpnOZoeJJ2j1pMBcZ3PWiO9Rthkns+2QAqYjTjM5bALwaRpPNhEunnqxnrsz9W2LGIaO7FQsVrsojh9CIfQOj+w3Z2ZD68GMpeuhpxdCu4DVaDULr+dQ+NcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n3FCQWxy; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYReCcw/xKpexVUHXta10X07HiOo54qE/Zf6eov5OM9eqCBvjiPQRgwzSEWpyb2B4Mtj7LC8eZhBrgnHHZWEV/rmGpycjMyP7i3AvSMqPiVc0yOBo1+tk2HBYdCwV0c5+A+Hcqk39M9Uxgx/hZFiL9lelum8aBzJLjOwewXrsvBGD/zwp2dIruDiTHLVmiJvbawPY+HOyNTS77P3yeI+LGxLZStn13EF+kIgiaFVh+D+OEs3JUtC8OllNs8PJuNuA2b0EjtTJmOzmOnZ3OELPb2xMfAGAVmrfc91ERaipYVP3rwPbWvQWtc3X8bCrXS4fKKmkCH7/DNZSPHBRqsrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9b77B2a3i3hjDgzFN4PzsjgxWx9pZuFHz2G85tPG6A=;
 b=thldMEzw5gr5mRS34+WGFActvyfPh/XceYW8YiaRXfU2/VeGBSqI0kgKHsUKw4RlW9QOcP+JZgEZ7vqXsDm4UiVDorjlh2mYxR9KFMzX71Nag5y8S9h+/Fztl+RWSR6FO3pLUX76Id7mX3vLQ2nJTseQr+IZIxSY32Yb8Tj8LBeRGz8Q7+sHwVURKerzRSXWcsRKcggDjyCPeIFMVkOaUMFui60Cl382alFmAZLSdywBd1QOp0EIMvJk0kFosHP7IDXQxAtQTFNIYEsG4eHZKNt5+Hl2Wk3uTmkkpIVk14PgIYpG9HhGmnnP95jJth+eZEyywxP4i/qNdxqBYDFxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9b77B2a3i3hjDgzFN4PzsjgxWx9pZuFHz2G85tPG6A=;
 b=n3FCQWxyE61Toc9SF5f/2ubgimBNoxzV79RnL7Y4NUesnaTymr+BJOzeL5Ze8X1+kX3BpLRNcSqXxx72I/OnyLKt2HXg7uqQ5DAf6Sm2J6Ld5A08hiVkCN4YwjcZIRaRZNAw278AqJP1IpZt0zc/5YdeYSHhZRV+iB87ZT7GD1Oh0LfcBR0kfsvfSw6vyIJRC/qLzbREdkRe55HIZ0O0fMNnwDjVCGwlOeS236KP6jW3JzLzhjk0gWpoShGICfdD3DWM5UnZIkFkI1Ru/IKXNOGshooWP5VwN6n7ng/I2zNsZuwJUBou88lRGevmLlV/wZyNFj5Rg47+teabvJVP5w==
Received: from DM6PR02CA0063.namprd02.prod.outlook.com (2603:10b6:5:177::40)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 08:14:55 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:177:cafe::ab) by DM6PR02CA0063.outlook.office365.com
 (2603:10b6:5:177::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sun,
 16 Mar 2025 08:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 08:14:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Mar
 2025 01:14:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 01:14:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 16 Mar 2025 01:14:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Yael
 Chemla" <ychemla@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kalesh Anakkur Purayil
	<kalesh-anakkur.purayil@broadcom.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net-next V2 1/4] net/mlx5e: Ensure each counter group uses its PCAM bit
Date: Sun, 16 Mar 2025 10:14:33 +0200
Message-ID: <1742112876-2890-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
References: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb0e9c5-c547-4250-2658-08dd6462a230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JsF3m+SPr92qD9X5HkQUbUbWb94CADGJ+0TWEHHgMUY2cjvrQyWjFWkRnMiW?=
 =?us-ascii?Q?VVLvQLNVRHOaxK/JW1lOshow0KMrKOrmEaDetYwjqp3asFgntgBSPKOY/Kqv?=
 =?us-ascii?Q?9RyhIGzA2iLl/jodwZWi5fmnYOvdBixtHgvobD4c2Bvg5m6X7B3JsdbLjvyj?=
 =?us-ascii?Q?Swz43HWVj7xX8ArR0OAigDpwrlEyrWGJ1EVVYCas4vTsJvrp8wn3mtDVICQk?=
 =?us-ascii?Q?Mhp75uhINN3w3BEMPtNB8j098AO+ofc6R9sHHyPOjnLrpM4/MMTCF56umyu6?=
 =?us-ascii?Q?sVd3Ao3CmTuo9cUOv+ySCj0VokN0ST2d5plOpBLZueMlBSKscEui87yVct0y?=
 =?us-ascii?Q?ZFdU/mhY9IXAxWsS3SFM/5HklHMepYsrWP1HfqZF3bI3JOG8/CMwtW/tyZF9?=
 =?us-ascii?Q?I/DWp/FpbwKp/ogNOxzHETHsJN+PpbPt958mwGzKz+cosk4WL1kEMXRJGxTL?=
 =?us-ascii?Q?MQDFGmAe7Yh2SNm4n/39UujwHKLA9dgHG0mVtaTicZUF5ENjeaL0uK0e+3g3?=
 =?us-ascii?Q?DAaDVmGmK1voj7EJl4xyPTJDb+Xg5t0U0bfv4EnRiufuhSU80kUrynCgNK2k?=
 =?us-ascii?Q?MVo68E6EAVnq5gmUn/zpUdyyC52YH3FFqqIRrac15mrTpGGDTi8yJ1koNb7j?=
 =?us-ascii?Q?3Nly05UF1kNMZarc0YCll/7JX8pG7Y6qUDEkB0hZ4xx7qd8Tm4GGw2FN7smy?=
 =?us-ascii?Q?+YRzhRNagXGM/E1lnVACLHYgdvI+ETH6sL6Hi9IAg8hmjYW9+Nc/vEcMlPrN?=
 =?us-ascii?Q?H4IH9esx05ukKoXLyrplaI6j2HY7uAxHhO+Buq+SAuywdVqX8ZqlqRirqm/w?=
 =?us-ascii?Q?BYHEirh1L/DjQ7+4T58x6O6W36EZIn7ZjtzWZ6Gcbo+p4jLVmKXq8d9wWp6D?=
 =?us-ascii?Q?f8hQckly3bGHCXY2uqC28XXg1T/AqrZdHGxGFTAkQ2LlzlL4BeA5duwMYE9Y?=
 =?us-ascii?Q?r61T3Wpg12STCc5MqmC2pg0+pg/9cmhzQkdOxlBrsZPq74zEzQc1wKr39X0A?=
 =?us-ascii?Q?WwoilmcLWJ9kuOEilmAzlAOLsdEemzj1KUf5lJrK0ukP/tKpsRFyF45eC7iT?=
 =?us-ascii?Q?Lz8OlxfONYkGoORVB8X/nhTorjxeDfpvrTlum9ixEM8YIrl+IAKB9/k+V0Rc?=
 =?us-ascii?Q?EOq++ZHWe827vRb/SwPQ164hz9AsqenTmpoSgXZg0Nq4GBdJUqEj8zQDRgXD?=
 =?us-ascii?Q?5t/MDtMOYYLI8yiMCrOQVesDZ15ljILP6n5Drdl5fzU9z7UVUTdkuMALAlAX?=
 =?us-ascii?Q?FzCS22rYtY8qcMcuFdSGNt4koIcojMmXofwRLrKPCBJIcYkN8rdV+dF1p0Em?=
 =?us-ascii?Q?IHC7ZM4fU/V+OzIFeLL/NgraHTVT5MTKjam9YsRq+1sPZHsLytukX+omvXeg?=
 =?us-ascii?Q?ohJKedBZMf8rHGz372j9CiiepGoLqyFXIrO9wbpiEdf2rwIzQaKluZE9KRc3?=
 =?us-ascii?Q?uZ2QBIsq8ex9enZDbYsX9df6/rNsLGAZwdcC5zd32fpWzsQW1yIWqfaFuZcc?=
 =?us-ascii?Q?VO4kKOGZ+KYS2Fk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 08:14:54.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb0e9c5-c547-4250-2658-08dd6462a230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

From: Yael Chemla <ychemla@nvidia.com>

The code was incorrectly relying on PCAM bit of ppcnt_statistical_group
for accessing per_lane_error_counters.
If ppcnt_statistical_group PCAM bit was not set, we would not read
per_lane_error_counters, even when its PCAM bit is set.
Given the existing device capabilities, it seems to cause no harm, so
this change primarily serves as cleanup.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 611ec4b6f370..77d34037b92b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1272,11 +1272,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 
 	ethtool_puts(data, "link_down_events_phy");
 
-	if (!MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		return;
-
-	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-		ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
+	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
+		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
+			ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
@@ -1294,15 +1292,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 		data, MLX5_GET(ppcnt_reg, priv->stats.pport.phy_counters,
 			       counter_set.phys_layer_cntrs.link_down_events));
 
-	if (!MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		return;
-
-	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-		mlx5e_ethtool_put_stat(
-			data,
-			MLX5E_READ_CTR64_BE(
-				&priv->stats.pport.phy_statistical_counters,
-				pport_phy_statistical_stats_desc, i));
+	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
+		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
+			mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR64_BE(
+					&priv->stats.pport.phy_statistical_counters,
+					pport_phy_statistical_stats_desc, i));
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-- 
2.31.1


