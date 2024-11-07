Return-Path: <linux-rdma+bounces-5828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1559BFF95
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 09:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBA7282CFE
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 08:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7571D2B0E;
	Thu,  7 Nov 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgNEbIRg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC519AA5A;
	Thu,  7 Nov 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966665; cv=fail; b=kCHvZBerIRUHhwey+iLcETg/WZh+iUR2F4iGdzLlmM8ILzZGFwvaKmJOnORliResSuDLpdeBXQMMurkPxU2Q0xqF8wfevFGxRk3kWJ1XEa6Y6nNhHzKnzar2vAPZa+iqRfFF6SXKj/oF3+46hJPmbLW57mPN3jHDUCSYW7oclz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966665; c=relaxed/simple;
	bh=7AzVwdMpEGTPQmg/RIQ6+6NukoZvk/ZP6u/nk8X2IMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLV/hX5a9MHPxczqUddST+lsDdqoS/wRm9HlWqXik1lhMMLsTEoasce1PyOtNIbipuzzJ4UF6SEkwCi5c01dxIwHZF9NqmV4YrYfDVm8vivlc45gfyjVteCclaNywPI/ZKYcdH6fG0hfDTYwFUM7Qx+vci/ty4BMKNKSgPVDXbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgNEbIRg; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qcv9thAdIXJpusXr3QBvZO5RtWyKVQAVQQrS1K99EwC3vCDh7UNKOg2uzOJ71eQ0qG9ctEuJV08H5qrYjJEyvNeBfcI28pbQ/dlys6m0fVRqLhf2Of+MQxbYQUBQ2WwfQxaVAo4Zn7hKxaQzYePjkEd184kNsu+7Yq4mhGxLuCnRQJFFN5RTHGOQ8EI9nisqwIhJed++Yc58H5R8q3FZnrLQ3AzNalEBWit4jdlJrT9BuqVIRw+CTpSdjYi1T8H61XdWsZyJHMPcdYcO/k0D1k4xIaemxx8jkBByc60pRQTS2WuI6EN+vsuOSK8EuhAdYd81JMfnkr768qXm0m6P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUfGHicv0ZzVSkWw+3sDCCDZKRMBeib2hhPUSeg8NaI=;
 b=EKIl3+Bozn2+DvTNqrws6gpCWUSajD0hDygctUOncpQ5cA/b9yCppQN+amcBUxwmeNd/SfKKeZ2MblUll2zjd3G5VtD9ZMOJ/Gy4RV0ZPoruTvFCoqA0l0QL81zgFSTikayB1Llo6B/CCSCDedTrIDNmDCMADBf2iShlmYCp/wN38pklDYWJvPjThy4wKecaIRv/opAkro7qKbWhqWAFkQSGWBNNK9SOuc0lICXGKDhy4QVXO1Ffjyl1L66NkkNqX6onUyE36LUcgMzwSJ5ERcbQNvJCkFAGqBen3PYZsowdVc5E2eA7Xr/v3gI/tGGJMlIDMChYF8FKm71LlIPzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUfGHicv0ZzVSkWw+3sDCCDZKRMBeib2hhPUSeg8NaI=;
 b=kgNEbIRgOXKSRztlV09DoYB9C5zasaLH3mAJ1LQ0lBFW91ujTfw/irpLoQouSAR0vijLWT2Pt9QNHZW4JbQxYrP00mS8UtlUZNE6npeYc1isMOVTCuB3ZDBzGxqVTBBNoWu7jQYjEtAYLnVen72sMoPwldX/hT0OpybDYnSXulhTqEU/EWgjDWqwoOqrVWW5ZvzXC4g5IJGiPY9Slz3Xai3FT210OwY7plRfwHc3Ao/vowqQocWcOXuqPftaEMicClivgmzJ2ZJwfvs07yZ846oh+27PhQDTZvMMV/4mtAAEY/QioeGi8E1CUkxChL6/eYqaXfl8jXVJUQGhjtKpDg==
Received: from MN2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:208:23b::14)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 08:04:19 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::37) by MN2PR11CA0009.outlook.office365.com
 (2603:10b6:208:23b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 08:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:04:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 00:04:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 00:04:07 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 00:04:05 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v2 iproute2-next 2/5] rdma: Expose whether RDMA monitoring is supported
Date: Thu, 7 Nov 2024 10:02:45 +0200
Message-ID: <20241107080248.2028680-3-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff4abd9-f724-41e6-d96c-08dcff02c80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?831na0vglASB/XbnjR0wG5rez4v/j4iKN7PHUxxQ5t3uUky5thu+kpSVXbg2?=
 =?us-ascii?Q?KrKeOC4Qh6yaYHiKoEgf+Qh7bEYCoGtE3DiBygOAHcYO0MIDWyZAwpjAzNXJ?=
 =?us-ascii?Q?awKGYWtKOen/9sQJjNJkUcl+orxjHRP3JTqQ8xsfbnMF7G0uH5glZaoB/39o?=
 =?us-ascii?Q?cPPr/tVG9+zRwR+WAdwJTPYTXnoYa1s7Pur1FECPZ4E1ktrIAxOqptG7Cmfv?=
 =?us-ascii?Q?VzTOIicHw6QZq8/7cm9xufzO0uBSPfNyxWRgZRcBH6bO0z8BNEP3VlBy+eD6?=
 =?us-ascii?Q?ZFTGzN+XytJF4DyTC3Vp7sWgAFtVaJXaU75MM9LZB7XrgFhEpYOa0fhA8dzy?=
 =?us-ascii?Q?5IQJGOx6ubPRLA3u4lqQ5CV7oWVOucxvjV6tLYVHzolSir5/a02uN0NfkA5i?=
 =?us-ascii?Q?PQgr/0XxUBNrOD4Vi4Aei9mrUjaINRoDa8iiV4T0774bUMHtIHAuk1zl16Cy?=
 =?us-ascii?Q?beLgCk1a0lsCiNcGJ7uaMoAf3WYMC9f13lE69UgZkfRvvzcLjQiGS1X5Xl7B?=
 =?us-ascii?Q?CmL6qalidgASKKVGU6gWV39Qday/aVxFjIhp1NKr1Z4dla4SGX1OfHrFUkVC?=
 =?us-ascii?Q?y+QrB4+qwzp/9FwbIEt7wSecN4hxJqmSw9jWoQn7HyqNh32bo3I426g7ZROJ?=
 =?us-ascii?Q?Z6R+gkTRZnKBnQmt0xH3aeteuoL5RHYPpHUYfBhArRqLm0SQyiZG4C84HXe0?=
 =?us-ascii?Q?EXL7rhqdHTQlmAg9YnR3vRWlyq/AJpiQGJhyX/ZOJo7devvsYCM8J14HZDFN?=
 =?us-ascii?Q?zrt6NBwcHziA7MSano3bDR74jNL8Wjq9aVuM2nAoPsKxteNwYFtQaqOB+ENx?=
 =?us-ascii?Q?cpIBwy89zgJi4OHATdV4hZsViV0TMgfbWIG3zSAU2aOPCDVWrD3J+CP4Difs?=
 =?us-ascii?Q?g8rqQSAdyX24rQEspsQbiElabgp+GuDVu9wThHZeFlRGo/mY/uHQXWFxV7M8?=
 =?us-ascii?Q?FYNjYbs9i0+ZRz48ZpLny5Yq6bvNgvWcutvddF9cDuP0DvDltnasMBk9dAki?=
 =?us-ascii?Q?4kbUvwIQAq0/TLhKjmdqfycyOYtH4oyBcYCfzHcJFh7rbyGCTvqdu4jndAY5?=
 =?us-ascii?Q?iK7VYgx9ldMuuS/aGTIKYvfk2d1/jNJHt3/0M+ax7NnXN7pemLZfsW3dpxyM?=
 =?us-ascii?Q?JnNYDh1fD5OJdBGAFw5ptpADfJ1ahsmDsnPM8iweUS5r3ywkfU3Fyz4f/jFp?=
 =?us-ascii?Q?W+rnaKq3WjT9Z8ALuZSwZUJ9T5jsIMqDKEA4YFTXEU0Emkiamqj4IEmAU1ne?=
 =?us-ascii?Q?ZbcLnJrPI9EGFgOGfvwfPh3bzG40DwEVmhjzgK3c4KuXrRRCrFkP1uSaLu7l?=
 =?us-ascii?Q?2raccqKNcY/YEWz4HbJXXpJjGUkMa0quqrFeGVnve4BMYY9Bt70PvRwd294q?=
 =?us-ascii?Q?tEY8rx9jUF9QpHZaerT24rT/EAmaEcSghO8I/gXyQhrXKtj02A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(61400799027);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:04:18.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff4abd9-f724-41e6-d96c-08dcff02c80b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070

From: Chiara Meiohas <cmeiohas@nvidia.com>

Extend the "rdma sys" command to display whether RDMA
monitoring is supported.

Example output for kernel where monitoring is supported:
$ rdma sys show
netns shared privileged-qkey off monitor on copy-on-fork on

Example output for kernel where monitoring is not supported:
$ rdma sys show
netns shared privileged-qkey off monitor off copy-on-fork on

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 man/man8/rdma-system.8 | 9 +++++----
 rdma/sys.c             | 6 ++++++
 rdma/utils.c           | 1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
index 554938eb..5373027a 100644
--- a/man/man8/rdma-system.8
+++ b/man/man8/rdma-system.8
@@ -38,8 +38,8 @@ rdma-system \- RDMA subsystem configuration
 .SS rdma system set - set RDMA subsystem network namespace mode or
 privileged qkey mode
 
-.SS rdma system show - display RDMA subsystem network namespace mode and
-privileged qkey state
+.SS rdma system show - display RDMA subsystem network namespace mode,
+privileged qkey state and whether RDMA monitoring is supported.
 
 .PP
 .I "NEWMODE"
@@ -66,8 +66,8 @@ controlled QKEY or not.
 .PP
 rdma system show
 .RS 4
-Shows the state of RDMA subsystem network namespace mode on the system and
-the state of privileged qkey parameter.
+Shows the state of RDMA subsystem network namespace mode on the system,
+the state of privileged qkey parameter and whether RDMA monitor is supported.
 .RE
 .PP
 rdma system set netns exclusive
@@ -100,6 +100,7 @@ is *not* allowed to specify a controlled QKEY.
 .BR rdma (8),
 .BR rdma-link (8),
 .BR rdma-resource (8),
+.BR rdma-monitor (8),
 .BR network_namespaces (7),
 .BR namespaces (7),
 .br
diff --git a/rdma/sys.c b/rdma/sys.c
index 7dbe4409..9f538e41 100644
--- a/rdma/sys.c
+++ b/rdma/sys.c
@@ -20,6 +20,7 @@ static const char *netns_modes_str[] = {
 static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
+	uint8_t mon_mode = 0;
 	bool cof = false;
 
 	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
@@ -48,6 +49,10 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
 
 	}
 
+	if (tb[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE])
+		mon_mode = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE]);
+	print_on_off(PRINT_ANY, "monitor", "monitor %s ", mon_mode);
+
 	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
 		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
 
@@ -77,6 +82,7 @@ static int sys_show(struct rd *rd)
 		{ NULL,			sys_show_no_args},
 		{ "netns",		sys_show_no_args},
 		{ "privileged-qkey",	sys_show_no_args},
+		{ "monitor",		sys_show_no_args},
 		{ 0 }
 	};
 
diff --git a/rdma/utils.c b/rdma/utils.c
index bc104e0f..07cb0224 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -478,6 +478,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_TYPE] = MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_PARENT_NAME] = MNL_TYPE_STRING,
 	[RDMA_NLDEV_ATTR_EVENT_TYPE] = MNL_TYPE_U8,
+	[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE] = MNL_TYPE_U8,
 };
 
 static int rd_attr_check(const struct nlattr *attr, int *typep)
-- 
2.44.0


