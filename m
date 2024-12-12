Return-Path: <linux-rdma+bounces-6492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955699EFF16
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE6A1653FB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCCD1DE3DF;
	Thu, 12 Dec 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RiogK7Pv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AD1AF0AF;
	Thu, 12 Dec 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041721; cv=fail; b=IkU2muCLImSUtoVn90qLd0hYzufgwYu+k7mBgbfwTYplgXYTFiy/Sy5VrnlZsS/sIa9BPle59qdXoAGvdNzqM3wUfYE9n5MUBAD5A3siXuc/IAmLq3axDZ7NjbMwZK11YR48fluHKeOAw/oZI3NkTyYqhu0CtQ6N1a4hAC4Nr18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041721; c=relaxed/simple;
	bh=2LpWy9qn4uW5YI5WK39NwzFb5eQxxie9ms2nCar+biY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChNmjWBLRZvMyAGn/O+2hgwRGI+RW3GY8M4OkJvjlZTZvUBYgX6/GONq5244nWXygsSgrMQI7Vjt09VAlw7FazTN2Ukxl7xQn9OPy3+iUR9JqqqcUHZbZ46gEvdXYmjdbRj4YFZaAm3IDWe2IANkB33ZKNO91RPAHSCOoSuHdUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RiogK7Pv; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPm5EZJgIyhnridbBHajX0T7raQtLg1tBUHXu4pRsHGJupsuWgZ0uJRuKYosUZwrHhc9TYALCB+ukODWispw4reMaJzPdesm8jamlTFs0vBM1haTts8uCWh6pLHUpGpWZ5gB+BPVovr1F8gnTb3x+6fxQaUZHDC5M7ERihp21MBzmXcHwBEogiJQ262NGwDIvhgwSkZpGt1oOSVRfAoT5l2Xd86fyF4YL95f2EAe+ryanvu+VqpadANSWn5JmJ/JwJaJkjNR8de6tZIko1ZeHL93tbHaZgzhyY/b0ze2+IUxgHzQBSQ4LcodUF17g80hrBtg65qvMyA6sDSBDdJJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO4tnkbD8WI62s1KECvHKqg44Q4JsEJDsXpIi9+BCV4=;
 b=K80cGvYlL+OTFpWwW2z37Mh0Dv6T+feMgy1v/wYBlczlhoxLxP7bqdBrU6mOEz2e2MX10VH3LtwI3Mx+DmAbV8eqrcEHZ5F8VTxsCXIjKa33UnkARqvu+jApktslc5W9NAn3fl0FIaM792CRh+VSTe9IsnQaQMPpoWNmmgX5tVG8OB2WSRCj3COphqAtXM0l+XLY8qE+XVraRlvTcWa+kEApIAomCpvYH/QBJzyqo2KIZNt2+2J0MDSsAioX/O+2tdCYOk+Og/v5hUc+G0uvO10YTtlib47+pBA7XO2+lEIPg7bSOxZl4uF52rT19haOySfc2WIu6/GahnD1lYMyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO4tnkbD8WI62s1KECvHKqg44Q4JsEJDsXpIi9+BCV4=;
 b=RiogK7Pv/opzYELL2l9pquUg9lsSMpGou3ieitAbCxale04QPCsdgfe0FtifZOBId7mw725NxZFuKEuXPd5XLUcxYpcOQ/Pzf+KEYRt8XO90zvXQd8EITxmCdU7QkKoXsf0iGo0WWOS8u2vFMHTkZmTAVauRQc5wgRj4wbyORp+1t0ZiH4Wdhkvv4Sjm+8X1pNa1mUxbKBdeunT0onZwTSPLOcgd27A0C6W+2ZyC7lzoAoLxSeDtz9mOOR1JeqnKtS/lQUEObrq3zUFnzzaC+/ntLUJ/YVDA42/3iSNCIYFK8b1zczA3T61mTO2U6hTiSFe5A8DCb4X1m7US8dC0Ug==
Received: from MN2PR22CA0006.namprd22.prod.outlook.com (2603:10b6:208:238::11)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 22:15:14 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::f8) by MN2PR22CA0006.outlook.office365.com
 (2603:10b6:208:238::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Thu,
 12 Dec 2024 22:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:15:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:15:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:14:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 05/10] net/mlx5: HWS, no need to expose mlx5hws_send_queues_open/close
Date: Fri, 13 Dec 2024 00:13:24 +0200
Message-ID: <20241212221329.961628-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d46576c-616f-4344-7e32-08dd1afa73a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y9ICGasmwiZeYCNAVAn/leqpRDznRef6978VosasWgb8Zun9E0RmvjmEfTFp?=
 =?us-ascii?Q?K4Tr3n1YlQFtj+EbovzHa9AOtpgBWLh+41yvTtLG2T9OCocJZ7tPbXEKwO6R?=
 =?us-ascii?Q?1AOUocxrX+PNK4zNUXC5YkutoltSdJ1kXSAOe82o7wAPrLkCs8A6GUO4ifFM?=
 =?us-ascii?Q?Sa5fMfwkQqT9Nsr3jmptyTI+aKZjj+fA6iFaA2RrqnW7/kN4cjFD/a9r2CRp?=
 =?us-ascii?Q?Td/f9keJwxFla7uoAl336NvkeyQB04s89JwEKQsqJGJiQVayPvWwuh/vG6vu?=
 =?us-ascii?Q?VfnMtAo49wrs6h01YwLxGA0/nvgfKQiktMnAmqUK6tID1TTAcw+UPSw04/qB?=
 =?us-ascii?Q?1JbOVoi28HLVMM3BhhVjZjzKzSmdW/87m+LxDrauVPz9gEKLs6DHOPR0cuYn?=
 =?us-ascii?Q?c6+2m0KB5hLRsKeip18pRz5A9mAgmPeX4DHTJFsA/XXChc6l4Qw9tdXbksh0?=
 =?us-ascii?Q?LSFoLawMUpGXT1CqiRFmRkrs4FQDaIpaGHb8B3b77uCWTuqzqCI8Ljup1NsG?=
 =?us-ascii?Q?GO3rI4ikHRa12Mx4PLUQxDgDeD7A9vvMpZdVpva+0Ldaj85UzlyWjtSPpszM?=
 =?us-ascii?Q?i6YHu0NHDrkWKGXuCISmz4+L1zsZuvuoEQ+3iaqaAUkg5E4JKJ7dsKZShiSg?=
 =?us-ascii?Q?JgEUQJmqqmAXWJryKPkafexPXJ7uCuEFzRfpwUIKHnb640UWn66KlgUvhUqm?=
 =?us-ascii?Q?viJhLrqCt6ZHB+dFx/KBxnjk81zyozWarN8GhiYsMDq0KSQGdwUzVRbqT17K?=
 =?us-ascii?Q?fmfejMw6XPH7WofNARbjsG0xkOk9IMT/ivQi8bmVMtBn4Wmas62QU+jv8lKa?=
 =?us-ascii?Q?/OwRI2Iq3C0ier6cCJf/OjnuIOhp8br2jJ9he/8KImO5wT2pcM272nK7fX/p?=
 =?us-ascii?Q?yk5HSv7JpD3sTRiedsf3QCohiuMA1vTUR2tNsVATwddAKJyEHOHq9e/xqsfA?=
 =?us-ascii?Q?FQ4JnEB+/CF/h727jeH/iO6pGUd1R08wFs3Q8oyfqEgoZpGJKj8kTw+eoCp+?=
 =?us-ascii?Q?C1GRjYjuw8GugZY35Rvdace0fLT/pWqT2MaDaaCL/oEmUR5JLt5WkzAgQLF9?=
 =?us-ascii?Q?gOSY6N4xco11y1JLpImPF7udAAvxqP5IcwSWdf7tiJta85f6Ad26xQp1ZWO0?=
 =?us-ascii?Q?molz5dfcFqRqwby0anuEzs5er13XUF+6srvkF94q3dhmT0d2y1wFoiT0/zR3?=
 =?us-ascii?Q?ZubXFTUFpDO2ig3nbfcjYhR0iDeWikX3J91whSAvPQcm+vyzbQjSXjSUZpBQ?=
 =?us-ascii?Q?ThOwKJpWz8ZTgT5gEhstD36F6EbPUplZD5aYcUtJy5ZLTyNH0F3/gBNln/AM?=
 =?us-ascii?Q?HKr5tKPiqC03a7xZhRpYSgC+wC3kYNbLOSFvR1d7inOtf31F9njNjLN4EkH9?=
 =?us-ascii?Q?SBhd2WMqGm/TuwE/lerDFiEcl1lDc5zawS6A9mgwTzH9Lyk4EBT3Vhnsv1LN?=
 =?us-ascii?Q?zyPGi327Sr2rgXkO8fhrW4E0cmiUZrdr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:13.8803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d46576c-616f-4344-7e32-08dd1afa73a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

No need to have mlx5hws_send_queues_open/close in header.
Make them static and remove from header.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/steering/hws/send.c  | 12 ++++++------
 .../ethernet/mellanox/mlx5/core/steering/hws/send.h  |  6 ------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 883b4ed30892..a93da4f71646 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -896,15 +896,15 @@ static int mlx5hws_send_ring_open(struct mlx5hws_context *ctx,
 	return err;
 }
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue)
+static void hws_send_queue_close(struct mlx5hws_send_engine *queue)
 {
 	hws_send_ring_close(queue);
 	kfree(queue->completed.entries);
 }
 
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size)
+static int hws_send_queue_open(struct mlx5hws_context *ctx,
+			       struct mlx5hws_send_engine *queue,
+			       u16 queue_size)
 {
 	int err;
 
@@ -936,7 +936,7 @@ int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
 static void __hws_send_queues_close(struct mlx5hws_context *ctx, u16 queues)
 {
 	while (queues--)
-		mlx5hws_send_queue_close(&ctx->send_queue[queues]);
+		hws_send_queue_close(&ctx->send_queue[queues]);
 }
 
 static void hws_send_queues_bwc_locks_destroy(struct mlx5hws_context *ctx)
@@ -1022,7 +1022,7 @@ int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
 	}
 
 	for (i = 0; i < ctx->queues; i++) {
-		err = mlx5hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
+		err = hws_send_queue_open(ctx, &ctx->send_queue[i], queue_size);
 		if (err)
 			goto close_send_queues;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
index b50825d6dc53..f833092235c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
@@ -189,12 +189,6 @@ void mlx5hws_send_abort_new_dep_wqe(struct mlx5hws_send_engine *queue);
 
 void mlx5hws_send_all_dep_wqe(struct mlx5hws_send_engine *queue);
 
-void mlx5hws_send_queue_close(struct mlx5hws_send_engine *queue);
-
-int mlx5hws_send_queue_open(struct mlx5hws_context *ctx,
-			    struct mlx5hws_send_engine *queue,
-			    u16 queue_size);
-
 void mlx5hws_send_queues_close(struct mlx5hws_context *ctx);
 
 int mlx5hws_send_queues_open(struct mlx5hws_context *ctx,
-- 
2.44.0


