Return-Path: <linux-rdma+bounces-13997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE01BBFF652
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E40E4F9405
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6002C236D;
	Thu, 23 Oct 2025 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFhrpmop"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968629BD87;
	Thu, 23 Oct 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201931; cv=fail; b=VwzZWPC+rOHCbKWNPdgKN4yDB837rfnflD9M6+aIs1zne2FeK19eHyzMsJAWprZRD8Q86hCDrqxAd+3iSJYPl6oZhcpI/cyyrOuqK5XDpHnYrwksuJyjqZfEgavBH1fQZlBkT4oq4mbfQ6M8z2ascz/s3dzv8vbgHdrL0ssYiY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201931; c=relaxed/simple;
	bh=aFFWdXKhsi9yvWHLiSALrPJlYZvGWKdIHvnmGU7OCTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYAutlygijFyvNKXglb7NvwxDRXRKFzaHY/JXklssbLbMolTpUF7WJxOgiBUAVZOWHVqXrqDMP3fne59R8ggEI+ofhHL9on7U7i+5dlh5JEXJeqrHrusKFS6WwZYfFuwMKiihVQZoO1tpycakdCY7FyepyDfUX1Ggzfp8uN2Ys4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFhrpmop; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeWKxQvGPVxkuwhFTnqRHzuJxy/bBaWU3HToN1NfZNb865khBYOn/sfpqtWR8UrjLib9QYrjUjitZR19gzdbbEBXKL70r+QqngBN2DqSm++2MKo1fDYmc2icjA0TCEBRb1eYwP/WFFS3zre2RllHwlesxduQCn5X7fepOu+8xsJ2ZZx8hjw+b5s5UJMxKivhW3v9bvuoap/x2rtaAj1/Zy6YorFz4zUHMKxfpWDI5Gd9vI06+fiEDm7wuMQBGemlJsqOQqNPzXjGvlXpwJZi3BzdMMlPXp5oYPk0KiXn5yWlEaHT+4iC1ksSSdVpTWksgmijPLMs+8VVhLgh/R21bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU35hQiFnYtfb2tYuJPma7bqv4Ej9GPM6PKl66sOtmQ=;
 b=LbR5iFYjCJjG4ks0ZgDJmbmKvd2bduAUShNXCN4O4churbmq8ZCyiO6sho3KkDCTx1FFZCFCtcGoe9M80iCRFkVoYRyLh26jVRkxC5862YHmSfpvE64OCwM6qK0+wEB85e8fYItghRYCprCZPxKNEVUscDMRTn8JHQF2tYO6IkSTCvU3tMO0nNmWYEcWKNlqyqXjHzSitSMGOvemGEcOS+CqyGB4n25KmxYoJubWJd5g4MuVhkKVsxVsW6rD+T8fFLm29K5EXmPNPPrZDd7wNn2iVNrvgobIU3IUKLxbGoveLg44abinSGyFc6RBpsAQoKoSrbcA4yYYo5AI2G7yBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU35hQiFnYtfb2tYuJPma7bqv4Ej9GPM6PKl66sOtmQ=;
 b=rFhrpmopPB7cBvdIo21dsNi8pwAnNdv8BamL+Pfq2FJsaUGVGdm/BdvvyWczw4osgepAgbuZJmgDPmZxI2zhGcuLnefpaPhsKgUrEH/ACeYzSALnSWFRHifpeP+ZVZ2a5YqMkES+dpK05WiJQpCK6PkTdKGgbBAIjBANasiAUr7ElgpZimC6KN5owI00jGa/p9CcGseBN6L0m6h4NJUMwiZG5chtkiuIqEEZR6n+VxVbZIIytPwrxDREJEuZ1JCfysGM0/V16625lfs2BcQeDggfnLJEFSDJ0GvxLTijx2sEDf5TY+qZEO7tnRh/BHzXgXJ0ig8xjGUNY2fnDVxa3w==
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:45:20 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::7d) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 06:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 23:45:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:45:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:44:58 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 3/7] net/mlx5e: Allow setting self loopback prevention bits on TIR init
Date: Thu, 23 Oct 2025 09:43:36 +0300
Message-ID: <1761201820-923638-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e89a69d-fd86-4284-363f-08de11ffbbae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aFKYVB4Lgycag6Kkh2zqJ4FknZvySVrBszbENKnwHU3Mr4fPN3LWnk4QqnXQ?=
 =?us-ascii?Q?KU6j55GTjLg/6kTvfJCcMFDno9WLq9fenGGXdrnxMsA+J5Iv5xgZk4rZvQF1?=
 =?us-ascii?Q?Xfgeuyb9MlzGoHsD0s89ldqkoK8KJTpmBPZTDxl1tlleD5thAoMAzzM3iPt2?=
 =?us-ascii?Q?GEx3KBtl8wh1+ZBCUFguO4Oj+lAK4dNNHzAM31tYleOOqX+04oO56FKN282j?=
 =?us-ascii?Q?CeCdsVzjpL6kMF4BTlRGA6ShvS3kcuI/g/6Z6/7eRznfRCEqoyY8688uraZV?=
 =?us-ascii?Q?9ibZKL0y8umLjc9Iz08Eb/h6zFJPfjjFNNBwKVwKMgt5bgm3uERyTd7EiNtS?=
 =?us-ascii?Q?/TPBJb3OS6X+7O9LqdY27RA1SRmAvP7NhpO+HF+BsvRDm1WNibelOZe8vZoT?=
 =?us-ascii?Q?HuQelWgpwhDlCN1GZgD0qF1iuVM+OFALg2RgxY6xHBjIvf88tZf1bE+Jn/Q5?=
 =?us-ascii?Q?pwdstNQJGtGGR5MN+7wZHqQhgJxIBiQx/wNsW/jlJ61SsPCojZt2QmYGx8Em?=
 =?us-ascii?Q?aXGF+iYg5eUGfgHfchcevWrwKgmO2GaEugqpQr5VhjwZOJ1iIcxYagYoJU96?=
 =?us-ascii?Q?lCBOq2SpfUuQKBAXMSXbmYvL9MEmOAWsc6zBNmUh8P31y2bE0kfneqjbXAAL?=
 =?us-ascii?Q?AF/NcgZG73TApzKHSR/EkU8y3JxASgQy+catuEKFZH3Pe+d+WU3JSaqlaj87?=
 =?us-ascii?Q?zqVRlwd3+VcJy4JnJ0jgdNEMKmoB0fzhiW+tnNaTvz+dohuARYnqpnkZBL8U?=
 =?us-ascii?Q?1NkaE0Hi39xDbWLkiLxnDHVDzCWvEXYeXt2uNyeZntmMfVkVPbLq0Q1S8f69?=
 =?us-ascii?Q?RyLSl8pNsFZCF6JisWCF6Ph0kjVB4n3GRbFvfw7mzuMvSUcPnHkEw+mqq8MJ?=
 =?us-ascii?Q?6lRYIjagSDO3eB5AlxKR1fBWPpZJnJ/sPE0mamTgzIeF9BlSRi+bLu9kFezq?=
 =?us-ascii?Q?q2PuUI9vuX9952CeWNShwQd7X7NG4Me8TN4Z/eJ/gbTFpkUkGWElP8IsjD92?=
 =?us-ascii?Q?XoRfbPHSMYDv/eH+6hiEV+fxgMyS+4O/P+1eN1a+FMaliJj9+8/RlLGSAMf2?=
 =?us-ascii?Q?WBZJVGqlHnZl0JdhHvw+/v7WUeVIkm4hILaDDJ+O3F1iTU1+g18mHzcIJtm3?=
 =?us-ascii?Q?6dw2vCijajmoHVOx4XLtbaJppXVI3wXXShoBqn/VMNDhgcf4xhAcmW9CNKn4?=
 =?us-ascii?Q?A/G9PmELwnyvH/7kZwgb86jNcDna9IvY3xDJclgwaXAgLEz3GIEXKDj+RKuI?=
 =?us-ascii?Q?BvReVvLwXLeOJE16vaEUsA/1nmCibdhNTOLwfCN/2AaSr6ZhKJOOKdoqqALq?=
 =?us-ascii?Q?wnkd80U+vd+Rb5DIufr2mXJKWskRzX4h7dDrUeiDC+Cyk6l20xqHs/xDxIxQ?=
 =?us-ascii?Q?jx87LY3z/fb0QtLKL7vBcK567SuKLbTIbWEhWO/K2CwNt6g+Ry1E4R7O3lds?=
 =?us-ascii?Q?uu721fK7fkz66RRchaMlR5OVlkVc9Zjf5DGQlqsPunNfTi8/pFs5hShh71Sk?=
 =?us-ascii?Q?sMKhrnAqKGrrSx6QPOJv6sY5P/VHOAo4Na2odXFpcoaVOi26pV0bSieC10t7?=
 =?us-ascii?Q?M1iaH4+VHklHBB5St/w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:19.5086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e89a69d-fd86-4284-363f-08de11ffbbae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813

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


