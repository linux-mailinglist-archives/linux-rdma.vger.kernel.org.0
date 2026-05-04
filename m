Return-Path: <linux-rdma+bounces-19948-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEbgKc/n+Gmt2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19948-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:39:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F934C2AD2
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6BF530106BB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2F3E8695;
	Mon,  4 May 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tiRE1cpJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687753E6DD9;
	Mon,  4 May 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919906; cv=fail; b=dCMLaWC3glLzpf2v9CdnMsmbXG4T16GpYCf2JxhtvX9d26nK7GI0kc2OAZGY7ffbnfnEtbGTV77GKV1IN4HaTsn1RPxvGaZvV47v3biIFHgmDkyR+CcPs94cl7ffFZV6QDyWIyX9qX7KdS68J23nE1XmNmu2x4070JaSBoHaPdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919906; c=relaxed/simple;
	bh=6UuvJrw6mp6M+4M1sg3/gXOchiP44V0INPgLTosKlOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPwCDptMmjHDr1xlq01FQtJrzbyMpro1j04rUkWT5+yCMq8EbXjoS3NLg8Qk1mUPDl9+9iif2fQiPPXasf2gXlr1RAQJWYNCXGC1tJ7d1Z48j8eOesJ0oYiGAUmG02g+QHCB6FZDWdzi1eLZEK6ZN8SuhiaI1lBvr4uUhJQTEew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tiRE1cpJ; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpMwN0rTQGdHubPF8GEiEp5+qefmXMLO8XP8ufLudzlHIKNhJmn+ITIujWacVqUjBeKuFpMW2hYN8Pud7+2O1ZqMhEjtTMThtPDHn9WGd85NvzITimgRQOA/IfDmshCv72FcPc+IwSebksWXBvht/KOdKfuWRkmK4k7pRQ5wEzODfGctOnco5qEXlyd5y+wm44HRMoms56idHear93QLkSyIe3Iy/QrlbfZapuBH/SX2QWeVyh50KQfQ8NfZQvN1YddpMXOF8iT4g9NjKLf+vr8vI9SN9tEUOrOx1yjb+cFLLA5f4jCZLOsj2Z7MAqf4igxistuPF14ji3byZTJu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qashn//pzEbd26uw8dZr53hnsF3E/GGHgyAWtQDhHo=;
 b=LIGMsp+3tMga6vxTcMFwsuhiVSYaMxfolRI22ODTCYRgwOSNvYfI42NZcso53Mwy9mJcZ/JonYO/ZO77hP8VAtw+JESerLwaQK2IJWu4534EdumcTIykN8nqGaF4i4VBtPbY0NL1T+jzXFcQOclHeiDjuo3zIkUhNoR9pwPxpd5xZ2QU6sXN8pkGfn0WBZ6HYQqTILsxAlDPh+La1YogcIUl4QrlBHASELeGcOA4yQFshYLNB4jFr8r/FTBlihen97uLMdD8Y7nnyFrLtrdOAop6fj136Jhng+rB5CziJzU4RsxZTBQHbehHaqa9r2P9SYZ5+XSQCBioL53FQmTL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qashn//pzEbd26uw8dZr53hnsF3E/GGHgyAWtQDhHo=;
 b=tiRE1cpJX94G/GJm2FygsORDjtWhyUEYa+KtXXNB5YNq0EqZSb1Ky+bq2jjG0tzc0G790oz32VqCJwP/yIJugMYAAoePJhSDM43NCGE2jSEjhKGumoWFpzKWpojtxomZe2UkMQ80I0GSZvS7fBgiBtuenh4riQRj0AL+TGjEKyNihPJQxZwqvG1l9SmIoMJiwwO0fe+glZLZVNTwkAERN2j0joTEw5SnuscZo6bJRYUfg4FgpfdKuGOqamS1//LIY1PV83PEqi3RsXxgyWUSCCeayIDpHhN3ogmz2sOXjLftsZQmdcKEpG0UjQJjeJM2q8/luvTKIj85aHxrEmLmww==
Received: from DS7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::12) by
 MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:12 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::e7) by DS7P222CA0019.outlook.office365.com
 (2603:10b6:8:2e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 18:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:37:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V3 2/5] net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
Date: Mon, 4 May 2026 21:37:01 +0300
Message-ID: <20260504183704.272322-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: fd350fa6-cdc5-419d-7bc2-08deaa0c4be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DfmjqchXoa4qvtwPv/1/EgniM23GXnxtI7Fb8abuLylR73VZsXrVpcbCYGXBLlAwUAxs3uLdzcmuvyi4eEDVK7zLhoP/ay2NXEiDC8JgeN7mcZ1xZ0SA35QPtD4oA+fej2IVa+M0/HZcD5DfOd8XhlF21cxTu4iBBTbUWkn2sDnxGwdEVXoqIhzGf7817mwKknHHQXwKqwGbHwvuI2HYDqljP6eZsUE8/DSkeZkXjpwaFTJPmU30yStrwXqgZhAqu4R6YWrr7y21uR1Kp5RuISFROw20vq+x2fxvwMgRR+m/mwzd2hsOWD4J77PpFurMdEOgs09l3Pc6+M4ELDwtQAJM7VaEWwyP7GJzi0DT95qY3ZZwSn9YaNEwGHnf7Q2NbzfVORzv0LD5u8+pbFCRGI7OlE75mLUUAgv74pP0uLu85FrbXYbGUO3TBy6aBv/fP5/0rG1E0KUN9zX6GWRi8764bwKgoVWfheqOkvm1JH7DoESslOgDivNTapEtGs2BGZgvr5GRGXLYFarYpBj1sWcqNGMJWMvSp6piP4Lwffk7WuM7DBaNHkywM3hiV5HdFxk/p8GCu4JLPnGShdTdFDVpLNGbD4jCEH9GDwMQxM8SZPZcNAuvPNwNILpEXhEuEohFfOIUGopUBlUd/XH2zBKbxMTjbYX8qNxLrUjSeEa8CZEnV97qEQwWC6NDYEARkKG5Q8WbOeMZLC6T21zlzvGjkE4xO/vPZXGg8sQC7GM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SQ7RZRGzmzdNZD3Ax2DJHeCmwm+DPGycqFghN5hdGLAM+zyohVWva0UWIE/YycWdkhPhl6PWDpFoHCJTVkOsOC1culI39N30s7nRed1eSjcfO9kBllCKYe3Lu096+SxSdE7iMgJv02ww2dEWBqT2H9/rIHo6sflQsHQnDOxh2V4+89PnMU+KB0DC5BhY8bcuYUNIP8lVMo2dps58tjfiQUIMx71YsNEGPISuS71VpjhbkNkN+4iZIrWm8vOdMYOotLHDNMsGLnveimyfn8f8b1UfaBDMTIOw/A8ZWQ5zSiUi7Prpqg52SL1XFR6NjkHJb2yvqnRyLKK0iZ5g2U/kp7YNKZfXOwLClR5JUnCsxzkCgt09hMCoW8FOBV74UVkEhflbBg9Kej4sYVKWW+494f/qQuiEXyHNoxCp+r/nSVDiccJWTmHOsJYzqmGxppIO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:12.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd350fa6-cdc5-419d-7bc2-08deaa0c4be8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
X-Rspamd-Queue-Id: D9F934C2AD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19948-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Gal Pressman <gal@nvidia.com>

Report hardware GSO statistics via the netdev queue stats API by mapping
the existing TSO counters to hw_gso_packets and hw_gso_bytes fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..f3a936d5a62d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5518,6 +5518,10 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	sq_stats = priv->txq2sq_stats[i];
 	stats->packets = sq_stats->packets;
 	stats->bytes = sq_stats->bytes;
+
+	stats->hw_gso_packets =
+		sq_stats->tso_packets + sq_stats->tso_inner_packets;
+	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5557,6 +5561,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 	tx->packets = 0;
 	tx->bytes = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_bytes = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5583,6 +5589,10 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			tx->packets += sq_stats->packets;
 			tx->bytes += sq_stats->bytes;
+			tx->hw_gso_packets += sq_stats->tso_packets +
+					      sq_stats->tso_inner_packets;
+			tx->hw_gso_bytes += sq_stats->tso_bytes +
+					    sq_stats->tso_inner_bytes;
 		}
 	}
 
@@ -5601,6 +5611,10 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			tx->packets += sq_stats->packets;
 			tx->bytes   += sq_stats->bytes;
+			tx->hw_gso_packets += sq_stats->tso_packets +
+					      sq_stats->tso_inner_packets;
+			tx->hw_gso_bytes += sq_stats->tso_bytes +
+					    sq_stats->tso_inner_bytes;
 		}
 	}
 }
-- 
2.44.0


