Return-Path: <linux-rdma+bounces-12360-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAB5B0BD4B
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08DC3BD671
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A5D283FE5;
	Mon, 21 Jul 2025 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J2U5yvjV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79C27F006;
	Mon, 21 Jul 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082049; cv=fail; b=YaD01Wy9w4WijYaWjf5MeG04+nAbDpdphudtxxAoWzpguJx1k2wMNLbsb26CIWfi0HDRzs7bw9IZGcGJI9hsazerL1a35RpC/DXmb0Ti/Px9Yv+oVmfdL436AGKEJgRJows1NHcfxkoScIuBCCCNNWr2YwDgRgu39r+JWqeJJOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082049; c=relaxed/simple;
	bh=xqiFslgWNeLLxjvXiEuowlFFIr0k6O2tHtcf/QbGbNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPVmsYMZ98j40ulq99FS9gCfCxfy5TBuildvpchT7aOKuPgYnFXRhdwWaDpiv5nLaFjJYEgKD6qdqq/9j1QrAYDbI1AKsuGU2iJw8qnP9w5B5OD/cl4z8OGY146fLz/iLRlIa3Y/2d6/OeIOgqql60/9doSmNIcp4C2sauxxN3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J2U5yvjV; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JL2hrauE4Y5FHDi4RT/qU962iXqr21c/UAjzxsQAhudGs76cUsXL7+DhSzwfbUmyvp5pXRChE/k9k1uVr0wn8ihvDHNUOXlHfNYoJVYwlZjLu9gWi2nRMERkdxflW0FdEGSzfEj3ROIdo7Qxo98X2WK/yhCXIN/Syq0o7XB20EJZWw9fT3LpPJf7YBIsXuMlHXqNlEzz1s9r0hjGTsJUXlHW5Ue4qsfBQB2lCoyw21+4EtIP6b+T9yIGiOYqTCEmLSLj0PjtBtU2FeaKZBEZEDt9iLb6SEKOegon6HuTZQWtBBq+yrSKpp7Ho6yY7ro8Pxqkuw3D9EI8OPLMRo0Csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcobcUzE6+GNbbv4jflK511moO00MeqsQ0+Kfm+7BPA=;
 b=IF1GZao7MMJMxWQO/U4hTSdbVGkYgk7P/GLb8yRVIZ8Rfz5pNPrOQ8MEfIzLL/mv4jx7+rQKCOpo3d4Weq2kfQyhkU6kglWjrDgLpz6nTSPV08M0l3rzOAK6kVz9GeryTc9JQQxdAO+dp14d/aXIScuKZyccMrrMW9zScItB006ZzmpqZSZR+xOHKqcnk3bRlzIns4nhSl9GwFgHhZoMLf05l3NUaAs4VvxpAD1u8vFJA6l0a57PmtQfGItwsTewvsa/A0xzgNDn7kVUCVlwJmztAKaEzuKMHBo9ljwlvr6hlo3zUJd6PiOLFIzoEcsdAEgEU4bey8bXFwKCoVbI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcobcUzE6+GNbbv4jflK511moO00MeqsQ0+Kfm+7BPA=;
 b=J2U5yvjVIrEX9+IRK2TOX0Tib+pXO0pWG02kXmkIENFPSImWvhmC7qjJuMcSUE5SAG09FpdoQppWcwJ6jkgehg+QaAHFi+6Dn7OLdBNTOr4OHzZbBZl6G8IfNGnLzQKF+IQ+FkBEhAJFx84n1yRrbaeWDfKXkLIrX0l8Ms5YUvLHk+G3mYl7/OaA/gCj7Rd5vkvbv///zHnVcY+pGG+wXN5lZq0ZRccTrE8eI1encZW0r/XjGbeM0y0h6+n8YRzdOjPB68rdoChdx69iIGWy/GL/Art/w2GqywlXRPuxDXrxHvM5jEgDFfbct8ciQhi8SQNQbaUks0Zt+IM62532Qg==
Received: from SJ0PR03CA0349.namprd03.prod.outlook.com (2603:10b6:a03:39c::24)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 07:14:04 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::fd) by SJ0PR03CA0349.outlook.office365.com
 (2603:10b6:a03:39c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 07:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 07:14:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 00:13:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 00:13:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 00:13:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V3 2/3] net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
Date: Mon, 21 Jul 2025 10:13:18 +0300
Message-ID: <1753081999-326247-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d635e67-c097-4505-d111-08ddc8262d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIA0Y/mA+b6sMOo37kca/lwZU3CCelk9BUvgxHQmRRNGuYmjQo+bUU7isQe+?=
 =?us-ascii?Q?r9vMuR5mYHSnJXfoIz2QZGE00BR3HMzsA6oqiB5S2mQx5JQisLfCGgAc0WYY?=
 =?us-ascii?Q?K+cHaKLZdoQPpS6OWm7E0URtknNRneZvtZi5swnloz5KfQrEQo53azhvRolB?=
 =?us-ascii?Q?ArprgS8zLI2+dVvcHxChk5JMp09YCZVYmrD3Tpnye4ye/0Qx/CNqUYgFXuo7?=
 =?us-ascii?Q?4OvaMGJqLsmito1SCgvDSn0aWGSvnkN4z1KQAe0sVZRuf8GXGLt04Mg6pD10?=
 =?us-ascii?Q?7+hCeolxR3O7p8TgmFB0Ryi2BO3fKHZJ22JVcX8FgZu4clwBcN4afLCyvlh2?=
 =?us-ascii?Q?O1DZ7+oiBJ+AJ9vhv/O9lNXY0d4FyLdPu7KTpSb2gYqJkenyWKUJaD/xnmsF?=
 =?us-ascii?Q?1KpeV6ypJGHANLQIq0GrbltBXzcfcFqInhfJ1RkvEZiUHon8Xr5H/wF7CYyL?=
 =?us-ascii?Q?XRigYC+GVfKOHMxToiyqvZzhQivwraB6kWxH7Pd5Kyk5EXQHJlp7401aYvI0?=
 =?us-ascii?Q?8usRt/Qshf5R9kpIqGNF2YbvQkflv7Qneqo98xuJmMSJd9o4nrjfHIukMn+p?=
 =?us-ascii?Q?/jD5huXaUmQsiMifHU3/DGp3PYHEm3ltjKM98SgQU65v8FEkmWGIZfKM5h9O?=
 =?us-ascii?Q?PLGwCS9YUcb0Fn+K5wi4BqeDsKVbaesUftNQDQk2pg1pXubTlhtNwxPondAi?=
 =?us-ascii?Q?KkhgsbB7VwkNh/kXAiI5JdThFJvuO06ISTFlzAkDL7BkU3QVtKm/6m7HHtZs?=
 =?us-ascii?Q?Ydi0uFB/KoSJp+o/Uv8FLfKLDQwUj/gQV0NwlSpNQRaa6D+psQjYXKkssHCB?=
 =?us-ascii?Q?4aCXHGqREPesJ/szNgTJmmyKk2q5eKw8kswQ96f96d/lGjTFfFEPfsG2d7jK?=
 =?us-ascii?Q?oz9EfeSQZXla24rFoHKBXar5W5ePAGkXjC92ebTTpXZ6GkOJiaujc1P2fAqK?=
 =?us-ascii?Q?DSuQ1uxyPa1U77fXRQPm84KUkdAhEGfrr47uu8w0xGen8G/0V3OFIryP5+LQ?=
 =?us-ascii?Q?/PHCqjsiA3zq4BPIwCAOUyvmcsHZeMC51+XjL+S2e4siVltqFC9DL3fEamQV?=
 =?us-ascii?Q?3FPSrEVfSAsJXnFW64KeZfnL5Hp/7TrPItnnXyo+2awqigYSwHRF5/McRi1z?=
 =?us-ascii?Q?5rtHGByAgOxPFQZV+op0So+1+A0tGCeqtKlw6RphfELyKu9cUg44U1gqUjN+?=
 =?us-ascii?Q?iS27zIyjVzR6tndPuifYkGk1U81TiSFyer5MGo6tidpqN5EtJEZaTTZ7jdcI?=
 =?us-ascii?Q?p5FQ7GGMygqCb1BmzGuDJweciGLcr/NVgvrgl3pxt69PYY4WXDBP7Oixwfdk?=
 =?us-ascii?Q?DMY6fhdwDDb/OIm4k3UImVntIhVj+noPFdv68bTrFzD6OKg2TbLaCSmHoLl0?=
 =?us-ascii?Q?501cfWcgkfG+Rdw/E/rTqfi7EStHGh3ihtbcgWye3zba/aQnj5IsHR9ElgO+?=
 =?us-ascii?Q?nwvMWmpFcgJBvaYWBQIedLYhmDTA+aKlqua1yqAUAL94lRXAlOOTnBz8RKod?=
 =?us-ascii?Q?fj8U7oBwAPXin/EwTkOgl44d+qX+4xzfLZD4?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:14:04.8213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d635e67-c097-4505-d111-08ddc8262d30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

From: Lama Kayal <lkayal@nvidia.com>

Refactor mlx5e_shampo_get_log_hd_entry_size() as macro, for more
simplicity.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 9 ++-------
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h | 2 --
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index b25147442c92..558fad0b7e48 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -84,7 +84,7 @@ struct page_pool;
 #define MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE (9)
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
-#define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
+#define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT (6)
 #define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
 #define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
 #define MLX5E_SHAMPO_WQ_RESRV_SIZE BIT(MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 86f6147de22b..3cca06a74cf9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -414,12 +414,6 @@ u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 	return params->log_rq_mtu_frames - log_pkts_per_wqe;
 }
 
-u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
-				      struct mlx5e_params *params)
-{
-	return order_base_2(DIV_ROUND_UP(MLX5E_RX_MAX_HEAD, MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE));
-}
-
 static u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5e_params *params)
 {
 	return order_base_2(DIV_ROUND_UP(MLX5E_SHAMPO_WQ_RESRV_SIZE,
@@ -928,7 +922,8 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			 log_max_num_of_packets_per_reservation,
 			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
 		MLX5_SET(wq, wq, log_headers_entry_size,
-			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+			 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE -
+			 MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT);
 		lro_timeout =
 			mlx5e_choose_lro_timeout(mdev,
 						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 919895f64dcd..488ccdbc1e2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -95,8 +95,6 @@ bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 			       struct mlx5e_params *params,
 			       struct mlx5e_xsk_param *xsk);
-u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
-				      struct mlx5e_params *params);
 u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param);
-- 
2.31.1


