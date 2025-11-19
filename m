Return-Path: <linux-rdma+bounces-14622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CDC71117
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 21:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 07E24297BB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B62F690A;
	Wed, 19 Nov 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="El1Y0jf/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EE2D94B6;
	Wed, 19 Nov 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585350; cv=fail; b=rVqzU8LnJYEmXGPXh8y6EKIpEZzl2FDXB81J42JAzBCTw3tmqdLKLuGa31VAzqw9oOKoXpGnau86kcVNesTQLG1BNiPUM2smHLROZvAgd67dIbfUxgdD3URCgHM6XlGa7lnyQxd5SIcKht97T3f9sNF1N4B03U0ScUgkbK1pzEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585350; c=relaxed/simple;
	bh=D7AMSbkwFKHlk3zsqgVV1qCwQhj7HUNO1YoIBm/A2D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiX0YHok7peHG58wYHF8b8GJJ3tAROgd+Tsx3dEFmsADlJhuvKBNp0mrgZ5JJ3zBE2g3kzSRG5ph16Nx5NF2/Q0F9YMjZZPGkCB/7sQj6msmb0u1u097y2+VrSiTdln/sZGzlYkjNoMqim2Wy45leyrs1XayLW6VsHbGegO0MQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=El1Y0jf/; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djZlgOR6WjMaH375Bn45i954Pr9ZweH01bAsZCIY+301D4WA5b9dEsBjNGyG64kDhmB42noVmpEqaT27OYSFlgTn73WL407QZOgg/mW6CLgV0KISkKZTKe0fQ5EusSqKwEt0Gd0m7tHCGnPzTCbC4Ecbgsq3T3Oz+L+hQcNpfbXhcOQ2q78le02Y3fqRs7szfMjZ5HTwec02wBQvwkZFJ6mQbrKffIUBWp7rSPjDHBVyj0yYciaKJZBjKIcnt3s2GfyYz5AFxcAGexwaHdPt+iTgFFt2daHyCk7EULszK7xuviyDeJStnkbphshS17MrMIPrQ18dFFG3+rITcIShLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfn3RuMvAqlEsDJe7xi6qO7s46c4xk49AIT7N680aLg=;
 b=QXv5fYt2JDndT1GrfE51hwnh8idFO03C371eDltYpcoACMHGKe6khlmhMlfWg/Jv/HiAmJK6xIMzvlC3jIe2Ayw25tWgStPy+y98soHXZB+UwXGN/rVSKvGl5bELulHAae7RuAluFEYGMyyK3DxXvb/rH52ccffYfayZlwJFAFZmZg4XanHEabXOEIt0Jw9DJ8s6MU4mVm0DQcX/9QSCnvWG94eO2/AhsUzTjDRowuUe5eOZ0pvsyc53vl5REg+fGY4jEUdZp5A/iW3nXhx7tZvniyVfuNtRYc5sv8VNakHOpQQzcxqNVU4S30oGgJZFvg5nh2ibugaVFtuSlJa3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfn3RuMvAqlEsDJe7xi6qO7s46c4xk49AIT7N680aLg=;
 b=El1Y0jf/q0T02YeVHlCC65u1ruLJK8HQXmsrAUVNKHa38rNZS1Nk8VVJTJNfMvfysIkIJhUFCVvaiaOv8U7qj9hBMW1OPqGHxQHmHxsYNKGInpwgnjRW/NN50fAjDQiU7Gk/IdwVJRDcVOgB1ZbjEU6/AptZ3VdKoATWJhebpQ2J5u+E28rOJkSgkBa0f66Iof6oeZ6l0VPz2LmDJhU6sulVmeNd/DmFdK7HIUMKj0gRX32aJJVwODAwniBcx0uSphxMLytXmziHHmnkFBiRQygCLkdX6MxBesqgVB1IFQZApt160NxVPpLe33yvuglszD08xtv9nPmlmWM3YjJk0w==
Received: from MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 20:49:04 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::b4) by MN2PR15CA0041.outlook.office365.com
 (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 20:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 20:49:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 12:48:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 19
 Nov 2025 12:48:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jay Vosburgh <jv@jvosburgh.net>, Saeed Mahameed <saeedm@nvidia.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: [PATCH net-next V2 2/3] net/mlx5e: Add 1600Gbps link modes
Date: Wed, 19 Nov 2025 22:48:16 +0200
Message-ID: <1763585297-1243980-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
References: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 241326ed-eec7-4bec-2a0b-08de27ad1344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qs11W1p/0na5kcy378StuDcVud86J6BaqW4YQdoQkypgmeSXwfkwPYPDj+if?=
 =?us-ascii?Q?PD3J+l9/yAYQsA5zgLRtdWkVlGLQHeNsmPo9b2ZCgEPKYGg2g0P3T182707L?=
 =?us-ascii?Q?4D9NFVhTwjuSgEKQqLyg7wp8J8kkrEAJLGXvO8u/In//Zv/y94AsPN0EPJ2Z?=
 =?us-ascii?Q?6CAqqQudV0UBEZgC6IRckhO7UrixdwUHNgh4GTSNa0uhik0uYhqdNWAe6uw6?=
 =?us-ascii?Q?TiwSMadX/qlStGxwnmCK8wJUJMdH/wq0d+orlXv7M/ZMpJQGW42f0e+4uz7P?=
 =?us-ascii?Q?2zjLNiiRG09auQ7RDakG2KqPJI/SGMCtcLjaumSFr9JxkAaLnIAey1CosdCL?=
 =?us-ascii?Q?5FhVHvsXPoejRqEYRVZQA4xmudm6zd91sjJ2zt/tOg/NZ7xKoGR8PHJ4R6L0?=
 =?us-ascii?Q?WrUaGbatQ0E405WFE3LGoSXRMhp5PjwynGXW39ZeWKtcYeWaY2Vl/wl/8/Mf?=
 =?us-ascii?Q?IdW1yOjNLhE16vtF234REiG8/4ZtjfD3wGij4RD9WsIGxGCYADXyByroTR7P?=
 =?us-ascii?Q?wHkuuSLkmNUHC20uEqmyeyk2V+QMmqF7Ww5WKNbNWsxTOIOnN1GyubteDd1v?=
 =?us-ascii?Q?g4NzgMKDofWNNmdhkgJr4nuPgdyZY+8ULpyYSqpc6K6Wp+S5YYWNNz6gyVxA?=
 =?us-ascii?Q?+1bXA+icqdEScaGP4OSPP619+fm6fhXgTu9orzgajpzS3Cxeku+QAIcUiVfl?=
 =?us-ascii?Q?xLz+dX2JIGwXwoTTnv2qDx870ihiyH4nKsFO5zfhqmSYC9Rrl8HdtSBZ6/DX?=
 =?us-ascii?Q?TiEC2YcFZlBrkj1sImqr6YyaFGKMHzg8yP2fPYjj8g7CfTAfJlehVgHiDX6p?=
 =?us-ascii?Q?ipgqcvELtVjg4Qp5dTJgU+UsCncDgHMRXhxZzgxOLoNVIHN2OumNIqttXUWz?=
 =?us-ascii?Q?FWZG8CwM9hNobapFDUv6NRDm5BwXLLmUJBlhTliHlUSSVhzmsrjICtht4J1m?=
 =?us-ascii?Q?7a/QgLELwOOKUy1UiGLK/TdilS1+y32GkJ+6XgOtHp7Ib2+Zcb5gRKRNZYM1?=
 =?us-ascii?Q?Wu4GMD6yLBwmOLSo3AWOaxKP2KfXpIKXgypHcuNbVQAXhaR46ufz4EQhkQZ1?=
 =?us-ascii?Q?Ddl142C7743+QGrGDrLoF+cveH8yTzvxy3r3oCwYKabkLlE40jF1TN9UCB3s?=
 =?us-ascii?Q?FHSr7y3hejV0eEs/rpruKEJUfWW5FeGtYYgux16sw8VFE0QbVnFXtJ54Y/Cs?=
 =?us-ascii?Q?puIIOoeMJo0WsmlpegLlTpSVoG7EbXQ8L1lPkjjDI5zigBWw7lmGawBBVCOK?=
 =?us-ascii?Q?tnFLUZJlcBbuVC2laLRabXgnZJ6nQSkYGjO2eckKPyxk6O9JMaDD3XzCfxp9?=
 =?us-ascii?Q?Jxz5WnMr/YfYoKcwrUEthvxcsrzB2POcqboofTxOeCKzn4NssM4bPuPeGuSQ?=
 =?us-ascii?Q?MJARK33ScZL7N4KJVX4dAisIG2cdV2nnxl9Ol0NAUR7489rdLbhZp9Z2iavs?=
 =?us-ascii?Q?QCY70dlPDH4EfH+I9nljvzu2BC883UVo7MkNfbKuikwOC8kgpIIFMp9zWySh?=
 =?us-ascii?Q?EY+l5cMfChms4ryVHldDcbUUTQVhGJG45yrallRKSNG/FDsGDa0ihCgCpvOP?=
 =?us-ascii?Q?4CxGELIld086mUEqaLM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 20:49:03.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241326ed-eec7-4bec-2a0b-08de27ad1344
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931

From: Yael Chemla <ychemla@nvidia.com>

Introduce support for a 1600Gbps link mode, utilizing 8 lanes at 200Gbps
per lane.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/port.c       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 727d7a833110..fe67c73849f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -261,6 +261,11 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8, ext,
+				       ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT);
 }
 
 static void mlx5e_ethtool_get_speed_arr(bool ext,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index e4b1dfafb41f..85a9e534f442 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1108,6 +1108,7 @@ mlx5e_ext_link_info[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000, .lanes = 1},
 	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000, .lanes = 2},
 	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000, .lanes = 4},
+	[MLX5E_1600TAUI_8_1600TBASE_CR8_KR8]	= {.speed = 1600000, .lanes = 8},
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
-- 
2.31.1


