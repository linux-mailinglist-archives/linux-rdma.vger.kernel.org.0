Return-Path: <linux-rdma+bounces-13947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6DBEF967
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 09:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061F43E1036
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6632DC35F;
	Mon, 20 Oct 2025 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBuRFVNp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923B2D94A6;
	Mon, 20 Oct 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760944028; cv=fail; b=cw3X+11ik+VkzbtSxvoIZEJ+YQY2+U3hfCKcewuBm58gunZ/ivOSiVX7XSa7LoSS1lpngmEQYKVXb9LKwt7727O2JCJ8s9reyhcKAp9Wo5ZdEzO9GvODMTK4KfTxofJhECDFgAmGEnpIk5/NBd1mgQ2ijDqXmK/sLJIljqCk2CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760944028; c=relaxed/simple;
	bh=Hbo/ycf9KJ517XxSMF+VMKY0vnTCce1ejzFfDkDoeJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U21+Q/qeXLoVlR1c6SSgNAi35pNEIMNzIMkUfK1rPr93dRPO5OosJ+jBaBUFe+vhzzSWdxSqnDUNSAIHshOF2xx2Xqg7vycyANylEaemD4Hbo52PjunSRSyPLH328Q+7dt8TZ2L5WSBDWhwTPiYb0+RRL8YEL+1m0BIyqUSmcKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBuRFVNp; arc=fail smtp.client-ip=52.101.52.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3HPnc0OYkUtnXJWxole8gQlK6w4eKxndYfYJWviQ/3vsZ5G9lXEI/Vret1DtyUBG5AYac6YsQahdOTBVFNsMu3jSiBlZyjn6jVA+kA0ZuNdd57nHaZgJFkDEcEoqUvr/JVNLTMNsMEuYqQ41lzBLjA8sLaEsTIbEVUuNm9IrySy1QfY6i+rgeavdT7la1E5dGcgXKPBn/dv+wmnoS2dRT6EoxuEl2gg1qfbM9fIl9ZgQJ382y6d7xSn+B/xNIniDCTb6ZePJpwEEIY4eL6lEtBp9ztN2JGk87fthB9lpE9Fbugj3JOKrjCne1wb3MEmHpiP8pGXHsIRKPwa1IjMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7SfOgdydjxsO8gT09nsoHE1S/SEjCbSgzNnfDtlwK0=;
 b=S66hi48M1BthFr4LFJD7EV690qJcBdePhEpmp5iusX7p+m+vg4WmonMsdPcq4Vn/FadmRPqfKBuy9nbI4UZxGRWvzGtG0eo+klm8rdsjcZh+ODdKSQOlVbJMANp2eCisQ9vb3mLc7jQr+BpGOKwSFhOSplRQ26lYqd5pU/Bp/f9ePrZ3M5BOj6hDlR8WvV/tPFBfXKAeUH/foSfOBZp46uTKEWZhNJ9Gase6BtXwE2cV+9K2bsDdEQ327sXaNhBUgEneTXlk+JWeJULy3s4s/NalacJU2b4SOGpFrffn+HiwNvr/6ntct+mm9KoFb/YR1+BytbE//XU9MgQZ8RgQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7SfOgdydjxsO8gT09nsoHE1S/SEjCbSgzNnfDtlwK0=;
 b=mBuRFVNpZn5nzdhj+4homcfX5h4EjcT5k53W3oWCkjbwYxmNn4JKw3O3DqAHZ24vR1QoDNZ+oH6Tl1kweL2dwzt6lcwnyK9qcTL7Yf2vScdwpgrCfHkJ2fZ2RAYHWbaHZw/gWwbK3iITW2SqQX3CQBW8G/CRry+7aWEAQTZ7SKFQZo+a2Dx354VQdXQZ+Usp4faFMfyJYAzPbOrsPFftZMcZ3LeSpTb7U/cWMiOtOPi4iJSLzRv1FXr7OC2qmJ6ivq/A2G5D+dPEJOU7lRI2AHVRRkP1MXCDT0kq64gnlD2fYpfKtKhDFcAMOq6ZPzw4cIP5QBZT7yygoNilIiDKdA==
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 07:06:58 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::55) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.14 via Frontend Transport; Mon,
 20 Oct 2025 07:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 07:06:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 20 Oct
 2025 00:06:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 20 Oct 2025 00:06:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Oct 2025 00:06:41 -0700
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
Subject: [PATCH net V2 3/3] net/mlx5e: kTLS, Cancel RX async resync request in error flows
Date: Mon, 20 Oct 2025 10:05:54 +0300
Message-ID: <1760943954-909301-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: cb48c12c-0c43-4905-636c-08de0fa74261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BoLrrhRXHjIwvWjCnSDAsYGdRyRYBoFV5A42gIz2sycdXJzi/MlhVyrCs6qm?=
 =?us-ascii?Q?cvjgeyQA6c7Zo7wtbEsmbVZzm3Dd31m6GK1rTFXpHUYPNmeBkSyln+wIBX8V?=
 =?us-ascii?Q?3BvUg9OJnripN8S9RYwroIOKy7pApZWihI8Og7GA0eeftBgajYCimqrBB/X3?=
 =?us-ascii?Q?EoVzbLSKQkZfUtWuW7qI+NRpM3sGB0PdSAfo4upHEz4+C61X5+nTvI18NK/5?=
 =?us-ascii?Q?lqe24GJpcHhnSYHemTM2xLc/VRBr3dnW01cRD1YjEuxdY3rkZaPX6bwfNdoj?=
 =?us-ascii?Q?zdtuDd7HZepqfaj8eRrbg1Dt2XnJlTMK1mjuozWlrKXHHOfxzacKx+r7OnDl?=
 =?us-ascii?Q?Vuv/2tI0ip1ivq8rs41ODNMsJOPe/0naybgsMmqgMcnlBqt0qAvmZAmRKz71?=
 =?us-ascii?Q?UcKIz49bxknAfdmzg5tXmRjCBh8qiXZCQoMnvuR2Uc/QdB209jGdap94UsfS?=
 =?us-ascii?Q?47tMiVofT9DP4DV484QZu93XiHO8+UqleRfxvx01qTjVJVvTINqbOt5P6Mdb?=
 =?us-ascii?Q?50UFrvldNbSjgQsWfBLohEzTqDrKd9LskOfo14fS29oMHt/6MG947fU4L0I7?=
 =?us-ascii?Q?8GEgtE7dGTg/1fZxbQBf/OMjt3APAj8efOOI/njNBVcUrLH0u2VRl8y6abMa?=
 =?us-ascii?Q?NlCvAWiZFBq7kPWiZ1Pw7WDlz6rkE2ty/WeEXZ1qRTJjhYUkuwcF01EeWhsR?=
 =?us-ascii?Q?L+0vKnBM0ORI3vQRW2ys65nefeWRALoeM4yO/CxSdYnQjgtuQXw35OrAiJmU?=
 =?us-ascii?Q?9lQq3HvJZdNLKDO5cIIZ8hy5u9ekqRE+4SW0I4QPOe6Il2RlZRL/mGYoH+rr?=
 =?us-ascii?Q?YAec5bpBjOoXtsay/L6Y4IWmBn1aUnK20bvq3MfLjEr1ely4tenXP6U6r4Dn?=
 =?us-ascii?Q?sTJPOEnGbVxjmJ3VQjCkvunrF0kq7Uqlowp7g1mbZwcLHycor7/I9GXNnDo+?=
 =?us-ascii?Q?l9hnNJBhF1Af+5RXiWMRXQnT27ZhSdQCkJakiTNqD+sC7XTA9gZ8DYhUeURm?=
 =?us-ascii?Q?LcdM/ar/ukAI94AZThM9k44g4UbA1d8BlTw7al8PgyZgesZ/PLnx/VpTOQuM?=
 =?us-ascii?Q?1YIq+C2zol7jZyd36gcSvYEBDMrBbrIxqpqxpgohU1c1uYkMxTAM+1dweHPz?=
 =?us-ascii?Q?QUpiJuQtXW9dXbh6Dve5i7c6eLzIdPYXsrK1bLWR0DzNYYEe7ehVH+eWNV4V?=
 =?us-ascii?Q?8sGKnJJSw0TSjklOaWG3N5ms9VXXoFbDC8xQkTMKx4UPidKPgWKsuWlHBaOq?=
 =?us-ascii?Q?SRLHjzG2wgz8pRIBvljPKaclDAhAAhsI8LX4MR7NJJilv7Tn+wO8Unxp67/l?=
 =?us-ascii?Q?Lke/ZDE1vLrrpN7HgfVBVqI0YaCV74n49Ww3DpJn8syb40IkcRnTYyXhh8ea?=
 =?us-ascii?Q?Olk695lLQytk9sEXXpKwc8WJQ1Wncw1kHEFt2gXtZiVxIEFL9Ud3mUHi48Mj?=
 =?us-ascii?Q?hnWBDvlIJRiPUSYv7IINv8+iRdoKrrxdDMr7bYHRwMM7KsWkTyphIpZK7atd?=
 =?us-ascii?Q?dQONPbiVNQCJ96iqihlEOMIf3kZ8Xd0Chd7wWWbYDCLbhBp2R5j1kMbovBSC?=
 =?us-ascii?Q?suRCFwTdV84L7v90lP4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:06:57.8952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb48c12c-0c43-4905-636c-08de0fa74261
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

From: Shahar Shitrit <shshitrit@nvidia.com>

When device loses track of TLS records, it attempts to resync by
monitoring records and requests an asynchronous resynchronization
from software for this TLS connection.

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

Fixes: 0419d8c9d8f8 ("net/mlx5e: kTLS, Add kTLS RX resync support")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 33 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 5fbc92269585..ae325c471e7f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -339,14 +339,19 @@ static void resync_handle_work(struct work_struct *work)
 
 	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags))) {
 		mlx5e_ktls_priv_rx_put(priv_rx);
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(&resync->core);
 		return;
 	}
 
 	c = resync->priv->channels.c[priv_rx->rxq];
 	sq = &c->async_icosq;
 
-	if (resync_post_get_progress_params(sq, priv_rx))
+	if (resync_post_get_progress_params(sq, priv_rx)) {
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(&resync->core);
 		mlx5e_ktls_priv_rx_put(priv_rx);
+	}
 }
 
 static void resync_init(struct mlx5e_ktls_rx_resync_ctx *resync,
@@ -425,6 +430,7 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 {
 	struct mlx5e_ktls_rx_resync_buf *buf = wi->tls_get_params.buf;
 	struct mlx5e_ktls_offload_context_rx *priv_rx;
+	struct tls_offload_resync_async *async_resync;
 	struct tls_offload_context_rx *rx_ctx;
 	u8 tracker_state, auth_state, *ctx;
 	struct device *dev;
@@ -433,8 +439,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 	priv_rx = buf->priv_rx;
 	dev = mlx5_core_dma_dev(sq->channel->mdev);
 	rx_ctx = tls_offload_ctx_rx(tls_get_ctx(priv_rx->sk));
-	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags)))
+	async_resync = rx_ctx->resync_async;
+	if (unlikely(test_bit(MLX5E_PRIV_RX_FLAG_DELETING, priv_rx->flags))) {
+		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(async_resync);
 		goto out;
+	}
 
 	dma_sync_single_for_cpu(dev, buf->dma_addr, PROGRESS_PARAMS_PADDED_SIZE,
 				DMA_FROM_DEVICE);
@@ -445,11 +455,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 	if (tracker_state != MLX5E_TLS_PROGRESS_PARAMS_RECORD_TRACKER_STATE_TRACKING ||
 	    auth_state != MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD) {
 		priv_rx->rq_stats->tls_resync_req_skip++;
+		tls_offload_rx_resync_async_request_cancel(async_resync);
 		goto out;
 	}
 
 	hw_seq = MLX5_GET(tls_progress_params, ctx, hw_resync_tcp_sn);
-	tls_offload_rx_resync_async_request_end(rx_ctx->resync_async,
+	tls_offload_rx_resync_async_request_end(async_resync,
 						cpu_to_be32(hw_seq));
 	priv_rx->rq_stats->tls_resync_req_end++;
 out:
@@ -475,8 +486,10 @@ static bool resync_queue_get_psv(struct sock *sk)
 
 	resync = &priv_rx->resync;
 	mlx5e_ktls_priv_rx_get(priv_rx);
-	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work)))
+	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work))) {
 		mlx5e_ktls_priv_rx_put(priv_rx);
+		return false;
+	}
 
 	return true;
 }
@@ -561,6 +574,18 @@ void mlx5e_ktls_rx_resync(struct net_device *netdev, struct sock *sk,
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
+	tls_offload_rx_resync_async_request_cancel(&priv_rx->resync.core);
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
index 263d5628ee44..39419172a690 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1036,6 +1036,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
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


