Return-Path: <linux-rdma+bounces-15544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73AD1CF37
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA79930C8054
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 07:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C932F5306;
	Wed, 14 Jan 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bRuNUyEK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8737A4B7;
	Wed, 14 Jan 2026 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376941; cv=fail; b=l9Lok4+1vOqHnCeW96wYiOCvseTy6Ib0UycPhO69zfHg+dLHZilsfzwhY3N0FcT/d04EKWQ6IBF12KWKnQJ5LBegPfMlnw2TRxhgGjxDeVNqUoxZZ2bU90UQnC7ql2Kqm42MiI/np5pklIudZr/nP6+SUVHTZhiBGrjjSn8KdEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376941; c=relaxed/simple;
	bh=9IdCbZhLEprALAvnkUSponFptSck45v2LbfRSqKJWI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQvLGhoMmuIU8oudrInseyhyKgqqMF3xmvU66v6QQJcA7pERV0fEZGp/Wlma/9rnNFQUa5IZHAM4URPWQ77jVj0yHhVyz1+mCvp0jTmVoFheaA6lJkPCnBMgZXqj8YSfVeVsLB1iQEjl7i/kR6BX9eORE8pyanFc/GkJ44k1UBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bRuNUyEK; arc=fail smtp.client-ip=52.101.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiANm4W0UemnH4o1CprsMa8TLfi45j1mdtLioIVXRpnaWaFkcQp16aBhFVMGM7jZgrbV7Dtz4bceN83P7drgmLr0VWVlefIl5+INeNnS+TL57JRJDCkiz2udj+dpfyCv3FzAMrkT28DUBcMYlZcEN/MrEabwdacxKubJ4p3NyLZhFVvfsykjA9Kp8QEo8EvHaJRMDYCrII4S9uzF36mBkvPayTC4LI3ZEYey7pzlrhTzd7oqWtJHl9A3xYo8INXQEpnGauePXKx8n9Nje2CouhGDK3TtsLJnkY/OphGELXTNSc0efSM4OkvZJEMltAP+7gjZTFiyWY2+uSE/pLijkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVGm6sr/tpW+Gk3Vrypuo+Att00TQkVwsipZDJlmjJo=;
 b=ZVF2VYb4G9KzHYThurbBQSaGHFY4A4/X/mbqfhqSFJCE788FNnaIrSAkgRLuFv9PfmQR6vJoF+0JYOHF1+gDR7zZZFT8loA0g8bSDqjvcGhEQeTuI7u5jhq0i3eqzXmNfWHn2mIbcOKIqws5Mn82sdV2Cmx6C9ez2F7rZO2hq2wbsaoflapk8PLTaQHVbJ/Xx0vIobXWvRwHMPoEFosVegY2X+/aYo2WPfHGQSK4yEocsfi2NHOj/tkPvbP5b3CeUAW92KkqHRACifNQOyQLsmT+HRj70cwQrGpSBKkez3zYPUNuFFOn9c6ndztZ0W9hqRJZys9mKNVi2clXkDhjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVGm6sr/tpW+Gk3Vrypuo+Att00TQkVwsipZDJlmjJo=;
 b=bRuNUyEKB+m/f5pkGljZxkP6QTDKCkkc5m+u8QZ8sGzesME/DgoskjtcwKfGlZcdXLdG/ojayh/nMeatWw2gh918HMwfui3QiIk4kHeQyOa2d7isPEqhezeDMEOoU0VIWLuUONJvhflLQyftIsOkYXRx/YR97aT/GpK5FhT1+sII+9Yc0kZSd8nyqspxjsLts6ypv4ZX4qGcn4UlSeKbU4JbLgCp8LedgCTK4jM0MOK3+sjXl9VtRisGL15GRIqLcK3onEcpbrK/s+B5/nBLE+KCKOrPoumWBs8pKT8sEddWRzAKJSngx5JVTFqF1+wbZeaH8YRstunUlFp9UF2Irw==
Received: from SA0PR12CA0023.namprd12.prod.outlook.com (2603:10b6:806:6f::28)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 07:48:47 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::10) by SA0PR12CA0023.outlook.office365.com
 (2603:10b6:806:6f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 07:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 07:48:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 23:48:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 13 Jan 2026 23:48:31 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 23:48:28 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 3/4] net/mlx5e: Move async ICOSQ to dynamic allocation
Date: Wed, 14 Jan 2026 09:46:39 +0200
Message-ID: <1768376800-1607672-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
References: <1768376800-1607672-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: 72281f93-461b-47dd-578b-08de53415961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DfjU5Vas/g16FEd1Vsw3ZS1koOI0r+ss4t1cZBqizuexxSo+DlpLEMPW1tEL?=
 =?us-ascii?Q?n+lvG57MO9CHEG+gt8huVtVuiCMpTxlhqJ9WRT0gtbAvO5EiKr1MiLZzItHY?=
 =?us-ascii?Q?GABM/A+FKSwZuoEAKbYhUUOt80ejClcjgU2RESGD6OXmfAtFdgbbAw1fQJPS?=
 =?us-ascii?Q?J9xdh4W/YOHCdzhyXjibL9EQC6DWI6h2l59L81ZuUQdZ42FRg8dVIpBveIJQ?=
 =?us-ascii?Q?pCvnWkbcSQALdAFXXIlwMCRWeSErNM6NymgQcGU0+7xckoYmL3dbyc1Ghvjm?=
 =?us-ascii?Q?tPLiHwujPI8dfFHKkGBKZx8H2uWKb7SmIIa7hoWsI3UdIpn4XR/IWkPepajs?=
 =?us-ascii?Q?U9zGYQsi9JZaWLooQjW/H4EuxRL3/5dQEyrXxuLNKn9TEUsjKdhAq+OhNZQ0?=
 =?us-ascii?Q?n4YbzmIg/FgUzYW1kDXH5ez9Yfc4zTt7gz/6duwfBYKsQoDqmcYpVEubxsuH?=
 =?us-ascii?Q?kyrirtyoDknXHJQzr5dLeNeloxbvAhidJY/if1lOrLnjkmRtlNWLkc1bhQcl?=
 =?us-ascii?Q?Urhf5f8ZaQ86u5vKUTFTG3nR3hVsZfl7PVKUyPbemjZnAIUSLOF4+jhjLvsM?=
 =?us-ascii?Q?m722gNv8gGjg7TSqgZ0Pn6MwJdkiURN6j9sVhrdMmFUqCn9x8R5FrUQzvpxT?=
 =?us-ascii?Q?e78ur4s94JwXPBHLYGJi3twLdNKB9UgpOWOc5dnig7Wljd0XgfHcM6EQy0LQ?=
 =?us-ascii?Q?xwyxmdJbsDkGz0M+XNw5uLIgImMV92BAmhzihVjZdU+Xh8yUsr2KUVUfVaNX?=
 =?us-ascii?Q?56YC0/BbqwPHzGc9NwV/RDfTMkJeXqdFjAAkb9D0n8XXidvXfXH1Mc0N+47m?=
 =?us-ascii?Q?N0CScZLI8+ZdupzISqiwaWIX7iCeNzLVPuAx7egQyGOE9tQy6aQX3WPwb4BQ?=
 =?us-ascii?Q?idiNAi/g2FciqLwsMgbxE3wF7n9yj1s5jmw8lF0k2C/0cpyYAuVU16F9GK5h?=
 =?us-ascii?Q?BsXhON04WSljcKoK2Dx4eWdoloegjLUO7qzS9g7WhPWrxZHKnJAlnp+iK9HA?=
 =?us-ascii?Q?3rovLv6XjdDgTdrxtZtDSmSAUenTixKKeVnOLtrUF2pb92yGY8B1I5bHwzQW?=
 =?us-ascii?Q?psADtWIBfzeZLaIVoIvnLd7eV04m5H9/FsBfEQdHIXHypSdifPBMR8MvLNB1?=
 =?us-ascii?Q?A2fpDAeOl5SfVyvMw14UfdizNAEwq2nAtp4UipFahksDozFstQP6PWY8LnpN?=
 =?us-ascii?Q?O+2JBXhRnprTleFHxMn8PqOkGogVLTUCi45wUjl2YriDEL7rlm8m6DR43zGH?=
 =?us-ascii?Q?Xf05z6dYz+rAgo4/PbXhYPo0PmkfHyiz8EA9b0ZTG7yysV2zRv0szTBidvc4?=
 =?us-ascii?Q?hrdAsNQLqIrgcq0qm9Xd59PrKfNDx0Fz1xXtwPZ7uoSt88C6ZiXpnyEvO2DH?=
 =?us-ascii?Q?yAS+2dht0zNcc0sbL3eAI0QaqGZZg3PWIMDDFUVpt24LV/0Zg5gTd5vioDYV?=
 =?us-ascii?Q?4ExWETSMdbS9JH0HmWSDwJXWmLh4Un5pqTOdpKdd4rn/mb8oX6eGbZHYvmUu?=
 =?us-ascii?Q?Q7ZFjSnwXfymT+lpYj6iDXO+thbSdxW3Flt3YJqJT75JQx0n+CQCJxYq1jL2?=
 =?us-ascii?Q?JSsdRrH2Wr7CMp4p9t4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:48:46.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72281f93-461b-47dd-578b-08de53415961
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311

From: William Tu <witu@nvidia.com>

Dynamically allocate async ICOSQ. ICO (Internal Communication
Operations) is for driver to communicate with the HW, and it's
not used for traffic. Currently mlx5 driver has sync and async
ICO send queues. The async ICOSQ means that it's not necessarily
under NAPI context protection. The patch is in preparation for
the later patch to detect its usage and enable it when necessary.

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  6 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  8 +--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h   |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 67 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  7 +-
 6 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 83cfa3983855..a7076b26fd5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -782,7 +782,7 @@ struct mlx5e_channel {
 	struct mlx5e_xdpsq         xsksq;
 
 	/* Async ICOSQ */
-	struct mlx5e_icosq         async_icosq;
+	struct mlx5e_icosq        *async_icosq;
 
 	/* data path - accessed per napi poll */
 	const struct cpumask	  *aff_mask;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
index a59199ed590d..9e33156fac8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
@@ -26,10 +26,12 @@ int mlx5e_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
 		 * active and not polled by NAPI. Return 0, because the upcoming
 		 * activate will trigger the IRQ for us.
 		 */
-		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &c->async_icosq.state)))
+		if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED,
+				       &c->async_icosq->state)))
 			return 0;
 
-		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state))
+		if (test_and_set_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
+				     &c->async_icosq->state))
 			return 0;
 
 		mlx5e_trigger_napi_icosq(c);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 8bc8231f521f..5d8fe252799e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -202,7 +202,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
 	int err;
 
 	err = 0;
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 	spin_lock_bh(&sq->lock);
 
 	cseg = post_static_params(sq, priv_rx);
@@ -344,7 +344,7 @@ static void resync_handle_work(struct work_struct *work)
 	}
 
 	c = resync->priv->channels.c[priv_rx->rxq];
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 
 	if (resync_post_get_progress_params(sq, priv_rx)) {
 		priv_rx->rq_stats->tls_resync_req_skip++;
@@ -371,7 +371,7 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
 	struct mlx5e_icosq *sq;
 	bool trigger_poll;
 
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 	ktls_resync = sq->ktls_resync;
 	trigger_poll = false;
 
@@ -753,7 +753,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
 	LIST_HEAD(local_list);
 	int i, j;
 
-	sq = &c->async_icosq;
+	sq = c->async_icosq;
 
 	if (unlikely(!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state)))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
index cb08799769ee..4022c7e78a2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.h
@@ -50,7 +50,8 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget);
 static inline bool
 mlx5e_ktls_rx_pending_resync_list(struct mlx5e_channel *c, int budget)
 {
-	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &c->async_icosq.state);
+	return budget && test_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC,
+				  &c->async_icosq->state);
 }
 
 static inline void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index fdbcc22b6c61..aa4ff3963b86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2589,6 +2589,47 @@ static int mlx5e_open_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	return mlx5e_open_rq(params, rq_params, NULL, cpu_to_node(c->cpu), q_counter, &c->rq);
 }
 
+static struct mlx5e_icosq *
+mlx5e_open_async_icosq(struct mlx5e_channel *c,
+		       struct mlx5e_params *params,
+		       struct mlx5e_channel_param *cparam,
+		       struct mlx5e_create_cq_param *ccp)
+{
+	struct dim_cq_moder icocq_moder = {0, 0};
+	struct mlx5e_icosq *async_icosq;
+	int err;
+
+	async_icosq = kvzalloc_node(sizeof(*async_icosq), GFP_KERNEL,
+				    cpu_to_node(c->cpu));
+	if (!async_icosq)
+		return ERR_PTR(-ENOMEM);
+
+	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, ccp,
+			    &async_icosq->cq);
+	if (err)
+		goto err_free_async_icosq;
+
+	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, async_icosq,
+			       mlx5e_async_icosq_err_cqe_work);
+	if (err)
+		goto err_close_async_icosq_cq;
+
+	return async_icosq;
+
+err_close_async_icosq_cq:
+	mlx5e_close_cq(&async_icosq->cq);
+err_free_async_icosq:
+	kvfree(async_icosq);
+	return ERR_PTR(err);
+}
+
+static void mlx5e_close_async_icosq(struct mlx5e_icosq *async_icosq)
+{
+	mlx5e_close_icosq(async_icosq);
+	mlx5e_close_cq(&async_icosq->cq);
+	kvfree(async_icosq);
+}
+
 static int mlx5e_open_queues(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
 			     struct mlx5e_channel_param *cparam)
@@ -2600,15 +2641,10 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 
 	mlx5e_build_create_cq_param(&ccp, c);
 
-	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->async_icosq.cqp, &ccp,
-			    &c->async_icosq.cq);
-	if (err)
-		return err;
-
 	err = mlx5e_open_cq(c->mdev, icocq_moder, &cparam->icosq.cqp, &ccp,
 			    &c->icosq.cq);
 	if (err)
-		goto err_close_async_icosq_cq;
+		return err;
 
 	err = mlx5e_open_tx_cqs(c, params, &ccp, cparam);
 	if (err)
@@ -2632,10 +2668,11 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_rx_cq;
 
-	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
-			       mlx5e_async_icosq_err_cqe_work);
-	if (err)
+	c->async_icosq = mlx5e_open_async_icosq(c, params, cparam, &ccp);
+	if (IS_ERR(c->async_icosq)) {
+		err = PTR_ERR(c->async_icosq);
 		goto err_close_rq_xdpsq_cq;
+	}
 
 	mutex_init(&c->icosq_recovery_lock);
 
@@ -2671,7 +2708,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	mlx5e_close_icosq(&c->icosq);
 
 err_close_async_icosq:
-	mlx5e_close_icosq(&c->async_icosq);
+	mlx5e_close_async_icosq(c->async_icosq);
 
 err_close_rq_xdpsq_cq:
 	if (c->xdp)
@@ -2690,9 +2727,6 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 err_close_icosq_cq:
 	mlx5e_close_cq(&c->icosq.cq);
 
-err_close_async_icosq_cq:
-	mlx5e_close_cq(&c->async_icosq.cq);
-
 	return err;
 }
 
@@ -2706,7 +2740,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	mlx5e_close_sqs(c);
 	mlx5e_close_icosq(&c->icosq);
 	mutex_destroy(&c->icosq_recovery_lock);
-	mlx5e_close_icosq(&c->async_icosq);
+	mlx5e_close_async_icosq(c->async_icosq);
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 	mlx5e_close_cq(&c->rq.cq);
@@ -2714,7 +2748,6 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 		mlx5e_close_xdpredirect_sq(c->xdpsq);
 	mlx5e_close_tx_cqs(c);
 	mlx5e_close_cq(&c->icosq.cq);
-	mlx5e_close_cq(&c->async_icosq.cq);
 }
 
 static u8 mlx5e_enumerate_lag_port(struct mlx5_core_dev *mdev, int ix)
@@ -2879,7 +2912,7 @@ static void mlx5e_activate_channel(struct mlx5e_channel *c)
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_activate_txqsq(&c->sq[tc]);
 	mlx5e_activate_icosq(&c->icosq);
-	mlx5e_activate_icosq(&c->async_icosq);
+	mlx5e_activate_icosq(c->async_icosq);
 
 	if (test_bit(MLX5E_CHANNEL_STATE_XSK, c->state))
 		mlx5e_activate_xsk(c);
@@ -2900,7 +2933,7 @@ static void mlx5e_deactivate_channel(struct mlx5e_channel *c)
 	else
 		mlx5e_deactivate_rq(&c->rq);
 
-	mlx5e_deactivate_icosq(&c->async_icosq);
+	mlx5e_deactivate_icosq(c->async_icosq);
 	mlx5e_deactivate_icosq(&c->icosq);
 	for (tc = 0; tc < c->num_tc; tc++)
 		mlx5e_deactivate_txqsq(&c->sq[tc]);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57..57c54265dbda 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -180,11 +180,12 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	if (mlx5e_poll_ico_cq(&c->async_icosq->cq))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX, &c->async_icosq.state);
+		clear_bit(MLX5E_SQ_STATE_PENDING_XSK_TX,
+			  &c->async_icosq->state);
 
 	/* Keep after async ICOSQ CQ poll */
 	if (unlikely(mlx5e_ktls_rx_pending_resync_list(c, budget)))
@@ -236,7 +237,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	mlx5e_cq_arm(&rq->cq);
 	mlx5e_cq_arm(&c->icosq.cq);
-	mlx5e_cq_arm(&c->async_icosq.cq);
+	mlx5e_cq_arm(&c->async_icosq->cq);
 	if (c->xdpsq)
 		mlx5e_cq_arm(&c->xdpsq->cq);
 
-- 
2.31.1


