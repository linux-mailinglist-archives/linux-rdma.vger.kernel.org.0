Return-Path: <linux-rdma+bounces-14649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3EEC742E0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E525C4F1058
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908A3431E4;
	Thu, 20 Nov 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZj5uqjS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35F33B97F;
	Thu, 20 Nov 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644493; cv=fail; b=J/7wBU6bdrRAzuDkks5pe/6gZYOSXkPqiNUGJ0MHuB1WDq+n3oVU+wy5fAMm1PeCaafAG4IsKJtOWFTpK6MM8ISQGhTWNsyap4U0gLtGGEycl+BeScpBRTCA5cM5pTZPm6O9JhOMO4l8U1jWmLWWPbud414tjDHUH+JPjVOGyvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644493; c=relaxed/simple;
	bh=U36XFRQKma578uT1QkEf2v87DJbed/6ShXc7asbeyP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSOouZ1vSoMoL68n5zH230CeDcofJ2uQ13MzmU97QuqbDnxAv+sNXJDoM2sjKuAURPDBb0FZZ1K6pw9tYwQkXXhwgDnSiyBsgVctcnFJDPgJ5XECtKqOSSr7MZkZ3RPXBQbQsMji8zrsiMxGN/4KmsNtd3MDMq3+bqRn5uqZqDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZj5uqjS; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4oJdWQZwibmh4PJ5j9c6BhGHWunGdh6kHE+Gmhq232I0HQ9S3gz/Bz+cAD27ASPGO1HV44V1g/GFZVTZWrtRghjgw0gop5pc6rXNGCp5y7zKrRXTYhmuQv04zl2lqSYd9h5jeobCu9f+N3YU27hCmEiah2fGLas/KRVq3qBl8uln2LBRU1xLFdWJ/nvVXUaGacu6bsEH6hPavt+7KLP5SA5x2Hc3epqzKIcAj9gbj8Vtup/m5KDb4ORf/DB16jR2FcpagqEdI/NKZ46Wc0caUrA/o/Y8Rm9o/vHWSRpx8h58cR7dkZbS+hTW5QHXjI61xMknr6ehTXjVOA2X1aO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=nFppuE1K2al/TTq28W880PdsTB0lMi5HhvukIozLFnTQLYFU6mqT2EJM6A9qTj9aL93JBGq47xMnXcuiZOCSA98ASuoZu3eZEPfypD+cGBV2RWqSRe/oPjR9Hkz3ZMAsmzaUxlWdju0xAmMo+wv/tmCB5Clx/KT1iWlrLu/zwrbT4UGWiGFoZ2uPdGZ5mXF3jawCxTikXWCCfkmExSNLCerfKnB2udYfsN4tEJtF/7M5uAGDHs9SKqB0Dwp4/B6dWpl/yDqx1dpxMCtDLz5aco2fKCAFTcCfaKZshkGaPnWYz1AbZJzCDoAAKvXeiFK728jQ19PtonCVT9z+yXbDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkAo1WA+IHZyE4a32jxwkjwBJAj50MNSpTK0tDiJPFs=;
 b=JZj5uqjSyKkfHwLjCKH3Fuj9EYoAsh0KGwy72u7HJCKZy/Yib6E2ugxYn//D4xlxnVzqzDvDHdZ6E/AupuHqP1U3pfUbzlEeDVg/J309jE10SNREoImKsyyzaNtM98JU83kUjwMeKUXz0R4P0M+DzoRYNpchFfzj3jaUlqKCAmPhbRa8vBO2r+67Ka59LHOp8I6wOg7sCTkJpePemLBqZ3cAX2zxDREraosTsjr5JM0ZnMOa5TjaDv1yQhOQ90klq1RuDVk8K60PSdgb8B8HCbh6+CKZnfTTuvXQf3Fkfx2BBcVu2XjnLHdauSpU56lJld1ffrnnpwUjvHq0njnJzQ==
Received: from BL1P223CA0037.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::14)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:14:45 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::47) by BL1P223CA0037.outlook.office365.com
 (2603:10b6:208:5b6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:27 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:14:20 -0800
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
Subject: [PATCH net-next 12/14] net/mlx5: qos: Support cross-device tx scheduling
Date: Thu, 20 Nov 2025 15:09:24 +0200
Message-ID: <1763644166-1250608-13-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: d597843c-162b-4b1a-9421-08de2836c63d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbnhoYkIQu4tORRZcX4jzqtm5tcmqkH4zAwu/iq3H9Hc1LN/T6BerJc51/m7?=
 =?us-ascii?Q?E3kmddqTkGeOmioQHMAxWi41yOiWUHmvmLLW9OM/IW3zXFCyP6ao0cWONAg7?=
 =?us-ascii?Q?DovnAflofs7iByf+AwUGhEAqi1Pn7hSYnBHTz0ZS8kEV0MYHWFCfzjYmW4Ll?=
 =?us-ascii?Q?oR+/fFBNiIe6RmaRyRJQAYpM6TwcgXGuoQfOijhW3I32IDR3quUsKaIqK3dO?=
 =?us-ascii?Q?b1QtzsOcPvVvXUsOq0sVh2WviwMavWcKvr3uz6NqJf4QrHF9qykiONodkBLm?=
 =?us-ascii?Q?UtVLiqbCzRAaOs3191ojS93vJLW72K32uCbiDs7DDLW/pd/yMOFPbCDpaLNO?=
 =?us-ascii?Q?cHlYfBTRn3t7tXVRKf5im0G8g90oKHAFs0SvTY0+xWi9Tb5A1UurjScPX/3Z?=
 =?us-ascii?Q?wv+KEFkfU8GRwGdl8Dk7d+i4SEQLgbYeEItorMV9v8CaIag/ukf88i7G+5ux?=
 =?us-ascii?Q?eu2rr3Y6KCocLJ30L7VlVKbm3/6aMAib85DwtKsq/Btsr6VDBjOtgUVlu+4M?=
 =?us-ascii?Q?iuHjG1jdoLG5t3Ka7G2KpwNfL57PH7fyWpB4ZmQAFqJYuEmWYja18Z0XHJa8?=
 =?us-ascii?Q?YyUXx1xgMfsQvsRzJ5GyD3bF0AlQBDZbR5CSFxkJmcxOhkTnZYuIp5xFQ9WT?=
 =?us-ascii?Q?8beV2fyvgPZy2hbU0MC50wyiIbls8ckkJ9IGPNQcjy9E1pY39kqn9FljUI1Y?=
 =?us-ascii?Q?Zoshxi4KaMPESqtfUw/uBYcUjb5+FqHQXAKIGxxP8YuVWxAp0bxJ4LAZEpJ9?=
 =?us-ascii?Q?DJOG26VnmHMfHmUIBFeq8/Q9I/vui6vS8AIRV7+I4l+642qvLfFlUjyk1n9w?=
 =?us-ascii?Q?Gvqs3vTuJpmP/dYR6WgPtsd0a9ENb6dvsiazT7dm0vUObN+N8LfB8msJxnIl?=
 =?us-ascii?Q?Qtdi9iEKN3lZ4iwNBCACgOEAfwRi8oQd8CMUSRxw+dlQwGsAIiKMvikQnzdS?=
 =?us-ascii?Q?bwfQ/TQqNQ2oAVk3Zb51HDU9V9W1acorNEt5haG3NNUO/UGr0gZtzBhylvBT?=
 =?us-ascii?Q?ZQlvj+QTObs3cZ8RTjLFDnezhCON15DkXp0wyYl3JAXRvxWGqG6wCFQwKAYe?=
 =?us-ascii?Q?sX7NNkIdtILnVdXYD3pjQPx8f2Y1MHYtFUdrCpXwYdXJA3o068V4R+YL5Nlt?=
 =?us-ascii?Q?xM/ebmDYgZPEQhc+2aL+5OcY1vQVL2TlwjPJkrBlfLKhCsAwtrRGFjzURX8X?=
 =?us-ascii?Q?MSxpwJATYLwDKLM8RiouwpxKbnHryWW5vjjkPvIZaFcGCsgt8JE/lbE+jBfn?=
 =?us-ascii?Q?tHylLKVnhwQQVmcTngzn2motQIMy13dd74FtmN0pfi+1nmkYJi3c+zPArG3C?=
 =?us-ascii?Q?VOmO8Tgc6S5ecL/lEIA5qaN0FaUdH4Q0tvKEXpkGQH60N1QoNc1KHufPdKsL?=
 =?us-ascii?Q?P7r9dgrZiX1bYd7qlTjvELo8u4WyJhd1QNRLusnwVNqkoeFeGZdYf/s6owO2?=
 =?us-ascii?Q?elsGsAL51BU58pPS3FNr1mVosBtjfee2EnIiyFTYY38bYHBM2ak94IDkdOAm?=
 =?us-ascii?Q?TCkFaM+e11+YhVd1g0ajxXloizUCgoMew8roGFOqdIdBqIA61OFAx0woPuEv?=
 =?us-ascii?Q?e2o0Zk+WneDPh7z3fc0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:45.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d597843c-162b-4b1a-9421-08de2836c63d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

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


