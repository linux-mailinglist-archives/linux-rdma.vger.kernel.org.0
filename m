Return-Path: <linux-rdma+bounces-6218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5039E2D76
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 21:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D34B3FC58
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994020ADD6;
	Tue,  3 Dec 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GUmoHukY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E6220ADE0;
	Tue,  3 Dec 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257869; cv=fail; b=G3V4uBpXox4yWhx1jFoxB8Q66nCV4ygqDV71QG6HMnv01eWlES/JB/gcymiSNb9C5SWeBMTCHibmN26gBDU1FtxKA1PBsuu9+Fou74R/izKUJXHwx2d5unso1VbGrMH5St8E4eUvXNamPwhEIV3oHpFEeId3znLElxkit2P8k8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257869; c=relaxed/simple;
	bh=4cNIZDzLQfKsJJ0kQrHNCv75ROx+XfXm7fbjY1Jm25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLwL9gg/xbcdFOpbRT8jPfDgsVms/jmqRm4rtwqIqIBJzyZQ8fBbGqq3zVf+S4LZDQOye/ufGZGtr2GmgXWylNfs9dv5mR3R8WGUebMMSOJs0Sp7okApRWPB/0RX83lOalBLhJ+askk3su5TO7J8ml/BWlY5J0mg/9jcxt2wIIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GUmoHukY; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz6v0flUgNaVcDx7qDXXkCDN5Itw7s88rbxr3l96+Q93wrkvgZLuc3GHT1A+L+Sc4Lhw+4M1os6BHAIVY/qDFr0BhMn1MYEhBtd/sXoSqDywHdRHkyKMkfDpAE87+uAz27HWgo6RsbbotcybC3cqRQTX1q0TCXQdj8j1OfHOfRwD5tXMUS+rgVJ4dvAJXKHzyqD68LAGtGJ8TAeAZHxFvMFAaa0nZMiErXeJJJvWAJ29d5E1RcxLspfLSrEO1jR4T3wJtsGqcTACRhnWE0tGxNITOdOgzTb9PL7ZDfJEFwNfYAH9RuZi5+6KVoOED5379knXIo0/C38T9HZED+WGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPvv3IafnPs+viKn9AmZlYH2Xt66noDxqyj57pvtwVk=;
 b=Y6sYTxCfl5s1pJDvHT0p3cjWgGHXMIdwJygIxlRyM3uZmd5Qwq5pmxzr8tCoIk7sCE/cNPpG8r87h601gh7pCCAi3HOPmW/+TnXdxbY6Pq5VxYQvFYi8xZdEqOxfK0V1xAMeFq0jyX/GgDddwnGnuVGP+uJ/fHKo/7IQ4rbhrCMmBmDBx3GiVo9zywVxfuk59TogarsiVuUlnHbIxfOz0pE5sK08EuoeCdjN79ZHEKnhVECzEwhXqpTSWaEYbmJmFbraldsJm+BTqO70s2k/A5oCR2RqlhmkpYG9bdCGxhfPkEYiPpQ9lmzc1cKdob1zOnMbUJxgTUAgtzKcQcxiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPvv3IafnPs+viKn9AmZlYH2Xt66noDxqyj57pvtwVk=;
 b=GUmoHukY8O422p+BueC/aY9JGAX7671OA68Hlx7J0mFbl9V4wOrVYwr2a9KZAzpJNY0vNmZsS+7z7si07DA05r6uo4/dIuan88yycJNJ0JEbDN3YL4X8O+biejd9GZf+3YhQ6SCY0+Q8oXpWh9NFtuR5AKRDJxcu7lszzXFQbi2kqlMFbLgP8YyGmhDBNuZw05ZeL2a40YYgHp3Yl4jCHyC0fKa/5X7AzjD1rlBgCTi5kgEGTQaXzodWMRZQafz3gq5Hp66ueW7VO2aCFchPg7sMDWNJvLJZfFOVg9uZGyr/chUmovqTa2TUVPIg1JNcyBucxMrpZ0L7SzEX4pZSGQ==
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:31:00 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::31) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 20:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:31:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:30:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V4 11/11] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Tue, 3 Dec 2024 22:29:24 +0200
Message-ID: <20241203202924.228440-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: b97c0c7a-6e6a-43ba-4728-08dd13d96651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3adcB4IW72kPlLvPD7Ha97kEKiwsDlMnnv3pXf1ykm9O9FdrpNQ86wex+/h5?=
 =?us-ascii?Q?P+07lDEE1E7NSlSBoyUds/5O3QSo5HQOwmCIqxAkqn2ylySjREMPVonIRdyf?=
 =?us-ascii?Q?QdwmhnJA2ctbuaxkTk+bL+CIOlOMGAFCx0vgpT7Q6FaqsxoA7hyRfbLNXUDC?=
 =?us-ascii?Q?SfPfzNmsgCaleGYczuoOTdVizJoDe5knaFP7PDmf0sa58Q+XT00d42L5diTH?=
 =?us-ascii?Q?W/ku6o6zg02L1uA4kmHT2JQFY/h3d4+EzynJyFKMAvRsfPX7zYuvX0ipNSdJ?=
 =?us-ascii?Q?dM+1PxIpZnaiakE2UVMELRe0hPplGeJJ/6pd6sAmC6ge+mRi4mGOW2hckV5A?=
 =?us-ascii?Q?972gKPtNBku4CoQwI0VpVYM183XO6dy+FnSVjAW+Bh4zvt90CF10swCAjOR1?=
 =?us-ascii?Q?5E9AL1XDDxMXGOfJO7TVJT2+do0CEnOCRRflgZf2LCRBVJs3WeDfdLFunZhV?=
 =?us-ascii?Q?joV43T11Wj1oim+Qa9zZYd4bApc4nOUv7O4syJlatY2eiTS8aJXXSuiIDUkJ?=
 =?us-ascii?Q?zMHiqzA7WEKpHe30dL3zAOlp4TeIZHZ680XpIFbzuazr9WoTYEdYkX6ge0JT?=
 =?us-ascii?Q?FeSIoc7SWQ/CPeekuK9rWyvV9qDxZ7pe4jD4Yc+Sru9zsaVQWB6xr1LyG4kg?=
 =?us-ascii?Q?geABQy+lSHRa1L936v0nRcV8X4wHmzna0W3kqFhmKKD3GdWeQ7sei0+p+HVu?=
 =?us-ascii?Q?O+ae8UiFZRJJrQ7sCbj3USIzVG7dS2SzyKiaY4JQbHcZ5tLiktEBK3XEWoQk?=
 =?us-ascii?Q?iQXb2Piw9zCH5IOSB7JPyWkzZah1P5IF/3d8AewMUc1EpqLM+5nJAeHaI5IH?=
 =?us-ascii?Q?5/3Tp22wGViv3AHUFxqmz40SJp7ipANP75lsYAQ6GbKZNPgTPDUXKCDzpfRV?=
 =?us-ascii?Q?G7lg72uWJI6JpLusqywbfKf6/tRWyAI8t6gxQfVwGxtiof1OCKwaFqfpnqiv?=
 =?us-ascii?Q?Uh8L35H0vsBRS4IX1XmmquZ2EciPmDuLJrjiSL1MHSV+JO9vj9g7QcwNjwU5?=
 =?us-ascii?Q?d5DhsdhEID92Opyg6Qcei2KIO1o3rWJcx1FYqjUtuABSc34TklMopody31kN?=
 =?us-ascii?Q?CAjdteTAt6VdR/bH6PdTZX61lzVzYlkGAp27uGsiZbTdLMsTchVSqMVKjF2w?=
 =?us-ascii?Q?UlOMyBRE5kusJx81UVlEuTR6pyGvxF7wTe/q+LPSnOjvlM10CUVhedESJG5V?=
 =?us-ascii?Q?iwMXaTUhBGY2xO9tsMYSIQ+looXnZa0yVGuK+olE7B3WFwKOGBZpO/KsSuQw?=
 =?us-ascii?Q?zu02WINr1CRlkOHUEk8pPwbBtkYAPCHrctfKCxnOV0rce8UpLuF4F60cGRFv?=
 =?us-ascii?Q?3c3gHbTDJUW+9agRpBfNpbbdfbrI5eOlCUpLj9jfMkNftTYuCP3sWcCFZLgo?=
 =?us-ascii?Q?wS6JZyj8agA8cQObw5f+NQJRssj5Yx8QSsObFYuetx0we0AM5DnwxhaLXe3X?=
 =?us-ascii?Q?TKZxhO0PI+c5yQKPdaq38IEnUL30qTVy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:31:00.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97c0c7a-6e6a-43ba-4728-08dd13d96651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for managing Traffic Class (TC) arbiter nodes and
associated vports TC nodes within the E-Switch QoS hierarchy. This
patch adds support for the new scheduling node type,
`SCHED_NODE_TYPE_VPORTS_TC_TSAR`, and implements full support for
setting tc-bw on both vports and nodes.

Key changes include:

- Introduced the new scheduling node type,
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`, for managing vports within the TC
  arbiter node.

- New helper functions for creating and destroying vports TC nodes
  under the TC arbiter.

- Updated the minimum rate normalization function to skip nodes of type
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`. Vports TC TSARs have bandwidth
  shares configured on them but not minimum rates, so their `min_rate`
  cannot be normalized.

- Implementation of `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()` for initializing and
  cleaning up TC arbiter scheduling elements. These functions now fully
  support tc-bw configuration on TC arbiter nodes.

- Added `esw_qos_tc_arbiter_get_bw_shares()` and
  `esw_qos_set_tc_arbiter_bw_shares()` to handle the settings of
  bandwidth shares for vports traffic class TSARs.

- Refactored `mlx5_esw_devlink_rate_node_tc_bw_set()` and
  `mlx5_esw_devlink_rate_leaf_tc_bw_set()` to fully support configuring
  tc-bw on devlink rate nodes and vports, respectively.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 185 +++++++++++++++++-
 1 file changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index afb00deaae16..87c9789c2836 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -67,6 +67,7 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 	SCHED_NODE_TYPE_RATE_LIMITER,
 	SCHED_NODE_TYPE_VPORT_TC,
+	SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
@@ -75,6 +76,7 @@ static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
 	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
+	[SCHED_NODE_TYPE_VPORTS_TC_TSAR] = "vports TC TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -159,6 +161,11 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORTS_TC_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (tc=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT_TC:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
@@ -344,7 +351,11 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		esw_qos_update_sched_node_bw_share(node, divider, extack);
+		/* Vports TC TSARs don't have a minimum rate configured,
+		 * so there's no need to update the bw_share on them.
+		 */
+		if (node->type != SCHED_NODE_TYPE_VPORTS_TC_TSAR)
+			esw_qos_update_sched_node_bw_share(node, divider, extack);
 
 		if (list_empty(&node->children))
 			continue;
@@ -476,6 +487,129 @@ static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlin
 	__esw_qos_free_node(node);
 }
 
+static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent, u8 tc,
+					 struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = parent->esw->dev;
+	struct mlx5_esw_sched_node *vports_tc_node;
+	void *attr;
+	int err;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0, SCHED_NODE_TYPE_VPORTS_TC_TSAR,
+					      parent);
+	if (!vports_tc_node) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
+		esw_warn(dev, "Failed to alloc vports TC node (tc=%d)\n", tc);
+		return -ENOMEM;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
+	MLX5_SET(tsar_element, attr, traffic_class, tc);
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, parent->ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	err = esw_qos_node_create_sched_element(vports_tc_node, tsar_ctx, extack);
+	if (err)
+		goto err_create_sched_element;
+
+	vports_tc_node->tc = tc;
+
+	return 0;
+
+err_create_sched_element:
+	__esw_qos_free_node(vports_tc_node);
+	return err;
+}
+
+static void
+esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node, u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
+		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+}
+
+static void esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+					     u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		u32 bw_share;
+		u8 tc;
+
+		tc = vports_tc_node->tc;
+		bw_share = tc_bw[tc] ?: MLX5_MIN_BW_SHARE;
+		esw_qos_sched_elem_config(vports_tc_node, 0, bw_share, extack);
+	}
+}
+
+static void esw_qos_destroy_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+					    struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *tmp;
+
+	list_for_each_entry_safe(vports_tc_node, tmp, &tc_arbiter_node->children, entry)
+		esw_qos_destroy_node(vports_tc_node, extack);
+}
+
+static int esw_qos_create_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = tc_arbiter_node->esw;
+	int err, i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_create_vports_tc_node(tc_arbiter_node, i, extack);
+		if (err)
+			goto err_tc_node_create;
+	}
+
+	return 0;
+
+err_tc_node_create:
+	esw_qos_destroy_vports_tc_nodes(tc_arbiter_node, NULL);
+	return err;
+}
+
+static int esw_qos_create_tc_arbiter_sched_elem(struct mlx5_esw_sched_node *tc_arbiter_node,
+						struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	u32 tsar_parent_ix;
+	void *attr;
+
+	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
+					  TSAR_ELEMENT_TSAR_TYPE_TC_ARB,
+					  SCHEDULING_HIERARCHY_E_SWITCH)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch TC Arbiter scheduling element is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
+	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
+			 tc_arbiter_node->esw->qos.root_tsar_ix;
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, tsar_parent_ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw, tc_arbiter_node->max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share, tc_arbiter_node->bw_share);
+
+	return esw_qos_node_create_sched_element(tc_arbiter_node, tsar_ctx, extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
@@ -539,6 +673,9 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 {
 	struct mlx5_eswitch *esw = node->esw;
 
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		esw_qos_destroy_vports_tc_nodes(node, extack);
+
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
@@ -628,13 +765,38 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 
 static void esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
 						   struct netlink_ext_ack *extack)
-{}
+{
+	/* Clean up all Vports TC nodes within the TC arbiter node. */
+	esw_qos_destroy_vports_tc_nodes(node, extack);
+	/* Destroy the scheduling element for the TC arbiter node itself. */
+	esw_qos_node_destroy_sched_element(node, extack);
+}
 
 static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 					       struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
-	return -EOPNOTSUPP;
+	u32 curr_ix = node->ix;
+	int err;
+
+	err = esw_qos_create_tc_arbiter_sched_elem(node, extack);
+	if (err)
+		return err;
+	/* Initialize the vports TC nodes within created TC arbiter TSAR. */
+	err = esw_qos_create_vports_tc_nodes(node, extack);
+	if (err)
+		goto err_vports_tc_nodes;
+
+	node->type = SCHED_NODE_TYPE_TC_ARBITER_TSAR;
+
+	return 0;
+
+err_vports_tc_nodes:
+	/* If initialization fails, clean up the scheduling element
+	 * for the TC arbiter node.
+	 */
+	esw_qos_node_destroy_sched_element(node, NULL);
+	node->ix = curr_ix;
+	return err;
 }
 
 static int esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
@@ -965,6 +1127,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 {
 	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
 	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	u32 curr_tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
@@ -976,11 +1139,19 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 	if (err)
 		return err;
 
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node, curr_tc_bw);
+
 	esw_qos_vport_disable(vport, extack);
 
 	err = esw_qos_vport_enable(vport, type, parent, extack);
-	if (err)
+	if (err) {
 		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+		extack = NULL;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node, curr_tc_bw, extack);
 
 	return err;
 }
@@ -1415,6 +1586,8 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *p
 	} else {
 		err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, extack);
 	}
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1441,6 +1614,8 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *p
 	}
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
-- 
2.44.0


