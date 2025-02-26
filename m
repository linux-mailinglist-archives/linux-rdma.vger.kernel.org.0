Return-Path: <linux-rdma+bounces-8131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B94A45DB8
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E751C1898577
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6176D221735;
	Wed, 26 Feb 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IkzJ52el"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02D4221700;
	Wed, 26 Feb 2025 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570540; cv=fail; b=bfuHR9NhxtZeikoWwOB/slHAO2uQlzajCDmC3I3BHH4cV4FcuKewctHUP6MyLJbkjkkJj2tbcHlq78FkRAvTyPUHy4NRFbA4GNVxgNr8r658aCwt73OwM4y0inVCVQ7MwJz2UZSmKJxO54NBl1sVfy5kp2O82jvfWwlGQlfC2Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570540; c=relaxed/simple;
	bh=bozRa3xyxpTSfv8qKO6e70XdL1M5BdNhQulNVX3D1C0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U14aLzfFELygJPx+msses9DNxVAYvVaENwqwiK21/uqfeNxO9c7hHg7F+kmD+m/bB+W6qINDmFy3EgW3I1hmadOa2SkPMKKqmL1ZOVnAxkMhcqeq5PPh/36ffVWrSlRvBJ5WmSmZH2LkmAboHuevq7R6niBktJaXgjo3rEjXUu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IkzJ52el; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2qLBEBTL8PyMsDTKw/IfYStFq+hZr1/PtJYfz3HpBf6R1aQuGugxol2cB2AfLgEeL2H0nzprpXQf61DMSSgSw724ROr6mzo3XYUsXQd6X4a0Tsv6h9fYY5klPLXi8vwtwFMyoflm7RQnaoAH4lyxHjtUHpBzq+AIMNtZDzNmgB9aSSKPGDA5n6v20M01L0GJBtonbMa9qvXDEKPpCnMlS1+wr5QUgH3Y92zzR4Rfgd3pZxn7Crp2a/50+/jM5PEUGkjmsTV7Y2tVZ+C55cRK4zA/fIh9nf6e/ellLY4kILKbGE7/BBXUmmU0YMsmkj2PvdtglUF/vOuNiF8qnVTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVEDnaZqJ2z+iD4hSMRRngSw6bi25NaqJMPfm08KM00=;
 b=oZxrA+eLFvDoN0rgpfvw8VDPEFSQ90lZROwrLfD7WCjvlBuXe61cpyOZMV/5aLD4j6OK7BTjtX6jWg3MdzBM2OjN0qULLO85iwRSkQg6OZcT/uh4zmUUvw/SlmZUtZ/NvHYaHMAAKHX1a0Hxj3M4e4z4c2icvhYtQhYGaTLfcQtvk5K2E0hT7YG2eDutXudwE8v1g5NBPaGQp3DR+UPgKRS36UoFMvTk9o1bH5gyNESdkml89PAqAXNm4LcOP9oOjZzBewDhM0t+CV/fvVFrsAiIRdeNnuaUgRtE9sR0FPmzL3QjrQjveARhpsZGo3hl86LvwbsKcpLP2h2e+uo0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVEDnaZqJ2z+iD4hSMRRngSw6bi25NaqJMPfm08KM00=;
 b=IkzJ52elDxLODhBjGi9rwJUb4kY2Y3Q9y1L2rGKgikBWeJvTiN4tStSGZfl+qCfz0eXld/iYzegtzM4xBBUerptW5vX0dnDE7u0oGAEzx/TK6k6Y5fp9ZRhnE3hctHYVzV8pwhM2hqzSREQXkrzGWIaghFQcy6YlOa5kVd3y+LEQc8ATUuhoIQggUT1YfH+FFaIqnQKoLxcZCoHZi0egP8qPa2ZlnE/BxUK/8nHrYKbi26XKXbQ6kyEMuBEnZ7ptUusLCmgwqpCYjtO37k6LX7TK7G6nzYxAFinsU0dfkU5DcEJbdgxK0XzU9baxULF3yLdGwtuLl1Y+D3P6Cp4Ouw==
Received: from SA1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::20)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:48:51 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::d7) by SA1P222CA0019.outlook.office365.com
 (2603:10b6:806:22c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 11:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:48:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:29 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 2/6] net/mlx5: Refactor link speed handling with mlx5_link_info struct
Date: Wed, 26 Feb 2025 13:47:48 +0200
Message-ID: <20250226114752.104838-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226114752.104838-1-tariqt@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 414f1dcc-d7a4-482b-eecc-08dd565b8972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4PSFDqW+utv9pWLuwLQsmivGnLNg/1qTvJCCwQDXGJkA3X5Dq5r9ksHXH0G+?=
 =?us-ascii?Q?g2X6fG5sWPqsHwvRyEwCtud2XiUTsaylqrUU2qyjKr3n15rOaMwKL1LsonMV?=
 =?us-ascii?Q?z1oQW07M1vPYNrElpAZDidnEWdmPwK06EmidvG4D/HZ8T2SIZERDfumdIQFv?=
 =?us-ascii?Q?yHUghzI904lTfHnNQAA7pSfon9ZF9wCxfHUcHB1z7u3RnsOMitLz8L9DiLJC?=
 =?us-ascii?Q?6kaHPxKWoqkOLR965SrEEYfUqwQKGEGiza+P9mNDlgigeqq616q1aTZ08/ca?=
 =?us-ascii?Q?utKR31RXjglhH1AtzeZQ/ApkTKroVIVrfDj93jbglUxSERb3lRk5rVHrpVfx?=
 =?us-ascii?Q?goIonVpGqVLjDpDY1ei2yoYPVLWuTaAiHyqVM7oR7+v3zLe0WKOU7zWTzslx?=
 =?us-ascii?Q?VggFxqSJIJFmVPYw0aiT8kCfOKScJ8lia2gDllEMWKTQ3l5qk3JB0EC48Fsn?=
 =?us-ascii?Q?tasjbCCPk7T/UkQyVr6O8A91FjPKCjPSzmIPb6T8dv+w3iNJ3n8zcRMBveIi?=
 =?us-ascii?Q?svb9nq4j3lwIXxZMuxHUJlo5ltGAcgv7aXEkrvQaXxHjmYLZikd4Q/rmnhwg?=
 =?us-ascii?Q?HbVZIbHVOdj+w0pkuwNSVXPOVYVx0VTzIo5XZU8UDPBH/T1VPIznjy3vbfOz?=
 =?us-ascii?Q?jDaBTi44YnkOeQpuFO27Rvb1QTPzJAU16X6zuZviRiJdubxHZxtuXRNGMERZ?=
 =?us-ascii?Q?LX9Q2hB3BcH+x9FZTH9AizmpZBzO/3NEO4ZgsxllrDTAXsnloYh+4NqhwABX?=
 =?us-ascii?Q?1m0ZZeR0dC/+LZvTOxNUCqLjYp8Ih5SxAnBh9VU64kx3Y+AjT+Y9MGfNF/Vx?=
 =?us-ascii?Q?yY5McQQ3MNVQW2Lpdy8NwaxMz4Pvaxn07hygN++GjoPdEAjcAdzIfxwWOAdC?=
 =?us-ascii?Q?04GLY54LAWLefzNpeUYndYxVd9jcLPTeni92CfGewm1TUx5dLRJTkwZn3lOz?=
 =?us-ascii?Q?p5lZ3uYXu+qKIVX/enUkigrS4fc4AlEi+UHhtF75L8jvZb5/O06BwtvBdjl9?=
 =?us-ascii?Q?RhriXWsqTYQ4gdMjRofQNRqcnxXyLmvtc7WKULCNBtsuAvAshRdcJM2yGNdC?=
 =?us-ascii?Q?0aHgYvfBUTQG5hMZjrs3vaQqYmvtCiPj/qnzIRaRG9zjkLpmvf6+3HZA0MSF?=
 =?us-ascii?Q?lRzl71jFkz+GfrnOVJ+4c4QV1yaFJUfrcd57nsUK5g8KzU2L3+uFdb4U977w?=
 =?us-ascii?Q?aEO2vXgSCzBMOJP4HSgEbS4ojCIi/E5or5EqZRlj/noxZqKMPRA7+agUos+q?=
 =?us-ascii?Q?U38SRrntcMdaM8CCAmciD+NCxZESTRIOFt0yMwoJxer5vhBKtg2qIkBKSulV?=
 =?us-ascii?Q?EAnlM+0rFlZHx4D3nhXiP2Xe8EagGwdiQwYS7PzJ6xzGqSYArttF6BTUZTSs?=
 =?us-ascii?Q?MwLFfshOWkR1tDH1k0P7RwVea8pSCnaTsyKPNk0SFruCNggK57AcFu0lVlUt?=
 =?us-ascii?Q?kUpOfH8lECAMRmnGu6zTKzcTL/GC8h7OE9gJyUE9xTv8pr8L+fZ9C5YDt43y?=
 =?us-ascii?Q?SB6DIXrT3+IQOcw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:48:50.3408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414f1dcc-d7a4-482b-eecc-08dd565b8972
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695

From: Shahar Shitrit <shshitrit@nvidia.com>

Introduce struct mlx5_link_info with a speed field and change the
types of mlx5e_link_speed and mlx5e_ext_link_speed from arrays of
u32 to arrays of struct mlx5_link_info. These arrays are renamed
to mlx5e_link_info and mlx5e_ext_link_info, respectively.

This change prepares for a future patch that will introduce a lanes
field in struct mlx5_link_info and add lanes mapping alongside the
speed for each link mode in the two arrays.

Additionally, rename function mlx5_port_speed2linkmodes() to
mlx5_port_info2linkmodes() and function mlx5_port_ptys2speed()
to mlx5_port_ptys2info() and update the speed parameter/return
type to struct mlx5_link_info, in preparation for the upcoming
patch where these functions will also utilize the lanes field.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/port.c |   9 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  24 ++-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  14 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    | 144 +++++++++---------
 4 files changed, 103 insertions(+), 88 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index f62fbfb67a1b..6049ccf475bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -80,6 +80,7 @@ int mlx5_port_set_eth_ptys(struct mlx5_core_dev *dev, bool an_disable,
 int mlx5e_port_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)
 {
 	struct mlx5_port_eth_proto eproto;
+	const struct mlx5_link_info *info;
 	bool force_legacy = false;
 	bool ext;
 	int err;
@@ -94,9 +95,13 @@ int mlx5e_port_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)
 		if (err)
 			goto out;
 	}
-	*speed = mlx5_port_ptys2speed(mdev, eproto.oper, force_legacy);
-	if (!(*speed))
+	info = mlx5_port_ptys2info(mdev, eproto.oper, force_legacy);
+	if (!info) {
+		*speed = SPEED_UNKNOWN;
 		err = -EINVAL;
+		goto out;
+	}
+	*speed = info->speed;
 
 out:
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 0cb515fa179f..9a1b1564228b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1082,23 +1082,21 @@ static void get_speed_duplex(struct net_device *netdev,
 			     struct ethtool_link_ksettings *link_ksettings)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
-	u32 speed = SPEED_UNKNOWN;
+	const struct mlx5_link_info *info;
 	u8 duplex = DUPLEX_UNKNOWN;
+	u32 speed = SPEED_UNKNOWN;
 
 	if (!netif_carrier_ok(netdev))
 		goto out;
 
-	speed = mlx5_port_ptys2speed(priv->mdev, eth_proto_oper, force_legacy);
-	if (!speed) {
-		if (data_rate_oper)
-			speed = 100 * data_rate_oper;
-		else
-			speed = SPEED_UNKNOWN;
-		goto out;
+	info = mlx5_port_ptys2info(priv->mdev, eth_proto_oper, force_legacy);
+	if (info) {
+		speed = info->speed;
+		duplex = DUPLEX_FULL;
+	} else if (data_rate_oper) {
+		speed = 100 * data_rate_oper;
 	}
 
-	duplex = DUPLEX_FULL;
-
 out:
 	link_ksettings->base.speed = speed;
 	link_ksettings->base.duplex = duplex;
@@ -1349,6 +1347,7 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5_port_eth_proto eproto;
+	struct mlx5_link_info info = {};
 	const unsigned long *adver;
 	bool an_changes = false;
 	u8 an_disable_admin;
@@ -1359,7 +1358,6 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	u32 link_modes;
 	u8 an_status;
 	u8 autoneg;
-	u32 speed;
 	bool ext;
 	int err;
 
@@ -1367,7 +1365,7 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 
 	adver = link_ksettings->link_modes.advertising;
 	autoneg = link_ksettings->base.autoneg;
-	speed = link_ksettings->base.speed;
+	info.speed = link_ksettings->base.speed;
 
 	ext_supported = mlx5_ptys_ext_supported(mdev);
 	ext_requested = ext_link_mode_requested(adver);
@@ -1384,7 +1382,7 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 		goto out;
 	}
 	link_modes = autoneg == AUTONEG_ENABLE ? ethtool2ptys_adver_func(adver) :
-		mlx5_port_speed2linkmodes(mdev, speed, !ext);
+		mlx5_port_info2linkmodes(mdev, &info, !ext);
 
 	err = mlx5e_speed_validate(priv->netdev, ext, link_modes, autoneg);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 6278b02105da..9639e44f71ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -129,6 +129,10 @@ struct mlx5_module_eeprom_query_params {
 	u32 module_number;
 };
 
+struct mlx5_link_info {
+	u32 speed;
+};
+
 static inline void mlx5_printk(struct mlx5_core_dev *dev, int level, const char *format, ...)
 {
 	struct device *device = dev->device;
@@ -359,10 +363,12 @@ int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
 			      struct mlx5_port_eth_proto *eproto);
 bool mlx5_ptys_ext_supported(struct mlx5_core_dev *mdev);
-u32 mlx5_port_ptys2speed(struct mlx5_core_dev *mdev, u32 eth_proto_oper,
-			 bool force_legacy);
-u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
-			      bool force_legacy);
+const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
+						 u32 eth_proto_oper,
+						 bool force_legacy);
+u32 mlx5_port_info2linkmodes(struct mlx5_core_dev *mdev,
+			     struct mlx5_link_info *info,
+			     bool force_legacy);
 int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);
 
 #define MLX5_PPS_CAP(mdev) (MLX5_CAP_GEN((mdev), pps) &&		\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index c7d749e8e133..e1b69416f391 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1038,56 +1038,57 @@ int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio)
 }
 
 /* speed in units of 1Mb */
-static const u32 mlx5e_link_speed[MLX5E_LINK_MODES_NUMBER] = {
-	[MLX5E_1000BASE_CX_SGMII] = 1000,
-	[MLX5E_1000BASE_KX]       = 1000,
-	[MLX5E_10GBASE_CX4]       = 10000,
-	[MLX5E_10GBASE_KX4]       = 10000,
-	[MLX5E_10GBASE_KR]        = 10000,
-	[MLX5E_20GBASE_KR2]       = 20000,
-	[MLX5E_40GBASE_CR4]       = 40000,
-	[MLX5E_40GBASE_KR4]       = 40000,
-	[MLX5E_56GBASE_R4]        = 56000,
-	[MLX5E_10GBASE_CR]        = 10000,
-	[MLX5E_10GBASE_SR]        = 10000,
-	[MLX5E_10GBASE_ER]        = 10000,
-	[MLX5E_40GBASE_SR4]       = 40000,
-	[MLX5E_40GBASE_LR4]       = 40000,
-	[MLX5E_50GBASE_SR2]       = 50000,
-	[MLX5E_100GBASE_CR4]      = 100000,
-	[MLX5E_100GBASE_SR4]      = 100000,
-	[MLX5E_100GBASE_KR4]      = 100000,
-	[MLX5E_100GBASE_LR4]      = 100000,
-	[MLX5E_100BASE_TX]        = 100,
-	[MLX5E_1000BASE_T]        = 1000,
-	[MLX5E_10GBASE_T]         = 10000,
-	[MLX5E_25GBASE_CR]        = 25000,
-	[MLX5E_25GBASE_KR]        = 25000,
-	[MLX5E_25GBASE_SR]        = 25000,
-	[MLX5E_50GBASE_CR2]       = 50000,
-	[MLX5E_50GBASE_KR2]       = 50000,
+static const struct mlx5_link_info mlx5e_link_info[MLX5E_LINK_MODES_NUMBER] = {
+	[MLX5E_1000BASE_CX_SGMII] = {.speed = 1000},
+	[MLX5E_1000BASE_KX]       = {.speed = 1000},
+	[MLX5E_10GBASE_CX4]       = {.speed = 10000},
+	[MLX5E_10GBASE_KX4]       = {.speed = 10000},
+	[MLX5E_10GBASE_KR]        = {.speed = 10000},
+	[MLX5E_20GBASE_KR2]       = {.speed = 20000},
+	[MLX5E_40GBASE_CR4]       = {.speed = 40000},
+	[MLX5E_40GBASE_KR4]       = {.speed = 40000},
+	[MLX5E_56GBASE_R4]        = {.speed = 56000},
+	[MLX5E_10GBASE_CR]        = {.speed = 10000},
+	[MLX5E_10GBASE_SR]        = {.speed = 10000},
+	[MLX5E_10GBASE_ER]        = {.speed = 10000},
+	[MLX5E_40GBASE_SR4]       = {.speed = 40000},
+	[MLX5E_40GBASE_LR4]       = {.speed = 40000},
+	[MLX5E_50GBASE_SR2]       = {.speed = 50000},
+	[MLX5E_100GBASE_CR4]      = {.speed = 100000},
+	[MLX5E_100GBASE_SR4]      = {.speed = 100000},
+	[MLX5E_100GBASE_KR4]      = {.speed = 100000},
+	[MLX5E_100GBASE_LR4]      = {.speed = 100000},
+	[MLX5E_100BASE_TX]        = {.speed = 100},
+	[MLX5E_1000BASE_T]        = {.speed = 1000},
+	[MLX5E_10GBASE_T]         = {.speed = 10000},
+	[MLX5E_25GBASE_CR]        = {.speed = 25000},
+	[MLX5E_25GBASE_KR]        = {.speed = 25000},
+	[MLX5E_25GBASE_SR]        = {.speed = 25000},
+	[MLX5E_50GBASE_CR2]       = {.speed = 50000},
+	[MLX5E_50GBASE_KR2]       = {.speed = 50000},
 };
 
-static const u32 mlx5e_ext_link_speed[MLX5E_EXT_LINK_MODES_NUMBER] = {
-	[MLX5E_SGMII_100M] = 100,
-	[MLX5E_1000BASE_X_SGMII] = 1000,
-	[MLX5E_5GBASE_R] = 5000,
-	[MLX5E_10GBASE_XFI_XAUI_1] = 10000,
-	[MLX5E_40GBASE_XLAUI_4_XLPPI_4] = 40000,
-	[MLX5E_25GAUI_1_25GBASE_CR_KR] = 25000,
-	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2] = 50000,
-	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR] = 50000,
-	[MLX5E_CAUI_4_100GBASE_CR4_KR4] = 100000,
-	[MLX5E_100GAUI_2_100GBASE_CR2_KR2] = 100000,
-	[MLX5E_200GAUI_4_200GBASE_CR4_KR4] = 200000,
-	[MLX5E_400GAUI_8_400GBASE_CR8] = 400000,
-	[MLX5E_100GAUI_1_100GBASE_CR_KR] = 100000,
-	[MLX5E_200GAUI_2_200GBASE_CR2_KR2] = 200000,
-	[MLX5E_400GAUI_4_400GBASE_CR4_KR4] = 400000,
-	[MLX5E_800GAUI_8_800GBASE_CR8_KR8] = 800000,
-	[MLX5E_200GAUI_1_200GBASE_CR1_KR1] = 200000,
-	[MLX5E_400GAUI_2_400GBASE_CR2_KR2] = 400000,
-	[MLX5E_800GAUI_4_800GBASE_CR4_KR4] = 800000,
+static const struct mlx5_link_info
+mlx5e_ext_link_info[MLX5E_EXT_LINK_MODES_NUMBER] = {
+	[MLX5E_SGMII_100M]			= {.speed = 100},
+	[MLX5E_1000BASE_X_SGMII]		= {.speed = 1000},
+	[MLX5E_5GBASE_R]			= {.speed = 5000},
+	[MLX5E_10GBASE_XFI_XAUI_1]		= {.speed = 10000},
+	[MLX5E_40GBASE_XLAUI_4_XLPPI_4]		= {.speed = 40000},
+	[MLX5E_25GAUI_1_25GBASE_CR_KR]		= {.speed = 25000},
+	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2] = {.speed = 50000},
+	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR]	= {.speed = 50000},
+	[MLX5E_CAUI_4_100GBASE_CR4_KR4]		= {.speed = 100000},
+	[MLX5E_100GAUI_2_100GBASE_CR2_KR2]	= {.speed = 100000},
+	[MLX5E_200GAUI_4_200GBASE_CR4_KR4]	= {.speed = 200000},
+	[MLX5E_400GAUI_8_400GBASE_CR8]		= {.speed = 400000},
+	[MLX5E_100GAUI_1_100GBASE_CR_KR]	= {.speed = 100000},
+	[MLX5E_200GAUI_2_200GBASE_CR2_KR2]	= {.speed = 200000},
+	[MLX5E_400GAUI_4_400GBASE_CR4_KR4]	= {.speed = 400000},
+	[MLX5E_800GAUI_8_800GBASE_CR8_KR8]	= {.speed = 800000},
+	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000},
+	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000},
+	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000},
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
@@ -1125,44 +1126,49 @@ bool mlx5_ptys_ext_supported(struct mlx5_core_dev *mdev)
 	return !!eproto.cap;
 }
 
-static void mlx5e_port_get_speed_arr(struct mlx5_core_dev *mdev,
-				     const u32 **arr, u32 *size,
-				     bool force_legacy)
+static void mlx5e_port_get_link_mode_info_arr(struct mlx5_core_dev *mdev,
+					      const struct mlx5_link_info **arr,
+					      u32 *size,
+					      bool force_legacy)
 {
 	bool ext = force_legacy ? false : mlx5_ptys_ext_supported(mdev);
 
-	*size = ext ? ARRAY_SIZE(mlx5e_ext_link_speed) :
-		      ARRAY_SIZE(mlx5e_link_speed);
-	*arr  = ext ? mlx5e_ext_link_speed : mlx5e_link_speed;
+	*size = ext ? ARRAY_SIZE(mlx5e_ext_link_info) :
+		      ARRAY_SIZE(mlx5e_link_info);
+	*arr  = ext ? mlx5e_ext_link_info : mlx5e_link_info;
 }
 
-u32 mlx5_port_ptys2speed(struct mlx5_core_dev *mdev, u32 eth_proto_oper,
-			 bool force_legacy)
+const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
+						 u32 eth_proto_oper,
+						 bool force_legacy)
 {
 	unsigned long temp = eth_proto_oper;
-	const u32 *table;
-	u32 speed = 0;
+	const struct mlx5_link_info *table;
 	u32 max_size;
 	int i;
 
-	mlx5e_port_get_speed_arr(mdev, &table, &max_size, force_legacy);
+	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
+					  force_legacy);
 	i = find_first_bit(&temp, max_size);
 	if (i < max_size)
-		speed = table[i];
-	return speed;
+		return &table[i];
+
+	return NULL;
 }
 
-u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
-			      bool force_legacy)
+u32 mlx5_port_info2linkmodes(struct mlx5_core_dev *mdev,
+			     struct mlx5_link_info *info,
+			     bool force_legacy)
 {
+	const struct mlx5_link_info *table;
 	u32 link_modes = 0;
-	const u32 *table;
 	u32 max_size;
 	int i;
 
-	mlx5e_port_get_speed_arr(mdev, &table, &max_size, force_legacy);
+	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
+					  force_legacy);
 	for (i = 0; i < max_size; ++i) {
-		if (table[i] == speed)
+		if (table[i].speed == info->speed)
 			link_modes |= MLX5E_PROT_MASK(i);
 	}
 	return link_modes;
@@ -1170,9 +1176,9 @@ u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
 
 int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)
 {
+	const struct mlx5_link_info *table;
 	struct mlx5_port_eth_proto eproto;
 	u32 max_speed = 0;
-	const u32 *table;
 	u32 max_size;
 	bool ext;
 	int err;
@@ -1183,10 +1189,10 @@ int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed)
 	if (err)
 		return err;
 
-	mlx5e_port_get_speed_arr(mdev, &table, &max_size, false);
+	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size, false);
 	for (i = 0; i < max_size; ++i)
 		if (eproto.cap & MLX5E_PROT_MASK(i))
-			max_speed = max(max_speed, table[i]);
+			max_speed = max(max_speed, table[i].speed);
 
 	*speed = max_speed;
 	return 0;
-- 
2.45.0


