Return-Path: <linux-rdma+bounces-14145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C961DC20406
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1CF24EB9F6
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17301247DE1;
	Thu, 30 Oct 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qj/m1ppA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27E2459EA;
	Thu, 30 Oct 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831232; cv=fail; b=bjbz2jx+yObtO83UdeY+0e/acEx+sljPnySnKDy8Km1UnGnAYQ7dQsrgqok/HrBf+Jw6EsfF3jmTVceqKTVk54qDBr/BRbfTrWdkj0rfrTWoyqEr8iYAG9At7mSecB/ihds+Ru9FRyMSdILeHx9tMZTMle95wE0tbA6+8D2CATs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831232; c=relaxed/simple;
	bh=cI65svmiPbhrlfAlN1FuxXC5JzeWh53nSPZWXKOPmDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXLpKd23WYgbxP7y1aLH95+Nep8P2uzzirBy8MkKrNoxSVIZqMpGDG76DmSSy60svMCecP8dJLf3ds+CbHsLnpQ77G2EVfxS2iuHE5K46Lz9yQmJKmLvkQYTB9MiOcX+ZCK2ZuzpdE/AoMcBJvP9CxyBKmE+zmnZJ4FQg8dwY7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qj/m1ppA; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dj1hFZIRAwm1XKQuAJeQyjz4lFJOoM9aBdexu+5QDr5aBfvo5Kz53flzVEXbIRZPpuc8oHzrD4qaowD6SHURZkKT+4yrp78atUXDuW3F+SRo8y92EQg9wVKr3gSHuI+A48S2WeE3KR04lRj9wZhjQYkAlu8X84WwJp+tHWM2lywleAoegyM4RYrwRsUlLAbzsS9xH+ZCYi4m6VmD6R0uibgwGumd8QbMxSkfI3KNzOLCIljcr6VGWYQgM0emJIxgvd5t/3vIJ5Wg1Kbl3wLVVLwPz0Jo3jxVuO498McXF3iACKsXTYSSFudL/UA8ubaJqOB2g8ybbf+8JZ+vsdn3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcDCvB1miYQeZtAvJBRGgud6INIoNdP6kICvHHYRU1w=;
 b=E0q+miYIyWtO5KP6ekpnCR2rTe8NPlOz8t3dPXkBNkhgwQqLJjVegPYUc8m9y3YOxlu49vSre62KzGrboPd0qj+cNrD2hyO4hKjVYHU9Es9NMeqUHYbfxNK+trfGBcghExfC/0reS2pNIVuGt71ll8q3qwX43jtTcmkHGH1mE9aM9oxOjAkRkigvjkU5HvDnV4RjHS04r//d/Hh4JCH6UCqDXxJA/k4CJchuzAduqufDJ7fOLFS1u2BoRqlDknU194MBGis7FOTFwiuJR2Mpes5xNiatfmAi0AItfbI9wnDZPpseLkwvLWPfuCCV/q5IsGcvwFK3s29/tf7aqIpM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcDCvB1miYQeZtAvJBRGgud6INIoNdP6kICvHHYRU1w=;
 b=Qj/m1ppARcpbl+PbrWmZZDtvx58kgw/LY1UX2BbLKfZkMVElp347lUXH6KGi+Cre25JhrkE/yFuyII3HfK5Xn8DOtGIJD/+W9FDTFTilzRYvcdEz1Q9jExzsyJFuIQm4KtzSMakT7+XHFVny0ipUghwUlGnVCAbxsYosiJv5XOdgGLfJiSaNSxUgIzpqPmbFGS16GREEgrUm0yqZCeQ3XoLuxqBVBu4j9lOoY51CJpGN+IowHL5jYY5a4+DuDTrQ2EptInb13BNSi39vVdoZeNxv6qjwegrWuuVcfi7oGCapGGYyw2me2sXA9jv8nrMnxn5IDAGS1sp2/2fSHWIQ8g==
Received: from PH7P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::31)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 13:33:40 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:338:cafe::c5) by PH7P223CA0026.outlook.office365.com
 (2603:10b6:510:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 13:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:33:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 2/7] net/mlx5e: Use TIR API in mlx5e_modify_tirs_lb()
Date: Thu, 30 Oct 2025 15:32:34 +0200
Message-ID: <1761831159-1013140-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa6678d-3bd4-4658-7e80-08de17b8f00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fN8QOWb65N9hj3QWSF/rM6frwf7aONNwQHvWxQIABWSC4tTzHMnH7yskq3NN?=
 =?us-ascii?Q?M1HoRskNJeQabJQp/PWOoUJfL46BCY8R5DcM2n703r8ksWvwVNCGBj6u8DfV?=
 =?us-ascii?Q?8OWI53Iny6lClvqWEt2n0qDB/g6aL/W8SPveiZGuqei6/ds5ziZ6yo7p/9n7?=
 =?us-ascii?Q?IlsEg+TCpVLx5j42dLqYXbVH25xLQh5mlWWH/V4AEz0EI+VQhqV3NEts52xd?=
 =?us-ascii?Q?xwwxXNn0Oly4FlvvXMKnHyBVfa8TEbzo4kDaf9VxdlfXcEBMD0kzxA+0LbD+?=
 =?us-ascii?Q?XS+t7AHrSSdVrto2DPBW2Qft/FXKv2VXnyJuAJvDEo5oy1KPVuSu1N6Wa9Uz?=
 =?us-ascii?Q?fAeWAsr87/VsjG4dOEu077w0UXZ9f8YJ7tjrAcfYJfmq1iZCFJWfZpESVwyE?=
 =?us-ascii?Q?0RNP80hhw/6iHbjqQun3D+VHY44nFIErEdQuxCk2qEiaMd04dYjoSf1OX/b4?=
 =?us-ascii?Q?O5fleq4g1ew0Plrc/GOcfZn3T3z/DA8hB9JaS6f+JX6kPEWEqpQ2n9Rg3oyk?=
 =?us-ascii?Q?ZEJQDNZJx/xnHYR8hOxCCc7EfSqO3AYJCevI18KV4TLmK52cwkzPz3VkLar6?=
 =?us-ascii?Q?IhrIuLNOLQlPsb3BdRWlIsTxl4yM7GatS6+SNf5V0YkEqEzcw6lYuc+q+oxh?=
 =?us-ascii?Q?P5DvLBmDDjDSZwX7DiXg1mppoAq6CLZ1EnPQPweKSU3DMWzvZSNp6jGR9PG+?=
 =?us-ascii?Q?jEJEQW8wTZgQOZR7dUCSTFjmyuMvNfJitBccLn/cXGWNJxxwFZLRlReI2BuA?=
 =?us-ascii?Q?ABu0GbTGH60pTMZEjL/FVlfRhHVLaiTbZSOfnEhTE3mPm8e5y4qVUdYA4qq6?=
 =?us-ascii?Q?ZsQXgeT7oll60prZCyrBFAYaJdElIpiwmTTwDgvUr0aRVkE4wcdzRzyy3b4r?=
 =?us-ascii?Q?1Zv9iYDJurxzJFNVObNwCJ/bLyyRRt4Ts2JpM7Iwfj+xLEC/nXFIRa0lrKH6?=
 =?us-ascii?Q?5RTqzzZRFkysyo3yd4AL+V4VQaLl4qXcYH3pAjP8p0gk4q9CnMIUHOG0c2bx?=
 =?us-ascii?Q?buStnow15FIY4/kWo+zAhNswBIXLd1kS+n8wtdYkjNc+sPxZKntmcwQ6ifhi?=
 =?us-ascii?Q?zVSRhrsj/ah6gHzV6ROTGM6G9/OgUiTPNUyjZuGI9F0x7wj/g+PDbuHI+gV+?=
 =?us-ascii?Q?7oOVBSXr6vVMpGqZh4rQw2/F1zTX4M6/kJWZH9+///nU8KsGlelEl9fnaSbL?=
 =?us-ascii?Q?QwgFH8q5z7/YAsCQ6AainpjiNPuCtGfLJXsWeB9/lJ+1U/3j2VODzLg1gAXD?=
 =?us-ascii?Q?t+zUMts9y2ReMane8tA8Ra9gLBzhMFjWiffHURH4RVlKaGcmEJ/HrEgx4lf8?=
 =?us-ascii?Q?q3WPepUcPtBxYzoUplesUPYpPSf+vi9qgSEqajAxyoz7pEiY7EjU/O93Vc4c?=
 =?us-ascii?Q?CKxNj7aEoAPsNbuzf1Zj2jQmz/5JeTbTyp+oXBuwMh9QINjulzw7bPwZmNP/?=
 =?us-ascii?Q?Iy1qNqxTgI9qneU1osW8sDroOI4sGm/Pv9MO3PhdzcZRnHxK8F4QOg03kzYT?=
 =?us-ascii?Q?+MLYE0Qs/PI36Ja2tbg0Z2YAwnDaEc2e/YBDmSY3bjqvf/ejqSNLgO/RQ4V0?=
 =?us-ascii?Q?Ma1TZ13bYyd+3kVRpUM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:40.1109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa6678d-3bd4-4658-7e80-08de17b8f00f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

Extend the TIR API and use it in mlx5e_modify_tirs_lb() instead of the
explicit modify_tir code.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  | 29 +++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |  3 ++
 .../ethernet/mellanox/mlx5/core/en_common.c   | 41 +++++++------------
 3 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index 19499072f67f..0b55e77f19c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -146,6 +146,31 @@ void mlx5e_tir_builder_build_direct(struct mlx5e_tir_builder *builder)
 	MLX5_SET(tirc, tirc, rx_hash_fn, MLX5_RX_HASH_FN_INVERTED_XOR8);
 }
 
+static void mlx5e_tir_context_self_lb_block(void *tirc, bool enable_uc_lb,
+					    bool enable_mc_lb)
+{
+	u8 lb_flags = 0;
+
+	if (enable_uc_lb)
+		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
+	if (enable_mc_lb)
+		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
+
+	MLX5_SET(tirc, tirc, self_lb_block, lb_flags);
+}
+
+void mlx5e_tir_builder_build_self_lb_block(struct mlx5e_tir_builder *builder,
+					   bool enable_uc_lb,
+					   bool enable_mc_lb)
+{
+	void *tirc = mlx5e_tir_builder_get_tirc(builder);
+
+	if (builder->modify)
+		MLX5_SET(modify_tir_in, builder->in, bitmask.self_lb_en, 1);
+
+	mlx5e_tir_context_self_lb_block(tirc, enable_uc_lb, enable_mc_lb);
+}
+
 void mlx5e_tir_builder_build_tls(struct mlx5e_tir_builder *builder)
 {
 	void *tirc = mlx5e_tir_builder_get_tirc(builder);
@@ -153,9 +178,7 @@ void mlx5e_tir_builder_build_tls(struct mlx5e_tir_builder *builder)
 	WARN_ON(builder->modify);
 
 	MLX5_SET(tirc, tirc, tls_en, 1);
-	MLX5_SET(tirc, tirc, self_lb_block,
-		 MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST |
-		 MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST);
+	mlx5e_tir_context_self_lb_block(tirc, true, true);
 }
 
 int mlx5e_tir_init(struct mlx5e_tir *tir, struct mlx5e_tir_builder *builder,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
index e8df3aaf6562..958eeb959a19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
@@ -35,6 +35,9 @@ void mlx5e_tir_builder_build_rss(struct mlx5e_tir_builder *builder,
 				 const struct mlx5e_rss_params_traffic_type *rss_tt,
 				 bool inner);
 void mlx5e_tir_builder_build_direct(struct mlx5e_tir_builder *builder);
+void mlx5e_tir_builder_build_self_lb_block(struct mlx5e_tir_builder *builder,
+					   bool enable_uc_lb,
+					   bool enable_mc_lb);
 void mlx5e_tir_builder_build_tls(struct mlx5e_tir_builder *builder);
 
 struct mlx5_core_dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 376a018b2db1..022a0cf7063c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -250,44 +250,31 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 			 bool enable_mc_lb)
 {
+	struct mlx5e_tir_builder *builder;
 	struct mlx5e_tir *tir;
-	u8 lb_flags = 0;
-	int err  = 0;
-	u32 tirn = 0;
-	int inlen;
-	void *in;
+	int err = 0;
 
-	inlen = MLX5_ST_SZ_BYTES(modify_tir_in);
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in)
+	builder = mlx5e_tir_builder_alloc(true);
+	if (!builder)
 		return -ENOMEM;
 
-	if (enable_uc_lb)
-		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
-
-	if (enable_mc_lb)
-		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
-
-	if (lb_flags)
-		MLX5_SET(modify_tir_in, in, ctx.self_lb_block, lb_flags);
-
-	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
+	mlx5e_tir_builder_build_self_lb_block(builder, enable_uc_lb,
+					      enable_mc_lb);
 
 	mutex_lock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
-		tirn = tir->tirn;
-		err = mlx5_core_modify_tir(mdev, tirn, in);
-		if (err)
+		err = mlx5e_tir_modify(tir, builder);
+		if (err) {
+			mlx5_core_err(mdev,
+				      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
+				      mlx5e_tir_get_tirn(tir),
+				      enable_uc_lb, enable_mc_lb, err);
 			break;
+		}
 	}
 	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 
-	kvfree(in);
-	if (err)
-		mlx5_core_err(mdev,
-			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
-			      tirn,
-			      enable_uc_lb, enable_mc_lb, err);
+	mlx5e_tir_builder_free(builder);
 
 	return err;
 }
-- 
2.31.1


