Return-Path: <linux-rdma+bounces-12036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DBB00491
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F8D16817E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jul 2025 13:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6176274FDA;
	Thu, 10 Jul 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrSRNhDL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64D272E4E;
	Thu, 10 Jul 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155706; cv=fail; b=kZO7ZkXhGRakWIlfks8IjOXWxBNgiwu8onldFsoy0zckAzFcJFBABQA78DQ3kU2Q8y7pmGqpPIDAI7DdMMz5/WTYXxIHn1geJL/dWZXPbfYTS+WsYGoeBqM4svyoNR7lQR9uYOBuFAeZtHIwzLDKTi+BrnmhjS6dtb2MBnRmp60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155706; c=relaxed/simple;
	bh=EIhB897hJmA9t8Todqyp3nwWGgkxRvqsWjDB0gU7WRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anhNKmND7+8ZNNf/xcBu7ujX1/9DQ1v4qleb1f4tlP8t5EAbif+P8leW+BiumL8YTTB4dI0hf63gab8/oykuyfxYLoviX2luBr/oTAMoDt5Xdj9dOXXBMQzbTvml6h/lDjD/uKk4SpQVg0X56EgKQCsun9Bww2SrrHmua/z+rLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrSRNhDL; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWy5okIjRIyukgMUabRT5jyVWyL6CALMA6qnYu8njOvH56p34g7GI9mHLlNJxu6OyxfMB2lCfQyt+4mTuy4Ost1Xp0eDtd5B07VY4T4bIQHshHFIzmWsmgEVmlyeWkLlnHc5BJZMgCYn1HFpihvQICCLN7xlY/xPYfvXscFFzUmHoEq/2tuB8Pv7mf25DRiS6JdGY+R1kCqjHM27JSrbwQORlHZ9DuEpEwQIZSLY/hEigDd1qFAUxSlYoNgAuMPcy4HrJmmz0OA9RXGQcZ9KBdIUlFzzgd1HzTNjMuKJpsosSIKgAgjYbrDKf80Xfyt+gmWyI5y42gS78d18hlW2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+aINXaMoe9qM8bXThudTVAFwa5oSCdbMT++46cjVLQ=;
 b=D6n/fPRPWawPPKmMqDfijUJW7EgUC/fBjFGzDdRi9mW7EhI7shtoL1FnpMuoFu8C8BNm1+SeaF3ocMj/E0fY/llZRNZm1IJvcAVuTtBO4IDVyUugjVH4laZO4DG3K5Uzbj5xbdZgjZwOwQ/+QJ4TARB23+xNlwl2uGxAsbX1lND9Cc9iKoJS93U746ZtJ0dPEslFTiZxqlDPmCdreyC/mHTCtl3rH4/2DdNb41JO4u+Aa8MYWPe8UzZ8A0wSHmsvIz13r7SeRalRzXPnSv/6l0Llw8P2COJI0LQexq1UlFDyJ1kRwegy0AxNRYhOnsUphxoawXQY6ggIWGp+5A5OwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+aINXaMoe9qM8bXThudTVAFwa5oSCdbMT++46cjVLQ=;
 b=mrSRNhDLEDHr+SxsSr/YnelrdOabcIuZBqQn7ELm9JjfArylZA601V5/dGd/zx+8gktu8dj0CbHd/1SDb47qjnYa8aA5gww0DUsjgZW1afEoEZ0nHBj2h/Yr3XOyd43fYhP5D8C0lSi+fUIVyAqv2yWinDx5/En1txM1D2lAKRAih3r9oJ5tYnqkhTgUhh6QYKvoSoV1+oZaUct0gvlTtAQzrmyE/9Wl9O5BGn7aJBuOTdjfYBjgM+r81pU8DN4l80hUz6LFxjvlijg4623TjdZLoXX/FBpaO65EmKEByZ9AxOBe8kqNtQqJe7L0Jngo8ZIwOmrl5cjFtLyTuRG9Sw==
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 13:55:00 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::ce) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Thu,
 10 Jul 2025 13:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 13:54:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Jul
 2025 06:54:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Jul 2025 06:54:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Jul 2025 06:54:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Add new prio for promiscuous mode
Date: Thu, 10 Jul 2025 16:53:44 +0300
Message-ID: <1752155624-24095-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
References: <1752155624-24095-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: a436af32-0177-446b-f75f-08ddbfb95c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjVlS2XIE0SHo5+qq6p4BtYKDB/YSltz+dKwSa7wdZ7TqfL/LfWF/eTYWRrm?=
 =?us-ascii?Q?MX4GL7VYbwvJvqrS7MnbqNNlZq8XsU0GrttjraDKuQ0U8hLppZ92ZGl5GveB?=
 =?us-ascii?Q?XuTamry0GjS3AR75i4IN3jTIJrrvYe2RT832//r9mNyDalfRWsjAcElwOtlj?=
 =?us-ascii?Q?wHjhuW1+5KW7UmYb+1qu7qCtuuQEvHzH2tyVmi0fNkXHkiO02T2jQbQuaVZ/?=
 =?us-ascii?Q?EtE7gLAWsH7RrQTUaoVllN5ZL5GxkPoG/cUqjw4XNP0M7K7aSTsAVxjhASAF?=
 =?us-ascii?Q?6905b6EihKcIIYqOiX/52CGxGADEaJ4FzPpB3h0T1kJ8+6weutx9m2j/PsYS?=
 =?us-ascii?Q?VZdP3VixkeA5VTKV8aYfUYRN22I/qKLqJiEiSZw9w1imqJXcNZ7ZSaQAVpdp?=
 =?us-ascii?Q?gTXQoWG8WWGruFeXMYlwFiYwJbh/RCET3pLbussaujR60dBfHEQlpjnc0czg?=
 =?us-ascii?Q?UAWnmChc5DxUOp6i9knfGlMf9BYpmhBcwti4QR/fmP8Mw5F5zJdFtlxoPOlR?=
 =?us-ascii?Q?aGe8SUADl2uXZFKCLgWU8SiLjoQ/hxng/tH6oFYneifYDAU0R+7awHLyW0N0?=
 =?us-ascii?Q?+f4lJsV2wv1iAC2qrhk3F6hsFdpV5SW+l9Se1efVc/dNoKRmtoMbHzCB7WnH?=
 =?us-ascii?Q?2rwBeJmoWbjeKZ5Ae1iRxeNYBUdJ7CPRkhPfRHKp81cQhbrFyqNcnVp9WPIU?=
 =?us-ascii?Q?5LRdmvHT5LAmnSe81+mQnkS4MN3rw0w84RXbAUfExTRGmfGJfUF6Ft0ePbzl?=
 =?us-ascii?Q?qK8L/ZLTHfbREUfsp029lEv//AYb3MZ8XZLBtuAs6XU52xVS3f8f+gic0/lk?=
 =?us-ascii?Q?d1HJm4e9j7VGtghrY/5ejT+gUe/TqDNf2WWt9DwJYVtHnCGR03nl4c9790zY?=
 =?us-ascii?Q?cnBH1wtMntpSZ0oHbsA8LOwQbKrdWES9jYHcJrexZ2COAG/8SRHicTgVsa8o?=
 =?us-ascii?Q?1BbCwXY1fv9K3Usz1JUjNlNlCwU0jQKZN0CChC+wOpQ/o7Rn5tXeFfayL74U?=
 =?us-ascii?Q?BepVCqh5sWdZ4GJ3PkqOQd8qStcH2uIAofNnmxkIff0EwYqqYy6zwa4eCAd9?=
 =?us-ascii?Q?q84YFsUpNE6CMRxIMNk6w2nfQu0tBSb5AIsPvAXDyeWJwVNki7REcWvikVeD?=
 =?us-ascii?Q?p0scdY0vQ7tD5GZhLC0eHEM+tH9dVpih2SMtuX0jtOSVKQZSDYkv/4mTNa6j?=
 =?us-ascii?Q?LwcMqoKlLbFowHg5+NgU1bJXnvsj5+ybAB3y1i0697b0nGCPz1DIHX+GcNt7?=
 =?us-ascii?Q?ar3FIIFBX3IqdM77VprpXJnOdVFCunjWKigPXUAucJIO6v03GUHf+qlUqfco?=
 =?us-ascii?Q?S6nZQfh+DbX4H9JSzDZPfERv+pxVb606bjaP3CTYgM3Ap0lwVauPBf1wpt1k?=
 =?us-ascii?Q?8MO5V8eqDylEcpEnJttaCZ2Rk5xVW05I3s6intBNhvY3b9ytC4JUHBbTT96Q?=
 =?us-ascii?Q?NhM/15+Fvq9GK4H1OfYdQG7Au3aZfcvyEH+bxCg8z4y0zENs/9KZpJcIi5D6?=
 =?us-ascii?Q?bRDfmWRINzqF4TkPtHgLZawDj9n/FWAFbB/x?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:54:59.7026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a436af32-0177-446b-f75f-08ddbfb95c88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619

From: Jianbo Liu <jianbol@nvidia.com>

An optimization for promiscuous mode adds a high-priority steering
table with a single catch-all rule to steer all traffic directly to
the TTC table.

However, a gap exists between the creation of this table and the
insertion of the catch-all rule. Packets arriving in this brief window
would miss as no rule was inserted yet, unnecessarily incrementing the
'rx_steer_missed_packets' counter and dropped.

This patch resolves the issue by introducing a new prio for this
table, placing it between MLX5E_TC_PRIO and MLX5E_NIC_PRIO. By doing
so, packets arriving during the window now fall through to the next
prio (at MLX5E_NIC_PRIO) instead of being dropped.

Fixes: 1c46d7409f30 ("net/mlx5e: Optimize promiscuous mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h   |  9 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 13 +++++++++----
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index b5c3a2a9d2a5..9560fcba643f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -18,7 +18,8 @@ enum {
 
 enum {
 	MLX5E_TC_PRIO = 0,
-	MLX5E_NIC_PRIO
+	MLX5E_PROMISC_PRIO,
+	MLX5E_NIC_PRIO,
 };
 
 struct mlx5e_flow_table {
@@ -68,9 +69,13 @@ struct mlx5e_l2_table {
 				 MLX5_HASH_FIELD_SEL_DST_IP   |\
 				 MLX5_HASH_FIELD_SEL_IPSEC_SPI)
 
-/* NIC prio FTS */
+/* NIC promisc FT level */
 enum {
 	MLX5E_PROMISC_FT_LEVEL,
+};
+
+/* NIC prio FTS */
+enum {
 	MLX5E_VLAN_FT_LEVEL,
 	MLX5E_L2_FT_LEVEL,
 	MLX5E_TTC_FT_LEVEL,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 04a969128161..265c4ca85f7d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -780,7 +780,7 @@ static int mlx5e_create_promisc_table(struct mlx5e_flow_steering *fs)
 	ft_attr.max_fte = MLX5E_PROMISC_TABLE_SIZE;
 	ft_attr.autogroup.max_num_groups = 1;
 	ft_attr.level = MLX5E_PROMISC_FT_LEVEL;
-	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft_attr.prio = MLX5E_PROMISC_PRIO;
 
 	ft->t = mlx5_create_auto_grouped_flow_table(fs->ns, &ft_attr);
 	if (IS_ERR(ft->t)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a8046200d376..3dd9a6f40709 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -113,13 +113,16 @@
 #define ETHTOOL_PRIO_NUM_LEVELS 1
 #define ETHTOOL_NUM_PRIOS 11
 #define ETHTOOL_MIN_LEVEL (KERNEL_MIN_LEVEL + ETHTOOL_NUM_PRIOS)
-/* Promiscuous, Vlan, mac, ttc, inner ttc, {UDP/ANY/aRFS/accel/{esp, esp_err}}, IPsec policy,
+/* Vlan, mac, ttc, inner ttc, {UDP/ANY/aRFS/accel/{esp, esp_err}}, IPsec policy,
  * {IPsec RoCE MPV,Alias table},IPsec RoCE policy
  */
-#define KERNEL_NIC_PRIO_NUM_LEVELS 11
+#define KERNEL_NIC_PRIO_NUM_LEVELS 10
 #define KERNEL_NIC_NUM_PRIOS 1
-/* One more level for tc */
-#define KERNEL_MIN_LEVEL (KERNEL_NIC_PRIO_NUM_LEVELS + 1)
+/* One more level for tc, and one more for promisc */
+#define KERNEL_MIN_LEVEL (KERNEL_NIC_PRIO_NUM_LEVELS + 2)
+
+#define KERNEL_NIC_PROMISC_NUM_PRIOS 1
+#define KERNEL_NIC_PROMISC_NUM_LEVELS 1
 
 #define KERNEL_NIC_TC_NUM_PRIOS  1
 #define KERNEL_NIC_TC_NUM_LEVELS 3
@@ -187,6 +190,8 @@ static struct init_tree_node {
 			   ADD_NS(MLX5_FLOW_TABLE_MISS_ACTION_DEF,
 				  ADD_MULTIPLE_PRIO(KERNEL_NIC_TC_NUM_PRIOS,
 						    KERNEL_NIC_TC_NUM_LEVELS),
+				  ADD_MULTIPLE_PRIO(KERNEL_NIC_PROMISC_NUM_PRIOS,
+						    KERNEL_NIC_PROMISC_NUM_LEVELS),
 				  ADD_MULTIPLE_PRIO(KERNEL_NIC_NUM_PRIOS,
 						    KERNEL_NIC_PRIO_NUM_LEVELS))),
 		  ADD_PRIO(0, BY_PASS_MIN_LEVEL, 0, FS_CHAINING_CAPS,
-- 
2.31.1


