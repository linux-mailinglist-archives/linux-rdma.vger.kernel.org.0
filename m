Return-Path: <linux-rdma+bounces-12740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D98B25AFA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C1C77BBC13
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B22264C4;
	Thu, 14 Aug 2025 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xEfwuyx/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906B222566;
	Thu, 14 Aug 2025 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150004; cv=fail; b=lbIxhf9kS3nMmDMH1rpchB7CA7X4kb1Mil9MXId2jMRd/7pyVzy/kI7LTz7HgknNyXxS9WcPueQOXWpqSvIAl54BDwLbLnk5qkAgfzLehFs0CL9wijF9PTl4KcaKZqU02xAAiux2OxKVRTCmoQxVve14SsJnL9C5j0uxrUlw6mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150004; c=relaxed/simple;
	bh=cfAPpr9FLjx1dDkl8128I0XDbVgK84Fov9ZJccVDNWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzIKujdrk6Esl3if1X+ZfZjMJ3rW6ATxQjUQsYSJ3i/GZZx0LfqPrXvepH/oWYVo8DOzpHx/ZtKOzajJ8pJjBDJPTIEziTZGlQVII2SCzfLFi76Ow2X8HGKe2vvFnE03nMVb5AQe26xBFINAQVkfiB9Q72MVVO0+fBaORYbYCn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xEfwuyx/; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA6RshavzKgfC8axB0Ori+HTq4ckoitC9tOVtCO4pzCBBuoNrQmpP1azgUUQfLoefPKEFTeyVXl3Gg0/DCjdN+QLfGQbyyA/2iHhTyzbVVVmbTlPVsTyU/U2KrKjyYyvlgMz3q3N1AVHAdDsLGhkEfZJmsaQ//mu0Jx8zHYIVFLq0x6MGQA0YZ57WZs6RVpi920nqF/xfF3y7inGgTEzl2BcRW1+6KLv9foGHsOJ1xZXD/bJRst7UVhMONUNvQGwmI9W8qIDF7TGme0Ui24WsoRL2Mgv3cuHPoIGqZGfeB+LxSsesRhm0ZcRR/6CSsIyRwGxpEIhRUIQItwxSQwDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSbuYxLGmefOiITmUeGLgntibKjgkrgO7SStEDGtPjY=;
 b=KBXtsxEOFHxl/HgJ3aHUp1kHrZ0tLpHjwOnOAVFaQoX005jK/zYLXkOmj2sOxKfVDP4mC4HqVBU0uD/fnC4ZwPavpDT+Wn8YZGv6A4mf0trp0+mInG0abYaTecGOubZYQWbo6FWbMguFpOsFdClHtaCmg4q63P3OGnDDx7WXaZuFP+dH8HXpNAIYDlEm3M05Jkiu4oKz0miaeGn6Xv8mQQ1SA9PFShtCbYIoiGzeTYlcuztWUDaIZkkuLDhf5vNCt4cLRY8ZKbXibSeJxUwZRTMXoMQBgEiN8Lzs8uIdKNbCpVBIXaHeiRu/+zB4KQZ8+Y4oE2x6+PyL9+Qqc/Upxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSbuYxLGmefOiITmUeGLgntibKjgkrgO7SStEDGtPjY=;
 b=xEfwuyx/cmAj5uGOoulwWzN5ietZaxpGc6/qLbsynCqYLjbZDopq2dmV5JPwK71m29dCdNjGDMK89j4F4QKodyAz524f4ZcG02kgCAnVAaAGVURqVSkugiIQqx+M+hObK1w9Zwhq46Jaz3RJ19mI0rSVewznh4HKz8pY/hZD+F8=
Received: from SA1PR02CA0023.namprd02.prod.outlook.com (2603:10b6:806:2cf::25)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 05:39:55 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::99) by SA1PR02CA0023.outlook.office365.com
 (2603:10b6:806:2cf::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 05:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:53 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:49 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v5 08/14] RDMA/ionic: Register auxiliary module for ionic ethernet adapter
Date: Thu, 14 Aug 2025 11:08:54 +0530
Message-ID: <20250814053900.1452408-9-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7243475e-efb1-4a47-9568-08dddaf4ff5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P3OHxhI2quiYsZq5omaagEXQicBCMgQSG5+w1mEN0QfDS7rpJSjQO/SJ97WD?=
 =?us-ascii?Q?HdRpo/UKW2pk/D2JNTMyv8k1CvILM6fefGXOazvDIxMk9J0bVDqyegl36Wdv?=
 =?us-ascii?Q?EqiA117Q55fzVURHem97w1bkxo6z4Mf+26PUDJaes9jeAKvSKG1Nv5dDA8yf?=
 =?us-ascii?Q?wjddhNzcBquBwy3clUIPCeOZYKoIeTCMzt2Ow+NhQlTAN1WnjCw48pU4D0Q8?=
 =?us-ascii?Q?qpsszmntPEcwOxOoa4w1BRAZteMufWaRx+lNU9PBxI6Oq8uywMwwfJh6MfaH?=
 =?us-ascii?Q?I7ITqnN3neTOlsE9O0PcW9mXmzoGRWIHuVMkSqoSl1+D0QmYmr6z1y9mG70u?=
 =?us-ascii?Q?2rCMJRBpcJ6E6uzt5xfFimdz08Qc6Py9sSogvViS8mj8bSc21cmC/VmrdEFC?=
 =?us-ascii?Q?KgyE6SGO9lp+9PVP8QcES6mlaLMmuYA9NLXMzVPlrJaJukAUeI8Rk4jk0FXp?=
 =?us-ascii?Q?jDDZBpcf+6JzwVKCI9ecpL+ACh9LCMrEQKa7KpIS2FR1cPoYcU2RejIhkf4g?=
 =?us-ascii?Q?Qevc0QAV+3rmpfnrdmnKcMOXUWqjd+SMrxjPNlp6vFFi2J1ITb7x2R0wUUNy?=
 =?us-ascii?Q?gywPkYLs0KaqPTBvQVHRK5Nm2hL9Aw2MSEQFnr+IKCS8dVZ/sW9ZNbkaT32V?=
 =?us-ascii?Q?MdalDlhFi9Wrc6Ttb2jZopWy6rRu90jAtycbyTDcvRKhUS0xfYw05xbyadYP?=
 =?us-ascii?Q?7Gx7ZC29RvMLazzwWW31aqGLapqiplZyyDqRnrFFZJr1HUhlzjN5nLKuwudO?=
 =?us-ascii?Q?YsjQt/7zY95/8ui6oGXE6pkIco/lyf/URqY37sOH9h2ZgOAqxyOb88G03Pox?=
 =?us-ascii?Q?qBw58RZncLl2fec+IO7OA157GubpKkzJgabaQnhhvPoIWeSUuWyeSxwGIjLZ?=
 =?us-ascii?Q?Oeo3cwnH2UBQWMA9ZFSNGozUCh5+ToFwd22MSCI7zu8H+r8BYRy8/dnyax9k?=
 =?us-ascii?Q?fqcbnqaibgy4LFGEOXRuhoKJu3w20nWJImHLxOHyM/6p7LnAOY5V+ZMdnNqA?=
 =?us-ascii?Q?pInXN0Z+pKbHnoH2tB18HPrETGnOjoAA8xBPU59U2NbDEr86N3eH+mNmHOEa?=
 =?us-ascii?Q?fKV3z7N9Vks5/LipbwEjlnNCnIeT5hnXWaShfu0uBRhep8fgA2unb2Pse+sF?=
 =?us-ascii?Q?1GwzkwoPa7ccOfHHVtRVUHf766561hB+pc3N39PS51hl85wG3NpHH6UGrPko?=
 =?us-ascii?Q?kcLfkeeLntFgDvI3aKaHmgeUwCx9iYhV1kS+z7p1yuXotTfGf5BLteT6wpWI?=
 =?us-ascii?Q?rqkdvWZgVHQsBiaDtEJ2nUPyw/hIF4i24unuckHawuGFNTAXVs33nr3XiGyW?=
 =?us-ascii?Q?T3qNusNLyOZXNI4g73uTgIC6wdTqUvlPzqF0sU+5dOe6VFggQ2l5zHzF5gZp?=
 =?us-ascii?Q?Fpvor/2WG7kDXJIF9VxTHp62qyiXe9F0WT16w1C6/MvVxLXRDMizoV7V9MhO?=
 =?us-ascii?Q?YQUyt5F+iM4/Y0Ux210vFxOo9osbkgYRq3mYGxMi3nz+bajgvYE+vkwe+Wz5?=
 =?us-ascii?Q?L1bTjAG+4u+V6s6kKUb3wWa+3vHRlVOQaCeK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:54.6909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7243475e-efb1-4a47-9568-08dddaf4ff5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656

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


