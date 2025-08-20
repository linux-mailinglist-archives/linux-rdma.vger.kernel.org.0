Return-Path: <linux-rdma+bounces-12831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7AB2DDE7
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E079D3BE35B
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE90320CCE;
	Wed, 20 Aug 2025 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YcK0FRKC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D972617;
	Wed, 20 Aug 2025 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696779; cv=fail; b=WbZ/pyi40XXT8796BLabFxL+2pmTbeFTXuI9RYgqYVUTJU9EJBwd+zl6r2j/syzSpbZuCA6QMZ1sf8m278OUDfrn9lbczIMuODNqUG7L45lg5YP+obeibj+X+LRDhir+fPanMwbEAssB0nT8XCbpx6fPhESz5BoauJXWYUzkbD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696779; c=relaxed/simple;
	bh=mmgAgMBOPPE+BdoltznMA/9Vk4zWt/68gf1nE3Lnx+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5b6SQ+h8gmLIi+AmVIZTMGZ/DYrwCUS6toiS6tIGJYllxEVl174huCkZNqylSLMQPjXJ8PFvbFFQMCqniBSOF31Meh/x0eKeBH29x6LTAaiM+gVVGvQA6DaKa4kO9fyXgkFUkidg+M9GliQ1Dp/5RX6lEVKOCRVoj1WupbUCWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YcK0FRKC; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwXCclzZsJRNMggABZUxsk6MthSdYsK0rc7zexNrOtpdckDCryFZhlEb5bvGkr1OyQfUOHvpulQt4jjwJi8SNK/5zKyIE71XxV9GQFmWSX3aiCAnrks03GLq/aUlnsK4UrW3YfR4cxt5bOV8suGvTbd/Or8Zs41FTgsYGFRQY1xoq7zP9+6FSrjlzp25G5CHd6FNUojRuJLla2sBypeg6a1wcqAG29wxX2w+rCJDW7rB7tTDEC5v+YEt/a9Qhgmv7sAf8BhRY+6u3atsORcyBIVaAxRyeocOuLcIQDKsisVd6GNnZqvq/Gc9MYewE1evALC/waBQWvWQtTVyakCJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWmk6KnFnaRVaRXfHZe+7ffHmpFovg2kxX7fO1Bju5g=;
 b=MptonVSVeJ2pzsUH7tRyXYFj6wznFdGt4wZ4AQQPE71fvY5dhfoow9O5BjxymewowLCXh2/sY/ZRx6WmNW0BVD5CyK/KzrEP6JPUOAGJCiLOdSxJ67ERswjVzC8KdGW9EbSX9qLCddJskwlOOV3KCgn6bIzQjDVUCLg0ScbC79BQjRKAVsSy2k4UWmqtZpNGmj6xj72tZEZwx3ZXx3pok17Ez1rNtIqJKmrctWdaci/zMStLDVv02q+PMxwqym1Mchws5o7m6z9TWC9U5UoA71TydUOOZ0VBHR9JRCFI+55RvDyPJK4JsOKZTcNXRtIJdLD5H017LwCD9/fOtm49PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWmk6KnFnaRVaRXfHZe+7ffHmpFovg2kxX7fO1Bju5g=;
 b=YcK0FRKC129jGN5AiqTVkvKfUCQ8FQvCrfHIsGtpdMMAraJ0Thk67xMrDiyztFEUmx+eA+tR/Pv60LOY4Y+jBR7cfFzAGYnnTslk5JNzMGyNqrChyfjQPVFZOkhWhZpHDFQ7mClxZuYUXT6Xc0/oLlS8Lh+++RNB5PRHGAe7r5nujLzedpefX5Z/XBZgurn1tMXn5jWFpWrRvDVJyYYeIDhlCfE4v3HXFZ5CCKeFpzMn4Aiy+Q0Cfstw5rVIPwPwEdOo0iOrlrN12F4i34U9g0q1vS2O6DsjFoz8N8zkYxypVgBBETrg05dmyyAzz8sK+xw4ezxsXmsLTYqKPd+Peg==
Received: from SJ0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:a03:33b::19)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 13:32:53 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::f6) by SJ0PR05CA0014.outlook.office365.com
 (2603:10b6:a03:33b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Wed,
 20 Aug 2025 13:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:32:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:26 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Buslov
	<vladbu@nvidia.com>, Huy Nguyen <huyn@nvidia.com>, Dmytro Linkin
	<dlinkin@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH V2 net 2/8] net/mlx5: Remove default QoS group and attach vports directly to root TSAR
Date: Wed, 20 Aug 2025 16:32:03 +0300
Message-ID: <20250820133209.389065-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: f4593263-043e-4805-767f-08dddfee10ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YFpNOdLo/PNDDLxeXu9a75ZR4yU2qsKiFjPVQiZ3MBAwI813B1v42Y+/PO2A?=
 =?us-ascii?Q?KDwQILxENDe2e+d86dJRFHvkJZfteUb5+bt8MTKX9yVlz3tOJttM5onZ2hbn?=
 =?us-ascii?Q?Igd/jWbNLQfky9RDax0XeAJefLiD07xw+iFeXP+mjX9q06QfL+KirhxKUPOq?=
 =?us-ascii?Q?1w40ZfHmJIQEOv/SCHLC7blVVvEgM+mzdgfhcSETCWtIqrdc4uo6KQnkCUci?=
 =?us-ascii?Q?2zHEeoTbWcFh8uukGpJhA3ZxyINKdwEzbdOddM3L3Xbr/H+bkfEbaYb8LjqW?=
 =?us-ascii?Q?jVUHDcReHdsTnY9lbbs34YYNWorolpD6vGM9Z0L//q2kWR747ZswX8Qm/NvI?=
 =?us-ascii?Q?tyCxGmLipfEtggVTgmG3V1PHmY9OwnXY4HoCto/LDv3C9GaH8ZIwanswG03n?=
 =?us-ascii?Q?JNELJ3xW0Ae62hlhvrnInwW9e20uwsUl/PHb2E32VeK+pdBr1xesbrhynRBR?=
 =?us-ascii?Q?KxkjjDtxNlOP3Um8mkaCzgJEMfaqXO6dMqBouS68QPPWVdodSY9yuxCEgAeJ?=
 =?us-ascii?Q?qUHte0e3+VZ88RaHFgj+kGKENeWasokgOuf2S9EN2o72gBGZedLb52LSvPbM?=
 =?us-ascii?Q?yfkxFrw+IJhZd1qYWV7/sR5kK3PJJTqtpTEjznnDywysoRIi+qA7pMvoRbCG?=
 =?us-ascii?Q?20hk7seIaqTw6FScnY9oocO1IFIs1pFc5JK32IFdYkcOYuidoHhtlZU24zaY?=
 =?us-ascii?Q?twiGQyMDvAtKbZAKFXkhRm0d/YwLRJlyrJ7vJXDtNEv2ujMX8g6w9RV6r0l/?=
 =?us-ascii?Q?cXWyN9igY0NO/A5ofp4gUWFo6f4DacC705TGcwp0fK9REVNaQ6268FfD86/7?=
 =?us-ascii?Q?WjY8HQNel3rS7Tbb8AfNzgA6KNAXOCYx0eM6fx2v+8C68Ph+FxMbKiVhYGnW?=
 =?us-ascii?Q?DbuTnWfF17+0hKLVN00NdLSFsDMN/l1EBfSFCFMN8QA0sy+s7tJ0Nak6kq7n?=
 =?us-ascii?Q?xmxCpaRyMaElt1FklGt3A9iLPIzMwt5Vt2VNYOXg8mFmdmCImlRMFElfMGfx?=
 =?us-ascii?Q?d6cHEwd6GgkYPbl3PnEEQYTTMIPcP0GAc9PJySlW/FUBNFL/p/Y/X17nkfY7?=
 =?us-ascii?Q?lH4nENzqsZgmk05cuXnaW6yo2s0vet4wxxe26ktcdRDmQ7DelSpkRdKA3Gwd?=
 =?us-ascii?Q?YyYmKMadvwv2e81Uv22BLp8GRPZCGV3MoVMPKBbP8CLnnHySielzJ9Q7A7Zo?=
 =?us-ascii?Q?DkXXcLjc+yaxbAaDK1+uAYTIIYuL0l/jUl1/ZwyI0aFsuBcxb0XE0rSkLyqd?=
 =?us-ascii?Q?CtqlPwP0wEmbYX9a/ZY18mxprJ818qwcJiaDfvfJxZC4dU1CwuOgnKto5h7K?=
 =?us-ascii?Q?iiI/kYxwHWn+JcRrnZL2goQx3DZBCvzZcaMFCnzc0MvagcKFN6xRqOyDbbOW?=
 =?us-ascii?Q?26KqnL/1Y+km7qgks3PXHzw2PJlHyrzWsIlDn0QJy4FV/eQfLkFSYiHQVMp+?=
 =?us-ascii?Q?0lP0j8y+2j6cBALS4dO3lOUNPIn9QiZ/8K4qlcWY1P0uV3ZuvfSxfiMUikNq?=
 =?us-ascii?Q?RO4JRujKAGgasJhGrDUfReof/67T8PLhrsrr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:32:53.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4593263-043e-4805-767f-08dddfee10ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

From: Carolina Jubran <cjubran@nvidia.com>

Currently, the driver creates a default group (`node0`) and attaches
all vports to it unless the user explicitly sets a parent group. As a
result, when a user configures tx_share on a group and tx_share on
a VF, the expectation is for the group and the VF to share bandwidth
relatively. However, since the VF is not connected to the same parent
(but to the default node), the proportional share logic is not applied
correctly.

To fix this, remove the default group (`node0`) and instead connect
vports directly to the root TSAR when no parent is specified. This
ensures that vports and groups share the same root scheduler and their
tx_share values are compared directly under the same hierarchy.

Fixes: 0fe132eac38c ("net/mlx5: E-switch, Allow to add vports to rate groups")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 97 +++++++------------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 -
 2 files changed, 33 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 91d863c8c152..cd58d3934596 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -462,6 +462,7 @@ static int
 esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 				   struct netlink_ext_ack *extack)
 {
+	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
 	void *attr;
@@ -477,7 +478,7 @@ esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_node,
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
 	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id,
-		 vport_node->parent->ix);
+		 parent ? parent->ix : vport_node->esw->qos.root_tsar_ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw,
 		 vport_node->max_rate);
 
@@ -786,48 +787,15 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 		return err;
 	}
 
-	if (MLX5_CAP_QOS(dev, log_esw_max_sched_depth)) {
-		esw->qos.node0 = __esw_qos_create_vports_sched_node(esw, NULL, extack);
-	} else {
-		/* The eswitch doesn't support scheduling nodes.
-		 * Create a software-only node0 using the root TSAR to attach vport QoS to.
-		 */
-		if (!__esw_qos_alloc_node(esw,
-					  esw->qos.root_tsar_ix,
-					  SCHED_NODE_TYPE_VPORTS_TSAR,
-					  NULL))
-			esw->qos.node0 = ERR_PTR(-ENOMEM);
-		else
-			list_add_tail(&esw->qos.node0->entry,
-				      &esw->qos.domain->nodes);
-	}
-	if (IS_ERR(esw->qos.node0)) {
-		err = PTR_ERR(esw->qos.node0);
-		esw_warn(dev, "E-Switch create rate node 0 failed (%d)\n", err);
-		goto err_node0;
-	}
 	refcount_set(&esw->qos.refcnt, 1);
 
 	return 0;
-
-err_node0:
-	if (mlx5_destroy_scheduling_element_cmd(esw->dev, SCHEDULING_HIERARCHY_E_SWITCH,
-						esw->qos.root_tsar_ix))
-		esw_warn(esw->dev, "E-Switch destroy root TSAR failed.\n");
-
-	return err;
 }
 
 static void esw_qos_destroy(struct mlx5_eswitch *esw)
 {
 	int err;
 
-	if (esw->qos.node0->ix != esw->qos.root_tsar_ix)
-		__esw_qos_destroy_node(esw->qos.node0, NULL);
-	else
-		__esw_qos_free_node(esw->qos.node0);
-	esw->qos.node0 = NULL;
-
 	err = mlx5_destroy_scheduling_element_cmd(esw->dev,
 						  SCHEDULING_HIERARCHY_E_SWITCH,
 						  esw->qos.root_tsar_ix);
@@ -990,13 +958,16 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 			struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	int err, new_level, max_level;
+	struct mlx5_esw_sched_node *parent = vport_node->parent;
+	int err;
 
 	if (type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
+		int new_level, max_level;
+
 		/* Increase the parent's level by 2 to account for both the
 		 * TC arbiter and the vports TC scheduling element.
 		 */
-		new_level = vport_node->parent->level + 2;
+		new_level = (parent ? parent->level : 2) + 2;
 		max_level = 1 << MLX5_CAP_QOS(vport_node->esw->dev,
 					      log_esw_max_sched_depth);
 		if (new_level > max_level) {
@@ -1033,9 +1004,7 @@ esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_type type,
 err_sched_nodes:
 	if (type == SCHED_NODE_TYPE_RATE_LIMITER) {
 		esw_qos_node_destroy_sched_element(vport_node, NULL);
-		list_add_tail(&vport_node->entry,
-			      &vport_node->parent->children);
-		vport_node->level = vport_node->parent->level + 1;
+		esw_qos_node_attach_to_parent(vport_node);
 	} else {
 		esw_qos_tc_arbiter_scheduling_teardown(vport_node, NULL);
 	}
@@ -1083,7 +1052,6 @@ static int esw_qos_set_vport_tcs_min_rate(struct mlx5_vport *vport,
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	struct mlx5_esw_sched_node *parent = vport_node->parent;
 	enum sched_node_type curr_type = vport_node->type;
 
 	if (curr_type == SCHED_NODE_TYPE_VPORT)
@@ -1093,7 +1061,7 @@ static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_a
 
 	vport_node->bw_share = 0;
 	list_del_init(&vport_node->entry);
-	esw_qos_normalize_min_rate(parent->esw, parent, extack);
+	esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, extack);
 
 	trace_mlx5_esw_vport_qos_destroy(vport_node->esw->dev, vport);
 }
@@ -1103,25 +1071,23 @@ static int esw_qos_vport_enable(struct mlx5_vport *vport,
 				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
-	esw_qos_node_set_parent(vport->qos.sched_node, parent);
-	if (type == SCHED_NODE_TYPE_VPORT) {
-		err = esw_qos_vport_create_sched_element(vport->qos.sched_node,
-							 extack);
-	} else {
+	esw_qos_node_set_parent(vport_node, parent);
+	if (type == SCHED_NODE_TYPE_VPORT)
+		err = esw_qos_vport_create_sched_element(vport_node, extack);
+	else
 		err = esw_qos_vport_tc_enable(vport, type, extack);
-	}
 	if (err)
 		return err;
 
-	vport->qos.sched_node->type = type;
-	esw_qos_normalize_min_rate(parent->esw, parent, extack);
-	trace_mlx5_esw_vport_qos_create(vport->dev, vport,
-					vport->qos.sched_node->max_rate,
-					vport->qos.sched_node->bw_share);
+	vport_node->type = type;
+	esw_qos_normalize_min_rate(vport_node->esw, parent, extack);
+	trace_mlx5_esw_vport_qos_create(vport->dev, vport, vport_node->max_rate,
+					vport_node->bw_share);
 
 	return 0;
 }
@@ -1132,6 +1098,7 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *sched_node;
+	struct mlx5_eswitch *parent_esw;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
@@ -1139,10 +1106,12 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	if (err)
 		return err;
 
-	parent = parent ?: esw->qos.node0;
-	sched_node = __esw_qos_alloc_node(parent->esw, 0, type, parent);
+	parent_esw = parent ? parent->esw : esw;
+	sched_node = __esw_qos_alloc_node(parent_esw, 0, type, parent);
 	if (!sched_node)
 		return -ENOMEM;
+	if (!parent)
+		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
@@ -1168,7 +1137,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 		goto unlock;
 
 	parent = vport->qos.sched_node->parent;
-	WARN(parent != esw->qos.node0, "Disabling QoS on port before detaching it from node");
+	WARN(parent, "Disabling QoS on port before detaching it from node");
 
 	esw_qos_vport_disable(vport, NULL);
 	mlx5_esw_qos_vport_qos_free(vport);
@@ -1268,7 +1237,6 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
-	parent = parent ?: curr_parent;
 	if (curr_type == type && curr_parent == parent)
 		return 0;
 
@@ -1306,16 +1274,16 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 
 	esw_assert_qos_lock_held(esw);
 	curr_parent = vport->qos.sched_node->parent;
-	parent = parent ?: esw->qos.node0;
 	if (curr_parent == parent)
 		return 0;
 
 	/* Set vport QoS type based on parent node type if different from
 	 * default QoS; otherwise, use the vport's current QoS type.
 	 */
-	if (parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+	if (parent && parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 		type = SCHED_NODE_TYPE_RATE_LIMITER;
-	else if (curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+	else if (curr_parent &&
+		 curr_parent->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 		type = SCHED_NODE_TYPE_VPORT;
 	else
 		type = vport->qos.sched_node->type;
@@ -1654,9 +1622,10 @@ static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw,
 static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport,
 						     u32 *tc_bw)
 {
-	struct mlx5_eswitch *esw = vport->qos.sched_node ?
-				   vport->qos.sched_node->parent->esw :
-				   vport->dev->priv.eswitch;
+	struct mlx5_esw_sched_node *node = vport->qos.sched_node;
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+
+	esw = (node && node->parent) ? node->parent->esw : esw;
 
 	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
 }
@@ -1763,7 +1732,7 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	if (disable) {
 		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
-						   NULL, extack);
+						   vport_node->parent, extack);
 		goto unlock;
 	}
 
@@ -1775,7 +1744,7 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	} else {
 		err = esw_qos_vport_update(vport,
 					   SCHED_NODE_TYPE_TC_ARBITER_TSAR,
-					   NULL, extack);
+					   vport_node->parent, extack);
 	}
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index b0b8ef3ec3c4..45506ad56847 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -373,11 +373,6 @@ struct mlx5_eswitch {
 		refcount_t refcnt;
 		u32 root_tsar_ix;
 		struct mlx5_qos_domain *domain;
-		/* Contains all vports with QoS enabled but no explicit node.
-		 * Cannot be NULL if QoS is enabled, but may be a fake node
-		 * referencing the root TSAR if the esw doesn't support nodes.
-		 */
-		struct mlx5_esw_sched_node *node0;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
-- 
2.34.1


