Return-Path: <linux-rdma+bounces-8128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C120A45DAB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2E73AA4B8
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C89321A449;
	Wed, 26 Feb 2025 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gp7jwOoj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F409218AB2;
	Wed, 26 Feb 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570533; cv=fail; b=Hd+xqFaP33Lg7aKiNEPWFvO2OD0sNGhDXzxOfR5eLvFAWkYYYE/bggYYmZTeepbC+pxt4Fc1ZFBrgzeQNH/eWCkGTFQprvKwKohoi3Kpl5Z0q6vhYi/SaEVQR6mZvF7aO18v8b42UCu5H3tMsD/lanpd3O4jREIA0flI5fiItOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570533; c=relaxed/simple;
	bh=+XudvtuxzUdeogYleIuKC7DDmnWM+v1m+TVG1pAapns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3yT5KPSGIj2qB6sLtJwR5OkzuGoT68/7fd/hKH71l96fSs4HaEJ1vcKr/RJft7IogMp1pGzzCMfyZzCf/emtNKrdDKY2S/gg/DqbFYdeVKHFGDLq3bWjsfwI//uvPIJua6ti4iOzxwBenI71ck1LaIpSILRsaXnz/9kpPhwkl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gp7jwOoj; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivok2kIIY8iyUmU+Z8B8+zDPynkQchEZAfkp1HVVPE4bxVuHo5nIGP6T30Tv7I+gqavtkvfd00Xliepnvnky/PVMu0X6eHEls5qQmLwVdXgxDKLtgOBXje2ANFIIKRvtxexGCgvGoogOXe9PahFFkTadkh4H7pPj1bfmldVlGMlqX0eS/DWcgJsx5ZwgUDH8dwZBQF9Qm7T8uX58z/L9L+S/+8DMQRmi5FHUfDl+pHm5e8SYFRIP3TQCz7UzlOklVfGkknT2jaKfgk65fws3ALESEzERulvsF+igjUJROM4CL38lZ0+EGQ9mdZx5edrTzCK3z7rwTq6NSWp+ZQaxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1Hjc1OiZDHth5ka0W/kv9M1PqZ9d1IlHPKaxIhl2Ls=;
 b=IO0T7BKqQYR9G1wM1Ltg+hwHcAVU3DuAL0KSEq7uRT5UK6aUg4rBxxdT6muIJXQfOw5WRn3oZ4bG+V3fW2v5Uv9NkoEISRiUtTihqwQiKNl6Z0+kmc/2C2XMzAnPuXG1znJTrgdfP/9fj3DtWXPHrvzK8laYuZfr9mUe8Y7HNNdXy5R20lPDwKFCvpcwX3gKDpmYMb2Za0GCT0lt/TkUEWvS9QObBthmPPOq/UaZLqXF3zCY+KptIn0rRUW5yiFPW1FLXNwTK3E7rjmbCNWt4jVl1g/5j3xa4WYrqOILyGH60RJA1W4+waaPDfCZ1AmygTvUpWI5Ks0eLksqIAY7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1Hjc1OiZDHth5ka0W/kv9M1PqZ9d1IlHPKaxIhl2Ls=;
 b=Gp7jwOojzSAjJ0hb4vkzHmzKWZjavHtjtjiKMwDSADndkE9Cs/Uw48RylIeYkSaPGP0Oy1rBzt54ul9afTx3Kwxtna8Q/zglI5fnvi/FKzcpiYMMMNvCwSy6me/5ykylufbrU4+GGVDPw5jk4N+DlSaZ6LBB97KUV/j6jd/FHZ42ieq1PCr+WXCt+bkT4iQPmdf6OEdxHMqRDymhKDGkEiz3bZUowwx+fJ7INIIr45Zwg1IJH2tjEbzcOa/DAncKffG+YYizeEsFOReyW2F1oAG7TDKv/B2RvTURbrOG0ZT6o5+BcIV2YUQjdg5bmIOyud57risdwlVpuE9YEC3Nlg==
Received: from SA1P222CA0158.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::18)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 26 Feb
 2025 11:48:44 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::67) by SA1P222CA0158.outlook.office365.com
 (2603:10b6:806:3c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 11:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:48:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 1/6] net/mlx5: Relocate function declarations from port.h to mlx5_core.h
Date: Wed, 26 Feb 2025 13:47:47 +0200
Message-ID: <20250226114752.104838-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 35484375-2ef5-430a-dcb2-08dd565b854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qd9pUrZgeiiy7iW68eUnCIGMCW/M+M3JyMn7uScrcdcUtQHA+idiz6++KzU/?=
 =?us-ascii?Q?IMu9ckf4y3nsSgIRoKMmz7LJuZ3BlZAYstQfUUa5lLUeeAf4wYBbB+e+PUml?=
 =?us-ascii?Q?E8gyFCyl0EdccWayzF//FafVh5rA37DZHQKQw3dXZNoSnfF4Hc1ubvWsRiO4?=
 =?us-ascii?Q?Rrt3g8nXS3r8/MZpW0EmDN47rZmy/6ZTRkx+V9BwatxEuOppdDTyzaxor63C?=
 =?us-ascii?Q?eoBlp8H157C7JwhUkjXdyOEJnfSw4xMkqZBzsFJTvpk7j/dGjljmdCOIbEJ6?=
 =?us-ascii?Q?MTRnXFgrzwqlOkqd2+Ul+pFlXmH16f8lqligd+KNWV37I07n97NkVJ7hA5tZ?=
 =?us-ascii?Q?5z/yXn3H41oIqfiFvFVcM4in5H7XnkrGQGEjZK9PbbKvpyIrUF6Q5cV7Ny/D?=
 =?us-ascii?Q?HyP+q4McilFDw4MHFNdFMRyzp7RlJFoTeeEMVjK+piKSbuctCovj1xK0rdsY?=
 =?us-ascii?Q?9m8F40qwxeas0GmzPllS3MjrSSjKhugduQNr0xGGTypuqd+lr83huVXYeaeE?=
 =?us-ascii?Q?46o76PYpVBBg8pq2LU4PqrON1iDTgKR5ywZVG0Nu+fT8lSI/EfGvvHf/LI4O?=
 =?us-ascii?Q?6mMaGeYjt9LDM+CDpZqjB+rCcDhotBztk40QuAIwinMs6MT+BacMOO1+EhNc?=
 =?us-ascii?Q?5T6ZzOgBf6GR4qzHRUxxY+UO4ayNDdZwrV6+sQ+T9iPrC9PDw+eYO88k7vkP?=
 =?us-ascii?Q?9TGkjlTMB9+sNzBfvJ2MEr7rFh0umDPARws81Mp9KLzyQbruZXyX5On29OG8?=
 =?us-ascii?Q?94oJh2HaoY0n1nB8LNwbUyCEmJyjHtto5MEJLFJp+3d3T0u+m/A1y3rirqdn?=
 =?us-ascii?Q?e7B8Ac7nPQ3OwhEz3Es4c3mcfnW2gVuMHurl1hVf0Y8BjhEfuVFCPlbMX/mE?=
 =?us-ascii?Q?VCbFUlcvmwJWm7cbCDgeUNbxbBqfLLYxSFvrXyV+KLkqOxe+dE/yNqLr6Wmm?=
 =?us-ascii?Q?6KDxbN5SwxXY9FYxfhIXBklD/neBzHkobwdS6Jv8WkQWLvAND+jDP+rO2zDS?=
 =?us-ascii?Q?xU9JNAd4gGSkKcVbZxK2cPnBJkSk+8MxdJmp9GRh5XLJ/eRPwU3dgphtHyZB?=
 =?us-ascii?Q?wUAhEPamG/danr0SDipgAr7jo4FVjyk1huplwuA2WA0wTJeTT7GjEGm0vZjJ?=
 =?us-ascii?Q?lqS1ibXQtwpJcF0HIWvqO/W0Qz85EauzpBHpZ9ccGBzrQR4QKNQzBk9h5RLn?=
 =?us-ascii?Q?+TZlOQZkd66Grip+a8BqmC1hChyL8jjDqq3yfjgQiCtZW94LAebm3Sln/TRN?=
 =?us-ascii?Q?NrBtDOxVFhR0IjN24cUVLaICUa1uqGVGqBt2eUs0fB1gBW1zhjwgbVkTE6Z4?=
 =?us-ascii?Q?iYFJlBWF9LBC3d3mD/ojaLhRtQWE2u9GajnTzffOwOd4aEQy5mt8JL1JULDK?=
 =?us-ascii?Q?4Ng7vHlxt52PNy4KhRCvZscYxEVkWzh8OwugravVLUetYdvbu9Sp2dDbsOHs?=
 =?us-ascii?Q?w8XOORYbUQIiesnjnlKsUoXfYbN5xJYSM93Y4HDgriBPWKTwK6hyxFPFzfmc?=
 =?us-ascii?Q?Jix9J8IilQZlXsI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:48:43.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35484375-2ef5-430a-dcb2-08dd565b854d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214

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


