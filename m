Return-Path: <linux-rdma+bounces-9255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D9AA80D65
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6F342768C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FAB1E3DDB;
	Tue,  8 Apr 2025 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDZsxAZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31690219A7D;
	Tue,  8 Apr 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120978; cv=fail; b=Dm6V7q+fUGWWnQ6G9PcbGojnowJ0KnNU4Z0ZLpXynM0Vkii3aqBEX9AadmoTssJ0Z0hXw/bKW13gAIblnJvgvOBfyNIaygJeLNdpg9xK3u1IweVYdNurhGxjTWd2zjjhAVpzPb/FzCBVsrTFECmpKpB7KQMZfnjgAd79Nku59NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120978; c=relaxed/simple;
	bh=Sx7SKuwKoNTMT+Nq1AyrE3wk1rP8DeN0pqfoQ+zNgMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2aVIECNhyFT8nXj4+3dOkFYudUBVu7Yc7KDhDmiIsm/VF8MFmgjc6GDMFpZi2OjM/pJuI9F4rEgy3tqau+M1AFujOyLhG6CPHrVOZSDpT6Fh5HbPDlfIjrcqm3zxPU30jPU11meCSg/viZ4htaNSxDgyWEImi8BkOECuYYyFS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDZsxAZM; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgB4pGiF6qu2e+rZV4ZqHjHopTrYIeRvQLcfkeJCitMJZzAU7n7zGPp2zMxT+bxxtwH4IA4ttUHRoDVzZIAg7V/wVRoraOR5Zh6jVf8+vGAORRDcBUTZOgr7BmjXoyH6S0mn+BQPUt2evM6za5dzYDucGsD5xN4oY64cG8YVW16rbDuhJ6z/ccD2gHmGd13c/431LS0Ek8r6pxNm/PYOw9qg9aF0fh4wV3HQVHspai5WlxdoWTdnHe6Gl3M8+dzF7+TjAxHr/LURPrAcE8dfWrI7BbgggfkaykL3KE+5X/x0FU4wOcrLatDA+mEBga3MlvT3amE9W/JDdF4IHTjSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUq2+PSUk6nMplUEl1VQRvpQC2zDPVbaqeWZ1QJOlRI=;
 b=aUi1q8fBEnt4Af/7t7jmwrFmAjylLzxZPqmwm7LYbGKR+ctUXlVxDUTSefCYZZXIwiq+6REWfkrnrOvQRuPoFkxUNZcPCio4k3Vd3CyoNSBES1D7KjYfKtx/yzzHto1AGVBBXjGZEIGRDMfZBD3E9NwHGeXhVSVD3Gi8xYtRu1aQw3IOcwMiuEDbaWez7YE4avU8ql/SQRWX1SNhHHS9mEWHvgSuu7/vqxalIvK0PFIhoEU3LDur6ghdt9+Rys7sQg7EBU7pnwrS9dGPpIVxy9kt597Vnbb5KsweJDmcTVOIYjnF5AcXNunmDBu1xZn9SJgKs/SBpjtVHBsCkRk19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUq2+PSUk6nMplUEl1VQRvpQC2zDPVbaqeWZ1QJOlRI=;
 b=TDZsxAZMn70iQCxBgrTbIHO0T0WdGAfqtbgtSQ7Z5J7D6tTyUlfwwV16EIn5I+22YeWxBkOx3xzIyzhSHJkF4zLMrYd0q5727Cf2w+KpKS8BefpDHhcaa37xJDNDg3CwO2Uwxqouvvr29Ax4fnLEUOtxRJcXwvlhh0VCRabcWmSKa3k83F8GKl4GkgLWKsqQ5E8eUbqJccNYiA7o34nh2y9FUJWdmb8udKdcU/s8/IMWIb7NmIwWSVZccTbCaMFnU2xk2LDbDEE8bMOI1KhLAt6d4SDEZlYbQavnbQENIAETF7twBQe7gshmBlYBHFSWa21iItu7pDlWkZ4aRtJimw==
Received: from SJ0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:a03:3a1::24)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 14:02:53 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1d) by SJ0PR03CA0379.outlook.office365.com
 (2603:10b6:a03:3a1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Tue,
 8 Apr 2025 14:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:53 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:29 -0700
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
Subject: [PATCH net-next 07/12] net/mlx5: HWS, Fix pool size optimization
Date: Tue, 8 Apr 2025 17:00:51 +0300
Message-ID: <1744120856-341328-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8fc680-7cc8-4778-553d-08dd76a60e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+XLl/iLbJrKHtwt40qFc3HGDlWsPdXigJq4SvcgiHIJw6cspucT8rShpxOz?=
 =?us-ascii?Q?NShC1IG7rM++fEDRE0Db5LclsiN9tyiGGxuH1Wj+kOfS4AjMoT7UXJ/NSDxk?=
 =?us-ascii?Q?1ztaw4yGYmJ9qgZFw49A9hwMOkYREszSAI25HoE0fbktZyJ8r9pDvG40U7vL?=
 =?us-ascii?Q?g+uFGJndFmytQD6/UVZzY12mnovRZ9ODUR7PRma1ywN6js9aeBiOb14T42IZ?=
 =?us-ascii?Q?ASkDc8u1L2Bi/ikx2i5NWicWv6eNSBZvtuUGM5tGRAmnl4GNDu/Np9m1tcqP?=
 =?us-ascii?Q?yhdeku51ZHD2wTc67Zil7hcyuD1gbJDoy7Qb9RvgWVgH6xGO9LcD/SLvJnDB?=
 =?us-ascii?Q?h9Ktr9e+rIMwRtcJq8j4JFUeUF0lDTvc3+VvleZQJcG9FyVigqE62fhlGeT8?=
 =?us-ascii?Q?C+/n5/cZZE16k6QwuEWASTOQ/j0wFU7InRnkuoDm5PkLmV7RM/MR13aEbxzU?=
 =?us-ascii?Q?fjplPEzMRFn2MxynjD5JGD3ZdfVT5dsnu7cjbVLTmrg4aTsPDmJycn//J5fE?=
 =?us-ascii?Q?4bpsHBVk7FxXqXwPrDnEtBfG7oJNGTOG5syDWJbo152FpgKs0iA6l8ST/pRF?=
 =?us-ascii?Q?aa0+7LQ/5MrxiiXt+fN1iMxkQn85e3WZ2WOa6IP/UVsMbvwDC23wLMysURHy?=
 =?us-ascii?Q?wd/imo1kJM/AEyXq3TVD0H5a01ZOZHRpi4LEZDUsu1QP0LXs0moX4G0fyRWH?=
 =?us-ascii?Q?DKGMRNIe1x++7fHrM/nACKJNMjfpRF9ipafk//qMuylQYEguigyLiXXDNyyb?=
 =?us-ascii?Q?v0LI6370ws8ja6Uynu+lYoY49eXMSIUzZzS4vuBJTSW7zmvQFtxuh05KdGwg?=
 =?us-ascii?Q?QxwF/6tbZfJKMVd1v3ExZPRIFOX3gRnL+b1Rq74dgrvu2wyJqj+rf0VyA9O9?=
 =?us-ascii?Q?z/IygBOp9BAWTBPYpyE/RKiFI0WwwAv7+ecapsorHE9e+Tj3Oy6w1hjrD0K/?=
 =?us-ascii?Q?NADLDrGBXFUWK9lVNHinuQOxCoMkZKsgNvjgKFi7kQqIk27qTVD7sfaVajQL?=
 =?us-ascii?Q?CRZ//dwyvdFIJnWsriuYMyc8gnyBu+rkzfij+cLTlx02UaRnaRjOkb94JKv+?=
 =?us-ascii?Q?s34/jSdg6ZuX2x0CruWZ9paVd/qoIKZMUIynXc7WweApIgZfId4YdcMtBK1/?=
 =?us-ascii?Q?RlQ6DH0E3OFZK/3BA7PQkg2E7+IdFk1WWd1k2Kbo4YV4b8Zs63gXUiTm9drO?=
 =?us-ascii?Q?rgA6c48lzn1H5eanPIqHWuGjR5/1dzk7DwNd7qGaIDASmJIaBMCNPQbrOcPG?=
 =?us-ascii?Q?rRdD6p7wPSwF0c/l5DrkzoMgPka4ZxWZSZknihFYsmYaIKFdMtD1JOiGaZz6?=
 =?us-ascii?Q?Nfm3wEBb7Fd5P2OK+SU8SnZjfv+DZ0ELjP+l9DC+AjY5JRXl0TOBi2ioVkgv?=
 =?us-ascii?Q?uOaaEOadB9wAnTwyMbQMtkBbTIVqUa85ijRh04Rm/FkTkvQydW+w6fCmh5sW?=
 =?us-ascii?Q?qr/cKELsOCXINZfDcH7WwUv9BuimaLHBk1AGr691jit3R1eR8IAkLH0eFbFY?=
 =?us-ascii?Q?KRa8u/bUOAnZUck=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:53.3711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8fc680-7cc8-4778-553d-08dd76a60e65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

From: Vlad Dogaru <vdogaru@nvidia.com>

The optimization to create a size-one STE range for the unused direction
was broken. The hardware prevents us from creating RTCs over unallocated
STE space, so the only reason this has worked so far is because the
optimization was never used.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 26d85fe3c417..7e37d6e9eb83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -80,7 +80,7 @@ static int hws_pool_resource_alloc(struct mlx5hws_pool *pool)
 	u32 fw_ft_type, opt_log_range;
 
 	fw_ft_type = mlx5hws_table_get_res_fw_ft_type(pool->tbl_type, false);
-	opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_ORIG ?
+	opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_MIRROR ?
 				0 : pool->alloc_log_sz;
 	resource = hws_pool_create_one_resource(pool, opt_log_range, fw_ft_type);
 	if (!resource) {
@@ -94,7 +94,7 @@ static int hws_pool_resource_alloc(struct mlx5hws_pool *pool)
 		struct mlx5hws_pool_resource *mirror_resource;
 
 		fw_ft_type = mlx5hws_table_get_res_fw_ft_type(pool->tbl_type, true);
-		opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_MIRROR ?
+		opt_log_range = pool->opt_type == MLX5HWS_POOL_OPTIMIZE_ORIG ?
 					0 : pool->alloc_log_sz;
 		mirror_resource = hws_pool_create_one_resource(pool, opt_log_range, fw_ft_type);
 		if (!mirror_resource) {
-- 
2.31.1


