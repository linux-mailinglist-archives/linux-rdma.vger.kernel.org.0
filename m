Return-Path: <linux-rdma+bounces-10684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B3AC341E
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47153B95EC
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 11:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D281F1517;
	Sun, 25 May 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dw/1G9H5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05024143748;
	Sun, 25 May 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748171762; cv=fail; b=bD3jYhOSWYs5bKC4o/sAzbviif2+4oDDsfz3fcW3mp1hrvvYIWI2dKAneoTN+JjxlIqub0dph6XWCdNS3y8G2lrNOLiGzcGWi6LrzqOXeWQ1wylqcgQla+lvY4rdyDFIK+Ysbqq4XWbfsntjPJqmUDjvTHGZDMIs0vAq6j49Iy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748171762; c=relaxed/simple;
	bh=+vukl64guUe/LsD1GE2O3pnn+1b/oJs7kZ5gaB8epqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyoKjkQVMU/9mTfIgL+BM8msiInAaXXaRurrlkpqqgOfSvVNhG7/m9MtUFr4P/JdBEle0h8Eiqi9wGCxT06Hp8+K8sllBxlQ4AgCu+PL1TFY0Fj44slVVYLVJHC6nJkuRk2raH358Cb00rVqszfUxOnisF+1iE6+xaFdkcO56GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dw/1G9H5; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbr6HgkE35DAfhSS0RaFHg94C2oa+nPQ9RwZBb0QaSwVE6nN+QMHtAiB822SWCOik2wgWq8cdTGe9o+fpFNognjYQ66e/FgoGGbq0kFmpNld2ZNr4G3AHF8JPJcR7qj8DPLchMDMgGBOuLhA76piJblukkfRQGlbUeE81Ymx+vf9ts8ptFkpsC/7KYMcBwDeS/2HDX+nLlOOBYqNXhA9oU91XS5RhUYFqI+S3EW0lO8tX8stT+4A1hwBGCMIVzGaOveb1rWqidRpd0XQe6RBZFuWqKamosLIKwCVFjOayscRn4IRGtctq2PeP8yI0tx4xiaJIbbCsA9L5k7MVGefuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iToxc6lcu52x2WmVEOw7VMc1QfJKN3uCmcvtWnfIRs=;
 b=TpgPVmXFMWVLddeaAwtQUfnsbm6RQDKLX3xmoOqojs1VzUqtHI47qeaZCngYqeWzWGpgcp00x0GeA3jg2MI2evminvpOokx8iC+qQbMbNHqUYmFW1k7OgKU1BQLh7YKKYFD7dC5IVJTzT/cHhLuYYoUK6wbR8BGu2lhgxfGjgALXC25RdBnQmRXpyfHp4D7rVxGo7rssgEKad2ShNFPcJ8HTjGuybxPZDi7iX4EOpKbkI7zbiUai0xr48/HsnIfxfjJch05FkhBBF4hteJIJkCf44xiOKkiGXqWRw63qlmMDNXvJac2cNHPfw//INU4OD2ZRS0Egeweadxx3jbu0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iToxc6lcu52x2WmVEOw7VMc1QfJKN3uCmcvtWnfIRs=;
 b=Dw/1G9H53DuPXD3khUO6euuX5mFzXvfXl0/Jrj1tOmgBjaH6UZ3/6d628obf6mAVTZTQ/xZ+FzaCzBE4wgsUnVnF5SEVNeTr9gSd6rUYULYXT1GRVFog9sorLxYc2Z1sN7TQUjWu4H6IzRXGOiHT3iv5mzszMq0jW+pUW6ysdAtijmPV6VtX8cRtpsv89KQlfOCmHvnucWdPz2CsnzEu1Om9uLd3lJbyfyaOu2ORQ2t4ofRL5Y/mIGm6ZOOXuSvkmWE3yqIQOFkMYwWYjfsIQhpEbtaL1gLMmPw4I90pcMyTXm9nTOxmDUNfjRtTo9DvtZOT65zGq6mfV8yFNbWzJA==
Received: from DM6PR21CA0030.namprd21.prod.outlook.com (2603:10b6:5:174::40)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 11:15:55 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::26) by DM6PR21CA0030.outlook.office365.com
 (2603:10b6:5:174::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.8 via Frontend Transport; Sun,
 25 May 2025 11:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 11:15:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 04:15:40 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 04:15:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 25
 May 2025 04:15:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 2/4] net/mlx5: HWS, make sure the uplink is the last destination
Date: Sun, 25 May 2025 14:15:08 +0300
Message-ID: <1748171710-1375837-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: ca98a4aa-ee0b-4825-12be-08dd9b7d848a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVDNh9pxVuNT4+cljuFxacy0aGH3ZP8HdomtnPnhjBmRBE2+snvc4asJKpGC?=
 =?us-ascii?Q?BGN7MqTGO93kMl0r0bLB68l8b5x6AEAN83XWaEG5U12JGEmfkiJtLv7pSYCC?=
 =?us-ascii?Q?XgE+JBA+UyEMrvVdFwyNfNyu8Qem9gfH3U7oE7tfTwOajiYCWxNLkRz+NKPI?=
 =?us-ascii?Q?RTDflZxIUkVxI8hDNALpm/LShIgv2OMM4vmNafSD4Z7qvs6sVBhah5Ii5OlF?=
 =?us-ascii?Q?0Ufa6xzDpRWjQma+/g2eENhXIcYt82Ntoj/7bl44wSnGjy7i7ZsssFEZxKqS?=
 =?us-ascii?Q?kyzc2tebWqF3e2ebU4Hy6g3A763BeEs9KnfBQMAaNaVfjq28jqHVo5eOvxf5?=
 =?us-ascii?Q?sZUXGBDlRo9/7twt9Fxem3NVQzcxubZc/ehntOeQfndz0Z7s7j+MA0B6A8+w?=
 =?us-ascii?Q?gKKrkqf2OdnMz5fjp3GnnjyiU9zIZUFf1+BcZ3TBLz/E81a1u7mX2OE43e6o?=
 =?us-ascii?Q?VsQ4hzc7s43vOGKbnhqAr2OD/Qa7Ed8HYNnaawhoMSs2LBi/sKMhWcxvgfjC?=
 =?us-ascii?Q?j6oFhg79p3f7seaurjITMIym6bFidlwRkakPNMmFchl10QL9QSDwTgoxqt+W?=
 =?us-ascii?Q?1I5UKn00WAolvhQ2q8cuET9oP/AZk2kuYkE+a+bzW2DtR6jNvTZBJ06tKgp0?=
 =?us-ascii?Q?RdaQbkyVI02jSptSKb4AKemqU3POP0oeclmWac8hDCi6Z1pbEQrDYMEnE3hT?=
 =?us-ascii?Q?Rr6NzihztUOmgwjPfYLy06bBfguN+7OJMXxf/tRMj4QctDExSNuer4zchqLM?=
 =?us-ascii?Q?PRd2FQwKLxDOSAgNxKDSE4vwE56oSSYUq89H5gIDIpoitZebAWk+Q1acbR24?=
 =?us-ascii?Q?mKBleECAp0AOG7ZNX0pK6wm79r6Y4+JW245fkMifXCrqAfQ8S0013FHAjl4i?=
 =?us-ascii?Q?f0yFJqrLXYRvxlFysF0DOl3FmIbGED63UlarH1wh133HKUk17HZmv38bJuqe?=
 =?us-ascii?Q?pcpk+uGdDEaNExaKJWF/cnAxBtgmEDXUaNk7e0R+/A0wiFj5ybmfJzvMm1VG?=
 =?us-ascii?Q?W2++0cfhX9WuNyN0zZeNmCUWw6pwTIbE5n5fYC1GxIW522ISWK5UOX9N9/pr?=
 =?us-ascii?Q?UR4BLe5CpRLhyqBLx+BvtFrjcsKbeW+HMQ9Ju5RstaizyJDFI+EPPrTsSwj6?=
 =?us-ascii?Q?3KvhCZJljYJyOpPC7Irn8aLq3I3MFOJNS8W8z/CsWcEICo3+Zhgj5Zc68LTv?=
 =?us-ascii?Q?J4qx9rbPiuNZ+7nvZLMObwDVBFRGzZb0vi41/33C2NZh1faLtLX6VKfyqETC?=
 =?us-ascii?Q?jDO7D0EkoC5j+iSDol450cr+VCFthmxvirSEH3atiYk7LOj7EIreA7+sBo41?=
 =?us-ascii?Q?iOuwJ0LddUe3rDZofq/xVpWI615ow2nDHzb4PtyPp5FR4/MR11LwaC5qp6AM?=
 =?us-ascii?Q?c543Z/yIJfu7FEKK3pC3cW/2yJBudvAelMUU8OPD6mI/aXi6S/YdtBCECGAD?=
 =?us-ascii?Q?KHRN8nYNyOtNx7X4N9MQxe92O+3rlQKOrNlwKU8dogaDSm6dSEyZUl5Fq3/T?=
 =?us-ascii?Q?yABQMYlk13IhZSGkAKfwan1/QQiCQWE2jXKU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 11:15:55.2334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca98a4aa-ee0b-4825-12be-08dd9b7d848a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

From: Vlad Dogaru <vdogaru@nvidia.com>

If a destination array action contains a wire destination, it has
to be the last one in the array. Replicate the check we had for
software steering to avoid a firmware error.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  | 19 ++++++++++++-------
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  3 +++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  1 +
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index fb62f3bc4bd4..592f3a2ede2e 100644
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
@@ -1429,6 +1426,14 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
 		}
 	}
 
+	if (last_dest_idx != -1) {
+		struct mlx5hws_cmd_set_fte_dest tmp;
+
+		tmp = dest_list[last_dest_idx];
+		dest_list[last_dest_idx] = dest_list[num_dest - 1];
+		dest_list[num_dest - 1] = tmp;
+	}
+
 	fte_attr.dests_num = num_dest;
 	fte_attr.dests = dest_list;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 9d1c0e4b224a..ab1a4c7f1813 100644
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
2.31.1


