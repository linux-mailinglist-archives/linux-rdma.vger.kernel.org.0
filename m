Return-Path: <linux-rdma+bounces-6253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C0D9E47A5
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BC916ADEF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390141F03D9;
	Wed,  4 Dec 2024 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUsVJX2m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070B19048D;
	Wed,  4 Dec 2024 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350340; cv=fail; b=NX6KlpEWZFKD3tajQZ8FGQPV0Gq2QLY1FPwczAP4enSCZXeFmc60YiQ++gj5bT6Qvy/Bm+R8IWRuLRHSa9XcJ+cRAZ8tuvi0/q9D6v4qYnq8RKo9r+XRWkH+H3A90IZjoaFP/GQHSYlzeZ/BeFlaysbGJcB+tVyDghBkV7xHEXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350340; c=relaxed/simple;
	bh=4cNIZDzLQfKsJJ0kQrHNCv75ROx+XfXm7fbjY1Jm25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QteddeyXtnzmXnYhTz3AVbp7a5619EEUzn1mWiBy2/37d9ld1ztLq2SvfziWGJCkg/ZP0t0ym4ZDAtdz6i2HlbASsHAfn86yQ7ddcjjwQq1BIAfcDoXTeAB+8KOJ7AA6EStant5GPIELawKEWSj36I+TIEN8GspESHN3r8IwHfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUsVJX2m; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeJHMwHKdtatk39Yb99yMo5UC4Mbhn7Q5AgKpROlqr9p5KqUAia44chgGjpcc/+Qnwxd/XMGGLyWRmuwVrG++cGRgaNt87D4SDR7I362J7PD8gOeG9ni/oYDqut5ayWGqHABDvkoRcRuHElWh3wiS3WzvhWByM3P1s+pbqacItEB+2zVy1BZ27q85PS9XqiSFhd7tfCr3qz/mPWR5vDMwEKzXZ3b69a5AuhrIdQFMszFksC3cwdTL47Q8nylX114D26VU70HS0WFDcRxDM2flqKx0HysCl7lRw3S+YAgxoGi27p89+cLG8ZgIfG9Br/ZVCHmKyfIaTPAfC3Jahsrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPvv3IafnPs+viKn9AmZlYH2Xt66noDxqyj57pvtwVk=;
 b=VN59MA+JpfAMLkvcZ6POPQ2F4micdz1daDdyQ8ksWeJf6R6S1kQAobkK1ECbJKBk39hc3T2iUa62RJZ4+x+DT9OsfM+6Uh+44tTuPkdL+il6etcxTcAx6YMTKPdMZRjQItFnw/p2ZqynLSs+X5zX01V3QVn59aEVsuqPU2G6KvCC1yHEGaVRdtVq4tbm0PRMnJONg7UVHoPbNN9R7aQqwWX9JrccvaI9aLlR5msJZDrDWONdmr4iF0jWTYRBW3Q21nvWVTZASqqJc4TIqZM1BVvLTyrNI5lp+0oKHo6UaLVDuy44yCE/a1X/V8TMRCTOqMNVKZZAmPuek1ydvZQQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPvv3IafnPs+viKn9AmZlYH2Xt66noDxqyj57pvtwVk=;
 b=AUsVJX2mL3jy6m64JNrI83/FwUGn37W9MEJK9a4z6p2oQAxMpUUqXppojhplwCGYjAJfHjb+qoUv3A8TBXt0yV3ZYPH5DSasawZk7uvTyXfcxuTrklkdS8o+StFH1h3wLP5Guzx1k2hxBO5CSl5eFfP7ZGczNE99vMgupPbBTsfRVDcKg6yXmd5KTyxV1IbJDujwwzzUg4zdiUTeKGbIzYpeBzn41CId0KIDTWiYzaBhZ0BXIeLadYUDjaqnRBhFcZU8qR+w8vIN97mEVkYwbQxAk/6DKLQj/dOIjofRiZYvz+wIkgdGN7GcngtD3LgQCOEffk93MY4Et8xP3lf4jg==
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 4 Dec
 2024 22:12:11 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::6e) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 22:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:12:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:46 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V5 11/11] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Thu, 5 Dec 2024 00:09:31 +0200
Message-ID: <20241204220931.254964-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d98651-1f3b-4960-0818-08dd14b0b2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27e7+hOzopYqk8lfR0eoNAPKaS7b/P7NzUq07mrB93EKn5dOHWx16CmrbSaa?=
 =?us-ascii?Q?oJE3c/BxXNQLNSbWxqoM3kGPlPuqGgHZ1NqGTsUvNR6c1FugHTmM8J4tKCq6?=
 =?us-ascii?Q?1onWP8V0gV+AiKG17Jyl1aArHHjdTULm/zFt/DSfAlz3mf8AEfow7EwTRT9y?=
 =?us-ascii?Q?YWUcyiNNWnNqufQbxjYaQ6ssBqnITCS4gCDwk41ti5tnQBSYrLMDqCsWhHP3?=
 =?us-ascii?Q?j9gW9bjFG4Fugtxv4LPg+43kVrThJPSwkRPdUZY5h3rvbIddWD/o0YxnZASI?=
 =?us-ascii?Q?kaZ0IlgsUuqyw4LSNmKH2wxU9x5/VcY1ugCNZrQzKIpXKpnOVWoKu4i/jr1P?=
 =?us-ascii?Q?NgwTA2iwcGW873yfnlfO/4ydFR80IMWsvgfY5owrmJRqE31EjfRQqdxrLCcY?=
 =?us-ascii?Q?XNubTeWIQrypbShiFfPZ4u1Qd+B1h22pB1T8HFVAcaczMWcU38zTOo/gMJpP?=
 =?us-ascii?Q?Xik0rJsyOx1guVVLEOF7f0VAhiMdWjexTUnFy1RJlTwsQq9lLdoOETHrih1E?=
 =?us-ascii?Q?QVwpUHk6ZadixnophkNtSpXkD+MPFdRxSmbT96yzmzh02BqG6cdvd1pwQl9N?=
 =?us-ascii?Q?6f+pr8VmZ6gIXiqCOJnLeTBJWxXnv25Nl8F2g7X4ARXizTrc2+c9mEZY/Lcq?=
 =?us-ascii?Q?Bp0tJetSNlG+e/5aVgoGCNCvkhqL71oUvBkpWojY3sqLUnTfIr6HU12EkLd5?=
 =?us-ascii?Q?5hZKDmRxfDFEiobl9c17ICb++UaPI1jegt2I/8nnMatBMpcwpS22/ZZW4Ktm?=
 =?us-ascii?Q?KukvklLAWJWH2Bi1xxoynQ1hxvuaI4d67bS9IGKZTOgaFskpE3pugE6n781c?=
 =?us-ascii?Q?COpxzYLKC5yTz99ZzfMaNrgCWFPjAcovI06n5gRMxnRuaX0ho8ktNeXMBTH6?=
 =?us-ascii?Q?JE458GX69AEaMGtnDwIdspiFBNTz2uDSEnNyvSPmGMiXy22uswMXO1263M2j?=
 =?us-ascii?Q?ZETHEWIpgX0k0UBno96jR1BKM/LNAoDzF7y8+U6+GWrvwz3j8mD6csK1ai8y?=
 =?us-ascii?Q?2SBzK3e6EIRyJtxSJKeMflGmJtjrQ4p9qTIjj9XDgpt1WeWSu5VhgY8LrwN1?=
 =?us-ascii?Q?d/mmzVK5GvPeVxH3jiacmMHWy5nluqsOcnwvwjUXWwqE89oxTxqDjIsoU+QQ?=
 =?us-ascii?Q?04/fHgj7qSQJAgo10NSeoyBdmZHUYdHrQPmofIE9daRX8A2NMsFJhcB6HIFi?=
 =?us-ascii?Q?MYzpAoPqo8qZMg8202Yt8LDDwCDzQkZepO/npPA8B0uBFN5kIVIiog+YcLTN?=
 =?us-ascii?Q?USReJOpnKUw3eUWmiOqlO1u6T8+oW7TCo80ECtkbtY48vFpkfjn3EuBeP/wI?=
 =?us-ascii?Q?+RsU+0k0Hh9Bkb1s+FQEZf2tZ60DisdPynOfn1ydZIwAW7dVsFs8B1PFqSTn?=
 =?us-ascii?Q?7lLBveeq6CZTWtK1lUHl+2MMI4/6BxAz4LmUdooQBHZT5u5R3hseLaeeTF7Z?=
 =?us-ascii?Q?MNrCYmxsKzCpg3yaJAnK69Fd8SJ/u8PW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:12:09.9319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d98651-1f3b-4960-0818-08dd14b0b2a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253

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


