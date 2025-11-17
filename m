Return-Path: <linux-rdma+bounces-14565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2468C6642C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 459D235C208
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE872325715;
	Mon, 17 Nov 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PKGYEIrv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9A320CA7;
	Mon, 17 Nov 2025 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414409; cv=fail; b=dQUk0m6oOJVn/cEe5VlZ7PWdXfYB9qzzM69C5Br0fp2BuAErMp3fKTndmEwGsDJ+nhqGC/mM1mWnzW8TyiJyAMbu67h9j0eaUtqdagdTFmBNyDWr0jBqnv4FRFbI2oBdT9Tm4AxQpO/jR9Jbn3aMOEbOUoK0ZTRA/iZQ7E6dFaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414409; c=relaxed/simple;
	bh=82cy8P4MG8E8PDqH6MScSgFzHH5VIE9OXf4e/jE/M0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDLJIhzzwSnoU2VdJGhETfJ4GvsWrWcD8c88qL25U+Mkt+p3JfCp3kJiKKoeIPM8KmlIDnbkpicNEQIC2yicmkqmm8DvI8mhZ+CAcnEXmwj1d3ejgVbPDgOgdDwXrzOLd9SsvHotyAYPgSiX+2tYR9uKm3cZH6QWG7K4m0w9rkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PKGYEIrv; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyZ6ejPDUQO0nHLGPgv6n7+GDAuowqQOFAgmrmjxEoM74r5DsozIwQk9DHMoGbYBHkmsnwC7RZLyUm4Yi1GOm5bQFwbYJuIsaKXuA/8f5qe3eDI9ArPklg9g2h5dtmQeBmFOh7+Iear2+8t9eRxqAkPdF/1f0BpmJt5Iyl7bi+iCBrF5ahzBWICY93dMKin9S8RwSjPNdrFyF4RjSV/ucPZvYbfaAJN3xrWd7/RzIQbjQypwzA0myVhMx7B8RO9c1BfoTW0Ql8+HD44EPZi7NvmWjMJ2MhSsFqy+qupkq3k4fL6eUPLnZwqwZQUoC42oal5GAMFYBql0vTc4cVmC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgjqLtkONik5/acTg7fznCOebpnjfMbi7d3dk+XJegU=;
 b=dDvR5yMkB44rgrNGB1/8xhTr1x2cJvTdT6uqEtvIR0NZiO0F4ufQiq9QxV7kteP2Kiui8wGWBoa2xWYZf/pFiZnpP/tRVOtqGLyKXlSpy9xEHxiY6/XLQ8MKkqpjKXXs95DnXt6YSaqsBZopaD8+COXQqsH1DFKNGddfxW9m76c1llz36JKG4OgNLrNHNXX+NhTGRhqqC3fj7prL+gNpzgfEkPVsy8VBg2ne4wH+fV6mVIy5lSaf/RAiHd5UuFIxbHg9SWz32MexRLnczFtYib73+aapZaJi9BMFduOo4B/oFLs6WEUdnjGS09+88RIAcjYfohPQDk+r1ZegIurKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgjqLtkONik5/acTg7fznCOebpnjfMbi7d3dk+XJegU=;
 b=PKGYEIrvlW9ChhIQOGdm1joVa21A0x2wmMCTz6QIeAcOLE/GtGgmO7RUMFIEnz/JUunik1R/teeKZ3HdkHTDY45QJ/nj2i00vMT+EkLzVJz8xcnKKA3reDIt216ChVFVZllCfqOzI9bNmaP6YiEkjWENvUoyzJ02/vMUB+NRBRyg70R6r6RyvB0EmjniF8UizaNlVUuhaO74NXxeppTEVR7eywZUSHiGZKiZhw+c/3F7h2WNhmppSrA16+JJ9YV7mdnwbHsrIkF9tFY8En3ZHYsM3Ft4MuDuLUW447sTS5vjpREQQUj0cF/KsT66gZZfNBzkO2keX7mbj2plWexchw==
Received: from BL1P221CA0038.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::9)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Mon, 17 Nov
 2025 21:20:00 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:5b5:cafe::d3) by BL1P221CA0038.outlook.office365.com
 (2603:10b6:208:5b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:20:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:19:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 17 Nov 2025 13:19:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 13:19:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jay Vosburgh <jv@jvosburgh.net>, Saeed Mahameed <saeedm@nvidia.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5e: Add 1600Gbps link modes
Date: Mon, 17 Nov 2025 23:18:59 +0200
Message-ID: <1763414340-1236872-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763414340-1236872-1-git-send-email-tariqt@nvidia.com>
References: <1763414340-1236872-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b04204-32f6-4fc5-c543-08de261f10f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lx/+Wctda4O7PuCHc2oak1xfRiKCXGRoFCWIXWQjZSc3SbSktK2Oz0q/K9Ry?=
 =?us-ascii?Q?lP70DZY6K0QMzhXVyANbej1Z7RPe9rKxd6LsIOjQtcOpYZ7hHiRUJURaYBy+?=
 =?us-ascii?Q?9/XdJMYCMoWTm4TNKAuz8ElE5pVjn2BSM4DYLBmt2uzWxgHkbjKp+3KeAfjV?=
 =?us-ascii?Q?OCLRlshdnxCQx1yFXDlgQ2To0ARkbAFM4719mXljO+anWMC/DJMnsJU5snfE?=
 =?us-ascii?Q?HQs8BrSJIbOcYPQyIasUiNewojg/vtx3jeIGqoeVr2tQ+42dmpdSKwY0Mhto?=
 =?us-ascii?Q?GBx7iVv5RaYwfcdU8PUVeu/NTF++Nm5Ehs0UxOEJOqZjqZFBFWoR5FlSqUyx?=
 =?us-ascii?Q?X3S7DFc7lGGkuSNxeT/Ykvha7VBtlbtVtqNLIyg7D8Dx8BoWQzoish3J6z+U?=
 =?us-ascii?Q?pQJ+5yyaDQoxrGSnHymsZiuFnTDie9CUyiasPFqQJ35i2exgfcmnZN4XaUcI?=
 =?us-ascii?Q?Jc0BbsdnKm+zR07I6k0lLS0d+njFCCWkFv679JEHFhgUj3LHVSE29OgBfTCg?=
 =?us-ascii?Q?km2lAkh7K20H+hDNiAv7FlGjI9FF9cAA0nIVEPgGBZhbkxYFDQ/rHfenPe6n?=
 =?us-ascii?Q?E/QnvcxIoQOO/z2+a82DwEvBDujAI5vke9VJHax8++s6n+qQNJ3ckdRgrPAm?=
 =?us-ascii?Q?+pJXz6NNbdJgKP6Ikpg7z/0QHFPU87F1UzIo5VVoUXung31+tFAA4IgkDLl2?=
 =?us-ascii?Q?c/CbbqNce+7BRS3PyrmuegsNfShiph1td5oD3BqHeQCMhUOJ4A42gcUutcDB?=
 =?us-ascii?Q?811znPGxuKmu1n1Jtk0h6+7jQ13kmncgkdyVicNftGJC4Ps9GP2m6lJC+RL1?=
 =?us-ascii?Q?bcvtg3j3Mj++RgczcJP0EvFo0kwYMcgQiupz00p20apkwmRVNSX8n/2F+x0W?=
 =?us-ascii?Q?rxZG+Ts0RcE/DrgN2mDWoreqYAsl2UiHiYcFqq2l87YF71okgIdDzswnW4Cx?=
 =?us-ascii?Q?sxyKXcC19KZjtjeTT8w9riUI3fKIs6wj5IXF678fIexzpUHbX1ds6Yavukh3?=
 =?us-ascii?Q?Cb35ZxLEEDS52KMCRkn/iKVVR8XCcIOntaJ2IL0YgasZ+0mDdxqlfuLTeHbD?=
 =?us-ascii?Q?EBO+kZg9XzsUgjEU44bV6rW370m0QkcX6y1wQEhaoak8a63dLXWvsJbHXP2Q?=
 =?us-ascii?Q?57jkNymq6xfQKC/8jydF9Qlw8EUapu2lXBKGJ0sf8Yp+SWKc5DIVlu3skJxg?=
 =?us-ascii?Q?ywBEhoDGSAKisljzU+BnO5JY0t24bTQIPHAzN5fT66qDNFuROPAn3PVjTHn4?=
 =?us-ascii?Q?CvCzFcWPdu6HlHtStWR6qdSWtAhvEKjJvQKcCKwxXNBKeKX6GnxSvGB4Wm90?=
 =?us-ascii?Q?myuVOCeREyeq3Lp0vHsmaIL9fAG3lPfrdZNyGy8ZtP9rL2IOotxYfGW4X9zy?=
 =?us-ascii?Q?Hohl93i1kFILawoQkjr8SkI9He1+9oH4tneWNArCzKVGA19my6+pxcjb8Bql?=
 =?us-ascii?Q?vQkNE3AUoyY365zbUnvkw0SLaHzstDRQ8xgBxeI0J+KmCF7TRd/Qh3LIxqWE?=
 =?us-ascii?Q?DKX0gnBH+QGGB27bYNukE0QzkpgE199JK3bJoEk8NGPbrV+YEcRvpfs0aMRM?=
 =?us-ascii?Q?aLbop/3bmi0XHQG+RzU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:20:00.1477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b04204-32f6-4fc5-c543-08de261f10f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430

From: Yael Chemla <ychemla@nvidia.com>

Introduce support for a 1600Gbps link mode, utilizing 8 lanes at 200Gbps
per lane.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/port.c       | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 01b8f05a23db..72eeb9593e75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -261,6 +261,11 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1600TAUI_8_1600TBASE_CR8_KR8, ext,
+				       ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT);
 }
 
 static void mlx5e_ethtool_get_speed_arr(bool ext,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index aa9f2b0a77d3..1e6654573d81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1109,6 +1109,7 @@ mlx5e_ext_link_info[MLX5E_EXT_LINK_MODES_NUMBER] = {
 	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000, .lanes = 1},
 	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000, .lanes = 2},
 	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000, .lanes = 4},
+	[MLX5E_1600TAUI_8_1600TBASE_CR8_KR8]	= {.speed = 1600000, .lanes = 8},
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
-- 
2.31.1


