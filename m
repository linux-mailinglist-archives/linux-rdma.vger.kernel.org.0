Return-Path: <linux-rdma+bounces-14733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F4C82ACC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE6784E3EDF
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E635337BB5;
	Mon, 24 Nov 2025 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GC4R3yTG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333142F3C3E;
	Mon, 24 Nov 2025 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023410; cv=fail; b=UiaYzPQKx0H2QEvpvU/LaBdluup2g8bizOfW6XHx/ZOS2PdcjFQlBw4Lf1exeojmkIgzlOxhsY3TmLLVXZ5DiWVGSiyc7nBwsLWTOu55gptEkk3+/FHFwjQZzIYGm0xrHv4ta89AJp+wyH0M7iHtnmE9d9LyhBh3LVbwy9k8BuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023410; c=relaxed/simple;
	bh=U36XFRQKma578uT1QkEf2v87DJbed/6ShXc7asbeyP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg+CLohxVc0wi4to2QnIFzddHznwT6sTluLJTrZsOO54vTqS02Cxn7VhCxn7dJl6gCj1AO8oLcrDXdAnnEOHTtwTsZ/uDxnQUvFqjfy0yN4CF08RNFoIhtVjmGr3GWpwXpcvxgoL1C5nJdL8EO1dnhrT3J1SSCOqR5SefO09byw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GC4R3yTG; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqB4dLDd/pAvjWOFIKmG4FHa8HiPiXsf9wJ5bvDPVMMRKkoJ9e/8aEKYTQNq5TSKhx6i3wbESWeo5hNPAR/6BCqIWX/4pfcKkVDfqTSntyOZFRijjIXdUWAXg2bOZlR50lLn0uTCAXZF7ptDZCeu1otCldPpEdRQSKEx261vD/IOz7iEjHtW0+xXuEEXCph/1hZHlUGoG2Hg0wHALOzfSgxtr3GxcG4Rgp5Wy7XPcDph8vvwGnHUjN5855Y57an9zjF5mJag8Vw4ueSDohj5I2Fn8p9RkXjOiiQ5Q2nh+SlsUMbxDQeJre/DVJFuhSM6u1eTASGw2nxMER61bTBCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=DgT4jiWYcCEP+iDDKV79crzW6rwj+j+nuu2qBg7LPrA1gHh7ctQA00qM579vL9RiKDzYUr+e9amlo7vvs4a18xhrSS29tyxjecH891b5lp5L2shXw65YmGEPtIbFBKJmxElCqo6C8x7ncEwe3WMJJtWQ0QSx+90N3M6XN89a0wGxuSBQ1ohRN7+PcCkGA3MUBSKTmjW0xlu5St2CKzdAfj5kF+rRHT/aqrQ+5qgzYJZrhwytnvqQxza+Iun+DIXXXbxeWCWiNgps7ctnmKgGpGGX+fDkPgj78YrU5CLGTKg/f1A/o09LKU0YRPC/hkuxIW01QJAl1Ycqyf1PgFuYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=GC4R3yTGrsfS/aRvU9RyQLGU77e+XwSNON3xTIKEtGz2cZdP+5CaLYuV3Ezt/kHvXY0EeW7Ale10ppzWbrAxKVBrIzq09lYlS5LuBz1E5OmGMeJ65xvIMFiyBYYVDQy8BGvlTJoDEwJ0UgfWfYyGjr7OtcIVLN5wIIcvZP0V4eVeHUTeLEJxFkWRvPcBuvgcR6EGsEcVjwcPaX4SVgLos/Wig8ytAklzbjTAgJlVdDUm78mXXP36TYVMfAM2w+ao++TFjtYWr1AauPsk3F3liAwslLYkf7xHgyJYfISG+YJ6SgF/qtmO56Z1+MzF5mpNVJgZWduDU5hopu4CILIx4g==
Received: from DSZP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::14) by
 DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 22:30:02 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::d6) by DSZP220CA0006.outlook.office365.com
 (2603:10b6:5:280::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:30:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:43 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Tue, 25 Nov 2025 00:27:37 +0200
Message-ID: <1764023259-1305453-13-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e234eaa-3eb0-4e2b-d526-08de2ba9024a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BvAWCyWTL2TEIhDRifbwuv+1KDf8g67D28x9+ptBe5rflcP0jud5K5lfUIJ?=
 =?us-ascii?Q?uwA8cLG7FXwp7KfJFYpcd5YwbwiHxMhIVarJGTPlMGx9XptBkKONtPZnLPni?=
 =?us-ascii?Q?Ui2zWTFTccRPDGfqKa6I1qVjHAjqFwyi6/iyL/PIDWDQQ7nlRMuAy04p6qFt?=
 =?us-ascii?Q?hPZd3bFty3J7eJhJ1qckr4DD/8pf/mt2gFVnsVoJ468UR5q2e9sOiOGFhAWe?=
 =?us-ascii?Q?3FZrngKIzPoyytc3HyZc53+jG6saEljmoi9ug7+CLvX97bJrLy2yG/akqcXH?=
 =?us-ascii?Q?eeX3tyu2FsQ3Re0BIr3o5pJm+ZQFUAckf31B3+GUuJxPK9zEFgauUPr08lRx?=
 =?us-ascii?Q?gK593KzXv+n8Nln813pLwnJkqxtq8G4j2oCoETLJdb6tbFLySPtegAYW5v3Y?=
 =?us-ascii?Q?XXBY6iQ0+Sz/8cM33hDffsg+jf5CwUjSIefd9VeGHZcOCqw4I2boEtcUKxBl?=
 =?us-ascii?Q?0xRebcnj2Duc5vqiiX3dt0bJkOHwIgxwNpf7vvd9h/BzVVN8wnURcxE4iFpX?=
 =?us-ascii?Q?dJrS8cPpRe3huA9mgiodYUTkVmf6zLmg2sDn3BxtNT2iEhWt/47MP6sgaX/e?=
 =?us-ascii?Q?Yh+J8cS6Wm4BAxVHeQK7orfsvIBnA7o15wFO4VIrxwO6j27LVAnmg1cb1cUs?=
 =?us-ascii?Q?KFuS0vr5NsSuYTgohY4rMA+PyNu5gC29mc2GUk8uup2z3hDR2JAtqvIP+ZWc?=
 =?us-ascii?Q?QuQwu1D4Qn05qjeuZTRY5b9dXFDnZZZ1M0VSgo7/VOX/qUkIw2WdplXY1ROv?=
 =?us-ascii?Q?KX8biBJhI1ci2dT46J7rM2sEXro/0C1vziO489Wy3jCXpipda9f1n1ElGyei?=
 =?us-ascii?Q?2Xxy5q4GfXDQNfKo8Bx5a98/NrImsjFSmQx9EJMTHFKVrLGWDbWXRjjBtyIF?=
 =?us-ascii?Q?G87CPXZDNYzlOAHpyhmCfB7GVKSAnLPlHVX+4C44bbcDXpX3KzEZmljusQDh?=
 =?us-ascii?Q?9kuPLpRdrQb66qLDr1pA1Zo0Ba3F0cQOG4djystIu5ljCBAOeMR6V/Hhosp3?=
 =?us-ascii?Q?qoQ/rRx8Zoh6tYgorx33nkDBhW2oN1G4QXXct56Ytan5fT1ePQbqtc1OqDEn?=
 =?us-ascii?Q?9YuP3X3UW+691jRMdXquae6201TDb8NrELwtceMee761u9YnPArvg1zddX38?=
 =?us-ascii?Q?dSUyigb5XuS7tXrdpGU5vx/JMBKBQLlt+O6hZn9DnEVEPAQh8Kg0ANHlbeZB?=
 =?us-ascii?Q?j+lEopacd/gLgN8JGLfY0Lhep1CllnxksUHCzNKdCdcPguZSOgji/jRyXj8z?=
 =?us-ascii?Q?97GFmnhcpYuI6Pt3DGOLVAXYj1aIVcwlnizwDdboAInKdu34bCofWCRUMdqN?=
 =?us-ascii?Q?f+AbYmax0iUh7nu4/YXWS6PmrfeW2N0Pk1mGh/lKbf7MTzUZi7ZVv66UwqqD?=
 =?us-ascii?Q?h9wKGb43dXCVzD7z6gdUOIb8NkX8nXYIShzebKa3kjWr2lWgFhlnIReC73my?=
 =?us-ascii?Q?AnIWD1hE9qysEbnmy6F1Yihg2CYItAMm2n5EukOFi/VcJWEbXshiT2KYpj9a?=
 =?us-ascii?Q?NUz75Nvu7iMKRmDRzvXTDgE/Mltk5xNceLXO+JIbQrHerLn9ut3TjTVFP/wL?=
 =?us-ascii?Q?CdyTFsC/sNpNI21DZ/I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:30:01.9844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e234eaa-3eb0-4e2b-d526-08de2ba9024a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

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


