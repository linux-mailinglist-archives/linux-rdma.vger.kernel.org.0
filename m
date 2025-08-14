Return-Path: <linux-rdma+bounces-12746-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A079B25B07
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC25723B80
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DB2580F1;
	Thu, 14 Aug 2025 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KfUeyUoT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94722D4F9;
	Thu, 14 Aug 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150031; cv=fail; b=gpGEUNyQPHtYqR49kf4xtm/mtwBx8wEnq8z9HkXtQ5qA1F19YC/UCGbrkAeb3PILsN77LtT3scKVrAANt2Gj3Kj1GW7kDlNxc+L8Nt/i9DDtCEtn/3MTeAPQ3WRvwZbg1AYaYANZhKMV+Z5hzZldWV+tNnwVJI4MVmoy29oOQhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150031; c=relaxed/simple;
	bh=iTLQD7Ix9GSTo0/qYbXpAHaaN7JzZVsMRXJjlL1ZSGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPTWHa1vSn/Emlj5O+zRovgLmXHmTnpW+QcPI2DSJONdjSdxsNKpMGV9TupsbmZZ8YUU1hZubdtqv1Lx8CtvUE/7/S9mSKIMp+u03/uzT97ZN0E79PxekLpKker3rhA0hyMgH+EpgzmdhoaeJPSFK5MIdZljEQOUtqMSOzH/QkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KfUeyUoT; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2AWZgU+S9vQkJJIRoId9WrNj0w7qT1dnMA3bST17XMPj7sMzZvISlYyDZSFIS6mN+3SuvHYShxxsJtGmM/PrEbI7OtzvPTlU5VvHdlcqvUF8sx/u9CtUvRq79NdzhJPNeVWEsgRSGhDgxffY1eabeFswaMHw8WmG+ETFNDHCuKxfCpPx0nUDsXjGEvrXmHnfuwwl72RK6vqPVNLL1bTP9wEHuX5WxHLYZtilPZGr2mIcrra3PRwS5Ymm+wZhLdaVbKQiifh/J7LpamsD6hbaqd0kaylXcyBDWr5VzrMOpswFP3UtzdpP7IfZcUEfNHE8PaLnRgcosGIaQs3BkEpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJSBmKnVxonXyxHftDcuf0T/lU+7rDT6nlMYP3fhCbE=;
 b=I1llAuZQg/XBy7ei8nypl0m+/KyQR/zYCM+2o2VHhz92rBia9wLFMmf9RLr5JvMDwkNZkcCj4QI8hkhTSIQUE9lmZqPeoqGlAcC4oO6Y8vAAor0cxWwzKG347iMOgjJQiV5uVr10VECeY9bXB3abyjTKXhbyGEJKFXk5/p7wOf9IvHaAqsgsxM6fGuqtxI8ECMF36Y+aFcWjPbgQ1eH21xIgfEj1uMss7tkjIUF/wmm3yMkYvKHcRodVAEc623QhETOAykBAX34JPsoes2VJCy4gyUBoqvWDkd1nP2hgAqePTVe57vwGIO8FVQSX03rYOzq4sapsygHMnGTr8B9zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJSBmKnVxonXyxHftDcuf0T/lU+7rDT6nlMYP3fhCbE=;
 b=KfUeyUoTga/+TKJSNy5zBYvd4ScN03MTLcXnYIObhI5tpcftpcN4QDmi2bvafjCoJRQAHzag/gdpO+/81fe8vxmkpIG3oRV/PuwinDWxKF5NIophCR22mGMTYcqa5jKh8UgealM86wqp0b2mB53hqCkU+NLn9U/2u3Nc6/ef5K4=
Received: from SA0PR11CA0118.namprd11.prod.outlook.com (2603:10b6:806:d1::33)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 05:40:23 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::16) by SA0PR11CA0118.outlook.office365.com
 (2603:10b6:806:d1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 05:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:40:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:40:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:40:21 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:40:17 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v5 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
Date: Thu, 14 Aug 2025 11:09:00 +0530
Message-ID: <20250814053900.1452408-15-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: ae37221f-e39b-41fb-beba-08dddaf51074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kND+BsVpVuZs9k/UyKKHNEzsCm3QVaUn13YjjDqMZ3r+cCAwOHQExNqwRgGL?=
 =?us-ascii?Q?ms+6hffLjNJBmQU/eceTb7/Q3djCFZOISrKPpeFo+CRKKSpqlb+f4rlS3S3L?=
 =?us-ascii?Q?OzVyMCgIUXy+cZbTRMTnGra8z8NyJosaAM+S8BwoRm2q3NwzkQ8rcCAFwoPC?=
 =?us-ascii?Q?f6EJ+Vj0/Uii08DC0ee1yN6V/2EaJ0u3cQC3yNGAqLdhwStywxWGf21L4NUy?=
 =?us-ascii?Q?zcPMn53Nt8yWDMqjCZ8rMwR8FFJ9ZZfsjsNF1f9rn/NnwHoV+tzDUdlCkSog?=
 =?us-ascii?Q?/8P64vGSC4bLy9FJvKusaS8YW1Kq+JGup4EXZk+fYsxiRZ95QZ0VB7LIqQ9C?=
 =?us-ascii?Q?Slmmwo3JZGRGDs1LdWj/Azc0adR66lZU+wZHHC4/9o8OrotJomJJeuJ/zvCv?=
 =?us-ascii?Q?T4Wi+wIns5cefUTABPOeqP9zTxNwangN4FVTQqztA5rgi2Vgx0dUzAka9ROJ?=
 =?us-ascii?Q?LEMOjjIC4SJXceV8owLJ+Pk121/MDoRXaw7d5Tl0F7YbZObv7eye8XtTlTg3?=
 =?us-ascii?Q?Xx5C8x3uCz8OCEPIfSCBhHRWKBpLS2T5U1DYJABpBVuD6PqMtUhy07qywRFD?=
 =?us-ascii?Q?87EQ8kqwaOkdY5tkWThCrOTKIfUkHtagKqmt2gwlxOBmhHRVGuzXOOye4p+v?=
 =?us-ascii?Q?mAfKB6d+piRVmT78L+rd9FrvqdHYkk0zKagiQRZE+UsoZHIPYQ7OFdRP0T42?=
 =?us-ascii?Q?oNpv79dEudjLYBckf2TR6JCH5RHGZitGFqMX4cKv+k/ajwuHSRSLCd7GfzOG?=
 =?us-ascii?Q?DPGjd3JvtvxobGeyb6ERUr3P2Fr+MMkavPw6sG9kR03/EQAVWvr9k9+W0SwD?=
 =?us-ascii?Q?vKXof5H6HI5uzKcUbXqcI3qUoMR17XiAL/BuJc14AKMb/47IfOdOIB/4BNba?=
 =?us-ascii?Q?ITm69qF5OHNEPgmDrOenyr6dMos5tc62YGKywmb7JbTsnPDijy51Nm4TRMFh?=
 =?us-ascii?Q?SJCvBLBlHofq9wln3W4OxtKooV1cQExW9oTk7ZwXM2wccaGnzlqcoQJ/+uP/?=
 =?us-ascii?Q?8wsoTGNB0auqNSKCdMF23BKgOa7Fg4QXGigh8aZxRj7lnhQLamjPo9WK+n+0?=
 =?us-ascii?Q?Ep4MDnyqaHtgERjEI6irQHpF4LcQyuy7b+kgubLdPjIbnXYL72fEnSapC6a4?=
 =?us-ascii?Q?0kVR9YUveGMvwnuRRmAABpxVxFbkFup11bHy1WnsRT1p01DVa8FILxbsX6vL?=
 =?us-ascii?Q?fLOonb60JTn4NQfnS/CnJcpwJLZOlku+6NoGl0bGFln1Fg93BZ5tCXfh6i83?=
 =?us-ascii?Q?3x48UkK4ps2gJGpuqRMPULsOmUFlR5Vs10r3RS5sebKFuMpDPsa/GmuwG7RJ?=
 =?us-ascii?Q?5W7rdc1/7gnaD79p1ZoyN1YHD77eWZWopJe/DPX7XX+4YJdUPdBtfzuUq5eq?=
 =?us-ascii?Q?vyR2kqp9QPmikeZ8vCMIp40RsyOVrLEktUAzoTOUEh5BgOEhGYXkqhlKy68y?=
 =?us-ascii?Q?kNwc+v8rmS9BMjv8ROQc3kXU2YgJVuj1OnHhEOu+q5KRUltOBaXTNcf4ROGX?=
 =?us-ascii?Q?0VOgp2MS6vYGcC0TCpxHpCJTg8iAjkQ6NrEr3U28n6XhPTKchf4DGNoEZA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:40:23.3765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae37221f-e39b-41fb-beba-08dddaf51074
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

Add ionic to the kernel build environment.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v4->v5
  - Updated documentation
v2->v3
  - Removed select of ethernet driver
  - Fixed make htmldocs error

 .../device_drivers/ethernet/index.rst         |  1 +
 .../ethernet/pensando/ionic_rdma.rst          | 52 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++++
 drivers/infiniband/Kconfig                    |  1 +
 drivers/infiniband/hw/Makefile                |  1 +
 drivers/infiniband/hw/ionic/Kconfig           | 15 ++++++
 drivers/infiniband/hw/ionic/Makefile          |  9 ++++
 7 files changed, 88 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
 create mode 100644 drivers/infiniband/hw/ionic/Kconfig
 create mode 100644 drivers/infiniband/hw/ionic/Makefile

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 40ac552641a3..1fabfe02eb12 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -50,6 +50,7 @@ Contents:
    neterion/s2io
    netronome/nfp
    pensando/ionic
+   pensando/ionic_rdma
    smsc/smc9
    stmicro/stmmac
    ti/cpsw
diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
new file mode 100644
index 000000000000..4c8a7abb24e0
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+===========================================================
+RDMA Driver for the AMD Pensando(R) Ethernet adapter family
+===========================================================
+
+AMD Pensando RDMA driver.
+Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
+
+Overview
+========
+
+The ionic_rdma driver provides Remote Direct Memory Access functionality
+for AMD Pensando DSC (Distributed Services Card) devices. This driver
+implements RDMA capabilities as an auxiliary driver that operates in
+conjunction with the ionic ethernet driver.
+
+The ionic ethernet driver detects RDMA capability during device
+initialization and creates auxiliary devices that the ionic_rdma driver
+binds to, establishing the RDMA data path and control interfaces.
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
+The ionic_rdma driver depends on the ionic ethernet driver.
+See Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
+for detailed information on enabling and configuring the ionic driver.
+
+The ionic_rdma driver is enabled via the standard kernel configuration system,
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
index fe168477caa4..088558cc8b18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1176,6 +1176,15 @@ F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
 F:	drivers/net/ethernet/amd/pds_core/
 F:	include/linux/pds/
 
+AMD PENSANDO RDMA DRIVER
+M:	Abhijit Gangurde <abhijit.gangurde@amd.com>
+M:	Allen Hubbe <allen.hubbe@amd.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
+F:	drivers/infiniband/hw/ionic/
+F:	include/uapi/rdma/ionic-abi.h
+
 AMD PMC DRIVER
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 3a394cd772f6..f0323f1d6f01 100644
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
index df61b2299ec0..b706dc0d0263 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
+obj-$(CONFIG_INFINIBAND_IONIC)		+= ionic/
diff --git a/drivers/infiniband/hw/ionic/Kconfig b/drivers/infiniband/hw/ionic/Kconfig
new file mode 100644
index 000000000000..de6f10e9b6e9
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2018-2025, Advanced Micro Devices, Inc.
+
+config INFINIBAND_IONIC
+	tristate "AMD Pensando DSC RDMA/RoCE Support"
+	depends on NETDEVICES && ETHERNET && PCI && INET && IONIC
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
index 000000000000..957973742820
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-y :=  -I $(srctree)/drivers/net/ethernet/pensando/ionic
+
+obj-$(CONFIG_INFINIBAND_IONIC)	+= ionic_rdma.o
+
+ionic_rdma-y :=	\
+	ionic_ibdev.o ionic_lif_cfg.o ionic_queue.o ionic_pgtbl.o ionic_admin.o \
+	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o
-- 
2.43.0


