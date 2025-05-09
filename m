Return-Path: <linux-rdma+bounces-10184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30223AB09FB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 07:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D946C3B5835
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 05:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341D326D4F1;
	Fri,  9 May 2025 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyeffWTQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA89926C384;
	Fri,  9 May 2025 05:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769807; cv=fail; b=aBSfA16dwKwlQ7E1ciSroPQob68rlRb6GX14R7Z81PiTQbQwkHei8Rt/0L/3xwcHIon+Ub7mLmCsM0QOATZEas0f3pZScK5WshHXQ7X8/BFzeUI/xYPvWgFIBwqvPuusaSdBn4p+W+E95c1vEKhrSvfOJY4SeHnytJhOd51pbEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769807; c=relaxed/simple;
	bh=Wvs9F6wn99YpZQrMegFW6AXz/ErQ/lGVTJ1jkM+wY70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NG4MxJLcHw/HZaxfn+G0FqRZr71S64Nm76Sw5C7it18zauXPB833m2DMKc4233glyeAMi4nFaLc2m+ECz5zYf+OyIrsI6A/IWvJ1AetNcRDgOdlRGD7QvfQLTOcc4e7ohpevLN2RRPMwsXOI81r8/N7hDvU0+nXkvw2UzM317Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyeffWTQ; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4rnvSyDJ9RnfHfXfyoFuIpG2a2swO4Ix6a4jcafEfKTfRNYjYbs+quhVGnA2AIj11FeuyTSuG/AjvdS7UKbBbOL3HQpzyzGP1eAv2n4WycXQcGBegn80t+KqICC0NXIAaXyVVo5E4q6V2KOEqy05xSm7MAZB+kamL/yx2rk+E7BRnOgEAGb4pEbgCUIB+sLcHmzCKCHKsQKvDv3MOK7t8ECHZW12VC6xKqkcGAiaPWFIKm8iDhI1ywL5xJpnEx3EUmJeu2ILy+7UGPbucITOdC+RzdhVPribd+mNiQLPBM6pTIr65X+S4gp506ZDeW/xzLBoFtgsL8OcLzL/yijxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caQoorjCVhwmBFU5JFHozJBPBDsCzGqL7fnrtTloMHY=;
 b=YjDJNYKd7jyguAMDvsMamnlI9AMTmariPqBjugSylv6tdVDEgnpYh994h3p1FBlm1AcSuJSptzW92dKNFlKYjUJdMkTveDr6r/Gp+SI7GtUxQfhk5OSrM/VqoUTA5hMsa9iMsTeY5+rlZjT2LEJxPN3ciY0/FduA1EA1DPNXIhjRV4ay+yegonP6Yzv69uQMCv4BxTnFQ6Uz9bjnpsgJ+W+/Ua/c33pD7l7eeza2P9YaV0mD3giD9xxM3EvcQIDEyBJ5Kcieuz5xtEhE/J/RGmLD/XOpcDR0Ra4VkIQ3cY5tO/3w/N7TEsg9KHsIOtJLy2WDS0LCLeEgUse5ID+Zng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caQoorjCVhwmBFU5JFHozJBPBDsCzGqL7fnrtTloMHY=;
 b=YyeffWTQ39Y4t/CkJmOqZUywpNhepp+pei2jATZGwWXzeZIXaRFX/T10ELqyFicgWQ8pgjIIvUXqz8IrRPbNOOqWp0kG709b52eX/SY5jbmrvq2u6R+YQNk7HrU+eCnEl6KvZPWWsYJrihwbT8pVaHYmQN/L5/92KtOKYDIpQkubfD0vHjgxyzHozr1ZZeOEp7Cf+j2ydbQDdKBXwrE7zSHWW5fx47OiQQgYOY1LYCav2rV95CNs3ucBCMD3TWhlRQnnBt5OyBo+/ZDu4QNy6Tb4MsvG0fSJHwEEP1AGPWc3NTvQsjJ9MoV1RiMRbxyEI/iplBqxyEjpXi7z9YVnGA==
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 05:49:55 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::7b) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 05:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 05:49:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 22:49:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 22:49:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 8 May
 2025 22:49:39 -0700
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
Subject: [PATCH net-next V9 5/5] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Fri, 9 May 2025 08:43:09 +0300
Message-ID: <1746769389-463484-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 678c57f0-801a-4747-9a88-08dd8ebd52bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LPAwKuzB3kipvd3ptbmWmb6G0uiNpoFMFk/vx1Ytc0WKrPBWBNMQm4Usp2Sm?=
 =?us-ascii?Q?0FAZ7jQUMb0Wmo7bu5KStg8fl3R3WnjiCotGjPYB9S4n1neuY//Igg5PxRw+?=
 =?us-ascii?Q?W1N4ed6yKUa1ufH+Eew1OZcvw2P640cHtPRXx+wpok0mWGHYPOpXnr1dcbLD?=
 =?us-ascii?Q?gWdFESKmh1nE6GVGvk1XLrj495fQd7R3aUz7TIXkAmyMRnhSDmemgOV+oGJm?=
 =?us-ascii?Q?Pg2XJOKWQ0vCfD6sUIznRmTkeqZsq1FJ15LTWFLC9LG11goAQhlI0iKVf1yz?=
 =?us-ascii?Q?jNnndovVpEN5M9srz4ovor3Jw/rLKAUkMMr2QsCbFarnY9YOTBAMlvq/OKNi?=
 =?us-ascii?Q?SlVDykXnrOsrIt6bK6EXW4pf4quddxZJGRnB2f7u6IrRA0GLRqWLf5ADYGe8?=
 =?us-ascii?Q?EeCtI95rGFitakLqp5bT9OmY9+2oxyczGmQQ3cxdmQJ9kvDOyh5slD9yZ9J3?=
 =?us-ascii?Q?ltLJ5Bdz8Vwnv4aQzlBWRDq4NYbZZLmDyEytZWv6tiBg8uXOVcuz9I54KUtL?=
 =?us-ascii?Q?+ZImdjO/Kt0y394ZMDoh055/6zv7HfNuR255bq3fLPbRA+6D48w/HT7nBltP?=
 =?us-ascii?Q?P3wmOmxuSXi2M1kowRNCmJH77rLp/4E+ih41GklOVquzWCrKnLAxL8dIakH7?=
 =?us-ascii?Q?ZQpBrtSfORER+cbIEZXlbJSViLiN53gtYp8Y4JCNdKBHRwNmHLWd4chwQSj5?=
 =?us-ascii?Q?YYF5PJJCsLO+CllUN1C5KshqLJMoNd9PKrTf5hzMrkwVHaGAAzvtGt5QSrql?=
 =?us-ascii?Q?IdOa0CsKvYFXbd2r1123tBZKN1R2lsvzcohMbQKdUB08fZASu7npB4iIaGYe?=
 =?us-ascii?Q?wk1wvoNe9RS0biKwBK+UFvbScpdnGlEtT7X90I0TLUuA/MaBPHEHH+BWIFe7?=
 =?us-ascii?Q?nRPUqtV6fDoLoJGJUSG2jtbwvqQP5KxWKbDT8DaSRHSNVGvXWJGdD2mMyMy8?=
 =?us-ascii?Q?dYleEvPTSeg7f5v8HCJhe+PNR+yGp60+RHlEpJkFDZBMbeEJ8L/zh1IV6NVR?=
 =?us-ascii?Q?l5xD+a61x8qzQGgjmkubvLhMCKfaoDOe31En4BBMWpMVqK3TWF1A/VYsZdxh?=
 =?us-ascii?Q?NOHseRQV62oTSwF5l48C7W6IX1XOiNtUf7zOn3u0vzr5UZqRdoCR+WS7vA/+?=
 =?us-ascii?Q?jRFlODymp21KYkwqgbswcYITi+u4mX1mdXUCqkHgTkLr7P+fW9JDVYtySkJ0?=
 =?us-ascii?Q?3QEwxgTx7uEF8jIUjPIESNsrxZ9av7ePZYg0xzfGoShkRy51ZLvUgJbEiilC?=
 =?us-ascii?Q?/MI28H1BZ/3qqBjtIn7o6gxmPfetXzEXnVlNuaP3w9M2BBpvIbcxkolknNIL?=
 =?us-ascii?Q?3UFLOvyAbOa40o/7CFiFo438sv1FATyDfKMHO1VG4G9XaiisXIOxgGo0yZqR?=
 =?us-ascii?Q?Rekb8RZKZ+o7107UhVkXSZy2iROI6j7e5R/SjhzPO1mqcl3kEoKhHNlGQcj/?=
 =?us-ascii?Q?UiiciF3hbDEU3DcA9Y/T7Cu0XNmbtSLfnHnHJWDUp20rQ5ki6ENkfi0wrnrm?=
 =?us-ascii?Q?0ENHhuqmJkIzQJGxNTVtyPTui7omi8DDITHj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 05:49:54.3367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678c57f0-801a-4747-9a88-08dd8ebd52bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

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
index dec3bed682b7..14aeb1999044 100644
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
+	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
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
+	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
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


