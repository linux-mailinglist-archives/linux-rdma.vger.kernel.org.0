Return-Path: <linux-rdma+bounces-11881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F65AF80EA
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 20:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADEE189029B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4FE2F7CE6;
	Thu,  3 Jul 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eU/ACRGQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA242F6FAB;
	Thu,  3 Jul 2025 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568989; cv=fail; b=hyHO4Ft7/XvALG8Xz36ek5EulEhIXOvv5g8EkXWI+TMG4VvQBt41pgCS6lrmX6ph1CreAPAnx+GJTDzETW0oiKK/TXqOchokQeZucSedsWEq2HryllN9qPwvmJmxsxMrl487iU0lMRSwc4kKWMTG31ksg2oOxxALQgDEwslvIIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568989; c=relaxed/simple;
	bh=lbYMLBRbLSAovgaDxSQd7+zUlk9xghYC76dCYG2/t7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYBJfX7ZbT4tIOFeJ4Au/azR/KMoez3zsa3D/48M5T2P66w0LzSy8sNOtk1g7ob6Lfzp9AA7osFMJWQq5NWHCgfAZytPBZ4Md+Fj7c5JwtTrxZTR6BWiTNF3zbrh353HBm/HeuY1P1k1lsKIiPoyQgkey8ox6qBrJqFMJ31aOks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eU/ACRGQ; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcFtUjKMAAn0uBu0qBUbvs/dloKUhHTI14ReWGhi4UyduAr8EluUAaEY/roW+Pb/1dmOe3wzFHs6NiaOyHxBF0hW2P4QcyTVYONxBWGmfSAymlyZo4naWhIythZO5OZi6ZBIWdA8v/dbRtsa3nHs+4ZcW+WL51RVmoqFzjlD0bpwSmFMMfQffvl/qwVOO6LOEIWK4MZusktaiGD/xRIB4+BfZ8e8QS8hZJL2HxHE7S3JVz9+VgFlcVJWZggSv8kLtcD0wPMjwOIBTICg6M849cj92nIsL3wWwrVYtXYonrQ1Dtvx+wumRYqeWAZru8WaP3Y3WFfNEQMtdwGiM2zcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3iAq3rK5buI5vjuQnLCZFV1VT3EgnXQhCTGXBSoJUY=;
 b=A35BNkZRo1pdhQQIu3ie76NEgdELPXnsrS9zOH2lRRkhIInr1D4i/EmVtDQPTNoGxj9M2rXLWI0VNRD8nNwzGY58kB2/rG7d6ubEPBMoNYJqXZDJofc48R2VeWvVqNjxyv9eOOiv0ftA8dW/Ytisxp1Omh6ro4I+OH9nkKwYVObKepHutPdaH5NQn86jBN4n2TGcmPNBYm0JQXgKbRo1PqH7NA68X6VLfhiVg/W7aNNmE3DsMxZivrNRsaswOC1O8RUq3MEOoo/DAJI6WFJNIXV0oVjb5eJPrpMi0v94LVqTKp6F7oSKrrCRRcgno3vrGld4zF2CYCfvkspu1FRb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3iAq3rK5buI5vjuQnLCZFV1VT3EgnXQhCTGXBSoJUY=;
 b=eU/ACRGQ6OASwfwKI2evB3uQyJj9wDzZHIeHovPEmIs732BwwJxfw8xWcGNUVpdhIvjUi6b15cx5kNorZWQP/WGLIhIIM3RILZBU5TinH7E9/WDJQ3SHdFU4dh0XvmLK+tz0pVpmh8WL3KhAsrvhXp4OD+Lp2QbaPI3jzYnZ0qkhyhGmRVrkUOntOvjIwdCz9TsU2APpiQHA8BsBL3yBCv5QRlHv1huDPPDQDAw5vI8unAACdMW4nTmXl732jo4zMXha9LuSFx9CMQOmB7mKsDhKHyXZ/HBjf/HXO4qEXCgYjm2R0f6WZF1FFnHDhonp+xzjxsaiesx5xOyeM/ZvJg==
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 3 Jul
 2025 18:56:22 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::13) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 18:56:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:00 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 01/10] net/mlx5: HWS, remove unused create_dest_array parameter
Date: Thu, 3 Jul 2025 21:54:22 +0300
Message-ID: <20250703185431.445571-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: a5753255-dabc-4899-6b91-08ddba634d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vq3isJQGS/IFXUyp9txcB8wsX7mQWvdwaEZwkh0kskwBcQ52pYxFD1uh9Ldu?=
 =?us-ascii?Q?6eMIUYjxk+DsaJs34Sf6oIRDWaNhYaktnx8liad8Y6cFRMvNac14Mj+BvVSi?=
 =?us-ascii?Q?WxQ6qBGYA43xuvOd5VulwJaIxDa7KFVIZg24HRqMnM2MQz2hy62tmotGx8VO?=
 =?us-ascii?Q?G+uY+C4rn9UXzMBAj4f8HwGCEJ5aPdESAGANN4Cchsztone/W0s2CCj0qdsv?=
 =?us-ascii?Q?FAr25llj7Z++hpcKymwk5R9DQYbJqLDj5xYVaBQOV0RPL3aQiL86NgJmg29M?=
 =?us-ascii?Q?wgzsS2lbEPOCJ0dayHVB8d5nrDLyMpOyU4H4cosNoCc36ed+KTyeqMD/Gk4G?=
 =?us-ascii?Q?RYQvzJOY1RjrPRJV2gBy33TM4EJN9T5K6Gpw6qHlDuWaOtkZfkfNPaqLGeNy?=
 =?us-ascii?Q?R4LRS4w6HKIeihXS0DBPzIzKxtm3QT8avwIgr81jtL2PbQjRtp1kfGhyKpGI?=
 =?us-ascii?Q?WlZAeAo6zNK6P4F1pY3N7jkF7vebkLoWDy84aORI1HH9zGZBEHOVDGRJWj9+?=
 =?us-ascii?Q?iolqiFem9Qrm0nsAmQGFrOc+UtJ6NcaB85cCY7cikSo8sB9CEvHnTqeIS9zH?=
 =?us-ascii?Q?atRPBiVw3yfz5aTZtP2dtqrLC753PgxfiZ4mo+G+W/HpqvtRDGy0fnFCic+e?=
 =?us-ascii?Q?hr0rNMEW80M57Y8Uz2r3jRorgVQ3cpmcjPxkA3mdeB2vVN42f1LExNyOCUap?=
 =?us-ascii?Q?VK45USNNAYvMvBgEK7akYRdVcZegL0zwNjWlj0uCdaB76fIm3v/mhiKM/UdC?=
 =?us-ascii?Q?9QE8/kPgJC35u8cqaTS2Iq5nsiqNqOg94mKg3AEi+lzGWtjTOVRDGYYPmO9J?=
 =?us-ascii?Q?YipTu77fby942TrYOQlvOWi4tChlFQCMAvrTjp63Ivu5VL1Mr4q34pkZvFZp?=
 =?us-ascii?Q?l9MffVKMcs/Chqpulw38yTyQNHtMBn10KVICORi7EVoKqISnk0DIEE3irjYQ?=
 =?us-ascii?Q?xjWvmxMc5Gz4oPmmLjF2iDekV9XbNU1RYMfNcYVMjMMkGVwXGwyYAEsj0YfG?=
 =?us-ascii?Q?fkbngiW09mhZI7x9CQ9kikqBxJ/IUWTHETlKYER7JvWGLeN11l0WeuUIGP36?=
 =?us-ascii?Q?KhhQ0hcDLJ6fN4togus5/3KFPdkOrsjZvuUQeBRsyDffcQHiMPvmb4Je/gRR?=
 =?us-ascii?Q?2xpOR+etuqojEfpNO8R5JUT8l9Wd1ALC8YTB9cosw0g86A4GqP9EHyRC8maG?=
 =?us-ascii?Q?c/8p5FQYbILnC6tp7Z87vLpyshVFgWtaPDj/Ty0/oBXp1QxxQG0+lf0S3sv4?=
 =?us-ascii?Q?Bcgx/AfY5/wGCeGKaSwddHIAhuBrt1Z+oKM/MGxteNwZaVm5g5QJWVj/PwCE?=
 =?us-ascii?Q?tjUcT3nX8hD8BSBqLaeQfO4tyKJ/RLS2gRhC1sbEMpQloBa8OoLXkd4tV2a3?=
 =?us-ascii?Q?4UH5VqKnZWOrOGM5S10VL1LkelsSNDBUXGNoIPgO0KjJskDrUocdj5Ll+uJn?=
 =?us-ascii?Q?cdCuYzRind20Iws9FXcxKOWvtj8GlbpKoqMB8YbbWmla0OI9tPi5AE9t1QW4?=
 =?us-ascii?Q?EEOV2w9Ybwnd5dmdAogQVw6tk9+E3GODycoT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:21.8743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5753255-dabc-4899-6b91-08ddba634d7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094

From: Vlad Dogaru <vdogaru@nvidia.com>

`flow_source` is not used anywhere in mlx5hws_action_create_dest_array.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


