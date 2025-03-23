Return-Path: <linux-rdma+bounces-8906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B643A6CF2B
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Mar 2025 13:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13E21886396
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Mar 2025 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987E204C24;
	Sun, 23 Mar 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSAo9m9L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C51FFC7D;
	Sun, 23 Mar 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742732935; cv=fail; b=OY4Wvqh6Ql2zh7mee8Rt0ufmDCQfJBx1HdoSbOz3uAmanvskVY4Oag3zcbbLotj9n4Ol8TdSsXU+3mwPEZhCdNJ26Vkhbu42T3mT6n4VTMerk37fN2i1T+mhphUtukitFpoNwichGMei9FcOZ2BgpC+5D+eK2T2ljpc/otYXFok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742732935; c=relaxed/simple;
	bh=861Zjf+V7n478Lat0TazM21IbBhbVWbEawXBH2wW/1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LdqeMAmvMJ1IlGvAGTs+jtIVH16tmdFqW6xl1RguzmENT5bJ01TR28s36SMKw/Ecb5lwJNrIVQ9VHHGjmr9G8I+/Si5mqdMb+Jd0LLf6uulP96wFX27OQh8zAssu/tp31C6GLRwf4fueqFmSJrTEHKocTK9GE/y8S9kRXdZwN/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSAo9m9L; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lqz2k1LZlrVvwYuYdt5XWzL7408QrIBRwHguPSm13ljjqnUZEywZqfJgJKmECqnORQ351rkTvCY2LuRpLGcXzBnv319jA2avJBszQMRg2MG0keOWEd3Bn+zZoQe+rwt8uukjg9/TTLcG9EOkm4IWCwzN79QQYcMORXrwrCg1yty9BmMirk5md+PTylYZ+Wh6KHVuUX5wSr8P4Ab6V8Am4eQPATsLZrY6s9rWbOV+9WAA0nY7GyUerz4egjcPt+dn7Qb85Z8U3Mdz/mx8N3CQ6wf4Jtppag/BXHihiCZ9e6qtyTnaMf6mM0yvnnM1PUyC7CBgCT/tK2VUF1SM6etuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/S/Aiq/ZuKW24/H/0SWOEq2gNSdc6HXBCm23U/z1Ek=;
 b=ReUmTvLo8OOAYxfwZKVNVMB6WL4Z5mpGOhECepHli1WNiUB/MRTwdBJ7JvlyMt9PfZDTIqpQ/4qQuaSmOF2fFjpLjRJP2RNAKr/hi6umZpOzkvlgnivzUJLOmtpFparUjZV0Izt+tUdXt8dH1Krmw67unBhpnCZPhrAvksiouDNh0vgEwCnszTmzKMcNRftc9pUtm8a9QtbAVlQ2E+6T29ft89/M+GjqF8WXKvG5DNTyRW0SmAtoHOoXcf3JQuI8FL64QwAM72ST5DF68G41MOcOvyNYg6Z/xDGEb5QcbPgoyoIcWTPW+uhfzrWmMNOkosblUE7jzRyFClBXJKDowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/S/Aiq/ZuKW24/H/0SWOEq2gNSdc6HXBCm23U/z1Ek=;
 b=DSAo9m9LXWOgt3PIp6XxPax+14FYGBC4HIym9vI/GvlzGAergCGbRZ/F9Qu7UvMZtuM6pi+veAo4JHV8ojW2nP8AkSYtc45cqnGrWiMW0MO0mPcq7L+WF1K5nYf2XOf5w91w9dAbg8LIJuB6mfyxwND0h5Dh05pBeCOHShBTryooenUOV/dLivS/CCHGk1g3lm5J0oo4NokAFGCyojS08TnTjREaa5QY8p5u/xE15c6SoGYR2gqqZrm2Wv6KoPLc6xwZ+G81E6lWvCiczQ106LyStqXl2bbsC+Afz0+KO/XgY3oK8Ul4wEh1H0zrZJ39SzRnquSyD2Ag8kEunH86AA==
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 12:28:48 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::ac) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.38 via Frontend Transport; Sun,
 23 Mar 2025 12:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 23 Mar 2025 12:28:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Mar
 2025 05:28:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Mar 2025 05:28:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 23 Mar 2025 05:28:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>
Subject: [PATCH net] net/mlx5e: SHAMPO, Make reserved size independent of page size
Date: Sun, 23 Mar 2025 14:28:26 +0200
Message-ID: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: f91d1100-1817-4523-675a-08dd6a0642df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W5BDBqUE9PvOl2j46ATKcuF/v+2g+uneqpk+mS/OY0pr2Bj9PZT/i4eOMubW?=
 =?us-ascii?Q?XXKoQile+avuEZWcM+7EILja4b+RD7yj0wO6qddEP1oMWScET/Z6Rif2Uve+?=
 =?us-ascii?Q?21DzCjFmzSODbVmjHmnjUIH86AXChOVMr62MOPe2SvccdbWjkvZIF2opH9Im?=
 =?us-ascii?Q?rIheyCfBUbIAhwk/uXzQeSTV3slibhbmhXfQt8yYgR8dowYK1SZq1dwFjbQY?=
 =?us-ascii?Q?LR+GIM7NlDMX9bZGE4ZENVgQqajpXoweEhqzucaQH0qiL+BDwUhLm2tA2CmE?=
 =?us-ascii?Q?ahb6YWxOEPaL6m5u4lJub7BVxlRUxRVvSKY6QLA0pLUHhavIGYt6wMzv8DXV?=
 =?us-ascii?Q?YajyUnPv5ZExgAVH4/wOYEyUxd4lVGkzqH8fc/mMtLiSGVV7RljcEG+KyKQB?=
 =?us-ascii?Q?91l06gO8y3bOQRmBIkFO5OkqW4Guf36RwCrgIuv/O9Um6oFgHErNCIT8rSoY?=
 =?us-ascii?Q?gJPOBBbqPFbKL1ajqDN+zWkNnySMLCklOJXlugfSgaNm/+cTCQaG2FaLMzIw?=
 =?us-ascii?Q?IacQX1sGdH2OQDAd61dN04gr6OuFxBcIKMAs6pofBy4SnNVhXEU+CVHT7oVE?=
 =?us-ascii?Q?taSN9oR2ngt31TtQ9YO+9CPtUfv4mr62hUDReZsj4yYoKhJE9GNYjqNDx9xQ?=
 =?us-ascii?Q?LJyO9Fy/Da+v2Va7X1551j48OPeFhyJgn10pNX8vXeXZ2+Sz9gPXY7ZAligJ?=
 =?us-ascii?Q?Nywcb8m28joUhb3goLULdNAP42E3R83GACNDCVXfavt+4MtB/nZgdQ4zM+8m?=
 =?us-ascii?Q?xr8LIb7PHhlH/7B2IyHvg90X7tjDNgD/sPEc3WE4ZjQ7dgNaAkFyKgWDLL1K?=
 =?us-ascii?Q?ZJFCt+vy/tWYjFNeEnMFB5BzkD8HUdjTk4ll26SwEd99a7j/GzVhscwrkk32?=
 =?us-ascii?Q?0a5RGsKiq+1LtUNSVQPRij9Yf36pvDMUKAtj9AI8eQMkW6FBdWeOs2uY06IS?=
 =?us-ascii?Q?x0aG0JYGOMiIJnwFRNpuFaU0HoZ+SGCaWbhbMuWzUn5OqSe6CYb3a1RidZo+?=
 =?us-ascii?Q?9XsEgFNbMM/O3+3ZG27PunOOru3+Mk6p1ZjluOe9IQZT1B3++F/UEKWGwDjC?=
 =?us-ascii?Q?aYNazbZddOj21GwZ8I0c34A3VQAzPj2hX5+6MnbS0fl06rYkMKVJ4+hkVqIa?=
 =?us-ascii?Q?TOqPnag+IshhphfAywe2Z6FcBAiBMSKBa12EiuGpykJ2HtzB9Va2VOaSIW4t?=
 =?us-ascii?Q?98EuZc2t+nLiCO8vg5brBsxvBPOBvRJxEwh3R2+dtL0p03ALYlfv2NL7xq3t?=
 =?us-ascii?Q?sGBDU0M4+lo9w/WL1RncGPPTXoRwNRNdA4vTBM9KKIFHDnYS/ELXG+DeEXVz?=
 =?us-ascii?Q?KacaupWf03LrRdautPiixy0bdumYwaXKJ2H454uAYtkUVVFIUs6Iq0uJJqYW?=
 =?us-ascii?Q?f4Icp9mdYuJyGdM6KaXU1SKy/iUCQwo8bLOOLUDYj0snQ6/cVtWuxbrOend3?=
 =?us-ascii?Q?Sk4slZQNsL8KBvGQZiZZqFWTbOZcdTn8Oqp8uFcQzp92YTYWtjaUSWMiPZ7B?=
 =?us-ascii?Q?5IVdlJlEsIgYzGo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 12:28:47.9357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91d1100-1817-4523-675a-08dd6a0642df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305

From: Lama Kayal <lkayal@nvidia.com>

When hw-gro is enabled, the maximum number of header entries that are
needed per wqe (hd_per_wqe) is calculated based on the size of the
reservations among other parameters.

Miscalculation of the size of reservations leads to incorrect
calculation of hd_per_wqe as 0, particularly in the case of large page
size like in aarch64, this prevents the SHAMPO header from being
correctly initialized in the device, ultimately causing the following
cqe err that indicates a violation of PD.

 mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1180
 mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x510, ci 0x0, qn 0x1180, opcode 0xe, syndrome  0x4, vendor syndrome 0x32
 00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
 00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
 00000030: 00 00 00 9a 93 00 32 04 00 00 00 00 00 00 da e1

Use the correct formula for calculating the size of reservations,
precisely it shouldn't be dependent on page size, instead use the
correct multiply of MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE.

Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 64b62ed17b07..31eb99f09c63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -423,7 +423,7 @@ u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
 				     struct mlx5e_params *params)
 {
 	u32 resrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-			 PAGE_SIZE;
+			 MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 
 	return order_base_2(DIV_ROUND_UP(resrv_size, params->sw_mtu));
 }
@@ -827,7 +827,8 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
 					struct mlx5e_xsk_param *xsk)
 {
-	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
+	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
+		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
 	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
@@ -1036,7 +1037,8 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param)
 {
-	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
+	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
+		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
 	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);

base-commit: ed3ba9b6e280e14cc3148c1b226ba453f02fa76c
-- 
2.31.1


