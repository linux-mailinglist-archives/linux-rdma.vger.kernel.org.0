Return-Path: <linux-rdma+bounces-6249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884059E47A1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B2318815E4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB71AB6CB;
	Wed,  4 Dec 2024 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N0pGqgS3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC8191F7E;
	Wed,  4 Dec 2024 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350320; cv=fail; b=SD13TOLvUJQ7jI8DrU81FNubDXbrzj/Ir+WBOyNVm75L+gqdD8uGncbLFQSmRMDHx9T+DouEn50H+45WTV6m2PWkOAkNPTAwXxgiRbv++XFk6PmJiR+UdMWyWAt/ksmLX/vW3VXOkknW0jE/D2E/OXnhsxP5wrXeGR/e9/lwT04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350320; c=relaxed/simple;
	bh=QCSEl6bliieREXUr8/JO++VkxisTk0SeosFxUyuPj3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHnT/lWuS4oIZr/zQZkjKraRndLOEqp+zJMvneGqyYn6xoJCkhtVJXd3ACTNGDwTe3mILI/2DVWlhzeyIfXgsTZSmZA8NBJmjNLiYL9AlOTUQ0QQQJcskFR11XZ39Qcn/Th/VTq6KM8dif50XIk4Dwx3rtj50MAQS/aLvoYztNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N0pGqgS3; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWi1H+SbP9K4/WZfR573MWg0wHLEXfqGiiD3ABuSb7iNU1SPAyG2w9bt7PMpG2uuUfSMnvADdGGU939l+r8WVnbWfoZFRzNZORDga5dZC0vRjbDxef8/4uHhJ59dOwfUFCKg+8fmUY9S8FkBR1KIsSzwfl0varjjYstCz2pPEvurdLm1QYb3/PQ+lmwtkN+603XWU40bNLWwAcaXF3/zZ8Ke7Ue8g2SogcsNiFBSeI9TklJykkLfMImq7OgKj/gtI/rqXEoi+dbivnRT0q+4150IPlRTxgEXBA20sWmJCLlbuOqDM/me+rZ2xa/ZNlhGjIp/+1RziwLuqiu5Z8sxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmm9CWkmGIV+pxRhdQaKECJunEX5SFomq8AeB3ctlYE=;
 b=ZgiIMqHOTnoQTwCbkW2CHBgIwS8/gBQSXVyHFDZbreAO8NS2DJoZtXeSS18QEDezdEURr13J/MNkkuwuTCMYNlZg9uWX4AVP0ktc8UuIgoIDfTlfNp+3/vebz5QCs9la3w1okMN6U8BVRsT++sYtoaQyzbMty2VukwQN4i+jZSD/8CTT7qWBglRnySeaSbKLAqSnGswzu0E+DBvlZGxYbhInXLT+tCrtUKospATCz4RLYgiTYkjZGEpf7u7/vcTw8fX0CLLd+HnScx9MKwORxq8cYa6zQN6iok6WVSq/uxiogkZqV7LtdUnOmaY7cs9WNuHGD3PbqLy+GSBn+NGFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmm9CWkmGIV+pxRhdQaKECJunEX5SFomq8AeB3ctlYE=;
 b=N0pGqgS3rhL6iVpQKfpEIFTduF/w+Hb108Xmjzf6GgplxGzRtkve381ir5LlgiwkcCUqJTm3V2WzrC8gwrXxhNI0hNDeF/eq+zOAmon99jPxE3MGB8YckQw7JDiyZgEVSGYMF0x+EX5Jf9T6oz1B57iv8SAXFrQB6DqLW4ljgiQ6mxROO0qUd5RkN1z369wElaESf5O8xjQxaMIpG1gxzhzkAikHtrx718i6W+MlbQr5FdNgTTbnxYmn/vt6JGsCIFg99gfxsRlT853wn0lYwDQv+eM9KNPKkXgSefu1BFQFnnQ5VFXMBnxgH2tq2UjBWICftbEZkT2n/Qo806PSqA==
Received: from BN8PR15CA0035.namprd15.prod.outlook.com (2603:10b6:408:c0::48)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 22:11:49 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::e3) by BN8PR15CA0035.outlook.office365.com
 (2603:10b6:408:c0::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Wed,
 4 Dec 2024 22:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:28 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Itamar Gozlan
	<igozlan@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V5 06/11] net/mlx5: DR, Add support for ConnectX-8 steering
Date: Thu, 5 Dec 2024 00:09:26 +0200
Message-ID: <20241204220931.254964-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3b25f2-9b45-4b40-68c5-08dd14b0a620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ic+xeumBWX58QlGGbieaaR+dYuSxVx79zw6lmlxnpMQ2ZJCpq7L2Z9ha5oVp?=
 =?us-ascii?Q?82CYzJ+bdfX/W84kwkNdk9ZD3Hj9peIjUnV2as79B86R45Exqe7EAbobm8ad?=
 =?us-ascii?Q?XTrR0b/vgakqQxZxsYlEXEGhEi7ccrr3GDv3ImKzCWbv6mkIaoaHKeCnmemw?=
 =?us-ascii?Q?+xInU5agHuIILn8G6ToouMSMpE4pOBUTmJB9KYvqtuWwBlJUIu9+hf6WvTlc?=
 =?us-ascii?Q?rRFo7eftKncJ9i1aDXYSihDJwFOyOuqkbPL1G7gsSw2OOGW3ZCkuy/CdvGOg?=
 =?us-ascii?Q?IkqNAI8bYtfSerMtRU5damXA42Nx52sPeYiHvweaxbZjV1MHJB+xlni2SMnB?=
 =?us-ascii?Q?B2u8r31qX25kTsqhZn72AImqPnCKCXVZeEq0C8lBmJoMdzObgHeijxduKAun?=
 =?us-ascii?Q?OKEcmhtOh18Mpvq8hyK9Q1QKa2HUnDA4Eh3951s90+Y//DcTwDHR9/D+ZT9I?=
 =?us-ascii?Q?TvI0F05FjwDUzACOA7gDCOSKo+mXCYox4Q2i6C6h601nVfK0BPoFdySRuRb3?=
 =?us-ascii?Q?UV8b5pBilbkmm5VI+JiIXljldBgR/XPXnnBKTXi6fQbh83fLOG0rRixxWEy0?=
 =?us-ascii?Q?qwoJXdKqgF2khLFAdsJkau6NBTjbeVQ8b07X/s+20bL8VzJrWFTcxkyEmSzS?=
 =?us-ascii?Q?s+qicBZ05IQtLRZWhd9hF+CikoqZm6OOAH7CU60Wnp+0pY8wx/2UOB5T7P6k?=
 =?us-ascii?Q?PuNY9DeSx8xqdCsNMnagD7ReCOJo8/V4ReyLi8gq2rE8q6tsJmJu2UqcXcHu?=
 =?us-ascii?Q?hUh8pOWX9obquLSyeVuP9CTW9KtYOAdgHkfcVeJVSr0IbDuCcL1kw1hKbufB?=
 =?us-ascii?Q?H6O+unD1TQjXTHOa/3Jp+KkB4JzQ8mmpCG/DtD3vfsCm3IrsncUNNMYvvO82?=
 =?us-ascii?Q?tEZqnesFDtb0h9CNsh3oGjxtpYtqx+y/AJPY+FuMg+0RX2ipGO2RVTXlIwfZ?=
 =?us-ascii?Q?0V33+HGMEuyUsz2UvFBFRZwaI/22AuZN7Px/tkEzv0H7I6PZzm/h6Yu9oT+a?=
 =?us-ascii?Q?Uog2uQh6IbAjMqP0O7AYimLs4g7Qr1aIt3YJ/ahXShgqLV9cWeCYfsYyav92?=
 =?us-ascii?Q?i6SdumpkBEGpq6UY6KjH0B7vtOShQ903eLjBx1d1/aJrZsl/m0nyXTh8QpS3?=
 =?us-ascii?Q?vylbUjzpRY3i/+5aDKE7rWVdFhchQ2Sf0MQI2keNfwMgNufHwuos78568xQ9?=
 =?us-ascii?Q?Ov5mFmU9Yb3FUnxQ5Ns/Uw5SIv0Nb2qcytOuRC3OtZUvlax/HRMXGpKcLN1x?=
 =?us-ascii?Q?8xlzje0CGZ2zQUH4GixYPr4V1eoPlJd9lwsWErzUdwRkZnfEKVOFko2J48n7?=
 =?us-ascii?Q?+xaQwKsDr1GKcg99NsllOpHa62Nd1gzb/b7KxEsfmetd7bJfWSoMVX4GFTIF?=
 =?us-ascii?Q?O+2A87IcwAm058cQe9fSd86ikwgUauSKbGD/ys8S0TtiJW1BRedqy4snkXu5?=
 =?us-ascii?Q?dwQPJcr5Z41outx193N0uF6ynPvFH6sr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:48.8388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3b25f2-9b45-4b40-68c5-08dd14b0a620
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061

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


