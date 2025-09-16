Return-Path: <linux-rdma+bounces-13405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1FB594DB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FB71B27ACF
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB22D0C69;
	Tue, 16 Sep 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ji6hSUri"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A32D3A71;
	Tue, 16 Sep 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021106; cv=fail; b=YJkipN0NcxQtbMG3apx3ol4wJCmE6c/hS55lNvqoOP9noDZbyM7IeZHNFkWFMUaDIziMNSq3CJylyq736HMA5F4CuldG5XRUDuH0JaA8yHLf2c7rlUImiuvn4UrthIEYdjrJ0tLIfgNPTsxsu/fV+9WnxaksAhEKs2ssYbMQWwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021106; c=relaxed/simple;
	bh=dVCpz8aPpI3HJcaUEIpSbYwcalgJatejDCT5o1F7Q2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVOYro+deYEdVi3vkNdNjpEItPjAmo9o+uEwTWE+HeEYiLC32nlIxy1dHTBCnimYQnFrVJR3lutbmN9RJvg8b3Ym8AaASxa0Vr1ZL3t7OCjDbprEFPKfBbKvew1LgL1/9IwT8GRFKh/Np9bAZvJaSeg4afAw2ohQ/ppxGTMTeEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ji6hSUri; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEr3ETyCqrbo9VhmrrV8oubY2v1M0X04mq4zXkkrwp1C7zcBus0aBIzfJlktbjcH4L7rEIxAg1kAmBvpEA2lYhCX5D9z48a0wgOw+PtID206AtP5srPaTxzR6vP3k1BLnrZVfBYnCI5rCLqQkfArnfZzW2YyJbC4QgTqgUZud3fj6B8ob33lnk3qJcZGlXmeMLHc3o2hwP9HF046FLlSRC4Wxyp/TBixCVHqzOGzmpKSSY14eXuQU/F3OcxPBDzrcti0hQZ8W3Vn66361FDn4jTWD3hZIFl2JZzA+nbVFtSu2UDhXq+ebM9+PiJCDoQlHPq3GaC4RdzY6BTovwisxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMhdnsvhPJUAgZZiTI4shWAuOrOzoD8/vxcGwSLJcNc=;
 b=LAyYa1mUl4MALC0F4/sVEwXKOSHCJ6y/B7TEzZ9/dWXY/ZGIIoSD9NVfJhtsbHRPyFvq7AjK7Q7kZkxg1zY50gLeDXaMwCTAfVZQgyARWaIILo1U1DsCoH3CJdj9B4tnowFH27N8UEvp4z/16+ZQ1gjSce+DpNfNaXN5di/xeHactxKHve5s/AlxYTgHH8DQ8FwtMrc2eUhp0Eao5ttbjlriCHWOqeRE1960E5iWyj705oGNEPmtiHZ0dQFv1vjYt6RBnaUDKB3VSw1VMnLBXOSuBegM3uLvrZew/OeSNrbBKbhfsZX8cBhaO6FTjXbC8l3WAK1uvLMSP2NcfnaSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMhdnsvhPJUAgZZiTI4shWAuOrOzoD8/vxcGwSLJcNc=;
 b=Ji6hSUriQsZDuaeGmi8cbPMbJFpQIU0Qzg8zbSZyedjU/T6a3DISvxtY87or9k5IOwlltbquYJMrt0rLnKJfGsIrP4cOl4pe7yrezQ7eHi8nfd8Hwz1GGflsBf7RmUdwu8lgaEqefiKxrTyAEcHrjtItgrYFlGW49X6h3JWIsrG0n6GuzpN8hZiM067+l7HbNrmUyFQoTg0uDf+EZlBkuifoWve82dqQJVMnTfQUpL2CDrmugmI7KqnsFcZd1LnGf0PnVrB0oGp1Czx+Ym3mudZBH/IGBNYc0D+ebpW4er8D8OBLpjgxeCJ3zZshbG7JWmGC75PfEcPocYFr+suUXg==
Received: from MN2PR01CA0002.prod.exchangelabs.com (2603:10b6:208:10c::15) by
 MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 11:11:41 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::81) by MN2PR01CA0002.outlook.office365.com
 (2603:10b6:208:10c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 11:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:11:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:11:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 16 Sep 2025 04:11:28 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 04:11:25 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>, <idosch@nvidia.com>
Subject: [PATCH v1 1/4] RDMA/core: Squash a single user static function
Date: Tue, 16 Sep 2025 14:11:00 +0300
Message-ID: <20250916111103.84069-2-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7b7839-af07-4c1a-e6a3-08ddf511d006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khTNdRQ9CR9ty2aDi6HbNsZHI4pfCzDwJC3U8XRRhLXAErgVbEHv0msjAR9B?=
 =?us-ascii?Q?Mn/WIyWykhmEZNl4Lqli/YKuFuy1Pn12C1kdPafjfzJFIlpogSbtM7TduaJG?=
 =?us-ascii?Q?aHz51aBqTp8sAo2zrJ2iTwAve+a+5FAjD6O379TiO5Jqw5xDsJXXrR7bAon0?=
 =?us-ascii?Q?aB5TFAz6C2F8jxmCLEzoFCVhwx5ddeDL/FKAON2yV0WwZ4nl/KgqglnQE5Z9?=
 =?us-ascii?Q?4KvY/OF9F1MPPNrzOAA24T+8dS4GCa8FBX8VU1igQGAJ9lmW6aQKilznXjgN?=
 =?us-ascii?Q?kDdvgWxrWITr748CN9pIc2wXFT1htntwgBFS7dZDV7o6xxEo5KNCRz0+HXio?=
 =?us-ascii?Q?+cD1zOly6O0+CyPFuQPGylilm8Womh2xt2Z6ao7hq05+39p/g4GgdKbcvHuq?=
 =?us-ascii?Q?5T64dKR4pECrCEoI2HJvPsI07/vhpT2kLPk3w7ESAACjOKLgjdaYDxEgtmp9?=
 =?us-ascii?Q?TZ+6WY4zgsb3KgKtqSDfyTieuH/AHn3ku2hjmEYq8yH5VfG1rJF37jaM1jpm?=
 =?us-ascii?Q?vHifSnmMVAebPSvfDTQJ0giBwBOW/3Gt1+lC66D+6N0dBDVsdtL2yeSwPEdr?=
 =?us-ascii?Q?PQ7v1SuqixrU6CE1wlSQuZjugXLJUxc0U5Ju34iFDbfvc4N1N/fhCwynP8qH?=
 =?us-ascii?Q?nnNoTeH5lT5oeSSiSvtIB4u/VN/5Rzo+R6OYF3AOnVwH8jbSfZCRidnZg9Rj?=
 =?us-ascii?Q?SDso4p6FjAMyV9YZjIM2dJuvWFBMsAMpmKpwZYYrtewuDl8uVv20uBcdyoxU?=
 =?us-ascii?Q?v7cMr4qub6FFh+CWBbbfcVnoObmmBpNXQlIh8hcJnNYARMo9DV8CXLJ2eEgW?=
 =?us-ascii?Q?mO1dNyNBCgVp09ORYr74wwks8heBiQyH6/YWrti7qBcPnOjwEedgrCVOHJY2?=
 =?us-ascii?Q?RCUoiVCsKax2X5Sx6UOj8ARIOPCObAa4EGPMQTXiU0hulqpDGPWeH8OkHEfA?=
 =?us-ascii?Q?5ugy0yRqODwVhb+uMNfUeL0ykgGPvkmQVLVsOA1c5EbcBjMU9go7AawAfLNU?=
 =?us-ascii?Q?YG33vVps64QZvG5FTGiBIb9slk+3EF7nSQUp85FkaVu2RDJJzFcPSjkj2sqn?=
 =?us-ascii?Q?gUevt5nC/vV+AAhp7oh/sGWjxQM/QAJQ4b+cYFsXJQol6ypczvJewE5uYe8S?=
 =?us-ascii?Q?0iREdToXQgL0OQH839eTfWCWGkUcHlM1TGn21V4CrsPBCLane4R2wkUVkHXI?=
 =?us-ascii?Q?YTDPng5OdhPJss48eN20oc4HMV1ig/96PqkrfJdc72v5k5e4allrAgG25V/B?=
 =?us-ascii?Q?0U1N8pHjXNKTsQydvHrfBKZA/q+W+jNsQPcKHWJw5zsILw6mx+eU4ceyuopE?=
 =?us-ascii?Q?rY63EqG77n3gI4AGTblZkHa+n6lnNUJolvpeCycOEyuXTqQpocc8kY8rXvwX?=
 =?us-ascii?Q?OR/ylRxyK5H34ymNhOWIYgNjFk6xRifHH9goB5bk6Tg/uqeDb2wbSYgg3W61?=
 =?us-ascii?Q?cHiD2MwQyifNKoWauc1coruAo8qKF2ut7dOYlbsChJ8LXZmejuvHEEniont+?=
 =?us-ascii?Q?SHsfzw3e8SRMuNgae1gm8eBE62hjhVyXQcfq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:11:40.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7b7839-af07-4c1a-e6a3-08ddf511d006
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

From: Parav Pandit <parav@nvidia.com>

To reduce dependencies in IFF_LOOPBACK in route and neighbour resolution
steps, squash the static function to its single caller and simplify the
code.
Until now, network field was set even when neighbour resolution failed.
With this change, dev_addr output fields are valid only when resolution
is successful.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/addr.c | 49 ++++++++++++++--------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index be0743dac3ff..594e7ee335f7 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -465,34 +465,6 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 	return ret;
 }
 
-static int copy_src_l2_addr(struct rdma_dev_addr *dev_addr,
-			    const struct sockaddr *dst_in,
-			    const struct dst_entry *dst,
-			    const struct net_device *ndev)
-{
-	int ret = 0;
-
-	if (dst->dev->flags & IFF_LOOPBACK)
-		ret = rdma_translate_ip(dst_in, dev_addr);
-	else
-		rdma_copy_src_l2_addr(dev_addr, dst->dev);
-
-	/*
-	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
-	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
-	 * network type accordingly.
-	 */
-	if (has_gateway(dst, dst_in->sa_family) &&
-	    ndev->type != ARPHRD_INFINIBAND)
-		dev_addr->network = dst_in->sa_family == AF_INET ?
-						RDMA_NETWORK_IPV4 :
-						RDMA_NETWORK_IPV6;
-	else
-		dev_addr->network = RDMA_NETWORK_IB;
-
-	return ret;
-}
-
 static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
 				 unsigned int *ndev_flags,
 				 const struct sockaddr *dst_in,
@@ -503,6 +475,7 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
 	*ndev_flags = ndev->flags;
 	/* A physical device must be the RDMA device to use */
 	if (ndev->flags & IFF_LOOPBACK) {
+		int ret;
 		/*
 		 * RDMA (IB/RoCE, iWarp) doesn't run on lo interface or
 		 * loopback IP address. So if route is resolved to loopback
@@ -512,9 +485,27 @@ static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
 		ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev), dst_in);
 		if (IS_ERR(ndev))
 			return -ENODEV;
+		ret = rdma_translate_ip(dst_in, dev_addr);
+		if (ret)
+			return ret;
+	} else {
+		rdma_copy_src_l2_addr(dev_addr, dst->dev);
 	}
 
-	return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
+	/*
+	 * If there's a gateway and type of device not ARPHRD_INFINIBAND,
+	 * we're definitely in RoCE v2 (as RoCE v1 isn't routable) set the
+	 * network type accordingly.
+	 */
+	if (has_gateway(dst, dst_in->sa_family) &&
+	    ndev->type != ARPHRD_INFINIBAND)
+		dev_addr->network = dst_in->sa_family == AF_INET ?
+						RDMA_NETWORK_IPV4 :
+						RDMA_NETWORK_IPV6;
+	else
+		dev_addr->network = RDMA_NETWORK_IB;
+
+	return 0;
 }
 
 static int set_addr_netns_by_gid_rcu(struct rdma_dev_addr *addr)
-- 
2.21.3


