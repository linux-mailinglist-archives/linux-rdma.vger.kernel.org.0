Return-Path: <linux-rdma+bounces-12951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA0B38542
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DF71C20AAB
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEC1225768;
	Wed, 27 Aug 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrRtvlWj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D02153ED;
	Wed, 27 Aug 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305713; cv=fail; b=UVi2bfLt3sulEPQx5S1zeKpalYLVczfkofGMxwk6zwQE1vrD1CsA1Ku4aDG+x7uAHQaNazocgIn6VaOszxmgHb3Yolhn+p8UpHPJQpzroSHjuKZdV+WwbD5z2fvjW3pS9XOC90rQSxkmgEi9bUwhhgpNDaDCFBLYbQo9swL3vfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305713; c=relaxed/simple;
	bh=r5/I4lETNhjzGp8Yr+/MrUtoh587lQAqA1xtUoEsDBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdFUtiBLyNU5gMk9ZO2Uh7pidLLVQX10RSbpvis7DAXVgFG8LIbgWJhyBubbQro6Z1N775u2XP1kD9oGUleuwuaCRyFb5R6P2m6a2m/d9rgVQnTSKpzla1/FTwSitTUgI/XIvHGIUyfaDbWQ7ubgL3iWcLhddYKTe/Vc4HTXMug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrRtvlWj; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6c0Y+zS3mrRhzvuIo+NfpAPE3JH4dmquhMLesMjM+NbYfFzq3emFUENMIYQ4GHqlrDG14VQEi95DLERA7c6B091cW/KAoISFZE4cIRQ1FsRPWPhjJz+/BP91EOA1V2WO3v+AUfYu6P4LydVyDqSjiYkpq5hO0+nvMK1iJvkCvnnJNtNsJIucHfC3gZG1C7oTz1LiRChbVNXmU9uC7lDJMOvDZJPg+aJLQjbet01g2jL8CPXo4iH0Flgeb/u/gdQ8zyMJ2GNbFF26RSJpCtZLgd26XbMxkkmNCpHoGIsRkbxxaKLJmas0/QhCRqg+Mg8gLdzSXcv66lq6U81YzAkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdZmkJJnXBfif8QT5LGiZDWZ4BWIuP0NWV7mCGb3qRI=;
 b=tBMZjmTvpoeq1xkYZHirbIScMe7a9zmoPKURvd7h2kXnznteyXWArXQ8ISZAz/oDB9iZWaT6e8SqxQZn25RlrSbNxYNLeziPMP+pTIBB6znD3F4C4iw2X5Mq9z7fuBE8+9vdMJUGuyizHBaxtbCnlu7admQbeWX47U33f68SijKnrK4b0UxCfTnsfzAH0ZXgeom2hsmPKFxyYPPYsPQJ7T/AKHxG0BBp//JdVdAOuiDv+WzVhii7s8AZ0ynVPM1+UFWyQFex9BLOEjn4ES6BO8x4A5OVOSn3zRhsdw67N2+vPdTnUuU37N8850NHdgQQra5vuwW5iyoj3pANb3FPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdZmkJJnXBfif8QT5LGiZDWZ4BWIuP0NWV7mCGb3qRI=;
 b=UrRtvlWjHllSRoTF5hdZuCtRHPrT/OOOm4dZ0cljWvEUHHNmIZHoBMZgC9tXfKo6r3pnmpsl57LE5gKRjsUH37Au4du6JtpI7G1pORm1fg2Rqz2E2Fjv7AFcA0keySjwVtSHYDBJt1+OBo6gE6l3g935TBWky0Fdpe3N6jav3I2yUKczWYg2Cvx9uXKUVI4N5EM5NDH5YFEnxHrxCF0Tj8CCRaQzXZ44kK0WORsGxo/bz4rGqoz3l9Im2+wKL3+8MFA1909Q2Fmd6jRzuaSHQUkf3YtD89WrQN/I1At6GD2ErGoBK6VzgcaRo3yr3WpmJanHuWu8zBFSHjdlFNyEAA==
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 14:41:50 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::c1) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Wed,
 27 Aug 2025 14:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Wed, 27 Aug 2025 14:41:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:13 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 27
 Aug 2025 07:41:09 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 4/7] net/mlx5e: add op for getting netdev DMA device
Date: Wed, 27 Aug 2025 17:39:58 +0300
Message-ID: <20250827144017.1529208-6-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827144017.1529208-2-dtatulea@nvidia.com>
References: <20250827144017.1529208-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ef9553-000e-4e07-6651-08dde577db61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtBwFJmk49v+IjRo4Pc9SwFEKRTR1uYk+Xko1CGvekoJ9b9KohjL9Hdj9I95?=
 =?us-ascii?Q?ZcXEyqHv2urtod0ixwXs+d8L6S+KG8VQ6KBqlc+Srtg/i732G3nSlT9XGDTL?=
 =?us-ascii?Q?Nwnua5rt1YG9GpxrntMPv9gKWIXx3A/Mf7itiwAx2hFGEM1vYD7/KLwUx2S1?=
 =?us-ascii?Q?TYrQU0KZe6DBtGaln8CkWN4Gi7Nix/ONeV3x1zFUvZW6EZO5c/GQ61VRKY9v?=
 =?us-ascii?Q?wj3CqTJt2XpmabKq/oXZjeVwGrN013FF4N5qeT4SwRdrB/2YvPXNifGRwhfT?=
 =?us-ascii?Q?Uts+GftY7XMdvKSDVjQq1FJ30fdlQQ3oLOtzhL2CVM2tOZzxW4ovPVqF0sKb?=
 =?us-ascii?Q?JgaasWiz9RNYSFB+MDtH9CPTEVGMLiVE50gc93Lf7zzVYV1yMOzlWWngKW/5?=
 =?us-ascii?Q?54O+TznOakpMmSx4VF8NOeXT/UemTsFQ5vHOnC4L/xI/HtmnOwO9rJcEQ1w1?=
 =?us-ascii?Q?oeLlRawWpJn7clorsb71SHHZKFkCPNymlmAdNtYv8OK7LclZTDyNI0/0ShbU?=
 =?us-ascii?Q?tzSigkXq5p1Nc9ZxkR0T7F0okiOUQXFFxA3AiAD6g8QPD6CcIA/10eNbkpk6?=
 =?us-ascii?Q?CcVzaQ+CBs4GaXCvdAr5olt0b0z/FFU238gPAARcueRoKVu2Zx7sg0UCc335?=
 =?us-ascii?Q?8rrK600XTPvOgWh1Kpgdv3Vgkpa0J+qXfK2P2fVfBX2ImtL1hqtj3OSAer4S?=
 =?us-ascii?Q?k4JLQ+yzz3roLM0ec3Uwcb/AFYhW2nVKOG6jXwmskcgDy6WVoJMgDC6AbPdC?=
 =?us-ascii?Q?c7qd+xE4azUubRYnF8/1HJQ/w03LzOdGAop4LEqy79YZVqnTqFF5Kg7VQEMp?=
 =?us-ascii?Q?NJfrPlNMIt8CKvDQzqYsk+R+/BRoPjiaQ2b0FFwtAcIH8u4iGjerQ/Lnof+J?=
 =?us-ascii?Q?FBY8F01VE7gKBUiQlBLBBDWi8+yQQyh59JOOIKp9THJ/yqgfoK3OmVXoVoCb?=
 =?us-ascii?Q?j/yX2w5t9sqt3Ddo65OpJ8IwH35XdnnSNDvXyEHr6jSx1WZQJfkCY4kv5gzK?=
 =?us-ascii?Q?VwjWpx5/j8MWHE+iVxPAFBGNUlu5uLWLwtKkJTYt0Vnj96aE+fVGDVpgHQYH?=
 =?us-ascii?Q?qyS5uN+++Wq99h/llAA+CbUbd/ooqLkf7RnpJrWJhuuPgG4O/sW6dMnycsSd?=
 =?us-ascii?Q?QGADsGoZGWxOjlmAHXZGQkH5ewIAUm6JF0TCuSbJgA9cBtHW2k2zBlRicroC?=
 =?us-ascii?Q?XR1X2pQpyT1oSOBmpzU/1mGdDE+mInEsCtkgjbL7JjvtQg1tUG4k1iovKgeo?=
 =?us-ascii?Q?WgtELH1EqmDSWxrWwsyxVkhoAqRUHC+2dSPV8BzxJ82Zmv2+Vf+1zjEIUVR8?=
 =?us-ascii?Q?yDmttYmjEtFrwE4/TPyunqr50OVBY7+EYk77/C7cSeB+SkWiggkIm3vb1DBb?=
 =?us-ascii?Q?ZM6Ca4pxytQ3ASQZ8clhtQcG4hryB+lLhfqHjMU39tKcG0wnW+DhVZ+K5bGV?=
 =?us-ascii?Q?gzYtc5TLthdr/fbRGzAmm08UupCrFY+GiXASGEN3AWS3C16YqjUtO43Mt5XZ?=
 =?us-ascii?Q?GNoXDtFP0lUFjQ7uFi2Gh+vPEgQ6Q4CGPJ4jmN+Ko2MrzqRvan+/IhiAyg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:41:49.9086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ef9553-000e-4e07-6651-08dde577db61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

For zero-copy (devmem, io_uring), the netdev DMA device used
is the parent device of the net device. However that is not
always accurate for mlx5 devices:
- SFs: The parent device is an auxdev.
- Multi-PF netdevs: The DMA device should be determined by
  the queue.

This change implements the DMA device queue API that returns the DMA
device appropriately for all cases.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..0e48065a46eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5625,12 +5625,36 @@ static int mlx5e_queue_start(struct net_device *dev, void *newq,
 	return 0;
 }
 
+static struct device *mlx5e_queue_get_dma_dev(struct net_device *dev,
+					      int queue_index)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channels *channels;
+	struct device *pdev = NULL;
+	struct mlx5e_channel *ch;
+
+	channels = &priv->channels;
+
+	mutex_lock(&priv->state_lock);
+
+	if (queue_index >= channels->num)
+		goto out;
+
+	ch = channels->c[queue_index];
+	pdev = ch->pdev;
+out:
+	mutex_unlock(&priv->state_lock);
+
+	return pdev;
+}
+
 static const struct netdev_queue_mgmt_ops mlx5e_queue_mgmt_ops = {
 	.ndo_queue_mem_size	=	sizeof(struct mlx5_qmgmt_data),
 	.ndo_queue_mem_alloc	=	mlx5e_queue_mem_alloc,
 	.ndo_queue_mem_free	=	mlx5e_queue_mem_free,
 	.ndo_queue_start	=	mlx5e_queue_start,
 	.ndo_queue_stop		=	mlx5e_queue_stop,
+	.ndo_queue_get_dma_dev	=	mlx5e_queue_get_dma_dev,
 };
 
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
-- 
2.50.1


