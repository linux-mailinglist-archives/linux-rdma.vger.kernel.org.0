Return-Path: <linux-rdma+bounces-13945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E2BEF95B
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 09:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6BA3BD7B0
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1EE2DC782;
	Mon, 20 Oct 2025 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sUG9RHM3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5EB2D9ED8;
	Mon, 20 Oct 2025 07:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944014; cv=fail; b=hCjPl3tQcb4J8fPo3lT6m5csD9gQLk7j03ahqCd+rIHgh86nBNgswogKnGSP1Ofys/2gm8JkU/9CyVImDWOLtKF83pnRrGmNXVBFXSOY9Qd0tDRYAAQFTQn0VjSgVEaUi2FEMatQbyni+8CGpU/5Ar/3DWQfxq8Jj2PjY3924Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944014; c=relaxed/simple;
	bh=nq7tEf2dT6cr20ShL5t5WRDzJhpDOj5kvMQBcMWwqIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDmYx3ME8Dj+RMEhqCVUsn4QYHpOY6QVjdhGNBNsa7JP53FFyDEZ0NaDjkrGFqjRfgKIiei4Uw3hJ5OPr9HUDm6C9f/LhaPVGXNM9RX67UgAh3Qnkv/m21wTwcmkh/A2vQONtlLRVT5Bh7pNp7I852bf+SiAGdanJ0PoLbWmHGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sUG9RHM3; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZntZD088bVq7rO3bdzTIGyrnRe8/OBXuvCeVlUR0rJl1Pmodm1cDv4NXt1UScY+5pktkcAGLT19juDjjICYDaGQOpqDPjyqu3etMcJ2hh6+FIsLia7D5XWGytatlN9FKHXzzfoYdrvilv9zfGuBqBZYYLcj6O43OJ1lx1rT5jb9sijfEadGqahGyRe+1N+9SzkW5Xp45N/riyjXwYWpv5Z3JPuxm8Y+GvNnpbUyILn4wsspcH2KFtEv3eV76qaCIj19QKMmthQsS3JMybuWr3YvvQGeABrvIqjSl+9kJ28YQte5LUdUZwG3iNpG0/K4nJEZHUtbdUyRAuyFPQTT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtY4cb2qAFUgxWJmmlGobFYDftXhIpcIWb0Rnj+0240=;
 b=ATV3ps0mEfPitT5o8hP0ffD36A6nRxm0wwQKyeNqe+lKQoD9wpa/h3HKrZTttutqVNCLKO7gG6ObVa5SbNZ2vec6ltkSPw1GU2fNyVSTv/l/Hb8e9LOUZApFA5zv9Tumpo8RYzXqkw7YrJNqr+3RIRq8fJFIRZJLNHSaGk3yMe73A2okxutWD4IFW+3ESKw1pkc8wMSj9MxBWFMiW/gLEIcrCtQCCN2kPnvL8PW9GP7A88tkeVnUD2ss2D+n9szVHqhX1KjNpN90tbzO/8DTTT0thn6h3nzGO7UhCQ5Z5GsTvhqFsh21xCz+bQi6nV/nHxkYZOe3+z3OdFW7pi9jiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtY4cb2qAFUgxWJmmlGobFYDftXhIpcIWb0Rnj+0240=;
 b=sUG9RHM399xix9j5gcTjLyvNtzLsw+KZ5AreZfprbXniQKIACEpMvJGrswy5Xm8nuDHIX+6GftnfJYgMC/6z8hhwYMBz1TYLOG4M90r6c5rfpqQNcMCwxl24p4SVzAuFBGu0/zsyzY0f47ImMmCJSS2onQNAfbsX756G1yYFrhhro5wVNWXDyOWGu/d1V/MmkP+Ncml2EaPfyxToVKZjDp37KM3hiVriN3W3cu7U7brLMXNo/BKpTurigdBRKGiuOx5cmUbGSG5voVFYSxAuV/ACBIBaPW2LSrVZ7SXq0VwsC2gv0WBzdZ1p1WfRJwSJe0EPwLetIvAKd0hJWtCOSg==
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 07:06:47 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::26) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 07:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 07:06:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 00:06:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 00:06:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 00:06:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net V2 1/3] net: tls: Change async resync helpers argument
Date: Mon, 20 Oct 2025 10:05:52 +0300
Message-ID: <1760943954-909301-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
References: <1760943954-909301-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 743aba29-4843-49b5-2e5f-08de0fa73bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TkRJuHrs5h+/RS4I8FM6PeECIGkYjBgf6dbl3RsBEiYqFGIWLhChh/qfHhjC?=
 =?us-ascii?Q?GXAe9tKkDOvs63VAKbR89KzllKmd8EFNhtAG2Mc3/8TrGmEqDUZBZWjU0JBH?=
 =?us-ascii?Q?BfcXIXOmwqSxW4X0eOi/NItFbq3FktLWZdeXJMbMi+4mKtF1A7kL7TbK6GLg?=
 =?us-ascii?Q?ULH4aAcdDScrXwjWoevXaxxpqHqVATIVCeCaQmfTb69HtXOXaewXkrEA/EXv?=
 =?us-ascii?Q?f3VNoHlEGmnuhWx4t0bnh/wyJg3XQorA8FMFfz3ESPku/dNaKFZG2baLasnJ?=
 =?us-ascii?Q?COxCCu6LZTLANyip6UzOqFYB1uKxYlASJrIEblHJCox2l9BNpRg/cTLGq1vi?=
 =?us-ascii?Q?UQ0SBcfiOWhZ3GwL+qhs+30ko+1e2ZCPNPVSjRnd2b5ZkzJNofRkBMgURO0r?=
 =?us-ascii?Q?OJ2WwEjDqgJyxHd8AmqKc1Y1dgJw/0ofTHl4NDr7d27qIMfULm/pRfCIihFS?=
 =?us-ascii?Q?BF1ysQ2xGBupCIWQRcMraXgev64eo7mO1O0WnliMsy3s/PiWNpV74m3Sj1GI?=
 =?us-ascii?Q?BXPsqsX0lJRdDXeqYrF5F0Mk+I2LnAudy5Iz//hFBvstH/QFYn75s9HnogBC?=
 =?us-ascii?Q?vRmJqv3NSEffI6Hy6SX+y90+TZjEdU/VILO90aCn3jlXKCgfNUgoqaCgHpEt?=
 =?us-ascii?Q?BXTXpPEMcyxK60Y2V4r89DXWVIKQT+bJ7HRO8fo7kAwgbIUoLIMLTzgHnXSP?=
 =?us-ascii?Q?Pr3EqRD5sUrSbngBeeNGggc7SFapm6yppujusj0/9zXvTgmZsGLKcspX4YXC?=
 =?us-ascii?Q?nqxSj1proIIuHKkqh4KsNHWiO+gzBGOLUnRCnQpmipTMVx30AWB5ad78qzhR?=
 =?us-ascii?Q?3BhA10or4fn9/rD5H12JJLnFem55qstuFsdFPTdamixNoFFKbiTfxSVI/FL7?=
 =?us-ascii?Q?uEWuGZxedYnOr4CWkP5jNeT0R4+fZOVKExFwAe0aew4lMHuAUqsGgwmYWYWy?=
 =?us-ascii?Q?7nIMrurTsSgtuV/g80wT0IjGGIDFlqnk15cr0SMs5bhNjF5sECk7OCwfHhXn?=
 =?us-ascii?Q?TnvHhzZZd88Fb/Fe3EFDnlZYjVsnxinv9wqRYZ51JDLR0XFqGJ7bvi+ElBu9?=
 =?us-ascii?Q?4ACAxqOR8XVlGaro4a9QhCRzk61c2Nv5lhKJJbkXs3FGL9QMUrRY1CIJZ5us?=
 =?us-ascii?Q?xOGlzwUAu3AZA+Upc70toktGyHfVWzeY4wa+ueR6uMZG9YMxb/atT1eM7IFo?=
 =?us-ascii?Q?NVsKaR0DyGSoXGgI/6gYqshSz9uohXzWNyKg9UFsrh3P3S3U1qgj6Wp/Bg0S?=
 =?us-ascii?Q?+NOTwx9K99tN17iWFuuUUGdWgAv3/yHb4bjKAqNRHjWzsIuxE25uI2SVfLC4?=
 =?us-ascii?Q?E9TdjKqeBYNEaUAuF5cKuhMgUucM+Z+5zfuABCuGpP+2Qd6G3TrY/RaY4yw8?=
 =?us-ascii?Q?7maMR9sPP9fQJl9PIaqK1kcWM9xIa/RFIkdfHjgRjLsPT+4GKhYkLEi06WUE?=
 =?us-ascii?Q?r95SimHuh6Hu+CbYSaHh/5b2APgfLOkzblh/topUlbeQRn6HpEnNqdAaG87T?=
 =?us-ascii?Q?/dnITsHRpGxlfwicyXgnme51pE9jUY1FpJozzmXITjmSohAzq3B8zMdD8e2u?=
 =?us-ascii?Q?1W3GOIwxbWL6z4Cb2Ps=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:06:46.7101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743aba29-4843-49b5-2e5f-08de0fa73bb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

From: Shahar Shitrit <shshitrit@nvidia.com>

Update tls_offload_rx_resync_async_request_start() and
tls_offload_rx_resync_async_request_end() to get a struct
tls_offload_resync_async parameter directly, rather than
extracting it from struct sock.

This change aligns the function signatures with the upcoming
tls_offload_rx_resync_async_request_cancel() helper, which
will be introduced in a subsequent patch.

Fixes: 0419d8c9d8f8 ("net/mlx5e: kTLS, Add kTLS RX resync support")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  9 ++++++--
 include/net/tls.h                             | 21 +++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index d7a11ff9bbdb..5fbc92269585 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -425,12 +425,14 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 {
 	struct mlx5e_ktls_rx_resync_buf *buf = wi->tls_get_params.buf;
 	struct mlx5e_ktls_offload_context_rx *priv_rx;
+	struct tls_offload_context_rx *rx_ctx;
 	u8 tracker_state, auth_state, *ctx;
 	struct device *dev;
 	u32 hw_seq;
 
 	priv_rx = buf->priv_rx;
 	dev = mlx5_core_dma_dev(sq->channel->mdev);
+	rx_ctx = tls_offload_ctx_rx(tls_get_ctx(priv_rx->sk));
 	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags)))
 		goto out;
 
@@ -447,7 +449,8 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 	}
 
 	hw_seq = MLX5_GET(tls_progress_params, ctx, hw_resync_tcp_sn);
-	tls_offload_rx_resync_async_request_end(priv_rx->sk, cpu_to_be32(hw_seq));
+	tls_offload_rx_resync_async_request_end(rx_ctx->resync_async,
+						cpu_to_be32(hw_seq));
 	priv_rx->rq_stats->tls_resync_req_end++;
 out:
 	mlx5e_ktls_priv_rx_put(priv_rx);
@@ -482,6 +485,7 @@ static bool resync_queue_get_psv(struct sock *sk)
 static void resync_update_sn(struct mlx5e_rq *rq, struct sk_buff *skb)
 {
 	struct ethhdr *eth = (struct ethhdr *)(skb->data);
+	struct tls_offload_resync_async *resync_async;
 	struct net_device *netdev = rq->netdev;
 	struct net *net = dev_net(netdev);
 	struct sock *sk = NULL;
@@ -527,7 +531,8 @@ static void resync_update_sn(struct mlx5e_rq *rq, struct sk_buff *skb)
 
 	seq = th->seq;
 	datalen = skb->len - depth;
-	tls_offload_rx_resync_async_request_start(sk, seq, datalen);
+	resync_async = tls_offload_ctx_rx(tls_get_ctx(sk))->resync_async;
+	tls_offload_rx_resync_async_request_start(resync_async, seq, datalen);
 	rq->stats->tls_resync_req_start++;
 
 unref:
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..b90f3b675c3c 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -451,25 +451,20 @@ static inline void tls_offload_rx_resync_request(struct sock *sk, __be32 seq)
 
 /* Log all TLS record header TCP sequences in [seq, seq+len] */
 static inline void
-tls_offload_rx_resync_async_request_start(struct sock *sk, __be32 seq, u16 len)
+tls_offload_rx_resync_async_request_start(struct tls_offload_resync_async *resync_async,
+					  __be32 seq, u16 len)
 {
-	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_offload_context_rx *rx_ctx = tls_offload_ctx_rx(tls_ctx);
-
-	atomic64_set(&rx_ctx->resync_async->req, ((u64)ntohl(seq) << 32) |
+	atomic64_set(&resync_async->req, ((u64)ntohl(seq) << 32) |
 		     ((u64)len << 16) | RESYNC_REQ | RESYNC_REQ_ASYNC);
-	rx_ctx->resync_async->loglen = 0;
-	rx_ctx->resync_async->rcd_delta = 0;
+	resync_async->loglen = 0;
+	resync_async->rcd_delta = 0;
 }
 
 static inline void
-tls_offload_rx_resync_async_request_end(struct sock *sk, __be32 seq)
+tls_offload_rx_resync_async_request_end(struct tls_offload_resync_async *resync_async,
+					__be32 seq)
 {
-	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_offload_context_rx *rx_ctx = tls_offload_ctx_rx(tls_ctx);
-
-	atomic64_set(&rx_ctx->resync_async->req,
-		     ((u64)ntohl(seq) << 32) | RESYNC_REQ);
+	atomic64_set(&resync_async->req, ((u64)ntohl(seq) << 32) | RESYNC_REQ);
 }
 
 static inline void
-- 
2.31.1


