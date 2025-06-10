Return-Path: <linux-rdma+bounces-11155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB07AD3C9C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B71BA18C7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED27241C8C;
	Tue, 10 Jun 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nKP8vtL4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B7236A88;
	Tue, 10 Jun 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568587; cv=fail; b=o6Gkzqudgo+bfrGoMw6hiCUD+zoCnESih625oKZpyzPA0yx5H5ObWc6zoBaL3f6YMT1nwWa5oz86NvKDqsAVHGF1vAvBqamWbh5PONDcLekl4KpxKRJa4JT1R42x8iMTjF1KWVuB2vRh7Le0walOz9u9dCfvysEWsXbSv4Ut364=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568587; c=relaxed/simple;
	bh=7xUMCH1zjIEKI5OqTPYcBHrR8Z7SHWeBaI81PIq8PAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cv3XIlZZeg2Bvl7ROPsKRzWiQnUDdYWqmwxciuMc4CvcZPeh2gsjByK5HKo9q0pV1lLAJjgDM8JKLZqB+TrPCYOXwNxilyuQn22DhX+5qnVM9LoMdrfa5QCBzE4SGHhMIxtua3yyi+qHI4VQMazWTQ9LuoXafLd+NGYmGNt/05I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nKP8vtL4; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4Q696taML9KycMJaWkcP86rIL9koUryJTvOghHF7o5J7RON2HWbNx7S/FxPIMfFrGRRLegyBbbF8sLfOFqODZoqqNERPpm1rED54Na+1XSlg6eHA7dLesvj+qxmVj1qJsJW8QanvkHelmFlhB3j82ClRyTzDjZrc4SXA8l9HOZJanq+/q9DWP/Qm+OURrDhXbzhzR2Id/LHRB0GGtijpAKdcoH0p08XllzO+BdM+7iTNJwh5NqJtqlREQ80O0Bwl1A46i4H5TemXgn6WSDV+sYBaqj739BI2d90Vm921uxUoiENaW0nsZ1/olbqLlDnfwCfExkRkW/JQsZaKQIbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9ByInyZ6sBRqF7kzGTr9HCuEY1yjM6NuxVnPFokOmY=;
 b=cyIQytdPhFpyO1cScuSRJdMlMS5BKD7altRkldqq8jqorasdQjjJEGPYncPrx0CAagCHXWiRZuhrGfF1dQ80L32GiqPNkkBAA9jIT9lcNbTlEyGA1irzv9yjZID5Q9AfIZtGHJTAzuNBSRN2ZbwX7BCc3IUUMoYuyZUeVIJtt6eKPPtuQSWw7kvBNSWmVMmaR4Llooiex29vNMH94ZcvbV8KO67ITdcUddAMZEBQ3PAHZFkWRcDCSDvhMjwVWX7EMuIYwZ+AcYm4mwCy9bubayEGgfaqOWFhSECUxjJH1WxzkqlO09NnGhpogo2zdDtvRqotARee4R9bSut7j1vZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9ByInyZ6sBRqF7kzGTr9HCuEY1yjM6NuxVnPFokOmY=;
 b=nKP8vtL4wLxX1WAm1Gq3A/BoumFfJO2cGfnegL2Vxba9fIHjQQqj5xW5WEInlI4OOWYoPkAPjp9oI825DMSzSNIfVtvXXWd6Y7zp1NSumCN75vpb2eRTaUtbn72Wqs+cF98xNTQf/5j2TPuieXA86ogByn2GPDIcrgYSmCHRqvmfDoEIy6uGgACFyo5hoSLNUkNV7goN74GqtNrKnHj8APFscPs8OuhcSNsJ2KtB69cAEHHum1mCPfdhT4Xf7HQWRMiTtqSpKzbgzWkPOKdAxkSlSbVWw9CqM8eyKoxll2laAeM/O/jnEW+tqkv/VGvH8SitrrrV814wh5eeMnr/ng==
Received: from BY3PR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:39b::7)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 15:16:23 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::56) by BY3PR05CA0032.outlook.office365.com
 (2603:10b6:a03:39b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Tue,
 10 Jun 2025 15:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:22 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:16:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:16:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:56 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 6/9] net/mlx5: HWS, make sure the uplink is the last destination
Date: Tue, 10 Jun 2025 18:15:11 +0300
Message-ID: <20250610151514.1094735-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dc890d-ebb5-442a-f999-08dda831c25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3gDB70v/NvdaFu+yf2GTlfwVV9UwJxlH8X0fMkJrppLaxkMbmKgLhhA8jIqh?=
 =?us-ascii?Q?XZEz/pjhznaXYYCtTv5poc4BWzQPIexEMAnE5BQWmzqfQoCgH85X1gjLKhZH?=
 =?us-ascii?Q?cnmHPcgxnzhX1Pxfydzusqp2E7VQMSTJ9lILDFb2S5OVzGMAgJSdyqq3tSY4?=
 =?us-ascii?Q?jGdwNWbVqsRZ9nYw6PVKpOTZGDXxbPO6nVxt6h5xQ6g2I3HPovgKFx2bWQfR?=
 =?us-ascii?Q?7ermPh8E+QjGqhO4O21GmRV5aeZrHJVMoc4G/v1OMsLoCRWa28emiN1wdl4a?=
 =?us-ascii?Q?xb6jViiLKwwHaDSPIkwh9ZBbIiUu/HnrXFSZJAtXkWFUNEnCY7ud12AX+0nw?=
 =?us-ascii?Q?a75MDxFaze9yxq25kHit7WNngK0J2t7Mvo9qBmEmajpN0nBCLzZiEWJGp8Bg?=
 =?us-ascii?Q?tq3AluwBxcVKMXNUqv4c2rcjWMzO11HgdVVA5VC7TIbmYESivR53+XeyvHP0?=
 =?us-ascii?Q?YDh3CMY9Pcn7z0XoZPGIMW26sMMENy2pasX0O+6KZHfoQwl2kZr+H61UV93N?=
 =?us-ascii?Q?L5OxWKZKMX1FhX4zGgUDkDQlxgNuzDI/r+VNqm8Vhg1OQGtYbm8gCGRjtxk0?=
 =?us-ascii?Q?K7GSYxDfObf+1fEpKvKNokqRJhVHfSA5PCdD3xS6VZ2ksQk4z0aKPHFN4zPo?=
 =?us-ascii?Q?cpjRTpmc3r0FlV5GPZF5NHfakzJpOSUtjHTvCFZWRuR2FdX6CW9IL0kirJlV?=
 =?us-ascii?Q?QtMKf7LFRV0pBQ2DodyhVOK603I+TBZ1os+E/jTBVluCTTzxb5Df2a6sx52c?=
 =?us-ascii?Q?Kor3sM0eEGiNWd1GsqXvzI8sGhjmo9MFVHCGHMNyBdw3kcQyJBzIFrhIYKB3?=
 =?us-ascii?Q?1Sxz5E2HBnAbivGG4LMnqe9OnIMXfRJZtl395F+8ImqLlZkqMDn9bgjPCUzD?=
 =?us-ascii?Q?3Ngpc3/ZNM1jA91NM6ORna6NYRRWysqpqhTJwaJXLOoBAR0la27HYHEOaxVK?=
 =?us-ascii?Q?0Ela+4BoaeX9NX8BzdZdnIACGSvOL3TRs5Au+nPezFrHjp6hVapSgDGoLNHk?=
 =?us-ascii?Q?n+jL0a41oxrV2bj/pXQlRx47EeeuX81gDMOVTsv0y/0nUc/1Od6GFHwq7plr?=
 =?us-ascii?Q?yzVW56UlIstXX9MKxM7pyn1FLFEZUeyQqsGWgTg1hfv1THT/a+1A+c7M8OFa?=
 =?us-ascii?Q?4Tylf6uWMliL+3YzabaO1r858qXukHEUFCeXbuzB6gxJLGFqE6EURD9fmDyr?=
 =?us-ascii?Q?d/jcOuRFQi3zIqE3A6ECNPV8OxadizR9GPnSFYfplozor9MJGC9LjdO/JvpQ?=
 =?us-ascii?Q?iLHQOvcX0ZFwMqC/ZJ5q28qQTY2jssc4QSz7E38P3FLraZGvN+H4vdWtPvZj?=
 =?us-ascii?Q?rJulhguLxyEA691TchzLY+LHD2wI002FFUEamf8i92GFwLPXYjlY29KdGFZ1?=
 =?us-ascii?Q?G8GJd1hY7TEirHOBrIJCyNjdXr7hcWhbD21IJ5OYVcHdMSOhg/5HobAcgbKd?=
 =?us-ascii?Q?13J/sn3T0Jfapzt/Hvyp/wZsIbZ5MIjj4+bgCPHhvDXT60WLViM/pVZB40FX?=
 =?us-ascii?Q?2PQQdDseLxu1rzpqYF5Yidvh8wd9iVfzkm+M?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:22.2877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dc890d-ebb5-442a-f999-08dda831c25f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699

From: Vlad Dogaru <vdogaru@nvidia.com>

When there are more than one destinations, we create a FW flow
table and provide it with all the destinations. FW requires to
have wire as the last destination in the list (if it exists),
otherwise the operation fails with FW syndrome.

This patch fixes the destination array action creation: if it
contains a wire destination, it is moved to the end.

Fixes: 504e536d9010 ("net/mlx5: HWS, added actions handling")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c       | 14 +++++++-------
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |  3 +++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index fb62f3bc4bd4..447ea3f8722c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1370,8 +1370,8 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
 	struct mlx5hws_cmd_set_fte_attr fte_attr = {0};
 	struct mlx5hws_cmd_forward_tbl *fw_island;
 	struct mlx5hws_action *action;
-	u32 i /*, packet_reformat_id*/;
-	int ret;
+	int ret, last_dest_idx = -1;
+	u32 i;
 
 	if (num_dest <= 1) {
 		mlx5hws_err(ctx, "Action must have multiple dests\n");
@@ -1401,11 +1401,8 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
 			dest_list[i].destination_id = dests[i].dest->dest_obj.obj_id;
 			fte_attr.action_flags |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 			fte_attr.ignore_flow_level = ignore_flow_level;
-			/* ToDo: In SW steering we have a handling of 'go to WIRE'
-			 * destination here by upper layer setting 'is_wire_ft' flag
-			 * if the destination is wire.
-			 * This is because uplink should be last dest in the list.
-			 */
+			if (dests[i].is_wire_ft)
+				last_dest_idx = i;
 			break;
 		case MLX5HWS_ACTION_TYP_VPORT:
 			dest_list[i].destination_type = MLX5_FLOW_DESTINATION_TYPE_VPORT;
@@ -1429,6 +1426,9 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
 		}
 	}
 
+	if (last_dest_idx != -1)
+		swap(dest_list[last_dest_idx], dest_list[num_dest - 1]);
+
 	fte_attr.dests_num = num_dest;
 	fte_attr.dests = dest_list;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 372e2be90706..bf4643d0ce17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -966,6 +966,9 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 			switch (attr->type) {
 			case MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE:
 				dest_action = mlx5_fs_get_dest_action_ft(fs_ctx, dst);
+				if (dst->dest_attr.ft->flags &
+				    MLX5_FLOW_TABLE_UPLINK_VPORT)
+					dest_actions[num_dest_actions].is_wire_ft = true;
 				break;
 			case MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE_NUM:
 				dest_action = mlx5_fs_get_dest_action_table_num(fs_ctx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 9bbadc4d8a0b..d8ac6c196211 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -213,6 +213,7 @@ struct mlx5hws_action_dest_attr {
 	struct mlx5hws_action *dest;
 	/* Optional reformat action */
 	struct mlx5hws_action *reformat;
+	bool is_wire_ft;
 };
 
 /**
-- 
2.34.1


