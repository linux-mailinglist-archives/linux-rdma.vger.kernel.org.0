Return-Path: <linux-rdma+bounces-14943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60611CB0008
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F283312A560
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59013329C69;
	Tue,  9 Dec 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OP5EiTOj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6832C25F995;
	Tue,  9 Dec 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285045; cv=fail; b=Tm7lS5UyN8sypnnP079FWqkAIP+P0WBa//vrcD55r7U/xx+nlQWDyM3LfsYJPjUbvjiJnVjtRtw4iq1xH35Q+53bDutuOQpYpgmCC2t56ZH1dZ3Mopz9lPjCaTJyHH+IbVrZ3QIflqstQ/hoWi6AHMu9+94FnnHK/se9nKjbVys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285045; c=relaxed/simple;
	bh=/9fWrblUYmjC+U5FydVBJiEWbp5ncjQLQmhe7ArYdL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAw+B1eLq3YOh3ci4d3TtN5mpirp5gb6TBCX4UjzmMLLCyr29vtamHAPzKguxIqcNWlx5M6S0pdQRSUFNhCg1Y02CmprfMty+m1bgUpIC04ttoAcIC2ei1EmBvxBgG748B28FT53iVJ/Lty8WpB3VsQzUmA8pPGtVPrZpXmiE6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OP5EiTOj; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOC2IhnT0258DGvz3XB7kJQ7ypu0c+jN6KCofXR7YofOcZzMNbByEIPJ/Kkl/gFTfNiC0WiLSNJZ/aAAFrInFhw3r+X/lu4pmrP3hap8wNUvbXIwwjCLUOn85xrrikS8W/sljqKmJbDp8vaWDW2ghr0Vqa47AhexsAatDS862n/VXt2e4igbKL+D8VqhY8UIQt2t+nK3NZfANKT3WZc1sqeMqd2P60tIai5dEEhsEOGBvdhzl7L+nvPrTdN/u0+2epzBf3zq7B6NqeKY9UIos6/8XsrtkD7HJJEsdgHhn6J99ixpF4yvJr8Vt9UNSSObdqc0N+MjpB6IfgpiiEbonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCbhkLfJCNweK9+GeOOmJ5z4lbRTfmrkb1gQryb9Aiw=;
 b=VSKWBok+m0drQyJpHXGql5qEKXP35mS5CTh1EMQwXVabU4jYgSqmnpHw8ypuvnjhdOoXJv4590A4UW/gmDgmG6jEPpYwdlu3JCX/pYIMXSkhjKg3eO4zmle+pcNcT/PgsJXlYIrDSphDm6zKdPvQeaBIVvZcHCFCczNIkE0TzCn4ixAvo+v/Gth7vGfK3qTVX8rZp3Lr/j2I5I/NeoorysA+ximU3yK6ZseVM6wOut/A8GcQx1zbnHAwaCBHfKVOXBHuN4shtapmxHU40MHO2gRL0PWxeODG4cPBFEfHx2IWS5k7102sc/f6oCjV77sMnsJvljZc8VUwitgivumjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCbhkLfJCNweK9+GeOOmJ5z4lbRTfmrkb1gQryb9Aiw=;
 b=OP5EiTOjxBHmeqA3NQPM4sXse9gPddLaDWEsJ0VqYNktSlT5h0ACklgBR6FLQsSoMCJdHF3IC1PxAqVIcE/1eLH5ftqfjbjjdWNA9zsIyrvLpz/rMh3G4u20USJHIs6KFr2ly8LpNz5wIORYIkLSSdSJjinIxeXMrbX3rmadAse9wzyI3h++ag+aR52TH7v4Yp7O3xvde3ZmEwaEDcRTktPUBt5RnsGcXwXxIlh/emFGf8clK5kDBlBSMgd4aO8CUGCtUnMryXocGsaR325Zpf7GN+nVbmznfCmiGQ1SI+mTSBJz4p71m4Yl7o2Nny8yCUg0V9QAArkfLjwWMkXIOg==
Received: from BL0PR0102CA0033.prod.exchangelabs.com (2603:10b6:207:18::46) by
 CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 12:57:13 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::d6) by BL0PR0102CA0033.outlook.office365.com
 (2603:10b6:207:18::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:57:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:57:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:57:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:58 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 6/9] net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
Date: Tue, 9 Dec 2025 14:56:14 +0200
Message-ID: <1765284977-1363052-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: d51042fb-c6e2-4b48-aee3-08de372278ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s5fXBnaCB+sWkwbMXRKPNPnF78Fcn7d2datGO6kLiSQHIaV+/5hHc51hbuu6?=
 =?us-ascii?Q?QSBGlfrPstdcEdc3jGRcZshBHJOjvds/BOSW2DFtyyNXmzhNzlSIwTGMqIMz?=
 =?us-ascii?Q?x/TS6SgFjJKrixJk1BgTYnRoMiBXYuZDPzjfLRcIsmj16X66vCCqGOJSnxD5?=
 =?us-ascii?Q?53OEfXTHY7Oh6QiCEN7tCI4rrts3+0xtFeBI7vWiFh1Gz6ktkiqc25lB9Uzb?=
 =?us-ascii?Q?8mu5S/B43qVaoENUg7TAUx/Ok72t9MRN4GRMwC5CuQRChOlsCBW7M5IT4pTt?=
 =?us-ascii?Q?UsI3A2D5ckM8oB7MeVppIC9rd83NrY+mikli7MbWBPp9RbKscCxVvdgkVroG?=
 =?us-ascii?Q?TaEmdJ+WZKbyZVntK+ZcZnLloSZrQ66HNLEhac4NRVFax/PY5OYC05eba7wd?=
 =?us-ascii?Q?Cfa+XRP1Yx1s370vQBPpKw7Cnqygr7Lir3ru7+8Nj84JY6IhGCcEOr5yvsy7?=
 =?us-ascii?Q?tSdM7E/2Nb0NSJNmr0G6SXFpEElu7cAPwe3CmLdEeJxQMupt89IMxh8w/JmN?=
 =?us-ascii?Q?V6kp6AREj7H4DB3t8sr2uL5PXY/GgAE+r+wszTYrOzIuK2XgPlKiXo0DmUDQ?=
 =?us-ascii?Q?zTFHZqBJvDPdjE0VATgQj9RKwe2YS8gF+KIfyxQzQNv/+VAH0LE4+MHRcI3I?=
 =?us-ascii?Q?99fDyKg185Z64JhoVQ5Cv2dVVFQN58tbvr+bD059mPQVlsmW0QqnxXbbsONv?=
 =?us-ascii?Q?y4xqWHQltpatPVJHsWU+zQ27grtCFC+qZwjra+t4V7fb/UqrnaAkpVEYm3zQ?=
 =?us-ascii?Q?pL9CsJF6FSDk+r/G5hhdPsUzngFp+ZSJG7dQ2wsJ5jAseiLwwPVJiK5oSIzn?=
 =?us-ascii?Q?RhNI36LqKOV6PPqYwaz3nsdPLxlxYQDGgI7wknwANiNAjGyY5Liw/87dKvXD?=
 =?us-ascii?Q?HQbjDPiFfcEaCufoF7RVSN6vtuKKE6Y7TtXxlMdCSBw67ojDfzPEwPWaWXxp?=
 =?us-ascii?Q?KWBnT7w4ZAU1hlkrtyyV+lohG1Ht/FPpWyB5+2lpPnSzaAdwRW+3Q5O15qh2?=
 =?us-ascii?Q?zZ3nft28aa+RKprX0JGYByIyKwBPMD4C+Hxgdlm1r4aZX0QwXO3JBkjS6ibe?=
 =?us-ascii?Q?R2/0i2UgeXoJvEeIxW7mgkelrHszLfssL3rk3iAYu+aDfJ2siXWyrQni2TWL?=
 =?us-ascii?Q?klmeKYE08VuCe0KRVRWzu9u9FZB8gY8Dp6iHjCWCcVFwXKe9GLBZk9xXdARb?=
 =?us-ascii?Q?oP/jowWy2wbdAC4a7D9Dm7lRBZzbI0BQo3laYxAwglaw7lBP0ooxiRh+pT4Q?=
 =?us-ascii?Q?KSoHcYiOL8985vNMbiE2SqfavykeBL2ylIlbuNtLpYvBjp8xWcHC6Wr9LaSu?=
 =?us-ascii?Q?JPJBWvgh2tgm9bGfmh0Ln4iJxf0QTh5F1k9bpNxYZ7Szw/0sj18wAkuwO+Dp?=
 =?us-ascii?Q?0ANYvnVcp1ht/WdySqL53AAd2p2Vn4WOd/h8GKwnUkXys9HJSgNdleRQJIK4?=
 =?us-ascii?Q?Im+QCAwHfInMX1zk7FE9IiGClfb8xVcDThcKLWER81ok5oyWQTKodpRaflMn?=
 =?us-ascii?Q?5k0ifFQKpor1V5GyRgSBdVqJkXLdxLDNdRoivSUF9/LIDGUpkIinMHtOCNGb?=
 =?us-ascii?Q?jX88OsQ6krp7c7sFGV+pAT9F4uRvPWjk7uAF/sSz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:57:12.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51042fb-c6e2-4b48-aee3-08de372278ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

From: Jianbo Liu <jianbol@nvidia.com>

Replace ipv6_stub->ipv6_dst_lookup_flow() with ip6_dst_lookup() in
mlx5e_ipsec_init_macs() since IPsec transformations are not needed
during Security Association setup - only basic routing information is
required for nexthop MAC address resolution.

This resolves an issue where XfrmOutNoStates error counter would be
incremented when xfrm policy is configured before xfrm state, as the
IPsec-aware routing function would attempt policy checks during SA
initialization.

Fixes: 71670f766b8f ("net/mlx5e: Support routed networks during IPsec MACs initialization")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 35d9530037a6..6c79b9cea2ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -342,9 +342,8 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 		rt_dst_entry = &rt->dst;
 		break;
 	case AF_INET6:
-		rt_dst_entry = ipv6_stub->ipv6_dst_lookup_flow(
-			dev_net(netdev), NULL, &fl6, NULL);
-		if (IS_ERR(rt_dst_entry))
+		if (!IS_ENABLED(CONFIG_IPV6) ||
+		    ip6_dst_lookup(dev_net(netdev), NULL, &rt_dst_entry, &fl6))
 			goto neigh;
 		break;
 	default:
-- 
2.31.1


