Return-Path: <linux-rdma+bounces-10138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72DAAF257
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AEB4C43D6
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E421018F;
	Thu,  8 May 2025 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QQbw0Of4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4213D213E7E;
	Thu,  8 May 2025 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680478; cv=fail; b=VWHOxA5JDcyLZRfcoXRT82mj6QogJbAgXPB/ePhBZbItIdCkRcjAYYPvspcsndGOEgc95sM1W6Uy1RdqF2n92p7N7fyoKtf5uABMzqoun0JSY1N5h9rCXMP1K4cK4WDW4PcSZOoVohw9hBwEznGPpMzcvOdLBSZhBUHI0WF6gnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680478; c=relaxed/simple;
	bh=8+NtQf5lkiRQPrS/xcz6OK0iODeCy7ElP2SsFMr69ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RX5D/WmnrpUnPKY/cCC/lQEdb244ndY9fVYOEI30qG42DwJiL2qk9pRFugcN/oZTtnaFz0wrSl0PfihqLYjhP1SXl9qPeuRsvY+qnipAw2A9L26LkwBMtrscjlXPS9We657XVOJiL+HJbnnREtqtNPtLqhQYlKt+Xm6KbCI0qoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QQbw0Of4; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdIPDPbELdJylK5NsKJw+KL0Uuxnm4vxK/CEx2EjQRKSMZGn2bqJdtkwf6dJoMWfHk86IUrqmZni6VB5N13xRHPmjEAtBMPjfH9m5TXpO9ADOQj/EffsDMrPOfxEIS6xyvFSTypxh5Ih1bzj6OecXhIcOoDX9cf0bWV0QDjD/KLwMBQGXK/IVWdFsTkIxvCg79OVjAvavR5f3wBmAkE1QuNMs49iyL2lzsIoZCCJZsKGNzPtI9nll4Xsm1JnAWtHhLnfjZg2XiE+9FrFder8Nv8yltbDaJlkw4cgjlxZPPzlKxMRzwv5nQpnKTztwUIgcJtwZhd2PNVrb0EO4uxi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s70M94ctOYpR99iVT7Q0DBV8zpCout837W9PlFOf4QM=;
 b=f1FH+CHCuRt51SZIbKP923c51eGnj2m16QIgV63Lqgst3q3UpLMG84wluQucXZ73UCDlYh7mSAidwMG30yxvihgA0dYD1T1BljA8bZH0vXYHJ5pyN/TESzB4VLDKl9D3W0JIbuJ57oZwoVsUZiXeP6L4NjGiwOr2oIYqJDv8khXKlLYfKwRDk4ds5Y0BqvPCspPndRK2D9XPdjZkpbEzlQE1tFc0MS9k8XcNWKc93RjdLZjTt4+PLggqSkTjmtIkiIsejq21XgrwhJJTcGoydDuwym8MS8QxAQCBtIWvUJ1aa6uPzTv+XWaIe+bF+Tn+9RI060mi3PJTRW2YnKLxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s70M94ctOYpR99iVT7Q0DBV8zpCout837W9PlFOf4QM=;
 b=QQbw0Of4LbfH3uRulgH/ucRYavDR/oBkkPuB+OZFLt3z4VgAKW9+MY0MrG48dDEskPd4VZJEJr+i4d2eRqpqTigWQWf/h7SYI92jxZSey4vWQHlI/8Ha89ANq3gNucMG/CDyIrKCCN8MC0K98aYUg2Ge5E6tUkNgKt/X5HsyMKI=
Received: from PH7P220CA0173.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::6)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Thu, 8 May
 2025 05:01:10 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::cb) by PH7P220CA0173.outlook.office365.com
 (2603:10b6:510:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Thu,
 8 May 2025 05:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:05 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:01:00 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 07/14] RDMA: Add IONIC to rdma_driver_id definition
Date: Thu, 8 May 2025 10:29:50 +0530
Message-ID: <20250508045957.2823318-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a654a9-20e6-4451-351a-08dd8ded5969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zhbKY/x4aMLF/hk7GNX2Fyh6LYENb94W+2KNMI2WOt/bxws7rt8Wmzk+JxdH?=
 =?us-ascii?Q?a7G2NOCLPh5Y/UZwTOAz3QTa9Bg6/208748PA8Uvcd59gtQZOKkBoWqwLOUG?=
 =?us-ascii?Q?TAjvquseZ0sMtFwhYI2XgQHSz6oe6czxRZjzN8WdPB6nJdQcO/SprCz3/HJE?=
 =?us-ascii?Q?0xRMpd7P6LB2x205B35rELsykiiuJt9rrVLsDq66mwQqA4auBF9TtG77gDc7?=
 =?us-ascii?Q?9iJ0dUj7Q0q9DuUlRNcCaEgXy8PKOXXWLmD5YbwbYzhMvZJfh6koSwv+yYGa?=
 =?us-ascii?Q?UXKIMT9rxpzY0ryfdIao0tH/hu/wCAFgre098ZITl58QpQnaqpkmIZXamKYR?=
 =?us-ascii?Q?vHDFf/LPzarAsf3g8iSXHjV7QR4ph/mQUWWesCQhcvHiO99IQ1OLupqkrrn8?=
 =?us-ascii?Q?YvH0ekdh//J0LWbxJiTO5d6MrNrjxO4b9+pabte6bixqmLMFxBYlp+fOQqPQ?=
 =?us-ascii?Q?UWLe/HRZ7HRG6ykb6gbXpi1YcrohEX9bzxNmUO5nj1tVpwfFnwhgXj0kmQNQ?=
 =?us-ascii?Q?5g3Uw8EHbvoCZsCf7VDMimHC9dQaHK8TFABq4pdwsfS15YUce01VG8p4JK5I?=
 =?us-ascii?Q?ARePc/OjBSL0sEazc87PeRmnJnn9mRYsHtn3VsfvYx9bb0boB/YcWjelcqJF?=
 =?us-ascii?Q?YPWFvXW2gi1p6bTanD6MHB9RtVY1P/Xm+N+px/891Ponh5k00HcAthmc3HXq?=
 =?us-ascii?Q?79p6zBWWeh4HTFNtsIuD60bmboLAMvKgFG1BBfICiGu0rVZNmwwGh0Sfxzal?=
 =?us-ascii?Q?LMPjrzoJiWEy2l4zF2N3UwQ8ZSzwZAQHCVOpPQQR0NxYecIoK2nCTxB9St9B?=
 =?us-ascii?Q?OxPoe3qOH/iSzeijqHkL/mIM5NidusSGAMsEBC6+56rwsgp3VnMOSJTIL8dA?=
 =?us-ascii?Q?SGjJJUNBTuecC8iSPw5ltRk3dxATGt7A15UltbiJRunnyOpba8lNiNeflxJn?=
 =?us-ascii?Q?BrdoLyl3WBbJehvh5WCxQfAi30oGuHzV8I5QRGvYCshFMrV5yy12FZMPh27l?=
 =?us-ascii?Q?XBjgEusbtRZsxXUl0D3CQoKZFMBiDpnwgMC7I7mbE6zEMorzZMkoljJ3DaHZ?=
 =?us-ascii?Q?gmYT1MsqQWfB895hyuMVgIH+jam0VGVwZ3fx5Rjv850dRFylO2H4Txn187o0?=
 =?us-ascii?Q?/B2xjhYjd7NDHdGHrUW1NjkYj/lvELkbUtGsuTNWZdAbpGTGzCMFXjgGflke?=
 =?us-ascii?Q?paXDcriFfXpSPtVaob8M6aidQQz5KIrQ6DATezE/5LWX4E5mcW7vSJpFbRGP?=
 =?us-ascii?Q?/E532BX5915Y0XTTVSVj6Om8Eoe+d2zfUMCb2f89IF/c9Fp6cjdMgwrgitaI?=
 =?us-ascii?Q?c9CWYEVCzEYY5nxbCgnO1/+cyvE3adTjbP4uFpoppvCr40Atc0whfYbaBODg?=
 =?us-ascii?Q?buyCUFs46+Ltgi8R8pMdtcH7LF5dkqzexWwDsz6/CmVR8zhtihQAqZMbJNo5?=
 =?us-ascii?Q?SYsq5qwVuKjSYBiKsBlKjB9NtnJf3j318A80F9Del6ZDXgvO4WGZQhYXIcS0?=
 =?us-ascii?Q?uK1NDl6oRxaLG8rsbes7pHNp7fh788d4SCKcXz5h5nlTJsnQcT9Ft3jrSA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:10.1866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a654a9-20e6-4451-351a-08dd8ded5969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966

Define RDMA_DRIVER_IONIC in enum rdma_driver_id.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index fe15bc7e9f70..89e6a3f13191 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -255,6 +255,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_SIW,
 	RDMA_DRIVER_ERDMA,
 	RDMA_DRIVER_MANA,
+	RDMA_DRIVER_IONIC,
 };
 
 enum ib_uverbs_gid_type {
-- 
2.34.1


