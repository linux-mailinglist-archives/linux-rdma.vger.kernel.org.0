Return-Path: <linux-rdma+bounces-8130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31629A45DB4
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC27E18988D3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF106221547;
	Wed, 26 Feb 2025 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChHPWpQQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB0219E99;
	Wed, 26 Feb 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570535; cv=fail; b=qywVA1n5oKKXMTFO4Cka2u1pF0jbrUirnNsWB7g3CFRcY/AiRzyAhd5ikqThJMA+KlIj5PrIA4vlhRZd0F/CpEGSbZlHX+SZS4uZq8h777KU4Vo8AvyFtBkq16+aWxLpen/Hjxx1zwf+2Kg1zio6qgfSw2ivgy6cI7uJGvo+jXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570535; c=relaxed/simple;
	bh=1F9CgFFRy/eoNK86QJf7labGG35dnaxHdsvRC5J27X0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnnmYXm6TKsIUaqShTxIxnDoPZv6RlN8wl1Ai6Q4YHhd0AnIEQyfqcmW2Fb8rCezVwbOuv6L73tfZJEh6LjFXQcxs2IFZ5cRenw+EjmdWQbzC3vxAOspRezBT4FIrwAGLn/TJZrLes2ny363KN/ZMPE6fh7eDXVybuIqnMl8gOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ChHPWpQQ; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4Y813wuldByMGh1mO6miIDlN00qy9rhZUjxbm9IVuG5nYN8ymSrloOhdCBrFDZndvH2c6VbEeIEmbhi/AtxQci4vp/MC9GftRUrtvWwe8BaLMW7d/SKaKX+akzVumRb57nHdt0BKhtc4gKk9n4CZPhhdyCXbAaBDitpWUKKeUhelKaZQGqgjh6bNp5KK95NuTcn0y+XV7IW4mjS5Ed3uGh8sIuWwnUT9aTnbkz0O3EQlmMlEj2IZHlwqt2+SSRnsuna7YoBQKRBK/19vuMgyZrmbKKbCqM5UqsfTQkiveU4VVVeO6RVpCRBVAVYZyWc7uuVeiNNWSI+ywWJsoYTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC+E6csWPKWR1HSx2SePnCoMMNESIicElHk5IE8+wH4=;
 b=bNhwBkgTxtGuf4JEynwXPC1TwutR8WdOkp9BPZwOsOdPKeM95L0r4NthuXfZcCsINPTl1xO1mA4C8XYi4OYM6/c3xpAqT6h+mQitmqWEe35p1IYbnxx7iS6sK37RGgAcY+QxY0BbuWmcUFqkPKh3h0ev5xdTh4/nJ1dPPRKnDkkbj6T+czJ8JCjkMaq6OVjDB/3/tjFsS0nxzRYLFAn6xfdBICQMOoeRCcBXI82zNAvigzNKwKRbBEMkzWmRgk1XOjBwKVjmgB2rXIwNnjBFJHMfuTnLvVSz4yAyaVwFprZ45sqn+2V4YL2fDSnnx0hRs7zLUbFH8b5crsfA+2e2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC+E6csWPKWR1HSx2SePnCoMMNESIicElHk5IE8+wH4=;
 b=ChHPWpQQfbL0auU67BG8naWNTfSLTyL8neCQHKe0PB4Koo9FGpAXwbgBy+J7+97rVICz6KHHqSrqFvLOtkLP3hFChQEYeK5YmELY2spU2MQ5ypk4dYMqoZznBktkHlstbj8ucZ4PX1XEXRtHREN0LihVU6KfWsOMzR8+FIXMUFSVWoVMfcp0YTWIDUWcgLh8uOsJQDwLUvV6Gr8s38Rl50pVqtiMFy0xvrHF0sSfuBWdLZHg2wr/RJMLk0RCwHkWuJf9Uk0R30d3FCDTTyiW/tjYRlYAjl3HlZKpAI5iIhdmgdGyxW6pIjbaIemmrb+6/hDjHN+NbViWT4h6bjdlGg==
Received: from BYAPR07CA0080.namprd07.prod.outlook.com (2603:10b6:a03:12b::21)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 11:48:48 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::17) by BYAPR07CA0080.outlook.office365.com
 (2603:10b6:a03:12b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 11:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:48:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:37 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amir Tzin
	<amirtz@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 4/6] net/mlx5: Lag, Enable Multiport E-Switch offloads on 8 ports LAG
Date: Wed, 26 Feb 2025 13:47:50 +0200
Message-ID: <20250226114752.104838-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: a90fcc85-b32a-4500-4d5c-08dd565b8827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FW6DmNvfo1ZLbdHeVjRRa0oY15ZTUGGjOfVHC3N4BbTJSS/OwczgCSFkUzaC?=
 =?us-ascii?Q?69WVQlPAscqYQ9/a4MxIr+R74eA8b+R7iXKO8bayAwF8zyUQ58acK4KThvDd?=
 =?us-ascii?Q?TatJuUt5mzzP62jKKGaWVLE2ygXbU52iDkVeS/uCjV9RmV8fDbVEOaPeTw8D?=
 =?us-ascii?Q?hXKo1RN52x3vpsIJ3L8PqPrZeMxGM1mk0VWVUn2aOweN+oBQMocZRKXkWqL+?=
 =?us-ascii?Q?bxI92z5Y0BZM4MoFGedfUxDz6RA3oY7KeSvV8HvIUAtkxq8WQbGYcAEt/H4a?=
 =?us-ascii?Q?cWhobglpDMF+FScKlnzp/j5ivKyubjWjA3oOVUJlfHXIGG2r12xV6+W8njb6?=
 =?us-ascii?Q?J8kIPh32ABFM1QgNPvxmaggmqGoQdaHTiAa5W0NLBa7ohd+/ji4KiJvftw9M?=
 =?us-ascii?Q?mDw+sBItPBob6ctOVWUFNQ+HAi589KSBvNeRMl+N9ByUV/AjBTm++hSGNe25?=
 =?us-ascii?Q?OiQbjxVchwjDQDmCp5OBROJh7y4zCF5ZHXH6/klb9qmM4ZBNyoyfm+5KinEk?=
 =?us-ascii?Q?Ratx0yOEmk4cwTG9OpM3TQKBneHaqQEgrTxBEoE+udkAaUrJH4JRF+3oCjnD?=
 =?us-ascii?Q?SKdoIsVniZ+fYKfpZ/41tYINbOTS1lPHrUVrrBlQQefAJvSJkSuRuj/bpOFV?=
 =?us-ascii?Q?xW2EkW+Cgt53b8JQJURFiAiNX7HfTEzPQL8mdJFFW9o1ZyYWGRU5yRSjkbYW?=
 =?us-ascii?Q?gcV44ndcyjAmue5zAmTQVR7IEUYSD6L5v/HtEbjjJ47pXYX3BCvgPY8BXnMR?=
 =?us-ascii?Q?7hKZpd+Yp+BtkSCDjfv9rVEqE2eHDUGMr2GJGtgn6dEUyonWopUDlKY1+VPZ?=
 =?us-ascii?Q?wmYfPz8UjQ9DVOKP1MGLkoABwiwnYRZG5kn2oQt/eqNfRaiywLWoK9XdPJb/?=
 =?us-ascii?Q?3LD2DtNlZPV1HG/aIQPR/JYk0FoDv6ILGr04/DQ14P2xW6rKu9fENlC7bfZP?=
 =?us-ascii?Q?nvM2dOrAmv9RBv4HSO/AJJv8PE64DC7ovEMLoq32czpllmj31+GMvotD2OXF?=
 =?us-ascii?Q?sn45MJle2f38TRElq5J3BeKF0UJzRGnd/jPMw+irDB4AIwFtJEKrt6G9n+Zy?=
 =?us-ascii?Q?j/WF2xNNzDKSvvybIGNQT8X1pJsTsZygYCGFeQP17Oq8oubA3tb5FTXR4+eJ?=
 =?us-ascii?Q?oK+Mf7qNKdp5PXl+GZGPuUe6uKEB/WybHVqviW32YLLOH13eVSLxFYVFAoff?=
 =?us-ascii?Q?r4hRnFKy4qwbEf/BplsDN0Cmp7XfZZS9gromCixvLp39CqST2Gh1hCguLnll?=
 =?us-ascii?Q?15vVLKzVKrFkOGeB52nlaIWTFywe8mrTuWcCZPzzZtZZUkalO8+Zy69S4KGm?=
 =?us-ascii?Q?uQB6XWXCMoJBbBXkR3K4E07vt+3+77R8KbFH5qgqRb7DHy0QOx2Ll392WI57?=
 =?us-ascii?Q?gKlDHF1Y0jp6PX9HqJu4RBVPYHnf4ZMW9S6uRVbAtQMv2MG/Bl1MgaxhQlva?=
 =?us-ascii?Q?VffBPydkKnQi1YU1VHWHvx5uV2ryeJkelnc87Te/3asV9BT8CqnxfP1moXhJ?=
 =?us-ascii?Q?KuVi9goXFAuxuTk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:48:48.1517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90fcc85-b32a-4500-4d5c-08dd565b8827
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

From: Amir Tzin <amirtz@nvidia.com>

Patch [1] added mlx5 driver support for 8 ports HCAs which are available
since ConnectX-8. Now that Multiport E-Switch is tested, we can enable
it by removing flag MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS.

[1]
commit e0e6adfe8c20 ("net/mlx5: Enable 8 ports LAG")

Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index ffac0bd6c895..cbde54324059 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -65,7 +65,6 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
-#define MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS 4
 static int enable_mpesw(struct mlx5_lag *ldev)
 {
 	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
@@ -77,9 +76,6 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 		return -EINVAL;
 
 	dev0 = ldev->pf[idx].dev;
-	if (ldev->ports > MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS)
-		return -EOPNOTSUPP;
-
 	if (mlx5_eswitch_mode(dev0) != MLX5_ESWITCH_OFFLOADS ||
 	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
 	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||
-- 
2.45.0


