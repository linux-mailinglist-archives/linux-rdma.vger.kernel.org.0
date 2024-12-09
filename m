Return-Path: <linux-rdma+bounces-6358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F49EA0E6
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013A4165DD1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1319D07E;
	Mon,  9 Dec 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mj+El+WI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD3137776;
	Mon,  9 Dec 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778819; cv=fail; b=jfeUfMPS7s1NHG48b4myP4gRwM7c9QrOwIpOd7Qo+DQDCXU+YOdORFnE2YbnadXnKmWNuNd1FZogEdRuQy37SMUYE5w3a6OqksbdfJVaAgwuj/mDmvYRM52xjhwAKDBsers1nt8DwpzsHKbLhZxl5ijCZNkENaCelyMoG6QHYdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778819; c=relaxed/simple;
	bh=pHPiHxkHVeAXSkJmkHECWEtJLRvdm2FGHKnjy3XcH74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ill8togqPcfrTMIcxhTHbKuORO5zCci2/ie9x4ucpdW3Bwf1lPW2A+HUmNWHmgaxn/w1xX5/u3otM9qb9FB1Nly/JlAiN1a7M+5V1BJIPWDExFRc0Qm/LD6W8pnvqdya0oNQY4cbnGNxv9b581HfEuP9491QA3ZTFRf0K9VpgGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mj+El+WI; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auIQ39JtfFwACuVUMcMuqNPG/wNrb5/ZDpGw8QJw9jlw9GxPRSa3k/HDv4GtvEliw4674WuAW8wOqppKIwKv9pc9/A9OSos00c2B+QmKQ3M1uRKEKS0tV4eQ/fiFj78UZjG/u5ZilIFOhj4QUk4kqlfubNnY052LXisaYuKDKH/1riMviIa65gjVUP417pubK3m10OGRe2+8clvVPVFERhpdCE2rMFEr4be5j/xUXbGzANfkhkQtmzWYAQZ2XVSclRzoKB8uHFiiEOuH+bKJUJwuiQhjFEyCGxha+YyPiOwWOcPHWjywqzx8vHlAKN0muSyvfW5nKIjXspNe8mtmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFQzAYTi2EezQBOcjrjkNtbQA0YlRS5M3RDhfwGiltw=;
 b=F6LRpue9F2ss9L621w0zQwugWyV/VsgAbO2WcRG/mLGHF0vH6LQtxo7oWSuTl74XVR6Rtg9ElOPI+xC/BJ8DrRpnISCVSvRngJgwIpdTparozFFjzXRSczohTj4PpOowR71q4r95hA+iMQoZwQFbXABGuRZXQ0vMOnxeHHtH60fo2ikQFKfIO8hLegtR7X9R7yUsbZP90LlX9gPOw610m8isRlVXdSm15iQRW647jG7J4rvSNvPO9nC5pQjU1tzlPE2Y0gJxcchkN/0FcwyO9+LiIf96t3Pa50Wv193X4a4zpR/R//zHsuZYIJsPZmdYK7eCreF1pVInTGq+yR9FHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFQzAYTi2EezQBOcjrjkNtbQA0YlRS5M3RDhfwGiltw=;
 b=Mj+El+WIP3yaHdy6QtR9/HRyryyJ7fNDXG9/IodRPEJOMCiOfD/R8hU0FUPkaV0gZRB7kXY2U/r2zdR8Okup28a5tAQA+s30rA7QzJAHuhi/YlzZ4bfCgEGPnXlSIh7tCxBdvgqsWmHbjAqgttVuk6tt9SJJxuHQNo+BWUBmEVTpKLcAiF5A1ZLbsDbBSD2bK59fnQIuTHTPh8hfBMIV+aJ8qVuzqVeKgBBwlwzc+WIG7PNORfELzDiFw5sXciupxRbbveiO/PfjP1MVfA32JbEeM4PnsJwz6vksr4h2Ynceqf5r3RwMQiMF4PYCyM+aYR0Ya6AdhbDUaPoxRJAcxg==
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:13:28 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::c5) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Mon,
 9 Dec 2024 21:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 21:13:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 13:13:14 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 13:13:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 13:13:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V6 6/7] net/mlx5: Add traffic class scheduling support for vport QoS
Date: Mon, 9 Dec 2024 23:09:49 +0200
Message-ID: <20241209210950.290129-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241209210950.290129-1-tariqt@nvidia.com>
References: <20241209210950.290129-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: a99d31f0-a8e2-4937-478b-08dd18965355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?60jhWHgT5hfOW/S8tGqFvJKadMzMrkaiASiK6dMDDfCjaHhUVpd3tlgtCJ4I?=
 =?us-ascii?Q?wtQAPgnUPwXtiphsp3NsiEvrcvvT2f/bmtiKWjFVyOA7V4dTfKtJKsjnD5hi?=
 =?us-ascii?Q?1r0OS7dm0zamGusbDf/+cJncQdR+Gk8SGIm1hMmecKGujqERquWxHpho+hsg?=
 =?us-ascii?Q?Qtj9wUeB49OhVr+s3ZOfsVVioNQ3BrwbzJ59eloidCuL/dQpOKK9ueA5Z/sH?=
 =?us-ascii?Q?kADwdF/SyzmoNsrjeH+vwtm/dbvgp8k8nQJt13hfkcRC9XyQQI4Iy9mTRd/r?=
 =?us-ascii?Q?fDA/1KPDKjx6GUunx5a3o4QPT2XLVUfGQlsbdesbpMdnZ8OfyzknDEBurEQ3?=
 =?us-ascii?Q?gtfkEpSY4mCDv8+Bq6qpThOR87dnBMv/j2vuYKAsJ3hQMLYI28zwG8QF0+iG?=
 =?us-ascii?Q?mpufmpeouQ1siP26yGh21dyxBPeXOzonrtFqdimxQCQfaciRAnjSi+qJw4wC?=
 =?us-ascii?Q?SWgdUglkPrrvByHqeadAxu9IuEWteg1FtDY3xwRuR28XVkKj9d3mG6XkX1Yw?=
 =?us-ascii?Q?kA4G9U4ly/wxFm/4P5r8XKhs8qB/9E1nL0h8YRomkIwVc0+vXQcc50Kyde1d?=
 =?us-ascii?Q?swK2I2QTody5ZhHVNlw/TqD507P4Uov4jNIWprr5FtRKYQxI89SQmsSjdXQj?=
 =?us-ascii?Q?W1FtmHG0cJkKlbs2dw+KKy7MKJfDfRVtuOE6cPc3uDDYtuw+U3dRB0vidjAO?=
 =?us-ascii?Q?siMxjSFh+XCLyTjV4yA8uzt571n+l7aM+PCP4m43taqkH169Lrs7EA8EKA+m?=
 =?us-ascii?Q?5AaEUDIxRtDu9ZapWqoNkN0AByqBs/Y4eB4jGN/RR1HQ0dVQRCGdMV8p6W2S?=
 =?us-ascii?Q?ihpVJCj2IN+Rm5nezfhlNCa92RfRkXIz2mV+ttkISF5pmf7SVyzfs/4S+w1b?=
 =?us-ascii?Q?JdErKonhasOjNivyychvpBF5wlAT7Vp59a+nGccLlgLpi5Us+ipXBIV0IT1b?=
 =?us-ascii?Q?g8hjbZJyICOo+CsKe9jjreKr3phrin3fAHXZ3Krs4TFAMHwGQqLoSWoHYZ2l?=
 =?us-ascii?Q?9C8OFokvJX8sV7KPYV3cdEveTFzWK+XWldKGxMElE0WwlHfEa5c75bihg/NR?=
 =?us-ascii?Q?zGtiRjg1NvBklhNbJnwF8I6vlb+emUTHV/qTkQog/OBAkpFBcQMbtu1vxXCy?=
 =?us-ascii?Q?XG75YY5+yFEdYOvPK052Gcv6vk1qXpudIFEdpBgcUK1O3Z4uN4kgeSp94y8c?=
 =?us-ascii?Q?nMmvBe+x69TrXb/ciJFrJgF8VPl5u/eNIIP3OgYaBwwPbJRGFe3vS4l+f97S?=
 =?us-ascii?Q?IXfeB5wkTtdVKs2vnhSeRGbZ/ERDdshU1VRf8ap2db4E/eRbirqgGsW15xG7?=
 =?us-ascii?Q?1wkPnxbEZQcbMrnrIFDfFnLPHpG019ULtJo8Ss8AExbJ7rxogt/UugqX+lfS?=
 =?us-ascii?Q?LuRWlShsWLfxyBWyaX6WWYx+Fk/laZ96zhNydV3bwvbuJwLOeJJ/sts+49ig?=
 =?us-ascii?Q?J17Iio83YtNDNM/z2YQx1TJ/hPKbTMP+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:13:27.8112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99d31f0-a8e2-4937-478b-08dd18965355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785

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
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 360 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  13 +-
 2 files changed, 352 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b17c3a82d175..afb00deaae16 100644
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
@@ -92,6 +96,8 @@ struct mlx5_esw_sched_node {
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
+	/* Valid only when this node represents a traffic class. */
+	u8 tc;
 };
 
 static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
@@ -121,6 +127,14 @@ esw_qos_nodes_set_parent(struct list_head *nodes, struct mlx5_esw_sched_node *pa
 
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
+	if (vport->qos.sched_nodes) {
+		int i, num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+
+		for (i = 0; i < num_tcs; i++)
+			kfree(vport->qos.sched_nodes[i]);
+		kfree(vport->qos.sched_nodes);
+	}
+
 	kfree(vport->qos.sched_node);
 	memset(&vport->qos, 0, sizeof(vport->qos));
 }
@@ -145,11 +159,17 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT_TC:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->vport->vport, node->tc, err);
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
@@ -243,6 +263,23 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 	return 0;
 }
 
+static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
+					     struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+
+	if (!mlx5_qos_element_type_supported(node->esw->dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT,
+					     SCHEDULING_HIERARCHY_E_SWITCH))
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
@@ -379,6 +416,31 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
 
+static int esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
+						 u32 rate_limit_elem_ix,
+						 struct netlink_ext_ack *extack)
+{
+	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	void *attr;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC,
+					     SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(scheduling_context, sched_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
+	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
+	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id, rate_limit_elem_ix);
+	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_tc_node->parent->ix);
+	MLX5_SET(scheduling_context, sched_ctx, bw_share, vport_tc_node->bw_share);
+
+	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx, extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
@@ -575,12 +637,169 @@ static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 	return -EOPNOTSUPP;
 }
 
+static int esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
+					      u32 rate_limit_elem_ix,
+					      struct mlx5_esw_sched_node *vports_tc_node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *vport_tc_node;
+	u8 tc = vports_tc_node->tc;
+	int err;
+
+	vport_tc_node = __esw_qos_alloc_node(vport_node->esw, 0, SCHED_NODE_TYPE_VPORT_TC,
+					     vports_tc_node);
+	if (!vport_tc_node)
+		return -ENOMEM;
+
+	vport_tc_node->min_rate = vport_node->min_rate;
+	vport_tc_node->tc = tc;
+	vport_tc_node->vport = vport;
+	err = esw_qos_vport_tc_create_sched_element(vport_tc_node, rate_limit_elem_ix, extack);
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
+static void esw_qos_destroy_vport_tc_sched_elements(struct mlx5_vport *vport,
+						    struct netlink_ext_ack *extack)
+{
+	int i, num_tcs = esw_qos_num_tcs(vport->qos.sched_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		if (vport->qos.sched_nodes[i])
+			__esw_qos_destroy_node(vport->qos.sched_nodes[i], extack);
+	}
+
+	kfree(vport->qos.sched_nodes);
+	vport->qos.sched_nodes = NULL;
+}
+
+static int esw_qos_create_vport_tc_sched_elements(struct mlx5_vport *vport,
+						  enum sched_node_type type,
+						  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *tc_arbiter_node, *vports_tc_node;
+	int err, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+	u32 rate_limit_elem_ix;
+
+	vport->qos.sched_nodes = kcalloc(num_tcs, sizeof(struct mlx5_esw_sched_node *), GFP_KERNEL);
+	if (!vport->qos.sched_nodes) {
+		NL_SET_ERR_MSG_MOD(extack, "Allocating the vport TC scheduling elements failed.");
+		return -ENOMEM;
+	}
+
+	rate_limit_elem_ix = type == SCHED_NODE_TYPE_RATE_LIMITER ? vport_node->ix : 0;
+	tc_arbiter_node = type == SCHED_NODE_TYPE_RATE_LIMITER ? vport_node->parent : vport_node;
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		err = esw_qos_create_vport_tc_sched_node(vport, rate_limit_elem_ix, vports_tc_node,
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
+static int esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
+				   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err;
+
+	if (type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+	    MLX5_CAP_QOS(vport_node->esw->dev, log_esw_max_sched_depth) < 2) {
+		NL_SET_ERR_MSG_MOD(extack, "Setting up TC Arbiter for a vport is not supported.");
+		return -EOPNOTSUPP;
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
+	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
+		list_del_init(&vport_node->entry);
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
+		list_add_tail(&vport_node->entry, &vport_node->parent->children);
+	} else {
+		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
+	}
+	return err;
+}
+
+static void esw_qos_vport_tc_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
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
+static int esw_qos_set_vport_tcs_min_rate(struct mlx5_vport *vport, u32 min_rate,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	int err, i, num_tcs = esw_qos_num_tcs(vport_node->esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_set_node_min_rate(vport->qos.sched_nodes[i], min_rate, extack);
+		if (err)
+			goto err_out;
+	}
+	vport_node->min_rate = min_rate;
+
+	return 0;
+err_out:
+	for (--i; i >= 0; i--)
+		esw_qos_set_node_min_rate(vport->qos.sched_nodes[i], vport_node->min_rate, extack);
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
@@ -589,7 +808,8 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
 
-static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+static int esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_type type,
+				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
 	int err;
@@ -597,10 +817,14 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	esw_qos_node_set_parent(vport->qos.sched_node, parent);
-	err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	if (type == SCHED_NODE_TYPE_VPORT)
+		err = esw_qos_vport_create_sched_element(vport->qos.sched_node, extack);
+	else
+		err = esw_qos_vport_tc_enable(vport, type, extack);
 	if (err)
 		return err;
 
+	vport->qos.sched_node->type = type;
 	esw_qos_normalize_min_rate(parent->esw, parent, extack);
 
 	return 0;
@@ -628,7 +852,7 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	sched_node->min_rate = min_rate;
 	sched_node->vport = vport;
 	vport->qos.sched_node = sched_node;
-	err = esw_qos_vport_enable(vport, parent, extack);
+	err = esw_qos_vport_enable(vport, type, parent, extack);
 	if (err)
 		esw_qos_put(esw);
 
@@ -680,6 +904,8 @@ static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rat
 	if (!vport_node)
 		return mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, NULL, 0, min_rate,
 						 extack);
+	else if (vport_node->type == SCHED_NODE_TYPE_RATE_LIMITER)
+		return esw_qos_set_vport_tcs_min_rate(vport, min_rate, extack);
 	else
 		return esw_qos_set_node_min_rate(vport_node, min_rate, extack);
 }
@@ -712,12 +938,59 @@ bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *m
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
+static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type type,
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
@@ -725,16 +998,17 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
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
+	/* Set vport QoS type based on parent node type if different from default QoS;
+	 * otherwise, use the vport's current QoS type.
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
 
 static void esw_qos_switch_vport_tcs_to_vport(struct mlx5_esw_sched_node *tc_arbiter_node,
@@ -1025,6 +1299,14 @@ static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw, u32 *tc
 	return true;
 }
 
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport, u32 *tc_bw)
+{
+	struct mlx5_eswitch *esw = vport->qos.sched_node ?
+				   vport->qos.sched_node->parent->esw : vport->dev->priv.eswitch;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1098,8 +1380,44 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
 					 u32 *tc_bw, struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
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
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch traffic classes number is not supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
+	vport_node = vport->qos.sched_node;
+	if (disable && !vport_node)
+		goto unlock;
+
+	if (disable && vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT, NULL, extack);
+		goto unlock;
+	}
+
+	if (!vport_node) {
+		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, 0, 0,
+						extack);
+		vport_node = vport->qos.sched_node;
+	} else {
+		err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, extack);
+	}
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
@@ -1218,10 +1536,14 @@ int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_s
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node && parent)
-		err = mlx5_esw_qos_vport_enable(vport, SCHED_NODE_TYPE_VPORT, parent, 0, 0, extack);
-	else if (vport->qos.sched_node)
+	if (!vport->qos.sched_node && parent) {
+		enum sched_node_type type = parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR ?
+					    SCHED_NODE_TYPE_RATE_LIMITER : SCHED_NODE_TYPE_VPORT;
+
+		err = mlx5_esw_qos_vport_enable(vport, type, parent, 0, 0, extack);
+	} else if (vport->qos.sched_node) {
 		err = esw_qos_vport_update_parent(vport, parent, extack);
+	}
 	esw_qos_unlock(esw);
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index a83d41121db6..9b0be25631df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -212,10 +212,19 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* Protected with the E-Switch qos domain lock. The Vport QoS can
+	 * either be disabled (sched_node is NULL) or in one of three states:
+	 * 1. Regular QoS (sched_node is a vport node).
+	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
+	 * 3. TC QoS enabled on the vport's parent node
+	 *    (sched_node is a rate limit node).
+	 * When TC is enabled in either mode, the vport owns vport TC scheduling nodes.
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
2.44.0


