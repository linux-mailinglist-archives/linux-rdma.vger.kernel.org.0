Return-Path: <linux-rdma+bounces-6353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3699EA0E3
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD2F1886CD0
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E896019D092;
	Mon,  9 Dec 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XH/1++rv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF319CCEA;
	Mon,  9 Dec 2024 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778799; cv=fail; b=bK61Hjt7uCEUp9Nf+mAKwEv8Ixi1Y6HsLdB/M1SON2ylEFnew0GymcA0nfDRHW5/iF2YsZAtatg4N0T7mxxsGQcgByQXfHJBrTTEhc+/2rXXjLtY8LW2Yqca8KBp6z1/5pm/EDDRnCXfsBJK1x+nMFnaqOjoTB7emey1m6MS7+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778799; c=relaxed/simple;
	bh=QCSEl6bliieREXUr8/JO++VkxisTk0SeosFxUyuPj3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTr3Ch4MT/6e/f/bO+JYoFI5w1VksW4yt53yHT9TJoZEfT9pZze6kHnLKXtS9WU+PQpXmzBGVGHD6N2dJAZQEBV0yTquOp25BSxMEyjN+zdvnUrEbOikB7Iyj+EOpiUe4lItrATdZdv66iJ9s2F6XNjFPy0p0pF3qGFcl0NlD54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XH/1++rv; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAKSrUqrkGf/NOvnw1mkQxOIYA9tifSsonyHWaPqGaCoD8vkI5UqDRHAzhWM/FfqqCsxWunrFC8y7kliu7oeo2nXpVNYaKb0cYZtSjaNqihnxVCj3LPGUu+A4TV7tzRDPzpoobLxEps9fCFhyPae66TFLJXCgSy+mdO62K07LOLR8UdeUeNt00awi7z5O9jmZqaAPR8aDU4BHW+BJSlQhYg+PIOJDQTgwGjka9Bplgrbb6Bl4C9UXedrm9ErlT3iWMXyx8IGP/xKNBUvL58ZMbayMTyonB4waMX/3/TuUQq7XNj885Umre2+csztzjIyV2w+CE0YK6LD/irsl/E/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmm9CWkmGIV+pxRhdQaKECJunEX5SFomq8AeB3ctlYE=;
 b=fm3D9O7rxS57lnuDc7Szg71R+A7lFlDUpmBNum7uwGJVZcfy0C6Fwkt6C4XNzMAu5+3kirOgTVcR+mdlfEDpnNRr/4yDxC8MJQlaCse/8XwuCTO/j3X4nrgWJfXhvFrQIWoTxdP2JIlBLGV7btqGM7yKhaBRWZ4nsxHfAA4Ngw9sc9nHPnqYH4u8rjpsSvHaewR+o08mlZBGkP9yyzwcPZm+NmsaQTPbpIFwDZBKSIMFxvkxPAby/ACSxxoFidZOQB3czTnNv/3zxqL7CGPy5b294InHF88ZD3c2i4qPtEIf3xDnUNtJ8+JtH3g005v3AXAosjPGOZ4UGLqnOtV1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmm9CWkmGIV+pxRhdQaKECJunEX5SFomq8AeB3ctlYE=;
 b=XH/1++rv8MCl0SMRbIRsYGN/KNVGnGhXHH9o9fFev1HHdIOHhZZikIEXbJywpbA3AmhP9PLJJ6GI7tjzU8Lc14E3rpk3pdajayHfhgoET3SE/XVkO00GwJniluyAd8B9K0Ae3C84Es61uvx0c3R0TxiPORX9uahZQOJJAlpn5U20Z6BnTY5fvIk30uxmUdeohiA5HAVm+2QOTeJFvJZPjOuAHVZfxguSWGW0wuZzyOkVAi6B1ViFTSXJnxzyr4SJYsFsNgmQNc4AoK3a0ILnJxZyIEVdKhwVZEZnlA8jA3MlPcN+abkH4xjtH9nSkQbMAKIob1L5PlmbFxE9oqukdA==
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:13:11 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::fa) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 21:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 21:13:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 13:12:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 13:12:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 13:12:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Itamar Gozlan
	<igozlan@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V6 2/7] net/mlx5: DR, add support for ConnectX-8 steering
Date: Mon, 9 Dec 2024 23:09:45 +0200
Message-ID: <20241209210950.290129-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241209210950.290129-1-tariqt@nvidia.com>
References: <20241209210950.290129-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e1c164-c22a-4eac-a4d1-08dd18964950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H082yRZ5SPTjKNvTPMCXu7JRvkEXIyObZXwqL2hs6ARnldszyqRAGniMkHUg?=
 =?us-ascii?Q?clj0HcXAQ5X+HtSTJkPBE1kwM0Jd3MN3zx8VBzdhIGAaWjn6t25I7I+XBiDS?=
 =?us-ascii?Q?52uBMfSvWsfvOyw3IX8qBlcgJWBu3XnU3nDsH2mxktw6Udgxe0B6zouewsQ5?=
 =?us-ascii?Q?wCvEpHMgDyJB35OMsicKEj1B05LHcqHSbgJQWuR4b/fefAWREvt6TFcp/Y9A?=
 =?us-ascii?Q?d9bLAJ21xHogpjKYmk41Dij9jLK0WidlAqH4gUAWbgb2WddmrrASFgKkueyP?=
 =?us-ascii?Q?Yofn5CRrhbJ1UixL/zGzFNgkLVVULJW6SnNVTTIiWRLJolmrVgvhb394DNRt?=
 =?us-ascii?Q?ZNzKCWTQEaFMXtfHm4tiEcxSTmC/S2o7GaynGyN/dSPxKu8z3up2Chea49V4?=
 =?us-ascii?Q?rcf43ecQVwviGm9BOUNfyzB+18vwvAMsQFXmy2sq0YXNuDAF1CrR14gSrdmv?=
 =?us-ascii?Q?mhxsFwjUWZ8D2EjMWMZsgVLhKOAkIG2mj/eHnbpiK2oPInfLiwdIB2Rv1O4m?=
 =?us-ascii?Q?KWXMcqOJF0/FzW+pcLv2S8v74gYMbsXblaJMbQuu5Sdw9fgnHAOshOsflrO5?=
 =?us-ascii?Q?+9LIg8ISzw8kfW4ejWMzonank8FF15gff5dxqKfqsI4pec/2RKpcMPsbtrCG?=
 =?us-ascii?Q?+f8MTmbfEj+5Q0PTuljrkg8mqeTuUlzADTxRwc5m/EL0oIt3Te9+PoaobN94?=
 =?us-ascii?Q?1yzp5Dupqzy6F72AUZjme9+1xrN8LtL87twkukrWXUUIyb57QERkPh57PHGS?=
 =?us-ascii?Q?0uYd4x60iqKySQgG1zifLwLJIyn6DQ49RbrrHcHETDUZHZhU3goe9//sBP42?=
 =?us-ascii?Q?BmidPBs+T0knfqNTMypJoQCHH7pEiN2JvJUrQGCiGn9aler7BG9bfXdMppmo?=
 =?us-ascii?Q?ee/RF2aYn3tdAqrQar9RodPBRTEKl4mV0GITBJD8qdwqr4NN5KC8Wlwo1/P2?=
 =?us-ascii?Q?mGByHxhW8YaWfpvLChf3Ucc0jk7yh54aefUqpWbTmVKkYk+EzZl+PAVY/DqP?=
 =?us-ascii?Q?jyFWB7mGrSrF7n3DAplUlVhj18sertfzo+JHlBeOdf3wJkjcBY0NZkhJ4Ufz?=
 =?us-ascii?Q?NMRZMWEd7VOIn6s9qJQe5III5vnz1L9Zom1jO7LaDNSY2Q5MltIiPZ8Rn8dL?=
 =?us-ascii?Q?Pcow+P5eGCwnekGraBDurz6fgNPsnpLKuSYPhFaevmi1MybNVv5yoH8x/SwD?=
 =?us-ascii?Q?LH/xDWw0LqeKyjiVar0yxa/n1CzHSQGWzSuKtq+1M3h/7ka+vpjkSmhiV4F0?=
 =?us-ascii?Q?coP0Qp5SvtZGNfpDsskOh+aj4o39n5JjgOHFfiu7bBtTs0DBTGjfRsbIGoaj?=
 =?us-ascii?Q?1tS1cMzw5J2vGaLoXsEe97VznvAN3GUW8gE6zNyLuWaAdC5fUWQoPwkn4/Br?=
 =?us-ascii?Q?wxK+zQQlLMoujgtSDS+wcnJolizrOuEnH0r/fAGXdCGdxfPZ0VXilZIuK63T?=
 =?us-ascii?Q?kfw0zvtsXrSmtOtEfCSt0sLdPLlzKQuf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:13:10.9880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e1c164-c22a-4eac-a4d1-08dd18964950
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

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


