Return-Path: <linux-rdma+bounces-8544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F628A5A636
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7093116A18B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB61E1C3A;
	Mon, 10 Mar 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WPj2XU/7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59A1F098F;
	Mon, 10 Mar 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642115; cv=fail; b=SrCXHodNkjyL2OwafnEu03rpwtENxZ/aRL4VwAc5FJY1ocd0egWSOLk5YsjFWf4yzkP8HkHbEn9JtSf34Z21UKx/XslqZVDklmVrpvYa1vq7wblI813MWlhTzPAq328dSxkfTNumMDs5gUwJCL3gXUhMPW2SMAeP08HA4jU2djA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642115; c=relaxed/simple;
	bh=jRuO8yMYJr5BiftK3uSb6ph4e2fc08WTEDQ5E3jiRsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnX/8OLe3ZqbYOWroVYBa9P9ijLuFvUMdNR8l0dStyXOcqH1+FjgGWK7pMRHv1vyqegQUG8o0J9vw2TwBrKpM/msLDsOjKyGsKjS80KhQpEoRQjJ/EfxjDSshdSlE6mDYywtaqxvmPQQq3bApO2Zop10YBMaMzk0wuLqWt3/kVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WPj2XU/7; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQMYlkikD//WDQtXDGoyZp0cJ8lJKXgvJzHOfxRoZAcA/x+tWNpETK+09VXw+goGsBWkITPfVRgjBZLbjJriZ9WFst5c7xyX/05pNAFGRufe17Atk/T/q6o7mt7wQSF4texPPj5PcUXkuh9MGsU2W1O1zbgGbJsh+57yxqQRej5sJlEE3FLbYjHVfEigYvplsGdaTedxSM0taQslTHk3XUYW+OqHCtkJtZR1/r1zrt7RSQmKLH4NFWCgvwIFUkL0i0oOTGao2xRdeec9XL1QQ2y7AYbv9Rk5VTw5Qfvpgs77Z+PlRuLg0V8o+86cWF/hrGkVcfYLtzrvdtac/LJkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqMBN9p/+OJ12PcDV6OXtXhrQahv3O3kN1lDd5kUTRE=;
 b=pgj5gB8GmKXKQGTbbKtwQjwcJTB69PN/ahbsCwXMIm/abBtzs07hmjDvjy00nMlC/K2+PYKKGTIbK4puiuVmga+kGCd6dSdJGX352/M4zwmrjJTDoWewp+1lB+lmUXyScRo/4/D9GwXIvF8yIwE6fhZ5U/GOlHkm3gPoludmHuEDnGPJNhAUmJUJACCCQKSvBVSInPVaBmWNaH1dOt0R0w3zqkrIxe8HNnghvcBiDhtIZ59U72vhR7MRlkhkOkI7yzn5uOOp4efOs3813KRyNAmaO0/7S9CNPOLDDRfO6sR3JCxFvOMQyTTgUjHAqlsugy0Nkl/cyfUihxqwoOmy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqMBN9p/+OJ12PcDV6OXtXhrQahv3O3kN1lDd5kUTRE=;
 b=WPj2XU/7h48Lb/V2YR5/CCCak5XWm5Hr4FjHx6IjppDCp4eama+EQs/YMYgStvF6oYRayr+QuJaOVcZoMU0S9mLJjIByYaszpFifKFhkE40EP4jrEQGuVlPC5NvXtPkfdgACcNwNOen2OG6wI4o5r4ckeQzZU3GgRaXDFP4GX2K21MBZzMQ+Isi4K6dCdkzyEfc5Q2amviHYUy0W0/d9Si8v+WYVIKVW/8FGLHXrgNA9mt4erKnBi4xA2IrpbROsA9925DMakKOwmDhSuoCqorq5Z4S/Gag5NtAi0RWsaSvKTFMKGEHP2+HXnqYHX85lcrU5JOF0a4VP0GRgsR30CA==
Received: from BN7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:408:34::18)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:28:28 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::c3) by BN7PR06CA0041.outlook.office365.com
 (2603:10b6:408:34::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 21:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:28:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 14:28:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 14:28:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 14:28:02 -0700
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
Subject: [PATCH net-next 4/4] net/mlx5: Add support for setting parent of nodes
Date: Mon, 10 Mar 2025 23:26:56 +0200
Message-ID: <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 064c894c-be2c-497c-28ee-08dd601a7f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZzkaU+VMrQwKMRCyCmRYlbt4j9BOAsZ+naR12bLoxRKp22Ylv9Q3y838Y3Ic?=
 =?us-ascii?Q?0Us3LQkgQT2L19075Xlp7GzummCFCkCLbW1/CSNbD5+YDNh+gLsL5HthCjoh?=
 =?us-ascii?Q?cosYJF2lruiEBVzJxBpEz39Zvawk1K8C5QiQVYLXY3igFsQc0JP3Om6OJRPG?=
 =?us-ascii?Q?03y5xFvImjlteiBWcXorVnhVMPxtrs/wYGG+FOQiQgcwHH/T72rEzw0IYCMF?=
 =?us-ascii?Q?avqRIO/hHOpy3gcLsGpMsows2PLNsAtBOaftQWbtmyL6FMS/KulRSySnDkyl?=
 =?us-ascii?Q?kq+lRAayMqtgI4zA6/gQsYjnrLW4lBRMLdNJUQjG8y8NPu+QeFHRgEx0zKO3?=
 =?us-ascii?Q?c0vZHpbTU5uS4C0rbNe/z0v1AfEk4kHELCzT2rg+e8GRNlbkPqTj1b/mp69L?=
 =?us-ascii?Q?c9JBsLwkOMHprYCPBUCkK+p+KYttG6uZ3WxP6XYmJqEpD36RUMyidEA6Mbli?=
 =?us-ascii?Q?NJMuAGe3GmKINsRI0kzvvmWnIrNToOM7gCmet+aHHs3KoS2IjHLag0iOAljM?=
 =?us-ascii?Q?xiM1xulvuj9emGSCLsK6KmdEBINhgK5Hga5jQJtJaM97ivyZCBOlu5woSxX5?=
 =?us-ascii?Q?r4KIvdwYdpHsy31+WZTg/aXOFS8ALclW9M1NmzNfU3t91bIvsKWyiUhwbka1?=
 =?us-ascii?Q?o+qelM4ncqaVlMOokciskhWFawNUypkCmpFGPUWM39A3+5POVooxwIGHYqVR?=
 =?us-ascii?Q?afHlYagwzygZgoPs/RxXRz3R3Z3q8KJSFu3189ow+oPQS91T5Xai9WlpXwl7?=
 =?us-ascii?Q?nBPJxI2m7NwKZGGN72qzkDoKdUmpdRo0mIpXsGFK4EqOBhaAPlmngFYvdlHy?=
 =?us-ascii?Q?AA79G8G0NtKet7hV5V9ylynCxJZIAuks70yy2cZ/hr6wJ2V6/lS9+bp2jm8C?=
 =?us-ascii?Q?6UqAJbUNivVAG+il9fVvW/d+jYW94ECMRoIeclHv2SJtVqKmkfbO5Va6kk/6?=
 =?us-ascii?Q?JV8KUPk7uCoBnUFaPYkhin41t5xkZfuUzxwDj4sCHWCTEnDemMTb64g9X8l2?=
 =?us-ascii?Q?HHkfVOgQ14vdAQCJr0rnTI1/FZInpjun5JrEV2TTbTjHYDstLqDbUvqe7CcE?=
 =?us-ascii?Q?jWa1wsTe0vC/9sI/lUd8TngCU25HUsgpLfSYelhiSwZYdvm1DWU4K0zEZQMx?=
 =?us-ascii?Q?cbWpI+p4twShsd2vDAriDrsE+e48L345A7JApYVD6Pm87r4zbFdZVUQpp4ks?=
 =?us-ascii?Q?iFznailVEKNprw/dEahSCukfX8D8aKNDWFLjCuFEFg60LJeqayesgw/vXtey?=
 =?us-ascii?Q?f9t2tjRb3+KlqfufAHXq8cIiy+r5xj+jKahRZEfhFz5DU2up7QjVH+2inygt?=
 =?us-ascii?Q?156UiyWOT2PWra7Ozf4ktVwZjZYttcCFqTNQNzrCXR0GgL2lmjk/UN5+A/oU?=
 =?us-ascii?Q?F8EGozkfYeek6P4QybCkAu92L/FFUhkq/72inviFuWsnlcVq3J6r4f24Tfby?=
 =?us-ascii?Q?/rsNzWpD3CNZCu9Ng+cdBPK4E915xOB6lxtjSDA7Fx2Z0ras9M3F6irSQpdZ?=
 =?us-ascii?Q?MQezUfIQGwZGU9c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:28:27.9205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064c894c-be2c-497c-28ee-08dd601a7f86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_parent_set()` to allow assigning
a parent to scheduling nodes.
Implement `mlx5_esw_qos_node_update_parent()` and
`mlx5_esw_qos_node_validate_set_parent()` to enforce constraints on
node reassignment.

Don't allow reassignment of nodes with active rate objects.

Update `esw_qos_node_set_parent()` to handle cases where
the parent is NULL. A NULL parent indicates that the scheduling element
is attached to the root scheduling element, and since only rate nodes
can be connected to the root, this update is now necessary.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 108 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   4 +
 3 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 39202540a142..df5a2e717ddd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -325,6 +325,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
+	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 3c850efb4ca3..b6ae384396b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -111,9 +111,9 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 {
 	list_del_init(&node->entry);
 	node->parent = parent;
-	list_add_tail(&node->entry, &parent->children);
-	node->esw = parent->esw;
-	node->level = parent->level + 1;
+	if (parent)
+		node->esw = parent->esw;
+	esw_qos_node_attach_to_parent(node);
 }
 
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
@@ -1018,3 +1018,105 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	node = parent_priv;
 	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
 }
+
+static int
+mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
+				      struct mlx5_esw_sched_node *parent,
+				      struct netlink_ext_ack *extack)
+{
+	u8 new_level, max_level;
+
+	if (parent && parent->esw != node->esw) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot assign node to another E-Switch");
+		return -EOPNOTSUPP;
+	}
+
+	if (!list_empty(&node->children)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot reassign a node that contains rate objects");
+		return -EOPNOTSUPP;
+	}
+
+	new_level = parent ? parent->level + 1 : 2;
+	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
+	if (new_level > max_level) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Node hierarchy depth exceeds the maximum supported level");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
+					     struct mlx5_esw_sched_node *parent,
+					     struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent = node->parent;
+	struct mlx5_eswitch *esw = node->esw;
+	u32 parent_ix;
+	int err;
+
+	parent_ix = parent ? parent->ix : node->esw->qos.root_tsar_ix;
+	mlx5_destroy_scheduling_element_cmd(esw->dev,
+					    SCHEDULING_HIERARCHY_E_SWITCH,
+					    node->ix);
+	err = esw_qos_create_node_sched_elem(esw->dev, parent_ix,
+					     node->max_rate, 0, &node->ix);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to create a node under the new hierarchy.");
+		if (esw_qos_create_node_sched_elem(esw->dev, curr_parent->ix,
+						   node->max_rate,
+						   node->bw_share,
+						   &node->ix))
+			esw_warn(esw->dev, "Node restore QoS failed\n");
+
+		return err;
+	}
+	esw_qos_node_set_parent(node, parent);
+
+	return 0;
+}
+
+static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
+					   struct mlx5_esw_sched_node *parent,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent;
+	struct mlx5_eswitch *esw = node->esw;
+	int err;
+
+	err = mlx5_esw_qos_node_validate_set_parent(node, parent, extack);
+	if (err)
+		return err;
+
+	esw_qos_lock(esw);
+	curr_parent = node->parent;
+	err = esw_qos_vports_node_update_parent(node, parent, extack);
+	if (err)
+		goto out;
+
+	esw_qos_normalize_min_rate(esw, curr_parent, extack);
+	esw_qos_normalize_min_rate(esw, parent, extack);
+
+out:
+	esw_qos_unlock(esw);
+
+	return err;
+}
+
+int mlx5_esw_devlink_rate_node_parent_set(struct devlink_rate *devlink_rate,
+					  struct devlink_rate *parent,
+					  void *priv, void *parent_priv,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *node = priv, *parent_node;
+
+	if (!parent)
+		return mlx5_esw_qos_node_update_parent(node, NULL, extack);
+
+	parent_node = parent_priv;
+	return mlx5_esw_qos_node_update_parent(node, parent_node, extack);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 43a40bda7d19..ed40ec8f027e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -33,6 +33,10 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 					  struct devlink_rate *parent,
 					  void *priv, void *parent_priv,
 					  struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_parent_set(struct devlink_rate *devlink_rate,
+					  struct devlink_rate *parent,
+					  void *priv, void *parent_priv,
+					  struct netlink_ext_ack *extack);
 #endif
 
 #endif
-- 
2.31.1


