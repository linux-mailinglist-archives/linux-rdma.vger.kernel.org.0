Return-Path: <linux-rdma+bounces-11569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6EAAE6453
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E3F188C650
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94660291C2A;
	Tue, 24 Jun 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fbQNXq03"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98259291C28;
	Tue, 24 Jun 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767221; cv=fail; b=qKsgX5YQnu7/PJb2DpLWN3kpH7cosYPRle3sDOVuCB9HODJFrbUCH5wiCo/yLMOyA96Wt4/Fd5AO+9Wp99bdJ0ZNXi0Z4K7VlCW2X5lFxqNB+pkoDjL2rZ9JrbmkdRofRTSr/B7m4c4BPLnJ8F+P6SK7L+MjIRRAJzM4coAa9ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767221; c=relaxed/simple;
	bh=Uk4Tp0eixEBxkiSXqQqyj4UBFh7RRID32avXeJ1wydg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpancxuPPgRG2qqbSJyMe9jCN7Bvfm+q6g/1j/R0kTHb0qpD/8+LWsKwBZ9YVLqLeCQ+h16IdS/pnvfaSSakANM4Gy2WZRUM1rP7fYp4SoKhODUM5UKYfucI/0clnP/zkFuli1Wznd+UigeMF3OfVAkrNQynyL1E7SLTFQkM+f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fbQNXq03; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRHul+zb9Z7Bd/A+/RnbAIhWzwFXEEwGVYMuh/Dppu6ngp0LVdjVywn+WSFlBYkX0Uw4B1q55Se/CA3rFEsK4K0K87mql7AXthjhRKDToB76rIC7cA2LelYvGUE8AVCRbZ86d/50MU/6Vw0AbEeEvEk2zARnuZccMw2nK1fy7moaTFvfeckX5KcBhl8rwzJ4Uc6bnMUSCP7P74lw1196kr38NEixhUSVfMAL5EJRc/mwgrnD0sfZ+ZZKknhWmDJ/3j0jvwy9XmAr25bNoKHfgdeT4xFOx8CkFcDROi5ENgNiUSSF9CljYlZdrirfXVQuVdW7rQ9E6h8BwTHD2iGmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZMfsuqV9rzJVJCm+mCMO489ht3AwPQ7DvJloUHAY8c=;
 b=y4nE+pzDHkL0iFY18C6WbYUxBPnIQ+/dFlfqV0Q44MA6Cr3S6idE+inVi0ee9NPqSTK9mxUBRa9oN91EP5pNNT9HTpZbExiVN1zFY02YBUtNK4TFoDmtOB4T0HMz6WdWRv7cuih8S7cYPOkYkoT0R9TXhY+og21F16eaPl2rbv+odDyrAiFiJFe7KFMmL1um93XTQH8WV/ujJX0m8bG6ws33UmNEOEjqGwFM8uB5bBarWX8R/K4dKb7Jt+ZnPpCS2/36fuo089NnZORFtZ87k59C6/wZt9uwzMout8jKGnXWmLOqvUhR5XcY05Q199TPEr9ruQ4WGcwLVGz4cCERYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZMfsuqV9rzJVJCm+mCMO489ht3AwPQ7DvJloUHAY8c=;
 b=fbQNXq039/8F0Dj5TjXbCy5sMmQwJ9HYiOY0gF9ND6lylg+2oaa57/FcUsqjdpT0jTNd/Ao1r8gxLl0/5Gjo8Mh1Zj4/Xw+eT7r3o3Znu5424dY1ZasO1FzQdH4PbWMY+gj2NF9hLYymw0+ktqPuzpOAeunMkSSdlycqB6BA6IE=
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 24 Jun
 2025 12:13:33 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::f1) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 12:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:31 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:26 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 01/14] net: ionic: Create an auxiliary device for rdma driver
Date: Tue, 24 Jun 2025 17:43:02 +0530
Message-ID: <20250624121315.739049-2-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 4290036f-404e-4146-2dcf-08ddb3188969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CbXb9sM8GQ3er1EQaOJSqrDfdwAA4qJIdjSuhup40MaMVJDpWSFQNo3E43Qn?=
 =?us-ascii?Q?2r3jsOSKSctOzP6NKDwEymu/5CNZORCsELPmpvj9AnyuFbb8zAKEzw6gkBAZ?=
 =?us-ascii?Q?ulxthMjcDH9qUXddQcBwwxOvDI/wFDAGw8G7ubELt1XCzlVtF/BlidvBVkML?=
 =?us-ascii?Q?82s0zM1fvHynhHa4bO83zFfVHeEvIRPR1uWQ3itAHLtOnOSjl2+AcZFa3QyR?=
 =?us-ascii?Q?/QePBloaisl7CzhkuRYSEbZrNE4cm5eoBG8z6b0MVNFirtDgLx84IKG24XRP?=
 =?us-ascii?Q?iz7mkAHuw+jYlehAG30VQKqof8TLLHVlSih7gQuwHgxvPoa8vPqpmqOCZKY2?=
 =?us-ascii?Q?HwLSPJ+lwfm8ItCj+6cQLU0lx8Tf64Lv+vM1Lnkxy9maJjs2/DiBUmo9ad5s?=
 =?us-ascii?Q?RFEvUh+VSbi4ajqVgkJuBiFyvPKR16daicYqhmp2EjMnWtvLKesmIXrNBfbs?=
 =?us-ascii?Q?hngNGXM+ABzoj0bmxa7Z06z1U0WU8yB53tEFJrn9A6OPCrBtq0XGYFa806xK?=
 =?us-ascii?Q?6ZOIKWb3R/qf5zSXBegkvBLXOi1D4uHrfMQ8fIYI9hrX1VFkZvbvPKTDNg5G?=
 =?us-ascii?Q?QCV/ER55pUgNfsM8ArHOMPCyjtATPd8ODWL8WeRfHGEg/j0vjWfd+MoUyJjY?=
 =?us-ascii?Q?b3qmxkqDAWa2g2Ke4gqAGnMrWnohcFbeUJAJdazxtHEAC4/XOg9cRn/gyKFG?=
 =?us-ascii?Q?bkqG+P0g3Tk7yfGekz0nx54OyhyZvmDNaexj0zVu07EyquVgks3bxY3v7S1A?=
 =?us-ascii?Q?BOeKPf68RA/8pUtRMqxe+GRX8uklT6SbWJhkY3NKKXP7WadbBzGsy2fJUaUn?=
 =?us-ascii?Q?WoY1HOAwQuEPuqcsO+6PiWeGh6pBxdPuWoMQ2m65JIsMXk18GfQp56EdjJJB?=
 =?us-ascii?Q?c1rBw/MztLA16vOO7MjIFgRVi2g0nJ3Pf95/DazoKYTyLO2GT+vnDz7g1kZ+?=
 =?us-ascii?Q?aAIPDs2199XrK9NM+Mnfgu5ui2mN9fQBb+Uuo2ejNhCgc1lW+KQBX3/3w4i6?=
 =?us-ascii?Q?vsyyr4XxiVEYlYDBnkJAmLu478Ard7gPCb7k9NkQ5mnJS97NgA32zWFEpprT?=
 =?us-ascii?Q?+/o8MUA1mVtuEAV/vhX6zKdGOwHw9ZcLwyrL/OtUSFTpdxWp1gShvfkOmEKJ?=
 =?us-ascii?Q?Xr/RDVv9Yo6cWd5jXgmdRXDNzt5jwET3Fmf/aFE6HYcEl84bkGXc+QIZ1Hb8?=
 =?us-ascii?Q?xpX+qXgEiGTaxKYsslnfKOht2NrRiOY19JRvdGCX9gvFbCmdKDkzPzEqzDlA?=
 =?us-ascii?Q?LVyTeaAsZadmsdaVNNoO569jQHHouIBIwM0HfFtW+JVZFuf0TXNLDMqZs3rZ?=
 =?us-ascii?Q?6k7LFCOhKti7HBWjMozQd0E6OW3GaYNgnUCyyVLBARKdkoQ28wxVu/IM74oQ?=
 =?us-ascii?Q?jf6COePFKRj26EA3GFHeXBuFg71d9/dW9uSMVBOizI7HLnzjvISAH1laqBtB?=
 =?us-ascii?Q?XQ+oCXebYJThssvnaXVrmIFmav9wM6fViaPa+2T0U4N4a9uCZaCo0ynaX89S?=
 =?us-ascii?Q?B4nncf6ouWEXvuZvcsOoPji9/VGII8ViBFO7CQs1/TJuxdWqf56OBkmQoA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:32.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4290036f-404e-4146-2dcf-08ddb3188969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

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


