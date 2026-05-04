Return-Path: <linux-rdma+bounces-19949-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EE4E8Dn+Gmt2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19949-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:38:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A74C2AC2
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42FEF300AB23
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477B3E929B;
	Mon,  4 May 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3e6fElO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1E3E7145;
	Mon,  4 May 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919907; cv=fail; b=Oqheqe5+fXYnRkmRnYX+/ZhhFtQZ877sh+29X4RPMMB2XYrgTakKSY2OjaoF6VAV1voscdrOeDlr7F6j4uCkQImHdqLI9DBd4hWbd3yw0QTUdLZOxjz/SLrS1cn3qaWOmzbYaPyT0wf40Uy/dCyKOWA5ZqVn4hw/U6dynwqCY3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919907; c=relaxed/simple;
	bh=iordBhU+B0xH/5OrXWnkzYgjvfmq0UPFeM9CfFmhOEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eI9qXJBQkA2L6fDU+umbPqogYjuWe+Oz0GixTI3xRev9oclEFBZJHNJvOMqfTnZE74QcE4YkBHJqmqrHgWVCbU1Z4ix86ajVkBwVDMqYFIP6+EfkDAODkVoFRVUFGJLOCNU2jjgBi2aGVQR9lSYR8V3OiMeZ7wnAAKJw/kKLsP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d3e6fElO; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trPL5xAp/mJFwwfqdRWC6Rm8qpnInGWAWtsiHS82PFLeVXpNUfhrarjxZqW/QpZcwMkGq3o9p5xNX3UAoMWMATh4N6UI1S7oCz0RKa0OnB1yo14lwVPRkkUp1vriPpq+vcdjREl1wWQecVTagT+BW/9zPc90Ouh6jrTH547MmE5dxwNdRZAczWoY3JYrSH3lxzqlCoi7dkYTj4vZkoTHTDCPQ6Co44XgrELGWMv5iXJtAdkuETbgh1pzzU4BHUKrhANL+AKFJw4NyMXcLlwdm+LxjakuL7uThf5yqVOdS6Xj/GW1l4KYnac87uiCL9DuGwz+S2D8OTefNGs2mezLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhNgtJlTQwczx/6hXTTviKXtE5XQ7D1P+PnhB5QKa94=;
 b=Hi6G5M0JGw8JmFn250qR2bBlYHMRxtTSlEgoCiSGVEWgNgnNOElWRjlAryAOmaSI5hWgCIgPcvWKL/FNT+DZtzvXbmetKKp6RY4M0Lh73AjY7yWRnNI1vJSFQQDb0hbDzjwbHAs7wevqg1zbMxHwARLUTlcuzxKU3ckOAoo/UcZ6RcjZRlNTcB81bH6KXadyP6Tj2AvLe3HpkD5EDDoLQ8eCNtQDKlUbraFRiHbuqFTj5BkzJdXp38dUfMplV2bYbtl9ZfD4n4jIZMkCXdBculhvgcqWFi8lWZ0ck/6zvK7Sjg6kCuasbvFHtANGVLB7FhVnXG31JcEJwVeXOd8iPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhNgtJlTQwczx/6hXTTviKXtE5XQ7D1P+PnhB5QKa94=;
 b=d3e6fElO+M13UQqjwtSXKUmvUkeFARg87nAdDr7AZE3dQ2o1Cn3TIBEUr1RvX3U4gl7dRYGwwW6NvFuNlHhKiEMvXva2AL5THzC79tGxqdZO+hzkqCYA6sw5BiDXqzGe9A4OSvwgGhPuvMT0PNNzgp3n7r2R+IvOn696F7YuhsWe1/oWtceiIWlXarqHmBLy67DG+MCJISLhdf1IdRogWhHQF0C09Bfddp5+lmnCEAthUSKTUJdqPcqaLAqo4un50tn8WV/B7Ar0Isg+HaQay+R9K/8XCW4dmJTsIkVLqh1CT+Ez8nE9HxJ9465HMcgj+A9YNdTkqlb4EKsooOp+yA==
Received: from DS7P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::35) by
 DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.25; Mon, 4 May 2026 18:38:18 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::ce) by DS7P222CA0027.outlook.office365.com
 (2603:10b6:8:2e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:37:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V3 4/5] net/mlx5e: Report TX csum_none netdev stat
Date: Mon, 4 May 2026 21:37:03 +0300
Message-ID: <20260504183704.272322-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260504183704.272322-1-tariqt@nvidia.com>
References: <20260504183704.272322-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 4776097c-9bca-4d9d-3222-08deaa0c4fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jKh/1j8TKXuO3sqCsP5+5CYY21XPivpUcBtcrBLifzp/CG3s22wjrlftwWKtb1ti2mak32s4oj/OoHsD/h1IHwmNuHGrsAqlD+DXNyOW707nFu1m96fEfrljs5ZFaHKvX8btrzkPQLCOB+vE7mWOcdPg9UoM/9AKMlQsVvNUxxF8uHOtexABLLEBCd7oejdipluoVKSAkAeJoA0G328L4GrTKAQzAkHPZJyYO4Ys4STgeNT0759A3MCGW/xzHKUxao+RGdXz4u/fywR/gPLli5FerhfOwK9W3VkeTwh6DaRPzsKSXKiIyjF+gLzSsn/BpyCcQQ2kLp7uNgvy7ZPK5PECWyWsqm/v3bIiKvfKcKNO9ag5Lu6567sZDIQeZQYcT1/3OC1H1IkI7uiTrZ9il1cydNetaWs6XBvtnccBkAKph43MpRTIopnqmIVno/aI+cFrCfmvctMTnxLKUmiMV/wth51/fEHOsCCQRsDodGE2mQHtY9W+v3w0PoJmmLqFABDbF7FWnMR05GhXsf55cM0RZhtuaFYKoqJ3LuncXaaI7XEQqJrRpuXS4583yPKUKF6x6paGxpfqMyyi67NDfMImJ03Kmh80Gy0NC5ewfcSKUsmeiY4GKHhHWT00mn+r3UeUizjrEVsydXk4io+04obBIapTuSgpT7+oIbo/ZDca9CVVXqaaxA3nc/6W91ajslKiDaPTkquI0BtPh5J0wtMpYfkYeV1AYYGyGBJ6/K0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YF16mcobK5D6D3GIX9e4GVRJspsTW0iqt+ckvDra2Pl06HCl3uSjnUR27VH1fR5hxM4BqDgaXuN2OAp1VRpiV+u3P41Lwkt4AwaRX3CS8HeSjuSDcwjwrGZMQ97MPohQMKScFFUKPmPX20kKnyG7c7NNJuLkjFrBPyRErRP4bubFCZcivX/2XXRUPwPA2Fz0ZNxC2iGsi5TbwK3dnaH7MdMgdBLp1JjL9tJhAJRtYOyGw27n30kAqRQPRblPajZuQPsmh8J/NG3y/e/QmJbKgoS8Znf3LuBO11Crm3RAnUWNE1enI+En6zaIhQ3wEjaDPe+UUHkQR7VIiBficRx2s/orKUhtbEF98QGCoex8sSmKsufhTD/QPL6DXb/zkKbsEJlY4AEVwV2bwDHxNmVU4lUe2z3Nwvb+LJbYPihvEHhfdB3VJjrRmYJTcTo0/XkV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:18.4152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4776097c-9bca-4d9d-3222-08deaa0c4fa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
X-Rspamd-Queue-Id: 064A74C2AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19949-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Gal Pressman <gal@nvidia.com>

Report TX csum_none statistic via the netdev queue stats API by mapping
the existing csum_none counter to the csum_none field.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a8b55af21ec0..6fc354a7c5c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5527,6 +5527,8 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	stats->hw_gso_packets =
 		sq_stats->tso_packets + sq_stats->tso_inner_packets;
 	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
+
+	stats->csum_none = sq_stats->csum_none;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5577,6 +5579,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 	tx->bytes = 0;
 	tx->hw_gso_packets = 0;
 	tx->hw_gso_bytes = 0;
+	tx->csum_none = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5607,6 +5610,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 					      sq_stats->tso_inner_packets;
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
+			tx->csum_none += sq_stats->csum_none;
 		}
 	}
 
@@ -5629,6 +5633,7 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 					      sq_stats->tso_inner_packets;
 			tx->hw_gso_bytes += sq_stats->tso_bytes +
 					    sq_stats->tso_inner_bytes;
+			tx->csum_none += sq_stats->csum_none;
 		}
 	}
 }
-- 
2.44.0


