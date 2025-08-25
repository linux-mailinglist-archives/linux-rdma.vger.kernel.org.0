Return-Path: <linux-rdma+bounces-12898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A32B34468
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7482A1F60
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0303019CD;
	Mon, 25 Aug 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+NQ7TEk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123B3019BF;
	Mon, 25 Aug 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132553; cv=fail; b=JZsN3zbMfE1GH56etI9Z8jpg75E8VPs76zz6oTI+InLBrErWXxcJq8Di5WDp4Q67cYZmuNawJgiTf6BMKi/43sxEDlLcxdps2Yuy0ILOWUlKjUyRy+ZKB8irTMc8ynO4nQsQocHL0D3qzcnBUeTm1Q9TmsickJq2Uv759NNCbxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132553; c=relaxed/simple;
	bh=w0QXiYPS6TF929WR+2Lk16OYMVHSl4CqwEr7n0VeJlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cD8Cwz1Hw1zpiPDk0S9bnX5Rw8Pbn5Kr8ffPgW5LTIN4N2E+8XFskU47ZxlyuOo/LZIWEXk88rXUzNXfpd/Nuixc/JWQ0/CVBsCvi4SXT6kF85FGZUNwCDFW43HW/4P9rVHYOTM56kT99J/S9viaQtvvk+qM5ibvygx4P8dzF9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+NQ7TEk; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7X7x94ZQ/reka9wT6k4iKnxOME2ecEbaYfxsHLWcFqjf3G3YV/fgKAZ41+ustXtnedI11sbwg1Yn0+Diahl9oOkhUmTnhugeATMheEKkxXb4UbIU8L3XigoTmzRu0SQC98oGNHieEs6n5q3foKS9snGA42qADHlb5R/bs7HJb3eOz1LaLh6Ijr3w9YFcdoWWYLd5+2ihT62gyNA5taVzj+GgnSf/P5VDxhvj2v7yH9YBTPA5K+l4YYMBBGTbN6ueua+GPAn+/C1oWl8C+F9KyNm3cFeQ8KwtcXN17pHN0b7vK0qncEMJf3VAvxvxxhoUoE1xEq3/wnE475gkeZ+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gWVaM0Ds6JBQTgNWbkaYrwFhR9FbkGnYUhsGnpIm4Y=;
 b=aPZJLWDOpCNe8+tlSRcgtG/Ib7h95NeTUI24vrZ6rQa1LLxEdW86XgjBoxwTCVeZSs1Q/drln9qjINHnMKncqBkhXrDssxyrc+SZSLPBUcfJBGlHte11yqlJTXe5bH5lSb9GszyyLN9M4bKcNuEAOpmB7a8zuMPVCSClB2tSAeFBdGvmxzoowP4xQh//h1V+WNhq0rK69zuJfwS7IQG+WwHrt4ZqMkEpEjezZ3mkhG5wO5OoGpCxjpDxYaxSx2iDeLdn8X832cm64g3tp+X8KOQJ0CxDqOLwiMblCeMtUWwmE/58SKGHEFl1edpEflTMqvKriC7TaWOzPphUSLExbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gWVaM0Ds6JBQTgNWbkaYrwFhR9FbkGnYUhsGnpIm4Y=;
 b=t+NQ7TEkZlPiKn+6GRAevWN3hEzKqEPvbko+s9UPWq0ghFTAWgfMrC7FX85vg+lKpMhnCKvglSLIs/lZCdVg0DOLIimpAfGASqqWT/GjdhKgDBgDUx/Kja7J/WHpuMVI21CBjeGG/y8CMbQN00KeT8UVMZgJTDTRWohX6DmOnqmdx4SAvnyjQADtWaVP2uWZf/zgLsRrc8prQImKgnZGgKOwwrOnJjNBOwCqQCPmhKsLGi6mHLkjdVL2woBEEOn5mZXtKs0tqND3xlR7fRC8RXe/LELjzscfeEC0+HJGbKWyzLOuQjnXMPy2paP6qn/ZfAuhyFF3n3SDuR21ZJyJiA==
Received: from BN9P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::7)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Mon, 25 Aug
 2025 14:35:37 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::19) by BN9P222CA0002.outlook.office365.com
 (2603:10b6:408:10c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 14:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:36 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:15 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
Subject: [PATCH net V2 07/11] net/mlx5: Nack sync reset when SFs are present
Date: Mon, 25 Aug 2025 17:34:30 +0300
Message-ID: <20250825143435.598584-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3af926b3-4220-4ef3-a22a-08dde3e4a838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a5wu2DnN/inSDNr1ctpXWmcrox9hjHDSD4HRz4o7xXA4LuBM4DLDqtPP58Z6?=
 =?us-ascii?Q?zFOPCF+B/H4/dcRcS1+HO++Bqm+ls5rOI+U9hXOQDMS+UYfMQF053ezjRd5M?=
 =?us-ascii?Q?EN85fwKDlJJtH1ur6RU7pC4Gnx2oi4NW/Xpu7USL6FT9E1/fs4dicpIk/P4b?=
 =?us-ascii?Q?kxoFGefcKFbJEuKaE/RfRWgW+X+SX8RZycTwP5Aq0sISeINJQ+VUKbsJeZPr?=
 =?us-ascii?Q?BmkhL+mCYkUPVAjG692FXLfrBLRZrKL68ayX7gTEUzRcUFqUHPaaSjdQNiwO?=
 =?us-ascii?Q?XEw8hELgYzwjajgVx+9UfBGXVFsO5F05x7QfTbsP5ZCkfU7YZAq1YSJzPzqS?=
 =?us-ascii?Q?xmeasYoX4Tu4CY1hoBAxmPcIqimuN9NnhYuULddCsEi1o4qByYlHtF6WpIWa?=
 =?us-ascii?Q?cX78LIYTjHI5GpZxMXVIlyl8I8EmVNklRagwyUCGZzCY4iosZOjlsdm9vakQ?=
 =?us-ascii?Q?yUsbeb71sX35mn6FoR11uy4tUXm0qW8tUNX9TheHBokSI3dqZAHFwmK91K9K?=
 =?us-ascii?Q?HYrFfQjKWUpWawNtL2W+GyYhRsteCXcEbFrFnC+wUR44zThkKyDOCod3GnQw?=
 =?us-ascii?Q?PKw/S5OZScZrwJIWhL5mskaj3AQfhmTiPiZ2+fm3LhFNcNHInvpSPvwaSZeU?=
 =?us-ascii?Q?MJCdIxL2dpQvI3SSCFYd/k8SIo5QRuEieF/forfb818QsQs3TQPWOZmDkGIf?=
 =?us-ascii?Q?RZqCo2MztV2XxRf4cQnrYvo2tAEQuQUaEWN9KLJXy6J0dKClevvm3oU5lCPA?=
 =?us-ascii?Q?cEAw8kCjFpEhQ/tk1XoEfAgDI8ENVeIpV8RrGFYjnbdVs98aBlZIlhv1QmLS?=
 =?us-ascii?Q?cQZuPjMqCrfPRaKL1ITeyC3o/ikPVdoP1i63cSlmks9fHeIVhweFeacq0+B6?=
 =?us-ascii?Q?PrAQaMBb4jreqtU7QqwPOcxmKHAE3iONnGPNZwVj9GbfQzgVWYbYoCQVnhYZ?=
 =?us-ascii?Q?XQhZ16lP3HX8WmH+RLI5T6J3OFsVdoaf0GhMwkcvckcTpfODmX9UlvdJwXYy?=
 =?us-ascii?Q?7iN284xNTYUA6Wkbtd7Qcop1rVYlPZ8MD3JrtNs8IBIhZ/iClqmTccTarmun?=
 =?us-ascii?Q?8aJSjuZT6QQjt58P8ePA2daBqh5YwDi2gyXPuFUZwXPYpm9YMiQMgclrBSVH?=
 =?us-ascii?Q?Dv4YJMYxj7WAYNGhg68ml4Aq2XHK4hFjLbsF+E19P0e/vyL/+8WA+pgL62uJ?=
 =?us-ascii?Q?pO1Yz+s3B4zt1j/bQlcHcLoTmYmRj/PBhbU4cgGvVabCM0j/dUBTzibo0PkT?=
 =?us-ascii?Q?4JtEX5T0uToOhiqfMk/Y+Qiv2iTzaXiH84LBmEOKfaeDxZQZatM5+w2FYLSu?=
 =?us-ascii?Q?bUR6vvRDdjqlbvysZBuCUaWnvYoRLz1KiFJeBTqS5wLyWH0yCdzg4jab7Djn?=
 =?us-ascii?Q?bNlgGhsEmv0uTTNcP5Z/E3TGok3HW3KpJaJhootmYPjaTJoflflRQg1WQUME?=
 =?us-ascii?Q?lBXHmFS8AkrPrMhWOjM3UqGysQq7+jsxUBRIGAKUZlavqlGxxoy9AQvxEkz2?=
 =?us-ascii?Q?MJx8MrvksK6dVyhFvh2xGD6k0MARNlH1I69k?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:36.9540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af926b3-4220-4ef3-a22a-08dde3e4a838
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

From: Moshe Shemesh <moshe@nvidia.com>

If PF (Physical Function) has SFs (Sub-Functions), since the SFs are not
taking part in the synchronization flow, sync reset can lead to fatal
error on the SFs, as the function will be closed unexpectedly from the
SF point of view.

Add a check to prevent sync reset when there are SFs on a PF device
which is not ECPF, as ECPF is teardowned gracefully before reset.

Fixes: 92501fa6e421 ("net/mlx5: Ack on sync_reset_request only if PF can do reset_now")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c   |  6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h      |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 38b9b184ae01..22995131824a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -6,6 +6,7 @@
 #include "fw_reset.h"
 #include "diag/fw_tracer.h"
 #include "lib/tout.h"
+#include "sf/sf.h"
 
 enum {
 	MLX5_FW_RESET_FLAGS_RESET_REQUESTED,
@@ -428,6 +429,11 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev,
 		return false;
 	}
 
+	if (!mlx5_core_is_ecpf(dev) && !mlx5_sf_table_empty(dev)) {
+		mlx5_core_warn(dev, "SFs should be removed before reset\n");
+		return false;
+	}
+
 #if IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE)
 	if (reset_method != MLX5_MFRL_REG_PCI_RESET_METHOD_HOT_RESET) {
 		err = mlx5_check_hotplug_interrupt(dev, bridge);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 0864ba625c07..3304f25cc805 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -518,3 +518,13 @@ void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 	WARN_ON(!xa_empty(&table->function_ids));
 	kfree(table);
 }
+
+bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev)
+{
+	struct mlx5_sf_table *table = dev->priv.sf_table;
+
+	if (!table)
+		return true;
+
+	return xa_empty(&table->function_ids);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
index 860f9ddb7107..89559a37997a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h
@@ -17,6 +17,7 @@ void mlx5_sf_hw_table_destroy(struct mlx5_core_dev *dev);
 
 int mlx5_sf_table_init(struct mlx5_core_dev *dev);
 void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev);
+bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev);
 
 int mlx5_devlink_sf_port_new(struct devlink *devlink,
 			     const struct devlink_port_new_attrs *add_attr,
@@ -61,6 +62,11 @@ static inline void mlx5_sf_table_cleanup(struct mlx5_core_dev *dev)
 {
 }
 
+static inline bool mlx5_sf_table_empty(const struct mlx5_core_dev *dev)
+{
+	return true;
+}
+
 #endif
 
 #endif
-- 
2.34.1


