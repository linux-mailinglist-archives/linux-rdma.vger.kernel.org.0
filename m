Return-Path: <linux-rdma+bounces-13550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82EB8F3D1
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC013BB940
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010892F60AD;
	Mon, 22 Sep 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7AnFGDD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4712F5308;
	Mon, 22 Sep 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525140; cv=fail; b=r8GqiM4owRHAyQLzTtJDyZLd3ijOXQ9wpYDyxPIOKPzC+nYbCL8SN9KqPHNES02ltnvuv8b8skMVPYFXjWdm0ubDQStBPzXBKYzHkPfCXvctRUE6u5Xwul2zT7JgB+VFcPUZ03YVi3d7llKaKdKGiGeZMElfpvhv6Rxb8avRmZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525140; c=relaxed/simple;
	bh=DjqeXYD0Ql6XnjL4OSfjhgmezSXnbgpOvq8qqMEJac4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKj7+hdHQPd2doagXqOmG6yJq+3OdoVPfidm3zlMNsJkdrj3sDoR6ednuhWNc5pXcvhG7hX3y0iSkb5CaEnngvFV58ybgLmCV6UxSQIiAhwgcIbf+1Vu+GrW2vasoZ9oM3SdmH+/iihBtqe1/Vli9N3mjnUyHPFrf5PE3Fo5md4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7AnFGDD; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olWFzyjc4d5aleXlmWp7hQeGDy9gzHOuSWpXMMQYDFE0dlkXbiJkIq049vCAYU0yDkv+M76lBJFbzzbGEvAl3cdQKbDUjRxCe0BbZaWUmdVHd8weFneS90eyPB4ykPq7Jlf6kTBMqgiee4uJmWb+KP+eNCUjqk8TbE3CdZq7Jb5IcuurfxQS6GXcswi1zHsJwhnq0pS3qVf/gAnh/Z2Hgd076+2Fw5ytgkHGQJ+nafjOqSHINSZa+0KITdgfF8cW0g8Lvcekg1w4A43IpZZiz6k01lYScbowqs0B8HjUJbGwb0ZuA2Jf0c82rxwFmFfpycIHIZSNYjcSuq5hhAV4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkWeFDyTYSkfNszYB3LaUA99bVmrxZwxHTiwW7R0L9U=;
 b=i1RTzCM17If88WLkzuSltTikoPxpZcnf1MqUTiAfS2meo9DW+ad7q5hBrniSj7rNRkfIsryKJornK+TtJ2NuE4EXIuL/tqQSevcK0vdd9k6AveKd3nuUGHCb/KydWq6Eb8ddfmsOwB0WyZHeA+Nh837CZA04VVCXuTlO3DwN7S647T5cdHmxzp8409rWG5gsHNnz2rKU1tR+3h684O6h5xZVeXD58FlH7zvA+tSfxsNFzcsRRnUd3jolg0t9065JXCqcDZRyMORQhRnFSiMwhs3zHbg5syBCuMIz6RUnC+bpQEBN8J4rkcStgCKQLPnkt1/OgjYu9jgUxlnn1XtguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkWeFDyTYSkfNszYB3LaUA99bVmrxZwxHTiwW7R0L9U=;
 b=l7AnFGDDAjZxHJ+U6jlAkxmUBWoM0rl+k/Zt5xqWwf2fBHLwnY2OLoDiBxskL0tFk1Q3yGMO7/ypL/e4+SaAv6VtGepiEIh59qs5XOUMWKFTgSSclFacJyx9rvdwLgf6vTGSv/7fAdZKyLGAUF6MQNVa+aYW/A5PYwGk+N9bD4X/OTWxbibVJOx/V/JAw4ExRmK6RDT32Z6i0J6jE3PwdRyD1fZLUn1Ox3oKsVP8nluwlHOGIFmhpg3tvfQfY7aCUmtBDbxsoMOQaWcYtF/tF5pBjV+FFCfpOD9BixB4dHNI/Rxb1M0hRPbLfx4FQazEyR81893ntHzwrEq7VHmXUg==
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 07:12:12 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::51) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 07:12:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 07:12:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:11:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 00:11:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 22
 Sep 2025 00:11:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5: HWS, ignore flow level for multi-dest table
Date: Mon, 22 Sep 2025 10:11:33 +0300
Message-ID: <1758525094-816583-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
References: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 40392d2a-2642-4c7c-2c48-08ddf9a75a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?smZKD1GvIqUpvNX0hEh9xe4wtjMYPZ2u5278zzw4xzgThS9rQZv8e0nRBNK6?=
 =?us-ascii?Q?dWfbfWChAahGWGMPmkAJ2J+8sapShioDKHiMXFU8aROjKnqGNLnUNm2Ok8ze?=
 =?us-ascii?Q?q7SWc+UA1Q2CjpVmdsXeD6PgXC2k7d6+3Dt6dbDaV1+fgjH77MbalH/sfnUO?=
 =?us-ascii?Q?U+Q0TU3h3e+g3X387AqEaUgEV6gzSnFVN2FaXcDuwexC1c34XHRP2RHSWTS5?=
 =?us-ascii?Q?5Z9wEh9PZz6BlxY2qhEXm5UKNMKdZiq9YWOXnXRtlOOsojHPXzST2Mdxg+MM?=
 =?us-ascii?Q?SIgLTAcyJ/D3bPvHPMIROSccVW7sSOs1PjGsmvK8yAQiR4kBLhKgKZ87Fn+9?=
 =?us-ascii?Q?Zb4rcmz1XkaIsFdE+cvcBY4PZPdL8TBWIeUSe2i6G6tWEBD4jdGzg0VdFfwK?=
 =?us-ascii?Q?9G5SXwd1yuxXcJwBjN1EEmFVw5MWV6HZR4zGA0RuUY6R9+2qi8u5b5dQ4b5j?=
 =?us-ascii?Q?U8dwqd9BFCetmdE6ezNsShilobbtecvUpu3NluxvHtykiHBwiq7Oa/OLgHTb?=
 =?us-ascii?Q?88mrHk++SBHdCIEZCpxotKNYBmx7j4Wx7SatPJZpTRALL/YvsUdnsjWnfEvG?=
 =?us-ascii?Q?Iypifi4nhqHEvacIIDjW+keckMsJHFnfL/ecL3hwKiAavBCKLqvEFTv3k82W?=
 =?us-ascii?Q?/VjkL8CyyuUe4cUmEojzjDxOYei85A5Ln8bOmvvVUETGfmSM7hLSVbaBmkAl?=
 =?us-ascii?Q?kemMC9mRXezOYNXTf33mkdpn6L0HTD2Zc2r4oW4XrhED8VlhCps5yno6uz3d?=
 =?us-ascii?Q?DV+CFI7ECrsbJGR98ekHpKOP4KCxJEjwG815stmnpJ8fINrCAIjAtqZNgY+Y?=
 =?us-ascii?Q?ahLqn3+kvRvHub4o+tZOQHuw69zy0+W2D8l+0GeQgUU1/mUWjEqRLxb661cl?=
 =?us-ascii?Q?iNWRGXAhtjFdPuyt1xSJ4BRmZaJoLgM8jJIGrGMCX4LW1nzLR5Uxeq9vT1fO?=
 =?us-ascii?Q?8NgNzQacAQpWRY8hOfqklt4EOIRbC3Ix8L8I7utPnQ6pYrqtolAfmZYhp12c?=
 =?us-ascii?Q?EL/c/zl9sw7LD2AP8fvsqkd68HDVrS45VmRcLbpKh8xGkGjMehl9wKXR/8O6?=
 =?us-ascii?Q?3zmL4bEvK9VCrwg1qCgWNcmpQ9akrWhrk/n521pQn900Cb43O9YVSzwoAHQF?=
 =?us-ascii?Q?9G6RnK6TkVA/FKQQgJZ1I5YUMcWb5qM5zpDp6sTcewBpLmpvgpSTm0kwwYTn?=
 =?us-ascii?Q?g0QBMi6ltajuPVjKo4ao16ynIOlvML/yoC0fS8GHbTjNNJAF1EtyDDGaULEa?=
 =?us-ascii?Q?4u0Ydll/GN2SWUyWjp2xKJj7Fnz5B18xW/BfKhE/O+IQCu7vX4zNd/BCGvvl?=
 =?us-ascii?Q?pjDsyofCG6tBAOR65pp1SYug0frpYT6JrC6cgiRAnGeCNFjb+nxfYW45Sm7L?=
 =?us-ascii?Q?5Mpy33suDE38+3iKev2wvYqwf8G34pag+PrAoA56YdZJCksvJ/+s96i2Po6n?=
 =?us-ascii?Q?jtBzAx4qqTwEKB1zX36yduq++8g29ysG1lsqcYdtn9pnsRaodnrMjk63/6X2?=
 =?us-ascii?Q?XW18KJ/JnHBnpenwGE8q9v6+E2nxVrvZ/cHr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 07:12:12.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40392d2a-2642-4c7c-2c48-08ddf9a75a38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

When HWS creates multi-dest FW table and adds rules to
forward to other tables, ignore the flow level enforcement
in FW, because HWS is responsible for table levels.

This fixes the following error:

  mlx5_core 0000:08:00.0: mlx5_cmd_out_err:818:(pid 192306):
     SET_FLOW_TABLE_ENTRY(0x936) op_mod(0x0) failed,
     status bad parameter(0x3), syndrome (0x6ae84c), err(-22)

Fixes: 504e536d9010 ("net/mlx5: HWS, added actions handling")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/action.c |  4 ++--
 .../ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c | 11 +++--------
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h         |  3 +--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 6b36a4a7d895..fe56b59e24c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1360,7 +1360,7 @@ mlx5hws_action_create_modify_header(struct mlx5hws_context *ctx,
 struct mlx5hws_action *
 mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				 struct mlx5hws_action_dest_attr *dests,
-				 bool ignore_flow_level, u32 flags)
+				 u32 flags)
 {
 	struct mlx5hws_cmd_set_fte_dest *dest_list = NULL;
 	struct mlx5hws_cmd_ft_create_attr ft_attr = {0};
@@ -1397,7 +1397,7 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 			dest_list[i].destination_id = dests[i].dest->dest_obj.obj_id;
 			fte_attr.action_flags |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-			fte_attr.ignore_flow_level = ignore_flow_level;
+			fte_attr.ignore_flow_level = 1;
 			if (dests[i].is_wire_ft)
 				last_dest_idx = i;
 			break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 131e74b2b774..6a4c4cccd643 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -572,12 +572,12 @@ static void mlx5_fs_put_dest_action_sampler(struct mlx5_fs_hws_context *fs_ctx,
 static struct mlx5hws_action *
 mlx5_fs_create_action_dest_array(struct mlx5hws_context *ctx,
 				 struct mlx5hws_action_dest_attr *dests,
-				 u32 num_of_dests, bool ignore_flow_level)
+				 u32 num_of_dests)
 {
 	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
 
 	return mlx5hws_action_create_dest_array(ctx, num_of_dests, dests,
-						ignore_flow_level, flags);
+						flags);
 }
 
 static struct mlx5hws_action *
@@ -1014,19 +1014,14 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 		}
 		(*ractions)[num_actions++].action = dest_actions->dest;
 	} else if (num_dest_actions > 1) {
-		bool ignore_flow_level;
-
 		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 		    num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
 			err = -EOPNOTSUPP;
 			goto free_actions;
 		}
-		ignore_flow_level =
-			!!(fte_action->flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
 		tmp_action =
 			mlx5_fs_create_action_dest_array(ctx, dest_actions,
-							 num_dest_actions,
-							 ignore_flow_level);
+							 num_dest_actions);
 		if (!tmp_action) {
 			err = -EOPNOTSUPP;
 			goto free_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 2498ceff2060..1ad7a50d938b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -735,7 +735,6 @@ mlx5hws_action_create_push_vlan(struct mlx5hws_context *ctx, u32 flags);
  * @num_dest: The number of dests attributes.
  * @dests: The destination array. Each contains a destination action and can
  *	   have additional actions.
- * @ignore_flow_level: Whether to turn on 'ignore_flow_level' for this dest.
  * @flags: Action creation flags (enum mlx5hws_action_flags).
  *
  * Return: pointer to mlx5hws_action on success NULL otherwise.
@@ -743,7 +742,7 @@ mlx5hws_action_create_push_vlan(struct mlx5hws_context *ctx, u32 flags);
 struct mlx5hws_action *
 mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				 struct mlx5hws_action_dest_attr *dests,
-				 bool ignore_flow_level, u32 flags);
+				 u32 flags);
 
 /**
  * mlx5hws_action_create_insert_header - Create insert header action.
-- 
2.31.1


