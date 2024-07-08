Return-Path: <linux-rdma+bounces-3704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007A929BDB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 07:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB824281941
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38A12E78;
	Mon,  8 Jul 2024 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kznJITPe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383A12B6C;
	Mon,  8 Jul 2024 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418192; cv=fail; b=NBX/92y8JrFnZxak7wQz0By1z4jTtBCsGr/rd62Qq+L2Vzp4LUC3m8PHOwP4dqXU5JYvxOgTLsQniuMiG5y8myL2LlxMPZ2LVJL5h0mxAn5TioyAVYe3iPg6qNCHTHETLp3jRbwqKbHZiPRjkbwO4oDqcHMrgyT8us9YI67X0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418192; c=relaxed/simple;
	bh=EUJ9Bt4MmwiL6sTj5XE49RYcdkjNfcEHuWI2vNQiXDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFjjvT1d5iV9nIzwKTafL7fSWxPhKjwXwnsB5Jj+FBcUWXoY921nByy0BDKHFXw7H/ImCfBTg7PDSEeb0h568BW/V3zMYye39C/wbQwcgy2t5hoMAFiTnS8Cn/k+f8e6pzAAnJXEIDSQvWtUwwRjQqwTEyEZu0OQ+Y4spYlw7pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kznJITPe; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3TwUals4n+PCimQ171+wMrOUfRlnOhTI6lV1eA1soAWvuvId5lT5cIuwRWse3dTUET41gpAYQEICVOzLKs3B9ITNEEHSloI4EUsw7kRWfftvOVcYVioR/vt2v8Lmcaf+YRFg4yklj4/iFqs1Qp5svRiLVLeGvaXmHK63Lx3+scqJlXl8MPUAZ6AglK7/WE9m2TX/ayvjZw631Kr5UDonWGYX5EKEIkiMDpKXYpnykfh0gVvm+1lJdvBTVJ0rsE8yxnMH/zJi6V1jNT9HKs8Yk1YyiMDG8+Thp+H11YnPBi/kITixjiBbP6klcwtaSxoF3LnhT4k16E9JZk8QM2/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWpiVbgACLOrPiOuAxNqD9WGk0l68Hmn/vnu07ebOik=;
 b=FUAxJeL2sDCfNroVnHi2zn7djmgzHgGRPwVDLaKJlOwLj46VGU5ZxMDdKOV8n9+VnqREIKkMIRdEXpyXjjMksU960jXd4tMXRDxRHfnCa+xvbJAR7QfhS5mM3eTL8O19tbY7founj9/zPjoRkoyQ6ucUb+dL5jk7qVyKHFIuEi/RbxWIpjJtPltnJURNuL05P8LaoIKFDtGB8J5h0SZV+pqftOnU6xPgXVOh1SlxiVuFX2liC1OGWHdyZwWY6YjWAOlZuvq8kFFHr6hfS8EuRhetd/63wcro2L7KDVTyHbY0VPShjchDr1RoDYamcfVet5apzmsviAhXSi04nd8w2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWpiVbgACLOrPiOuAxNqD9WGk0l68Hmn/vnu07ebOik=;
 b=kznJITPe0GgW/VU+3L6a3e/GIvdybCXVnc1OgiQTe+BeuymwGMHUotKZtXg0L/uHuGpI6bgdGOBfyDCaAvHjQfcLWgsl1g0uSljRQcUt1HVBofvhFJs76FtUsozLlTB34eTaa4e2rHGkecL0ks1WRXhypaxOLEP+RCw6ZwZ6cAQWljViL+d9p1xjR0c3M0wFkkpaavimwPKHJKgbMHWHAbCGnj9BaEkzKfFYmsAW9zXxGGsCsiSBXuBdEJOpMcx/RC4VlwRHT/lK+qVBaIXjrz/J7ZX0D0cDmgWxNSRmIfBI3wotzG1DHR2o2XDGEWv7qOyZyd9Ji6YjUUFoOOqxow==
Received: from BN9PR03CA0884.namprd03.prod.outlook.com (2603:10b6:408:13c::19)
 by CYYPR12MB8704.namprd12.prod.outlook.com (2603:10b6:930:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 05:56:27 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::15) by BN9PR03CA0884.outlook.office365.com
 (2603:10b6:408:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 05:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.1 via Frontend Transport; Mon, 8 Jul 2024 05:56:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 7 Jul 2024
 22:56:13 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 7 Jul 2024 22:56:09 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next v10 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Mon, 8 Jul 2024 08:55:36 +0300
Message-ID: <20240708055537.1014744-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240708055537.1014744-1-shayd@nvidia.com>
References: <20240708055537.1014744-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CYYPR12MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 995b1312-e368-42d0-fff6-08dc9f12b4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?80fEmUR2nNFNxbqzg35dGCd+LTVOnOwQIqjIpHnywZmO6YtT0mD+md3erxki?=
 =?us-ascii?Q?BHHG16H08zYbNalCD9ww6WlXss0LtlqkELvSFfEzUJBPBQFk++pOIWEa759+?=
 =?us-ascii?Q?bIgXUrLvHSWlvnqvOCpJWzeiJ4W4xtgmo0Kj8QH2ET4pH8j6+cILYjq4Gjzf?=
 =?us-ascii?Q?ALXQF3gBcfMjf5H8L7FEbGIWk83lALtfdv8DZJb8AUtLsRBD9szCGVzyshgv?=
 =?us-ascii?Q?g+bi1yyYExdphSq9kZ0AWHAa0q1qLqdYfDYvUKHMm+rmIavwEOviOzmXDwfk?=
 =?us-ascii?Q?DIJUi1+B4Hmf5QuJmbsdnEDPZxKI++1788D1cinIEaIlAmQm20SZPrMgJLYR?=
 =?us-ascii?Q?PAyOD04c1fusjKHothwg4TCZV7Vg8LqYtlMZE91FaQ7HGU8383dtOP+UII2Z?=
 =?us-ascii?Q?4IGVd8cJpCDRkI3wSnWkbi48J9AmcXcYQaL8zoHV4dtv3EL6oF7B+LsTR0rE?=
 =?us-ascii?Q?hdSrIJzArPc6rXVIgfKIQQWgXsqRmHBQZbaPfVTBTkkyBfqU/sO0ZM/3Cxjw?=
 =?us-ascii?Q?959yYjb3pUK446WBFjyFxPxg0S8NO+IInwOjX8YJfl+rDEwsXLtpvjjBKQMX?=
 =?us-ascii?Q?qo96cmxV0VnfUp8HdV9ylK6xvP/v28FBdt4vj9Nr2AYuylHZxizv1nALC87e?=
 =?us-ascii?Q?mJbsXrFzDaxGoQMDLOqo1MHSSexqbaxoccDQwn0RIAAt9wC5ItIh8S29/eXj?=
 =?us-ascii?Q?qaNl2kChpph55WCS0TRWFlwHx1tDvfQbTZJYaVejS8kFBoNSzrOYuiwLm8Qw?=
 =?us-ascii?Q?SPIVD6QghUTwMKXrzZBVn8e+DaNKieCWNZbgEHBX5O7f1IyeJRk12zsod9gB?=
 =?us-ascii?Q?soRaTzjMfvUKr6DOwaGMPR+Yk2rUAKwwuaqNC3vbJAEYmTmkaGbOEaAvj+8m?=
 =?us-ascii?Q?Q7A7yBQ5fzLQJ3Hwx5TaUxOnPTfONdegFUElvU7HSI/M2ReOjxiTlHjpkIk9?=
 =?us-ascii?Q?5dM5vEeVfWXS7Ms/EHp1PZ2cs39+hrq/R/w75o76o7i6sxbFc/3rhg3hadWL?=
 =?us-ascii?Q?VWAWyTbisuwJBd9bNKgVAZ/KRsievgm9h00m5qpST/RjlZizTeQeA+MHBJck?=
 =?us-ascii?Q?Zu05Syf6V1JSr+sFWTqCasQJ0fgbnuUToDRLChauItf1qlJ6sJWTY8FZk0W0?=
 =?us-ascii?Q?MsaFf5/HzN8fvoyHyiodWaNDiXlneWtQXZiOxezmanmIEqXoz8+Hek8rdJK+?=
 =?us-ascii?Q?hAClphvt8Zp7ADtY/RnLeRoS4xtcQMuAdn7vxqQbKnTp9vV9JAvlL9YrA0nl?=
 =?us-ascii?Q?I/t0eCu3FXafonp7g6d6xD5QLK08I12wL9+LrwBRIlof6xvU5xd+2nKSgpcE?=
 =?us-ascii?Q?JBOhWYFLL9lwEoJIb9FBmCL+UfvG2Tnp21Nu9oZJGsBzVEEAC4rxAnGAMp2Y?=
 =?us-ascii?Q?B2NZoiYBLBnksLS6+AejwHrWXX2Z0zyCYq9s/aJAIY7FDRhYz93Syaqk8ReP?=
 =?us-ascii?Q?pgdUmDUceSduiwFMCtCBJlORd8Qnmb9q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 05:56:26.8904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b1312-e368-42d0-fff6-08dc9f12b4c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8704

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

Cc: Simon Horman <horms@kernel.org>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
v9-v10:
- remove Przemek RB
- add name field to auxiliary_irq_info (Greg and Przemek)
- handle bogus IRQ in auxiliary_device_sysfs_irq_remove (Greg)
v8-v9:
- add Przemek RB
- use guard() in auxiliary_irq_dir_prepare (Paolo)
v7-v8:
- use cleanup.h for info and name fields (Greg)
- correct error flow in auxiliary_irq_dir_prepare (Przemek)
- add documentation for new fields of auxiliary_device (Simon)
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
 Documentation/ABI/testing/sysfs-bus-auxiliary |   9 ++
 drivers/base/Makefile                         |   1 +
 drivers/base/auxiliary.c                      |   1 +
 drivers/base/auxiliary_sysfs.c                | 113 ++++++++++++++++++
 include/linux/auxiliary_bus.h                 |  22 ++++
 5 files changed, 146 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
 create mode 100644 drivers/base/auxiliary_sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary b/Documentation/ABI/testing/sysfs-bus-auxiliary
new file mode 100644
index 000000000000..cc856079690f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
@@ -0,0 +1,9 @@
+What:		/sys/bus/auxiliary/devices/.../irqs/
+Date:		April, 2024
+Contact:	Shay Drory <shayd@nvidia.com>
+Description:
+		The /sys/devices/.../irqs directory contains a variable set of
+		files, with each file is named as irq number similar to PCI PF
+		or VF's irq number located in msi_irqs directory.
+		These irq files are added and removed dynamically when an IRQ
+		is requested and freed respectively for the PCI SF.
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
index 000000000000..49095d81d3ca
--- /dev/null
+++ b/drivers/base/auxiliary_sysfs.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/slab.h>
+
+#define AUXILIARY_MAX_IRQ_NAME 11
+
+struct auxiliary_irq_info {
+	struct device_attribute sysfs_attr;
+	char name[AUXILIARY_MAX_IRQ_NAME];
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
+	guard(mutex)(&auxdev->lock);
+	if (auxdev->irq_dir_exists)
+		return 0;
+
+	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
+	if (ret)
+		return ret;
+
+	auxdev->irq_dir_exists = true;
+	xa_init(&auxdev->irqs);
+	return 0;
+}
+
+/**
+ * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
+ * @auxdev: auxiliary bus device to add the sysfs entry.
+ * @irq: The associated interrupt number.
+ *
+ * This function should be called after auxiliary device have successfully
+ * received the irq.
+ * The driver is responsible to add a unique irq for the auxiliary device. The
+ * driver can invoke this function from multiple thread context safely for
+ * unique irqs of the auxiliary devices. The driver must not invoke this API
+ * multiple times if the irq is already added previously.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
+{
+	struct auxiliary_irq_info *info __free(kfree) = NULL;
+	struct device *dev = &auxdev->dev;
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
+	snprintf(info->name, AUXILIARY_MAX_IRQ_NAME, "%d", irq);
+
+	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	info->sysfs_attr.attr.name = info->name;
+	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
+				      auxiliary_irqs_group.name);
+	if (ret)
+		goto sysfs_add_err;
+
+	xa_store(&auxdev->irqs, irq, no_free_ptr(info), GFP_KERNEL);
+	return 0;
+
+sysfs_add_err:
+	xa_erase(&auxdev->irqs, irq);
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
+ * The driver must invoke this API when IRQ is released by the device.
+ */
+void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq)
+{
+	struct auxiliary_irq_info *info __free(kfree) = xa_load(&auxdev->irqs, irq);
+	struct device *dev = &auxdev->dev;
+
+	if (!info) {
+		dev_err(&auxdev->dev, "IRQ %d doesn't exist\n", irq);
+		return;
+	}
+	sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
+				     auxiliary_irqs_group.name);
+	xa_erase(&auxdev->irqs, irq);
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index de21d9d24a95..ee738379d5f2 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -58,6 +58,9 @@
  *       in
  * @name: Match name found by the auxiliary device driver,
  * @id: unique identitier if multiple devices of the same name are exported,
+ * @irqs: irqs xarray contains irq indices which are used by the device,
+ * @lock: Synchronize irq sysfs creation,
+ * @irq_dir_exists: whether "irqs" directory exists,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -138,7 +141,10 @@
 struct auxiliary_device {
 	struct device dev;
 	const char *name;
+	struct xarray irqs;
+	struct mutex lock; /* Synchronize irq sysfs creation */
 	u32 id;
+	bool irq_dir_exists;
 };
 
 /**
@@ -212,8 +218,24 @@ int auxiliary_device_init(struct auxiliary_device *auxdev);
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


