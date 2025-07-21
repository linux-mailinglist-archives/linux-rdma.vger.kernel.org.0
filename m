Return-Path: <linux-rdma+bounces-12361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC7B0BD53
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 09:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B61188C78C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 07:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D13283151;
	Mon, 21 Jul 2025 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KwRpUkeg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD67285074;
	Mon, 21 Jul 2025 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082056; cv=fail; b=jbsE0i9a2xu9f8fF65jkW0KUb24z5Wm9AGTpVac4ryFh7oUK6rp3PE0FN9Q0lSmAU5gyrwMeknL0gevb7o+z2l+xfRS8nLPVIsxG9lqGfQj8zdsLdgpqfbTvSJvGOC3Z+CD1Mx0QzC0HcC5GlVrUwdylxh7rAdvBk5kcvSjveuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082056; c=relaxed/simple;
	bh=y+fg1y0das10cLYBK5O5glzaw9FxMcNRaKxk3g9cxEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBQPzN4DxKBYeSEhTJPW37/eFc2oOOd5ZIOIGTfjG0g0tvz1VZ7yrjK1ICOWDWOwN1omdFnWxpqWU9jjFqCWFygMJbk1mwGK95bg6fJoGw6WC7RM77Qx0EEUupziyWKcYJxLlJ9UYj9TFmASZHjGsen6f50d4IQoPcSfKVwYaeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KwRpUkeg; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJsOWJ7bmZWRelNWFRQfOuG89HGOhukoOrqODJVzRiAytzMc4ub46/vrek2gQgpazprim9T4Jec9pC7E6cOxykLDOabhHvWsuBSwp/x31XOta2IvgDtB8JAFpagAkHseV6ZRqTMVSZqV3TPtqRFEbrQcNsq7UzW1rPxl1TMQFNZ5gtUMZhOn4cXe1oWPfXDLKPLyVZJ64kABYQsB4xnWvGO8Yee2bxB0clO3N1JPTH8QqkI83ozypW86b8kBD6qRMGO68vGZJQYBUzLSta4L9++b6jXwI76UsSqoLFCguROGX2pcKPDTxnGqcJBXO0iPlozuf4vPZfvMJ1Yc3hL6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmajpKoJ1UUd5OWXy2jrzgfuvbsdGiLlwEDCzV/ESGI=;
 b=xP33SJfYtS5sBKFyzhjiwXtj0OMTSJnRcSquH4NNbvKh4Cy5QwS7lMNSRlSaaG2cJEnKvSu6Ko43yA/9ex9IPjsS1bYZD1ik1BqUsFUa5EtU+eE0ukmeLdggV38ynt2g8ZyOy6OllqC0qR+BIotIr/NV/t4/SAfpAQVqSByVtoZdUxfT8Gtu2u5vCTPYLN5sb4ADenxEA/uPc05CcCsFu4zk7hL/+CjJaLx/YuT7oHOhtFN0rDW09c33Zvl6jNxGsq1OwpTmd+RYiyxI4P/v1jz13+QmpCruXnY27/9LyhdF1FFvsWcBTRKu5dEBCRTAa3uTWXHCHypeJRONatlYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmajpKoJ1UUd5OWXy2jrzgfuvbsdGiLlwEDCzV/ESGI=;
 b=KwRpUkegWf3f2QX2aLUZ6LRxFCsqFCK8+wcGq3p0h1CyK4z5umig1AOfBGK2c/NSKWaRJsDxJnLtZaFZMgzPSalL29CUVCIFepNU2wFO0jwqcVCtBg1B/AWcqc3iSX8GKP/kIs19gfWmrwJupMzJwM1BabtKGtD94pI3QySjVzk9LX3aOXdpbFTZpiEb93bEt2gVIaT8cj3I9neeVBWLGfvGTltc5LDqpX1HdsJ/UvsGfkxmpfcCAMaC7n4FWbTGhyVcBO/SLMLSpqfmo/Ypb2X5+9yPCQekHImGgZl0GWRWivHAUxLgjm5aFXkyU8wQXcFwLVRjIdafdTloWa7SYw==
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 07:14:07 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::97) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 07:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 07:14:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 00:13:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 00:13:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 00:13:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V3 3/3] net/mlx5e: Remove duplicate mkey from SHAMPO header
Date: Mon, 21 Jul 2025 10:13:19 +0300
Message-ID: <1753081999-326247-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
References: <1753081999-326247-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f0915f-2e4a-4381-19ce-08ddc8262eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4TlR+L392i8Wvj6bRJmlAcBrqe8/GZ7v0vn/04hS7ALkKpfEy10XnPUcV35?=
 =?us-ascii?Q?ltbN9s+u/y44X3dNVmzUAedNnoZTu09bUsAiEpZQlFe9HpV6SMTGaBTPWt7t?=
 =?us-ascii?Q?IQ+npM90tcRz5DhYvAik02VoyRan1KJRceJ8wNpV2uT+mj/p3oq6dC263VKR?=
 =?us-ascii?Q?CTvrA/ap4ZBUIw8CuRQ8Hnu+G6kNbgW6Vu0NbXprKYLDIZtFwisraRm36HbC?=
 =?us-ascii?Q?DMZILJoudtvtbalxdNfZZwN9S7zmBUbL9A6ELspnLZNeOJgWdvzSbWm+Msad?=
 =?us-ascii?Q?wCXlDbdAgUzvwDHT1yxqs/1KwTCOjV4n68bTbPumT2t7AcG+VgzfQK9VQrgV?=
 =?us-ascii?Q?LjuT3hH+FDfN63TOMZ7B278LhQfqLrDs4SGj6MrCxWiiUytkz/IIGkcojtjM?=
 =?us-ascii?Q?wzqEPTjFgcwQJPUrGVKUTqF14UbLkYNGD05LASW/WA+ebjrM3rzeiXry/xHm?=
 =?us-ascii?Q?Yd43oUryyN+sB1PQlIgeVF39FacFs64mrbPktXj4BRcR1k/pK5aITvKRW3DX?=
 =?us-ascii?Q?s5FuawFv79ODGsZtE4OhA15FeEGrFiVHs0oq5fdfR/Qj63OondfZxSB2RgyD?=
 =?us-ascii?Q?twQo0VnU2gysDSQtuFTQznuQqAi5xLFRWctNNeLPiROB3j0RJ/3oTfqfVhLQ?=
 =?us-ascii?Q?W2gmPll1h7nvV7AQ2P3gBoln8tptcUh2vHYW5LOId3uB8+K5+5qarPNTSsCQ?=
 =?us-ascii?Q?dl8CCEXL00a8TdxcK8SzMJcFmjPPnksHnhV8HssmwNAdMXTOrWFCOFHJunLE?=
 =?us-ascii?Q?jHAAsuFcFj3RzLOs7BGhvKbSU5OPfpD2LN3eZ+I+ZMQoQ8G0odcGyTbfYoDC?=
 =?us-ascii?Q?RoXyfzV7E7jtH/v3zz31l2qprz/+MlxeKcTH4o22KX4sGqipwdCvtS7vbOaM?=
 =?us-ascii?Q?Ns8+ZX0gZH7fiFV9oii+42v380jBk2UsG7M6ecdRj8+KMB9Cku+vd7liuGPJ?=
 =?us-ascii?Q?+D7rsRf7eNU9VSJp6O8f47MF/2M84rVC9PKNuFR9O9ZaWXXbHHgNLFVz5/3s?=
 =?us-ascii?Q?HQfO0KiijC4YhDtpKYwqimuiWry59epiofCu0pO56NnW/84UD8KrFQfn3bi2?=
 =?us-ascii?Q?ijt9HJfy9Xu5TFezR6pd6fp3Fsexm76qdnh6NVtLz4oiI5m8UOwYvS9TmSuH?=
 =?us-ascii?Q?FmQC2lB3zDTw3wGGfptUN1UDxfRGk9Ox06302SGHPR71iyvTmRXth7T+b2Uf?=
 =?us-ascii?Q?+O53jLpIrYfvOCmGcJlIMZnBzpK6T8LGkfICGbAqndy6bewo6+0/MqHgV523?=
 =?us-ascii?Q?1nzDZYglYc3oWjvXiYK+cAQNRNRmYnVz/hZvVLVyzgwP8oElXFFtEu8ak/DY?=
 =?us-ascii?Q?vttBiRG4LsUNrG1cwrP4c/7EuqcsrmzW2KZhO34HwZyzsL2n5Nkwna12JTkc?=
 =?us-ascii?Q?6+9FKDd+/aQO1VNKerdom7n+n0oeiCTWeGIoscVuCGQyXUIPcTbXUxVP8SSt?=
 =?us-ascii?Q?szC0KQYTnIAMWAw5DEWYham3fkuRN8+dTmOVu15pD/ovyfCNe6ZkmFzilpIC?=
 =?us-ascii?Q?xZZNw7CamqShoPEUqs7i6ZkEnNTgEf8ACpK0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 07:14:07.5117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f0915f-2e4a-4381-19ce-08ddc8262eca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166

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
index 558fad0b7e48..99295eaf2f02 100644
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
index bd481f3384d0..33bdb7f1e03f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -546,18 +546,26 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
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
@@ -783,11 +791,10 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
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
@@ -832,7 +839,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 err_hw_gro_data:
 	page_pool_destroy(rq->hd_page_pool);
 err_hds_page_pool:
-	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
+	mlx5_core_destroy_mkey(mdev, be32_to_cpu(rq->mpwqe.shampo->mkey_be));
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
 err_shampo_hd_info_alloc:
@@ -849,7 +856,8 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 	if (rq->hd_page_pool != rq->page_pool)
 		page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
-	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
+	mlx5_core_destroy_mkey(rq->mdev,
+			       be32_to_cpu(rq->mpwqe.shampo->mkey_be));
 	kvfree(rq->mpwqe.shampo);
 }
 
@@ -1122,7 +1130,8 @@ int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param, u16 q_cou
 	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
 		MLX5_SET(wq, wq, log_headers_buffer_entry_num,
 			 order_base_2(rq->mpwqe.shampo->hd_per_wq));
-		MLX5_SET(wq, wq, headers_mkey, rq->mpwqe.shampo->mkey);
+		MLX5_SET(wq, wq, headers_mkey,
+			 be32_to_cpu(rq->mpwqe.shampo->mkey_be));
 	}
 
 	mlx5_fill_page_frag_array(&rq->wq_ctrl.buf,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index a4896e89fa35..218b1a09534c 100644
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


