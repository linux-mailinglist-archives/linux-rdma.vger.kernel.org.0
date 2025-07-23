Return-Path: <linux-rdma+bounces-12418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC1B0EC3D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1C93A0256
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A6279DA3;
	Wed, 23 Jul 2025 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bxs0bVrL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215062797A9;
	Wed, 23 Jul 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256749; cv=fail; b=bwo/8F+x1/Oq5slEg+sLq6jtXUYAn370gsBHKkn0fO1V7Fefz/tbhx0Yv1bFy/vp8BVpR8J5cXIF9YZIlBNJZuoE48NzAFH4LXYUdYhomOQKBmLnL087yd4jMboVDmC5YlLxpHXGoIWEoErsy+bPgshP8fIh40/ZHbnwLbSFY+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256749; c=relaxed/simple;
	bh=4a9bVj/kt3suouBpGyEeflJKjnWoU7Nbn7aEKSClViw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsr/OEOLTwRw9UBVfDBgDnU7EMNuenfSEQy1nbEC5iWt5sFYt0F2MDnrLDssVNwnUKP69W5mEjjOY/esWJu4+/jeXE5SMa29a1qDuq6SMwADB7oN76w9jte6S+FGvQHlchI/VD0L/wpTRRGoN+IVgy6rS0u680nx/MbfrB9tkIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bxs0bVrL; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRp3kI+lYa5nGxyIN7/UVPDlP0+ZQd8d50fqp4MW8IdqRXu55cDg18CBjTIK6y0yeDE77HrZedtnfX/8Du1VRf6Z+0GNV6onHeFKkiDTUJ6+T6yY7Vawp6q7SDD58kYjOjSXAo9wY5LB7yvzWqOkUY9FHQRzXL8Q3EA+RQwj795b6YlKwzZKA6lVrxMrH79I3eKQH6DU0EOMDvTA1e9wqgToZicoobkzofyV6TUSMuvQHfIJUE1xQx8bOVO0N8on/7HxLoxfOB63Iov7USkIpWocEpBuvKia+bD91dOYoV20pHLhaK5YM2ofeBlUvaeTnqUJmz7qtnEp9LZ+yt8cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3nZSGE/UGmwRK+fmj52d0IiFlVW1cmjOzIfhxu7GMU=;
 b=cutp3kPuHa7mves6u87rv22rzGcFsLBU1CLmXAFCTPsivAI2WxDUpY80AG++sGyLzZ7/CB2YbLrCUq4Wtj/BIZ2pUNHnrs/qrKUeErgZ4/30jmFpG8v2DezklYYX94x9KWBKkiysD/vB0ySXv/hY4eD7g4KXAuuaZC21KGorKpIcHJCWWgbwBOCz0kMKdTZ1jHrObXUYb1huPU38Bl8c2HdCfpKqT3rXhKD6eJZsII6BYhoYBnvtm3T6mig1k9mi7X8GneckOmjaCDWpvzeAThNScdOLAktyyhCnaLcLLBXaQXGLuoLoXBct3GF1CLNUQznRX254IOnj/4vCPMU/PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3nZSGE/UGmwRK+fmj52d0IiFlVW1cmjOzIfhxu7GMU=;
 b=bxs0bVrL1e9XRFDn7jVuiy0/Ri56VQKbt+XTw+u9svfxQwzangNEXignzgKVjE+5fwBi4kLR5qY7jGtWTERFkvqZAaHHFz0JtZU74VQ2FWk8LRIVNopxrC/cOv0u9Cj3AEmUWVqKRmaLDR/QpEVtpLCo0bjuWEVY2CJlI/KfR8o+ieX08bNX57qsj2E5qaktRdwvjhIjD2ZOukZcPkZpDb7Tg/weQbjhzF51OqwzFSd2kMYQ2o9vObNw7pHSBTsvw8jrSvhbn1dKF437rpj3xmDkSgEvDUyRW/gHbk7mfXeJQqVxrYr4RuCjr+HX+Nn8t/CR3VrH8cvzK9Uo/vWcNA==
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 07:45:43 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::5a) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 07:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:45:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 00:45:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 00:45:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Jul 2025 00:45:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Fix potential deadlock by deferring RX timeout recovery
Date: Wed, 23 Jul 2025 10:44:32 +0300
Message-ID: <1753256672-337784-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
References: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 81eff920-da51-4406-16a2-08ddc9bced27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tE/grJfRn9pEx8zvhhkTmgR1hMi4mLDwE6ooamkCzei20Qi/IaDcyVjIg1eZ?=
 =?us-ascii?Q?+gzVxTGqKw8i21TI/hgcEPLAC9O40FRhI9+NUOX9HDj+mnSXl/7AXrZy6o67?=
 =?us-ascii?Q?px7rfqHJHO0U0hhkY/a1lT+5qLNjnsgYk5uT2CBZKWqFQJTN2q+6HE2qqfZo?=
 =?us-ascii?Q?1eicU2tccOy0kIQDJnomR81XJLwWmTVCGGeytpmGtE0FSIWhnQSweIRwJlJK?=
 =?us-ascii?Q?Yv1urwnEQB+G0bSVfwrDCgOCnpF5gielzDwq/xHOTDt50FTS99AZSnSppueQ?=
 =?us-ascii?Q?1YAUCLt+0bhVtrjzZx0e+KapMLa9bpeugFyWJ/6W4pewGvzwTr3oUHBMunwp?=
 =?us-ascii?Q?GhBY2hnZOe0aHenXAdM6T7zKk7UvR85gU6aFQpMJDxUGH36scMET288I7z36?=
 =?us-ascii?Q?Q7qqae9Y5xRYlQyyRVoKnAQMFjz3y6MQqbNQj8Kxnmz87MfvZVbGdWkp/aXp?=
 =?us-ascii?Q?kZvfW1b3qceuRccMcwJWvXpRlJWvxy1THTYYhUodiqYrDXHst4fYoyDqkNaL?=
 =?us-ascii?Q?g6H07hl5+dtRay1c8wkqxT3GvzalW1V5dZjkIvQyFpjrD0x937WyRXcGPHxI?=
 =?us-ascii?Q?/ySQ0zkSqZ5PyFjD2TjNWNNwyZ7Y+rXTpmekGOMZavtWnNxvmLsYvjUtFvRd?=
 =?us-ascii?Q?vb8b7aFUHgyZTaFuc6ifnNXOrPYRmIv0teNGz3HaS3TaqZoQPvA3i610uy5M?=
 =?us-ascii?Q?O0mAEFEwRMDbVWCgeL7MYABRLdHm/917hD3Wpk6N1WkMSjLMxS+tD5KviTC2?=
 =?us-ascii?Q?lEWrlxq4yUcMNI75CFIhGZSchKkY75mDsADthvJhLusp/WvA3v9QgpPYanJn?=
 =?us-ascii?Q?/uYlp3uqQ40pwdIDRALWVOJfSEsEGqgkWtkYXoy2PFHI/75xH6V0eKyMMxh1?=
 =?us-ascii?Q?Ro8tE5n+q5H3r4LpxxN6Ew2s2G0pECoZaiQ9x1kLRr70IAV6HIifPRBN+3mQ?=
 =?us-ascii?Q?pRMK3Im7H67h2ccqFIr2cMt0yqRTd7G/RxwqxA0IED6trQF/nJykzl7CBc02?=
 =?us-ascii?Q?IGHARLaqyijjlIYHZ4J46DCnNk6boSQL5GYMPMGjm6aQCRtx/dhflT79Ics/?=
 =?us-ascii?Q?rAZUvUP/lWexz5ah/H5A4ALrrz0SNNydJRAA1T5+K0qTH/5ba1UDvodsZGUu?=
 =?us-ascii?Q?dPp/hTFvyeWWzR4Y8TvJvWb83YlFye9uWDBu3/Jq4tWDyZp3/4YocFwuhQPM?=
 =?us-ascii?Q?JD43zG6fwONV4TNBZXPmguN5MIbzoL++/H8X0WVg7rIwIVjyv1b+Amz6loOv?=
 =?us-ascii?Q?WfxpCno6xzh0/idakJpdTl64BjhP9fyS9rkEKnODMk4xtVcRgNZa/QP1CTYE?=
 =?us-ascii?Q?Hj+NiRxJ8qMVFqdPGtSZafC2HZqhHt5QWbqHbLK+ZJZpRZRTT7KsKoHN8IIR?=
 =?us-ascii?Q?drRPyifwgbRVo7IB9tS6vb4SXL3UKs4fvwDE/oseAXjViXvdht/AY5CFQJH9?=
 =?us-ascii?Q?oGlYJtz94hlLi6HDaOTXf9+SPB12BPFWdrlyOiX9CwWsx/EzQ+1yhHX1NrXk?=
 =?us-ascii?Q?u71dTkFZ/K2uOSH+yp0pPog0bDtqzjDM77rR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:45:42.5509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eff920-da51-4406-16a2-08ddc9bced27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738

From: Shahar Shitrit <shshitrit@nvidia.com>

mlx5e_reporter_rx_timeout() is currently invoked synchronously
in the driver's open error flow. This causes the thread holding
priv->state_lock to attempt acquiring the devlink lock, which
can result in a circular dependency with other devlink operations.

For example:

- Devlink health diagnose flow:
  - __devlink_nl_pre_doit() acquires the devlink lock.
  - devlink_nl_health_reporter_diagnose_doit() invokes the
    driver's diagnose callback.
  - mlx5e_rx_reporter_diagnose() then attempts to acquire
    priv->state_lock.

- Driver open flow:
  - mlx5e_open() acquires priv->state_lock.
  - If an error occurs, devlink_health_reporter may be called,
    attempting to acquire the devlink lock.

To prevent this circular locking scenario, defer the RX timeout
recovery by scheduling it via a workqueue. This ensures that the
recovery work acquires locks in a consistent order: first the
devlink lock, then priv->state_lock.

Additionally, make the recovery work acquire the netdev instance
lock to safely synchronize with the open/close channel flows,
similar to mlx5e_tx_timeout_work. Repeatedly attempt to acquire
the netdev instance lock until it is taken or the target RQ is no
longer active, as indicated by the MLX5E_STATE_CHANNELS_ACTIVE bit.

Fixes: 32c57fb26863 ("net/mlx5e: Report and recover from rx timeout")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../mellanox/mlx5/core/en/reporter_rx.c       |  7 +++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 26 ++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5b0d03b3efe8..48bcd6813aff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -728,6 +728,7 @@ struct mlx5e_rq {
 	struct xsk_buff_pool  *xsk_pool;
 
 	struct work_struct     recover_work;
+	struct work_struct     rx_timeout_work;
 
 	/* control */
 	struct mlx5_wq_ctrl    wq_ctrl;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e75759533ae0..16c44d628eda 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -170,16 +170,23 @@ static int mlx5e_rx_reporter_err_rq_cqe_recover(void *ctx)
 static int mlx5e_rx_reporter_timeout_recover(void *ctx)
 {
 	struct mlx5_eq_comp *eq;
+	struct mlx5e_priv *priv;
 	struct mlx5e_rq *rq;
 	int err;
 
 	rq = ctx;
+	priv = rq->priv;
+
+	mutex_lock(&priv->state_lock);
+
 	eq = rq->cq.mcq.eq;
 
 	err = mlx5e_health_channel_eq_recover(rq->netdev, eq, rq->cq.ch_stats);
 	if (err && rq->icosq)
 		clear_bit(MLX5E_SQ_STATE_ENABLED, &rq->icosq->state);
 
+	mutex_unlock(&priv->state_lock);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ea822c69d137..16d818943487 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -707,6 +707,27 @@ static void mlx5e_rq_err_cqe_work(struct work_struct *recover_work)
 	mlx5e_reporter_rq_cqe_err(rq);
 }
 
+static void mlx5e_rq_timeout_work(struct work_struct *timeout_work)
+{
+	struct mlx5e_rq *rq = container_of(timeout_work,
+					   struct mlx5e_rq,
+					   rx_timeout_work);
+
+	/* Acquire netdev instance lock to synchronize with channel close and
+	 * reopen flows. Either successfully obtain the lock, or detect that
+	 * channels are closing for another reason, making this work no longer
+	 * necessary.
+	 */
+	while (!netdev_trylock(rq->netdev)) {
+		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
+			return;
+		msleep(20);
+	}
+
+	mlx5e_reporter_rx_timeout(rq);
+	netdev_unlock(rq->netdev);
+}
+
 static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
 {
 	rq->wqe_overflow.page = alloc_page(GFP_KERNEL);
@@ -830,6 +851,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 	rqp->wq.db_numa_node = node;
 	INIT_WORK(&rq->recover_work, mlx5e_rq_err_cqe_work);
+	INIT_WORK(&rq->rx_timeout_work, mlx5e_rq_timeout_work);
 
 	if (params->xdp_prog)
 		bpf_prog_inc(params->xdp_prog);
@@ -1204,7 +1226,8 @@ int mlx5e_wait_for_min_rx_wqes(struct mlx5e_rq *rq, int wait_time)
 	netdev_warn(rq->netdev, "Failed to get min RX wqes on Channel[%d] RQN[0x%x] wq cur_sz(%d) min_rx_wqes(%d)\n",
 		    rq->ix, rq->rqn, mlx5e_rqwq_get_cur_sz(rq), min_wqes);
 
-	mlx5e_reporter_rx_timeout(rq);
+	queue_work(rq->priv->wq, &rq->rx_timeout_work);
+
 	return -ETIMEDOUT;
 }
 
@@ -1375,6 +1398,7 @@ void mlx5e_close_rq(struct mlx5e_rq *rq)
 	if (rq->dim)
 		cancel_work_sync(&rq->dim->work);
 	cancel_work_sync(&rq->recover_work);
+	cancel_work_sync(&rq->rx_timeout_work);
 	mlx5e_destroy_rq(rq);
 	mlx5e_free_rx_descs(rq);
 	mlx5e_free_rq(rq);
-- 
2.31.1


