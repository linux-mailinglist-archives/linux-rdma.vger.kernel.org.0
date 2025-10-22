Return-Path: <linux-rdma+bounces-13974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1ACBFBDC2
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 14:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818383A22C7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABA340A64;
	Wed, 22 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kWsXwHFu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB030274C;
	Wed, 22 Oct 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136260; cv=fail; b=AgWdpS21Wwb95BvHDLRO+eqYM3SV8Ad9vU1bMvIE64IISlj0yGOivnKPGwHHM/T26GfgHRE31wXQ24auqds7PX3tHiYIiv21IEw6mNxHJDdl5aWvTps5UERz8g9g16BW7eOKs6hV1WsQeGuIZiphwHIyaFqxJR2VvINP6eSOOjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136260; c=relaxed/simple;
	bh=O9ervebCr2wWwADwMhQ7JDhKeqKvJL7DLA058XSH51Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=km2wfCy0XCyGDkEXfcDxPe31C/Pam3jMkz5Us2/Z19o9Z6l/UuXrMi2mxYQX1OHYQzIAyVuJmcE5PxmPQW9WYqxtvgh/w6ZATT/2eboA35EX+M0rumBUC1uB3j3Jl+SN0ZLAECpaVJviSS1n416pDi8zh7xkLyIITX1NqG9RFKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kWsXwHFu; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEhezgeEDMviX1/0QUsyd7VhQ/Hge1gJD4Kl0F87DxkrUxAxtIUpivht5g1OmmugnIParyzDEgDEHnR/6Rb1YuazXcPcerR6JfR2r8C3HUIVRTEBben0QmTFHTMmVkCjZv2VD2EC4G6YHBB69fGzIU5DUsuPVDVenvR5jcFKGT0571lxIGXLeMjeiEWWFHwEVCobZ+2K/MMx9yiWWpmJz29BfQ+OjLpX7DmRpiCq2C+TextV/k31/exlNF3OhjDcLIUetBgCA7qYtHKSCIz89w1czzZ01qffHeTvEMbBM7Qj0cSej2rE3okEuwLO4z0Vx8QrJn3AcyJNGMR41FKcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1z/Uqtq0xMLD2EuGgv1AkCAKazb1JQ/IlQ9D3O2xkn0=;
 b=Hfx4z0UW+Pp56bQwniCXlIjV4U/D/EMObmFoFedPy9oRg1hVcPR3kogBC9A89dI9lnN0yYNsfRKEO53YqedbDlMkVymz+fTEuRfPYUytkT/4wYKX+Tw2RcdTpiBHw4pn6s8ESI+xeLV6avcU4rN4Ap3Mv4Zoe7cCPk+oS8WVk4k0zvBF/jx9laMYfVLiNpBK23geLy9F7ic+JTx5o9Dzdx1DN4HtGnIPzmN/YoRbbox2WNcIJFqT4rqOHzgVSxBUVUrFyVv6JEe6JKN9M9NP5+/rowSCJ8ooYTbVnjuNwngP1G8Zshx/mdbsVB4cuGwz0QCwnDh1jvtO0mRVgoNrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1z/Uqtq0xMLD2EuGgv1AkCAKazb1JQ/IlQ9D3O2xkn0=;
 b=kWsXwHFu5aABzJ/oZGfU4DgVr3DiQejKPiWgRW/bBsP+T+CER3IG0TuwnBpsYW03Xe24Z98tcS3KqAYiIOmpSmKqnW7UQCsQbTde4tEerUD7GKDS7mlHYEr0IGkN3H6GtexJSDcVC6NAr4dCuKU9ZwqezZvrLV8wOnmxUVi4kEeE2L6EX7wlnfwetMu8pYFZFnzWOoEhTtJoDOOdkme8UDQw4ySjKQyO6DGrB8+np3yCu5o48QTT/s0VMoTcY7ZDXNDhG0czrnTa8nbVOd1HmExOo81NZfcWziXHjwvDKvFFvXSo7Pt8M2omPVIctb7gby6zgOnNGxEzuuOfx3DbwQ==
Received: from DM6PR14CA0071.namprd14.prod.outlook.com (2603:10b6:5:18f::48)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:30:46 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::63) by DM6PR14CA0071.outlook.office365.com
 (2603:10b6:5:18f::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 12:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:30:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 05:30:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:30:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 05:30:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Patrisious
 Haddad" <phaddad@nvidia.com>
Subject: [PATCH net 3/4] net/mlx5: Refactor devcom to return NULL on failure
Date: Wed, 22 Oct 2025 15:29:41 +0300
Message-ID: <1761136182-918470-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
References: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1847c74c-3347-4c0f-dba1-08de1166d31f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lw4GV7xCZWQK14RbE9BXQ/fTPeWws2pFcROzRfsaaNKPhn62NO1KMwc0nLAy?=
 =?us-ascii?Q?AQHCntGQhtGAep4csPvRBe4cld8Fw/wxm8YdIUG6Jg3G2Q+sY9EYWpnpGUTC?=
 =?us-ascii?Q?QtyTD3TBcy9j8g7xI/9yKysYxcOgjz+Lb/1dd30Pj4MluC3Y4S6/pbkLE7un?=
 =?us-ascii?Q?n6KTcCawsy/8uMc7xP2GB/CWTkrf0REg6X/J+s0xwQAj7A8weY7+FZZd8m6R?=
 =?us-ascii?Q?7BFTvnqPf7c4SC6uzadUv9evdS89KEyKPuDTmTIno03s56gGSSQpApHcEOl+?=
 =?us-ascii?Q?nCbN2piEtQnM+nuMW8X9rvkN2fMMNRMmiKkwL0E6BfygL2lx9E7H6SNcr9tK?=
 =?us-ascii?Q?5UphgMD/jdlZEK5R9BW/UIIVbwlYQtInNdJS97QYemI6RHdkonDIaxZ/QqK0?=
 =?us-ascii?Q?IybwaCY+h8b/NMsRmX0tqrQuVVgC7TwqEnFGB/DJw211DbXVFvxZ/HopgAea?=
 =?us-ascii?Q?MuYzprF4022+kwCsj4bNW18HmS4RtOHbh/7PCz53LDIkZbCv9puolkfB5onw?=
 =?us-ascii?Q?DLqYqQqDno9iI3DvFwhQLXpKkE47XGIDEYQUYvut7mW+3BLrN+oCIJ3sPU3V?=
 =?us-ascii?Q?0QZ1WrkX+LcWyh+pqTOh/YtPU548oJ4s62iCCa4P93pX6e08WDnqQRm8aSIv?=
 =?us-ascii?Q?jzFL6rgL4KGKgFEyu6bW1JeEgixsPBBhIC2X9sU4IllXn6w+fK1E8Tb6UkZm?=
 =?us-ascii?Q?hPH4q7WE1PzuT3TJpHUMWIHRFRqWlafqPCsxHJJD8fkZeVmPms6K5SD/RzNh?=
 =?us-ascii?Q?6O3HLl5W+f2xE24bgvFNcZfLtQXbksZGhCe0rfUOU73chKXuxpSxwwfnhQdw?=
 =?us-ascii?Q?6JuXpIUmliUQHlYbeiPGN8d34mcfCQTWRxp730/SIMSw2YlMOW8ETVHd5+IX?=
 =?us-ascii?Q?YjYBWfVS+8bKhB31t2Hv7alHG86yS61eLBgijGv+3hg+AOBrPkZ9enQ500YP?=
 =?us-ascii?Q?uqrCJVKhhcGmaELWkPBIM1mv/KzrZb6s+WwnNL7sM1VdVEaLqIvKbgnVgfyE?=
 =?us-ascii?Q?oRag5P/1l1pao4oEX3x8dRcxp9fYIgSe9QdRSEmwYkSLVXSUTtR8dQe2hXv0?=
 =?us-ascii?Q?3kBq6S+btK21Urjr/t1r9sdjd+XeHMRiRUdD2qoJejqZQjRNMt7C8Bbz0uHL?=
 =?us-ascii?Q?JskioFhl4ZD8uqLmJbUBSpBrdP8a1KjafcEn050a5C4MugKO91qxcjBuw6Dj?=
 =?us-ascii?Q?aHeHAcfvzhEF1wf7Z0wsxHZth3rU8s+T1fxxPE14oI7n1jBs7X49OAF+tQMq?=
 =?us-ascii?Q?YwisYtjoWSNka+sZHOJj/QJicfVq9fwkHWyK6hLSW0/52GNdo7LRQqcG8EmZ?=
 =?us-ascii?Q?GkOW22MKWkcNrpEnF2/lkRQenkJBcCbkcY1c6YqxBN+PFjvNDtdDZdrGDW0Q?=
 =?us-ascii?Q?/Garn2ic/G48JOa+7a6agSGGIhm36If4J15GNXwp/YLoyUt1QIAuKiLN9SKt?=
 =?us-ascii?Q?zyIo2yRWdJCrtza12HFawildOLF3rE1YI2KlTOl0/OHe5ES5VfaI/T/vFU2G?=
 =?us-ascii?Q?lqVFhjkFMi+lgnZsShGQFsoQxGZmg603N5jaaFkwrLQfHX/yDlIf+lwqFYjK?=
 =?us-ascii?Q?aUBiFz4B9mj7u0QW/dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:30:45.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1847c74c-3347-4c0f-dba1-08de1166d31f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

From: Patrisious Haddad <phaddad@nvidia.com>

Devcom device and component registration isn't always critical to the
functionality of the caller, hence the registration can fail and we can
continue working with an ERR_PTR value saved inside a variable.

In order to avoid that make sure all devcom failures return NULL.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     |  4 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  7 ++-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 53 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  5 +-
 7 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a56825921c23..41fd5eee6306 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -242,8 +242,8 @@ static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
 						      &attr,
 						      mlx5e_devcom_event_mpv,
 						      priv);
-	if (IS_ERR(priv->devcom))
-		return PTR_ERR(priv->devcom);
+	if (!priv->devcom)
+		return -EINVAL;
 
 	if (mlx5_core_is_mp_master(priv->mdev)) {
 		mlx5_devcom_send_event(priv->devcom, MPV_DEVCOM_MASTER_UP,
@@ -256,7 +256,7 @@ static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
 
 static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
 {
-	if (IS_ERR_OR_NULL(priv->devcom))
+	if (!priv->devcom)
 		return;
 
 	if (mlx5_core_is_mp_master(priv->mdev)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4cf995be127d..34749814f19b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3129,7 +3129,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 						     attr,
 						     mlx5_esw_offloads_devcom_event,
 						     esw);
-	if (IS_ERR(esw->devcom))
+	if (!esw->devcom)
 		return;
 
 	mlx5_devcom_send_event(esw->devcom,
@@ -3140,7 +3140,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
 
 void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw)
 {
-	if (IS_ERR_OR_NULL(esw->devcom))
+	if (!esw->devcom)
 		return;
 
 	mlx5_devcom_send_event(esw->devcom,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 59c00c911275..3db0387bf6dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1430,11 +1430,10 @@ static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 		mlx5_devcom_register_component(dev->priv.devc,
 					       MLX5_DEVCOM_HCA_PORTS,
 					       &attr, NULL, dev);
-	if (IS_ERR(dev->priv.hca_devcom_comp)) {
+	if (!dev->priv.hca_devcom_comp) {
 		mlx5_core_err(dev,
-			      "Failed to register devcom HCA component, err: %ld\n",
-			      PTR_ERR(dev->priv.hca_devcom_comp));
-		return PTR_ERR(dev->priv.hca_devcom_comp);
+			      "Failed to register devcom HCA component.");
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index d0ba83d77cd1..29e7fa09c32c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1444,7 +1444,7 @@ static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
 	compd = mlx5_devcom_register_component(mdev->priv.devc,
 					       MLX5_DEVCOM_SHARED_CLOCK,
 					       &attr, NULL, mdev);
-	if (IS_ERR(compd))
+	if (!compd)
 		return;
 
 	mdev->clock_state->compdev = compd;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index faa2833602c8..e749618229bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -76,20 +76,18 @@ mlx5_devcom_dev_alloc(struct mlx5_core_dev *dev)
 struct mlx5_devcom_dev *
 mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 {
-	struct mlx5_devcom_dev *devc;
+	struct mlx5_devcom_dev *devc = NULL;
 
 	mutex_lock(&dev_list_lock);
 
 	if (devcom_dev_exists(dev)) {
-		devc = ERR_PTR(-EEXIST);
+		mlx5_core_err(dev, "devcom device already exists");
 		goto out;
 	}
 
 	devc = mlx5_devcom_dev_alloc(dev);
-	if (!devc) {
-		devc = ERR_PTR(-ENOMEM);
+	if (!devc)
 		goto out;
-	}
 
 	list_add_tail(&devc->list, &devcom_dev_list);
 out:
@@ -110,8 +108,10 @@ mlx5_devcom_dev_release(struct kref *ref)
 
 void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc)
 {
-	if (!IS_ERR_OR_NULL(devc))
-		kref_put(&devc->ref, mlx5_devcom_dev_release);
+	if (!devc)
+		return;
+
+	kref_put(&devc->ref, mlx5_devcom_dev_release);
 }
 
 static struct mlx5_devcom_comp *
@@ -122,7 +122,7 @@ mlx5_devcom_comp_alloc(u64 id, const struct mlx5_devcom_match_attr *attr,
 
 	comp = kzalloc(sizeof(*comp), GFP_KERNEL);
 	if (!comp)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	comp->id = id;
 	comp->key.key = attr->key;
@@ -160,7 +160,7 @@ devcom_alloc_comp_dev(struct mlx5_devcom_dev *devc,
 
 	devcom = kzalloc(sizeof(*devcom), GFP_KERNEL);
 	if (!devcom)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	kref_get(&devc->ref);
 	devcom->devc = devc;
@@ -240,31 +240,28 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       mlx5_devcom_event_handler_t handler,
 			       void *data)
 {
-	struct mlx5_devcom_comp_dev *devcom;
+	struct mlx5_devcom_comp_dev *devcom = NULL;
 	struct mlx5_devcom_comp *comp;
 
-	if (IS_ERR_OR_NULL(devc))
-		return ERR_PTR(-EINVAL);
+	if (!devc)
+		return NULL;
 
 	mutex_lock(&comp_list_lock);
 	comp = devcom_component_get(devc, id, attr, handler);
-	if (IS_ERR(comp)) {
-		devcom = ERR_PTR(-EINVAL);
+	if (IS_ERR(comp))
 		goto out_unlock;
-	}
 
 	if (!comp) {
 		comp = mlx5_devcom_comp_alloc(id, attr, handler);
-		if (IS_ERR(comp)) {
-			devcom = ERR_CAST(comp);
+		if (!comp)
 			goto out_unlock;
-		}
+
 		list_add_tail(&comp->comp_list, &devcom_comp_list);
 	}
 	mutex_unlock(&comp_list_lock);
 
 	devcom = devcom_alloc_comp_dev(devc, comp, data);
-	if (IS_ERR(devcom))
+	if (!devcom)
 		kref_put(&comp->ref, mlx5_devcom_comp_release);
 
 	return devcom;
@@ -276,8 +273,10 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 
 void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom)
 {
-	if (!IS_ERR_OR_NULL(devcom))
-		devcom_free_comp_dev(devcom);
+	if (!devcom)
+		return;
+
+	devcom_free_comp_dev(devcom);
 }
 
 int mlx5_devcom_comp_get_size(struct mlx5_devcom_comp_dev *devcom)
@@ -296,7 +295,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 	int err = 0;
 	void *data;
 
-	if (IS_ERR_OR_NULL(devcom))
+	if (!devcom)
 		return -ENODEV;
 
 	comp = devcom->comp;
@@ -338,7 +337,7 @@ void mlx5_devcom_comp_set_ready(struct mlx5_devcom_comp_dev *devcom, bool ready)
 
 bool mlx5_devcom_comp_is_ready(struct mlx5_devcom_comp_dev *devcom)
 {
-	if (IS_ERR_OR_NULL(devcom))
+	if (!devcom)
 		return false;
 
 	return READ_ONCE(devcom->comp->ready);
@@ -348,7 +347,7 @@ bool mlx5_devcom_for_each_peer_begin(struct mlx5_devcom_comp_dev *devcom)
 {
 	struct mlx5_devcom_comp *comp;
 
-	if (IS_ERR_OR_NULL(devcom))
+	if (!devcom)
 		return false;
 
 	comp = devcom->comp;
@@ -421,21 +420,21 @@ void *mlx5_devcom_get_next_peer_data_rcu(struct mlx5_devcom_comp_dev *devcom,
 
 void mlx5_devcom_comp_lock(struct mlx5_devcom_comp_dev *devcom)
 {
-	if (IS_ERR_OR_NULL(devcom))
+	if (!devcom)
 		return;
 	down_write(&devcom->comp->sem);
 }
 
 void mlx5_devcom_comp_unlock(struct mlx5_devcom_comp_dev *devcom)
 {
-	if (IS_ERR_OR_NULL(devcom))
+	if (!devcom)
 		return;
 	up_write(&devcom->comp->sem);
 }
 
 int mlx5_devcom_comp_trylock(struct mlx5_devcom_comp_dev *devcom)
 {
-	if (IS_ERR_OR_NULL(devcom))
+	if (!devcom)
 		return 0;
 	return down_write_trylock(&devcom->comp->sem);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index f5c2701f6e87..8e17daae48af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -221,8 +221,8 @@ static int sd_register(struct mlx5_core_dev *dev)
 	attr.net = mlx5_core_net(dev);
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
 						&attr, NULL, dev);
-	if (IS_ERR(devcom))
-		return PTR_ERR(devcom);
+	if (!devcom)
+		return -EINVAL;
 
 	sd->devcom = devcom;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index df93625c9dfa..70c156591b0b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -978,9 +978,8 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	int err;
 
 	dev->priv.devc = mlx5_devcom_register_device(dev);
-	if (IS_ERR(dev->priv.devc))
-		mlx5_core_warn(dev, "failed to register devcom device %pe\n",
-			       dev->priv.devc);
+	if (!dev->priv.devc)
+		mlx5_core_warn(dev, "failed to register devcom device\n");
 
 	err = mlx5_query_board_id(dev);
 	if (err) {
-- 
2.31.1


