Return-Path: <linux-rdma+bounces-9730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B64A98798
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C69F1B66B28
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46D278E5D;
	Wed, 23 Apr 2025 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YClNIcU3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787526C3A6;
	Wed, 23 Apr 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404351; cv=fail; b=bseN+tRndr9Pna0PovaTx0vWLcfPjmMEUQ2qnqPzkWZRffcM90XNy0s7YK/i6UaLk0U2G9cnTxWYV+j1X6AeErl0dpiqFsx7lLCGldQlM7AhsbfGITNQ+b55ZTORLmWJMOLj1QEbu0OdZcEyhjuTudguLuOJJ17xJLSCCGnxg44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404351; c=relaxed/simple;
	bh=qFXxzj1wSIv0dUTpeodhNPDQUa5MmWSI4zNDTxic1uY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOCMOb8vt4yZJQBXgDyYgPcjgHETv8il6jVQBU6tbkQuxVZ5830KiFI8VwErRHDxGbCmbPgRntnpLg1tCFazClvLKDQsd4/EkwPdmIvHCFOY0R3VtsAPmng/DB8HWnx1K5OU4CWJtDiGbBpZz3uklrHDPcIrxc3FR8EqwilFWBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YClNIcU3; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBmzwGQMyHE/ErHJUXgz1ACabZq8jrl6QIIXOpyMq6PHQ9gzq8ofNDQEfhH0t71RvOP2OxO1lUemSsteRwKepYqIhTzVX9m34ymvYVy9lHHEmpRvy9nwLgNHcOtsEO3u7rOISeF8ZssctKb/lxRCELf+VLzu8g0Us0HyKxvcg0055fAuPtlDrlhbs0NZm6uYer3lmF5pETmpIdRVk6tVX8jqQtpVfy6tfhtfVvhc5aYZjGqWvqmtJ07D7djZsH3r3fusDqeiKTpsNUZsKHigoTB5UJeHE9gYm1JeUsloG7LVdw8X4tJ1A0ceL9J4dWcDe/hX2duPNFf2N/MrtHodcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDfs5+dicFbMEZ+n16V4zDkx0r0vuiD32oqywwP8Wyg=;
 b=rplWZNtuNcrLXkKG0jFMCEty9APO1P9a8yc9R+xe6/9K7KqKgD+dplSLLCVMIX58JroR8S4ikz0B5d/zyMPq+s1AT/9nRX6cFmQ9wsBJtkXcPTqNA871nMMoumC4V2OewQR5fCYRq+WRqSQgkpEcfoKTo92C1vAVvJQKf8LVFip93QN+A3yYMgAzLE7AwgQdVPX0yOq7kB7xjg4UoryrsUwnQHOo0mEG36ed5BWw4vsWOHE7qZJ4pdVKCAa/uFF2HnkCmnAiFLQ+XojLGotOUuccNLDzH7eVZuofSvoZl0HT/hAVm//akRiSQgbLS3CQJj7KFq6fJxmUBhMe0EkI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDfs5+dicFbMEZ+n16V4zDkx0r0vuiD32oqywwP8Wyg=;
 b=YClNIcU3PeHj9O2phcdxq3DV7xSxuyWKEFtgvWyNkslzcnLdCtGBZaiAYtoG/YV+ulUghMruPNZYrSix/SWj0Bh6ClX3V4PbuhCKXUFklTO/yQV0gL5TNvhf8OjgBvifKJ8U1Zd3XVBk9WwMT0U1vjFnsFHmCqyu/tvokNbeuLM=
Received: from CH0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:610:e5::23)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 10:32:23 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::9e) by CH0PR03CA0258.outlook.office365.com
 (2603:10b6:610:e5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:32:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:32:17 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:32:12 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
Date: Wed, 23 Apr 2025 15:59:13 +0530
Message-ID: <20250423102913.438027-15-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7053c0-1098-40da-1501-08dd8252225a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fI7kkuFiJcLicxLVzOsAJS6fGGUvJTwr8QCRAR15r/qvQPNuRWlNaO9RzloT?=
 =?us-ascii?Q?zl0lI3UDKCVq9DBon25+atQI1yR11M7Tfyj+aNpiBFzVu6VycMrchybuVX4n?=
 =?us-ascii?Q?ETQiHeprQ88sXQKSo8JwnqlqIWI+XQQm9k9mbIB5B166uFPYtaw2FpCmwmy4?=
 =?us-ascii?Q?isyNedES3TLwXMWe/9ckXiGK5E2TVmCeNtOSupJ7dojefel9nTbOI9wacBt2?=
 =?us-ascii?Q?HG6TySpkN1ewxOSl7ecoWxob3F1tJ/K8KIcf6KKoIMgv2wmWu8lr3eWXMiua?=
 =?us-ascii?Q?EOnqObJyC4JWuFOQUzEfAq+78EfsDRG6nyyIheJPLpimG0EUFaVPNnjbwM09?=
 =?us-ascii?Q?XWCcquZtd/dmo1YIu8JKoRQ9/7CbAnzautxRq7xYF8bEnor7XqlN6rILQANI?=
 =?us-ascii?Q?zLk1REK89KXC1kvAUtAkailO6OmUixzrTvLlE41zPpD12krfna0M0oMegWqe?=
 =?us-ascii?Q?dGA+FHSsDD95ENthZakgo25zgE05ASikhdan2J4sgu6JI3LF/iNSugWh9xzN?=
 =?us-ascii?Q?LsKVzgHgE0vm08f2eNF+PKRPqJsLGPnjfJ643GtHqAKxfY9sxuV1++oioHKO?=
 =?us-ascii?Q?FdKMvtab7vsA05HddhUCLWYbtC/GMm5fvjKUmsC6CSFtcAWxd3nC4GwU3JiR?=
 =?us-ascii?Q?ORA9aDSpaAUHcdyJ4TF8jTxM6fMmL1dd4uoBLeh/olPoN5Ogka75SPJ1IN/P?=
 =?us-ascii?Q?v8ITt7Wf3tAkzi/Lm3UrwGV8qWHG0gVdhkfiMUPL0AvGNfb1LaxSw9mOaQSn?=
 =?us-ascii?Q?z2Y7TLwvDbLAl+eBNbaauJK+fUi3Pk9FnxQw/E6omegkbP+1Mnjg0ItGYI6G?=
 =?us-ascii?Q?IgoQdHXvQuAG8Af9RaASherK19ImlO/tUBoLGKKmRKuvTG0H90FgsNx0kHSv?=
 =?us-ascii?Q?MQkzXo6cIo3IbxjNNc+9ngEoYg/RGWJBEKnw5aqUYtUQtv7OH9o75FKytDGe?=
 =?us-ascii?Q?4rlD87Lcum9mJ/bmeEnPHp+7AUxvodH9m5MgW/wOtv/3BoQda2d873+RBRHF?=
 =?us-ascii?Q?/N6LPsb7DYfTZZN5pEXhEmR+s1mivDpBmXvKrDiXF0n4MnL7tQqxK7A1PGvM?=
 =?us-ascii?Q?mSQH5bO3HKXMASxJYOi5z8qH3QTzOt1va6gJmjGGt75s44hQIyW1N3VhmVdi?=
 =?us-ascii?Q?Wg6qP5WP6Tk/ggyxrcS9iPOTFpUbB8dPyYOmc6aw0ZVWMYIVx1pFyPnRcdLU?=
 =?us-ascii?Q?3osyiM4o0ufPGvgyEPBTbbWO8DttB7ma1PGSAAvNcgEGo3N55g8tx+c3tr7s?=
 =?us-ascii?Q?B+iQvoI9U/U+nEfcjMFHbfyyaiH1Np3yeW8JaUvVpfdv219orKtqx5lsJ1gm?=
 =?us-ascii?Q?p3a72NbjLaM3/XDSRssIIZ88KQVSKrgcLUVDo+BzZXkllbpMwW5ONQ96Q/g4?=
 =?us-ascii?Q?7Rodp0FK9Wf2pA2C2TYdNHIUNC8KNt9N8BvUNJWplvaSNquHE5f/JCmYRuyQ?=
 =?us-ascii?Q?8H6zTWGdtGXawlr00E7HMw0UfDoU9RzQiwTsW6ughXMcW9+20j5QE2Xzmv4q?=
 =?us-ascii?Q?J2PFdkeA4Y9mIaS0d2NHy4U8G4ClKzS89FVNbJ6LO0D1WyTEsFbsb3erOg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:32:23.1111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7053c0-1098-40da-1501-08dd8252225a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043

Add ionic to the kernel build environment.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++++
 drivers/infiniband/Kconfig                    |  1 +
 drivers/infiniband/hw/Makefile                |  1 +
 drivers/infiniband/hw/ionic/Kconfig           | 17 ++++++++
 drivers/infiniband/hw/ionic/Makefile          |  7 +++
 6 files changed, 79 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
 create mode 100644 drivers/infiniband/hw/ionic/Kconfig
 create mode 100644 drivers/infiniband/hw/ionic/Makefile

diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
new file mode 100644
index 000000000000..80c4d9876d3e
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+============================================================
+Linux Driver for the AMD Pensando(R) Ethernet adapter family
+============================================================
+
+AMD Pensando RDMA driver.
+Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
+
+Contents
+========
+
+- Identifying the Adapter
+- Enabling the driver
+- Support
+
+Identifying the Adapter
+=======================
+
+See Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
+for more information on identifying the adapter.
+
+Enabling the driver
+===================
+
+The driver is enabled via the standard kernel configuration system,
+using the make command::
+
+  make oldconfig/menuconfig/etc.
+
+The driver is located in the menu structure at:
+
+  -> Device Drivers
+    -> InfiniBand support
+      -> AMD Pensando DSC RDMA/RoCE Support
+
+Support
+=======
+
+For general Linux rdma support, please use the rdma mailing
+list, which is monitored by AMD Pensando personnel::
+
+  linux-rdma@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 76ee6f5004ef..23505a0bb272 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1154,6 +1154,16 @@ F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
 F:	drivers/net/ethernet/amd/pds_core/
 F:	include/linux/pds/
 
+AMD PENSANDO RDMA DRIVER
+M:	Abhijit Gangurde <abhijit.gangurde@amd.com>
+M:	Allen Hubbe <allen.hubbe@amd.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
+F:	drivers/infiniband/hw/ionic/
+F:	include/linux/ionic/
+F:	include/uapi/rdma/ionic-abi.h
+
 AMD PMC DRIVER
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a5827d11e934..f3035edfb742 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -85,6 +85,7 @@ source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/erdma/Kconfig"
 source "drivers/infiniband/hw/hfi1/Kconfig"
 source "drivers/infiniband/hw/hns/Kconfig"
+source "drivers/infiniband/hw/ionic/Kconfig"
 source "drivers/infiniband/hw/irdma/Kconfig"
 source "drivers/infiniband/hw/mana/Kconfig"
 source "drivers/infiniband/hw/mlx4/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index aba96ca9bce5..c30489902653 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
+obj-$(CONFIG_INFINIBAND_IONIC)		+= ionic/
diff --git a/drivers/infiniband/hw/ionic/Kconfig b/drivers/infiniband/hw/ionic/Kconfig
new file mode 100644
index 000000000000..023a7fcdacb8
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
+
+config INFINIBAND_IONIC
+	tristate "AMD Pensando DSC RDMA/RoCE Support"
+	depends on NETDEVICES && ETHERNET && PCI && INET && 64BIT
+	select NET_VENDOR_PENSANDO
+	select IONIC
+	help
+	  This enables RDMA/RoCE support for the AMD Pensando family of
+	  Distributed Services Cards (DSCs).
+
+	  To learn more, visit our website at
+	  <https://www.amd.com/en/products/accelerators/pensando.html>.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called ionic_rdma.
diff --git a/drivers/infiniband/hw/ionic/Makefile b/drivers/infiniband/hw/ionic/Makefile
new file mode 100644
index 000000000000..d8787ba09c0a
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_INFINIBAND_IONIC)	+= ionic_rdma.o
+
+ionic_rdma-y :=	\
+	ionic_ibdev.o ionic_queue.o ionic_pgtbl.o ionic_res.o ionic_admin.o \
+	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o
-- 
2.34.1


