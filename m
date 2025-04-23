Return-Path: <linux-rdma+bounces-9718-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA6A9875F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39849444302
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F74326D4FF;
	Wed, 23 Apr 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0jVR8ZpD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6D26A0B0;
	Wed, 23 Apr 2025 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404249; cv=fail; b=RxUfq9brPNgHXe6O7WiVVOzNckKX969nupc73MQIfDNcWMFMQHLwchjwmQfqhMolnWWfZ4aCM8TV8KpsxxPmvPB64IF030TAAnCTB/4xKIYHqOifX00lwA499h/f1CAHoioZc87WpuzEbukqvQ9FGYXIqdCllUhY/cvB+HpvpJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404249; c=relaxed/simple;
	bh=qEVaZxm0d62OTx7NfoALZXL/6L4M7+T8oSWUb8XOH9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACnBsGM7bHt8HcegfqOAjpUYR5hNuM4AHN3Xp6dxUZ2oHuEVseNq1XZ540C19uCw+pIH+oHHwVxkcg5/VdC8x9ZuOV6MScWOPYT8js1kNSzxx4VG9wAlano8U2wGxqdMRpUcUDzJWr9NXTpD8xy5YYx8iZy0i03BVrFycnavJPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0jVR8ZpD; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C10l+n4Oi9UXYpY6iVfIi1oKR61zrh/c2MHuZRkoXrTTVy+DC3f0gUGA5khtp5QRtyxr/oS1HrSHPZh6Ej/K2f1QvM8TbolwTK5MSNELHHwGx+Yp0EgWsAaDSDQ0nwlE81QXa9jW55au4TCT1CDT2HMfe+xjwZd+Q7Ytt/L5oPL9+As5RoRjJBq6Mn4vGmqXjoNKDktzhydfFKH78L6+wFFwP/Pj8Ep2+3O5ImkUTvQBMoWM0ep8Khu0xMiiMiiRABgSH0opHdRHK0Z1PTJwN3Cy55aOvwojDpLiIMIDhqUE5y6F5Al67QwdlENvqW2aycUugG8aUulWEn6UUDcjbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C94cU9c1eK7aQSOZvRzp2rP9BeOE1c8UP+wsMW2ZbA=;
 b=MygzLJNaJ0WeoFjc1esl3arX4PRID215KeqCrhRuWV7VFQKnFT3HMYBHdxBVIuubrfL+mtUgywJnz++MEdcLU7Y5M/UC3irDNmq8+0yPhZaAt8fztdJaLmyS7gqxQIwzTC+2YDQi6x/C4DEPiR/pYnAujVxOL/bIc9ETyF1iOGAT5aH2iN5PY5MynAyxwaJH3wWPUsn+nNox8j2XNN2gTjZqnJy51ipHcyDdgfsMXtbSCVkTcF7zbR9JBng/wUtKVfI/YtpgXkDRLNIVKDPzOt03zOgPrnOP/+uIdFGg6MIm5X8TI01RVzliWUKuVbRWLAYXiRvY9Zj6fkq/BaX3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C94cU9c1eK7aQSOZvRzp2rP9BeOE1c8UP+wsMW2ZbA=;
 b=0jVR8ZpD44y2gZOHSvJ3HU8LbT2wgBKSypnTqwBhG6t5FBMwAX/fdVhIfqomStufO2tdDz18X+6RKvNBmmxF0AgJjJbx90w9J6t4RsC3kM7Ttp5utb38U+U3MUHVRcp71ITFeDVJEDuH3mZRdm9Dn3ouZNO+JgL35E9M9MwOxpU=
Received: from BYAPR08CA0029.namprd08.prod.outlook.com (2603:10b6:a03:100::42)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 10:30:41 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::23) by BYAPR08CA0029.outlook.office365.com
 (2603:10b6:a03:100::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 23 Apr 2025 10:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:30:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:39 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:32 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 03/14] net: ionic: Export the APIs from net driver to get RDMA capabilities
Date: Wed, 23 Apr 2025 15:59:02 +0530
Message-ID: <20250423102913.438027-4-abhijit.gangurde@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 332b12bb-955d-4afa-a288-08dd8251e5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+4xg/sG4jRk8YAznFcOI54SCEMbMZ+6aJ0IaJmmLM2fRTzDRsbRa1dUImmO?=
 =?us-ascii?Q?O5R9Lb3ZAa5PSmR4c9nrrdfDFRihmibDqOyrLmeQxb2yq6uNz+O30STxGrZQ?=
 =?us-ascii?Q?0Cm812sz+hSb89JrNOMapcQWGotwYdrH97j0HM5N+Foh7CwcVyUEzCovWy7n?=
 =?us-ascii?Q?5ZOvntSX1fZMTE6ObfGKSqUNaazPt9Ypjxronb2rha0D3L7fAHgZiycJe+u7?=
 =?us-ascii?Q?q6Frh6xKPyEex8pedo9xmCXiWI7ESduwtXTXwCV1bZxgW3PDssLfYVunA6um?=
 =?us-ascii?Q?wnERUvWbQ2bRo77yBZgHZz8CN0GWl8KKxz05dMjdME/NdbIB4ZUI9l6jylYp?=
 =?us-ascii?Q?jz82CbJsRQK+s12ucEeEzRsp9MgdL4mh96/loYUkgo7isvBTHwdJXySKFB0r?=
 =?us-ascii?Q?hDd1I782yINRGKqDhHYnavGyb5Tg/wyx4FTO5Stro0RXnVG1G5A/yq3LvuTb?=
 =?us-ascii?Q?co4FcC4E0zylvOZKNRo4pnRzF5/P3/C+ucbHsHT8cZAUr9oabiW35Vx90Vjh?=
 =?us-ascii?Q?x6NUTrUazf1kLHIxB0B6DhLhVobygGmNyS3WlGR/1EFya5yghvZAQf5dH7q6?=
 =?us-ascii?Q?S5zdW4emUIrPhZUvchx6cPzq31a5BYVDdca66e//T3Zg4vmLcyIGzB41rBY7?=
 =?us-ascii?Q?yI1h2Ke61nAGElLzvlR9/jGl6wj5ciBrtof5LO/unlJN8MaVI4FrGJ5b5+xw?=
 =?us-ascii?Q?IDlhMjI2LZbebJgVwXztJ8V6SMEa9XMs6m00j31owCDgLyV0uz9LcM4n0e3I?=
 =?us-ascii?Q?nC2PZ7+oUm8pH6aOVDE4/0q0Oph8+V1/2GOz0SdH01M4obQ1tabBjyp1Idew?=
 =?us-ascii?Q?mD3dOfMzZBkZJj/8gAkRcrOOoc0NGbdNVR0mWpn7O6Dkv2nSSWv0QUx0Dnl2?=
 =?us-ascii?Q?0aPn8g98DmsqLENpdrwzikzz9Vdx2cCsWgxw1nK6WjUi/uJem26k5S0X/Kho?=
 =?us-ascii?Q?s6dzOR5/pYM9QtqfiZvxxCH0J9otQ0pa4AN5oXsHpWZ9/HY+fLWCi20bFsPO?=
 =?us-ascii?Q?8uNt1pHooh7ClXkv69rnwoesJ+gxYFt3pbTFDDVxiM9+44yYAkzGSsTkMzaj?=
 =?us-ascii?Q?GmlrDL5O75j449xFWJGQBNe8TCvByUnqOFYhw6v/7+Vu4ToqHyR1C9ziPHfP?=
 =?us-ascii?Q?mbAlpA8UoTR426JJGWeL6p2o+5oFtUfiyIOgMmzl8N3zpLOBJhHjknhbrxHo?=
 =?us-ascii?Q?Wdwh6Ni1D94TZfU3Aelxl2C+ceGzUV7zVCbhq9Xfq5x8wR87/Arh2TlnG+7W?=
 =?us-ascii?Q?zIKeoKuEQ1go+64Y3OyjvIx1vmD9EKduXGYFRI5DQviVoh16nb0RZ5xfbtt3?=
 =?us-ascii?Q?bhKFImS9ZRLpc1zyZjNVaHGjTLROcU36g9382nzM7kFg/+8T64VWnNeMExe1?=
 =?us-ascii?Q?fZl+8fNdMTpk5TWfsDgHHpJwqkGSq0kphSOoutrxQDjnFHoVlrtQBxab0N/6?=
 =?us-ascii?Q?LO/CwHbAh1XzvM7QvA1Yhx+w/QtOkgKIwp5ltdzl+e09qhIY2QxUAyGUB/WA?=
 =?us-ascii?Q?s8xmARI8/EpLz2Xuwo3mYHmy+55wyXHhEmTXlNpVohSPAjYlsyk2oR5yzQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:30:41.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 332b12bb-955d-4afa-a288-08dd8251e5bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609

Export APIs from net driver allowing RDMA driver to get basic
device configuration and RDMA capabilities to create ibdev.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/ionic/Makefile  |  2 +-
 .../net/ethernet/pensando/ionic/ionic_api.c   | 40 ++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_api.h   | 47 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  8 +---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 26 ++++++++--
 5 files changed, 110 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.c

diff --git a/drivers/net/ethernet/pensando/ionic/Makefile b/drivers/net/ethernet/pensando/ionic/Makefile
index a598972fef41..4696f8ee234f 100644
--- a/drivers/net/ethernet/pensando/ionic/Makefile
+++ b/drivers/net/ethernet/pensando/ionic/Makefile
@@ -5,5 +5,5 @@ obj-$(CONFIG_IONIC) := ionic.o
 
 ionic-y := ionic_main.o ionic_bus_pci.o ionic_devlink.o ionic_dev.o \
 	   ionic_debugfs.o ionic_lif.o ionic_rx_filter.o ionic_ethtool.o \
-	   ionic_txrx.o ionic_stats.o ionic_fw.o ionic_aux.o
+	   ionic_txrx.o ionic_stats.o ionic_fw.o ionic_aux.o ionic_api.o
 ionic-$(CONFIG_PTP_1588_CLOCK) += ionic_phc.o
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.c b/drivers/net/ethernet/pensando/ionic/ionic_api.c
new file mode 100644
index 000000000000..8c39e6183ad4
--- /dev/null
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/kernel.h>
+
+#include "ionic.h"
+#include "ionic_lif.h"
+
+struct net_device *ionic_api_get_netdev_from_handle(void *handle)
+{
+	struct ionic_lif *lif = handle;
+
+	if (!lif)
+		return ERR_PTR(-ENXIO);
+
+	dev_hold(lif->netdev);
+
+	return lif->netdev;
+}
+EXPORT_SYMBOL_NS(ionic_api_get_netdev_from_handle, "NET_IONIC");
+
+const union ionic_lif_identity *ionic_api_get_identity(void *handle,
+						       int *lif_index)
+{
+	struct ionic_lif *lif = handle;
+
+	if (lif_index)
+		*lif_index = lif->index;
+
+	return &lif->ionic->ident.lif;
+}
+EXPORT_SYMBOL_NS(ionic_api_get_identity, "NET_IONIC");
+
+const struct ionic_devinfo *ionic_api_get_devinfo(void *handle)
+{
+	struct ionic_lif *lif = handle;
+
+	return &lif->ionic->idev.dev_info;
+}
+EXPORT_SYMBOL_NS(ionic_api_get_devinfo, "NET_IONIC");
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index a7e398e1de21..f59391102c62 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -5,6 +5,8 @@
 #define _IONIC_API_H_
 
 #include <linux/auxiliary_bus.h>
+#include "ionic_if.h"
+#include "ionic_regs.h"
 
 /**
  * struct ionic_aux_dev - Auxiliary device information
@@ -18,4 +20,49 @@ struct ionic_aux_dev {
 	struct auxiliary_device adev;
 };
 
+/**
+ * struct ionic_devinfo - device information
+ * @asic_type:      Device ASIC type code
+ * @asic_rev:       Device ASIC revision code
+ * @fw_version:     Device firmware version, as a string
+ * @serial_num:     Device serial number, as a string
+ */
+struct ionic_devinfo {
+	u8 asic_type;
+	u8 asic_rev;
+	char fw_version[IONIC_DEVINFO_FWVERS_BUFLEN + 1];
+	char serial_num[IONIC_DEVINFO_SERIAL_BUFLEN + 1];
+};
+
+/**
+ * ionic_api_get_identity - Get result of device identification
+ * @handle:     Handle to lif
+ * @lif_index:  This lif index
+ *
+ * Return: pointer to result of identification
+ */
+const union ionic_lif_identity *ionic_api_get_identity(void *handle,
+						       int *lif_index);
+
+/**
+ * ionic_api_get_netdev_from_handle - Get a network device associated with the
+ *                                    handle
+ * @handle:     Handle to lif
+ *
+ * This returns a network device associated with the lif handle.
+ * If network device is available it holds the reference to device. Caller must
+ * ensure that it releases the device using dev_put() after its usage.
+ *
+ * Return: Network device on success or ERR_PTR(error)
+ */
+struct net_device *ionic_api_get_netdev_from_handle(void *handle);
+
+/**
+ * ionic_api_get_devinfo - Get device information
+ * @handle:     Handle to lif
+ *
+ * Return: pointer to device information
+ */
+const struct ionic_devinfo *ionic_api_get_devinfo(void *handle);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index c8c710cfe70c..afda7204b6e2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -12,6 +12,7 @@
 
 #include "ionic_if.h"
 #include "ionic_regs.h"
+#include "ionic_api.h"
 
 #define IONIC_MAX_TX_DESC		8192
 #define IONIC_MAX_RX_DESC		16384
@@ -139,13 +140,6 @@ static_assert(sizeof(struct ionic_vf_ctrl_cmd) == 64);
 static_assert(sizeof(struct ionic_vf_ctrl_comp) == 16);
 #endif /* __CHECKER__ */
 
-struct ionic_devinfo {
-	u8 asic_type;
-	u8 asic_rev;
-	char fw_version[IONIC_DEVINFO_FWVERS_BUFLEN + 1];
-	char serial_num[IONIC_DEVINFO_SERIAL_BUFLEN + 1];
-};
-
 struct ionic_dev {
 	union ionic_dev_info_regs __iomem *dev_info_regs;
 	union ionic_dev_cmd_regs __iomem *dev_cmd_regs;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 830c8adbfbee..f97f5d87b2ce 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -494,6 +494,16 @@ union ionic_lif_config {
 	__le32 words[64];
 };
 
+/**
+ * enum ionic_lif_rdma_cap_stats - LIF stat type
+ * @IONIC_LIF_RDMA_STAT_GLOBAL:     Global stats
+ * @IONIC_LIF_RDMA_STAT_QP:         Queue pair stats
+ */
+enum ionic_lif_rdma_cap_stats {
+	IONIC_LIF_RDMA_STAT_GLOBAL = BIT(0),
+	IONIC_LIF_RDMA_STAT_QP = BIT(1),
+};
+
 /**
  * struct ionic_lif_identity - LIF identity information (type-specific)
  *
@@ -513,10 +523,10 @@ union ionic_lif_config {
  *	@eth.config:             LIF config struct with features, mtu, mac, q counts
  *
  * @rdma:                RDMA identify structure
- *	@rdma.version:         RDMA version of opcodes and queue descriptors
+ *	@rdma.version:         RDMA capability version
  *	@rdma.qp_opcodes:      Number of RDMA queue pair opcodes supported
  *	@rdma.admin_opcodes:   Number of RDMA admin opcodes supported
- *	@rdma.rsvd:            reserved byte(s)
+ *	@rdma.minor_version:   RDMA capability minor version
  *	@rdma.npts_per_lif:    Page table size per LIF
  *	@rdma.nmrs_per_lif:    Number of memory regions per LIF
  *	@rdma.nahs_per_lif:    Number of address handles per LIF
@@ -526,12 +536,14 @@ union ionic_lif_config {
  *	@rdma.rrq_stride:      Remote RQ work request stride
  *	@rdma.rsq_stride:      Remote SQ work request stride
  *	@rdma.dcqcn_profiles:  Number of DCQCN profiles
- *	@rdma.rsvd_dimensions: reserved byte(s)
+ *	@rdma.page_size_cap:   Supported page sizes
  *	@rdma.aq_qtype:        RDMA Admin Qtype
  *	@rdma.sq_qtype:        RDMA Send Qtype
  *	@rdma.rq_qtype:        RDMA Receive Qtype
  *	@rdma.cq_qtype:        RDMA Completion Qtype
  *	@rdma.eq_qtype:        RDMA Event Qtype
+ *	@rdma.stats_type:      Supported statistics type
+ *	                       (enum ionic_lif_rdma_cap_stats)
  * @words:               word access to struct contents
  */
 union ionic_lif_identity {
@@ -557,7 +569,7 @@ union ionic_lif_identity {
 			u8 version;
 			u8 qp_opcodes;
 			u8 admin_opcodes;
-			u8 rsvd;
+			u8 minor_version;
 			__le32 npts_per_lif;
 			__le32 nmrs_per_lif;
 			__le32 nahs_per_lif;
@@ -567,12 +579,16 @@ union ionic_lif_identity {
 			u8 rrq_stride;
 			u8 rsq_stride;
 			u8 dcqcn_profiles;
-			u8 rsvd_dimensions[10];
+			u8 udma_shift;
+			u8 rsvd_dimensions;
+			__le64 page_size_cap;
 			struct ionic_lif_logical_qtype aq_qtype;
 			struct ionic_lif_logical_qtype sq_qtype;
 			struct ionic_lif_logical_qtype rq_qtype;
 			struct ionic_lif_logical_qtype cq_qtype;
 			struct ionic_lif_logical_qtype eq_qtype;
+			__le16 stats_type;
+			u8 rsvd1[162];
 		} __packed rdma;
 	} __packed;
 	__le32 words[478];
-- 
2.34.1


