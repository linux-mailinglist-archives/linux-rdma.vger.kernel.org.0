Return-Path: <linux-rdma+bounces-8326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CA8A4E647
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA4461514
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7BE29B20E;
	Tue,  4 Mar 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uBkVU1BB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAB27C16B;
	Tue,  4 Mar 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104436; cv=fail; b=TYGrr7G4kRhsODC1b4nOF2elyF0o1r68IK0iCx9C3PUTVvOiyMTzZt7anCUvoA2QR2C4oBqVSAy79qeeRHPQXdxdaCf0cDsTVCGe1llGNQ5UjmXXywYkMAqIEOJIaT2+bQSpQpQsu02Daz8KOV/gDkbodPK8xfMZCq5AKBJ+jxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104436; c=relaxed/simple;
	bh=SlNLoELE3gs/Nz6JxMkXRQhNgDFO6fCfaSz0Ca7YZPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP65HQWW5hv3fuphrFAlZ4lgZdtQBj9jbYTvjKW1gjxF/8UAyb83KeBAKiVNVRaT6oOLE+wCHn66UIVRX97SdSYHseXc+wVKDjP3+s5rsJA3t1Hfj8c8IlSJMaMeJXqy+yFVvAftROmBJUNvaab7GTzjwvjayjI+gvvSueClwi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uBkVU1BB; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD1FqWk3equNbtzLHLlTGLu4TIGLAVN9b5VJbiO699zgSJVki+mfRJfNgAoqt2mzhRV0kEKdolNeMnKoulmW6Qae2g5YHLhrpnWYsOkEO/pCGs1xaaUV3E03bJtytLR4BS+8cxzZYs0/8ZCPzBomgLnLNkhCZsr39045LSpB8p6yuxkN6cpPKnKxLIML4nx0bIZ/0rgMxRYEgYPDFKGbRRflc7LHlj6vpvxxZKyqfLuiLMFnoDdYrDAsfXpL/1Hu/Nc28TFPwW+0/d//DLwB4fKpyRcTTMMTDs+6M/WGhwsOM5uYQpGQaLYOB/T/A/eUiNTx8CwErcNkkABnitRvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZdOHBweoAEgcj0PS07J+QCt2gQakssg1p9eshixQvA=;
 b=bdIUPKfn1ICcQrg7h1uJ0xEy7VJqBgDmWFqhYFS/OHeD372XYo2QofXPSsPOpCQ/niD9wTirPYlMDjkqunYfZTAmjjJuXtWO69N6iuzNMYZIC96mygzrcBTS2fCAdWOyqALeGcSlrCecyg70NIIkO06OS/jp9Uk9qE4+rv0Zi3kzDNfKVM1Yi08yfDoqTMMM39tR510yFuyAXxgaxPLJ8KLPZkBaAlA6imv1v8K5RgUHI1FyJ+ryeqg25bIV8vHFAUi2903Y7nOpyWHw5HMW9gXBn0dGBLAJzT2szYoNMnkoegp1bfiRw9UDLNHUPtsYR0yjNk5vLFawrF5k32wnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZdOHBweoAEgcj0PS07J+QCt2gQakssg1p9eshixQvA=;
 b=uBkVU1BBROtmJ/VzUx3/2CXlGrJ6IY0FjI54rHE1Vbxgf2Y8wGUNdaxzaXdq0VvNhrGVGvO6hbwDOflFm+oMNN65fETxtrdnLKnMuOO6eNbF4YYsSF5wpAA9diqImHjY82NX3UBqTU5NRzPUP4mV0tIl2Cj23g09c2AwO911/5Hh40X3/S4qQnt6LGoOjBCm8ylosQMV6EEHsvptlU5giUlAu5rQY5i2JcYcYp1/oQoPyw/gpbl3W9mt8HaM2iUyttQysRDtRWjsR3XfbjskN74+npPvqs8sEQW7HFx+WYqbVBZPmk8sxgbNpAtS94K3jtJBoSeklbQk+IJx+M2b9A==
Received: from SA0PR11CA0145.namprd11.prod.outlook.com (2603:10b6:806:131::30)
 by PH8PR12MB7422.namprd12.prod.outlook.com (2603:10b6:510:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 16:07:07 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::fc) by SA0PR11CA0145.outlook.office365.com
 (2603:10b6:806:131::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 16:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:07:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:06:49 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:06:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:06:45 -0800
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
Subject: [PATCH net-next V2 2/6] net/mlx5: Refactor link speed handling with mlx5_link_info struct
Date: Tue, 4 Mar 2025 18:06:16 +0200
Message-ID: <20250304160620.417580-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH8PR12MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: f886fab0-f721-42ba-d420-08dd5b369cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9Wv5Xaw5bhUjv26TThco0ChLji6v7s/H7KlJq8QuEbQ8Rya7XLacWADbZxz?=
 =?us-ascii?Q?Juq3kARIu89ZPzpmAxzPU+Lrl3b+eyIBx/ieXBDhm702oWnjkklJkdBlaKAS?=
 =?us-ascii?Q?Oqqa1oCwEBn9Vn20HU25SazP2AC93cVBHr47vS6gF9riXy6GpIVVi4USauoF?=
 =?us-ascii?Q?Ic45RnjWx7NaEpKAYBODT5S82+TWTmmOn7Jc5ByFeQxJG1vC5TWaaFOeWN6V?=
 =?us-ascii?Q?yyDlQmZl0ZBI+8+Gphg7mEA07oD0xQScYP8fVB4dgTA99IMTPRDBdFHFVujJ?=
 =?us-ascii?Q?gEZf7/Jj0ubi8BNoncN4xoNKxQ0bksd7GebSR9gD0F1bKzmMhXQym5tlVZrC?=
 =?us-ascii?Q?DuheTCY9zkWJ29J1Qv3cFVchljz0GKYYe2yHS20V6cNy0NxIQfdiEkJt4XjU?=
 =?us-ascii?Q?nUzN4fPOSl1PQx6zeK4gm6VCSyviL5OrIQwotIzICuzICHHHCm9JN7SQnZkW?=
 =?us-ascii?Q?OdzeDU6t7nIV3cXQy7JuVxvbt2BxHt4E8NtZJoEeEfzIa7IlNJ1e5t+NDPD0?=
 =?us-ascii?Q?quQriP+qNBydg5cNCJ6nvS41od4f/4lmIXH7IEqZkfyaB5SEprYCuM+BxESz?=
 =?us-ascii?Q?7aNryXjoXXyIFDNF8qt5uQ5F3bMLA+y6WJoee6kXmD1wckH8ziCK93LWijKL?=
 =?us-ascii?Q?WhCGtnFZZNcg8yZbCecme9GrC4lXorlOw1gYuJWHdm9m5Rp172Fmg574Mt1E?=
 =?us-ascii?Q?IKTr1s4JuvCzNhhSqfWnkpyMN2dgs0X9fzTf0vpvLwndPvI6SYTxsmMacnP/?=
 =?us-ascii?Q?701fOj8uNocim1sAvJo02l/akfni5ZG/1qwIQkRiZLJODpubO3LzCqeQd9iA?=
 =?us-ascii?Q?scKr43ALy7fce2W2c2fFg5FbgrCp1kDbAHG8W6tMfC+3ssoH2riTUkqn/LpL?=
 =?us-ascii?Q?JX3eCTLgymq7tTxDfnzZk7yJhpLRSMiFfhDo6jbVXz28M/hove5iraDJ3t67?=
 =?us-ascii?Q?0JcWcHz/uTan1ndQIT3MGsGOBsokJ5dEZy1Qoa5wkC6VFkWSXzyzn2CUXiEg?=
 =?us-ascii?Q?CwJ2tOShLftIfIVKO+vzrdA4V1abzA6iAMNvl7Jqx9Ep660dPJ/O3naBSthk?=
 =?us-ascii?Q?xD1ly85/hM8OumW0JNqiFEnfBwvUagEbAF5noYo9hm9LVY7CrcTsfYdP1VqC?=
 =?us-ascii?Q?DczIEpxzapXmLBKbWSF2rWIXUllDqNWYOLfzSTZCyYnEMS1LCIZxMQE3zTLj?=
 =?us-ascii?Q?96huXjqD4jlF0OOgbhENON6jEhCtyqsraUkCN9XFLtrDUrRJpVys4r4USqOf?=
 =?us-ascii?Q?WFdUeSO+Kn0s9k1wr1uJgqx8UprRTQ/H4FnAj7NABDDBL35zOK2hcrFdCB5p?=
 =?us-ascii?Q?yQO+YJM8JmU5OD1DOddazmpremIngFEaAZXcnt3uDFT7HL5yOnj3fdZJL1/X?=
 =?us-ascii?Q?qEAdHGzTnLIR+loCiaQbsjPHhxtpzCRSdQanyUYSZaILlKYXNMw6rW76/so0?=
 =?us-ascii?Q?gHCMMJab7R4IqwB2VttY3bFNsS8EA8dF+NJL4pMU3CSDZ/t2ps22s20o7cDI?=
 =?us-ascii?Q?BDIHQcAb4JeaNF4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:07:07.1709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f886fab0-f721-42ba-d420-08dd5b369cc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7422

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
index 3b2efde9dda2..fdb3e118c244 100644
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


