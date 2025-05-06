Return-Path: <linux-rdma+bounces-10076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E76AAC299
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C33A3BA15A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810A27CB07;
	Tue,  6 May 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BFqMRhKJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA027C87C;
	Tue,  6 May 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530875; cv=fail; b=q1NTvWnWWuTQAgs4cJma8zfV9tAfRZ0tLwISIDdKYwwMhXRG5reTojp5nobtoOrZQvuvaQIare4xYLoHJ0sqk0lpjv61PKFReucxmI3CfiJQgLPfxY67M17p6Em7SNjE7avycEJK05ZXOii6martZngtqFqurYhrLnlSHKEz+9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530875; c=relaxed/simple;
	bh=cvhhEasZVfTgOCHWP0Os8tPq1jSbgf1cDsQYbSFfP6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjARaLoqviX0ARDBY2QdutO/vbT8cBn0+yaiKqAj44R4xldubenAkvppg2eOddTW18nkuYp0jqxlC2FdKqpxdJ71qtH9TeTHZ9+OIgnrkd3FmruGYdaabjrgc8LBNxEUnFHbGZftmqOibzOZ4mn/sIgXLr+aFoY8ofeIP3k4HOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BFqMRhKJ; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqlLrtnO2/b7YEh2nAFfWgdbyvH/B0DOdtfvqB4HB2K3s0Um6di63F97zst/PWCSwC4Qf0kOSQgxmVAYfSJun7clcSlsR9Zzl7+rBkbTkvXey60OjXBHCTNOL6oyCklfD4rz/9lemDbpMDDYrLyMZtv0a9fMlWx8hxUUgSOmQbzrz10F3f2IzskMFKA1uaP+ElTJMYQh2Rj+9LZIqRGWEUh3iIQalk2dE4VqVdXyD+OT01y4t6c0Qg/MKAjAQPW3FXzUVY0aRutu1K3RAmcSPSiqpjVM4Oe7fau5TdZwNsWAb35HegLFGBcb+HJF9j174tWVixaORBpgNaRICZIz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8/rW+in+zfjbP8VVbLA/SAXahsmKtwglbaogJE+Vgw=;
 b=jJnL09HySELbZzre3DrB2KXTUOSWAIbIRJJF/o4oVU/fv+8BDEz3I0mNxmveTm4a5v5jiXPZq1E8PO4bsrU0iVPtdk3JtyvrtQSf7GxPIRBYVA1kP1udrba1dQ2BVRrruIxzPH7Kjah8+l925gPW1st4mVu/WHO4MtTjhW0bQzSNNbHRVqyTMHzUxhzEjiRXXTh3K1elJ7BnqTMI0NhZU6GgpzqgK/s49MltNXcT6Pv15Iu0H1L/XxMHKX5vLdUvAxW1zk8QWOLqDHBEQGc4U1Dz/4AZRnnJzQ5b25r3lIiUjFLTMENTAPfBjb3L3OAtmS5DhZ5oNmgPLop0C74oLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8/rW+in+zfjbP8VVbLA/SAXahsmKtwglbaogJE+Vgw=;
 b=BFqMRhKJFQwdIYQ5WDZlsWsbLtDaFfZ7yxBT3rJ/+69hyw8b9rmYV0fas31KVsg/ZcAQ8HGQZG5cD2/4zC02mhv28NDAYwW1MsPP33baNHDYElMrNG45UaTu2kbx3qXxVmTdq5TqbTZEZ3pR+Oo0P4fl5rTCMLZU4IQyerl6+ZBYwXQBLDy6o0/o8h7ljlrLNmelaTl5YbRbv8GO9cyJLcSbgjJGqI+HE5E2rcQkuvCClB9wyWNI/kcgzpQoHGKol8haMixR9hzMAOG35zAL81zqPsJKwobcqJsUeeXgnSEQrQ1fajaL+ZJia+IqAhDtXMjinra1xE/ZoG+kE2y49A==
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 11:27:43 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::48) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 11:27:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:27:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 04:27:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:27:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 04:27:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next V8 4/5] net/mlx5: Add traffic class scheduling support for vport QoS
Date: Tue, 6 May 2025 14:26:42 +0300
Message-ID: <1746530803-450152-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
References: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 69238bd0-c60b-484d-767e-08dd8c910470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCZLD0mKIUKN43hOmkrX953kK+R64vfqvah9mow/6N59yU2JKb6tATorV1en?=
 =?us-ascii?Q?/hdXEpjAocHK/7FmMjBzTlYfYe+Y/igRai8OnkT2dzArzsuIZt/1vwIughlm?=
 =?us-ascii?Q?op1fZRqbZMcNrN/g7hR6jeisaq9J7WyfLf2Gov8bPx+2Cj0YxQZ8SEvADedK?=
 =?us-ascii?Q?dec8K3QfWRpMjQspBTK9bkK0zKhHX3eTzpsL8TgMZaeN//QIvb8tt6tCpNuT?=
 =?us-ascii?Q?j8ozRZEImjbdx3XS7RgSoNgdkEIHTUKGs9avr4N2jfUWFbguDTLFEDBb3/dj?=
 =?us-ascii?Q?goUlJTCBNGAghQBvvEaOzjZnotjeieT/V9jsU5Ti2DbioPzLbSwzXYbBW8I5?=
 =?us-ascii?Q?Wj0uYxmXmulGKux7gVr8bSJGf+WxuXEhg/P0lYVddWdsnyvye17BYpgdRhnT?=
 =?us-ascii?Q?wC5/zfvB7IrJuQbrHc+fjVHvspyBIKF9e7+lyDLibfcMv5PwHBYTRgpfv+V3?=
 =?us-ascii?Q?vp99ptXvRKyjJqHl316oziVIif8LQ5lQoLFmUjj+bG5VIasz/7a/AQ5n0Ol7?=
 =?us-ascii?Q?mnC3ymuBBpL1geD98XwvJmM29obFSfeukCcubZaF8BB1AJMy7At4mfj7roeJ?=
 =?us-ascii?Q?0f8nJ0MFviWfGmsxYOUm77Fuq4aPAz2xI2UjgvfQK2nVmXwbOEgElNr+VVy0?=
 =?us-ascii?Q?595srscmh2sFbJeXnhHHPjJuVxl5cBIS/InNNXGV37D2UT7gi9kvAGkeQmBF?=
 =?us-ascii?Q?ih5POf33SIcntMEZS1FXei6GObT2CLocl/AO+nOsOrAEBpW9aWk6j1uq1vK0?=
 =?us-ascii?Q?WhcTc8uOUWzfmfxerXLwZkzc3TvffwduMs9GXrwtiVKxKMFF6oYXvrVJvTWj?=
 =?us-ascii?Q?kscu4V9kfgTYb9fx28IPrOVlU0NK+15qZoZtqKUDVUAY9GtuELUhSkzIdEwy?=
 =?us-ascii?Q?1J23cQTxWcmA8MvEs0qoc5vaPzm9p6Z744/1+Nk/97y6Jnn1ckS/QBn6A3qO?=
 =?us-ascii?Q?gFVDJ/ig435whcgrRcmrdI4qvrvMEfXm7ObTMT2B9frY12uNdGF3H+vl29lB?=
 =?us-ascii?Q?66xc+9BUAdfzsMK70WHfg8RKPnWaF8jMqdqVJouE9M0r93cuADJc2PESIf/a?=
 =?us-ascii?Q?VfIyh4zmKkdBL3vK9SqDgFcpry8hDw8YvBho6wNPkZLtEUS0eo/UP1do2TN2?=
 =?us-ascii?Q?kC3aX22gO104hOvIRFv057/K8J64MUnejgVx3o3CBbv3nmtqZZkcEiYSy/Lk?=
 =?us-ascii?Q?4spoZt15Z+Ewj+8QuxaEWwzrH1f9h0zFVnYHfVuWoBdYGeyBTSqFEAhRLLKT?=
 =?us-ascii?Q?YrJ8KN5AslbAbiYXBFcRoVj3vsK+YiwmTMamaND+n8xseypmcn43PgHVB1lQ?=
 =?us-ascii?Q?2H8qK+UBd1Ai6TDMGdtWVjVg4k6XlLe71rdR+qtebX9PmFkgna9w/Venc9DI?=
 =?us-ascii?Q?tSTEhHlE6ub3CqnovfIVD0JiWuHBilfmwv5OGDsxds7t+vQ8UNQsB3ETdAa3?=
 =?us-ascii?Q?BVrb9FsJ+2d7UgMboJ6cD2r902pw8EZy8eflnPKCYJvnJIY0INmOrAs4tLQF?=
 =?us-ascii?Q?PKznDuer87Bs1EhTmhPUmmu9A9YHq1lO0fv+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:27:42.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69238bd0-c60b-484d-767e-08dd8c910470
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for traffic class (TC) scheduling on vports by
allowing the vport to own multiple TC scheduling nodes. This patch
enables more granular control of QoS by defining three distinct QoS
states for vports, each providing unique scheduling behavior:

1. Regular QoS: The `sched_node` represents the vport directly,
   handling QoS as a single scheduling entity.
2. TC QoS on the vport: The `sched_node` acts as a TC arbiter, enabling
   TC scheduling directly on the vport.
3. TC QoS on the parent node: The `sched_node` functions as a rate
   limiter, with TC arbitration enabled at the parent level, associating
   multiple scheduling nodes with each vport.

Key changes include:

- Added support for new scheduling elements, vport traffic class and
  rate limiter.

- New helper functions for creating, destroying, and restoring vport TC
  scheduling nodes, handling transitions between regular QoS and TC
  arbitration states.

- Updated `esw_qos_vport_enable()` and `esw_qos_vport_disable()` to
  support both regular QoS and TC arbitration states, ensuring consistent
  transitions between scheduling modes.

- Introduced a `sched_nodes` array under `vport->qos` to store multiple
  TC scheduling nodes per vport, enabling finer control over per-TC QoS.

- Enhanced `esw_qos_vport_update_parent()` to handle transitions between
  the three QoS states based on the current and new parent node types.

This patch lays the groundwork for future support for configuring tc-bw
on vports. Although the infrastructure is in place, full support for
tc-bw is not yet implemented; attempts to set tc-bw on vports will
return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 438 ++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 2 files changed, 422 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 9a92121cb4cb..8893aaf32724 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -65,12 +65,16 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+	SCHED_NODE_TYPE_RATE_LIMITER,
+	SCHED_NODE_TYPE_VPORT_TC,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
+	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
+	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
 };
 
 struct mlx5_esw_sched_node {
@@ -94,6 +98,8 @@ struct mlx5_esw_sched_node {
 	struct mlx5_vport *vport;
 	/* Level in the hierarchy. The root node level is 1. */
 	u8 level;
+	/* Valid only when this node represents a traffic class. */
+	u8 tc;
 };
 
 static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
@@ -148,6 +154,15 @@ static void esw_qos_nodes_set_parent(struct list_head *nodes,
 
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
+	if (vport->qos.sched_nodes) {
+		int num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+		int i;
+
+		for (i = 0; i < num_tcs; i++)
+			kfree(vport->qos.sched_nodes[i]);
+		kfree(vport->qos.sched_nodes);
+	}
+
 	kfree(vport->qos.sched_node);
 	memset(&vport->qos, 0, sizeof(vport->qos));
 }
@@ -172,11 +187,19 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT_TC:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
+			 op,
+			 sched_node_type_str[node->type],
+			 node->vport->vport, node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
 		break;
+	case SCHED_NODE_TYPE_RATE_LIMITER:
 	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
 	case SCHED_NODE_TYPE_VPORTS_TSAR:
 		esw_warn(node->esw->dev,
@@ -271,6 +294,24 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 	return 0;
 }
 
+static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
+					     struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+
+	if (!mlx5_qos_element_type_supported(
+		node->esw->dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT,
+		SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, node->max_rate);
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT);
+
+	return esw_qos_node_create_sched_element(node, sched_ctx, extack);
+}
+
 static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 					      struct mlx5_esw_sched_node *parent)
 {
@@ -388,28 +429,64 @@ esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
 						  tsar_ix);
 }
 
-static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
-					      struct netlink_ext_ack *extack)
+static int
+esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
+				   struct netlink_ext_ack *extack)
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
 	void *attr;
 
-	if (!mlx5_qos_element_type_supported(dev,
-					     SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT,
-					     SCHEDULING_HIERARCHY_E_SWITCH))
+	if (!mlx5_qos_element_type_supported(
+		dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT,
+		SCHEDULING_HIERARCHY_E_SWITCH))
 		return -EOPNOTSUPP;
 
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
-	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_node->parent->ix);
-	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, vport_node->max_rate);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
+		 vport_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
+		 vport_node->max_rate);
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
 
+static int
+esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
+				      u32 rate_limit_elem_ix,
+				      struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	void *attr;
+
+	if (!mlx5_qos_element_type_supported(
+		dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC,
+		SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
+	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
+	MLX5_SET(vport_tc_element, attr, vport_number,
+		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
+	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
+		 rate_limit_elem_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
+		 vport_tc_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, bw_share,
+		 vport_tc_node->bw_share);
+
+	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx,
+						 extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
@@ -617,12 +694,202 @@ static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 	return -EOPNOTSUPP;
 }
 
+static int
+esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
+				   u32 rate_limit_elem_ix,
+				   struct mlx5_esw_sched_node *vports_tc_node,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *vport_tc_node;
+	u8 tc = vports_tc_node->tc;
+	int err;
+
+	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0,
+					     SCHED_NODE_TYPE_VPORT_TC,
+					     vports_tc_node);
+	if (!vport_tc_node)
+		return -ENOMEM;
+
+	vport_tc_node->min_rate = vport_node->min_rate;
+	vport_tc_node->tc = tc;
+	vport_tc_node->vport = vport;
+	err = esw_qos_vport_tc_create_sched_element(vport_tc_node,
+						    rate_limit_elem_ix,
+						    extack);
+	if (err)
+		goto err_out;
+
+	vport->qos.sched_nodes[tc] = vport_tc_node;
+
+	return 0;
+err_out:
+	__esw_qos_free_node(vport_tc_node);
+	return err;
+}
+
+static void
+esw_qos_destroy_vport_tc_sched_elements(struct mlx5_vport *vport,
+					struct netlink_ext_ack *extack)
+{
+	int i, num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		if (vport->qos.sched_nodes[i]) {
+			__esw_qos_destroy_node(vport->qos.sched_nodes[i],
+					       extack);
+		}
+	}
+
+	kfree(vport->qos.sched_nodes);
+	vport->qos.sched_nodes = NULL;
+}
+
+static int
+esw_qos_create_vport_tc_sched_elements(struct mlx5_vport *vport,
+				       enum sched_node_type type,
+				       struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *tc_arbiter_node, *vports_tc_node;
+	int err, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+	u32 rate_limit_elem_ix;
+
+	vport->qos.sched_nodes = kcalloc(num_tcs,
+					 sizeof(struct mlx5_esw_sched_node *),
+					 GFP_KERNEL);
+	if (!vport->qos.sched_nodes) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Allocating the vport TC scheduling elements failed.");
+		return -ENOMEM;
+	}
+
+	rate_limit_elem_ix = type == SCHED_NODE_TYPE_RATE_LIMITER ?
+			     vport_node->ix : 0;
+	tc_arbiter_node = type == SCHED_NODE_TYPE_RATE_LIMITER ?
+			   vport_node->parent : vport_node;
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		err = esw_qos_create_vport_tc_sched_node(vport,
+							 rate_limit_elem_ix,
+							 vports_tc_node,
+							 extack);
+		if (err)
+			goto err_create_vport_tc;
+	}
+
+	return 0;
+
+err_create_vport_tc:
+	esw_qos_destroy_vport_tc_sched_elements(vport, NULL);
+
+	return err;
+}
+
+static int
+esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
+			struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err, new_level, max_level;
+
+	if (type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		/* Increase the parent's level by 2 to account for both the
+		 * TC arbiter and the vports TC scheduling element.
+		 */
+		new_level = vport_node->parent->level + 2;
+		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
+					      log_esw_max_sched_depth);
+		if (new_level > max_level) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "TC arbitration on leafs is not supported beyond max scheduling depth");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
+		err = esw_qos_create_rate_limit_element(vport_node, extack);
+	else
+		err = esw_qos_tc_arbiter_scheduling_setup(vport_node, extack);
+	if (err)
+		return err;
+
+	/* Rate limiters impact multiple nodes not directly connected to them
+	 * and are not direct members of the QoS hierarchy.
+	 * Unlink it from the parent to reflect that.
+	 */
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		list_del_init(&vport_node->entry);
+		vport_node->level = 0;
+	}
+
+	err  = esw_qos_create_vport_tc_sched_elements(vport, type, extack);
+	if (err)
+		goto err_sched_nodes;
+
+	return 0;
+
+err_sched_nodes:
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		esw_qos_node_destroy_sched_element(vport_node, NULL);
+		list_add_tail(&vport_node->entry,
+			      &vport_node->parent->children);
+		vport_node->level = vport_node->parent->level + 1;
+	} else {
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
+	}
+	return err;
+}
+
+static void esw_qos_vport_tc_disable(struct mlx5_vport *vport,
+				     struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	enum sched_node_type curr_type = vport_node->type;
+
+	esw_qos_destroy_vport_tc_sched_elements(vport, extack);
+
+	if (curr_type == SCHED_NODE_TYPE_RATE_LIMITER)
+		esw_qos_node_destroy_sched_element(vport_node, extack);
+	else
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, extack);
+}
+
+static int esw_qos_set_vport_tcs_min_rate(struct mlx5_vport *vport,
+					  u32 min_rate,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err, i, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_set_node_min_rate(vport->qos.sched_nodes[i],
+						min_rate, extack);
+		if (err)
+			goto err_out;
+	}
+	vport_node->min_rate = min_rate;
+
+	return 0;
+err_out:
+	for (--i; i >= 0; i--) {
+		esw_qos_set_node_min_rate(vport->qos.sched_nodes[i],
+					  vport_node->min_rate, extack);
+	}
+	return err;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
+	enum sched_node_type curr_type = vport_node->type;
 
-	esw_qos_node_destroy_sched_element(vport_node, extack);
+	if (curr_type == SCHED_NODE_TYPE_VPORT)
+		esw_qos_node_destroy_sched_element(vport_node, extack);
+	else
+		esw_qos_vport_tc_disable(vport, extack);
 
 	vport_node->bw_share = 0;
 	list_del_init(&vport_node->entry);
@@ -631,7 +898,9 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
 
-static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+static int esw_qos_vport_enable(struct mlx5_vport *vport,
+				enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
 	int err;
@@ -639,10 +908,16 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	esw_qos_node_set_parent(vport->qos.sched_node, parent);
-	err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	if (type == SCHED_NODE_TYPE_VPORT) {
+		err = esw_qos_vport_create_sched_element(vport->qos.sched_node,
+							 extack);
+	} else {
+		err = esw_qos_vport_tc_enable(vport, type, extack);
+	}
 	if (err)
 		return err;
 
+	vport->qos.sched_node->type = type;
 	esw_qos_normalize_min_rate(parent->esw, parent, extack);
 	trace_mlx5_esw_vport_qos_create(vport->dev, vport,
 					vport->qos.sched_node->max_rate,
@@ -673,9 +948,8 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	sched_node->min_rate = min_rate;
 	sched_node->vport = vport;
 	vport->qos.sched_node = sched_node;
-	err = esw_qos_vport_enable(vport, parent, extack);
+	err = esw_qos_vport_enable(vport, type, parent, extack);
 	if (err) {
-		__esw_qos_free_node(sched_node);
 		esw_qos_put(esw);
 		vport->qos.sched_node = NULL;
 	}
@@ -728,6 +1002,8 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 	if (!vport_node)
 		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, 0, min_rate,
 						 extack);
+	else if (vport_node->type == SCHED_NODE_TYPE_RATE_LIMITER)
+		return esw_qos_set_vport_tcs_min_rate(vport, min_rate, extack);
 	else
 		return esw_qos_set_node_min_rate(vport_node, min_rate, extack);
 }
@@ -760,12 +1036,60 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
 	return enabled;
 }
 
+static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
+				       enum sched_node_type new_type,
+				       struct netlink_ext_ack *extack)
+{
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+	    new_type == SCHED_NODE_TYPE_RATE_LIMITER) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot switch from vport-level TC arbitration to node-level TC arbitration");
+		return -EOPNOTSUPP;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_RATE_LIMITER &&
+	    new_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot switch from node-level TC arbitration to vport-level TC arbitration");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int esw_qos_vport_update(struct mlx5_vport *vport,
+				enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
+				struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
+	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	int err;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+	parent = parent ?: curr_parent;
+	if (curr_type == type && curr_parent == parent)
+		return 0;
+
+	err = esw_qos_vport_tc_check_type(curr_type, type, extack);
+	if (err)
+		return err;
+
+	esw_qos_vport_disable(vport, extack);
+
+	err = esw_qos_vport_enable(vport, type, parent, extack);
+	if (err)
+		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+
+	return err;
+}
+
 static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *curr_parent;
-	int err;
+	enum sched_node_type type;
 
 	esw_assert_qos_lock_held(esw);
 	curr_parent = vport->qos.sched_node->parent;
@@ -773,16 +1097,17 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	if (curr_parent == parent)
 		return 0;
 
-	esw_qos_vport_disable(vport, extack);
-
-	err = esw_qos_vport_enable(vport, parent, extack);
-	if (err) {
-		if (esw_qos_vport_enable(vport, curr_parent, NULL))
-			esw_warn(parent->esw->dev, "vport restore QoS failed (vport=%d)\n",
-				 vport->vport);
-	}
+	/* Set vport QoS type based on parent node type if different from
+	 * default QoS; otherwise, use the vport's current QoS type.
+	 */
+	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		type = SCHED_NODE_TYPE_RATE_LIMITER;
+	else if (curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		type = SCHED_NODE_TYPE_VPORT;
+	else
+		type = vport->qos.sched_node->type;
 
-	return err;
+	return esw_qos_vport_update(vport, type, parent, extack);
 }
 
 static void
@@ -1112,6 +1437,16 @@ static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
 	return true;
 }
 
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
+						     u32 *tc_bw)
+{
+	struct mlx5_eswitch *esw = vport->qos.sched_node ?
+				   vport->qos.sched_node->parent->esw :
+				   vport->dev->priv.eswitch;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1187,9 +1522,50 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 					 u32 *tc_bw,
 					 struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack,
-			   "TC bandwidth shares are not supported on leafs");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *vport_node;
+	struct mlx5_vport *vport = priv;
+	struct mlx5_eswitch *esw;
+	bool disable;
+	int err = 0;
+
+	esw = vport->dev->priv.eswitch;
+	if (!mlx5_esw_allowed(esw))
+		return -EPERM;
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+
+	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch traffic classes number is not supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	vport_node = vport->qos.sched_node;
+	if (disable && !vport_node)
+		goto unlock;
+
+	if (disable) {
+		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
+						   NULL, extack);
+		goto unlock;
+	}
+
+	if (!vport_node) {
+		err = mlx5_esw_qos_vport_enable(vport,
+						SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+						NULL, 0, 0, extack);
+		vport_node = vport->qos.sched_node;
+	} else {
+		err = esw_qos_vport_update(vport,
+					   SCHED_NODE_TYPE_TC_ARBITER_TSAR,
+					   NULL, extack);
+	}
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
@@ -1311,10 +1687,16 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node && parent)
-		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, parent, 0, 0, extack);
-	else if (vport->qos.sched_node)
+	if (!vport->qos.sched_node && parent) {
+		enum sched_node_type type;
+
+		type = parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR ?
+		       SCHED_NODE_TYPE_RATE_LIMITER : SCHED_NODE_TYPE_VPORT;
+		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0,
+						extack);
+	} else if (vport->qos.sched_node) {
 		err = esw_qos_vport_update_parent(vport, parent, extack);
+	}
 	esw_qos_unlock(esw);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8573d36785f4..d59fdcb29cb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -212,10 +212,20 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* Protected with the E-Switch qos domain lock. The Vport QoS can
+	 * either be disabled (sched_node is NULL) or in one of three states:
+	 * 1. Regular QoS (sched_node is a vport node).
+	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
+	 * 3. TC QoS enabled on the vport's parent node
+	 *    (sched_node is a rate limit node).
+	 * When TC is enabled in either mode, the vport owns vport TC scheduling
+	 * nodes.
+	 */
 	struct {
-		/* Vport scheduling element node. */
+		/* Vport scheduling node. */
 		struct mlx5_esw_sched_node *sched_node;
+		/* Array of vport traffic class scheduling nodes. */
+		struct mlx5_esw_sched_node **sched_nodes;
 	} qos;
 
 	u16 vport;
-- 
2.31.1


