Return-Path: <linux-rdma+bounces-8850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB6A69AF4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 22:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28DF37ADF11
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33521B9D6;
	Wed, 19 Mar 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BIdTnszt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AA21B90B;
	Wed, 19 Mar 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419989; cv=fail; b=K1JTia7fxNeu5J3y4Da3kHpCc7t8dvSHgLFW6ylGVn+WnvOsGrqE/3zKxaX6MsUp44yHxC2ta0NuWsBWMlCH5Tm1K1YeaYOiQx2E3QHu8KvwuPYnXrEOa8UfyHfHSXv6rGKbXcfLXPja9y4z3K0G9S05iZTNeV2qVYey4w9xleQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419989; c=relaxed/simple;
	bh=NT1KI0PhIWK0fSKr6BwJzwA+9NCel0iX/11p1coNXxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuZ6X5jRHUp5sAt0M2b1a90+D/LUmm3BIMdYqfRgWYZCVygDW5tVZr5jAllwYzOvdEu5ICoI+MdOusgZlyudJ3P0EqAkAVWGKOQyeVWC7z8wbDqlRVp1ejgE99D6tqW4EXVHtKzNQBs8b0AKaV6rFjMwuXD3eOeAQYPe6jMGD+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BIdTnszt; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8XPiDh+2LTbSFKDoU4J8sXSjxDGaAKKPS5B4IKOmNpISSA71+kmP/DxFQANmeuWeZwWFY/R4md6lzXxr4ukfC8gJNncFC0eG/yfRYwtIUIu1nEqUIKFXwm509ZyUNXWVjfk9wXWOxF9+lMhaKDbBftcheHoo+ja0ph1zFzbUEckm+Kqn2QTO9jYfjyTcRSv9XsZ6iVacNUr9C7lCOMHl9cJF1HHkvdmdKJ7Eiq59fGlZnyHCkxaFbDE6z1PMQ/+vT5f5GJEj/SlBS8NVqNEjEp9yfKxq6hVVN/S6ODHTfzlNgnFwZAdZbwmXjq90/IcgFfuruYLZqefa39yxZLUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CprVHXqTZZzd3TD4MjapO4m8YPcbPcEe/nwBKdMKghQ=;
 b=SUs+WXXP8fQBl39e2kJFhfAEqasEABnMbxfzYTNznZWlV0SHReLYaQ0Uh5JkMqf+yuk3BVGTNuJNxEq3zWzMD730Zoe993mUUuUEooMbit9HuFdgTc1mRA4rIpPFMlhXKTZvSmFZ+ElYpOKnjkWbeKJMxBiwg687QlX4dsb5Vuh9uBqvogbv7A7GO1Ec3NENHsMX7YO5Pt62u+vqCAUxb8mvSLEkSlEqHIajfqNcUyThVEJK0q5f5wBldPHP8uyxsZLsb7A3h90ACWFJSBpTpPungNj0c11yMu4gb9CtYlrPZxJJfcfr7p/x4nIBCMQF9p0Is3cZkTcDMtWS95VTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CprVHXqTZZzd3TD4MjapO4m8YPcbPcEe/nwBKdMKghQ=;
 b=BIdTnsztxpOwy9VLbUh4VpBzTorbBh8yLV90aJ5Tb8CP//ddkuuahtGGeYGwAGCB4kRyYjlmj7vm/jL9ryppr0Ve5KYTN2X0vb+m0a2IHN5QI5tBl+1eYcWsbTiHwky98v/23R5C+8bwPbJEi6Lw8WBuVUfd2Fv7BFLjSFRKFI4=
Received: from PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::13)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 21:33:00 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::6) by PH7P220CA0090.outlook.office365.com
 (2603:10b6:510:32c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Wed,
 19 Mar 2025 21:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 21:33:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 16:32:57 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <Jonathan.Cameron@huawei.com>, <kuba@kernel.org>,
	<lbloch@nvidia.com>, <leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 4/6] pds_fwctl: initial driver framework
Date: Wed, 19 Mar 2025 14:32:35 -0700
Message-ID: <20250319213237.63463-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250319213237.63463-1-shannon.nelson@amd.com>
References: <20250319213237.63463-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 7665bcc6-79fc-4c35-59e8-08dd672d9f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bc8OAXNzTcseGlAdxMSXON9785f6GkmlWgQHnAu7geQUQOTXe9yt5fToRQRW?=
 =?us-ascii?Q?gqufqYy79ecvd97nuVZtPcRrc3JYvn2wr+ZK1FWmEG+rCHgnQ2UBWp5su5C+?=
 =?us-ascii?Q?6TrbmQDncv0Vm7jBtZ4DtjcREBzI5A+KfmVnm/RR3xua8PiN3PmOOKJMLpHn?=
 =?us-ascii?Q?eswnfwF53TiaFfNT/6jyR4cXMpfspB+3sib6lMLN7lixLf9JokoFPDwUHQCB?=
 =?us-ascii?Q?pE57h8QG3eib1kw1/FKu182vKxgZtM04DeKabt/MjWrLJahLMjoezadKRIne?=
 =?us-ascii?Q?qiF6YynSlZz+H6i0hRSXAPOgUuKrIP8O4VgUEXeF+a8SvQRkQZp+hQmItzzz?=
 =?us-ascii?Q?8z/FbvN4QG5flYBuC7OTxfmO13zHjvPy5jrqyWlN0+lzC5FtFSxRHa86gOcd?=
 =?us-ascii?Q?RHvcTHeR9jPuYlEt11MCV0q9sQmzdSVf4+Lc41w2XEIh4UP2g5qV+DAgchKH?=
 =?us-ascii?Q?kJ6rjhrOlzbDXwEUhrjOUzijj96S+UrGMRqCStAyklV2UL3Bv5sgNNAHkV/Z?=
 =?us-ascii?Q?g3a/0ixPc4dFIB1OdzbnPAhrMojxvEmff/TYV7OvyWzAC9tG50L7Xj18yiec?=
 =?us-ascii?Q?yfXhsFuSHCVuQmtCdg6Sb2swx4Icpel1Dxtgea9yfiJasP3LTGkAxsUHlZSa?=
 =?us-ascii?Q?qXRYwlQ5GgL78fC20U6rKii2bXXYEp6DbLWgNZ0bR9v+aO1goGOK3Jg7W9Jt?=
 =?us-ascii?Q?5fUdZzmEFF+RSa6aL4d0/Johz1Q3WBHuxmvTv09fDscWQ/N8wWQkmiJXbE44?=
 =?us-ascii?Q?STbCliLxD+vdU5XkeQ8VuQDUHGqV9cwEGQkwQxwfRymtGnip/hT8IEL1wUvJ?=
 =?us-ascii?Q?aBzP+QavT3jP+TmiUuc6HjGFy9uKEOhJatPqqYRDTxhEPpzZ3JOrjVG858Pc?=
 =?us-ascii?Q?IZp0+pULikf1+Y5nV864ukIZhjDhavpQSArrTzKxiPXmsmGn5tv9LkN04iZN?=
 =?us-ascii?Q?7fAvE9+q/CHAlTihKJtQKiOyuvGBnHlpLK1ZLuFyZAdm7UObaH5b8AhFebox?=
 =?us-ascii?Q?k/aFQ0/x8Hq1F6d6h7LxxThJZ3R5DrJ7FAeyngRA8huVxXT3r3h86+iVPNQR?=
 =?us-ascii?Q?5lFHDAgEu1GQQXGT2bP5LcFfw+GcT1E6oERDY9T8ZI12Vt2Lc6/XpPtBdK2k?=
 =?us-ascii?Q?vp+wadelHTo5ntUFpp9EW1UetjJyf0x8c9DJ9Y1FexRo4Ya8KTUjoDBpOu+R?=
 =?us-ascii?Q?gc6ahxY4VLKGb2euRs2IrR8jMz6hJJ+rqxcpRWZlyRVY/z3jn3MMzqX5Ts8/?=
 =?us-ascii?Q?eBlnwRK35wUX3i1NAk6FXzhfSmfOdCyvHLPVwNKZu6p4U+I0A6cRMzVwnXAg?=
 =?us-ascii?Q?RoKjbYYtO1/Fs2eEBL1Qz/riB5RaadQYZ9R4yy67FRqqrTIuHLpwRtx+hKQ7?=
 =?us-ascii?Q?H8s2OxCjCbi/aRdPkeYP69FpXdHyCdQSiH3PFA6tjZjqlwDdwP3SDXtVLicT?=
 =?us-ascii?Q?vJKD6CRv3lXGxU3G9OLXqBSIar7ug1a/cZofYrNYYghyUFALiXIHQNThv7Em?=
 =?us-ascii?Q?fkGte0kzjXHN0NM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 21:33:00.1832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7665bcc6-79fc-4c35-59e8-08dd672d9f7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

Initial files for adding a new fwctl driver for the AMD/Pensando PDS
devices.  This sets up a simple auxiliary_bus driver that registers
with fwctl subsystem.  It expects that a pds_core device has set up
the auxiliary_device pds_core.fwctl

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 MAINTAINERS                    |   7 ++
 drivers/fwctl/Kconfig          |  10 ++
 drivers/fwctl/Makefile         |   1 +
 drivers/fwctl/pds/Makefile     |   4 +
 drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
 include/linux/pds/pds_adminq.h |  83 ++++++++++++++++
 include/uapi/fwctl/fwctl.h     |   1 +
 include/uapi/fwctl/pds.h       |  32 +++++++
 8 files changed, 307 insertions(+)
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
index 000000000000..749bfb652f4d
--- /dev/null
+++ b/include/uapi/fwctl/pds.h
@@ -0,0 +1,32 @@
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
+/**
+ * struct fwctl_info_pds
+ * @uctx_caps:  bitmap of firmware capabilities
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_pds {
+	__u32 uctx_caps;
+};
+
+/**
+ * enum pds_fwctl_capabilities
+ * @PDS_FWCTL_QUERY_CAP: firmware can be queried for information
+ * @PDS_FWCTL_SEND_CAP:  firmware can be sent commands
+ */
+enum pds_fwctl_capabilities {
+	PDS_FWCTL_QUERY_CAP = 0,
+	PDS_FWCTL_SEND_CAP,
+};
+#endif /* _UAPI_FWCTL_PDS_H_ */
-- 
2.17.1


