Return-Path: <linux-rdma+bounces-5831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA389BFF9C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 09:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE841C2199D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C446C1D5CCF;
	Thu,  7 Nov 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PAvAkyo+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C81155398;
	Thu,  7 Nov 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966683; cv=fail; b=uCzQwBLJcxOs1RlMzDYVnjAEVmJLgh9yRywGI1caux3mciW/V0WgFrlFrTJa/u9vzdeBIlUrD//YU6dDKkTQHG43Y37d4docDrYK4OB4OEdtBSdUjSajhPVMdmF9mXh+W7rPu7jMFsyq5q/4xJKQOvpOND/PK6vW9oQ+PGTmwJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966683; c=relaxed/simple;
	bh=kPSzhW/HlrttbnmapXqwUMOVhd2/8kC2Vz21qdIZOy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb+Np1r5FIErsQ89OO4BjJDCwRizujn+rBO6QJ2hdaTymqiZHOKyldRCc5IcDTSHR4f7p51a81HekI1h8t63uRR2uSgKN4cNw3V8wo+DdTDFT88W4DZCfdZhCBT9zgKaoVQsWkBDfuo7HAfcJ+jImxmW1Hr73C/XXpHeUdFtaGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PAvAkyo+; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+VQ7WUSVzt1jK9YsDILU4sNzsXu2CI6/HXihAC1Ll5IGb8mulAa6W7weCGbQjF5ddAsxpuAD1BU62j/TvCQHGlNIWbVl38C4/XeWOT+AK+r9jvN9qWhgzDfjYO/bIUVIpVmjCjqJWpsMvmOvcAW6vlMGrPlw06Dm9CkA/0oJm37o4ld7CYlzzju49OPehJalsEklVxFpqgoyYtA3TNM3FRF6vcJcAUqyPMsS8SqWEZLfIrH5tX97LMjzKJKuOssX2rLEPRSanzIaQVNJ5fwBH3D1FYLvxYgP/MG8KK/r4bLrHqb2t7nBA+25xEeZwAJCadJMb/b1XceC7+cUMw4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA/MGtEORUUmGMMwM0leDBwubCRVf/5+1zCImVGoFBo=;
 b=IdPV8X7mk4UPg1SgPXgglkI491hhDefdrTEoN0a07ceDh4smecaDdHx0LjRP+GotW3Yk0kcsSSw/EQSwwu2xEu7XbF0Q7QxoG5j63HTJO5dbsZKBlBnofvm2BjegCF5I5mtISk0UaJWemx1eH3zpRW91QMC1EtDU/BD5P7m2rjFdWk5NlFf/oqdqkjVwlBsdwg7RH1MqsgahR69wQbRUyiSqTCbkk4jyUQseR+RcN+IE/5k34hXYFgy8PGEmuU4StkckFjroByGiYCd8axQLrZtX7E1YQfSW77ZbT7onKDpi9eLk24mTY8V9KDzsh519BtDHBwmZUju+Li0sZhQthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA/MGtEORUUmGMMwM0leDBwubCRVf/5+1zCImVGoFBo=;
 b=PAvAkyo+SRUSZf2TLwK1pptwBqw4UH1V9A5q1JikXiXy5pQjQsSQH3OWKX+Nqw8wzSOnT4nv+ro33So0cnZ/yaRCjeBymasfmenXbjl815xWbgPUUEJoYmebUkGls7WNkZ90dxLXwAjKuJb6/1TpyTdBwZhR2Xqw/bZZ1tq9rsXgQnKstIkp6xLPC5aoyoIRmXp9pvF7pv6NIO0W2jvEl8B5Wor7crMyC7yFewJZGqkwptnqd44xIxMgFDOyQ8eI8xSR7P6T8jXwa29ruSYnwJjNz1YGbMrraDedP2ibgddq5yMJt6cJgeGPqghVTLkJhNM37BTMYu+x2OxvW/8BMw==
Received: from BN1PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:e0::20)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 08:04:39 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::75) by BN1PR10CA0015.outlook.office365.com
 (2603:10b6:408:e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:04:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 00:04:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 00:04:25 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 00:04:23 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 4/5] rdma: update uapi headers
Date: Thu, 7 Nov 2024 10:02:47 +0200
Message-ID: <20241107080248.2028680-5-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107080248.2028680-1-cmeioahs@nvidia.com>
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: ce78f24e-3ea5-49fa-a11b-08dcff02d40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDrl6336cPL2BQ1iiJS9E40Gs5sKoPB9PEw/+Wg3R53QjExb0jUQUgbu9Oir?=
 =?us-ascii?Q?mLxG6yLLSBhjBusC4kEE+4QT6ZpGwF6As1BwhMliMzrnZdnkA9Vtz2KBMuFt?=
 =?us-ascii?Q?KyvGa4LSebCmYpm8BGSByTrQNeGP2e8FxkBKZWfWs/53/NFy9GTuw29lrQPh?=
 =?us-ascii?Q?tTQVPOSYkqclc6+H3M6X1KYEL9uDdwvST4h4QtRgEcRkNv2qZOcs4n6Um/Za?=
 =?us-ascii?Q?N7QnbeaiFQZe9KG1KCshawVQEdmWhSU8Xjm2X3mU+HK9uPbjGGFfBzS3Wq9b?=
 =?us-ascii?Q?lB3ickeYMNfJ21O4NvaRaLuC8sTor7cLWNgApSgPk+T8CU1LQ/9GRoC2fv+b?=
 =?us-ascii?Q?9PAlRIovSXt3k3c0wOoMA3fUAzZJCmcFJt13zyZ58i+G76N1+wTDs3THcMN6?=
 =?us-ascii?Q?PNpvLkL1UTYT6E+QoOycvLoG3Iy0CCLzyFMfHKjKiG78lT3l21RmD9wkdWwP?=
 =?us-ascii?Q?ob1kh6HIg62Zz5AaXCSjnWyu0SZBn0wAE7Rvtwpxu+aUGtKqRXVok8grwGsX?=
 =?us-ascii?Q?/QoPwAeYekDjaYk6S37CxmxCWPalrykB4eyVIRQMVd4PvwKBD9qhij6csFKY?=
 =?us-ascii?Q?rpJhW2hc6VrNyrcwf+fOBe2xMfQcnym+b2cyP1FgebTTzt7AKha8GfbAsqrP?=
 =?us-ascii?Q?xTc0EcDpkekGY9AKBYW1pCbyCfAU7VE8wn6s6GdPfwlJM6UQBTxwjlJDozDN?=
 =?us-ascii?Q?pbOuAt0+Lb6nO4hU1Q9dEyhK5h+GE4ru7jbrF4yUMVicDqaDqFu6gQbslW69?=
 =?us-ascii?Q?ilKEuciIfrh12ycJotiB0PhEzPEIGXYPg2KbRypVC98oPfObsxyWPUn4QW12?=
 =?us-ascii?Q?HHfkQtFtf3DoaaFtT+czxKklXY6ULWnRp6J732GicmjoBWo+I7i1n4EZ6pE+?=
 =?us-ascii?Q?2L/S03RYKRtSTsgtD51mNuexWwIEDG5+ZwP3CmCpcvBogaBouCBIobvLl1ub?=
 =?us-ascii?Q?mN1R+kQ1vQRlEeV16HQZsyEGE0eWEAncZTM7pYS03EeycBsfG6BCi0A0Hu5I?=
 =?us-ascii?Q?jWqK1glslsqmBTV+X03zEqDanfVfgo4W+X9KfgkDhgxyVKyc4HnGE7UCWFIS?=
 =?us-ascii?Q?eC7re5WQ0KZLzfQIjGXpVUUimEmSwQ/yJvYQbPrlpThw2lSgfzoICLRDmXBd?=
 =?us-ascii?Q?xzr9Hhn8ttXSd7pE4goo9Wxaa4YwSX80g1kD+82DgYg051Z+yihIx+x6eNNK?=
 =?us-ascii?Q?Z5rpjgxbPJIMDq+Is4fExVZJIMuwK+G/reqhb2Xn2Aq8MihJ8W5kbxlkyHD3?=
 =?us-ascii?Q?OufTyQsklXy3Gy7sr/E8VWmNzDShfmxdeHmBIFwKnW7wc/bh1hbU5M12Z2vK?=
 =?us-ascii?Q?9KPvAiDwIXBFJgc74A6MkeYhjPcjSigoCmjYZjDZVf4Ipnm5OK58+Cs7mSD2?=
 =?us-ascii?Q?HCjK5ORM8g2WAHiOeD1ilkX9dEmRb+yPtwNX3BQ7owLgInwp+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:04:39.0573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce78f24e-3ea5-49fa-a11b-08dcff02d40d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

From: Chiara Meiohas <cmeiohas@nvidia.com>

Update rdma_netlink.h file upto kernel commit 7566752e4d7d
("RDMA/nldev: Add IB device and net device rename events")

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index aaa78e93..28404085 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -638,6 +638,8 @@ enum rdma_nl_notify_event_type {
 	RDMA_UNREGISTER_EVENT,
 	RDMA_NETDEV_ATTACH_EVENT,
 	RDMA_NETDEV_DETACH_EVENT,
+	RDMA_RENAME_EVENT,
+	RDMA_NETDEV_RENAME_EVENT,
 };
 
 #endif /* _RDMA_NETLINK_H */
-- 
2.44.0


