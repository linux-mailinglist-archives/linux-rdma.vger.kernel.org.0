Return-Path: <linux-rdma+bounces-3577-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4891D9F5
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 10:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F32A1C20FA6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B439FF3;
	Mon,  1 Jul 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LW4O5t0C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639CA54F87
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822707; cv=fail; b=SOqch/1U/vzbjG4zOGFYDLZvW4oaigmJlPobLF5/FQWobfmMkz+nYXzW2ApJsni3KKLBlnX1xSk5h/3Ye1+GUZvghtMoWHlHXPDob+Fy2cNDPdmgUA+EFXaG1NFoVy6pOYLnzqUbivMPuV/5TZE7JFxEJaRPVzSFMzJKCHI2F34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822707; c=relaxed/simple;
	bh=wazHNU1T/NB/J7gRI62CjynA2FMRdUeGfJXWlDz7/a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIe2dNJIeXqqInfsY5BoWl/T1XCFe7wYCOPfX1qnaPQGQshUOr8J7ohZu5678DCWLqYAigxWn29QiARuCMx5OnpvSAWoBKt6ZwiOyBUE7VnGDrE8XCKbU7zKgHBuNxheiK5yjeEGOEDzo/puL1oOPQOBXHUHUq/UB7O4Fs5HIpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LW4O5t0C; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjmRIF0sHkCIMbtdHZ0xlhl2f2kzwtRLPsLQOUg9v/t0V1igUUq+2Eenh8qGN1hTIfjeDvLew9D9MiPxUkNgZ4Vu46RF0UsXaB59NAdP7o4/ByHK18CVImtHW+gOVcPHJmPq3hfjg/eW7pLMsgnOA7iumZ8jkI1qjW52jEK1F6MXw4ptIg2ItyC6/tfzEKvfpjL2pb12B79P8feIR/jb89GUW5f3KCLdhhMEkVCEfnbljEh3KiK46SDp7AtydRoZKi0ZRcCh/8pvMpWHtMBbGqv+AaX6TLC6pJ5HD9QxDrVoRY2ZRQFB2tdFdyKPVSfd/XiUU7cJLp+iv23kjHLk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgNEUjDT0FdRmHKi2iGBeji+HDl+yTNZen139/uiz3I=;
 b=nT1SyzL5uRxoPivp2uyAq2pNmtVkrRKpZ8UJ6cZ9Cd0YWnudlrwcxX8H3I5oE/YnuuCrsjU8rDFi0HqpwUsN0Y3tHufFf2OuVy0BK2KsSB66bIK+H77Y3N3Bita6Xp2iScBnSAWKINy9NAahiS30ku49lVF597hjdO8ZFq/nsXiRqoXt0m9fFJWcAFPpKPfjG5opTh8qn3SmJ2GAX7SNWprkgdwgmHiP2uBwA9eAsIs69fohpU6JOx6ZW6qi1ZxzuYjrksliIK3IgKIHhcEuxDYcNR3asruq8bDqIeL8xGyOGqLDAFlX/XaX8tNJuC2btbMERlYF0OJdz1s7zTWcZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgNEUjDT0FdRmHKi2iGBeji+HDl+yTNZen139/uiz3I=;
 b=LW4O5t0C/0X3PhaY11N9dFGd5SGaemUL8rBGDy1et/MbBVxXteuJ1YbnHJU6KLsbjoAW5ZdpsyzFiRkyLcnY4XY0XQcfjzLz7FoF4PtBPKw5oQ8qEESDIulqyOVwSf7gcAkm0W7QhgVRY3bYpA508HhvXT6mAwfNeXKQOTroj4eZ1iO9mAXz6TBj9aOSMWFtxoEcS8cz1ReyZBng6d/CeTEpc0GM/xUa3BecNeTjccCYAGOebP8si1Iky7/DY3Th2naiXdLK7T4cDQ3RlWjLar9uBhvxJqpNb0a116nwHgtYps2Tv64FgHovMMXXdWXe1mRuqNYR3yFkW0Q7ttoDkw==
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 08:31:42 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::3f) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 08:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 08:31:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 01:31:25 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 01:31:24 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 1 Jul
 2024 01:31:22 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [RFC iproute2-next 2/2] rdma: Supports to add/delete a device with type SMI
Date: Mon, 1 Jul 2024 11:31:12 +0300
Message-ID: <20240701083112.1793515-3-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20240701083112.1793515-1-markzhang@nvidia.com>
References: <20240701083112.1793515-1-markzhang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd23429-4c7b-456d-e11a-08dc99a83c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8QmqGDsh7aGHuhWVSORzzKEbKIbhbmPeyB5yLPp/+N5RSVJjepMz2gMXk1eE?=
 =?us-ascii?Q?VuBJaUj8L85+4tQXZ4OkSci67fVo12DiSm/DW6q0JFz//bVzmao+p732ueS0?=
 =?us-ascii?Q?48nR54g7V3aoS1OKRFAohAhAKnZrnHdZaGv/+A4WM2+8jj4yBQnFdw6MFIru?=
 =?us-ascii?Q?peQBJnEO0yfCWHqc5y+eictKxGvn6YdKccW+it2C2Del6CR8/1VyXaf8dI03?=
 =?us-ascii?Q?rrLyr9FZ7eCXFStk8evTcGfLWLAQWg5xt1eD0xu0txF30E/5z6IUztrboSTo?=
 =?us-ascii?Q?n0q+tU4FlwsTyDMEiEhmReyzMwP0usuJPXFswLiXWYNRSnUWIvaaz9zsvFtn?=
 =?us-ascii?Q?lW0SumOCRrKVCCzekEV3yUq5wopZN6NxRP8KWtl14Mn/7SfeOwl5yqZhTY5H?=
 =?us-ascii?Q?qTK/o3wCR980eimOQ0u5+Wwfu7bPhxM3UeXB1ghs4mQFc6DqwDJQNkSU0mMD?=
 =?us-ascii?Q?+jt7ddKptMtOruYR8/mN7mJMAE3yzaZblXGYt2QaRpGgKhZ3t+Fvc73/SXlK?=
 =?us-ascii?Q?bxx7dGbA73itf4edty+HDKXayPT0OVrvTK9ZxIhMKa75FgOhEG6YeapswgoM?=
 =?us-ascii?Q?b8++C0quHb/pRKZVlSuQi5RaeZ4GM9eCZHF4HazVOioLauaPrrFikBygCx9y?=
 =?us-ascii?Q?KmEJvQGaMi6tDOuchbhIUJ72TW0kcbR9lBCUh5DYL0oxyhADtajgM777Ws+q?=
 =?us-ascii?Q?bGmznnaYWBi8xr9cYFg+6E8SIBKDQKYXBR6DkAmaWO2qE3fT7EoZcTQLbshC?=
 =?us-ascii?Q?hOYAfiCqLYXhK57rMZRWeuFKadO8gYPdHxZiOf8GHxAcv2NEQFOoXxrWMkPR?=
 =?us-ascii?Q?z06zFndf4odWiIzLmBtawJW2gGZW/G8895EPChATPgv2kimLwLIbYqu5DTHg?=
 =?us-ascii?Q?m2sO2yyAg+3pK/wMKe6AO3Q8yQSwFFz8f4z8YciyqQfXhD4yplvLdMHJWtJw?=
 =?us-ascii?Q?o8F5KTFklOcXTqzyCnWngMIlt7+DzVFq2WgaPakKCEQxptfrbyQIOWeNWuA5?=
 =?us-ascii?Q?EraLw1G1xRQWHoqqPMcLC158ZXPrO8+ZCgCF7VPCWdlPQR1nO17myagzkbCP?=
 =?us-ascii?Q?y7MN3x0LxPkK7/kTiDoqjlTEaL2E8ElNCeo197jobUgx/jhbJKbQR7b9jmh2?=
 =?us-ascii?Q?vVowFnlnVR4p41FZy4DMNNz5+SiNB9sOpYJ74Mmm5XhsGmi04k7Y5Msvl6e8?=
 =?us-ascii?Q?MhHfYU9fp3YfbrcbiNrIjfBkEw+MnB831lcqj6RUG9VLVhlLQaGubg/Cq1pf?=
 =?us-ascii?Q?9cH2qW1aQAa9ZX6YFMRvJFi5nloJNwJkUoVuW0+nALetmw9mSA/tVYl8EM5S?=
 =?us-ascii?Q?dh/bJq6+Fjl1frs0FGqyHTrLtRZ25gU+RRig02NuFdfBOk4r2+HYhpuZr9Io?=
 =?us-ascii?Q?HBZ8L5u3v9QdqHc0GLPpTLchX4tqO2UlVgUbBiIHuHw04P9uUqA8iGcQgfp8?=
 =?us-ascii?Q?UfbmvlgzChu7buKBP7h2jYA0UPzjA6md?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:31:41.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd23429-4c7b-456d-e11a-08dc99a83c0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

This patch adds a new device attribute "type", as well as supports to
add and delete a rdma device with a specific type. This new device
provides a subset of functionalists defined in IBTA spec.

Currently only type "SMI" is supported: A SMI device provides SMI (QP0)
interface; This device and it's parent associates with the same HCA port
and shares the physical link, so when the parent doesn't support SMI,
It allows the subnet manager to configure the link.

This patch also supports to print device type and parent if any.

Examples:
$ rdma dev add smi1 type SMI parent ibp8s0f1
$ rdma dev show smi1
2: smi1: node_type ca fw 20.38.1002 node_guid 9803:9b03:009f:d5ef sys_image_guid 9803:9b03:009f:d5ee type smi parent ibp8s0f1
$ rdma dev del smi1

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 man/man8/rdma-dev.8 |  40 +++++++++++++++
 rdma/dev.c          | 120 ++++++++++++++++++++++++++++++++++++++++++++
 rdma/rdma.h         |   2 +
 rdma/utils.c        |   2 +
 4 files changed, 164 insertions(+)

diff --git a/man/man8/rdma-dev.8 b/man/man8/rdma-dev.8
index 368cdc7c..e26f738c 100644
--- a/man/man8/rdma-dev.8
+++ b/man/man8/rdma-dev.8
@@ -40,6 +40,18 @@ rdma-dev \- RDMA device configuration
 .BR adaptive-moderation
 .BR [on/off]
 
+.ti -8
+.B rdma dev add
+.RI "[ " NAME " ]"
+.B type
+.RI "[ " TYPE " ]"
+.B parent
+.RI "[ " PARENT_DEV " ]"
+
+.ti -8
+.B rdma dev delete
+.RI "[ " NAME " ]"
+
 .ti -8
 .B rdma dev help
 
@@ -53,6 +65,22 @@ rdma-dev \- RDMA device configuration
 - specifies the RDMA device to show.
 If this argument is omitted all devices are listed.
 
+.SS rdma dev add - Add a RDMA device with a specific type and parent IB device; This new device provides subset of functionalities defined in IBTA spec.
+.SS rdma dev delete - Delete a RDMA device which is created with the "add" command.
+.I NAME
+- The name of the device being added/deleted.
+
+.I TYPE
+- The type of the device being added; It specifies which functionalities it provides. Supported device type:
+.sp
+.in +8
+.B SMI
+- A device with this type provides SMI (QP0) interface. This device and it's parent associates with the same HCA port and shares the physical link, so when the parent doesn't support SMI, then this type of device can be created to allow the subnet manager to configure the link.
+.in -8
+
+.I PARENT_DEV
+- The name of its parent IB device.
+
 .SH "EXAMPLES"
 .PP
 rdma dev
@@ -84,6 +112,16 @@ Sets the state of adaptive interrupt moderation for the RDMA device.
 This is a global setting for the RDMA device but the value is printed for each CQ individually because the state is constant from CQ allocation.
 .RE
 .PP
+rdma dev add smi1 type SMI parent ibp8s0f1
+.RS 4
+Add a new IB device with name "smi1", type "SMI", and "ibp8s0f1" as its parent device.
+.RE
+.PP
+rdma dev delete smi1
+.RS 4
+Delete the IB device "smi1".
+.RE
+.PP
 
 .SH SEE ALSO
 .BR ip (8),
@@ -96,3 +134,5 @@ This is a global setting for the RDMA device but the value is printed for each C
 
 .SH AUTHOR
 Leon Romanovsky <leonro@mellanox.com>
+.br
+Mark Zhang <markzhang@nvidia.com>
diff --git a/rdma/dev.c b/rdma/dev.c
index f495b713..fd60c1a0 100644
--- a/rdma/dev.c
+++ b/rdma/dev.c
@@ -10,6 +10,8 @@
 static int dev_help(struct rd *rd)
 {
 	pr_out("Usage: %s dev show [DEV]\n", rd->filename);
+	pr_out("       %s dev add DEVNAME type TYPE parent PARENT_DEVNAME\n", rd->filename);
+	pr_out("       %s dev delete DEVNAME\n", rd->filename);
 	pr_out("       %s dev set [DEV] name DEVNAME\n", rd->filename);
 	pr_out("       %s dev set [DEV] netns NSNAME\n", rd->filename);
 	pr_out("       %s dev set [DEV] adaptive-moderation [on|off]\n", rd->filename);
@@ -148,6 +150,36 @@ static void dev_print_sys_image_guid(struct nlattr **tb)
 	print_string(PRINT_ANY, "sys_image_guid", "sys_image_guid %s ", str);
 }
 
+static const char *dev_type2str(uint32_t type)
+{
+	if (type == RDMA_DEVICE_TYPE_SMI)
+		return "smi";
+
+	return "unknown";
+}
+
+static void dev_print_type(struct nlattr **tb)
+{
+	uint32_t type;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_TYPE])
+		return;
+
+	type = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_DEV_TYPE]);
+	print_string(PRINT_ANY, "type", "type %s ", dev_type2str(type));
+}
+
+static void dev_print_parent(struct nlattr **tb)
+{
+	const char *parent;
+
+	if (!tb[RDMA_NLDEV_ATTR_PARENT_NAME])
+		return;
+
+	parent = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_PARENT_NAME]);
+	print_string(PRINT_ANY, "parent", "parent %s ", parent);
+}
+
 static void dev_print_dim_setting(struct nlattr **tb)
 {
 	uint8_t dim_setting;
@@ -221,6 +253,8 @@ static int dev_parse_cb(const struct nlmsghdr *nlh, void *data)
 	dev_print_fw(tb);
 	dev_print_node_guid(tb);
 	dev_print_sys_image_guid(tb);
+	dev_print_type(tb);
+	dev_print_parent(tb);
 	if (rd->show_details) {
 		dev_print_dim_setting(tb);
 		dev_print_caps(tb);
@@ -366,10 +400,96 @@ static int dev_set(struct rd *rd)
 	return rd_exec_require_dev(rd, dev_one_set);
 }
 
+static int _dev_add_type_parent(struct rd *rd)
+{
+	uint32_t seq;
+
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_NEWDEV, &seq,
+		       (NLM_F_REQUEST | NLM_F_ACK));
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
+	mnl_attr_put_strz(rd->nlh, RDMA_NLDEV_ATTR_DEV_NAME, rd->dev_name);
+	mnl_attr_put_u8(rd->nlh, RDMA_NLDEV_ATTR_DEV_TYPE, rd->dev_type);
+
+	return rd_sendrecv_msg(rd, seq);
+}
+
+static int dev_add_type_parent(struct rd *rd)
+{
+	return rd_exec_require_dev(rd, _dev_add_type_parent);
+}
+
+static int dev_get_type(const char *stype)
+{
+	if (strcasecmp(stype, "smi") == 0)
+		return RDMA_DEVICE_TYPE_SMI;
+
+	return -1;
+}
+
+static int dev_add_type(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		dev_help },
+		{ "parent",	dev_add_type_parent },
+		{ 0 }
+	};
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide a device type name.\n");
+		return -EINVAL;
+	}
+	rd->dev_type = dev_get_type(rd_argv(rd));
+	if (rd->dev_type <= 0) {
+		pr_err("Invalid device type %s\n", rd_argv(rd));
+		return -EINVAL;
+	}
+	rd_arg_inc(rd);
+	return rd_exec_cmd(rd, cmds, "parameter");
+}
+
+static int dev_add(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		dev_help },
+		{ "type",	dev_add_type },
+		{ 0 }
+	};
+
+	if (rd_no_arg(rd)) {
+		pr_err("Please provide a device name to add.\n");
+		return -EINVAL;
+	}
+	rd->dev_name = rd_argv(rd);
+	rd_arg_inc(rd);
+
+	return rd_exec_cmd(rd, cmds, "parameter");
+}
+
+static int _dev_del(struct rd *rd)
+{
+	uint32_t seq;
+
+	if (!rd_no_arg(rd)) {
+		pr_err("Unknown parameter %s\n", rd_argv(rd));
+		return -EINVAL;
+	}
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_DELDEV, &seq,
+		       (NLM_F_REQUEST | NLM_F_ACK));
+	mnl_attr_put_u32(rd->nlh, RDMA_NLDEV_ATTR_DEV_INDEX, rd->dev_idx);
+	return rd_sendrecv_msg(rd, seq);
+}
+
+static int dev_del(struct rd *rd)
+{
+	return rd_exec_require_dev(rd, _dev_del);
+}
+
 int cmd_dev(struct rd *rd)
 {
 	const struct rd_cmd cmds[] = {
 		{ NULL,		dev_show },
+		{ "add",	dev_add },
+		{ "delete",	dev_del },
 		{ "show",	dev_show },
 		{ "list",	dev_show },
 		{ "set",	dev_set },
diff --git a/rdma/rdma.h b/rdma/rdma.h
index df1852db..d224ec57 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -72,6 +72,8 @@ struct rd {
 	struct list_head filter_list;
 	char *link_name;
 	char *link_type;
+	char *dev_name;
+	int dev_type;
 };
 
 struct rd_cmd {
diff --git a/rdma/utils.c b/rdma/utils.c
index 0f41013a..4d3803b5 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -475,6 +475,8 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_DIM] = MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_RES_RAW] = MNL_TYPE_BINARY,
 	[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE] = MNL_TYPE_U8,
+	[RDMA_NLDEV_ATTR_DEV_TYPE] = MNL_TYPE_U8,
+	[RDMA_NLDEV_ATTR_PARENT_NAME] = MNL_TYPE_STRING,
 };
 
 static int rd_attr_check(const struct nlattr *attr, int *typep)
-- 
2.26.3


