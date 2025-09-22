Return-Path: <linux-rdma+bounces-13560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0419B8FB0C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A9418A2139
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DA2FE062;
	Mon, 22 Sep 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hFjtz2z9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C102FD7D2;
	Mon, 22 Sep 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531747; cv=fail; b=uOgeFb5k3rhOhkDHs6l/bhxMf6iq2ZXTSm8GtAj6YFEk5LekantpzUR5MdMgNJ1dmyuulM21+8nmnYtlwV9eEmoa28kaGIpyZUiAQReEBUGDzvUe2MDHO4I/DzDCH48mrVbvZZBBUWiRUnu38QBrTVqRykoUH5AYyVVttFo1DUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531747; c=relaxed/simple;
	bh=t/4Z97hmAIv9mj7sv8irm0Ty/vM+LmMlGQuU9W8UOU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbqmVQatZsLW7RYzqmkYp1yQzlXxD0Qq/8wgBMObTze+wzQVk/Sbg4/1ItR9eZ5m/q6ovHSq2S8HCm8tB2+TWy+NdsKhoj0VFp36k9/bts1rAuj9VAurte1MuKEHCN+tbMqagNnyn+v570R3k2bEJHhBpKuS1aIzk7aZqfv5R2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hFjtz2z9; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNq9AnmABMk0O23HFyGYwZPLNPkEePWCiLeT8VvZSeyF3FWRmecHap+yQHxYQx6lU3jYKRB+vGUubB2PPF5A90g3yRyVl5Ube6k9+9cEobdDGChc5exN2dMa/pimGuPg9k0eazpv0mjiUWSf1LKGIT1p5tfaf40B5nsOxlrCsWRuPCAOFLPFhnwsf+KsumYRpuKtnRRNqz8xlzC0Y0mYC3UZ4O79JeL3yBb/hgjcXO8k9y5VZunlzDWQ47JuG/3fcfC4qnNwgJ24vHCOZBkAzQ4GTPLaWFDYrvMAck0Q6u0t0tkIUDlQRk6hvP7hvkAK461AM7nTOJ/uJgwlMzgT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+nGnS9+4SCuIOn+slrhdkgiUnZhY1miHwG+yx5/BFA=;
 b=KAe0STahK8Cq4lnhRQkbpDhD6idilWVOhTRa8pULGqSifIZnLQyw2YoDY+gaExeSGNSn/fEQ0uxLg9tfebQ5zliP8dTQWZf+ePtFsy5qagH92xiy0612f4lp8sPddOxSEsVbAyLp2G2YayMjAcETR5fpZ32U/rg5Vd5Ey675D7+HCaKnEVIskyqzziJ7p+tVYdjk/6vhbrs53DfLQAjxaHFFtYuOX9BwrlhxPzzEP4Lw6xMZOLigK7EqxTyaK/KTEszQaxG57XhnY43dQMHmDJu7DRM3cpj/F0J3BjxybfMmLelOfnd+47/vSD7t1GNQJ9S4iL2r6DG8z4DvMVssNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+nGnS9+4SCuIOn+slrhdkgiUnZhY1miHwG+yx5/BFA=;
 b=hFjtz2z9dWeerhmZKgp02Tj05z2cqO+xFTa4UyKIb8UUHTXKcrlFCkPG7y2ad/fjdtt/Q9K5wGdOV7tpLJIOu2kLUqpVZDu5l4sLVRbE9W7akGW4NA7zl3q8co3n9fOIkALCqx0FpzMfzuGTt+vWwM5sAupDGoMW6hoBBxxVCHuJloMvuoir6woiKcFnOcLvbVqWpFELeABYusjyThprOK+07Fz5FAirLPgtDmf2U2n6cuCAoFfMLuCFZcWb7dy/hx/3MCk+QkeYwUEYEmYZ5cCezHfTpn4UtCKGzgu91KuIQtJ5ICUvBVrndEG2iv5M3rUce/mlAT8fje0iVXjkOA==
Received: from CH2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:610:4f::33)
 by IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 09:02:21 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::5f) by CH2PR18CA0023.outlook.office365.com
 (2603:10b6:610:4f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:02:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:02:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:02:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:02:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 6/7] net/mlx5e: Introduce mlx5e_rss_params for RSS configuration
Date: Mon, 22 Sep 2025 12:01:10 +0300
Message-ID: <1758531671-819655-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 97218606-4df9-46cb-3e46-08ddf9b6bd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lq47t/z42/rbFRxxs+UbJf2M/h2SRzvUEtlmY87Y57g2IXAnRqbSj/XPEfKJ?=
 =?us-ascii?Q?5+SQZWodKHn3qgPT3A7HFIWsSR+nUvO6tYc/ynEZQQr2D05d+fNIcRsYXENM?=
 =?us-ascii?Q?jHg0Qlv8u+ycpymFgVREmc6vxWCjXrqQvmlYkDv7VKbRaX+6lDINwe/792E6?=
 =?us-ascii?Q?6u0/CDqFAq4TfNEvXIO1P1tizYFta5x8kM6tAweGfgN0LxU/zCvbratLsUxD?=
 =?us-ascii?Q?5I0vx1VF+ag3uIsi1LL1xHs9mIBx4HEXiW+wryEbmt387XW4vLdN+qOPj7LX?=
 =?us-ascii?Q?lgBSYSdKcqaHNb8f8vu0OKPXynIaAjccVVKNPMOnzgim+7YEbgSk3A8Fa6uj?=
 =?us-ascii?Q?3Nj84IkpBdEn4jOLNaDUq6b1q1HuHaFpKJepGuUhPoNdlCwpgIpMrIhKEEuq?=
 =?us-ascii?Q?L8immT0Y04dZFWNUwNcsxRCr7a6rYrpxF/XnXpBWvLSpfj/6D/Gn6CYdJK9U?=
 =?us-ascii?Q?/e+ZI42hFC9edZU0DN9c8SAifULUyc+dnB0gG+G7qPLZjF8ymWSJ8aj1D9FS?=
 =?us-ascii?Q?a98mv4m4fytvJRzjY+4JwGI6UPftGS8/Kgfb1Pw5IK8r42yQgi4kdmmhCdS5?=
 =?us-ascii?Q?D9d+bkmAjb5EEajtUQLg1rqWbZwHopMV4cENOhh3AK+vRPksAKOW1JeYHiGL?=
 =?us-ascii?Q?ua5XtKghBUyBvGB/o2aNzb5cunzND/kPxQm9p5FIX0QiSbDQC33CJX+E7mDN?=
 =?us-ascii?Q?XgdFyDwwZN5qVcErbFb9ufaOHWoI9NjIjPGWQ4dlwz+GdDGcUGUwDNHkbR87?=
 =?us-ascii?Q?QRE+UC1UxrSJys3UYZoJ+q9WN7KQr8YVTAEstdLjEhyDiVQdisIiwM2PlrDb?=
 =?us-ascii?Q?HHa0MCAkpCwwBCIoUYEP92olXhz2AZkc+ecC7shzmn1daqbjlrh+clcA1Vak?=
 =?us-ascii?Q?AzS4s4TrS+3Pdk7FCJ/xL6h/5H8WKA/ixopHdVphJ2qqi6rH2HTT6i44LPHY?=
 =?us-ascii?Q?SuS4VL/hjPAfAtF+nDQ/SHa+Ukea3SY3lpGnHhM8G7O08jSd3U5qpxLL71nW?=
 =?us-ascii?Q?2utxJGvB0NheuCJNKGW2q3KJlqVm9DltvJhsKmGZIiP2B+7sAdtWuuirpYdb?=
 =?us-ascii?Q?qCIqTmqw+kdkOVj2cSDbrscYvqk5IUVRpuIac/jCXMQjoyeNybtc2W6dCdbx?=
 =?us-ascii?Q?Tq9eNOcMyATyHaSLnnoDjixXhbEzK+GRgTXQD/iWepaZwV3gpw3dlQxy51GV?=
 =?us-ascii?Q?Jv2zHq61Sg9GJtIqm6EA3OKqcqeImcpfI8EzkPIxJnDRzeLHRWxH0tR5L9yR?=
 =?us-ascii?Q?nCcRLR5WpMi+uT6rG3aMXkzl6dMZVrCZ29PXQmyrpkh5AMdH5yP6Kjy82xMH?=
 =?us-ascii?Q?SavXDj882r/AgMs4Gqb9nWeObdfUUUr5tL5qi5igGmPwwqKZy0LRgy9LXCq2?=
 =?us-ascii?Q?DNH1LIydr0FppRoREf9hB7pk9lvsDzMkMy5mSKxBy1rzbI6xrKIyXk9Ty+hz?=
 =?us-ascii?Q?FVVz0r3s0C9vTAz5nR/ETDV4s6bArIlDxOydgCRLKAHIIXek4Cf9Om5P8XPI?=
 =?us-ascii?Q?8Cx4B8atvUudaBnxr8sT86FOK01rM5RlzCNs?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:02:20.7050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97218606-4df9-46cb-3e46-08ddf9b6bd1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B

From: Carolina Jubran <cjubran@nvidia.com>

Group RSS-related parameters into a dedicated mlx5e_rss_params
struct. Pass this struct instead of individual arguments when
initializing RSS.

No functional changes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 36 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |  8 ++++-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 18 +++++++---
 3 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index c3eeeec62129..c96cbc4b0dbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -75,15 +75,14 @@ struct mlx5e_rss {
 	struct mlx5e_tir *inner_tir[MLX5E_NUM_INDIR_TIRS];
 	struct mlx5e_rqt rqt;
 	struct mlx5_core_dev *mdev; /* primary */
-	u32 drop_rqn;
-	bool inner_ft_support;
+	struct mlx5e_rss_params params;
 	bool enabled;
 	refcount_t refcnt;
 };
 
 bool mlx5e_rss_get_inner_ft_support(struct mlx5e_rss *rss)
 {
-	return rss->inner_ft_support;
+	return rss->params.inner_ft_support;
 }
 
 void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels)
@@ -198,6 +197,7 @@ mlx5e_rss_create_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 		     const struct mlx5e_packet_merge_param *pkt_merge_param,
 		     bool inner)
 {
+	bool rss_inner = rss->params.inner_ft_support;
 	struct mlx5e_rss_params_traffic_type rss_tt;
 	struct mlx5e_tir_builder *builder;
 	struct mlx5e_tir **tir_p;
@@ -205,7 +205,7 @@ mlx5e_rss_create_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 	u32 rqtn;
 	int err;
 
-	if (inner && !rss->inner_ft_support) {
+	if (inner && !rss_inner) {
 		mlx5e_rss_warn(rss->mdev,
 			       "Cannot create inner indirect TIR[%d], RSS inner FT is not supported.\n",
 			       tt);
@@ -228,7 +228,7 @@ mlx5e_rss_create_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 
 	rqtn = mlx5e_rqt_get_rqtn(&rss->rqt);
 	mlx5e_tir_builder_build_rqt(builder, rss->mdev->mlx5e_res.hw_objs.td.tdn,
-				    rqtn, rss->inner_ft_support);
+				    rqtn, rss_inner);
 	mlx5e_tir_builder_build_packet_merge(builder, pkt_merge_param);
 	rss_tt = mlx5e_rss_get_tt_config(rss, tt);
 	mlx5e_tir_builder_build_rss(builder, &rss->hash, &rss_tt, inner);
@@ -337,7 +337,7 @@ static int mlx5e_rss_update_tirs(struct mlx5e_rss *rss)
 				       tt, err);
 		}
 
-		if (!rss->inner_ft_support)
+		if (!rss->params.inner_ft_support)
 			continue;
 
 		err = mlx5e_rss_update_tir(rss, tt, true);
@@ -357,11 +357,13 @@ static int mlx5e_rss_init_no_tirs(struct mlx5e_rss *rss)
 	refcount_set(&rss->refcnt, 1);
 
 	return mlx5e_rqt_init_direct(&rss->rqt, rss->mdev, true,
-				     rss->drop_rqn, rss->indir.max_table_size);
+				     rss->params.drop_rqn,
+				     rss->indir.max_table_size);
 }
 
 struct mlx5e_rss *
-mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
+mlx5e_rss_init(struct mlx5_core_dev *mdev,
+	       const struct mlx5e_rss_params *params,
 	       const struct mlx5e_rss_init_params *init_params)
 {
 	u32 rqt_max_size, rqt_size;
@@ -379,8 +381,7 @@ mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
 		goto err_free_rss;
 
 	rss->mdev = mdev;
-	rss->inner_ft_support = inner_ft_support;
-	rss->drop_rqn = drop_rqn;
+	rss->params = *params;
 
 	err = mlx5e_rss_init_no_tirs(rss);
 	if (err)
@@ -394,7 +395,7 @@ mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
 	if (err)
 		goto err_destroy_rqt;
 
-	if (inner_ft_support) {
+	if (params->inner_ft_support) {
 		err = mlx5e_rss_create_tirs(rss,
 					    init_params->pkt_merge_param,
 					    true);
@@ -423,7 +424,7 @@ int mlx5e_rss_cleanup(struct mlx5e_rss *rss)
 
 	mlx5e_rss_destroy_tirs(rss, false);
 
-	if (rss->inner_ft_support)
+	if (rss->params.inner_ft_support)
 		mlx5e_rss_destroy_tirs(rss, true);
 
 	mlx5e_rqt_destroy(&rss->rqt);
@@ -453,7 +454,7 @@ u32 mlx5e_rss_get_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 {
 	struct mlx5e_tir *tir;
 
-	WARN_ON(inner && !rss->inner_ft_support);
+	WARN_ON(inner && !rss->params.inner_ft_support);
 	tir = rss_get_tir(rss, tt, inner);
 	WARN_ON(!tir);
 
@@ -517,10 +518,11 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss)
 	int err;
 
 	rss->enabled = false;
-	err = mlx5e_rqt_redirect_direct(&rss->rqt, rss->drop_rqn, NULL);
+	err = mlx5e_rqt_redirect_direct(&rss->rqt, rss->params.drop_rqn, NULL);
 	if (err)
 		mlx5e_rss_warn(rss->mdev, "Failed to redirect RQT %#x to drop RQ %#x: err = %d\n",
-			       mlx5e_rqt_get_rqtn(&rss->rqt), rss->drop_rqn, err);
+			       mlx5e_rqt_get_rqtn(&rss->rqt),
+			       rss->params.drop_rqn, err);
 }
 
 int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
@@ -553,7 +555,7 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 		}
 
 inner_tir:
-		if (!rss->inner_ft_support)
+		if (!rss->params.inner_ft_support)
 			continue;
 
 		tir = rss_get_tir(rss, tt, true);
@@ -686,7 +688,7 @@ int mlx5e_rss_set_hash_fields(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 		return err;
 	}
 
-	if (!(rss->inner_ft_support))
+	if (!(rss->params.inner_ft_support))
 		return 0;
 
 	err = mlx5e_rss_update_tir(rss, tt, true);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 80225709675b..5fb03cd0a411 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -20,6 +20,11 @@ struct mlx5e_rss_init_params {
 	unsigned int max_nch;
 };
 
+struct mlx5e_rss_params {
+	bool inner_ft_support;
+	u32 drop_rqn;
+};
+
 struct mlx5e_rss_params_traffic_type
 mlx5e_rss_get_default_tt_config(enum mlx5_traffic_types tt);
 
@@ -30,7 +35,8 @@ int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir);
 void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels);
 struct mlx5e_rss *
-mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
+mlx5e_rss_init(struct mlx5_core_dev *mdev,
+	       const struct mlx5e_rss_params *params,
 	       const struct mlx5e_rss_init_params *init_params);
 int mlx5e_rss_cleanup(struct mlx5e_rss *rss);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 74dda61e92bc..ac26a32845d0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -55,6 +55,7 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
 	struct mlx5e_rss_init_params init_params;
+	struct mlx5e_rss_params rss_params;
 	struct mlx5e_rss *rss;
 
 	if (WARN_ON(res->rss[0]))
@@ -67,8 +68,12 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 		.max_nch = res->max_nch,
 	};
 
-	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
-			     &init_params);
+	rss_params = (struct mlx5e_rss_params) {
+		.inner_ft_support = inner_ft_support,
+		.drop_rqn = res->drop_rqn,
+	};
+
+	rss = mlx5e_rss_init(res->mdev, &rss_params, &init_params);
 	if (IS_ERR(rss))
 		return PTR_ERR(rss);
 
@@ -83,6 +88,7 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int in
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
 	struct mlx5e_rss_init_params init_params;
+	struct mlx5e_rss_params rss_params;
 	struct mlx5e_rss *rss;
 
 	if (WARN_ON_ONCE(res->rss[rss_idx]))
@@ -95,8 +101,12 @@ int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int in
 		.max_nch = res->max_nch,
 	};
 
-	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
-			     &init_params);
+	rss_params = (struct mlx5e_rss_params) {
+		.inner_ft_support = inner_ft_support,
+		.drop_rqn = res->drop_rqn,
+	};
+
+	rss = mlx5e_rss_init(res->mdev, &rss_params, &init_params);
 	if (IS_ERR(rss))
 		return PTR_ERR(rss);
 
-- 
2.31.1


