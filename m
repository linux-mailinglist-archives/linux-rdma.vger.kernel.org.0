Return-Path: <linux-rdma+bounces-11521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E6AE3108
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EB16FA55
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C31FF608;
	Sun, 22 Jun 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jS76fYyY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F31FE470;
	Sun, 22 Jun 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612983; cv=fail; b=Phx6BQ0Ncfg71T8GgICULA4UTFbBY2m+0VEJcj4VBTykZn28HcACvF7rH0bClRX6QUPXpOuk/yZ+QG/Eg5mlQYTU28l0owqsAAtVgFMTCQ+oZHYnwwxgVewde9XVA0obuCDx5F3zoa+7AyWl58o7PWM9D0oJSWhkQMuRcGlwAEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612983; c=relaxed/simple;
	bh=lOZl7RwozwK2ifQ7DZx9GSLF2fNVK3CHdTdp4q7qgTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMaO1aKv/BWxYvsdK54A+wE+aDSW6lG5MTIeq4qy++hZy32WvYfQDwo6XtJWI6wk22nlsx9+3apAmM5P9rmATCJ2OBOH1qcG6LSYWGPEZyTg2U7XUuBb3caTe+NrKR3a4P5IS48LNDVjcwsHTFHrrNv1buSPSPUTSHZpBXUz/70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jS76fYyY; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrvZsB5ni+bZAUfZSs6BsvozOalJAXXJbfVU6ApYhclNoxiFI0S2RYJ6SCUG2D8PGj9GV+H2stKaq2tfPsiaRSrXaAgj1aMwA/w7xnNfF1XTD8lY0qLdK/WxRYmc262Ck5CWcXHb27qygmA8iLe7DEJcmDMAxCjkhW3olgm/Fx10GdNpWx6B0lgUyb9PIitEG7E9OsycGcIXsRp/HYnzON8jHYwX0wNlxDIqGKaagEmHvtMsYhgR5vskTseY7956Bs5EianPwDjnXjm81N21zLgDka/SaPFv7x26aK5yDS+P5ZrlWgzwh7ajBLBYiLw2FKCZZnt/KHKpPho9jXMGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVt0N8r3F+maKEiZcu0TfT9wa8S8S02m2rs6mR+F1EI=;
 b=gnukV3gBeWdO95xRphH89xUHWH04F/+7vFm3HaBsxXlxdOoJMwDukRIBkCBnKhs//7Zrt2N4dyh9b+y9b5aOmR87rCH4DqoKhRuxa6VuTo17ARzGoAf1F8XLoJZWP007ZtEMW5PPUFpaLD8oZgFztybepxZeCrrRFzIzj0dU/E91fDxXCm3Zd3rv12FFjxj+ntrtRG3IDOn/ug0dIXjf5SnYDAfgaXZ1Uzvdey1G7h6TZsse0BSy0ZZWAaBnQSFab1bHyLuiGhScoDtzIZkxVLCeXoroYZoE8TX4OOve2I0IQmRHU/OWmGu+Wlf5qHrIhSZX4irfHAOTZFg2ZuKBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVt0N8r3F+maKEiZcu0TfT9wa8S8S02m2rs6mR+F1EI=;
 b=jS76fYyY0WvNSRcdC3uYOrV/4oHCCw4GHtFXF5ieUGIwQjwFi4YJCinan3mp1xcCUzAqqxW5KGnH70x58quno13JmMcK2HAUkooF+d/mjgdblQOwcLUZvVqfnhoC/i3a9tZhfG++/FmICLitmGwjlYEFtnzweExHDrgu6sKcTtId2CcPD9rXzRcVVUTUNZOfMTgP9ww1uqwNe95RCADZDFC9UpMjOQpHicRj8TKNlm083rhKsXOxXAhv4wVpGUcWmYOmmVTs4ScjHkkgIOfZWFR0vJJ1rSX/5O2WTgxRcQ5HKqgy2BqQ+e4YqmDayq3sAo0iUy0KkyiT7bGvMA8upQ==
Received: from SJ0PR03CA0130.namprd03.prod.outlook.com (2603:10b6:a03:33c::15)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sun, 22 Jun
 2025 17:22:58 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::29) by SJ0PR03CA0130.outlook.office365.com
 (2603:10b6:a03:33c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:22:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:22:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:22:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:22:52 -0700
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
Subject: [PATCH net-next v2 4/8] net/mlx5: HWS, Create STEs directly from matcher
Date: Sun, 22 Jun 2025 20:22:22 +0300
Message-ID: <20250622172226.4174-5-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 6901a427-dc8e-41bc-4918-08ddb1b16e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cDt90/gVPB77BuqRawwG8eTybPiCYWsrMCricib/pTKlgVIr6RymvGCMnLJl?=
 =?us-ascii?Q?IgnOYW9TC46NafgChqayidWCoXP3KN9jo0iPMUYQWKOPpDFt9XQ6XVqVF5/e?=
 =?us-ascii?Q?kweuXas4YuoCAY0o9ScWJbE4shNP+uruWnmZgLXiV0k4ezo45cd8B5GDIMRO?=
 =?us-ascii?Q?rB9ignNXK1XbOp2XnG7OesXezi7wirzbd+qtd6g2P1kgmA9j8r2J6tgJCHbr?=
 =?us-ascii?Q?loMwixhJ76qZRFQcEJfJE2hkEjBVHOlWVlIe2Z64xpYiaWq7RUA83GnkgnB7?=
 =?us-ascii?Q?mnb71ghlfu/1jYliCzXqLCRVe6tqcxpMeTFYvdVIwGodmkJfLCSutioEkXmW?=
 =?us-ascii?Q?o/vZV4KQ3w2ocR08TT25kkctx1a1duQhMPBJ44zucVuv/NtuRbFrtoag32Ua?=
 =?us-ascii?Q?ldazDVBTkOE4TAmPO/ME7cCo5sphDvAMyNwQAMEXp8D1uMqb0k8t9hM0BAfm?=
 =?us-ascii?Q?PqqVUwB0Jbn9Sxxmo555RWEqedhopDkxwzhVL9epZvyT3QmnFsIlVu51vlKF?=
 =?us-ascii?Q?7jwDC/NuJE1uel+KIoz98DaZPRO8eQXHynK6WBv+AikDsTKyv+5o8sMOio86?=
 =?us-ascii?Q?4cXwZrIuoYQS4kWfNHz1ZgmDzJcSnIC6fRuo4iWYaFv7y7+QQ481Hh6bP3YO?=
 =?us-ascii?Q?nqcJWmt2ALyqcM+i7uibSD+lL2HktqHSZocvQaVDaVUiCRU3W5wlM9Iw1HNa?=
 =?us-ascii?Q?leiXeeonHFVVkeUHhnUxVYNDpqjSbFgwKaNVdc2UT8MVJEqgFL6RWUJ236mh?=
 =?us-ascii?Q?+E9FmAYAcGhkagaeP1CTJLsk0TdhArWgDroQwAtSOQxWeoYV+7OTSIcZ7jhj?=
 =?us-ascii?Q?KdFYFmSDmfxMAGzMsHFsN+3egBU/+OeMd/eqrZ07gorcIQy3gb7yYbKC5NeT?=
 =?us-ascii?Q?7Cbbb97I/0cB2SgdqrihREstccQoE08BSWH+n25qLh9w1b4qChOWM5zkg1rW?=
 =?us-ascii?Q?w8GkbYl9QhbPz/Dp6sfeZr9Hkvbk5DbUkyado+dyBQqjOGk0hi4DRNmnlIyE?=
 =?us-ascii?Q?eJusnBkE0mL1o1Sr6gdlzBPPIhQLNlox+b0RldCc8D9I54m/c/stkNcFId2G?=
 =?us-ascii?Q?rhEMPhQ9JMfGs2/oF1oGreBjWZRXCh4HBwhAi+zl2M6ons5iJOTyWESLM6ma?=
 =?us-ascii?Q?XBH+rW9tATqoYDDm9lEEAIAt5kT9r+N43GqA+Ur6e0b1mZM623C7NjAbBJXy?=
 =?us-ascii?Q?LVgzaD6M2H2DtT+6E2vw1OYWiRJyVIX+TiHQjnLpo1byshgjkqzwoDFQlKSf?=
 =?us-ascii?Q?e8uP177UdktPEOmVX519As6bEO9zM404LwaFLUpnJeZURP2NeysXcUrLWDiv?=
 =?us-ascii?Q?gz/usW9yg2e74uTlqUz69DRn63G1BDsJxbsiHs4AdczHjjRVp+sZxMPR7Clw?=
 =?us-ascii?Q?fcUsBvUn016ZGUFThbSAIjtOvQLQELd68q1CcrKhhxwofxlSnzKPSvE3D9wu?=
 =?us-ascii?Q?9hbKVoNdSE/DL3MrezWTc08tXkhJViH4TlSaz6zMIgbzVjK4BrZ2EfPuyreI?=
 =?us-ascii?Q?Me++4KupTEWE76xrSynSrRytQEyZA8XTIXjO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:22:57.3996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6901a427-dc8e-41bc-4918-08ddb1b16e5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F

From: Vlad Dogaru <vdogaru@nvidia.com>

Matchers were using the pool abstraction solely as a convenience
to allocate two STE ranges. The pool's core functionality, that
of allocating individual items from the range, was unused.
Matchers rely either on the hardware to hash rules into a table,
or on a user-provided index.

Remove the STE pool from the matcher and allocate the STE ranges
manually instead.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/debug.c   | 10 +--
 .../mellanox/mlx5/core/steering/hws/matcher.c | 71 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  3 +-
 3 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 91568d6c1dac..f9b75aefcaa7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -118,7 +118,6 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 {
 	enum mlx5hws_table_type tbl_type = matcher->tbl->type;
 	struct mlx5hws_cmd_ft_query_attr ft_attr = {0};
-	struct mlx5hws_pool *ste_pool;
 	u64 icm_addr_0 = 0;
 	u64 icm_addr_1 = 0;
 	u32 ste_0_id = -1;
@@ -133,12 +132,9 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->end_ft_id,
 		   matcher->col_matcher ? HWS_PTR_TO_ID(matcher->col_matcher) : 0);
 
-	ste_pool = matcher->match_ste.pool;
-	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
-		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
-	}
+	ste_0_id = matcher->match_ste.ste_0_base;
+	if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
+		ste_1_id = matcher->match_ste.ste_1_base;
 
 	seq_printf(f, ",%d,%d,%d,%d",
 		   matcher->match_ste.rtc_0_id,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index ce28ee1c0e41..b0fcaf508e06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -507,10 +507,8 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 		}
 	}
 
-	obj_id = mlx5hws_pool_get_base_id(matcher->match_ste.pool);
-
 	rtc_attr.pd = ctx->pd_num;
-	rtc_attr.ste_base = obj_id;
+	rtc_attr.ste_base = matcher->match_ste.ste_0_base;
 	rtc_attr.reparse_mode = mlx5hws_context_get_reparse_mode(ctx);
 	rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, false);
 	hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, false);
@@ -527,9 +525,7 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_get_base_mirror_id(
-			matcher->match_ste.pool);
-		rtc_attr.ste_base = obj_id;
+		rtc_attr.ste_base = matcher->match_ste.ste_1_base;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
 		obj_id = mlx5hws_pool_get_base_mirror_id(ctx->stc_pool);
@@ -588,21 +584,6 @@ hws_matcher_check_attr_sz(struct mlx5hws_cmd_query_caps *caps,
 	return 0;
 }
 
-static void hws_matcher_set_pool_attr(struct mlx5hws_pool_attr *attr,
-				      struct mlx5hws_matcher *matcher)
-{
-	switch (matcher->attr.optimize_flow_src) {
-	case MLX5HWS_MATCHER_FLOW_SRC_VPORT:
-		attr->opt_type = MLX5HWS_POOL_OPTIMIZE_ORIG;
-		break;
-	case MLX5HWS_MATCHER_FLOW_SRC_WIRE:
-		attr->opt_type = MLX5HWS_POOL_OPTIMIZE_MIRROR;
-		break;
-	default:
-		break;
-	}
-}
-
 static int hws_matcher_check_and_process_at(struct mlx5hws_matcher *matcher,
 					    struct mlx5hws_action_template *at)
 {
@@ -683,8 +664,8 @@ static void hws_matcher_set_ip_version_match(struct mlx5hws_matcher *matcher)
 
 static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 {
+	struct mlx5hws_cmd_ste_create_attr ste_attr = {};
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
-	struct mlx5hws_pool_attr pool_attr = {0};
 	int ret;
 
 	/* Calculate match, range and hash definers */
@@ -699,22 +680,39 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 
 	hws_matcher_set_ip_version_match(matcher);
 
-	/* Create an STE pool per matcher*/
-	pool_attr.table_type = matcher->tbl->type;
-	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
-	pool_attr.alloc_log_sz = matcher->attr.table.sz_col_log +
-				 matcher->attr.table.sz_row_log;
-	hws_matcher_set_pool_attr(&pool_attr, matcher);
-
-	matcher->match_ste.pool = mlx5hws_pool_create(ctx, &pool_attr);
-	if (!matcher->match_ste.pool) {
-		mlx5hws_err(ctx, "Failed to allocate matcher STE pool\n");
-		ret = -EOPNOTSUPP;
+	/* Create an STE range each for RX and TX. */
+	ste_attr.table_type = FS_FT_FDB_RX;
+	ste_attr.log_obj_range =
+		matcher->attr.optimize_flow_src ==
+				MLX5HWS_MATCHER_FLOW_SRC_VPORT ?
+				0 : matcher->attr.table.sz_col_log +
+				    matcher->attr.table.sz_row_log;
+
+	ret = mlx5hws_cmd_ste_create(ctx->mdev, &ste_attr,
+				     &matcher->match_ste.ste_0_base);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed to allocate RX STE range (%d)\n", ret);
 		goto uninit_match_definer;
 	}
 
+	ste_attr.table_type = FS_FT_FDB_TX;
+	ste_attr.log_obj_range =
+		matcher->attr.optimize_flow_src ==
+				MLX5HWS_MATCHER_FLOW_SRC_WIRE ?
+				0 : matcher->attr.table.sz_col_log +
+				    matcher->attr.table.sz_row_log;
+
+	ret = mlx5hws_cmd_ste_create(ctx->mdev, &ste_attr,
+				     &matcher->match_ste.ste_1_base);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed to allocate TX STE range (%d)\n", ret);
+		goto destroy_rx_ste_range;
+	}
+
 	return 0;
 
+destroy_rx_ste_range:
+	mlx5hws_cmd_ste_destroy(ctx->mdev, matcher->match_ste.ste_0_base);
 uninit_match_definer:
 	if (!(matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION))
 		mlx5hws_definer_mt_uninit(ctx, matcher->mt);
@@ -723,9 +721,12 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 
 static void hws_matcher_unbind_mt(struct mlx5hws_matcher *matcher)
 {
-	mlx5hws_pool_destroy(matcher->match_ste.pool);
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+
+	mlx5hws_cmd_ste_destroy(ctx->mdev, matcher->match_ste.ste_1_base);
+	mlx5hws_cmd_ste_destroy(ctx->mdev, matcher->match_ste.ste_0_base);
 	if (!(matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION))
-		mlx5hws_definer_mt_uninit(matcher->tbl->ctx, matcher->mt);
+		mlx5hws_definer_mt_uninit(ctx, matcher->mt);
 }
 
 static int
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 32e83cddcd60..ae20bcebfdde 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -48,7 +48,8 @@ struct mlx5hws_match_template {
 struct mlx5hws_matcher_match_ste {
 	u32 rtc_0_id;
 	u32 rtc_1_id;
-	struct mlx5hws_pool *pool;
+	u32 ste_0_base;
+	u32 ste_1_base;
 };
 
 enum {
-- 
2.34.1


