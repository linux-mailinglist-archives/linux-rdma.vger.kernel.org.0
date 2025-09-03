Return-Path: <linux-rdma+bounces-13064-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2243CB4169D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6487E1BA2296
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 07:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0186C2DE718;
	Wed,  3 Sep 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tp0ytZXZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62BD2D9EE3;
	Wed,  3 Sep 2025 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884675; cv=fail; b=ncD/jd7lq///aaoI+hQ1LSm1vAomGbiEm+oc37OndU/SbFvH5HkIO0zzUEzWkeY48pF+zpkfLaYn6VfkUgcApqK8qDnZEqh3o4ydGJL6FXG+RTyP/yvJlnZcd62LwGYzVc2zGg9+cEPKEnrzMtRsQRAuamITbeZajI71ohi70oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884675; c=relaxed/simple;
	bh=DK+iGObVyB+ZWztwez8BjOQ+5a8kECRHuKuq4eYhfTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Acth4Fappcnfb9fHvEZjzarrSheN/BBwATiMVqWSSjRAcwLYojnd76Km8Fxisqewoqi5prKfsib05HCw2hESvS07k3PE7jjy8Ggii4uUwNJrPHKIfUdsV0zl+W2kKtEHJJ4zV9DYWgtof8Fr6+gersgz93YG3uOxzsD+nFHC3ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tp0ytZXZ; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQXpspx5t9P9Kvj2tiDa9w63qsRW7k5+lQOFE/3OIR+QZNq6AIQrEN2pJ1I3lXRr10yVwH3vMgXFLJkQSH2vqTG9CACRmiyfHWwnWiUK9XL80Dqj7UNv0P93qkebW5+vi9EgWSXnNDE5fzV/h2oXuRhAXaZ+GD4yhnnMdR9/v6Ec7pJW6RDC6VP7Yf8iD/+5AiAOLNJ5zC6JaIgdylecx4iFvA9Yv5qy7K+JTnBvLgrsZQSch8T1QIaZe2zT9X88AlPpEY7Ac82412nEteVTHWQi+eAmfGd4LfpLh7Jwc9laSBGFExlvLpOX1iM2VbxmK3ivEq/Rn3eljupOibj1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIsvNZOm4WDM7Z2zLd2Y0lDckU/0fZJmV8ZW9ghcE50=;
 b=Oq/6pusSA4mxweZSPrX1UnokVH5T6rc+kpGXGBiuPylA3rO/h3zLd5yDAA4frZkidLwX+76PmiDmMh8o7iulojtZV8An2EaH96Ezc2VW61NNTGOaKnB4dp+EutO92EPO9jh6TUgX8QzkYvG7nxGSjcBRiEjCWbn6bDVbNh1WXJQ3LkkqGbGPvh2wjY1D7gY77MFQRtKPYtPAyii2C3jeoPjrvVsRe/gV5xuITVs9DEBur7OpxY6aQ7vrH6boFSV8JGzoGbIHDkID0lzKBoXxk1G03b5E+5Cc1Q8ulRkaDznobVP2pfudUOjHIg+MGPk1x0EqmAc5XpT727haYCjLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIsvNZOm4WDM7Z2zLd2Y0lDckU/0fZJmV8ZW9ghcE50=;
 b=Tp0ytZXZVb2VX+//IhffUWvya2abwBYAo7PhDTLA5fvZIh/8Ij95h8oMpucJZEatGq0teQKWQ/P4wUUYEobIeWyUdrJIIdYfaT5N79YHhpfIyNWhbF0YDIPavb13GtGYiKfZ2GvalnStCWSwN2qKSnhBjH3lW79DpaTZ5s/3QKcYeixQ7NhCUhqzGkQroSY2X/v5cW4HxVG7G6gSo2CV1JrsTKV4kttoqnrFqy4RkXlACjkhYB4nxBWzmqKTJyXa+7TeSHHU/BAQJ83jgZe94F5eOhNV23zNFVHKsOva8+ezL6X4H9cTOPdnIDr62OeG4Xr/ye2az26kPGpn+A8WCA==
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 LV8PR12MB9692.namprd12.prod.outlook.com (2603:10b6:408:295::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 07:31:08 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::88) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 07:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 07:31:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 3 Sep
 2025 00:30:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 3 Sep
 2025 00:30:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 3 Sep
 2025 00:30:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>
Subject: [PATCH mlx5-next] net/mlx5: Add RS FEC histogram infrastructure
Date: Wed, 3 Sep 2025 10:30:00 +0300
Message-ID: <1756884600-520195-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|LV8PR12MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: a5437311-f15e-420f-32ae-08ddeabbd905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jFFpAODDaOiaiKK+nvATXh0+tYvsQ/evHnXNMkysRa2/C2QEXnjZxv7Zlffb?=
 =?us-ascii?Q?/DXwNeISJssDs+PT0oiR77eDcwBRuiIgKV1OO1j3w2cBT8ihw1ebMHom5ycc?=
 =?us-ascii?Q?Syi4lWrzkBB6QMc9hgmuS/JcAWvxvW99CkXok8apAi3Nt9QgP3dMUJS4H1JN?=
 =?us-ascii?Q?rNbNH97aGNNJIgMElcIp8QLvbXdpymscZC37uJc8ykZAlv1RiH/DpW5Ua4K2?=
 =?us-ascii?Q?hb6QU58QFkimi357l/9FWq50dlLfe7y4vuFQFIjNaNBge664dcZjkeaTi5WM?=
 =?us-ascii?Q?OGfXG2WYF6CfsnZVjETeChjsER3hkscqIsYRjQ+W18Xd0XPKLZr6DowhWR/h?=
 =?us-ascii?Q?2i+uk8VKcAhs0FcJGKOBnCN6lMcaT18WGC9aaX2ZhRbSitXAigJyJ7dP+0Zj?=
 =?us-ascii?Q?/r88jLLit5pnMk3kDRbyLdXY9vt3frW7PDGImK4xFvSmJeLGa65e9kFHANCl?=
 =?us-ascii?Q?gHKsmo5qP/MRhjrAdTIWYB9V84CIUH0lCenHc3FZeGWw29yNSVXnr3VUmjE9?=
 =?us-ascii?Q?TdHPDENT/snSaZATvJb4iHq4OF5DZMNA+RVxBAdsuthV8jrcrryylZmu1T6I?=
 =?us-ascii?Q?RVFxZA0wZy+K1blv08yCRWxaWYPURZhi+3PWvf5EbvSnDSSpmajUio7r6YQT?=
 =?us-ascii?Q?Yrty2eVqvqFYSvBvDRjYww5s0/eZeIWR30Y9CclsIH1NiUQWk0mT4i4BBQm5?=
 =?us-ascii?Q?BW2yenjHbAhjLsz4crFYsdeIz4G9sM6L/G2O4mPhSnwaSHTWaoMYlp2DI/32?=
 =?us-ascii?Q?Se/GuBspF/wDu/sGlX/13MocTP5R71SuaoYn6t6TE32qMjLc5C+xYeI7kSHf?=
 =?us-ascii?Q?BJzLMDvW/t6NKjicliRMGMHd4Qd4WmD9AdMNfTd44ekV+ZxGIC2PSnIvYEjk?=
 =?us-ascii?Q?l8Coe2kdImVMWEIyhYPjc54T9Sk8T0efCBlK2XhUVcT6Q08+kLGtx6nWOksz?=
 =?us-ascii?Q?MvbBha5Rb7ivPRdF9KLxDZzGFGAkxSx2jl0CPANr3MBT6AA6Mk8kDpFgfRcb?=
 =?us-ascii?Q?ql8IH/NA9t6ohqRk70KFsWykyNF9Q+nGkUQKsFpMstvUWGCkNWnYQx8Hfkmm?=
 =?us-ascii?Q?qwa3uusOg+2xijzbniJlQEDeixWfobK8Uim1mvU7+TGEwgAAEZbCgnz8jJAy?=
 =?us-ascii?Q?xFh8QeZ6cy0wfgR8kG668N9mQEh3NXdGk5oUNbnbuMdKBWEwXsk3i5wCVan4?=
 =?us-ascii?Q?DkmCsVyvJjPDoQTMxG9HXezQy35uk7f8BjjbVGW7uvElzOWcCAbXx3tYPmjR?=
 =?us-ascii?Q?NOK9tHmQRHH85fFcx37Bs6YpO3kMJ7ZxEz8kfFVZmbYULmfB5cweHJp0D+sd?=
 =?us-ascii?Q?u/GFe/DgC1P1yMiGB3fOEWSG5Veyyzu2jCR/TSOXgSkzR3v+tXpi/sMpKLeX?=
 =?us-ascii?Q?yemhbzEAz1epzQmetEpbgK57LoJJ4MzfDIpCkzhzN9G0L3oGmAU6CoSgMD0v?=
 =?us-ascii?Q?NM9Nmqqj6vRzkbvXiATBTek+AGxwqedH9iq8fLda/nhvuwK1Ss3wLAJo2s/N?=
 =?us-ascii?Q?6WTIlrBlmlLGCvgyZ7Cxk0vlAn+R9BdbTBdA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:31:07.5858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5437311-f15e-420f-32ae-08ddeabbd905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9692

From: Carolina Jubran <cjubran@nvidia.com>

Define the Ports Phy Histogram Configuration Register (PPHCR) to expose
RS-FEC histogram bin ranges, and expose a new counter group in the Ports
Performance Counters Register (PPCNT) to report the corresponding
histogram values.

Co-developed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/device.h   |  1 +
 include/linux/mlx5/driver.h   |  1 +
 include/linux/mlx5/mlx5_ifc.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 72a83666e67f..d7f46a8fbfa1 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1525,6 +1525,7 @@ enum {
 	MLX5_PHYSICAL_LAYER_RECOVERY_GROUP    = 0x1a,
 	MLX5_INFINIBAND_PORT_COUNTERS_GROUP   = 0x20,
 	MLX5_INFINIBAND_EXTENDED_PORT_COUNTERS_GROUP = 0x21,
+	MLX5_RS_FEC_HISTOGRAM_GROUP = 0x23,
 };
 
 enum {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8c5fbfb85749..c0858af0e854 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -130,6 +130,7 @@ enum {
 	MLX5_REG_PDDR		 = 0x5031,
 	MLX5_REG_PMLP		 = 0x5002,
 	MLX5_REG_PPLM		 = 0x5023,
+	MLX5_REG_PPHCR		 = 0x503E,
 	MLX5_REG_PCAM		 = 0x507f,
 	MLX5_REG_NODE_DESC	 = 0x6001,
 	MLX5_REG_HOST_ENDIANNESS = 0x7004,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index e9f14a0c7f4f..097b1b7ada63 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -4901,6 +4901,11 @@ union mlx5_ifc_field_select_802_1_r_roce_auto_bits {
 	u8         reserved_at_0[0x20];
 };
 
+struct mlx5_ifc_rs_histogram_cntrs_bits {
+	u8         hist[16][0x40];
+	u8         reserved_at_400[0x2c0];
+};
+
 union mlx5_ifc_eth_cntrs_grp_data_layout_auto_bits {
 	struct mlx5_ifc_eth_802_3_cntrs_grp_data_layout_bits eth_802_3_cntrs_grp_data_layout;
 	struct mlx5_ifc_eth_2863_cntrs_grp_data_layout_bits eth_2863_cntrs_grp_data_layout;
@@ -4915,6 +4920,7 @@ union mlx5_ifc_eth_cntrs_grp_data_layout_auto_bits {
 	struct mlx5_ifc_phys_layer_cntrs_bits phys_layer_cntrs;
 	struct mlx5_ifc_phys_layer_statistical_cntrs_bits phys_layer_statistical_cntrs;
 	struct mlx5_ifc_phys_layer_recovery_cntrs_bits phys_layer_recovery_cntrs;
+	struct mlx5_ifc_rs_histogram_cntrs_bits rs_histogram_cntrs;
 	u8         reserved_at_0[0x7c0];
 };
 
@@ -11738,6 +11744,28 @@ struct mlx5_ifc_mtctr_reg_bits {
 	u8         second_clock_timestamp[0x40];
 };
 
+struct mlx5_ifc_bin_range_layout_bits {
+	u8         reserved_at_0[0xa];
+	u8         high_val[0x6];
+	u8         reserved_at_10[0xa];
+	u8         low_val[0x6];
+};
+
+struct mlx5_ifc_pphcr_reg_bits {
+	u8         active_hist_type[0x4];
+	u8         reserved_at_4[0x4];
+	u8         local_port[0x8];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x8];
+	u8         num_of_bins[0x8];
+	u8         reserved_at_30[0x10];
+
+	u8         reserved_at_40[0x40];
+
+	struct mlx5_ifc_bin_range_layout_bits bin_range[16];
+};
+
 union mlx5_ifc_ports_control_registers_document_bits {
 	struct mlx5_ifc_bufferx_reg_bits bufferx_reg;
 	struct mlx5_ifc_eth_2819_cntrs_grp_data_layout_bits eth_2819_cntrs_grp_data_layout;
@@ -11804,6 +11832,7 @@ union mlx5_ifc_ports_control_registers_document_bits {
 	struct mlx5_ifc_mtmp_reg_bits mtmp_reg;
 	struct mlx5_ifc_mtptm_reg_bits mtptm_reg;
 	struct mlx5_ifc_mtctr_reg_bits mtctr_reg;
+	struct mlx5_ifc_pphcr_reg_bits pphcr_reg;
 	u8         reserved_at_0[0x60e0];
 };
 

base-commit: 04a3134f88a4bd03001a3093144819523cfca99e
-- 
2.31.1


