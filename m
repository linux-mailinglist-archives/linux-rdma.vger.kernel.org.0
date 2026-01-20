Return-Path: <linux-rdma+bounces-15747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE23D3C1AE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 995B250930F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4B3D301E;
	Tue, 20 Jan 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wm8+9Jrd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD73D2FFE;
	Tue, 20 Jan 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896000; cv=fail; b=MqJ9h+DcQ1+Fv2qMCluPj5/GnbkA3Dd6sEjiZfdHhVHGvffK31ZCXvtHnAlCcfqOokgGpEaw63/Or8ep09wUo1FxswfFk5QNGfIAYwDoxcZm15/q9/+TUFMBwz3cyjiq9CHTW3XqR64fsWX2/iQXE5MxRhOCO+fUtzqm7smwNRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896000; c=relaxed/simple;
	bh=fxybUZ9ZdVf3H3f5esyACqfvpsaQgDEUuOjturSLINU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFnD2z3MyhbOBl/dLpMKDlIynHkVNunOH1TrR1DYeFhwUe8MRo2G+kMYmDaCK8CS0sguD6oYIYgS499SEspb9hD83yFqw/wCIwGwlxQNGaFRBYm3tefmOFrtfK27+JngXpRZ8Tto+a7Sv4fePnmvUcCd2R9GS1VhTaxR5UJ2XA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wm8+9Jrd; arc=fail smtp.client-ip=52.101.46.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVyf8uVN2VOZLzDyKh+9O42kMjiAOoKsN1mMnzA+E7idYc032kZ/Itk0olWuIxJNZbe+ZcpX2ZTMM9QMQVOprCASZ/zbrYuPcnrTmmSCqWwa9tNdsVhkWzOE2NtTx+qCgYFih5zROrD8O/OwYjfbL8z0pNnQw0o3fUfJAl50G6f9x3kOy9C1+KwSXQKW7XC43wnrzs67YrIrGlxIe8DO2c3+glkSwl9gYlm0/0Gupv6j9IG2aJBCQoc6H1mgv1A7oNqKkyfFeWpHBVmxzV2W3ErwWmngJDhF2Oxl0fxNSs4SWkfkq/zb/K2c1V25JYU7KmR+CjWZ5uLwFHYyRAy4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGz2+WdH+/nxKcfCz+M0Xf6QNMiW2jcUQ0vvnuLIroA=;
 b=v9e8ERuAKCOhhU63PbmzycPnQggYzv6q/gr9JLX96FjIzO5zErMsVJy9fCqq5/B/hobEzpnU0i0SpN4Nd+Dm1hNftK82d/Rf9jXcJnI1vptF11gdplX5T5D/3mpgTDLhYVheEM1rzRR+mLhFtfO8YORu1r3Xt6Mi2Sk5kDhvhJlZHBl9NVYihGX0XtKAwXiQ/k2KEMTBvs1cyB4f39HheSq04X78+p4u4CfUXrAIfwJAq5O2VUtp1LRoxZMy68towSONRqZDeZsLG9w4EQLHZ8cb6fjD8BNk2AblFW6c3HqrTtUMjdMpLdyWfeBsb1Q2nDaesk+UXchByLhEHNcKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGz2+WdH+/nxKcfCz+M0Xf6QNMiW2jcUQ0vvnuLIroA=;
 b=Wm8+9JrdvPX+zh4BII1HFYQLsUkMEDmzWgtWOm3sf78CP/sMHbDONT4FRm+6Axp8MKtMpBrLhFx6yfa9OsGEwymCVVSruGN57EfdZH9e8deuffSd7hY8FRf2J0RJKme2Ey+0R5rBnp3+886vBLPGXioY8MflyIbLUE74BzCkLaDdBqN1DykvhV9pi0TYlRY1SOl4y44S5fbrS7oXGQd7e8GCmGMFk8GFkNRJabk+nNwqHyREp73U0QGnCDrXyx765NfxCzowW2Sa4TA5Lze9k41+w9nIJKyJAMwUCaBXCQK3AEKi+gQ2nAR5xzdsoSBQzXMHj9dczQ23RIjYtnggsw==
Received: from BL1PR13CA0367.namprd13.prod.outlook.com (2603:10b6:208:2c0::12)
 by SA1PR12MB999109.namprd12.prod.outlook.com (2603:10b6:806:4a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 07:59:54 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::69) by BL1PR13CA0367.outlook.office365.com
 (2603:10b6:208:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.7 via Frontend Transport; Tue,
 20 Jan 2026 07:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:59:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:41 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:35 -0800
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
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 13/15] net/mlx5: qos: Support cross-device tx scheduling
Date: Tue, 20 Jan 2026 09:57:56 +0200
Message-ID: <1768895878-1637182-14-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA1PR12MB999109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae9890f-a58d-4f0c-cdbd-08de57f9e568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49csAimQpjLGCKECHyP5sd7DM5UWxHgMKa3ny+FlkMqHNfjvUEQTtIpR/AIF?=
 =?us-ascii?Q?oSXPBxVNcIkQWjeZRRYOGH04Ij3cTzeZfLlDgU0F75dYLyH0NQ/UwmOyXdal?=
 =?us-ascii?Q?bS+GssBXi5pcPVedT7lzmhvHBL1GZXNBGrygDBWVmqTdOxtcS3zPIg8n7379?=
 =?us-ascii?Q?MktC097/H8DV8/9Q3O3FzdpasVcF7iHM4T/wPj/jao+Phs+uo8Ent1nK3YWL?=
 =?us-ascii?Q?T5/1n7z3AFBVp4p3JOz+CBzxoXD4LMGbsgzk1fa6781nVLMS6B2rKAcaHKyX?=
 =?us-ascii?Q?VyuTxnwy3sri2Bi27tziQZGpEqzGGJPW8ajobXHtGGB8wgwD9YvsX1LV6YGD?=
 =?us-ascii?Q?9OvD2hQeNs2BOIciVJTQ6ELixjM8Va3aNpSpkY716M+kBoEJ81n4ZegW0e9R?=
 =?us-ascii?Q?nEaZNstOCjMzCsCBJpx5REwX45+3kUwrbe90Mj3q6Y5sewoeSGC6Rdn5l0gY?=
 =?us-ascii?Q?WtosJftm3J5Y5J3gIV+dpJ6zRsh8fV7pAnZNRezuUDib/bpuNfQJhyvFKbd0?=
 =?us-ascii?Q?5WTRgA7SvN009m8O5G6QD6tB9OmFKAg6LTAPUqbUgpAbhC41LfRvHJetU4QC?=
 =?us-ascii?Q?k5/A/Kp5yAk/fx6X2erq/lsnDLEMrKhnnpj2t8wEtc7N10IN9z/qGAUzZGgK?=
 =?us-ascii?Q?VpcVOZGMc35Ol0cswrwKZbNbt6CMK4ZvmfDl55mlQPyIixg71V8pEYQS0XFh?=
 =?us-ascii?Q?Kk7zl3+WKlYbc4OrwUXJX7j9+c9VUYF7XghLZ+D82UiK2/Ybi+uy618R2unD?=
 =?us-ascii?Q?qS1B+GOoKix3nHalbrer4av5zaI90LCTu7eLfTDSX2qyXPkt7R/jHUOkgRMH?=
 =?us-ascii?Q?QVwoqvgf2ZmarkNAWn/i9xYjiaYdFwRExKggi6icdlrrs7pYQ/a4TRGxixCU?=
 =?us-ascii?Q?rVIePOtXLSQBasyNH6cceFt/F7koae7fiPMe/vLy1zLBp+W9Ghq4ZdJn7+WS?=
 =?us-ascii?Q?4wQ3H/JFLPbZ5nHQnXsdtTTTu1VnS3wKmLa4dexzhVGeBTEe0TYUFEfY/yXo?=
 =?us-ascii?Q?H9IVqA7lbtBVllBRApY9BpmZRzxXJItNyl+dZ4skQAFrfcrSXDEnGwG+8F8r?=
 =?us-ascii?Q?8KtZnNAt5wy/c2QudPQIItyPD9CSHcY4Ve/5SlnM2PvvymO/yvvb/Ae+RhFL?=
 =?us-ascii?Q?ptBjEB6IFqIswoffdfirXe6+Y1w+JwghV4zMT3kLcMIRiMGvQ+Q+WXKKu9/c?=
 =?us-ascii?Q?SlMjtFsSn6aSvpyJsWTJR5/GnmiTHeMBdvntWQfb6UnjkGSpJ6gL1HlesE+1?=
 =?us-ascii?Q?jV9OubWuzL/L0eGzPQ4jZgnpRY/NI0XIti6Gn554CZreHR4RRwIiIhr3c3CF?=
 =?us-ascii?Q?wj9YRirJlCGzEf1AajE5kW0JmrSUCrjUAIRT2965UEC5PdR+kRPGbuQHbmnR?=
 =?us-ascii?Q?cSoiYRcCcaMTzRwE3F4BsPhLK3DAKdLg/LlnnSteJupkl9M/jLOH01+1hPAh?=
 =?us-ascii?Q?YApeAMIRvPAHV+2QfhMGUkz6Uec7zhRgPCfQeftElp/3sF7uzt4NKvohMLY0?=
 =?us-ascii?Q?tnBLRWENfpSrIstUwDJxwSGwXdc8SXwBdduqx3hJwgVZL3S3S5vTIz2KGDMQ?=
 =?us-ascii?Q?nh/jecUmAzKEOmk/0YHE4KOeCvKuXSgmQvojl2HFP57gNkBz2JWv6vtnBMcc?=
 =?us-ascii?Q?/nFxvGcZcNWZ982cf9EEOW2JIqPQ9e9VeRfXLuktOjaUh1cylucCk18CFe5t?=
 =?us-ascii?Q?f8h40Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:53.8766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae9890f-a58d-4f0c-cdbd-08de57f9e568
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999109

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
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 122 ++++++++++++------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 0d187399d846..b4abb6fa2168 100644
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
@@ -1213,8 +1253,17 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+		struct mlx5_eswitch *esw = parent ?
+			parent->esw : vport->dev->priv.eswitch;
+
 		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
+		if (!esw_qos_validate_unsupported_tc_bw(esw, curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1224,10 +1273,9 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 		extack = NULL;
 	}
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
 						 extack);
-	}
 
 	return err;
 }
@@ -1575,30 +1623,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
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
@@ -1803,18 +1827,44 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
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
2.44.0


