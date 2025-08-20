Return-Path: <linux-rdma+bounces-12837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A1B2DE02
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F10E188BBDF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40C320CB6;
	Wed, 20 Aug 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hh3JfCMB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61C320CB2;
	Wed, 20 Aug 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696805; cv=fail; b=ljnYn/jQJSf3t/Cn6KPePRUCCirYpj5CyvdeEFoDzVa3PZUuCsewXpe8ZXoPtNwhedo181V7xutQ/zivcyTHY+otHFXyI/O0ZOqUyYkn8w6qt5MnXEKuqTwyxlzP2mLFn0wwy1P0CAbDM1HO7K6D5kqzX28bo8hbIZQkGJOjiOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696805; c=relaxed/simple;
	bh=r4OWMpFRlD1QXjTYj59WudBUav/5hJ2xx9wQe82B7rM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/qSTLRPiWOjTi8ecMwwFgPgxzKxLbgnhbeaXRPPeNf17b49EDPCF2Ppr5KhiZhekisYUJU01FOK+GMwx50ST6hAH2DceAu+AMX3dNvK7SVDIR+fcehiEuutIF67AHesAiu5YV0e4goTxQ8NsDsPasxjZ13/pfPfOLCwvH2Oc+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hh3JfCMB; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUPYW2VRWMePkXX04Jv2xsOVrXR1q3p48TId+CaG3nZQaBwW+LBvuwJeGkhcb/R/BPzE4PIzM2A8w1YsjS+jkw94eaMPuEPM8+shG88ppaP3vqWMQRoCO/ZoTzjo7x0rJAZspG8PScKxAXp/9r5wh5vnQmQw7/IAJTCxzXfpyxjdk6i5trMXPUayWjYT5cmoCxz1QLAnzmPJdCJqd7ohoxQwXTGoLqKNLAZnSeFaJZHls2XiuA2NW4cBfcIHn9H7ybaWj4P2UedoyDXakOO4bvrX9XIDNGJgHpEe98TN/lOCcwU/bWz7PMPn7fOtx9PCjR32JJe7WAbg8MNEPaIfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpNz96fuoQaKhfN1KpGb6IkuzhXGoFqz1f6inIATB4c=;
 b=aWWKPL563Tqay2cTfgNPHpSl18bPJAykHsnVr/X7Ld2Q2zdT0rlv+hGullBp/f0/nvXFdHdIEvVbb5lp1zVYvFLmvJhySPGTHtQ0WtyK4RpMYZo4wZCJJga9I21EhtVBN9duhtUuo9/qv5dYdMD/Bji2Z8Sb3VAbySyr4Iv29K9CHsHgEAOheSL4QT5hV4DcGgw7efLAC+OcBzEGkyWpG0CL+seLRQwnzZQrlCARM1ILiCLf31qMw8PZ1yehmCFQXc5VsxGcnsywM0/CBBgGpXNggYgtRmP9ZTDHybol86dhaBOUoCT85jT6VYQe5enC3ZfiQKEMGoIr6XQe/iGX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpNz96fuoQaKhfN1KpGb6IkuzhXGoFqz1f6inIATB4c=;
 b=hh3JfCMBCHxZB0scJZpnKNJnZX2wdqFVnfVePEJCGyWOezxdfMaHjGGNZOkWCE6X11OA52IAq1bkb8JNm1/+0GrnON+ifMVXhk+3aKrQwTZjOcAV9JS5qBX4dMyov7fXc3T+PoX7NGxQnnRwPnYeyO8X527oxKt283nsYwwYiejJSeE78PR3zkkzs2pnWE32OA5cUDDHfm/umLNBMRKGZGUQ8DlqsFycR6UoWUt6km5XJlkejtAW6JXtqtC/4p1MUIkltMesTJw953fxzn1EnezWESV0B83Ku0YPxuIOx/INdg2uEEz0v8ca6dRnR+anducBan9cx2qVYTQnMm/SPw==
Received: from MW2PR2101CA0019.namprd21.prod.outlook.com (2603:10b6:302:1::32)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 13:33:21 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::41) by MW2PR2101CA0019.outlook.office365.com
 (2603:10b6:302:1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.5 via Frontend Transport; Wed,
 20 Aug 2025 13:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:33:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:53 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Huy Nguyen <huyn@mellanox.com>, Parav Pandit
	<parav@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH V2 net 7/8] net/mlx5e: Query FW for buffer ownership
Date: Wed, 20 Aug 2025 16:32:08 +0300
Message-ID: <20250820133209.389065-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 89053f60-f518-45a9-0c01-08dddfee2139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1//ZNnEbbS3i47VkwVVWocuWbOfgiutSKNyt7UHyc0ucJdAXH3rkS6vF+Sg5?=
 =?us-ascii?Q?FtW1pesVq2c4wzjnatU3I9EDqvdURJMWMf5ciGs16n7tmwSHgmXIJHJCwocX?=
 =?us-ascii?Q?mtNIG78PulFNtEr7M+Im0Mbix4sMwMk9zOKKDWcZIs3TzYDvDRtNiURKrcmQ?=
 =?us-ascii?Q?J6RzSn/3gcAHt4d0XUWsNVix3AWagDsVNfG5gtfiuH2UP4Pdi6ZP1g9AbU0/?=
 =?us-ascii?Q?ZBkpqDETuYOD8T7k8iARcl6uUpHuYT+8JTgFEc/qG+PnR10mn4clHVnqU223?=
 =?us-ascii?Q?253T8M+OKv8SXLdfiI2e3dDqR6TZl3dOirbdppZFrib2XNXj3SjmTFgPVQHP?=
 =?us-ascii?Q?+OpxHf3pumfbUYWVDcQthl4Souu29MqRCUG29wukc22Tnu5FNnj23Y+BnjhT?=
 =?us-ascii?Q?ER040nMJzZgjaOuHS6IUyHe8d7YGvrN6/pmrM7po86y6wy9iJaP5i6I1ZLj0?=
 =?us-ascii?Q?RBGXyoUGydCjBNyn9FxQiFodcBm9BXGBGCfDmSyQbDF3omGOtYit07Mo8y3/?=
 =?us-ascii?Q?mulhIVwP+e9AOSeCDa+jNczCWO2llfuSLMVrLO2iTcxwbfUtr2JKpj/zVU8T?=
 =?us-ascii?Q?E7fnWgXz/gyJnMn+MohbYPaJNLG7HvrXFn5Ish2uynv+fsQ45GKzhBQ2zuDH?=
 =?us-ascii?Q?LSjZyDIsy4ngKodIycZm8wQJQ2lbaxSfPdLvDiXBKmCuQUOkccNH4piWjq/c?=
 =?us-ascii?Q?JHqVCdEZcMBzEDOa+aL3W+Ratn7a+pCuNINiAiqaq4N4IlFvGckQh4NvnN+j?=
 =?us-ascii?Q?JnQPoQNEQSkqKPBva4+ZAX2wAjpJA5ITnrEQxmxH8Bi3/qOnpefehhFthnE4?=
 =?us-ascii?Q?wNOvPslv/tAQHeHfV3xSNCLX/QG2Hw1xuyh79qYSwXYvvAGzSKF/g5qlf3+K?=
 =?us-ascii?Q?K162zhH09/Z3d2ZJmgfJ7BV4a9EeU3sa+p1L1bRWkHtpZqOmgE1EzHl59HBF?=
 =?us-ascii?Q?4kpAq+iaR/39ETE8EuWfRwKYdDzKShnMdh08vz4lRGtCC7uhbJsUmEoOmNwz?=
 =?us-ascii?Q?JWot5wUUxCb1VR6xBVLh8PJHewP47FzwXoxz6nAYIbuPZPzx4gvZBe3BzhsT?=
 =?us-ascii?Q?rVkCxJw2PQ7kSH/WTYDYfe0/J4M9foU9bmXZEUzCqawEojpPJcIon4pWQ+qM?=
 =?us-ascii?Q?GgArM+KQC0XUEJrr/SQuYWCGlKQlqqqM2qUQ1/w06RUkLQLzaKpoFvw7KYu1?=
 =?us-ascii?Q?1QsidfSAJqdCB3I94gmyc8cL0mgTZ5dNvNxfVinKh3T2FAKWhN6/kv1j15Lv?=
 =?us-ascii?Q?bFyY9iAnhZey7TOraLGRV6aG8MrBAvZnqtneYQTWAgNnbyl93RnQ/dx0zYly?=
 =?us-ascii?Q?SV68BIoz3B8tqqwOstLvCcPTlpNSQM4IbrBrd+PKZfYmm7E2o/LplX5e4aLt?=
 =?us-ascii?Q?+GvYStcM5yJtflNknncDnfkpvJnX+CceSo1OKYSkofFPJTJP73FJKown0sn9?=
 =?us-ascii?Q?+NUwn8AnQw0o8T4UF+7eyT+MP3V4xWT4dbiHgRQjJ5NZvWRAXSdjANj/kDQg?=
 =?us-ascii?Q?EXRAs1ZJBjVMlhzm1UPslny1l3QSNRfY6aZP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:33:20.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89053f60-f518-45a9-0c01-08dddfee2139
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

From: Alexei Lazar <alazar@nvidia.com>

The SW currently saves local buffer ownership when setting
the buffer.
This means that the SW assumes it has ownership of the buffer
after the command is set.

If setting the buffer fails and we remain in FW ownership,
the local buffer ownership state incorrectly remains as SW-owned.
This leads to incorrect behavior in subsequent PFC commands,
causing failures.

Instead of saving local buffer ownership in SW,
query the FW for buffer ownership when setting the buffer.
This ensures that the buffer ownership state is accurately
reflected, avoiding the issues caused by incorrect ownership
states.

Fixes: ecdf2dadee8e ("net/mlx5e: Receive buffer support for DCBX")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/dcbnl.h    |  1 -
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    | 12 ++++++++---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 ++
 .../net/ethernet/mellanox/mlx5/core/port.c    | 20 +++++++++++++++++++
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
index b59aee75de94..2c98a5299df3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
@@ -26,7 +26,6 @@ struct mlx5e_dcbx {
 	u8                         cap;
 
 	/* Buffer configuration */
-	bool                       manual_buffer;
 	u32                        cable_len;
 	u32                        xoff;
 	u16                        port_buff_cell_sz;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 5fe016e477b3..d166c0d5189e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -362,6 +362,7 @@ static int mlx5e_dcbnl_ieee_getpfc(struct net_device *dev,
 static int mlx5e_dcbnl_ieee_setpfc(struct net_device *dev,
 				   struct ieee_pfc *pfc)
 {
+	u8 buffer_ownership = MLX5_BUF_OWNERSHIP_UNKNOWN;
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 old_cable_len = priv->dcbx.cable_len;
@@ -389,7 +390,14 @@ static int mlx5e_dcbnl_ieee_setpfc(struct net_device *dev,
 
 	if (MLX5_BUFFER_SUPPORTED(mdev)) {
 		pfc_new.pfc_en = (changed & MLX5E_PORT_BUFFER_PFC) ? pfc->pfc_en : curr_pfc_en;
-		if (priv->dcbx.manual_buffer)
+		ret = mlx5_query_port_buffer_ownership(mdev,
+						       &buffer_ownership);
+		if (ret)
+			netdev_err(dev,
+				   "%s, Failed to get buffer ownership: %d\n",
+				   __func__, ret);
+
+		if (buffer_ownership == MLX5_BUF_OWNERSHIP_SW_OWNED)
 			ret = mlx5e_port_manual_buffer_config(priv, changed,
 							      dev->mtu, &pfc_new,
 							      NULL, NULL);
@@ -982,7 +990,6 @@ static int mlx5e_dcbnl_setbuffer(struct net_device *dev,
 	if (!changed)
 		return 0;
 
-	priv->dcbx.manual_buffer = true;
 	err = mlx5e_port_manual_buffer_config(priv, changed, dev->mtu, NULL,
 					      buffer_size, prio2buffer);
 	return err;
@@ -1252,7 +1259,6 @@ void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 		priv->dcbx.cap |= DCB_CAP_DCBX_HOST;
 
 	priv->dcbx.port_buff_cell_sz = mlx5e_query_port_buffers_cell_size(priv);
-	priv->dcbx.manual_buffer = false;
 	priv->dcbx.cable_len = MLX5E_DEFAULT_CABLE_LEN;
 
 	mlx5e_ets_init(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b6d53db27cd5..9d3504f5abfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -367,6 +367,8 @@ int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
 int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
 int mlx5_set_trust_state(struct mlx5_core_dev *mdev, u8 trust_state);
 int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state);
+int mlx5_query_port_buffer_ownership(struct mlx5_core_dev *mdev,
+				     u8 *buffer_ownership);
 int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio);
 int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 549f1066d2a5..2d7adf7444ba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -968,6 +968,26 @@ int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state)
 	return err;
 }
 
+int mlx5_query_port_buffer_ownership(struct mlx5_core_dev *mdev,
+				     u8 *buffer_ownership)
+{
+	u32 out[MLX5_ST_SZ_DW(pfcc_reg)] = {};
+	int err;
+
+	if (!MLX5_CAP_PCAM_FEATURE(mdev, buffer_ownership)) {
+		*buffer_ownership = MLX5_BUF_OWNERSHIP_UNKNOWN;
+		return 0;
+	}
+
+	err = mlx5_query_pfcc_reg(mdev, out, sizeof(out));
+	if (err)
+		return err;
+
+	*buffer_ownership = MLX5_GET(pfcc_reg, out, buf_ownership);
+
+	return 0;
+}
+
 int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio)
 {
 	int sz = MLX5_ST_SZ_BYTES(qpdpm_reg);
-- 
2.34.1


