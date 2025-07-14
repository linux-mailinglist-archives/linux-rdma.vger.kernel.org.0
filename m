Return-Path: <linux-rdma+bounces-12107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B764BB03622
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8636189324B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D5211A11;
	Mon, 14 Jul 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HQR1Xo6c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EB229B0D;
	Mon, 14 Jul 2025 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471675; cv=fail; b=TX9aKws1cnskgbEvUaTqhs0N9AKa+W0wmH2ZwBzOg10PdZ+mLeYKLYkTsUlav9IeJCawCcG+7yz4xFcr8z28kNInXsQp+/3w7P2yfBPxA4QIh++n2eW6YtQuhhtBOAcrT0f/PKcSo+KF6inpHXZTWy9E+gwJiexMX+j5pjoRhxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471675; c=relaxed/simple;
	bh=BY9O3rctfmlaPW2AbLNBjqw351xRl3WtBE68q6pYcuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2lTcTvfAdUbQLo8jTfgiS94umZ6S18bniOW6YiqOPwzNSbjCeHkmfoBLuTU9LVViRaLZOkvAX+K2Ifv5krsXS18VFdie6VHjWND3BXrCPLFYCB0y/RHsngFaABKLBaBonhdKmWwL2lJ4zGylrUhc8LI//pH8VYptdovb5xA8oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HQR1Xo6c; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr9O1A+bYRWVQPKDCaR6JY81+LV8MLwGlpEo5Z2Y+7tSniJs+OwelXjRSaFZMLYVIzUyywTENGEL2sJT6UgloB2AWqMniQjKVgqOI9asFSDztJafuonJjW9jw+WIhJdAg44JdrZa5I7rYjB5VvNdp4kkPQTjC6l03vqUKL9hoMeOBQqElRy2i//O9qHh05B5Vtl/tiZfwPlPM5LqxPxWV6VM6utgZFkGBBn7OV3f/e2D5aOtvyeXHWcAm2HXuZV8+xyvBYx2T0UvVHLO3nJKafmvMbgv1s65bsA8ODdPH9MujzOi9LZX+idZz1gdeTkVfOOoZ6sgQJsQDZ5Sbn+29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4/irpDPFdP8gJd25WUFJ+WuN2FQg5MmwhtF62cg6mk=;
 b=PU/PSCVzT75ywH/Ce/8wrTvwl3rLq1cRodIU/NG3oA9JbdTxYR9VSg1TM9sPaJTauqWYG9ernWN5kbsbuN3d0gDlJGgEYr1SFBcvV92/0rblky765pWLrjT/PKgk6NLVsw0YaYbGskImvMAhnppmoGfymwHZiYtjjdVWRM0Uk1jCLZJZFdutEX04wl+8PrrMfjQ/ZPyxjmg9+F/S42IoajYgrhd1wwYvoV7P1otqVyQ+tuwIH+MrUhN9zMD5bRYpWmTHyXo6ALoqFJ2puJi5sqbmEBAzj6c2uetvDKGKZpI1aEuJNZz9JG9hdY3VRBrJMEp7x6oHQeh6RzkrfV5Phg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4/irpDPFdP8gJd25WUFJ+WuN2FQg5MmwhtF62cg6mk=;
 b=HQR1Xo6cbhF1gG9muiufMjk5gyCccJJ3sL6yFEyBFJfEJNYyfjjv5Q+auO/5Jb5NE65X0Rmj81/HHokLeiB/jIQ8PvEvMsbAv7woML1B9268dehLkKQLa6nXnOstb8WSHmxnSk3yyvrbEK0m9bZhAG+RBWzjDGQjXikhcRdv6vURoWE8yB/pkLA9L7VzlyLj8VG+66odmACQ2nTenoKgDK9l9u5Q/RVrbnDOSEXyqOp6TZiWfSPyAsK15gtVZ+udP6qT55aJU5kFHo8xJEbp+KrBmANAQO7vfft51zxoKSuK0PyqCUmKm2V+PxkmyfJDPynq+T15d3mZwZsFGq1u6g==
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 05:41:09 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::78) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Mon,
 14 Jul 2025 05:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:41:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next 6/6] net/mlx5e: Remove duplicate mkey from SHAMPO header
Date: Mon, 14 Jul 2025 08:39:45 +0300
Message-ID: <1752471585-18053-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca5b3fa-551c-4468-0667-08ddc29908d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yi9S4MRGwOxpwdcAI2RYnCQn512JLlFMRJTKp1yUfoMmIJYst147MTFfqfZs?=
 =?us-ascii?Q?FDxoDr6dV53xDtM3W/o503yBOOyICFmIzBzkdUE8tyGtIIjE/wTujDwBpy2y?=
 =?us-ascii?Q?aPskwHQ+HlQH5ETj5+8WFZihzlEp5a+oLVJ1USEaRo5arETG86vH93756eDS?=
 =?us-ascii?Q?lFGuUbEItdZXRx9HrcUyZ10pNw7WB0LA8b3tqgx0JBPMYqnbuKtzP627skjf?=
 =?us-ascii?Q?+y4jUgN0Jtx7ogexowX/8+40udsMnNLvO+LmgZamaZMl2zcI7WKQrjiQ4VBv?=
 =?us-ascii?Q?l5XCi5TPHG8gSWlCSze/wDjvnaJY2247OlOP4Khb6FeqQ3Z9YafzvuSGu3pF?=
 =?us-ascii?Q?Pz0mWpFegFNxpZDCFCO0bd+ERULrd6C9Vzk+I+9RjUKCXCZ2LOs569al30VL?=
 =?us-ascii?Q?JpzhUqLuXXTmt9zvyC2xniAkZQN8OzFNoXA8mZNwXcPAVxjdHTlaf4uvGk8/?=
 =?us-ascii?Q?qfQ0Z4TBMO0lkNmXLe/0SUStr5PeE40ecOYkIE7ebRxfVXX3K/lfMWMg8gqe?=
 =?us-ascii?Q?i5IsXPSKfeLvrgHX0+5A6GE1BgeLAIyluXL7AkfzDI+YjoCM/xEHkLyVZbxi?=
 =?us-ascii?Q?KyIvvgfNLrciZB0mTqYRNgGVhi2/e/7RYdKZe80xOzbXS/XenJ9BYkqEt0JO?=
 =?us-ascii?Q?OwujVlv1dnoYDusHfVjnokQaivw8CFjYJ95aILOBhL7A12moco35c5/vt+ie?=
 =?us-ascii?Q?xHVHTa14Oitr9pUBGi1MtXTVGA+rcEyRAW4sHaKLC6IkJuEpGcbrJumiIfGS?=
 =?us-ascii?Q?Yr6ySVb9c/7qEzEdcvvAF39X+ldpFzjEP9Lxx2DDdeNqLmFF8frI7uwv/vw2?=
 =?us-ascii?Q?xALm4NocF8/jXmwlJeLYxD+GlwtEvft+UCGUNBXuVHPYeBagEEf8Cxxr+ms4?=
 =?us-ascii?Q?Zvk9XiKva9LAdJrp3WH7xNHFw1d+qXeJ/gY//0oY5EGNeguoDgEB6H9H7kOu?=
 =?us-ascii?Q?80B1zuvKxtwFPzuUTjLoN3c1v1Cr+cDDwWV2YAGHz3/OEiU7hid8bBUUGAuw?=
 =?us-ascii?Q?aCljioJpbD794tvdC8R1sRra8wWM9QrWRKiIkkbDm6FeoDUwwHv96Gw6InjV?=
 =?us-ascii?Q?HzPgAsbfzbjd+dYgSpVf7/eNPTyvBNh5tnjUmKxsHopep+2TMGY0Tn2CXTxI?=
 =?us-ascii?Q?rM/aFuboRKpsqzs5pojXGh3w68i+72QYlrQhC3k9xYcSRI2FLsueepZitVlH?=
 =?us-ascii?Q?wPBboc99WhTMrc8EoTJJK3YV7+xKg/HE4wNtxZ1dUrGTX/7E0ZhFRkWrO5Bm?=
 =?us-ascii?Q?cllxmWCxogYayj8RS8oBDAybhvq74wkL06NAL8v0za5srwbknnqLmeqbBr96?=
 =?us-ascii?Q?M359Lt6cRYoHLahhq0+PKxSrAgfbfjtwnGehzcZIX67RWY82ZGB30XG09crz?=
 =?us-ascii?Q?J+zIkypY2oG1legWSUIyyv2hF5fQ3jmEpih4lXjoTiNHv0/rTU3VZq+34Y+O?=
 =?us-ascii?Q?Bx8wn9+gEj5rLcutH8FZs5ade/Ee51bebQL/acOpPQXNZ/VYBPT0KyzlMGHR?=
 =?us-ascii?Q?epFAGSfmwcRymVaee1GFm4k7K1uWXZFQXsXN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:41:08.8811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca5b3fa-551c-4468-0667-08ddc29908d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

From: Lama Kayal <lkayal@nvidia.com>

SHAMPO structure holds two variations of the mkey, which is unnecessary,
a duplication that's repeated per rq.

Remove duplicate mkey information and keep only one version, the one
used in the fast path, rename field to reflect field type clearly.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 22098c852570..2f9fea076c00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -630,14 +630,13 @@ struct mlx5e_dma_info {
 };
 
 struct mlx5e_shampo_hd {
-	u32 mkey;
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
-	__be32 key;
+	__be32 mkey_be;
 };
 
 struct mlx5e_hw_gro_data {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fee323ade522..cc1e134f9734 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -545,18 +545,26 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 }
 
 static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
-				       u16 hd_per_wq, u32 *umr_mkey)
+				       u16 hd_per_wq, __be32 *umr_mkey)
 {
 	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
+	u32 mkey;
+	int err;
 
 	if (max_ksm_size < hd_per_wq) {
 		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
 			      max_ksm_size, hd_per_wq);
 		return -EINVAL;
 	}
-	return mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
-					 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
-					 umr_mkey);
+
+	err = mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
+					MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
+					&mkey);
+	if (err)
+		return err;
+
+	*umr_mkey = cpu_to_be32(mkey);
+	return 0;
 }
 
 static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
@@ -782,11 +790,10 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 		goto err_shampo_hd_info_alloc;
 
 	err = mlx5e_create_rq_hd_umr_mkey(mdev, hd_per_wq,
-					  &rq->mpwqe.shampo->mkey);
+					  &rq->mpwqe.shampo->mkey_be);
 	if (err)
 		goto err_umr_mkey;
 
-	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
 	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
@@ -831,7 +838,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 err_hw_gro_data:
 	page_pool_destroy(rq->hd_page_pool);
 err_hds_page_pool:
-	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
+	mlx5_core_destroy_mkey(mdev, be32_to_cpu(rq->mpwqe.shampo->mkey_be));
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
 err_shampo_hd_info_alloc:
@@ -848,7 +855,8 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 	if (rq->hd_page_pool != rq->page_pool)
 		page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
-	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
+	mlx5_core_destroy_mkey(rq->mdev,
+			       be32_to_cpu(rq->mpwqe.shampo->mkey_be));
 	kvfree(rq->mpwqe.shampo);
 }
 
@@ -1121,7 +1129,8 @@ int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_cou
 	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
 		MLX5_SET(wq, wq, log_headers_buffer_entry_num,
 			 order_base_2(rq->mpwqe.shampo->hd_per_wq));
-		MLX5_SET(wq, wq, headers_mkey, rq->mpwqe.shampo->mkey);
+		MLX5_SET(wq, wq, headers_mkey,
+			 be32_to_cpu(rq->mpwqe.shampo->mkey_be));
 	}
 
 	mlx5_fill_page_frag_array(&rq->wq_ctrl.buf,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 2bb32082bfcc..78159a5e7bbd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -676,7 +676,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(ksm_entries);
 	pi = mlx5e_icosq_get_next_pi(sq, wqe_bbs);
 	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
-	build_ksm_umr(sq, umr_wqe, shampo->key, index, ksm_entries);
+	build_ksm_umr(sq, umr_wqe, shampo->mkey_be, index, ksm_entries);
 
 	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
 	while (i < ksm_entries) {
-- 
2.40.1


