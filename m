Return-Path: <linux-rdma+bounces-14511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F80C61C9E
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 21:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D73F4EAA0F
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3694A27A444;
	Sun, 16 Nov 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D1Kfxnos"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE1326D4CA;
	Sun, 16 Nov 2025 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326053; cv=fail; b=KSCIO1coCwt4eKOEm5gwMeMFKvOSyCHms5vle+ByURGDh7n45PCD4BdH4A5mSKA506mKkEDEQjfgdn+yEaxhRuAHuhShQVv+OcShP7aqT8bmYBo0NJY9lkDi9nmaRypGnI8qDLYjgtdD0FU96RD+NKlCVlJd6C0OexSOjWao6dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326053; c=relaxed/simple;
	bh=cmmmfXbuQTiPJf1oPbPTq0rNfipBwnjtihshhrFFv/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgRmUJksYreUMcRL5okx6KQZjcwWGyFBHfAlTtYgcS7wS4LIGZLXkTxWpyMihNiSD2cAgK95Y3C9w2dPsUsR57qzPBSZ3pV7K3xjskC0dDNyU5QSQnXpETkGpuLH+Qwfxk3xmqp6QTcLzAMPfI3IxZGVbKOW/k7O60lWpoJgORw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D1Kfxnos; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lak10mjDyoZcpIDxcZG5dUlBtlrL0NHbMUNGpexaN7CtigqQ5z5NNGcWTZhlFKMVmcvLz0H4EdnGBmRva8tZ/H0/kt/l+QirpHJjV46pNkqXOE2j39NmEy9j6o95LAXy8mFq20MBUQmdm7yAZ9UyD2dUJKjdLwrdaPSz245bN2we1BKSbPSiO/klyMaOXXwu/VZI2dzKIufRpPA8z2CWJU232IVUnlcbCh1O4i/1ZF+pejl72pMWe5DgMPQk7DSTe7LVYiAXSxbgk6ZT0o4xUTIJqOSgBtN5g8VbIOljIf8Oq/9NtTOkXi5vqZiLiYvRjPq2oB0EXXPFj+hjWZil0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO3L5RzxqmuG7uszviaOOLh1gQp0pHRnrQIU9SdanVA=;
 b=IDMdTQm+f/dlGnMJ/RsL74LBf882dTR0x8lfetUV0W+V5kAX0R1UCaJb8/T+LQBX4VkYABZDC1U07a6sYylZk4WywWwPHXVuZzy2yWqOSec/Ueex9COWhD1zC7LfRh/BbWlKjAUYwgA6d0WW29ljLv2nrDDJkL1slGMlpRyeFiZVqFiQ27MrughjgTlX/1WYCPg+1qQWoOI6hp0Kc2buyiVCfQYQ2zi529ZYOeFh7KvkJTTwiBdR6g6z7HLXgBWQd7sXWqGpxkIRTu4fsbJK6zAmUZk2/m9awLDCR1X71csd7kM6Mpu7YEHj9FO1QF0YzIY6u+a3XRfymroLQFdg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO3L5RzxqmuG7uszviaOOLh1gQp0pHRnrQIU9SdanVA=;
 b=D1Kfxnos34wh1RSwfssPBmZRJAebjEZOfvms8kN/M0WLm7aHxZTY71olbb5RgaGNC3bygfIOX3kexA0b8REEGE770L8iuXqJXaqbJb+SeQNwBBNOoCa/bEqM4QbPwxerAlDYgedyRlGpzPN3m8v8EW6/5cVY/loOVAkzPpubtOPGy/iMVlplcILbA88D35XBnQiZmwJYIvzltQOaR9v7IEVf8AMGNvGelBHGfk7z4AoBKQy0k71UsKpIcPnutO200WQX2OSdSdphWR24mDVXmF70hsrSXjzET6T23hDQBpocsspv7Oj1bdQyRCUKp3ZWJlVJmhUGRO2IjjCLC/d5oA==
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Sun, 16 Nov
 2025 20:47:24 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::a5) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.19 via Frontend Transport; Sun,
 16 Nov 2025 20:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Sun, 16 Nov 2025 20:47:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 12:47:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 12:47:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 12:47:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 3/6] net/mlx5: Move the vhca event notifier outside of the devlink lock
Date: Sun, 16 Nov 2025 22:45:37 +0200
Message-ID: <1763325940-1231508-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
References: <1763325940-1231508-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 518f4ae0-eb9a-406f-3208-08de25515834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RQtkZMRA6ufxzTOsGn7g2F1W3IUeQBkYsDw7+mUxNTCfhNCZ4S9EPka+wB/4?=
 =?us-ascii?Q?/W6szCAUSb+3+6JdzDlXJcLUW2bXZLIeSsfZ7HFW3Pq7Hy327arc7rY5QrMP?=
 =?us-ascii?Q?wmbxg8jQEhGs9vUkOyDjw9fcMRJAD9IAmkjNChfzZa/+THexoJrrJP/1u0Yn?=
 =?us-ascii?Q?PKy0huTlInpAVTcuiIWTwA7hv5mIWLnlefct5YQWxOTApCNYUcRAT9N8dk0g?=
 =?us-ascii?Q?a90LItOOeu2SHWB17o+wDvDgLNTZiHjjWzb5/rsBYodIojJX02kQT1biMXcK?=
 =?us-ascii?Q?xLm7XQt+hvg+lAdjuB+AwnSmxLELbI/j9PnuFH4TswSmYTsbqSt5U3n/UgJr?=
 =?us-ascii?Q?Uj566QNbdGmT0yxlJgVYizdU8LCYPc4+63dhE0ddQTJ7NRpioamSwhP2Wu+S?=
 =?us-ascii?Q?xrIFyXhN1g6p1yICSeDyP8db/EZ04r2lohxD9tz5snBrcHbXfyVVo5XpH+fq?=
 =?us-ascii?Q?3/grtHqljz3RgpP31iuhIOHhDQ5dhoxeqpM51NDW6b1jk9wg+JUyMj4YWfSI?=
 =?us-ascii?Q?Io9aCcEgtIFBSz89FVDqPGJQyZk5rByU3paBw/c3GAkJ+FUNWjns+L1/y7RQ?=
 =?us-ascii?Q?579Ybigf7TyaxPoFyn8B7pHG+LWtPSPYiaDV3Y08JKV2z0IbXlEOPDDvgTUm?=
 =?us-ascii?Q?QGpXHCb/kzPSFEEe4yzCZBuMk9fIITBFmnvAvk0Xx+dNpVe8IWllo+G6cra/?=
 =?us-ascii?Q?je8BsYIUc4cO+cZikPmLdst+9goWkeE+D9j1VaCDrjBeGZiLePOr3n31w4fT?=
 =?us-ascii?Q?CWXw0XeRYY2Ny/jtPzpy1LYXpJauSRqfEvI71x5IjfGt/LVnj+MZ5pE/67ng?=
 =?us-ascii?Q?KJ58nu0itZDdRbcbgdgwuYD6ZtCthuebfR190cHEF+2dUL9VaAi11kvhS0ve?=
 =?us-ascii?Q?Cn/Na85LiLrWvpwgoumodH7FCajttmVHFljCl3/163e56TldNJi1s8Iy6TwB?=
 =?us-ascii?Q?TwJwisI/6p7P2Ncz0RYqQGUDQjHJ4F3Dme8VNWN/m/N6g+BLw0PEp0fTCxhH?=
 =?us-ascii?Q?9R65/hdqjzrk+cLc2Fmk9MpcwuR26eujpuVeUxDzfcIShltaR02NuXLvD0uN?=
 =?us-ascii?Q?0R670FAI7OpPI+RQklZ2U3IhJ2KbNtkbjjxJNyhqanLGFEryLN4LlKAyWALM?=
 =?us-ascii?Q?TNd4joHwqc7KHG31qyPvFP7do/B/Sy/29EuQo/YgpA/ms5ECsOKKuao9nexy?=
 =?us-ascii?Q?jhePRfOOUlRFIsSJt7vd+a8OxS6mvSV+eGaAMw0Un9uV/f2KmEjw/r6hoVRH?=
 =?us-ascii?Q?A4AfHbvwEA/RBeM3OweCEhoWBgpWdMhB6YsmwBjxBlnnXxBqil4EJ346ZYeL?=
 =?us-ascii?Q?D45KJKFWkIcMffqDAw5lq8BcTfO6rSbBRWdUzSLx/RFJf5gTyaQkE7Mz90Fr?=
 =?us-ascii?Q?3izgsWMJYtLSWqXYb3SkgvGL4pH6DQvkWL4JrkeC/LoEQQ6Cl+xEgY48mlDW?=
 =?us-ascii?Q?Ew+GPs3f3m8yAHsOfebD+wE+T0HXANa9iPYycTZ/jsgSIdHv6H2kmJB0u48J?=
 =?us-ascii?Q?dPWVYWEP20aQ4jC2YShO6INhDESFt1lgojkEtOYqzew3BQDy+CtIP8hlphLc?=
 =?us-ascii?Q?/LffcMY8IwxygbNJcQA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 20:47:23.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518f4ae0-eb9a-406f-3208-08de25515834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

From: Cosmin Ratiu <cratiu@nvidia.com>

The vhca event notifier consists of an atomic notifier for vhca state
changes (used for SF events), multiple workqueues and a blocking
notifier chain for delivering the vhca state change events for further
processing.

This patch moves the vhca notifier head outside of mlx5_init_one() /
mlx5_uninit_one() and into the mlx5_mdev_init() / mlx5_mdev_uninit()
functions.

This allows called notifiers to grab the PF devlink lock which was
previously impossible because it would create a circular lock
dependency.

mlx5_vhca_event_stop() is now called earlier in the cleanup phase and
flushes the workqueues to ensure that after the call, there are no
pending events. This simplifies the cleanup flow for vhca event
consumers.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    |  3 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/dev.c  |  1 -
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c |  1 +
 .../mellanox/mlx5/core/sf/vhca_event.c        | 69 +++++++------------
 .../mellanox/mlx5/core/sf/vhca_event.h        |  5 ++
 include/linux/mlx5/driver.h                   |  4 +-
 6 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 05f16f3e9c4f..097ba7ab90a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1438,12 +1438,12 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
 {
 	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_devlink_traps_unregister(priv_to_devlink(dev));
+	mlx5_vhca_event_stop(dev);
 	mlx5_sf_dev_table_destroy(dev);
 	mlx5_sriov_detach(dev);
 	mlx5_lag_remove_mdev(dev);
 	mlx5_ec_cleanup(dev);
 	mlx5_sf_hw_table_destroy(dev);
-	mlx5_vhca_event_stop(dev);
 	mlx5_fs_core_cleanup(dev);
 	mlx5_fpga_device_stop(dev);
 	mlx5_rsc_dump_cleanup(dev);
@@ -1835,6 +1835,7 @@ static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 	}
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&dev->priv.esw_n_head);
+	mlx5_vhca_state_notifier_init(dev);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index 99219ea52c4b..a68a8ee24dce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -381,7 +381,6 @@ void mlx5_sf_dev_table_destroy(struct mlx5_core_dev *dev)
 
 	mlx5_sf_dev_destroy_active_works(table);
 	mlx5_vhca_event_notifier_unregister(dev, &table->nb);
-	mlx5_vhca_event_work_queues_flush(dev);
 
 	/* Now that event handler is not running, it is safe to destroy
 	 * the sf device without race.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
index 1f613320fe07..a14b1aa5fb5a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
@@ -389,6 +389,7 @@ void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev)
 		return;
 
 	mlx5_vhca_event_notifier_unregister(dev, &table->vhca_nb);
+
 	/* Dealloc SFs whose firmware event has been missed. */
 	mlx5_sf_hw_table_dealloc_all(table);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
index cda01ba441ae..b04cf6cf8956 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
@@ -9,15 +9,9 @@
 #define CREATE_TRACE_POINTS
 #include "diag/vhca_tracepoint.h"
 
-struct mlx5_vhca_state_notifier {
-	struct mlx5_core_dev *dev;
-	struct mlx5_nb nb;
-	struct blocking_notifier_head n_head;
-};
-
 struct mlx5_vhca_event_work {
 	struct work_struct work;
-	struct mlx5_vhca_state_notifier *notifier;
+	struct mlx5_core_dev *dev;
 	struct mlx5_vhca_state_event event;
 };
 
@@ -95,16 +89,14 @@ mlx5_vhca_event_notify(struct mlx5_core_dev *dev, struct mlx5_vhca_state_event *
 	mlx5_vhca_event_arm(dev, event->function_id);
 	trace_mlx5_sf_vhca_event(dev, event);
 
-	blocking_notifier_call_chain(&dev->priv.vhca_state_notifier->n_head, 0, event);
+	blocking_notifier_call_chain(&dev->priv.vhca_state_n_head, 0, event);
 }
 
 static void mlx5_vhca_state_work_handler(struct work_struct *_work)
 {
 	struct mlx5_vhca_event_work *work = container_of(_work, struct mlx5_vhca_event_work, work);
-	struct mlx5_vhca_state_notifier *notifier = work->notifier;
-	struct mlx5_core_dev *dev = notifier->dev;
 
-	mlx5_vhca_event_notify(dev, &work->event);
+	mlx5_vhca_event_notify(work->dev, &work->event);
 	kfree(work);
 }
 
@@ -116,8 +108,8 @@ void mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct wo
 static int
 mlx5_vhca_state_change_notifier(struct notifier_block *nb, unsigned long type, void *data)
 {
-	struct mlx5_vhca_state_notifier *notifier =
-				mlx5_nb_cof(nb, struct mlx5_vhca_state_notifier, nb);
+	struct mlx5_core_dev *dev = mlx5_nb_cof(nb, struct mlx5_core_dev,
+						priv.vhca_state_nb);
 	struct mlx5_vhca_event_work *work;
 	struct mlx5_eqe *eqe = data;
 	int wq_idx;
@@ -126,10 +118,10 @@ mlx5_vhca_state_change_notifier(struct notifier_block *nb, unsigned long type, v
 	if (!work)
 		return NOTIFY_DONE;
 	INIT_WORK(&work->work, &mlx5_vhca_state_work_handler);
-	work->notifier = notifier;
+	work->dev = dev;
 	work->event.function_id = be16_to_cpu(eqe->data.vhca_state.function_id);
 	wq_idx = work->event.function_id % MLX5_DEV_MAX_WQS;
-	mlx5_vhca_events_work_enqueue(notifier->dev, wq_idx, &work->work);
+	mlx5_vhca_events_work_enqueue(dev, wq_idx, &work->work);
 	return NOTIFY_OK;
 }
 
@@ -145,9 +137,15 @@ void mlx5_vhca_state_cap_handle(struct mlx5_core_dev *dev, void *set_hca_cap)
 	MLX5_SET(cmd_hca_cap, set_hca_cap, event_on_vhca_state_teardown_request, 1);
 }
 
+void mlx5_vhca_state_notifier_init(struct mlx5_core_dev *dev)
+{
+	BLOCKING_INIT_NOTIFIER_HEAD(&dev->priv.vhca_state_n_head);
+	MLX5_NB_INIT(&dev->priv.vhca_state_nb, mlx5_vhca_state_change_notifier,
+		     VHCA_STATE_CHANGE);
+}
+
 int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 {
-	struct mlx5_vhca_state_notifier *notifier;
 	char wq_name[MLX5_CMD_WQ_MAX_NAME];
 	struct mlx5_vhca_events *events;
 	int err, i;
@@ -160,7 +158,6 @@ int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 		return -ENOMEM;
 
 	events->dev = dev;
-	dev->priv.vhca_events = events;
 	for (i = 0; i < MLX5_DEV_MAX_WQS; i++) {
 		snprintf(wq_name, MLX5_CMD_WQ_MAX_NAME, "mlx5_vhca_event%d", i);
 		events->handler[i].wq = create_singlethread_workqueue(wq_name);
@@ -169,20 +166,10 @@ int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 			goto err_create_wq;
 		}
 	}
+	dev->priv.vhca_events = events;
 
-	notifier = kzalloc(sizeof(*notifier), GFP_KERNEL);
-	if (!notifier) {
-		err = -ENOMEM;
-		goto err_notifier;
-	}
-
-	dev->priv.vhca_state_notifier = notifier;
-	notifier->dev = dev;
-	BLOCKING_INIT_NOTIFIER_HEAD(&notifier->n_head);
-	MLX5_NB_INIT(&notifier->nb, mlx5_vhca_state_change_notifier, VHCA_STATE_CHANGE);
 	return 0;
 
-err_notifier:
 err_create_wq:
 	for (--i; i >= 0; i--)
 		destroy_workqueue(events->handler[i].wq);
@@ -211,8 +198,6 @@ void mlx5_vhca_event_cleanup(struct mlx5_core_dev *dev)
 	if (!mlx5_vhca_event_supported(dev))
 		return;
 
-	kfree(dev->priv.vhca_state_notifier);
-	dev->priv.vhca_state_notifier = NULL;
 	vhca_events = dev->priv.vhca_events;
 	for (i = 0; i < MLX5_DEV_MAX_WQS; i++)
 		destroy_workqueue(vhca_events->handler[i].wq);
@@ -221,34 +206,30 @@ void mlx5_vhca_event_cleanup(struct mlx5_core_dev *dev)
 
 void mlx5_vhca_event_start(struct mlx5_core_dev *dev)
 {
-	struct mlx5_vhca_state_notifier *notifier;
-
-	if (!dev->priv.vhca_state_notifier)
+	if (!mlx5_vhca_event_supported(dev))
 		return;
 
-	notifier = dev->priv.vhca_state_notifier;
-	mlx5_eq_notifier_register(dev, &notifier->nb);
+	mlx5_eq_notifier_register(dev, &dev->priv.vhca_state_nb);
 }
 
 void mlx5_vhca_event_stop(struct mlx5_core_dev *dev)
 {
-	struct mlx5_vhca_state_notifier *notifier;
-
-	if (!dev->priv.vhca_state_notifier)
+	if (!mlx5_vhca_event_supported(dev))
 		return;
 
-	notifier = dev->priv.vhca_state_notifier;
-	mlx5_eq_notifier_unregister(dev, &notifier->nb);
+	mlx5_eq_notifier_unregister(dev, &dev->priv.vhca_state_nb);
+
+	/* Flush workqueues of all pending events. */
+	mlx5_vhca_event_work_queues_flush(dev);
 }
 
 int mlx5_vhca_event_notifier_register(struct mlx5_core_dev *dev, struct notifier_block *nb)
 {
-	if (!dev->priv.vhca_state_notifier)
-		return -EOPNOTSUPP;
-	return blocking_notifier_chain_register(&dev->priv.vhca_state_notifier->n_head, nb);
+	return blocking_notifier_chain_register(&dev->priv.vhca_state_n_head,
+						nb);
 }
 
 void mlx5_vhca_event_notifier_unregister(struct mlx5_core_dev *dev, struct notifier_block *nb)
 {
-	blocking_notifier_chain_unregister(&dev->priv.vhca_state_notifier->n_head, nb);
+	blocking_notifier_chain_unregister(&dev->priv.vhca_state_n_head, nb);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
index 1725ba64f8af..52790423874c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.h
@@ -18,6 +18,7 @@ static inline bool mlx5_vhca_event_supported(const struct mlx5_core_dev *dev)
 }
 
 void mlx5_vhca_state_cap_handle(struct mlx5_core_dev *dev, void *set_hca_cap);
+void mlx5_vhca_state_notifier_init(struct mlx5_core_dev *dev);
 int mlx5_vhca_event_init(struct mlx5_core_dev *dev);
 void mlx5_vhca_event_cleanup(struct mlx5_core_dev *dev);
 void mlx5_vhca_event_start(struct mlx5_core_dev *dev);
@@ -37,6 +38,10 @@ static inline void mlx5_vhca_state_cap_handle(struct mlx5_core_dev *dev, void *s
 {
 }
 
+static inline void mlx5_vhca_state_notifier_init(struct mlx5_core_dev *dev)
+{
+}
+
 static inline int mlx5_vhca_event_init(struct mlx5_core_dev *dev)
 {
 	return 0;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 27eeadbcff50..57368db0a5b7 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -488,7 +488,6 @@ struct mlx5_devcom_dev;
 struct mlx5_fw_reset;
 struct mlx5_eq_table;
 struct mlx5_irq_table;
-struct mlx5_vhca_state_notifier;
 struct mlx5_sf_dev_table;
 struct mlx5_sf_hw_table;
 struct mlx5_sf_table;
@@ -615,7 +614,8 @@ struct mlx5_priv {
 	struct mlx5_bfreg_data		bfregs;
 	struct mlx5_sq_bfreg bfreg;
 #ifdef CONFIG_MLX5_SF
-	struct mlx5_vhca_state_notifier *vhca_state_notifier;
+	struct mlx5_nb vhca_state_nb;
+	struct blocking_notifier_head vhca_state_n_head;
 	struct mlx5_sf_dev_table *sf_dev_table;
 	struct mlx5_core_dev *parent_mdev;
 #endif
-- 
2.31.1


