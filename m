Return-Path: <linux-rdma+bounces-10452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4A6ABE320
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858D87A521E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F2D281362;
	Tue, 20 May 2025 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z/r8ribL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5944628003E;
	Tue, 20 May 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766877; cv=fail; b=Ulo1uRlu/3I5PUoJX/VLmrhyCWyInfIjAK57hOAX2B7+gJ5U8yOGMFCXprtYVodSYkt2iVxg54Qd0rbN7IE2I6Tuyw+Xr9+7OCkGGc70ctKEiDkouX4J38zI1Cg4Lj41ozez8MOyS7h3WvG1VUzjpEbkSKcT+jnQqDuO1L189jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766877; c=relaxed/simple;
	bh=BWpXcDTQItsZkUVyJeiXXI3eLb9mB4fASNm42L3mU+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2PoRKze4CMchKjKxW3mxHT/ey781KF3+CC7LmkkMcl3b2O/HxSixfuUJlclxjVnrEYMapjPZByEfegwqCNN1wdpaLpcCjCx7ZhDBn1jd22op4qShg/2VxAu+IBt71FJTkfo2RNcWgcrb7j66U3yxwgJcFY2Bfx2zRUy847CPew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z/r8ribL; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq9jzp+HhZTyX8y47xN/HCfa1RiRan28wVBkd6NmkEnDLiVoA0anFXhVuFTSqpfCcVG+R/IsdJNzHXtiIcNWssqB6VON6FqsVby+v1z/N199a9aP18KbRRFyHxl4d8EaaHUUyaDcUujSfSnF/P38Ty6i7s5qArsE9cmV993h/5qKceipXExzjutPW/vdjA6pwvU4ZvFbOwvTj0O6W0i265T1kyrlaQD5MicKP3cbhpHcuZKw7nj6UPDox1zNppeG7ROetHvXfLgLs31oYg8YcsZ+jrye76ikhewLYdlaHhztPxsOaV09Fe96AYXEHw6YI560bIPd42NqKpQZbK8EHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjctCQl9SZWptk3yHaN+eibVOLW6QAdmnlIgvRBNgXo=;
 b=JM1ONlNx2Pl/jZ4UWXQ19Z7NyJKXxKPdEb53YArpKBJz5XLzsI8QI5s4edsQ7331pI5t4NIzzqLTTEuifQvBd8BLMeo95Si4fzbxyzvYfm/Rj1yGAfywSilXoIvM8VCUEVGRM4SeQyvHfVxfWPVcuKCLAGiUi5MFzXH1bt6gPVQFMVtxOADaaKCP5FT+V2IxXgT20jsktg36gFSyJW4D1Ij0JBn0QiAioTLdGYoVOA7aDXmlNjAPyeBy2PXjwFvWtHkzhlrIPO/HrxgBdyQDEfq2RAwgZLzZyJdS10yonVmzobhqmFPt19O+OHUfWbaP9uWikOEJP2JcZ54Ek6xpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjctCQl9SZWptk3yHaN+eibVOLW6QAdmnlIgvRBNgXo=;
 b=Z/r8ribLCTcYESgifrl8za5SoRaC+QhzsgicMjNV4vlSdFvnOjcDrk0Rpk+sLFLe9M5Gg+zYS4+z7I/cvi4pekcSnAx9+6rXHQm4kghi3uGqggG76CPcJKaRarSS8+nIKWuSOklG45V2BVeeeSqb+Gj4BE23HFi4YEnZbNyvs9ci5DjcT3l6CCEJG8xF1J/X/v8ouMONKNL9X6ws4yCDy08VN0T0kR8znMGzA4acBK+e/OBfISDnJyb9njEuTJpq5vt9s51M2ZhTZ4fANnxe+DsM3VUPltPxrh/Rr8Bbukxwmc2L2VN8vIj421y10qyLYQYp7CM36gVs6d+vWACPnQ==
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by DS7PR12MB9044.namprd12.prod.outlook.com (2603:10b6:8:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 18:47:48 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::57) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Tue,
 20 May 2025 18:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 18:47:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 May
 2025 11:47:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 20 May
 2025 11:47:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 20
 May 2025 11:47:14 -0700
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
Subject: [PATCH net-next 4/4] net/mlx5: HWS, handle modify header actions dependency
Date: Tue, 20 May 2025 21:46:42 +0300
Message-ID: <1747766802-958178-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
References: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 958b6a6a-e0c3-4591-ce9e-08dd97ced0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOCzmUjj3VICkEa6ziX8erOi8fDa6DAuWLHJbm8IZAAiIUP0fmKpCnu74OCb?=
 =?us-ascii?Q?Xub7L/2kxKrIuPonTk+5/x/4Vt3e7MbJqUxoXTG6xz7XR4Dy+A8+hKZHVpwu?=
 =?us-ascii?Q?0z61gWVSbYVzk6KPFQjN+q20WEn2DpES1Ntk7d2mOEnC2R+70m06NUJQpdwK?=
 =?us-ascii?Q?ZM8USENPs9FIMXiXFPoLJqCgjd54MWw0o0S84fEHx58FvHun2t5YQ+n4H1D3?=
 =?us-ascii?Q?3JMQJXLlv7HWMcTmZBRsjcCBhU5TWZpFICZVNA+CA0nrS8BLXACpnrzxAUkv?=
 =?us-ascii?Q?ufU7wPAITEHaAOYVhy25/2BlAqdUG+IzsOQ/io9ulckRcG2B/YDn8xhnycc+?=
 =?us-ascii?Q?Cm0zDahJtCVROrgzpYvX6wuRNL6CkvX6xTOJD6jElsXdvd+KFthA8soW8OnF?=
 =?us-ascii?Q?xQWL9mxnMXEVKHxbN44nqGONZAvpXRUNCFJAi1qbHGAsNb450lFa8kx7jqgY?=
 =?us-ascii?Q?2848Z3lgwaFyeW5OQLzujWVpFbSyZKl0UHMzv2oeoIbHgHJbxRvxQptZQxLB?=
 =?us-ascii?Q?46nWkkPg2N9GubTYFkMwBz5tzA4hV0dZxOfkAqtwnxLsqjVEXjUA0wVyqVo7?=
 =?us-ascii?Q?+OzvBeBdafWvRaM76w1Es2Q93CrXVPAGzVyZw/NfajIudaOcQSzFJQxhjoJs?=
 =?us-ascii?Q?MxWobqB1D0iF492sA7NIXgZVYU1WD/WRg9JsY8c9lizSfytmkyysFzoiPLxF?=
 =?us-ascii?Q?pp8Tjue7LmlxXeHnkIiTtCaUl2EHdsvfqfQo/keiHM75a8d6H486wb0CJCkL?=
 =?us-ascii?Q?l34/gQMtBTNNOZHQyrGUKg+jbnPcJQvPyFRRmzSePOVHLNSlsjnocjiYkT0z?=
 =?us-ascii?Q?W5WJPQ/zGi8894sGekpISe0uxlcA7y4zJSmHJXk5l3pQkuqfQP02wx6xY1Ax?=
 =?us-ascii?Q?wN48SpAQyxnfrv46eX4you32Py+MrU6cIRXuUIzXS32VzIC3RlUuy1ZihKdW?=
 =?us-ascii?Q?qyxM0lL3Yz1JJ+GetAXYabVajh1IL9NNjGdbmVi1Sa0830ZAYLVWPV+OTBez?=
 =?us-ascii?Q?54svZmNn5hO6aKt10aLeYOfl8LOpgRzRAtMcz7vA+AGxOES6WShHfbmQmTbV?=
 =?us-ascii?Q?DVYcDyG5uPW+VFPYy2kf/KLHHuFTyx63DxNqXNfJPbUa56lr1AhyNx6C66Ml?=
 =?us-ascii?Q?KGTvEPKtutJTFvPwPkRkY29i44+xrsrunl4nde4AUjRfU8mF/qz75Gck8c9G?=
 =?us-ascii?Q?AQ2R1sET0NJs5axtebESdL6uW+2JS9AnuVsm+PYPeYtQ8JlqdBTggFAZ/VA6?=
 =?us-ascii?Q?cEdw17uXPfovNxY/KYiwdsaV68PnjExVxKnLtu82BxEQxnKt1p9IdwyDegG1?=
 =?us-ascii?Q?Jk9vRfwmmvLpHWeaEKfonfShKezr7+p6/WBxZdkF64Jy+IKWhhFSLYboNPCG?=
 =?us-ascii?Q?dkl3FNM5UvqfZag+f9ItthyhdjKrSvaqRvGiATp4bLSnHx3ZM3Nwb9Cajpo/?=
 =?us-ascii?Q?qDiCJGitFYERaQO/VHviI96ZP1rcoikCM0+9Fuu6dKbDtrU2ihKrgWEdHyVI?=
 =?us-ascii?Q?1yMM3jZgfNVACu0AxSG2FjEYV3a8DAoJ2woJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 18:47:47.8409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958b6a6a-e0c3-4591-ce9e-08dd97ced0e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Having adjacent accelerated modify header actions (so-called
pattern-argument actions) may result in inconsistent outcome.
These inconsistencies can take the form of writes to the same
field or a read coupled with a write to the same field. The
solution is to detect such dependencies and insert nops between
the offending actions.

The existing implementation had a few issues, which pretty much
required a complete rewrite of the code that handles these
dependencies.

In the new implementation we're doing the following:

* Checking any two adjacent actions for conflicts (not just
  odd-even pairs).
* Marking 'set' and 'add' action fields as destination, rather
  than source, for the purposes of checking for conflicts.
* Checking all types of actions ('add', 'set', 'copy') for
  dependencies.
* Managing offsets of the args in the buffer - copy the action
  args to the right place in the buffer.
* Checking that after inserting nops we're still within the number
  of supported actions - return an error otherwise.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  | 21 ++++--
 .../mellanox/mlx5/core/steering/hws/pat_arg.c | 74 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/pat_arg.h |  6 +-
 3 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 64d115feef2c..fb62f3bc4bd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1190,14 +1190,15 @@ hws_action_create_modify_header_hws(struct mlx5hws_action *action,
 				    struct mlx5hws_action_mh_pattern *pattern,
 				    u32 log_bulk_size)
 {
+	u16 num_actions, max_mh_actions = 0, hw_max_actions;
 	struct mlx5hws_context *ctx = action->ctx;
-	u16 num_actions, max_mh_actions = 0;
 	int i, ret, size_in_bytes;
 	u32 pat_id, arg_id = 0;
 	__be64 *new_pattern;
 	size_t pat_max_sz;
 
 	pat_max_sz = MLX5HWS_ARG_CHUNK_SIZE_MAX * MLX5HWS_ARG_DATA_SIZE;
+	hw_max_actions = pat_max_sz / MLX5HWS_MODIFY_ACTION_SIZE;
 	size_in_bytes = pat_max_sz * sizeof(__be64);
 	new_pattern = kcalloc(num_of_patterns, size_in_bytes, GFP_KERNEL);
 	if (!new_pattern)
@@ -1211,10 +1212,14 @@ hws_action_create_modify_header_hws(struct mlx5hws_action *action,
 
 		cur_num_actions = pattern[i].sz / MLX5HWS_MODIFY_ACTION_SIZE;
 
-		mlx5hws_pat_calc_nop(pattern[i].data, cur_num_actions,
-				     pat_max_sz / MLX5HWS_MODIFY_ACTION_SIZE,
-				     &new_num_actions, &nop_locations,
-				     &new_pattern[i * pat_max_sz]);
+		ret = mlx5hws_pat_calc_nop(pattern[i].data, cur_num_actions,
+					   hw_max_actions, &new_num_actions,
+					   &nop_locations,
+					   &new_pattern[i * pat_max_sz]);
+		if (ret) {
+			mlx5hws_err(ctx, "Too many actions after nop insertion\n");
+			goto free_new_pat;
+		}
 
 		action[i].modify_header.nop_locations = nop_locations;
 		action[i].modify_header.num_of_actions = new_num_actions;
@@ -2116,10 +2121,12 @@ static void hws_action_modify_write(struct mlx5hws_send_engine *queue,
 		if (unlikely(!new_arg_data))
 			return;
 
-		for (i = 0, j = 0; i < num_of_actions; i++, j++) {
-			memcpy(&new_arg_data[j], arg_data, MLX5HWS_MODIFY_ACTION_SIZE);
+		for (i = 0, j = 0; j < num_of_actions; i++, j++) {
 			if (BIT(i) & nop_locations)
 				j++;
+			memcpy(&new_arg_data[j * MLX5HWS_MODIFY_ACTION_SIZE],
+			       &arg_data[i * MLX5HWS_MODIFY_ACTION_SIZE],
+			       MLX5HWS_MODIFY_ACTION_SIZE);
 		}
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index 78de19c074a7..51e4c551e0ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -490,8 +490,8 @@ hws_action_modify_get_target_fields(u8 action_type, __be64 *pattern,
 	switch (action_type) {
 	case MLX5_ACTION_TYPE_SET:
 	case MLX5_ACTION_TYPE_ADD:
-		*src_field = MLX5_GET(set_action_in, pattern, field);
-		*dst_field = INVALID_FIELD;
+		*src_field = INVALID_FIELD;
+		*dst_field = MLX5_GET(set_action_in, pattern, field);
 		break;
 	case MLX5_ACTION_TYPE_COPY:
 		*src_field = MLX5_GET(copy_action_in, pattern, src_field);
@@ -522,57 +522,59 @@ bool mlx5hws_pat_verify_actions(struct mlx5hws_context *ctx, __be64 pattern[], s
 	return true;
 }
 
-void mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
-			  size_t max_actions, size_t *new_size,
-			  u32 *nop_locations, __be64 *new_pat)
+int mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
+			 size_t max_actions, size_t *new_size,
+			 u32 *nop_locations, __be64 *new_pat)
 {
-	u16 prev_src_field = 0, prev_dst_field = 0;
+	u16 prev_src_field = INVALID_FIELD, prev_dst_field = INVALID_FIELD;
 	u16 src_field, dst_field;
 	u8 action_type;
+	bool dependent;
 	size_t i, j;
 
 	*new_size = num_actions;
 	*nop_locations = 0;
 
 	if (num_actions == 1)
-		return;
+		return 0;
 
 	for (i = 0, j = 0; i < num_actions; i++, j++) {
-		action_type = MLX5_GET(set_action_in, &pattern[i], action_type);
+		if (j >= max_actions)
+			return -EINVAL;
 
+		action_type = MLX5_GET(set_action_in, &pattern[i], action_type);
 		hws_action_modify_get_target_fields(action_type, &pattern[i],
 						    &src_field, &dst_field);
-		if (i % 2) {
-			if (action_type == MLX5_ACTION_TYPE_COPY &&
-			    (prev_src_field == src_field ||
-			     prev_dst_field == dst_field)) {
-				/* need Nop */
-				*new_size += 1;
-				*nop_locations |= BIT(i);
-				memset(&new_pat[j], 0, MLX5HWS_MODIFY_ACTION_SIZE);
-				MLX5_SET(set_action_in, &new_pat[j],
-					 action_type,
-					 MLX5_MODIFICATION_TYPE_NOP);
-				j++;
-			} else if (prev_src_field == src_field) {
-				/* need Nop */
-				*new_size += 1;
-				*nop_locations |= BIT(i);
-				MLX5_SET(set_action_in, &new_pat[j],
-					 action_type,
-					 MLX5_MODIFICATION_TYPE_NOP);
-				j++;
-			}
-		}
-		memcpy(&new_pat[j], &pattern[i], MLX5HWS_MODIFY_ACTION_SIZE);
-		/* check if no more space */
-		if (j > max_actions) {
-			*new_size = num_actions;
-			*nop_locations = 0;
-			return;
+
+		/* For every action, look at it and the previous one. The two
+		 * actions are dependent if:
+		 */
+		dependent =
+			(i > 0) &&
+			/* At least one of the actions is a write and */
+			(dst_field != INVALID_FIELD ||
+			 prev_dst_field != INVALID_FIELD) &&
+			/* One reads from the other's source */
+			(dst_field == prev_src_field ||
+			 src_field == prev_dst_field ||
+			 /* Or both write to the same destination */
+			 dst_field == prev_dst_field);
+
+		if (dependent) {
+			*new_size += 1;
+			*nop_locations |= BIT(i);
+			memset(&new_pat[j], 0, MLX5HWS_MODIFY_ACTION_SIZE);
+			MLX5_SET(set_action_in, &new_pat[j], action_type,
+				 MLX5_MODIFICATION_TYPE_NOP);
+			j++;
+			if (j >= max_actions)
+				return -EINVAL;
 		}
 
+		memcpy(&new_pat[j], &pattern[i], MLX5HWS_MODIFY_ACTION_SIZE);
 		prev_src_field = src_field;
 		prev_dst_field = dst_field;
 	}
+
+	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
index 91bd2572a341..7fbd8dc7aa18 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
@@ -96,7 +96,7 @@ int mlx5hws_arg_write_inline_arg_data(struct mlx5hws_context *ctx,
 				      u8 *arg_data,
 				      size_t data_size);
 
-void mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
-			  size_t max_actions, size_t *new_size,
-			  u32 *nop_locations, __be64 *new_pat);
+int mlx5hws_pat_calc_nop(__be64 *pattern, size_t num_actions,
+			 size_t max_actions, size_t *new_size,
+			 u32 *nop_locations, __be64 *new_pat);
 #endif /* MLX5HWS_PAT_ARG_H_ */
-- 
2.31.1


