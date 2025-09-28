Return-Path: <linux-rdma+bounces-13717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEF9BA78A0
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199513B9DA9
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EDA2C21DD;
	Sun, 28 Sep 2025 21:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="doUpzpLC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011055.outbound.protection.outlook.com [40.93.194.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485C2C159C;
	Sun, 28 Sep 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094779; cv=fail; b=dzmIxrI+LCnM+/v9TP3PJkKQzwkeXSo+tMagVDcfy121ivzda131opZ+S6Z3rKk9ORUbmB2C9peSqMSsWU4MrSsqveHjvDWCrCKb+eXXU4W/RsFSdaaJuUe72rAr9CbS3EdpPYyXHbHnpTjZA7/CRGePBxr2fCfCRwsQcU0wkJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094779; c=relaxed/simple;
	bh=t/4Z97hmAIv9mj7sv8irm0Ty/vM+LmMlGQuU9W8UOU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BE+1dZGoW8sdRINGuj7Ml0dE/wUJacqJyYE2Ffq8stHXEKleTxnVKl023Q8QMTmqpXp/10i9eD2h/izI93ybaDGTbKNRZEfUmhGb+02sTccKf2hKiqHlMo9A9LrSDdSQyOvUX9i33H6lhEjYvAfW7wKN3cgVwbJL4gzxOVbNCdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=doUpzpLC; arc=fail smtp.client-ip=40.93.194.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYXXyRBVY9UgLWYocEaLkLZBlCMu4leYR5JtHfu1fj/4w6O3suC46bKgrvSw1CV5XOQUKYNx0tYk809BeDJby8KAjmn2HG/am3a3HLpaOzsGJiWvJ3+Q4DiYsK/+JFT5xlGhJ5dde5PVcqqQd1lyK82IjbJdpDob4KUWMH5VZ5V8qnzwX6Hd8zb3RhI4KbCbpQsWysC7VnVOMfQq0I51FbYUSYA69YQI5zZOXS5IxeQnTayt/Rwdjw9JbjMKkZNDGmJ6+CY3DMVlh+5J+V7daxXtReD6i8pnnjkr/BUekQqepFuMOa5YKqC1QkHFbpemPeffpw9GdAfijiqij51nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+nGnS9+4SCuIOn+slrhdkgiUnZhY1miHwG+yx5/BFA=;
 b=Z2QfvEV6wkVWUVY24nzmxx5req3n5jpaq7s7Rw+mfw9Ro+hQ6ystoO+KFkGbTU1swi/tvxUuBxcUg0Sh4NAyxMDtVRDgGuuFJN+9IbpbNPUOIB0n12SrF3Y1V7bNLRBEkAxP6WkTqYNC9sykKD/KBj7W+zu6ZY56i7zqzXWbT/ALgn//dfbQHcl4smQOTGUwnGbbwdDjvgeRZ4Px8M8b6K2MARCHFIaxDpKl2IVo7aE13/HQkUY1hmo0GekI1qTc83kOXcXw25bKvZk3uNflx2byjambRqYiFMm5MmxkHZbT7Y9J7ddBMuv8gr44GnZ1s4mvxj/x5+NJl+51aQFWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+nGnS9+4SCuIOn+slrhdkgiUnZhY1miHwG+yx5/BFA=;
 b=doUpzpLCIlTb0X/HI4VqQ3HoUZnNrwdNyzU5aHCyehMAKPZxm1uklmNzyVgTlA9xYiCxKocrKkzYWcRFEnOponhhedN0E/tlGkTV7SH+MFtwHqEkcfoun3SUnJ9cRtAfnMmouO5n65BPeqtaTetEJgxLVrWgkTSCrJxfJmANCnq9rjfMoVMCuabwrVs+rGy7rFkizNiFIXNj7CRErYppOasKYMg+EsVQbymFv8W019SgSo/ECda6W3L+hXjb08idEF5FfXwJxA793m5b1wDaKcJYbvYWt9ymtqzhoc8vOWxXo7hSd1KWRCFiY5BA3MBXmLHFwagQRWEzaHl9PP8k4w==
Received: from BY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:a03:1b8::39)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Sun, 28 Sep
 2025 21:26:12 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::56) by BY5PR17CA0026.outlook.office365.com
 (2603:10b6:a03:1b8::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Sun,
 28 Sep 2025 21:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:26:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:26:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:26:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:26:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next V2 6/7] net/mlx5e: Introduce mlx5e_rss_params for RSS configuration
Date: Mon, 29 Sep 2025 00:25:22 +0300
Message-ID: <1759094723-843774-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
References: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: f70cd11c-7652-4d74-8fed-08ddfed5a5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ph0X8fqgdMw5wopMLEqmZGlxpZYeJYNdDixKtiVsV6PxRttMEdF8XkG/Quz0?=
 =?us-ascii?Q?sYEztKBySbroH9sFtBJDK3sRGDZrAGzTIi/BdHu72eSDit68SLnxUZWvlX08?=
 =?us-ascii?Q?h5XdV4tdxN4A7xpFNk8O4JLzBEvgNNvE2Pat8eXXjJznGbePomQdPHbWMYNA?=
 =?us-ascii?Q?da0Vbmfxge58Ttx2oRSGOuC0VPJ5DG6E6k5sKehQ72ne9qVaRTGVyqvO6dvA?=
 =?us-ascii?Q?h4ZJ3FtJSVIoZnRVAiDd6vidRezBZ7oJ18xJ1AQi+IyIJYD/3ZAYJzQ5FV2U?=
 =?us-ascii?Q?Ub8XkpiKGgZWnUWh9Wu6PZC7L8nCTWJWkAaLIq5rNd+l/+M5KdOk7+S2iyLp?=
 =?us-ascii?Q?atLQ1iRSo6aJ3uNo4ZZntvk5OcewDIpLPLQo0uGYMCbWrr/ffzDVnM1hVinj?=
 =?us-ascii?Q?dJ51xpVl1elhz702slragapWmx2fs1nqoGfL1tkxjdi/S/18TUpQ9B5zmVeF?=
 =?us-ascii?Q?JAJ+2+wcYhwMjGFzC2CneNUnFxNXhcrg5r+J54Vn9n26AaxsLl8KvqoultjB?=
 =?us-ascii?Q?iJSH47KFvMr1zNWtZQtms6g9yXUzt/0SheAGHbTbFbFSaiBp1SrsyP1ztr25?=
 =?us-ascii?Q?dEcEvrU9onRSBa4iWWpWexSx8mAwNqXARh6dBdIS0L19/O5oJsdV1e5fC9TX?=
 =?us-ascii?Q?EpwYkHX9gICddUeLwY8XRWDru0MINrRkEAC05G1NR8i1tYVT0gSl2nhmXgyX?=
 =?us-ascii?Q?7BsNhMFsq80TiaHq4vPIkwpy2iqFGmCySZMDusXrHOV9IL653fZgpMGrNPPH?=
 =?us-ascii?Q?utiTDe3O0HKsQ2PaN1wwvlwT0DNFpz+K9IJgRD6OOYQ6/ga8VmkoSMPIzUMc?=
 =?us-ascii?Q?LE3vl4AAnqW4LtNhiW5KTpJL/tyrRdRdpzRUy/j8OEXiz2EDzxR+zz4kEXJJ?=
 =?us-ascii?Q?UOoyKa6s2KgKwUMbmkePhvVEI3gC513lJvD39kxWh0H7raMPomoCPHAU8FYK?=
 =?us-ascii?Q?da5j5BxY0tjWT/6+Rn4ySjlw9naYm/T6+cCGg1U/br2KQj214FlG7OauKePw?=
 =?us-ascii?Q?ne7tPrpC+JKtYXU8LQ4zauVkAgNbjlhCIUSQDg9Hc0TG64/UEd9wXQEYH56Z?=
 =?us-ascii?Q?ku5S+YtUq54b0lORPzsK9CwAxR1lwvrVqNYMBTmK81f1ETTxHMEroOTIF9nq?=
 =?us-ascii?Q?g5fFVe3bZS+eDZN4lhxhUAZ8uhtI33W5Ix6mdSrkhMJBLdF5iLjCc3yv31cU?=
 =?us-ascii?Q?qFLHdrjtOh4LZ1Vj8J+/VnYXCYGwVddeLSH5EekoTY68qVJcm2/uYlSe3+PP?=
 =?us-ascii?Q?0zoJSAC0FO4EQcQdsSZdoM79OSXNra9dP8TVvTqd+9OnZyBHy1up6yWrHGJH?=
 =?us-ascii?Q?M10F5u9c0xIqRHTky7amgq9EinfNiU8LD+EIR8g9Jkn95Zohg+3nnyAt2iID?=
 =?us-ascii?Q?aZaj/NCPWE9i6V4+LkK6M1ydqYuM7XEYG460rsFPpyR31dwZhSpDngGWxzWV?=
 =?us-ascii?Q?sIQeWfJtQ6dhrHkpS3McaFk5Jkc/2IwFU6i1522tJSzew6al+oKLbhvxyx/i?=
 =?us-ascii?Q?UPO27QDpKeYcbN5pViw+tdbsGXkMUl4EbW6Tq6QLM2nB1MEORrOuvzhc+1Ls?=
 =?us-ascii?Q?ao7uQ7JQM28N3kC4uWA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:26:11.6316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70cd11c-7652-4d74-8fed-08ddfed5a5a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752

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


