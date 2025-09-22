Return-Path: <linux-rdma+bounces-13546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF38B8F134
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5526189D7BD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCB2EFDBA;
	Mon, 22 Sep 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pOKOHX8A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F22ED842;
	Mon, 22 Sep 2025 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521241; cv=fail; b=CJuIl0pjYJbdUQtYIBFwzuB4esj9+JhOvvOGdcM9ATI4yacpTIc3+dN365jyP+kffxMBsqUvFl/XRr1Akhg2LX6PhfQgfWkiaRsQmbkT7RL/niIEdkEdl11LTTD8dP7lfIbVoHfKR149qMJP/cd+NKGyQtisIkpbu3zRxsyVhws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521241; c=relaxed/simple;
	bh=ICXglgFmSSeBHSuDdF1CCra3bktxfrAhNI9j7AY0Ck8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXwW6urITs3CYDmu8GKdPA0I+gP4dSy0MGto/2rabaQ1c88imA99Netm2rvIFwKhLbz+QmmVjSYPVBJtEengb9Boheq7boZcof/Vj2NVFPGbl38oHC0pBqvkcCle/eJF3XGoNBXVnvoxeOUt2mR0P52JfIezPSXY4XDXd/WcqnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pOKOHX8A; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj756NMfHEfRQ01dPtdE6i0P3P6WGu6K5JE/ZgmPvX6tvF3/uDrtNAYNPjn7OY8COMzHl6OQO2TfRZj9WD4YGqLkX9fKfrg/QQKnFWnFNM9XbwV9/4Pe+Oc/rBtFSry4s12esrp5bfG7Y1S7bJjx6rm9cPwO5iwK3AFPVV8tNrPy1zWqtkUKpK2u2hHD4+z4WtJlWpmS8NXL6GdbiwuytygKM79wGUohfKnxk55SS/4M5ikIxtjYXtopkI3UTWjNjhSTe5QGuziXVzzxomLTRytHGP80C4Qz95SP2r/U2phjMwvOwPPUCObFHJENFVy+KXJ/J4LGKmtZhrdzT8Y0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EPjZRqLLBkW2922HUh/7lo+9pD1vlgxfjNpn+KNTXo=;
 b=EkCFuMm+xOw4y/02A9eJ9eUmpmSmggFh8aOUiW9UWIFc/8LGyEqz/OZO5VI9uYKQD9ly6FGyge//qtU6bmD3x+bNvDCYwzgS1LTMkGKscb4+6vdgK+b5CfaN7ZDvl9dcxBZ6RJx7lvSUum8FbdweqhZMRy2l6qmY3oZFieu1YQPq56SaklVd+1scYwN9m0YXTCuq4SkH/gcci06vGHEfcLPUhDdeb4Iyft61KvZMUlt1hpWgSpE2IKSZdE5MNlGumpR4mXuZL1x2HYPfrNMdM3birjVT6oBbkH+p7fuc8tGvGQoQTsB2kDxNNsTQzBsaC3p7RbgnRSAO35nUwYFkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EPjZRqLLBkW2922HUh/7lo+9pD1vlgxfjNpn+KNTXo=;
 b=pOKOHX8AW36wgy1OGoEK2CB3MycnCR47Qz99+tHEzVPj3I+eSl349Z3YLSr6GhbTe0oakywpQbliUxT/WEzYaZkU3PoCAweD3nNo10Z26ovffT3M2Dzi6QA6/ZxyuBqu0D26Y+vtn0edBLd4Jh0HBaJpwpGNqOx62kw+k0QIrNfE38IascAOLjs4R+rwOoyEHfSdwFi+/SYZ4zumj/kY12x5LzRbcMz+0lcEsq1ZsP/dXIVbZMRbN8e838/EAYKGskgtcXuT8NqN5y5IldcvwKy2k4vJY6RwswmUVqA/Iigfb3mcWC3o1drqqz7GT027XlkWg3JbaPSa7hzjPMIdAA==
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 06:07:15 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::f1) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 06:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 06:07:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 23:06:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 23:06:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 21
 Sep 2025 23:06:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: IFC add balance ID and LAG per MP group bits
Date: Mon, 22 Sep 2025 09:06:31 +0300
Message-ID: <1758521191-814350-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>
References: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5d00b2-a765-4321-2879-08ddf99e46e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVbXYi7hf/w0TD/cEfjWiqIXdBS7jpz0An7Bl9KeMXbIgaBBb3EThUuQhbN2?=
 =?us-ascii?Q?rhNNUK0iD+jvOpkHNeD+OBjuC+scf6y+WWzkzTfcrBvb22shC+/NIE3wjazD?=
 =?us-ascii?Q?7yX2rET1WgUbKzCAenEgbzntE33n9FYQ1lxmVYQyQb9JiJw8jvwu28gYzG1x?=
 =?us-ascii?Q?LRq6UAuO56w7EmcCd5kSBx7W1FCsNdxDsEVc8WfIU1MhjpYe4j3q02H7SZT3?=
 =?us-ascii?Q?5KGp4UA/M4OwZNuutCzGqjD1S5C3/4J23Lfu17WKUXInItXtPOwUT54VBV01?=
 =?us-ascii?Q?9KaVsxBbFJikXRMoH9C9Q3CowLOVlRKpyb0PubriK55MdcHTaqNELPk1A7yp?=
 =?us-ascii?Q?+AQf9R7r7/8l7c51VSvQcUtNsqwgcFY4pNZ8NGH2axXIcYfMtt3jOyGNfVWL?=
 =?us-ascii?Q?OQJjGD9tWiJbOgggMtm2ctg1hKanLMfz8I4D5dY1cWocTMkx2kapBGo6RVUU?=
 =?us-ascii?Q?SqKHmyji59UepQsETNVsaowzsjmWjJfZDhrOcHzPrGOc00tC2+bxjJCbBYqg?=
 =?us-ascii?Q?JRWeyTqwGYrQWSL0elGXB23jrKGD2xxloVDj3bUmMkU7qsteh5Qi7Xaf/jtp?=
 =?us-ascii?Q?pq4Zr58DOAPYe+BJvex6I9roLn2wQiXlZRDlaBZmk5S/uPxO+fpzKdQgyi8b?=
 =?us-ascii?Q?3pB1XqzwshoFOE3/KapMJC7BBWME41YSSIVQz9CsZgJ2S+rIlLvUQVwE+VEs?=
 =?us-ascii?Q?4M/s2VjI/FQSP2TPMI34dLkHVxyzuG8EimXTv0IrxvQYk6+nwnmADvfEDdx5?=
 =?us-ascii?Q?fWJwlVrWgsUk/y7Ou8IxYpLFivgJNF8B/T/3j/7r6hzLUO1hUVGt91NX5qW/?=
 =?us-ascii?Q?WFAXuq7y2r3GzbOS0nc6l6zC/9IoG1s/kfk4T0QyuHgNZpLlxiW4gU1RFw0q?=
 =?us-ascii?Q?718Mdymz6MqCy0XLCnWFA43IFBDhx+GAKucQf1ifyEa8BPZELIWaNbwcbHbA?=
 =?us-ascii?Q?WoplcP7qkxJCIu8d6mn+MQe7qltrZqKLay0JFGz5MQm10jHmPRpx02DM2Gni?=
 =?us-ascii?Q?A1Dg3ibDrZZ5Cm6pqrvVXhzuz4I7m7uSicm5P5AKd32knLV00LLedgM2XvoC?=
 =?us-ascii?Q?sKq7VBA8S+yO+h4thPsO3JGaKWKFbqbb3WOp96/m1wugKeK8+5VM0p0k6GE9?=
 =?us-ascii?Q?3RW1RZzRXZhjQBm9JSciNoIL4YW78wXFdeGL0/AsEvbuFpXI9pmlFoVv4FKX?=
 =?us-ascii?Q?PMBr2GQExYnL4om28I/8rzvkJ9s+3auzgq1kZK8Is0/Ie4IFLKHylSA7OpTk?=
 =?us-ascii?Q?qgDJRV7EuhKkRwVboXct1uOvoM12jqcjzT3avtM4aZZjP+Su1a+7KDGQcpke?=
 =?us-ascii?Q?1F2Bko3/oqEf4RxCYYa0u9b1KpTnoiLpv9Kp7oFEILF6OrJZYWqCqTCt4s2d?=
 =?us-ascii?Q?P/WCvvZRr8yTYMSPVWLrnreZsAg7Gi4gkWSmumr24xN36R3opb0tw6gfMy2W?=
 =?us-ascii?Q?Z+oF8SXvxJzFFIn1/OkrF6+f5z7zQ2GHrv1v2QNPs/nFxgDq7FQLSjf+OQLm?=
 =?us-ascii?Q?Vy6LmaG1QEvpuJtX1/F39Cg0YX8HZCvfMuh6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:07:14.4321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5d00b2-a765-4321-2879-08ddf99e46e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

From: Mark Bloch <mbloch@nvidia.com>

Add interface definitions for load balance ID and LAG per multiplane group
functionality. This patch introduces the hardware capability bits needed
to support balance ID in multiplane LAG configurations.

The new fields include:
- load_balance_id: 4-bit field for balance identifier.
- lag_per_mp_group: capability bit for LAG per multiplane group support.

These interface additions are prerequisites for implementing balance ID
support in the MLX5 driver.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c0f5fee7a4a5..07614cd95bed 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2235,12 +2235,16 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_440[0x8];
 	u8	   max_num_eqs_24b[0x18];
 
-	u8         reserved_at_460[0x160];
+	u8         reserved_at_460[0x144];
+	u8         load_balance_id[0x4];
+	u8         reserved_at_5a8[0x18];
 
 	u8         query_adjacent_functions_id[0x1];
 	u8         ingress_egress_esw_vport_connect[0x1];
 	u8         function_id_type_vhca_id[0x1];
-	u8         reserved_at_5c3[0xd];
+	u8         reserved_at_5c3[0x1];
+	u8         lag_per_mp_group[0x1];
+	u8         reserved_at_5c5[0xb];
 	u8         delegate_vhca_management_profiles[0x10];
 
 	u8         delegated_vhca_max[0x10];
-- 
2.31.1


