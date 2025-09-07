Return-Path: <linux-rdma+bounces-13141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DCAB47C4A
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9DF63C2C03
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F586283FE4;
	Sun,  7 Sep 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snXC7DGZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EA275105;
	Sun,  7 Sep 2025 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261470; cv=fail; b=tSwRf1IRHbGG8iZgbrQQcIFjecIgIdmen+BVhAbNzpoZmNqe5O7ZxDMMY01mPiJgbckzuZBI3aWejveFKJ6f8OsMBjUxI1VDWBpJzag7NyZhkq9AsFPk0bxo64csXXyRn9U96WBOVMCsiPaopF59a643m5vKom4MeiDkgViQQDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261470; c=relaxed/simple;
	bh=F5S1Pm1b1pb9q0dq6yInh9JHav9AysBkrBXdlCxys1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWv9DbR2Zd2/Z9kY3SUroq6kEzG/0jYUMJSze8CD3F2LGcqv4j+bI7vLX3TBItEGI0veUt3T5oUjMPuY0rfEU7wNeN/ndVbuWx0aW/nkDBUsDFC4tI43ZuVDQiFpq/u6I0Xrsg8f53hGA0wYXpdofmlBIQPJdyFzpC1ykTy74Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snXC7DGZ; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZT4bz9zmevl/J9BLEHZ9rAFlK+FAji/sQ8NUFbXwKkDedzvN3nnjogcT5+hXjLRmQxbjzJDqE5YZ6mc8YM8s9v9IdgC9PqWK9KcBclsR4XZDanOMeQkuxU5wauYM8lGgElQ6Ezz2lm/bpSd0vGla+PTGPQKhNt34WU5s9g3X1bikuZmQ0a6M6lIMxd2DUkYIT3pxPAzw4tlHV1utp8c3wMdT/uEwNwMlloY0pKcE96ICpb2oAYP8X7FtgGaJqF2/WfNsUwzztl6fpzZuiX5dnfgVjg9W0UMQii4kr3HDHMX970OTlvHP7ayDt8GESHVYRXQiD2eDrgWfo3aUs27nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Nb9wUpnfw9JzQmW3E2pnWNtOCnKeWnSlbrBvcQYyLQ=;
 b=pim9RavAQ5A0erGtTrVnzlTX2twm3KpvKCLFuJ9vVMtXYApTlqUxFqlyt7M+zq+e5QrfCBTD8RrUADANwnWmX6du6eGMD0WA1s62wNgqLkI5Q1mTSR5m0KpGJMuc2hzdxg1gtGvDzCIX8my3VMV2qvMDW+X9eTc8xIe1LrzewvZpk7uimCydsNOcUCSZFBkgL1YPloFGHD3DdO1eckUWNz+FaLZewQne3AmRSdbuq9BhFg4kfYZci0KIsVWwiGw5MWhEyetk3QFWjN9b/7lj/nY4EXEWF4CZRYPwR8vxanrOe5VJgDNv9xpcirQsDoHi37p5Wk6xJzSaEIfqUkY2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Nb9wUpnfw9JzQmW3E2pnWNtOCnKeWnSlbrBvcQYyLQ=;
 b=snXC7DGZQVJ1W4AoxhyZAOPVdrxS9hlGc4osh+xEMeY6NEalLVOFl7cJbSFkThnu0CBa422v0FSs/e1Pw4QoRy6Wu9XLy70lgGCz8ly1b73g8dkN/HbvrKnRmPFMg0Ezm3d6ooxkcCOfXBxL2xkSwgFG4VotPYsXOtcXCDkh5Qb9KnoGSbqbrv+x77RLCpXr2bR+3E8NZTHAgjc41OB8EB4MFhsXWVlAQ8QZbh+B+IUDUekabATHn8U+d29BCJ28Bu2VOLd3nf1oTQylzcT4erngkAcliu0nSLDzgMZWTb8t5NRKwc893+s6iMtcJkH2kJSLuf32jGi9vHbpGc9JkA==
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 16:11:02 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::56) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via Frontend Transport; Sun,
 7 Sep 2025 16:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 16:11:02 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:38 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 7 Sep
 2025 09:10:35 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>
Subject: [PATCH 1/4] RDMA/core: Squash a single user static function
Date: Sun, 7 Sep 2025 19:08:30 +0300
Message-ID: <20250907160833.56589-2-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: 33012709-64a8-4572-dc13-08ddee2923fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ghz9XJLxNKsuQTE/iCSy/K+F83edPS/09Klqp7Y6x9VZLMvo1UjhKdVV3aXt?=
 =?us-ascii?Q?tJT0jbl717NV2n0lHpZ6kRmGl9n/KMMYc3ZXWCtRpsn0uCOi74Ij9RtajLvD?=
 =?us-ascii?Q?BUyCdBnVUwLAs4ABrNZqcXLxDEDYXrgDjMiOQnjm4tjCVhZc9qsXbtJpu8dK?=
 =?us-ascii?Q?wbJWgedxolY47GP7JyLPY2PA4sJZ9ZvFMfIE1pRFh2x7QLht76ZNybZb0wZR?=
 =?us-ascii?Q?RD9SOqq/zDr0zPRUSYCP4Nw1p35amoFa3XljqaIN9MA3MMgdzpdZ59reuIIb?=
 =?us-ascii?Q?omRuXpVoSMPZ2yKRNnH+J7xtL5MJ212orcE/NHkHPKA7It93FlkWkbaFXcRk?=
 =?us-ascii?Q?q5OfSXPN5JM7CngmpchFh+7OYY903WmI5Z7EXHRckBa1ANcyyNWy10IfTm/t?=
 =?us-ascii?Q?uVePgna2A3meggv5IhMSqc9GNunEKK6tu9KyTZ3XQMnncBG/tM/J3B/uC37f?=
 =?us-ascii?Q?O3jVRQZUgvWEh4WxwJOKv3XgFQ+X/eU3B/mLKjFHcCpNInoiQSfBmLhpSJWn?=
 =?us-ascii?Q?up1X6ibjubohml8VlkZWmEOCQ3YmiEZnpmgbLN3a/+nNCFAt7vzueV8zL8v2?=
 =?us-ascii?Q?HpKDKZPDan25vRUiUS0AL7PryiXeyoVMx0vVhOxnD9fVN76rlbe4GxsNJirS?=
 =?us-ascii?Q?jUaLpkAWX/DTU1xigBsg4hB08v0wALD/dEm3qWEetC62zyYzT2ctx538PwS+?=
 =?us-ascii?Q?rWY1hXPeTchRI4xse9hj9cymu1TkSOfNXprmH2gidSde6IUFS+fYDfWFDq3T?=
 =?us-ascii?Q?BBLuM2phLRmQV3ONpp6ZmZlJIyjYM7XDtIjqutgIexLqH2OGzAjWMyUGDYRn?=
 =?us-ascii?Q?Z6lq49Vdv+kj/EF2JYOSpw9kHKGYeAmaakwsWaD6yxlOONaPoWBZ/xGKF6zk?=
 =?us-ascii?Q?nqhVWEimLFFX1EIFiImIb5hpC3ts5ejW3q31EZgNVJ4rPo1DbfC+H7WAtmP5?=
 =?us-ascii?Q?Aln1UqtbfqJXVXZqiDlKz8yYcnAVgjzDEamgCVFd5JFF4pMRgCR1HO61RM0A?=
 =?us-ascii?Q?hCa2VC461tZige6QCqWaDbLqak00bxXphgIF367GKWHkC3VKfGvAHjtgooGj?=
 =?us-ascii?Q?UeJBM2F9lB4EsG+lREovCzH0ZpJELXYJDuZ7Ovpg5EiZDBCotlfOD2liNgaU?=
 =?us-ascii?Q?le80/atkdfEWM056QT5yEZrrpPglJ4XC35mqnpswFJxTVQuDIspO7bdEZ59c?=
 =?us-ascii?Q?nCdmz8sGiYrcowYa3VFbBT0CJwSU7rn1ngab+p20mx3vF7dlNUiSI6vw9tC3?=
 =?us-ascii?Q?ZdJsFYE3P+35KKJyYjixfbqOVB5hYMgmVoj5BPcQ+Mgds3mYRBbwHpVhZLGa?=
 =?us-ascii?Q?y0JPd8hLtPuPKbeQKXWnPe5M082ais2Bzr2L6DjXz8MYStku/1mtfaZI96jc?=
 =?us-ascii?Q?oueVJmfcgFPadf+7hhhty8mbcQzhL2rsKFU6gQKka/qmDfQWnFs+/SP2F+f8?=
 =?us-ascii?Q?L0Nmf2uOMWTXf3+hfKzRGeGkfbDbFzPV5mtQy94gEJ91S0McLgduf9G01OfU?=
 =?us-ascii?Q?gjPSyIbmotHbOSc7ObRIwim10c9kuZ+NyPtv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 16:11:02.0862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33012709-64a8-4572-dc13-08ddee2923fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029

From: Parav Pandit <parav@nvidia.com>

In order to reduce dependencies in IFF_LOOPBACK in
route and neighbour resolution steps, squash the
static function to its single caller and simplify the
code. No functional change.

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


