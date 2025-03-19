Return-Path: <linux-rdma+bounces-8851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0084A69AEF
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 22:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A221897E6E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8D21C178;
	Wed, 19 Mar 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UNylvA1A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0D321B9DF;
	Wed, 19 Mar 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419991; cv=fail; b=iXMT9tYmU2nhnC3B9KEksfVL1jUkgNNheCettTC34SenxWOfZUyRhCLMLfMBscGQt+yddKoZ/Q7eiy5L5HV/WuD3GEXSVSjq2DZUPmHZY9dxvmJUKoXNBkP6JPa4c9S6ohlPhJY9woqQ93PC6iMSfaFJ4nZzMA748XqCwheB7PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419991; c=relaxed/simple;
	bh=g0Luo8zaYjKqX2gsxywM8Yk7U2zl4Ttp8ccn8vYoM1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9M8okaystOUjFZBFYi9/6wQGEVPg22iBmfGkecx+E0R0qAPQ6AT9Rnfhyj4zJpAYjUdmzpD1gsjhZSjwVOctMlZIHqPvsrxmxf+oNIjvBi2mt1Fwm6LlkoXmPzYio/Pg2wJend0sJuM4jsrOptJxFVbzDavOgaCSUHLWWaMnDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UNylvA1A; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/t5V8L9P47ZzdK10curRHUs7ZVpdxEbh/oZYkXKjunYHIkqAKy2G86IwL7/8s9CAPYRxwj+l6eza/y/NLuAIZT4dp+yGFk9iLJ4LwayIrnbc37+wP98ku/lQviFIc65xwHANXaajBtpnX3GCUWOnHJkPKeUVVHhvVNPGK3hVWxzN1vz+CVKq4WR06h4+EoWCxKb3b0FzynPl4AhX7fbU5i6BnZNYuVn32PFmCje+ktm7sJd4sipXz7pfwBLMlJSZZW36VWDmYzTn5JWOJct18z20og8954F/WlaHqREtrs0ceNMY0JrxGvVDeeKhZwbJr3R5Mkz7Ug9uvYUrxs3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG5ufIbuDBQIhKZ8CIO8JjDuhmXdpx1UBDhOQpk9/3k=;
 b=ZZlqHIOQO+2E1p0PUFXLfqTkNsDk2uxiki4tNo+mbLJTmkyzYoZm/amepeHcGE+xQJlFvk0o0Y+i4WpG16KLFDO1bT2ttreeC7kT0TWStMHKQlBE982o7DYV8jW/9eu9OIuRjkPPAqRXTAzm7kQISYqiehuOtPVvLFMWBLcpHDD9rMCvoRyWEKSN2wVDIRSMutnzVj1KRCq1rnRvaGP5Jh3QJcITMo5KErgHKPSPs+61hnW7/29fMu0lgMVAW9DdbaUFm4ikg2a+WEuB2DoY0+m8YaYm6osidU0Kq5rOx1PKVozGrUwHKH87UQp74w+nijTqxNueEBkPjnAwWbxMWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG5ufIbuDBQIhKZ8CIO8JjDuhmXdpx1UBDhOQpk9/3k=;
 b=UNylvA1AnhSQlUnnQejMQ2eYEltGHS9oW984PCbxSiEUTaOZ5X3Owk7fZPyfIZAYhemanhVm5hFXfuH+ejNwrC4PcJrx6qCxZPFIbvEPNc/UQl0tKgMEo8zkzqfdnC0QtWZ9xg6LGIQMbtKZGurl9dN0NFN4p90Y3nC8HLJ7rKc=
Received: from PH0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::30)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 21:33:04 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::3) by PH0P220CA0030.outlook.office365.com
 (2603:10b6:510:d3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 21:33:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 21:33:03 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 16:33:01 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 6/6] pds_fwctl: add Documentation entries
Date: Wed, 19 Mar 2025 14:32:37 -0700
Message-ID: <20250319213237.63463-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319213237.63463-1-shannon.nelson@amd.com>
References: <20250319213237.63463-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: bd681626-f3b1-4801-8655-08dd672da18c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbEeyw39cjK/Ld6cYdMfXKW2VGQz2Yri0XFRsirtSZCHe9aah+Kzwes99UFQ?=
 =?us-ascii?Q?z86zSuT1EKYSdqdTpS94A8r0QO+uGE9ZF7MpXu2jWgNVuyAMXUxcSAhopv5P?=
 =?us-ascii?Q?7T222A3loHltLOeTU0pXAz0HWW2enPuBIi5p8DcIp+ZEn81pB8yPMepa7zOR?=
 =?us-ascii?Q?/q17fw5/pJIOCg7PTIuUVnSImVjMhfvJ48h5fuChne5GOro6cw5ypDqOufoH?=
 =?us-ascii?Q?eDF5s8a3RVwjihshrAlktyKFcLB6nCGe+Jk5U0nFh2LBb2Li8wvlYUy5dxeK?=
 =?us-ascii?Q?t5SwCkAnLdYsi0m2VeOsugmcYbAWzcWqoBSnU+8E32yk3PD84+MIq65qf+6B?=
 =?us-ascii?Q?P1a7hCqr1hWBXnG92+An0+ssXgxMqaXYio3oG/MTKlq5FXQ76P4W/93Lc8GF?=
 =?us-ascii?Q?1EoTrYdp4o14xQYpU9ZENToSZdmfJa1hdompbuHMNnHoqv0P7n7uHUq0DPko?=
 =?us-ascii?Q?5rNuRvxEAt6hws7i3Lc6fm1C817vExq22+mfTFMLNpDp5Ux1lkA/g+60gRGF?=
 =?us-ascii?Q?+Y83IYBp4YSC5SEkqRquHr22EeD7HFIJC6LBHYhgL9A6Z2sAeExOplPi6tfg?=
 =?us-ascii?Q?BTnPzTfo97/GreE3kcAdA3TPXjF2EJKE6rIAzVK+MSXMxANGsC5DpPiXNJOq?=
 =?us-ascii?Q?3eBuuwYeqB77l16AhdUJxa3V4+kUUkTRXBFkdH/qfgCYVTne1Y1GZ/mH9rgX?=
 =?us-ascii?Q?jE4WaYpx7pd/B3QH4nZWEZed/tsdVgHDNI92SssHN2HzoD7kvbNbs3U/9D4w?=
 =?us-ascii?Q?q/QZuumLGednOBadgAQm5sUHCT2XV7ZN5tHOXyBMqCcZ5j4UBrYFEdciWj9w?=
 =?us-ascii?Q?aKvtqqiEk+J77EhYQ2z1AgIJSQbXzmiNkZkrEDUD/tsRKVWKcB+PaTFcvnKD?=
 =?us-ascii?Q?jT6xvQ2P3qmhZbW9j1QPaeZq/KEboFrPiRcKZMUxUoMu0uiWGTx59fsvQbBM?=
 =?us-ascii?Q?+64FhiOgTcleFG/X/PVezQDkEiAEMQFsLYd1ZYqP0wgnjP1i59C9Wzm5M0Fi?=
 =?us-ascii?Q?7tXfoYBSu1T4h3Z0kqiuOPsILrMub0uFkawDaF/z9GpC1fLuKfjgDt7MF2KY?=
 =?us-ascii?Q?nCwyUpzvmuvSiVf2OW3M8IdYtQj1FUEkW53WIkgR8b7YW7UF1RfMIZqnb9AN?=
 =?us-ascii?Q?YWwyJ8MurzVJ9lss9EUltQhXTifjrd+UxDKos/GRz5JdFQ8ftWBkCUIUll7i?=
 =?us-ascii?Q?n4OKNLk9oFqfy2meIuKRWiZ/YFbus5woWVgO/5d3SeUw7bux9idG6bP3mGI7?=
 =?us-ascii?Q?kVDnq1Lx695r+jZwob0+qQSDqtt0nO07uHSWjLsP2fU3yX0Iw9Xg9D+wMEiE?=
 =?us-ascii?Q?qfcPFKZIxgwJbWckvwYbYK2eCcKo6hgP5RFtXUcpdZEEiN48a2D4q7yJAJph?=
 =?us-ascii?Q?fSxsFaT7aokGVvMJhMAqdqrWjQghjDftb8WjAnBWCJ/K41S+lAfKAz6wwhQW?=
 =?us-ascii?Q?o1wzVq8l6txNhmRHox2CSRCIL/sSn5rR/1ZJHqrlmD5EAwZLGLuIR/bO9J8c?=
 =?us-ascii?Q?KcXJ6p0y2F8k4DrPzG3N0TbtybwanNtDPwUe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 21:33:03.6602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd681626-f3b1-4801-8655-08dd672da18c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822

Add pds_fwctl to the driver and fwctl documentation pages.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
 Documentation/userspace-api/fwctl/index.rst   |  1 +
 .../userspace-api/fwctl/pds_fwctl.rst         | 48 +++++++++++++++++++
 3 files changed, 50 insertions(+)
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
index 000000000000..a8f5a457ba0f
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
@@ -0,0 +1,48 @@
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
+.. kernel-doc:: include/uapi/fwctl/pds.h
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


