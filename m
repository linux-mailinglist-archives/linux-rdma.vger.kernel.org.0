Return-Path: <linux-rdma+bounces-8319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F2A4E1F0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D020A17CA6F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F252641DB;
	Tue,  4 Mar 2025 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpXzibFs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB4209F33;
	Tue,  4 Mar 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099618; cv=fail; b=gDOQUEpndZGCDK5zNLLxG3N21A7wxQkqq8Swt3T8LotABdPP3u7qj9GDFA+e3HRue8FFgCR94XYK5rpASWIZcmK+NJ55JHJ5olISYpiUl1G9cfkNn9NYFfkqaROu657dEYrSUKoyXe8g+ZoPg/uiOAq/QC4MtDPy/dmlSr/ViXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099618; c=relaxed/simple;
	bh=XsoOv68TX8hnBivwSXCjxw6BB74+7kVZ08Hd/ntl6hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWEb0Xua0EDW/CwgLqrgAiMlmon1Omz2IddZHl8ZWiHdP0/3Wmss86MQgwA1tWceJt2y4HL7IZ1fb2bzrVF3XBaxgb/5OWeqVtOEK/mRl392stzzbDoILr3q9pcDff6/o3Zyj6VmoZrwVYu1tvlDL6+Nj/VC6HqI0ntQWEfUyEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpXzibFs; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrnUKgpnY5uNib2IlUH7VU+MeMdNb+zHteMyPGr3zM8XZmtyC8VFYuq5o7de3CLtoMpzEED1PKLaYMLfRWePtxun+UnmXfCc64MNn4f4k8eK31TwL7nsR60klwXS1s4KZKRAQIgW4FVydryilWgK7wW+wcyS5VctCKm4dArm5lnn9+dISpFnV7II54DCPKTZ1I+zgJESMJWd7d6lEsnmwCsWpc2kgAjhGJJ9LpAlR2kGuAIuAVAZOP32R7gf2t4Go+HllbHl3rE3MWtQUWtJxSXefvbQ1tnjk1KxLsGSOawMp7LPWKmANl5dR4b7v6lcJJVQMBi8oVZCyKxor1J5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+tDvwTv3R/4W74xVUqsC2BhDQCRXvUi5IthsQSMb/4=;
 b=yLPdRoL0vHytKRTEKDaxpTWutwI50fv+K4E81kHezfX26D0ZD+5wxeQhExM630pwaBW60b+UJmAGaxTxrTqoQShdKIUeAtilR+zsAp8yomLp+FThv0HLxYJmRJzLJHXApkncfqbb0tzL5v7k64PB6jpVi4H28C0qUkse2PAZRSCBD9PBAIbfTmsvQLBJjXWKMcbfDX8OINxMkO7m6ib1aYsBe5DkvuAcwnn2q3/bZbNN8qXICuIJEDrjhHkBnQScXABqsz7RBTBb1KoNySt0yH+4IyugxTssYVieR2QzJMgJF6AzLNi0ozln0xqz10jIWYBl8MaXj204kAyAFUnGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+tDvwTv3R/4W74xVUqsC2BhDQCRXvUi5IthsQSMb/4=;
 b=SpXzibFsXqokWDDIbkkt4km1hkVjGNVzoMYqNQkiSmAF1gBC5Lc+Vmlarg4K58iZvwWizN2EpJ66G1ZXr5YtBidS8lJAhxsZo38KIZ95uXQbM9ddZ1WGO9aRKfbZeA7qbIdUCrkxYnQRhscksDRbxhx9evg/y48IRxGeuVcOBUU/GeWj0azsM8uZPHCjx/NnCyd89weIYkYYMuoZ64HMktCGwArU+4LKAp7pRt4v7y1x3fga4GyJGc2mMjwCue0Hdrz0Z2n9IyHE6walsPvEdXhwphD3J0U6dWUMyONkSb+89BIaEpd6CTCHBfzkwuGjtPQ1lpTud5f5q+P0EId31g==
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:46:52 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::ff) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 14:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:46:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 06:46:39 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 06:46:38 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 06:46:36 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [RFC iproute2-next 1/2] rdma: update uapi headers
Date: Tue, 4 Mar 2025 16:46:15 +0200
Message-ID: <20250304144621.207187-2-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304144621.207187-1-phaddad@nvidia.com>
References: <20250304144621.207187-1-phaddad@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH7PR12MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4cb1ba-37d6-4a8d-362a-08dd5b2b6683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1Hpp9zOGeozYmKV2J9W3MJgHAdP4fyxEt4Ck4XVnnd4LBX2ahX+8hyBdhzr?=
 =?us-ascii?Q?38i8p53PhByFcBgBjR4Pkz/L6O3f14YAPiwzI3AughxAnGUktrjnA8RYjrDJ?=
 =?us-ascii?Q?6KBHnlMczg9ak/Fxi7n6P7g63tCVaCsEQxy7mjbRdhZ0p3vUpKzLieCXNarE?=
 =?us-ascii?Q?5hu12nSRCqm9ghuVuElPMpC9uwV0ne9sw3CvHzTLMHDzQ+dVCY0vJxN/9uuN?=
 =?us-ascii?Q?txmZEikie4AF9aaGfLRYfraCzVyHO7OATXpSmFdthya5RJ9yPnY8H6ts512V?=
 =?us-ascii?Q?316A+ZppqzJdas3LqiEZrauoa41HzPKUrrmCIzVD8EJtP6g4pr/YfiuhQ1y/?=
 =?us-ascii?Q?dwL7T1u7Z0OTqvA7unjwIMeNOavJzf3kx/bHab2obEh7sVaESe0waIdTDodh?=
 =?us-ascii?Q?xpVaeHMODVGNEZoeugb9dCqN9Jk/dcBorf2wh8rZm7gOkIzfNAxTD1Y6aGkb?=
 =?us-ascii?Q?cSws+KYbbN/M1d4yZXSzZyH7rVvpdAUi5+jgGANexExkxmXFUNklVos/5xtO?=
 =?us-ascii?Q?h17y5jcNKDwuUMLS7CBjy2kCRsR8iZ3lNWCgP83/iQuh33qW1I1VO88JdGAi?=
 =?us-ascii?Q?SM0SFdvYb4fY+nZTujkMDkNHENQuiWhCs8ioMVQT84MneG928jZ+y6buwoAQ?=
 =?us-ascii?Q?4ZFXas0jy2FY3dR8bMKUWlpOmB2TzBEbyk3jfxV5EqVGbZZ9I9ZSOeXuXobD?=
 =?us-ascii?Q?MtkQx0TboSRRpyBIoo2orUzh7KfJJD4TuHSzydxI1SED6907n10x5frX/3B8?=
 =?us-ascii?Q?X1CL1qDS3I0WfyjNzyMmO5Yc5K6gc83ok1p2ODVRHB+qrNF+XJAD837tN4Af?=
 =?us-ascii?Q?sU/zTtNTdQx+dEND62skBB4cxe2CVkt63YqZ5dgVCZnD1CjGXFSKT0uuFfyn?=
 =?us-ascii?Q?OlDhYMdzAdTea8J7XDS3fiGQEwYvm+egXoyahJilWOKSGtAq02ChDmJMY1gC?=
 =?us-ascii?Q?cXRT1Bvb++Bo19lDbJ0ss5E1isWyw+cZRcr5KwHUrl9/U9Ek2EIK+HbWxo1m?=
 =?us-ascii?Q?I7Y4VYNeAawCj6/+2InStO9HXsLrPFLACDmCQIcDrs3iCIkAz/p+WdRfIhUK?=
 =?us-ascii?Q?amIJpOeQQfAY3/NYKCw1J3x2OXAysijkG6Zw3mFv4LLPKsav6SvqXqK3jJVQ?=
 =?us-ascii?Q?NoGA9bKIaA8ClpHERqJp+OWA5FexqQvD25llBRBqPbBcDtND8NytSi4JoMkg?=
 =?us-ascii?Q?Ata0PJBjK9yKYg+jzu7aVuwJCgyLhPmb7OiH7E9G7tK1ucw/mtL3ZcQ+Gpmj?=
 =?us-ascii?Q?MGkHWevOs4Nw+jZOBZYpZ7NcyJ7qUluUuanwDGJH7BvDOIa334kCEdlyhz8B?=
 =?us-ascii?Q?kggKqVc+sNjE4Doj1Ot95YA8RaJp0TnDNiDeDgjIjNQsbkosumwzLhKNXxgu?=
 =?us-ascii?Q?DFnd8A5squd7mf0afJUhQNEQ6MbnY6Thb7/vocoOX4EeviRFronEqnegDE8D?=
 =?us-ascii?Q?Z3HiDIg5a3JEODEersX/GD9Z10x2IAKYu3j5XAeL7e9o+LQMkhCFgEDNzgXw?=
 =?us-ascii?Q?jUmO5Ftp1fD5qos=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:46:51.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4cb1ba-37d6-4a8d-362a-08dd5b2b6683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892

Update rdma_netlink.h file upto kernel commit ????????????
("RDMA/core: Add support to optional-counters binding configuration")

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 28404085..ec8c19ca 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -580,6 +580,8 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
 
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
+
+	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
 	/*
 	 * Always the end
 	 */
-- 
2.47.0


