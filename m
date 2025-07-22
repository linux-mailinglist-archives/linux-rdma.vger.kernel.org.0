Return-Path: <linux-rdma+bounces-12395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C595AB0DEB3
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9931B5802BA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jul 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9E2EA495;
	Tue, 22 Jul 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="knCtTiYw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7E2C9A;
	Tue, 22 Jul 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194280; cv=fail; b=o4eRQFhKRvPniPOo0plD9wajaPIjWIBdzFnuUdpA5a8GWi08bcZM9Zo9JvLspuD+1OUkdbZpt5kYAgPv7jKCB7o35YDhKK9WkWfYN8LPLMOYXmluBCgz4mHrFCol5OK6n9wfxoNYXTh3uMv3DWxCVvlEeIe+eb6vjw8fudpGU+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194280; c=relaxed/simple;
	bh=ZxKlvbp34fqvgwRX2osAph3CESVOgj7ZkY2fWWsPkEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niw+IhhHPYIjXwoTr7PjqMpllTKMFjzTDagJNaY9H6ykw9IZs1RpxYnwvnjeYvnI+M6MP0kGKOfYNWK2pie7rI0ALvnE/uxtedCkQbI0dJNWYmvj1uoY7eBPCM/+zYgAMWBcrO/jiTl0i6DJQo0S9h1B/SO+3Ewg8amOxhjrsP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=knCtTiYw; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcR6do2KcYApqc8531qeeOTT/a/FMkzsc6PLoIS9LoMkiC//YOCwXk841ZPOO5XIa/OM4DJtRmrmThGf13lQuDHU8s8efkjYLR9hGRuD7cwb3i0Ymw3/PfNWq8MiNUqyWTBn/0wSUyo/fSUgtIRYVa2sp34dYouYNcV3WSXxER7rn9hwwCpCLjMDrvQkzEaXaYVn/W7SfJM2HxFrE2b5ExZYLDsXxv5tPxS6TmoUjU47aT082C6LNQjAvSTZugBtg/rfJsMbCKG6Vm2s4byS0QRcrPJtBeNhoRg1zDIZiDccaD2mzU6US0bXOe61RoKjqX0L0miQx7004VSOnhxaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeApo8lhP03vYIm0RvOcOT5P0/QoMLpaAVD1661hUpY=;
 b=U7cI3Z/5HpRMyOlrFMGmpuaqSuCd3861P+IykPArRcBKSkRo3mOTR4WIO8/N2V1mIH6iZxQkx/NZKeJ+bxaHuccHv2JSEcswkX3cAqO35BrKVEDQ/mNNS3Ny48v7d67cgpxJJI190cQqTHfISZsZ/JssCiyWBedjIVYyObbWHVcdN5DYrxDbA+UKmKNPmD5TNcfqG7sQla628B07CP5Bx0X6Ci3R/vKfQvtCu8rlZmYUGNY79isFegxnYSnYh+AipOCK05utukmscOeMoYZ2oy8Gkk+8KjbUJCRMfK9fOMSBiM/swUkja+QNRuzFiseYxpYoUKPzMxruMdDYAlrdrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeApo8lhP03vYIm0RvOcOT5P0/QoMLpaAVD1661hUpY=;
 b=knCtTiYw0G937DHs/sdaZjS74Yv7mebr9WDBspmXylA5RN7dkbYEOPbMk9Ms2YA7K5YztsnmKaPEqr4wJhQgv4u8U+qiE0eTTkcr+jcK3W44RvRh+PQznUcFpmMesyTTxAtQIR2w17BUdMdnyG8hqyPN6EOtKQ2UB3IhNFuG/R4zg0eJFwLSscab7ZY4Lc86wAkaN+eE8oI9S7PEhrZ88kQnBie4Af7JNu+nGnmenp01PVGzF5gN2WLRTP7BCYiMqaD9dRnlzy59SKVOWXpl4qz5aBJoqT2tD0ME/kwmn43KkEycmCIxOV5HfyPIi139IgciwO0FmTm1DjcgghccAQ==
Received: from MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::11)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 14:24:29 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::8b) by MW4P221CA0006.outlook.office365.com
 (2603:10b6:303:8b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 14:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 14:24:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 07:24:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Jul 2025 07:24:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 22 Jul 2025 07:24:12 -0700
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
Subject: [PATCH net-next V2 1/2] net/mlx5e: Support routed networks during IPsec MACs initialization
Date: Tue, 22 Jul 2025 17:23:47 +0300
Message-ID: <1753194228-333722-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
References: <1753194228-333722-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef8fa6e-903e-436e-a816-08ddc92b7841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jeCoTqtZwBHkeDrBfkqV4Ocql2iymxTzmv1IRrY6xkI6XC/0c7TMyveBkv5c?=
 =?us-ascii?Q?ign1befHIdH5v1JF7k/+AOgS7R7X3Aw8ptWy13L6gE9iw4vc17RENsT7onIC?=
 =?us-ascii?Q?FDuEI9Vo6pg1UYmNERlzjljhckzmknNptco804x5iLe/imNMrDi5yU7E1aAb?=
 =?us-ascii?Q?0tsXIGoHGHbHGly55582M/mXLusxGocq9dbS4R4dI66dmZJlD8Nbs8L6mcEg?=
 =?us-ascii?Q?A7w0LoDO++OOV1eUbTpDL4msapRmfNcsQN0QdS2wk4k4CBT9V+l5/oUm7bIw?=
 =?us-ascii?Q?ng3gybdIZ6vGvVB4SyL7ms5APIDrQVSfHhsQe2Bd5J1SaUBoUqJkwBe14CjU?=
 =?us-ascii?Q?js+oKPtMp6OQYFlxVCwr5tJCvndgok9qs51eef+jtdrGG7Wzwif3CScXT66v?=
 =?us-ascii?Q?Temf8G9HjBESbuSv07gaUvJs8ieIgn/oboR9kE8nCcki5TgYY+bvikzQDOlB?=
 =?us-ascii?Q?HMaH8bKs/6HCU2T24tDK9lXvNf5hxUoVS/qycujEoJ6IQ41uXFJnZwDBU7XA?=
 =?us-ascii?Q?BRZ/AIuYg2Hfs8PrvbEBkHsGSIte2a9ZhSspC5wwhs+0Ab4AcTkmvgJCwJot?=
 =?us-ascii?Q?OnDoQVTP0wMxV/xGsT0gBtYByIm2AOHSGTTJRTTxeAzzaYP1Pxld5oeJbvOq?=
 =?us-ascii?Q?ckYBoBcdwwfRKAmxE4hEGI1p6Dm9ePguZFtxFBXD9i1DFJRK1S0gv/glVXrb?=
 =?us-ascii?Q?izJnjkCXOknxWpIljAgdymAlqb1N1E/P9suNYuFkDAvhXQq6urren+ARlLPO?=
 =?us-ascii?Q?MX5QRP8XivT+96rQQqWVlP91hp+sz74fOt3FlEs0+VOPuLsi7I3a4X/II1Hh?=
 =?us-ascii?Q?vPuK/o7sVI9fEwNvzghTYBLoNiD7msnJvx/v3I5uXpdZVYBypSCxFm0CjK98?=
 =?us-ascii?Q?l3tMfG5D/6Ab6eUI2WbemvgxhorzZ36NyrO5+lmPpW18+Syep+NznGR9Oyek?=
 =?us-ascii?Q?iQq4iQr4ZaLQx1eABBmTUDdgOgfSw8lYmLNOo8OQJjldsFZ/wAA3PwT+0l72?=
 =?us-ascii?Q?E0j5e/K8m4tUApzoHJtEUfeIVOrj0QvSvwPNN/lZQMWMA1kleULBn+Tt+ys5?=
 =?us-ascii?Q?SERs7ydmVy9Sk+v7Ek1wIIW8JRFwX8oc+d5WSQHP0vqswqFLw6XmurVRjJqF?=
 =?us-ascii?Q?rH7TTBaJ7emIDaESjc4fEv15+v/Y8Q5vyxpgMgLqIqhGx/ob2I2R6jcWO7Ot?=
 =?us-ascii?Q?pvVGjOqVUTgVhlUhziyTLcwynXctSVMp9NfuwuNYeNXXCtY1xGq8deRGN6ET?=
 =?us-ascii?Q?OGpFHg2uQ/SXZvjsrF7ja9917Nbvs1eJl7rLvtVV3CSQMTGtqc/RAiw+Gnmx?=
 =?us-ascii?Q?09oQ5vLVQfFTozrZgMoMmqFphVUUBfobiS8h5kl+30cfieDC560QcotxGJsm?=
 =?us-ascii?Q?gctyJban13xpIYdYWU+lpJ6stb34kLYbUmm+ptQzFdxz9Iq9aJBuprqfXjcy?=
 =?us-ascii?Q?K/ky86EaJgAVxWFD6wrN1xMIx57hyb24lLK5/a8/7v0mT28FNshIMfIqIjab?=
 =?us-ascii?Q?mBhr1NZ2LANqVd2d3HzVQMYp/FNKBaYl/nmaTYmDE1P0jnIXwyyWEwGPQEh1?=
 =?us-ascii?Q?+rEIr/qJm7GhcKh7fv0mpRjeKEiwbtd+7ndfW40l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:24:29.3873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef8fa6e-903e-436e-a816-08ddc92b7841
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772

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
index 77f61cd28a79..00e77c71e201 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -36,6 +36,7 @@
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
 #include <net/netevent.h>
+#include <net/ipv6_stubs.h>
 
 #include "en.h"
 #include "eswitch.h"
@@ -259,9 +260,15 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 				  struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_sa2dev(sa_entry);
+	struct mlx5e_ipsec_addr *addrs = &attrs->addrs;
 	struct net_device *netdev = sa_entry->dev;
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


