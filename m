Return-Path: <linux-rdma+bounces-8486-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388D6A570E1
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A81798E7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006C324EAA8;
	Fri,  7 Mar 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NIZfygb/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCE2459F2;
	Fri,  7 Mar 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373649; cv=fail; b=OYQzCH2koT9SJsG9WB3yCqKjun5K0nWlGrPWctZ8HZCEq1ijgs0pOKe7NfyQZ+kNFxgIQ72PMaHTX8l8RZZqq031bjhNlKa9ZXRpTQYp93E9VCdsMZhoNHy4FM6O1wKjBjpU9U1EzecfPTrtYGmTxJBo6le1wkEYsCMlSot7gOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373649; c=relaxed/simple;
	bh=ferGZOFIzROlDqsM4T8DoNTuaoD2QtOi98i1X4igXRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mk89ovwPImDudvE/+7cU5csDrVBWDKeUZaUQ7eUh2UKdXcV/3ksYaWu4ZidHkCKzlnlxZpC1PEHQlq2pHZAHvmRYoG9yUeotnyHbymkLgYK/nIDC5oKa6D+lmp31VroM0fBEEfKvBsW5C1ey8vuHNRsESRvZcl/un55CRa8oR7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NIZfygb/; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjJiYILfSpDEvB44yD/p0IlxGCAsfC84SdFr3J9Sjl/EQaHSR+2U5+AjpkfNOrI/lG0hkgA38w2Q8nL2Pl5jUG0YJXLRCm3DJ1JsnGrFrU/ctlfkps6tpuPRMrQPZkYn+usLYlVAqqRhyIcA+A8BkPeUcFMmk2ztiYekHt7YCe7zyo8zIxVJ86/GlY8gBvI7SIM3SbmxSXN27bqIc2gYuoMrsch3kTaHMTleldTAe7If2XPsdMbYd6va5XDwvRJLIjiYrl2yc9gFmheM552UUbdc5lh8s4/PO/dClD2qrYfIAiflLhl5xZI8gsPNp9dmf0lOPR1/q9fs+hADv0Wddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INGQmnv/tOOC5h2niJkDo/1Qd7JfssPJEhAPQIOD24o=;
 b=irgm+edFwjzr+K8lzxTUaGxUWeDphThfsvbt66N9o7Gx9LyDt4BWAksPGn9bsKY0HFGN8Q5bm/EbMT8y/cr5t7iw+QI7cwxDnRZJ6r8Xoo6ykOh2riWrPrvqiMKnhTbL9zfGf2nSW0kGIrjB5Jn0+PLyxZuP0Jkn0DBP2pCe6Y2s5KLUIQGUt2xOhs81exHAHYzdkObxFNM7rZxHOy820DsTSAxnBNP0BggW2PFGd1J1ps8IXKjk47yOv9eYHfGQ7x8Ajgqlr/MTCeN7baPDl5VUuoBPrMXH3cwY1Cx8hokfn2RsBeXGMY4+OxuuKpxqE6CHCX9lyrCOEPs9TVa/rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INGQmnv/tOOC5h2niJkDo/1Qd7JfssPJEhAPQIOD24o=;
 b=NIZfygb/uKI8A9p4coQhTb/7IJkaXMvr6I7PLRo+L8Pb0gwzcfQqvXjo2TiSmGQq+8NAoASx3U6DIhhi3BIg8rZ9pwWKqGmR8br2MOoNSYrCuIOVZBAyUiRpvO5s62C6S7ODUxCF7zxEnCIpnXhz++rM/Rf2n4d0mReTdKCYz9o=
Received: from BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 18:54:02 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::da) by BL1PR13CA0329.outlook.office365.com
 (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.11 via Frontend Transport; Fri,
 7 Mar 2025 18:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:54:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:59 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 6/6] pds_fwctl: add Documentation entries
Date: Fri, 7 Mar 2025 10:53:29 -0800
Message-ID: <20250307185329.35034-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250307185329.35034-1-shannon.nelson@amd.com>
References: <20250307185329.35034-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: bc101b5f-48ca-4c48-a7ce-08dd5da96d84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZyZH3rYIwbjK+vxohH+NcrDC5fC8Ck12Pno0WPIsXema811U9tMpdSj3mi7l?=
 =?us-ascii?Q?xOKexGmqIlvZVfhv8ZeUXy8zo3s06OLSK5Na/xTDRL5f1zxpG+sPXlNXHtEx?=
 =?us-ascii?Q?JBdut4ZeUThJ/Y9R/2bKYcMnnQdELRhvA7AA3Gda7m/VN5GMhQeHO5Ilwdbp?=
 =?us-ascii?Q?TAanEDSUnaKyQjwxgMCChDVqyQVvTdwT8wZUeDPLQvLRNngUmg8WsW80icYL?=
 =?us-ascii?Q?xeGdF/Xxwe0Mhi+NxajloJGfj+fR6Kge6xKuTFQPAn+oztCwL3XUhmJ5xYgl?=
 =?us-ascii?Q?nNzP/RLQUBXP6oqfUMhrqKXZmOJiUyWfiQRWyHvn6+W8jGHfWjBYktDtSM7T?=
 =?us-ascii?Q?0mArkM00ee/p7y8/v9uii5Ji9UR5D4Jt3bJC/FmnVR0p0dT8Fo6ZxHLSAbWq?=
 =?us-ascii?Q?ULj0ROE+hHvbFXLo5Pu/Es09wvZAPgZjwjqFj7J6pHCXibiMuo7Z1f70FgQV?=
 =?us-ascii?Q?NIex7U5W3oXmCBWawrEktnWntn1NiVkGUTNzCbRV4C4hgzi7hVarq8zvcQl2?=
 =?us-ascii?Q?LHNp7YqrW20EItl5cexoyWvTcuSeqk5ry4O/9cnkKKgUOCIvSLKcWjX0oAp4?=
 =?us-ascii?Q?tOGTImNF4DnofWD+rtnLXnxIPcIYx389zcJKUBEUs/87RhvyNjM0+Vkxb52o?=
 =?us-ascii?Q?hZDXGddEfJfpNpnds9KAdUWlRU8JCdCdLdJa0a5h+gyo1TU0NxTPf7VwCWql?=
 =?us-ascii?Q?yPeupfTwUpjplogk+tY+bIBkWc2Z9bG/4OkDfOXSUbGZYLx9anFfOi8j/kbc?=
 =?us-ascii?Q?zPY163Ymo9/VW1DhfVLQWHjSQfeme/9E0+Xmt+4CcFIoG7oe4Hi+fGjIPFo+?=
 =?us-ascii?Q?wURGs/mZjswdUxKXw7u0XMIt3P9LIMkXSjXXXlcn06qZofvz4aLLi50lmFJq?=
 =?us-ascii?Q?AoXQ0RL/PyHyibjjWhKLAgDbcy6DcJ20X1S/prKl9lfm4VPVT8+MlxG0BS8n?=
 =?us-ascii?Q?gRVYPkL0WcGnrdkT1O+L1xE26AvW8+weMQ3J1VrND31KGrSd3AP7EDFCg3Eg?=
 =?us-ascii?Q?R/g9l0yxVkot/3D9+0gvLQOJKK/CLlJth3oOAr2MtDpKHHmHdr2nS4dmyKz2?=
 =?us-ascii?Q?0Ttml2baUoIgrWHmUaTXlVwx8xVftxhjVbXk6mFxBIaGUJwUDCT7PqW5G82j?=
 =?us-ascii?Q?ZGRwBBMoh0Axk/kVb3USFm7OzkaWxoR/sjCUZQxSiHJd9J8IjP4sdeGrglb4?=
 =?us-ascii?Q?ZBAl4p67RItJV/lvFsMOjvf6k9yuhduj+537Elv3N3Xd1jR75Yh3ZQf9Il+j?=
 =?us-ascii?Q?K6j62EPgaWEPf7VPSNiWIK+E0uxQXS3xturw/JtFmQ8BujgWPRkEklL0mOn7?=
 =?us-ascii?Q?P9T399gHIv5n8XNVmf2oBa7yYVBBiBHlBmSmXiC5zvPMOp6/2iwYxa9EkeMV?=
 =?us-ascii?Q?A2LYcdhDEPZZJ+jH0ziMa7tmkG1BJs4HKTF5Sw2N7QeovU7s8V1C0viPAmBr?=
 =?us-ascii?Q?WVASod+W+Ig4a0DhV3xFORdkV7fPhak/aEGaiJMQQXYGD5sElm7/N4xyqjo3?=
 =?us-ascii?Q?icJFH80J0vyz1gkCi7FnP3zyTYHDchmQ5ysT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:54:02.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc101b5f-48ca-4c48-a7ce-08dd5da96d84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

Add pds_fwctl to the driver and fwctl documentation pages.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 .../userspace-api/fwctl/pds_fwctl.rst         | 40 +++++++++++++++++++
 3 files changed, 42 insertions(+)
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
index 000000000000..e8a63d4215d0
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
@@ -0,0 +1,40 @@
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
+The PDS Core device makes an fwctl service available through an
+auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds to
+this device and registers itself with the fwctl subsystem.  The resulting
+userspace interface is used by an application that is a part of the
+AMD/Pensando software package for the Distributed Service Card (DSC).
+
+The pds_fwctl driver has little knowledge of the firmware's internals,
+only knows how to send commands through pds_core's message queue to the
+firmware for fwctl requests.  The set of fwctl operations available
+depends on the firmware in the DSC, and the userspace application
+version must match the firmware so that they can talk to each other.
+
+When a connection is created the pds_fwctl driver requests from the
+firmware a list of firmware object endpoints, and for each endpoint the
+driver requests a list of operations for the endpoint.  Each operation
+description includes a minimum scope level that the pds_fwctl driver can
+use for filtering privilege levels.
+
+pds_fwctl User API
+==================
+
+.. kernel-doc:: include/uapi/fwctl/pds.h
+
+Each RPC request includes the target endpoint and the operation id, and in
+and out buffer lengths and pointers.  The driver verifies the existence
+of the requested endpoint and operations, then checks the current scope
+against the required scope of the operation.  The request is then put
+together with the request data and sent through pds_core's message queue
+to the firmware, and the results are returned to the caller.
-- 
2.17.1


