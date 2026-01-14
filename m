Return-Path: <linux-rdma+bounces-15541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C4ED1CF16
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D808630B3416
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 07:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3E35F8D0;
	Wed, 14 Jan 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ao9IS/Ds"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028948CFC;
	Wed, 14 Jan 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376922; cv=fail; b=QtiJfvqP+Qo+ZDAWhzfLWK7UdAqEyS30uFK9cqvVz87NCaeGHYIBswmcjKjOfvYFkgTNWRxcs6UMJwi5cKuGAHuHqpF4cI4Wtft9IxQ6jeLfERea9AY235UrJ5io0LAeIBpXn+AhAQ1l8FVjKAzTVvLJBPJUJLvbu8Kymm4oxPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376922; c=relaxed/simple;
	bh=UKCcjHjnyPFSmvWN6Uv69t9gULdSQrZPPtP08Gx8x5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ+9HIG42r9wsAZ91gs+GkcPihSOJYpd8Bl+XNscRPqRKArk+og7ov6jFi7NqnCVdpe2OSHk7cpau8sL4mX028Y3ornCOyLgV6umlFF1v6l1DslFrJWw/nkXbN8gnCmK8wms2DnqOcP9tn5lsmpv3RzWxhdy92Se32kPUGeSJ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ao9IS/Ds; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXpLpZrArgR8yjLSHL5t3qXxN6tYVRJTM7eOZkLBzKWMZ62s2Syha3rauDZ/2G6jGBZS1IbxH9bt9BrPd2/EZWuxT9G/nInBT7tT4tjqPJx7kXO+EcsaD304ZsXebB4MyEiJsHO28kmCLbxd26+ZnP4/qIcyzfUTDjrdyTUQH0vqz3FSu59RCo1616pUq/P4cDMnUUMKHmTxCoXAcAv5xNqAePYEF6XOjJu1sWKf26Y7LK+P6E4edWjFnSf6rMqx8zqLvw37NjgTQ5q+uLqAtm7/tTVTukf3KhWMDjE5KfupY7eE8lIURXnVxopeyTpxr7mTIgQgtYBd9HgsWJwHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwtektvNLsRptuiHCaupQMzM9PA0xDctRS5Er9Km+uw=;
 b=ahaujG16FNg3UEaXOLfElF/cxhncFFiWcVoPEyGSAQz7eevTzhtxztOlrZJZUFsCO7g3lntBBSw9B3hGUhvrxgHq8I1YKCb996vRO7tBJsg1+N0+SuUCPO+q27u8eqUjR1po5CG5vxDGz7/iVOV3DYzLHGT5V4XNfwkiu4qqF1sK1K1KD3x6FuI9ZA6iCjLfxzaOy2SeCJD9lORAiPNlb1VPYod64E/MTFJ12GikM7sN+qIOPtpPN/9cEC5OaEuiuUjauuGMRrcoWuL5n2+FlmjzNYm/05WHmFrjFGe1ETHbybfVYGQfvpvYHFS1DEknX0vUUg+p5xZVItXnA3gU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwtektvNLsRptuiHCaupQMzM9PA0xDctRS5Er9Km+uw=;
 b=ao9IS/DsOT0mnKAfBx8n7WjY4yyW+WzbhCV1tBeH7TVJUY8fTJBMxzubm3zkwBA6K2xQ+XH1vcO404Zd5r1jyr2eqYzwazgBGxRdlu+n+iciZOqB9T9IDXbNyhVCW+UqQTlXEkhobR4ok+vu3EC/dkbg8aBW/CurrCgKThdSkQRU8tys5zYhqeF4A7fNEeS3X763Gw9+8I4ZLiDZKZZkZqsDEEvDaQoKpbplq6tep62BMW9SxAKk8k0Ze5VqMF/G6f4jyakPp3lharjqfDm3MyPL0zas2ZASElYds5r6J64WrhkXBOVUJEf9+/YaiNlYHhLJa3GBsXfMnMJTU2MAPQ==
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 07:48:35 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::81) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 07:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 07:48:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 23:48:24 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 13 Jan 2026 23:48:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 23:48:20 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, William Tu
	<witu@nvidia.com>, <toke@redhat.com>
Subject: [PATCH net-next V2 1/4] net/mlx5e: Move async ICOSQ lock into ICOSQ struct
Date: Wed, 14 Jan 2026 09:46:37 +0200
Message-ID: <1768376800-1607672-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: ac57712e-a7a9-4bde-2d59-08de5341523b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Do3xe4LrOFCi1uYv8iXwKSjHOHfEgCmZKBPLAhfCTP914o+y6Mgi1W0xbLA8?=
 =?us-ascii?Q?RuGdmbixeOmXCrUAXe7wwTFC1PpkaGaQYCPrLEOcq4uNyId652Vl7A5I+PXR?=
 =?us-ascii?Q?HzaNcHDSdJbU/mKZaw71CoQliZGPrivz8Uti+wC8SqHqtJb87q/o4U5fKQtp?=
 =?us-ascii?Q?EJTq68ItacVlvepi6c4C693+SGwNUKQL+43HdFVQd5DTeJBogr135tXIKwrg?=
 =?us-ascii?Q?m+hhD1/lyZWUZRL28DoRQNemSgwcRHYb1VcMsGBIQKdXr36XPb2ARCh3oK8A?=
 =?us-ascii?Q?l7Ew42YNrO/JIXYsbHV2XrKiyCRWchjCPXUWjT9EvYHjcbRM+h6W14Pb4Mfs?=
 =?us-ascii?Q?rDxJ2iShf8IqB+VehnsXQemT761qriOYhSdfTeaV0Japt0tVs20cGCrXqpr2?=
 =?us-ascii?Q?Z/w3gdor50wjk1b5WpZwD5rtkUczTOxUepYoBcFMxQcA1W9YbdZHeDCFkov2?=
 =?us-ascii?Q?Z6+UhGVwgnWsUOmtdpO6sF28994jy3+d/KTdifX/i54fDph3Rblrym0CT/vZ?=
 =?us-ascii?Q?129JvcMmBG8Qe0YMWe4+lO4SOVZlUiO++5Zsf+RNPpKKJ8rEHAPwV9nTL9+D?=
 =?us-ascii?Q?MyDvWDKoeYChiEioWHcUIaZG6XjqpydIqMElMnG+1qrDEZCbx/iO7+9hPDkC?=
 =?us-ascii?Q?C7QtZwfpR3topElmnVXgVqKCZTjVy7x5Z+z9zj9oGFbaEp3tge2nvEdFiSeh?=
 =?us-ascii?Q?Xjv4neNukgABp/so0UU0eujayXHr57JkZGRiDkEEqy1tcnZuQXQSpZdExxLn?=
 =?us-ascii?Q?pb0dMzHyltDV9ft1ZZxvx2XwILWrYyCKvBLZqBUnvWTbbyd7SnCzRmy6TqU5?=
 =?us-ascii?Q?+dXcat/kjWekVOdblc/0uNqam+ntXD+sVi34VZRjU4DPgYP3HQTBzjJ/Zq/j?=
 =?us-ascii?Q?+Vh4jsXZNnc/WTzHQfhcs8NDLvM3hKWIYtEPliiKX2BBjx0IDXqdc8h3iQlB?=
 =?us-ascii?Q?SN+euD/Km4Ah8h2Py9UUVA0PTKOpMkgHhcDgCgx0Rsjigj3n8QPcnqXAl8FO?=
 =?us-ascii?Q?mRcnnWCBZInxmVcnMqJ1HP+BqwWkenZJyQDVpcDQ1ai4dQEKxAPx9onFc9SX?=
 =?us-ascii?Q?2JllVZV9uFAFDQd3HTGzz2ksaMvwXSTwthjMiuMKyrhQNp2dYtPG3freoKXx?=
 =?us-ascii?Q?19TEhhUDFeC5Cif0H0kPSEmXYwRMj7EE9RgVrhbVRoqZXGpZ9fSf2oVeUUSu?=
 =?us-ascii?Q?p6uLOHXlGNhPLQMdgY3I4WZndBD4vcVGCfysGPgrEM5IIxPV+5oWKUTWlvNr?=
 =?us-ascii?Q?qUbwgkJNWQrn37bpY9CpfsmCIY1KvkMEKpGpgjCrHDXUV3BExPxChV1wMLfD?=
 =?us-ascii?Q?ahHi0GMSrg+hgkTSCPuRxOr1ZzH0Xu/fa0glPMZ2FcGx6DLrecYjCSoqmqDN?=
 =?us-ascii?Q?zvCdmOuja3Qr6KGU83cWiJUzwFAsbsCKSj9OfQwDvDpoVqH8gweKKv0STNk7?=
 =?us-ascii?Q?4y/WjpEz6tQ6MQ2EuF9C/p+1K08BqituYccykXRdKMw2+im/vieyTTXWZtq+?=
 =?us-ascii?Q?C9HL7xxMGXk5eI3rK95K7bqk6F2j4jnHPNy2fa1frviFOxjCmJb/Fmk3O+C1?=
 =?us-ascii?Q?ikHVLPm0UAAqQ9EFH+I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 07:48:34.9542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac57712e-a7a9-4bde-2d59-08de5341523b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316

From: William Tu <witu@nvidia.com>

Move the async_icosq spinlock from the mlx5e_channel structure into
the mlx5e_icosq structure itself for better encapsulation and for
later patch to also use it for other icosq use cases.

Changes:
- Add spinlock_t lock field to struct mlx5e_icosq
- Remove async_icosq_lock field from struct mlx5e_channel
- Initialize the new lock in mlx5e_open_icosq()
- Update all lock usage in ktls_rx.c and en_main.c to use sq->lock
  instead of c->async_icosq_lock

Signed-off-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h   |  4 ++--
 .../mellanox/mlx5/core/en_accel/ktls_rx.c      | 18 +++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en_main.c  | 12 +++++++-----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 262dc032e276..ebd3b90e17fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -545,6 +545,8 @@ struct mlx5e_icosq {
 	u32                        sqn;
 	u16                        reserved_room;
 	unsigned long              state;
+	/* icosq can be accessed from any CPU - the spinlock protects it. */
+	spinlock_t                 lock;
 	struct mlx5e_ktls_resync_resp *ktls_resync;
 
 	/* control path */
@@ -777,8 +779,6 @@ struct mlx5e_channel {
 
 	/* Async ICOSQ */
 	struct mlx5e_icosq         async_icosq;
-	/* async_icosq can be accessed from any CPU - the spinlock protects it. */
-	spinlock_t                 async_icosq_lock;
 
 	/* data path - accessed per napi poll */
 	const struct cpumask	  *aff_mask;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index da2d1eb52c13..8bc8231f521f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -203,7 +203,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
 
 	err = 0;
 	sq = &c->async_icosq;
-	spin_lock_bh(&c->async_icosq_lock);
+	spin_lock_bh(&sq->lock);
 
 	cseg = post_static_params(sq, priv_rx);
 	if (IS_ERR(cseg))
@@ -214,7 +214,7 @@ static int post_rx_param_wqes(struct mlx5e_channel *c,
 
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
 unlock:
-	spin_unlock_bh(&c->async_icosq_lock);
+	spin_unlock_bh(&sq->lock);
 
 	return err;
 
@@ -277,10 +277,10 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 
 	buf->priv_rx = priv_rx;
 
-	spin_lock_bh(&sq->channel->async_icosq_lock);
+	spin_lock_bh(&sq->lock);
 
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, MLX5E_KTLS_GET_PROGRESS_WQEBBS))) {
-		spin_unlock_bh(&sq->channel->async_icosq_lock);
+		spin_unlock_bh(&sq->lock);
 		err = -ENOSPC;
 		goto err_dma_unmap;
 	}
@@ -311,7 +311,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 	icosq_fill_wi(sq, pi, &wi);
 	sq->pc++;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, cseg);
-	spin_unlock_bh(&sq->channel->async_icosq_lock);
+	spin_unlock_bh(&sq->lock);
 
 	return 0;
 
@@ -413,9 +413,9 @@ static void resync_handle_seq_match(struct mlx5e_ktls_offload_context_rx *priv_r
 		return;
 
 	if (!napi_if_scheduled_mark_missed(&c->napi)) {
-		spin_lock_bh(&c->async_icosq_lock);
+		spin_lock_bh(&sq->lock);
 		mlx5e_trigger_irq(sq);
-		spin_unlock_bh(&c->async_icosq_lock);
+		spin_unlock_bh(&sq->lock);
 	}
 }
 
@@ -772,7 +772,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
 		clear_bit(MLX5E_SQ_STATE_PENDING_TLS_RX_RESYNC, &sq->state);
 	spin_unlock(&ktls_resync->lock);
 
-	spin_lock(&c->async_icosq_lock);
+	spin_lock(&sq->lock);
 	for (j = 0; j < i; j++) {
 		struct mlx5_wqe_ctrl_seg *cseg;
 
@@ -791,7 +791,7 @@ bool mlx5e_ktls_rx_handle_resync_list(struct mlx5e_channel *c, int budget)
 	}
 	if (db_cseg)
 		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, db_cseg);
-	spin_unlock(&c->async_icosq_lock);
+	spin_unlock(&sq->lock);
 
 	priv_rx->rq_stats->tls_resync_res_ok += j;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3ac47df83ac8..e666d9cc1817 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2075,6 +2075,8 @@ static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params
 	if (err)
 		goto err_free_icosq;
 
+	spin_lock_init(&sq->lock);
+
 	if (param->is_tls) {
 		sq->ktls_resync = mlx5e_ktls_rx_resync_create_resp_list();
 		if (IS_ERR(sq->ktls_resync)) {
@@ -2630,8 +2632,6 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_rx_cq;
 
-	spin_lock_init(&c->async_icosq_lock);
-
 	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
 			       mlx5e_async_icosq_err_cqe_work);
 	if (err)
@@ -2750,9 +2750,11 @@ static int mlx5e_channel_stats_alloc(struct mlx5e_priv *priv, int ix, int cpu)
 
 void mlx5e_trigger_napi_icosq(struct mlx5e_channel *c)
 {
-	spin_lock_bh(&c->async_icosq_lock);
-	mlx5e_trigger_irq(&c->async_icosq);
-	spin_unlock_bh(&c->async_icosq_lock);
+	struct mlx5e_icosq *async_icosq = &c->async_icosq;
+
+	spin_lock_bh(&async_icosq->lock);
+	mlx5e_trigger_irq(async_icosq);
+	spin_unlock_bh(&async_icosq->lock);
 }
 
 void mlx5e_trigger_napi_sched(struct napi_struct *napi)
-- 
2.31.1


