Return-Path: <linux-rdma+bounces-7662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C4A319E0
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C8F167BBD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 23:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC826F46D;
	Tue, 11 Feb 2025 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cHEp+FRU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03326B97E;
	Tue, 11 Feb 2025 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317766; cv=fail; b=fdNmN5aGxVrgyGC3TThZ+TopLgpd+ttrSU/f92R52gBy+7k5oHmQXDHXaFwFYy7thrySmmXOwNet6RAT2d3zQ6CDZctRHIghwT1mkM+1xyqVix55RzIfEkApF9htvXa5aaMX+TCk2DYWAZkqk3UEWPc2LJmbBXP8ZiVwSf2Etzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317766; c=relaxed/simple;
	bh=046E5BeG5BDYHSfZK4/NyB6tNRTUUFTuwWGzyi9Sxmg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPQXY3QPEL7bg1JCbCq/ZhV5jxwA0qGOLGOMPaOxpRFPQgMz9g4Sqqrwz8N9561jSBEGVAxKgbUqwfqaVYmWozAYIAvNk/bBGjrBHVEUxBUCpysnDH9mBOzPHaK+lZNxJv879E6+NHH5KtfzJ08hiBzAV0+5usb0V41Wzn7OzPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cHEp+FRU; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kz2pBh/vjmr4n8VFIzxAmXDWBt8U/FuL1Pd6Xo6dW3t7AXN8k9fF6JdNbpLpqDbArdWbdNEeklZX5i8hrnpdpUw+fJXHcqDQiA7+EbE+RZv1USwwH1wl5XQq55KmXXxyH1sm0Lk/YsVmJlOD5N48sMwAWo7HMm92tS/M5eZwFfnsnQ/HGZTp6hFTGFBsqVp5arD/TKEH0qh5etuTBjGhbmgmTeJdQi2anaY5DFtuZJMcMR1WPlXdvZV7yQc6yRfZIqgWO4P4nVluy/yztFzrU+9tk6nGrtYhdCuFVsmCRDcPJUssWmNrlCk0jKyXAFjeu1EC2ITnVceun0/m+PUXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fqo2u3+sTnFbHlVaVgddCB01+Lkbjp5eb3eGUBeQFw=;
 b=cVuYIKc6z+227DevVnVGDLrcPSUy16oXELvUhUOAr8/Ndz1i1h/tA0WKNFn4kFI0MqmS9VSZl8/pPP3gfyHrSPJUR/WKPSvTvCWpt9Ccg+y3AsXAWU8zWgPii2CzSyXyNB/UsxbAWnNihPNvN2roCQLE940hhCJoXS3t7ILJucf6/q74vEkeI54XGjXrDgUnqZbOBAJEt6IiC+pn4241t++XFL8M0yFRi8r0RD1+7oixHe57dAp2QOmVgjfM00lr8CLFwx5ALaAk1Zz0tqsuy6gEq3D/s4vcy4lSUmtSw/aBOnTeW12A2KEl4q5q412ThuFUd3Vwq4s/j/yEifnrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fqo2u3+sTnFbHlVaVgddCB01+Lkbjp5eb3eGUBeQFw=;
 b=cHEp+FRU6fZXX5axSxWs4gdtVzI0rcxYhxxBRPisQ6vEnlULhOmSgefM5HlKCgr16tkgb+Hes/JaE11OTFQhu1YCMRmxz4u4wZcI8zz4Yt2jwNMuQYxORgOtRkKv4SLOxOia2Ret6IhWifo1LDzqM2jv8lCxo+Irw+sKwq9lWlM=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 23:49:17 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::28) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 23:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 23:49:16 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 17:49:14 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <saeedm@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
Date: Tue, 11 Feb 2025 15:48:52 -0800
Message-ID: <20250211234854.52277-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250211234854.52277-1-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 13608c6f-4db6-4f3e-a17d-08dd4af6b23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014|30052699003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Te9x2pV/xnGMZumRYVRdyZBcn7fCwJVX+3jQ2f3FgBFk7dEeue/cwROveKii?=
 =?us-ascii?Q?cR8lUjfxuGDMN+bk/QpNG7W3S1j5sWP0DtWu8JnRwC72NW7od2et7e9iR4Jl?=
 =?us-ascii?Q?tpaK1s4l3oth7XSWNWz7s1EmfreSeDxJeWO5okNuhFqtMBf7fAtzkNxtnA+w?=
 =?us-ascii?Q?VYtpeey7J3QR/EMabSP2MBwCOrACgxsYA1t84783QKmk1bj6y6uDIpIBG1ZT?=
 =?us-ascii?Q?rLw98Yl+KzRxKBTwPlJR7tdX6gHMExTPB7jxegXiNz7aYth2ssm4fxZNHzxG?=
 =?us-ascii?Q?ziZviRt+yHu1HR4K70ogcD0FzhHhVt+f81eFym6ce7eRQ57wKt0LDwH2Akld?=
 =?us-ascii?Q?Iwl1RR57q/68v8P6R8LZj8R9BKaPIeI1v70q2PjqZQjf62RmbKx1AunC3O1z?=
 =?us-ascii?Q?HcJ0VcQF0XYT9IZD/TtGBfA/H+4sEu3bvB+Sv52WU3tRqu+5za42yjbHmwz/?=
 =?us-ascii?Q?9cRaDOqfn3qavN9Vv7H2zub392Orc/deHqRDIYzE4NWXRxmLZt900Q5fK38h?=
 =?us-ascii?Q?sExaN+Z4NdxBNSHE1dDGZEQPjK14QALDzk8kb7No3vTq2MQSQ6/1x7z4gtQr?=
 =?us-ascii?Q?VkKzcIZdknLZmCxIHaMLXNzR/ET3R5d6nnUQjgr2l2Iy1MkzBb68cudHHTLz?=
 =?us-ascii?Q?AJuDDN2Ecs2t8NiV4C4HRi9EcY/vvjKjyK42E7AP7eNCidTGqBpmIdSClaoM?=
 =?us-ascii?Q?2TJwK8Mj2VCF6b6NlExaTdHkeHw3PyzMtfe8PFTS6dvaMx4g2hZWq99QGEkU?=
 =?us-ascii?Q?LOEQHERkeIdcnnS8kEa8pwk9LH62Xv5hPhpbZ1XGMHsMyDZuAgBN24d0Mc2y?=
 =?us-ascii?Q?RKlUcnfPmKQG1LlAV9HT+Yy11XE6QlVhDIk+A5c+K0ATgXYw+obFjfF/3f8r?=
 =?us-ascii?Q?KSnujtRiy86GLSaLPJAAAAe/pdoF7pMszhhLOgDkFAJrdTyx5oU81XqelhgQ?=
 =?us-ascii?Q?2sYCsjmCjuWqaMyVPK6Qs5VKPsXiYG/e8AyqsSAzG3vg2xIn3ibL5cnTex3y?=
 =?us-ascii?Q?4wo+W3vez0pruVjLH/jWrInmhQwl7t2XX1FmO++BmLLxJ7k+KvF8KV4m+Jr1?=
 =?us-ascii?Q?Ya8gNLeadmKml2kvqKc5wNR6ka6zVBK34Mb02ALCW+oXlBVxdgVcK897ht+u?=
 =?us-ascii?Q?oEoqD+egQ/y4uWE8UN0Bxw8dp84GhtBHMhxWk93KoYnY4NFr7YewPWPVePKn?=
 =?us-ascii?Q?Kyf0zeoco9qNa9kWMC268fA/2kjYDdgOghLPH7H7nf4xo1worlPIVIJ0I1sL?=
 =?us-ascii?Q?kEASss4/0//FqiGpscyAAgf8EzjowllQqbmTBJ73g1D/cjryyZ8ezWqsGMwi?=
 =?us-ascii?Q?4SlS2RqlKPBIhzbJwlo7/2WzbUg9Ap+vE0IRnDpCGLMYVAaBRvIW4mntqg3+?=
 =?us-ascii?Q?6HVnh7+fq5faZ7NqREs3oTl2BbwskU22xykhyQQkWki86vZ8inKdTlBT3mtM?=
 =?us-ascii?Q?aEguraoLYjFsW8VnhZPfHS8H+6X+wU/4pZZzqsZIq0ei2HD4YHLstlIU1NvN?=
 =?us-ascii?Q?ECvQiYCa2hCJYXA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014)(30052699003)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:49:16.7397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13608c6f-4db6-4f3e-a17d-08dd4af6b23d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491

Initial files for adding a new fwctl driver for the AMD/Pensando PDS
devices.  This sets up a simple auxiliary_bus driver that registers
with fwctl subsystem.  It expects that a pds_core device has set up
the auxiliary_device pds_core.fwctl

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 MAINTAINERS                    |   7 ++
 drivers/fwctl/Kconfig          |  10 ++
 drivers/fwctl/Makefile         |   1 +
 drivers/fwctl/pds/Makefile     |   4 +
 drivers/fwctl/pds/main.c       | 195 +++++++++++++++++++++++++++++++++
 include/linux/pds/pds_adminq.h |  77 +++++++++++++
 include/uapi/fwctl/fwctl.h     |   1 +
 include/uapi/fwctl/pds.h       |  27 +++++
 8 files changed, 322 insertions(+)
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 413ab79bf2f4..123f8a9c0b26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9602,6 +9602,13 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
 F:	drivers/media/i2c/gc2145.c
 
+FWCTL PDS DRIVER
+M:	Brett Creeley <brett.creeley@amd.com>
+R:	Shannon Nelson <shannon.nelson@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/pds/
+
 GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
 M:	Tim Harvey <tharvey@gateworks.com>
 S:	Maintained
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index 0a542a247303..df87ce5bd8aa 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -28,5 +28,15 @@ config FWCTL_MLX5
 	  This will allow configuration and debug tools to work out of the box on
 	  mainstream kernel.
 
+	  If you don't know what to do here, say N.
+
+config FWCTL_PDS
+	tristate "AMD/Pensando pds fwctl driver"
+	depends on PDS_CORE
+	help
+	  The pds_fwctl driver provides an fwctl interface for a user process
+	  to access the debug and configuration information of the AMD/Pensando
+	  DSC hardware family.
+
 	  If you don't know what to do here, say N.
 endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 5fb289243286..692e4b8d7beb 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_FWCTL) += fwctl.o
 obj-$(CONFIG_FWCTL_BNXT) += bnxt/
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
+obj-$(CONFIG_FWCTL_PDS) += pds/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
new file mode 100644
index 000000000000..c14cba128e3b
--- /dev/null
+++ b/drivers/fwctl/pds/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
+
+pds_fwctl-y += main.o
diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
new file mode 100644
index 000000000000..24979fe0deea
--- /dev/null
+++ b/drivers/fwctl/pds/main.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) Advanced Micro Devices, Inc */
+
+#include <linux/module.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include <uapi/fwctl/fwctl.h>
+#include <uapi/fwctl/pds.h>
+#include <linux/fwctl.h>
+
+#include <linux/pds/pds_common.h>
+#include <linux/pds/pds_core_if.h>
+#include <linux/pds/pds_adminq.h>
+#include <linux/pds/pds_auxbus.h>
+
+struct pdsfc_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+	u32 uctx_uid;
+};
+
+struct pdsfc_dev {
+	struct fwctl_device fwctl;
+	struct pds_auxiliary_dev *padev;
+	struct pdsc *pdsc;
+	u32 caps;
+	dma_addr_t ident_pa;
+	struct pds_fwctl_ident *ident;
+};
+DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
+
+static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
+	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
+	struct device *dev = &uctx->fwctl->dev;
+
+	dev_dbg(dev, "%s: caps = 0x%04x\n", __func__, pdsfc->caps);
+	pdsfc_uctx->uctx_caps = pdsfc->caps;
+
+	return 0;
+}
+
+static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
+	struct fwctl_info_pds *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uctx_caps = pdsfc_uctx->uctx_caps;
+
+	return info;
+}
+
+static void pdsfc_free_ident(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+
+	if (pdsfc->ident) {
+		dma_free_coherent(dev, sizeof(*pdsfc->ident),
+				  pdsfc->ident, pdsfc->ident_pa);
+		pdsfc->ident = NULL;
+		pdsfc->ident_pa = DMA_MAPPING_ERROR;
+	}
+}
+
+static int pdsfc_identify(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	union pds_core_adminq_cmd cmd = {0};
+	struct pds_fwctl_ident *ident;
+	dma_addr_t ident_pa;
+	int err = 0;
+
+	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev->parent, ident_pa);
+	if (err) {
+		dev_err(dev, "Failed to map ident\n");
+		return err;
+	}
+
+	cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
+	cmd.fwctl_ident.version = 0;
+	cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
+	cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);
+
+	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
+	if (err) {
+		dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
+		dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
+			cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
+		return err;
+	}
+
+	pdsfc->ident = ident;
+	pdsfc->ident_pa = ident_pa;
+
+	dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
+		ident->version, ident->max_req_sz, ident->max_resp_sz,
+		ident->max_req_sg_elems, ident->max_resp_sg_elems);
+
+	return 0;
+}
+
+static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			  void *in, size_t in_len, size_t *out_len)
+{
+	return NULL;
+}
+
+static const struct fwctl_ops pdsfc_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_PDS,
+	.uctx_size = sizeof(struct pdsfc_uctx),
+	.open_uctx = pdsfc_open_uctx,
+	.close_uctx = pdsfc_close_uctx,
+	.info = pdsfc_info,
+	.fw_rpc = pdsfc_fw_rpc,
+};
+
+static int pdsfc_probe(struct auxiliary_device *adev,
+		       const struct auxiliary_device_id *id)
+{
+	struct pdsfc_dev *pdsfc __free(pdsfc_dev);
+	struct pds_auxiliary_dev *padev;
+	struct device *dev = &adev->dev;
+	int err = 0;
+
+	padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
+	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
+				   struct pdsfc_dev, fwctl);
+	if (!pdsfc) {
+		dev_err(dev, "Failed to allocate fwctl device struct\n");
+		return -ENOMEM;
+	}
+	pdsfc->padev = padev;
+
+	err = pdsfc_identify(pdsfc);
+	if (err) {
+		dev_err(dev, "Failed to identify device, err %d\n", err);
+		return err;
+	}
+
+	err = fwctl_register(&pdsfc->fwctl);
+	if (err) {
+		dev_err(dev, "Failed to register device, err %d\n", err);
+		return err;
+	}
+
+	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
+
+	return 0;
+
+free_ident:
+	pdsfc_free_ident(pdsfc);
+	return err;
+}
+
+static void pdsfc_remove(struct auxiliary_device *adev)
+{
+	struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&pdsfc->fwctl);
+	pdsfc_free_ident(pdsfc);
+}
+
+static const struct auxiliary_device_id pdsfc_id_table[] = {
+	{.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
+
+static struct auxiliary_driver pdsfc_driver = {
+	.name = "pds_fwctl",
+	.probe = pdsfc_probe,
+	.remove = pdsfc_remove,
+	.id_table = pdsfc_id_table,
+};
+
+module_auxiliary_driver(pdsfc_driver);
+
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("pds fwctl driver");
+MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
+MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 4b4e9a98b37b..7fc353b63353 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
 	u8     status;
 };
 
+enum pds_fwctl_cmd_opcode {
+	PDS_FWCTL_CMD_IDENT		= 70,
+};
+
+/**
+ * struct pds_fwctl_cmd - Firmware control command structure
+ * @opcode: Opcode
+ * @rsvd:   Word boundary padding
+ * @ep:     Endpoint identifier.
+ * @op:     Operation identifier.
+ */
+struct pds_fwctl_cmd {
+	u8     opcode;
+	u8     rsvd[3];
+	__le32 ep;
+	__le32 op;
+} __packed;
+
+/**
+ * struct pds_fwctl_comp - Firmware control completion structure
+ * @status:     Status of the firmware control operation
+ * @rsvd:       Word boundary padding
+ * @comp_index: Completion index in little-endian format
+ * @rsvd2:      Word boundary padding
+ * @color:      Color bit indicating the state of the completion
+ */
+struct pds_fwctl_comp {
+	u8     status;
+	u8     rsvd;
+	__le16 comp_index;
+	u8     rsvd2[11];
+	u8     color;
+} __packed;
+
+/**
+ * struct pds_fwctl_ident_cmd - Firmware control identification command structure
+ * @opcode:   Operation code for the command
+ * @rsvd:     Word boundary padding
+ * @version:  Interface version
+ * @rsvd2:    Word boundary padding
+ * @len:      Length of the identification data
+ * @ident_pa: Physical address of the identification data
+ */
+struct pds_fwctl_ident_cmd {
+	u8     opcode;
+	u8     rsvd;
+	u8     version;
+	u8     rsvd2;
+	__le32 len;
+	__le64 ident_pa;
+} __packed;
+
+/**
+ * struct pds_fwctl_ident - Firmware control identification structure
+ * @features:    Supported features
+ * @version:     Interface version
+ * @rsvd:        Word boundary padding
+ * @max_req_sz:  Maximum request size
+ * @max_resp_sz: Maximum response size
+ * @max_req_sg_elems:  Maximum number of request SGs
+ * @max_resp_sg_elems: Maximum number of response SGs
+ */
+struct pds_fwctl_ident {
+	__le64 features;
+	u8     version;
+	u8     rsvd[3];
+	__le32 max_req_sz;
+	__le32 max_resp_sz;
+	u8     max_req_sg_elems;
+	u8     max_resp_sg_elems;
+} __packed;
+
 union pds_core_adminq_cmd {
 	u8     opcode;
 	u8     bytes[64];
@@ -1216,6 +1288,9 @@ union pds_core_adminq_cmd {
 	struct pds_lm_dirty_enable_cmd	  lm_dirty_enable;
 	struct pds_lm_dirty_disable_cmd	  lm_dirty_disable;
 	struct pds_lm_dirty_seq_ack_cmd	  lm_dirty_seq_ack;
+
+	struct pds_fwctl_cmd		  fwctl;
+	struct pds_fwctl_ident_cmd	  fwctl_ident;
 };
 
 union pds_core_adminq_comp {
@@ -1243,6 +1318,8 @@ union pds_core_adminq_comp {
 
 	struct pds_lm_state_size_comp	  lm_state_size;
 	struct pds_lm_dirty_status_comp	  lm_dirty_status;
+
+	struct pds_fwctl_comp		  fwctl;
 };
 
 #ifndef __CHECKER__
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 518f054f02d2..a884e9f6dc2c 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -44,6 +44,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
 	FWCTL_DEVICE_TYPE_BNXT = 3,
+	FWCTL_DEVICE_TYPE_PDS = 4,
 };
 
 /**
diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
new file mode 100644
index 000000000000..a01b032cbdb1
--- /dev/null
+++ b/include/uapi/fwctl/pds.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright(c) Advanced Micro Devices, Inc */
+
+/*
+ * fwctl interface info for pds_fwctl
+ */
+
+#ifndef _UAPI_FWCTL_PDS_H_
+#define _UAPI_FWCTL_PDS_H_
+
+#include <linux/types.h>
+
+/*
+ * struct fwctl_info_pds
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_pds {
+	__u32 uid;
+	__u32 uctx_caps;
+};
+
+enum pds_fwctl_capabilities {
+	PDS_FWCTL_QUERY_CAP = 0,
+	PDS_FWCTL_SEND_CAP,
+};
+#endif /* _UAPI_FWCTL_PDS_H_ */
-- 
2.17.1


