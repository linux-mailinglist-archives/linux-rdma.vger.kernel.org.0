Return-Path: <linux-rdma+bounces-11143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84170AD3C8C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0043AD51B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2F23958C;
	Tue, 10 Jun 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0zb1h3t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38E230D2B;
	Tue, 10 Jun 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568293; cv=fail; b=ImyPRo+tJUZqFOSVdUMO/UdiYcmYp0ObfmfL7f1CdneTNNtAxk+LMbwfhCtTGSyQGgg0L/QWJjUIVd4qIPS6k0Uu2AXBosQqv+CAGqX1ucNnffz+jwOmASYr4sl8JYmqilEup4I2RgJhXDPjN/MqFzAzu3IN2QJpzYSdbkJaGSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568293; c=relaxed/simple;
	bh=Y2ui4bpyi2StrG03Rxz/C3o+qK4XzXlFkCTpwgp/vNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzuAQZoMkGBhMoxHKcG7sF4q9Nk/eIbjoIUkkZs5Dk9KivvlctOg3cj0KxyUlzVlrEJh9WmcbAKqdSqEdY/WaAQPpcIcGXw3Rbg5WE15jaVixvMVou8RSBAznsLcs08V85cjD6AgjEYqQjHBNkKmiPN55DRaaGi0nsqFzn/9YDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0zb1h3t; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjJQOiyXIGUUJlIc0bubewj/aVjOF3x6puFx8JM4er1o6T2xQ790VKGSCQikVzbMEh8W/tCyHKzfkNZrVEyh3+3jrBMrWaj08qnjD+Hk1hZBQ4KB5uPpzyI7iTAYVTBfTWQwN8gTSKSFfqTUamjWGPgFUmXAyQHPveyXQXhbzy0be3/ARfSnlSd5+ggHwfYiwza9+iwFg8Py8tXSfrxkagEPUxPqnFwE4GmErpKtZKJC70r3OuPrpuXAjGkGapBGOu8ypNHR6QfFycf4GTZU1EwwyM1DRTHYFWF8dwfqYcuBjSkMAEd1KMyirfFZGR3inX5v+mckbP6vGIFR2BWcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=EdyIg9m/169+Pf1jvdg7/IAWDgXXSi8N4oYhVvL0O++CdiwETD/sDN6J+B90RoeS6rqsQmSkldsakTK/TvI1nsiLj1eg21Ge4+oXVYeQMQWZNTGTZuco46jHuvKPXhagn/7HdLQTZKFJUbHghjYfgnvJnuU4E1KIkZg/+Wd+ZiFffU/F6Pv1gBfaZP2nBw3dl73fa9XsnSf862O/BW7hwGGh1WwIKCG/C/eqceM0TypJ0tj0w9fcBWN0b2bxkIJ9PsZxXpq2fWX84fitlFKoO0os/b1lCqcb+/fNHZbEM2v9eZ+iN2xXTobKEEqYWry3cHnpK7oWwOIceE4B4mQ9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffOldQx4EhzLumaUO4DQI/K6c9IeBAfc4wzdVLLPS+U=;
 b=X0zb1h3tb4FrvC9opybatrA9cHdPqzvZ7BhOcujcSbTC4CW3VoTv9HiyHCMBDTuOeEcYpRR6/bb6QqbW4B87rOaO0XbLm9PuZFisScY453sZ2IrwxiUqbKekrNNO+qsSmqeaJ3v/yTDnf6ufwXImcfljOKRbecWeU/SaUNXivXuwX299EvPad1ROkcA5dQn4xbMzqERJGcMIXJJ+CtDB5QNpK8DclXaCtPD8TcFUAU7wMGFzf4lYxwCUVyh28hXu6FUTDWRRg3wTDD4KrLDDyEOQILECBk6p8XC+nchB5JgRBS22S69mV9jSzXlTXTgvq2mFPkE16h66tNDZ7m0s4w==
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.18; Tue, 10 Jun 2025 15:11:28 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::21) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Tue,
 10 Jun 2025 15:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:11:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:11:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:11:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:11:01 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 05/11] net/mlx5e: SHAMPO: Improve hw gro capability checking
Date: Tue, 10 Jun 2025 18:09:44 +0300
Message-ID: <20250610150950.1094376-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa185b6-0fab-4595-2508-08dda83112fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VsDA6tiGI/OPDvPRn1FbcGatrdowACQTDAr2WmHUf8r5DuqK/ncFcnyLLzW?=
 =?us-ascii?Q?dFqTGklTSAD6KNgLm+Ve6IM1TNTARBE5mqRWhpT8s+toSXrefOXDdKzV1z3G?=
 =?us-ascii?Q?wi2LLzO6Z4vK93QzRaSVjOdaNfaE68V9M2o2pI6fHZJuTlizl2fDckzcJg/v?=
 =?us-ascii?Q?PYewI5uboEflAERSMM5K2X841MQRY4R2DTCFkvOJVaV5E6K369dLK20F+5K+?=
 =?us-ascii?Q?tXyFF99RljFG4cZmVZ4WwneFAOqznM65zpj8TR39q0U0nSUE7k4Kh0ESq1bI?=
 =?us-ascii?Q?y40g36mZ7JLd0YOyuinOo2Ivpy42ErpbSqW5C6FEbeEEcphL2LesmRZPkSV5?=
 =?us-ascii?Q?dOZasV9iPRyru2Oh1iBSsvLDIug2zrLp+2MymFB2FA4p6z2PZNRtQkCLqOsj?=
 =?us-ascii?Q?xWOLVh8CuF1b4FIwEhKabirNvxccQH3osEH/oJfmRs8y7sZGXWZRViaPvXVF?=
 =?us-ascii?Q?Y+X6FV4F9A5twIXGXzQR1TuWyxi5sM80EfnFgF5MxFfkDO80jGqXmeng8H7e?=
 =?us-ascii?Q?ZqTzZAwsYX0GlkKrTgrid8Xrc5286gfs3fbWXv8vrtkOUu7K8q1mCBC3LArj?=
 =?us-ascii?Q?cW7oQAs4xoE/phQ+mJRjeHMWEVA7n5oetXhOcad8nM20PNqCOObxtCgYCDVE?=
 =?us-ascii?Q?DHlnL4zKzk+L2EJqRgE7HzPR6tbgJaFQacfpNvU22s2JN+OHk6pkfLiSH5wu?=
 =?us-ascii?Q?aJF68rakJ8Ccm6vUavJgx/hyjPfbx4DCPD57B6SFYfdZIc8MAj40If2uElwW?=
 =?us-ascii?Q?L9WDd4relwN3OqBEO5xLfnp9BB02Y6tqU8m1BE0Z4+X2SplwFyHFNu1iHX3n?=
 =?us-ascii?Q?LpQcp6Xzawz7bnYZXF4ZL2i+qjPPUUP8tlqnH8g2kgcLR9czOzSfC26+Xy54?=
 =?us-ascii?Q?pOh1giTr6HJFe00ADgucrhfFXNdFEq4mdm2TXYYbffmwRZ8r0WwMcNlSCjxA?=
 =?us-ascii?Q?2cgV5vUb+6IESeL6qDDvN/IW2xzzUh+/VKRf4WCfIY3zYjwhRHReODbwQeo7?=
 =?us-ascii?Q?hMYaEcJoOMfx1VYbuN0Z5ZFNik+zZ+fh2oRsLABv+uBSKy3f1xavOvg06EDB?=
 =?us-ascii?Q?9MLettSBbUYa1Nvfh8Y3f4DImWYiT/MxzKhtYecex9D02vb6PSP+pTohn2wQ?=
 =?us-ascii?Q?flQdFM0DtLSnvAsvyrn6+cp/6RebzIIAbgUgXe1UZen7ED84f02bDASCSgW7?=
 =?us-ascii?Q?sx5TrrK8YKRS4DeY7VkVo9AqpHmHBWAFbeFcEz65YU7VhVx4yNyKQbXySEsx?=
 =?us-ascii?Q?HmujWV4TUcHbOVONytt9e8/qNcMnBVpy7ioc80WmE61+jrsHh525ZRZM1BTc?=
 =?us-ascii?Q?mChG8WSBzrqdXtGGe96ogaCLwG7RMhF8O7GCW268Q0fvpdBg4dyYwBrItSil?=
 =?us-ascii?Q?jsF2I2bhmysPFenmGHL/r/fUJ2lVpFVKBkWfVcxCgav/ISDvlwlDDcJK6to5?=
 =?us-ascii?Q?t095DBKPohOKEHlXmQhIghei3h4ij9jM66ILMyDZ9zfJGYRUvMVJj1TKvS5z?=
 =?us-ascii?Q?CPEoliL0DjqcCVGmdV7Vt1a3SX8njjEhJH5c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:11:27.9771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa185b6-0fab-4595-2508-08dda83112fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

From: Saeed Mahameed <saeedm@nvidia.com>

Add missing HW capabilities, declare the feature in
netdev->vlan_features, similar to other features in mlx5e_build_nic_netdev.
No functional change here as all by default disabled features are
explicitly disabled at the bottom of the function.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e1e44533b744..a81d354af7c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -78,7 +78,8 @@
 
 static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
 {
-	if (!MLX5_CAP_GEN(mdev, shampo))
+	if (!MLX5_CAP_GEN(mdev, shampo) ||
+	    !MLX5_CAP_SHAMPO(mdev, shampo_header_split_data_merge))
 		return false;
 
 	/* Our HW-GRO implementation relies on "KSM Mkey" for
@@ -5499,17 +5500,17 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
 		netdev->vlan_features    |= NETIF_F_LRO;
 
+	if (mlx5e_hw_gro_supported(mdev) &&
+	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
+						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
+		netdev->vlan_features |= NETIF_F_GRO_HW;
+
 	netdev->hw_features       = netdev->vlan_features;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_TX;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_RX;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_STAG_TX;
 
-	if (mlx5e_hw_gro_supported(mdev) &&
-	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
-						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
-		netdev->hw_features    |= NETIF_F_GRO_HW;
-
 	if (mlx5e_tunnel_any_tx_proto_supported(mdev)) {
 		netdev->hw_enc_features |= NETIF_F_HW_CSUM;
 		netdev->hw_enc_features |= NETIF_F_TSO;
-- 
2.34.1


