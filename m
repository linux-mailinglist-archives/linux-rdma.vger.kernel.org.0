Return-Path: <linux-rdma+bounces-6215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6699E2E34
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 22:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F43B60A3C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153B0204F6E;
	Tue,  3 Dec 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ozm/UvsG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463DE1F75B3;
	Tue,  3 Dec 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257861; cv=fail; b=MQV0fZUX3oFvZ4IvhF2iWPXhXZfTr6/VkkwHY0nEcGyqnDpV+9nl7MRsfNqUJkIItXahuWn5xgiAdg7NiSy/sGKBERq/5eFVPhvvMZ3Rzfh+X4fVaBSqOORW5a/dZDdAjOx7+6kq+lc0fE7WNyEpsrwxorMMvYYi4DpbbSjpTpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257861; c=relaxed/simple;
	bh=p+f0Rc2cXt21kTHLqooaSn39K7o1wGJSQMQlC7VmNFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YI4f9/0S5bRw/AjbCMizCOOyPa8x2vaItBaqw0ixRM5pr0RmoLVH4nsXbojN8z9kOBvvpZXBf2k3uRAB0qQ+qpI7pz9+mHQgRJ8BdzL2zz0hx827id7or6YQhiTTI7DKZ4usuLF3Q4cD5a7kZgsfQ5IK4Vv4gVJSW3jSVkT7UdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ozm/UvsG; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXcBPqPG4q5a3KTdONUwLqAm7Prh2K86XLIKWfDOJUu/hZlrg3GM976Om4bJo99a71UlK9ZTUTyBN1RuvUC9RmYA/GhVDcGUWt31Dvuc8wyDPy03lRACde/c4JxwgQoRWsT4P1SEbgv9mN+uXKF2a4lOh+2qFi7Gv5hsl9tnwpz2zpYvPhekiAkxnAHl0dxI/TUjMBX03DHTmDflSBhL9u1nN+jcKAl8gqYITBpT5FVwzo/L/s6s0Tp8cyFT1xLvkYR4iYsK3U1PO6TcD9OpKGfojUzCPXqIaTRU8+EFQRbr1jSQb2fZyOk+xU05FNmxgxswxFDwndbbCnXPG57muA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=qbnXzv88kT6cgQm4O5Ct+FrXdq+dXFYMFSY8tEODQh/Up0gPSExuUn+hSYvFoTgztzZgj6wjGNC8jrQvHIpxueDN9Tu377EO6EN1dZKcPvG5Ojt3O1qSg2BzyulZ+X10rjiAqJwfkKwIafYqm0+hmGMpdT+ZkarM3iLVsd7uJQilOFMjh2pG0a6/c5fD8iT90uTYu0unEEm4Oe5PDhpSYvshWrenqc1xn1V9fmSwYRG4UnXh921sCH8J/D5CRbUV58R5cjLBv9CUyQZehHhKG9GOlWM4unKpugbyVKr1u/5fm8HZz/z5Jrsl6XJPw11vHpVy+JOWeV5wf8lEO8E8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=Ozm/UvsGppKUNyF2OVqynqdXLtg3K4taVlWY3u21etOVQv6aNC+Hi9eNafYjxg69wt8T+DvUY1QbshXqbKyHoxnqU3a0P52wehaHhRuS2pSX3qjDhJIgkW1e8UWeYQK/kQzRFgeqGQytqHo2sOvVIgQz57kQiefoe0+YpcFd1N+uMtJ+i5toBqyHWFkjOJhyffXZrSibgbf6IENmjSGst4Saj6WcfWTy82btaottEDiPJ0F8qGVurF4zQY/E8nNsc7LLJTFNSOUngFST+8/vTs0K6hIUVz7sCaP2GtSYq6IBzPSW+AoHHk/vHzQgEoDljLeS5bBWiBKb0p1YgJl6CQ==
Received: from MN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:208:530::34)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 20:30:53 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:530:cafe::1) by MN0PR02CA0019.outlook.office365.com
 (2603:10b6:208:530::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 20:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:30:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V4 08/11] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Tue, 3 Dec 2024 22:29:21 +0200
Message-ID: <20241203202924.228440-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc5c8bd-ac0c-4d53-c7b6-08dd13d9615d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lVHUm7ECHze6jeFIkje80OwFuf6oKGofi5LFktH7+OkyL3xc+sUiCrY7hNHw?=
 =?us-ascii?Q?39W76mhVN1o0aq6w6sbSL59tjzBuVHmXxUMTYKI2mrc3V5zYBuQola0hVmP8?=
 =?us-ascii?Q?MQHrta8qSvkV66Y2NuEpidyXtZtLE3j6l/Mjw6JLj30xDqvNJe/Yk67G3Vdk?=
 =?us-ascii?Q?kAApfQsBnhd6ryZqPvI5dwWMRF74XaD2WcfbTV3IECqP8/L+aZxdqkfyp37K?=
 =?us-ascii?Q?PjPW9grJqjmTjhpszUEAKllqsoT1j/g7l8LuUdLvyuAIYoa5Jf4z4ONhqdJ1?=
 =?us-ascii?Q?mIPRqL4JOyoT4khkteJ4AOgJdD3WjjqyI7r78w0niwpvws4M0cpQDfHFoxKH?=
 =?us-ascii?Q?IS/X81JHJvCzJYGWnMmfyMzAiDufqT1mY7NlmYaWB1LRId93IitUqGZ+s/e+?=
 =?us-ascii?Q?ktZnj4VIxLywpT49SJ4IeZwknth9ALzjsVacbwNHAzueWCqBdzzg66SUdmyd?=
 =?us-ascii?Q?q+eeM1Zs9ORhltAdrgZ2Huv7ArrqFMVATw6aFjBhCkI2IIDg2IONSxEdnn4J?=
 =?us-ascii?Q?IRt3Cs/Y0G6z5MBX/w7HmjT0FMphcq7JRg0IVcmJQQgJJRzBWeWd8FDOWJ5K?=
 =?us-ascii?Q?J9cqQUi3yPi+F9PxhvKqxbzqvq99s/fEtuVy1I7Z2Lwd/c1+70BeQHHzLLMz?=
 =?us-ascii?Q?zG0fVmBxEds8vxQYtoopwOWoE/ayk4LuWPrvvqAyYR1HgymRpJSH/WLU1F0Y?=
 =?us-ascii?Q?Vq/6z0YbSCElb2vgszuvjrlS4FngC9+l+d3Qdq2c+5ExWsXnEg12n0ew2M5n?=
 =?us-ascii?Q?uaYkl145cYkqhNAKABXNKSRyR1C8KPrB5Qocmkz8AmiVG0jQAfi/nsLL05yq?=
 =?us-ascii?Q?2EWUoDBxNTcMSY6kjyBz3WwZEvVPMIxIBs17ii5ERATm5r7oUNWKlSONRWUM?=
 =?us-ascii?Q?gLKRbzJ2lyJjyLcqfNMYSD/LLaSTyF4z1pAZE3vVp1OHpEwT4xWNUsqDgvED?=
 =?us-ascii?Q?hrRHohCg0bXvAmAwnj6a0Mtl0Gt4unOSBTrfV/K3JRpuIVM+m67B1zsPQFNX?=
 =?us-ascii?Q?BXr+V4Cl5RijO3ir1bF+qDKWbHlIfzdK0Pug9Q7jzZLXB4ANftDP3JX9Wowb?=
 =?us-ascii?Q?jxz0kCPMXvHjDHy4AohhxaMx1Rba5ORsxaHJeLhHj7BG4lCIX1gHj4RPtXru?=
 =?us-ascii?Q?X+aUkH6VEYiY/mMnbaFiu9fzzdA/r+ecu53BGP1zDMHg7Zf4LFecqPstJRAF?=
 =?us-ascii?Q?dFYOlCEkMv7Qxr5E7uqzJEc45wSsOEf1v4z9YevWBY9Dzg/UOxke9llwRAHX?=
 =?us-ascii?Q?jLTz3n1hE9vMB2jKt50yCtKqSq8DosnVK8CYugHmUoWHx0M9Q4zCg0HxI+LK?=
 =?us-ascii?Q?uXe78yA4oYqn0Iu0ZuI5IFzHNgj8k/eTX3PxMGigOOPZjNe5u0JHfQg9/Czj?=
 =?us-ascii?Q?UATkkFD9eMK77sHmLfAFcIo1tAhyS+pRnpB2Ro7yTGiV1fGeOzo+xdoSuMPp?=
 =?us-ascii?Q?mkmpEDRXxPx6suqbLelQcNTcn7l9Ripa?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:51.6814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc5c8bd-ac0c-4d53-c7b6-08dd13d9615d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..728d5c06d612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -320,6 +320,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..db112a87b7ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -882,6 +882,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..0239f10f95e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.44.0


