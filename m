Return-Path: <linux-rdma+bounces-9347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBDFA84CC0
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077999A48B1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D32900B8;
	Thu, 10 Apr 2025 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B/FOCiLa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3028F93C;
	Thu, 10 Apr 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312731; cv=fail; b=rt69tyfHzjqxP4bDzJ+WawsUVVKyLnUkzSYbX1MYY5zi7+a3oImAAE/59BDmUUhJsyNNUZmPGc5VfDsuiSwVbd+QtHwt06OU3cca5OGgxBqp1XPRb542VDxUdDqIOo9DIk/vHtwMvPK2f3d5uG36ad5fGAmu1/v75BFTM6T02GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312731; c=relaxed/simple;
	bh=usLGynfChlOr8lhPdrRtxR5KiUcNVGA41PVd+Tsa9GY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fgdj34F/uF0SQ3BLluA6Cfa2JmLHtdMEW+M9gmzaVMH9UOITWDrsWJoc9y0IExP3V4WGWZ9u9moxvIE7OFLCEZ+C8BI4hw8eqgXUQGWVaQxc2iRVttAEME5aZAONVbH1NJRWyrqlPdZK6uiRb68KIRQpTSdCcV8bLts9Tvny4qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B/FOCiLa; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRE5mghL5Duo2eNwj/+BzP/jyVKYSnZD3B+1d2KnyGPjIkf3OpROlfUySdrvtHzPpNnRXjFSb/z0z6+1W6ncyGjH4LfnSWg96+NcOT2ExSiDYWNHh8qAknv7bAfDqn3gU5HUhHSCcxN5sKxNvKTLBbVKzIxatRnVFuFEbadz5o2GJID9P4O/QuC4i/Iqw4Xk9lm9yYgj7W+PhOdw3hoJ/s0qn3qiRSSdJhq+9CVvz5KzjfnptTvT9oqCrsK3k6NDPUAfb+/WT2J+/DdvaLeBi3bZ5ypohDEwAm5n7AimNmL+weRQoy8Yji7WVek9vUAWNtahfypJHxwRr8s+9d2MrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDDZA8lHBwZ1Je6GQqWlw12UxFPo82DMnI8b08iWeUU=;
 b=g7tHHFs4LDUT1hKfOaTZnOfY4+hC8TdAupaYatC2saau98p6br+terwsH/uDNJR5tG1qclHNScRBYd/7MiHIVGRqPSgpsQeFqs9djNagtrQmK3YCirA/ofrnnwxPN8M1/T7PjOgmaxsrZG458KMuH4sj1c2V9EU/zdQZBjvJnpdo4SCnoSC9nxWqhS2eUmWz0+zaohiqov/aX0QI14j8FlW7eBrX2pTob6HyNcMkA8Lrf8virP/bkicwnd2cI0JSpdoC/7C8GhgRzDcEd9AE0qovud04Buig/Q/oB4wecaNEqCGwqId044CcsTte59PHtrUvCRGK8zoIRtA/2Hdskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDDZA8lHBwZ1Je6GQqWlw12UxFPo82DMnI8b08iWeUU=;
 b=B/FOCiLaV7sCTNltg41H2RfgYoMKi6Y+AHAyOC6j88HqX9ql89EpkDQWAhGXfJpoYWVUvD0yGJh+x9+hLuoGpYEP+q20qri2io017S1UD6fkfvExqjmVRhMESCd6/UtDczzgkRrdB9HwOwoEKvqUnh7WO6V5Qu5m9WaAWMm6hE34auCiEQ8AbROA6P/5Ko93AbHaRvNsUCDKwgeVYdrcrYMZZPyltle6Vr0nDksFKT+a4uCdh5oVPHfGbnZMqKRD0byCilgDx86wvQhqqPuLtIq5f9p4Ah3oOS93OFFyrdAya1zReOzXtz8ou0kwIsNXOOGU+C1hin42ia2/AReCMw==
Received: from BL0PR02CA0057.namprd02.prod.outlook.com (2603:10b6:207:3d::34)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 19:18:41 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:207:3d:cafe::de) by BL0PR02CA0057.outlook.office365.com
 (2603:10b6:207:3d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 19:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:25 -0700
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
Subject: [PATCH net-next V2 04/12] net/mlx5: HWS, Refactor pool implementation
Date: Thu, 10 Apr 2025 22:17:34 +0300
Message-ID: <1744312662-356571-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: c02e7cab-1ff4-4585-d006-08dd78648137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QOOu9yZXKXVAjLYo1gSqAVktvyn4KMB4T8JScPI23ZH8Q/ZCbg1QYrKyEkzy?=
 =?us-ascii?Q?0nWyRLcCvxh4aVcn2aWWyvc/x3YjgjP8S+/eGQ1sWRhZqeKe+JoGowHcMWuP?=
 =?us-ascii?Q?Lwol9iyA5P2XAunp/pAUrO7SGIKfsClzYQjTEfyEVrAF7CKmtr3vmx1jjc30?=
 =?us-ascii?Q?BxJYK2KRBRQBTfzsF/jQtSHB1RcDmPSSqjD2cGE/O2M76s69mbTIWjMp9Nhh?=
 =?us-ascii?Q?dpeFqX9TnouDxZanbrEHdD91/EZOKaJHwWaxHLm9BQ2rC78KoqLgNA12XuKy?=
 =?us-ascii?Q?NbU9x7t7VoPWCFxhAsDc/CqLpA0peg+7p8QV3XH/iM9fPeTdsJbyaKm0JJz1?=
 =?us-ascii?Q?hgVPLOtnegSelI/pCGg2uEEu2bInb1oILt3IhNSjP7wKQ18+LrYIcNNXqSg/?=
 =?us-ascii?Q?WhvQMh/iyg9uS1G455mX1cRWOPBSY0uGoVl65lHo7sTqLKmMxFgP9S5CHA1m?=
 =?us-ascii?Q?IphHBZkGYeLxkSaMgMnhazofoJClqidaiGCTFPXiwv9JkODmnlBEzGWsD0nJ?=
 =?us-ascii?Q?tXOgZh7Dk6Q50wR1FZbnsFdrm4GzYbd/hyyWyIjrOifpz/UH7CQhFDClLGVG?=
 =?us-ascii?Q?N+8uNTsDQN5BxwLrNfUyMQTWw7eJi/aY8PF4OYcQcW1lD2pBaIzMRY7QDhMY?=
 =?us-ascii?Q?uX0+ZN6iXbYI2viGSQyYHJUJEfJgykO1dzTB9bvWlTj3mxXZZdeE5biLaQ3E?=
 =?us-ascii?Q?g6jhJn6r9YqpAjHXbTii1B6UblrN1264/LBX7wUUO9q43iWG3TsW/B2qfdrp?=
 =?us-ascii?Q?pOPn0AG5cT71wKXB+ChBXCoH55WDz/Vmg/p6Y4iffTl5ERT4cm8hdQX3sbn7?=
 =?us-ascii?Q?LAQ9V8v/O9jaZBP8rnKlZJ1WHHI60jpwPd2ghAJX3XoHsVFjSpIRggu/zpTS?=
 =?us-ascii?Q?8xOk+haNAcqJkYLsplasSy72z2szKgdc0s66kHyw0lwmctbkSNqBPMl4Z4/6?=
 =?us-ascii?Q?jVU53v2ILmekD1DrRwDEu7pQ4ijn44U4WJDHMS/yJtTTFI/JBgKretYsQq6J?=
 =?us-ascii?Q?16T+T2cPmQit6Rprhyu4LsmwCV22YQzZhauxRoHc1rPQnE7ggn5mKkzNmypC?=
 =?us-ascii?Q?nlsgf5Yhfzmxgfa9zSvOFPXrbUgKnhm+HqHhzKlkw+VLKD4mOkiJXcLKTs2O?=
 =?us-ascii?Q?F6EXwUNWsuh1fCrHE7Ur0nYID4w6arkKKFPLBto7vH20zP5tBBmsaq+AWWkh?=
 =?us-ascii?Q?OTsRGXm22zwTevYBlOD+qcW0dR3tnDG36+0W2+4Gp/Vb4fVN9U7Q1lozbuOI?=
 =?us-ascii?Q?GMixn1eK2TRRFYHf8M+py2VwYKZ2Op17BrBM95oqQuiv/83LxuHYTDIBISw/?=
 =?us-ascii?Q?wjz3W478bRaDIm8gT9uuNBSaxOOwLx8CWNfcdqlFcB4BCnXmflXspsaOhFP6?=
 =?us-ascii?Q?vaT1AJE85WEGhFfdSa0XCJytFgzWv+cI+4tBa7BrPbIEIMduJ0k+kHsLxB5l?=
 =?us-ascii?Q?zMwoyBvvffRcEk2VDjUf9c30ga7LFi6hyLJfhPfIJyexXlq2J7fc/+2kD988?=
 =?us-ascii?Q?gmJxsbn0fbkGqEc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:41.5523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02e7cab-1ff4-4585-d006-08dd78648137
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

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
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
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


