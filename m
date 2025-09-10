Return-Path: <linux-rdma+bounces-13224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74CB50E78
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB14C168F3F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBF030649B;
	Wed, 10 Sep 2025 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eozHJ5zT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0E308F28;
	Wed, 10 Sep 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486932; cv=fail; b=OPCHS5F58LgmXdLWE6uAm1SmSHCtLZc7ELZ6Xg+ugwP7Se+M+hWqBGVwpqpUAVgNcZQQGPH2U9n2XnXBkQ/io1EtJAZmyriDeZ1D2WC89M/jTEvcHd9P5uZKDCrkz7/pfLgIbhv9euexZLYkSXNUyRrDBYkn0m89Trzx1eBg59c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486932; c=relaxed/simple;
	bh=HbvMwVADizVkTcy6pItOZ3pTESvMq4KzyhWvwn75YLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+K0fUedECG1Hmag8/iPojFApbSqv4d7cJGfqr5suyzYu7satJjM2pwGFD3xaJWdd7ESpfCeK5cJPJEUI3PQsmJRe6apxFATeJb4VgSPvQxwpwN3t9AsxIL+aBgFwkYlnYO/45VXTXTOcj+6MPGRgo5/CPfIMNBSmWl2/12rMXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eozHJ5zT; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOpRis2vT/JOi93XfOxSos/zDLpKGruVigHrpDn6TIMpqsVaLo7hEQIMRQT73y7v/xoBEx/Lhfxt8/BzzV21GcD45c38kJ4N2E/JEdVXRzf915fkzL4CSE9/LB5+DfyloYnHKMZVQ9Wb72yxtZAL96Br7Sq5M8psuLUgFTDMPNgU7E6vF316QX4Sc1MJxG5f95DvJHJ9mmTMkTEj9HFpeuz2g7GqGWIbwgDawrcK3VclcIqUuxNF1eo1KqkuKYa5GaOJgkLI4KfcuQI6eVDhi1r9MnaZiQLJja/VBpVoxA50P8WbSvWU7YDR25vn64DewI/X+Twf4XAWkqEMMHNOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkSrYlmwa+3/iARvgdDIqNlLm3X3CoMfAgB03picEgw=;
 b=CgALBf2Edqw6DdUH38FMz7a0UxPhnUvnu1+tBddHF6nL26rw2gGXoVdfDJC8+nXkuMqDNZW05iQOvV85VjSSic3h4t4XEGlZIDainSap6fzFDXYvqklJbwIXUreUFpDt5/HZl0h2UF1vbLSoutQqgMG7u6M3uy3GcAqw4lEn1AWG9u5bHuZNhw6ZAVhWY4l/H54knhOJoV/7dz27BrcszHKVPZ6FsCavWwLwr4oD6c2n0DEc73Y1kvL1zkiAWY5q9iEna4zVFTB4hpN61tAAImt9Yb51lT5NcZOt/hY+7oiJ51H3xsWVv5T7eK3bK/OlP1sPGn3/2rhFdjfMIa27JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkSrYlmwa+3/iARvgdDIqNlLm3X3CoMfAgB03picEgw=;
 b=eozHJ5zT5QLuSSoLwmyuUhwEXWwY5zoUJBsCnhYSJQiczJqkk46kHUB75QDQmm+GVpjh1AW8D4e90figfBl8CA00GSo6Y6Ufq9e9Hzd+wCTKfaOYQbscQdD65T6uESF4BsTXhkI/HaS+cc5W70fIpxq9y1LFs7tWtd6BFnHBBKO3AqnuspNI6eOEVwCWTAZf7pF7mdgJJG1E6BjLBwbFfGvAuKTgqvC6N1F0g8nsLWvq6Wglo3pcnFg1/P+yslahsVjeoQblkggTA+8SylW1yRTj0+cM4q/9bEKN359Kht0+XebGoUoPIInVGvQv9iXgBujgQpqjOyllqpUduOBKZQ==
Received: from CH2PR19CA0029.namprd19.prod.outlook.com (2603:10b6:610:4d::39)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:48:45 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::58) by CH2PR19CA0029.outlook.office365.com
 (2603:10b6:610:4d::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 06:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 06:48:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 9 Sep
 2025 23:48:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: kTLS, cancel RX async resync request in error flows
Date: Wed, 10 Sep 2025 09:47:41 +0300
Message-ID: <1757486861-542133-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: aeae3a01-aef5-4f65-49db-08ddf0361618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?spBr2jbCbdHO8zgviWCcZvSbvmjUocrGsPM+ObpYkpGAnA6kYpOK0OnZFHqH?=
 =?us-ascii?Q?hIxJN/kD7RbH08dVPEmn7a4+TIKoa6MhB/dgZFjNNnmq0oUyDgLQQFv6UAft?=
 =?us-ascii?Q?CaZSy+t9oleFudPNy3DPebR/4mqfF0qKLxE82YRM1Rhz/QaE4L6W46TdzaUc?=
 =?us-ascii?Q?4fXRMD6j6Cc28gBak+GES5qY70Phoa+D7uaV6wBnhRusieQ5VomeR/mqujf+?=
 =?us-ascii?Q?Ig/JRjmVJJDu2NyKi1DtKeQtkX2+Ht0aBhGukql4So1QQE/51tn/QzHwg74n?=
 =?us-ascii?Q?8dl41o2PdHYPQyhNxNVJ4s1f90esW4FoVT3hq3OofgfjJIiVoR843U/UcCil?=
 =?us-ascii?Q?Lz5mE3hDNv1WVHXeaRLsxsC4kgzyfz7E9iAfyUOPLkeDZwLs5pc9DirEBRv8?=
 =?us-ascii?Q?cG2TJxdq2Kmn/d+O1EodM8aE/QvTGq1gxGgvTnZHZCelLObMa68gZr09pjMs?=
 =?us-ascii?Q?NUfLLOJoCBsrAtKpgUTBkF18hpgA+O0oYlzbbTvjmpG2LKD50XCxehMbKxNd?=
 =?us-ascii?Q?+409aCjjp+/vHcQSLApd02x9TDhn3mR8c3AvUM2OFkt95RatvA/yoOgPYLuq?=
 =?us-ascii?Q?op+wiRqopNifqcWdTvqriaNEjUlOsKqfV1Zg8SXHqXOLDGpVf7sZCAC9fhlf?=
 =?us-ascii?Q?hq0pv1oWkHQsFp7tBptyMK5b+P30K9FWgHVn9fb7KdUz/bFo3P0JRGRbHMqs?=
 =?us-ascii?Q?ONq+O9SG3tQFNZ7TE1BuGoQtcAFa+zLlmlImLON44XvkxK0HIg18aHQKZyCj?=
 =?us-ascii?Q?JMg5zquz20uJxTLgL9tdPXynPPEOlnLGYZtGS1Xz3WtL/r5Sqvb5Dr6wEfph?=
 =?us-ascii?Q?wNMoypOBS59qUp9iCHtRJzE/p2S/aVbvdcxxLh6peEp+Jhog+i/GBagfqcWI?=
 =?us-ascii?Q?4Yh/xx+FP3MRwEtUwvah9+YxhSIyyE9Ut/A6Y5DDRyoUIXa1fqwA5ODSrRts?=
 =?us-ascii?Q?UE1+EP3fuwOlBu8b4VvqmyXW/fwUJnl/x26BsNfLTitZwwSlWiaMei4lrl5h?=
 =?us-ascii?Q?sbkSMvSUTsvjxIAYuXCsUJG4W7N/BaspdiX+BFIScZqWi4gRqy5wMEHukTSa?=
 =?us-ascii?Q?1yks6h7PTqVyTYSGTcOPBhS++YykGX0h5OKjEk1LnPwPKDC0Erzw9YLp2XJV?=
 =?us-ascii?Q?NMIdWzgLTLijzrwz7xOmDYTdnJsw82+j1MqukbgkBdN19poS6VC4Cdwje2yP?=
 =?us-ascii?Q?Jz+TfbyLi3Mn90IWcXrdsGD9bWPRoytuqX4GP1F882SCffEeknQ81ESxUIc3?=
 =?us-ascii?Q?gEYKSzx7YxWhkZemnNsxHUa4Ml2JY7T/g+bzeLNbb36ZhBe9DyTjqKze3/tN?=
 =?us-ascii?Q?5zmSQxky5wkIB4IA3SjHx1qKkvsSOT6z+EcjQKjuoCqkdtTWR7NLrvHUQYSm?=
 =?us-ascii?Q?ztKiRx30aMGLIel9Dtr+I+Zn9bZqMy5xX/TR7jxzQJqLTKdVSi28HGayNcre?=
 =?us-ascii?Q?teAMoGAENS8Ey2xtoDrjLVaf4nMhzmUbFFKjA9N5bWcWuYA8scrHeVa8bHLC?=
 =?us-ascii?Q?nN864OwrmLzw5b7Wgn+REc1qv9INsquFzb34?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 06:48:44.4351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeae3a01-aef5-4f65-49db-08ddf0361618
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934

From: Shahar Shitrit <shshitrit@nvidia.com>

When packets are lost and the device loses track of TLS records,
the device attempts to resync by tracking TLS records and requests
an async resync from software for this TLS connection.

The TLS module handles such device RX resync requests by logging record
headers and comparing them with the record tcp_sn when provided by the
device. It also increments rcd_delta to track how far the current
record tcp_sn is from the tcp_sn of the original resync request.
If the device later responds with a matching tcp_sn, the TLS module
approves the tcp_sn for resync.

However, the device response may be delayed or never arrive,
particularly due to traffic-related issues such as packet drops or
reordering. In such cases, the TLS module remains unaware that resync
will not complete, and continues performing unnecessary work by logging
headers and incrementing rcd_delta, which can eventually exceed the
threshold and trigger a WARN(). For example, this was observed when the
device got out of tracking, causing
mlx5e_ktls_handle_get_psv_completion() to fail and ultimately leading
to the rcd_delta warning.

To address this, call tls_offload_rx_resync_async_request_cancel()
to cancel the resync request and stop resync tracking in such error
cases. Also, increment the tls_resync_req_skip counter to track these
cancellations.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 29 +++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..ec9400de95c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -339,14 +339,19 @@ static void resync_handle_work(struct work_struct *work)
 
 	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags))) {
 		mlx5e_ktls_priv_rx_put(priv_rx);
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(priv_rx->sk);
 		return;
 	}
 
 	c = resync->priv->channels.c[priv_rx->rxq];
 	sq = &c->async_icosq;
 
-	if (resync_post_get_progress_params(sq, priv_rx))
+	if (resync_post_get_progress_params(sq, priv_rx)) {
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(priv_rx->sk);
 		mlx5e_ktls_priv_rx_put(priv_rx);
+	}
 }
 
 static void resync_init(struct mlx5e_ktls_rx_resync_ctx *resync,
@@ -431,8 +436,11 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 
 	priv_rx = buf->priv_rx;
 	dev = mlx5_core_dma_dev(sq->channel->mdev);
-	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags)))
+	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags))) {
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(priv_rx->sk);
 		goto out;
+	}
 
 	dma_sync_single_for_cpu(dev, buf->dma_addr, PROGRESS_PARAMS_PADDED_SIZE,
 				DMA_FROM_DEVICE);
@@ -443,6 +451,7 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 	if (tracker_state != MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_TRACKING ||
 	    auth_state != MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD) {
 		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(priv_rx->sk);
 		goto out;
 	}
 
@@ -472,8 +481,10 @@ static bool resync_queue_get_psv(struct sock *sk)
 
 	resync = &priv_rx->resync;
 	mlx5e_ktls_priv_rx_get(priv_rx);
-	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work)))
+	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work))) {
 		mlx5e_ktls_priv_rx_put(priv_rx);
+		return false;
+	}
 
 	return true;
 }
@@ -557,6 +568,18 @@ void mlx5e_ktls_rx_resync(struct net_device *netdev, struct sock *sk,
 	resync_handle_seq_match(priv_rx, c);
 }
 
+void
+mlx5e_ktls_rx_resync_async_request_cancel(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_ktls_offload_context_rx *priv_rx;
+	struct mlx5e_ktls_rx_resync_buf *buf;
+
+	buf = wi->tls_get_params.buf;
+	priv_rx = buf->priv_rx;
+	priv_rx->rq_stats->tls_resync_req_skip++;
+	tls_offload_rx_resync_async_request_cancel(priv_rx->sk);
+}
+
 /* End of resync section */
 
 void mlx5e_ktls_handle_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
index f87b65c560ea..cb08799769ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
@@ -29,6 +29,10 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 void mlx5e_ktls_tx_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 					   struct mlx5e_tx_wqe_info *wi,
 					   u32 *dma_fifo_cc);
+
+void
+mlx5e_ktls_rx_resync_async_request_cancel(struct mlx5e_icosq_wqe_info *wi);
+
 static inline bool
 mlx5e_ktls_tx_try_handle_resync_dump_comp(struct mlx5e_txqsq *sq,
 					  struct mlx5e_tx_wqe_info *wi,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b8c609d91d11..c713e683ef1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1035,6 +1035,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 				netdev_WARN_ONCE(cq->netdev,
 						 "Bad OP in ICOSQ CQE: 0x%x\n",
 						 get_cqe_opcode(cqe));
+#ifdef CONFIG_MLX5_EN_TLS
+				if (wi->wqe_type == MLX5E_ICOSQ_WQE_GET_PSV_TLS)
+					mlx5e_ktls_rx_resync_async_request_cancel(wi);
+#endif
 				mlx5e_dump_error_cqe(&sq->cq, sq->sqn,
 						     (struct mlx5_err_cqe *)cqe);
 				mlx5_wq_cyc_wqe_dump(&sq->wq, ci, wi->num_wqebbs);
-- 
2.31.1


