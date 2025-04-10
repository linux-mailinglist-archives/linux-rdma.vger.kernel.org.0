Return-Path: <linux-rdma+bounces-9355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A690DA84CDD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70199C5544
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479482989A8;
	Thu, 10 Apr 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="koqX92K3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2D298989;
	Thu, 10 Apr 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312769; cv=fail; b=i/rpnRUZcS9Q4sSGZGZc5R2wtcJ6H7MRY1QVzRMf8h9sHHX/x8lU/ROGpoZI6ZQIQRmhHq8sr+xt4FGdJVtfCIMyWy2f7pYsJL5AiWESLtCuk7KyjXIdsZQdjCpDrty2OEkOw+/RlxgOpXaTHI6wtizaOqStrErWSPZVUbsVwac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312769; c=relaxed/simple;
	bh=UpuSnju4haSSxrY2aiq+i8iO44ofn6TeIMVS46BX5uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOc8+PSUqBSXF9kX7NsnQMfczADE+ejoYUC/YrWWlgcdVr2qRzGP/cx5+V2HvMnGTFK9Bhnw+WSSqUmi54QDTIpsHpcCLOao2l2tuevBU2B+/CIig+HmmyfhvRpM2UQnJ8NZR2cC48Nxbkhrte5eqjx267Rrf0rtFe/BSnDjIZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=koqX92K3; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nvw3w2PEMKU+RVj+riyNPLvqI9JmvV2QzqNAbNUI8ASPl4bU9R2vOHcAoFfEsdcr8nyuYaV+sh/fcCQ0hPlwfvAQfduf81qXDJjGPHIbvMgrlmk9uL0Igq2GNa487/gq3s4qr5adiyFAzx/TbmREWIRRpB1OzL1zRx8H2IsjNYk8TVPmnLTH9S7rbQDkG2zckP54nI539ADEpORKp67sZvvHaPxcZE5svNBb/hfHMWGaLu6MFY6s++Lb5GRUxExC+7KBmsRGe2z/MZzfiS1HqwRIQbdw8LESsCRttXbBEHCw79Y6svMNsh4itdkB2oAEP46tP/CEfp3dgNA34U8H9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJessMSFTSSNcnkCiCwFeTTtF7veDXMqyYZxheVv/dw=;
 b=hpYiNdm+jk95Mcl4bxXDzYpP0fl6K8k4PH87Kcj+/fuvZOkUw1YQgi3aX8rXV9iMDfjUEoq8NRbP6GtvZDdBuT0xXW3rCIB9IYRk5jbw/HsGKleThXoFI7MX62A+D1NnhTnPOWCuJecRflOkIL7TX9SZwwm7NXvBvgOAbPZS7zatcVhQDaWf7joXHMwdWDC/mN2o8O8blLQ4M6iUd0ZARDnGbuScycKOCJRbixoAZx/x9CEp1ke4wl+8FC/qNuRm53tVOxWA5WVNeX2Vft+pKPgs2vfPF//YnOHy7gcnI0CFxd8Um1g4wzlOatDe0RmW19uBjHwIQ015jnbmCY6xFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJessMSFTSSNcnkCiCwFeTTtF7veDXMqyYZxheVv/dw=;
 b=koqX92K3GTDfDiMljJULEcDYwCNeYucupp0oaclcsUT+HQDettnkaNxKeGo66BGTIObLpzn4wOq17sYrI0bQ+yiSFeOVS4ETAOjLhkHWab7cz9BSORg0LknTiXR8IFsaHKPTMGq1PfE+er9xeHb0yijCOGtTNoTtnAWXKQB0SfbFK7T88kwANAKRF3B6x5FfSpO11kmUIjxiXCCfmNss2mFQzBGBv7UVg5oz+6DNQIOl4HVh278na/TVnsceEs+awU6K9TdKpOBaxSRIn/hiS8PCVJyauAmwpL41mCltp6ouaUiFyZ154ct1IP7L05z8DEigBN1FFjS/tQKdIYpx7g==
Received: from BYAPR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:40::30)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Thu, 10 Apr
 2025 19:19:23 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::a3) by BYAPR04CA0017.outlook.office365.com
 (2603:10b6:a03:40::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 19:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:19:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:19:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:19:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:19:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 12/12] net/mlx5: HWS, Export action STE tables to debugfs
Date: Thu, 10 Apr 2025 22:17:42 +0300
Message-ID: <1744312662-356571-13-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: e51456cf-8527-4d6a-e9bf-08dd7864999c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfz1zwyQ/SuTs0WO07MtRncSEmPXQm5FOkio3cYssBBkziKSnHXqhCE9yN5a?=
 =?us-ascii?Q?EqumZnpINSfUy3sOTH6bLI6Ykq01RgqJ7aWK5wFd63ZqXdOsvSNE2sXorIE6?=
 =?us-ascii?Q?RXovZkdH6rbiRbZwKf3IsF5/LWRs8jdeyX4vEGypqmqRQY3aPbuw6K1AD0Pt?=
 =?us-ascii?Q?LqSy2yDQ3W+bcLGhiIL/8fPr/DW2eDRdHATtsY7JFSRNZ6GUEwxDS8nqqvbM?=
 =?us-ascii?Q?wsJRUrp6jTBCAo0gOQd67zRjRqwtT3g/y07scxY5nZcWmtBKfxotEUPOYDYd?=
 =?us-ascii?Q?nhYDFKab0xvShGuWeb41UehwQnOpvpTP6iNMaSH/jPUAa6Tb3k1i3dtYl8dI?=
 =?us-ascii?Q?2hwNh4Xrw+++E23nwQBx6M78U15G3KTB+/OfPcSXW2lIaRZq0Gc+IP3QL1UN?=
 =?us-ascii?Q?0J4e5UENlZ6udRReX3WQprjl2VYdEhNOuov1owxJUyhHS4thNeT8J3WOOTIQ?=
 =?us-ascii?Q?Cm/UjZ4jH+G/QK/PLVJEI5eoEZqLs05gLlx3O2MuW2/Z0wcRkC2kXOOVoDFy?=
 =?us-ascii?Q?wMvoPJDzyJQd/R5E4u2cxRJ2n4rri7W9AIzxKgHImdMvwgAVZWkvUwLMkB2S?=
 =?us-ascii?Q?NskoVmlnyEUBJjir4xNqBryWnDxIkRdteidKBJC+3iJay2ApNi6jcKdrmwPr?=
 =?us-ascii?Q?LXzmHmYYhW6aGerqDbDUNM7wuFV6++lg2T3tF16+l3VAluB2xnl9Nd829LNn?=
 =?us-ascii?Q?QUuDWzSX3jJ7C5K96Unc33QPg46QmPcjxHk1r/p8NBTVZhqOjYz2H4digew5?=
 =?us-ascii?Q?M4swc1BfD9O4xIUQdSdpFKLwElkcsOoprPZTQQiOauhpm83lk+fVmtoabZCf?=
 =?us-ascii?Q?13l6QRNhF7OPomx3HRCF0V1CiVG/mbu1yZdY8aaMlj45yzkl/wC/XNTqVuz2?=
 =?us-ascii?Q?c05PwecgR+sBYxA2zugo+NgEc156Fb4DJ7L+vpe6o5Dvf795AsvmIH++GHlU?=
 =?us-ascii?Q?YtdtH3PSh6AHHEB0mhcpWRmKgl952Clc/Dt4+s7+9DpsHWiUZRlr/BJC2vIy?=
 =?us-ascii?Q?846ETYiuVybrfZ6qCXcYHkhRvAFYYonOQIU7CvaKJyEcgRpwRCI/R3rGfXHh?=
 =?us-ascii?Q?nHs0HaJuXeciMzFLDIblTDHPcJ/uN2I++42vxXkJrYHnIyLNy4Vk0V6mlzTX?=
 =?us-ascii?Q?sIRbFhXP2d1TmezS2uSSBzLqBv5keVuhQ0vTfrANaZgbjhxDXdLYtfug8oYO?=
 =?us-ascii?Q?kS8wTGaQM/FSRQxVUwMS4Xd+MS82N9PvIP7mivtFpTnbm+CjniNOdXnD5hLo?=
 =?us-ascii?Q?8dij0cmqPrCkfF1/4F48a8bpgwGb43Nkmkgz9KeWarMw6rICiE3QNeG9+59a?=
 =?us-ascii?Q?Vv/b6GrLEZ/cH66NKqhGKvqXZHevqkD+T23VzcWbz7vff54faIVNTymVKzox?=
 =?us-ascii?Q?/et3KutC4HGPgx0NmFwIRw0bdI9pjuEU/BQCgR5OEj810jMJEDliUQ2jMeVg?=
 =?us-ascii?Q?0JdIC4jUeQmkE3nMhqjjBD4fACfUPf+3MInKqJqfzs8XwyXFX/IX7jkeS0l5?=
 =?us-ascii?Q?knTRtf2LU+56qOs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:19:22.4957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51456cf-8527-4d6a-e9bf-08dd7864999c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

From: Vlad Dogaru <vdogaru@nvidia.com>

Introduce a new type of dump object and dump all action STE tables,
along with information on their RTCs and STEs.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../mellanox/mlx5/core/steering/hws/debug.c   | 36 ++++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/debug.h   |  2 ++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 38f75dec9cfc..91568d6c1dac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -387,10 +387,41 @@ static int hws_debug_dump_context_stc(struct seq_file *f, struct mlx5hws_context
 	return 0;
 }
 
+static void
+hws_debug_dump_action_ste_table(struct seq_file *f,
+				struct mlx5hws_action_ste_table *action_tbl)
+{
+	int ste_0_id = mlx5hws_pool_get_base_id(action_tbl->pool);
+	int ste_1_id = mlx5hws_pool_get_base_mirror_id(action_tbl->pool);
+
+	seq_printf(f, "%d,0x%llx,%d,%d,%d,%d\n",
+		   MLX5HWS_DEBUG_RES_TYPE_ACTION_STE_TABLE,
+		   HWS_PTR_TO_ID(action_tbl),
+		   action_tbl->rtc_0_id, ste_0_id,
+		   action_tbl->rtc_1_id, ste_1_id);
+}
+
+static void hws_debug_dump_action_ste_pool(struct seq_file *f,
+					   struct mlx5hws_action_ste_pool *pool)
+{
+	struct mlx5hws_action_ste_table *action_tbl;
+	enum mlx5hws_pool_optimize opt;
+
+	mutex_lock(&pool->lock);
+	for (opt = MLX5HWS_POOL_OPTIMIZE_NONE; opt < MLX5HWS_POOL_OPTIMIZE_MAX;
+	     opt++) {
+		list_for_each_entry(action_tbl, &pool->elems[opt].available,
+				    list_node) {
+			hws_debug_dump_action_ste_table(f, action_tbl);
+		}
+	}
+	mutex_unlock(&pool->lock);
+}
+
 static int hws_debug_dump_context(struct seq_file *f, struct mlx5hws_context *ctx)
 {
 	struct mlx5hws_table *tbl;
-	int ret;
+	int ret, i;
 
 	ret = hws_debug_dump_context_info(f, ctx);
 	if (ret)
@@ -410,6 +441,9 @@ static int hws_debug_dump_context(struct seq_file *f, struct mlx5hws_context *ct
 			return ret;
 	}
 
+	for (i = 0; i < ctx->queues; i++)
+		hws_debug_dump_action_ste_pool(f, &ctx->action_ste_pool[i]);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h
index e44e7ae28f93..89c396f9f266 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h
@@ -26,6 +26,8 @@ enum mlx5hws_debug_res_type {
 	MLX5HWS_DEBUG_RES_TYPE_MATCHER_TEMPLATE_HASH_DEFINER = 4205,
 	MLX5HWS_DEBUG_RES_TYPE_MATCHER_TEMPLATE_RANGE_DEFINER = 4206,
 	MLX5HWS_DEBUG_RES_TYPE_MATCHER_TEMPLATE_COMPARE_MATCH_DEFINER = 4207,
+
+	MLX5HWS_DEBUG_RES_TYPE_ACTION_STE_TABLE = 4300,
 };
 
 static inline u64
-- 
2.31.1


