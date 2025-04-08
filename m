Return-Path: <linux-rdma+bounces-9256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788ACA80D64
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8891BA4CFB
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C81CCEE2;
	Tue,  8 Apr 2025 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AyORxMiN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2E1D6DDA;
	Tue,  8 Apr 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120990; cv=fail; b=AyDMKKRil62XIDkr8Ix4UuEYoQeCO4S886KgdIWMg2eEgGzs6UG6ZSgbLmCH8d0nLu7AZEhmMQFxBk1/7WB7hFdPfr4TAnV39QsgNt0pkbPs6PMkd74vTSYmp3xpT3Bnq2tEAXXw56Uk01FFgWafiqFZuaCLGESkZFNQb7oY9jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120990; c=relaxed/simple;
	bh=pQOFzX8fiWlGBKiHntMjHtoxDUEIAzRYFBOwSRinqVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pA1jSsiNhlS+/4qDSZMQWhsYDg4y2jBmvvsB8+3Z5zAXRXPr+FF1P/DG2PEEKzhytXr9XeJHe17aEqwayKydUQtY+xvrmw3i5/tPIY+ENZoUse0+GHoCOhfiM6WdkyQkfd2M4cstY/Oz57D+GZAWDfxtbOy3SSxPXfQbwZ20htk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AyORxMiN; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKhM+Jv3pDO5hOlBdFEE3gCXMYU9R08j6L8kwpzorGWepljPgNDaimwpMX4VIsi0PWn12hrVg2m6O+fyXYh6ptRM3o3fUK5WxGPYmr2uQbU78/V5AuKMQCsRZidqJNHgIuEc3rjyCHoc4hQsNNXZ4RtWaYQutHerx8kGG7syug5j7VszPTUwGAqzpyNvdSxC3gtZamURWEL6u5LVkkjjwgASjZ/nFr9A2+pPqdTdKC44GFj3bZe1muR6lfH4iKR43eSYa1c/qiKFGcGAkfAKabawO2eLHTIjdXG2iHlXs5nF94S1JIEW+KLvUL4isdKpYNKVIciyYo1IEQQwHV/EsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WXdYn+7SuRCixqof74dnyqPMNFJu1Of8CurlOTddRw=;
 b=vZk27KK+S2fwDVX6X4ITKLpQpPZ2hnJ9K7bwABNzL/CX0GqzrgMcByt97lbLr9oHrYcMiahd5rNQN7wlNgNuSlgt6LRwgLkP2zU6KdRDkSm4iFGPM8Yu8nJBKGWcvKZTGSvMcvPulOy26RtobCg4tqOZaQnrwnjrDr/HUBz7iJZOMMAnmqCPBEYu2V85/95khFMUsf/NLFTpRD85Yv+BncVCYk2fUPGvanBU9uJBbZ3uP29uTrUZ9koGHq16x/fjYU72b9bSl5KtjiJYqJUdKIYP1kZVuSGd2PVuToST4b+1CM4L8MArLeHr4jzrVMkHeRBR1Gaeel+4MMrbAVd0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WXdYn+7SuRCixqof74dnyqPMNFJu1Of8CurlOTddRw=;
 b=AyORxMiNbc6Iz7z/djMxGUvVDMImbI9+V8fOUqGqCiEesguUh5gsCQyJkmKRt8TKcPi3g8cirahPycU8c5ORG39/IqOs2yeYD4ZS1at57796ZyAh4Lqw8seoIFAeovzm2pUWj2kGPcDQcemwoJ2PGXAC/qwTBVCa4i9INxxsBG/xRO3qXQf3bPL22xSICvPySkhT5bA5PuMaUjd7T/QcibHsI9Zp5xC1RLbQeS3eaLq1M8Flb5rMCer/AHtrrmSX3Zzg20Wo6dXFlv3SeOvjJXGSD3J3Dx8LUYcb4zXJ4V/TePN/puc1VbsYwYybrZz7pfJyE+24fj7d08OW9PDmXw==
Received: from SA0PR11CA0060.namprd11.prod.outlook.com (2603:10b6:806:d0::35)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 14:03:03 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::d2) by SA0PR11CA0060.outlook.office365.com
 (2603:10b6:806:d0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Tue,
 8 Apr 2025 14:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:03:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:39 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 08/12] net/mlx5: HWS, Implement action STE pool
Date: Tue, 8 Apr 2025 17:00:52 +0300
Message-ID: <1744120856-341328-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa737f4-7c95-41cd-826f-08dd76a613d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+WVpm7Zf1paq1gCsMNaQkpFCOr0UcyZEg7Mk9XVE0qXemtM2oKBHLVVHdOOn?=
 =?us-ascii?Q?gImuxf73Jcm1WnWNhChrH3z7PS398VPDOr7tJ9Q+65G8xXmw6g55+plkQM9R?=
 =?us-ascii?Q?JNl1D1oLND9RlfV+w08fyl8uSoBa4qL0WkOLaIPIgjlVhq+VBTE3Lwy2MG7r?=
 =?us-ascii?Q?KW3tXu6H4OYhFedztpEqyBf/RjIWNfSEp2VO+eSrlYo8b6DQy7af4cHm/zfb?=
 =?us-ascii?Q?9gKZerEmmsjDYPpt2wjla0ZVg9EhcyRr+8Fb40CJ7eNBziVV3DEJzIrh6ZBO?=
 =?us-ascii?Q?t4+9UuTc2HLN9tdklayx2QUIj7f7z9lJR8yaFDwQxa27bawHy0ISXUdcRwCp?=
 =?us-ascii?Q?QzxuT0CkB4aKGzZ+pDnfdr48c84iZT6pj3jehUD1N2PZC2949azacG4fdYOD?=
 =?us-ascii?Q?5awAd8RQIi7+ikAfZG+0b61PjnxlErBfLWMJz9inttbvZnsIoxx0HPahwhAo?=
 =?us-ascii?Q?1yc7h9iNTxROajYCgauNnexGqeS1G3qXynFeLvQwa7QRBm060aecnESSHHAs?=
 =?us-ascii?Q?j/xX91eRM0XkRpBjDnw3UnMZtGYi18L2EqSn/dl5nkvlw8iLPhXLvqKrmecG?=
 =?us-ascii?Q?xILAi21fMQaQlooXtcjQtfAVgD9dlEtFpQRaeeKllJZFkChtvXNgqVydokw6?=
 =?us-ascii?Q?+MgLzGVw2zlOD2vdh1o8qeuPvfgrDTb7vgrWIzDMBNm7+t8vGSb7T9/qtErE?=
 =?us-ascii?Q?WkR6wkfjzFn6NYAaGM1qQeuDbljCqIJPtWqjTd2STFG2RXVZYeaZ0ZQcQ6Ao?=
 =?us-ascii?Q?UMNXOtQtg4u5p5HmO1q9x2FlfODKHzLiUFCCARGgZAjXUs3AvNvnyQgUmqFj?=
 =?us-ascii?Q?9rjTOftZj3dKIa9UrMfjXTncPPj1fubI5u14HhIvIKWYYeWNYaUh54keDSdS?=
 =?us-ascii?Q?thflstemd5p63ZGaglxl6DmQ9yp9bl9c/UeDm3OhZYdV43dkqSglE2Nt54qH?=
 =?us-ascii?Q?72VWUOqJfQrxr1i1nrAGmMWniAOSypW/Pd1vM8qhRvwwuKSZawyXfbKkg5wd?=
 =?us-ascii?Q?wdh9HeiTt5fkIr5Oe8IUaG2J+/8l6JyNXsfaSHRT3AJPFm/RTYtNKqJ5FLGm?=
 =?us-ascii?Q?RF1j1ZJWLMfBty76eXQdg8wV2T6Pj1EroqwyLCIP1R86wfYpF7I1A/Co5MPP?=
 =?us-ascii?Q?h5Vl1ET1ThvXySbMedQIsM9Fx5xqXvw0+UgF02KztUQcggFsMrwvhv+HS/CX?=
 =?us-ascii?Q?ASGTif7KwR6YOnwD3UO1aws+Zpt7XZ97av1UokhBM5bXuWv3LHLxeVe+sQ/m?=
 =?us-ascii?Q?HGB9nnSP1ZVSv5EAWx6zhK2ya0m28B2Jb9wsVEPhwzWZ7nRYvF3ZA5o382YA?=
 =?us-ascii?Q?CL/66cjY0qo46p+/nUKDNhyQ4ilsY1w6M6UGu5ksK52VuWEwWATo15yi5hxr?=
 =?us-ascii?Q?DJjNti5tHP4L+xaxWekSktNSkKN+hY8mh4HeJHJGjDcCqWlMas2eHkKyf7sV?=
 =?us-ascii?Q?X0FttaqrhiIGVReRDxecl3X9S8Ft1JkfqaDjbA9O7LthOwgPpmoEnwMw4GQ6?=
 =?us-ascii?Q?Cm/UZB7fJ9UPOFg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:03:02.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa737f4-7c95-41cd-826f-08dd76a613d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

From: Vlad Dogaru <vdogaru@nvidia.com>

Implement a per-queue pool of action STEs that match STEs can link to,
regardless of matcher.

The code relies on hints to optimize whether a given rule is added to
rx-only, tx-only or both. Correspondingly, action STEs need to be added
to different RTC for ingress or egress paths. For rx-and-tx rules, the
current rule implementation dictates that the offsets for a given rule
must be the same in both RTCs.

To avoid wasting STEs, each action STE pool element holds 3 pools:
rx-only, tx-only, and rx-and-tx, corresponding to the possible values of
the pool optimization enum. The implementation then chooses at rule
creation / update which of these elements to allocate from.

Each element holds multiple action STE tables, which wrap an RTC, an STE
range, the logic to buddy-allocate offsets from the range, and an STC
that allows match STEs to point to this table. When allocating offsets
from an element, we iterate through available action STE tables and, if
needed, create a new table.

Similar to the previous implementation, this iteration does not free any
resources. This is implemented in a subsequent patch.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 .../mlx5/core/steering/hws/action_ste_pool.c  | 388 ++++++++++++++++++
 .../mlx5/core/steering/hws/action_ste_pool.h  |  58 +++
 .../mellanox/mlx5/core/steering/hws/context.c |   7 +
 .../mellanox/mlx5/core/steering/hws/context.h |   1 +
 .../mlx5/core/steering/hws/internal.h         |   1 +
 .../mellanox/mlx5/core/steering/hws/pool.h    |   1 +
 7 files changed, 458 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 568bbe5f83f5..d292e6a9e22c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -154,7 +154,8 @@ mlx5_core-$(CONFIG_MLX5_HW_STEERING) += steering/hws/cmd.o \
 					steering/hws/vport.o \
 					steering/hws/bwc_complex.o \
 					steering/hws/fs_hws_pools.o \
-					steering/hws/fs_hws.o
+					steering/hws/fs_hws.o \
+					steering/hws/action_ste_pool.o
 
 #
 # SF device
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
new file mode 100644
index 000000000000..e5c453ec65b3
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025 NVIDIA Corporation & Affiliates */
+
+#include "internal.h"
+
+static const char *
+hws_pool_opt_to_str(enum mlx5hws_pool_optimize opt)
+{
+	switch (opt) {
+	case MLX5HWS_POOL_OPTIMIZE_NONE:
+		return "rx-and-tx";
+	case MLX5HWS_POOL_OPTIMIZE_ORIG:
+		return "rx-only";
+	case MLX5HWS_POOL_OPTIMIZE_MIRROR:
+		return "tx-only";
+	default:
+		return "unknown";
+	}
+}
+
+static int
+hws_action_ste_table_create_pool(struct mlx5hws_context *ctx,
+				 struct mlx5hws_action_ste_table *action_tbl,
+				 enum mlx5hws_pool_optimize opt, size_t log_sz)
+{
+	struct mlx5hws_pool_attr pool_attr = { 0 };
+
+	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
+	pool_attr.table_type = MLX5HWS_TABLE_TYPE_FDB;
+	pool_attr.flags = MLX5HWS_POOL_FLAG_BUDDY;
+	pool_attr.opt_type = opt;
+	pool_attr.alloc_log_sz = log_sz;
+
+	action_tbl->pool = mlx5hws_pool_create(ctx, &pool_attr);
+	if (!action_tbl->pool) {
+		mlx5hws_err(ctx, "Failed to allocate STE pool\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hws_action_ste_table_create_single_rtc(
+	struct mlx5hws_context *ctx,
+	struct mlx5hws_action_ste_table *action_tbl,
+	enum mlx5hws_pool_optimize opt, size_t log_sz, bool tx)
+{
+	struct mlx5hws_cmd_rtc_create_attr rtc_attr = { 0 };
+	u32 *rtc_id;
+
+	rtc_attr.log_depth = 0;
+	rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
+	/* Action STEs use the default always hit definer. */
+	rtc_attr.match_definer_0 = ctx->caps->trivial_match_definer;
+	rtc_attr.is_frst_jumbo = false;
+	rtc_attr.miss_ft_id = 0;
+	rtc_attr.pd = ctx->pd_num;
+	rtc_attr.ste_offset = 0;
+	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
+
+	if (tx) {
+		rtc_attr.table_type = FS_FT_FDB_TX;
+		rtc_attr.ste_base =
+			mlx5hws_pool_get_base_mirror_id(action_tbl->pool);
+		rtc_attr.stc_base =
+			mlx5hws_pool_get_base_mirror_id(ctx->stc_pool);
+		rtc_attr.log_size =
+			opt == MLX5HWS_POOL_OPTIMIZE_ORIG ? 0 : log_sz;
+		rtc_id = &action_tbl->rtc_1_id;
+	} else {
+		rtc_attr.table_type = FS_FT_FDB_RX;
+		rtc_attr.ste_base = mlx5hws_pool_get_base_id(action_tbl->pool);
+		rtc_attr.stc_base = mlx5hws_pool_get_base_id(ctx->stc_pool);
+		rtc_attr.log_size =
+			opt == MLX5HWS_POOL_OPTIMIZE_MIRROR ? 0 : log_sz;
+		rtc_id = &action_tbl->rtc_0_id;
+	}
+
+	return mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_id);
+}
+
+static int
+hws_action_ste_table_create_rtcs(struct mlx5hws_context *ctx,
+				 struct mlx5hws_action_ste_table *action_tbl,
+				 enum mlx5hws_pool_optimize opt, size_t log_sz)
+{
+	int err;
+
+	err = hws_action_ste_table_create_single_rtc(ctx, action_tbl, opt,
+						     log_sz, false);
+	if (err)
+		return err;
+
+	err = hws_action_ste_table_create_single_rtc(ctx, action_tbl, opt,
+						     log_sz, true);
+	if (err) {
+		mlx5hws_cmd_rtc_destroy(ctx->mdev, action_tbl->rtc_0_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static void
+hws_action_ste_table_destroy_rtcs(struct mlx5hws_action_ste_table *action_tbl)
+{
+	mlx5hws_cmd_rtc_destroy(action_tbl->pool->ctx->mdev,
+				action_tbl->rtc_1_id);
+	mlx5hws_cmd_rtc_destroy(action_tbl->pool->ctx->mdev,
+				action_tbl->rtc_0_id);
+}
+
+static int
+hws_action_ste_table_create_stc(struct mlx5hws_context *ctx,
+				struct mlx5hws_action_ste_table *action_tbl)
+{
+	struct mlx5hws_cmd_stc_modify_attr stc_attr = { 0 };
+
+	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
+	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_STE_TABLE;
+	stc_attr.reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
+	stc_attr.ste_table.ste_pool = action_tbl->pool;
+	stc_attr.ste_table.match_definer_id = ctx->caps->trivial_match_definer;
+
+	return mlx5hws_action_alloc_single_stc(ctx, &stc_attr,
+					       MLX5HWS_TABLE_TYPE_FDB,
+					       &action_tbl->stc);
+}
+
+static struct mlx5hws_action_ste_table *
+hws_action_ste_table_alloc(struct mlx5hws_action_ste_pool_element *parent_elem)
+{
+	enum mlx5hws_pool_optimize opt = parent_elem->opt;
+	struct mlx5hws_context *ctx = parent_elem->ctx;
+	struct mlx5hws_action_ste_table *action_tbl;
+	size_t log_sz;
+	int err;
+
+	log_sz = min(parent_elem->log_sz ?
+			     parent_elem->log_sz +
+				     MLX5HWS_ACTION_STE_TABLE_STEP_LOG_SZ :
+				   MLX5HWS_ACTION_STE_TABLE_INIT_LOG_SZ,
+		     MLX5HWS_ACTION_STE_TABLE_MAX_LOG_SZ);
+
+	action_tbl = kzalloc(sizeof(*action_tbl), GFP_KERNEL);
+	if (!action_tbl)
+		return ERR_PTR(-ENOMEM);
+
+	err = hws_action_ste_table_create_pool(ctx, action_tbl, opt, log_sz);
+	if (err)
+		goto free_tbl;
+
+	err = hws_action_ste_table_create_rtcs(ctx, action_tbl, opt, log_sz);
+	if (err)
+		goto destroy_pool;
+
+	err = hws_action_ste_table_create_stc(ctx, action_tbl);
+	if (err)
+		goto destroy_rtcs;
+
+	action_tbl->parent_elem = parent_elem;
+	INIT_LIST_HEAD(&action_tbl->list_node);
+	list_add(&action_tbl->list_node, &parent_elem->available);
+	parent_elem->log_sz = log_sz;
+
+	mlx5hws_dbg(ctx,
+		    "Allocated %s action STE table log_sz %zu; STEs (%d, %d); RTCs (%d, %d); STC %d\n",
+		    hws_pool_opt_to_str(opt), log_sz,
+		    mlx5hws_pool_get_base_id(action_tbl->pool),
+		    mlx5hws_pool_get_base_mirror_id(action_tbl->pool),
+		    action_tbl->rtc_0_id, action_tbl->rtc_1_id,
+		    action_tbl->stc.offset);
+
+	return action_tbl;
+
+destroy_rtcs:
+	hws_action_ste_table_destroy_rtcs(action_tbl);
+destroy_pool:
+	mlx5hws_pool_destroy(action_tbl->pool);
+free_tbl:
+	kfree(action_tbl);
+
+	return ERR_PTR(err);
+}
+
+static void
+hws_action_ste_table_destroy(struct mlx5hws_action_ste_table *action_tbl)
+{
+	struct mlx5hws_context *ctx = action_tbl->parent_elem->ctx;
+
+	mlx5hws_dbg(ctx,
+		    "Destroying %s action STE table: STEs (%d, %d); RTCs (%d, %d); STC %d\n",
+		    hws_pool_opt_to_str(action_tbl->parent_elem->opt),
+		    mlx5hws_pool_get_base_id(action_tbl->pool),
+		    mlx5hws_pool_get_base_mirror_id(action_tbl->pool),
+		    action_tbl->rtc_0_id, action_tbl->rtc_1_id,
+		    action_tbl->stc.offset);
+
+	mlx5hws_action_free_single_stc(ctx, MLX5HWS_TABLE_TYPE_FDB,
+				       &action_tbl->stc);
+	hws_action_ste_table_destroy_rtcs(action_tbl);
+	mlx5hws_pool_destroy(action_tbl->pool);
+
+	list_del(&action_tbl->list_node);
+	kfree(action_tbl);
+}
+
+static int
+hws_action_ste_pool_element_init(struct mlx5hws_context *ctx,
+				 struct mlx5hws_action_ste_pool_element *elem,
+				 enum mlx5hws_pool_optimize opt)
+{
+	elem->ctx = ctx;
+	elem->opt = opt;
+	INIT_LIST_HEAD(&elem->available);
+	INIT_LIST_HEAD(&elem->full);
+
+	return 0;
+}
+
+static void hws_action_ste_pool_element_destroy(
+	struct mlx5hws_action_ste_pool_element *elem)
+{
+	struct mlx5hws_action_ste_table *action_tbl, *p;
+
+	/* This should be empty, but attempt to free its elements anyway. */
+	list_for_each_entry_safe(action_tbl, p, &elem->full, list_node)
+		hws_action_ste_table_destroy(action_tbl);
+
+	list_for_each_entry_safe(action_tbl, p, &elem->available, list_node)
+		hws_action_ste_table_destroy(action_tbl);
+}
+
+static int hws_action_ste_pool_init(struct mlx5hws_context *ctx,
+				    struct mlx5hws_action_ste_pool *pool)
+{
+	enum mlx5hws_pool_optimize opt;
+	int err;
+
+	/* Rules which are added for both RX and TX must use the same action STE
+	 * indices for both. If we were to use a single table, then RX-only and
+	 * TX-only rules would waste the unused entries. Thus, we use separate
+	 * table sets for the three cases.
+	 */
+	for (opt = MLX5HWS_POOL_OPTIMIZE_NONE; opt < MLX5HWS_POOL_OPTIMIZE_MAX;
+	     opt++) {
+		err = hws_action_ste_pool_element_init(ctx, &pool->elems[opt],
+						       opt);
+		if (err)
+			goto destroy_elems;
+	}
+
+	return 0;
+
+destroy_elems:
+	while (opt-- > MLX5HWS_POOL_OPTIMIZE_NONE)
+		hws_action_ste_pool_element_destroy(&pool->elems[opt]);
+
+	return err;
+}
+
+static void hws_action_ste_pool_destroy(struct mlx5hws_action_ste_pool *pool)
+{
+	int opt;
+
+	for (opt = MLX5HWS_POOL_OPTIMIZE_MAX - 1;
+	     opt >= MLX5HWS_POOL_OPTIMIZE_NONE; opt--)
+		hws_action_ste_pool_element_destroy(&pool->elems[opt]);
+}
+
+int mlx5hws_action_ste_pool_init(struct mlx5hws_context *ctx)
+{
+	struct mlx5hws_action_ste_pool *pool;
+	size_t queues = ctx->queues;
+	int i, err;
+
+	pool = kcalloc(queues, sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return -ENOMEM;
+
+	for (i = 0; i < queues; i++) {
+		err = hws_action_ste_pool_init(ctx, &pool[i]);
+		if (err)
+			goto free_pool;
+	}
+
+	ctx->action_ste_pool = pool;
+
+	return 0;
+
+free_pool:
+	while (i--)
+		hws_action_ste_pool_destroy(&pool[i]);
+	kfree(pool);
+
+	return err;
+}
+
+void mlx5hws_action_ste_pool_uninit(struct mlx5hws_context *ctx)
+{
+	size_t queues = ctx->queues;
+	int i;
+
+	for (i = 0; i < queues; i++)
+		hws_action_ste_pool_destroy(&ctx->action_ste_pool[i]);
+
+	kfree(ctx->action_ste_pool);
+}
+
+static struct mlx5hws_action_ste_pool_element *
+hws_action_ste_choose_elem(struct mlx5hws_action_ste_pool *pool,
+			   bool skip_rx, bool skip_tx)
+{
+	if (skip_rx)
+		return &pool->elems[MLX5HWS_POOL_OPTIMIZE_MIRROR];
+
+	if (skip_tx)
+		return &pool->elems[MLX5HWS_POOL_OPTIMIZE_ORIG];
+
+	return &pool->elems[MLX5HWS_POOL_OPTIMIZE_NONE];
+}
+
+static int
+hws_action_ste_table_chunk_alloc(struct mlx5hws_action_ste_table *action_tbl,
+				 struct mlx5hws_action_ste_chunk *chunk)
+{
+	int err;
+
+	err = mlx5hws_pool_chunk_alloc(action_tbl->pool, &chunk->ste);
+	if (err)
+		return err;
+
+	chunk->action_tbl = action_tbl;
+
+	return 0;
+}
+
+int mlx5hws_action_ste_chunk_alloc(struct mlx5hws_action_ste_pool *pool,
+				   bool skip_rx, bool skip_tx,
+				   struct mlx5hws_action_ste_chunk *chunk)
+{
+	struct mlx5hws_action_ste_pool_element *elem;
+	struct mlx5hws_action_ste_table *action_tbl;
+	bool found;
+	int err;
+
+	if (skip_rx && skip_tx)
+		return -EINVAL;
+
+	elem = hws_action_ste_choose_elem(pool, skip_rx, skip_tx);
+
+	mlx5hws_dbg(elem->ctx,
+		    "Allocating action STEs skip_rx %d skip_tx %d order %d\n",
+		    skip_rx, skip_tx, chunk->ste.order);
+
+	found = false;
+	list_for_each_entry(action_tbl, &elem->available, list_node) {
+		if (!hws_action_ste_table_chunk_alloc(action_tbl, chunk)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		action_tbl = hws_action_ste_table_alloc(elem);
+		if (IS_ERR(action_tbl))
+			return PTR_ERR(action_tbl);
+
+		err = hws_action_ste_table_chunk_alloc(action_tbl, chunk);
+		if (err)
+			return err;
+	}
+
+	if (mlx5hws_pool_empty(action_tbl->pool))
+		list_move(&action_tbl->list_node, &elem->full);
+
+	return 0;
+}
+
+void mlx5hws_action_ste_chunk_free(struct mlx5hws_action_ste_chunk *chunk)
+{
+	mlx5hws_dbg(chunk->action_tbl->pool->ctx,
+		    "Freeing action STEs offset %d order %d\n",
+		    chunk->ste.offset, chunk->ste.order);
+	mlx5hws_pool_chunk_free(chunk->action_tbl->pool, &chunk->ste);
+	list_move(&chunk->action_tbl->list_node,
+		  &chunk->action_tbl->parent_elem->available);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h
new file mode 100644
index 000000000000..2de660a63223
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025 NVIDIA Corporation & Affiliates */
+
+#ifndef ACTION_STE_POOL_H_
+#define ACTION_STE_POOL_H_
+
+#define MLX5HWS_ACTION_STE_TABLE_INIT_LOG_SZ 10
+#define MLX5HWS_ACTION_STE_TABLE_STEP_LOG_SZ 1
+#define MLX5HWS_ACTION_STE_TABLE_MAX_LOG_SZ 20
+
+struct mlx5hws_action_ste_pool_element;
+
+struct mlx5hws_action_ste_table {
+	struct mlx5hws_action_ste_pool_element *parent_elem;
+	/* Wraps the RTC and STE range for this given action. */
+	struct mlx5hws_pool *pool;
+	/* Match STEs use this STC to jump to this pool's RTC. */
+	struct mlx5hws_pool_chunk stc;
+	u32 rtc_0_id;
+	u32 rtc_1_id;
+	struct list_head list_node;
+};
+
+struct mlx5hws_action_ste_pool_element {
+	struct mlx5hws_context *ctx;
+	size_t log_sz;  /* Size of the largest table so far. */
+	enum mlx5hws_pool_optimize opt;
+	struct list_head available;
+	struct list_head full;
+};
+
+/* Central repository of action STEs. The context contains one of these pools
+ * per queue.
+ */
+struct mlx5hws_action_ste_pool {
+	struct mlx5hws_action_ste_pool_element elems[MLX5HWS_POOL_OPTIMIZE_MAX];
+};
+
+/* A chunk of STEs and the table it was allocated from. Used by rules. */
+struct mlx5hws_action_ste_chunk {
+	struct mlx5hws_action_ste_table *action_tbl;
+	struct mlx5hws_pool_chunk ste;
+};
+
+int mlx5hws_action_ste_pool_init(struct mlx5hws_context *ctx);
+
+void mlx5hws_action_ste_pool_uninit(struct mlx5hws_context *ctx);
+
+/* Callers are expected to fill chunk->ste.order. On success, this function
+ * populates chunk->tbl and chunk->ste.offset.
+ */
+int mlx5hws_action_ste_chunk_alloc(struct mlx5hws_action_ste_pool *pool,
+				   bool skip_rx, bool skip_tx,
+				   struct mlx5hws_action_ste_chunk *chunk);
+
+void mlx5hws_action_ste_chunk_free(struct mlx5hws_action_ste_chunk *chunk);
+
+#endif /* ACTION_STE_POOL_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index b7cb736b74d7..428dae869706 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -158,10 +158,16 @@ static int hws_context_init_hws(struct mlx5hws_context *ctx,
 	if (ret)
 		goto pools_uninit;
 
+	ret = mlx5hws_action_ste_pool_init(ctx);
+	if (ret)
+		goto close_queues;
+
 	INIT_LIST_HEAD(&ctx->tbl_list);
 
 	return 0;
 
+close_queues:
+	mlx5hws_send_queues_close(ctx);
 pools_uninit:
 	hws_context_pools_uninit(ctx);
 uninit_pd:
@@ -174,6 +180,7 @@ static void hws_context_uninit_hws(struct mlx5hws_context *ctx)
 	if (!(ctx->flags & MLX5HWS_CONTEXT_FLAG_HWS_SUPPORT))
 		return;
 
+	mlx5hws_action_ste_pool_uninit(ctx);
 	mlx5hws_send_queues_close(ctx);
 	hws_context_pools_uninit(ctx);
 	hws_context_uninit_pd(ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 38c3647444ad..e987e93bbc6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -39,6 +39,7 @@ struct mlx5hws_context {
 	struct mlx5hws_cmd_query_caps *caps;
 	u32 pd_num;
 	struct mlx5hws_pool *stc_pool;
+	struct mlx5hws_action_ste_pool *action_ste_pool; /* One per queue */
 	struct mlx5hws_context_common_res common_res;
 	struct mlx5hws_pattern_cache *pattern_cache;
 	struct mlx5hws_definer_cache *definer_cache;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
index 30ccd635b505..21279d503117 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
@@ -17,6 +17,7 @@
 #include "context.h"
 #include "table.h"
 #include "send.h"
+#include "action_ste_pool.h"
 #include "rule.h"
 #include "cmd.h"
 #include "action.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index c82760d53e1a..33e33d5f1fb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -33,6 +33,7 @@ enum mlx5hws_pool_optimize {
 	MLX5HWS_POOL_OPTIMIZE_NONE = 0x0,
 	MLX5HWS_POOL_OPTIMIZE_ORIG = 0x1,
 	MLX5HWS_POOL_OPTIMIZE_MIRROR = 0x2,
+	MLX5HWS_POOL_OPTIMIZE_MAX = 0x3,
 };
 
 struct mlx5hws_pool_attr {
-- 
2.31.1


