Return-Path: <linux-rdma+bounces-14056-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD25C0B1AE
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 21:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C91F4E9333
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34B2FF65A;
	Sun, 26 Oct 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lj/UuXJ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6867C2FF656;
	Sun, 26 Oct 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761509049; cv=fail; b=i3VtiinM9ENo/u2jC7ZLahoN1ETHgItNedlhBW0mDemldGC2SZATudpa/J8Uigc64TUPDqcwPebJZpHXSLU4dV3RBAxGNXG2hj6+5GqyZOaMkqZWuOmHEE2LKLf/bveIR13qzISyawHuTXgTb631s3JfxXuwSryqMH5sTFVg1O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761509049; c=relaxed/simple;
	bh=xURtjsrn7Y0p50rLD5Ga2Ou1SjytBARhXBlEueISxvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaiPIW4rfJDY8W3n9l8dTZe5eS4hf6xWMbmGzYLmlJ7N1NQxeRXyQisCHq8+fIvqipVwaNAClUKsqhVkU9poVLN7l+0P8UyNo81neeyzKZhcnj5Zj8cyZS2XowF4aai9ICdV38r5ktWYu9+CVV/GqJXZfVR346lo+mMvz/Gz4mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lj/UuXJ5; arc=fail smtp.client-ip=52.101.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4HuAgITLGPWc5EubWW3E4/BBW8EW+3dIj3Sw4G2VTcrRNatsLH5ARrRoK+7mp8CNeC3d/74xxMg3lnpa+Z10eEnhW7Q1kdm4gPdpCeaFJqQ3VsvXXBgqodYJdSohBFdB4ZS/EKP7VQ9jbWC7sMWhsJ6DKoxkwwaUEHe1rZH2QLmOMVb+glcFpnS2U1P/XW0Zq/FIbu3EDRBO0lVFCZ3dbI/RQV4viUGqvA1kxjoFzbTxOhtTRw/yB/9c3/DNGIcz3KCNNF3pFxnq6Db70K7sl7Va+/Vgh4sI5v58P/sUrDtME0ehlzGg0E3j2KmstP/RaVtxQ6zQp6ULhVt5ufkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXydeuNRtO4JClnHUQXd9Uh5NpOb8Qbi+IE+yEOi1wg=;
 b=tCAJzuJ6MO+KrAul0JHjG9bpbk7pPc1ZOzv9Ed0z19jpDCJAwVDHymghRG4xstNhVLY+2YWv5qW/ctwDsYlOYgUNxE3ZB/Ze3k3JZ0SvBDClc8HiF4XMY4uTgTeCSVwN6YBk4Xwq5yafEDjkXBFQwV6tsOFqRn4WRlOkFOq+mVoB/SvzLg0mR8oAefmRhbIT8dm0PDfLFHiVmPkzqMhr9qmgERSn1WvHfa9kj6yzAJ4YdXzB6m7Sk3jGgUg7EJyeBov7cvfJacF+AbTc1p09vS/GP5EyKgP91uI6VfA/bDPTOeAUQp51k3i3Fqrae7lwzYe22VrWXAe67BwW2hy3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXydeuNRtO4JClnHUQXd9Uh5NpOb8Qbi+IE+yEOi1wg=;
 b=lj/UuXJ5sLSG6p4ODRFUSiybAOhp7oH2LBgyr0ZA7v+zA3pbjcRaXm+UEqgs6WXNDSd8jq741M4b/mO7sRrJxBssXBVwF9ulgfVTFwnF3KU2pc5M2JsIJkz2GeeJRmAqM+V/dYntfe+YTo/edJtSgGOwg40QRUrbp2TLjGR1hkJbDT/Bw3fujQCRB+vLBO5H13jrHjocnuOQMVenc4KSJbQIvXZOCL8QSgNHX9zzElbVOdNgwk1OjkdPgkFNrf8jA1wY1GYUPe36mzHWc+01PkOXemshxzqiqvY7gFa7GzRDnb04BSIbbsJPCkrg0zyXgqkvmYPFla9jHlRjjU4DqA==
Received: from SA1P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::30)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Sun, 26 Oct
 2025 20:04:01 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::1c) by SA1P222CA0028.outlook.office365.com
 (2603:10b6:806:22c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Sun,
 26 Oct 2025 20:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sun, 26 Oct 2025 20:04:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 13:03:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 13:03:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Oct 2025 13:03:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net V3 3/3] net/mlx5e: kTLS, Cancel RX async resync request in error flows
Date: Sun, 26 Oct 2025 22:03:03 +0200
Message-ID: <1761508983-937977-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS4PR12MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec8724f-1a2e-431c-d666-08de14cace8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pTdVR9Dmcf3FalEakUTmuHVVt7fN14dlVkxcNyA0Z1CL85eBJywgr1vpHqo+?=
 =?us-ascii?Q?tNaa4cU+6Ks0Sle/Akzxfgakl7faGJSdFMxm3M92VBw7JBOxGlNHTH+gT3rH?=
 =?us-ascii?Q?GmIYu9JFAxdT0ic00FG/LorOcBMOLUmrqv1LI59g42/zd9BugvFYNelxAo6K?=
 =?us-ascii?Q?HOdcf+HWiyQMRXUJN9k4uVrLxRub/0f62N7Yacn1FOJ6FfMyiGLZXaxRokSx?=
 =?us-ascii?Q?kRf3BK88OmdDDAm7GAf6fMoIRU5HFRBbddTu7uedafAITv7PZ86JcHaxQHfJ?=
 =?us-ascii?Q?wAe5tJS2MNby90whGn7dDoai44Jkaufw+K+FubNdYnUcrF2TyJZHAuuvS7HC?=
 =?us-ascii?Q?xLXDwOVL7ntvGWuffy+22ZkvEDet1468rpKxY/j4/9ARhV4uMkFSJZnsfsE/?=
 =?us-ascii?Q?lmVci/lpSFbuCKV1rWfP8tGoJo/KFwFF/WDi3pxS8gpFly6NddRh4W8nV22y?=
 =?us-ascii?Q?lBrTpSS/kTXLnYrgLWntUiWxcNc2jNZJr9oyrzC9RHpd5EFmaDGXiJ2rBfBd?=
 =?us-ascii?Q?h6nwb0/m6gBn6owGUZ4eG69BRgBJ8lLWTQKUstudIEFiJL9BwfX0xUMI9DdG?=
 =?us-ascii?Q?F6Pk4LYt2kieeEVVlEJ8qZjAXNU4JxIpSXGg854wbVfl3zwMOAFlmb2gFQiH?=
 =?us-ascii?Q?HYc2lcPgD59TTMFivWkcUu0I9kvHbwKSH6IKf6HKOWPcuVTrLB7VNRb0xLwx?=
 =?us-ascii?Q?G1YN/mfIyt4LNzk29M69yKLputzb2fFxiebIpgo499X9u0IhzvvqePoVPTLI?=
 =?us-ascii?Q?dnR+IOmhwYlcItW4NXm/UJtVFaRjSzuL3wg3cVZTa1MPelQGjrnK2Bi0qVtn?=
 =?us-ascii?Q?lJ0vP624Z8ikbosOXwr/tR41sBJcFTfoZK0vT6oCgdcvVvJwf4xso3g5Zn8S?=
 =?us-ascii?Q?sPNrwKONsg8PevT3I7+kqvpLa8Qw+gyuCyogfs/IZukYWKENxIa6mundcwXL?=
 =?us-ascii?Q?Gi6gGfFLbiIYBxR3m1hu/xubg81PJTsegDFaDOSDelG9M4qjMu+0QYW5jd0H?=
 =?us-ascii?Q?9RuJF/u3Cu4EPGl1azNvx+9Xsed5e801wcqUcvvvX5HaAB6ItUrwOxeLCLwp?=
 =?us-ascii?Q?mQHz+Gf0EH//5own0hLNf3k0ylgHERyLRa8HUQTj+bzIRHRwGXWhl/hGXllX?=
 =?us-ascii?Q?iEkluAGlGCAJqZBARHieVenUDt+bzqnXMqloHq1WwwEsKkOSPyr9PSh7f8ob?=
 =?us-ascii?Q?s7U63vHfWaV0cHn2dUXmrt8Ufld0bDBBxMHojghRRA//udKq1D33CF399hoM?=
 =?us-ascii?Q?fS7FAKwPKQ0XYRJg/EFherRMeO9nwp3pC1fUnEXhCcLo03hJWzheW3FrKMgu?=
 =?us-ascii?Q?AHMacPacTRylkpqRQd7oeY1sD3Bo25fVJ0vevKz+h8anTqc6xYM1N+UCZ0Cz?=
 =?us-ascii?Q?8ChaiWXVs2xjqy+R/r4fq7MH2IhwoR5UWPtvmO0mqFi/PPWrLDE6NTgYFlGg?=
 =?us-ascii?Q?utvmB8Zbggcte2J3yc+J7lFSNX7HlvTDNFk2s5kAn4nWcTkKXaA1ubR8EzvN?=
 =?us-ascii?Q?NThsOtGQWrvLPWdOAn7lMMlS/UrM/5wgjZ/A8fKBcJ8/Uzz60a/hQjRaJU5r?=
 =?us-ascii?Q?q83/AxfBqGwcszPXMTI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 20:04:01.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec8724f-1a2e-431c-d666-08de14cace8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820

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
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 34 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  4 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  4 +++
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 5fbc92269585..da2d1eb52c13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -320,7 +320,6 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 err_free:
 	kfree(buf);
 err_out:
-	priv_rx->rq_stats->tls_resync_req_skip++;
 	return err;
 }
 
@@ -339,14 +338,19 @@ static void resync_handle_work(struct work_struct *work)
 
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
@@ -425,6 +429,7 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
 {
 	struct mlx5e_ktls_rx_resync_buf *buf = wi->tls_get_params.buf;
 	struct mlx5e_ktls_offload_context_rx *priv_rx;
+	struct tls_offload_resync_async *async_resync;
 	struct tls_offload_context_rx *rx_ctx;
 	u8 tracker_state, auth_state, *ctx;
 	struct device *dev;
@@ -433,8 +438,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
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
@@ -445,11 +454,12 @@ void mlx5e_ktls_handle_get_psv_completion(struct mlx5e_icosq_wqe_info *wi,
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
@@ -475,8 +485,10 @@ static bool resync_queue_get_psv(struct sock *sk)
 
 	resync = &priv_rx->resync;
 	mlx5e_ktls_priv_rx_get(priv_rx);
-	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work)))
+	if (unlikely(!queue_work(resync->priv->tls->rx_wq, &resync->work))) {
 		mlx5e_ktls_priv_rx_put(priv_rx);
+		return false;
+	}
 
 	return true;
 }
@@ -561,6 +573,18 @@ void mlx5e_ktls_rx_resync(struct net_device *netdev, struct sock *sk,
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
index 1c79adc51a04..26621a2972ec 100644
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


