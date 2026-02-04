Return-Path: <linux-rdma+bounces-16544-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA2yKoefg2kLqQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16544-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:35:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED15EC1B3
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8080E304C069
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8013D646D;
	Wed,  4 Feb 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYT+p7vr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE822DB79D;
	Wed,  4 Feb 2026 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233657; cv=fail; b=KVAo3Wc8KIaQbYp9nPxnK35z7vyvUdKZeubQOjOWJygWgecvVyKJLjzqYKmXgSGCNlX8PDu5DckDwe121i4oqzjBYMX8qWAxYU2fcqC/ajhWw6sxB+NEOSxQClo8XpM0MZ83m+fZ2FhBOP/4Zf+H8H5Ijm5PCIUg41CUvLWYbB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233657; c=relaxed/simple;
	bh=kRwjLK4Fhl/af52oDNhVqwyjR2AeSBPg8pRVb2DeCVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOEPUGmKxW8XKPKvsRW6j0cHT+FenrrEonNMt8dLQ/5rvRHVSGEOMO3x1jgvMSzUV4lBrDrHEvEs1TS13hDd3Ol3iZUzGul1xz3OIBfktWBppDejJKOahun+M5Xf5ik60URbdnj/OEtXPjK4be1nSFkQEw4uliBkOWQppUANibc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYT+p7vr; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAeepFjQ3YCvB8erjGQM/NxaSsAXOD7vheVVo/NE4u/Ivj8yvHCLM3cWCjMXGZRgWxH4Iv5Sq05RZh70l6XqayOcqLJvvUSH1u2rdqJTDq9eBcQjYoTvdqYCiWnlbi2RXyZfUyxvLDjZ1H++e7ugekluVZ9hJweUw7ul0cTqd8vSOJTi6d88AQFngj9F5VOZKx+ucZYZaLsj/erAi5ShaDW4jB4mUtZPkE6XiHET9eJW/srwRyAn/fLwWF0J5HoZ14l85DWeMytWJWkk09JuKb9bQmslL/HdN7GLTBuL9j2c6ifeZx4khlU+3d2qs4gDNoUwSeYqaeFCUGvRqKim5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peilcF4F0YWwZYJTLPbBS9j4oswPE4lmeBg5npqO0F8=;
 b=SRg+jwykVj7jcnXjuct0ZjXOwqmj2Z5kssqS4lfgWydVflPsba8lhkFsiUmCaaxnhv6mbEqve/MJqp4khyqcaer7lMMOyezTHwFX+wNPZjO/Bq/wAnb50p0PI+H/YKI5n5RZ1kaRnfNGAPqkp/Vvx0DbcaZVl+x9X/SOW1VZo+mAdY32tfoIWTCwfDMTQWLCZIC/KJXWzwrFNBANFoqTZgx3gyYk9f7YE3NHq2YkoxG0k1V0fXZ6mMqFXIcd8CqapSG1dGlU5kNN9Wm7G4Up5Ql2QsxeOIsly1n5jAOOt7aarPdYrEJnxfuAM7YFAlXLAQ3gHbcZ21WXbqYvriNh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peilcF4F0YWwZYJTLPbBS9j4oswPE4lmeBg5npqO0F8=;
 b=mYT+p7vrp3LjKT5iQtNF6FbsS0Uxz9oXz57eKTpHQkGDxq4JdIwLSNnekrAu3BMJr6FvCm2IXRikAJx49eel8A8q/LPC1ph9yM43CY5TvI+CD53d3QWFry7jKOG+Z2rsIYPluqXpUNugqtQ/UcmzFEWut068ZbDWcwWaqXF8QG7l03J6qIfa69Q7Jet7t/yAhWjXDHwets6nNJ9KQEhKIG43GAYE6A8+jRZZIlQxymEPhfOt7H2Y3ID0gHldb4BI1HT8yqFsmdmqZ0xCgB6Ml7IgFRwUq65vJfMupu9KiwaWAF57H2qMxSylo5PSEKsnFqUjPdYoKBgLbf0yMx6HVg==
Received: from SN7PR04CA0116.namprd04.prod.outlook.com (2603:10b6:806:122::31)
 by MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 4 Feb
 2026 19:34:13 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::cb) by SN7PR04CA0116.outlook.office365.com
 (2603:10b6:806:122::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 19:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:34:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:47 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:33:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5e: Report hw_gro_packets and hw_gro_bytes netdev stats
Date: Wed, 4 Feb 2026 21:33:12 +0200
Message-ID: <20260204193315.1722983-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260204193315.1722983-1-tariqt@nvidia.com>
References: <20260204193315.1722983-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW4PR12MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e41021-fe0d-4c0f-7906-08de64246026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7MqUrVstmbSf+CCFVdu2ScqUhn8mZabdXSsKapXdOFM3XgNKM8jncgXruqT8?=
 =?us-ascii?Q?fkdXd23cqemGeUkmdI/t20SbI4bsQTov/YdgGueuObQ1WO/CwtkJwL/TwSat?=
 =?us-ascii?Q?mc14N8ZNV1U4eX5HtB+PhccvDDwmrI3gkxNaY4xcSJSZHeLByR77SrftPfbX?=
 =?us-ascii?Q?s93rKj9Js3WTgiDFGmvowRn7jolcg6Z/8jMqw/AzROeR1uLrSzJ5IDoDbOSS?=
 =?us-ascii?Q?9xPckU/msuxq2iEkL/7sx21aWgbgjVGgdH5rhoV2Zcru+3HkxZMSGOPiPnbh?=
 =?us-ascii?Q?fky8/QvDntUBDdmghyprLg5LMyQWgZU1FcCG6Nf9nQKyc4kau0GjDUGmSYgN?=
 =?us-ascii?Q?DjiqpCgFfVN295mOnFmXH8K6w9vF4BFd/8/Zyy4XqTwz4flMoEdMeh1Qr4XU?=
 =?us-ascii?Q?RNFlq1Lg/VX82XNkz3peM/CMGVCCPD4pvBPd6AOMkY2Iu2koNT//NsxJetnB?=
 =?us-ascii?Q?bwb/gsB7NmkVPTunIqj1sGJW7JxAv/h/WUia1V4EpVtZRv+L9ec82Hejb2uz?=
 =?us-ascii?Q?lFslOxwvNF3R1Ig660Fio82dRNHKqVs+KRnH1QUKO1ryvm1Tdo6eosmhj2Js?=
 =?us-ascii?Q?EIQXBWvrMB9dT6QGxUndXEmnDwV8nBYk2QBQN4cRoN1gA3IEZWIhgtir5SUz?=
 =?us-ascii?Q?PoEXOEGr7HpsbuLYmHjLX2s9l0a5nYr6tsGQMc9ZqE27GnGgVXW1msBucN1p?=
 =?us-ascii?Q?uxBpI6TnIQnIlMiZ6TToqhJ10G6uOBWl2yeKP8Cvbg+QNVuvzEt1NcAnyoqc?=
 =?us-ascii?Q?ILoqr0mYKfx1WGGZKcNcNtpDsJBUpdBnnhdYAzP41OIRpDrAjNS76tNpZg+/?=
 =?us-ascii?Q?yo7nsaZQvpkuxl4LhJh4NRak0XWvmPk3DJM1/c5gd2lp17OD41q4H7ApJgek?=
 =?us-ascii?Q?fWqqAouoNdE+8BdBMpDP2mJduC7NFsq+c6crycvLRoJPTSHHMVNuZTCEDgXC?=
 =?us-ascii?Q?r7/e+OWvpbQaLUI9x3l9Mps9a7giq+EWP0V3PoXLB+tLOcIQ7qEzy9qWzWHX?=
 =?us-ascii?Q?i5WFLxfHTG1TZkjH+/HZslv4udMOGI8YJCt97GPeIq5G7G4KdLS7UlDLuA0C?=
 =?us-ascii?Q?M+MXbhrElexRswpTK2sU4ly48YbvdpV8IYncI1pRLk+anLcXBLOkbbViCyGw?=
 =?us-ascii?Q?De9RAkbKp5JorggJN7saiDFBgu2c94ocdih8ApybH8rLrCNP6np0kDNzMRrj?=
 =?us-ascii?Q?ydW7w2BG/Ahide6UMBpm4/dAbIrw2GzPQqUGCmYqswU1OJh+pak4owQ2rC/j?=
 =?us-ascii?Q?wGjvo/jPjR0aOK03XTUpcYaOP4Y3pAMMy0UUr28zP/pL83OJyW+KKLNPHZnh?=
 =?us-ascii?Q?Qo/QpUxN8PbIXI2P+HpBrd7GK+EqdBz5ke1r8iv+ZacUs3BnMhH2gQi0G76Y?=
 =?us-ascii?Q?ehzxD5pOgab0qS1UyPU2vNZ7rqQGyxEhX8FfzK128Rl7DsBEtjqVcNWpaMHZ?=
 =?us-ascii?Q?HenhDN5j+yMJUW1JoOQBWPlbOn0OJYjsATuUxEXgSA6bye3ye/6P6R69NdiU?=
 =?us-ascii?Q?TXTVTxpYiPrp9s6hWIr3Ww2PZ0HbNYdXm2uOlR6YpABGP1tcskRYvvfkzKHG?=
 =?us-ascii?Q?H8VVMrGq9XKJ8mulAoUhWdCc4k/VjpFmQNihb5q8Ym0EADV+g30xtKXYsQCj?=
 =?us-ascii?Q?nQrNI/qjSCjW1+HftMRD7vOkWsvAfE87wsVJi6aygeLBiwIejwK2d5iEKxwN?=
 =?us-ascii?Q?z8K5/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BLaZtInX9jb0IFszal/HLOjIIGEjhO+asm44maVRSzgi95g+qCKaimhrgTaFvJGvZJKtoXdR/zZ9KlaEaTlq3HScCcdoGAzl7uiaPmpI0I9PCzPPJuUDQfZdlvqz0xSWk7h6hhHU6vhiWTKMO/fxzUiD6WdrbXSERnp8fCWwAHnTPBsHq5BPf1WSUp9+2ibykw6bC03c/cdMRw3Be6DhVsjs4i0TgSj/R5Z1R2EqehvTt7zdcWbQvce4V44enAhrwRSc20H1foUf7TKbsvxUxAlxhwKD9gpFyr7aR7Z1XI1CECZkIzBJo+vn7J53iKHsoG/ZQECJDr8FllLOV8K8Nrz/PWZUx/Db/V5S3DNhhx6qV2TWA5wwmyUtv3ehLPkWqOy1F09DShv8PgzFcE/OUtYKftf9bN7X0nB+zY4OrlYz8nGqQvts+jHM6SQYA/rq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:34:12.6427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e41021-fe0d-4c0f-7906-08de64246026
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6997
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
	TAGGED_FROM(0.00)[bounces-16544-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1ED15EC1B3
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

Report RX hardware GRO statistics via the netdev queue stats API by
mapping the existing gro_packets and gro_bytes counters to the
hw_gro_packets and hw_gro_bytes fields.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 0e955568c2f4..774a2e32d5f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5532,6 +5532,10 @@ static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
 	stats->alloc_fail = rq_stats->buff_alloc_err +
 			    xskrq_stats->buff_alloc_err;
+
+	stats->hw_gro_packets =
+		rq_stats->gro_packets + xskrq_stats->gro_packets;
+	stats->hw_gro_bytes = rq_stats->gro_bytes + xskrq_stats->gro_bytes;
 }
 
 static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
@@ -5568,6 +5572,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 		rx->packets = 0;
 		rx->bytes = 0;
 		rx->alloc_fail = 0;
+		rx->hw_gro_packets = 0;
+		rx->hw_gro_bytes = 0;
 
 		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
 			struct netdev_queue_stats_rx rx_i = {0};
@@ -5577,6 +5583,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 			rx->packets += rx_i.packets;
 			rx->bytes += rx_i.bytes;
 			rx->alloc_fail += rx_i.alloc_fail;
+			rx->hw_gro_packets += rx_i.hw_gro_packets;
+			rx->hw_gro_bytes += rx_i.hw_gro_bytes;
 		}
 
 		/* always report PTP RX stats from base as there is no
@@ -5588,6 +5596,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			rx->packets += rq_stats->packets;
 			rx->bytes += rq_stats->bytes;
+			rx->hw_gro_packets += rq_stats->gro_packets;
+			rx->hw_gro_bytes += rq_stats->gro_bytes;
 		}
 	}
 
-- 
2.44.0


