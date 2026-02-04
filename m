Return-Path: <linux-rdma+bounces-16543-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FtdKF+fg2kLqQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16543-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:34:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F589EC184
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400D5303D2FA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA036C5B9;
	Wed,  4 Feb 2026 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DobqcG8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF723D646D;
	Wed,  4 Feb 2026 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233650; cv=fail; b=U/3e7YAMDMGqbruMdloND4ZfUtCDtnYPdCwtAIDz7uneN+qOQDMrYsHI8AdBIJWlY1sxMwa7x9MHFnHjqH5DvwoFHXGEJ6DqhSMeE0wlTWfQb9X5KbU8TJxZvNoOZHl2FqOkDChwIsjHHogfOyPvIVKXsOjSU0+U/60dBVR+yeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233650; c=relaxed/simple;
	bh=yeCyNUs030T6nR9VXiRaXomMw3Prm3LmC2R5yzS553Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chOxfXxZROhEvAfbzCk8dFwodRdWBdKMA/UsAQzP+1TP1UehMVqrLizfilh89XqTEp4QfL1xu8kQ5BR7UWveTXXDqECv7ivo3JY6SALWFvKmySI95c+REyfF0oZ+ZDlXYmPsrMh+skorqY3Tm0jYpGPIDx1062BkGc0PIDENkzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DobqcG8O; arc=fail smtp.client-ip=52.101.61.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e52Y9JX4PfCG8yKQlh6q2UQXAOnKJIDQ6T78KOhmpZ2GqpNKycwypyphd0YArspvnPzdT9Ac519W+333nvV444BVyQpVLq5Zh+QtFNpHvw/igEkLEYq/a7TbMISHt9JX11uVDiRChtMHn7R0T027JjD/uLU4a7UbPlMmOvgX+SreDfJK5b7ErGK9Ia2bnLQggzPn4294MNTF00LsbFO7u0BcA/5urQmdteBPH+xqb4GqoXINPaAOqHP+HET8zp1m1U8UqCnZ25Qju1j3TpKVK0p3QkkNjm9NRxwty1JPgiSQJYng1h+aByuo8/r+DeNcCFeREvK8ObpZRWU/DAptyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAw+RtlXH6c597f9NszviaT6mvLaI15ubdCyFEv1MG8=;
 b=AAHPFfP+muzOsl/bh3TyAwVsvC1D3vyme+ANV/RuV0kJap2H+pZsDnnJNQT6AnQWCavCKN7ZCLwvXtg3QPlx1Lbq0+B8REg7CHYyVzzDzerl9tLLTSyy4sC63ZxmMPa+6w6tHMuAGJP9Xb+NODkuDgdQeN/5BX2FZOWrUaewyQC/fpRnZopcvfLotRSqTwPxKlf+6x8BJqSuv01gcI2oe6SF093Zxm3Gs6ttNt1NJRCuYh5g1iff/WsEjoHNFRcG+8jUgSwvyDmER8x4lkOTDPLI7rqX5K0FtedPzAlS9hlA4a77RyQUxyI/d3naz2eG8Npfl46KJlP7ufS2wQaitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAw+RtlXH6c597f9NszviaT6mvLaI15ubdCyFEv1MG8=;
 b=DobqcG8OYYFbPrwVe9CSHdt08D/fTV+DdIhbcIs6nrAG8g9KCTTyI1iPw5TMW1zfhSIRobq5OvyJjq2/VhjEbblOrQEhqpY4L9bbIsVz3HMYWSu00yIl89X2M6z25t18RqvaUx1yxKfqqt7vc6upYygq710ev7LG4zf9MiL+sT6ScM50TaFPCtIEvp7JEupGuiDJpn1d18gcUuJE6aNFdmiK135oliuH4xxLyhl2Sn0WdSRB0d+BA2mmKtffqStlMw8zFrxfnIVEWMRwZO11GcQZVnSjvWdc1traReb0u5C3nTKPlpAImCcNZ+UmE5bmDwExDE6SCxDu2VIhVeJDoQ==
Received: from PH0PR07CA0067.namprd07.prod.outlook.com (2603:10b6:510:f::12)
 by PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 19:34:06 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::5) by PH0PR07CA0067.outlook.office365.com
 (2603:10b6:510:f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Wed,
 4 Feb 2026 19:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:34:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:43 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:33:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
Date: Wed, 4 Feb 2026 21:33:11 +0200
Message-ID: <20260204193315.1722983-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH8PR12MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f316ed9-ebe1-4bb3-3806-08de64245c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gRe+mTnkeqpno3VAsX8S3FkV3P726fbyRLdoCk4WDT/xzSt/UES/2AZat4M7?=
 =?us-ascii?Q?Q3j+qdtjcHlSy4um3WGA2YJmLh8m+rbz/BJ2c2bYPMUlfFsvMsznQx9k+TyE?=
 =?us-ascii?Q?kXZ5ENtqsMMcyc3lXhKfN4B4PHoqpypei7+6bE+QY587XxjDyi0qCdtZ2jI0?=
 =?us-ascii?Q?JOt6WIecmDhDbbOxuHzdSYjrUSfARKKB7eg7oyEMPIAT/45tswgYdQhucgOB?=
 =?us-ascii?Q?7ssS//6YqOVNK+bYb4s2oMa9pRZ2nc8NjMUan2cQcfafeOYgyqkC+TcvbgmO?=
 =?us-ascii?Q?n4KjtXBd2HDPf5wezzXAtU0LdcUGpQ8+BstuaWl/iystagElFuEV3+BSzlKC?=
 =?us-ascii?Q?lyibNK9flF0X1gqyeymi6o1AaMQwYBMiQnRbnL0iZZjMGyQ04vFrPaERNOwV?=
 =?us-ascii?Q?Zovk8YUc+jckLm1JlHnvAp837IXOniK3cjZhCFmkdT8iaPv9xtUnhdxjnj+M?=
 =?us-ascii?Q?qtQGsCU6eUZBsOKhlKqatz5eMFT0pakoh6MEdqnwAJsnYLqPgQ9Rpd4xs8Ya?=
 =?us-ascii?Q?5128DjVcypPphJ9+hkEMUXK8jS2naTj1BcgLFk4ZCfa97RW0T8vxBFyIcTzK?=
 =?us-ascii?Q?wHjOe/cDMC2H29+Tx6IILxMLGzulfqcDKGhC+HNOmLoZ1kLxcdUAPFuiXrtK?=
 =?us-ascii?Q?i9qoZFQesvsFN39Iddx+JNgF0AxTrD1ZMMJbez/I64RzJINj8YTCAYYIa0bS?=
 =?us-ascii?Q?oBFqmDNA92l5j2owEaTpRBo1RrNP+4JilQ2IRWxseK/MwSinigaU8AYjYB4G?=
 =?us-ascii?Q?HrNjgdDC1VaN9r06PWpr4XasmtEyC0yjsypBuMxhs5U2ZbHCmiP0849fjBts?=
 =?us-ascii?Q?EG1hCChQdC+eU6qXzg63Ok2GfhLruKN9u9pdCy5LSEc+LiLEZNexy6QWCBPg?=
 =?us-ascii?Q?ZQqXG+fDLA/kq75udHdRwcPtNf7Jg3m9xnxloOCSAQS0BUkDCDDDgzhFT9xJ?=
 =?us-ascii?Q?TSBXl+Y+EfoYsG2GVis0apCsy+TeBusYG3M3CzAxtdX9aMvVevgnXg5B6H+K?=
 =?us-ascii?Q?P7+Nz3SDQFGGurUaMAOIRPFKwdB0Cm8inDdVjBPRQpdL0E7JsZSgoIXCOaba?=
 =?us-ascii?Q?ptb3HCZ1bG8Rb78qumy1eL+4y5d+YOiZ1Py57GHKeWMjgMttsJgQIIJPwouK?=
 =?us-ascii?Q?OXWkzjE3gTALb4ZZwvo5nNiN9Dh1FHsbCVAzDqQff5mnPgJBaC3Mduzf7oyp?=
 =?us-ascii?Q?MUJ9Lgk9l6sMTYo4k1TVXG9XfM7FTFX1mqlh7yrzqZPv4IYwbINwWoxI/QJ+?=
 =?us-ascii?Q?7Q6K22RU/OCV0sTpEPbEAqICNs1NFu7QWk/5qMdNGSnOUskeTIPUBxcS2cXI?=
 =?us-ascii?Q?kzLIkTuSrMl6nxJY66QduwPZPPY9K2rGH0tfNGxfN+IC/GWIdF+FM+ms6eAy?=
 =?us-ascii?Q?NAsgETJxgIciaLlboj0GljXYmcFfb1dSZdBevhI3ZkWEP7nRDLPqt51YIFSl?=
 =?us-ascii?Q?BuzkYbtUWfgzSNXTSPno/GnVaAqhPCcrol94aDu1xNEbEdxifzQamcaYi5ZR?=
 =?us-ascii?Q?A/Nmwiii7x53feP5/Pdmtb1pHiGKctFoSS94vTVtpk386PccLrXrq2cM66lJ?=
 =?us-ascii?Q?XTK0p9NOQWFG27/VWIeFXvErnXdpKbdy7y/W/SB+gLHCMKpMHVI0u3VFL/6H?=
 =?us-ascii?Q?oYFOFB6s81FVg7fLrhoZInG0gsr8hs+GKgoOB4/dQ878VlRKPSu5t/MDZVq6?=
 =?us-ascii?Q?dLbSRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rvE9aGp1rY/DljiUBPP8r1b+yOsxcj2kJZynG6wm4t4Nhmt2URgTmxzHmaF38hqvwaY/R4vOJ87k/P1AjVBmBWQIbwcXpqk2E3L8EPvxdEYjqnNxrHewF3B/lvr0UZ20GE1AvWvDVqlK04lg8+sjMNxq4bGPrr4t9FLQaVGg7NKU6JiHrsWnywJTGh5wCX9132npn5TZv1uP1pUcx8v3DuHiLltxm9+gasDMqd01FP9M4jkhIsqsZA5BVxlG2eSD/olGUkLCnN27pm4323I8Eyare/pVGlCIlrcanL9HMKlzPl0X68grnYeVRRKorMcuPowAus4SdDDYBhxT7k1tvmMnRnjBoJYr8Crd43nYKNQlrlk/Gz0LtQAijT3/ysvBObmOpdZpIMNaWsRqAMd5YWzLJ8V5JGU1p8SKtKz+fdW+EeQdN3pmk3cp0sh8/5gm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:34:06.1140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f316ed9-ebe1-4bb3-3806-08de64245c3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6748
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
	TAGGED_FROM(0.00)[bounces-16543-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 2F589EC184
X-Rspamd-Action: no action

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
index 96dc6a6dc737..0e955568c2f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5550,6 +5550,10 @@ static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
 	sq_stats = priv->txq2sq_stats[i];
 	stats->packets = sq_stats->packets;
 	stats->bytes = sq_stats->bytes;
+
+	stats->hw_gso_packets =
+		sq_stats->tso_packets + sq_stats->tso_inner_packets;
+	stats->hw_gso_bytes = sq_stats->tso_bytes + sq_stats->tso_inner_bytes;
 }
 
 static void mlx5e_get_base_stats(struct net_device *dev,
@@ -5589,6 +5593,8 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 	tx->packets = 0;
 	tx->bytes = 0;
+	tx->hw_gso_packets = 0;
+	tx->hw_gso_bytes = 0;
 
 	for (i = 0; i < priv->stats_nch; i++) {
 		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
@@ -5615,6 +5621,10 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
 			tx->packets += sq_stats->packets;
 			tx->bytes += sq_stats->bytes;
+			tx->hw_gso_packets += sq_stats->tso_packets +
+					      sq_stats->tso_inner_packets;
+			tx->hw_gso_bytes += sq_stats->tso_bytes +
+					    sq_stats->tso_inner_bytes;
 		}
 	}
 
@@ -5633,6 +5643,10 @@ static void mlx5e_get_base_stats(struct net_device *dev,
 
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


