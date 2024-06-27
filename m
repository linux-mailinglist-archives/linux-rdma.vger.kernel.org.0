Return-Path: <linux-rdma+bounces-3543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C1591A95C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62C01C20ACE
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67F196D90;
	Thu, 27 Jun 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dqSj7XSf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547019645E;
	Thu, 27 Jun 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499136; cv=fail; b=keswoW3CgdeMJJPclHD3Z9M+MuJnIT2w98CQRnQfMHmf4r9e4HbkCmmw4+rscM/46Yy/8Gzl4K9YdirA44LRKKQWfe4s5D5Wt5+NcS3USYMiYU74Oq6DEe5bp5V/hRfIvLn0OgYVwWQTw4Qf+GCoGdCmm2m4pMoqi5ItGbrCwC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499136; c=relaxed/simple;
	bh=uYa05/cL6vMWNsdm3mYEIl7JvEEcIS0pf9IqeCFPM3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RujyqT9pls85PrfnFP2A4RZGGQg6t8g2KQJRG6BfKhy9J9UgCVAW7CBBr/Px8DQdWJSSlDg0xtkkXNk0lHdFBF8JGJztOe8o+nKkLKoCUgoi4SPOhjyjIXsUIfiyQEm2Hp/rBnbcT3lAxQGtIHu3RqNwdI4F0UnEXpAZx3FASlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dqSj7XSf; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpEWf27DhYr5Twu5VtdTmBspgV72YV5v9UvKneKotFd64S26eGfSxhxWG1/yHWGW+HRIT0XdlmiBEKbTOaMUnOFrsOwi18zbhVKckKex1tTmBT9pK02W/uEpXMHbNsoQgtmS6CNMzYIlITYWY/kUGE7sKpGAi0P1XyxW99iu8qt+P9v4ivCWKUnEAujhu4+L2TrTHnOrVwV7M9gbOJ+vufeZR1UaWFu2xYcy4m6kyaQU1t4A9eyyvGWoqcouGZGR0/w8XQLqFQx7h1sKbuMA8nLB+WWrFG6BX+GThZ/eQAq50MuD4Io6j0bAqmZVuwFTkhZOeeytllEci8DIje4iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czQxVjtIFYpfL9n/FOl+Y6/33B3sZBi+SneqgzN6zSo=;
 b=h5978p85iAlgrsqcFrWY4dPql3kkkL7xmxHQA44yJbd8vxPOePqI1Ne6f3U/BhnHDN47Tinh8W8x3EwtpqIWWmbJb8xwGwNTHhYS7oB8kGRG+7aESnvrZhsU4ZB5cKxd49DcPpQ2WtBCok5cl4svMtbqjOZExJren2KJ+i+c0GN4dKhmoB/iEuJGgq3uKHkU1gGSCD33l4Pbj7lCGNRP5omaIvVN1Ta33Lw1PhgjacATpfE0IxxzSm+eDgWuyE1wxY0KHaDsWQ7t7ZmKsJoch7Dz4rfuvFMmLWRAJYduVtU2ajU6hSKIja+zrdH0mhYPl5Ag++auVHabthHmatvV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czQxVjtIFYpfL9n/FOl+Y6/33B3sZBi+SneqgzN6zSo=;
 b=dqSj7XSf0TkTCVrC6eVya+Ptsd8ZGytDzDFUWGs3TQRp9R4DPghNb9hvvZgpIjvneOytg4slW70K/D4ZUIAh5lADjTIdOXWX4OrPwWINJDy8Voo4U8KYlRBtyhph1xEKwlJyGJy2PFV/jq+o22TZvQyOQWpLCbE2f2jqi642CQnVsIRUmZiIS3cC9A6jt8OMx5OLNPyxzeoOOjU0fImraGL5bczEzYLMdE9vvsxccvzLglNN5d1pd6wRUu497tqW7aTQzSw/8PpiLKQdktMUFbNr+eDLTQmH8bHy4iMW8pKtj/AMpTveVpdm71rADiBYigSab93zJnDxLM0pnc4ZRw==
Received: from SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::14)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 14:38:47 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::4d) by SA1P222CA0187.outlook.office365.com
 (2603:10b6:806:3c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:38:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:38:30 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:38:26 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next v8 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Thu, 27 Jun 2024 17:38:09 +0300
Message-ID: <20240627143810.805224-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240627143810.805224-1-shayd@nvidia.com>
References: <20240627143810.805224-1-shayd@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: b84afe11-5fd4-4edc-a84f-08dc96b6da51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q96O6hC9U2rX8TIdetP48gQ3KgrSv4TFFJKqi81pp2AHEdl8ejhXxJ8MsIpI?=
 =?us-ascii?Q?S9tkDDX++jKEbPp0YK1SQfTqrcgQ3CM+t1Ip8vD9RwVzEO3kBYKMAwMJQ1ec?=
 =?us-ascii?Q?CYXCl+KErbMzMhhwyoIlfBQ27amXeW6ueOeoOmZSAM/VAMP8UDe528E2sFPT?=
 =?us-ascii?Q?pOvtN4xYpJKypCjwhA4lBw1Bh3bJMqvRFJBxqAVDUMtHF5iOwRq1mX2Bofkd?=
 =?us-ascii?Q?1KMeQ2mLnXqtn6swA2F3EYTRvReXxqzp/yoQE3jWZQSQvq/S54Bl6avlo+Q8?=
 =?us-ascii?Q?DvxsbZ8+w+DUplB7IN6Mm+b+xFXz303lqnhwamuvJ/UGQNXJ7Qv0YXog55CA?=
 =?us-ascii?Q?NX7RXX186MvIhQ52uMpuoZVjMZk9hJ+ckJ679e3X2qdS8y8/ObOebsPoP/dk?=
 =?us-ascii?Q?ZAhARjkNzpmWLhwzf6jr5Pc78mvxAKDohKH1JO4Olr9tlrfhNhtsRedzjExN?=
 =?us-ascii?Q?9Os5TwxWiHlV+Ifqw0oKStpo+TUXbz53f2WbvpsRkiKtJwf1XtY06KUI6Foj?=
 =?us-ascii?Q?RKpPUWgFe/4EhRzatfX2eyyt4o/BuzOCD2x/5hopRQIJuXG8J69eH9Y2pW5p?=
 =?us-ascii?Q?MQP6SasrO9PfA0UNInY9OKWSG8ONu7sfj7rtntLJTpCsZV2gUybtbvi2Oozy?=
 =?us-ascii?Q?Wde6Y9vKQDU6420l63kJnjNiDXwNS0LqJ54pPQotsrxcyRl//qdmzpCkL79T?=
 =?us-ascii?Q?v3fZH0aHYaKiQVCE0YM7Uq1KnZs8xvuyx38kVlebAFLBLY8tGH9WxNc3nfRV?=
 =?us-ascii?Q?ZLWPQR2vYrwXxvlgyObUvNxlL0I2uSUKoGX6xhwKeSwD1XvZ+035Xb6nAHXm?=
 =?us-ascii?Q?+Ha1EJ1b3oDQ6kIvM0xuXiAT07FhiOdyBo2rQ5Mn4Ib1EPxbE9vMeP7RCe19?=
 =?us-ascii?Q?E+Fvfk7o0X1JFS7ofKI7KOa/auUb+go7xrcvyXoGifnl1dKUxsNTop+9RSKB?=
 =?us-ascii?Q?y1Dq0YubkYRqzG+4glJtRBHOabbVFdUvGDyKAOI9mwosdO/v2p+7dvlmmefV?=
 =?us-ascii?Q?RUOygbfSfVCnrHdnShUZ73Jm0KTyzl72WvX5It+9/ffKA6iScJwinFL8YMG1?=
 =?us-ascii?Q?5nY2BdHNQEurndI09ECQawuz5kBXydXwL1+TLkVZUz1tXX02p3nxEk2V9kgR?=
 =?us-ascii?Q?Xxtx075rUdEif1755dm3yq7VNyfREnaINUJaZFvxmbl1RdF0tsJJMsoGvruD?=
 =?us-ascii?Q?SRzobHQOg6r4VIC/92izuzzQDZQdnmiDu1FRPSaSIatOhk4HERtJbF8o/3/S?=
 =?us-ascii?Q?Z/EVDQXLLFIGI2kYb3HWzrH/Nl1QB9YvBzMXSGJzs62Z7Wx5mLSTaxntARaO?=
 =?us-ascii?Q?7k4o709riZlz/siisideLXkV5dDPkui6a8CJT1oqNEHVA1yWz8qzeOLcgf1w?=
 =?us-ascii?Q?Je3dxmTqzn0AhZQdiNHnGRVAB35kbQgqbeMi/N4M7XGihvTrVcmKP7g89ZtK?=
 =?us-ascii?Q?L0WebmOQGQdHkqnSS+kn0lM+D+bM7LTh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:38:46.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84afe11-5fd4-4edc-a84f-08dc96b6da51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266

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
index 000000000000..40fa75e4c8c9
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
+	if (auxdev->irq_dir_exists)
+		goto unlock;
+
+	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
+	if (ret)
+		goto unlock;
+
+	auxdev->irq_dir_exists = true;
+	xa_init(&auxdev->irqs);
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
+	char *name __free(kfree) = NULL;
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
+	name = kasprintf(GFP_KERNEL, "%d", irq);
+	if (!name)
+		return -ENOMEM;
+
+	ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	info->sysfs_attr.attr.name = name;
+	ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
+				      auxiliary_irqs_group.name);
+	if (ret)
+		goto sysfs_add_err;
+
+	info->sysfs_attr.attr.name = no_free_ptr(name);
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
+	struct auxiliary_irq_info *info __free(kfree) =	xa_load(&auxdev->irqs, irq);
+	const char *name __free(kfree) = info->sysfs_attr.attr.name;
+	struct device *dev = &auxdev->dev;
+
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


