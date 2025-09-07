Return-Path: <linux-rdma+bounces-13144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5DAB47C4D
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5736E189BE8B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65438286D40;
	Sun,  7 Sep 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NjhBCWAe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08A283CB5;
	Sun,  7 Sep 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261502; cv=fail; b=RCHWO0IhRnx1nWQozV7fjDENWh5dg0dS/2Eiin7Hj4rMBNg93oZGQRbxhHGvacpaiW5dWgPshPRfT///TETFg8EZHxOdBbJY1dBey0ke4t8QfceGET8+iVc+deW0gJIydSYvdKmVzi4aVb4+VpG1sEaPWTrq7hi7gVIqdn9fTcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261502; c=relaxed/simple;
	bh=jvDsx23r7656PRJQkOJhPKUK6Om1WcNjKbkMlQ8urc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObMwm6Vd9T5TxOnlNjAKiEepJVdHtc6okgrwErllgykVjrQug9Bvn2XPirhsPYAv7aq4ofLXK5pSPxzkYeoFm4kqs/VOc++FmhmDwxJ9a7LfXuyWrsSRhhGDKcuXFQbLSWL6rx8vAfUxOaBXUJbISssdqdszy3lu9FnWZ9wN/BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NjhBCWAe; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqyKPFUW5gZ8U+ewc3DY6pbBDNnJkEFGf05ZZjxvpxDswreUAZsLsQOX3E3nwh9mryAZTGbmdEHHeRsiSnHWMKT1tZ6/djXzDrGn7+lSjgIMZNFSpHVihtsso7DcLOa2QEo5rMMMPEMEZ+mMakD2n+wRtBTg4yom8x6mf+krtp1riZoDU6a3LycpJbWXevcp7Mq0k/Mcftlsf3elyHpuVF2FLqvuSWISFxKFOh8nh9ym0leKx69uqTQBQiXn+s4bxbOF5nEUStvsCuWDEGdh+YmSlVvq95wubfFFXZ1iCGWADOzGV3JIsdLUwY709ymvP9ogHpv/1grC0M/L1eQRVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP71k3g+COjwDowbjjJkamAzZGTjqNh/4cZUz6cnWe0=;
 b=Wr7yeFrIFm3n/NhlZw7FjCbO5s38HD/VMhoatSCRO6MTWCcv6O99bI3SUg4dXdBiYiDMF+Nl3gOgmXmF3EKn7q2blhPB4swHkXn71ySwiwqYRvd/xacEeyELybnADCmaYM1v1is12/mP2zHAbDl+NoEmpMkr0NKwa5/+T35Wa7NlfxYdPE8ZsHzkgJmRwxUtQA+5V8NKaGJK3c/NU8ezzAbeF3ZwhcUfIzv+cljzOC2dip+q7b+zTZD/imfhtT3MnHukMYr+ft5FKkYqJ2juD3WpFuFI/bsDWCoyICJVktB08x8cOBvt+5G9dR7qwY7GvbNqFf5uHZ7eIvt8vBG9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP71k3g+COjwDowbjjJkamAzZGTjqNh/4cZUz6cnWe0=;
 b=NjhBCWAebFJxRacuyiiVwRH4Jet4KIsP9XKQ7EmN37/E27aZYyl46gc34jdSSlSdy683UeE8gH017KRroFrcV7p7TOyJxXrHXmCL41bOzq2WLHM5TqGtWHnociiMP0DRNyeg2MfRlyP2VfH8fuOxGWawRdSSERqvMKXLElEcn14dtGhTukQh0K0zz1pePrt+95gxuPjIrPynwjfHMThJWjXOCM0T9p5btzvMp8ZMgSenU7XTRTrukrWGxR7rKtXmDCd4DzxXCLSzRRf8kvPtzkw8v46FLYLchdm8SKWns0sf+RNTjHgiyy7i1+U1nESM+ruycLe7bN3dvpjbCFrGNQ==
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 16:11:36 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Sun,
 7 Sep 2025 16:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 16:11:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:11:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:11:13 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 7 Sep
 2025 09:11:09 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>
Subject: [PATCH 4/4] IB/ipoib: Ignore L3 master device
Date: Sun, 7 Sep 2025 19:08:33 +0300
Message-ID: <20250907160833.56589-5-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cbbe78-b810-4fa6-9d82-08ddee293834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cALQRpOhg4co7QbcSM6cMTdhfYcA+aL/DBTOHgEkO5sOm0bMM82IQnpMC9Dg?=
 =?us-ascii?Q?fjpfk8YiUqoTWAdlPmXaxlLj0qucbWld7xTcI0zp3yKa412a4CjgiXS8LGuF?=
 =?us-ascii?Q?U0RSG9ppYs7C0bQX1RO+c1+3GfPcGAgtvTdGAS7u9HH5LsUHI1ya+Wqf3X88?=
 =?us-ascii?Q?eigCI5GTZ+eQqbr1tlw7UtIYnYQLpyK149JVRhSB86cSfV0xp7pLtF1siF6P?=
 =?us-ascii?Q?4pS0Cu7LseqhmYeO+jwLSuxPXoP/j+VG3vc1G7+pw2dQWk6/YvfRcFkfzB0q?=
 =?us-ascii?Q?YG4/mEgB6uV6VC4biK493YLbSFXH8tjTnMNdSj71juqoxdsjsSpq+IT5lnZY?=
 =?us-ascii?Q?IrU6Q69y4jKk3boIYpFJdq8QwrEiYPYwuOPcyIlpZhMQAsw6b/FI1haRPnB+?=
 =?us-ascii?Q?IcVkxFY54M5xhXpQI9DTf5CZfZ93DhzDNilmzbuV92BDUtfpiLLR14pLM1LO?=
 =?us-ascii?Q?aUguG/CkdD/r9IpuJxXIojdKVlT+wy5KuO2kd70asMRrh9XxFZKNpifphheh?=
 =?us-ascii?Q?twXf6P+dlgBbke9SLFLVXIqhVYVmaaU+4uoSY+BfmLhGmvrp70bMQgDKRd7H?=
 =?us-ascii?Q?20LpXNDi0f4HxI6PeUIX2uY+JhK+1ce1RVU6R3sBRNDSvaL38vL0QsDFSh2A?=
 =?us-ascii?Q?QKUuhtY3EXMv6b+laJyP9Td+oSM5CzRydVANSpGJwZxgU4UetuZTMjjUjuRU?=
 =?us-ascii?Q?1rsbdaYhPl+cS5rN7eze/M/yFr0yj9vykCxHkbzzFVCeK7Wx/gKh8PbYUklc?=
 =?us-ascii?Q?h2rKKZnkHO5bJYDKMP/x3wM+BLV0TGoenSkKqvK80p65uerCd9t0dyjtEp9X?=
 =?us-ascii?Q?m/SU/rjPJBOpKw5WzSO/eFoiEtzzlDaMRnQpaNg2y5K/Gl9R2h84C+38mpmU?=
 =?us-ascii?Q?Y3Nnb43RlmjffbYvvsmwbo7x0WK68ASLRGRz5oFUaGlGsYMhdY3ejMCIDjay?=
 =?us-ascii?Q?KeFac0LvHI44sbodlIP18ZgEsSqGk3nQVDCFfs5iR41+eLdK1xuduGNVP5bb?=
 =?us-ascii?Q?89thXi0cDDs1Nbf5UawyOYORbkI16VrmrxkNjMENxJcG7OiGyg/Sb/ass4G6?=
 =?us-ascii?Q?NNGaRClh5ilMcixRkMFPyimHeMY9/vgY2qo7qukG5EX5OGN94LL76ka1BT90?=
 =?us-ascii?Q?Q/S4M9iPir56AV9/RMANoIbfjX1ckfWVcCurZlBmTNSaJaZW4wcJhmtUImIS?=
 =?us-ascii?Q?pwTbVcTF1/VKE+scWh6TxqzL/Zuu+xQTHM5VEZih7V5jDaLqAN8PUBOPRYwK?=
 =?us-ascii?Q?22WtBMj3KiyQmkxX8Slm1OS/KUWvni+ttVM0qncaK6bzXLIpV1xpcj490fr9?=
 =?us-ascii?Q?I7fEMLz0y3sOKWJHzXbzcNzHAF98KeMmkE9Fr359X5lfEWsAFPHSF+Nihgea?=
 =?us-ascii?Q?e7ti1jLu8Scat/N5t3fgqB1pdT3lvTMgcaJJVh4gUfj92x3fi2/DoixyB2yH?=
 =?us-ascii?Q?HoPUeNv88t5aohCDBPga++Uvapey+HV8AtfVOieGeOgoTexGnmMzdwEhC2+c?=
 =?us-ascii?Q?8eHOtM0UudsSujmkJE/Rfu+MDe+8rHGiESpA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 16:11:35.9934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cbbe78-b810-4fa6-9d82-08ddee293834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Currently, all master upper netdevices (e.g., bond, VRF) are treated
equally.

When a VRF netdevice is used over an IPoIB netdevice, the expected
netdev resolution is on the lower IPoIB device which has the IP address
assigned to it and not the VRF device.

The rdma_cm module (CMA) tries to match incoming requests to a
particular netdevice. When successful, it also validates that the return
path points to the same device by performing a routing table lookup.
Currently, the former would resolve to the VRF netdevice, while the
latter to the correct lower IPoIB netdevice, leading to failure in
rdma_cm.

Improve this by ignoring the VRF master netdevice, if it exists, and
instead return the lower IPoIB device.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 7acafc5c0e09..5b4d76e97437 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -351,26 +351,27 @@ static bool ipoib_is_dev_match_addr_rcu(const struct sockaddr *addr,
 }
 
 /*
- * Find the master net_device on top of the given net_device.
+ * Find the L2 master net_device on top of the given net_device.
  * @dev: base IPoIB net_device
  *
- * Returns the master net_device with a reference held, or the same net_device
- * if no master exists.
+ * Returns the L2 master net_device with reference held if the L2 master
+ * exists (such as bond netdevice), or returns same netdev with reference
+ * held when master does not exist or when L3 master (such as VRF netdev).
  */
 static struct net_device *ipoib_get_master_net_dev(struct net_device *dev)
 {
 	struct net_device *master;
 
 	rcu_read_lock();
+
 	master = netdev_master_upper_dev_get_rcu(dev);
+	if (!master || netif_is_l3_master(master))
+		master = dev;
+
 	dev_hold(master);
 	rcu_read_unlock();
 
-	if (master)
-		return master;
-
-	dev_hold(dev);
-	return dev;
+	return master;
 }
 
 struct ipoib_walk_data {
@@ -522,7 +523,7 @@ static struct net_device *ipoib_get_net_dev_by_params(
 	if (ret)
 		return NULL;
 
-	/* See if we can find a unique device matching the L2 parameters */
+	/* See if we can find a unique device matching the pkey and GID */
 	matches = __ipoib_get_net_dev_by_params(dev_list, port, pkey_index,
 						gid, NULL, &net_dev);
 
@@ -535,7 +536,7 @@ static struct net_device *ipoib_get_net_dev_by_params(
 
 	dev_put(net_dev);
 
-	/* Couldn't find a unique device with L2 parameters only. Use L3
+	/* Couldn't find a unique device with pkey and GID only. Use L3
 	 * address to uniquely match the net device */
 	matches = __ipoib_get_net_dev_by_params(dev_list, port, pkey_index,
 						gid, addr, &net_dev);
-- 
2.21.3


