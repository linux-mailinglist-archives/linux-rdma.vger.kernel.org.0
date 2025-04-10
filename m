Return-Path: <linux-rdma+bounces-9351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D0A84CCF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03271BA4FE9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9B28EA5A;
	Thu, 10 Apr 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H80oVFCm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A328FFF7;
	Thu, 10 Apr 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312748; cv=fail; b=gKPPBB9azAuy/c6+DFDm2j0AaJj2GbuL7+rjHTFSCN9NgzUZiU/C7QEl+hF9SZs9GiWSazsLZ9/PiYPon7CtbZYHCnwKtfVqWFFHfIhNXgdy8t2311/t2pKIC6Nn8YVdS2nwInsQxkl665z1T0LYAcOZlhFbksTHkDz52nivAhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312748; c=relaxed/simple;
	bh=CN68HPTRWrKarOaaiXWM1PJWepn7YokGP0w/UjedFIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQ13CrdpP+9jIGk7P+FLbgp2L6BUJcWhJ0fuIHgI4a8UhIsSJ5wjqLmeHdXTcAMNJkN6mMsgsky1AM39KywpjR2TLyuX+Du6tEV+xirtW6YmUSTCofwReWAXIEWVth88PX3BDCE9pBGesdVogSyi6mf0rLCN7O8CC4wIl2styM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H80oVFCm; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fG2m0HKjq9WhUZYs3dIThOnF9FcfA3wq2fJcjXaqCOYOAZ3z9AQ4Ho5qS37Ccy5qbpME6GwlYwDoURGkGevOkxchOvb5mf048z6BXIUlFIl/HSWFeihdMga2D/5Cr2ibPudNef7d9BUhnloHHVolrcJqz4Ak2uJYneuYjBfIb61HReQe8j1tgdIV67SF/C1FE16gBAmTlb989gVaMxOtB3MFXMn8znK/XITKEeuN3t3VEkfBUcMtFrUvwHMp5B6wbZYeuQuKCubNy/Uy2QaQqVrmvgf93qQFKl3694HXfZEEgUbg1KDHF5Son6toKgRDAc5epQDUo22D+YYzGrchew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azPN/hZCmcOqR0XJELNcmBtV/iQH5JG/L7rt2bucZRE=;
 b=DHKnolxiafhoWEIaNOly5QaVwywIUFSgA6qYwIGGo2elqTifugB0l5q9Otx3mlhWR2Ecf9AMr9vkXhXTTZ2Kkqb3jGb7/ymYOMecOSWvBFrCbgy0HaGk8YMlEbetl37iDM0v18orSG2VJqaH9g3RueR+8kALBaT2l/URcldECoNKfWXoGfmftBmcx1LzKQmUV3GES/L0c8srp5Ii6wn4Y34VMNOklbuBXEyi+lw8L0TA/pDMKIGj3w5VBRCvJ49W02rfzkhmQKHf8J9+zLeGnLgE+Ac3k2PXjYt0j9+LKSgn+/qyx/wD+OrUrVB1wxTzcbbP0jyPB+BKBBAjTlZz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azPN/hZCmcOqR0XJELNcmBtV/iQH5JG/L7rt2bucZRE=;
 b=H80oVFCmbJGGu7Clu0wJhv9EM/KP3SF3ABMMpG69vMmrMICFLP0KwvSvLAiWG+4MR3s3fzacU5Te7zGFnO5Bhf0478oVC+iIs8tFuBLFdZp9tMlxORf0ZI/b7+BIgju7XGTiB/I8O0RpqX9JFKV7v7sXGPizoimpkurLZjKTfFNKjeAt1TIu3VjzYiivVJ1yAln46BA8pdCBHml0C4AwU4OhiVt9ekEgs9EfyTuXVK/sLNTwzU6aNlJyINQ1UFkFFkQwB19mN4Ti7N5a9XTpsN9NSy9bWXktCISax1f9IHVe2Pi/yWZmq62FGfQGymh7XsCzXuGm+Mu9yrxZ5h1rmg==
Received: from BL1PR13CA0312.namprd13.prod.outlook.com (2603:10b6:208:2c1::17)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 19:18:58 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::52) by BL1PR13CA0312.outlook.office365.com
 (2603:10b6:208:2c1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Thu,
 10 Apr 2025 19:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:47 -0700
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
Subject: [PATCH net-next V2 09/12] net/mlx5: HWS, Use the new action STE pool
Date: Thu, 10 Apr 2025 22:17:39 +0300
Message-ID: <1744312662-356571-10-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b409416-0023-419b-17b2-08dd78648b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b4+blppCML6VayBieXAmRM4M7p6puwG2aWsMqI81w0xN1+5OERqzad/kkX9B?=
 =?us-ascii?Q?NCGJXsurkSLPFH/frUvOz+St0xb+803IPx0UbSh1sZCiL63Zdi9nZgiooiiJ?=
 =?us-ascii?Q?ZKii9vxlEUHgqHtkg5KhWGZxjuyGOCvsqnjaAjGVnE+LeFxlEw2+gXvsQsdX?=
 =?us-ascii?Q?xsLp08A1/hrWqHYBY1hSe3/z5+HhttFhm62h++BEppqSm7ybhbw8UQbzcUcz?=
 =?us-ascii?Q?DqMqomPG4910Q6UNv6THrhAUtEbcGtLaBYs6f+V8CwiPdIJpmTb8mlqthYnV?=
 =?us-ascii?Q?2MgTuiQMCWpol1y13Ts5XJsmw9ZQDMWVndhBhwn0av+KgrBB/mBNAZTjK+h2?=
 =?us-ascii?Q?7dR/jtrvDSFYv8gLI5ama+ESbO82cTL8NmVX6YH+Xr5ycS6d36kE1n3gybQC?=
 =?us-ascii?Q?fGazp57ElIo4Y2M/gf1jXBJmh1VIK7qQaF+MFa2x/1ASkP5GtaKVay/yDUdz?=
 =?us-ascii?Q?/pXZT+5Lrj1lDoEPAQMsuObnN1iTw251RbDiYNWqrGpg635DLARf3HSE8ybG?=
 =?us-ascii?Q?N8VibeXARLK0reEIuziBAmjKEK2hTBj6F31WlPYpFWttUuNEHvpNrGLtVOgK?=
 =?us-ascii?Q?1/YJYgyz4fD3L+lzmenMk7NV/2l6YLal5Hq5AALhm3+ZwuFPgft6GV6ha9Az?=
 =?us-ascii?Q?MKVNE5JLrWodcMMqxuxOv3PV56r2WDqex2AtaWyjYciOthM8MJAUdSPy+wEH?=
 =?us-ascii?Q?yh7UC1BS+aU0s4nIzhY1fUMNGdPkeLQU5MxKR6oZh51ejPBL1FocdM/UTIIL?=
 =?us-ascii?Q?/n3OwhZ8X+q2fKzI2xGzod5+FfnS355VnLsLcPPKIlJlcx+HKMMnwLeEg1q0?=
 =?us-ascii?Q?jT+NUAKBaEpx4uxi7jpcvmMDRsD22ggmSu4lfEoxiz4ZjF9JkYU5SkGYaFZo?=
 =?us-ascii?Q?DE1e8wAnDz6w/Qas8MdQkcUVpVEJKTep33FQ1wJCvVSbrAF0cIj3rY1BDidD?=
 =?us-ascii?Q?3RWRGD0zTjJP4VPcLxotWZdYSmja8oi5CrwH0j/+j9FbxrUO6A8ORVfWYlGu?=
 =?us-ascii?Q?564xDIzJVWmktT8FQrafWMTmmNLYDXeXex2p7VTFrrJVsMQIgs4XxPhBuVuS?=
 =?us-ascii?Q?t/eAoHS+U3O98PWbtTkqyY5ZAFVXkdpvxYFSg8MQDyvORUnNgEz1UuLm8Lm6?=
 =?us-ascii?Q?K/Q6SuG81NFxQBCoRgYHwz0EnTsjmwlpw1/dhyHREROETBI7PksIsZGhp8BH?=
 =?us-ascii?Q?Hk6mqKxxz0S1RwRcLWho7tWhCm4QELMkVbNMmvP1aU3f/hqDZt1kw6AK8J+Q?=
 =?us-ascii?Q?nEGQwoFbFD1EMus2bZEC+kIuJONRsl9G/Cl+L1rmnQzBiXqotW6VLnfyjiMi?=
 =?us-ascii?Q?7awGW09TdxnZNW64o6bKzrC//eqLzPpkTEa5eG19qF9auUbO+rN6I7DXkejU?=
 =?us-ascii?Q?qvehW59JLc32RMnUk7OA5yywih6EGlBzqgPpks80h8HuQtzJ9RUfnUVuaCpM?=
 =?us-ascii?Q?yF26BmS5qs9IqL1mqN/++zzw9h4fm7J+b+z3iN7jc2ETbYFBzjKg+A0dnCpa?=
 =?us-ascii?Q?E3MLwlEIu3UpBEk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:57.8927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b409416-0023-419b-17b2-08dd78648b01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

From: Vlad Dogaru <vdogaru@nvidia.com>

Use the central action STE pool when creating / updating rules.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../mellanox/mlx5/core/steering/hws/rule.c    | 69 ++++++++-----------
 .../mellanox/mlx5/core/steering/hws/rule.h    | 12 +---
 2 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index a27a2d5ffc7b..5b758467ed03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -195,44 +195,30 @@ hws_rule_load_delete_info(struct mlx5hws_rule *rule,
 	}
 }
 
-static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule)
+static int mlx5hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
+					 u16 queue_id, bool skip_rx,
+					 bool skip_tx)
 {
 	struct mlx5hws_matcher *matcher = rule->matcher;
-	struct mlx5hws_matcher_action_ste *action_ste;
-	struct mlx5hws_pool_chunk ste = {0};
-	int ret;
-
-	action_ste = &matcher->action_ste;
-	ste.order = ilog2(roundup_pow_of_two(action_ste->max_stes));
-	ret = mlx5hws_pool_chunk_alloc(action_ste->pool, &ste);
-	if (unlikely(ret)) {
-		mlx5hws_err(matcher->tbl->ctx,
-			    "Failed to allocate STE for rule actions");
-		return ret;
-	}
-
-	rule->action_ste.pool = matcher->action_ste.pool;
-	rule->action_ste.num_stes = matcher->action_ste.max_stes;
-	rule->action_ste.index = ste.offset;
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 
-	return 0;
+	rule->action_ste.ste.order =
+		ilog2(roundup_pow_of_two(matcher->action_ste.max_stes));
+	return mlx5hws_action_ste_chunk_alloc(&ctx->action_ste_pool[queue_id],
+					      skip_rx, skip_tx,
+					      &rule->action_ste);
 }
 
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule_action_ste_info *action_ste)
+void mlx5hws_rule_free_action_ste(struct mlx5hws_action_ste_chunk *action_ste)
 {
-	struct mlx5hws_pool_chunk ste = {0};
-
-	if (!action_ste->num_stes)
+	if (!action_ste->action_tbl)
 		return;
 
-	ste.order = ilog2(roundup_pow_of_two(action_ste->num_stes));
-	ste.offset = action_ste->index;
-
 	/* This release is safe only when the rule match STE was deleted
 	 * (when the rule is being deleted) or replaced with the new STE that
 	 * isn't pointing to old action STEs (when the rule is being updated).
 	 */
-	mlx5hws_pool_chunk_free(action_ste->pool, &ste);
+	mlx5hws_action_ste_chunk_free(action_ste);
 }
 
 static void hws_rule_create_init(struct mlx5hws_rule *rule,
@@ -250,22 +236,15 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 		rule->rtc_0 = 0;
 		rule->rtc_1 = 0;
 
-		rule->action_ste.pool = NULL;
-		rule->action_ste.num_stes = 0;
-		rule->action_ste.index = -1;
-
 		rule->status = MLX5HWS_RULE_STATUS_CREATING;
 	} else {
 		rule->status = MLX5HWS_RULE_STATUS_UPDATING;
+		/* Save the old action STE info so we can free it after writing
+		 * new action STEs and a corresponding match STE.
+		 */
+		rule->old_action_ste = rule->action_ste;
 	}
 
-	/* Initialize the old action STE info - shallow-copy action_ste.
-	 * In create flow this will set old_action_ste fields to initial values.
-	 * In update flow this will save the existing action STE info,
-	 * so that we will later use it to free old STEs.
-	 */
-	rule->old_action_ste = rule->action_ste;
-
 	rule->pending_wqes = 0;
 
 	/* Init default send STE attributes */
@@ -277,7 +256,6 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 	/* Init default action apply */
 	apply->tbl_type = tbl->type;
 	apply->common_res = &ctx->common_res;
-	apply->jump_to_action_stc = matcher->action_ste.stc.offset;
 	apply->require_dep = 0;
 }
 
@@ -353,17 +331,24 @@ static int hws_rule_create_hws(struct mlx5hws_rule *rule,
 
 	if (action_stes) {
 		/* Allocate action STEs for rules that need more than match STE */
-		ret = hws_rule_alloc_action_ste(rule);
+		ret = mlx5hws_rule_alloc_action_ste(rule, attr->queue_id,
+						    !!ste_attr.rtc_0,
+						    !!ste_attr.rtc_1);
 		if (ret) {
 			mlx5hws_err(ctx, "Failed to allocate action memory %d", ret);
 			mlx5hws_send_abort_new_dep_wqe(queue);
 			return ret;
 		}
+		apply.jump_to_action_stc =
+			rule->action_ste.action_tbl->stc.offset;
 		/* Skip RX/TX based on the dep_wqe init */
-		ste_attr.rtc_0 = dep_wqe->rtc_0 ? matcher->action_ste.rtc_0_id : 0;
-		ste_attr.rtc_1 = dep_wqe->rtc_1 ? matcher->action_ste.rtc_1_id : 0;
+		ste_attr.rtc_0 = dep_wqe->rtc_0 ?
+				 rule->action_ste.action_tbl->rtc_0_id : 0;
+		ste_attr.rtc_1 = dep_wqe->rtc_1 ?
+				 rule->action_ste.action_tbl->rtc_1_id : 0;
 		/* Action STEs are written to a specific index last to first */
-		ste_attr.direct_index = rule->action_ste.index + action_stes;
+		ste_attr.direct_index =
+			rule->action_ste.ste.offset + action_stes;
 		apply.next_direct_idx = ste_attr.direct_index;
 	} else {
 		apply.next_direct_idx = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
index b5ee94ac449b..1c47a9c11572 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
@@ -43,12 +43,6 @@ struct mlx5hws_rule_match_tag {
 	};
 };
 
-struct mlx5hws_rule_action_ste_info {
-	struct mlx5hws_pool *pool;
-	int index; /* STE array index */
-	u8 num_stes;
-};
-
 struct mlx5hws_rule_resize_info {
 	u32 rtc_0;
 	u32 rtc_1;
@@ -64,8 +58,8 @@ struct mlx5hws_rule {
 		struct mlx5hws_rule_match_tag tag;
 		struct mlx5hws_rule_resize_info *resize_info;
 	};
-	struct mlx5hws_rule_action_ste_info action_ste;
-	struct mlx5hws_rule_action_ste_info old_action_ste;
+	struct mlx5hws_action_ste_chunk action_ste;
+	struct mlx5hws_action_ste_chunk old_action_ste;
 	u32 rtc_0; /* The RTC into which the STE was inserted */
 	u32 rtc_1; /* The RTC into which the STE was inserted */
 	u8 status; /* enum mlx5hws_rule_status */
@@ -75,7 +69,7 @@ struct mlx5hws_rule {
 			   */
 };
 
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule_action_ste_info *action_ste);
+void mlx5hws_rule_free_action_ste(struct mlx5hws_action_ste_chunk *action_ste);
 
 int mlx5hws_rule_move_hws_remove(struct mlx5hws_rule *rule,
 				 void *queue, void *user_data);
-- 
2.31.1


