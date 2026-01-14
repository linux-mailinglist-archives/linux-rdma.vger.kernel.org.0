Return-Path: <linux-rdma+bounces-15543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B55BAD1CF25
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2E21301A385
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF237C0FA;
	Wed, 14 Jan 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bG5TxnfK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCF36B054;
	Wed, 14 Jan 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376940; cv=fail; b=WxbVaahnVEoqrjZUS4GjLRrm4erCiXaX6W/7D+O3m9PaXsSzg/gBC7/wn2eVquyl21KBdFm4ZbHDaS0d/DjczltqofSO+rBTnQm9gw5dryY5RJKWlfY8kM45LVNFpBQ4iPSfL6KddjPPsjQCDKF7Ymd0qAXjXz5eCCTDIJdhVvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376940; c=relaxed/simple;
	bh=u9f804gplbAHsgPckScxlHgBxbQXb2Uo+gNURZaeRMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+L7o9Cf2McpzidTRd//mItFjiby8laSQRd4BKfLvcIeP3XL2N7xy52oPTFeViUp5AaYF0aGQka6DbdwhMVqx+HYNkK8KqcMsmO/c/cN7lYf1fSR9Ej+SW2F1NIpft7IFV3LTLgbMDCx4OrhnMpjDEZNICjw2gyeYZt02tLUnAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bG5TxnfK; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXBqoLgJt9MWKQGupMQkm8HauFE9Uew0dMV4vDjjr6Z4pmBJ28jsCwx25cTYLywzxUitqSXANxsJgUyGe+4gct+nUfg7UjYOO0Z4Y54D3k3Ujc0zgCmoYcvNiuPjEaA4fb/NaKBtS2JUOuIk/YzGslCJlCqt06Pr+4EzGZbvL58tD5mOvCKTakA0Il8bgqbUihJQoLe1glynjKFwmaPSP9SL6N7WKkSNt7GHCYjfQI8GuoVXDakrFFxTtaM/fEzyjgB6pcCfiWbR0uIajSm5RaOUjye27T8plV1d2qtlukSfACJYwUOvJOKdmxD0PSqWK7WrNWXq+zFWogVGjo7E9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nQeYvscCk6rzdciWCOxtLCtnhwGQo8pqcU2Ke+wobs=;
 b=r3O/RCzHTkco1z8b2peGz6T2mHD3KwwPmv4VKfyHP7fcVunyZFOcARb0pvzkWRner3cxHgG6E7UcIVeIQ44vgMfH9IGuuM0OGammvuJkd2Ka3H7B8FAMs2OUeitEeq+XXGibsMitoEroCsdkmWIQc7Y+NU25VIbn8xcaRRy8zzRWKKjA6dUgE9XDHfcnTeqwc6blh0v/6cr5BEROOs0pTrzprELP5N6O+B8yrjUEOgBuCYUtBbCJkFoge4Gr+R8gOadWIty4IeCqdRHMDXsznX2gNwM1XpBH7BYUmOM3HDnANkZJkRoQnBcz0jOVvel+uJv/cn0Gq6T/pr/swOEbFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nQeYvscCk6rzdciWCOxtLCtnhwGQo8pqcU2Ke+wobs=;
 b=bG5TxnfKSHskFKJNrM07+1uB3Mo+7AlMDIvhyXQzRBxkyGVXMCtETU/cDN9z45q98DhhYJWemXBMIPQLiD113IzsFvJcz1gw9Mgkntf98sEUNR/ZQXOl+o08jWnYxgImEgwcZwl09rsS4svrpM7Z4ob1BvepqUOoNr/O75BzZCKuT1R60kQDQFhHnNGhG6BGBeCycITfa8QynEbJ72X92dFHTvp0rH0ZKGoXLAPkBx1rjVtQ3twjj6MWVVu8ywc3gDJVU9NYrn7fVK2tKKo0esvZnjkU+4PHKERC1S4YMMYnWcFJo69DxRDR5j0jn/lbhao2bUbrhILUiibegOeWyg==
Received: from SA1P222CA0177.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::25)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 07:48:50 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::29) by SA1P222CA0177.outlook.office365.com
 (2603:10b6:806:3c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 07:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 07:48:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 23:48:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 13 Jan 2026 23:48:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 23:48:32 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 4/4] net/mlx5e: Conditionally create async ICOSQ
Date: Wed, 14 Jan 2026 09:46:40 +0200
Message-ID: <1768376800-1607672-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
References: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: ebedcd9b-6962-430f-c605-08de53415b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?779yIG/IYqCsYGbwBYc5uSxYWFsYF57WvmnYEcgLaWnwdWO4YbzsnjYUaDTw?=
 =?us-ascii?Q?K3Lu1GBLHUKlLLAADqL/Un0pfm2ck6yZ5uREvyHrCH0CftgwIMnpnaqOdMWP?=
 =?us-ascii?Q?HrN3+ULOf7E8gGYbV2GA9ICm3+tNsql7m0o6XdjY54UtruNcjZSa6K5yLJQq?=
 =?us-ascii?Q?tGaljgCHbKft4HYtZzLxAty8I0/uVve2KNO9UGu+KSY/KvweM3JQex9+W1ru?=
 =?us-ascii?Q?N9Nxh7bl+Q0sdXr3DvbLMhfdjc5LH4htHeMBOpoH8pm6tlP64/R5adtM6NuU?=
 =?us-ascii?Q?qce1fcM5236w8/2U1F3hPQ7YNhldf+c/CSAQ/32mTvajI1gW5b8yzPfqvtNW?=
 =?us-ascii?Q?X5BGlPeSOQ7TGrWa06l5pFxbe4u18Up+eKxQ5FCXillLpjhd1ZgXx5iS6Y7b?=
 =?us-ascii?Q?Z7WrWv/F6P+5SmjeWckHOWQrQy8xbSb9X6NCpGYAbLx/2atQsKzI70HYIyG8?=
 =?us-ascii?Q?IPEgJuQQI3OVOhLpilMatEGA6Z0gwZdHI+TyuFq9iZjM91ZqBm1X8QTrGHfc?=
 =?us-ascii?Q?AQENjxlP8sUsb4ZBiDYQsv5HE5qh10k/HddBIkqvhGRUJedS2lhdDazpejzy?=
 =?us-ascii?Q?Y/I0CIIKuwNz+DBZIbhTg8W/JeR551OmZUsCGw4fwwYUcDIXNFGnQmV+p7nS?=
 =?us-ascii?Q?uy6Tev5S+08M3WtACuxGdeYWfULNtKAcqeT0kmD/3XsoMo9ArYlX4CjjbSGj?=
 =?us-ascii?Q?e5DzOSRFabsZqtXDy1e5zdBLiFWOK5H3lbj23Sj+iRL6kWl91U9o5JQ93nYT?=
 =?us-ascii?Q?wiL08cQp/SFWhIYvw65nriqbkxozXv1yTZ4kWWKsH2+7/oL46ZpAYRx+WM8H?=
 =?us-ascii?Q?3y9whqGX4BdRvV/P2CTnTvv8PYcq24ivV0zUWRuSwHNVrLRcEBolKzEas5TW?=
 =?us-ascii?Q?+H42qypT96uQ38+aLNL0DtpF+UFyGkRKljP7YVzIXZ7q4QkecKn4GM0Ctnzf?=
 =?us-ascii?Q?TcLBW2M9C3rq3E8V5ywlW5/DsHFVhMTMx8s0XRWbUayYl/zvihVJQIFH5yiU?=
 =?us-ascii?Q?6X9vYUxxQrw24eQLmcZLmVbA7vdxYdpNW+44ytiNy30Katv1SX88Pk6PmFwV?=
 =?us-ascii?Q?g5tn1NOLqUrjyduktDddEEY2q/yXa+4t1Uxe5dUihttouNm/THcG50pbOx6w?=
 =?us-ascii?Q?WR9pLLZwUgxUd1Kg44o3LwYujL5BP7b2T8mvgxckmUlWSCMgsHIZWnktpI7X?=
 =?us-ascii?Q?W/ZwUPo8mLzaxfsb/DORbIwAw/PQxaHj8zI+LAaFjAnbowYbEtxYW7DxTXMx?=
 =?us-ascii?Q?utLWQt3VF0aJEVD/l+H/L6iDTJNY/f39UUFu6v5XI6K2lLGJlSnrTOEWxMNA?=
 =?us-ascii?Q?sgeifI5LmMXn5SloExZ5NAT4M3hrLP1sAP1QL/cqoFEfFfxIW96jX0OSqYvG?=
 =?us-ascii?Q?wdaCTWfp1YG400ZXtCarXIevpQaH2nQUJeH570otpv8JWX+z44ei7hgIXvHh?=
 =?us-ascii?Q?jNYfw0R9wBxsbHZCBPkaCNsCtnQCKazKvc/NnyyWh/C2RAgd7VXQ+BonwfIn?=
 =?us-ascii?Q?04FFAei2xeJMrNYImgRPG/LcMclZ+gyLmWgs24FIyyaoZVkWAzwzc2PQPaVc?=
 =?us-ascii?Q?Q1imnbLu72IbDzr66/M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:48:50.6565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebedcd9b-6962-430f-c605-08de53415b96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264

From: William Tu <witu@nvidia.com>

The async ICOSQ is only required by TLS RX (for re-sync flow) and XSK
TX. Create it only when these features are enabled instead of always
allocating it. This reduces per-channel memory usage, saves hardware
resources, improves latency, and decreases the default number of SQs
(from 3 to 2) and CQs (from 4 to 3). It also speeds up channel
open/close operations for a netdev when async ICOSQ is not needed.

Currently when TLS RX is enabled, there is no channel reset triggered.
As a result, async ICOSQ allocation is not triggered, causing a NULL
pointer crash. One solution is to do channel reset every time when
toggling TLS RX. However, it's not straightforward as the offload
state matters only on connection creation, and can go on beyond the
channels reset.

Instead, introduce a new field 'ktls_rx_was_enabled': if TLS RX is
enabled for the first time: reset channels, create async ICOSQ, set
the field. From that point on, no need to reset channels for any TLS
RX enable/disable. Async ICOSQ will always be needed.

For XSK TX, async ICOSQ is used in wakeup control and is guaranteed
to have async ICOSQ allocated.

This improves the latency of interface up/down operations when it
applies.

Perf numbers:
NIC: Connect-X7.
Test: Latency of interface up + down operations.

Measured 20% speedup.
Saving ~0.36 sec for 248 channels (~1.45 msec per channel).

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../mellanox/mlx5/core/en_accel/ktls.c        | 10 ++++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 30 ++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c | 38 ++++++++++---------
 4 files changed, 50 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index a7076b26fd5c..d16bdef95703 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -939,6 +939,7 @@ struct mlx5e_priv {
 	u8                         max_opened_tc;
 	bool                       tx_ptp_opened;
 	bool                       rx_ptp_opened;
+	bool                       ktls_rx_was_enabled;
 	struct kernel_hwtstamp_config hwtstamp_config;
 	u16                        q_counter[MLX5_SD_MAX_GROUP_SZ];
 	u16                        drop_rq_q_counter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..1c2cc2aad2b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -135,10 +135,15 @@ int mlx5e_ktls_set_feature_rx(struct net_device *netdev, bool enable)
 	int err = 0;
 
 	mutex_lock(&priv->state_lock);
-	if (enable)
+	if (enable) {
 		err = mlx5e_accel_fs_tcp_create(priv->fs);
-	else
+		if (!err && !priv->ktls_rx_was_enabled) {
+			priv->ktls_rx_was_enabled = true;
+			mlx5e_safe_reopen_channels(priv);
+		}
+	} else {
 		mlx5e_accel_fs_tcp_destroy(priv->fs);
+	}
 	mutex_unlock(&priv->state_lock);
 
 	return err;
@@ -161,6 +166,7 @@ int mlx5e_ktls_init_rx(struct mlx5e_priv *priv)
 			destroy_workqueue(priv->tls->rx_wq);
 			return err;
 		}
+		priv->ktls_rx_was_enabled = true;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index aa4ff3963b86..d04ba93fe617 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2632,7 +2632,8 @@ static void mlx5e_close_async_icosq(struct mlx5e_icosq *async_icosq)
 
 static int mlx5e_open_queues(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
-			     struct mlx5e_channel_param *cparam)
+			     struct mlx5e_channel_param *cparam,
+			     bool async_icosq_needed)
 {
 	const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
 	struct dim_cq_moder icocq_moder = {0, 0};
@@ -2668,10 +2669,13 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_rx_cq;
 
-	c->async_icosq = mlx5e_open_async_icosq(c, params, cparam, &ccp);
-	if (IS_ERR(c->async_icosq)) {
-		err = PTR_ERR(c->async_icosq);
-		goto err_close_rq_xdpsq_cq;
+	if (async_icosq_needed) {
+		c->async_icosq = mlx5e_open_async_icosq(c, params, cparam,
+							&ccp);
+		if (IS_ERR(c->async_icosq)) {
+			err = PTR_ERR(c->async_icosq);
+			goto err_close_rq_xdpsq_cq;
+		}
 	}
 
 	mutex_init(&c->icosq_recovery_lock);
@@ -2708,7 +2712,8 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	mlx5e_close_icosq(&c->icosq);
 
 err_close_async_icosq:
-	mlx5e_close_async_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_close_async_icosq(c->async_icosq);
 
 err_close_rq_xdpsq_cq:
 	if (c->xdp)
@@ -2740,7 +2745,8 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	mlx5e_close_sqs(c);
 	mlx5e_close_icosq(&c->icosq);
 	mutex_destroy(&c->icosq_recovery_lock);
-	mlx5e_close_async_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_close_async_icosq(c->async_icosq);
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 	mlx5e_close_cq(&c->rq.cq);
@@ -2825,6 +2831,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	struct mlx5e_channel_param *cparam;
 	struct mlx5_core_dev *mdev;
 	struct mlx5e_xsk_param xsk;
+	bool async_icosq_needed;
 	struct mlx5e_channel *c;
 	unsigned int irq;
 	int vec_ix;
@@ -2874,7 +2881,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	netif_napi_add_config_locked(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq_locked(&c->napi, irq);
 
-	err = mlx5e_open_queues(c, params, cparam);
+	async_icosq_needed = !!xsk_pool || priv->ktls_rx_was_enabled;
+	err = mlx5e_open_queues(c, params, cparam, async_icosq_needed);
 	if (unlikely(err))
 		goto err_napi_del;
 
@@ -2912,7 +2920,8 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_activate_txqsq(&c->sq[tc]);
 	mlx5e_activate_icosq(&c->icosq);
-	mlx5e_activate_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_activate_icosq(c->async_icosq);
 
 	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
 		mlx5e_activate_xsk(c);
@@ -2933,7 +2942,8 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 	else
 		mlx5e_deactivate_rq(&c->rq);
 
-	mlx5e_deactivate_icosq(c->async_icosq);
+	if (c->async_icosq)
+		mlx5e_deactivate_icosq(c->async_icosq);
 	mlx5e_deactivate_icosq(&c->icosq);
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_deactivate_txqsq(&c->sq[tc]);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 57c54265dbda..b31f689fe271 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -125,6 +125,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct mlx5e_channel *c = container_of(napi, struct mlx5e_channel,
 					       napi);
+	struct mlx5e_icosq *aicosq = c->async_icosq;
 	struct mlx5e_ch_stats *ch_stats = c->stats;
 	struct mlx5e_xdpsq *xsksq = &c->xsksq;
 	struct mlx5e_txqsq __rcu **qos_sqs;
@@ -180,16 +181,18 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq->cq))
-		/* Don't clear the flag if nothing was polled to prevent
-		 * queueing more WQEs and overflowing the async ICOSQ.
-		 */
-		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
-			  &c->async_icosq->state);
-
-	/* Keep after async ICOSQ CQ poll */
-	if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
-		busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
+	if (aicosq) {
+		if (mlx5e_poll_ico_cq(&aicosq->cq))
+			/* Don't clear the flag if nothing was polled to prevent
+			 * queueing more WQEs and overflowing the async ICOSQ.
+			 */
+			clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
+				  &aicosq->state);
+
+		/* Keep after async ICOSQ CQ poll */
+		if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
+			busy |= mlx5e_ktls_rx_handle_resync_list(c, budget);
+	}
 
 	busy |= INDIRECT_CALL_2(rq->post_wqes,
 				mlx5e_post_rx_mpwqes,
@@ -237,16 +240,17 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	mlx5e_cq_arm(&rq->cq);
 	mlx5e_cq_arm(&c->icosq.cq);
-	mlx5e_cq_arm(&c->async_icosq->cq);
+	if (aicosq) {
+		mlx5e_cq_arm(&aicosq->cq);
+		if (xsk_open) {
+			mlx5e_handle_rx_dim(xskrq);
+			mlx5e_cq_arm(&xsksq->cq);
+			mlx5e_cq_arm(&xskrq->cq);
+		}
+	}
 	if (c->xdpsq)
 		mlx5e_cq_arm(&c->xdpsq->cq);
 
-	if (xsk_open) {
-		mlx5e_handle_rx_dim(xskrq);
-		mlx5e_cq_arm(&xsksq->cq);
-		mlx5e_cq_arm(&xskrq->cq);
-	}
-
 	if (unlikely(aff_change && busy_xsk)) {
 		mlx5e_trigger_irq(&c->icosq);
 		ch_stats->force_irq++;
-- 
2.31.1


