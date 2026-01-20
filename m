Return-Path: <linux-rdma+bounces-15752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81115D3C222
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BFEC602A91
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE6345738;
	Tue, 20 Jan 2026 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sm2ryx4l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050943D3331;
	Tue, 20 Jan 2026 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897060; cv=fail; b=cZ+aF/EMsVXMXN9Bqzyv+gs2oK9Y/MVxgWT2zv9yrOaF6ymrzSRvF5y11wwsOTtYTSblR0BuivJElriNBoOGQ5HDRyMm7+E8+ioAFjFlObGxfwcIsIEHZcLuRjEzgHXvr2xKemWL5BtFUPMpaZNpTHS9GwF4PYyUVilkKNjJKpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897060; c=relaxed/simple;
	bh=cIHPtB3QL0AsOTKkdcij/ebK9NAu+BjZiHVPfVP/718=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkM2MjK3AKCMyXIUPn32uE44FfusCAuvA0eFGzBBBDqnrF/P8ZtoN3pqEroe1sh2+nR6tunTMFCtgm/ff/yU4XjzVO+1YttdR+ygWpDj2qFmV9JwD/ptVZCo0D7bN0qOwhP1VJMitJBRiiBgcQ5NjR5osiRPFjELkK2d1GRCocc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sm2ryx4l; arc=fail smtp.client-ip=52.101.193.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3yxapqzHpYCOVtbdrMJ5HSItnGVhSsTWlGKvKeCmFrXbf72yC7N4G8AfAM22izJ1sIspo9LOcLirgvEd5aB4XIIMXde/YG0B/pTRw33K9MscjG/3OTwfA/nopVOveSNjhQbxqpLaEnhT77UP/KYveYORrEEbuDRJM5Y56l7SS5UE1gKiVW23c1FgKqE7yUTsKsrsm+Wa8HpcM1T2y0IfaIRlwB4rRqM6KZCQ0a80qYefFzumFN6fY1vmVbYTg0gZJXJuZfVsDQT0POwvjD2BRtdlU66yj74XwdQiJz+QfFptXD9O1XDoUayadftOFd0j/mrsvXxuW9CvwmPkotr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/cKSOUbmYI4iWUjgucwN2DlGDSEhXl69BycnihPVPY=;
 b=OwMaqY+EshX0ry88EeJSNXJP7/jQJKXRRhfCJDXUVLmevcuxy+e/UdD6EwdAZyH9M0M7byS8NvEPxGMk5AVfb/YDH2/ElWrKIQDwP5K0YkCPp3LqoMDHGs7WPeDlRULazANieygak/lkwT5wHYpgeubtmKhMvc2Vbyc5zDqn9IeA4lxZnwLdiEIOE9iKvslG13f04Prj07w5j3ah3nS55a/bu+CVZdZniUByYTqRFaTGKRtwcitW7cW5aHPB8FmpTVDodjFgHR2h6WBAa4ycHZ22eCqWyG0UB+DK3u6e+KAa7bGLhveO54TPmyarTn2Ex3M/CVg4VQM+2yLhgyJQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/cKSOUbmYI4iWUjgucwN2DlGDSEhXl69BycnihPVPY=;
 b=sm2ryx4lPJlKEychR0/N5Cf5G35Ru6OpkLuMUNZjHrWqhns9+NoyanWicGbGW2yPf+i31X8dnzpUDhpNPqBiACZvBRPctJRIFORGiRT11WLw2MfEc9QDWcVgRyu69pSup/nBMQQSTF8JeqxNsYq1uJN+MbAeaLgq2kAWhNq36nQPvyVYu8YUB+A1CQzunyR1iRVMQQimWPSS4TreMjzDSUPPD977hIomRTyvFHgNSCvC36AOtHRoUYGJrdBmm9DqFgm2e+mC+oD0QRMoawO6AGqXpq+rHLRnpMRNiydgZHz81ihtqxG21edgwnq+1NdIgZBT6rNDI1cV+UYAJ3Wz4w==
Received: from PH8PR21CA0017.namprd21.prod.outlook.com (2603:10b6:510:2ce::17)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Tue, 20 Jan
 2026 08:17:34 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::f7) by PH8PR21CA0017.outlook.office365.com
 (2603:10b6:510:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.2 via Frontend Transport; Tue,
 20 Jan 2026 08:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:17:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 20
 Jan 2026 00:17:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 1/4] net/mlx5: fs, Fix inverted cap check in tx flow table root disconnect
Date: Tue, 20 Jan 2026 10:16:51 +0200
Message-ID: <20260120081654.1639138-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260120081654.1639138-1-tariqt@nvidia.com>
References: <20260120081654.1639138-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b8f9d4-fdec-4fa9-4033-08de57fc5cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5d7eesgZeNX9Qhsemus1cXnjlHYaJNpe2MYNs+txPjktpZqvlZ2GEF42L24U?=
 =?us-ascii?Q?5fT5slsMHAIDzeRGKxWlnS0Fi/YK4RBG45175xhUeZZnTemW/VN1fkR+7kHu?=
 =?us-ascii?Q?0S8VD5s0/bawQluX9Jq37uP7Iu5t8JVflvyBaXLo2Savp7sUNDdjGpE2+Wjd?=
 =?us-ascii?Q?qOq3PUa3kj4YCpoK/a2uXl+Kzb02VQusqNeNGSCnFzZLcroW+CfFXzMEN0Bv?=
 =?us-ascii?Q?cQmuhcPh/LtToo8UjaDxxnYTBu4C5Cb/mZOe6Nvdhb8TkcJI2Opm3Lwy87kL?=
 =?us-ascii?Q?rMHGAGfON/Kcs7+LqO3jR8/wV54E537Wj05uk/vVYJowwEAzBeDpzbVRTLKf?=
 =?us-ascii?Q?BbFYIjxzbmajlwNasBnj1KN4bOhQaZRcZp7eUSuPTt2SoxVxhf9RJ2c9x7PU?=
 =?us-ascii?Q?zMGGYAIE3sN8NS4d1HH2jTXcXTaf9NI5YfEyU/bYm+/X2NKGsC7iR+a5O/+/?=
 =?us-ascii?Q?4YocGJsNuetYziUjppWlng/mz4OIqxWtG+Pul74sFCFoh91shIbd9yfaj2vN?=
 =?us-ascii?Q?SYyXGs16csdN6OlI5JbbGMvBeZeUexYlbya+WMcg3U6bh7yX7ERYNVa2Yst6?=
 =?us-ascii?Q?Lh5u9IzKV54RDaN0e/GjoDAmS3RG/3rnkTW26rh5+6u46/nWEoO6mqKspS7f?=
 =?us-ascii?Q?L5JS2bVDb1Ixi1qusJ05MxHmaqSmsnwgM2XutXz4pNeYFiiNAupNRlGFSGH7?=
 =?us-ascii?Q?K7x4FeXRbGri9SHugcbGty5mi8h/7s3I4cLY//k96j33iF08veC0gQkWYet+?=
 =?us-ascii?Q?xds9MYagVkwPUk9ZkmdCEH3lLBnQzYxnqFdiYcf1hSXQLGdgwAfJmpEykQtk?=
 =?us-ascii?Q?8IN2bH0v7iHNclbx2HiQBpP0cq4APEFJAJ1LgesJJK/yivMAN+L/pRtdPQLY?=
 =?us-ascii?Q?p5NIotc/edS0zblzQuqJ4eEYGDKCnk+9jRpcbA6qvIjoPbUdtFGpg8HeoKyb?=
 =?us-ascii?Q?XoLKIj/DBNy9MB4+8kejMZXucOFz2Hq5gH+UhyDjS7FB1NlUtarUbk8ghwN/?=
 =?us-ascii?Q?ZQUHJAK+d5P2MW2CnimyWumxoJt92vQgRuI8zYc4N31vHCeTlRcFies8Cny/?=
 =?us-ascii?Q?eVzbKTiSwTGmHsuL5j8GPzmzKfOdFfimqGR7T9NCS7gTUN6NY9e1A8UdtY20?=
 =?us-ascii?Q?dV29F1Lk1KwEuIoeHH6AiYe/O6trdnhAm7Axfkm2EYTK4t+hvdfRpEs0JNjt?=
 =?us-ascii?Q?L1YoJmj4s3WhAU7pRHKxF/4Jxf+2Aj59YyIzrS7vf3iSLh/OKFfo/Rzhevy/?=
 =?us-ascii?Q?/12YvHyJAPXHJkWrrZRlGVFYerFE2wdVItMoV6pOoYzQRJEgp01KofjUxgby?=
 =?us-ascii?Q?EhwXphQWatr9z+aZjhjbmYekQ+t27htgIWQJia5nHwlS2H46aJV2l3JhwOtI?=
 =?us-ascii?Q?P1AqG4UPEUu0hD9roLhV0wDuQHj+r0VczSx5lhA4NSZ/gu52xzUCC3IWOadL?=
 =?us-ascii?Q?4R1iaD0WhGGu40Hb892p+aWNTeiqWEPMMESeLBeLTctilLRo7AIbNxFAUoqr?=
 =?us-ascii?Q?qcgIBDIMWWmOnygKcGg5He2EOgOHae5vrp4Hmla0TcknD8I8DP+mE3ZWX5ni?=
 =?us-ascii?Q?Kk19cHelQnWDAcHA6KyMovpCG/7zR+8iFF/wK00ZvexkI5BtMHeHJMzYz7uV?=
 =?us-ascii?Q?q+G4YhfBzzMlWoHlA7pJu5e2bB0zFxSAJF2AVXbs5jD9D7e20ewXtOP0HdDr?=
 =?us-ascii?Q?4AfExw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:17:33.1733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b8f9d4-fdec-4fa9-4033-08de57fc5cc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

From: Shay Drory <shayd@nvidia.com>

The capability check for reset_root_to_default was inverted, causing
the function to return -EOPNOTSUPP when the capability IS supported,
rather than when it is NOT supported.

Fix the capability check condition.

Fixes: 3c9c34c32bc6 ("net/mlx5: fs, Command to control TX flow table root")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index ced747bef641..c348ee62cd3a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -1198,7 +1198,8 @@ int mlx5_fs_cmd_set_tx_flow_table_root(struct mlx5_core_dev *dev, u32 ft_id, boo
 	u32 out[MLX5_ST_SZ_DW(set_flow_table_root_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(set_flow_table_root_in)] = {};
 
-	if (disconnect && MLX5_CAP_FLOWTABLE_NIC_TX(dev, reset_root_to_default))
+	if (disconnect &&
+	    !MLX5_CAP_FLOWTABLE_NIC_TX(dev, reset_root_to_default))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(set_flow_table_root_in, in, opcode,
-- 
2.44.0


