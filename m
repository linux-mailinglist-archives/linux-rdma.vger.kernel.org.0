Return-Path: <linux-rdma+bounces-14697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE23C7DD2F
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778593AC583
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE142D73A9;
	Sun, 23 Nov 2025 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dc30qGvu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01595296BBF;
	Sun, 23 Nov 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882682; cv=fail; b=lr0tlJww59jGtFtmAov8kKnY9alb5hlFR5Uqz8RgIrlvPcL4ZS7hsG8OXza0dssgJaj7l8NDE8/AN3ne6DHcuZr17qUPFloByuMk9BMoMykQSBS3p33cL+fW00rLjd0QWF+FHhFfnnWp4aoODYOvJEa1/MHxC/QBXsv6035lLLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882682; c=relaxed/simple;
	bh=U36XFRQKma578uT1QkEf2v87DJbed/6ShXc7asbeyP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJPLA5tSNu9j/ETsDrqIOdsfZOQxXkupHiPgnrVY+Nx12V8dOuicKPqWXJ4MkWoFQQSDPH3Y0+0CXj9KI8jVvhS5fl2FfqGBIyPBs7yLlMP6yhPdQX8Y7nnsn1BONf5180Rph49sYbKoX96emKFTCImJHrjGDjpftQDFvAMWTP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dc30qGvu; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPZ84UQ47cSD87j9lOcMcG+Kmvyjx+XJGvUr9n2tN9vZ+XDvxBlXwNptvOrzYDoIhgksxq5fpUYvpWbwJETSAwe9pCvKA8PhD0DgkcxfoDHtKxKPL3leuTltxnR7x1DztGIGcEouTk8t9G6VGmXPAFLnqmIiAKmWywJ28gfdBl/tlsk/HtwTs5jnM2v/vUpvZ3GN+jY7aLToN9DW7Vfrjjrs104dN36f3zajrQTtssPfi7mIp1GQSRKuoLvomSMZ2k5AYpbDwBKlHM0yuc5NSooZ0XY3jkInMO8KMt7v4/EtsSLwhNe9S8ysBzej6wJI3EySDWXZDY7f1R7Su8l/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=D9rJRDSbBPQEFHLNzGUs4jYZ5GhRlA+ZcnaUO17+tYxA2/Pp3IsJjRryTnBVIFgTMUTDg9Qvnj/K30mvx5wL3pvaw/HkmGG2zzmOhsu0K/PsUXXxvF3LBqKj+lEd1xud3sndUwlRVsniA1YO5fs4n94+Wwd96JBSvBvWxZAntE52kslYS7glIpgMm2P67aFGJwTm+xiH9SK7kOFJeyAhuQCvzwJozzcvWIzqEtaYlH66RkKKBsDlI3vGZPIKbataEw/nVqLsHDpAdK9NQjhqYiuqIN60B9VQjDTGIbdkAMblAaZg1yshQ+gkz81c2jdeceo7snq/YBZW5fXba5bd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=dc30qGvu7GdZP7ok8Velhqgy1YNdocjm7UOvDyyVLpm6zEAQyROL7bjw1N1EPfrVjOU3+mkb7S7K+ZRPJZ7FQ7DUrWvnV0r1Ph06xRs1CyazpimoFrdxoUlz8tbgubMRkBe+oNi4bEi6ch/NmV/FaIqdCQGfPd+Q1b1vM72482vHW1moii6LYI3mOTGnLE8rSeVjja6CKYmCuMlDPpTlPUnrQ7c1P48pm3S8G0CX07yTzf2wLMhv8svXR5MlsXlUV2M71YiLJ0ikqaxyV1Wnf4gQi/8R/5HQyr+QumY9PJ0Ti6OC6fLFp7VEYga+dHZb2fDGFAGHLQh0d9gpb0Avsg==
Received: from DM6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:5:190::28)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Sun, 23 Nov
 2025 07:24:35 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::28) by DM6PR11CA0015.outlook.office365.com
 (2603:10b6:5:190::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sun,
 23 Nov 2025 07:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:26 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:24:20 -0800
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
Subject: [PATCH net-next V2 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Sun, 23 Nov 2025 09:22:58 +0200
Message-ID: <1763882580-1295213-13-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b32c8e2-a9f9-4ce9-78f4-08de2a615a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0jdIJrQt6MhQhmOyKNUwoEg0lbhE+rBQms190BofQraczDvr9MCytQPf2g3h?=
 =?us-ascii?Q?tTlwk7x87232u6gour+uDhh3gBQ4TtVflHUinCn2NjQyGDsQsMktyhSVPupo?=
 =?us-ascii?Q?HdbeOgM+uqiAeik048e+ZuwtEgDELN3XAzhKcHdgrxwzUqDMR7eADXCwK9jd?=
 =?us-ascii?Q?ZY04i8uacKBIGnZBHVnRh0/kYvs/aVpqt0FgHJbyaedJLEj/jSL7OZEsM4zY?=
 =?us-ascii?Q?o0ALxTbE4bEClzYIb2C2k8c9WIjWgDtmTVsUdOY10l7wjKaz2WdAne5s+0Hp?=
 =?us-ascii?Q?B94zj0PcRiPp6LtLt9esIgB4M/wmChkrrwrwXyzhzldlaGxO6xlM8ZH2OeSA?=
 =?us-ascii?Q?N4nkEYshIPEyzv+OjY7FWsyVOgSBwgcp5TLIP8krTNnJsz2N6yb4xLacuM3j?=
 =?us-ascii?Q?rsUfzs/0yC0QUsv8diN/pr/1NslxJhT+MLDGaopvl0WoDABM7oUute/3SKFK?=
 =?us-ascii?Q?IpsFDS9WDI7sqZ3tZUBrRYFZq2w2lRlKo3l1BSuDpZ8wiget8ibvvxk4B4Jm?=
 =?us-ascii?Q?B/tKA3n+POjod/XDsDxg/KDh1eGA83AqoQTzgGQzWWmoPmw+NPoLaaVthNXH?=
 =?us-ascii?Q?/L+UxSSxqd603PmzCVV6jZiV0MSSovplCiweqw6PsKOa0Jjb5QMgpKRgZBnO?=
 =?us-ascii?Q?t0erFYHXl3TT8x9cBM7wdl0ZhzZZ/NvS/fluE+2O2WiQpPgGb45XnbVlezhq?=
 =?us-ascii?Q?7jkaiHALmEx8FR4SvMPEkU7g7BCIkdOB1vAdRbTRQ6+HLeL4brg61wwbmiVa?=
 =?us-ascii?Q?E6vzxFKU3uEcnYSkTFITIeXkLI1feWKBqnd7Wu3FQcWcj+d+WPgxApd2J1qG?=
 =?us-ascii?Q?VtJN/IB29QbvwDWGhE+4zmMAk4BvX6pNknnal1O2r2MqkhmwJUc0BnoQWV1c?=
 =?us-ascii?Q?jPXY9UjeYXLgbsCYPX9A4mwGzj7DAQkOC0cX1Oo5vqyU8HsOdlNvKg9/VR+n?=
 =?us-ascii?Q?jXVMW6adCRqtI0UklzMltqLE/Q6kwBnUfA1hSjuE1xYjCkATlwvOrtUP2vGz?=
 =?us-ascii?Q?R397qXgt9aBv/OYrCYMxz51BLvxnT5WYeZBVKyXNiVZMngK1BFXd/wnMhElR?=
 =?us-ascii?Q?6hEXrVw/48I6SvwzpNeEbIyKkgA2TDEHAS0UIFS/gkEjNNmntDLohNtjhdo7?=
 =?us-ascii?Q?u1ZA5kVIwhiIvOoOBHLrPSYi8NDseso+rkoukAEsOlyYwKAa3eWmc7GIXSY7?=
 =?us-ascii?Q?hbdwPM2ZcttejcmIrUdf4WGkKnxD7PKx6WaRe1Zc55WkkZGFVugIMb6lK87t?=
 =?us-ascii?Q?VWr+2ziKjDaaat0N/9M1ZaJfu7Kx6NNsuNmCFv4CKh44J7lqZY9QWxh6Q/5v?=
 =?us-ascii?Q?clbk87HXe0ySFt+YblfhK5xdMTkKs69vOM4VOO93TItqv8h+MAnhFmESwDk5?=
 =?us-ascii?Q?KNftD89apze/t1mv1oK3wzL+TzC1t6GKdjkQE5sTJIjNJCBE0niVLRBi5dPr?=
 =?us-ascii?Q?atZd1qytn0OfJ+n2/M4lJbTical7HW+026YRQU9GGN77mbJRcxA6pszA4Px/?=
 =?us-ascii?Q?U5NPAN/fFxNH1DKaz4ztkM44+wIP9YRyZWGgmRas+vW0BkasouCbDusq9WFd?=
 =?us-ascii?Q?GqjIhgQBIZK1xz66o8k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:35.1937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b32c8e2-a9f9-4ce9-78f4-08de2a615a99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

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


