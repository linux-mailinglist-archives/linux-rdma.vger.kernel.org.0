Return-Path: <linux-rdma+bounces-19946-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJd1GqXn+Gmt2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19946-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:38:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F84C2A93
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 20:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 930C93008251
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0C3E5EE0;
	Mon,  4 May 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YX+7xicy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D093E51F2;
	Mon,  4 May 2026 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919904; cv=fail; b=Bw1QrrRsMTWGSaM5tmwqbojeQPXpPhhjTcFe1UwPestNhHvCsXrAakukKJWhBpy6Vtae77z4p9HLI9JP1awmSs+hQ1rTr5SgkjZon5+Byx4LLiJKd+avOojp7vJRujwHpG2dD+dPYyNotsa7CaVoSyznQ0g2mgRBHR4Lvrn+D+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919904; c=relaxed/simple;
	bh=lNnhVpwtE2PfpUvOlJM+HRFa04Jt54OupFxiBV828Lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZhKnzQFiey89OER4Id+DV6vnzmgKw7qTyYNtksYcEa/sf/sDYUYN3oOHsgR2KvatWq+MhPkraYA55fxX2pHw/orNUA2xqe6QM8ocZ5icoYdY7X09mdCDC0LuA7AENDVAJd0/zamKpIZ+xcVnsyY9/hgfbUj1XWx+4X7zAS/QHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YX+7xicy; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=it22zRSPkDx7HmP9y8/GDfR+XH6NfWnbto80tM0Nt1Eu9NbOa4nwLYZ7l9/uh16k361JixKI+n8gpQ7LrPBjzkDuwp0fR8N+xXMdJlQSec5Km6evxQMlji3uDlSy5bO+3HzIste9bTz2D6nqHPt4ylqUC6R9zhPJANKQijFXJwLTjRp3Rr83BEK2UhPY/jO3K9lc8MSAfbwYfxJ8lSiryQzbfNpgs+yveaZZdFclFQeV47LUssDErGbQ1lTtgziVvdokuf4YZh0n/hz8KBINJzYUfuhCCB1e97PHtX552JYbKRz3mLNHpmYbFrcX6IpFp4bRinM+shzcCSIrH1hOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOYFRQzBk4CcrWPNi6zb8z3UbLZ6zMLakrrTgb4yhGQ=;
 b=N9wjeymUNHhVRIIma9OfF2ZwqLr2CjqRYYvt/kqiz5K8kyVhd45E+gruOJ6YOAdwBlm2fgukiZE6ZMV8gbRZ3SZUmzNdYHKqtOKzEpScaqqCA/Usw4DBWzNM4yQQk5WmWRxWwnn+IklwuH8ZwzIdTq6MwzZUHqPC7TTHfa4Ku30XeY+Siz0QUuRFL/IZcEed4Uyk/0v61t2EEWevNEMMO96O27vU/lcTGbMNcUmxDqQfWT03wmko7C/L3rXwJWSYBJkKc7l0PsNrXyTEGFcyjcJd45TYon444Fm6ImOJx8O6TFezvGmIr4j1HZrotf9lH+4fjXVT4qdjqP/wDLoRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOYFRQzBk4CcrWPNi6zb8z3UbLZ6zMLakrrTgb4yhGQ=;
 b=YX+7xicyuIStQGGoYSzTAebcX3KKme16MQWF0UEzOinKuOv3z/sZZEETj4ZjNkGDm17XHEwdH5mLuf35nBUMpO7VnhOp26EME84yZKuds66YovQb0TdSqkLSSJRzb/FkJoN23XUr8owPvQw+HoDDQLnHp1tQXCvfY7tXdAzg4M3wxE7L0eSFtJrg8V8F2xCzNp78SGIzioXCQUZ7UBLRPIv8tR8KQ9MsbVmL3WtZl94deN7QcoPMtMLhT+sjjSSxRQGijdwaql2ZyVLJ29Wfp5Ouw1DGTZCI/x0BLKFJlDws3TYbjLo9TQrz96vEAkD2ponf9wN2zpqAUJF1IeNgBg==
Received: from BL1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:256::9)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 18:38:15 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::55) by BL1PR13CA0004.outlook.office365.com
 (2603:10b6:208:256::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.13 via Frontend Transport; Mon,
 4 May 2026 18:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 18:38:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 11:37:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 4 May
 2026 11:37:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V3 3/5] net/mlx5e: Report RX HW-GRO netdev stats
Date: Mon, 4 May 2026 21:37:02 +0300
Message-ID: <20260504183704.272322-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 45683664-1db1-4f39-dda7-08deaa0c4dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1WWwwKbeGWUD3eNDNlDiHOLhYp6s5ykJlsdLrEV3MplNjk1R7VOYhq2S3Lh+iXTsPJSEnFO9RJLNa9hmGWnHogLhcg7L0TS9unj8mWlBH7GyiU7RkVQx2s72xEMUeOoO+sh016oJFPCQ6RaA9RG77n7uoLpU4klE9STUO8onASnnZEeWqMrbrbVnb5Y9Z2SAjmxe+mkHlgUjUAqlF++h7Dt1wb7GjwXKroZMqSeIuuu+Rop2sxiuu7MXceDjsiuIpKlBdiGL7ZDVM0IXkYwZHP1Yg2mu64f6O5E+eaaGforrnk1xMBOEQjP/poa4qqHchHngBo6mHwEY9OSJZi3snlOE3UeCgOKAHU9g9nM9taSFtoCLOcH0adSJVUwQebkxREZCqf2qj5NTcGLJ52hjntK2fzlC//nQTdxaIsbFaDxAr79Jw4I0CaGI727Ce+NxJPXoSC5O91H8nOybOLtK9xAhQKavb3hvaqpY9px0Yzf++fz/KM0olezxoEQ4aupU/hf6rUrMawIfOBV+43tCNWd2nr6QrShCtVOpArBZSaijgnTxl1VnFAcTMok9sY9zVQI5Ejy39mS/DGk69ACn5uL6S/XRvCjRtVtc9TcyBbDpBZXcXiBQwfgdB03Q3jR6jw/bzI6BlI359e90RhF0ly81HYNMW92YJMPWus6yvkBqD634S/9IE5KXhxg57n19DoPWHAAUCt8bMmWCvQxlkyBVecFeO7ivrD5RMf2d9lQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gUXJewC3hUTUMYRlVsNh0dYny8QX+GmGcvuKp2uesxy91c9UiP9eDVlwYmHamIYauyePnQnt+FTCydbNcmbrlctVZDn0EgDFrmml5STCDSd9oREvFuZrCB4cr13ckMiG9z0KRLbzQasTrpxL7jh/PVOFhczddZRQnbzTZ4LB6Nm7hPfKoLc7nQKeFfsXD6sP7z8fN1joZmZLF0FHUd/nsPYMlM+zCu6+0yCUpjmYAmvjGVED14l3c62ljj+fzPgTQiTQAS3L7O9bBeh/kqwxyPh8kPMeUsYBbBEIqFEdM1xBKs6GZHesmwzZA4LH1fV9+0sOFUwlVTeeI/61MvDQ85y2axeNq+fgT9BKDQSbKNtif1iey6aZVg3OwOxh5zBH5kkkG+d/3XF5QbRCV5QcvYi4StFadEqsZLkSBFvvu5V5Kz2CTeHFLLfRU41cnIix
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 18:38:15.3807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45683664-1db1-4f39-dda7-08deaa0c4dda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
X-Rspamd-Queue-Id: 355F84C2A93
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
	TAGGED_FROM(0.00)[bounces-19946-lists,linux-rdma=lfdr.de];
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

Report RX hardware GRO statistics via the netdev queue stats API by
mapping the existing gro_packets, gro_bytes and gro_skbs counters to the
hw_gro_wire_packets, hw_gro_wire_bytes and hw_gro_packets fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f3a936d5a62d..a8b55af21ec0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5500,6 +5500,11 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
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
@@ -5536,6 +5541,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->packets = 0;
 		rx->bytes = 0;
 		rx->alloc_fail = 0;
+		rx->hw_gro_packets = 0;
+		rx->hw_gro_wire_packets = 0;
+		rx->hw_gro_wire_bytes = 0;
 
 		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
@@ -5545,6 +5553,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->packets += rx_i.packets;
 			rx->bytes += rx_i.bytes;
 			rx->alloc_fail += rx_i.alloc_fail;
+			rx->hw_gro_packets += rx_i.hw_gro_packets;
+			rx->hw_gro_wire_packets += rx_i.hw_gro_wire_packets;
+			rx->hw_gro_wire_bytes += rx_i.hw_gro_wire_bytes;
 		}
 
 		/* always report PTP RX stats from base as there is no
@@ -5556,6 +5567,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			rx->packets += rq_stats->packets;
 			rx->bytes += rq_stats->bytes;
+			rx->hw_gro_packets += rq_stats->gro_skbs;
+			rx->hw_gro_wire_packets += rq_stats->gro_packets;
+			rx->hw_gro_wire_bytes += rq_stats->gro_bytes;
 		}
 	}
 
-- 
2.44.0


