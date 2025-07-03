Return-Path: <linux-rdma+bounces-11883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A43AF80F0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9CD1CA3A59
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213C2FA63D;
	Thu,  3 Jul 2025 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VaiU9i2n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939722F85DA;
	Thu,  3 Jul 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568999; cv=fail; b=gfmJLNrVyTdPT0giOWXmCaQKHi3afOAQkdfmPY/QA5cGEfBZK/p9e4jQLp6n0A6PWEbtkNgYscSoK9RjIhnVCrTgpGras/TWoeJUrJMvfVtLpDDEx0ueJdikDbG6fQsGmx8viDeT0QpmYGCF4BTmUhcj9zMHzFfYvBP3mN6GoUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568999; c=relaxed/simple;
	bh=gL5Pf1dTVd1vIuuyIlGrHA8y9nrQRF/YQRSVfT8A+CY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShTOSjAkTcYI2T76YFA3b6Wp/+xqtjPGebwyuIwR1hSbuVAlOUu5VjwPAyWOkexWOTm1BGiropqfr8hXFrHHktEhijWe+QiizXOrffDm7mV5Fq8AWjqWawhs84fxG4VlvEMY/jI80ED8hUuhr6/wcJNcJxgDLNiYWFNl6KotqNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VaiU9i2n; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R53GkJ98TyDdpssT4M3xqRWuOemKhwzOgwAcbmkORdFGDmJur9oNCWbaOuyNBrt7hC+hqnK24xo/hMFynzP1oSYkqtJ9+Qhggrphe9nub5/I/3LfCZ/vPxENyMFNE8JX5tJz8sFYceogQMBf5LRq9nUMcyJuXHxhguV7aLfx5tvmsvUzZnXjipUGgNKfj70bFV8y4SQ95z3bUqBfH4ulxSCvQRPwtVneht1ddNL4e2CwT+wOZur2WOeX+HLktnbzYbK6A8E8w1tZxbB5+s+rudpFd2qzg35fGm/Pu7uV2HTnwxKewdshGQs8jAQWhr9ROP1eOoCC69L399+tR62cbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXtWidwZfQPyeFewEhUR4cRCMuE3gpktkztvZT4ni0M=;
 b=hw96KlY7jk4rOBxKy2hwMhpp1RPn9RSnjNtuPHjc0EHrI3jb++eK6JntGkAhv46Ja/VsdoZ1Ue9Ri+jnR/wzL1rQIVuFb1DCrVSpsDfvVQ0X+5q8333UcV/k7TjU5M9O8OXnDJZAONYki7tHlUgndpbi+DM/WnLv8TiWdLXFfAU/hPZBx9pmQ4Eh4W8aZSyILsJYTgg3A3Ca24qkvjZQlrn1lKlNV0QSds+24wpwjW8Ffu5Di4GL+w3KDv6ITj26gQ2flHIBBmrHrDhLRs0/KwenpZ/JM6/t5r1gl55lASA/AUsz4S+cFpyrKQH7OGlTgTynWYjNckLscn6+UgVU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXtWidwZfQPyeFewEhUR4cRCMuE3gpktkztvZT4ni0M=;
 b=VaiU9i2ns+zYoMt5ztTelrO26FqDfdfXYmY5rU3/qDaDOj5YF+pOlvq79vJnZcJ2k9kOkprKe52jv/nqgHTxJp4IaAf4O7OeZVtcrpi1EjiyrGLX/N7LK6eVoVibK2mGR/BS5PiBjx5u+0WyYPmJ8oUt5rvZqGMoa0M3ey8LtT92AHATD/97zV6P+FqZMvsGAy/eFTdfp/pVihk+25tbNk0sRceHD6ySJx7M1Db7+jlAWEVIhJaOLmL07UzGuULeReKwFkE4LQbjaoYFFpqL5KqqE4r+hCPMsWNMHymdkCozpgMhREgd7eg4Jly8RDY7Dlhj7zXH+EyvaTdR4e04vg==
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Thu, 3 Jul
 2025 18:56:32 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e9:cafe::80) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 18:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:09 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 03/10] net/mlx5: HWS, Export rule skip logic
Date: Thu, 3 Jul 2025 21:54:24 +0300
Message-ID: <20250703185431.445571-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd2d48a-01fa-493d-6da9-08ddba635388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k5Cd0xg+NFtuF2Jx9mOos7irYP6mG4oJFXdfiVjY10E62ojjTIhwB7tKJGGn?=
 =?us-ascii?Q?9xMGs4ISQVFOXRRLMzfp/7kNPMy3MYeAERp8pNm8E283pAGuhYjJGbpUWfkj?=
 =?us-ascii?Q?PeoQA1qKBibEroocsVYfHiIZ8g/XxM2q4tUKutoyIscPSWTub1ra1sm0Pab2?=
 =?us-ascii?Q?RD1fAw+8TyH6vLUtEiapOpbTE0RMqOcZ5pDcsaFsPMoqcYMEmIZqGDfoPC+r?=
 =?us-ascii?Q?yp+9oVdYLTT3GNl5ebyj68j2mu5UVlSZ4i1k8Zo/f7kwHyJawT0TfFUKNeXc?=
 =?us-ascii?Q?BBhNPRorSuv0/cNDnUR0fQoXK4cP9aRQoUaV6Heof9gVxV5+XJZV7DQxUyK0?=
 =?us-ascii?Q?O1MS/9+rGX3AKFao1yhBxte9ze030piLgS++nJQM9lTQGMVIhJ99mAathB+O?=
 =?us-ascii?Q?xcc9F3NhKTC+/HEYJM4RZ7S1/Qw+hNJU39yHowuw8JWLpGxx/bcQaeQfLL41?=
 =?us-ascii?Q?obtAuzWM8K5SR3lheoj5ShaS6A33/gZmTeFBKfdeiwtJRBOeg6oqmk7OM7tk?=
 =?us-ascii?Q?THN9YDXyjaHMWI0cqRqJEpWy+aKKfMN/jKG0H2Y3RDcXzl7wWWBHqgWI8Whs?=
 =?us-ascii?Q?NuDRhJ73oCTPEUEfUeQu+6mW7t+AbByKVNYVeOPplCWVhAIBz1rZiHhocEIN?=
 =?us-ascii?Q?2uOKl7zgySBP2yZ699z1wbbmI8DO6c73WxhzCGTQTTWDcxmoE82lL5dFDX+t?=
 =?us-ascii?Q?EH/YO/g+jAGKyGzimUqxxHfhPRyN+Wk2doybu4VLnU9TbP3Sg3xld3G/RHae?=
 =?us-ascii?Q?QgcKmU5vUsEdswi9yK7wncIobhtM6Gax9DPa/Ymsl9TnXzrRXH0A9h1HfrLl?=
 =?us-ascii?Q?9bQb+7VKQ1/iCxE1xlZyqP9FuYHeMcePYG/qENe36Euw8Y5FcAiBFXdCXyNc?=
 =?us-ascii?Q?T2LgWFXM/tFnmvXbPWteXPNVKiodiW0DLjQegDQiXfTmwX2OuO/T0QEGTUN+?=
 =?us-ascii?Q?Y67Vcya5ucJGEpbkcwyf15L4rEX4ujGJiI7nn7aA6k67DoO1gQUDEl/2C8Qx?=
 =?us-ascii?Q?dNK4da76zttFDkDpyqbGUueyyx822yIxydzaeEAZJ+Q4JrWlw4zX9zIBnpEQ?=
 =?us-ascii?Q?gBiIegRuE07UavMqRDbRmQiFyIZtzlqZl15WuvDGsNCVTZlxe1xapxQKvkBk?=
 =?us-ascii?Q?/2/fIYkFMj5vMrfieY2KtewArahobQThr2enbVD8i6u3uVqI6LUtrfhj/+n9?=
 =?us-ascii?Q?CnCySg0yinW6JC0u5I15eGrKLNByRncvC8QJ/2+oOC+7Cdlwp0BILbvFjGN0?=
 =?us-ascii?Q?AxwdCGFCXEnNR4HRiYXmy1Bl+q5hJLSsUDL0ZdRjbGuF78b415kY9G5yVvtq?=
 =?us-ascii?Q?RrwjTdTw1SpvRmmGRQlhDHYJlzNl5kvYOjbICdSBmN7CodLyVYoksuuAuvfN?=
 =?us-ascii?Q?TD8gtPGdgr/vIhpWErhn/YEeM5lHa0kFPr/FU7BnZoOoi/f7Bqf2mpzQhO89?=
 =?us-ascii?Q?pGaG+2hjGe6/0nUKMsihqPo9tRdwwelq+E1NtcbMZehYmtP1LTKTT4n1Z9X8?=
 =?us-ascii?Q?J6e6ufHVDmcaCdODdP228OZBo08HH5Yp7blY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:32.0651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2d48a-01fa-493d-6da9-08ddba635388
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808

From: Vlad Dogaru <vdogaru@nvidia.com>

The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
RX and TX rules individually, so export this function for future usage.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/rule.c  | 9 ++++-----
 .../net/ethernet/mellanox/mlx5/core/steering/hws/rule.h  | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 5342a4cc7194..4883e4e1d251 100644
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
@@ -66,7 +64,8 @@ static void hws_rule_init_dep_wqe(struct mlx5hws_send_ring_dep_wqe *dep_wqe,
 				attr->rule_idx : 0;
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		hws_rule_skip(matcher, mt, attr->flow_source, &skip_rx, &skip_tx);
+		mlx5hws_rule_skip(matcher, attr->flow_source,
+				  &skip_rx, &skip_tx);
 
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


