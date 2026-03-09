Return-Path: <linux-rdma+bounces-17769-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CFbFYmarmmqGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17769-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 11:01:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6105F236AD9
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6943430D6D2B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1F938757F;
	Mon,  9 Mar 2026 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WVi5Ktqp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD207385501;
	Mon,  9 Mar 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050174; cv=fail; b=iN+weV+GbCo9T2/nOWm8tdzMUs/35ywx2E72yzhYKTjvDMDmlIZ0hxmOorS8cQSphNeu1LPCxWJt3o9wMqD5Wck0Kqp3/RIzkNfBN1+FNC3qstZ+wZ+hM+siPeTzVz8Ao8rBTSoZ6jNPlKRwpe/upcfhQTsoh7fel+tPARl+6wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050174; c=relaxed/simple;
	bh=8YWW5xakUrHaxQgqV2/3G1CYUTcVK14ph68gAigOtIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA1ar22HQ/2ehoDNQUG9QQqxPSvUZ8DvKyWeAoD0rbIrsEUxUylpdM8+CQ6rvREq9nANqVnv9IZn93AU8kdUQcMkbPAHZ5cROdaRI8oSzZ+VEE7/9hMiyNp5VeAxkhHhDIMK3OTqFfnbTJL/uY9y+wROPvL8lHaPI/paGsib/zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WVi5Ktqp; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCBEd4RcMZB7gFtJOsr+YOkcEti0OBRa6ONI7B2uZ1KujT8icGOs4tckUN1MRTOvUiOYLPWSmMH9IEpbaAiFNMQjiiFSb+yttWX00lYz5zbAhldu4HinIzq4NKkCIm5ZJkOcJfbfOH6voipIpI8KNMUHnuKBuMwAzz/YmCbVNs6ienQP9ByP1KUbZXGbBatrSxwgiZSPN4yA8YmX02YxxK4RHfQugmbcQMMsvrQUhs5rd1cFizmEy1SlcPBUzCSYQpamHxnXBzNfnwvTww9Z+d/uBHqsjzy0WDM4E+c2d6atIqm451dPla6KB5rTp7PXWP8wjNI0cUis7b63FwdjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bkzFhGP4QmMgpLepEGHtaX9D91+9xvbziE4x9wtf2A=;
 b=UhSVgoK8yKUJ7EoqfZsRw/NxNR04dgCbf7gL+4FDyfYmlPFGGEtYkg6RzIKPQTSeUbuYtm0A9qASUIiTAEC81gJ6g83akAolgNx9kKAKhYxbvuJQqGjqXH00ULfHBoqMUGQ8fT59d4l+MBOnzJVhDPyEUV1qAeEwG1jtCYldwo6iuaMbgw7JU+AdduZfvJpLWGqCT/CcczA2de4g6NnWZNEH4+9o2akYGWEmJQqIMjkgEgJr2TcsAYbHG1V3FpnsPsFdPSkhETitKgZONszctLZ9gqkAibCdK6AWj1ylrwHsuCGNUTiXst380JnqT2KOAnws82BpTsd/P8K21s0IzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bkzFhGP4QmMgpLepEGHtaX9D91+9xvbziE4x9wtf2A=;
 b=WVi5KtqpgFQO7KNXAncuKB7jF4TSHjDGcEWPyj90AkBgDPtcQOENquSXNOiGa6pByBxFiO23PK/N8gMoITnx1vymK9F05Cw+MF9clh1rj+ec/FFd0dNbhAr8zqMTcwy2NQG/AL4ExNERsCHt6MbwzhOdhEEBeOdjzJJrnuhOR2m5VIfrWr1httNAkL0txPnHHNU0Kgiv8+EZ1Dx9+E4yTJpfxvN8EzRU1BW9XncA73j9ReY/bmQuwpLufKsVKoK4YlCCT7vPHkMiezgewWoXdxrTOlujdBdBgZ6JxCK1J8vEsYmo6LP68JuyCxTMkxnDcq9RGc9BJ31HHb169TkSTQ==
Received: from SA0PR11CA0208.namprd11.prod.outlook.com (2603:10b6:806:1bc::33)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:56:05 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::3d) by SA0PR11CA0208.outlook.office365.com
 (2603:10b6:806:1bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:56:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:55:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 9 Mar
 2026 02:55:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V2 4/5] net/mlx5e: Report RX csum netdev stats
Date: Mon, 9 Mar 2026 11:55:18 +0200
Message-ID: <20260309095519.1854805-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc49e7b-cde3-4379-2d5a-08de7dc21471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	Jl5JoHGsBY9dDDVixS+OGbVGd5s3fYzzGnh9jhGbsrRfoCw5Q9edOLfx+cMwZPnh8a62PsXhB81/bgjbW9q0VLHxoCUZTBrznqqkLoILqiYaK7MCf0qwrv1TN7J5G4MaRZIHPVPdxbJ2Ncw31vzcm8T7AnC78tafaaJZ5FYH0AU4eC2IYYRseyoIYixkEzOpql7RLkNi8BxivsMjeE2Yoz0ZiG1sV38R/M1JbHZoEnGAI/zzGQ6WdIs1T45gIqY3WWrELbvTcIkOvJ0Q71DHpTpEVGKlT64E8Ey8aFBvwT4kV7pUQ38s1p/e4p/rcByNytKDGZ8QbT7T9DsgcLWZFjgjtk0JbdRmHo4rw33GQml39XEBVmCPMN//7tw3cHtOXC2Q0tAm/UmKddbD7eI60BjE9q1yB8TdozgKMJ1Pdgin0LKevNdnhEAdZ5rIzqNaX+D/87jc32wpW6KGoFzngUDuRhkZ4aex6hb2I4w4kIAjj4asFqfvNWPwU6rEKOfrBJzgSY2NtAHU6GnrTbo3tWlbe6G5N5O7LNXHwFoN18AUbXXZHgLzvS5FnBpqTHOqVBgidc2BK7KHv8+rjMlgqNu5ON0c10r5p7cvUw/u7hm98VnyqFIPEy7nxvu/2n9JoKRRo55IXhxGfd27hcy3zvrOTF94WnG40BhQnbnP+xBBZfGgPzsbZtFqoibS54AzT6/Q1TII8iB8+gyWZ33LE/ZF6p1s5Kc5UyRbr46zcuO/dICLJkc19/YlS8aRHuoz2lOkuAhJbVVfqL6GCS2I8Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2biQr1DOw3NrsYPFF3GZqgt6A/L2Blod7h6UMKAGVbTZMg3RQVIJwrkMM1gt2Np1XhabWvxHcey5lzdv4D+6oqaLi5Rw1jQevHK1yBhP5kVytv0dEWYb/r1oSUMaxrsG/keQ5C59Vo/SLZM6Q+Ry+jCAD7E7TPZm00STnPLBcPY+4SDe3h4vPz4NnlLJkwUtbSdMR/YaKw31qSFkIDkqNm3vBg8uHc0qKDp6JF6S7i6sv4g6UY5wWF6G/ljisPMViKBOHUGibJC1G/5iE42vMNOnfExjQwZuu37x0xRnKehvFXcazqM2nNcAhkLOhTdnDXodnhqJ2SigiCfzk5izNWIeRwjvB4muiit+uUjyY7iaRJJilGpNv03Xq5pXPCVSHJ6k+FYxodPXmyrx357orEtdJ01U2mbT1VT/OZ/1JXHop6awuEWzYIEjgf0OCrtt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:56:05.1751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc49e7b-cde3-4379-2d5a-08de7dc21471
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
X-Rspamd-Queue-Id: 6105F236AD9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17769-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report RX checksum statistics via the netdev queue stats API by mapping
the existing csum_complete, csum_unnecessary, csum_unnecessary_inner,
and csum_none counters to the csum_complete, csum_unnecessary and
csum_none fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e2f98b1f8636..a03fbf1cb362 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5466,6 +5466,14 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->hw_gro_wire_packets =
 		rq_stats->gro_packets + xskrq_stats->gro_packets;
 	stats->hw_gro_wire_bytes = rq_stats->gro_bytes + xskrq_stats->gro_bytes;
+
+	stats->csum_complete =
+		rq_stats->csum_complete + xskrq_stats->csum_complete;
+	stats->csum_unnecessary = rq_stats->csum_unnecessary +
+				  xskrq_stats->csum_unnecessary +
+				  rq_stats->csum_unnecessary_inner +
+				  xskrq_stats->csum_unnecessary_inner;
+	stats->csum_none = rq_stats->csum_none + xskrq_stats->csum_none;
 }
 
 static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
@@ -5509,6 +5517,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->hw_gro_packets = 0;
 		rx->hw_gro_wire_packets = 0;
 		rx->hw_gro_wire_bytes = 0;
+		rx->csum_complete = 0;
+		rx->csum_unnecessary = 0;
+		rx->csum_none = 0;
 
 		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
@@ -5521,6 +5532,9 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->hw_gro_packets += rx_i.hw_gro_packets;
 			rx->hw_gro_wire_packets += rx_i.hw_gro_wire_packets;
 			rx->hw_gro_wire_bytes += rx_i.hw_gro_wire_bytes;
+			rx->csum_complete += rx_i.csum_complete;
+			rx->csum_unnecessary += rx_i.csum_unnecessary;
+			rx->csum_none += rx_i.csum_none;
 		}
 
 		/* always report PTP RX stats from base as there is no
@@ -5535,6 +5549,11 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->hw_gro_packets += rq_stats->gro_skbs;
 			rx->hw_gro_wire_packets += rq_stats->gro_packets;
 			rx->hw_gro_wire_bytes += rq_stats->gro_bytes;
+			rx->csum_complete += rq_stats->csum_complete;
+			rx->csum_unnecessary +=
+				rq_stats->csum_unnecessary +
+				rq_stats->csum_unnecessary_inner;
+			rx->csum_none += rq_stats->csum_none;
 		}
 	}
 
-- 
2.44.0


