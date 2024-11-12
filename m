Return-Path: <linux-rdma+bounces-5939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F599C528D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31FB1F2329C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231C20E332;
	Tue, 12 Nov 2024 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Phi0qP0D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6C20EA2C;
	Tue, 12 Nov 2024 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405535; cv=fail; b=pf/j8MFdjXb2oZJWR5iHQq93XuNaqYJT8GNaE6dptayhzrflEIcQOMH1KxureylNN8KMUnwfrUl+abiitHy8Qc14A87PiWFIXeRDy1oHqF/YMMhbJw1epA25t75uzXlbiWGkD/GxFBRFZ+6ssXvB7zPfJm8V4CZqC7OsCf48Dpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405535; c=relaxed/simple;
	bh=7AzVwdMpEGTPQmg/RIQ6+6NukoZvk/ZP6u/nk8X2IMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXpNIXisYbcI5mbF02TQUC/NiKbXt3tBTCH2OdpcQ1/1ZH5qYyRuGLg0NAj5+whIaIAePyXdsyBj+NBjJHvaAq2dpI4G4+97+cPQBFG3dHbO8E8U69xaHxeBXqI6AppBbGC7HJmIZzSuf1Nhe96IoeUT1vpAx5eWVintNVQJlSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Phi0qP0D; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrYSTLsJFbphTRda7EDgKbaiNo4EFUBsZmVK4q0Z85sjEraVoZgqXV6VLZUE2K++NQU/jKSGNyHJkPQmPzeotocGqK8G+lsZmaKbCiAbuLY8iOJfEfeL03oqFLGVVu4ZhaY1m+OGXcQ3gBPKfgV0iK8eU5bIXZdSjSVuhVO/ZGszZ9Kb1vN7VBH+S3LkyiNS74aQDpKWelyNJTMI6d1GXj3NHOsN6SSzvRqtFNjb9Jmpwn9D2HiEYD6X3g6CPzUZOyH91kQsDIIvolH2uYx/z+jrd3uXICkESVXuIxk/BihE3cbPFtZl49LUnWVboAL4fPuSbsPrijZti6Iv8heTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUfGHicv0ZzVSkWw+3sDCCDZKRMBeib2hhPUSeg8NaI=;
 b=o2JXLdudsbCz7/FiOcqV3dhti+0VmeZuwmRKpHROCHJxBrtDeamggPeALUvkERyROkk6o5BGQIlJJ7Qviyn0so5uYZ9XqvnlBBunUjdFyKSeaSMi7lWMBp8NXip6z/9+AV2lEVdYIm8vilpTLDuxiFnMl7dhtaKToalyAoqh9hTmNLWAXG/tesgsPEmnjEbyeGJYngvcJLBXuaxs5xldhEo/PbbkAbePVxfMB9ZBVVgySkziMcwoFzKAHsNxbEW30QVSA+i2+LamunH342YOIRv0ZDw9Btwgrg3qVPsfZQuKUHNshej3WsLD8fvl1R2MNRzQAytbau+36n629D3K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUfGHicv0ZzVSkWw+3sDCCDZKRMBeib2hhPUSeg8NaI=;
 b=Phi0qP0DODyXnDMhFUuJ/O8e4zA3MB4TZ4hluLH+kHInrndOWPrMVmwVW5kPzvfo8Wax8UmrUZgMJCfrRJ7CuGJfHpReZVGPY0C+BqoOiCGkyECGmjG78ZlM2Xfl5UT0CQDFS13V6ecMB/JFS1vIbvNwBrFfGvRgqse8dXucSE8i3+QEFeVJNou6WJI+o0nM8Rf6SOTH0cF3mwOT9EVwQsf4YKkyudbh0E1gslLdbb44XRkFsJqEsyn4X8DKvVIyeWnr1xKZYGAjZmplxWvIkFSgV783uhmTraDI/DWAkH0aqdjwK/rFXS6GJ5b+Z1eVGuI2AK7S0JuipVF3wBsagA==
Received: from BY5PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:1d0::26)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 09:58:42 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::11) by BY5PR04CA0016.outlook.office365.com
 (2603:10b6:a03:1d0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 09:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 09:58:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 01:58:35 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 01:58:34 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 01:58:33 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v3 iproute2-next 2/5] rdma: Expose whether RDMA monitoring is supported
Date: Tue, 12 Nov 2024 11:57:59 +0200
Message-ID: <20241112095802.2355220-3-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112095802.2355220-1-cmeioahs@nvidia.com>
References: <20241112095802.2355220-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e0025b-2758-4b2c-188c-08dd030096a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rw54O7FzRY8rywnaJOxWEd1TVvYLCD3qxuEX+EdkKw2P1KF/f6nizYbPoA2q?=
 =?us-ascii?Q?iqMcw/20ZeOQOp8v1m8v+7WGpwOMGi83aYnpzrPE0j9zxSqQacpnQr4hXrga?=
 =?us-ascii?Q?suzmf8cDUnWK1PkoPiEXLZNPXIUtS0wM9Od39V+qa6bCa7Z3yDtMNYjd7+T7?=
 =?us-ascii?Q?/mE6rWW9WuRUmhkkjwIWsLKSqMgimx9Xb/0joaoFbSRKO9md6ZIgLa02H8PE?=
 =?us-ascii?Q?2VKeBBTn7rpGvAqXI9L/MW14WdrjFVMFAc+GalstdqonzCVS6JdPeLFiWsgB?=
 =?us-ascii?Q?6OiMsq8QfXqQ9IVlHC5LrzfzII55emgo2AsS+ydWNSFcxrg9VFDzYfcUEcfF?=
 =?us-ascii?Q?piIc7Gg3Lr75v9IJMqnVyhPdTjxtdAvwZOIsOoTS+ARdegDCw6TknJkGP8SW?=
 =?us-ascii?Q?z0i9PdzfZ0pmpq6o4QHiCH78S8zuzh2lzdCwWcJxFk94iI2xYhpts835JXBj?=
 =?us-ascii?Q?qazki2s9JHzplDLq1eO9xD8vW0WtBZ3i3NEBsZylAj0H1t1e03pK9mX5rKJ1?=
 =?us-ascii?Q?PzMqEUSSnFFDJIy0mCkzdSz/ynlE4kAZ6v4IohR+Vqnmj8qDgb07FU/ZVgzQ?=
 =?us-ascii?Q?2N5eNIG4Jpva3lGxLbf8XG8LJ1w3vRx+lYc1ybPSEP4KnGXxeBkhKUeN6k1R?=
 =?us-ascii?Q?2gwz7FfJ8dpyItIVg72+xV2lYNXCbbdjC0zAvUF4bpvA3y/4qCQknVKPIa0b?=
 =?us-ascii?Q?cnK0YK2DgpupF0++nbHjxms+IFViPsmuT/41oCtZMs1QbB3rl86o/FzG9TiW?=
 =?us-ascii?Q?OwDiOTBp1PQKLksuOgcvaXjjsc7ZA8rtzsUDx7zfi7mfSr2fO2zQLiK4dtr7?=
 =?us-ascii?Q?TWLry2vS8CuP4sp3lUEkdxqn+5gPeoy1WjGl4AE1jz6ecxY8yhFQcD8Qh6Or?=
 =?us-ascii?Q?ISzekThvOozZG75pYp1X2vsZC0AgwvIDo4/smn1GTE/7DG83AjH0atiMpF7x?=
 =?us-ascii?Q?uVJLunW5GwMswrRAW3Tc7onjl/9PoHtlre2loKst6cD40g8ExAn6gL+HjV9q?=
 =?us-ascii?Q?SF0OqgsJxHrPHYvifBzDvP655Tx9Yx70/YN5c14PMkLrGnOM8LWYiZvjT4Em?=
 =?us-ascii?Q?Vphdd1Nu6n84PJk7QtC9vqAT6zzGz6LN6eKyQPi2P+m757DacnRS77ryaLGL?=
 =?us-ascii?Q?sIDey64YiSFo5SUXV/Cv42qeOjOH1OGUGItO5r81+be0tIEDahNsDH06Oi2T?=
 =?us-ascii?Q?tShJ6eLJksowFfjfy3O88ZOc63j2z8TGhstf6NXNjimSPqv8ol/DYmtAdZJq?=
 =?us-ascii?Q?iT6nFFKT20ae4061/U6y7wFULpkS/ccFtK8EBHJ6QgT6PaH7vY5ueq6IYeST?=
 =?us-ascii?Q?NPcKZtRwL7QdLGoJwnpx4R1K6krezf6qCaSQ9SndHEEwendt0Z7d4JdHKvjj?=
 =?us-ascii?Q?wUwOZRayQg2GaswYfhTZ8O6MVoiqKsdPGr5PpVRpmItKRhe96A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:58:41.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e0025b-2758-4b2c-188c-08dd030096a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

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


