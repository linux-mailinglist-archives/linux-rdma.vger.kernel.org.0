Return-Path: <linux-rdma+bounces-8681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618DA60117
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2182B19C25B5
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8581F3BAE;
	Thu, 13 Mar 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwyE98kw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAC1F1521;
	Thu, 13 Mar 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893955; cv=fail; b=nYGoByO/Cnc21ogvuqvK2DMma/BUUomSjek+lAEzDmQyxffTV7AnDuS0KVx1Nv9HwtCMcbgAU2skFvnfXGxtGV+JqF/NmLFxefUFJYfh0IMtuDudtxFJj72C4Juqz2awICfh+Dexik41wFbtjb1j1aHTo6vzzR9Fh5Bb6T1jjRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893955; c=relaxed/simple;
	bh=CdUnjPqArKx/fLEtvvv6H6amUI3Y0grZvM4lrPSQGB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YO0Fe2qsezz6nqVXB5hnBL+rWBBMcQ7N04nLOf0QXsKPeGG4OMe+RgTbxosTFm89GnS/tArU767QTGWqZecXShPERorCxXddcy6DGu47v/RXYz0zze6Qwj6rp4hzAvrz8Ri6vDH/ZkK9rU5/CEvehN1I8soYtK3bBBLvCAk0NLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwyE98kw; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC6H27oMiBaEH0OqzIA2U0M91ktegrkEv3yzbRwcZW9duXKJ2xKdnKFn/rko111bVI5JZgslG8fwUmhploipnbPaGEfOeyK/PQjAV3Mb5LZBh+D8Yg9bEnOOILXeOnpcF6td4LxEIqK5zqhbVGE24daCmhdomSoPTMNQLBvi5APJxPQS4uAdfNh1KSi8AgDwLwzlwsfJIq/z3Nw9UCyE7uxU61D+MAoPX1RukTo4iIzrFtRjzaO1rV22wDAOP07O6biSZcoYkBn8CxLGVQ5I0sug2MFfAf+sl0/wPbXDaMBXym6hHZIdTxH8EWMorvCNXmb4OGDQ91WlhjuAI4WHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isy2U0Cs5iDfTgnPyzRsNxiJYWfZhv6SGC/0sHQZWdw=;
 b=bghQQ0jPEF1INeBG9PjGUB7tFbgbX0+96LufvuPxrtqQWZq1/0eOFN/2k5+jKcJbZwB+SPg0CmbnQTMjOp2olJSvn/9JGHunZ0+Xg09rYPrXlqKg/0BeS1/+nPfNORWG2pyF5AvJfEtKPCkJe2mtHjrqtKwkzj315/pQ2JUVeL6CLiCjeyWMp1zsBfJjESp4iyaxI7z0ZY0xTCn5oXZtzfbWa4rdpdNqpG0tslafMYnZcVTjwIGXiqYSzooeSWNYgyhLZZKtQ5puDVQ399CQ8Y2R5tbTH6CuBmabvzVE8mNNg05ECgBxXVBVc2d24+DpOvnLGH3aH1wEijyR5oPNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isy2U0Cs5iDfTgnPyzRsNxiJYWfZhv6SGC/0sHQZWdw=;
 b=NwyE98kwz6bPNszf1PPYQPIDceAU0mDFPnYFqr4eNRSq6s8INCWz39pksSiN7SQsvuZF7mtkAoQAHD+TpVXbpQUIGNpt3SuU6jpC3mOI6BLewhviqzD1XkJxWD3NQzcX3jPvcjVqlQlWhwcfipSahph4YDnFuhq9NFQBAqhcZCbADG/11r8VzUTEuGwuehgyUMQCPNyJomED11CwFSdJhm1FWMU+AUooMW73Shdd2Ib8qdlc2K4mEUOL0HzGK9ayV+hetgC6HDq1PbDTspACs8WhL4YSP3FFpScQiFr6vdjnJb2zUdrx2r86eSU2GOR1fV+6FAVRpFLpBpVpXNXL0Q==
Received: from BL0PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:207:17::35) by SJ2PR12MB8182.namprd12.prod.outlook.com
 (2603:10b6:a03:4fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 19:25:49 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::83) by BL0PR1501CA0022.outlook.office365.com
 (2603:10b6:207:17::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Thu,
 13 Mar 2025 19:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 19:25:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Mar
 2025 12:25:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 12:25:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Mar 2025 12:25:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yael Chemla <ychemla@nvidia.com>
Subject: [PATCH net-next 2/4] net/mlx5e: Access PHY layer counter group as other counter groups
Date: Thu, 13 Mar 2025 21:24:44 +0200
Message-ID: <1741893886-188294-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
References: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 01982513-d16b-41c0-70f5-08dd6264dc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7ts9AtK2/fs/rUSApFADOjl+xpSuxaFEzIb1EjWPLyD47ifOU+VdNxDSA8H?=
 =?us-ascii?Q?0WbN1wDBioK1Vc5ojf3BRaeIGTwFRtDboiswHCSuFwJ7ZB37hROE+egOSIsG?=
 =?us-ascii?Q?hz5LdMqSMnKkPSZvmgClO8qHTh25QZNA6LcjrClBEQdeo3BhiMR1Sv+Y7Gzl?=
 =?us-ascii?Q?yTqezKXRN6+6dvgaS6wIaTagZ+n8j9rvx2RgHiL1y85szayZXSR2hncd13r2?=
 =?us-ascii?Q?BAuH2/RnlyeolrNajs/depWNJG1oV4OUolAW7OHZoqedr7Fw6zKTFqy42bY0?=
 =?us-ascii?Q?wFrN7RDBPjX3JwH/tbIUqCvcHzVpSE5wfqFvWW+2ZIOrUWgfrplieP0J6qYc?=
 =?us-ascii?Q?Q5lM5bq+xyu7R4Vaz+KJi9UGrdUV0Y18YMHRhsQ2aAnjj/oQNv/uhiqHPyWB?=
 =?us-ascii?Q?MepYHkFYioYYtzBna+Sm42EWcIRu35JbZhoJ6dES7KZ5UbqkwMzaj59TA4rm?=
 =?us-ascii?Q?Io0PeCXm2xkcSubZ8VNySS31vXfko5GmW7orCb8Q69mERU2ZXtKJ9lC5mPf9?=
 =?us-ascii?Q?lB9ZAJaHNEZJXiyHO4Gnt2tIAiwL/D2e079qZmlr6NBMMfBhIsjpFZGlFZVQ?=
 =?us-ascii?Q?6onjN1llIiHCi5fm43+aUgqctMHzM3ZwCl+vx8LPAjG7ufo6XI5qXa//P1eB?=
 =?us-ascii?Q?HmgQRTShr3dXTlh46Vx6yG9DzQ/6wDNbDKihFLK5PxBDCplEi3ncTUWaIu2Z?=
 =?us-ascii?Q?Us8zUOygDGHhI0coKipil5FUfKy0EwV512gLV6Ce5Bu2IZosqWdlGhuN3zeq?=
 =?us-ascii?Q?ift+cM/1N21Jmxvsxr4VMyUJeH7ig63kihCBD6xnW7bjy9pyqqh8hZ0PZawz?=
 =?us-ascii?Q?RLzaSyVMXsa3riJqBgkV+WI9POClkfUQzAW4Y8+X0jnEa79tp32U6ku3MrE4?=
 =?us-ascii?Q?b11oeYe+/gpReVAjxwrD3gzK3nD9lqa9FDdnd4A5O01llVWYlbV1+6LQfwyg?=
 =?us-ascii?Q?P0o5c/TbtdMEar3S/IP0REQDW9n7ytdykFgr6TyIB+XjSmohD4LUoMmR0P1y?=
 =?us-ascii?Q?KmFU8xdQzPe50kkDLJcXoDNDCOrMGyeFmJweL9AExaHoDwPnr4OV8TRVfLvx?=
 =?us-ascii?Q?yezHS3u8C+Y9Y6yNteFdFX+XAzFUGnWHKsD2+elLMzOCGsSI8VvJ8xTRan0y?=
 =?us-ascii?Q?Ewoxf3ZOjbNdQ0fmvOZvEe6CwQNBVLdIhT21CAdnc3GTqjdLS/SDTSlGULBh?=
 =?us-ascii?Q?z0pXt+51TV9o4w0Fr4t4f0YF3bjDZnBrVEQbVnXvOFgOJgN+bbKTYASpkT+W?=
 =?us-ascii?Q?8AyoGkQTCl8vuypAFHywetm8QE/n+1ItwL8dtDXg5CFrOtIFsBeUt8bRppQF?=
 =?us-ascii?Q?DoAFjLLx9gcIDnzqZu+IZ4Nox49lES1oKEiyvT+8hQpmLen1dPR9twnOfWy4?=
 =?us-ascii?Q?1vZlyG/rfJ+ymVVqvGrcy5ukzgdoBS2dXqaT4/uZRQYQ1V8IcyfN2krz1512?=
 =?us-ascii?Q?X/WRjk+OqaIXtEJSKLg5MYhxaTmZYA2OU0TgDSjXN6G9ecDANAmnwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:25:48.7769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01982513-d16b-41c0-70f5-08dd6264dc5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182

From: Yael Chemla <ychemla@nvidia.com>

Adjust the way physical layer counters group is accessed to match the
generic method used for accessing other PPCNT counter groups.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 77d34037b92b..0cf0c920532f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1227,6 +1227,13 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 	mutex_unlock(&priv->state_lock);
 }
 
+#define PPORT_PHY_LAYER_OFF(c) \
+	MLX5_BYTE_OFF(ppcnt_reg, \
+		      counter_set.phys_layer_cntrs.c)
+static const struct counter_desc pport_phy_layer_cntrs_stats_desc[] = {
+	{ "link_down_events_phy", PPORT_PHY_LAYER_OFF(link_down_events) }
+};
+
 #define PPORT_PHY_STATISTICAL_OFF(c) \
 	MLX5_BYTE_OFF(ppcnt_reg, \
 		      counter_set.phys_layer_statistical_cntrs.c##_high)
@@ -1243,6 +1250,8 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 	{ "rx_err_lane_3_phy", PPORT_PHY_STATISTICAL_OFF(phy_corrected_bits_lane3) },
 };
 
+#define NUM_PPORT_PHY_LAYER_COUNTERS \
+	ARRAY_SIZE(pport_phy_layer_cntrs_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS \
@@ -1253,8 +1262,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int num_stats;
 
-	/* "1" for link_down_events special counter */
-	num_stats = 1;
+	num_stats = NUM_PPORT_PHY_LAYER_COUNTERS;
 
 	num_stats += MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group) ?
 		     NUM_PPORT_PHY_STATISTICAL_COUNTERS : 0;
@@ -1270,7 +1278,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
-	ethtool_puts(data, "link_down_events_phy");
+	for (i = 0; i < NUM_PPORT_PHY_LAYER_COUNTERS; i++)
+		ethtool_puts(data, pport_phy_layer_cntrs_stats_desc[i].format);
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
@@ -1287,10 +1296,12 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
-	/* link_down_events_phy has special handling since it is not stored in __be64 format */
-	mlx5e_ethtool_put_stat(
-		data, MLX5_GET(ppcnt_reg, priv->stats.pport.phy_counters,
-			       counter_set.phys_layer_cntrs.link_down_events));
+	for (i = 0; i < NUM_PPORT_PHY_LAYER_COUNTERS; i++)
+		mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR32_BE(&priv->stats.pport
+					.phy_counters,
+					pport_phy_layer_cntrs_stats_desc, i));
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-- 
2.31.1


