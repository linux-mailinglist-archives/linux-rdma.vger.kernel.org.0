Return-Path: <linux-rdma+bounces-6449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1881C9ECD94
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522F2169560
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FA2368E0;
	Wed, 11 Dec 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cNeICnUs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003A2336A9;
	Wed, 11 Dec 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924684; cv=fail; b=ZghrUZfFam73glKMirjbLFj4Pny45nzyBUL4AXbE7bXHG0AtPcAZ9Cn+O7zIqITEFvnawUUyIx0MgdoCmX7fCWcgdnicqgeZMI1fM7OI1T3dcTVX6OxWnib0CgTDNzlULR3JR3jNXkgftvIFzIpO2l/YHLNrEudZ1GZvzLI5GHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924684; c=relaxed/simple;
	bh=6ZVzd45VKwaVqvqtE2yC1dZepgb84hEbcv7tRF6SLUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDkjMUzhNVp/kPDBCQzfcwfKhG8ya8ILkAC59uFrl2jxgx7uxDqzOK5yJjqISeeAGC3hcJMNpP95aktRbB1S2rTzZP3CNaUDX+WD0P9uo29RtCDV5ynK45mnqtbXxM9s1x926Im72Xqahizn7lH5yqbZKe7B8dIFPSU8GpmCAuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cNeICnUs; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYqhQ6ExhXYk5BZnIxcHNfoI5j4jQLKzOJJpR3Yr7TUTfniPDhs/Qbec1AXGzstKqCPi9uDzx1eIMbmw5Z38Z4Ns9LewNxxdeUOqqljrcfwjvOKtC+6rSpqvWCHfGCPVMVMIJs5NiNAWnDfzi46rZaGsD8BeYYGbTAY3z9j/0SynoJbRjlC/tCO2TL+EzP0r9dsZqN/38I+rZ3GJ5K9DPFlkMUoVk5WNf4HhvxQ5OMKVKHl3XhzyxgjqvN8mBm0VN7oxlcjDxkfORUXvJwL27tDM9s8fCPlUj7gkscZ9Qt5VczCFI3yYrVq1mRJBc2cTRnt1RYR3hRVbva3rykOv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfv3elRwyUydOqmqS8DCP8iIxtevsE045EXbXJHdEGU=;
 b=o7WDm3h8iG3N4GFW7xd0KTJjDtGLPTNb1E9wu28eF75Jmh5ybg3fnotLJ9TVMIT4XCWpC3zDUPV56iVCAkJRySPu0d95O1907HYRlcA5FgVKLtEiI3d22AX5l48+2C8W4agGKXTOG0BL+CH/TXEM0uzH24lsnYenwgik0iweVohpw1xPWMQrAmQTbku0wU0d0UhWSR9zpMFzo7Uj8Fj3+3pCJA/wVA+4vo5VviWjsXyr1SgQsRKqu2mI2YvgouXCbam4t/w2afitXrpowwBHvbcrNQDRcKJ7i2md7gSIqjXEtyZ+CFdthVa6ehWsotMntyErpnuOlKOz1ntO+ZRKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfv3elRwyUydOqmqS8DCP8iIxtevsE045EXbXJHdEGU=;
 b=cNeICnUsWJb0si8xT/+MP4yGi0UHn0vmn6qO1CukEM9iKNPm6mcDdmRmm4PXQmXWT63JiQ/mqzczI+1XMdHg/Vl1F+6FO16Fsdt+zTSMXDdwarDn+zxkjhmfyWrsD6dC40XzjvAoVOmCsOLZhjScj2i13QUxIP9rZ2m6BDWpzHj3G0XFiz4irVMiSrmYZJH3YIUvXrapBnWAsbnVolzSVPhDehwdO3sn0k+Jl+eTz/UQ5mQ9TkGD2wqrcyJA04KoJaYtFr7TYvaPx0de7kK0axQ/TU/8U1GE692f9qjG0J+l8JANrlM+Tib3yVvYTeqTISvKAv4eashYUOSsmdp2Jg==
Received: from CY5P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::40) by
 SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 13:44:37 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::cd) by CY5P221CA0036.outlook.office365.com
 (2603:10b6:930:b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 13:44:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:44:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:22 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:44:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:44:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 12/12] net/mlx5: fs, Add support for RDMA RX steering over IB link layer
Date: Wed, 11 Dec 2024 15:42:23 +0200
Message-ID: <20241211134223.389616-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241211134223.389616-1-tariqt@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: f66bae45-7bf1-4b01-1f1e-08dd19e9f46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zGCCi8zOI7hruE46o9YugIXDBWAOhEELaX8LcmOS+41XS7fTqWVxuybdOiD9?=
 =?us-ascii?Q?5lPIl6GwZDlw5fRHvP4Nk2GKNG7UD0PpU+SvLoQHjSnjdOJJmfHEYZeHXhpG?=
 =?us-ascii?Q?ui7clXLycDYhq4BieBdVPnPJ117uLnVb3z5McU7okA5bY0UtR/J84Hp5jzTM?=
 =?us-ascii?Q?J3WzWMj7dUcbSVx/epAm50vZlmem+SyK2QYkrkRq+R5xjMpAVZPzy5xcwfl4?=
 =?us-ascii?Q?gIM/8+7Qlgv1QwGnVLAqcX489FVgWE9IJB7o02MbjsPvUJVSWH+5qdGC/wtK?=
 =?us-ascii?Q?y6k+3bTQlDP5vj229cZLhwIt0e8iNJ6w57djUxG5Tcpon3xh9mAdNTPJ2Z34?=
 =?us-ascii?Q?/AEp9+eYkogAGayj5dz7CtpogcfzWGRRZJmbcNqTwemQqwm0DEQH19/NuIJs?=
 =?us-ascii?Q?gkSi2ta3lpw+3wu9z4Qpi/oMrKO1ByUEGyRo2pWEd92gsm01C3Pftc2+w+fU?=
 =?us-ascii?Q?AGWdZps9Vfxz6iYnL1+iOnKdpoAwSz8mwaj+wszmV7Mm1kMrItdXriqkNiwA?=
 =?us-ascii?Q?6ZMobg095czk6uMlX1/YeGAWh4n3El+cBbURpfvR5JaS422AQn2YBynXwFiw?=
 =?us-ascii?Q?T/uUZPMCNaeJs7k2cwjLqi1D2fD9f/AIyMEpXSRiWw3RGtW3Yu44/ttB3a2e?=
 =?us-ascii?Q?tg59PoWlJQCuGmzw4MM1L1iHaun2Sfk0r6b7w+DGOYX6aER4Ozq6NxjYtgLq?=
 =?us-ascii?Q?WAH1MHWaVTcLzHtdYBLnruk0cC5PMtg4+dtoczIcCw4IB7wizL84FOYtZOt3?=
 =?us-ascii?Q?jilq7DenKVcSP/meQY5ZrghGE1Rq2d8ZPXEvMCSwsR36ok8X+NjBa+POqcku?=
 =?us-ascii?Q?7OVchtaa28SSLW5UOXuYbZ5QM5Nw/7lEJfAMU/wHrE30kS11cHSg2wlqpQEo?=
 =?us-ascii?Q?mqHZvAmgHXqPsuUCJSSacFwXscCMmZLR3XhxvMDGmr7N0yLU4Ocz6BYFuJz1?=
 =?us-ascii?Q?4Kwl++3E2hqmTNbPkjftyFTs0kjKtWgJAf/N/Y+qNrrg1HuxBwGEbvz0cxEq?=
 =?us-ascii?Q?iPMn57AFSfLXlMplMzcnQRVt2tOTWXLuqiFgRIY+duBJ7qnJszIwVQDJgpIr?=
 =?us-ascii?Q?qTbXl/TxzUMCxO24MZPPfeRauTNEduVwKRjxbvQM8ensGtjqQZsR6tK8dtSW?=
 =?us-ascii?Q?jJ8qc5igMSXHveVjQ8aBIlqCrq6HYwdCz2kMePxHcnsnTrdqI+0LK5fsra0i?=
 =?us-ascii?Q?ms2tg4lvpdv6Vjpt1D/9E38jXwgqPByD7xC+WdSLtMj99XSumbLlVHgV2yub?=
 =?us-ascii?Q?1H7kyweyGQWp1XV82SpRz56CDvLavTh338od9eui1fvx2H/bzgU/3qfxStfL?=
 =?us-ascii?Q?T2QsNUbalRflwi0yrCle5v0NO3kS1MDpIb5Ffr4+TiHoi5tMMheihNfkkqRA?=
 =?us-ascii?Q?StF+nx3UCfoFuXdzCE4TC3taDsEea4y86fiiAiigeGYzHhbRjwF0i1u5T9Mo?=
 =?us-ascii?Q?JWlwBqWGNTYDFvM2CP+fc0WNcGNtpKTm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:44:37.3873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66bae45-7bf1-4b01-1f1e-08dd19e9f46c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847

From: Patrisious Haddad <phaddad@nvidia.com>

Relax the capability check for creating the RDMA RX steering domain
by considering only the capabilities reported by the firmware
as necessary for its creation, which in turn allows RDMA RX creation
over devices with IB link layer as well.

The table_miss_action_domain capability is required only for a specific
priority, which is handled in mlx5_rdma_enable_roce_steering().
The additional capability check for this case is already in place.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 6bf0aade69d7..ae20c061e0fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -217,7 +217,8 @@ static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 	int err;
 
 	if ((MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_IB) &&
-	    underlay_qpn == 0)
+	    underlay_qpn == 0 &&
+	    (ft->type != FS_FT_RDMA_RX && ft->type != FS_FT_RDMA_TX))
 		return 0;
 
 	if (ft->type == FS_FT_FDB &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index ae1a5705b26d..41b5e98a0495 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3665,8 +3665,7 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
 			goto err;
 	}
 
-	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support) &&
-	    MLX5_CAP_FLOWTABLE_RDMA_RX(dev, table_miss_action_domain)) {
+	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support)) {
 		err = init_rdma_rx_root_ns(steering);
 		if (err)
 			goto err;
-- 
2.44.0


