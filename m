Return-Path: <linux-rdma+bounces-13223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73469B50E75
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760FE1C81041
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 06:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E031308F08;
	Wed, 10 Sep 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9jCdub+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DE30648C;
	Wed, 10 Sep 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757486925; cv=fail; b=T3c3YEMCAHiuMLfObdvmJcsU3mAZAQIbhQQSvqoAox8ZjaGHecqEp4WlFTCM3tcvxM4+qKVa8tQWjw5Jrk+t20uY9dYV81JSSj55jxA1kP7xEBT4W3VmEIRwOE34eRf2SJ9LpZ4ekByBYRReTJ2iNCxucgEWmNRD4zOx2X1kzhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757486925; c=relaxed/simple;
	bh=Rz9tknUE4NjmlRHl6uqV8huqdEct8JTLO7RgmUrjkh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEi/ezPHoXEV5d0396QPW9jueqEEYuzn9D5yyYYkyBwOp1Sr53AH2QA6WG3uTxQW8ZxafMjhtiuH9imVJ7NvKDpnt3SCyUKB6oG9JODwDN4J8iJmUl8Pv9jCuEJ0/+l1E0QT5kr0VBa409lHkNEv2AP6Vk+lKE/ulooF+PQz6u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9jCdub+; arc=fail smtp.client-ip=40.107.212.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBlr9Fnb57n1Jcu/hO07bHGjEGgxNzNfMmoBagx9esRX79g5V2YrfC1Nr92jVkV5EkOu9SQJvdxmf+DdPft1wjJrnUMc9deIb2sKxnUTp9Ti21BmrFXuu9N7RD4Xr889R3HGcDCcHabWFXH9et7q4Ka/A9RxS65OR+mAfTLy+BJCNfy0sf4PAYn9oRic8xuOb4nrzeCtiOwypx4HwmNEJ+WxndRF4TY18QsOMHnvwYEPeMmLRRo6JdPTzsRU0Sm/aJAtEXfSarsp0tC/SFHiFG8Er9mcnb7f09XZlAzqVPH2PYfU49cxb2dgxSx9f3AF+CNHOhn7OQYAXGsNnFRJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50z5szLwyyOw3PyIfuP889MHb655Uqy5nEy1Dib5nf8=;
 b=GD9esRdnYESMEY9pne/go3MCGgPV1FS0uhqUdenj8z1BT4wD4BPijDk24QAG+pPLNCkJptir689q19nBxbD32MKm9k1o3vnfcKPtYlCVw6gi5+jLFoU60KxuUQldeSP4DldKtglCgBewYqV9mSPS/FCoK0GAb0TYilJ1HdF6pV9GESyOSJCMWhAk6a3nYr63f1HnWMSF9HMt/Z/hd6ANbIi7h18lvDLjG512iz5ZtwBXFQVEpJKU9bccAe3Efs/D+RQcPNjoipv+l0QG25JNdhlGV8FDaVKehTC2V8+5sEXutVEnvpjEuVu7KSMsOAwLlqr+ByNnSNBzXpLRbD2vxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50z5szLwyyOw3PyIfuP889MHb655Uqy5nEy1Dib5nf8=;
 b=S9jCdub+PeuxF0hmBxD+ukrZJ0JUU78k1TS9cs/tVSPWRmh9GGZzbNwQRhS0w40N/W7SvZ7aEF1LEkoqV2cYgnfflEkXARc1KliaWvBds5SlkP+WBZscNAUurSDauXYUeqaJ/4RuqN21FcfzW+mxeEwyzK1ytO7u7n+pSZHNoer6pRJt83/YzQQUfmwthveRfdCrb25hQwpNwem6YSOnErwcT9qkTaDcIX1II+Q4ZzUavlOQAqgqKKghnXh+BNYIwCh9Gt9VNZs51kd4XbwMIJNRpsf3mg8qegTeB+d5nuNY6U/1m01qjX+OOD42QKgxezDpiLt4WLvs4Zz78/ZZIA==
Received: from BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::11)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 06:48:39 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::f6) by BN9P220CA0006.outlook.office365.com
 (2603:10b6:408:13e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 06:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 06:48:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 23:48:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 9 Sep
 2025 23:48:13 -0700
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
Subject: [PATCH net 2/3] net: tls: Cancel RX async resync request on rdc_delta overflow
Date: Wed, 10 Sep 2025 09:47:40 +0300
Message-ID: <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 57bea1f5-f8f8-4318-0a50-08ddf0361271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zPn3uhjuvnT24FgpeBph4USO2gLyk3QKQTe9IMrYBZ6qjqlImR/L+AbFPphO?=
 =?us-ascii?Q?jLsA8967q87y1OVPt5Aqcs+HYHOqJy6turAgRv0NlE/qbonU+ezuJ7v9gzPv?=
 =?us-ascii?Q?6ZSW85q7uY4x5gs8YDdGNQnVyfaRRSjLGiFmgvfFxd2HSvyXlIoU9YudGcvy?=
 =?us-ascii?Q?Ly9WZVTNbOyX4mRo1yo0sKXAtMJlx/pUp4nZs9G6MVF4rSwTN4/Q6wDz8V97?=
 =?us-ascii?Q?jdJ2SYGIJiXqBTEo973ajSCgKj3F1g0Hu8Ozj48JTk/lhRhX33LQXlrFGZEO?=
 =?us-ascii?Q?LDkOCK/u9zBxCVfgTYq5P96bKehaWaekUL8VXCVrDdatFiTNwkW9q3CzOEc0?=
 =?us-ascii?Q?SnlNok2eDE8glR+xq+V/0FNpVCspJm7Er7cBnoC/H+2htUVMWjv9Y1DYf37o?=
 =?us-ascii?Q?9lgpGqOaGhuZJYU7tKfPVZbrRVHfcK7bpi1dKxGXY2FJQGAKTV++1Ksp1fVc?=
 =?us-ascii?Q?AFqNa3i9JcxRjNNJfDohoY75xWeSbQrHB3qYngNXzc5W0Q2XC38Dy41ne1Ti?=
 =?us-ascii?Q?mCit8RGIchTh5kcolFZTbdGGHbEKzzPJP/CRAVvTIYvFHESSA4DgP+ecT4U9?=
 =?us-ascii?Q?EfVc70d1ekHPv63CHm5K44lvGRrQo1SWgHpi1SstukYdTcm9Itrua9uYeszG?=
 =?us-ascii?Q?TLqIGN/yls7qxfbdFBt2noWAjcDSxhFo1nTTxtIbwXZLc8XMiGU+SOi+uKkf?=
 =?us-ascii?Q?YSBzbtgbiZ0xlvaPWC5MWSwqpOV7wD6V2QNfqwBON5NYrdFONw80yR5Oerwd?=
 =?us-ascii?Q?aIGBwttkc5d1gA0fvMh5EKWdHQN5yp5t4uk8rcndbUuh17O7/Ho4/KVGUYwX?=
 =?us-ascii?Q?5KaDxCDfstXOM2s+N+lmPvAwCoJQwCA8VR+d1VwTS0nnGJLUVSCZ3tDCPQpe?=
 =?us-ascii?Q?U5Np7lP1KWMkpyZjolY1cYuyFztICBc/jJ0jq5Z8trgtSlkzH5SBN21siYcW?=
 =?us-ascii?Q?2vjefsTHjOpEY6HU9+Sg2wIPjhI/LuUNGQXkffq70mvSypJ6llQaG5V7ytCU?=
 =?us-ascii?Q?YVnMLqHpwodgViaqaJIvBZ04Sr7JDPS+Dl/0G1ReyQiOqnvPD7V0saXkchnb?=
 =?us-ascii?Q?l8h8NCYqKY997zOo5HWCcEo/QwBePqigPCGJn/s6jwr6qe3tgZxVRxB51+3f?=
 =?us-ascii?Q?CludeHrhqVYkka1Y2VxFdv4P1myh4E55oK3WyedpIA2f61PkNW3UsvBLJwSE?=
 =?us-ascii?Q?ZNtpVa4bz9jDm/ZI8wj+L/QZBJZx8z/tDQ2ToBq0P2+gmhwPKwdxqg3HwtNb?=
 =?us-ascii?Q?eg3YumF3+gUJUw6pLxKAW4JLe4yUqviWTQDAGFFlkVwo2c9323VhYvCfbS2+?=
 =?us-ascii?Q?ZxZL8p59CLB27RliH6f9+Cx+bV172hyI+w5W4iUwtxRmk3UtGMmWYy0RP+55?=
 =?us-ascii?Q?mHDr6uRzsrkz+rCaDDsOBYC6xxWd8rS0HqZcVQfMUDDrKe9y+UUpz3b0dYlG?=
 =?us-ascii?Q?sHB4Qj09xAWwOXwKPfx6sdDBbLBwC9LoOQ+aGEZ7jXcJUMv3ROlDu33XVFEm?=
 =?us-ascii?Q?/q/ErBHa+ac49q6XhIqtNwkJdKyWqNygZo1K?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 06:48:38.2968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bea1f5-f8f8-4318-0a50-08ddf0361271
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

From: Shahar Shitrit <shshitrit@nvidia.com>

When a netdev issues an RX async resync request, the TLS module
increments rcd_delta for each new record that arrives. This tracks
how far the current record is from the point where synchronization
was lost.

When rcd_delta reaches its threshold, it indicates that the device
response is either excessively delayed or unlikely to arrive at all
(at that point, tcp_sn may have wrapped around, so a match would no
longer be valid anyway).

Previous patch introduced tls_offload_rx_resync_async_request_cancel()
to explicitly cancel resync requests when a device response failure
is detected.

This patch adds a final safeguard: cancel the async resync request when
rcd_delta crosses its threshold, as reaching this point implies that
earlier cancellation did not occur.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/tls/tls_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f672a62a9a52..56c14f1647a4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
 		/* shouldn't get to wraparound:
 		 * too long in async stage, something bad happened
 		 */
-		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
+		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
+			/* cancel resync request */
+			atomic64_set(&resync_async->req, 0);
 			return false;
+		}
 
 		/* asynchronous stage: log all headers seq such that
 		 * req_seq <= seq <= end_seq, and wait for real resync request
-- 
2.31.1


