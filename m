Return-Path: <linux-rdma+bounces-9252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD77A80D53
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C201B87B6D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AC1E0DE8;
	Tue,  8 Apr 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOComp/t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB291C863C;
	Tue,  8 Apr 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120968; cv=fail; b=X9kYCsyDINMl7qVP9nwMqsIWobbZfGmwCBIgVNF+WE7sosCbP01KfPCKqZPU+jHS3KjTPKE2jCJERW7o6mK3NPQwx/O0Mobi9ON0/0yFF4b8dYwCjBQ3AI4sdi+vfILGmIEJTpCcfQ227Tji7yrSEwdB2KV8RFwzPM9YDYPWUAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120968; c=relaxed/simple;
	bh=Hadse8ze0+QofI/HkoaFFXgwXoB5Lp1ArvcZxwb/Xbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoAFo1H6FkS91nSKeY54eL0DGdKmBNjL1c81bb4gYFRUFIPZgreJR3Xdm0uJAy9Q+r5cjcpWa501nL3p+7++aSMQZ3WcNFQ02m4lDnl8Wun/w6CG8QXEIh2iCuJKiQsDQWt7C68tmexFEKdE3kHeXxhQCkbEhzA2ostQltz/Uqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOComp/t; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+BjOj+/Yqe64XYO7ACTfLqU2YVatx1vYiE0fJE9PPwR3pO9Y3+t48N3YaX6Bdk91V5WhbP5nmGdze3LKyx2ehSLuJNe2hPe4gB5HeSGZnTcfi5UKROqI5uiBKpnSsBHW1bKpa+dsoFcnF1zUeFUfOUZDWr7Mf31wykKF0/oYyrWzkU/t6bwdf/VpmMmLl3Nc2c7NYZpHqI1it5Ejn5F0HAUDXcNsjojp4VEmF16y5voqJfe0/Xu8wA+XzJo1lnogiDBlFJlJb/5HPhasGOpc8N5iFVPZUGnGTNw9IcN/YAz82yzeqt8L2xGdTMhqPTiy13p9n8k14dI8u6ok7Nw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkbzyEbDlEZ+FCczTUaJ1WhG+kGdUCXYyw+4kqses9c=;
 b=jz4qMBQyCYOAh/AiUawpELmykFWI2vQ3YGKfltegNVrJmit/cjoMu8j0UHt+txqnweoWXNIYd68Im4mJy3hNPc2L/gYUjvmVEQjIzOHT8fkjjBPiPmtLhFuhiLShXEuvBbBmlw3eTIYgU8JIG5wMXVkxucIBY/JQN9444vojKVXYbFAopndqRPMf8QogN+Ierima+2M9FFDA26ReH5Kx0BwLTfoCv88/8sZdUizaEa3KuoILdAz65EOu4zaMhZVfbfrmzxeT/phJINgmwpnEweD3ss7xdZXgzIa+LVG5oET0U1gQpmDPGzR+cRmSuOoXPZ/cRBnvnI3BaecdepM44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkbzyEbDlEZ+FCczTUaJ1WhG+kGdUCXYyw+4kqses9c=;
 b=JOComp/tv3dUR+Ej+Z+4sM7zJpXe32WjIMijKEmI2AuHdWSHOwTL0e2jXMSIYZpPGZLmY18Zc5CzHiPxjYEXtky9YsViAq50qP4Eel9E1kgGEjy1WK8IIC+h7m8obmjOxhjj5nvUyZ1/KBwVStX65sPMrjhMT5k3EYE0HYoyZBTuqhVMKCTjRryhwddc/7o234uNi4JqqTqwFwPGYz96iEy+JMvuGn5NOodw+BHTytHovlStevsLOzbpRclWESqaXB7doJJrfdwDPGeHfmehXplzSiS3aJvUZvP5JtTLdOHexvi8pY+iF+qq4GHOhQxX9SK5XrYZ5PAIEJCRalS6SQ==
Received: from SJ0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:a03:3a1::14)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 14:02:39 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::5d) by SJ0PR03CA0369.outlook.office365.com
 (2603:10b6:a03:3a1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 14:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 04/12] net/mlx5: HWS, Refactor pool implementation
Date: Tue, 8 Apr 2025 17:00:48 +0300
Message-ID: <1744120856-341328-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9fbca9-6378-4645-6561-08dd76a6057f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGb6RG6LftrOQQMqgMYSiQ+mHsqZ9y0M8fSEZAB9AgXcCuuJ01L7O73Ap1Mp?=
 =?us-ascii?Q?JNTWCJNfuLLNojEUlcLDXUjnfD9oD9ZxJzYMKQXlZG9QQaXjSm5oXwVAvfe4?=
 =?us-ascii?Q?sdw80xpAyfyT7u8P71Nhrd10NYmT7eEQkgE3dZ5vzlyVWVMrvBm40kXl7fIZ?=
 =?us-ascii?Q?yLR9SCotrDArlgLdakqo+0ZFmgngzs4KhlPVNbXsqib++5o+AdO1hxi99TFR?=
 =?us-ascii?Q?k9C78IXndmJ7s4tC2EOc9lnDk2v3w23R+ZZIo3m6ZOwTCOHrs1LuWDHUrzO0?=
 =?us-ascii?Q?JQ410WB1ZashssG4GNwQUA5iH3Ew+yT6JANsgyRKHhFF3lEAxl288lFVJaVr?=
 =?us-ascii?Q?Rli/I4vBww90PnzE0XFz/erlvcQFxfOFk/CUoLXPcYuT1p21RstwcwPUvPmv?=
 =?us-ascii?Q?PXRTXe7DBdwRrr1ACweG78V4mD7lk3jPRDYhH4PTNt7NjvjCjBx5jK2YA8rG?=
 =?us-ascii?Q?BwhiaGWFAJbqxO4p8kgTpYM7v1qyrFglUUPmRwgguJl5dwu+IS94+Z2lzs5J?=
 =?us-ascii?Q?JF23YHqH7Wccv+yBz/iO32gyx4TX1vSC+nOZjVpHxtD8uyvAZNsI+A5xQAr+?=
 =?us-ascii?Q?xbaXbXikmTXAicoe2drFAtNEIz+t70nc67Qkg4znB19/J39HJYvQ+SpoYyoW?=
 =?us-ascii?Q?10BL8oILMrXiExa89mkRIM5elOhpNsepxu98qaqQKACRiJEXi3bmS85ZmteL?=
 =?us-ascii?Q?PCsJXO0NL83nvKLLBNokjk25OZxURafL9GfKaX0+YCoGVgeWHNlghuo1uN6e?=
 =?us-ascii?Q?ryTmCsNlECjqdB66StANLEfKyeOw15ACtSUPP1YEzBleB9cdAIm+9iFeUAnq?=
 =?us-ascii?Q?UzhfAso3DRSrMv9ViH8q99V1tvnEJc7UznULyDProkZCSdUxtA1pC2WDHuPw?=
 =?us-ascii?Q?TXsLVhDByD9F3aVKkB4QqtrvEG8u4Uc/Aq9IYpaBsZ8Sa8q7nYtQrw71q172?=
 =?us-ascii?Q?8FA0m+gW86aAfUlwmES08QM2oluInwDJNVbtIPGh2DkUMcF2z0LzEN2uG9wj?=
 =?us-ascii?Q?QCG4Xo3RmSOAfU0T5zXMs+u8dMRh/rZW/Q7FOrG9IcolmYJ/Zo65yiCPKzYi?=
 =?us-ascii?Q?imxAoOXmBIPu9WpJ83nd8CgIW0F7r+ZUGxMBoarrdZyPkXxnGuM/IOtv7z7g?=
 =?us-ascii?Q?aGou6hP7lQC191XofnMtna37g0/SCyyz9CS2YCycKIKuVqExTFtvQ2chl0XH?=
 =?us-ascii?Q?Ls6dLhfwl1sV4oeyBAUvtZc/Pk0UKG9Vn9ao1xylDfhpGGne6zgdQAffmbdY?=
 =?us-ascii?Q?BVvrsoRf888Eu1g64kT0+1DFNkMs4m+BDsYL1rOfEvsTFsg+fl1GfeAy7HvI?=
 =?us-ascii?Q?5FICj4jNwVcV5YkGg4PhBEvwRP6xtnl9O915vxE8S6PUtMHfJ8AC12q38/vY?=
 =?us-ascii?Q?7EkmMkuNqJBuG7Q1etJS8jI/JA558PcwmI3iJTrI7q61gbFpCNemcm2lWtqk?=
 =?us-ascii?Q?tevNBvEAwdw27SacK+HQMC5J+yW06bj0cX7kudPg5Lox2DWqqp/CmcN1XjKX?=
 =?us-ascii?Q?g/+XS9h4qRzu1Vg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:38.4111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9fbca9-6378-4645-6561-08dd76a6057f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

From: Vlad Dogaru <vdogaru@nvidia.com>

Refactor the pool implementation to remove unused flags and clarify its
usage. A pool represents a single range of STEs or STCs which are
allocated at pool creation time.

Pools are used under three patterns:

1. STCs are allocated one at a time from a global pool using a bitmap
   based implementation.

2. Action STEs are allocated in power-of-two blocks using a buddy
   algorithm.

3. Match STEs do not use allocation, since insertion into these tables
   is based on hashes or direct addressing. In such cases we use a pool
   only to create the STE range.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  |   1 -
 .../mellanox/mlx5/core/steering/hws/context.c |   1 -
 .../mellanox/mlx5/core/steering/hws/matcher.c |  19 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    | 387 +++++-------------
 .../mellanox/mlx5/core/steering/hws/pool.h    |  45 +-
 5 files changed, 116 insertions(+), 337 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 781ba8c4f733..39904b337b81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1602,7 +1602,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 
 	pool_attr.table_type = MLX5HWS_TABLE_TYPE_FDB;
 	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
-	pool_attr.flags = MLX5HWS_POOL_FLAGS_FOR_STE_ACTION_POOL;
 	pool_attr.alloc_log_sz = 1;
 	table_ste->pool = mlx5hws_pool_create(ctx, &pool_attr);
 	if (!table_ste->pool) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index 9cda2774fd64..b7cb736b74d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -34,7 +34,6 @@ static int hws_context_pools_init(struct mlx5hws_context *ctx)
 
 	/* Create an STC pool per FT type */
 	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STC;
-	pool_attr.flags = MLX5HWS_POOL_FLAGS_FOR_STC_POOL;
 	max_log_sz = min(MLX5HWS_POOL_STC_LOG_SZ, ctx->caps->stc_alloc_log_max);
 	pool_attr.alloc_log_sz = max(max_log_sz, ctx->caps->stc_alloc_log_gran);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 59b14db427b4..95d31fd6c976 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -265,14 +265,6 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 				rtc_attr.match_definer_0 = ctx->caps->linear_match_definer;
 			}
 		}
-
-		/* Match pool requires implicit allocation */
-		ret = mlx5hws_pool_chunk_alloc(ste_pool, ste);
-		if (ret) {
-			mlx5hws_err(ctx, "Failed to allocate STE for %s RTC",
-				    hws_matcher_rtc_type_to_str(rtc_type));
-			return ret;
-		}
 		break;
 
 	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
@@ -357,23 +349,17 @@ static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
 {
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
-	struct mlx5hws_pool_chunk *ste;
-	struct mlx5hws_pool *ste_pool;
 	u32 rtc_0_id, rtc_1_id;
 
 	switch (rtc_type) {
 	case HWS_MATCHER_RTC_TYPE_MATCH:
 		rtc_0_id = matcher->match_ste.rtc_0_id;
 		rtc_1_id = matcher->match_ste.rtc_1_id;
-		ste_pool = matcher->match_ste.pool;
-		ste = &matcher->match_ste.ste;
 		break;
 	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
 		action_ste = &matcher->action_ste;
 		rtc_0_id = action_ste->rtc_0_id;
 		rtc_1_id = action_ste->rtc_1_id;
-		ste_pool = action_ste->pool;
-		ste = &action_ste->ste;
 		break;
 	default:
 		return;
@@ -383,8 +369,6 @@ static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
 		mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev, rtc_1_id);
 
 	mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev, rtc_0_id);
-	if (rtc_type == HWS_MATCHER_RTC_TYPE_MATCH)
-		mlx5hws_pool_chunk_free(ste_pool, ste);
 }
 
 static int
@@ -557,7 +541,7 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 	/* Allocate action STE mempool */
 	pool_attr.table_type = tbl->type;
 	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
-	pool_attr.flags = MLX5HWS_POOL_FLAGS_FOR_STE_ACTION_POOL;
+	pool_attr.flags = MLX5HWS_POOL_FLAG_BUDDY;
 	/* Pool size is similar to action RTC size */
 	pool_attr.alloc_log_sz = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
 				 matcher->attr.table.sz_row_log +
@@ -636,7 +620,6 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 	/* Create an STE pool per matcher*/
 	pool_attr.table_type = matcher->tbl->type;
 	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
-	pool_attr.flags = MLX5HWS_POOL_FLAGS_FOR_MATCHER_STE_POOL;
 	pool_attr.alloc_log_sz = matcher->attr.table.sz_col_log +
 				 matcher->attr.table.sz_row_log;
 	hws_matcher_set_pool_attr(&pool_attr, matcher);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 0de03e17624c..270b333faab3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -60,10 +60,8 @@ hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32 log_range,
 		ret = -EINVAL;
 	}
 
-	if (ret) {
-		mlx5hws_err(pool->ctx, "Failed to allocate resource objects\n");
+	if (ret)
 		goto free_resource;
-	}
 
 	resource->pool = pool;
 	resource->range = 1 << log_range;
@@ -76,17 +74,17 @@ hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32 log_range,
 	return NULL;
 }
 
-static int
-hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range)
+static int hws_pool_resource_alloc(struct mlx5hws_pool *pool)
 {
 	struct mlx5hws_pool_resource *resource;
 	u32 fw_ft_type, opt_log_range;
 
 	fw_ft_type = mlx5hws_table_get_res_fw_ft_type(pool->tbl_type, false);
-	opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_ORIG ? 0 : log_range;
+	opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_ORIG ?
+				0 : pool->alloc_log_sz;
 	resource = hws_pool_create_one_resource(pool, opt_log_range, fw_ft_type);
 	if (!resource) {
-		mlx5hws_err(pool->ctx, "Failed allocating resource\n");
+		mlx5hws_err(pool->ctx, "Failed to allocate resource\n");
 		return -EINVAL;
 	}
 
@@ -96,10 +94,11 @@ hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range)
 		struct mlx5hws_pool_resource *mirror_resource;
 
 		fw_ft_type = mlx5hws_table_get_res_fw_ft_type(pool->tbl_type, true);
-		opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_MIRROR ? 0 : log_range;
+		opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_MIRROR ?
+					0 : pool->alloc_log_sz;
 		mirror_resource = hws_pool_create_one_resource(pool, opt_log_range, fw_ft_type);
 		if (!mirror_resource) {
-			mlx5hws_err(pool->ctx, "Failed allocating mirrored resource\n");
+			mlx5hws_err(pool->ctx, "Failed to allocate mirrored resource\n");
 			hws_pool_free_one_resource(resource);
 			pool->resource = NULL;
 			return -EINVAL;
@@ -110,92 +109,58 @@ hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range)
 	return 0;
 }
 
-static unsigned long *hws_pool_create_and_init_bitmap(u32 log_range)
-{
-	unsigned long *cur_bmp;
-
-	cur_bmp = bitmap_zalloc(1 << log_range, GFP_KERNEL);
-	if (!cur_bmp)
-		return NULL;
-
-	bitmap_fill(cur_bmp, 1 << log_range);
-
-	return cur_bmp;
-}
-
-static void hws_pool_buddy_db_put_chunk(struct mlx5hws_pool *pool,
-					struct mlx5hws_pool_chunk *chunk)
+static int hws_pool_buddy_init(struct mlx5hws_pool *pool)
 {
 	struct mlx5hws_buddy_mem *buddy;
 
-	buddy = pool->db.buddy;
+	buddy = mlx5hws_buddy_create(pool->alloc_log_sz);
 	if (!buddy) {
-		mlx5hws_err(pool->ctx, "Bad buddy state\n");
-		return;
-	}
-
-	mlx5hws_buddy_free_mem(buddy, chunk->offset, chunk->order);
-}
-
-static struct mlx5hws_buddy_mem *
-hws_pool_buddy_get_buddy(struct mlx5hws_pool *pool, u32 order)
-{
-	static struct mlx5hws_buddy_mem *buddy;
-	u32 new_buddy_size;
-
-	buddy = pool->db.buddy;
-	if (buddy)
-		return buddy;
-
-	new_buddy_size = max(pool->alloc_log_sz, order);
-	buddy = mlx5hws_buddy_create(new_buddy_size);
-	if (!buddy) {
-		mlx5hws_err(pool->ctx, "Failed to create buddy order: %d\n",
-			    new_buddy_size);
-		return NULL;
+		mlx5hws_err(pool->ctx, "Failed to create buddy order: %zu\n",
+			    pool->alloc_log_sz);
+		return -ENOMEM;
 	}
 
-	if (hws_pool_resource_alloc(pool, new_buddy_size) != 0) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
-			    pool->type, new_buddy_size);
+	if (hws_pool_resource_alloc(pool) != 0) {
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d size %zu\n",
+			    pool->type, pool->alloc_log_sz);
 		mlx5hws_buddy_cleanup(buddy);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	pool->db.buddy = buddy;
 
-	return buddy;
+	return 0;
 }
 
-static int hws_pool_buddy_get_mem_chunk(struct mlx5hws_pool *pool,
-					int order,
-					int *seg)
+static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
+				       struct mlx5hws_pool_chunk *chunk)
 {
-	struct mlx5hws_buddy_mem *buddy;
+	struct mlx5hws_buddy_mem *buddy = pool->db.buddy;
 
-	buddy = hws_pool_buddy_get_buddy(pool, order);
-	if (!buddy)
-		return -ENOMEM;
+	if (!buddy) {
+		mlx5hws_err(pool->ctx, "Bad buddy state\n");
+		return -EINVAL;
+	}
 
-	*seg = mlx5hws_buddy_alloc_mem(buddy, order);
-	if (*seg >= 0)
+	chunk->offset = mlx5hws_buddy_alloc_mem(buddy, chunk->order);
+	if (chunk->offset >= 0)
 		return 0;
 
 	return -ENOMEM;
 }
 
-static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
-				       struct mlx5hws_pool_chunk *chunk)
+static void hws_pool_buddy_db_put_chunk(struct mlx5hws_pool *pool,
+					struct mlx5hws_pool_chunk *chunk)
 {
-	int ret = 0;
+	struct mlx5hws_buddy_mem *buddy;
 
-	ret = hws_pool_buddy_get_mem_chunk(pool, chunk->order,
-					   &chunk->offset);
-	if (ret)
-		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
-			    chunk->order);
+	buddy = pool->db.buddy;
+	if (!buddy) {
+		mlx5hws_err(pool->ctx, "Bad buddy state\n");
+		return;
+	}
 
-	return ret;
+	mlx5hws_buddy_free_mem(buddy, chunk->offset, chunk->order);
 }
 
 static void hws_pool_buddy_db_uninit(struct mlx5hws_pool *pool)
@@ -210,15 +175,13 @@ static void hws_pool_buddy_db_uninit(struct mlx5hws_pool *pool)
 	}
 }
 
-static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool, u32 log_range)
+static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool)
 {
-	if (pool->flags & MLX5HWS_POOL_FLAGS_ALLOC_MEM_ON_CREATE) {
-		if (!hws_pool_buddy_get_buddy(pool, log_range)) {
-			mlx5hws_err(pool->ctx,
-				    "Failed allocating memory on create log_sz: %d\n", log_range);
-			return -ENOMEM;
-		}
-	}
+	int ret;
+
+	ret = hws_pool_buddy_init(pool);
+	if (ret)
+		return ret;
 
 	pool->p_db_uninit = &hws_pool_buddy_db_uninit;
 	pool->p_get_chunk = &hws_pool_buddy_db_get_chunk;
@@ -227,234 +190,105 @@ static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool, u32 log_range)
 	return 0;
 }
 
-static int hws_pool_create_resource(struct mlx5hws_pool *pool, u32 alloc_size)
-{
-	int ret = hws_pool_resource_alloc(pool, alloc_size);
-
-	if (ret) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
-			    pool->type, alloc_size);
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct mlx5hws_pool_elements *
-hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order)
+static unsigned long *hws_pool_create_and_init_bitmap(u32 log_range)
 {
-	struct mlx5hws_pool_elements *elem;
-	u32 alloc_size;
-
-	alloc_size = pool->alloc_log_sz;
+	unsigned long *bitmap;
 
-	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
-	if (!elem)
+	bitmap = bitmap_zalloc(1 << log_range, GFP_KERNEL);
+	if (!bitmap)
 		return NULL;
 
-	/* Sharing the same resource, also means that all the elements are with size 1 */
-	if ((pool->flags & MLX5HWS_POOL_FLAGS_FIXED_SIZE_OBJECTS) &&
-	    !(pool->flags & MLX5HWS_POOL_FLAGS_RESOURCE_PER_CHUNK)) {
-		 /* Currently all chunks in size 1 */
-		elem->bitmap = hws_pool_create_and_init_bitmap(alloc_size - order);
-		if (!elem->bitmap) {
-			mlx5hws_err(pool->ctx,
-				    "Failed to create bitmap type: %d: size %d\n",
-				    pool->type, alloc_size);
-			goto free_elem;
-		}
-
-		elem->log_size = alloc_size - order;
-	}
-
-	if (hws_pool_create_resource(pool, alloc_size)) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
-			    pool->type, alloc_size);
-		goto free_db;
-	}
-
-	pool->db.element = elem;
+	bitmap_fill(bitmap, 1 << log_range);
 
-	return elem;
-
-free_db:
-	bitmap_free(elem->bitmap);
-free_elem:
-	kfree(elem);
-	return NULL;
+	return bitmap;
 }
 
-static int hws_pool_element_find_seg(struct mlx5hws_pool_elements *elem, int *seg)
+static int hws_pool_bitmap_init(struct mlx5hws_pool *pool)
 {
-	unsigned int segment, size;
+	unsigned long *bitmap;
 
-	size = 1 << elem->log_size;
-
-	segment = find_first_bit(elem->bitmap, size);
-	if (segment >= size) {
-		elem->is_full = true;
+	bitmap = hws_pool_create_and_init_bitmap(pool->alloc_log_sz);
+	if (!bitmap) {
+		mlx5hws_err(pool->ctx, "Failed to create bitmap order: %zu\n",
+			    pool->alloc_log_sz);
 		return -ENOMEM;
 	}
 
-	bitmap_clear(elem->bitmap, segment, 1);
-	*seg = segment;
-	return 0;
-}
-
-static int
-hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
-				       int *seg)
-{
-	struct mlx5hws_pool_elements *elem;
-
-	elem = pool->db.element;
-	if (!elem)
-		elem = hws_pool_element_create_new_elem(pool, order);
-	if (!elem)
-		goto err_no_elem;
-
-	if (hws_pool_element_find_seg(elem, seg) != 0) {
-		mlx5hws_err(pool->ctx, "No more resources (last request order: %d)\n", order);
+	if (hws_pool_resource_alloc(pool) != 0) {
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %zu\n",
+			    pool->type, pool->alloc_log_sz);
+		bitmap_free(bitmap);
 		return -ENOMEM;
 	}
 
-	elem->num_of_elements++;
-	return 0;
+	pool->db.bitmap = bitmap;
 
-err_no_elem:
-	mlx5hws_err(pool->ctx, "Failed to allocate element for order: %d\n", order);
-	return -ENOMEM;
+	return 0;
 }
 
-static int hws_pool_general_element_get_mem_chunk(struct mlx5hws_pool *pool,
-						  u32 order, int *seg)
+static int hws_pool_bitmap_db_get_chunk(struct mlx5hws_pool *pool,
+					struct mlx5hws_pool_chunk *chunk)
 {
-	int ret;
+	unsigned long *bitmap, size;
 
-	if (!pool->resource) {
-		ret = hws_pool_create_resource(pool, order);
-		if (ret)
-			goto err_no_res;
-		*seg = 0; /* One memory slot in that element */
-		return 0;
+	if (chunk->order != 0) {
+		mlx5hws_err(pool->ctx, "Pool only supports order 0 allocs\n");
+		return -EINVAL;
 	}
 
-	mlx5hws_err(pool->ctx, "No more resources (last request order: %d)\n", order);
-	return -ENOMEM;
-
-err_no_res:
-	mlx5hws_err(pool->ctx, "Failed to allocate element for order: %d\n", order);
-	return -ENOMEM;
-}
-
-static int hws_pool_general_element_db_get_chunk(struct mlx5hws_pool *pool,
-						 struct mlx5hws_pool_chunk *chunk)
-{
-	int ret;
-
-	ret = hws_pool_general_element_get_mem_chunk(pool, chunk->order,
-						     &chunk->offset);
-	if (ret)
-		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
-			    chunk->order);
-
-	return ret;
-}
+	bitmap = pool->db.bitmap;
+	if (!bitmap) {
+		mlx5hws_err(pool->ctx, "Bad bitmap state\n");
+		return -EINVAL;
+	}
 
-static void hws_pool_general_element_db_put_chunk(struct mlx5hws_pool *pool,
-						  struct mlx5hws_pool_chunk *chunk)
-{
-	if (pool->flags & MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE)
-		hws_pool_resource_free(pool);
-}
+	size = 1 << pool->alloc_log_sz;
 
-static void hws_pool_general_element_db_uninit(struct mlx5hws_pool *pool)
-{
-	(void)pool;
-}
+	chunk->offset = find_first_bit(bitmap, size);
+	if (chunk->offset >= size)
+		return -ENOMEM;
 
-/* This memory management works as the following:
- * - At start doesn't allocate no mem at all.
- * - When new request for chunk arrived:
- *	allocate resource and give it.
- * - When free that chunk:
- *	the resource is freed.
- */
-static int hws_pool_general_element_db_init(struct mlx5hws_pool *pool)
-{
-	pool->p_db_uninit = &hws_pool_general_element_db_uninit;
-	pool->p_get_chunk = &hws_pool_general_element_db_get_chunk;
-	pool->p_put_chunk = &hws_pool_general_element_db_put_chunk;
+	bitmap_clear(bitmap, chunk->offset, 1);
 
 	return 0;
 }
 
-static void
-hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
-				       struct mlx5hws_pool_elements *elem)
-{
-	hws_pool_resource_free(pool);
-	bitmap_free(elem->bitmap);
-	kfree(elem);
-	pool->db.element = NULL;
-}
-
-static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
-					     struct mlx5hws_pool_chunk *chunk)
+static void hws_pool_bitmap_db_put_chunk(struct mlx5hws_pool *pool,
+					 struct mlx5hws_pool_chunk *chunk)
 {
-	struct mlx5hws_pool_elements *elem;
+	unsigned long *bitmap;
 
-	elem = pool->db.element;
-	if (!elem) {
-		mlx5hws_err(pool->ctx, "Pool element was not allocated\n");
+	bitmap = pool->db.bitmap;
+	if (!bitmap) {
+		mlx5hws_err(pool->ctx, "Bad bitmap state\n");
 		return;
 	}
 
-	bitmap_set(elem->bitmap, chunk->offset, 1);
-	elem->is_full = false;
-	elem->num_of_elements--;
-
-	if (pool->flags & MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE &&
-	    !elem->num_of_elements)
-		hws_onesize_element_db_destroy_element(pool, elem);
+	bitmap_set(bitmap, chunk->offset, 1);
 }
 
-static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
-					    struct mlx5hws_pool_chunk *chunk)
+static void hws_pool_bitmap_db_uninit(struct mlx5hws_pool *pool)
 {
-	int ret = 0;
-
-	ret = hws_pool_onesize_element_get_mem_chunk(pool, chunk->order,
-						     &chunk->offset);
-	if (ret)
-		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
-			    chunk->order);
+	unsigned long *bitmap;
 
-	return ret;
+	bitmap = pool->db.bitmap;
+	if (bitmap) {
+		bitmap_free(bitmap);
+		pool->db.bitmap = NULL;
+	}
 }
 
-static void hws_onesize_element_db_uninit(struct mlx5hws_pool *pool)
+static int hws_pool_bitmap_db_init(struct mlx5hws_pool *pool)
 {
-	struct mlx5hws_pool_elements *elem = pool->db.element;
+	int ret;
 
-	if (elem) {
-		bitmap_free(elem->bitmap);
-		kfree(elem);
-		pool->db.element = NULL;
-	}
-}
+	ret = hws_pool_bitmap_init(pool);
+	if (ret)
+		return ret;
 
-/* This memory management works as the following:
- * - At start doesn't allocate no mem at all.
- * - When new request for chunk arrived:
- *  aloocate the first and only slot of memory/resource
- *  when it ended return error.
- */
-static int hws_pool_onesize_element_db_init(struct mlx5hws_pool *pool)
-{
-	pool->p_db_uninit = &hws_onesize_element_db_uninit;
-	pool->p_get_chunk = &hws_onesize_element_db_get_chunk;
-	pool->p_put_chunk = &hws_onesize_element_db_put_chunk;
+	pool->p_db_uninit = &hws_pool_bitmap_db_uninit;
+	pool->p_get_chunk = &hws_pool_bitmap_db_get_chunk;
+	pool->p_put_chunk = &hws_pool_bitmap_db_put_chunk;
 
 	return 0;
 }
@@ -464,15 +298,14 @@ static int hws_pool_db_init(struct mlx5hws_pool *pool,
 {
 	int ret;
 
-	if (db_type == MLX5HWS_POOL_DB_TYPE_GENERAL_SIZE)
-		ret = hws_pool_general_element_db_init(pool);
-	else if (db_type == MLX5HWS_POOL_DB_TYPE_ONE_SIZE_RESOURCE)
-		ret = hws_pool_onesize_element_db_init(pool);
+	if (db_type == MLX5HWS_POOL_DB_TYPE_BITMAP)
+		ret = hws_pool_bitmap_db_init(pool);
 	else
-		ret = hws_pool_buddy_db_init(pool, pool->alloc_log_sz);
+		ret = hws_pool_buddy_db_init(pool);
 
 	if (ret) {
-		mlx5hws_err(pool->ctx, "Failed to init general db : %d (ret: %d)\n", db_type, ret);
+		mlx5hws_err(pool->ctx, "Failed to init pool type: %d (ret: %d)\n",
+			    db_type, ret);
 		return ret;
 	}
 
@@ -521,15 +354,10 @@ mlx5hws_pool_create(struct mlx5hws_context *ctx, struct mlx5hws_pool_attr *pool_
 	pool->tbl_type = pool_attr->table_type;
 	pool->opt_type = pool_attr->opt_type;
 
-	/* Support general db */
-	if (pool->flags == (MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE |
-			    MLX5HWS_POOL_FLAGS_RESOURCE_PER_CHUNK))
-		res_db_type = MLX5HWS_POOL_DB_TYPE_GENERAL_SIZE;
-	else if (pool->flags == (MLX5HWS_POOL_FLAGS_ONE_RESOURCE |
-				 MLX5HWS_POOL_FLAGS_FIXED_SIZE_OBJECTS))
-		res_db_type = MLX5HWS_POOL_DB_TYPE_ONE_SIZE_RESOURCE;
-	else
+	if (pool->flags & MLX5HWS_POOL_FLAG_BUDDY)
 		res_db_type = MLX5HWS_POOL_DB_TYPE_BUDDY;
+	else
+		res_db_type = MLX5HWS_POOL_DB_TYPE_BITMAP;
 
 	pool->alloc_log_sz = pool_attr->alloc_log_sz;
 
@@ -545,7 +373,7 @@ mlx5hws_pool_create(struct mlx5hws_context *ctx, struct mlx5hws_pool_attr *pool_
 	return NULL;
 }
 
-int mlx5hws_pool_destroy(struct mlx5hws_pool *pool)
+void mlx5hws_pool_destroy(struct mlx5hws_pool *pool)
 {
 	mutex_destroy(&pool->lock);
 
@@ -555,5 +383,4 @@ int mlx5hws_pool_destroy(struct mlx5hws_pool *pool)
 	hws_pool_db_unint(pool);
 
 	kfree(pool);
-	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index 112a61cd2997..9a781a87f097 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -23,29 +23,10 @@ struct mlx5hws_pool_resource {
 };
 
 enum mlx5hws_pool_flags {
-	/* Only a one resource in that pool */
-	MLX5HWS_POOL_FLAGS_ONE_RESOURCE = 1 << 0,
-	MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE = 1 << 1,
-	/* No sharing resources between chunks */
-	MLX5HWS_POOL_FLAGS_RESOURCE_PER_CHUNK = 1 << 2,
-	/* All objects are in the same size */
-	MLX5HWS_POOL_FLAGS_FIXED_SIZE_OBJECTS = 1 << 3,
-	/* Managed by buddy allocator */
-	MLX5HWS_POOL_FLAGS_BUDDY_MANAGED = 1 << 4,
-	/* Allocate pool_type memory on pool creation */
-	MLX5HWS_POOL_FLAGS_ALLOC_MEM_ON_CREATE = 1 << 5,
-
-	/* These values should be used by the caller */
-	MLX5HWS_POOL_FLAGS_FOR_STC_POOL =
-		MLX5HWS_POOL_FLAGS_ONE_RESOURCE |
-		MLX5HWS_POOL_FLAGS_FIXED_SIZE_OBJECTS,
-	MLX5HWS_POOL_FLAGS_FOR_MATCHER_STE_POOL =
-		MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE |
-		MLX5HWS_POOL_FLAGS_RESOURCE_PER_CHUNK,
-	MLX5HWS_POOL_FLAGS_FOR_STE_ACTION_POOL =
-		MLX5HWS_POOL_FLAGS_ONE_RESOURCE |
-		MLX5HWS_POOL_FLAGS_BUDDY_MANAGED |
-		MLX5HWS_POOL_FLAGS_ALLOC_MEM_ON_CREATE,
+	/* Managed by a buddy allocator. If this is not set only allocations of
+	 * order 0 are supported.
+	 */
+	MLX5HWS_POOL_FLAG_BUDDY = BIT(0),
 };
 
 enum mlx5hws_pool_optimize {
@@ -64,25 +45,16 @@ struct mlx5hws_pool_attr {
 };
 
 enum mlx5hws_db_type {
-	/* Uses for allocating chunk of big memory, each element has its own resource in the FW*/
-	MLX5HWS_POOL_DB_TYPE_GENERAL_SIZE,
-	/* One resource only, all the elements are with same one size */
-	MLX5HWS_POOL_DB_TYPE_ONE_SIZE_RESOURCE,
+	/* Uses a bitmap, supports only allocations of order 0. */
+	MLX5HWS_POOL_DB_TYPE_BITMAP,
 	/* Entries are managed using a buddy mechanism. */
 	MLX5HWS_POOL_DB_TYPE_BUDDY,
 };
 
-struct mlx5hws_pool_elements {
-	u32 num_of_elements;
-	unsigned long *bitmap;
-	u32 log_size;
-	bool is_full;
-};
-
 struct mlx5hws_pool_db {
 	enum mlx5hws_db_type type;
 	union {
-		struct mlx5hws_pool_elements *element;
+		unsigned long *bitmap;
 		struct mlx5hws_buddy_mem *buddy;
 	};
 };
@@ -103,7 +75,6 @@ struct mlx5hws_pool {
 	enum mlx5hws_pool_optimize opt_type;
 	struct mlx5hws_pool_resource *resource;
 	struct mlx5hws_pool_resource *mirror_resource;
-	/* DB */
 	struct mlx5hws_pool_db db;
 	/* Functions */
 	mlx5hws_pool_unint_db p_db_uninit;
@@ -115,7 +86,7 @@ struct mlx5hws_pool *
 mlx5hws_pool_create(struct mlx5hws_context *ctx,
 		    struct mlx5hws_pool_attr *pool_attr);
 
-int mlx5hws_pool_destroy(struct mlx5hws_pool *pool);
+void mlx5hws_pool_destroy(struct mlx5hws_pool *pool);
 
 int mlx5hws_pool_chunk_alloc(struct mlx5hws_pool *pool,
 			     struct mlx5hws_pool_chunk *chunk);
-- 
2.31.1


