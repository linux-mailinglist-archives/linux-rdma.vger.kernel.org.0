Return-Path: <linux-rdma+bounces-17767-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH98ADearmmqGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17767-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 11:00:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632F236ABE
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 490DD309CCA2
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3028387583;
	Mon,  9 Mar 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U74HMFOz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411B38734E;
	Mon,  9 Mar 2026 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050157; cv=fail; b=BCu0Vat+a+6yBKS/q9sv0OnYEz5nEL6KCFNfTh74K5vqjxgOa3YK8EYBGa38RbxfkET0RVgb5Ljo7UA0+zzio3LIXhzLSika+d3VFOd/2qJXw0vq4MIwFIeaiB3aO+LMtorU1ZMUyekXdsHw23/WBRFjGwqeSiwlgm8w0jK4yi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050157; c=relaxed/simple;
	bh=HIEYWZEHhQVKBxVIU07at3ZcPmW7eAFIWdkMEdzpFWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvK97KeSpNimRIb68tKMGN1Qh2ljxVyJiWrKAEBce/ah4OyOSjEIrXjr9dYQjWzcKFrrOhMJGYI4/XDVABOPxWEAuxHtDvpijfNs5o0uny8bvmT/jB4NNq1vpixxvhuMU3iqkuHoBWarB+vUn2Y2O2ys/35HOO8bRjfMpRgu+zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U74HMFOz; arc=fail smtp.client-ip=52.101.48.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKeFhzNGDJDCrPrg4OTZslk3xSQPCXzk7FAIsgvcSDFakIfxVwWXTH37i/kqFob7Eq3flfvqeegXvvP5P0U9na8lBaCl9xE0umOoumZFLrMYYqNzjG/4x8r0CG6RoDQVyLUKgBdIQcuvKAef6ymNPtonsIhiIsB6d+LvZk63anSr5QCKDqGwh72hTZKYWFOrOsvLep2EpvNkOnYXtMDbNrxxTaPn/sgu4IQv9qCGcEQjiTgCf1vScO/nfu4ZG0fj/rPzEXYAygyIGOJj5m/qc0RhI62w9xJWY85D9MHSA7GvLaMN3ILDRkPOK5fyaItHoBIK871IDO/eSKBpLfV/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT4uDCTIHcewiuy+FYELOfAmTwGS5srozM7UAIyA+GQ=;
 b=ghNnRwQoKtdwQm1FhhCOSs2kUlVfo0nUhgJE10woto30qa1tuMGqfvy1ClR7iOQ216Recbo8SMp7ot2F80IQwKmjVbEv/yOSHc8i3BPn9cjem25e2Ngf8g8UPQ+bIJd779sL+wrC4CgeA0DcWH0sHewwo0kv12CzT+nXKIcJn5K4lrAc7r19Wll4MfvlmbHxs3NQEvZCvD/LoYdvQzTf+XTYou3+FwiyV/Gp+WPhBCn8PCd5Sdmmn5X5yZz8K6RvIS5bzXYKl956BTIccVVFlQk+Dfq5tvUMw94HV1oW5/x2jjk7oEQQy3vi1VN8KpeGMZcZ6wGnUtdzbAjRA4Jg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT4uDCTIHcewiuy+FYELOfAmTwGS5srozM7UAIyA+GQ=;
 b=U74HMFOzY41M8pdEIkxxS5g1GJ8I/GXSJs3qojnerVQaKNd9dH/k1/ZNFo3tEQHRSla1S6a7+/w8k+jhoezL17noGArt1Ahbx6VPQwYv4TY0bvM227g7uDdoJI0GgzTyzJE7+g01n/LwhHVGbiJrWsD0mKnsDSf1JQF2/lmIiNQ4eXIlrK37sl2llrsxsoUgp4h1gbibdeTQpWSMNPaIufIxu6aP91tqCqWfoJJvwOl2LZIIyheH5udshJTLP6/CNvVVFDSK/NFcLE2LnxyFylgNFRDjuLJ82DWLfDx0v/6G3sGwluedr+N915JMkMfhiki58St25hkM3VjPlS56TQ==
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 09:55:53 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::52) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:55:53 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 02:55:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 2/5] net/mlx5e: Report RX HW-GRO netdev stats
Date: Mon, 9 Mar 2026 11:55:16 +0200
Message-ID: <20260309095519.1854805-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309095519.1854805-1-tariqt@nvidia.com>
References: <20260309095519.1854805-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad4f8ac-8162-4281-25ad-08de7dc20d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	N9VLrk4SukAdhRtIrcQ5qzH8U8FPbjV84mhaGh8MVIUr/zYIxHjZAdVU2O0OjERiVPoFtS5lo/PwP1JmrVSwp4aKN+bk5OrY6Mg1gYBs/NXwFsJlYy+gqjEZrb0DYG1L8gavhEDuTZADn211QaVBl8+JTrXKECCV3fq9C+ZAHY5BmoN7IGMGiIu9zsHDWYnUYlaY6NGetkCMkD+KNQ/KMis7XxWgGXuggyuaBoY28OxV3YxKY+Ud+sSgC7I1FWI+aLvBApedNLMWHvF4fOpd58+kmj2YyrFunS6ujgZNefrEfAbp97ueLQIN8KLJWayt/bCCfDhTQi30vxwH3boiUcwxj4+vsPCYeagjH1Yo3vOAAThaoyruXlAOo0I8FcyeZc3FhCZl+gukn5563TYrjvGWmBK705nkOoVuYZzFMcbN3ca0slBAtEVffzE2iA9sa40JQApjMSXUv3GrAwMwYbiB3xcWemXDqTY0Oi9zOODeFg2JZhsDVdGFmmUS84m4Xd0NmBk3rWFC5jfRcL9YuMnDjz9asn0GaSk4R8ebBNFtEAKv6RraRuwc2cmiCh/TqBiKFf7hvOAucZBovj5TSZz0CCLCcPcI1NR/1ztZu3hk1BXh9Iz/eiIIFv2fYsEZhdtGSYGmmaH9wBLwpfQRuDEa7+CYBnoyNt5IYKNkEjKPqmMCA2GVWd0N1TsFh4BsG731RQ7/1FY5ziVacRn9hDi6/J7vsDsElvDusRHEYU142ohTRx4VRrKL5WSEvAhoWgmacHpgMBlHA7p0DZOUrQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qzvNbeDTvyyNyZUhzOUO9JDarsCxsrQ/pwRTjk+urI7HutN98tNgeG8fqxFjcB2s80Yiizydo5WS929X5ZJwBzBY+61O76nTxHaX/beLpKY5McLlmZH7uAugfwrQJ7FTxAPxzYRiua4YJHbZnizT0N6WREKkPG04oPFw+lU8CLeF7hU43a1sqMQSXJz6ecrqYejc7W5Y3625RH7fc3TvVdu9Q7cfq/teLUuqADZ5S+9kH8lqTIf5sLN4Xzsxu4IZDjITx2oHhvxTFZ+uxMJ4IeuOmnbrm1DH7jOE20HOoqy/+zDYZG9Xx/K+aQPefsfQniPAYCf0qUC1DoV0icsSPg+B7PqgWDMQcBeInxcOBMGl9KnD/V+6pUm0L0odIWDhKGrd8o//mFEXlQdprajsGmVJI1EywDzOHxYkOBGcFjbqjRPeD7oYzmmmvKKX/z5f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:55:53.0864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad4f8ac-8162-4281-25ad-08de7dc20d2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
X-Rspamd-Queue-Id: 7632F236ABE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17767-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report RX hardware GRO statistics via the netdev queue stats API by
mapping the existing gro_packets, gro_bytes and gro_skbs counters to the
hw_gro_wire_packets, hw_gro_wire_bytes and hw_gro_packets fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3e934e269139..f20fec154d47 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5461,6 +5461,11 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
 	stats->alloc_fail = rq_stats->buff_alloc_err +
 			    xskrq_stats->buff_alloc_err;
+
+	stats->hw_gro_packets = rq_stats->gro_skbs + xskrq_stats->gro_skbs;
+	stats->hw_gro_wire_packets =
+		rq_stats->gro_packets + xskrq_stats->gro_packets;
+	stats->hw_gro_wire_bytes = rq_stats->gro_bytes + xskrq_stats->gro_bytes;
 }
 
 static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
@@ -5497,6 +5502,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->packets = 0;
 		rx->bytes = 0;
 		rx->alloc_fail = 0;
+		rx->hw_gro_packets = 0;
+		rx->hw_gro_wire_packets = 0;
+		rx->hw_gro_wire_bytes = 0;
 
 		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
@@ -5506,6 +5514,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->packets += rx_i.packets;
 			rx->bytes += rx_i.bytes;
 			rx->alloc_fail += rx_i.alloc_fail;
+			rx->hw_gro_packets += rx_i.hw_gro_packets;
+			rx->hw_gro_wire_packets += rx_i.hw_gro_wire_packets;
+			rx->hw_gro_wire_bytes += rx_i.hw_gro_wire_bytes;
 		}
 
 		/* always report PTP RX stats from base as there is no
@@ -5517,6 +5528,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			rx->packets += rq_stats->packets;
 			rx->bytes += rq_stats->bytes;
+			rx->hw_gro_packets += rq_stats->gro_skbs;
+			rx->hw_gro_wire_packets += rq_stats->gro_packets;
+			rx->hw_gro_wire_bytes += rq_stats->gro_bytes;
 		}
 	}
 
-- 
2.44.0


