Return-Path: <linux-rdma+bounces-14150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CECC2047E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF674069CF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1201D5CD1;
	Thu, 30 Oct 2025 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KjruHlCD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874C37A3CD;
	Thu, 30 Oct 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831255; cv=fail; b=BXYy5MtlbHwb0uOh0wL2P3WCOxZIqrriSTB0+xq1iB423miToPEqPYwzfHxe+T4QU+QWGR+6O6furaq0eUSUVtZD+jQEh/vR1JI7hzvPJCKHMrcA659TdUbj7eWxT9u3KxkGtwv9ktddtwztMFwYNTr3dKa0RFFKVWohu0LbyuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831255; c=relaxed/simple;
	bh=Y9QJWGZ80E5MG725RcU9tzDz3sOnBOa/OOKADuNjzFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ct0FgMSU3jVkTqcofKcqGjtxc/jrOesO/ahrhF7gXm644WdUB+ZmZaDg1GFVk3yN8KbySXL6zG/OQhcYkOy3/fHM8xW2GFr5oiJ062TxElnMeFlPR7Qqkl+NR3Cb7HWzI+4g6Pxnkr6h/twtAmJIoyGaDk78v8Hj7KMPrr4upbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KjruHlCD; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g//gDUs8beDJB2RCt1fzYnagFdActYFr1V/4/x2vsqZLbpYMU0zVy2D9gKH/sj7uMp6MK1W+bX4HzWEyxVjjscDKgiQ5NQyJjBV6C0RYj9bM66Nzzl1nQbbLypkcRqa7041XlyHTaBhYB7Zuy7QJNwPXo8aHBTNr39s3HnAlh2TA3w0j86pSJboMgxQRxSAl2XS3JXS+0ApqFm5IwgX/oaQlhT1aSc/uIyU5TLEljLlGBZbAP/xHxuaUjeRYC40gQhGKqDiLstZZdTU1tykhE1CGg0wf6eQZSIJPlt/Q7ZyPliJQADTaYrjD/DvNjqyxhlq/iRdtqyuqiEw1hCTdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54SolZFmGdi6UjAf/qCKd4x5MYWktIAg7oCJTq2WZ18=;
 b=HDv+zcZ7ayqfjtf3YBcnoPRmCKy26TWxod7f5q/oG67LHlh9FOLKWldUiWxEac7Z1DG7uRHBFAYjz+HRHRPdoWcmYKpeKwAOs63Xq3J0EO8o0DxS2IUHXhnR/8gtoUUp9SJ4ZqjmK8AvPuxNWGdfRfFYO7m45Cuw/mtCqpVuA5eGmPHv78+R8I42AS3yXEefY1FW9c+XQrNfbgvz2+TM3Po2B7acUVGI6FVoy1EMHB8QEyseAEDRh39Ia4myn8ZfPZog0a3AmmLjBWT4g/HsEIhK+mimy4co5k0YDqtw9i57EC+ewJrsqSrC6V37Dzt2kKkSU+vip2srJl/GUw/Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54SolZFmGdi6UjAf/qCKd4x5MYWktIAg7oCJTq2WZ18=;
 b=KjruHlCDzalXhTYawG1rg6WJRjNIDe+9ize96Vx4vaizyK5UBy7Mrn7gYgufxnl1/2pLXlGo2aklE7nrdxbPLAndvyKV6Rqd5L4EqjqRAC6YJdlJyH5pp9e8uXhqRYdL7zrKPC1KM44I8TDNuMbpHxGp19ivLFk2utTr1PmYhpBJw6G74r2ZBJYsd0Wh7WAeAk1WHv0IL3jKKDBfCJEd4Nm7ImF5/Le3BZzX7cVTmj/STYQ29B4zDDHy2fu5n2IS1TUZVAhLpz7ffnrXjM2zXQv3ruEPKmh6yhKO5Ke/vlHolLZgEj15KtByTdwlvfzv9oLOfUmmRezF3lDa8iH//g==
Received: from DM6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:333::16)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 30 Oct
 2025 13:34:07 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::3d) by DM6PR03CA0083.outlook.office365.com
 (2603:10b6:5:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 13:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:34:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 06:33:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 7/7] net/mlx5e: Defer channels closure to reduce interface down time
Date: Thu, 30 Oct 2025 15:32:39 +0200
Message-ID: <1761831159-1013140-8-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 43020b37-e1c9-4cc3-65f0-08de17b8ffe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?brIwWtfSk5HW/H5GLWvlcWEBClpr9TG2aXbdJ0PcpKRUyyeLtngfgv/GZet4?=
 =?us-ascii?Q?lKbr1m1gAlwHh+JmBtBRF05U3JAy0+TbdNgsXtaYn/EFeAwoYdj5Gyp+Y0/h?=
 =?us-ascii?Q?Q4/hmcUsdShlbUhwEHzH1rCKsvpBTit6bvP23m7ve+8AYX6Qr77Z64fHYolD?=
 =?us-ascii?Q?N1plbIZD8qGQY5O2g7kh2JWZMhbwkt/B3HpUfdr50r1MDBDKYS5UyZmWDlY2?=
 =?us-ascii?Q?UbVHPAB/KAw3z4ERnn0qcL63/KDMra4Pgs0HJuqmcg44vzo136v3mcxXMsqC?=
 =?us-ascii?Q?PgL+km0je0UAejH769AMfDRLeBLckLrPPq73/f5dj77uLZ74Pp5lMx2aj+1+?=
 =?us-ascii?Q?AKtilDERGFdDoUWa5tM/Aflxef9AsQpeLYCw8CqkTUPoH8V0KZrykuO3Ahan?=
 =?us-ascii?Q?r15mtPi2rA9JVpiu6QkDfDz6XpW/iGkZ7dtP4w9HLHTfDuHU3Ik+LHWS8Rr3?=
 =?us-ascii?Q?iToinYIwSQL4qZw3Fp2hyO22WUwkRG4fQ9plE9mDNLd1IkhKd4Zd/zhzdppo?=
 =?us-ascii?Q?DP4t6swS/jXchSNIbHXK8YyY7FaA3SKc/YDUvuNkBg15hoJB8kNlJBpkg+jO?=
 =?us-ascii?Q?aGGsfiCcPWsjRxKUn7BZK2QvQ8XMeFxpM5pRGzs5HLaZ7+n71USVJNMfCUc6?=
 =?us-ascii?Q?a/hlJAB04gf0RYLdY6Pma7kRgr4tEe8C856ga0kJc7xQopMV1QzGuJd5V8wC?=
 =?us-ascii?Q?o+sfwYeHNfYmp4iVP+6oHXfEuligjzZ3XQwq+e6nCII0Qq7leh2Jhq4nv4Fe?=
 =?us-ascii?Q?rkhb8g0Jzb2s4Yv6f+4PfMkHuglQEph4i7CP2fQbVsnRTCOAymrlLRNlOkQH?=
 =?us-ascii?Q?1VxHZ3Z9DiVrCugexGoTJuyclS4WrFFiOY/4lRrGuTYnGNBklnBc+QBNxbwj?=
 =?us-ascii?Q?LDzHP8noGI8OSkYRNJIdGpkS+NybWS9Yxjj94b2yRHl40qHiytsNukWYANkn?=
 =?us-ascii?Q?AvtG94DqF6iD4cD7joTMhKsxPVo2GcQbw8OI+AIDy0GDdPT0Jiu6UFs7+Vfu?=
 =?us-ascii?Q?npvP6IRCmSYFetocTrBawSUfy5x+qn8zsB5JAjVANvI8ZqQ0LyUQ4JIowndR?=
 =?us-ascii?Q?/D2dF63HTN98Aq9sJiUn2a4BKmk1RW8DoIep7qoWK+6u3tLA22YU2gQGySo8?=
 =?us-ascii?Q?3fEjkr0G1NN8an2FGMcM7CQmdJPqrMv9jFWO0bE0bMRpp9Tn7cuO1t4DyBxM?=
 =?us-ascii?Q?Bb9R+tfncY9H6u5/2Ba+v3xRzGOMDp+e7ZhVgmQgHUNuhY+4PAKqXh9GPc0N?=
 =?us-ascii?Q?v9V23vaZLRLLDOMX7YBxPFzOw12jgbdRsOESW+XTfwX4ps1HYFbeTKptm7iC?=
 =?us-ascii?Q?0ljLuWsKLYaYcu8wMpemIO1twGGuWnXPbj7Y47XjWvuQToaFvCJNQC71cNuA?=
 =?us-ascii?Q?Ed/6K8sVCQ/ahzIXwWpEY//m3H/iMsxV0sXMI3/D15AA6tTw6KRh043BC+h8?=
 =?us-ascii?Q?1P6942nceWsW+10GegWnT8pd/hpbR48o5ByVR0KPPjSQ5oaNaFY0TsVSNovV?=
 =?us-ascii?Q?zVh5A9FKtVfHUw2u2LlqzhJLIJP6zcAeFVeijW9sQqGIYu4mIlZ1ztJlG0V4?=
 =?us-ascii?Q?QEtJIAGBQ6moA9jd/00=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:34:06.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43020b37-e1c9-4cc3-65f0-08de17b8ffe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844

Cap bit tis_tir_td_order=1 indicates that an old firmware requirement /
limitation no longer exists. When unset, the latency of several firmware
commands significantly increases with the presence of high number of
co-existing channels (both old and new sets). Hence, we used to close
unneeded old channels before invoking those firmware commands.

Today, on capable devices, this is no longer the case. Minimize the
interface down time by deferring the old channels closure, after the
activation of the new ones.

Perf numbers:
Measured the number of dropped packets in a simple ping flood test,
during a configuration change operation, that switches the number of
channels from 247 to 248.

Before: 71 packets lost
After:  15 packets lost, ~80% saving.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4edf64e1572a..9650fa6c6a63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3384,7 +3384,8 @@ static int mlx5e_switch_priv_channels(struct mlx5e_priv *priv,
 		}
 	}
 
-	mlx5e_close_channels(old_chs);
+	if (!MLX5_CAP_GEN(priv->mdev, tis_tir_td_order))
+		mlx5e_close_channels(old_chs);
 	priv->profile->update_rx(priv);
 
 	mlx5e_selq_apply(&priv->selq);
@@ -3432,6 +3433,9 @@ int mlx5e_safe_switch_params(struct mlx5e_priv *priv,
 	if (err)
 		goto err_close;
 
+	if (MLX5_CAP_GEN(priv->mdev, tis_tir_td_order))
+		mlx5e_close_channels(old_chs);
+
 	kfree(new_chs);
 	kfree(old_chs);
 	return 0;
-- 
2.31.1


