Return-Path: <linux-rdma+bounces-14694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7A9C7DD17
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0EC3ABE19
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C929E11E;
	Sun, 23 Nov 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4cDZVGb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5629A30A;
	Sun, 23 Nov 2025 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882670; cv=fail; b=fL4U2boPs85ziNes9vLb4yxQIgkE+/JsaYEcTi9t5SFmr2UMS+jy64aFrfixS/QKdWhva+KhbQ8V9lpE+rc1RUeIh1tCy3mMC2poGzVMhZj0ZEZDHPTZCmlm4sIfxBhFZiEkVlLqRIDVJzmNDYp0f5LjWvEM1SDIzKUHYZrcE3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882670; c=relaxed/simple;
	bh=6IcInnTRJCj0yAcET5rTQb1VR06ZxyPT/b1zQWPLppI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ansuD/kKPTxPVZusVRuOcMGt+72y84vA1T5qUhRe1LUKNgI/igtEXqU938SvZDgKRNCLc1P2k6yYWbmu+5XynWPythPCiUGfIHOZ8/qT9VZNxigKVq743YwM2rfD+ZPTkXLA3G9bydDUid3cBDEO1oIqzImBBnqDr/itLr9XAqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4cDZVGb; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzqGLlV7Hgg78/4pJJmXEHz40B5yXly4VvujciqBiORy0EOeu+OOv3POdSqrv/PzkBccrSa8hSJHMInk6Cr4zgpL/y7yOIGgseo9fouVQsC6yoxzsq0ZJ48jUkHbEuBDrU0MhOFg/1VujccMCUcjiOwu9BGYWBRcV4j0+j8cUqaVjfQ2l8kf89h1c4ARStoj7jynUO6OmWylqgI0bvGb5CXH1nxnBxX3Bv1REXR3WN5QvT4EorvOdlp3s11LAYCu7h8HO69CBZy85hp3kGfqW87/ZKRXP6/HX/ADZPrgsJpVk9IAxnexUv+Eo9yZM9myhRigfCfz1cLIgYKFBvZcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=mQaTgMVn3r43AsDtwVQxUMoIl/PLutSZ06iIvW1AOpMGoxHzmzo/IxcCPuCGCMvs5KOYhGoY6UbwZW4YCnVYQdov38ITWPe2fDAI7tm/KOdfQ0Ntgna3HC3ferZRmBm9Njfqk1JSu64VSgs3IuN3izBTOO90bcY7B0Nw1ZqZEbIgnGMFUcNokFfFKZ0p/LReQHO8P8MKitEhdq9hwztfTQlGMukureM/UYEqhigBo17eSacKsHKhSpbuoyXW5M/SvFVZO6dBqakPH3gEEwUiQ+wIVED+1zDB6foR2FskvXRcLlxQc3xKJlnOahMzIL1JZfBjXcdh/Eu8vNuBCh1dTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=m4cDZVGb3R+0ZgPl8s5n/LyBwo5lR+E7DYhX1ndHcOJZj0g4jRSf68Hh8tPucfV2r8TkfTu+roWHPChaQockFAm7kLADumskI25KJ7DN5hqN7gHD5okkm5RXWZQUuPq6QIkvXDjHwCJqpDOO5orJb4IpOFDPPyfHW6zN7trINNpJ+vlnmgr2sHUZbTx4Q4s815doTQny7JOxPFWdDw7IogKdInEsbJAAkSGUb1JFc5hFxfLiA/00BqFKFnUS1NqDoKQDJXNBVzlwfuPli9qoJD4YGpIiVkJW0iPQ/PT08GtDb7icvD3QQAIzWvf8QyCIbibeCtRwxNjLBY560wV85w==
Received: from SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Sun, 23 Nov
 2025 07:24:22 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::64) by SA0PR11CA0068.outlook.office365.com
 (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 07:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:24:01 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 09/14] net/mlx5: Introduce shared devlink instance for PFs on same chip
Date: Sun, 23 Nov 2025 09:22:55 +0200
Message-ID: <1763882580-1295213-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b42825-0d2d-4144-8cad-08de2a615319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|30052699003|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XtHgbUTDpx5GF3972GKK6NVnoz1Zv0sA9Fc6U905P5Y4Xj1chbnhqbkXGgiQ?=
 =?us-ascii?Q?mBwkwtG1LTuhw6YCfLV8ugPJHLeeCkL9e26SZPPyL7eQbBe0/Qa5xxKJZy4g?=
 =?us-ascii?Q?4kqwbCnVJx0AkZj0ZfUAEUD+Y3ruLRujaNTuIiY3H8HlgebdXexIXO+h+RnG?=
 =?us-ascii?Q?p0kQSA8chAc0SjmcGhtz5Ta65c1snPV/M2vcasu2S/wxiBJu6E392oF4XyrW?=
 =?us-ascii?Q?BvQYjBplXCS8+6tbhim65kHJRUWr7ZEWgu559gkvgffm4neGheudOxvtp7vF?=
 =?us-ascii?Q?CpnnokofBRccgDNZ7Zc1/Z4LXiuUvQc9jJYVv548UcrJ+ZTmJ4acghdAS323?=
 =?us-ascii?Q?0A8pllFieWT+a10/0dcdcuJubNvj6qFzAUyvkNxs3f24+Gsfr/cbtt8LswZG?=
 =?us-ascii?Q?pHYuOiICqIlhM9P4MEzoO6hwbtEb5cIQkPOvDdr082lo0nwSv4w7oDSOKFsw?=
 =?us-ascii?Q?psDiQ3/fwTF/SE86gAyRVRgoczq6SRWlfFidD5gZWYKyR5zZaucjMIJSMa8A?=
 =?us-ascii?Q?C4AFriHCQ5eqRChSCmdImKa4QrohDe3Dx6sToAkGWWbmHzDiCCcyi70LL1hj?=
 =?us-ascii?Q?AQFA5TZ+NE3ziZzNZeiKphIzXlUezE2yv+Au/3FHcGSGdzQgXu7f0UziuEEn?=
 =?us-ascii?Q?IrROs8bobD0+6Nlkb373zvvII/zYaBU67P3xopWCMCGQYr3FQZxU/hU8f4aR?=
 =?us-ascii?Q?/qE3PSDWMEIo32OBnf+BztV1EdNeBBoaqIPmd6n+1QlQ4YJWpi7cm8waGUzy?=
 =?us-ascii?Q?VctRbvntNCmBZd3DYmr5NDrlp8uUzn8xanXum1gN9A1d9FFIZpALXYwwLri+?=
 =?us-ascii?Q?FdvONMf5P8nf/8PN98mFVW5HP3BlGDP0fyQNPAs1cLkHX8q7t6qAciGcAbYD?=
 =?us-ascii?Q?qmi8/lMphQRN3q5l8kO9ZJehH9V5YEUwDojmhg7/42l3F5/8GDFfKcuSYE2d?=
 =?us-ascii?Q?uTEB0M3IOJUAhvDv/BNB6qU0x5hVMR0SYvAU7sYahCNB+vEv2d5arFERzvkW?=
 =?us-ascii?Q?1UgBbLgooHrDhBzV9q3nuyTr0vDz1NFcmnr3rsEg5B9fv+ehFhyFNBzw0/wz?=
 =?us-ascii?Q?LXScxb0HrVmOYw3gw3gCTLCVhn9eRpIODgtc4rokCu/TSH/5YRxDX8PvGdT5?=
 =?us-ascii?Q?G5jq54Y2JaoUr5mbYgZligxnv/yDlrmoP6b4DTwIrSIoDUQ88slESCsg35lK?=
 =?us-ascii?Q?yG/1v7oBdA1JdScMbAQ6Iuhwy0JdTATQWeshrid8R0IAeK/CPs8rQJpWJklY?=
 =?us-ascii?Q?tN1jNNR5hDieV6UfHK6dewylMTcRShVF4a0+h/hqxcaPtDY6oeqU2dScVge5?=
 =?us-ascii?Q?CpxqtSVgQY8W2wdHOO62GUgnv0mppIwojWjM2T4pkghyhRGCPA9N2ysJoVLV?=
 =?us-ascii?Q?c9U0aSdhfBbnAphYzYM1S8q83/JZM072D//COViZnZWMe5Ztz1zuXgS38kwJ?=
 =?us-ascii?Q?eRbw3pzsO7AlEhT3JZvccJWqtA07n1SlLk/M6CQpDqTNXncv/GxinbQv6tfU?=
 =?us-ascii?Q?bPWWAwnZHfM/au8GJc8SzG9B51thQtZxMN92cNmxdipxYjFKt+OR1vkQ8fp5?=
 =?us-ascii?Q?GWLCDlz08HnwJWEC7uI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(30052699003)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:22.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b42825-0d2d-4144-8cad-08de2a615319
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is not good object to pin the configuration
knobs on.

Introduce a shared devlink, instantiated upon probe of the first PF,
removed during remove of the last PF. Back this shared devlink instance
by faux device, as there is no PCI device related to it.

Make the PF devlink instances nested in this shared devlink instance.

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
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  18 ++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 166 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  13 ++
 include/linux/mlx5/driver.h                   |   5 +
 5 files changed, 205 insertions(+), 2 deletions(-)
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
index 024339ce41f1..a8a285917688 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,17 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(priv_to_devlink(dev->shd),
+					      devlink);
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
@@ -2015,6 +2023,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -2026,6 +2041,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2047,6 +2064,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..e39a5e20e102
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <linux/mlx5/driver.h>
+#include <linux/mlx5/vport.h>
+
+#include "sh_devlink.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created for PF group of the same chip.
+ */
+struct mlx5_shd {
+	/* Node in shd list */
+	struct list_head list;
+	/* Serial number of the chip */
+	const char *sn;
+	/* List of per-PF dev instances */
+	struct list_head dev_list;
+	/* Related faux device */
+	struct faux_device *faux_dev;
+};
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
+{
+	struct devlink *devlink;
+	struct mlx5_shd *shd;
+
+	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
+				&faux_dev->dev);
+	if (!devlink)
+		return -ENOMEM;
+	shd = devlink_priv(devlink);
+	faux_device_set_drvdata(faux_dev, shd);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+	return 0;
+}
+
+static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
+{
+	struct mlx5_shd *shd = faux_device_get_drvdata(faux_dev);
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	devlink_free(devlink);
+}
+
+static const struct faux_device_ops mlx5_shd_faux_ops = {
+	.probe = mlx5_shd_faux_probe,
+	.remove = mlx5_shd_faux_remove,
+};
+
+static struct mlx5_shd *mlx5_shd_create(const char *sn)
+{
+	struct faux_device *faux_dev;
+	struct mlx5_shd *shd;
+
+	faux_dev = faux_device_create(sn, NULL, &mlx5_shd_faux_ops);
+	if (!faux_dev)
+		return NULL;
+	shd = faux_device_get_drvdata(faux_dev);
+	if (!shd)
+		return NULL;
+	list_add_tail(&shd->list, &shd_list);
+	shd->sn = sn;
+	INIT_LIST_HEAD(&shd->dev_list);
+	shd->faux_dev = faux_dev;
+	return shd;
+}
+
+static void mlx5_shd_destroy(struct mlx5_shd *shd)
+{
+	list_del(&shd->list);
+	kfree(shd->sn);
+	faux_device_destroy(shd->faux_dev);
+}
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct mlx5_shd *shd;
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
+						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
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
+	guard(mutex)(&shd_mutex);
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->sn, sn)) {
+			kfree(sn);
+			goto found;
+		}
+	}
+	shd = mlx5_shd_create(sn);
+	if (!shd) {
+		kfree(sn);
+		return -ENOMEM;
+	}
+found:
+	list_add_tail(&dev->shd_list, &shd->dev_list);
+	dev->shd = shd;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	struct mlx5_shd *shd = dev->shd;
+
+	if (!dev->shd)
+		return;
+
+	guard(mutex)(&shd_mutex);
+	list_del(&dev->shd_list);
+	if (list_empty(&shd->dev_list))
+		mlx5_shd_destroy(shd);
+}
+
+void mlx5_shd_lock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+	devl_lock(priv_to_devlink(dev->shd));
+}
+
+void mlx5_shd_unlock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+	devl_unlock(priv_to_devlink(dev->shd));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..54ce0389cfea
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+void mlx5_shd_lock(struct mlx5_core_dev *dev);
+void mlx5_shd_unlock(struct mlx5_core_dev *dev);
+void mlx5_shd_nested_set(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1c54aa6f74fb..29fd4dff1cd1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -735,6 +735,8 @@ enum mlx5_wc_state {
 	MLX5_WC_STATE_SUPPORTED,
 };
 
+struct mlx5_shd;
+
 struct mlx5_core_dev {
 	struct device *device;
 	enum mlx5_coredev_type coredev_type;
@@ -798,6 +800,9 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	/* node in shared devlink list */
+	struct list_head shd_list;
+	struct mlx5_shd *shd;
 };
 
 struct mlx5_db {
-- 
2.31.1


