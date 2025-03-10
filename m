Return-Path: <linux-rdma+bounces-8542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42CA5A631
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A721600ED
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8341E3DE8;
	Mon, 10 Mar 2025 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OqgC13uh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE41E8350;
	Mon, 10 Mar 2025 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642106; cv=fail; b=aSmPAmw6MGRcWmsJxVZ5mcgwGNA1Yv1y8BnXXbY0O7odohrMiyVnEABA1lPPfbJJS8M0E9I1jk7q9x4yVhu7U7EnS7HVJQ1AHPJHsCB62c9QmVVpQJ3wDnBb6fy/pngcFMbsdsdFa9ZXl0ahwk8ASyaDzG+kfYPcbFMOhIa4C8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642106; c=relaxed/simple;
	bh=xLoiRds7lAD/qpQGjRoV5KdKajnzqgMgt3YG5aBBOSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7YfGPlci2DJNDu4L+N4bHEE8MM2mFTD9EJz7QbC4oDwaeSRVTkRGysurcKoDfUJyE1wIFH+3ZMj0F/7Z6NqRG0a4MNNDaHGbiIZucrF/7oruoaKQjs9oN1nRahBO9NEzvCfEHnPXQw2Xf0fX8P496AXfKwxy4Sj7QGSQGNlwQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OqgC13uh; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvsQn7YGjZGTSTdNECRcZKhXcLkVLuCUl+NdU+3VrLa9z98a9qlMWr/OLoUxXJ+QYPPbH31V8US9d3DQeyfXkDca9ZP943N5KN+wdgItYpGShOFSvisBHnKbtHfl0gcuxZJ83sTBYlxyEi4BkwrbiFG1C7DJeqSWbaJECYyXZhoLw+KC9rk5OO+e0H4/2NuoFOW2UY3k4Fs1RI7vgiZkZEKKl61gn5DPlN3fJd5INtUh4IeW7Kkeu+zbQsDcbJh1Cm+d5EuWkMk5CLYgjQfNk51cB5JJwCMn8R8XGA9N1VuGFlGCt7httKB6EX7K//1jAhM8z6gKcoABfupwGzo8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD3HIWXc14nlCgHNCXGtwsaw0vlZC53pGwT4+iw8HPg=;
 b=QhIZcjjZrz6l+ubCRTW6qY6900vwJpcY0Raw/2YDIGQkA4SG2Mr7kMc4+I03k33nJOHOXJbRilRGuuYeUpOQwGm/D2qGkVPA0h2V+2g4tXjM3+GD5HLRNpQOEeHeV9loZTvO7Cf8ovHpgDO5QTibjKUJkT8yYGaY9MB82SRjzuu6ezcrM4QlR0TGnz82lRrEV30xRMz98cIg0N6SYA7/O8tR6kQpaZwqHXcs+biE+IOzqHGbwrT49ePKlBjJY0iOGlimJe6uqykAGHHiqGXPAsw5ieK/zKTRvjJQGXY+mVAjJTVAhY2tK8SDuKeVXFZHUXHDb/SHWWvZPRPs5LcAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD3HIWXc14nlCgHNCXGtwsaw0vlZC53pGwT4+iw8HPg=;
 b=OqgC13uhqEYBxUYV/cpeMko2inaKZllkAnJug8kUxM3CsdlUllwEVMsV5e6taH+6xq3QuZhL7YvsykJDFRPhl0TY7FKdJQLrv2vT55AqBTBVitkWx/3GBecejcM1sEtZZsWPU0wh18nxWqZqEuLVkppgYYe4xADtjPavcqqWQK3YeTcpwuNqLow0O/hTsLx4Ig6WKPqva4zYw76YdtzzsayWJEh4HQ7T0d6aGgyBL7q76d5Dg0eGaaP+0xz9wvo8Bqk0fejisilzuAOgDVNdbU3KWKdLb3HdIJhUVNeeOOzrGD5JDG5xKUGuxIKsZzoy+Ieuu1L9lpzR6ireJ4bMuA==
Received: from MN2PR05CA0019.namprd05.prod.outlook.com (2603:10b6:208:c0::32)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:28:20 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::40) by MN2PR05CA0019.outlook.office365.com
 (2603:10b6:208:c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Mon,
 10 Mar 2025 21:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:28:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 14:27:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 14:27:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 14:27:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 1/4] net/mlx5: Rename devlink rate parent set function for leaf nodes
Date: Mon, 10 Mar 2025 23:26:53 +0200
Message-ID: <1741642016-44918-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 787974c3-b921-4374-73e8-08dd601a7aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/YRMvU0YjdNmN4gP0wrYMsNp+ShYl3nhs1kUUksiAqhn+C5y7/Nuo05p9x8s?=
 =?us-ascii?Q?USf5MozNlC5fKO+5mgpB7eWzwUvq1Wdr8+eQtsj+QLl04+u1mVy9eX3XNMvI?=
 =?us-ascii?Q?b/prM4Ct/+ir1RF5ylXONHg9IrkGjotMCKc6axMbJXs/buaw4rBHZadoGIf7?=
 =?us-ascii?Q?SDscIs/83SRcDZlduTsmkgowLfnnQ80RDuKZkO+1NHfTf01xrwWm7gJM1Piz?=
 =?us-ascii?Q?cxZ90daLa6vwOsGHVx5qyCx87qwXlyQES9RpGnu4NSjnaGbJwH1R91nTJd7g?=
 =?us-ascii?Q?44Js7HdZAnXZllF/nWF7BLQ9wcd43Maeekn1AVG4hflX4dXtiRn2mWuYKHVN?=
 =?us-ascii?Q?f1VgFU7sPqPzBs7Oa5H4+2f/pszo2QzQp3saqy/6fIHM4EqnYPVi0HnqmyDq?=
 =?us-ascii?Q?Jmrqha7MBzYz/JEwsA4cetWAQW+jT9qvK8v/nmHywcrdQI17zmnuzV2QkEbi?=
 =?us-ascii?Q?BJwq5hNUuMQ+Jx+10naIc5ZHwbJ2CMY98qdE0EIwJA02hJihaMlaL04GWwdf?=
 =?us-ascii?Q?jeiTzbho2YosxPKsUP/DX36YRG+788Gk3xpIsL+nFCcCrQjnEuVOjDMPiBqo?=
 =?us-ascii?Q?tUbmixyqNxMTlaB1NS9cnnJ8k8pedKE6iOucbFs/3b2SY0S96wAS2wSFYAp0?=
 =?us-ascii?Q?c1/tBAcy2k9o8XMMkRZpkAfT3XYUNz6L5UDRSKrA+zTTtriVLUsWa/6Cr+Vb?=
 =?us-ascii?Q?XXAiwHS/r8mC3jtAqruaaupdXK7aOjVk2JTyfGZdoDOUXl0FzcSTAk2BdRY6?=
 =?us-ascii?Q?ImFJRXOTf+pxxoN+kEy1oBMaRwQUteEhbrVpKwyA2Qc5s217vA/rJio6Xclf?=
 =?us-ascii?Q?iLOhEisxennSmkVQ6yfY/diFsk83Gqxfiv76nS2N1XlbP8NH71hP5nuIVQUa?=
 =?us-ascii?Q?bUUH2TBYq+UiFsiVEfvBCBrCo5wjthLGurJW/f8+X5l8zGmvw6idA7C++SnR?=
 =?us-ascii?Q?4mG3nnucuqItdJwjN6aKMjvicm3IhZ5HV3OtV6HmFtGnK8yKiuCHXWVFya+s?=
 =?us-ascii?Q?/1eUBwjCHQm/NuK6X4rTeEl8R0MqYgNkCLOv1iqRsJC0kWB1ZnOrHPC0qFtC?=
 =?us-ascii?Q?B/XDDbLr+jBEPxnpQrGzIFjdKg8f7gsNlmItsbJC1GpD25MD6tlY5cFi4gDx?=
 =?us-ascii?Q?KxMw46jWpCfoBWmvaztiZLFcCo1CBXnQEpxxqgVe88CR64KfVDS7Be+hAZDA?=
 =?us-ascii?Q?gpD6dbQcUnxaZjr6WAV+gHdDU25mJ2tzVD0g8c8X6f63z4EsVQNM6ZisduwZ?=
 =?us-ascii?Q?j9ItzToZEU8GjtyI2TCuRlBGidWchFeE1XC/3lkR0QyMFmsewIKpb60AXQxs?=
 =?us-ascii?Q?7HKg2Iy4YhtK4MGTvBIA6wmgrFKvdLh/lNb6oBWtpHDQ0TWTgtz7ZD070+pS?=
 =?us-ascii?Q?2IWasNx9Iacc5/rfPx2GnR0xA1yBvEhR7kjun02Cc90PG8PVY8tq1IuUIUXF?=
 =?us-ascii?Q?JGMToosUL+IRiY/Hji6syB5C0fsX2treM+0MHEp3EgnhWKENQwk6FlUKVb3N?=
 =?us-ascii?Q?8Chc23MN6NFvCek=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:28:19.9059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787974c3-b921-4374-73e8-08dd601a7aba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700

From: Carolina Jubran <cjubran@nvidia.com>

Rename `mlx5_esw_devlink_rate_parent_set()` to
`mlx5_esw_devlink_rate_leaf_parent_set()` to distinguish setting a
parent for leafs from nodes, which is not yet supported.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..39202540a142 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -324,7 +324,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
-	.rate_leaf_parent_set = mlx5_esw_devlink_rate_parent_set,
+	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 823c1ba456cd..c56027838a57 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -986,10 +986,10 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	return err;
 }
 
-int mlx5_esw_devlink_rate_parent_set(struct devlink_rate *devlink_rate,
-				     struct devlink_rate *parent,
-				     void *priv, void *parent_priv,
-				     struct netlink_ext_ack *extack)
+int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
+					  struct devlink_rate *parent,
+					  void *priv, void *parent_priv,
+					  struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node;
 	struct mlx5_vport *vport = priv;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..43a40bda7d19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -29,10 +29,10 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 				   struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 				   struct netlink_ext_ack *extack);
-int mlx5_esw_devlink_rate_parent_set(struct devlink_rate *devlink_rate,
-				     struct devlink_rate *parent,
-				     void *priv, void *parent_priv,
-				     struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
+					  struct devlink_rate *parent,
+					  void *priv, void *parent_priv,
+					  struct netlink_ext_ack *extack);
 #endif
 
 #endif
-- 
2.31.1


