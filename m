Return-Path: <linux-rdma+bounces-12443-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F88B0F94F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4324A1CC38F9
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A676243387;
	Wed, 23 Jul 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PL03sXbg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32414221FDD;
	Wed, 23 Jul 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291995; cv=fail; b=b26CqsSLvOF2qmfjvqeT3XYgz+NMt9NbQyc5iK3f+hP8af9Ti67l/i2kYYJ+LPB9jip8h+u/OfJPFfgeGtlG8tQLz/YVsmGBsQAe38pmtPpDlyZhV1UudPlrLPQnytI+EGQcY8yGqeOll07NwQNjcy80qgV+gY7tVGLPDuzA8hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291995; c=relaxed/simple;
	bh=xBDGkaaBs8OTkBDDYh80VvMnRA+4sj6DWKOGYanXi8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/3FNBApaS/yR7b6CM2IL6hfAVSpoD4gbN9QM8jQHSsfCX3As+/QO/RCUdZdE12Jn1pWHnM6uzdU2S8LHqaJkWZ1AzOr3KsQoqyI60Ka0ml2pdDb1U3sJh2I89PIkHZJrAOwygkiVqm1gxr8vhX1NvOfCo3th2Aeg0QwvNvZa/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PL03sXbg; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sy0XxFwV+JPDyV/HQh/5LBJ/pfusg7Xh0v3KTQhv3IUU+59H6A9Tlwy7EpnEYqxsn7/mKL9B4o8ZrJKc0ZWoVinpib5IZDgNMvZ0icBSpGG4+Q4zNNBxw0Ld7iKzb59HhEIvyqRdWdij0IFYg9Ov6ULy6zlQ6wb/xDBaByJNsDtaQgmaDLN1abL37O95Qd/BbOQe8aZaOroyaQOMImxKU77iLI08OIhDZws3e34USv6kp8dWwaN1gBi0/r0DfWPwu5jSgKaHmxo9to29RikXZX+wFoN3ZuNeppB9jQIoucLF9yrMhptOqzTzFYeUQnAfe14J0NV9VeMJQNCJEKcyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3GOFkB4Dmd+hu2WQ4ZC6/aGuhcFnJEAo/QPuN85Zbc=;
 b=UEI4MC8E4F2fAmYj8kU+nCTdNlPcpTeRBoqM6XKXosuQkP4KVMCZjML2C2DT+sy5tdv+Fwr9zhHZQqzKg259l+PQlkYQ62NX5T5ULQLS8izHx3e0zRsZD65gyy9+4Ux9PVjzBGVl/RVrZUjAi459IHANZBMzT647p90jCQMDxffwlKo7HLRbtXYMjGU92hfAWafTlcl8KW1orTYS/EyoG+CrgNWEAUa6sQ2/JDsszcIw1MeF4RqhcRRDupXSUfh0OQf0L7lMUigC/yC/OyADzhj8DT+opqXpVU7G/0x2/yRbMFWLsoNlM36Pqph11d4oENej7d1vp0AubQ1+yuuSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3GOFkB4Dmd+hu2WQ4ZC6/aGuhcFnJEAo/QPuN85Zbc=;
 b=PL03sXbgniDnSiAAZE1qaDIhQ6aTIlwpld7+CZrgLYSNZAEYfXkE9zlcmeAkFcQxjD/Mpd0Cnvz6E1bC+bwh/fMdQ41v0wqTF8eKxpg9XkRUk9n+giCueHuXd8sx9FJnrIdXBOg1Ihi00Z5A1ESb8nGtDmRkw4QZiyocWgnLGk0=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:33:06 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:610:1f4:cafe::d8) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:33:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:33:04 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:33:00 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build environment
Date: Wed, 23 Jul 2025 23:01:49 +0530
Message-ID: <20250723173149.2568776-15-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 88272773-3e0c-4b8d-48c9-08ddca0efc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YsP4/crPzEFfwfaEeFpWm6n/V21ZweA9ee+8DGL5acd98z5HoSd56sUHluu?=
 =?us-ascii?Q?rgolV3/BFIdu+GjMug+S/5MR/sPmi7B54/69ylLvFbLJAsU8rhcwk2U0nfE7?=
 =?us-ascii?Q?Lx2kNjwkcn2JB8GwD75fbW2pwqMCRjfGTR+pEWXKTqP7jJBmdc3D82K4MEIN?=
 =?us-ascii?Q?s11xwsw9G2JiDXDSdWPMQefH4yMxDYTYfQkIYG1jlOSJsF0O/XsLkTE8HCHk?=
 =?us-ascii?Q?KG36CnTpM5wg/VQOtf3a0IAJ2BNxEKNJibSz6V687N6mq97HOZ+7cxMGe7pg?=
 =?us-ascii?Q?37scBBsQLdUt6+Fgo9BcvsNoANe9Rx0ipWGLNhfAs+f51fdpqItXkJOlZ9WI?=
 =?us-ascii?Q?uQnwA6UkV4STCzjV0Itu3PNvMWist3Z6agXZiPE17jcqsCRuHxzNVrZ4jzTD?=
 =?us-ascii?Q?G80WDEn1OqY7eajE55fnw9UVPjA6w3xWwYbUhVmqtp06sK7uvkFHO9O7PWe1?=
 =?us-ascii?Q?F0OeoYQ3KmNP6TiVNiAZVhUW8lpII06BBkIiGfWuveSy4gDgWkYNNkt1HW9v?=
 =?us-ascii?Q?nh0UKaWoYvtVRb6lqumdTkk+QwqNXyScSg21LHDJjPCx420JYpk670fR78Uu?=
 =?us-ascii?Q?3Ac7arTjqVw2T5eaaWpGdCSOVfX8PPmRumVZ/gCJbVzWOOecXhpBzwTWreM6?=
 =?us-ascii?Q?4+vZoxu7CPMlVCE71A5KfmT9Ov+0Sp0GgcG4hQGwwGE0n7doE2FnOVuyLz2n?=
 =?us-ascii?Q?y0aPrBjLExeIt4r6hWQDoMXZsS2IKiLi6/6Zl0bnI+vCn4EkKAFXUeqOwQed?=
 =?us-ascii?Q?QmRTgAnklsEz/xj5NPtXOL8GA/GFcVFtTRqjLcIZqK7wXCUf+PIQDxaZOAEb?=
 =?us-ascii?Q?K8lqc6114VDABEFjaZBNEOI9IIzYLNvw45AjQfaJj1LP4Ef0ctq/uyq8DhGz?=
 =?us-ascii?Q?yK+q5pfM0gt1AmWX1UvURjHBNOj918z9zQgMTWI/+OsCktnOOzzgwoA27wLS?=
 =?us-ascii?Q?ZloRFS4TFe4zFxRiUeUbgKmtD0rnDYUnBUSWoHrYNteLd2BJl6Iq5VUQBEwv?=
 =?us-ascii?Q?gy2tOSszc5x6baFnWLB7mkly3zzSRnfK394uTPlnXEa0ipqfaaDBsBl0XzRk?=
 =?us-ascii?Q?zDo5PhOEEv3XhQFz3iu2T4xx2fo7jSDtGYGGrTuKlh0XV3mc63Exi/EMFDYT?=
 =?us-ascii?Q?wWSN/lP8zCas4gPhTRJe5LrrdRlTOJv1uzTOQo2ctelCncjAP/T2dlPVOPMv?=
 =?us-ascii?Q?GmbtgAB66UhV1iNIqOGYj30SuZpZezbgJDietdy2lu2NtDExu1Ms3ewAd0tG?=
 =?us-ascii?Q?WqgyoOkqqzZsnFdrsujZfzlB5vqMnMnipNkFlufulDLehGwcJXk9+re64EiE?=
 =?us-ascii?Q?Si4MsvF55I95wIKAUKY3g+e5CK6Pkdq+nftfuBkWmHYaLZMsBUiKtJzmhLID?=
 =?us-ascii?Q?6Nt5dKrjjnmFz4Q/8Fh8gXYWwTPqh6dMm8qDQHUNmTJC78unJ0mTUV/8LauU?=
 =?us-ascii?Q?xInDijLyJaKKPQNQXAQQKG2N1U0ccfRJxcKuoyOGZYsPDydk7jM085r6dU86?=
 =?us-ascii?Q?Wd9o5jC5IBztkvD095kb4JJsj4BIysq7oP1A6SRfdZDpJMJ/mE1pzsDJwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:33:06.2024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88272773-3e0c-4b8d-48c9-08ddca0efc03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

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
index b4f3fa14ddca..f52409bde673 100644
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


