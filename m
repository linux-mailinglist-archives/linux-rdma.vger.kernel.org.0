Return-Path: <linux-rdma+bounces-4821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718A9714CB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6121F21457
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C01B2EC0;
	Mon,  9 Sep 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nn/lvUL6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF27D1B3F0B
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876327; cv=fail; b=H6fMyuAR8KTWf/8FEMVi2KBBnWEM9DXh9aQ8ZTB0GJUcoIqXhFLAN0qQi/b9rPeEkY5J0txPpyd/RFui2rLUQhycbJgkDqT1XEWSnkBrJ4W2DmUkFGujRdCGEvJbXixcXWVbxUaIE56CHzU5T7qJYLDSeg020/6eg4rX+n9RIpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876327; c=relaxed/simple;
	bh=LSssioY6EyCwDnw/m6KAsbO3/98FxfcW1TJYO18Po/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emAz+LgSqZylSE/WYW/mwwRdz1OjSTK1kmC7L/OIoHEO5qCtaKchtIf2vd9V9o1q3XhG8U5/GbR/x635tXXnXKO+mQnmEHk89Q/SZ5/QHzPdR/Ir30EfaDJmy5ZmFuvMQJ/7QJOtX3NgQEpPJ+MlLmtVx5WvHB7HgLJ3UnQue1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nn/lvUL6; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On4Q6Vdi1/gPk2v+EYMtEGo9RBbjm1fedlkSwH3xf1VlVwLyeVPSTxq2ouuyzgWnBiRaHtToHlFw0ZGo+qiNmoCGM65Y4XK4DcCOAJ8d6ZlFvQge/8u9yD0zpOkmqCEbPiWhXs+fK4SaO47Abzj65DQc7ojmPDG8gueE5Kqwx7N4Q/e6N3g4FJziW1GVuXUozGDwH2V26cXsQhxWtc+l0ojGiAom5lpArQubI81Rh/JKs0Z0ELxCjubkpmGQNLU9PWOrhRzqjdlfGCY9sT2jcSKatyz2ZzkAclzQb90Oad+vNwoFoi6C5dhtG7ZCus5clWEBzlew0zGb6MlO2lxr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2s0AtPNfcIJt7DB29cUc3n33jC+C+1miWiMr01rD4l0=;
 b=mBxDVv9BoY89uedSx/Pg+95gItZbO3VZnRMMoxvv7zQu2KJBK58Sre3tYqozo16wGvi/YbvSBjL2OMt53HuU0IfJCoKtuQ84G455Ej3wOgaKyOnv73YNVQ+QI2bk9DNfAhDIYxTXrG5L3l9w2ZFdBViQ6kfWEMRfvSKIS52JMqXlj6YdHrDGP9YDdhn3hvA76gRnXi/ljzbEzMK1YX8GeJZupUlDtkLuavo7J7p2y3KOMtiWALzBd51SZKxMBVEUfSBhS/1zw05yq7RM+q56A8hERpXJ5a6r6Ymyi89oh364BIbZFKQbzlNkpsHMtgTd9uXC3g07UrmLTmHfvihmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s0AtPNfcIJt7DB29cUc3n33jC+C+1miWiMr01rD4l0=;
 b=nn/lvUL6vj8GZEu2GaDZpPTF4UiUb3KDceIemQC90kTSfnUH0Qq24jXYBscoCGERi5yNsXc+LjulA58YGCiciQ1Kt5sBHpZdTE+w8O/+qD3kyOIhh6XNNbnHY//A2EQBBv2msPfZ97F/XfDB2ItEJgf4Tcj1k8m2AUjG7wBv096g71vcYNNe8auWeM7EBGv7bDmf2bxuTJHA6NSAvO7mHXsoZM7qFZyOQskmVmxYIic16w7M+0/sybPJfyPED36Frf6v7Rgbh8DnL+TkBwPOrl4aXiqPx0JcIdRmLXD30wSjQOZE4uL5eI7Nlq3F8BwrFj/kGVtqgv7c2x4CwKlfpw==
Received: from PH7P220CA0079.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::27)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 10:05:22 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::47) by PH7P220CA0079.outlook.office365.com
 (2603:10b6:510:32c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:10 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:08 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 1/8] net/mlx5: Expand mkey page size to support 6 bits
Date: Mon, 9 Sep 2024 13:04:57 +0300
Message-ID: <20240909100504.29797-2-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 785f5019-862b-4a0f-9c27-08dcd0b6eb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IQVgEqm97zcFIxfVkCCn3OC/i1SXMgZspVpoVw21Lr1D7HtzgE/aszDrxggB?=
 =?us-ascii?Q?p2TlRyXRhf2iJWmgWKzYgDQZQFsxsonL1Fh357PzLmB2CklRk4y16zCsOJwX?=
 =?us-ascii?Q?O0gWC6Ul5ullrV5Mtte337CcS84pyy/ZU9jYHGC6LOmPkif2ffsyYTOlnj5I?=
 =?us-ascii?Q?KLxUYF3uWqEbZo2xO+3S28BV7sweJCPxrERxXmhVTuk6N39MaKfXY5UZ7Ivb?=
 =?us-ascii?Q?deieIBEFk/5O/3JD5h7aorw01rwr8KyCCq/xArMkXxe+d5HjA5KxXCV0RJDI?=
 =?us-ascii?Q?ZqOnq2SH4MZe6LcVZLqcv1+BGVECWJFPxsbTm8VO36bihl71/8lmojRLoAxn?=
 =?us-ascii?Q?ibQphe8VMhJa1sPwWO5wSW9Qls+cBsGr9gdAsgsn6B8xNrcwOb/WHdF1Nl1W?=
 =?us-ascii?Q?pKPu9NRUTp4ElK3AwCvKIEHM4Tgyc2GtCh3rusmMKb2HyJ12WktkUG5Eo5VO?=
 =?us-ascii?Q?/Q03LX540BuX3wmhtcEk9XUTgPICDZuB3vhftJI147q48spfiiFUJO3P0peU?=
 =?us-ascii?Q?k3jLi/L8bevQHpVD6pAToO1dyvqRGv4aVSihd7QL5o5Aryb/00TXYNLAAwkS?=
 =?us-ascii?Q?bRqfXA94MmAnkoMdGit2uCWxo8z52LV3Q3qHNb8+hNxIfDTzkjekZNWacR6o?=
 =?us-ascii?Q?4R1ojOc0gRSIopzbN/a3YFyjJNZf59IAxt0miPHunAINr4wFRizvGD34XB8b?=
 =?us-ascii?Q?AV1Ugv++UTLsI6t7kFzUQnTNjfzAeTAnJ+VRLoSR4UqhnhNuXkBDQgS4yFaC?=
 =?us-ascii?Q?XjHe1IPoKOps8J/6xE+vEh3wzuWZAeiRopaJju0YS6w+5ZP62PG7a2lKyCqo?=
 =?us-ascii?Q?boBuOXpCyihJ/T4xCA3F3/9U/BHXdgtbXTdRnxzMk4TZM7CHAoPQKaDz9JsY?=
 =?us-ascii?Q?S6qIUCQwDodP8F8gTwn2ffFa8no9KdnuB+YaV0EsvgJcNvScsmi4risNsI/V?=
 =?us-ascii?Q?/CkTa0NH0/vrLzsWmOfgzibH72QtGHcBKW7qPsILj5WLrdTbfHNRyrNLQeLg?=
 =?us-ascii?Q?Cj83LeQrUcgb+k2CZ/GsMwU5/YNuRW4A4ttdLqV97aLoQKQ3UwRYb68Gz6KE?=
 =?us-ascii?Q?kIpoTmoz9f8hL1rAwCC5VLGXgU5B3U87jOmTxVqlkPt6YD9S/xEizcPZE5SZ?=
 =?us-ascii?Q?nGgUUbUWtUy+YvJgK5++EKPiIQ3CdG4zFB2ZOUOss94ttHgfRch+qQopTKie?=
 =?us-ascii?Q?xowF/Qk+A2nmbp71Bb3neY6SAqS9MdVQxkcvh8vOGvX8O8vfRQmX+qQBaiJe?=
 =?us-ascii?Q?Ix3OlNv6S3VzD6DyyJ7lgMfu+ugjaIEXLx69O3ISLUGo+f60wqpAW4zJ7nIN?=
 =?us-ascii?Q?iAce9dBqCQO2RDLrjEZ84yaJi2ZCQIbmphNX8PhPE72A3Uo1WzPGf3NYgANV?=
 =?us-ascii?Q?rBo5AifS1e+i2ahIhIi9JNnGuFc6TyS/zB1NeiT4byKpclveOL+f5g1MeJV8?=
 =?us-ascii?Q?e7m3pLuw2/RNfX7ta8DnEeJ8+5IURS3F?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:22.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785f5019-862b-4a0f-9c27-08dcd0b6eb1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Protect the usage of the 6th bit with the relevant capability to ensure
we are using the new page sizes with FW that supports the bit extension.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 27 ++++++++++++++++-----------
 drivers/infiniband/hw/mlx5/mr.c      | 10 ++++------
 drivers/infiniband/hw/mlx5/odp.c     |  2 +-
 include/linux/mlx5/mlx5_ifc.h        |  7 ++++---
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 926a965e4570..ea8eb368108f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -63,17 +63,6 @@ __mlx5_log_page_size_to_bitmap(unsigned int log_pgsz_bits,
 	return GENMASK(largest_pg_shift, pgsz_shift);
 }
 
-/*
- * For mkc users, instead of a page_offset the command has a start_iova which
- * specifies both the page_offset and the on-the-wire IOVA
- */
-#define mlx5_umem_find_best_pgsz(umem, typ, log_pgsz_fld, pgsz_shift, iova)    \
-	ib_umem_find_best_pgsz(umem,                                           \
-			       __mlx5_log_page_size_to_bitmap(                 \
-				       __mlx5_bit_sz(typ, log_pgsz_fld),       \
-				       pgsz_shift),                            \
-			       iova)
-
 static __always_inline unsigned long
 __mlx5_page_offset_to_bitmask(unsigned int page_offset_bits,
 			      unsigned int offset_shift)
@@ -1725,4 +1714,20 @@ static inline u32 smi_to_native_portnum(struct mlx5_ib_dev *dev, u32 port)
 	return (port - 1) / dev->num_ports + 1;
 }
 
+/*
+ * For mkc users, instead of a page_offset the command has a start_iova which
+ * specifies both the page_offset and the on-the-wire IOVA
+ */
+static __always_inline unsigned long
+mlx5_umem_mkc_find_best_pgsz(struct mlx5_ib_dev *dev, struct ib_umem *umem,
+			     u64 iova)
+{
+	int page_size_bits =
+		MLX5_CAP_GEN_2(dev->mdev, umr_log_entity_size_5) ? 6 : 5;
+	unsigned long bitmap =
+		__mlx5_log_page_size_to_bitmap(page_size_bits, 0);
+
+	return ib_umem_find_best_pgsz(umem, bitmap, iova);
+}
+
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 73962bd0b216..3d6a14ece6db 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1119,8 +1119,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
 	else
-		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
-						     0, iova);
+		page_size = mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
 
@@ -1425,8 +1424,8 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags,
 					MLX5_MKC_ACCESS_MODE_MTT);
 	} else {
-		unsigned int page_size = mlx5_umem_find_best_pgsz(
-			umem, mkc, log_page_size, 0, iova);
+		unsigned int page_size =
+			mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
 
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size,
@@ -1744,8 +1743,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 	if (!mlx5r_umr_can_load_pas(dev, new_umem->length))
 		return false;
 
-	*page_size =
-		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
+	*page_size = mlx5_umem_mkc_find_best_pgsz(dev, new_umem, iova);
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


