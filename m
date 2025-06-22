Return-Path: <linux-rdma+bounces-11519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38705AE30FF
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCDE16EF8F
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42815ADB4;
	Sun, 22 Jun 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kRWCopDp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BED1F3B83;
	Sun, 22 Jun 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612973; cv=fail; b=IpcmUCgPOpSZMnSil5YwqE1zy2do4FN909vLTXgdmupbNyHkRvavXOMNN6fmMJ5iWr/03zrvNcw+MobSkYtqrRe/EKZy684onflljYfPOQ5k81ykps2OiIbA/j9IXbl+azhz9yhqLShOC8vTyCv5TZUsMWSeU3u582lXgaQpLqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612973; c=relaxed/simple;
	bh=dS90vfcUrBPDeJrxOypfVyYlYvv+VLeWO2L7ZVcxrJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2oSZVZL0O33axj1Nsd9yMXzQ1aEX61zvjZbqkex2lV6rFVMcxDwMbegE1oTtJyO+GKcYG/WEpAOVmvOR/1SUf+XQLOqv8rGAE4WjhOPKFLUAcRdX44tv2XR8Q/NoJAHKLKRJcZYoHMPFLFp8YLiMRadQM97qyoQKNe+ic9X8W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kRWCopDp; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt8Mbw3dRy/6c0rbG3TUvk5IJuJ+wDh+N/Xs8gLOW87iqDC2nOTKKtnTe4SzRc8tNx9ECD38A6ZjWUQrXhm8DE2CkzRnpBaRzBT3CDhJpNy+NEk80sqCJyQI+JFao/BLb9icrcen8Zeip9BMXYvnlzjVJ2/wdbuULUk7FN3S7/fcu0Ls/Z0jaYw1pt2scBQA9e/jnIA6Ws9sNo0p7yHTN+/fTXa9neMPGv6A9DUgxmmdDvfmQWeqoJKk8gDRwaSOBb9Ku4km2ZIGyvyfcObXqjzA7HCw5bnj2CElXgL/WlZh6ca5vQpytrxG/1Z5fGiGUQiyFfwRzEPj8BaOPYD24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LviI4Potc1GrYbiU8zxZq227MFdPF+DpjrbJy5FOn7I=;
 b=IkgvCIQjAb/GZBcnwzCKCLTxvicqcqPKVA4PqHW26baUCtuwHl3bpVjbUa4Dd4TcR/WlTHVOHVq6ZvBtjAkBDkolNefyXL2uO+vSwX7vpgSZxjxUUxrQg5QKTtH1GNuodSSkWrqgKWrQHmxiBBEPCSovdno48tRIXQaAv9ngGpg8K6/uTm0ve+i6NGPrWX8HjajlM/m8U8yguv5IcZoba6/Re57BGi9ExHgDEVFuWRmr7mRBE5uEPqBxgIMd9DHXSYtiJjypOzNMck14YWmzAhEr3tTsVminz/7OEWelUzh1s6UkqTYkuKsomEuxy3I9LNs5KkhJhGld1cK55P+Eug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LviI4Potc1GrYbiU8zxZq227MFdPF+DpjrbJy5FOn7I=;
 b=kRWCopDpFM7s+v/rhcDTFZ9f6UFz/5tv96/qjYgfUn+MWcqYfo6MnA7+KxO1oV9uqHPVt21Vbqo9DitJ7fJHffzBIvpgMLBgHoqR+Ijbtf6o4jiOcvIsmskOm4KA5EHQHtBhqXO2//6DwURbE4Ws6SQjjlyrqXzRKBSnYhhA5ML8t2O7N5VMVo2MWQ6cI8T7adllO9+8b30E/OGmFeKX7alTh1KGXPu4BAjDXpFxLOTQ0ByVYfp7L19TjiJRCsA9d1PyAplJanojvUQ6zcMjGZ/Jv3P4R2k1ujYcYS9iojhxH7DpvRIa9fsosxTpg8pjeX4XZGkeLq28GR+yONSRdA==
Received: from BL0PR01CA0036.prod.exchangelabs.com (2603:10b6:208:71::49) by
 IA0PR12MB8647.namprd12.prod.outlook.com (2603:10b6:208:480::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Sun, 22 Jun 2025 17:22:45 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::79) by BL0PR01CA0036.outlook.office365.com
 (2603:10b6:208:71::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sun,
 22 Jun 2025 17:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:22:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:22:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:22:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:22:39 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v2 1/8] net/mlx5: HWS, remove unused create_dest_array parameter
Date: Sun, 22 Jun 2025 20:22:19 +0300
Message-ID: <20250622172226.4174-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250622172226.4174-1-mbloch@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA0PR12MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 132360cb-ac25-45e5-b070-08ddb1b166dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFss2Qh44vv4mcvfHZDY3ITg5iHNuLwSRfYbUM169MNPU/2/QvyBXrb2Ha9E?=
 =?us-ascii?Q?5jGhIeRJj6T0BemhQwBuG7xXz+GRKkLpSUHnDuAA7wNCR0LTFE+Kd7dcfG0Z?=
 =?us-ascii?Q?CyyvqTARSO3s+cTWMSdN02u2ij04T3qki833OTe1r/utKYGADZshm46+Fst3?=
 =?us-ascii?Q?nTm4ufiOBKDnaHMoCe6mVBWI7CeqNss8IBdn8VQQCFcl43wyEG38v5ehaBrx?=
 =?us-ascii?Q?nxbWa27tnGU4jETUXNaQExNNNxb+8A+UAzh9sZuI5d5bZvKMDXL9e+/sAklT?=
 =?us-ascii?Q?8HlhJpvx7ggEb5qsAM7RxnUKLQnRT/tPjcOLhaBM3hPuPC/G6MI0vc7ad8ME?=
 =?us-ascii?Q?iMOgHOZ5BaAe7V9gpGpqlTzcNuqxgNR0HSSdY1lD1qW1vx6dZ++PUc2QTL9p?=
 =?us-ascii?Q?c6cTQSt0n3ZOPZC/cAAR2Ri+eBlXwmmCK25Hh4MLiwPjcXg9jzUKqqQsUQW5?=
 =?us-ascii?Q?hXucG7VIovRSn3xpGoSCmR41EoaynChYNF7jyDj48A0vKEWJwPevRBfvizNn?=
 =?us-ascii?Q?181n/fDT6xeSEPzPowhY0uDtdKkCU5xY3apOE+VREAWSLCFnhGohFBbep8FQ?=
 =?us-ascii?Q?6kre7FSsypcdEiCorzRhCADVvn65Y++lm1CByiTvq7+UxZ5L0VpVDZRsUZqt?=
 =?us-ascii?Q?00arExmF1IBNj1+Qhv2gXGJeGciAv+pNeH1dd3jpCSNvwIbJN5r/ebARP5XS?=
 =?us-ascii?Q?WWn66GaFT/A3PU9EMq13lSrRGymSwSUAW7ahLU3slmLOYvkCu7A89uPGFRWP?=
 =?us-ascii?Q?zzpGeShpKRkkXIoU6OkAC2TlNyHlhuerQvpiL1Z4Nec098E91+i/Qmm/ni+j?=
 =?us-ascii?Q?9NT18+qJUXu++HTVDrCBCN2WNFP3Hn5GhNFw+tFDLTtMaGb7EePK6atyErvQ?=
 =?us-ascii?Q?3s9h+F0C5hoV8LzRfs2CGIrZ6SBCMs7b3jSx26eash9ghsotfjO9b8fVhmNp?=
 =?us-ascii?Q?azU0jLbklomsayN7HF/ef4cH7sw/p3IztCZCTuv+Nx2CeXGJdiMSjI3wZn32?=
 =?us-ascii?Q?CHwywA760uXgIO9PdAE91j5t8CEhXYdeCriBQk+hJoGAkAR4We9kwTX1U9K8?=
 =?us-ascii?Q?kbDsu+DhcdH62YncF5WCZ9OXdBokKE4lCDn+wZrZSMFzJ8ObFbInu1ggcSSg?=
 =?us-ascii?Q?MD+LrOfAP9h+EXMmmPPASbn1T4nPNmntd1XokimBYQAmZcRa3+OHCAFsOWlj?=
 =?us-ascii?Q?KOG0Vs9dBLsKVBoGJtTNJ3TTml/g637KOGHSh/FhVRGIkiqvcRnPO2r/DLqc?=
 =?us-ascii?Q?3DPHyQvCcmI/150HpPDCz5wBzHIQjlB+VYvZNb9+cgY37qiBHHVKHJs20X+t?=
 =?us-ascii?Q?JmuuP08oy9e69XwakqsFq9u5hGYabyMk2TK3fCUSwWXFRRFnyXtiVxTJWDe0?=
 =?us-ascii?Q?ZBgMsoVE9YcoRZeqLQFpfEaB9z1Oy6u+eVNUuviRWoqGsH3o4l4v9dDz26Ag?=
 =?us-ascii?Q?v3escX3TK9KucDct5WbDjXqNDEjGsS4tgmz/vsUeq1qKHQZeToOO8JdM2cF2?=
 =?us-ascii?Q?pHsa/WuzcjnWQ3i5NPV996HvquihE4Glxjep?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:22:44.7498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 132360cb-ac25-45e5-b070-08ddb1b166dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8647

From: Vlad Dogaru <vdogaru@nvidia.com>

`flow_source` is not used anywhere in mlx5hws_action_create_dest_array.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c      |  7 ++-----
 .../mellanox/mlx5/core/steering/hws/fs_hws.c      | 15 ++++++---------
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h     |  8 ++------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 447ea3f8722c..396804369b00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1358,12 +1358,9 @@ mlx5hws_action_create_modify_header(struct mlx5hws_context *ctx,
 }
 
 struct mlx5hws_action *
-mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
-				 size_t num_dest,
+mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				 struct mlx5hws_action_dest_attr *dests,
-				 bool ignore_flow_level,
-				 u32 flow_source,
-				 u32 flags)
+				 bool ignore_flow_level, u32 flags)
 {
 	struct mlx5hws_cmd_set_fte_dest *dest_list = NULL;
 	struct mlx5hws_cmd_ft_create_attr ft_attr = {0};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index bf4643d0ce17..57592b92e24b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -571,14 +571,12 @@ static void mlx5_fs_put_dest_action_sampler(struct mlx5_fs_hws_context *fs_ctx,
 static struct mlx5hws_action *
 mlx5_fs_create_action_dest_array(struct mlx5hws_context *ctx,
 				 struct mlx5hws_action_dest_attr *dests,
-				 u32 num_of_dests, bool ignore_flow_level,
-				 u32 flow_source)
+				 u32 num_of_dests, bool ignore_flow_level)
 {
 	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
 
 	return mlx5hws_action_create_dest_array(ctx, num_of_dests, dests,
-						ignore_flow_level,
-						flow_source, flags);
+						ignore_flow_level, flags);
 }
 
 static struct mlx5hws_action *
@@ -1015,7 +1013,6 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 		}
 		(*ractions)[num_actions++].action = dest_actions->dest;
 	} else if (num_dest_actions > 1) {
-		u32 flow_source = fte->act_dests.flow_context.flow_source;
 		bool ignore_flow_level;
 
 		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
@@ -1025,10 +1022,10 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 		}
 		ignore_flow_level =
 			!!(fte_action->flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
-		tmp_action = mlx5_fs_create_action_dest_array(ctx, dest_actions,
-							      num_dest_actions,
-							      ignore_flow_level,
-							      flow_source);
+		tmp_action =
+			mlx5_fs_create_action_dest_array(ctx, dest_actions,
+							 num_dest_actions,
+							 ignore_flow_level);
 		if (!tmp_action) {
 			err = -EOPNOTSUPP;
 			goto free_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index d8ac6c196211..a1295a311b70 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -727,18 +727,14 @@ mlx5hws_action_create_push_vlan(struct mlx5hws_context *ctx, u32 flags);
  * @dests: The destination array. Each contains a destination action and can
  *	   have additional actions.
  * @ignore_flow_level: Whether to turn on 'ignore_flow_level' for this dest.
- * @flow_source: Source port of the traffic for this actions.
  * @flags: Action creation flags (enum mlx5hws_action_flags).
  *
  * Return: pointer to mlx5hws_action on success NULL otherwise.
  */
 struct mlx5hws_action *
-mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
-				 size_t num_dest,
+mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				 struct mlx5hws_action_dest_attr *dests,
-				 bool ignore_flow_level,
-				 u32 flow_source,
-				 u32 flags);
+				 bool ignore_flow_level, u32 flags);
 
 /**
  * mlx5hws_action_create_insert_header - Create insert header action.
-- 
2.34.1


