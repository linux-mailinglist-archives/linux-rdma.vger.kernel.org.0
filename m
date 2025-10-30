Return-Path: <linux-rdma+bounces-14144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A06C203FA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 341FE4EB0D8
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3255244664;
	Thu, 30 Oct 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKiRmhYS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893EA2475C8;
	Thu, 30 Oct 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831220; cv=fail; b=I6Sn4tgduICpuTippWv66fNwKURknDpXr8+wIvDKZ4xQBc3CeVPobS9kGZPqQx4btuNlGVqqvBTG6NfhbPWY2gPR6/jCU3rdrjnAp/pG9VLoVH14jvhpO2RxDgY/YjcauReh8yURYHAZsOFyvbvHaf2OcYV0WUPMeRSMc7Wm1kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831220; c=relaxed/simple;
	bh=n+ZeSGa83CGw0upz4YmebTGZqVZ4uhsXugnY9YdJ+TY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbZ9uGqsJtbvPIJpTjRUSI9W8rxeTu+55biR4aF50oG02xw+3w2iUpYIL5ZYmiz7Xj4L09aYO3aictN1Y74LzW7gscJwkxv1l9Io2iO2/YM7ll7ZJpvaLWsUGMOUUDmQrIZ2QsdA5CWuUHo0vqnJOcjC+G2QboHVq74PV1yhfEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CKiRmhYS; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1RA6FLGrg1ppe2Ljr2bMNN5pd7Q1UfcnRaw5Ts8WW6k63HzlsqtbjWtZznYVfOI9sYsoUlFNMilD3+qVpy01gvPNy0pBCPuuGGd7qiPSg1PzZQi7JeYBm8SU3ydhFM5WkmdlkuFmbt6CCaSkMOyGZQIN746EvkMJQUYAxPYl7+rtLZBgVLLG/e3DTIXNmsndz0i0Z2+EI/9GLXh8+e2umSEPs5Fozi98kedIYhqP6AYC+RRgJqG5/truDEz7DihwRAfq7+9Ew9JZp5ULpC91OWdumAGf/P7/ihBUCznQBD36RGqcCqgHGMelKt6kbhM9N3ThIE/nreCS1gJpZKhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqIJocDiKDuhQ/0TM/ml6JA1PelqaaIxYlUFELNy1U8=;
 b=HamYRhQ1vNepL9UcBLafC1TA6v35Pp7SQUc6raHYB5EDJP7loEdjql2kAfdSq5fseIwTeW1/UcN/1JMd1pWL6cLFODPLLZKgWiAnwFITV8fvzY/fytV4OTbKsBGJryhD0KHD3JGJWOf4fC/mk512AetvAt7vtkVMLMaLHOIFDhm/pz6dL7NsccQlo18O4hmORM3qfE8BL+HKT9diDYrF0YTnviEeqLPL5M7M33jP6jT4sBZ7ISxyuoovvbWeb+chnfoUndpFJEtF22VOyRrtp25P7sCJUxKM+QEHxNHa19+a3vDlu+0AUqtR68bjmSyfJ2oxsNbbgCezxuKxraPhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqIJocDiKDuhQ/0TM/ml6JA1PelqaaIxYlUFELNy1U8=;
 b=CKiRmhYS50gtqfgMlai85qXUGrAQI5ENdtKk4cwPjV4oDX636EtzidF58ysZkuOfnPFXCu9u8ffq9p/Tk2mO20qNt4j8LJ8lk8rdR0Ws1fKGIuoozXZPyty0i2GnOKCeA5LYaja44Q2tYrRvItOsgTdvhM5X7gjqxgT5qkZXfBTVA5IhCjSmDl9nwnY/tvsrVMSVolvqy8KpgenLQA79GJZtXi0T4Llb8GKv8bARP5H6iL2pr3Sr2TJtTsjzWZNazt88q9VG5i9I4zy749gnsj5O3ojWS79n+uMzLI95DKb1NuDkOGJ/sA6PGszdByzL6btiWVnuNs5fqABZ+lU4Jw==
Received: from CH3P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::13)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:33:32 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::5d) by CH3P221CA0028.outlook.office365.com
 (2603:10b6:610:1e7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 13:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:33:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 06:33:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 1/7] net/mlx5e: Enhance function structures for self loopback prevention application
Date: Thu, 30 Oct 2025 15:32:33 +0200
Message-ID: <1761831159-1013140-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: c041ce78-42f0-4f1e-2649-08de17b8eaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+vMKwypRUQlkt3DU9i7wEj8L4+bBw9ANVZgTodAMLxAYNvLdTealhvgzSpSR?=
 =?us-ascii?Q?PIZ369qoz6bHANi+++QsrwrUfCK3NJQ7emTmx+Bria5xHHE/dw8cmPanhIU5?=
 =?us-ascii?Q?HPNCOGd/TndHUmWwWH8sHIWil0ydTgmS1AJqs2kai34siI8IUKoSrkrm9TLO?=
 =?us-ascii?Q?KfZDQLE1hiUjnJwZrHHJCPG5zSXLetJBOj0zhAf3CO9jlr1Rh+TkYf3atYPI?=
 =?us-ascii?Q?tLbSd2C0X62W688wrLBnadhi/d8rI65gNymsw1hgP0aUJghSjbbC2XL3yfW8?=
 =?us-ascii?Q?GS4jq7gNrwLob+rtjGd60qB0FsyTwU1a1kE4KPHs+d6yLEVYczi6DcWSncum?=
 =?us-ascii?Q?FyhhR40PrnaZ3tzn1LCf6ELKP8zYZI471S2IROllvo0sU+Uf/7i/o1dK3duq?=
 =?us-ascii?Q?4AYYsS8C7JVLBJsCmW0T7dA5h21IHFp9ngjSY7QLoFoM2kNS1krMT9bUw6fy?=
 =?us-ascii?Q?TPirhcOGM9MmX1dC8TnysMCG8de7XikRydNeQLkQgb/wpV8KSnmHNVsiRW4Y?=
 =?us-ascii?Q?GPDsk4Yd4Zp6agnMh5jxyZqCDZIvvBFjvpAu42LwM8EXfAVl59NMxUJsG10Z?=
 =?us-ascii?Q?d+KwS7rDvMrDEpZnJEafX9gRBURMBOp1Ia6D1IpYNMDT925ulIVMvyPWj7aC?=
 =?us-ascii?Q?nrYOl04scpN5O+EmLeVH1QcYrgE8UpDXWpfsPhJsJJWuEZlE704MOJmBXyAw?=
 =?us-ascii?Q?dihdegMclHpa3C2r29zOXKjgw4OLTNdkppRWsWOsWchxT8WImvI4iFwIUXq6?=
 =?us-ascii?Q?57zdTWGIQ0Sw+I/7JOy7Z0BGQV1yc2y0kxGL1xXgihYA0EnYKHW1avbptett?=
 =?us-ascii?Q?o+kpO9dSshUWaP5t/S9EF3d5EeB1LuAclAZK7hlsmOhdLJUooxVS+EQ1Xtrw?=
 =?us-ascii?Q?eeE3UxG11WF2ydtvHrJ3vbomCl9xD7mBZAhJAaz30lPGeZVvW5fGW1+mDc0S?=
 =?us-ascii?Q?sw8cb+vpJPmRMF4YkOX99I406tMUaRBG77c1+JhJ9c0uavkGmQ3Lk/zZpXiW?=
 =?us-ascii?Q?RFy+NyxtqCfcMukaIcUvRQo/W/2CJDUoOLc/QDtNcnjcCKGtk5fUf7mOUR1c?=
 =?us-ascii?Q?cF/xNbHcFIQJhRoA846gY9PQTp3DlqZ37h2Ob6gHRaIHV0y8v+AEy1W6ip0Y?=
 =?us-ascii?Q?+rz6HUNIOO8miYvIwP/b7hsdsjMwHMe7Cfzdk7+/4vAA1LHPL9INcoX/S1Sa?=
 =?us-ascii?Q?YNB7c6rDJFdMsMbjXNXzsrjs+OZQ3PcmdasP/nieHUmtBhsocaZDJTpltN+U?=
 =?us-ascii?Q?4pYrrRfT2FuvUz6l6jKaGEDO9sgr+pR+dniQ5pBhdybcUvOcF+0L9R+hQm4A?=
 =?us-ascii?Q?TaO5vgIScriJ8rzWNUJ6yWb/JIHpgWRt5R2NqeUCoirzNDcsVWWVTitz8cpJ?=
 =?us-ascii?Q?zy35Ux2TjeWGKcRJFvkoEVc1PiCzJTs3OZsQg2mZlah+sFb96aSaPqEcJI+H?=
 =?us-ascii?Q?TGICsnA1h47q3HwYOwvwPntVrx1L9nlETO2xOZoqilrrNF2h+m4EQx8lSNjH?=
 =?us-ascii?Q?MsXaOqjNvN/FvEN0l1cHmCiPcz0q6218c/9BbODEENXW2m4PHXcwc9DzzTnJ?=
 =?us-ascii?Q?/2cEOegQv1Ym4/0tlnc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:31.4509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c041ce78-42f0-4f1e-2649-08de17b8eaee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669

The re-application of self loopback prevention attributes in TIRs is
necessary in old firmwares (where tis_tir_td_order cap is cleared) after
recreation of SQs.

However, this is not needed in new firmware with tis_tir_td_order=1.

As a preparation patch, enhance the function structures to differentiate
between an explicit loopback prevention configuration apply, and the
re-apply operation required by old firmware.

Loopback selftests should now call mlx5e_modify_tirs_lb() directly, as
their use case is not related to the firmware limitation.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h     |  4 +++-
 .../net/ethernet/mellanox/mlx5/core/en_common.c  | 16 ++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c    |  2 +-
 .../ethernet/mellanox/mlx5/core/en_selftest.c    |  4 ++--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c    |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..a25588fe2773 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1154,7 +1154,9 @@ extern const struct ethtool_ops mlx5e_ethtool_ops;
 int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey);
 int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises);
 void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev);
-int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
+int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
+			 bool enable_mc_lb);
+int mlx5e_refresh_tirs(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 		       bool enable_mc_lb);
 void mlx5e_mkey_set_relaxed_ordering(struct mlx5_core_dev *mdev, void *mkc);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 30424ccad584..376a018b2db1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -247,10 +247,9 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 	memset(res, 0, sizeof(*res));
 }
 
-int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
-		       bool enable_mc_lb)
+int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
+			 bool enable_mc_lb)
 {
-	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_tir *tir;
 	u8 lb_flags = 0;
 	int err  = 0;
@@ -285,7 +284,16 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 
 	kvfree(in);
 	if (err)
-		netdev_err(priv->netdev, "refresh tir(0x%x) failed, %d\n", tirn, err);
+		mlx5_core_err(mdev,
+			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
+			      tirn,
+			      enable_uc_lb, enable_mc_lb, err);
 
 	return err;
 }
+
+int mlx5e_refresh_tirs(struct mlx5_core_dev *mdev, bool enable_uc_lb,
+		       bool enable_mc_lb)
+{
+	return mlx5e_modify_tirs_lb(mdev, enable_uc_lb, enable_mc_lb);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c46511e7b43..ad9835129383 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6132,7 +6132,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 
 static int mlx5e_update_nic_rx(struct mlx5e_priv *priv)
 {
-	return mlx5e_refresh_tirs(priv, false, false);
+	return mlx5e_refresh_tirs(priv->mdev, false, false);
 }
 
 static const struct mlx5e_profile mlx5e_nic_profile = {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 2f7a543feca6..fcad464bc4d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -214,7 +214,7 @@ static int mlx5e_test_loopback_setup(struct mlx5e_priv *priv,
 			return err;
 	}
 
-	err = mlx5e_refresh_tirs(priv, true, false);
+	err = mlx5e_modify_tirs_lb(priv->mdev, true, false);
 	if (err)
 		goto out;
 
@@ -243,7 +243,7 @@ static void mlx5e_test_loopback_cleanup(struct mlx5e_priv *priv,
 		mlx5_nic_vport_update_local_lb(priv->mdev, false);
 
 	dev_remove_pack(&lbtp->pt);
-	mlx5e_refresh_tirs(priv, false, false);
+	mlx5e_modify_tirs_lb(priv->mdev, false, false);
 }
 
 static int mlx5e_cond_loopback(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 79ae3a51a4b3..49ab0de762c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -316,7 +316,7 @@ void mlx5i_destroy_underlay_qp(struct mlx5_core_dev *mdev, u32 qpn)
 
 int mlx5i_update_nic_rx(struct mlx5e_priv *priv)
 {
-	return mlx5e_refresh_tirs(priv, true, true);
+	return mlx5e_refresh_tirs(priv->mdev, true, true);
 }
 
 int mlx5i_create_tis(struct mlx5_core_dev *mdev, u32 underlay_qpn, u32 *tisn)
-- 
2.31.1


