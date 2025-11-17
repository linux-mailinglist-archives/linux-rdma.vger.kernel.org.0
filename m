Return-Path: <linux-rdma+bounces-14568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EEFC664FE
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652204E4047
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F91336EE6;
	Mon, 17 Nov 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9kRD1w1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876972C178E;
	Mon, 17 Nov 2025 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415789; cv=fail; b=YY8sSY9XTLtpHeO6Jp1HrwFfBjXEOJCxkUSHGf8sEZcUhktVybQepgEltkVfJdIiwtX4KY2q8vdb9/gWBY+RNA6SMb9A86DnL4G5Y/LPtda32wQ4DI3QsJgmUKRakaNaK/mv7Qwk1PcB4jmMSJ/NcDGXGNnnzcY6mprDG80c8Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415789; c=relaxed/simple;
	bh=OkNWMBTwQBpKm0X0Tms+CoCOJ/ReinGPhohC7RETALc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmZvc/8fPJ9FHXyy7WXxoxx+i83mi6d7bUUd+1NCUckocWL7p0/UuSTwJ9t1lyoxIIt4AJ3cO+QkJaJf6znU7+uV8RpDC5TOltDoK36A4mrsX9K+TxhTVdZm4TB1GUKITU5SeuDilE3wCsDvvu/0C2NGWvqIN8J0VOB/XEjonh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9kRD1w1; arc=fail smtp.client-ip=52.101.85.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji0JFycW5UQmAhGd5ILPUEcAJR51sjp4WxUS2bqxTuXR7IAPVPp9oEogIvMc3SOWPLOEjdCxFzT4vwJWl2BjsQLuLT9yIwIyxc5OUyYce5FdD1W7KLzDTTUkUU4+0bDVXH8TBuR9CtvMxGv/SmuMBfcAkyxBCyKgiEOopK97QjtEjA6Xj2BjJPkDUj1Z/StDdIJLNZ3H39KloW35EmnitwWz3O5R6rpIQcqYoo/9jNc2tBbcskjV3Tv1E9VSle4JIPRcOSbVHEk+fehfn7T8igzilP6DODL+7hxc43f+zBk9+3kIpLCZ5cjSjpg5L5ulRFRmNPUge4WV9P6PEjfT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pyg2gw5QpQs3djxuy7tGJedam/2PCyfCltUP/ZOeyg=;
 b=fryEHvzNrgAShGt2QO+wHcBCgk/8b61TrnTGgzVs7mf/3peCMfm+LCLxgmzxaoAJq30qqqcOwj1diB4cOSA1cemtdrJ+XBUHuW2IhoFCeTYXOPiN5jz4osCWRutDz47SKMkVhxqMIJoLwnjesOqhsb54yPOVVoOYxwcJZNvO2cLQeq3SCq249jeCYT+/agWx/WWEABzPc0JMJok1FEjUeap7Xl1vcYbBVX7rBQ62pihEx92ryJvGDuEs6uYy7ZpL1/LeSpR1+VzJSvaExq5fYszPtBWaQTtgoHuN4xwuXw7fGUeA2bCXEgJkDo/uUsNX9r2Nk1qZFPdqadYWh57cAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pyg2gw5QpQs3djxuy7tGJedam/2PCyfCltUP/ZOeyg=;
 b=t9kRD1w1mpOefOyJRobguz8zaEf8O7YkMQ6elLei6f6FWtvsIhtXd+037XUA0AmsJHiQNhfNLrogm8mQ2ZRNraxfgds2EApIIMLgPMtIkz3TXuRtnDjrytD5yNps7Ybf426kw8AEQ43IzL82QbRTWgXYdoIjaup3p0NO6X51h3SHeiw/ZT2qAtih5WRIHxYdSE9eBX8HT58U66Ema/uXF17uZmTZex46mCW/iUvk6ZfvrKaimnXFGYHgPdy/a2qoaU+n9gxKPcAi/Rg5QLtBK3lEyXFVCcB+FHZrPdzzATup8LuD7Rtx3uLwh2viqU604n2ZkeDJAbk8vVdkg7DP6Q==
Received: from CH2PR14CA0040.namprd14.prod.outlook.com (2603:10b6:610:56::20)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 21:43:00 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::c8) by CH2PR14CA0040.outlook.office365.com
 (2603:10b6:610:56::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:43:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:41 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 13:42:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 2/5] net/mlx5e: Recover SQ on excessive PTP TX timestamp delta
Date: Mon, 17 Nov 2025 23:42:06 +0200
Message-ID: <1763415729-1238421-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 94086160-0cc1-4bad-ff00-08de262247b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O5Lpq4bFS7BUb1nUU5bQ/F1WDInfuQ4PuIZAjSyUAsSkJNqu0/Q5bwzYFrG1?=
 =?us-ascii?Q?qubdoHfXDP3+RwGxmGVDF/Q/NBshh7mR4U+qnm4h99FfsPSEnszPzLn53XIh?=
 =?us-ascii?Q?YzHnCWGJfZL1eaqBhq/a7940qpXFg868/yk4jhn98GrY6FLexQlzhNDLVpr8?=
 =?us-ascii?Q?hkqCE6kOMCvsjwSOJ/nJAnypfE++kOmu0h4x+qv8jmkqfG/R213PFm3bW+fR?=
 =?us-ascii?Q?idVmFUccXZGNR+UOiZZDYkHbtvoIFBkc2eVo43Od3HmRVW6HKffU8qk4tKJB?=
 =?us-ascii?Q?QZuAsLPKt+V4Ps23qtHr/IUSwR9CQCtAhgyBu4KGXQUtG67fgS3RLpncneM+?=
 =?us-ascii?Q?csEJWhzPRWhW+q9e4M6enlzUzVZ56JNaDbdPW+1wzrx4rCrDPkTg8tCGFFkk?=
 =?us-ascii?Q?S6CBjjEcC5aE15JPy01BTh+ge1t8YgRCf+YN9LzABgNGbSZaSYu/NThzANaq?=
 =?us-ascii?Q?KeTBUQL9Ssa0OXxz3ZSuvqMv07+2+tEFSbM5WsVV/Sm5gI5GQWMF7bQBJ74N?=
 =?us-ascii?Q?yX3cKaESlJNQa2a/gkqjFMcksicZtZom2CHQxIfsWhyWOdu6rUPqrkNXNBpC?=
 =?us-ascii?Q?7DGw8XVQxHLLLZCjLwfvTGwPjn7BwuoLwMzlhr4pMn0WcqTtfVTKKDo6gKAw?=
 =?us-ascii?Q?e0a6EiGckIpHh1mA3CbTC3lMmq6xNY4UGUH5C5EswhfK4nCUeuUbVEBfafk6?=
 =?us-ascii?Q?ccptMh9EjpxD1wHPZpWRBPizmdAydiyZcQerLapWVrCEa8F7xOBuk1XCJ+2D?=
 =?us-ascii?Q?z9ZNrtzqahuRa2T7V6rMvMnLLaVU+AEBG9ya4U7mWZ5Jjha44LwRVJoFGkIa?=
 =?us-ascii?Q?hB5woLPicWSdO32VMP+TIpzwE1VTxN1A2beByRhJ9JgMIJnCGRsUQThwYk/o?=
 =?us-ascii?Q?moKKYZSP8lyRRvrVN/Mz++WsTuEQftpWQvndV2kl0XZZvWTz95ie2QJaWUTr?=
 =?us-ascii?Q?5s1ZEUk3rDBXIk42L0kA0ssrfMMuzEZgRpmPLgRWxeXNsl2NB3Q74ZmOaOW1?=
 =?us-ascii?Q?uWVMArjh1VV+mGfh1E54ScxA6qUSX+VLDfpt0bWhQc6JkDW0s2/rO5AP4Sda?=
 =?us-ascii?Q?tR7Mf/47XGqy49zgDP8+nKarn0dJTHrNg4EkH/94a8Mo+b6vm6d/jvKVNKuL?=
 =?us-ascii?Q?bg/Kfu+5cgHQzGFdVR6wt+q5SD2v2Y2xHCpe2auCnSpCaEG85u/RxzD1XnXQ?=
 =?us-ascii?Q?aqbGIS5XzJkeCvFaD4jXU9QFTfmdfM/JUS3neX/wJthLrQE+X5Sbev099n13?=
 =?us-ascii?Q?1XUo9ckXOMG1NwHhGKNK2DQ5hap8aQLB/I8cPkp2Xbn5q5bAinfz6vr6F3j/?=
 =?us-ascii?Q?ra5mzJdH5qRuUCQOzkP3Gzb+w0vpB1kLtW7iR4lp3j6FG5QiwPV6dXaMSldN?=
 =?us-ascii?Q?4nelyfMidqFJkgEQzrINGZrpzqEI5UcmaecY7ZoTMthihuC7I/aSveVXxw36?=
 =?us-ascii?Q?EyvOE597NtjYOeYVTv5liG9QDe1ODOe+oXaDjc6mUBhNQbd3Mu/ktNNL9Ris?=
 =?us-ascii?Q?yQSKEe3u4cIbN6ZGW4JbJhg9BRNqtp37oi/jupxnzGM40mtlpVyUMx0KMtRn?=
 =?us-ascii?Q?78aBKxrXFYumztY2wyc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:43:00.5272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94086160-0cc1-4bad-ff00-08de262247b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508

From: Carolina Jubran <cjubran@nvidia.com>

Extend the TX timestamp handler to recover the SQ when the difference
between the port and CQE TX timestamps is abnormally large.

The current logic aborts timestamp delivery if the delta exceeds
1/128 seconds, which matches the maximum expected packet interval in
ptp4l. A larger delta makes the timestamps unreliable.

This change adds recovery if the delta exceeds 0.5 seconds. Such a
large gap should not occur in normal operation and indicates that
firmware is stuck or metadata tracking is out of sync, leading to stale
or mismatched timestamps. Recovering the SQ ensures forward progress
and avoids silently dropping invalid timestamps.

The timestamp handler now takes mlx5e_ptpsq directly to access both CQ
stats and the recovery state.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 21 +++++++++++++------
 .../net/ethernet/mellanox/mlx5/core/en/ptp.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 12e10feb30f0..424f8a2728a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -82,7 +82,7 @@ static struct mlx5e_skb_cb_hwtstamp *mlx5e_skb_cb_get_hwts(struct sk_buff *skb)
 }
 
 static void mlx5e_skb_cb_hwtstamp_tx(struct sk_buff *skb,
-				     struct mlx5e_ptp_cq_stats *cq_stats)
+				     struct mlx5e_ptpsq *ptpsq)
 {
 	struct skb_shared_hwtstamps hwts = {};
 	ktime_t diff;
@@ -92,8 +92,17 @@ static void mlx5e_skb_cb_hwtstamp_tx(struct sk_buff *skb,
 
 	/* Maximal allowed diff is 1 / 128 second */
 	if (diff > (NSEC_PER_SEC >> 7)) {
-		cq_stats->abort++;
-		cq_stats->abort_abs_diff_ns += diff;
+		struct mlx5e_txqsq *sq = &ptpsq->txqsq;
+
+		ptpsq->cq_stats->abort++;
+		ptpsq->cq_stats->abort_abs_diff_ns += diff;
+		if (diff > (NSEC_PER_SEC >> 1) &&
+		    !test_and_set_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state)) {
+			netdev_warn(sq->channel->netdev,
+				    "PTP TX timestamp difference between CQE and port exceeds threshold: %lld ns, recovering SQ %u\n",
+				    (s64)diff, sq->sqn);
+			queue_work(sq->priv->wq, &ptpsq->report_unhealthy_work);
+		}
 		return;
 	}
 
@@ -103,7 +112,7 @@ static void mlx5e_skb_cb_hwtstamp_tx(struct sk_buff *skb,
 
 void mlx5e_skb_cb_hwtstamp_handler(struct sk_buff *skb, int hwtstamp_type,
 				   ktime_t hwtstamp,
-				   struct mlx5e_ptp_cq_stats *cq_stats)
+				   struct mlx5e_ptpsq *ptpsq)
 {
 	switch (hwtstamp_type) {
 	case (MLX5E_SKB_CB_CQE_HWTSTAMP):
@@ -121,7 +130,7 @@ void mlx5e_skb_cb_hwtstamp_handler(struct sk_buff *skb, int hwtstamp_type,
 	    !mlx5e_skb_cb_get_hwts(skb)->port_hwtstamp)
 		return;
 
-	mlx5e_skb_cb_hwtstamp_tx(skb, cq_stats);
+	mlx5e_skb_cb_hwtstamp_tx(skb, ptpsq);
 	memset(skb->cb, 0, sizeof(struct mlx5e_skb_cb_hwtstamp));
 }
 
@@ -209,7 +218,7 @@ static void mlx5e_ptp_handle_ts_cqe(struct mlx5e_ptpsq *ptpsq,
 
 	hwtstamp = mlx5e_cqe_ts_to_ns(sq->ptp_cyc2time, sq->clock, get_cqe_ts(cqe));
 	mlx5e_skb_cb_hwtstamp_handler(skb, MLX5E_SKB_CB_PORT_HWTSTAMP,
-				      hwtstamp, ptpsq->cq_stats);
+				      hwtstamp, ptpsq);
 	ptpsq->cq_stats->cqe++;
 
 	mlx5e_ptpsq_mark_ts_cqes_undelivered(ptpsq, hwtstamp);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 1c0e0a86a9ac..2a457a2ed707 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -147,7 +147,7 @@ enum {
 
 void mlx5e_skb_cb_hwtstamp_handler(struct sk_buff *skb, int hwtstamp_type,
 				   ktime_t hwtstamp,
-				   struct mlx5e_ptp_cq_stats *cq_stats);
+				   struct mlx5e_ptpsq *ptpsq);
 
 void mlx5e_skb_cb_hwtstamp_init(struct sk_buff *skb);
 #endif /* __MLX5_EN_PTP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 2702b3885f06..14884b9ea7f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -755,7 +755,7 @@ static void mlx5e_consume_skb(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		hwts.hwtstamp = mlx5e_cqe_ts_to_ns(sq->ptp_cyc2time, sq->clock, ts);
 		if (sq->ptpsq) {
 			mlx5e_skb_cb_hwtstamp_handler(skb, MLX5E_SKB_CB_CQE_HWTSTAMP,
-						      hwts.hwtstamp, sq->ptpsq->cq_stats);
+						      hwts.hwtstamp, sq->ptpsq);
 		} else {
 			skb_tstamp_tx(skb, &hwts);
 			sq->stats->timestamps++;
-- 
2.31.1


