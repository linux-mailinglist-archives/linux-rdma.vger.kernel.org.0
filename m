Return-Path: <linux-rdma+bounces-8680-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A97A60114
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 20:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5912017EECB
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489011F30A8;
	Thu, 13 Mar 2025 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="txTfvF9N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44441F0E44;
	Thu, 13 Mar 2025 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893954; cv=fail; b=aeRPYjBgX57V/0sA0+lqmKCtdX4D/cHTbLN+aDzkAsGirpWl9v8/4TUjC/c/b2m05YC3j4MUKdZQfh6jwFUZrjZ5qkVVezT+RUBzPCZ/f/Ju3A7Q7oQzH0leqyJEXI1l77zRk9yqo4ZzgX6vB1EMGCDUWi0bwJWHsBtuXVcJJyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893954; c=relaxed/simple;
	bh=fwLjWtckE+bO9Ab3P2gNS7t2Tcy33aoQXO8jfTOd9/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xs4LnTwhBMWEkYZi8EXkaWNTOB97hM4k4/SDsbIrrFdzXd+RIcyMPuY1HKZOEuX9jhypVCwpABXqM/82Aam7gfE4fcS7w0s0GTZCD9VNwKRlOKXpQJaxa6pO8v3BH1C5Zk5usw8EhqsudBzgmdNXcPPjBASXWr3BROr3Lt1GGQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=txTfvF9N; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXwGZYskeX9Cm/LSCg3+s1kbYeK/iZOIFveRWIgw1bolfL7gtHKV+Yz695m/HVY9vwaNJFCpYPExRj3QA9qhKx6/Z/IG9Ny5znfZXZ+9KAKEOgtM3MyX0fEXi47C+WZeS+vFy8Ahz9NGh/JoRdxitSM0oA1v8ND28P2FuHgiYYlw5KB/kq6WsjmsvWd1iZQfXf+qiDM8gwiOlDUaJvxvM2c4mKx6tXQ9KZKwLXqUBOffyp561qbPJnlA/d+K9KW9yxtdBhYbbmNFB1lYm7q1w03DjPaOUeQ7yeF9TgHtlUPfwS6rOruGlhkQnJ96Awig4Bk4m/WjaWXRb5Tj28doAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7X2xUgwvpDL8If7efKjrapWbhJcYnHks/ZK5a2q3YM=;
 b=GwALRsxHmRe88YIaLfIR336aynr5ASAW+m9dzNIQIT9tkkHagfLWW3RQ41ZXhC6U4TH1czQalfVbvUYHEVswxPZ2Du+tkh2+Q85ZjtdLQFz8kA75Kb88FI8LT7/2BsJW0iGYQEfzHftbjWJggxa4obQhDZCsrkbuBnwxcF0YkNYNr9V+utAfGTIXjXCKudGQqtb3n6fMM7YQgIey6jexIaRfs7R6lKzKDqfLbYErvlK569826YrsDZsDUZM2CsYo/4WAI/gBDYN2Ow1n8eqI5auj6y6mOjeF3KOUm0GKgL6gxPK2lR6eAxpDAwFFDovu6VSZ5bMFBqoAqP+IxNuPoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7X2xUgwvpDL8If7efKjrapWbhJcYnHks/ZK5a2q3YM=;
 b=txTfvF9NIJw02txZLkSL+TmGmjcrgNGKfeT1m+Tn9/9FXE3sBIsgkburkD07xOwsVgkQRLT1Wk3lza6Pzdbyanbmo4wvrniGGEAh8o/UZ2/cX+iiaXcXp/3lWEQ4/TNDrnm4mlovNiMLtfb2IpsgKucSErPkVGmTprGU/ChtmvzXanDErtO8XVwOvswbja4PUSBuVoYZPbbUiFaLKjXEgjMfcHAlTgF6X2Bea5NNI4DOXFdT3ynCtNMfavBsdmvafIdcXSYKxzD6/n7pZA+w3z2mGTNsgR0U2hP681nc7FvKz0XCSuvvkSm45UXUfESnvM5MLU7zeyl7B5DfMyo5PA==
Received: from BL6PEPF00013E02.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:18) by DM3PR12MB9415.namprd12.prod.outlook.com
 (2603:10b6:8:1ac::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 19:25:45 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2a01:111:f403:f901::4) by BL6PEPF00013E02.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 19:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 19:25:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Mar
 2025 12:25:27 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 12:25:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Mar 2025 12:25:23 -0700
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
Subject: [PATCH net-next 1/4] net/mlx5e: Ensure each counter group uses its PCAM bit
Date: Thu, 13 Mar 2025 21:24:43 +0200
Message-ID: <1741893886-188294-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5ac050-1b59-4ea9-bca9-08dd6264da3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mErlW0cJnO6AKlwIOE4JU1uO6mdQ4YiD9nmkaOnF6clBCz70E6F0+E+6BjKC?=
 =?us-ascii?Q?uR1N7ji3tbYilbcXyD+t42y2LadpevFZgWRSCoa9pqW4+Hsez3EhAqNvolZL?=
 =?us-ascii?Q?jFdaA2EGR/gi1RN+RwrLp1x4zvoCLxMi4zWsKIqO3yanysHNfZCpSXc/QtP1?=
 =?us-ascii?Q?mWrrhmNn/k0JM23BP4o8TVWx+rN1fgrjZrHg1hBdlKepQHfCbUH5UP7t/gK8?=
 =?us-ascii?Q?ezFe0KDD2Gsrt747egsFFdA4vZsS1fHc/PdEF+KlIGC1SI7+BPBU+pcLvyCt?=
 =?us-ascii?Q?3A09iB0o5wj+yObEK0GHXONKYPlQUPMo4S7vEYsWn1p4HQDtkB7k0KwhT028?=
 =?us-ascii?Q?XXKR1d5FmVFNx5t6tqJbGkwU4OvBXxs1ckbGfc/n7I+FfSYFuq08V2Qhr0ET?=
 =?us-ascii?Q?h8/VjDsH25zWi1Eg6C4mtRGfIeOEvHqpp2xRO1QkaJMEEE0yRagAUpTdprM7?=
 =?us-ascii?Q?rxgA7OlCStBTQlWnDQ5HKyODlwC6TfpJPA8LRwZz3jEebXEBkUTj9n2/Zule?=
 =?us-ascii?Q?G7qDTqA0VTrdIGrSIEFnMLPAciLmANtxSh+LYMVzYwXo4/agbjbqC7NmakbR?=
 =?us-ascii?Q?V+REuaGuIDmJhtCgMFCmDIZcdxTZs+fncpp1lHN2of5mQuC+njS2g8uRHRik?=
 =?us-ascii?Q?8sZyBUYvO/DC4xEyTMAwCORdxVLu6eYHyQiaB+C3i+cf3XROhrarqYTd4XC1?=
 =?us-ascii?Q?HJgoBU2GVCMpGDs+QYpwzX7YggRm01y43Kg9fEgm4YuriWQSCqRoDZ2pYsYt?=
 =?us-ascii?Q?Tv88viR69PFg1fKIAEgvxAKEHkCGT/l8eS3rG1ugjNd8s8fKOunD1/Pu6PJr?=
 =?us-ascii?Q?Zrs2i1QVxXPW/6JmY29KzWegzl3hl7kuBR1mx6djbdPFb51EI8IMRcRKpnYl?=
 =?us-ascii?Q?6zQQot6nN+UccNbBV9+nixUhSVL8Jx3/XK51++bTtspcWX4UJykn659HdbN6?=
 =?us-ascii?Q?0JODv3O3tFRR5+KxH22oSAlrI7GiVth1m2dLlkyrmY5XViE3oqIZEZ9NX/of?=
 =?us-ascii?Q?dwsM3kxo8qamHOAAbKfB7IEqhIsMdpyAhwgcW2Kv7HxRMDKesw6+npbRwPc0?=
 =?us-ascii?Q?op89GGWm1aDReUWAI598uEVkc3OD2cTnWNFJEVoLIA7ikkIFL/jF4MRYqkx/?=
 =?us-ascii?Q?zHAplX8XI+yuC4UeUsiBqjeD0UDveEGmTpn952CA+GQJtsXorAuxcpJm1fft?=
 =?us-ascii?Q?L63FYd2WE4qS21I+KJLlTccX47FvA7lAWCTWokAJEEVzCqDd0iPEX4y/hvJO?=
 =?us-ascii?Q?ukMCEVLfECLBoSbJtFYB8A009+PPBgX5hgJ0X9OaIpcMOdxobGZhqd22ED3z?=
 =?us-ascii?Q?Icu0TKpiWuRX5nfOnmd9HhTr48uiPOIXQ7GBEyTzuNCUdredkrxi9QLlg0O6?=
 =?us-ascii?Q?w54BDde/uJzO/LBJ6Z9F98145JExlCgxITS8k5XfeMG+TEMIIcPvL94bFaCe?=
 =?us-ascii?Q?BsQLZ5w9ftloT/FOJba5b+gtJi4MKDgNn7bgo/o8x58hTtSwdTbbyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 19:25:45.2177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5ac050-1b59-4ea9-bca9-08dd6264da3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415

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


