Return-Path: <linux-rdma+bounces-14054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86378C0B19C
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 21:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE881898AC2
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F32FE07D;
	Sun, 26 Oct 2025 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVxkZpVl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9182D0626;
	Sun, 26 Oct 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509038; cv=fail; b=fNoKvsjGXQz2ICVDoC4lILgmnv2I3CR2SKuc9LLtpDuyumO4N2T0MozCQl/TsKUL/PVVOKwqHSgslVU8X/TAu1vm91nl73vtrOFRzdLA2PZh2PjljoOusLM2O0oa63wti0ebYy6owGd1hpRhVFLJ4qXhYxmIPqIovgPb13Ilb9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509038; c=relaxed/simple;
	bh=bgyhDeCm0IZCNaEahCwsNr5cK/nu4hu6C5E8SdNvhBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haFy5ozEQwxWjRPdWZzijFzV9TjFaJffPkSD/Y9z/8kLW+lAm4O+FNRX2Rraw6GNqTRMNPdsJrHtlfIJt/djq9Q8x2W/MAZGKCl3g2g2gcSJAi/pWXmgB4jIdSj/dfVJP8OwCl6Jhe9me/BAzFqE6bMhDToTZ1RuLiXWhx2pNPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVxkZpVl; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtuUvJUsPP3OkxQ6wtDUUrsvGmW1IUJZHNnuQwa5I6tBRL5QG+MdyMPHL1s4GSo9/70h+P0r3MZl5pO5oC2N2FW5UEGnCjQnzTfA6Vr8FWuRX/EtHcHaQMJeetnTu+MJ19X+LrSNVh6fJghqsJNDgEo8OCyIcthXhjEvPnewvyIweLL6uaTrW1+TgG/OLXF5iA/XZd8i4br/+eTlb5rkzJgXyv5CB0/DJKt8Q2OPlTLuGslmiUiYDL1wK2uKUHg5kVIkgUaqf9iYGYRI+9eJi3EDb+59mse4nnCNhvrhH3eMckpz6wP3EqijQaslApY4ZUzwLJW5arNjvs2cRq7CDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0GLR7Ff0VvFBfBbYIKxCBiWfHR9d8BE8RkAY+3yLxc=;
 b=b32bZ6NCSX3GDpOv9O0j4YOjNVLyDjXHbVxGorhpOCqkclXeCGq5S1vE3QpAUQ8f8GKTEWNXRq3a8J2w/7sEE9iP/0i7DuP888+QuOGypvcMmJhHi30uHOl3o17Ur6uLx7/SIH6C5zmSYtYGgeSEOfxWTNFDWJi2b00DF6Y9GnFhaW3KuSi/3WDV4ELIw/4jSfofruG14ZRFExIYUXXO+DfGPptglwgKAYzRRuaZNqc4FVC7OQMljGGp28CCU7C3Oot8Gbt3fpp/rJro2nmAHSPX/rtmGwZH4jp3LX/vS4TJcvzjMCVPUQ44O0iNN0PsPqg1xwWXq4opUOMN1TO8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0GLR7Ff0VvFBfBbYIKxCBiWfHR9d8BE8RkAY+3yLxc=;
 b=XVxkZpVl9lAFbSykP8vzdqtditztEEVIYSC+xK9JpLjOr8tY2PyLS+UZ/dYdwMfu9MF39XYfTdqT3Q5qROhWdx7QKCbYVrJqttjMUWUJj41GouQsL3qrKHiSs/bXYuIm+ZkJ9zR69PHRiKnXrAwlOq+2MpKIik1MrhzTV8607thBOF3yA8DhykyzXliZviLc/X/F03sEKvNI9En15MNuOaViSlWwrG7hOq+Gwomyy516AbsO4csPAFhJJtXVsE0qjVGeIWdjd8Ll0DfNyKTCydBvTZgEbxV0KRLOwOuXgzWebklHjC5mIIPawcA5vflkJtRuPReYMOy33Px4iMdFvQ==
Received: from SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::15)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Sun, 26 Oct
 2025 20:03:51 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::ff) by SA9P221CA0010.outlook.office365.com
 (2603:10b6:806:25::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Sun,
 26 Oct 2025 20:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sun, 26 Oct 2025 20:03:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 13:03:43 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 13:03:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Oct 2025 13:03:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net V3 1/3] net: tls: Change async resync helpers argument
Date: Sun, 26 Oct 2025 22:03:01 +0200
Message-ID: <1761508983-937977-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
References: <1761508983-937977-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7041a2-c72a-44e3-b563-08de14cac8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5BrTpj+qkV2xkhCskZnHcVVJH2NKlXsKG5lTCGM1dTtBtQZgZGWxaaDWhFle?=
 =?us-ascii?Q?2SCYrJ9h2HW8vS5+cWoSHuSA7+wS8333aBP+AwwcfaGHN0BXgpbYUx1BDkAF?=
 =?us-ascii?Q?I0FnWYRGqWefEesqL0LgZX3wykWg8wc2PGptVUmlSt1umGH6+yHced1EH5gN?=
 =?us-ascii?Q?6yPIFzDWZJ5bRXc92VyZh+a3vBX3/2z50+3JVRYi7M4h3OXi3ARGxDq4pI8e?=
 =?us-ascii?Q?XjKb6UzFy135pODFArElsVS1C4LrLTaeoNHrUESN4PR32gy3Pv3bIprvd8f3?=
 =?us-ascii?Q?xtD3N9w+TIxU70QXODXZwuXkBmOoWNO1XNH8EhKH9BTZ/9lAxRknUihF6vUj?=
 =?us-ascii?Q?liNKR9N2HMqZLTdzSr78+kY1oNuXPEE2Q3KUTWc3L92N+DRS0DlC9NzD03Vd?=
 =?us-ascii?Q?6zJjh/Re/vT5tVAR6muQo8gxaLYUa0LWGXnEmXKIg2gaAForJL2QH06ey5f2?=
 =?us-ascii?Q?UIhNWyjiSjox2YHQ7AWXAnC9dPK+6F8wCcRo7U4qivKuSRdA6lmveSzHxFxN?=
 =?us-ascii?Q?0N2UTE3EBTdIbh1s8nBa9IFMNM4mzkw1i1mDKLrYtjTd3aIDJexrqC0unF1J?=
 =?us-ascii?Q?DD6mq5j+cJtAYERgQA7MkRLTMLXXSxdbmmfhmNWv+v+LQFNQldw8kdHKUF4d?=
 =?us-ascii?Q?hY6Y3D6njQ0CWrFUEddK2qFlEjrqin4QbpdG7WMPD2riluUa185qFrNTDNrY?=
 =?us-ascii?Q?wb8i5k3cSd2puMsSvo/u0zhxrWQ3bn2PhxA0elXWH9vS4BnfyYhZwczmK2eh?=
 =?us-ascii?Q?nfm2sCLBe/I+/bqRZlvbglWMYENw0Lgzj5d0aER/tOwIZFRcEpcKBqm9QfP6?=
 =?us-ascii?Q?ZQ0ZGyl+kwTdczVa9NL7O1R3PuZFTdLMv/F9L7J9xUzZzlpRsQUcyw1SLLgO?=
 =?us-ascii?Q?sibfJ7BWD+rXNUsFCGOi9p2lz+7u1kfl9g0ov/T1AJEECguJn9BdyEz1WK4T?=
 =?us-ascii?Q?qx/ruwxDGbM9G2CZTORBM/Qh1+jbX3NZlg8Z+W4CMy/KvUo5UzGE6ICgqrcE?=
 =?us-ascii?Q?z6sIPgVFrB0n4X3ZH7KHn+9tdUPzmttn5V4Ez1oY55+TXY3vlYNSbRE3hda6?=
 =?us-ascii?Q?3np31F55ZAtGNz10HlsKJq3yFo8w9CyV978Z7MB1Niw0a4tnTHbF9Dg/zH/g?=
 =?us-ascii?Q?K4ePCalGgrAsbJHAwtPmwK4wcp5XPTZYKNZ3HvViOagMjN9tofm2ZRL2iQqK?=
 =?us-ascii?Q?yXaarzLhLMYS+tRs/ZohyCDiThdq1bZkj1lbD3hrar6TEv80qZhECsF2ONck?=
 =?us-ascii?Q?JWw3K2V5hnnYA3RJW6zlFuuIhpymiXrriGYmXDSZMOO6yMOIOwtfX8lvEQHy?=
 =?us-ascii?Q?JE8G+lKZBH1UfqZyVzi0KwxCRq/unnFwceWNTJ74cdBuGXIqtNU5xxqk/kal?=
 =?us-ascii?Q?P19Asv/ZuUU4otGAG96eVXGGJmfBQh6EzlrXrw6zUno4S0hP04cYVPbYgpsn?=
 =?us-ascii?Q?jFGa/7+h7oAMhtGBkDzJnBggPDOyIajzR9gpsfoxKSI5/rznTezgXGB9+kCy?=
 =?us-ascii?Q?ApMvp/UquRr3t8i4u7ZdRJIbCKD2jIGQBQmSCb1622bZqA6VVe5Dh1j9eH7/?=
 =?us-ascii?Q?DGqNAyjEzUJC5QqMVDE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 20:03:51.4547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7041a2-c72a-44e3-b563-08de14cac8a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3

From: Shahar Shitrit <shshitrit@nvidia.com>

Update tls_offload_rx_resync_async_request_start() and
tls_offload_rx_resync_async_request_end() to get a struct
tls_offload_resync_async parameter directly, rather than
extracting it from struct sock.

This change aligns the function signatures with the upcoming
tls_offload_rx_resync_async_request_cancel() helper, which
will be introduced in a subsequent patch.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
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


