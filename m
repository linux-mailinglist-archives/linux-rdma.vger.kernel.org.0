Return-Path: <linux-rdma+bounces-11983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E34AFD983
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A6F1AA6C83
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3FD246776;
	Tue,  8 Jul 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YVutNyZm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA42459FE;
	Tue,  8 Jul 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009424; cv=fail; b=DOqRalhpuaBQgmQCA1aO9F3GIEdF02tUL51kHMTqiUaF5YzfSafgvinvLMabyKzwH2iahhPBWah+Qw6EVkCDRtqHxSnDNQ2RgysALXz9nfh8g7pIWvY/aigWpVqPFo9d9EhaYfSxY5aQt6wweiQfJ3QCLsBaP/1Ce6PrZ4GlU5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009424; c=relaxed/simple;
	bh=dIKX6RhWt0WefI3xH1Sk6HcFysiMognnyKyjlBJwUKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoXWQR2oQCeWC/UJL0YW57CliOto/0ZFRQeKUsJRiUruMOrnwdsupAiE4JdrvI+WiMANEx2Y1bUBU06c69IAjJ+5EmCaokveI85Z8++Rw8TsNkXzaafSgu6gGCoKfCtL02V0iJLwEc/FOeNGN4mMYp6OF/opaISKNUvfaLon8g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YVutNyZm; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMe5ZH96PhEAKZ1MiGL1wDEMEONZMAfTWegg66Fm4Eiugb/YLRb2m+BS28+P5EXKeufRKAQArubvv6eNw0QoCWY6ygJaKv7dSAnWnyLQXI6Ytylpmdvz7jLw14KCLGVC8G7dzID+UWNjnyIfMZzNShzI/XoeDHGRJIO3fcUOB3y/VTj2Ow8zkGUxsxEKD1m5LNjYfYbTQQdE56rZZuos+i9QxK3KMaZiWO1dVMzra1qDyfVHCFuXDvsalxnF897geLpxk586CNvRFKTOccMgedIhXJ9ZYpBjtmTBD7/XSXweAhBse4WYYSJZQKKDBml7ti8nMCjMJTAScbpGNCdIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkrQKD/1G6qATt958DAzXTOPrksuF5cDyV17xju+P4Y=;
 b=afyL56NRrtNhvkGl2I88v4UW2i5BEbu2seYuWGYlrGmxk0N4CGSNDw6JH+RDiX4J+F7H52Nz4IVQ5jZvFpeGxZlviVc/cDY7NrkbKLFOim679L8okdzVpt0nNe404rlO/wNa81ExrCQD96vIn3H/rtK4C+RZGO5WwfFyAEBNZArsMb2XKq+aSzd9V6w/GngHp9zZEL4ulRpXzmJwJHX4AXvL10Qt9XZPljMBFZxcp2Fm4OXlSikMDDz6gpNNSHQfrLl0YAugjCrYJF57lx/eo5oZA+hJ4a3REMkt7j54hQgEVBgWVWWz2yozqhQqi35p84A0xtnrwrPot4uNh6HyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkrQKD/1G6qATt958DAzXTOPrksuF5cDyV17xju+P4Y=;
 b=YVutNyZm52g9AoLBHtCmxddBBptp27T+rso4bVlKt8MDE1zVaFxC487Xuppu4jevlpQ+zJvKnWtlKinm9ijXqxNDHvjUUmwAqF1zmKIDU5nk9jMoe+UFz8CYRBfqAfy5qWcqricEWjbbH7YWt8jbXTImrqHiEpvIFD0wOwOfDUBGFEdrPAm+ttqnGJ1c4A1eHyFhHIOiJkUfdoy3KrJ45yYW/+1z6rgj9T3KcLgW0YeueBEmzOtWVp9Jiu8qOEoHP2Lm1lTIrH/H+bvqdPAuME6O6CUcuUwUSPxFaOVJRwZvcsbLo5NxhaHqcjxS2bzYcg53JbCcyrgdmaxopDo1gA==
Received: from PH7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::17)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 8 Jul
 2025 21:16:57 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::87) by PH7P222CA0012.outlook.office365.com
 (2603:10b6:510:33a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 21:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 21:16:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:16:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 14:16:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:16:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5e: Remove unused VLAN insertion logic in TX path
Date: Wed, 9 Jul 2025 00:16:23 +0300
Message-ID: <1752009387-13300-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: a05d9993-bd63-48ef-10b6-08ddbe64c52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKyVyruuOwClxdqelatpbXVHhgd41pKaqAU2Yh4zQ7WQgUXdIXvFbyF5xOqi?=
 =?us-ascii?Q?9At7LL6bVhSt4KOW0nA4KkqDHGTJ6I28Htjqk5gYUwk2HwmC5tLXL2Y8Qn9C?=
 =?us-ascii?Q?kas74xTwIHvxtDqv3l1qJaUAtQSATWXgthPi+jbCzWZKuV5KcYzG68X7XKN/?=
 =?us-ascii?Q?EVua6t0GPxlmW2l2NcPE9Ri2Gq/i0j/srhwcMpOcpgQMnX6u3qhnYZ0APuIz?=
 =?us-ascii?Q?qmr8GzyyIiFD5rLevbdJJNQBGcgQNjrr3u4aUMHk1kPCkRxPTInRYgdIW0da?=
 =?us-ascii?Q?R/2Y81uGZqOMH/p6ji45dEUtwkJMnGi/BmQwafPVVPe4+KzalnWpsByn9WOO?=
 =?us-ascii?Q?RxqpejujtXmHYh91Us5tPwjTm9C4SnpgdDDyyZ79/XP6GNKySDGf8TLrDvTT?=
 =?us-ascii?Q?qSljaYleP8fyyjFahA7PnK7vjcWpnFVIa1tl6scUq+b6uoqKuyGZNx/L1p9Y?=
 =?us-ascii?Q?SbryxvfIcIJHanbFBYKMLQDpG1WgXC44i86qWqaa79CeSoesIHAaRSzcqSiI?=
 =?us-ascii?Q?zxw2KOz4P99BAgAUaNk5SztjydmWq957LvKE8gsMLfRnT8QgxPA4HvHi/chF?=
 =?us-ascii?Q?8HIB3UWgpbytHlOW9m+e3bNTQhy3ayv/OKCWhVmzbh6cCBSJaWMxzJM9aEWc?=
 =?us-ascii?Q?GkLRLC/pCDVkG7/hlbIUmICjpe5UnncYtLkq9bmU6bQZXOVKBgWSFjy2E90e?=
 =?us-ascii?Q?KAPELj9K1by/g+HK+RNMUa0EOpvKnyHt6aIOSAG4mQGTwhYifGW4CI4bPxTo?=
 =?us-ascii?Q?3m08laH5PQDw2HvcuqK4PpR/7i7Jcav1JvUwFhwd88S57uyyJdXYkbYFoeYU?=
 =?us-ascii?Q?lFls7smi0ie1v+HS2ATo+KxGH0/Wz2xfkhKdVCi6Ba05BzaA4T6mGSLexQEw?=
 =?us-ascii?Q?k7iKkTmB9tstKSbnf00bT8c5VbfiXPa+rEKTeAO8mi+uNFJG3aerAvnSXLeC?=
 =?us-ascii?Q?waBRMgrzjc7aBk3zZS7KoQh6rIaxrpPfGIUV+HYCKrwCTL+Fua6mq/AarPpV?=
 =?us-ascii?Q?9GKqz03bzrO2bLfoX1h8nvp9BR0DiOBSBt/RRHB/8a1WWkIaHW+ckbHaLmhf?=
 =?us-ascii?Q?u7IRX/0rqOGUzNppVWpkrZx5hU+E9btYQhPKEWV1/DbP2ph5Y7vJPnd9yvIx?=
 =?us-ascii?Q?zX0039z/gZL+Xa6K7pNrZZ3WJscg6ZuuVs60D4WL50qSq0U/tHHO47TfupEy?=
 =?us-ascii?Q?A8MoSQ0Sx4bgeykCs/c8kMStBxX6Ai5XalQGPUboFf4jbB/omz5y2uy+KFQL?=
 =?us-ascii?Q?DJah2KmxpfkenMGoXPN51J7m5djCvkcSeQ3oPsHGIJQAC1N0g6BKSTjhetr9?=
 =?us-ascii?Q?JCpgZHMViMH/sHACapaDl0kq16FeksAAdfm7VEkr4OwEuIK+gOH6oO5L4Rqi?=
 =?us-ascii?Q?qe+R6cbNtSaUpGoz5K0VLszsaxwzd+DB0dvuX4MJCf1PmoFsiCuKQC9oiLzl?=
 =?us-ascii?Q?27wsorqnpT5rM0J+ql4HInuyjVO9zyZWWBmUJnGwjlbQjC4ZbL3f673uPJuI?=
 =?us-ascii?Q?zBN8bt/RLGPqBqH/vM+wcFPxeA7mee6UKu5A?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:16:56.9150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d9993-bd63-48ef-10b6-08ddbe64c52e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

From: Carolina Jubran <cjubran@nvidia.com>

The VLAN insertion capability (`wqe_vlan_insert`) was never enabled on
all mlx5 devices. When VLAN TX offload is advertised but this
capability is not supported, the driver uses inline headers to insert
the VLAN tag.

To support this, the driver used to set the
`MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE` bit to enforce L2 inline mode
when `wqe_vlan_insert` was not supported. Since the capability is
disabled on all devices, this logic was always active, and the SQ flag
has become redundant. L2 inline is enforced unconditionally for
VLAN-tagged packets.

The `skb_vlan_tag_present()` check in the else-if block of
`mlx5e_sq_xmit_wqe()` is never true by this point in the TX flow,
as the VLAN tag has already been inserted by the driver using inline
headers. As a result, this code is never executed.

Remove the redundant SQ state, dead VLAN insertion code block, and
related logic.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c         | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 2 --
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c          | 9 +--------
 5 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 65a73913b9a2..64e69e616b1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -383,7 +383,6 @@ enum {
 	MLX5E_SQ_STATE_RECOVERING,
 	MLX5E_SQ_STATE_IPSEC,
 	MLX5E_SQ_STATE_DIM,
-	MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE,
 	MLX5E_SQ_STATE_PENDING_XSK_TX,
 	MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
 	MLX5E_NUM_SQ_STATES, /* Must be kept last */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 5d0014129a7e..391b4e9c9dc4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -340,8 +340,6 @@ static int mlx5e_ptp_alloc_txqsq(struct mlx5e_ptp *c, int txq_ix,
 	sq->stats     = &c->priv->ptp_stats.sq[tc];
 	sq->ptpsq     = ptpsq;
 	INIT_WORK(&sq->recover_work, mlx5e_tx_err_cqe_work);
-	if (!MLX5_CAP_ETH(mdev, wqe_vlan_insert))
-		set_bit(MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE, &sq->state);
 	sq->stop_room = param->stop_room;
 	sq->ptp_cyc2time = mlx5_sq_ts_translator(mdev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index c3bda4612fa9..bd96988e102c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -13,7 +13,6 @@ static const char * const sq_sw_state_type_name[] = {
 	[MLX5E_SQ_STATE_RECOVERING] = "recovering",
 	[MLX5E_SQ_STATE_IPSEC] = "ipsec",
 	[MLX5E_SQ_STATE_DIM] = "dim",
-	[MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE] = "vlan_need_l2_inline",
 	[MLX5E_SQ_STATE_PENDING_XSK_TX] = "pending_xsk_tx",
 	[MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC] = "pending_tls_rx_resync",
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e8e5b347f9b2..fee323ade522 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1677,8 +1677,6 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu);
 	sq->max_sq_mpw_wqebbs = mlx5e_get_max_sq_aligned_wqebbs(mdev);
 	INIT_WORK(&sq->recover_work, mlx5e_tx_err_cqe_work);
-	if (!MLX5_CAP_ETH(mdev, wqe_vlan_insert))
-		set_bit(MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE, &sq->state);
 	if (mlx5_ipsec_device_caps(c->priv->mdev))
 		set_bit(MLX5E_SQ_STATE_IPSEC, &sq->state);
 	if (param->is_mpw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 55a8629f0792..e6a301ba3254 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -256,8 +256,7 @@ mlx5e_tx_wqe_inline_mode(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 	mode = sq->min_inline_mode;
 
-	if (skb_vlan_tag_present(skb) &&
-	    test_bit(MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE, &sq->state))
+	if (skb_vlan_tag_present(skb))
 		mode = max_t(u8, MLX5_INLINE_MODE_L2, mode);
 
 	return mode;
@@ -483,12 +482,6 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		}
 		eseg->inline_hdr.sz |= cpu_to_be16(ihs);
 		dseg += wqe_attr->ds_cnt_inl;
-	} else if (skb_vlan_tag_present(skb)) {
-		eseg->insert.type = cpu_to_be16(MLX5_ETH_WQE_INSERT_VLAN);
-		if (skb->vlan_proto == cpu_to_be16(ETH_P_8021AD))
-			eseg->insert.type |= cpu_to_be16(MLX5_ETH_WQE_SVLAN);
-		eseg->insert.vlan_tci = cpu_to_be16(skb_vlan_tag_get(skb));
-		stats->added_vlan_packets++;
 	}
 
 	dseg += wqe_attr->ds_cnt_ids;
-- 
2.31.1


