Return-Path: <linux-rdma+bounces-8882-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C9AA6AEB5
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF6AC7AD7ED
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE322A4F3;
	Thu, 20 Mar 2025 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kThonj/E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444D2288D2;
	Thu, 20 Mar 2025 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499887; cv=fail; b=LcMDFBFfuBfbHYaf8d2uzbL7G403STGEcBlv4PpEBK4tlSQv732KF48c/pZVgZpIfqskoMIbtTo7dBldBcOuEnxOuzegp8XQcYJndks+D6crI/SfRAQDex+I7F7nGSbmJvq7bVw+TKrNEAV4tUNXkO56403gW5BSqmBnu36kdzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499887; c=relaxed/simple;
	bh=I7FKqGLVUWm71ENHgR9771lzDXvQTYAhJCUzSllQgNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXmk1F/CPOGDlGIQ8htM678GljKQ9o3LfL3UFUuLkq87POZdbAFSNkvGD7F+S651xcQ9lNCxB0aRKTbCWVUZeO6EkjQLj9tAOv0jn+GZgYIb1Mnla+r6T9rlUT2QXpBmPOdMZv9li2uNQr16SKOVAv3ZcZv18js/ANZm8nA/8G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kThonj/E; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue95DLArxPp0pfObkzyGOWjUXMsxbMhWG1xsERvv45Hi300roeDY5FsHx2jRPJ7sKOQRDOcdoQRqumL406xM8p8siz5wah5xc4czaB08YeQFYYXZmzcKCnNiE5Joplker77FoGXonG+o8uuQsG0i1u1OdDIroRcR38Ypg1A5a9T5IbuhS0a/U9neUMmhddGD+PTaBXJWF9vhwbQV0pO/xEYd9ZRvurLgSmsUlqCP6NSulEIObC/lSSRzYTmM/A5Hp4O+jM3t0g16vimMu2yGLmkCHchY0iHnPDpoynnFoWtSQiT49weTp8hsCKLliQlMlM7O3fM3yk5LP0Z7WWwvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Buh2JjXl8fE7wIFly8+U++NyVsGuTVAD9EhfkxZlZxI=;
 b=F4Q8w1aiRUr3NpCWXPz1zshWmqOBc4UXYiLkD2UjcZbXA/zufs99kkxs0/XF+4F79Kigj5UR1PPwpzPY2md8jfyaKb6w8R3Ciwn2pEJu7S13lEO+552qXAwdDCbBqSLMeP0O/XRd2t/JRIMPybaYfNiYMiVmTBpx3OP9U641IlcUT7CHPcgzrGWcjU3o/z7rb0A+sby/e5Z4e58bifBWtXkyDA75FThzz39lDFXA3ujX5bOK6dAj6KU6b0AuXXtG2EwM1aaoLuC21C0X9vMbsdUKRUWcIMmBeksL6hyNSliLgym5zvDIdqSCs+rDzWVBm7B9LPXHzWqV4aAheGWMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buh2JjXl8fE7wIFly8+U++NyVsGuTVAD9EhfkxZlZxI=;
 b=kThonj/ECWXp5eVeZc408Nf/TQmZ14oJ+kCeoupk/BxXfYwj02QArHnqdcfT8LMfBYjHz8vStH5atGvkMCz0lE99AUzd7ccURP2pa4I/fKXJyGtnbDyCtKwfKL5OHCHi/wo9jsbHmB8DM/zafli44EAPf5cWUB5bW8O3wRncSfI=
Received: from BN9PR03CA0944.namprd03.prod.outlook.com (2603:10b6:408:108::19)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 19:44:40 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::bd) by BN9PR03CA0944.outlook.office365.com
 (2603:10b6:408:108::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 19:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:44:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 14:44:37 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 6/6] pds_fwctl: add Documentation entries
Date: Thu, 20 Mar 2025 12:44:12 -0700
Message-ID: <20250320194412.67983-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250320194412.67983-1-shannon.nelson@amd.com>
References: <20250320194412.67983-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bf3507-d149-4e06-693d-08dd67e7a764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6OeViLWjXXRkKft2qLhfGxKUautkcJfUpnwv2RsYQsgsuBPX36wkpshQR1rX?=
 =?us-ascii?Q?2GtlpypUGKh22gsTyu2nToKZM9RsUyUb61iLDxBl0fFevOGyDqu4Ai3aiVXr?=
 =?us-ascii?Q?4WeuLouYbny9Lv3eWBgql513HYzBK/z14lbwqpf2ihlAew9wP72JlXUjdanN?=
 =?us-ascii?Q?OIheDeVnxcV0QsMG7sfjQRzeK4sEUz2YJ1rzEXIHEnsDG7vgJeOU1X9Qmy/Z?=
 =?us-ascii?Q?zb5eLa2yaCh34KCeritm0ko4KQkIWjtaKJWO/LTq6acM+2cxRxyJqGb58nY3?=
 =?us-ascii?Q?U7iP3zDAdDDoiacSyArakJs6Ig211MXXw/QWPmOb+su8D48X4mrRzDf1+MLj?=
 =?us-ascii?Q?ncz91jH3CUkLNiyAN/FbLMDC2EWSXNoNM+whn4+AY2lRHPe7cbGeh+z68kpO?=
 =?us-ascii?Q?N37N6mmMgBs40romX6PJ3PNhIP/w5Q6ev0DGtC9EABJCQq/aKUzLZLK0341c?=
 =?us-ascii?Q?nmfLlmyxrG1XoQeAJcDDflPYDTaeuGM2DD1uyh5+0OVnBgS2//2nxGbMARTQ?=
 =?us-ascii?Q?IMveOxDzQmbcDtysmSIIhEAhtMkIUZFToXzgwhXuamHLPuFIDVCDUJxjDNgn?=
 =?us-ascii?Q?j9dyE4vvkUm/qByB7MvLqXYLMfdY+jQx7lWHXKHTdGxGPpHZatt339clgeXY?=
 =?us-ascii?Q?Qhg396Yh5goHnp25q0acGIVDLeqlaixS0m2pNjlvQrWBUqLdblwZmTdN79FD?=
 =?us-ascii?Q?k30Nscr1LIhTMuOhI7LDf7hy+/kLqYyZNjM3p29Vic4lYgQl1uvAWJuy7kys?=
 =?us-ascii?Q?VElM5Zs8nM4fJXQehALCVgmU2hC5mpqxoXoKiHKv/KyZDBwgTJw4QtGGHZBd?=
 =?us-ascii?Q?ZV1VJGsvw0tDuzRduDP8HEdSL17ZUWKlAyappU90RALyLkLtMjrhAq4+uAgb?=
 =?us-ascii?Q?7FT4i7AazlwJury2MrQazbf31U217HnsY1DBgl2Gg+vQHve8o/nPfu0poK1F?=
 =?us-ascii?Q?oTMz0nHVqczQwqWo5B1Bm6IcZVhvc+0WbYZQN3LpOrLbaexJwidhcby3zfAA?=
 =?us-ascii?Q?znuBQiQL3RYF8kFi+GAUNg+NhGyeVYEOk2+SWz3ja6Nu7kF0v2Y1pBf+48pq?=
 =?us-ascii?Q?n0JQJgU31OyYLPGXUSp3EKY4dfeL337zPKp87UwJpdgn/wuQYmkp8emOifZf?=
 =?us-ascii?Q?MSdHP0V1sYZKbNEb6QW8xYA13w8nsZ/KkCWdWxRNEXym+cKOFC7d68RcRyAQ?=
 =?us-ascii?Q?TEKZ7QtBd5mo3GSPwIqd8I0BvIinQBDv46A9xkm9BhGyO7HDruGDkv2XnGMO?=
 =?us-ascii?Q?zEdEf3ojUQ9Ed7oc45pz+S8foLemkjAEVYqRqo04GK5/jNvtam6i12V5Dbcm?=
 =?us-ascii?Q?YjEdtIrN7oiOQh0K6EAe4TDfIGTE42tOZMLDwgRRWcIYolnWiN3PDSM36PZQ?=
 =?us-ascii?Q?3DNTGxFXOc4bL/FSmBxmMJP20ihHa4F8qVk3joAI4rA+U4uTkQut7AVy4UNB?=
 =?us-ascii?Q?5zjVvaYCLflsL7ICEMnGJ99cCqTUcYWnE50RUrFwAZxPABdGpVNtSNg8S1IQ?=
 =?us-ascii?Q?0yHVhySmARl2Jannwb7s23cJDDt77ZqZY82n?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:44:39.9647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bf3507-d149-4e06-693d-08dd67e7a764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943

Add pds_fwctl to the driver and fwctl documentation pages.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 .../userspace-api/fwctl/pds_fwctl.rst         | 46 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
index 04ad78a7cd48..fdcfe418a83f 100644
--- a/Documentation/userspace-api/fwctl/fwctl.rst
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
@@ -150,6 +150,7 @@ fwctl User API
 
 .. kernel-doc:: include/uapi/fwctl/fwctl.h
 .. kernel-doc:: include/uapi/fwctl/mlx5.h
+.. kernel-doc:: include/uapi/fwctl/pds.h
 
 sysfs Class
 -----------
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
index d9d40a468a31..316ac456ad3b 100644
--- a/Documentation/userspace-api/fwctl/index.rst
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -11,3 +11,4 @@ to securely construct and execute RPCs inside device firmware.
 
    fwctl
    fwctl-cxl
+   pds_fwctl
diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
new file mode 100644
index 000000000000..b5a31f82c883
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================
+fwctl pds driver
+================
+
+:Author: Shannon Nelson
+
+Overview
+========
+
+The PDS Core device makes a fwctl service available through an
+auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds to
+this device and registers itself with the fwctl subsystem.  The resulting
+userspace interface is used by an application that is a part of the
+AMD Pensando software package for the Distributed Service Card (DSC).
+
+The pds_fwctl driver has little knowledge of the firmware's internals.
+It only knows how to send commands through pds_core's message queue to the
+firmware for fwctl requests.  The set of fwctl operations available
+depends on the firmware in the DSC, and the userspace application
+version must match the firmware so that they can talk to each other.
+
+When a connection is created the pds_fwctl driver requests from the
+firmware a list of firmware object endpoints, and for each endpoint the
+driver requests a list of operations for that endpoint.
+
+Each operation description includes a firmware defined command attribute
+that maps to the FWCTL scope levels.  The driver translates those firmware
+values into the FWCTL scope values which can then be used for filtering the
+scoped user requests.
+
+pds_fwctl User API
+==================
+
+Each RPC request includes the target endpoint and the operation id, and in
+and out buffer lengths and pointers.  The driver verifies the existence
+of the requested endpoint and operations, then checks the request scope
+against the required scope of the operation.  The request is then put
+together with the request data and sent through pds_core's message queue
+to the firmware, and the results are returned to the caller.
+
+The RPC endpoints, operations, and buffer contents are defined by the
+particular firmware package in the device, which varies across the
+available product configurations.  The details are available in the
+specific product SDK documentation.
-- 
2.17.1


