Return-Path: <linux-rdma+bounces-10077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2264AAC2A2
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A153B7B490A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6F27CCD1;
	Tue,  6 May 2025 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kw+7oiiY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C9127AC54;
	Tue,  6 May 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530880; cv=fail; b=AK4X9Kbp99y7ZPkFDM/nWfS64PaZfkgu3jzerjctR6oOEHoZfqSXHT80uSg9LNJJm27AkQ0tKOzwQ1TNb8RkFrV006MAvOBkiyXsrEosvpslkHKopVO6YOfIPu0x21jCxSYwJ0PVUtpxjBSqrPhQ4tjRA0JQmESVjqP5fAIQ1+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530880; c=relaxed/simple;
	bh=oWhpAXSxzr4hRhZJN0WCvReM3CV26fAJ9FGSLOFnvRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7wU94n/Y8fcsgY5wDulhVBivPbYmI+BaBn7/QrwwW6QRytBhvwFBDz2bv6L45hnffGvljzm84ynWJPd2bylKuo+lGJpUp+Os7DM0YisH0/iTb18TjSdEHXXV138fbEr2YKWRXj+McCay6i/KEWpdY0o1McKKpJchyaQqI3/mBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kw+7oiiY; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K86lklMQjmp/M4Q/WhnWRowC3B0U3+5ri9xpS1+0/LOLC9Yqbc9BWy4FTL43F7PpHyKquzUQlpYXoEK49KeTKsp8mF52CLDeIBfNnhHvaemI79SNEcG6Qfwo/VPbXeSWrjZrUE6pSs8Om18pCak8iO5Gbr/5xtzPdV3SdY7OWbB4dMTy4Ltpbvo2uRPWdBI1Jv2hqDfP5FhzHuLNvl1dYjefuUm6Hym9jsiqN2rpQ5lsiUInTh1k1DzVuMZii+6nPv1zjBQgepXvtDacaf4cx8TYw39lE2/bmfCTh4wtfgS4vwib242ET8GLkkw4PUP5z7HCteeGGwObwBnzsi0Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxB5w+JLi0kgwlejSF/7asaTy44ctL1dcvR3ldNYdiY=;
 b=ExlB8ITHB9LrMwBs0e7x1csK8Vuk1GXTJk5R3vkzImLqlKvINYr5YUgGRgzPqW8I7ayYW91ZqE2AibJPPQfvAGlQM5qEzlVJyFFX+6b03q+AVNdmOJt4UNAAotsqMYjFC0jAcO2rD8fPrLWkluz0xg05x3klmJEXOlpC29J7HMJLyVmrD/1Yqos14DlzYO78NwYqGnyrbZGnLKytB5ySwoeSmKIZGkzaYFkbWK9lvmaWILQ65ggGUb4u9HqHh6fHfcmPEGrHIUFxNgfBm1O47ulgktnOPn627B4HqyYB4ZIbDxlFFZ5V/cewG38Wx/EfeD4k0OZl1Sj0XSpcgOt37w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxB5w+JLi0kgwlejSF/7asaTy44ctL1dcvR3ldNYdiY=;
 b=Kw+7oiiYduXN36WkEOOyJzXes/TZm70tDmvlWDiRF2BDjHfWrp2dQ3dgUL9nXYb4F9PjLyMOCECMuedtriRYAPPnpmJltwkPlR606czGnz+94NW8kago+YajuTOC+3HpEZMbiTx+4HH/yBU9mrPUP2DXCBN4P9U0mPPZlvWPDPYtRgqk0eskovet2DEG3ZQ+1l/RdXeUqVgNgq/m9H2oEgDFwDG2uo0USOspjNGCU770YK0mw8IBi6WyK386wZzPXaVQV5M8poR4vI3pt2d/VwQ6RddPkeTLz6eBJbDJNxmvvviOyukRA07SV8LLsCUZWOoA1rFs+lI9eNt0WyIvmA==
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 11:27:46 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::7e) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.22 via Frontend Transport; Tue,
 6 May 2025 11:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:27:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 04:27:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:27:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 04:27:31 -0700
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
Subject: [PATCH net-next V8 5/5] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Tue, 6 May 2025 14:26:43 +0300
Message-ID: <1746530803-450152-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae1058b-3f4d-4e1f-14a9-08dd8c91062d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYjAnL/7JS4d3rhoLBn/nAGEbfIo8dhdYX+ySsz1Me/g5vvtlyLNGsfD/Enn?=
 =?us-ascii?Q?xbS1Lt7+WSm6bqiHcEhzc69iz9jEynhgrA1ci0HdwGDF4+RwACxwfEpsgCtv?=
 =?us-ascii?Q?5tT7J8wcmmqRJsPRAhE3WtyXBmpfM/k5sWxn1GQ37VnBw1wLB8l4l4rAOC10?=
 =?us-ascii?Q?wQFiL0ulGPnpCR56VQ9pbqMzRHfpF1J4PTJk3clRNs8i2s9DHRLUMG6yp4OM?=
 =?us-ascii?Q?C0TA+dL6l3cvY4TU245IWkad63zBkCCmxDP4iM53+LseGBi6Iv7SZweI4Wst?=
 =?us-ascii?Q?mdIguWBliDFJ1Uyf3b1+rW/LPI1NgZ95YDB7wV/77dOkn22lCHM+ZDXJBq5I?=
 =?us-ascii?Q?128oypQbVxYUmIj2x2pFsTM4kFsT9frzjDYzbtoorJOpcaxMJYmykvouE4FM?=
 =?us-ascii?Q?84yxy6Y8hfIF+IxuYiHL/MNWZAPMYMWH+PCiZYLAPRGYo5vu5NVQo8mVT9BE?=
 =?us-ascii?Q?N2DYcIQXeaU3+IhLU2mCtJgTMuM8zmYBrlcMKCYHdT7I5L1h4wTjyOLK+Hnw?=
 =?us-ascii?Q?WyPeBwKeAhh8MAOZ3tfK19tu4j8EfeB9E0zykt/1cwAjOFD7FYRk62Q3CEtl?=
 =?us-ascii?Q?/L7izSAwcCfEpp373vRcWFb/ubnQmZlg0/EnBn1n/b3MhLnjoUfNDyEhZv2o?=
 =?us-ascii?Q?XmDOnNOYZNC6ld8ECDytrQMUZH730UVweFPYHd5IXUlSdKRW3EUpdR9itbl9?=
 =?us-ascii?Q?jNJVZfvdRjqQQyixafwUZMlbpwX2clVDfiHI7UyGOD3RuVh7qFYxlRr4Ybe9?=
 =?us-ascii?Q?AWPeBtFA72QUrgcCcf+dor9BRnH6NnXM2XSdcNK//8u3gqM/xl0H/LJBoZdk?=
 =?us-ascii?Q?uJrR5jvI7tvbY5ugnEMovR2lz6fscFFBGbqsgGZTbV45lkrEesWSOXVzsiPM?=
 =?us-ascii?Q?4XgSiQPdym654i+nip46F53aRhEn/LkKmxLxJ7Wqqt9sRhcPy1XqL3edAgoP?=
 =?us-ascii?Q?rZZOCF2FIVrfzDcrUdYHbIQnxaGMWmSJGdduoVtQ0NTDDiYyipnMA1fIots9?=
 =?us-ascii?Q?M3Csw1B8ljoBg5jS9SxbcYwObtcIgfT74lpIicCFKRw23kxAJt22NjL/EXLK?=
 =?us-ascii?Q?ethR+FVcwfbLD1eNET9DMCaw3o5GTt9PREJRmp6dMI/1xBddaUIHpJveCHr3?=
 =?us-ascii?Q?0htsB4wt4WHlxerK+pYZQ5lvdyv0GuUcG+QZVVw8O5Z9QbbqNg0aIxpMuLMK?=
 =?us-ascii?Q?gKjS/ELS7Vu8hfch7Hqc+wVG+yqWrsF2KdQPoXMkw29kBPq1n0yj0JXKbkjy?=
 =?us-ascii?Q?fHXrjXbant4WH2XXyDcypTwpqqiVOx120QFWt0kaKK5YpexDxnl5cAKnMaAE?=
 =?us-ascii?Q?LBQMMS1uVQb9wL5pIqP6ArEeoUEg32UjOQBJaEjmqmGfiMVGLqtp3Kmx9b2I?=
 =?us-ascii?Q?BJEarWzR/1QD22nA9hc81J4owcS5sKJOhSnz78n6kNMrya4LfWahOEnTB6c0?=
 =?us-ascii?Q?iGaFipQsFsByO7UwdEX4xXJedwi/jmoL2V63/GADR6iuzNMgQrrR1dAzKqh9?=
 =?us-ascii?Q?taA+DdHDdvEcncq24+TAHNTJJlFEnWjegpGH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:27:45.7998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae1058b-3f4d-4e1f-14a9-08dd8c91062d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662

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

- Refactored `mlx5_esw_qos_node_update_parent()` to ensure that tc-bw
  configuration remains compatible with setting a parent on a rate
  node, preserving level hierarchy functionality.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 264 +++++++++++++++++-
 1 file changed, 257 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8893aaf32724..fac5058025ae 100644
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
@@ -187,6 +189,11 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
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
@@ -376,7 +383,13 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		esw_qos_update_sched_node_bw_share(node, divider, extack);
+		/* Vports TC TSARs don't have a minimum rate configured,
+		 * so there's no need to update the bw_share on them.
+		 */
+		if (node->type != SCHED_NODE_TYPE_VPORTS_TC_TSAR) {
+			esw_qos_update_sched_node_bw_share(node, divider,
+							   extack);
+		}
 
 		if (list_empty(&node->children))
 			continue;
@@ -527,6 +540,144 @@ static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlin
 	__esw_qos_free_node(node);
 }
 
+static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent,
+					 u8 tc, struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = parent->esw->dev;
+	struct mlx5_esw_sched_node *vports_tc_node;
+	void *attr;
+	int err;
+
+	if (!mlx5_qos_element_type_supported(
+		dev,
+		SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+		SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0,
+					      SCHED_NODE_TYPE_VPORTS_TC_TSAR,
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
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	err = esw_qos_node_create_sched_element(vports_tc_node, tsar_ctx,
+						extack);
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
+esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+				 u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
+		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+}
+
+static void
+esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+				 u32 *tc_bw, struct netlink_ext_ack *extack)
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
+static void
+esw_qos_destroy_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+				struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *tmp;
+
+	list_for_each_entry_safe(vports_tc_node, tmp,
+				 &tc_arbiter_node->children, entry)
+		esw_qos_destroy_node(vports_tc_node, extack);
+}
+
+static int
+esw_qos_create_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+			       struct netlink_ext_ack *extack)
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
+static int esw_qos_create_tc_arbiter_sched_elem(
+		struct mlx5_esw_sched_node *tc_arbiter_node,
+		struct netlink_ext_ack *extack)
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
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
+		 tsar_parent_ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw,
+		 tc_arbiter_node->max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share,
+		 tc_arbiter_node->bw_share);
+
+	return esw_qos_node_create_sched_element(tc_arbiter_node, tsar_ctx,
+						 extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
@@ -591,6 +742,9 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 {
 	struct mlx5_eswitch *esw = node->esw;
 
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		esw_qos_destroy_vports_tc_nodes(node, extack);
+
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
@@ -685,13 +839,38 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 static void
 esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
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
 
 static int
@@ -1064,6 +1243,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 {
 	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
 	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	u32 curr_tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
@@ -1075,11 +1255,23 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node,
+						 curr_tc_bw);
+	}
+
 	esw_qos_vport_disable(vport, extack);
 
 	err = esw_qos_vport_enable(vport, type, parent, extack);
-	if (err)
+	if (err) {
 		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+		extack = NULL;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node,
+						 curr_tc_bw, extack);
+	}
 
 	return err;
 }
@@ -1563,6 +1755,8 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 					   SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 					   NULL, extack);
 	}
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1592,6 +1786,8 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 	}
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1716,6 +1912,15 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
 }
 
+static bool esw_qos_is_node_empty(struct mlx5_esw_sched_node *node)
+{
+	return list_empty(&node->children) ||
+	       (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR &&
+		esw_qos_is_node_empty(
+			list_first_entry(&node->children,
+					 struct mlx5_esw_sched_node, entry)));
+}
+
 static int
 mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 				      struct mlx5_esw_sched_node *parent,
@@ -1729,13 +1934,26 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 		return -EOPNOTSUPP;
 	}
 
-	if (!list_empty(&node->children)) {
+	if (!esw_qos_is_node_empty(node)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Cannot reassign a node that contains rate objects");
 		return -EOPNOTSUPP;
 	}
 
+	if (parent && parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot attach a node to a parent with TC bandwidth configured");
+		return -EOPNOTSUPP;
+	}
+
 	new_level = parent ? parent->level + 1 : 2;
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		/* Increase by one to account for the vports TC scheduling
+		 * element.
+		 */
+		new_level += 1;
+	}
+
 	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
 	if (new_level > max_level) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -1746,6 +1964,32 @@ mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
 	return 0;
 }
 
+static int
+esw_qos_tc_arbiter_node_update_parent(struct mlx5_esw_sched_node *node,
+				      struct mlx5_esw_sched_node *parent,
+				      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_parent = node->parent;
+	u32 curr_tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
+	struct mlx5_eswitch *esw = node->esw;
+	int err;
+
+	esw_qos_tc_arbiter_get_bw_shares(node, curr_tc_bw);
+	esw_qos_tc_arbiter_scheduling_teardown(node, extack);
+	esw_qos_node_set_parent(node, parent);
+	err = esw_qos_tc_arbiter_scheduling_setup(node, extack);
+	if (err) {
+		esw_qos_node_set_parent(node, curr_parent);
+		if (esw_qos_tc_arbiter_scheduling_setup(node, extack)) {
+			esw_warn(esw->dev, "Node restore QoS failed\n");
+			return err;
+		}
+	}
+	esw_qos_set_tc_arbiter_bw_shares(node, curr_tc_bw, extack);
+
+	return err;
+}
+
 static int esw_qos_vports_node_update_parent(struct mlx5_esw_sched_node *node,
 					     struct mlx5_esw_sched_node *parent,
 					     struct netlink_ext_ack *extack)
@@ -1791,7 +2035,13 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 
 	esw_qos_lock(esw);
 	curr_parent = node->parent;
-	err = esw_qos_vports_node_update_parent(node, parent, extack);
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
+							    extack);
+	} else {
+		err = esw_qos_vports_node_update_parent(node, parent, extack);
+	}
+
 	if (err)
 		goto out;
 
-- 
2.31.1


