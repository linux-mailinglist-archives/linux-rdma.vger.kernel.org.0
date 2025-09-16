Return-Path: <linux-rdma+bounces-13407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A2B594E0
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25724E025B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253212D47F3;
	Tue, 16 Sep 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYF3LFy4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97E2D46B3;
	Tue, 16 Sep 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021118; cv=fail; b=bx9lQI7cIBlwUeWdeRbPpULVgQbCWZiS6pAnCqaxehevcdYwqAYo+zLwO8WNebPNGdEDKtT/PsetnHV0bVCOIicTiIpxGGGiFaDIa/lmU1zdMo4QBw0qThI3/GJwqcII//05KReeRQVXVD4wgNaTqJ3r7Nv94vlAguveKUpqTnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021118; c=relaxed/simple;
	bh=HCkAMf03k114DoOFWrp+FmRbwskZckew5wPKbIDhAQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nk+Q39KY6xZgb0scVDwbYNu2xcjMchhzsXz9i0vFFbJZGjTWPhXWtY7XzC9rg/2ANp2JEmUf5NBQeSgDsaWtyldm9m2Af3m47ToFdRFMnDju5XO9mo7+De9pnhfFW8db/Grlx5iyuLLh4EI00cEkl4ze1soQzRC5QxY8Mna2m7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EYF3LFy4; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuJolwArsfD4wgslL4HmMe7HHsFTMIOfjysH0jGKRCEk+5A21gPKXiDI7ikOHx35bnZeev7e2IxJF8IPTAw6Oqc1Oj5n2Tw19ebEHt1YwFtaIuxoQSb1cpbpPilBrz65jk9HBo2IK/N9JjBOwvh4KiJarEMXE9yQShuR1jsdgNfFgzk9Jaq1Ku1zcEVGVI/N5Eu2F2s++Dq372uZ+ZFH6dytOWzM88ZkUON+AO3Qrd019u7m743vhmqJwXOsCCit7C+JGAd9vqlb5Tn0IcRgibfQMhEqztvKksnpIYj9I+xhwPETAKJnc98bIfUswT3OV3rYsyE1yUmTGlDMdOQkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3cLk7L57j4NRYt7PcGfIDcPG8O0HeTD5afsCGYehdc=;
 b=f37G+T7gK1niipVvRDgHwBCVTvIJUtTHJL6EFXqxWuC6T+UMSaa7ct/2+efViKk1a4opQ9wlRUiO2KN50UbhabPD5rRKwljSw8/nA2h96V5zaheBpw0bRY4bN752vfGxiMq6zwYMReBfPXSw0Dgoyhn52E4c3rz6D92/FUp7QtAJKWXntJ3owB7Q1wT2VVlPjK5RFYt+6a4ah1+b6o3UDGbg3RZ4YPuD8TfDkfXNslJbFAjlef5ahBMDdoeO0coRtUhc1iuTEbl6XGJfmWyV5+gp8JBDT3nYGj1Jb4G6xrovLaWc9FqClXwri3Bsw6sVgXBa5L2NHKpCrTO5AJgysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3cLk7L57j4NRYt7PcGfIDcPG8O0HeTD5afsCGYehdc=;
 b=EYF3LFy4ECFnh+q90ehhc8Ro3h4zx1TXIRRIs9lo9rbYW4BbAhk26s3AZVFjcA8Pwmd8nM2IHrSTz88IHqAz2DY8AhsMPrbOhB7K7913+663p6wLLsTf7R2e9HwLFwBbt4fAzUGBDOmL3E5vyJGw4dul6mLnzArb0XZRZiV+tJ4G5yTPfQLZvJkh1dBrlEPKEoDITNxBx5qRwYaVB8UMsIbdsNzgpq7ZZizMsnwTJ6z8Z+ngDusQ1SzKQsnVCSEuhOpGOPRbe7cuJuZsGdSVf2Y7NztPHgxQwxmUEaNVhCJMq1X5ClWu/GQkVlEnlsPisOnD1vwUIBgk9SUimJuGQQ==
Received: from BY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:a03:1a0::20)
 by SA1PR12MB6776.namprd12.prod.outlook.com (2603:10b6:806:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 11:11:50 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::7f) by BY5PR16CA0007.outlook.office365.com
 (2603:10b6:a03:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 11:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:11:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:11:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 16 Sep 2025 04:11:37 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 04:11:34 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>, <idosch@nvidia.com>
Subject: [PATCH v1 3/4] RDMA/core: Use route entry flag to decide on loopback traffic
Date: Tue, 16 Sep 2025 14:11:02 +0300
Message-ID: <20250916111103.84069-4-edwards@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250916111103.84069-1-edwards@nvidia.com>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250916111103.84069-1-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SA1PR12MB6776:EE_
X-MS-Office365-Filtering-Correlation-Id: fa193de0-0cc4-482c-8d98-08ddf511d5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DvUkuKkVP4EdCNsQvcN08XB+9zobW27Us6ZxhlRsc4Dslu5FhQhdvl3s3ljP?=
 =?us-ascii?Q?v0U0qzwtputkCq2+xHdGzXsJiLa0fkum5TYbiPRHk51K/w6eFd/mqAqr3am8?=
 =?us-ascii?Q?qkUW7itGotRm9537FHoOCCGaR9N3em2k7eT0NI1PMy5vaJ6OUkAEC279fbso?=
 =?us-ascii?Q?B1g8AI1JmGHsbEsJ0RcX//AY4E2FoY1+yTotfpEyKbcdsfPF19eJQ/tVv2zx?=
 =?us-ascii?Q?w+73Xe1hxFoH04TK4ggkPSYZvdBEvygtOHcZMR9TX7VO7VPIGbcefq8WyUwR?=
 =?us-ascii?Q?5r2vOitJeB8POQ0n4YS7rWFsvW5FhUJleG0cVpNA2kDTslulDtMmMeXmyFhl?=
 =?us-ascii?Q?mnzViIx+LgZxmklvUgxTZQYnMjho/6Db8RxGs7Axtuf3dPGgTFqN1UxhBf/3?=
 =?us-ascii?Q?g95WjwMsYd42FgZwv1p8ABeqO+sWB13TqW0cNMP0fSv58JUxiOvjF6Qw837C?=
 =?us-ascii?Q?9DEp5aVZ1mG5/Q6A4ZFBEsLffV0HS99EAaG2cTdY/Y8HIcJ04DOOWhoz9UIF?=
 =?us-ascii?Q?krK7UO3Ds/EL4jtIyyyRnsG2tmga8y3658JqyoPYtO0TTBbLFiVVU9gcD0vv?=
 =?us-ascii?Q?qvgfWUpww1VAswEn1z7d5AeCofmE9jYZAW16OseA++bw2Sr7zsJ92UjqDi3w?=
 =?us-ascii?Q?GGVaB+vGjH/jyI8EMRudQyZBxlh3ThjjOzRDWpMS+FYpWNCbjD2VpE2EmwSR?=
 =?us-ascii?Q?avTNQevXfWZafefzufiQrbJJOLBuH7+NU0XJuXmSn/RypJigLSmwkHZ+JCvq?=
 =?us-ascii?Q?K6CbLD+2c+xFAPSuSgiOqoZmadZaRQh3Elf4E17NoE1hliU5HoB7hC9GIwPW?=
 =?us-ascii?Q?xoPDYNu16c23Rvy6ZhtxM+97AsWluZbtPUWE0J2lG2xo8X4pwpR4Lgb1vilG?=
 =?us-ascii?Q?2ZMq91fXL0y3CdQ8aTMy0opxS+t0hjlBlDCBUN99LiLnTFaH+L+loUKPGnxX?=
 =?us-ascii?Q?GePZ8+lczZvuSutCFE8UUskjE8W+XRCTqbo07z7Hsz+SWPZkAJuN+29M4TkJ?=
 =?us-ascii?Q?OfgHtlGaMoTNjGIidcnBBEi7mJ1IOwk+hm3jYLWdtaeca+6csWHuf7+D8oz7?=
 =?us-ascii?Q?6T5FqPF0K4wsSlftW7TWi/aCmat56T1Ucu2gp1KG+5Kx4jFeSZTL4DaVVyph?=
 =?us-ascii?Q?yxbhWWG8uUNC973Mnry/iL8rJS54ifpw0HDBEhms/hX9cgg2se0gxJymWWu4?=
 =?us-ascii?Q?M7jlUj9Nm+99ciM2XXnfufKvtrjIbtxOQ9ZE1FE0pnspQWZSogoIIhqeGqF+?=
 =?us-ascii?Q?Wz1a0ZwTSIUg/EKh1FLaQmUSEddaNiJsYK3DGkLregyrNSmZkt5VUszDfFIT?=
 =?us-ascii?Q?dBnLmSaxH0UuZttd5r+h2Zdlb+9/o1qDmupakiVQ719XA/KsM7XoNgHp6g+G?=
 =?us-ascii?Q?QpL1B3EGies0Uh7J+GceELFJHTdJs6XclTsD6cVcQwRIF1qMV+ccu1q5dOkw?=
 =?us-ascii?Q?aM+lfCQHctFZp77kpwD3sEXFHSALBlRrpnq6rXfq6MRCWf0BkzEWLMORc+v+?=
 =?us-ascii?Q?bHIFCqs4+u4irI6uSSa7KLButB519JZDJ2yz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:11:50.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa193de0-0cc4-482c-8d98-08ddf511d5b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776

From: Parav Pandit <parav@nvidia.com>

addr_resolve() considers a destination to be local if the next-hop
device of the resolved route for the destination is the loopback
netdevice.

This fails when the source and destination IP addresses belong to
a netdev enslaved to a VRF netdev. In this case the next-hop device
is the VRF itself:

 $ ip link add name myvrf up type vrf table 100
 $ ip link set ens2f0np0 master myvrf up
 $ ip addr add 192.168.1.1/24 dev ens2f0np0
 $ ip route get 192.168.1.1 oif myvrf
 local 192.168.1.1 dev myvrf table 100 src 192.168.1.1 uid 0
    cache <local>

This results in packets being generated with an incorrect destination
MAC of the VRF netdevice and ib_write_bw failing with timeout.

Solve this by determining if a destination is local or not based on
the resolved route's type rather than based on its next-hop netdevice
loopback flag.

This enables to resolve loopback traffic with and without VRF
configurations in a uniform way.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/addr.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index ca86c482662f..61596cda2b65 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -446,31 +446,40 @@ static int addr6_resolve(struct sockaddr *src_sock,
 }
 #endif
 
+static bool is_dst_local(const struct dst_entry *dst)
+{
+	if (dst->ops->family == AF_INET)
+		return !!(dst_rtable(dst)->rt_type & RTN_LOCAL);
+	else if (dst->ops->family == AF_INET6)
+		return !!(dst_rt6_info(dst)->rt6i_flags & RTF_LOCAL);
+	else
+		return false;
+}
+
 static int addr_resolve_neigh(const struct dst_entry *dst,
 			      const struct sockaddr *dst_in,
 			      struct rdma_dev_addr *addr,
-			      unsigned int ndev_flags,
 			      u32 seq)
 {
-	int ret = 0;
-
-	if (ndev_flags & IFF_LOOPBACK)
+	if (is_dst_local(dst)) {
+		/* When the destination is local entry, source and destination
+		 * are same. Skip the neighbour lookup.
+		 */
 		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
-	else
-		ret = fetch_ha(dst, addr, dst_in, seq);
-	return ret;
+		return 0;
+	}
+
+	return fetch_ha(dst, addr, dst_in, seq);
 }
 
 static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
-				 unsigned int *ndev_flags,
 				 const struct sockaddr *dst_in,
 				 const struct dst_entry *dst)
 {
 	struct net_device *ndev = READ_ONCE(dst->dev);
 
-	*ndev_flags = ndev->flags;
 	/* A physical device must be the RDMA device to use */
-	if (ndev->flags & IFF_LOOPBACK) {
+	if (is_dst_local(dst)) {
 		int ret;
 		/*
 		 * RDMA (IB/RoCE, iWarp) doesn't run on lo interface or
@@ -538,7 +547,6 @@ static int addr_resolve(struct sockaddr *src_in,
 			u32 seq)
 {
 	struct dst_entry *dst = NULL;
-	unsigned int ndev_flags = 0;
 	struct rtable *rt = NULL;
 	int ret;
 
@@ -575,7 +583,7 @@ static int addr_resolve(struct sockaddr *src_in,
 		rcu_read_unlock();
 		goto done;
 	}
-	ret = rdma_set_src_addr_rcu(addr, &ndev_flags, dst_in, dst);
+	ret = rdma_set_src_addr_rcu(addr, dst_in, dst);
 	rcu_read_unlock();
 
 	/*
@@ -583,7 +591,7 @@ static int addr_resolve(struct sockaddr *src_in,
 	 * only if src addr translation didn't fail.
 	 */
 	if (!ret && resolve_neigh)
-		ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
+		ret = addr_resolve_neigh(dst, dst_in, addr, seq);
 
 	if (src_in->sa_family == AF_INET)
 		ip_rt_put(rt);
-- 
2.21.3


