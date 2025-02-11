Return-Path: <linux-rdma+bounces-7661-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD0A319E6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB5F3A8995
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E30E26F460;
	Tue, 11 Feb 2025 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDLV2c3f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC426B971;
	Tue, 11 Feb 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317766; cv=fail; b=NPrI32m65oDdvBbCHdOfOOrG8v7MIDmsWU0NgdftUlLU0sspIHbN0RKn/GOxKn9ec+YoGk/8S3DUYt1opMdkCkiHQbhtmZ+/n/GZtK3IEx1s9RqKxbqEQeEbKOLUmy8/TSfPqUe7Dv+AiefQJMqB54B834sHuup9LDCzC7plDP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317766; c=relaxed/simple;
	bh=3rXogz/wORLMze9KByC7imBV1rtKLLeTdH/jHdx3ubw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=me0Ig4GgpVAA/e0pwZZtpC36YqmIJpr4Ljf84Ja+11roz2pXQiPB2hhJlz+smqsflNQakZv3Gn5UqgShnEerN5fBqGHGnOva0+9IGOA1meXKW3fTNoq67pqXJPLHr8eu+iGfZoOHalgP7vvjG4eoEjxjJ+vDb2uaIQyl+dh+pRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDLV2c3f; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxu/6rYXOhjLgk10JjTt0QYAOqNpP+LzwAvbx0ujnIt8ahpno1Fkh90zGamDcLKjOEeZ2h80dzYpzr8xVLS3CPazwxrjHwAiHXaU2JSRqMNHMjW+S/ZtlPXQ6X94y0suHqcVe4M0EfEUd0nomnO17TvGmsWrYSXT6WprXzfDOatz9crMitYIcY4fDBnMXwNyIonTj1DgeZszLiTGSX5otLSJOpS0mI5uMRj05xK2fACpWCyqaO6MSQCD9jV/et0OPajz0nicVc4HydL/LYtLWWm+kzqvmscJ6MhBpATKT3ljZ9UiKp8bgMt+QxacSvoIVvoudhtp6RsREieWVUmUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3A612y5dAH2TQJRxuNdGtK7VQVtDIH8XnD+dV1qBc4=;
 b=TQSEfUTQOIZ+vlEQukUAaeshrOCsuIIJozaxlWZtSZbeXD6gM9abB9wa2VEB65iuxX/d0kYCxNV5T7hqCTScCdGPPGPRG4rWKdtOvrD7XrUxyruJ5EDSbKSdz7/j8TOf+OBpDiup724zetldlteegvwZQ95LtQvXu9kHMiauho0iRHIIS3WvLF/ApuS9wNdKHraLtGIGh86zCU9z5W9g80dW4Wc0H7nLLgHKU/vVYcxDgQI2Kn5/42JYeCRjwz5+Twwl9AVjhE+7+ZomdlpVG2WqCs225GP/zBamMYWgDOuE7TUOEfssksbbPbb3z1qB2HsZbyXHQdVraCriCBPSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3A612y5dAH2TQJRxuNdGtK7VQVtDIH8XnD+dV1qBc4=;
 b=uDLV2c3fb1/h2VjiBKXotmuR33f0BorNj6t4uteZaEkyfEzEaL9ENQHnG71WogWuGnKAiIHoXpQbGItHbxkyUrRgyPDKJqUXaMSVVcRpJ/sbn53NAxHJVDQTYwhpb2clRrYA6SYj7T5hMugZ27PAfT93xjqXg2ylye6mWBEtRqM=
Received: from MW4PR04CA0155.namprd04.prod.outlook.com (2603:10b6:303:85::10)
 by IA1PR12MB9522.namprd12.prod.outlook.com (2603:10b6:208:594::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 23:49:20 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::d4) by MW4PR04CA0155.outlook.office365.com
 (2603:10b6:303:85::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 23:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 23:49:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:17 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <saeedm@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH fwctl 5/5] pds_fwctl: add Documentation entries
Date: Tue, 11 Feb 2025 15:48:54 -0800
Message-ID: <20250211234854.52277-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211234854.52277-1-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|IA1PR12MB9522:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5e5ec9-f73c-43e6-53f9-08dd4af6b3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y1iAiTMKheJlvXT8I21WaR4IGo4Idjl/OgXhroWj+kqYvs/S03h7R75iE2Mm?=
 =?us-ascii?Q?WJCL+bDEXX+CBTYphoSWY1cPYZIWVAfyIpB2Qm402TI+CZ/VZ54W/8uAB+RY?=
 =?us-ascii?Q?j6Wl7ylBnfg6H/DkNQtNblp+76tWa9WN/UVzqpG2iI4dH/4rAL/j9EwOqVzg?=
 =?us-ascii?Q?bxr10w3ezBVXQt3VVkj6aCoAy0pWRUcZrE3Q3QYSCZKLcSFBK+bz6PB0Bd4C?=
 =?us-ascii?Q?5l3xt5F1QGfM1zSrHVUU+4PDXlO1sUE+5eDwbozXztc+Q4PYjylflCYCRHkD?=
 =?us-ascii?Q?Q1/8+kqkuL34PdFOBjjTtksp53G7nbyUVkPGjnaEtH8QTwEAd7nP7iPHO3J6?=
 =?us-ascii?Q?iolKwFa5jw+7FcVFJO+1j8FVbKPH+1im5gnZAsGhuS4j86/oywXgtlfHvV2v?=
 =?us-ascii?Q?2eDXCOApc54C67PPgKUQqJ8oCKsNpjZNcrPzkFa6DbH63lWSci8OxNvOqrO6?=
 =?us-ascii?Q?D1T6ROwtA4o3EpYLh9iYwLiWGWvuJJhGyuorbLcla6LIOD5Q1DIDMnzvJg8Z?=
 =?us-ascii?Q?sHVkWESnbOnrG58zoVTO3a2D/Bhk8nRgpoQ4n8NmWVOeyry+3m6MpfoXbn2+?=
 =?us-ascii?Q?o6CQzfbxHUecG2H4Zr/tKrsWf36g7bPKK+4BVL2NVzq7m7WXdYNSMxmpONoe?=
 =?us-ascii?Q?bnjDieeQiQc7NiFDKUoWXdTiGduFdJOH6NOTKu1STbOvvdrIhs/NNBnvtREN?=
 =?us-ascii?Q?/wEOJH+ZimNDQuSfrZPtvpXbpAYsdnLtnBq4n7kw1PJqKxLiJx6dZfgngn/d?=
 =?us-ascii?Q?+X9eqbTqv2/NuALLi1ZGeYMr+to9krTSqnH6yVCqh5gNBkaJhzEfb6wHzEGe?=
 =?us-ascii?Q?BpDLSFOZsptBkSeiDOzYXgYhozGs+udkSLjUSkfXZfViowT+DUA7qDDPlS6D?=
 =?us-ascii?Q?FINq4pSR0o+L4urnoQn5TXgglbrONGgzpxho2MzseVSBaPKR1k37JyhB6FcC?=
 =?us-ascii?Q?pusVXSXz6lNXHSjvb2Gh8tdVTjmxPwKbZJX18ixHFyg4wBYF9n38YFRUF0kl?=
 =?us-ascii?Q?MgjlEEMoT21GOFiaQ5XqoSjLv5fUPDGwdQ1ZspriXP/bvLIRy9J8SsbaCh8n?=
 =?us-ascii?Q?gfobocx2eADlvu3wR0VPZEzg2SfOr6Cfav/Gat790YEYe/V8v7AFt/yv444g?=
 =?us-ascii?Q?bFGYM07/ljbJ1qLccniABBciZpEwD8vfkeRQMy8cZr5/BdyVxjIxa62Fxfi4?=
 =?us-ascii?Q?eP/22BFgchwigC/V2QW0X1REP/Raxr+Scrv6a+boJKYfjPL52jwWnWEIqDFn?=
 =?us-ascii?Q?lipf92VrfrMdwoOG7Y7MCey1FveZMA4k/MsFRt0nzdOQeNaj962iXVMWiyfB?=
 =?us-ascii?Q?/F0W/qp1zM89wv8BCies/scK08+enFJts+UScU6RTVQVC0Id6iAYxB0phIWq?=
 =?us-ascii?Q?stp7AHM/PVI0UiJbLT33qvrF7QfUsXLe4p0asypt0vXryg8y9KSn8akB/CXS?=
 =?us-ascii?Q?zRq89tTxP1znwtkfZ/Rl4bF0rsGqIuzmglMSsLxqxXtAe+ykgzPiZxEXse3w?=
 =?us-ascii?Q?FNLH+6NdU7pCaO/gaRoBsBC7f+Orh1Ne5tNH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:49:19.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5e5ec9-f73c-43e6-53f9-08dd4af6b3ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9522

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
index 000000000000..9fb1b4ac0a5e
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
@@ -0,0 +1,41 @@
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
+only knows how to send adminq commands for fwctl requests.  The set of
+operations available through this interface depends on the firmware in
+the DSC, and the userspace application version must match the firmware
+so that they can talk to each other.
+
+This set of available operations is not known to the pds_fwctl driver.
+When a connection is created the pds_fwctl driver requests from the
+firmware list of endpoints and a list of operations for each endpoint.
+This list of operations includes a minumum scope level that the pds_fwctl
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
+against the required scope of the operation.  The adminq request is then
+put together with the request data and sent to the firmware, and the
+results are returned to the caller.
+
-- 
2.17.1


