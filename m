Return-Path: <linux-rdma+bounces-12220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 477E7B077DB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C721C7AFBC9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5321D5B8;
	Wed, 16 Jul 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fszxFw7w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59C23817A;
	Wed, 16 Jul 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675548; cv=fail; b=Er78pHJ9k3t9w4/ed2w2D9PdIAiNzlb08P6DtP44fUna1Z6K8qODQ73ktkPcYk/5N3qRdCLdjtRhjPtQhMBRDQ8YHuZYOq20lgpxS9moBX/vxEVBlTxb9D0bjiaylNF6G5qqVBX3JA4AfsGSY0QHdWQ0sJAAniMOwj2c7E9awbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675548; c=relaxed/simple;
	bh=asVtae8FN7QG1xzmZBjsf+Fhf6GYQ/2pGnRQTsNo1FY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xke+0MoH+WXFfvViE6p96+u4/w07ov1hklscwVuLgsDYJ/0XL6diVY8kjmPc8O0kGz3auyBHnT+LKB9+syVZZoBVM3TnP6x6BLdkWm60nGbuy+x+YPhFSRnuQR3RE3BLpatvK8ctXlPmRpwD3QZem/gYfTWP9hTlbEhSF/JRjtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fszxFw7w; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOtaz7vg46YLJh/yurvSHjKlRGSaGNAz6D+GdljB/3njYWs4fhILeQI6t9MZdd1sT0jJ04jCQ3CaN2v43gFgzmw1lKWxy5vjqDk785wcOIiFgdXfylG0pAXPfQOlmlExHS3Wgry7HyQtvjVyQUQKuC+3aenmhDmc1fmRibvt6YwPIEdIRN7DmU4ebEDK8aOrVrqE9vLcRWini1gd87PjESU4q0ODVr+s7taiWeaXFqbTFvsm6FJFkqpnXiMomO8Zf3g0KthroFduQoA/5kfc8QiyZBARpemAoGVRdigUjaAiJfEWITqTLX4uC/HLg+il4YQnEiXG+baX/ncbyQ1ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEMtBYYNpXwnS5VJgDYjifum7fD0ZyjAo8X9iwhhq8I=;
 b=sLYjEAErwXreiA2v89dVUkMIjKyHlEd2s4FVj2ew6xT1d4lbd2mz6uajHHak31C4sp48NEl1/hNaWK/0QlntCVP5ECHoRawmZAOS75XdgMnu3wpusq/BlIeoGjAFbfltYmhDzyUoQV4u9EQRp1mqzrVoiLlEQJM3D69S/AlZ5WpS+GntTDqtxCWG6X3OxisgPtl+1odyMuFDME0eEVc59PC5H8gXewVOBY1hqakFSaW7STdn3EeylR8m4WsCy519vJIn1/T41pBf3StfsHdPhL061JJa7K6D8qcOMDduJyWfuAxWVwE9q4X9fgjksIVfEYmJT6hVh0dS9IDkQKJxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEMtBYYNpXwnS5VJgDYjifum7fD0ZyjAo8X9iwhhq8I=;
 b=fszxFw7wdXbhHiiuRGvNdj9X+KlqR4dJKNjoIvNuXW/2gU9C3k+rl7uTymAjtiem2sX630k+h6NApxJbW9FCOlVoYy0eBkLwZ6yt1voLYOAJQmB3auEvejGMV76Q2sXEB1iWHHvtHXvhsjZoeQQPYZjAgDllYuRKLIv5wUViWsvpLgnugnnpQGxw3+7e9+3NzOctRfcLjkcgG7+0YoMODrrvIlQNS6ssMaNI4gA4ZuVlxUR/CUhqteocUsNxkQs2FdRNV479OVfBSFNqaQDnz1EttthOGWygcBKTelcldbXg6HukvamzkFgoICJx1M+kAkcapF/nHXjLmUotsQiPHg==
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 14:18:57 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::33) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 14:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V2 6/6] net/mlx5e: Remove duplicate mkey from SHAMPO header
Date: Wed, 16 Jul 2025 17:17:52 +0300
Message-ID: <1752675472-201445-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c42447-e0d8-4791-e601-08ddc473b2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AIQaSyYRbiZU8fCmUmj9mBQ3PbzzTv+NZgO6NMpRLij7Ls5LIF7xbXp9z/AW?=
 =?us-ascii?Q?MUpuPI9oMRlFzkKFl4dG1A1BQQLie8llDiZw+1kapULC9ZeZeTL0Rx9AnRdJ?=
 =?us-ascii?Q?JFECU0XmGzR1l3eC6oSHgILZTjaHi0dhSPUlqqThRPWojpPuR2XzBeV1SKD1?=
 =?us-ascii?Q?c0AXGL3FOhEPhkJDNtutMDK885+IMO34ljLKYBg501W52D04PrB1jYy3Pup0?=
 =?us-ascii?Q?BKjOCnGY5Bvcy8OO/SN3JSmJ8L5isTMaPkd7+ZcekrcAB/ncBlRGZeGXKsWF?=
 =?us-ascii?Q?6qIrP2fYXBbrHoPIcKVMoL0dXURehYlb7URH4PltQaI5FfH4iv+fehIwJV/z?=
 =?us-ascii?Q?L6uZp6OrJu6TNCVj8OfyiQufe7MS9oOIsLamVTnpLmhmz7H/k1A7FoIAZuS1?=
 =?us-ascii?Q?UVLlDjBt8PLHDaG+lacdM/qFxhte9orq2KL74WTPviJ+aCIuJ9r80sHLR0av?=
 =?us-ascii?Q?7EZ31abaBezU858ML4Wiks43uChGi3FAUjxtj4630NKah1R9Cot9UXyEeogC?=
 =?us-ascii?Q?O+6sAT84gSl+wIvVelkqWN3VBpKynF1ZXRqClYU2oTpy5QTPPtHtTdFYLJZt?=
 =?us-ascii?Q?Etcdu2OA8Eg7Gu8YKHCE37NLW81rIildYIBNZuO6D8aWWgk/iHCPlAOJCjyI?=
 =?us-ascii?Q?ugTilvFyOhxgmz/kEjb0oN6YNpItQKaMVt9m6bawMO2w5ryDEuWbIBFDcOKJ?=
 =?us-ascii?Q?+YdvSEkELepQpGQ1elRIuhjx/2KxEegqnvgy7UZABNdzXYFfNLklvJqjsKi+?=
 =?us-ascii?Q?PIbM2bUil9U5zdNSlMxX60VvXr0BY5R7k5dotYfSxA7kx5Rq15xS5BPsmbQv?=
 =?us-ascii?Q?tCjbfuRgyjBufh1M0Hi1slV7Dv+7zMhoWDt425jhkL1UHS82MUrqlMU0XbEI?=
 =?us-ascii?Q?AkVhR/GQRWPjpKK/pUOKeEyMsoghE0srT7mO36ZkM3ndmjjUUqVdy2+oeyXv?=
 =?us-ascii?Q?n/8aBDaBqQXC2bsU6FIuaVjA83Ua1hw4IWJkTCHubZVJW/dydAGvEuGU39W6?=
 =?us-ascii?Q?7Sr0YKqiJPmGRIjC71Pd+JRNXTrYCH7brHO7zgozav8/Hutu8rG9zEZs4UBk?=
 =?us-ascii?Q?y3oy90KMdyiiVTlRrPj388yTzAH+TIr/nLaAf+R+Tz1p/2vfYycXnkK6k5gW?=
 =?us-ascii?Q?YeV4gEd9XTvaIqUZ2t9aKTSt/mLO4LmBZPa3/6yGRVmoeHryBqlESNEVUmGi?=
 =?us-ascii?Q?FCpG97Ixbi70nX4H2voAKc9FixZTRe2kQmMiy0DlPjaN3STExHChRbQYqMwP?=
 =?us-ascii?Q?6SBxZ0VcrTWZ6zTL0yYbO5houHxqwPH0tqSLSX0plkiLlitNTdQLXgabANf5?=
 =?us-ascii?Q?25ujiKV3JMYXkl0Lx83/wkxpDwP5Jevzqthmp4TALATjslgoty1J11wQ7z0s?=
 =?us-ascii?Q?cni8NvkXIda/cDLkwrTcztbUq16mfXw7tZnU7COWYMKkXzEWZog9G5WsPCuQ?=
 =?us-ascii?Q?M5HrfJjNgUflEZIoUXRGg62wAfJ4oMmwZL6A7VEVVSmFmuAGWfwZYE7kR6So?=
 =?us-ascii?Q?Kd76bknPeP9yY/ifZUNkD1+cjBce5VdQKJ1v?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:55.5164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c42447-e0d8-4791-e601-08ddc473b2d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C

From: Lama Kayal <lkayal@nvidia.com>

SHAMPO structure holds two variations of the mkey, which is unnecessary,
a duplication that's repeated per rq.

Remove duplicate mkey information and keep only one version, the one
used in the fast path, rename field to reflect field type clearly.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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
2.31.1


