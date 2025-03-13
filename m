Return-Path: <linux-rdma+bounces-8682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E80A6011F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D94517F265
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517A1F417A;
	Thu, 13 Mar 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YTLHqZfz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512D1F4162;
	Thu, 13 Mar 2025 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893960; cv=fail; b=mbr+i9ez6wbX7KBWtELlxUKAW4/4XWFpfLxdFwz3mKiCtxXvX0QnZ/olZ9Q16GRcJ5QzGqEdtE8ZlPuz3g//u2yLC3Aaef1LC8HYKNoyKFtm46G60UmEDicc7kHZoxlWXAqdq5M27Du88Tzh2IO3d26gF1Ov2jWWem4bFXEwS50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893960; c=relaxed/simple;
	bh=zAuTb6dtNGrhVdKKt9efNIZdPXMQJx48ucrmc/pXU0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K396zsi2BiS+E1MOxmvONso3nKgcmb+rYLKHH+KK1MDW6ng0OUL7zw5QHGcRc6qIgsGhgwVxC3KGmMGUOdBnFIDPgU0BYdNZgA9pAM7brPfn1YEOLjA/mcCBGgRt1AhlNFk0JpJrvgbumteH292q6LGiSih57dZiQ5DzKsQkLnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YTLHqZfz; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js2rAinNlzUITCTvPgs1R8N5pvLTrnzsmZ3E3KrmcN2llN5K8RrRDddMKHbI4zt5a8JypxlQqSTkbMWye3DIZD+uqbgOC/1aExHCJoYfE3iNj2/PZ7DpLDQ+iErSQqzvROa3IjKbj9CZ7835cZKMBywfEBkbaie7mx/6MzUSpnRuh+QYk3yGVNVFSO0Uio7C3NTlBqF/QUqMricDNCb0+D4jC1F+s+QmPxxe4eKdJsXzvumpBYBlsBg1+lR/bosF/2hyv1ZUWw3dQCVdTLH1aGzc+Hg9jPIjwY28jOJKV9VmLkdZabZkIAYMtk/srC+dG5w17uoveVh4noLmZ/+JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIRHbZWBNroqd9YcacSx8uJUl2+L6BZ+1slmmq0hVuc=;
 b=EHdnwbloo2K91pQkWTwiO6t9OPpp3rsp4SZ358mCpMOukL2SY+w0ywYKQdBP1AYjFws1k97Vu9vt/Gg1n5B25O2Vq5+qS/KdRC9BtUjliyHT+fNmfIp9F0O/dPZoDkAzxb7FvbcBcyd8UvkB/Yr82+tcruDTn/eG/uk0QlZtpxknZfNNdITHtbeciiMgCR+jynJN/Qxlnnsyxpem6hV5ajuu5pYREJ5HpJmHPM4RBIA3cb638k0agIvsp20ArYo7VEtNJYLRnIKVGT8gOA9bwjjC2tI2xLeGD5xMXtANKZ6Q3n/qa+fc3U+FO1Yr5QWaAqoCvQniPyOfQ5WBVFEesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIRHbZWBNroqd9YcacSx8uJUl2+L6BZ+1slmmq0hVuc=;
 b=YTLHqZfzGW00X3dEtUTJUdqXWdQ1x1rtvAOnyGLKvrOFWx8fr0Vekv8N64O254esibLmNqewi17S9M0nDJEil5GMS6sojAgh6fvNnst9ljrBitOQ8SROiL2qywYNB0uYlWQdDEiAGM+f9EXKyEhmIFjopPT3K1jcZ+nLf0C9fGRmcVJIcQusg+CzQDqH1EqIph3+OLWLhdVv+4CXWHCuy5E+g8HyWRvmMJN9JBtrjTblBYGPbKHkbnmxTqlQTsVgVpzC0kY2dlfa37SXMmE3Y6t/fYESvHPnqoLr2cM09JZf2gawWiRiMLC011KeQI78VCVNC0Rkzu9risBtYNmNIQ==
Received: from MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 19:25:53 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::2f) by MN2PR16CA0063.outlook.office365.com
 (2603:10b6:208:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 19:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 19:25:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Mar
 2025 12:25:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 12:25:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Mar 2025 12:25:32 -0700
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
Subject: [PATCH net-next 3/4] net/mlx5e: Get counter group size by FW capability
Date: Thu, 13 Mar 2025 21:24:45 +0200
Message-ID: <1741893886-188294-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 026ae6c9-0259-4091-8baa-08dd6264de09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zTc7to10CBFRt3aYDv0o1U/EuaPwBNiNFQqMp1disMxk5DTVl7flgFVAaZ8c?=
 =?us-ascii?Q?xKLl23p96Kbls1JiKBk6QIMF81DVHgvf0bsbaPtvPhaE6ZoVuepuLfSVqNQY?=
 =?us-ascii?Q?IL4ipTggbbd40DAXOhk2QDROqu/hi1IOs5CNVMEAJqEVKSpefnniTSaTurn1?=
 =?us-ascii?Q?yj6wfq4gYBIWKYCyzKcG/I5b+KYR3febzDkCnYxnUQWkBwdIMGHAXOzsb3G+?=
 =?us-ascii?Q?/gZSdSU25/FL6o7/OfgKlZRSaj12uT4hQEryFBtWCEzuz3Zn9sPNGra12kAb?=
 =?us-ascii?Q?4EVOUhBaDoXcpxhK5KzlEEgkzRssZNs5ImL5p4pgh0xieO6nkrzoLLx+f20o?=
 =?us-ascii?Q?icU3glqLLn87hIHXH+FeD5YYSopDYayUCwlq7YpqghEG9ArxHXpUgS/BcVRY?=
 =?us-ascii?Q?eFDZ6grENCRbSuP2qskjdOEOUaARenb1AXksB8Co1MdvOf80A2LzQUkzUq0U?=
 =?us-ascii?Q?hGBDxdsDpo2c8f2jWIerawD0cX/flBtNfJ+V/dq1MYUnqVbwYKYq0jiMs3lc?=
 =?us-ascii?Q?T+bglylAHZ+fub5AvXQWoA1FJs4tnUMA34/kReBmGGw2O0vH+O6DsCiF/Xxs?=
 =?us-ascii?Q?XcgArExxnj5wrFDZ7CJ9E8Zr0wCTZn5N/4XYkP/J+7v/j6EfiLFoC0EfcBw/?=
 =?us-ascii?Q?txPa83VmnnJpiAl1yQ41LBOIxhgpcDuKzQ27v+95u8SjKeRy2bf1xfIIWf4P?=
 =?us-ascii?Q?Y2lxGyWNdBoqAS/TDBD16VsBiAX9aXJUInIlkR6z104Y1NOazqxVCkbX30SQ?=
 =?us-ascii?Q?jxoCrTR3ibZ5BD7S8+4t1O8MomZb/k8/RhBtyRxGsNWGGp7mmnidLVeqzqwl?=
 =?us-ascii?Q?PjxWR3ERi95vkxVIN3EOGf+1G7ckgKhFn50m3kd6DDmCTI55tOP6Am64m6Hc?=
 =?us-ascii?Q?XrqEz/eiRcdwenlCQddx/jvaFOr0hTH/AiFZVmXvKtA2q+nm7c44BAxlqTE/?=
 =?us-ascii?Q?bBM4IxA3dvfqHT3itHr+nV20U87PR9kSszWfY2M7wMmCZhaNmmcwJADdURUM?=
 =?us-ascii?Q?bHZs0RlJHEtZb1nxqbXJz3p4zxpbOSXmyRqj+yKuqGrepyvYD1XNWycnmmj2?=
 =?us-ascii?Q?7YwO2A7nkk/eP/VDhyM89LjpwEUIr0eDHgZVKkYTg29J/6OOcu9gRRGA7ZsF?=
 =?us-ascii?Q?2Q03UbtgFX2tI2vUweKdDJovXvjieoDXIS4/xtzx9KA0HMQPRmokcuqS5qZ7?=
 =?us-ascii?Q?9NnIz9dDflQTdXWjyW8kOpBAIA/vV4iFbInbz1npP7XrgLMEKVIwEUCz/t3Q?=
 =?us-ascii?Q?MxZsMLwP/QRHiSvw+gl3hjOFOhNb5hvFRhCeGmUPaRu/T0yCOoNs5ydKRw4D?=
 =?us-ascii?Q?k7auphFDJrOv+yCYiUF2I7J7R1rER1kfT9bzCyQ9T+W7g0XPeHA3FSTZk5vG?=
 =?us-ascii?Q?v8Zpy5alHcT8ln4y6PlNgLgmbgMdmk9RN41WwNgglVe5dUqv4lj1sPjAyo8g?=
 =?us-ascii?Q?WgDpX5HkC2hbPviPxVO2YzaN77dGFo+iyAQ2AJftrRMK0RP6VaxqeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:25:51.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026ae6c9-0259-4091-8baa-08dd6264de09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248

From: Yael Chemla <ychemla@nvidia.com>

Retrieve the number of fields supported by each PPCNT counter group
based on the FW capability for this group.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 58 ++++++++++---------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 0cf0c920532f..a417962acfa9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1257,6 +1257,13 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_err_lanes_stats_desc)
 
+#define NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_PCAM_FEATURE(dev, ppcnt_statistical_group) ? \
+	NUM_PPORT_PHY_STATISTICAL_COUNTERS : 0)
+#define NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_PCAM_FEATURE(dev, per_lane_error_counters) ? \
+	NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS : 0)
+
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
@@ -1264,11 +1271,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 
 	num_stats = NUM_PPORT_PHY_LAYER_COUNTERS;
 
-	num_stats += MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group) ?
-		     NUM_PPORT_PHY_STATISTICAL_COUNTERS : 0;
+	num_stats += NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(mdev);
 
-	num_stats += MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters) ?
-		     NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS : 0;
+	num_stats += NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
 
 	return num_stats;
 }
@@ -1281,14 +1286,15 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 	for (i = 0; i < NUM_PPORT_PHY_LAYER_COUNTERS; i++)
 		ethtool_puts(data, pport_phy_layer_cntrs_stats_desc[i].format);
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-			ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
+	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(mdev); i++)
+		ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-			ethtool_puts(data,
-				     pport_phy_statistical_err_lanes_stats_desc[i].format);
+	for (i = 0;
+	     i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
+	     i++)
+		ethtool_puts(data,
+			     pport_phy_statistical_err_lanes_stats_desc[i]
+			     .format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
@@ -1303,23 +1309,21 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 					.phy_counters,
 					pport_phy_layer_cntrs_stats_desc, i));
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-			mlx5e_ethtool_put_stat(
-				data,
-				MLX5E_READ_CTR64_BE(
-					&priv->stats.pport.phy_statistical_counters,
-					pport_phy_statistical_stats_desc, i));
+	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(mdev); i++)
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(
+				&priv->stats.pport.phy_statistical_counters,
+				pport_phy_statistical_stats_desc, i));
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-			mlx5e_ethtool_put_stat(
-				data,
-				MLX5E_READ_CTR64_BE(
-					&priv->stats.pport
-						 .phy_statistical_counters,
-					pport_phy_statistical_err_lanes_stats_desc,
-					i));
+	for (i = 0;
+	     i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
+	     i++)
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(
+				&priv->stats.pport.phy_statistical_counters,
+				pport_phy_statistical_err_lanes_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
-- 
2.31.1


