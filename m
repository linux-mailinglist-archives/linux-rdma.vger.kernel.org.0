Return-Path: <linux-rdma+bounces-9723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C823A98777
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956D07A241B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED7274FFD;
	Wed, 23 Apr 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DPqsw/rV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E426D4D4;
	Wed, 23 Apr 2025 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404286; cv=fail; b=i6Xo4OXhhAvlGfJIW9JePITzShJRGn5y06+b07sjbQ8RN24IFh2jBun08vgQ76hiD3Utm2R6THp+PKMgadHub1aXFSl0MRn5Jj0gzk85WHRW7/4qZev7IB0GU8q9418G6nQBUkNgmIcA7O35kxW1kmxylQsdbzYoJIsr8eL+0u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404286; c=relaxed/simple;
	bh=g6RnGab8Syl9GrA1pOdu6VwhvkPrKQrev2jPPISXRMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7Tpe5ARyuveJAJ16qV3dkLNagde9FLig9lDhKRjIEM6+gt0+IZmjFwjpa6F6buYGK22K1AA4a2ttbikAaqndwfMqDH86zZlEjwoy8sT5mPKIRS9ASQ2/GQ1K2mmVJsbmheUd87B6TvdLEiMSWHa/mr/hBKVDwg80GNYWLQ/oI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DPqsw/rV; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esj1RO2669Odtud4s/X69z+GmGmgl9MdNXrEw42Pea2Zqr3oxfuCT3BPfYhsSCLY2xQGaaVXdEJjCiH9nnfm/5pB4r9oPXR0NPn0lEGtqYEhfGGIefT4tborcOM+/k7Kk1PG8pSGFSwoiXcGgQ9VPILMcPiuZmuzPzQJ5c2smGfIigXReONNtnhmVIMlPP6xIA+XMR54/LJ/aOBpg26AaLLxyuOZFqtrmSfYGsLqVG+JjMvuP6JvYWK9rORABxYwTblv3w0V0Jy3ZvH3PfdPvixiPOFNnHc+yuLpgJgHVr1qunkgwubDzRBiqkL22ApGCadIwoQH+MZA3BsCMxZcFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCXGbtxXgN8s10maJ34nMfp/yMCr8xls9k+woWpgmOI=;
 b=OfeIEWx+53YAjxzYukv4nAdrCDYhZjH4uQA5bwkXvob6NkexrPPU2OQT3w6LpRsrA6X5T8gO1He2svoaRAwp4SgMzSl6RGyVkQRkipG+5JFiUsD8OlYGQ4yE5EW1D16ZjcmbtlBz7h3bY274GV2rc3sWpXD6F/I4l8mAGzFDXfme1TAl1dTZ+ncQdoU4kDd3/uH9yisWUM2n+vwSkYLJMh8DMMHYU0MXPVJ9EBSZtuAa78trydSdPSIIyvdar6asICoF70RR9KFDt9DZAdZcLlwsHgxyd9wakIw/FNec5VosKwvGoWvg7MuSlTJwqHOouIqEPM5Y+J4Kgjgk3/wLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCXGbtxXgN8s10maJ34nMfp/yMCr8xls9k+woWpgmOI=;
 b=DPqsw/rV7JJ1ULFBlBm4jzG+Ey6UEhuYpmzeGLEaLGmZh4VG6jO1swUC6nQrNAvD3GanRXWKYKk4wSIlWSxj1uDtKMD4AFjjV5MaeI6GDaYZ2QA5jRueIGUfFX4+DavISBA9/tAPV1jCD4BSz/+DFIRES0zMGdnNznz3yITlow8=
Received: from SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 10:31:20 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::41) by SJ0PR03CA0172.outlook.office365.com
 (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 23 Apr 2025 10:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:31:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:31:18 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:31:10 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH 08/14] RDMA/ionic: Register auxiliary module for ionic ethernet adapter
Date: Wed, 23 Apr 2025 15:59:07 +0530
Message-ID: <20250423102913.438027-9-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 920c0a51-cfd3-4706-3bdd-08dd8251fc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wynJYj8/uu8a20ZIaMFq3uB1ljNNEUUfzRk1zZxkho4AMif8L+KyCIGW54X1?=
 =?us-ascii?Q?oDh2X2H7U5LOq6sNFTdba1i1gf7lUtjEwDHO7cEQ448JFBeob0KdsQanbDun?=
 =?us-ascii?Q?S6svdy7Az7Oazr4AodlOy9Yg0VGxUtHkkw0j15veWigj0xYFN6jp+wV5vduE?=
 =?us-ascii?Q?N4gE9bjE+6/7jNaGhLn6GcWcz4IsuM4KZsRwBjh5TX9rt/Nw+f6vFvLaVR4I?=
 =?us-ascii?Q?sRX0UvHTaurhfovXRKCSUmF6TQIDlh3X9tBH1kgfVMwODdaj8+IBHlmQirI0?=
 =?us-ascii?Q?iGH8RrGsbdY+6XZbAKs4P0u71PDi4k2jDRj7m+uS6NWYhv+XvS/5COH+LhFj?=
 =?us-ascii?Q?Cl/MgkbjrcoS6rQuEguRLS36DeQr1v9LdybTJiWEHdGrFNVh9doTcHeJt5ua?=
 =?us-ascii?Q?mrmUEXUWmsuQbT6wouoW58Blw6uwP81GqbbKyPUsMYJ/sO1lir0cDHw+k1UX?=
 =?us-ascii?Q?JT4mU0YQFn7A4aGcBdpor2bWUO/gaME/bVX2C95eVo8PH3cOExPXux4CCmAT?=
 =?us-ascii?Q?ZniYxCjhmIiVeb9naJk32Nripn6f93GHK+eRz2eymmMnvyKWp/spht0QaG6v?=
 =?us-ascii?Q?YMgDCvNsXlhM/T6pCmPKCPDwU7ynb36v6VF0f6yz6HYwH2MjGx/phwFcm9JZ?=
 =?us-ascii?Q?7jDowu4NRCgMw155L3tMRjZCq5pxRMuTm2KrJmPpdKSGavsPCSi7xHkMxG/t?=
 =?us-ascii?Q?9dihb0tPe8Q1nzoIQssuK0riMunLB+IIxZifZR+wN8TrN/IfhYNfQ3HuCqn8?=
 =?us-ascii?Q?f+BSmqgbo2T9NUxPGtRVthA5EDCr4R7fyeY/r3XmNk0Y0NNBUJYGIPg+IOEl?=
 =?us-ascii?Q?38Virk5VVoF1+KbzM0layWWkbFZoUj9dWzm0NrDnjRHrV55yefbmxktThqH3?=
 =?us-ascii?Q?c7itPVM53XWm0GLy5nTDLiMc/u10IfT1mSz46b+fauDgzA6W2J0tq9n7lnZl?=
 =?us-ascii?Q?SfQYRN4xpe4fDUg8J/9TZYtqH7Pr364yW9DWuBIpInui9YXuu6yPbGFOu44o?=
 =?us-ascii?Q?fa18uiyeDnhnEEFNkiJ/P+Pyx//gfawp++LppfLLIRfKyVL4TF1fMWbqojOe?=
 =?us-ascii?Q?NpzWiUAoGPER+yPYtGsnXVJhvktfLKveXo+3S47hx8tTuyrEaHNT/Wh43B3U?=
 =?us-ascii?Q?HcuXjfBI3DA2A32vgDGauAB4IPasIiROLO/Zk/JoWuYUD1kVtY9RXijEwMX1?=
 =?us-ascii?Q?W0UTwPlc60RJFkEMG9VKHTrQW8sruq3+Tcr6AucVzimmDlb5rB3i2I2sS714?=
 =?us-ascii?Q?VHtf+yRk0hPzY5nJAxVN024/8tC6ldq98moGSNEV2udVx5p826dm5h2e8djS?=
 =?us-ascii?Q?WGexZZhVlduasjahi8TeIfZi398Ewf2woeKuMOS9YQuOpRwsF2HXMqSh2c3z?=
 =?us-ascii?Q?oGJVtXGnzPtjKyU6qLTKq6+CACiENjJbu9JaBPR4BNVbUAJmI55gJLLal9u+?=
 =?us-ascii?Q?wiiviFpp9+47DWLjpL3tSOHri68TFCZrt+itOghjU3LyuyKwlJx7zjxkvCwC?=
 =?us-ascii?Q?z7c0PKEElTTDTzIxdz2AvPJbpFeeQTWSX/G385WvoiYD4KMGVY8Y7c0awQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:31:19.5861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 920c0a51-cfd3-4706-3bdd-08dd8251fc8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

Register auxiliary module to create ibdevice for ionic
ethernet adapter.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 152 ++++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h |  27 ++++
 2 files changed, 179 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
new file mode 100644
index 000000000000..91110dc08590
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <net/addrconf.h>
+
+#include "ionic_ibdev.h"
+
+#define DRIVER_DESCRIPTION "AMD Pensando RoCE HCA driver"
+#define DEVICE_DESCRIPTION "AMD Pensando RoCE HCA"
+
+MODULE_AUTHOR("Allen Hubbe <allen.hubbe@amd.com>");
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("NET_IONIC");
+
+static const struct auxiliary_device_id ionic_aux_id_table[] = {
+	{ .name = "ionic.rdma", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
+
+static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
+{
+	ib_unregister_device(&dev->ibdev);
+	ib_dealloc_device(&dev->ibdev);
+}
+
+static struct ionic_ibdev *ionic_create_ibdev(void *handle,
+					      struct net_device *ndev)
+{
+	const union ionic_lif_identity *ident;
+	int rc, lif_index, version;
+	struct ib_device *ibdev;
+	struct ionic_ibdev *dev;
+
+	ident = ionic_api_get_identity(handle, &lif_index);
+	version = ident->rdma.version;
+
+	if (version < IONIC_MIN_RDMA_VERSION ||
+	    version > IONIC_MAX_RDMA_VERSION) {
+		netdev_err(ndev, FW_INFO "ionic_rdma: incompatible version, fw ver %u\n",
+			   version);
+		netdev_err(ndev, FW_INFO "ionic_rdma: Driver Min Version %u\n",
+			   IONIC_MIN_RDMA_VERSION);
+		netdev_err(ndev, FW_INFO "ionic_rdma: Driver Max Version %u\n",
+			   IONIC_MAX_RDMA_VERSION);
+		rc = -EINVAL;
+		goto err_dev;
+	}
+
+	dev = ib_alloc_device(ionic_ibdev, ibdev);
+	if (!dev) {
+		rc = -ENOMEM;
+		goto err_dev;
+	}
+
+	dev->hwdev = ndev->dev.parent;
+	dev->ndev = ndev;
+	dev->handle = handle;
+	dev->lif_index = lif_index;
+	dev->ident = ident;
+	dev->rdma_version = ident->rdma.version;
+
+	ibdev = &dev->ibdev;
+	ibdev->dev.parent = dev->hwdev;
+
+	strscpy(ibdev->name, "ionic_%d", IB_DEVICE_NAME_MAX);
+	strscpy(ibdev->node_desc, DEVICE_DESCRIPTION, IB_DEVICE_NODE_DESC_MAX);
+
+	ibdev->node_type = RDMA_NODE_IB_CA;
+	ibdev->phys_port_cnt = 1;
+
+	addrconf_ifid_eui48((u8 *)&ibdev->node_guid, ndev);
+
+	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
+	if (rc)
+		goto err_register;
+
+	return dev;
+
+err_register:
+	ib_dealloc_device(&dev->ibdev);
+err_dev:
+	return ERR_PTR(rc);
+}
+
+static int ionic_aux_probe(struct auxiliary_device *adev,
+			   const struct auxiliary_device_id *id)
+{
+	struct ionic_aux_dev *ionic_adev;
+	struct net_device *ndev;
+	struct ionic_ibdev *dev;
+
+	ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
+	ndev = ionic_api_get_netdev_from_handle(ionic_adev->handle);
+	if (IS_ERR(ndev))
+		return dev_err_probe(&adev->dev, PTR_ERR(ndev),
+				     "Failed to get netdevice\n");
+
+	dev_put(ndev);
+
+	dev = ionic_create_ibdev(ionic_adev->handle, ndev);
+	if (IS_ERR(dev))
+		return dev_err_probe(&adev->dev, PTR_ERR(dev),
+				     "Failed to register ibdev\n");
+
+	auxiliary_set_drvdata(adev, dev);
+	ibdev_dbg(&dev->ibdev, "registered\n");
+
+	return 0;
+}
+
+static void ionic_aux_remove(struct auxiliary_device *adev)
+{
+	struct ionic_ibdev *dev = auxiliary_get_drvdata(adev);
+
+	dev_dbg(&adev->dev, "unregister ibdev\n");
+	ionic_destroy_ibdev(dev);
+	dev_dbg(&adev->dev, "unregistered\n");
+}
+
+static struct auxiliary_driver ionic_aux_r_driver = {
+	.name = "rdma",
+	.probe = ionic_aux_probe,
+	.remove = ionic_aux_remove,
+	.id_table = ionic_aux_id_table,
+};
+
+static int __init ionic_mod_init(void)
+{
+	int rc;
+
+	rc = auxiliary_driver_register(&ionic_aux_r_driver);
+	if (rc)
+		goto err_aux;
+
+	return 0;
+
+err_aux:
+	return rc;
+}
+
+static void __exit ionic_mod_exit(void)
+{
+	auxiliary_driver_unregister(&ionic_aux_r_driver);
+}
+
+module_init(ionic_mod_init);
+module_exit(ionic_mod_exit);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
new file mode 100644
index 000000000000..a4461b23aec3
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_IBDEV_H_
+#define _IONIC_IBDEV_H_
+
+#include <rdma/ib_verbs.h>
+#include <linux/ionic/ionic_api.h>
+
+#define IONIC_MIN_RDMA_VERSION	0
+#define IONIC_MAX_RDMA_VERSION	2
+
+struct ionic_ibdev {
+	struct ib_device	ibdev;
+
+	struct device		*hwdev;
+	struct net_device	*ndev;
+
+	const union ionic_lif_identity	*ident;
+
+	void		*handle;
+	int			lif_index;
+
+	u8			rdma_version;
+};
+
+#endif /* _IONIC_IBDEV_H_ */
-- 
2.34.1


