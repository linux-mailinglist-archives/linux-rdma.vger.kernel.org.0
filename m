Return-Path: <linux-rdma+bounces-11152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59463AD3CCF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7D73B05E2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B923C505;
	Tue, 10 Jun 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fIrBEhnT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5E23C4EB;
	Tue, 10 Jun 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568563; cv=fail; b=Cao/rRKUePDmxHDGyy96pLgMcPY55z9xSucq8XmUM+napg9GHKFFlHjjVpd63BmY3WqWFpr/sN0tpgOuEpBZOVBaYI7eLRx7d63x6fHjs8jbH1nibWHp5GLNAVH1Sh6QN5U12AFLfcjGoXtkIq1Ru6Smq6HTF54Q5gsqj3j6D2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568563; c=relaxed/simple;
	bh=TT7jTTdndzdj5IY+gBKze5WPALpW+um76NOQLydXA3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAo5DuYDp+NB4tiyHyLe5edsusToVBWDqqELX++gViipBtife/B+LGK8CS+T+36urot+VUuxm169Cq7B/fA9B1rjnnZKy0W/t3ZkGZdBasaOXRAkhqSfuaDCDzE1SS+H+9qumEiOlVuh0eGxNxfyiR97bLPkL+hovcNtnZk2GaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fIrBEhnT; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqWgR6TQjJaxibWmoGHVa0FvZilwzFQLu9Uup2pZW4ClSVWoEirkv5MT1j9YpHfb0Jm71cEXvjf2dR931oIIhUvgHwLw1yb5cNeyIvL/EvglaLbxZFQgTkUtWNShUg6ol+HgM0iuguwAgwWSkEB/tI8l0JXZI8ZoyNxuGe6yRKAZchzh90g8VXPV7yPKhxOQWj9N3d6NOuRLwcm0hjksQ7+XI6kd2Sa1BXU9hrLUoBHf8+GtEeGOu9fzprlsC/yzWf6LEy7bisWgM8WEIz0lCo1CBjKsChd7GUbWbSCdaAgH+Tf7yL7SiU3uFRv9w/jkfToDnEideGcW96HcwEitQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXLWV/9gIQWNZAadpD4qltHWrehWLelshUNb1EH6Cyg=;
 b=kYOrDJoCd4cWM1lqkz8n1rC3ZCcg4TnVFtHLGsfjBTOxpl9gyy9D0Xq6n430dNFDP03m+cg6LfGtLA73bDO0zXDm1ymPDTPzJdvpjx8jhhdfE+JxG9RHaGp3tQ9bPt5xAsTth/efCdeSyQm9Qac2i/xCeRIFk+Z0fCPp0OHDj0Fdt0Kg+obyUmHL5wy15jwvTKvjs+TtKqh4XzpIV4FKjrXUpqbBj9oKfGlA6xU3bMPKUxO4WQDofhofVNUUVRccfeayQ8bkl3X8DrG7GCHNmPaP5i9TSAdtWIDcquEOhTFCE7UZ9dQyDOm4Izek0h28tf8LmziCx3YBVrS8AzzSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXLWV/9gIQWNZAadpD4qltHWrehWLelshUNb1EH6Cyg=;
 b=fIrBEhnTKzG49l6kgb/bho7o04VZoazzqbeMQ9rFYzgQtSwQwm3zB+OunKZ9PHiaXJttXAd0g6QTuLT3tN8lOWKDc1u2vW3r72mLu/6VOrWbRFCGHqiDu7lSo6Xw1YUnJ1RmiSXprtYMss4XI12hcjSa1aO3FFnBb1gJtqYE+s+AdUbsbYNbxxIOEhFYx+MtZIlYQ+E/C3QrBYTAX1eLwbKH+3fr81XxLMZ11Rk2JnjICSGyB15u8lHmD03Oztvy82gfmjVwsGjCsyhGOGT/cJ+hiqt5vL+aDrhdFBSjr4AK1+NvyXvxH7RqUmMBzm+D4Rkx52WzpLx+jZOJEaKWDg==
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:15:58 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::33) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.32 via Frontend Transport; Tue,
 10 Jun 2025 15:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:15:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:15:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:15:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:31 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 2/9] net/mlx5: Fix ECVF vports unload on shutdown flow
Date: Tue, 10 Jun 2025 18:15:07 +0300
Message-ID: <20250610151514.1094735-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c8fb54-2dd3-465b-a71b-08dda831b3a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6yPyuGotfCqQKcCfloUWqOfc/wyOacWYK1fRamhfRHjA3fubV/gncsvkfrB7?=
 =?us-ascii?Q?urHhjbt8LZA0N5SPINe+BPpetUcXZ/jC5GCe9cmoLjsUu07dtdgKZm3TTahZ?=
 =?us-ascii?Q?7HurVwVwfCnYcIhmFHmN01LmIoyisP7Yci0ps9kABVfmmdf6Ix0Eompsi1Tx?=
 =?us-ascii?Q?Cuzip33CDcl9Y5UnRK0/GPX6fRzWhA5S5xzYlCQmJgG0Tf+zsI+DoZwR3jvT?=
 =?us-ascii?Q?LNcmGsFwKYKnQmlHqBoMV/24zYGsWfc47MTl+/xY+Jwmm0gVKUQOmb8LYZGS?=
 =?us-ascii?Q?7IVcmxhyeEihAVajbd7gWxVzJ8teN9E6J9kS/T3PLHG7WItfHkOn9ZoGXEay?=
 =?us-ascii?Q?75aP3V0vHStdIpnb3YAkA1hIhClgX73I/9C2rTD7ZTvkAkbPkyovHrIvVpNV?=
 =?us-ascii?Q?5aGH+t+zI6B2ubRepG4Gd2bu5o+krUVrLWwij+gt6ckIBaXaPEC/CeedPSTR?=
 =?us-ascii?Q?ZJS22a/Jd9p9CUJyOaEbWzZUEALW0qADNOCDfmWzRT2fRj35e9+pcjxtK8i1?=
 =?us-ascii?Q?IE5h/sW3/+Z00cn++RxuH/UXMHaZ4szGnF6pH+viWAG6b+z/0pDRDP0fWKRQ?=
 =?us-ascii?Q?sfKXR3adr6Qv0rL19J9MNsrxe5I2n64xbhrYpq/fQQa5iYtcYpgZbFw19GON?=
 =?us-ascii?Q?iztB4Zqy1xJK4Mj3syjGjYejOFmFd2JdYEGgQfDF3vZIIWqJKAPoyjqoEz/v?=
 =?us-ascii?Q?uXCk3p2aKxvHQRwKSZSan43BdFkqyfabAgxV92zTCH2AQ5WRAD+T+Z1YJh9R?=
 =?us-ascii?Q?sN7ihcO/49OhwAN0um73EAIuKwYVvPfoRbjOsCdO8H+dzo6u9gi0N3LnHzvB?=
 =?us-ascii?Q?vSVKS8Q2neHskwvlJxMC54NSv2hsXbM7QyVE4zXbJRu82yea4Lj0VcjEykkq?=
 =?us-ascii?Q?bClmsdi9Pv+0xzhd5Ryuxxp6U1ZQGGsNXNy2yaUgbjFsKS8Co+AhHqf7xLqF?=
 =?us-ascii?Q?ZI3A3gWc4ptQDlRRubGXx0ZLzcdyKtmm+uREe72kuyt4zL7qhdnC/EUbxXYp?=
 =?us-ascii?Q?MlEhIVnJOyWtzt7/OjkTn02lDzkiW5PgYiZXsEIglG+ZLbaDBAh1ds49z6MO?=
 =?us-ascii?Q?UCOMOr1E0RdVDCcAw2c0Y5ZYL87s59KVCLtmLJBLyL2ABVTo8+BaSyST87iV?=
 =?us-ascii?Q?oG4JVJE8I/Ns5G3mcr9EWkybmm5Ycj+/WfBSnfmJeDC7Oj41Z2XHmgzl71Yu?=
 =?us-ascii?Q?JHdgF3oZBebvIj3fCkqto6ezztXJGGXQJqmsnvJrwa7wTuXGB9Ynl2U7wyex?=
 =?us-ascii?Q?1M88qcVS4261lUvJEr6bZQ246mZJvS9MR19VV0H7URMexkQeT6stzXbzZ98n?=
 =?us-ascii?Q?hAwJEZhMWnUJvQWuyaOm48tMnGsJBHfTJGze/Cc44Klh/sK6tW1IYi4JmAZg?=
 =?us-ascii?Q?pOEfRemjEbiXYXgrhKUl0Gyet1VoBikkCwKFwsvveksVY/DjJfWGGWd0UOSk?=
 =?us-ascii?Q?eD2TqhkVXKaQKFINzAKLff1gnyfqdwOBKGEKEGocgEpWxQmzVsdi3Qc6Mu2X?=
 =?us-ascii?Q?olH5cHYUhn61W7vBorec60vku65+ry3dhLct?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:15:57.6117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c8fb54-2dd3-465b-a71b-08dda831b3a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827

From: Amir Tzin <amirtz@nvidia.com>

Fix shutdown flow UAF when a virtual function is created on the embedded
chip (ECVF) of a BlueField device. In such case the vport acl ingress
table is not properly destroyed.

ECVF functionality is independent of ecpf_vport_exists capability and
thus functions mlx5_eswitch_(enable|disable)_pf_vf_vports() should not
test it when enabling/disabling ECVF vports.

kernel log:
[] refcount_t: underflow; use-after-free.
[] WARNING: CPU: 3 PID: 1 at lib/refcount.c:28
   refcount_warn_saturate+0x124/0x220
----------------
[] Call trace:
[] refcount_warn_saturate+0x124/0x220
[] tree_put_node+0x164/0x1e0 [mlx5_core]
[] mlx5_destroy_flow_table+0x98/0x2c0 [mlx5_core]
[] esw_acl_ingress_table_destroy+0x28/0x40 [mlx5_core]
[] esw_acl_ingress_lgcy_cleanup+0x80/0xf4 [mlx5_core]
[] esw_legacy_vport_acl_cleanup+0x44/0x60 [mlx5_core]
[] esw_vport_cleanup+0x64/0x90 [mlx5_core]
[] mlx5_esw_vport_disable+0xc0/0x1d0 [mlx5_core]
[] mlx5_eswitch_unload_ec_vf_vports+0xcc/0x150 [mlx5_core]
[] mlx5_eswitch_disable_sriov+0x198/0x2a0 [mlx5_core]
[] mlx5_device_disable_sriov+0xb8/0x1e0 [mlx5_core]
[] mlx5_sriov_detach+0x40/0x50 [mlx5_core]
[] mlx5_unload+0x40/0xc4 [mlx5_core]
[] mlx5_unload_one_devl_locked+0x6c/0xe4 [mlx5_core]
[] mlx5_unload_one+0x3c/0x60 [mlx5_core]
[] shutdown+0x7c/0xa4 [mlx5_core]
[] pci_device_shutdown+0x3c/0xa0
[] device_shutdown+0x170/0x340
[] __do_sys_reboot+0x1f4/0x2a0
[] __arm64_sys_reboot+0x2c/0x40
[] invoke_syscall+0x78/0x100
[] el0_svc_common.constprop.0+0x54/0x184
[] do_el0_svc+0x30/0xac
[] el0_svc+0x48/0x160
[] el0t_64_sync_handler+0xa4/0x12c
[] el0t_64_sync+0x1a4/0x1a8
[] --[ end trace 9c4601d68c70030e ]---

Fixes: a7719b29a821 ("net/mlx5: Add management of EC VF vports")
Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 7fb8a3381f84..4917d185d0c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1295,12 +1295,15 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_ECPF, enabled_events);
 		if (ret)
 			goto ecpf_err;
-		if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-			ret = mlx5_eswitch_load_ec_vf_vports(esw, esw->esw_funcs.num_ec_vfs,
-							     enabled_events);
-			if (ret)
-				goto ec_vf_err;
-		}
+	}
+
+	/* Enable ECVF vports */
+	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
+		ret = mlx5_eswitch_load_ec_vf_vports(esw,
+						     esw->esw_funcs.num_ec_vfs,
+						     enabled_events);
+		if (ret)
+			goto ec_vf_err;
 	}
 
 	/* Enable VF vports */
@@ -1331,9 +1334,11 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 {
 	mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
 
+	if (mlx5_core_ec_sriov_enabled(esw->dev))
+		mlx5_eswitch_unload_ec_vf_vports(esw,
+						 esw->esw_funcs.num_ec_vfs);
+
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		if (mlx5_core_ec_sriov_enabled(esw->dev))
-			mlx5_eswitch_unload_ec_vf_vports(esw, esw->esw_funcs.num_vfs);
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 	}
 
-- 
2.34.1


