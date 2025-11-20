Return-Path: <linux-rdma+bounces-14650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DB1C742C5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14D923533B4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354D34404F;
	Thu, 20 Nov 2025 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ROhyu5s3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03400342CB3;
	Thu, 20 Nov 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644498; cv=fail; b=EKekZBO6P5s1rYrVCid2tKffvVgEdEVIUiS7YsPzacnhS/z6VfqyujNM8BqZVmjAmEiMT1rh3Ov4UhW2mqknmbVhN86yVSpwKlyYgi302yAE0n9UMfQ2qtX8bqPYgDAD99n9XIuI/GeTmFfiLVCbAqGnXbGgU6/ZLyndPbixlBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644498; c=relaxed/simple;
	bh=eCQG3S/yOds8JQUOHWixmpPqBLMdmU/S/TtH7v9dU+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9C3zWaclrJsnb6oKYtW4F3lwJyGcaCcjAjdKl50eAktMeFPVh6NV3YhJII4auKApzaRbVrsaxQEYooaNrvwTalnT1kICH/b/6zMuJJxrlQ8B2cFiAtAVemJTrihhVnrjwTflJB9P+p4Ye0YSusSq6G+kJR5lpkl4jCWpfIvk4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ROhyu5s3; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbqppNe8vCWKThkd3jHxp7XJJbzVM9IEfGrXAr8crB5S1elRazfRsHy89fWIQHkfrpKVmR9I6+L277QgZMH2Xb5RWP/Jv7NP1kwgT4pYF3PumbUB9m8O2y6b8gLYsBs3zOoRz2Wm7YcktNWW2sxpnvCPtJMt2hj40WusGgX74xMx+PH8vw7W73q0gnvpI5EXoLHutL9RLO9SXi1Uxdd11kQhUmuspFb8ajLtYshLu+3nUMTXXLywaExOWpxJX/gSjRBnOkw617qCb2oNif2lA6xOT3p582Y0W4qSq92jCZ9LpYysk7m2739OPugHYzu1HBQMzdy/2paS8gtkZu7OKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=IDXOL8SixdI4t8/68gpZdnT4UJy9TysT3pPTuc8pv439rLN1wcDgH8RWE1n2hq54tIpshw7FeUd50cinbheUEsx/j89iLscvMFXKeFzl02V5EUBxLTvv2BVumCYZKRjtk1JlD1TuLvybXDFDhl3LSfVJnbkB8SbZTn1Iqt9Shc4FPm6/s3vHP0JqZbkuzDTHJXNW57p/kaPR+nNlmylgaUm6oW7GUrpLGF7UP3utdibDTO+S2m8RwprvzALiHCqCST3coTYP8tpaP1FJY9UwvIjNYo7fImQnu3NHJ8C6AjLd6cErQvddppd5Q3yImpWE1/F2xKW+DwdhDpc/Syvweg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pAm2wQVgo0BwkiOeplsjOGdgWjn/yXUgEfaNOjFTP0=;
 b=ROhyu5s3973DoNf5YFqZvt/Ce1OHE/+zFiNexjUdkt93C2eOl18gWiIrYCMPyLSLNPfHuFdZZIGy7ix//PF6DgU7eIupV+dzIPlGtaf/tKhqHsTc3sHfXAUK41WQ4T7a9HHhYiO0KWMTwpbEqS1EXpPy5offk3ceVOdg0GdRwt7UlM+ZvZjcpGMMylqKuf4rXzS9X1mImbSxJywp2ZSRpYnbJu2mHAQdJXIIZBo0Ax6FZiG8pkscG/SpEMmi2AOl8hzCAA6KuwZrLit/X2d4Nm25HP6s6N4UlOY1fcHY+6YXfwc4T0uZSjImWH1nIQ0sCV0q6184UHhQvlpuOSpJng==
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:14:52 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::b2) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:34 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:14:27 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 13/14] net/mlx5: qos: Enable cross-device scheduling
Date: Thu, 20 Nov 2025 15:09:25 +0200
Message-ID: <1763644166-1250608-14-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 09681271-a5a7-4b49-092a-08de2836ca48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OW0tstumg7xwaE1OPWvVUOUjwFnAwwqmR0ithneSuGOimhR7RQzoazi1qgyJ?=
 =?us-ascii?Q?uAYLneNHef4O2GStvWJeo8D+Hs3YSQBD97UGZ1N9XRsb5qB8GhdqMJvuFwxS?=
 =?us-ascii?Q?OmPQpOKh4Woi2rUHxAu736RVrlruZoVDMgBjSH9xzVSRzpQcnXul5vFbmZxY?=
 =?us-ascii?Q?T3jGkKrTXVS/3G+OGkpa9PiuaJ1hKZibDcmtX954g0lgcQ1+KfM7ugZAB84l?=
 =?us-ascii?Q?X0JiYfCn4TlwiQHPF3tRtCLZU6pkSsWQcfS7JY4Y9Rn5G2GJIGORMCvBivjz?=
 =?us-ascii?Q?KRxOuqBYyQd0QCz1AUTQGtJNe4y7DWT8Y1LRosBiXdANn97aCsyzSwlcrJJT?=
 =?us-ascii?Q?Rhk3fjGyGZbrwt0C/d36AkREmnYT3f9F8QpOHtFGVxg3xSrnEStMCiyZbbUj?=
 =?us-ascii?Q?43fqIybq9Rjm68tqjL684LGm13/kX13C8DLcjeOfkX8dGdKh2dt5Og5zzwnF?=
 =?us-ascii?Q?9G1vAj8W2vS2K70LhTpFVGoXT9hPfSh9JGY3SVJ3lfMLbQsGjDlN1mLn6hrz?=
 =?us-ascii?Q?QSlOuKtPfsEiaVybM7vE/llwbYCdTg3wC5+6qspzuXNlAUtnhPpj7IaltLHq?=
 =?us-ascii?Q?PmWgFbATAWUXUzx/QFbbqSqqhxM8IgiU3Unv4kyQqfRhV+z3H8mGjyk2rFMf?=
 =?us-ascii?Q?zoR/2i9fsoaarRDD/iUchS/M7V+kXN+Xyr649RJlIpMwCoBlVhl2PKT2kFDx?=
 =?us-ascii?Q?ltYUnBjgR+yChqgctopQyRl+CkqWM8zVOzh3whgg9RZHTO/KF9l4X2uFWVtd?=
 =?us-ascii?Q?KUAuo5dCLofHH4JmciSfxIC4ewAoj+SPgF9cPvQO+IPLg8q66yfzsP3XFp1V?=
 =?us-ascii?Q?pxkDKPm6AW03LPHfMYQVN/SDrSNLDvQYCaG+SIWDKq5T73DR1EvvQ+tjUpGx?=
 =?us-ascii?Q?sB0T934preIxGVzEAY//AR4dKwFsDzM6IzphzcdT5s4aD9IfCaKN7ZPqCBUO?=
 =?us-ascii?Q?+KJoabrjh4iaGvhtR5i4YBm57D9+TzA+/JSkDIP1jegqYNGjRBuT64KJr6Zw?=
 =?us-ascii?Q?Go4gmpeTm+vGVeJGDtWLmD8/GLak3UfXp6PenOkB0Lj4JFQ6w8ajpinmnoMs?=
 =?us-ascii?Q?PEstmdDrnK41gR+/qCeLhvGuHMCAx85+fcIs8+rBvNzxfq7EXbx1CUUQX0wO?=
 =?us-ascii?Q?V+LQULA0tbjfn+u2GpbO8HCjpy0+AdA9LUtm8mcGBMThGlR8C7t+AEXUej1h?=
 =?us-ascii?Q?VZfKlTbqVDAsRI2rtZ3mnL5iz5qCpaFjBzzFMTyxRzTULh0cpx+TooqTyfEF?=
 =?us-ascii?Q?s0QX80akxRAhGfatg7H61EmnJvWqop1Uo3l0y4Gbpt31ucSI6drBcaJFV9ZR?=
 =?us-ascii?Q?ge5Av7Nd+Sj03PqNS8gNlOjbm6UhynIAjpDrtyOkhI9uufz41AuyaN8xf9MV?=
 =?us-ascii?Q?XFYJmxR9JFwClEqQldiYRdTZ7v43epnrr98Yz+nLcjFaoYiQUw7G7D3/Xhka?=
 =?us-ascii?Q?GeDSS2nGltZkj2+Jo8RvYcu/uGPl5xsrOyjnQ/uqr8VxepDQr8zeT+GkKGRv?=
 =?us-ascii?Q?dn5ls9YIoI/WX+pT501Otz/PzKRZdrS+OtvnWHR9VGKXvOsSfOjH1DZT+hp5?=
 =?us-ascii?Q?M5sYO5ozWqXz1KiuWXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:51.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09681271-a5a7-4b49-092a-08de2836ca48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795

From: Cosmin Ratiu <cratiu@nvidia.com>

Enable the new devlink feature.
All rate nodes will be stored in the shared device, when available.
The shared instance lock will additionally be acquired by all rate
manipulation code to protect against concurrent execution across
different functions of the same physical device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 887adf4807d1..343fb3c52fce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -380,6 +380,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
-- 
2.31.1


