Return-Path: <linux-rdma+bounces-8327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEEA4E61B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A4519C68D3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C7A2BE7B9;
	Tue,  4 Mar 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oP+nDhv1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EB29B21B;
	Tue,  4 Mar 2025 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104442; cv=fail; b=uuayW6Mp+DnFWmRllpxozWVKvccZ521XpQhvmLGnlmu6OpoGtvT6hsWHhOXO3nWpLKhF5m+651Ym5U7KKlkShXIvudDXNmVoRBiDru2FQSVWsfWLwlNHA0rx4UtuUijn7ECu3sFB5Elb/yVWqywp9PBenNm87eoKG7TokqPqncg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104442; c=relaxed/simple;
	bh=iPHSmpl30CuhZWAFlxT9eLazlx/E+CmfgIBtwL8EnRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNh9pjkwEYM3uQhoi/6kpMiDrweV19Igw1eYhJKETSaN2vUnqsdWLEFRL7ERpfrCR7huQsed+KJA3qXOz+AtVvlxDWy0iaSFSZJojRsLdlrgUX5mAYfsURsaY4w2pFJd6MDcG5ZJtuMPAr1ogEAfxzFhbCfN1wvhhNij3DqMgI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oP+nDhv1; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lw0Gf4PLCA86DBnE0+vqTvJd/8sQnzclJs5OOxbeKmbNChhF/W+G42hcLpdtBMNEp7F74LBYAxiU9L2qp7CddKEBhp5aenRNXdVk0dheIWN3sTXk+vaLseh96CeCi+nsbk183YYvQr5nM0ygJCAFYXYpGQ6wsFTiBEwsAb4YByQLw2xn6pLQ5O/wE7JeeYd5VlqXymiHeXrl4WP+rHnE5I/Xzd+BAL9NYLR80XIYcS8pHfA2h/GgvsiJLYNIYd592ghVx/K7Gfqjk2gZiusMm95lxFinYkFuD6QMe7XrOIJ/YZ7k/QBYllTiLVtzRxqpEnZO0RBeKtcIVOuooJA99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjhBm9+gI6+sW7K+I0V4BLfqzqOTS5bI+PW2nMnzQe4=;
 b=dui5/rO+R2bR5gNd7as19Q8+Femwv7k7WeycXWe6tKRLOKTEU/MSe/6FKjRioM3nhe75BfwmiXyZHAsQnJ+XUNbeSbLgtgWhvaneLLpE6a4ZnbLcbQFKGUpXfIWVAoNx2h0j/Pd15CscVmtagOD3p5WMM1Hd6f89FcDqx8fcbrItA3boEMPald3GAyceGeyNjnD8qgVVaL3RTYeEOoImpajzebt9a2gFKwhBVldArwAg0+kruAWh0pIVwVahnMkO5EhEXPC72pt3+QDtoH8aBuhvjps3rKOlnery8n7fdxVaNjN+8RRt1kDvbcEnmmSbw2q3H6BiXXd8cr1ALbvfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjhBm9+gI6+sW7K+I0V4BLfqzqOTS5bI+PW2nMnzQe4=;
 b=oP+nDhv1HysEzYeWJygdhs1ZNdL7TJjbmQcnWYt1e8bLgL+KqoOxNzuMZCkFlVP5FfraF14JtmZuiCHU7e4uQhp2TlDan371EdtMwfCzL+UKBwN+U+6wbUq4QebhLJLyX0DokAi2KkfT2WVxgHiEpHu5GdNOZu0FGea8a6UhmtW6+MQnhuCTl/hL8rua/ozOme9UkCROVc8TiW8K1akBCeDcOiF1XK2uS/Z6f6faw4zQbjtLGVjIdG7zfnfrJOJ08J1JdYrVYQ01Q0w5SxGL7qb0NFlZaRbLf0B+N1iI2vbWnwvTFz6cuWs1x4IzLH5aErYwHNOKTj69MUxTV5TlXQ==
Received: from PH0PR07CA0106.namprd07.prod.outlook.com (2603:10b6:510:4::21)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 16:07:13 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::9a) by PH0PR07CA0106.outlook.office365.com
 (2603:10b6:510:4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 16:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:07:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:06:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:06:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:06:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next V2 3/6] net/mlx5e: Enable lanes configuration when auto-negotiation is off
Date: Tue, 4 Mar 2025 18:06:17 +0200
Message-ID: <20250304160620.417580-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250304160620.417580-1-tariqt@nvidia.com>
References: <20250304160620.417580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c8a589-fd42-4b4c-29a2-08dd5b369fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f72wg3r6bPqu9/ESlJY4YIZKuUMlDC1BxKz/XYkq8fEnEkORXe+mXoNd+dql?=
 =?us-ascii?Q?9QEQUVYxrIppOLcYE86/wEXUhG+j+eLwzYsgDiDTCxKFGjJqlUS5ZjyLpi66?=
 =?us-ascii?Q?d6DSA1VAF04kkN8K791pWcSkdUtI+8cuvSpYg5i/DbY+/XN7gz208UaNo/NZ?=
 =?us-ascii?Q?hg1Jgh58n70lq5PzZEIb4+/lc23m0f9UHsiC4Me/D3KHT07g5co5f7k2q0J5?=
 =?us-ascii?Q?q2ig91Hb8+jMP77jBYF0vPsf5HMRqRQ6GF+CUy+iSssi8tZhHa1mlCasPgbP?=
 =?us-ascii?Q?1awHWZpbYKpbdNF1uOnVIDJi5sM4eDy+ilBIBrYN4D013mXk3wh2YgQEWIni?=
 =?us-ascii?Q?M0d2gVws+r35uC8qoS+aJtKnSWx6Mjq0FKxvlz9nJITAarxKLyS09QHL0sAS?=
 =?us-ascii?Q?fpmgYTGKdIUHWtUVonp8ZTO4doaRzccunlejWWhrcmJp60PTRc/wDI/GTCAq?=
 =?us-ascii?Q?3PmRzrFJM8q+OvtASm77DFHLIol6HpBQXc+ewMySP+QBoN+p97rSse+xPodH?=
 =?us-ascii?Q?DAd4x+5yKaaMfjWUHKQxHEQ0qdEaOISUXZLxJ1Lu/Lc9YJQ/wsZ/k9suR2JN?=
 =?us-ascii?Q?VRzPn5++VyLYiO8t7RgEdYxBAHkKzrLZmuuh8PR+knNgWJD8y091PBiwUIqr?=
 =?us-ascii?Q?d279ch6yKxdhH2cdTfKPQz1ws1Goi0wjDYLW4Rjo7xHI2g5I9VPScwYV/f0i?=
 =?us-ascii?Q?9ikucxedlU2RnnNjH69mBxegIBTT05x3XdGUEvc4vyWQqbybfIA7dNsyiUsH?=
 =?us-ascii?Q?IwDWEXDV9q9kytKk6XW/UU5VC9HrwY8roDHgkTYwHc1pNM/grVgWOO65kog9?=
 =?us-ascii?Q?0NQweCKRcr4IRfgWJLa74yPRaTWqFLAm9Pd8aqMi7yel8RJ8aB5x3MVfWisM?=
 =?us-ascii?Q?mwS/zYr+I6oERib2m3CTVZ2bYtMvaDCQiIVexhy/t0DiFNUmtZx+DM146RJH?=
 =?us-ascii?Q?YtaY6NgtnlnQoShSZzAoAe0vYmiv4KnrJuYWIXdj4yEKEa67jT0TsL8KU7fG?=
 =?us-ascii?Q?wKrbIry5kfd5TfFFbRkdNDOT/62QRPiPUlVtljemhD/TQVJRWZp2tm11K87K?=
 =?us-ascii?Q?WlpGq2qGsqMbiNq2t9EHYbodoXq/EMzfNWbZHRcEQCvcTIupWIp3vmvSxSBC?=
 =?us-ascii?Q?eUyv0AuzfidD8PqFAuPyI/OfWjz5Va8rt+kLkIsP+tX15tsVpZhVuIfoXy/2?=
 =?us-ascii?Q?DHtLgVdixWd9sPFkH/48eUgatx6Jto/ix8asoRrLN9R8IYmzqcZ8pcjbG3wX?=
 =?us-ascii?Q?QgT+s0ZyGgxX6F8ahRg1QLucU8Pl4vvN+dJ6fWQ1Xq1P6iwU7lO1+3gp2tLt?=
 =?us-ascii?Q?zPSZ9hktEdIeDDOPaSjAyTQPA/ybzn5KB0hc5PHRhKjCPAOJnMeXYq/xzb3+?=
 =?us-ascii?Q?nIp1asf6+9gqD/IbkxPPi/qKw63j8Cc9MvffjuzBQfjGoULGUygXcB/JmPAa?=
 =?us-ascii?Q?Ys3ne+HO1JwgEWmIb+PPZTPVJHgx45kSaB4dvmqSVT9Nawei82By/5oiTN34?=
 =?us-ascii?Q?ztM0IoDSZT15NeU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:07:12.2981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c8a589-fd42-4b4c-29a2-08dd5b369fd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

From: Shahar Shitrit <shshitrit@nvidia.com>

Currently, when auto-negotiation is disabled, the driver retrieves
the speed and converts it into all link modes that correspond to
that speed. With this patch, we add the ability to set the number
of lanes, so that the combination of speed and lanes corresponds to
exactly one specific link mode for the extended bit map.

For the legacy bit map the driver sets all link modes correspond to
speed and lanes.

This change provides users with the option to set a specific link
mode, rather than enabling all link modes associated with a given
speed when auto-negotiation is off.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 23 +++--
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/port.c    | 98 ++++++++++---------
 3 files changed, 67 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index fdb3e118c244..fdf9e9bb99ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -42,6 +42,9 @@
 #include "lib/clock.h"
 #include "en/fs_ethtool.h"
 
+#define LANES_UNKNOWN		 0
+#define MAX_LANES		 8
+
 void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
 {
@@ -1076,15 +1079,16 @@ static void ptys2ethtool_supported_advertised_port(struct mlx5_core_dev *mdev,
 	}
 }
 
-static void get_speed_duplex(struct net_device *netdev,
-			     u32 eth_proto_oper, bool force_legacy,
-			     u16 data_rate_oper,
-			     struct ethtool_link_ksettings *link_ksettings)
+static void get_link_properties(struct net_device *netdev,
+				u32 eth_proto_oper, bool force_legacy,
+				u16 data_rate_oper,
+				struct ethtool_link_ksettings *link_ksettings)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	const struct mlx5_link_info *info;
 	u8 duplex = DUPLEX_UNKNOWN;
 	u32 speed = SPEED_UNKNOWN;
+	u32 lanes = LANES_UNKNOWN;
 
 	if (!netif_carrier_ok(netdev))
 		goto out;
@@ -1092,14 +1096,17 @@ static void get_speed_duplex(struct net_device *netdev,
 	info = mlx5_port_ptys2info(priv->mdev, eth_proto_oper, force_legacy);
 	if (info) {
 		speed = info->speed;
+		lanes = info->lanes;
 		duplex = DUPLEX_FULL;
 	} else if (data_rate_oper) {
 		speed = 100 * data_rate_oper;
+		lanes = MAX_LANES;
 	}
 
 out:
-	link_ksettings->base.speed = speed;
 	link_ksettings->base.duplex = duplex;
+	link_ksettings->base.speed = speed;
+	link_ksettings->lanes = lanes;
 }
 
 static void get_supported(struct mlx5_core_dev *mdev, u32 eth_proto_cap,
@@ -1236,8 +1243,8 @@ static int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
 	get_supported(mdev, eth_proto_cap, link_ksettings);
 	get_advertising(eth_proto_admin, tx_pause, rx_pause, link_ksettings,
 			admin_ext);
-	get_speed_duplex(priv->netdev, eth_proto_oper, !admin_ext,
-			 data_rate_oper, link_ksettings);
+	get_link_properties(priv->netdev, eth_proto_oper, !admin_ext,
+			    data_rate_oper, link_ksettings);
 
 	eth_proto_oper = eth_proto_oper ? eth_proto_oper : eth_proto_cap;
 	connector_type = connector_type < MLX5E_CONNECTOR_TYPE_NUMBER ?
@@ -1366,6 +1373,7 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	adver = link_ksettings->link_modes.advertising;
 	autoneg = link_ksettings->base.autoneg;
 	info.speed = link_ksettings->base.speed;
+	info.lanes = link_ksettings->lanes;
 
 	ext_supported = mlx5_ptys_ext_supported(mdev);
 	ext_requested = ext_link_mode_requested(adver);
@@ -2613,6 +2621,7 @@ static void mlx5e_get_ts_stats(struct net_device *netdev,
 }
 
 const struct ethtool_ops mlx5e_ethtool_ops = {
+	.cap_link_lanes_supported = true,
 	.cap_rss_ctx_supported	= true,
 	.rxfh_per_ctx_key	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 9639e44f71ed..2e02bdea8361 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -131,6 +131,7 @@ struct mlx5_module_eeprom_query_params {
 
 struct mlx5_link_info {
 	u32 speed;
+	u32 lanes;
 };
 
 static inline void mlx5_printk(struct mlx5_core_dev *dev, int level, const char *format, ...)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index e1b69416f391..549f1066d2a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1039,56 +1039,56 @@ int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio)
 
 /* speed in units of 1Mb */
 static const struct mlx5_link_info mlx5e_link_info[MLX5E_LINK_MODES_NUMBER] = {
-	[MLX5E_1000BASE_CX_SGMII] = {.speed = 1000},
-	[MLX5E_1000BASE_KX]       = {.speed = 1000},
-	[MLX5E_10GBASE_CX4]       = {.speed = 10000},
-	[MLX5E_10GBASE_KX4]       = {.speed = 10000},
-	[MLX5E_10GBASE_KR]        = {.speed = 10000},
-	[MLX5E_20GBASE_KR2]       = {.speed = 20000},
-	[MLX5E_40GBASE_CR4]       = {.speed = 40000},
-	[MLX5E_40GBASE_KR4]       = {.speed = 40000},
-	[MLX5E_56GBASE_R4]        = {.speed = 56000},
-	[MLX5E_10GBASE_CR]        = {.speed = 10000},
-	[MLX5E_10GBASE_SR]        = {.speed = 10000},
-	[MLX5E_10GBASE_ER]        = {.speed = 10000},
-	[MLX5E_40GBASE_SR4]       = {.speed = 40000},
-	[MLX5E_40GBASE_LR4]       = {.speed = 40000},
-	[MLX5E_50GBASE_SR2]       = {.speed = 50000},
-	[MLX5E_100GBASE_CR4]      = {.speed = 100000},
-	[MLX5E_100GBASE_SR4]      = {.speed = 100000},
-	[MLX5E_100GBASE_KR4]      = {.speed = 100000},
-	[MLX5E_100GBASE_LR4]      = {.speed = 100000},
-	[MLX5E_100BASE_TX]        = {.speed = 100},
-	[MLX5E_1000BASE_T]        = {.speed = 1000},
-	[MLX5E_10GBASE_T]         = {.speed = 10000},
-	[MLX5E_25GBASE_CR]        = {.speed = 25000},
-	[MLX5E_25GBASE_KR]        = {.speed = 25000},
-	[MLX5E_25GBASE_SR]        = {.speed = 25000},
-	[MLX5E_50GBASE_CR2]       = {.speed = 50000},
-	[MLX5E_50GBASE_KR2]       = {.speed = 50000},
+	[MLX5E_1000BASE_CX_SGMII]	= {.speed = 1000, .lanes = 1},
+	[MLX5E_1000BASE_KX]		= {.speed = 1000, .lanes = 1},
+	[MLX5E_10GBASE_CX4]		= {.speed = 10000, .lanes = 4},
+	[MLX5E_10GBASE_KX4]		= {.speed = 10000, .lanes = 4},
+	[MLX5E_10GBASE_KR]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_20GBASE_KR2]		= {.speed = 20000, .lanes = 2},
+	[MLX5E_40GBASE_CR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_40GBASE_KR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_56GBASE_R4]		= {.speed = 56000, .lanes = 4},
+	[MLX5E_10GBASE_CR]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_10GBASE_SR]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_10GBASE_ER]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_40GBASE_SR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_40GBASE_LR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_50GBASE_SR2]		= {.speed = 50000, .lanes = 2},
+	[MLX5E_100GBASE_CR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GBASE_SR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GBASE_KR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GBASE_LR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100BASE_TX]		= {.speed = 100, .lanes = 1},
+	[MLX5E_1000BASE_T]		= {.speed = 1000, .lanes = 1},
+	[MLX5E_10GBASE_T]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_25GBASE_CR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_25GBASE_KR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_25GBASE_SR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_50GBASE_CR2]		= {.speed = 50000, .lanes = 2},
+	[MLX5E_50GBASE_KR2]		= {.speed = 50000, .lanes = 2},
 };
 
 static const struct mlx5_link_info
 mlx5e_ext_link_info[MLX5E_EXT_LINK_MODES_NUMBER] = {
-	[MLX5E_SGMII_100M]			= {.speed = 100},
-	[MLX5E_1000BASE_X_SGMII]		= {.speed = 1000},
-	[MLX5E_5GBASE_R]			= {.speed = 5000},
-	[MLX5E_10GBASE_XFI_XAUI_1]		= {.speed = 10000},
-	[MLX5E_40GBASE_XLAUI_4_XLPPI_4]		= {.speed = 40000},
-	[MLX5E_25GAUI_1_25GBASE_CR_KR]		= {.speed = 25000},
-	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2] = {.speed = 50000},
-	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR]	= {.speed = 50000},
-	[MLX5E_CAUI_4_100GBASE_CR4_KR4]		= {.speed = 100000},
-	[MLX5E_100GAUI_2_100GBASE_CR2_KR2]	= {.speed = 100000},
-	[MLX5E_200GAUI_4_200GBASE_CR4_KR4]	= {.speed = 200000},
-	[MLX5E_400GAUI_8_400GBASE_CR8]		= {.speed = 400000},
-	[MLX5E_100GAUI_1_100GBASE_CR_KR]	= {.speed = 100000},
-	[MLX5E_200GAUI_2_200GBASE_CR2_KR2]	= {.speed = 200000},
-	[MLX5E_400GAUI_4_400GBASE_CR4_KR4]	= {.speed = 400000},
-	[MLX5E_800GAUI_8_800GBASE_CR8_KR8]	= {.speed = 800000},
-	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000},
-	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000},
-	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000},
+	[MLX5E_SGMII_100M]			= {.speed = 100, .lanes = 1},
+	[MLX5E_1000BASE_X_SGMII]		= {.speed = 1000, .lanes = 1},
+	[MLX5E_5GBASE_R]			= {.speed = 5000, .lanes = 1},
+	[MLX5E_10GBASE_XFI_XAUI_1]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_40GBASE_XLAUI_4_XLPPI_4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_25GAUI_1_25GBASE_CR_KR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2]	= {.speed = 50000, .lanes = 2},
+	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR]	= {.speed = 50000, .lanes = 1},
+	[MLX5E_CAUI_4_100GBASE_CR4_KR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GAUI_2_100GBASE_CR2_KR2]	= {.speed = 100000, .lanes = 2},
+	[MLX5E_200GAUI_4_200GBASE_CR4_KR4]	= {.speed = 200000, .lanes = 4},
+	[MLX5E_400GAUI_8_400GBASE_CR8]		= {.speed = 400000, .lanes = 8},
+	[MLX5E_100GAUI_1_100GBASE_CR_KR]	= {.speed = 100000, .lanes = 1},
+	[MLX5E_200GAUI_2_200GBASE_CR2_KR2]	= {.speed = 200000, .lanes = 2},
+	[MLX5E_400GAUI_4_400GBASE_CR4_KR4]	= {.speed = 400000, .lanes = 4},
+	[MLX5E_800GAUI_8_800GBASE_CR8_KR8]	= {.speed = 800000, .lanes = 8},
+	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000, .lanes = 1},
+	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000, .lanes = 2},
+	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000, .lanes = 4},
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
@@ -1168,8 +1168,10 @@ u32 mlx5_port_info2linkmodes(struct mlx5_core_dev *mdev,
 	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
 					  force_legacy);
 	for (i = 0; i < max_size; ++i) {
-		if (table[i].speed == info->speed)
-			link_modes |= MLX5E_PROT_MASK(i);
+		if (table[i].speed == info->speed) {
+			if (!info->lanes || table[i].lanes == info->lanes)
+				link_modes |= MLX5E_PROT_MASK(i);
+		}
 	}
 	return link_modes;
 }
-- 
2.45.0


