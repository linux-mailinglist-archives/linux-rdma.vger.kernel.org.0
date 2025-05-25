Return-Path: <linux-rdma+bounces-10686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B06AC3423
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFBA177292
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5391F4625;
	Sun, 25 May 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NKSallNj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337581F4192;
	Sun, 25 May 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171767; cv=fail; b=if39wdQErP2ffa89Ohu8s1d69PsUOM5tu3zLViDrirzeTG+Aip4wcBl+ZVryx6uEjNWJ3U+AV+e2GKog4ZVdlRe26q8aFBLoGi1qxgM0OUfNrX914HO2K9F2+KNAmHkz0Teepz0bHgI9i+cuVezKQyi89VmafedeikNga+b2T6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171767; c=relaxed/simple;
	bh=jJwpBTEeH7eDBO/zjbw7JJdFRsZZxb/EKb796iRDyco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwvgqybfL+yUwqfRT+QfAR7d3lAHH6o/tqFC/4R9OMj28sz6FZXVeyCKzpnD9F5H+cagqRtTKU9oFaIv7lW55Y8sBL1/sQGOd2Gkrq5sfYDIlY2x9WmvcwJnNzU6/K37mVfQweCcePgRdLThQBbEVs1ZtfOs5k/L0GnxqmWl9Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NKSallNj; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uju6e8nGXZIz2xVOjNR2o/z8n+YZ7/Kf3YKO3paqNsWj2xnGCFg5insdIKJvUV6VM07Nh5p1QzcQBCg8cpmljhS+Fe5h+6t7zrdyueF/Oxbn+leXigWSpC5fy9dop+3zakoPMRVwF9vo/tB/ZsXJoQWUMnbIKRp4YEsMe8KriG37d21VekVVXuvCq/yKIelQaRRw1C7QsreXwMVBtSvvHNyC1b1OmnjO9VsZAFRyueusPdq5FKSuaFOZ2OlDM234yYM5CAbTNZUkx5jCOcFKSn988DjmhEWZstEAWXwYf7Jr5h5WFFH/JVdIquIiVCVopt3lH5Bxs9G8GdqsHS9qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syU71rpyRW9NjFFsz3CcLcN00vHZQIF7Xe7AwGhaaEc=;
 b=xbVBdVcnpxPN5sHZ51mKOjykCOWwYONedZAgE8WPUDwaRsEVzSGXx9ojxdoYW/+1Cwkvp5uNR/KgljvEWdtR0yUYihfQLXYbPq7D87teu4dP+Ave+KLR6aQjCsseD8xT+x+wGPr6MiJ9iyKWUegHkc6S5sxqd0LsRAGvCNW1HvZ0cmECs0/61gZyqzkrvGVnRLyoraxtDtB49ftXKaIenQZnmQ+IqnMJTTdLvzCKb25pufduuq2nWZyLzmk0uQw4btQ2YCl2JTPX4I+mG04lR/rQ4s+kR+LFGfH/DWupO6e/gUIEoCKuUgE83117F5lGzv487v7PUwQwiAR//ZFxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syU71rpyRW9NjFFsz3CcLcN00vHZQIF7Xe7AwGhaaEc=;
 b=NKSallNjDj48UgUuaXqWLd5z2qxi7RTDqKy2oYbo5Cgqd5n0CvXgUx5We7OTufHdsNiWBlSsL0/U4BbCVI3V0jTeGo7kgLJrUmaQ0dsaXHzCyYzXi7iSWiV1NjjttHKLuXufY7YfFlk4dvtgw5nZzhlZMseN8L5Wa98hmopeMgVyHi5eF0q0VG0ky8+34V2XaszCstcShWuC0Yj6/E/xjXsJcD7LBFrgp9Bi7NhnSIR4lL88ArFWokHRwy5VzXTykPZSCR+xXQ8xLeenBEsZGmUpHvjzPJIl1UDYHoA6FyEXB1ApFMvBVYem3n7WkYWRt3wwxbkPtAOlZidOCuDmLg==
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 11:16:00 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::7c) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Sun,
 25 May 2025 11:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:16:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:15:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:15:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:15:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 3/4] net/mlx5: HWS, remove unused create_dest_array parameter
Date: Sun, 25 May 2025 14:15:09 +0300
Message-ID: <1748171710-1375837-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: 15dd2f78-3412-4b02-d472-08dd9b7d87a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UtOn6BlWdW/JCnCYt7qeV1MvcX3GFhDtW2udl6NjsRkbjEBmks+N9sI2HgMM?=
 =?us-ascii?Q?TTWiLbgtvRKuTRrN27rVP+4zdBXkW9Wghf+ZS65v+NIE/jfkGobYCJ873x4P?=
 =?us-ascii?Q?5nefGAae/X8LZFJCctXI3WaU39JEKwhXYume56AJqEoNAmPEYCw9shK61R0Y?=
 =?us-ascii?Q?OWZFP5DMaTyNc1N/LMp0j7AgtlSNvRAMwUfyh1VB5Tb0CtoxfKCEoueOSZBL?=
 =?us-ascii?Q?Asv0Tm6gS16k8qyHyuGkObPlwKeBFiTFV0/3oLgEHVUu8CYjIlre8Ml3H8UA?=
 =?us-ascii?Q?9v+7FffRnfCRl1I1yhyErX9tIrryzIDh4GU0OF7lQyvmb3R+mIITWxTOkr/v?=
 =?us-ascii?Q?TEP6aqfTRYmuQbxZ6cZpkM+LgDLDUfFzrkWnspfk33/3dDH3tNM2HmDwdtBj?=
 =?us-ascii?Q?v75gCjOchrn4BeRiRgLxEj+hNZPFoHRzzgwdIFIBSDF0vi9mT+sR68mmqkAL?=
 =?us-ascii?Q?BxYW0IkdtGyCcNjHcQ71GaRTvommLJTrtab6Mrj6DzkDbRcZVHO1JwDDI1j1?=
 =?us-ascii?Q?Ce7NS9jLrkzgnzOiWaBIcZE/tsGi3X3KSXWmtYnRpGuqLXyHFLKsMd95AB9k?=
 =?us-ascii?Q?NI3ngI8c4h76rmUtamakg+iLP2jxTy4ezkynmPyw1hfGABfgfCEy2Vl7CnFA?=
 =?us-ascii?Q?+UDByf4E/UbAYJH7S63/hNtt+EP9QQXx/+HipAL6QZBpzKWB8spV07vDvBc7?=
 =?us-ascii?Q?/HAcmA6zOGWKOG30gKlxeyWtKB0ZRwhLLc/5jTJ+TtRAH9Pbx0JntbEOvWU8?=
 =?us-ascii?Q?xjjAEsNtsoKsA8Hv/5RJey0QVk+Mh4P4tQzlb34/SkbtoPgk+p97QiWm+Zo/?=
 =?us-ascii?Q?ogzyKvc8BxJcmcp8sCYzmVwK2wEVa2U6ruD1h2dksGYaNzaZQNGdCWLfSvao?=
 =?us-ascii?Q?SVW3gFkx8ekXltyydzk161HH01yQ+Syrtu0hR8KDo8BDAwzXB5T9iEgs9DIl?=
 =?us-ascii?Q?hvdVl8qZ5RvMcTfwbqDdAyOMtD3rclqH3ZgkL4XwgjYmqZt2AFCCKvfE9Jz6?=
 =?us-ascii?Q?FkS/LNGciAhP7ZSPvXGVLqzBr7m5dgVRIXlfk8fEVb7vJul9xTXdYQfQCqM3?=
 =?us-ascii?Q?vo7Jf/INX4c42ArLd7wz/zPSQekaKX1qc3gZSTuBDN9sy4exzPCNgBvBbyeP?=
 =?us-ascii?Q?d0OaTsJRvEGhh/2lVy8ogIYMxiaM7zpobVgazUo4x+nMfB/m0dqFofHhyM5k?=
 =?us-ascii?Q?6HB/N/LPwmhACJHQkEV7eKGye+jRJmzmCa9nrePmfSIs45djOLtsMclP54nN?=
 =?us-ascii?Q?eCPsWeM8M9tNzXuHpZmDSD/fhbSu8Ojpp+lBprSrpXYdzMcGB8joy2bzPW6q?=
 =?us-ascii?Q?6O4lWaUrfVVL7RgaZ0py6AX6g3h8TIDuQtPj24l58WfHw4u1nAXVBc5XgYn+?=
 =?us-ascii?Q?Cb7YylFL236gd4b9Pe7jq44Qfp4HY5yeqE5/9DTa3RspeEOcVl0bxL7LsVuZ?=
 =?us-ascii?Q?NhN3QjAgA8uozzqZ5vsDALvSrhQu0gyEZV3Emu/4eQfmau3BnAfRxc6F5A6z?=
 =?us-ascii?Q?JFEU56WpZ8jhD604AalPxDlAWb95qMMDooEL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:16:00.2975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dd2f78-3412-4b02-d472-08dd9b7d87a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

From: Vlad Dogaru <vdogaru@nvidia.com>

`flow_source` is not used anywhere in mlx5hws_action_create_dest_array.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c      |  7 ++-----
 .../mellanox/mlx5/core/steering/hws/fs_hws.c      | 15 ++++++---------
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h     |  8 ++------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 592f3a2ede2e..106dc416beec 100644
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
index ab1a4c7f1813..eb7802bec615 100644
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
2.31.1


