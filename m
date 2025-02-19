Return-Path: <linux-rdma+bounces-7828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB43A3BD32
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D109A3B6AA4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2341E0489;
	Wed, 19 Feb 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9SsU4De"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B81DEFF1;
	Wed, 19 Feb 2025 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965377; cv=fail; b=Vlq+vdmFaJ2RIPSxaqq17KihteddSjC/jeFsZTmwhvmVYaDNUYhGje6bQDBYHp8FSDkSh+/t22P2Mzjk8NwP+HXlibBmS++7DnY3JzbbDgCZ6tIZjjIy7XGrD/kQp5+pk3C0ULmmuf0y28aDPXfr/QTs5Xu0EAGpVi/g9cqMlKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965377; c=relaxed/simple;
	bh=rfeMCg+iSdvQnZJYREQwhh++/lmhmwCoP9Y/sTUwjzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Go7WWTxoWHAOV6IqtByf4CpbQqzq8mDKD5YcEwV0dZGiN0Mv+SbCPPV4ugk8+ilKtoVJWEnkkCPkBYrI6Jg47+9EG+3qA4y/K1wo987B97+EU248lKKxRjzFOJhWTN6a3uQNe34jxYQKWan8e6KtMbJ7Ot+buiwlMyb9d4uUASM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H9SsU4De; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wbcWKqo82EniKSOl2av0hkAbbTn03aIAsy7KnnaEVLWCm6cDgm2k123UCQcouLNQ2K6R0TsjdASNW32XcLNGYT+kNgIallFcaHdi3nsJmJVyfZeJ6jae6Q+PAfZQM2OhzvCfWUgY4/MQ9Eoy6l9KbsBR7ZBOaf7YV0ERdlP4oLh1APlRLpaVtJKDwjpotYn9jm/V4zOHRtTe+0lXNt+7sNBBGY9V6fBtgXqFZ2dETz2GEVIZr37YPJ/H0NmA+z/HK92GJq7WR3ECtUt1uBd1ChXCJpUEp+22dOBWk6AHMipj6oyGNEB79c23Lolw1NS44jX2W11I6QYYa9pDUfAfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k6G/Sq1G9Uuoyp4jfC6AYXvzv7Jyc+OvOHATP1nlFQ=;
 b=sVNFM2+XjHfV47Mv0ptSC1erq5FVlAXf9i1G+Vh4eoDn3PofwLyl9fdpbRimKK7pDo448zXSesrt5asiIvkSvlfVfTbtbHZuFg+3CmTrjo4GPg5jx9L4hS5u2sm46McP8AnfermXOJ5XMoiQ2p3cL2DSnXO/wFnvtnTyhJQEaqDoHuqq0y+8gki1H9fnoXc3N5VPhF0PWnI2hrZpuMh/jgTJYUwsxCsamOlcppZj92tOlSPM7GZSFeHNNZYRNc2MX58xqP/h/g83NHEROd6jxXQmup/9E073BRhg59eJbufavxIkgwkMzX32O9Up8a+aCIlmZrRoCltB4BFwQyUwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k6G/Sq1G9Uuoyp4jfC6AYXvzv7Jyc+OvOHATP1nlFQ=;
 b=H9SsU4DeuUw6uMx1r/yvhN9HZ1d8jihFhEqcrA9DKeVBzk4GJlneC+oB0FfyGgAPJVjRyIAsssB29qQQRqFG+4Jv1VDMfpoNoX9dxfbKhwKKu97LA6lqPvGXpawgqJRBhsTxBhrKu+QdiEgXrwB5RV2dwYOZAqlAWfAZyB/LwIUiQ2qHsnqL1pEKpgBiVT/Y7hX7VCI5EV85TXsBzaBtDYWC1M9+VQtDO0V3CZXQJGG640gcx/llaDxEc/Dr/mA9cpPxkUP90zvE1oKvppt8Y3naIkIBX3NSgxMndhZrqZ8H3m8JhazmXuxQGR4XfnOcfIacwYZ+DXaQSX8Tz03GYg==
Received: from SA0PR12CA0027.namprd12.prod.outlook.com (2603:10b6:806:6f::32)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.16; Wed, 19 Feb 2025 11:42:52 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::62) by SA0PR12CA0027.outlook.office365.com
 (2603:10b6:806:6f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Wed,
 19 Feb 2025 11:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:42:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 03:42:38 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 03:42:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 03:42:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5e: Refactor ptys2ethtool_adver_link()
Date: Wed, 19 Feb 2025 13:41:09 +0200
Message-ID: <20250219114112.403808-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250219114112.403808-1-tariqt@nvidia.com>
References: <20250219114112.403808-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: c454b251-78bb-43d5-05a7-08dd50da8ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhS3uvzzrqd+ZQl11yTdlHIv/aSBdWZp/+AYN6jX8I5sjOBwS/xo4iKqaOlw?=
 =?us-ascii?Q?rGisAZIxklBc/I7OepUdroKI++8pWI7iLPy+Kd01Lx6A7jXDM4Xc5E+ylx1k?=
 =?us-ascii?Q?AxUYxXjIhNiAUVa7rINbesrFDR0JTT1iV4R9vLElNv6Y0VXQPLP87Wo5RcAP?=
 =?us-ascii?Q?GTsPsBS9IDg7XxZvzzEtLie5ehJm8UWQXbWOsbc4pkYW67BYr1ZOs28hIA98?=
 =?us-ascii?Q?wtsiToi3F/Sj919669IK5WDpTD6sNBZ19p62p+qLMdtx9f52TKFHk+TiObNQ?=
 =?us-ascii?Q?drV/PNWC4MVDyGuFIYhgyyOPrf8bOs7PPKLvEzVH2HxcwlMu2At7aWVdu/u4?=
 =?us-ascii?Q?00gxDMCwlN9ZU+2/n8+ECcpKWBXmQcwvMS0g6f/2m166YHkFni1hQHUQlP7L?=
 =?us-ascii?Q?thE9Fg6OaDzs8dh2nJfoC1S5CMxTaPMBTRyaDrOT/Dh4VxaUn7xl0sbcXgH2?=
 =?us-ascii?Q?rXIdYlxqrS+sPZ/3dZ9Y3jGBCq29Kfk5UrVt1StZe7sh/B13N1kWA+DHgJw5?=
 =?us-ascii?Q?/wHOe2pcAQE6BcrzCp4Eqn1cadSFkx8tFBu5ZBr0T+Xx3D4Cu3mi8Nf+XzVf?=
 =?us-ascii?Q?TdGd1lyfeENFLvmxjMLkr5n2Kb1pneqxeozvqZ5hpid3n0KTKBiS7YxmQ7v0?=
 =?us-ascii?Q?resVeC0bQW9JCdtsplWFwb33mJjavOSJb9nnXjEvp2tBbk1PeMeAPUz3G7KF?=
 =?us-ascii?Q?Yk+zqTz5X6I4ibBTWYBwQLvCsrrLpb2vJjkYMXI9j/TsKn2308efo7WCSUMa?=
 =?us-ascii?Q?cbGDx1KDKt2jd/8kAMacD8l4Q1t88v/H/mmt94glla4boCkZno+FLYdPXkhj?=
 =?us-ascii?Q?oVpz0a0zfH5EX0aOt04M1nqJYjEmyutcliXpBmuuJmUJxpg2rERu0RKBTLLT?=
 =?us-ascii?Q?y52hdsRHH8FdYZaQncWABN8ousT00nZJDFkrwM9pShxGKkwa23kbM9Mlgc/k?=
 =?us-ascii?Q?rDACaTIB2r2yJWcDnnjCuLLrH/BEiB0yToovKAzlUeR6s2Xv8v9mNwFtBkxs?=
 =?us-ascii?Q?gSpHEWXZPr5aTcPYxjL18HpHTo1Zt5+sNhY2X4rB+NFLMcuGZJbJLeoNwM9z?=
 =?us-ascii?Q?Br0VOkFEgjIvGiss0OnrQA6NcIUgVPMuVfsTsuXOODL97IV0XQJJP3o0rEtv?=
 =?us-ascii?Q?D47kSerQfMDclWRQous12p0obJUv5RgYBY6ZKCkHa0KMnmuTognmhV+KMmTU?=
 =?us-ascii?Q?GuNi9XULZyvPQUXbStYNBbVDJ9JtZboYyPYCLq5n/zWuO0hN7hmNnzfegAJM?=
 =?us-ascii?Q?Gnw/YqhY1EBcolrxuTG5oUtuzblN4kX0tV+x5Z0igQiVEFSi95O2h9gFN01G?=
 =?us-ascii?Q?CfwTcEmn2XmVER+k6yfoBn53WZerpvolNCSsujsbHO3ZEsWbIEM3OswwOokB?=
 =?us-ascii?Q?Qg8hFkesxwnTDiHvrwzwyuEcoukoGL69M4x2pRzZqkEoXgQXxf2vXWnjF++F?=
 =?us-ascii?Q?GFGdcgP/ARZ6uwWatKedxWMMQRuaPZuZjE+jhO6duCCH3hecQj4s+3vknCPM?=
 =?us-ascii?Q?YDEQSXSzZpumo3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:42:51.6135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c454b251-78bb-43d5-05a7-08dd50da8ac2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435

From: Shahar Shitrit <shshitrit@nvidia.com>

The function ptys2ethtool_adver_link() contains duplicated code that
is found in mlx5e_ethtool_get_speed_arr().

To eliminate this redundancy, we update mlx5e_ethtool_get_speed_arr()
to select the appropriate table based on the ext argument passed by
the caller, rather than querying the supported mode locally.

This allows us to replace the current logic in ptys2ethtool_adver_link()
with a call to mlx5e_ethtool_get_speed_arr().

This adjustment aligns with the ptys2ethtool_supported_link() function
and prepares for an upcoming patch that reduces code duplication.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index f9113cb13a0c..a24bc546e270 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -260,12 +260,10 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT);
 }
 
-static void mlx5e_ethtool_get_speed_arr(struct mlx5_core_dev *mdev,
+static void mlx5e_ethtool_get_speed_arr(bool ext,
 					struct ptys2ethtool_config **arr,
 					u32 *size)
 {
-	bool ext = mlx5_ptys_ext_supported(mdev);
-
 	*arr = ext ? ptys2ext_ethtool_table : ptys2legacy_ethtool_table;
 	*size = ext ? ARRAY_SIZE(ptys2ext_ethtool_table) :
 		      ARRAY_SIZE(ptys2legacy_ethtool_table);
@@ -912,16 +910,15 @@ int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
 	return mlx5e_ethtool_set_per_queue_coalesce(priv, queue, coal);
 }
 
-static void ptys2ethtool_supported_link(struct mlx5_core_dev *mdev,
-					unsigned long *supported_modes,
-					u32 eth_proto_cap)
+static void ptys2ethtool_supported_link(unsigned long *supported_modes,
+					u32 eth_proto_cap, bool ext)
 {
 	unsigned long proto_cap = eth_proto_cap;
 	struct ptys2ethtool_config *table;
 	u32 max_size;
 	int proto;
 
-	mlx5e_ethtool_get_speed_arr(mdev, &table, &max_size);
+	mlx5e_ethtool_get_speed_arr(ext, &table, &max_size);
 	for_each_set_bit(proto, &proto_cap, max_size)
 		bitmap_or(supported_modes, supported_modes,
 			  table[proto].supported,
@@ -936,10 +933,7 @@ static void ptys2ethtool_adver_link(unsigned long *advertising_modes,
 	u32 max_size;
 	int proto;
 
-	table = ext ? ptys2ext_ethtool_table : ptys2legacy_ethtool_table;
-	max_size = ext ? ARRAY_SIZE(ptys2ext_ethtool_table) :
-			 ARRAY_SIZE(ptys2legacy_ethtool_table);
-
+	mlx5e_ethtool_get_speed_arr(ext, &table, &max_size);
 	for_each_set_bit(proto, &proto_cap, max_size)
 		bitmap_or(advertising_modes, advertising_modes,
 			  table[proto].advertised,
@@ -1128,7 +1122,9 @@ static void get_supported(struct mlx5_core_dev *mdev, u32 eth_proto_cap,
 			  struct ethtool_link_ksettings *link_ksettings)
 {
 	unsigned long *supported = link_ksettings->link_modes.supported;
-	ptys2ethtool_supported_link(mdev, supported, eth_proto_cap);
+	bool ext = mlx5_ptys_ext_supported(mdev);
+
+	ptys2ethtool_supported_link(supported, eth_proto_cap, ext);
 
 	ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Pause);
 }
-- 
2.45.0


