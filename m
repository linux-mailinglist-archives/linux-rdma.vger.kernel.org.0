Return-Path: <linux-rdma+bounces-9349-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD9A84CC7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE38C9A5EEF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37921293460;
	Thu, 10 Apr 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jhXbtvF6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B36293441;
	Thu, 10 Apr 2025 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312736; cv=fail; b=Ml3RA9GlV+Bn1gLRjKQAr0ZBUAaHsfA6YkC26U7e4UKnw/B3XnZZYk5hl0o6ZApBG/JAffQ6vRw5WmQgECS1SABs65hZZJtF94q9vpIKDq7oIuK9IBKZQpxDY5g/2Fus5k2ZS/GZ6KIVGb+MgCYNVy15c1o4u98xxqMcYLOwLGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312736; c=relaxed/simple;
	bh=Sx7SKuwKoNTMT+Nq1AyrE3wk1rP8DeN0pqfoQ+zNgMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwozGgcazTpYHtR3pmIRMyiEVdPyMEHE9vxsN3YOb4Uv9+Bsod3GxWQnLvZJHzWALdZnVQWJ/OzLRzB0h5HbBnBahAifp5cKQEJABWn0XszYrUOqOgWJMYYFS0XN0D8FFgB5HjH8tI4kH5gkioVn79QAVdZ8etmIpFoWdI+l6uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jhXbtvF6; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQgIM8KreCsQBZKmyUal5DAgZRywIM0BmyiZBYQwenBzLeBsNT4kFaqtAC3Kcuo317U1SuvVepc57VkHPwbTPcWiu2ZEDlCXIBNkkUkyiT5AUxReyZKyXYfN19urTtpCbcmvZItKo9XPEmd16XCwUVuB8AuzrHQ2OX6lQ2DPw3vx45SeLpwp2rn1vNZK8LC1x1dCVINVnnXjzLcax2YwHWpuhSMfoDJKTstZwE40Pkj31vxykvCcBnuah0Iz9vE3vNC1AVA4OZe6K3KtyypfNzK9FhfMFSyay4y0GBl9Zx5Prsbipildo6bRDZbdzn3+dviqouA2A/d7bXLmaiO4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUq2+PSUk6nMplUEl1VQRvpQC2zDPVbaqeWZ1QJOlRI=;
 b=J2chcmwp0H0+IYsz5I84a5zMasBHuyMOjPWZKQ3ZMJasAlVF1rlzhrE42o0o7goMWRBOJij2udP8kPaPEVbC1BgHtPthANnf48+9w+K6qCuN++zaNIjSZtkIFPT2NjHA/GyYV7y7QdRoPe9Gh42s7Ig62KQZvRKuQpRn/jZUMznX2Q5+d5a/8EJZyXtR9R08Hg+kiPRAkpi3GJb3ukFq6GpUSVjj0cZ0uN3P1boRpXfiFpaK500pTsKypwhPKpdpTu/HIUoEWvQzX/MKiDNW48ihHRfQtYQkxfn/zSxgnoCzpWyAA1/3avryIG3TbHIoGRQOzwBp/vYvbx+NF3sXaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUq2+PSUk6nMplUEl1VQRvpQC2zDPVbaqeWZ1QJOlRI=;
 b=jhXbtvF6etegXDB1XRK163+QSzKL/E3xZniSzIHj4M9JaRG64/kqQoA7tT+yMT/6QA2M5gC7pFNamKozeNGC9JHRGUgZSEMtsRTQLH6YHdCkr74y8JnIEUND/qdSm+w3jScO0RgCDu0ReIgb+aoObgHH1oVJUugZ2XX7Ks3cPzCqVmyDKqkKfJXGDQ95CB746iIw3SoznneutMU8cedoRSk7z4BXVsiAO1a1IvbB0lO7ZGp/tLp4dIkbcymIvyT1mYseYHDaa6cHk2K8KOjInOGsKB7eHb5vXfHhHz1BFhBk9vfpd6v1Blaz1hfnXzixy8vZZkB7q0iD9vEbb5lunw==
Received: from BN8PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:94::31)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Thu, 10 Apr
 2025 19:18:50 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:94:cafe::b) by BN8PR03CA0018.outlook.office365.com
 (2603:10b6:408:94::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Thu,
 10 Apr 2025 19:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:38 -0700
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
Subject: [PATCH net-next V2 07/12] net/mlx5: HWS, Fix pool size optimization
Date: Thu, 10 Apr 2025 22:17:37 +0300
Message-ID: <1744312662-356571-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: e784780f-a934-4784-baa3-08dd7864867a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APuUsYDAhCTdgEePLu5S8M0Dn2qjTWbwKcEccpUMHyMO5MF90PKgYOBw28M6?=
 =?us-ascii?Q?nytf19svIlkdFuT8qRzSd3woJ5qxaRLN439mnaFOgHAZkIvve+JeQtwzF6f4?=
 =?us-ascii?Q?sqCmipF8qGqydXxovMakQeqC07QHAZBLotr2jGoRfY41RoiICzn9WLNiodhu?=
 =?us-ascii?Q?xIb6J+VOuQzV4OKiPdlywSn/8q7Zxvo010tcJtuBcLXjAo8yvveYhAsoNGMb?=
 =?us-ascii?Q?flnZtx8cpxDS3XUwYtKRt7KzuZ7A/81DaCTW8n8j5G4sl6ydUrsMLG/ReizF?=
 =?us-ascii?Q?KjKO0M/738i1cOwvfi+miz/etGvtCTD9RxFafylUDAKsL+p42ysLqJrMHALa?=
 =?us-ascii?Q?FQNdNB1c8ODz2fjA0vYwN1O0qN4XCLpCLYL9cJ/V81oRUWgkNDEym+3AEeF+?=
 =?us-ascii?Q?FZb8Ed/0xSiu7vU1nZJoM00oOpepxup20O10OTjjI4Ol5N4XU/GZt8vTjMSu?=
 =?us-ascii?Q?T6Y2Vd9s04aaxkBvJKG0nputOB9/Wo+WaCarWmm8e38lNz9Me/HQc3EsY17i?=
 =?us-ascii?Q?FUYseEr48ZloX37OIdAojNYpBTOYjok0RwIcUGE6BMK+DsIWXf0ZhY1k9Gl/?=
 =?us-ascii?Q?er9Gczo19I6rub3MsU1mLFLPh49fncsXy+lkxxNwvqewN/dF7iLWS2CrYjwW?=
 =?us-ascii?Q?18PaLPrH2v2qmAkZMl7AFR8cLd0oKei2nTblc8RjVKj4FshvNvdkkpxiMBSn?=
 =?us-ascii?Q?u596XPHo6DyRJGc22G97FUMlE0ze0YDiHjWmY9+kPlnTTcqKsSygpbW731l+?=
 =?us-ascii?Q?PUd85WlSNCPcQxjjDGFiSGfBP9LM8oxB+z/358T7NB62xjYwhP05MEAewYH6?=
 =?us-ascii?Q?dYW7ZyEvZiI51rJOmZaUng8wyGz1YDl4vpIkW8e2hr19jPTwPI1dO+SidMoR?=
 =?us-ascii?Q?j3BEOyS1F0RRD/IWqgVCSywjSXp3crCylTSLTaE7Hbhj3q9zRBh3y+k9iyZM?=
 =?us-ascii?Q?HHgOmBRDswABQOVuB6P76Utm9ocT4ibr8Htq7JMLO9eL5BZtiDqP79RmrJa5?=
 =?us-ascii?Q?F+cDqIQLny9lsDUPpRkuq3nvo6XXMlVWwAGlalDLe27YKlPPTLJnQ7QikWQw?=
 =?us-ascii?Q?6171rqXTKV57QHZYhG9phWpgmfBsLQVoGEYjXk+74RfPcqhN6pKEaPww86LV?=
 =?us-ascii?Q?l6RMmCyKZPN1qVUZJ2JIj0VkfQ2BVledfgYg5cqxIrdkqEi+NBn6B/FnFTvD?=
 =?us-ascii?Q?SJen+KT5gWPo6No1zshzEwly9VMlNzNS49F70ZZC9ydacG2TSYmuRG91lxh7?=
 =?us-ascii?Q?l/hku+cJ25piCTN3z9qoeVI6gGVFzVMKTP+kU+gAkvxLvYzl82RDEoNK0EWi?=
 =?us-ascii?Q?805x0BpfzgpusFSMcyirUi5UO0JDidCq430RvSAzArXIJs8lHk1QbWEfTlBH?=
 =?us-ascii?Q?EFl7x+p/Ay5D9vAlrUXSm+R/HGCnD8SFlBP12z4Wq0Jk77qI7pz020SLR0A+?=
 =?us-ascii?Q?Zt5hNrmA2csvOdS5VjEmfpARKRtwaqAJpZRkf0DA/sl28naWce+Gtn5jdYrJ?=
 =?us-ascii?Q?xiwMo0YYFj6R7kS8Z+slFIXfopHD60Lt0ROG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:50.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e784780f-a934-4784-baa3-08dd7864867a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128

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


