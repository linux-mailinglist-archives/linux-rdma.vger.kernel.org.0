Return-Path: <linux-rdma+bounces-12889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7AB3368B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 08:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C2E1B22DD1
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB74286417;
	Mon, 25 Aug 2025 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7uyw8tA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020A283FE4;
	Mon, 25 Aug 2025 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103886; cv=fail; b=tvjBTdk+mevg1V0xlw77Geev2noVuOV83aUzYFx8woI5iA7KZcbwC1Er/JeJZYyqTGGhSNnK0cdLf4n2iCsDSYzB2Vh75GzLU4GVrm+U5mG/QMK3gZoHrxLdEB66wVwUugRSwl3GBXeegBhZGaOoZ5eUw592AF+Uvkd9ycnPnws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103886; c=relaxed/simple;
	bh=r5/I4lETNhjzGp8Yr+/MrUtoh587lQAqA1xtUoEsDBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrvJgqxNRbAuVI/6bcZhuHV2mDagLiAiwC60LeN2JcNWNviwWdIWxN4ycwo+ziLJUOIjutFy3sKL+IyyX/s40/QAVLr28QpAC+DBX9KPK/Lesq0l1xWeOk9uiKWK9BolCvKg7QAXyB6/b2WRnwGbFcBUbNgW0461eiYoOSWshoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7uyw8tA; arc=fail smtp.client-ip=40.107.100.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF1h64FrAbNXa1MZxKkjabTov3Ae9WZcF7QjlIEm03u5rX7/ynUZ5vWaOdqOGPmvN1aIhCqhW9mhchDIROYnvl57L6N50F+gy9ucPkEBrYzkPo6juOyYd2tvitKPerq1561Z3BlVlOw3or6WFKVHdfbQmBukjwhu6v4Fj9R/yswt5JWLJffTMTtG1cXS3ccAMh6l2bzPTHFNPn8vlDeA3mFJvBRghOGVJsLDEA3ttwf39Dhh5XOMAa51EmyiNR5NZmuXpSNWAOpLqmlt2Uvi0m8pY/bIUhFpIto/MYa7IHf4TgrHV6JivT9CSDPX1wXxlvSt7FlqBR04niAsyK1yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdZmkJJnXBfif8QT5LGiZDWZ4BWIuP0NWV7mCGb3qRI=;
 b=rV+uSl4LUvpXjZ+/qakh//MVsCI+WQf8STKJU9r01QdoUqgycAXGUm5QXHqvTuvuvEwu6PhQ8JBOWNk/pv1vq3v2l9Xbq8BRfcDknlR8MgLMJ1BPMU7E/GkN1ZHgiB7fJDZH/+dDlCb58SqXxHzC54hxLbYjBgP0YspKdqj+gSKgyAW129Wc55CkP60M7KIfhysLc1aZiFkFRA8kSv7+z9jF8UWwzpXynsQk172FlAZfzCZxlZc7LM2EWCfLjza0yjjtV1AHmgNui98LLVnKl3n2vNlw6Ch5ghTXTFwgom6k/EyiXf+2hL9JIkVSaKtDMsrIcxUA15KvwamjIbAq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdZmkJJnXBfif8QT5LGiZDWZ4BWIuP0NWV7mCGb3qRI=;
 b=S7uyw8tALA31zyX6sbnLRfRzd3gesUQg4RDVAhIJ6JK6win91jRWd4aGmEDMKx738/N5ZLYf2JUIoHNl9yOesO7yEIcPMS5yLY2XwxJgwzIpgyRAa9z8Sgf7hoZgJgLU+xPuq4Wp2cz/G1VVdfSa2Ij5MI6C8pcfxb6M5yVgAUUpEBmhkg0xKMnUIDSaf6LDvh+hMSMzVPUUaixFY1UsiFwFg3UbSg/ka5wKERYwt0Xg7jRMZPyD3ZOCkOb+OifMt9ZzT6OQC3UwgQ2A6+BUNiXEmXszF9TIpFasKL8nuuPtViQ6D7KlIF6RHkLcLzkJjj7+8ldrOss/ykZcboPRyQ==
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 06:37:59 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::84) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 06:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 06:37:58 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:39 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:38 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 23:37:34 -0700
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
Subject: [PATCH net-next v5 4/7] net/mlx5e: add op for getting netdev DMA device
Date: Mon, 25 Aug 2025 09:36:36 +0300
Message-ID: <20250825063655.583454-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825063655.583454-1-dtatulea@nvidia.com>
References: <20250825063655.583454-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: cc873a94-ceb6-4f4c-7668-08dde3a1ee83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IGSd1ePoLujLS8NyeNEA9e783rUJvSpithA5kwKeLyNR0AqX9+up8vZ65luF?=
 =?us-ascii?Q?XjTDofa0y7r+G1SSDBRWkwEdVy4DjUQaiUkHRzkDeKgbGPxPX4Z3grnts/Hl?=
 =?us-ascii?Q?AHvXi2+lXiAhh3vKZ7niGh9FUwScKpQTZ+hQHuT6JNWftaCGwqbKm0cS+JMb?=
 =?us-ascii?Q?sa08Rdy3n4wOZwugnQf8ssRUzyxmmmXqFyJEDq/bOfTgxGSiKm2HnhRQZ42T?=
 =?us-ascii?Q?/SAQXoAQNx9MYDBGOiYdyX3RFiAs+bddbb44BgyzlX1IvHwgjUA7FXeyDxdd?=
 =?us-ascii?Q?mdlwzRsldxL0wpwWaNPX6Y8ODyiU+IJLaouKuioYFrjttFbQ7JGJN4cRb8yx?=
 =?us-ascii?Q?yu3JdnNojgct6x+zTrLtJKiHs9DgiQhJZpr6H7z15F2UjcQBVlQgaWq8Thlx?=
 =?us-ascii?Q?fL+/A6eDOy4K7BdUVMxf8Hy+06XkKQKTDCaUSkaucm5G4Vy2NLfcRr+AJOGw?=
 =?us-ascii?Q?rjkQHLnQpNltw6XITQpg2v39gEEl3FEv8vE9OVK5ldSJZuUHM366J4nHYFTL?=
 =?us-ascii?Q?M7cK81M6m9SHs/y0zSfFPkTpdC+FPxibXNZ/U7KtaLj1aTYZuVG0wwE8+yEP?=
 =?us-ascii?Q?pR0ROmGSsBYlW4uD3w90wivpKy6Iy17xlzZMf5++SxbiQRtLJ/jQWr7twJCU?=
 =?us-ascii?Q?Z1g7PaqDGl7kQzI1vOcqPzeOmK7/DloZ/6s44M7V6C92JBBoJHcLbteMHltD?=
 =?us-ascii?Q?U0ydHE5i/7IoceN8SS65IjClh6aNNPGybNz1n0LWQxlLh1AxkDqSJeKjGhVG?=
 =?us-ascii?Q?NJrKxo4y3gie+owIZ8JsMurX1l9SQ9m1IO0zQ9YvSgrl6dgBHO5Q/XiDp6sl?=
 =?us-ascii?Q?KG2DLg9Rqqn7NI6CSOxEx/P3UfNMxuIoJI0ydV6vWR7g+lvwjPMm1lAEejaL?=
 =?us-ascii?Q?cowxlnTrv2L/GzS+nxLC9K4oneFflT/UL8IifiteqHydlU8jckAt+n0i58PU?=
 =?us-ascii?Q?qkiUwVacEUPVtbHV7Bpklj/rzPVvtEjouBtymN7hVycuRNkDeL1fbR2DZhar?=
 =?us-ascii?Q?tfti/yTj4MVKb5tKyiip+WSGzfG14JTQxG1ujQ3Bu4Wuncdaa3eU5Ph+lQew?=
 =?us-ascii?Q?I2ltFf0aj6n1ooEQWOssGoQqXK0EXpbiJnUkpLXt9VP+WkarT14ocbGgMVDA?=
 =?us-ascii?Q?irjDDiF/DTPvdSstYr/3QJ0B31G9dqXS/w31FGYfBJQjdd5JlsGbqpElIazl?=
 =?us-ascii?Q?R4yzf2litHWCzD2m0vPF1uiBM/rKg4oMUVbE7lLZg+9QaiVmvUBrqTOdqv0O?=
 =?us-ascii?Q?5pdsdFbvzP+VhPgsVhcboG9hDykZC5sEuuB9G0ChWKn6re4FcUtvt1Lo+7bA?=
 =?us-ascii?Q?9jTb6/G5+cTshXEdshXrq+RNFJ8qYQq7mq6sY/nSxJgYYKoWCrAVVagpWIj5?=
 =?us-ascii?Q?+MZ09G6fApv4glW3OOJdX+JHt3aXwvNF+YokXQqifhdOd+q8i9lMkv58QRF1?=
 =?us-ascii?Q?PB2xALyo0AHN5mRd+8E6ZV85a8zF9X1KwCvoPMVYPB4cpnkTQV9Puc2W+a91?=
 =?us-ascii?Q?NwkG2b3fgt+5NLO7g0l7TLqkNoWRMGlz9B5BNsWrgfmM38WTL/ROOtKh5A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:37:58.6014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc873a94-ceb6-4f4c-7668-08dde3a1ee83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

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


