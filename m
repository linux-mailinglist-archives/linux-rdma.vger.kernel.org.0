Return-Path: <linux-rdma+bounces-8328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D838A4E62A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD125421622
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2528F294EFF;
	Tue,  4 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="huZiYZIg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54E2BE7A7;
	Tue,  4 Mar 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104442; cv=fail; b=kuIrZb+CMTKSGrruuGsoZPIhXkOOoUtW+RPXa3CfVJX2k8D606fEU91CKSsGpsKfnMTraKwxZj/TH2oRASMvvkBcWwu0qKVrZeAD2gUR5fO0jGdbGZLBuIiI09EhAe5eL12R90GCWbnKAkTJ++YJ3VXV/MI8Mfar5+wBR4uPwF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104442; c=relaxed/simple;
	bh=+XudvtuxzUdeogYleIuKC7DDmnWM+v1m+TVG1pAapns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRkF9tgLUl+wPg2l3x/n4ueHiesl4xq8xydu67A7G28NtYD5eA9/zqQk33yvC1bAob5xJeixwuxVeVD8f80LKFEnsuI5lmC5SRAWghwZ/iUSO6saC7JwrSjHtiVrERxEq0aAFyQy4zrtoM/m/H14xb9jCEuXLY+PpmX7glwq8Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=huZiYZIg; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuTNn+wq18ksW1pRJXw0NZV8xkT3OVHpAgQOKOluogMNJ8lYEBFTaBAn2J9eNofdDfgE8hkEz1SzLFdn+mvd7e8GnVwQ8f0MIa8xH+onboyHSfgJll+Wjlwcm4Nd07RJwRyue/bx+k7rVcs0MZ9Wa9NO58C9j29jgW31lB43TzGEa4AAhtXu9peLMjgOCE9sXiHnKR3XBtUg/RbMtZnkt3oeuXKn3z/QiN2oBFHhh0okih5Sz2PekVgILrdXcbFlJ2DaW7/GfFnMOoRhiGIqtO0hSTtwS3U6BcgVxRpavAW0oM4HCUydbbtZdyX55/PGvi+GoC42CHcB9gOEgkHrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Hjc1OiZDHth5ka0W/kv9M1PqZ9d1IlHPKaxIhl2Ls=;
 b=BUky41+POs7Nra/Jg3KWcUaqliJkahKOy1BwdDXQFHuDrOqnlq7OiyTmJipMyG+SGzKu5ZAT77RbT76eB5b2Leo4H2yrno78Gxb6GLnodbZUvqSjdlLE7HvH46Q+yUIig3MNWJ9FApEqlUVFp/hr0C6/mvdCveeWV37NimYdPVZJMBY6ca7gkvYo7pPciAC4/Uv5bUo+GTS10ef9ZDrh4gInJJYrc0AeFu+y8tG4a/D+4oJpg9OQlwAjT3a/i3lBPJY1eRt9NckwFOkX1v60xWnq0Lf6rwahlipC0pbDUCM6ZIfZmqWpi68Kqqls4eZ3AWXZI0Yy7Y2gc6lzGlndYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Hjc1OiZDHth5ka0W/kv9M1PqZ9d1IlHPKaxIhl2Ls=;
 b=huZiYZIgh4Jo84HdPrGeFoK0Cl4JJ6KNJy0A+oMWEXpEOuGuTUE8TNdqf37JLwqmwQthMA58hUumT+3oZCZ2IfNfgbJ3HpryqljN7DWZw1etBEz9a1ckbr8B1SvKgrTMYBWT6Je5W+jtVigyk19U8+dBVNqm/fB6xzQ8EImWcQXoQzWhg78ZVGYm7JOELxD3EGX5X9k5rMbrkWtt9Cjmg8ohqLlcXKpJIAZndyy2YhJjWVkvfDl/wj2ujtnbxhjKTZ7NbhxGau1EMolPJkMCW/6yWk4+5OAmdwALUl2TtVa5g878qCDVVsyIgDA4HzKweV/utHd++LmPwDzFfgbcUA==
Received: from CY5PR22CA0022.namprd22.prod.outlook.com (2603:10b6:930:16::35)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:07:09 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::7e) by CY5PR22CA0022.outlook.office365.com
 (2603:10b6:930:16::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 16:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:07:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:06:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:06:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:06:41 -0800
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
Subject: [PATCH net-next V2 1/6] net/mlx5: Relocate function declarations from port.h to mlx5_core.h
Date: Tue, 4 Mar 2025 18:06:15 +0200
Message-ID: <20250304160620.417580-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: afaa6869-5bb0-4618-2a06-08dd5b369d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/giiSI0UDm8DFkkIGSGcJPUWzdmFBgo9kHMq4Cc2A36wiowMGx8Dd9pifsbn?=
 =?us-ascii?Q?hgd7WvZHqFzH8oVlewYbWlxkr8IxD5VbUvLSYUeXH4K3g22WMwbQROhjdZaY?=
 =?us-ascii?Q?XuQ2i1VebT/jlviR8Vj7GWotOM7sfcD7YNSSBvVP/lE2SoJDjlkeMWbyJq3u?=
 =?us-ascii?Q?eBb9R6VcsImgfySgRKDdv+wGgZOYe6OgaKjkiOFJg2wWYdkVLpT6FTcvD+Qw?=
 =?us-ascii?Q?y8HCbt0NZg8/8SPWUHXm2JoOPldeulVvk5ZC9MJg3P1HJ0oOfb4ydjJsI+em?=
 =?us-ascii?Q?Oz3bRHCi/nYBU/4oH6JV0uzGXnFTbhPwSKVW46FYTVlbmCwDfY5+LQLDjc4U?=
 =?us-ascii?Q?VmdBDjqAUYwK4TaIuho/oP4Iti6p7QSDJmbisuabaHXEOMhR7+dMh6ZjVzq9?=
 =?us-ascii?Q?CIW45esY9QPmnwvXn8dUbjVLUw7TVXy+hjyVLIbdNMLDyMnxG0f7IFyksnrI?=
 =?us-ascii?Q?XGso8CIQP51VfDtX3AdqB3i4kpuYV7rBLlJSZ20XR45iyi8MIUYuBXWn8J0n?=
 =?us-ascii?Q?a3CMIofbn3G2h3YILLv/cF+NJkFENksbNyb+7dwyVVsw+xKxAL2AhjeEPx5T?=
 =?us-ascii?Q?htf7q81IcxEkOtdBic1DW8+/2V4HLwPwflGMY3Rlgn2Wi1gWHbHzP1DwSZLY?=
 =?us-ascii?Q?KTdqNbmpAO5/3FkaaAarCBEs8ricXP60CBkQyCh1RSTID0tA4OPVGzrDBK76?=
 =?us-ascii?Q?fMpktnFONCHipqIUGZOdNGlRq/rQmUtAilaJqR4vzgY4J1HmlvNsjMksDYyH?=
 =?us-ascii?Q?roZE/PuuYwzwCKGw1Ijy28FyjWs1X+PMPZ9OdEipv+vezhbSOh7vWLpGQI/U?=
 =?us-ascii?Q?329A6Cep2AEnjza6XlVPYRJ5CnthsHDVscAFmW6y1i+onJITBdZURJZTQT9t?=
 =?us-ascii?Q?zqd8B5Um2h8SV2xWw8blf4rHaovNgraFRlQK/04NN+/NwMdOpdjZMmoMPWAk?=
 =?us-ascii?Q?JcSWDe2G9OPgvy4uSeek/7hXiGBBTZ9Beoa0iYHJmSG8mJKUyfyaPDpH9rI2?=
 =?us-ascii?Q?oh8jdxBjvxpqzpUWJDD3A2nuh4rZr5hCnU7qnhserg3YY3qzmH9d5kwGMe46?=
 =?us-ascii?Q?xgWazTANaUSEnHOFHECdP8dL/HJ4tzxEe3GIEUlDWa2TuCvjrV0aaIGSD4o7?=
 =?us-ascii?Q?Z9R7IE8nSDoe1R7Qsfs+rP5ROKMQhPWTemgOMHZEDNK5NOxNvTirF9DJye8S?=
 =?us-ascii?Q?qZsc+reK9r3sl716W+SUPfLjLazYMwLQRUySHJJW4uQSXfxjTeYrUYSbymsa?=
 =?us-ascii?Q?FURiMq45VfI3tJXawmNU6ILuDRNbA3NZHxgo9DCS2/KdpQgTrv+IwMK+lu7D?=
 =?us-ascii?Q?7wYRIohFlv5TQo6/oOnTYq6qQvU75iaoHGZuzWiw1OcIt07ukQ3yWGf6BF3v?=
 =?us-ascii?Q?kfCIEodrEM6bwt7XQIh2ac2oOwSAyU8aHUQgDN4VJVsiPZlt6FA+d08m5Mtd?=
 =?us-ascii?Q?6U5VqwEVzrt2gUUvKtPPj5eCsdWgjwgZELibC+1B0IS3OvOSpDCyVcFcl6GR?=
 =?us-ascii?Q?aEAJ+8a8hWlgTow=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:07:08.3639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afaa6869-5bb0-4618-2a06-08dd5b369d8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

From: Shahar Shitrit <shshitrit@nvidia.com>

The port header is a general file under include, yet it
contains declarations for functions that are either not
exported or exported but not used outside the mlx5_core
driver.

To enhance code organization, we move these declarations
to mlx5_core.h, where they are more appropriately scoped.

This refactor removes unnecessary exported symbols and
prevents unexported functions from being inadvertently
referenced outside of the mlx5_core driver.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   | 85 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/port.c    | 20 -----
 include/linux/mlx5/port.h                     | 85 +------------------
 3 files changed, 86 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 6fef1005c469..6278b02105da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -114,6 +114,21 @@ struct mlx5_cmd_alias_obj_create_attr {
 	u8 access_key[ACCESS_KEY_LEN];
 };
 
+struct mlx5_port_eth_proto {
+	u32 cap;
+	u32 admin;
+	u32 oper;
+};
+
+struct mlx5_module_eeprom_query_params {
+	u16 size;
+	u16 offset;
+	u16 i2c_address;
+	u32 page;
+	u32 bank;
+	u32 module_number;
+};
+
 static inline void mlx5_printk(struct mlx5_core_dev *dev, int level, const char *format, ...)
 {
 	struct device *device = dev->device;
@@ -280,6 +295,76 @@ int mlx5_set_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 arm, u8 mode);
 struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev);
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev);
 
+void mlx5_toggle_port_link(struct mlx5_core_dev *dev);
+int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
+			       enum mlx5_port_status status);
+int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
+				 enum mlx5_port_status *status);
+int mlx5_set_port_beacon(struct mlx5_core_dev *dev, u16 beacon_duration);
+
+int mlx5_set_port_mtu(struct mlx5_core_dev *dev, u16 mtu, u8 port);
+int mlx5_set_port_pause(struct mlx5_core_dev *dev, u32 rx_pause, u32 tx_pause);
+int mlx5_query_port_pause(struct mlx5_core_dev *dev,
+			  u32 *rx_pause, u32 *tx_pause);
+
+int mlx5_set_port_pfc(struct mlx5_core_dev *dev, u8 pfc_en_tx, u8 pfc_en_rx);
+int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx,
+			u8 *pfc_en_rx);
+
+int mlx5_set_port_stall_watermark(struct mlx5_core_dev *dev,
+				  u16 stall_critical_watermark,
+				  u16 stall_minor_watermark);
+int mlx5_query_port_stall_watermark(struct mlx5_core_dev *dev,
+				    u16 *stall_critical_watermark,
+				    u16 *stall_minor_watermark);
+
+int mlx5_max_tc(struct mlx5_core_dev *mdev);
+int mlx5_set_port_prio_tc(struct mlx5_core_dev *mdev, u8 *prio_tc);
+int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
+			    u8 prio, u8 *tc);
+int mlx5_set_port_tc_group(struct mlx5_core_dev *mdev, u8 *tc_group);
+int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
+			     u8 tc, u8 *tc_group);
+int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw);
+int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
+				u8 tc, u8 *bw_pct);
+int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
+				    u8 *max_bw_value,
+				    u8 *max_bw_unit);
+int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
+				   u8 *max_bw_value,
+				   u8 *max_bw_unit);
+int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode);
+int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode);
+
+int mlx5_query_ports_check(struct mlx5_core_dev *mdev, u32 *out, int outlen);
+int mlx5_set_ports_check(struct mlx5_core_dev *mdev, u32 *in, int inlen);
+int mlx5_set_port_fcs(struct mlx5_core_dev *mdev, u8 enable);
+void mlx5_query_port_fcs(struct mlx5_core_dev *mdev, bool *supported,
+			 bool *enabled);
+int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
+			     u16 offset, u16 size, u8 *data);
+int
+mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
+				 struct mlx5_module_eeprom_query_params *params,
+				 u8 *data);
+
+int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
+int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
+int mlx5_set_trust_state(struct mlx5_core_dev *mdev, u8 trust_state);
+int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state);
+int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio);
+int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
+
+int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
+			      struct mlx5_port_eth_proto *eproto);
+bool mlx5_ptys_ext_supported(struct mlx5_core_dev *mdev);
+u32 mlx5_port_ptys2speed(struct mlx5_core_dev *mdev, u32 eth_proto_oper,
+			 bool force_legacy);
+u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
+			      bool force_legacy);
+int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);
+
 #define MLX5_PPS_CAP(mdev) (MLX5_CAP_GEN((mdev), pps) &&		\
 			    MLX5_CAP_GEN((mdev), pps_modify) &&		\
 			    MLX5_CAP_MCAM_FEATURE((mdev), mtpps_fs) &&	\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 3995df064101..c7d749e8e133 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -196,7 +196,6 @@ void mlx5_toggle_port_link(struct mlx5_core_dev *dev)
 	if (ps == MLX5_PORT_UP)
 		mlx5_set_port_admin_status(dev, MLX5_PORT_UP);
 }
-EXPORT_SYMBOL_GPL(mlx5_toggle_port_link);
 
 int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
 			       enum mlx5_port_status status)
@@ -210,7 +209,6 @@ int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				    sizeof(out), MLX5_REG_PAOS, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_admin_status);
 
 int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
 				 enum mlx5_port_status *status)
@@ -227,7 +225,6 @@ int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
 	*status = MLX5_GET(paos_reg, out, admin_status);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_admin_status);
 
 static void mlx5_query_port_mtu(struct mlx5_core_dev *dev, u16 *admin_mtu,
 				u16 *max_mtu, u16 *oper_mtu, u8 port)
@@ -257,7 +254,6 @@ int mlx5_set_port_mtu(struct mlx5_core_dev *dev, u16 mtu, u8 port)
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				   sizeof(out), MLX5_REG_PMTU, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_mtu);
 
 void mlx5_query_port_max_mtu(struct mlx5_core_dev *dev, u16 *max_mtu,
 			     u8 port)
@@ -447,7 +443,6 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 
 	return mlx5_query_mcia(dev, &query, data);
 }
-EXPORT_SYMBOL_GPL(mlx5_query_module_eeprom);
 
 int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 				     struct mlx5_module_eeprom_query_params *params,
@@ -467,7 +462,6 @@ int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 
 	return mlx5_query_mcia(dev, params, data);
 }
-EXPORT_SYMBOL_GPL(mlx5_query_module_eeprom_by_page);
 
 static int mlx5_query_port_pvlc(struct mlx5_core_dev *dev, u32 *pvlc,
 				int pvlc_size,  u8 local_port)
@@ -518,7 +512,6 @@ int mlx5_set_port_pause(struct mlx5_core_dev *dev, u32 rx_pause, u32 tx_pause)
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				    sizeof(out), MLX5_REG_PFCC, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_pause);
 
 int mlx5_query_port_pause(struct mlx5_core_dev *dev,
 			  u32 *rx_pause, u32 *tx_pause)
@@ -538,7 +531,6 @@ int mlx5_query_port_pause(struct mlx5_core_dev *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_pause);
 
 int mlx5_set_port_stall_watermark(struct mlx5_core_dev *dev,
 				  u16 stall_critical_watermark,
@@ -597,7 +589,6 @@ int mlx5_set_port_pfc(struct mlx5_core_dev *dev, u8 pfc_en_tx, u8 pfc_en_rx)
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				    sizeof(out), MLX5_REG_PFCC, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_pfc);
 
 int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx, u8 *pfc_en_rx)
 {
@@ -616,7 +607,6 @@ int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx, u8 *pfc_en_rx)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_pfc);
 
 int mlx5_max_tc(struct mlx5_core_dev *mdev)
 {
@@ -667,7 +657,6 @@ int mlx5_set_port_prio_tc(struct mlx5_core_dev *mdev, u8 *prio_tc)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_prio_tc);
 
 int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
 			    u8 prio, u8 *tc)
@@ -689,7 +678,6 @@ int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_prio_tc);
 
 static int mlx5_set_port_qetcr_reg(struct mlx5_core_dev *mdev, u32 *in,
 				   int inlen)
@@ -728,7 +716,6 @@ int mlx5_set_port_tc_group(struct mlx5_core_dev *mdev, u8 *tc_group)
 
 	return mlx5_set_port_qetcr_reg(mdev, in, sizeof(in));
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_tc_group);
 
 int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
 			     u8 tc, u8 *tc_group)
@@ -749,7 +736,6 @@ int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_tc_group);
 
 int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw)
 {
@@ -763,7 +749,6 @@ int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw)
 
 	return mlx5_set_port_qetcr_reg(mdev, in, sizeof(in));
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_tc_bw_alloc);
 
 int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 				u8 tc, u8 *bw_pct)
@@ -784,7 +769,6 @@ int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_tc_bw_alloc);
 
 int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 				    u8 *max_bw_value,
@@ -808,7 +792,6 @@ int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 
 	return mlx5_set_port_qetcr_reg(mdev, in, sizeof(in));
 }
-EXPORT_SYMBOL_GPL(mlx5_modify_port_ets_rate_limit);
 
 int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 				   u8 *max_bw_value,
@@ -834,7 +817,6 @@ int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_ets_rate_limit);
 
 int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode)
 {
@@ -845,7 +827,6 @@ int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode)
 	MLX5_SET(set_wol_rol_in, in, wol_mode, wol_mode);
 	return mlx5_cmd_exec_in(mdev, set_wol_rol, in);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_wol);
 
 int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode)
 {
@@ -860,7 +841,6 @@ int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_wol);
 
 int mlx5_query_ports_check(struct mlx5_core_dev *mdev, u32 *out, int outlen)
 {
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index fd625e0dd869..58770b86f793 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -61,15 +61,6 @@ enum mlx5_an_status {
 #define MLX5_EEPROM_PAGE_LENGTH		256
 #define MLX5_EEPROM_HIGH_PAGE_LENGTH	128
 
-struct mlx5_module_eeprom_query_params {
-	u16 size;
-	u16 offset;
-	u16 i2c_address;
-	u32 page;
-	u32 bank;
-	u32 module_number;
-};
-
 enum mlx5e_link_mode {
 	MLX5E_1000BASE_CX_SGMII	 = 0,
 	MLX5E_1000BASE_KX	 = 1,
@@ -145,12 +136,6 @@ enum mlx5_ptys_width {
 	MLX5_PTYS_WIDTH_12X	= 1 << 4,
 };
 
-struct mlx5_port_eth_proto {
-	u32 cap;
-	u32 admin;
-	u32 oper;
-};
-
 #define MLX5E_PROT_MASK(link_mode) (1U << link_mode)
 #define MLX5_GET_ETH_PROTO(reg, out, ext, field)	\
 	(ext ? MLX5_GET(reg, out, ext_##field) :	\
@@ -163,14 +148,7 @@ int mlx5_query_port_ptys(struct mlx5_core_dev *dev, u32 *ptys,
 
 int mlx5_query_ib_port_oper(struct mlx5_core_dev *dev, u16 *link_width_oper,
 			    u16 *proto_oper, u8 local_port, u8 plane_index);
-void mlx5_toggle_port_link(struct mlx5_core_dev *dev);
-int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
-			       enum mlx5_port_status status);
-int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
-				 enum mlx5_port_status *status);
-int mlx5_set_port_beacon(struct mlx5_core_dev *dev, u16 beacon_duration);
-
-int mlx5_set_port_mtu(struct mlx5_core_dev *dev, u16 mtu, u8 port);
+
 void mlx5_query_port_max_mtu(struct mlx5_core_dev *dev, u16 *max_mtu, u8 port);
 void mlx5_query_port_oper_mtu(struct mlx5_core_dev *dev, u16 *oper_mtu,
 			      u8 port);
@@ -178,65 +156,4 @@ void mlx5_query_port_oper_mtu(struct mlx5_core_dev *dev, u16 *oper_mtu,
 int mlx5_query_port_vl_hw_cap(struct mlx5_core_dev *dev,
 			      u8 *vl_hw_cap, u8 local_port);
 
-int mlx5_set_port_pause(struct mlx5_core_dev *dev, u32 rx_pause, u32 tx_pause);
-int mlx5_query_port_pause(struct mlx5_core_dev *dev,
-			  u32 *rx_pause, u32 *tx_pause);
-
-int mlx5_set_port_pfc(struct mlx5_core_dev *dev, u8 pfc_en_tx, u8 pfc_en_rx);
-int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx,
-			u8 *pfc_en_rx);
-
-int mlx5_set_port_stall_watermark(struct mlx5_core_dev *dev,
-				  u16 stall_critical_watermark,
-				  u16 stall_minor_watermark);
-int mlx5_query_port_stall_watermark(struct mlx5_core_dev *dev,
-				    u16 *stall_critical_watermark, u16 *stall_minor_watermark);
-
-int mlx5_max_tc(struct mlx5_core_dev *mdev);
-
-int mlx5_set_port_prio_tc(struct mlx5_core_dev *mdev, u8 *prio_tc);
-int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
-			    u8 prio, u8 *tc);
-int mlx5_set_port_tc_group(struct mlx5_core_dev *mdev, u8 *tc_group);
-int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
-			     u8 tc, u8 *tc_group);
-int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw);
-int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
-				u8 tc, u8 *bw_pct);
-int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				    u8 *max_bw_value,
-				    u8 *max_bw_unit);
-int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				   u8 *max_bw_value,
-				   u8 *max_bw_unit);
-int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode);
-int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode);
-
-int mlx5_query_ports_check(struct mlx5_core_dev *mdev, u32 *out, int outlen);
-int mlx5_set_ports_check(struct mlx5_core_dev *mdev, u32 *in, int inlen);
-int mlx5_set_port_fcs(struct mlx5_core_dev *mdev, u8 enable);
-void mlx5_query_port_fcs(struct mlx5_core_dev *mdev, bool *supported,
-			 bool *enabled);
-int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
-			     u16 offset, u16 size, u8 *data);
-int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
-				     struct mlx5_module_eeprom_query_params *params, u8 *data);
-
-int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
-int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
-
-int mlx5_set_trust_state(struct mlx5_core_dev *mdev, u8 trust_state);
-int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state);
-int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio);
-int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
-
-int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
-			      struct mlx5_port_eth_proto *eproto);
-bool mlx5_ptys_ext_supported(struct mlx5_core_dev *mdev);
-u32 mlx5_port_ptys2speed(struct mlx5_core_dev *mdev, u32 eth_proto_oper,
-			 bool force_legacy);
-u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
-			      bool force_legacy);
-int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);
-
 #endif /* __MLX5_PORT_H__ */
-- 
2.45.0


