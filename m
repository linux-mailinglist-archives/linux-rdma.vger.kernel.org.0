Return-Path: <linux-rdma+bounces-13222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F09B50E76
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE17A6477
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 06:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7D4307AD6;
	Wed, 10 Sep 2025 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bov+ah+J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532E1798F;
	Wed, 10 Sep 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486919; cv=fail; b=E/wZa4YeORKnBHHCEVD4wtQvy/VQd/dHRAfHv+Yxvo46S73Sq65HUBCFIXZakBKj4Z+rgIq0P/TKJ+sZXdhAJMZLSd1UazvqAwbn8Uoy++3ECG8jmlN28CPfzGnNpDkL0JM8RaEiFusLFyV9tSxvvu+8BUyPGH6cnTu/bL1D8IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486919; c=relaxed/simple;
	bh=/MVCRYtzGXtqMvBofzYLpZfqZfxA7i5tKaYAadFsclA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO7s7whSQRKkJTkgPWgF8t3+slvscgdBggbB8g8r3wHLPmYn6xUwnS2n56zX0GcLPSqokNPXrIdAADnncBz8rGMvoUTMi/E4filPWl18NzaZ5Pbyda6788dEq90y6bZEkusDjDCRrC/koDMx2vyBK0plhdKxDy3QfH+dqZErg2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bov+ah+J; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwTuC9zeE+d5yiTIhaMhbTDacHVSOFYm4gMV91NNBneIgiSMaDmrFdnQhMQy++6VUeRgvprXeF3YMCncDnPnNblxhYFiO7FXxk8Ir/EqY2mm2lMtfKvCSWn/nLqBE8338xPmZ9H2JINlCL8uf3EHyNH3TXhg6FUHVfLvmqN8W7OPmUJuO4JQRT4uTVzKsx5wL2IsyQpUYLxOFcv5MqvxyroAa7AkGxGyydNHdHyU7fc0gMWHzs8858jYXNnI8/n/AZkdWBFfu33lh3INQrvLet5Tb3y+tDOCCvJ0SV1fIDDvsaka6dUvAL/kNg1rOBVooKialD1MLQa3CYq+GlX0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8CdkHnM5dhM+KTH00sFx86IeSBn/asiX1naNRDvSqA=;
 b=MXob42vM+pBAs4RQqzSCeM7mYdcylS/S8NRKNxNpw+4xPNHYXnJuvX2jEoYCiwt9cZksN4YSX4FL26uEniJUdF2j8f/tfSv3BLX9FBPmEuYz5CbST1zw15IMrpa0JmxZ8lTnnI8UmHhOk5h768JNB1Ugo4ocZXt0ODSR+GMrJdPNwa2ct5DC7gk7JIcqNp2ZBuJvIYu+BfQ0jgMP90zLcu7gx42lApynSGuIhsGQDWlkNfwA7HjQBlEKsaiSAsx1KV/z4cHkXgBwDRGGkTufdLtfr9Mk3/6ZO838NzHRBHNDBuwJUMH5bB0F8Gt4259NfLcD72WjCw2bXGb5J4f+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8CdkHnM5dhM+KTH00sFx86IeSBn/asiX1naNRDvSqA=;
 b=bov+ah+J9QyWvQjytdl9/HjNSxCnHXcHTSeBzYW4D0TyP4/GAmIGyySeqofj984lRLb7OI4hOL2PawxuGsjR5E5pWopgOuOiGRg83thVbOvyQu09dmhxRCYIiVBhvXvcQ05Cn+pu6fQTVQiPRsmzbTo0tBcQqgj53ny/aoGQ1EliMFRlp1RZAECZpa1rSJQ2KiF0i8g6vUz8Hvk7a40mgyRT2yNqfqlHz9Ow2HPgrYJd06WUb19b6E+QoTvHY34yHh7z0VSho0MQMr72tv5lWVbmHSFF5KIzLIvCq4sk1Up7Uu0HpPJOIC8xtQV8f5n3Qxn1e4o3zmF2myjKq/FDAw==
Received: from BL0PR02CA0138.namprd02.prod.outlook.com (2603:10b6:208:35::43)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:48:33 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::e8) by BL0PR02CA0138.outlook.office365.com
 (2603:10b6:208:35::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 06:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Wed, 10 Sep 2025 06:48:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 9 Sep
 2025 23:48:08 -0700
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
Subject: [PATCH net 1/3] net: tls: Introduce RX async resync request cancel function
Date: Wed, 10 Sep 2025 09:47:39 +0300
Message-ID: <1757486861-542133-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|BN7PPFCEE68E7BF:EE_
X-MS-Office365-Filtering-Correlation-Id: e9aaa26c-7f47-43c4-099e-08ddf0360ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wAPsl+eX2nlJyHlWf7a0X1Iuj8HFc8D8JGrZWAQGn01DYZujjgE0DEP0LqS5?=
 =?us-ascii?Q?bsLtSbCPuMSnHqdrD8HeAe5iT1tiM1C4xsQI/gJc2zLut2ENM5+ni3M2WjYY?=
 =?us-ascii?Q?Y8dD9YfSMkFlqmdQKSGydJTPwDQJjxWDV8xhJdcEVX2JKOofu/HiBTvls28F?=
 =?us-ascii?Q?Sh0lPucsRBHhLass7PikTGxiqNy/o0pRTcAufK3I71arCNAmiXxGL3OzqPjF?=
 =?us-ascii?Q?kGtuZcdv64xMqQUFZZOnmjMfqJwy0493dPPD0h3pOaS+RYL62IDQ6OWx4Byq?=
 =?us-ascii?Q?ckXlyO/c3DMOAkQ63gyAzt2ZQhZfZF+0/Gov+Q+wEuEA1/6vwjIf2c72RkO4?=
 =?us-ascii?Q?wEsMt7ujLIc3irwGzy0E27t8RifWWI2PbUkOwdxioOW97xHYCa9L1VKzNmg/?=
 =?us-ascii?Q?EgoWqKqxBUrOT4Ri6oNETaVR4RUPCDzZYVNbf5eGoCIA8I+/d6HmhpXh+r3F?=
 =?us-ascii?Q?YioUu/UIat1o9f1+SF8F2poU4zY9xUFbRhVPBSXDrukQpJe/6T8AnigW5hRU?=
 =?us-ascii?Q?UnzzjyQmcZRHfofdNYBHFREBm6doILHr2sYwK6qP2f8ECG6ZRUHJBltbIJst?=
 =?us-ascii?Q?EXQ11VVc/KB66NH7qTEclx9mMU79VvQy12vevVr957pXeOdO6wN0sn78waCi?=
 =?us-ascii?Q?8IPaAFW/h85VyPfAIIn9biyHEaIgZwFqOPaiQ+9cs5Jj5dweIOdlswkHcvis?=
 =?us-ascii?Q?NED4RxSEgqM6YaiS5s2B0wy0OT/xo6Mucz0Rb/fre0oqNxoxlDeSfsIuSB8w?=
 =?us-ascii?Q?MrFtUND7GBnRbAU6jHe0SN1NKH3AZbWTBM4+cjo7ZXc25bJvT4eCI+EbZUOn?=
 =?us-ascii?Q?rLUtjaT7hbY4i/3Z2vKckQu+YYY9IJhOiQsu/xOGXgzK+7CK7rwJJM32jRv+?=
 =?us-ascii?Q?EEXGvPt2FeVBacRrlRx0tByrvN0stoOfkcIBmvEiTRMx7hlLhx20Ebox1txJ?=
 =?us-ascii?Q?H4D5v6FuqVfPrqbJlSXVV/vTle0Sn9ML97S+PI0e/whONAP7sA7HNM3G8ayP?=
 =?us-ascii?Q?7naXPAQz7YShhNGOwRl8MuwxtENYhBB0jyZ9+54gVf2OdOB5TwXJQdJ8A4Ac?=
 =?us-ascii?Q?YyecFIxUycCNKi2k675T1/ckV+uAkkSTzN5jTpq+S+Ecsq3zSWNwv4DXRV8j?=
 =?us-ascii?Q?yuCHZykOkNiJ/uuMVIzYkOkTeNW7TBrzPBTO6lq3e287V6htE2c5m+H6/wec?=
 =?us-ascii?Q?E66Nouofgnseo3E0SSq7B2MxOW3glaD/hF396ToPb9jsAKfDQwJCDlt6n1ax?=
 =?us-ascii?Q?6PEXXQWKR2F880QjtrAPQZ3792v33NQKL4OJHU18ksnlYAKh5RGFXBNovyQy?=
 =?us-ascii?Q?YfZ0APqmr54G6xLe57JsySHd5hbVCuAgLkOPbK0CuRP3vomgD1NAd42sV7QB?=
 =?us-ascii?Q?wc1ZDjJ0ohRXviqrLQGQv2N/Rd9qLEIegqp9jHU0gdpiTUHwtfFGdun4s0Ji?=
 =?us-ascii?Q?E/Xpfa2Pdc3pAh5GPmgDuNFwM1V7uav/uYsCNhbe8ndt9CXJOvJ2MTW74aTv?=
 =?us-ascii?Q?wSuKgdUlDbMJUlFXaT7dyHLzOAlJiXjplYB4?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 06:48:32.3471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9aaa26c-7f47-43c4-099e-08ddf0360ef0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF

From: Shahar Shitrit <shshitrit@nvidia.com>

When a netdev requests a RX async resync for a TLS connection, the TLS
module handles it by logging record headers and attempting to match
them to the tcp_sn provided by the device. If a match is found, the
TLS module approves the tcp_sn for resynchronization.

While waiting for a device response, the TLS module also increments
rcd_delta each time a new TLS record is received, tracking the distance
from the original resync request.

However, if the device response is delayed or fails (e.g due to
unstable connection and device getting out of tracking, hardware
errors, resource exhaustion etc.), the TLS module keeps logging and
incrementing, which can lead to a WARN() when rcd_delta exceeds the
threshold.

To address that, introduce tls_offload_rx_resync_async_request_cancel()
to be called when device response fails.

A follow-up patch will use this function to cancel async resync
requests in mlx5 when the device is no longer able to complete the
resync.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/tls.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..380492effe3f 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -472,6 +472,15 @@ tls_offload_rx_resync_async_request_end(struct sock *sk, __be32 seq)
 		     ((u64)ntohl(seq) << 32) | RESYNC_REQ);
 }
 
+static inline void
+tls_offload_rx_resync_async_request_cancel(struct sock *sk)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_offload_context_rx *rx_ctx = tls_offload_ctx_rx(tls_ctx);
+
+	atomic64_set(&rx_ctx->resync_async->req, 0);
+}
+
 static inline void
 tls_offload_rx_resync_set_type(struct sock *sk, enum tls_offload_sync_type type)
 {
-- 
2.31.1


