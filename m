Return-Path: <linux-rdma+bounces-12843-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB12B2E326
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 19:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63A65E48D4
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804B338F26;
	Wed, 20 Aug 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZq6vZe2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6553376AA;
	Wed, 20 Aug 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710032; cv=fail; b=kfi7XJkBDTYm8askPZahrmVa6wlpWJxqlbwXvZKD6dBhEoV0j/+rTAV32IOJ6jOk/CAY7rizHWRuc++IaQTvaMy2DSu1VyUPxcRn+iFqNgEnf7J0Gwf73/TE8f8OfX50SxYxfPTrZ/hKLWQu3uuwYUoQ3jptW9xInIT1UAV64gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710032; c=relaxed/simple;
	bh=r5/I4lETNhjzGp8Yr+/MrUtoh587lQAqA1xtUoEsDBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN7cMGjqCjq3T96Z1KKbR9X5I36g85plt6sxylhCih3x4XNHi/AE2UgGCNOvSxOOcmwheENd1DoSBxR3Yieo8Nn5eqthOWnNyYotFte/VeM98ObqwZPdjHk+1SZJomV0ddq1J0oNpKVzNQRmjSPDogGVjjnp7bOVz0cUNIh7ffg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZq6vZe2; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di6IjpekTByEwGyyMJgv/5CFz59jIojKWw2H+i9COTYZj8UtYs8lyS4cZ/BVl4N9NTcxHENr9taixep08OugtLsnBqy+uwYl1zqnRrEWIjgPKU5qXMV8+UHIMDmmm+ZsARBzsZvo8Tk89jMb/Qg+Z/nDUWsPnx65l1GL6qys1z3C88CCC2gKHihghRHD6lR4mfcMA2GELQkE2c2+uVZ5FyoyjMdd4If+gkUTqk2uAp0ou4BWdG6+7LTXqd9CQYIGluNGbBkVcp1Pe1jACZPFVeZ7eqrDcHep89IMmiBqQAVJkcxLL1hZdPNhYENFdWc6JjlH7O3ldyqeMgSiSxf6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdZmkJJnXBfif8QT5LGiZDWZ4BWIuP0NWV7mCGb3qRI=;
 b=va/1wfI5vEfi8ywTmAm9RjILD6uqZEv8asKGgx9JJ/6euREVjA7u0mXmbm+uz83nRS/PFGIZEVVjMZ6GPhJ9MKKOo/TJaYiRjl67ssMvMxF6ZMn9B4QlHDxLdavxjFVUvcM0v9AWc6YJ7SDCuCgXZ/LwU1h16yeaNBsdv3Yb7Q7pVpSSJdQyNIl4lFNjvjBRY17mtKt3VbB0pSr1coWI1qaG80eyE9Sci22DkRxcC/hjk0dS3ujkvca7xE/IdeCU5DihIAt6rDCTQHWJr0ReKxvlub/dBXuAizrtQUpOtXuqRiuW3XF15RCHS/74LSRhRHrY16/15Be12MDAk0S41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdZmkJJnXBfif8QT5LGiZDWZ4BWIuP0NWV7mCGb3qRI=;
 b=CZq6vZe2zadfZRgi5EhyjK9uWBc4bq5Y6a3TYjyTaafUdAWs2Vey2bvu0H2/JyyOwuN/NoDTQ9VzHGRyl78Ljx6/CvbLpT5X4tJXnP3No6v7IA2bNJ1Jeegxp6OOGrFGC9Nt9Q/eh/gX5Uwh3hY2FC5JKAUAdOVaie+OSrTC9718CJyDk7S4E2YicdxWYozCnzE43w8lNBz/G+elkznKM+kYWYtFvXwOSlmPobtd4YB2Y5JXYFMazaCC2iuyllOLFhq9E9tx5u/DcPnk/EAN6YhDxO2zod1aieVBdotJzhzV8KuMSjJ/E7G79aRkv19IV+ReG2xEjvljPvbz08rkuA==
Received: from YT4PR01CA0444.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:10d::26)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:13:48 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:b01:10d:cafe::fc) by YT4PR01CA0444.outlook.office365.com
 (2603:10b6:b01:10d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:13:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 17:13:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:21 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 10:13:17 -0700
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
Subject: [PATCH net-next v4 4/7] net/mlx5e: add op for getting netdev DMA device
Date: Wed, 20 Aug 2025 20:11:55 +0300
Message-ID: <20250820171214.3597901-6-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820171214.3597901-1-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b141940-39d5-49f8-b956-08dde00ced26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7I7P5hUOj5i06TyrYZuleHc6jZ3Ddsl3YafUYqfFN4k9wqHrXUIyX3loTEEH?=
 =?us-ascii?Q?QRysmwf/9xyUF+zDallzYj3fK/VL6ellkOTPTCRZSi3cVV4URwBEIEsmpDBo?=
 =?us-ascii?Q?wlmo0dEAiHruGhKp8C8H7Q2u2/KTpwrKh6NX6ge4dU7v7WCGuKp2461NyPDP?=
 =?us-ascii?Q?dZGQCC7HAdyQ9L2aWdjxnqpr2iM291X1Wfw1nRoTKWZlkSBjnFzAR2I9XfiD?=
 =?us-ascii?Q?Be2sKOCfZUyPF+zCYTm/umFS8XF6HlNf2IYQVZNtKfAXSLVgviFiXlmFBQmG?=
 =?us-ascii?Q?emZ/7IDzaHxSkw3shEnoJAOhjZsnZFoF+Xg+OvxjqmYH3FY9QRICg4XrYruw?=
 =?us-ascii?Q?l7fjmTsTSqfIV43Qz7JKkO7+P106P8DLEC+j4yv6otVsX0W9swy+dI/exm6q?=
 =?us-ascii?Q?fyT94oId7rCuS8HqzP8cJK05FOcyt4pYss3IWYdCwP+V3+spTDI2kp9l3a5Q?=
 =?us-ascii?Q?ZI3gIwFu1nI6u5Jo6MOYLKPXBBITmg2NHzNO3lVb2oxlqaUwp3XALr4blFEQ?=
 =?us-ascii?Q?S98qYMUbnLJx0A7eHXfZpVCbR6Y3eEsyHbpIG5tSj7WE6gT2hGScgReoWuMg?=
 =?us-ascii?Q?vZric7VETC5CNvcZVu0FIYnfjE/MlFzjB9khiE2VkNvym7RcLn0Rr3YKjfad?=
 =?us-ascii?Q?bHkbO0eYGIzdS1VDnL0HxRA0j3y8A0gJ02IdiZLvcz56QMlCLTV9iA3UtfCi?=
 =?us-ascii?Q?BkpNgj/y2DMQmxv8LKhgd+IlacaOQGD2xCY2HglNXw5GWXtY2s0pD1tWMPrO?=
 =?us-ascii?Q?W3G9ycqSX2tO1z9drKUWcslaxF9ZkDzQ0VV0GxqbF4c/z9O/9oTenjcoFoOH?=
 =?us-ascii?Q?zviw9/xkAezEUE+l1SstL8qWw3NY6pj1/vC6gPOu1d80le0mbUWkpVSvG4/s?=
 =?us-ascii?Q?N34PwrZ6e73vJAMxPLr6ppmDtkO7oVG5Qn0TSJPUa4y97VWdE2Tg0iP4jtkG?=
 =?us-ascii?Q?/BgLvIO6Y6d1+GeYsy9kh7RXfZ1Vflv33Y4YgTfB4Fhf7qFQhXxKQ/yECwPs?=
 =?us-ascii?Q?50ow477ER7eJ+n1Wd6pBBmrYfEH5J+ffW3UylWoRhzObE0yMaRqPwHKITsWf?=
 =?us-ascii?Q?3K3+kTtm5oa/2kbnwUwvn9u36xAtsz+PFrn/8Q53BZ3kPRTH88CieuBjjQgl?=
 =?us-ascii?Q?S9CyjgQfYMUTobT1qpnc8T9uU34EaR5cVQERi0eT8AXTHNXkqP3RGzWaaZkg?=
 =?us-ascii?Q?X7u1FxIUrB6I19fpL9fZ2dPyXhlWXUCn7OnvBfOn6ZGO/+M1JQmgkEQJk56t?=
 =?us-ascii?Q?IVcUMpvsYh6TIKGE3HpMkLGCOiJWOPUVk3rh2/j3Ok0//OynDvjR0L00Gsgc?=
 =?us-ascii?Q?0fYXOioJvQobqbqysbZUVKqFT+C+vibgSI39096ABwrTZUrwu+P4oovkWzxX?=
 =?us-ascii?Q?QTn6sdJV+5tb6k2PegAQswb2cPvWaiT8uCjOCj+WbwjbDN6Xrn3VGgiPz2Ip?=
 =?us-ascii?Q?boUFaxet7Or+d+QQ0xla45fNGSMfv43z7JWzLnCpJJcBeUQKwoCsQqyC9bfC?=
 =?us-ascii?Q?1kcg9kc6ezkM1hqSSOTXzcpA62dqoAKv8vaXu7tfP8KAESa6lfF/dqTKzA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:13:47.7747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b141940-39d5-49f8-b956-08dde00ced26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480

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


