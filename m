Return-Path: <linux-rdma+bounces-12430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD04B0F913
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C4358766E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9645220F23;
	Wed, 23 Jul 2025 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3YlFFn9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A661F4C8B;
	Wed, 23 Jul 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291943; cv=fail; b=IrO+K3ily5R3GxMqiBAeoZmn1QdBWiQdRScYyYRWtSq9C5yB9Iwot9ElpIV+0Lcd9WAo5oh0i56Sjs6ZI8zUl+h9710kHFOy40h6Lom2di2rE/zh2kjhF1O4GMQ5RbCmnLSRw036GpENpCf1i3EfbP96AZS4U9ER/9BqnMIdQQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291943; c=relaxed/simple;
	bh=Uk4Tp0eixEBxkiSXqQqyj4UBFh7RRID32avXeJ1wydg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aj5RYISS8cCPwVZyUWQlWb6JkkeQSVM4cNFSsewlJKllBi1Mx/d+z2/nrXikccZ+CQGzh5jHemD71RLioVpHQIWJWo98K++FVL4o5nFNgxDKK0Duw2OyJXzk509bCFkXOkShV4abvDREnAskvwbWoahtOP3Rpca5yWAg+HCJ6A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3YlFFn9a; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQJcxha+Z3yFVMVBWDHTx6Gaz6XbkZBaqi5DVlJkVU28zwUi8aUdjFby3gCv/qtZt9SpqXBsvGzE+FVr6R8sGuLBzIbgwy8TlnrjT+I03RJrpVvCZmkW/jYeHzopDJ29KJz1pZV+IXFAu69q4XBEuZxlFK2krOjF/ItrTisoZr1aKLCTG4Frpf4B3eukUw9F5R5HT6fuhhTToCWJyd7ip5ThprEGF0ku1KrdM+IDZmbT+/toThdzO3wBUL6dlYsFAQgORN90OEA3tpG0CCmrWbrj9cs/jp6svnFsku7diXOSP6fKAdPwuNKCCh2u7koe6/f0kl0LOx6mUUzjruYGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZMfsuqV9rzJVJCm+mCMO489ht3AwPQ7DvJloUHAY8c=;
 b=QwkCcNhttm6GqaviUzJzM8TVkT1qDBN2aipVL8uWbQLRgSDJnVKWum8VWVxXpoN38uvcCA5lTpKYnRLLfPVk7Rtxsqdh1m2d0s6FZ+NtrENnYrT4kBOcI4nFWe7V7vdz5auxK5bKHTIozrTMYnZh0/jqQAKfkhjH3CHyb5Ao6KEgCsEYja5WvuPgUs3jglgq54L+qGGIybAoCoI8YZGy0R6Y8mEB5O+UszvV7yr2ybb4Pz0FmaMcXNSRp9WCrNr0Zcql2Pq6Y3ZNMAVkU/n1CSz3yN/uZI/TLIb/nmSBgM+Rmn1xOnDlgL4uBp5yz1NkvkMQVpNGWfdL9SQHYIeIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZMfsuqV9rzJVJCm+mCMO489ht3AwPQ7DvJloUHAY8c=;
 b=3YlFFn9aieNwaMki6EZB4FdchV8jn8Z4YHqWVNR/0inijdmHUkpvFvZNgQH+ZY0pJnQHReQDjyFLoKI9nGr6eB4MZKa75JG0SHQO1d9hEO07x2G1lPDeNd48ys6vNYkqe9x/dv3SEVNOp6XyckDccWaUWD4AvrACvD01sW4MzBY=
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by CH1PPFDA9B3771F.namprd12.prod.outlook.com (2603:10b6:61f:fc00::626) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 17:32:18 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:610:cc:cafe::38) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:03 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:31:59 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 01/14] net: ionic: Create an auxiliary device for rdma driver
Date: Wed, 23 Jul 2025 23:01:36 +0530
Message-ID: <20250723173149.2568776-2-abhijit.gangurde@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH1PPFDA9B3771F:EE_
X-MS-Office365-Filtering-Correlation-Id: 75149ae7-2d9b-46f7-bcec-08ddca0edf4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V7X4aPDsiTbAMzT6Bj25G2YP0CtKhuix1mjKDpvTtq59M3ye9n8e+IQeLMZw?=
 =?us-ascii?Q?pPJTyicsSd7Ab0mnFrbBHvHA9HktxF+gbfIXeHB8qOZ0oNJgzsVvAh6bcdB3?=
 =?us-ascii?Q?ANzN/ACI6rjMjWdwCRFuuQgEU6aQFTrDYU3NlUKnepg5ZwxwSkNAsdLp9Xe7?=
 =?us-ascii?Q?asr61Jfy9wfg7NeO6+J8uk0lG5TsGCcGFA1M7MADOUFYL/BEtaM1Mrdjjamd?=
 =?us-ascii?Q?tcJ3EEkym5BWV85FZYXMC9jXNvWhYY2nAULo9E/qeWBXMm48XnOztdz4ojlv?=
 =?us-ascii?Q?E+fxJRcgux9JQh0hpeVDHp0D+elFJ9QCiTLO4tcDossu5TSvoApyN3JFLNhe?=
 =?us-ascii?Q?qGwJqpyEbM22nyE/68X0J8E3h7e2E6YQW3ts8ukgQLaG/9gm8tEAzOXHB1+U?=
 =?us-ascii?Q?ApsabauB3jf5wDhWA1ME4fna+7HR/JpMB9K4U9aZGJH1Ib4y0AdvJx+kkGDa?=
 =?us-ascii?Q?C1kpqmK/wwuGcgEr+HMK/1s+32HKVla6lst4/eQy/+jrHcgm6Pj3yFt/RffC?=
 =?us-ascii?Q?s/F8p/0QwkACK/LtpdrUTkQ0T61OocRrXeKtf376Q+cIT+MKVyEnhe9zEPKI?=
 =?us-ascii?Q?7LX32aiyJtIZsIgb28HfP+SPKfwyFQoClkichfVv4G/fVBzANl10QyXDitDD?=
 =?us-ascii?Q?/txkvQszCmrJguzFnF7ykTLmMxMRA2EUtTkjPlNrUr2uAK8lrOPwT59u9xX6?=
 =?us-ascii?Q?3II3hhcW8h8XQG++RHxgPpgnpUYSiBbQxdMMM+idpU3IzS/9slPlBcMz9aL0?=
 =?us-ascii?Q?8VFJ19kIYxHyxp8j+bJY5oPTyEj8B6iDoMRf/2LRAm8UgtRYQ0y+mf39zrpx?=
 =?us-ascii?Q?SqN9LNagAM+nzeO1kwHDggy4RfompPJvAvXlAJ3+4Lh4ch6cs5usi4+X+al5?=
 =?us-ascii?Q?W1tu5aVvRYjUAayA+fnyEATe4DiZK9R520bp6MJLt/6xLQCSX8VoobEfUFsc?=
 =?us-ascii?Q?MKM4K/RWATt2jMngbvt9MKT4Y6lcxUJooXNJdTHeaGxl+FMzCLRfvCA4A24a?=
 =?us-ascii?Q?cUwkW0M3PBt4GGzPHPNj/Ak0UGRH9CgFLoAMkdh19SzfJR7cI4jJjs9a2XcY?=
 =?us-ascii?Q?3Me0SEmBCIEcK6ZJji694w3w12fFPrjAfMukqDqm2UrFiRleFqTcKXfDOl8b?=
 =?us-ascii?Q?ntJ1muB9KI61nBgoUDhjZIwJiws4A0moYQI3s/whRHt7sOqS/zL4oYFqJXXD?=
 =?us-ascii?Q?U053KAWNnmwwJO9uUcGUw4LGAAGeY+TodIwcMpYDrDlb95iHMIRbUMzPhtaI?=
 =?us-ascii?Q?W8Tn8BZZADilrSHZ+6IKkAasG7Bl5vnKbr2TE2b+NY/nEfPFpf5Q7D+/x7mO?=
 =?us-ascii?Q?zAVDFoG+xnHJEv/nwR1z6aXxKwQex163L7kwsUIC9EOfTDG4o/obNbKJCWoe?=
 =?us-ascii?Q?zoeqViFLJCshZzjZjOwu6shTIs9VXqjtVfdc/+VYk6vSO+PR+8CTvs5bemYS?=
 =?us-ascii?Q?ZU/X4d+r+ZIQT/kXIesOVfGLrclXKDWQ3GEcl5X/l/MaJpWwgrcEW/r5YniB?=
 =?us-ascii?Q?jv0u0LQeHRL+t6uc5Xl9J7nPzzn4l4qgJDNfTQCx2i28oGwgJNqvF0b7nA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:18.0164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75149ae7-2d9b-46f7-bcec-08ddca0edf4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDA9B3771F

To support RDMA capable ethernet device, create an auxiliary device in
the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
device to the Ethernet device.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/Kconfig         |  1 +
 drivers/net/ethernet/pensando/ionic/Makefile  |  2 +-
 .../net/ethernet/pensando/ionic/ionic_api.h   | 21 ++++
 .../net/ethernet/pensando/ionic/ionic_aux.c   | 95 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_aux.h   | 10 ++
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  5 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  7 ++
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +
 8 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.h
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h

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
index 000000000000..781218c3feba
--- /dev/null
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -0,0 +1,95 @@
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
+	id = ida_alloc_range(&aux_ida, 0, INT_MAX, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(lif->ionic->dev, "Failed to allocate aux id: %d\n",
+			id);
+		err = id;
+		goto err_adev_free;
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
+		goto err_ida_free;
+	}
+
+	err = auxiliary_device_add(aux_dev);
+	if (err) {
+		dev_err(lif->ionic->dev, "Failed to add %s aux device: %d\n",
+			aux_dev->name, err);
+		goto err_aux_uninit;
+	}
+
+	lif->ionic_adev = ionic_adev;
+
+	return 0;
+
+err_aux_uninit:
+	auxiliary_device_uninit(aux_dev);
+err_ida_free:
+	ida_free(&aux_ida, id);
+err_adev_free:
+	kfree(ionic_adev);
+
+	return err;
+}
+
+void ionic_auxbus_unregister(struct ionic_lif *lif)
+{
+	struct auxiliary_device *aux_dev;
+	int id;
+
+	mutex_lock(&lif->adev_lock);
+	if (!lif->ionic_adev)
+		goto out;
+
+	aux_dev = &lif->ionic_adev->adev;
+	id = aux_dev->id;
+
+	auxiliary_device_delete(aux_dev);
+	auxiliary_device_uninit(aux_dev);
+	ida_free(&aux_ida, id);
+
+	lif->ionic_adev = NULL;
+
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
index 4c377bdc62c8..bb75044dfb82 100644
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
@@ -415,6 +418,7 @@ static void ionic_remove(struct pci_dev *pdev)
 
 		if (ionic->lif->doorbell_wa)
 			cancel_delayed_work_sync(&ionic->doorbell_check_dwork);
+		ionic_auxbus_unregister(ionic->lif);
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
 		ionic_lif_deinit(ionic->lif);
@@ -444,6 +448,7 @@ static void ionic_reset_prepare(struct pci_dev *pdev)
 	timer_delete_sync(&ionic->watchdog_timer);
 	cancel_work_sync(&lif->deferred.work);
 
+	ionic_auxbus_unregister(ionic->lif);
 	mutex_lock(&lif->queue_lock);
 	ionic_stop_queues_reconfig(lif);
 	ionic_txrx_free(lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7707a9e53c43..146659f6862a 100644
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
@@ -3532,6 +3538,7 @@ void ionic_lif_free(struct ionic_lif *lif)
 
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


