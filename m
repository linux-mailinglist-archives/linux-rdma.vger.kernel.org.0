Return-Path: <linux-rdma+bounces-8220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF102A4A783
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A909E16E28A
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9BA195811;
	Sat,  1 Mar 2025 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KnRB0nBd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4719154BE0;
	Sat,  1 Mar 2025 01:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793035; cv=fail; b=IwxNS7IX/JDRpAqxalF6VOT/h0YIuLZC5MfXOfZnNO2YrQPbSfqk0KR/fBV7ivx9++ysZV5odo4cafcQmifzy4r17gv90G0cj90RyzbairPv21yPu8E//tb+nfFjYcdveTfSoLuo9vego94Co7VPllg9by/UkR2jK9Y68Uym8UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793035; c=relaxed/simple;
	bh=KjJ1lArG8cVwGGbFPGo2jQtIRdd3kTKxVRHUD2+Smug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/qwSKmgmbTaX2GpAUu3PaYz3v5WUQl4q0gST3+QXfQGD086MYQK0OiFAzDWwNS+nW6J28GK8agBnDXI9R+lvmyW3bey9uMinfL7TXTNpmCLBoJ6TMIhtubXO43KVh0Ve9ZH8jm/zdWYMSeLE512UJ3lwD9UBhLDR7eozLSS3Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KnRB0nBd; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7CP4seHzpmogvBWm5ClyobEJGk8ZWVHDPxabEKOC73fvje8R3r7Unt1lht5cGlNLYQKvEFIEKkqqgmhASrWkrSiE5mN8IjZoCcyP7IietcK8v49gt6pAD3ussKnyTTHzOXdXQjEAbaI07LQTGE7MpPPpDdVRaaU9d3P9RfBZnOw4Mi0YKoTbM2AZCvFO5An+qb7TE+mD/h/uJXjCIoHXS8q33IwtzIi70ZWoOqxxr+ivPRnCFZquX+wLKWsHWejIg5imfnxvPV+e8UiKPdyyJwknFG1qaFPzK+pYt8YEEF9UYQFxuJLcAYTSZwDqekVFUwuaQGar5Ymdt76zUFSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeBSIyHStw6Dg795Gj76pj9fWvSEaBUjalkfmMohgUY=;
 b=TS5KcflHgFl6Oc+JFWiXi1RIu2AqiwUydD7hFJyT751Ti5jXUbmScZLCKPtmjDWuYz4Rh9ANajy6FQgl09znblb4t/GTyE1kCKunGBpmlN7mjPHcYGps0Jm6B2zezGhCHszR3Ir1xJc11PvebtgEbH+A9/FO4/aaTuLJORWTUEDL1WJZJ0SQjLswmKL1lhZyFheZYtcPhCUgm8wdtjeaJ/jOvu5syDkqbxprmT5ZpWmF6Z+SIdy5w7w5xq1fDzNUIGSjqfJTAM0LHVsdW0jHMgl0eicViMUFjG/09Loek5X7AnwyTwMiSQNvfbaFF7y4Ecd9IPnfo0+mGqDuvyEv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeBSIyHStw6Dg795Gj76pj9fWvSEaBUjalkfmMohgUY=;
 b=KnRB0nBdM05On7Xhd7EX5pKh24S6qKiro5c1sJ80MX379IGzqse14v/2S7xkf3WGgvWq+T1Tx9M4JyGdHWORBrctEtcFYmJglQGrXbC3o5RK+o47GkcfK5bo5kq2wOqPqIWkkdHyuHbSB5txNnz8jCl6KIpAJ0t/Z6n4kiqI0wg=
Received: from BYAPR01CA0053.prod.exchangelabs.com (2603:10b6:a03:94::30) by
 DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sat, 1 Mar 2025 01:37:10 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::b9) by BYAPR01CA0053.outlook.office365.com
 (2603:10b6:a03:94::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Sat,
 1 Mar 2025 01:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:09 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:37:07 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 6/6] pds_fwctl: add Documentation entries
Date: Fri, 28 Feb 2025 17:35:54 -0800
Message-ID: <20250301013554.49511-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250301013554.49511-1-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec57954-7dc6-475f-a7c0-08dd5861959d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyG4CZjucrFmEQk+50jjgYmT0/BBoCXIlDjWADtNTkkP8Pp6Z8LhAfbs6i5K?=
 =?us-ascii?Q?OnWk9D8Oqp4tuIgF9FkEeeSdQ0BYF/DKcX9p8bGGPStXgSqsttN/oMmfqpER?=
 =?us-ascii?Q?iTrlYy8dYWnYjHD97UGqjmLbR8sBBStmE4fLQefV/gORFCevbQ0m4HHu04wU?=
 =?us-ascii?Q?M9drXaC1lARV4c86/NcxUARG9AYdxhQMiXRRnNO4/l2Tz65eBEZOXmFZou7t?=
 =?us-ascii?Q?1U3gjWXWVundOqZKOnnYgwN92rLFFSoTXNk2mJxD+CVdxQF4Il5xc3w02MgO?=
 =?us-ascii?Q?L4j1B+Tk1ANiTDpISkGNSbnttTqnNM2uJ96vkgyEuMYvSlZ7Lr7huIdJu+j1?=
 =?us-ascii?Q?CXSYrLSPYXm0Sj+CmYwqmHKHOMcR812EN46ytiBcbdU9Cagm4lQYDSo2Uhj3?=
 =?us-ascii?Q?VFV2wvi5D99VfN2BTUFWoOoA5y1pWIxnkJbGOPDI9gUY/hsdQKCq/glGZ0ye?=
 =?us-ascii?Q?dNCjReSbRw4LfVBPq0D1gZCdpZnxSCSON4In/yP8HmA47Rjies3aOhJF6iy8?=
 =?us-ascii?Q?jwnyBZqKy8t1xNoB+sZVFPdTDTci6hF7GbUCVHXWGpMl+pViHxLlqUtGqkuf?=
 =?us-ascii?Q?A1F29oij+SYdwK5lAMSK1otRYZXZT4VEUKSqelEp+mJMwfS4xYW+PiZH7ZIr?=
 =?us-ascii?Q?boMJsLR56qTlhHMfToRpKeTpc39U4jdteYXbrChIdNOMUMES/K1ISbU6A3xn?=
 =?us-ascii?Q?CitqTx15UHgBDuQl2+dCOAnbTnvp8/KlAPhHeaNPyRDddJi4LCOgB34lpkpK?=
 =?us-ascii?Q?J0G0hsnA+UqKSHRUMfliWYDmihi1Tai7iZho7EX3GkFMHevkmlLAVdOnH6Yt?=
 =?us-ascii?Q?Wh7ym98M7/fLYO4Hhn9nHasQEsQasqLFHkoCqBiaBmib7mfXYGS6qoyVYqf8?=
 =?us-ascii?Q?AGl1RIQUT+ucl04f/J0Po+kAkxtBHoeSj5SKrzMBEVJuNnQYd3+fystKgbfW?=
 =?us-ascii?Q?X4vxCG7tC0y2Ppq9keZ0LJupjlVf8rRb1Nh2t0f9aRZyca9C4JpqwRVfkUYZ?=
 =?us-ascii?Q?KnOXl210uyRlidywjhrm8Pp95wlhRXl459KaxPVUn4bNYtP5Ua92v1I2y676?=
 =?us-ascii?Q?+Gp7ZmNUC86ApDclEKFRMAuB3yPUti1s9Hdrdba76Djv/i4em4qNqDhC9IVc?=
 =?us-ascii?Q?f+nwyQo5F9Qv0IrvzSzhfM78cHV4hCGXBCgFWhE8stR/RqMKhl/Y3BD19cCh?=
 =?us-ascii?Q?rPau1vBVhJnVdchYpZl5IE3NbgHVLHfpCG+1sS+29mDn1APJB8ZYWZZw7Sdv?=
 =?us-ascii?Q?ElEqHZZA6HSI7SZ2xHcddG5q/esFjXvGQKN30lwDJr1azh+ModcBcuOlBgPP?=
 =?us-ascii?Q?ZoVNEYivDh/2O2u7toSUeBkhBVoje5JD8D0F19nRZvK+IOzAouv4R9oWh+vN?=
 =?us-ascii?Q?cDg4hWWfU167x1l7yMvn/WQMzxGmbqqXpaPS3wNN+1c9s0Cvf0m32Y0/f7wI?=
 =?us-ascii?Q?tUpsM1LgL9n8Hvn0tP2x4NmqEM8Q8KnfNod9EeWoSMkXp3CrO6GT/gsqW5JX?=
 =?us-ascii?Q?c47pvbm9SJWqAQ6LlJJUenKzcVoEfd3l45Bt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:09.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec57954-7dc6-475f-a7c0-08dd5861959d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

Add pds_fwctl to the driver and fwctl documentation pages.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 .../userspace-api/fwctl/pds_fwctl.rst         | 41 +++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
index 428f6f5bb9b4..72853b0d3dc8 100644
--- a/Documentation/userspace-api/fwctl/fwctl.rst
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
@@ -150,6 +150,7 @@ fwctl User API
 
 .. kernel-doc:: include/uapi/fwctl/fwctl.h
 .. kernel-doc:: include/uapi/fwctl/mlx5.h
+.. kernel-doc:: include/uapi/fwctl/pds.h
 
 sysfs Class
 -----------
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
index 06959fbf1547..12a559fcf1b2 100644
--- a/Documentation/userspace-api/fwctl/index.rst
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
    :maxdepth: 1
 
    fwctl
+   pds_fwctl
diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
new file mode 100644
index 000000000000..f34645dbf5ea
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
+auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds
+to this device and registers itself with the fwctl bus.  The resulting
+userspace interface is used by an application that is a part of the
+AMD/Pensando software package for the Distributed Service Card (DSC).
+
+The pds_fwctl driver has little knowledge of the firmware's internals,
+only knows how to send commands through pds_core's message queue to the
+firmware for fwctl requests.  The set of operations available through this
+interface depends on the firmware in the DSC, and the userspace application
+version must match the firmware so that they can talk to each other.
+
+This set of available operations is not known to the pds_fwctl driver.
+When a connection is created the pds_fwctl driver requests from the
+firmware list of endpoints and a list of operations for each endpoint.
+This list of operations includes a minimum scope level that the pds_fwctl
+driver can use for filtering privilege levels.
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


