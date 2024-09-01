Return-Path: <linux-rdma+bounces-4676-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDF96741A
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 02:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879DF1C21014
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 00:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3921E529;
	Sun,  1 Sep 2024 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="duRnvF/s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E218E3F;
	Sun,  1 Sep 2024 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152143; cv=fail; b=oDx8lmGUYiL4oSw3rCWgFRDufbaRx+9vlC12/5gKIaeonGOLKF53dP/bUQXoKdo90INStFCRCf37s+9S4CCiagZCsT0/Z5O2yKZwtcQvOeWr1XZ6RWF2EKnrxaHWHYcXQ/Kjkqy09AzJhS5EE2UAqSfaz+nT7hWy6u04KH/MHFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152143; c=relaxed/simple;
	bh=U5AluDAiMuVy2UxdpLtXLZ/p5+kSSnb8cyDhpfc6yUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gY9a6cDHUNeKYd7fILbWpAs+JZTEXgvkt4F92qYws5DjJAdapBIC5O/Bc5nXcfP6EiyOHWyeXCdnjB7sE4OsXPAOzbU3JUkQVMzEIkbvY4TpY+LqV48Glmfioy05NpmjnRJKyd02WOP4CLMfbFMiHkl8ACW9OwuMQ4Uw2WelwGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=duRnvF/s; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdP/afNVdPDzPDSbN6TtExLRX0bcvawoPJgeS7ktv5v8gyGuMTPro+j0oNqlF+Wjdj95CGJH+maYS6KHk5gmT6iP1+oFohTtUUHryrL3PlMmp5HLb4Jnn9PVU3pr1ryzWaLrYb+WPtpYz4Y6jfStK/tc02Bi2JI3qV6kjjpEkjcUGUL/7jyRMgmaIIyEYJW4FiNwy/z57y2PLV7Z4zEC5776MoU/sVbWXfN5anVgP4sFTmsBly6g8noXoCr8wzWmwsX5dhZg8L2k54EMg4OvboDgZ8edWQD4eVzZ1kO7IfNcVQAvAx5jklU7dsRQ7ZNq0/o55ZKtPvoFydDEgXpP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EgocS5CVZQL0X+3XeU/9M+cTmMoJsiB/I7JbQ3uG10=;
 b=UbOM/LojuYo21uoNW/5BsOF4F+XQhMpgmLZ/4tAl+pIo+zbb7sqwYvM3BgEYBxv7d8MtHk9zikfmuuLBsWeF+SKtmTXLR8SzM3wkdY8TybmmVMVGvzFILejS/l5xPSlmMyZTcIyVw8BHXiJvOlR0GMcmbPjcb6PBG5JeKZRzNa/dj2ZyQiSPuIL7ZbHcWhjbJ7jm7Ut2/L5AkmCvjzv8q8ZJFUF+0lWWUnMCUZ0XHySbpVhHpe/5c7TIkINaEnKniiTmQe848L5Y/kg1oRDwkXPNTQcK05W0vAx+d8ZMiyQ/g995QgzgSbn3uy8cJjEgOlnYNENBiNmmHDWfEfJJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EgocS5CVZQL0X+3XeU/9M+cTmMoJsiB/I7JbQ3uG10=;
 b=duRnvF/sJMic+MiomVTDQhAFE6829VGQL8x0WXmoEiJdsnjBWlmxgJZh60AjEhyi9Hb8NL+l095OSj9OGPCLXbG8h2WtB7hmGQE3q40PHgSFu7JrgwnGkr8+jjsbPpoDOXuVrvaFg4b870KR/wTlUvGzBhjQia6Rkr9yYVY2TDHG4KC9CfHU+bFDOSZ2d5zFQD3i9/NWQGgYP9XvgfD8vtjMrTDcI+7Jua+f6j2Sifj/d6lsbREKV8yk/Le7TkB5PRxKjWz/DLAZmgq3OEBTzyMO+/GECnRGuWJvQgOUGXfF6QPH+YYzQhTUlZyLiTyuowdPyTxn9Q15SOPZf0REmg==
Received: from BN0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:408:142::7)
 by SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sun, 1 Sep
 2024 00:55:37 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::1) by BN0PR08CA0022.outlook.office365.com
 (2603:10b6:408:142::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Sun, 1 Sep 2024 00:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 00:55:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 31 Aug
 2024 17:55:30 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 31 Aug 2024 17:55:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 31 Aug 2024 17:55:28 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [RFC iproute2-next 3/4] rdma: Expose whether RDMA monitoring is supported
Date: Sun, 1 Sep 2024 03:54:55 +0300
Message-ID: <20240901005456.25275-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240901005456.25275-1-michaelgur@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 164863a2-5594-4fc6-5f16-08dcca20caac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cubYFiNtSijeH10zl/kh5fNV9mBCugKluVJZzQkCAgrQ/fna/gtpXeNYShCR?=
 =?us-ascii?Q?nVe15IbdCdMikcNOLBUd8Ci0mmRYVyDByFkgVBxHdTMaj8M6Ylm3FkR0HKlw?=
 =?us-ascii?Q?uWyeZ8MDT/RDEmK2rpEYwbyB/6Xf9C5VlN+4usbduN7ir4iJMqXMLYSRc/D3?=
 =?us-ascii?Q?rywoAoptcfRWrWDWGalMX7GNrZgqHT/TjRsJTw1fCkfQiUM/g4uCrzFuTUl+?=
 =?us-ascii?Q?BRb7xLl77WzSmAwITV3LVsq7SlFjJ1kbAOdCzgKsUmnxJfKFWec+PmHbK2Nh?=
 =?us-ascii?Q?6Nsir5PAXy9TPQfVPRhNAxN4xMw8A3nG3WmD0FczYDSRA8ms0PMrFmBRuTyM?=
 =?us-ascii?Q?yX8uzl7LDIyTRyBm8Q3dieFkLhM8aT4+lqJFyUtQyTZ+r7KXai5ZMBm6RzgY?=
 =?us-ascii?Q?k06gclwz8zX/Zv2r77vqtzStcYLMxLUNZMzlSVl+rSentTqkchJ76I9xBU8k?=
 =?us-ascii?Q?8tET/7ufHcjswhhjAxgysyLmSAwvYVrEqM4rdf2sa5cpfYvYfysZTB2lt1dz?=
 =?us-ascii?Q?soGHHmnxQEXlIL7HJBEUqRZPwa+SL0Xp7sJVgrKEOyQ8V5F0tnPyJhg+nkHH?=
 =?us-ascii?Q?+F3GpQ+QwhUZJz5247LHJxI8elIuxpuTdNlGPL3JXH9PROAdnoedv2NT382f?=
 =?us-ascii?Q?WWHxgY8iwbyYvKrCI3SPUMQzE33APgQ6h5DY96ZYKU58DvcYBfsKMGWrzbxX?=
 =?us-ascii?Q?uJTaialyPiKL/cukHCJH6dL4eRzcREUaOpw8yRXu9Kex6luwwABcsd1wmG9/?=
 =?us-ascii?Q?tyOwKUP0Z2APlt/gvSWpUZyAUTwyhV9kUZK1LzQmPVzbJ4wZcqe7G4ZJxVyM?=
 =?us-ascii?Q?zU92KzAaQF9TVTaAxCQr9ftdGXNV8d4A1rRlDkNL0f6DzgP/EHH6emEjbBlP?=
 =?us-ascii?Q?5MBnc06cnUcs/cnl/TxFP2wifw6Z0jHWlI8dbqzrEbaPhFc8FC9TPrRnrHjt?=
 =?us-ascii?Q?XyQhNWiJeB9K3od62JPEZXVtHNW3wJDkLLJe9+DN2Yb3f72hb5m3UYRz6kBC?=
 =?us-ascii?Q?kHMenkHJU7ODl8aUpcDRJMadq3FEygWJVtgrG0X3feEuO6B3E/B5v+6/xSKi?=
 =?us-ascii?Q?igD5o6HB6Qs7YDWtfgVAy/bKJ1UYAYGFaeTuTSKoIbTQHhJG90NdxAknQ0Ic?=
 =?us-ascii?Q?OckrZD7Gr3uSZXesouhHc0P2y+cn7qmdG5Y+eHB2kUaOtp+2vFjdbufeZahW?=
 =?us-ascii?Q?MjVyVXMtjmdwBMghxxVmO3bCiJBlm6jv1b0xSflGwcWa88QfTPMT1Ze8FOfp?=
 =?us-ascii?Q?+IbnS5PmiPXj22b8j2SE3OH8fsw8WqJX9c2/MRSsD3C3AfEQbnApdT0sbMwT?=
 =?us-ascii?Q?AcNMuD9JheQ7r8ocCZk/cn9Gih63cyTA/6ui9IwqksnQYdJfUWK5nkDLLJxd?=
 =?us-ascii?Q?zbfUzndbapvY27G5luUcPdz42MrbqqWNxBnHAOns6/eSNot3ZtBpq711U6oL?=
 =?us-ascii?Q?tZTTL/j7QesyKwbIsV2vbENIs7XPHJeu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 00:55:36.5794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 164863a2-5594-4fc6-5f16-08dcca20caac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964

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
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
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
2.17.2


