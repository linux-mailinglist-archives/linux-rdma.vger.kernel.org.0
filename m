Return-Path: <linux-rdma+bounces-12218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677CB077D2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42E350848C
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F92262815;
	Wed, 16 Jul 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+CpDV5K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875492594BD;
	Wed, 16 Jul 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675534; cv=fail; b=WDtb1XuCfSkERVQfcMvncJwI4YKPTLP/eg+3AgU1TQlYiLpYk/WCX4mqF6l5YYhcgOd5W0s5fSfvCa2Wy5T2K6+Mk8xlQdWHQ5Me6LOqilXo0aWSrqm0KrZ8MHUtcjCaW2hxJKJ5IbW9fTYpzUDnE4JC1LtvJuA956hJELEH6Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675534; c=relaxed/simple;
	bh=XbQQKIIEHmdUZ9lb6/K65v/ooHDrmKqYWDpDXSIQiXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2Zh3/5kXajZV5Ar7n5w7ict9Zu9K0zwh3erBFZErG9qSGqYM7o619KewttDf8GQtTL2pi8SOpW/FRvsblZKBlYgrgMD9mJubfGKrWLqptU6/QzPS/irAKRLuG4Ed2SCgitRB577dTFh9mzgPynK588Z0ALPJUsFUwLMvZbfZTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+CpDV5K; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEvzHd3atCQCoqmdOumAhpnaXmr1LSZFmeTI4PHnyalw/w9ZbmoWWw2K5bOlQ/errK+Fx2ZVpQYvo1AeEEEiOOrHV7dsCBIV7rYSMIeKsHdI3Bw6tjm0JOOJXUq/HwRpeskoJcM2Aa3k7D/UnjS89R/2hV1qUUjNNKw9qyAJsPG0bqrf7ZLXU/omNcqP4Ubky2BceXGel2W8X7EKsHwucdLklsJQLSGkbRfP7FAAH0RIM+1ngcdue05vgsVbrNpVyRwxhBkCSt2gRoBGv+u6Egg0lbCNoZQtXQlOhU6ec0ltg9r49Byj3hVPTgITCxAM5yLVpSmLIb187BPFlk6stw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUpsYweOjZVlrCNLac9Ejm0g91YNdZmQShx8GSSLpGI=;
 b=funJt4xbvf3fl7L+9y5Pgb3leZQAjUIUAsUcuWUyufzTT/JgH6hBip+wsEkO/+rSCfBLgw6/51yqopbu/uY064Q4o1y4Fl7EOmpBtEOo8jx4WjiyoTASH/LgjFgRjqImBaPoBBEIpoMiXJ5EiNItnTtWkPuRUz1dmvSKAF3ehvz7okycIsVjYi8YfJMLCrgf7mWqNonUWtdgYp4Eww0vKfQmD89q+Nro0uFWZ5fWrk2LsVfY7EnBqfSoqSnLY+8G8w137lHoET4SzECZMRxD5w8lohUVk5H37U0yq8kzZBER6kn/DQZGA3ig75Og2LY/YFjx7yVCl+KxKE3jcWy9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUpsYweOjZVlrCNLac9Ejm0g91YNdZmQShx8GSSLpGI=;
 b=R+CpDV5Kt5DveYzvipuEOKxTkpQSnke8JcanQlhRGRZQyI+/gctBAaLdH5G2YrchMKwqll7IVZjLrumImOzm5t7u/dFuPWEeNPu1d41RGEVqSzp1fukRymfvocHytIeFgcllwqC5+3QUhR1unt2DGR/lrCLOLz8hah4GNocexDEk8DQsPkOS9px91CWSU/9lmDmcEzEtABphoxptv5sa+nlia1iCGchi4YASD4XK3wujEqFInVJnO3H0pyRziOFd8qtEgcw3Hjy7jQ1p7tLN1tYiYfg4XAF8+o2WX/ERALqp1NSaEH5+uLHvHWNmMbgddUsdesE3Jo8xkPKTIJBPSA==
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 16 Jul
 2025 14:18:49 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::eb) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Wed,
 16 Jul 2025 14:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V2 4/6] net/mlx5e: SHAMPO, Cleanup reservation size formula
Date: Wed, 16 Jul 2025 17:17:50 +0300
Message-ID: <1752675472-201445-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
References: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac787ee-7f6c-4952-a299-08ddc473af20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?szO2Apf/LENJRpZ1Dsz8HxIS2PlGYikfTHblI1Nndl/uHLcagKIFvG+dKn9x?=
 =?us-ascii?Q?pv45x+wdXffg9YC1VJZmh6UoOkmHEzjqS33JHj0ybijxDHk77b16PmUyinOe?=
 =?us-ascii?Q?XxQR0QnWRCNbVnn63TYGrU0/aeLVl3vYlcaZE5jib5qOUlPOc3NgdlV+Rd/i?=
 =?us-ascii?Q?46VlUpn6XQOuBHhLLKfuQ1Bi4vKXcnAeCkNDT/iE2rrfbblJqHJBCZ5RRDd4?=
 =?us-ascii?Q?C5Gl9OwkQt9eIJU1KF85HeFPbVwBwfNLBBBpW6PXtV3mzujS5Ptg8agmWcTS?=
 =?us-ascii?Q?eNtXywKg/GQVyz53cox8lMST+WYyyuQ4c2YnEd+Q3MrGErKwuchiNyGvtKXn?=
 =?us-ascii?Q?Gc3uAdp6NQ8sgLii+EJkpN3V1ljsJPGPsvX1+72aJl578pXqtgMaztJhM8IA?=
 =?us-ascii?Q?YyltvVysk0sHTNnvFwiB9wrWzDY+W94VxAyVOTFi66dzAWTZm4GKbAsNMSBJ?=
 =?us-ascii?Q?cDNZvKHoRmHUsXbdvZMs28f/YFP0Yg9F0DSfVbUpw991csLz6OEc1pVaC/nG?=
 =?us-ascii?Q?jU3jRew9a8pY1ZCPD2/QxsQbQTeKDoybbBtTL920tRqQyxS/8oRKnAuibqiT?=
 =?us-ascii?Q?Ldog3ICKvM5OFhRxcMue+Xj/O6/FDFOh2DjoljL5XrsnSyQUDiB5ApsHbDbL?=
 =?us-ascii?Q?mM0YKiPGPym4dByUA95pFafSqzTraG/yWR7C4N3mbVr+32vwDak3L6hqIzdC?=
 =?us-ascii?Q?m90XGyKZj39B1AFvlife57PQOMD4zhP3GDKtH+/EWlYUsGv64Vh0ySTYCZkv?=
 =?us-ascii?Q?DJ8HGfC+aaPy9BDW9wAiV00W3Ck6H9gUAewdduHKG+/YpboOVZBink53Sqp1?=
 =?us-ascii?Q?OK2INfOpq0F8wlTBWbAF55cFZbVjSSiv8XfywoGcOgOn/yefD8ubIE7CAw3U?=
 =?us-ascii?Q?d1TIA0doR+5x7nVbh7T9++v5zJphFiOPFjutNsnf9+rqYKCCvthJUl4bnUrC?=
 =?us-ascii?Q?n3YUXQX2w9dWpQDcEmEHQEbaTRcuVqwIUqYCNUR4GaZFh+emZ0NRtBdJbasv?=
 =?us-ascii?Q?9h7y1VxSWy90atK/E590CurJVUos0Z1Iu0B/QaZ6N3TQy8oS4DyPOEwbgcbI?=
 =?us-ascii?Q?ScLfl6QMOnVEwlLdUnAv28E9JEHeh6qmfByrRSDy2flCwhyz/f8LdSIaQTMl?=
 =?us-ascii?Q?s8KW88suGOkX0ysE5kylaXQzHt7c6GK/HxlMbF7vzidjXjGB4pu2wpH+VHG6?=
 =?us-ascii?Q?bq+blObgEacOShqIFTuD2+inKLlPI9LOxqkz4Q2bSBUiiy75BhWUK5RhTW85?=
 =?us-ascii?Q?wvMIPFnIWop84IIPBkD2TcyW0fCt8EdPua8t4em+hXtTIrpR7AUY6Tzz1TAB?=
 =?us-ascii?Q?2AvqI6UjoGdYMgtuyuhsHGXqgql7HWosR91GGlCks5vY6NF5FC9B98Aht9+q?=
 =?us-ascii?Q?UYldNIdPwKyVyfj1IyJHHljCfvmECXUYJ9sDnuN8siAZbYCuuyCloyNrSEdZ?=
 =?us-ascii?Q?g1CVVEm5ITDCA4ZW16k4z59BuFUCtPzep37Mn8O37gN+mbg9izbuCC+atw+s?=
 =?us-ascii?Q?62yR+jwZ+oXoYYtF94YzQNLBMthREDOLXaUf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:49.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac787ee-7f6c-4952-a299-08ddc473af20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890

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
 .../ethernet/mellanox/mlx5/core/en/params.c   | 34 +++++++------------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  4 ---
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 64e69e616b1f..019bc6ca4455 100644
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
index fc945bce933a..b98973fe2f03 100644
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
+	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
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
+	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
 	int wqe_size = BIT(log_stride_sz) * num_strides;
+	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;
 	u32 hd_per_wqe;
 
 	/* Assumption: hd_per_wqe % 8 == 0. */
-	hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;
+	hd_per_wqe = (wqe_size / rsrv_size) * pkt_per_resv;
 	mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",
-		      __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
+		      __func__, hd_per_wqe, rsrv_size, wqe_size, pkt_per_resv);
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


