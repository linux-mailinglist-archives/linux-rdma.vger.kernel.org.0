Return-Path: <linux-rdma+bounces-4743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C379496C273
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C3A1F2640A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918564778C;
	Wed,  4 Sep 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gdYirdI9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01C2C95
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463865; cv=fail; b=QiJkNAoqPx5eZxxqj5cmVwCv6WV58l+tiBzulEVY83w2BZsZrWgEy7F1DLWgcB9gECG36cMLmYPV49vJR1EWsrNd/l+/1X3fzNITMUwJpgyaSQUCvpIoLBA1/7udLXn5bE3ytpFk2k0fbYu5PLA+FMBK85VLTU9Y2ruUFS4CoWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463865; c=relaxed/simple;
	bh=BmNtBdEXtMOgKrCTQgsc4df78FABQr/ox4uBXdK7IkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqabpUAeEapoZoyBKceaLsX3xOZBbSR3jRuEibqAfy+DuwXaIV5GIXFmDAfpKpS2XmoPBamL8+oRMW7DeJ8WZtEjyyGnN+bZ4nZHFKiqndOkcUl2qC+mshyD0Wk28b9YPNg/FRcMbmscdFMRd9l5WUzxNWyszQt+OSVHUFCq7I8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gdYirdI9; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CccxKkFzNJ4to+WVHZ5YOhrq12kNJAAdtIYxvqSFI7tzcN39UmQFK0IQuq4rWyNpuB2+4qgCKgjXONHHbZXC35zdNX6ftMVzOA3YWS4e1jMm4BPt9GvyOBjL3KndLjYawwOQkZgjR1EcJjbBYJaLoNQ1sj5NEg3WQkqJjahw4K9O4KUm0k5v3BUZSsOl/VhlOxhBTq0rETK9pVQGgLEPXoTf1+Z+Wl2b1+4gZfMA2f24Q1WhFNJmejXKeUHSNHUYalwElbCjZybQTnY/pozkq3jqQDwVCweSfwg3vj9yNpwEup1kA7NBPC2kqAq5L0JZdOfPXBtHp5Az5vwp8ETqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTdXFVTLs5/DNoAOBGdDmb/7yxwMAGtzNYK6kvPuuyU=;
 b=QX/OQS613BhqgVOi9E44jLlqQqDunSTqM3mh+jvOB3gmavcbUMF9FnVQdJaoFuz/afGV6NWAv6OHxzbQGhws1yLvwE/zc1vb2tAeHZQ3H73rVwMFEO15VfmSApH22xeyY9zrpJ4dZANwVP/BxE9lb8y8j/3Lk8t0TLRj0mxnVEcj3RbKcWxtmpjUtNTLFUtXQVoc9XLQpec/Kestvfy/WOseHJsEFUK9T+aaXTv3xa6uZZW/Dn6QryT4Zx6n7BSMQTwE6eG2CxnLKV27j+05ya8Lr23kAfMu8vzH+zR0O4k0afyuunsShwpm6i4bHnoDZtew3gPjvzGy87mcgfUZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTdXFVTLs5/DNoAOBGdDmb/7yxwMAGtzNYK6kvPuuyU=;
 b=gdYirdI9FdFLhi7VuRKU0vHwNgMOzPOS2QEkVzk32Z5pLY1wWJAbxiP42B4W3qkRZpiuI1b46ZtcMdyLoInZK2M3nx3EnA1FLQrwHHWmElJ/pvr6jPmECa3zkP3jwsYjm7UkrwYzjBb7QjIK6DeXxgXgBjkemVRGFqG1Zz3ykCL+433sZb0TXyewejSrEdI10SyfX2eDqWyi7V4jmP7CHPajYur6K228Yl4UqBzonkBTuBhu4hv7kUQDNDKpJt8YO2SWPD1hdcDoB5+NDWp0G9/DMy7XVoPF57fNfu7DcKBwak/JLKeIm7C8zgZNN+RGecVFJWClaxacYHcOS2nbIA==
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:30:58 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::5f) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 15:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:30:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:30:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:30:44 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:43 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/8] net/mlx5: Expand mkey page size to support 6 bits
Date: Wed, 4 Sep 2024 18:30:31 +0300
Message-ID: <20240904153038.23054-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240904153038.23054-1-michaelgur@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: fa602229-6617-4c07-ea98-08dcccf69357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p8R7gBZnSbU66AJeZ9t2ZsYtnGMlwsxrLu1EN1tTUpCP+HkwLtFnL+cdSpxC?=
 =?us-ascii?Q?AAabBNuadE1uAicCZd5IFNQu8yifba6FN/VKf9+YjDjVJlIPZq3QSZ4Bm3hs?=
 =?us-ascii?Q?bJzylQzHmlElJKBzkkdNFzn2iP7xaixCvZv58T/xXnHG1ZHQisk2bIfLDXde?=
 =?us-ascii?Q?r81P0+t3Qi3rwrEMhNFEDc+msoOH9Dccjd6lK+VP6wvcyCrq85tzcLWvEY5A?=
 =?us-ascii?Q?hnkCO1R1KYzQI7SGgyfuDplbjORTXGPwAiWHsEr+7dI0lXIv+0Y0td9Esh2k?=
 =?us-ascii?Q?V8P9tEtddoK8NbmPmODcyXXqwFzSWYZcpWeFFxz8Cm3k1Keo5+I0vOwoINdF?=
 =?us-ascii?Q?adIQdvu+WVOJhNZ+XZRAxzMtaWyWfbhUlgu5uypa2bPVMpPZvbXJ2QfZOEz3?=
 =?us-ascii?Q?TyB1M0l3bHOdtQwklEMKN4mJxP2QTtqv8IvT3O7noYmkorX80ijBOfNz0bUa?=
 =?us-ascii?Q?svuABbpLBIDRRwusKGUUU0r3SHZxP6oyrmrk0ULwoT+XEsqHOHQcw5H+UsSH?=
 =?us-ascii?Q?lZ+PFsV64FCnHBHALVFi8IS3HBeLApV4T5IMRgWRNsL9CZOVz7v9lBDZ9lmg?=
 =?us-ascii?Q?gG7AHUfxad7TeMD8q5TZ/HbDMw9U/cSmDQPiIiu4IAsox73Ks92Hdun5jwuw?=
 =?us-ascii?Q?40/edXE+U1lI8ARYgRtFTy339+VFGae0sG6RdLI01gxcceAGVsikaOOmw/Bj?=
 =?us-ascii?Q?FKWmdjt+aOkJs0M9ggXe3KMhhPbcymB772kPs44ylVWST4atx3QQnFfB5uJ0?=
 =?us-ascii?Q?hPeldlW2lOADh0t/eIgyMQ6AOlZXJgJpPmSOLefrcvWk7SLOQ8hnsWX1iG7D?=
 =?us-ascii?Q?fy2fN68y24wY8sII+EcE2J5NAuDUEcEeWVOGrjABBLCsjuuSp7kY8FtGZsoy?=
 =?us-ascii?Q?zPenGy8mLEgqPEuYeHFdGb5Ayj7FC8t/SWUSeeeSgxkADUfLL71HhIuMPhxx?=
 =?us-ascii?Q?AmSE31yXgi6qmw1Mb94a6fdkMUCepoMUskqHGIK7KU/7nwgb2Bvc7n7puV/K?=
 =?us-ascii?Q?S6HRhKfBnDDud6InXf+8yu2zAYUA+nNxrrSzZRkcAmKpgyvlo5SepT2+ia8/?=
 =?us-ascii?Q?6At6V4GeTfrfpc2answyKu18o3M95gVTu4vy4Wur6FuT8uu8Bw3AwnQYkxuU?=
 =?us-ascii?Q?rqDjCDYPabBsEgWdqOdZTQyScKUoEOfrMsSz3Kx1j/3pgwYw1+bzazzcezyo?=
 =?us-ascii?Q?doW5O7aPkZqgPtOOAPfKRNGimPEVWeiB+9SFPfiBIvWQ9TlYzaTGnYMcW8c9?=
 =?us-ascii?Q?T0FwCGpp5bdDnO677TQKvPZ1ymvIj255QTXmToERfwaZ4Pi6PVDxnd1ESj6t?=
 =?us-ascii?Q?5dd6hD7YGNpEbUkoqib+bcyalzhzTk54TXN80SspDneq2UR4cyOk7/cLEmMB?=
 =?us-ascii?Q?JjMcR2p9zSECvecfR6XxpbNWVpOVT+f0dFX+H0S/g1sRcUQkTFsR4jg03QX/?=
 =?us-ascii?Q?OdXAr6qo9iDAtrNtx7LUZEhxziNih//w?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:30:58.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa602229-6617-4c07-ea98-08dcccf69357
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

Protect the usage of the 6th bit with the relevant capability to ensure
we are using the new page sizes with FW that supports the bit extension.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 ++++++++------
 drivers/infiniband/hw/mlx5/mr.c      | 10 ++++------
 drivers/infiniband/hw/mlx5/odp.c     |  2 +-
 include/linux/mlx5/mlx5_ifc.h        |  7 ++++---
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 926a965e4570..89c2ab728577 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -67,12 +67,14 @@ __mlx5_log_page_size_to_bitmap(unsigned int log_pgsz_bits,
  * For mkc users, instead of a page_offset the command has a start_iova which
  * specifies both the page_offset and the on-the-wire IOVA
  */
-#define mlx5_umem_find_best_pgsz(umem, typ, log_pgsz_fld, pgsz_shift, iova)    \
-	ib_umem_find_best_pgsz(umem,                                           \
-			       __mlx5_log_page_size_to_bitmap(                 \
-				       __mlx5_bit_sz(typ, log_pgsz_fld),       \
-				       pgsz_shift),                            \
-			       iova)
+#define mlx5_umem_find_best_pgsz(umem, dev, iova)                              \
+	ib_umem_find_best_pgsz(                                                \
+		umem,                                                          \
+		__mlx5_log_page_size_to_bitmap(                                \
+			MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : \
+									   5,  \
+			0),                                                    \
+		iova)
 
 static __always_inline unsigned long
 __mlx5_page_offset_to_bitmask(unsigned int page_offset_bits,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 73962bd0b216..0b52f080879f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1119,8 +1119,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
 	else
-		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
-						     0, iova);
+		page_size = mlx5_umem_find_best_pgsz(umem, dev, iova);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
 
@@ -1425,8 +1424,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT);
 	} else {
-		unsigned int page_size = mlx5_umem_find_best_pgsz(
-			umem, mkc, log_page_size, 0, iova);
+		unsigned int page_size =
+			mlx5_umem_find_best_pgsz(umem, dev, iova);
 
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size,
@@ -1744,8 +1743,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
-	*page_size =
-		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
+	*page_size = mlx5_umem_find_best_pgsz(new_umem, dev, iova);
 	if (WARN_ON(!*page_size))
 		return false;
 	return (mr->mmkey.cache_ent->rb_key.ndescs) >=
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 44a3428ea342..221820874e7a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -693,7 +693,7 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
 	u32 xlt_flags = 0;
 	int err;
-	unsigned int page_size;
+	unsigned long page_size;
 
 	if (flags & MLX5_PF_FLAGS_ENABLE)
 		xlt_flags |= MLX5_IB_UPD_XLT_ENABLE;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 691a285f9c1e..1be2495362ee 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1995,7 +1995,9 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8         dp_ordering_force[0x1];
 	u8         reserved_at_89[0x9];
 	u8         query_vuid[0x1];
-	u8         reserved_at_93[0xd];
+	u8         reserved_at_93[0x5];
+	u8         umr_log_entity_size_5[0x1];
+	u8         reserved_at_99[0x7];
 
 	u8	   max_reformat_insert_size[0x8];
 	u8	   max_reformat_insert_offset[0x8];
@@ -4221,8 +4223,7 @@ struct mlx5_ifc_mkc_bits {
 
 	u8         reserved_at_1c0[0x19];
 	u8         relaxed_ordering_read[0x1];
-	u8         reserved_at_1d9[0x1];
-	u8         log_page_size[0x5];
+	u8         log_page_size[0x6];
 
 	u8         reserved_at_1e0[0x20];
 };
-- 
2.17.2


