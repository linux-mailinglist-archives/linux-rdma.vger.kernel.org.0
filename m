Return-Path: <linux-rdma+bounces-9251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F02A80D42
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AED4609DA
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759711DE883;
	Tue,  8 Apr 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7TpiK5D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63A1DE3A6;
	Tue,  8 Apr 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120962; cv=fail; b=tUlYRXURQnQ7aXZFI7GjBxoMq8OKWw1SybpypyLEenGuZF2mgQN75RI95meMtfm1jTquoQx+ylU024j9y/4DNPhxjphkrGvmnquwO2Wryz0pxWCVP9HDF7FQ3L7StFjlQxUaUfHBQNtZnbLKh29XrbOxe/pxXZ7lEIgG9h07/Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120962; c=relaxed/simple;
	bh=/Wuyq9rN6e0cLxyYPtEsXb8rpMVf17iPlvk2+vQBKwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcLpyAOrrKZ4MgNjBx2qd84nldLfFo1xKUWYH2ZLluMl4T+KVgjlR5e3HZHRfV8aVeCJNQmHArDeajz8T4tJWInyn9y3FTt9BRQ7MbtMvbNB91o4pgXeLIx0McnCA+EEZ3+8+3AC1QNLRY6SRA0ROBszyaBLpeod0WC7ODgcDXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W7TpiK5D; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8P44pftV/AH3kqHOpzqZhLXnHs6LEtsglfp5mRKyk5y3k4SkRHySKj4NaufkdOs6ZK+EsKQaLmcqFLSmUkHVZHpDEqMBLNLXr8zn01CHDvYPHNktNgENQ2eXuR0MLH25DIGrX9K9CxzRZloIGmxvmHSRJ6/g1m2bwr4NQ5zbKGlw2kpWF9JS77KrkDqzX6DCJh4varQVMZezLPJJrHHUYdrS5KJPImyA1Mxsqzpj6njiTE3nDlbGGXWlluBAiab9Tx2S/hCeRN0jDXYkm81yMia3g8nQ+dXO3RL7ucVSuM8nvbQXKGOstQgfnADTvg2DatDiv9Wp2yPl0j8n1nTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LX6qlE+76XbDYEOkvFVlk4HvfjrKkPjCc6luIJ3BYM=;
 b=j5JvoFyNABhED4OkSvcOUQl/FpQ5zaatcTHCEEb9jT4SQ9sYNHdrUmf5UuXJ025/EttPVYczdyRNV6eR6GZOP7knq3bgkzwdm3dl+IU3RVL62xmrkYNrzPz+AmUg/jm9hkRHj/EUheoPIWTNlvQsWWqu5GdhZmD8VPSGTWwzM59N4PTShwEyCVCNf9RE/dK9hBOqS4FPJZ5CM3IdKTUkAhmWEU6y3mDQQJ0jnkNQtUDZm0v2yOY3veVjeBocePAgmwxR2evjWo3dR536frYeQ1ymieghqPH28JfyJd1vsACYWHFEysEB+nop2IYrIZCDkrVQXJOuZAaS3PZ1xSoXyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LX6qlE+76XbDYEOkvFVlk4HvfjrKkPjCc6luIJ3BYM=;
 b=W7TpiK5DiS/JG9O2AEMOR5lswlXHsrkCj2csX8AtoAMsIURt6UJJGHewidg3o0nc9SFoJrHeR/NlRa9f4060gyVHkuH+bO+4p33sdcI+neBahVnRf9j9DsHpjXMS+/hTth4uW+KxfFSygV9QkHsGTU1ygY5v17UwGeM5RrKV/fmpEEa+DNes6WztvpmqCDEL+mIcKrFDJQUBb9Kf3Q9kWcCFVnK2KgqN8emsFyCRab1jv69T43z3SfTQESJxTmqGNszI4NkhoPWimGXA8DChD1TBJcL2TgNXOyczWbo8fZj2nHPikBymzrsa4756vAwaUPMSkAflp27pTtOVLaDQlA==
Received: from BN7PR06CA0059.namprd06.prod.outlook.com (2603:10b6:408:34::36)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:02:35 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::7b) by BN7PR06CA0059.outlook.office365.com
 (2603:10b6:408:34::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 14:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 03/12] net/mlx5: HWS, Make pool single resource
Date: Tue, 8 Apr 2025 17:00:47 +0300
Message-ID: <1744120856-341328-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 757f713d-d0b2-468a-f18f-08dd76a60389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y2uTLZipORQvcnaP4allLyXPRTIi9otuoJyhE4lrHcuIXuVgLILCM6YE6xZD?=
 =?us-ascii?Q?WtYPRIsVnFXHq+etU4jX+fZ52Pt38bJCjV0H5w9YtCBZO4RMTxi8dSpaaaPb?=
 =?us-ascii?Q?KdMbPJ9P5KfgcyrZohqSCePxcP9KhZRrV5rlJ6NSI4FsFlkzU0oZlaayvCQU?=
 =?us-ascii?Q?9Z9qbAOGJP8uf7fuEL3fwDNg+EzYsWfB+9TPT07Dez2EvPmSJySUn3Zo6mtf?=
 =?us-ascii?Q?EowwMOZxAbnSi1UmaP8HUG95GwtVONv3jNF7EvgC8dfbG5rl6+tgGQw5sQYk?=
 =?us-ascii?Q?Ui9RMrmGrjNQLX/Ax+gwHyzhr0Mhfd2lEgCgGm74zKwDuQDySnvaxmyBGnHu?=
 =?us-ascii?Q?WvXxoOFQwgnFsAoB49LDJy2T5UxeJzCX0OmrX1ZHwx6Bf8O3LQc8pq6OjfNo?=
 =?us-ascii?Q?qsxk4Z2DkXcXKAnIGCokufOk1nw39wJ/9B7QACYcj/pum80889PNp1xlpFSs?=
 =?us-ascii?Q?9cLkqyobqKvHTYxxGhZSX2p79SGMW7ngMVzXptpu2PimRlSGh0mSq4oUduDd?=
 =?us-ascii?Q?qE4/MJxgdpnCVuhAa/NVLBXqkInrJCfX3S2fQgCZkFVnclgkw+6hxHwCsTq5?=
 =?us-ascii?Q?aD4jJBAkavytPI3ywoHj9XQ2twyLdgWx26wr4IWMjSg9NgEu5MZVllBEwjSo?=
 =?us-ascii?Q?f5Bpm8xUK0Ih54fpfqbf+WbUe92zbgma1bGZzfI9zXcpSSJoUhezkqRtA2af?=
 =?us-ascii?Q?EymWMADRiDTiDFxscOpHebsZ47Y7jO+RXBkvA0Kz1gKa/9UOy3uktKPgP9/i?=
 =?us-ascii?Q?fy8Cx3LMqrybMHGAcmfj2zkwQewxEgMgekiXm+3r4Ow164ylr7CdB37UwaID?=
 =?us-ascii?Q?zto2s9yF9r7OpEywX6PGUZarwDPVxJkj0+nvDURT3TOMh3tbUbsY3LCLeHyk?=
 =?us-ascii?Q?9Tz0t4mNGLuXTulmUavxX8Zh9wPAEcqlpR6ewq8v9tY/5WotqrJK1Wsnc00Y?=
 =?us-ascii?Q?ulyrEfKE8aL/xLjLDKp/RettW9TtSoM42AW+ZjlypaorODGE9voDrQ9bHxYT?=
 =?us-ascii?Q?UHcrchNL4WblJ3z/AGmEJ2kyRSf+heluBf7gh/qx2tC6bQOpLSb6GLS+t8wd?=
 =?us-ascii?Q?UtgHWa1l0kJ4WXBlu/RDaC6tWq+KMrgu4Q6XOLBn+vvAxm2ljRgZfV5Z71n3?=
 =?us-ascii?Q?QySpmwRVQ9Unn7wBIIEzFzWVPxx/QK3x14/s8XkxGS0e9n0TyVEjSk1bOFFG?=
 =?us-ascii?Q?2u1K7sH5bTfT8JtBAbfpZYiA0rpdd8H/dnsfvIWefOQ7Fb74OwT+LwG9pJTK?=
 =?us-ascii?Q?k7wayUKUkbG1JGsU17EiR0BWPwlTce4ofaqd6fpoIHnPgouo2KioRvsEel3N?=
 =?us-ascii?Q?CeYmtK/Vhy5x3sfxVRFklasT2xtEmDcNXs0x3wfAHdjESoMhzufJzEaInucS?=
 =?us-ascii?Q?NK3T19k0zQwfH8U7pZB0tOYeCD/JpO5+fqiWsEmrj90wqD2bXp2T833lZBv6?=
 =?us-ascii?Q?8rhXlZ5iJT+u1klcHoFkewf4QB22/4M5eRii6RYeeNU2j6Ed8ZF6Q9VV97EZ?=
 =?us-ascii?Q?ZxBhQSMgATO+z4I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:35.0624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757f713d-d0b2-468a-f18f-08dd76a60389
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617

From: Vlad Dogaru <vdogaru@nvidia.com>

The pool implementation claimed to support multiple resources, but this
does not really make sense in context. Callers always allocate a single
STC or STE chunk of exactly the size provided.

The code that handled multiple resources was unused (and likely buggy)
due to the combination of flags passed by callers.

Simplify the pool by having it handle a single resource. As a result of
this simplification, chunks no longer contain a resource offset (there
is now only one resource per pool), and the get_base_id functions no
longer take a chunk parameter.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  |  27 ++-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  22 +--
 .../mellanox/mlx5/core/steering/hws/matcher.c |  10 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    | 182 ++++++------------
 .../mellanox/mlx5/core/steering/hws/pool.h    |  28 +--
 5 files changed, 91 insertions(+), 178 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index b5332c54d4fb..781ba8c4f733 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -238,6 +238,7 @@ hws_action_fixup_stc_attr(struct mlx5hws_context *ctx,
 			  enum mlx5hws_table_type table_type,
 			  bool is_mirror)
 {
+	struct mlx5hws_pool *pool;
 	bool use_fixup = false;
 	u32 fw_tbl_type;
 	u32 base_id;
@@ -253,13 +254,11 @@ hws_action_fixup_stc_attr(struct mlx5hws_context *ctx,
 			use_fixup = true;
 			break;
 		}
+		pool = stc_attr->ste_table.ste_pool;
 		if (!is_mirror)
-			base_id = mlx5hws_pool_chunk_get_base_id(stc_attr->ste_table.ste_pool,
-								 &stc_attr->ste_table.ste);
+			base_id = mlx5hws_pool_get_base_id(pool);
 		else
-			base_id =
-				mlx5hws_pool_chunk_get_base_mirror_id(stc_attr->ste_table.ste_pool,
-								      &stc_attr->ste_table.ste);
+			base_id = mlx5hws_pool_get_base_mirror_id(pool);
 
 		*fixup_stc_attr = *stc_attr;
 		fixup_stc_attr->ste_table.ste_obj_id = base_id;
@@ -337,7 +336,7 @@ __must_hold(&ctx->ctrl_lock)
 	if (!mlx5hws_context_cap_dynamic_reparse(ctx))
 		stc_attr->reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
 
-	obj_0_id = mlx5hws_pool_chunk_get_base_id(stc_pool, stc);
+	obj_0_id = mlx5hws_pool_get_base_id(stc_pool);
 
 	/* According to table/action limitation change the stc_attr */
 	use_fixup = hws_action_fixup_stc_attr(ctx, stc_attr, &fixup_stc_attr, table_type, false);
@@ -353,7 +352,7 @@ __must_hold(&ctx->ctrl_lock)
 	if (table_type == MLX5HWS_TABLE_TYPE_FDB) {
 		u32 obj_1_id;
 
-		obj_1_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, stc);
+		obj_1_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 
 		use_fixup = hws_action_fixup_stc_attr(ctx, stc_attr,
 						      &fixup_stc_attr,
@@ -393,11 +392,11 @@ __must_hold(&ctx->ctrl_lock)
 	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_DROP;
 	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
 	stc_attr.stc_offset = stc->offset;
-	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, stc);
+	obj_id = mlx5hws_pool_get_base_id(stc_pool);
 	mlx5hws_cmd_stc_modify(ctx->mdev, obj_id, &stc_attr);
 
 	if (table_type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, stc);
+		obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 		mlx5hws_cmd_stc_modify(ctx->mdev, obj_id, &stc_attr);
 	}
 
@@ -1581,7 +1580,6 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 					 u32 miss_ft_id)
 {
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
-	struct mlx5hws_action_default_stc *default_stc;
 	struct mlx5hws_matcher_action_ste *table_ste;
 	struct mlx5hws_pool_attr pool_attr = {0};
 	struct mlx5hws_pool *ste_pool, *stc_pool;
@@ -1629,7 +1627,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	rtc_attr.fw_gen_wqe = true;
 	rtc_attr.is_scnd_range = true;
 
-	obj_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+	obj_id = mlx5hws_pool_get_base_id(ste_pool);
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
@@ -1639,8 +1637,7 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
 	stc_pool = ctx->stc_pool;
-	default_stc = ctx->common_res.default_stc;
-	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, &default_stc->default_hit);
+	obj_id = mlx5hws_pool_get_base_id(stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_0_id);
@@ -1650,11 +1647,11 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	}
 
 	/* Create mirror RTC */
-	obj_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+	obj_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 	rtc_attr.ste_base = obj_id;
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(MLX5HWS_TABLE_TYPE_FDB, true);
 
-	obj_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, &default_stc->default_hit);
+	obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_1_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 696275fd0ce2..3491408c5d84 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -118,7 +118,6 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 {
 	enum mlx5hws_table_type tbl_type = matcher->tbl->type;
 	struct mlx5hws_cmd_ft_query_attr ft_attr = {0};
-	struct mlx5hws_pool_chunk *ste;
 	struct mlx5hws_pool *ste_pool;
 	u64 icm_addr_0 = 0;
 	u64 icm_addr_1 = 0;
@@ -134,12 +133,11 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->end_ft_id,
 		   matcher->col_matcher ? HWS_PTR_TO_ID(matcher->col_matcher) : 0);
 
-	ste = &matcher->match_ste.ste;
 	ste_pool = matcher->match_ste.pool;
 	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
 		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 	}
 
 	seq_printf(f, ",%d,%d,%d,%d",
@@ -148,12 +146,11 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->match_ste.rtc_1_id,
 		   (int)ste_1_id);
 
-	ste = &matcher->action_ste.ste;
 	ste_pool = matcher->action_ste.pool;
 	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
 		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 		else
 			ste_1_id = -1;
 	} else {
@@ -387,14 +384,17 @@ static int hws_debug_dump_context_stc(struct seq_file *f, struct mlx5hws_context
 	if (!stc_pool)
 		return 0;
 
-	if (stc_pool->resource[0]) {
-		ret = hws_debug_dump_context_stc_resource(f, ctx, stc_pool->resource[0]);
+	if (stc_pool->resource) {
+		ret = hws_debug_dump_context_stc_resource(f, ctx,
+							  stc_pool->resource);
 		if (ret)
 			return ret;
 	}
 
-	if (stc_pool->mirror_resource[0]) {
-		ret = hws_debug_dump_context_stc_resource(f, ctx, stc_pool->mirror_resource[0]);
+	if (stc_pool->mirror_resource) {
+		struct mlx5hws_pool_resource *res = stc_pool->mirror_resource;
+
+		ret = hws_debug_dump_context_stc_resource(f, ctx, res);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 37a4497048a6..59b14db427b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -223,7 +223,6 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
 	struct mlx5hws_match_template *mt = matcher->mt;
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
-	struct mlx5hws_action_default_stc *default_stc;
 	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
 	struct mlx5hws_pool *ste_pool, *stc_pool;
@@ -305,7 +304,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		return -EINVAL;
 	}
 
-	obj_id = mlx5hws_pool_chunk_get_base_id(ste_pool, ste);
+	obj_id = mlx5hws_pool_get_base_id(ste_pool);
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
@@ -316,8 +315,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 
 	/* STC is a single resource (obj_id), use any STC for the ID */
 	stc_pool = ctx->stc_pool;
-	default_stc = ctx->common_res.default_stc;
-	obj_id = mlx5hws_pool_chunk_get_base_id(stc_pool, &default_stc->default_hit);
+	obj_id = mlx5hws_pool_get_base_id(stc_pool);
 	rtc_attr.stc_base = obj_id;
 
 	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_0_id);
@@ -328,11 +326,11 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_chunk_get_base_mirror_id(ste_pool, ste);
+		obj_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
 		rtc_attr.ste_base = obj_id;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
-		obj_id = mlx5hws_pool_chunk_get_base_mirror_id(stc_pool, &default_stc->default_hit);
+		obj_id = mlx5hws_pool_get_base_mirror_id(stc_pool);
 		rtc_attr.stc_base = obj_id;
 		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, rtc_type, true);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 35ed9bee06a6..0de03e17624c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -20,15 +20,14 @@ static void hws_pool_free_one_resource(struct mlx5hws_pool_resource *resource)
 	kfree(resource);
 }
 
-static void hws_pool_resource_free(struct mlx5hws_pool *pool,
-				   int resource_idx)
+static void hws_pool_resource_free(struct mlx5hws_pool *pool)
 {
-	hws_pool_free_one_resource(pool->resource[resource_idx]);
-	pool->resource[resource_idx] = NULL;
+	hws_pool_free_one_resource(pool->resource);
+	pool->resource = NULL;
 
 	if (pool->tbl_type == MLX5HWS_TABLE_TYPE_FDB) {
-		hws_pool_free_one_resource(pool->mirror_resource[resource_idx]);
-		pool->mirror_resource[resource_idx] = NULL;
+		hws_pool_free_one_resource(pool->mirror_resource);
+		pool->mirror_resource = NULL;
 	}
 }
 
@@ -78,7 +77,7 @@ hws_pool_create_one_resource(struct mlx5hws_pool *pool, u32 log_range,
 }
 
 static int
-hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range, int idx)
+hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range)
 {
 	struct mlx5hws_pool_resource *resource;
 	u32 fw_ft_type, opt_log_range;
@@ -91,7 +90,7 @@ hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range, int idx)
 		return -EINVAL;
 	}
 
-	pool->resource[idx] = resource;
+	pool->resource = resource;
 
 	if (pool->tbl_type == MLX5HWS_TABLE_TYPE_FDB) {
 		struct mlx5hws_pool_resource *mirror_resource;
@@ -102,10 +101,10 @@ hws_pool_resource_alloc(struct mlx5hws_pool *pool, u32 log_range, int idx)
 		if (!mirror_resource) {
 			mlx5hws_err(pool->ctx, "Failed allocating mirrored resource\n");
 			hws_pool_free_one_resource(resource);
-			pool->resource[idx] = NULL;
+			pool->resource = NULL;
 			return -EINVAL;
 		}
-		pool->mirror_resource[idx] = mirror_resource;
+		pool->mirror_resource = mirror_resource;
 	}
 
 	return 0;
@@ -129,9 +128,9 @@ static void hws_pool_buddy_db_put_chunk(struct mlx5hws_pool *pool,
 {
 	struct mlx5hws_buddy_mem *buddy;
 
-	buddy = pool->db.buddy_manager->buddies[chunk->resource_idx];
+	buddy = pool->db.buddy;
 	if (!buddy) {
-		mlx5hws_err(pool->ctx, "No such buddy (%d)\n", chunk->resource_idx);
+		mlx5hws_err(pool->ctx, "Bad buddy state\n");
 		return;
 	}
 
@@ -139,86 +138,50 @@ static void hws_pool_buddy_db_put_chunk(struct mlx5hws_pool *pool,
 }
 
 static struct mlx5hws_buddy_mem *
-hws_pool_buddy_get_next_buddy(struct mlx5hws_pool *pool, int idx,
-			      u32 order, bool *is_new_buddy)
+hws_pool_buddy_get_buddy(struct mlx5hws_pool *pool, u32 order)
 {
 	static struct mlx5hws_buddy_mem *buddy;
 	u32 new_buddy_size;
 
-	buddy = pool->db.buddy_manager->buddies[idx];
+	buddy = pool->db.buddy;
 	if (buddy)
 		return buddy;
 
 	new_buddy_size = max(pool->alloc_log_sz, order);
-	*is_new_buddy = true;
 	buddy = mlx5hws_buddy_create(new_buddy_size);
 	if (!buddy) {
-		mlx5hws_err(pool->ctx, "Failed to create buddy order: %d index: %d\n",
-			    new_buddy_size, idx);
+		mlx5hws_err(pool->ctx, "Failed to create buddy order: %d\n",
+			    new_buddy_size);
 		return NULL;
 	}
 
-	if (hws_pool_resource_alloc(pool, new_buddy_size, idx) != 0) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d index: %d\n",
-			    pool->type, new_buddy_size, idx);
+	if (hws_pool_resource_alloc(pool, new_buddy_size) != 0) {
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
+			    pool->type, new_buddy_size);
 		mlx5hws_buddy_cleanup(buddy);
 		return NULL;
 	}
 
-	pool->db.buddy_manager->buddies[idx] = buddy;
+	pool->db.buddy = buddy;
 
 	return buddy;
 }
 
 static int hws_pool_buddy_get_mem_chunk(struct mlx5hws_pool *pool,
 					int order,
-					u32 *buddy_idx,
 					int *seg)
 {
 	struct mlx5hws_buddy_mem *buddy;
-	bool new_mem = false;
-	int ret = 0;
-	int i;
-
-	*seg = -1;
-
-	/* Find the next free place from the buddy array */
-	while (*seg < 0) {
-		for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-			buddy = hws_pool_buddy_get_next_buddy(pool, i,
-							      order,
-							      &new_mem);
-			if (!buddy) {
-				ret = -ENOMEM;
-				goto out;
-			}
-
-			*seg = mlx5hws_buddy_alloc_mem(buddy, order);
-			if (*seg >= 0)
-				goto found;
-
-			if (pool->flags & MLX5HWS_POOL_FLAGS_ONE_RESOURCE) {
-				mlx5hws_err(pool->ctx,
-					    "Fail to allocate seg for one resource pool\n");
-				ret = -ENOMEM;
-				goto out;
-			}
-
-			if (new_mem) {
-				/* We have new memory pool, should be place for us */
-				mlx5hws_err(pool->ctx,
-					    "No memory for order: %d with buddy no: %d\n",
-					    order, i);
-				ret = -ENOMEM;
-				goto out;
-			}
-		}
-	}
 
-found:
-	*buddy_idx = i;
-out:
-	return ret;
+	buddy = hws_pool_buddy_get_buddy(pool, order);
+	if (!buddy)
+		return -ENOMEM;
+
+	*seg = mlx5hws_buddy_alloc_mem(buddy, order);
+	if (*seg >= 0)
+		return 0;
+
+	return -ENOMEM;
 }
 
 static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
@@ -226,9 +189,7 @@ static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
 {
 	int ret = 0;
 
-	/* Go over the buddies and find next free slot */
 	ret = hws_pool_buddy_get_mem_chunk(pool, chunk->order,
-					   &chunk->resource_idx,
 					   &chunk->offset);
 	if (ret)
 		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
@@ -240,33 +201,21 @@ static int hws_pool_buddy_db_get_chunk(struct mlx5hws_pool *pool,
 static void hws_pool_buddy_db_uninit(struct mlx5hws_pool *pool)
 {
 	struct mlx5hws_buddy_mem *buddy;
-	int i;
-
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-		buddy = pool->db.buddy_manager->buddies[i];
-		if (buddy) {
-			mlx5hws_buddy_cleanup(buddy);
-			kfree(buddy);
-			pool->db.buddy_manager->buddies[i] = NULL;
-		}
-	}
 
-	kfree(pool->db.buddy_manager);
+	buddy = pool->db.buddy;
+	if (buddy) {
+		mlx5hws_buddy_cleanup(buddy);
+		kfree(buddy);
+		pool->db.buddy = NULL;
+	}
 }
 
 static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool, u32 log_range)
 {
-	pool->db.buddy_manager = kzalloc(sizeof(*pool->db.buddy_manager), GFP_KERNEL);
-	if (!pool->db.buddy_manager)
-		return -ENOMEM;
-
 	if (pool->flags & MLX5HWS_POOL_FLAGS_ALLOC_MEM_ON_CREATE) {
-		bool new_buddy;
-
-		if (!hws_pool_buddy_get_next_buddy(pool, 0, log_range, &new_buddy)) {
+		if (!hws_pool_buddy_get_buddy(pool, log_range)) {
 			mlx5hws_err(pool->ctx,
 				    "Failed allocating memory on create log_sz: %d\n", log_range);
-			kfree(pool->db.buddy_manager);
 			return -ENOMEM;
 		}
 	}
@@ -278,14 +227,13 @@ static int hws_pool_buddy_db_init(struct mlx5hws_pool *pool, u32 log_range)
 	return 0;
 }
 
-static int hws_pool_create_resource_on_index(struct mlx5hws_pool *pool,
-					     u32 alloc_size, int idx)
+static int hws_pool_create_resource(struct mlx5hws_pool *pool, u32 alloc_size)
 {
-	int ret = hws_pool_resource_alloc(pool, alloc_size, idx);
+	int ret = hws_pool_resource_alloc(pool, alloc_size);
 
 	if (ret) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d index: %d\n",
-			    pool->type, alloc_size, idx);
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
+			    pool->type, alloc_size);
 		return ret;
 	}
 
@@ -319,7 +267,7 @@ hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order)
 		elem->log_size = alloc_size - order;
 	}
 
-	if (hws_pool_create_resource_on_index(pool, alloc_size, 0)) {
+	if (hws_pool_create_resource(pool, alloc_size)) {
 		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
 			    pool->type, alloc_size);
 		goto free_db;
@@ -355,7 +303,7 @@ static int hws_pool_element_find_seg(struct mlx5hws_pool_elements *elem, int *se
 
 static int
 hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
-				       u32 *idx, int *seg)
+				       int *seg)
 {
 	struct mlx5hws_pool_elements *elem;
 
@@ -370,7 +318,6 @@ hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
 		return -ENOMEM;
 	}
 
-	*idx = 0;
 	elem->num_of_elements++;
 	return 0;
 
@@ -379,21 +326,17 @@ hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
 	return -ENOMEM;
 }
 
-static int
-hws_pool_general_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
-				       u32 *idx, int *seg)
+static int hws_pool_general_element_get_mem_chunk(struct mlx5hws_pool *pool,
+						  u32 order, int *seg)
 {
-	int ret, i;
-
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-		if (!pool->resource[i]) {
-			ret = hws_pool_create_resource_on_index(pool, order, i);
-			if (ret)
-				goto err_no_res;
-			*idx = i;
-			*seg = 0; /* One memory slot in that element */
-			return 0;
-		}
+	int ret;
+
+	if (!pool->resource) {
+		ret = hws_pool_create_resource(pool, order);
+		if (ret)
+			goto err_no_res;
+		*seg = 0; /* One memory slot in that element */
+		return 0;
 	}
 
 	mlx5hws_err(pool->ctx, "No more resources (last request order: %d)\n", order);
@@ -409,9 +352,7 @@ static int hws_pool_general_element_db_get_chunk(struct mlx5hws_pool *pool,
 {
 	int ret;
 
-	/* Go over all memory elements and find/allocate free slot */
 	ret = hws_pool_general_element_get_mem_chunk(pool, chunk->order,
-						     &chunk->resource_idx,
 						     &chunk->offset);
 	if (ret)
 		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
@@ -423,11 +364,8 @@ static int hws_pool_general_element_db_get_chunk(struct mlx5hws_pool *pool,
 static void hws_pool_general_element_db_put_chunk(struct mlx5hws_pool *pool,
 						  struct mlx5hws_pool_chunk *chunk)
 {
-	if (unlikely(!pool->resource[chunk->resource_idx]))
-		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
-
 	if (pool->flags & MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE)
-		hws_pool_resource_free(pool, chunk->resource_idx);
+		hws_pool_resource_free(pool);
 }
 
 static void hws_pool_general_element_db_uninit(struct mlx5hws_pool *pool)
@@ -455,7 +393,7 @@ static void
 hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
 				       struct mlx5hws_pool_elements *elem)
 {
-	hws_pool_resource_free(pool, 0);
+	hws_pool_resource_free(pool);
 	bitmap_free(elem->bitmap);
 	kfree(elem);
 	pool->db.element = NULL;
@@ -466,12 +404,9 @@ static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
 {
 	struct mlx5hws_pool_elements *elem;
 
-	if (unlikely(chunk->resource_idx))
-		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
-
 	elem = pool->db.element;
 	if (!elem) {
-		mlx5hws_err(pool->ctx, "No such element (%d)\n", chunk->resource_idx);
+		mlx5hws_err(pool->ctx, "Pool element was not allocated\n");
 		return;
 	}
 
@@ -489,9 +424,7 @@ static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
 {
 	int ret = 0;
 
-	/* Go over all memory elements and find/allocate free slot */
 	ret = hws_pool_onesize_element_get_mem_chunk(pool, chunk->order,
-						     &chunk->resource_idx,
 						     &chunk->offset);
 	if (ret)
 		mlx5hws_err(pool->ctx, "Failed to get free slot for chunk with order: %d\n",
@@ -614,13 +547,10 @@ mlx5hws_pool_create(struct mlx5hws_context *ctx, struct mlx5hws_pool_attr *pool_
 
 int mlx5hws_pool_destroy(struct mlx5hws_pool *pool)
 {
-	int i;
-
 	mutex_destroy(&pool->lock);
 
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++)
-		if (pool->resource[i])
-			hws_pool_resource_free(pool, i);
+	if (pool->resource)
+		hws_pool_resource_free(pool);
 
 	hws_pool_db_unint(pool);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index f4258f83fdbf..112a61cd2997 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -6,16 +6,12 @@
 
 #define MLX5HWS_POOL_STC_LOG_SZ 15
 
-#define MLX5HWS_POOL_RESOURCE_ARR_SZ 100
-
 enum mlx5hws_pool_type {
 	MLX5HWS_POOL_TYPE_STE,
 	MLX5HWS_POOL_TYPE_STC,
 };
 
 struct mlx5hws_pool_chunk {
-	u32 resource_idx;
-	/* Internal offset, relative to base index */
 	int offset;
 	int order;
 };
@@ -72,14 +68,10 @@ enum mlx5hws_db_type {
 	MLX5HWS_POOL_DB_TYPE_GENERAL_SIZE,
 	/* One resource only, all the elements are with same one size */
 	MLX5HWS_POOL_DB_TYPE_ONE_SIZE_RESOURCE,
-	/* Many resources, the memory allocated with buddy mechanism */
+	/* Entries are managed using a buddy mechanism. */
 	MLX5HWS_POOL_DB_TYPE_BUDDY,
 };
 
-struct mlx5hws_buddy_manager {
-	struct mlx5hws_buddy_mem *buddies[MLX5HWS_POOL_RESOURCE_ARR_SZ];
-};
-
 struct mlx5hws_pool_elements {
 	u32 num_of_elements;
 	unsigned long *bitmap;
@@ -91,7 +83,7 @@ struct mlx5hws_pool_db {
 	enum mlx5hws_db_type type;
 	union {
 		struct mlx5hws_pool_elements *element;
-		struct mlx5hws_buddy_manager *buddy_manager;
+		struct mlx5hws_buddy_mem *buddy;
 	};
 };
 
@@ -109,8 +101,8 @@ struct mlx5hws_pool {
 	size_t alloc_log_sz;
 	enum mlx5hws_table_type tbl_type;
 	enum mlx5hws_pool_optimize opt_type;
-	struct mlx5hws_pool_resource *resource[MLX5HWS_POOL_RESOURCE_ARR_SZ];
-	struct mlx5hws_pool_resource *mirror_resource[MLX5HWS_POOL_RESOURCE_ARR_SZ];
+	struct mlx5hws_pool_resource *resource;
+	struct mlx5hws_pool_resource *mirror_resource;
 	/* DB */
 	struct mlx5hws_pool_db db;
 	/* Functions */
@@ -131,17 +123,13 @@ int mlx5hws_pool_chunk_alloc(struct mlx5hws_pool *pool,
 void mlx5hws_pool_chunk_free(struct mlx5hws_pool *pool,
 			     struct mlx5hws_pool_chunk *chunk);
 
-static inline u32
-mlx5hws_pool_chunk_get_base_id(struct mlx5hws_pool *pool,
-			       struct mlx5hws_pool_chunk *chunk)
+static inline u32 mlx5hws_pool_get_base_id(struct mlx5hws_pool *pool)
 {
-	return pool->resource[chunk->resource_idx]->base_id;
+	return pool->resource->base_id;
 }
 
-static inline u32
-mlx5hws_pool_chunk_get_base_mirror_id(struct mlx5hws_pool *pool,
-				      struct mlx5hws_pool_chunk *chunk)
+static inline u32 mlx5hws_pool_get_base_mirror_id(struct mlx5hws_pool *pool)
 {
-	return pool->mirror_resource[chunk->resource_idx]->base_id;
+	return pool->mirror_resource->base_id;
 }
 #endif /* MLX5HWS_POOL_H_ */
-- 
2.31.1


