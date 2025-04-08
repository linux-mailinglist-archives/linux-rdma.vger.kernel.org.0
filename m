Return-Path: <linux-rdma+bounces-9260-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2748A80D71
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA651BC164A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FB022B8D9;
	Tue,  8 Apr 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FGEr86tJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402C1D517E;
	Tue,  8 Apr 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121010; cv=fail; b=HkU5H5ONJ/FFfh3iMGRTqLZlnIHekCKvHh4bL3CBGLcqBH5ctPdONFSVuhQjUCqEZdPebZ5iiZ/zVKN+M6rLQqolRiPYDqPyczJb5o3qWXdYzRxrr4aYGiAJkdZD0f2RswnB85cmNxyQJT0X4p+Nrd5lCGnc5s7++GnrP3iRnCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121010; c=relaxed/simple;
	bh=L88NRETtP6sqszPwc5BIf7Mg4JJ6+YhPbIDJhhKU8Og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9nGtQhrszFhrU7DrpnP/jW9qnPiclHWaVSq11aPeBYnAHtRQ0VJ4OY7KNoSnCZuU6hcshlckILgL//yaFvIQEGc8uoS/azdfTefb9E0T1kb79boq0swLlg0OnKI1HEyLSsAZqkurYDAHp7iNudbe3cJN9hPbsWvn1r1Y7AtOQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FGEr86tJ; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgMtXTsyEQnw4u1tPG1vsP0HqRHyim6pKOnmv9uMr18dkgJZtcml0Svk76p5OmOvj+1dzzJOi5OJWv7qF4DIXa8djd9firdHJZQKPlbblBYiJ+VYGCIbImqyBP0JxeGS8ZBJDzXJSKDscfPTcxFo4TbhW/OFXn5xG+3/NKrje9eTme9nLtulwgmOU1q7RuMjoYiLqtLl9hElnQq3rfs6iXrKiIfuqqcYUyDB4xt7xhEgF0EhRZlUQRyAsabq40ugb4yeXKiINJju+cbu4NALoWMAjXEsQ/Z6AE4aTq0tNBhZJkC1oFu5kyhWk3M7ZafmNHyytVqwPTdOKFnUVErXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xrl95zic3GqpyBI1jJoUO7UkFWTH/Py7OlBLIbK9Sc=;
 b=usuXYZEn/FBNFQhHu2UIdnmrEp62UqQF7z0xJVXfGXYfh1R4PKqXPCii/f41FiS9vqU3iFddVgn+pISFkUzkUC9zZTDuF5BaRrjdck+VDE3gA08tiz1ucI9qGThVudAEgKIZxD9bfTdzPZxFfzqSyw4x9iR1gu9G0T7JiXP775CsAKUtghARB/zs8DqWJyAKVMqjvUoMx0keu5rbEIRZCS/JaRd6VcTwTdcFcqWHfKaPgcE0Tsto1XBGRF23SK1aJmPHCpeV0G4kTjTMbJSSQyvJXvofq4tWO/LiLhERL+kAKBg2ipoCSl78Rqmus+SNvjSeXTr1p0WTEi9fMc/MIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xrl95zic3GqpyBI1jJoUO7UkFWTH/Py7OlBLIbK9Sc=;
 b=FGEr86tJsJ75SJ4cvXxg55vuare1YjPy/mXwO9UBRPExEYXqVXB7cIbBDtUWi1aHAbIgMBKPsuEjO3d1i/kUrZPtjlQRoFSbcBIN7MwAbSBhR5McdTr42R1pQu+rDPlpqsgQVftco3EJFjEuU1B35DkO+cw7f5DLYKqQHvPelqwRPmUMGvgY62QCg65dy8EnPW9KwUBNJNeECCIUbvg+ZYHHuUFc9ua4D0YNUTTm66o1vhfrBaNfOTaScJhTkq57JGhw0gaylu+67KTyHW3dx0KRPOXq9zOFHhyvxBq0+Qv9njhdvCJjtrFpJlFIrXGvcGwlW7kWjehOEwd4I1NFVg==
Received: from SA9PR13CA0021.namprd13.prod.outlook.com (2603:10b6:806:21::26)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:03:22 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::b7) by SA9PR13CA0021.outlook.office365.com
 (2603:10b6:806:21::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.11 via Frontend Transport; Tue,
 8 Apr 2025 14:03:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:03:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:54 -0700
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
Subject: [PATCH net-next 12/12] net/mlx5: HWS, Export action STE tables to debugfs
Date: Tue, 8 Apr 2025 17:00:56 +0300
Message-ID: <1744120856-341328-13-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 471e252a-63a0-41c0-be57-08dd76a61f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sl3JWOTSxsYzkf5YTHzRmAgSGCSmDMjxPFW3xdyZ1ESEE+ByBtK3nTAVXBbP?=
 =?us-ascii?Q?+1ab2UibIuhbANqxd0Pai7w6oV0oun2nxYQRsEDJN3koOnTDJKerNYRLcKMS?=
 =?us-ascii?Q?we6ZMyMl6QQCCF5ynHGYLGEwSWuFXQ8wmj+YjcLmr21xRQ5WlEYdnvREfgZJ?=
 =?us-ascii?Q?bqSmWF6xSk0Xjb97aRoI/mWQ8hkow/xUzWkl5THGwmmeTu16AEFFs/lFXWC3?=
 =?us-ascii?Q?o4pfeH9Ok9F/Qx7oBJLxb/wl6rqDn3TZa0we6MW1I1BFASAqZeJdBUUyraCh?=
 =?us-ascii?Q?wW8n+aJebKDo2UgCPVy9qTXkurAs8WnteJ1SMQBxe9sULUwvkerQKIbhdSOw?=
 =?us-ascii?Q?feBzsP449QYDMlaMtJcz40FNk00oyA21GznKnZfUeQb82UtZT2DWhmrpgvTI?=
 =?us-ascii?Q?tyZQCIjvekYla3zJTH/pa3MXsu6PW9fXewG2ZME9nAZeg8lx/g7n2uiV/Qy4?=
 =?us-ascii?Q?aVChGvdewMViANhb5Z/YK+9v5femRPe91P8lIabVv/1dSSQHmjObTlXFtIZi?=
 =?us-ascii?Q?xkPZCU6vA3We86xY+uG/CJyhp0T62wi4+ufFaLe+GfutlmMUcDwtgzpMWPLe?=
 =?us-ascii?Q?IuoDbKp9zLEmNRxlf9o2onxcuHwl75dOoSYb/tAD+4fjjVXvvWoKArJefFQD?=
 =?us-ascii?Q?CcFwNTzSVtBvB4T8QslYUCYYzADb0dSTyMFxrYoHNfgu0TLnowJfhI5qdkcQ?=
 =?us-ascii?Q?1BoEmQGXn2Cfi0kUhDikGbg0YCw/fVXb6aVZQsAIequmrbmNpWa+PVSJbAHP?=
 =?us-ascii?Q?vIy3eZbdtWcKq3KYfZM6oedvp1+kJJjPPLtl90+VvJLeOmsma+215xlcjS1w?=
 =?us-ascii?Q?AYy26gO04JWOpHTG2lL3Bu+KxP6/9clxjITTcMG5+TiiwDSRUiBGAW8L9bv0?=
 =?us-ascii?Q?vladg6VajbmhC0KyHNYtReNi4dxj9dI94fyphANoK2n9T+sdeWPblnQjzvvR?=
 =?us-ascii?Q?eFdKApUV+y/c6OjeX9HtcZ2PwX5RskFlE5rOYe+K15PPeHDzJNzpX0i9ImhH?=
 =?us-ascii?Q?K5gxFv5kodJ/hbzEzShQ4FsMzVSbUmh4LsZA0ZVCZFI6T8Z5KiNQamidCCd6?=
 =?us-ascii?Q?geocFWv2R+egDVO+puFx0navnaw1sg6nHF+lH6fQcLTmHFx2SSsaoDW9mSbe?=
 =?us-ascii?Q?ZrAo9JcrlreY02raqMBUdk0wHv+f5qVI9dDVqxg2i/YDfzmasO0eLJDCiBxL?=
 =?us-ascii?Q?X4ejpUmPwTbX8F5Tc8BSEC7E7CwqIgyFMvZIj1IaqRVUpjeosarZn4GnPHq/?=
 =?us-ascii?Q?r54e/7CXwxAYohvPatGj6cFbQjsVZK+tZRRl6L4JCwgwSb+QwYExBQJCjdAL?=
 =?us-ascii?Q?Ax/D3oSDsqfnzmp0QddbaEYP7Uk8h/+2yN93mdbMG3SYj61o80dSI7o2+zJC?=
 =?us-ascii?Q?JeGO5mAvV4v3r8LhbCm+RMHT8DRxciDFj7NvbmvnhRPeQLsXBXCqd79QRtVe?=
 =?us-ascii?Q?s44F86PfBUDzdj3auNnx06kPW6mtpPHyUKWH/zuPR/QOaxyx2UC1vkxOzeru?=
 =?us-ascii?Q?KK4vzjeNMSGXf++pOuBUfDZtg78pJ2ZgOhLD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:03:21.5130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471e252a-63a0-41c0-be57-08dd76a61f39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

From: Vlad Dogaru <vdogaru@nvidia.com>

Introduce a new type of dump object and dump all action STE tables,
along with information on their RTCs and STEs.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
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


