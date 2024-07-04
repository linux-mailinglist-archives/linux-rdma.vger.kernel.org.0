Return-Path: <linux-rdma+bounces-3641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0FB926F99
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 08:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC7EB236C0
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A021A073A;
	Thu,  4 Jul 2024 06:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgYT/87M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC131A01DE
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074584; cv=fail; b=DPJL9zMHLaN8z8aP7rYXrKFPvqdEBSjrKrbcXYpYncdnNT0+ZfY6j+uqXNWF3eEtu1VRt9xkg2aP7b1rP3eLcsHy3C2eKFb9Dv7lpqJ38hS4Go4PQneWOi3lw3OOIeQz+rPsLV1aTuf6zi7Hgktj7j6SZuitPlNMNmJxJ1an/1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074584; c=relaxed/simple;
	bh=wazHNU1T/NB/J7gRI62CjynA2FMRdUeGfJXWlDz7/a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgIx2MMS0l6SI6sca/e6RJCX+b+W1zVDx+zxZ3y+MBwrEVhVA575frS0SwZ9duYK5czvQ968yga6bqKkQa/WzYDUQQrvtTaMktUQnS6xOjI/dffgqq/JSfEO84AYkyBiYvSEHgo3snb70hiSXrCAeJ4DsWUjJczO8XzvutsQOcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tgYT/87M; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToIMTENBQLKVnCbzvsaFZ3l1LO9siF+w19h14B2YaeQCBZXs8Vtk6I7wB7dJIqXarlysALgc7gG0XoJR4T2OLZoC3+2gMvUWY+A3yakSFmCBQBbxEvSanRzrhnY1nWPLvWnvhHnk5Z9zg/0ptyf64/2oR4UcDDtM0ekB0nuPq4L4Xc93W0xJrkVhFzsIE3TFcaAHgCkZg2MrRTnZkwDFqiEgJKFMb4bCQUV1RLExJcYL0nkRKpoBWKN+K0Z6zm7PnWrwb6EmsUik7ypDpuhJhw7wWczlouQrGk1dpuYHOtjlpoTriBZaVo7RFNZ+tScrtmNm9HwisFXjVClkDSpZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgNEUjDT0FdRmHKi2iGBeji+HDl+yTNZen139/uiz3I=;
 b=F56V29KobhnE6NmXmPabAxMmolNcPa3MBOV637mlEF5JvqmGbyMVvFOLLCK0mBfGajB6yiHrTqVijUcPzrnChDGqVc4s7+y7p6YYSogQ5hU6vFT/JtC6zwxUKGnd7rbejceq3uTEZnS2wTFzhVNKvH/ZBGJGUzx5tVuM7zK1XJvgy3AElW/0W0NMmWSmihrmChbvkvpJfCiFdDcVk2+dWUtoWRKtE7wBenWB82wRqNTY2+5qoJ1jcalZHI7lFfUSEqGThWJ7PxdbgBd+fuuxxFWSn/RTwYCUIjuUT6z+NIyPxNKyCVJE6XSf//z/aG9imkvjF00Jj4cNBEzBe7KGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgNEUjDT0FdRmHKi2iGBeji+HDl+yTNZen139/uiz3I=;
 b=tgYT/87MEKI+wMvw6hIkNCtX/eYpXTiLsMIu3CN+bXvYgvcaLit75H6Wcn1iHLlZEL44MfsmB5tbQFP0G1gdSKe6znxXpbmr/nuuoSZcargXHOlvleYdGVZuSvwYI8t1F1d0VRzgGH6+B7fY/WRojQEWhOgq5x0JIaqUvycpDr+gRHkpVTJe5JOo9u61W+pvbbZmwCVsiQHTrPhEMgsCIgKQwjlNwz1ondkyY2hwoFduAoVYoYJDeX4gK+UWN3BkryQeHzJDxmPPjNQvA2rlWLVmA8mIqR749XDtfTZ+eMmqDpdWAhbvnV/F+JEX9awbiZkmw22Ylyx6bCB1YIm4GA==
Received: from SA1P222CA0139.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::25)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 06:29:39 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::9d) by SA1P222CA0139.outlook.office365.com
 (2603:10b6:806:3c2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28 via Frontend
 Transport; Thu, 4 Jul 2024 06:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 06:29:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 23:29:22 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 23:29:21 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 3 Jul
 2024 23:29:20 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [RFC RESEND iproute2-next 2/2] rdma: Supports to add/delete a device with type SMI
Date: Thu, 4 Jul 2024 09:29:01 +0300
Message-ID: <20240704062901.1906597-3-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20240704062901.1906597-1-markzhang@nvidia.com>
References: <20240704062901.1906597-1-markzhang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5da726-b4b5-469d-4af5-08dc9bf2ae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/HGd+uxmSp7vnsUD2dhnxE3Pq1P+4td2vJG2QvalGEaSxvWZs146u51wLNZ?=
 =?us-ascii?Q?Rgbw9pKkPWE/ei7aOb4zkr0VkdJRrv6Nsw3GddwcFG51WXIRfzH/U+VNwB7q?=
 =?us-ascii?Q?Qyrj0Zo0/JoL6SmmQE5KjZJs360c55Ul5j4QpsfqTG1dXLlrbSilmwOUaEFj?=
 =?us-ascii?Q?1Yk9z2iil7oaScc+tw+RvwY6RgIxMkk2dE1OKunNGQzvcnkIrEvko45Kno1m?=
 =?us-ascii?Q?2O17ONEEGVBqVPuH3iqn8FtGKGsSapj3L+7lRlNbd2bc3wIc+cB/o0vrPTt7?=
 =?us-ascii?Q?t78sx9kbDFO/JCTZZkTmcsz5CVMa7SYUTWITNCZYsOJcBtuN5amqIB6D1F3i?=
 =?us-ascii?Q?mRxG99yIpwLXRWcwpBDGIdQBrNzgQz/2n4WaBnBNsJ6m8LcWWCWBtMMrjhQJ?=
 =?us-ascii?Q?hJcOFEfI5fnL1dw5T4THZz0VX6ub+RcVgRefaWwmQrqzp++TPPPnM+yMsDId?=
 =?us-ascii?Q?TqRwpwAFALrJntoZhgQrW61mB7X+ENYzG8yp61pJXcEktzRTbGYjrD3BtT3p?=
 =?us-ascii?Q?XYqehylDWHAf46HmQ4CXP2eT/gw087IrBiSk2gVCzgLJIMIIDhzgfRagKkTM?=
 =?us-ascii?Q?GdkSwTHoGQpq7s5ZyVU6fUanduDiMFMGw1O9HRfZgs1VM+EgMBUAgqHPXWNT?=
 =?us-ascii?Q?73mtX2SBxllyHNrg7+td+7rEXYadWroj7InqvCVkq0Azx/+kXSYH3WwrJ4mc?=
 =?us-ascii?Q?0BFO/Cn4Au+N3Q4xiljTQC4/UEnRlYoMgg7IfP38vTEJkeYcr9wSZiegETgb?=
 =?us-ascii?Q?QPAZ9rNTAOsESkDL+GGgmm7XqJ6vvkcnCUuDmiA6SSN/fhzTiM+KYHGqrLfw?=
 =?us-ascii?Q?XOqqngMRR/aitQGoGUd9pWTVvr1C7oedHXb3bEwtFWDHiiQ7/L9GaJIWG1/Y?=
 =?us-ascii?Q?UwJCmir/2UmosSl7PP9txPm47ZKy3u8+/ul/NGAMIgxf93Ymp7S5k+LUrU0/?=
 =?us-ascii?Q?s4CgVB8SWOSmi6QnRpTUef25/4Wupliv1xgPcG77Jzi0npwqOeLs7JrCx+Xk?=
 =?us-ascii?Q?o92H5rE27yg7WAOvQl1Tsyqe1sG4qy2lEIBioebi8tG6p5p3bDFFW+IvQAjo?=
 =?us-ascii?Q?yfoFMKdVOTm/xATNIFW6amTYMfJp5rL4Olfynx9aztTjMOtxNH2qwKhpdS3Q?=
 =?us-ascii?Q?kqiGQ5IFcaaljmcDbKtWXlFJoqSIBxTPWP4Xm7c24m72MZXEm19LMK6SSU9W?=
 =?us-ascii?Q?ljlmyPB7L+QlkZnxvWMHgngNJRFa1CwJ4XnCjb4XFv2jq+lxcgq8gp80Ljip?=
 =?us-ascii?Q?WwDLJZ5NpUJhWbXodkF0Tck9XzZantd5E4aIopNt0yULRY3QbSSIKy0FaR/7?=
 =?us-ascii?Q?9FoNWFBceqIWGXsFszKoq5vcoDddgnyGzRvb/naEydd0cTA1IoD6umecdt4N?=
 =?us-ascii?Q?166G+yZym8jxFHGI6pkPktbBIlZcPYGXhIf6r3OmgbhmSIy2Jc8sGYMBqHUI?=
 =?us-ascii?Q?cGzGPV2XdlIQzZ8WFpzEzwrHOVudyOQf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 06:29:38.9806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5da726-b4b5-469d-4af5-08dc9bf2ae77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782

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


