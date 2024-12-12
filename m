Return-Path: <linux-rdma+bounces-6497-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE52F9EFF22
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000EA163F92
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71681DE884;
	Thu, 12 Dec 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qHDyzhUU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F6E1D6DC8;
	Thu, 12 Dec 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041748; cv=fail; b=OKPUvIrVHAbLPm6JsQO+zactmO4eIRpedecQQnZZCqKCy4qOn5i4MUEHaqrpRPuQj5leYgfkkmzfdhfCoxPWV2gwmiBXGyplEt5EoG0Een3F/pjku4NyyiY7elZGGHFPxMPo9aDn1m4DD7jUyyEw+8MjA0/hGJ9hIVd+9/K08uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041748; c=relaxed/simple;
	bh=QCSEl6bliieREXUr8/JO++VkxisTk0SeosFxUyuPj3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5xL/XJqjE2Jj8bdKsZsCyb8G4hQ+xreVgquK2k+l3oNaeY40+l8UK+NQPKRUX9b6FwX3gz6jvXomuM7nKnfy3ZRrz+V+ApeOGb7N57daMCJiu0bjjMiS1Vo8GLwJ/1DjVdWOHUov/RYwhd5O0ZpZT3LOwLFo21IW21M9p3MaoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qHDyzhUU; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVDQdkH+OXMvn9IDLj9sI6DfUhn7zvNVGOwHDdWBuRsEJF7gfsbX6nj+7Za8fGqDbWdmb5xVp9r3s7Wu0RKfefZfEavZzN2CppyQWmD6ZqUv2bWWS6aZ15GKPuvPhnsVQj4rTAi1DFmHhBKFBpFAxtLRH3NwCO7JohojjLpnVObz0/leorZwLfVbusDLNUTpJWNXpD/KydpsbOJ51mMVxWwmxayjYelJV/Xj3I7GmBzstXhTSadItQxZ92/2pYi5C8E2w4jdFDfWfWRQsOHCN6/0sR8FakUltHRLQHLbsbp2Kfp6CgVrSVhcYSyjM6ubsAXQAlJHQ1x1MXv1KniDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmm9CWkmGIV+pxRhdQaKECJunEX5SFomq8AeB3ctlYE=;
 b=zFONcUmeIRNOjWouGbOfWXyOFLIXXW71sC4Jpzq0w+G9UBsOZ+V5y5r6ssj3/CiGvazCOFFBO3LwMAK67yfHmIwGMYB5OT7ht8t4gf77krAbSS4zlmnuVuTllWmNTjwf2OLK3jwDtIlMZ5/KMmwsyk+CpziHA7/CDk9EqwmBPOrWqnV0XUVNfnCZfBFL76PQ/aacgrpDQ7NRrsCvKM8Vpv6dVBwPNYtpBLYzWe9aG0tVcWQITWWvHwKR7iKTkNX45JndjqCndgrTmIZkqXoTFQXGXhTpeJoG/yHzzM4qGkcTLf5E5+4LWjZAahY15FSGLsdoqfLJY9dt9B+At2a+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmm9CWkmGIV+pxRhdQaKECJunEX5SFomq8AeB3ctlYE=;
 b=qHDyzhUUS5AKY+19kMASBV8TGLjDMwaUT7L/3RVi0xsH/KvNoZBdQVBPQEJ0Ccgp6qe2DrPSsKHv5HYQFsmv1cxfe9b6EO4B/05OrKZH+JSs2wIzz0TSTO7AZ/TedGQPJ2eX863+EV7O3pg0ZwCBmct1y+cI3JkybfibtNM6sO5I1w5A5NQqIKDxX7X2jEgdUDjGS03QrCZPto0GKj61bwCcexc76lDPjTJTZ6l9WB0/L5o2qFui4/bqsguzPjk/PUylG9LsMBADRRaAEYZle2Nlh1qSB/nXfXXMfuM3KT5+GZU2pkZYXFsHXYm0tQlzFx4Fy3q+jZihHmU47IHViA==
Received: from MN2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:c0::38)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 22:15:37 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::fa) by MN2PR05CA0025.outlook.office365.com
 (2603:10b6:208:c0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:15:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:15:13 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:15:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:15:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Itamar Gozlan
	<igozlan@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/10] net/mlx5: DR, add support for ConnectX-8 steering
Date: Fri, 13 Dec 2024 00:13:27 +0200
Message-ID: <20241212221329.961628-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9f8781-eaef-46ad-5f7f-08dd1afa8108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvyalVB/3n3vquAmTpkSWx4jgJtDP1sNuS33e8IkBKDKcQwcQvmbS1cKPWbJ?=
 =?us-ascii?Q?tFiwoDJEeUaMEHt0eNTKfGzX5NSKRcp/6Srbx1bjBu4A5hXuMnkTjTTtuO6R?=
 =?us-ascii?Q?EyykT/RdMN7RsNz9n74jIS7LwlGD4EfF2z0YOWrjhTy1HhL02AO0X5pY6oHH?=
 =?us-ascii?Q?F6OhMbFzKypqb/Z6tPPRyrPB78LNH9sJs51tuKCjSJlAHBGoC2Uwx3vVPE/b?=
 =?us-ascii?Q?exDtfiKni2zfIemYjBl1bgrNVu6/i3lUFUgwVpcxUveWG1y26VUlHds63fdl?=
 =?us-ascii?Q?Cli0eQZR+Ic+xBtXGLT0YzVSxvPFK7e3l5WeKvURJaQQZhKybHaBssVuvFg7?=
 =?us-ascii?Q?hEkBBiCBf3+uPUzlnMyIKKyhIibee3DZgn4NkxeMpbA+5qOg1+JKHFx2nqkb?=
 =?us-ascii?Q?wi0JUGetYeY5RUwXUpcUe9chVSZU0MHRr0BChj9yQDvAYF7shaxjEIZRyse6?=
 =?us-ascii?Q?yKKF76b6WWbzdRrjYnP0Wbrc8wmiIGHRxCxByttypgzORT3kUOFTHgHzjaZe?=
 =?us-ascii?Q?wFBzuk5SbQLMx5D774r5B1BH2e4VUgVtngMvDoCGHCr0gHQEcG5imQWnGm8t?=
 =?us-ascii?Q?pbyomYS4MqFNM/4myVFrIR84qRXz5csRYswkY5IU/KzwopQ2sIubjGU8jjDc?=
 =?us-ascii?Q?C04c9UwHP9VhEkhl3w40E//Y+9Dxw5emrtAXcW9BWA8H6GIXPRKgreG198Sx?=
 =?us-ascii?Q?8hPxIr7E0Jv767824W098CnRAxyynxZ2UvPXeogzVw0tsQNQhji3UbH2CPsn?=
 =?us-ascii?Q?SKxaL5dyIlST3br78HPQ+eNcdCStlhzB7+OppGVFhzY1YF7X1DKpqORG4l04?=
 =?us-ascii?Q?V0rC8lkA/66ykbWj/I12Cm1592piOV1U1CcSQB9zBLXfZPdkmDfFC2Ai3aqk?=
 =?us-ascii?Q?amjSeCoT2ANW9EfWIOYPXW+OrgWXGnnzjk9E3faIReYqdfoJXc3zB4w7q6l1?=
 =?us-ascii?Q?N/EHkZFUMjpBOgLnALvFYrX4kaIfcHE4YccdJtGJVb4iFQ4Y3FkGvEP+uGnS?=
 =?us-ascii?Q?wR/WyHMCj9GMjWSYKlWiJCaY1Ae+mWWAp82o6tAazTYxdswGMR88rKf2coW4?=
 =?us-ascii?Q?Ucou2RBhYuROLAs0mfe+jt+Xtdcisf8f/R5HOz301X24pFv7nav6koNODEIo?=
 =?us-ascii?Q?UeJ2RsFAhTpDczFvdsrhgjka+JArdPdmwGMD1l4DCmdwf4/JYVc3XXR+g1/T?=
 =?us-ascii?Q?Dgq/AZQwj+8Jx1IhqLyV9qzS8SO6AxXLAOcO5JA3zOYobPKY64ZfJTFm9q+Z?=
 =?us-ascii?Q?jxIDq56pBPC5WXgp6FVlinSMx6j2dt2E9siWciEih4IcfE7Y6bJvfzFHljKG?=
 =?us-ascii?Q?8uBDqC3h+5SJiy4oO/3aYQsFvVsVBQbnOm6OX+0yVUs8iBFS874rlbnwfU8Z?=
 =?us-ascii?Q?egxbJTeSZaKKaHWurkMh+9liPvdr6AWPe9ZXXGuVoyCSFOo9RmAEtox/02xV?=
 =?us-ascii?Q?3iod0sA6CVS2QJsBLWulEIGNeCj8QTax?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:36.3559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f8781-eaef-46ad-5f7f-08dd1afa8108
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

From: Itamar Gozlan <igozlan@nvidia.com>

Add support for a new steering format version that is implemented by
ConnectX-8.
Except for several differences, the STEv3 is identical to STEv2, so
for most callbacks STEv3 context struct will call STEv2 functions.

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   2 +
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |   1 +
 .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 ++++++++++++++++++
 .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++++
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
 7 files changed, 267 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index be3d0876c521..f9db8b8374fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -123,6 +123,7 @@ mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
 					steering/sws/dr_ste_v0.o \
 					steering/sws/dr_ste_v1.o \
 					steering/sws/dr_ste_v2.o \
+					steering/sws/dr_ste_v3.o \
 					steering/sws/dr_cmd.o \
 					steering/sws/dr_fw.o \
 					steering/sws/dr_action.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..bd361ba6658c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -8,7 +8,7 @@
 #define DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, dmn_type)	\
 	((dmn)->info.caps.dmn_type##_sw_owner ||	\
 	 ((dmn)->info.caps.dmn_type##_sw_owner_v2 &&	\
-	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_7))
+	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_8))
 
 bool mlx5dr_domain_is_support_ptrn_arg(struct mlx5dr_domain *dmn)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
index 01ba8eae2983..c8b8ff80c7c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
@@ -1458,6 +1458,8 @@ struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx(u8 version)
 		return mlx5dr_ste_get_ctx_v1();
 	else if (version == MLX5_STEERING_FORMAT_CONNECTX_7)
 		return mlx5dr_ste_get_ctx_v2();
+	else if (version == MLX5_STEERING_FORMAT_CONNECTX_8)
+		return mlx5dr_ste_get_ctx_v3();
 
 	return NULL;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
index b6ec8d30d990..5f409dc30aca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
@@ -217,5 +217,6 @@ struct mlx5dr_ste_ctx {
 struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v0(void);
 struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v1(void);
 struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v2(void);
+struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v3(void);
 
 #endif  /* _DR_STE_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
new file mode 100644
index 000000000000..cc60ce1d274e
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include "dr_ste_v1.h"
+#include "dr_ste_v2.h"
+
+static void dr_ste_v3_set_encap(u8 *hw_ste_p, u8 *d_action,
+				u32 reformat_id, int size)
+{
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, action_id,
+		 DR_STE_V1_ACTION_ID_INSERT_POINTER);
+	/* The hardware expects here size in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, size, size / 2);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, pointer, reformat_id);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, d_action, attributes,
+		 DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP);
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_push_vlan(u8 *ste, u8 *d_action,
+				    u32 vlan_hdr)
+{
+	MLX5_SET(ste_double_action_insert_with_inline_v3, d_action, action_id,
+		 DR_STE_V1_ACTION_ID_INSERT_INLINE);
+	/* The hardware expects here offset to vlan header in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_inline_v3, d_action, start_offset,
+		 HDR_LEN_L2_MACS >> 1);
+	MLX5_SET(ste_double_action_insert_with_inline_v3, d_action, inline_data, vlan_hdr);
+	dr_ste_v1_set_reparse(ste);
+}
+
+static void dr_ste_v3_set_pop_vlan(u8 *hw_ste_p, u8 *s_action,
+				   u8 vlans_num)
+{
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 action_id, DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 start_anchor, DR_STE_HEADER_ANCHOR_1ST_VLAN);
+	/* The hardware expects here size in words (2 byte) */
+	MLX5_SET(ste_single_action_remove_header_size_v3, s_action,
+		 remove_size, (HDR_LEN_L2_VLAN >> 1) * vlans_num);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_encap_l3(u8 *hw_ste_p,
+				   u8 *frst_s_action,
+				   u8 *scnd_d_action,
+				   u32 reformat_id,
+				   int size)
+{
+	/* Remove L2 headers */
+	MLX5_SET(ste_single_action_remove_header_v3, frst_s_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
+	MLX5_SET(ste_single_action_remove_header_v3, frst_s_action, end_anchor,
+		 DR_STE_HEADER_ANCHOR_IPV6_IPV4);
+
+	/* Encapsulate with given reformat ID */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, action_id,
+		 DR_STE_V1_ACTION_ID_INSERT_POINTER);
+	/* The hardware expects here size in words (2 byte) */
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, size, size / 2);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, pointer, reformat_id);
+	MLX5_SET(ste_double_action_insert_with_ptr_v3, scnd_d_action, attributes,
+		 DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static void dr_ste_v3_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
+{
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, decap, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, vni_to_cqe, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, s_action, end_anchor,
+		 DR_STE_HEADER_ANCHOR_INNER_MAC);
+
+	dr_ste_v1_set_reparse(hw_ste_p);
+}
+
+static int
+dr_ste_v3_set_action_decap_l3_list(void *data, u32 data_sz,
+				   u8 *hw_action, u32 hw_action_sz,
+				   uint16_t *used_hw_action_num)
+{
+	u8 padded_data[DR_STE_L2_HDR_MAX_SZ] = {};
+	void *data_ptr = padded_data;
+	u16 used_actions = 0;
+	u32 inline_data_sz;
+	u32 i;
+
+	if (hw_action_sz / DR_STE_ACTION_DOUBLE_SZ < DR_STE_DECAP_L3_ACTION_NUM)
+		return -EINVAL;
+
+	inline_data_sz =
+		MLX5_FLD_SZ_BYTES(ste_double_action_insert_with_inline_v3, inline_data);
+
+	/* Add an alignment padding  */
+	memcpy(padded_data + data_sz % inline_data_sz, data, data_sz);
+
+	/* Remove L2L3 outer headers */
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, decap, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, vni_to_cqe, 1);
+	MLX5_SET(ste_single_action_remove_header_v3, hw_action, end_anchor,
+		 DR_STE_HEADER_ANCHOR_INNER_IPV6_IPV4);
+	hw_action += DR_STE_ACTION_DOUBLE_SZ;
+	used_actions++; /* Remove and NOP are a single double action */
+
+	/* Point to the last dword of the header */
+	data_ptr += (data_sz / inline_data_sz) * inline_data_sz;
+
+	/* Add the new header using inline action 4Byte at a time, the header
+	 * is added in reversed order to the beginning of the packet to avoid
+	 * incorrect parsing by the HW. Since header is 14B or 18B an extra
+	 * two bytes are padded and later removed.
+	 */
+	for (i = 0; i < data_sz / inline_data_sz + 1; i++) {
+		void *addr_inline;
+
+		MLX5_SET(ste_double_action_insert_with_inline_v3, hw_action, action_id,
+			 DR_STE_V1_ACTION_ID_INSERT_INLINE);
+		/* The hardware expects here offset to words (2 bytes) */
+		MLX5_SET(ste_double_action_insert_with_inline_v3, hw_action, start_offset, 0);
+
+		/* Copy bytes one by one to avoid endianness problem */
+		addr_inline = MLX5_ADDR_OF(ste_double_action_insert_with_inline_v3,
+					   hw_action, inline_data);
+		memcpy(addr_inline, data_ptr - i * inline_data_sz, inline_data_sz);
+		hw_action += DR_STE_ACTION_DOUBLE_SZ;
+		used_actions++;
+	}
+
+	/* Remove first 2 extra bytes */
+	MLX5_SET(ste_single_action_remove_header_size_v3, hw_action, action_id,
+		 DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
+	MLX5_SET(ste_single_action_remove_header_size_v3, hw_action, start_offset, 0);
+	/* The hardware expects here size in words (2 bytes) */
+	MLX5_SET(ste_single_action_remove_header_size_v3, hw_action, remove_size, 1);
+	used_actions++;
+
+	*used_hw_action_num = used_actions;
+
+	return 0;
+}
+
+static struct mlx5dr_ste_ctx ste_ctx_v3 = {
+	/* Builders */
+	.build_eth_l2_src_dst_init	= &dr_ste_v1_build_eth_l2_src_dst_init,
+	.build_eth_l3_ipv6_src_init	= &dr_ste_v1_build_eth_l3_ipv6_src_init,
+	.build_eth_l3_ipv6_dst_init	= &dr_ste_v1_build_eth_l3_ipv6_dst_init,
+	.build_eth_l3_ipv4_5_tuple_init	= &dr_ste_v1_build_eth_l3_ipv4_5_tuple_init,
+	.build_eth_l2_src_init		= &dr_ste_v1_build_eth_l2_src_init,
+	.build_eth_l2_dst_init		= &dr_ste_v1_build_eth_l2_dst_init,
+	.build_eth_l2_tnl_init		= &dr_ste_v1_build_eth_l2_tnl_init,
+	.build_eth_l3_ipv4_misc_init	= &dr_ste_v1_build_eth_l3_ipv4_misc_init,
+	.build_eth_ipv6_l3_l4_init	= &dr_ste_v1_build_eth_ipv6_l3_l4_init,
+	.build_mpls_init		= &dr_ste_v1_build_mpls_init,
+	.build_tnl_gre_init		= &dr_ste_v1_build_tnl_gre_init,
+	.build_tnl_mpls_init		= &dr_ste_v1_build_tnl_mpls_init,
+	.build_tnl_mpls_over_udp_init	= &dr_ste_v1_build_tnl_mpls_over_udp_init,
+	.build_tnl_mpls_over_gre_init	= &dr_ste_v1_build_tnl_mpls_over_gre_init,
+	.build_icmp_init		= &dr_ste_v1_build_icmp_init,
+	.build_general_purpose_init	= &dr_ste_v1_build_general_purpose_init,
+	.build_eth_l4_misc_init		= &dr_ste_v1_build_eth_l4_misc_init,
+	.build_tnl_vxlan_gpe_init	= &dr_ste_v1_build_flex_parser_tnl_vxlan_gpe_init,
+	.build_tnl_geneve_init		= &dr_ste_v1_build_flex_parser_tnl_geneve_init,
+	.build_tnl_geneve_tlv_opt_init	= &dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_init,
+	.build_tnl_geneve_tlv_opt_exist_init =
+				  &dr_ste_v1_build_flex_parser_tnl_geneve_tlv_opt_exist_init,
+	.build_register_0_init		= &dr_ste_v1_build_register_0_init,
+	.build_register_1_init		= &dr_ste_v1_build_register_1_init,
+	.build_src_gvmi_qpn_init	= &dr_ste_v1_build_src_gvmi_qpn_init,
+	.build_flex_parser_0_init	= &dr_ste_v1_build_flex_parser_0_init,
+	.build_flex_parser_1_init	= &dr_ste_v1_build_flex_parser_1_init,
+	.build_tnl_gtpu_init		= &dr_ste_v1_build_flex_parser_tnl_gtpu_init,
+	.build_tnl_header_0_1_init	= &dr_ste_v1_build_tnl_header_0_1_init,
+	.build_tnl_gtpu_flex_parser_0_init = &dr_ste_v1_build_tnl_gtpu_flex_parser_0_init,
+	.build_tnl_gtpu_flex_parser_1_init = &dr_ste_v1_build_tnl_gtpu_flex_parser_1_init,
+
+	/* Getters and Setters */
+	.ste_init			= &dr_ste_v1_init,
+	.set_next_lu_type		= &dr_ste_v1_set_next_lu_type,
+	.get_next_lu_type		= &dr_ste_v1_get_next_lu_type,
+	.is_miss_addr_set		= &dr_ste_v1_is_miss_addr_set,
+	.set_miss_addr			= &dr_ste_v1_set_miss_addr,
+	.get_miss_addr			= &dr_ste_v1_get_miss_addr,
+	.set_hit_addr			= &dr_ste_v1_set_hit_addr,
+	.set_byte_mask			= &dr_ste_v1_set_byte_mask,
+	.get_byte_mask			= &dr_ste_v1_get_byte_mask,
+
+	/* Actions */
+	.actions_caps			= DR_STE_CTX_ACTION_CAP_TX_POP |
+					  DR_STE_CTX_ACTION_CAP_RX_PUSH |
+					  DR_STE_CTX_ACTION_CAP_RX_ENCAP,
+	.set_actions_rx			= &dr_ste_v1_set_actions_rx,
+	.set_actions_tx			= &dr_ste_v1_set_actions_tx,
+	.modify_field_arr_sz		= ARRAY_SIZE(dr_ste_v2_action_modify_field_arr),
+	.modify_field_arr		= dr_ste_v2_action_modify_field_arr,
+	.set_action_set			= &dr_ste_v1_set_action_set,
+	.set_action_add			= &dr_ste_v1_set_action_add,
+	.set_action_copy		= &dr_ste_v1_set_action_copy,
+	.set_action_decap_l3_list	= &dr_ste_v3_set_action_decap_l3_list,
+	.alloc_modify_hdr_chunk		= &dr_ste_v1_alloc_modify_hdr_ptrn_arg,
+	.dealloc_modify_hdr_chunk	= &dr_ste_v1_free_modify_hdr_ptrn_arg,
+	/* Actions bit set */
+	.set_encap			= &dr_ste_v3_set_encap,
+	.set_push_vlan			= &dr_ste_v3_set_push_vlan,
+	.set_pop_vlan			= &dr_ste_v3_set_pop_vlan,
+	.set_rx_decap			= &dr_ste_v3_set_rx_decap,
+	.set_encap_l3			= &dr_ste_v3_set_encap_l3,
+	/* Send */
+	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
+};
+
+struct mlx5dr_ste_ctx *mlx5dr_ste_get_ctx_v3(void)
+{
+	return &ste_ctx_v3;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
index fb078fa0f0cc..898c3618ff26 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5_ifc_dr.h
@@ -600,4 +600,44 @@ struct mlx5_ifc_ste_double_action_aso_v1_bits {
 	};
 };
 
+struct mlx5_ifc_ste_single_action_remove_header_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         end_anchor[0x7];
+	u8         reserved_at_16[0x1];
+	u8         outer_l4_remove[0x1];
+	u8         reserved_at_18[0x4];
+	u8         decap[0x1];
+	u8         vni_to_cqe[0x1];
+	u8         qos_profile[0x2];
+};
+
+struct mlx5_ifc_ste_single_action_remove_header_size_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         start_offset[0x8];
+	u8         outer_l4_remove[0x1];
+	u8         reserved_at_18[0x2];
+	u8         remove_size[0x6];
+};
+
+struct mlx5_ifc_ste_double_action_insert_with_inline_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         start_offset[0x8];
+	u8         reserved_at_17[0x9];
+
+	u8         inline_data[0x20];
+};
+
+struct mlx5_ifc_ste_double_action_insert_with_ptr_v3_bits {
+	u8         action_id[0x8];
+	u8         start_anchor[0x7];
+	u8         start_offset[0x8];
+	u8         size[0x6];
+	u8         attributes[0x3];
+
+	u8         pointer[0x20];
+};
+
 #endif /* MLX5_IFC_DR_H */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
index 3ac7dc67509f..0bb3724c10c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/mlx5dr.h
@@ -160,7 +160,7 @@ mlx5dr_is_supported(struct mlx5_core_dev *dev)
 	       (MLX5_CAP_ESW_FLOWTABLE_FDB(dev, sw_owner) ||
 		(MLX5_CAP_ESW_FLOWTABLE_FDB(dev, sw_owner_v2) &&
 		 (MLX5_CAP_GEN(dev, steering_format_version) <=
-		  MLX5_STEERING_FORMAT_CONNECTX_7)));
+		  MLX5_STEERING_FORMAT_CONNECTX_8)));
 }
 
 /* buddy functions & structure */
-- 
2.44.0


