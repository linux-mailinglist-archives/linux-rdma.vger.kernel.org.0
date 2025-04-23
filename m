Return-Path: <linux-rdma+bounces-9717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B5A9875B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF961B66546
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A32269D0C;
	Wed, 23 Apr 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jpgo1ZGf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140C25CC6F;
	Wed, 23 Apr 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404244; cv=fail; b=M4W0asghbJfW/2lqEMxTU2+cDrvjg15YeciBO6J4bOGUkiYsUapYSssCZxPpOCtH7T69FsC4OQber2iFGoee7Ui5ecHcMIQ5HtURzIAEF3ow1AmgPJSLssIFwyWjlVo/VaxZ04p1JfMUlazD22SGXougE/BQarsj+99M6nIMKXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404244; c=relaxed/simple;
	bh=q/Hj2nFBD6xaIe+LAInz9hc2GraCi37ELJsQ/1VBes0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7k4jEvZfKKUZnJ8TzY4rCFc3PwPIqfvoBEhxPynlhZu3mq8gcVYP3tNk1+FhvbeoEhL6lITtdmfLysCPh6TB95q8HRgE+YTNhfeFnBcO2T7WQ768E3AR+MreenxAaL1ociTzBV6Jnku2gNehvOh6IvQNAniZB4cFYl6bGeFKn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jpgo1ZGf; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9DkjPYnvqZI7UNdKyHUHsZFosmIeEVhYOuMJTl/m+wziSjxtD055SC18gf3niDfsdWWZRftqCZ61BGP5JnMoyr0kwPNV5jWoKw/PdAPMpydnvUyQJKioXATpjPyBhSMVKMIW3ayMDc9qq7gDsjVxU9xYqTTDGUyRFI9gBYGaYGjmoP3xV6VFdPD8dIhbtdEBuoqTgxcDJ0fgJaeejrMSFSasl9wSb/HsuY47nWSJxvE13f/OYQzO6+5NvTw7jjHwQwpG2u+ZlvEY//bx3EyPGLeBQ0PRlekmVnA2h5ETJmq3lnKoGlbJpsgKy+SA5uGs2W/Jt5jIIc2kYwHrKw5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBVeD7VBNOEfo2Lwy8BWaC59r0JSL5Jy6dH28GJDcD4=;
 b=kKIEnJxnlneTDu9SPWr45TGiqnyfepjrZce2LIUrCyE61LFSMkkiVboOqrSPuymGofySVmqJFfMn8KqAsJhjIZrV5q/d3drPsn8pmdEdfL5SoFsWhKJr/JUkarXTQ1t3GvUSyjjvsm75dydHjRTB/OEnHVZcZG1j7XiABfb0ekmLbNVXtnOT0gpohcPKjb/j4MURYVwNmpL+sG/GlYBzX/Inp1RYjRAlll0tGdfYqHM9/E/7pa6aEfHOQXPviphdc1Ug0Yr44lmDbSfdP3jcV/cFd0TGglOZtApOBR3wkmBLu3m9IQqopma28wxDssL01pU5HTq7RhUIz2EYsyrxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBVeD7VBNOEfo2Lwy8BWaC59r0JSL5Jy6dH28GJDcD4=;
 b=jpgo1ZGfjyjPPbz8sFQNO3pfvhIbvw3Vsk6N8yO7NFIYf+JHRwfzqRyUM5ucJ2QTVzVnA+lyueisPdXu78ZrRdIdvF7vnBt8SMSPYT80LHe9JSk4slUZo0NGuU0oUTtxaBEOY8k5Dg2mFH0xY7LrJuuWtL9hGKCJFBmkxSdbfCM=
Received: from BYAPR11CA0060.namprd11.prod.outlook.com (2603:10b6:a03:80::37)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 10:30:34 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::bc) by BYAPR11CA0060.outlook.office365.com
 (2603:10b6:a03:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:30:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:31 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:24 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 02/14] net: ionic: Create an auxiliary device for rdma driver
Date: Wed, 23 Apr 2025 15:59:01 +0530
Message-ID: <20250423102913.438027-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: cf718a48-ed3e-420d-9d13-08dd8251e103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DbRtCJgw/fDnXmuzdssf8hYfVFBNfKHRcEZU8Hj2FPKdy9kY/g8KPcwFZgPM?=
 =?us-ascii?Q?UZnrDBLpz6JOwJ9oTDf72IQTYqNuj8tsFdjLpj98kat5IpieqHpEcEBj+GaY?=
 =?us-ascii?Q?qJ1cr+9RKXxg0j3cd/HRWFb1vj5x0zKYAowgTUfFk/KmRX0FeFhBhFguy9as?=
 =?us-ascii?Q?atfCNcJRoMRv9k7hhKDMiijNbsaIX/N18VUG9vpUYjQrpOykGiTd33xMtHxG?=
 =?us-ascii?Q?KjYZ0urzK4ujf9vi5fY0OXLOUKnOg6/sKx17CxA2wj8bN08xCy3yEbwyIbiA?=
 =?us-ascii?Q?DH6FZ96CHSAyO7LNcsLubECiZPetgn/asuDtEalEPnQVOxeRFIX5jEtP95ji?=
 =?us-ascii?Q?T1WEXFzVrhXTeMnsVciV/ixsWk8DLwqalAZ9b8fAMJr9pCW2yn3m8vM1NiiG?=
 =?us-ascii?Q?D/bsqivxHziLsq8l/jqhXmY32wjXJ5mePP5U9BnqhSZuHtHtnNzaVDSdpZnL?=
 =?us-ascii?Q?Vs8s37sJILziyqSQhVCXf8WReuPfsVh501KwpZZsE1vek2z7/7osL8xxzNjd?=
 =?us-ascii?Q?HSJoc2qAJfVLxfcHhTLrxjIFf16/xdUe31j35TUGk7owJQFnx4wqNjuem1IQ?=
 =?us-ascii?Q?t1nvYTNxCNlsdsFm5iXjqTiprMJWZoJxzvcfzUoBeVYriVy3G/SSSO9rtL5/?=
 =?us-ascii?Q?bjYA/DA6t7jB0so5CbIah2jStWJ1QZO+dXKZ8rmPf8ZY4BP13T/AQGLVq0Tk?=
 =?us-ascii?Q?gJ2YBComme0FvGJm8taACE175clgWlpytY1UDioF14HCKRejKWBA/MoMW4kq?=
 =?us-ascii?Q?eu8f6Nb0Ettt0ydxp4obzQ4bpC4M+TN3PkBTaPDHe672VnSrReHotgsTQvbS?=
 =?us-ascii?Q?bY1whQPBESsPOtQCsHpZ57hYJfAHIlohgmGAMpA0YQ+9o50Ejk7rBU+U7BCt?=
 =?us-ascii?Q?fEKUm39gJWm2/smn7nEe7foYWWakCQLZMA18O4FIY0vm0GVv55LE/2QnZ1o7?=
 =?us-ascii?Q?OsUF4PEaCPSoMd92YslTCcfmIqC0GG42RCSLbivOWZCCsYAoGagQvjQdFpDF?=
 =?us-ascii?Q?EVHVEWZocrstlA/TG2SlTr/qNysxKZF9QaO9xWgfZ7gURaZetwQnjOdv8Cmc?=
 =?us-ascii?Q?Bv45UMjfTDcRoMw5lACpbq09sc3BfZ/n8jQLUDohgxF/0U30ZHh8rTNitiwE?=
 =?us-ascii?Q?X0CpQuEh4rr3EwQQNDi9fHPyu0m439a5Lhy6t5Qqm5sBrlBs+OH643sn17+x?=
 =?us-ascii?Q?cMWljIR2zpSB9EvwmretKUOb2Dxn+nsZToRS746BV2ONhCqh5PoAU4u4s5qG?=
 =?us-ascii?Q?2R8AuzlYyqM1UoA3nd13rqmBEwMyo9Dw71XLPWJMF0lJyZHiftiTzUZbGqU5?=
 =?us-ascii?Q?3RQI4dzMjcPXVAb8jMsPICyU/WmoNLOFv7UWtVT3zEMIxTDjrjeOAhJA+hOF?=
 =?us-ascii?Q?I0akpTUVXaFYI6P0HWB3guMJRRqNNfCx25feWQJDTA7n4IFnfRqfunF+QWe+?=
 =?us-ascii?Q?piiq9GwlJZX0pwynEqZGELxzdIf5WE4Ou1KJjTr/aNPVkkLno61Yru21MW5e?=
 =?us-ascii?Q?Hkyr0+TDj8NWSykHYjcX16sv9MYUaF8YSmU0GgjzCHDhfGthr00ldLOmUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:30:33.4144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf718a48-ed3e-420d-9d13-08dd8251e103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

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
index 000000000000..a7e398e1de21
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
+ * @handle:     Handle for this auxiliary device
+ * @idx:        Index identifier
+ * @adev:       Auxiliary device
+ */
+struct ionic_aux_dev {
+	void *handle;
+	int idx;
+	struct auxiliary_device adev;
+};
+
+#endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
new file mode 100644
index 000000000000..f660ddf9e6c3
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
+	if (!(lif->ionic->ident.lif.capabilities & IONIC_LIF_CAP_RDMA))
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
+	ionic_adev->handle = lif;
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
index 0a99a72376ae..e63ed91879a1 100644
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
index 05e9a931ef0d..333394e477e0 100644
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
2.34.1


