Return-Path: <linux-rdma+bounces-12279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B64B092BB
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 19:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F184188C30E
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4BD30205B;
	Thu, 17 Jul 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWOcqNcZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840E30204B;
	Thu, 17 Jul 2025 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771892; cv=fail; b=YZqJFj/CYt1zTcu6GjMXJl0H8NDXd1TFUe4R59eJCdlC+96MoO13k3Xjp6f7cNURVwPAoVz1ps2SWxX4ewRLsE9/1TZB3SpyKizOazMAURx+1b0yfRzZxPuEX3w/ZwKHJvo+VAq1v/grn0qttAco0RpzxFvzQXq9jJxYw9dKEgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771892; c=relaxed/simple;
	bh=fO8OC/JIj94SMf8oCDadFlgsScVnStmxGCq+mu07vAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYxZh8dkooHm9k3ehXrr8WrMmDqDvRnv5un3EBhwl8cwX6lBLznhRsDmWa5/6VCHanipbv14amLYvqZP1403+PCdhd6l+bxVduOGwU99fXtLXgACQDB02EjxuMUuEfyhn6vzc6kLQtb9YCK3aO+XV5GVGs7M9pep/7qlj6yEgu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWOcqNcZ; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zChQZ2QJQPfRh8IhYxSzEc89kxGpNLjLqxf4ZKsalSw/JRquJNJciQlZs3skYvpvjaeDmspcqbxDF80Iu+G7XIrLQ+4Fs0a5hlDmEK2EqfEuGUQsoLXwsIbYdVHRsggfZ90rv/Ms6dk5SM62DyAQAWII4cVDKChwmEZQ684MjYHZD4prB2LQw8lE6+/ucbjp7MWqWX7pP+FEbvv/FVgaLO0pq+hSH9u2oiQzo/D7r8twf56YvDO1I3a4Q9UneI7NZCfy6IDJ5BTSQO8cR1z/urztZnAr1cCgybwpgB3f9vum39Z2WG3P20AaFhazV8CbNXaS0ECfd1F/ktFSnua3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Ri+9rbX5Lt2Dy11NWTbgLyC4zuYOMQOYVcjcYopb4=;
 b=KsNnoEloYUvvpHADR5Uh/n0JBdJcZITiEqX7cncY7GdR7VW0vW8uYZfnQrDCxpvqSNINJInIvIyIM3g04GO6cm4U8gB3IXyhZvE6Kt1T20i1Bt5Bjfj1FjvUHe0sns/yBksaXsalOZ+Jii78xJXtBMnAyvLvJwEFiXLk/hoISDmvpU64YPpB0O7wy2844Sy6qRhh4/fMfN7hq8IFqY0neBGUEbWgMpwItihg89xkDdolSM+z0s9TabQ4rANwZPO89sysqf/w21NNf4xvjONbqOrpYQkTprg1KCa6wQO8bmFKWIrUFRNOiivSD9r4Haqa0IzEH1JldbWafxlxw0ldAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Ri+9rbX5Lt2Dy11NWTbgLyC4zuYOMQOYVcjcYopb4=;
 b=hWOcqNcZz0iD0h4shlwUF2WdDGkfjSvRRoWKcbFKAcZF0GjPtMzhRSvzWPigIB2ypqNGvAiCDsITQV46ci6z/jRVJqLDm2rtyqcctJ+PrqrLGaxikhTWmhCfDLIFSh235do8Y0dPiIs5D7GXL7vWiDOmaHAG6l9nGXdGu/7x3uoDUzUBOBrNu4sJByQ0HL8eteVeN1LqgCUBgldqkBE/rTbF+Psts/yT1w6/iKLcspySHfOu7bpG+HwXyu3iAG8tBNkfaERrR504pzK+LDpi0DLMyucar7z+PchqaHBtCvM/Vt4r4QUcqqEd3F7TNPAfBmnzcVO/dyAD6MMOK9UvYQ==
Received: from BN0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:ee::27)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 17 Jul
 2025 17:04:48 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::ec) by BN0PR04CA0022.outlook.office365.com
 (2603:10b6:408:ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 17:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 17:04:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 10:04:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 10:04:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 10:04:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexandre Cassen <acassen@corp.free.fr>,
	"Leon Romanovsky" <leonro@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5e: Support routed networks during IPsec MACs initialization
Date: Thu, 17 Jul 2025 20:03:10 +0300
Message-ID: <1752771792-265762-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
References: <1752771792-265762-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b7b557-c1d7-44ec-4516-08ddc5540941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swYRFNWTQQz0wJKT8zcCi2tNPal+e2rTlUXyO7zD5FotQl8pjkTEbzkoosOZ?=
 =?us-ascii?Q?dfcgMz6qFFLb3Dg7In7c5u1Cm2npCE0JbZcB3IzpDA4pQsvcP+q6+0kIQi/v?=
 =?us-ascii?Q?w1IGDNeCNBxwFHiNJsaNUKrJEGlrQxE6kH8IvDfS2vcPxyidGE+1Em922PJg?=
 =?us-ascii?Q?YrE1lrmCuc6k7ZlO+61P2KFVzk+Vxah2dDlD9Q3pR5PJN0xkNgfTDyvZBMpr?=
 =?us-ascii?Q?If6jDtLBmnquQ11LtaYf1SYDykSFpAZxgbZOUiMfIrtBDY93jVLHm8yJngZ4?=
 =?us-ascii?Q?MUL2JmXIYyEci10cMI6sZvaAd1hM8GfZBO7tI4cwmYlAifDnEE9Dpn2GAi7/?=
 =?us-ascii?Q?JevBQjW9KKh/rNMUtvRf/8s0gc9QgoA9kagFSHI7sVQQ2pAImUjYEFdLH3g2?=
 =?us-ascii?Q?2/n3veu75UWDO3u1zxFGBzxvjGsWEj8myg0CDWbFFBLBIBg4D3qN4K8BD3Av?=
 =?us-ascii?Q?UVbwF1IQsxthN4kLkiBweD51kFS4iUPL9v1lj888AlM6QMhrzGonI9ZA5Qyr?=
 =?us-ascii?Q?g1+UDQ66bP573GJTHXkC4HjtPNd8fovtqraicwkvgIRXHlJArMkpYK5D1znb?=
 =?us-ascii?Q?zzY0Q+s2YlcCABQDFFUf1gabdfvC4REiSFxNbub8vz2Hy7CTYehrUG6kwOiO?=
 =?us-ascii?Q?8KcGNfF9Z2QBMRgVA3AjtuATVvKfzMgAemMXt1nH65I7Q8EAPAS8b8CiDQXK?=
 =?us-ascii?Q?6GErV/Dffyjtklw6rvVTwjhyP2ODRYqg3YdNbGvM5JRFQb+VjCBKjVWbOrnb?=
 =?us-ascii?Q?oDcAIVfKNcOFzssnh7XyroRaFoBZ5ScwiWc8LNUIzb6Vb1BNqhnzDJhbtRmp?=
 =?us-ascii?Q?DeC5ClwF7LYf+SvDCRiI5ZxFvVIQx5qd3bngJkmyYSXQU6waO2gGGkDwQAgp?=
 =?us-ascii?Q?P1g5lYU6U5q11eo2lNdz8Uc+r6UrzcnkS/jjdgEVb1DkVPYi+eFEklSriXQt?=
 =?us-ascii?Q?bvfFNvMN7FoOoSXI+3RsCqijZtH4yQYJIyjFyBMLHp/i+tHQ6MUdZJsHg+S/?=
 =?us-ascii?Q?lB3iimiqDms6WGFk1+12Rba4BZYF9Fpss3Gf/xCS7ZXg5un32OJjlbHKDJTu?=
 =?us-ascii?Q?5ICqi7qgdHbQJxXgxwnO44FedmH08upJc2avsJsDsf6IiumjNCMsmYVd6mKW?=
 =?us-ascii?Q?kus61oHU0Ph07GLAXbHsNKSjkv+p6HwiaidKMFYz/MMF5tF8q8QAnJfww5+E?=
 =?us-ascii?Q?JEd68VLkL0PAxi9LCGWAThbYgwOAnCN957+p0p2x1ao9qVBpnNU5bKJU4/jk?=
 =?us-ascii?Q?3e85IcEWfSRsFqsqVJkxDfdMNsSoX4F0gKQmlb+3ySGbv+pRa9/HNqaBsh+k?=
 =?us-ascii?Q?vsV2PyJKftrMGeVXEqNRENfogzby8p4gluWQJ/eIPvFaP2XJMR3yCy+lJGbe?=
 =?us-ascii?Q?5mpnItZJQmKLj38a7S6sPs5qKH1ixQG0xKLisPbblJyOlcs5kKkxboCKKrXT?=
 =?us-ascii?Q?omXZ3snDXvm4PK+WRhEM/G2UhNzHkaRwzGYyLTU3zE8qU6pNzJPsuxB7WEhO?=
 =?us-ascii?Q?VAteu9OzZMDZ8yeRCksb57I/pbK+pDPLOEj2UZPHnUJOEJnM4wBTT1QopPU0?=
 =?us-ascii?Q?IMaXndXhSaMuIUy/jPZJzJqcekXFk3KgEu3ARU/k?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:04:47.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b7b557-c1d7-44ec-4516-08ddc5540941
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

From: Alexandre Cassen <acassen@corp.free.fr>

Remote IPsec tunnel endpoint may refer to a network segment that is
not directly connected to the host. In such a case, IPsec tunnel
endpoints are connected to a router and reachable via a routing path.
In IPsec packet offload mode, HW is initialized with the MAC address
of both IPsec tunnel endpoints.

Extend the current IPsec init MACs procedure to resolve nexthop for
routed networks. Direct neighbour lookup and probe is still used
for directly connected networks and as a fallback mechanism if fib
lookup fails.

Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 82 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 77f61cd28a79..a486684c8e60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -36,6 +36,7 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <net/netevent.h>
+#include <net/ipv6_stubs.h>
 
 #include "en.h"
 #include "eswitch.h"
@@ -260,8 +261,14 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 {
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
 	struct net_device *netdev = sa_entry->dev;
+	struct mlx5e_ipsec_addr *addrs = &attrs->addrs;
+	struct xfrm_state *x = sa_entry->x;
+	struct dst_entry *rt_dst_entry;
+	struct flowi4 fl4 = {};
+	struct flowi6 fl6 = {};
 	struct neighbour *n;
 	u8 addr[ETH_ALEN];
+	struct rtable *rt;
 	const void *pkey;
 	u8 *dst, *src;
 
@@ -274,18 +281,89 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	case XFRM_DEV_OFFLOAD_IN:
 		src = attrs->dmac;
 		dst = attrs->smac;
-		pkey = &attrs->addrs.saddr.a4;
+
+		switch (addrs->family) {
+		case AF_INET:
+			fl4.flowi4_proto = x->sel.proto;
+			fl4.daddr = addrs->saddr.a4;
+			fl4.saddr = addrs->daddr.a4;
+			pkey = &addrs->saddr.a4;
+			break;
+		case AF_INET6:
+			fl6.flowi6_proto = x->sel.proto;
+			memcpy(fl6.daddr.s6_addr32, addrs->saddr.a6, 16);
+			memcpy(fl6.saddr.s6_addr32, addrs->daddr.a6, 16);
+			pkey = &addrs->saddr.a6;
+			break;
+		default:
+			return;
+		}
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
 		src = attrs->smac;
 		dst = attrs->dmac;
-		pkey = &attrs->addrs.daddr.a4;
+		switch (addrs->family) {
+		case AF_INET:
+			fl4.flowi4_proto = x->sel.proto;
+			fl4.daddr = addrs->daddr.a4;
+			fl4.saddr = addrs->saddr.a4;
+			pkey = &addrs->daddr.a4;
+			break;
+		case AF_INET6:
+			fl6.flowi6_proto = x->sel.proto;
+			memcpy(fl6.daddr.s6_addr32, addrs->daddr.a6, 16);
+			memcpy(fl6.saddr.s6_addr32, addrs->saddr.a6, 16);
+			pkey = &addrs->daddr.a6;
+			break;
+		default:
+			return;
+		}
 		break;
 	default:
 		return;
 	}
 
 	ether_addr_copy(src, addr);
+
+	/* Destination can refer to a routed network, so perform FIB lookup
+	 * to resolve nexthop and get its MAC. Neighbour resolution is used as
+	 * fallback.
+	 */
+	switch (addrs->family) {
+	case AF_INET:
+		rt = ip_route_output_key(dev_net(netdev), &fl4);
+		if (IS_ERR(rt))
+			goto neigh;
+
+		if (rt->rt_type != RTN_UNICAST) {
+			ip_rt_put(rt);
+			goto neigh;
+		}
+		rt_dst_entry = &rt->dst;
+		break;
+	case AF_INET6:
+		rt_dst_entry = ipv6_stub->ipv6_dst_lookup_flow(
+			dev_net(netdev), NULL, &fl6, NULL);
+		if (IS_ERR(rt_dst_entry))
+			goto neigh;
+		break;
+	default:
+		return;
+	}
+
+	n = dst_neigh_lookup(rt_dst_entry, pkey);
+	if (!n) {
+		dst_release(rt_dst_entry);
+		goto neigh;
+	}
+
+	neigh_ha_snapshot(addr, n, netdev);
+	ether_addr_copy(dst, addr);
+	dst_release(rt_dst_entry);
+	neigh_release(n);
+	return;
+
+neigh:
 	n = neigh_lookup(&arp_tbl, pkey, netdev);
 	if (!n) {
 		n = neigh_create(&arp_tbl, pkey, netdev);
-- 
2.31.1


