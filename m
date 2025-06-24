Return-Path: <linux-rdma+bounces-11582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8AAAE6487
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D614A673B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09A2BF3EB;
	Tue, 24 Jun 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fwq8HAcr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D40298258;
	Tue, 24 Jun 2025 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767284; cv=fail; b=SBdrODHZ4fyhknLZmun3inlZBSC+CeEX1Kt0HlapV3p5oUdPYyl9bil+pTr01l9AQcJKdiyjCcD4Bg6vBhYXgy+vOTyoBKal7EcJ3zUBTHRdhW6uEIqKO3O0r3sIHZI+hkyCkjdbM6F9ggsR27QcvcqvHbR19Z1LkWIuuDob/+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767284; c=relaxed/simple;
	bh=RKoWo9bGqIzzXF2xjFxek4viR8XQlFkcZWpsTQ1mElA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwYe9ZX9x3PCOoZyRm2YvQ3UaiwtH4UUyt/Sc3BxuQpTwL5yFEniWi6QafU5/VZnSMejpDGxE6zjgv9q3oDZvugSrY29XROoanLy5LaH1CS3aPiU4FXBxLmqwd0X6/fMb13qw17+cfgVZ9bjiDxTtQEQ0+DID/O0O3FZ5jCB6VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fwq8HAcr; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rofExcMPTmOJO11sWeggvx0vzLO/YqxezJ5HDn9Zu//gTiI4+DcnRSXJuVtDhS6J5tICRQZMeI7bRewXUThZrs3YB5gGGdlMTmsUPGV/kAXnw8Yi9gy6Re/rK4BQv8wlKCqzNWYwhS6X2AsrfrmDYGZNE2N1DTRgL8kDHumDFnNAt/AvhWzJWvGsHyc6S0JmOvwiBwXbe1eGodWAY8gifQZFShS0Ll72947VBF5NA4TBqsbOcxwaILqvBZ2r7Mm84qo9mJN6L3zmMeeKTrqf1He1LJdspTgnyKwnPxi7YFWtukWRWQhWQfCMOggh6T4pPaLgt49MNmqQTuJK4cryJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebb1ycMDhtsLqHBlOchScTb+H/X9Y2soCSTnmRSjAec=;
 b=opIQaV2bX49p7JxwYyeQI16FBHJcfWbFzQb5iXXyilWFEbwfp0Phcw6EV3SOdHBOIXArvVnNor0PIN888eCWCS/pWFjkVXC+f0B18ZIMSKoNLFKnrVNGiHxNqrR1xY3qvnO3GDNoomLldMMGYT0sJxeLu6zjXAcrY47Igas7RPTcORMFCuiRCgY4iCK2Fy+6zMosYdwbd//OgW+1mI+IwGBkhDmb6y+/NTCT4GbMqua8c6ewGFSo9mQsKu7vxQ/a/u6PCuwXHmI1fFxbkJM9o6cJqrlmH0i/sDw/dBMywdAXvnO0Ly+IgjFkTrT/JlOuCu4TCWDIFIPHV1xaKa+kyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebb1ycMDhtsLqHBlOchScTb+H/X9Y2soCSTnmRSjAec=;
 b=Fwq8HAcrXcJ3xyZhQteflRoCQ+6O2eaaDS23C+dsAsSltYzKflA+HjdefHLUcCRUlOSE1pCjQGJS6jZnH7BbnSNRQk1NdfDDgSNOK/fgPeZAyF6wNeeQ0ymC3AaKTUqYwPRHE0dvWbo1JW/+20qRuT7UkDytdgLKm7X7PMAeuP0=
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 LV2PR12MB5920.namprd12.prod.outlook.com (2603:10b6:408:172::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 12:14:33 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::9c) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 12:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:14:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:14:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:14:32 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:14:27 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
Date: Tue, 24 Jun 2025 17:43:15 +0530
Message-ID: <20250624121315.739049-15-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV2PR12MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 5613966a-dbcc-4967-f6a5-08ddb318ada6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kx0P+ImZ1ciMcdOio7OfsH03ZpICCOsP7nRycGNOKikeO3x0cVepXVQbp/7Y?=
 =?us-ascii?Q?PgHg3glbefNHRjdUBx/lr+u/yAJBJrBPH4NH7QeQC8sN3+/OLbwGQ1RWg+uT?=
 =?us-ascii?Q?6xNqMDczg3n4Ja6TlGcoSaNeDcfzrgz115zZ6CSk/kA3C4tzOhf14Ut71opb?=
 =?us-ascii?Q?P+CinD16/lvCg73AYklE165KFqMWLPofSims1/VX+kU+wQijveiQ6VAMl8SO?=
 =?us-ascii?Q?er38fd1HxSe9ylAeehRaPgZoqUosOvI22rwlS7mJFmRhx1IYdmaVGYz2lQJp?=
 =?us-ascii?Q?l1v6MTCbDmNC3xRcto7nqghgXWpLT0Xtm7cI1FTo3XiW2kcwQpe3BOa6y6nG?=
 =?us-ascii?Q?2cXaWvhYQraG8OT4kY7wJ2STMYxqWXZ3x/64zDY6IsAwphXlImCf3vzYj0Db?=
 =?us-ascii?Q?VDofzIt4/dTHacATbY40g+o+3V9DNIVHCzX1S12gVQCZcuxi0Pn1SVAMwcZ0?=
 =?us-ascii?Q?ZMi7ize2wR68CtTNkuxMW/R5wmULporTGf2FOYsCZ46nY9gmDqYWp66LZjHD?=
 =?us-ascii?Q?mQbuQJRv7yPTIP+YCsyLa/lB7qrSzlvnjmUgh9Y/OwJxgXLK+NFFhINVqEHJ?=
 =?us-ascii?Q?YrSEoKWNFoQQ+8rF277XbuQ+1zpqLMFg6WUigqWQGn7+7y+g0oH6GhrZMlfp?=
 =?us-ascii?Q?DASd9dSYDDjg8gxdokIAY46hucvYUoWqQ9sdNHwRKDqDRa40fE+MOqbvNU9o?=
 =?us-ascii?Q?xYPzcB1q8Dh4uPti/c+J6TSKFQy96xQ0htBlp0B+F4XRlPIteL5JWJhJgrlX?=
 =?us-ascii?Q?lFPXNA6h6ZuqgYI2tnMCp7hSzVcxhPr+9izb8MdVlWF44Kx+LRWV1Knv4o6t?=
 =?us-ascii?Q?KVAdpZe+l2vWTdtsib/0EzCfDvczZfChkp13/Gmod9OigQi7u3AVLVEdGz7b?=
 =?us-ascii?Q?o/hp47wNfb2Fup2kAPq7VbN8wv19/FKxajessuLeQLXStXQlCCub3JqCki4v?=
 =?us-ascii?Q?O2ApOjGFLr5TKj5r+vTN7+FvxdTlObyGKHDTwPCAhGVY9X1rON0qZJnlowmP?=
 =?us-ascii?Q?kbB4ozDdin9LI4tunRHCOiu55FN0wxchV/LzuqgMaOfB1Z/bx+JvLZekNCfA?=
 =?us-ascii?Q?S0s9UJpgZXKSr4vaGQnBwyZXAXFwLn+VgESsF1j/7dcWYu3oRcIHKZ8Qjhfv?=
 =?us-ascii?Q?LWpZOvt2J/6sI8G8GzCvmeUuPaMc7jCRqTk4XnQSAum8tsOar+tGUDvEiKZr?=
 =?us-ascii?Q?kdOOQ5t+tZhxj83SqThHKl1pALJJqf6clbhEWweeb5elGg958+33qbk6hm6b?=
 =?us-ascii?Q?nx2yWNKGRN7ZanpRgCu2AlhxAAfdgTdqGn7GFz54/31RCYOYWwD/2C2BB3BH?=
 =?us-ascii?Q?mCZQ2czmYfwa+db3r7tI2rQKtr1jRbRgZqz59xC1Dv/p7BRaNK8uj5AAIIvu?=
 =?us-ascii?Q?CgXsZtntzk6DbWepZqgnXL9vYR/RAjejVVlqjt4bq/LtyPpq9x/NbidSwfNl?=
 =?us-ascii?Q?ANYZL/vwmf5ooQvBGnmBnXT30ecXqpSJZyGelsbRBeVNTQObgFslnoBHH0P1?=
 =?us-ascii?Q?MIJLLUmF6OWr5EsYYW70pcmNHPNvHOKaMhMlyBoZ4O8qmHPA8+yYkCVSMQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:14:32.9666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5613966a-dbcc-4967-f6a5-08ddb318ada6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5920

Add ionic to the kernel build environment.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v2->v3
  - Removed select of ethernet driver
  - Fixed make htmldocs error

 .../device_drivers/ethernet/index.rst         |  1 +
 .../ethernet/pensando/ionic_rdma.rst          | 43 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++++
 drivers/infiniband/Kconfig                    |  1 +
 drivers/infiniband/hw/Makefile                |  1 +
 drivers/infiniband/hw/ionic/Kconfig           | 15 +++++++
 drivers/infiniband/hw/ionic/Makefile          |  9 ++++
 7 files changed, 79 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/pensando/ionic_rdma.rst
 create mode 100644 drivers/infiniband/hw/ionic/Kconfig
 create mode 100644 drivers/infiniband/hw/ionic/Makefile

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 139b4c75a191..4b16ecd289da 100644
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
index 3f35ebff0b41..e0aee7c025b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1165,6 +1165,15 @@ F:	Documentation/networking/device_drivers/ethernet/amd/pds_core.rst
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


