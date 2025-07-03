Return-Path: <linux-rdma+bounces-11890-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32965AF8107
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E961B58664A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752C303DC3;
	Thu,  3 Jul 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tq7U7PIF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E32302CAC;
	Thu,  3 Jul 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569029; cv=fail; b=MThNh8YgkJiU1zUvru3L8bBaJvfYrPhoz1L4hPMJuSmRC1K2fFrW0xI89pL0metAATvqYQET3rmWkCE4ys83ZYPd3zEsQUobSd/LT2fyCDGz1U9K3dNOd675wtJqafKUHCkVcidsDqpMxQ0TTCJa2oGSfhLYjPTzJFozkwzHAVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569029; c=relaxed/simple;
	bh=yU9qX4QWkdm0HiJGgvc6bhcrfjQpBUuzUWMC3nmhf30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmSlXZxuTKg5y9WP8xHmU61SVllfNfSXwCYnub7YCvNzqY0ht819FsMZDi1D1JRAs5sZ5q5wv7KGZuc6/NXFMmgl/N76zsRkPEYl7IMpTnTNI99CQ+y+oU0+6JPn+TNevhVNV7V0Nq6GJ2nqpkBM9ZgPL57NNaoOzCytqipeip0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tq7U7PIF; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOQMYx1d5SNzhBy70Hn7RcTJTMpU+RJb7J4VuFsyq8Wff591C4KybnEDzeQO0zxy+tITaH1zVAB1kK3BGXr7ykIDQ8cuvTN6V8pmsDNQIPmfWWTe2JHbDr/3L0ijRqEp8ANFmxTYKCItyFBTPakQ+8Fzb4fGqerJXBe8cTHicRShGZOPvHEknsHDTa5wxLgubptwAqboAoPT3Lk8vS72k3Bvl7J5snr8X2HgVAajVQkDGA9q0NeQz37O3AfIhycINyCcUPFDiL3CAwprVpRqeGgfsUqBOc8w3RH/PugwwKJ1HUSDVVc10LaZpB/m2Xw2MR8fDna4ZtL/xwFipPaGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7gy8/RtDH03zPU87GIEWJlarXtse1XhrcI/p0mpGOM=;
 b=Wb8QkQJ3oWA35o9txQ9lU5mSPEYMIulzNSVlIRbkWBeFAoarQ40g9qhW+c+xYgiEgIekdvBwueZrPXAR5ybRCYNNgoDPT72hPg6oSuYvjdJ0c7G/4nVGXWW0LFYXpKpTs/8A+6PXISp+qoj3vFKsDVBFy36pvTNmh9BN96LPLHkVYBWc6abOZMGg4imr4A8i5G8CH92m4G/aDU8w8evuSUR5c8kn3v8wYPc7wv5wpWgtpu1GGWrsVxfJjpNjM/qZmQ1JIRvacAXGa+DHFAIgbHFNUhIP05Fp+FJthSAvn54jhoM53SBoXQakhNwwLUk62z65wSMkGf8m8gVmiI+KPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7gy8/RtDH03zPU87GIEWJlarXtse1XhrcI/p0mpGOM=;
 b=tq7U7PIF+D/AMG0QRvCvgKAo9jQ4UDgY7mHa+E+/xI0wzOK8nuNkbvKYp6K2uUHRnMaSmckO+mrRplk+6w4RxjhuCviY093tsH62gaJiKqeoIy4KeMaO04ibCasCJ0pRpPxpWab34i+Mt2a/4GOE4IT8PKf3DH3JnxOPc8BZWHKfjjGRz4GEqRjD0QbsgoLTCMmWzczHIMPJgyyK0sGNY9oLhrM9a8bnzlLsUFYNh21Cmud11Bzawn34b9I/hIdCOsxzTJL6aM5QYnwIJkxiXjv+PQCdGK2HLoiCe9myMtpsN/Ln1d0LKZfDUB+X8U5iWnKrsyBxjYiNqMKjlKYReQ==
Received: from BN7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:20::38)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 18:57:03 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:20:cafe::64) by BN7PR02CA0025.outlook.office365.com
 (2603:10b6:408:20::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 18:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:57:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:42 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 10/10] net/mlx5: Add HWS as secondary steering mode
Date: Thu, 3 Jul 2025 21:54:31 +0300
Message-ID: <20250703185431.445571-11-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab889b0-7b8f-456b-8132-08ddba636578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4zgOq8PepRusjnQ1UR+wY1NYdwFudgqi/JXnbOJnnEVhmv1NXw1DloWtCpxn?=
 =?us-ascii?Q?wB58VGsS39yEQfjvGlXO7YGa2oUlqbA5OR0S4B7kMbYB1ILh4T22EaBnhYYn?=
 =?us-ascii?Q?ieQX/YvmTPVhPI0PXkYDigMbKQPXmKjXZAdySW70HyeRQJA97T29xpO2Lh8x?=
 =?us-ascii?Q?RPmCvrovKx72QSg6v7b+CmuhqysurDskeFPsdRCiqt7UdG6QUxtvkdZ/elfN?=
 =?us-ascii?Q?YnQI6LlO5vK3gGMaGCNb4S0afEkQO/BtytFENGKWdgwdoCTtnlrt1deN3qp3?=
 =?us-ascii?Q?eqme4lfeZKSbYLAg0ggTQNpQDXe4AOADzimHHHHnEuNLKsyP5mM59xJVUs16?=
 =?us-ascii?Q?lvi+l6cQrCx5Hft0VoHqPMgHlnnBhpE9PZlNxd00LWFCUeyj8NB/aTkd6jSS?=
 =?us-ascii?Q?YhYQABcljb1JnpC1pa6dHz1vtGHie6EH9ymyqFydmQQJlU1Ji05OV5X+4L6x?=
 =?us-ascii?Q?EMcUpfBVwAGW941UtGGZY92CKfSf3wUSoFkC/CkS9WW67few7Xr5V0OsHwkN?=
 =?us-ascii?Q?/zxGCHR8GN5AGZhgsp9a9oVLpCyPLDOYe5uRpNyW9dudQYoYQGSseq5GDWYc?=
 =?us-ascii?Q?84OwhzLXxuIRGeC7wbFyxdJtOlMGWrVskGVTTys9xZMvOHDi0xIL32AP1TRz?=
 =?us-ascii?Q?Siucwv26B+WpOlX6S9wfBzJr88pJAZa8Ew3B1zrfI3ldOX4WPW0b6mINoyww?=
 =?us-ascii?Q?xEOXlMXAYO3dNccxSo9Fm4qy6WHv8q9wn+WUn0ecwFq3uCkTFuZ0STnc5ZZQ?=
 =?us-ascii?Q?XuNIKZCSGMj+f7CPh2AAKVflEBI2JEX5EOgtSaMpZTa6/CbzLjOR33z8eZt2?=
 =?us-ascii?Q?AeYlPSSAEucENfxuH5KjC0AFywHuPWUkOWrb4oeRSTQryR5e6CZLSmf8ms6+?=
 =?us-ascii?Q?sWq3lLJmxpmO2ttzK1CrjqVuz+c0Nmb81qt18bJEUuY4TwqUDbwFQFxXs1SP?=
 =?us-ascii?Q?0x5V3fbGD5zWVnskd/4Eqm8eVX4OZpAqM9wKldplLbBohhNAQm79QNaamO0G?=
 =?us-ascii?Q?q31XgYPPy7c8dTR9dW0mnAY67iQd9CApXJxwhIQiCzRPtZXy+IHt0CNnhQZT?=
 =?us-ascii?Q?cZziAsyRktqpqp7UEHsXuTYpSgM9efFO4iRyzq1w2QtMMQWZotYuvPi5/GI/?=
 =?us-ascii?Q?H3GGFlrUTaldRMBTNDrU/oO41b8i1IH9FfnYLWkbNeGna4/9WJDow6EwIH0o?=
 =?us-ascii?Q?AAxYWzoStG0hJjhSZ+nz+MvQWY/kYC9Ys68SD88pllgq15XYZUEHv7xqPKUW?=
 =?us-ascii?Q?cMxNvJTvypo0wiRyAxVWFSNZTrOfZse5H5aHuw1QO7QdCDPPu4QJkRTRN4xl?=
 =?us-ascii?Q?wXcypkuzZrKmAUlgc7jNf+hnMZgC/msXVa+/bPbBlot2SL+jtlxV9U6kRJIk?=
 =?us-ascii?Q?/k9rt47AR7VHPY86o2D4fOdiLsO8baVXr+nbo8I0bgeSOY6Lues8QKm9vBl/?=
 =?us-ascii?Q?yD3HxvEzYduKM2LtuDBW2+WNqPyPp26Lk31LPtQJ89qus5Hns3UxVSRBpXa0?=
 =?us-ascii?Q?C7mczQMPZBFb/8lEl5M+CQ7AtRkKaqgjLeSy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:57:02.1555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab889b0-7b8f-456b-8132-08ddba636578
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

From: Moshe Shemesh <moshe@nvidia.com>

Add HW Steering (HWS) as a secondary option for device steering mode. If
the device does not support SW Steering (SWS), HW Steering will be used
as the default, provided it is supported. FW Steering will now be
selected as the default only if both HWS and SWS are unavailable.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a8046200d376..f30fc793e1fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3919,6 +3919,8 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 
 	if (mlx5_fs_dr_is_supported(dev))
 		steering->mode = MLX5_FLOW_STEERING_MODE_SMFS;
+	else if (mlx5_fs_hws_is_supported(dev))
+		steering->mode = MLX5_FLOW_STEERING_MODE_HMFS;
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-- 
2.34.1


