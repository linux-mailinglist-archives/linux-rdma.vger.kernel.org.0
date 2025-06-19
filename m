Return-Path: <linux-rdma+bounces-11460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E2AAE047B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EA37AA93D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4D23A9AB;
	Thu, 19 Jun 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QpexSPfC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705A22ACC6;
	Thu, 19 Jun 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334165; cv=fail; b=Lp8xV6rtFXvapMMnMxk8iYtZuy/HB5Gdm+DN9umIDFcxdblk6xguLVGFdAWpqTkv+Rdd2PszXwNhO5iueVi8wrS7vKCvgUm9heXBJgqiC/DUFaoQWHT3/NamAmfvExfi0KQT98eZn71Pquiz8bWaaIfW+6sPYSoQNcTgwDW0bCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334165; c=relaxed/simple;
	bh=pCo6ofEXpAtsP3FRLWpyvKjgH7jHDgHVfwXKQ7kaJRg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5uEUfPD7RPOps2QoHxzZx3+/xfWB9L2Y1/qRzeNSSzQ2kEOcH5iHqeIExbmKBH7m/sWoWNo+bxT1fWnqSDs/X5JPJeZf98Ej5g2F8r8uhW6vdVtOuZDDT8q1loPiMS0/0TNqMDidHbDP5jrfntqcJEcp7UEGQnmHB9jB4yP3ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QpexSPfC; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/z28g42v5XTlRbTu8r0Y+vaaJPNStkW0YzIvGoEDbL37cTBBeu4fmQ9hSkPp8koC5amnNf+mg/+Vn3FL0aVu8BCItBceSh8s1NIthTcil8SV2uCwoVLpt1a8Fk7AfP93YXapDOOx1G8I3fpOqg38UU9+01R51B42vNh1ArgRPoyvu/QWPdVT+7Alsv8ltZ52QCRJbSvRmn9PxKEA8ZP8vAEAq6wDpt9iC/eXufrtnx4/WPj7fw3ATraCVlMHDpMqk5yoH6cYj4UZ8ryApprDuQJm/ZBM0ugco6ENrRHoJGCg9/+95yp5YRFXjZHi7UUHBRfgtssuMvD8Mz2vvZJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGsgSv/46/gGV1u/dOXFPQBgtvGY/bP7i5DR9saG1HA=;
 b=kcCV1R3X1e/q2lg9BEkUAbIzXI5j3PuMLG/u1bJ2vGfsHCuZIiwTrOLW7MwE7qRdu24FADHtKv5qLZazqSJrztQfWEnyXigt1ty086OKd6nu1SQl4ejWoOWbT833SSkNdqP/CuSgNh4A3yO4GjDMT3jbdjGSEMIGBzKZPlcNr2gT2Oe43BMYJxyBhzGf/E/NR9inkn8Cgx4tJM4WZ7IpkCBowGAWYPanmWGDQnv3sdr2UCaV/jHLB/NOk/9C8xvgf8YHazamn/6HQWDUWZz7x4yxPLzVjBMwGOo5hXwoq4hdNTqzo6sTAHG4JLmaP1Ob7EIRAgMNAgsknFENxmmZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGsgSv/46/gGV1u/dOXFPQBgtvGY/bP7i5DR9saG1HA=;
 b=QpexSPfCiZc3wMu+nE651bAWYn0jUQp677Ohxw8rKuO5HoOiujzk6rObeMDb+Arf49dpENbNKme/1wMYlq8wTzlyhiU3ECK74iqEi1D5TRmvPo2QA6FYMMTdkB6dpJOoTxFVeJ597oVIinShLn+vjCBZTg2HDvqB/8jm4ahXPWW/YDFQ2Tpr+pN2X236+JEP624thPSng8XYShHOSAB7w1YqO6Wa7KqGlfRamuiwNR0gPPRm6aOoJDA3KMfskliPr4eM72hzG6BCizrKQD1a+0LEJY+0zfl0iniw9jSmhSavzIFW2vP3cvNlZTfvRMVB0Xaz3A9K1KtDH8MCcnWOMg==
Received: from CH2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:610:4c::30)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Thu, 19 Jun
 2025 11:55:56 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::da) by CH2PR10CA0020.outlook.office365.com
 (2603:10b6:610:4c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.23 via Frontend Transport; Thu,
 19 Jun 2025 11:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:55:55 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:46 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 5/8] net/mlx5: HWS, Decouple matcher RX and TX sizes
Date: Thu, 19 Jun 2025 14:55:19 +0300
Message-ID: <20250619115522.68469-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: dc6ec36c-f52a-497d-9702-08ddaf283fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TU9olFV6YgjBds00ZzQnVMAtNNi/089kBAwIsfrwFLurDJJwE/TGmvkq48UT?=
 =?us-ascii?Q?ngl/zgGEKUlSR4tgrERt/yYYTiARTqqqvJkSthuTbsv+J1LLz5hCsj032WXk?=
 =?us-ascii?Q?oARwgjDtfO2ZEuc9jHeOKuLeK1bVO95i8wvkZVk8i+6X81RNei/ZYKRFwz3+?=
 =?us-ascii?Q?FZdgAYHGjIhqY1QIpw5OieMJPco1TzprkwU9s8i6VfbYFwQeFPfEsshhV3kK?=
 =?us-ascii?Q?2P7QSmDy7BzTlYfRI7PhtZwdCKOXzAHfrzYx6oBSvFLVoMiZ6sCYTuumAQjZ?=
 =?us-ascii?Q?2LYptSFUGyX0K1GPrIfD4gIbsm75ETyK3C3OoUv0lPXgPvG8cU75/xJPPGEs?=
 =?us-ascii?Q?IyC9qjjbPCmZaHcBlz6u98t5euoDPAJOESflCIjwP70swFRkRo/Yk2jpzLA0?=
 =?us-ascii?Q?IpbY3+NxaICGA/H9OEvTxq/ECZ6YddkWPs5KPs1jyCapnHIzJrf4Okgmofzb?=
 =?us-ascii?Q?XAUaFQpkXn5TYRX36irJScLej/z5uNO3CHD6DbeBgvUshgaI0gBW0ku78DAi?=
 =?us-ascii?Q?2IW7IXJR2lLTgQbk51V9VkP2ZHb8pAK+as9UylUxY2NhtiZLNNQgRgxItlH5?=
 =?us-ascii?Q?/sHnp6NNJDicpMHIC1254wV6DscNB/VBv9kZK6n3I34sWWrnp2K4XNt0zP9b?=
 =?us-ascii?Q?G/0zqJsNw8ITDylxo+02iU7+IQ71qMlPUfyuiLfjUjrpUAZ+K7H3Iw1UanM+?=
 =?us-ascii?Q?rbO8VCWSoBaLtzxvrrO8H8Bfr+n2BBWnkOzme3JUmRTI1wRgVjqP/3JBqUCI?=
 =?us-ascii?Q?UL7U2P1nUXQ0fGh6MQDKOKlWK9BSEdJ25V5VIfBKUV2E1iPLVN0YqpdHuca2?=
 =?us-ascii?Q?pKSlYUIR+bYSO8IzKc08E10/cOmvVvMSpO4GfaTwSB9P1CRvHkIgmn1QNOGD?=
 =?us-ascii?Q?xnEv240aVTMDoNKQKR/o7ImogoEZZ9u4FAOaEcUtUMPZZgkDVjSaKXWrPr2Y?=
 =?us-ascii?Q?5fOVTv761FHN8Cwug2qgEB9NaDpJEKJvGVNNar7fSbxnjJvKS0WY7ebLjVzc?=
 =?us-ascii?Q?+qg8nohtb62ldNMalTuo849I1nQCdBQrs8k0zWXnSIO3kg6WT2dR81M1tToG?=
 =?us-ascii?Q?k4ee/5UpKbsmSuVDnKTGoszOZ6qv2e8WyWxMTDq3OL+mK8LzKaDsJIV3wQ9t?=
 =?us-ascii?Q?ED31ncHo8wNRxqOkKbjVxnq4Lmxu+E2Z0tbigOOR3oRsPUREYNYeBrwemoU9?=
 =?us-ascii?Q?NH6XwAL7NrGryzm2ZmFwfi1CL95Mur07nGiTw5oGjLuFIUWdckf+0xXriCHc?=
 =?us-ascii?Q?tJWR0t9nm4w/c58emCH6UqdaRrZTjpH5PpSxuqBSHQcWL79nwxFLJpfUjQBH?=
 =?us-ascii?Q?phWIMi0S6r3EjtjHb9nJiRkaEx2sW4YDRIrgtfrbdUBzhjLWzyOtewzHEnFj?=
 =?us-ascii?Q?ZnasfW2VFRPoKQkRtiEFUI78zJBH3ksU5CyxCh95zQ3QFwYqe8vON2ev1ZL6?=
 =?us-ascii?Q?y9vuK0i4w6FT21PhN4gI9iLzDH29lKQxYYaBO5tfy/3qxO6kVgyDTXoLCTxZ?=
 =?us-ascii?Q?QIaCWCk9QyGyoHXJcgOUz30TGQZTMVN4pKAI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:55:55.7687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6ec36c-f52a-497d-9702-08ddaf283fb9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Kernel HWS only uses FDB tables and, as such, creates two lower level
containers (RTCs) for each matcher: one for RX and one for TX. Allow
these RTCs to differ in size by converting the size part of the matcher
attribute to a two element array.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     |   7 +-
 .../mellanox/mlx5/core/steering/hws/debug.c   |  10 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 107 ++++++++++++------
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  28 +++--
 4 files changed, 104 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 665e6e285db5..009641e6c874 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -48,7 +48,7 @@ static void hws_bwc_unlock_all_queues(struct mlx5hws_context *ctx)
 
 static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 				      u32 priority,
-				      u8 size_log,
+				      u8 size_log_rx, u8 size_log_tx,
 				      struct mlx5hws_matcher_attr *attr)
 {
 	struct mlx5hws_bwc_matcher *first_matcher =
@@ -62,7 +62,8 @@ static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 	attr->optimize_flow_src = MLX5HWS_MATCHER_FLOW_SRC_ANY;
 	attr->insert_mode = MLX5HWS_MATCHER_INSERT_BY_HASH;
 	attr->distribute_mode = MLX5HWS_MATCHER_DISTRIBUTE_BY_HASH;
-	attr->rule.num_log = size_log;
+	attr->size[MLX5HWS_MATCHER_SIZE_TYPE_RX].rule.num_log = size_log_rx;
+	attr->size[MLX5HWS_MATCHER_SIZE_TYPE_TX].rule.num_log = size_log_tx;
 	attr->resizable = true;
 	attr->max_num_of_at_attach = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
 
@@ -93,6 +94,7 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  priority,
 				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
+				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
 				  &attr);
 
 	bwc_matcher->priority = priority;
@@ -696,6 +698,7 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  bwc_matcher->priority,
 				  bwc_matcher->size_log,
+				  bwc_matcher->size_log,
 				  &matcher_attr);
 
 	old_matcher = bwc_matcher->matcher;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index f9b75aefcaa7..2ec8cb10139a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -99,17 +99,19 @@ hws_debug_dump_matcher_attr(struct seq_file *f, struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_matcher_attr *attr = &matcher->attr;
 
-	seq_printf(f, "%d,0x%llx,%d,%d,%d,%d,%d,%d,%d,%d\n",
+	seq_printf(f, "%d,0x%llx,%d,%d,%d,%d,%d,%d,%d,%d,-1,-1,%d,%d\n",
 		   MLX5HWS_DEBUG_RES_TYPE_MATCHER_ATTR,
 		   HWS_PTR_TO_ID(matcher),
 		   attr->priority,
 		   attr->mode,
-		   attr->table.sz_row_log,
-		   attr->table.sz_col_log,
+		   attr->size[MLX5HWS_MATCHER_SIZE_TYPE_RX].table.sz_row_log,
+		   attr->size[MLX5HWS_MATCHER_SIZE_TYPE_RX].table.sz_col_log,
 		   attr->optimize_using_rule_idx,
 		   attr->optimize_flow_src,
 		   attr->insert_mode,
-		   attr->distribute_mode);
+		   attr->distribute_mode,
+		   attr->size[MLX5HWS_MATCHER_SIZE_TYPE_TX].table.sz_row_log,
+		   attr->size[MLX5HWS_MATCHER_SIZE_TYPE_TX].table.sz_col_log);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index b0fcaf508e06..f3ea09caba2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -468,12 +468,16 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
 	struct mlx5hws_match_template *mt = matcher->mt;
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	union mlx5hws_matcher_size *size_rx, *size_tx;
 	struct mlx5hws_table *tbl = matcher->tbl;
 	u32 obj_id;
 	int ret;
 
-	rtc_attr.log_size = attr->table.sz_row_log;
-	rtc_attr.log_depth = attr->table.sz_col_log;
+	size_rx = &attr->size[MLX5HWS_MATCHER_SIZE_TYPE_RX];
+	size_tx = &attr->size[MLX5HWS_MATCHER_SIZE_TYPE_TX];
+
+	rtc_attr.log_size = size_rx->table.sz_row_log;
+	rtc_attr.log_depth = size_rx->table.sz_col_log;
 	rtc_attr.is_frst_jumbo = mlx5hws_matcher_mt_is_jumbo(mt);
 	rtc_attr.is_scnd_range = 0;
 	rtc_attr.miss_ft_id = matcher->end_ft_id;
@@ -525,6 +529,8 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
+		rtc_attr.log_size = size_tx->table.sz_row_log;
+		rtc_attr.log_depth = size_tx->table.sz_col_log;
 		rtc_attr.ste_base = matcher->match_ste.ste_1_base;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
@@ -562,23 +568,33 @@ hws_matcher_check_attr_sz(struct mlx5hws_cmd_query_caps *caps,
 			  struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_matcher_attr *attr = &matcher->attr;
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	union mlx5hws_matcher_size *size;
+	int i;
 
-	if (attr->table.sz_col_log > caps->rtc_log_depth_max) {
-		mlx5hws_err(matcher->tbl->ctx, "Matcher depth exceeds limit %d\n",
-			    caps->rtc_log_depth_max);
-		return -EOPNOTSUPP;
-	}
+	for (i = 0; i < 2; i++) {
+		size = &attr->size[i];
 
-	if (attr->table.sz_col_log + attr->table.sz_row_log > caps->ste_alloc_log_max) {
-		mlx5hws_err(matcher->tbl->ctx, "Total matcher size exceeds limit %d\n",
-			    caps->ste_alloc_log_max);
-		return -EOPNOTSUPP;
-	}
+		if (size->table.sz_col_log > caps->rtc_log_depth_max) {
+			mlx5hws_err(ctx, "Matcher depth exceeds limit %d\n",
+				    caps->rtc_log_depth_max);
+			return -EOPNOTSUPP;
+		}
 
-	if (attr->table.sz_col_log + attr->table.sz_row_log < caps->ste_alloc_log_gran) {
-		mlx5hws_err(matcher->tbl->ctx, "Total matcher size below limit %d\n",
-			    caps->ste_alloc_log_gran);
-		return -EOPNOTSUPP;
+		if (size->table.sz_col_log + size->table.sz_row_log >
+		    caps->ste_alloc_log_max) {
+			mlx5hws_err(ctx,
+				    "Total matcher size exceeds limit %d\n",
+				    caps->ste_alloc_log_max);
+			return -EOPNOTSUPP;
+		}
+
+		if (size->table.sz_col_log + size->table.sz_row_log <
+		    caps->ste_alloc_log_gran) {
+			mlx5hws_err(ctx, "Total matcher size below limit %d\n",
+				    caps->ste_alloc_log_gran);
+			return -EOPNOTSUPP;
+		}
 	}
 
 	return 0;
@@ -666,6 +682,7 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_cmd_ste_create_attr ste_attr = {};
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	union mlx5hws_matcher_size *size;
 	int ret;
 
 	/* Calculate match, range and hash definers */
@@ -682,11 +699,11 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 
 	/* Create an STE range each for RX and TX. */
 	ste_attr.table_type = FS_FT_FDB_RX;
+	size = &matcher->attr.size[MLX5HWS_MATCHER_SIZE_TYPE_RX];
 	ste_attr.log_obj_range =
 		matcher->attr.optimize_flow_src ==
-				MLX5HWS_MATCHER_FLOW_SRC_VPORT ?
-				0 : matcher->attr.table.sz_col_log +
-				    matcher->attr.table.sz_row_log;
+			MLX5HWS_MATCHER_FLOW_SRC_VPORT ?
+			0 : size->table.sz_col_log + size->table.sz_row_log;
 
 	ret = mlx5hws_cmd_ste_create(ctx->mdev, &ste_attr,
 				     &matcher->match_ste.ste_0_base);
@@ -696,11 +713,11 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 	}
 
 	ste_attr.table_type = FS_FT_FDB_TX;
+	size = &matcher->attr.size[MLX5HWS_MATCHER_SIZE_TYPE_TX];
 	ste_attr.log_obj_range =
 		matcher->attr.optimize_flow_src ==
-				MLX5HWS_MATCHER_FLOW_SRC_WIRE ?
-				0 : matcher->attr.table.sz_col_log +
-				    matcher->attr.table.sz_row_log;
+			MLX5HWS_MATCHER_FLOW_SRC_WIRE ?
+			0 : size->table.sz_col_log + size->table.sz_row_log;
 
 	ret = mlx5hws_cmd_ste_create(ctx->mdev, &ste_attr,
 				     &matcher->match_ste.ste_1_base);
@@ -735,6 +752,10 @@ hws_matcher_validate_insert_mode(struct mlx5hws_cmd_query_caps *caps,
 {
 	struct mlx5hws_matcher_attr *attr = &matcher->attr;
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	union mlx5hws_matcher_size *size_rx, *size_tx;
+
+	size_rx = &matcher->attr.size[MLX5HWS_MATCHER_SIZE_TYPE_RX];
+	size_tx = &matcher->attr.size[MLX5HWS_MATCHER_SIZE_TYPE_TX];
 
 	switch (attr->insert_mode) {
 	case MLX5HWS_MATCHER_INSERT_BY_HASH:
@@ -745,7 +766,7 @@ hws_matcher_validate_insert_mode(struct mlx5hws_cmd_query_caps *caps,
 		break;
 
 	case MLX5HWS_MATCHER_INSERT_BY_INDEX:
-		if (attr->table.sz_col_log) {
+		if (size_rx->table.sz_col_log || size_tx->table.sz_col_log) {
 			mlx5hws_err(ctx, "Matcher with INSERT_BY_INDEX supports only Nx1 table size\n");
 			return -EOPNOTSUPP;
 		}
@@ -765,7 +786,10 @@ hws_matcher_validate_insert_mode(struct mlx5hws_cmd_query_caps *caps,
 				return -EOPNOTSUPP;
 			}
 
-			if (attr->table.sz_row_log > MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX) {
+			if (size_rx->table.sz_row_log >
+				MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX ||
+			    size_tx->table.sz_row_log >
+				MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX) {
 				mlx5hws_err(ctx, "Matcher with linear distribute: rows exceed limit %d",
 					    MLX5_IFC_RTC_LINEAR_LOOKUP_TBL_LOG_MAX);
 				return -EOPNOTSUPP;
@@ -789,6 +813,10 @@ hws_matcher_process_attr(struct mlx5hws_cmd_query_caps *caps,
 			 struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_matcher_attr *attr = &matcher->attr;
+	union mlx5hws_matcher_size *size_rx, *size_tx;
+
+	size_rx = &attr->size[MLX5HWS_MATCHER_SIZE_TYPE_RX];
+	size_tx = &attr->size[MLX5HWS_MATCHER_SIZE_TYPE_TX];
 
 	if (hws_matcher_validate_insert_mode(caps, matcher))
 		return -EOPNOTSUPP;
@@ -800,8 +828,12 @@ hws_matcher_process_attr(struct mlx5hws_cmd_query_caps *caps,
 
 	/* Convert number of rules to the required depth */
 	if (attr->mode == MLX5HWS_MATCHER_RESOURCE_MODE_RULE &&
-	    attr->insert_mode == MLX5HWS_MATCHER_INSERT_BY_HASH)
-		attr->table.sz_col_log = hws_matcher_rules_to_tbl_depth(attr->rule.num_log);
+	    attr->insert_mode == MLX5HWS_MATCHER_INSERT_BY_HASH) {
+		size_rx->table.sz_col_log =
+			hws_matcher_rules_to_tbl_depth(size_rx->rule.num_log);
+		size_tx->table.sz_col_log =
+			hws_matcher_rules_to_tbl_depth(size_tx->rule.num_log);
+	}
 
 	matcher->flags |= attr->resizable ? MLX5HWS_MATCHER_FLAGS_RESIZABLE : 0;
 	matcher->flags |= attr->isolated_matcher_end_ft_id ?
@@ -862,14 +894,19 @@ static int
 hws_matcher_create_col_matcher(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	union mlx5hws_matcher_size *size_rx, *size_tx;
 	struct mlx5hws_matcher *col_matcher;
-	int ret;
+	int i, ret;
+
+	size_rx = &matcher->attr.size[MLX5HWS_MATCHER_SIZE_TYPE_RX];
+	size_tx = &matcher->attr.size[MLX5HWS_MATCHER_SIZE_TYPE_TX];
 
 	if (matcher->attr.mode != MLX5HWS_MATCHER_RESOURCE_MODE_RULE ||
 	    matcher->attr.insert_mode == MLX5HWS_MATCHER_INSERT_BY_INDEX)
 		return 0;
 
-	if (!hws_matcher_requires_col_tbl(matcher->attr.rule.num_log))
+	if (!hws_matcher_requires_col_tbl(size_rx->rule.num_log) &&
+	    !hws_matcher_requires_col_tbl(size_tx->rule.num_log))
 		return 0;
 
 	col_matcher = kzalloc(sizeof(*matcher), GFP_KERNEL);
@@ -886,10 +923,16 @@ hws_matcher_create_col_matcher(struct mlx5hws_matcher *matcher)
 	col_matcher->flags |= MLX5HWS_MATCHER_FLAGS_COLLISION;
 	col_matcher->attr.mode = MLX5HWS_MATCHER_RESOURCE_MODE_HTABLE;
 	col_matcher->attr.optimize_flow_src = matcher->attr.optimize_flow_src;
-	col_matcher->attr.table.sz_row_log = matcher->attr.rule.num_log;
-	col_matcher->attr.table.sz_col_log = MLX5HWS_MATCHER_ASSURED_COL_TBL_DEPTH;
-	if (col_matcher->attr.table.sz_row_log > MLX5HWS_MATCHER_ASSURED_ROW_RATIO)
-		col_matcher->attr.table.sz_row_log -= MLX5HWS_MATCHER_ASSURED_ROW_RATIO;
+	for (i = 0; i < 2; i++) {
+		union mlx5hws_matcher_size *dst = &col_matcher->attr.size[i];
+		union mlx5hws_matcher_size *src = &matcher->attr.size[i];
+
+		dst->table.sz_row_log = src->rule.num_log;
+		dst->table.sz_col_log = MLX5HWS_MATCHER_ASSURED_COL_TBL_DEPTH;
+		if (dst->table.sz_row_log > MLX5HWS_MATCHER_ASSURED_ROW_RATIO)
+			dst->table.sz_row_log -=
+				MLX5HWS_MATCHER_ASSURED_ROW_RATIO;
+	}
 
 	col_matcher->attr.max_num_of_at_attach = matcher->attr.max_num_of_at_attach;
 	col_matcher->attr.isolated_matcher_end_ft_id =
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index a1295a311b70..59c14745ed0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -93,6 +93,23 @@ enum mlx5hws_matcher_distribute_mode {
 	MLX5HWS_MATCHER_DISTRIBUTE_BY_LINEAR = 0x1,
 };
 
+enum mlx5hws_matcher_size_type {
+	MLX5HWS_MATCHER_SIZE_TYPE_RX,
+	MLX5HWS_MATCHER_SIZE_TYPE_TX,
+	MLX5HWS_MATCHER_SIZE_TYPE_MAX,
+};
+
+union mlx5hws_matcher_size {
+	struct {
+		u8 sz_row_log;
+		u8 sz_col_log;
+	} table;
+
+	struct {
+		u8 num_log;
+	} rule;
+};
+
 struct mlx5hws_matcher_attr {
 	/* Processing priority inside table */
 	u32 priority;
@@ -107,16 +124,7 @@ struct mlx5hws_matcher_attr {
 	enum mlx5hws_matcher_distribute_mode distribute_mode;
 	/* Define whether the created matcher supports resizing into a bigger matcher */
 	bool resizable;
-	union {
-		struct {
-			u8 sz_row_log;
-			u8 sz_col_log;
-		} table;
-
-		struct {
-			u8 num_log;
-		} rule;
-	};
+	union mlx5hws_matcher_size size[MLX5HWS_MATCHER_SIZE_TYPE_MAX];
 	/* Optional AT attach configuration - Max number of additional AT */
 	u8 max_num_of_at_attach;
 	/* Optional end FT (miss FT ID) for match RTC (for isolated matcher) */
-- 
2.34.1


