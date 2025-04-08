Return-Path: <linux-rdma+bounces-9253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B383A80D57
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF731BA2DE9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9781E5203;
	Tue,  8 Apr 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOQ4v93t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECE1E3DDB;
	Tue,  8 Apr 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120973; cv=fail; b=oWMP9AelER9SXGSfMWlfklCe+Cq78wLzpb7sOQC7ngN/1rDyFTLsO77V8o8o3Dyu7e6lGa8AEU1iBhq8926QbSYIb4C06avZ8dehSFWcJnFwYV+o63I03bDjt1sNhihWWJj/o45xXFFcis/6azlHUnedykjwlEr3SLeEUCyFvkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120973; c=relaxed/simple;
	bh=HK+GOU4sZTQFGSLmUhiDmI6xKe6DNg3kWz1OwtsQgPs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uLOhXGI/lfVzZ9ED6WiPBdJO6qZN3xTtDLnGnACIkPOJYLY+aybHjH91oMzBTUsLOcVMww3u5CpfT016lKjGSiAqG/gtWnjSzgLqMEq0PNkvU4/Hry57mPOvJbmZlev3AB/qO/Qk6TXdwcCY/fO128ZA0JR1VrJoPDgkawlapuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOQ4v93t; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGvIUv24aNGbagx9+Do3NUVoSjVISSBGbKd76AiupKYCggXpGMUEBuAxspM7yZjvMxkpqK8kEouPaTLJKDjU/qMK8RKDFXTHF5Ci8CXdlH7lJuzLfYi8YYw8J8I9eor3KbfsJE8/UGusFaOfjC8cGJvdPiHGfkh4mEcfGxAh1pjL3tfR+zxIG+KV7CGkllgzbNcxJdgMxhg4LF0B5et1Mg7Fd6bMRFklhi5zaUT7CfE8RzFkuA+24Q2Xo1w1wxsDkVdzFo+8dmH1ESoB3O0mf7VpzS6dzTfiFgF4dRdLyLpPaNYEWbQe+RDCGh8iweeRFJ29UPWTm+1pw8GwxXeXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG/JPPJQgoazhWDUBL9CWMishNOKFT85st6KI573E+8=;
 b=RYgS+ejyc1Rknwj30l29uJSL28/Hnwsj+02zTqmCceWTc2WM8I9nBqOD8poqz2IQ3Xc79FUjNv/JWaYJD831UdjNwgRwzzOjgbwu/FZq1UV3XJMWjbYFD3lvOmfi2um5V8cy/SeswlW4LkULM4tkXAdhkuv4xwTquJ8eqWji73jKyVr1ttNxAB7kvxtVqy4XjqMo9L96xhAELm+jOQ3/d2P/H1DB2miAYazEyIcuh7tlNUmqerzQWuM88ZkV3sRESkj5frGRgRSs1qO0SN4Lgem/bQDyKC3pbTo2SQigl4J3RP3hLbjUqf5zYYYh1ZK8b7tMVlxRDPx8q6l3mEikDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG/JPPJQgoazhWDUBL9CWMishNOKFT85st6KI573E+8=;
 b=KOQ4v93tqVbY/sR3piT0sb9Aqm8oA142PjCGHF7MVzc6oRlh1t51a9LH4YrZKd8VyImfWCFoJH2Gsnn5JGQedvlb194ehTdjAcZi1silhietZDdt3rW1tGqk4hcVypNiMEF2wpYgxCVLgK4JUtKPBEnp/QAIVz+2CECaw97NDId7GI0hLSqMConE0q7D1O3pK6zKQkL4r9A1jVyxdP+UAvG2VG2qvp1NNnvAqU13abtDabNJCEAF469FrqyMeeUz+UmPgHyECGVKQz7xuvm01+anwvbnmYMyuBrp9e/0aGQXDKAWj4X2b5gtZG2df6011UD6LcOP5a+gQs2W1qpRzA==
Received: from SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 14:02:47 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7a) by SJ0PR13CA0080.outlook.office365.com
 (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.16 via Frontend Transport; Tue,
 8 Apr 2025 14:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:24 -0700
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
Subject: [PATCH net-next 06/12] net/mlx5: HWS, Add fullness tracking to pool
Date: Tue, 8 Apr 2025 17:00:50 +0300
Message-ID: <1744120856-341328-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c036adf-b600-45e3-a0fe-08dd76a60a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyVMXT/u/osUKxtLXceqZ+uHa3Xey5NcetsyA3dqRPUKD0+AYC2A9GJlAzcJ?=
 =?us-ascii?Q?h+W6sTXZDIzc3kbq3P0sBNqbf033wvJmbU1khodV4fJqhS/F1fubApV1DvEz?=
 =?us-ascii?Q?siKDFj1EcxGke0lR7VgqwnALeA8v7qvBjdeijW5Tg3u6vlBoFXD6C5XBx1tx?=
 =?us-ascii?Q?KVS4DtbpRdnc1mF/gYO1F9/rGuy09LG2/MUROAW+zaWj4EZUk6WIwaRH9zTl?=
 =?us-ascii?Q?VxDoww7NG+vi+EBwGJtCS+vjubozUqrRJ9Um8HaZ6PbiZCyGMeIfLTSUgbzA?=
 =?us-ascii?Q?VVRaDaSYuLFmBuAKxzCkPCVd020joinjdl8lOZc4O5eNxxlSzLvfx39bbI4d?=
 =?us-ascii?Q?9d6MYUmWlXQ8Ppl66yfg1VI30bw2+fHdZ2CX43+kjLR/SSzxM3vXNOQtpOfq?=
 =?us-ascii?Q?hFY/8TGVC46wnPVFDt2EO8QeYDWi9V40Gs3bY1UI+1+1rY9ccTmdyfvYR2Ll?=
 =?us-ascii?Q?WDjBbOlfJPwSh9QvTBa+A3i0n0onXrUiDHdopyJGi+DXuFCD8fDIuVvneBBM?=
 =?us-ascii?Q?iLilGCzOmLfSwO+32QRxeeHFd/SFWa27DFaYTm3aGp4xHpQRCQkrRfhjmEDc?=
 =?us-ascii?Q?jS6fQwF8LmqbkXYGdeQX8rdAYiPyTHzNeMuSgzGnLeqncEmvvf1Gv3SZOrmd?=
 =?us-ascii?Q?J+7mKRbwRgFSOQpvGKaQR0C/TFwyAlA/wxzBj320AW/T6pqZnTb2HB715oZp?=
 =?us-ascii?Q?C7x7xColgbrNwQ7SdKnApC9oYbB39rIODEJUd0oZRDGQ2dlRPCtxVVNLuJBT?=
 =?us-ascii?Q?/EawDWD4hSbumtCbKcdYKxCLpgrmAbi1ceHiyJKq0GYb902bpimgRaKuwHI6?=
 =?us-ascii?Q?hirxgi8peW87MZrFgH6iGS2cULx8rIDcszu6BA6RCUWka59Q3dq3MSDt/irE?=
 =?us-ascii?Q?itVPoCWaw/T7k6gPFJKLfaPa7pynOTcuK0THHCSotFhgb6CmIGawV21ummzV?=
 =?us-ascii?Q?7l3UWmmNVVRIv4EDxC9GlOuNy+Imvz9FoTGLY6cneWks1oefN4+0IQVEFt0u?=
 =?us-ascii?Q?hMEjCNG3I4Asr5jqiwewSUeW5nPA5MCdVggCIZGxNu2famQqDZg98RmCluBW?=
 =?us-ascii?Q?laY12J2XoIcO/PSwqERzj9KY4sH9nPys2cds4GDAUObOAnXVnYrozriQVzbk?=
 =?us-ascii?Q?alovir/vr7IHnhTPACXrYKkOrCIe+mHNshltOYVhyjsrgnmXMgDAPfGkTWPu?=
 =?us-ascii?Q?/wKDDA2GPkr1nWXWwRBFJIuCIF7JanbOMuZHmZ6lbL7mIO2A6ihmIBnJrDsQ?=
 =?us-ascii?Q?xsMAo6gt2R0A8VdyqV60/eAoXOfmJGz3XZY5CmAqCxZRyfUMXkClRS+nOzJF?=
 =?us-ascii?Q?3k7govBtPqoSsK7t/E/1PCAoojIiAL7PLEY7XxlPsKOF2HVrg/JMqn7XbgqM?=
 =?us-ascii?Q?LoNqCiuANt2G0Vl3UjfIBflEkvyA+bxCHjXxp+ubFwSb1uqR75y2L8Vf+OcH?=
 =?us-ascii?Q?9PNOzy8Vw5BTS9++gGDu2rGAxltCtMkpozL1ckUvH5DXfGIY4UKBdzsaEA//?=
 =?us-ascii?Q?pVr8Dx5VOH1J1V8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:46.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c036adf-b600-45e3-a0fe-08dd76a60a67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750

From: Vlad Dogaru <vdogaru@nvidia.com>

Future users will need to query whether a pool is empty.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
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


