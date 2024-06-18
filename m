Return-Path: <linux-rdma+bounces-3273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA3090D6A6
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1278B283DFC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B3520DF4;
	Tue, 18 Jun 2024 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zh5a5jK7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541D1EB2C;
	Tue, 18 Jun 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723391; cv=fail; b=efp5eLeI0s6PurxpI7Y9PvV/MTTVYNdGLssqL0b3bD3b3Q8cmj91xxH67uQ9JGYABEm750HXk2H/EZ3OCDh3ghHW2Xb+QVebFG076q4FnJCZikV3Gd8cjGvj4o5VvK0/9DdWxXWyBZQeej3WBhCrZP+XqpsnCOAJ+plyyFnBssY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723391; c=relaxed/simple;
	bh=XWdzondiXejRulpTE/ozzYTqa2c0wMmIYcRF8zUretc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFFdxk6ojs5ly1SIhm22rMi4UUFHmmkj8QI1jP+463udj2m35DIllPQox4eNl1tkZkKq+Ezxon9yAf68oNqyzsSpPdYAlTCxDzPQOVusu60R8WugIQ3WAB1vKPy/JCczrPf0bF+wNh1mWJBC+pBrv+fHC++p6wLUo7Df3u5MCkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zh5a5jK7; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUV4aNqhwshDDYTCLBzw4iP2dvhg0zqsFx8MIUmcq8o5+CpDTEZiz6IKVu/QKeCpzFTWFDsycNbzBKcKGR72ENuVyfPanSMFbDan5NaiRaIfvhz4yCa/TV80l9OWPel9X8ovdMl0YL51YKAKrS/wR81C384szFybCE+eLL1sUIxpTC10ARdTBAer8hmeX/ozC3R6dqfOo7Vfb6dIxcMGQyNxloQGbRYnoaOW+9YDVPDF6f1gfZQREMqZc8+8hMXO6B41fePHeXG3cXlUBooGK0NAiYdnL9eRgGMtg5jQdq3EAryQhcDro6Aw3R+APjUy0gKK7mQabZyr0aJSXZxdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=av1+oClR9PZ07ASfPbxo8jJUUhKo+a7lbHoGfcPpmSQ=;
 b=oG+WdWrOGU9EltDSI6FmEEKnrGamGd5jXIEE/Yq5mLTxzolgWtFLLn2QXnlufrVNDH1u3RdUAEQaLn9DvS6bRZv5r5fVulnYAR/ygBHDD01DCmd7qm76iPso5owf4Y8l5Loy8k5zYJHDc/QBEtgLCvG4b1g+i4JRlPsKZIzAUESbV9Cy9aiQkHsrFS6pkS9Qj9w3PgaqYaNTlsfjIGlNVNFzwG6JHF2KXm/6oC13n516Qn+M5TJrLuXwkO2xMuKXrVKbafcKxtpFWsL1pnVmO1BIKJvRMZzIWTA6TMM+rs1RbPj6mXIBHja/xpzwC4DlwSNCISJMfenbFmwnH7t5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=av1+oClR9PZ07ASfPbxo8jJUUhKo+a7lbHoGfcPpmSQ=;
 b=Zh5a5jK7yima4wYOuqcjygU4emXYYv0cV89XLqUfOXdka0wZorGBzIBGP5Mo5pnevOLGpjdy5v6cKZBUbj8hwSTFMlsIeBD9tZptMEq2+jy9EhuWwntOXqGzZKUQYuwkOyzFU8oTAKHaeMflEYQ5d6hSI8VgqDeHXJa7andq9A6uRDDAowmeeYRyRFxH1mdysCZFbvYKtT0lcv2bkiLZM2TTjrEwlsV2vVa7PY+ZSkARQbnDftFs2VLhCP5xzIP6k5jwbsBbVM1VIJKLjRxJWDsWwNRaLsnSXDtuqOFfV+uLByjdQU8aTTGJYpsH5TbZewuwUyIk82ppppjNVnw/Mg==
Received: from SA0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:130::29)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 15:09:43 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::87) by SA0PR13CA0024.outlook.office365.com
 (2603:10b6:806:130::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 15:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 15:09:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 08:09:21 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Jun 2024 08:09:17 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>
Subject: [PATCH net-next v7 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Tue, 18 Jun 2024 18:09:01 +0300
Message-ID: <20240618150902.345881-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240618150902.345881-1-shayd@nvidia.com>
References: <20240618150902.345881-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db70d9e-2ba1-4921-3b55-08dc8fa8aeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3IfzoOHNgNezsFF2lKIwCD9b+zO7OIzfanP+ah7ak2Z9Y1jn7d+eJAn7sfd?=
 =?us-ascii?Q?dKvVy0IrkXsqVWah8E43zWz6i3j2GnoEhhh6xyzKZTG+GVyrdpF0HoULn8am?=
 =?us-ascii?Q?0Jj1pZQQozhydJHjpS5UQGWcFii1wwx3drscZTq6mlK9mi1vX89bIV7RHtlx?=
 =?us-ascii?Q?EotEIR2XL8voJmVVNTEXOBW+Hk9r99QCBlqaz+A2ARKwRSNxyeajyGko0ab/?=
 =?us-ascii?Q?+nbdlgvvsFKcsrmP0o9tPajujLZHjezLvibOKs+LgblVRd0beRl1JXlcPnF3?=
 =?us-ascii?Q?37Z6Iek2uSdc2plaBIszHSdj+dNjoGIJSfRCZ4L7BfLWjH+Hk+1Y9rBFyv27?=
 =?us-ascii?Q?P2V/YBoc2GlQ2TSeqw5JnTlvGqKalegJGY2/oZCiSmYVtmGxkJYwtyNKJvLc?=
 =?us-ascii?Q?dWL9/pDyrV1VsVjf1sArfs0hiQ/WPWY4biMiFiAT3f2tqG5E1Ylu8tipW0vk?=
 =?us-ascii?Q?WKWt4NZCOC6ATliaDqFjQOP/M6QYH/i3aiWo66BOfDebgoF059/JSNe/gYaX?=
 =?us-ascii?Q?gzjbRkNMe/BmvONdbpGsdcsVux+ALwj/7dBFMKOPv3RP4Tjog45O6x7WJKl+?=
 =?us-ascii?Q?zpRXQkuzGcT2vyHBYdcbEfAK3grmbvu2h3mnlad2fli13lDWLusTcc1jmREN?=
 =?us-ascii?Q?tMTEthYwBpb97YrVVt7LRZ9SZSD9N1xfTPciuPoGswI+W98hUrlXC7jJxbpb?=
 =?us-ascii?Q?8hu5tWm3xffAfnvogB9gDNSplBKvt7idgsdM0PmIFOhs8mpv/2vbu155B1jh?=
 =?us-ascii?Q?vTDHKkRFQVf2W7nm4lhset201yYexYzdhPRZxm3uYRut2TXRS54NgPI0XnBH?=
 =?us-ascii?Q?Q4EVRSirDuM5c3H7MVNo3xqMu056FiGlt860vKmg14SE/ivNEXX1fAC0aP2M?=
 =?us-ascii?Q?CgTOLBMZ51dCen8JVx+uyvRjWkK5ltPM5EJk6Yj1hng4vrpaPhnypViiBIqg?=
 =?us-ascii?Q?Nqtd3Tc53G7+DBhzSUAQI6CiQz8E7zWUTp4IHn95Rd+xsAjwW5u27f2VowfC?=
 =?us-ascii?Q?d7EA7p2V9AaA8gKPpsUh0c8KcJ4t4THmLyXSrFQK+fcgA3ff04zgQ3Hmuecq?=
 =?us-ascii?Q?lGBJWDL8SGZcOlk/NQYYlpFh8Jf4NRrSvA/DvmJoyl5w1dkyVhKAW1tZ7BPR?=
 =?us-ascii?Q?CwBQ+uQB/D9TN+Is1BsU9WUhLeIsjpqbVt+W6p7GgRd5t9oYXT+svOyhCthI?=
 =?us-ascii?Q?AmZf0m7snvKB6BZL9aJjlBuJ+TF135W6pNBECStLQWKxTtV7UbvTMM+XspdO?=
 =?us-ascii?Q?IfHbhsalzySd3vGgVZGTUvUkcaKcD5/Q0DfXQx+Tjvk+PABjTUeW1PQkaM9j?=
 =?us-ascii?Q?83kFaZzQK6GSQ3G3p6bVerfqWax0l1OgX/83f5YdFdFweRtGf05QDyKh5QzT?=
 =?us-ascii?Q?otZFg3oe26mkbkobOMiYsBHiFSEmZ0Xg/zH361xvjxXOTjp6Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:09:42.6530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db70d9e-2ba1-4921-3b55-08dc8fa8aeb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
and virtual functions are anchored on the PCI bus. The irq information
of each such function is visible to users via sysfs directory "msi_irqs"
containing files for each irq entry. However, for PCI SFs such
information is unavailable. Due to this users have no visibility on IRQs
used by the SFs.
Secondly, an SF can be multi function device supporting rdma, netdevice
and more. Without irq information at the bus level, the user is unable
to view or use the affinity of the SF IRQs.

Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
for supporting auxiliary devices, containing file for each irq entry.

For example:
$ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
50  51  52  53  54  55  56  57  58

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
v6-v7:
- dynamically creating irqs directory when first irq file created (Greg)
- removed irqs flag and simplified the dev_add() API (Greg)
- move sysfs related new code to a new auxiliary_sysfs.c file (Greg)
v5-v6:
- removed concept of shared and exclusive and hence global xarray (Greg)
v4-v5:
- restore global mutex and replace refcount_t with simple integer (Greg)
v3->4:
- remove global mutex (Przemek)
v2->v3:
- fix function declaration in case SYSFS isn't defined
v1->v2:
- move #ifdefs from drivers/base/auxiliary.c to
  include/linux/auxiliary_bus.h (Greg)
- use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
- Fix kzalloc(ref) to kzalloc(*ref) (Simon)
- Add return description in auxiliary_device_sysfs_irq_add() kdoc (Simon)
- Fix auxiliary_irq_mode_show doc (kernel test boot)
---
 Documentation/ABI/testing/sysfs-bus-auxiliary |   7 ++
 drivers/base/Makefile                         |   1 +
 drivers/base/auxiliary.c                      |   1 +
 drivers/base/auxiliary_sysfs.c                | 110 ++++++++++++++++++
 include/linux/auxiliary_bus.h                 |  20 ++++
 5 files changed, 139 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
new file mode 100644
index 000000000000..e8752c2354bc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
@@ -0,0 +1,7 @@
+What:		/sys/bus/auxiliary/devices/.../irqs/
+Date:		April, 2024
+Contact:	Shay Drory <shayd@nvidia.com>
+Description:
+		The /sys/devices/.../irqs directory contains a variable set of
+		files, with each file is named as irq number similar to PCI PF
+		or VF's irq number located in msi_irqs directory.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 3079bfe53d04..7fb21768ca36 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
 ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_MODULES)	+= module.o
+obj-$(CONFIG_AUXILIARY_BUS) += auxiliary_sysfs.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d3a2c40c2f12..55bde375150f 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -287,6 +287,7 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
 
 	dev->bus = &auxiliary_bus_type;
 	device_initialize(&auxdev->dev);
+	mutex_init(&auxdev->lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_init);
diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
new file mode 100644
index 000000000000..3f112fd26e72
--- /dev/null
+++ b/drivers/base/auxiliary_sysfs.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/slab.h>
+
+struct auxiliary_irq_info {
+	struct device_attribute sysfs_attr;
+};
+
+static struct attribute *auxiliary_irq_attrs[] = {
+	NULL
+};
+
+static const struct attribute_group auxiliary_irqs_group = {
+	.name = "irqs",
+	.attrs = auxiliary_irq_attrs,
+};
+
+static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
+{
+	int ret = 0;
+
+	mutex_lock(&auxdev->lock);
+	if (auxdev->dir_exists)
+		goto unlock;
+
+	xa_init(&auxdev->irqs);
+	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
+	if (!ret)
+		auxdev->dir_exists = 1;
+
+unlock:
+	mutex_unlock(&auxdev->lock);
+	return ret;
+}
+
+/**
+ * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: The associated interrupt number.
+ *
+ * This function should be called after auxiliary device have successfully
+ * received the irq.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	struct device *dev = &auxdev->dev;
+	struct auxiliary_irq_info *info;
+	int ret;
+
+	ret = auxiliary_irq_dir_prepare(auxdev);
+	if (ret)
+		return ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	sysfs_attr_init(&info->sysfs_attr.attr);
+	info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
+	if (!info->sysfs_attr.attr.name) {
+		ret = -ENOMEM;
+		goto name_err;
+	}
+
+	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
+	if (ret)
+		goto auxdev_xa_err;
+
+	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
+				      auxiliary_irqs_group.name);
+	if (ret)
+		goto sysfs_add_err;
+
+	return 0;
+
+sysfs_add_err:
+	xa_erase(&auxdev->irqs, irq);
+auxdev_xa_err:
+	kfree(info->sysfs_attr.attr.name);
+name_err:
+	kfree(info);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
+
+/**
+ * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: the IRQ to remove.
+ *
+ * This function should be called to remove an IRQ sysfs entry.
+ */
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
+{
+	struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
+	struct device *dev = &auxdev->dev;
+
+	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
+				     auxiliary_irqs_group.name);
+	xa_erase(&auxdev->irqs, irq);
+	kfree(info->sysfs_attr.attr.name);
+	kfree(info);
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..96be140bd1ff 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -58,6 +58,7 @@
  *       in
  * @name: Match name found by the auxiliary device driver,
  * @id: unique identitier if multiple devices of the same name are exported,
+ * @irqs: irqs xarray contains irq indices which are used by the device,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -138,7 +139,10 @@
 struct auxiliary_device {
 	struct device dev;
 	const char *name;
+	struct xarray irqs;
+	struct mutex lock; /* Protects "irqs" directory creation */
 	u32 id;
+	u8 dir_exists:1;
 };
 
 /**
@@ -212,8 +216,24 @@ int auxiliary_device_init(struct auxiliary_device *auxdev);
 int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname);
 #define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
 
+#ifdef CONFIG_SYSFS
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
+				       int irq);
+#else /* CONFIG_SYSFS */
+static inline int
+auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	return 0;
+}
+
+static inline void
+auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
+#endif
+
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
+	mutex_destroy(&auxdev->lock);
 	put_device(&auxdev->dev);
 }
 
-- 
2.38.1


