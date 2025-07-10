Return-Path: <linux-rdma+bounces-12017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E60CAFFA2C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 08:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62984540ACC
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBD2877E1;
	Thu, 10 Jul 2025 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZW/vkbSn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD2283FD9;
	Thu, 10 Jul 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130352; cv=fail; b=fzjEjuwDUdZAhHLaz0ytrSBwEkLIn+mP2Lc8y6o+U4ywnwfP3HXElsI959U3ljhtpa3OyVbqFFmEFcezW6gH++SUW9PnF/wkYZDXT5+OC9n5n+I2Fm/o3zfmPJAV6D5+4h30zSU8N3w95FEOgWHSHHbnS0nvGzsMJCt6g0hnVBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130352; c=relaxed/simple;
	bh=aJPF9AJ8lJkiwDbbgsJ+R+Y3s8z1bKEdp5guwaj6Tt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuGjIgTzaR8O2PlKccaWdBe+TP9CSv/uRDeybSmUvv3PLyq7Tcz3fMlrVhZ0IGZkSTN+epz+wBHtLbxSm8Sthy6xai99ZQrrSlWZkLBtDqxfP/0WwXl39kjknqmpcu8ksNAiBq2SFURey8adVpNC9/HNKSS0TsJwLmV5jPcgRJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZW/vkbSn; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZHS04AZTYX0QoLvv88RjTbwaBSBLLkZkHh+VyMTkGaduItW2n4Husli5hz+qg5zgoHz5q4cB2Yc5QvHGyB6dxh1Ce5YwCqJYwS8tATz9lw02Xwucn+BkRUi27Ar5t4gjPp+Ic0AenVUQwdmeBtBkyLCIJPPu+eNiHkCvFtrLvCqO8EriPbz45/xnUpeap9HFos1VzcCWn32+jYWFdVxlU5tAnFGf5uIOFlGSFHK7jO7wqj9arNeR+ZKuz03DWdMGRWLpIexGFf7pGYjdvOZMsCsP6O8hg2RvilTXOX+vYltR9LED9Wr0IUMJ0xuVbuIfZN0wg0EJ+i8KFT94cb5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzaHo2myWsb3DnHWqQUvlBDIjR7vnESyRCKID+1n8cY=;
 b=WfIXeGzvAb8zk1dcCN9hvvjLtwPu2Hu8Vnydzoi7S5mDdwSYTtYYZi4ISx3Du1U3PAr2Nzr/YaKh1wFPB+qud3Ph/mnCbyPZn/oQ+SUmfTvQVaIGl6hU1fkU2biu/IAC6BZW7IJMXwckEGwPIaIu9YKRtl3/f4pQ/+Ix6vNq0jE5/ZCMR51t9riBMBrtzYEVBEeBQ9QRlIBVlisjipPJxWZsssp+BGXpxtyWEY12l+X6qNwKE8jeHWaoISLQK1Wi/eH1lhsiyubhUFUpBXJe2DdlVTqqbD6bhCvO/FbFAx7qneeM/wckUQavFCUdnLwf9XQfCYpeA+JVvk6+kredYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzaHo2myWsb3DnHWqQUvlBDIjR7vnESyRCKID+1n8cY=;
 b=ZW/vkbSngzD1uIU69zB1a4qz6LSaXI8SWQUK7nBwtpW6SqLZ7T7mzOFzVDkXl6bflOnT8R07IDhAK2C+D6FxMcA15nC2jPJ9GTSQtokm+4THQ7ohnhbTV1vuAEC2QEKBTSq3raQ6G5I+5Z/+s9YV5zhLdV366+Moh8Gi9DqceRGfsYnaVgQgwfwKurwTDMV/wrMw4QSDSTow3Vq7uHr64ensEVDqdAufusvM5ebA4Fb0xyea66HD29mF2YAy98O/N71aAo9YAk6m8PMD2zALRACv3uwi60kKU2sbNO+VCkT9PI9z9O2B+lAidn3jZVK4y137Ni9tzEZ4xag7cVBENA==
Received: from SJ0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:a03:2c2::8)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 10 Jul
 2025 06:52:24 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::46) by SJ0PR13CA0033.outlook.office365.com
 (2603:10b6:a03:2c2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Thu,
 10 Jul 2025 06:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:52:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 23:52:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 23:52:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 9 Jul
 2025 23:52:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 1/3] net/mlx5e: Create/destroy PCIe Congestion Event object
Date: Thu, 10 Jul 2025 09:51:30 +0300
Message-ID: <1752130292-22249-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf265ab-00ac-47c9-8f34-08ddbf7e536f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKyXvlUdxYekIf2nF+WZ6qF+LX8KYqOBsOA6BzpRHN/Nen2sjEO9+vxMq983?=
 =?us-ascii?Q?m+Pm9UWq76Dk/nlAXnGKoYFZENye3zUiYDoafMFAtfkPmYKfoAm2NiUwu2Mv?=
 =?us-ascii?Q?MEVE2RxbcGi6MSGHsyQs9YnSZ4+GvpS1QhpLoHNsvBI83nWcUNGDNpX4QxK7?=
 =?us-ascii?Q?cBGo6QSqDMXLrGNeK621R7Ve6+F0CQE3htD4UiOtFSKMN4cZMF5afXdQeH9k?=
 =?us-ascii?Q?emcZO7TjZojPBFCay1Mzk/ua6ogM0Z45RWivioBZsMa7NbFHbX/X0zmeZigY?=
 =?us-ascii?Q?Pmez4M3u3X3hCRts1s9EyB3vFzcGkJJjo5RK4AvGGVQSnW/IbvfueXyxvoZW?=
 =?us-ascii?Q?2miIzpH0QqHTIhTRsrO8Ha6lt+Jepv0maR6U8MdEruWsMWLbe4XScAVuWVUU?=
 =?us-ascii?Q?r51TxfAmHyEQ7zoQjuGtzltTi3de5YlGN3b/rxG8HM4pouDHH69veYqti5mS?=
 =?us-ascii?Q?c5eDWKOxOmAQ6zzznQWboUuqVlWUzC+EWDTiF9mw9LyE9gbexSbBGAnRjJKL?=
 =?us-ascii?Q?JKC+R5WRmR0AK8Mv56XyciZrDwAel9NpTMprjr30fa4Z7TaiAj7uRJ0o7GVR?=
 =?us-ascii?Q?yJOj2CN/vLgNHQbOBCcK+n97JDpr4M79B7Yz598tzJ3xYyuAcXP5vGjPaL5c?=
 =?us-ascii?Q?75mVgEi28okz/DciKZLvjIvKVn/wScYCIlinfmXQwMuwfhPitQ+oxjNmv8HQ?=
 =?us-ascii?Q?KX1JJryGESewBQsGKQ8setx2G81hOmrl0EDEETder1pmG0zaQNX7gfrui/tT?=
 =?us-ascii?Q?LeWgsojkplgJwUiU5ECCWiX8gc9mF85F1IHL0r753TQdv7Jex5ed3zoJp5lb?=
 =?us-ascii?Q?b5gHjbZFLkN+BohUp6L4JoBewSBa/OPB3C+/T1yvEvx1lADqHtXmbCu6l+UF?=
 =?us-ascii?Q?xZBeMOQDnK6KfSwZgtLsaQQRedOVOMWg/UqIp2DJbAdUXDOAl609lkDtTBe5?=
 =?us-ascii?Q?C9pFtPsuMe9MqeSsvSaY8mzJGnPUq7x/2aX53ydLH9gTfrxFfQ9TUOIDmFoe?=
 =?us-ascii?Q?3WNv3QL5HIMs+Sd01i7U+tRU+IjfEL8TWq17OqK1Szk/wZYH9XjdZ8/Aeu1n?=
 =?us-ascii?Q?Jj/DTVy0Vugj2SM2/tBwyTNkA+4anebDqVeucKmFilTy0iCKT3PNH4oW5VzJ?=
 =?us-ascii?Q?q4oXaeqVQMWzExS6dd/hoOp3oa4aOIauJ4jQwF7Pqoc/0DrfNKmP0RWfDxbi?=
 =?us-ascii?Q?A30Yjns0IJEl1LX962qdcqEyXav/TUij2KCVgLKvqRWVnrjwozK6U1NzJj1V?=
 =?us-ascii?Q?uLTdzNu02+HlNOmsjM7lXUkW7+0jXPJWow390oaziNkEncm02CuPPQidR5my?=
 =?us-ascii?Q?GNSoZTWIFQW4Xq8dYqyZ0Bdve53ltOMqFUOP1m+bFYgeACWeM7MXumRN0Zxx?=
 =?us-ascii?Q?33mqC+VksdqtvWLxlVVpDUK3iNkIdXIQ1gM43cVENvFR80dCHRztMOVbSQW5?=
 =?us-ascii?Q?/bI18MDy8d+nioypM6L5HkSicHxDhRmGtxzzkdlupYAIgPcp2NzOY665hbFr?=
 =?us-ascii?Q?NzasAXzcwosQp2WDtxz1E/cpLNhlhPDjJH6K?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:52:24.1764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf265ab-00ac-47c9-8f34-08ddbf7e536f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

From: Dragos Tatulea <dtatulea@nvidia.com>

Add initial infrastructure to create and destroy the PCIe Congestion
Event object if the object is supported.

The verb for the object creation function is "set" instead of
"create" because the function will accommodate the modify operation
as well in a subsequent patch.

The next patches will hook it up to the event handler and will add
actual functionality.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 153 ++++++++++++++++++
 .../mellanox/mlx5/core/en/pcie_cong_event.h   |  11 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   3 +
 5 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d292e6a9e22c..650df18a9216 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -29,7 +29,7 @@ mlx5_core-$(CONFIG_MLX5_CORE_EN) += en/rqt.o en/tir.o en/rss.o en/rx_res.o \
 		en/reporter_tx.o en/reporter_rx.o en/params.o en/xsk/pool.o \
 		en/xsk/setup.o en/xsk/rx.o en/xsk/tx.o en/devlink.o en/ptp.o \
 		en/qos.o en/htb.o en/trap.o en/fs_tt_redirect.o en/selq.o \
-		lib/crypto.o lib/sd.o
+		lib/crypto.o lib/sd.o en/pcie_cong_event.o
 
 #
 # Netdev extra
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 64e69e616b1f..b6340e9453c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -920,6 +920,8 @@ struct mlx5e_priv {
 	struct notifier_block      events_nb;
 	struct notifier_block      blocking_events_nb;
 
+	struct mlx5e_pcie_cong_event *cong_event;
+
 	struct udp_tunnel_nic_info nic_info;
 #ifdef CONFIG_MLX5_CORE_EN_DCB
 	struct mlx5e_dcbx          dcbx;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
new file mode 100644
index 000000000000..95a6db9d30b3
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en.h"
+#include "pcie_cong_event.h"
+
+struct mlx5e_pcie_cong_thresh {
+	u16 inbound_high;
+	u16 inbound_low;
+	u16 outbound_high;
+	u16 outbound_low;
+};
+
+struct mlx5e_pcie_cong_event {
+	u64 obj_id;
+
+	struct mlx5e_priv *priv;
+};
+
+/* In units of 0.01 % */
+static const struct mlx5e_pcie_cong_thresh default_thresh_config = {
+	.inbound_high = 9000,
+	.inbound_low = 7500,
+	.outbound_high = 9000,
+	.outbound_low = 7500,
+};
+
+static int
+mlx5_cmd_pcie_cong_event_set(struct mlx5_core_dev *dev,
+			     const struct mlx5e_pcie_cong_thresh *config,
+			     u64 *obj_id)
+{
+	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)];
+	void *cong_obj;
+	void *hdr;
+	int err;
+
+	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
+	cong_obj = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, cong_obj);
+
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+		 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_type,
+		 MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT);
+
+	MLX5_SET(pcie_cong_event_obj, cong_obj, inbound_event_en, 1);
+	MLX5_SET(pcie_cong_event_obj, cong_obj, outbound_event_en, 1);
+
+	MLX5_SET(pcie_cong_event_obj, cong_obj,
+		 inbound_cong_high_threshold, config->inbound_high);
+	MLX5_SET(pcie_cong_event_obj, cong_obj,
+		 inbound_cong_low_threshold, config->inbound_low);
+
+	MLX5_SET(pcie_cong_event_obj, cong_obj,
+		 outbound_cong_high_threshold, config->outbound_high);
+	MLX5_SET(pcie_cong_event_obj, cong_obj,
+		 outbound_cong_low_threshold, config->outbound_low);
+
+	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	if (err)
+		return err;
+
+	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+
+	mlx5_core_dbg(dev, "PCIe congestion event (obj_id=%llu) created. Config: in: [%u, %u], out: [%u, %u]\n",
+		      *obj_id,
+		      config->inbound_high, config->inbound_low,
+		      config->outbound_high, config->outbound_low);
+
+	return 0;
+}
+
+static int mlx5_cmd_pcie_cong_event_destroy(struct mlx5_core_dev *dev,
+					    u64 obj_id)
+{
+	u32 in[MLX5_ST_SZ_DW(pcie_cong_event_cmd_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)];
+	void *hdr;
+
+	hdr = MLX5_ADDR_OF(pcie_cong_event_cmd_in, in, hdr);
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, opcode,
+		 MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_type,
+		 MLX5_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT);
+	MLX5_SET(general_obj_in_cmd_hdr, hdr, obj_id, obj_id);
+
+	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
+bool mlx5e_pcie_cong_event_supported(struct mlx5_core_dev *dev)
+{
+	u64 features = MLX5_CAP_GEN_2_64(dev, general_obj_types_127_64);
+
+	if (!(features & MLX5_HCA_CAP_2_GENERAL_OBJECT_TYPES_PCIE_CONG_EVENT))
+		return false;
+
+	if (dev->sd)
+		return false;
+
+	return true;
+}
+
+int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_pcie_cong_event *cong_event;
+	struct mlx5_core_dev *mdev = priv->mdev;
+	int err;
+
+	if (!mlx5e_pcie_cong_event_supported(mdev))
+		return 0;
+
+	cong_event = kvzalloc_node(sizeof(*cong_event), GFP_KERNEL,
+				   mdev->priv.numa_node);
+	if (!cong_event)
+		return -ENOMEM;
+
+	cong_event->priv = priv;
+
+	err = mlx5_cmd_pcie_cong_event_set(mdev, &default_thresh_config,
+					   &cong_event->obj_id);
+	if (err) {
+		mlx5_core_warn(mdev, "Error creating a PCIe congestion event object\n");
+		goto err_free;
+	}
+
+	priv->cong_event = cong_event;
+
+	return 0;
+
+err_free:
+	kvfree(cong_event);
+
+	return err;
+}
+
+void mlx5e_pcie_cong_event_cleanup(struct mlx5e_priv *priv)
+{
+	struct mlx5e_pcie_cong_event *cong_event = priv->cong_event;
+	struct mlx5_core_dev *mdev = priv->mdev;
+
+	if (!cong_event)
+		return;
+
+	priv->cong_event = NULL;
+
+	if (mlx5_cmd_pcie_cong_event_destroy(mdev, cong_event->obj_id))
+		mlx5_core_warn(mdev, "Error destroying PCIe congestion event (obj_id=%llu)\n",
+			       cong_event->obj_id);
+
+	kvfree(cong_event);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h
new file mode 100644
index 000000000000..bf1e3632d596
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef __MLX5_PCIE_CONG_EVENT_H__
+#define __MLX5_PCIE_CONG_EVENT_H__
+
+bool mlx5e_pcie_cong_event_supported(struct mlx5_core_dev *dev);
+int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv);
+void mlx5e_pcie_cong_event_cleanup(struct mlx5e_priv *priv);
+
+#endif /* __MLX5_PCIE_CONG_EVENT_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fee323ade522..bd481f3384d0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -76,6 +76,7 @@
 #include "en/trap.h"
 #include "lib/devcom.h"
 #include "lib/sd.h"
+#include "en/pcie_cong_event.h"
 
 static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
 {
@@ -5989,6 +5990,7 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_init(priv);
 
+	mlx5e_pcie_cong_event_init(priv);
 	mlx5e_hv_vhca_stats_create(priv);
 	if (netdev->reg_state != NETREG_REGISTERED)
 		return;
@@ -6028,6 +6030,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 
 	mlx5e_nic_set_rx_mode(priv);
 
+	mlx5e_pcie_cong_event_cleanup(priv);
 	mlx5e_hv_vhca_stats_destroy(priv);
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_cleanup(priv);
-- 
2.31.1


