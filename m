Return-Path: <linux-rdma+bounces-11456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE6AE046D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82733178780
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3621C23771C;
	Thu, 19 Jun 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KK3Htkig"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15F230BEC;
	Thu, 19 Jun 2025 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334144; cv=fail; b=NZ9DZ340leWRGVkE6EB/GKZ5VPoP65yEnShUzzsbndIa+3vHra7qQRmjWI//U7/rdtbP7KcCWsAQBzHqCG5htYlJn8ZBqWlyO/WNCJMDVit8qwYFWLcvfi+f8rbVX4ZkpVgAYHq6TD1RjKQziGVb61wcOIqX9AH/J9GLgyk7shk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334144; c=relaxed/simple;
	bh=dS90vfcUrBPDeJrxOypfVyYlYvv+VLeWO2L7ZVcxrJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr2Vn81cRzF1skOigqNmVDxnipoEYFYFzveOYvl2ocgq3VR738wA6OPAV1RMUggTbQ21QBTEQQn5RuEbvEkW+yjU6kTXvxaRSQRHPpDwFH5tdk9Nrtar6Y1st9FaoxOuPa6ZAkQpbsqRYsPBY7kDRl+ZTu49XX/e6w6ngKvyasE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KK3Htkig; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAHmlsiVY9GbWYAbj7hvSnTtY0B1XxEPXOmkmGgoqmzNSGWk53q3N/BJt1omtHhEQwIhVqEGPRiWvEG+MPDOMKoRb5p4RW65SxHqFyZ6QKt/OCp7F0/xSSnb6DniGOU44dNxdxNn3x+vWwFSTFGx9WfmuqcVlBYYIga+PwIhVqMq2dK1af8MIMEAE8zpzZxNYfImY9nKdtxVkqqVxC6Dbj0PsNhuLhBuWE3vTCdE1mbQ8ZiWZvLBo9yzcrFLsiqfTAZ6DSfzCsRsKogIEsnFvk+cmXYvM4UqK8HZRR7mCddVZQqUhFTkrizurY1ar2KfTG1tRwYAI3cSnYkRgk9joQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LviI4Potc1GrYbiU8zxZq227MFdPF+DpjrbJy5FOn7I=;
 b=Ymz9p6AaqFtacu3jjAikpTqUGkxC/JeQvM0RVo9/eHBDXQoCi9FEKPNRCnsbGG9QIPR1KtMEUnHqS99xKthMFt30gGkgo3xQkcnZkXcqfaZ+/4LhXadbEeMC2dLq1aoEPQn8aa3PH2ygbEqgmjXOImPm1sErdpdtRHsRgg8TW8GSngBmcoEcG99F9dj6s3pDnzJ+KUpk7ULdf/tQwHF44RjQ6owC+78XODXRYLOGeFmtxEfC505XTdUJOy7Ase8YFnAIeX1JkuWn8Fbt1YOI442jj+kzbHV3TPpYd5sXkaUE0PFFEpENz8cFmvPL82X/RXHSwIhjkgP2PlTNhVNwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LviI4Potc1GrYbiU8zxZq227MFdPF+DpjrbJy5FOn7I=;
 b=KK3HtkigzyNfeGvdOqWR8P/S0WXgEuVEcwHLn7X2fOU7IR7tV8XrN9n+rp0nY18zBKTC3qO3zlbREGNMI9Du+yZV6lnfQsclOmlz6OO+CLwrwOii/4OJ95HJI4AoYX+o53C2LEVI/fpmx7OR90U5Snd46wITblt1oXhVo8UzpDWjsQYq9f+VbRMXZ1MAFesVEsyaFokJ0Mp1k5cUJ5Lt6LOjWKgUFGPmONLgtoTSBIssIH61N1wa+LoqiFemqLwFSUZxOBQlF+2z59wQKjDsmyJ23ebeeve4mXBZmju9Gcfxc/avl4KCyUkvkBEZTqeiBwoUCe4fBXfK9ravLfevmQ==
Received: from BY5PR20CA0028.namprd20.prod.outlook.com (2603:10b6:a03:1f4::41)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 11:55:38 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::38) by BY5PR20CA0028.outlook.office365.com
 (2603:10b6:a03:1f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Thu,
 19 Jun 2025 11:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:55:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:28 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 1/8] net/mlx5: HWS, remove unused create_dest_array parameter
Date: Thu, 19 Jun 2025 14:55:15 +0300
Message-ID: <20250619115522.68469-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9d1490-cba2-4844-3a8c-08ddaf283512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2vN81jmYQPC6ivxHBFy84P71f7o3ggi5g4UkLZJ4kF/sGUQu6ssZZm/5U9t4?=
 =?us-ascii?Q?ZQ+qJcwUK5ZTxvPzjSo5EzrSre5IfjjPur4HtCCvlzJIKrmIOZIPlIzO3P2t?=
 =?us-ascii?Q?Qv6h7kIDxYtGfuLIIWoSXCdLW92Op3bgHr99jCq56CUDeFKwyua/IgnvCH73?=
 =?us-ascii?Q?LobBpE++egTOvwJfauFK/ViZ8Dx2Ip4ffUrM3PK8fs+WF5fkeR6bqjL3Eqb6?=
 =?us-ascii?Q?mIIuYqrV5OQTmXvWmpa2qNu59f7SQ/zAcd+qvzpb+ZxrJBYwvhKwXLsANKYO?=
 =?us-ascii?Q?m6sxvA4+Nb4OBvxTwEi0Us57OuY38JI8UFQc1bfXY4zZJLG/aOiH1d1++eij?=
 =?us-ascii?Q?avDLwqLbNri/iN90OTH/0dl38rX6d+SGGgX90+uabAXMexC3nkSwVqr2fSMb?=
 =?us-ascii?Q?DQrG4aPNd/Kh07dstelxPE5v9OWLfkB5ETqjaqHU7A5DqCKaxEi24TpOsLVd?=
 =?us-ascii?Q?XP8kGZ+LU71r01kyYuEJFkHMNbAZLMUyx0QJJD6Y97JX1ruACA3K4wRpVNFb?=
 =?us-ascii?Q?1rzRclZcw3KzKxZ2/tAfrDFcd9UzjAhzm1iWO3vggtAR6n2DeRTyK3Mu+HAd?=
 =?us-ascii?Q?baKkjvHY5s8Gve3svLDxg7jL+SBNUT/Mf6Xoz+sAKy/0ATdKYrLkFpDauZRY?=
 =?us-ascii?Q?PumYMdvT5TSN6+Y6wsRAiuRDMOXTvlyhD9rIsRhvNU0UhTEei6GhX38ltZCS?=
 =?us-ascii?Q?YozosjsSA/+oZ4R9vlkIxDXKhfuj13fqNiZDYFpMolmKH/xycb+G7v8PC3xt?=
 =?us-ascii?Q?r+Eb1CdV1v83qZbM/nk8KXpO7eto6eF+hxqiBGLnPsmjYDsF3b9rPnxnCGUd?=
 =?us-ascii?Q?DWyeKaBu18UCg+gGHhigzhxPpUIxmkkAoUN5/WlsxcPBy9BwUn+NbKr2cTPc?=
 =?us-ascii?Q?t8pm4fMBblQbl2r/tBOMUkhaGoQ/bxWdlPh/4VAakRvtAN0ylrXiMuipZHKC?=
 =?us-ascii?Q?Tcv/nlLnOrXMkyMdGicpX3QabutfHjXuZdD+cDA5bYG4cHnRvdyjY+6wjqtu?=
 =?us-ascii?Q?evmKRNmNKUPefJj6V1SWFRnuQTIiM/xujgtMC0OTeIVRDlDINRqOMY+SduxZ?=
 =?us-ascii?Q?bZXR0mL2pnonv2PhSnPcfuGbj48U1DTcnG5eb72y+3g91zCpXQd/O15FdOsL?=
 =?us-ascii?Q?SqJR4/9r1i+MAtrluwkopT4fkYwTk2Tx1f6cxYmBgOCNPsDc33HoMdjuLmZQ?=
 =?us-ascii?Q?c9Sp7EkpDZwplS2ujz9rIs7O9lWHnwGIrt/s7RlRyMkOF8vd5s2tgyhDgBjV?=
 =?us-ascii?Q?s6cQGUdVAYcdCYM3HIRe6cKo19/3v9yawMKnliMg894/m3rfN0QMwP2oAuK6?=
 =?us-ascii?Q?Ed4J/xP+qhwxzsDUuOhgNhY7j4RDai9W+GZrwXCE2eTRCDMzx5amyQWFUMv7?=
 =?us-ascii?Q?1zZXsxxTW8UXjxfbn+LXmpb6obLgDl+AJlSDUPHKk58rMrZdl4E3PIW45be4?=
 =?us-ascii?Q?o5debmmIwkhNDR8ZFSl0iULw7Oo3Gq3d9kwCXTH5Oa061GvPEnljVfGUs37T?=
 =?us-ascii?Q?XrfNiTbYqO8AWGcfK8HyQ66/kfSkc5pLvRUD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:55:38.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9d1490-cba2-4844-3a8c-08ddaf283512
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393

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


