Return-Path: <linux-rdma+bounces-9352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB2EA84CD5
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3624E1B98
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CBD296171;
	Thu, 10 Apr 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7545qtu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325C296170;
	Thu, 10 Apr 2025 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312756; cv=fail; b=jBq4TVRetY8OO9M6hK3FKXNRMnGQPZl12Oy/5nro8XPuOgxUw81i5/5c01wrTTLr36GHugxj1FL8p0pQytOsDsvD3IhwQsbMBLIBOrYllFzRaonfMj15L5SEtwX98jVwywJ00pUpm2P39CCdQ2SYvxS3b1k/JZl6RmO/GYAa4Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312756; c=relaxed/simple;
	bh=bpmwnnNT0TPnittb4B4/Chdhy/HnRUXy1S+yKVqJ/Lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rovX1BvNVm4EPUuvYpxQXOoxfBk+Uh5dT8BUbeFLhsIpLM/WkmiThep9wdpdUNVaqx1RPMWs1xQg+IJEWq7z0k7CQv/XEZDDpBI7COTgbcGkK3ULMEg7uA7KyZM84J0xRPb4Sa2Zn5UiP/pj9XDtMsfDLhsLGrMY9fzMobdxo4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7545qtu; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPg64bIV3It39t2t3wSUr98EKYKYlV7VDbq21WAh2q0AeG9KwIjJi+KEtScm7nUZG4JOG3GCAUhNdERukCkbvUnC6vv2ck/FYmuih3CmZgIN8dP+y7vT8wfxY+mkHvmTXVcYAQWwWF+N9Vkp9PxXZQ9QUFprPqtJydRvGADaIzKdFIGl6ndBmpDkwxJ+ckKcEqQkiXZmsypTo82ju6CfPpAjNHeHfApMwc0m1WRWFVLBylxHKcbWPdDkRJ/fNHVE09OGyRDogbhet0zaUUd3ZbAYei54B1wWZGbWGW4+1oO30hecEsJUKWU4vZnaij537xDPHfZEQypg7kjV4F3jpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEXlfYGTU68OR9C/ldrCfG61+2IJVCuSOAQ7rbgdvzo=;
 b=lWz/dtL+LqPpe4yZG8dk1KUop1NSeXWVZQO6b4YrSWPUVq7WzPiMl52E+DLd96QPNqwY2iR/2O0AupYzy2HU3C7ea1C+9QqyzV3dUld25qRb0yED4/YL3HUJj/tDFNObUewaszC2wn1CTvmEfbUNuhYCTZzzm+yASqycOaLWLXJdRaQ4XIje+eCru+yTmlp+NFXctJZSjowT8jj5lbcDZinaJjV5hs38VsOUY3eLb5h32uFReiMpX0vppzEnjt9mdDgUjxS1YwIcrKTSJMs6MgO15aapsrNIAGbw1bW19X+vr9SKqWZbH/T8XC7qo/zAdoGdQOJ/M+2aKZXGaWKZqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEXlfYGTU68OR9C/ldrCfG61+2IJVCuSOAQ7rbgdvzo=;
 b=l7545qtuEy6s2V4+NJt4c7kVkb/sJtISuXSVqaJeBLfzjSC0glWHWlBRy1JAg6YjReoTpcmFHzmuE82AbBkxjHpBq7Rbm1aTKQqr/onIKLlk8df7+zGKyu+tmdIAo/kNyNTlSd7N76rLT3AR/0vnBZt4xOCjEf78S/BsAk4ozGBdMnRgRTCQoKWSCq4vXvx4kLungQfUgTOfW1CbEXEekARxjyCP7mFQFOV1Dv2v78+UGZCKFXrP8gaANTdwdyKs1jrblraPmI1x+b6q+ELDJ2gvag8QpAq//lmRt3kW5VHX2h++5GMKD+B+f8T4kUqKrmko503kiiBtJgffoY5yPQ==
Received: from SA0PR11CA0086.namprd11.prod.outlook.com (2603:10b6:806:d2::31)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 10 Apr
 2025 19:19:05 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::df) by SA0PR11CA0086.outlook.office365.com
 (2603:10b6:806:d2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.22 via Frontend Transport; Thu,
 10 Apr 2025 19:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:19:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 08/12] net/mlx5: HWS, Implement action STE pool
Date: Thu, 10 Apr 2025 22:17:38 +0300
Message-ID: <1744312662-356571-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5972b715-a1a3-4257-559c-08dd78648f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gM932RYiMnDJZTdwzuIqqWw7iriLVI/DEcPA+xSX3WI9H7hEBk2beYpVC3Ad?=
 =?us-ascii?Q?pIymmCehHa+vZw0T2BHBVlgW1r6o5HZ+PoCQ3Pb4tKXzWwXNZNxNAnVD3R17?=
 =?us-ascii?Q?2SbLKzSeN8Gc0M7hBsH4MJieSeOatiiuwI6w0QSXgR/RxjBqEtBmdiHFhUio?=
 =?us-ascii?Q?WAh+9UAJqIJ1yEIZ2YGSvMZy06EPYbDxEY+H4ZlNdvNQdcc7076+xcqRuWnY?=
 =?us-ascii?Q?5SMUeCS9FmvGxMh9AaoNgUTuvyL5RQPCEj/P2ADwJyYc/vFhzXuwRsjTy9hV?=
 =?us-ascii?Q?wPBirrJ8W6ESvq/bnzezebZEJn2UDapdeikjSjAGrgSkcM0U/+5K/mRo9Ji+?=
 =?us-ascii?Q?VEKt+RHpF8KjDNV/APx3utJjpfLGzBifMOi7uYZKndjtd3D5FJI4g26ZoxII?=
 =?us-ascii?Q?wBL3Mog0leAZ4gQuRVnrGuslLF0Iv7ZrcenmZ3BBSrDmWekDfm7kqBVq6C1P?=
 =?us-ascii?Q?PtOwGDmfxQEl1bGqui08h1/dbV1MiFEe4SIsFPdW8+qGrqQk/Mro/AZCa3EI?=
 =?us-ascii?Q?4HurPZJw2OtRijWNKcQ3Xkc2AkrNMNFUdDotkekVX6EZ36paAxXcvmMyNp9q?=
 =?us-ascii?Q?MU9HbBD3Gkt5tf/+COZXLMnRi6l153zLnx/O9bDBWYHXg94nfi1TAnozQoqu?=
 =?us-ascii?Q?tsU54E+KJ8E8H2WRJdcVFE5uHwlyGVvO4h1Kqd/L1U6do544EP+M8PGZ3HsM?=
 =?us-ascii?Q?lNeWIEXEhFc7YObNjyyV8rRpkGcRPBHS36UefL2lvClbtgDukZV7/GfgJUFN?=
 =?us-ascii?Q?RnRfHOWuzYCpPXp7MbEwoUNjaMbIZ4VEDBYcRRfFougtXZVkkg0G7foJAcEQ?=
 =?us-ascii?Q?lmfKmgt0r+77uTqQJHmqkLjJ1tSi4df4rPQMJvQ7wx6NxDYxPQ/4Sl3j/rpT?=
 =?us-ascii?Q?ZhGqo8SbIGD+JgEuxu83//xULXmgvL0nWL0i5eYrNzjTxZR9roRa+sNZtNpa?=
 =?us-ascii?Q?A4QO99Ee65J12ScU7x5hAu2+31LhhfOQgR9D5Dcnpq7vaN3C+gToyxb39koL?=
 =?us-ascii?Q?xgKLZJd1AagdfDlx1jHcZnA3/OBztx5GoHAKkG3AymTXUyj7LsSykuKyiatp?=
 =?us-ascii?Q?4gKqEP9WImb/gYHkeH8+FAsv11dIyfMgECPOGHuq3962goovA3JB94bepMF7?=
 =?us-ascii?Q?72URZXS9B5HClAlfBSCQJRjtw5FP9I4ECp9n8TURWJVHznVdtnOjQ17lVncY?=
 =?us-ascii?Q?XhYtPS/CUiBYICZDlgDQDGuym/fmuNZQv+zZMrt10TtbVOmQ/EPxSxbuRmns?=
 =?us-ascii?Q?QEkNntXn/R9K3hvOeNt2p1ecjv8piZ4i2u9KWHEDqpQ7RT/msiQ8pZHEBCdh?=
 =?us-ascii?Q?T4NrBY7eH23PmYYuSlC86Pd9osHu2QfWyAP9n0NA+4s64EgFoD7wjpqPbc4f?=
 =?us-ascii?Q?ocyCcUwu0pTfgzzAY5xnuAE0ghdk203/8o4lOOCFu+F96heiK4Tgv3M4DOzX?=
 =?us-ascii?Q?jZej22hro4FtWycAAvhYXdLiCKHGEO+vI1bzyiV3ehng2eTYIr7YRQ+o1F+1?=
 =?us-ascii?Q?+z4NwNyB86soJFt1GP33TbcvNs9iEupUUFH1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:19:04.9691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5972b715-a1a3-4257-559c-08dd78648f2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

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
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 .../mlx5/core/steering/hws/action_ste_pool.c  | 387 ++++++++++++++++++
 .../mlx5/core/steering/hws/action_ste_pool.h  |  58 +++
 .../mellanox/mlx5/core/steering/hws/context.c |   7 +
 .../mellanox/mlx5/core/steering/hws/context.h |   1 +
 .../mlx5/core/steering/hws/internal.h         |   1 +
 .../mellanox/mlx5/core/steering/hws/pool.h    |   1 +
 7 files changed, 457 insertions(+), 1 deletion(-)
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
index 000000000000..cb6ad8411631
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
@@ -0,0 +1,387 @@
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


