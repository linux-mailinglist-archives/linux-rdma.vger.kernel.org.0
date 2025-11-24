Return-Path: <linux-rdma+bounces-14732-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD3C82AC9
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89B5934A857
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DCC3376A7;
	Mon, 24 Nov 2025 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OEZfkQel"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B8337117;
	Mon, 24 Nov 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023402; cv=fail; b=U1Iuk+uf3h/cscI1YyZx/tY+mNec0/VrKX1Au1A3aHdB9PXjhpT7LR7OWlJD5RguNEnvYYlmimnVlHnS/VD0DIVCVgnIn8d/oSl/pisud5YiLcLaU68h5mS++KfBrL5V718CbsKrnenF485W8YyuMKFg/hUt49OTf8SiuVO/PC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023402; c=relaxed/simple;
	bh=6IcInnTRJCj0yAcET5rTQb1VR06ZxyPT/b1zQWPLppI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0R/nJJ45fAtyoEniWbFdc3+/7iOiWJ3xZlXtjH+ARZ2oldwJKwBY3kMG05eIX2hiBC4oUkFa6/RfaLHOavTnUmrzTGXwuhRHuxHVArKRFV4ALyH1O9CVXIDcv0RaPoFzMqQInjYv5CgaFa7UNX35h/AY5jshfSjtkKwIkcDlwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OEZfkQel; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcfbj2nhDCCcyzLJbfwJGkp85ivgjj6h7K9nvcHCB6z1thmp/hENp7FAL9Oal49Zk4JSoi1SQi/+HAJxMk2jerIesmwThgjS3ZbzIdZHN+s5hO6CHbJeOgMUPF3wYk8NMdaaq7F5cie3STjTsZyXsf29N8OrqLeuva7GlCsGJHEOeLA+rfSzQ8CJEIqkKwJsbN621Lmxhb43YeB/S/e8jgSMn40pOxyb8YfrZnG1GxbJ05QpTAnDF7ny8rh1oqnVFMyJLG48RcoX2Zon8clqqnc1c+yPhGoEwAMSuAkUQ79z3WHHpCbVIU9e1vBkR7auqp4fdAg55MsP3FAppzo0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=Fv2DB9jtOP+qqChdTRhrYhHruogsgfQ6wDyrWwmgu7qpOoN7mgb0DG8b5d8z5WsAW4CzBINfhr6O7wJnMNsA/RhVDK4jSb5gCW/Efg8yr1gEPuiQnKQFZ7aoHkVB/6BrNvOzlGiGEyQJkjacOcsF8wD1EKjojSlXB6vRZ3yw0ZqqxjdZfWqATUJp3danHqeyxc2zU0FHhqYGukzKIjCyj3/S9wZIRZuV6RwjyGrwuoxgZSHQHnfay4KdqVCBzZENt9GbwZYQPRZ9wGoIUfUvYrI9h79MqnTVB2oz4IqPzM94FkBqAqARmSDLcqSNAHfWLgDws7Q06IKQQZM+jmcwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=OEZfkQelfKbYytURHvVGwtvrYRFISMNzeCwV7CgZqD+hxBOrlFnyhDIbxFaiuScfYQ44XTxJM821Xyq/Ut/IbQKdDPOnhWbuw9ymbit3r6tQ7xE0TcFjfFLOkODFL4Awe10ZjdrQ6szoI9PzRl2CTCzz7GVU0wnUJTsMlGfJoWspCpZIq/JqtgI7h9uWo3gFY4W+1nqI9g5RzQK0eIZtdZ6Ky+PXJkgn2j3nV26CfTIbSFdXULENDUAXvnZ81hFda15iZf2xwMEvrHitKtOkLeRvnxTux4ABBFZl+ARJc8y2jjyT4PJq+oYsnTdRaO3auyo7DXDuBJdWIUQawgcvNA==
Received: from DM6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:333::26)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:49 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::6) by DM6PR03CA0093.outlook.office365.com
 (2603:10b6:5:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:31 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:25 -0800
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
Subject: [PATCH net-next V3 09/14] net/mlx5: Introduce shared devlink instance for PFs on same chip
Date: Tue, 25 Nov 2025 00:27:34 +0200
Message-ID: <1764023259-1305453-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e092a98-c632-478c-b4db-08de2ba8fada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|30052699003|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uj2o/CfDcQB8ThPq/nCyOB8pKyIBbKJ08xbzXT1o/CAz6QqtVJ7LyOfEobFY?=
 =?us-ascii?Q?oM0oGiNLDfssHLUnEKg2r6PzIrWqJ2om45BpNzLLutrKV5u90zBlfbX71iVl?=
 =?us-ascii?Q?SJLfaAaLy7N4UVwVUXQUWY+tqHXTNmwoNyERVlLpq7sCFbAmhTfcXzMVYBbH?=
 =?us-ascii?Q?XyvpfvZ+biL9aI2gFsa3vNSlUKcL7dMYOH6X8GXCadn/eOOCvE8m90aiKXax?=
 =?us-ascii?Q?DfFniZxF2dxdktcS0TR4qSc0hQf+QJ8+3e9tbg9JkLBJZuEk+xoQAudH9X/x?=
 =?us-ascii?Q?XpSyioA4bjKhdc9d5WwHk+tIG6oiLWNfSsHAcoCEO/PZSvbANbGGHSE0MUfV?=
 =?us-ascii?Q?CDC36yeBayh1Lq8F+t9ayMsZvVH+rC3A0jMY5seT9XyfCDkR8HjzeP/SPAKV?=
 =?us-ascii?Q?UfOg0YuNn5eLNuc7kYYCKCyPf+WVisbWG7VrOjCi7clJ8W/5ucb0W2Dtx48q?=
 =?us-ascii?Q?S9ZoJOwnqgB/RlGtZrJwDEOqf1hDeFLsHYHMIZsPjU9x9TicXAWA2XYaOxpT?=
 =?us-ascii?Q?lk2Z81deO5zrYVNPV1ndlIVZHUSdvk+vN7whOIORvj+Ukut+ha4L3ZsO1lsT?=
 =?us-ascii?Q?SDrCTD+hCpKTLKWxIs5Gn4dE0Nk1XOWZDIRH7toOfq6LuCWUACx9ZoQVHYly?=
 =?us-ascii?Q?7zQwczBOFDIC7W3ADOouDjWi5fGc7El/xDSiivh3TRHR9O8SC7PDn4/8ot7c?=
 =?us-ascii?Q?feOIRl8lFm7jycnZjMUUfHk7eHvNS9VkD4SRuFJZO3GsYM+/b8TljotBr1b6?=
 =?us-ascii?Q?BobxxVxmV7Dk7emw90fxA2q24HKcpC3dSAxx27EzEjtBedKjc0hl67w3RVma?=
 =?us-ascii?Q?cB+ugw2nbV3LKp1lojDBzdOHkGRGO/tw/M/d6EgWtRcYdBC0hL8M3WKMDScN?=
 =?us-ascii?Q?RypOpoIt2NziPn691PoybCjMDfpzzpBQOfMhqw7Fthar7DT2hQDBto3Jfxjh?=
 =?us-ascii?Q?E7KDzSe42PupSghArFWDxePydRR5Vmw03Hvun4x2loIHQ/WD7Z9q11lc0Pg7?=
 =?us-ascii?Q?7yAQBNwADMfgVTQqQ8XPg0NIbEboIyhKewgM04E6qAjXJUyhdAqUlyvOM3r2?=
 =?us-ascii?Q?MseU3EJd66ksK4KE/fA+gAteKxVBKYrjWDAz5Ig8kkGhW2OE/DQn90KtGrYP?=
 =?us-ascii?Q?cAG7oCgj2EfIVqqXnx2YD2m4o08mRZCKhs3m7KFwZXHER4w6jNphyhjK9eLI?=
 =?us-ascii?Q?YMb46Lzrqp2KdrsitzGhZnt1Os5eGAvYKL5LV0FRQuWiSeLNSLuLXOe081Uy?=
 =?us-ascii?Q?DbyGrCJP6R+drpIl2lD+MdpXuxNNkRsoi1Ko1YaT4LEdgvMHjw2r9y456dQF?=
 =?us-ascii?Q?Y4VIOBiMagnQ8zmpDNEiYtUW6nlrzyt1vQWjkHFIzFfbR50E6Yc2OwTNAAvs?=
 =?us-ascii?Q?egqO/aD+uPxl7V4iFFuTikBdESjbb/+QfaSNUih4vnDW2hxZcgSwM8qy67sn?=
 =?us-ascii?Q?AuM5af8THNl2ygCLGupWGlWxBvOblooGJmcobC7bVNp0gAyZEvjdcYrSpXVa?=
 =?us-ascii?Q?97eczpW8LMWK8AkqkvkHdjuEsUBf5ZNOt0JWFOTPJgeQrQaot3dtzQ7oMTf4?=
 =?us-ascii?Q?aX0rinVJTRNe9l3VYyk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(30052699003)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:49.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e092a98-c632-478c-b4db-08de2ba8fada
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

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


