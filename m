Return-Path: <linux-rdma+bounces-13143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C99AB47C4E
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 18:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93113AFE56
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54A2848B3;
	Sun,  7 Sep 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KzwE84H2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4B283CB5;
	Sun,  7 Sep 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261491; cv=fail; b=u09qM718tveZ2aAC3HaG3vQqwrKn8z2gZgJvKptO44BWwnlIyICPw7g0FyX4RmqSdO+E7XKt1Scg/t43XBVv0UcfzfektIfcc94blJvZPvlVu2o5ATwnaA9h034hG9iqewzkatSTuAw2psDB6Gh/Qpe/DyWQqClG4WhyoSus5uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261491; c=relaxed/simple;
	bh=HCkAMf03k114DoOFWrp+FmRbwskZckew5wPKbIDhAQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OR9gUYKOS4EV10AjU2/B7jmGNuxVN160GESjFXPUp6ZmoM6mbfxAtlPFu5dTJQo1BD2WFTcDQw1XgM9mEUT5PzPLDc+2WNuVl3X0BPKovgyIBLFxJQsRwjB1wwAnFHuB6A6JZxJ1jLfqr32dKNmVnUoMxp2k0dh2sSWgunN/DJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KzwE84H2; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZwT8ZYu7IvqZf5SzF1DEDnNTkwAbsAO8XbQr5t/TRV5sVeN285XR37TaU22W3oKhRcPTqP8q8mjEMRJHYRNfPOW1ZKUb7FoFHDIwf8ZFeUCD5lvaYLgkehEBZefce5sYItRoT2CWxr3ONi+6M8SyPO9Z4Qkk9dqr75/0QTc39nWBeWFzNxCCSnyM66WkzsmjBhrY6aQdjzRvgclM4nE8LR5+h26hp63iR1NOcYt8Q+KUA8isLSeXh2W13lXoNT7GSarN/FM+HEFtUqzCbJlIzF63RAaYIdfq9dPc/iIzM3KHPpIjA7yFTIQtHNhnyUuGjSO83GWkREFuAPUvo3XAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3cLk7L57j4NRYt7PcGfIDcPG8O0HeTD5afsCGYehdc=;
 b=fhrISagCtOz8+rFn04KIlMn0yqtlxo/S71+RIWn5GUSPUBam+8Yk11fMnKnRox6rCAxjVvo5rdv3MOEemWm/EvesKy/j8lewIZkxyjJm7v+uPIouL5KjnSJgpFkvJly2xwT77Sgf99nJpQJxsY/oTxUm2ude3/Jpo+ORJfj7zvMioIEltY7Lm4r6m7bOBkr/cGnpTMjRcY2EYsBHUFCbri30FWwcOkulL7BrJ28f78WLROkFFLfALA6cMvH8jOyDmnktPtvqP2x5Q8SxWiV4eS512fwXvfC6m46XiCrhltbWO+eY90SEdBVhK0zzCEwkx9fXNbOHGdRSWRGqaclsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3cLk7L57j4NRYt7PcGfIDcPG8O0HeTD5afsCGYehdc=;
 b=KzwE84H28EodxxA5l9q1TQG3T5NTjtOVJNu6CH61+21WdZOT0euPJES60DdXOEHSIcu2y5hkTV2VR5L5LcNxzdpuBYhKrcgZo/ANcGMijNlSmfHIRLYdn36Z74/r90HO4bZLUwaH1tU9YhZajsHYj8HmxQNGDQS8R7LQK/+v9y7HrjcGB6wp7wGJY7zi/GeGdrizIp4Rq/7IRjB2LymKc6IYFbsioWyndecG9icIzjmEVXgHhB92Y1K0izdvfWvoHXqzM2VMWUEX6wcmBezHtVmR34ElFXKZQ/mkB37+zk0AZJAM+I/TYbCLtBwW/cC6XxmXVfHoIKfdfNjFxvFUgA==
Received: from BYAPR06CA0020.namprd06.prod.outlook.com (2603:10b6:a03:d4::33)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 16:11:17 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::25) by BYAPR06CA0020.outlook.office365.com
 (2603:10b6:a03:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sun,
 7 Sep 2025 16:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 16:11:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:56 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 7 Sep
 2025 09:10:52 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>
Subject: [PATCH 3/4] RDMA/core: Use route entry flag to decide on loopback traffic
Date: Sun, 7 Sep 2025 19:08:32 +0300
Message-ID: <20250907160833.56589-4-edwards@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250907160833.56589-1-edwards@nvidia.com>
References: <20250907160833.56589-1-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f6ee66-39f1-4eca-cbad-08ddee292d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NY6SDeNON4d9Gsc8t2aIYeaP2g7GdKfGT7TdZymwOGnhN05pCuSVtVzCW5Wv?=
 =?us-ascii?Q?kxdRg6RrkQ/QYw0ikIAoRrJDLBgE75JuUlA8GJPjboPacxr82cJreevNP5Ng?=
 =?us-ascii?Q?WCFhBTxgaK21pbkNcHulSsygZ7SJD6zz/zt+zSxzgDh+f2NFQGyNLRGQXiN7?=
 =?us-ascii?Q?Dhh7f3n7+r97JzR4/5c1XFZTtFQjrln32oZFU6VRPbb+WyU1gYvEJKGN382U?=
 =?us-ascii?Q?N7aXEUCsWdET0V9TPVbQ7jrX644Yfz6mOEur6CmS73T8Vrr3U8qOrNyEDAF5?=
 =?us-ascii?Q?hi2wqPW7MkxwA1Oz7KQAB7k5XZKYrwlVfQxNPtMsYgbtBEmmt6TxkPqxOAPS?=
 =?us-ascii?Q?SmgJgxxSn9GaOAJpzADR6+Vum8axF9nmg0EYGw8br68N6Vp9zaoDP+SlvH2m?=
 =?us-ascii?Q?kM1oYTP6S3F4c0fFQt88bstilyCijSViH5GTGz1run7RyMQLzy1tOiCXOaz2?=
 =?us-ascii?Q?Wl4Ft1GlCKXg5UyUGgb3id0jgG+PKyX5XiLvhdeD/6nW2XxBeiqpKMaGzP2J?=
 =?us-ascii?Q?j1mUOahhoR3Q3hZYcyIx75QObUs9TkOHLS4FWFdncSaTa7fU8vzz8IeBdQ3u?=
 =?us-ascii?Q?/HkWaeO6Cr1R3wNXfV3SJuUxQjTHgubVicNMT8hLY/u5B+CkJQCXCsm8nESZ?=
 =?us-ascii?Q?v7973EYJQ8DmAcV05yYSb2jsyHDhLXkCMcLbO15ZfRYrSpFAdOO4qC4E0Yjg?=
 =?us-ascii?Q?pqHn33hW2OTZOuXx4BFOHo8CUrisrxAHgeC99dzPFqZQO+CTXmOeibH4YUaG?=
 =?us-ascii?Q?RnvHqRSa7FXH+oJQJAxdUTPRk1UEHVFFge1oLAapiQ4NbOUGU6JTgtMTSBlZ?=
 =?us-ascii?Q?AUrux3RsAiEBe5CmHikA+A3aFtrXWp3dVx9xSXj61j/VCA9BUsSoOfZBMIDE?=
 =?us-ascii?Q?/Ggdq+4hRPucC/ITDqzz0Sn9EDCamRbah1q2UBM6rfcBn2gVZ2lAxurwnvNu?=
 =?us-ascii?Q?j5XgxjwQD29qLueZ6YuWj3QHtxMsMAgs4WLjEfwB1gc8Dle4/nyDLzRO4e5B?=
 =?us-ascii?Q?x5JI1qqUrRcLJS7WbfYw8dxqA4UKtbiQJZXnRrUQSQu6nBzztAbAtCnHjhGx?=
 =?us-ascii?Q?Xysdw8U5iNj6Gmd2X42eNaUtyroZ6YfH4hdXUVctW5S4j2n7myYqgSB5IERD?=
 =?us-ascii?Q?Xz6Rf9DQ+Vmes6uHlivwD88VfiekYi+b11hE3u4AGr16cMp/IRgFu5FqtTy6?=
 =?us-ascii?Q?pz98t7ZupjAaqJCs760/fNM9HmLeyKB5xf8MmGhBAHe8C9vQwrrTbfHkQUjw?=
 =?us-ascii?Q?B+VBrWEMw44CtUCqwxBP9QCmepdKxG0bm4L0N5yW8BEmyacPF1hem7KEoCj6?=
 =?us-ascii?Q?1Nr4u+nhpq1S8UYY5BfMLlyhQodUDKdwd/AU4W0z12iDVohKQw8o+klk47Ad?=
 =?us-ascii?Q?VJUAgOHzzss947nvsdWew8QvAEgdO7bM57z/mfb7pf0pUDkzZ+n0QR5bsZad?=
 =?us-ascii?Q?+KWqfMmqHhmLMlci16NoPWNX1yzIxiXzwpJAVcV9O5VHtJ1i0BbG4eDNH9wF?=
 =?us-ascii?Q?lFiF0lKyHKkVUZ2SaTf2pQv3gJB248s7mLK8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 16:11:17.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f6ee66-39f1-4eca-cbad-08ddee292d20
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543

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


