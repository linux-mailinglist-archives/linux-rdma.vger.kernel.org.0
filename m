Return-Path: <linux-rdma+bounces-12195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E6B06173
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 16:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091541C468EE
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB41244693;
	Tue, 15 Jul 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsd25gt9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4910923A9AC;
	Tue, 15 Jul 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589870; cv=fail; b=T0nObOFIq/QE3yj0wxsqR86gJkuGoP/YGeUGWM65MarDuicFXTLBS3cFSe0pNX9LrCD3xhSjgAQribBYirY7KbJ4T7IVI6zBucqxRKyZrNBQF5TQgJE8hY3tfKsGk0Qn5vKL3DVW1SN/S/ZoIm1nRAI7MLkT5tgQ6eW2smV5Zf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589870; c=relaxed/simple;
	bh=ESCyo8mWqeAAvNsZF+zLiIusuFPVN4mBWOyd/OsD2ew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GX/HLaQCNxwzw3RBamiB+vUzy6/JXLGklaV0ae1hm4m4BQ5nJkwoulW9d1MJSnzs3EnS+x7mLZFOLtqfw8Sh8PRnHuC/8anJ8pEmxX1d2R1J7593EsIavLqnS/+P7gQ0ZosK2njIHZA8pFYF3l7AX/Qv0Ho+ugc0PZL5DEKuI4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsd25gt9; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuZtAFjXBk6psoi5yU5grNOgh+nJgWsFhWuthcHyewoY7bl/pN5UdxYj+0bOV6ZlYGDYBPxXyoAimzYPbzLvfXso1bhm/QOUZ+rr72GnTbGtEfFPHnx/3hb7d3Pw6jmhqZqHigBIIZdDnOPvEgzKlcquU+sueDefRNCpgeekGAxOL/b+LPYMcQqn56xpZ3Z6Bn5T/11Vo4MIld5D25zfAIna1GVxKfR8Xce/KUsEIJA1AJJcj4iq0uOwQ1FbLBRw4q+nJU/EA+HctGl1X0J/yACUh+Pcnu94xwZ1Ur+iC2Ewp24mpwgt55VhVdyvbaNxOMJiK1IoYnTTkFJtXi09bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eW5licDAKTa/56qLFH2wzItHkOFnnCJmBMxuDnBkoU=;
 b=NQriQiMq8vmzyp1+XpUk1bgmKh3WS3a9FustjbtsQzOqM9DTsP50NehFEPEA+RohhyKwjt3qoeUfpecvkdM+z9HM9ybILN9auJfcJeIbOWOBIUmhvbQHwhAAiKqFSUY1SPfe6QabNBqVyMOdPu7ytHsg0DEko2BaRmk9kf3Iq/5eS8G7xZzhYlrmc6cHjoYXrE6QaevnmeaAB7n2WHgJJeKzZ2ALX4+uJ/aXyLX51U6SZrQrox3LiNKJJZ7CDGosCPzOtFiaYcsBg3xWIPwlTcnDOqDKS4W+8l7BwOQnHapuZFnAPKgX72iq1FTFNATMsdDcCidH2CwIjH6VUEwmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eW5licDAKTa/56qLFH2wzItHkOFnnCJmBMxuDnBkoU=;
 b=qsd25gt9HQO6zInoschw//uYNBSK3kZ916fR3M1df5qQeEJr4zBeNilhqIfPjnp3HfhgwFQELg4BblsoxpqmEdU1E/aeHqV1phphLoKrbGlZMR8C3zMCyj1SvVkAC7qX7TlYO3xrr6ABfX84DIfPfPuW0hJTFKHFAqJGx6gIA3esUta8eyLBemSHkAX+vJbBkoPyJL3x2dhX8mTOcl0dlqLrID0l1oGJKpBj0zcBb2L26XsGJMQIS2JglHKwEGTU1Hl+0fYrFC+hY9WWuKAcBiSXCJEmMM7MAiphALoJplZ7c+KPbso45nl5WyqRodcelAbIVgqzXCgDn3KgnRHvSQ==
Received: from SA0PR12CA0001.namprd12.prod.outlook.com (2603:10b6:806:6f::6)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 14:31:04 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::d5) by SA0PR12CA0001.outlook.office365.com
 (2603:10b6:806:6f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 14:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 14:31:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 07:30:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Jul 2025 07:30:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 07:30:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 1/2] net/mlx5e: Create/destroy PCIe Congestion Event object
Date: Tue, 15 Jul 2025 17:30:20 +0300
Message-ID: <1752589821-145787-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
References: <1752589821-145787-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 14526464-3674-46be-28c7-08ddc3ac3a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEoWcOvffcbx1yQncQhcGtxCxag4MGbI5ne+cIseRtyxBAL3oLp9NsssQ1Cj?=
 =?us-ascii?Q?kaY6GqE0VtSxokg5kUN6UxZ04mPs8+RHgh7uDhm0CvnWrz9/eJvjx1QjLtTQ?=
 =?us-ascii?Q?awVdESmOoJFmILtGk4ajQPreF3mTpriect7N+/W8HuKfN4O73ysYlu3e4v16?=
 =?us-ascii?Q?crY2f/xxgc0MNVY3tQLlE/KuIKpRuZNeBgtx05mRrqfZWwpGO/DjmOZmIrXO?=
 =?us-ascii?Q?s1N+My9J+GvsKXWuK5RX6yRd2tKHCi8Dg91xmDir1dL+35lE0lxFUOtbGpM2?=
 =?us-ascii?Q?oxVI1Xznr4wPT3x1iavcP901wmvuUpRSXdx4CKdBXOVTKhbVQsCM0B6IOm8V?=
 =?us-ascii?Q?MWKsvGWeI/DtezN4CVY0/p6Qdt2BTpsc9kpZ5ZQFZ3WRwY3g1VDrEPPtiPXp?=
 =?us-ascii?Q?SuCE9eN8Lxk0VhmOt6lBqVybMV+riPSFtnrEfUbKexhKOJALBVrIwrOisTrV?=
 =?us-ascii?Q?wnnYC12luFzucGy9W/zJ9Uczzyf74tO6YFKMV8KTU3B8D0vypjEUcaOEroP0?=
 =?us-ascii?Q?bktiStNmeNgFE5EuVhC+KXH1Z9mlztkagR/EIZACCoX4zeLeAXbxFwwqa3S3?=
 =?us-ascii?Q?eTzb7Da8emTawvASG//UyGk9xh41rkaNhbfTR+p7QjnS3AR6cjC0wcvxO3j4?=
 =?us-ascii?Q?LT3hrHzDjKx0/gUvbZriYMrgwPRBlIjRYAMjbd1FJsvag67VR/7Ck7ADECd7?=
 =?us-ascii?Q?KDW3cEFxDUoSn6DUVAq8UERX+Fz22OngeBMntTByND3S3uds84Ibi12GQxxV?=
 =?us-ascii?Q?xld9y2+Cv68pR2UXCkQkL54VihJVPr3Yaxxri7mRa9jzkM1rx2Mk9o4ZTSU8?=
 =?us-ascii?Q?jxRx1YVHr52UVGN4owASM6bobG3VgvJ1sOFDkQA8m1OZYlu9Bft9tn7YjAsu?=
 =?us-ascii?Q?IS4Xwzc4uvMOW1tUSr2niDkhHRPKNW5gvoI/jjvj5ThPPeJtrOqhvONkwAhE?=
 =?us-ascii?Q?vSIhCfFnqnsyfGYg43ST1tpKM2++OtoU4y2FqwpZV5WQMY70O7Qs9+rkPdFE?=
 =?us-ascii?Q?Jv+irubx1l8AVQmgtNcOLxESwoxaIcgdszjlvYVMD4udusGFR/30Xqtl/npt?=
 =?us-ascii?Q?kjKoFuzBrT4AX1ZEv8lMjIveweKyBH0hoQVJW+IcjA1+1fru0ecRJyzH8iQW?=
 =?us-ascii?Q?AZXk3nyedDdIP2ppPIhp/2Nvd8Xy81QmSG6nmu0UfchvWtYLgdz7EUeuiNit?=
 =?us-ascii?Q?vHYs1lpkvmxiB5k9aBvhA5k0o0Ekgs82PkFvL5qFVPKmew699Jao8OKf6j88?=
 =?us-ascii?Q?iY9u+bZC3JemELHPRJALxAAcZud67FwxdzdMKIhHSgBIP7CGQREsbuGhyY64?=
 =?us-ascii?Q?CgzYwiEkm3llDCPvFyz71qGyvea+BQqaffqtSHE2vMX90p++fK7/XwrYhfmg?=
 =?us-ascii?Q?hntEjlwWZ0ODVCPf5JNNxtHo09UVZDabviG0zpjnzrQSVVZoXLUVP+5qM+h6?=
 =?us-ascii?Q?8+KNsO+q8GfVuGgk5AUntYTwabn46j1mCLMi62YKu9SMIR81nkJ2VLkF/GXJ?=
 =?us-ascii?Q?jjdEVkbHIcrOI0YmjPndoyi0C/CyJpA8n+HY?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:31:03.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14526464-3674-46be-28c7-08ddc3ac3a09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

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
 .../mellanox/mlx5/core/en/pcie_cong_event.c   | 140 ++++++++++++++++++
 .../mellanox/mlx5/core/en/pcie_cong_event.h   |  10 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   3 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  13 ++
 6 files changed, 169 insertions(+), 1 deletion(-)
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
index 000000000000..9595f8f9a94d
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
@@ -0,0 +1,140 @@
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
+int mlx5e_pcie_cong_event_init(struct mlx5e_priv *priv)
+{
+	struct mlx5e_pcie_cong_event *cong_event;
+	struct mlx5_core_dev *mdev = priv->mdev;
+	int err;
+
+	if (!mlx5_pcie_cong_event_supported(mdev))
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
index 000000000000..b1ea46bf648a
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. */
+
+#ifndef __MLX5_PCIE_CONG_EVENT_H__
+#define __MLX5_PCIE_CONG_EVENT_H__
+
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 2e02bdea8361..c518380c4ce7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -495,4 +495,17 @@ static inline int mlx5_max_eq_cap_get(const struct mlx5_core_dev *dev)
 
 	return 1 << MLX5_CAP_GEN(dev, log_max_eq);
 }
+
+static inline bool mlx5_pcie_cong_event_supported(struct mlx5_core_dev *dev)
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
 #endif /* __MLX5_CORE_H__ */
-- 
2.31.1


