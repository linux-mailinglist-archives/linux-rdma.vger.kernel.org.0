Return-Path: <linux-rdma+bounces-8219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02340A4A780
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 02:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B140C189CA9C
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726741632DF;
	Sat,  1 Mar 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o97HbJK3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638B14F11E;
	Sat,  1 Mar 2025 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793034; cv=fail; b=sWnkLUjUebNz2cBL7cyD65FbMFprq3XDwVYsejL2vFo/iEXjFuhKynz6JqCxfYqyQMSJdzYCWEiSHT6hh0a9FTKaYaS4+fNW4t5rzhuMG8QHxjStWtY4aPwAZrqrfOMn5w2F8Yq2zmn9DnO7MwZ/3eu+AXDPsn83yyeFyU62jio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793034; c=relaxed/simple;
	bh=CS16NNCN+l+5VXz3hnOdTOFWmbhMlyEzH6qGvXPgHu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVT33Wo7JQQyGKZYYR7j865+ypwOg9yhFrvVw3MBqycYB3BKFb8KcYPVeyNppLg41/QmeMQwPP6FIC1AWs/iQq5kKW0mWrYhHw2AWG1ziA6JQVHJLrbsfaqX5n7xorBl6zSQwqtJA6Mah1L80jbKxnGCLL7Prp+rnHcQd3AZj1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o97HbJK3; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIhwuKnD0KY4+7OxOdNWm0qP6pjIkpyaqk+25RU8+MkJAUPwPZa5hASPI9O5/95OGp71HdJrrPxrLCt5laJgpjILpmJdGpKJ3s2mZGn9Mg0gTw/ypmc747mNkQmslp1nx8TqAHgmnrzDGAYoUkN+gJ07qEmvUqRK4PkUFvjGZovarxS7t9AyIAiFGoIKRpZKcL2PjvKmAnLLoeIBw/lYyiUd6qQylqvf3Cdto5qqIKNTiODiPYUOAgq8Ts/l9uoK/3lLmHiNpPFoBxc8fg+j/GxlE4Bbuf01zyEscC5MCyQO6rEfMtFmoKVzoWPFlP/Gcz4canK5/5YDhz1DKttEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVzIar3JZghH5aECOcgFIQevgIfTEY51M1qE3c8WLP4=;
 b=Az2MJBPRgTNaEhVi9TOgSO7gVi/4PxLO8xAVdZXM8kWZP0H1MiFytvWBHcTLzIC3EqGocEBCyzZox3bRjjvBesM9NIy5wtxFDHBQPk1OWAdwPpTYZP4BDUblHyaU9k1qxcQV4dP6+3VtpZx8cRMScpi6ssx+yQVvNfI3m5ba1FeirQqAmvHNSV6aM1TVmCcjOo6RgoacxPmzPZ45so2vw2aCQ+geceKf5BgDdHfJoorp3uiG/1v72RB4RH/QoYDJ6neifwxkyWb3nFld1+qbe7S2/IF3bGnxRMOUBP/Ss8iqYkkzHxfn2pOV2EQgV4v5H5o4V92Z4I4H/DwafJtuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVzIar3JZghH5aECOcgFIQevgIfTEY51M1qE3c8WLP4=;
 b=o97HbJK3vKKcosbTe1Mf4GM7JfhBXVTLKnY/KiliWEB76KV3y6ahxfEL5tzTmLyA8vk6sWKQPHnm4hpDnUkGea7XOQNeqMRDjNf4H6RsgPg7tRhb6gZlVE21Q97Eyi/yviF7nZU1uYWCmrt+wpi1CY/PkA7PXhoNwM+rLbUeZ3Y=
Received: from BYAPR06CA0002.namprd06.prod.outlook.com (2603:10b6:a03:d4::15)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sat, 1 Mar
 2025 01:37:07 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::5) by BYAPR06CA0002.outlook.office365.com
 (2603:10b6:a03:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Sat,
 1 Mar 2025 01:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Sat, 1 Mar 2025 01:37:07 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 19:37:04 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 4/6] pds_fwctl: initial driver framework
Date: Fri, 28 Feb 2025 17:35:52 -0800
Message-ID: <20250301013554.49511-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250301013554.49511-1-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fdcf45-cbb1-4356-db64-08dd58619406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|30052699003|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/m3ZAy61oYsEhpvzmp6RvrlgguLS91bfMF7kAe5dSM4m9vy2Igo/tnGIa7NK?=
 =?us-ascii?Q?gYzsQEXR6Bmxe28O+8bS/pRt6VmppktOeETEYE9wnK6usysCrXXiP1F+/lb8?=
 =?us-ascii?Q?MEyw+8kjTXWO5qPDJl7B6olP6OJRz352sE11oR0j9mqU4gUAumFoW1sRG7aJ?=
 =?us-ascii?Q?K+zw2QJhI+X+iS3oJCxDBIiC3y/ltG+HHjtRKnHt5+/2p0bswOs+S0x0pHw4?=
 =?us-ascii?Q?9CplFOufzn/cEdKYfaonMyB2TfLXR7BuOz6tAeJHJzYIWdXCcpJ78MUJmspZ?=
 =?us-ascii?Q?IEn6r8ULrEMQVD+UCMl93ebEEqC97wweTwPAWLWRZZh/hx4Ij5VWzcAbYoh8?=
 =?us-ascii?Q?dRFEPclMkuC4aJxRAoqR+swCHgVAEXloJy8xIejGzRGtsSD4SHp4acz69Hxe?=
 =?us-ascii?Q?LZimTjB5V2dzylx8+VFhoJW79ab8NvkuGbfEYaLJt4eGTqpJxhtr6y32oeVm?=
 =?us-ascii?Q?KU6Db8tr7w3gMmpxrYx8o4IrVWfJtcCkgTCiiotVQHcNV3PBeRAt9904Bp/N?=
 =?us-ascii?Q?PoTu97GPgXdzCfgigaQ5nmTnnhUzipx+rUp8qG4drsZF4pAvheEx7OFoqPXM?=
 =?us-ascii?Q?zaTDXJmPAlUSGNx3rWnEzzUGsTXIqA7yT3FEMzKmmTNrrf3pUmNDspoQ9gkc?=
 =?us-ascii?Q?+0CO03wqt0mb3i/LJqzWtC8ivl5Ox/s2Prky+BjM3/f0w+O1fqjyTeD1S5Ez?=
 =?us-ascii?Q?NuFf8VEcbtm+QsSua5k77Dqbkw4/6v3g5SYmAmjqW+CUtBJh2U368kBqAb3t?=
 =?us-ascii?Q?Vgkzvd36QgifWMCJ4bsQ4yuTuhIjU34nHJ4LPWPoyH1xLCpKLF0ddbsO/GP8?=
 =?us-ascii?Q?9llBcW7GBcn2bOgxA19jvZT60kO3oSrwITJqxSQWD1UV5j07so094e+1N0Bx?=
 =?us-ascii?Q?vjMcI2GqaaD8+StiZ/0eHQk52CO91T9UFEgLgdBo+IdZMoH1ebm579HYTwDV?=
 =?us-ascii?Q?S5r8i7/JL2Z8hfImFPyL+w1CxphL+B5tKE+03UOSlm76+BNFbTfnlDAQAIOe?=
 =?us-ascii?Q?QjmzmDChGWG1UjwAMLYxdPtEg8O/OAuBb6VSwl3XvZPPdcHKKyXPTt++lxRh?=
 =?us-ascii?Q?yHSUJsCVyEtdhHGOOUpkG3w1a/oNyc2a0350vtTvfAUvEdDjxO/+jx+TMDC1?=
 =?us-ascii?Q?B+zp4ULKh7TVZWDmGqQ4XA+e18IeJf6nGoCYNJOkugPxqGXf0Efuz0GlNid1?=
 =?us-ascii?Q?8I4xrymUGI9q7uo+qUgXVgcbc3qUfPaUfyCCKzBB+6/Dkpiq5Ry/on+A5YMs?=
 =?us-ascii?Q?B0UgWzJS6QJjVE6DaoDRKV6bOzahV3RGXbcDDBeWLJ6mUp/35iYD9g0xPrSu?=
 =?us-ascii?Q?pOVF09AhADeXxQ7WlbOlYsSHgaySlhT8NFgxWrtTgFPoiASb1guwowPKENt3?=
 =?us-ascii?Q?0LgBtp7ULsbjYaJIrd27eoKCPY3ozjEHqiOZH5pWlRJjPhxPtvt7+yKZ96vF?=
 =?us-ascii?Q?KvxyWFNzL0pcW8Yiod59Y8y1ZePwyed3IfremjIQiQy2d8svwWdUAx4ezQmM?=
 =?us-ascii?Q?sQfhMMCzLJNZCi+AT0hFu0vP4ublYd2+kouF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(30052699003)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2025 01:37:07.3309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fdcf45-cbb1-4356-db64-08dd58619406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324

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
 drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
 include/linux/pds/pds_adminq.h |  77 +++++++++++++++
 include/uapi/fwctl/fwctl.h     |   1 +
 include/uapi/fwctl/pds.h       |  27 ++++++
 8 files changed, 296 insertions(+)
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d2700d1ba0f..a396726feb6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9601,6 +9601,13 @@ T:	git git://linuxtv.org/media.git
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
@@ -2,4 +2,5 @@
 obj-$(CONFIG_FWCTL) += fwctl.o
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
index 000000000000..afc7dc283ad5
--- /dev/null
+++ b/drivers/fwctl/pds/main.c
@@ -0,0 +1,169 @@
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
+	struct pds_fwctl_ident ident;
+};
+DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
+
+static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
+	struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
+
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
+static int pdsfc_identify(struct pdsfc_dev *pdsfc)
+{
+	struct device *dev = &pdsfc->fwctl.dev;
+	union pds_core_adminq_comp comp = {0};
+	union pds_core_adminq_cmd cmd;
+	struct pds_fwctl_ident *ident;
+	dma_addr_t ident_pa;
+	int err = 0;
+
+	ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
+	err = dma_mapping_error(dev->parent, ident_pa);
+	if (err) {
+		dev_err(dev, "Failed to map ident buffer\n");
+		return err;
+	}
+
+	cmd = (union pds_core_adminq_cmd) {
+		.fwctl_ident = {
+			.opcode = PDS_FWCTL_CMD_IDENT,
+			.version = 0,
+			.len = cpu_to_le32(sizeof(*ident)),
+			.ident_pa = cpu_to_le64(ident_pa),
+		}
+	};
+
+	err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
+	if (err)
+		dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
+			cmd.fwctl_ident.opcode, err);
+	else
+		pdsfc->ident = *ident;
+
+	dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
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
+	struct pds_auxiliary_dev *padev =
+			container_of(adev, struct pds_auxiliary_dev, aux_dev);
+	struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
+			fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
+					   struct pdsfc_dev, fwctl);
+	struct device *dev = &adev->dev;
+	int err;
+
+	if (!pdsfc) {
+		dev_err(dev, "Failed to allocate fwctl device struct\n");
+		return -ENOMEM;
+	}
+	pdsfc->padev = padev;
+
+	err = pdsfc_identify(pdsfc);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to identify device\n");
+
+	err = fwctl_register(&pdsfc->fwctl);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register device\n");
+
+	auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
+
+	return 0;
+}
+
+static void pdsfc_remove(struct auxiliary_device *adev)
+{
+	struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&pdsfc->fwctl);
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
+MODULE_IMPORT_NS("FWCTL");
+MODULE_DESCRIPTION("pds fwctl driver");
+MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
+MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 4b4e9a98b37b..ae6886ebc841 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
 	u8     status;
 };
 
+enum pds_fwctl_cmd_opcode {
+	PDS_FWCTL_CMD_IDENT = 70,
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
@@ -44,5 +44,6 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
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


