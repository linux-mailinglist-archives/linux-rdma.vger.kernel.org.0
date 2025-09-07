Return-Path: <linux-rdma+bounces-13142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB185B47C49
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF7917BDC3
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Sep 2025 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1000285071;
	Sun,  7 Sep 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6PQunk8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99945281531;
	Sun,  7 Sep 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261473; cv=fail; b=t6jvwBg914eAmsveUUE5Q9/mlMqAEr/HPRxK0cOR4FttWEKdZs0syUGqV/u4jQmXZ/o4yjvmtYjCAATrZVTmhOfVdBPlKN5abEkF0HXB2M+kHoyXXpR5zvIKFqK91/q85FuDjkV1DwWLDtQlXd7XByThjFxlOO82VwfglW7p+GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261473; c=relaxed/simple;
	bh=n/73WphBEju0y+YNH8Xs4VZ3qbfC4zFvYa0+rHQFKP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GA+1M4KCVClLYxNx6jaU1KCzeu1UHwOS1U8C53K1G4i8USglepXjvIoFnRUoML1wseX3HK9Q1XIzTEkeIFF2E/VllsKREUxVL06RzRytq+Q1esXfLm8GKQ3NWfA/HfgTMeizYBFGqI2zgP8MR8xf/iGX4nMU0JunaLIjpnDn1Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g6PQunk8; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sd440EoH0tC5IVuAnIxaE+FmD9HovEqr7hnudAPV5f69iXfUEmZ2e723KIvyH0FcSRrYA1SYK4Qn0VDlx0I5bosEC4glTZSEnFl72W+sv2ANMFgif/KHMQZpt7o3U+3sU62TsaD2ac0lt3gLj5JJYTyhnSgChrGcbtZXTIA5q0oX7xMuxtNulOOnBU1rLFFm/gOG+f++Lc1Ys/uiH0jVph2S6shD16RVChucPQaM4RAXy6ApHMoOwcto1ec6TQXOE69gkE7goWjS6QIJA17LBrOU+YfMMihzfsiMTNIlhSy7NA0Ayj/cTLBLe2FlaToBk7RmlI38M/tW1qZTq2OGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAl+3Lk3V/glsOW0scvKFF4Kiq2QycTahI5TusgmyfM=;
 b=qywr2SFMXffuuprSyIh8UUDfQ2s+xIGRpsTFM1lkZNynsczXJPyiWj8ljnCAFhqJ2o8TEBgRJ2/ihFak3NpKHA4VeclWslmZzlqeaRqtQRpA9CCfnIfFe1HMfpjoGADj7I6fmANKmKQHd2iYiv/69Lrzrj6OvIT8+O3f453BISYRjKAoF656jdQfQdGjQW8Pylzcnuw4UF8HjmqOxCisb7zQ3OeyEKJoPcYMBuM8LDXSCkxqObpClei5wWI97PjgmQNfhrsXSE/d9z6y+NVqe7FIQBQbh0okR+8wZRpcJcOw9MuUhhe9L4T8UfIRyljPYmuoH7hRng8FjpFlatgphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAl+3Lk3V/glsOW0scvKFF4Kiq2QycTahI5TusgmyfM=;
 b=g6PQunk8ymCHyaLXiKvx5KkO5o7YGM6QYjB295/gO2Mz2c/1vhyrJYGuKNk1oSFnCAg32v9FHmVUUo9XTtYIVScXU46VZr5YLKNMb/85gvi1eYc2FFZBo58bFcyDrWMH/R3N5GgrdDEasmvzlAMbhGG3PZSicFmu4TU7qL1udLHtZnid1d/RjE1Gn0fcLKy6KYz7DGmwtMEiwSwyNxYETBIuBJnR7eBlLOtXkK4+DegpGNss24XMLxDeX6Q0I/S9U4mLguZHZP3vl9nC94tcn1Ou8wiueKtjS5nerm+vAKSP3c0FQ3BqTQxKf5DXyb5xI8bkx6hOBxF4PN72fB5guw==
Received: from BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sun, 7 Sep
 2025 16:11:08 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::c4) by BYAPR06CA0029.outlook.office365.com
 (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sun,
 7 Sep 2025 16:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 16:11:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 09:10:49 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 7 Sep
 2025 09:10:45 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>
Subject: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without ARP support
Date: Sun, 7 Sep 2025 19:08:31 +0300
Message-ID: <20250907160833.56589-3-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f571c72-3cf0-4abe-ea07-08ddee292792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Te/hzkDetrBuGO6wVPvpoT8yTZQIRLbOyhRcXAX+TkfLCATKYZvtIWzPtHNN?=
 =?us-ascii?Q?Ht4Sd776VUBD/XOCbaYDlLi8KEFosHlDa7+B0cIzkhot8PsE910Ac40psxqr?=
 =?us-ascii?Q?uc7dM25pVKoPR+D2LxpSKhFYst8SIferxKmulL20M6bak8vDXnfigJlBEma7?=
 =?us-ascii?Q?a7RcqcdMpgHPKWIohQy7RtoEO80mncrSHJCMdmurz4R/DLzLwNnhSCIznJF2?=
 =?us-ascii?Q?xmIPn4YNIpWIiMDSL6Ch2yEQ41BJJeb6fKmPd+0BY5C+QIxIk4Lbg27GOewp?=
 =?us-ascii?Q?n9gjynIzUSbLWLRaStqcsH+NnQoI8xHbQCEeabwaWpMtWZm2tfafEdiyJ+6a?=
 =?us-ascii?Q?FExACg80sl9pZgP2mwc+of8UPVL0W1n3PDHWWsczYKMj3EiiD42DqLmpht8e?=
 =?us-ascii?Q?jlJ9sNB+tAj/pOhcCxpIAXUDXqdWHcv+3cW/4lgzrteJglM98nG/AF8KSYUO?=
 =?us-ascii?Q?9lWO+a1wo7CTuC+GrnU6w3AqGyz8fQku9bZHvOv6+tfgFgWPff8oE8aZbStZ?=
 =?us-ascii?Q?4f6keC0dscuTVXyyIrlGuwbG9zeuEf3j+71oejsEJKEeYCnzbq3MigLB8XSN?=
 =?us-ascii?Q?EBe+HCAIMAO1pNf/YdzfdAAPu+0Iqoqwoc8r/RusrYXIJs3dcF5wATc6/wD3?=
 =?us-ascii?Q?Cy0hPxG3l7ADid8pIFeTfnxa/JbEO7WCzTTxHybV9IIROcPY3CIvx6zPPo4Y?=
 =?us-ascii?Q?wihXsFJEl/fpQQmmmKQp+rB/gxEhyaisuUxrHpfBpd7F11yTq9uswPD/D3gk?=
 =?us-ascii?Q?49ldVyZiW1zxb8hdrt47hld2fYbMDtTTOiCM3LK6iv09KwPD5mreJWF7BTEr?=
 =?us-ascii?Q?h+mwtx7CYD/3OV3ugnOYYLHmFi7ZctrLZZ49D3SFYPqqIIK28ARtsB6VlJQ6?=
 =?us-ascii?Q?7Sic0GHDM1WBk7Fc+LyCrZd0Bc7shFShc6XG4yYOdMtc5UzKxCbou26pTOAI?=
 =?us-ascii?Q?nwjD7R4vD69KD3WDvKJRXs4EoCyhwRSgkK/9l9jxg/6EteKdAkE2ioBi1mnS?=
 =?us-ascii?Q?UC2gcXIizcuxD78daV0sRqdzqv3PQqa9G12zfg4Eae0b2uCxw5cunkXZg6gP?=
 =?us-ascii?Q?4Rx3shwvRo3Qz1VcD+TFe9/WWjnvltOkbhgzLowiWHy4fVHc6o6y/r4xUwKr?=
 =?us-ascii?Q?HXmrlbUqOoXjPeNzCRaG6Lu3GjO20KfbUh+ylL2lWA+5ylFJLDp13ibIfWna?=
 =?us-ascii?Q?OWV9tA1OKguLWK3e0FaeoJhgxxLs7Ci/AdS539UriFkjEs6XyUeUAMmCIa+n?=
 =?us-ascii?Q?yU7JMKgoEvWDKpAn9D2Xua4JNwKg7yE8BG3VGgUtr/TNO7ttQMMnzmkPDAMX?=
 =?us-ascii?Q?NGXo4GbKxJKm84+AYXOeXlIiE+ISaQNNEi4Gon+eG4Rt9iP/VJ76i1OxR+p+?=
 =?us-ascii?Q?RCBHvlaYieSgBcJczazZnNdcxgNrjUcgZwLlYYl0QWT88gDT1sfEFoun+fVg?=
 =?us-ascii?Q?QpjQoyY8YIco/LIhUpBJaG1psYr7nxkDjT9SS0G0XLmOfGRlPcWMzcZS1W7I?=
 =?us-ascii?Q?48Tgo0+6DpE8Dt+V+m2ZyoD6pfFWBInlPvti?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 16:11:08.1156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f571c72-3cf0-4abe-ea07-08ddee292792
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340

From: Parav Pandit <parav@nvidia.com>

Currently, if the next-hop netdevice does not support ARP resolution,
the destination MAC address is silently set to zero without reporting
an error. This leads to incorrect behavior and may result in packet
transmission failures.

Fix this by deferring MAC resolution to the IP stack via neighbour
lookup, allowing proper resolution or error reporting as appropriate.

Fixes: 7025fcd36bd6 ("IB: address translation to map IP toIB addresses (GIDs)")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/addr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 594e7ee335f7..ca86c482662f 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -454,14 +454,10 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 {
 	int ret = 0;
 
-	if (ndev_flags & IFF_LOOPBACK) {
+	if (ndev_flags & IFF_LOOPBACK)
 		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
-	} else {
-		if (!(ndev_flags & IFF_NOARP)) {
-			/* If the device doesn't do ARP internally */
-			ret = fetch_ha(dst, addr, dst_in, seq);
-		}
-	}
+	else
+		ret = fetch_ha(dst, addr, dst_in, seq);
 	return ret;
 }
 
-- 
2.21.3


