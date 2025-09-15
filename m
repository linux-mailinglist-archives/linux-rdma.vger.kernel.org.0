Return-Path: <linux-rdma+bounces-13372-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC2B57B53
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BDF3B1F48
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9303130B521;
	Mon, 15 Sep 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l4FQlZbE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60130B51F;
	Mon, 15 Sep 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940133; cv=fail; b=Q1tJH578QmeYk0591vEXV5qXuQR03FZ+MRniCdjh8CF0hOHDs9QcB5SiES7ENNHlrl9y5BpabPF2NnMe0v8TJVYK0+7XYBzrBQ6jNqS9eg8Rt8gDVDRqoOQFk6CwrpooB6JvK3axbS08UWHad/gUB1/QeqpE5ihlX09vYsESsuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940133; c=relaxed/simple;
	bh=hUVwdeZLbIMYTgIsKn/CWP60ViGxG+dpP1hAQbZ1tHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAxYGewDeHPxfqhd3teDLur8Vl/I5AquKVdQn4PbRpd0N5czTRESLYVd1M+yqpw31rNz/8QPSAgf6IB9Pv/3TvCSFmYEgfSSlSUa/1KISMbU92fAl8s3PA7LmaGLiDIy0U1pls54Pe4z7L5io4k6D0Pcs6b1s0cOBp9oblYC5bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l4FQlZbE; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nL+YzjqLnX3l8nPg89d55VjzXjqbDS6ddSVRzsLP7XN/ftuDfsM8XOSs4taxAdWJ7A530zZHJKsQVFFec8sKl1AKlPY2IS/6JSC7+bthdqhqysjPE6cbwlNFGkqUSYUAJtpemrPgKgNl+DdITPmMT9D5vVhfHuSHIS9KBwRBMdDXABR9W0X45binV/VW2ihYbDZhaInOh0kmyQwqNscGV8rpeMQQFY9ifx3N82QNohLqIGldKCdRzhRYmXgHjz5SCPOWO+K3fn4gBqo74gdL3t0MIP4X/gUakbRsHpuSrlNlBm+vWU0su73+zejGcvSkkrOTG/pHtQ0NmSFZ9eboSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEM3gCXO6zkXZ3J/pDEbxsDJJA+RBvrRrv6YzSS0zf8=;
 b=nN16X1iXV4l3ZwXxZqVus/VvvUUrz4iNp3LqHduMMVE7v8UJF0QcIBsqSvc1TJ3TKdiJmczmXr7NzCeIBE9Ekbg9FUWwju3cQ/2Zqt/EEFmdwP/OJoHXPQ6mx/OhhqhUC7bCnDvKIksSDtVTPFnqOK3CwPZ09us3DxlZIaLOCx2doxjekODNVGgLaPWPVvDUndczzI4TvvhfvBsWXj9+takkL/tuMhlkOz66rcQ42SRf+bXdA0Zlkpj1veEqisu7nQU3Ya1aSg68NDqCcbDAH9SniPQgAyAGThOQvUXD7e8EQmWhd5Fr3H2INGut79nA5Z7ZyR49n3tnqMkDURlVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEM3gCXO6zkXZ3J/pDEbxsDJJA+RBvrRrv6YzSS0zf8=;
 b=l4FQlZbENZ2Nciy35xGYNllXI6aOEaAqOdC0X7wNVB6wJWQtXBn8xyI6ok0lpS3lybfbjqC8fErNGaPCn4yteDJbBO3JGRXG72n4C6BMZ26xKa0pgdtUhEJWAqAcO+8tbUnGBoWouvMCj7P1j9umKU0MNpsPIz9F4kFR436cJxxJJMP8Vpjs1Vxl+nhGh0nDPGFr6sZBQs1U8Sb9G2lEtXh4zAhXIO+IlK9+5JeE/4oiT1bCi5uJDkCx3CyHWyD+tXR4mSjhNvksaRRhPX3CvkoCEbh0LC5os/qQXItSn6Y7n3RDW4m92clELL+SGkrBHfTAXmP/CUM+X1CIVL2jgA==
Received: from BN9PR03CA0901.namprd03.prod.outlook.com (2603:10b6:408:107::6)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 12:42:07 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::4a) by BN9PR03CA0901.outlook.office365.com
 (2603:10b6:408:107::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.19 via Frontend Transport; Mon,
 15 Sep 2025 12:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:42:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:41:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 05:41:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 05:41:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next V2 2/4] net/mlx5: Lag, move devcom registration to LAG layer
Date: Mon, 15 Sep 2025 15:41:08 +0300
Message-ID: <1757940070-618661-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
References: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c4545e-8c18-433f-4236-08ddf455481d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M95R4JLmHIX1g8imJkKCm+Ec0WTTas6jDRX/+WvHEKqcwvw03kSqeUSuUY+T?=
 =?us-ascii?Q?6sy7mzHnOBt1nhlEb9BeUw7cQKduYeMyyRmefCz29V/LT2jowQkfcUWAAZVQ?=
 =?us-ascii?Q?5F0TGppY+d50hfMLU00y8mBh8BKHD3UKMpXl7RR1dst5Czr9zNbbZXcb81+8?=
 =?us-ascii?Q?pvUJyXjqmg1v1PXrchtMlvqcQWgpH1VdRZ0L4L1CcjIfvKgwDEg8a3jPG+EY?=
 =?us-ascii?Q?grGJvH5FDi13Ei2cmHCZvn68EXW7TXxyHfhaditgX+CyUimNpLgI4OvV32hG?=
 =?us-ascii?Q?MyVzVTesHz8E4tfP5+YTHeTRGlNx7+qRQ+ehIgdLsaFwmlf396Cbp8uKZgES?=
 =?us-ascii?Q?TrEae5+ihSw/ix3vixiotcs70ha6d66iK1HuHmbFcaFZZ+FTcX97fCDr7YiJ?=
 =?us-ascii?Q?UPFGSmoik0XvDg2hY4+t3hEELSwxW+n21OM9dxbjg/peR3DfaK7cSbF2xeU9?=
 =?us-ascii?Q?sUnHlgDbrpxLh0KEpS4gkizodfKLy+4H1G+lRRY6ItjvTJq0wcBQAZH/VurJ?=
 =?us-ascii?Q?ruP5zf5A9ZTKY3hCwelaiBncBYsywpUUmB67LZQ2sg1kbcefaAaVuj6+neLG?=
 =?us-ascii?Q?fETwoHnRddLOQ9l8MV7pY+Xi+LB0SLzl4UFuVFmV238vbmOi/GdtUeoyCjV/?=
 =?us-ascii?Q?Vb0reOuPzByq7O2MJpxuihEbA0PXugXs9AkyZwnwT+YGAdjqF0N7YhtyyG0v?=
 =?us-ascii?Q?nYFgJ+cNAaVYyz3x3OOiFUy7eH0aFzM2s4pRSOKSTpOHualPjiuhjCBOw1UO?=
 =?us-ascii?Q?y4lZygxeii5KjPXCbjzjpkbdj+0gI4UxppnSdDFZ4nNN+erpc5GDlIrBhqXn?=
 =?us-ascii?Q?vrgbqPq36OpPokT7dQEUxlIaGmOMwIPLMuGPcY7vCDpAxonxDF3UuxNRHLmA?=
 =?us-ascii?Q?dL9sZb1exmhZ+/QC3g9TBHHI10zYTPkTRvjrlUFdTS1bQfHzpQ8E3ho6mFnW?=
 =?us-ascii?Q?L55kihlCLOpmMcNjWDYQ8f/keEq7fKTT2ciOCecg5lcOVQDYwiwm9Hu7Ihp+?=
 =?us-ascii?Q?OhQArUmEQj13LakNc+oxHzhdeaNveZVjjiYMAg1+mVQ1/NTbpGi3cqdIIBSh?=
 =?us-ascii?Q?+XbK3VyDE84CFafw3LBPVStNq2hD7FGSVGaj/PiExfg7JV6srwsyXNVPXx3S?=
 =?us-ascii?Q?R+XfYu+p1cucvwBJUi+ADAwgJK31hxh81As6Pb0e43YDvJGy1bK8EjqUKHiC?=
 =?us-ascii?Q?g/Q4SI/+06RfjZlz77h7U+2o6fqjiuhMU7tAvSRq6Y4UGc5bfJvlb6QfkjxP?=
 =?us-ascii?Q?3Os65pvrWFEQ2+5xCpvXxvnrSox79mRF87sWZWYeozRIB3BHgcw7egsO1bYb?=
 =?us-ascii?Q?zHeDzoQEbv/2za1gQ1ocb7POhkmzcZCMqci3IcyXF8Pmdw0HS3XKZFqSYU0K?=
 =?us-ascii?Q?0jgt/EI3879oTNljvcG1hKf9WOgMIcrEyTQ7yFRQgjbCYa/hYZ4cCdgavNXz?=
 =?us-ascii?Q?0w1DkUVy4qpHtavfAHBhiKEFpbJ8y+mprz25sC/vfH32JbYCW95R5BeRi1fj?=
 =?us-ascii?Q?FCFDnTsRRCrfzRsg1A4GfbDsghkhdPkZ88DA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:42:07.3978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c4545e-8c18-433f-4236-08ddf455481d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838

From: Shay Drory <shayd@nvidia.com>

Move the devcom registration for the HCA_PORTS component from the core
initialization path into the LAG logic. This better reflects the logical
ownership of this component and ensures proper alignment with the LAG
lifecycle.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


