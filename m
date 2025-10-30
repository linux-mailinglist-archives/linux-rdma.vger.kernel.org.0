Return-Path: <linux-rdma+bounces-14146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E7C20407
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2734DE20
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483B25A355;
	Thu, 30 Oct 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uWWWVBQX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37823E320;
	Thu, 30 Oct 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831236; cv=fail; b=KyYmSWSbxe3B8nEnfy3sLduk+WjRuP31iQKl/tjHccuhU1+FzTzUftuAp8UKyrpSJp+CzCrt/Y83oZaOpPWDAFtBgxEyIYFw+MKiJqYNoaLOD6+cGZa4jcrqGcGsozPO+EWLX2AQmQooLDvOhcAHPUPIWnO0mKzC8yDqek9Uu+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831236; c=relaxed/simple;
	bh=aFFWdXKhsi9yvWHLiSALrPJlYZvGWKdIHvnmGU7OCTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3Dz8n/QPYljJvUXUjGDOWn7O+oktyVvtWe/ww9QuNmHWhpSw2lbsD+8dmexX4ZjfIfvvaVAeuhKeN7c0wFC2EesJbVXOPxs6vtVGa6Fd7wzyC8t5gFZjI0uOl4wnm/+rQc2D+1kb1OzvUcqANaP6XNUUzCQKcgPoNhELOvf0sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uWWWVBQX; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlG01cu5rK4iNynAhJJ1dkBTldP1/ewkZOzq4xK5sIDolZPFzKqrA5Fa47q8LkVZGYqhQXRXLpti1lg1Xd041N9BfotrSWQUfD888Sct4w9m2vGEnBdMWQ4NKZIagBCmxC2h9neTZhNH5NmOClInj8DcoanmKRvOiTBLuxTwjm3adwt95QZbbIYLvNybyvyCOxFEAbmMxdRHJoixaMk55bwoxhgktNWTiwyXfZETohIOK1i1xzCAGUw5uNz1zNNCBd/jzeMMIPpYS7yaGW9c2fTrJrkaf0ViuU+3CfeAvo/z1+gSYXCMsTLwk0XYdBp5KUewP9iWyl7mCoUSbeqHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU35hQiFnYtfb2tYuJPma7bqv4Ej9GPM6PKl66sOtmQ=;
 b=jKCPCXKEC0vmjiYWAUur2V3TOnbIizYjWt+7wkOcK1YOy8aYbq+MAUM262yY3UE2xorJnaywSc9EIIe5aOI61pYJd+8/5JNwKG84Zi3FmnCxJhRB1zUELPgzh6GrJQ5YN/J+Ota9XJ5vanJMssM5a9EzvucBZnBV365xupoi7EGBTOghfkzUdGZ3BfdSKsBKhYNwJr43aUgODUj1U13Hf/hkzdCGO3eQ3E6GqLYgHGZFGAlD56nEPJ4+HTnOpJILBIZtAnE7ALPqtK42I4JMXWmbQWGl8E3JT6aHvog4pQoLwK42/vvd0XUUJms6OjF7uyK8t9cV8+WYNSNkKR9pmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU35hQiFnYtfb2tYuJPma7bqv4Ej9GPM6PKl66sOtmQ=;
 b=uWWWVBQXZLRm5rkD75phf1sozbXLVPiMf43i7qOw/Q9cvUfGH5CV+tV0TDICT+2Kwcxh+fdrZkPxiEsdSkW27Ht2l+gTtDgoKsOUrVqDKUvVaU5TX0a2c9Jr5l9Vc4vtOIZP758I1kzIV71ea2qRok6yQMeIEAMdiYUdJQ/acBcTlMSWtQwu5wfzcZYbu3fAnCXVgzsAG+VVduuMXTKoRMLMHH8zBOdXVnxE65+sKr+fL4/Pe/9se51op64HVwdDo7F5tcESC/JzSJDy54dcBhFyIvSP2+yhaI+YEYX4YBvLuwBq67IbpSt9OUreVYI1R49SEsnEJ3nnVEro2EsZ8Q==
Received: from PH0PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:e::12)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:33:48 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::12) by PH0PR07CA0037.outlook.office365.com
 (2603:10b6:510:e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 13:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:33:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 3/7] net/mlx5e: Allow setting self loopback prevention bits on TIR init
Date: Thu, 30 Oct 2025 15:32:35 +0200
Message-ID: <1761831159-1013140-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec93714-544c-464b-839c-08de17b8f4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P2u0BsPMlrzNKw9Pzch6yIsk3QJmThmgZDFywOzXX7mFmSTYSdgdfvxydcJs?=
 =?us-ascii?Q?1z6HqGl3gKvcSiNGi+LdcFrpztrgVQMJQHuovbfGiJ8dL41NObwFfjVDLZn6?=
 =?us-ascii?Q?7W3ZciPJm1u8M1ucpyRsEu47d6rR8T09zyJ8vtOqb+xYweHAn6kxEeDEE+Ri?=
 =?us-ascii?Q?NmWNWdWRtQcd0kh1s+Y5tZqs2PEbO8FPWSGKW8BkGXAPmdbpJcxgqGi482pt?=
 =?us-ascii?Q?OqNAc972374J8dHP0T1UdIHUIKOqaYgdtHiBdDjUOAao1AahZCkkX/5CnAHX?=
 =?us-ascii?Q?lx2fMKnN7UszkE2wgOYZw4ci6hie2n8seHPAV1BelJerZ6MCmH9auHa9WBcJ?=
 =?us-ascii?Q?mVROaoKEZ3NLs4iBKajOoLIQHSj/0cFD8Vhc9ySfQ11p1xunxyWeW7lQlz/Y?=
 =?us-ascii?Q?8NvYw5aIY2MzMvUjYVVwwRkgvFRY4BcJQDgTNh5MZHIRgGpFk2lFDSahq0jQ?=
 =?us-ascii?Q?LnCPrcbNVlmixR1JUoRMvpTt3M+0Ae8+E+0yGIRcDuzCI6Dyc4OJ46YitOOW?=
 =?us-ascii?Q?6rETPECGSbGWW5tMRd/dsDHnjKNhCxM8kbdgAfBH602lxCi00ylIdnpQWiW0?=
 =?us-ascii?Q?KB8/F9nRnJkMw75tJw53BWk70U1gDk28KhbODhJ6eDPDoDMas3/TTPVYsFIy?=
 =?us-ascii?Q?LPdC8g0c4ks5lJIrouqJM3cnmP31gJKiPLDCfCKMGMQRicSVBDaAMCIFD4uB?=
 =?us-ascii?Q?b7yOtdIhI1+g5Z+FxXxlcn8RgPzHM5IH+lTyj+rSnh4Z/3EYYqUANdUnexeP?=
 =?us-ascii?Q?o01//y+CRaNIUBfO+2A+1AVgDOBsTGxrczCbL3SIhpsJAxKYn+mi0xzuSwm7?=
 =?us-ascii?Q?yU4b+BUs58502FMR5bxgj//81gAmNc1XiF7PnZc5fERu3XQBtvcYSmsQ8mlU?=
 =?us-ascii?Q?2zHEUtaBIUYXiOnNWtynlOgW2fZuAfm0Kunzcwa4WzLHaOusQa2nnr1nc5Fj?=
 =?us-ascii?Q?8d6xmANZnJQ98YoRT/7kpms8Jw0rZQMv4ie8NC1W83g1ZbGp2ZZXY8L1nLI1?=
 =?us-ascii?Q?is3cwFfQZDRTufdQTFMokipQ4/XfugCvDmGRn6JBHyNuwieZFeZY5hsN2P5L?=
 =?us-ascii?Q?HQhqiIIZJ8+hHYoGiAtdojteDFpTXxaBXO0NNWE2QWrXQha9HhL8Y7ALdzN+?=
 =?us-ascii?Q?UisLUn6+mnvVPqFfydmQ8TowZfbnJEY2mUaNUofntA6dSD3QVa/GvPGxYQ/l?=
 =?us-ascii?Q?OsPX7BnHgMsGLOCcXVyvlIdTJHRt/5Kbw8KX7xa/26h71XHrY6R24jtkimGA?=
 =?us-ascii?Q?zRD4RV8HOYEMyV1o5jmMbvwbbedYzMv3hb9rt/tnlaESRDnS3uMnUxuqcb/c?=
 =?us-ascii?Q?kNWP87VryuTbSrp/ugev4s8ypkmahYlO0d/4RpgpqjsS1tmxie+b0rpbUhyv?=
 =?us-ascii?Q?Kop5ix9++2DkD6zV0IdnXPOCiXs8Ela4uNfMrycZk53kuo/nRqfwB33RCVw3?=
 =?us-ascii?Q?fPAoqio18TGE3ZcMBof003RSEKhLfE1YJLFi+8IfbmDQmV53F/HTPQpNAL2z?=
 =?us-ascii?Q?54doxaYdibgaVf7I8E+OyT11E5SWYCBHJ2pSnutFVhGOD9Cc1CQEVadAEJPe?=
 =?us-ascii?Q?ixrMJZn7s17DHIC72yE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:47.9881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec93714-544c-464b-839c-08de17b8f4c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579

Until now, IPoIB was creating TIRs without setting self loopback
prevention, then modifying them in activation stage.

This is a preparation patch, that will be used by IPoIB to init TIRs
properly without the need for following calls of modify_tir.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c    | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h    | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c | 7 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index c96cbc4b0dbf..88b0e1050d1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -231,6 +231,8 @@ mlx5e_rss_create_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 				    rqtn, rss_inner);
 	mlx5e_tir_builder_build_packet_merge(builder, pkt_merge_param);
 	rss_tt = mlx5e_rss_get_tt_config(rss, tt);
+	mlx5e_tir_builder_build_self_lb_block(builder, rss->params.self_lb_blk,
+					      rss->params.self_lb_blk);
 	mlx5e_tir_builder_build_rss(builder, &rss->hash, &rss_tt, inner);
 
 	err = mlx5e_tir_init(tir, builder, rss->mdev, true);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 5fb03cd0a411..17664757a561 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -23,6 +23,7 @@ struct mlx5e_rss_init_params {
 struct mlx5e_rss_params {
 	bool inner_ft_support;
 	u32 drop_rqn;
+	bool self_lb_blk;
 };
 
 struct mlx5e_rss_params_traffic_type
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index ac26a32845d0..55c117b7d8c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -71,6 +71,8 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 	rss_params = (struct mlx5e_rss_params) {
 		.inner_ft_support = inner_ft_support,
 		.drop_rqn = res->drop_rqn,
+		.self_lb_blk =
+			res->features & MLX5E_RX_RES_FEATURE_SELF_LB_BLOCK,
 	};
 
 	rss = mlx5e_rss_init(res->mdev, &rss_params, &init_params);
@@ -104,6 +106,8 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int in
 	rss_params = (struct mlx5e_rss_params) {
 		.inner_ft_support = inner_ft_support,
 		.drop_rqn = res->drop_rqn,
+		.self_lb_blk =
+			res->features & MLX5E_RX_RES_FEATURE_SELF_LB_BLOCK,
 	};
 
 	rss = mlx5e_rss_init(res->mdev, &rss_params, &init_params);
@@ -346,6 +350,7 @@ static struct mlx5e_rx_res *mlx5e_rx_res_alloc(struct mlx5_core_dev *mdev, unsig
 static int mlx5e_rx_res_channels_init(struct mlx5e_rx_res *res)
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
+	bool self_lb_blk = res->features & MLX5E_RX_RES_FEATURE_SELF_LB_BLOCK;
 	struct mlx5e_tir_builder *builder;
 	int err = 0;
 	int ix;
@@ -376,6 +381,8 @@ static int mlx5e_rx_res_channels_init(struct mlx5e_rx_res *res)
 					    mlx5e_rqt_get_rqtn(&res->channels[ix].direct_rqt),
 					    inner_ft_support);
 		mlx5e_tir_builder_build_packet_merge(builder, &res->pkt_merge_param);
+		mlx5e_tir_builder_build_self_lb_block(builder, self_lb_blk,
+						      self_lb_blk);
 		mlx5e_tir_builder_build_direct(builder);
 
 		err = mlx5e_tir_init(&res->channels[ix].direct_tir, builder, res->mdev, true);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 65a857c215e1..675780120a20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -21,6 +21,7 @@ enum mlx5e_rx_res_features {
 	MLX5E_RX_RES_FEATURE_INNER_FT = BIT(0),
 	MLX5E_RX_RES_FEATURE_PTP = BIT(1),
 	MLX5E_RX_RES_FEATURE_MULTI_VHCA = BIT(2),
+	MLX5E_RX_RES_FEATURE_SELF_LB_BLOCK = BIT(3),
 };
 
 /* Setup */
-- 
2.31.1


