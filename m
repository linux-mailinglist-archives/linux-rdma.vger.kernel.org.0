Return-Path: <linux-rdma+bounces-13061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB933B41511
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93301BA005D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709682E8B7B;
	Wed,  3 Sep 2025 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jX8CSqdk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CA2E62C7;
	Wed,  3 Sep 2025 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880312; cv=fail; b=Asn+pPQaP+sY+CESPnUGzJsgyvF5ElJ0XTZIvFWE0OTpXzwv+LnUImuJl9XJaQflraU0FmV7WwV5+BC11tC56biAFMyF7tIM+c0u1taOja7sWn6J64CkY3MYuAd6lM7sLODjMfdtOPqxL4eT0PIO8RRgXR5Cc5dmrndcGkFSxsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880312; c=relaxed/simple;
	bh=DJYK71nbmjk+FYAwap5Uz69BaQWZRWOVmqRK7/0h7Dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KN03d7cJiW3mJGHWlTnf6/TMOBOrGm3k/E09M8advAwank8i8NoWZbBm6eFkuAIP5Pk6gmSx6HxwITsVNFRvqnPz1II4TaLa9aJxY8Fw22e2FK7SFy+bc8JI4gnFHRrNALypwXZKa7GEwQBPAPdls2WWSEpqRiqa7jI38Fe0mh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jX8CSqdk; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yo5QoUf7LIDdZ3+pz2CyrVZSAeW159uStTgrkALPiR4wGQnITVAU1aUF7bjOJRONXy0TjS5EqbB9WZexCIdVtXRzTecEQlL9WBJXuCV6T+BaRcSkv6uVW4xYLk1PhcGrznWanq5m+h9hsCVemY3Ey7zQOFt1aXsKCqb8Xubj2uvoAjx5Cxj2G+vQnjvNicSe8KI6DurHW9YNo8yaTetDsrAsdF9w+ILVDw9keBlYrLA/LG4cq3D5KDrZ2UHyC3QSh4P7Yi/GKdcj2HjlJ1bE3DoBhAy0/ZoUYaq0rsKHJc8D0P+r8034aWf5n2jVKZLdjmYBd/hXJpAboMvxNIXCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3rtUed9V65pQCQs9cE+fjbD3tM4fIjeqau6b5B7fWc=;
 b=s+OuSVWMBm9p6lm9rkBubtzCBNCHTssrToHtv6SxOSO2xd24WnnQVirYf/7MlMQsP39Xjj4T7qwPC2oH597W41G6j/c1lhaM4EskCRWI6OklUiWMWP4N0BXCl8k8LHJxn1DJxCdmRpZynCPfD1YXQzx9LXSO1e7Ma8VrtYyI/NcY8zcbmd0r4TLmLbjdCHdoS6iH/85fPk+xTDlurQWZCedEEhR1kS78KwXglTVacvkhNwhnzXSlQnQ82d25YxuwyOsrDiR7kjJAouZlfwhZ2T32b1CjEWaa/r/BDPdMNH2SbVxdtUpldaxLB+qiZlpbNrOxDL3s2gOzUOuwcc8u6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3rtUed9V65pQCQs9cE+fjbD3tM4fIjeqau6b5B7fWc=;
 b=jX8CSqdk7v7rtvJOXMxQTyea9/Imw76O6smfKAkP1epTxBt1sKD53ODj9Lqi5XRs6IvIMX7s93gTAfJJ9nXDNQZzD3bz8RNAJ4X8Y/SaJ3f8PVautQZnKLZkmaSnDghJ2cwXSgN0b/R0gsQUenOxGpa54Umhe+AQfBKMXwwLl4g=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:18:24 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::25) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.15 via Frontend Transport; Wed,
 3 Sep 2025 06:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:18:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:18:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:18:23 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:18:19 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v6 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
Date: Wed, 3 Sep 2025 11:46:06 +0530
Message-ID: <20250903061606.4139957-15-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf51dd5-9559-4330-91bc-08ddeab1b025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93MGkAasTZqkgszhlSmIZyelOV/zp+zM+GxhJfAO3lKqmQkSgx58RMu5TJnL?=
 =?us-ascii?Q?qjpjNM/R97oCUwNn6aBm8pI6lpG3njzZ1gizWYNZXGecs6JQgHLcsDhP/qu8?=
 =?us-ascii?Q?gCoRwV35nWFxL6lfUWSub2uahfmAVIcl+x9+Azt7hqH4sSzLSwuDtTvKapYF?=
 =?us-ascii?Q?KZFN+txvqug56hwHlTd++ziEQo6Njad06LFKMv88a1n9qk4HJEAZz3Spl1ia?=
 =?us-ascii?Q?IGZq4tM5m5AwFQsbC6hgBhe+qW8ACzzAnDRwYGaNVwUcSE3WWkx2astN94Gl?=
 =?us-ascii?Q?S6AaTIEN7+bh3fbubUHSYsjNFaUmh2zoLZQ5aI91Vwo1HMySOBYmKAAhpmXE?=
 =?us-ascii?Q?fTkCqstHTYlXbpZkPu5qjM9AKGD0hYuMs6IiC7tNMDKWnnWJBx1c63JVBVB/?=
 =?us-ascii?Q?O1HNwyswjOjED+zTjDF404oJS+f22kLnWRaUIzdDmbXDRmKlOM5KBOHuJixi?=
 =?us-ascii?Q?OxgBkvjtsDQSOQm4k0EN/02pQ1vNCelaBO4ep0jbXq3fshLvlLGbaHwLlwo+?=
 =?us-ascii?Q?tPLBwC6hDALYPHcYpVyyV8qcegpjH1kMh43i7AfVk26AB+YjVV1JS3q75XZj?=
 =?us-ascii?Q?muoNrwrmQzSp1SMiFzIKbGU/2bmMiA+6mDwaP0crDZVRaHU6kGon4xw8ehib?=
 =?us-ascii?Q?e5vdv4DZ0YOVOKKGRLXn0VRuay6h8mSFkl6Gu9S2GVju5fZ16gtWPzKIPc1x?=
 =?us-ascii?Q?N+UdAigp7LuNlJqHQMghydEnRF8oyIm8HeO2KJiuOnAl6F9P6ZUQiYwZmo29?=
 =?us-ascii?Q?ApPEEV002MzTKrUiar+Fp2ZfzPB97eBc2KCoA/EIfkVPcij1YgNeFA5C+jPM?=
 =?us-ascii?Q?IGqwXfgg+N08G/QqrmPP/p6jBAe+07tGK9cAdv9YVDRm4kTIFA3OF9po249M?=
 =?us-ascii?Q?KjCmI6XLpY2bmrfA2KZAVnn7SCbAVeOTqiygxOH7jxdrNfHWNi8PL1U8oygg?=
 =?us-ascii?Q?e1SZhJlzR0znoa3/0Y9BmR3MU1u3V/34+MxPKjnPB4WP3diZWq/zt3MqUNAP?=
 =?us-ascii?Q?5CVNs5Gva5Z+uAoTbTNlt2F1ZpaOwe/pQz6HseHVrArLybLQk7yXkQG/FqdD?=
 =?us-ascii?Q?S6jAP2upL3/f8L0YLWwJWcEQmMWQiWhISl6z9kHmN4A6WiT8z32V7KV2gy65?=
 =?us-ascii?Q?w6qS6X3tL0FJVLU1PS9qyBjmuAGhsmW//floiBNvg7co62UCvFIzeQeNp+S2?=
 =?us-ascii?Q?r9mx5SAuU4pYZFigA+OyJ0k7JjtdfNEg8kcEfV+CIDMO71iE5mVkaxxh+2Sj?=
 =?us-ascii?Q?26uXEG7KETyXIW+dCWFI8CSbAA8riXnpiV5Nsh6q85IPI9yHRjyFAzNK0H1H?=
 =?us-ascii?Q?p4Sxvf4OeF8PsyihoSVDLyJPFFFHd5P2/NfGfLoUAXfYCVZ6S0jSJUiFZzf9?=
 =?us-ascii?Q?0WWE3m7mTTB5RzJRcL9Cu/wCrke5/imEgpoxDkxYOkED/7f68EzZ0jUYD2bg?=
 =?us-ascii?Q?wu4DTC+zekwoClLzZfP1lBEWRFMEWt2i7DpYBczIo6wzAvVEjzTKQE8XPBaT?=
 =?us-ascii?Q?JggktoKrv9jZaUH5xkYSxoYlqj5Kimhpjm+Zr+yA9kMYBVnsmoL9u3H85A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:18:24.1037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf51dd5-9559-4330-91bc-08ddeab1b025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

Add ionic to the kernel build environment.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v5->v6
  - Updated documentation
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
index 000000000000..42eb461d5f85
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
+For general Linux RDMA support, please use the RDMA mailing
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


