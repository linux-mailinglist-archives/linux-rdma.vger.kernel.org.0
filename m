Return-Path: <linux-rdma+bounces-14773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DFC86F3F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 867733531A5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08000342505;
	Tue, 25 Nov 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/LKUFWM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD934217C;
	Tue, 25 Nov 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101308; cv=fail; b=bIzjNerTLIhuPYaqGWU2t9kUhpba/7ollNC7MN1qMo79a36PLMbrBftE4A5C4BaVwwvXsuGrBs0Wfqr8ddnqHhurUapHimLHF6p5D9oyxUVZZhuzXD2if0Zpus33g3B4iUMBJGb8rLdspanLOy8CiQO0nlDKibYJ61PHnOm9TWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101308; c=relaxed/simple;
	bh=U36XFRQKma578uT1QkEf2v87DJbed/6ShXc7asbeyP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8q/JEs44NtRoJcCLUa54C3edxskecSBkt0MQOi48SjhJRTBtpQutNr8EgH4+ut0VJ1Iu/oI61l74ia/W9omSr2S7RPpwaEgucWk+72v4x7P+j2PRlV1KZRGcIid37bvRiNJDLRjlhoAxulHZ82r0iQYMnBKIRx7duHhis/WodU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/LKUFWM; arc=fail smtp.client-ip=40.93.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJRaJUOuzSsOs48f/ddIs5lXpIB2iELLz1d0mOEcPEHDfeKjZYxdZJ8vVKw4yg5ZAY/s729VHbnmyWU1sv9DTnDT40aPNla5HXP1qd7ivb9+Xv+VpjDAaXm7xE7rXA2KW55p+j6/GKPjsCGGX11yLy2DnEW5UXjViR1qoOoM++9tudWy+MqQfdjshdBMEPGK0Nv7JCGnUa2WHdKfXW6qmWhVat/X9EXQa027A/EKtAKuOxALhbM0xwUPVbOPXgIzkui7/zFUR0+ifgJo0annv8/1m5VoBdjbSwHeszfzjG/tmfBSqkAWQXAapbMeK1KeLfO4hUnj4wdPUv8l8gyU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=BIbcCL/0a6N6eU/ludNGbkjdoQmc5rFNQgSY9JQHfD1ZhwgeXLPegB3KhIko45wMkZXki62adGfjXaka0BYpl23F1UL6g68Kr/H6w50PkDJ3w9oM/g5jkMSGZ6/GWlwnjPDyvBCLxZK/rdu8pN2DxPC4QOEWhmhzJ2wXV5OkqdoEcFK4CE8nSQj3+TI1B+Jr5WIUU8ywLH93I824gWEnBxtv6goBFKu7LZZpBK3MhgnXg+o+zzMqXwqiIncuC284skpypuWsV92SG2a2wDvhZCjLW+ptPD0mgMRBqwyucb1y08XxRARz7Ra0mT85agU9i6OjDbP2tAuNBJTzl+qqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=H/LKUFWMbx3Gog9F2Exz3mAPJmcA/7gz3SIoxZdxH6I1Zu7IkFYuSU5P98XGS2NeDfNg36Df9ZHuz8Qh15/BQDhvTK0fpo//rc/lI52dZkyv2rsyK6CmA7kZKkavPnZ5F+uynNBtJK6i6CWW01y44BKqhNT0XFXHRibcdv7R9NDTKbA9rxPRazsH5Q/95L2EHr1R7fpvIPb5bGhWED3aN5y67azJ7uNPARhsDGnSlu06AHkKkUj4NFMMrGI8U8ojqezktzQotO7r+iIkfX51k3t2z0TQFDhHXKyy7ypAO3Y/LVk1L95UE3mXf4YxUgYGIobSTXKZpBWfg3rfD92Lgw==
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Tue, 25 Nov
 2025 20:08:12 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::d0) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 20:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:08:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Tue, 25 Nov 2025 22:06:11 +0200
Message-ID: <1764101173-1312171-13-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f36976-33f5-406e-2bee-08de2c5e5c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXDsSpipAyGpTe1lYTmwZI++4tRstOQQd6MKb3j6aPFswM9xIyENJqARM6tS?=
 =?us-ascii?Q?F4K0r/xZC3IMB3dfFOeUSISTviov+HAjJoQh/QpvtwdLdULBWVXCWlr7pPSN?=
 =?us-ascii?Q?KGkV+sRpUzsDN5sqQ11yq2OH9k4iIC+dBpONROGEKOQdJqUsrbCUlunuMz3i?=
 =?us-ascii?Q?6hDWucgIdUSFk2V36uArOVI6tPj0al6pHLxwbqcQJlGqbZoSOEMX2QsNfQQP?=
 =?us-ascii?Q?Pr0jNIEW9KN4rHLnEjyGiq81fbw4YDoJ5eI8pjBeUXbL3YQhkpW8WOSxIial?=
 =?us-ascii?Q?/XWzj4+yHMf2l0zG/g+io9oDxSqoLQ20+926fgp1s0h0QhAE38XhvjfXlkaF?=
 =?us-ascii?Q?TA8eN3g1hHFAqy7ujg/wBC08Yrnrb9SyMO7zIM7nPl1Qc8TUUyacHjvR7Myq?=
 =?us-ascii?Q?r4A/ylPhH9o6Pj/TTguOoABbvPhkRKf/zAuSXPamTLcmOnHduyZXx33ojU47?=
 =?us-ascii?Q?/zPcENb5gloDUeZzGoNqqN7zj76Zadt1qEPSiLu03Qe22lpO4vBnHoBKo/xN?=
 =?us-ascii?Q?BktRHyHBshyCWAiJbaaVj8oFgV5swUffx5m5BxTomz1QNznSUitvRbpKGi6N?=
 =?us-ascii?Q?+HlNUKQnY+lG8udHm/bd0UHCBFmtmtFR2V669aJ05QBQdadfYcV9Bp4AFlMH?=
 =?us-ascii?Q?WeyLK94N5RBh19UJ/6zhXVXIgdVFQAQCt1crQ8Ey9/q8hphY1TwIUlaDb6v3?=
 =?us-ascii?Q?keIWaAEH/5LJEE43RfOg+S4S0dXqU4cQ97P4z3rnMlgTRKhFQZX3EqNrW18r?=
 =?us-ascii?Q?V60GtYkz5L2qPZ99w0nQCYspcgP0frRINDDnJ6OSyeBAr+POHOtYobRq9O92?=
 =?us-ascii?Q?N4ZAhZNsk6IpDD1x2AUCkvQ2Fs7Pt0Ei5YTVlG87QyvfhiYhYK5XQ8gLnLZ3?=
 =?us-ascii?Q?miJ5ATNPLCoGtz+HacQ5ekeqTCfbEDwUGXuIRB3CcsOczEAdlnIrdD7+SkWC?=
 =?us-ascii?Q?KhEApKoecFpdJsMbXQrCfmjZ+c/2ZRuVw3lBtFokV4JjMrYhpfadKRiWkETd?=
 =?us-ascii?Q?Iwbca1JsNSEszbzQUE4LNvtLRHs7N1LghRVT1SapI/OrsH3CYYzzkiE1riEO?=
 =?us-ascii?Q?DUQrgULHsgFWyHNbUMw72RpbC05j1Y6rFxcLcYvn1HwiXi5XaPA56cFa3Oso?=
 =?us-ascii?Q?Nup8qvti8XRy3JJOJH/HIXDyVssP1H1p3IBL7wtCY+U5j1VMTQz2do0pcmss?=
 =?us-ascii?Q?OREPCCHHUX6N9iEqQOyUy9RvJ0yF+tZwkhVDBCjV4NtDabbbOXPcy120phj6?=
 =?us-ascii?Q?K2dFIlrJHYo1P3e3rmJ6S2rv5NJYzeB/H7djJTVmxp1AOSuMzZ03YY1aIsyD?=
 =?us-ascii?Q?VJzqQH2LS/E0N1Nbhaa+K71CCImGDei8uUnwT8O9llxci0R1vVNxnco+oDPc?=
 =?us-ascii?Q?aiu7GdscwcBo1CG0T8fJvMGimUfEStXF1ez2O6M9b0a2u/9atuZ5azUHEWv2?=
 =?us-ascii?Q?5myRnj04mwGv4rKklr2pUP7dqQciVlU1DUGvYJc81rlPH0mXhv6x6PZ8oBYK?=
 =?us-ascii?Q?kR48nblm215lN2WY2XuLZSNUS56ooeckUd5VpfDToMeRWjYGur4PYu1FxTH9?=
 =?us-ascii?Q?+wqU5rUjUsdpB6P8qqU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:08:11.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f36976-33f5-406e-2bee-08de2c5e5c53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436

From: Cosmin Ratiu <cratiu@nvidia.com>

Up to now, rate groups could only contain vports from the same E-Switch.
This patch relaxes that restriction if the device supports it
(HCA_CAP.esw_cross_esw_sched == true) and the right conditions are met:
- Link Aggregation (LAG) is enabled.
- The E-Switches are from the same shared devlink device.

This patch does not yet enable cross-esw scheduling, it's just the last
preparatory patch.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 114 +++++++++++++-----
 1 file changed, 81 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index f86d7c50db42..3c8716b0644b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -50,7 +50,9 @@ struct mlx5_esw_sched_node {
 	enum sched_node_type type;
 	/* The eswitch this node belongs to. */
 	struct mlx5_eswitch *esw;
-	/* The children nodes of this node, empty list for leaf nodes. */
+	/* The children nodes of this node, empty list for leaf nodes.
+	 * Can be from multiple E-Switches.
+	 */
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
@@ -419,6 +421,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -430,11 +433,18 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
 		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_node, sched_ctx, extack);
 }
@@ -446,6 +456,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	struct mlx5_vport *vport = vport_tc_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(
@@ -457,8 +468,7 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_tc_element, attr, vport_number,
-		 vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport->vport);
 	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
 	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id,
 		 rate_limit_elem_ix);
@@ -466,6 +476,13 @@ esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vport_tc_node,
 		 vport_tc_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share,
 		 vport_tc_node->bw_share);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id_valid,
+			 true);
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 
 	return esw_qos_node_create_sched_element(vport_tc_node, sched_ctx,
 						 extack);
@@ -1194,6 +1211,29 @@ static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
+					       u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++)
+		if (tc_bw[i])
+			return false;
+
+	return true;
+}
+
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
+						     u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw = (node && node->parent) ? node->parent->esw : esw;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static int esw_qos_vport_update(struct mlx5_vport *vport,
 				enum sched_node_type type,
 				struct mlx5_esw_sched_node *parent,
@@ -1227,6 +1267,12 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
 						 extack);
+		if (!esw_qos_validate_unsupported_tc_bw(parent->esw,
+							curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	return err;
@@ -1575,30 +1621,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
-static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
-					       u32 *tc_bw)
-{
-	int i, num_tcs = esw_qos_num_tcs(esw->dev);
-
-	for (i = num_tcs; i < DEVLINK_RATE_TCS_MAX; i++) {
-		if (tc_bw[i])
-			return false;
-	}
-
-	return true;
-}
-
-static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
-						     u32 *tc_bw)
-{
-	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-	esw = (node && node->parent) ? node->parent->esw : esw;
-
-	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
-}
-
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1803,18 +1825,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
+static int
+mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
+				       struct mlx5_esw_sched_node *parent,
+				       struct netlink_ext_ack *extack)
+{
+	if (!parent || esw == parent->esw)
+		return 0;
+
+	if (!MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling is not supported");
+		return -EOPNOTSUPP;
+	}
+	if (esw->dev->shd != parent->esw->dev->shd) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot add vport to a parent belonging to a different device");
+		return -EOPNOTSUPP;
+	}
+	if (!mlx5_lag_is_active(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling requires LAG to be activated");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int
 mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 				 struct mlx5_esw_sched_node *parent,
 				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	int err = 0;
+	int err;
 
-	if (parent && parent->esw != esw) {
-		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
-		return -EOPNOTSUPP;
-	}
+	err = mlx5_esw_validate_cross_esw_scheduling(esw, parent, extack);
+	if (err)
+		return err;
 
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
-- 
2.31.1


