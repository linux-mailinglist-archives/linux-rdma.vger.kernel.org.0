Return-Path: <linux-rdma+bounces-13408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C903B594E1
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186DE1B2804F
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4EA2D5C8B;
	Tue, 16 Sep 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwktyfoG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B02D47E7;
	Tue, 16 Sep 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021122; cv=fail; b=kJxpdNh3UEvt0QMEawkAA0vr1SKoPAxd8+1XhwFkKmtsqujMp9En1AqCJVZqVo/paF7csmYMnn+FzqbW/tqCI0b9schQRALagRnYUs/RhlRW3Bl5yat1lAP9OtzsAx4f9N4jabn2tzx5b582ON8nehPn1H8YNm5dshiu2kTsYXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021122; c=relaxed/simple;
	bh=jvDsx23r7656PRJQkOJhPKUK6Om1WcNjKbkMlQ8urc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1nAKAAELp7s++7BatIsMSnraZ+vkv/pmRK4VHdv3XPDHQxajd8W8GsQnbCWHtQBH2PHlftwmRkEybE63OjoGtDH0pRdu1NrgQwRizPNZAhakmscdhkk9uzvC6Ge1iqXHygSsRiZNqMZGCZqMCSpkP6siWmsovnrNOWPKDmERZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JwktyfoG; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQYTCPRxi/XqxUsQDOVblRtmzUv6kXQRxcuhrrJeB92ENwkoXNmUFebL1cZ3fAGEiXfq5zr3vPjDnxoDehLS31Qo03WXgSkyUn93yKLj38M4EQAFP6SIDfh+kKtM13dZ2P+5df7f9gjiyYHVY2Ge5fP/121bJA++J8QWPdOZt1Ou0vctV0lUUJAFrS5wWwOIoZTev8Y8h9fzIxZMCqHf22Qe+t5ghuU7ePIUDV2/7lnC69OlgirFD1Z1o3E6ObYXrWBiWKMk3IeQ9RvDwqomDSzPl/hXEdobaursfTm833bKCjsEw1c0+M9ekdYXXJFGFOD7pPHKErizIa5rvCr0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UP71k3g+COjwDowbjjJkamAzZGTjqNh/4cZUz6cnWe0=;
 b=JVul5+YolDl4+ygwtpdoenEjbhDruiYWvDfWvOQQz83RXKhNxgu4MyL+4Do8ysJZVNTQ/h5i7bFXODU8a/p42MBb6rPT4SR/iK4swysqFSxtgLO2R8EPJbaJ1wkj7a9BMChyo9rE19IeRFDW1CMF22zuvEagSdXao0z+0OZKqeXilBOCC3EPWtDpYjCMvkEPlkJOVLNaF9AcsZ1mW9rxnoWFzFq4pubPLowryh2KLirQcppFkM9Q9qq6qs9jhbIOc058Euo45nNDYPKp5ILQmL5mJw+0cSc2mlD4vtP0KUMSe1DikCQbNQSA8dy5Y98D3Q60OEwkcSeF07voBipHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UP71k3g+COjwDowbjjJkamAzZGTjqNh/4cZUz6cnWe0=;
 b=JwktyfoGAEpLrPILhK8f5xPtTOIVFBqTt5SmPqQN+irBB9o5Iu9/IywTIPCcltwdBvvKLLCiKaJlGLcak3zYvkoyOtRImzmiIAdULGS1gii1HNpeWkWDWIrAd/g6sfGpgH2Jwd9kCcj7IvErpviV+8EOHmgNn80vWdOU5dLINwJMgf4v7Euv4PpTN96XXN2db8lTZbjy2jx2Ic13Iuyzju6G6w66xQFHpPSv1K+IhoEgFAFCU5olAKjFPgvZLgplCa4dpd+QP75JjJjzkrC7xfs9+yMfecBHnFZfXlKJp+Wx6PpncxrFY9JtNoBvx9RvQ5yqGPhPLyyh/P0WQJGDpA==
Received: from DS7PR07CA0004.namprd07.prod.outlook.com (2603:10b6:5:3af::13)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:11:54 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::aa) by DS7PR07CA0004.outlook.office365.com
 (2603:10b6:5:3af::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 11:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:11:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:11:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 16 Sep 2025 04:11:42 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 04:11:39 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>, <idosch@nvidia.com>
Subject: [PATCH v1 4/4] IB/ipoib: Ignore L3 master device
Date: Tue, 16 Sep 2025 14:11:03 +0300
Message-ID: <20250916111103.84069-5-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc55c08-cdd2-4bd3-99ae-08ddf511d772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjSyh+v/J1ku1wweSizQoYHV3UU3q07VycM9drs4KgsoDcPwhdj2RC12L5nK?=
 =?us-ascii?Q?0qJ2FrSvgTaAeYDnhbK0sWHISAyWKF5vAZFYTPBnZDI0LkqNHDYrSCzCwXW3?=
 =?us-ascii?Q?Zk3dJTs7NxDkCSILu7jllYX2/EF+mAxfS3Dbzg0Y/FlQL54q47Iw3GxTMfym?=
 =?us-ascii?Q?NHhf2W8QQCd1ajVLjAuHc8TfE+uxmbX+Rv8TZvJ62avlwRfBX3G9Ck2zuPJY?=
 =?us-ascii?Q?QFFWV6dfpE8ftapT5GhC9fU08+bMluZrhT2/hEBaf/hi3c/8uhP0LjUDVEPw?=
 =?us-ascii?Q?KJAxBkA/NQ8YttI2whrvxzz9EfAS03lT1dnsgbOGPgxQvIOwvDfglToBYKPj?=
 =?us-ascii?Q?Sydb0ZI67b/3mNUV1eiwa5B/wSqsvvf2Ix/zfCAbL9gwiuKFfWrgaCu/4E5m?=
 =?us-ascii?Q?RBIXT94qzi0y5ZlRvfGaW9tSTHXXkjyGwej+PSU5nqqyKxjaBtahGRR3yo4C?=
 =?us-ascii?Q?SzxT2MoQHSedX0lQw9Jqe/kcAMl4WOvJq5Ktr21xq1KJbFae43srjjugi9cn?=
 =?us-ascii?Q?wLFKGZWUjWanp2Hsp9J5ZLtBPJUrZzZT8BbLjKeNHj913hjYlfkHWh7yq46D?=
 =?us-ascii?Q?6wmpgU6DfX2WCmJl0Gdh+4WBtbFqCmR3u/z4EknvRQkX0jrw1ZkTqFJnskpW?=
 =?us-ascii?Q?aRRh7OMmeL+v/Rtcewn2r4iQm2gct/KcW7RRrdT56dKAVxATfPHLJwciydIF?=
 =?us-ascii?Q?YucmxwbJ4ryndJiYlIyDUCKusuJ5icZSFJvIHU5gakYfsjuDE8gBqWk2J7rj?=
 =?us-ascii?Q?4Av0iyM2St3pz67XFCf7Dgdh3KtGPyQpdHRXQsucGAoUpfdWqjmLVOrZGvmP?=
 =?us-ascii?Q?t/x1EfTBbOPgWe1+wNN6RmtqCeiyvjvxczJAwmegOa/8/hNpb/GPB1sxZGk7?=
 =?us-ascii?Q?/bAqc7HOSVC2fM8FY/CxOu4mJZfs3jknUlXq9hu/uPkBM14Q7gFG+xXaCRws?=
 =?us-ascii?Q?tzMpwObWEpEhih19Hq9tHR8Z5OWSgoMaQ6RRhrRBUk4X5riQ+VbX4osSwxSe?=
 =?us-ascii?Q?fIZtWb1Dx1T+3qPG8+GELytbY+D4sIsuqmTSNtnwMk1xy9tdG/Wh33TBkMXJ?=
 =?us-ascii?Q?DTXEz75MUHJ1bQmXCC+b3O7aYEEQdxXk1A4EZLU2XWAUgZKa0SEmknP1UFQg?=
 =?us-ascii?Q?hmg1GckYeUtDWeY4YyofKSB7T8R45DoAYee/Dpz47XymmRxVsv8B3/2BTuj4?=
 =?us-ascii?Q?xZgiBdL6HnK4HXfZidjPQmhxPmbx8/n0F70yZD2+laz39OU6SPqTZrXIzzDL?=
 =?us-ascii?Q?8X7fb5ypI3EkeUWctsog6LP/qMEnhC4qVP1gGWMBct357hQL7m/p/E8DdnFN?=
 =?us-ascii?Q?9QgfORK8BqkefDFwYIKdRP9MuUCd+c+jKCFgMy1aYIn6Fyk1XtpLj1kU/Fbn?=
 =?us-ascii?Q?UghMunAbPEp+LY1PkiZOlgv5+Eggkj6JD9TDOClibOTTK8YT6lHPON86jSvy?=
 =?us-ascii?Q?tyWuKpHZQcS7/P77Jx8DvtcdG5DCYzMjjwWMTW56zNHmK90ME2fwcb7uZvNf?=
 =?us-ascii?Q?kxyTy4sINd9FZalVL8SaEsrujx8bstO9MvKu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:11:53.3803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc55c08-cdd2-4bd3-99ae-08ddf511d772
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226

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


