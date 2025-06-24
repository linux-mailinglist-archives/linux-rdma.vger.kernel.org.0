Return-Path: <linux-rdma+bounces-11575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3647DAE646E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CD3405C17
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1129A311;
	Tue, 24 Jun 2025 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zySFLws2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D17299AA1;
	Tue, 24 Jun 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767245; cv=fail; b=lVgJwazZqmcY2RB1ZY9Mb1tyP5wjNGa2aGZFJky52QungBH0dpqMY6gVbIJ7I/Rpq+yGpt5CwXeBmS0zOZ9paP5i+KYfaNJTcuvoc7pLMJ70YqqMj+Hl3cAEPHKRz6naObk3IL37ns/i+gEJTVQNBe6R9vzkqHncfgVeeTflTjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767245; c=relaxed/simple;
	bh=NfROQPYeGxHoicQQxDjEDs5h42zqtaKn9+xjzZTPuQY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRKfyifPGKwNrDVF752DhWwRHfDTnCk/e5zrdNRpJSbUy20z8nJXX0ODp42nOg7APHec1N8HLq79l1BGG7Mg5DBpOOy3tWI8FcBC8K2LqGUpEhzuRyqodp4bWQKn7ot3gPcrjGCt//V/TLIBvNzDG9fetcIxTG2ftGHnJ3QjurQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zySFLws2; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/e+lddmCSMiTyZt6VtNitfSNyXsPR5Xxqn1m0VwCpqYMtQZ50poV3X2itVcZ+Ups+DLASjpJp88Lgi1ag+D8XJD7mw0mfVgW73+U3VeKopBpzmkcCCYFUFhamZ+ANQNkPIiECIcaRjiaOsHe3dCdpnxyE6GMS6iMH6RDhRcZW6Z48gaPQna7Y9gl0DGnzeDK8tJ2IJ2WZqBNQaulNqNZ5pFR28MY8RB6uMS2Jbhzi1du4v5pIeTxQHlFFWIl/PeuGs9hvFb4naybeIRN3Hdu/jWj2tnwl/E3TV3Ij38vro+c35PvKms9GEksIn31C1HrJB8qNo5+ftwAOSC+eRYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=OOoZog1yoO2k/EDLaOdmTKm39MMigPkXZx4Yu02hrFjMa+npRfKAHLmYmW6r4xlEgNqij1AilJ+YXEIrlFOmDIsTow98mbD9uNfiwsPgVFN4pL9nS1lsxzQX3llUCboPjZynG3hJQKvG+OcUiUD+r8FhtJzTGGMisW7gO4FwPPjHc6ZFNOJtf5dAbSdSS1YsenBomaIUtCE4Xv+8gqE9JvsvP7jBKUrFz3891AHrkUv70qJ2ZxWtrzTGAxcoDODLh246Actbfn+v3BGUGpBJyQ3daMLgo5PAdIltVvDSl9qGXqg7Ucago2EhxmlW6AKFhFwpA/kFmiQ1gZByyj4gJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpRkPx+dQVGxL2AILTyXPMS7gdxA9IxJorx8b13lVVE=;
 b=zySFLws27pp8HEZXW1JygkfAOIPoYZ1svHpCi22+vp+yxPxcNPAy8dIAqyde3qVXKNSLLCyniqRg5DDEYVeE+pyZOedL1ksOc+FxnwflMvt0h8mN0BiPDjig6QYNEQHfKs3hYLqr4nV9E1TgeGwsAEDvZ9xmlEelazeM1lsSH5M=
Received: from BN9PR03CA0932.namprd03.prod.outlook.com (2603:10b6:408:108::7)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 24 Jun
 2025 12:14:01 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::e9) by BN9PR03CA0932.outlook.office365.com
 (2603:10b6:408:108::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 24 Jun 2025 12:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:58 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:54 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 07/14] RDMA: Add IONIC to rdma_driver_id definition
Date: Tue, 24 Jun 2025 17:43:08 +0530
Message-ID: <20250624121315.739049-8-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 633b2cff-95c9-4c70-5e79-08ddb31899cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYlAI8it+CxdFELmh1cGL5MYYUnqjlQSxxvvSGXnIQvyuhQVi3IeioJFa3Jz?=
 =?us-ascii?Q?yBVAjbrSEnuskk0XMx9e9jswkI35r8T4KW0g7e/G0lEkZgg2wZXuAKDAHZ0K?=
 =?us-ascii?Q?tRftiEqmy7ru6LtIW5Xd8++dhQ7EV7ctjFrh+fIPmstdrBmSQy6pBDCAhU9X?=
 =?us-ascii?Q?nU3+LLXpKOS+kQY1ANhC6xeDFrhzPTBBgZ7UdawWY9deTbsIB88IF+187fCA?=
 =?us-ascii?Q?nzhw/RjV0oHJXsciDV8/7Qzn8MdhhELvVsrN5nuyUdCKycbudpjyy/AuVQ1Z?=
 =?us-ascii?Q?c4BwDrYt5T/f2vKrajBBRE/JGKMi87o2Nc5UktOFZHE6tE4wlVw6gpV4OjT6?=
 =?us-ascii?Q?fa7uqWBF7rMf8GQth77CVmDfTCc/MWE1il0ddkZlDBcqMDd06Bgid7K7R4t5?=
 =?us-ascii?Q?lVf6tmgnRj5XWAcBQb5YRZLAXZrB0BWvuOJyeDpS6kDG5L2VMRBbTtHzmflN?=
 =?us-ascii?Q?OkZN17GyMNBBo2JmY1vLxP7z+C0WjDTFl53+md88hoIQvypWyK3cI6kHkzHC?=
 =?us-ascii?Q?mxpbYLeqj0SAZkM6rbypcI/2VrExeJOmCwDclbifn+56Du6W4qr+gM5dnnEt?=
 =?us-ascii?Q?fGW5NSPMsQ3EpaZx6HaDDfSD4AWBUaenctpc6W0XMujd1COHTbDYyZpC2N6K?=
 =?us-ascii?Q?dn4sM1ZW+FPkL2a5AcZFKamucnQft54g1eiKAzsSTwTurSjlSoOeq/AZcFRO?=
 =?us-ascii?Q?PxiIa21Ipq32Rc7WrQd8gbJxZNYT7TcJ9nWY0M4M2znPI5JPxi3zEycryDuc?=
 =?us-ascii?Q?Y2W9XzxVg0+k4mZVT0GBfV81Dpw/TGOBUW97Eq+4vP2dWN+iJHUHUIMANjtK?=
 =?us-ascii?Q?8l0Jqfq2xFW9dX/fcNE+vlZdzkoHBNC0t7ntYqYfgUTNvx7Z3f/ayIDHLuBR?=
 =?us-ascii?Q?2VmhnWZpIsEetB5D3F4DZ54gHHZt+N/cmwqLadZz20rEOjn4kphHBttf4UV0?=
 =?us-ascii?Q?TcGq1bT4DNjJm4v4UKRXniEh+Qiac3y8+JwmfZpCfvP3MtN88bW581aK3dzz?=
 =?us-ascii?Q?9wwVnn0mK8xxlmBJdfdWOze4hnHWTWiEZRq5HNuiMQhORdXyUPx2tOd7bY8F?=
 =?us-ascii?Q?BGdWb2xB7p7RZf7dE0JQ2m6O0irphNnPr6hcrU+iQn+FevhRPNNnFSehJ1Q4?=
 =?us-ascii?Q?Etb8K4Ixf8r0vzJy2fsBU6mGWmMCjJwdaMqbDeHlFk03k45JqUbURK4jZfPq?=
 =?us-ascii?Q?VWC3tPugahp1AG/zg0XttWhYFOb/W1CNiyKLogcnHRx7mmBWo697Fg7iKQyO?=
 =?us-ascii?Q?9lKwbzeHNvVW5m+Op7zYkLmxHVHVKQ3wYf6Lo/wjO1kdDC8T7CUsdxVdYr6Z?=
 =?us-ascii?Q?wirl1RsJfGKeeWDZV5/3/81zeYyccr3uLDPcMO71xu+Chpc6MmaIC4zPhiwj?=
 =?us-ascii?Q?PUDwgcPWD0+HfMzyBzfZDBbMA5cf0+u2iuTKz/rIj6UPSIuMtwdm5k6ESXBQ?=
 =?us-ascii?Q?FZ5Z29NIzUb2cKx6gnzIMHy8dUMMlkuVRfLxMGL7+g/czV+w0J4KNPsT+2RK?=
 =?us-ascii?Q?oIzJZ4RPGPXoBw1sEkvHUmgOF2Q+S733ite+SKhu5XgyPgbULApXoxV26w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:59.6873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633b2cff-95c9-4c70-5e79-08ddb31899cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

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
2.43.0


