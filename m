Return-Path: <linux-rdma+bounces-10132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B35AAF247
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA554C4239
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB320F066;
	Thu,  8 May 2025 05:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cYD9B/Vq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B4A7494;
	Thu,  8 May 2025 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680449; cv=fail; b=Mp5mHMTD4d0OLXZDZ0hEX8nq5tdJ7OpWcFGQA3qAcdhXE7D7WiMtlTDBIycQU3umMX6VVXycEEAJbLCg8P4u5KQMZ5FmTHIxRvdBFY5U5HFMCn/5TG6zAGlGtlMN4QVB7/Gq9+jkFO4tjtABXsQRYQHymJ9flla/M4G0ihx+LVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680449; c=relaxed/simple;
	bh=iv3plnzg66NjgFzhb5AioRk6iMC+cAleeeNmIqk4Acs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdT3n6zWZtDxRbyK9NYnx1POdnjALWWtQnW0GDjQLfnxwHWgQ4JuocRL3CrvpPOl20FotE+DRbhH3YfV7qJBQdgj1poLqjwLK8sL8uihUTONdl0RonnTcTT4/F/YYQDkWh0K+b6PrcRHB6xXED0oE7yGKXbDVIvxmTIci3xzE7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cYD9B/Vq; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLlN4Ia93ExaQE+5pmp+gkE6CznsTGBGlrHS/jW9XRTEcfpHv9sanep4CL97EacHUROj5w9heHOJINePVaPhplE077oDjC1DsYI5P9Svw3n8C6tHTSoPes5gmdSx7hLYN2c7MmPBbykRLWw3F1zFjkZfV1ijzL2V6scIG4VyfSJP3/fh5+79SzoD6H+2aD5VuffMdGsaTPoTBmC5LKL3zIzfz2LVLFdU5bLFeEw+4C6inmub+zSznGO8JSukM/Pmi7h+I95+eSWQr/Ed49dbg59+qc5goXnNCV9orGSr4DTaTRd5JP1gUIK248g2XJvzli8Y4REEKwFmit7AmkBCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+t4xBBf1VckZFvP/4xE3rX7IvzIZEjPaD2r2Co/HJg=;
 b=xovX3HloTU+6zxMsHs+KZMPiLNVWhf/lrWJt2yJd4epFtssk5z34zL9qCJUaywDPvm8iX83hOEqPMtWg3hjgIQ+QSzHrM0qLEW9EHoc3t4vAuIoL1JlOC0bdSJVFNaefzqEm0h1mXs6+CkbcC3a2ysSmQ96RgG0PbA8vOjGEJrI9yy0RoK//fLKJ5+lrsvh4PCs8nwgFOkToQuEmLnTMWoCZBBeO3ED/R9cqsecvxo430gI7fwhKU9t96MmnlKJmmiXdD5tjZ33cKTJSln/IBqvFiydVOvgSr92kpoAdLFoVnTx8BmhvAPr1U86dVeO1KCnz1OQZfZntCvuARD7PJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+t4xBBf1VckZFvP/4xE3rX7IvzIZEjPaD2r2Co/HJg=;
 b=cYD9B/VqyfiWY92v/9m7Y2bwOlxR8luUw7f20asNONeX3GiOs2NFzxg7EE0p1Y/HTlDFNmouMOgtl2/PJgFJaav/86W5DtcJ/R1DHAR0L87C3qb1EY/WPzZOoiY7VSix+XowqZhaGb6+hZUpRxe9tBY0WDE4nUD0oKYNrP5F1yg=
Received: from MN2PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:d4::38)
 by BN3PR12MB9593.namprd12.prod.outlook.com (2603:10b6:408:2cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 8 May
 2025 05:00:38 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::15) by MN2PR04CA0025.outlook.office365.com
 (2603:10b6:208:d4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Thu,
 8 May 2025 05:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:00:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:00:37 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:33 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 01/14] net: ionic: Create an auxiliary device for rdma driver
Date: Thu, 8 May 2025 10:29:44 +0530
Message-ID: <20250508045957.2823318-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|BN3PR12MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: df7f77c5-0f7a-42aa-1f78-08dd8ded463b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I7+oSQuP7xo8VIkSuSqVcfQcMq/BvAmLRIX2rbWG3ql/dLh77peh6GKsEQOP?=
 =?us-ascii?Q?zDqdzyBsEWm4Sr+8AgyKn/2DA3jKYPNPhCJiQ8ursC/g1oKdPmRUdFa8HF+k?=
 =?us-ascii?Q?O82Dqp+EKpebiwk+3TLvEhtfmbZdvZzQc4xwxb4xwyR1eVCQqtr9y1qD25tZ?=
 =?us-ascii?Q?wpOoaKzHYmVoU/4z16UlbSC3vy8LQgKpkb9DkfttK5CGwkWDVV0iZRvJYgxu?=
 =?us-ascii?Q?c/TEXNjSfImFybb/2yVKnSEtpXLtJmz/m0+hujdhh/dAB/gHti2mymw9x4DN?=
 =?us-ascii?Q?K1OjaNQZSwAO+g6H0BAJYRouW0cIFad7GwuIYTkK8ruWBqBZlFBe3yS46u26?=
 =?us-ascii?Q?PQyk827L9QkCjYdASWJB/ofTDVlLs3wn7+z3KbGe3VL1elJKnoAQq2OoVV+m?=
 =?us-ascii?Q?C+IO72XW7VzbWqpA5YztfB89unEXDZb2wPUKqV6Bvf8EVFaAZ40v7gdkxgBa?=
 =?us-ascii?Q?bqKrb++viwxnHqG+ku9iSRZnTx78/DSovx0A4TnzalUkhIqJ/OHojjz2r9gv?=
 =?us-ascii?Q?hBe7EsTOWgvtQLMCxQ7i3TFGN84yaRwCu0sWwz/KARpVVPndcXdLIN2URpL8?=
 =?us-ascii?Q?3If4aBExT29i42yPIGR01MDknenNvPyfUYK+xmd/mbPA5mQt6bMuaP9YXgvC?=
 =?us-ascii?Q?OX1+CrMLrH/fG/2RszlDbUor0HtV/IyrtUJNcz+LkQqe95phov+NGoMRZ7ve?=
 =?us-ascii?Q?PGijI7LQyx/OcplNKhmGRfvyHed008jq44eEBL5nCUgTdFmV8/BT5efBLzBa?=
 =?us-ascii?Q?/5T/A+xYziSgFOnoj1Jrl5hGOQyqx65jidMJztAq4uFDhMnIVbrDd2uSaxpC?=
 =?us-ascii?Q?Kxo+8YS1RgLmeSShXYqwKkXA612u3i8nOyyS79oAhpNbWMdyuWa3DwktRix2?=
 =?us-ascii?Q?XczvS4VvgVfSbadPu5aIV0jehkFhP3Y+KAp+sVtECHCy9J3QTPAVKwB00rtY?=
 =?us-ascii?Q?mxIx+kCxq0VczgNfEozPpJMA65ydoejay3ChIEO18BN22+QH4JcJS78FATCW?=
 =?us-ascii?Q?w8y5PJ9wHOodcFtEdj/BYonkThgO3LgdpiaDMinvbmwppn5+evBCeLJHD2oI?=
 =?us-ascii?Q?O6ksJoI2mi5Xg+W5W8MwJ1xb/IojchVcHhVDhm7bKvmekZozSnjoADsMgHeC?=
 =?us-ascii?Q?alJlXZKpKsC9Pekz0Q6RZ6fW9jchjEdyh8eaLkFH2/L7ZbazETBxoM3L2sZ0?=
 =?us-ascii?Q?CjGfwIAu7X/uNqKZKNRlRw1RKuequTwOuXc6ONt892J/fT7+AYOT8zJhL1K9?=
 =?us-ascii?Q?IdEFbJ31T+4Iq/Nd3x3X90jUnnKU6+W0V84IfdRL4CZmW3sTcYoCBz4ZdFmW?=
 =?us-ascii?Q?tI2woOLJoGePCu8e68ao5upVooi64b1DFjUU4RNsGu6Ug7FzCD9ky9NE7aJR?=
 =?us-ascii?Q?FpsMY9sIT5yjj/QrMXhk2BRqPfKjdXnAJwVqAUDNIxI7L2E6JxWpKT+n1xfQ?=
 =?us-ascii?Q?HYik6zOyyY3ZU2BCtx7thaNI5d3cL2OhWrnbdAOXF//sy0BZnwtDRRtdmBDN?=
 =?us-ascii?Q?zY62M20I2dRNv+lyhGxpl8tjffwkdE4iU7g6unAzAa02vxKI+S9o40pdhA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:00:38.1076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df7f77c5-0f7a-42aa-1f78-08dd8ded463b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9593

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
index 000000000000..ba29c456de00
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
2.34.1


