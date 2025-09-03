Return-Path: <linux-rdma+bounces-13055-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58EB414F8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6551C7B3B2D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFF2DEA70;
	Wed,  3 Sep 2025 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bdvms4tg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2E2DE6FC;
	Wed,  3 Sep 2025 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880283; cv=fail; b=qvTYcm8CMYDHvh44fC6bBi+Vr41whUfYgrheo9hk4VgDZSZ2LpajEEAWadz/M1dF7vAP8wALXZIHMUqYrLP6luqr5kiMoODAjeaUWZ0Ej+C0YOCqKKkEvisSzk7hAdhaR8BPRGgDcL4gKwLQMYbRGLLrxY3YvyU5Ju75x0CvKYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880283; c=relaxed/simple;
	bh=cfAPpr9FLjx1dDkl8128I0XDbVgK84Fov9ZJccVDNWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5GvDIlyBF3qH9u+ZQWtYR85FMOS8/2sipjB9Gg96zUcal9Mbj8Uh+tr5xHD80vqmBHSS1PYKGZyC6h7Il55ZA3QKcm9WvRUZe73nsanaIBLkvB+pRv+pWGPp37G97F7zX0IjXABVONByBotJPjGUAJFr8TZMQw9c1nLNetS+BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bdvms4tg; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2UUekJpvaqINkXZJJiZKgbnOD4TLVIayT4XwvDYLtg3BSWj0a1TXpGrchtH7JB77q1ZOtj1hHXXKE8Ol6mdO2TjbCpetXXZdjreRRYs+ZCr5sDqVdHDr/rK20G2ulLiDivO6Vb1hkMO6eoQ4cugsFFAKx3nLENRFZNv9ndRwLOofxFnIYArMdJ/Y5S7QuKd0LTHICfk3KxngXwUvV19YAC6e+Unxy7ht+HwoVDGg+Dh17pZOv3KbJjdtNkzb9AxItK7qaBeREAmt5f9f++KfHyxua0Mq+vicLaO5/NhrC+tr3bvimvdVB9N9VTtuyWfkjNbLO3POKFyueXL48nsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSbuYxLGmefOiITmUeGLgntibKjgkrgO7SStEDGtPjY=;
 b=XPHNNIr1jr/8qiYvsVp+E/CViD3GBPmGMvBa5lXQAt47Ui3LCesOcuAbYt0QuN/Pz4+u2SvyD/Nhngbp2AHqnTeZSU0PapaqyyrG1hWY4H4Ye/cDBZ89NP94NkdPGlr7kHu5+Y+4Ur4H/pRgq2K1OpHDIWYB91Z47A6ynysz1vWF1o+5ca7Op8yqK4jCst2C1cz9i/wQP5/aC3X9U59W7EIOBObhAXOc8rNdXG6hW6bKkUSPQCcRvvarxSFXQp3xmUTYRM47hdi0n2iOelBnNbRJinlid/tf6ax0NOmFYPDNDh/jOVUpzeWPoOiRRUuSqREgD7lCKwGJCXB28R6BBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSbuYxLGmefOiITmUeGLgntibKjgkrgO7SStEDGtPjY=;
 b=bdvms4tg/Q5/NnW/AP90kB3w6kXovlMPsuGdLp7uF6JNPxUSu8upki1gqgalKl8IOUhrEDKylxhuSBnuJBOcCyyzi4lye4C6jTG+sh0RvnSyNSeP4Zy5Nc8Quakt7XfOB41DjkbUJzFRQ/G65gs/xJzOENxxYkn3RTqbyEevMLU=
Received: from DM6PR03CA0070.namprd03.prod.outlook.com (2603:10b6:5:100::47)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Wed, 3 Sep
 2025 06:17:56 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::3d) by DM6PR03CA0070.outlook.office365.com
 (2603:10b6:5:100::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 06:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:17:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:54 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:50 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v6 08/14] RDMA/ionic: Register auxiliary module for ionic ethernet adapter
Date: Wed, 3 Sep 2025 11:46:00 +0530
Message-ID: <20250903061606.4139957-9-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: face3af0-2a7a-4ca9-72cb-08ddeab19f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XIpKsOEXwFR8+0ketkspkb9M1GxEtzGbbzE1ipRiG8+j+0EXVNR6h+NFsRMx?=
 =?us-ascii?Q?h4KPEb3JCCQ3CRXMUL40R0lVBqfABhCiV+VghiP/2ARV7rrg1lwfPnJpMvcj?=
 =?us-ascii?Q?wQbaTcc3sPMia9LsuBN3uv8Bf0Yw/IZ2EuCvzpT2Fwre3csR5/Y4vb3Tw9li?=
 =?us-ascii?Q?ZvB9Z+CN1peieR/VrvPUCooz3W9pkQTNtxE+fbxnN8zeyqyCAn3y1fWAkeh5?=
 =?us-ascii?Q?yJznCUINyIUOmFL7UWa/AAY+zYwY+dOGHO54vEVo5eZhnJf1Wb7zF+XKC/G3?=
 =?us-ascii?Q?wICahXYY8Jv7R4OSuJd/J8/qVEYyxJeQwtdQqAhwVnExPq/IKKhJEEeDEvfB?=
 =?us-ascii?Q?HIKulWdRDivII8p0myCFJS38Y7Pe4aXtvqxMBpNCLCw4Bqf8wAPhk00Kbme/?=
 =?us-ascii?Q?CZz4ehbB4cknROyFTuU08QLWsthtpgpm/gcD1TfNGa+/LZbovWOhpssNS6xl?=
 =?us-ascii?Q?azZYvMYTgI2PxB0w9a6iR7mhm1cQIIvUrPjT9I2LzPLQ0S0kJqdDh4oZFF73?=
 =?us-ascii?Q?anhDAYMUg5sQbXJ4CFaoozI5fouhGdrtozhY8GnRcBG/+H7m9EKO7urFpzc3?=
 =?us-ascii?Q?muZlePsLPzYDcEqXGVZFoR4GxqKNInkXAq4GKlqKA/jp9DLClxlB5JuASSKC?=
 =?us-ascii?Q?i+bSsBNJHO4H0Wfl9Kl+NBGuws7J6o3XXJmEZn+bxJW6o5rzQ0L+QK9g4NAh?=
 =?us-ascii?Q?8dAMrIOtB/hOFxvXy2xGVxPOe/aCUrQ9GyvK1MxNZtvWmKEyfr6WQoBFB91w?=
 =?us-ascii?Q?shDNY2kcuoB0/vZdS0bOh4Br5sHsya0OJdv0EZmM0V+Qt+hBjLk9WrAzG38Z?=
 =?us-ascii?Q?D8SmoFlgUUnY3+vwE6X6aw7CVaonf6oe+VjNA1VL4zYHYtSiobml+Y9oWGa1?=
 =?us-ascii?Q?TL/i30tYKcrHkRKVhNHh0+fR7KSumR7H+u9DWo4Uzs+wpFsyf+Rt5kPpy7sV?=
 =?us-ascii?Q?NyBXVSAEixdyvOZ11AIaXc18+tMCe3II2gdnNviloiQRP5ffkS/8rI7Y7imm?=
 =?us-ascii?Q?IiUgd5EggqbgIXWBFnnD0ci3XYBWEHLE7OGpvUvVq7yzZcCfoAyNYWjCU/HA?=
 =?us-ascii?Q?3OTUgeu58/3Rm622piygiSsbKRC06OPBM/0RD0E7Tk5HD/nZXoTFdOzdOmXk?=
 =?us-ascii?Q?iTjKY3kdVmORD8GHlx9W0wAZijI6OP/APIlWB6CSJzpoQDr29CJj4VfJ0ZeE?=
 =?us-ascii?Q?aCwhKP+z9vMx4eVWizQWlt4FRYRg8nO9jaA6n+YaziJr5jVaCBF/kjzqWYVk?=
 =?us-ascii?Q?A5RECjpUsAj3p4gRlg2TlORbbhII1JFGqS0H5bMqhIaQI81D4Rz1OptOFMrR?=
 =?us-ascii?Q?dmpt0yOwus5C2W7VotlssGLtir4FgYrXChNCNkLM6VIVLuyuCxB9JjVSfTuY?=
 =?us-ascii?Q?zG9K1m9VsxbOhqf8GIs69DkiPW0XK1s7fsXDEmWxy2+DeFAlFt0XBJ/Kw8CY?=
 =?us-ascii?Q?DbOfd7wpiuOdQjV5Fy5msOt1PH4BFZQDDNxi/VO99Sr/VVDSfhDzVhfIdXG1?=
 =?us-ascii?Q?62dvZvgl3EmuVqMmB3COVR2eocG7MJoBwjuX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:55.5210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: face3af0-2a7a-4ca9-72cb-08ddeab19f1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006

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

 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 131 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |  18 +++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 101 +++++++++++++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  64 ++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
new file mode 100644
index 000000000000..d79470dae13a
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -0,0 +1,131 @@
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
+	struct net_device *ndev;
+	int rc;
+
+	dev = ib_alloc_device(ionic_ibdev, ibdev);
+	if (!dev)
+		return ERR_PTR(-EINVAL);
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
+	ndev = ionic_lif_netdev(ionic_adev->lif);
+	addrconf_ifid_eui48((u8 *)&ibdev->node_guid, ndev);
+	rc = ib_device_set_netdev(ibdev, ndev, 1);
+	/* ionic_lif_netdev() returns ndev with refcount held */
+	dev_put(ndev);
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
+
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
+static const struct auxiliary_device_id ionic_aux_id_table[] = {
+	{ .name = "ionic.rdma", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, ionic_aux_id_table);
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
index 000000000000..224e5e74056d
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -0,0 +1,18 @@
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
+struct ionic_ibdev {
+	struct ib_device	ibdev;
+
+	struct ionic_lif_cfg	lif_cfg;
+};
+
+#endif /* _IONIC_IBDEV_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
new file mode 100644
index 000000000000..8d0d209227e9
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -0,0 +1,101 @@
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
+		    le64_to_cpu(ident->rdma.page_size_cap);
+	else
+		cfg->page_size_supported = IONIC_PAGE_SIZE_SUPPORTED;
+
+	cfg->rdma_version = ident->rdma.version;
+	cfg->qp_opcodes = ident->rdma.qp_opcodes;
+	cfg->admin_opcodes = ident->rdma.admin_opcodes;
+
+	cfg->stats_type = le16_to_cpu(ident->rdma.stats_type);
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
+	struct net_device *netdev = lif->netdev;
+
+	dev_hold(netdev);
+	return netdev;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
new file mode 100644
index 000000000000..5b04b8a9937e
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -0,0 +1,64 @@
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
+void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
+struct net_device *ionic_lif_netdev(struct ionic_lif *lif);
+
+#endif /* _IONIC_LIF_CFG_H_ */
-- 
2.43.0


