Return-Path: <linux-rdma+bounces-12733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB3B25AF4
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A8D18836D0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAFF2222A7;
	Thu, 14 Aug 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0hSYqmUQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A01E3DFE;
	Thu, 14 Aug 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149972; cv=fail; b=SbrG/nPIN1K+78yYL/+SYVBV+Db20DTeMbE7ilMk/kFd7zXVDS714iL1JInqmnQBZUNsdjiJKRz6UmUJdE9BQxSSuP5W6KysHc71MkYZWXyKK+weiBVwp+cSpqupGQEQoeB/aQ19/vXRlmr49WHaVl15EEyaEsh3KZujp+R86bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149972; c=relaxed/simple;
	bh=n7Ag7VrGMr0eXV9KsRtEFDZUaiLoLkfXXRwpnGbLQOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gyf869rWqYXIyYBaovqG3jzdC+8LXVvr77mnNj4OjxZU/xYdt8Bhgjx0hpCSfKsdH1dmFo/rYaVWKRadyDTZpSuWvbWVk/udM0DG2qCLlIGbBqCDBO4jfIM+L1wVu+S6uzhhFO2gb9+MhDUGn09uz4ZMv3SlEhZ/LIz4he4SosU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0hSYqmUQ; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaH0TKogPYiFU8OWenNK6huYGRfxYdmjkQBe0bLvwfdHVB46xw8qXH7fvIJPmcKB8Pp38KO62gbrWsTeAzNexWELTRadEG8ESxt7NkIIXao7l1wbBoPM0Rbweutmv+gi66NDnWVhuCG+yzMwTG3Qqlr6bl67Bk55iJ2/cQA7kZj5EO64+eWQDPT2kpoofn4hxKZ0Ga0LXqY2RIDCYqRcP2XEEmQHex8ASvyTx4pl4VbFAVbJ74O0ETNsD1NR3dRweQAlMijmLd53n/3jhajlj09/HuNHtuaslfbT2JEYuUjnWBl7rizfhwYOfYy4h8YS1iLnlpTX2bJqicmtIDotww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxfUUDtW2SDTyhw0hYRj6aj+IY4QFOr52TMIQYw3JBI=;
 b=JjCEG8n0/8CeyA0l35gBpo+mKQXdmLgHnQ8QudIkHKSad0sWp8DLAiQV8hRhE6JLPhW10sDol6ZDTewCsdgkoJQiAi6M7jBpCOJ33PA5cnJXUFtJAeGfDp5CwecXxELMqe+drlPwjaocD1j644D8theO3Mvza+fxeXHu7z1QpbFsrs23/l/b6kBYt4vKXtEyJEUEFguZ9MvRVlsL3YU8LbYqx0HnHzvOe+/BMoMLAmX6oCii0RpdheBPoN7DDAnxvBSUpchKd5fTbKqowvCFwiBn0XZV7JPiCF1qieCMyaC9Oe1w1HlpqXQyrvV7nxwv16vCNLdZPYPekwWe2BqMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxfUUDtW2SDTyhw0hYRj6aj+IY4QFOr52TMIQYw3JBI=;
 b=0hSYqmUQ5/QElo6KPi8iPToMmhwMWwm2wo8x/Bhm9tx+QkuBgpgjtmOntlQI/Lg4kZNcvazV6l4etbl/ViEEtf+tzjvsMKPLtX+BKQVWL0wK9OKv/rvAgO6AtZlRqIQzOMYQDWFbP1TCuHL7B2MSQ1PWjPjeJPvAEH8up2VtN5k=
Received: from BN8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:408:c0::22)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 05:39:24 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::74) by BN8PR15CA0009.outlook.office365.com
 (2603:10b6:408:c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 05:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:19 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:15 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 01/14] net: ionic: Create an auxiliary device for rdma driver
Date: Thu, 14 Aug 2025 11:08:47 +0530
Message-ID: <20250814053900.1452408-2-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 30eb692f-249a-4974-7f3e-08dddaf4ec73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bz/fbqb8vyGYYAmy/E+Yf3tkZ5JofpzQZr5Dahgl/yW8ph/Ku7CRQJd6hJN3?=
 =?us-ascii?Q?A5GGlr2YGQ0/oziDVB0KrhEkdEh+wchWH5gS/xaCTukS4I4D88U4UIbMW97u?=
 =?us-ascii?Q?YI0t9W4HxlcjEv40SkJlQgLzNh5mTiZA0HNZlP6E1jXgFIDxvS5IS6OxfkG/?=
 =?us-ascii?Q?mtlWjBcju0ufyVmNDdLWlNSy7dzxeV3xPAgLZwlQW6AHHiy7yvI9hM9rPBrQ?=
 =?us-ascii?Q?4J55lr/OocyMOIgLbE+wZbA1Ld9yJxrDzBXFXn2gr7y4z2vrUof6wELdwjSC?=
 =?us-ascii?Q?OlrQAyV4sFfBaOz0GNLFvdG7I9inzZiCz9z9JizTKyeyJB5Q13S/S5Y6p6U5?=
 =?us-ascii?Q?+KPb8/5Ioy/vA2MwOue3ncam991ookXArXLsl+DBTfi02G5SUOpNlEMYwjkv?=
 =?us-ascii?Q?P+0nCiLTyPD6YqNzuKYMYLM/ya4p6iEnVdvK/UelPgrwcApSa5pqDPJRrJT6?=
 =?us-ascii?Q?MSyMVgEQXTS4dfl1927LGql96JdKos4Hna1idZ8C01jni35V0YVZx4cMxpPO?=
 =?us-ascii?Q?j648Y39dt5INHpPQLlp4hAJ6gWASI534vSIzlL+DBx7FyZmGYbNZNX2x0f15?=
 =?us-ascii?Q?QGXIBFMhQgQnbY9QiJg6Xvr3jxqU6CCGP+l6AJm12lJCQlyFJpOPfUBkE/b4?=
 =?us-ascii?Q?Tz8LCTpCFYmE5BNLUzP+kR/z1q7hvbFSFg5kPfwQe0W1dulXxKlomO3Mz2ZJ?=
 =?us-ascii?Q?O6iGO7LUmB1q6zKQSvoVdSsM9MTakTYBtnCwKi7GiAcRAMuoih27vZ/d5o8d?=
 =?us-ascii?Q?WLflyRf61PV9k8rhqwuURPc7Kk7WSJ/4ZJJNAIdQWWigbm4DLlJv2hIvEgLP?=
 =?us-ascii?Q?mPzMA79iNVSMOxnzTnm39YL6474QECXeE4MER7zY5KkiFvVF74fQEvbGEuck?=
 =?us-ascii?Q?SKZZHf2misr56CCNuZ0Y74c5VrWIFi1vasizwHZic4av8NmVc6RC3AE97LwJ?=
 =?us-ascii?Q?SHinhsK+0GBTan+UbKl91GUFiCWFo6/XvSPq7FB9bcPUHsKcPSacpb9uabdh?=
 =?us-ascii?Q?N4cPriuBgC8V7QKcAz0e+pOrHKHJFw1k11Xm25Rva2U8UV9FrN6zoIG3/UT4?=
 =?us-ascii?Q?25M1N8peTbKl4jCyubPLRMS/Y2to/QKJweFiEr6cuD+ODb6kkU3jbFTC0WVy?=
 =?us-ascii?Q?qK6IBds9VEMQvsEqq1X1pzRCm897NsakOXxC3e//Tamsn3l5WODJ9Kj8Rah1?=
 =?us-ascii?Q?5RvDXjaBlwk3QbXSFyx7eBA8Jm+cNjYmXW816zGnTbfLVV+eM3V0qwkGLurx?=
 =?us-ascii?Q?t23rseoFWL6MDPQH7iW33DLQbgOYBYkpDs9uSh4PgGEyLQFTGhYMiut8ODGQ?=
 =?us-ascii?Q?E0pXzhqMzGlNf4wqQzSIV+cU0GNNZRehC13zxI92StnEkXgn98750B21TMH2?=
 =?us-ascii?Q?+w0dixmL6MDLNzhLFU8KK78s1Ojt//ZSJfNNd7w1HsmsF5s4xwoA944FLk1X?=
 =?us-ascii?Q?C82og8YFzf13SrjrI91+kM4UV2oDkewp2rGJIwD65Ee6eqg2egpaxIhrE7At?=
 =?us-ascii?Q?uV3PRQGWJ9qtalDOMZhD6/HE6J75nZvvLYeu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:22.9893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30eb692f-249a-4974-7f3e-08dddaf4ec73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

To support RDMA capable ethernet device, create an auxiliary device in
the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
device to the Ethernet device.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v4->v5
  - Updated documentation
  - Fixed error path in aux device creation

 .../ethernet/pensando/ionic.rst               | 10 +++
 drivers/net/ethernet/pensando/Kconfig         |  1 +
 drivers/net/ethernet/pensando/ionic/Makefile  |  2 +-
 .../net/ethernet/pensando/ionic/ionic_api.h   | 21 +++++
 .../net/ethernet/pensando/ionic/ionic_aux.c   | 80 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_aux.h   | 10 +++
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  5 ++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  7 ++
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +
 9 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h

diff --git a/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst b/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
index 05fe2b11bb18..d0005a7f04c7 100644
--- a/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
+++ b/Documentation/networking/device_drivers/ethernet/pensando/ionic.rst
@@ -13,6 +13,7 @@ Contents
 - Identifying the Adapter
 - Enabling the driver
 - Configuring the driver
+- RDMA Support via Auxiliary Device
 - Statistics
 - Support
 
@@ -105,6 +106,15 @@ XDP
 Support for XDP includes the basics, plus Jumbo frames, Redirect and
 ndo_xmit.  There is no current support for zero-copy sockets or HW offload.
 
+RDMA Support via Auxiliary Device
+=================================
+
+The ionic driver supports RDMA (Remote Direct Memory Access) functionality
+through the Linux auxiliary device framework when advertised by the firmware.
+RDMA capability is detected during device initialization, and if supported,
+the ethernet driver will create an auxiliary device that allows the rdma
+driver to bind and provide InfiniBand/RoCE functionality.
+
 Statistics
 ==========
 
diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet/pensando/Kconfig
index 01fe76786f77..c99758adf3ad 100644
--- a/drivers/net/ethernet/pensando/Kconfig
+++ b/drivers/net/ethernet/pensando/Kconfig
@@ -24,6 +24,7 @@ config IONIC
 	select NET_DEVLINK
 	select DIMLIB
 	select PAGE_POOL
+	select AUXILIARY_BUS
 	help
 	  This enables the support for the Pensando family of Ethernet
 	  adapters.  More specific information on this driver can be
diff --git a/drivers/net/ethernet/pensando/ionic/Makefile b/drivers/net/ethernet/pensando/ionic/Makefile
index 4e7642a2d25f..a598972fef41 100644
--- a/drivers/net/ethernet/pensando/ionic/Makefile
+++ b/drivers/net/ethernet/pensando/ionic/Makefile
@@ -5,5 +5,5 @@ obj-$(CONFIG_IONIC) := ionic.o
 
 ionic-y := ionic_main.o ionic_bus_pci.o ionic_devlink.o ionic_dev.o \
 	   ionic_debugfs.o ionic_lif.o ionic_rx_filter.o ionic_ethtool.o \
-	   ionic_txrx.o ionic_stats.o ionic_fw.o
+	   ionic_txrx.o ionic_stats.o ionic_fw.o ionic_aux.o
 ionic-$(CONFIG_PTP_1588_CLOCK) += ionic_phc.o
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
new file mode 100644
index 000000000000..f9fcd1b67b35
--- /dev/null
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_API_H_
+#define _IONIC_API_H_
+
+#include <linux/auxiliary_bus.h>
+
+/**
+ * struct ionic_aux_dev - Auxiliary device information
+ * @lif:        Logical interface
+ * @idx:        Index identifier
+ * @adev:       Auxiliary device
+ */
+struct ionic_aux_dev {
+	struct ionic_lif *lif;
+	int idx;
+	struct auxiliary_device adev;
+};
+
+#endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
new file mode 100644
index 000000000000..f3c2a5227b36
--- /dev/null
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/kernel.h>
+#include "ionic.h"
+#include "ionic_lif.h"
+#include "ionic_aux.h"
+
+static DEFINE_IDA(aux_ida);
+
+static void ionic_auxbus_release(struct device *dev)
+{
+	struct ionic_aux_dev *ionic_adev;
+
+	ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
+	ida_free(&aux_ida, ionic_adev->adev.id);
+	kfree(ionic_adev);
+}
+
+int ionic_auxbus_register(struct ionic_lif *lif)
+{
+	struct ionic_aux_dev *ionic_adev;
+	struct auxiliary_device *aux_dev;
+	int err, id;
+
+	if (!(le64_to_cpu(lif->ionic->ident.lif.capabilities) & IONIC_LIF_CAP_RDMA))
+		return 0;
+
+	ionic_adev = kzalloc(sizeof(*ionic_adev), GFP_KERNEL);
+	if (!ionic_adev)
+		return -ENOMEM;
+
+	aux_dev = &ionic_adev->adev;
+
+	id = ida_alloc(&aux_ida, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(lif->ionic->dev, "Failed to allocate aux id: %d\n", id);
+		kfree(ionic_adev);
+		return id;
+	}
+
+	aux_dev->id = id;
+	aux_dev->name = "rdma";
+	aux_dev->dev.parent = &lif->ionic->pdev->dev;
+	aux_dev->dev.release = ionic_auxbus_release;
+	ionic_adev->lif = lif;
+	err = auxiliary_device_init(aux_dev);
+	if (err) {
+		dev_err(lif->ionic->dev, "Failed to initialize %s aux device: %d\n",
+			aux_dev->name, err);
+		ida_free(&aux_ida, id);
+		kfree(ionic_adev);
+		return err;
+	}
+
+	err = auxiliary_device_add(aux_dev);
+	if (err) {
+		dev_err(lif->ionic->dev, "Failed to add %s aux device: %d\n",
+			aux_dev->name, err);
+		auxiliary_device_uninit(aux_dev);
+		return err;
+	}
+
+	lif->ionic_adev = ionic_adev;
+	return 0;
+}
+
+void ionic_auxbus_unregister(struct ionic_lif *lif)
+{
+	mutex_lock(&lif->adev_lock);
+	if (!lif->ionic_adev)
+		goto out;
+
+	auxiliary_device_delete(&lif->ionic_adev->adev);
+	auxiliary_device_uninit(&lif->ionic_adev->adev);
+
+	lif->ionic_adev = NULL;
+out:
+	mutex_unlock(&lif->adev_lock);
+}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.h b/drivers/net/ethernet/pensando/ionic/ionic_aux.h
new file mode 100644
index 000000000000..f5528a9f187d
--- /dev/null
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_AUX_H_
+#define _IONIC_AUX_H_
+
+int ionic_auxbus_register(struct ionic_lif *lif);
+void ionic_auxbus_unregister(struct ionic_lif *lif);
+
+#endif /* _IONIC_AUX_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 136bfa3516d0..f8752b1d2790 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -9,6 +9,7 @@
 #include "ionic.h"
 #include "ionic_bus.h"
 #include "ionic_lif.h"
+#include "ionic_aux.h"
 #include "ionic_debugfs.h"
 
 /* Supported devices */
@@ -375,6 +376,8 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_deregister_devlink;
 	}
 
+	ionic_auxbus_register(ionic->lif);
+
 	mod_timer(&ionic->watchdog_timer,
 		  round_jiffies(jiffies + ionic->watchdog_period));
 	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
@@ -416,6 +419,7 @@ static void ionic_remove(struct pci_dev *pdev)
 
 		if (ionic->lif->doorbell_wa)
 			cancel_delayed_work_sync(&ionic->doorbell_check_dwork);
+		ionic_auxbus_unregister(ionic->lif);
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
 		ionic_lif_deinit(ionic->lif);
@@ -445,6 +449,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
 	timer_delete_sync(&ionic->watchdog_timer);
 	cancel_work_sync(&lif->deferred.work);
 
+	ionic_auxbus_unregister(ionic->lif);
 	mutex_lock(&lif->queue_lock);
 	ionic_stop_queues_reconfig(lif);
 	ionic_txrx_free(lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 48cb5d30b5f6..8ed5d2e5fde4 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -19,6 +19,7 @@
 #include "ionic_bus.h"
 #include "ionic_dev.h"
 #include "ionic_lif.h"
+#include "ionic_aux.h"
 #include "ionic_txrx.h"
 #include "ionic_ethtool.h"
 #include "ionic_debugfs.h"
@@ -3293,6 +3294,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 
 	mutex_init(&lif->queue_lock);
 	mutex_init(&lif->config_lock);
+	mutex_init(&lif->adev_lock);
 
 	spin_lock_init(&lif->adminq_lock);
 
@@ -3349,6 +3351,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->info = NULL;
 	lif->info_pa = 0;
 err_out_free_mutex:
+	mutex_destroy(&lif->adev_lock);
 	mutex_destroy(&lif->config_lock);
 	mutex_destroy(&lif->queue_lock);
 err_out_free_netdev:
@@ -3384,6 +3387,7 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
 
 	netif_device_detach(lif->netdev);
 
+	ionic_auxbus_unregister(ionic->lif);
 	mutex_lock(&lif->queue_lock);
 	if (test_bit(IONIC_LIF_F_UP, lif->state)) {
 		dev_info(ionic->dev, "Surprise FW stop, stopping queues\n");
@@ -3446,6 +3450,8 @@ int ionic_restart_lif(struct ionic_lif *lif)
 	netif_device_attach(lif->netdev);
 	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
 
+	ionic_auxbus_register(ionic->lif);
+
 	return 0;
 
 err_txrx_free:
@@ -3528,6 +3534,7 @@ void ionic_lif_free(struct ionic_lif *lif)
 
 	mutex_destroy(&lif->config_lock);
 	mutex_destroy(&lif->queue_lock);
+	mutex_destroy(&lif->adev_lock);
 
 	/* free netdev & lif */
 	ionic_debugfs_del_lif(lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index e01756fb7fdd..43bdd0fb8733 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -10,6 +10,7 @@
 #include <linux/dim.h>
 #include <linux/pci.h>
 #include "ionic_rx_filter.h"
+#include "ionic_api.h"
 
 #define IONIC_ADMINQ_LENGTH	16	/* must be a power of two */
 #define IONIC_NOTIFYQ_LENGTH	64	/* must be a power of two */
@@ -225,6 +226,8 @@ struct ionic_lif {
 	dma_addr_t info_pa;
 	u32 info_sz;
 	struct ionic_qtype_info qtype_info[IONIC_QTYPE_MAX];
+	struct ionic_aux_dev *ionic_adev;
+	struct mutex adev_lock;	/* lock for aux_dev actions */
 
 	u8 rss_hash_key[IONIC_RSS_HASH_KEY_SIZE];
 	u8 *rss_ind_tbl;
-- 
2.43.0


