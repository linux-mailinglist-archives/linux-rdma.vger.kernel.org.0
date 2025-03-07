Return-Path: <linux-rdma+bounces-8484-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD0A570DC
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 19:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB873B927E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DF52459F0;
	Fri,  7 Mar 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fo855cJ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434024DFF2;
	Fri,  7 Mar 2025 18:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373646; cv=fail; b=c+hwOdjr54ZRP77VBTsYwnaYEvWiK/eyKHcGpxOhd7stTHbIg1ZTDdLA+NkyX9Bjkvscl4pZZaISsOE5I35yCkHNNtCfhwqGQKhBAnpsB8/6Ba5/JHxMACBC55um4KBJy5AJ94BpUvnBwWEH5yUKdHVrVwpYMsedrLi0W4A6HEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373646; c=relaxed/simple;
	bh=Rt3n76trJABtG3883MsgAMyYNQCfQJUbyRSyA8rbvCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBzAcuPlt/D9afzcJShJVdlW/uH7jHp3cgyOp/HcE/yG3dEJKO0ot+0fJI/RfK+NVv+UmTnODKqm+Xeexp6mwCCnOVdyjY4WdbrLozNzB7UbpBhtkpF9oEqmT0bu7BYdiRDvCjepl2iCwHzduYBYZs4hYULNil4iVZOp/7nZ+aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fo855cJ+; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOR5puWymoeX/UJ3daY8eawkCx19LLhy5dcoLuD38c8yEGiW3CJABhrfJtnJfEYU0PsGPvh69nHNxA5zSM2nWkmO8FWCpmPi7lvYjh7s4qweBAaYD/MAC3DJ9IoO4Ulo2JocMnBCGdLUT7n7xYatlAHVykm4eFYWzeU6RdIMYFoLHzTOJLv1cW0GW4+l2e1BFRYS8nbuo/y6cm+poB69jwF2qrv40lOwfmbKjQgzKK4FjcrAVfcxfCortQU0gENnsuYzVr4LhCAHOdOStrtBfnSPtliSDT9X29aYMKzTexBIkuhFqNn1DWm81RPG5sm0DsB1sEBzdP7bC3YAtAiYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usHu6kMMNS9FNwRv7VI7m0eUmTFOkovDelnzlDmHHEk=;
 b=dhoTYMv3Sy7G2dK9QJrpW7PtPQSWa9RBA7kcY9AtkMjrXvzWA9dOQXIU0epDC0A2dBrX5TjQ6ouqtjoMwrjSNdVjsJGO4XdkSNqS3lY+1embp56IZrMQKc8ZhAjcOEeKVYkAY3ezccUEr2BIYsjpd2PU/qGYP0ppndKTcrOSPOQ/h1fLlY8axuNewz0eTUwg8OC0xw+RQK3s5skhNQXFdG8PBXXlXbSJK3jMKPZckeidxYer5Hq+NuPt2D0O1bJwOTRP8L2y9NFBNHjnd/lpU1QmJDWQZe27gK0T4cqGTE61RvKEOJfpQQYHYgSHCrWizxQ53KP9B3ezDFbtLMYTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usHu6kMMNS9FNwRv7VI7m0eUmTFOkovDelnzlDmHHEk=;
 b=fo855cJ+yrbD78N8PPnl7QnRBSQH4573+CScfz8vK/U0jg4DEPeFsQJk90Ph+tElB4YWiA1TSu3/4LWKWCYBYG7Uj0a1s1RNzWwy/GIFqupOK7bu0hna2V6DF+eW41/nKvBBgN3xwFtX48o8dB8rqs2pDrOl3j3q3nj9qI8+5pU=
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 18:53:58 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::1f) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 18:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:53:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:53:56 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 4/6] pds_fwctl: initial driver framework
Date: Fri, 7 Mar 2025 10:53:27 -0800
Message-ID: <20250307185329.35034-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250307185329.35034-1-shannon.nelson@amd.com>
References: <20250307185329.35034-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 151ea327-b412-4d37-2736-08dd5da96aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|7416014|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+AYcU/fHt/rlJsjYHjvDONUCol/9FMevRx6dXIoFJRECo/Gigh3ffjTUwVO?=
 =?us-ascii?Q?vrNeGPZyon3FaWKSTGDW96ANuGv2Jr64N9LQyVniCG+LX+7sjHXXEEo1Buif?=
 =?us-ascii?Q?yp1li/iirGgJrU+cP2JvIgxIxDVvnFL+HFllseQxPbUl1TcA8HDU4gSuqFux?=
 =?us-ascii?Q?2u8L7xbQm5ZbfZvRejLr83V61w9/Y4pwsCpx8pGV0FcOE7ucxX7jyvhO5Xqb?=
 =?us-ascii?Q?EIctPwgYJisXWstLDE4lZfG//OiEA3+QX6AvrxlLyDARGepferiDh5LhClmR?=
 =?us-ascii?Q?tflzOSBdHhT/v4hXOlGsYEEFZbn3VH0a9eDCY3CXxlGsO2sY7QUOH/vOX2T5?=
 =?us-ascii?Q?ttCltpqh2gaXDLFvAvKXixUYcMLSmMA6+nsTMFLitfk1GQxEVNywC/0xILQw?=
 =?us-ascii?Q?k5vFQiYttkeHxbRkNX+cVD+TWYMG5tZ46fRidSGYCD35Y42+QYz9Q8dmr3pE?=
 =?us-ascii?Q?9dNefmjTLmQRuBmRJpWl/RV8+Sk6UTF4LNv9bY30NFKihcgzoc/whfUTuwJf?=
 =?us-ascii?Q?36uzxqG7H0WootSQ3LZokTaLTjXCv2BEC757JsjDxTFuqJaVZZk7lpoO20tp?=
 =?us-ascii?Q?CuwD33PwQJ+Vb9NG0oum6MUMrrc8EFWSZCvRjH/EPKbR4/NcvVzOgvlxZA7k?=
 =?us-ascii?Q?aiWxaxYEV3ZwMjl1vNlFD5esiyZsWMCp4DmxBmiNJ1hMg8dbS0UcjSEEtPsN?=
 =?us-ascii?Q?+TNVUOPlQ0tBuxtAKaVeS7Wqpib9WBdcYwVWdVdJQLRtweYeeAl7xGuK0MXJ?=
 =?us-ascii?Q?v+36AoEmgKI0LGlN8fqDTZYyCjRpPBld+oonOAUcngtlIoJvcZk6/sPDMNJf?=
 =?us-ascii?Q?Mygn7jgof7gjlNDJnpVzwiOYCakxm60ZDSZ/86Tm5dIH6RSDLfrXPdDuIsta?=
 =?us-ascii?Q?/n+e4ot60DPZYaqdgBTw7EZEVUCaLgl6O8OE6TXYiulRutValIxMRV2ZD1VJ?=
 =?us-ascii?Q?byCh/ngbm3y7n9guSHtpjscSetz3h+Wqk441UGmpQhUXSl1fN9Ik9uTSdnVV?=
 =?us-ascii?Q?xm0Ksb9i7lza58tA/Prb2g6IkcMYuEWAwurVYspLAEn6pb43GsZtD93sBVKz?=
 =?us-ascii?Q?6tNlLDBw+aWaRnfO4L38QNfApncyhN9DgjdVIwOzu6JUXDKSYUGSm4MRVBXb?=
 =?us-ascii?Q?w0D/mJ9LVmi0cfO6wa/MkYVPb/X3CwOgOiWG83B36bYaIGUCAbPUFlhptecR?=
 =?us-ascii?Q?E5aT6TCRfz6eUxf4e3CgKLw5Rw3ZAOWx1w642a85Qjd7AHQ+KGaxDtJ2SLfd?=
 =?us-ascii?Q?4trQi2h5XcmjlH3bRQvZSqBfz8l9YpeL9QvoShHnAexgmm+4SCoySHZ680Bh?=
 =?us-ascii?Q?uv10S2epyUPuybII6RRD2R24AFgKsOA4e2Pz2yvh+IHehieGmwzxEYn9ZGGc?=
 =?us-ascii?Q?4K3MYgZ4tM9Ll0bAkIZz4mBjhEH+6xTfE+YYNXCdDq1gBMetHGD7itvutXek?=
 =?us-ascii?Q?fujjwgdFjheXwvsj3T8WpVErbP/7D6a4UYX4TtmNm68mLZUlWDa/qRGN6fsJ?=
 =?us-ascii?Q?dXUtA8q8650LAYg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(7416014)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:53:58.0440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 151ea327-b412-4d37-2736-08dd5da96aea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

Initial files for adding a new fwctl driver for the AMD/Pensando PDS
devices.  This sets up a simple auxiliary_bus driver that registers
with fwctl subsystem.  It expects that a pds_core device has set up
the auxiliary_device pds_core.fwctl

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 MAINTAINERS                    |   7 ++
 drivers/fwctl/Kconfig          |  10 ++
 drivers/fwctl/Makefile         |   1 +
 drivers/fwctl/pds/Makefile     |   4 +
 drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
 include/linux/pds/pds_adminq.h |  83 ++++++++++++++++
 include/uapi/fwctl/fwctl.h     |   1 +
 include/uapi/fwctl/pds.h       |  26 +++++
 8 files changed, 301 insertions(+)
 create mode 100644 drivers/fwctl/pds/Makefile
 create mode 100644 drivers/fwctl/pds/main.c
 create mode 100644 include/uapi/fwctl/pds.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3381e41dcf37..c63fd76a3684 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9576,6 +9576,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/mlx5/
 
+FWCTL PDS DRIVER
+M:	Brett Creeley <brett.creeley@amd.com>
+R:	Shannon Nelson <shannon.nelson@amd.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/pds/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index f802cf5d4951..b5583b12a011 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -19,5 +19,15 @@ config FWCTL_MLX5
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
index 1c535f694d7f..c093b5f661d6 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
+obj-$(CONFIG_FWCTL_PDS) += pds/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
new file mode 100644
index 000000000000..cc2317c07be1
--- /dev/null
+++ b/drivers/fwctl/pds/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
+
+pds_fwctl-y += main.o
diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
new file mode 100644
index 000000000000..27942315a602
--- /dev/null
+++ b/drivers/fwctl/pds/main.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
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
+};
+
+struct pdsfc_dev {
+	struct fwctl_device fwctl;
+	struct pds_auxiliary_dev *padev;
+	u32 caps;
+	struct pds_fwctl_ident ident;
+};
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
+	int err;
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
+	return err;
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
+	struct device *dev = &adev->dev;
+	struct pdsfc_dev *pdsfc;
+	int err;
+
+	pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
+				   struct pdsfc_dev, fwctl);
+	if (!pdsfc)
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate fwctl device struct\n");
+	pdsfc->padev = padev;
+
+	err = pdsfc_identify(pdsfc);
+	if (err) {
+		fwctl_put(&pdsfc->fwctl);
+		return dev_err_probe(dev, err, "Failed to identify device\n");
+	}
+
+	err = fwctl_register(&pdsfc->fwctl);
+	if (err) {
+		fwctl_put(&pdsfc->fwctl);
+		return dev_err_probe(dev, err, "Failed to register device\n");
+	}
+
+	auxiliary_set_drvdata(adev, pdsfc);
+
+	return 0;
+}
+
+static void pdsfc_remove(struct auxiliary_device *adev)
+{
+	struct pdsfc_dev *pdsfc = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&pdsfc->fwctl);
+	fwctl_put(&pdsfc->fwctl);
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
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
index 4b4e9a98b37b..22c6d77b3dcb 100644
--- a/include/linux/pds/pds_adminq.h
+++ b/include/linux/pds/pds_adminq.h
@@ -1179,6 +1179,84 @@ struct pds_lm_host_vf_status_cmd {
 	u8     status;
 };
 
+enum pds_fwctl_cmd_opcode {
+	PDS_FWCTL_CMD_IDENT = 70,
+};
+
+/**
+ * struct pds_fwctl_cmd - Firmware control command structure
+ * @opcode: Opcode
+ * @rsvd:   Reserved
+ * @ep:     Endpoint identifier
+ * @op:     Operation identifier
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
+ * @rsvd:       Reserved
+ * @comp_index: Completion index in little-endian format
+ * @rsvd2:      Reserved
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
+ * @rsvd:     Reserved
+ * @version:  Interface version
+ * @rsvd2:    Reserved
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
+/* future feature bits here
+ * enum pds_fwctl_features {
+ * };
+ * (compilers don't like empty enums)
+ */
+
+/**
+ * struct pds_fwctl_ident - Firmware control identification structure
+ * @features:    Supported features (enum pds_fwctl_features)
+ * @version:     Interface version
+ * @rsvd:        Reserved
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
@@ -1216,6 +1294,9 @@ union pds_core_adminq_cmd {
 	struct pds_lm_dirty_enable_cmd	  lm_dirty_enable;
 	struct pds_lm_dirty_disable_cmd	  lm_dirty_disable;
 	struct pds_lm_dirty_seq_ack_cmd	  lm_dirty_seq_ack;
+
+	struct pds_fwctl_cmd		  fwctl;
+	struct pds_fwctl_ident_cmd	  fwctl_ident;
 };
 
 union pds_core_adminq_comp {
@@ -1243,6 +1324,8 @@ union pds_core_adminq_comp {
 
 	struct pds_lm_state_size_comp	  lm_state_size;
 	struct pds_lm_dirty_status_comp	  lm_dirty_status;
+
+	struct pds_fwctl_comp		  fwctl;
 };
 
 #ifndef __CHECKER__
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index c2d5abc5a726..716ac0eee42d 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -44,6 +44,7 @@ enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
 	FWCTL_DEVICE_TYPE_CXL = 2,
+	FWCTL_DEVICE_TYPE_PDS = 4,
 };
 
 /**
diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
new file mode 100644
index 000000000000..558e030b7583
--- /dev/null
+++ b/include/uapi/fwctl/pds.h
@@ -0,0 +1,26 @@
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


