Return-Path: <linux-rdma+bounces-11141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E88AD3C56
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 191507B18C9
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A25237172;
	Tue, 10 Jun 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sSb1ok5a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D900235073;
	Tue, 10 Jun 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568266; cv=fail; b=BH6sXQ4xy2GDXlVYvQUgQBNvJ5K9FEYBs3SZ6DlHBkfTHz5G6jCJaKD/FPtRBla1aC7/cfti5RgClsYmMX5EtkaIJtNI7THYV25bl1PvjjoKE4jjcIrfA2EOReZlq978hF/2cMgpBGkkyu7SqclVP7LP8pbXMXQdI9cMiFPCvTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568266; c=relaxed/simple;
	bh=Xgx/dPfVS+Tkzxi3CaWGdOyCIJe70pIQDr2I5eF6M04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RY8XnQM0zbDSvBCBnfAi2nwTYoqLaKAS4xYI8BrgzYyI7P/oAq3LHAdNHldsPLurOyB/1fjZqQ5J9LFmx6TsNM+pZ6B/3wYNUXpHRKTTzq3TK6neimniDSJqNQxSfEyW6bmkljJS9U+a1mchzi0lbyBvcwmHuU3vrW1lgJ451CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sSb1ok5a; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9nlaqIHeVQC8UT3rReideaF2Eh/5m7RlnJKFTqsMxZs0Unxo2R1fNmevlqZuqnAoMcYOClU6HQyKnSoO9OZINA2FrpzRJFLDhNA/QiYkASzOUUrR30AyiWp0La+QVJyOjXe2pgQ+IEA9iapv4cRHE/WE9lH3FXsYXDJxqFc7WAn05cfSjpkTRH/y67TglInldDr/uAgEvvJTMAa9qcTQXztJqLja0MS+y5Y0BWXeLFxXeNWRRl3XyaeF9hRobPsluty3r1VxDXgF+MyzlrW8L7ZQSurAihPRPpqaHumsKNTRqwp0q/B0rKIAuBVr5lflJ3rlqiXDsiMja4iW0xy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=QT41f+Rb7yvkzye9SzvPKLwxGg0zlK2W40vCiefy7DIC/6bwVJgEXgag+RPTInYk8oYVYotNKOAH52q3oOEM2l839ismvvzbWiok473EuR+uyDrX6Tq1gSWh5odf4wR1qnVgfMAYRz2Nl/UDp5ekP1WLsxxZBpeLkzy/L7buu0Q9LKe002dJ2Z/JPuFL58qoAWArqzUde8YGMlnUj16zg70s8V09Ya9lSU/dmDJopedeOvc/Exee5iuKXA1yM7mcAMEj45ADCvtf57+PEuvLFCQ9OYI8lMil30rQrNAKvKJh3d8Raou3YHhHfQR5vByFKWFDUiQhE8M+rrG5Fk52AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZmdD+pOnRRieqlX3rygkvIpgIXGt0BMPDG4T0Q4HmY=;
 b=sSb1ok5aBnuW3Hm0QJrGs2RXfkRUbw9nWPbq8ggMbRGjd2THna5TZlyzcaA0Q6eR/l0240ataBwnAU0IZ6JRkX8j+C19/1FOqtyijhAc3TCFKdAX2TE2exfQYnXmZPh+lBrS83IjaRG1JabICbAta46vRekBSDHzDIE36GWCl6bwrV4XA/rW6km5mwU+YNBt/uLo2GN4JAZ+vRbvD3MsNsLjbGl4KU3W58/df/DibmV4TqXt+oCsHmjSODrNKK5e2s8Hg1/bXUNPr1QEAnf1Oyax01V770GTQvD4Jav8nV2ff4T4RPAaB0HUV0AEBwmphMhIZdznmKMsNJ1dox3pVA==
Received: from CH2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:610:54::29)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 15:11:00 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::6d) by CH2PR11CA0019.outlook.office365.com
 (2603:10b6:610:54::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 10 Jun 2025 15:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:10:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:10:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:10:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:10:29 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 03/11] net/mlx5e: SHAMPO: Reorganize mlx5_rq_shampo_alloc
Date: Tue, 10 Jun 2025 18:09:42 +0300
Message-ID: <20250610150950.1094376-4-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c47eb5-ce07-4deb-5a78-08dda8310223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?btTU9MSA4mr/b3qEAW1ouotFUiHYVoz4NbaK7B3bxKTTpIJGJJTuOS3cCXFJ?=
 =?us-ascii?Q?nlDJdF9bEIGB2zIBgqNoi6sN1v00Aubj1lse/YiRW/rwUqV3Rd67wHHIfRb/?=
 =?us-ascii?Q?EJBqr45cWBrTLXoCHS/MdQiBAV1MYi3Yrj8GzmaHK0PBX/eh9xqHNu1lCuNZ?=
 =?us-ascii?Q?RBEbdPfvq43t2T7WZWJfRVYjWKuXXIzNPrd/RLmKT/gXLvabbpRAI4bTPJMS?=
 =?us-ascii?Q?6drn5szCGmtglomvCXudScxc2PZg96CJ9UDoUFb3UsyMsU+ThPqbfxdZ2B3p?=
 =?us-ascii?Q?DuwF9KWVKIXfKAvTWYy18lwp9rAAQcJ5MwYfhwQiO8BrDRdeAFlVOnwX5j1x?=
 =?us-ascii?Q?8559wPS6z6rZABXLOHWW4OeLLmWOONGiYsRJUWAlpcbJKOgfryZ7wd4WBIHY?=
 =?us-ascii?Q?NBv5EoJK0JZ1Y8+yAdXLr/61inOyHw3J3jessGdIFHoRku0dqayzN3WYjEX1?=
 =?us-ascii?Q?ZBCApLIGnnUDvhYz1xJPEePof3tXRFUOz63JxKMCjbNfZINMn7jXDDiuvJfd?=
 =?us-ascii?Q?5XvouVmDqKIPDXNivixTvvNTF+40lSmdx8a/DAUvXbw1AIL63qvaufY1Xzg/?=
 =?us-ascii?Q?ItdmoNzNc8O2TH6fscAuWCIMUS9Az2e0qGGze8a4zLC41g5TjMlpufewIkzO?=
 =?us-ascii?Q?RiXs1CoOtU1kStuGbtTAaea5dwlPG0xvqm1IOZ5dnJZshXix2I4adUhy3uQc?=
 =?us-ascii?Q?9KltQdgRzeGzvPhq4CKvJMLt0VBHYM8IFYSo1EHc7uRtHbU96uRaxCho0X1G?=
 =?us-ascii?Q?Oej/SYoEotcjMl3y6plrBL0tvRYjCI7plwz76EkZnUgDYCND1XnkTho5x8pc?=
 =?us-ascii?Q?iADCpzAjOqgXTgHab8EQC8TRF/ycovYQtCgL75Qvv6lm3w1UmSUXI/JwA3+H?=
 =?us-ascii?Q?fTEEXAGPf/2Sd77aT5vTXi/PuXFD4M/0T4jydAcrC17V83AbF3U/LyqTUPGi?=
 =?us-ascii?Q?2VHlgDGZH8Zic5EA4W8BhgmAsA9ZN8YpgvJuOHPZuN6TWVW0ii0xsPWN98bU?=
 =?us-ascii?Q?Ps3vcmOD2wjJDpEtGYrGs6sELS2F2ZDTrIWIKWwunTjjgBY+Y5/InjNOv1E7?=
 =?us-ascii?Q?GXWUcIlnJpMm5a9F5fSyNThN6pRhoYMy+mwuutH/Bmp9ss37JEIQzgsFN8Gg?=
 =?us-ascii?Q?XU5t6Pbe3Pc+PNVVf96wM7OQnVcVLdLsZkeEt9dY2sdj+vpaLL9RAb1HTKyV?=
 =?us-ascii?Q?Xb8mWqveUC3aDW6iFpNtx+089OZc8+vldO9e+cSSMtZqEzAUN2lwrjz29ObU?=
 =?us-ascii?Q?nN2SAm96pGed12UzJDcCBp7IyeahthxRkph0P1ndPyFGKHwqznuKPYyc4nVj?=
 =?us-ascii?Q?Q+I9YahLYpGZaVYuR4Y56HsO+t+0A0vM7hl9cYvxaeDhvvrSknjFUjrPypuL?=
 =?us-ascii?Q?3cuOiC7hwNoEVc9UBnpMsrXbeAEDMqNzkaj5PWPrMAO/xBlUuCEumOaMsioD?=
 =?us-ascii?Q?7sGgrr4jItVhr6dUK343ffijO0zK+5Wwc2MiCVxgIyIPGnR0j06/dvhHXTaf?=
 =?us-ascii?Q?0GBTgVG4hsV8q9vdZcstAUfD7EpeRUZbT87f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:10:59.7067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c47eb5-ce07-4deb-5a78-08dda8310223
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993

From: Saeed Mahameed <saeedm@nvidia.com>

Drop redundant SHAMPO structure alloc/free functions.

Gather together function calls pertaining to header split info, pass
header per WQE (hd_per_wqe) as parameter to those function to avoid use
before initialization future mistakes.

Allocate HW GRO related info outside of the header related info scope.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 135 +++++++++---------
 2 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5b0d03b3efe8..211ea429ea89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -638,7 +638,6 @@ struct mlx5e_shampo_hd {
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
-	u16 pages_per_wq;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..3d11c9f87171 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -331,47 +331,6 @@ static inline void mlx5e_build_umr_wqe(struct mlx5e_rq *rq,
 	ucseg->mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
-static int mlx5e_rq_shampo_hd_alloc(struct mlx5e_rq *rq, int node)
-{
-	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
-					 GFP_KERNEL, node);
-	if (!rq->mpwqe.shampo)
-		return -ENOMEM;
-	return 0;
-}
-
-static void mlx5e_rq_shampo_hd_free(struct mlx5e_rq *rq)
-{
-	kvfree(rq->mpwqe.shampo);
-}
-
-static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, int node)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-
-	shampo->bitmap = bitmap_zalloc_node(shampo->hd_per_wq, GFP_KERNEL,
-					    node);
-	shampo->pages = kvzalloc_node(array_size(shampo->hd_per_wq,
-						 sizeof(*shampo->pages)),
-				     GFP_KERNEL, node);
-	if (!shampo->bitmap || !shampo->pages)
-		goto err_nomem;
-
-	return 0;
-
-err_nomem:
-	bitmap_free(shampo->bitmap);
-	kvfree(shampo->pages);
-
-	return -ENOMEM;
-}
-
-static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
-{
-	bitmap_free(rq->mpwqe.shampo->bitmap);
-	kvfree(rq->mpwqe.shampo->pages);
-}
-
 static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
 {
 	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
@@ -584,19 +543,18 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
 }
 
 static int mlx5e_create_rq_hd_umr_mkey(struct mlx5_core_dev *mdev,
-				       struct mlx5e_rq *rq)
+				       u16 hd_per_wq, u32 *umr_mkey)
 {
 	u32 max_ksm_size = BIT(MLX5_CAP_GEN(mdev, log_max_klm_list_size));
 
-	if (max_ksm_size < rq->mpwqe.shampo->hd_per_wq) {
+	if (max_ksm_size < hd_per_wq) {
 		mlx5_core_err(mdev, "max ksm list size 0x%x is smaller than shampo header buffer list size 0x%x\n",
-			      max_ksm_size, rq->mpwqe.shampo->hd_per_wq);
+			      max_ksm_size, hd_per_wq);
 		return -EINVAL;
 	}
-
-	return mlx5e_create_umr_ksm_mkey(mdev, rq->mpwqe.shampo->hd_per_wq,
+	return mlx5e_create_umr_ksm_mkey(mdev, hd_per_wq,
 					 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE,
-					 &rq->mpwqe.shampo->mkey);
+					 umr_mkey);
 }
 
 static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
@@ -758,6 +716,35 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 				  xdp_frag_size);
 }
 
+static int mlx5e_rq_shampo_hd_info_alloc(struct mlx5e_rq *rq, u16 hd_per_wq,
+					 int node)
+{
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+
+	shampo->hd_per_wq = hd_per_wq;
+
+	shampo->bitmap = bitmap_zalloc_node(hd_per_wq, GFP_KERNEL, node);
+	shampo->pages = kvzalloc_node(array_size(hd_per_wq,
+						 sizeof(*shampo->pages)),
+				      GFP_KERNEL, node);
+	if (!shampo->bitmap || !shampo->pages)
+		goto err_nomem;
+
+	return 0;
+
+err_nomem:
+	kvfree(shampo->pages);
+	bitmap_free(shampo->bitmap);
+
+	return -ENOMEM;
+}
+
+static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
+{
+	kvfree(rq->mpwqe.shampo->pages);
+	bitmap_free(rq->mpwqe.shampo->bitmap);
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -765,42 +752,52 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				u32 *pool_size,
 				int node)
 {
+	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u16 hd_per_wq;
+	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
 		return 0;
-	err = mlx5e_rq_shampo_hd_alloc(rq, node);
-	if (err)
-		goto out;
-	rq->mpwqe.shampo->hd_per_wq =
-		mlx5e_shampo_hd_per_wq(mdev, params, rqp);
-	err = mlx5e_create_rq_hd_umr_mkey(mdev, rq);
+
+	rq->mpwqe.shampo = kvzalloc_node(sizeof(*rq->mpwqe.shampo),
+					 GFP_KERNEL, node);
+	if (!rq->mpwqe.shampo)
+		return -ENOMEM;
+
+	/* split headers data structures */
+	hd_per_wq = mlx5e_shampo_hd_per_wq(mdev, params, rqp);
+	err = mlx5e_rq_shampo_hd_info_alloc(rq, hd_per_wq, node);
 	if (err)
-		goto err_shampo_hd;
-	err = mlx5e_rq_shampo_hd_info_alloc(rq, node);
+		goto err_shampo_hd_info_alloc;
+
+	err = mlx5e_create_rq_hd_umr_mkey(mdev, hd_per_wq,
+					  &rq->mpwqe.shampo->mkey);
 	if (err)
-		goto err_shampo_info;
+		goto err_umr_mkey;
+
+	rq->mpwqe.shampo->key = cpu_to_be32(rq->mpwqe.shampo->mkey);
+	rq->mpwqe.shampo->hd_per_wqe =
+		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
+	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
+	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
 	if (!rq->hw_gro_data) {
 		err = -ENOMEM;
 		goto err_hw_gro_data;
 	}
-	rq->mpwqe.shampo->key =
-		cpu_to_be32(rq->mpwqe.shampo->mkey);
-	rq->mpwqe.shampo->hd_per_wqe =
-		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	rq->mpwqe.shampo->pages_per_wq =
-		rq->mpwqe.shampo->hd_per_wq / MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
-	*pool_size += rq->mpwqe.shampo->pages_per_wq;
+
 	return 0;
 
 err_hw_gro_data:
-	mlx5e_rq_shampo_hd_info_free(rq);
-err_shampo_info:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
-err_shampo_hd:
-	mlx5e_rq_shampo_hd_free(rq);
-out:
+err_umr_mkey:
+	mlx5e_rq_shampo_hd_info_free(rq);
+err_shampo_hd_info_alloc:
+	kvfree(rq->mpwqe.shampo);
 	return err;
 }
 
@@ -812,7 +809,7 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 	kvfree(rq->hw_gro_data);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
-	mlx5e_rq_shampo_hd_free(rq);
+	kvfree(rq->mpwqe.shampo);
 }
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
-- 
2.34.1


