Return-Path: <linux-rdma+bounces-9249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0632A80D54
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0CE3B7982
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F51CD20D;
	Tue,  8 Apr 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xe/7IcFm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0C42A97;
	Tue,  8 Apr 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120955; cv=fail; b=dGJbpr9Jfchit9SZ9liuy4XQR9XyV0r7JddtzNKliJ0IXqVu4Ag1C/o6evLd/uK7VmqasSJcV0YnDhCJ4+U7nEk681xE3f+gItcoG7eWZO0CdOlP7he5/Y/KEA9WR+fVG20mBWvLuCFo+DxUJC0I25JlRDc2LUtFYeYMRBRtzew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120955; c=relaxed/simple;
	bh=ZBBFb5p+oL04xkzjokB+CkJO8yAei0/ndHlF+GVq76E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3UGKf1DeIqHOiB0fzkwPXvZ8yIbeELGhzTwpGseIsu1B4uy+pXYz9TkbtmQJzksXq3KTG8KdQOVVrAcCYfLPkyHzQHad/k2OrA4Xhdl1PKUvXArXtmHCl6paaEdt0NHW+xVF9xTDUvKjj1ShCNiPMjuiyrr8G1ZAYTXG1sKe6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xe/7IcFm; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoI6R1sAy4x3FD09ShLWTeIX634JyXMeuXGG0PTiqLkDCWrMN54l/4leypA5AXG3gpNHJfEZpUz/FTwt/jQoIT7cXxZYW7Slwdq6hHgTpVik2C5iJBPrsFzmhGdqhz+566KWbi7HA19OZ5xiP/WJpfWJjIoD1UseJZhIZJbi0LsJ72MnTdK/qiKRu4PE7pVlMYG8uNOCJgS6iZ/JhZlVlPjL0AZMGTewEyo8bx6k6LsWey2ig08Ok4stCVytOF9WIwUnXkAGdeh+1MVZPnzqCYuDMInzDNowcqVkB1OQBGHfmqQYp0CrZlTKphrXyQySiAlhSxtTsmItyhEuLddM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjdrjdPn0FTQe678ZJxedvgl4kCpqFXhsQk4WtF5h4s=;
 b=Tr4VgQz977m6+u4d5mdh5OrklC7IvQMrxX1XCbu/33ppWWAvwDqyzlc0M1fR53F3Z5fqW2ZpYgfC44N3IMJT3i3QYFTLt3XPMyqiLPuR0APCBH564L4QOPE3MZ6GVAbMOCCcDZrxyphHaDMoA3zkDjfya+Ja8F+3rlb+7AGWdvUrQfY4w/VHNd6wgbaYrzZoQLB6zjDZSRy7P2C7GKvJhYbpYl2ijWlz/IDcG24C15gaZRhzAy72y7bp9Tdo6/BMo/VvY+KAWGN0bQUDroskaMC5ffrUZz4JAB3e4SX4mmee9z7fIAUJvoGEsu1hEU9lpLUNYeD+FPZnWa/4G6iVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjdrjdPn0FTQe678ZJxedvgl4kCpqFXhsQk4WtF5h4s=;
 b=Xe/7IcFmYWUv2Bzl3Sj+vSg2tsR/rsQuq1bT55SVc54BPObGSye+a3bdVOcLaa38GSaUrM48haBdi+DpJcMWAFaH2B5oYw9QLEEmljMiCqS9K4813UpjHTvk3q2wzAVmz6E/qEIKOKA6DUJClvixU9+dVhXeZVdbCaLhg4gRX/D9KrwU2EjvkPRK48t+y3UJCgPJugEre096sScr7WWmSbBdQdwbmSzT4SU8Kk6kIwMuE7O+LWog4QFhD0e5jDo0YoyBWadYRy6+D+hDZb286Iil0QpT1ELeTSm9DMa0tZ9LfL7CPtyZ5G5U5Wdfs82y8uquqXtX8U2R3AVKBteg/A==
Received: from BN9PR03CA0879.namprd03.prod.outlook.com (2603:10b6:408:13c::14)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 14:02:30 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::c7) by BN9PR03CA0879.outlook.office365.com
 (2603:10b6:408:13c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Tue,
 8 Apr 2025 14:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 02/12] net/mlx5: HWS, Remove unused element array
Date: Tue, 8 Apr 2025 17:00:46 +0300
Message-ID: <1744120856-341328-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b1dce1-63f6-4ec7-805c-08dd76a5ffac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lo8+JWJhU5OAcftIF4rqU6pkLXFoCR0afO1chX6Wx3k1zGYnRW9ISCmW1Ntb?=
 =?us-ascii?Q?rSeoMhotl9N09U4LB8AYiCz69fIeinpd0gq6Ma6DM5OYwhipRVqaM8cBkdrE?=
 =?us-ascii?Q?+ky+XUDl9bE1j21Zb5GQMUm0Tx+rnzwygvmoAuPlSdKRBOGKwl6woWdLzHeY?=
 =?us-ascii?Q?72l+UhN0I3zapJXeNxmsrKqVPTVrfDdi+CVv7MvA2GOb0EYD2asqnfA895AR?=
 =?us-ascii?Q?mZ5oEIUPCPWmS67Y8KP5Ts6ArEupcpuQXK4SDA2sWYan6HZSdaS4Er12lqtk?=
 =?us-ascii?Q?E8hwTI4pePxuTXyf412Gx1Boz9ouf5kkhTAcerioiGAJ5pZrOGQ5pvjM3U9u?=
 =?us-ascii?Q?mqHWj1rket8EE6ItG1rNvnf33SxHyYLbBc/gF0x501Z4fcnxyxXcTFgGy2Fc?=
 =?us-ascii?Q?O9r3zRBtUTGdlPHQR7rwMQdnUm4317TGWPiUJbC4UrMSO4KaA96HHy5+XFXn?=
 =?us-ascii?Q?uP7RJsYxDfG6ChfZwb0QNtcbcZkAh5XCJwTOkACo2df5Z8FCMI9xArBMtb9H?=
 =?us-ascii?Q?7iKsPfl/t2ngQGvqbJhhY6Z4oBOJEOCdFqPkLy+ufUk/NLpB2fi95bjoU7z1?=
 =?us-ascii?Q?51muSmh0YiZ44qQZ5k/o0grDXihvWpGtLZeLi/Pl4M1zAMGcY9916PH2cZ9g?=
 =?us-ascii?Q?ZKcTqyMZZORPZhuXDxXkHtJY3G8vQAXNVO/SHT5lx44m27QjvJZJXHsgrZvR?=
 =?us-ascii?Q?SWe0g0DuwqDAItbEQvkUuvaERUH5mNuPpQwyVbRGPZ1Mvlu/Vs3Dw3uaPTAv?=
 =?us-ascii?Q?TEgXdjknoyoOiWHbtM1hWeLh17233Hl4jaNBc9xS5wrQBiqeymaMWmwnDsWl?=
 =?us-ascii?Q?+9pnMCz9m44kbQv67+QO3w/IilXC2C21k9JHpoKys8kt/xHvCUFxIHhEQf1d?=
 =?us-ascii?Q?ZV7SP99PxSd438wtEgjvB0xiHtOVRR1nr2dcDSi6YW1m2F7i4wPIkZa8DVCB?=
 =?us-ascii?Q?1zTyNVW83AhGAOCJXqlu0e0IhleNDknla2ncMfj6fhqlGx3BusbChf2sPMJi?=
 =?us-ascii?Q?8OWi1EH2lmtmIiOadbG5D3g7bcZc1G6B6sK+kdytxnG0lnWFfRzFZGUXqs6p?=
 =?us-ascii?Q?BSQZHecph39ye/184j0t025IxDeHimw/pPZd+Piv2biazaGQOLW/h9TLonVw?=
 =?us-ascii?Q?Uj0Kz10AiAlll7t2pDJHa9EBmQbOoBP9aYU4wYsx+ZyJ7ondeOo/0fTwJlgW?=
 =?us-ascii?Q?HS39jZB7wYZGqgo2i/UgZjU1nSa966hfjr1l46SYIM8rnXruyzVKqC2OBddx?=
 =?us-ascii?Q?5NZlfF4qNCHoZ2z8AI5Tv8Ndd+gbtROxtyMe+wH6d0fmvRyr1D13t0S754tn?=
 =?us-ascii?Q?KI20OREuZkNDYqfgg5UCTN1XtwMO7jxpBvDK8ZogThJMDLbjKi0yxiOhlNSw?=
 =?us-ascii?Q?rgdi4HpmAShAx10IKvamPs7Fb3v9+h2V7HkjSnOCCA3WdT2t3XAMZpoIo8cR?=
 =?us-ascii?Q?LN+zdxy/GNKdsxQH9lghCozYh0jBRx1M9SFbTFwYXWUDIghA0ufCrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:28.5780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b1dce1-63f6-4ec7-805c-08dd76a5ffac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475

From: Vlad Dogaru <vdogaru@nvidia.com>

Remove the array of elements wrapped in a struct because in reality only
the first element was ever used.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/pool.c    | 55 ++++++++-----------
 .../mellanox/mlx5/core/steering/hws/pool.h    |  6 +-
 2 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 50a81d360bb2..35ed9bee06a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -293,7 +293,7 @@ static int hws_pool_create_resource_on_index(struct mlx5hws_pool *pool,
 }
 
 static struct mlx5hws_pool_elements *
-hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order, int idx)
+hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order)
 {
 	struct mlx5hws_pool_elements *elem;
 	u32 alloc_size;
@@ -311,21 +311,21 @@ hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order, int idx)
 		elem->bitmap = hws_pool_create_and_init_bitmap(alloc_size - order);
 		if (!elem->bitmap) {
 			mlx5hws_err(pool->ctx,
-				    "Failed to create bitmap type: %d: size %d index: %d\n",
-				    pool->type, alloc_size, idx);
+				    "Failed to create bitmap type: %d: size %d\n",
+				    pool->type, alloc_size);
 			goto free_elem;
 		}
 
 		elem->log_size = alloc_size - order;
 	}
 
-	if (hws_pool_create_resource_on_index(pool, alloc_size, idx)) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d index: %d\n",
-			    pool->type, alloc_size, idx);
+	if (hws_pool_create_resource_on_index(pool, alloc_size, 0)) {
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
+			    pool->type, alloc_size);
 		goto free_db;
 	}
 
-	pool->db.element_manager->elements[idx] = elem;
+	pool->db.element = elem;
 
 	return elem;
 
@@ -359,9 +359,9 @@ hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
 {
 	struct mlx5hws_pool_elements *elem;
 
-	elem = pool->db.element_manager->elements[0];
+	elem = pool->db.element;
 	if (!elem)
-		elem = hws_pool_element_create_new_elem(pool, order, 0);
+		elem = hws_pool_element_create_new_elem(pool, order);
 	if (!elem)
 		goto err_no_elem;
 
@@ -451,16 +451,14 @@ static int hws_pool_general_element_db_init(struct mlx5hws_pool *pool)
 	return 0;
 }
 
-static void hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
-						   struct mlx5hws_pool_elements *elem,
-						   struct mlx5hws_pool_chunk *chunk)
+static void
+hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
+				       struct mlx5hws_pool_elements *elem)
 {
-	if (unlikely(!pool->resource[chunk->resource_idx]))
-		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
-
-	hws_pool_resource_free(pool, chunk->resource_idx);
+	hws_pool_resource_free(pool, 0);
+	bitmap_free(elem->bitmap);
 	kfree(elem);
-	pool->db.element_manager->elements[chunk->resource_idx] = NULL;
+	pool->db.element = NULL;
 }
 
 static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
@@ -471,7 +469,7 @@ static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
 	if (unlikely(chunk->resource_idx))
 		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
 
-	elem = pool->db.element_manager->elements[chunk->resource_idx];
+	elem = pool->db.element;
 	if (!elem) {
 		mlx5hws_err(pool->ctx, "No such element (%d)\n", chunk->resource_idx);
 		return;
@@ -483,7 +481,7 @@ static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
 
 	if (pool->flags & MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE &&
 	    !elem->num_of_elements)
-		hws_onesize_element_db_destroy_element(pool, elem, chunk);
+		hws_onesize_element_db_destroy_element(pool, elem);
 }
 
 static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
@@ -504,18 +502,13 @@ static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
 
 static void hws_onesize_element_db_uninit(struct mlx5hws_pool *pool)
 {
-	struct mlx5hws_pool_elements *elem;
-	int i;
+	struct mlx5hws_pool_elements *elem = pool->db.element;
 
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-		elem = pool->db.element_manager->elements[i];
-		if (elem) {
-			bitmap_free(elem->bitmap);
-			kfree(elem);
-			pool->db.element_manager->elements[i] = NULL;
-		}
+	if (elem) {
+		bitmap_free(elem->bitmap);
+		kfree(elem);
+		pool->db.element = NULL;
 	}
-	kfree(pool->db.element_manager);
 }
 
 /* This memory management works as the following:
@@ -526,10 +519,6 @@ static void hws_onesize_element_db_uninit(struct mlx5hws_pool *pool)
  */
 static int hws_pool_onesize_element_db_init(struct mlx5hws_pool *pool)
 {
-	pool->db.element_manager = kzalloc(sizeof(*pool->db.element_manager), GFP_KERNEL);
-	if (!pool->db.element_manager)
-		return -ENOMEM;
-
 	pool->p_db_uninit = &hws_onesize_element_db_uninit;
 	pool->p_get_chunk = &hws_onesize_element_db_get_chunk;
 	pool->p_put_chunk = &hws_onesize_element_db_put_chunk;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index 621298b352b2..f4258f83fdbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -87,14 +87,10 @@ struct mlx5hws_pool_elements {
 	bool is_full;
 };
 
-struct mlx5hws_element_manager {
-	struct mlx5hws_pool_elements *elements[MLX5HWS_POOL_RESOURCE_ARR_SZ];
-};
-
 struct mlx5hws_pool_db {
 	enum mlx5hws_db_type type;
 	union {
-		struct mlx5hws_element_manager *element_manager;
+		struct mlx5hws_pool_elements *element;
 		struct mlx5hws_buddy_manager *buddy_manager;
 	};
 };
-- 
2.31.1


