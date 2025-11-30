Return-Path: <linux-rdma+bounces-14835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC80FC94DAC
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 11:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BE894E2B61
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24127F75C;
	Sun, 30 Nov 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="enwAAi4X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D427B348;
	Sun, 30 Nov 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764498396; cv=fail; b=i2C7oYvp48OgFR1sSsCr12xBCgECKFkC1dctdzcdc/LHT8VEB+vrxSfmSVjfKt+y0IOBaaBalt55rouR/hbdw24u62rOZSl58zAaNi5YVsMn4gvXgjb6mvaUjvx8RhLgZ8gVzboTs/RX+fEGJv7W6t5AoqwxuudI48jHMr9g1dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764498396; c=relaxed/simple;
	bh=5A9C83ILc7TM8Z+HQn8OK+MGJAnGrqIo07YcUlbbmZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2fPfSHr63mxKJlPr5fxRBsZU9IfZT6GfYEzyBer1bB6Ia25ws8mgFuj2oUipE4AL+9rgJiNtJHfZ2X85ZYrMQUw/qxk2r1vLVEx/R//N0PlCiLuOI7bhSH6jbo/bPhBPC86t+T6aPYWg1ZyhghPOHuJ+pekSly5WO4OFof8MCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=enwAAi4X; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic2GHQf1giuyFWb0iJMIRkDkkPn/QFomnOGQ71c5GmQAfG3Dlrbh2w27eBDMJiXaIK/7b0srTZMf9H3YSJ7Z15Iabi+Ub2p7JoXrgyZh3jELUgJhjwa3g/vzzlVk8FXAcRbvqw0+UH022EW9LHuGc2EV6Sj4UcO1lt3djRnihoExA0ZkXQikflaomdq/UFcq6hQuJqdG813qQt1h7eT/JKLUDWxI8XyMq89FPB83+Gyy/u5mUk9onG3CSz+NqzHeQ8poeA9+1t+QOYZQMY71/1CsNE7fMPYLqdlcWa1oBhW8IG5pX8jY41LqPxXIcVAUyyG8nTpw+dhijXdMjlkwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZsX88ACT1/PJumi3RCqbzsWW30gbs7NMpftIf2y414=;
 b=JCYbQkGTZZgvZ/M5fNs8uBNXetjl8ecwxrKEnKKbCR+ZE3eiO2deQzUtDlDpXGPb07M2BzEq/24Jc4+7w6O2hvZGLsdzwgtYmkQUUZYmOvNERn4sBcDJNX/9jTqo9h3cSo0hTKgZC7lc0dkkNJogdk/RElV13ROgxQUJAGDCeUhgmVZhRn4j2tkcH1onRXG1Iq3mdHxY/wqmXX7iy8iFsHfKepotGGYSIHk6xaQepniWNOYXDlBPSJOfQQy9c1z4MQIYgufScDd25p+P3bq/5OScXc59Ef5L5ytoyD/ODtDivikfcXrWQg1vCSrDdiajkSwQo7aHM0s/GOeR86qL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZsX88ACT1/PJumi3RCqbzsWW30gbs7NMpftIf2y414=;
 b=enwAAi4XN9C25AD2xYEUnA+pgN/P5Y+psDXj1XslySwyier+NydM6G/5Z543MoaAfcDrckmopzRUmr8Bgghldv6Fu99A6xl8+dl2PQKIUcEireT194PhBmot2+EO87PYjwi6cUHjxZldgvNNHQ1LA/i648UOhtG0mk+ELsa6GnpvlAMmZ2DSHBgU5hTze/9WT+oT+33N2eYRtiL6a0zVdCi2z0DjNFBG24Fn5PE7oK1S5EHTd6Db1EU3zQ2gdH/vCy4oH7FPbEAdI0nx5M4tZfiPYwq6O4TVeh+zIbF0BFGK8IIW7B7mbEx5TYoDgKBp1hHXx/DudKBi0foS7a8Y/g==
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:26:29 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::b5) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 10:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 10:26:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 02:26:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 30
 Nov 2025 02:26:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH net-next 2/4] net/mlx5e: Rename upper_limit_mbps to upper_limit_100mbps
Date: Sun, 30 Nov 2025 12:25:32 +0200
Message-ID: <1764498334-1327918-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
References: <1764498334-1327918-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: b7739a3d-9e6d-40c6-6e4d-08de2ffaecf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PbIKdc6Wi6tZ98F6rZY3zWBV7Fb6TyFz7lKDGJz1sEMdb5hRxWtFeSVTZh2?=
 =?us-ascii?Q?2BJgQr9+vqDBBmeOze1mtDHScHi5NSnmbE1T8KKC1rDsX0XLU9kOY+ElpEpa?=
 =?us-ascii?Q?VBO2841nFasmk+UaXgvpw1eQujyaLkpGtf/YBFZCARzXDtuFYyc334BzDYBI?=
 =?us-ascii?Q?noitnz0GdnXKlVX3QZZ3Ou2PYbQtKtSWjli6LBFK+DD/a/hPVk54jgbJiOca?=
 =?us-ascii?Q?rMHWpVZwIrze2V/V20EMtbWzTMcSRckIV3nQCiaF1AQF+K/9VmeULWgPUYwQ?=
 =?us-ascii?Q?aiRPXj3w5b0t1PlsIoUSXeQc0Wr11UrqQG5Nfzmu8yL7M0ICTqjskY1jxoJH?=
 =?us-ascii?Q?rQ5nsLOwA66CFz7Org3XqVijXpD6jRFBSmWDkuzyH6bOend3E+iLoiWaEDdP?=
 =?us-ascii?Q?pN/77pTNf0qLs6yrHQ3IZvgJcjHcUMZ9QyzURji8oO19DbZqILA1REYIuqjx?=
 =?us-ascii?Q?zMBWFAAYf7FOtOXhqfji///2NF92Ni6/exZlb+pD62ftnWlw/NSdGD0rF/V2?=
 =?us-ascii?Q?VdhmGmGEbxXJz+MLL0jSUtFFyDfcXhB5XpjK+NlBKZdXpYmkXp3nx9vwXMEb?=
 =?us-ascii?Q?NztMDmJyu9Q84ue+TMi9+dBDZ1tMvmc2w1b7VWBxgMqAiKOdu54N+/fJFFyE?=
 =?us-ascii?Q?WgqGbFQJpqGIiwhVqZpZJYzKEWjEXtjXANKICeo9a8bxUoBW5m3EQNDiEOta?=
 =?us-ascii?Q?BTXA9qTkgV+LkVJ7ffsFM0zK8TiH6LIoIFxoP/SZuaUWfpNyWD5XEi7SmCDf?=
 =?us-ascii?Q?bAAvtCQL53ZuASC3/UlxvgaouUCE3haSQrkLmGNaK8f99dp3CMP1nVspefRd?=
 =?us-ascii?Q?Aiol4gLp9trx4If+NIM5z5Q3pzKbuOlK9H8Hdd+29XWWuHTRKQOrkZLQi9rr?=
 =?us-ascii?Q?JJQyVjmAgi07kW26eKPoPxlmblLaeq08XoZ3i3+c5MHfTSL2L58HsRyw8F2q?=
 =?us-ascii?Q?PTM/099XrxXfXg8MqHcQzjzoZYeEChowv0HxgLL9t9MD2InfO45TinJg++Uf?=
 =?us-ascii?Q?r3BYLyF+1slwibdo7czzPV7HZTy4zN0NjjnM1lluhRD7Iu1Qzd9642U5mfb4?=
 =?us-ascii?Q?cv4zF7Ri5lG/Qm9eK+6Ym0yXFOHu9l6eRcALGnl0q3RGLcIPgbRryrpzqR87?=
 =?us-ascii?Q?UyB1oXxmX+aGoVffnzuNHUCUGGgf8SVOdA9CoqeG5s4L1QN8UogBWutnUu/p?=
 =?us-ascii?Q?+RIic7UPtxHqYux8xQ9YRnMK1ZrE0Fd2sS02XgAKC4+cHR4cErwAVGOE4igM?=
 =?us-ascii?Q?W7Nqz2d8P9iK+6oKzyGVZ4K03mC8lNFPT7OyxCJfbnFkat6N90NuZznQfey9?=
 =?us-ascii?Q?JjTWGVg9L70h4cK3QRbvbT5msVLQgohjLJEtD1KepsgryJvFaWYOiA1oLZY2?=
 =?us-ascii?Q?Ju1FxJ6TK5FM/OjTilxwplOzZAJ+ltVN5DqKQzXg3IrKEAdGXzc7CHp77axf?=
 =?us-ascii?Q?958RhwdObe0QfhcGdEd4ySywbdB5UHUONiojCT38Zd17mGSfA1Dv/68l+Ux+?=
 =?us-ascii?Q?WDufrl5Rv56UTXi2J3+3PJ6uVrlr0PoAGhj8u0TNZAvLGw9z69YC8ibEsyeC?=
 =?us-ascii?Q?IdH4FyCXd03vN77x+zc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:26:29.5827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7739a3d-9e6d-40c6-6e4d-08de2ffaecf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

From: Gal Pressman <gal@nvidia.com>

Clarify that the limit represents the threshold for using 100 Mbps
units rather than a general Mbps limit.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index dd491fd8162b..7127442f8003 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -595,7 +595,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
-	u64 upper_limit_mbps;
+	u64 upper_limit_100mbps;
 	u64 upper_limit_gbps;
 	int i;
 	struct {
@@ -614,7 +614,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
-	upper_limit_mbps = 255 * MLX5E_100MB;
+	upper_limit_100mbps = 255 * MLX5E_100MB;
 	upper_limit_gbps = 255 * MLX5E_1GB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
@@ -622,7 +622,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 			max_bw_unit[i]  = MLX5_BW_NO_LIMIT;
 			continue;
 		}
-		if (maxrate->tc_maxrate[i] <= upper_limit_mbps) {
+		if (maxrate->tc_maxrate[i] <= upper_limit_100mbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
 						  MLX5E_100MB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
-- 
2.31.1


