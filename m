Return-Path: <linux-rdma+bounces-11461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686BAE0483
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778837AB0BF
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7F24DCE1;
	Thu, 19 Jun 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DX+FZ9Kb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D63248F77;
	Thu, 19 Jun 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334170; cv=fail; b=sXB9fgJN+dgnAOWlczH7NT9vM6alG+YDsZS38jsgKLaQkitvOjmni3rFLMquiJEm5T+MVpI2vJGc6UnR/1ngdsRdu9DmGvH2RvYccqHM2RAR3l2UxXpl0KDIexyobF2RqcmXvCx6/ACao2QyGIH82wXydY/G1p4ZIlJfp+1nO54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334170; c=relaxed/simple;
	bh=8/c2mhYCy5W0ouxskrlqgiZ4J+mE8AYfwxVbe3BEDzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmXdG6YrN+KMrYrH/L0CVGV+rFbV5TGvAvLnVEvfBphydrOlQwPDLQmS+TEEwmoh2GXcmWM5dwC0ZfPlDGf1tUaArm2LEinrcTVDsjRwP1y+955pUakD1xHPUn12Cf2ZYyiqytBOLE5wwM/Bp78llisUCnCag8AohF8CijZOuag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DX+FZ9Kb; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQ/G6Fm3lGgjZbJ4Ga3Loe9fwPO4cAHXIz+h2FRToIduNmU/kYyve3UeQEuzlRO+CVJKzMgvdVqUC32rDqeiYFWxxR4jDgQQ5o36k5tgktv8xB/j+FDlhd+Q4s5+N7yVXNw6YCcuabDBfx0VxZ9P0RsSbT8j3y5HqZp4zY45ZsIJ1SjgrCTyKR40O+cdDXQfwPboEIr8ECKwtJZbPLOdenI56d6RRVKqBrVecHFkf+DBruS8xgXB/V91qkCbgXt9W3PjnrpashA/9aoj5y2vM8B38NrM0yrL6EdItNS+5lPopyWifZhi0EeOX8TkEuFSHg7FczM/EtLw0qwxqXgsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMq8l0xHYUDgnwpz10rB2NzvLJKEUsybDaVcUKvYK/M=;
 b=twhEAFexGYrYOqjPT34Ib0RQ3rrKoBle8MNKFp0v1szkrVDeGdoLoIs7CNWex2YANlqNdAmB589a84FQc1sV8J7kIFwXuesODY3pmZJ6agcbDFGd5fCwQGL+Ur7XgK6KEpA0TqrfnWZQJmprnCc0+t3GaDjJoPu9ghXz7zQaF5Kacxgc3ljjG1vBuc3h4rLn6ZAFwsvU1wriH0hh1lJuClFovdHD9kanHngIFLIjLkwUvANJedhcxRz3Y7DhtJNyfhbHos2OMibEqzD0WJ1k0urXSVt13jDtl/8GmGHfj6N2BA5OU1baE/KvUnZGTlO+Zau+VYhphKOY2eT7xhExzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMq8l0xHYUDgnwpz10rB2NzvLJKEUsybDaVcUKvYK/M=;
 b=DX+FZ9KbcV3mpK+utHLG37FX+9G5qwmeXyHHkS10m2/SzhIEQAshD3HA1yt2rH7g4nA9VEOs3sazIiGfnyCj4SNugI6pqvEJlT9tVURhle3taqkpZx5VOC2bWf6TptZkBb04IxbjOaP8NcGv6glMMyUCltgeANs0XCdoCpIqyFmsADCJvcyeko4Xa/JQsSXvnsamOIHkYEyWNcHVxzgQO2GAkDf1QS1FVCtjlN53aG0htVR3keEfZXUC3UAhbwDIcdDQzSCMAbM9/9W3km/yKbQjugGWdE2dhPjHO5OEP3X3OgJ4m9v04garFdbjUONSk/i1dRvbsuL+LpVwcY1w0g==
Received: from SJ0PR05CA0209.namprd05.prod.outlook.com (2603:10b6:a03:330::34)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 11:56:04 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::a1) by SJ0PR05CA0209.outlook.office365.com
 (2603:10b6:a03:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.12 via Frontend Transport; Thu,
 19 Jun 2025 11:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:56:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:56:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:55 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 7/8] net/mlx5: HWS, Shrink empty matchers
Date: Thu, 19 Jun 2025 14:55:21 +0300
Message-ID: <20250619115522.68469-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: c4082114-c1de-42b2-bf51-08ddaf284489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|30052699003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VD6pLIoLjmWZV1EVq68nxaJjvGA6UdoM08/RmREfQdlRBHuPF6WI+IJGH0SF?=
 =?us-ascii?Q?rbAM4F5lSK44wjYZF3wOR57MJ/PV+mvBI91xI7H8TaNumBwLBDK8ozMF/nFH?=
 =?us-ascii?Q?VD1KE8gdR1zdSGz8ijJpPzAekHS+Zmnp9+ROfajUtgYeWuE+o5+MMapD8hBg?=
 =?us-ascii?Q?GzHB90i1BlOo92PVD51DoRo9d0iLHRxHQz9lsC9xRD27fM0qwc2S28tXWKfL?=
 =?us-ascii?Q?2zeBPVmoPtcMrs/yhz1wDidq8GkTU7AdgIMVtf/GlgYcJsWqYwC6pLBUw+C6?=
 =?us-ascii?Q?3/PtZKhjviOjtEket8OF7zzOwAwOqJB/bTMxDiGjG49Mgdr5ZXgjiGe4gUvD?=
 =?us-ascii?Q?KP3gooqK0/30klzNgNsGz3UhGak32/Z183JeW2j+EUExyortlmgdGoYLOILu?=
 =?us-ascii?Q?lWzi5ovZ2k3/KOpNLVZyOTt+aa730XA9uLKCJdOIgwrQKLsJu+r/aqV+Blav?=
 =?us-ascii?Q?0FQRu/ncoVZ2/MHqvFZ8a4P2eglg2rijc76NVtJl5DAIf4OwYoIeNtcXIWt4?=
 =?us-ascii?Q?z9LHBoS5jkucK+ZU2kdW8MdSe/Ecqa29D8mvl0ZRwzCzOU5ZcIojfVzzvVkr?=
 =?us-ascii?Q?MxbfrHZfdmjqBVXLbTfVMHteCv6J6SeOTt4VTARwu/icGJTgu6HWmK6l+OVg?=
 =?us-ascii?Q?UZGMYG6o7J+A1AlOAmSDBqXJ1PHWGUm5b8uPDT+TSCLwyGSU0K/sEQ0Mms4M?=
 =?us-ascii?Q?SwroNAMIuJ1HEQRpXEnlVNgwmYMch9QI5SM4PjZjRKclJAJnb6pf5NtG+HoO?=
 =?us-ascii?Q?Cwp65zT9B1xU/qfyH9PcXXsaUb1VJte9QY+/8srpB4Ht4YsKf+/575u+nSg/?=
 =?us-ascii?Q?YT2KK07Nsb7j0aE8SRHWSuDecDTLEWr8C5R8Of0oUX1CE1U2nI1lDKP6DALr?=
 =?us-ascii?Q?VdJEynzircSiV2tLYmoedx8nDkbuUqTdXmLk16BWT4zV0R67F3ACcUYLrL6e?=
 =?us-ascii?Q?eMQ2tyHT0FxqemAsz8fGCnW4JwhXHYy9q7y+QOOtig0cYY8C8cbrnjBCsjYe?=
 =?us-ascii?Q?cAsPy4eNi7L5zhxiMLLqE8GzO88u0y7MhoLupVxIeI+ej9G/tDIm3Cjb7iXp?=
 =?us-ascii?Q?R8e9UJHG46huGQHxUPDW5s2q4NVI9nryeq4NVZBOv3J13TlXsURMSgXWTrw9?=
 =?us-ascii?Q?RFGgcWKqTqUB4PPt7SPCX6VIAmxxhOkMSpzXVpZPRki3d5dM9VGcIJOYvuKi?=
 =?us-ascii?Q?diS5G+r+xwXu0brywB4FcRqLFY2cJY8FzTmjKqHzOqbhP1lk+G2eO2g5Dwi0?=
 =?us-ascii?Q?TPjo5nvk9dtXFYnLJb0elKC+amYlRFdroyneqL/9A6wm9E8vV5Y2jAfnRWMj?=
 =?us-ascii?Q?1jmtOzT5h10MS32QrcGtKn8oxpgfhr/mXQM6NV5/vomY+2fDhyA/vDUuiHpM?=
 =?us-ascii?Q?dm6tKyenb635S34MKaQ2e9sQjVb8xN6Qb4auIqEZDkLiurTcmbqSLlkXQ1Zh?=
 =?us-ascii?Q?22FFvVjRFAGkEiO+P8X3u8PLtg2Cp0NhxidOt5zQdREDejjw0e+NnAFTAQJq?=
 =?us-ascii?Q?A7wJb4OH9+UP3svFGCI2+0eH7O9lVu/w/6ng?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(30052699003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:56:03.9660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4082114-c1de-42b2-bf51-08ddaf284489
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Matcher size is dynamic: it starts at initial size, and then it grows
through rehash as more and more rules are added to this matcher.
When rules are deleted, matcher's size is not decreased. Rehash
approach is greedy. The idea is: if the matcher got to a certain size
at some point, chances are - it will get to this size again, so it is
better to avoid costly rehash operations whenever possible.

However, when all the rules of the matcher are deleted, this should
be viewed as special case. If the matcher actually got to the point
where it has zero rules, it might be an indication that some usecase
from the past is no longer happening. This is where some ICM can be
freed.

This patch handles this case: when a number of rules in a matcher
goes down to zero, the matcher's tables are shrunk to the initial
size.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 0a7903cf75e8..b7098c7d2112 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -3,6 +3,8 @@
 
 #include "internal.h"
 
+static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher);
+
 static u16 hws_bwc_gen_queue_idx(struct mlx5hws_context *ctx)
 {
 	/* assign random queue */
@@ -409,6 +411,70 @@ static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
 		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
 }
 
+static int
+hws_bwc_matcher_rehash_shrink(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	struct mlx5hws_bwc_matcher_size *rx_size = &bwc_matcher->rx_size;
+	struct mlx5hws_bwc_matcher_size *tx_size = &bwc_matcher->tx_size;
+
+	/* It is possible that another thread has added a rule.
+	 * Need to check again if we really need rehash/shrink.
+	 */
+	if (atomic_read(&rx_size->num_of_rules) ||
+	    atomic_read(&tx_size->num_of_rules))
+		return 0;
+
+	/* If the current matcher RX/TX size is already at its initial size. */
+	if (rx_size->size_log == MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG &&
+	    tx_size->size_log == MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG)
+		return 0;
+
+	/* Now we've done all the checking - do the shrinking:
+	 *  - reset match RTC size to the initial size
+	 *  - create new matcher
+	 *  - move the rules, which will not do anything as the matcher is empty
+	 *  - destroy the old matcher
+	 */
+
+	rx_size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+	tx_size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+
+	return hws_bwc_matcher_move(bwc_matcher);
+}
+
+static int hws_bwc_rule_cnt_dec_with_shrink(struct mlx5hws_bwc_rule *bwc_rule,
+					    u16 bwc_queue_idx)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mutex *queue_lock; /* Protect the queue */
+	int ret;
+
+	hws_bwc_rule_cnt_dec(bwc_rule);
+
+	if (atomic_read(&bwc_matcher->rx_size.num_of_rules) ||
+	    atomic_read(&bwc_matcher->tx_size.num_of_rules))
+		return 0;
+
+	/* Matcher has no more rules - shrink it to save ICM. */
+
+	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
+	mutex_unlock(queue_lock);
+
+	hws_bwc_lock_all_queues(ctx);
+	ret = hws_bwc_matcher_rehash_shrink(bwc_matcher);
+	hws_bwc_unlock_all_queues(ctx);
+
+	mutex_lock(queue_lock);
+
+	if (unlikely(ret))
+		mlx5hws_err(ctx,
+			    "BWC rule deletion: shrinking empty matcher failed (%d)\n",
+			    ret);
+
+	return ret;
+}
+
 int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
@@ -425,8 +491,8 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
-	hws_bwc_rule_cnt_dec(bwc_rule);
 	hws_bwc_rule_list_remove(bwc_rule);
+	hws_bwc_rule_cnt_dec_with_shrink(bwc_rule, idx);
 
 	mutex_unlock(queue_lock);
 
-- 
2.34.1


