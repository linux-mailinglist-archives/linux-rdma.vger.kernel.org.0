Return-Path: <linux-rdma+bounces-13264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9E6B528CA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 08:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D2E7B8728
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2886726C3A2;
	Thu, 11 Sep 2025 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQOLYeu1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFC1DF97D;
	Thu, 11 Sep 2025 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572324; cv=fail; b=gH/qpok/xeW/X+gaXF0FdJ4/ZqhMCi/55U0R6JBv5mvh2IReUvLdVdnEGPlk0cDHMXwxtWxDripiD8nL9uhDajEm7qkVU1vJL23TjuY+VO8HZmAikuE5CXmXF/kOS7t9x2Pd5uzRKjVsaMzdazVfnH+Lgbgx6OKxZ8sEAUdan7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572324; c=relaxed/simple;
	bh=jsHjJvNGwll3QoaEhqsBIMHBJDduDzHAVosbTjnEHgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfJvGT3X891NAXCNFJ0b69AHnggCbACWeAPPsy1ACXgfD5b0Ug/auK6iwn+VbK95S9+k4IWWw4Zw7y4Cog7HpOByKhfe8QBChPwwS7ByG+UUYo6C5CUUfNm55aQWdsKWspd69p33I+H6O0I9eKqWOQkmaRY0oqZzWBLz6ALzQrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQOLYeu1; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMKTAMnF7+3bJCyNco+Ud0cquYL5NiEeFV+dI/ZNAYDd24JyP/2pNnqw9Lv+sKwG5lOPxZfhkWfmHA/ClPk238f32B8kzBEYsU9T1GOKud6hRt77Ex6AJulDunTuXawO7dFBJZ/EfTilC6AGhHzsEbcWxuasTPza6zTEtouNJc6wJTuRpLEU7jtRMZ6MTU1KhlS2AChZoWIojroKrCprPps8F9jgq6Tyw2G0487Ca2kEDEBDICMj1I6gOQk6e0qJcNFvBgZfMKHfAls1YgBRXMSRWdb784MURr6lgYsrOVaJhdy3GIVCLG5W4UYvyuU3IfYlaf+1qKQs9vCa/EQ+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt36dTGJ71EZf9tdU2KjNWWK7m6elpOqlNY5DVaGpFg=;
 b=LtYadZp4F1T6HNv50Iy+M/XlvHYCihZ71TozzDbt1dkxsKpbFNG4syo7CVJVg/TgJ+ch26Ze+z41QB+uUm/nYyQUxMTGX5vEhQZoVXU+2HsJU8qbQNbbGoYFU8POoD+jraeIrOmO6LrAvab6s9Vl83Jizln5+WSn1kEsX9GzrA/xsEAXos+EVMcDu9IPipWGsKWOS+eAMuN70VKTjA1QJ24hXn6OMKQHxEm65XlGdPk32U4fnS3hUa8D5A3Uawqj7MUVSdmH6JEVqZtsHwlVCcFCc056qd/bjWe9CCItWgK9B0qxKUx+EroubfIi0EjcxBWDQFp1LcfIlswOTv6Thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt36dTGJ71EZf9tdU2KjNWWK7m6elpOqlNY5DVaGpFg=;
 b=FQOLYeu1nve1FLVj92ZXVao4QwnrjJVhhqyzAnHAdOh7WmIxbo0DQzJYl2rUEoJZCfxUGULwv2n59stFRJqQikLNbB5ZfUxcuMZXRqdX3TgcU8nFz7ufaxRhh69WSs1k8scEhJ9FYknpaLyY9K6okWWM2w+PpObiYhJMQt6wTLdyLTodCw1U2tJe0kKLiaC483EFJpiVnjup7D3ubBgk8oL+1lvWm9ZkowemauQ3/ZFhW0sfgK+NhTFqQ3Dhh5HSeDyCeBG+D4NC0W5WZZX0fXkiVDPssTEyUYmBICuoBWOxkodoAxkY9poix9weBg1VU8jvximMLVS7MZ/UaA/+jA==
Received: from SA1PR05CA0012.namprd05.prod.outlook.com (2603:10b6:806:2d2::16)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:31:59 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::4c) by SA1PR05CA0012.outlook.office365.com
 (2603:10b6:806:2d2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Thu,
 11 Sep 2025 06:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:31:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 23:31:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 10
 Sep 2025 23:31:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next 2/4] net/mlx5: Lag, move devcom registration to LAG layer
Date: Thu, 11 Sep 2025 09:31:05 +0300
Message-ID: <1757572267-601785-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: de145ebb-cf59-452b-5a50-08ddf0fce8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ARl3bdVnN7ZbHnqRKjIM1t7shqRF8E+cv1/wmD1r4EJGe2TcaMHp4PyZJ0Kn?=
 =?us-ascii?Q?SFQ/Kf18ovr89csgNBVrE3Rr1F7yjHDDKNBoTwPr8Jd3GE0FF1WETkFkBWOE?=
 =?us-ascii?Q?Ib9wLf2OeckiWR9iuOF0+tFF4AcsqZqJhFoPalPek0c2S0oCfH4erMiwIs6G?=
 =?us-ascii?Q?QIm84nlEEP8ONW9MvKI8wLOqxfe+O1bXXfsVZBqXWD6WzfVbepGhjbfDKriC?=
 =?us-ascii?Q?cqBhQcff0qQqRnnnV6wYx526LWOXGAnOqNMIIy9UiE9NwBNQm3q4I7VNjCsA?=
 =?us-ascii?Q?YPJw2/ulv3N1gLwuLx30Bmhr88idgixUCEfdwoxve4dk6r84jdO0v8KUxFFD?=
 =?us-ascii?Q?Rq5T6b9QmI1yEUtiKtl11eZO3uYqrYUnYrUelU0B9ZYIk2HQYH627VEYWHPb?=
 =?us-ascii?Q?KUh+psCzYt+bA7AXP8pLEfiPc4vkOvueliJ/+URog66lkwO7jDQhVU0RsB7b?=
 =?us-ascii?Q?F4OTq6PR5idj4JnaGDymJLyMEYqla0DkWv0onsGDj+qtt6DtHA2BbfXLeBhY?=
 =?us-ascii?Q?W/5yLBnWu8H8NF/gcetY9yrxXtBrxG29AjD8XW0+qADbsPfUfP6elFZMu1Ul?=
 =?us-ascii?Q?UWnvs5dEd430uE6ProwZdfQLCTozoUKjjldxJNtbjJ9XZPc2JUOM2WvMJKzP?=
 =?us-ascii?Q?Nj6aN8v+gBsvVWvfN/JADAiuEdR5vWaP1TrfpxWT1zR6nSzxmuVoxZrM4X2L?=
 =?us-ascii?Q?rMfPiJQupAHSiORrWRlr5ZT6mppKfmzFnheoumvYeSOWP8LZcx+QChty/CXT?=
 =?us-ascii?Q?Jv7nvYKt7QnDSIINorIiItYXPMrL+knA7/QCrKuJndCpvsBKP3dDUH5kPUZb?=
 =?us-ascii?Q?XxMu4i5NYNanvKJ5Goqn2O0bqlAnvLrJhKsMyW5Kp47Lh1d/JyJtdwRulSDj?=
 =?us-ascii?Q?B6ymqFz9SedM60NOoEt+NyptYTlXQNUzBiWsn5N3lUgKYd+xKg0HpwXq+tFA?=
 =?us-ascii?Q?oiW2IuSQPMmmxauPk3gwMjjMfmAjs7/SXghkQkWGbebClm63xhHzmo7p6dPt?=
 =?us-ascii?Q?ZxJU+p9EKeLO6ZHKjM/hEMwzHWsVb02OIQqVnQLR78p5FiwsGJtGyBbDhTD2?=
 =?us-ascii?Q?GN5w0ey2wrw9x8htD5+IjvIbkdWPbArsEdC++WozCVnnGULptf3lmS8yJd7L?=
 =?us-ascii?Q?13mN1hziMXPHKis3zhAJPi5A5bz6IUsRWC87kqGw2OzXlmgrrOZOk9e3smzE?=
 =?us-ascii?Q?piFJ7Tp/BNC8WGGN6GBWmr1oYQ8zir72TjALvX2qg/wY7BlC4uyv0eDSWsu8?=
 =?us-ascii?Q?ZHJN6nJnYYYUciW3x29wSzmkk05anGgZ3qQ7l4HSiE8wRIHBg+zz+VvEw6Ye?=
 =?us-ascii?Q?I5pcFNeipGmtcQTroujOL/KAJ/+D6v81xx3gJ0T2iGiII+vFeZPJ5e4NEUZH?=
 =?us-ascii?Q?KNUU+i48id+UEwzwPS8wyaSSnxErp7yw2DaQrDZsYMUYsMZmnOsZEdqDvRaB?=
 =?us-ascii?Q?NV3BCv6i8OVE+da42ww/6ybVy7bDWXR6/MiVUqIt0td1nzvYvKUv1o/FtGMg?=
 =?us-ascii?Q?xY3AaWLzgpDhlNizCa2fSoPB+LCvh5Ivhryu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:31:58.6115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de145ebb-cf59-452b-5a50-08ddf0fce8f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

From: Shay Drory <shayd@nvidia.com>

Move the devcom registration for the HCA_PORTS component from the core
initialization path into the LAG logic. This better reflects the
logical ownership of this component and ensures proper alignment with
the LAG lifecycle.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 31 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 27 ----------------
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index d058cbb4a00c..ccb22ed13f84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1404,6 +1404,34 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 	return 0;
 }
 
+static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
+{
+	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
+}
+
+static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
+{
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = mlx5_query_nic_system_image_guid(dev),
+	};
+
+	/* This component is use to sync adding core_dev to lag_dev and to sync
+	 * changes of mlx5_adev_devices between LAG layer and other layers.
+	 */
+	dev->priv.hca_devcom_comp =
+		mlx5_devcom_register_component(dev->priv.devc,
+					       MLX5_DEVCOM_HCA_PORTS,
+					       &attr, NULL, dev);
+	if (IS_ERR(dev->priv.hca_devcom_comp)) {
+		mlx5_core_err(dev,
+			      "Failed to register devcom HCA component, err: %ld\n",
+			      PTR_ERR(dev->priv.hca_devcom_comp));
+		return PTR_ERR(dev->priv.hca_devcom_comp);
+	}
+
+	return 0;
+}
+
 void mlx5_lag_remove_mdev(struct mlx5_core_dev *dev)
 {
 	struct mlx5_lag *ldev;
@@ -1425,6 +1453,7 @@ void mlx5_lag_remove_mdev(struct mlx5_core_dev *dev)
 	}
 	mlx5_ldev_remove_mdev(ldev, dev);
 	mutex_unlock(&ldev->lock);
+	mlx5_lag_unregister_hca_devcom_comp(dev);
 	mlx5_ldev_put(ldev);
 }
 
@@ -1435,7 +1464,7 @@ void mlx5_lag_add_mdev(struct mlx5_core_dev *dev)
 	if (!mlx5_lag_is_supported(dev))
 		return;
 
-	if (IS_ERR_OR_NULL(dev->priv.hca_devcom_comp))
+	if (mlx5_lag_register_hca_devcom_comp(dev))
 		return;
 
 recheck:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 1f7942202e14..eb3ac98a2621 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -973,30 +973,6 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 	mlx5_pci_disable_device(dev);
 }
 
-static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
-{
-	struct mlx5_devcom_match_attr attr = {
-		.key.val = mlx5_query_nic_system_image_guid(dev),
-	};
-
-	/* This component is use to sync adding core_dev to lag_dev and to sync
-	 * changes of mlx5_adev_devices between LAG layer and other layers.
-	 */
-	if (!mlx5_lag_is_supported(dev))
-		return;
-
-	dev->priv.hca_devcom_comp =
-		mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_HCA_PORTS,
-					       &attr, NULL, dev);
-	if (IS_ERR(dev->priv.hca_devcom_comp))
-		mlx5_core_err(dev, "Failed to register devcom HCA component\n");
-}
-
-static void mlx5_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
-{
-	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
-}
-
 static int mlx5_init_once(struct mlx5_core_dev *dev)
 {
 	int err;
@@ -1005,7 +981,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	if (IS_ERR(dev->priv.devc))
 		mlx5_core_warn(dev, "failed to register devcom device %ld\n",
 			       PTR_ERR(dev->priv.devc));
-	mlx5_register_hca_devcom_comp(dev);
 
 	err = mlx5_query_board_id(dev);
 	if (err) {
@@ -1143,7 +1118,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 err_irq_cleanup:
 	mlx5_irq_table_cleanup(dev);
 err_devcom:
-	mlx5_unregister_hca_devcom_comp(dev);
 	mlx5_devcom_unregister_device(dev->priv.devc);
 
 	return err;
@@ -1174,7 +1148,6 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_events_cleanup(dev);
 	mlx5_eq_table_cleanup(dev);
 	mlx5_irq_table_cleanup(dev);
-	mlx5_unregister_hca_devcom_comp(dev);
 	mlx5_devcom_unregister_device(dev->priv.devc);
 }
 
-- 
2.31.1


