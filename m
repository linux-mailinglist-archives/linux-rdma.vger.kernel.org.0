Return-Path: <linux-rdma+bounces-13048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E0B414DA
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82F717262E
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD182D8368;
	Wed,  3 Sep 2025 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RpfT48uh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F022D7DDC;
	Wed,  3 Sep 2025 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880251; cv=fail; b=dVHnBcgYdBRXJUPNQ0coITrm7OoWpmrY0akrKtiADCoG4uJC+XLjnyYEqe4KeK8oLMbonEkHSiG2WeFDeBd3uXwlDHH9uvaYK8Xm4RyFnsk1KV/arvJWI5Z1diraImHdnqT2hVr5YZa6D29xI+kuRrqF8fPu3qr+07NL8tA7WJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880251; c=relaxed/simple;
	bh=8baS+8kNkKKysKNbtC6ek054hR41M8i+R7PIIbBvjb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXVugC/+AlBad4kLuE7A/vA2U4Iot1S9LZTAMUd0KPZ0b/69OUhXiPv5B6G4pkJmb3jxFJjL4dJjZKlu+dE+PVmn6Ux3gnwTwIEOpCU4K7Ls96DKAKuffWjpgyXY8/zsbrpgfRnO2DF56BeA+bpukMg8SQbgpt3pLob+8oSmyDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RpfT48uh; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZk/ewr7NGcjtIRPr+xcPg4AxSpL9IWvHZ82/ue8tS/2oaGNqbA2GHyyQFR45KelfCVlTKEI1oojYu61Qir+UCBnxW4YMVm99lbvPQoePa3guRx698PIfyFXCTvgLkQ+wRPtoiNzWYNRFshZZCmmgajY4/dPx3JSgJtWE8FNngi6IPbw5SDX4ewBKFJf0t9OlXXdBvi4YvHGr+KPYQsXZdfEn8T+LoKQN5JjzWiyOE3sXYeZCN7DL9gw82Eti5SErJBQhZ0Z13pUfjSaVSRieELqQeW6kKLTulkSuuebPqwpUjmnXymr9sEr59BXIraGYF0Xc06k+Eh/R+EzDPYX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjoJ+wT79wex1FVBIMZn8v45mKl9PpTMNBBYTO+QRTo=;
 b=me+R9BJkZ4KanXUx3TDWLQoGXRmgJtzkCV9rKSZwdPVPtNTUvxb0+WOJta/c7jrYNa6L4UqedDyLMNEbwM396tmRVDYQMqGhCO452KO6bNd+cAZx+jj1q8cfBNPtZ/fh6XT0U5M1dRTbw44vXjEBdpRG81nM1rq45PseuUGxC03QfjhPZzlk6WVxARuAnvtweJGb8C01bhweYCNLqxgCy3jkfSZOp7hBwqH0GXjnxlQhD4Zvp1TVCSJeFOhhYUnwR2ZFwHnMuSadOGQ7gZhfzhGRNCTB43x/3dPBaSd1Sg5ICSStBcK0bBiDWyh9LM4x6rtN1PVMOHWwiqqihgBtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjoJ+wT79wex1FVBIMZn8v45mKl9PpTMNBBYTO+QRTo=;
 b=RpfT48uhXEQMqR31MSRv8TtSyoxhZwy+DljMf/6s1mhpMQv/OkCUp+dB4hUdgTOnmthar1cQXOJ2O8baObx3apaOXjuD0u0E7u8PwAYl4Q1Kdrjhm6YZVXX8oT+nApfQKsw1+/DwE/srKZsm7G+UXSrFM3ohveJLiekJit/EjOs=
Received: from CH0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:610:b3::9)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 06:17:22 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::6a) by CH0PR03CA0034.outlook.office365.com
 (2603:10b6:610:b3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 06:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 3 Sep 2025 06:17:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:17:20 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:16 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v6 01/14] net: ionic: Create an auxiliary device for rdma driver
Date: Wed, 3 Sep 2025 11:45:53 +0530
Message-ID: <20250903061606.4139957-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: 9019c990-5bc2-4de5-ebca-08ddeab18aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BBm+NcH/R3SgDba47f+3aX7MiRkzJEMccugYHZ14w2yMCrmsPn4nMhwH4F+G?=
 =?us-ascii?Q?thS0LK6Cqf1L9tVjSI7iQ58PBwp3/8qwws5lyr23g2Klr1a60IHkRrHVGEoW?=
 =?us-ascii?Q?tvfKaDEOPYZZ43YPgnlq2MXJgFm6i21tgJhectKDwEe6C+29YaD3qet5xQaE?=
 =?us-ascii?Q?kzwCr7swU+yxcsor+RxWmL40j7delJKBrcRn1iAg0WLwBX6t6FVwIuxM94a5?=
 =?us-ascii?Q?Up9Lt0wyLdmm8oVS1Pt5yhtEbSTn8vwa8Ts6rSO1IJQKLR7gj2KB6Xj9pCw9?=
 =?us-ascii?Q?/QzTCvryFjmwvNlmzGIdV6sJTjPmtFykZwXWKkF4j71xeaAVudKAdUQu3Pox?=
 =?us-ascii?Q?Mnr2jiYiq2WYMDjTsG8VKLfkKSpl940qAw12e76dNu6hwIzd/fNc2tf5ddH6?=
 =?us-ascii?Q?3jxX3zGJFjzJirXp68YikvmOtmDlxyRb1G/kjJhJhUNHvg28gzAc1HO4GVpT?=
 =?us-ascii?Q?ZgukKMQDnx/tMopMd8XzBejTdXngb7VIVoZyOwAfkCYZOG8hW6FM63a5f07U?=
 =?us-ascii?Q?rtuFgjlws+Ka1THjeyhmMXrBWFmUtq3+5HvguOKdw+Xxt5itpCKFFJLobNHd?=
 =?us-ascii?Q?csL3/Q6Pqj5RSw+e0cRAfbdzcFnSlwdNZ7jf8eBQPY5jn1IC83+dyeG3aaNn?=
 =?us-ascii?Q?WOKcS1MFj5/TxdD1uio1AXTvQIm/wrQ6+CKmD8z+WzBkZeXiXTNn+SBUqHVM?=
 =?us-ascii?Q?QHyLN+FGw2CK7UwhKej+YpcSZ3oPZo8DLZBjiqcLK7rm2sHmlUPuZ+4OZxLT?=
 =?us-ascii?Q?MZw9t2/+p3lq1CrFCzXhGqSbpsIOWCFVEJ7teVBkMop8PG3Q2LMof+OfxwH9?=
 =?us-ascii?Q?/+UkLIJiIHnsU98I4Gl7SGLVWG6hgeYpUD2ZTmIkCafGkzwYw70mCGllnceL?=
 =?us-ascii?Q?8pSsjy/QrD7yQi7+zfKQurW2WglOZCkXn+YHbVoZNOTmsdqGqsfuJl0GCNUV?=
 =?us-ascii?Q?lU2LspMiSskUnnoVqHOFTDkJlSxnsRhlhVNpFl8S8hBdcgVfTL8xhUSlAUjO?=
 =?us-ascii?Q?fLdXKtQvm+pxB40yEfV9fsuXtncu2qaDXCMhL/4WW5lOkef48LpmqNj05NTx?=
 =?us-ascii?Q?s7E/HdmJPl6Jy5cPZjQVAwdjcIWi0SCIrryTyrsS9gprz+Iuy7sf09vBCpfL?=
 =?us-ascii?Q?4OjEo+bZ7dmnGIR/2Uf0ZmDOFyz2rIhkkXSSZoYhUzjp9oRese2K/aYJXtqY?=
 =?us-ascii?Q?jITXVDx7Nqf3PAUaOGJaSdyTRdVmzHeb4peKWRikQCSbz90O5FWAH1vZ4IX6?=
 =?us-ascii?Q?yNo5yVeLtOqzSYgtDDcmrXzta09UIOqEB7N9bmchF2duCoy0OEKUH21KOCjg?=
 =?us-ascii?Q?ntCGr1A1dPI4Xkjq4sTo/AXiBMqLavpUmSIUFoEmfCHUAeycKnRKwFxrXtvB?=
 =?us-ascii?Q?rEv8hILXpZnGtYasa8jyXgxDsIlzrhJyoRcKuW596hDr/hzpXMl+dRxH9nQa?=
 =?us-ascii?Q?JY/RU0kcETkZ5JW+2QCn+dSNmy3hpUAW9fPznjKTGVesS1qe9whgZkfE+Pub?=
 =?us-ascii?Q?Q8VyXTsxmQWINer5k7FfQrHQWl1QfZmsMiwE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:21.7010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9019c990-5bc2-4de5-ebca-08ddeab18aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119

To support RDMA capable ethernet device, create an auxiliary device in
the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
device to the Ethernet device.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v5->v6
  - Updated documentation
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
index 05fe2b11bb18..a0029b6db31e 100644
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
+the ethernet driver will create an auxiliary device that allows the RDMA
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


