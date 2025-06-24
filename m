Return-Path: <linux-rdma+bounces-11576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73DAE6476
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B6E1926CF5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2C29ACEC;
	Tue, 24 Jun 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dNU48keT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26E29ACD4;
	Tue, 24 Jun 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767251; cv=fail; b=X3Im2WXwto4Q2TA4k4SEOae6LTWf1Ro6vugQ7z2YTBjbHJvoacqibTh8olKt8jsBhTYbRfYbjqhZfGYhi/PxNPxVJmQoz6A65X6OpNyUOO607QUxNGLmB/XemrjxUnq1ygYi73X79mRuFQXSOV+pLXS1OTrRtl/ksTBmWInabWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767251; c=relaxed/simple;
	bh=oyu2Ku8kk+w9QKfEgOh5HsnhZbV0i5xvjMHrp5rrNJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLStmQqwnwUVxqvAQZ8e6OabwgZMJqxPDw/pQbxoe4R/cjwxGQTOtqA69aPOgGm8IVN2nTsyG0YabE0AkHdEd8gisHRL8DenKLJD1Uskmev2wY1nUdC1zGi2nVmemG4ke+kBZGChOtIoLzm7gt5e8/IYNovSIXdk5Qaeqe15lw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dNU48keT; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eK9IAAnBPr/DBwUQzgxVqHa0E5ZW8PDR4R6jEySoppwwEZHaC/eAqCuqC9j78lZ7hpCc5aKMrNANU+FiiCkGKyaXoQj5eRL+YgBmVPRo2zsZE+PNjkP7c368e/C3m3xdzY6d5q318JlC0+Fl1gvBoo2INd523rZqVdrEmPXvyzt/mAuNT6gjjn77h4ntow+pXjvIA5jrfV6nGOoxiqmaPsUtPtdbqqMcilg7HD0xEttxwgERRMVnsgMixF4E/XTqE9YezpsOopPL2adSuAgwUcHZkoOpra4P6hrOLG8nqvYH6Fpwq4IFZU0U/Bgmt44aNFB2W80hzMnwhJn0OF5+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YAwxx1e1IfUKGDwcUBRCKYOq99+188NVGLeR3QjyNc=;
 b=IBGYFQ8Hbv/l8NVvOMAOVBI/mZSEXSaHiN/fLJzCBc5cSIFuraleT9SF9PeB9InXImA5SqiFBDiIBefTFpG5M3ZWPytU+4ozLI7vAXNO9/x7w/+NMQur2gxX3k7WYlfN+SCMNfNgm5VkNHJVUVaULkw5Fe3DDaXCJjVRw+IEdFSLNLyPREhvfX2XS/MJ7yd4YEo8vivac1NgB96RIjV9/4SxIlUZomXhwBo8Z51fc7m1LXCN8z2MLIS+OH4lnoI/wVRVpJI22UecByQ+n6aeI3CSGyDHkXx26vvRzRJ4FV9vujNA7nnj4Ur20+0fGdDvYuA8z3Q12ivHowgAQPjKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YAwxx1e1IfUKGDwcUBRCKYOq99+188NVGLeR3QjyNc=;
 b=dNU48keTLxzLB7qLwejvqOWeX0FjwKe3DRPIZmfOfyjQoIgEnRM6qGZXtEA3kIBCX7MqE1zjAOf5cEMcZdORBGm3LhH+JIKxdgJqu15ehsCweRCffiXzYfon7hme+5yJ6qxhG0BJEpy60oQWgv3WSB/qU/mbWLMr74Wh7FOYP0g=
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 12:14:07 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::8b) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 12:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:14:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:14:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:14:03 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:59 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v3 08/14] RDMA/ionic: Register auxiliary module for ionic ethernet adapter
Date: Tue, 24 Jun 2025 17:43:09 +0530
Message-ID: <20250624121315.739049-9-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7a34e8-f4b5-4beb-7728-08ddb3189dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmGYZbaDPP6FKktMOMbY+wdsHxhwdJOYwl3SzlCFOWGQXn5uQuD/aP3XU56I?=
 =?us-ascii?Q?FDjPX+ww3ogF8iyNWb7hQfoDI5Erxv4MNFJuw21/6J9OhuCExLXRPx9xNDQy?=
 =?us-ascii?Q?SeuUSoIyBIttqKDtG6KCu/2BcmWz12Krk3HYUXYrHwWYLz+tLQJ5Es0CDt3C?=
 =?us-ascii?Q?Lj410t960Ny3p1Vjz350I64BY9sm946iVUH5u8QA/iOUAekWryObeXKbaB4x?=
 =?us-ascii?Q?BXezpjY4w1Kc6pjpE7GFqI0QpBXf6YdaNppKUlYdhuFLUQjYooANn++Ubioc?=
 =?us-ascii?Q?C2b7ZXyPgwtdRSvL4Y1uNastt2S4W5LiCShIQVef56JRtNnXyOe2lOjUbPkw?=
 =?us-ascii?Q?XDVQoIac3lp2KqUtIfBA8zphx1qsXJPQFBkhe/Dl5M8b4YLrzX5ZNIKLA2vW?=
 =?us-ascii?Q?lFsEo/RY3f5wBZL2SdPuYJSe997a8xaBtYUKX3gZX8vkCeJLKgSApAPHfCQY?=
 =?us-ascii?Q?JTlc97NYsK31mdpgUEFjtbKQhjejudel3k/B62Bbozt/KZLNAdteWwcNFD/l?=
 =?us-ascii?Q?eduEWGXf4pU4IAyRYlMHIqTNymhXpRlweHEf0+yNoJzRaqD/7xyzsF0oMhe4?=
 =?us-ascii?Q?7Qt78uS6SyW/v/Kjeq0LADl8Fb5m8wSaMYNOw2eimZYF9B3+BEW6BGjM9hKm?=
 =?us-ascii?Q?CoHJJBm7t6VUhRL9bKR1nX5tOdwMyZgwo9l1bHyaV0Br6xgeeSB+XY04WRPV?=
 =?us-ascii?Q?YBrMCVwcYlYR2jqzjQhPdDQZXG5qEfJbihVTmLTcfPF/s3yscgPmPdoO4dZj?=
 =?us-ascii?Q?NNlFma35pLfl5R4zC4VskZH9J/hUQaGqPqiqjHh+hrF8s9jThFhvAd7oTRaM?=
 =?us-ascii?Q?5Mtm/fbwOvHStPGRj/Wx7XtYpoP6sDxoZKjGaelvwNl3q52sEbnAWh/O7Oe+?=
 =?us-ascii?Q?bkd4EsqKKkNDfR8GTEyT2HdMbNyjlMB+ezcougFd7hRTPni/AuhWjmX0MjA6?=
 =?us-ascii?Q?Kf4FZo/IlvImSnSEhub2uvmindy6GmxnJJbgt6VsOimDXiRjpK4v14icmS64?=
 =?us-ascii?Q?2PlWQ/9pVVIsePdbVK/8WGFV25IX4P7EdDzGEs8zobyT7vIoGuBdoK3HhqvJ?=
 =?us-ascii?Q?EWhFRW51CUZhpdUT8pMU4zsdb9wwXVYbPKASVjzvUbuWV4xra3bUH1XY5fWd?=
 =?us-ascii?Q?b7Sy0W9Aswv88GdnbLIatjutPjVP3Dotn3Mwy3WAC/elYOafwLdwXYva7pES?=
 =?us-ascii?Q?M4t9UARiSf62/MfQOuo5hKWaCK1VXh9QHc3mevnH/16lkrrmmku3lxleaySn?=
 =?us-ascii?Q?Sn5iIlTbItgtH5DqOXVmS8d9T6UmvTxOr4vV9j62qObEHaQplo0N2Mdyxn04?=
 =?us-ascii?Q?4txAGmylt48semv5TBmu1OfV6+K7NZ/0zO//gBTW/BOXCfuVMwW6rz37hpS2?=
 =?us-ascii?Q?8B5VRmcyATPKliBLQtDY7x2JAXaB3BpghoJIlSGRdbuOAbknecK3hGidUyfq?=
 =?us-ascii?Q?wEK7B26fekqmG+BBCfJgfVSpHOLSHPGX0Rm3tM9Gt4YEpSnSLqNbc68X0+SH?=
 =?us-ascii?Q?ByIJmbSDVIAFeUiH1pVQCCCKchM6YUZyWtAx3JSLbE2YmKsdB4Y9MLOiiA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:14:06.4405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7a34e8-f4b5-4beb-7728-08ddb3189dd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

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

 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 133 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |  21 ++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 118 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  65 ++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
 create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
new file mode 100644
index 000000000000..6bd0175cd7b1
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -0,0 +1,133 @@
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
+	int rc;
+
+	rc = ionic_version_check(&ionic_adev->adev.dev, ionic_adev->lif);
+	if (rc)
+		return ERR_PTR(rc);
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
index 000000000000..386af7d351d7
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -0,0 +1,118 @@
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
+	return lif->netdev;
+}
+
+int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
+{
+	union ionic_lif_identity *ident = &lif->ionic->ident.lif;
+
+	if (ident->rdma.version < IONIC_MIN_RDMA_VERSION ||
+	    ident->rdma.version > IONIC_MAX_RDMA_VERSION) {
+		dev_err_probe(dev, -EINVAL,
+			      "ionic_rdma: incompatible version, fw ver %u\n",
+			      ident->rdma.version);
+		dev_err_probe(dev, -EINVAL,
+			      "ionic_rdma: Driver Min Version %u\n",
+			      IONIC_MIN_RDMA_VERSION);
+		dev_err_probe(dev, -EINVAL,
+			      "ionic_rdma: Driver Max Version %u\n",
+			      IONIC_MAX_RDMA_VERSION);
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
2.43.0


