Return-Path: <linux-rdma+bounces-10274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D87CAB2A8E
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1316E1AB
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8A262FD9;
	Sun, 11 May 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJLm9N6m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE260261589;
	Sun, 11 May 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992370; cv=fail; b=eA1bDVuUfK1DtX6vRnF98g2gOFdERRCaLj+8nNH5Mo4gXLG9iV1OVqKxHfwy/LCZsmziBOAQpUelf0cV1Qml9sQOX7W6J3zgj10BYxWFZE75IixbqVRwV0uhsPpKEdewAP3G98dwW5ktYixq6X5X5+B0BGWUYHKnBFXDW/rXIaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992370; c=relaxed/simple;
	bh=NaEG0PeO4hp/8p8yRKxGePYX1MLfSypS/fv1GTCiuXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHRcN8geXOnvA1Ed5GpaKCJI3S/iqpu2LRYAHDmUstGhLYlNqB9W04hwc93i6Wi0BbNcDwQqYX+xGYalRS0jdGCjWJtcuq8jwsCA2+dEukFwbzxV3ZqEz4o2DcN57ckFhFOic9uJes0MPAhZT/T06RcvjF+/pnU73CQ+ci3sEsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJLm9N6m; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUtnvPtN+8lBg7Jyyf0xI+ia2DmgLqmmukpUveQ+1lzsH8jfOK08VTXF7a2Nc4TvXZZm1jAzwWcWNtqGeg+t0vXkHRncXlDJ2q2UjSvESARdn7UNE/ePuKHT9dZKD0C5uDW0J7ee3fpdnATIuBgNtIAA54ILSnzFTgjGYFiMoF4wlp38hmQXXbXgV+dKEjJs2xw6oPM5v2cC0AI12wQ7LLg+jEPrjhZDkyZUR0u0T5NpA00VbNlMise9q4KrBkh7xxSwnH9SOE/vxRRPtrr4Ut5uAzOwNfGyERWWNSEjLoePuTB1oK52TRBAQVzzLEVLOFIqvfl38Nb9RWI3CvMORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uxtUzZbgMDVP8DTbLZJpxIQ9HxzHoqcFG26SnqoMnc=;
 b=J78fYkHTygKzkMsPfYwnsecWrPWfX4QPA18tvjY57x4ZNUhihLgyyQYQMZuMoqsSp28jy23+xhwEkasYrbA6Kjj6gelEHobSa6IiCuNvgPNAIojjGeBGXG5n/hbeejb0iSwLcJNjLHFKRdwXhLokHvamWQPUZsNL4F8sVyMgj2aNYXKZkoOYJjhI9Wq95FuSuOeMJUQJovflNfbAY7VdNr8L/STaRU3h7YrP3BhG+y2H5g4Fld5/OcmGGx5YB/f5X4EuCgwYqSjs/7vJVa77FO8F+cCmxWa9JHBTJN2+8vx2VYaklcWpzBuorYaL6LqBVQFB4in7suUuBLjTJAHNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uxtUzZbgMDVP8DTbLZJpxIQ9HxzHoqcFG26SnqoMnc=;
 b=YJLm9N6m09DpYptVXRhd1zv1/9JDvAWKq2xB/Fz8xHwZ1KFZB1JFQU0nPtInfwgWr2zxWI8GOFekYCcSnA61KjY+9EriZdQx3uNwhxRVs4EDJgl4kKxm6uGs5eVYYma3UnC6YfOPkG6kx+Fqjqj7nqGjEg12S0ugoY5CJ9eJS8OAyg3DzOsr5Ma3O62iz9iWcQDA8OHWLyrKL05aKOXwDo4DKEiqtGk5XhAYJ33IkI7ZfzCZg1raebtohfPkBsQL0daA9H66rlorIh+aywzsQJzA4ZNYG9g3fihc6Beam7p0ziIJcvtuWs2PRP6FIiCxRjYZf1OznZ6gxo0KYHvK7Q==
Received: from BN9PR03CA0441.namprd03.prod.outlook.com (2603:10b6:408:113::26)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Sun, 11 May
 2025 19:39:25 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::d1) by BN9PR03CA0441.outlook.office365.com
 (2603:10b6:408:113::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Sun,
 11 May 2025 19:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:14 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:10 -0700
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
Subject: [PATCH net-next 03/10] net/mlx5: HWS, expose polling function in header file
Date: Sun, 11 May 2025 22:38:03 +0300
Message-ID: <1746992290-568936-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ea8806-3013-488c-add4-08dd90c3890f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bflydC4Noev1xaKCkfM2BpBLviT8Of7Dl8KtGP60xuKbJrU9AOYmF/bVeqaU?=
 =?us-ascii?Q?F9fgPYNgRfNU2l2vLuiTfTqDw6JmbGYrKID/2z8T1dOqgdzpSE5PFrgCS6jF?=
 =?us-ascii?Q?Y7wdaFyKdN4KgTyJtysJdXw3hVDByPwj8nP6OO8ZjGq2PzohDt+37q5q8BXD?=
 =?us-ascii?Q?YEZ4P/+UiJNjzABtLPAZFDKFKu4UDrry3cwdpcceMch0eF3qQJlKqQzqx5ML?=
 =?us-ascii?Q?86S59Ee3D7PFtyzSiCRfPtX193FHgBqTLj98xZWFzLRttPI/TjFMKotCtHK6?=
 =?us-ascii?Q?/pV2cNCawna5FzmAk7Hd0Uqc44p+RjC9Wi5eB65V5zouLsCXJEoji04Debav?=
 =?us-ascii?Q?V0ivhjzGv8YzN4MjtPJsEMTB4GEXm4/Jh68sNDQNIBdnmzYVDW0lOmrFmFhm?=
 =?us-ascii?Q?qOZDuGw0GkFMhKiYicp/PpPaRlFgac74zQBxH5lMn7i+EFU5Mk5EY66WJW9f?=
 =?us-ascii?Q?FTW4geA+1M4lva+WNt+FVN7isBmHf8ypX2YSZqVH9HIC6Y0vm3P8E/ZvFaDJ?=
 =?us-ascii?Q?IqrdrOpflFmAx5YTNdQphldyR9qqKclMLQuNGgmzUZ157icfxM0YYTzzs/wp?=
 =?us-ascii?Q?HNu0WHpddeD1IHjZSXNX73cjorKm7SDnWPSSdmO3aAKtoMFQnwybJfHJ37ej?=
 =?us-ascii?Q?QA4vy0Cxg8laONg4DzTnn7txsKjCyJJRDSmd5a26UU9aEet5xD4At0MxfG4S?=
 =?us-ascii?Q?cP59+tWvVT9TlhTIPrpKTqH+LLuC39Gdvz9dfsfltVJlVVhYqnmZwIVinHmJ?=
 =?us-ascii?Q?luuZNbut3HgAN/IpvCaWeLT1r8zKFWWeS0OilaaPXAHBjN/69xVhoybyArKi?=
 =?us-ascii?Q?CbCkWW6K1ACm9aRz5ZBKqcUL6wdeXWg0+UChMq6VcFBlFlmN3hhipSfeH/Hz?=
 =?us-ascii?Q?ixDcI+8UEPIadjFBx4IcUmowu/pdD1GmZMZKMeOKlFspJMYyptny/q60ZjbE?=
 =?us-ascii?Q?7AvCLD4gIDLmWo2HLoyG9pE/yCHexwewfHuMkP0cELl+dYz6QtShnMhhrDlQ?=
 =?us-ascii?Q?IHhos0NxBW2e6zRw2lgkBDLCglFfM4oXe4zyAKwgmJCgp8yGNy1IiBb067Ha?=
 =?us-ascii?Q?oRrR5h51175pcILMv1/UiDyRP4nK1YraGsfO9BMz1YiyMkdJG75aqqkH0EQQ?=
 =?us-ascii?Q?7+ORfnlArScAN3amswMsURNeAdtIvDZkhWXczULExj0lH7t0WEu32ByUald8?=
 =?us-ascii?Q?8F32nukrbGv+GnqefExbaW5cE/P3c9FLvNEVEJdKp+HI6Vbokypkxi1zOHw9?=
 =?us-ascii?Q?ILkQpUqLSVEAKSwt/GxvA5Ne9LbINMPha+LAP9HCwV1k1RK43gXankllhowR?=
 =?us-ascii?Q?Y7Z8N6iAo5zNuhynRQkTAMrsGnB+1cVFtwXG/MChSLIHLS9VaXfEFR/QiU9d?=
 =?us-ascii?Q?MKy5ieHVulG5bzTwAWGPw6hKUWJQ4ns05ORzeq72jNLK/49BkFnhTWGzubna?=
 =?us-ascii?Q?lu6fU6x2fFx084wCtZW0fhDNdUIx4izRBE4U2DiH7lDYT9Te1Ot/AA1EE3Bv?=
 =?us-ascii?Q?NAtYXIqu7vHZ2lU6hi+SPkriFaKm8uBhLvyZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:24.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ea8806-3013-488c-add4-08dd90c3890f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In preparation for complex matcher, expose the function that is
polling queue for completion (mlx5hws_bwc_queue_poll) in header
file, so that it will be used by complex matcher code.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 29 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  5 ++++
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 510bfbbe5991..27b6420678d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -223,10 +223,10 @@ int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 	return 0;
 }
 
-static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
-			      u16 queue_id,
-			      u32 *pending_rules,
-			      bool drain)
+int mlx5hws_bwc_queue_poll(struct mlx5hws_context *ctx,
+			   u16 queue_id,
+			   u32 *pending_rules,
+			   bool drain)
 {
 	unsigned long timeout = jiffies +
 				secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT);
@@ -361,7 +361,8 @@ hws_bwc_rule_destroy_hws_sync(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret))
 		return ret;
 
-	ret = hws_bwc_queue_poll(ctx, rule_attr->queue_id, &expected_completions, true);
+	ret = mlx5hws_bwc_queue_poll(ctx, rule_attr->queue_id,
+				     &expected_completions, true);
 	if (unlikely(ret))
 		return ret;
 
@@ -442,9 +443,8 @@ hws_bwc_rule_create_sync(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret))
 		return ret;
 
-	ret = hws_bwc_queue_poll(ctx, rule_attr->queue_id, &expected_completions, true);
-
-	return ret;
+	return mlx5hws_bwc_queue_poll(ctx, rule_attr->queue_id,
+				      &expected_completions, true);
 }
 
 static int
@@ -465,7 +465,8 @@ hws_bwc_rule_update_sync(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret))
 		return ret;
 
-	ret = hws_bwc_queue_poll(ctx, rule_attr->queue_id, &expected_completions, true);
+	ret = mlx5hws_bwc_queue_poll(ctx, rule_attr->queue_id,
+				     &expected_completions, true);
 	if (unlikely(ret))
 		mlx5hws_err(ctx, "Failed updating BWC rule (%d)\n", ret);
 
@@ -651,8 +652,10 @@ static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_match
 							    &bwc_matcher->rules[i]) ?
 					       NULL : list_next_entry(bwc_rules[i], list_node);
 
-				ret = hws_bwc_queue_poll(ctx, rule_attr.queue_id,
-							 &pending_rules[i], false);
+				ret = mlx5hws_bwc_queue_poll(ctx,
+							     rule_attr.queue_id,
+							     &pending_rules[i],
+							     false);
 				if (unlikely(ret)) {
 					mlx5hws_err(ctx,
 						    "Moving BWC rule failed during rehash (%d)\n",
@@ -669,8 +672,8 @@ static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_match
 			u16 queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
 
 			mlx5hws_send_engine_flush_queue(&ctx->send_queue[queue_id]);
-			ret = hws_bwc_queue_poll(ctx, queue_id,
-						 &pending_rules[i], true);
+			ret = mlx5hws_bwc_queue_poll(ctx, queue_id,
+						     &pending_rules[i], true);
 			if (unlikely(ret)) {
 				mlx5hws_err(ctx,
 					    "Moving BWC rule failed during rehash (%d)\n", ret);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index bb0cf4b922ce..a2aa2d5da694 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -64,6 +64,11 @@ void mlx5hws_bwc_rule_fill_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 				u32 flow_source,
 				struct mlx5hws_rule_attr *rule_attr);
 
+int mlx5hws_bwc_queue_poll(struct mlx5hws_context *ctx,
+			   u16 queue_id,
+			   u32 *pending_rules,
+			   bool drain);
+
 static inline u16 mlx5hws_bwc_queues(struct mlx5hws_context *ctx)
 {
 	/* Besides the control queue, half of the queues are
-- 
2.31.1


