Return-Path: <linux-rdma+bounces-11453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5403AE0405
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE9176A2F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB452242D66;
	Thu, 19 Jun 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fN/uIWVS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5923D2A2;
	Thu, 19 Jun 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333077; cv=fail; b=TDPrT4Bb2fTEk81Qi2FC8qRQD4fj02v5GgCl1cSgdfyUSTvZryw4m0fX8SwL/uBB9C6S48BDFN4pHaIzUpS40r/kfBJ1jaQkWcN5y/aha0CfKD9xnwz730j/zXZjlzhA5NvBuOnoalckX1NPBfgPUeCfK53GNykWyaI6eIKI7dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333077; c=relaxed/simple;
	bh=0+4dRyW07LR4cuqCp+TZ02zGweF7z+xv/pwOl/NEtHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIjjBrtd9v6xxIx11ZuVXaESRozaFN+vdovM4R0qi3ZqMJgpLFY/RoqPrfmshrosmYuiEDJgihkA4TXjcHaW2IItZCL8i/GvCQICBIk9F2crZuPM26Xb1zFstwJnY1RfyuMIcil6c1XzG2Z8ZQkLL4b3V2z93io9VzdT+0gPUsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fN/uIWVS; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRVQ9/lIqcaY46vL6lzznH/yeerTbl153fVW7iU2UiPlb1x1+VnZMbDGjqIciwZPtbJzXCsmODZPYscBVjyGqVKev6jD4bQ45fioIudoqAOxwVxiNxDuWwmnME/ve7G7BbH7ud8Vggc+sHi8xRPgnE4H0O2vwtn0WY2/mZ6L7sjbfPOPVTeM5J9R7t1bjbEo7q2voHqMQ5r0GaP0vD35dyLCpvhbErjO3qAG2EV6Dxh590g5O+jtMAzVNRiclI7/E/c0lNij85cfbgyItXF6jXkjyMQO5SWZo91V9cbISlW582cfLeLEpcQM6hTZOwjajBNQkXEqsgxCSBVD+Gh1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYwhkyEtZjlYM162L7LKJv6e9UKotoD6Pzxf8Ts2qbg=;
 b=IsYD7zNFrT/qrjgzUxI1VM6ZWRtL5hiufEC6r3hk5oXTItcSdAbTRZqfk7PMs/AYbqWVfSLghnmUrUXMUY76kltI1d3GQhEMYmvluxk+kzeeFpmbQoV7UJ50Uvr6brJk+3E0FvIykLH/FtjGGKhy74tHKdvkbY4W/RM+X9bijswQxsrM6O/QZN8MyWgiPaofJ4RK04QcZR1e2+1Rzxlpvm1SsB1+TrclX0iR6ickTlHaSMSjHKu3sAUKtdozU/7YrALoi3KrIdnbr9FhZTNPmwv3lGregR8xo8RUH3GRCZghwOff1XDoVPPj3/iDcP1gNCHHHVUwxmmtworPMeUafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYwhkyEtZjlYM162L7LKJv6e9UKotoD6Pzxf8Ts2qbg=;
 b=fN/uIWVS7edNEzwjqtUYcfM00W5IhyIdsCvA8Cv5Tde013SFCADan6oDS7JsVHrNiD/5U7LgJo9gbqQecKOAkH+L2Bvr72JyyknPtZm+iZ65muYg4dbn3tC/6b3SN02eg0UkAo2G4XsDV62Puk+cfjQ6COaPEaEG94wZAgc+ZcaE5YYyQSjl9SmOEeSVEy/IIpX1JuQbDP2mfVeXIrVzEQ2QoN2KRNS3GHEyX6yhXCmEutJZ5VSWjqFkQtov1HCG8fqGw9vXu3oAqr9dMk3QwkS+S95i6HeJhJ0qEHWI2DxKEmp9ZPGyAnxH1c8p0xbrPQqRHldDLjPeNCakBZHdXw==
Received: from BYAPR02CA0042.namprd02.prod.outlook.com (2603:10b6:a03:54::19)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 11:37:50 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::a0) by BYAPR02CA0042.outlook.office365.com
 (2603:10b6:a03:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.23 via Frontend Transport; Thu,
 19 Jun 2025 11:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:37:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:37:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:37:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:37:36 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5e: Create/destroy PCIe Congestion Event object
Date: Thu, 19 Jun 2025 14:37:19 +0300
Message-ID: <20250619113721.60201-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619113721.60201-1-mbloch@nvidia.com>
References: <20250619113721.60201-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 733d0d20-b1ae-4004-60ec-08ddaf25b822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8u6q7lNn1Lv6iOKGCMk8eqAmXwYiQjpKdGYVAjJSFkkso5UxOICadyw29e/K?=
 =?us-ascii?Q?vyVrASo1jmw8xststLFFCfgGv7jYypZxCOe0moOrLGcNmScYirSC4b2o2OOs?=
 =?us-ascii?Q?Ik9FuQ23aNUU/DtUz7/0VLZHFPYPl9rmvxmYYLsF+dEETQF3lIdsnTBWbCl+?=
 =?us-ascii?Q?rm/uFPZ6HkhwgxFTc/zO/XMxdRUJQ3c6Oq9lSIdIePJQSlzZmnr2pNhcOLFz?=
 =?us-ascii?Q?YiEJFRlGr/XYdQSMWr45s2WqDx79VpYoLdTZuSGUqKiNG3Hhjw3I1gkzBi8i?=
 =?us-ascii?Q?AwC8r+ngQ4WWnJ2UX2QfWeNPLRVM7gNs3hrwaWn/JPT2jcdL4i8FDFgmtZwp?=
 =?us-ascii?Q?/oOC4oPw8gVhv9/jfciQsX1nL3Au8rRnFwaBokB5nkHzmPUqbwWWZGvWfEUW?=
 =?us-ascii?Q?JmX7Frs3DjygrNzvUd7AVmieh4j62P/PNZhcW/SHltZt0oVvu7QnFl+oe85n?=
 =?us-ascii?Q?yzRXdDW17X7VOVPcGEbJGZfJpRuFACALgxOywlGyHFoFUnPYv2ibTX21It5T?=
 =?us-ascii?Q?GQC6ytyBjMPWrf1WdPS4f9Nf2dHpbDgufHjynvxWBoMiUOQirHNsTMnuWACS?=
 =?us-ascii?Q?QTEB2FlTJBPyOevPlT0DRwAcJ26YaitCtlcqsL7Jw1W4+f6Bg/Pco/UGAJxh?=
 =?us-ascii?Q?OmUr+dY33/+Tv85pgp3FYRoEaNolmgJuETUuO+2Dprv4Qn0QlzBRRp/+XzxN?=
 =?us-ascii?Q?yLwQkStjAvIoGHZ74CphvOWgYPNjCm4wqvt4jG19xSnAaiTyWeMW/U0WM/MA?=
 =?us-ascii?Q?DqVKbgH792l54uznchpbRK8tQNXEH0lZMdBRBPRmzi8cxtBYt/v6wzrSpfK/?=
 =?us-ascii?Q?U+dFsVdHNzNcqSlnzGY2dm8uWbzI7uBm9sblo5sFJg5I3VRmv5Ba46MG9hKo?=
 =?us-ascii?Q?c24rm1yLmtN/fHazaVqNKZoAvRtw33E97XngeLjo5YYKsp3p7IUqBW5SQxGz?=
 =?us-ascii?Q?0xLi9Y2btVwBpaxad5WbU/ZJHGyoFtfkXx5xh3BRUGErNWOEwcYh4vOjVPnd?=
 =?us-ascii?Q?G+N4e2q6arTmGLZGOsIIHwq+jFic9NqggFmhlk42ns26n8UrP/NrFqzlLYb7?=
 =?us-ascii?Q?ExjjLYIDWY2NZWejocFk8wgH1D1dKDrY4i/BYekEpMFPilmbyHdbDLzePPz8?=
 =?us-ascii?Q?esFh6LVs8OFSqMVVof3J/f4MeZYsQcf2pLPQx+OiBKJnrdQgi7S3QjuHS7Li?=
 =?us-ascii?Q?NhPc6Hi4DKPkgMdslAeej2M6+0ZSOlXXy/Vvb4YcnaP31ibKbeHMQHfCf00v?=
 =?us-ascii?Q?b9l3dZSBVAJx0a/prfGJjghHluKJ6QvK6IBRVnev1qxQ34gi0MU1NpHKg6nm?=
 =?us-ascii?Q?rnj2PBEMG+7MKhcg9wx7DepG6hgfoTSPPYEPx1ND9igCFl8Hjv0pnAoXE0OC?=
 =?us-ascii?Q?ZjCgZbswBN3eHjWKty6LFfzrO59Vq/rv97dZ9l/86Y2gLHhLyAus82HNYeHZ?=
 =?us-ascii?Q?CI7PQgqI5h3o0ygsUZIbl6XG7p1O5zKGu6Huvwqf7bPWc35JpKg10kd5bSyu?=
 =?us-ascii?Q?WbauuwhZ8EU0mahFNyR12L6a6BOBZuKbL1TK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:37:49.3096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d0d20-b1ae-4004-60ec-08ddaf25b822
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

From: Dragos Tatulea <dtatulea@nvidia.com>

Add initial infrastructure to create and destroy the PCIe Congestion
Event object if the object is supported.

The verb for the object creation function is "set" instead of
"create" because the function will accommodate the modify operation
as well in a subsequent patch.

The next patches will hook it up to the event handler and will add
actual functionality.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
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
index 65a73913b9a2..784050bbf7f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -921,6 +921,8 @@ struct mlx5e_priv {
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
index dca5ca51a470..c6c2139483e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -76,6 +76,7 @@
 #include "en/trap.h"
 #include "lib/devcom.h"
 #include "lib/sd.h"
+#include "en/pcie_cong_event.h"
 
 static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
 {
@@ -5988,6 +5989,7 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_init(priv);
 
+	mlx5e_pcie_cong_event_init(priv);
 	mlx5e_hv_vhca_stats_create(priv);
 	if (netdev->reg_state != NETREG_REGISTERED)
 		return;
@@ -6027,6 +6029,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 
 	mlx5e_nic_set_rx_mode(priv);
 
+	mlx5e_pcie_cong_event_cleanup(priv);
 	mlx5e_hv_vhca_stats_destroy(priv);
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_cleanup(priv);
-- 
2.34.1


