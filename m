Return-Path: <linux-rdma+bounces-8517-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A7CA586D8
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 19:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710591889DDD
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EA20296B;
	Sun,  9 Mar 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wgtw3jX3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD091F875A;
	Sun,  9 Mar 2025 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543709; cv=fail; b=sBQtY7i9Z4WkEVcYt/uC1GO+/bSKZjgyO3ZL1wEp38GEl+/QiO1tE6FgVNjj54B8tjDixRPHhBrWhZN7c4sw+EKGv8Jw5NC+22L6XKXCqLXvjBp8YSx9U0SXVyKz95tmRlV0RMCZ52rygBglooc5xkaGtKH4k5pCP97nhIHqQYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543709; c=relaxed/simple;
	bh=Nixf72nfNd4giyOUxIUAJgGCr3rG1PhA2dPqSQ1/5XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haTRHod/KcFg/MmRhEQOhbWeBGkit1g9ZeJNobygaiH1/fzFUNhWxWnqQiyLQc8kFQ2EhMx7SVSM97QkxRs1N0AlVPrYF3pyi4WRDxAv7XD98VUYZ2nyYWVP4rv3kb/KnRTkRMPD/ueuaiuDLZKKyqQv8taqavh6kbU6m59te6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wgtw3jX3; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMsQuZOlvRTlbFu2kFDoiOAfAAHpBqw3Ed70GjrV2ThKJddkPlxJw4nPXsojTXh6Q9ec5kFgewSvwSHX/jEywkHhPT3rKxTFwvxudIMw0ogxY/uRH1hBrmDS1BfrYtbYGN6SMoAIF/oABt9ji3p6df9wVh6wWEu402ihtLRcWWcJszzAEuz2X5gpCGda+vkTkFP3Pa3XXxA9q5ozORV5Xctwy4ImiJBj3FeT/b37Sqk2XNhd1+ACfElw8NUlWiYLxPpxC6ESZi1XglQro5gycx1kV7UEFaJGxwuCAoN2FpdJYsC7v0qaOnGGtjGggzmLjkUE5cNVYqyeolSz6Jqzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8p7HggcwcR9CC8w5c0JPVzof3ihTrhPKE5bKTSn1I4=;
 b=s+NTkLFK9r5rUfL64E/j8RCHC4OdmvHRxYrB0M7xNMqn8EM+LrFFIPrC2jJZ2YQflyjYSv8uVMUZQTYy2yzWaTX2mn80SPdABbdNVnl3646NTrbzZB3yYuWVIDyAAVg3as7LjtCf8OCEJ3QQhpmoQl7/lxF0Zp83V7YW0+1c7yi93qlhezrbOYgnwFvux9zxNoS/SivlOuvxtQ2Xk4/MKU72r2yFYBkXVwnvKd9yV+uvkTrN37dUpYfQTZCY8T30496QGaUCm5fajSicFSDnE5N8sv+SCGey1BfnJjdmzaE3TRUjRa26IchHbNWqEvkMT3PL+3bV+Pylm36YHGksuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8p7HggcwcR9CC8w5c0JPVzof3ihTrhPKE5bKTSn1I4=;
 b=Wgtw3jX3kfwxuKKCk2Yk/G13JqpEe1p2DVAVrSjzX7DLMn5CqhZSd7INwWl14AwKSalwCGDPmZVuilp4mPhMrTwQIJri+AkbGJ0INotisI95Q7h3YqhGhp5VrIv9DlOu3Re5Cpj0wNI/iSaSxiHfpUuzpdYL8BWbCnbBFBhpeHFcqSjrbxM//+jHiLwDqfalvqf/e/Yq3x01R8pyjXP+q2BcPPF8QAYXaSwINHYz5aD+9B1BPoGMhwo4ZDNtv543GJ7ws2Qb0ieAp+O7LIQqTbfd1q3XloDTV634oJeeIVn8yLPChdu8oIcyf+SxscZBfKOV6D4Tg/ObYeiKqYLxoQ==
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 18:08:24 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::74) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.15 via Frontend Transport; Sun,
 9 Mar 2025 18:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Sun, 9 Mar 2025 18:08:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Mar 2025
 11:08:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Mar 2025 11:08:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Mar 2025 11:08:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/3] net/mlx5: fs, add support for dest flow sampler HWS action
Date: Sun, 9 Mar 2025 20:07:43 +0200
Message-ID: <1741543663-22123-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 45828436-4e30-4cdc-23b1-08dd5f356221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JdOkGiG4it5BZENYc7N4+AyqZVBDkppePmTkMM1byI3Sch8OjbSB7HBbR7LO?=
 =?us-ascii?Q?sDaQ1i6pGrEslEhGII1r0rjHW4IbKTXnw8irtzxV1tioVOdOLl5m9TeeCyyO?=
 =?us-ascii?Q?QDQ+gNdxg8RZWuHH4wA1zqebBPmLy9IzAUQyj/9Z0Dim6ocQjQ3nqoqikK9k?=
 =?us-ascii?Q?axQKR+n498rAMr80U/cs0Ussam9nkjH8C5DwxSZn+8BMO/KlKlMGg9jmAN9S?=
 =?us-ascii?Q?aqgSTKiGDsV4w1CwkXoGqJH/9c0vuriiTYUsbAOgi9mmCXlb8oIATByvpcrP?=
 =?us-ascii?Q?GHb7U6edwHQUCkR9ZNjWGE2vX5IxvWAVHGu2iZudKjQ/pMnLXA9hfglxjhIW?=
 =?us-ascii?Q?ntfV1omFACICGOBYV//O3Yw0+RGjYtaQjFwAN514amgfwS5omU757/iaPZ0/?=
 =?us-ascii?Q?vK0GV0mj4odstwoyNmDjKXwGRmzpQEDCeeCGle1sy1IBFgR2iql+SRRwSs3g?=
 =?us-ascii?Q?J671WadPoFvldaOKBrbVMetw93LnhZCKoyNhC8J2ODEAql1Spo8AyqkZnqLZ?=
 =?us-ascii?Q?h1yEYMyJ1e03+o/XOWkcEtC2Gijpb1xaEpHRLVtr0yxN5hjcG1lq7YtiG/6y?=
 =?us-ascii?Q?ENdPEV2eGX7XQ/Pvdd1Gk0zuznGWE7Nato8v5jHjodtwDJ83PAqqoDZ7Nnc0?=
 =?us-ascii?Q?qe07PFnCgCBAN+RjEIViFKA71IPfOBclgOAek9riBgbOF5EElMXmdhLCICQL?=
 =?us-ascii?Q?45P9AqwiwdGSwqBEw/cC1PT06D2iyQ9JlGsH84wv5mB9K0mD8wCAbrakbyzY?=
 =?us-ascii?Q?1wwFxY95d+q/o9/7LSDGIKw+pbCKKNxytkPxGS0Pss9B0e7jlMYTwAVttH4c?=
 =?us-ascii?Q?rd/f6JYLoF2Eu0t5oYdbSjSTqPfppTDh4DenEaX/P6Omd3OpFfOnuPlRJxj4?=
 =?us-ascii?Q?WomPItSd6Q6oLE6cuCYFE1bkBuMoKcYxkoSsXGEerFgoeArBvHsc5kq2RdJd?=
 =?us-ascii?Q?BKq7l08QWZNGUg/TnsskvqeMoQJQZqPmwdJp2jte6nxAHEGt6NQe/l/zJob6?=
 =?us-ascii?Q?8SdzhMqbsz92tv6JF72mT6UbtkeSN54omgrFnjCZI8q52DSoorqhO4hpHCum?=
 =?us-ascii?Q?WBTG5KjdJcalLG3rnuIXEsgL4GbfzWv4cSutmR2dFFJieWK4UlMci7884aKh?=
 =?us-ascii?Q?SV+BURnn5JpzDLbiUF1DzBluI6zZupWqUM2oeERfxMw6ns5Y1SqSAOGL2u+p?=
 =?us-ascii?Q?QqUUADhPUMGQvOk4uRSNb1+HtdqYL2JzCrJ/f0esqkgs+Ze8HS8lzo5qvfaz?=
 =?us-ascii?Q?/THJunz4LsLq6149ky9PJnF9FUPJRqxVGzqDMN3mzeGy7evHbTYmhgou1huL?=
 =?us-ascii?Q?erxYAGOMRzKm73UimhxbcMCJyccgID8i/7X4lOIurDuhB+RcOA0y2WM6/p9f?=
 =?us-ascii?Q?we/CWrfRoG+nWQjiH/tEYvZjbLg/t8za48cXyMHuWRC+YTEAH4OWwHzzB1u4?=
 =?us-ascii?Q?4Jgd+ndTrctwrfYFeqlQVyrsE4ebJtEjAGy70GKGBhhTcwY71S/KyoUrwkEn?=
 =?us-ascii?Q?yVG4Ihbza8nX0pw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 18:08:23.8691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45828436-4e30-4cdc-23b1-08dd5f356221
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

From: Moshe Shemesh <moshe@nvidia.com>

Add support for HW Steering action of flow sampler destination. For each
flow sampler created cache the hws action by sampler id as a key. Hold
refcount for each rule using the cached action.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 54 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  2 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index edf7db1e6e9c..1b787cd66e6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -67,6 +67,7 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 	xa_init(&hws_pool->vport_dests);
 	xa_init(&hws_pool->vport_vhca_dests);
 	xa_init(&hws_pool->aso_meters);
+	xa_init(&hws_pool->sample_dests);
 	return 0;
 
 cleanup_insert_hdr:
@@ -94,6 +95,9 @@ static void mlx5_fs_cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_for_each(&hws_pool->sample_dests, i, fs_hws_data)
+		kfree(fs_hws_data);
+	xa_destroy(&hws_pool->sample_dests);
 	xa_for_each(&hws_pool->aso_meters, i, fs_hws_data)
 		kfree(fs_hws_data);
 	xa_destroy(&hws_pool->aso_meters);
@@ -528,6 +532,42 @@ static void mlx5_fs_put_action_aso_meter(struct mlx5_fs_hws_context *fs_ctx,
 	return mlx5_fs_put_hws_action(meter_hws_data);
 }
 
+static struct mlx5hws_action *
+mlx5_fs_get_dest_action_sampler(struct mlx5_fs_hws_context *fs_ctx,
+				struct mlx5_flow_rule *dst)
+{
+	struct mlx5_fs_hws_create_action_ctx create_ctx;
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	struct mlx5_fs_hws_data *sampler_hws_data;
+	u32 id = dst->dest_attr.sampler_id;
+	struct xarray *sampler_xa;
+
+	sampler_xa = &fs_ctx->hws_pool.sample_dests;
+	sampler_hws_data = mlx5_fs_get_cached_hws_data(sampler_xa, id);
+	if (!sampler_hws_data)
+		return NULL;
+
+	create_ctx.hws_ctx = ctx;
+	create_ctx.actions_type = MLX5HWS_ACTION_TYP_SAMPLER;
+	create_ctx.id = id;
+
+	return mlx5_fs_get_hws_action(sampler_hws_data, &create_ctx);
+}
+
+static void mlx5_fs_put_dest_action_sampler(struct mlx5_fs_hws_context *fs_ctx,
+					    u32 sampler_id)
+{
+	struct mlx5_fs_hws_data *sampler_hws_data;
+	struct xarray *sampler_xa;
+
+	sampler_xa = &fs_ctx->hws_pool.sample_dests;
+	sampler_hws_data = xa_load(sampler_xa, sampler_id);
+	if (!sampler_hws_data)
+		return;
+
+	mlx5_fs_put_hws_action(sampler_hws_data);
+}
+
 static struct mlx5hws_action *
 mlx5_fs_create_action_dest_array(struct mlx5hws_context *ctx,
 				 struct mlx5hws_action_dest_attr *dests,
@@ -602,6 +642,9 @@ mlx5_fs_create_hws_action(struct mlx5_fs_hws_create_action_ctx *create_ctx)
 						       create_ctx->id,
 						       create_ctx->return_reg_id,
 						       flags);
+	case MLX5HWS_ACTION_TYP_SAMPLER:
+		return mlx5hws_action_create_flow_sampler(create_ctx->hws_ctx,
+							  create_ctx->id, flags);
 	default:
 		return NULL;
 	}
@@ -662,6 +705,9 @@ static void mlx5_fs_destroy_fs_action(struct mlx5_flow_root_namespace *ns,
 	case MLX5HWS_ACTION_TYP_ASO_METER:
 		mlx5_fs_put_action_aso_meter(fs_ctx, fs_action->exe_aso);
 		break;
+	case MLX5HWS_ACTION_TYP_SAMPLER:
+		mlx5_fs_put_dest_action_sampler(fs_ctx, fs_action->sampler_id);
+		break;
 	default:
 		mlx5hws_action_destroy(fs_action->action);
 	}
@@ -939,6 +985,14 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				dest_action = mlx5_fs_get_dest_action_vport(fs_ctx, dst,
 									    type_uplink);
 				break;
+			case MLX5_FLOW_DESTINATION_TYPE_FLOW_SAMPLER:
+				dest_action =
+					mlx5_fs_get_dest_action_sampler(fs_ctx,
+									dst);
+				fs_actions[num_fs_actions].action = dest_action;
+				fs_actions[num_fs_actions++].sampler_id =
+							dst->dest_attr.sampler_id;
+				break;
 			default:
 				err = -EOPNOTSUPP;
 				goto free_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 6970b1aa9540..8b56298288da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -23,6 +23,7 @@ struct mlx5_fs_hws_actions_pool {
 	struct xarray vport_vhca_dests;
 	struct xarray vport_dests;
 	struct xarray aso_meters;
+	struct xarray sample_dests;
 };
 
 struct mlx5_fs_hws_context {
@@ -51,6 +52,7 @@ struct mlx5_fs_hws_rule_action {
 	union {
 		struct mlx5_fc *counter;
 		struct mlx5_exe_aso *exe_aso;
+		u32 sampler_id;
 	};
 };
 
-- 
2.45.0


