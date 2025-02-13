Return-Path: <linux-rdma+bounces-7747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D37A34CE0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251821652ED
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 18:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391F245014;
	Thu, 13 Feb 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kivBPLua"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3024BC13;
	Thu, 13 Feb 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469790; cv=fail; b=AaKa2SHhEWVLYKg/VKeFw3SXZPDbYVM3Mdi1cMA3JBixUAMbtlvut9kgkCtIdMDaVYNKgeJqVAIGAz2Rg0GwcibsiaL3+s+Dx7xOq6MwbghXB3PzKmc/uv2+2jVwE2EXqi1akglDI0Tc/Ygt6O9VnvpCxgU2xV+Qgq/sOzb3SsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469790; c=relaxed/simple;
	bh=/RkT7MOaPWRzkHIyutSWxiflTKU0ftTLXHbnW0Lm18c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=us1F+DkHRFQ0AvOpI+sODstNCrnkDvL700uXR3GaSju6H8NwW4sw4SEtJlnqXbVlMzSaETpWBGKxT3cxR5Rn+/1//1H2MPjX98fhP0uhmgTWSjzCsbuzjCBLeMWgMlwhh63Y84TwuP7ibSeLruKmngBzkgJH8wHLSoWUuvlGAik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kivBPLua; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVRlbn9ImM4A1RDA3Lap3RrbvobJffyL/ym/cw8VVeS9aD88q61jTQeRBHoFZhc5iItugA5kVglwCU8hEYAWQxq7rEQ2evHRdjJvAJUUXp2SaALIo6G9mnlN71nSEOwCYifjvfYyd3vPp/yuUh4oCxHghvx7UROlfZI1kA4fnHxN5v5FvhaeCcCzCUfJV6lQt7IfKn8EPfk0Da6xGWFTPBVsOPFeDa6JO6MbomaiCEMRjCI6eDHcIIXv0kVY94fJMC7P/WdJ1ebr8iw1Myv+uIDxZTvA0Ngc/Lg7xVHET/TYAcmdfDbTlA4wUi7awqnDI2pOwvooFmkxioQqhTBxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e40PPhyVORJ4EwPSm5oUz+X+G/MUu0k9v9P7J6aSqvE=;
 b=ZDrXF5WQGIiaJbalnK4w2uQprkb3bzGWfOMnHxqsZ/iVX5SrkaVIv+QRIferA1NnoKm3M8hLXpGYz661ByxEIu3KMbk5NhQ9hgVYNLkePuDz0Viep8JIeba2WMOXaj6Gyj7Ray/mbtrnMDi6hguICVQsyG8tgLBwpyjdOCUYT80nVuMQh4qlmomNf873dzWD6mXqJCkiZvMUS18LrypVjdMQVNtd6rV5yNWBIlEI4AXpygMpnDxEX+BEy1Whp/b3AGEy8vJ2Zlnlwheeitm+l0v3Kjw2Hyw6yfOnyrqolXO9OBsWhQr6pPNKgo9/+r3RTlawaFdQPJqnmXkei7xSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e40PPhyVORJ4EwPSm5oUz+X+G/MUu0k9v9P7J6aSqvE=;
 b=kivBPLual0kp6vCW0TfbKUD0+TxfhMWL03OtEZ82AwLT+3ABPZxAqV/KSgRQ++MKr31ZI6hNb3VzahSdFvFlRYlc3BYbPsS3XrT7nZ+FXawUqoQfbk2NIpgsqWxhkyQMn5hxXOdMjSGosYpn4NCV5PN7z3To/vlEvuWZAdJlkj3CHrMci/8VjWqtvSFkZ1N0G7k7eBs+qcf7CSzcSCk0Vo8ZbNirqoSWP1vD7pXOeNaWvidQE0bP3M/K0WTuSXuLocB43EsUWdXWE69Q5TK+4XyNJRKc7i2ZzkcIHKdZTl4CM+F0NlZ5JXB0Dqf3NxsUu5AcP83xGka/cfwcDap3Ug==
Received: from CH2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:610:5a::26)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 18:03:04 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::a2) by CH2PR08CA0016.outlook.office365.com
 (2603:10b6:610:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 18:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 18:03:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 10:02:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 10:02:45 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 13
 Feb 2025 10:02:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Jiri Pirko <jiri@nvidia.com>
CC: Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 08/10] net/mlx5: qos: Support cross-esw tx scheduling
Date: Thu, 13 Feb 2025 20:01:32 +0200
Message-ID: <20250213180134.323929-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250213180134.323929-1-tariqt@nvidia.com>
References: <20250213180134.323929-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d777010-fcda-4593-29f9-08dd4c58a99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YnjT+8X4FOgw5EvdqU5hYctoD7kYdeliGeF6GtwN54TFeXri5/IdjBvy7SeD?=
 =?us-ascii?Q?qIiRnlBNruqMuYAZNB/FdwQ9zcQj8g4ducK97+VAzVLqEWvZe6c9LLGACl6B?=
 =?us-ascii?Q?sURpEl/6UIHa4Ujw1QAOBLlyuG0SfOpCPxCpA7bRHvRTXIcKQlKTbssW8Ram?=
 =?us-ascii?Q?KHWKNLOomawHjTti1Do4ztTXGJxhdgSpmhs7BMd1g+KXxn5kA9fNe2TqKSOJ?=
 =?us-ascii?Q?uy43EQcSq3G5wCyvhGa+yDOBp00N+df7qucCaUVapoLzZG1xW6GpH7KXEqkU?=
 =?us-ascii?Q?aqHpQ6ZoEZxag6mlTFCf5wCYZkbrM21fViPKNxyGfQEIwAy385n7lFL7Hucz?=
 =?us-ascii?Q?fNGtP9p56FE2RBQM0ZpTtIW0l58E8Ui2+dZrA156oT74CPmu3BLVM+mJuA27?=
 =?us-ascii?Q?QcrAOdkKdDlsA/r2TxpKpDYoEX+hbxBnuq7gYQanYCv9D4CSRzW/Vh18+p56?=
 =?us-ascii?Q?ZFsn8TJ37m3S/L5AjhtaJZfKlLju3Ug58r9dYzEeIEzQWnuLb2Sd+WPn+XKG?=
 =?us-ascii?Q?ngh+NXWQwU2P079Zcruz1HwPgVPuFftfomKllyk3ndv6V+qHc8fa4K3i6jM8?=
 =?us-ascii?Q?iJv7xTiCirDYBQ+HqML9mwm7D+JUHq2d8TsRqhCFHEFQh0QNinG1297Kwzo5?=
 =?us-ascii?Q?k2t5xwVpPrNMu2piIpnX4l4DNQ+eUe+yHKsCozICyIuvf2gXP7FawFqS3wv+?=
 =?us-ascii?Q?AuKaAiP9SanM8uI9VwVm7hTvIeRkTGGCXSDgt26pkq2LE9KdUSMvorAXjBTr?=
 =?us-ascii?Q?vQ3TAWeVD4Wbtvuxt+mmjVxBrpnxC5S89zSP2hyYLwAVLIdMq+3P8AvrdQyW?=
 =?us-ascii?Q?3J2dokABM3cUWkCd2+V2V7sOMXWHz0wUVY+1ntn9pyw9cQiXpS5PQxZiHZ09?=
 =?us-ascii?Q?Hdygjm9zcd0SFDK63lEI7fI/F41ojupbgIyqsRCPGtjQLqG/ZDwjFP0ibvsh?=
 =?us-ascii?Q?KyErdZyTMK+iIazsXDjLzU97FAwoD6B4Hk1OP4/s3f4GRBwDa8PVaUDUDYlQ?=
 =?us-ascii?Q?9vk7pn9Du0XLgaacAk2Q09yyXcc5gFB3ngBnlJ1UsEZ+CKucSvPn7X/k807y?=
 =?us-ascii?Q?xCygiySa2YxxIpoQx2RKz6L8/HpqPvIslDRCtdmwv16T0f8c3zJxSIoIoj6g?=
 =?us-ascii?Q?k/MDpUJ+ZGsELsSP4JC/CPr6XEKSkkB0cx7sr0Ykuuih1dhxQ4BwR5+ALJ/4?=
 =?us-ascii?Q?LQMJami9xqLKW3IWgdiU/2clDMDTj583uBdganS5jsKZElLu5q4IoY4GCjQS?=
 =?us-ascii?Q?8oZy/VYwUFZjm8HdV+ETvgOnUcTJu/o5Yh4ETBqoTNg6ziqn6chvwg/1eSEE?=
 =?us-ascii?Q?uxvkqDu1/UZ2mBKyIBhiefVEwPTFm9QQDUVs8O0apdnp32S5DW5ldR0V2B7D?=
 =?us-ascii?Q?DI0VmYCQ5yUXPQwuvfZz65+Krf+L4HI+ihQ+jVRe56Mlbl5fVVPC4Dj9xbVr?=
 =?us-ascii?Q?XSDUeYIy2PLgOOy2efqTY7Ebx++UlWhYQs+stDkRLLTOXJZ+3Fyv9z0Sspx3?=
 =?us-ascii?Q?TbyQzYn2HSPhb7k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 18:03:04.1267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d777010-fcda-4593-29f9-08dd4c58a99b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

From: Cosmin Ratiu <cratiu@nvidia.com>

Up to now, rate groups could only contain vports from the same E-Switch.
This patch relaxes that restriction if the device supports it
(HCA_CAP.esw_cross_esw_sched == true) and the right conditions are met:
- Link Aggregation (LAG) is enabled.
- The E-Switches use the same qos domain.

This also enables the use of the previously added shared esw qos
domains.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 59 +++++++++++++++----
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 6a469f214187..e6dcfe348a7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -147,7 +147,9 @@ struct mlx5_esw_sched_node {
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
@@ -398,6 +400,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(dev,
@@ -408,7 +411,13 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid, true);
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, vport_node->max_rate);
 
@@ -887,10 +896,16 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
-	if (esw->qos.domain)
-		return 0;  /* Nothing to change. */
+	bool use_shared_domain = esw->mode == MLX5_ESWITCH_OFFLOADS &&
+		MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched);
+
+	if (esw->qos.domain) {
+		if (esw->qos.domain->shared == use_shared_domain)
+			return 0;  /* Nothing to change. */
+		esw_qos_domain_release(esw);
+	}
 
-	return esw_qos_domain_init(esw, false);
+	return esw_qos_domain_init(esw, use_shared_domain);
 }
 
 void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
@@ -1021,16 +1036,40 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static int mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
+						  struct mlx5_esw_sched_node *parent,
+						  struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	int err = 0;
+	if (!parent || esw == parent->esw)
+		return 0;
 
-	if (parent && parent->esw != esw) {
+	if (!MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched)) {
 		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
 		return -EOPNOTSUPP;
 	}
+	if (esw->qos.domain != parent->esw->qos.domain) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot add vport to a parent belonging to a different qos domain");
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
+int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				     struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	int err;
+
+	err = mlx5_esw_validate_cross_esw_scheduling(esw, parent, extack);
+	if (err)
+		return err;
 
 	esw_qos_lock(esw);
 	if (!vport->qos.sched_node && parent)
-- 
2.45.0


