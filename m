Return-Path: <linux-rdma+bounces-10144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E914AAAF27A
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102E21C20C26
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BC22DF8D;
	Thu,  8 May 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U528d3C/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23E22C322;
	Thu,  8 May 2025 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680507; cv=fail; b=hg4O8pYglIW+vZIWOAdjyr0SiQQPm0mI6Fi5PJiffqTMSfiqHgjlFHJSojhZc/0yMZVsKIeBBcbR8cyKraT8Mm15eCofjbOS7tC68GA4uX9iht0CP7c4PDeFmdqDrrQPZAzSffwCASsBhNHsqr1z7F5MsyYCvymYe0s6iaL03fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680507; c=relaxed/simple;
	bh=ZQWwMislFNHCsAdxt2OSkY/7WFFmGGPWs3+WIB6dqu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYxHTvZVuYiXAwDH6eXwrKI6lzXx9f4Vv0wZyZSXlRaS998EnNiG/DLAdmIfOLe7c76G3+u8yJLHC4rOKniT/xzZGcLg4Xe/bHSZA46z7pssvI6HcMr8tB5AGgOM3/fTTMkk9lCe7UwVkSLCoJ9kOlt+PPedLQt1d2mQ4E5IEU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U528d3C/; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVoWHI69fAqNs5l0iDnXwr58xdVrF4KADB9U0jeQtVQ79xEllZzqPVLvLnFXFKbtC8kCwsVBkrqStrtRCYnx+1fd9JXOkfWRMz8i0zAYVLr5MR/toewYk7D26WjDEfPr2A+t+Lr7mGjbU9zW3v6LScBdmhL69Y1y3pmtLXAF++Bytsvqy2nfZ8VMM5jlE/3EU9DG73N2+GEYedT1000jFBUeXlkrXGVQbYRrpa7ksDN1ZdgFFPMvj5Krki5VYP/KwB+ke60D0DFhFGQ3ZXi7hguE/n7vXzDm+cHdFPgFqH02NKWZZ+16aXB8HleXwxGvMc3H9dpc88PXIYetkRPBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D/ITuynkAVWkoUS3AczOp3vNKOM/dv65+PUbln0nLo=;
 b=MKYZcwIgeNgGQCaHXOULtT7TrDgAdZPUbhESk1nmIGmRzpCVQ3hYLXQebUMXPup5UBLXkqY/P7tjoqWuSuxWxkAexQqSXxZH8ChGWT8u1KpbWGYd17E8zp4KWjg4YuFaPRjDSKhtqfNH7aI/XXVytOKah1iJaw6scQR8ooo6POlQ5LrHuQDaO88IAiHXo8Su1RTgaawWMBJkZAuSbITsLlV7APuOC64ICOdxcWG6mXGNkelXk11VgFkU58P+RhFogkKPDnQo5GWGRHAuuQ5FYI/N7WxN1Q/C0GxdwtBfrO1wvV6JetZwWDx6vfryCOWxNhs18+Luj2DmsVPHfwgWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0D/ITuynkAVWkoUS3AczOp3vNKOM/dv65+PUbln0nLo=;
 b=U528d3C/lFq4FwmiMzQn7bTbEiL8fggJUGTj0P9QzBLiF3Q64SIia1nmk1Par3QJL4Rd/FS/C16GAF4zDtPlhaM8ca0lZVyT8WXFYEe49xK5Ax8xquSQuip/cvt2HU91FxGueyneL2caYBBETWkmXCDKAQJnSj315wVvhAqZo+s=
Received: from PH8P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::31)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 8 May
 2025 05:01:40 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::43) by PH8P222CA0002.outlook.office365.com
 (2603:10b6:510:2d7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Thu,
 8 May 2025 05:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:38 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:01:34 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
Date: Thu, 8 May 2025 10:29:57 +0530
Message-ID: <20250508045957.2823318-15-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dffb7c4-3801-49b8-9a4e-08dd8ded6af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7266CTqb3U3AQxxibdrgdDES/oQZGun5F1SWe1hP5h/caxYL2enbxrujqrFC?=
 =?us-ascii?Q?T+K4wnnB1ICh9sjD0R0aVkvr3H2JTaF/rN1xnpHS9nKCsswt0QMYu2ocQJVc?=
 =?us-ascii?Q?FFr//0YVWTHsnxs99lLWmn2APpNN80yWquhmn/7LqvCq1c5FAkOPmrYCvJcv?=
 =?us-ascii?Q?lj97keURt8rxbD/9oX+mO7wcxhy2bYdDe/xR1RDWk31Tnq8wFFghHCTSwArT?=
 =?us-ascii?Q?6XjNSSJquVY2nQmfRW7L5btxWbRwRRy6aCmKB7E5HuuByNKTEKvv0AiiMMi0?=
 =?us-ascii?Q?zdAe3aoHt2Bu3uYXv548WmDfMDI8Bq33q/BQFKAqJkgj5MnT+JAlJClS5qGR?=
 =?us-ascii?Q?MEqkSFaNS4HlswHYTB6qk70DE4aj/CNiQV68FOtb2mzYsEShLV7/UoU3PgWG?=
 =?us-ascii?Q?Q7H4WOZOqq40b7m6wZwdDbUTlUFJq4pcRC6NTv+FFR/3ePO6mWNmDiPHNUjr?=
 =?us-ascii?Q?FZbrOCAzM+2rVaVnwFwG+LPejh9JnQe8iEkd46wXF4P4WMBAdcBSQaC2h8Be?=
 =?us-ascii?Q?lv6sdD/jrf7Jb9exBjqFiMlOx+tkV2I5s36XecnOoAGxsQ2ghIZj1lASSG+P?=
 =?us-ascii?Q?dqCQTKq4dfjgvi/7h9/NaS0g0ApuDejWLN4wJ0rcAWw2RGfTuMMejjV5CDgq?=
 =?us-ascii?Q?1/LPDhK7D9FJYKd5Fw5yjmu4ywkKSeCkwl2d4g7a8B6JakCfHrMK7DohR12w?=
 =?us-ascii?Q?b7ey5hfsWQ/MlMkeORBIW7Aj+qGkMl0vD8SMIphCtauex07BY35VHRr2+CbJ?=
 =?us-ascii?Q?zz+s+F/hLSbH4JJnjXEXVCiLQlpDMeVonW1JYYskgutFa9OpKoEKvgzlel5r?=
 =?us-ascii?Q?02U1sRlvWHtjBlLLbROOK0C7TZHQoLM18ShyhMRK9/mcQraqjA6dWwZmUQJ8?=
 =?us-ascii?Q?yigYT/3YsQ58G+k07tMB00dxZKHElTVKk3C2yHPq9HlLnPjnQ81bPuzm7D+k?=
 =?us-ascii?Q?W1yo+8RG+V2yFrUjPtd4YPhhl8ye/nAFP+MOqGMyMXY9QttRqCOjTGjoTQ9C?=
 =?us-ascii?Q?Q6bwWGmynql7so3hQfmCowSp/x1MCkHqDzD5RCK0TIDec+DwdfEo0eCRoa4k?=
 =?us-ascii?Q?v1u8KAhk47fEbg0y/mHluID19g7BDA1Z+gmr8MI8PfL1azb83xfUIxUBFPj0?=
 =?us-ascii?Q?I2kIAXjqFwzzNM0ogT+v7jmUd1bx4YHw7AAeOZo1bwBLDjVrDObVdQxPrMb1?=
 =?us-ascii?Q?4gzmnnoAjgvMHtSRh7NMde0CDZKONEAjarRzUFTjtzLA0c8+D/+Z4dmfEiS4?=
 =?us-ascii?Q?y6rzLTW+IJcEzhgRvugjUxdkH52pyhXcX088oDPXiO5unn2nqdKwzPPw5ZoU?=
 =?us-ascii?Q?xQ69X07G+efaHFr4qYYm4I5BlCabid2h19AhmMTanXBDvCRwIRNwij0BY0qy?=
 =?us-ascii?Q?U8niGB0Yy0ekZenKSRityYSXIMwQHYbzodoJ88a9WYHE75tNkaqnjHpdZq2f?=
 =?us-ascii?Q?diOqqqULAkFkDHveCG3IVTFlbVExQDDkZmu6Avh5HfsTm5IvIhLtKmptOs9S?=
 =?us-ascii?Q?e1tiIyO3GjJQZXYbhLAUUkmcU5K4AXiiQFzrECngkTPa4xagye6x4izljw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:39.6456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dffb7c4-3801-49b8-9a4e-08dd8ded6af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

Add ionic to the kernel build environment.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++++
 drivers/infiniband/Kconfig                    |  1 +
 drivers/infiniband/hw/Makefile                |  1 +
 drivers/infiniband/hw/ionic/Kconfig           | 17 ++++++++
 drivers/infiniband/hw/ionic/Makefile          |  9 ++++
 6 files changed, 80 insertions(+)
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
index 96b827049501..9859d9690d31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1154,6 +1154,15 @@ F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
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
index 000000000000..d1588d4cdb0f
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
+	ionic_ibdev.o ionic_lif_cfg.o ionic_queue.o ionic_pgtbl.o ionic_res.o	\
+	ionic_admin.o ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o
-- 
2.34.1


