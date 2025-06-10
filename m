Return-Path: <linux-rdma+bounces-11142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4DAD3C5D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DAE7B1BA5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55712238C0D;
	Tue, 10 Jun 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VONMEJym"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002D238178;
	Tue, 10 Jun 2025 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568284; cv=fail; b=HccxlhDsz/JeQYKGFdUNw2KhkM53gt12GfVEEUtKPmRF6U+iV5dx1g4UOXaTXZ9siNFSmkej7ZGEENNmFU4ywx8a5X09kl2p/5IEsc2trX2/gxL9mmt/CS+aqbrV0PWDPY7RCo/q9MnXOx4b5Ewv3gUm/Z39/b+qdthhKklT4YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568284; c=relaxed/simple;
	bh=ZKP5AowOc91bfxJMYUruwyj4KjjnoRH/G5O+SG8VUW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csZ4Tw9MHgUCoN59CWOYnSo3PfBxONI9YrEcETvfV9x8vrHrhzAVj4UFSVn3Z7O7yQ3oDhwfhCyws3BCQPCDj5U6hB/r5+8Fo4woAYulF/8J/5Fu9otARS3rasCD669tco0Bj7bGIfnQ+LtkD0Vj38CTz0XSRLAPvS+p/LSHzRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VONMEJym; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRk3IFNOo+3cjMGF+Z+2/YcVSXSlqiVkWlLXrrAw1IPw2YGIalsnbsDr2q0sny7TPk8LYk4EUbttiNAwThtJkq4Fa6epScmNaRWRiDrfXUxmNMnIlnbPObKa1/rkH8iz30j4HGxcF63DwLUnOyqa3nNGayw15iHnhYNEZcqzz0jMV5emYAWASCQq/kByDgJtwCkrSiUs+MRq/SrdtX591VIra95crGa3+HMn5gZMHsiSxyN9h3Gerhx3nvdncVDx20sPjoLBOUkWrUVZA0FCexul1ueHl6HQnh/N+cVneUK/hdvVpVk3tfJqyRH3PGZ5eYEJTHJ6zL+Ig0axGEI8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=XEBLbl9GOj597dMhhvxu/Hrlw4luycs8/fe7roMIn5LU2yX+ep25FQlgC5vk5ej0jE6bxxhezlUNmcUIlUp4ds5xamP9LaAH/SL7HB81qT6F6ULLCn6MheHPgyMp2pNVjpGMl/jFW+tX/NipXBHrv/A2pm5qQszfWSJmGeFAXDgxUmrSl/SQIxbqtAdXtJwedy38Bv2cS+XOTP1ctZtZY0um+8WzijIHMyi1YZRyB+8ssZQBtM6qNfSbLwKTZWv4sA2QeJIjVVLic5vEnExwtT/WjUlSo5yB3KpyklGks9nwH8gecpMKugM3XN9CmIkwTN26MN5cdggbY4aMPh6y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgz1OGLRs37uvqGlZMMC1EsF9CaynvpaVkKMug3Cphs=;
 b=VONMEJym6kLwRJ+0DKq5JWK2HW8Dmf7GpEDopquvEdlEXZHmlDFwVH424HIsZRjbfKFnsS2xsqGXcrCdhhNxuWDJY9Z4RCiiU9XMEiTpv70G2sff5EDhe9rDUROKI+R+SESvN/jLCPm0zxK5r41eszPBAmEMtzdDkdMESH7+Klt0WobgTSQdALuoYJ+ZoEJnTcy9t8HSZvxEeHVo5Zmvk1KIVxYEbuq8pcQIlYrrkx3WyxRD61gLBHYNZLyYRCcz7SVhf+XRpj51neVdA4ySIWKnN5uMOfTi0i4YM7txEu+P3d93H5kktOb2ly9VASWtOFHIXB6psZV6jEem9bDRYg==
Received: from PH7PR17CA0048.namprd17.prod.outlook.com (2603:10b6:510:323::11)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 15:11:18 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::d7) by PH7PR17CA0048.outlook.office365.com
 (2603:10b6:510:323::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:11:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:10:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:10:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:10:49 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 04/11] net/mlx5e: SHAMPO: Remove redundant params
Date: Tue, 10 Jun 2025 18:09:43 +0300
Message-ID: <20250610150950.1094376-5-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 66221e34-8791-4e44-9460-08dda8310cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8bxrRYNW0Mr6zcTSqzd2x27PZyHtIQSkjVejshFWCMX0oRcU0s1v50m9en9?=
 =?us-ascii?Q?W72EpzWWDoP33XgrHXeh7xz6fDyb9R8SI8Q4mmbXWD3z+MmI9yiyF3q/oQIc?=
 =?us-ascii?Q?2gqWfWLdVmkyJsJexRNPE8ANNfziqIU7UgQacdVi8/H+Y9QL6+wxsC6Bjb7v?=
 =?us-ascii?Q?EzJHyG1zJ67Sp/zyvqHJzegCjQhUblbap7U8U7ktE0396vEgXtyVYRt+40wq?=
 =?us-ascii?Q?5hm5qMpqtsWONU3PMkbjU13/U99VPKPc/sdvHdx1UEJH/Agie/czLx1fMPc3?=
 =?us-ascii?Q?EOkTZb+rYNiw0v399Vmdoq9EC6hVMzOQ2X1WU/ydusz82UwBZI8KNxEhkJqC?=
 =?us-ascii?Q?aLKFZCNI3bQEZahOMTXFagaloTFpISF/7KNwKVrqknZxoCUwyzaJnRzQ2Eal?=
 =?us-ascii?Q?kKEUgae3XevrtisOp0fCUmGC7cGZeO8eRKhrd5UyQNAZDebJGtC6C7A9k4L5?=
 =?us-ascii?Q?QAplmfa4TWUnkhdi6vkhS+WtZoFOUlD8v4X6U9CtB0dvauTEcOocR8Kn573r?=
 =?us-ascii?Q?C7tlOXmAgTcyjuP5cSAuwmgfJ6ybDsnZYNcRlw6dIbjmTSlgkpAiCmZMRE+8?=
 =?us-ascii?Q?7/9cuaSqTOIiA3iaRYXJ8X5bLAkWmZefmI/S4xxaNBQhG6gwEhv2mxhiS5M0?=
 =?us-ascii?Q?HmgWXKgLO06CBuAcTHBtFy0iLTfYrg/4ynoZTtrdaO4wsdmh6MKoVEVnl1pg?=
 =?us-ascii?Q?MxQckorVW9H4R9gEmoHyeJ+Uq1/MI7dB0AHFUjOo9b1S831FEioumTvD4td8?=
 =?us-ascii?Q?zkEOj2QaS0n79Mwp11SQRPbXLigSxRlNyQblMADH0e5OiMKICDow+SQYzRtY?=
 =?us-ascii?Q?HIQHROVge/YLVpJApsoVcOvU+1t2sf5zw1Cg6/dU4segVRHhzNzsrLWZXq5d?=
 =?us-ascii?Q?+LvPA2I8DyjgEDIRg9E7ZFLDti+dG0Ns7LD0QBMWEXqfbfEokZamSRwaJ1JR?=
 =?us-ascii?Q?cSmsOHNvZKgS8/Ff3jAxjJoZ+BITCQZ7kAIqTV2W+O57Sdf3O1Ei13mnm7k0?=
 =?us-ascii?Q?/II80814xejv1FhogDn40af+c3plq0aeA4v6b4pF3LMt3rrv6IqMZgBD9uMm?=
 =?us-ascii?Q?qVpXWe9sEDxfxJ+0QQMDENtQYN659qWf0e3Z5aZ2KLkihIK3VQw8bP+H/mDC?=
 =?us-ascii?Q?YfnWIbAUI9bP4OExOLwl54/mC7VE8ABBWijnN9IKGKDFrLhWb7VzQAjOI3bs?=
 =?us-ascii?Q?eTAatofAo5ImK/wvNzgWNjf3m9nnmYgsAqqxaGA8h/3FzXLyvzw4qKtMicqM?=
 =?us-ascii?Q?JfW/WKfOQ05GQdTKkigNTfcGUcZ5mV+Rt8Q8UOsJs85m/mMhOtUiuugG2r5F?=
 =?us-ascii?Q?UPR6D7ECatFX2AzhrboPYnioKtd9Cn3AqGxlju0sl1eCktSVfW7DyVPQiRgf?=
 =?us-ascii?Q?8sD4bQHKEE4Eh6f5GyXNDMItBadF8H6Y2semoWKDPtvkAWGFYamU80ioy47E?=
 =?us-ascii?Q?uiKD7UF5cxDGQCZynHAkxE+kktWFb/JG8XJHtjNEX/l0kwNNKUNyVAUy47q2?=
 =?us-ascii?Q?rLb+2broZnZ7rCaxI/QRPUDcct/4+E19nVLP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:11:17.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66221e34-8791-4e44-9460-08dda8310cbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273

From: Saeed Mahameed <saeedm@nvidia.com>

Two SHAMPO params are static and always the same, remove them from the
global mlx5e_params struct.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 ---
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 211ea429ea89..581eef34f512 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -278,10 +278,6 @@ enum packet_merge {
 struct mlx5e_packet_merge_param {
 	enum packet_merge type;
 	u32 timeout;
-	struct {
-		u8 match_criteria_type;
-		u8 alignment_granularity;
-	} shampo;
 };
 
 struct mlx5e_params {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 58ec5e44aa7a..fc945bce933a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -901,6 +901,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
+	u32 lro_timeout;
 	int ndsegs = 1;
 	int err;
 
@@ -926,22 +927,25 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 		MLX5_SET(wq, wq, log_wqe_stride_size,
 			 log_wqe_stride_size - MLX5_MPWQE_LOG_STRIDE_SZ_BASE);
 		MLX5_SET(wq, wq, log_wq_sz, mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
-		if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
-			MLX5_SET(wq, wq, shampo_enable, true);
-			MLX5_SET(wq, wq, log_reservation_size,
-				 mlx5e_shampo_get_log_rsrv_size(mdev, params));
-			MLX5_SET(wq, wq,
-				 log_max_num_of_packets_per_reservation,
-				 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
-			MLX5_SET(wq, wq, log_headers_entry_size,
-				 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
-			MLX5_SET(rqc, rqc, reservation_timeout,
-				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
-			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
-				 params->packet_merge.shampo.match_criteria_type);
-			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
-				 params->packet_merge.shampo.alignment_granularity);
-		}
+		if (params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO)
+			break;
+
+		MLX5_SET(wq, wq, shampo_enable, true);
+		MLX5_SET(wq, wq, log_reservation_size,
+			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+		MLX5_SET(wq, wq,
+			 log_max_num_of_packets_per_reservation,
+			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+		MLX5_SET(wq, wq, log_headers_entry_size,
+			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+		lro_timeout =
+			mlx5e_choose_lro_timeout(mdev,
+						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
+		MLX5_SET(rqc, rqc, reservation_timeout, lro_timeout);
+		MLX5_SET(rqc, rqc, shampo_match_criteria_type,
+			 MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED);
+		MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
+			 MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE);
 		break;
 	}
 	default: /* MLX5_WQ_TYPE_CYCLIC */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3d11c9f87171..e1e44533b744 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4040,10 +4040,6 @@ static int set_feature_hw_gro(struct net_device *netdev, bool enable)
 
 	if (enable) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_SHAMPO;
-		new_params.packet_merge.shampo.match_criteria_type =
-			MLX5_RQC_SHAMPO_MATCH_CRITERIA_TYPE_EXTENDED;
-		new_params.packet_merge.shampo.alignment_granularity =
-			MLX5_RQC_SHAMPO_NO_MATCH_ALIGNMENT_GRANULARITY_STRIDE;
 	} else if (new_params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) {
 		new_params.packet_merge.type = MLX5E_PACKET_MERGE_NONE;
 	} else {
-- 
2.34.1


