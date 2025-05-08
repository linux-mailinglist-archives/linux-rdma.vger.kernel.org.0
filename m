Return-Path: <linux-rdma+bounces-10139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB2AAF263
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F76B9E0B58
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC56821D3C0;
	Thu,  8 May 2025 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3lvI9UAh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9921420E;
	Thu,  8 May 2025 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680479; cv=fail; b=Y//jvj9zOiiNKLNyx8MDzIEsZ+iGMU6PzeOmTCseCujVIQaopVkDKqbLIXHvEjSw0bk8VayvSj1rmRO64Vx12Ilb5t3JrdSz8dOZnla8OuiXe/DUQXOGdGfHwkbVaWUkubZpPKER5JG9O6TvDfxltN/nYnQMUC/iWhA3I1eHUGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680479; c=relaxed/simple;
	bh=PTEdx4lWog3nfKCGYkKz4jfJEM/kgGgtH/KEgs7Hkrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9b7ix5liu3QAL4JhB1Fq+DTuS6x2QHYaMtlSH75YdXqd3GvgjeivcTYDxhbtexkcwqKHvj53LyKzeG4MN3XGNZBwn/OYIazFn0KRFvXhKGeme1IQwuuxrSsnqpbrXfxZxoaEhvWGI85Tnd9uIjySyfMfQ7NxaDr3OHW+EJ0Wyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3lvI9UAh; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpnOwe00b4PJDTpnSq/V9GxRcUhHneooOQpUffwLfdoAM4Kakg4cWXC7S3XfqVHlHTUv9eM6nV2E3/VxIxFJIJKBLu5gs60DvOCvQuiu7c42FqiIV8JyPx2MWGyGuMDd4ZwRLtC2E84GzZW6Z5D4gAALLN7mOU1IUDFcM4dyrncvOYFwWIhvG5h1y7IIBIwIWHjNHrVEWS31TTucRj7icnx1xmZhwi2+0dqo4IwbVfoo0hkv4AnAf9+PjbHXm5Z/HRH+G0xtdAdTZr9h0Ntk4vWN8xhBYbEeUZBFpK/6z9XtKHeTMzRbPGp0uB0J3IiJ+8CgknTi9a2QF1HaQwIcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kfxj/MU57YdTuxCw6SyI+yUvYE0RsZ3yRGZK2i0fP4=;
 b=BnAvaNGBPlqV1R6R9R02RRCJzFcNHOgnfWyQncwKEs5OHX6dJ7w0wULXgq7kMI8SiBx0mmdAFmRaB/8F6wUiiUERHM263kIeD2O+MpKnB4HC0iT+1Hf7WFmU1nJnkfePh6mpjy9laMgr+gP4M6HiN0bFTwXvdLPGSSvdx85YzWkhmlKwQI6IZR9CE66FWd2d50g0Oo9r92alJs+Xq1HgOKlNus1p7oIMoCoGvinCgTpG4tvyNjOuzOjPS8d/CRHYOY3NsPDAi/dbolzafYfhBcowSqvYdm11H5/Jrp2fEzfuBW25knPJX2Ww5Wkr1s66AZdu4RzZuJwjr1HVhNapJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kfxj/MU57YdTuxCw6SyI+yUvYE0RsZ3yRGZK2i0fP4=;
 b=3lvI9UAhfW8MZ8usiO/68vsgP8xf9p1TSMD+XXiqOa9bqLEqPALGBllEy9jm2h9IfBt3OrVRG2wBzSpAY4r6gb6Lg42x+YqvGyXkO/fO/L6ZIjN8fVkOdkvm5OIKTokFHta9UWv96hBneSrbhb3ZLb2tNl2OhSJEGEyxhADjypY=
Received: from PH7P220CA0152.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::10)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 05:01:12 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::56) by PH7P220CA0152.outlook.office365.com
 (2603:10b6:510:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Thu,
 8 May 2025 05:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:09 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:01:05 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v2 08/14] RDMA/ionic: Register auxiliary module for ionic ethernet adapter
Date: Thu, 8 May 2025 10:29:51 +0530
Message-ID: <20250508045957.2823318-9-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b859cc-26de-4e1d-53fb-08dd8ded5a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6n9nwxnQbX75leGq7YiPZzdf5C1GTS5FXlfpvCT8FplqVnzCuNcZeZfqVxh6?=
 =?us-ascii?Q?3awJ07fWRt1HsHQfJ2AWdLYUMWIZYhBjczaFcYryUqDF8An7VCTu4U7lZXNq?=
 =?us-ascii?Q?+ThsMrOcpmICheBZPjD5atBq06/lcWljTMNkTgfMUrCnefEO5JwIYRqMiDEF?=
 =?us-ascii?Q?A/j2Wv+m5WcYHoq9wX/hmHgriAWg1iPFCo1LJnFV+M7WqcUfXR5A5dq2zkve?=
 =?us-ascii?Q?0/wg7pv9dDPV4gGUGWJB0Q3mmVRSc2FOghKugFXl0yJciLHMiiXo08I0Lrzi?=
 =?us-ascii?Q?l0lIzFmPz97BCpMC4HxI+hpHT9o5OFHzlGRyPvwc6dorPyjqRP03XQ5tgKZy?=
 =?us-ascii?Q?bZf3qkVcbh4IRAk6EqElc8rHmSlMsHfidOT2BBxZWNLlm0HMqerg0NEL/kyc?=
 =?us-ascii?Q?Ar1CwVZceRK2X+H1CuTxf3ED68DUmDYX5oCNrj8px/tR5CAA6iNRWLjkVCN7?=
 =?us-ascii?Q?OYmwWtgY96uBJjEhISXjQ4RPeZ0spOEmR1tftSrv4QV51/q9pcbVEBUyEee6?=
 =?us-ascii?Q?Fl+h5FUg4BKctf0GaSI0QXfoCfD3AVZdiOyNKWKYOauqwJGzKuoIc2BX3pMH?=
 =?us-ascii?Q?oWx+59ss8RHfuMpNOiduvi9tmGXI4x7dMGXgXFlIfoKf9uc/eMR8Rhh5DQ5j?=
 =?us-ascii?Q?j8Yu6eqE/DqlzAzyRO6ZVQe7KZo/kX9n6ovV09AI8y1xF+EiQqhM6PVMzv4R?=
 =?us-ascii?Q?3fDmodoC2QU6Eo6f1W8Txg4zWjn5/n7z3kR8VFQxqO1j3HlupiBfvMXmUELE?=
 =?us-ascii?Q?2Lp7NgOhi5LGrMjbawM2D8ZhIx0jEUdeOkJ9ZxtgKBfxVqoLcpaZbLDO90by?=
 =?us-ascii?Q?wTqwo8y6bdr1PpOFDR1R+XEXNcSM8QID5Ny+Vkxqj4xWDgvf8TbV33Iw9gSr?=
 =?us-ascii?Q?uH8ERevzexI9ZoanZ7hSUZCqSeS+sw3ICYAlQGH3fTTmTmq4fFM8iHZLC38g?=
 =?us-ascii?Q?riyY/WsmhjBE+oYnsRsYwj9A3+6SHY85eDHkqU8CswUExAqPpEGXMrD9avdp?=
 =?us-ascii?Q?NFbw6iA9CZGYewSg5gxLAvrk2yiq5yoBw+bYKXGugQWILkJEtu1yGZJ/qIi0?=
 =?us-ascii?Q?sk9Yb0gZvhfSl2UJUgIyM3B3heCKqpY5J8vbpCU7pPAPveKahNmqfR1mIUvI?=
 =?us-ascii?Q?/D6ZQ8R6zbPRJek5BfeLvTfcPSJpDgbvr5xQaccK6tg/uMuIh5cJVyHhkvFw?=
 =?us-ascii?Q?3Z9XtOGQoLFtD9/tfCAGuBLwf/vxBqBZ0XpNRnUFVX8jG3qxEHj/uFyWtAVb?=
 =?us-ascii?Q?aDZK9T6AF3rBOigZhM/uQR3QJ99Yy09HaON3KSBwEtXXDwKyfiDRmjFVkTs2?=
 =?us-ascii?Q?j3Tk7PQk4R0d5sT4r249VzHHnzk6JLIaALkfQVZTFCI8STwYhj1vipE/dpZr?=
 =?us-ascii?Q?kywFWjidYeBKJMLyWI7vEKlHLIRBYCTeZsstF0swjzMLtGAWc/9/wsgAcNPz?=
 =?us-ascii?Q?A4wV6zSn2p+hXcaGPltMTDoPhyZ/6aRjKrOw0Lm+Ql7ifM6ffqZKBDYAR71p?=
 =?us-ascii?Q?COVFphx9ht/bg2UGx1d+oeeGuzP1Res4Tthla27VjTaP5IPRrPTkdkbVPw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:11.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b859cc-26de-4e1d-53fb-08dd8ded5a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

Register auxiliary module to create ibdevice for ionic
ethernet adapter.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v1->v2
  - Removed netdev references from ionic RDMA driver
  - Moved to ionic_lif* instead of void* to convey information between
    aux devices and drivers.

 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 135 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |  21 +++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 121 ++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  65 ++++++++++
 4 files changed, 342 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
new file mode 100644
index 000000000000..ca047a789378
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -0,0 +1,135 @@
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
+static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
+{
+	struct ib_device *ibdev;
+	struct ionic_ibdev *dev;
+	int rc;
+
+	rc = ionic_version_check(&ionic_adev->adev.dev, ionic_adev->lif);
+	if (rc)
+		goto err_dev;
+
+	dev = ib_alloc_device(ionic_ibdev, ibdev);
+	if (!dev) {
+		rc = -ENOMEM;
+		goto err_dev;
+	}
+
+	ionic_fill_lif_cfg(ionic_adev->lif, &dev->lif_cfg);
+
+	ibdev = &dev->ibdev;
+	ibdev->dev.parent = dev->lif_cfg.hwdev;
+
+	strscpy(ibdev->name, "ionic_%d", IB_DEVICE_NAME_MAX);
+	strscpy(ibdev->node_desc, DEVICE_DESCRIPTION, IB_DEVICE_NODE_DESC_MAX);
+
+	ibdev->node_type = RDMA_NODE_IB_CA;
+	ibdev->phys_port_cnt = 1;
+
+	/* the first two eq are reserved for async events */
+	ibdev->num_comp_vectors = dev->lif_cfg.eq_count - 2;
+
+	addrconf_ifid_eui48((u8 *)&ibdev->node_guid,
+			    ionic_lif_netdev(ionic_adev->lif));
+
+	rc = ib_device_set_netdev(ibdev, ionic_lif_netdev(ionic_adev->lif), 1);
+	if (rc)
+		goto err_admin;
+
+	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
+	if (rc)
+		goto err_register;
+
+	return dev;
+
+err_register:
+err_admin:
+	ib_dealloc_device(&dev->ibdev);
+err_dev:
+	return ERR_PTR(rc);
+}
+
+static int ionic_aux_probe(struct auxiliary_device *adev,
+			   const struct auxiliary_device_id *id)
+{
+	struct ionic_aux_dev *ionic_adev;
+	struct ionic_ibdev *dev;
+
+	ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
+	dev = ionic_create_ibdev(ionic_adev);
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
index 000000000000..e13adff390d7
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_IBDEV_H_
+#define _IONIC_IBDEV_H_
+
+#include <rdma/ib_verbs.h>
+#include <ionic_api.h>
+
+#include "ionic_lif_cfg.h"
+
+#define IONIC_MIN_RDMA_VERSION	0
+#define IONIC_MAX_RDMA_VERSION	2
+
+struct ionic_ibdev {
+	struct ib_device	ibdev;
+
+	struct ionic_lif_cfg	lif_cfg;
+};
+
+#endif /* _IONIC_IBDEV_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
new file mode 100644
index 000000000000..a02eb2f5bd45
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/kernel.h>
+
+#include <ionic.h>
+#include <ionic_lif.h>
+
+#include "ionic_lif_cfg.h"
+
+#define IONIC_MIN_RDMA_VERSION	0
+#define IONIC_MAX_RDMA_VERSION	2
+
+static u8 ionic_get_expdb(struct ionic_lif *lif)
+{
+	u8 expdb_support = 0;
+
+	if (lif->ionic->idev.phy_cmb_expdb64_pages)
+		expdb_support |= IONIC_EXPDB_64B_WQE;
+	if (lif->ionic->idev.phy_cmb_expdb128_pages)
+		expdb_support |= IONIC_EXPDB_128B_WQE;
+	if (lif->ionic->idev.phy_cmb_expdb256_pages)
+		expdb_support |= IONIC_EXPDB_256B_WQE;
+	if (lif->ionic->idev.phy_cmb_expdb512_pages)
+		expdb_support |= IONIC_EXPDB_512B_WQE;
+
+	return expdb_support;
+}
+
+void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
+{
+	union ionic_lif_identity *ident = &lif->ionic->ident.lif;
+
+	cfg->lif = lif;
+	cfg->hwdev = &lif->ionic->pdev->dev;
+	cfg->lif_index = lif->index;
+	cfg->lif_hw_index = lif->hw_index;
+
+	cfg->dbid = lif->kern_pid;
+	cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
+	cfg->dbpage = lif->kern_dbpage;
+	cfg->intr_ctrl = lif->ionic->idev.intr_ctrl;
+
+	cfg->db_phys = lif->ionic->bars[IONIC_PCI_BAR_DBELL].bus_addr;
+
+	if (IONIC_VERSION(ident->rdma.version, ident->rdma.minor_version) >=
+	    IONIC_VERSION(2, 1))
+		cfg->page_size_supported =
+		    cpu_to_le64(ident->rdma.page_size_cap);
+	else
+		cfg->page_size_supported = IONIC_PAGE_SIZE_SUPPORTED;
+
+	cfg->rdma_version = ident->rdma.version;
+	cfg->qp_opcodes = ident->rdma.qp_opcodes;
+	cfg->admin_opcodes = ident->rdma.admin_opcodes;
+
+	cfg->stats_type = cpu_to_le16(ident->rdma.stats_type);
+	cfg->npts_per_lif = le32_to_cpu(ident->rdma.npts_per_lif);
+	cfg->nmrs_per_lif = le32_to_cpu(ident->rdma.nmrs_per_lif);
+	cfg->nahs_per_lif = le32_to_cpu(ident->rdma.nahs_per_lif);
+
+	cfg->aq_base = le32_to_cpu(ident->rdma.aq_qtype.qid_base);
+	cfg->cq_base = le32_to_cpu(ident->rdma.cq_qtype.qid_base);
+	cfg->eq_base = le32_to_cpu(ident->rdma.eq_qtype.qid_base);
+
+	/*
+	 * ionic_create_rdma_admin() may reduce aq_count or eq_count if
+	 * it is unable to allocate all that were requested.
+	 * aq_count is tunable; see ionic_aq_count
+	 * eq_count is tunable; see ionic_eq_count
+	 */
+	cfg->aq_count = le32_to_cpu(ident->rdma.aq_qtype.qid_count);
+	cfg->eq_count = le32_to_cpu(ident->rdma.eq_qtype.qid_count);
+	cfg->cq_count = le32_to_cpu(ident->rdma.cq_qtype.qid_count);
+	cfg->qp_count = le32_to_cpu(ident->rdma.sq_qtype.qid_count);
+	cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
+
+	cfg->aq_qtype = ident->rdma.aq_qtype.qtype;
+	cfg->sq_qtype = ident->rdma.sq_qtype.qtype;
+	cfg->rq_qtype = ident->rdma.rq_qtype.qtype;
+	cfg->cq_qtype = ident->rdma.cq_qtype.qtype;
+	cfg->eq_qtype = ident->rdma.eq_qtype.qtype;
+	cfg->udma_qgrp_shift = ident->rdma.udma_shift;
+	cfg->udma_count = 2;
+
+	cfg->max_stride = ident->rdma.max_stride;
+	cfg->expdb_mask = ionic_get_expdb(lif);
+
+	cfg->sq_expdb =
+	    !!(lif->qtype_info[IONIC_QTYPE_TXQ].features & IONIC_QIDENT_F_EXPDB);
+	cfg->rq_expdb =
+	    !!(lif->qtype_info[IONIC_QTYPE_RXQ].features & IONIC_QIDENT_F_EXPDB);
+}
+
+struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
+{
+	return lif->netdev;
+}
+
+int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
+{
+	union ionic_lif_identity *ident = &lif->ionic->ident.lif;
+	int rc;
+
+	if (ident->rdma.version < IONIC_MIN_RDMA_VERSION ||
+	    ident->rdma.version > IONIC_MAX_RDMA_VERSION) {
+		rc = -EINVAL;
+		dev_err_probe(dev, rc,
+			      "ionic_rdma: incompatible version, fw ver %u\n",
+			      ident->rdma.version);
+		dev_err_probe(dev, rc,
+			      "ionic_rdma: Driver Min Version %u\n",
+			      IONIC_MIN_RDMA_VERSION);
+		dev_err_probe(dev, rc,
+			      "ionic_rdma: Driver Max Version %u\n",
+			      IONIC_MAX_RDMA_VERSION);
+		return rc;
+	}
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
new file mode 100644
index 000000000000..b095637c54cf
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#ifndef _IONIC_LIF_CFG_H_
+
+#define IONIC_VERSION(a, b) (((a) << 16) + ((b) << 8))
+#define IONIC_PAGE_SIZE_SUPPORTED	0x40201000 /* 4kb, 2Mb, 1Gb */
+
+#define IONIC_EXPDB_64B_WQE	BIT(0)
+#define IONIC_EXPDB_128B_WQE	BIT(1)
+#define IONIC_EXPDB_256B_WQE	BIT(2)
+#define IONIC_EXPDB_512B_WQE	BIT(3)
+
+struct ionic_lif_cfg {
+	struct device *hwdev;
+	struct ionic_lif *lif;
+
+	int lif_index;
+	int lif_hw_index;
+
+	u32 dbid;
+	int dbid_count;
+	u64 __iomem *dbpage;
+	struct ionic_intr __iomem *intr_ctrl;
+	phys_addr_t db_phys;
+
+	u64 page_size_supported;
+	u32 npts_per_lif;
+	u32 nmrs_per_lif;
+	u32 nahs_per_lif;
+
+	u32 aq_base;
+	u32 cq_base;
+	u32 eq_base;
+
+	int aq_count;
+	int eq_count;
+	int cq_count;
+	int qp_count;
+
+	u16 stats_type;
+	u8 aq_qtype;
+	u8 sq_qtype;
+	u8 rq_qtype;
+	u8 cq_qtype;
+	u8 eq_qtype;
+
+	u8 udma_count;
+	u8 udma_qgrp_shift;
+
+	u8 rdma_version;
+	u8 qp_opcodes;
+	u8 admin_opcodes;
+
+	u8 max_stride;
+	bool sq_expdb;
+	bool rq_expdb;
+	u8 expdb_mask;
+};
+
+int ionic_version_check(const struct device *dev, struct ionic_lif *lif);
+void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
+struct net_device *ionic_lif_netdev(struct ionic_lif *lif);
+
+#endif /* _IONIC_LIF_CFG_H_ */
-- 
2.34.1


