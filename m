Return-Path: <linux-rdma+bounces-4827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B139714D1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B70D284FB2
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136B1B3B2D;
	Mon,  9 Sep 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mj/WHoAV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DCB1B3B0F
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876342; cv=fail; b=AG2iQ5Gthx1yBYwCiMI6rOa9QHXJjxQg+641iI3s1uNWz8h+J5W6bfFTS0N72cZb73T4cHVML58d7V52l81+F78y93ggSRb54MeXsJK9qEez9KPyjtkBvKZ9c9j7deF9ve1MWOXYWukjx24ze9FZUi7CoTOslk35rwznVWmkmyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876342; c=relaxed/simple;
	bh=ZckFFfkJckagz5gA0MzYXbUN980P1wiGdBe4E7lzqko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/hrq7oBz8TLJo+yEdFy1LZtI3Czfkz5SLqnZBDi1zQSqHm5XJk6Zk8c9+QT+iOjQhRKLndHobq5VpHMs2vGT+YLaZ+GqUzPeMmkt21gnSD+TttbJdHwYqv9hbQ1nXwPvISG1OpTu9NY6MzuUb1ys8xBTTmUhAmgUjreIw2qikI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mj/WHoAV; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhipji/KY/l1CBWKDQiX2xQx9S3UyHR6QNUIFJ2KYS4f7gmt5ivWu9EnqH0256U7ZNluCqGBpBqGyllnd64TJ47NgwJRF7IX7809eFfJSKhLpmbOCQVHeamYAwWsyDWyBZNRCvWH0u2cXajHLlGmFp1SPOxkNXWHrUbFfblR+T16PIEJ34bghpl52Y46jm/qDhe18JmWo+W5XrVBGtZ2J38By8Px85TkPXpZB40M5zYeV3wjfvQSj8gTTQED4idtugEgTMUEJvApkaS4MIVbOPPKZ/JycfeHFcDXbukisnBzq98MwLQQCn3o5694/MxlBMJ/cEvXNAFi8kz3xbkucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK5S06jt+hfRr5xMxH9UJyqe7klpnnkE0QAZF2sHEUk=;
 b=aAVeahPsjfMtiSRi5SDmt4GpGgNwTnW8DGA7lz16RRm6AIMbmNoEoheEilrex0DeWmoAtuQOK+ljGdul6gt3yuA0DXuIb7y0xMyZJ/4aec+/bx31Kw8FIYirlASM5Kwm215quBUztyUcnoknv3sGyF94dW19lTo7lOjFtM9mxWN7QLJIG1c6v/RDuzoeR/mjtzTmmwmefYD/EzpdIq06b5uswscoEdt39rs9u6Bn0LebLjozV/VwrKDiJ3ba+AW5TM9O0JxBHlc8gnKwDqST3iNc5zxoLRyYX/VqC7VJwyN7st7h+MeGRCXv8v9/PFbv0Fj/6Hdjdbzvn3wTT60Wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK5S06jt+hfRr5xMxH9UJyqe7klpnnkE0QAZF2sHEUk=;
 b=Mj/WHoAV84ESOu8C2mkTit6NrUMAAa74SHtTNa5Ql97BzEPqeBd7ptOPfKyEfOL6dYRpa+KUhaZGVvSbgNThYSrO7J9j01buDT7jjusLGEJnCoy6ePMmPhptndk+Wu4H2fgk4FuiYkI3fdeJ3IXHHn1118PLZnDukmFiqn9/o4nC2ueg+NtfG1Sk3PAPbuzZvRNuVtknismVwswvjd+rIG1NeX0Nc1HN7wnT74DG5X4Y9tDrqHSq8e0BVVdY8fm2pXayamAIGlSuu8jfG6CWrbZpk7LRGcYo7+0OFR4/wPuFEfoqrqe+LaOaLQdGdfZJ/75RHtJvGiRc2sHoXpklPw==
Received: from MN2PR06CA0006.namprd06.prod.outlook.com (2603:10b6:208:23d::11)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 10:05:34 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::ff) by MN2PR06CA0006.outlook.office365.com
 (2603:10b6:208:23d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:22 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:21 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 7/8] RDMA/mlx5: Add implicit MR handling to ODP memory scheme
Date: Mon, 9 Sep 2024 13:05:03 +0300
Message-ID: <20240909100504.29797-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909100504.29797-1-michaelgur@nvidia.com>
References: <20240909100504.29797-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eda17bc-4834-42ce-2637-08dcd0b6f1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/gof26RwRYgDE17jTjI8JKmYnbmh2LS9s82CRCpnLUjfQtrsXldg5EGvBAJ?=
 =?us-ascii?Q?oEvnQu8upxntBfeHB0qNCaRu3BwsQ1KU02n+emAURIxi9h2KPp0yx06D2Pzh?=
 =?us-ascii?Q?f9IAKXPtuGTuuyiAB12Nt+hbJL98r4CVf8SuNg7N/9ntxoBCK+PQc+xAKudK?=
 =?us-ascii?Q?D0RIZ8fsw9lhgSedcvyfQ1++559uNgMo/mvftX4sCH3Rgey95E8chpJmy1Ep?=
 =?us-ascii?Q?KdF/ncPtk8g9eiocltAusCt+P8TfNZb9RTlXIy0zppnzZGmPgNC8sEnr3+XO?=
 =?us-ascii?Q?K/wfa1zAs8UOqP2xvJAjDRqKj7XW9zkFLznlPfYaCwZNbgwTPxWTt542CFW0?=
 =?us-ascii?Q?YQoztfkp1Dedi7F7y8zLJgy2W/vDHQW7oNZhxGuQZOKRS93H5lLp+5RotixG?=
 =?us-ascii?Q?DCbNGdXmhR3zPGest/g+22WArwOK8GMkizuXDIJcv8ZRRnIIxA9lazwxV42c?=
 =?us-ascii?Q?+Ti1fhLKOZlDQQKCDt85IjAFj9Or1xSZ4wMkwHkvBsZXI4TdoEaVubTe79mP?=
 =?us-ascii?Q?WVRirkWmxUxq2CvqIdXIRMhWQ3+RtmgCEwvdlgw04kEn0QCeqSxkduwL/QXO?=
 =?us-ascii?Q?sQRc3kbSU4d2d5i8MpXfhZHpa9crjdypcTZZ0ykboD0qiRNM3+KuyaDCpjd0?=
 =?us-ascii?Q?V5PSXvLdAjy/AazsBbsT90dKHXtMvaYoWNzr2SOFl44I2Swx1GgBKGJu3w2R?=
 =?us-ascii?Q?zF1sk2RaVykZFUU93J8OrIvf74yCWgyUnLpUGspSR2GCjMy25Ak22fYocydi?=
 =?us-ascii?Q?37aME/Qh7B8ukkVcF62vHH06NQ6ZnCUnUD6aAtepqohD9Q/2IsaGPGVQnh72?=
 =?us-ascii?Q?2U8Y1RuTTf4vUPhKI8MzWnWjJtTN3s1CyGHg0gK8R/5BpycmrD1i1acRHxAQ?=
 =?us-ascii?Q?myT3oIGWYML9iLMA3jl6Rnv/9Ygi+o5cyvc26qlEslF03gDa5aAJQ6V3uJoT?=
 =?us-ascii?Q?hDchGyAYZHLEIqv1Jum5WkuFJPSsJhH7DFd38J5xO0GN9RMI+oEf0zHuT67K?=
 =?us-ascii?Q?J46r31u2RlXsaCGvq2NFo6hlc8D8aTYWoomTzT9eZNYMvK3ydzQF+OS9j9Av?=
 =?us-ascii?Q?9XFWyA6S062N+0Muj9G2hCE5BGSK5uxtrvfR+pEVQqBnFbEIKKTPHD+tdNm5?=
 =?us-ascii?Q?VgjcWUQCcyoqZjcDAmzSx/snUxl3fs26Sbrp9c9yO7YfGhcWOlbRiopN0CWv?=
 =?us-ascii?Q?FOYZez93GZ5opbrpFLczHTu6KU4b/Y73zlOv7oC2bW4Zugv1ns8UbA0uklyu?=
 =?us-ascii?Q?TRwrQYbBWjazZtc2dC6/ex2MtOWpIpa5a3vrDV18DTmVLRC17gYQ14GTghS8?=
 =?us-ascii?Q?XvDPZR2IMdRcXBo+5YyFDzc/FXdxJN4CHPgdx3RzS4vgp52zkKAEvi4Kvc0L?=
 =?us-ascii?Q?sERet2XensGwNL43stOGMgKsFebT1tHleqa4FhQXStFBmgRn3K3/CZMIRipX?=
 =?us-ascii?Q?lUSjPcTqq29VXLMFAh90ooABOMicQvDh?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:34.0024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda17bc-4834-42ce-2637-08dcd0b6f1f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

Implicit MRs in ODP memory scheme require allocating a private null mkey
and assigning the mkey and va differently in the KSM mkey.
The page faults are received on the null mkey so we also add storing the
null mkey in the odp_mkey xarray.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 +
 drivers/infiniband/hw/mlx5/odp.c     | 116 +++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ea8eb368108f..227dbaf7a754 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -630,6 +630,8 @@ enum mlx5_mkey_type {
 	MLX5_MKEY_MR = 1,
 	MLX5_MKEY_MW,
 	MLX5_MKEY_INDIRECT_DEVX,
+	MLX5_MKEY_NULL,
+	MLX5_MKEY_IMPLICIT_CHILD,
 };
 
 struct mlx5r_cache_rb_key {
@@ -715,6 +717,7 @@ struct mlx5_ib_mr {
 			struct mlx5_ib_mr *dd_crossed_mr;
 			struct list_head dd_node;
 			u8 revoked :1;
+			struct mlx5_ib_mkey null_mmkey;
 		};
 	};
 };
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 841725557f2a..4b37446758fd 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -107,13 +107,20 @@ static u64 mlx5_imr_ksm_entries;
 static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 			struct mlx5_ib_mr *imr, int flags)
 {
+	struct mlx5_core_dev *dev = mr_to_mdev(imr)->mdev;
 	struct mlx5_klm *end = pklm + nentries;
+	int step = MLX5_CAP_ODP(dev, mem_page_fault) ? MLX5_IMR_MTT_SIZE : 0;
+	__be32 key = MLX5_CAP_ODP(dev, mem_page_fault) ?
+			     cpu_to_be32(imr->null_mmkey.key) :
+			     mr_to_mdev(imr)->mkeys.null_mkey;
+	u64 va =
+		MLX5_CAP_ODP(dev, mem_page_fault) ? idx * MLX5_IMR_MTT_SIZE : 0;
 
 	if (flags & MLX5_IB_UPD_XLT_ZAP) {
-		for (; pklm != end; pklm++, idx++) {
+		for (; pklm != end; pklm++, idx++, va += step) {
 			pklm->bcount = cpu_to_be32(MLX5_IMR_MTT_SIZE);
-			pklm->key = mr_to_mdev(imr)->mkeys.null_mkey;
-			pklm->va = 0;
+			pklm->key = key;
+			pklm->va = cpu_to_be64(va);
 		}
 		return;
 	}
@@ -137,7 +144,7 @@ static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 	 */
 	lockdep_assert_held(&to_ib_umem_odp(imr->umem)->umem_mutex);
 
-	for (; pklm != end; pklm++, idx++) {
+	for (; pklm != end; pklm++, idx++, va += step) {
 		struct mlx5_ib_mr *mtt = xa_load(&imr->implicit_children, idx);
 
 		pklm->bcount = cpu_to_be32(MLX5_IMR_MTT_SIZE);
@@ -145,8 +152,8 @@ static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 			pklm->key = cpu_to_be32(mtt->ibmr.lkey);
 			pklm->va = cpu_to_be64(idx * MLX5_IMR_MTT_SIZE);
 		} else {
-			pklm->key = mr_to_mdev(imr)->mkeys.null_mkey;
-			pklm->va = 0;
+			pklm->key = key;
+			pklm->va = cpu_to_be64(va);
 		}
 	}
 }
@@ -225,6 +232,9 @@ static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
 		return;
 
 	xa_erase(&imr->implicit_children, idx);
+	if (MLX5_CAP_ODP(mr_to_mdev(mr)->mdev, mem_page_fault))
+		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			 mlx5_base_mkey(mr->mmkey.key));
 
 	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
 	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
@@ -492,6 +502,16 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	}
 	xa_unlock(&imr->implicit_children);
 
+	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
+		ret = xa_store(&dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			       &mr->mmkey, GFP_KERNEL);
+		if (xa_is_err(ret)) {
+			ret = ERR_PTR(xa_err(ret));
+			xa_erase(&imr->implicit_children, idx);
+			goto out_mr;
+		}
+		mr->mmkey.type = MLX5_MKEY_IMPLICIT_CHILD;
+	}
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
@@ -502,6 +522,57 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	return ret;
 }
 
+/*
+ * When using memory scheme ODP, implicit MRs can't use the reserved null mkey
+ * and each implicit MR needs to assign a private null mkey to get the page
+ * faults on.
+ * The null mkey is created with the properties to enable getting the page
+ * fault for every time it is accessed and having all relevant access flags.
+ */
+static int alloc_implicit_mr_null_mkey(struct mlx5_ib_dev *dev,
+				       struct mlx5_ib_mr *imr,
+				       struct mlx5_ib_pd *pd)
+{
+	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in) + 64;
+	void *mkc;
+	u32 *in;
+	int err;
+
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	MLX5_SET(create_mkey_in, in, translations_octword_actual_size, 4);
+	MLX5_SET(create_mkey_in, in, pg_access, 1);
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	MLX5_SET(mkc, mkc, a, 1);
+	MLX5_SET(mkc, mkc, rw, 1);
+	MLX5_SET(mkc, mkc, rr, 1);
+	MLX5_SET(mkc, mkc, lw, 1);
+	MLX5_SET(mkc, mkc, lr, 1);
+	MLX5_SET(mkc, mkc, free, 0);
+	MLX5_SET(mkc, mkc, umr_en, 0);
+	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
+
+	MLX5_SET(mkc, mkc, translations_octword_size, 4);
+	MLX5_SET(mkc, mkc, log_page_size, 61);
+	MLX5_SET(mkc, mkc, length64, 1);
+	MLX5_SET(mkc, mkc, pd, pd->pdn);
+	MLX5_SET64(mkc, mkc, start_addr, 0);
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+
+	err = mlx5_core_create_mkey(dev->mdev, &imr->null_mmkey.key, in, inlen);
+	if (err)
+		goto free_in;
+
+	imr->null_mmkey.type = MLX5_MKEY_NULL;
+
+free_in:
+	kfree(in);
+	return err;
+}
+
 struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 					     int access_flags)
 {
@@ -534,6 +605,16 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	imr->is_odp_implicit = true;
 	xa_init(&imr->implicit_children);
 
+	if (MLX5_CAP_ODP(dev->mdev, mem_page_fault)) {
+		err = alloc_implicit_mr_null_mkey(dev, imr, pd);
+		if (err)
+			goto out_mr;
+
+		err = mlx5r_store_odp_mkey(dev, &imr->null_mmkey);
+		if (err)
+			goto out_mr;
+	}
+
 	err = mlx5r_umr_update_xlt(imr, 0,
 				   mlx5_imr_ksm_entries,
 				   MLX5_KSM_PAGE_SHIFT,
@@ -568,6 +649,14 @@ void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr)
 		xa_erase(&mr->implicit_children, idx);
 		mlx5_ib_dereg_mr(&mtt->ibmr, NULL);
 	}
+
+	if (mr->null_mmkey.key) {
+		xa_erase(&mr_to_mdev(mr)->odp_mkeys,
+			 mlx5_base_mkey(mr->null_mmkey.key));
+
+		mlx5_core_destroy_mkey(mr_to_mdev(mr)->mdev,
+				       mr->null_mmkey.key);
+	}
 }
 
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
@@ -1410,14 +1499,25 @@ static void mlx5_ib_mr_memory_pfault_handler(struct mlx5_ib_dev *dev,
 			       pfault->memory.fault_byte_count +
 			       pfault->memory.prefetch_after_byte_count;
 	struct mlx5_ib_mkey *mmkey;
-	struct mlx5_ib_mr *mr;
+	struct mlx5_ib_mr *mr, *child_mr;
 	int ret = 0;
 
 	mmkey = find_odp_mkey(dev, pfault->memory.mkey);
 	if (IS_ERR(mmkey))
 		goto err;
 
-	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+	switch (mmkey->type) {
+	case MLX5_MKEY_IMPLICIT_CHILD:
+		child_mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+		mr = child_mr->parent;
+		break;
+	case MLX5_MKEY_NULL:
+		mr = container_of(mmkey, struct mlx5_ib_mr, null_mmkey);
+		break;
+	default:
+		mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
+		break;
+	}
 
 	/* If prefetch fails, handle only demanded page fault */
 	ret = pagefault_mr(mr, prefetch_va, prefetch_size, NULL, 0, true);
-- 
2.17.2


