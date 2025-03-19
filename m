Return-Path: <linux-rdma+bounces-8845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E016AA69933
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 20:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848EE486465
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96520214A69;
	Wed, 19 Mar 2025 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CfGX3ztX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10621ABBC;
	Wed, 19 Mar 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412296; cv=fail; b=Gwvzj+XpE+7seokxL+7C7x3g+ZTU0aac2TAv9F15j/n2HTqMo4+krg2xy/5kSSkONqy/3mIYSq/aLQpJnCaP6yPQiKJeMlb81TOxt8ZImtKaLPwFfbS64TKpXY6DCnhRUFXS9hJayK64ldumqdg/TKpuOMqL/swwPw4E9Moxyno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412296; c=relaxed/simple;
	bh=Xiw7tN5oeXt0qNWHJnmIFxACUC2NEa8vyII3DpubpZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tudf8sJArIow88P8AahqNMGxhgwTdBHG61UfCfhLqU7SNJ4/of+10utGrFfU9swzd8AuQJ1UeB9QCxnyAfPshoC33SEl0h4iUXhYhLF7lHCZpGxOCzIinDYcAl0G8653gDSMK+XJZTnNkpUw9PFVf8mUU7JwoN6LFKwHm2J3YNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CfGX3ztX; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de5/HDmorzza+ZPOufKukWUrCDI/o15pPHKrXhsxCLaidgkmGgz9hSWa9F4y6nR41q7X2eHr3yy8Gam+Odb5TlQV2DvyCAVcnEZm/sLfNIvAruM4YQphax4/nxpbHr9NIarFmxSwLC6arHqwCBq04w5mFwBzLNP3i9qukD/rYOQB93NSx2+jLwRgR1sX5I4cclwvnjxsIaIIZmS6+R/XyWPBO6R+J5A0KM3DQOD2jL2S9uW+SBHk2FbRJ2b1f69+4jke0JQU3netdl+YZXHYu3E76SIMtss/i9l/cF25x2erJthJn8/o/mGlKHEmbg3tZdq3HWfte0Lczk3Jwam/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DNaG5uPEuAxV64NB0r+y7JCjICnAGQ7jACDFPDriew=;
 b=TnxekDHZ+Mcq9AXy5mUMYMuDvDz86Yv5VF3JEB9GZ1Lncd8sv7vj6Ne5+6C6hdbweRi9gbKuXdIFlkrvPfNfTP1jSlN3aRdgjlI74lVEmpsNcMsGmhB7WUjXgnSAdHUbWfLyo+K95z+yqfLF0TzP+SiW7nMuA0EcQOx/XVYoS1WerFgH0iXNCAtgpITxdATPknTHKO10D4JWhiqF8dXQ0aRizF+us26JY8UwUB+fMmAcKpseglrbdhG7jDQQCumzvGWiErnJe9fUHsjSShlgWY3Iwe1rebMkU4Ko2llIWkeTw1Cyq5+d9TBN760qs0PzRsuWv3zOMuvUF9KbGRgVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DNaG5uPEuAxV64NB0r+y7JCjICnAGQ7jACDFPDriew=;
 b=CfGX3ztXAlsU18CZHozoY/VkyKdDI2cZpbjvR6jk38ae7vSQ9WqlT7wimKn2sMeYw4YpGvjZbzFP77XPeV5e3sQQ8xnLrsSSVPlabTcyXPSe6hMb5MZYBV3rByuPTpjxexS65y5roJ2GEGpluV6WNdPFKIphxXpAYrPRXRm7XUchnxYSZV9sPxWP7uPpU6PrsRWUabxiWiWr+d/uCgfFmsIJD11BDb/jrFVzLbn1WuyYVcpvNOaApHNVTjWZSPLvV9WPeH24knHg7ihiQaa2wLuA9I5/k6dOXHrMX73eT94gJJYR/m0nehWkaMNAhgG3g78+usj/3Hzd/ua5UjyxKQ==
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 19:24:50 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::30) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:24:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 12:24:37 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 12:24:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Mar 2025 12:24:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5e: Always select CONFIG_PAGE_POOL_STATS
Date: Wed, 19 Mar 2025 21:23:19 +0200
Message-ID: <1742412199-159596-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
References: <1742412199-159596-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e7c57e-ed06-4b06-e40c-08dd671bb6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g5Qj1Bq05wYx8Wj9Ux90XWmLYAwe3aaeo1mB9+vvg6Kk6yvu82rI2pF/nyKV?=
 =?us-ascii?Q?rtHBv1Jn19jDLvbfvNK80UpcMGs7mFk2ErPcUp94YEW4EnOD+E244Im9RLPp?=
 =?us-ascii?Q?aCDechoeKA8de4zyIxNLAtmacf0FqN6koumicE7krjBOFOfezzcRtaVFcJfE?=
 =?us-ascii?Q?kdypegfv8yI8c3bPTRs3F3XYNif6reA/rk/xtk4jqNp1ISDHTKMgRgP1vUHs?=
 =?us-ascii?Q?OUMUWbsKgB0jezjkGt55qdURqYsiS8CBb9/4dPPqWWqYiVqLl01zmXIvDM3n?=
 =?us-ascii?Q?MscSLj7VAmixuV7GSpB82KvuGrG1sd4hwDZYm5wcemmadjqC1bwWgnGlEsZE?=
 =?us-ascii?Q?e66+91oGj+JeG4F9LMZJ367ULIZw2DX+dn3W/t3CAjVitD2oowf9X70dWkz9?=
 =?us-ascii?Q?se5s7gjTwLOoHepf0uV5GCINsjLfYyCjOcylTO8ZzduXS/JLTVjMCWU/SMPu?=
 =?us-ascii?Q?GCrK7sY0CHiAqXOWQAhX/53IJ3nHG3JkA42jY/0nae3kD6W+3XW/CGIT89Cz?=
 =?us-ascii?Q?0BK/q9/XoBkeXaHjLW3T7CzAJ3EwDZ4mTkp3TU+R/LBCovDDa3af6HyoC2un?=
 =?us-ascii?Q?qVaCLOcP/Xga2qgVCFstaTn+gQsTB1FodK70p0JN29oNtEmC3D9sE4ydJj14?=
 =?us-ascii?Q?PfZDMuW1hu7HHcW2IS6cITxbW0NjpfF2uRBZVtqq31rAJHFC5yfcnravcWmg?=
 =?us-ascii?Q?f8QUmoDCoDsw2xxVVGq3suK+zNCVB6dEMjwYhHvD3r/UxqCfp1lML6Y4b+2W?=
 =?us-ascii?Q?YAXtzOp+bSu7BQ15k2BYGa70qPEer+nbel/A1SZe/QO5eA3CAvju3yDIm+/i?=
 =?us-ascii?Q?LobcVa7Dp7DfAdYCzhgoxuOrYq6q29vArUh8p72f8JDV2r6A/FKg7CNpVO0O?=
 =?us-ascii?Q?03qOKlkxmR8fwTthVu144eqKmbrbgXGsRsCJboLPRNlYfPE6PaP98CQOVuR2?=
 =?us-ascii?Q?b+stkoAw068Cdi4dCRJc4+mqO4agt6z1h1W+K13FI7QITaPVKXdF3p+lDHU/?=
 =?us-ascii?Q?zwHKyYDIlpAWZG3AdblkTg0UFSKAekLjaskZayvKRzXNcSrzLMCV2C2+M6/C?=
 =?us-ascii?Q?Qiq2q5dOUyrC43q14EWFM/q035wXnLGCrhkH6fwL4lBY8HMcb/TnJgnHOT1u?=
 =?us-ascii?Q?Uy6gaTmoIKr+uVKRkU/8GLrWaD+Kp5IHVlYaopBJMkvG2Vtx4NjhxmNmeLrq?=
 =?us-ascii?Q?12bcSe5pC+V5Bz57vr4TfDK3GHDUDXj6frJJkXBalogRqVb8HYale7Ylmvmg?=
 =?us-ascii?Q?YMHb2hQEKjerb5Ih5i166soPhPq7+bbSMmEgLm6LYimOdJWvbDDKs4xoyDh0?=
 =?us-ascii?Q?LfKt1hOI/86PHLhzd4uYOpJcmfBXEUqU5tmsYWvfSvO+i2IgHqpNyKshgTJt?=
 =?us-ascii?Q?rf/KpjdocaBPvpv+lxs/8HHnCS/PS9QC6HlmCu5fiV9bRv6dbxlFVcwryX1V?=
 =?us-ascii?Q?PJmBJSV/Y+pbxtsZoRMq8tzs+j1t5I9JSiAZI7np8+rAWwH54NT6bWEm7BeC?=
 =?us-ascii?Q?6mBOtcOel9D2ePM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:24:48.3368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e7c57e-ed06-4b06-e40c-08dd671bb6d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611

Always set PAGE_POOL_STATS in mlx5 Eth driver.
Cleanup the corresponding #ifdefs.

Page pool stats are essential to monitor and analyze RX performance.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 14 --------------
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |  4 ----
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
index bf4015a12b41..6ec7d6e0181d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Kconfig
@@ -31,6 +31,7 @@ config MLX5_CORE_EN
 	bool "Mellanox 5th generation network adapters (ConnectX series) Ethernet support"
 	depends on NETDEVICES && ETHERNET && INET && PCI && MLX5_CORE
 	select PAGE_POOL
+	select PAGE_POOL_STATS
 	select DIMLIB
 	help
 	  Ethernet support in Mellanox Technologies ConnectX-4 NIC.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 611ec4b6f370..386f231e642e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -37,9 +37,7 @@
 #include "en/ptp.h"
 #include "en/port.h"
 
-#ifdef CONFIG_PAGE_POOL_STATS
 #include <net/page_pool/helpers.h>
-#endif
 
 void mlx5e_ethtool_put_stat(u64 **data, u64 val)
 {
@@ -196,7 +194,6 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_arfs_err) },
 #endif
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_recover) },
-#ifdef CONFIG_PAGE_POOL_STATS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_fast) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_alloc_slow_high_order) },
@@ -208,7 +205,6 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_bytes) },
@@ -377,7 +373,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_arfs_err                += rq_stats->arfs_err;
 #endif
 	s->rx_recover                 += rq_stats->recover;
-#ifdef CONFIG_PAGE_POOL_STATS
 	s->rx_pp_alloc_fast          += rq_stats->pp_alloc_fast;
 	s->rx_pp_alloc_slow          += rq_stats->pp_alloc_slow;
 	s->rx_pp_alloc_empty         += rq_stats->pp_alloc_empty;
@@ -389,7 +384,6 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_pp_recycle_ring			+= rq_stats->pp_recycle_ring;
 	s->rx_pp_recycle_ring_full		+= rq_stats->pp_recycle_ring_full;
 	s->rx_pp_recycle_released_ref		+= rq_stats->pp_recycle_released_ref;
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	s->rx_tls_decrypted_packets   += rq_stats->tls_decrypted_packets;
 	s->rx_tls_decrypted_bytes     += rq_stats->tls_decrypted_bytes;
@@ -496,7 +490,6 @@ static void mlx5e_stats_grp_sw_update_stats_qos(struct mlx5e_priv *priv,
 	}
 }
 
-#ifdef CONFIG_PAGE_POOL_STATS
 static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 {
 	struct mlx5e_rq_stats *rq_stats = c->rq.stats;
@@ -519,11 +512,6 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
 	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
 }
-#else
-static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
-{
-}
-#endif
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw)
 {
@@ -2086,7 +2074,6 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, arfs_err) },
 #endif
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, recover) },
-#ifdef CONFIG_PAGE_POOL_STATS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_fast) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_alloc_slow_high_order) },
@@ -2098,7 +2085,6 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_bytes) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 5961c569cfe0..8e3344e8eadb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -215,7 +215,6 @@ struct mlx5e_sw_stats {
 	u64 ch_aff_change;
 	u64 ch_force_irq;
 	u64 ch_eq_rearm;
-#ifdef CONFIG_PAGE_POOL_STATS
 	u64 rx_pp_alloc_fast;
 	u64 rx_pp_alloc_slow;
 	u64 rx_pp_alloc_slow_high_order;
@@ -227,7 +226,6 @@ struct mlx5e_sw_stats {
 	u64 rx_pp_recycle_ring;
 	u64 rx_pp_recycle_ring_full;
 	u64 rx_pp_recycle_released_ref;
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tx_tls_encrypted_packets;
 	u64 tx_tls_encrypted_bytes;
@@ -381,7 +379,6 @@ struct mlx5e_rq_stats {
 	u64 arfs_err;
 #endif
 	u64 recover;
-#ifdef CONFIG_PAGE_POOL_STATS
 	u64 pp_alloc_fast;
 	u64 pp_alloc_slow;
 	u64 pp_alloc_slow_high_order;
@@ -393,7 +390,6 @@ struct mlx5e_rq_stats {
 	u64 pp_recycle_ring;
 	u64 pp_recycle_ring_full;
 	u64 pp_recycle_released_ref;
-#endif
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tls_decrypted_packets;
 	u64 tls_decrypted_bytes;
-- 
2.31.1


