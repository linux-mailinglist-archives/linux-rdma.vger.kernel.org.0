Return-Path: <linux-rdma+bounces-12359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B86B0BD4C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268F61887467
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC368283CB8;
	Mon, 21 Jul 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3Qvc1kU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CB283C90;
	Mon, 21 Jul 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082048; cv=fail; b=bjqYyhv2Tl1Pk3D7XfATTJXZUA7GVs1JxTcVgOyrBS9gWpUAB865QgY7IXjU4d/v8iTD8X03WuSnlcR2vUpAGay8+lVcDiVzGf8sC9i94C+nv/IrIk3R9bqp3GwgZrjw00IA6wDvZdH7YLxLDglPEQwwMYH9TmhXJRwm6Ph5TiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082048; c=relaxed/simple;
	bh=x4Deyhk8G0S+1TsidAfVsguDSWOSVuEVJJuR4IcZvD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M674DnMrOT5KNLwhccKdtYt0o4gThArW8t2P7pWnv4aRSkqXicZHiQ+w/POpCl8mocROR80xAeIujFUV6C/uF5wMD8kh62CZSJpA+2QdFMCKMqjwVdeDI1Tgr9hdMckWqywmaXGKnr0E09u27HOW2SlXNA5NVM67tncPLw2kTjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3Qvc1kU; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpRNCuWJ1DK5SzGIfYIRl/mcpcgzA82aP9S34/0AB6E0XM1ezU1v5CjpHBhm6Gec8h6w/augoQE7Ri6qGf1O+JaU3d5pq0gABD2Fm2ozbrgCzxukrFhjZTmlZdf8Eu01Qr51Uwj9aXKuNSh48hxuO1X++tKqsauIsxUXlmYL0zFPDyCTRX07xYIHfpJ6cnONJVL7zn4KqGvj6vLnGwWy4CZbUnb7iM/U0jSVb7kkeSkAglfVM0UjdpfEVBN1UwWCVEdgEJLJehZHG+bsDIL1mUVvJeAlq6pOQquOf9hTWmevY++Vb9bwNpKSGdgEn0U1SoBuRfKnwRxSIs8RGv+XjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LGKilvQOqwjsbfSg9rBn5hMOGvgrpc0UHFDcxdURTs=;
 b=FqIKQQT64lIo7nieklfrTv/BLnSfnYPNg5wKQmDTpnbkYPFTClF120mGH+7O3yiuyDhTA0+7yXykrDswVPDkZFd4Z84Wi8S7mkbCAKFVhKpG56O/AVqiqvU/mq8svboAfobqDF77fWQmxRuuZAtMUSskQ1NyjjFFKqjmuDrqFdiXamMt+B/4HA0Xuaw7r/23XKRqMdpHJtUPNdEQ4YGniYElniIOhFdFSeA5rlx4vqNH2U2eZesEES6E/oQtX6ynxRwgIotAeY0DD9wFR4rWg/dVIhlscCwKMed9BNJrHgnmGtsNUUpSFPOGKi1RRydd7KWmas1CIjBLWxcPVv6WyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LGKilvQOqwjsbfSg9rBn5hMOGvgrpc0UHFDcxdURTs=;
 b=m3Qvc1kU/SUUkGExUt3R3xDyjDn+pAMfRaYvJxW07RtOdV2/KyfclciSZwpTqj2CHZF7RueHWdlgYaG86ORuJHiubYzwbqh3jGa1bTeZuMPw+KyEl82dp0g13DoyJC3/cSUq5+1GPsPc+vxnxd3m05PZCoFxr6q5GJHH4TXNBK7dxMBBA+79kpoVuKMdiujb8FEQbO9vQXI1Kum/UbyKe1gQBJJeNpgLnTxqBUzpcMxOpjhJFPnK4YGX7F4UrxrfzkBG9MTfOP3r1N0jzjJQqfKCQsmlPI/5vQ/nHTlvBAucZYtF65/ywaTvoqhWSbaHuKf7JE+zEIzCtmF1v0yfUw==
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 07:14:02 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a3) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Mon,
 21 Jul 2025 07:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 07:14:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 00:13:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 00:13:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 00:13:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V3 1/3] net/mlx5e: SHAMPO, Cleanup reservation size formula
Date: Mon, 21 Jul 2025 10:13:17 +0300
Message-ID: <1753081999-326247-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d921274-e6c3-4d9f-159e-08ddc8262b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SxeBQcFTuhKJrn64kxV0pnaj7tuq8VKVW6hu4Ud6nvE+bgMkv3UeQSYkG9r9?=
 =?us-ascii?Q?MzIjGpI7nkaNboufX6pIJl/6GXpq+w/MouShygxREyLwKh7+ABUI7tFTeoPd?=
 =?us-ascii?Q?txSMokLuCHVEiG+Tcm7h9aMd3E5qyh4lqc1pmCuiUarMlFkBIzFmDbYlNfgK?=
 =?us-ascii?Q?CjBavwZ75Mnf9Y7Q3E8o0/OBvVWgzFNw/LxrjSKmDDC3SmkXiV42ewYJMkjB?=
 =?us-ascii?Q?cAk7q0chvgkGVarLIMc8xO7h9hpzuE61vUZPa60NCZhw0dwesm3QoYhcOIIP?=
 =?us-ascii?Q?lL4n8X16ffbIdEBGOBrIEfoZnqdi73Yj0h3jY18o8K0tiCW+yGgdifEasxCC?=
 =?us-ascii?Q?sQA30H3FHw+y8VA2SPWhJdTEBnXqcMjnep05SPRuQWrXfKzOQNUukFOIlelg?=
 =?us-ascii?Q?S3ZT2bQScgcvfUMtoMygoQWn7uUD6tWSgzFow0zodn+bIBp40ihjQYMajHiM?=
 =?us-ascii?Q?yXhW4A+E0k5vblc2PVbu37o05GmSIBUfQ7OVcZrXcX7Lel2BiSmvlUwEW6gT?=
 =?us-ascii?Q?zjiYDdxj32/lV3nIoO9IERmosyIXKV1zFanT7WREgxE7/+Et7GTJLVgJfGHx?=
 =?us-ascii?Q?McLfOOad9WjSwil4WAVyS8q90PHxJ8bZPEmQCu8mibQbew23G+VLdVUnSR0r?=
 =?us-ascii?Q?vOJUfn1QjGlbT7By4RPrkXfYdkfGrT4klQoGH8Tq9mkGZoajjFCqqSLJKKK/?=
 =?us-ascii?Q?FxB8Q9S0aKHasHv4vqybxobgWoz7nwdgBCLG3Tt6cJNDB6ljtjQDS8TAfnaJ?=
 =?us-ascii?Q?NDtOr3FESJcCVfe9Obfv/snCQ2L0s4x4Yp2MdCNmWwaziHG5MsTIYXN8i2lH?=
 =?us-ascii?Q?Smlj0k2k0JTqAbrvtiFiSHPyxu1lYOOU3ub3LJuL+O9oaOjyJSW+aagru2Ga?=
 =?us-ascii?Q?ycJU83tw5JXF6fPuMmJ/YYXmf039cfISbWIIxiNaiaoQcMDi34qi3/5BQT6b?=
 =?us-ascii?Q?uADsmhJNuGaebE4+qjhs/frbDUkyfsAa7xCqyR27UGH3dqWkyfxEpQJ6Ew6y?=
 =?us-ascii?Q?daY6AIN4n1ToUKvGQqHf/Dug0J2RKG/SS1lq/+k3FDAt2u7Tpp6LIr2rNffC?=
 =?us-ascii?Q?26eMsFvfGDVvFj1LA8ABWk8B6GMNGKuquKwdqmtzDfAZxx5M7LNQi67gxCbM?=
 =?us-ascii?Q?UFKCyLBdb3AQ+ul2C3ZMc+Qy/5ek1x7ysRHMH4UwOKWpLbEwjgAdor798Xz7?=
 =?us-ascii?Q?CE/sw7Ob6JRSIW0WCY8A4LjP3JUAyzd9o/ab2L5mMs4oOUE5HV9M7kpuFXWv?=
 =?us-ascii?Q?kouVQmtJll/x1YPhVuCliZbaZcEiFzqvlAi9s3GALsQV8/9BAgS90KyctjuM?=
 =?us-ascii?Q?vBbR0MPaFNocfPZCoSB9NsERcGpdQziYYIOFJZGrRqSOxe7IKYC1uY6N38Q4?=
 =?us-ascii?Q?B1f2JN4MQcFR7NTEnpZCqZwdqE+OeRq/GEkhQJ++lB3jq6gKjU53mRQduKuR?=
 =?us-ascii?Q?RBXk9XMK47cEjPkaKJcf2xcSJ7B9uMIVOnlx0O2I7OTcGdjGXzJsgG9e1A3U?=
 =?us-ascii?Q?7ld5lARvllFsHmvVJGskdCgCxmnUwlxLSehu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:14:02.2113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d921274-e6c3-4d9f-159e-08ddc8262b9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

From: Lama Kayal <lkayal@nvidia.com>

The reservation size formula can be reduced to a simple evaluation of
MLX5E_SHAMPO_WQ_RESRV_SIZE. This leaves mlx5e_shampo_get_log_rsrv_size()
with one single use, which can be replaced with a macro for simplicity.

Also, function mlx5e_shampo_get_log_rsrv_size() is used only throughout
params.c, make it static.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  5 +--
 .../ethernet/mellanox/mlx5/core/en/params.c   | 36 +++++++------------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  4 ---
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b6340e9453c0..b25147442c92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -85,8 +85,9 @@ struct page_pool;
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
-#define MLX5E_SHAMPO_WQ_RESRV_SIZE (64 * 1024)
-#define MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE (4096)
+#define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
+#define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
+#define MLX5E_SHAMPO_WQ_RESRV_SIZE BIT(MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE)
 
 #define MLX5_MPWRQ_MIN_LOG_STRIDE_SZ(mdev) \
 	(6 + MLX5_CAP_GEN(mdev, cache_line_128byte)) /* HW restriction */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index fc945bce933a..86f6147de22b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -420,19 +420,10 @@ u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
 	return order_base_2(DIV_ROUND_UP(MLX5E_RX_MAX_HEAD, MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE));
 }
 
-u8 mlx5e_shampo_get_log_rsrv_size(struct mlx5_core_dev *mdev,
-				  struct mlx5e_params *params)
+static u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5e_params *params)
 {
-	return order_base_2(MLX5E_SHAMPO_WQ_RESRV_SIZE / MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE);
-}
-
-u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
-				     struct mlx5e_params *params)
-{
-	u32 resrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-			 MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
-
-	return order_base_2(DIV_ROUND_UP(resrv_size, params->sw_mtu));
+	return order_base_2(DIV_ROUND_UP(MLX5E_SHAMPO_WQ_RESRV_SIZE,
+					 params->sw_mtu));
 }
 
 u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
@@ -834,13 +825,12 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
 					struct mlx5e_xsk_param *xsk)
 {
-	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
-	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
+	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
 	int wq_size = BIT(mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
 	int wqe_size = BIT(log_stride_sz) * num_strides;
+	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;
 
 	/* +1 is for the case that the pkt_per_rsrv dont consume the reservation
 	 * so we get a filler cqe for the rest of the reservation.
@@ -932,10 +922,11 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 
 		MLX5_SET(wq, wq, shampo_enable, true);
 		MLX5_SET(wq, wq, log_reservation_size,
-			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+			 MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE -
+			 MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT);
 		MLX5_SET(wq, wq,
 			 log_max_num_of_packets_per_reservation,
-			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
 		MLX5_SET(wq, wq, log_headers_entry_size,
 			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
 		lro_timeout =
@@ -1048,18 +1039,17 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param)
 {
-	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
-	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
+	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
 	int wqe_size = BIT(log_stride_sz) * num_strides;
+	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;
 	u32 hd_per_wqe;
 
 	/* Assumption: hd_per_wqe % 8 == 0. */
-	hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;
-	mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",
-		      __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
+	hd_per_wqe = (wqe_size / rsrv_size) * pkt_per_rsrv;
+	mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_rsrv = %d\n",
+		      __func__, hd_per_wqe, rsrv_size, wqe_size, pkt_per_rsrv);
 	return hd_per_wqe;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index bd5877acc5b1..919895f64dcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -97,10 +97,6 @@ u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 			       struct mlx5e_xsk_param *xsk);
 u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
 				      struct mlx5e_params *params);
-u8 mlx5e_shampo_get_log_rsrv_size(struct mlx5_core_dev *mdev,
-				  struct mlx5e_params *params);
-u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
-				     struct mlx5e_params *params);
 u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param);
-- 
2.31.1


