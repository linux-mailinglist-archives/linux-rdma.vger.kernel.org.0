Return-Path: <linux-rdma+bounces-8880-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619DBA6AEBC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1254827EE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790C22A4FC;
	Thu, 20 Mar 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1n0WJI/n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2002288EA;
	Thu, 20 Mar 2025 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499884; cv=fail; b=m4b+/K5z8zS8een5HmaBpXZbHc7VurJGMKUdHX4dgON/UcqIIt9U9+nWTFJVkfXPAiWbM2c5dk2hvyeWqyg3SDUs6NuPvlZeE3ZZPLFjlVYBGlzONoo5yGLuzB5LNeNGD3WuBH4IXeomVLY/+mumVmzlamRXrZM5bNnIloElxz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499884; c=relaxed/simple;
	bh=NT1KI0PhIWK0fSKr6BwJzwA+9NCel0iX/11p1coNXxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P677LSXJg+kcE4ySTKCxoI1XIJPWytzvrG0qi7tut4tsSD3QGESW21UgZO/CWmVATt2/kNW+Hp0yC9Atqqnwzbl5B6Q29N6gcY6xO/EciCt/cd3Fm7cSoaw4+P6PjrsfZhUipu5qhyvQfNIUZsdiy5jE3xTtdU303X4iyRN7Wrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1n0WJI/n; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O54MJBdGvY4DzfzUEheaPiuWxVo0ZSSZ33H9LnZ7i36HNvd7mijqeyNJaKtlyoK/2R4ZS8dxhutswXS9eytfTqijazlR4O40RcbZ4ZQcsi4Xl/wmYm9vccxsFlStvNkiM+ZgYas2ekHChagMA1tOqfMDYyRcJ9c+uYXBgSMqfPdXIY4/jQfKrlc7q50pVqD17maCllGYNcL9Evh7YHfCKEyC9BLc+GxZ+Wq0Xz7Qw73UrQqYAbe+RW2mqShjkcMxaaBKlBrG7OTo/s13Cwlizjfiw9JOsYeCN0yAkKf8nKl/4NPLxowJzd3xtVyZDgeOS3KIncaReNv8QkDHFhbt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CprVHXqTZZzd3TD4MjapO4m8YPcbPcEe/nwBKdMKghQ=;
 b=d91wyZShmvc12DN1XH5CWSOe068gqFDJw3yd0mXdryiMXau2qACuFaiBNV9NqxTO/5ty3+r9VTtZR3djzujxv/cNsSL+/cCZFRLENSCe2CB1L87n/rjOPZPeDfSB1PApOWQijTxsYj0SnVyjVq5LEMLqZWw1dzIceNbv2q7BUQV3Sn/LZT7GAAvT6D+ABMhyprGo3Q1SjzdPs+ST4pp6+GKlAKIuV6WEpNtaozAekcgde73JZlhQpaqNnZpkIMAh92tjBLenP1T7dVT9X2t4Tf0gVuzN54bSKo8b2d55Cp/eo6Zr0WDEQflNLTGVfIXkq3WJCq3PtfuEMF6vl1lmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CprVHXqTZZzd3TD4MjapO4m8YPcbPcEe/nwBKdMKghQ=;
 b=1n0WJI/nJRVJsdBAHIV6cP0e0r0R6/lJqvA0CiX8HlP6PkHp97l/n4Hx3ZpXWIpgELaOPhw7cQSKiOKVLL69Ejs00rrKxmGT2CJ0eB6ByUDfKILSFnWkYXm+qgfhgyFw/LNmIrA7DKbs8Cjri4q9G18F29dBUhRIIlCDEwpJAZg=
Received: from MN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:530::14)
 by IA0PPF864563BFB.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 19:44:37 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::c9) by MN0PR02CA0016.outlook.office365.com
 (2603:10b6:208:530::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 19:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 19:44:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 14:44:34 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 4/6] pds_fwctl: initial driver framework
Date: Thu, 20 Mar 2025 12:44:10 -0700
Message-ID: <20250320194412.67983-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250320194412.67983-1-shannon.nelson@amd.com>
References: <20250320194412.67983-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PPF864563BFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 009b424f-7cfa-47c7-421e-08dd67e7a583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|30052699003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TKhJyqv5nS1HASvKzOzVdUHwF99AdCQiAmMf9ZGED8//KvAgAtRXW/ABw761?=
 =?us-ascii?Q?Jv47xEhKDKOaTh/RGVkXI1ubjmY4tyV8G1kh6U3etr+waP43JCDE8VvwocOG?=
 =?us-ascii?Q?IiqubIBylEXkhWbmZqIpo85vG8YkoL/wbG+DWZF+8VvukUkJ6lTPeRIP+FfJ?=
 =?us-ascii?Q?84R3rOT246yX2SMDTmu2O6S9qRxXEa9GWRdt9ld2ke6S2RzcEDKHskbBGshe?=
 =?us-ascii?Q?twqKt8DvO/P08DWxInVBHhtKM6tkoWfDzT4rWtReFhlrlIw+oZOqZ0OyeDP7?=
 =?us-ascii?Q?EXPZKOc5GhUdHtpy0hMiibVFlweRyVaD7Gss4THVsemmURwKVPuyUcFgoNy5?=
 =?us-ascii?Q?FGd1xvW8OPwgwo3UKlJ7+6pqbgI7whqxmr8PnQI+CTEruhJiJBn0D2zXvkWs?=
 =?us-ascii?Q?8aAngYzRxUW7cqR0xFkRKyAwMxEH9xvAIRdE9S4Ih0+ei+BhXGNe5kOA+zN1?=
 =?us-ascii?Q?Uq3MBbDAyO3Ht16Uldy0OBeEJKmkv/cJp3YyLJlT3Mmj/Bv7O7ILSLZ6aus2?=
 =?us-ascii?Q?fLWHSiSEeIwCv183bSBHAY16aoP2RspijVcpThlvYVeAZFhUt5mNOPdUruwv?=
 =?us-ascii?Q?1biVLO/NQPqHxmIfzMI7eRVQ2f+E1rWFftXvku/I6elF1NVDbrEdCmliRS0V?=
 =?us-ascii?Q?Bj2Z2RulPt9VvgOgvx3fv8iH0hawOtKxizHSku9tgvMeF8c/1iKW4TC+/oxn?=
 =?us-ascii?Q?Jdajh8EyWjr5HnR81IJM3HyItexTCijLsbQkK2IzMYJ81fdyghew1nAObJVF?=
 =?us-ascii?Q?93dgv7G5AJS/OS/uQFzgJyInO9Fwlm4XAUXu3fQvNwb4STqMQPdXo4qGW9R3?=
 =?us-ascii?Q?7LOICnaeZEoMWYJc82HkteDv70H2vac7xOvmXHyl+dHTiSphJcVehPQSxvSm?=
 =?us-ascii?Q?DRog73lbB46M76Sz5yhAclRR7MnHbqNjhpEIphhNqWzD8+zgRjBykufgqMld?=
 =?us-ascii?Q?fsf+khK3bfx93SFV5BBO9YSy+tfv8H7A2h7+4taMARt9RpiyihlSIu/YeuGO?=
 =?us-ascii?Q?1JOdoanD0i1xqscm7SbeN4AmtlWncUwI4AbbFdwBH7sJl2Bww2hh95XrstPl?=
 =?us-ascii?Q?PAQXKQbpluE9bv9hB5XnOZDn/6d/Bktp8FeeJhhqlJjtPME9RraAXsVJzo/a?=
 =?us-ascii?Q?EZdPEqLgWB9mGMSp0KkPVtK38x9t/S2g8DwbtlHyrsEW9o6mrxG2GNIQ4D7y?=
 =?us-ascii?Q?H223TbJd8ZzmWL2V/SQyXNJQBRElDeJetNZURuBCb5l4Phn4I3hc0n8RQjOk?=
 =?us-ascii?Q?jHEySPka1Ce2w29LDU3DBB5xluVDk/P+mzh6uRFHASLRquFAjoaq9DsU3vdV?=
 =?us-ascii?Q?S7TWyzVdJ0yPjHAJwe5sMU9aRCIbzehWdwzNevqNv4htGch/7ukONt5V4LSM?=
 =?us-ascii?Q?o2tXhIDsZm6A5yVotRZOVtDgljry5OkOOYtsmX4wjzuy7E0Sxi+84jDiZHAY?=
 =?us-ascii?Q?wYPGVYFLG6NqRf/bFy7T8gXum23D6/2ogx9bWRVc6UiU44y21KOm4b3iYmLP?=
 =?us-ascii?Q?dst9bTm0PZ9paBE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(30052699003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 19:44:36.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 009b424f-7cfa-47c7-421e-08dd67e7a583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF864563BFB

Initial files for adding a new fwctl driver for the AMD/Pensando PDS
devices.  This sets up a simple auxiliary_bus driver that registers
with fwctl subsystem.  It expects that a pds_core device has set up
the auxiliary_device pds_core.fwctl

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 MAINTAINERS                    |   7 ++
 drivers/fwctl/Kconfig          |  10 ++
 drivers/fwctl/Makefile         |   1 +
 drivers/fwctl/pds/Makefile     |   4 +
 drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
 include/linux/pds/pds_adminq.h |  83 ++++++++++++++++
 include/uapi/fwctl/fwctl.h     |   1 +
 include/uapi/fwctl/pds.h       |  32 +++++++
 8 files changed, 307 insertions(+)
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3381e41dcf37..c63fd76a3684 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9576,6 +9576,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/mlx5/
 
+FWCTL PDS DRIVER
+M:	Brett Creeley <brett.creeley@amd.com>
+R:	Shannon Nelson <shannon.nelson@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/pds/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index f802cf5d4951..b5583b12a011 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -19,5 +19,15 @@ config FWCTL_MLX5
 	  This will allow configuration and debug tools to work out of the box on
 	  mainstream kernel.
 
+	  If you don't know what to do here, say N.
+
+config FWCTL_PDS
+	tristate "AMD/Pensando pds fwctl driver"
+	depends on PDS_CORE
+	help
+	  The pds_fwctl driver provides an fwctl interface for a user process
+	  to access the debug and configuration information of the AMD/Pensando
+	  DSC hardware family.
+
 	  If you don't know what to do here, say N.
 endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1c535f694d7f..c093b5f661d6 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
+obj-$(CONFIG_FWCTL_PDS) += pds/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
new file mode 100644
index 000000000000..cc2317c07be1
--- /dev/null
+++ b/drivers/fwctl/pds/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
+
+pds_fwctl-y += main.o
diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
new file mode 100644
index 000000000000..27942315a602
--- /dev/null
+++ b/drivers/fwctl/pds/main.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) Advanced Micro Devices, Inc */
+
+#include <linux/module.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include <uapi/fwctl/fwctl.h>
+#include <uapi/fwctl/pds.h>
+#include <linux/fwctl.h>
+
+#include <linux/pds/pds_common.h>
+#include <linux/pds/pds_core_if.h>
+#include <linux/pds/pds_adminq.h>
+#include <linux/pds/pds_auxbus.h>
+
+struct pdsfc_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+};
+
+struct pdsfc_dev {
+	struct fwctl_device fwctl;
+	struct pds_auxiliary_dev *padev;
+	u32 caps;
+	struct pds_fwctl_ident ident;
+};
+
+static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
+	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
+
+	pdsfc_uctx->uctx_caps = pdsfc->caps;
+
+	return 0;
+}
+
+static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
+	struct fwctl_info_pds *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uctx_caps = pdsfc_uctx->uctx_caps;
+
+	return info;
+}
+
+static int pdsfc_identify(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	union pds_core_adminq_cmd cmd;
+	struct pds_fwctl_ident *ident;
+	dma_addr_t ident_pa;
+	int err;
+
+	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev->parent, ident_pa);
+	if (err) {
+		dev_err(dev, "Failed to map ident buffer\n");
+		return err;
+	}
+
+	cmd = (union pds_core_adminq_cmd) {
+		.fwctl_ident = {
+			.opcode = PDS_FWCTL_CMD_IDENT,
+			.version = 0,
+			.len = cpu_to_le32(sizeof(*ident)),
+			.ident_pa = cpu_to_le64(ident_pa),
+		}
+	};
+
+	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
+	if (err)
+		dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
+			cmd.fwctl_ident.opcode, err);
+	else
+		pdsfc->ident = *ident;
+
+	dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
+
+	return err;
+}
+
+static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			  void *in, size_t in_len, size_t *out_len)
+{
+	return NULL;
+}
+
+static const struct fwctl_ops pdsfc_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_PDS,
+	.uctx_size = sizeof(struct pdsfc_uctx),
+	.open_uctx = pdsfc_open_uctx,
+	.close_uctx = pdsfc_close_uctx,
+	.info = pdsfc_info,
+	.fw_rpc = pdsfc_fw_rpc,
+};
+
+static int pdsfc_probe(struct auxiliary_device *adev,
+		       const struct auxiliary_device_id *id)
+{
+	struct pds_auxiliary_dev *padev =
+			container_of(adev, struct pds_auxiliary_dev, aux_dev);
+	struct device *dev = &adev->dev;
+	struct pdsfc_dev *pdsfc;
+	int err;
+
+	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
+				   struct pdsfc_dev, fwctl);
+	if (!pdsfc)
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
+	pdsfc->padev = padev;
+
+	err = pdsfc_identify(pdsfc);
+	if (err) {
+		fwctl_put(&pdsfc->fwctl);
+		return dev_err_probe(dev, err, "Failed to identify device\n");
+	}
+
+	err = fwctl_register(&pdsfc->fwctl);
+	if (err) {
+		fwctl_put(&pdsfc->fwctl);
+		return dev_err_probe(dev, err, "Failed to register device\n");
+	}
+
+	auxiliary_set_drvdata(adev, pdsfc);
+
+	return 0;
+}
+
+static void pdsfc_remove(struct auxiliary_device *adev)
+{
+	struct pdsfc_dev *pdsfc = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&pdsfc->fwctl);
+	fwctl_put(&pdsfc->fwctl);
+}
+
+static const struct auxiliary_device_id pdsfc_id_table[] = {
+	{.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
+
+static struct auxiliary_driver pdsfc_driver = {
+	.name = "pds_fwctl",
+	.probe = pdsfc_probe,
+	.remove = pdsfc_remove,
+	.id_table = pdsfc_id_table,
+};
+
+module_auxiliary_driver(pdsfc_driver);
+
+MODULE_IMPORT_NS("FWCTL");
+MODULE_DESCRIPTION("pds fwctl driver");
+MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
+MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 4b4e9a98b37b..22c6d77b3dcb 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1179,6 +1179,84 @@ struct pds_lm_host_vf_status_cmd {
 	u8     status;
 };
 
+enum pds_fwctl_cmd_opcode {
+	PDS_FWCTL_CMD_IDENT = 70,
+};
+
+/**
+ * struct pds_fwctl_cmd - Firmware control command structure
+ * @opcode: Opcode
+ * @rsvd:   Reserved
+ * @ep:     Endpoint identifier
+ * @op:     Operation identifier
+ */
+struct pds_fwctl_cmd {
+	u8     opcode;
+	u8     rsvd[3];
+	__le32 ep;
+	__le32 op;
+} __packed;
+
+/**
+ * struct pds_fwctl_comp - Firmware control completion structure
+ * @status:     Status of the firmware control operation
+ * @rsvd:       Reserved
+ * @comp_index: Completion index in little-endian format
+ * @rsvd2:      Reserved
+ * @color:      Color bit indicating the state of the completion
+ */
+struct pds_fwctl_comp {
+	u8     status;
+	u8     rsvd;
+	__le16 comp_index;
+	u8     rsvd2[11];
+	u8     color;
+} __packed;
+
+/**
+ * struct pds_fwctl_ident_cmd - Firmware control identification command structure
+ * @opcode:   Operation code for the command
+ * @rsvd:     Reserved
+ * @version:  Interface version
+ * @rsvd2:    Reserved
+ * @len:      Length of the identification data
+ * @ident_pa: Physical address of the identification data
+ */
+struct pds_fwctl_ident_cmd {
+	u8     opcode;
+	u8     rsvd;
+	u8     version;
+	u8     rsvd2;
+	__le32 len;
+	__le64 ident_pa;
+} __packed;
+
+/* future feature bits here
+ * enum pds_fwctl_features {
+ * };
+ * (compilers don't like empty enums)
+ */
+
+/**
+ * struct pds_fwctl_ident - Firmware control identification structure
+ * @features:    Supported features (enum pds_fwctl_features)
+ * @version:     Interface version
+ * @rsvd:        Reserved
+ * @max_req_sz:  Maximum request size
+ * @max_resp_sz: Maximum response size
+ * @max_req_sg_elems:  Maximum number of request SGs
+ * @max_resp_sg_elems: Maximum number of response SGs
+ */
+struct pds_fwctl_ident {
+	__le64 features;
+	u8     version;
+	u8     rsvd[3];
+	__le32 max_req_sz;
+	__le32 max_resp_sz;
+	u8     max_req_sg_elems;
+	u8     max_resp_sg_elems;
+} __packed;
+
 union pds_core_adminq_cmd {
 	u8     opcode;
 	u8     bytes[64];
@@ -1216,6 +1294,9 @@ union pds_core_adminq_cmd {
 	struct pds_lm_dirty_enable_cmd	  lm_dirty_enable;
 	struct pds_lm_dirty_disable_cmd	  lm_dirty_disable;
 	struct pds_lm_dirty_seq_ack_cmd	  lm_dirty_seq_ack;
+
+	struct pds_fwctl_cmd		  fwctl;
+	struct pds_fwctl_ident_cmd	  fwctl_ident;
 };
 
 union pds_core_adminq_comp {
@@ -1243,6 +1324,8 @@ union pds_core_adminq_comp {
 
 	struct pds_lm_state_size_comp	  lm_state_size;
 	struct pds_lm_dirty_status_comp	  lm_dirty_status;
+
+	struct pds_fwctl_comp		  fwctl;
 };
 
 #ifndef __CHECKER__
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index c2d5abc5a726..716ac0eee42d 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -44,6 +44,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
 	FWCTL_DEVICE_TYPE_CXL = 2,
+	FWCTL_DEVICE_TYPE_PDS = 4,
 };
 
 /**
diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
new file mode 100644
index 000000000000..749bfb652f4d
--- /dev/null
+++ b/include/uapi/fwctl/pds.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright(c) Advanced Micro Devices, Inc */
+
+/*
+ * fwctl interface info for pds_fwctl
+ */
+
+#ifndef _UAPI_FWCTL_PDS_H_
+#define _UAPI_FWCTL_PDS_H_
+
+#include <linux/types.h>
+
+/**
+ * struct fwctl_info_pds
+ * @uctx_caps:  bitmap of firmware capabilities
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_pds {
+	__u32 uctx_caps;
+};
+
+/**
+ * enum pds_fwctl_capabilities
+ * @PDS_FWCTL_QUERY_CAP: firmware can be queried for information
+ * @PDS_FWCTL_SEND_CAP:  firmware can be sent commands
+ */
+enum pds_fwctl_capabilities {
+	PDS_FWCTL_QUERY_CAP = 0,
+	PDS_FWCTL_SEND_CAP,
+};
+#endif /* _UAPI_FWCTL_PDS_H_ */
-- 
2.17.1


