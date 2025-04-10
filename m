Return-Path: <linux-rdma+bounces-9348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E08AA84CCA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144754C8154
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F1290BA8;
	Thu, 10 Apr 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TkYeC1Du"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510C28FFC6;
	Thu, 10 Apr 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312732; cv=fail; b=joUp68IQAuYa43qji1IluQ7X0jqD9EduBitD9cYztpTaI5acU8hVl2dm+9svdROV4qXt63B4HbbMepFu06suhq5rQW2fx2cVR0u0X2+ZlKZ8P8mDsrfG/mdNfPRswHlgoaiFCjlmycFpMJx7YXXFugfeIy/IEFaI1v7nH3FSgT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312732; c=relaxed/simple;
	bh=tvXIIJFnNgmZU2Zi3ccRqyKf+tHqZS86Fdk6dRfeWKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmsaGm15dhqzT1ysNl/7ckzPnuVRbxjpctznyurf7nB27GqLTICPI7GXZIhZcCh576J1J4eJoZqX9VRW97KKrQUkYUx3vP4aX9OHqOwW7yo5nnsa/uNogFQjY73K4rh1ZJ+yqz8baSo1tRwjG2luDdBidoGdHtayUaaR4Z/lo00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TkYeC1Du; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV3f5jPcGoAY/Xyop3MRWs1oRD6qDBanQJN2hU5PlqAz5KeN1YxQ/MOhjyraFuJmCiiuAFHRG0e9ySzv+BLWsrnE2pmf0eQTN9NgRwu8aaKo24aFvZd55+K9BVy894+DXbKglCGbkq1AZYCz5adYFan2hmcMnpzjVn869r0DIWWr+Ys1sZ87Hdu7ciNyqDBv5tYoyptuvMjAVVcLqnPulADH21oTx+FLc/2M6KED3xn8yHOq76SW/vbmyE9aLDM/z6HRkxX8tymI0zGejUc1p1BL1ZIZ0GM9AHreIuoNXTukh3Ruqa/T0XjIAkVX9XJRrEWWjObkeutEREXljSaLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUqq3GTRzRCrqlG/Yk6ipU6Jh6s068yQarIrREqCL5k=;
 b=kiZgspQDwfb2opg6lsz+KKxKWu63YhDc2vFMkH/ukXcDrw2E+ydy98GqUw2E/oQglgSAm5uwOHetYRn5AmjEfMT6ueIpXQhojwzeAD005+HykQBMkzvSUh188gN4PwvlKpYUVJ5ulXEN5oPgU4i0tl1dZ5JxxcsGhuAwk2ZzQdVAdNXS3B9YpQaMzmy03uYGb4fn1vBt7D+eS8uGACcR4Tw3d0YN+KtaWhwFX/bA7G1wO0Y7dhDnsNs6vhE5XWhowlURN8dTJzSDW+SoST1Dtwrxi6BYBuoU6PACrhnsHq4E4sZHhh3u4BoKuVnqsHbE3XwawhuINQlFgxWrOUTeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUqq3GTRzRCrqlG/Yk6ipU6Jh6s068yQarIrREqCL5k=;
 b=TkYeC1Du/mkfNHdg1V/hkXIZGus73VWSzMZhIai6hPYX9A7CChkG/kAr3MU003mPxc8L51EdRVcx5PeT7K3mvwLqkFK3/vO11AHmKB6cEutvkjkVnmDis7A1U2bZ079cGMRMjdpfLLUdgRfRdawR/eGmv5RuNKdtYmK1sICMw5oNk9SQnDEnugd9i87eBVNKh4ytYe7tH5RQY4E/vul5G/ulz6DHPMl1VKAtJtnth/RI+oHVhvI/RcfWNXKb++N9b4E7pXc5bGbl3/MW1wY3GrgvXyp0SPwttUam/tHUcK44wDXtPN80zhWzYS0WX9579+4fkEI11/I9TsFOhe7FRg==
Received: from BN8PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:94::34)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Thu, 10 Apr
 2025 19:18:47 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:94:cafe::99) by BN8PR03CA0021.outlook.office365.com
 (2603:10b6:408:94::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 19:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 06/12] net/mlx5: HWS, Add fullness tracking to pool
Date: Thu, 10 Apr 2025 22:17:36 +0300
Message-ID: <1744312662-356571-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 442522f6-466c-4288-6f69-08dd78648469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxQYswyBo5rbHT2MiV/6an9dN8hh8ZCLBZj9f2FxkVt7ZpPKorf2FuYkW52r?=
 =?us-ascii?Q?sL/TaXuqW97TlN1q7UGrr4QjMzK3eR/lgXB8W1bG7Ujd6+LsDAxZLxB2cr26?=
 =?us-ascii?Q?W0J7S9srldSKbKAk7OftIz0BsxdUYjUChq3d/auz19aJ/eiMj9j6esEXhfI6?=
 =?us-ascii?Q?6TprXbngp9mUfGAfm8298k6eGC8N9gFzANtJyctFLT0hSjVQnSZFq0iDxlWA?=
 =?us-ascii?Q?9AsHJQQFnPZZdZcL2pWfeAefgkafCVH8CMyPZA17LoTF6492iKtuTNdR79tq?=
 =?us-ascii?Q?fu9uIru+ikJ74Nw4BLuE6EPnaDSGaTZVvPx+GkxV+SINCeelJlsKyucSVCfa?=
 =?us-ascii?Q?gR0zfDxkuWTdTp7uL6aZ83b3gBH97q02nUjWrPf6i1FpJO51040ZUeA6drSV?=
 =?us-ascii?Q?/4wdhZ5K2+erzOw5dVj4rxluhMbrqCn5ip20qXqlUWeS1Wkye2YHRbU2Nh9L?=
 =?us-ascii?Q?gzhu/pV54ymuj2YV8Wffk0+/Cf2kjt5f9nERs6Qh1XGZn0dME+abK1zKuNDE?=
 =?us-ascii?Q?6F6AagJiM5BfzbOtG8WHES2aStqohU4yBq3WOb+ryxbo7B0AO8MRWLnJj55r?=
 =?us-ascii?Q?21/o5r6Xjlqayi0jGvsuozl0Y1HPTPHvIK2kJfgPT4erI8KsXXo/6VqNtCXY?=
 =?us-ascii?Q?PRvGXXm4/ZGNSJbbYCCaOPdRrLj+chknqo4Q34cbo3tFVjJ028rcrKqQ9Lam?=
 =?us-ascii?Q?KJ/VGl6Z8Mc5pieIpMgk6j6lWv1uSrXYQdR+xhRAHY1aveq9ffkvhdiumfKn?=
 =?us-ascii?Q?svLg4kgofoW6CbEK8eGcZZzntKMjTpz5rzcHiRm4oo9QAYR5+dEmTxtgigcN?=
 =?us-ascii?Q?hTHM6o4xCBZCEdEGVEGhR3lAODV0jLtUPPdzM/TljyqXsHCBSAp7WstndPDK?=
 =?us-ascii?Q?f4CguYAe9a7XYV9O+fK36RsMwVVFNkvRIn9NUvn6Cu9f1Dzz8KBuRpfphVn+?=
 =?us-ascii?Q?EGvaG5slRJkWSH3LcNbtzkGMKzIIOx05300u9dxTo4qvvkILYfyzuD8PaDGT?=
 =?us-ascii?Q?XfMe7ApaF5VoRtRkwEAqTB9wcfkBUcWVtaBgMND5UBVcsc1mjF+fJwDP2Kt3?=
 =?us-ascii?Q?/c3KoYaYT/r08cjVA5wZzWqX49eza610Dt6iEXjBjeYprPBM01VDoSV7niPR?=
 =?us-ascii?Q?WU/Y4CIPF202Kc307czzKQ0H0OhBqSLEDchkVxLzgG5qNAkb3ZMn5VtVRz55?=
 =?us-ascii?Q?okxxbFSTyTFMTJfmXuzAWwsute3XeKxBhHtqMG1u44uAQ8ydIQwCB2R/Ug4O?=
 =?us-ascii?Q?bUq7w5CuTksWQ4vrRN5ZFJDJO6wTfN8PrjMSfyxyXk18lKdPOJmN4qIBkTbQ?=
 =?us-ascii?Q?w/fGTkILEX9HrHOpa6EdDlf8Dd414224BTekhZTXSbvjVBm6+uiv9Jgn5s7j?=
 =?us-ascii?Q?5VxuxVfIUxIC7quakFOAWs4vMTzJynSEMQdzaCjCInhq7YzrToTzAzsJfSLI?=
 =?us-ascii?Q?Z43Xotdgr06kfknsjWSwTaebb7dCADlRLsfIdXFKgYqyRzfo3H4P0ZmvD8n9?=
 =?us-ascii?Q?RCwZQGyEUC1teCr3cVvsIWeUA+XxseNcnYX3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:46.8012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442522f6-466c-4288-6f69-08dd78648469
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

From: Vlad Dogaru <vdogaru@nvidia.com>

Future users will need to query whether a pool is empty.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../mellanox/mlx5/core/steering/hws/pool.c    |  7 ++++++
 .../mellanox/mlx5/core/steering/hws/pool.h    | 25 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 270b333faab3..26d85fe3c417 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -324,6 +324,8 @@ int mlx5hws_pool_chunk_alloc(struct mlx5hws_pool *pool,
 
 	mutex_lock(&pool->lock);
 	ret = pool->p_get_chunk(pool, chunk);
+	if (ret == 0)
+		pool->available_elems -= 1 << chunk->order;
 	mutex_unlock(&pool->lock);
 
 	return ret;
@@ -334,6 +336,7 @@ void mlx5hws_pool_chunk_free(struct mlx5hws_pool *pool,
 {
 	mutex_lock(&pool->lock);
 	pool->p_put_chunk(pool, chunk);
+	pool->available_elems += 1 << chunk->order;
 	mutex_unlock(&pool->lock);
 }
 
@@ -360,6 +363,7 @@ mlx5hws_pool_create(struct mlx5hws_context *ctx, struct mlx5hws_pool_attr *pool_
 		res_db_type = MLX5HWS_POOL_DB_TYPE_BITMAP;
 
 	pool->alloc_log_sz = pool_attr->alloc_log_sz;
+	pool->available_elems = 1 << pool_attr->alloc_log_sz;
 
 	if (hws_pool_db_init(pool, res_db_type))
 		goto free_pool;
@@ -377,6 +381,9 @@ void mlx5hws_pool_destroy(struct mlx5hws_pool *pool)
 {
 	mutex_destroy(&pool->lock);
 
+	if (pool->available_elems != 1 << pool->alloc_log_sz)
+		mlx5hws_err(pool->ctx, "Attempting to destroy non-empty pool\n");
+
 	if (pool->resource)
 		hws_pool_resource_free(pool);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index 9a781a87f097..c82760d53e1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -71,6 +71,7 @@ struct mlx5hws_pool {
 	enum mlx5hws_pool_flags flags;
 	struct mutex lock; /* protect the pool */
 	size_t alloc_log_sz;
+	size_t available_elems;
 	enum mlx5hws_table_type tbl_type;
 	enum mlx5hws_pool_optimize opt_type;
 	struct mlx5hws_pool_resource *resource;
@@ -103,4 +104,28 @@ static inline u32 mlx5hws_pool_get_base_mirror_id(struct mlx5hws_pool *pool)
 {
 	return pool->mirror_resource->base_id;
 }
+
+static inline bool
+mlx5hws_pool_empty(struct mlx5hws_pool *pool)
+{
+	bool ret;
+
+	mutex_lock(&pool->lock);
+	ret = pool->available_elems == 0;
+	mutex_unlock(&pool->lock);
+
+	return ret;
+}
+
+static inline bool
+mlx5hws_pool_full(struct mlx5hws_pool *pool)
+{
+	bool ret;
+
+	mutex_lock(&pool->lock);
+	ret = pool->available_elems == (1 << pool->alloc_log_sz);
+	mutex_unlock(&pool->lock);
+
+	return ret;
+}
 #endif /* MLX5HWS_POOL_H_ */
-- 
2.31.1


