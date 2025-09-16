Return-Path: <linux-rdma+bounces-13406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA003B594DD
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3F11B27A1D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECE2D24BE;
	Tue, 16 Sep 2025 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csEUweUA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE052D24B3;
	Tue, 16 Sep 2025 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021112; cv=fail; b=kk6VVklMXoYFbcEj78qqSF9c0jWBUl06NvSyWCS6s6juCx+7Hx6f+ZErujId3tETFc/LvntfAX1MKOdpgTyIBylz58L17MYMqXVOWrs22sLVZbvKQLLqeF6T3m7RxCDyIYyAT2mi0TUeY5LO6h/Q0+4UM7Bi2+vsHyPXNiTluIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021112; c=relaxed/simple;
	bh=n/73WphBEju0y+YNH8Xs4VZ3qbfC4zFvYa0+rHQFKP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZI38AEGa8aNFsp+5yPTxuGBal5hSV0nQwcW2l7spT8ioqGoWWdOkkm5JfwbymfNY2rkgWlFQCTj2xXoLqORe49gegul1IRECFuGXxQyu4Ryt3CZHMupoJOtbx1nU7VUc4udA5aAk6oUQKA4UaRL5VAOhDXvaEo8gLvZsu7H7BNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=csEUweUA; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMU17iX4aR00rlpldpffT6G8ababxfLmgAZrIeTcaEqFteCBxVhc3Mo4rb2enOLtm45h9/zKfH26PAbxkOwCh4eovjM9p0Bb4unrU4yBpzEAIaztSgXXV4v08F7h1VJGnIJDBU+9mm39ttFzbGlnAl1HWH3BJHdrHti99cYyfc+I7z+45xXWpAffJ7oWtBoZSTnwuI2vS+NBTtkxFFkZvyYqA7VCOnvL60ornt3D9z2fw7JvdMGykL6nhRUYqnGmY+snX26znYoK6GxWmghXBnXdY0FNaw9yOQJeo0bUKZkYL+CGKpRYWKk32xLekzw8aPQSP8Wug8EajoHi9oFeSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAl+3Lk3V/glsOW0scvKFF4Kiq2QycTahI5TusgmyfM=;
 b=l3L1cMFRYMnqEHvqYyvE5+UdDdfehDZn350HOJRN0MSOUSJyBbZZW/qd5JhY2jZqIfLJv9uU1rnTQRjtB27AL3Y5ZWdA+fQxZpSPfT10hR5MQMLTEYXJd+KLopwnRpPW3OL0jr4zFKKqYMQXFf4zG5r1jZfjSzsY9cL4sg9O32olBlQo6AFwMuN84m6GntNOtBNzJgS8pg6v2xEf/33tM+zM5JobuDcniA6uVgO3BC7HsCUqkJDUbWz87G2ZzD6pDfzc4JOprXtcQqMr0QTry42Mp6DmsWCJMuVurCCbn1HjxMmLXDznRhUzMRBuLfawA8PGhxY3WxE14m/0nszT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAl+3Lk3V/glsOW0scvKFF4Kiq2QycTahI5TusgmyfM=;
 b=csEUweUA6ki+9M8XqnD1Qt9mY8iZSqBXTcnk0n2iXgXo+oZksrB+x2Htu5E9Mi6s77ZAA1W31mRwZo/6/eRxTZ4Q03cF8yuU/cyxQF7qCZP7v5bU3cQFzK54Tyl4B0SHFRUhrzEZE3QyhAQjsFT3F6cuk+4pHvo6PCvvmIKRZYAxtXo4KYLS5DXo5xDDHaDL5AGu8mYPv4/LFXqu3gUnFxGi5fXXds6XeSLxSXBRpRE3vp0LifOIFzjRL8zwSZyDF/d3rnuTt0XrGZQohC4uUXxhZdi+PRdfMlC6NLBT8Ji9DuE0YsVC7h93t8bDIKd5S66Ie69pr10N7TMbpRun5w==
Received: from BY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:a03:1a0::30)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 11:11:46 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::ac) by BY5PR16CA0017.outlook.office365.com
 (2603:10b6:a03:1a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 11:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 11:11:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 04:11:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 16 Sep 2025 04:11:33 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 16 Sep 2025 04:11:30 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<parav@nvidia.com>, <cratiu@nvidia.com>, <vdumitrescu@nvidia.com>,
	<edwards@nvidia.com>, <kuba@kernel.org>, <tariqt@nvidia.com>,
	<mbloch@nvidia.com>, <gal@nvidia.com>, <idosch@nvidia.com>
Subject: [PATCH v1 2/4] RDMA/core: Resolve MAC of next-hop device without ARP support
Date: Tue, 16 Sep 2025 14:11:01 +0300
Message-ID: <20250916111103.84069-3-edwards@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 524af8b6-e34f-4525-9222-08ddf511d368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJde4SXl8cflhd3t9HQTran9BG1PFU76P6MTfukSlOgbS2ibu7nyFpBHROIQ?=
 =?us-ascii?Q?yUJKiNYmmGwp6UZ06T/FprD4cxtn/inRyIv39DTvSfh8zzof5+Y1IDR6NTt/?=
 =?us-ascii?Q?d5j9CS/ecv99TI7UxuX7XHqHphguTEnZohJUr1mViPWMjNhQBIDxxEBjna3e?=
 =?us-ascii?Q?pR/euD1hw/K6SCC2xUqC9IfJP4LDVaSGAdPEBh8njzZx4tk2lmyCUYhLPTRG?=
 =?us-ascii?Q?5mN82sDjaQV4INW6WLVjEDK9/qW5wRZ28HFclXZk5RPu4iNwl6qO0SwhK0LF?=
 =?us-ascii?Q?Bt9LdxDgSRGx8yY+f6nMQDUEX3LPtImYMKgVmXRoIZRhNPKWc8DI48cydkn6?=
 =?us-ascii?Q?v/LFLWBnRIepk1utHxWB//5kTsbXqkEMYOJRqGkqSQ3OKYs5nDq1Q65qoQPU?=
 =?us-ascii?Q?UefLE3IO0l1wbvOJOm0XmDn+XGJbRfKTThBNtgKExtRcIUPoC22oJ0asJS2u?=
 =?us-ascii?Q?cLssG7cCFAIAKY5YDBx6XjzM4R5+n60MiMHijtDNkfeC04KitGdEdpUc3O6x?=
 =?us-ascii?Q?QTMI7eArM6YMgEJlZDGuc24n5O+xeFheHSloV9sLI9mU+Rz1eMuxw9230gvR?=
 =?us-ascii?Q?owsRMpGlicbAVMJzeU7oWbNhxw3xdZ/Pb/Ox2UyDxJOy4tt0k4y2JBkQaoFJ?=
 =?us-ascii?Q?MBJWuuhQe6pER+UeDTybfV1GnmWNRFgRQAf2McInMvsGq0hQYxzICOyQ0qXE?=
 =?us-ascii?Q?AYYyyTJwP4Fch/hbBlcc7mho6OuG1Z/IMWDiAkBuY5HcBNoHOogk8UU9Y7t/?=
 =?us-ascii?Q?7ONDXaLRxkdc+KyZF5zMw5bynXXB3yuyXVda/7upE5+0HkA93po9yW0i5f5g?=
 =?us-ascii?Q?ZHyCb7hqozlA48s/drh98dIhjugkTuS720K3Fmvbsd89ORn0v/QgWm6nkzxI?=
 =?us-ascii?Q?FB7a1kMEggMtHFXCb4RLotNnja2yg7ZOHLphBmMIRuIWZ5XFL1LYfd9t3JJo?=
 =?us-ascii?Q?0ki2p3gDUZJ5IFgCBGZCmBF1R9qbabQF1k/vjgtHuAWzknl8B59sinW3iB4U?=
 =?us-ascii?Q?uZkJuiVkkaMQtLnX31dMQadPwO4KI6akVixmBfMi2oA3pCrIiiRKfq96FdhP?=
 =?us-ascii?Q?Fl3ZJ8Z6E+CYMXYH977L+iw6m+jh2ud+q+oH8XgtretLkxlXyQlE8jP6xF04?=
 =?us-ascii?Q?wXAEaKjEemPEhfjBHIht9TRkuaLDPTvlzoy4KJt222HYRbiNAiOcBlRbvdih?=
 =?us-ascii?Q?FMCtZLkqbkJ+CoJ5RFMjNY2KSp0GR0UHGt4ABsxAB7PJt4/2XroYRdIaIEV6?=
 =?us-ascii?Q?MTK2voXxPcAR1m9nMtI9ArwQwOcJv6M0zkTbPcm8Dxi6fL4+uj0ABFuh/cKR?=
 =?us-ascii?Q?eamutjqXuaRUFjK6ppp5QkyQ7e7v+xJZ08Dv6rBke5rwCiiFxQY6PRFm5HY6?=
 =?us-ascii?Q?oAPJ9Ni+401NmYQL3B2q7uuhSGIwpUzi5/ilfR1npmsaF0evC+RbOPrNhMom?=
 =?us-ascii?Q?9u11F06VP0CksJZ9Dhyna245bdDNmmvxHKvHNn0sQ58jjNnvIPcDQK61RMa3?=
 =?us-ascii?Q?tE9cy7fQJEf3H/BDrqd/tN5+zlqf2QbbnAoe?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 11:11:46.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524af8b6-e34f-4525-9222-08ddf511d368
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621

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


