Return-Path: <linux-rdma+bounces-11522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D5AE3106
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5153B09A9
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7790202984;
	Sun, 22 Jun 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/gaYwO5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C021153598;
	Sun, 22 Jun 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612984; cv=fail; b=GYSfmDGiFIrAStmIQNKeqNr1plZ/ipPxkUzShjbrHQ9DW6Tz6OUBp18CmP8dsY+h9CHhIiEs/KlXHjDmv7D46AOSYTB9eW9+z3jikCXRexCFli8WqUiT3/Zou0gZ9lGfagulyBP1QMMRy29e7G+XCoYpA8lpTgU75yFFllOjtY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612984; c=relaxed/simple;
	bh=DibSIbI8HLsQymoapnXudBUCniAhkrKZ8pM5Z0z3sMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxqIne40pbvTbQ5HEul6HiOw6pVkUS82MRcRjSSH4OB1+NjIbCCQ6QgZCtHzzzfMAc/vHqmTVLTGYUVvxTfDRyPmdBS5ElbP64pVFYEEfw+KSgTQB1mNkGPpyWN0XiGzLxX39/4UdxnDnGnFoFPHG98ujFtmgULVZyDZpw690xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/gaYwO5; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV2AsXY8ZkvjynSsaX4BDu54ogXH6mnzMA9Tdy+jol8xKtIGOThq1bk7DCyycuWJ9yIItDHligyhOdiSjdjgqUbOur/IfyT4aoMoaK1BblsRRYla3xM2mGVKL+0YkhY4KQ2iQLGSjt1wDffgxpMdjozKdkbnfy0NQ/TqvckKvKCqTsOE4PpRKiSj1Lf3j+H7Hc+F7dO2B2ZhkdrendInQDZHryJ/oQlpPSiJV1L8/FyTHLXda8mrGxQ5zH38p75b+mxIrMs/KGkTSQL+lHwqCA2bRuluqi7GBQpbzY89bFqW7QZUIbSYr3cDaZ7QlGRht5N8fDMbV8p7mvpk490N+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGSuM9ON+IMEMr8dQbykz3O3D+cru0yBQ/8i28o6LXA=;
 b=HsqzRGhEoXfUq/WfkZiWtgE5Kc4nkaRTpnyix4kPXhtdLFdlNz48SRbBjAtUnBIwfDPViQoMvqujVVa0TIA0hOnu8L6W1eGIanU4XQTbzRyYPJ2n+g9douLPEkWHjj5V+LuPCCTCFsWCMx9YZA+q3skNB+VBECWSgm8a6/bxQHBuwRxbzsIedJqhcB0QT2WnOSvf8xMfcnwBtOSBhS9ISfWgE8i8E92jAeZoPIw/16P6yGf9WvjF7qNtrSf+CFNkj9lXqc36V+Cob3QLWd1JU7HZUCXblXC9i263Vq3Cm5mQUYbrnT3MAGiHTUmvvjbYLaJmCodwnyn4tprsT6UjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGSuM9ON+IMEMr8dQbykz3O3D+cru0yBQ/8i28o6LXA=;
 b=a/gaYwO5BQvfJyM7iWGmsyVqU1AlGK8f4038MoPpL3Wi9fKTQbx6xYXRNVrF8LHAHsO7NSbsvmULwBfiFXbwj6rHslbdzGaqwsWqr9TIBueZa/41+VK81Y5Bsix5+ZONun8i6naFry8FFWDilC1nEK14TBzbjNun7uFRRbS7dXPtZQya9jBAp45HYp1mi/TCGRvS6Pv3DS7FcxE2gaHqKpzlmz/Zo0lc5MKJw6v70wEozx+zvEFrecHfij/B1iEmflETBIfGMXZi2QTHCJ8jtCmif+A+nrjw1LVtzTURCQ3v6HgXZ9e8A7IijJQrdsoUcoGipDOYGC9cpJ6+S5CDGw==
Received: from BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) by
 BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Sun, 22 Jun
 2025 17:22:58 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::82) by BL0PR01CA0018.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:22:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:22:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:22:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:22:48 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule skip logic
Date: Sun, 22 Jun 2025 20:22:21 +0300
Message-ID: <20250622172226.4174-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250622172226.4174-1-mbloch@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: f232f77b-2f14-4230-a345-08ddb1b16eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wMy1mMxkHVYceIR5Q9ivjDRMoSIDffrPA/8+tvDqn5LNB4MjAJ428hAR+uUv?=
 =?us-ascii?Q?/thA7P1PI71juqs6B0pzjhvZzIEZMw0aISZu7cY6r1ZEkCsXoZYcuvPcIb9A?=
 =?us-ascii?Q?e/dTU8C10i9twyQ+1vJMIJemwDzpuyzptTlyqiyyEOQLkLt8URgRIMHdFPBM?=
 =?us-ascii?Q?0/a96qHb3hvdHz5Rebrj5R0a3WMoiiFMUuHxj8b/oAUARsDkR+AyG79bR3uk?=
 =?us-ascii?Q?z2MrK6n+A7CWSSW0NjqrdWUBkWyDenfWMP0C50Jf1Pa3U3tp3wkxOetMXe4/?=
 =?us-ascii?Q?vsk91q9R9W1u0G5hPV/ho5FEO8Vm8h+MYTYdE0DxcBqMvgUYKazvI75ZSMRl?=
 =?us-ascii?Q?2N/QpoSeC3dcWQ41vF6wI93r6N1bjRf6EAGettWnGblLLmigdGOqyKDjLv9X?=
 =?us-ascii?Q?K4YFfj18O8fLfO0z04S9hojc9+nFvW4caCtUOb/zmXdmCNOStIWmPnTyTjHG?=
 =?us-ascii?Q?cVTLlR0xm97ENkMsY7UGhKKzGe8BhULpVlFv6TJ2CnXEn5mfUtXnL3CuHakY?=
 =?us-ascii?Q?J+r+FgIjJj6EEuVjuQEAIF9EpbtEv75B1Raa9n5hhHSjWVMIbCOnu7Oalwhi?=
 =?us-ascii?Q?q3Srts2JZ225Ry3sBRvY5IW8dcn7uPmWcdbp04xAakkXLARS1bmdz/W+vfY3?=
 =?us-ascii?Q?pLyHQ/pFC53ni8/7app/+q8qw2nEaTKC4qhwqbNOGJ1f1blnrS/GNF2yNzDl?=
 =?us-ascii?Q?HwMoUbw6kHHGLYvyshhKb1hGe5mbJqiqRFE5e0E2RRGdPTZpybkFANRKzzjU?=
 =?us-ascii?Q?88WHAobB2wQBPfCQro+b6rbYMxpoDy8QswK8aebxHR8fW1W+cX1sldGb1qSr?=
 =?us-ascii?Q?gke81GRwb82jCC9/IhcPATDU8564sZE8GzPDlkFRnEVeKmwbj/DYUgtCYmiB?=
 =?us-ascii?Q?lTYRyxAeKQ2Q2ZKY8pvjSn+kPVoldlmQCmUDTT3cT2WJSB9pZUje8OD1Vx/f?=
 =?us-ascii?Q?YHtYKsKSkycj7bItsvGktkZHW3f73XriqKB1Ddwl+roR9D1rifx8KHnd/Gwn?=
 =?us-ascii?Q?4e5d/+8CK6bGmL9MpJ11CkasgozEcRhWUmVstxIZAqVuNBAYXHExJ9/U+G2n?=
 =?us-ascii?Q?opl6yQI/d/aN9bnTbts0/TCFUqIT+R6eVKCYwugURA6m8qh4ejgch/hiKIh7?=
 =?us-ascii?Q?x47dhQG+fHZQFfMojj1TeazkgAtv3D9ejqnnXHp55ojJt+mPYMf3cs+H6k+O?=
 =?us-ascii?Q?x6iIjc7guFsOYrneGquKmR69GubFME/tugxYI9gqwmabHHjNwXhy7NeE/MJH?=
 =?us-ascii?Q?PKo+dV+zp3/V2iuTHEp6suVObBFut/4B4o6y4BD+OsZOGtxaBuxpN5JuOQiz?=
 =?us-ascii?Q?SonGBMStVrNi+wljnmqeETWqqeaR2k6OGzJGxM7GkuZ3IkTNyX1YHshOZblg?=
 =?us-ascii?Q?CTIP0gmU+3GmGdq13/xwkOsf3j9GhRWqHz5ZqnjR5ad2XFi2iIV9ijCKOoB5?=
 =?us-ascii?Q?+Z7OvR8q4/ww6lX8iGZPctQvg1Gp7nWjgnqn/qFwWBCtbuX69QuqQOadK9Uc?=
 =?us-ascii?Q?DfRpERKqWmfuy7hIodaVeUuBBZoq9HfelfI5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:22:57.9104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f232f77b-2f14-4230-a345-08ddb1b16eb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

From: Vlad Dogaru <vdogaru@nvidia.com>

The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
RX and TX rules individually, so export this function for future usage.

While we're in there, reduce nesting by adding a couple of early return
statements.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/rule.c    | 35 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/rule.h    |  3 ++
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 5342a4cc7194..0370b9b87d4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -3,10 +3,8 @@
 
 #include "internal.h"
 
-static void hws_rule_skip(struct mlx5hws_matcher *matcher,
-			  struct mlx5hws_match_template *mt,
-			  u32 flow_source,
-			  bool *skip_rx, bool *skip_tx)
+void mlx5hws_rule_skip(struct mlx5hws_matcher *matcher, u32 flow_source,
+		       bool *skip_rx, bool *skip_tx)
 {
 	/* By default FDB rules are added to both RX and TX */
 	*skip_rx = false;
@@ -14,20 +12,22 @@ static void hws_rule_skip(struct mlx5hws_matcher *matcher,
 
 	if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_LOCAL_VPORT) {
 		*skip_rx = true;
-	} else if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK) {
+		return;
+	}
+
+	if (flow_source == MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK) {
 		*skip_tx = true;
-	} else {
-		/* If no flow source was set for current rule,
-		 * check for flow source in matcher attributes.
-		 */
-		if (matcher->attr.optimize_flow_src) {
-			*skip_tx =
-				matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_WIRE;
-			*skip_rx =
-				matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_VPORT;
-			return;
-		}
+		return;
 	}
+
+	/* If no flow source was set for the rule, check for flow source in
+	 * matcher attributes.
+	 */
+	if (matcher->attr.optimize_flow_src == MLX5HWS_MATCHER_FLOW_SRC_WIRE)
+		*skip_tx = true;
+	else if (matcher->attr.optimize_flow_src ==
+		 MLX5HWS_MATCHER_FLOW_SRC_VPORT)
+		*skip_rx = true;
 }
 
 static void
@@ -66,7 +66,8 @@ static void hws_rule_init_dep_wqe(struct mlx5hws_send_ring_dep_wqe *dep_wqe,
 				attr->rule_idx : 0;
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		hws_rule_skip(matcher, mt, attr->flow_source, &skip_rx, &skip_tx);
+		mlx5hws_rule_skip(matcher, attr->flow_source, &skip_rx,
+				  &skip_tx);
 
 		if (!skip_rx) {
 			dep_wqe->rtc_0 = matcher->match_ste.rtc_0_id;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
index 1c47a9c11572..d0f082b8dbf5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
@@ -69,6 +69,9 @@ struct mlx5hws_rule {
 			   */
 };
 
+void mlx5hws_rule_skip(struct mlx5hws_matcher *matcher, u32 flow_source,
+		       bool *skip_rx, bool *skip_tx);
+
 void mlx5hws_rule_free_action_ste(struct mlx5hws_action_ste_chunk *action_ste);
 
 int mlx5hws_rule_move_hws_remove(struct mlx5hws_rule *rule,
-- 
2.34.1


