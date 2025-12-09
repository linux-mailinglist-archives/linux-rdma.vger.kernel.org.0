Return-Path: <linux-rdma+bounces-14946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B34CB0050
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17A83301808E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D31C701F;
	Tue,  9 Dec 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OR4bMKf4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06E329C4E;
	Tue,  9 Dec 2025 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285056; cv=fail; b=n0omkfU/xdMvclewXWIJ1aUaM41AtrSos+8TgVxXQy8f+CM2iOU9NMaXLOmL+4FwamO0t/+jTBJfahHWVO5HWn0hGGkaPDw+r9t6T062aO03ThJFD++1aCF/Cp+AyuQ0osHbmRoPN5p9U+uLEZjXaDDVzjFOFgyojxBxFZW3OQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285056; c=relaxed/simple;
	bh=lI9F3Rfu4hWJknzEBZpzDHGxRPEds2H90p5wgdooAn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVWVuT6LaFk3S0U0nw/3Dm+1/9dSwzEdkUhn7WssqpYWSB7mDbqoCDZ+gR4GeB2oLIDWeO2iqQmNZnQjvgPv6xVdZaOq5hM67faCuyFdmX70Qm8a/t7kboR4Dvw0P7AxRSw4+Y9OsdBZCYnY3AvihkzINZDs6DZXB11Y54Oo6nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OR4bMKf4; arc=fail smtp.client-ip=52.101.48.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0c4wMJmnOdazfIYbXHhCVeI+4jOKEkabG1h7OEjfqQiY98dlDME2iXtoatA3+F56FB+o5u8qN6/j6KpudE5dboF5AIxvGK7LYp1LjECcVvu2rF1EO8+VzC44xndSzFab/W5RGRG2AOLhHTrle4PbDc7ajg/bwYk6sezPqlj08Kj+kMsVXguHFNM17eSRkdoYG+b0yJlO3nT1A0qhu+aMaq8gTjBeRKixnrU2vAr33Ba8oCH4bGWc7iC1bNli7ZGwTuxZ26QKMtLrp8y1/Hq6fBzs/QOGz4P7iaVBZdsGrELm13/tgH2GLI/Gf8lIqScBxD+tD8haGcug5s+FXJH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBw4OpwAFZRiUBOpIW0TrzZ83t3iXk7Fjd7At/b3HsU=;
 b=wcKB58E4O8abE9BWsdreJcF68dhc1T6MuRohzD3FSFzRcVH4LeaLPSfSPFF0Rd5CeF2ULeH3hu/ghCaOmm4zg2vfANyOlp6+fe+7lrpNePlC40jjjqm9U76zAvBM6TRqr1k6sLo4s3rIqAhMu1LaAQeW6JejCIaF/a4vcdWeWKh7s2RhUYK8WOkHoKC29QD7zC/ZGmo5LyjwAAlPHuUoFGPRMhy2rWJ+04XvwkGZ2UN8cg9U+zSUrv1ScM5bn0xlVJGun4XJVFFyaqNCRzOunsYSp96m+N7XOMRrQ86W2taMgkACeGN8PH9VFFzdaxvMeNQqgkt+XpXfqeOpLU8EaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBw4OpwAFZRiUBOpIW0TrzZ83t3iXk7Fjd7At/b3HsU=;
 b=OR4bMKf4WcWReNQ6lSPMJTZEhawiJZzgvlimZDnOuhUn14l8/2m53GG0x1V02/9LpOm2k6spm9jfLlNdThHJ/zTpElpf7n+mMBhhNl6a8kGEKlMWFC6ij6cQuouCv/aInsi1yQJftv9dSJP7MJoN93iit0sx+Z6fdI8xw4VwB7P2a28j89smIHaD5VCPGCHuL8gfcbzLF59P0/XdXv03zNg4nZtBf6y6ZTZN5ovPxtU5um69LXYfK8+Gp3WIPfh97VNXsyYpuvGEXxtgmIv/bnfQAfEvD6hkbs83Xk0/nkfT5X3H2a3e7G0A2my0k/539P7CSSFmkcInBySw15h3tg==
Received: from BN0PR02CA0053.namprd02.prod.outlook.com (2603:10b6:408:e5::28)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.6; Tue, 9 Dec 2025 12:57:28 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::42) by BN0PR02CA0053.outlook.office365.com
 (2603:10b6:408:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:57:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:57:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:57:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:57:12 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net 9/9] net/mlx5e: Don't include PSP in the hard MTU calculations
Date: Tue, 9 Dec 2025 14:56:17 +0200
Message-ID: <1765284977-1363052-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe87d24-646e-4ade-4b3f-08de372281b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Io5bH4Ae5dwPzNN+jAMDb5+WxascDEu4v2ia7/A6EbZyGi+aTOiHkZhM9GnL?=
 =?us-ascii?Q?IU/eyien/TMKUsi3xS0MiqxDNq8eI+KFY50xHYRCqTwR9iV9SKbyKPiXN53y?=
 =?us-ascii?Q?WoyHuPYjq9SoCRAP+HHoHQGGu77jKq14DeTWA51EW4SQK96IlMhlUbJa6eSG?=
 =?us-ascii?Q?xsGe7TUHwUu2O6MFFEly7QxxmfCrSa/Vwi1R2xy50fNzfM45SDKDkL5+Mdzf?=
 =?us-ascii?Q?/YG5vj7mwwr6k2q9MrMfv6KUplCO4BkQl9fODgVNK0y2awGmO10X8bZoUnD9?=
 =?us-ascii?Q?L3PyRTSCBQvozNFPheTmKa5LQ+iCb7k4yTyYEOngbRV/jaDGpHJgJdA/FqCI?=
 =?us-ascii?Q?8nj74U0a8rdN3RSq0tZqUhURU6850a+36nZGVRnJ9YL8Hyv1DJXjr7gJ0d+T?=
 =?us-ascii?Q?IztdRER4rEKN8XVijZ8ZP/TvoijgsQ1C1HI9OCmQDh2++4Cw1a122ANXvdsX?=
 =?us-ascii?Q?+53m5wqdtk+/dJ14e55+bm8dOGG2taq+TIoXC75oMcJo64zBReD0PMCkMpMU?=
 =?us-ascii?Q?miYI77OJNLJBL+fVD4Ksrekb3MpT8W3hAHM7YtcZ8ySfkQcTo4BSStQPhc0R?=
 =?us-ascii?Q?PCUHHGI3CwMMdqXe6k0Wal8rDUSOzgDIyTj2GQHm4UMoxFPx8A5+xhchz0RE?=
 =?us-ascii?Q?KYUhD59oI3uHxQ/TD557l61vCzgB+KlyVOjRqeJytz0rJRUVZvNnvAB/Go73?=
 =?us-ascii?Q?sRApdcfaiH6DE5maZSLCUHwRQAml2sDGJABnARA2kKIAxHl73t74Ousu6YLm?=
 =?us-ascii?Q?SIMLinyfoOKiwp9XBRZVZoQsDQ9uB4dEV5XePXueswYGW4pcF9zI0wp9Ogg2?=
 =?us-ascii?Q?7gXpquTSI28/HLzzEHgrsxTTN8BIVHb9ZuxU9rZbTvfryBzwh8ELCnu2wROn?=
 =?us-ascii?Q?z+B/9jTD+IRHFjNCMDmu/XjmRSfTd6DJTdXusuJDJJB+l7RQ2yxAytAdM9Sv?=
 =?us-ascii?Q?WduQCKbfvD1Mo2mhMoZqTtO96IKhKE7NXcznVFIUC+4p3A4ErsrnnLTyMWIu?=
 =?us-ascii?Q?9USHqWoZNpM6vtoVIVmG3m+ZIyMqyqWs9STSIn5dP+Skk5qf2NWlctXVHBGl?=
 =?us-ascii?Q?h+p1VULS3ahZPg6J3zequW4KIJso7HPpAPX2SPWlrDUG557PKhO0ODIC+HT/?=
 =?us-ascii?Q?vfKklIb+69aeXIavmQZ8oWNk3pymDDqL43W0OGuXB/djAPJR9cFZD36IDOeq?=
 =?us-ascii?Q?h0tw+f4NsdNUoxkTqZpDX6mCDRNIQWJ5TFvD3ZseQACHpmXnjjkIIr58Yrjt?=
 =?us-ascii?Q?gM3PddCvMLt8CYMkvYM1AHQqxg9oEnNJbZG5JVQpjxOcGg+ypB09j7udnR1n?=
 =?us-ascii?Q?OKRVqkSFiB2hxFe1QCIt0cCKIf3TH13ANC13gZ0SC6t2ap4o1FksGRLMcjJ1?=
 =?us-ascii?Q?hDzkwJa3RuNDQ330qrUo4wsAd4nu3pLGYyh37kvxqApwV8VZnWln5MA6dCwc?=
 =?us-ascii?Q?rIgC8t4Tdy9DQE3clCUmiIKM87aAZzqtAs39U1QINhPvDh9BYwUAd+tO3Swh?=
 =?us-ascii?Q?PtC5XT6/AdcsSYMR7lJTQ2Y3V/Hq6Ag08dNBpVSuBCfsMIGMdvq5SjkWTCwg?=
 =?us-ascii?Q?V14KRGsIwzWes3xvkSO/cSCgrevY5Vl64789K0QH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:57:27.6415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe87d24-646e-4ade-4b3f-08de372281b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373

From: Cosmin Ratiu <cratiu@nvidia.com>

Commit [1] added the 40 bytes required by the PSP header+trailer and the
UDP header to MLX5E_ETH_HARD_MTU, which limits the device-wide max
software MTU that could be set. This is not okay, because most packets
are not PSP packets and it doesn't make sense to always reserve space
for headers which won't get added in most cases.

As it turns out, for TCP connections, PSP overhead is already taken into
account in the TCP MSS calculations via inet_csk(sk)->icsk_ext_hdr_len.
This was added in commit [2]. This means that the extra space reserved
in the hard MTU for mlx5 ends up unused and wasted.

Remove the unnecessary 40 byte reservation from hard MTU.

[1] commit e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
[2] commit e97269257fe4 ("net: psp: update the TCP MSS to reflect PSP
packet overhead")

Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 811178d8976c..262dc032e276 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -69,7 +69,7 @@ struct page_pool;
 #define MLX5E_METADATA_ETHER_TYPE (0x8CE4)
 #define MLX5E_METADATA_ETHER_LEN 8
 
-#define MLX5E_ETH_HARD_MTU (ETH_HLEN + PSP_ENCAP_HLEN + PSP_TRL_SIZE + VLAN_HLEN + ETH_FCS_LEN)
+#define MLX5E_ETH_HARD_MTU (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
 
 #define MLX5E_HW2SW_MTU(params, hwmtu) ((hwmtu) - ((params)->hard_mtu))
 #define MLX5E_SW2HW_MTU(params, swmtu) ((swmtu) + ((params)->hard_mtu))
-- 
2.31.1


