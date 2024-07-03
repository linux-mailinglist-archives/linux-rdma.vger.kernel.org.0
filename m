Return-Path: <linux-rdma+bounces-3622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12769254CE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 09:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519321F22DCA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2024 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F4137C25;
	Wed,  3 Jul 2024 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0veeU1F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E68137914;
	Wed,  3 Jul 2024 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992380; cv=fail; b=s/g+1ObbF9OV6tVtjWptVyH07pwaUT7eBQ75hHzy45SU87w5eeDwb5FvXcHl5uzs65UK1lXHgHTqCD18s3nRbL2BLUVXBTpc89kxKuZEfvRbDGqMQCf5P9NIIMq4j0GUpW0H1g3GQPG8RXBBHdmHEa93KyU1KEw66vRKE4oOTZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992380; c=relaxed/simple;
	bh=f+mo6AHxVhTQQygVXU+JfYeKsL0fttiHwoCie0o6v+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo3OOR6aMiwP5KOvPpc2+0E5GqEdD9xyDVgCYQT9vEAsaYCC0+gggpr1DF7vMGAztOSgFhZCe1Y3e+n8rku6NffuMLGuuM1nqo9LIHqb2u66uWSQeA8QKECl7XnZEZXwbNvHV9p4i46+0Zr/TB1G2U33Lo8KQdqJx7E+5ksGEZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0veeU1F; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEgoQTQqpmRhKrSyNVGICnJ3qYnLCwUMsdWVCTF5NKFo48/qkPldHM66s++t4b48UtYMgTe80r+WsktLvQHKLyKTjaiVUkoUMu4jWFk/DDXyFe4gwewz/7uBeUcFsMTV9cWntHIjuKhnQ4Gqa4/883HUVl5XfygBXTyBzKYE3Pw21qalWfCrajZgltYW2RAMnHbPkT4gJfL/RQ8D4okbpTKTb/o6bnvISz7+/Ec1Z7v2EdSjtVd1QHwMRu5GuhyVqNAFZRAEIgL1dqS+BCuhNy//xhokCFhSilPlVyWBvk/XKnvBtTpQNl60YtMSyWFqEYsE0kQqsdpqcdsf3Nuf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypZtXZHM7q7XnNWx9mxzQf/SvlEuWJjbbpTvlxZVQNM=;
 b=h9o5qeGkiBbiTA7j4yYqOh8Fqt8cdVrMdhxxXSSNqA+c70hsgbWZ2Q4SWONwKXE+SOrjpFFjSyJw2zotLC1lVIJzFWzlcw7qSS1hnRU6Qeek6iD5aVxpMPPPAoVLfF/xPxFuepz1bT91+AoG1xkVkYtAn2Cl4d2coRaEr2Ld0uAGCdDsCq3VblB8KIeLFWmTbbzjirkH0qe5DIM4RNk6v1KVGCjp57LikRCxaFGuS3JzM6N++zSC9EZCmX3VpDWSrfq3eKR+j5ZKfmOBDUducdOIPCd68VomDd5Bfnp7Knq1xIjtdvAz1+TJEawCGYO1ewpIm1CqYNJqtEDKIVFiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypZtXZHM7q7XnNWx9mxzQf/SvlEuWJjbbpTvlxZVQNM=;
 b=W0veeU1FaGLivxjQSYjqeJ3X28dsf1qswXFLV1qiXP8ufP4eYNHZ1H/gIp6sI2jqhcBs6JaCzd/47T2OJIyvk6IpeYTfmOYKJA8iubpzxo6Hi7hTX1UrFoNXcJo6JrFzffDsMJMHProhiTuut+v03mgvx6+M6VrIifvlZUIo9wVoKDsSZXanjSTU7ldlLciftWmGWbu1sZDVd/xvhy/QyB7lUAp03esb2ls4UEdroIgMTpXPnGSkeEH8txW3EqG2Kce3nUb+DjOAy571csVMTGt/llM1fxFwkvQ9mSotuIuUqeODtqwHYImf97IOyFqNRVQzrSammJAZEr1zzYQo8Q==
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 07:39:35 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::df) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 07:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.1 via Frontend Transport; Wed, 3 Jul 2024 07:39:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 00:39:22 -0700
Received: from nps-server-23.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Jul 2024 00:39:16 -0700
From: Shay Drory <shayd@nvidia.com>
To: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <gregkh@linuxfoundation.org>,
	<david.m.ertman@intel.com>
CC: <rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next v9 1/2] driver core: auxiliary bus: show auxiliary device IRQs
Date: Wed, 3 Jul 2024 10:38:57 +0300
Message-ID: <20240703073858.932299-2-shayd@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703073858.932299-1-shayd@nvidia.com>
References: <20240703073858.932299-1-shayd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5a9357-8ac7-45da-35fb-08dc9b3348da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aeW5LP3jQRjJaPYjBuCBU3mrVD1cfRdft/uTliBLcEE5e6Vxn8Vy9vzWk0/?=
 =?us-ascii?Q?BrcNpWsMy2HAQanoVFSi0L0nBfrqPqyEtXgWs3bTE444pDYa1MA1R+T7mFyJ?=
 =?us-ascii?Q?6QdRgE3FrfcbHUZJOsG45Rn1HCeH+PTMGOjJI3KM2D2ZzmvyN/iLt9wJRCsS?=
 =?us-ascii?Q?6WLLkcp4A1YfgxPi04m/KQPcCsnbzgOD5MUJ3ox2bDW960MSKfLMuocu+fnc?=
 =?us-ascii?Q?4jlNQW562WOJ2VV2aK+usc7KmoQ6kCmDmolhpw1S1+Gpp/8ndBHBA+R4rCvx?=
 =?us-ascii?Q?Kv3M+uKTQ+z4twVoRW+yLclI67GwT//YwUxl/8uHGYL88NffrBQKPxSAaOe3?=
 =?us-ascii?Q?NsBmV7/GZ1IeSc1COVjiJ/VRKURQfrqIb7xTNiNt66/Z/rIZ34p8apfKJiZY?=
 =?us-ascii?Q?p7qtDXnpgr0VmmHSOdFd1HoF5B4xuZQrgIacdJtgSlg+h1Gnrec0SgvZAxgz?=
 =?us-ascii?Q?Up1Ih53b+q9vQhbYtTUTLtXVCgnfwBl4mJmyzILKD/G4b1k0mrALAsnnf1Nq?=
 =?us-ascii?Q?c4eGiQzyEZQfpsG6Il5O96PFZrQPM332bv9WtTTbaklErEnOZNgNxH1eVIz5?=
 =?us-ascii?Q?Sz1wb8I+57jegwOQYhAumPd84vYyBn+NgBOvxs0izv8PvF0tLr5uyP5suA+o?=
 =?us-ascii?Q?TzFYQ9ehE3DetyHPu59VHbWeEE5X+wdave99glJ8RibiFNUEShZ0+uQMW1wi?=
 =?us-ascii?Q?L11gWlS13uXRh0PXjS9AAF4c6xLvnuB8NiY76QL7umTac3MvfcfcHZaFqTQx?=
 =?us-ascii?Q?D1VE7QB/n5yTbFj7y3OCihM6jCD2N0DWIWYVga6w6MeLFyOmDtglO6oVOc4w?=
 =?us-ascii?Q?jYgoRxUXT92AXun7qwadDHVG3UAv+wO//VbXlP4QmJi7VU7aidAProypdiVc?=
 =?us-ascii?Q?MY//0zW/yCEooAuQpqAgc87MPxNkFHIV/ATJ3nFOjuGNkEQQ2uJ77+rIeqTZ?=
 =?us-ascii?Q?UeosN4cV6QZ9WYyCAw5OpcW8zlmtnbKQntntKuwEqMwJg3mSr5wnBikn+goy?=
 =?us-ascii?Q?PGMcrt8Yn0iJLwkFer72YvjUcoNMkBvBpVwIaZZjmpx1KMjec+iKTmaZyBRX?=
 =?us-ascii?Q?GqPQ33OKJn0KB5AYCxIzP13oQX+AfSnjF9k+/DTkXRGbITW7wKLleJzpVzTt?=
 =?us-ascii?Q?SQ4JlAEBs50ysFVq8GtLn/Sk5ogvZiVRA34QAM5teMlw7kt5x3ktV1VikEo+?=
 =?us-ascii?Q?YT+AcWO+MR96FS0ozuC1O2Fso4qDaXsPj7FbSr1+zx9N7Y0yOegHBnBr7b6H?=
 =?us-ascii?Q?Y6uFkdFwf/S1F4BccWYYLvMUGj1INXvHVGtRlzT/PnLFiHoDxrhqUE0PkGJb?=
 =?us-ascii?Q?54DFHCmZa5uZL0qerO7vwC7FYi9hjMEcXl6+F96P4d1ZOiqlNqsmDJONqhKH?=
 =?us-ascii?Q?E9+FeoY0q5b5fPzXNdAkgYN/09XIEbrZkezE7MN8iZ784BNKUL+1OCeevR3R?=
 =?us-ascii?Q?eXoWVnqHgQl+hERby1bp6I3UszWKplZ+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 07:39:34.6727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5a9357-8ac7-45da-35fb-08dc9b3348da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>

---
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
 drivers/base/auxiliary_sysfs.c                | 111 ++++++++++++++++++
 include/linux/auxiliary_bus.h                 |  22 ++++
 5 files changed, 144 insertions(+)
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
index 000000000000..f4e267971d70
--- /dev/null
+++ b/drivers/base/auxiliary_sysfs.c
@@ -0,0 +1,111 @@
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


