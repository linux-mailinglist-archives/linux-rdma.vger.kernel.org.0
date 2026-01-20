Return-Path: <linux-rdma+bounces-15745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0169D3C189
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04F2C4615EB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA053D1CB1;
	Tue, 20 Jan 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8ux8EGN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEA3C1FE8;
	Tue, 20 Jan 2026 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895977; cv=fail; b=ETyo34fSGLzxzqLEzizh5ovPfIHK5E2bK5gq8f0Cv+8GcwTTCHEKaHvnqtGZZyzRdCs0fcMJGdGn7aYhjmRnD15oQWM9iWru3ogGj9KlmHh9kZxDyvPwTyY4OgV6sFf8acMwRZivGjgAQa9KUYSSBev5YCy1MGFhWibyTtpQZv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895977; c=relaxed/simple;
	bh=aD3Q2mDF6Uz4fvINTxksuF5yNF/vSN8rewVHcaH+c84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPAUVJEIvxowig6Li0gyxiAfXitanHaoGX63k2lIsgSPcxiX/3vGMc/tdislTqXQVjBGZP/7x277K+ToXlGV4fdPiaBXR+kXNWi3JCr4X0XC/rXY9u/6/6CZoTM7xo393hJ4uee3byNoTuqPE8eL0HPK7jBEIFMWFfCixb3OS8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8ux8EGN; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2Vw4+fj8d+bm55n/IlyXqj/0Wtn88EHrB3rv9SUHA/fprNyS1AAeMjHyuljP4yBWv0sIXGia1UpcK1FN0B2p9X0A5cJSZUJthJtrAvdwnnbdT/592Y7Zl9Z46expbN4vAbyT/GF7YcRNEeYOCX4SH+dXbm2zuI7X8QJGBipzI4wu45iOyiC5JAZeRg9QGkp2+6wIwTNeShicOOKEz2fUUCBNCFeU6eTgGLxK7UIppsKg/3EKiI2+5cpUgAvGxeBWNqguBa6XbrbYWTketTKWGW6zpLS55f4ZkehbQzkVQeSID4QadZWC8twerAmxR15rWxFUxlxgzDcOHsdx+4eHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVB0aULsdyPon6uVay0K5BY+CG2UfHwzu5Sg6Mnxzk4=;
 b=ldfCm5BwRfXsGalwLLsh96N9EkRaNwtvRWj1B1tMo7YA3p8PUmqfEdS8U0Ckt2Dhybl9D9Pc8TpVoN37BQ8CUkCwT+wrCEqnVmKJcZo7z9lYrPqPjGd6wWlP0EL1u5aGyutT6CujfOGfqbulWsnYzxdNw5eYeTuT8dzos/HwTN94HuIKQWWgMi3zp2uVQ7RNxyp/wgxznO6V+d8qaN5hhYlwGhbQjhMhBi61wlNaljcgr7bnIVi7mwm63rE9pokCWoI0/RIbCYq1r61RAVBCVKHa/VUYhcI9a5vKZLzITlx54BHQ64DlK087DQ6HZJUa0WOqv5AAFL7LY1ITGjE7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVB0aULsdyPon6uVay0K5BY+CG2UfHwzu5Sg6Mnxzk4=;
 b=F8ux8EGN7LXZJSajWsOjwtLFr7O0GGS+2DX7iADyztgzzo4SrzePjFIo/oSM9mZzR6qXIMsphcLUHv0CXKawUp0qSO8YRk7QjcQv+mjMKWUj2miIMTNHuKm/9jss9rfsDsGuZvq51ulQaRKeMnOwvoInRdSzUQ9BNcsjDlNl5xKhT080FM4oJ4o6vcsaSBy/UrUmehHK/DmylBkkKkWKa80i6bhdN2bwpt7MlH6pLHXPSt7rrNeW7WoThESk58yowt2j9q+uqzLPMvu+x5Y9eewYGUk+EJn917DRiBVozP0vAXCwyvum82xg8beyQ0658EiThCAlrbMTpSk8i7C+vw==
Received: from BLAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:36e::17)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 07:59:31 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::46) by BLAPR05CA0021.outlook.office365.com
 (2603:10b6:208:36e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 07:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:59:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:23 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:17 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 10/15] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Tue, 20 Jan 2026 09:57:53 +0200
Message-ID: <1768895878-1637182-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: d5629dcc-e94c-4810-b104-08de57f9d803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ztfpYVrKQxy7fycGmQGBzwekwj8OlfcYm6Y3ss+8jS8z7uptnxw0Lw82BKj?=
 =?us-ascii?Q?jWBL1/TieioZrVaa+bnFKwQAbnHcPvBUIN5/XBN+kp0gxIH3JXrUL6AnVOL2?=
 =?us-ascii?Q?7d02YJqTsuKfLoOISJje18OWf5kCiucTyE9IcMk7FmTZl0+72ZyrCSadtdKY?=
 =?us-ascii?Q?J/G90FuFXgmJSh5I0cEiHoPuaccSVwq5iJbYcgPMf1tN0G5wdDtWPSVtjd76?=
 =?us-ascii?Q?/3oSY8meVnIgw+McvrrXlmWyeWna/Y/vCWdyJrH5fu+QSeqoUCUVZC3Is9+m?=
 =?us-ascii?Q?XAiomULwFuAN8aYWbxEqwpCA/gksGYHOZ1JgYFl3IpmR7/wWOGcPGdPJm15V?=
 =?us-ascii?Q?r6OVVCpAiiN48hBZg4TNGKtO5bT/v6rEPCR/L0I7LtnwKM+FSaWmu56+9Vk+?=
 =?us-ascii?Q?4y0u7EKVhZjAvJqEqy9VXNL9DLQEqc0xKmPeQITr5oEs+HuJi0Xhl0OHB8mP?=
 =?us-ascii?Q?3y+fW8N9tkujX1lG5QWBjpf23RuGVU3Lvb/UqZUFgBbHgysWRsTnI9RmT0Yp?=
 =?us-ascii?Q?5uZ94biPADOoUxO//+maqPEpAM2QACR9vecgcfi3PUFKSH+RnQVE8e10X5X/?=
 =?us-ascii?Q?Jmz4qVIiiuZCXhIvFgKkQuF90XZOJvAWz/rA5t0PxJ5vYo9vrvZG6WUJQmQw?=
 =?us-ascii?Q?OdsxjHE1ancJrhR0xVt5gds0S5CpfWqQrpCqSNcFSV60u+HnHRXlYGube68S?=
 =?us-ascii?Q?W1kxXWFZxKDi98ESuazRmCvxdOBFMirh73L8Qv2Xgcq40cmCcDNwVrDVovj8?=
 =?us-ascii?Q?BqlWiotQ5+5kh8xEvxhi5zLkyZUhje7Mj7ZL+id61TfJUPRtVNZOy28Yfmja?=
 =?us-ascii?Q?HX/IJJYzsN4b5LgRYHZfIGlhtEWAJEHY61fKK8EZriYfgYZRgKVcndrvJ0g7?=
 =?us-ascii?Q?jJZVZLRzQLF/m8pmvu9zmC9Qjr2eIX5huW45r1O3rIDdIaC4wEpKTlII7IXk?=
 =?us-ascii?Q?zc0fIwUiJ2nMX+81e5TMjliGNWi+FfXT4eETfLB4/EQXCifJU5S+AnNOLKYw?=
 =?us-ascii?Q?MCAOUnC/AnVMCnljLn87ga47GcZjTbT/u4yJGzWpFVQkKv0mTv5/9ZIIgZk/?=
 =?us-ascii?Q?jmnC/cwXk6kAOWfiZBhQWen91TkuVCTHveqkuinr3v6sHnsiB9c8lP3xgVie?=
 =?us-ascii?Q?OhgqEG80CI7J+Pj7zlcWCfokoN7JGHfa3KsREfE+Gnfd1kZ5S6zjW+GZ84T7?=
 =?us-ascii?Q?b+Rm6iFXQUde4nXmD1+ZvzZlY8aV+htQQkQFafEVBquEGZayXVw02ks2g/nu?=
 =?us-ascii?Q?X97BH6mUQ7huBSh8oPLBjwLBys6aLgBeF1Ify/4YeBDDFdtqcBpFKU5CA43u?=
 =?us-ascii?Q?VEkCR1EfqAddDlc2QbwFqd8taEqLvBGIbH84mLCH+hn/B+Mh6LJbEmAi4D3m?=
 =?us-ascii?Q?tWF3e4ybULCydDA/svLWuaWc7pN45zBBMLt1Fa+uVjYvmqW7RpIXLLNENOKs?=
 =?us-ascii?Q?pJHgC5iXnxrDx4kRz2Xh2UBJXs145V3DjOoimAYtIoNNacQAl2p8eG6aJwq3?=
 =?us-ascii?Q?27iCUpxwKlGQK1UUF+i/ZboQ+UKMg56p1OKJSE1phs/zj1Uoc/OuPS/NXY0H?=
 =?us-ascii?Q?lVkaHBfgV2AjMH3gxe/e2nBPyaqvOP3Zj5Shn5qlVyokhv7+0EI21W9kcUMU?=
 =?us-ascii?Q?Uu1qXZFRRsDkPtoTuPQMFcLMz1w8v9jLp7wMJIR4TenMTYGaQvHLEmkdJ8X/?=
 =?us-ascii?Q?CAgQyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:31.3990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5629dcc-e94c-4810-b104-08de57f9d803
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

From: Jiri Pirko <jiri@nvidia.com>

Use the previously introduced shared devlink infrastructure to create
a shared devlink instance for mlx5 PFs that reside on the same physical
chip. The shared instance is identified by the chip's serial number
extracted from PCI VPD (V3 keyword, with fallback to serial number
for older devices).

Each PF that probes calls mlx5_shd_init() which extracts the chip serial
number and uses devlink_shd_get() to get or create the shared instance.
When a PF removes, mlx5_shd_uninit() calls devlink_shd_put() to release
the reference. The shared instance is automatically destroyed when the
last PF removes.

Make the PF devlink instances nested in this shared devlink instance,
allowing userspace to identify which PFs belong to the same physical
chip.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 17 +++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 63 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
 include/linux/mlx5/driver.h                   |  1 +
 5 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 8ffa286a18f5..d39fe9c4a87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 4209da722f9a..9cd8361ca00e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(dev->shd, devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -2015,6 +2022,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2026,6 +2040,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2047,6 +2063,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..abae5f0130e9
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/driver.h>
+#include <net/devlink.h>
+
+#include "sh_devlink.h"
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct devlink *devlink;
+	const char *sn;
+	char *end;
+	int start;
+	int err;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO,
+						     &kw_len);
+		if (start < 0)
+			return -ENOENT;
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn)
+		return -ENOMEM;
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	/* Get or create shared devlink instance */
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0);
+	kfree(sn);
+	if (!devlink)
+		return -ENOMEM;
+
+	dev->shd = devlink;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+
+	devlink_shd_put(dev->shd);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..8ab8d6940227
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+#include <linux/mlx5/driver.h>
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e2d067b1e67b..3657cedc89b1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -798,6 +798,7 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	struct devlink *shd;
 };
 
 struct mlx5_db {
-- 
2.44.0


