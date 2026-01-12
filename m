Return-Path: <linux-rdma+bounces-15451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B81D118D2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6AAE30504DD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116234CFD5;
	Mon, 12 Jan 2026 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AmPeYFva"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2FF34AB0B;
	Mon, 12 Jan 2026 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210881; cv=fail; b=giCjMqj08HogYsm7iJdoYGJKroNhSEjbRau45fQK2nCT+kPzJu11nx1T8g6O/67gSOa6Xrco6LUSAhk6fz+YO7z3VWLHbinAn/xzM61uHjyBiV6PbJFEKy1XDlTiLcC53AlrFv0mbsN0ZSflTYJBA2ir3cWfTMABou9GWYuRhuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210881; c=relaxed/simple;
	bh=rbDubrL/IFp4o5g2XhEBE5XZo7tuvHQcuj9fQCIDEcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS7Jx+kOMy4RxtntfuFzAsJtRFrayqsXWpkjce3GBUu1LGA0ZqQOUAschzU/pBfnO1ckUFEAaqOWEBajDYukO66Ts7imw4hrF82PdlGRYKKdiaNXm+dsPIhRUyFZK/bspMsvEhzFX4mvL2xUgfyvl7B8ecU/jGtiKymr4CjOkII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AmPeYFva; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPagAbSJJaVKVy1LvEKuC6fgvn+evIePxRiDEvOXlNGr3UyAEntrrrs39NAmQcXHsOxGP6/ezRrx/09AsiExbu2CW3mf0T5s7aAs3Z6qz+mI11IPIZZzv0m5KJnz1ZdwuijLCyuQgD3zof2nVK41/6Nkk3eUYK76zVu7hDDfw0AGiAAKlBZQ3ipTD9sqVYRuo7vRg5QKB+apJ1mBijerUThDBUg+VAhzRAHmMoFjIt5mLzQo9KPQT503KaV8sn6gNjS7/TDJviunqPsEZyCPRJKyMHG5Pndpm5FrWyYpopoiDaRNJgRuMzgq63Hd7DfayEwx09hfsQp3vHurnSaE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vAIirAMJG7ZIz7/43kyjqKUfCFLUDsdgsu97uDMHl4=;
 b=ONT1EzYjG+mjX2voNkyyN0h2rJZ0lBBoVfu7L0ZroxbRtsG+E0TDL3M/r54FVluiPwp3RHYI+y1YAnqHqUI5zA/mtHusp/AaIq3AU2b2pkSTT36xfSCga28eiS8FBkydm2CamUV+0TYTkHY+vAPS89R5shhaCxL8O6x4vrhSGJlzSc02mmTY8SdNYeHRZ8AgqpGtEN2UzKB62g6MiSbCG7qGtraVfPU55aB+JllWmLAn9Ee3zNBv34B/WGcZtJmJ1414xVt9vZaCdbXJ99Ry3iKM9VHkFZy9EkmjDLdatf4gzaNNCqDe6l06n9j1CCDFz3LdCRoXMZBNN2a9btXSvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vAIirAMJG7ZIz7/43kyjqKUfCFLUDsdgsu97uDMHl4=;
 b=AmPeYFvaIuhp+LErVX4HWpI2bxJHokBtvJPw+T1ltur1X3c78CO0U5OWSU9iRe9lioTRUA9T5wZeL38tZy+c5KkAtjLXlwbR0oRXJuoRt2SFiXtWK5l/Y9ReIhQSRPptiB+Raa1L2lSCQ/RzTo8g0WCuPR0LM9aK6GBf52xOmtUrCKPH4X98aMrjxlvF14OU3tbmUAKlBH0eMIQCtwPvPLYqphFLiKWy++D1hy2EeAX18Fy9zsD5XTbVly/YLje37EALgXgSt9Uv8OsP5oXIG5eYvt6iFm2QajxJG4dSw/uYSqawdHNSkkYFrE/PEQinLaw4sF6rvojA32K4CkrVOA==
Received: from BLAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:36e::22)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:41:07 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::3b) by BLAPR05CA0016.outlook.office365.com
 (2603:10b6:208:36e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 09:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:41:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:52 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:40:47 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: Initialize bulk for single flow counters
Date: Mon, 12 Jan 2026 11:40:25 +0200
Message-ID: <1768210825-1598472-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
References: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 043d2753-c010-403a-47c8-08de51beb61f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y2oOyEzFhUbeDuo/5xpYtwZPKL1l1wCw9AU3vRPK3tJRHtD2pIfK+YklNhMr?=
 =?us-ascii?Q?wL+2IBmjqO/AWj5Q01P0MMrv66lxtlSjb/ZcjANL4NOoLVGaviXk5R7U+qot?=
 =?us-ascii?Q?WjagnwBq3PmWB0AGbzdcBDp/XrgqkymBDlQeL123joKfj2Yt9Kp0jNva9SHW?=
 =?us-ascii?Q?qhNYJ6S8VxiivDYrsCrPxegfLcs5vXTNz7jRp6O5ItzCPmdZRpVNgwfzZ3bs?=
 =?us-ascii?Q?y8bFatBeBXTAZnwQDSic58ov1x3OjwnVe/vnKvwNY4IH7JNhlYhDH0VMU6Y7?=
 =?us-ascii?Q?yYxpPzoYni70CWfmiLi99Y2K7Ur0HeMTGHmNyQcRf9ugaGXPsUzYjyPWzYzn?=
 =?us-ascii?Q?wr6DKCPd+VZUM5oY/TKh1H5TUY5TyR3Et/m22/xixPV9cLE4SxzfYjv8SR8e?=
 =?us-ascii?Q?Bdb3XtqAci5OjmEaD47lKe6hHrQHnIHIlMw/mdY8fCNQbqywFTIYdnXTK1VM?=
 =?us-ascii?Q?YIOXzMI9JLqBDPmFbMGZRfih/9VGoatOoNsRUxsRxF/4sSgX42FR7xJDyk78?=
 =?us-ascii?Q?BXvOPnisYFJhfQI1RzI725fcO/MnRy0GBL8Jp5JIYBLcgqerzBQ1TQyHW+F1?=
 =?us-ascii?Q?SHfL3Pvas1EyhpOL4BKXj7BAaJODSDa2b9PFxR+yvp7z6fqKtx89dxMTRouY?=
 =?us-ascii?Q?iz+AOo/P4z7eLpuv8wuFNOjjXzdio4kQgUAJ9RWWZnhTZOLz2lkcwH5KokOI?=
 =?us-ascii?Q?3xfWpuZrKNaHyaDRQI/PQKXA1RgKHqBBHqIOEl50fVWxnFQKM06J1oKbPW2Z?=
 =?us-ascii?Q?CcO/GX7s6baCJ2QIs0mQJAO1pzvmg268YX0ve7B7fA8KS1e8I3j8KFFXYU3k?=
 =?us-ascii?Q?Dw1eLyLfk5efYz6Sb8D8TuGf0A5W7gsWraW5K5IHtVJc3GJ+AFLlpi8Gh4uv?=
 =?us-ascii?Q?0MwgXN6MFNLdgiDc0jkACPWLs1gHRltSKf9bAzBI5O2ppWXSOEf0CcQT+fpH?=
 =?us-ascii?Q?BS5NEomp6M+SuJFqFdl3DjMSzocPLjvlfYaIl2jrC0AtlDb8dG748aH4e7nM?=
 =?us-ascii?Q?2iP4F5XXaxMvEV/UdHEylfcBCLZl7g4p8obdnWFS/5IYjoSkH3vCF4uUXWyV?=
 =?us-ascii?Q?AD9gXeCWFrcT9TGhC3AjrzxSg15jtto89vBSEQF5paL9dNg5B6ThX3oZR5dV?=
 =?us-ascii?Q?Qlie6el0Ef9rm3AGH5u0ByPmGzI6J4CkV5yqXuW4pw5nTMorOGE2nN3UwnYf?=
 =?us-ascii?Q?iT3pd+rTHTFWXQ1ybi5PCuGIpTz0cCUmWYUVp3esGMrolqoI3P01kjgTi57q?=
 =?us-ascii?Q?VXIi4wngBgn3wQsb01heKS5H59Zxvv8M8RQ+RTx/EKHlg10YFdBiAUa9g7KY?=
 =?us-ascii?Q?n43as8WmwpVwuPzhbEJroIpa4v2Z+LTJs6Q0HbPFxeE2O5dTFASoQ883+tPg?=
 =?us-ascii?Q?qDjxcUCGVIuacsQ3f0ZMgONdqAJj+cpWSa47YwvVBEWvjxo4hIoyYrzH1kA/?=
 =?us-ascii?Q?rzMlJqM5gctXjZv/iHr/zAtTftM4BJCFqnnpR1mz2k+LfENjhyN6N7Y4HXbv?=
 =?us-ascii?Q?4RXGEJCHhKf+xA69Kif3gku4rgESiFCG5vomPlIOj7AYPpPEwAUE22SWebbN?=
 =?us-ascii?Q?jjjtiFakmiMM3L4sqCs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:41:07.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043d2753-c010-403a-47c8-08de51beb61f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

From: Moshe Shemesh <moshe@nvidia.com>

Ensure that flow counters allocated with mlx5_fc_single_alloc() have
bulk correctly initialized so they can safely be used in HWS rules.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  3 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 39 +++++++++++++------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 1c6591425260..dbaf33b537f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -308,7 +308,8 @@ struct mlx5_flow_root_namespace {
 };
 
 enum mlx5_fc_type {
-	MLX5_FC_TYPE_ACQUIRED = 0,
+	MLX5_FC_TYPE_POOL_ACQUIRED = 0,
+	MLX5_FC_TYPE_SINGLE,
 	MLX5_FC_TYPE_LOCAL,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 14539a20a60f..fe7caa910219 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -153,6 +153,7 @@ static void mlx5_fc_stats_query_all_counters(struct mlx5_core_dev *dev)
 static void mlx5_fc_free(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 {
 	mlx5_cmd_fc_free(dev, counter->id);
+	kfree(counter->bulk);
 	kfree(counter);
 }
 
@@ -163,7 +164,7 @@ static void mlx5_fc_release(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 	if (WARN_ON(counter->type == MLX5_FC_TYPE_LOCAL))
 		return;
 
-	if (counter->bulk)
+	if (counter->type == MLX5_FC_TYPE_POOL_ACQUIRED)
 		mlx5_fc_pool_release_counter(&fc_stats->fc_pool, counter);
 	else
 		mlx5_fc_free(dev, counter);
@@ -220,8 +221,16 @@ static void mlx5_fc_stats_work(struct work_struct *work)
 	mlx5_fc_stats_query_all_counters(dev);
 }
 
+static void mlx5_fc_bulk_init(struct mlx5_fc_bulk *fc_bulk, u32 base_id)
+{
+	fc_bulk->base_id = base_id;
+	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
+	mutex_init(&fc_bulk->hws_data.lock);
+}
+
 static struct mlx5_fc *mlx5_fc_single_alloc(struct mlx5_core_dev *dev)
 {
+	struct mlx5_fc_bulk *fc_bulk;
 	struct mlx5_fc *counter;
 	int err;
 
@@ -229,13 +238,26 @@ static struct mlx5_fc *mlx5_fc_single_alloc(struct mlx5_core_dev *dev)
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
 
-	err = mlx5_cmd_fc_alloc(dev, &counter->id);
-	if (err) {
-		kfree(counter);
-		return ERR_PTR(err);
+	fc_bulk = kzalloc(sizeof(*fc_bulk), GFP_KERNEL);
+	if (!fc_bulk) {
+		err = -ENOMEM;
+		goto free_counter;
 	}
+	err = mlx5_cmd_fc_alloc(dev, &counter->id);
+	if (err)
+		goto free_bulk;
 
+	counter->type = MLX5_FC_TYPE_SINGLE;
+	mlx5_fs_bulk_init(&fc_bulk->fs_bulk, 1);
+	mlx5_fc_bulk_init(fc_bulk, counter->id);
+	counter->bulk = fc_bulk;
 	return counter;
+
+free_bulk:
+	kfree(fc_bulk);
+free_counter:
+	kfree(counter);
+	return ERR_PTR(err);
 }
 
 static struct mlx5_fc *mlx5_fc_acquire(struct mlx5_core_dev *dev, bool aging)
@@ -421,13 +443,6 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
-static void mlx5_fc_bulk_init(struct mlx5_fc_bulk *fc_bulk, u32 base_id)
-{
-	fc_bulk->base_id = base_id;
-	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
-	mutex_init(&fc_bulk->hws_data.lock);
-}
-
 u32 mlx5_fc_get_base_id(struct mlx5_fc *counter)
 {
 	return counter->bulk->base_id;
-- 
2.31.1


